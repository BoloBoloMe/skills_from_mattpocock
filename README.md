<p>
  <a href="https://www.aihero.dev/s/skills-newsletter">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://res.cloudinary.com/total-typescript/image/upload/v1777382277/skills-repo-dark_2x.png">
      <source media="(prefers-color-scheme: light)" srcset="https://res.cloudinary.com/total-typescript/image/upload/v1777382277/skill-repo-light_2x.png">
      <img alt="技能" src="https://res.cloudinary.com/total-typescript/image/upload/v1777382277/skill-repo-light_2x.png" width="369">
    </picture>
  </a>
</p>

# 面向真实工程师的 Skills

[![skills.sh](https://skills.sh/b/mattpocock/skills)](https://skills.sh/mattpocock/skills)

这是我每天用来做真实工程工作的 agent skills——不是“凭感觉写代码”（vibe coding）。

开发真实应用很难。GSD、BMAD 和 Spec-Kit 之类的方法试图通过接管流程来提供帮助。但它们这样做的同时，也拿走了你的控制权，并让流程中的 bug 难以解决。

这些 skills 被设计得小巧、易于适配且可组合。它们适用于任何模型。它们基于数十年的工程经验。随便折腾它们。把它们变成你自己的东西。祝你玩得开心。

如果你想跟进这些 skills 的变化，以及我创建的任何新 skill，可以加入我的新闻简报（newsletter），和约 60,000 名其他开发者一起订阅：

[订阅 Newsletter](https://www.aihero.dev/s/skills-newsletter)

## 快速开始（30 秒设置）

1. 运行 skills.sh 安装器：

```bash
npx skills@latest add mattpocock/skills
```

2. 选择你想要的 skills，以及想把它们安装到哪些编码智能体（coding agents）上。**确保选中 `/setup-matt-pocock-skills`**。

3. 在你的智能体（agent）中运行 `/setup-matt-pocock-skills`。它会：
   - 询问你想使用哪个 issue tracker（GitHub、Linear 或本地文件）
   - 询问你在 triage tickets 时会应用哪些标签（`/triage` 会使用标签）
   - 询问你想把我们创建的任何文档保存到哪里

4. 好了——你可以开始了。

## 这些 Skills 为什么存在

我构建这些 skills，是为了解决我在 Claude Code、Codex 和其他 coding agents 中看到的常见失败模式。

### #1：Agent 没有做我想要的事

> “没有人确切知道自己想要什么”
>
> David Thomas 和 Andrew Hunt，《[程序员修炼之道](https://www.amazon.co.uk/Pragmatic-Programmer-Anniversary-Journey-Mastery/dp/B0833F1T3V)》

**问题**。软件开发中最常见的失败模式是错位。你以为开发者知道你想要什么。然后你看到他们构建出来的东西——才意识到它完全没理解你。

在 AI 时代也是一样。你和智能体（agent）之间存在沟通鸿沟。解决方法是一次**追问会话（grilling session）**——让智能体就你正在构建的东西向你提出细致问题。

**修复方法**是使用：

- [`/grill-me`](./skills/productivity/grill-me/SKILL.md)——用于非代码场景
- [`/grill-with-docs`](./skills/engineering/grill-with-docs/SKILL.md)——与 [`/grill-me`](./skills/productivity/grill-me/SKILL.md) 相同，但增加了更多好东西（见下文）

这些是我最受欢迎的 skills。它们帮助你在开始之前与智能体（agent）对齐，并深入思考你正在做的变更。每当你想做一次变更时，都要使用它们。

### #2：Agent 太啰嗦了

> 借助通用语言，开发者之间的对话以及代码中的表达，都源自同一个领域模型。
>
> Eric Evans，《[领域驱动设计](https://www.amazon.co.uk/Domain-Driven-Design-Tackling-Complexity-Software/dp/0321125215)》

**问题**：在项目开始时，开发者和他们为之构建软件的人（领域专家）通常说着不同的语言。

我在使用智能体（agents）时也感受到同样的张力。智能体通常被丢进一个项目，然后被要求边做边理解行话。于是它们会用 20 个词表达 1 个词就能说明的事。

**修复方法**是共享语言。它是一份帮助智能体（agents）解码项目中行话的文档。

<details>
<summary>
示例
</summary>

这里有一个来自我的 `course-video-manager` 仓库的 [`CONTEXT.md`](https://github.com/mattpocock/course-video-manager/blob/076a5a7a182db0fe1e62971dd7a68bcadf010f1c/CONTEXT.md) 示例。哪一个更容易读？

- **之前**：“当课程某个章节中的一节课被设为‘真实’（即在文件系统中获得一个位置）时会出现问题”
- **之后**：“materialization cascade 有问题”

这种简洁会在一次又一次会话中带来回报。

</details>

这内置在 [`/grill-with-docs`](./skills/engineering/grill-with-docs/SKILL.md) 中。它是一次追问会话（grilling session），但会帮助你与 AI 建立共享语言，并把难以解释的决策记录在 ADR 中。

很难解释这有多强大。它可能是这个仓库里最酷的单项技术。试试看就知道了。

> [!TIP]
> 共享语言除了减少啰嗦以外，还有许多其他好处：
>
> - **变量、函数和文件会用共享语言一致命名**
> - 因此，智能体（agent）**更容易浏览代码库**
> - 智能体（agent）也会**在思考上消耗更少 token**，因为它能使用更简洁的语言

### #3：代码不能工作

> “始终采取小而审慎的步骤。反馈速率就是你的速度上限。永远不要接手太大的任务。”
>
> David Thomas 和 Andrew Hunt，《[程序员修炼之道](https://www.amazon.co.uk/Pragmatic-Programmer-Anniversary-Journey-Mastery/dp/B0833F1T3V)》

**问题**：假设你和 agent 已经对要构建的内容达成一致。那当智能体（agent）_仍然_产出垃圾时会发生什么？

是时候看看你的反馈循环了。如果没有关于它产出的代码实际如何运行的反馈，智能体（agent）就是在盲飞。

**修复方法**：你需要常规的一组反馈循环：静态类型、浏览器访问和自动化测试。

对于自动化测试，红-绿-重构循环至关重要。也就是 智能体（agent）先写一个失败测试，然后修复测试。这有助于给智能体提供稳定的反馈水平，从而得到好得多的代码。

我构建了一个可以放进任何项目的 **[`/tdd`](./skills/engineering/tdd/SKILL.md) skill**。它鼓励红-绿-重构，并向 agent 提供大量指导，说明什么是好的测试、什么是坏的测试。

针对调试，我还构建了一个 **[`/diagnose`](./skills/engineering/diagnose/SKILL.md)** skill，把最佳调试实践包装成一个简单循环。

### #4：我们构建了一团泥球

> “每天都要投入系统设计。”
>
> Kent Beck，《[解析极限编程](https://www.amazon.co.uk/Extreme-Programming-Explained-Embrace-Change/dp/0321278658)》

> “最好的模块是深的。它们允许通过简单接口访问大量功能。”
>
> John Ousterhout，《[软件设计哲学](https://www.amazon.co.uk/Philosophy-Software-Design-2nd/dp/173210221X)》

**问题**：大多数用智能体（agents）构建的应用都复杂且难以修改。因为智能体能极大加快编码速度，它们也会加速软件熵增。代码库会以前所未有的速度变复杂。

**修复方法**是一种面向 AI 驱动开发的激进新方法：关心代码设计。

这内置在这些 skills 的每一层中：

- [`/to-prd`](./skills/engineering/to-prd/SKILL.md) 会在创建 PRD 前询问你将触及哪些模块
- [`/zoom-out`](./skills/engineering/zoom-out/SKILL.md) 会要求智能体（agent）在整个系统的上下文中解释代码

关键是，[`/improve-codebase-architecture`](./skills/engineering/improve-codebase-architecture/SKILL.md) 会帮助你拯救已经变成一团泥球的代码库。我建议每隔几天就在你的代码库上运行一次。

### 总结

软件工程基本功比以往任何时候都更重要。这些 skills 是我把这些基本功浓缩成可重复实践的最大努力，帮助你交付职业生涯中最好的应用。祝你使用愉快。

## 参考

### 工程

我每天用于代码工作的技能。

- **[diagnose](./skills/engineering/diagnose/SKILL.md)** — 针对棘手 bug 和性能回归的纪律化诊断循环：复现 → 最小化 → 提出假设 → 加仪表 → 修复 → 回归测试。
- **[grill-with-docs](./skills/engineering/grill-with-docs/SKILL.md)** — 一场追问会话（grilling session）：用现有领域模型挑战你的计划，打磨术语，并内联更新 `CONTEXT.md` 和 ADR。
- **[triage](./skills/engineering/triage/SKILL.md)** — 通过分流角色（triage roles）的状态机对议题进行分流。
- **[improve-codebase-architecture](./skills/engineering/improve-codebase-architecture/SKILL.md)** — 基于 `CONTEXT.md` 中的领域语言和 `docs/adr/` 中的决策，在代码库中寻找加深机会。
- **[setup-matt-pocock-skills](./skills/engineering/setup-matt-pocock-skills/SKILL.md)** — 搭建其他工程 skills 会消费的每仓库配置（问题跟踪器 issue tracker、分流标签 triage label 词汇表、领域文档布局）。在使用 `to-issues`、`to-prd`、`triage`、`diagnose`、`tdd`、`improve-codebase-architecture` 或 `zoom-out` 前，每个仓库运行一次。
- **[tdd](./skills/engineering/tdd/SKILL.md)** — 使用红-绿-重构循环进行测试驱动开发。一次构建一个垂直切片的功能或修复 bug。
- **[to-issues](./skills/engineering/to-issues/SKILL.md)** — 使用垂直切片，把任何计划、规格或 PRD 拆成可独立领取的 GitHub issues。
- **[to-prd](./skills/engineering/to-prd/SKILL.md)** — 将当前对话上下文转成 PRD，并作为 GitHub issue 提交。没有访谈——只综合你们已经讨论过的内容。
- **[zoom-out](./skills/engineering/zoom-out/SKILL.md)** — 告诉智能体（agent）拉远视角，对不熟悉的代码片段给出更广的上下文或更高层视角。
- **[prototype](./skills/engineering/prototype/SKILL.md)** — 构建一个一次性原型（prototype） 来充实设计——可以是用于状态/业务逻辑问题的可运行终端应用，也可以是在同一路由中可切换的几个截然不同的 UI 变体。

### 生产力

通用工作流工具，不限于代码。

- **[caveman](./skills/productivity/caveman/SKILL.md)** — 超压缩沟通模式。在保持完整技术准确性的同时，通过去掉填充语将 token 使用量减少约 75%。
- **[grill-me](./skills/productivity/grill-me/SKILL.md)** — 围绕一个计划或设计持续接受追问，直到决策树的每个分支都得到解决。
- **[handoff](./skills/productivity/handoff/SKILL.md)** — 将当前对话压缩成交接文档，让另一个智能体（agent）可以继续工作。
- **[write-a-skill](./skills/productivity/write-a-skill/SKILL.md)** — 创建具备正确结构、渐进披露和打包资源的新 skills。

### 杂项

我保留下来但很少使用的工具。

- **[git-guardrails-claude-code](./skills/misc/git-guardrails-claude-code/SKILL.md)** — 设置 Claude Code hooks，在危险 git 命令（push、reset --hard、clean 等）执行前阻止它们。
- **[migrate-to-shoehorn](./skills/misc/migrate-to-shoehorn/SKILL.md)** — 将测试文件从 `as` 类型断言迁移到 @total-typescript/shoehorn。
- **[scaffold-exercises](./skills/misc/scaffold-exercises/SKILL.md)** — 创建包含章节（sections）、题目（problems）、解答（solutions）和讲解（explainers）的练习目录结构。
- **[setup-pre-commit](./skills/misc/setup-pre-commit/SKILL.md)** — 使用 lint-staged、Prettier、类型检查和测试设置 Husky pre-commit hooks。
