#!/bin/bash

if [ "$TESTENV" = "" ]; then
 export TEST_HOME=$PWD
 export JMETER_VERSION=apache-jmeter-2.13
 export JMETER_HOME=$TEST_HOME/$JMETER_VERSION
 export PATH=$PATH:$TEST_HOME:$JMETER_HOME/bin
fi

export TEST_REMOTE=127.0.0.1

# Update cert name, test user, and jmeter filename.
export SERVER_JVM_ARGS="-Xmx4096m -Xms2048m"
export JMETER_CERT=
export TEST_USER=ubuntu
export JMETER_SCRIPT=jmeter-sample.jmx

ID_OPT=""
if [ "$JMETER_CERT" !=  "" ] ; then
  ID_OPT=" -i $TEST_HOME/certs/$JMETER_CERT"
fi

export ID_OPT

TESTENV=1
