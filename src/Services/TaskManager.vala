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
    public class TaskManager {
        public MainWindow? win;
        public DayColumn dc;
        private string app_dir = Environment.get_user_cache_dir () + "/com.github.lainsce.timetable";
        private string file_name;

        public TaskManager () {
            file_name = this.app_dir + "/saved_tasks.json";
            debug ("%s".printf(file_name));
        }

        public void save_notes() {
            string json_string = prepare_json_from_notes();
            var dir = File.new_for_path(app_dir);
            var file = File.new_for_path (file_name);
            try {
                if (!dir.query_exists()) {
                    dir.make_directory();
                }
                if (file.query_exists ()) {
                    file.delete ();
                }
                var file_stream = file.create (FileCreateFlags.REPLACE_DESTINATION);
                var data_stream = new DataOutputStream (file_stream);
                data_stream.put_string(json_string);
            } catch (Error e) {
                warning ("Failed to save timetable: %s\n", e.message);
            }

        }

        private string prepare_json_from_notes () {
            Json.Builder builder = new Json.Builder ();

            var mon_tasks = win.monday_column.get_tasks ();
            builder.begin_array ();
            foreach (var task in mon_tasks) {
	            builder.add_string_value (task.name);
            }
            builder.end_array ();

            var tues_tasks = win.tuesday_column.get_tasks ();
            builder.begin_array ();
            foreach (var task in tues_tasks) {
	            builder.add_string_value (task.name);
            }
            builder.end_array ();

            var wednes_tasks = win.wednesday_column.get_tasks ();
            builder.begin_array ();
            foreach (var task in wednes_tasks) {
	            builder.add_string_value (task.name);
            }
            builder.end_array ();

            var thurs_tasks = win.thursday_column.get_tasks ();
            builder.begin_array ();
            foreach (var task in thurs_tasks) {
	            builder.add_string_value (task.name);
            }
            builder.end_array ();

            var fri_tasks = win.friday_column.get_tasks ();
            builder.begin_array ();
            foreach (var task in fri_tasks) {
	            builder.add_string_value (task.name);
            }
            builder.end_array ();

            Json.Generator generator = new Json.Generator ();
            Json.Node root = builder.get_root ();
            generator.set_root (root);
            string str = generator.to_data (null);
            return str;
        }

        /*
        public void load_from_file() {
            try {
                var file = File.new_for_path(file_name);
                var json_string = "";
                if (file.query_exists()) {
                    string line;
                    var dis = new DataInputStream (file.read ());
                    while ((line = dis.read_line (null)) != null) {
                        json_string += line;
                    }
                    var parser = new Json.Parser();
                    parser.load_from_data(json_string);
                    var root = parser.get_root();
                    var array = root.get_array();
                    foreach (var column in array.get_elements()) {
                        var tasks = column.get_object();
                        foreach (var task in tasks) {
                            string name = node.get_string_member("name");
                        }
                    }
                }
            } catch (Error e) {
                warning ("Failed to load file: %s\n", e.message);
            }
        }
        */
    }
}
