#!/bin/bash

/etc/init.d/postfix stop

cat /usr/local/app/main.cf | envsubst \${SMTP_HOST},\${SMTP_PORT} > /etc/postfix/main.cf

cat <<EOF | tee /etc/postfix/sasl_passwd
[$SMTP_HOST]:$SMTP_PORT $SMTP_MAIL:$SMTP_PASS
EOF

postmap /etc/postfix/sasl_passwd

chown root:root /etc/postfix/sasl_passwd* && \
    chmod 0600 /etc/postfix/sasl_passwd*

cat /etc/ssl/certs/thawte_Primary_Root_CA.pem > /etc/ssl/certs/ca-certificates.crt

/etc/init.d/postfix start &
wait

cat /usr/local/app/mail.html | mail -s "$MAIL_SUBJECT" \
    -a "Content-type: text/html;" \
    -a "From: $SMTP_MAIL" "$MAIL_RECIPIENT" && \
    echo "Email sent successfully" || echo "Error sending email"

exec "$@"
