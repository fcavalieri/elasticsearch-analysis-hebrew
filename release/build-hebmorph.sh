#!/bin/bash
set -x
set -e
set -u

SCRIPT_FOLDER=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
RELEASE_FOLDER="${SCRIPT_FOLDER}/release"
PACKAGING_FOLDER="${SCRIPT_FOLDER}/packaging"
TEMP_FOLDER="${SCRIPT_FOLDER}/temp"

rm -rf "$TEMP_FOLDER"
rm -rf "$PACKAGING_FOLDER"
rm -rf "$RELEASE_FOLDER"
mkdir "$TEMP_FOLDER"
mkdir "$PACKAGING_FOLDER"
mkdir "$RELEASE_FOLDER"

(
  cd "${SCRIPT_FOLDER}/.."
  mvn clean
  mvn package
)

(
  cd "${TEMP_FOLDER}"
  git clone https://github.com/synhershko/HebMorph.git
  cd HebMorph
  git checkout hebmorph-lucene-2.3.3
  mvn package
)

(
  cp "${SCRIPT_FOLDER}/../target/elasticsearch-analysis-hebrew-2.3.4.jar" \
     "${SCRIPT_FOLDER}/../plugin-descriptor.properties" \
     "${SCRIPT_FOLDER}/../plugin-security.policy" \
     "${TEMP_FOLDER}/HebMorph/java/target/hebmorph-lucene-2.3.3.jar" \
     "${PACKAGING_FOLDER}"
  cd "${PACKAGING_FOLDER}"
  zip "${RELEASE_FOLDER}/elasticsearch-analysis-hebrew-2.3.4.zip" \
      "elasticsearch-analysis-hebrew-2.3.4.jar" \
      "hebmorph-lucene-2.3.3.jar" \
      "plugin-descriptor.properties" \
      "plugin-security.policy"
)
