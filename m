Return-Path: <linux-kselftest+bounces-30696-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9201EA88168
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 15:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A67987A9A2E
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 13:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAC12E3373;
	Mon, 14 Apr 2025 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="NZ7WH6t4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFD42E336F;
	Mon, 14 Apr 2025 13:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636461; cv=fail; b=JmWuyfD8uFfXDANElthp6RCmOE0ZPH8wdZ9aH8hqYWRjFNzozmeGMSwuM/UdZT46ciZsvMSH33Dw5B6zzvC8dXU3rilkOlTjLPpv4Wq1cDr9NjmJzxdXdXrBiGMVIZdbR4otl8+qE6w1skcdTeck7DgtSvNq5zD+AJFwApLLaeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636461; c=relaxed/simple;
	bh=KD7/NR3z7EZK3pNxTn5FeoJCQ5ELLAzCb70Q6PtqoD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BmKuRiaAkyzssAW8UIEYNtygoqr7mNFu3sU74gKkw7w6e0XG2KukfZ/1/B4uGXH3GZNCgNt2nnsELGxlBmunX69lA26kUNkVulXBKdJgL9EKJDpJYieH0Ls96LmQCoi8c7nMVVkeF3STltfIrNcvODJtpWHpB52tejDvT7r2QkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=NZ7WH6t4; arc=fail smtp.client-ip=40.107.21.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2S65I9Bm+Dhb1cFbc8HW5oJliDTlnLbVH5hkmgk+dGtZHaxhsc8fxE81c008ofwkzNKOMfws0xMRXgRkLYjGl87Ac6Pd7x8tNZqTSSCubOR37aX9FA42wTOomdb69mQ4lYJwXw/OHZHRPbaLqZjB/toeClStwkj432QlCwOZ9qb5vKRg6S8eX4prlonts9ZoR25BxCeVO2czOs5z8BbJNxgu/nIIeYXH3OOFNV3UL24lrA2dyV5k1I+8ZeF+dIQyul2rfFR9YEbo2zSEl9Uv9A899uyiLGG4AUUyaFUnwe+bXJCaKBuyhkcBNV6yJuNec/2Kv2Ed2c2pKpRVKyNwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgX0CwSPtzsPeTZbfIpkANOIMszxeyMZ4gue9xFsyEQ=;
 b=UInLOSD+cjl/3YGlal3ikmW4QMzaQWZwcqyk9eioNLpe4IeFHetd/L/y69yg8RpuRP0g+d3KYViG8V9nCcfZQFTUDa7Sn2BqPnbEF1B+uZT7xMdwT/mpD4otAGJDRZEA0fINme2sQCsvwNquRaz23SVfRw7ZqJEHBSgb6fqJ3QI0mcYtY7z/1cC7pOnRg9RJU2UdHPK0mWzNkSg/p2JFlXM+tSKhhHbBub9z2B66Otne3GCe9hLvDGaN3RVARJ8tF7pw4f7SUTgAAYkxqkriDLkkBbrtRvazP2+epLk2b+iXxt+GveFhQTSBq6TEmPH6LEoj9jl/j2e1uTWtukHxuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgX0CwSPtzsPeTZbfIpkANOIMszxeyMZ4gue9xFsyEQ=;
 b=NZ7WH6t4FZckcG3UtC7kQdMp+o/0+9P/8VIlTE/zzopmG4kX7tipL/Z6CrZLHIBoVsawJFFKj13VOGyMt6hE+th+/AswAXeAc6mQMY5iBtYy2hgxaPL87xR4Gkc1DjyzUqjMM+k2assL7JTrBkHs+E4zjHeLIPY7XoCGbyz701utGP0X6ycPlWFfVQCz4/Ly2rIhsgIMciii3XQ+4d7nn4G/aL5zheJ3EmOv+opdD0lIuhJp23BkI2LXJqokY9I2wGeGJMEddzwPqHMRE2jt76HUMpZLvFwOhQkaVkMwLT7nyldUwpcpLUQxEDD6n3HirDSQ7nvK6LE3aZSvM2JWqg==
