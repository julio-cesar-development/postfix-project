FROM juliocesarmidia/ubuntu_base:18.04

WORKDIR /usr/local/app/

RUN apt-get update -yqq && \
    apt-get install -yqq \
    postfix mailutils \
    libsasl2-2 ca-certificates \
    libsasl2-modules gettext && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY . /usr/local/app/
RUN chmod +x /usr/local/app/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/app/docker-entrypoint.sh"]
CMD ["sh", "-c", "sleep 5"]
