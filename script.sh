#!/bin/bash

echo "Launching app..."

echo "Starting app1..."

python -m SimpleHTTPServer 4000 2>&1 &

echo "Waiting for app1 to launch on port 4000..."

while ! nc -z localhost 4000; do
  sleep 1
done

echo "app1 is running on port 4000"

python -m SimpleHTTPServer 5000 2>&1 &

echo "Waiting for app2 to launch on port 5000..."

while ! nc -z localhost 5000; do
  sleep 1
done

echo "app2 is being served on port 5000"

python -m SimpleHTTPServer 6000 2>&1 &

echo "Waiting for app3 to launch on port 6000..."

while ! nc -z localhost 6000; do
  sleep 1
done

echo "app3 is being served on port 6000"

wget http://localhost:4000 -O 4000.txt
wget http://localhost:5000 -O 5000.txt
wget http://localhost:6000 -O 6000.txt

cat 4000.txt
cat 5000.txt
cat 6000.txt

echo "Cleaning up..."

fuser -k -n tcp 4000
fuser -k -n tcp 5000
fuser -k -n tcp 6000

echo "cleaned"
