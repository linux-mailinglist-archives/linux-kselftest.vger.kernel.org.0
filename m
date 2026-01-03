Return-Path: <linux-kselftest+bounces-48108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E986CCEFFAB
	for <lists+linux-kselftest@lfdr.de>; Sat, 03 Jan 2026 14:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E0B33003488
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jan 2026 13:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32D730BB82;
	Sat,  3 Jan 2026 13:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="BDVHRNxH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010064.outbound.protection.outlook.com [52.101.69.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37922FE04D;
	Sat,  3 Jan 2026 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767445849; cv=fail; b=bHdCcaAh5bEGipLdSZIZBn3+RpoPCfPNO1ZGGcjXlRKHBWFeTamcr8pVxZ39l/8Nabv4TuEQIgYe4zqv/bXBu2f4tUYLXkIwmNjxcuPl7I+2NB+CHMgWFAehYSI8yN0v8T2bQpY1NLYSgzu9QuHHq9VsM6Cl3tbHQq2g8ftUVIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767445849; c=relaxed/simple;
	bh=ERNOHIFP/lwSagvkus4ORdFuFTEXPHEH057EdZeRjFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kky8b6HcuyqguRIqFs/c0jX6aEI148i3SVkzLupA+Wud3UVq8k2J7JpJf9t5fpU4aC9UjwRz7Fnt6JdJpyXToyDtsGVLNbyKe6LmvQzG/kl6sQqji2UpKg5sJKDpECBse515t+769W73qcRtl5R19HB8BUui/aurT1gJZMtbGrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=BDVHRNxH; arc=fail smtp.client-ip=52.101.69.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1Msj/9ng6yIVaZe9CDeywr5KOxaQqM5ae6KZbMjL++pUBqEuotPM3UbNRe2X1agfbpnICs6bMiPL2kf1PUgASSqt2HoBL/PLZ01Nrtj0M0eh4CB2vxmQjV6U76be3+jMd911WuZbYXGeP/9EH061/P5llhZX0lnmevYpXjewsZpVFAtFsEx2CJACP+GPNbHSbFUdKOe7qzWhcInV0m73WAV6+Ay6B4xKpFnSzLh91/lIwPMDLMzLbNgl5P9L2uqnVMZ/M8DOaGDRu4m1baizY0k17kGBBuPQbBg5Mrqr9cCxSXQWEXjFRdUI0jgJrr1b5Cmgogh7dKprJH8IuRgyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdrm+ZpMbzc6xadJtuZH0le39dlmyIxKZmEzLnFQuDs=;
 b=Beo3+cwVVOtHbYxFguNPKVYoQ84+MPcDL5hbDGx53lzYCTdJlV7bi4ub2Rt0BbDlPEZ0MTwhHnQEdcUQqSkbmcBRxDbXIQ8fo1vZLU+yjWVPSPAFFVLMfOf6tPZTEVG+FEBJIji+kEWsgvwcqhGU9HaaEdQ5fvW3J1PkY2rPsF0CW+/ORZvQ344h0wGi3D1tpNqvfMlF/Tb5Oie1ZFeGCsbXXGICMvDJDik5ip8opw28p4zs3i//7iq5NdzsmUWRjsfyVBZpCm7IqA9MYrRKidj4jlsu6hcI9F9XRFX4AKc0FD7YNjimj9XB5NholgQQ9KXtGQKs9Oz26WLUPT31GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdrm+ZpMbzc6xadJtuZH0le39dlmyIxKZmEzLnFQuDs=;
 b=BDVHRNxHSwlbDHfEifQIZDJit43kL+at8tqDAJXsBpfLAtDyC58uo32AszGWl0olG66baVASRU09iJ2+MeVwHD+E+HttlPWDTicr34ObIz1scAQHaC0koYYYhFaVha+Js69V0ZlymOE1EQHB7xg6vUmlCFF6KgUew9MJX0hYDRt2hI4lrRm+jt9ta9dnDUAg38AGyA9XLFY6VcwpP3EEb9vLzVy/6lPICFO/VipxDN2+tk+eV1QCWYPdxZh3ngF5cj8gf29hHc5eQBsBHM7GUNPqOgAFtDoTkTUzHS22ZJA9bJmqBoxDgvC55oeqnlXH7eJOg5xnUUwBbbY+JAiD5A==
