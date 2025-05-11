# 🗂️ compare-folders

Interactive shell script to compare two folders in macOS — ordered by speed of checks and with optional steps.

## ✅ Features

- Step-by-step folder comparison
- Ask before each operation
- Sort steps by runtime: fast → deep
- Colorized output for better clarity

## 🔄 What It Checks

1. Folder size (`du`)
2. File count (`find`)
3. `rsync` dry-run preview
4. Full recursive `diff`
5. `shasum`-based content comparison

## 🚀 How to Use

```bash
git clone https://github.com/jjffb4a/compare-folders.git
cd compare-folders
chmod +x compare-folders.sh
./compare-folders.sh
```

## 🔐 SSH Clone Option (if key is set up)

```bash
git clone git@github.com:jjffb4a/compare-folders.git
```

## 💡 Tip

Edit `compare-folders.sh` to customize logic, e.g.:
- auto-skipping steps
- changing color schemes
- enabling logging

## 🛠 Requirements

- macOS Terminal
- Built-in Unix tools: `find`, `du`, `diff`, `shasum`, `rsync`
- Optional: `ncdu` (`brew install ncdu`)

MIT License — use freely, adapt, contribute.
