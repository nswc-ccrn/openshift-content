FROM registry.access.redhat.com/ubi9/ubi:latest

# Install dependencies
RUN dnf install -y git vim podman && dnf clean all

# Install Helm 3
RUN curl -fsSL -o /usr/local/bin/get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 \
  && chmod 700 /usr/local/bin/get_helm.sh \
  && source /usr/local/bin/get_helm.sh \
  && rm -f /usr/local/bin/get_helm.sh

# Install OC Mirror
RUN curl -fsSL -o /usr/local/bin/oc-mirror.tar.gz https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/oc-mirror.tar.gz \
  && cd /usr/local/bin/ && tar zxf oc-mirror.tar.gz \
  && chmod 700 oc-mirror \
  && rm -rf oc-mirror.tar.gz

# Install Openshift Client + Kubectl
RUN curl -fsSL -o /usr/local/bin/openshift-client-linux.tar.gz https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz \
  && cd /usr/local/bin/ && tar zxf openshift-client-linux.tar.gz \
  && chmod 700 oc && chmod 700 kubectl \
  && rm -rf openshift-client-linux.tar.gz && rm -rf README.md

# Install Openshift Installer
RUN curl -fsSL -o /usr/local/bin/openshift-install-linux.tar.gz https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-install-linux.tar.gz \
  && cd /usr/local/bin/ && tar zxf openshift-install-linux.tar.gz \
  && chmod 700 openshift-install \
  && rm -rf openshift-install-linux.tar.gz

# Install OPM Client
RUN curl -fsSL -o /usr/local/bin/opm-linux.tar.gz https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/opm-linux.tar.gz \
  && cd /usr/local/bin/ && tar zxf opm-linux.tar.gz \
  && chmod 700 opm \
  && rm -rf opm-linux.tar.gz

# Install NetApp Tridentctl
RUN curl -fsSL -o /usr/local/bin/trident-installer.tar.gz https://github.com/NetApp/trident/releases/download/v24.02.0/trident-installer-24.02.0.tar.gz \
  && cd /usr/local/bin/ && tar zxf trident-installer*.gz \
  && mv trident-installer/tridentctl ./tridentctl \
  && chmod 700 tridentctl 

RUN mkdir -p /workspace && chown -R 0:0 /workspace

WORKDIR /workspace
ENTRYPOINT ['/bin/sh', '-c']

