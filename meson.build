project('com.github.manexim.typewriter', 'vala', 'c', version: '0.6.0')

# Include the translations module
i18n = import('i18n')

# Set our translation domain
add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format (meson.project_name()), language:'c')

gtk_plus_3_dep = dependency('gtk+-3.0')
granite_dep = dependency('granite')
gtksourceview_dep = dependency('gtksourceview-4')
libhandy_dep = dependency('libhandy-1', version: '>=1.0.0')

dependencies = [
    gtk_plus_3_dep,
    granite_dep,
    gtksourceview_dep,
    libhandy_dep,
]

subdir('src')
subdir('data')
subdir('po')

meson.add_install_script('meson/post_install.py')
