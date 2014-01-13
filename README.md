# redmine_holidays

Holidays plugin for Redmine 2.2.x.

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

Once Redmine has restarted, login to Redmine as admin and set the permissions from *Administration* -> *Roles and Permissions*.
There will be a new Holidays permission. Set the permissions as required.

A new module *Holidays* will appear in the project's module as well. However, it isn't used. So, you don't need to change any settings in your projects.

### Uninstallation

To remove the plugin, from the root of your installation directory do the following:
```
RAILS_ENV=production rake redmine:plugins:migrate NAME=redmine_holidays VERSION=0
rm -rf plugins/redmine_holidays


### Other Plugins

There are some holidays plugin available for Redmine
* [redmine_multi_calendar](https://github.com/ksfltd/redmine_multi_calendar)
For Redmine 1.4
* [redmine_multi_calendar](https://github.com/JostBaron/redmine_multi_calendar)
Fork of the above for Redmine 2.x
* [holidays](https://github.com/IceskYsl/holidays)
For Redmine 2.3.x
* [redmine_special_days](https://github.com/digitalnatives/redmine_special_days)
