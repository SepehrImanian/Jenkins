FROM jenkins/jenkins:jdk11

USER root

# Install docker client
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https \
  ca-certificates curl \
  gnupg gnupg2 \
  software-properties-common \
  lsb-release \
  apt-utils
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y docker-ce-cli

# Install ansible
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y python3-pip
RUN pip install wheel && pip install ansible

# Install kubernetes client
RUN curl -LO "https://dl.k8s.io/release/$(curl -sL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
  chmod +x kubectl && mv kubectl /usr/local/bin/kubectl

# Install helm
RUN curl -fsSL https://baltocdn.com/helm/signing.asc | apt-key add -
RUN apt-add-repository "deb https://baltocdn.com/helm/stable/debian all main"
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y helm

# Install terraform
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
RUN apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y terraform

USER jenkins

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml
COPY --chown=jenkins:jenkins casc.yaml /var/jenkins_home/casc.yaml
COPY --chown=jenkins:jenkins plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt
