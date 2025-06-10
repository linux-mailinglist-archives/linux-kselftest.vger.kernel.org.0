Return-Path: <linux-kselftest+bounces-34574-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F58AD3856
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 15:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B419E5C49
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 13:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0484A2E62CC;
	Tue, 10 Jun 2025 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="HP91/HsO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013001.outbound.protection.outlook.com [40.107.162.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E832DFA25;
	Tue, 10 Jun 2025 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560027; cv=fail; b=l+siBTD/Y02JB+VAKxwR1JI5HRAil0aWIzXBRrBp40uAHV6dXfaO/oblplc3+ZHCuciTWFAG1qQKdlBVOqrMpwvoUxFCC/Sj+1fwSdasTAX5sJl/USg15ROYRT/8mH+vq9TbyaUcN0pTLhFvn/yZasFtHI7uJ8dkvHTo90FQ2Xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560027; c=relaxed/simple;
	bh=gmLYe0b2YNp9cI3CicjihJyTmGDPpFzt1b2VyMT/aWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NM3LJuYJEDXSY5FTYCS+KCMUyNSrgESm56REHEBl/X+nxZfBCCbkSiV+bSRdSanZrHlyFNLMysFWwOj8UwtR2VjmtGYXFnvltzyPYWCl+TI8YSYQzYC9SECj4qla2DaZVFB9ePyU13b0trt1AJVyumJmAp+945Q9k2IfAzVlCQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=HP91/HsO; arc=fail smtp.client-ip=40.107.162.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UyeuGNAFWZ5rkgGAZA+SBebHKUH3j1Ila94idNnZOA+lcZN1tuBitgZHVxn6XG9W2jWTIXm5pMOBVyRcaWpR2FoffGGwCL8D2xLxAtpmfUcyJP2TypY1Bg3yRZM2d0jAN6EmJ05h17kZXDLgxlnlfAnWY8OGrVY5GzXM0SR/seVLLY/BCTUgTGmeOF09v3BRj9qMaiP1whyd4X6roO1/ZTbHoCyLVPu1IUeeYbn0EgMkOg/VZgq2pu8AaHglWedK2ojd8Lpd+9YhMYjdTYcFeU04uBjB8MQUMCPrZCQT6rDhZuU0gq0hs+hyKX3VM+zuveAdOxd4WJ3vTJWXCm7QsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKHPVGJL+X90QJl4wXOruE6md0BKoovqRDlbLBM0cVQ=;
 b=TABd6lNi7pCG57ZcTvfdchtJFLNwn1h1tGI+hFpFbUKKMWonOZa0Vv36DgDCQkXUsqyExRgLU9AnnfggrE2zk+RqfsyRyNXhrz8vvU2QSPgK6gevqEX8cNLGuqBxbnjNo8lcUwV/d31MqCTB40+VgYraREGsyU5ta58UezkS+d1YjglIWDSpit64qxbWyIBOvSBllXt9cVDU5iaLcscWFCUX/pqAw3N4HgVX2Z2zha54ybvak+RP8jPUOc3zLy/xjR2ULZugB9xGHRZVyFNhcVkdmMrXPHJXHyKyfZD/mmcl7adppkxWlYpFwqNtvrrzR8sW8sY8724xwrMj1dRlwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKHPVGJL+X90QJl4wXOruE6md0BKoovqRDlbLBM0cVQ=;
 b=HP91/HsO4fr1bpwaoieqZBkLxqaa1uZ99Bp5UHpYFh0ZDybue6ga//6otXQyj+3qO8i8O7lOivx4626zqC0996pvUL3xH1BKc3qnRXDKFKZlOE5FYZHry5xyZ6DUAlUGdibKIZJyhdz5yjrqGHikOjhCFJEs4kvPR+vwmRb+ohYsuSwkIboloIfxWYL8XuWBjVkziZdjIxq4EI6/CkQBRAq99oYT5SHNv4w31XxHAJADT5UPpb3/LwEO5wjGrrit/kdNRV5Tu5ZtCKJIJmOgY/3k5gKpNhBDQFkiMbGjbKiLIhkCtISKeb/ZTxCJ2OljzaAWSSnh6Rx7gg8Ij0XZdw==
