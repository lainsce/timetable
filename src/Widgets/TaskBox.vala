namespace Timetable {
    public class TaskBox : Gtk.ListBoxRow {
        public MainWindow win;
        public TaskPreferences dialog;
        public string task_name;
        public Gtk.Label task_label;
        public Gtk.Label task_time_from_label;
        public Gtk.Label task_time_sep_label;
        public Gtk.Label task_time_to_label;
        public int uid;
        public static int uid_counter;
        public string color;
        public string tcolor;
        public string time_to_text;
        public string time_from_text;
        public bool task_allday;
        public bool task_notify;

        public TaskBox (MainWindow win, string task_name, string color, string time_from_text, string time_to_text, bool task_allday, bool task_notify) {
            var settings = AppSettings.get_default ();
            this.win = win;
            this.uid = uid_counter++;
            this.task_name = task_name;
            this.color = color;
            this.tcolor = color;
            this.time_to_text = time_to_text;
            this.time_from_text = time_from_text;
            this.task_allday = task_allday;
            this.task_notify = task_notify;

            change_theme ();
            update_theme ();
            win.tm.save_notes ();

            settings.changed.connect (() => {
                change_theme ();
                update_theme ();
                win.tm.save_notes ();
            });

            task_label = new Gtk.Label ("");
            task_label.margin_start = 6;
            task_label.halign = Gtk.Align.START;
            task_label.wrap = true;
            task_label.hexpand = true;
            task_label.label = this.task_name;

            task_time_from_label = new Gtk.Label ("");
            task_time_from_label.margin_start = 6;
            task_time_from_label.halign = Gtk.Align.START;
            task_time_from_label.label = this.time_from_text;

            task_time_to_label = new Gtk.Label ("");
            task_time_to_label.halign = Gtk.Align.START;
            task_time_to_label.label = this.time_to_text;

            task_time_sep_label = new Gtk.Label ("-");

            var date_time_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6);
            date_time_box.pack_start (task_time_from_label, false, true, 0);
            date_time_box.pack_start (task_time_sep_label, false, true, 0);
            date_time_box.pack_start (task_time_to_label, false, true, 0);

            var evbox = new TaskEventBox (this);

            var task_grid = new Gtk.Grid ();
            task_grid.hexpand = false;
            task_grid.row_spacing = 6;
            task_grid.margin_top = task_grid.margin_bottom = 12;
            task_grid.margin_start = task_grid.margin_end = 6;
            task_grid.attach (task_label, 0, 0, 1, 1);
            task_grid.attach (date_time_box, 0, 1, 1, 1);
            task_grid.attach (evbox, 1, 0, 1, 2);

            evbox.settings_requested.connect (() => {
                dialog = new TaskPreferences (win, this);
                dialog.show_all ();
            });

            evbox.delete_requested.connect (() => {
                this.destroy ();
                win.tm.save_notes ();
            });

            this.add (task_grid);
            this.hexpand = false;
            this.show_all ();
        }

        public void update_theme () {
            var css_provider = new Gtk.CssProvider();
            this.get_style_context ().add_class ("tt-box-%d".printf(uid));
            var settings = AppSettings.get_default ();
            string style = null;
            string tcolor = null;
            if (settings.theme == 0) {
                // Coming from Flat
                if (color == "#ff3030") {
                    tcolor = "#ff8c82";
                }
                if (color == "#ff7308") {
                    tcolor = "#ffc27d";
                }
                if (color == "#ffcc33") {
                    tcolor = "#ffe16b";
                }
                if (color == "#2ed573") {
                    tcolor = "#c6f96f";
                }
                if (color == "#1e90ff") {
                    tcolor = "#8cd5ff";
                }
                if (color == "#5352ed") {
                    tcolor = "#aca9fd";
                }
                // Coming from Nature
                if (color == "#ff5656") {
                    tcolor = "#ff8c82";
                }
                if (color == "#fa983a") {
                    tcolor = "#ffc27d";
                }
                if (color == "#f6d95b") {
                    tcolor = "#ffe16b";
                }
                if (color == "#2ed573") {
                    tcolor = "#c6f96f";
                }
                if (color == "#1e90ff") {
                    tcolor = "#8cd5ff";
                }
                if (color == "#aca9fd") {
                    tcolor = "#aca9fd";
                }
                // Going to elementary
                if (color == "#ff8c82") {
                    tcolor = "#ff8c82";
                }
                if (color == "#ffc27d") {
                    tcolor = "#ffc27d";
                }
                if (color == "#ffe16b") {
                    tcolor = "#ffe16b";
                }
                if (color == "#c6f96f") {
                    tcolor = "#c6f96f";
                }
                if (color == "#8cd5ff") {
                    tcolor = "#8cd5ff";
                }
                if (color == "#aca9fd") {
                    tcolor = "#aca9fd";
                }
                // Resetted color
                if (color == "#EEEEEE") {
                    tcolor = "#EEEEEE";
                }
            } else if (settings.theme == 1) {
                // Coming from elementary
                if (color == "#ff8c82") {
                    tcolor = "#ff3030";
                }
                if (color == "#ffc27d") {
                    tcolor = "#ff7308";
                }
                if (color == "#ffe16b") {
                    tcolor = "#ffcc33";
                }
                if (color == "#c6f96f") {
                    tcolor = "#2ed573";
                }
                if (color == "#8cd5ff") {
                    tcolor = "#1e90ff";
                }
                if (color == "#aca9fd") {
                    tcolor = "#5352ed";
                }
                // Coming from Nature
                if (color == "#ff5656") {
                    tcolor = "#ff3030";
                }
                if (color == "#fa983a") {
                    tcolor = "#ff7308";
                }
                if (color == "#f6d95b") {
                    tcolor = "#ffcc33";
                }
                if (color == "#78e08f") {
                    tcolor = "#2ed573";
                }
                if (color == "#82ccdd") {
                    tcolor = "#1e90ff";
                }
                if (color == "#8498e6") {
                    tcolor = "#5352ed";
                }
                // Going to Flat
                if (color == "#ff3030") {
                    tcolor = "#ff3030";
                }
                if (color == "#ff7308") {
                    tcolor = "#ff7308";
                }
                if (color == "#ffcc33") {
                    tcolor = "#ffcc33";
                }
                if (color == "#2ed573") {
                    tcolor = "#2ed573";
                }
                if (color == "#1e90ff") {
                    tcolor = "#1e90ff";
                }
                if (color == "#5352ed") {
                    tcolor = "#5352ed";
                }
                // Resetted color
                if (color == "#EEEEEE") {
                    tcolor = "#EEEEEE";
                }
            } else if (settings.theme == 2) {
                // Coming from elementary
                if (color == "#ff8c82") {
                    tcolor = "#ff5656";
                }
                if (color == "#ffc27d") {
                    tcolor = "#fa983a";
                }
                if (color == "#ffe16b") {
                    tcolor = "#f6d95b";
                }
                if (color == "#c6f96f") {
                    tcolor = "#78e08f";
                }
                if (color == "#8cd5ff") {
                    tcolor = "#82ccdd";
                }
                if (color == "#aca9fd") {
                    tcolor = "#8498e6";
                }
                // Coming from Flat
                if (color == "#ff3030") {
                    tcolor = "#ff5656";
                }
                if (color == "#ff7308") {
                    tcolor = "#fa983a";
                }
                if (color == "#ffcc33") {
                    tcolor = "#f6d95b";
                }
                if (color == "#2ed573") {
                    tcolor = "#78e08f";
                }
                if (color == "#1e90ff") {
                    tcolor = "#82ccdd";
                }
                if (color == "#5352ed") {
                    tcolor = "#8498e6";
                }
                // Going to Nature
                if (color == "#ff5656") {
                    tcolor = "#ff5656";
                }
                if (color == "#fa983a") {
                    tcolor = "#fa983a";
                }
                if (color == "#f6d95b") {
                    tcolor = "#f6d95b";
                }
                if (color == "#78e08f") {
                    tcolor = "#78e08f";
                }
                if (color == "#82ccdd") {
                    tcolor = "#82ccdd";
                }
                if (color == "#8498e6") {
                    tcolor = "#8498e6";
                }
                // Resetted color
                if (color == "#EEEEEE") {
                    tcolor = "#EEEEEE";
                }
            }
            if (settings.high_contrast) {
                if (!task_allday == !settings.show_tasks_allday) {
                    style = ("""
                        .tt-box-%d {
                            border-top: none;
                            border-right: none;
                            border-bottom: none;
                            border-radius: 4px;
                            margin-bottom: 4px;
                            border-left: none;
                            background-color: shade (%s, 0.66);
                            color: #FFFFFF;
                        }
                        .tt-box-%d:backdrop {
                            color: #DDDDDD;
                        }
                        .tt-box-%d image {
                            color: #FFFFFF;
                            -gtk-icon-shadow: none;
                            border-image-width: 0;
                            box-shadow: transparent;
                        }
                        .tt-box-%d image:backdrop {
                            color: #666;
                        }
                    """).printf(uid, tcolor, uid, uid, uid);
                } else {
                    style = ("""
                        .tt-box-%d {
                            border-top: none;
                            border-right: none;
                            border-bottom: none;
                            border-radius: 4px;
                            margin-bottom: 4px;
                            border-left: 3px solid shade (%s, 0.5);
                            background-color: shade (%s, 0.66);
                            color: #FFFFFF;
                        }
                        .tt-box-%d:backdrop {
                            color: #DDDDDD;
                        }
                        .tt-box-%d image {
                            color: #FFFFFF;
                            -gtk-icon-shadow: none;
                            border-image-width: 0;
                            box-shadow: transparent;
                        }
                        .tt-box-%d image:backdrop {
                            color: #666;
                        }
                    """).printf(uid, tcolor, tcolor, uid, uid, uid);
                }
            } else {
                if (!task_allday == !settings.show_tasks_allday) {
                    style = ("""
                        .tt-box-%d {
                            border-bottom: none;
                            border-top: none;
                            border-right: none;
                            border-radius: 4px;
                            margin-bottom: 4px;
                            border-left: none;
                            background-color: mix (%s, #FFF, 0.77);
                            color: #333;
                        }
                        .tt-box-%d:backdrop {
                            color: #666;
                        }
                        .tt-box-%d image {
                            color: #333;
                            -gtk-icon-shadow: none;
                            border-image-width: 0;
                            box-shadow: transparent;
                        }
                        .tt-box-%d image:backdrop {
                            color: #666;
                        }
                    """).printf(uid, tcolor, uid, uid, uid);
                } else {
                    style = ("""
                        .tt-box-%d {
                            border-bottom: none;
                            border-top: none;
                            border-right: none;
                            border-radius: 4px;
                            margin-bottom: 4px;
                            border-left: 3px solid %s;
                            background-color: mix (%s, #FFF, 0.5);
                            color: #333;
                        }
                        .tt-box-%d:backdrop {
                            color: #666;
                        }
                        .tt-box-%d image {
                            color: #333;
                            -gtk-icon-shadow: none;
                            border-image-width: 0;
                            box-shadow: transparent;
                        }
                        .tt-box-%d image:backdrop {
                            color: #666;
                        }
                    """).printf(uid, tcolor, tcolor, uid, uid, uid);
                }
            }
            try {
                css_provider.load_from_data(style, -1);
            } catch (GLib.Error e) {
                warning ("Failed to parse css style : %s", e.message);
            }

            Gtk.StyleContext.add_provider_for_screen (
                Gdk.Screen.get_default (),
                css_provider,
                Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
            );
        }

        private void change_theme () {
            var settings = AppSettings.get_default ();
            if (settings.theme == 0) {
                var provider = new Gtk.CssProvider ();
                provider.load_from_resource ("/com/github/lainsce/timetable/elementary.css");
                Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
            } else if (settings.theme == 1) {
                var provider = new Gtk.CssProvider ();
                provider.load_from_resource ("/com/github/lainsce/timetable/flat.css");
                Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
            } else if (settings.theme == 2) {
                var provider = new Gtk.CssProvider ();
                provider.load_from_resource ("/com/github/lainsce/timetable/nature.css");
                Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
            }
        }

        public void notificator (Gtk.Application app) {
            var time = new GLib.DateTime.now_local ();
            string time_now = time.format("%H").to_string () + ":" + time.get_minute ().to_string ();
            if (this.time_from_text == time_now) {
                if (this.task_notify == true) {
                    string title = _("Task: %s").printf (this.task_name);
                    string body = "This task started now!";
                    var notification = new Notification (title);
                    notification.set_body (body);
                    notification.set_icon (new ThemedIcon ("com.github.lainsce.timetable"));
                    app.send_notification ("task-notify", notification);
                }
            }
        }
    }
}
