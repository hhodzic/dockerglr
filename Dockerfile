# start from base
FROM ubuntu:20.04

MAINTAINER Haris <haris.hodzic@progress.com>

# install things
RUN apt-get -yqq update
RUN apt-get install -y wget ruby git jq vim

WORKDIR /work

# install workstation
RUN wget https://packages.chef.io/files/stable/chef-workstation/21.3.346/ubuntu/18.04/chef-workstation_21.3.346-1_amd64.deb
RUN dpkg -i chef-workstation_21.3.346-1_amd64.deb
RUN rm -f chef-workstation_21.3.346-1_amd64.deb

# install gatherlog reporter
RUN HAB_LICENSE="accept-no-persist" hab pkg install chef/gatherlogs_reporter
RUN HAB_LICENSE="accept-no-persist" hab pkg exec chef/gatherlogs_reporter gatherlog report --help

COPY .bashrc /root/.bashrc

# expose port
EXPOSE 5000

