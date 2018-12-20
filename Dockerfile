FROM ubuntu:16.04

# Install AWS staff
RUN apt-get update \
	&& apt-get install -y python-pip unzip curl jq \
	&& pip install awscli \
#	&& rm -rf /var/lib/apt/lists/* \
	&& mkdir -p /root/.aws

# Install Git
RUN apt-get install -y curl-devel expat-devel gettext-devel  openssl-devel zlib-devel
RUN apt-get install -y git

#Clean up
RUN rm -rf /var/lib/apt/lists/* \

# Install Java.
RUN \
	echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
	apt-get update && \
	apt-get install -y software-properties-common && \
	add-apt-repository -y ppa:webupd8team/java && \
	apt-get update && \
	apt-get install -y oracle-java8-installer && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer


# Define working directory.
WORKDIR /data

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV LANG C.UTF-8

CMD ["bash"]


