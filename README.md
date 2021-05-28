# dockerglr
Run Gatherlog Reporter within docker container

# Overview
I was running into issues with getting gatherlog reporter running locally so figured to run it in the container could help me run it easier on different machines. 

# Prerequisites
You should have these running on your local machine:

- Docker
- Git 

# How to Run it

First clone the repo, cd to it, and build your docker image
```
git clone https://github.com/hhodzic/dockerglr.git
cd dockerglr
docker build . -t glreporter
```

Once your image is built you can check it's there
```
docker images
```

You can then start up the container from your newly built image
```
docker run -t -d glreporter
```

You can then check that your container is running with
```
docker ps
```

You should see something like this:
```
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
013d463e2c32        glreporter          "/bin/bash"         1 minutes ago        Up  about a min   5000/tcp            fervent_herschel
```

You could then use docker cp command to copy gatherlogs bundle to your container:
```
docker cp exampleGatherlogsBundle.tbz2 <CONTAINER ID>:/work
```

example (You can use attachment from your favorite ticket):
```
docker cp myserver02.cloud.mycompany.com-2021-05-27_20.08.45-UTC.tbz2 013d463e2c32:/work
```

note:
```
you can play with "ticket command" tool as well. Modify your image to include "ticket command" 
and download your bundles that way. I was running into some issues with tokens for SendSafely. 
one of these days I might try to make it work. 
```

Once you have your bundle inside the container you can go there and untar the bundle, 
cd to root of the bundle, and run gatherlog report

Continued from earlier example:
```
docker exec -it 013d463e2c32 /bin/bash
```

You will get prompt that looks like this:
```
root@013d463e2c32:/work# 
```

From there run:
```
tar -vxf myserver02.cloud.mycompany.com-2021-05-27_20.08.45-UTC.tbz2
cd myserver.cloud.mycompany.com
cd 2021-05-27_20.08.45-UTC
```

Once you're in the root directory of your bundle just run 
```
glr
```
This should generate the report for your bundle. 
glr is just an alias that executes the gatherlog report. 

