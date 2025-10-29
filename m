Return-Path: <linux-kselftest+bounces-44260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0607C18EC0
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 09:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B1A10507268
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 08:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBE0313537;
	Wed, 29 Oct 2025 08:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Re7tmbmn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011057.outbound.protection.outlook.com [52.101.65.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBDC31327F;
	Wed, 29 Oct 2025 08:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725199; cv=fail; b=ZQtev5Xeohv3gmsd7TWuFXSrAgHADnErYzDr05h/3xDt+9jvWgzjcs5jOZAHGHvTD9Wt3aWKNy+geWG+VmQJenZcdSj2sH7pMR2n32UToshsXonaXw2po449daerf8oaxjG9uU7DdDxDsMMeeCetDLisCujZtc+bTPQhWxhch0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725199; c=relaxed/simple;
	bh=S04ydwaBMy2Vi6fSZxjERn0vxJdouX/SP+1arVkjSTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EDzO20hAE8aMfhW+jxbLwgXaa+sHpT4wgu/Wn7vUSVrWQ/2cbAs5jkt4PeVIQo2bvyolaAgiExg3Q78XShXsZh5jVLdHfFaWSOlWfVdwVZxCfRnFX6B9iuhuuGmqBRmsI6bxuHHGysn3yN8Vl6jDiSE07cmlxBoH3w+ARwVpN/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Re7tmbmn; arc=fail smtp.client-ip=52.101.65.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=er4R98u3uPpEOitCGJ69mg1rQoSR5UCpdtq2zaQRNXqzJz26qlebxP5ulSOn5Q5wXJxlFKL+sd6kOHL/d1DPKtX3pT3QRc9EvJWBnFRzVVOXwxgisiac9OCMPrvyJJ6xfr7jsBu2juvmRA0f/nPrLLg3EusJD3qKqj2u1gKHnOy49UasQQm+Qfp8qNhsLmOB+bQgxtyDU0zv8vJ6VjUtSZ1V6bU54tN6F0LYz1wk2xfha1JZXlgoCuUKg76i5t8Zm9lM3ALuRKBbn76ZRRnkEa9qC+nk+5VnBV7hed6kggV1jT5B+F7NV3I3bIhsLdR5w2TxJanBSsVdEI9RODZ6zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxMvScUkpgxzyIKiJfYOoG0Xu2SUzXHOIgfHH0RJow8=;
 b=Bsvwb1TINNcNw3DV97FtlY46nps1+utefeYLAug3zGaJALbaUU76t+k453PuUywoeapE0njN/r1EpDpYJqhoaTrYPpyTk5ggUixhi41mCrcS4yeQAcb11pLZfvM3CLNFXVUxWxvucnbWGvBR0cZMA2j7HFAGS1r+JyTWYetpbjuEoOjn17VeXNNGQzXIvsHPSY/vqioR2hBjWyTJvCTrej3IIC29v0lqXpDF6l8FVRuDldFW2544VN1BHOVDUq2qbEhp7d4EdQPF9qBD6sqKRM79NOvA3UqXBlvwSBShXmB30bQgmMbMdlDkStiOiqwc4ivmAw/+8M5kCyI9O2emGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.241) smtp.rcpttodomain=apple.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxMvScUkpgxzyIKiJfYOoG0Xu2SUzXHOIgfHH0RJow8=;
 b=Re7tmbmnL0B7Vsan8C0SY50zZOAh+oDXrItN5NDzso6SZOpGnpwFSM/CGNk4UDNSotIVv9w7F/b7EnHnyr8oS2ObBhiAWmHzRa38gKo/w390gJjxlaaFuqOypgVk3s8HtxaeWHblxpLhMQUlwWgy9XRiR3yF34VVw7ffBf1gm8UJN8cUFW6Q/twkBEJ8sUeeVQvJsMWOA5DJ585b4d4KdqiTvTBgHoU+EUmo+Vygjf036FhDBGIlFmDylGx52eL/IgNAAfB6aeSmcIq91gzw7l8sClH4gJ9/49HxiayY6yMj09iSXseBFW1vix5mwN+MLruxdRxf1pIH4O82nJwxIw==
