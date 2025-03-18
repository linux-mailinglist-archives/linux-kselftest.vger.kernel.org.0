Return-Path: <linux-kselftest+bounces-29297-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4124EA663BA
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 01:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8B43B6596
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 00:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBDE155A59;
	Tue, 18 Mar 2025 00:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Q5Q1IopP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012012.outbound.protection.outlook.com [52.101.71.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA13C224F0;
	Tue, 18 Mar 2025 00:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742257685; cv=fail; b=pAY8secKzcoVEY0JbBdRGXKLiR+BJSQ0usUdN2U2t6HK9GK50SDoeyCqmbtsnlNb9AiiD1Ll3jcKM84G+AB0357VHTK5jXj/2lLink4lytVP27xbm0D2NEsrmHjK4YpRQJ6ZriVGfrQvulQ4hJaI4OE7mTKYQQVdr3BhWdS1f8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742257685; c=relaxed/simple;
	bh=Jfw8pCRZM/WvUnDQpH9IFbTRpO7rJFAbatV4ss6bVm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mqWi9lMCziif6CIRq5XCYn7ZCePt83UYFEWeau9Ahab4iuE6OGfhB34dJz9AwZXGhZwjQRPT4nFqYEpzOS3iFDeFs/E/rrYzAJuvJa+z75eOTt0wSCizI0EDDmuADTYaleN2I8hz+bXEOaSox1yeD6fM8DcPB9KQI1Qnxwe18e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Q5Q1IopP; arc=fail smtp.client-ip=52.101.71.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfwwl+8GqWYadKozPkyZtUU9bFyKPTs8Tt88sOWOx8ho+9443T3zZFGReV532u42Tka8kgX5Ilu/0n/Ym19SIay4Jqhmp/jzVIk1E7Ex1XwqWT2vsCZ4GF5PnVQh5/oZKcHa1F9YJreCjG3/cILnCixkSy0p0FG4xLKN2Lny6W8sxofwQWQ8h2k8wEyW/MpzRJmh3nnggC2REMB9D3SlF3D3lV4izIbMgNKry9pDycFCcNgw7kTnIdMDuA8Rnguoee/bJVKALvBWrqOaaBu2FODt35mhHBWTRODgNxkUISRET7QSQR4HhrYAypcZ+XvREstXmSBSu7mo1gljzyil1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0iTVB9QAuoJKr4I1LIOJqJ3t3nWd6OvyM23++tXfgd0=;
 b=w4+MP1l2U1zXa6FypRY85mQEvwDnLToDWVwtPk5uWOP51q4h0005jjiPCNj1l+1ZX3EXPQkY0xpHWRTrjipncRXko141yTMQebBY1t9cqGJNPpL1fMF+ZkfZjsk95b8NKFduXpZRAhBxy1GfyHbGPWUW/MNRVDZiQyVlSNp83HYOUkGQMEhriykpN2ojw6lbu3nmQIICC671fIfOLIZ3/Vp4+dTT2ctUK3uVkgOQPK5Q39kW29aCgJ7qNLz34y53vAIwj/Wtx6nJd+tT7pyNZUHkaAPyPkomsd3Ef2tU2b6HgsMmheIB5vZXJCQLREz1qR1ZCt1DaoLyAsFK1xlRUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iTVB9QAuoJKr4I1LIOJqJ3t3nWd6OvyM23++tXfgd0=;
 b=Q5Q1IopPzvtNa07dZevDfLjoh7cugayTs9+Bpg4VAnlwxmrf2M8rWg45cqyNCHatuu48iRuHybjd1Nqg9QW5GzV+PlvXpcIp6jhms1KOcHKjbNgfVylh+qRhXkh8PVLgYKdj7/24ncKMW3/MZLvHYBlFa6qpKO+yj3FU8kWWwX5KpD79RKKmrfIeQA77dQNeUO1zJPMGNVQUDpmJfkHu1HNdCFtM0Y1H8uJh8iNGyCBnZio3mpAg8dsXScLvraPZtAhR5xMKAictDyPJl0j34uL8KpQiaSEhEw76UsTexcy05WWDgm5dhOMmNkNM6CfoBe74mZnQa4r7GPvF7rgBYA==
Received: from DB9PR02CA0005.eurprd02.prod.outlook.com (2603:10a6:10:1d9::10)
 by PR3PR07MB6778.eurprd07.prod.outlook.com (2603:10a6:102:73::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 00:27:58 +0000
Received: from DB1PEPF00039234.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::a8) by DB9PR02CA0005.outlook.office365.com
 (2603:10a6:10:1d9::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 00:27:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB1PEPF00039234.mail.protection.outlook.com (10.167.8.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 00:27:58 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 52I0RNBq024935;
	Tue, 18 Mar 2025 00:28:06 GMT
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
Subject: [PATCH v2 net-next 10/15] tcp: accecn: AccECN option failure handling
Date: Tue, 18 Mar 2025 01:27:05 +0100
Message-Id: <20250318002710.29483-11-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318002710.29483-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250318002710.29483-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00039234:EE_|PR3PR07MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 24b30673-13ec-463d-ef45-08dd65b3bc1f
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?YjVCN0tJcy9pbFNkeGhPQ1krdE05UnVCbnBIQUpLcUlkd1ZGeTg1dVhVbWxI?=
 =?utf-8?B?MDZuNWJTK3hTdjdHQVhyRENzd0ZwZ3JwYUVvZEFCRXg0Q0pnMFFtbENnME1N?=
 =?utf-8?B?QmlTVlAzL0dOUFJ5OWhzZVhPaUtRb1VTOEFid09yQ0puY0JtSGIxcUxpQzBr?=
 =?utf-8?B?anRjR1dmSTYzYndkdGJZTmkvNUc5U3JkYUFkT2cyZFJLdDVYL2Q2ZDdwWTE5?=
 =?utf-8?B?SzdCMmlaalpWY3o5UnVLcjZ0b3BUNEdNZnRvOFkyZzRwK0V3aUJKU2dGYmYw?=
 =?utf-8?B?bXVvd25YTE5PZ3pRTEdNV1duSGluSzdlV2pQQlZGamd4ZHV0WHkvRlBWQmx5?=
 =?utf-8?B?OVZndWZMMUp5VFNWYTJqUk1sVUFxd3hSQUFGdm1HQ2FmNjVCMXY1QkdvVzFK?=
 =?utf-8?B?T1BoYkFzSU9oNmVuTHJSTU1xVHdmRHlwNDJ1UkFvTFFPb1JGUjZsZXpCaTZ6?=
 =?utf-8?B?RHExMzQ5N1FqaFA3N2cxTEpxcTdqTGhIUW9MZWliT2VodFg2ZlFPRXF3VmRh?=
 =?utf-8?B?U2pDbHR6eEo1THJ3YXE1WEdQbEVKcnF1a3I4c215UW5iL0pBOGswcG9HOU04?=
 =?utf-8?B?eXNQaExHT2tHYXJXRE1iYWJ6ZzJWV3YwSUcrVUYrbkFQM0dsOHFLWDliaVZE?=
 =?utf-8?B?c2EyZkQrNXVGeXNGNUtGWnkxczlTb2htZkRsQmRZR3U1RVhEVXk2dnc5dVAr?=
 =?utf-8?B?ZGYyTndnVlZHTEJuTmc5WHpqMWZlZVQrOER3bDJUWGw1cm9peCtRUEV5ZjVE?=
 =?utf-8?B?dy9JRjl5RDJEV2d5aGkvbXdVZGRMYlVDYnFzOHNjQ1FCUGo0aGVjM1FyVE13?=
 =?utf-8?B?VnN3eUMwMWordDVvVkhnd1ZxY2RselkvV3YxZjRWcmpucGJIR282ZFdncnFY?=
 =?utf-8?B?K0l3TjM0Z1FYSmFtOTZCcWZ0MHBFUlBMSnBXbkMvaVQ5Ykh3NGswMlRBeUh0?=
 =?utf-8?B?VmRUeXhjTXlIdlFiYWRSTnEzN1d6WE5wY3BCRXUvc1hpeW10U1k3dU00ZER0?=
 =?utf-8?B?RE93bmR0YlpuekMrQit3S3R6K1haTGs4NnA5S09sM01JbjlqTG1aRTdmVUhY?=
 =?utf-8?B?Y0prWDhDOHQ3ZFhMREZIUk8xVTFVeVJyVmpHdmhldW11NVpsNkpKZUtBcith?=
 =?utf-8?B?ckViWGpLSVhiamE0TXJFNHNVRW90UU1OY2VKNkNFVlVXZjRQdThDSm1KVkw0?=
 =?utf-8?B?ZXVQWjA1U0ZlV1JTTHZxRGNYTkpLSm51V1R5ZzBabU5kb1M2MTQ3dzlxazJh?=
 =?utf-8?B?UEljSTdkU0xMazROVDl6Y3lEdjE3d1VvLzZUZHZCbWJjb1BBK2pLd1kzRVlV?=
 =?utf-8?B?eWtIemIzTHk0Y2NQTktZNTdMNnNEV1YvMERBVXJFcVFuRWlzT3BwNEpTbmdL?=
 =?utf-8?B?UDRxZyswVE41VGdMd0Rrb1R4N2ZoNDNrSEN1NXprdTdqMW5sejZFcVhzcnBQ?=
 =?utf-8?B?TXFBMTI3SGwxbDR4OVlRU0paUWFPTXo1Rko4U1M4SWhQNVk2akhNT08vTjd3?=
 =?utf-8?B?U3FJUzNMK1pCU2tGWEc5NUkxVHpLamRFRGhUOXRnVGd5UFhZY01WeVJ3TVJk?=
 =?utf-8?B?ZHI0U1NGc0lqY0pmOHBhdURJVnNQWFJ3RVNuUzVQLzNMdnVodFFkMDhLVjZC?=
 =?utf-8?B?ZnZLemdXMzYwRnhxVEpUbjFFU1o0Y1RVdXZBSUZMdjVJQ2JtLzJjQUl1QWF2?=
 =?utf-8?B?RmpmNkxYd2ZOS3phQlZxV0FIM0UxSk1kYjZNbXdCbVlCRkhRejYxUms4cmls?=
 =?utf-8?B?TTRLOTg1L1pNQUNaMkx5OG5ZdktzVjI1QU5wNHVscVNadHdxeEZpNWhSQVNa?=
 =?utf-8?B?VjRIeUZSZE9qbHFNSFZ1NmxaMGw5SHVKdDlCNWk4MU91a0J4V0ZqZTFqVUNT?=
 =?utf-8?B?NE5EaWtFTDljcmFBUWFJTlU1bVBGRGR2OE5ZSG5hbjM4ZWUwanpMTFBJU25a?=
 =?utf-8?B?ZVNrRHRqT05sYWxncno5a1BvdG5wWVllRlVITFpzMFlGWVV2bXR5NExoaEJL?=
 =?utf-8?B?SWJ6Sll5MXhZUk1MWC91d2hoSUdxUFhTOEM3L0ljVzdRQlVURHdVRzI4MExL?=
 =?utf-8?Q?Ozlrzh?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 00:27:58.5145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b30673-13ec-463d-ef45-08dd65b3bc1f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00039234.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6778

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
index 8d0f5a73b0a3..ccb5918c8b41 100644
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
@@ -388,7 +389,8 @@ struct tcp_sock {
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
index 48fb4e5579d1..d531da9f9af8 100644
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
index 701013b0aa87..c4eadf6dd6fb 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3365,6 +3365,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->delivered_ce = 0;
 	tp->wait_third_ack = 0;
 	tp->accecn_fail_mode = 0;
+	tp->saw_accecn_opt = TCP_ACCECN_OPT_NOT_SEEN;
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 8cdeb7765d91..d7498b1c9fb9 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -447,8 +447,8 @@ bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace, u8 sent_ect)
 }
 
 /* See Table 2 of the AccECN draft */
-static void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
-			       u8 ip_dsfield)
+static void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb,
+			       const struct tcphdr *th, u8 ip_dsfield)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	u8 ace = tcp_accecn_ace(th);
@@ -467,7 +467,19 @@ static void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
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
@@ -587,7 +599,23 @@ static bool tcp_accecn_process_option(struct tcp_sock *tp,
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
 
@@ -603,6 +631,13 @@ static bool tcp_accecn_process_option(struct tcp_sock *tp,
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
@@ -6458,10 +6493,25 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
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
@@ -6955,7 +7005,8 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		 */
 
 		if (tcp_ecn_mode_any(tp))
-			tcp_ecn_rcv_synack(sk, th, TCP_SKB_CB(skb)->ip_dsfield);
+			tcp_ecn_rcv_synack(sk, skb, th,
+					   TCP_SKB_CB(skb)->ip_dsfield);
 
 		tcp_init_wl(tp, TCP_SKB_CB(skb)->seq);
 		tcp_try_undo_spurious_syn(sk);
@@ -7532,6 +7583,8 @@ static void tcp_openreq_init(struct request_sock *req,
 	tcp_rsk(req)->snt_tsval_first = 0;
 	tcp_rsk(req)->last_oow_ack_time = 0;
 	tcp_rsk(req)->accecn_ok = 0;
+	tcp_rsk(req)->saw_accecn_opt = TCP_ACCECN_OPT_NOT_SEEN;
+	tcp_rsk(req)->accecn_fail_mode = 0;
 	tcp_rsk(req)->syn_ect_rcv = 0;
 	tcp_rsk(req)->syn_ect_snt = 0;
 	req->mss = rx_opt->mss_clamp;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 82065b49e7dd..07259c828594 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -498,6 +498,7 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
+		tp->saw_accecn_opt = treq->saw_accecn_opt;
 		tp->prev_ecnfield = treq->syn_ect_rcv;
 		tp->accecn_opt_demand = 1;
 		tcp_ecn_received_counters(sk, skb, skb->len - th->doff * 4);
@@ -552,6 +553,30 @@ static void smc_check_reset_syn_req(const struct tcp_sock *oldtp,
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
@@ -713,6 +738,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	bool own_req;
 
 	tmp_opt.saw_tstamp = 0;
+	tmp_opt.accecn = 0;
 	if (th->doff > (sizeof(struct tcphdr)>>2)) {
 		tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0, NULL);
 
@@ -890,6 +916,18 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
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
index 61bb5f5ee357..6bee68795b0e 100644
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


