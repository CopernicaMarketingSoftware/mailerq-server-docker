# use ubuntu 22.04 as a base
FROM ubuntu:22.04
MAINTAINER Copernica BV <sander.hansen@copernica.com>

# everything is non-interactive
ENV DEBIAN_FRONTEND=noninteractive 

# install the dependencies
RUN apt-get update && apt-get install -y gnupg ca-certificates && rm -rf /var/lib/apt/lists/*

# download and install the gpg key
RUN gpg --homedir /tmp --no-default-keyring --keyring /usr/share/keyrings/mailerq-packages.gpg --keyserver keyserver.ubuntu.com --recv-keys 90DE523265E3563E

# add the MailerQ repository
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/mailerq-packages.gpg] https://packages.mailerq.com/debian jammy main" | tee /etc/apt/sources.list.d/mailerq-packages.list 

# install MailerQ server
RUN apt-get update && apt-get install -y mailerq-server && rm -rf /var/lib/apt/lists/*

# copy our entry script to the machine
COPY mq-entry.sh /usr/bin/mq-entry.sh

# run MailerQ server
ENTRYPOINT ["/usr/bin/mq-entry.sh"]
CMD mailerq