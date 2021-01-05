
## Live coding with Remote Development on OpenShift

This is the source codes for Live coding with Remote Development on OpenShift.

---

#### Add configurions in `application.properties`

Change `REPLACE_WITH_YOUR_PASSWORD` with your own password:

```
quarkus.package.type=mutable-jar
quarkus.live-reload.password=REPLACE_WITH_YOUR_PASSWORD
```

#### Package a mutable jar

```
mvn package
```

#### Deploy it to OpenShift

You should log in to OpenShift cluster with your credential.

```
oc new-project quarkus-remote
oc new-build registry.access.redhat.com/ubi8/openjdk-11:1.3 --binary --name=quarkus-remote -l app=quarkus-remote
oc start-build quarkus-remote --from-dir=target/quarkus-app
```

Make sure if the build completes then run the following commands:

```
oc new-app quarkus-remote -e QUARKUS_LAUNCH_DEVMODE=true
oc expose service quarkus-remote
oc label deployment/quarkus-remote app.openshift.io/runtime=quarkus --overwrite
```

#### Run the remote dev mode in the local machine

Add the following configuration and change `REPLACE_WITH_YOUR_ROUTE_URL` with the application's route URL:

```
quarkus.live-reload.url=REPLACE_WITH_YOUR_ROUTE_URL
```

Run the remote dev mode:

```
mvn quarkus:remote-dev
```

Open the endpint(i.e. http://REPLACE_WITH_YOUR_ROUTE_URL/hello-resteasy) then update the code like `Hello RESTEasy from OpenShift!!`.

Reload the web page then make sure if you see the changes.