#!/bin/bash

echo "start copy files to new JFrog Home"

# Artifactory data
mkdir -p $JFROG_HOME/artifactory/var/data/artifactory/
cp -rp $ARTIFACTORY_HOME/data/. $JFROG_HOME/artifactory/var/data/artifactory/
 
# Access data
mkdir -p $JFROG_HOME/artifactory/var/data/access/
cp -rp $ARTIFACTORY_HOME/access/data/. $JFROG_HOME/artifactory/var/data/access/
 
# Replicator data
# Note: If you've have never used the Artifactory Replicator
# your $ARTIFACTORY_HOME/replicator/ directory will be empty
mkdir -p $JFROG_HOME/artifactory/var/data/replicator/
cp -rp $ARTIFACTORY_HOME/replicator/data/. $JFROG_HOME/artifactory/var/data/replicator/
 
# Artifactory config
mkdir -p $JFROG_HOME/artifactory/var/etc/artifactory/
cp -rp $ARTIFACTORY_HOME/etc/. $JFROG_HOME/artifactory/var/etc/artifactory/
 
# Access config
mkdir -p $JFROG_HOME/artifactory/var/etc/access/
cp -rp $ARTIFACTORY_HOME/access/etc/. $JFROG_HOME/artifactory/var/etc/access/
 
# Replicator config
# Note: If you have never used the Artifactory Replicator
# your $ARTIFACTORY_HOME/replicator/ directory will be empty
mkdir -p $JFROG_HOME/artifactory/var/etc/replicator/
cp -rp $ARTIFACTORY_HOME/replicator/etc/. $JFROG_HOME/artifactory/var/etc/replicator/
 
# master.key
mkdir -p $JFROG_HOME/artifactory/var/etc/security/
cp -p $ARTIFACTORY_HOME/etc/security/master.key $JFROG_HOME/artifactory/var/etc/security/master.key
 
# server.xml
mkdir -p $JFROG_HOME/artifactory/var/work/old
cp -p $ARTIFACTORY_HOME/tomcat/conf/server.xml $JFROG_HOME/artifactory/var/work/old/server.xml
 
# artifactory.defaults
cp -rp $ARTIFACTORY_HOME/bin/artifactory.default $JFROG_HOME/artifactory/var/work/old/artifactory.default
#or, if Artifactory was installed a service
#cp -rp $ARTIFACTORY_HOME/etc/default $JFROG_HOME/artifactory/var/work/old/artifactory.default
 
# Remove logback.xml with old links. Please consider migrating manually anything that is customized here
rm -f $JFROG_HOME/artifactory/var/etc/artifactory/logback.xml
rm -f $JFROG_HOME/artifactory/var/etc/access/logback.xml
 
# Move Artifactory logs
mkdir -p $JFROG_HOME/artifactory/var/log/archived/artifactory/
cp -rp $ARTIFACTORY_HOME/logs/. $JFROG_HOME/artifactory/var/log/archived/artifactory/

echo "All Done"
