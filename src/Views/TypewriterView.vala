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

public class Views.TypewriterView : Gtk.ScrolledWindow {
    private Models.Typewriter model;
    private Granite.Widgets.OverlayBar overlaybar;

    public TypewriterView (Models.Typewriter model) {
        this.model = model;

        var overlay = new Gtk.Overlay ();
        add (overlay);

        var editor = new Gtk.SourceView.with_buffer (model.buffer);
        editor.set_wrap_mode (Gtk.WrapMode.WORD);
        editor.top_margin = 40;
        editor.left_margin = 40;
        editor.right_margin = 40;
        editor.bottom_margin = 40;
        editor.auto_indent = true;
        overlay.add (editor);

        overlaybar = new Granite.Widgets.OverlayBar (overlay);

        model.notify.connect (update);

        update ();
    }

    private void update () {
        overlaybar.label = "%u characters • %u words • %u min read".printf (
            model.characters, model.words, model.read_time
        );
    }
}
