<div align="center">
  <span align="center"> <img width="80" height="80" class="center" src="data/icons/128/com.github.manexim.typewriter.svg" alt="Icon"></span>
  <h1 align="center">Typewriter</h1>
  <h3 align="center">A minimal writer with autosave</h3>
  <p align="center">Designed for <a href="https://elementary.io">elementary OS</a></p>
</div>

<p align="center">
  <a href="https://travis-ci.org/manexim/typewriter">
    <img src="https://img.shields.io/travis/manexim/typewriter.svg">
  </a>
  <a href="https://github.com/manexim/typewriter/releases/">
    <img src="https://img.shields.io/github/release/manexim/typewriter.svg">
  </a>
  <a href="https://github.com/manexim/typewriter/blob/master/COPYING">
    <img src="https://img.shields.io/github/license/manexim/typewriter.svg">
  </a>
</p>

<p align="center">
  <img src="data/screenshots/000.png">
</p>

## Installation

### Dependencies

These dependencies must be present before building:

-   `elementary-sdk`
-   `meson (>=0.40)`
-   `valac (>=0.40)`
-   `libgtk-3-dev`
-   `libgranite-dev`
-   `libgtksourceview-3.0-dev`

### Building

```
git clone https://github.com/manexim/typewriter.git && cd typewriter
meson build && cd build
meson configure -Dprefix=/usr
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

| Name                                        | Language  |
| ------------------------------------------- | --------- |
| [NathanBnm](https://github.com/NathanBnm)   | French 🇫🇷 |
| [meisenzahl](https://github.com/meisenzahl) | German 🇩🇪 |

## License

This project is licensed under the GNU General Public License v3.0 - see the [COPYING](COPYING) file for details.
