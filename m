Return-Path: <linux-kselftest+bounces-42530-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E1CBA5B5B
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 10:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E6FE4A797F
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 08:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056FB2D94AA;
	Sat, 27 Sep 2025 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="YmkrHRmZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011056.outbound.protection.outlook.com [40.107.130.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C422D8DD3;
	Sat, 27 Sep 2025 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758962913; cv=fail; b=SmwNxeZz3+RJR3T8B2EhqFTnZpBkyPnTJ7/MvPy1O+0qnMrt6yfiN8aWSQeswe0bUZCNi+6G45SV6zkD92jr2+qHOf2hUPP8aGPG1oqNTNPyDuMdjnHVlpiXQ+tp+vH/RKoEEh6yGnjJ5oFj3Es3oPhYb607v+YI62dtP6iQgVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758962913; c=relaxed/simple;
	bh=A2HiQqlBr8pkOAOWVEIPqdc56LBqSJ77Jmp8qmR2KfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=idoB2P0dPHie3kQRzAnF5srvKY6Kr5g/1UTduuz91y4owH9p6ukTdzjRKj/isDiAcrhaF5bhQP1L1Z6lRACTjvuDOCk0sc31YhPFviYqUNuvu/SAuXisTHXPu5uOnfqgNwXKnIYjp7h2QDsJAubl37ZvsoR1mhbdPXQjeeHeptQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=YmkrHRmZ; arc=fail smtp.client-ip=40.107.130.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5Er79qDcIMokq6Y7eWwNpkwjnNjcY5h84ip5b7q5yIBhUjoF1naZqIAALMKaasivSTA6mQxDXtleB43HDgMB5Z86x3512XWNvnbb7eN9hHD2XTdNDVGKWTnarF12VBPueGaPEll+Iy9qv9k4tSTVU/IloyDJAOMSjbmyp78GCJlow31Hf+jhQUFtmwlM+/B2D5LME8O2XgUzxi0ZUekHyoXhAbNBI1xdudO4eZtTqqxljpWMVB2gip611ISUtrDsg/h3v7qlqimTF0u7R9reKyX3xit2e7sXDpTNJNikXSq5Uylu7EiQRvnEWtdn2pC8ZXCkF5Bg0brZkKpUgGFXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rS/Wy6zL4qCyvsB1TzLmNwxXpbklPv1NS9mP7Gq6whM=;
 b=r7fcgmw83EGDqP59Rt446g+A0FRq66UdnqnXiMkHu/0NGv/x2/UrPO0Mt83+0/W2IkasEKNZjOEzUlwubYDp81HoObftjATXHMsOJbLIQfwEy9gzujRfqbzxodRMMuX0edfktJBSOkPMiBUmwqtwB0ASYe8K9ssq7HYqMXzfVf/Ojq5GvhW3c5RrPy5y9xfCxggGr1bwLepCVWIN2jt+cAM1rowhPKcF6AJG6rFbMQrq+1W64BA7bdhsSYbZZ6IraeWdqVGI8kQkiycd70OSOIrJjnuMQkGEvQJAl4qgGXlgFB+1DVyxu9gkV8Lg1VqERqrafnSu+t5wY2nVFjcYQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rS/Wy6zL4qCyvsB1TzLmNwxXpbklPv1NS9mP7Gq6whM=;
 b=YmkrHRmZHv8W0KO1dN/P5xkA3ycudxhwJp0x+MbW/Hp+n1E0xDoMKK5mb8ZztfEV5e4ya456W94EpAV8hxs14ifWsu5mRDvOMajkyGn6QnamAPpeoiJdZ9NZIlzWkR29kHMHJlthFiaCQDTxW6mR1vljjkYmAO9CdfOHY0Ejg6Wqi3BacLqsLc7Ojlr2hLP6GJGDJLs8WSyrM50MC8KMIPLkM65bwCt5d4fhqL4zuJW3fKZAY0IUnyGeLd36oUo2sOzZbqTHJncnpWcn8IPttuZHgnYkmMVEjzl7pucIjZ02wN3b8A9RykAsxRJmKp/8B3oy5u3Zea/TOQ/ydwlt7g==
