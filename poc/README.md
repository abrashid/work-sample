# Disaster recovery - Database secret resiliency (Work-sample-db-secret-resiliency.png)

The database secrets cannot be easily created new every time. For example, the passwords for the various database user roles. If those are not the current passwords the database expects, then the application will not be able to talk to the database and application is effectively down.
The Secrets Manager is used to hold database passwords or secrets, but we need a way of populating those secrets with the correct, current passwords. 
To achieve that we need a way of securely storing mission-critical, highly sensitive passwords that will persist even if we lose an account.

### DR Scenarios - Database password corrupted in secrets manager

This scenario is where through malice or accident database secrets have become corrupted. Expected effect - Application is up but it can't reach the database to run queries
Required response 
We need to restore correct password to secrets manager then consider actions for compromised account.
Create the password by using IaC.
Manually find the original password and reset it in existing Secrets Manager. Having restored the password to the existing SMs, the application should start to connect to the database without the need for a redeployment

### DR Scenarios - Account compromised or deleted
This scenario assumes the account has been compromised and we need to rebuild the application in a new account. Expected effect - we should assume complete loss of service.
Required response 
We need to rebuild entire infrastructure in new account but same region
That will involve:
Infrastructure is built and data restored from latest back up.
Application is deployed and some loss of data that all passwords have been compromised and need to be changed/rotated.

### Separate Security-Account - Appropriate for above DR Scenarios

Secrets are stored with the Custom KMS key
Any new/change/delete secret triggers notification and needs approval.
After approval, secret is updated to the non-prod and live-prod accounts secrets manager.
When approver rejects the secrets change request - Secrets manager returns to the AWSPREVIOUS secret version or even returns to the specific version ID. 
It's not allowed to change the secrets in non-prod or live-prod accounts directly. Any change to the secret must be done through security account. 


# aws-security-hub-analytic-pipeline (Work-Sample-SecurityHub-Findings-In-Quicksight.png)

AWS Security Hub is a service that gives an aggregated visibility into security and compliance posture across multiple AWS accounts.
By integrating Security Hub with Amazon QuickSight, a machine learning-powered business intelligence (BI) dashboard service could be built for senior leaders and decision-makers of the customer.

The steps shown in figure include:
Aggregate
Transform
Analyze
Visualize

### Aggregate

Using the aggregation feature within Security Hub, findings within each administrator account can be aggregated and continuously synchronized across multiple accounts.

### Transform

Data coming out of Security Hub is exposed via Amazon EventBridge. Unfortunately, it’s not quite in a form that Athena can consume. EventBridge streams data through Amazon Kinesis Data Firehose directly to Amazon Simple Storage Service (Amazon S3). From Amazon S3, an AWS Lambda function flattens and fixes some of the column names, such as by removing special characters that Athena cannot recognize. The Lambda function then saves the results back to S3. Finally, an AWS Glue crawler dynamically discovers the schema of the data and creates or updates an Athena table.

### Analyze

This section aggregates the raw findings data and creates metrics along various grains or pivots by creating a simple yet meaningful Athena view. With Athena, one can use views to join the data with other data sources, such as organization’s configuration management database (CMDB) or IT service management (ITSM) system.

### Visualize

QuickSight will register the data sources and build visualizations that can be used to identify areas where security can be improved or reduce risk. 
