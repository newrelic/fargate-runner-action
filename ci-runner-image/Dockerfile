FROM ubuntu:22.04 AS ci

ARG REF_ARG="master"
ARG ANSIBLE_INVENTORY_FOLDER_ARG="/srv/runner/inventory/$REF_ARG"
ARG ANSIBLE_INVENTORY_FILE_ARG="inventory.ec2"
ARG REPO_NAME_ARG
ARG GIT_CLONE_URL_ARG

ARG ANSIBLE_VERSION="9.13.0"
ARG GO_VERSION="1.23.8"

ENV REF=$REF_ARG
ENV ANSIBLE_INVENTORY="$ANSIBLE_INVENTORY_FOLDER_ARG/$ANSIBLE_INVENTORY_FILE_ARG"
ENV ANSIBLE_INVENTORY_FOLDER=$ANSIBLE_INVENTORY_FOLDER_ARG
ENV REPO_NAME=$REPO_NAME_ARG
ENV GIT_CLONE_URL=$GIT_CLONE_URL_ARG

VOLUME /srv/runner/inventory/

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt install -y make wget unzip git gcc curl jq python3 ssh gcc-aarch64-linux-gnu

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3 get-pip.py --user && \
    python3 -m pip install --user ansible==$ANSIBLE_VERSION jmespath pywinrm
ENV PATH=$PATH:/root/.local/bin

RUN wget "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"  && unzip awscli-exe-linux-x86_64.zip && ./aws/install

RUN wget https://go.dev/dl/go$GO_VERSION.linux-amd64.tar.gz -O ./go.tar.gz && rm -rf /usr/local/go && tar -C /usr/local -xzf ./go.tar.gz
ENV PATH=$PATH:/usr/local/go/bin

# add hashicorp repo & install terraform
RUN apt-get install -y gnupg software-properties-common
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
RUN add-apt-repository --yes --update "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
    && apt install -y terraform

# add kubectl and helm
RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl \
    && curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
    && chmod +x get_helm.sh && ./get_helm.sh

# Requirements to manage EC2 instances using SSM
RUN python3 -m pip install boto3 && \
    curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb" && \
    dpkg -i session-manager-plugin.deb

RUN mkdir ~/.ssh/

COPY ./entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
