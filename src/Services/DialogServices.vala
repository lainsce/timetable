namespace Timetable {
    public class Dialog : Gtk.MessageDialog {
        public Dialog.display_save_confirm (Gtk.Window parent) {
            set_markup ("<b>" +
                    _("There are unsaved changes to the timetable. Do you want to save?") + "</b>" +
                    "\n\n" + _("If you don't save, changes will be lost forever."));
            use_markup = true;
            type_hint = Gdk.WindowTypeHint.DIALOG;
            set_transient_for (parent);

            var button = new Gtk.Button.with_label (_("Don't Save"));
            button.show ();
            add_action_widget (button, Gtk.ResponseType.NO);
            add_button ("_Save", Gtk.ResponseType.YES);
            message_type = Gtk.MessageType.INFO;
        }
    }
}