Received: from CWLP265CA0404.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b6::6)
 by AS8PR07MB7077.eurprd07.prod.outlook.com (2603:10a6:20b:259::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 12:53:38 +0000
Received: from AMS1EPF0000004C.eurprd04.prod.outlook.com
 (2603:10a6:400:1b6:cafe::19) by CWLP265CA0404.outlook.office365.com
 (2603:10a6:400:1b6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.17 via Frontend Transport; Tue,
 10 Jun 2025 12:53:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AMS1EPF0000004C.mail.protection.outlook.com (10.167.16.137) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Tue, 10 Jun 2025 12:53:38 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 02C0C2004A;
	Tue, 10 Jun 2025 15:53:36 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@amazon.com,
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
Subject: [PATCH v8 net-next 11/15] tcp: accecn: AccECN option failure handling
Date: Tue, 10 Jun 2025 14:53:10 +0200
Message-Id: <20250610125314.18557-12-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610125314.18557-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250610125314.18557-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004C:EE_|AS8PR07MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: d44c24a6-7208-4a7b-37a3-08dda81dd1e7
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?VVRJVGlkK3c1TUNybVpPbFgxTkk5OHo0YUlxQTJvMWFidUtuMjliREdDTzY3?=
 =?utf-8?B?SlhST3hNVHhNSituVzFjOC9nRHQwRCtrbXNVckJIemlLTHJuVU83eW0zdVJS?=
 =?utf-8?B?QUpkQWd4ZGxHOTVDTm5JSXJNcW0vTWVPRlloRzlOZXBDaExGa1BpbWsvMyty?=
 =?utf-8?B?bVF4cktBQ3NJK05mQzMrZWNaaXJuR2hndjYyRk9pS0pKSDl0cUllenMvQURO?=
 =?utf-8?B?MEpoQ21GajVQN2pudDlQU3pCaDVYOWlyeStkYXAwekF4bVpXZFpIZ0R6K0Ew?=
 =?utf-8?B?Q1A0K0hDb1ZzRkk3aWhocXNvQ1oyenJZL3BhVWpYL0ZkS0llalozR2tXejZh?=
 =?utf-8?B?OGpUMTRwcHhwaDNUbW5zTllUT0ZSdFdzREI3cDVEL3p1bHBBaVNvMU9TNmxT?=
 =?utf-8?B?NTk0Y1JtbXNxNGRDdGhxempWaCtrbytFYXJ6M2J5Qm1rVzNSSEM2MGdOTEZa?=
 =?utf-8?B?SUx0ODdhZjBUZnhTVk8xSWVENHJIOUxsWXBzMno0Uy9hMjZrSGZjVm9RNGs2?=
 =?utf-8?B?NW5sR094VXA5Q29zSk9ObXQ4bVN0eTkrYzlQZ2lyN3Q3bDUxc3F6L09nTFJY?=
 =?utf-8?B?ejhKcHk0VVpFT09KSkhVbXIyY3FZbkV2Ykt0ZGRzTFVkQWVMNmYrL211bEdH?=
 =?utf-8?B?Qm5YRFEvd2d4UWdWdTJyeitRRHVwNGhIYmZUR0I3U2pLdVU2emNUOEhjK3g4?=
 =?utf-8?B?MEpUd1hRZzRVOXpEOTdjS0ZuS212ZlpYSmpYaUNTWkJ1OTZTT0lQanhkNU9s?=
 =?utf-8?B?VjFuYkJRVEE1clZOYng5ZDdQVHFpdXpPbkFOcFpLYm9RTDI2N0ZvWHNRNjZP?=
 =?utf-8?B?d3B1NXF6L3FwNldNOTFLazh0cG5hNVUzK21DNU8vbWtEZzBOTWQvcUhYVFVm?=
 =?utf-8?B?cTFiaXp6bXV0cm5VYVUzRUR6OXFKM3QyT09jTnBWNTMvMklvZmVqY1lQUzBK?=
 =?utf-8?B?WTUrN0R3SGs1dDlrcW11WkdQMjZYWDNTakRIaUw4RUpjcEtjcEZBT1VRRTNX?=
 =?utf-8?B?eStyai9oU2p1VW9xL09QY25MUFlUWmNIam00L0RwS01YRmJJODkrcDEvY1pn?=
 =?utf-8?B?Zkl0d045aDQ4SHMvWW52WlRxUlBiNmg3dlo5OVI2U1Vub3pFQzViZzBUWGpL?=
 =?utf-8?B?RUFFREdNVDJRQXJWSzRlc1hpcWlmRW5LTVBFTUF3VkR3ZHFZNmFJbTFQZjNT?=
 =?utf-8?B?Q1EydkxTWTZLZFEvWjdHL2JCc2xUczZGemExUUFUTmw3VmNwWmdrblNhTklP?=
 =?utf-8?B?NzJnQnM3MFpEQTIwUnNkUitSdldROFBxRVFHSDQyemV1bDVwVVRUZnZ3S1ph?=
 =?utf-8?B?aU8zaUVyd05PSmdmV2NkNDFhelM1SUt6QWU3S2lhUi94T3dtaUk3dmIxTjVl?=
 =?utf-8?B?REZBQmlpR3BjS2twR0F2SmFWMTFMOFYxMzduWk9jWjIwM0JsM3RiWTRGY2tG?=
 =?utf-8?B?Mnp4NFRCUGg3ejNXQVVtUkswZlZBV0JKNnFsdEwxN2hyZER2VUxNbVdKekgr?=
 =?utf-8?B?blZZWld6WXYwRWpQWTZJOU8xUVBuYUI3aU12RURDMXVxYmRjTkhpRmdhNUNv?=
 =?utf-8?B?YXZIZ1hXSU1QcVJNZEVRZFUxSWNxeHVtNmYwWXZJMUVLUmlhVUw1R0hOcXBN?=
 =?utf-8?B?MmhleXZqQnhxSVFESk1UaHNjSzZXVlg4a0tjeW1pR3ZWTWZMZTZYWVIrTXEx?=
 =?utf-8?B?bXVFYXpKV3d0TFpjdjlvY3Bkbk9JeUNjU3pQTWxkYnVwcjIrYjcvUkdPUjVZ?=
 =?utf-8?B?MlhGaWdJNG9lWWI1NVpWRm53eHM4dllYMlg4NWc5U05uN1dFUTFISSs1cDZ0?=
 =?utf-8?B?RW04dGp5VERSUVZsWjBvQkhlTFFGZ2orR2k1OHM0VW84QVRPbEJLcW0rV21p?=
 =?utf-8?B?b0hES3NTUnV0Z1lvTVBYOXNwVnc1dWRQNmU3UXdabkhSZGNDTUFIL3p2ZkJr?=
 =?utf-8?B?cnhmSlhSMjFHMzFJWG1UWTBUYld4M0VWMmhNck9sNTZoeXpIeXVNTGRvV0du?=
 =?utf-8?B?ZHk3QlcyTHZIZU9SVCtNNUM1MVVYUGFmb2hVTG1Jc3lSNUVNcy9zS1NYcFhk?=
 =?utf-8?B?d0ZubDJKcXFMVjFRNFgzbENCRHFwSjlVaC9JQT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 12:53:38.4854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d44c24a6-7208-4a7b-37a3-08dda81dd1e7
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000004C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7077

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
v8:
- Add new helper function tcp_accecn_saw_opt_fail_recv()
---
 include/linux/tcp.h      |  4 ++-
 include/net/tcp.h        |  8 ++++++
 net/ipv4/tcp.c           |  1 +
 net/ipv4/tcp_input.c     | 55 +++++++++++++++++++++++++++++++++++-----
 net/ipv4/tcp_minisocks.c | 38 +++++++++++++++++++++++++++
 net/ipv4/tcp_output.c    |  5 +++-
 6 files changed, 103 insertions(+), 8 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 5d3743ef5d91..91d60fd4b229 100644
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
index 96cd8d99ff6f..a2c330afa883 100644
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
@@ -478,9 +484,11 @@ static inline int tcp_accecn_extract_syn_ect(u8 ace)
 }
 
 bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace, u8 sent_ect);
