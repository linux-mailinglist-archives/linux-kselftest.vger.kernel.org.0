Return-Path: <linux-kselftest+bounces-31320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3750EA97152
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 17:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0741E401285
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 15:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC444293454;
	Tue, 22 Apr 2025 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="i2ezByfx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6CE28F957;
	Tue, 22 Apr 2025 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336328; cv=fail; b=AG7yqOQTV8gIvVNvSbnuM4x38Dys2N8kIXyYrEubZ0XtfmS+w7CNxX7uJU++wg+IMsMkIejaujlx1HmG5KBPaEDPOGJS/3LiFdXhxpbEDD0POLMXziOo6QATkZocqMPjuTbYza3p6xt8eVIWMq4jYybFmryLLey1q2ezCmXKMkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336328; c=relaxed/simple;
	bh=H4Ta/aqH/+X5fm7gdt8gL4ezvI2uAzIeY8VEnU+1crI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B8+STnQDVQnK4pXSDQ/avz8Ypyeh9aL8QBjzz/gJX17WkVZhYas0g4T6xxrtVuskaN/oJ4YMB3ut0zniVzKOcXOeiLvznjH/5gCcKT+C/qNW6fmoB8kWAGJVhNZqwYNOCA4rltA0Skeb340HtMI7th/yQUee1YNJl5iL986KbpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=i2ezByfx; arc=fail smtp.client-ip=40.107.20.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGkmC7soNN+46XEnrT9z133IApi3cX8sLz5AJzQbmnsgo/gGzILnEe0DxSR967AodfYlIie/IDVCSUS2eXJrf72436l23UwypsDES7GXNJp1jIswsUf3oPFpxGcI+LLJKpE1Ui60xUsIOFAvD9eKpV8/34qVY+9Akfz/mg11NlOHrEUqcDPt8M1+bCrilLytXb9lwKobA7t2MPqePWswkjYYeEkGKd39RSYEteahhc5O3ZwOEeSZ0/Cu4uTuXapPPKlcaI2646ztuDmc7Swt3aJnBqdQ5uqEj4WI4vDxR7q3XSnA6qAUjrlYJjnfcRldprYkXhQGB9rfDwHfW4P3uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Poqcka8LGzahnVUc7Z0FpFiE5ylqtV+odWq87mE8f6I=;
 b=H/HaLem5SmPppu3fhNYwpNqQuCGBPvV2uiWI5Kn0OGqPvew+/BHXOU6t0xUWYC3f+UCEOjnEevgvvXpLfQRB3mBm0++B53gm0HbLQ81bK8uKitdF1CL/PtiygxakZpqMFdwZsSZ1dedPWq+YKu0tSk4KrZ3uO2F2oHifhBzduXRX1QJB+e8RFQMvE9B9ElLYu4NZ1M/tJgYzPk4B4MNv5ZXHhWUuOspY5uJJM7IL1RKo4wICOmCzBS1gmY2yXnNjjv7M+jxy1hIHFy4+/0kAdHmD4FuNH3QpuQ9aj32ljeRuo0iNbBaDYefsShXYxAjZ1kcqF0v634g/8iif/ZhB+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Poqcka8LGzahnVUc7Z0FpFiE5ylqtV+odWq87mE8f6I=;
 b=i2ezByfx8m3/PJ48ay0FlkaddSpaYhfaNMTMlRLnIqC3+jeZb0WxCdu1B3fDiXNkhNKrImlpzwJLyulKbU286Md2CUDJMN4ylw+KHmFWnCZwbH2bQHxLmxfKiMsmHQs9svP+GbvsBSJ/s1wa6pxAMSKkt1gAZnkHQhoOy0iH5gB+qqbYT0Ql5lchdD9ptT944o7Z+neULXi2mNSsB24nJSWG19AHscuTS2RnvqZDdsdJXHM35QTt7sfITt0zsuHbQlbSHAJNF58Dwe6cZ2H7YAkq/HWGioPGZSvXidGvoiiA9XDew36abOJIDk/YSfBquCJGMK5ZItJDGAGQgTid3A==
