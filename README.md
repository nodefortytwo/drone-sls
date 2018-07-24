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
    image: nodefortytwo/sls:v2.1.0
    role: arn:aws:iam::***:role/***
    action: deploy
    stage: dev
    region: eu-central-1
```

If you have a api-gateway domain
```yaml
pipeline:
  serverless:
    image: nodefortytwo/sls:v2.1.0
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
    image: nodefortytwo/sls:v2.1.0
    role: arn:aws:iam::***:role/***
    action: deploy
    stage: dev
    region: eu-central-1
    version_alias: true
    when:
      event: push

  serverless-live:
    image: nodefortytwo/sls:v2.1.0
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
    image: nodefortytwo/sls:v2.1.0
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
    image: nodefortytwo/sls:v2.1.0
    role: arn:aws:iam::***:role/***
    action: deploy
    stage: dev
    region: eu-central-1
    create_domain: true
    conceal: true
    accelerate: true

  serverless-live:
    image: nodefortytwo/sls:v2.1.0
    role: arn:aws:iam::***:role/***
    region: eu-central-1
    alias: LIVE
    when:
      event: deployment
```