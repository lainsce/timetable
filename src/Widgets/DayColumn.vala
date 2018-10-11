namespace Timetable {
    public class DayColumn : Gtk.Grid {
        public Gtk.ListBox column;
        public string day_header;
        public int day;
        public Gee.LinkedList<TaskBox> tasks;
        public bool is_modified {get; set; default = false;}
        public bool task_removed {get; set; default = false;}

        public DayColumn (int day) {
            column = new Gtk.ListBox ();
            column.hexpand = true;
            column.vexpand = true;
            column.activate_on_single_click = false;
            column.selection_mode = Gtk.SelectionMode.NONE;
            var column_style_context = column.get_style_context ();
            column_style_context.add_class ("tt-column");

            switch (day) {
                case 0:
                    day_header = _("MON");
                    break;
                case 1:
                    day_header = _("TUE");
                    break;
                case 2:
                    day_header = _("WED");
                    break;
                case 3:
                    day_header = _("THU");
                    break;
                case 4:
                    day_header = _("FRI");
                    break;
            }

            var column_label = new Gtk.Label (day_header);
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

            is_modified = false;
            task_removed = false;
            tasks = new Gee.LinkedList<TaskBox> ();

            column_button.clicked.connect (() => {
                var taskbox = new TaskBox ();
                column.insert (taskbox, -1);
                tasks.add (taskbox);
                warning ("N° of tasks: " + tasks.size.to_string ());
                is_modified = true;
            });

            this.row_spacing = 6;
            this.attach (column_label, 0, 0, 1, 1);
            this.attach (column, 0, 1, 2, 1);
            this.attach (column_button, 1, 0, 1, 1);

            this.show_all ();
        }

        public void clear_column () {
            foreach (Gtk.Widget item in column.get_children ()) {
                item.destroy ();
            }
            tasks.clear ();
        }

        public void remove_task (TaskBox task) {
            if (task_removed) {
                tasks.remove (task);
            }
            warning ("N° of tasks: " + tasks.size.to_string ());
        }
    }
}
