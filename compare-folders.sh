#!/bin/zsh
## ~/projects/compare-folders.sh   chatgpt loverk jjffb4a  2025.05.11

# === Colors ===
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# === Prompt for folder paths ===
echo "${BLUE}🔍 Enter path to original folder:${NC}"
read ORIGINAL
echo "${BLUE}🗂️  Enter path to backup folder:${NC}"
read BACKUP

echo ""
echo "${YELLOW}📁 Comparing:${NC}"
echo "Original → $ORIGINAL"
echo "Backup   → $BACKUP"
echo ""

# === Step 1: Compare folder size ===
read "DO_SIZE?${YELLOW}Step 1️⃣: Compare folder size? (y/n) ${NC}"
if [[ "$DO_SIZE" == "y" ]]; then
  echo "${BLUE}📦 Folder sizes:${NC}"
  du -sh "$ORIGINAL"
  du -sh "$BACKUP"
  echo ""
fi

# === Step 2: Compare file count ===
read "DO_COUNT?${YELLOW}Step 2️⃣: Compare file count? (y/n) ${NC}"
if [[ "$DO_COUNT" == "y" ]]; then
  echo "${BLUE}🧮 Counting files...${NC}"
  ORIG_COUNT=$(find "$ORIGINAL" -type f | wc -l)
  BACK_COUNT=$(find "$BACKUP" -type f | wc -l)
  echo "Original: ${GREEN}$ORIG_COUNT${NC} files"
  echo "Backup  : ${GREEN}$BACK_COUNT${NC} files"
  echo ""
fi

# === Step 3: Rsync dry-run ===
read "DO_RSYNC?${YELLOW}Step 3️⃣: Preview differences with rsync (dry-run)? (y/n) ${NC}"
if [[ "$DO_RSYNC" == "y" ]]; then
  echo "${BLUE}🔄 Running rsync dry-run...${NC}"
  rsync -anv "$ORIGINAL/" "$BACKUP/"
  echo ""
fi

# === Step 4: Full diff ===
read "DO_DIFF?${YELLOW}Step 4️⃣: Run deep file diff (diff -qr)? (y/n) ${NC}"
if [[ "$DO_DIFF" == "y" ]]; then
  echo "${BLUE}⚖️  Running full diff (may take time)...${NC}"
  diff -qr "$ORIGINAL" "$BACKUP"
  echo ""
fi

# === Step 5: Checksum comparison ===
read "DO_HASH?${YELLOW}Step 5️⃣: Generate and compare checksums? (y/n) ${NC}"
if [[ "$DO_HASH" == "y" ]]; then
  echo "${BLUE}🔐 Generating checksums (this may take a while)...${NC}"
  find "$ORIGINAL" -type f -exec shasum {} \; | sort > /tmp/orig_hashes.txt
  find "$BACKUP"   -type f -exec shasum {} \; | sort > /tmp/backup_hashes.txt
  echo "${BLUE}🔍 Comparing checksums...${NC}"
  diff /tmp/orig_hashes.txt /tmp/backup_hashes.txt > /tmp/hash_diff.txt
  if [[ -s /tmp/hash_diff.txt ]]; then
    echo "${RED}❗ Differences found in file content:${NC}"
    cat /tmp/hash_diff.txt
  else
    echo "${GREEN}✅ Checksums match — folders are identical in content.${NC}"
  fi
  echo ""
fi

echo "${GREEN}✅ Done!${NC}"
