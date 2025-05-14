Return-Path: <linux-kselftest+bounces-32946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B78BFAB6DAF
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 16:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1408D1897CFA
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 13:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F01283CB3;
	Wed, 14 May 2025 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Z/Uev7mf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EC027BF79;
	Wed, 14 May 2025 13:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747231040; cv=fail; b=e63S9qu91lAKTaxcC0znV/8ajXqmb9+SR94/zclnEvvIqvSDaSNGb99hvsQxW/Ep1OfehbcWcMBXkzYO6lDkgd1fj8D6py7InFgPGM9aXhpO/G1uLJO5gJfR0LaIcDOh+XQqXmIQVkfbtO1sW5w+BRvKG1GL7D+3FVBKeXAWFBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747231040; c=relaxed/simple;
	bh=0r1CyKz5KSin9T9qo6Ak4seT6Mkopec6tQMzE6n0elo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uj9wzGrHe74dB+c9mb2r0wVwZmmJ/6wXEmfse2pHnu2L5J1iUBS2FMEBxoP6YNNsjnIVArLEu+yiT3jGPXwIvzplNIoYId+znXREAdt/1YsZqyUKg/x2Pbj5WEl6DZYQ+fkPzbAZyCBuTZow9A7wONljR2FMZo44zr58OMD2xAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Z/Uev7mf; arc=fail smtp.client-ip=40.107.20.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oejcq4IJHZMe1jwz2QdURPa0+5iVQd7qhBr41LWOGexjyDZcF1eQrqV8Dv1lwiqpV/OEEOV6AJZNeEookcfgBdPEDAARxkpaVd4m7EYuDDoOWnxP69OGOxdtWRRhTLPNJ24PNPbXXiuRLJ1VbQaUEERbS4CCdOJrwxc6aHnaV8voHlJSwi/Fakuaenq7mbhK4fKfqNLhOn06ZFIbbWglqSGXOUJt01LvD+nsgu9aEsBA/EQsartI6uq7jiNGBF7Myu66iC7rGUGReh1D80AyYIoqiGNbB2PFGB8ir0+smxIMLiE3qOR4xNEZLGVrFF5w2q8rWuHNPtVjIhzSNDVaFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPXU4zsCBb7Tb8Nin42fMi9aKmm8EBDRpMt9BOPaT/w=;
 b=qmVkalKXbqYfGXH4gz0NEYhnX+5DSNZUtPQkeHR6nh9+ChryXExnpaXiEzRruIhT5Zj8i2cELlQ0hbclQAf2Tj3wsNHaMF59zRdaKnIRu30Dsb4BY7M0Izy1dznZxeic/EcTF/tslqlmYzNF9R4KASf4os6+hyi10vVX5ikXzjtZQdQbNerDvg+ZcpToH3rFfhP1utZdvgGtrqTTyZNLC9gZRRVCzhIKMNd7GQsGtsR6V7NOdqWgnLlv/6lTiY5hV9/9Qh3LpKjYImnbyLcZY1PuuUZ5+0TvX82bvVfmiIEZm5WTwewJmm0p1e4NMgS3gviv/yfYVyJWiC2cdYJDsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPXU4zsCBb7Tb8Nin42fMi9aKmm8EBDRpMt9BOPaT/w=;
 b=Z/Uev7mfbx5ONA/+0DQtXEO8HW8g+8mWCEKeSW0Pw1WfsBRUxfab4+I4QuNUbobg5w52xVjUuh06326heFdsD7UoTfv7MBbF6AdZCIgXmExGAV9tZRwJ3ra7+RIgLTpwPsSGkU4OUan6ScZ3Fs2t3VxiqCnjr62JnOykJjTEs63lTO6DO/oChY6d3BJXbLa7TiZ5t+kEf/RkW/3plKKzOepd/huYdxKPuWX4YK8FS4BMhXDPhZlJ4yYGG7ov1MipD3DRXBCcG7g2EBhrP6TrfiFF67Vm+bugaLU9qigPtMJ3YbWVS9nzmHvpJ10t9fhjdyfFQbUql/CiQ4US5Dih9Q==
