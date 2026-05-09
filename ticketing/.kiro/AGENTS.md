# Kiro Ticketing System Agents

## System Overview

This multi-agent system uses the AWS Kiro tool to tackle complex problems through specialized agents working in a coach-and-player orchestration pattern. The system routes tickets to appropriate specialists while maintaining context and oversight.

## Agent Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     User/Ticket Input                       │
└────────────────────────────┬────────────────────────────────┘
                             │
──────────────────────────────┼──────────────────────────────
│  ANALYSIS LAYER                                            │
│                                                            │
│  ┌──────────────────────────────────────────────────┐     │
│  │  Inventory Agent                                 │     │
│  │  ✓ Researches system state                       │     │
│  │  ✓ Produces contextual summaries                 │     │
│  │  ✓ Cites all sources                             │     │
│  └─────────────────┬────────────────────────────────┘     │
│                    │                                       │
│  ┌────────────────▼────────────────────────────────┐      │
│  │  Summary Reviewer                                │      │
│  │  ✓ Validates claims (direct evidence vs guess)  │      │
│  │  ✓ Identifies speculation & contradictions      │      │
│  │  ✓ Quality-gates inventory findings             │      │
│  └──────────────────────────────────────────────────┘      │
│                                                            │
──────────────────────────────────────────────────────────────
                             │
──────────────────────────────┼──────────────────────────────
│  ORCHESTRATION LAYER                                       │
│                                                            │
│  ┌──────────────────────────────────────────────────┐     │
│  │  Planner Agent (Coach)                           │     │
│  │  ✓ Analyzes problem scope and type               │     │
│  │  ✓ Routes to 1+ specialized agents               │     │
│  │  ✓ Oversees execution (coach pattern)            │     │
│  │  ✓ Validates and iterates on outputs             │     │
│  │  ✓ Synthesizes multi-agent results               │     │
│  └──────────┬──────────────────────────────────────┘     │
│             │                                             │
──────────────┼──────────────────────────────────────────────
│  SPECIALIST LAYER (Players)                                │
│             │                                             │
│    ┌────────┼────────┬──────────────┐                    │
│    │        │        │              │                    │
│  ┌─┴────┐ ┌──┴───┐ ┌────┴──────┐                        │
│  │ Code │ │ Docs │ │ Integration│                        │
│  │Analyzer│Generator│Troubleshtr │                        │
│  └──────┘ └──────┘ └────────────┘                        │
│    ✓          ✓          ✓                               │
│  Debug,      Create      Diagnose                        │
│  analyze    missing      cross-system                    │
│  code       docs/specs   failures                        │
│                                                            │
──────────────────────────────────────────────────────────────
                             │
──────────────────────────────┼──────────────────────────────
│  OUTPUT LAYER                                              │
│                                                            │
│  ┌──────────────────────────────────────────────────┐     │
│  │  Resolution: Root Cause + Actionable Fix          │     │
│  │  Verified Findings + Quality Assessment           │     │
│  │  Updated Documentation (if created)               │     │
│  └──────────────────────────────────────────────────┘     │
│                                                            │
──────────────────────────────────────────────────────────────
```

## Agent Roles & Responsibilities

### 1. Inventory Agent (Producer)
**Role**: Knowledge researcher  
**Input**: Problem description or research question  
**Output**: Comprehensive summary with citations  
**Key Characteristic**: Every claim is sourced

- ✓ Searches local wiki, docs, JIRA
- ✓ Aggregates findings into structured summary
- ✓ Cites all sources with line references
- ✓ Flags knowledge gaps and uncertainty
- ✓ Provides foundation for all downstream agents

**When it's done**: You have a well-sourced understanding of the system/problem

---

### 2. Summary Reviewer (Quality Gate)
**Role**: Fact-checker  
**Input**: Inventory summary  
**Output**: Validation report with confidence ratings

- ✓ Verifies each claim against source code/config
- ✓ Distinguishes direct evidence from inference
- ✓ Identifies speculative or incorrect statements
- ✓ Rates overall summary quality
- ✓ Flags items for revision

**When it's done**: You trust the inventory summary as a factual foundation

---

### 3. Planner Agent (Coach)
**Role**: Orchestrator using coach-player workflow  
**Input**: Ticket/problem + reviewed inventory  
**Output**: Routed to specialist(s) + synthesized resolution

The Coach:
- ✓ Analyzes problem type and scope
- ✓ Routes to `code-analyzer`, `docs-generator`, and/or `integration-troubleshooter`
- ✓ Provides full context to each player
- ✓ Monitors player execution and validates outputs
- ✓ Requests iteration if needed ("Please dig deeper on X")
- ✓ Prevents false starts with oversight
- ✓ Synthesizes multiple player outputs into coherent resolution

**When it's done**: You have a routed decision with specialist work underway/completed

---

### 4. Code Analyzer (Specialist Player)
**Role**: Diagnostic expert for code issues  
**Input**: Ticket + system context  
**Output**: Root cause analysis + code fix proposal

- ✓ Locates and traces relevant code
- ✓ Identifies logic errors, bugs, performance bottlenecks
- ✓ Proposes specific fixes with rationale
- ✓ Scans for similar issues in related code
- ✓ Suggests test cases for verification

**Used when**: The problem is code-level (logic error, performance, crash)

---

### 5. Docs Generator (Specialist Player)
**Role**: Documentation specialist  
**Input**: Ticket + system context  
**Output**: Generated or updated documentation

- ✓ Identifies documentation gaps
- ✓ Researches implementation to write docs
- ✓ Maintains consistency with existing style
- ✓ Includes examples and troubleshooting
- ✓ Cross-references related documentation

**Used when**: Problem involves missing/outdated docs or API specs

---

### 6. Integration Troubleshooter (Specialist Player)
**Role**: Cross-system problem specialist  
**Input**: Ticket + system context  
**Output**: Integration analysis + fix proposal

- ✓ Maps system boundaries and communication
- ✓ Traces request/response flows across systems
- ✓ Identifies protocol/format/auth mismatches
- ✓ Proposes integration-level fixes
- ✓ Considers versioning and backward compatibility

**Used when**: Problem involves multiple systems, APIs, or data contracts

---

## Typical Workflows

### Workflow 1: Code Bug
```
User: "API response times increased by 50%"
  → Planner: Routing to Code Analyzer (performance issue)
  → Code Analyzer: Identifies N+1 query pattern, proposes batch loading fix
  → Planner: Validates fix, considers if docs need update
  → Result: Code fix + optional docs update
