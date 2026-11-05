#!/bin/bash
# Checks the marketplace: the manifest parses, every plugin has a name and a
# url source, names are unique, and every source repo has the ref it names.
set -euo pipefail
cd "$(dirname "$0")/.."
manifest=.claude-plugin/marketplace.json

jq -e '.name and .owner.name and (.plugins | length > 0)' "$manifest" >/dev/null \
  || { echo "fail: $manifest needs name, owner.name and at least one plugin"; exit 1; }

dupes=$(jq -r '.plugins[].name' "$manifest" | sort | uniq -d)
[ -z "$dupes" ] || { echo "fail: duplicate plugin names: $dupes"; exit 1; }

status=0
while IFS=$'\t' read -r name kind url ref; do
  if [ "$kind" != "url" ] || [ -z "$url" ] || [ -z "$ref" ]; then
    echo "fail: $name: source must be {source: url, url, ref}"; status=1; continue
  fi
  if git ls-remote --exit-code "$url" "$ref" >/dev/null 2>&1; then
    echo "ok: $name -> $url@$ref"
  else
    echo "fail: $name: $url has no ref $ref"; status=1
  fi
done < <(jq -r '.plugins[] | [.name, .source.source, .source.url, .source.ref] | @tsv' "$manifest")
exit $status
