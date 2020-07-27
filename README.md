ParkHub Release Rebase
======================

GitHub action to rebase lower environment branches using the recursive, patience
strategy when the main branch is updated. Use this action to rebase development
and testing branches after a release to make sure that new work includes code
from the latest release and any hotfixes since the latest release.

The recursive, patience strategy will pend extra time to avoid merge conflicts.

Usage Example
-------------

```yaml
name: Rebase On Release

on:
  push:
    branches:
      # All pushes to this branch will trigger the task.
      - master

env:
  GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

jobs:
  rebase_branches:
    runs-on: ubuntu-latest
    steps:
      - name: Check out action code
        uses: actions/checkout@v2
      - name: Rebase dev/test branches on master
        uses: parkhub/github-action-release-rebase@main
        with:
          base_ref: master
          head_branches: develop qa staging
```

Requirements
------------

- `base_ref` must be a valid branch, tag, or commit (the git ref deployed to
	production) in the GitHub repository
* `head_branches` must be existing branches in the GitHub repository to rebase

Acknowledgements
----------------

This action is based on [Local Git
Rebase](https://github.com/marketplace/actions/local-git-rebase) and [Cirrus
Actions Rebase](https://github.com/marketplace/actions/automatic-rebase).
