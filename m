Return-Path: <linux-kselftest+bounces-49016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F91AD24840
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 13:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32D5430321DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 12:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEDB394470;
	Thu, 15 Jan 2026 12:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="JnQgP2wF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013003.outbound.protection.outlook.com [40.107.162.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABAE32E728;
	Thu, 15 Jan 2026 12:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768480149; cv=fail; b=HSa2lNFg8CeBY5RZzJFwLyecEtD3pCEkIev2DcQNk/BAeUGiQlezkYyH96hI00zj//7dqjGsp2oFiDsf5tWBCi0106QwGULLT6Uzpi+eMXg+K5JFwBnU6A+0jABHyCjlN94dQhcgPBDuaagnfvCvlkL7m2tY2ReVP+QewNDsFE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768480149; c=relaxed/simple;
	bh=K+xG6q9M03m17xw3Ss2Zns8IrEW9W9LXKJAfaEremeo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=LeoH6epiCkOpCraBTc2XfCE/fwNCZfFgVrH9w/7BxhZv+Z5ZQ3Ok/dR3KcudcKveqnI9RcxoshCWhesaQ83gGHBhJDQh34abdz8Hb11rrv20N9SpOpUYjBgkDVA5lkQhOjL0aeAp2cm6nKBw8Y4+66BqPu0KEIiufsuNya8n/5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=JnQgP2wF; arc=fail smtp.client-ip=40.107.162.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VA+0okcpuKcs+R39AEWF9efQzDCmSk9b2sub5ph4k1urGerw+RfWMIOGmf19I+RrvSCzbx/+zOVZ88YKlbPCtZpUqDZMDDgYr/J7zRJEGixOJIATiSmISTKDIhWMnZwZiQR21zDX6XbQIMI+OZGAFLGr3+vaCI2QWuOzUL19IzxQuo8gMv8RcngTpW9/y41cTFaG6ui1P7FgfgDjmIE3LrEUGC37F0DTtIZhfpyDWN+10blz2kRF4iWohyejApq51vqybNGunEBF47kwZ7LXX97+v9PdM/CqgCwrRcO8JRFIct8fohtvmfZJiKoOA5kzh1WFO2jLto5IXbZD9LQf5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6XqS5rsMX74T6JUQ2W91ghUmIM8I7gFzzBxD673jbY=;
 b=b6SlWT5QTz/56oLLeWYsbCz6Ca4xQ6w2abbW/sVZSMqD4mPABzeudm8tjonrpnt+uxNhmgzMixKIlHt/Jp5WFRcKk+ZM4a3Psxswd2POgw0DhLN3N8fnzNrg3lt7QgjFjPShsGfvCN/zhzba0zXlf9fnkCKGZ+/hdGHzqJYG0HLU/3GMHopAmOQH5haFE3RW4PDIctWXab4PPHTM0uOw8xulUliHQ/4+ZSyMQ7m61J5n1Ho/9864LiMTnY9LBqgod/47JKc/w8Um/n1RktV4HBebG1yd8p9+h1i6qOjkWDf2JLFZNLWVcxcvnNS3eRwHz8IqI4PLr7N9C1/Zd/bKWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6XqS5rsMX74T6JUQ2W91ghUmIM8I7gFzzBxD673jbY=;
 b=JnQgP2wFLEmgm0ptQ8aGNUM2RIRcTZfDnc6N1mhp9dqFTOab63Ez2q0JEfUnwnUHscXNnxy7NpnIbS7Z74mTfhVkYGjvNnZq9vlz0Fu29omXmOOMwhflvMeTi4Hv1RQ7iVG+H8epKerQ/LMYAOIQLfusuovtCL20k0XAhaWqW6y51gtFgdQx7tFehZnTReJ7gmWkwsPnOmhmryuv52BDiIx+3Ds8vZtudxUs/I3tWktCQDKgjg/bsdH/y7CIWn1wpZUKV97FcI6fprcd2DuxSCJXxZ+4j3tW9Or8cbUIT34ekz/7cKcXCcQfS9VSJ1k2bKEHaZVCahL6ncSC1qNlNg==
