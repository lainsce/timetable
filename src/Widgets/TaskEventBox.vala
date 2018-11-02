namespace Timetable {
    public class TaskEventBox : Gtk.EventBox {
        public TaskBox tb;
        public Gtk.Button app_button;
        public Gtk.Button task_delete_button;
        public Gtk.Revealer revealer;

        public bool show_button = true;
        public signal void settings_requested ();
        public signal void delete_requested ();

        public TaskEventBox (TaskBox tb) {
            this.tb = tb;

            task_delete_button = new Gtk.Button();
            task_delete_button.events |= Gdk.EventMask.BUTTON_PRESS_MASK;
            var task_delete_button_context = task_delete_button.get_style_context ();
            task_delete_button_context.add_class (Gtk.STYLE_CLASS_FLAT);
            task_delete_button.has_tooltip = true;
            task_delete_button.vexpand = false;
            task_delete_button.valign = Gtk.Align.CENTER;
            task_delete_button.set_image (new Gtk.Image.from_icon_name ("edit-delete-symbolic", Gtk.IconSize.SMALL_TOOLBAR));
            task_delete_button.tooltip_text = (_("Delete Task"));

            app_button = new Gtk.Button();
            app_button.events |= Gdk.EventMask.BUTTON_PRESS_MASK;
            var app_button_context = app_button.get_style_context ();
            app_button_context.add_class (Gtk.STYLE_CLASS_FLAT);
            app_button.has_tooltip = true;
            app_button.vexpand = false;
            app_button.valign = Gtk.Align.CENTER;
            app_button.tooltip_text = (_("Task Settings"));
            app_button.image = new Gtk.Image.from_icon_name ("open-menu-symbolic", Gtk.IconSize.SMALL_TOOLBAR);

            var task_buttons_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6);
            task_buttons_box.events |= Gdk.EventMask.ENTER_NOTIFY_MASK & Gdk.EventMask.LEAVE_NOTIFY_MASK;
            task_buttons_box.pack_start (app_button, false, true, 0);
            task_buttons_box.pack_start (task_delete_button, false, true, 0);

            revealer = new Gtk.Revealer ();
            revealer.set_transition_duration (100);
            revealer.set_transition_type (Gtk.RevealerTransitionType.CROSSFADE);
            revealer.halign = Gtk.Align.START;
            revealer.add (task_buttons_box);

            this.add (revealer);

            this.events |= Gdk.EventMask.ENTER_NOTIFY_MASK & Gdk.EventMask.LEAVE_NOTIFY_MASK;

            task_delete_button.clicked.connect (() => {
                delete_requested ();
            });

            app_button.clicked.connect(() => {
                settings_requested ();
            });

            this.enter_notify_event.connect ((event) => {
                revealer.set_reveal_child (this.show_button);
                return false;
            });

            this.leave_notify_event.connect ((event) => {
                revealer.set_reveal_child (false);
                return false;
            });

            app_button.enter_notify_event.connect ((event) => {
                revealer.set_reveal_child (this.show_button);
                return false;
            });

            task_delete_button.enter_notify_event.connect ((event) => {
                revealer.set_reveal_child (this.show_button);
                return false;
            });
        }
    }
}
