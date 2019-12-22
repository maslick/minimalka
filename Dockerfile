FROM debian:stretch-slim as packager

ENV JDK_VERSION="11.0.5.10.1"
ENV JDK_URL="https://d3pxv6yz143wms.cloudfront.net/${JDK_VERSION}/amazon-corretto-${JDK_VERSION}-linux-x64.tar.gz"
ENV JDK_ARJ_FILE="openjdk-${JDK_VERSION}.tar.gz"

# target JDK installation names
ENV OPT="/opt"
ENV JKD_DIR_NAME="amazon-corretto-${JDK_VERSION}-linux-x64"
ENV JAVA_HOME="${OPT}/${JKD_DIR_NAME}"
ENV JAVA_MINIMAL="${OPT}/java-minimal"

# downlodad JDK to the local file
ADD "$JDK_URL" "$JDK_ARJ_FILE"

# extract JDK and add to PATH
RUN mkdir -p "$OPT" && \
    tar xf "$JDK_ARJ_FILE" -C "$OPT" ;

ENV PATH="$PATH:$JAVA_HOME/bin"

# build modules distribution
RUN jlink \
    --verbose \
    --add-modules \
        java.base,java.sql,java.naming,java.desktop,java.management,java.security.jgss,java.instrument,jdk.unsupported \
    --compress 2 \
    --strip-debug \
    --no-header-files \
    --no-man-pages \
    --output "$JAVA_MINIMAL"


FROM debian:stretch-slim
ENV JAVA_HOME=/opt/java-minimal
ENV PATH="$PATH:$JAVA_HOME/bin"
COPY --from=packager "$JAVA_HOME" "$JAVA_HOME"
