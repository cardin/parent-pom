#!/bin/bash
if [[ ! -f "pom.xml" ]]; then
  echo "<PROJECT_DIR>/pom.xml not found. Please run this script in <PROJECT_DIR>"
  exit
fi
mvn -P library install