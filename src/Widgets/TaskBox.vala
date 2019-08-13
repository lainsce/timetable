namespace Timetable {
    public class TaskBox : Gtk.ListBoxRow {
        private MainWindow win;
        public TaskPreferences popover;

        public string task_name;
        public string color;
        public string time_to_text;
        public string time_from_text;
        public bool task_allday;

        private int uid;
        private static int uid_counter;
        private const Gtk.TargetEntry[] targetEntries = {
            {"TASKBOX", Gtk.TargetFlags.SAME_APP, 0}
        };

        public TaskBox (MainWindow win, string task_name, string color, string time_from_text, string time_to_text, bool task_allday) {
            this.win = win;
            this.uid = uid_counter++;
            this.color = color;
            this.task_name = task_name;
            this.time_from_text = time_from_text;
            this.time_to_text = time_to_text;
            this.task_allday = task_allday;

            build_drag_and_drop ();

            var evbox = new TaskEventBox (this.win, this, task_name, color, time_from_text, time_to_text, task_allday);

            var task_grid = new Gtk.Grid ();
            task_grid.hexpand = false;
            task_grid.row_spacing = 6;
            task_grid.row_homogeneous = true;
            task_grid.margin_top = task_grid.margin_bottom = 12;
            task_grid.margin_start = task_grid.margin_end = 12;
            task_grid.attach (evbox, 0, 0, 1, 2);

            evbox.delete_requested.connect (() => {
                this.destroy ();
                win.tm.save_notes ();
            });

            evbox.prefs_requested.connect (() => {
                popover = new TaskPreferences (win, this, evbox);
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
            if (settings.theme == 0) {
                // Coming from Flat
                if (color == "#F33B61") {
                    color = "#ed5353";
                }
                if (color == "#ffa358") {
                    color = "#ffa154";
                }
                if (color == "#FFE379") {
                    color = "#ffe16b";
                }
                if (color == "#9CCF81") {
                    color = "#9bdb4d";
                }
                if (color == "#8ED0FF") {
                    color = "#64baff";
                }
                if (color == "#C1AFF2") {
                    color = "#ad65d6";
                }
                // Coming from Nature
                if (color == "#ff5656") {
                    color = "#ed5353";
                }
                if (color == "#fa983a") {
                    color = "#ffa154";
                }
                if (color == "#f6d95b") {
                    color = "#ffe16b";
                }
                if (color == "#78e08f") {
                    color = "#9bdb4d";
                }
                if (color == "#82ccdd") {
                    color = "#64baff";
                }
                if (color == "#ad65d6") {
                    color = "#ad65d6";
                }
                // Going to elementary
                if (color == "#ed5353") {
                    color = "#ed5353";
                }
                if (color == "#ffa154") {
                    color = "#ffa154";
                }
                if (color == "#ffe16b") {
                    color = "#ffe16b";
                }
                if (color == "#9bdb4d") {
                    color = "#9bdb4d";
                }
                if (color == "#64baff") {
                    color = "#64baff";
                }
                if (color == "#ad65d6") {
                    color = "#ad65d6";
                }
                // Resetted color
                if (color == "#d4d4d4") {
                    color = "#d4d4d4";
                }
            } else if (settings.theme == 1) {
                // Coming from elementary
                if (color == "#ed5353") {
                    color = "#F33B61";
                }
                if (color == "#ffa154") {
                    color = "#ffa358";
                }
                if (color == "#ffe16b") {
                    color = "#FFE379";
                }
                if (color == "#9bdb4d") {
                    color = "#9CCF81";
                }
                if (color == "#64baff") {
                    color = "#8ED0FF";
                }
                if (color == "#ad65d6") {
                    color = "#C1AFF2";
                }
                // Coming from Nature
                if (color == "#ff5656") {
                    color = "#F33B61";
                }
                if (color == "#fa983a") {
                    color = "#ffa358";
                }
                if (color == "#f6d95b") {
                    color = "#FFE379";
                }
                if (color == "#78e08f") {
                    color = "#9CCF81";
                }
                if (color == "#82ccdd") {
                    color = "#8ED0FF";
                }
                if (color == "#8498e6") {
                    color = "#C1AFF2";
                }
                // Going to Flat
                if (color == "#F33B61") {
                    color = "#F33B61";
                }
                if (color == "#ffa358") {
                    color = "#ffa358";
                }
                if (color == "#FFE379") {
                    color = "#FFE379";
                }
                if (color == "#9CCF81") {
                    color = "#9CCF81";
                }
                if (color == "#8ED0FF") {
                    color = "#8ED0FF";
                }
                if (color == "#C1AFF2") {
                    color = "#C1AFF2";
                }
                // Resetted color
                if (color == "#d4d4d4") {
                    color = "#d4d4d4";
                }
            } else if (settings.theme == 2) {
                // Coming from elementary
                if (color == "#ed5353") {
                    color = "#ff5656";
                }
                if (color == "#ffa154") {
                    color = "#fa983a";
                }
                if (color == "#ffe16b") {
                    color = "#f6d95b";
                }
                if (color == "#9bdb4d") {
                    color = "#78e08f";
                }
                if (color == "#64baff") {
                    color = "#82ccdd";
                }
                if (color == "#ad65d6") {
                    color = "#8498e6";
                }
                // Coming from Flat
                if (color == "#F33B61") {
                    color = "#ff5656";
                }
                if (color == "#ffa358") {
                    color = "#fa983a";
                }
                if (color == "#FFE379") {
                    color = "#f6d95b";
                }
                if (color == "#9CCF81") {
                    color = "#78e08f";
                }
                if (color == "#8ED0FF") {
                    color = "#82ccdd";
                }
                if (color == "#C1AFF2") {
                    color = "#8498e6";
                }
                // Going to Nature
                if (color == "#ff5656") {
                    color = "#ff5656";
                }
                if (color == "#fa983a") {
                    color = "#fa983a";
                }
                if (color == "#f6d95b") {
                    color = "#f6d95b";
                }
                if (color == "#78e08f") {
                    color = "#78e08f";
                }
                if (color == "#82ccdd") {
                    color = "#82ccdd";
                }
                if (color == "#8498e6") {
                    color = "#8498e6";
                }
                // Resetted color
                if (color == "#d4d4d4") {
                    color = "#d4d4d4";
                }
            }
            if (settings.high_contrast) {
                if (settings.show_tasks_allday && this.task_allday) {
                    style = ("""
                        .tt-box-%d {
                            border-top: none;
                            border-right: none;
                            border-bottom: none;
                            border-radius: 4px;
                            margin-bottom: 10px;
                            border-left: none;
                            background-color: shade (%s, 0.5);
                            color: #FFFFFF;
                            font-weight: 600;
                            box-shadow:
                                0 1px 3px alpha (shade (%s, 0.33), 0.12),
                                0 1px 2px alpha (shade (%s, 0.33), 0.24);
                        }
                        .tt-box-%d:backdrop {
                            color: #DDDDDD;
                        }
                        .tt-box-%d:selected.activatable {
                            color: #FFF;
                        }
                        .tt-box-%d:selected.activatable:backdrop {
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
                    """).printf(uid, color, color, color, uid, uid, uid, uid, uid);
                } else {
                    style = ("""
                        .tt-box-%d {
                            border-top: none;
                            border-right: none;
                            border-bottom: none;
                            border-radius: 4px;
                            margin-bottom: 10px;
                            border-left: 3px solid shade (%s, 0.5);
                            background-color: shade (%s, 0.5);
                            color: #FFF;
                            font-weight: 600;
                            box-shadow:
                                0 1px 3px alpha (shade (%s, 0.33), 0.12),
                                0 1px 2px alpha (shade (%s, 0.33), 0.24);
                        }
                        .tt-box-%d:backdrop {
                            color: #DDDDDD;
                        }
                        .tt-box-%d:selected.activatable {
                            color: #FFF;
                        }
                        .tt-box-%d:selected.activatable:backdrop {
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
                    """).printf(uid, color, color, color, color, uid, uid, uid, uid, uid);
                }
            } else {
                if (settings.show_tasks_allday && this.task_allday) {
                    style = ("""
                        .tt-box-%d {
                            border-bottom: none;
                            border-top: none;
                            border-right: none;
                            border-radius: 4px;
                            margin-bottom: 10px;
                            border-left: 3px solid mix (%s, #FFF, 0.5);
                            background-color: mix (%s, #FFF, 0.5);
                            color: shade (%s, 0.4);
                            font-weight: 600;
                            box-shadow:
                                0 1px 3px alpha (shade (%s, 0.33), 0.12),
                                0 1px 2px alpha (shade (%s, 0.33), 0.24);
                        }
                        .tt-box-%d:backdrop {
                            color: shade (%s, 0.6);
                        }
                        .tt-box-%d:selected.activatable {
                            color: shade (%s, 0.4);
                        }
                        .tt-box-%d:selected.activatable:backdrop {
                            color: shade (%s, 0.6);
                        }
                        .tt-box-%d image {
                            color: shade (%s, 0.4);
                            -gtk-icon-shadow: none;
                            border-image-width: 0;
                            box-shadow: transparent;
                        }
                        .tt-box-%d image:backdrop {
                            color: shade (%s, 0.6);
                        }
                    """).printf(uid, color, color, color, color, color, uid, color, uid, color, uid, color, uid, color, uid, color);
                } else {
                    style = ("""
                        .tt-box-%d {
                            border-bottom: none;
                            border-top: none;
                            border-right: none;
                            border-radius: 4px;
                            margin-bottom: 10px;
                            border-left: 3px solid %s;
                            background-color: mix (%s, #FFF, 0.7);
                            color: shade (%s, 0.5);
                            font-weight: 600;
                            box-shadow:
                                0 1px 3px alpha (shade (%s, 0.5), 0.12),
                                0 1px 2px alpha (shade (%s, 0.5), 0.24);
                        }
                        .tt-box-%d:backdrop {
                            color: shade (%s, 0.88);
                        }
                        .tt-box-%d:selected.activatable {
                            color: shade (%s, 0.5);
                        }
                        .tt-box-%d:selected.activatable:backdrop {
                            color: shade (%s, 0.88);
                        }
                        .tt-box-%d image {
                            color: shade (%s, 0.5);
                            -gtk-icon-shadow: none;
                            border-image-width: 0;
                            box-shadow: transparent;
                        }
                        .tt-box-%d image:backdrop {
                            color: shade (%s, 0.88);
                        }
                    """).printf(uid, color, color, color, color, color, uid, color, uid, color, uid, color, uid, color, uid, color);
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
    
        private void build_drag_and_drop () {
            Gtk.drag_source_set (this, Gdk.ModifierType.BUTTON1_MASK, targetEntries, Gdk.DragAction.MOVE);
    
            drag_begin.connect (on_drag_begin);
            drag_data_get.connect (on_drag_data_get);
        }
    
        private void on_drag_begin (Gtk.Widget widget, Gdk.DragContext context) {
            var row = (TaskBox) widget;
            Gtk.Allocation alloc;
            row.get_allocation (out alloc);
    
            var surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, alloc.width, alloc.height);
            var cr = new Cairo.Context (surface);

            cr.set_source_rgba (255, 255, 255, 1);
            cr.rectangle (0, 0, alloc.width, alloc.height-15);
            cr.fill ();
    
            row.draw (cr);
    
            Gtk.drag_set_icon_surface (context, surface);
        }
    
        private void on_drag_data_get (Gtk.Widget widget, Gdk.DragContext context, Gtk.SelectionData selection_data, uint target_type, uint time) {
            uchar[] data = new uchar[(sizeof (TaskBox))];
            ((Gtk.Widget[])data)[0] = widget;
    
            selection_data.set (
                Gdk.Atom.intern_static_string ("TASKBOX"), 32, data
            );
        }  
    }
}