/*
* Copyright (c) 2018 Lains
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*/
namespace Timetable {
    public class MainWindow : Gtk.Window {
        public const string ACTION_PREFIX = "win.";
        public const string ACTION_SETTINGS = "action_settings";
        public const string ACTION_EXPORT = "action_export";
        public SimpleActionGroup actions { get; construct; }
        public static Gee.MultiMap<string, string> action_accelerators = new Gee.HashMultiMap<string, string> ();

        private const GLib.ActionEntry[] action_entries = {
            { ACTION_SETTINGS,              action_settings              },
            { ACTION_EXPORT,                action_export                }
        };

        public MainWindow (Gtk.Application application) {
            GLib.Object (
                application: application,
                icon_name: "com.github.lainsce.timetable",
                height_request: 750,
                width_request: 900,
                title: (_("Timetable"))
            );

            key_press_event.connect ((e) => {
                uint keycode = e.hardware_keycode;

                if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0) {
                    if (match_keycode (Gdk.Key.q, keycode)) {
                        this.destroy ();
                    }
                }
                return false;
            });
        }

        construct {
            actions = new SimpleActionGroup ();
            actions.add_action_entries (action_entries, this);
            insert_action_group ("win", actions);

            var settings = AppSettings.get_default ();
            int x = settings.window_x;
            int y = settings.window_y;
            int h = settings.window_height;
            int w = settings.window_width;
            if (x != -1 && y != -1) {
                this.move (x, y);
            }
            if (w != 0 && h != 0) {
                this.resize (w, h);
            }

            var provider = new Gtk.CssProvider ();
            provider.load_from_resource ("/com/github/lainsce/timetable/stylesheet.css");
            Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);

            this.get_style_context ().add_class ("rounded");

            var titlebar = new Gtk.HeaderBar ();
            titlebar.show_close_button = true;
            var titlebar_style_context = titlebar.get_style_context ();
            titlebar_style_context.add_class ("tt-toolbar");
            this.set_titlebar (titlebar);

            var new_button = new Gtk.Button ();
            new_button.set_image (new Gtk.Image.from_icon_name ("document-new", Gtk.IconSize.LARGE_TOOLBAR));
            new_button.has_tooltip = true;
            new_button.tooltip_text = (_("New Timetable"));

            var export_tt = new Gtk.ModelButton ();
            export_tt.text = (_("Export Timetable…"));
            export_tt.action_name = ACTION_PREFIX + ACTION_EXPORT;

            var export_menu_grid = new Gtk.Grid ();
            export_menu_grid.margin = 6;
            export_menu_grid.row_spacing = 6;
            export_menu_grid.column_spacing = 12;
            export_menu_grid.orientation = Gtk.Orientation.VERTICAL;
            export_menu_grid.add (export_tt);
            export_menu_grid.show_all ();

            var export_menu = new Gtk.Popover (null);
            export_menu.add (export_menu_grid);

            var export_button = new Gtk.MenuButton ();
            export_button.tooltip_text = _("Export");
            export_button.image = new Gtk.Image.from_icon_name ("document-export", Gtk.IconSize.LARGE_TOOLBAR);
            export_button.popover = export_menu;

            var settings_button = new Gtk.ModelButton ();
            settings_button.text = (_("Preferences"));
            settings_button.action_name = ACTION_PREFIX + ACTION_SETTINGS;

            var menu_grid = new Gtk.Grid ();
            menu_grid.margin = 6;
            menu_grid.row_spacing = 6;
            menu_grid.column_spacing = 12;
            menu_grid.orientation = Gtk.Orientation.VERTICAL;
            menu_grid.add (settings_button);
            menu_grid.show_all ();

            var menu = new Gtk.Popover (null);
            menu.add (menu_grid);

            var menu_button = new Gtk.MenuButton ();
            menu_button.set_image (new Gtk.Image.from_icon_name ("open-menu", Gtk.IconSize.LARGE_TOOLBAR));
            menu_button.has_tooltip = true;
            menu_button.tooltip_text = (_("Settings"));
            menu_button.popover = menu;

            titlebar.pack_start (new_button);
            titlebar.pack_end (menu_button);
            titlebar.pack_end (export_button);

            // Day Columns
            var monday_column = new DayColumn (_("MON"));
            var tuesday_column = new DayColumn (_("TUE"));
            var wednesday_column = new DayColumn (_("WED"));
            var thursday_column = new DayColumn (_("THU"));
            var friday_column = new DayColumn (_("FRI"));

            var grid = new Gtk.Grid ();
            grid.column_spacing = 12;
            grid.margin = 12;
            grid.set_column_homogeneous (true);
            grid.hexpand = false;
            grid.attach (monday_column, 0, 0, 1, 1);
            grid.attach (tuesday_column, 1, 0, 1, 1);
            grid.attach (wednesday_column, 2, 0, 1, 1);
            grid.attach (thursday_column, 3, 0, 1, 1);
            grid.attach (friday_column, 4, 0, 1, 1);
            grid.show_all ();

            new_button.clicked.connect (() => {
                debug ("New button pressed.");
                debug ("Buffer was modified. Asking user to save first.");
                var dialog = new Dialog.display_save_confirm (this);
                dialog.response.connect ((response_id) => {
                    switch (response_id) {
                        case Gtk.ResponseType.YES:
                            debug ("User saves the file.");
                            //TODO: Save file
                            break;
                        case Gtk.ResponseType.NO:
                            debug ("User doesn't care about the file, shoot it to space.");
                            monday_column.clear_column ();
                            tuesday_column.clear_column ();
                            wednesday_column.clear_column ();
                            thursday_column.clear_column ();
                            friday_column.clear_column ();
                            break;
                        case Gtk.ResponseType.CANCEL:
                            debug ("User cancelled, don't do anything.");
                            break;
                        case Gtk.ResponseType.DELETE_EVENT:
                            debug ("User cancelled, don't do anything.");
                            break;
                    }
                    dialog.destroy();
                });

                if (monday_column.is_modified == true || tuesday_column.is_modified == true || wednesday_column.is_modified == true || thursday_column.is_modified == true || friday_column.is_modified == true) {
                    dialog.show ();
                    monday_column.is_modified = false; tuesday_column.is_modified = false; wednesday_column.is_modified = false; thursday_column.is_modified = false; friday_column.is_modified = false;
                }
            });

            this.add (grid);
            this.show_all ();
        }

        private void action_settings () {
            var dialog = new Preferences (this);
            dialog.set_modal (true);
            dialog.show_all ();
        }

        private void action_export () {
            var dialog = new Preferences (this);
            dialog.set_modal (true);
            dialog.show_all ();
        }

        #if VALA_0_42
        protected bool match_keycode (uint keyval, uint code) {
        #else
        protected bool match_keycode (int keyval, uint code) {
        #endif
            Gdk.KeymapKey [] keys;
            Gdk.Keymap keymap = Gdk.Keymap.get_for_display (Gdk.Display.get_default ());
            if (keymap.get_entries_for_keyval (keyval, out keys)) {
                foreach (var key in keys) {
                    if (code == key.keycode)
                        return true;
                    }
                }

            return false;
        }

        public override bool delete_event (Gdk.EventAny event) {
            int x, y, w, h;
            get_position (out x, out y);
            get_size (out w, out h);

            var settings = AppSettings.get_default ();
            settings.window_x = x;
            settings.window_y = y;
            settings.window_width = w;
            settings.window_height = h;
            return false;
        }
    }
}
