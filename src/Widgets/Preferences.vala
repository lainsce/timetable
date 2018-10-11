/*
* Copyright (c) 2017 Lains
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
    public class Preferences : Gtk.Dialog {
        public Preferences (Gtk.Window? parent) {
            Object (
                border_width: 6,
                deletable: false,
                resizable: false,
                title: _("Preferences"),
                transient_for: parent,
                destroy_with_parent: true,
                window_position: Gtk.WindowPosition.CENTER_ON_PARENT
            );
        }

        construct {
            var main_stack = new Gtk.Stack ();
            main_stack.margin = 12;
            main_stack.margin_top = 0;
            main_stack.add (main_grid ());

            var close_button = add_button (_("Close"), Gtk.ResponseType.CLOSE);
            ((Gtk.Button) close_button).clicked.connect (() => destroy ());

            var grid = new Gtk.Grid ();
            grid.margin_top = 0;
            grid.attach (main_stack, 0, 1, 1, 1);

            ((Gtk.Container) get_content_area ()).add (grid);
        }

        private Gtk.Widget main_grid () {
            var settings = AppSettings.get_default ();
            var main_grid = new Gtk.Grid ();
            main_grid.orientation = Gtk.Orientation.VERTICAL;
            main_grid.row_spacing = 6;
            main_grid.column_spacing = 12;

            var main_header = new Granite.HeaderLabel (_("Work In Progress"));
            var geo_header = new Granite.HeaderLabel (_("Watch This Space"));

            main_grid.attach (main_header, 0, 1, 3, 1);
            main_grid.attach (geo_header, 0, 4, 3, 1);

            return main_grid;
        }

        private class SettingsLabel : Gtk.Label {
            public SettingsLabel (string text) {
                label = text;
                halign = Gtk.Align.END;
                margin_start = 12;
            }
        }

        private class SettingsSwitch : Gtk.Switch {
            public SettingsSwitch (string setting) {
                var settings = AppSettings.get_default ();
                halign = Gtk.Align.START;
                settings.schema.bind (setting, this, "active", SettingsBindFlags.DEFAULT);
            }
        }
    }
}
