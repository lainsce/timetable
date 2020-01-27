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
    public class MainWindow : Gtk.ApplicationWindow {
        // Widgets
        public DayColumn monday_column;
        public DayColumn tuesday_column;
        public DayColumn wednesday_column;
        public DayColumn thursday_column;
        public DayColumn friday_column;
        public DayColumn saturday_column;
        public DayColumn sunday_column;
        public Gtk.Grid grid;

        public TaskManager tm;

        // Actions
        public const string ACTION_PREFIX = "win.";
        public const string ACTION_SETTINGS = "action_settings";
        public const string ACTION_EXPORT = "action_export";
        public SimpleActionGroup actions { get; construct; }
        public static Gee.MultiMap<string, string> action_accelerators =
                                        new Gee.HashMultiMap<string, string> ();

        private const GLib.ActionEntry[] action_entries = {
            { ACTION_SETTINGS,              action_settings              },
            { ACTION_EXPORT,                action_export                }
        };

        public Gtk.Application app { get; construct; }

        public MainWindow (Gtk.Application application) {
            GLib.Object (
                application: application,
                app: application,
                icon_name: "com.github.lainsce.timetable",
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
            tm = new TaskManager (this);
            actions = new SimpleActionGroup ();
            actions.add_action_entries (action_entries, this);
            insert_action_group ("win", actions);

            int x = Timetable.Application.gsettings.get_int("window-x");
            int y = Timetable.Application.gsettings.get_int("window-y");
            int h = Timetable.Application.gsettings.get_int("window-height");
            int w = Timetable.Application.gsettings.get_int("window-width");
            if (x != -1 && y != -1) {
                this.move (x, y);
            }
            if (w != 0 && h != 0) {
                this.resize (w, h);
            }

            var provider = new Gtk.CssProvider ();
            provider.load_from_resource ("/com/github/lainsce/timetable/stylesheet.css");
            Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (),
                                                      provider,
                                                      Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);

            this.get_style_context ().add_class ("rounded");

            var titlebar = new Gtk.HeaderBar ();
            titlebar.show_close_button = true;
            var titlebar_style_context = titlebar.get_style_context ();
            titlebar_style_context.add_class ("tt-toolbar");
            this.set_titlebar (titlebar);

            var new_button = new Gtk.Button ();
            new_button.set_image (new Gtk.Image.from_icon_name ("document-new",
                                                                Gtk.IconSize.LARGE_TOOLBAR));
            new_button.has_tooltip = true;
            new_button.tooltip_text = (_("New Timetable"));

            var open_button = new Gtk.Button ();
            open_button.set_image (new Gtk.Image.from_icon_name ("document-open",
                                                                 Gtk.IconSize.LARGE_TOOLBAR));
            open_button.has_tooltip = true;
            open_button.tooltip_text = (_("Open Timetable…"));

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
            export_button.image = new Gtk.Image.from_icon_name ("document-export",
                                                                Gtk.IconSize.LARGE_TOOLBAR);
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
            menu_button.set_image (new Gtk.Image.from_icon_name ("open-menu",
                                                                 Gtk.IconSize.LARGE_TOOLBAR));
            menu_button.has_tooltip = true;
            menu_button.tooltip_text = (_("Settings"));
            menu_button.popover = menu;

            titlebar.pack_start (new_button);
            titlebar.pack_start (open_button);
            titlebar.pack_end (menu_button);
            titlebar.pack_end (export_button);

            // Times Column
            var 0_row = new Gtk.Image.from_icon_name ("daytime-sunrise-symbolic",
                                                      Gtk.IconSize.LARGE_TOOLBAR);
            0_row.halign = Gtk.Align.CENTER;
            0_row.valign = Gtk.Align.CENTER;
            var 0_row_style_context = 0_row.get_style_context ();
            0_row_style_context.add_class ("tt-label-time");
            0_row.tooltip_text = _("Sunrise");

            var 8_row = new Gtk.Image.from_icon_name ("weather-clear-symbolic",
                                                      Gtk.IconSize.LARGE_TOOLBAR);
            8_row.halign = Gtk.Align.CENTER;
            0_row.valign = Gtk.Align.CENTER;
            var 8_row_style_context = 8_row.get_style_context ();
            8_row_style_context.add_class ("tt-label-time");
            8_row.tooltip_text = _("Mid-day");

            var 16_row = new Gtk.Image.from_icon_name ("daytime-sunset-symbolic",
                                                       Gtk.IconSize.LARGE_TOOLBAR);
            16_row.halign = Gtk.Align.CENTER;
            16_row.valign = Gtk.Align.CENTER;
            var 16_row_style_context = 16_row.get_style_context ();
            16_row_style_context.add_class ("tt-label-time");
            16_row.tooltip_text = _("Sunset");

            var 24_row = new Gtk.Image.from_icon_name ("weather-clear-night-symbolic",
                                                       Gtk.IconSize.LARGE_TOOLBAR);
            24_row.halign = Gtk.Align.CENTER;
            24_row.valign = Gtk.Align.CENTER;
            var 24_row_style_context = 24_row.get_style_context ();
            24_row_style_context.add_class ("tt-label-time");
            24_row.tooltip_text = _("Night");

            var star_row = new Gtk.Image.from_icon_name ("starred-symbolic",
                                                         Gtk.IconSize.LARGE_TOOLBAR);
            star_row.halign = Gtk.Align.CENTER;
            star_row.valign = Gtk.Align.CENTER;
            var star_row_style_context = star_row.get_style_context ();
            star_row_style_context.add_class ("tt-label-time");
            star_row.tooltip_text = _("All-Day");

            var tgrid = new Gtk.Grid ();
            tgrid.get_style_context ().add_class ("tt-column-time");
            tgrid.set_size_request (24,-1);
            tgrid.margin_top = 24;
            tgrid.margin_bottom = tgrid.margin_start = 12;
            tgrid.margin_end = 0;
            tgrid.row_homogeneous = true;
            tgrid.hexpand = false;
            tgrid.vexpand = true;
            tgrid.halign = Gtk.Align.CENTER;
            tgrid.row_spacing = 78;
            tgrid.attach (0_row, 0, 0, 1, 1);
            tgrid.attach (8_row, 0, 1, 1, 1);
            tgrid.attach (16_row, 0, 2, 1, 1);
            tgrid.attach (24_row, 0, 3, 1, 1);
            tgrid.attach (star_row, 0, 4, 1, 1);

            // Day Columns
            monday_column = new DayColumn (1, this);
            tuesday_column = new DayColumn (2, this);
            wednesday_column = new DayColumn (3, this);
            thursday_column = new DayColumn (4, this);
            friday_column = new DayColumn (5, this);
            saturday_column = new DayColumn (6, this);
            sunday_column = new DayColumn (7, this);

            tm.load_from_file ();

            grid = new Gtk.Grid ();
            grid.column_spacing = 12;
            grid.margin = 12;
            grid.set_column_homogeneous (true);
            grid.hexpand = true;
            grid.attach (monday_column, 0, 0, 1, 2);
            grid.attach (tuesday_column, 1, 0, 1, 2);
            grid.attach (wednesday_column, 2, 0, 1, 2);
            grid.attach (thursday_column, 3, 0, 1, 2);
            grid.attach (friday_column, 4, 0, 1, 2);

            weekend_columns ();

            Timetable.Application.gsettings.changed.connect (() => {
                weekend_columns ();
            });
            grid.show_all ();

            new_button.clicked.connect (() => {
                FileManager.new_tt (this);
            });

            open_button.clicked.connect (() => {
                FileManager.open_tt (this);
            });

            var box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            box.hexpand = true;
            box.pack_start (tgrid, false, true, 0);
            box.pack_start (grid, false, true, 0);

            var scrwindow = new Gtk.ScrolledWindow (null, null);
            scrwindow.add (box);

            this.add (scrwindow);
            this.set_size_request (600, 600);
            this.show_all ();
        }

        private void weekend_columns () {
            if (Timetable.Application.gsettings.get_boolean("weekend-show") == true) {
                grid.attach (saturday_column, 5, 0, 1, 1);
                grid.attach (sunday_column, 5, 1, 1, 1);
                saturday_column.visible = true;
                sunday_column.visible = true;
                sunday_column.margin_top = 6;
            } else {
                saturday_column.visible = false;
                sunday_column.visible = false;
            }
        }

        private void action_settings () {
            var dialog = new Preferences (this);
            dialog.show_all ();
        }

        private void action_export () {
            try {
                FileManager.save_as (this);
            } catch (Error e) {
                warning ("Unexpected error during export: " + e.message);
            }
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

            Timetable.Application.gsettings.set_int("window-x", x);
            Timetable.Application.gsettings.set_int("window-y", y);
            Timetable.Application.gsettings.set_int("window-width", w);
            Timetable.Application.gsettings.set_int("window-height", h);
            return false;
        }
    }
}
