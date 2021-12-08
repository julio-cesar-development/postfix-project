import os
import smtplib

from email.message import EmailMessage

SMTP_HOST = os.environ.get('SMTP_HOST')
SMTP_PORT = os.environ.get('SMTP_PORT')
MAIL_SUBJECT = os.environ.get('MAIL_SUBJECT')
SMTP_SENDER = os.environ.get('SMTP_SENDER')
MAIL_RECIPIENT = os.environ.get('MAIL_RECIPIENT')

email_file = 'mail.html'

msg = EmailMessage()
msg.add_header('Content-type', 'text/html')

with open(email_file) as file:
  msg.set_payload(file.read())
  # msg.set_content(file.read()) # doesn't work for text/html content

msg['Subject'] = MAIL_SUBJECT
msg['From'] = SMTP_SENDER
msg['To'] = MAIL_RECIPIENT

try:
  server = smtplib.SMTP(host=SMTP_HOST, port=SMTP_PORT)
  # server.starttls()
  # server.login(SMTP_USER, SMTP_PASS)
  server.send_message(msg)
  server.quit()

  print(msg.get_content())

except Exception as e:
  print(e)
