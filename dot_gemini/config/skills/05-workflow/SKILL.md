---
name: antigravity-workflow
description: AntiGravity 跨電腦專案管理工作流（三層級自動偵測）。當使用者說「開工」「收工」「初始化專案」「開始工作」「結束工作」時載入。本技能整合三師爸 EP06 跨電腦交接規範（project-init, startup, shutdown）。
---

# AntiGravity 跨電腦專案管理工作流（三層級自動偵測）

> 依據三師爸（@sensebar）EP06 跨電腦協作架構設計，支援 **L1 本地 (AGENTS.md + handoff.md)**、**L2 GitHub**、**L3 Obsidian** 三層級自動偵測與無縫交接。

---

## 1. 專案初始化 (`project-init`)
- **口令**：「初始化專案」、「建立專案藍圖」、「幫我 init 專案」
- **層級偵測**：
  - **L1**：建立開放標準全大寫 `AGENTS.md`（專案藍圖）＋ `handoff.md`（交接檔）。
  - **L2**：若已登入 GitHub CLI (`gh auth status`)，建立私有 GitHub Repo 並推送。
  - **L3**：若有 Obsidian MCP，在 Vault 建立 `<專案名>/專案工作流程.md`。
- **原則**：若已存在檔案，盤點缺口補充，絕不未經確認任意覆蓋。

---

## 2. 開工流程 (`startup`)
- **口令**：「開工」、「開始工作」、「上次做到哪」、「接續工作」
- **核心動作（只讀、只報告，不改檔案）**：
  1. **讀取 `AGENTS.md` ＋ `handoff.md`**：摘要上次做到哪、目前狀態、下一步。
  2. **跨電腦比對**：比對交接檔中「上次更新者（電腦名）」與本機 `$env:COMPUTERNAME`。若不同，特別標示「⚠️ 上次在另一台電腦收工，請確認雲端同步完成」。
  3. **Git 狀態檢查 (L2)**：檢查本地乾淨度；30 分鐘防呆 fetch 比對遠端 commit（**絕不自動 pull**，僅提醒使用者）。
  4. **Obsidian (L3)**：只列筆記路徑，有需要才讀，不浪費上下文 token。
  5. **結構化回報**：回報上次進度與建議的下一步，等待使用者指示。

---

## 3. 收工流程 (`shutdown`)
- **口令**：「收工」、「結束工作」、「下班」、「準備換電腦」、「同步」
- **核心動作（寫入、改寫、同步）**：
  1. **敏感資料審查**：嚴格檢查變更內容，絕不洩漏 API Key、Token 或機密。
  2. **更新藍圖與改寫交接檔 (L1)**：
     - 更新 `AGENTS.md` 之 Checklist 進度。
     - **完整改寫 `handoff.md`**：記錄「目前做到哪」、「目前狀態」、「下一步 (1~3 項)」、「注意事項」、「最後更新時間＋更新者 (Agent @ $env:COMPUTERNAME)＋Git push 狀態」。
  3. **精準 Stage 與 Git 提交 (L2)**：
     - 嚴格禁止無差別 `git add .`，只 stage 相關變更。
     - 擬定繁體中文語意化 commit 訊息，經使用者確認後提交並 `git push`。
     - 回填 `handoff.md` 之「Git push 狀態（✅ 已推 / ❌ 未推）」。
  4. **Obsidian 詳細紀錄 (L3)**：若有 Obsidian MCP，將決策背景與踩坑寫入筆記。
  5. **結構化回報**：依層級 Checklist 回報同步狀態。
