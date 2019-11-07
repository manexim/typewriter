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

public class MainWindow : Gtk.ApplicationWindow {
    private Services.Settings settings;
    private Gtk.HeaderBar headerbar;
    private Controllers.TypewriterController typewriter;

    public MainWindow (Gtk.Application application) {
        this.application = application;

        settings = Services.Settings.get_default ();
        load_settings ();

        headerbar = new Gtk.HeaderBar ();
        headerbar.get_style_context ().add_class ("default-decoration");
        headerbar.show_close_button = true;

        set_titlebar (headerbar);
        title = Config.APP_NAME;

        typewriter = new Controllers.TypewriterController ();
        add (typewriter.view);

        typewriter.model.notify.connect (update);

        update ();

        key_press_event.connect ((e) => {
            uint keycode = e.hardware_keycode;
            if (match_keycode (Gdk.Key.F11, keycode)) {
                is_fullscreen = !is_fullscreen;
            }

            return false;
        });

        delete_event.connect (() => {
            save_settings ();
            typewriter.save ();

            return false;
        });
    }

    private void update () {
        headerbar.subtitle = "%u characters • %u words • %u min read".printf (
            typewriter.model.characters, typewriter.model.words, typewriter.model.read_time
        );
    }

    private void load_settings () {
        if (settings.window_fullscreen) {
            fullscreen ();
        }

        if (settings.window_maximized) {
            maximize ();
            set_default_size (settings.window_width, settings.window_height);
        } else {
            set_default_size (settings.window_width, settings.window_height);
        }

        if (settings.window_x < 0 || settings.window_y < 0 ) {
            window_position = Gtk.WindowPosition.CENTER;
        } else {
            move (settings.window_x, settings.window_y);
        }
    }

    private void save_settings () {
        settings.window_maximized = is_maximized;

        if (!(settings.window_maximized || settings.window_fullscreen)) {
            int x, y;
            get_position (out x, out y);
            settings.window_x = x;
            settings.window_y = y;

            int width, height;
            get_size (out width, out height);
            settings.window_width = width;
            settings.window_height = height;
        }
    }

    private bool match_keycode (int keyval, uint code) {
        Gdk.KeymapKey[] keys;
        Gdk.Keymap keymap = Gdk.Keymap.get_for_display (Gdk.Display.get_default ());
        if (keymap.get_entries_for_keyval (keyval, out keys)) {
            foreach (var key in keys) {
                if (code == key.keycode)
                    return true;
                }
            }

        return false;
    }

    private bool is_fullscreen {
        get {
            return settings.window_fullscreen;
        }
        set {
            settings.window_fullscreen = value;

            if (settings.window_fullscreen) {
                fullscreen ();
            } else {
                unfullscreen ();
            }
        }
    }
}
