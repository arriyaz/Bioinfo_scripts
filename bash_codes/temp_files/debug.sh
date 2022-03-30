#!/bin/bash
set -xe
file_name="not/here"
ls $file_name
set +x
echo $file_name
echo "Hellow"
set -x
echo "finish"
