# CLAUDE.md

Guidance for Claude Code (claude.ai/code) when working in `node-red/`.

## ⚠️ This is vendored upstream code — DO NOT EDIT IN PLACE

`node-red/` 是 [Node-RED](https://github.com/node-red/node-red) 的 upstream clone（branch `master`），不是 FMS 自己開發的程式碼。

- ❌ **不要改這裡的 source / README / package.json** — 改了之後 upstream pull 一定衝突
- ❌ **不要從這裡複製 convention 到 fms-backend-rust / fms-frontend** — 它們是不同 stack、不同設計年代
- ✅ **要看 Node-RED 怎麼用，看 upstream README 或官方文件**：https://nodered.org

## FMS 專案怎麼用 Node-RED

**單一用途**：在 `integration/` 整合驗證環境裡當 **MQTT → REST bridge**。理由是 fms-backend-rust 目前**沒有**內建 MQTT subscriber — 設備要把資料寫進 backend 必須打 REST `/schideron/openApi/data/device/write`。所以：

```
fms-mock ──(MQTT iot/forward/#)──► mosquitto ──► node-red flow ──► POST /schideron/openApi/data/device/write ──► fms-backend
```

整合用的 flow / settings 寫在 `integration/node-red/` 下，**不在這個 vendored 目錄**：

- `integration/node-red/Dockerfile` — 基於 `nodered/node-red` 官方 image，加上必要的 contrib node
- `integration/node-red/flows.json` — MQTT 訂閱 → 轉換 → REST POST 的 flow 定義
- `integration/node-red/settings.js` — Node-RED 設定（例如 admin auth、credential secret）

要改 bridge 邏輯，**改 `integration/node-red/` 下的檔，不是這裡**。

## 未來計畫

若 fms-backend-rust 加上內建 MQTT subscriber（直接從 mosquitto 訂閱 `iot/forward/#`），Node-RED 這座橋就可以退役 — 詳見 fms-backend-rust 的「已知設計取捨」段。

## 為什麼這份 vendored fork 還在 repo 裡

- 鎖定特定版本，避免 upstream `nodered/node-red:latest` 突然有 breaking change 影響整合驗證
- 方便離線 / 慢網環境 build 對應 image（`integration/node-red/Dockerfile` 走 `npm install` 從 npm registry，不是這個目錄；保留主要是 reference）

實務上，**`integration/node-red/Dockerfile` 用的是 `nodered/node-red` 官方 image + npm 拉套件**，這個 vendored 目錄目前並沒有被 CI 或 docker build pipeline 直接使用。可以視為長期 reference / fallback。

## 不要做的事

- 不要在這裡跑 `npm install` 然後 commit `node_modules/`（已被 .gitignore 擋）
- 不要把 FMS 的 flow / credential 寫進這裡的 `flows.json`（它是 upstream 的 demo/test）
- 不要把這裡的 `package.json` 當作 FMS 的依賴清單

## 找實際在跑的 Node-RED 設定

|要找的東西 | 看哪裡 |
|---|---|
| 跑哪個版本 | `integration/node-red/Dockerfile` 的 `FROM nodered/node-red:<tag>` |
| 訂閱的 MQTT topic | `integration/node-red/flows.json` 的 mqtt-in node |
| 打到 backend 的 endpoint | `integration/node-red/flows.json` 的 http-request node |
| Admin UI auth | `integration/node-red/settings.js` 的 `adminAuth`（**dev 預設無密碼**，正式環境要設） |
| Device UUID mapping | `integration/node-red/flows.json` 的 `deviceMap` 變數 — 要跟 `integration/seed/01_devices.sql` 對齊 |

## graphify

這個目錄有 `graphify-out/`（如果跑過 `/graphify .`），但因為是 vendored upstream code，graph 的訊號意義不大 — 它反映的是 Node-RED 本身的架構，不是 FMS 的設計。要看 FMS 怎麼用 Node-RED，看 `integration/graphify-out/` 比較有意義。
