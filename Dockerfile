FROM ubuntu:xenial as builder
MAINTAINER Kaija Chang, https://github.com/kaija

RUN apt-get -y update && apt-get install -y maven openjdk-8-jdk
COPY dependency-track /opt/dependency-track

WORKDIR /opt/dependency-track

COPY build.sh /opt/dependency-track/build.sh

RUN ./build.sh

FROM tomcat:8.0-jre8-alpine

# Remove Tomcat default deployed webapps
RUN ["rm", "-fr", "/usr/local/tomcat/webapps/docs"]
RUN ["rm", "-fr", "/usr/local/tomcat/webapps/examples"]
RUN ["rm", "-fr", "/usr/local/tomcat/webapps/host-manager"]
RUN ["rm", "-fr", "/usr/local/tomcat/webapps/manager"]
RUN ["rm", "-fr", "/usr/local/tomcat/webapps/ROOT"]

COPY --from=builder /opt/dependency-track/target/dependency-track.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
