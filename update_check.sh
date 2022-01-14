#!/bin/bash
if [[ ! -f "pom.xml" ]]; then
  echo "<PROJECT_DIR>/pom.xml not found. Please run this script in <PROJECT_DIR>"
  exit
fi

echo "===== Checking Plugins... ====="
mvn versions:display-plugin-updates

echo "===== Checking Dependencies... ====="
mvn versions:display-dependency-updates