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
    image: nodefortytwo/sls:v2.0.0
    role: arn:aws:iam::***:role/***
    action: deploy
    stage: dev
    region: eu-central-1
```

If you have a api-gateway domain
```yaml
pipeline:
  serverless:
    image: nodefortytwo/sls:v2.0.0
    role: arn:aws:iam::***:role/***
    action: deploy
    stage: dev
    region: eu-central-1
    create_domain: true
    
```

The full monty
```yaml
pipeline:
  serverless:
    image: nodefortytwo/sls:v2.0.0
    role: arn:aws:iam::***:role/***
    action: deploy
    stage: dev
    region: eu-central-1
    create_domain: true
    conceal: true
    accelerate: true
```