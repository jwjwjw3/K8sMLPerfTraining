FROM ubuntu
USER root

# Update the package list, install sudo, and grant password-less sudo permissions.
RUN apt update && \
    apt install -y sudo && \
    apt install -y screen vim htop nvtop git openssh-client openssh-server pdsh && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

RUN echo "source /nfs_container/container_start_script.sh" >> /root/.bashrc

WORKDIR /root/.ssh
RUN ssh-keygen -t rsa -b 4096 -N '' -f /root/.ssh/id_rsa && \
    cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys && \
    echo "Host *" >> /root/.ssh/config && \
    echo "   StrictHostKeyChecking no" >> /root/.ssh/config
