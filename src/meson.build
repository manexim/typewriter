config_data = configuration_data()
config_data.set_quoted('LOCALEDIR', get_option('prefix') / get_option('localedir'))
config_data.set_quoted('GETTEXT_PACKAGE', meson.project_name())
config_file = configure_file(
    input: 'Config.vala.in',
    output: '@BASENAME@',
    configuration: config_data
)

sources = [
    'Config/Constants.vala',
    'Controllers/TypewriterController.vala',
    'Models/Font.vala',
    'Models/Typewriter.vala',
    'Services/Settings.vala',
    'Views/TypewriterView.vala',
    'MainWindow.vala'
]

executable(
    meson.project_name(),
    sources + ['Application.vala'],
    config_file,
    dependencies: dependencies,
    install: true
)
