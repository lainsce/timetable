namespace Timetable {
    public class TaskBox : Gtk.ListBoxRow {
        public MainWindow win;
        public string task_name;
        public EditableLabel task_label;
        public int uid;
        public static int uid_counter;
        public string color;

        public TaskBox (MainWindow win, string task_name, string color) {
            this.win = win;
            this.uid = uid_counter++;
            this.task_name = task_name;
            this.color = color;
            update_theme ();

            task_label = new EditableLabel (this.task_name);

            var task_delete_button = new Gtk.Button ();
            var task_delete_button_style_context = task_delete_button.get_style_context ();
            task_delete_button_style_context.add_class (Gtk.STYLE_CLASS_FLAT);
            task_delete_button.set_image (new Gtk.Image.from_icon_name ("edit-delete-symbolic", Gtk.IconSize.SMALL_TOOLBAR));

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

            var color_button_indigo = new Gtk.Button ();
            color_button_indigo.has_focus = false;
            color_button_indigo.halign = Gtk.Align.CENTER;
            color_button_indigo.height_request = 24;
            color_button_indigo.width_request = 24;
            color_button_indigo.tooltip_text = _("Indigo");

            var color_button_indigo_context = color_button_indigo.get_style_context ();
            color_button_indigo_context.add_class ("color-button");
            color_button_indigo_context.add_class ("color-indigo");

            var color_button_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6);
            color_button_box.pack_start (color_button_red, false, true, 0);
            color_button_box.pack_start (color_button_orange, false, true, 0);
            color_button_box.pack_start (color_button_yellow, false, true, 0);
            color_button_box.pack_start (color_button_green, false, true, 0);
            color_button_box.pack_start (color_button_blue, false, true, 0);
            color_button_box.pack_start (color_button_indigo, false, true, 0);

            var color_button_label = new Granite.HeaderLabel (_("Task Color"));

            var setting_grid = new Gtk.Grid ();
            setting_grid.margin = 12;
            setting_grid.column_spacing = 6;
            setting_grid.row_spacing = 6;
            setting_grid.orientation = Gtk.Orientation.VERTICAL;
            setting_grid.attach (color_button_label, 0, 0, 1, 1);
            setting_grid.attach (color_button_box, 0, 1, 1, 1);
            setting_grid.show_all ();

            var popover = new Gtk.Popover (null);
            popover.add (setting_grid);

            var app_button = new Gtk.MenuButton();
            var app_button_context = app_button.get_style_context ();
            app_button_context.add_class (Gtk.STYLE_CLASS_FLAT);
            app_button.has_tooltip = true;
            app_button.tooltip_text = (_("Settings"));
            app_button.image = new Gtk.Image.from_icon_name ("open-menu-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
            app_button.popover = popover;

            color_button_red.clicked.connect (() => {
                this.color = "#ff8c82";
                update_theme();
                win.tm.save_notes ();
            });

            color_button_orange.clicked.connect (() => {
                this.color = "#ffc27d";
                update_theme();
                win.tm.save_notes ();
            });

            color_button_yellow.clicked.connect (() => {
                this.color = "#fff394";
                update_theme();
                win.tm.save_notes ();
            });

            color_button_green.clicked.connect (() => {
                this.color = "#d1ff82";
                update_theme();
                win.tm.save_notes ();
            });

            color_button_blue.clicked.connect (() => {
                this.color = "#8cd5ff";
                update_theme();
                win.tm.save_notes ();
            });

            color_button_indigo.clicked.connect (() => {
                this.color = "#aca9fd";
                update_theme();
                win.tm.save_notes ();
            });

            var task_grid = new Gtk.Grid ();
            task_grid.hexpand = false;
            task_grid.margin_top = task_grid.margin_bottom = 12;
            task_grid.margin_start = task_grid.margin_end = 6;
            task_grid.attach (task_label, 0, 0, 1, 1);
            task_grid.attach (app_button, 1, 0, 1, 1);
            task_grid.attach (task_delete_button, 2, 0, 1, 1);

            task_delete_button.clicked.connect (() => {
                delete_task ();
                win.tm.save_notes ();
            });

            task_label.changed.connect (() => {
                this.task_name = task_label.text;
                win.tm.save_notes ();
            });

            this.add (task_grid);
            this.hexpand = false;
            this.show_all ();
        }

        public void delete_task () {
            this.destroy ();
        }

        public void update_theme () {
            var css_provider = new Gtk.CssProvider();
            this.get_style_context ().add_class ("tt-box-%d".printf(uid));

            string style = null;
            string selcolor = this.color;
            style = (N_("""
                .tt-box-%d {
                    border-bottom: 1px solid #ccc;
                    border-top: none;
                    border-right: none;
                    border-radius: 0;
                    border-left: 4px solid %s;
                    background-color: alpha (%s, 0.3);
                }
                """)).printf(uid, selcolor, selcolor);

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
    }
}
