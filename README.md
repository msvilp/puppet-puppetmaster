# puppet-puppetmaster

This is a Puppet module and [Kafo](https://github.com/theforeman/kafo) installer for setting up:

* Puppetserver
* Puppetserver with PuppetDB
* Puppetserver with PuppetDB and [Puppetboard](https://github.com/voxpupuli/puppetboard)
* Puppetserver with [Foreman Smart Proxy](https://github.com/theforeman/smart-proxy)
* Puppetserver with [Foreman Smart Proxy](https://github.com/theforeman/smart-proxy) and [Foreman](https://github.com/theforeman/foreman)

Each of the above is a separate Kafo installer scenario. This installer works on CentOS 7, Debian 9, Ubuntu 16.04 and Ubuntu 18.04. However, the Foreman scenarios are only supported on CentOS 7.

# Setup

To run the installer outside of Vagrant do 

* Install Puppet 5 from Puppetlabs
* Install rubygems from system packages using apt or yum
* Install Kafo's dependencies using /opt/puppetlabs/puppet/bin/gem
    * ```$ /opt/puppetlabs/puppet/bin/gem install yard puppet-strings kafo rdoc```
* Ensure that executables under /opt/puppetlabs are in PATH. You can do this with a shell profile fragment (e.g. /etc/profile.d/puppetmaster-installer.sh) that has the following content:
    * ```export PATH=/opt/puppetlabs/bin:/opt/puppetlabs/puppet/bin:/usr/share/puppetmaster-installer/bin:$PATH```
* Run the above export command in the currently active terminal, or logout and log back in

If you using the release Debian/RPM packages then this is all you need to do.

If you're using the Git version of this installer, then additional setup is needed. First ensure that /usr/share/puppetmaster is present by creating a symbolic link. For example:

    $ sudo -i
    $ ln -s /home/joe/puppet-puppetmaster /usr/share/puppetmaster

Then you need to fetch the Puppet modules this installer depends on:

    $ /opt/puppetlabs/puppet/bin/gem install librarian-puppet
    $ cd /usr/share/puppetmaster
    $ librarian-puppet install --verbose

Finally you need to ensure that the puppetmaster module is visible to the Kafo installer:

    $ cd /usr/share/puppetmaster/modules
    $ ln -s /usr/share/puppetmaster /usr/share/puppetmaster/modules/puppetmaster

These extra steps can be omitted when running the Vagrant boxes as the provisioning steps handle all of them automatically. The provisioning scripts are in general a good reference for what this installer needs to work properly.

Also note that as Foreman and Smart Proxies communicate via TLS you will need to ensure that their names resolve correctly before running the installer. The best way to do this is to have records for them in DNS, but using /etc/hosts is also an option.

# Usage

To run the installer from the installer directory:

    $ sudo -i
    $ bin/puppetmaster-installer -i

The "-i" switch to sudo ensures that the environment is root's environment, which is particularly important on Ubuntu and Debian. The -i switch to the installer makes it run in interactive mode, which is probably what you want to do.

You can run the installer automatically like this:

    $ sudo -i
    $ /usr/share/puppetmaster-installer/bin/puppetmaster-installer\
     --scenario puppetserver-with-puppetboard\
     --puppetmaster-puppetboard-puppetdb-database-password='pass'\
     --puppetmaster-puppetboard-timezone='Europe/Helsinki'

When using Vagrant you can automate puppetserver setup during provisioning as
well. To do this you need to modify two config files:

* config/automated_install.conf (basic settings)
* config/installer-scenarios.d/automated_install_answers.yaml (installer settings)

Make sure that you change the default passwords in the answer file.

If you change the scenario from the default (puppetserver-with-puppetboard) make
sure that your answer file matches the scenario. You can create a matching
answer file by removing config/installer-scenarios.d/last_scenario.yaml (if
present), launching the installer interactively in a Vagrant VM, selecting the
desired scenario, setting the parameters and launching the installer. Once the
installer is running, the contents of that scenario's answer file will match
what you selected. You can then copy that answer file to
automated_install_answers.yaml. Alternatively you can use "Display current
config" output as the content of the answer file. However, you then need to
replace the first underscore ("\_") with "::" because the kafo installer does
module mapping. In either case make sure you have defined the passwords in the
answer file or installation will fail immediately.

Then, in the root of the repository, run

    $ sudo -i
    $ bin/puppetmaster-install.sh

Vagrant will automatically copy your r10k deployment key and eyaml keys to
correct locations if they are placed under keys directory in the repository
root:

 * private_key.pkcs7.pem (eyaml private key)
 * public_key.pkcs7.pem (eyaml public key)
 * r10k_key (r10k deployment key)

# Development

## Testing with Vagrant

This repository makes heavy use of Vagrant and Virtualbox for testing. You will
need to use a fairly up-to-date Vagrant or you will run into networking issue
with the Ubuntu boxes. We recommend using Vagrant 2.1.5 or later.

It is possible to run installer at the end of provisioning. This feature is
primarily designed for Vagrant-based testing. To automatically setup a
puppetserver with your desired answers first copy your answer file to
config/installer-scenarios.d and run the installer like this:

    RUN_INSTALLER=true SCENARIO=puppetserver vagrant up puppetserver-bionic

The answer file needs to match the scenario you chose. See [vagrant/run_vagrant_tests.sh](vagrant/run_vagrant_tests.sh)
to see how this feature is utilized to automate regression testing.

Alternatively you can use installer's command-line parameters to define your
answers.

## Creating deb/rpm packages

Creating Debian and RPM packages is straightforward with the Debian 9 -based packager VM:

    $ vagrant up packager
    $ vagrant ssh packager
    $ cd /home/ubuntu/puppetmaster-installer/packaging
    $ ./package.sh

When upgrading package to new version the following Git spell will show which
files have been added, modified or deleted since the last release:

    $ git show --pretty="" --name-status <start-commit>...HEAD|sort|uniq

This helps avoid leaving critical files out of the packages.

## Living with changes Kafo makes to versioned answer files

Kafo installers have a nasty habit of modifying answer files which are versioned 
by Git. To prevent these local answer file modifications from getting committed 
by accident you can use a command like this:

    $ find config -name "*-answers.yaml"|xargs git update-index --assume-unchanged

# LICENSE

This project uses the two-clause BSD license. See [LICENSE](LICENSE) for details.