+void tcp_accecn_saw_opt_fail_recv(struct tcp_sock *tp, u8 saw_opt);
 void tcp_accecn_third_ack(struct sock *sk, const struct sk_buff *skb,
 			  u8 syn_ect_snt);
 void tcp_accecn_opt_demand_min(struct sock *sk, u8 opt_demand_min);
+u8 tcp_accecn_option_init(const struct sk_buff *skb, u8 opt_offset);
 void tcp_ecn_received_counters_payload(struct sock *sk,
 				       const struct sk_buff *skb);
 void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 2514eef12dcd..15286f6c6504 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3395,6 +3395,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->delivered_ce = 0;
 	tp->wait_third_ack = 0;
 	tp->accecn_fail_mode = 0;
+	tp->saw_accecn_opt = TCP_ACCECN_OPT_NOT_SEEN;
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 37c4c7995934..ffd9f462370c 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -445,10 +445,16 @@ bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace, u8 sent_ect)
 	return true;
 }
 
-/* See Table 2 of the AccECN draft */
+void tcp_accecn_saw_opt_fail_recv(struct tcp_sock *tp, u8 saw_opt)
+{
+	tp->saw_accecn_opt = saw_opt;
+	if (tp->saw_accecn_opt == TCP_ACCECN_OPT_FAIL_SEEN)
+		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_OPT_FAIL_RECV);
+}
 
