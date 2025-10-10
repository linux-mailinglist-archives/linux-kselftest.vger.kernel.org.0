Return-Path: <linux-kselftest+bounces-42951-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0BDBCD196
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 15:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA3434FBDE8
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 13:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF8B2F3C2F;
	Fri, 10 Oct 2025 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="FYS88ukn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010025.outbound.protection.outlook.com [52.101.84.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A352F39D6;
	Fri, 10 Oct 2025 13:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760102263; cv=fail; b=PjJj08Z4g9kxmGmQ7EB4I4itWA5kDrHu6MgrcKXhohP+9CrfPy2QqsnBvnRe8JpEnCYtx0qcvGQz1g2+RwehOgVJV86e9c+XI8UlAU5ZOlZ9diDYiXJJxXmFqBs2r4dJ7WmMMrgMO2J73QymLSQV2r/WCHmzUBnfis25Zrc7ahg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760102263; c=relaxed/simple;
	bh=HG89KDgLb/Thxkh/F3XvA+9Em5jAI7lathjA/LNG7is=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hHNI9fa1IT9ZwiauXrbxcFm5Lf2siGLXHl9PLWun6YhMbKfJSvq7Le5WowtB1GMdKnV4YqyqkYbOPkuI+KTI5icOJoqItTupDofSFAau8PQ/JFczbg1PuM0PM/U1Vsg4eoVPTSNMiDnVy1p8q9pzTqboVhP5lHHTa0z7a7ZBWy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=FYS88ukn; arc=fail smtp.client-ip=52.101.84.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMzbckqX5HBCgrzVQ0OunIRex6HurCAPhIxQkZC2X7k5cQpw9v7DWt/8CgTvp2ZyGuvteBo0U6UzAREmITgEjm4OqDfsZ1tN2ga6gGNb1aGO5wzXzaBvAoDcEyi71DgDYOPIPh/NM9wUTGgw8Gyo0U4aGRFLO4973PLJym1z6r03aP2vc1SKcdqotV18Y3/ez0mLzrFkuSRP9iihaQeG5GApMiWDwRhPwRlJ9vwVVvrtQejhvHAYmHybJ7BleJBO1L2zwlYtrcw38+LR2O5exE1oyna0CFoj9qVXET3B+9ewAYXEb9RhF9VC6n1jXns/Mk7ZCVSWKfFFwHyOYQeh9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIRsH6eEtEwzcalK6eelVND8k/OculqcZVWMZYSHAwE=;
 b=MQzc3ccSPER7261qduAsKLsW/f1ZRbIg/4D876QQwyyYjfQUZgbp/u5btypZVj3sg8QgNFMzVTnXk2U305kW5GVxdEV2vZsCOyKvyIxKoP7eWh9MW59kgM9wtR7MDs95Y3yMzZPNyjvaXTN77VtMSgCS+E1eQnvDaymOnXGjYj43TxsBzdqLFkip292+9W75EgCLhIhq0vmpUZ2DE8D8EUnOrgiD+C72hNMOEmhIoISbwd9RypTqTWdKQM5MFTxqXUYKmLouo2c9qSyUL7zzxEKKmxtdZ6+YRsOPmpQakysLfVhoZXX/IrZLSb2gxRoHUyByGYxJUXuwhEx2j+Vfew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIRsH6eEtEwzcalK6eelVND8k/OculqcZVWMZYSHAwE=;
 b=FYS88uknO2gjYYzXtDOdmecQKJ2BkBNI+aBVjWtf9L0W9eihjQzkiQqrg+THj0VsKLysWpoE1XrQ/12KnMeHk4jUdFoCxh+5GO6zS9IXJFVGzeXqni1P8OvejecBSKPiPYS0S2lD4dlCsJslSaJxbt44vZlJIUNyCmMTxCebyc1PYjQtezZWk1NPBOHIVcmy3VE6p2VfAV2KK881BM3QGhYdVDVylQdiRbpzA1eaiX5pH55ThFtvpHJcF4G+AYoODxkh2cpbbAE9nt4rogNGHwEi8HwTqdLHxBrink1Ef34985UdzvE97Gad3jjU8ighH0lXBoNVQwALp0N2axV9sw==