Received: from AS4P192CA0018.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::7)
 by AM8PR07MB7618.eurprd07.prod.outlook.com (2603:10a6:20b:241::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 12:29:01 +0000
Received: from AM3PEPF0000A794.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e1:cafe::5c) by AS4P192CA0018.outlook.office365.com
 (2603:10a6:20b:5e1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Thu,
 15 Jan 2026 12:29:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM3PEPF0000A794.mail.protection.outlook.com (10.167.16.123) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Thu, 15 Jan 2026 12:29:01 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id A3FDF20164;
	Thu, 15 Jan 2026 14:28:59 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	parav@nvidia.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	ast@fiberby.net,
	liuhangbin@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v8 net-next 00/14] AccECN protocol case handling series
Date: Thu, 15 Jan 2026 13:28:32 +0100
Message-Id: <20260115122846.114576-1-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A794:EE_|AM8PR07MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: fb6618af-a4ec-45a8-7fe6-08de5431a9ed
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|18082099003|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Z0c1LzZGbm9KRmlXWHpsdUh0MmRxOHFOZnhmWGVxamR2MjFhVHV6dWVxVkVo?=
 =?utf-8?B?RW9iL1diajhDQjI2ajNRR09UWVBCVXhrNk1velpQOTJMT0hHWWE4aTViNjJp?=
 =?utf-8?B?SjFaTHhzSkVUSXhrdjNKM2xzdGZRcGJTUWRMZjlldDJxZ01TWkpFeC95NFdR?=
 =?utf-8?B?NVY1elVJVDh2czZuMVdqc1g3KzFUTzR0aUp3NHJ3OXhBcW1GbUpzZlJJZGRh?=
 =?utf-8?B?QS9zVEtjazFGQXJPenkrU1NuQ0ZuSmpPTEFTWmRPUWR4L2pmNWp2NTRNS25i?=
 =?utf-8?B?K1l1TjhYOHNPOHJqUS9ka0F6elg3eTNzVXdSRXB0dmp1OWNSL0FQU0RYK3N6?=
 =?utf-8?B?czZMK0lKRkt4RTFXN3hOWFptb0daRzc0SFRCUFcwRFQ2Tk9paHY3VDc5Z3Uz?=
 =?utf-8?B?K2pka0RjMWRUeEtEakl5RzQwL3AvNjQwbHFNT1FLSjZaTnA3cGl3dnRod2Iz?=
 =?utf-8?B?c0F4T1IyMzdJbmxXdUY4dnNZNlR3d09hZWFwaXhCZDltakkyKy9EVHg3OGdt?=
 =?utf-8?B?djVnUEZNcjAwRk44bTByN3FMOFh3bU1waERKRU8zR3ViTUZ3RVNBeG9jQ0o4?=
 =?utf-8?B?V0Z6eFh2RURiV2NWTnVibWxFNUYrUFM0NFJubzZpWnBWS1Z3eUN2NmlrRWtF?=
 =?utf-8?B?SDNuVzFuRHRxdGdyUi8xTzY1Ym9JekcwemhuSVVTbmhlY25JTG02NVpocSti?=
 =?utf-8?B?TUNhN211SkE2dThITGhQVk5Zak04MU5VMG5rMkFLTFNXeGVTUkhwWG9taDds?=
 =?utf-8?B?TWRqQ2ZhTGRkMHBsNUJjTk5TQkpQVXdRVkVzcGZzNjlOU25IcWJEbjNCaVRX?=
 =?utf-8?B?NHdnYlJDNjZZMWkvNzRWTi90UmhzYVZ0UkdZVVRLNnQzMDdBckxqRElLWUR4?=
 =?utf-8?B?d1I5aEIwWXlaSGdUdkVIR25tWXZnaEtzY05taUpzUTdNRDBYZTF1bEQ0YWxs?=
 =?utf-8?B?NE9LYXI0ZXlaZWZsclJLWUpMdmxHMm00ZFFQRktNckFBVnpFcDZIR1BjM3pZ?=
 =?utf-8?B?TzdOY1lEcmNBUU5heXBvS2RqUmV3NFpwTEtOaVgzZStUN0F4MU9OQ0xwdEdZ?=
 =?utf-8?B?b202bGJmQ3dESWEwMFZuRnduck42cXRISlFiNTFEL2NGWllwNk5pSGVja2xZ?=
 =?utf-8?B?c3d1NUF4TTI5R1h3Z1BvZnpuWmk3TXE2OUVZWWMyZFd5Vy85SHMvU2I4RUpH?=
 =?utf-8?B?TCs4cHY0TTg4N0l5SzRwYXRYaDhJd1BjRnorcXVubVN2WnJKVHhjellkU1JR?=
 =?utf-8?B?MzhmakpSR1A3SnVGZks5Mld3V1paVFRrOElWemJJalp2V2RjWDUwOFZsbDZV?=
 =?utf-8?B?eVNub2VEZDhHeTZyaGtsai9QMXRUV3Jhc24vZGhnVnZyM3JvbGtLZmw3Vyth?=
 =?utf-8?B?bFA4cHhMU1RkR2E0cWwyMXlLbHpqUDlXaUpmeFRRVzNJTUZtZ1h1anZVOVRy?=
 =?utf-8?B?eEFuTnJySGlMK1Q4TzVDbWFSWkxCNHdSS3JhbFFWNXNLR2pFZjRZek1hTFJa?=
 =?utf-8?B?Ly82QVhoQ2tqeVdiOU9mZzZBRVcxdytyTXBwOEphMGZNbTFqOVFCT09aMkh5?=
 =?utf-8?B?R09IdlViTWpGUThhbzduUzNxT2NsemNxblJuQ1hQWmhqMkFMdTRYUWYxYnpU?=
 =?utf-8?B?UEpyTElpRUZ2Q0JaRHZqd0Z5VUdYMjJTZkdWRjRpU0w0T3VlZnlGRDFyLzVX?=
 =?utf-8?B?R2RHMlczR3JaWnEyYUNlMU1Sa1B0MzVmeVpwVG9sYlRwaDVOS09IcnFjYW9S?=
 =?utf-8?B?SXlWN0hRZmRWNEhNNkRqWW5WTVJnQU1vSUFmTzRWTVovSmZWUkJBWGtLTWJI?=
 =?utf-8?B?WExZOXdlbUdCSGg2d29sc2VZdFo3NlZKaWM0cWxBZnNvTm45ZHJiUGgwZzN0?=
 =?utf-8?B?ZDRoVjJsdWp4RERwOUhBZzNrc0NoNVg4NkJzcUwzU2ppSDNZa2ZnQWF2MDRo?=
 =?utf-8?B?UXRQbklQeHJzcXkveElpUHBMMkx4clRYMk03Ky9KSW1IeUFvV3lndDhYM1Q4?=
 =?utf-8?B?SVBpMzNmWmljcVZFbEpaZktFbGZDSzg5d2VXa1dZb0syYVY2VzV0c2hiM2ox?=
 =?utf-8?B?MXVzTXhydDBnTVBDa3A1ZGdpT2NzbkJra3VPYnZIOSs4WG41dGlDT2ZacU5C?=
 =?utf-8?B?Sm91ZTc5YXdaeWV2Q0pjbHN6dnVSQzNXSnQzYWwrUzhkK1czeUpNS0VzOTRR?=
 =?utf-8?B?ekNXOThqY0lvMEw3dFp0dSs2SmZrT2hIeG1ZUEY2VXVCUmMxSkUxeWp2RmJs?=
 =?utf-8?Q?gRGSsXb0H9NCfJfrC5vEeqiT4x3d9stW9Gd9gqvR8U=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(18082099003)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 12:29:01.3155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6618af-a4ec-45a8-7fe6-08de5431a9ed
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF0000A794.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB7618

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Plesae find the v8 AccECN case handling patch series, which covers
several excpetional case handling of Accurate ECN spec (RFC9768),
adds new identifiers to be used by CC modules, adds ecn_delta into
rate_sample, and keeps the ACE counter for computation, etc.

