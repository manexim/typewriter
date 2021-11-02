<div align="center">
  <span align="center"> <img width="80" height="80" class="center" src="data/icons/128/com.github.manexim.typewriter.svg" alt="Icon"></span>
  <h1 align="center">Typewriter</h1>
  <h3 align="center">A minimal writer with autosave</h3>
  <p align="center">Designed for <a href="https://elementary.io">elementary OS</a></p>
</div>

<p align="center">
  <a href="https://appcenter.elementary.io/com.github.manexim.typewriter" target="_blank">
    <img src="https://appcenter.elementary.io/badge.svg">
  </a>
</p>

<p align="center">
  <a href="https://github.com/manexim/typewriter/actions/workflows/main.yml">
    <img src="https://github.com/manexim/typewriter/workflows/CI/badge.svg">
  </a>
  <a href="https://github.com/manexim/typewriter/releases/">
    <img src="https://img.shields.io/github/release/manexim/typewriter.svg">
  </a>
  <a href="https://github.com/manexim/typewriter/blob/master/COPYING">
    <img src="https://img.shields.io/github/license/manexim/typewriter.svg">
  </a>
</p>

<p align="center">
  <table>
    <tr>
      <td>
        <img src="data/screenshots/000.png">
      </td>
      <td>
        <img src="data/screenshots/000-dark.png">
      </td>
    </tr>
    <tr>
      <td>
        <img src="data/screenshots/001.png">
      </td>
      <td>
        <img src="data/screenshots/001-dark.png">
      </td>
    </tr>
    <tr>
      <td>
        <img src="data/screenshots/002.png">
      </td>
      <td>
        <img src="data/screenshots/002-dark.png">
      </td>
    </tr>
  </table>
</p>

## Installation

### Dependencies

These dependencies must be present before building:

-   `libgranite-dev`
-   `libgtk-3-dev`
-   `libgtksourceview-3.0-dev`
-   `libhandy-1-dev` >=1.0.0
-   `meson`
-   `valac`

### Building

```
git clone https://github.com/manexim/typewriter.git && cd typewriter
meson build --prefix=/usr
cd build
ninja
sudo ninja install
com.github.manexim.typewriter
```

### Deconstruct

```
sudo ninja uninstall
```

## Contributing

If you want to contribute to typewriter and make it better, your help is very welcome.

### How to make a clean pull request

-   Create a personal fork of this project on GitHub.
-   Clone the fork on your local machine. Your remote repo on GitHub is called `origin`.
-   Create a new branch to work on. Branch from `master`!
-   Implement/fix your feature.
-   Push your branch to your fork on GitHub, the remote `origin`.
-   From your fork open a pull request in the correct branch. Target the `master` branch!

And last but not least: Always write your commit messages in the present tense.
Your commit message should describe what the commit, when applied, does to the code – not what you did to the code.

## Special thanks

### Translators

| Name                                            | Language   |
| ----------------------------------------------- | ---------- |
| [NathanBnm](https://github.com/NathanBnm)       | French 🇫🇷  |
| [meisenzahl](https://github.com/meisenzahl)     | German 🇩🇪  |
| [mirkobrombin](https://github.com/mirkobrombin) | Italian 🇮🇹 |
| [onerbs](https://github.com/onerbs)             | Spanish 🇪🇸 |
| [Vistaus](https://github.com/Vistaus)           | Dutch 🇳🇱   |
| [logdimov](https://github.com/logdimov)         | Russian 🇷🇺 |
| [milotype](https://github.com/milotype)         | Croatian 🇭🇷 |

## License

This project is licensed under the GNU General Public License v3.0 - see the [COPYING](COPYING) file for details.
