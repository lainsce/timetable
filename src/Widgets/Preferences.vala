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
        public TaskBox taskbox;
        public MainWindow win;
        public Preferences (MainWindow win) {
            Object (
                border_width: 6,
                deletable: false,
                resizable: false,
                title: _("Preferences"),
                transient_for: win,
                destroy_with_parent: true,
                window_position: Gtk.WindowPosition.CENTER_ON_PARENT
            );
            this.win = win;
        }

        construct {
            var settings = AppSettings.get_default ();
            var main_grid = new Gtk.Grid ();
            main_grid.orientation = Gtk.Orientation.VERTICAL;
            main_grid.row_spacing = 6;
            main_grid.column_spacing = 12;

            var interface_header = new Granite.HeaderLabel (_("Interface"));
            var weekend_label = new SettingsLabel (_("Show weekends:"));
            weekend_label.set_halign (Gtk.Align.END);
            var weekend = new SettingsSwitch ("weekend-show");

            var tasks_header = new Granite.HeaderLabel (_("Tasks"));
            var high_contrast_label = new SettingsLabel (_("High contrast colors:"));
            high_contrast_label.set_halign (Gtk.Align.END);
            var high_contrast = new SettingsSwitch ("high-contrast");

            var show_tasks_allday_label = new SettingsLabel (_("Differentiate All-Day Tasks:"));
            show_tasks_allday_label.set_halign (Gtk.Align.END);
            var show_tasks_allday = new SettingsSwitch ("show-tasks-allday");

            var theme_label = new SettingsLabel (_("Tasks Theming:"));
            var theme_type = new Gtk.ComboBoxText();
            theme_type.append_text(_("elementary"));
            theme_type.append_text(_("Flat"));
            theme_type.append_text(_("Nature"));
            switch (settings.theme) {
                case 0:
                    theme_type.set_active(0);
                    break;
                case 1:
                    theme_type.set_active(1);
                    break;
                case 2:
                    theme_type.set_active(2);
                    break;
                default:
                    theme_type.set_active(0);
                    break;
            }

            theme_type.changed.connect (() => {
                switch (theme_type.get_active ()) {
                    case 0:
                        settings.theme = 0;
                        break;
                    case 1:
                        settings.theme = 1;
                        break;
                    case 2:
                        settings.theme = 2;
                        break;
                    default:
                        settings.theme = 0;
                        break;
                }
            });

            main_grid.attach (interface_header, 0, 1, 3, 1);
            main_grid.attach (weekend_label, 0, 2, 1, 1);
            main_grid.attach (weekend, 1, 2, 1, 1);
            main_grid.attach (tasks_header, 0, 3, 3, 1);
            main_grid.attach (high_contrast_label, 0, 4, 1, 1);
            main_grid.attach (high_contrast, 1, 4, 1, 1);
            main_grid.attach (show_tasks_allday_label, 0, 5, 1, 1);
            main_grid.attach (show_tasks_allday, 1, 5, 1, 1);
            main_grid.attach (theme_label, 0, 6, 1, 1);
            main_grid.attach (theme_type, 1, 6, 1, 1);

            var main_stack = new Gtk.Stack ();
            main_stack.margin = 12;
            main_stack.margin_top = 0;
            main_stack.add (main_grid);

            var close_button = add_button (_("Close"), Gtk.ResponseType.CLOSE);
            ((Gtk.Button) close_button).clicked.connect (() => destroy ());

            var grid = new Gtk.Grid ();
            grid.margin_top = 0;
            grid.attach (main_stack, 0, 1, 1, 1);

            ((Gtk.Container) get_content_area ()).add (grid);
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
