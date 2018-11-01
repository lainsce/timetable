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
*
*/

/**
 * PopoverDialog is an elementary OS styled dialog used to display a message to the user in a popover.
 *
 * The class itself is similar to it's Granite equivalent {@link Granite.MessageDialog}, only that it presents itself linked to an action button, and has custom buttons that one can add custom actions and styling to.
 *
 * See [[https://elementary.io/docs/human-interface-guidelines#dialogs|The Human Interface Guidelines for dialogs]]
 * for more detailed disscussion on the dialog wording and design.
 *
 * ''Example''<<BR>>
 * {{{
 *   var delete_popover = new Granite.PopoverDialog.with_image_from_icon_name (
 *      "This is a primary text",
 *      "",
 *      "Cancel",
 *      "Delete",
 *      "applications-development"
 *  );
 *  delete_popover.primary_button.get_style_context ().add_class (Gtk.STYLE_CLASS_DESTRUCTIVE_ACTION);
 *  delete_popover.primary_button.clicked.connect (() => {
 *      Actions for this button
 *  });
 *  delete_popover.secondary_button.clicked.connect (() => {
 *      Actions for this button
 *  });
 * }}}
 */
public class Granite.PopoverDialog : Gtk.Popover {
    /**
     * The primary text, title of the dialog.
     */
    public string primary_text {
        get {
            return primary_label.label;
        }

        set {
            primary_label.label = value;
        }
    }

    /**
     * The secondary text, body of the dialog.
     */
    public string secondary_text {
        get {
            return secondary_label.label;
        }

        set {
            secondary_label.label = value;
        }
    }

    /**
     * The primary button text, for the primary action of the dialog.
     */
    public string primary_button_text {
        get {
            return primary_button.label;
        }

        set {
            primary_button.label = value;
        }
    }

    /**
     * The secondary button text, for the secondary action of the dialog.
     */
    public string secondary_button_text {
        get {
            return secondary_button.label;
        }

        set {
            secondary_button.label = value;
        }
    }

    /**
     * The {@link GLib.Icon} that is used to display the image
     * on the left side of the dialog.
     */
    public GLib.Icon icon {
        owned get {
            return popover_icon.gicon;
        }

        set {
            popover_icon.set_from_gicon (value, Gtk.IconSize.DIALOG);
        }
    }

    /**
     * The {@link Gtk.Label} that displays the {@link Granite.PopoverDialog.primary_text}.
     *
     * Most of the times, you will only want to modify the {@link Granite.PopoverDialog.primary_text} string,
     * this is available to set additional properites like {@link Gtk.Label.use_markup} if you wish to do so.
     */
    public Gtk.Label primary_label { get; construct; }

    /**
     * The {@link Gtk.Label} that displays the {@link Granite.PopoverDialog.secondary_text}.
     *
     * Most of the times, you will only want to modify the {@link Granite.PopoverDialog.secondary_text} string,
     * this is available to set additional properites like {@link Gtk.Label.use_markup} if you wish to do so.
     */
    public Gtk.Label secondary_label { get; construct; }

    /**
     * The {@link Gtk.Label} that displays the {@link Granite.PopoverDialog.primary_button_text}.
     *
     * Most of the times, you will only want to modify the {@link Granite.PopoverDialog.primary_button_text} string.
     */
    public Gtk.Button primary_button { get; set; }

    /**
     * The {@link Gtk.Label} that displays the {@link Granite.PopoverDialog.secondary_button_text}.
     *
     * Most of the times, you will only want to modify the {@link Granite.PopoverDialog.secondary_button_text} string.
     */
    public Gtk.Button secondary_button  { get; set; }

    /**
     * The image that's displayed in the dialog.
     */
    public Gtk.Image popover_icon { get; set; }

    /**
     * Constructs a new {@link Granite.PopoverDialog} with an icon name as it's icon displayed in the image.
     * This constructor is same as {@link Granite.MessageDialog}, but with a way of pointing to an action or button in the user interface.
     *
     * The {@link Granite.PopoverDialog.icon} will store the created icon
     * so you can retrieve it later with {@link GLib.Icon.to_string}.
     *
     * See {@link Gtk.Dialog} for more details.
     *
     * @param primary_text the title of the dialog
     * @param secondary_text the body of the dialog
     * @param primary_button_text the first button text
     * @param secondary_button_text the second button text
     * @param icon the icon name to create the dialog image with
     */
    public PopoverDialog.with_image_from_icon_name (string primary_text, string secondary_text, string primary_button_text, string secondary_button_text, string icon) {
        Object (
            primary_text: primary_text,
            secondary_text: secondary_text,
            primary_button_text: primary_button_text,
            secondary_button_text: secondary_button_text,
            icon: new ThemedIcon (icon)
        );
    }

    construct {
        primary_label = new Gtk.Label (null);
        primary_label.get_style_context ().add_class (Granite.STYLE_CLASS_PRIMARY_LABEL);
        primary_label.use_markup = true;
        primary_label.selectable = true;
        primary_label.max_width_chars = 50;
        primary_label.wrap = true;
        primary_label.xalign = 0;

        secondary_label = new Gtk.Label (null);
        secondary_label.use_markup = true;
        secondary_label.selectable = true;
        secondary_label.max_width_chars = 50;
        secondary_label.wrap = true;
        secondary_label.xalign = 0;

        popover_icon = new Gtk.Image ();
        popover_icon.valign = Gtk.Align.START;

        secondary_button = new Gtk.Button ();
        secondary_button.set_can_focus (false);

        primary_button = new Gtk.Button ();
        primary_button.can_default = true;

        var options_button_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6);
        options_button_box.halign = Gtk.Align.END;
        options_button_box.margin_top = 12;
        options_button_box.pack_start (secondary_button, false, true, 0);
        options_button_box.pack_start (primary_button, false, true, 0);

        var delete_grid = new Gtk.Grid ();
        delete_grid.margin = 12;
        delete_grid.column_spacing = 12;
        delete_grid.row_spacing = 6;
        delete_grid.orientation = Gtk.Orientation.VERTICAL;
        delete_grid.attach (popover_icon, 0, 0, 1, 2);
        delete_grid.attach (primary_label, 1, 0, 1, 1);
        delete_grid.attach (secondary_label, 1, 1, 1, 1);
        delete_grid.attach (options_button_box, 1, 2, 1, 1);
        delete_grid.show_all ();

        this.add (delete_grid);
    }
}
