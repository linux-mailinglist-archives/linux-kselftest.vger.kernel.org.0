Return-Path: <linux-kselftest+bounces-31090-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 437CBA92D86
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 01:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70A603B08BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 23:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A899221579;
	Thu, 17 Apr 2025 23:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="PaMEA6k/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7F82206B2;
	Thu, 17 Apr 2025 23:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744930864; cv=fail; b=i3yG//78ywE7iqS3m4vPTetR6jIAmkBnV4ahjF+WdQ6qkR5g5YvRSDQVrZktBYqjobQN+ri06Vjl05uQlnTTNSeGc0cUV2e1ppBdPjylzkul9MmvLKxhX0+Vi/NFFqBh2/0aS+57c9dAT5HzVJkRtxphRbzGxfOOa0Kv5Aay8Ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744930864; c=relaxed/simple;
	bh=g1x1wSE8mDsEEGPuXD/eGJRl+sR0RK7CBjRuw48/ZGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cRHcQH3yAToZJMQ6SI5VmiyAjjfT1IZjvvxu9eljodPjgzv5oEznpTVY0i3uqqgGwdjk++3v3SN2SbxBwiCurtclgSN1GIuz5vpbKWnUu+4yVQuZiN0X/b3BP9XWnhbPUwbGIwl+gSt9wO56+phwkw/gsKGBcni2GKvvxz+ZQ58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=PaMEA6k/; arc=fail smtp.client-ip=40.107.20.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xx4DV5D3RJHdIz1S4nPO4roeYPNH1JhYS+lPsbuAGfk7xCg2u3yi5/PBHptrZCoxRmnc1BxBjMHCKVAU7wb7RvlE7ey72oS3VxbmbfKqBriFgVoMYf3OU9GhHT4NTU9knJDJ6wmwo+ul7ajLQqxJvRGH7A96bIgpb43IQ+qLg8QYuq0saTg2kD0waO4vDO4hdILP+//ac3Ok6/abA1wblBLMJSh4bge+hI63Isp2bdivbO1Bm8EQA2imi3AuafoFOeHMXDBg0+cf9cq+U+Ws31AqUiUYvYvgK0faUtLm8+7fLox4IsXRD8t7iAdifMxtvp2fsnsVirQju+Wfru/kkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhuGs1hGnXUmt37E9qd1tbYti4EboLpVQ2TRoAXN87U=;
 b=k5Ry6c/ZnebpLXXW2tN1SFkKYtwezpAwalxr2DN446pepHLOHkn+0PmxlThY6VNpafHev3b2HcsEPSBi26mqAa4/i6YT0yg+BzwMQoocFqMslHLukhOWLi2BXxD/17SLmOdYiIIZa/skB8SVy74b235Fgg0uNQ4+/p5T5vMVnQTVsobJZnCxtI/L3WsfqYxr9d0Lzd8Ptgrr2QeNG1anTN4WWZ5TGn5lYTj81CPhFPmOb6DweoFWRkcA6VBEVpkDYeHCspzMhQJf/Jaq/aLrooDvEicfzLFsl9gtXRodkZWxCKb4y+mvq9SzOqqPdcA8dSRCAdgFlaMKRkGdD4EMjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhuGs1hGnXUmt37E9qd1tbYti4EboLpVQ2TRoAXN87U=;
 b=PaMEA6k/5FKuuckucqmtXWOGpfNKK2SOt2/M4KsLmqoK/Py8sID5KW1smBktoVVOk0/tlHaWa+FGQ+xXfpIippdsQHUHi2iS9sTKdcXcs7spwwtmv9gaUs3zHN5YTOt47z9115B2WPDYLkmRQXua1qv7AMdN+qgiN7hru8SDBbEcEKnaDdnIxg4MONdeidFG0WOMGSCgIDn/qdryaQHId5sezaQNMvxYiUjCyFisN6ADRqS+QAMdKjpL84cbb4lAA1DIqFAJLzfrZc708xl/+lGwQmrYknhd/JhUuuY/pmeY09jTdxdKYQR8E9W4ff6wYzxj1MjXghDdOPf0ll0mmQ==
