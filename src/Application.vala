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

public class Application : Gtk.Application {
    private static Application? _instance;
    private MainWindow window;
    private Models.Font _default_font;
    private Models.Font _current_font;
    private Services.Settings settings;

    public static Application instance {
        get {
            if (_instance == null) {
                _instance = new Application ();
            }

            return _instance;
        }
    }

    private Application () {
        Object (
            application_id: Config.APP_ID,
            flags: ApplicationFlags.FLAGS_NONE
        );

        settings = Services.Settings.get_default ();

        _default_font = new Models.Font () {
            font = new GLib.Settings ("org.gnome.desktop.interface").get_string ("font-name")
        };
        _current_font = new Models.Font () {
            font = _default_font.font,
            size = (int) (_default_font.size * settings.zoom / 100.0)
        };

        settings.notify["zoom"].connect (() => {
            font.size = (int) (_default_font.size * settings.zoom / 100.0);
        });
    }

    public Models.Font font {
        owned get {
            return _current_font;
        }
        set {
            _current_font = value;
        }
    }

    protected override void activate () {
        Intl.setlocale (LocaleCategory.ALL, "");
        GLib.Intl.bindtextdomain (GETTEXT_PACKAGE, LOCALEDIR);
        GLib.Intl.bind_textdomain_codeset (GETTEXT_PACKAGE, "UTF-8");
        GLib.Intl.textdomain (GETTEXT_PACKAGE);

        var granite_settings = Granite.Settings.get_default ();
        var gtk_settings = Gtk.Settings.get_default ();

        gtk_settings.gtk_application_prefer_dark_theme = (
            granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK
        );

        granite_settings.notify["prefers-color-scheme"].connect (() => {
            gtk_settings.gtk_application_prefer_dark_theme = (
                granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK
            );
        });

        window = new MainWindow (this);

        window.show_all ();
    }

    public static int main (string[] args) {
        var app = Application.instance;

        return app.run (args);
    }
}
