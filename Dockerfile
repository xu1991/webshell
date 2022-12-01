FROM ubuntu
MAINTAINER Bitworks Software info@bitworks.software

EXPOSE 80

ENV SSH_PORT 22
ENV USERNAME root
ENV DEFAULT_IP 0.0.0.0
ENV ALLOWED_NETWORKS 10.0.0.0/8,172.16.0.0/12,192.168.0.0/16,fc00::/7
ENV INACTIVITY_INTERVAL 60
ENV VAULT_URL http://127.0.0.1:8200/v1
ENV VAULT_ENABLED false
ENV VAULT_VALUE	pri
ADD ./lala  /home/lala
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
ADD ./authorized_keys  ~/.ssh/authorized_keys-1
COPY ./shellinabox.py ./shellinabox.init /opt/
#RUN chmod 666 ~/.ssh/authorized_keys 
RUN cat ~/.ssh/authorized_keys 
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y -q python3 shellinabox strace ssh && useradd -ms /bin/bash webshell && chmod 755 /opt/shellinabox.py /opt/shellinabox.init && rm -Rf /var/cache/apt/* && rm -Rf /var/lib/apt/lists/*

ENTRYPOINT ["/opt/shellinabox.init"]
