import { config } from "..";

const bridgeQuestionConfig = [
  {
    blockType: "static_select",
    params: {
      block_id: "operation_type",
      label: "依頼項目",
      optional: config.IS_DEBUGGING,
      options: [
        {
          label: "調査依頼",
          value: "search",
        },
        {
          label: "データ修正依頼",
          value: "data_modify",
        },
        {
          label: "SQLレビュー依頼",
          value: "sql_review",
        },
      ],
    },
  },

  {
    blockType: "plain_text_input",
    params: {
      block_id: "request_background",
      label: "背景",
      optional: config.IS_DEBUGGING,
      multiline: true,
    },
  },

  {
    blockType: "plain_text_input",
    params: {
      block_id: "request_detail",
      optional: config.IS_DEBUGGING,
      multiline: true,
      label: "依頼内容",
    },
  },

  {
    blockType: "number_input",
    params: {
      block_id: "user_id",
      label: "ユーザーID",
      optional: config.IS_DEBUGGING,
      is_decimal_allowed: true,
      min_value: "0",
    },
  },

  {
    blockType: "number_input",
    params: {
      block_id: "order_id",
      label: "オーダーID",
      optional: true,
      is_decimal_allowed: true,
      min_value: "0",
    },
  },

  {
    blockType: "static_select",
    params: {
      block_id: "severity_type",
      label: "緊急度",
      optional: config.IS_DEBUGGING,
      options: [
        {
          label: "当日必須",
          value: "in_today",
        },
        {
          label: "3日以内",
          value: "in_three_days",
        },
        {
          label: "7日以内",
          value: "in_seven_days",
        },
        {
          label: "1週間以上",
          value: "over_one_week",
        },
      ],
    },
  },

  {
    blockType: "datepicker",
    params: {
      label: "対応期限",
      block_id: "limit_date",
      optional: config.IS_DEBUGGING,
    },
  },
];

export {bridgeQuestionConfig};
