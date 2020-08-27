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

    public Application app { get; construct; }

    public SimpleActionGroup actions { get; construct; }

    public const string ACTION_PREFIX = "win.";
    public const string ACTION_QUIT = "action-quit";
    public const string ACTION_FULLSCREEN = "action-fullscreen";
    public const string ACTION_ZOOM_OUT_FONT = "action-zoom-out-font";
    public const string ACTION_ZOOM_DEFAULT_FONT = "action-zoom-default-font";
    public const string ACTION_ZOOM_IN_FONT = "action-zoom-in-font";

    private static Gee.MultiMap<string, string> action_accelerators = new Gee.HashMultiMap<string, string> ();

    private const ActionEntry[] ACTION_ENTRIES = {
        { ACTION_QUIT, action_quit },
        { ACTION_FULLSCREEN, action_fullscreen },
        { ACTION_ZOOM_OUT_FONT, action_zoom_out_font },
        { ACTION_ZOOM_DEFAULT_FONT, action_zoom_default_font },
        { ACTION_ZOOM_IN_FONT, action_zoom_in_font }
    };

    public MainWindow (Application app) {
        Object (
            app: app
        );
    }

    static construct {
        action_accelerators[ACTION_QUIT] = "<Control>q";
        action_accelerators[ACTION_QUIT] = "<Control>w";
        action_accelerators[ACTION_FULLSCREEN] = "F11";
        action_accelerators[ACTION_ZOOM_OUT_FONT] = "<Control>minus";
        action_accelerators[ACTION_ZOOM_OUT_FONT] = "<Control>KP_Subtract";
        action_accelerators[ACTION_ZOOM_DEFAULT_FONT] = "<Control>0";
        action_accelerators[ACTION_ZOOM_DEFAULT_FONT] = "<Control>KP_0";
        action_accelerators[ACTION_ZOOM_IN_FONT] = "<Control>plus";
        action_accelerators[ACTION_ZOOM_IN_FONT] = "<Control>equal";
        action_accelerators[ACTION_ZOOM_IN_FONT] = "<Control>KP_Add";
    }

    construct {
        actions = new SimpleActionGroup ();
        actions.add_action_entries (ACTION_ENTRIES, this);
        insert_action_group ("win", actions);

        set_application (app);

        foreach (var action in action_accelerators.get_keys ()) {
            var accels_array = action_accelerators[action].to_array ();
            accels_array += null;

            app.set_accels_for_action (ACTION_PREFIX + action, accels_array);
        }

        get_style_context ().add_class ("rounded");

        settings = Services.Settings.get_default ();
        load_settings ();

        headerbar = new Gtk.HeaderBar () {
            show_close_button = true
        };
        headerbar.get_style_context ().add_class ("default-decoration");

        var zoom_out_button = new Gtk.Button.from_icon_name ("zoom-out-symbolic", Gtk.IconSize.MENU) {
            action_name = ACTION_PREFIX + ACTION_ZOOM_OUT_FONT,
            tooltip_markup = Granite.markup_accel_tooltip (
                application.get_accels_for_action (ACTION_PREFIX + ACTION_ZOOM_OUT_FONT),
                _("Zoom out")
            )
        };

        var zoom_default_button = new Gtk.Button.with_label ("%d%%".printf (settings.zoom)) {
            action_name = ACTION_PREFIX + ACTION_ZOOM_DEFAULT_FONT,
            tooltip_markup = Granite.markup_accel_tooltip (
                application.get_accels_for_action (ACTION_PREFIX + ACTION_ZOOM_DEFAULT_FONT),
                _("Default zoom level")
            )
        };

        settings.notify["zoom"].connect (() => {
            zoom_default_button.label = "%d%%".printf (settings.zoom);
        });

        var zoom_in_button = new Gtk.Button.from_icon_name ("zoom-in-symbolic", Gtk.IconSize.MENU) {
            action_name = ACTION_PREFIX + ACTION_ZOOM_IN_FONT,
            tooltip_markup = Granite.markup_accel_tooltip (
                application.get_accels_for_action (ACTION_PREFIX + ACTION_ZOOM_IN_FONT),
                _("Zoom in")
            )
        };

        var font_size_grid = new Gtk.Grid () {
            column_homogeneous = true,
            hexpand = true,
            margin = 12
        };
        font_size_grid.get_style_context ().add_class (Gtk.STYLE_CLASS_LINKED);
        font_size_grid.add (zoom_out_button);
        font_size_grid.add (zoom_default_button);
        font_size_grid.add (zoom_in_button);

        var menu_grid = new Gtk.Grid () {
            margin_bottom = 3,
            orientation = Gtk.Orientation.VERTICAL,
            width_request = 200
        };
        menu_grid.attach (font_size_grid, 0, 0, 3, 1);
        menu_grid.show_all ();

        var menu = new Gtk.Popover (null);
        menu.add (menu_grid);

        var app_menu = new Gtk.MenuButton () {
            image = new Gtk.Image.from_icon_name ("open-menu", Gtk.IconSize.LARGE_TOOLBAR),
            tooltip_text = _("Menu"),
            popover = menu
        };

        headerbar.pack_end (app_menu);

        set_titlebar (headerbar);
        title = Config.APP_NAME;

        typewriter = new Controllers.TypewriterController ();
        add (typewriter.view);

        typewriter.model.notify.connect (update);

        update ();

        delete_event.connect (() => {
            save_settings ();
            typewriter.save ();

            return false;
        });
    }

    private void update () {
        headerbar.subtitle = "%s • %s • %s".printf (
            _("%u characters").printf (typewriter.model.characters),
            _("%u words").printf (typewriter.model.words),
            _("%u min read").printf (typewriter.model.read_time)
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

    private void action_quit () {
        destroy ();
    }

    private void action_fullscreen () {
        is_fullscreen = !is_fullscreen;
    }

    private void action_zoom_out_font () {
        settings.zoom -= 10;
    }

    private void action_zoom_default_font () {
        settings.zoom = 100;
    }

    private void action_zoom_in_font () {
        settings.zoom += 10;
    }
}
