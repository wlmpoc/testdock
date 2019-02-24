# Swarm notes

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

docker service scale httpd=3
httpd: scale can only be used with replicated mode

 docker service update --publish-add published=8080,target=80 httpd