Received: from AS4P192CA0043.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:658::9)
 by DBAPR07MB6936.eurprd07.prod.outlook.com (2603:10a6:10:17e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Tue, 22 Apr
 2025 15:38:40 +0000
Received: from AMS0EPF0000019C.eurprd05.prod.outlook.com
 (2603:10a6:20b:658:cafe::b8) by AS4P192CA0043.outlook.office365.com
 (2603:10a6:20b:658::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Tue,
 22 Apr 2025 15:38:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.29)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 AMS0EPF0000019C.mail.protection.outlook.com (10.167.16.248) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Tue, 22 Apr 2025 15:38:40 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 94A5620A28;
	Tue, 22 Apr 2025 18:38:38 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@amazon.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
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
Subject: [PATCH v5 net-next 11/15] tcp: accecn: AccECN option failure handling
Date: Tue, 22 Apr 2025 17:35:58 +0200
Message-Id: <20250422153602.54787-12-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019C:EE_|DBAPR07MB6936:EE_
X-MS-Office365-Filtering-Correlation-Id: 54cd19b9-6c14-4b46-77ad-08dd81b3c196
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WEhjbUU5cnpLVWZndW1OaExKVjc3WkRrdm4xV3lhMVJQeVBJVmRRK3RYZ2ln?=
 =?utf-8?B?bit4K2M0QjZnQ3pXVFRrM2VYMGpGVHFROGlqMjRpc2FjNjI5dEhOdGIwS1lF?=
 =?utf-8?B?OHdWUnZ5TFE3dVA2ZmpDc0JWODB2eWtvVEcvTU1LV2hab29BOTFnTHJEMjlM?=
 =?utf-8?B?RThMUDY3Z2RqOTZXdEdVSDhpWklvSmFVWGsvdHFlNEEyTzlWWEdyUkpCT0dk?=
 =?utf-8?B?SURsTE9kak9ZR3FmMHBmbjVFSXllYzh2aGt3MEhkMXdOUlc2ZU9GcTZ0d3ZP?=
 =?utf-8?B?b0JtK1Mwd1ZMalNHcHh4MTdkK0o5T2czNlpPUStleDFFdCtKbUlJY09VYVUv?=
 =?utf-8?B?QTlkam5IeTdVaUFST1dXNFdLek5WYkZjbE5GT2pLVmhFbDRtQXI3emZuY05p?=
 =?utf-8?B?UGJBWlBsZmNxY3ROcCs1a3VvZWtxL21tTFVzZnFxQVdzcGFKOVQ3NWIxMzgr?=
 =?utf-8?B?UUtKZUNIc3MvSWs5TlN2OSs2Q1VpR3E5UWoyd0s0ZHQreXlsZnRFMW9aNE16?=
 =?utf-8?B?cmg2bVNpZHVmSSs2dVAyNE0xejB2bm5TNVFvb0c4NkxNOUZBZVJIS3lSL1c5?=
 =?utf-8?B?WWFYS0ROSW1PL3o0RGNqWk41WC81b0F5MFlSQ2djdTBCanlZV3hwdlBmQS81?=
 =?utf-8?B?Wm5jMGxBQzk2MzVVTmZ1aUJyeVRRZGVpNzBiaFEvMzF6Z0UrMTFJYnhaeW5y?=
 =?utf-8?B?bkVmaWdpWEVGalFDVjdWY1A0MnZLSmZGSFVteXhHZVU3UE9HczFTZ20yWjM0?=
 =?utf-8?B?Mm85am41YnArMFJOK2tkRXFYVUh6SUhMOG1qbDZINFhpTVRJWUlXZytFbHZU?=
 =?utf-8?B?dnFIcHRlMSt0VTNiQkpYemd1dGpvbnlFaCs2bml6c1JJdVY0WG9KZzBvQmpJ?=
 =?utf-8?B?em0zZWo1T1Bjdnd0ZU9ZS3dHUENuTlRncVY5WVRORzJ0UmlQMjVid3ZzRFJh?=
 =?utf-8?B?bFpvS250M2VlN2xPNGVOUDFjQ2FZWTEvSEdaMUtHY09Ubkc2VFlMNTQ2MUlQ?=
 =?utf-8?B?VEJQYW1GWWtuMThCTXZlMFNoaFhUbXpwTGpndHA1Wnl0WjU5YzBjdEJjbHl6?=
 =?utf-8?B?b2FSZi9SSFdwOEVKSTVSenhSVk5ZWWdUeDN6aERGczk2RzVmbzNsTG9wa1Fu?=
 =?utf-8?B?UGY0NkxpNmFZY2FxWDg4cE5qdC9WYjhxNUEvTCswRUpZUVhncVk4Z0xSZjhQ?=
 =?utf-8?B?a0taVlRmRFpJK3AxbS8vQVlrU1g3cWtKTVMxZWUvWDJiMHdsdFc0cGdGTE9u?=
 =?utf-8?B?eEZud04xajRhcW5ZeVd6SVprWi9ubTJ1MGZtK01JQUJaUkJqMXIrMmlySWF5?=
 =?utf-8?B?RGcrSFVqTFdXYmJuNU0zb1B5ZnpwRzN3VW1GZytrODJuTURCanFXV3QyNC9n?=
 =?utf-8?B?Vkloc3VJNUFTUml3YXkwc0M3RzByQ01rTU9ja2hhN0dDdERQRmlsbmxVdmNt?=
 =?utf-8?B?Z0t2Y0VnNzM2cGNSeStoRjV4L2V6bmNvU0VweXhqekE5d05pL1Q0U0ZjdG50?=
 =?utf-8?B?eXRGMXcyU3pNcHJoZjJ4N09CUUlJVXpNRUE1MlFaWnEzUi8yRE9DTTNycURW?=
 =?utf-8?B?TGQ4OWxVRGZzUllXUjdKaW43RjBtMWJWMkd4TmNpMGxNZmlSaDlhc1huS1V1?=
 =?utf-8?B?QTIvYzRMSFphYStYRURwUG5seHl2MHR5Rm1yMjN5ajBhNldUdmFMV20vbjdS?=
 =?utf-8?B?QjZXbDBEK0hnYWpXY2JTYk9wSmV5dldEMjBvTGpZcUNQa0NianhLMW1tSFRM?=
 =?utf-8?B?MTZIUlJkME9aRnFsNDNmVG5obGgvTi9SMzVXN0tXTjg4UlZYbjhBaGs4RmJi?=
 =?utf-8?B?bitjU2FWSTdrSGdzVUpqdVNIWmt5SjN6ZXNWZ3o3L3p2UHZSYXM1RjZrZWxG?=
 =?utf-8?B?WkdSMUN0TUtxZ3dVOVpIenJkRzR0d0NTQlkwUVU5VFdPUGYzUFY5OS9OWE84?=
 =?utf-8?B?UmtxNGtJckxwWmJpVlVPWGY3MWtzNnc5WFpZWk9jSWNTM1MrNjVLM1pJWDRl?=
 =?utf-8?B?ZFJweXpyd3JTU0UvaGwwK3hIbjZUSkx3Q1RpdmxtUmdOaGdqOXFQVkFNbFlJ?=
 =?utf-8?B?YVJDVmEzRDNxS2duekdOWnBCVDVQYVE4Z0dPZz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 15:38:40.0191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54cd19b9-6c14-4b46-77ad-08dd81b3c196
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6936

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

AccECN option may fail in various way, handle these:
- Remove option from SYN/ACK rexmits to handle blackholes
- If no option arrives in SYN/ACK, assume Option is not usable
        - If an option arrives later, re-enabled
- If option is zeroed, disable AccECN option processing

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/tcp.h      |  6 ++--
 include/net/tcp.h        |  7 +++++
 net/ipv4/tcp.c           |  1 +
 net/ipv4/tcp_input.c     | 67 +++++++++++++++++++++++++++++++++++-----
 net/ipv4/tcp_minisocks.c | 38 +++++++++++++++++++++++
 net/ipv4/tcp_output.c    |  7 +++--
 6 files changed, 115 insertions(+), 11 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index acb0727855f8..b93bf1785008 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -160,7 +160,8 @@ struct tcp_request_sock {
 	u8				accecn_ok  : 1,
 					syn_ect_snt: 2,
 					syn_ect_rcv: 2;
-	u8				accecn_fail_mode:4;
+	u8				accecn_fail_mode:4,
+					saw_accecn_opt  :2;
 	u32				txhash;
 	u32				rcv_isn;
 	u32				snt_isn;
@@ -391,7 +392,8 @@ struct tcp_sock {
 		syn_ect_snt:2,	/* AccECN ECT memory, only */
 		syn_ect_rcv:2,	/* ... needed durign 3WHS + first seqno */
 		wait_third_ack:1; /* Wait 3rd ACK in simultaneous open */
-	u8	accecn_fail_mode:4;     /* AccECN failure handling */
+	u8	accecn_fail_mode:4,	/* AccECN failure handling */
+		saw_accecn_opt:2;	/* An AccECN option was seen */
 	u8	thin_lto    : 1,/* Use linear timeouts for thin streams */
 		fastopen_connect:1, /* FASTOPEN_CONNECT sockopt */
 		fastopen_no_cookie:1, /* Allow send/recv SYN+data without a cookie */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 3ee5b52441e3..0ade2873b84e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -276,6 +276,12 @@ static inline void tcp_accecn_fail_mode_set(struct tcp_sock *tp, u8 mode)
 	tp->accecn_fail_mode |= mode;
 }
 
+/* tp->saw_accecn_opt states */
+#define TCP_ACCECN_OPT_NOT_SEEN		0x0
+#define TCP_ACCECN_OPT_EMPTY_SEEN	0x1
+#define TCP_ACCECN_OPT_COUNTER_SEEN	0x2
+#define TCP_ACCECN_OPT_FAIL_SEEN	0x3
+
 /* Flags in tp->nonagle */
 #define TCP_NAGLE_OFF		1	/* Nagle's algo is disabled */
 #define TCP_NAGLE_CORK		2	/* Socket is corked	    */
@@ -477,6 +483,7 @@ static inline int tcp_accecn_extract_syn_ect(u8 ace)
 bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace, u8 sent_ect);
 void tcp_accecn_third_ack(struct sock *sk, const struct sk_buff *skb,
 			  u8 syn_ect_snt);
+u8 tcp_accecn_option_init(const struct sk_buff *skb, u8 opt_offset);
 void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
 			       u32 payload_len);
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index a712643a934e..03c205eaabe5 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3367,6 +3367,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->delivered_ce = 0;
 	tp->wait_third_ack = 0;
 	tp->accecn_fail_mode = 0;