Received: from DUZPR01CA0108.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::23) by DB9PR07MB7771.eurprd07.prod.outlook.com
 (2603:10a6:10:2a6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 23:00:56 +0000
Received: from DU6PEPF0000A7DD.eurprd02.prod.outlook.com
 (2603:10a6:10:4bb:cafe::7) by DUZPR01CA0108.outlook.office365.com
 (2603:10a6:10:4bb::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.23 via Frontend Transport; Thu,
 17 Apr 2025 23:01:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.29)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 DU6PEPF0000A7DD.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12 via
 Frontend Transport; Thu, 17 Apr 2025 23:00:56 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 2C39C20864;
	Fri, 18 Apr 2025 02:00:55 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: dsahern@kernel.org,
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
	horms@kernel.org,
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
Subject: [PATCH v4 net-next 05/15] tcp: accecn: add AccECN rx byte counters
Date: Fri, 18 Apr 2025 01:00:19 +0200
Message-Id: <20250417230029.21905-6-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417230029.21905-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250417230029.21905-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DD:EE_|DB9PR07MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: e869a4f6-cbd0-497a-2d45-08dd7e03b65f
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bzNMM3ZuemRYUVZGR3pBT2YrMjR4c216cXdkamhmQ3NrNFBSTlhOSzJBQ1BS?=
 =?utf-8?B?SFhzc0RHUGNDSHE4cEZGKzhnWmNSMkI0ZVRjMEEvbHBQR3B1ZVhrU3BoNXBO?=
 =?utf-8?B?WldXYm5vN0syd2tUQ1c4dXlvOFQrNFQ0NUszazd6ZkMza004emJNMXVQU1VY?=
 =?utf-8?B?Y3V5SmhQbXlGWXA0YzZSc3BtZEhpSW16aDF1cUhsZFVZd3g3eTVnSGNWK3JV?=
 =?utf-8?B?UTVkL29uMkN2TVdrZzRLT0pTczYyMkZGWmMvbUpFdm5ZaTVIZ2tEaU9XVFhU?=
 =?utf-8?B?YWNLVFRyNm1wK2ZpRko5MG9nUUxsYnpvb2YzSUtLNjdXcSt1dU9hcWg2ekZS?=
 =?utf-8?B?YUgyY3hTTGlLRHZwbS9NMFhIcGV0NlBhdFlJcDVRRjBya2E5UkFYbTlEK2g1?=
 =?utf-8?B?M1p2RGJzZkRsZXRYK1MvS1FhczkzVjQxQ0p5SmxKL0h2TGE5aHRTYXM0Tnc5?=
 =?utf-8?B?bXpETnFrc2VHVGFHQkN5eldudSttaDNCRHlRM0h1Q3h5eDlTSmh6S2NuQi8v?=
 =?utf-8?B?a1M5R2RSRW5mR3QwMjFjUnFncXRUOWo0U215cFNCR0FGa25BNnRxZm9zWGVT?=
 =?utf-8?B?TkNvdWxzQTc4WDI2T1gzQ2VXaEVYQysxUlNuUXRnT1NUUTFoYTN4Q0dXOHNU?=
 =?utf-8?B?Y3JGdldmZnYzYXZnY1IwUit4eHZtWktLWEk3WFNhQ2xoSG55OHlGcGRRUEFa?=
 =?utf-8?B?dkJOTTVqcXlEUDV6RlpBUUJZMFl5aDFYMVBXWDBXaVhVRk9peVhNaDU0VnVh?=
 =?utf-8?B?Z2M5NUFlZGFhcFhnd0h6a2NtMzVRaHF6UnN2NlBYTEhRRXJvc0xSWmFhK25Y?=
 =?utf-8?B?QUpEVlJ1S1dGeHhTT0RkVlVqMGhGQlRkT2FTWXBmSkJSbUp6ZHBxcmluaVpx?=
 =?utf-8?B?c1VyMjB1dzROYnRXS3U3WEh0RFNxakd2YTB5VVJKUXJVZzdqRUUvQUlUT0ww?=
 =?utf-8?B?M0RlS3hQS1NBQm0yR1crZXpITVZyQ3FickM0c2t1Sm5tbHh2UWE0dS9ZUlZI?=
 =?utf-8?B?YUFaOXpjS1dyOXVqZEE4dEJZaXhKNVhtQm8wak4vTUVEWmIxclZ4MnhnRDZZ?=
 =?utf-8?B?bWRwbEJ2WXhIY2NPZXZieFRaeVBBMWxORTdYdEhiNUV1azVxaHRpRUlVQmpu?=
 =?utf-8?B?TFU3MjJCL2F2Sm5HM09nWnZ0WkpydXVvLzVkMnJxSWdiS3BGcVZPOWdQZUx3?=
 =?utf-8?B?ZXhWVHNGSWRUQUdHem1uNTV5OWNUNW1RNEhDblFuOEZFQzc3Zmh0WE91MFlw?=
 =?utf-8?B?TW1oTjJjdlF6cUJXWHlTaEtacTZsVWFxWDlORlJVYXkwMU95eFRuNmUrZERj?=
 =?utf-8?B?RUlSWXdWeWc1WFlvaS9tRTlhMUNxRVRqenVXblZmZ0dDZEZpVXovTXM4Wm5W?=
 =?utf-8?B?MklBOE9Bc3lYbnVjV1VlR3FsbVd3YWEySTJ0NFQyZllPVUhUTmY0REhaNDhl?=
 =?utf-8?B?cm5xQzZ4SU5uVkF0K3lhUHVva3B3Yms0azRTWUNPQkd2Q2g3UjI5N3E0SSs5?=
 =?utf-8?B?bFVxYWVaekJSc0JjZ2F6cThGRnlUL0JLTGVCWUczbnREd0I5NFpQOENuM1M5?=
 =?utf-8?B?akUrbWxackhaMXVQaWU5RVJObTZlRmExWU5LUDhUTUJXa2NpZXNyRlE0YXZN?=
 =?utf-8?B?VlcvQ1NvWW9sTTR0SlEwTFdzUjcyRjE2VHpVWXJHQlpIZzA1WjYxY3NYelI4?=
 =?utf-8?B?UEFwb3RPSlVlbFhrQmd5UEFGU2UzN3FtRjU5TGo2SWlRaGdOYlFkMjBSeEQ5?=
 =?utf-8?B?TGx0eHdrWnRVRzZ2NllVcmhNNC9CcnZYYVBSR0lteGRhS2YxVFlBeU1OUkhF?=
 =?utf-8?B?b3VxdFUyYzgzcldweTR0WDdFVVpyNkliV25yY0JJZkNHM3VabFBVblZsWGRL?=
 =?utf-8?B?UUhscHk3Z3JGNkVJU1BSZ0JYNlpDMXBEZnFtK1FTT1BYalQzUkQwUVhDNnBu?=
 =?utf-8?B?L2l6UnFtNWJRa0ovZ2JzUGVUeldxako2eDZXbTFqREdoOUhxeFdQVlpOU3Y3?=
 =?utf-8?B?anZLQWNUcjJMQmZSMnFCNVZvL25DMmphODNSWUdmTzNaZ2lkUjBZeGxVL0U1?=
 =?utf-8?B?MENoaFNRNmZ3OUtNSytweDFuajJYVkNGMExzdz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 23:00:56.5515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e869a4f6-cbd0-497a-2d45-08dd7e03b65f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7771

From: Ilpo Järvinen <ij@kernel.org>

These counters track IP ECN field payload byte sums for all
arriving (acceptable) packets. The AccECN option (added by
a later patch in the series) echoes these counters back to
sender side.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/tcp.h      |  1 +
 include/net/tcp.h        | 18 +++++++++++++++++-
 net/ipv4/tcp.c           |  3 ++-
 net/ipv4/tcp_input.c     | 13 +++++++++----
 net/ipv4/tcp_minisocks.c |  3 ++-
 5 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index af38fff24aa4..9cbfefd693e3 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -303,6 +303,7 @@ struct tcp_sock {
 	u32	delivered;	/* Total data packets delivered incl. rexmits */
 	u32	delivered_ce;	/* Like the above but only ECE marked packets */
 	u32	received_ce;	/* Like the above but for rcvd CE marked pkts */
+	u32	received_ecn_bytes[3];
 	u8	received_ce_pending:4, /* Not yet transmit cnt of received_ce */
 		unused2:4;
 	u32	app_limited;	/* limited until "delivered" reaches this val */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index f36a1a3d538f..6ffa4ae085db 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -467,7 +467,8 @@ static inline int tcp_accecn_extract_syn_ect(u8 ace)
 bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace, u8 sent_ect);
 void tcp_accecn_third_ack(struct sock *sk, const struct sk_buff *skb,
 			  u8 syn_ect_snt);
-void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb);
+void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
+			       u32 payload_len);
 
 enum tcp_tw_status {
 	TCP_TW_SUCCESS = 0,
@@ -1035,11 +1036,26 @@ static inline u32 tcp_rsk_tsval(const struct tcp_request_sock *treq)
  * See draft-ietf-tcpm-accurate-ecn for the latest values.
  */
 #define TCP_ACCECN_CEP_INIT_OFFSET 5
+#define TCP_ACCECN_E1B_INIT_OFFSET 1
+#define TCP_ACCECN_E0B_INIT_OFFSET 1
+#define TCP_ACCECN_CEB_INIT_OFFSET 0
+
+static inline void __tcp_accecn_init_bytes_counters(int *counter_array)
+{
+	BUILD_BUG_ON(INET_ECN_ECT_1 != 0x1);
+	BUILD_BUG_ON(INET_ECN_ECT_0 != 0x2);
+	BUILD_BUG_ON(INET_ECN_CE != 0x3);
+
+	counter_array[INET_ECN_ECT_1 - 1] = 0;
+	counter_array[INET_ECN_ECT_0 - 1] = 0;
+	counter_array[INET_ECN_CE - 1] = 0;
+}
 
 static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 {
 	tp->received_ce = 0;
 	tp->received_ce_pending = 0;
+	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
 }
 
 /* State flags for sacked in struct tcp_skb_cb */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 73f8cc715bff..1e21bdf43f23 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5092,6 +5092,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
@@ -5099,7 +5100,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 97 + 7);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 109 + 7);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index cc34664805f8..c017e342f092 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6106,7 +6106,8 @@ static void tcp_urg(struct sock *sk, struct sk_buff *skb, const struct tcphdr *t
 }
 
 /* Updates Accurate ECN received counters from the received IP ECN field */
