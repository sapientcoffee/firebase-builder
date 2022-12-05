FROM node:19.2-alpine AS app-env

# Install Python and Java and pre-cache emulator dependencies.
RUN apk add --no-cache python3 py3-pip openjdk11-jre bash && \
    npm install -g firebase-tools && \
    firebase setup:emulators:database && \
    firebase setup:emulators:firestore && \
    firebase setup:emulators:pubsub && \
    firebase setup:emulators:storage && \
    firebase setup:emulators:ui && \
    rm -rf /var/cache/apk/*

ADD firebase.sh /usr/bin
RUN chmod +x /usr/bin/firebase.sh

ENTRYPOINT [ "/usr/bin/firebase.sh" ]