namespace Timetable.FileManager {
    public MainWindow win;
    public File file;

    public void open_tt (MainWindow win) {
        debug ("Open button pressed.");
        var dialog = new Dialog (win);
        dialog.response.connect ((response_id) => {
            switch (response_id) {
                case Gtk.ResponseType.YES:
                    debug ("User opens the file.");
                    // TODO: Find how to read the file and display it.
                    break;
                case Gtk.ResponseType.NO:
                    debug ("User doesn't care about the file.");
                    break;
                case Gtk.ResponseType.CANCEL:
                    debug ("User cancelled, don't do anything.");
                    break;
                case Gtk.ResponseType.DELETE_EVENT:
                    debug ("User cancelled, don't do anything.");
                    break;
            }
            dialog.destroy();
        });

        dialog.show_all ();
    }

    public void new_tt (MainWindow win) {
        debug ("New button pressed.");
        var dialog = new Dialog (win);
        dialog.response.connect ((response_id) => {
            switch (response_id) {
                case Gtk.ResponseType.YES:
                    debug ("User saves the file.");
                    try {
                        save_as (win);
                        win.monday_column.clear_column ();
                        win.tuesday_column.clear_column ();
                        win.wednesday_column.clear_column ();
                        win.thursday_column.clear_column ();
                        win.friday_column.clear_column ();
                        win.saturday_column.clear_column ();
                        win.sunday_column.clear_column ();
                    } catch (Error e) {
                        warning ("Unexpected error during save: " + e.message);
                    }
                    break;
                case Gtk.ResponseType.NO:
                    debug ("User doesn't care about the file.");
                    win.monday_column.clear_column ();
                    win.tuesday_column.clear_column ();
                    win.wednesday_column.clear_column ();
                    win.thursday_column.clear_column ();
                    win.friday_column.clear_column ();
                    win.saturday_column.clear_column ();
                    win.sunday_column.clear_column ();
                    reset_modification_state (win);
                    break;
                case Gtk.ResponseType.CANCEL:
                    debug ("User cancelled, don't do anything.");
                    break;
                case Gtk.ResponseType.DELETE_EVENT:
                    debug ("User cancelled, don't do anything.");
                    break;
            }
            dialog.destroy();
        });

        if (win.monday_column.is_modified == true ||
            win.tuesday_column.is_modified == true ||
            win.wednesday_column.is_modified == true ||
            win.thursday_column.is_modified == true ||
            win.friday_column.is_modified == true ||
            win.saturday_column.is_modified == true ||
            win.sunday_column.is_modified == true) {
            debug ("Buffer was modified. Asking user to save first.");
            dialog.show_all ();
        } else {
            debug ("Buffer was not modified. Aborting.");
        }
    }

    public void save_file (File file, uint8[] buffer) throws Error {
        var output = new DataOutputStream (
                                file.create(
                                    FileCreateFlags.REPLACE_DESTINATION
                                )
                         );
        long written = 0;
        while (written < buffer.length)
            written += output.write (buffer[written:buffer.length]);
    }

    public void save_as (MainWindow win) throws Error {
        debug ("Save as button pressed.");
        var dialog = new Dialog (win);
        var file = dialog.display_save_dialog ();

        try {
            debug ("Saving file…");
            if (file == null) {
                debug ("User cancelled operation. Aborting.");
            } else {
                if (file.query_exists ()) {
                    file.delete ();
                }

                if (win.monday_column.is_modified == true ||
                    win.tuesday_column.is_modified == true ||
                    win.wednesday_column.is_modified == true ||
                    win.thursday_column.is_modified == true ||
                    win.friday_column.is_modified == true ||
                    win.saturday_column.is_modified == true ||
                    win.sunday_column.is_modified == true) {
                    string buffer_text = "";
                    buffer_text += "* Monday\n";
                    foreach (var task in win.monday_column.get_tasks ()) {
                        buffer_text += "\t- " +
                                       task.task_name +
                                       "\n\t<" +
                                       task.time_from_text +
                                       " - " +
                                       task.time_to_text +
                                       ">\n";
                    }
                    buffer_text += "* Tuesday\n";
                    foreach (var task in win.tuesday_column.get_tasks ()) {
                        buffer_text += "\t- " +
                                       task.task_name +
                                       "\n\t<" +
                                       task.time_from_text +
                                       " - " +
                                       task.time_to_text +
                                       ">\n";
                    }
                    buffer_text += "* Wednesday\n";
                    foreach (var task in win.wednesday_column.get_tasks ()) {
                        buffer_text += "\t- " +
                                       task.task_name +
                                       "\n\t<" +
                                       task.time_from_text +
                                       " - " +
                                       task.time_to_text +
                                       ">\n";
                    }
                    buffer_text += "* Thursday\n";
                    foreach (var task in win.thursday_column.get_tasks ()) {
                        buffer_text += "\t- " +
                                       task.task_name +
                                       "\n\t<" +
                                       task.time_from_text +
                                       " - " +
                                       task.time_to_text +
                                       ">\n";
                    }
                    buffer_text += "* Friday\n";
                    foreach (var task in win.friday_column.get_tasks ()) {
                        buffer_text += "\t- " +
                                       task.task_name +
                                       "\n\t<" +
                                       task.time_from_text +
                                       " - " +
                                       task.time_to_text +
                                       ">\n";
                    }
                    buffer_text += "* Saturday\n";
                    foreach (var task in win.saturday_column.get_tasks ()) {
                        buffer_text += "\t- " +
                                       task.task_name +
                                       "\n\t<" +
                                       task.time_from_text +
                                       " - " +
                                       task.time_to_text +
                                       ">\n";
                    }
                    buffer_text += "* Sunday\n";
                    foreach (var task in win.sunday_column.get_tasks ()) {
                        buffer_text += "\t- " +
                                       task.task_name +
                                       "\n\t<" +
                                       task.time_from_text +
                                       " - " +
                                       task.time_to_text +
                                       ">\n";
                    }
                    var buffer = buffer_text;
                    uint8[] binbuffer = buffer.data;
                    var file_final = File.new_for_path (file.get_path () +
                                                        ".org");
                    save_file (file_final, binbuffer);
                    reset_modification_state (win);
                }
            }
        } catch (Error e) {
            warning ("Unexpected error during save: " + e.message);
        }

        file = null;
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
}
