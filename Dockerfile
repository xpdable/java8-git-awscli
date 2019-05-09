FROM amazonlinux:latest

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
#Skip for now as Maven usually work with full JDK
#RUN mkdir /opt/apache-maven-$MAVEN_VERSION
#RUN wget "http://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz"
#RUN tar xvf apache-maven-$MAVEN_VERSION-bin.tar.gz -C /opt/apache-maven-$MAVEN_VERSION
#RUN rm apache-maven-$MAVEN_VERSION-bin.tar.gz

#get jre for jenkins
RUN yum install java-1.8.0 -y

#install yq
RUN curl https://github.com/mikefarah/yq/releases/download/2.3.0/yq_linux_amd64 -L -o yq
