#!/bin/bash

dumpe2fs $(mount | grep "on \/ ") | grep -i "Filesystem created"