Received: from DB7PR03CA0092.eurprd03.prod.outlook.com (2603:10a6:10:72::33)
 by AM7PR07MB6772.eurprd07.prod.outlook.com (2603:10a6:20b:1bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Wed, 14 May
 2025 13:57:11 +0000
Received: from DB5PEPF00014B92.eurprd02.prod.outlook.com
 (2603:10a6:10:72:cafe::48) by DB7PR03CA0092.outlook.office365.com
 (2603:10a6:10:72::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.28 via Frontend Transport; Wed,
 14 May 2025 13:57:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB5PEPF00014B92.mail.protection.outlook.com (10.167.8.230) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Wed, 14 May 2025 13:57:10 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 4C86020094;
	Wed, 14 May 2025 16:57:09 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
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
Subject: [PATCH v7 net-next 11/15] tcp: accecn: AccECN option failure handling
Date: Wed, 14 May 2025 15:56:38 +0200
Message-Id: <20250514135642.11203-12-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B92:EE_|AM7PR07MB6772:EE_
X-MS-Office365-Filtering-Correlation-Id: a3c196aa-a11b-4545-4bda-08dd92ef3912
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cUhDN3RubzFCdDdITHRLMVdJcHhERWp5a1UrQUtRRGU0YWlBM2hkc2gvcGI2?=
 =?utf-8?B?WHF4NVVCRit5OFo4NEtQYVVQMHB5WFk4MHUyUFVscWZMU0hVRitpK3Y1OUxW?=
 =?utf-8?B?MG9mL0l1Wms2S1FZbE1rM2Q0ZjVZQzQxQmFtL2VqSG4yRmdmcWFBSEkrUUpy?=
 =?utf-8?B?VmRheXl5cVlacjhvNGFHTktkSVp6R1ptMHFTR0pIRnh1MDlSU2M0N2U5L2Fs?=
 =?utf-8?B?eXpkYzVGM0JSZm5OZkp5OWZ4aVVyVkxzUzBUNENDRjBpT09RMERUV09maEkw?=
 =?utf-8?B?KzFRbERPYjdadzhuYjBoWituRkJVTEU2UmZYK3pnd0ZGSEJZM05jNW94S3Bs?=
 =?utf-8?B?M3F0Vk50MGFzb0FpSFBwK1E1am0rVGlIQ1FQQ1gxcGo4QVdZdG92OUIrQWdp?=
 =?utf-8?B?dVVHaUdmaytjbFlqeW5SYkFKdlFyaWNYZi9EMDA5SVBRRW5aWno3c3V6TTdw?=
 =?utf-8?B?Z1F6Q3hNc1ZSNTJZaHpKY1NoWmRHTzFONnMzZmYvU2JIK2FvUjlvSytBMTI5?=
 =?utf-8?B?QlNsbWVDSitUdkdUYkZrVlhQK081Qk01K1lobndlK2NZaWlNM3JsYWV2dDZZ?=
 =?utf-8?B?cUsrdC93ZERTaThIRGZoRFJ1eXZMVkJrNm5ob2FOekgyVHlFUlQ0TDdHYlox?=
 =?utf-8?B?cFdMMkJvQ2NJUmN2RG1EVG1CMDJiMm5hdVdnakdDcithTHlBTEhuTHVoOHhj?=
 =?utf-8?B?V2pPZE4zRVhycU9ONEVVVkdPTVJUc0t1OGhNeTdRYWdZMzhoRGZzTWpkd1Rs?=
 =?utf-8?B?OWQ0anFiTkhhNU42UGZ6R1BIci81VHBjeFFBaXBvT2dYc2paQThPRHhQWSt5?=
 =?utf-8?B?cHo0aGM5YlhrTUxkNmN3YzQ1N1gyWG5ZbFUzc05TaFdhdlErSFBMYXZ3MWRx?=
 =?utf-8?B?am9ZMFZzcUhQUnpnV25nenZLM01lbnpUOTQzMGhwUndMOXZhYmNVeHFzWmVt?=
 =?utf-8?B?b0lSVXoyandicHpndUxnM2ZXa1RpUUVNaVVFQW9oRDJ4VUx2RWpVR2NPeTUz?=
 =?utf-8?B?M2NkeDVUSTZ1VjB2a1ZmMm5jN05rWXlMQ1k4b1hsUnV3RjV5VldmWE1GTkQ3?=
 =?utf-8?B?MTNjdjJTOUg1SUxDaHRlS2g3UU94N09yR21neC9ub3I5eW9xaStBTWtnVmo4?=
 =?utf-8?B?UUR3Uk9FYnRlaTZnbHdkczR6NjgrYjY2TExrbHpMZnMrQmJHMXZwcjNVblBY?=
 =?utf-8?B?ZUNnQmRaTzhIc1FCa0Q1S1BOL1pHV0RvQ2syelZlVUdFcmNDK2RrVm9lc1Mz?=
 =?utf-8?B?SVA3QTFYYThHVVQyOFRYd1FQN2U4RkowUndUa0hsM1dlb1ZiUU56YzV0VjY3?=
 =?utf-8?B?cGVrQ1RFZjBOeW1HMURMaXFqN1VhNTA0eFZxQWZnOGVZT25yS0JrbitJTVlv?=
 =?utf-8?B?Nmk2Z09RNkdvZnhuTUZuMlVLWElEaFJxSW8ySVhEK29ybWFLQmZaejZWU0d3?=
 =?utf-8?B?NEcxY0cvTXRlWkdESnBUMTZRTFBYTFVFOXJpZXBPTzJIZGpha0VvaUZPeDZZ?=
 =?utf-8?B?R0drY1J3UzRubHNNQXpJWVZ0N1VoZFFCZWxTZWRlM2lMODFPTVRlV085anY4?=
 =?utf-8?B?dDhBN2dwQlh3a3M1VjRaR1BkaUNaZXZuNmNvQWQwRVhLT3JtVkhlWXd0MlpS?=
 =?utf-8?B?ZkFZc0NWdWVGbXJUZUYxWDBQeEViMG9IWUtnNEZpK2VWb1YxYU84T05IRjNR?=
 =?utf-8?B?V28yMXI5RnNzYlhxeDhOWm1uL1VPVjJWTE56dGx1MGw2Z3IxOExna0RsVndG?=
 =?utf-8?B?YWNKQW9hUTV3VkRERk5MMkIzNEZzdzJHZDJTc2gyRVc1UlhwbmhxR2F5Q2lB?=
 =?utf-8?B?cFNvRzBSM2NiZVp5ak9TR0cvM2dlYjhMMmVtLzlKZ0VMNjU1WkI2ODAyTlQ1?=
 =?utf-8?B?aTFuL2FVTlA5SnRUUTRneGJlS0g1WmJYWFNNZ3hXRmZoWXRlUXFYWGpVOExO?=
 =?utf-8?B?OEtkeTJtWTYyaTV1SXNjM296WCtZY0h5S3l2VzV3WGxvRkNlVzR3VGxTUG1M?=
 =?utf-8?B?WWxsa3JhVlBoZDVyTGtDbnJ0WGtuODRZNVh2bHJjNGRaWXB0K2trUGpWZmxT?=
 =?utf-8?B?cysvc2hxRjVsLzRGa2Qxd2x2WjRIdit3ZEZiUT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:57:10.8021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c196aa-a11b-4545-4bda-08dd92ef3912
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B92.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6772

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

AccECN option may fail in various way, handle these:
- Remove option from SYN/ACK rexmits to handle blackholes
- If no option arrives in SYN/ACK, assume Option is not usable
        - If an option arrives later, re-enabled
- If option is zeroed, disable AccECN option processing

This patch use existing padding bits in tcp_request_sock and
holes in tcp_sock without increasing the size.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/tcp.h      |  4 ++-
 include/net/tcp.h        |  7 +++++
 net/ipv4/tcp.c           |  1 +
 net/ipv4/tcp_input.c     | 68 +++++++++++++++++++++++++++++++++++-----
 net/ipv4/tcp_minisocks.c | 38 ++++++++++++++++++++++
 net/ipv4/tcp_output.c    |  5 ++-
 6 files changed, 113 insertions(+), 10 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 0740efaaef28..b5066eef8782 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -173,6 +173,7 @@ struct tcp_request_sock {
 	u8				syn_ect_snt: 2,
 					syn_ect_rcv: 2,
 					accecn_fail_mode:4;
+	u8				saw_accecn_opt  :2;
 #ifdef CONFIG_TCP_AO
 	u8				ao_keyid;
 	u8				ao_rcv_next;
@@ -409,7 +410,8 @@ struct tcp_sock {
 		syn_fastopen_child:1; /* created TFO passive child socket */
 
 	u8	keepalive_probes; /* num of allowed keep alive probes	*/
-	u8	accecn_fail_mode:4;	/* AccECN failure handling */
+	u8	accecn_fail_mode:4,	/* AccECN failure handling */
+		saw_accecn_opt:2;	/* An AccECN option was seen */
 	u32	tcp_tx_delay;	/* delay (in usec) added to TX packets */
 
 /* RTT measurement */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 3419618a7891..5e4593e39de4 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -279,6 +279,12 @@ static inline void tcp_accecn_fail_mode_set(struct tcp_sock *tp, u8 mode)
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
@@ -480,6 +486,7 @@ static inline int tcp_accecn_extract_syn_ect(u8 ace)
 bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace, u8 sent_ect);
 void tcp_accecn_third_ack(struct sock *sk, const struct sk_buff *skb,
 			  u8 syn_ect_snt);
+u8 tcp_accecn_option_init(const struct sk_buff *skb, u8 opt_offset);
 void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
 			       u32 payload_len);
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 20a2e30e15f3..e68b9706eeff 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3399,6 +3399,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->delivered_ce = 0;
 	tp->wait_third_ack = 0;
 	tp->accecn_fail_mode = 0;
+	tp->saw_accecn_opt = TCP_ACCECN_OPT_NOT_SEEN;
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 10c37a41b9a5..c93e4bffb23e 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -446,9 +446,8 @@ bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace, u8 sent_ect)
 }
 
 /* See Table 2 of the AccECN draft */
