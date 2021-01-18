
## Live coding with Remote Development on OpenShift

This is the source codes for Live coding with Remote Development on OpenShift.

---

#### Add configurions in `application.properties`

Change `REPLACE_WITH_YOUR_PASSWORD` with your own password:

```
quarkus.package.type=mutable-jar
quarkus.live-reload.password=REPLACE_WITH_YOUR_PASSWORD

quarkus.container-image.build=true
quarkus.kubernetes-client.trust-certs=true
quarkus.kubernetes.deployment-target=openshift
quarkus.openshift.expose=true
quarkus.openshift.env-vars.quarkus-launch-devmode.value=true
```

#### Package and deploy a mutable jar to OpenShift

You should log in to OpenShift cluster with your credential.

```
oc new-project quarkus-remote &&
mvn clean package -DskipTests -Dquarkus.kubernetes.deploy=true
```

#### Run the remote dev mode in the local machine

Add the following configuration and change `REPLACE_WITH_YOUR_ROUTE_URL` with the application's route URL:

```
quarkus.live-reload.url=REPLACE_WITH_YOUR_ROUTE_URL
```

Then comment the existing OpenShift extension configurations:

```
# quarkus.container-image.build=true
# quarkus.kubernetes-client.trust-certs=true
# quarkus.kubernetes.deployment-target=openshift
# quarkus.openshift.expose=true
# quarkus.openshift.env-vars.quarkus-launch-devmode.value=true
```

Run the remote dev mode:

```
mvn quarkus:remote-dev
```

Open the endpint(i.e. http://REPLACE_WITH_YOUR_ROUTE_URL/hello) then update the code like `Hello RESTEasy from OpenShift!!`.

Reload the web page then make sure if you see the changes.