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
    private Gtk.Label label;

    public TypewriterView (Models.Typewriter model) {
        this.model = model;

        var scrolled = new Gtk.ScrolledWindow (null, null);
        scrolled.expand = true;
        scrolled.get_style_context ().add_class (Gtk.STYLE_CLASS_VIEW);

        var editor = new Gtk.SourceView.with_buffer (model.buffer);
        editor.set_wrap_mode (Gtk.WrapMode.WORD);
        editor.margin = 40;
        scrolled.add (editor);

        label = new Gtk.Label ("");
        label.margin = 6;
        label.halign = Gtk.Align.END;

        attach (scrolled, 0, 0, 1, 1);
        attach (new Gtk.Separator (Gtk.Orientation.HORIZONTAL), 0, 1, 1, 1);
        attach (label, 0, 2, 1, 1);

        model.notify.connect (update);

        update ();
    }

    private void update () {
        label.label = "%u characters • %u words • %u min read".printf (
            model.characters, model.words, model.read_time
        );
    }
}
