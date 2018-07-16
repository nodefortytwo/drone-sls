FROM node:8.10-slim

RUN npm i -g serverless@1.28.0
ADD ./scripts/sls-run /bin
RUN chmod a+x /bin/sls-run

ENTRYPOINT sls-run