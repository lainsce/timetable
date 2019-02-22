namespace Timetable.FileManager {
    public MainWindow win;
    public File file;
    public string buffer_text;

    public void open_tt (MainWindow win) {
        debug ("Open button pressed.");
        var file = Dialog.display_open_dialog ();
        string file_path = file.get_path ();
        string text;
        try {
            GLib.FileUtils.get_contents (file_path, out text);
        } catch (Error err) {
            print ("Error writing file: " + err.message);
        }

        Regex r = /\* (?P<day_header>[A-Za-z]*)\n/;
        Regex r2 = /\t\- (?P<task_name>[a-zA-Z0-9…]*)\n\t\<(?P<from_time_a>\d*)\:(?P<from_time_b>\d*) - (?P<to_time_a>\d*)\:(?P<to_time_b>\d*)\>/;

        MatchInfo info;
        MatchInfo info2;

        debug ("Opening file...");
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
                new_tt (win);
                for (r.match (text, 0, out info) ; info.matches () ; info.next ()) {
                    if (info.fetch_named("day_header") == "Monday") {
                        for (r2.match (text, 0, out info2) ; info2.matches () ; info2.next ()) {
                            win.monday_column.add_task (info2.fetch_named("task_name"), "#d4d4d4", info2.fetch_named("from_time_a") + ":" + info2.fetch_named("from_time_b"), info2.fetch_named("to_time_a") + ":" + info2.fetch_named("to_time_b"), false);
                        }
                    }
                    if (info.fetch_named("day_header") == "Tuesday") {
                        for (r2.match (text, 0, out info2) ; info2.matches () ; info2.next ()) {
                            win.tuesday_column.add_task (info2.fetch_named("task_name"), "#d4d4d4", info2.fetch_named("from_time_a") + ":" + info2.fetch_named("from_time_b"), info2.fetch_named("to_time_a") + ":" + info2.fetch_named("to_time_b"), false);
                        }
                    }
                    if (info.fetch_named("day_header") == "Wednesday") {
                        for (r2.match (text, 0, out info2) ; info2.matches () ; info2.next ()) {
                            win.wednesday_column.add_task (info2.fetch_named("task_name"), "#d4d4d4", info2.fetch_named("from_time_a") + ":" + info2.fetch_named("from_time_b"), info2.fetch_named("to_time_a") + ":" + info2.fetch_named("to_time_b"), false);
                        }
                    }
                    if (info.fetch_named("day_header") == "Thursday") {
                        for (r2.match (text, 0, out info2) ; info2.matches () ; info2.next ()) {
                            win.thursday_column.add_task (info2.fetch_named("task_name"), "#d4d4d4", info2.fetch_named("from_time_a") + ":" + info2.fetch_named("from_time_b"), info2.fetch_named("to_time_a") + ":" + info2.fetch_named("to_time_b"), false);
                        }
                    }
                    if (info.fetch_named("day_header") == "Friday") {
                        for (r2.match (text, 0, out info2) ; info2.matches () ; info2.next ()) {
                            win.friday_column.add_task (info2.fetch_named("task_name"), "#d4d4d4", info2.fetch_named("from_time_a") + ":" + info2.fetch_named("from_time_b"), info2.fetch_named("to_time_a") + ":" + info2.fetch_named("to_time_b"), false);
                        }
                    }
                    if (info.fetch_named("day_header") == "Saturday") {
                        for (r2.match (text, 0, out info2) ; info2.matches () ; info2.next ()) {
                            win.saturday_column.add_task (info2.fetch_named("task_name"), "#d4d4d4", info2.fetch_named("from_time_a") + ":" + info2.fetch_named("from_time_b"), info2.fetch_named("to_time_a") + ":" + info2.fetch_named("to_time_b"), false);
                        }
                    }
                    if (info.fetch_named("day_header") == "Sunday") {
                        for (r2.match (text, 0, out info2) ; info2.matches () ; info2.next ()) {
                            win.sunday_column.add_task (info2.fetch_named("task_name"), "#d4d4d4", info2.fetch_named("from_time_a") + ":" + info2.fetch_named("from_time_b"), info2.fetch_named("to_time_a") + ":" + info2.fetch_named("to_time_b"), false);
                        }
                    }
                }
            } else {
                reset_columns_state (win);
                for (r.match (text, 0, out info) ; info.matches () ; info.next ()) {
                    if (info.fetch_named("day_header") == "Monday") {
                        for (r2.match (text, 0, out info2) ; info2.matches () ; info2.next ()) {
                            win.monday_column.add_task (info2.fetch_named("task_name"), "#d4d4d4", info2.fetch_named("from_time_a") + ":" + info2.fetch_named("from_time_b"), info2.fetch_named("to_time_a") + ":" + info2.fetch_named("to_time_b"), false);
                        }
                    }
                    if (info.fetch_named("day_header") == "Tuesday") {
                        for (r2.match (text, 0, out info2) ; info2.matches () ; info2.next ()) {
                            win.tuesday_column.add_task (info2.fetch_named("task_name"), "#d4d4d4", info2.fetch_named("from_time_a") + ":" + info2.fetch_named("from_time_b"), info2.fetch_named("to_time_a") + ":" + info2.fetch_named("to_time_b"), false);
                        }
                    }
                    if (info.fetch_named("day_header") == "Wednesday") {
                        for (r2.match (text, 0, out info2) ; info2.matches () ; info2.next ()) {
                            win.wednesday_column.add_task (info2.fetch_named("task_name"), "#d4d4d4", info2.fetch_named("from_time_a") + ":" + info2.fetch_named("from_time_b"), info2.fetch_named("to_time_a") + ":" + info2.fetch_named("to_time_b"), false);
                        }
                    }
                    if (info.fetch_named("day_header") == "Thursday") {
                        for (r2.match (text, 0, out info2) ; info2.matches () ; info2.next ()) {
                            win.thursday_column.add_task (info2.fetch_named("task_name"), "#d4d4d4", info2.fetch_named("from_time_a") + ":" + info2.fetch_named("from_time_b"), info2.fetch_named("to_time_a") + ":" + info2.fetch_named("to_time_b"), false);
                        }
                    }
                    if (info.fetch_named("day_header") == "Friday") {
                        for (r2.match (text, 0, out info2) ; info2.matches () ; info2.next ()) {
                            win.friday_column.add_task (info2.fetch_named("task_name"), "#d4d4d4", info2.fetch_named("from_time_a") + ":" + info2.fetch_named("from_time_b"), info2.fetch_named("to_time_a") + ":" + info2.fetch_named("to_time_b"), false);
                        }
                    }
                    if (info.fetch_named("day_header") == "Saturday") {
                        for (r2.match (text, 0, out info2) ; info2.matches () ; info2.next ()) {
                            win.saturday_column.add_task (info2.fetch_named("task_name"), "#d4d4d4", info2.fetch_named("from_time_a") + ":" + info2.fetch_named("from_time_b"), info2.fetch_named("to_time_a") + ":" + info2.fetch_named("to_time_b"), false);
                        }
                    }
                    if (info.fetch_named("day_header") == "Sunday") {
                        for (r2.match (text, 0, out info2) ; info2.matches () ; info2.next ()) {
                            win.sunday_column.add_task (info2.fetch_named("task_name"), "#d4d4d4", info2.fetch_named("from_time_a") + ":" + info2.fetch_named("from_time_b"), info2.fetch_named("to_time_a") + ":" + info2.fetch_named("to_time_b"), false);
                        }
                    }
                }
            }
        }
        reset_modification_state (win);
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
            task_string += "\t- " + task.task_name + "\n\t<" + task.time_from_text + " - " + task.time_to_text + ">\n";
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
