# Preparation Build
FROM registry.access.redhat.com/ubi9/ubi as prep

# ARG
ARG VERSION
ARG ARCH

# ENV 
ENV VERSION=${VERSION:-4.13.13}
ENV ARCH=${ARCH:-amd64}

# Download binary
RUN dnf install tar gzip git -y 
RUN curl -LO https://mirror.openshift.com/pub/openshift-v4/${ARCH}/clients/ocp/${VERSION}/openshift-client-linux.tar.gz
RUN tar xzf openshift-client-linux.tar.gz
RUN curl -L https://mirror.openshift.com/pub/openshift-v4/clients/helm/latest/helm-linux-${ARCH} -o helm
RUN chmod +x helm
RUN git clone https://github.com/sa-mw-dach/bobbycar.git

# Build image
FROM registry.access.redhat.com/ubi9/ubi as build
WORKDIR work
COPY --from=prep oc /usr/local/bin
COPY --from=prep helm /usr/local/bin
COPY --from=prep bobbycar /work
RUN dnf install jq -y
RUN helm repo add drogue-iot https://drogue-iot.github.io/drogue-cloud-helm-charts/
RUN helm dependency build helm/bobbycar-core-infra

