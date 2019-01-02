FROM amazonlinux:latest

#Versioning
ENV MAVEN_VERSION=3.6.0

#update
RUN yum -y update && \
    yum -y install wget && \
    yum install -y tar.x86_64 && \
    yum install -y make &&\
    yum clean all

#Get Git
RUN yum install -y git

#Get Maven
RUN mkdir /opt/apache-maven-$MAVEN_VERSION
RUN curl "http://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz" -o apache-maven-$MAVEN_VERSION-bin.tar.gz
RUN tar xvf apache-maven-$MAVEN_VERSION-bin.tar.gz -C /opt/apache-maven-$MAVEN_VERSION
RUN rm apache-maven-$MAVEN_VERSION-bin.tar.gz

#get py3
RUN yum install -y gcc openssl-devel bzip2-devel
RUN cd /usr/src
RUN wget https://www.python.org/ftp/python/3.6.6/Python-3.6.6.tgz
RUN tar xzf Python-3.6.6.tgz
RUN cd Python-3.6.6
RUN ./configure --enable-optimizations
RUN make altinstall
RUN rm /usr/src/Python-3.6.6.tgz

#get jdk8 for jenkins
RUN yum install java-1.8.0 -y
RUN /usr/sbin/alternatives --set java /usr/lib/jvm/jre-1.8.0-openjdk.x86_64/bin/java
RUN /usr/sbin/alternatives --set javac /usr/lib/jvm/jre-1.8.0-openjdk.x86_64/bin/javac


