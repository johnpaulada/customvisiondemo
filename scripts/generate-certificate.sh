#!/bin/bash

npx devcert-cli generate localhost
mv localhost.cert snowpack.crt
mv localhost.key snowpack.key