This patch series is part of the full AccECN patch series, which is available at
https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

Best regards,
Chia-Yu

---
v8:
- Add apcketdrill patch #14 into this series (Paolo Abeni <pabeni@redhat.com> & Jakub Kicinski <kuba@kernel.org>)
- Add helper function in patch #10 (Paolo Abeni <pabeni@redhat.com>)

v7:
- Update comments in #3 (Paolo Abeni <pabeni@redhat.com>)
- Update comments and use synack_type TCP_SYNACK_RETRANS and num_timeout in #9. (Paolo Abeni <pabeni@redhat.com>)

v6:
- Update comment in #3 to highlight RX path is only used for virtio-net (Paolo Abeni <pabeni@redhat.com>)
- Rename TCP_CONG_WANTS_ECT_1 to TCP_CONG_ECT_1_NEGOTIATION to distiguish from TCP_CONG_ECT_1_ESTABLISH (Paolo Abeni <pabeni@redhat.com>)
- Move TCP_CONG_ECT_1_ESTABLISH in #6 to latter patch series (Paolo Abeni <pabeni@redhat.com>)
- Add new synack_type instead of moving the increment of num_retran in #9 (Paolo Abeni <pabeni@redhat.com>)
- Use new synack_type TCP_SYNACK_RETRANS and num_retrans for SYN/ACK retx fallbackk for AccECN in #10 (Paolo Abeni <pabeni@redhat.com>)
- Do not cast const struct into non-const in #11, and set AccECN fail mode after tcp_rtx_synack() (Paolo Abeni <pabeni@redhat.com>)

