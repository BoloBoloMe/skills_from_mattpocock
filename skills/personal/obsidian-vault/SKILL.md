---
name: obsidian-vault
description: 在 Obsidian vault 中使用 wikilinks 和索引笔记搜索、创建和管理笔记。当用户想在 Obsidian 中查找、创建或整理笔记时使用。
---

# Obsidian Vault

## Vault 位置

`/mnt/d/Obsidian Vault/AI Research/`

根层级基本是扁平结构。

## 命名约定

- **索引笔记**：汇总相关主题（例如 `Ralph Wiggum Index.md`、`Skills Index.md`、`RAG Index.md`）
- 所有笔记名称使用**标题式大小写（Title Case）**
- 不使用文件夹组织 - 改用链接和索引笔记

## 链接

- 使用 Obsidian `[[wikilinks]]` 语法：`[[Note Title]]`
- 笔记底部链接到依赖/相关笔记
- 索引笔记只是 `[[wikilinks]]` 列表

## 工作流

### 搜索笔记

```bash
# 按文件名搜索
find "/mnt/d/Obsidian Vault/AI Research/" -name "*.md" | grep -i "keyword"

# 按内容搜索
grep -rl "keyword" "/mnt/d/Obsidian Vault/AI Research/" --include="*.md"
```

或直接在 vault 路径上使用 Grep/Glob 工具。

### 创建新笔记

1. 文件名使用**标题式大小写（Title Case）**
2. 按学习单元（依照 vault 规则）编写内容
3. 在底部添加指向相关笔记的 `[[wikilinks]]`
4. 如果属于编号序列的一部分，使用层级编号方案

### 查找相关笔记

在整个 vault 中搜索 `[[Note Title]]` 以查找反向链接：

```bash
grep -rl "\\[\\[Note Title\\]\\]" "/mnt/d/Obsidian Vault/AI Research/"
```

### 查找索引笔记

```bash
find "/mnt/d/Obsidian Vault/AI Research/" -name "*Index*"
```
