# Project name, programming language and version
project (
    'com.github.sergius02.qrit',
    'vala', 'c',
    version: '1.1.3'
)

# Translation module
i18n = import ('i18n')
gnome = import ('gnome')

# Project arguments
add_project_arguments (
    '-DGETTEXT_PACKAGE="@0@"'.format (meson.project_name ()),
    language: 'c'
)

config_data = configuration_data()
config_data.set_quoted('LOCALEDIR', join_paths(get_option('prefix'), get_option('localedir')))
config_data.set_quoted('GETTEXT_PACKAGE', meson.project_name())
config_file = configure_file(
    input: 'src/Config.vala.in',
    output: '@BASENAME@',
    configuration: config_data
)

# Listing dependencies
dependencies = [
    dependency ('glib-2.0'),
    dependency ('gtk+-3.0')
]

subdir ('src')
subdir ('resources')

# Executable
executable (
    meson.project_name (),
    sources,
    qrit_resources,
    config_file,
    dependencies: dependencies,
    install: true
)

subdir ('data')
subdir ('po')

meson.add_install_script ('meson/post_install.py')
