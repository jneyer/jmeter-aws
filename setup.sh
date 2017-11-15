#!/bin/bash

if [ "$TESTENV" = "" ]; then
 export TEST_HOME=$PWD
 export JMETER_VERSION=apache-jmeter-3.3
 export JMETER_HOME=$TEST_HOME/$JMETER_VERSION
 export PATH=$PATH:$TEST_HOME:$JMETER_HOME/bin

 if [ "$CONFIG_PATH" = "" ]; then
  export CONFIG_PATH=$TEST_HOME/config
 fi

 if [ "$DATA_PATH" = "" ]; then
  export DATA_PATH=$TEST_HOME/data
 fi
fi

export TEST_REMOTE=
export SERVER_JVM_ARGS="-Xmx4096m -Xms2048m"

# Filename of AWS SSH certificate for worker nodes in certs directory
# If JMETER_CERT is blank, keys added by ssh-add will be used.
export JMETER_CERT=

# SSH user ID for worker nodes
export TEST_USER=ubuntu

# Filename of JMeter test script
export JMETER_SCRIPT=jmeter-sample.jmx

# Files to copy to worker nodes for test
export TEST_FILES="$CONFIG_PATH/jmeter.properties `find $DATA_PATH -type f ! -name README`"

if [ -f "$CONFIG_PATH/settings" ]; then
 source $CONFIG_PATH/settings
fi

ID_OPT=""
if [ "$JMETER_CERT" !=  "" ] ; then
  ID_OPT=" -i $TEST_HOME/certs/$JMETER_CERT"
fi

export ID_OPT

TESTENV=1
