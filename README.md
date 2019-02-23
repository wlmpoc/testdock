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
```
docker run --name testcontainerformountoptions -d --mount "source=$(pwd),target=/usr/share/clouduser,type=bind,ro=1" ubuntu tail -f /dev/null
```
> ***Exec into the container to test the read only mode***:
> `root@5ee15b378712:/usr/share/clouduser/mytestdir# echo "Container - appending text to the end of the file" >> samplefile1 bash: samplefile1: Read-only file systemcode here`

 **Note:** Differences between -v and --mount behavior
 Because the `-v` and `--volume` flags have been a part of Docker for a long time, their behavior cannot be changed. This means that there is one behavior that is different between -v and --mount. If you use -v or --volume to bind-mount a file or directory that does not yet exist on the Docker host, -v creates the endpoint for you. It is always created as a directory. If you use --mount to bind-mount a file or directory that does not yet exist on the Docker host, Docker does not automatically create it for you, but generates an error.

