---
name: antigravity-voice
description: AntiGravity Edge-TTS 語音回覆與播放模組。當使用者說「用語音回答」「唸出來」「唸給我聽」「用語音講結論」「語音回覆」時載入。
---

# 語音回覆規範 (Voice Responses via Edge-TTS)

## 觸發時機
當使用者提出以下指令時載入並執行：
- 「用語音回答」
- 「唸出來」
- 「唸給我聽」
- 「用語音講結論」

## 講稿撰寫原則
1. 口語化、精簡（約 100 至 250 字）。
2. 數字使用中文字（例如：「五個項目」而非「5個項目」）。
3. 只講關鍵結論與下一步行動，詳細內容保留於文字回覆。

## 聲音設定
- 預設聲音：`zh-TW-YunJheNeural`（男聲，穩重自然、適合教學）。
- 備選女聲：`zh-TW-HsiaoChenNeural`（活潑清晰）、`zh-TW-HsiaoYuNeural`（溫柔柔和）。

## 播放執行方式
使用本技能內建的播放工具：
`powershell.exe -ExecutionPolicy Bypass -File "C:\Users\willie\.gemini\config\skills\07-voice\speak.ps1" -Text "要唸出的講稿"`

或直接指定聲音：
`powershell.exe -ExecutionPolicy Bypass -File "C:\Users\willie\.gemini\config\skills\07-voice\speak.ps1" -Text "要唸出的講稿" -Voice "zh-TW-HsiaoChenNeural"`

播放結束後，僅需簡短回報「語音已播放完畢」。
