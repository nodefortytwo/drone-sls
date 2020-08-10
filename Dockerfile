FROM node:12.18-alpine

RUN npm i -g serverless@1.78.1

RUN apk add --update python-dev py-pip jq 
RUN pip install awscli yq

ADD ./scripts/sls-run /bin

RUN chmod a+x /bin/sls-run

ENTRYPOINT sls-run