-void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb)
+void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
+			       u32 payload_len)
 {
 	u8 ecnfield = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
 	u8 is_ce = INET_ECN_is_ce(ecnfield);
@@ -6121,6 +6122,9 @@ void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb)
 		tp->received_ce += pcount;
 		tp->received_ce_pending = min(tp->received_ce_pending + pcount,
 					      0xfU);
+
+		if (payload_len > 0)
+			tp->received_ecn_bytes[ecnfield - 1] += payload_len;
 	}
 }
 
@@ -6398,7 +6402,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 					flag |= __tcp_replace_ts_recent(tp,
 									delta);
 
-				tcp_ecn_received_counters(sk, skb);
+				tcp_ecn_received_counters(sk, skb, 0);
 
 				/* We know that such packets are checksummed
 				 * on entry.
@@ -6444,7 +6448,8 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			/* Bulk data transfer: receiver */
 			tcp_cleanup_skb(skb);
 			__skb_pull(skb, tcp_header_len);
-			tcp_ecn_received_counters(sk, skb);
+			tcp_ecn_received_counters(sk, skb,
+						  len - tcp_header_len);
 			eaten = tcp_queue_rcv(sk, skb, &fragstolen);
 
 			tcp_event_data_recv(sk, skb);
@@ -6491,7 +6496,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			tcp_accecn_third_ack(sk, skb, tp->syn_ect_snt);
 		tcp_fast_path_on(tp);
 	}
-	tcp_ecn_received_counters(sk, skb);
+	tcp_ecn_received_counters(sk, skb, len - th->doff * 4);
 
 	reason = tcp_ack(sk, skb, FLAG_SLOWPATH | FLAG_UPDATE_TS_RECENT);
 	if ((int)reason < 0) {
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 779a206a5ca6..3f8225bae49f 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -497,10 +497,11 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 	struct tcp_sock *tp = tcp_sk(sk);
 
 	if (treq->accecn_ok) {
+		const struct tcphdr *th = (const struct tcphdr *)skb->data;
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
-		tcp_ecn_received_counters(sk, skb);
+		tcp_ecn_received_counters(sk, skb, skb->len - th->doff * 4);
 	} else {
 		tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
 				     TCP_ECN_MODE_RFC3168 :
-- 
2.34.1


