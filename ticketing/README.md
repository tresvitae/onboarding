# Ticketing System with Kiro Multi-Agent Orchestration

A sophisticated problem-solving system using AWS Kiro that coordinates multiple specialized agents to resolve complex tickets through staged analysis and targeted diagnosis.

## Quick Start

```bash
# Start analyzing a ticket
kiro run planner-agent "Description of the problem here"

# Or get system context first
kiro run inventory-agent "What is [system/component] and how does it work?"

# Then validate findings
kiro run summary-reviewer "Review the inventory output for accuracy"
```

## Agent Network

| Agent | Role | When to Use |
|-------|------|-----------|
| **inventory-agent** | Knowledge researcher | Start here for new problems |
| **summary-reviewer** | Fact-checker | Verify inventory accuracy before acting |
| **planner-agent** | Coach/orchestrator | Route complex tickets to specialists |
| **code-analyzer** | Code diagnostics | Logic errors, performance, debugging |
| **docs-generator** | Documentation | Missing docs, API specs, guides |
| **integration-troubleshooter** | Cross-system | API failures, integrations, data contracts |

## Architecture Pattern

**Analysis → Validation → Orchestration → Specialization → Synthesis**

1. **Inventory Agent** researches the problem domain
2. **Summary Reviewer** validates findings for accuracy
3. **Planner Agent** routes to appropriate specialist(s)
4. **Specialist Agents** (code, docs, integration) dive deep
5. **Synthesis** combines outputs into actionable resolution

## Key Features

✓ **Coach-Player Workflow**: Planner agent actively oversees specialist execution  
✓ **Multi-Specialization**: Route to 1 or more specialists based on problem type  
✓ **Fact-Checking**: Every claim validated before acting  
✓ **Context Preservation**: Full ticket context maintained across agent handoffs  
✓ **Feedback Loops**: Coach can request clarification or iteration from players  

## Configuration

All configuration files are in `.kiro/`:

- `agents/`: Individual agent definitions (JSON)
- `settings/`: MCP servers and CLI config
- `skills/`: Agent workflow documentation (SKILL.md)

See [AGENTS.md](.kiro/AGENTS.md) for complete system architecture.

## Documentation

- [.kiro/AGENTS.md](.kiro/AGENTS.md) — System architecture and workflows
- [.kiro/skills/](./kiro/skills/) — Individual agent skill documentation
- [README.md](../README.md) — Main repository documentation

## Example Use Cases

### Case 1: Performance Degradation
```
Input: "API response times increased 50% after v2.0"
→ Inventory Agent: Research changes in v2.0
→ Summary Reviewer: Validate findings
→ Planner Agent: Identifies 3 issues
  → Code Analyzer: Query optimization needed
  → Docs Generator: Config documentation missing
  → Integration Troubleshooter: API change not backward-compatible
→ Output: Coordinated fixes across all 3 areas
```

### Case 2: Integration Failure
```
Input: "Messages not being delivered from upstream"
→ Planner Agent: Routes to Integration Troubleshooter
→ Integration Agent: Maps systems, traces flows, identifies schema mismatch
→ Planner: Checks if code changes needed
→ Output: Format fix + adapter layer if needed
```

## Best Practices

1. **Always start with inventory** for unfamiliar problems
2. **Validate before acting** using the summary reviewer
3. **Review routing rationale** when planner delegates
4. **Iterate with players** if first output is incomplete
5. **Synthesize holistically** when issues are multi-faceted
6. **Document discoveries** as you learn

## File Structure

```
ticketing/
├── .kiro/                          # Kiro configuration
│   ├── agents/                     # Agent definitions
│   │   ├── inventory-agent.json
│   │   ├── summary-reviewer.json
│   │   ├── planner-agent.json
│   │   ├── code-analyzer.json
│   │   ├── docs-generator.json
│   │   └── integration-troubleshooter.json
│   ├── settings/                   # Configuration
│   │   ├── cli.json
│   │   └── mcp.json
│   ├── skills/                     # Documentation
│   │   ├── inventory-agent/
│   │   ├── summary-reviewer/
│   │   ├── planner-agent/
│   │   ├── code-analyzer/
│   │   ├── docs-generator/
│   │   └── integration-troubleshooter/
│   └── AGENTS.md                   # System architecture
└── README.md                        # This file
```

For detailed system architecture, see [.kiro/AGENTS.md](.kiro/AGENTS.md).
