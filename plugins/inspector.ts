import { inspector } from "opencode-plugin-inspector"

// Factory package: must be invoked, not listed as a raw npm plugin.
export const Inspector = inspector({ port: 6969 })
