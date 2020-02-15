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

public class Application : Granite.Application {
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

        _default_font = new Models.Font ();
        _current_font = new Models.Font ();

        _default_font.font = new GLib.Settings ("org.gnome.desktop.interface").get_string ("font-name");
        _current_font.font = _default_font.font;
        _current_font.size = (int) (_default_font.size * settings.zoom / 100.0);

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
        window = new MainWindow (this);

        window.show_all ();
    }

    public static int main (string[] args) {
        var app = Application.instance;

        return app.run (args);
    }
}
