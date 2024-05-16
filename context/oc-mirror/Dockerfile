FROM registry.access.redhat.com/ubi9/ubi:latest

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

ENTRYPOINT ["oc-mirror"]
CMD ["--config=/config.yaml", "file://"]

