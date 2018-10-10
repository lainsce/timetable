namespace Timetable {
    public class DayColumn : Gtk.Grid {
        public MainWindow window;

        public DayColumn (string day) {
            var column = new Gtk.ListBox ();
            column.vexpand = true;
            var column_style_context = column.get_style_context ();
            column_style_context.add_class ("tt-column");
            var column_label = new Gtk.Label (day);
            column_label.halign = Gtk.Align.START;
            var column_label_style_context = column_label.get_style_context ();
            column_label_style_context.add_class ("tt-label");

            var column_button = new Gtk.Button ();
            var column_button_style_context = column_button.get_style_context ();
            column_button_style_context.add_class ("tt-button");
            column_button_style_context.add_class ("image-button");
            column_button.hexpand = true;
            column_button.set_image (new Gtk.Image.from_icon_name ("list-add-symbolic", Gtk.IconSize.DIALOG));
            column.add (column_button);

            var task_label = new EditableLabel (_("Task…"));
            var task_delete_button = new Gtk.Button ();
            var task_delete_button_style_context = task_delete_button.get_style_context ();
            task_delete_button_style_context.add_class ("image-button");
            task_delete_button.set_image (new Gtk.Image.from_icon_name ("edit-delete-symbolic", Gtk.IconSize.SMALL_TOOLBAR));

            var column_grid = new Gtk.Grid ();
            column_grid.hexpand = false;
            column_grid.add (task_label);
            column_grid.add (task_delete_button);
            column_grid.show_all ();

            column_button.clicked.connect (() => {
                column.remove (column_button);
                column.add (column_grid);
            });

            task_delete_button.clicked.connect (() => {
                column.remove (column_grid);
                column.add (column_button);
            });

            this.attach (column_label, 0, 0, 1, 1);
            this.attach (column, 0, 1, 1, 1);

            this.show_all ();
        }
    }
}