Received: from DBBPR09CA0043.eurprd09.prod.outlook.com (2603:10a6:10:d4::31)
 by VI0PR07MB11234.eurprd07.prod.outlook.com (2603:10a6:800:303::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.18; Sat, 27 Sep
 2025 08:48:28 +0000
Received: from DB1PEPF000509FC.eurprd03.prod.outlook.com
 (2603:10a6:10:d4:cafe::67) by DBBPR09CA0043.outlook.office365.com
 (2603:10a6:10:d4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.12 via Frontend Transport; Sat,
 27 Sep 2025 08:48:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB1PEPF000509FC.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9
 via Frontend Transport; Sat, 27 Sep 2025 08:48:27 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 2E4C020107;
	Sat, 27 Sep 2025 11:48:26 +0300 (EEST)
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
Subject: [PATCH v3 net-next 11/12] tcp: accecn: verify ACE counter in 1st ACK after AccECN negotiation
Date: Sat, 27 Sep 2025 10:48:02 +0200
Message-Id: <20250927084803.17784-12-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250927084803.17784-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250927084803.17784-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FC:EE_|VI0PR07MB11234:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d84746b0-0f09-4a3b-1f64-08ddfda2a09e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r5kY7mjWs1p51g+0ut2HOYXSgt6sI8Jeykna1D5Lsvr0MmfqNXAia9PSKVRF?=
 =?us-ascii?Q?2LsGHxV1S6RWVqfp85OM/Fg2RKqbi8SbkLHqXN6UZePV4BXzeZ05efiVtZvM?=
 =?us-ascii?Q?Cw5Zw1WdKxowgadQp6gVM0RUxGyJWOdWto3iwYQY8LmDv3BDOr9QwUmYdhHT?=
 =?us-ascii?Q?1sjPGSfQLyVWjc38VugIUrk6PcLjaHfcF/wIKevE7AYR1/M398yoJoHNAQAt?=
 =?us-ascii?Q?TOU3EOb1FHglDYqlZRYDpMACLYFATq97xDlu9DPw+7LKZutGTswW9i366VvK?=
 =?us-ascii?Q?UPhxHu4wV8IAtqhILj25jP9IvuCEzCe2r8Zh7r5UWq13+f36zBK3PAEg8Rtg?=
 =?us-ascii?Q?V52g/E5PhmRJRVz8Qxu2GrH5G6bFoAsmdEcxuv6mEuH/qDQQ5lBrp6fb1pfU?=
 =?us-ascii?Q?4Ctb9srO44oloU+wveVjz3K6nxS/EJ3fcgqnYNbjlvIXg0Q9vobEGsNNy1T3?=
 =?us-ascii?Q?ZKF+YPAZ0DSZ7d/BZtWVyNDfVWPok8OqPI/Mxj4FFr8tlfzJ537kpGCspPzK?=
 =?us-ascii?Q?+62engygmRhrNqFDqXpilM6Ep+H1J7SZG0lpwO7jpQTKvZbusnLfM8K65vpN?=
 =?us-ascii?Q?7dGrV6F+bne4WioS6jilrv9kHs8w4ALFqKAkqNGfgek+mrQjJ5ax9p4Sjwti?=
 =?us-ascii?Q?ep9dlyDiXQPfst0OlwYWFEIXF4wIypVMsU4mgdz8gVUXJfU+DKXHkzTPPvF1?=
 =?us-ascii?Q?pebqc01U87pxpQwNPyaTgiMxfezQTM5TygmugNyXKLeagKhQ85gsnnMo5V8B?=
 =?us-ascii?Q?dyJF7EI7jZH2tDeXqWb/yQ+NRg1U3QMKy9AUz82yXUrC4OtlOpnFoSXmG6XC?=
 =?us-ascii?Q?VfeBQ3o1COGT2Zbejlb/Cb0Gda0hNy+e4L2A8ol8lXnzjqwIwvmhyUXlPS8h?=
 =?us-ascii?Q?4PTO9sDg7oAiKBn0Skg8WAXGKsIU6obuYKQ3UrJDtWuUk7va/Jv5spT3Dv3R?=
 =?us-ascii?Q?sDdRrVSzMUEbBnFO8jGH9qGDPodE2yqKaH6Jopx/SwL29/wGvd5qFWmUFhHL?=
 =?us-ascii?Q?+0FBK9D2W8S/LrmgdMMLjcnBApDh/V+8iyKxaTdCijGiYsw7DHM1LDEu5Qea?=
 =?us-ascii?Q?2spyh4b58RsB+29clr1QHBKg5XQVGfGWaQ+MfJd/XzKaVgabFEMv0Qt7M3md?=
 =?us-ascii?Q?QGVYtXVXvUXriZHYPPv6AEKXUP2mYXYwGTyOXtzXk44obxnyVF1E00A8P7NZ?=
 =?us-ascii?Q?xYMg7ag+YUHE7zuAVxZPoYtLLx1qZSecRTR3A1cz5HYe/GHnwKTlhplL5Wzk?=
 =?us-ascii?Q?DcX4PMgTzsLxjQ/n8dde2waduRZMr1ISJV4NDuMNIqqLS12AaUE01x9jkwVp?=
 =?us-ascii?Q?enkSZDRrO43V4b9apVR8Ye/lQtWLqa6ZpcaYAjPkg1EDldn468d1vuCumL9w?=
 =?us-ascii?Q?je4mLzGDpKI22e8xZyS6Z5zrjfm86w0+UkgX7FAJ108cPtqnBTC5eA8olB1g?=
 =?us-ascii?Q?YnXkpPWTj9Pc6qjJ6nT64bj2OoUpVbQJON8MDLh+Y9Q9CKU4J2fGaoKq8yJ2?=
 =?us-ascii?Q?rMAIWxLNTBvad1r6IbEferhpLpMjwSON8lqWlpxS81KzFjilUE47fG2DJUsL?=
 =?us-ascii?Q?LOju4m8joYwC6Co9u86xMksg8GuOU8el6GodvEui?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2025 08:48:27.6856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d84746b0-0f09-4a3b-1f64-08ddfda2a09e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509FC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB11234

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

After successfully negotiating AccECN mode in the handshake, check
the ACE field of the first data ACK. If zero (0b000), non-ECT packets
are sent and any response to CE marking feedback is disabled. This
follows Section 3.2.2.4 of AccECN spec (RFC9768).

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_input.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index c1a6bdb57638..3369635ee433 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -495,7 +495,7 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
 /* Returns the ECN CE delta */
 static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 				u32 delivered_pkts, u32 delivered_bytes,
-				int flag)
+				u64 prior_bytes_acked, int flag)
 {
 	u32 old_ceb = tcp_sk(sk)->delivered_ecn_bytes[INET_ECN_CE - 1];
 	const struct tcphdr *th = tcp_hdr(skb);
@@ -534,6 +534,16 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	if (flag & FLAG_SYN_ACKED)
 		return 0;
 
+	/* Verify ACE!=0 in the 1st data ACK after AccECN negotiation */
+	if ((flag & FLAG_DATA_ACKED) && prior_bytes_acked <= tp->mss_cache) {
+		if (tcp_accecn_ace(tcp_hdr(skb)) == 0x0) {
+			INET_ECN_dontxmit(sk);
+			tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV |
+						     TCP_ACCECN_OPT_FAIL_RECV);
+			return 0;
+		}
+	}
+
 	if (tp->received_ce_pending >= TCP_ACCECN_ACE_MAX_DELTA)
 		inet_csk(sk)->icsk_ack.pending |= ICSK_ACK_NOW;
 
