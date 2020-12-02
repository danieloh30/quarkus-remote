#!/bin/bash

oc new-project quarkus-remote
oc new-build registry.access.redhat.com/ubi8/openjdk-11:1.3 --binary --name=quarkus-remote -l app=quarkus-remote
oc start-build quarkus-remote --from-dir=target/quarkus-app

oc new-app quarkus-remote -e QUARKUS_LAUNCH_DEVMODE=true
oc expose service quarkus-remote
oc label deployment/quarkus-remote app.openshift.io/runtime=quarkus --overwrite