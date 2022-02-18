#!/bin/sh

VOLUME_NAME=named-volume
DUMMY_CONTAINER_NAME=dummy

docker run --shm-size 1G --rm -v $VOLUME_NAME:/screenshots:rw nailbiter/puppeteer pdf_screenshot 'https://www.jma.go.jp/bosai/forecast/' 800x600 2000
docker run -d --rm --name $DUMMY_CONTAINER_NAME -v $VOLUME_NAME:/root alpine tail -f /dev/null
docker cp $DUMMY_CONTAINER_NAME:/root/screenshot_800_600.pdf pdfs/screencap-`date "+%Y-%m-%d-%H-%M"`.pdf
docker stop dummy
ls pdfs
