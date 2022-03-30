## Color profile authentication problem
Create `/etc/polkit-1/localauthority/50-local.d/color.pkla` by `sudo gedit` (note: .pkla extension is required) with the following contents:
```bash
[Allow color for all users]
Identity=unix-user:*
Action=org.freedesktop.color-manager.create-device;org.freedesktop.color-manager.create-profile;org.freedesktop.color-manager.delete-device;org.freedesktop.color-manager.delete-profile;org.freedesktop.color-manager.modify-device;org.freedesktop.color-manager.modify-profile
ResultAny=yes
ResultInactive=yes
ResultActive=yes
```

## Solve "Authentication required to refresh system repositories"
Create `/etc/polkit-1/localauthority/50-local.d/46-allow-update-repo.pkla` with following content
```bash
[Allow Package Management all Users]
Identity=unix-user:*
Action=org.freedesktop.packagekit.system-sources-refresh
ResultAny=yes
ResultInactive=yes
ResultActive=yes
```
To learn more about it visit this [link](https://c-nergy.be/blog/?p=14051)

## Wifi, network, etc authentication problem
Create `/etc/polkit-1/localauthority/50-local.d/10-network-manager.pkla` with following content

```bash
[Allow network manager]
Identity=unix-user:*
Action=org.freedesktop.NetworkManager.*
ResultAny=yes
ResultInactive=yes
ResultActive=yes
```
Then restart the sevice
```bash
service network-manager restart
```

## Authentication required during usb mount unmount
Create `/etc/polkit-1/localauthority/50-local.d/allow_all_users_to_mount_usb.pkla` with following content:
```bash
[Storage Permissions]
Identity=unix-group:*
Action=org.freedesktop.udisks*
ResultAny=yes
ResultActive=yes
ResultInactive=yes
```
## Authentication required during shutdown
Create `/etc/polkit-1/localauthority/50-local.d/allow_all_users_to_shutdown.pkla` with following content:
```bash
[Allow all users to shutdown]
Identity=unix-user:*
Action=org.freedesktop.consolekit.system.stop-multiple-users
ResultInactive=no
ResultActive=yes
```

## Authentication required to restart the pc
Create `/etc/polkit-1/localauthority/50-local.d/allow_all_users_to_restart.pkla` with following content:
```bash
[Allow all users to restart]
Identity=unix-user:*
Action=org.freedesktop.consolekit.system.restart-multiple-users
ResultInactive=no
ResultActive=yes
```






