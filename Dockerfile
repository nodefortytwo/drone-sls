FROM node:8.10-alpine

RUN npm i -g serverless@1.28.0

RUN apk add --update python-dev py-pip jq 
RUN pip install awscli yq

ADD ./scripts/sls-run /bin

RUN chmod a+x /bin/sls-run

ENTRYPOINT sls-run