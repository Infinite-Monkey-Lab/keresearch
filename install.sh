#!/usr/bin/env bash
#
# Keresearch 一键安装脚本
# 将三个科研 Agent Skills 安装到 ZCode (~/.agents/skills) 和/或 Claude Code (~/.claude/skills)
#
# 用法:
#   bash install.sh           # 默认复制到 ~/.agents/skills 和 ~/.claude/skills
#   bash install.sh --link    # 使用软链接安装（后续 git pull 自动同步更新）
#   bash install.sh --zcode   # 仅安装到 ~/.agents/skills
#   bash install.sh --claude  # 仅安装到 ~/.claude/skills

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS=("research-project-playbook" "research-paper-writing" "paper-writing")

USE_SYMLINK=false
TARGET_AGENTS=true
TARGET_CLAUDE=true

for arg in "$@"; do
  case "$arg" in
    --link|-l)
      USE_SYMLINK=true
      ;;
    --zcode|--agents)
      TARGET_AGENTS=true
      TARGET_CLAUDE=false
      ;;
    --claude)
      TARGET_AGENTS=false
      TARGET_CLAUDE=true
      ;;
    --help|-h)
      echo "用法: bash install.sh [--link] [--zcode | --claude]"
      echo "  --link, -l   使用符号链接而非复制文件（方便 git pull 同步）"
      echo "  --zcode      仅安装到 ~/.agents/skills（ZCode / 通用 Agent）"
      echo "  --claude     仅安装到 ~/.claude/skills（Claude Code）"
      exit 0
      ;;
  esac
done

install_to_dir() {
  local dest_root="$1"
  mkdir -p "$dest_root"
  echo "📂 目标目录: $dest_root"

  for skill in "${SKILLS[@]}"; do
    local src="$SCRIPT_DIR/$skill"
    local dst="$dest_root/$skill"

    if [ -e "$dst" ] || [ -L "$dst" ]; then
      rm -rf "$dst"
    fi

    if [ "$USE_SYMLINK" = true ]; then
      ln -s "$src" "$dst"
      echo "  🔗 已链接: $skill -> $dst"
    else
      cp -r "$src" "$dst"
      echo "  ✅ 已安装: $skill -> $dst"
    fi
  done
}

echo "=== 🧪 Keresearch Agent Skills 安装 ==="
echo ""

if [ "$TARGET_AGENTS" = true ]; then
  install_to_dir "$HOME/.agents/skills"
  echo ""
fi

if [ "$TARGET_CLAUDE" = true ]; then
  install_to_dir "$HOME/.claude/skills"
  echo ""
fi

echo "🎉 安装完成！已就绪的科研技能："
echo "  • /research-project-playbook  （选题、实验纪律、发现日志、去AI味与投稿策略）"
echo "  • /research-paper-writing     （章节结构、段落流、反向大纲与审稿人视角自查）"
echo "  • /paper-writing              （6阶段头脑风暴、句子工艺与 M1-M18/S1-S31 双门禁）"
