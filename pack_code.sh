#!/bin/bash
rm -rf /tmp/notebook_export
cp -R /competition_ws/src/r2d2_competition/notebook /tmp/notebook_export
test -f /root/notebook_export.tar.bz2 && echo "\033[0;31m/root/notebook_export.tar.bz2 already exists, not overwriting it\033[0m" || echo "\033[0;32mGenerating /root/notebook_export.tar.bz2\033[0m"
test -f root/notebook_export.tar.bz2 || tar -C /tmp --exclude=.ipynb_checkpoints --exclude=nohup.out -jcf /root/notebook_export.tar.bz2 notebook_export
rm -rf /tmp/notebook_export
