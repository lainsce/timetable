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
        public MainWindow (Gtk.Application application) {
            GLib.Object (
                application: application,
                icon_name: "com.github.lainsce.timetable",
                height_request: 700,
                width_request: 800,
                title: (_("Timetable"))
            );
        }

        construct {
            var provider = new Gtk.CssProvider ();
            provider.load_from_resource ("/com/github/lainsce/timetable/stylesheet.css");
            Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);

            var titlebar = new Gtk.HeaderBar ();
            titlebar.show_close_button = true;
            var titlebar_style_context = titlebar.get_style_context ();
            titlebar_style_context.add_class ("tt-toolbar");
            this.set_titlebar (titlebar);

            var new_button = new Gtk.Button ();
            new_button.set_image (new Gtk.Image.from_icon_name ("document-new", Gtk.IconSize.LARGE_TOOLBAR));
            new_button.has_tooltip = true;
            new_button.tooltip_text = (_("New timetable"));

            new_button.clicked.connect (() => {
                //
            });

            titlebar.pack_start (new_button);

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
            grid.attach (tuesday_column, 4, 0, 1, 1);
            grid.attach (wednesday_column, 7, 0, 1, 1);
            grid.attach (thursday_column, 10, 0, 1, 1);
            grid.attach (friday_column, 13, 0, 1, 1);
            grid.show_all ();
            this.add (grid);

            this.show_all ();

            var settings = AppSettings.get_default ();
            int x = settings.window_x;
            int y = settings.window_y;
            if (x != -1 && y != -1) {
                move (x, y);
            }
        }

        public override bool delete_event (Gdk.EventAny event) {
            var settings = AppSettings.get_default ();
            int x, y;
            get_position (out x, out y);
            settings.window_x = x;
            settings.window_y = y;
            return false;
        }
    }
}
