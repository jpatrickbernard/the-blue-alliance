#! /usr/bin/env sh
set -e
. $(pwd)/ops/travis/should-deploy.sh

if [ "$TRAVIS" = "true" -a "$TRAVIS_EVENT_TYPE" = "pull_request" -a "$1" = "DEPLOY" ] ; then
    echo "No deploys on pull requests, skipping travis_before"
    exit 0
fi

if test "$1" = "DEPLOY" ; then
    should_deploy
fi

pip install -r travis_requirements.txt
paver install_libs
wget https://storage.googleapis.com/appengine-sdks/featured/google_appengine_1.9.40.zip -nv
unzip -q google_appengine_1.9.40.zip -d $HOME
rm google_appengine_1.9.40.zip
npm install
npm install -g gulp-cli uglify-es uglifycss less
