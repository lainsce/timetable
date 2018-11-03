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
        public MainWindow win;
        public Json.Builder builder;
        private string app_dir = Environment.get_user_cache_dir () + "/com.github.lainsce.timetable";
        private string file_name;

        public TaskManager (MainWindow win) {
            this.win = win;
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
            builder = new Json.Builder ();

            builder.begin_array ();
            save_column (builder, win.monday_column);
            save_column (builder, win.tuesday_column);
            save_column (builder, win.wednesday_column);
            save_column (builder, win.thursday_column);
            save_column (builder, win.friday_column);
            save_column (builder, win.saturday_column);
            save_column (builder, win.sunday_column);
            builder.end_array ();

            Json.Generator generator = new Json.Generator ();
            Json.Node root = builder.get_root ();
            generator.set_root (root);
            string str = generator.to_data (null);
            return str;
        }

        private static void save_column (Json.Builder builder, DayColumn column) {
	        builder.begin_array ();
	        foreach (var task in column.get_tasks ()) {
                builder.begin_array ();
		        builder.add_string_value (task.task_name);
                builder.add_string_value (task.color);
                builder.add_string_value (task.time_from_text);
                builder.add_string_value (task.time_to_text);
                builder.add_boolean_value (task.task_allday);
                builder.add_boolean_value (task.task_notify);
                builder.end_array ();
	        }
	        builder.end_array ();
        }

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
                    var monday_columns = array.get_array_element (0);
                    foreach (var tasks in monday_columns.get_elements()) {
                        var task = tasks.get_array ();
                        string task_name = task.get_string_element(0);
                        string color = task.get_string_element(1);
                        string time_from_text = task.get_string_element(2);
                        string time_to_text = task.get_string_element(3);
                        bool task_allday = task.get_boolean_element(4);
                        bool task_notify = task.get_boolean_element(5);

                        win.monday_column.add_task (task_name, color, time_from_text, time_to_text, task_allday, task_notify);
                    }

                    var tuesday_columns = array.get_array_element (1);
                    foreach (var tasks in tuesday_columns.get_elements()) {
                        var task = tasks.get_array();
                        string task_name = task.get_string_element(0);
                        string color = task.get_string_element(1);
                        string time_from_text = task.get_string_element(2);
                        string time_to_text = task.get_string_element(3);
                        bool task_allday = task.get_boolean_element(4);
                        bool task_notify = task.get_boolean_element(5);

                        win.tuesday_column.add_task (task_name, color, time_from_text, time_to_text, task_allday, task_notify);
                    }

                    var wednesday_columns = array.get_array_element (2);
                    foreach (var tasks in wednesday_columns.get_elements()) {
                        var task = tasks.get_array();
                        string task_name = task.get_string_element(0);
                        string color = task.get_string_element(1);
                        string time_from_text = task.get_string_element(2);
                        string time_to_text = task.get_string_element(3);
                        bool task_allday = task.get_boolean_element(4);
                        bool task_notify = task.get_boolean_element(5);

                        win.wednesday_column.add_task (task_name, color, time_from_text, time_to_text, task_allday, task_notify);
                    }

                    var thursday_columns = array.get_array_element (3);
                    foreach (var tasks in thursday_columns.get_elements()) {
                        var task = tasks.get_array();
                        string task_name = task.get_string_element(0);
                        string color = task.get_string_element(1);
                        string time_from_text = task.get_string_element(2);
                        string time_to_text = task.get_string_element(3);
                        bool task_allday = task.get_boolean_element(4);
                        bool task_notify = task.get_boolean_element(5);

                        win.thursday_column.add_task (task_name, color, time_from_text, time_to_text, task_allday, task_notify);
                    }

                    var friday_columns = array.get_array_element (4);
                    foreach (var tasks in friday_columns.get_elements()) {
                        var task = tasks.get_array();
                        string task_name = task.get_string_element(0);
                        string color = task.get_string_element(1);
                        string time_from_text = task.get_string_element(2);
                        string time_to_text = task.get_string_element(3);
                        bool task_allday = task.get_boolean_element(4);
                        bool task_notify = task.get_boolean_element(5);

                        win.friday_column.add_task (task_name, color, time_from_text, time_to_text, task_allday, task_notify);
                    }
                    var saturday_columns = array.get_array_element (5);
                    foreach (var tasks in saturday_columns.get_elements()) {
                        var task = tasks.get_array();
                        string task_name = task.get_string_element(0);
                        string color = task.get_string_element(1);
                        string time_from_text = task.get_string_element(2);
                        string time_to_text = task.get_string_element(3);
                        bool task_allday = task.get_boolean_element(4);
                        bool task_notify = task.get_boolean_element(5);

                        win.saturday_column.add_task (task_name, color, time_from_text, time_to_text, task_allday, task_notify);
                    }

                    var sunday_columns = array.get_array_element (6);
                    foreach (var tasks in sunday_columns.get_elements()) {
                        var task = tasks.get_array();
                        string task_name = task.get_string_element(0);
                        string color = task.get_string_element(1);
                        string time_from_text = task.get_string_element(2);
                        string time_to_text = task.get_string_element(3);
                        bool task_allday = task.get_boolean_element(4);
                        bool task_notify = task.get_boolean_element(5);

                        win.sunday_column.add_task (task_name, color, time_from_text, time_to_text, task_allday, task_notify);
                    }
                }
            } catch (Error e) {
                warning ("Failed to load file: %s\n", e.message);
            }
        }
    }
}
