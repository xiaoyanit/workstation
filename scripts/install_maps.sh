#!/bin/bash

mvn install:install-file -Dfile=$ANDROID_HOME/add-ons/addon_google_apis_google_inc_3/libs/maps.jar -DgroupId=com.google.android.maps -DartifactId=maps -Dversion=3_r3 -Dpackaging=jar

mvn install:install-file -Dfile=$ANDROID_HOME/add-ons/addon_google_apis_google_inc_4/libs/maps.jar -DgroupId=com.google.android.maps -DartifactId=maps -Dversion=4_r2 -Dpackaging=jar

mvn install:install-file -Dfile=$ANDROID_HOME/add-ons/addon_google_apis_google_inc_7/libs/maps.jar -DgroupId=com.google.android.maps -DartifactId=maps -Dversion=7_r1 -Dpackaging=jar

mvn install:install-file -Dfile=$ANDROID_HOME/add-ons/addon_google_apis_google_inc_8/libs/maps.jar -DgroupId=com.google.android.maps -DartifactId=maps -Dversion=8_r1 -Dpackaging=jar

exit $?
