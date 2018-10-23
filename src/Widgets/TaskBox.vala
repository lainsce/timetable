namespace Timetable {
    public class TaskBox : Gtk.ListBoxRow {
        public MainWindow win;
        public string task_name;
        public Gtk.Label task_label;
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

            var task_name_label = new Granite.HeaderLabel (_("Task Name"));
            var task_name_entry_buffer = new Gtk.EntryBuffer ();
            var task_name_entry = new Gtk.Entry.with_buffer (task_name_entry_buffer);
            task_name_entry.set_text (this.task_name);
            this.task_name = task_name_entry.get_text ();

            task_label = new Gtk.Label ("");
            task_label.margin_start = 6;
            task_label.halign = Gtk.Align.START;
            task_label.ellipsize = Pango.EllipsizeMode.END;
            task_label.hexpand = true;
            task_label.label = this.task_name;

            task_name_entry_buffer.inserted_text.connect (() => {
                task_label.label = task_name_entry.get_text ();
                this.task_name = task_name_entry.get_text ();
                win.tm.save_notes ();
            });

            var task_delete_button = new Gtk.Button ();
            task_delete_button.vexpand = false;
            task_delete_button.valign = Gtk.Align.CENTER;
            var task_delete_button_style_context = task_delete_button.get_style_context ();
            task_delete_button_style_context.add_class (Gtk.STYLE_CLASS_FLAT);
            task_delete_button.set_image (new Gtk.Image.from_icon_name ("edit-delete-symbolic", Gtk.IconSize.SMALL_TOOLBAR));

            var color_button_label = new Granite.HeaderLabel (_("Task Color"));

            var color_button_red = new Gtk.Button ();
            color_button_red.has_focus = false;
            color_button_red.halign = Gtk.Align.CENTER;
            color_button_red.height_request = 24;
            color_button_red.width_request = 24;
            color_button_red.tooltip_text = _("Red");

            var color_button_red_context = color_button_red.get_style_context ();
            color_button_red_context.add_class ("color-button");
            color_button_red_context.add_class ("color-red");

            var color_button_orange = new Gtk.Button ();
            color_button_orange.has_focus = false;
            color_button_orange.halign = Gtk.Align.CENTER;
            color_button_orange.height_request = 24;
            color_button_orange.width_request = 24;
            color_button_orange.tooltip_text = _("Orange");

            var color_button_orange_context = color_button_orange.get_style_context ();
            color_button_orange_context.add_class ("color-button");
            color_button_orange_context.add_class ("color-orange");

            var color_button_yellow = new Gtk.Button ();
            color_button_yellow.has_focus = false;
            color_button_yellow.halign = Gtk.Align.CENTER;
            color_button_yellow.height_request = 24;
            color_button_yellow.width_request = 24;
            color_button_yellow.tooltip_text = _("Yellow");

            var color_button_yellow_context = color_button_yellow.get_style_context ();
            color_button_yellow_context.add_class ("color-button");
            color_button_yellow_context.add_class ("color-yellow");

            var color_button_green = new Gtk.Button ();
            color_button_green.has_focus = false;
            color_button_green.halign = Gtk.Align.CENTER;
            color_button_green.height_request = 24;
            color_button_green.width_request = 24;
            color_button_green.tooltip_text = _("Green");

            var color_button_green_context = color_button_green.get_style_context ();
            color_button_green_context.add_class ("color-button");
            color_button_green_context.add_class ("color-green");

            var color_button_blue = new Gtk.Button ();
            color_button_blue.has_focus = false;
            color_button_blue.halign = Gtk.Align.CENTER;
            color_button_blue.height_request = 24;
            color_button_blue.width_request = 24;
            color_button_blue.tooltip_text = _("Blue");

            var color_button_blue_context = color_button_blue.get_style_context ();
            color_button_blue_context.add_class ("color-button");
            color_button_blue_context.add_class ("color-blue");

            var color_button_violet = new Gtk.Button ();
            color_button_violet.has_focus = false;
            color_button_violet.halign = Gtk.Align.CENTER;
            color_button_violet.height_request = 24;
            color_button_violet.width_request = 24;
            color_button_violet.tooltip_text = _("Indigo");

            var color_button_violet_context = color_button_violet.get_style_context ();
            color_button_violet_context.add_class ("color-button");
            color_button_violet_context.add_class ("color-violet");

            var color_button_clear = new Gtk.Button ();
            color_button_clear.has_focus = false;
            color_button_clear.height_request = 24;
            color_button_clear.width_request = 24;
            color_button_clear.halign = Gtk.Align.CENTER;
            color_button_clear.tooltip_text = _("Clear Task Color");

            var color_button_clear_context = color_button_clear.get_style_context ();
            color_button_clear_context.add_class ("color-button");
            color_button_clear_context.add_class (Gtk.STYLE_CLASS_FLAT);

            var color_button_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6);
            color_button_box.pack_start (color_button_red, false, true, 0);
            color_button_box.pack_start (color_button_orange, false, true, 0);
            color_button_box.pack_start (color_button_yellow, false, true, 0);
            color_button_box.pack_start (color_button_green, false, true, 0);
            color_button_box.pack_start (color_button_blue, false, true, 0);
            color_button_box.pack_start (color_button_violet, false, true, 0);
            color_button_box.pack_start (color_button_clear, false, true, 0);

            var time_label = new Granite.HeaderLabel (_("Task Time"));

            var task_time_from_pop_label = new Gtk.Label (_("From:"));
            task_time_from_pop_label.halign = Gtk.Align.START;

            var time_from_picker = new Granite.Widgets.TimePicker.with_format ("%H:%M", "%H:%M");
            time_from_picker.text = this.time_from_text;

            var task_time_from_label = new Gtk.Label ("");
            task_time_from_label.margin_start = 6;
            task_time_from_label.halign = Gtk.Align.START;
            task_time_from_label.label = this.time_from_text;

            time_from_picker.time_changed.connect (() => {
                task_time_from_label.label = time_from_picker.time.format ("%H:%M").to_string ();
                this.time_from_text = time_from_picker.time.format ("%H:%M").to_string ();
                win.tm.save_notes ();
            });

            var task_time_to_pop_label = new Gtk.Label (_("To:"));
            task_time_to_pop_label.halign = Gtk.Align.START;

            var time_to_picker = new Granite.Widgets.TimePicker.with_format ("%H:%M", "%H:%M");
            time_to_picker.text = this.time_to_text;

            var task_time_to_label = new Gtk.Label ("");
            task_time_to_label.halign = Gtk.Align.START;
            task_time_to_label.label = this.time_to_text;

            time_to_picker.time_changed.connect (() => {
                task_time_to_label.label = time_to_picker.time.format ("%H:%M").to_string ();
                this.time_to_text = time_to_picker.time.format ("%H:%M").to_string ();
                win.tm.save_notes ();
            });

            var task_time_sep_label = new Gtk.Label ("");

            var task_allday_label = new Gtk.Label (_("All-Day:"));
            task_allday_label.hexpand = false;
            task_allday_label.halign = Gtk.Align.START;
            var task_allday_switch = new Gtk.Switch ();
            task_allday_switch.hexpand = false;
            task_allday_switch.halign = Gtk.Align.START;
            if (this.task_allday == true) {
                task_allday_switch.set_active (true);
                task_time_sep_label.label = "";
                time_to_picker.sensitive = false;
                time_from_picker.sensitive = false;
            } else {
                task_allday_switch.set_active (false);
                task_time_sep_label.label = "-";
                time_to_picker.sensitive = true;
                time_from_picker.sensitive = true;
            }

            var task_allday_help = new Gtk.Image.from_icon_name ("help-info-symbolic", Gtk.IconSize.BUTTON);
            task_allday_help.halign = Gtk.Align.START;
            task_allday_help.hexpand = true;
            task_allday_help.tooltip_text = _("Set the task to span all-day.\nWhen turned off, will set the task back to default time.");

            task_allday_switch.notify["active"].connect (() => {
			    if (task_allday_switch.active) {
                    task_time_from_label.label = "All Day";
                    this.time_from_text = "All Day";
                    task_time_to_label.label = "";
    				this.time_to_text = "";
                    task_time_sep_label.label = "";
                    this.task_allday = true;
                    time_to_picker.sensitive = false;
                    time_from_picker.sensitive = false;
                    win.tm.save_notes ();
			    } else {
                    task_time_from_label.label = "12:00";
                    time_from_picker.text = "12:00";
                    this.time_from_text = "12:00";
                    task_time_to_label.label = "12:00";
                    time_to_picker.text = "12:00";
                    this.time_to_text = "12:00";
                    task_time_sep_label.label = "-";
                    this.task_allday = false;
                    time_to_picker.sensitive = true;
                    time_from_picker.sensitive = true;
                    win.tm.save_notes ();
                }
		    });

            var task_notify_label = new Gtk.Label (_("Notify:"));
            task_notify_label.hexpand = false;
            task_notify_label.halign = Gtk.Align.START;
            var task_notify_switch = new Gtk.Switch ();
            task_notify_switch.hexpand = false;
            task_notify_switch.halign = Gtk.Align.START;

            task_notify_switch.notify["active"].connect (() => {
			    if (task_notify_switch.active) {
                    this.task_notify = true;
                    win.tm.save_notes ();
			    } else {
                    this.task_notify = false;
                    win.tm.save_notes ();
                }
		    });

            if (this.task_notify == true) {
                task_notify_switch.set_active (true);
            } else {
                task_notify_switch.set_active (false);
            }

            var task_notify_help = new Gtk.Image.from_icon_name ("help-info-symbolic", Gtk.IconSize.BUTTON);
            task_notify_help.halign = Gtk.Align.START;
            task_notify_help.hexpand = true;
            task_notify_help.tooltip_text = _("Set the task to notify when it starts.");

            var switch_box = new Gtk.Grid ();
            switch_box.hexpand = false;
            switch_box.column_spacing = 6;
            switch_box.row_spacing = 6;
            switch_box.attach (task_allday_label, 0, 0, 1, 1);
            switch_box.attach (task_allday_switch, 1, 0, 1, 1);
            switch_box.attach (task_allday_help, 2, 0, 1, 1);
            switch_box.attach (task_notify_label, 3, 0, 1, 1);
            switch_box.attach (task_notify_switch, 4, 0, 1, 1);
            switch_box.attach (task_notify_help, 5, 0, 1, 1);

            var time_box = new Gtk.Grid ();
            time_box.hexpand = false;
            time_box.column_spacing = 6;
            time_box.row_spacing = 6;
            time_box.attach (task_time_from_pop_label, 0, 0, 1, 1);
            time_box.attach (time_from_picker, 0, 1, 1, 1);
            time_box.attach (task_time_to_pop_label, 1, 0, 1, 1);
            time_box.attach (time_to_picker, 1, 1, 1, 1);

            var date_time_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6);
            date_time_box.pack_start (task_time_from_label, false, true, 0);
            date_time_box.pack_start (task_time_sep_label, false, true, 0);
            date_time_box.pack_start (task_time_to_label, false, true, 0);

            var setting_grid = new Gtk.Grid ();
            setting_grid.margin = 12;
            setting_grid.column_spacing = 6;
            setting_grid.row_spacing = 6;
            setting_grid.orientation = Gtk.Orientation.VERTICAL;
            setting_grid.attach (task_name_label, 0, 0, 1, 1);
            setting_grid.attach (task_name_entry, 0, 1, 1, 1);
            setting_grid.attach (color_button_label, 0, 2, 1, 1);
            setting_grid.attach (color_button_box, 0, 3, 1, 1);
            setting_grid.attach (time_label, 0, 4, 1, 1);
            setting_grid.attach (time_box, 0, 5, 1, 1);
            setting_grid.attach (switch_box, 0, 6, 1, 1);
            setting_grid.show_all ();

            var popover = new Gtk.Popover (null);
            popover.add (setting_grid);

            var app_button = new Gtk.MenuButton();
            var app_button_context = app_button.get_style_context ();
            app_button_context.add_class (Gtk.STYLE_CLASS_FLAT);
            app_button.has_tooltip = true;
            app_button.vexpand = false;
            app_button.valign = Gtk.Align.CENTER;
            app_button.tooltip_text = (_("Task Settings"));
            app_button.image = new Gtk.Image.from_icon_name ("open-menu-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
            app_button.popover = popover;

            color_button_red.clicked.connect (() => {
                if (settings.theme == 0) {
                    this.color = "#ff8c82";
                    this.tcolor = "#ff8c82";
                } else if (settings.theme == 1) {
                    this.color = "#ff3030";
                    this.tcolor = "#ff3030";
                } else if (settings.theme == 2) {
                    this.color = "#ff5656";
                    this.tcolor = "#ff5656";
                }
                update_theme();
                win.tm.save_notes ();
            });

            color_button_orange.clicked.connect (() => {
                if (settings.theme == 0) {
                    this.color = "#ffc27d";
                    this.tcolor = "#ffc27d";
                } else if (settings.theme == 1) {
                    this.color = "#ff7308";
                    this.tcolor = "#ff7308";
                } else if (settings.theme == 2) {
                    this.color = "#fa983a";
                    this.tcolor = "#fa983a";
                }
                update_theme();
                win.tm.save_notes ();
            });

            color_button_yellow.clicked.connect (() => {
                if (settings.theme == 0) {
                    this.color = "#ffe16b";
                    this.tcolor = "#ffe16b";
                } else if (settings.theme == 1) {
                    this.color = "#ffcc33";
                    this.tcolor = "#ffcc33";
                } else if (settings.theme == 2) {
                    this.color = "#f6d95b";
                    this.tcolor = "#f6d95b";
                }
                update_theme();
                win.tm.save_notes ();
            });

            color_button_green.clicked.connect (() => {
                if (settings.theme == 0) {
                    this.color = "#c6f96f";
                    this.tcolor = "#c6f96f";
                } else if (settings.theme == 1) {
                    this.color = "#2ed573";
                    this.tcolor = "#2ed573";
                } else if (settings.theme == 2) {
                    this.color = "#78e08f";
                    this.tcolor = "#78e08f";
                }
                update_theme();
                win.tm.save_notes ();
            });

            color_button_blue.clicked.connect (() => {
                if (settings.theme == 0) {
                    this.color = "#8cd5ff";
                    this.tcolor = "#8cd5ff";
                } else if (settings.theme == 1) {
                    this.color = "#1e90ff";
                    this.tcolor = "#1e90ff";
                } else if (settings.theme == 2) {
                    this.color = "#82ccdd";
                    this.tcolor = "#82ccdd";
                }
                update_theme();
                win.tm.save_notes ();
            });

            color_button_violet.clicked.connect (() => {
                if (settings.theme == 0) {
                    this.color = "#aca9fd";
                    this.tcolor = "#aca9fd";
                } else if (settings.theme == 1) {
                    this.color = "#5352ed";
                    this.tcolor = "#aca9fd";
                } else if (settings.theme == 2) {
                    this.color = "#8498e6";
                    this.tcolor = "#8498e6";
                }
                update_theme();
                win.tm.save_notes ();
            });

            color_button_clear.clicked.connect (() => {
                if (settings.theme == 0) {
                    this.color = "#EEEEEE";
                    this.tcolor = "#EEEEEE";
                } else if (settings.theme == 1) {
                    this.color = "#EEEEEE";
                    this.tcolor = "#EEEEEE";
                } else if (settings.theme == 2) {
                    this.color = "#EEEEEE";
                    this.tcolor = "#EEEEEE";
                }
                update_theme();
                win.tm.save_notes ();
            });

            var task_grid = new Gtk.Grid ();
            task_grid.hexpand = false;
            task_grid.row_spacing = 6;
            task_grid.margin_top = task_grid.margin_bottom = 12;
            task_grid.margin_start = task_grid.margin_end = 6;
            task_grid.attach (task_label, 0, 0, 1, 1);
            task_grid.attach (date_time_box, 0, 1, 1, 1);
            task_grid.attach (app_button, 1, 0, 1, 2);
            task_grid.attach (task_delete_button, 2, 0, 1, 2);

            task_delete_button.clicked.connect (() => {
                delete_task ();
                win.tm.save_notes ();
            });

            this.add (task_grid);
            this.hexpand = false;
            this.show_all ();
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

        public void delete_task () {
            this.destroy ();
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
                style = ("""
                    .tt-box-%d {
                        border-bottom: 1px solid alpha(#000, 0.25);
                        border-top: none;
                        border-right: none;
                        border-radius: 0;
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
            } else {
                style = ("""
                    .tt-box-%d {
                        border-bottom: 1px solid alpha(#000, 0.25);
                        border-top: none;
                        border-right: none;
                        border-radius: 0;
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
