#!/bin/bash

set -x

/etc/init.d/postfix stop

if [ ! -z "${SMTP_USER}" -a ! -z "${SMTP_PASS}" ]; then
  cat <<EOF | tee /etc/postfix/sasl_passwd
[$SMTP_HOST]:$SMTP_PORT $SMTP_USER:$SMTP_PASS
EOF

  cat /etc/postfix/sasl_passwd
  postmap /etc/postfix/sasl_passwd

  chown root:root /etc/postfix/sasl_passwd* && \
    chmod 0600 /etc/postfix/sasl_passwd*
fi

# ls -lth /etc/ssl/certs/
# cat /etc/ssl/certs/thawte_Primary_Root_CA.pem > /etc/ssl/certs/ca-certificates.crt

/etc/init.d/postfix start &
wait

cat /usr/local/app/mail.html | mail -s "$MAIL_SUBJECT" \
  -a "Content-type: text/html; charset=utf-8" \
  -a "From: $SMTP_SENDER" "$MAIL_RECIPIENT" && \
  echo "Email sent successfully" || echo "Error sending email"

exec "$@"
