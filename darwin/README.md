# 🍎 Joaozinho macOS Nix Flake Setup

A step-by-step guide to bootstrap this nix-darwin configuration from scratch on macOS.
Homebrew is managed entirely by `nix-homebrew` — no manual installation needed.

---

## Setup

### Step 1 — Install Nix

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

Restart your terminal after the installer finishes, or source the profile it tells you to.

---

### Step 2 — Save the Flake

Create a directory and place `flake.nix` inside it:

```bash
mkdir -p ~/.config/nix-darwin
cd ~/.config/nix-darwin
# copy flake.nix here
```

> **Important:** Replace `"joaozinho"` with your actual macOS username in two places inside `flake.nix`:
> - The `darwinConfigurations."joaozinho"` key (used in the apply command)
> - The `nix-homebrew.user = "joaozinho"` field

Then initialize a Git repo and stage the file — Nix flakes only see tracked files:

```bash
git init
git add flake.nix
```

---

### Step 3 — Apply the Flake

```bash
nix run nix-darwin -- switch --flake ~/.config/nix-darwin#joaozinho
```

This single command will:
- Install `nix-darwin`
- Install Homebrew automatically via `nix-homebrew` (`autoMigrate = true`)
- Install all Nix packages, brews, casks, and Mac App Store apps
- Apply all system defaults (dock, finder, dark mode, etc.)
- Install fonts

That's it. 🎉

---

## Updating

After editing `flake.nix`:

```bash
cd ~/.config/nix-darwin
git add flake.nix
darwin-rebuild switch --flake .#joaozinho
```

To update all flake inputs to their latest versions:

```bash
cd ~/.config/nix-darwin
nix flake update
darwin-rebuild switch --flake .#joaozinho
```

---

## Troubleshooting

**`darwin-rebuild: command not found` after first apply**
Close and reopen your terminal. If it persists:
```bash
export PATH=/run/current-system/sw/bin:$PATH
```

**`error: getting status of 'flake.nix': No such file or directory`**
You need to stage the file first:
```bash
git add flake.nix
```

**Mac App Store apps not installing**
You must be signed into the App Store with an Apple ID that has previously acquired the app. `mas` cannot install apps you've never downloaded before.

**Rosetta errors**
Enable it manually:
```bash
softwareupdate --install-rosetta --agree-to-license
```

---

## Quick Reference

| Task | Command |
|------|---------|
| First-time setup | `nix run nix-darwin -- switch --flake ~/.config/nix-darwin#joaozinho` |
| Apply changes | `darwin-rebuild switch --flake .#joaozinho` |
| Update flake inputs | `nix flake update` |
| Build without applying | `darwin-rebuild build --flake .#joaozinho` |
| Rollback | `darwin-rebuild switch --rollback` |