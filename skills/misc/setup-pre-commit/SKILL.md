---
name: setup-pre-commit
description: 在当前仓库中设置带有 lint-staged（Prettier）、类型检查和测试的 Husky pre-commit hooks。当用户想添加 pre-commit hooks、设置 Husky、配置 lint-staged，或添加提交时格式化/类型检查/测试时使用。
---

# 设置预提交 Hooks（Pre-Commit Hooks）

## 将设置什么

- **Husky** 预提交 hook（pre-commit hook）
- **lint-staged**：对所有已暂存文件运行 Prettier
- **Prettier** 配置（如果缺失）
- 预提交 hook（pre-commit hook）中的 **typecheck** 和 **test** 脚本（scripts）

## 步骤

### 1. 检测包管理器

检查是否存在 `package-lock.json`（npm）、`pnpm-lock.yaml`（pnpm）、`yarn.lock`（yarn）、`bun.lockb`（bun）。使用已存在的那个。不明确时默认使用 npm。

### 2. 安装依赖

作为开发依赖（devDependencies）安装：

```
husky lint-staged prettier
```

### 3. 初始化 Husky

```bash
npx husky init
```

这会创建 `.husky/` 目录，并向 package.json 添加 `prepare: "husky"`。

### 4. 创建 `.husky/pre-commit`

写入此文件（Husky v9+ 不需要 shebang）：

```
npx lint-staged
npm run typecheck
npm run test
```

**适配**：将 `npm` 替换为检测到的包管理器。如果仓库的 package.json 中没有 `typecheck` 或 `test` 脚本（script），则省略对应行并告知用户。

### 5. 创建 `.lintstagedrc`

```json
{
  "*": "prettier --ignore-unknown --write"
}
```

### 6. 创建 `.prettierrc`（如果缺失）

仅在不存在 Prettier 配置时创建。使用这些默认值：

```json
{
  "useTabs": false,
  "tabWidth": 2,
  "printWidth": 80,
  "singleQuote": false,
  "trailingComma": "es5",
  "semi": true,
  "arrowParens": "always"
}
```

### 7. 验证

- [ ] `.husky/pre-commit` 存在且可执行
- [ ] `.lintstagedrc` 存在
- [ ] package.json 中的 `prepare` 脚本（script）是 `"husky"`
- [ ] 存在 `prettier` 配置
- [ ] 运行 `npx lint-staged` 验证它可正常工作

### 8. 提交

暂存所有已更改/新建的文件，并使用提交消息：`添加预提交 hooks（husky + lint-staged + prettier）`

这会运行新的预提交 hooks（pre-commit hooks）——是确认一切可用的良好冒烟测试。

## 备注

- Husky v9+ 的 hook 文件不需要 shebang
- `prettier --ignore-unknown` 会跳过 Prettier 无法解析的文件（图片等）
- pre-commit 会先运行 lint-staged（快速，仅限已暂存文件），然后运行完整的类型检查和测试
