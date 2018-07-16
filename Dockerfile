FROM node:8.10-slim

RUN apt-get update && apt-get install -y python-dev python-pip jq
RUN pip install awscli

ADD ./scripts/sls-run /bin

RUN chmod a+x /bin/sls-run

ENTRYPOINT sls-run