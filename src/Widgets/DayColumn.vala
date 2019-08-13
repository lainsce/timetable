namespace Timetable {
    public class DayColumn : Gtk.Grid {
        private MainWindow win;
        private DayColumnListBox column;
        private string day_header;
        public bool is_modified {get; set; default = false;}

        public DayColumn (int day, MainWindow win) {
            this.win = win;
            this.set_size_request (180,-1);
            is_modified = false;
            column = new DayColumnListBox (day, win);

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
                    if (time.get_day_of_week () == day) {
                        day_header = _("◉ SAT");
                    } else {
                        day_header = _("SAT");
                    }
                    break;
                case 7:
                    if (time.get_day_of_week () == day) {
                        day_header = _("◉ SUN");
                    } else {
                        day_header = _("SUN");
                    }
                    break;
            }

            var column_label = new Gtk.Label (day_header);
            column_label.halign = Gtk.Align.START;
            var column_label_style_context = column_label.get_style_context ();
            column_label_style_context.add_class ("tt-label");

            var column_button = new Gtk.Button ();
            column_button.can_focus = false;
            column_button.halign = Gtk.Align.END;
            column_button.width_request = 40;
            column_button.height_request = 30;
            var column_button_style_context = column_button.get_style_context ();
            column_button_style_context.add_class ("tt-button");
            column_button_style_context.add_class ("image-button");
            column_button.set_image (new Gtk.Image.from_icon_name ("list-add-symbolic", Gtk.IconSize.SMALL_TOOLBAR));

            column_button.clicked.connect (() => {
                add_task (_("Task…"), "#d4d4d4", "12:00", "12:00", false);
            });

            this.row_spacing = 6;
            this.attach (column_label, 0, 0, 2, 1);
            this.attach (column_button, 1, 0, 2, 1);
            this.attach (column, 0, 1, 2, 1);

            this.show_all ();
        }

        public void add_task (string name, string color, string time_from_text, string time_to_text, bool task_allday) {
            var taskbox = new TaskBox (this.win, name, color, time_from_text, time_to_text, task_allday);
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
    }
}
