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

public class Models.Typewriter : Object {
    public Gtk.SourceBuffer buffer { get; construct set; }
    public uint characters { get; construct set; }
    public uint words { get; construct set; }
    public uint read_time { get; construct set; }

    public Typewriter () {
        buffer = new Gtk.SourceBuffer (null);

        Regex regex = null;
        try {
            regex = new Regex ("\\s+");
        } catch (RegexError e) {
            stderr.printf (e.message);
        }

        buffer.changed.connect (() => {
            try {
                if (regex != null) {
                    var text_stripped = regex.replace (buffer.text, buffer.text.length, 0, " ").strip ();

                    characters = text_stripped.length;
                    words = text_stripped.split (" ").length;
                    read_time = (uint) ((1.0 * words / Constants.WORDS_PER_MINUTE) + 0.5);
                }
            } catch (RegexError e) {
                stderr.printf (e.message);
            }
        });
    }

    public File directory {
        owned get {
            return File.new_build_filename (
                Environment.get_user_data_dir (),
                Constants.APP_ID
            );
        }
    }

    public File file {
        owned get {
            return File.new_build_filename (
                Environment.get_user_data_dir (),
                Constants.APP_ID,
                "autosave.md"
            );
        }
    }
}