Received: from AS4P191CA0048.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:657::17)
 by AM9PR07MB7793.eurprd07.prod.outlook.com (2603:10a6:20b:309::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 13:17:38 +0000
Received: from AM3PEPF0000A799.eurprd04.prod.outlook.com
 (2603:10a6:20b:657:cafe::9) by AS4P191CA0048.outlook.office365.com
 (2603:10a6:20b:657::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 13:17:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM3PEPF0000A799.mail.protection.outlook.com (10.167.16.104) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Fri, 10 Oct 2025 13:17:38 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id F1FE81C0047;
	Fri, 10 Oct 2025 16:17:36 +0300 (EEST)
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
Subject: [PATCH v4 net-next 04/13] tcp: disable RFC3168 fallback identifier for CC modules
Date: Fri, 10 Oct 2025 15:17:18 +0200
Message-Id: <20251010131727.55196-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010131727.55196-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251010131727.55196-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A799:EE_|AM9PR07MB7793:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3b91b43e-34a8-4e4c-89e9-08de07ff6292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fpftAocSGSZyV3RYYV87fdxzs6+Kh7MvQGbuBVLHKX+4CjPSRMnsba2VFO+w?=
 =?us-ascii?Q?QHsffPpx2IaoM82j/OuhJLWQ6RLrE4CYsdeOnt76+U19wDbkhnNWsF6NUMZJ?=
 =?us-ascii?Q?MOby3+JB/4svvoE7HHIhMM7TOEMfjeh0VXGScB9jRVTWLJFJT8jUiI3Z1MfX?=
 =?us-ascii?Q?PgffeTboVjKoveSRN1lJgmp8HHUtyb2bWU8IWEZyvhgsdD1FJUsnwy7WMWQe?=
 =?us-ascii?Q?BuEgThJBVt8Wmnw5um6qGJ1yBd+KB3rVMkaio7yQkmOhK8iyQcy5vZ7dLKjd?=
 =?us-ascii?Q?frGHG604wLfbyFxhWAgpwHoDNArvKP9ZiN5UQICXpmRkU0pccCJS+nm87XIZ?=
 =?us-ascii?Q?0iLTRYdQxr8YMflHdea5ZmB7mHXNvSLCo1m8tLJhhvuQazHh2G7M2wC4mbVr?=
 =?us-ascii?Q?uBwClg/TUY8x83GBwDt6KoxdJJno09RezMn3WF9kIzjpLnuZ9EdFn0nUhUJe?=
 =?us-ascii?Q?H5Nrn/4gkbMRbrqXwyvgYJWsBXm5/cZZMToxCGF5CxndZmfJb4VSS5dDakp9?=
 =?us-ascii?Q?gUevujzSFq3GoX2k+fbIDGw6Z65e93Xo8WA4OBzXaXnh/TJNGHl4v0e+xLa+?=
 =?us-ascii?Q?PsEY2Lp6fsmt1d6F43IVfuNmCeMVEn+tg8pOM6T24TxtD9ZqrNQTRA/nsOY/?=
 =?us-ascii?Q?U2PUjc5pLRRUUZIHXQ46zpTu9TlwS5OQwxRk6/GBi7nGiwx5UbENzYSWNNxF?=
 =?us-ascii?Q?blHa5yf9cFAx8oGBAbCqgepbRWNC9XyWO1CUhWXkHb9Jj0WFHLkkFAqlDbVA?=
 =?us-ascii?Q?cT3o7F1VoCPyZbahwVhfrXz73YpzFB3lhqxMaplmIbpBJ3KFgZYy8w32lT2f?=
 =?us-ascii?Q?/B93B80mIO6azeRZEUPUauT9g4wfr5uNwWiXCEd131spClmXaqL6P7MKY6EQ?=
 =?us-ascii?Q?5E80GRODcDxmdpwnMA8kMcXEbW4HOy2Ps867nTgb1qnuwm3VnvcLM9uabnda?=
 =?us-ascii?Q?vx5H7SARygOKfePnB0X0hXQyyDHouGdtGhbyZE/REKi+1f+yHhizFEvIkQXQ?=
 =?us-ascii?Q?5e+7YMjeDhkDK0Us2oDK4W768dTVXZ4uUx3lKFX0xRT7DsKpa+q2g4zA1a/V?=
 =?us-ascii?Q?7MSIYgqCm4JR59ORqo0hmgNUmNy4UiYInyw5RsV8QMVXwjIcgb6WwbyP3xeY?=
 =?us-ascii?Q?5RJTbStkA1/JUzLR3y5CBFTt2MX8mMsnUZLlQKjEVVeb0EhYTbAcf7Qog8HV?=
 =?us-ascii?Q?KgkuN+hY3IAIn+FVuDYyF0O8ZjRkbM515itX5z0nHZXttVMzoe5/t5FPsvR0?=
 =?us-ascii?Q?BbSrYnCJ6Mh7NB+/fHDI7rw5n3K1MgK+rRGX/hopcXdwVZx8u+U3K9lOdzdy?=
 =?us-ascii?Q?O4IRI6fYrVa1Ab7Cz7K9hUsLHX1SMiILLRnmOWRp4/EOv4BWRZrGmDhdnvLK?=
 =?us-ascii?Q?0I1FbRsZ3QU6IrnCJd+hyOAPzdV0pR6OWZE2NDVLkicCTdS0Sn+DyFgbc+E2?=
 =?us-ascii?Q?18iHrSjAwMRPYn2rYb7U5JufwTg1Y4LUcMwfZIC1LQr2yXVSMDQNElSgdUVx?=
 =?us-ascii?Q?DMGYqEkk46ETsHIhIxtFjaQQazoZVQypE+5WG2GDleAHPuFd7TXyoA3MGG1d?=
 =?us-ascii?Q?ItfgFGJVzKF++ZV4ju0=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 13:17:38.4368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b91b43e-34a8-4e4c-89e9-08de07ff6292
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF0000A799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7793

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

When AccECN is not successfully negociated for a TCP flow, it defaults
fallback to classic ECN (RFC3168). However, L4S service will fallback
to non-ECN.

This patch enables congestion control module to control whether it
should not fallback to classic ECN after unsuccessful AccECN negotiation.
A new CA module flag (TCP_CONG_NO_FALLBACK_RFC3168) identifies this
behavior expected by the CA.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

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
index 8467c83e4aee..08ac4433535f 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1195,8 +1195,11 @@ enum tcp_ca_ack_event_flags {
 #define TCP_CONG_NEEDS_ACCECN		BIT(2)
 /* Use ECT(1) instead of ECT(0) while the CA is uninitialized */
 #define TCP_CONG_WANTS_ECT_1		BIT(3)
+/* Cannot fallback to RFC3168 during AccECN negotiation */
+#define TCP_CONG_NO_FALLBACK_RFC3168	BIT(4)
 #define TCP_CONG_MASK  (TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN | \
-			TCP_CONG_NEEDS_ACCECN | TCP_CONG_WANTS_ECT_1)
+			TCP_CONG_NEEDS_ACCECN | TCP_CONG_WANTS_ECT_1 | \
+			TCP_CONG_NO_FALLBACK_RFC3168)
 
 union tcp_cc_info;
 
@@ -1335,6 +1338,13 @@ static inline bool tcp_ca_needs_accecn(const struct sock *sk)
 	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ACCECN;
 }
 
+static inline bool tcp_ca_no_fallback_rfc3168(const struct sock *sk)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return icsk->icsk_ca_ops->flags & TCP_CONG_NO_FALLBACK_RFC3168;
+}
+
 static inline bool tcp_ca_wants_ect_1(const struct sock *sk)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 0cc698a8438c..a7ba21d298ff 100644
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
index 27fba14bb3b2..4a6abf536dbe 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6828,7 +6828,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		tp->snd_wl1    = TCP_SKB_CB(skb)->seq;
 		tp->max_window = tp->snd_wnd;
 
-		tcp_ecn_rcv_syn(tp, th, skb);
+		tcp_ecn_rcv_syn(sk, th, skb);
 
 		tcp_mtup_init(sk);
 		tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 2ec8c6f1cdcc..1fade94813c6 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -488,9 +488,10 @@ static void tcp_ecn_openreq_child(struct sock *sk,
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