Received: from DUZPR01CA0112.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::11) by AM0PR07MB6338.eurprd07.prod.outlook.com
 (2603:10a6:20b:15d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 08:06:32 +0000
Received: from DU2PEPF00028D0C.eurprd03.prod.outlook.com
 (2603:10a6:10:4bb:cafe::e5) by DUZPR01CA0112.outlook.office365.com
 (2603:10a6:10:4bb::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 08:07:01 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.241) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DU2PEPF00028D0C.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Wed, 29 Oct 2025 08:06:30 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id BF937200E1;
	Wed, 29 Oct 2025 10:06:28 +0200 (EET)
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
Subject: [PATCH v5 net-next 06/14] tcp: disable RFC3168 fallback identifier for CC modules
Date: Wed, 29 Oct 2025 09:06:00 +0100
Message-Id: <20251029080608.92428-7-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029080608.92428-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251029080608.92428-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0C:EE_|AM0PR07MB6338:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5b230841-70cf-4a82-336e-08de16c21165
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?WpFvP9QEY+geyV1pU7I+lyoEd6LW0WWbJqihMh0kyHubp1h50ieyXaDSaTHJ?=
 =?us-ascii?Q?rYcCphYDTkFpwyfYTalu3Wf8XdG9CTGTPKmbrkzvP2oeOVZNh2hvI6DlZEPt?=
 =?us-ascii?Q?7zg2wpr4rtCmMZKDQFrSeSeUYc9PJ4TGW6pXZ049IrhJpPjAff4F9OQJD3h9?=
 =?us-ascii?Q?bPPQNAc5pLNmUhbu1HR24jSsmUNcCoFUXMeXMsqFfDn8L72TMBizWRUQFBXT?=
 =?us-ascii?Q?DbhGHn9xAauxL3qwW8PV+vl9ZtEK32OfpIezPup2I6k2wXgjHM//yHWeSUNk?=
 =?us-ascii?Q?S1w3fbpNQPyIf2UP6GZIxKAiQP7NZ2Y3AsAUb3RM2dCDeLszRVYsIE8RRPdW?=
 =?us-ascii?Q?nKrp2ecdD7jtrcQ8h85U9KtYSneYommY/sb/MRysCtpRV26bgHijzqRtStS5?=
 =?us-ascii?Q?YdlPn2VOPHRDEGHKfrw2evi/Pk0AWfZ8u32jTsNdouuso2JNBCNHcJsylrB5?=
 =?us-ascii?Q?F9gS/GFIh4cUzVqjgf/H5ypUnHG3NaQiW/JvClwBJM0d5ANJBOegVkKuGEVy?=
 =?us-ascii?Q?de03oBkfiq3qZKbvZRxcciOcG/S7tFMyiIMRbMzH04q0ooE9pcnBdys7yllE?=
 =?us-ascii?Q?EPZTQYUQXFrqnA81MOjru/pSLiIyTDaWFaUJwe52R1lEQmPdmq/G1Yi3DSgm?=
 =?us-ascii?Q?uhEZhxVnMby+MYI45McHhK0H9bvpqC3aOVK/4xoxXICRf/iQmXICxWYl+aW+?=
 =?us-ascii?Q?kAZLPxJGmX5a+hjgJuz01Vk3+pSxOiyX3ah8U2jhyy8V+NFHjNaPIH5IHwm2?=
 =?us-ascii?Q?1HaCTysJv9bFx5XWCgrU1WXj2nJ8h5j+AwsY5NXs1i8hUgQp6Bl/mSN17svb?=
 =?us-ascii?Q?22fWuzQTBhAKEpBa5H9LcSP+sZas+jIkx2WhCFq95dzPL1hWUXDh2SznW53T?=
 =?us-ascii?Q?VlFUhnawIt81TdjsSw+zY9ibudVcjSTT2qamRIFlLjo7Vea4t9Oj3LVVuEwV?=
 =?us-ascii?Q?GPJp91PGoo38XzEf9DaqfyYZrZ8g1+jQBOxv6mz7haPbqjv0IJcKDZp233fM?=
 =?us-ascii?Q?WfadYTDH37kLLUJ7tYyBF/DqPYLGac71BXi8dXP1Mnzzk3FlRNpkL6BtlR6/?=
 =?us-ascii?Q?uj3lAp5XjxDavhlfQO66YjKaXsZj2cmAxDo7YKVw9ARzX27YSys9CqHDDZth?=
 =?us-ascii?Q?EVecx5tsSvpk3GFhvT1OyQU577nqESj24UBLfekUahCbtF2EdVobO8kdEpKb?=
 =?us-ascii?Q?IZFPnSLzJA3hxzeyzjtjjHDv4SmVw+IjoKgYT0mxuG2pT7h7r6EyNS369rT7?=
 =?us-ascii?Q?xNCfZu0VS6tcnIVV3A9xpq/bLOlaOJKOASdOf0mrtVimZgoh+hDHmk9skHuU?=
 =?us-ascii?Q?ZYmvat6l79ZwcWAKGysbbe9gov1omTPvHQQIdX19nqYYJmVD9g6zEeAmVIOt?=
 =?us-ascii?Q?vmnFvqQECmREXPEiYjoQTrysGj97dH3J2uv9/hFwF0zbMbEhra+t9eDDc54o?=
 =?us-ascii?Q?iWmYczkqQ7r6M6iC9M0wF5zrCBxkPahYNfpCJO6I6L8hQR1mfkIlIa2FOqiG?=
 =?us-ascii?Q?naZ2sthWS7EuaBdmuCL0eHwn9KUzq16CyOaU+70KSWR5LdHL5ejVn2bXDBQ+?=
 =?us-ascii?Q?Kl93WG5nXGAj+7IA5pg=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:06:30.3656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b230841-70cf-4a82-336e-08de16c21165
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028D0C.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6338

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
index 76a67e77900d..68f835e70f44 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1200,8 +1200,11 @@ enum tcp_ca_ack_event_flags {
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
 
@@ -1340,6 +1343,13 @@ static inline bool tcp_ca_needs_accecn(const struct sock *sk)
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
index b4098d5cce48..6b10333fedd1 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6834,7 +6834,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		tp->snd_wl1    = TCP_SKB_CB(skb)->seq;
 		tp->max_window = tp->snd_wnd;
 
-		tcp_ecn_rcv_syn(tp, th, skb);
+		tcp_ecn_rcv_syn(sk, th, skb);
 
 		tcp_mtup_init(sk);
 		tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index ded2cf1f6006..512920b23968 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -486,9 +486,10 @@ static void tcp_ecn_openreq_child(struct sock *sk,
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


