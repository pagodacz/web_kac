#!/bin/sh

git push
ssh j2m 'cd WWW/web_kac ; git pull'
