# Optimize Image Bot

<!-- optimize-image-bot-readme -->
**Optimize Image Bot** is a Docker container that converts JPG and PNG to optimized WebP for use in Jekyll sites.
<!-- /optimize-image-bot-readme -->

## Configuration

The following Github Action workflow should be added.

```
name: Optimize Images
on: [push]
jobs:
  build:
    if: "!contains(toJSON(github.event.commits.*.message), '@verkilo optimized images')"
    runs-on: ubuntu-latest
    steps:
      - name: Get repo
        uses: actions/checkout@master
        with:
          ref: main
      - name: Get changed files
        id: get_file_changes
        uses: dorner/file-changes-action@v1.2.0
        with:
          githubToken: ${{ secrets.GITHUB_TOKEN }}
          plaintext: true
      - name: Optimize
        uses: docker://merovex/optimize-image-bot:latest
        with:
          args: ${{ steps.get_file_changes.outputs.files }}
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      - name: Commit on change
        uses: stefanzweifel/git-auto-commit-action@v4
        with:
          commit_message: "@verkilo optimized images"

```
