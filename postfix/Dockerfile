FROM juliocesarmidia/ubuntu_base:18.04

WORKDIR /usr/local/app/

RUN apt-get update -yqq && \
    apt-get install -yqq \
    libsasl2-2 libsasl2-modules \
    ca-certificates gettext

ARG SMTP_HOST
ARG SMTP_PORT
ENV SMTP_HOST=${SMTP_HOST}
ENV SMTP_PORT=${SMTP_PORT}

COPY main.cf .
RUN mkdir -p /etc/postfix/
RUN cat main.cf | envsubst \${SMTP_HOST},\${SMTP_PORT} > /etc/postfix/main.cf

RUN apt-get install -yqq \
    postfix mailutils
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN cat /etc/postfix/main.cf

COPY docker-entrypoint.sh .
COPY mail.html .

RUN chmod +x docker-entrypoint.sh

ENTRYPOINT ["/usr/local/app/docker-entrypoint.sh"]
CMD ["sh", "-c", "sleep 5"]
