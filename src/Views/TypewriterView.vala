/*
* Copyright (c) 2019 Manexim (https://github.com/manexim)
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
* Authored by: Marius Meisenzahl <mariusmeisenzahl@gmail.com>
*/

public class Views.TypewriterView : Gtk.Grid {
    private Models.Typewriter model;
    private Models.Font font;
    private Gtk.Label label;

    public TypewriterView (Models.Typewriter model) {
        this.model = model;
        font = Application.instance.font;

        var scrolled = new Gtk.ScrolledWindow (null, null) {
            expand = true
        };
        scrolled.get_style_context ().add_class (Gtk.STYLE_CLASS_VIEW);

        var editor = new Gtk.SourceView.with_buffer (model.buffer) {
            wrap_mode = Gtk.WrapMode.WORD,
            margin = 40
        };
        scrolled.add (editor);

        editor.map.connect (() => {
            editor.grab_focus ();
        });

        editor.override_font (Pango.FontDescription.from_string (font.font));
        font.notify.connect (() => {
            editor.override_font (Pango.FontDescription.from_string (font.font));
        });

        label = new Gtk.Label ("") {
            margin = 6,
            halign = Gtk.Align.END
        };

        attach (scrolled, 0, 0, 1, 1);
        attach (new Gtk.Separator (Gtk.Orientation.HORIZONTAL), 0, 1, 1, 1);
        attach (label, 0, 2, 1, 1);

        model.notify.connect (update);

        update ();
    }

    private void update () {
        label.label = "%s • %s • %s".printf (
            Strings.NUMBER_CHARACTERS.printf (model.characters),
            Strings.NUMBER_WORDS.printf (model.words),
            Strings.NUMBER_MIN_READ.printf (model.read_time)
        );
    }
}
