# Keresearch

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)
[![Agent Skills](https://img.shields.io/badge/Agent_Skills-ZCode_%7C_Claude_Code_%7C_Codex-blue)](https://github.com/Infinite-Monkey-Lab/keresearch)
[![Organization](https://img.shields.io/badge/Infinite_Monkey_Lab-无限猴子实验室-181717?logo=github)](https://github.com/Infinite-Monkey-Lab)

三个科研 Agent Skill，供 ZCode、Claude Code、Codex 加载，覆盖从选题到投稿的完整流程。`research-project-playbook` 管项目层：选题、实验纪律、记录、投稿。`research-paper-writing` 管篇章层：章节结构、段落衔接、审稿人视角自查。`paper-writing` 管句子层：造句规则、可 grep 的风格门禁、压缩与红队审查。

装好后，写作问题的入口从“帮我润色这段”变成一组具体检查：这段话有没有踩 M1 到 M18 的哪条禁令，引言里的主张有没有对应实验，摘要里的数字和原始 JSON 是否一致。

## 为什么分三层

用 AI 写论文的常见失败方式，是把所有问题都当作句子问题。润色只处理字面表达。多数初稿的问题出在更早的环节：选题说不清相对哪三篇论文的空档，实验缺单变量对比，正文主张找不到对应的图表数据。三个 Skill 各管一层，哪一层出问题就查哪一层。

| Skill | 管什么 | 主要产物 | 来源 |
| :--- | :--- | :--- | :--- |
| [`research-project-playbook/`](./research-project-playbook) | 做什么、怎么测、怎么记、投哪里 | 证据链、发现日志、导师汇报卡、投稿清单 | 8 卡 RTX 4090 LLM Serving 实测研究（70+ 配置，F1 到 F18） |
| [`research-paper-writing/`](./research-paper-writing) | 章节怎么搭、段落怎么流 | 反向大纲、Claim-Evidence 对照表、五维自查 | 彭思达教授科研笔记与 [Master-cai/Research-Paper-Writing-Skills](https://github.com/Master-cai/Research-Paper-Writing-Skills) |
| [`paper-writing/`](./paper-writing) | 每句话怎么写、怎么砍 | 机械门禁报告、压缩后文本、红队审查问题单 | UC Santa Barbara [SNL-UCSB/paper-writing-skill](https://github.com/SNL-UCSB/paper-writing-skill) |

前一个 Skill 的产物是后一个的输入：发现日志（F1, F2…）支撑章节大纲，章节大纲决定每段写什么，句子门禁处理剩下的表达问题。

## 安装

```sh
git clone https://github.com/Infinite-Monkey-Lab/keresearch.git
cd keresearch
bash install.sh
```

默认复制三个 Skill 到 `~/.agents/skills/` 与 `~/.claude/skills/`。可选参数：`--link` 改用软链接，之后 `git pull` 即更新；`--zcode` 只装到 `~/.agents/skills/`；`--claude` 只装到 `~/.claude/skills/`。

也可以手动把三个目录复制到所用 Agent 的技能目录：

```sh
mkdir -p ~/.agents/skills ~/.claude/skills
cp -r research-project-playbook research-paper-writing paper-writing ~/.agents/skills/
cp -r research-project-playbook research-paper-writing paper-writing ~/.claude/skills/
```

## 用法

安装后用 `/技能名` 调用，或直接描述当前任务，Agent 会按需加载对应文件。

| 当前阶段 | 调用 | 提问示例 |
| :--- | :--- | :--- |
| 有想法，准备开题 | `/research-project-playbook` | 我想做 X 方向，相近工作有 A、B、C。按证据链和 Kill test 检查有没有真空档，再设计 Phase-0 微基准。 |
| 实验跑完了，理不清主线 | `/paper-writing` | 实验结果在这份文档里。走一遍 6 阶段头脑风暴，逐阶段提问我，最后生成 `project_context.md`。 |
| 写章节初稿、查段落衔接 | `/research-paper-writing` | 加载 Introduction 指南重构这段引言：给反向大纲，标出每段角色，输出 `Claim \| Evidence \| Status` 对照表。 |
| 去 AI 味、压篇幅、过门禁 | `/paper-writing` + `/research-project-playbook` | 对照 `abstract-register-deai.md`、M1 到 M18 机械门禁和 S1 到 S31 语义门禁，审计 Abstract 与 Introduction，列出所有命中项。 |

## 各目录文件与规则索引

### 1. [`research-project-playbook/`](./research-project-playbook)：项目与实验纪律

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

### 2. [`research-paper-writing/`](./research-paper-writing)：章节结构与审稿自查

- 六个章节指南：[`abstract.md`](./research-paper-writing/references/abstract.md)、[`introduction.md`](./research-paper-writing/references/introduction.md)、[`related-work.md`](./research-paper-writing/references/related-work.md)、[`method.md`](./research-paper-writing/references/method.md)、[`experiments.md`](./research-paper-writing/references/experiments.md)、[`conclusion.md`](./research-paper-writing/references/conclusion.md)，各给出段落职责与句式模板。
- 段落清晰度与反向大纲（[`does-my-writing-flow-source.md`](./research-paper-writing/references/does-my-writing-flow-source.md)）：先检查一段是否只传递一个信息、首句是否点题，再做反向大纲，把每段主题句映射回论文主张，映射不上就改或删。
- 五维审稿自查（[`paper-review.md`](./research-paper-writing/references/paper-review.md)）：从贡献度、写作清晰度、实验强度、评估完整性、方法合理性五个维度模拟审稿人挑刺，配合 `Claim | Evidence | Status` 对照表逐项销账。

### 3. [`paper-writing/`](./paper-writing)：句子工艺与双门禁

源自 UC Santa Barbara 系统与网络实验室对 6 篇论文、7,600 多次 Overleaf 修订与 5 轮同行评审的逐句分析，经本仓库适配中英文场景。

- **6 阶段结构化头脑风暴**（[`brainstorming_guide.md`](./paper-writing/brainstorming_guide.md)）：从问题发现走到叙事主线，生成单篇论文的约束文件 `project_context.md`。
- **正向造句参考**（[`author_profile/craft_reference.md`](./paper-writing/author_profile/craft_reference.md) 与 [`editorial_principles.md`](./paper-writing/author_profile/editorial_principles.md)）：规定基础简明语域（均长约 21 词、主张先行、主动语态、具名机制代替泛化名词）及立场论文、教学叙事两类变体语域。
- **机械门禁 M1 到 M18**（[`author_profile/gate_mechanical.md`](./paper-writing/author_profile/gate_mechanical.md)）：可 grep 的硬规则。M1 禁一切破折号，M2 禁修辞性否定对仗，M5 禁 `novel`、`significant`、`robust` 等空洞形容词，M6 禁 `Moreover`、`Notably` 开场，M11 禁被动语态。文件末尾附完整 grep 脚本，每次修改后直接运行并报告命中数。
- **语义门禁 S1 到 S31**（[`author_profile/gate_semantic.md`](./paper-writing/author_profile/gate_semantic.md)）：读者视角检查项，覆盖先定义后使用、可跟随性、术语一致性、主张闭环与图表自解释。
- **7 种压缩算子**（[`author_profile/compression_patterns.md`](./paper-writing/author_profile/compression_patterns.md)）：删从句、并段落、删空形容词、删教程性背景、主张前置、补实验小结、文字转图表，一稿到终稿目标压缩 30% 到 50%。
- **非数据图表合成**（[`figure_synthesis_guide.md`](./paper-writing/figure_synthesis_guide.md) 与 [`figure_templates/`](./paper-writing/figure_templates)）：架构图与流程图的规格定义、生成与审查流程，附 TikZ 模板。
- **独立红队与循环审计**（[`red_team_protocol.md`](./paper-writing/red_team_protocol.md)、[`loop_mode.md`](./paper-writing/loop_mode.md)）：由未参与起草的审查实例重跑机械门禁与语义门禁，输出逐条问题清单；`/loop` 模式支持落盘账本、逐章迭代，直到零严重问题后自动停止。

## 参与贡献

欢迎提 Issue 或 Pull Request：补充其他学科方向的写作检查表或去 AI 味词表，贡献数字一致性、符号冲突、LaTeX 边距溢出这类审计脚本，或分享你在实际写作与 Rebuttal 中验证有效的规则。具体流程见 [`CONTRIBUTING.md`](./CONTRIBUTING.md)，新手可从带 `good first issue` 标签的任务入手。

## 许可与致谢

本仓库按 [MIT License](./LICENSE) 分发，三个子目录各自保留上游署名与许可证：

- `research-project-playbook/`：MIT License，Infinite Monkey Lab。
- `paper-writing/`：MIT License，源自 [SNL-UCSB/paper-writing-skill](https://github.com/SNL-UCSB/paper-writing-skill)，Copyright (c) 2026 Arpit Gupta（见 [`paper-writing/LICENSE`](./paper-writing/LICENSE)）。
- `research-paper-writing/`：MIT License，源自彭思达教授公开笔记与 [Master-cai/Research-Paper-Writing-Skills](https://github.com/Master-cai/Research-Paper-Writing-Skills)，Copyright (c) 2026 Master-cai（见 [`research-paper-writing/LICENSE`](./research-paper-writing/LICENSE) 与 [`ATTRIBUTION.md`](./research-paper-writing/ATTRIBUTION.md)）。