-static void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
-			       u8 ip_dsfield)
+/* See Table 2 of the AccECN draft */
+static void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb,
+			       const struct tcphdr *th, u8 ip_dsfield)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	u8 ace = tcp_accecn_ace(th);
@@ -487,7 +493,13 @@ static void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
 	default:
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_rcv = ip_dsfield & INET_ECN_MASK;
-		tp->accecn_opt_demand = 2;
+		if (tp->rx_opt.accecn &&
+		    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+			u8 saw_opt = tcp_accecn_option_init(skb, tp->rx_opt.accecn);
+
+			tcp_accecn_saw_opt_fail_recv(tp, saw_opt);
+			tp->accecn_opt_demand = 2;
+		}
 		if (INET_ECN_is_ce(ip_dsfield) &&
 		    tcp_accecn_validate_syn_feedback(sk, ace,
 						     tp->syn_ect_snt)) {
@@ -603,7 +615,22 @@ static bool tcp_accecn_process_option(struct tcp_sock *tp,
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
+				u8 saw_opt = TCP_ACCECN_OPT_FAIL_SEEN;
+
+				tcp_accecn_saw_opt_fail_recv(tp, saw_opt);
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
@@ -6492,7 +6526,13 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	if (th->syn) {
 		if (tcp_ecn_mode_accecn(tp)) {
 			accecn_reflector = true;
-			tcp_accecn_opt_demand_min(sk, 1);
+			if (tp->rx_opt.accecn &&
+			    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+				u8 saw_opt = tcp_accecn_option_init(skb, tp->rx_opt.accecn);
+
+				tcp_accecn_saw_opt_fail_recv(tp, saw_opt);
+				tcp_accecn_opt_demand_min(sk, 1);
+			}
 		}
 		if (sk->sk_state == TCP_SYN_RECV && sk->sk_socket && th->ack &&
 		    TCP_SKB_CB(skb)->seq + 1 == TCP_SKB_CB(skb)->end_seq &&
@@ -6982,7 +7022,8 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		 */
 
 		if (tcp_ecn_mode_any(tp))
-			tcp_ecn_rcv_synack(sk, th, TCP_SKB_CB(skb)->ip_dsfield);
+			tcp_ecn_rcv_synack(sk, skb, th,
+					   TCP_SKB_CB(skb)->ip_dsfield);
 
 		tcp_init_wl(tp, TCP_SKB_CB(skb)->seq);
 		tcp_try_undo_spurious_syn(sk);
@@ -7557,6 +7598,8 @@ static void tcp_openreq_init(struct request_sock *req,
 	tcp_rsk(req)->snt_tsval_first = 0;
 	tcp_rsk(req)->last_oow_ack_time = 0;
 	tcp_rsk(req)->accecn_ok = 0;
+	tcp_rsk(req)->saw_accecn_opt = TCP_ACCECN_OPT_NOT_SEEN;
+	tcp_rsk(req)->accecn_fail_mode = 0;
 	tcp_rsk(req)->syn_ect_rcv = 0;
 	tcp_rsk(req)->syn_ect_snt = 0;
 	req->mss = rx_opt->mss_clamp;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 5b0f703f23a5..ddf2837eb4d1 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -500,6 +500,7 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
+		tp->saw_accecn_opt = treq->saw_accecn_opt;
 		tp->prev_ecnfield = treq->syn_ect_rcv;
 		tp->accecn_opt_demand = 1;
 		tcp_ecn_received_counters_payload(sk, skb);
@@ -554,6 +555,30 @@ static void smc_check_reset_syn_req(const struct tcp_sock *oldtp,
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
@@ -715,6 +740,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	bool own_req;
 
 	tmp_opt.saw_tstamp = 0;
+	tmp_opt.accecn = 0;
 	if (th->doff > (sizeof(struct tcphdr)>>2)) {
 		tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0, NULL);
 
@@ -892,6 +918,18 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
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
index 3de6641c776e..d7cdc6589a9c 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1087,6 +1087,7 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
 	/* Simultaneous open SYN/ACK needs AccECN option but not SYN */
 	if (unlikely((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_ACK) &&
 		     tcp_ecn_mode_accecn(tp) &&
+		     inet_csk(sk)->icsk_retransmits < 2 &&
 		     sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
 		     remaining >= TCPOLEN_ACCECN_BASE)) {
 		u32 saving = tcp_synack_options_combine_saving(opts);
@@ -1176,7 +1177,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 	smc_set_option_cond(tcp_sk(sk), ireq, opts, &remaining);
 
 	if (treq->accecn_ok && sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
-	    remaining >= TCPOLEN_ACCECN_BASE) {
+	    req->num_timeout < 1 && remaining >= TCPOLEN_ACCECN_BASE) {
 		u32 saving = tcp_synack_options_combine_saving(opts);
 
 		opts->ecn_bytes = synack_ecn_bytes;
@@ -1257,6 +1258,8 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 
 	if (tcp_ecn_mode_accecn(tp) &&
 	    sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
+	    tp->saw_accecn_opt &&
+	    !tcp_accecn_opt_fail_send(tp) &&
 	    (sock_net(sk)->ipv4.sysctl_tcp_ecn_option >= TCP_ECN_OPTION_FULL ||
 	     tp->accecn_opt_demand ||
 	     tcp_accecn_option_beacon_check(sk))) {
-- 
2.34.1


