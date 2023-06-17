# AWS S3

> **AWS S3 provides infinitely scalable storage. It is used for data storage and backup, disaster recovery purposes, data archives, static website hosting, media hosting, delivering software updates and much more.**
> 

## Buckets and Objects

Amazon S3 stores data in buckets (similar to top level directories). **Name of an AWS S3 bucket must be globally unique across all regions and all AWS accounts**. S3 buckets are region scoped. Inside an S3 bucket, files are stored as objects. S3 doesn’t have the concept of directories. Each object in an S3 bucket has a **key** of the format s3://bucket_name/unique_value representing full path of that object. The key must be unique for each object at bucket level.

An S3 object consists of -

- the **content** that we need to upload (can be maximum size of 5 TB). While uploading content of more than 5 GB in size to an S3 bucket, we must use multi-part upload.
- some **metadata** - list of text key / value pairs set by the user or S3 itself.
- upto 10 **tags** - unicode key / value pairs useful in case of object security and lifecycle.
- **version ID** if S3 bucket versioning is enabled.

## S3 Security

Access control to AWS S3 buckets and objects for IAM users / roles within the same AWS account, can be done using AWS IAM Policies. AWS also provides us with **resource based policies** -

- **S3 Bucket Policies** - **Bucket wide** rules which can be assigned to IAM users under the current AWS account or even to other AWS accounts.
    
    S3 Bucket Policies are used in cases like - grant public access to the S3 bucket, force S3 objects to be encrypted at upload or to grant access to other AWS accounts.
    
- **Object Access Control Lists (ACLs)** - Fine grained object level policies.
    
    <aside>
    💡 Bucket level policies can also be configured using Bucket ACLs, but it is recommended to use S3 Bucket Policies instead.
    
    </aside>
    
    Bucket or Object ACLs feature can be disabled if you want.
    

AWS also provides a setting called **Block Public Access**. If you turn this on for an S3 bucket, then regardless of any existing S3 bucket policies which grant public access to the S3 bucket, that S3 bucket will never be exposed to the public internet. You can also turn Block Public Access on at the AWS account level.

Encryption at rest is available for S3 objects.

## Static Website Hosting

We can host static websites using an S3 bucket and have it accessible from the internet. The website URL will be of the format - [http://bucketName.s3-webiste-awsRegion.amazonaws.com](http://bucketName.s3-webiste-awsRegion.amazonaws.com) or [http://bucketName.s3-webiste.awsRegion.amazonaws.com](http://bucketname.s3-webiste-awsregion.amazonaws.com/). The S3 bucket (public access to it should be enabled) will contain HTML and required media files.

## S3 Versioning

We can version files present in an S3 bucket and for that we need to turn on versioning at the S3 bucket level. S3 bucket versioning protects us against unintended object deletions and also provides us with the feature of easy rollbacks.

<aside>
💡

- If objects are present in an S3 bucket before versioning is enabled for it, then after the versioning is enabled, they will have version - null.
- If we disable versioning for an S3 bucket, existing versions will not be deleted.
</aside>

> In S3 versioning, **Delete Markers** are used to indicate that an S3 object has been deleted. When we delete the an S3 object from an S3 bucket with versioning enabled, a delete marker is created instead of deleting that object itself. **This allows us to recover deleted objects by deleting the delete marker**.
> 

A version of the S3 object can be deleted permanently using its version id.

## S3 Replication

We can do 2 types of replications - Cross Region Replication (CRR) and Same Region Replication (SRR). S3 bucket versioning must be enabled in both the source and destination S3 buckets. Replication happens asynchronously and the 2 buckets can belong to 2 different AWS accounts.

<aside>
💡

- After replication is enabled, only new objects are replicated. We can replicate existing S3 objects using Batch Replication.
- We can enable or disable replication of delete markers. (Permanent deletions using version id cannot be replicated).
- Replication by default is enabled for all the objects in the source S3 bucket, but we can use some filters and enable replication for specific objects in that bucket.
</aside>

## S3 Storage Classes

AWS S3 provides different storage classes to help optimize costs and performance based on how frequently you access your data and the latency requirements. The storage classes are:

- **S3 Standard**: this is the default class and is used for frequently accessed data. It offers 99.99% availability. This storage class is generally used for big data analytics, gaming applications etc.
- **S3 Standard-Infrequent Access (S3 Standard-IA)**: this class is used for infrequently accessed data but when rapid access is required. We get 99.9% availability.
- **S3 One Zone-Infrequent Access (S3 One Zone-IA)**: this class is used for infrequently accessed data that can be recreated easily. It stores data in a single availability zone. We get 99.5% availability.
- **S3 Glacier**: This storage class is great for storing backup data which is generally needed once in a quarter. The pricing model - low cost object storage + object retrieval fees. It has got multiple sub storage classes - **Instant Retrieval** (minimum storage duration of 90 days), **Expedited / Standard / Bulk Flexible Retrieval** (minimum storage duration of 90 days) and **Standard / Bulk Deep Archive** (minimum storage duration is 180 days but charges lowest fees for object storage).
- **S3 Intelligent-Tiering**: this class is used for data with unknown or changing access patterns. It automatically moves objects between two access tiers (**standard, infrequent, archive instant, archive, deep archive**) based on changing access patterns and offers the same durability and availability as the S3 Standard class.
