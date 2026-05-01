# Graph Report - .  (2026-05-01)

## Corpus Check
- 5 files · ~5,000 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 8 nodes · 6 edges · 3 communities detected
- Extraction: 100% EXTRACTED · 0% INFERRED · 0% AMBIGUOUS
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- [[_COMMUNITY_FMS Context|FMS Context]]
- [[_COMMUNITY_Community 1|Community 1]]
- [[_COMMUNITY_Community 2|Community 2]]

## God Nodes (most connected - your core abstractions)
1. `integration/node-red/flows.json` - 3 edges
2. `MQTT → REST bridge role` - 2 edges
3. `fms-backend has no MQTT subscriber` - 2 edges
4. `Vendored upstream Node-RED (do not edit)` - 1 edges
5. `Retires when fms-backend adds MQTT subscriber` - 1 edges
6. `deviceMap aligns to seed/01_devices.sql` - 1 edges
7. `README.md (upstream)` - 1 edges

## Surprising Connections (you probably didn't know these)
- `integration/node-red/flows.json` --implements--> `MQTT → REST bridge role`  [EXTRACTED]
  ../integration/node-red/flows.json → CLAUDE.md
- `README.md (upstream)` --references--> `Vendored upstream Node-RED (do not edit)`  [EXTRACTED]
  README.md → CLAUDE.md
- `deviceMap aligns to seed/01_devices.sql` --rationale_for--> `integration/node-red/flows.json`  [EXTRACTED]
  CLAUDE.md → ../integration/node-red/flows.json

## Communities

### Community 0 - "FMS Context"
Cohesion: 0.67
Nodes (3): deviceMap aligns to seed/01_devices.sql, integration/node-red/Dockerfile (uses nodered/node-red base image), integration/node-red/flows.json

### Community 1 - "Community 1"
Cohesion: 0.67
Nodes (3): MQTT → REST bridge role, Retires when fms-backend adds MQTT subscriber, fms-backend has no MQTT subscriber

### Community 2 - "Community 2"
Cohesion: 1.0
Nodes (2): Vendored upstream Node-RED (do not edit), README.md (upstream)

## Knowledge Gaps
- **4 isolated node(s):** `Vendored upstream Node-RED (do not edit)`, `Retires when fms-backend adds MQTT subscriber`, `deviceMap aligns to seed/01_devices.sql`, `README.md (upstream)`
  These have ≤1 connection - possible missing edges or undocumented components.
- **Thin community `Community 2`** (2 nodes): `Vendored upstream Node-RED (do not edit)`, `README.md (upstream)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `integration/node-red/flows.json` connect `FMS Context` to `Community 1`?**
  _High betweenness centrality (0.333) - this node is a cross-community bridge._
- **Why does `MQTT → REST bridge role` connect `Community 1` to `FMS Context`?**
  _High betweenness centrality (0.286) - this node is a cross-community bridge._
- **What connects `Vendored upstream Node-RED (do not edit)`, `Retires when fms-backend adds MQTT subscriber`, `deviceMap aligns to seed/01_devices.sql` to the rest of the system?**
  _4 weakly-connected nodes found - possible documentation gaps or missing edges._