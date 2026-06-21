# 编写 Agent Brief

Agent brief 是当 issue 或 PR 移到 `ready-for-agent` 时在其上发布的结构化评论. 它是 AFK agent 将工作依据的权威规格. 原始 body 和讨论是上下文 - agent brief 是契约.

Brief 陈述 **agent 应做什么**, 这延伸到两种表面: 对于 issue, 从零开始构建变更; 对于 PR, 是 *对已有 diff* 还需要做的 - 完成它, 填补空缺, 处理审查点. 两种情况原理相同; 下方 PR 示例展示差异.

## 原则

### 持久性优于精确性

Issue 可能停留在 `ready-for-agent` 数天或数周. 代码库在此期间会变化. 写 brief 使它即使文件被重命名, 移动或重构也能保持有用.

- **要** 描述 interface, 类型, 和行为契约
- **要** 命名 agent 应查找或修改的特定类型, 函数签名, 或配置形状
- **不要** 引用文件路径 - 它们会过期
- **不要** 引用行号
- **不要** 假设当前实现结构将保持不变

### 行为性, 不是程序性

描述系统 **应该做什么**, 不是 **如何实现**. Agent 将新鲜地探索代码库并做出自己的实现决策.

- **好:** "`SkillConfig` 类型应接受可选的 `schedule` 字段, 类型为 `CronExpression`"
- **坏:** "打开 src/types/skill.ts 并在第 42 行添加 schedule 字段"
- **好:** "当用户不带参数运行 `/triage` 时, 他们应看到需要关注的 issue 概要"
- **坏:** "在主 handler 函数中添加 switch statement"

### 完整的验收标准

Agent 需要知道何时完成. 每个 agent brief 必须有具体, 可测试的验收标准. 每个标准应独立可验证.

- **好:** "运行 `gh issue list --label needs-triage` 返回经过初始分类的 issue"
- **坏:** "Triage 应正确工作"

### 明确范围边界

声明什么超出范围. 这阻止 agent 过度镀金或对相邻功能做假设.

## 模板

```markdown
## Agent Brief

**Category:** bug / enhancement
**Summary:** 一行描述需要发生什么

**Current behavior:**
描述现在发生了什么. 对于 bug, 这是坏的行为.
对于 enhancement, 这是功能构建于的现状.

**Desired behavior:**
描述 agent 工作完成后应发生什么.
对边缘情况和错误条件要具体.

**Key interfaces:**
- `TypeName` - 什么需要改变以及为什么
- `functionName()` return type - 当前返回什么 vs 应该返回什么
- Config shape - 任何需要的新配置选项

**Acceptance criteria:**
- [ ] 具体, 可测试的标准 1
- [ ] 具体, 可测试的标准 2
- [ ] 具体, 可测试的标准 3

**Out of scope:**
- 不应在此 issue 中改变或处理的东西
- 可能看似相关但实际上是独立的相邻功能
```

## 示例

### 好的 agent brief (bug)

```markdown
## Agent Brief

**Category:** bug
**Summary:** Skill description 截断在单词中间, 产出残缺输出

**Current behavior:**
当 skill description 超过 1024 字符时, 它在恰好 1024 字符处截断,
不顾单词边界. 这产出了在单词中间结束的 description
(例如 "Use when the user wants to confi").

**Desired behavior:**
截断应在 1024 字符之前最后一个单词边界处断开
并附加 "..." 表示截断.

**Key interfaces:**
- `SkillMetadata` type 的 `description` 字段 - 不需要类型变更,
  但填充它的 validation/processing 逻辑需要尊重单词边界
- 任何读取 SKILL.md frontmatter 并提取 description 的函数

**Acceptance criteria:**
- [ ] 1024 字符以下的 description 不变
- [ ] 1024 字符以上的 description 在 1024 字符之前最后一个单词边界处截断
- [ ] 截断的 description 以 "..." 结尾
- [ ] 包括 "..." 的总长度不超过 1024 字符

**Out of scope:**
- 改变 1024 字符限制本身
- 多行 description 支持
```

