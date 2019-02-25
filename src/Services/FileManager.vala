namespace Timetable.FileManager {
    public MainWindow win;
    public File file;
    public string buffer_text;

    public class Task : Object {
        public string desc { get; set; }
        public string from_hour { get; set; }
        public string to_hour { get; set; }
        public string color { get; set; }
    }

    class TaskDay : Object {
        public string day_header { get; set; }
        public Gee.ArrayList<Task> tasks { get; construct; }

        construct {
            tasks = new Gee.ArrayList<Task> ();
        }

        public void add_task (Task task) {
            tasks.add (task);
        }
    }

    public void open_tt (MainWindow win) {
        debug ("Open button pressed.");
        var file = Dialog.display_open_dialog ();
        string file_path = file.get_path ();
        string text;
        try {
            GLib.FileUtils.get_contents (file_path, out text);
        } catch (Error err) {
            print (err.message);
        }

        var days = new Gee.ArrayList<TaskDay> ();
        TaskDay? current = null;

        var curtask = new Task ();

        int i = 0;
        string[] tokens = text.split ("\n");
        foreach (string line in tokens) {
            line = line.strip ();
            if (line.has_prefix ("*")) {
                string day_header = line.replace ("*", "").strip ();

                current = new TaskDay ();
                current.day_header = day_header;
                days.add (current);
            } else if (line.has_prefix ("-")) {
                curtask.desc = read_desc (tokens, i).strip ().substring (1).strip ();
            } else if (line.has_prefix ("<")) {
                string from, to;
                read_hours (line, out from, out to);
                curtask.from_hour = from;
                curtask.to_hour = to;
            } else if (line.has_prefix (":")) {
                curtask.color = line.replace (":", "").strip ();
                current.add_task (curtask);
                curtask = new Task ();
            }

            i++;
        }

        if (win.monday_column.is_modified == true ||
            win.tuesday_column.is_modified == true ||
            win.wednesday_column.is_modified == true ||
            win.thursday_column.is_modified == true ||
            win.friday_column.is_modified == true ||
            win.saturday_column.is_modified == true ||
            win.sunday_column.is_modified == true) {
                new_tt (win);
            }

        foreach (var day in days) {
            var column = get_column_by_header (win, day.day_header);
            foreach (var task in day.tasks) {
                column.add_task (task.desc, task.color, task.from_hour, task.to_hour, false);
            }
        }
    }

    private static DayColumn get_column_by_header (MainWindow win, string header) {
        switch (header) {
            case "Tuesday": return win.tuesday_column;
            case "Wednesday": return win.wednesday_column;
            case "Thursday": return win.thursday_column;
            case "Friday": return win.friday_column;
            case "Saturday": return win.saturday_column;
            case "Sunday": return win.sunday_column;
        }

        return win.monday_column;
    }

    public static void read_hours (string line, out string from, out string to) {
        string[] s = line.split ("-");
        if (s.length < 2) {
            from = to = "";
            return;
        }

        from = s[0].strip ().substring (1, 5);
        to = s[1].strip ().substring (0, 5);
    }

    public static string read_desc (string[] tokens, int line) {
        string desc = "";
        while (line < tokens.length && !tokens[line].strip ().has_prefix ("<")) {
            desc += tokens[line];
            line++;
        }

        return desc;
    }

    public void new_tt (MainWindow win) {
        debug ("New button pressed.");
        var dialog = new Dialog.Dialog ();
        dialog.transient_for = win;

        dialog.response.connect ((response_id) => {
            switch (response_id) {
                case Gtk.ResponseType.OK:
                    debug ("User saves.");
                    try {
                        save_as (win);
                    } catch (Error err) {
                        print ("Error writing file: " + err.message);
                    }
                    reset_columns_state (win);
                    dialog.close ();
                    break;
                case Gtk.ResponseType.NO:
                    debug ("User doesn't care, shoot it to space.");
                    reset_columns_state (win);
                    reset_modification_state (win);
                    dialog.close ();
                    break;
                case Gtk.ResponseType.CANCEL:
                case Gtk.ResponseType.CLOSE:
                case Gtk.ResponseType.DELETE_EVENT:
                    dialog.close ();
                    break;
                default:
                    assert_not_reached ();
            }
        });


        if (win.monday_column.is_modified == true ||
            win.tuesday_column.is_modified == true ||
            win.wednesday_column.is_modified == true ||
            win.thursday_column.is_modified == true ||
            win.friday_column.is_modified == true ||
            win.saturday_column.is_modified == true ||
            win.sunday_column.is_modified == true) {
            dialog.run ();
        }
    }

    public void save_file (string path, string text) throws Error {
        try {
            GLib.FileUtils.set_contents (path, text);
        } catch (Error err) {
            print ("Error writing file: " + err.message);
        }
    }

    public void save_as (MainWindow win) throws Error {
        string buffer_text = "";
        debug ("Save as button pressed.");
        var file = Dialog.display_save_dialog ();

        try {
            debug ("Saving file…");
            if (file == null) {
                debug ("User cancelled operation. Aborting.");
            } else {
                if (win.monday_column.is_modified == true ||
                    win.tuesday_column.is_modified == true ||
                    win.wednesday_column.is_modified == true ||
                    win.thursday_column.is_modified == true ||
                    win.friday_column.is_modified == true ||
                    win.saturday_column.is_modified == true ||
                    win.sunday_column.is_modified == true) {
                    buffer_text += "* Monday\n";
                    buffer_text += get_column_tasks (win.monday_column);
                    buffer_text += "* Tuesday\n";
                    buffer_text += get_column_tasks (win.tuesday_column);
                    buffer_text += "* Wednesday\n";
                    buffer_text += get_column_tasks (win.wednesday_column);
                    buffer_text += "* Thursday\n";
                    buffer_text += get_column_tasks (win.thursday_column);
                    buffer_text += "* Friday\n";
                    buffer_text += get_column_tasks (win.friday_column);
                    buffer_text += "* Saturday\n";
                    buffer_text += get_column_tasks (win.saturday_column);
                    buffer_text += "* Sunday\n";
                    buffer_text += get_column_tasks (win.sunday_column);
                    var buffer = buffer_text;

                    if (!file.get_basename ().down ().has_suffix (".org")) {
                        var file_final = File.new_for_path (file.get_path () + ".org");
                        string file_path_final = file_final.get_path ();
                        save_file (file_path_final, buffer);
                    }
                    reset_modification_state (win);
                }
            }
        } catch (Error e) {
            warning ("Unexpected error during save: " + e.message);
        }

        file = null;
    }

    public string get_column_tasks (DayColumn column) {
        string task_string = "";
        foreach (var task in column.get_tasks ()) {
            task_string += "\t- " + task.task_name + "\n\t<" + task.time_from_text + " - " + task.time_to_text + ">\n\t:" + task.color + "\n";
        }
        return task_string;
    }

    public void reset_modification_state (MainWindow win) {
        win.monday_column.is_modified = false;
        win.tuesday_column.is_modified = false;
        win.wednesday_column.is_modified = false;
        win.thursday_column.is_modified = false;
        win.friday_column.is_modified = false;
        win.saturday_column.is_modified = false;
        win.sunday_column.is_modified = false;
    }

    public void reset_columns_state (MainWindow win) {
        win.monday_column.clear_column ();
        win.tuesday_column.clear_column ();
        win.wednesday_column.clear_column ();
        win.thursday_column.clear_column ();
        win.friday_column.clear_column ();
        win.saturday_column.clear_column ();
        win.sunday_column.clear_column ();
    }
}
