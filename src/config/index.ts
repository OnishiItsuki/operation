import {
  SLACK_SIGNING_SECRET,
  SLACK_ACCESS_TOKEN,
  SLACK_TOKEN,
  SLACK_CHANNEL,
} from "./secretConfig";

export const config = {
  SLACK_SIGNING_SECRET: SLACK_SIGNING_SECRET || "",
  SLACK_ACCESS_TOKEN: SLACK_ACCESS_TOKEN || "",
  SLACK_TOKEN: SLACK_TOKEN || "",
  SLACK_CHANNEL: SLACK_CHANNEL || "",
  IS_DEBUGGING: true,
  SHEET_NAMES: {
    AC: "【airCloset】OP対応依頼",
    ACF: "【aC Fitting】OP対応依頼",
    BR: "【Bridge】OP対応依頼",
    ACM: "【aC MALL】OP対応依頼",
  },
};