Received: from DU7P189CA0027.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:552::22)
 by AM8PR07MB8105.eurprd07.prod.outlook.com (2603:10a6:20b:36c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 13:10:43 +0000
Received: from DB5PEPF00014B9F.eurprd02.prod.outlook.com
 (2603:10a6:10:552:cafe::4d) by DU7P189CA0027.outlook.office365.com
 (2603:10a6:10:552::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Sat, 3
 Jan 2026 13:10:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB5PEPF00014B9F.mail.protection.outlook.com (10.167.8.169) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1
 via Frontend Transport; Sat, 3 Jan 2026 13:10:42 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 5278C1C0033;
	Sat,  3 Jan 2026 15:10:41 +0200 (EET)
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
Date: Sat,  3 Jan 2026 14:10:20 +0100
Message-Id: <20260103131028.10708-6-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9F:EE_|AM8PR07MB8105:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ba5a6ff7-5d9c-47f7-19e0-08de4ac9800b
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?hlKStcfKkABD+E734BDSwoROhg/2p0GO7+xEHih07/xyRKC4/GQ3DBEtfsyJ?=
 =?us-ascii?Q?p2AavQAHp0a4DE9ep8OIofZRNCJ20k69Gtd2I/S4Rq0QAxDZpPOg/b5EajTZ?=
 =?us-ascii?Q?dJIHS/hJthJpZN4gPGLI3OQ2J4SXQspYzbm65/RogwMIXuh2se/c5tjIjh39?=
 =?us-ascii?Q?YtCA5UHBrkd/07EEUCRrvuaVv8l1aGtqpmHymUIFAmxP/EviOJrYvITSFSR1?=
 =?us-ascii?Q?mZi02ET+kF1PSMbAnKGLvFRDJB8Z2fIFX3fL921vYE92aYikeOsB2Qqk+G2f?=
 =?us-ascii?Q?1+f0oxVLd1aFn2+Zjos1SXFoNdl3w2+iwnG7ZmjP8o4WY6PD8aUr/B1nR6yk?=
 =?us-ascii?Q?un0fxIUYHu0E/ss1meDzG34lmIw0ZD7AaUlQnWgu0caHXLHnVlRUa6FgoTWx?=
 =?us-ascii?Q?orrg3CijIioZ2b4i2qgJ+rSsM1S/vkiNXIJDopzoP537gAI5mDdkJL6hsxjL?=
 =?us-ascii?Q?q5iElaGLRs+FkB6kd/9AzN/AS6XTExuEV4uid8GV8p8Fe2WA4O3mI6yrPjMD?=
 =?us-ascii?Q?asi0NEUpI74L6wiUhl/edDOTGn66uogYbB+XEMBZn8ntTDmjBf1JyeHe3Ghe?=
 =?us-ascii?Q?js4w/CkdoFrZ62G4/ZZgQkZjSuHcrdqq//8KnOo9XgYQ8MYzRTgHoBJwfUH2?=
 =?us-ascii?Q?6wj6o3D3Rn9RkAkKzz5A7JSPN6pEl0YLzObfvUdcqVnYing8fw7LQHzo5UGO?=
 =?us-ascii?Q?wK9qsqkt9jniYCu2ZRhvUq/ALH2id0q6Eh6cGWJEhfwnNR2fEndl1PWr/com?=
 =?us-ascii?Q?ABUMVB7PN4n4vcmW0nqY6+7aFSC/IUtE16mQyEJ2fxD83EC0W63Pn9ie1QEt?=
 =?us-ascii?Q?1Xrm2SuC67gDITHukfg9k5LZK8UQBxxY3LE/IcLJ1a5uKHFNt4S9wrjtZ21F?=
 =?us-ascii?Q?cVoeg7z69SeCBDkaUMVfrPXHxlfXrBBjd4dpPBMvNbGf/C8jOy8ScvBBbKZb?=
 =?us-ascii?Q?/HaDqNHWDCwpihQVYzmKxFoY1UlHmYazprav4pmR7b7/3S7XNTPy6XS1OV//?=
 =?us-ascii?Q?NiE/0Y3sEsypTRSqiY53xdN5PPYxuCkaaOR81EB8BfRJfwU/ReGMIieElNFD?=
 =?us-ascii?Q?W/3ftW3HAvAZZ4RnjPsha2Ry7OJcjchduBTlFyTCM3yGfF4dMco8dFCIStoZ?=
 =?us-ascii?Q?6yJ7oTKupXnKzgOfu2aH7uS1X9L64+obpFUxAHeHFF+X5PMZimeHVOkcy4xv?=
 =?us-ascii?Q?Ni9JnRXqQ7tZX8ZX6hqox7gElY/EgSi9E5uTqjohoNcsX3yuLMMYvNmK1DCS?=
 =?us-ascii?Q?tGbEaUEi6OckY27Zuxz35tRuqOV7btRCp6jtMLJ+yk0DTJLKAsW9tYZu6z+0?=
 =?us-ascii?Q?8lqpV1sUgvpYJCdmP09yQLybF+bazBo34q6Yzh7Ci4iURquk2/gExU9eGYaN?=
 =?us-ascii?Q?tloFAylku19KnFeG+ryCX83qSVP/C6z1tub2ZmNA0atTY0YfgH6h2PHhzYZ7?=
 =?us-ascii?Q?jSwph6Dr/dsAKDO34zNJCvW+WV77JJicwDZ9UU2WpReEQqsq552X2G/ScjX/?=
 =?us-ascii?Q?VpVdUkRNBFNyHIA9ERpye1lAr04a8hYZI1bI26/1oPsNh+yDAa1gb5KilXXw?=
 =?us-ascii?Q?XsdY0s+8TnSoOx43PnI=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 13:10:42.9469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5a6ff7-5d9c-47f7-19e0-08de4ac9800b
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB5PEPF00014B9F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB8105

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


