# selinux-module-installer
Makefile to compile and install SELinux modules.

Use `make all` to create a policy module (*.pp) for every *.te file in the current directory, then use `make install` to install every *.pp file in the current directory.

In order to work, the module filename must reflect the module name (e.g., the sqlite module should be named sqlite.te).