v5:
- Move previous #11 in v4 in latter patch after discussion with RFC author.
- Add #3 to update the comments for SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN. (Parav Pandit <parav@nvidia.com>)
- Add gro self-test for TCP CWR flag in #4. (Eric Dumazet <edumazet@google.com>)
- Add fixes: tag into #7 (Paolo Abeni <pabeni@redhat.com>)
- Update commit message of #8 and if condition check (Paolo Abeni <pabeni@redhat.com>)
- Add empty line between variable declarations and code in #13 (Paolo Abeni <pabeni@redhat.com>)

v4:
- Add previous #13 in v2 back after dicussion with the RFC author.
- Add TCP_ACCECN_OPTION_PERSIST to tcp_ecn_option sysctl to ignore AccECN fallback policy on sending AccECN option.

v3:
- Add additional min() check if pkts_acked_ewma is not initialized in #1. (Paolo Abeni <pabeni@redhat.com>)
- Change TCP_CONG_WANTS_ECT_1 into individual flag add helper function INET_ECN_xmit_wants_ect_1() in #3. (Paolo Abeni <pabeni@redhat.com>)
- Add empty line between variable declarations and code in #4. (Paolo Abeni <pabeni@redhat.com>)
- Update commit message to fix old AccECN commits in #5. (Paolo Abeni <pabeni@redhat.com>)
- Remove unnecessary brackets in #10. (Paolo Abeni <pabeni@redhat.com>)
- Move patch #3 in v2 to a later Prague patch serise and remove patch #13 in v2. (Paolo Abeni <pabeni@redhat.com>)

Chia-Yu Chang (12):
  selftests/net: gro: add self-test for TCP CWR flag
  tcp: ECT_1_NEGOTIATION and NEEDS_ACCECN identifiers
  tcp: disable RFC3168 fallback identifier for CC modules
  tcp: accecn: handle unexpected AccECN negotiation feedback
  tcp: accecn: retransmit downgraded SYN in AccECN negotiation
  tcp: add TCP_SYNACK_RETRANS synack_type
  tcp: accecn: retransmit SYN/ACK without AccECN option or non-AccECN
    SYN/ACK
  tcp: accecn: unset ECT if receive or send ACE=0 in AccECN negotiaion
  tcp: accecn: fallback outgoing half link to non-AccECN
  tcp: accecn: detect loss ACK w/ AccECN option and add
    TCP_ACCECN_OPTION_PERSIST
  tcp: accecn: enable AccECN
  selftests/net: packetdrill: add TCP Accurate ECN cases

