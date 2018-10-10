namespace Timetable {
    public class DayColumn : Gtk.Grid {
        public Gtk.ListBox column;

        public DayColumn (string day) {
            column = new Gtk.ListBox ();
            column.hexpand = true;
            column.vexpand = true;
            column.activate_on_single_click = false;
            column.selection_mode = Gtk.SelectionMode.NONE;
            var column_style_context = column.get_style_context ();
            column_style_context.add_class ("tt-column");

            var column_label = new Gtk.Label (day);
            column_label.halign = Gtk.Align.START;
            var column_label_style_context = column_label.get_style_context ();
            column_label_style_context.add_class ("tt-label");

            var no_tasks = new Gtk.Label (_("No tasks."));
            no_tasks.halign = Gtk.Align.CENTER;
            var no_tasks_style_context = no_tasks.get_style_context ();
            no_tasks_style_context.add_class ("h2");
            no_tasks.sensitive = false;
            no_tasks.margin = 12;
            no_tasks.show_all ();
            column.set_placeholder (no_tasks);

            var column_button = new Gtk.Button ();
            column_button.can_focus = false;
            column_button.halign = Gtk.Align.END;
            var column_button_style_context = column_button.get_style_context ();
            column_button_style_context.add_class ("tt-button");
            column_button_style_context.add_class ("image-button");
            column_button.set_image (new Gtk.Image.from_icon_name ("list-add-symbolic", Gtk.IconSize.LARGE_TOOLBAR));

            column_button.clicked.connect (() => {
                var taskbox = new TaskBox ();
                column.insert (taskbox, -1);
            });

            this.row_spacing = 6;
            this.attach (column_label, 0, 0, 1, 1);
            this.attach (column, 0, 1, 2, 1);
            this.attach (column_button, 1, 0, 1, 1);

            this.show_all ();
        }
    }
}