### 好的 agent brief (enhancement)

```markdown
## Agent Brief

**Category:** enhancement
**Summary:** 添加 `.out-of-scope/` 目录支持, 用于跟踪被拒绝的功能请求

**Current behavior:**
当功能请求被拒绝时, issue 以 `wontfix` label 和评论关闭.
没有决策或推理的持久记录.
未来类似的请求需要维护者回忆或搜索先前的讨论.

**Desired behavior:**
被拒绝的功能请求应记录在 `.out-of-scope/<concept>.md` 文件中,
捕获决策, 推理, 以及链接到请求该功能的所有 issue.
在 triage 新 issue 时, 这些文件应被检查以寻找匹配.

**Key interfaces:**
- `.out-of-scope/` 中的 Markdown 文件格式 - 每个文件应有
  `# Concept Name` 标题, `**Decision:**` 行, `**Reason:**` 行,
  以及 `**Prior requests:**` 列表带 issue 链接
- Triage 工作流应在早期读取所有 `.out-of-scope/*.md` 文件
  并按概念相似性将收到的 issue 与它们匹配

**Acceptance criteria:**
- [ ] 关闭功能为 wontfix 时创建/更新 `.out-of-scope/` 中的文件
- [ ] 文件包含决策, 推理, 以及到关闭 issue 的链接
- [ ] 如果匹配的 `.out-of-scope/` 文件已存在, 新 issue
      被追加到其 "Prior requests" 列表而不是创建重复
- [ ] triage 时, 已有 `.out-of-scope/` 文件被检查并在
      新 issue 匹配先前拒绝时被提出

**Out of scope:**
- 自动匹配 (人类确认匹配)
- 重新打开先前被拒绝的功能
- Bug 报告 (仅 enhancement 拒绝进入 `.out-of-scope/`)
```

### 好的 agent brief (PR)

对于 PR, "Current behavior" 描述 diff 的状态, brief 要求 agent 完成或修复它而不是从零构建.

```markdown
## Agent Brief

**Category:** enhancement
**Summary:** 完成贡献者的 `--json` 输出标志 for `triage list`

**Current behavior:**
PR 添加一个 `--json` 标志将 issue 列表序列化为 JSON. 正常路径工作
且 diff 符合项目的命令结构. 两个缺口仍存:
错误仍以人类文本打印 (不是 JSON), 且新标志没有测试覆盖.

**Desired behavior:**
使用 `--json`, 所有输出 - 包括错误 - 是 stdout 上的良好格式 JSON,
命令的 exit code 不变. 缺少标志时已有的可读输出不变.

**Key interfaces:**
- 命令的错误路径应在 `--json` 下发出 `{ "error": string }`
  而不是纯文本错误
- 复用 PR 已添加的已有 serializer; 不要引入第二个

**Acceptance criteria:**
- [ ] `triage list --json` 对成功和错误情况都发出有效 JSON
- [ ] Exit code 与非 JSON 命令匹配
- [ ] 测试覆盖 `--json` 成功输出和一个错误情况
- [ ] 默认 (非 JSON) 输出 byte-for-byte 不变

**Out of scope:**
- 为任何其他命令添加 `--json`
- 改变 PR 已定义的成功 payload 的 JSON 形状
```

### 坏的 agent brief

```markdown
## Agent Brief

**Summary:** Fix the triage bug

**What to do:**
The triage thing is broken. Look at the main file and fix it.
The function around line 150 has the issue.

**Files to change:**
- src/triage/handler.ts (line 150)
- src/types.ts (line 42)
```

这是坏的因为:
- 没有类别
- 模糊描述 ("the triage thing is broken")
- 引用会过期的文件路径和行号
- 没有验收标准
- 没有范围边界
- 没有描述当前 vs 期望行为
