# Gitter

Create a folder of archived git repositories, using a csv to identify which repositories to clone. 

## Using gitter

Gitter has two major dependencies: (1) `git` and (2) `s3cmd` [NOTE: s3cmd must be version 1.5, which is *not* the default install for ubuntu]. Once you have these dependencies met, create an Amazon S3 bucket, and get an AWS ACCESS_KEY and SECRET_KEY. Then it's just a matter of picking your csv file and running the following commands:

```
git clone https://github.com/18f/gitter.git
cd gitter
export ACCESS_KEY=YOURACCESSKEY
export ACCESS_KEY=YOURSECRETKEY
./gitter.sh /path/to/csvfile yourbucketname
```

## Docker

More TK.