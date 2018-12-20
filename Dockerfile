FROM openjdk:8-jdk-alpine

RUN apk add --update ca-certificates && rm -rf /var/cache/apk/* && \
  find /usr/share/ca-certificates/mozilla/ -name "*.crt" -exec keytool -import -trustcacerts \
  -keystore /usr/lib/jvm/java-1.8-openjdk/jre/lib/security/cacerts -storepass changeit -noprompt \
  -file {} -alias {} \; && \
  keytool -list -keystore /usr/lib/jvm/java-1.8-openjdk/jre/lib/security/cacerts --storepass changeit

#ENV MAVEN_VERSION 3.5.2
#ENV MAVEN_HOME /usr/lib/mvn
#ENV PATH $MAVEN_HOME/bin:$PATH

#install Maven
#RUN wget http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz && \
#  tar -zxvf apache-maven-$MAVEN_VERSION-bin.tar.gz && \
#  rm apache-maven-$MAVEN_VERSION-bin.tar.gz && \
#  mv apache-maven-$MAVEN_VERSION /usr/lib/mvn


#install git
RUN apk --update add git openssh && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

#install python and aws cli
RUN apk add --update python python-dev py-pip
RUN pip install awscli

CMD ["bash"]

