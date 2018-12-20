FROM openjdk:8-jdk-alpine

RUN apk add --update ca-certificates && rm -rf /var/cache/apk/* && \
  find /usr/share/ca-certificates/mozilla/ -name "*.crt" -exec keytool -import -trustcacerts \
  -keystore /usr/lib/jvm/java-1.8-openjdk/jre/lib/security/cacerts -storepass changeit -noprompt \
  -file {} -alias {} \; && \
  keytool -list -keystore /usr/lib/jvm/java-1.8-openjdk/jre/lib/security/cacerts --storepass changeit

#ENV MAVEN_VERSION 3.5.2
#ENV MAVEN_HOME /usr/lib/mvn
#ENV PATH $MAVEN_HOME/bin:$PATH
ENV PYTHON_VERSION 2.7.14-r2
ENV PY_PIP_VERSION 9.0.1-r1
#ENV SUPERVISOR_VERSION 3.3.1

#install Maven
#RUN wget http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz && \
#  tar -zxvf apache-maven-$MAVEN_VERSION-bin.tar.gz && \
#  rm apache-maven-$MAVEN_VERSION-bin.tar.gz && \
#  mv apache-maven-$MAVEN_VERSION /usr/lib/mvn

#install flyway
#WORKDIR /flyway
#ENV FLYWAY_VERSION 5.0.7
#RUN apk --no-cache add openssl \
#  && wget https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}.tar.gz \
#  && tar -xzf flyway-commandline-${FLYWAY_VERSION}.tar.gz \
#  && mv flyway-${FLYWAY_VERSION}/* . \
#  && rm flyway-commandline-${FLYWAY_VERSION}.tar.gz \
#  && sed -i 's/bash/sh/' /flyway/flyway \
#  && ln -s /flyway/flyway /usr/local/bin/flyway

#install git
RUN apk --update add git openssh && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

#RUN mkdir -p /usr/src/app
#WORKDIR /usr/src/app
#WORKDIR /WebServiceTest/WebService.Test

#install python and aws cli
RUN apk update && apk add -u python=$PYTHON_VERSION py-pip=$PY_PIP_VERSION
#RUN pip install supervisor==$SUPERVISOR_VERSION
RUN pip install awscli

#COPY ./supervisord.conf /
#ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf 

#entry
#ENTRYPOINT ["supervisord"]

#ENTRYPOINT ["/entry-point.sh"]
CMD ["bash"]

