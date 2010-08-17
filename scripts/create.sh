#!/bin/bash

echo "Create an Android Project."
read -p "Enter project name: " name
echo "Enter project package:"
read -p "    novoda." pkg
echo "Enter target id."
android list targets | grep 'id:'
read -p "Chosen id (default: 10):" target
read -p "Enter default Activity name (Landing):" activity

<<TEST1
if [ -n "$target" ]
	then 
	target=10
fi

if [ -n "$activity" ]
	then 
	activity=Landinng	
fi
TEST1

package=novoda.$pkg
testname=$name\Test
dir=`pwd`
lowname=`echo "TasteLondon" | tr "[A-Z]" "[a-z]"`
main=$dir/$lowname/$name

projectSetup() {

	mkdir $lowname
	cd $lowname

	echo "Creating Android project"
	android -v create project -t $target -n $name -p ./$name -a $activity -k $package

	echo "Creating test project"
	android -v create test-project -n $testname  -p ./$testname -m $main
	cd ..
}

eclipseSetup() {
	cd $lowname/$name
	mvn eclipse:eclipse

	cd ../$testname
	mvn eclipse:eclipse
	cd ../..
}

pomSetup() {
	# probably run another script to make the pom.xml files
	# ruby/python/groovy
	pwd
}

echo "Create test project with details"
echo "Name: $name"
echo "package: $package"
echo "Test name: $testname"
echo "target: $target"
echo "Activity: $activity"

projectSetup
#pomSetup
#eclipseSetup
#templates


exit $?
