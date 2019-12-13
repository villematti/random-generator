# Random Generator
Generates an array of numbers between 0 and 254.

## Requirements
- Dart 2.x (Build with 2.7)

## Install
1. Pull this repo to your server
2. pub get
3. dart bin/main.dart

Now your server is listening localhost:3000.

## Usage
Send post request to localhost:3000 with length parameter. Length will define how many numbers you will get.

Example: localhost:3000/?length=10

## See it in action
https://rndnum.talviruusu.com has working example.

## SSL
You can also set SSL-certificate to you server. Just set environment parameters rnd_cert and rnd_cert_key. Those have to be PEM files.

## Custom domain and port 80
You can also use port 80 and custom domain. Set rnd_domain and rnd_port as your environment variables and application starts using those automatically.
