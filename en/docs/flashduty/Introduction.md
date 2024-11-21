---
title: "Introduction"
description: "Introduction to Flashduty Open API."
date: "2024-11-20T10:00:00+08:00"
url: "https://developer-en.flashcat.cloud/en/flashduty/introduction"
---

As a developer, you can interact with FlashDuty through various programming methods.

### Open API

FlashDuty is API-oriented. Almost all entity data on the platform can be accessed and operated through APIs or web pages. Common application scenarios include:
1. Synchronizing enterprise personnel changes to FlashDuty
2. Dynamically adjusting on-call rules and viewing current responders in real-time
3. Regularly exporting incident and operation records for customized insights

For detailed usage instructions, please refer to [Quick Start](https://developer-en.flashcat.cloud/en/flashduty/open-api/quickstart).

### Event API

FlashDuty supports receiving alerts from various commercial and open-source monitoring systems, such as Prometheus, Zabbix, etc. We also support pushing custom alert events through the Event API.

For detailed usage instructions, please refer to [Quick Start](https://developer-en.flashcat.cloud/en/flashduty/event-api/quickstart).

:::tip
Event API and Open API use different authentication methods.
:::

### Webhooks

You can use Webhooks to push real-time incident changes to your own platforms, such as ticket systems or incident auto-healing platforms. This enables incident data synchronization across multiple systems, accelerating incident resolution.

For detailed usage instructions, please refer to [Quick Start](https://developer-en.flashcat.cloud/en/flashduty/webhook/quickstart). 