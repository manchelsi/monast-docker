FROM centos:centos7
RUN yum update -y
RUN yum update -y
RUN yum install wget python-devel python-pip python-zope-interface python-crypto pyOpenSSL zope -y
RUN yum groupinstall "Development Tools" -y
RUN yum install -y epel-release
RUN yum install -y httpd php php-common php-gd php-pear php-xml supervisor 
RUN pear upgrade --force --alldeps http://pear.php.net/get/PEAR-1.10.1
RUN yum install tar bzip2 -y
COPY monast-3.0b4.tar.gz /usr/src/ 
COPY starpy-1.0.0a13.tar.gz /usr/src/
COPY Twisted-13.2.0.tar.bz2 /usr/src/
WORKDIR  /usr/src
RUN tar jxvf /usr/src/Twisted-13.2.0.tar.bz2
RUN tar zvxf /usr/src/starpy-1.0.0a13.tar.gz
RUN tar zvxf /usr/src/monast-3.0b4.tar.gz

WORKDIR /usr/src/Twisted-13.2.0
RUN python setup.py install

WORKDIR /usr/src/starpy-1.0.0a13
RUN python setup.py install

RUN pear install DB
RUN pear install HTTP_Request2 
RUN pear install HTTP_Client 

ADD install.sh /usr/src/monast-3.0b4/
WORKDIR /usr/src/monast-3.0b4
RUN sh install.sh

WORKDIR /root


ADD monast.conf /etc/

ADD supervisord.conf /etc/supervisord.conf
CMD ["/usr/bin/supervisord"]
