# backup

Backup scripts.

## Clean & Load & Archive

Do `all`:

```sh
sudo make
```

Each step explicitly:

```sh
make clean
sudo make load
make archive
```

## Copy to cloud or fileserver

E.g. cloud:

```sh
rclone copy -P ./backup_* gdrive.klephron:backups/devices/$(hostname)
```
