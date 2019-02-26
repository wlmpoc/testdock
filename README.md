#  Docker notes
This file contains all of my dca study notes
### formatted output example:
```
docker search registry --format 'table {{.Name}}\t{{.IsOfficial}}\t{{.IsAutomated}}'List item
```
#### read write mount:
```
docker run -d -p 5000:5000 --name dockerregistry --mount 'source=/srv/registry/data,target=/var/lib/registry,type=bind,ro=0' --restart always registry:2
```
#### read only mount:
```docker
docker run --name testcontainerformountoptions -d --mount "source=$(pwd),target=/usr/share/clouduser,type=bind,ro=1" ubuntu tail -f /dev/null
```
> ***Exec into the container to test the read only mode***:
> `root@5ee15b378712:/usr/share/clouduser/mytestdir# echo "Container - appending text to the end of the file" >> samplefile1 bash: samplefile1: Read-only file systemcode here`

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

``
 docker system df
| TYPE         |       TOTAL      |         ACTIVE      |        SIZE         |       RECLAIMABLE |
|--------------|------------------|---------------------|---------------------|-------------------|
| Images       |       3          |         3           |        245.6MB      |       0B (0%)     |
| Containers   |       4          |         2           |        185B         |       183B (98%)  |
| Local Volumes|       1          |         0           |        0B           |       0B          |
| Build Cache  |       0          |         0           |        0B           |       0B          |

---
