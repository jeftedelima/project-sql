#!/bin/bash

mainDir=`pwd`

if [ $1 == 'start' ] ; then
    for dir in `ls $mainDir/projects` ; do
        echo "$mainDir/projects/$dir"
        cd "$mainDir/projects/$dir"
        ls
        docker-compose up -d
    done
elif [ $1 == 'stop' ] ; then
    for dir in `ls $mainDir/projects` ; do
        echo "$mainDir/projects/$dir"
        cd "$mainDir/projects/$dir"
        ls
        docker-compose down
    done
fi