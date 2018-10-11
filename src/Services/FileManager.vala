namespace Timetable.FileManager {
    public MainWindow win;
    public void new_tt (MainWindow win) {
        debug ("New button pressed.");
        debug ("Buffer was modified. Asking user to save first.");
        var dialog = new Dialog.display_save_confirm (win);
        dialog.response.connect ((response_id) => {
            switch (response_id) {
                case Gtk.ResponseType.YES:
                    debug ("User saves the file.");
                    //TODO: Save file
                    break;
                case Gtk.ResponseType.NO:
                    debug ("User doesn't care about the file.");
                    win.monday_column.clear_column ();
                    win.tuesday_column.clear_column ();
                    win.wednesday_column.clear_column ();
                    win.thursday_column.clear_column ();
                    win.friday_column.clear_column ();
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

        if (win.monday_column.is_modified == true || win.tuesday_column.is_modified == true || win.wednesday_column.is_modified == true || win.thursday_column.is_modified == true || win.friday_column.is_modified == true) {
            dialog.show ();
            win.monday_column.is_modified = false;
            win.tuesday_column.is_modified = false;
            win.wednesday_column.is_modified = false;
            win.thursday_column.is_modified = false;
            win.friday_column.is_modified = false;
        }
    }
}
