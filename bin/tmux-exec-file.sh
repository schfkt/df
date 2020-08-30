#!/bin/bash

file=$1

exec_js_test_file() {
  if [[ "$1" =~ ^test\/ ]]; then
    local cmd=(yarn exec jest --silent "$file")
    echo "${cmd[@]}"
    "${cmd[@]}"
  elif [[ "$1" =~ ^puppeteer\/ ]]; then
    local cmd=(yarn puppeteer-tests --silent "$file")
    echo "${cmd[@]}"
    "${cmd[@]}"
  else
    echo "Can't handle this js/ts file"
  fi
}

exec_go_test_file() {
  go test -v $1
}

if [[ "$file" =~ \.spec\.(js|ts)$ ]]; then
  exec_js_test_file "$file"
elif [[ "$file" =~ _test.go$ ]]; then
  exec_go_test_file "$file"
else
  echo "Filetype not supported"
fi

