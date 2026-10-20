# 🧪 Keresearch

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)
[![Agent Skills](https://img.shields.io/badge/Agent_Skills-ZCode_%7C_Claude_Code_%7C_Codex-blue)](https://github.com/Infinite-Monkey-Lab/keresearch)
[![Organization](https://img.shields.io/badge/Infinite_Monkey_Lab-无限猴子实验室-181717?logo=github)](https://github.com/Infinite-Monkey-Lab)

**三个互补的科研 Agent Skills，覆盖从选题开题、实验纪律、篇章结构到句子级打磨与投稿防御的完整科研生命周期。**

*Three complementary Agent Skills covering the full research lifecycle: topic selection → experiments → structure → sentence craft → submission.*

---

## 🧭 为什么需要三个 Skill？（三层架构）

很多同学用 AI 写论文只停留在“帮我润色这段话”，结果改出来的文字语法工整却**满身 AI 味、论点没有实验锚点、经不起审稿人追问**。`Keresearch` 将科研拆成三个正交的层次，层层收敛：

```
┌────────────────────────────────────────────────────────────────────────────┐
│ 1. 项目层 · research-project-playbook                                       │
│    解决「做什么、怎么测、怎么记、投哪里」                                     │
│    证据链选题 · Phase-0 微基准 · 单变量纪律 · 发现日志(F1..Fn) · 数字/符号审计 │
└────────────────────────────────────┬───────────────────────────────────────┘
                                     ▼
┌────────────────────────────────────────────────────────────────────────────┐
│ 2. 篇章层 · research-paper-writing                                         │
│    解决「章节怎么搭、段落怎么流、审稿人怎么看」                               │
│    一段一结论 · 反向大纲(Reverse Outlining) · Claim-Evidence 对齐 · 5维自查  │
└────────────────────────────────────┬───────────────────────────────────────┘
                                     ▼
┌────────────────────────────────────────────────────────────────────────────┐
│ 3. 句子与红队层 · paper-writing                                             │
│    解决「每句话怎么写、怎么砍废话、怎么过机械与语义双门禁」                    │
│    6阶段头脑风暴 · 机械门禁(M1-M18) · 语义门禁(S1-S31) · 7种压缩算子 · 红队审查│
└────────────────────────────────────────────────────────────────────────────┘
```

| Skill 目录 | 层级定位 | 核心能力 | 来源与致谢 |
| :--- | :--- | :--- | :--- |
| [`research-project-playbook/`](./research-project-playbook) | **项目与实验层** | 证据链选题、阶段零微基准、单变量实验纪律、发现日志、数字/符号审计、三语域去 AI 味、导师汇报卡、投稿阶梯 | 蒸馏自一次完整系统测量研究（8×RTX4090 LLM Serving，70+ 配置，F1–F18） |
| [`research-paper-writing/`](./research-paper-writing) | **篇章与逻辑层** | 摘要/引言/方法/实验/结论分章节指南、段落清晰度测试、反向大纲、Claim-Evidence 映射表、5 维审稿人自查 | 源自彭思达教授科研笔记与 [Master-cai/Research-Paper-Writing-Skills](https://github.com/Master-cai/Research-Paper-Writing-Skills) |
| [`paper-writing/`](./paper-writing) | **句子与门禁层** | 6 阶段结构化头脑风暴、UCSB SNL 写作风格规则、机械门禁（M1–M18）、语义门禁（S1–S31）、文本压缩、独立红队与 `/loop` 审计 | 源自 UC Santa Barbara [SNL-UCSB/paper-writing-skill](https://github.com/SNL-UCSB/paper-writing-skill)（Arpit Gupta） |

---

## 📦 安装（ZCode / Claude Code 通用）

### 方式一：一键脚本安装（推荐）

```bash
git clone https://github.com/Infinite-Monkey-Lab/keresearch.git
cd keresearch
bash install.sh
```

> 💡 如果希望后续 `git pull` 自动同步最新规则，可使用软链接模式：
> ```bash
> bash install.sh --link
> ```

### 方式二：手动复制

只需将三个技能文件夹复制到你所使用的 Agent 技能目录：

```bash
git clone https://github.com/Infinite-Monkey-Lab/keresearch.git
cd keresearch

# ZCode / 通用 Agent Skills 目录
mkdir -p ~/.agents/skills
cp -r research-project-playbook paper-writing research-paper-writing ~/.agents/skills/

# Claude Code 目录
mkdir -p ~/.claude/skills
cp -r research-project-playbook paper-writing research-paper-writing ~/.claude/skills/
```

---

## 🚀 分阶段实战指南（怎么在对话中调用）

安装后，在 ZCode 或 Claude Code 中可以直接通过 `/skill名称` 或自然语言触发：

### 阶段 1：刚有想法 / 准备开题
- **调用**：`/research-project-playbook`
- **怎么问**：
  > 「我想做 [某方向] 的研究，目前看到的相近工作有 A、B、C。请按 `research-project-playbook` 的 **Evidence-chain（证据链）和 Kill test** 帮我检验这个选题有没有真正的结构性空档，并设计 Phase-0 微基准实验。」

### 阶段 2：想法发散、理不清论文主线
- **调用**：`/paper-writing`
- **怎么问**：
  > 「我跑出了一些实验结果，但还不知道论文故事怎么讲。请按 `paper-writing` 的 **Structured Brainstorming（6 阶段头脑风暴）** 一步步提问我，最后帮我生成 `project_context.md`。」

### 阶段 3：写各章节初稿 & 检查段落逻辑流
- **调用**：`/research-paper-writing`
- **怎么问**：
  > 「请加载 `research-paper-writing` 的 Introduction 指南，帮我重构这段引言：给出反向大纲（Reverse Outline）、标出每段角色，并输出 `Claim | Evidence | Status` 对照表。」

### 阶段 4：消除 AI 味、压缩篇幅、过红队门禁
- **调用**：`/paper-writing` + `/research-project-playbook`
- **怎么问**：
  > 「请对照 `research-project-playbook/references/abstract-register-deai.md` 和 `paper-writing` 的 **M1–M18 机械门禁 + S1–S31 语义门禁**，对我的 Abstract 和 Introduction 做一次完整的去 AI 味和红队审计。」

---

## 💎 仓库里的硬核资产速查

除了三个主 `SKILL.md` 外，子目录中沉淀了大量可直接复用的检查表与对照表：

### 1. `research-project-playbook/` —— 源项目验证过的 10 条硬规则
1. **证据链选题**：不喊“没人做过”，列相邻论文各自盲区，你的工作 = 无人测量的合取。三条最接近论文 + 盲区说不清楚 = 没有空档。
2. **阶段零先行**：端到端实验前先给平台画像（分钟级微基准），后续一切主张锚定实测常数而非数据手册。
3. **单变量纪律**：每个配置点全新服务启动；说不清“只差一个变量”的对比不进论文。
4. **发现日志（Findings Log）**：`F1, F2…` 编号记录，每条 2–5 句 + 数字 + 原始数据目录指针。它就是论文的脊柱。
5. **数字审计**：脚本交叉核对正文每个数字与原始 JSON（实战中曾抓到 `3,296` vs `3,349` 的漂移笔误）。
6. **三轮重复与 3σ**：关键配置三次完整重启，报告 CV，把头条差距写成实测 $3\sigma$ 的倍数，直接封死“是不是噪声”的审稿质疑。
7. **符号审计**：渲染前专门过一遍公式，符号首现即定义、同一字母绝不兼职两个含义。
8. **导师卡（Advisor Card）**：准备一句话电梯版（零术语）/ 两句问题方法版 / 三条贡献 / 数字速查表，外行版把术语全部翻译成直白动作。
9. **投稿阶梯**：冲刺 + 务实 + 保底 + 期刊，测量研究优先投对测量友好的会议（如 MLSys / EuroSys / IMC）。
10. **双语与去 AI 味纪律**：见 [`references/abstract-register-deai.md`](./research-project-playbook/references/abstract-register-deai.md) —— 区分**论文书面语 / 学术口头汇报 / 破冰故事**三种语域，收录对称句式、戏剧化模板、名词堆叠等典型 AI 痕迹及替换词表。

### 2. `research-paper-writing/` —— 章节指南与审稿人视角
- [`references/abstract.md`](./research-paper-writing/references/abstract.md) / [`introduction.md`](./research-paper-writing/references/introduction.md) / [`related-work.md`](./research-paper-writing/references/related-work.md) / [`method.md`](./research-paper-writing/references/method.md) / [`experiments.md`](./research-paper-writing/references/experiments.md) / [`conclusion.md`](./research-paper-writing/references/conclusion.md)：六大核心章节的句式与结构模板。
- [`references/does-my-writing-flow-source.md`](./research-paper-writing/references/does-my-writing-flow-source.md)：段落流畅度自检与反向大纲方法。
- [`references/paper-review.md`](./research-paper-writing/references/paper-review.md)：从贡献度、清晰度、实验强度、评估完整性、方法合理性 5 个维度模拟审稿人挑刺。

### 3. `paper-writing/` —— 句子级工艺与自动化门禁
- [`author_profile/gate_mechanical.md`](./paper-writing/author_profile/gate_mechanical.md)：**M1–M18 机械门禁**（一句 grep 扫描破折号滥用、虚假排比、空洞形容词 `novel/significant/robust`、被动语态、术语漂移）。
- [`author_profile/gate_semantic.md`](./paper-writing/author_profile/gate_semantic.md)：**S1–S31 语义门禁**（先定义后使用、可跟随性、论点闭环、图表自解释检查）。
- [`author_profile/compression_patterns.md`](./paper-writing/author_profile/compression_patterns.md)：7 种句子压缩算子与前后对比基准（专治超页数）。
- [`figure_synthesis_guide.md`](./paper-writing/figure_synthesis_guide.md) & [`figure_templates/`](./paper-writing/figure_templates)：顶会架构图与实验图的规范模板（含 TikZ 骨架）。
- [`red_team_protocol.md`](./paper-writing/red_team_protocol.md) & [`loop_mode.md`](./paper-writing/loop_mode.md)：独立红队对抗审查协议与落盘式逐章迭代工作流。

---

## 🤝 参与贡献

本项目由 **[无限猴子实验室 · Infinite Monkey Lab](https://github.com/Infinite-Monkey-Lab)** 维护。欢迎提交 Issue 或 Pull Request：

- 补充更多学科方向（CV / NLP / AI4Science / 安全 / 硬件）的领域写作检查表或去 AI 味词表
- 贡献实用的科研自动化脚本（如数字一致性审计脚本、符号冲突检查脚本、LaTeX 边距溢出扫描脚本）
- 分享你在实际论文写作与 Rebuttal 中验证有效的硬规则

详情请参阅 [`CONTRIBUTING.md`](./CONTRIBUTING.md)，新手可从带有 `good first issue` 标签的任务开始。

---

## 📄 开源许可（License）

本仓库采用 [MIT License](./LICENSE) 分发，并完整保留各上游项目的原始署名与许可证：

- `research-project-playbook/`：MIT License（Infinite Monkey Lab）
- `paper-writing/`：MIT License，源自 [SNL-UCSB/paper-writing-skill](https://github.com/SNL-UCSB/paper-writing-skill)，Copyright (c) 2026 Arpit Gupta（详见 [`paper-writing/LICENSE`](./paper-writing/LICENSE)）
- `research-paper-writing/`：MIT License，源自彭思达教授公开笔记与 [Master-cai/Research-Paper-Writing-Skills](https://github.com/Master-cai/Research-Paper-Writing-Skills)，Copyright (c) 2026 Master-cai（详见 [`research-paper-writing/LICENSE`](./research-paper-writing/LICENSE) 与 [`ATTRIBUTION.md`](./research-paper-writing/ATTRIBUTION.md)）
