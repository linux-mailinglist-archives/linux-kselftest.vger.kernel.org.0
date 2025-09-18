Return-Path: <linux-kselftest+bounces-41872-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3B4B85F81
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 18:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D113BA32C
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 16:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05ADF318141;
	Thu, 18 Sep 2025 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="TxJPpB+w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013005.outbound.protection.outlook.com [40.107.162.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0314307AFE;
	Thu, 18 Sep 2025 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212512; cv=fail; b=nKhRLi4dOETu8UkSEDC5PIMMAh+lyG289qxbtyfSk/rQCmcnvydDqteVrOI6cX0vc9KxCUAOk3Zvlwnqv8u+mWHiOfsSVwh2QtIeW6LE5mC0Y0XpOBdmkSYH1gxlrKNpLsHS7r+tmKhpTrHizKFbV3xAwRCmVbyxLHLwMkJiTWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212512; c=relaxed/simple;
	bh=BZdF8JRzJO4WIcWgG7x0R2+1ebe9Xn846IieEKClJbc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B5cxrm/Okkql0DoK5hooylH/FIl2Sdc+lruqU4+HNJL8l0zZ01fhGDVJE8puMXwJAwa8909l08g/4MA02MGkffz75ZraEGFF+8URxUVdVubaKWPq0WIxUqm1gd+eEx3VglpZPUM+qdyeg2B3GYjLvtWL6wQpQp6oB4R1sTNdClc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=TxJPpB+w; arc=fail smtp.client-ip=40.107.162.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHgiGcOckwcwCr9EeImvFfbuY1D9/s4g2mv0nFmdSzrMW0tzyuWaivmuX1GoOxZlljTRD35yrwrto89gbR4gq/PSgfzBc9+rKW+6l9t3lBgJmfciCcbju6FBSYkIYmqIumwYI/Aw0hOHURMmVe/a2qDKa18klL+dxXBhqhNZpv1ZjDbEOSx2ZfGCiTDZS1dYe+5lzuAg6sKfZkcmY5pIq1UUhUkEkaGNH8gQkS/lidszquM1LPDwEjEKbyRxAWU5R5T6H3nUrkfw0k9NVep7oU9u1pUJoru+FbeP/qLDSoVirdNwqB4ws8PMcbKoLvyX2tlMG8mA3yJwxv69m9vqlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMSTEbd64XtsE4XbhVpiFYHh28qUjXOrwfPTp8wVQBA=;
 b=K5rxLDkRQml4vWtPu50bFEMnt7Ey3Xm/eDA6ghffaM2/+Q/bTVY/qCMbpocSHAT1LwrUkGKTx7z1G36GmWaSeYelwKopPr3kMN/N1Hwx9/d+QKJsFgvLOGOwwBuRSLWkXyg6rftUL0Uv9f1U1W43GBhlYrUZu/Dd1jjUKoIzQeRSwV9XTpxgd3qFBtdZDtcUmPd2kMhfcF3iFpR3EVWb0/ZK1VT3F3oQL9V3LxD/H3oFtohjZ2R3IjfSpIK9dXPWTE/OFUCa/ul5U8qMSSJjLT3ozyyUIQYWqL+CEPdCe6evk/UYC+An2kGnQV/k74mMKsgwYSNHYcS1t0j51cb0BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMSTEbd64XtsE4XbhVpiFYHh28qUjXOrwfPTp8wVQBA=;
 b=TxJPpB+wGzzkvHEV+aM8+T1CxbFh0CDjQHB8LRDdY5NoT7JX4JD9UubboLyplwM6PG2bjuP2Ly9bw7M/kJyAwb4XdlTfVdjmSAUVz12aosqNu4JBHSdFdy6vCAIxfYb+SDwCJFPqng7qSMryMgk3bstcSD+MI1p1dLsoAUGfUmh54DlTifgf+AVlIlaSKMyC4ZUu0Bnmqiqt3cwqwiYukCYcraxTT3ZWE6untxbS+fUgo/VbL3+9SF07W33IUOr55MSk3iuQ74OUautuTnK4BjAHm7T4NmLmxWINNNuL0mty5HpbEDvPm4bDVfOAsSdxMm+M72csEP6FjDNnYjNhqA==
