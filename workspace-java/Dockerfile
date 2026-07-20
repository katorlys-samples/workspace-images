FROM katorlys/workspace-base:latest

# The Java version to install: https://sdkman.io/jdks
ARG JAVA_VERSION=25.0.1.fx-zulu

# Install Java, Kotlin, Maven and Gradle
RUN curl -s https://get.sdkman.io | bash && \
    source $HOME/.sdkman/bin/sdkman-init.sh && \
    sdk install java $JAVA_VERSION && \
    sdk default java $JAVA_VERSION && \
    sdk install kotlin && \
    sdk install maven && \
    sdk install gradle && \
    sdk flush archives && \
    sdk flush tmp