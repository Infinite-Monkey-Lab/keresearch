<div align="center">

# Keresearch

**从研究问题到论文表达，让每一步都有据可查。**

三个互补的科研 Agent Skill，分别处理项目决策、篇章结构与句子表达。

[![License: MIT](https://img.shields.io/badge/License-MIT-24292F?style=flat-square)](LICENSE)
[![Agent Skills](https://img.shields.io/badge/Agent_Skills-ZCode%20%7C%20Claude_Code%20%7C%20Codex-4665D8?style=flat-square)](https://github.com/Infinite-Monkey-Lab/keresearch)

[选择 Skill](#选择适合当前任务的-skill) · [安装](#安装) · [开始使用](#开始使用) · [参考索引](#参考索引) · [来源与许可](#来源与许可)

</div>

Keresearch 将选题、实验记录、论文结构与文字审查整理成 Agent 可加载的工作流程。你提供研究问题、实验材料或初稿，按当前阶段选择一个 Skill，即可开始有针对性的检查。

## 选择适合当前任务的 Skill

| 你现在需要 | 使用哪个 Skill | 可以得到什么 |
| :--- | :--- | :--- |
| 判断选题、规划实验、整理发现或准备投稿 | [research-project-playbook](research-project-playbook/SKILL.md) | 证据链、实验检查表、发现日志、汇报与投稿清单 |
| 搭章节、梳理段落、检查论证 | [research-paper-writing](research-paper-writing/SKILL.md) | 反向大纲、主张与证据对照表、审稿自查 |
| 找论文主线、改句子、压篇幅或审查风格 | [paper-writing](paper-writing/SKILL.md) | 项目语境文件、改稿、机械与语义门禁报告 |

三者可以单独使用，也可以依次衔接：

```text
项目层                     篇章层                    句子层
research-project-playbook → research-paper-writing → paper-writing
选题 · 实验 · 证据          章节 · 段落 · 论证         表达 · 压缩 · 审查
```

发现日志为章节提供证据，章节大纲明确每段的任务，再对文字做细化审查。无需每次都运行完整流程。

## 安装

### 使用安装脚本

需要 Git 与 Bash。Windows 可在 Git Bash 中运行；安装目录应与实际使用的 Agent 环境一致。

```bash
git clone https://github.com/Infinite-Monkey-Lab/keresearch.git
cd keresearch
bash install.sh
```

默认将三个 Skill 复制到 `~/.agents/skills/` 和 `~/.claude/skills/`。

> 安装脚本会替换目标目录中已有的同名 Skill。若做过本地修改，请先备份。

| 参数 | 安装方式 |
| :--- | :--- |
| 不加参数 | 复制到上述两个目录 |
| `--agents` 或 `--zcode` | 只安装到 `~/.agents/skills/` |
| `--claude` | 只安装到 `~/.claude/skills/` |
| `--link` | 用符号链接代替复制，可与一个目标目录参数组合 |

复制安装后，更新仓库并重新运行安装脚本；链接安装后，`git pull` 的改动直接反映到链接目录。使用 `--link` 时，请保留仓库位置并确保系统允许创建符号链接。

### 手动安装

将以下三个目录完整复制到所用 Agent 的技能目录，保留各目录内的 `SKILL.md` 与参考文件：

```text
research-project-playbook/
research-paper-writing/
paper-writing/
```

不确定是否加载成功时，可在 Agent 中明确指定 Skill 名称，并让它先确认读取到对应的 `SKILL.md`。不同客户端的调用入口与自动发现方式可能不同。

## 开始使用

在对话中写明 **Skill 名称、当前材料、希望得到的结果**。下面的提示可以直接复制，并替换自己的研究信息。

<details open>
<summary>准备开题：检查问题与实验起点</summary>

> 使用 research-project-playbook。我想研究 X，最接近的工作是 A、B、C。先检查研究空档与证据，再设计一个能尽早否定无效方向的 Kill test，以及 Phase-0 微基准。缺失的信息请先问我。

</details>

<details>
<summary>已有实验：整理论文主线</summary>

> 使用 paper-writing。实验结果在这份文档中。按六阶段头脑风暴逐步向我提问，梳理问题、发现与贡献，最后生成 project_context.md；不要补写材料中不存在的结果。

</details>

<details>
<summary>已有初稿：检查结构与论证</summary>

> 使用 research-paper-writing，按 Introduction 指南检查这段引言。先给反向大纲，再标出每段的作用，输出 Claim、Evidence、Status 对照表，指出证据缺口。

</details>

<details>
<summary>准备定稿：压缩表达与审查风格</summary>

> 使用 paper-writing 与 research-project-playbook。对照 M1–M18、S1–S31 和 abstract-register-deai.md 审查摘要与引言，列出命中项，再给出修改稿。保留原始数字、研究范围和不确定性。

</details>

## 参考索引

第一次使用只需选好 Skill；需要了解具体规则时，再展开对应索引。下列门禁和经验规则是本项目的工作约定，使用时应结合学科、文体与目标期刊要求。

<details>
<summary>项目与实验纪律 · research-project-playbook</summary>

规则蒸馏自一次完整的系统测量研究（8 卡 RTX 4090 集群上的 LLM Serving 测量，70 多个配置，编号发现 F1 到 F18）。十条主规则见 [`research-project-playbook/SKILL.md`](./research-project-playbook/SKILL.md)：

1. **证据链选题。** 禁止写“没人做过”。列出最接近的三篇论文，各写一句它的盲区；三条盲区说不清，说明空档还不存在，继续读文献。
2. **Phase-0 微基准先行。** 端到端实验前先花几分钟测平台常数：集合通信延迟、总线带宽、内存上限。后续所有主张锚定在实测常数上。源项目中 TP-4 总线带宽从 14 GB/s 掉到 9.3 GB/s，整个实验计划因此重排。
3. **单变量纪律。** 每个配置点全新服务启动。一句话说不清“只差一个变量”的对比，不进论文。
4. **发现日志。** `notes/findings-log.md` 按编号记录发现，每条 2 到 5 句，附数字和原始数据目录指针。实验和写作由此解耦。
5. **数字审计。** 写脚本核对正文每个数字与原始 JSON。实战中抓到过一处 `3,296` 与 `3,349` 的笔误，审稿前拦截。
6. **三轮重复。** 关键配置完整重启三次，报告 CV，把头条差距写成实测 $3\sigma$ 的倍数，直接用实测方差回应“是不是噪声”的审稿质疑。
7. **符号审计。** 渲染前通读公式：符号首现即定义，同一字母不兼任两个含义。
8. **导师汇报卡。** 电梯版一句话（零术语）、两句问题方法版、三条贡献、数字速查表。术语翻译成直白动作，例如 tensor parallelism 译作“把多张卡接成一台大机器”。
9. **投稿阶梯。** 冲刺一所、务实两所、保底一所、期刊一本。测量研究投对测量友好的会议（MLSys、EuroSys、ICDCS 一线），投机制向会议前先补系统贡献。
10. **语域与去 AI 味。** 区分论文书面语、学术口头汇报、破冰故事三种语域，混用即失败。细则见 [`references/abstract-register-deai.md`](./research-project-playbook/references/abstract-register-deai.md)：收录对称句式、戏剧化叙事模板、组件名词堆叠、四字排比等结构性 AI 痕迹的判定与改法，附摘要数字预算和替换词表。

</details>

<details>
<summary>章节结构与审稿自查 · research-paper-writing</summary>

- 六个章节指南：[`abstract.md`](./research-paper-writing/references/abstract.md)、[`introduction.md`](./research-paper-writing/references/introduction.md)、[`related-work.md`](./research-paper-writing/references/related-work.md)、[`method.md`](./research-paper-writing/references/method.md)、[`experiments.md`](./research-paper-writing/references/experiments.md)、[`conclusion.md`](./research-paper-writing/references/conclusion.md)，各给出段落职责与句式模板。
- 段落清晰度与反向大纲（[`does-my-writing-flow-source.md`](./research-paper-writing/references/does-my-writing-flow-source.md)）：先检查一段是否只传递一个信息、首句是否点题，再做反向大纲，把每段主题句映射回论文主张，映射不上就改或删。
- 五维审稿自查（[`paper-review.md`](./research-paper-writing/references/paper-review.md)）：从贡献度、写作清晰度、实验强度、评估完整性、方法合理性五个维度模拟审稿人挑刺，配合 `Claim | Evidence | Status` 对照表逐项销账。

</details>

<details>
<summary>句子工艺与双门禁 · paper-writing</summary>

源自 UC Santa Barbara 系统与网络实验室对 6 篇论文、7,600 多次 Overleaf 修订与 5 轮同行评审的逐句分析，经本仓库适配中英文场景。

- **6 阶段结构化头脑风暴**（[`brainstorming_guide.md`](./paper-writing/brainstorming_guide.md)）：从问题发现走到叙事主线，生成单篇论文的约束文件 `project_context.md`。
- **正向造句参考**（[`author_profile/craft_reference.md`](./paper-writing/author_profile/craft_reference.md) 与 [`editorial_principles.md`](./paper-writing/author_profile/editorial_principles.md)）：规定基础简明语域（均长约 21 词、主张先行、主动语态、具名机制代替泛化名词）及立场论文、教学叙事两类变体语域。
- **机械门禁 M1 到 M18**（[`author_profile/gate_mechanical.md`](./paper-writing/author_profile/gate_mechanical.md)）：可 grep 的硬规则。M1 禁一切破折号，M2 禁修辞性否定对仗，M5 禁 `novel`、`significant`、`robust` 等空洞形容词，M6 禁 `Moreover`、`Notably` 开场，M11 禁被动语态。文件末尾附完整 grep 脚本，每次修改后直接运行并报告命中数。
- **语义门禁 S1 到 S31**（[`author_profile/gate_semantic.md`](./paper-writing/author_profile/gate_semantic.md)）：读者视角检查项，覆盖先定义后使用、可跟随性、术语一致性、主张闭环与图表自解释。
- **7 种压缩算子**（[`author_profile/compression_patterns.md`](./paper-writing/author_profile/compression_patterns.md)）：删从句、并段落、删空形容词、删教程性背景、主张前置、补实验小结、文字转图表，一稿到终稿目标压缩 30% 到 50%。
- **非数据图表合成**（[`figure_synthesis_guide.md`](./paper-writing/figure_synthesis_guide.md) 与 [`figure_templates/`](./paper-writing/figure_templates)）：架构图与流程图的规格定义、生成与审查流程，附 TikZ 模板。
- **独立红队与循环审计**（[`red_team_protocol.md`](./paper-writing/red_team_protocol.md)、[`loop_mode.md`](./paper-writing/loop_mode.md)）：由未参与起草的审查实例重跑机械门禁与语义门禁，输出逐条问题清单；`/loop` 模式支持落盘账本、逐章迭代，直到零严重问题后自动停止。

</details>

## 参与贡献

欢迎补充其他学科的检查表、经过实际改稿验证的规则，或数字一致性、符号冲突、LaTeX 排版等审计脚本。

贡献流程见 [CONTRIBUTING.md](CONTRIBUTING.md)。你也可以从 [Issues](https://github.com/Infinite-Monkey-Lab/keresearch/issues) 中选择任务，说明问题、示例与预期改进。

## 来源与许可

本仓库按 [MIT License](LICENSE) 分发，保留各子目录的上游署名与许可证。

| Skill | 来源与署名 |
| :--- | :--- |
| research-project-playbook | 蒸馏自 8 卡 RTX 4090 LLM Serving 测量研究，70+ 配置、F1–F18 发现记录；Infinite Monkey Lab |
| research-paper-writing | 彭思达教授公开科研笔记与 [Master-cai/Research-Paper-Writing-Skills](https://github.com/Master-cai/Research-Paper-Writing-Skills)；见 [署名说明](research-paper-writing/ATTRIBUTION.md)及 [MIT 许可证](research-paper-writing/LICENSE)，Copyright (c) 2026 Master-cai |
| paper-writing | [SNL-UCSB/paper-writing-skill](https://github.com/SNL-UCSB/paper-writing-skill)；见 [MIT 许可证](paper-writing/LICENSE)，Copyright (c) 2026 Arpit Gupta |

由 [Infinite Monkey Lab](https://github.com/Infinite-Monkey-Lab) 维护。
