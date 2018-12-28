FROM ubuntu:16.04

RUN apt-get update && \
    apt-get -y install sudo wget unzip curl software-properties-common python-software-properties && \
    add-apt-repository ppa:git-core/ppa && \
    apt-get update && \
    sudo apt-get install git -y && \
    apt-get clean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

ENV MAVEN_VERSION=3.6.0 
#    JAVA_VERSION=8u191 \
#    JAVA_VERSION_PREFIX=1.8.0_191

#ENV JAVA_HOME=/opt/jdk$JAVA_VERSION_PREFIX \
ENV M2_HOME=/apache-maven-$MAVEN_VERSION
ENV PATH=$M2_HOME/bin:$PATH

#RUN wget \
#  --header "Cookie: oraclelicense=accept-securebackup-cookie" \
#  "http://download.oracle.com/otn-pub/java/jdk/$JAVA_VERSION-b12/jdk-$JAVA_VERSION-linux-x64.tar.gz" | sudo tar -zx -C  /opt/
#RUN rm -f jdk-$JAVA_VERSION-linux-x64.tar.gz
RUN sudo add-apt-repository ppa:webupd8team/java
#RUN sudo apt-get update
#RUN sudo apt-get install -y oracle-java8-installer

RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" > /etc/apt/sources.list.d/webupd8team-java-trusty.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes --no-install-recommends oracle-java8-installer && apt-get clean all

## JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

RUN mkdir /opt/apache-maven-$MAVEN_VERSION
RUN  wget "http://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz" 
RUN  tar xvf apache-maven-$MAVEN_VERSION-bin.tar.gz -C /opt/apache-maven-$MAVEN_VERSION
RUN rm apache-maven-$MAVEN_VERSION-bin.tar.gz

RUN sudo apt-get install -y locales python3-pip python3-dev \
&& cd /usr/local/bin \
&& ln -s /usr/bin/python3 python \
&& pip3 install --upgrade pip

# Install AWS CLI
RUN pip3 install awscli

WORKDIR /projects


