Return-Path: <linux-kselftest+bounces-46817-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E023C984A2
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 17:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A385A3444AE
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 16:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634AC3358C9;
	Mon,  1 Dec 2025 16:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="JxlA5kbb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011005.outbound.protection.outlook.com [52.101.65.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532E43358A0;
	Mon,  1 Dec 2025 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607114; cv=fail; b=tFA9p8OY/fyKUka75sGZhCO+VnktHC/a/ZuHziXFsi1V8zN5m229wkDhK0g49mt3pzTJVmoxNTviTDNOwjMtLj7DnD4AukNdOBaBIP7GMg+iC2V2BdoBKxl4kkn5otOs8vjB/mrYQPkrLFbpDQqewEUKer2M95hBzJBZNyEyZfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607114; c=relaxed/simple;
	bh=ERNOHIFP/lwSagvkus4ORdFuFTEXPHEH057EdZeRjFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KgieVb6AKzfSJDtxiJ8LZ3cmiEEIlSfTR/+g8Hno5+4UWgiaHM/ENWJvAnkecn2wwR8Q5NZVsj1VfLWwdEt54Fmj0t4fkS2IGw1QNcO3SGm8LnPKugXtYYZzP8cUkf+OPtb9DXoyFYVPo8C6lC17o6JNAG9eCnYUjS4KacQ7/Mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=JxlA5kbb; arc=fail smtp.client-ip=52.101.65.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N23GX/oI80n6t+hxHDGVnrL8ZkhmKagoF3jF5I9wcKsMwgSdumFjKpOEG1Apm/X9C+6vqIGl1jI0J54cYrppbkhG/vUKJ2OOxaS+miO8fIMbiqqDL3Ez83MYyfZhdrVO7OaRazQD7v24JAQurge1ZjmBPvHj414//0BI5PSa95z0RTU2F1jA8a64bjId+5zCRppxKz7EVggVfUbde5kXzOgLO+gAW2f8s02sKw0MzhOOq5Grj0hJqvmIOMMRDbDUzzBfI7KfKNBUWC7brbtY1X+emrxzIiZkn4a+y49OtStLhyuHYP45+VUGzr12MclooygG4TI4KFcBvWWAp0VC3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdrm+ZpMbzc6xadJtuZH0le39dlmyIxKZmEzLnFQuDs=;
 b=u8srAE0eqT3vzWZ7V5hGxatk0gOqL8cfCmXarLyC5pM2dvMN78XeJ4H0RXqHFllZfy26xaUV/VKQTqyuoGGwKObCmBhipqR70p5wP9Rb2CfcGM3wNSc6qwUHd16DebYIdTVQHHKh2KgSORDHZ+NAOz2z8FXMo0QNZH/23gzHyIiERjvywJ9edYnltizh/6eSBYj8EVDeSjc3yhpIw+NqRnHPIIFu2ol31Na10JW2n43nzwXUOtVMqxuxc4m9JYGQ9m2ZOXpF9Vp3FrNUD2r1dzG1Ba7PaX+k3HKeBq3i9CbFMN5qX82560LeaeeuyGLAjrMJlKPEIOp7RWP5X88Kjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdrm+ZpMbzc6xadJtuZH0le39dlmyIxKZmEzLnFQuDs=;
 b=JxlA5kbb4lbCTTGMWYX//nx3LfpLzK3n8DzuHdW2Uys/TDh6FTRfdkLk4xX7fcGkQ8t8LXzTadg3MJ6jseR4Fkf4hdIRzRI/Iahlr6T9797zVMUi/4mktTc3IFeoT0XX8TqCc7AdwCkAEhBiV8NTh5JzXBgWWwHLyixRbqfzy8XSzJzzJGSarrZVFsMmt1ZuZyq2pvBskiKWnU6PIVl62hX3STGhV8zlxul6kKvVU9Kg91YWX8NaoMvJNJ8awzN2nBpB9LXQn30Jy45/uXHTMooXAc6TzmBE1jTHyEOMjTlZpvjJJEOK2es8gIzPRGem6Hoym/0M2fQjgKt2wI6gfw==
