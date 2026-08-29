import { notification } from "opencode-plugin-notification"
import path from "path"
import { fileURLToPath } from "url"

const __dirname = path.dirname(fileURLToPath(import.meta.url))

const notificationCommand =
  process.platform === "win32"
    ? [
        "powershell.exe",
        "-NoProfile",
        "-ExecutionPolicy",
        "Bypass",
        "-File",
        path.join(__dirname, "notify.ps1"),
      ]
    : process.platform === "darwin"
      ? ["bash", path.join(__dirname, "notify-mac.sh")]
      : ["notify-send", "--app-name", "opencode"] // Linux default, matches the plugin's own built-in default

export const Notification = notification({
  idleTime: 60_000,
  notificationCommand,
  additionalCommands: [],
})