Received: from AS4P189CA0043.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5dd::19)
 by AS5PR07MB9840.eurprd07.prod.outlook.com (2603:10a6:20b:682::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 13:14:15 +0000
Received: from AM3PEPF0000A792.eurprd04.prod.outlook.com
 (2603:10a6:20b:5dd:cafe::1d) by AS4P189CA0043.outlook.office365.com
 (2603:10a6:20b:5dd::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Mon,
 14 Apr 2025 13:14:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM3PEPF0000A792.mail.protection.outlook.com (10.167.16.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 13:14:15 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 53EDDQBM009623;
	Mon, 14 Apr 2025 13:14:13 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
        jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, horms@kernel.org, andrew+netdev@lunn.ch,
        donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v3 net-next 11/15] tcp: accecn: AccECN option failure handling
Date: Mon, 14 Apr 2025 15:13:11 +0200
Message-Id: <20250414131315.97456-12-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414131315.97456-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250414131315.97456-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A792:EE_|AS5PR07MB9840:EE_
X-MS-Office365-Filtering-Correlation-Id: 305e4e65-bf82-471f-dfea-08dd7b56416e
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?dzB6MHBYcFNEZ2tJakRhTXRKS0F6NlFscFc1aHJFdGRTZDd2dWhlam1EeGpS?=
 =?utf-8?B?c0lHaWdtSVAzZUNEVkVoZHVjamxBOGRTVDI1MFk5QzdmZDFOZXdNNzhieUVV?=
 =?utf-8?B?SmwyTWJLWUt4YzFSQnVBYWpWQldlY3l3QnpXbHkwbnRCTkpZTHN6SDMxdldF?=
 =?utf-8?B?bFNBNHJ0dUhzME9ObXp1bFFuWFFuOTFrbEVjVzJLSkpvVmNGSHV3NDhBVGpW?=
 =?utf-8?B?RWNSMXN0UXh5UDUwUCsyMVFITkJFWnpacFdUV1pjOTNKbisvUUs1a29HLzlM?=
 =?utf-8?B?cHVVUmtwQ0JBb2lwZUNRcHZ5cXBIdlV0bUFSNVpnL3Z6SzF4NCtnbnNYbThy?=
 =?utf-8?B?L3REVGpsNjhMcWN3OTlQR0xQVCtBYUs4bm1NVW94K3FwbktPdUlUNWtjdy9h?=
 =?utf-8?B?Z1NWSnRCOTFpcnFsbDBCR2FYVTVwR3RlWEhWYS9MeFMrd1RseUZaSXBzQmxO?=
 =?utf-8?B?TE1wcVZIb2E5UEtjWGpRZldnakpXa1ZsYXhOeEFQRS9rZHNwMGxYamEwcXJB?=
 =?utf-8?B?eVJlUTRUUDZEUUZTOEpQTk5RV1JNOGdwVGJkM0NDRDRLTVFYS213WnFueFdl?=
 =?utf-8?B?Lzg3K0prS3R6dFFINlVwUFhCNXpOWjBSeVQxY09UTmpkaTY0N2JKSzN6Q1dC?=
 =?utf-8?B?MmJQeldYc0JXZlhZQWFvVUxBT21RbXFjOWlvUi90aldOcWZjQ0kzOGpKQ2xC?=
 =?utf-8?B?N1BNVVp0MVJ0dXBITG53QTQ3OHVSWXBoMVBNQ0x0R3hJZHp6L25RdzFOemlk?=
 =?utf-8?B?Qm93YjBRYm9DUXhSVHZxN3hWeEVkVkJqcWJ4cWxzc0t0ajdQTkFZVVMzRnJQ?=
 =?utf-8?B?VVJuN3ZpRzB0ZHlxbFFkdWRhZVBJNksyNFVrNEJLUFk4SXJnTnFWcVJHTzNY?=
 =?utf-8?B?UWhHWG9BUnBqckRFb0Rla0htUjBZVlZ5RzdvaGlXUld3bHNVQnk1VmRub0V0?=
 =?utf-8?B?cnkwTTE4Q2h6U09ab05DK1dLNXk1TnNtbGlnemsvTGd3TUlUK2R2RldTVnFX?=
 =?utf-8?B?ZHNCWEd0dDlnWGJVVEZITkJ2a3k5VVVKWTAwRVVtVklHcFFRUG40cURIUWxE?=
 =?utf-8?B?d2ZMTm56azRnRE94Q283WTl5bEYxdkNBa3FVUXB1OG0wNnpGbGZqYXZjTEND?=
 =?utf-8?B?cVRhaDMwVTYwRU14RDRXV3BSMGZtbzBHK0lncU90aW9wempyRC9TdWhNSFBX?=
 =?utf-8?B?cVJUclc1MmUvYitxaXQ3UU1qNE1NRFNzSUdxQjVmQ0hkeTQwN1J4d1JhSWZr?=
 =?utf-8?B?Q3krR2xnaUJSa2E1a1lkMStJbWRSdHhkZXVXamZ1eWxUaXF1OHkxOFpqMHJF?=
 =?utf-8?B?bE5zYnltclNEYjFkVFJ4c3EzZ0pUZmFSYVRMVi9mRitWU2J5QlV1SXgxbEVw?=
 =?utf-8?B?dGZBYU5NUXFFbDJqTDJ1R3lsSUZyTkhZTnI4U3BYSTRxQ2hPWGUydS8rMGZG?=
 =?utf-8?B?ZnQ2aHRES1doU1VaeUtPbHFGdDhDWEkxTlNqaXlmS21BMjZERVoyeWEwYlkv?=
 =?utf-8?B?ekRmV0IyMWQvNE13SVI0bXo3SW5zYVpERlcrNnBpTzk1Q2tzWk1pcTVvVkpz?=
 =?utf-8?B?dXY1Y3lJVHVjcG5lMnVKenp3ZHVXMzI3cHRxV1dzOW1xeDdVa0VCaWlUZzBi?=
 =?utf-8?B?OGFrR2drTzRQbHlsUFMyT25iaks1WW92ZlMwU2RrK2tuOG80RldMZzdkaG5K?=
 =?utf-8?B?bnNsQmE1YUtJRDFCWW1PeEZtRGpnZUx5ZXZDbVAySmFyQnI2RTR5RXN2eFhT?=
 =?utf-8?B?ZjF5MkdqYll2VDViNkt5T29XaEtBbGxLVGhIaGJReFcxd3FxNTROUDVQT2tO?=
 =?utf-8?B?cUQvdDR6VGs4dFhjaFVwOWxlc3FKbDdBeGpHQUcwSFoyWkVJMWQ0S2ZzdUhi?=
 =?utf-8?B?MjJUSXJJUFRTQTlpYjA2OEo3WHVzWWpqUDJmZUNpMEFmT0FkM2Q5VWFPd3ph?=
 =?utf-8?B?Y1pENGN0S00rUlgvUlh1L2YzS0JaTUNXWEh4MUc1dmE1NVpRQUpUL2tCTm9P?=
 =?utf-8?B?eEg2QVFIQmtvQys1S2FGOEE2cHNwMk53S1p6aU9rQ0QxNFQvRVo0Q0kxbHRs?=
 =?utf-8?B?Nzd0V1JTSDRZSGJxL1RBcFc3d2w1ZGhDL1ltdz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 13:14:15.0886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 305e4e65-bf82-471f-dfea-08dd7b56416e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A792.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB9840

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
index 9619524d8901..782e4dd58bf7 100644
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
index 25a986ad1c2f..8e3582c1b5bb 100644
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


