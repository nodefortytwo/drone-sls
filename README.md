# drone-sls
Drone plugin deploying Serverless Framework stacks.

At present, only AWS Lambda is supported.

## Configuration

The following parameters are used to configure the plugin:


### Drone configuration examples

The following pipeline will build and deploy to the selected environment
```yaml
pipeline:
  deploy:
    image: nodefortytwo/sls:v2.1.1
    role: arn:aws:iam::***:role/***
    action: deploy
    stage: dev
    region: eu-central-1
```

If you have a api-gateway domain
```yaml
pipeline:
  serverless:
    image: nodefortytwo/sls:v2.1.1
    role: arn:aws:iam::***:role/***
    action: deploy
    stage: dev
    region: eu-central-1
    create_domain: true
```

To populate lambda version to the alias
```yaml
pipeline:
  serverless:
    image: nodefortytwo/sls:v2.1.1
    role: arn:aws:iam::***:role/***
    action: deploy
    stage: dev
    region: eu-central-1
    version_alias: true
    when:
      event: push

  serverless-live:
    image: nodefortytwo/sls:v2.1.1
    role: arn:aws:iam::***:role/***
    region: eu-central-1
    alias: LIVE
    when:
      event: deployment
```
The key parameter in `serverless` pipeline is `version_alias: true`. It enables marking all built lambda versions with short commit SHA aliases. That is how `serverless-live` is able to determine which lambda version should be switched.

Alias switching can be also used together with regular deployment
```yaml
pipeline:
  serverless:
    image: nodefortytwo/sls:v2.1.1
    role: arn:aws:iam::***:role/***
    action: deploy
    stage: dev
    region: eu-central-1
    version_alias: true
    alias: TEST
    when:
      event: push
```

The full monty
```yaml
pipeline:
  serverless:
    image: nodefortytwo/sls:v2.1.1
    role: arn:aws:iam::***:role/***
    action: deploy
    stage: dev
    region: eu-central-1
    create_domain: true
    conceal: true
    accelerate: true

  serverless-live:
    image: nodefortytwo/sls:v2.1.1
    role: arn:aws:iam::***:role/***
    region: eu-central-1
    alias: LIVE
    when:
      event: deployment
```

### Attaching S3 bucket events function
To run this step you need to have instaleed serverless-plugin-existing-s3 plugin (https://www.npmjs.com/package/serverless-plugin-existing-s3)

Following example will build, deploy and conncect S3 bucket events to the selected environment
```yaml
pipeline:
  deploy:
    image: nodefortytwo/sls:v2.1.1
    role: arn:aws:iam::***:role/***
    action: deploy
    stage: dev
    region: eu-central-1
     
  deploy-s3:
    image: nodefortytwo/drone-sls:v2.1.1
    role: arn:aws:iam::144992683770:role/automation-drone
    action: s3deploy
    stage: dev
    region: eu-central-1
```