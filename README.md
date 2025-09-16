# backup

## Load backup to `backup/`

```sh
sudo make load
```

## Create archive from backup

```sh
make archive
```

## Copy to cloud or fileserver

E.g. cloud:

```sh
rclone copy -P ./backup_* gdrive.zubrailx:backups/devices/$(hostname)
```

## Clean backup and archives

```sh
make clean
```