-
-static void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
-			       u8 ip_dsfield)
+static void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb,
+			       const struct tcphdr *th, u8 ip_dsfield)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	u8 ace = tcp_accecn_ace(th);
@@ -487,7 +486,19 @@ static void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
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
@@ -603,7 +614,23 @@ static bool tcp_accecn_process_option(struct tcp_sock *tp,
 	unsigned int i;
 	u8 *ptr;
 
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
 
@@ -619,6 +646,13 @@ static bool tcp_accecn_process_option(struct tcp_sock *tp,
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
 		if (optlen < TCPOLEN_ACCECN_PERFIELD)
@@ -6481,10 +6515,25 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	 */
 	if (th->syn) {
 		if (tcp_ecn_mode_accecn(tp)) {
-			u8 opt_demand = max_t(u8, 1, tp->accecn_opt_demand);
-
 			accecn_reflector = true;
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
@@ -6974,7 +7023,8 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		 */
 
 		if (tcp_ecn_mode_any(tp))
-			tcp_ecn_rcv_synack(sk, th, TCP_SKB_CB(skb)->ip_dsfield);
+			tcp_ecn_rcv_synack(sk, skb, th,
+					   TCP_SKB_CB(skb)->ip_dsfield);
 
 		tcp_init_wl(tp, TCP_SKB_CB(skb)->seq);
 		tcp_try_undo_spurious_syn(sk);
@@ -7549,6 +7599,8 @@ static void tcp_openreq_init(struct request_sock *req,
 	tcp_rsk(req)->snt_tsval_first = 0;
 	tcp_rsk(req)->last_oow_ack_time = 0;
 	tcp_rsk(req)->accecn_ok = 0;
+	tcp_rsk(req)->saw_accecn_opt = TCP_ACCECN_OPT_NOT_SEEN;
+	tcp_rsk(req)->accecn_fail_mode = 0;
 	tcp_rsk(req)->syn_ect_rcv = 0;
 	tcp_rsk(req)->syn_ect_snt = 0;
 	req->mss = rx_opt->mss_clamp;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index e0f2bd2cee9e..87b03ee74676 100644
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
+	u8 *ptr = skb_transport_header(skb) + opt_offset;
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
index ea37a30ff71c..b630923c4cef 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1086,6 +1086,7 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
 	/* Simultaneous open SYN/ACK needs AccECN option but not SYN */
 	if (unlikely((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_ACK) &&
 		     tcp_ecn_mode_accecn(tp) &&
+		     inet_csk(sk)->icsk_retransmits < 2 &&
 		     sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
 		     remaining >= TCPOLEN_ACCECN_BASE)) {
 		u32 saving = tcp_synack_options_combine_saving(opts);
@@ -1175,7 +1176,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 	smc_set_option_cond(tcp_sk(sk), ireq, opts, &remaining);
 
 	if (treq->accecn_ok && sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
-	    remaining >= TCPOLEN_ACCECN_BASE) {
+	    req->num_timeout < 1 && remaining >= TCPOLEN_ACCECN_BASE) {
 		u32 saving = tcp_synack_options_combine_saving(opts);
 
 		opts->ecn_bytes = synack_ecn_bytes;
@@ -1254,6 +1255,8 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 
 	if (tcp_ecn_mode_accecn(tp) &&
 	    sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
+	    tp->saw_accecn_opt &&
+	    !tcp_accecn_opt_fail_send(tp) &&
 	    (sock_net(sk)->ipv4.sysctl_tcp_ecn_option >= TCP_ECN_OPTION_FULL ||
 	     tp->accecn_opt_demand ||
 	     tcp_accecn_option_beacon_check(sk))) {
-- 
2.34.1


