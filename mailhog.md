## MailHog

MailHog default settings:

the SMTP server starts on port 1025
the HTTP server starts on port 8025
in-memory message storage

Port mapping used:
- 11025:1025
- 18025:8025

## API

# get messages
curl -X GET 'http://localhost:18025/api/v2/messages'
curl -X GET 'http://localhost:18025/api/v2/messages' | jq -r '.items'
