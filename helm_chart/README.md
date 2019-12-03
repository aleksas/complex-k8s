# Semi working
Use old helm charts for elastic/* from repo https://kubernetes-charts.storage.googleapis.com/ .

- [install](https://kubernetes.github.io/ingress-nginx/deploy/) ingress controller into kubectl
- add postgress pgpassword PGPASSWORD secret.
  - `kubectl create secret generic postgress --from-literal=PGPASSWORD=your-password`
- [install Helm](https://helm.sh/docs/intro/install/)
- install this helm chart: `helm install --name my-release .`
- run port-forwarding to access kibana `kubectl port-forward my-release-kibana-86cb9c996d-zchlr 5601:5601`


# Not working
Try to run elastic/elasticsearch from elastic repo https://helm.elastic.co/. 

Filed an [issue](https://github.com/elastic/helm-charts/issues/388)

`helm install --name elasticsearch elastic/elasticsearch` doesn't work.  Trying it even with `--set replicas=1` (as indicated [here](https://github.com/elastic/helm-charts/issues/312#issuecomment-538004608)) or `antiAfinity=soft` (as indicated [here](https://discuss.elastic.co/t/elasticsearch-with-helm-charts-caused-by-java-nio-file-accessdeniedexception-usr-share-elasticsearch-data-nodes/174297/8?u=aleksas)) or `discovery.type=single-node` (seen [here](https://stackoverflow.com/q/51201699/1433554) and [here]()) results in :

```java
OpenJDK 64-Bit Server VM warning: Option UseConcMarkSweepGC was deprecated in version 9.0 and will likely be removed in a future release.
{"type": "server", "timestamp": "2019-12-03T09:42:18,746Z", "level": "WARN", "component": "o.e.b.ElasticsearchUncaughtExceptionHandler", "cluster.name": "elasticsearch", "node.name": "elasticsearch-master-0", "message": "uncaught exception in thread [main]",
"stacktrace": ["org.elasticsearch.bootstrap.StartupException: ElasticsearchException[failed to bind service]; nested: AccessDeniedException[/usr/share/elasticsearch/data/nodes];",
"at org.elasticsearch.bootstrap.Elasticsearch.init(Elasticsearch.java:163) ~[elasticsearch-7.4.1.jar:7.4.1]",
"at org.elasticsearch.bootstrap.Elasticsearch.execute(Elasticsearch.java:150) ~[elasticsearch-7.4.1.jar:7.4.1]",
"at org.elasticsearch.cli.EnvironmentAwareCommand.execute(EnvironmentAwareCommand.java:86) ~[elasticsearch-7.4.1.jar:7.4.1]",
"at org.elasticsearch.cli.Command.mainWithoutErrorHandling(Command.java:125) ~[elasticsearch-cli-7.4.1.jar:7.4.1]",
"at org.elasticsearch.cli.Command.main(Command.java:90) ~[elasticsearch-cli-7.4.1.jar:7.4.1]",
"at org.elasticsearch.bootstrap.Elasticsearch.main(Elasticsearch.java:115) ~[elasticsearch-7.4.1.jar:7.4.1]",
"at org.elasticsearch.bootstrap.Elasticsearch.main(Elasticsearch.java:92) ~[elasticsearch-7.4.1.jar:7.4.1]",
"Caused by: org.elasticsearch.ElasticsearchException: failed to bind service",
"at org.elasticsearch.node.Node.<init>(Node.java:614) ~[elasticsearch-7.4.1.jar:7.4.1]",
"at org.elasticsearch.node.Node.<init>(Node.java:255) ~[elasticsearch-7.4.1.jar:7.4.1]",
"at org.elasticsearch.bootstrap.Bootstrap$5.<init>(Bootstrap.java:221) ~[elasticsearch-7.4.1.jar:7.4.1]",
"at org.elasticsearch.bootstrap.Bootstrap.setup(Bootstrap.java:221) ~[elasticsearch-7.4.1.jar:7.4.1]",
"at org.elasticsearch.bootstrap.Bootstrap.init(Bootstrap.java:349) ~[elasticsearch-7.4.1.jar:7.4.1]",
"at org.elasticsearch.bootstrap.Elasticsearch.init(Elasticsearch.java:159) ~[elasticsearch-7.4.1.jar:7.4.1]",
"... 6 more",
"Caused by: java.nio.file.AccessDeniedException: /usr/share/elasticsearch/data/nodes",
"at sun.nio.fs.UnixException.translateToIOException(UnixException.java:90) ~[?:?]",
"at sun.nio.fs.UnixException.rethrowAsIOException(UnixException.java:111) ~[?:?]",
"at sun.nio.fs.UnixException.rethrowAsIOException(UnixException.java:116) ~[?:?]",
"at sun.nio.fs.UnixFileSystemProvider.createDirectory(UnixFileSystemProvider.java:389) ~[?:?]",
"at java.nio.file.Files.createDirectory(Files.java:693) ~[?:?]",
"at java.nio.file.Files.createAndCheckIsDirectory(Files.java:800) ~[?:?]",
"at java.nio.file.Files.createDirectories(Files.java:786) ~[?:?]",
"at org.elasticsearch.env.NodeEnvironment.lambda$new$0(NodeEnvironment.java:272) ~[elasticsearch-7.4.1.jar:7.4.1]",
"at org.elasticsearch.env.NodeEnvironment$NodeLock.<init>(NodeEnvironment.java:209) ~[elasticsearch-7.4.1.jar:7.4.1]",
"at org.elasticsearch.env.NodeEnvironment.<init>(NodeEnvironment.java:269) ~[elasticsearch-7.4.1.jar:7.4.1]",
"at org.elasticsearch.node.Node.<init>(Node.java:275) ~[elasticsearch-7.4.1.jar:7.4.1]",
"at org.elasticsearch.node.Node.<init>(Node.java:255) ~[elasticsearch-7.4.1.jar:7.4.1]",
"at org.elasticsearch.bootstrap.Bootstrap$5.<init>(Bootstrap.java:221) ~[elasticsearch-7.4.1.jar:7.4.1]",
"at org.elasticsearch.bootstrap.Bootstrap.setup(Bootstrap.java:221) ~[elasticsearch-7.4.1.jar:7.4.1]",
"at org.elasticsearch.bootstrap.Bootstrap.init(Bootstrap.java:349) ~[elasticsearch-7.4.1.jar:7.4.1]",
"at org.elasticsearch.bootstrap.Elasticsearch.init(Elasticsearch.java:159) ~[elasticsearch-7.4.1.jar:7.4.1]",
"... 6 more"] }
```
