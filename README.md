##### Tested with:

**java**
```
java -version
java version "1.8.0_20"
Java(TM) SE Runtime Environment (build 1.8.0_20-b26)
Java HotSpot(TM) 64-Bit Server VM (build 25.20-b23, mixed mode)
```

**cassandra**

cassandra 2.0.9

**cassandra logging properties**

*/etc/cassandra/conf/log4j-server.properties*

```
# output messages into a rolling log file as well as stdout
log4j.rootLogger=INFO,stdout,R

# stdout
log4j.appender.stdout=org.apache.log4j.ConsoleAppender
log4j.appender.stdout.layout=org.apache.log4j.PatternLayout
log4j.appender.stdout.layout.ConversionPattern=%5p %d{HH:mm:ss,SSS} %m%n

# rolling log file
log4j.appender.R=org.apache.log4j.RollingFileAppender
log4j.appender.R.layout=org.apache.log4j.PatternLayout
log4j.appender.R.layout.ConversionPattern=%5p [%t] %d{ISO8601} %F (line %L) %m%n
# Edit the next line to point to your logs directory
log4j.appender.R.File=/var/log/cassandra/system.log
```

**cassandra jvm**

*/etc/cassandra/conf/cassandra-env.sh*

CMS
```
JVM_OPTS="$JVM_OPTS -XX:+UseParNewGC"
JVM_OPTS="$JVM_OPTS -XX:+UseConcMarkSweepGC"
JVM_OPTS="$JVM_OPTS -XX:+CMSParallelRemarkEnabled"
JVM_OPTS="$JVM_OPTS -XX:SurvivorRatio=8"
JVM_OPTS="$JVM_OPTS -XX:MaxTenuringThreshold=8"
JVM_OPTS="$JVM_OPTS -XX:CMSInitiatingOccupancyFraction=75"
JVM_OPTS="$JVM_OPTS -XX:+UseCMSInitiatingOccupancyOnly"
JVM_OPTS="$JVM_OPTS -XX:+UseTLAB"

# GC logging options -- uncomment to enable
# CMS and G1
JVM_OPTS="$JVM_OPTS -XX:+PrintGCDetails"
JVM_OPTS="$JVM_OPTS -XX:+PrintGCDateStamps"
JVM_OPTS="$JVM_OPTS -XX:+PrintGCApplicationStoppedTime"
JVM_OPTS="$JVM_OPTS -XX:+PrintTenuringDistribution"
JVM_OPTS="$JVM_OPTS -XX:+PrintHeapAtGC"

# CMS only
JVM_OPTS="$JVM_OPTS -XX:+PrintPromotionFailure"
JVM_OPTS="$JVM_OPTS -XX:PrintFLSStatistics=1"

JVM_OPTS="$JVM_OPTS -Xloggc:/var/log/cassandra/gc.log"
JVM_OPTS="$JVM_OPTS -XX:+UseGCLogFileRotation"
JVM_OPTS="$JVM_OPTS -XX:NumberOfGCLogFiles=10"
JVM_OPTS="$JVM_OPTS -XX:GCLogFileSize=10M"
JVM_OPTS="$JVM_OPTS -XX:+PrintGCApplicationConcurrentTime"
JVM_OPTS="$JVM_OPTS -XX:+PrintGCTimeStamps"
JVM_OPTS="$JVM_OPTS -XX:+PrintSafepointStatistics"
```

G1
```
JVM_OPTS="$JVM_OPTS -XX:+UseG1GC"
JVM_OPTS="$JVM_OPTS -XX:ParallelGCThreads=12"
JVM_OPTS="$JVM_OPTS -XX:-UseBiasedLocking"

# GC logging options -- uncomment to enable
# CMS and G1
JVM_OPTS="$JVM_OPTS -XX:+PrintGCDetails"
JVM_OPTS="$JVM_OPTS -XX:+PrintGCDateStamps"
JVM_OPTS="$JVM_OPTS -XX:+PrintGCApplicationStoppedTime"
JVM_OPTS="$JVM_OPTS -XX:+PrintTenuringDistribution"
JVM_OPTS="$JVM_OPTS -XX:+PrintHeapAtGC"

# G1 only
JVM_OPTS="$JVM_OPTS -XX:+PrintAdaptiveSizePolicy"

JVM_OPTS="$JVM_OPTS -Xloggc:/var/log/cassandra/gc.log"
JVM_OPTS="$JVM_OPTS -XX:+UseGCLogFileRotation"
JVM_OPTS="$JVM_OPTS -XX:NumberOfGCLogFiles=10"
JVM_OPTS="$JVM_OPTS -XX:GCLogFileSize=10M"
JVM_OPTS="$JVM_OPTS -XX:+PrintGCApplicationConcurrentTime"
JVM_OPTS="$JVM_OPTS -XX:+PrintGCTimeStamps"
JVM_OPTS="$JVM_OPTS -XX:+PrintSafepointStatistics"
```

The following gc logging options are required:
```
JVM_OPTS="$JVM_OPTS -XX:+PrintGCDetails"
JVM_OPTS="$JVM_OPTS -XX:+PrintGCDateStamps"
JVM_OPTS="$JVM_OPTS -XX:+PrintGCTimeStamps"
```

This options are optional and could be disabled or enabled:
```
JVM_OPTS="$JVM_OPTS -XX:+PrintGCApplicationConcurrentTime"
JVM_OPTS="$JVM_OPTS -XX:+PrintGCApplicationStoppedTime"
JVM_OPTS="$JVM_OPTS -XX:+PrintTenuringDistribution"
JVM_OPTS="$JVM_OPTS -XX:+PrintHeapAtGC"
JVM_OPTS="$JVM_OPTS -XX:+PrintSafepointStatistics"
```

**logstash**

```
/opt/logstash/bin/logstash --version
logstash 1.5.3
```

all input, filter and output plugin configuration files should be stored in:
```
/etc/logstash/conf.d/
```

all logstash pattern files should be stored in:
```
/etc/logstash/patterns/
```

used installed logstash plugins:
* logstash-filter-alter 0.1.6
* logstash-filter-elapsed 0.1.5

```
/opt/logstash/bin/plugin install logstash-filter-elapsed
/opt/logstash/bin/plugin install logstash-filter-alter
```

**logstash-forwarder**

install

```
curl -O http://download.elasticsearch.org/logstash-forwarder/packages/logstash-forwarder-0.3.1-1.x86_64.rpm
yum install logstash-forwarder-0.3.1-1.x86_64.rpm
```

Please note the modified logstash init-scrips. Two seperate init and config files is a dirty solution, but required  for a filter-multiline plugin bug, which remove identical lines in one event. 

**kibana**

```
/opt/kibana/bin/kibana --version
4.1.1
```
