project('com.github.manexim.typewriter', 'vala', 'c')

gtk_plus_3_dep = dependency('gtk+-3.0')
granite_dep = dependency('granite')
gtksourceview_dep = dependency('gtksourceview-3.0')


dependencies = [
    gtk_plus_3_dep,
    granite_dep,
    gtksourceview_dep
]

subdir('src')
subdir('data')

meson.add_install_script('meson/post_install.py')
