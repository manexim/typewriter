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

public class Models.Font : Object {
    private string _font;

    public string font {
        get {
            return _font;
        }
        set {
            _font = value;
        }
    }

    public string family {
        owned get {
            return font.substring (0, font.last_index_of (" "));
        }
        set {
            font = value + " " + size.to_string ();
        }
    }

    public int size {
        get {
            return int.parse (font.substring (font.last_index_of (" ") + 1));
        }
        set {
            font = family + " " + value.to_string ();
        }
    }
}
