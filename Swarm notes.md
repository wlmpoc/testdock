﻿# Swarm notes

## Key Concepts:

One of the key advantages of swarm services over standalone containers is that you can modify a service’s configuration, including the networks and volumes it is connected to, without the need to manually restart the service.

To deploy your application to a swarm, you submit a **_service definition_** to a manager node. 
Manager Node
* perform orchestration -- orchestrator
* dispatch tasks to workers -- despatcher
* participate in leader election -- manager
* schedules tasks based on available resources & uses spread strategy -- scheduler
* uses ingress load balancing -- to publish ports
* uses internal load balancing -- distribute requests based on DNS name
* raft consensus algorithm

Orchestrators typically do the following:-
- The tasks of an orchestrator
- Reconciling the desired state
- Replicated and global services
- Service discovery
- Routing
- Load balancing
- Scaling
- Self-healing
- Zero downtime deployments by doing configurable updates. (Sets parallelism and delay between updates of each task)
- Affinity and location awareness
- Security
- Secure communication and cryptographic node identity
- Secure networks and network policies
--- Role-based access control (RBAC)
--- Secrets
--- Content trust
--- Reverse uptime
Introspection
---

## After swarm is initialized- status:
```
Swarm: active
 NodeID: hyold5lfo3vulnl38pyce59gx
 Is Manager: true
 ClusterID: x7g6kz41xq4os8kopsqj1felk
 Managers: 1
 Nodes: 1
 Default Address Pool: 10.0.0.0/8  
 SubnetSize: 24
 Orchestration:
  Task History Retention Limit: 5
 Raft:
  Snapshot Interval: 10000
  Number of Old Snapshots to Retain: 0
  Heartbeat Tick: 1
  Election Tick: 10
 Dispatcher:
  Heartbeat Period: 5 seconds
 CA Configuration:
  Expiry Duration: 3 months
  Force Rotate: 0
 Autolock Managers: false
 Root Rotation In Progress: false
 Node Address: 13.232.6.122
 Manager Addresses:
  13.232.6.122:2377

```

## Swarm Ports:

|ports|function|protocol|
|-----|---|---|      
|2377|Cluster management & raft sync communication|tcp secure|
|7946|Nodes communication (gossip)|udp and tcp|
|4789|Vxlan based overlay(user defined overlay??)|udp|
50|Encapsulating security payload|Ip protocol|
||communication between all nodes|Grpc protocol|


---

### docker node ls output column values:-

|state|availability|manager status|
|-----|------------|--------------|
|Ready|Active|Leader|
|Unknown|Pause|Reachable (manager)|
|Down|Drain||
|Disconnected|||

---

### Global Service:-
Cannot be scaled:

```
$ docker service scale httpd=3

    Error:- 
    httpd: scale can only be used with replicated mode
```
```
 $ docker service update --publish-add published=8080,target=80 httpd
```
---

- A N manager nodes swam can tolerate a maximum of loss of ****(N-1)/**2** manager nodes at the same time
- 
- If a swarm cluster with 7 managers is spread across three availability zones, how will you distribute the managers in such a way that the **quorum** is maintained. 
- 
- Swarm root certificates can be rotated. Min duration - 1 hour and Max duration - 3 months
   The manager node generates two tokens to use when you join additional nodes to the swarm: one worker token and one manager token. Each token includes the digest of the root CA’s certificate and a randomly generated secret. When a node joins the swarm, the joining node uses the digest to validate the root CA certificate from the remote manager. The remote manager uses the secret to ensure the joining node is an approved node.

   Each time a new node joins the swarm, the manager issues a certificate to the node. The certificate contains a randomly generated node ID to identify the node under the certificate common name (CN) and the role under the organizational unit (OU). The node ID serves as the cryptographically secure node identity for the lifetime of the node in the current swarm.

   Generally, you do not need to force the swarm to rebalance its tasks. When you add a new node to a swarm, or a node reconnects to the swarm after a period of unavailability, the swarm does not automatically give a workload to the idle node. This is a design decision.
   When you use docker service scale, the nodes with the lowest number of tasks are targeted to receive the new workloads. There may be multiple under-loaded nodes in your swarm. You may need to scale the service up by modest increments a few times to achieve the balance you want across all the nodes.

---

### RAFT Snapshots:

---

### Swarm Config and Secrets:

- Usecase
- How do you rotate the secrets used by swarm services and make the new one available to them 

### Volumes

Configure direct-lvm mode for devicemapper storage driver in production
Production hosts using the devicemapper storage driver must use direct-lvm mode.

{
  "storage-driver": "devicemapper"
}

Difference between -v and mount options for volumes:

Start a service with volumes and note the behaviour when multiple replicas of the service run on the same node. Also note the creation of volumes in other nodes.


Swarm service inspect:

https://docs.docker.com/engine/swarm/swarm-tutorial/inspect-service/



