### These AWS CloudFormation templates could be deployed from AWS Console or CLI.
### Deploy kms template first. Then deploy ebs template.

### Deploy with CLI.

```
aws cloudformation deploy --stack-name any-name-kms --template-file kms.yaml --capabilities CAPABILITY_NAMED_IAM

aws cloudformation deploy --stack-name any-name-ebs --template-file ebs.yaml --capabilities CAPABILITY_NAMED_IAM

```
### Destory with CLI.

```
aws cloudformation delete-stack --stack-name any-name-kms
aws cloudformation delete-stack --stack-name any-name-ebs

```