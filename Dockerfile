FROM rockylinux:9


RUN dnf update -y && dnf groupinstall -y 'Development Tools'
# seems like an odd dependency to have dangling, yet here we are...
RUN dnf install -y perl-FindBin

RUN git clone https://github.com/epics-base/epics-base.git /opt/epics-base

RUN cd /opt/epics-base \
    && git checkout R7.0.8.1 \
    && git submodule update --init --recursive \
    && make all

RUN cd /opt && tar czf epics-base.tgz epics-base
