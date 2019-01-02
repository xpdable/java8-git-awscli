FROM amazonlinux:latest

#Versioning
ENV MAVEN_VERSION=3.6.0

USER root
RUN yum -y install sudo
#update
RUN yum -y update && \
    yum -y install wget && \
    yum install -y tar.x86_64 && \
    yum install -y make gcc openssl-devel bzip2-devel glibc glibc-common gd gd-devel && \
    yum clean all

#Get Git
RUN yum install -y git

#Get Maven
RUN mkdir /opt/apache-maven-$MAVEN_VERSION
RUN wget "http://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz"
RUN tar xvf apache-maven-$MAVEN_VERSION-bin.tar.gz -C /opt/apache-maven-$MAVEN_VERSION
RUN rm apache-maven-$MAVEN_VERSION-bin.tar.gz

#get py3
RUN wget https://www.python.org/ftp/python/3.6.6/Python-3.6.6.tgz
RUN tar xzf Python-3.6.6.tgz
RUN cd Python-3.6.6 && ./configure --enable-optimizations
RUN cd Python-3.6.6 && make
RUN cd Python-3.6.6 && make altinstall
RUN rm Python-3.6.6.tgz


#get jdk8 for jenkins
RUN yum install java-1.8.0 -y
RUN /usr/sbin/alternatives --set java /usr/lib/jvm/jre-1.8.0-openjdk.x86_64/bin/java
RUN /usr/sbin/alternatives --set javac /usr/lib/jvm/jre-1.8.0-openjdk.x86_64/bin/javac



