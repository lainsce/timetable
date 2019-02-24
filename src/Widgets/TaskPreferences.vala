namespace Timetable {
    public class TaskPreferences : Gtk.Popover {
        public weak TaskBox tb;
        public MainWindow win;

        public TaskPreferences (MainWindow win, TaskBox tb) {
            Object (
                border_width: 6
            );
            this.win = win;
            this.tb = tb;
            this.set_relative_to (tb.evbox.app_button);

            var settings = AppSettings.get_default ();
            var task_prefs_label = new Gtk.Label (_("“%s” Preferences").printf(tb.task_name));
            task_prefs_label.halign = Gtk.Align.CENTER;
            task_prefs_label.wrap = true;
            var task_prefs_label_style_context = task_prefs_label.get_style_context ();
            task_prefs_label_style_context.add_class ("h3");

            var task_name_label = new Granite.HeaderLabel (_("Task Name"));
            var task_name_entry_buffer = new Gtk.EntryBuffer ();
            var task_name_entry = new Gtk.Entry.with_buffer (task_name_entry_buffer);
            task_name_entry.set_placeholder_text ("Task…");

            task_name_entry_buffer.inserted_text.connect (() => {
                task_prefs_label.label = _("“%s” Preferences").printf(task_name_entry.get_text ());
                tb.task_label.label = task_name_entry.get_text ();
                tb.task_name = task_name_entry.get_text ();
                task_name_entry.set_text (tb.task_name);
                win.tm.save_notes ();
            });

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

            color_button_red.clicked.connect (() => {
                if (settings.theme == 0) {
                    tb.color = "#ed5353";
                    tb.tcolor = "#ed5353";
                } else if (settings.theme == 1) {
                    tb.color = "#F33B61";
                    tb.tcolor = "#F33B61";
                } else if (settings.theme == 2) {
                    tb.color = "#ff5656";
                    tb.tcolor = "#ff5656";
                }
                tb.update_theme ();
                win.tm.save_notes ();
            });

            color_button_orange.clicked.connect (() => {
                if (settings.theme == 0) {
                    tb.color = "#ffa154";
                    tb.tcolor = "#ffa154";
                } else if (settings.theme == 1) {
                    tb.color = "#ffa358";
                    tb.tcolor = "#ffa358";
                } else if (settings.theme == 2) {
                    tb.color = "#fa983a";
                    tb.tcolor = "#fa983a";
                }
                tb.update_theme ();
                win.tm.save_notes ();
            });

            color_button_yellow.clicked.connect (() => {
                if (settings.theme == 0) {
                    tb.color = "#ffe16b";
                    tb.tcolor = "#ffe16b";
                } else if (settings.theme == 1) {
                    tb.color = "#FFE379";
                    tb.tcolor = "#FFE379";
                } else if (settings.theme == 2) {
                    tb.color = "#f6d95b";
                    tb.tcolor = "#f6d95b";
                }
                tb.update_theme ();
                win.tm.save_notes ();
            });

            color_button_green.clicked.connect (() => {
                if (settings.theme == 0) {
                    tb.color = "#9bdb4d";
                    tb.tcolor = "#9bdb4d";
                } else if (settings.theme == 1) {
                    tb.color = "#9CCF81";
                    tb.tcolor = "#9CCF81";
                } else if (settings.theme == 2) {
                    tb.color = "#78e08f";
                    tb.tcolor = "#78e08f";
                }
                tb.update_theme ();
                win.tm.save_notes ();
            });

            color_button_blue.clicked.connect (() => {
                if (settings.theme == 0) {
                    tb.color = "#64baff";
                    tb.tcolor = "#64baff";
                } else if (settings.theme == 1) {
                    tb.color = "#8ED0FF";
                    tb.tcolor = "#8ED0FF";
                } else if (settings.theme == 2) {
                    tb.color = "#82ccdd";
                    tb.tcolor = "#82ccdd";
                }
                tb.update_theme ();
                win.tm.save_notes ();
            });

            color_button_violet.clicked.connect (() => {
                if (settings.theme == 0) {
                    tb.color = "#ad65d6";
                    tb.tcolor = "#ad65d6";
                } else if (settings.theme == 1) {
                    tb.color = "#C1AFF2";
                    tb.tcolor = "#C1AFF2";
                } else if (settings.theme == 2) {
                    tb.color = "#8498e6";
                    tb.tcolor = "#8498e6";
                }
                tb.update_theme ();
                win.tm.save_notes ();
            });

            color_button_clear.clicked.connect (() => {
                if (settings.theme == 0) {
                    tb.color = "#d4d4d4";
                    tb.tcolor = "#d4d4d4";
                } else if (settings.theme == 1) {
                    tb.color = "#d4d4d4";
                    tb.tcolor = "#d4d4d4";
                } else if (settings.theme == 2) {
                    tb.color = "#d4d4d4";
                    tb.tcolor = "#d4d4d4";
                }
                tb.update_theme ();
                win.tm.save_notes ();
            });

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
            time_from_picker.text = tb.time_from_text;

            time_from_picker.time_changed.connect (() => {
                tb.task_time_from_label.label = time_from_picker.time.format ("%H:%M").to_string ();
                tb.time_from_text = time_from_picker.time.format ("%H:%M").to_string ();
                tb.changed ();
                win.tm.save_notes ();
            });

            var task_time_to_pop_label = new Gtk.Label (_("To:"));
            task_time_to_pop_label.halign = Gtk.Align.START;

            var time_to_picker = new Granite.Widgets.TimePicker.with_format ("%H:%M", "%H:%M");
            time_to_picker.text = tb.time_to_text;

            time_to_picker.time_changed.connect (() => {
                tb.task_time_to_label.label = time_to_picker.time.format ("%H:%M").to_string ();
                tb.time_to_text = time_to_picker.time.format ("%H:%M").to_string ();
                tb.changed ();
                win.tm.save_notes ();
            });

            var task_allday_label = new Gtk.Label (_("All-Day:"));
            task_allday_label.hexpand = false;
            task_allday_label.halign = Gtk.Align.START;
            var task_allday_switch = new Gtk.Switch ();
            task_allday_switch.hexpand = false;
            task_allday_switch.halign = Gtk.Align.START;
            if (tb.task_allday == true) {
                task_allday_switch.set_active (true);
                tb.task_time_sep_label.label = "-";
                time_to_picker.sensitive = false;
                time_from_picker.sensitive = false;
                tb.update_theme ();
            } else {
                task_allday_switch.set_active (false);
                tb.task_time_sep_label.label = "-";
                time_to_picker.sensitive = true;
                time_from_picker.sensitive = true;
                tb.update_theme ();
            }

            var task_allday_help = new Gtk.Image.from_icon_name ("help-info-symbolic", Gtk.IconSize.BUTTON);
            task_allday_help.halign = Gtk.Align.START;
            task_allday_help.hexpand = true;
            task_allday_help.tooltip_text = _("Set the task to span all-day.\nWhen turned off, will set the task back to default time.");

            task_allday_switch.notify["active"].connect (() => {
			    if (task_allday_switch.active) {
                    tb.task_time_from_label.label = "00:00";
                    tb.time_from_text = "00:00";
                    tb.task_time_to_label.label = "23:59";
    				tb.time_to_text = "23:59";
                    tb.task_time_sep_label.label = "-";
                    tb.task_allday = true;
                    time_to_picker.sensitive = false;
                    time_from_picker.sensitive = false;
                    win.tm.save_notes ();
			    } else {
                    tb.task_time_from_label.label = "12:00";
                    time_from_picker.text = "12:00";
                    tb.time_from_text = "12:00";
                    tb.task_time_to_label.label = "12:00";
                    time_to_picker.text = "12:00";
                    tb.time_to_text = "12:00";
                    tb.task_time_sep_label.label = "-";
                    tb.task_allday = false;
                    time_to_picker.sensitive = true;
                    time_from_picker.sensitive = true;
                    win.tm.save_notes ();
                }
		    });

            var switch_box = new Gtk.Grid ();
            switch_box.hexpand = false;
            switch_box.column_spacing = 6;
            switch_box.row_spacing = 6;
            switch_box.attach (task_allday_label, 0, 0, 1, 1);
            switch_box.attach (task_allday_switch, 1, 0, 1, 1);
            switch_box.attach (task_allday_help, 2, 0, 1, 1);

            var time_box = new Gtk.Grid ();
            time_box.hexpand = false;
            time_box.column_spacing = 6;
            time_box.row_spacing = 6;
            time_box.attach (task_time_from_pop_label, 0, 0, 1, 1);
            time_box.attach (time_from_picker, 0, 1, 1, 1);
            time_box.attach (task_time_to_pop_label, 1, 0, 1, 1);
            time_box.attach (time_to_picker, 1, 1, 1, 1);

            var main_grid = new Gtk.Grid ();
            main_grid.orientation = Gtk.Orientation.VERTICAL;
            main_grid.row_spacing = 6;
            main_grid.column_spacing = 12;
            main_grid.attach (task_prefs_label, 0, 0, 1, 1);
            main_grid.attach (task_name_label, 0, 1, 1, 1);
            main_grid.attach (task_name_entry, 0, 2, 1, 1);
            main_grid.attach (color_button_label, 0, 3, 1, 1);
            main_grid.attach (color_button_box, 0, 4, 1, 1);
            main_grid.attach (time_label, 0, 5, 1, 1);
            main_grid.attach (time_box, 0, 6, 1, 1);
            main_grid.attach (switch_box, 0, 7, 1, 1);
            main_grid.show_all ();

            var main_stack = new Gtk.Stack ();
            main_stack.margin = 12;
            main_stack.margin_top = 0;
            main_stack.add (main_grid);

            var grid = new Gtk.Grid ();
            grid.margin_top = 0;
            grid.attach (main_stack, 0, 1, 1, 1);

            this.add (grid);
            this.show_all ();
        }
    }
}