Received: from AM0PR04CA0114.eurprd04.prod.outlook.com (2603:10a6:208:55::19)
 by DU0PR07MB10740.eurprd07.prod.outlook.com (2603:10a6:10:5a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 18 Sep
 2025 16:21:48 +0000
Received: from AM1PEPF000252E1.eurprd07.prod.outlook.com
 (2603:10a6:208:55:cafe::3c) by AM0PR04CA0114.outlook.office365.com
 (2603:10a6:208:55::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 16:21:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM1PEPF000252E1.mail.protection.outlook.com (10.167.16.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Thu, 18 Sep 2025 16:21:46 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id B6521200F3;
	Thu, 18 Sep 2025 19:21:44 +0300 (EEST)
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
Subject: [PATCH v2 net-next 05/14] tcp: disable RFC3168 fallback identifier for CC modules
Date: Thu, 18 Sep 2025 18:21:24 +0200
Message-Id: <20250918162133.111922-6-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252E1:EE_|DU0PR07MB10740:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2ec056b4-57b1-4d4c-0da6-08ddf6cf7672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vN+mz/TvyzG+/owR97+mBeJ09IoqLQK/Pi2GWQighFyLxPvDca4fRmA4+IH2?=
 =?us-ascii?Q?8vDGFgj5pMWpdMvSJ8Ix+/bbjL+yJNoy0npyEfC/WbBX2/DyFXNYqRjJRRdW?=
 =?us-ascii?Q?PgXkOd9mfF/dUFqFt1oZl7HUuJAFzauZ/9ApWgi5aB24KGP6oBLygnFYNNBc?=
 =?us-ascii?Q?vVCf2XRZyLx66bEklajLVXV8IxLTQrBF2ZhpVmH6WRnqTzAzqphRMv7hodpY?=
 =?us-ascii?Q?Vr2tB19OZGFJZZFkcqjtyU532PW2kyiWdg4pJfQLj1wwPIQct2pLG0wiPQgk?=
 =?us-ascii?Q?IxpVvaFba0P/HIP57AQiJ0pPJeFBDj6/rRwLR2C7E11K68ItCqO2ttI59JxZ?=
 =?us-ascii?Q?ZzCS7/QP1XZ4qd7cOVcNKc1/WxobuYgc8heAyVVSU1rJuMH6L3gAQU5npGS5?=
 =?us-ascii?Q?y8SZCFHuv7UN4wc0eb9LIm41mCWXkrm7GDom9dz9C1VTalAswv130Wz9V/kD?=
 =?us-ascii?Q?cr+LKubKR1p0WgJtlC83NaliqM+od3dNcJ1/MaKe/BSDmYgG6c7jHC/JrzR0?=
 =?us-ascii?Q?sfuC6WljaHRIvA8xJWTgOhv0opFlD4zr4EukInqmD3SbQIVSopN200V80nBX?=
 =?us-ascii?Q?pUZwiRF1n+8pRy/gIwU9qulVRrjYkv+5RtWzSEk+2ZvGlM2Bnf/OUYhcUayr?=
 =?us-ascii?Q?94vfs5wVwn/WY+m+kr4PWYlmJ5e6YlyTExpSCyM/krWDwVQ6LUZtK1h5U9dB?=
 =?us-ascii?Q?RsvnFhZo1sn/EinbBd4i/qaOb7aOxykgS+vMo/c6v9TFITmL9o1Jz9TysLzp?=
 =?us-ascii?Q?o0CHVe/BLtgp+eKJAhtcd3GxMYS5JTifqtJnX0QMAVtEoQvrG62itnSb751g?=
 =?us-ascii?Q?OKFTKRKBr3kBmhEZGEFm7CfmM7xoxwcNVJ2NzwcOCPzYw6uNb3pE4OqfAOae?=
 =?us-ascii?Q?wkHVCHcCEqEPJHLX1Bl84D6eF+SX8XP20rRHgxBwTIH3ND/lnS35GFOr6Jmo?=
 =?us-ascii?Q?b1BoOshVqpPkHFwM8Ih3G7uL+bYIdL8WcUKCBrbLE7oJIMFHTDDRBbWpzKho?=
 =?us-ascii?Q?ihxmJw2aPpRimpkFl4W0KNdk4l5/wWx5HcvGyerMaW2uufpvYXlpTaDM8sJU?=
 =?us-ascii?Q?GyX+HmXyim7tCUx3DhMzC/W6Z/Am1nDTzcHCGTD1hs1axdVqwltKMjXe6GyZ?=
 =?us-ascii?Q?wQBEJvh83Y2lv/DptxDS+bUSR4l6BcJoLkEVwy2kCK0tsq4LqwEBeU/wJAaV?=
 =?us-ascii?Q?w8E63cCcx2F8NULHVrsbBNDzJvarahj8FmdoMqZ6q8aM9mfFUC7OLM94u5Fm?=
 =?us-ascii?Q?OTWd0Ofrqs5PRcvAFE4pU4pIGz6qyuaaD3phy9kXu7zLQOCaCgBI14u6EdZk?=
 =?us-ascii?Q?JzJXPqqhs8c77uC+2ZTORSXyXKISqLhkztZh5HQoi4hkRArLAORBRRmMjUX+?=
 =?us-ascii?Q?ICZ3ztGjDTIrimG0zqAcGckU3gqE+0yok1FdLc6aLuFIAGNlQUnTTEdZ5/fm?=
 =?us-ascii?Q?UnJ3CCCPGe8gQ1Oq19aBxyVQT4RwU0NtyKfn73h+jsV83ioms3PGEe63sTty?=
 =?us-ascii?Q?vq25IsaWTK68IJrkx9K2YsBnsV0uHi3Ut7Vsbi4eoiX6Nap0jhQwiZiJzA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 16:21:46.1480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec056b4-57b1-4d4c-0da6-08ddf6cf7672
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM1PEPF000252E1.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB10740

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
 include/net/tcp.h        | 11 ++++++++++-
 include/net/tcp_ecn.h    | 10 +++++++---
 net/ipv4/tcp_input.c     |  2 +-
 net/ipv4/tcp_minisocks.c |  7 ++++---
 4 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4b255b92cb42..8458aa79f509 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1192,10 +1192,12 @@ enum tcp_ca_ack_event_flags {
 #define TCP_CONG_NEEDS_ECN		BIT(1)
 /* Require successfully negotiated AccECN capability */
 #define TCP_CONG_NEEDS_ACCECN		BIT(2)
+/* Cannot fallback to RFC3168 during AccECN negotiation */
+#define TCP_CONG_NO_FALLBACK_RFC3168	BIT(3)
 /* Use ECT(1) instead of ECT(0) while the CA is uninitialized */
 #define TCP_CONG_WANTS_ECT_1 (TCP_CONG_NEEDS_ECN | TCP_CONG_NEEDS_ACCECN)
 #define TCP_CONG_MASK  (TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN | \
-			TCP_CONG_NEEDS_ACCECN)
+			TCP_CONG_NEEDS_ACCECN | TCP_CONG_NO_FALLBACK_RFC3168)
 
 union tcp_cc_info;
 
@@ -1335,6 +1337,13 @@ static inline bool tcp_ca_needs_accecn(const struct sock *sk)
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
 	return inet_csk(sk)->icsk_ca_ops->flags & TCP_CONG_WANTS_ECT_1;
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index bde5835a30f0..fb4fcb641d24 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -501,7 +501,9 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
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
@@ -525,9 +527,10 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
 	}
 }
 
-static inline void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
+static inline void tcp_ecn_rcv_syn(struct sock *sk, const struct tcphdr *th,
 				   const struct sk_buff *skb)
 {
+	struct tcp_sock *tp = tcp_sk(sk);
 	if (tcp_ecn_mode_pending(tp)) {
 		if (!tcp_accecn_syn_requested(th)) {
 			/* Downgrade to classic ECN feedback */
@@ -539,7 +542,8 @@ static inline void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		}
 	}
-	if (tcp_ecn_mode_rfc3168(tp) && (!th->ece || !th->cwr))
+	if (tcp_ecn_mode_rfc3168(tp) &&
+	    (!th->ece || !th->cwr || tcp_ca_no_fallback_rfc3168(sk)))
 		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 }
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index b0557f72f3be..beb23dd34c5a 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6811,7 +6811,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
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