@@ -580,13 +590,13 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 
 static u32 tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 			      u32 delivered_pkts, u32 delivered_bytes,
-			      int *flag)
+			      u64 prior_bytes_acked, int *flag)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	u32 delta;
 
 	delta = __tcp_accecn_process(sk, skb, delivered_pkts,
-				     delivered_bytes, *flag);
+				     delivered_bytes, prior_bytes_acked, *flag);
 	if (delta > 0) {
 		tcp_count_delivered_ce(tp, delta);
 		*flag |= FLAG_ECE;
@@ -3997,6 +4007,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct tcp_sacktag_state sack_state;
 	struct rate_sample rs = { .prior_delivered = 0 };
+	u64 prior_bytes_acked = tp->bytes_acked;
 	u32 prior_snd_una = tp->snd_una;
 	bool is_sack_reneg = tp->is_sack_reneg;
 	u32 ack_seq = TCP_SKB_CB(skb)->seq;
@@ -4120,7 +4131,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 		ecn_count = tcp_accecn_process(sk, skb,
 					       tp->delivered - delivered,
 					       sack_state.delivered_bytes,
-					       &flag);
+					       prior_bytes_acked, &flag);
 
 	tcp_in_ack_event(sk, flag);
 
@@ -4160,7 +4171,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 		ecn_count = tcp_accecn_process(sk, skb,
 					       tp->delivered - delivered,
 					       sack_state.delivered_bytes,
-					       &flag);
+					       prior_bytes_acked, &flag);
+
 	tcp_in_ack_event(sk, flag);
 	/* If data was DSACKed, see if we can undo a cwnd reduction. */
 	if (flag & FLAG_DSACKING_ACK) {
-- 
2.34.1


