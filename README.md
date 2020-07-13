ParkHub Release Rebase
======================

GitHub action to rebase lower environment branches using the recursive, ours
strategy when the main branch is updated. Use this action to rebase development
and testing branches after a release to make sure that new work includes code
from the latest release and any hotfixes since the latest release.

The recursive, ours strategy will resolve merge conflicts by choosing the
changes from the source ref and discarding the changes from the head branch.

Usage Example
-------------

```yaml
name: Rebase On Release
on:
  push:
    branches:
      # All pushes to this branch will trigger the task.
      - master
jobs:
  rebase_branches:
    runs-on: ubuntu-latest
    steps:
      - name: Rebase develop on master
        uses: parkhub/github-action-release-rebase@main
        with:
          head_branch: develop
          base_ref: master
      - name: Rebase qa on master
        uses: parkhub/github-action-release-rebase@main
        with:
          head_branch: qa
          base_ref: master
      - name: Rebase staging on master
        uses: parkhub/github-action-release-rebase@main
        with:
          head_branch: staging
          base_ref: master
```

Requirements
------------

- `base_ref` must be a valid branch, tag, or commit (the git ref deployed to
	production) in the GitHub repository
* `head_branch` must be an existing branch in the GitHub repository

Acknowledgements
----------------

This action is based on [Local Git
Rebase](https://github.com/marketplace/actions/local-git-rebase).
