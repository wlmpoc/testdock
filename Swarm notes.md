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
## Swarm Ports:

|ports|function|protocol|
|-----|---|---|      
|2377|Cluster management & raft sync communication|tcp secure|
|7946|Nodes communication (gossip)|udp and tcp|
|4789|Vxlan based overlay(user defined overlay??)|udp|
50|Encapsulating security payload|Ip protocol|

---

docker node ls output column values:-

|state|availability|manager status|
|-----|------------|--------------|
|Ready|Active|Leader|
|Unknown|Pause|Reachable (manager)|
|Down|Drain||
|Disconnected|||

---



