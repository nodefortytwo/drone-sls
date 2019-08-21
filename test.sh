#!/bin/bash

CREDS=`aws sts get-session-token --duration-seconds=900`

docker build -t nodefortytwo/drone-sls .

docker run --rm \
  -e DRONE_REPO_OWNER=octocat \
  -e DRONE_REPO_NAME=hello-world \
  -e DRONE_COMMIT_SHA=7fd1a60b01f91b314f59955a4e4d4e80d8edf11d \
  -e DRONE_COMMIT_BRANCH=master \
  -e DRONE_COMMIT_AUTHOR=octocat \
  -e DRONE_BUILD_NUMBER=1 \
  -e DRONE_BUILD_STATUS=success \
  -e DRONE_BUILD_LINK=http://github.com/octocat/hello-world \
  -e DRONE_TAG=1.0.0 \
  -e AWS_ACCESS_KEY_ID=`echo $CREDS | jq -r '.Credentials.AccessKeyId'` \
  -e AWS_SECRET_ACCESS_KEY=`echo $CREDS | jq -r '.Credentials.SecretAccessKey'` \
  -e AWS_SESSION_TOKEN=`echo $CREDS | jq -r '.Credentials.SessionToken'` \
  -e PLUGIN_ROLE=arn:aws:iam::***:role/*** \
  -e PLUGIN_CREATE_DOMAIN=false \
  -e PLUGIN_ACTION=deploy \
  -e PLUGIN_STAGE=dev \
  -e PLUGIN_REGION=eu-central-1 \
  -e PLUGIN_CONCEAL=true \
  -e PLUGIN_ACCELERATE=true \
  -e PLUGIN_VERSION_ALIAS=true \
  -e PLUGIN_ALIAS=LIVE \
  -e DRONE_DEPLOY_TO_OVERRIDE=false \
 nodefortytwo/drone-sls