#!/bin/bash

cat $1 | tr -d '\r' > $1
