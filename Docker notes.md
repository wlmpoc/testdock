#  Docker notes
This file contains all of my dca stu[Garbage collection in Registry](https://docs.docker.com/registry/garbage-collection/)[Garbage collection in registry](https://docs.docker.com/registry/garbage-collection/)dy notes
### formatted output example:
```
$ docker search registry --format 'table {{.Name}}\t{{.IsOfficial}}\t{{.IsAutomated}}'List item
```
#### read write mount:

```
$ docker run -d -p 5000:5000 --name dockerregistry --mount 'source=/srv/registry/data,target=/var/lib/registry,type=bind,ro=0' --restart always registry:2
```

#### read only mount:

```
docker run --name testcontainerformountoptions -d --mount "source=$(pwd),target=/usr/share/clouduser,type=bind,ro=1" ubuntu tail -f /dev/null

```

***Exec into the container to test the read only mode***:

```
root@5ee15b378712:/usr/share/clouduser/mytestdir# echo "Container - appending text to the end of the file" >> samplefile1 
bash: samplefile1: Read-only file systemcode here
```

 **Note:** Differences between -v and --mount behavior
 Because the `-v` and `--volume` flags have been a part of Docker for a long time, their behavior cannot be changed. This means that there is one behavior that is different between -v and --mount. If you use -v or --volume to bind-mount a file or directory that does not yet exist on the Docker host, -v creates the endpoint for you. It is always created as a directory. If you use --mount to bind-mount a file or directory that does not yet exist on the Docker host, Docker does not automatically create it for you, but generates an error.

**Image spec:**
 1. manifest
 2. image layers
 3. image index

**Example:**
```json
{
  "schemaVersion": 2,
  "manifests": [
    {
      "mediaType": "application/vnd.oci.image.manifest.v1+json",
      "size": 7143,
      "digest": "sha256:e692418e4cbaf90ca69d05a66403747baa33ee08806650b51fab815ad7fc331f",
      "platform": {
        "architecture": "ppc64le",
        "os": "linux"
      }
    },
    {
      "mediaType": "application/vnd.oci.image.manifest.v1+json",
      "size": 7682,
      "digest": "sha256:5b0bcabd1ed22e9fb1310cf6c2dec7cdef19f0ad69efa1f392e94a4333501270",
      "platform": {
        "architecture": "amd64",
        "os": "linux"
      }
    }
  ],
  "annotations": {
    "com.example.key1": "value1",
    "com.example.key2": "value2"
  }
}
```

**Container Spec:**
1. namespaces, default devices (/dev/null ... ), filesystems
2. cgroups
3. capabilities
4. LSM ?? , seccomp
5. filesystem jails
6. Rootfs mount propogation
   - slave
   - private
   - unbindable
   - shared

**[Further Details in linux kernal documentation page](https://www.kernel.org/doc/Documentation/filesystems/sharedsubtree.txt)**

**[Example Config.json file](https://github.com/opencontainers/runtime-spec/blob/master/config.md#configuration-schema-example)**

### Docker system information:-

```
 docker system df

```

| TYPE         |       TOTAL      |         ACTIVE      |        SIZE         |       RECLAIMABLE |
|--------------|------------------|---------------------|---------------------|-------------------|
| Images       |       3          |         3           |        245.6MB      |       0B (0%)     |
| Containers   |       4          |         2           |        185B         |       183B (98%)  |
| Local Volumes|       1          |         0           |        0B           |       0B          |
| Build Cache  |       0          |         0           |        0B           |       0B          |

---

## Container Security options:-

``` 
 "SecurityOptions": [
        "apparmor",     # This profile is used on containers, not on the Docker Daemon.
        "seccomp",      # the profile is a whitelist which denies access to system calls by default, then whitelists specific system calls. Used on container and daemon 
        "selinux"       # Used on container and daemon
    ]
    
$ docker run --rm -it --security-opt apparmor=docker-default hello-world

$ docker run --rm -it --security-opt seccomp=/path/to/seccomp/profile.json hello-world

$ docker run --rm -it --security-opt seccomp=unconfined debian:jessie unshare --map-root-user --user sh -c whoami

```


##### container bind options:
1. rprivate
2. rslave
3. rshared

##### volume options:

1. NoCopy
2. label
3. Driver options
    - Name
    - Value

---

### Docker Namespaces:

Create user on docker host:

```
$ adduser docker_user -m -d /home/docker_user -s /bin/bash

```

Remap username space as below:

```
$ cat /etc/docker/daemon.json
{
 "userns-remap": "docker_user"
}
```
Restart daemon:

```
$ systemctl restart docker.service

```

Check docker info:
<pre>

$ docker info -f '{{json .SecurityOptions}}' | python -m json.tool
[
    "name=apparmor",
    "name=seccomp,profile=default",
    <b>"name=userns"</b>
]
</pre>

---

##### Legacy default Bridge network:

* if multiple services of the same application need to talk to each other we need to expose ports for all the services even if they are not external facing
* To disconnect a container, we need to stop and then recreate it with different network options
* It cannot be configured without restarting the docker daemon

---

| Network Name | Layer in OSI Model |
|--------------|--------------------|
| Bridge       | Link layer (L2)    |
| Overlay      | Network layer (L3) |
| GatewayBridge| Virtual Bridge over Overlay|
| ingress      | Transport layer (L4)|
| Ucp External | Application layer (L7)|
  routing mesh | Load balancing


##### Depricated option --link:

> One feature that user-defined networks do not support that you can do with --link is sharing environment variables between containers. However you can use other mechanisms such as volumes to ***share** environment variables* between containers in a more controlled way



##### Prerequisite for creating docker overlay network:

1. daemon should have access to a key-value store
2. a cluster of host machines registered with key-value store
3. a properly configured engine daemond on each host machine

Note:- Overlay netowrk by default is created with one subnet. But we can configure this to span across multiple subnets

```
$ docker network create -d overlay \
  --subnet=192.168.0.0/16 \
  --subnet=192.170.0.0/16 \
  --gateway=192.168.0.100 \
  --gateway=192.170.0.100 \
  --ip-range=192.168.1.0/24 \
  --aux-address="my-router=192.168.1.5" --aux-address="my-switch=192.168.1.6" \
  --aux-address="my-printer=192.170.1.5" --aux-address="my-nas=192.170.1.6" \
  my-multihost-network
  
```
---

### Docker Volumes:-

The host directory is declared at container run-time: The host directory (the mountpoint) is, by its nature, host-dependent. This is to preserve image portability, since a given host directory can’t be guaranteed to be available on all hosts. For this reason, you can’t mount a host directory from within the Dockerfile. 


### Registry:

https://docs.docker.com/registry/garbage-collection/


### DTR:

[DTR Backup](https://docs.docker.com/ee/dtr/admin/disaster-recovery/create-a-backup/)
[DTR Single sign on](https://docs.docker.com/ee/dtr/admin/configure/enable-single-sign-on/)
[DTR Storage](https://docs.docker.com/ee/dtr/admin/configure/external-storage/nfs/)
[DTR Garbage collection](https://docs.docker.com/ee/dtr/admin/configure/garbage-collection/)

---

## **_Must read article_**:

[Container networking model](https://blog.docker.com/2016/12/understanding-docker-networking-drivers-use-cases/)
