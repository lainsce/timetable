namespace Timetable {
    public class Dialog : Granite.MessageDialog {
        public Dialog (Gtk.Window parent) {
            Object (
                primary_text: _("Save Changes to the Timetable?"),
                secondary_text: _("If you don't save, changes will be lost forever."),
                image_icon: new ThemedIcon ("dialog-warning"),
                transient_for: parent,
                modal: true
            );
        }

        construct {
            var discard_button = new Gtk.Button.with_label (_("Don't Save"));
            add_action_widget (discard_button, Gtk.ResponseType.NO);
            var cancel_button = new Gtk.Button.with_label (_("Cancel"));
            add_action_widget (cancel_button, Gtk.ResponseType.CANCEL);
            var save_button = new Gtk.Button.with_label (_("Save"));
            save_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
            save_button.can_default = true;
            add_action_widget (save_button, Gtk.ResponseType.YES);

            set_default (save_button);
        }

        public File display_save_dialog () {
            var chooser = create_file_chooser (_("Export timetable to…"),
                    Gtk.FileChooserAction.SAVE);
            File file = null;

            if (chooser.run () == Gtk.ResponseType.ACCEPT)
                file = chooser.get_file ();

            chooser.destroy();
            return file;
        }

        public Gtk.FileChooserDialog create_file_chooser (string title,
                Gtk.FileChooserAction action) {
            var chooser = new Gtk.FileChooserDialog (title, this, action);

            chooser.add_button (_("_Cancel"), Gtk.ResponseType.CANCEL);
            if (action == Gtk.FileChooserAction.OPEN) {
                chooser.add_button (_("_Open"), Gtk.ResponseType.ACCEPT);
            } else if (action == Gtk.FileChooserAction.SAVE) {
                chooser.add_button (_("_Save"), Gtk.ResponseType.ACCEPT);
                chooser.set_do_overwrite_confirmation (true);
            }

            var filter1 = new Gtk.FileFilter ();
            filter1.set_filter_name (_("Org files"));
            filter1.add_pattern ("*.org");
            chooser.add_filter (filter1);

            var filter = new Gtk.FileFilter ();
            filter.set_filter_name (_("All files"));
            filter.add_pattern ("*");
            chooser.add_filter (filter);

            return chooser;
        }
    }
}
