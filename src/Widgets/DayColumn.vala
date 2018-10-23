namespace Timetable {
    public class DayColumn : Gtk.Grid {
        public MainWindow win;
        public Gtk.ListBox column;
        public string day_header;
        public int day;
        public bool is_modified {get; set; default = false;}

        public DayColumn (int day, MainWindow win) {
            this.win = win;
            this.set_size_request (180,-1);
            is_modified = false;
            column = new Gtk.ListBox ();
            column.hexpand = true;
            column.vexpand = true;
            column.activate_on_single_click = false;
            column.selection_mode = Gtk.SelectionMode.NONE;
            column.set_sort_func (list_sort);
            var column_style_context = column.get_style_context ();
            column_style_context.add_class ("tt-column");

            var time = new GLib.DateTime.now_local ();

            switch (day) {
                case 1:
                    if (time.get_day_of_week () == day) {
                        day_header = _("◉ MON");
                    } else {
                        day_header = _("MON");
                    }
                    break;
                case 2:
                    if (time.get_day_of_week () == day) {
                        day_header = _("◉ TUE");
                    } else {
                        day_header = _("TUE");
                    }
                    break;
                case 3:
                    if (time.get_day_of_week () == day) {
                        day_header = _("◉ WED");
                    } else {
                        day_header = _("WED");
                    }
                    break;
                case 4:
                    if (time.get_day_of_week () == day) {
                        day_header = _("◉ THU");
                    } else {
                        day_header = _("THU");
                    }
                    break;
                case 5:
                    if (time.get_day_of_week () == day) {
                        day_header = _("◉ FRI");
                    } else {
                        day_header = _("FRI");
                    }
                    break;
                case 6:
                    if (time.get_day_of_week () == day || time.get_day_of_week () == 7) {
                        day_header = _("◉ SAT/SUN");
                    } else {
                        day_header = _("SAT/SUN");
                    }
                    break;
            }

            var column_label = new Gtk.Label (day_header);
            column_label.halign = Gtk.Align.START;
            var column_label_style_context = column_label.get_style_context ();
            column_label_style_context.add_class ("tt-label");

            var no_tasks = new Gtk.Label (_("No tasks…"));
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
            column_button.width_request = 38;
            column_button.height_request = 32;
            var column_button_style_context = column_button.get_style_context ();
            column_button_style_context.add_class ("tt-button");
            column_button_style_context.add_class ("image-button");
            column_button.set_image (new Gtk.Image.from_icon_name ("list-add-symbolic", Gtk.IconSize.LARGE_TOOLBAR));

            column_button.clicked.connect (() => {
                add_task (_("Task…"), "#EEEEEE", "12:00", "12:00", false, false);
            });

            this.row_spacing = 6;
            this.attach (column_label, 0, 0, 1, 1);
            this.attach (column, 0, 1, 2, 1);
            this.attach (column_button, 1, 0, 1, 1);

            this.show_all ();
        }

        public void add_task (string name, string color, string time_from_text, string time_to_text, bool task_allday, bool task_notify) {
            var taskbox = new TaskBox (this.win, name, color, time_from_text, time_to_text, task_allday, task_notify);
            taskbox.update_theme ();
            column.insert (taskbox, -1);
            win.tm.save_notes ();
            is_modified = true;
        }

        public void clear_column () {
            foreach (Gtk.Widget item in column.get_children ()) {
                item.destroy ();
            }
            win.tm.save_notes ();
        }

        public Gee.ArrayList<TaskBox> get_tasks () {
            var tasks = new Gee.ArrayList<TaskBox> ();
            foreach (Gtk.Widget item in column.get_children ()) {
	            tasks.add ((TaskBox)item);
            }
            return tasks;
        }

        public int list_sort (Gtk.ListBoxRow first_row, Gtk.ListBoxRow second_row) {
            var row_1 = (TaskBox) first_row;
            var row_2 = (TaskBox) second_row;

            string name_1 = row_1.time_from_text;
            string name_2 = row_2.time_from_text;

            return name_1.collate (name_2);
        }

    }
}
