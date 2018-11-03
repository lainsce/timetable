namespace Timetable {
    public class DayColumn : Gtk.Grid {
        public MainWindow win;
        public Gtk.ListBox column;
        public string day_header;
        public int day;
        public bool is_modified {get; set; default = false;}

        private const Gtk.TargetEntry[] dlb_entries = {
            {"DRAG_LIST_ROW", Gtk.TargetFlags.SAME_APP, 0}
        };

        public DayColumn (int day, MainWindow win) {
            this.win = win;
            this.set_size_request (180,-1);
            is_modified = false;
            column = new Gtk.ListBox ();
            column.hexpand = true;
            column.vexpand = true;
            column.activate_on_single_click = false;
            column.selection_mode = Gtk.SelectionMode.BROWSE;
            column.set_sort_func ((row1, row2) => {
                string task1 = ((TaskBox) row1).time_from_text;
                string task2 = ((TaskBox) row2).time_from_text;

                int int1 = int.parse(task1);
                int int2 = int.parse(task2);

                unichar str1 = task1.get_char (task1.index_of_nth_char (0));
                unichar str2 = task2.get_char (task2.index_of_nth_char (0));

                if (str1.tolower () != 'a' || str2.tolower () != 'a') {
                    return strcmp (task1.ascii_down (), task2.ascii_down ());
                } else if (int1 > int2) {
                    return task1.ascii_down ().collate (task2.ascii_down ());
                } else {
                    return 0;
                }
            });

            Gtk.drag_dest_set (
                column, Gtk.DestDefaults.ALL, dlb_entries, Gdk.DragAction.MOVE
            );

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
            column_button.width_request = 40;
            column_button.height_request = 30;
            var column_button_style_context = column_button.get_style_context ();
            column_button_style_context.add_class ("tt-button");
            column_button_style_context.add_class ("image-button");
            column_button.set_image (new Gtk.Image.from_icon_name ("list-add-symbolic", Gtk.IconSize.SMALL_TOOLBAR));

            column_button.clicked.connect (() => {
                add_task (_("Task…"), "#d4d4d4", "12:00", "12:00", false, false);
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
    }
}
