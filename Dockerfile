#231mb base with yum
FROM registry.access.redhat.com/ubi8/ubi

# default java is 1.8 /usr/bin/java > /etc/alternatives/java
# /etc/alternatives/java >  /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.242.b08-0.el8_1.x86_64/jre/bin/java
# for 11 update symlink to >  /usr/lib/jvm/java-11-openjdk-11.0.6.10-0.el8_1.x86_64/bin/java
RUN echo "Installing packages"  && \
    yum install -y python36 java-11-openjdk.x86_64 java-1.8.0-openjdk.x86_64 maven wget unzip git dotnet && \
    echo "yum installs done, Fetching Gradle" && \
    cd /opt && wget https://services.gradle.org/distributions/gradle-6.2.1-bin.zip && \
    unzip gradle-6.2.1-bin.zip && rm -f gradle-6.2.1-bin.zip && \
    ln -s /opt/gradle-6.2.1/bin/gradle /usr/local/bin/gradle && \
    echo "Fetching Sonarqube ****# todo check if the properties file is really needed" && \
    cd /opt && wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.2.0.1873-linux.zip && \
    unzip sonar-scanner-cli-4.2.0.1873-linux.zip && rm -f sonar-scanner-cli-4.2.0.1873-linux.zip && \
    ln -s /opt/sonar-scanner-4.2.0.1873-linux/bin/sonar-scanner /usr/local/bin/sonar-scanner && \
    echo "Fetching java nexus-iq cli   *****# todo create script and symlink" && \
    mkdir /opt/nexus-iq && cd /opt/nexus-iq && wget https://download.sonatype.com/clm/scanner/nexus-iq-cli-1.85.0-01.jar && \
    echo "Fetching community nexus cli" && \
    mkdir /opt/nexus && cd /opt/nexus && wget https://github.com/sonatype-nexus-community/nexus-cli/releases/download/v0.8.0/nexus_0.8.0_Linux_x86_64.tar.gz && \
    tar -zxvf nexus_0.8.0_Linux_x86_64.tar.gz && rm -f nexus_0.8.0_Linux_x86_64.tar.gz && \
    chown root:root nexus && chmod 777 nexus && \
    ln -s /opt/nexus/nexus /usr/local/bin/nexus && \
    echo "Fetching trivy" && \
    mkdir /opt/trivy && cd /opt/trivy && wget https://github.com/aquasecurity/trivy/releases/download/v0.4.4/trivy_0.4.4_Linux-64bit.tar.gz && \
    tar -zxvf trivy_0.4.4_Linux-64bit.tar.gz && rm -f trivy_0.4.4_Linux-64bit.tar.gz && \
    chown root:root trivy && chmod 777 trivy && \
    ln -s /opt/trivy/trivy /usr/local/bin/trivy && \
    echo "Fetching vault" && \
    mkdir /opt/vault && cd /opt/vault && wget https://releases.hashicorp.com/vault/1.3.2/vault_1.3.2_linux_amd64.zip && \
    unzip vault_1.3.2_linux_amd64.zip && rm -f vault_1.3.2_linux_amd64.zip && \
    ln -s /opt/vault/vault /usr/local/bin/vault
