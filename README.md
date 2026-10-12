# Moved

The eudi-dev formula moved to the tap of the eudi-dev organization:

```sh
brew install eudi-dev/tap/eudi-dev
```

`brew update` moves an installed formula there. Homebrew loads formulas only from trusted taps, so trust the new one before you upgrade:

```sh
brew trust eudi-dev/tap
brew upgrade eudi-dev
```

You can then remove this tap with `brew untap dominikschlosser/tap`.