Received: from AM0PR02CA0174.eurprd02.prod.outlook.com (2603:10a6:20b:28e::11)
 by AS5PR07MB9895.eurprd07.prod.outlook.com (2603:10a6:20b:680::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 16:38:26 +0000
Received: from AM3PEPF0000A795.eurprd04.prod.outlook.com
 (2603:10a6:20b:28e:cafe::9) by AM0PR02CA0174.outlook.office365.com
 (2603:10a6:20b:28e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 16:38:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM3PEPF0000A795.mail.protection.outlook.com (10.167.16.100) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.8
 via Frontend Transport; Mon, 1 Dec 2025 16:38:26 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id EBA4768002E;
	Mon,  1 Dec 2025 18:38:24 +0200 (EET)
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
Subject: [PATCH v7 net-next 05/13] tcp: disable RFC3168 fallback identifier for CC modules
Date: Mon,  1 Dec 2025 17:37:52 +0100
Message-Id: <20251201163800.3965-6-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251201163800.3965-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251201163800.3965-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A795:EE_|AS5PR07MB9895:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 50e6155f-6c34-4ab0-d848-08de30f80d41
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?ZO8o5Btsq0CSOgbjIOkwg+WHZwmwlytmqCg30e0c7NA4IHfWDFB12cKJ40fd?=
 =?us-ascii?Q?rlQlZEDJfwBCKcu3RnvRsFWtxZIfgs7gMd7LMjIiLdkhvPhXae6P6sXkKeSp?=
 =?us-ascii?Q?BOj46le/rEZwB5iCHlA/+N34az7jNjRuPG2Y+yuNZOuXNWu5aE/OHPoCOquP?=
 =?us-ascii?Q?2IJ8JPk18r5gDsAGUXuqxB0EgK/ePXWmviMIqEpc6cJoQbJRCWcnqhlhRxyN?=
 =?us-ascii?Q?wbPKlfKuWeaAHHg8kOjJrAk7l18T09cEVKtP8WPwCaI2dhq0n8eZVIDOsyyR?=
 =?us-ascii?Q?WdbY0rRMDM0BsOPOZnI9nJR+G7uJWz9etLkzx3ScaY3QrxBME9AhRcgzpHq3?=
 =?us-ascii?Q?UumEYtR6fs6ktuLsla+YvqJcf2ciiASmqPqASxCILGLzTcwrS9hjuG0n4GiW?=
 =?us-ascii?Q?XE9UeteexSQLNmXWlQpjq0YMAwEb1/VrmOXLjZ/Pj+e74dtIU3XhHFy4iZn5?=
 =?us-ascii?Q?vSB1GrqovdOWymD4bQKzrMhc5Gy7wMxYo02rpO1IGY3DjUC2F7jSussjOjFT?=
 =?us-ascii?Q?siikirCsXEF7QoXQVvly8j8Mc4t/DpBc6IJI1mAW6PIb4Cs2J0CG2lMOFhow?=
 =?us-ascii?Q?X7Flv7j3GPgk4Awhn4incuIgjAOESLeX9LcP7c4NQgJHGY/f/QiOFnivL4iN?=
 =?us-ascii?Q?wrTZVCpwFqjV+mJhbUFQr1YyO10j1TyXzAlMlJsq9/q9T8+IGwNDW7iQSgcG?=
 =?us-ascii?Q?pU1QhE635omy9aGmHVGzDrhyhHY90fz6TTojde7OtZSVMOtHymPsPNjYFQT0?=
 =?us-ascii?Q?D3Ius2Y6KCUeeLQCNdKt3b/ObFGrTNuna4yf+0cvIhFG1aGVxbYifaqx7p8u?=
 =?us-ascii?Q?eAuzC1V5/ezzRCzOD4LYtoNtNJyS8NThZ7s5lt9vfPS6jghhYB097I3BaO+W?=
 =?us-ascii?Q?Q6fkies8vojUasMj8QOoT76YhZnZrjz94FTh32JL+TY/SCDCYP1lr0EFk50p?=
 =?us-ascii?Q?I30EBYk9by35vTbiaXWmqOvqQEOaYGIepjuk85z9gBYabqBEyBH8C3g+VPme?=
 =?us-ascii?Q?19CGyjAzGlXbzoVsW9lhFlPzp9edpdVrukIUrFP1vedusAFTDvAAlXoJcZKy?=
 =?us-ascii?Q?ebwBwaZBPmO11XiQTIzyLcJZeiZlQttabrud5vVy5zg+TC6C0bROurZdG4jn?=
 =?us-ascii?Q?eIA/+116tiy1c7TGj1c6uR8By6p7OzdxI44xD/pI0gLfyqbB5QBKBBkr3QPf?=
 =?us-ascii?Q?MJchLA0kpN6m5kg9IN+kSzjmoNbMdLXB1aPsLLU22ymgfRnRPSjbw/adfgU3?=
 =?us-ascii?Q?ktlbodj28/AF5Whh/XKCFRzMxiBQKutd1iA7hXjAJV7VSzBmY5l2XlhzIMrc?=
 =?us-ascii?Q?VMdncDYDj3+tH1qOlk7J/CPbf0ASjJZ7aduy+R4L/Sx92fSLR9f/m8H7+dI6?=
 =?us-ascii?Q?JHHqR2ely0mrxzD9/F+0yDNopie3ca513KyUpF6yBNz7X7RQtU4/74rU0ZK+?=
 =?us-ascii?Q?itTXhosENXXq4fMwZIxhxRsSLCu+APArz/QInkfYwTVxLimcU3Cj6pd5fqXr?=
 =?us-ascii?Q?Me72OmMH0Gf7FPwtqKH7ry+3WY5fD39/XwycKIRts0FOvcgv+RjNoNlYF3fb?=
 =?us-ascii?Q?NMwGKJN6IUyNJ+HkfFE=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 16:38:26.4958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e6155f-6c34-4ab0-d848-08de30f80d41
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF0000A795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB9895

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

When AccECN is not successfully negociated for a TCP flow, it defaults
fallback to classic ECN (RFC3168). However, L4S service will fallback
to non-ECN.

This patch enables congestion control module to control whether it
should not fallback to classic ECN after unsuccessful AccECN negotiation.
A new CA module flag (TCP_CONG_NO_FALLBACK_RFC3168) identifies this
behavior expected by the CA.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>

---
v3:
- Add empty line between variable declarations and code.
---
 include/net/tcp.h        | 12 +++++++++++-
 include/net/tcp_ecn.h    | 11 ++++++++---
 net/ipv4/tcp_input.c     |  2 +-
 net/ipv4/tcp_minisocks.c |  7 ++++---
 4 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index c4c25f2e0c0d..e0a5cf2f7818 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1207,8 +1207,11 @@ enum tcp_ca_ack_event_flags {
 #define TCP_CONG_NEEDS_ACCECN		BIT(2)
 /* Use ECT(1) instead of ECT(0) while the CA is uninitialized */
 #define TCP_CONG_ECT_1_NEGOTIATION	BIT(3)
+/* Cannot fallback to RFC3168 during AccECN negotiation */
+#define TCP_CONG_NO_FALLBACK_RFC3168	BIT(4)
 #define TCP_CONG_MASK  (TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN | \
-			TCP_CONG_NEEDS_ACCECN | TCP_CONG_ECT_1_NEGOTIATION)
+			TCP_CONG_NEEDS_ACCECN | TCP_CONG_ECT_1_NEGOTIATION | \
+			TCP_CONG_NO_FALLBACK_RFC3168)
 
 union tcp_cc_info;
 
@@ -1354,6 +1357,13 @@ static inline bool tcp_ca_ect_1_negotiation(const struct sock *sk)
 	return icsk->icsk_ca_ops->flags & TCP_CONG_ECT_1_NEGOTIATION;
 }
 
