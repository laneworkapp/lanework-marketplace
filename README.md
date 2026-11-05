# Lanework marketplace

Claude Code plugins for [Lanework](https://laneworkapp.com) boards.

A Lanework board is a folder of plain directories and Markdown files that the Lanework macOS app renders live as a kanban board. There's no API and nothing to sync. An agent works a board by reading and editing its files, just as you do through the app. These plugins teach Claude Code to do that well: found a board, file and move cards, write comments you can act on, watch a board for changes, and repair one that has drifted.

This repo is the catalog. Add it to Claude Code once, then install the plugins you want from it.

## Get started

You need [Claude Code](https://claude.com/claude-code) and the Lanework app on macOS.

**1. Add the marketplace.** In Claude Code, run:

```
/plugin marketplace add https://github.com/laneworkapp/lanework-marketplace.git
```

**2. Install the plugin.**

```
/plugin install lanework@lanework
```

**3. Load it.** Run `/reload-plugins`, or start a new Claude Code session.

**4. Check it's there.** `/plugin` lists `lanework` as installed and enabled.

**5. Found a board.** In a project folder, ask Claude:

> Found a pipeline board for this project.

Claude creates a `<Name> Pipeline.lanework` folder, with lanes that run from Ideas to Done. Open it in the Lanework app.

**6. Put it to work.** Add a card or two in Ideas, and move one into Shaping. Then ask Claude:

> Sweep the pipeline board.

Claude reads the board and tells you what's waiting on you, such as new cards in Ideas to triage. It shapes the card in Shaping into a proposal and moves it to Proposed for your review. Approve it by moving it to Approved, and the next sweep builds it.

### Installing by hand

To follow the latest work in progress instead of releases, or to use the skills with an agent that reads Claude-style skill folders, install them by hand. Clone the plugin's repo and link its skill folders into place, as described in [lanework-skills § Install](https://github.com/laneworkapp/lanework-skills#install). Don't install both ways, or each skill loads twice.

## Plugins

| plugin | what it's for | repo |
|---|---|---|
| `lanework` | Founding and working boards, a standing watch, discovery, planning, merging and healing. | [lanework-skills](https://github.com/laneworkapp/lanework-skills) |

### `lanework`

| skill | what it does |
|---|---|
| `lanework` | The basics the others build on: what a board is, how to read one, the write rules every board shares, and founding a new board. |
| `work` | Working a board: filing and moving cards, writing card bodies and comments, sweeping and triaging, and handing build work to subagents. |
| `watch` | A standing watch on one or more boards, responding to changes as they arrive. |
| `dispatch` | The same watch for a long session: each change goes to a fresh subagent, so the session's own context stays small. |
| `discovery` | A guided examination of a project's problem and domain, run in rounds on a discovery board. |
| `plan` | Planning an idea too big for one session: chart its open decisions as ticket cards, then resolve one per session. |
| `merge` | Resolving git conflicts on a board with no human, keeping content from both sides. |
| `heal` | Bringing an existing board up to the current skills and app version. |

Most skills start on their own when you mention a board. These start only when you type the command:

| command | what it does |
|---|---|
| `/lanework:watch <board>` | Watches one or more boards until you say stop. |
| `/lanework:dispatch <board>` | Watches the same way, handing each change to a fresh subagent. |
| `/lanework:discovery <topic>` | Starts or resumes a discovery session. |
| `/lanework:plan <idea>` | Charts a plan for an idea, or resumes its plan board. |
| `/lanework:heal <board>` | Shows what it would repair on a board, then applies it when you say go. |

Each skill's full guide is in the plugin's repo.

## Updating

Each plugin installs from its repo's `stable` branch, which only moves when a release ships. To pick up new releases, run:

```
/plugin marketplace update lanework
```

Then run `/reload-plugins`.

## Moving from the old marketplace

Before this repo existed, you added the `lanework` plugin from the `lanework-skills` repo directly. Both marketplaces are named `lanework`, so remove the old one first:

```
/plugin marketplace remove lanework
/plugin marketplace add https://github.com/laneworkapp/lanework-marketplace.git
/plugin install lanework@lanework
```

You get the same plugin from the same `stable` branch. Only the catalog's address changes.

## Troubleshooting

- **Adding the marketplace fails because `lanework` already exists**: the old marketplace is still added. Follow Moving from the old marketplace above.
- **Skills don't show up after installing**: run `/reload-plugins`, or start a new session.
- **Each skill shows up twice**: you also installed the skills by hand, as links in `~/.claude/skills/`. Remove those links.

## Adding a plugin

For maintainers:

1. The plugin repo has a `.claude-plugin/plugin.json` at its root and a `stable` branch.
2. Add an entry to `.claude-plugin/marketplace.json` with a `url` source and `"ref": "stable"`.
3. Add it to the Plugins table above.
4. `scripts/check.sh` passes: the manifest parses, names are unique, and every source repo has its ref. CI runs it on every push, and weekly.

## License

MIT. See [LICENSE](LICENSE).