```

### Workflow 2: Missing Documentation
```
User: "How do I configure the integration module?"
  → Planner: Routing to Docs Generator (doc gap)
  → Docs Generator: Creates config documentation with examples
  → Planner: Validates completeness against code
  → Result: Generated documentation
```

### Workflow 3: Integration Failure
```
User: "Messages not arriving from System A"
  → Planner: Routing to Integration Troubleshooter (cross-system)
  → Integration Troubleshooter: Identifies schema mismatch between A and B
  → Planner: Checks if Code Analyzer needed for adaptation layer
  → Result: Integration fix + possibly code changes
```

### Workflow 4: Complex Multi-Issue
```
User: "Performance degraded since v2.0 release"
  → Inventory Agent: Researches changes in v2.0
  → Summary Reviewer: Validates the facts
  → Planner: Identifies 3 issues
    → Issue 1: Code optimization (→ Code Analyzer)
    → Issue 2: Docs incomplete on new config (→ Docs Generator)
    → Issue 3: Integration change not backward-compatible (→ Integration Troubleshooter)
  → Planner: Coordinates all 3, ensures fixes don't conflict
  → Result: Multi-pronged resolution
```

## File Structure

```
ticketing/.kiro/
├── agents/
│   ├── inventory-agent.json         # Producer: researches + summarizes
│   ├── summary-reviewer.json        # QA: validates inventory output
│   ├── planner-agent.json           # Coach: routes to specialists
│   ├── code-analyzer.json           # Player: code diagnostics
│   ├── docs-generator.json          # Player: documentation
│   └── integration-troubleshooter.json # Player: cross-system issues
├── settings/
│   ├── cli.json                     # Kiro CLI configuration
│   └── mcp.json                     # MCP server configuration
└── skills/
    ├── inventory-agent/SKILL.md
    ├── summary-reviewer/SKILL.md
    ├── planner-agent/SKILL.md
    ├── code-analyzer/SKILL.md
    ├── docs-generator/SKILL.md
    └── integration-troubleshooter/SKILL.md
```

## Getting Started

1. **Set up MCP servers** in `settings/mcp.json`
   - File system access
   - Git/code repository
   - Wiki/knowledge base access (if external)

2. **Configure each agent** with appropriate access
   - All agents share same knowledge base resources
   - Specialist agents inherit coach's tool restrictions

3. **Test the workflow**
   ```
   kiro run planner-agent "Test problem description"
   ```

4. **Monitor agent execution**
   - Check routing decisions from Planner
   - Verify specialist outputs
   - Review synthesis for quality

## Configuration Notes

- **All agents** have access to local wiki and documentation
- **Specialist agents** are invoked by Planner as sub-agents
- **Coach oversees** execution within player/coach pattern
- **Tool restrictions** can be configured per agent in `.json` files
- **System prompts** guide each agent's reasoning process

## Best Practices

1. **Start with Inventory Agent** for any new problem domain
2. **Always validate** with Summary Reviewer before acting
3. **Trust the Planner's routing** but review the rationale
4. **Iterate with specialists** if first output is incomplete
5. **Synthesize across agents** when problems are multi-faceted
6. **Document everything** as you learn about the system