Ilpo Järvinen (2):
  tcp: try to avoid safer when ACKs are thinned
  gro: flushing when CWR is set negatively affects AccECN

 Documentation/networking/ip-sysctl.rst        |  4 +-
 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  4 +-
 include/net/inet_ecn.h                        | 20 +++-
 include/net/tcp.h                             | 32 +++++-
 include/net/tcp_ecn.h                         | 99 ++++++++++++++-----
 net/ipv4/inet_connection_sock.c               |  3 +
 net/ipv4/sysctl_net_ipv4.c                    |  4 +-
 net/ipv4/tcp.c                                |  2 +
 net/ipv4/tcp_cong.c                           |  5 +-
 net/ipv4/tcp_input.c                          | 37 ++++++-
 net/ipv4/tcp_minisocks.c                      | 43 +++++---
 net/ipv4/tcp_offload.c                        |  3 +-
 net/ipv4/tcp_output.c                         | 32 +++---
 net/ipv4/tcp_timer.c                          |  2 +
 tools/testing/selftests/drivers/net/gro.c     | 81 ++++++++++-----
 tools/testing/selftests/drivers/net/gro.py    |  3 +-
 .../tcp_accecn_2nd_data_as_first.pkt          | 24 +++++
 .../tcp_accecn_2nd_data_as_first_connect.pkt  | 30 ++++++
 .../tcp_accecn_3rd_ack_after_synack_rxmt.pkt  | 19 ++++
 ..._accecn_3rd_ack_ce_updates_received_ce.pkt | 18 ++++
 .../tcp_accecn_3rd_ack_lost_data_ce.pkt       | 22 +++++
 .../net/packetdrill/tcp_accecn_3rd_dups.pkt   | 26 +++++
 .../tcp_accecn_acc_ecn_disabled.pkt           | 14 +++
 .../tcp_accecn_accecn_then_notecn_syn.pkt     | 28 ++++++
 .../tcp_accecn_accecn_to_rfc3168.pkt          | 18 ++++
 .../tcp_accecn_client_accecn_options_drop.pkt | 34 +++++++
 .../tcp_accecn_client_accecn_options_lost.pkt | 38 +++++++
 .../tcp_accecn_clientside_disabled.pkt        | 12 +++
 ...cecn_close_local_close_then_remote_fin.pkt | 25 +++++
 .../tcp_accecn_delivered_2ndlargeack.pkt      | 25 +++++
 ..._accecn_delivered_falseoverflow_detect.pkt | 31 ++++++
 .../tcp_accecn_delivered_largeack.pkt         | 24 +++++
 .../tcp_accecn_delivered_largeack2.pkt        | 25 +++++
 .../tcp_accecn_delivered_maxack.pkt           | 25 +++++
 .../tcp_accecn_delivered_updates.pkt          | 70 +++++++++++++
 .../net/packetdrill/tcp_accecn_ecn3.pkt       | 12 +++
 .../tcp_accecn_ecn_field_updates_opt.pkt      | 35 +++++++
 .../packetdrill/tcp_accecn_ipflags_drop.pkt   | 14 +++
 .../tcp_accecn_listen_opt_drop.pkt            | 16 +++
 .../tcp_accecn_multiple_syn_ack_drop.pkt      | 28 ++++++
 .../tcp_accecn_multiple_syn_drop.pkt          | 18 ++++
 .../tcp_accecn_negotiation_bleach.pkt         | 23 +++++
 .../tcp_accecn_negotiation_connect.pkt        | 23 +++++
 .../tcp_accecn_negotiation_listen.pkt         | 26 +++++
 .../tcp_accecn_negotiation_noopt_connect.pkt  | 23 +++++
 .../tcp_accecn_negotiation_optenable.pkt      | 23 +++++
 .../tcp_accecn_no_ecn_after_accecn.pkt        | 20 ++++
 .../net/packetdrill/tcp_accecn_noopt.pkt      | 27 +++++
 .../net/packetdrill/tcp_accecn_noprogress.pkt | 27 +++++
 .../tcp_accecn_notecn_then_accecn_syn.pkt     | 28 ++++++
 .../tcp_accecn_rfc3168_to_fallback.pkt        | 18 ++++
 .../tcp_accecn_rfc3168_to_rfc3168.pkt         | 18 ++++
 .../tcp_accecn_sack_space_grab.pkt            | 28 ++++++
 .../tcp_accecn_sack_space_grab_with_ts.pkt    | 39 ++++++++
 ...tcp_accecn_serverside_accecn_disabled1.pkt | 20 ++++
 ...tcp_accecn_serverside_accecn_disabled2.pkt | 20 ++++
 .../tcp_accecn_serverside_broken.pkt          | 19 ++++
 .../tcp_accecn_serverside_ecn_disabled.pkt    | 19 ++++
 .../tcp_accecn_serverside_only.pkt            | 18 ++++
 ...n_syn_ace_flags_acked_after_retransmit.pkt | 18 ++++
 .../tcp_accecn_syn_ace_flags_drop.pkt         | 16 +++
 ...n_ack_ace_flags_acked_after_retransmit.pkt | 27 +++++
 .../tcp_accecn_syn_ack_ace_flags_drop.pkt     | 27 +++++
 .../net/packetdrill/tcp_accecn_syn_ce.pkt     | 13 +++
 .../net/packetdrill/tcp_accecn_syn_ect0.pkt   | 13 +++
 .../net/packetdrill/tcp_accecn_syn_ect1.pkt   | 13 +++
 .../net/packetdrill/tcp_accecn_synack_ce.pkt  | 28 ++++++
 ..._accecn_synack_ce_updates_delivered_ce.pkt | 22 +++++
 .../packetdrill/tcp_accecn_synack_ect0.pkt    | 24 +++++
 .../packetdrill/tcp_accecn_synack_ect1.pkt    | 24 +++++
 .../packetdrill/tcp_accecn_synack_rexmit.pkt  | 15 +++
 .../packetdrill/tcp_accecn_synack_rxmt.pkt    | 25 +++++
 .../packetdrill/tcp_accecn_tsnoprogress.pkt   | 26 +++++
 .../net/packetdrill/tcp_accecn_tsprogress.pkt | 25 +++++
 75 files changed, 1654 insertions(+), 87 deletions(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_2nd_data_as_first.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_2nd_data_as_first_connect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_after_synack_rxmt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_ce_updates_received_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_lost_data_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_dups.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_acc_ecn_disabled.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_accecn_then_notecn_syn.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_accecn_to_rfc3168.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_client_accecn_options_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_client_accecn_options_lost.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_clientside_disabled.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_close_local_close_then_remote_fin.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_2ndlargeack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_falseoverflow_detect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_largeack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_largeack2.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_maxack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_updates.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_ecn3.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_ecn_field_updates_opt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_ipflags_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_listen_opt_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_multiple_syn_ack_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_multiple_syn_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_bleach.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_connect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_listen.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_noopt_connect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_optenable.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_no_ecn_after_accecn.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_noopt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_noprogress.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_notecn_then_accecn_syn.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_rfc3168_to_fallback.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_rfc3168_to_rfc3168.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_sack_space_grab.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_sack_space_grab_with_ts.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_accecn_disabled1.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_accecn_disabled2.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_broken.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_ecn_disabled.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_only.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ace_flags_acked_after_retransmit.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ace_flags_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ack_ace_flags_acked_after_retransmit.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ack_ace_flags_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ect0.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ect1.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ce_updates_delivered_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ect0.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ect1.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_rexmit.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_rxmt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_tsnoprogress.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_tsprogress.pkt

-- 
2.34.1


