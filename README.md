# Lanework marketplace

The Claude Code plugin marketplace for [Lanework](https://github.com/laneworkapp) boards. Add it once, then install the plugins you want.

```
/plugin marketplace add https://github.com/laneworkapp/lanework-marketplace.git
/plugin install lanework@lanework
```

## Plugins

| plugin | what it is | repo |
|---|---|---|
| `lanework` | Agent skills for Lanework boards: founding and working boards, a standing watch, discovery, planning, merging and healing. | [lanework-skills](https://github.com/laneworkapp/lanework-skills) |

Each plugin lives in its own repo and installs from that repo's `stable` branch, which only moves when a release ships. `/plugin marketplace update lanework` picks up new releases.

## Adding a plugin

1. The plugin repo has a `.claude-plugin/plugin.json` at its root and a `stable` branch.
2. Add an entry to `.claude-plugin/marketplace.json` with a `url` source and `"ref": "stable"`.
3. Add a row to the table above.
4. `scripts/check.sh` passes: the manifest parses, names are unique, and every source repo has its ref.
