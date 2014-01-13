# holidays

This is a holidays plugin for Redmine 2.2.x.

## Installation

To install the plugin, execute the following commands from the root of your Redmine directory:

```
cd plugins
git clone git@github.com:hshield/redmine_holidays.git
```

and then execute the following commands from the root of your Redmine directory:

```
$ RAILS_ENV=production rake redmine:plugins:migrate
```	

More information on installing Redmine plugins can be found at [redmine.org](http://www.redmine.org/wiki/redmine/Plugins.).

After the plugin is installed you will need to restart Redmine for the plugin to be available.

### Uninstallation

To remove the plugin, from the root of your installation directory do the following:
```
ice@mac:/source/redmine/redmine-2.3 > RAILS_ENV=production rake redmine:plugins:migrate NAME=redmine_holidays VERSION=0
rm -rf plugins/holidays