+static inline bool tcp_ca_no_fallback_rfc3168(const struct sock *sk)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return icsk->icsk_ca_ops->flags & TCP_CONG_NO_FALLBACK_RFC3168;
+}
+
 static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index fdde1c342b35..2e1637edf1d3 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -507,7 +507,9 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
 		 * | ECN    | AccECN | 0   0   1  | Classic ECN |
 		 * +========+========+============+=============+
 		 */
-		if (tcp_ecn_mode_pending(tp))
+		if (tcp_ca_no_fallback_rfc3168(sk))
+			tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
+		else if (tcp_ecn_mode_pending(tp))
 			/* Downgrade from AccECN, or requested initially */
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
 		break;
@@ -531,9 +533,11 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
 	}
 }
 
-static inline void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
+static inline void tcp_ecn_rcv_syn(struct sock *sk, const struct tcphdr *th,
 				   const struct sk_buff *skb)
 {
+	struct tcp_sock *tp = tcp_sk(sk);
+
 	if (tcp_ecn_mode_pending(tp)) {
 		if (!tcp_accecn_syn_requested(th)) {
 			/* Downgrade to classic ECN feedback */
@@ -545,7 +549,8 @@ static inline void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		}
 	}
-	if (tcp_ecn_mode_rfc3168(tp) && (!th->ece || !th->cwr))
+	if (tcp_ecn_mode_rfc3168(tp) &&
+	    (!th->ece || !th->cwr || tcp_ca_no_fallback_rfc3168(sk)))
 		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 }
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index ccbab5569680..e5c9cf586437 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6861,7 +6861,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		tp->snd_wl1    = TCP_SKB_CB(skb)->seq;
 		tp->max_window = tp->snd_wnd;
 
-		tcp_ecn_rcv_syn(tp, th, skb);
+		tcp_ecn_rcv_syn(sk, th, skb);
 
 		tcp_mtup_init(sk);
 		tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index bd5462154f97..9776c921d1bb 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -485,9 +485,10 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tp->accecn_opt_demand = 1;
 		tcp_ecn_received_counters_payload(sk, skb);
 	} else {
-		tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
-				     TCP_ECN_MODE_RFC3168 :
-				     TCP_ECN_DISABLED);
+		if (inet_rsk(req)->ecn_ok && !tcp_ca_no_fallback_rfc3168(sk))
+			tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
+		else
+			tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 	}
 }
 
-- 
2.34.1