+	tp->saw_accecn_opt = TCP_ACCECN_OPT_NOT_SEEN;
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 1e8e49881ca4..8f1e10530880 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -446,8 +446,8 @@ bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace, u8 sent_ect)
 }
 
 /* See Table 2 of the AccECN draft */
-static void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
-			       u8 ip_dsfield)
+static void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb,
+			       const struct tcphdr *th, u8 ip_dsfield)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	u8 ace = tcp_accecn_ace(th);
@@ -466,7 +466,19 @@ static void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
 	default:
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_rcv = ip_dsfield & INET_ECN_MASK;
-		tp->accecn_opt_demand = 2;
+		if (tp->rx_opt.accecn &&
+		    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+			u8 saw_opt = tcp_accecn_option_init(skb,
+							    tp->rx_opt.accecn);
+
+			tp->saw_accecn_opt = saw_opt;
+			if (tp->saw_accecn_opt == TCP_ACCECN_OPT_FAIL_SEEN) {
+				u8 fail_mode = TCP_ACCECN_OPT_FAIL_RECV;
+
+				tcp_accecn_fail_mode_set(tp, fail_mode);
+			}
+			tp->accecn_opt_demand = 2;
+		}
 		if (INET_ECN_is_ce(ip_dsfield) &&
 		    tcp_accecn_validate_syn_feedback(sk, ace,
 						     tp->syn_ect_snt)) {
@@ -586,7 +598,23 @@ static bool tcp_accecn_process_option(struct tcp_sock *tp,
 	bool order1, res;
 	unsigned int i;
 
+	if (tcp_accecn_opt_fail_recv(tp))
+		return false;
+
 	if (!(flag & FLAG_SLOWPATH) || !tp->rx_opt.accecn) {
+		if (!tp->saw_accecn_opt) {
+			/* Too late to enable after this point due to
+			 * potential counter wraps
+			 */
+			if (tp->bytes_sent >= (1 << 23) - 1) {
+				u8 fail_mode = TCP_ACCECN_OPT_FAIL_RECV;
+
+				tp->saw_accecn_opt = TCP_ACCECN_OPT_FAIL_SEEN;
+				tcp_accecn_fail_mode_set(tp, fail_mode);
+			}
+			return false;
+		}
+
 		if (estimate_ecnfield) {
 			u8 ecnfield = estimate_ecnfield - 1;
 
@@ -602,6 +630,13 @@ static bool tcp_accecn_process_option(struct tcp_sock *tp,
 	order1 = (ptr[0] == TCPOPT_ACCECN1);
 	ptr += 2;
 
+	if (tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+		tp->saw_accecn_opt = tcp_accecn_option_init(skb,
+							    tp->rx_opt.accecn);
+		if (tp->saw_accecn_opt == TCP_ACCECN_OPT_FAIL_SEEN)
+			tcp_accecn_fail_mode_set(tp, TCP_ACCECN_OPT_FAIL_RECV);
+	}
+
 	res = !!estimate_ecnfield;
 	for (i = 0; i < 3; i++) {
 		if (optlen >= TCPOLEN_ACCECN_PERFIELD) {
@@ -6457,10 +6492,25 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	 */
 	if (th->syn) {
 		if (tcp_ecn_mode_accecn(tp)) {
-			u8 opt_demand = max_t(u8, 1, tp->accecn_opt_demand);
-
 			send_accecn_reflector = true;
-			tp->accecn_opt_demand = opt_demand;
+			if (tp->rx_opt.accecn &&
+			    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+				u8 offset = tp->rx_opt.accecn;
+				u8 opt_demand;
+				u8 saw_opt;
+
+				saw_opt = tcp_accecn_option_init(skb, offset);
+				tp->saw_accecn_opt = saw_opt;
+				if (tp->saw_accecn_opt ==
+				    TCP_ACCECN_OPT_FAIL_SEEN) {
+					u8 fail_mode = TCP_ACCECN_OPT_FAIL_RECV;
+
+					tcp_accecn_fail_mode_set(tp, fail_mode);
+				}
+				opt_demand = max_t(u8, 1,
+						   tp->accecn_opt_demand);
+				tp->accecn_opt_demand = opt_demand;
+			}
 		}
 		if (sk->sk_state == TCP_SYN_RECV && sk->sk_socket && th->ack &&
 		    TCP_SKB_CB(skb)->seq + 1 == TCP_SKB_CB(skb)->end_seq &&
@@ -6954,7 +7004,8 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		 */
 
 		if (tcp_ecn_mode_any(tp))
-			tcp_ecn_rcv_synack(sk, th, TCP_SKB_CB(skb)->ip_dsfield);
+			tcp_ecn_rcv_synack(sk, skb, th,
+					   TCP_SKB_CB(skb)->ip_dsfield);
 
 		tcp_init_wl(tp, TCP_SKB_CB(skb)->seq);
 		tcp_try_undo_spurious_syn(sk);
@@ -7531,6 +7582,8 @@ static void tcp_openreq_init(struct request_sock *req,
 	tcp_rsk(req)->snt_tsval_first = 0;
 	tcp_rsk(req)->last_oow_ack_time = 0;
 	tcp_rsk(req)->accecn_ok = 0;
+	tcp_rsk(req)->saw_accecn_opt = TCP_ACCECN_OPT_NOT_SEEN;
+	tcp_rsk(req)->accecn_fail_mode = 0;
 	tcp_rsk(req)->syn_ect_rcv = 0;
 	tcp_rsk(req)->syn_ect_snt = 0;
 	req->mss = rx_opt->mss_clamp;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index e0f2bd2cee9e..8bb4953fc8bd 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -501,6 +501,7 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
+		tp->saw_accecn_opt = treq->saw_accecn_opt;
 		tp->prev_ecnfield = treq->syn_ect_rcv;
 		tp->accecn_opt_demand = 1;
 		tcp_ecn_received_counters(sk, skb, skb->len - th->doff * 4);
@@ -555,6 +556,30 @@ static void smc_check_reset_syn_req(const struct tcp_sock *oldtp,
 #endif
 }
 
+u8 tcp_accecn_option_init(const struct sk_buff *skb, u8 opt_offset)
+{
+	unsigned char *ptr = skb_transport_header(skb) + opt_offset;
+	unsigned int optlen = ptr[1] - 2;
+
+	WARN_ON_ONCE(ptr[0] != TCPOPT_ACCECN0 && ptr[0] != TCPOPT_ACCECN1);
+	ptr += 2;
+
+	/* Detect option zeroing: an AccECN connection "MAY check that the
+	 * initial value of the EE0B field or the EE1B field is non-zero"
+	 */
+	if (optlen < TCPOLEN_ACCECN_PERFIELD)
+		return TCP_ACCECN_OPT_EMPTY_SEEN;
+	if (get_unaligned_be24(ptr) == 0)
+		return TCP_ACCECN_OPT_FAIL_SEEN;
+	if (optlen < TCPOLEN_ACCECN_PERFIELD * 3)
+		return TCP_ACCECN_OPT_COUNTER_SEEN;
+	ptr += TCPOLEN_ACCECN_PERFIELD * 2;
+	if (get_unaligned_be24(ptr) == 0)
+		return TCP_ACCECN_OPT_FAIL_SEEN;
+
+	return TCP_ACCECN_OPT_COUNTER_SEEN;
+}
+
 /* This is not only more efficient than what we used to do, it eliminates
  * a lot of code duplication between IPv4/IPv6 SYN recv processing. -DaveM
  *
@@ -716,6 +741,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	bool own_req;
 
 	tmp_opt.saw_tstamp = 0;
+	tmp_opt.accecn = 0;
 	if (th->doff > (sizeof(struct tcphdr)>>2)) {
 		tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0, NULL);
 
@@ -893,6 +919,18 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	if (!(flg & TCP_FLAG_ACK))
 		return NULL;
 
+	if (tcp_rsk(req)->accecn_ok && tmp_opt.accecn &&
+	    tcp_rsk(req)->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+		u8 saw_opt = tcp_accecn_option_init(skb, tmp_opt.accecn);
+
+		tcp_rsk(req)->saw_accecn_opt = saw_opt;
+		if (tcp_rsk(req)->saw_accecn_opt == TCP_ACCECN_OPT_FAIL_SEEN) {
+			u8 fail_mode = TCP_ACCECN_OPT_FAIL_RECV;
+
+			tcp_rsk(req)->accecn_fail_mode |= fail_mode;
+		}
+	}
+
 	/* For Fast Open no more processing is needed (sk is the
 	 * child socket).
 	 */
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index a76061dc4e5f..8e1535635aab 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1085,6 +1085,7 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
 	/* Simultaneous open SYN/ACK needs AccECN option but not SYN */
 	if (unlikely((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_ACK) &&
 		     tcp_ecn_mode_accecn(tp) &&
+		     inet_csk(sk)->icsk_retransmits < 2 &&
 		     sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
 		     remaining >= TCPOLEN_ACCECN_BASE)) {
 		u32 saving = tcp_synack_options_combine_saving(opts);
@@ -1174,7 +1175,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 	smc_set_option_cond(tcp_sk(sk), ireq, opts, &remaining);
 
 	if (treq->accecn_ok && sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
-	    remaining >= TCPOLEN_ACCECN_BASE) {
+	    req->num_timeout < 1 && remaining >= TCPOLEN_ACCECN_BASE) {
 		u32 saving = tcp_synack_options_combine_saving(opts);
 
 		opts->ecn_bytes = synack_ecn_bytes;
@@ -1252,7 +1253,9 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	}
 
 	if (tcp_ecn_mode_accecn(tp) &&
-	    sock_net(sk)->ipv4.sysctl_tcp_ecn_option) {
+	    sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
+	    tp->saw_accecn_opt &&
+	    !tcp_accecn_opt_fail_send(tp)) {
 		if (sock_net(sk)->ipv4.sysctl_tcp_ecn_option >= 2 ||
 		    tp->accecn_opt_demand ||
 		    tcp_accecn_option_beacon_check(sk)) {
-- 
2.34.1


