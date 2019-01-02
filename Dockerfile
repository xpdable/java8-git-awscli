FROM amazonlinux:latest

#Versioning
ENV MAVEN_VERSION=3.6.0

#update
RUN yum -y update && \
    yum install -y tar.x86_64 && \
    yum clean all

#Get Git
RUN yum install -y git

#get py3
RUN  yum -y install gcc zlib zlib-devel openssl openssl-devel libffi libffi-devel wget zip -y && \
     yum clean all

# Install python3.6.2, using the method described in amazonlinux image documentation's
# "How do I install a software package from Extras repository in Amazon Linux 2 LTS Candidate?"
RUN amazon-linux-extras install python3 && \
    yum install -y python3-devel && \
    yum clean all

RUN pip3 install awscli

#Get Maven
RUN mkdir /opt/apache-maven-$MAVEN_VERSION
RUN wget "http://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz"
RUN tar xvf apache-maven-$MAVEN_VERSION-bin.tar.gz -C /opt/apache-maven-$MAVEN_VERSION
RUN rm apache-maven-$MAVEN_VERSION-bin.tar.gz

#get jdk8 for jenkins
RUN yum install java-1.8.0 -y
RUN /usr/sbin/alternatives --set java /usr/lib/jvm/jre-1.8.0-openjdk.x86_64/bin/java
RUN /usr/sbin/alternatives --set javac /usr/lib/jvm/jre-1.8.0-openjdk.x86_64/bin/javac



