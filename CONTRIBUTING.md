# 贡献指南 · Contributing to Keresearch

欢迎来到 **无限猴子实验室（Infinite Monkey Lab）** 的 `keresearch` 项目！我们致力于将经过真实科研周期检验的硬规则沉淀为可复用的 Agent Skills，帮助更多同学少走弯路。

## 🌱 你可以贡献什么？

1. **真实踩坑提炼的规则（最受欢迎）**
   - 你在做实验、写论文、Rebuttal 或与导师沟通时验证有效的硬规则（请附带具体的正反例，避免空泛口号）。
2. **中英文去 AI 味模式库（De-AI Patterns）**
   - 补充 [`research-project-playbook/references/abstract-register-deai.md`](./research-project-playbook/references/abstract-register-deai.md) 中的典型 AI 句式结构与专业平实替换写法（特别是中文学位论文 / 中文顶刊场景）。
3. **跨学科 / 跨顶会适配模板**
   - 目前技能主要覆盖 ML / CV / NLP 与计算机系统（Systems）领域。非常欢迎补充安全（Security）、软件工程（SE）、人机交互（HCI）、生物信息 / AI4Science 等领域的投稿与实验检查表。
4. **配套轻量级审计脚本**
   - 例如：正文与 JSON 原始数据的数字一致性核对脚本、LaTeX 公式符号首现定义检查脚本、PDF 渲染边距溢出检测脚本等。

## 📋 编写规范

为了保证 Agent 加载技能时的执行效果，修改或新增 Markdown 规则文件时请遵守：

- **可检验优先**：每条规则必须能让人类或 Agent 判断“遵守了 vs 违反了”（例如给出明确的正例/反例对照，而不是写“语言要优美”）。
- **保持上下文精简**：`SKILL.md` 作为入口文件应保持高信息密度；长篇案例、词表或分章节细节请放入对应目录下的 `references/`，并在 `SKILL.md` 中按需引用。
- **尊重上游版权**：修改 `paper-writing/` 或 `research-paper-writing/` 时，请保留原有的 `LICENSE` 与 `ATTRIBUTION.md` 声明。

## 🔄 提交流程

1. Fork 本仓库并从 `master` 创建分支（如 `feat/chinese-deai-patterns` 或 `fix/typo-in-playbook`）。
2. 完成修改后，在本地用 ZCode 或 Claude Code 实际触发一次对应 Skill，确认指令清晰无歧义。
3. 提交 Pull Request，简要说明修改背景与验证效果。
