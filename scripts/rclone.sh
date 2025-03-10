#!/bin/bash

SCRIPT_DIR=$(dirname $0)
ALL_FILES=`find $SCRIPT_DIR -maxdepth 1 -mindepth 1`

TARGET_DIR=backup_`date +"%Y-%m-%d-%H:%M:%S"`

RCLONE_REMOTE=gdz
RCLONE_PATH=Backup/gentoo

TARGET_TMP_PATH=/tmp/$SCRIPT_DIR/$TARGET_DIR


mkdir -p $TARGET_TMP_PATH
cp -r $ALL_FILES $TARGET_TMP_PATH

cd /tmp/$SCRIPT_DIR

tar cf $TARGET_TMP_PATH.tar $TARGET_DIR

rclone copy -P $TARGET_TMP_PATH.tar $RCLONE_REMOTE:$RCLONE_PATH

rm -rf $TARGET_TMP_PATH $TARGET_TMP_PATH.tar
