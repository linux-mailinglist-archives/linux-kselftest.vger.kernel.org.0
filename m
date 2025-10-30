Return-Path: <linux-kselftest+bounces-44412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CDCC20AA3
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 15:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51BD9189F595
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 14:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5D728505E;
	Thu, 30 Oct 2025 14:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="tjgkbtVD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010026.outbound.protection.outlook.com [52.101.84.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C39283FDD;
	Thu, 30 Oct 2025 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834900; cv=fail; b=NOeSHAL6PhKkHShVCuqoiCglvRogT2OB1Jyd4+wtF5m1tTyOss/W3CsKBLTO8GpcIVS2jWyqbVLhnrk7FX2IDpCxl/9C0KpiMppFbyrUZsFVhtswjoBqKHRKBfhFHS7EfAaxXln/WOJEY7nvynVJcG4H8ZJCSg0dPrWW/4iLboM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834900; c=relaxed/simple;
	bh=HGYvJh57mRlKSm6HPNfzkQrHpySiYLJCs7PcbOkaqBg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QSAE6FfX80cKNvkNp1vaK7eq1pO4UZJSFoiSxyQ9qZiPpPcjmYkwhVOKzF82UQkqxetonn70B3n/O7xHfpD35yp92R0/V4MDhqZqpmGQF3AGHFX+uPoacQQTcAosIts5toIyeUwTGE5pD1mS79/WSaDJPmb0AE0zOpJ9f0USBd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=tjgkbtVD; arc=fail smtp.client-ip=52.101.84.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jvdrsKhoQHpsprGvxmxRJF3D8vF07zc+ILdrHqoB9VySjMYJS6lHIjywIrMDc/k4qLFp8hm5i2R3eYpGGuz+ro/sfalwPY7GHcsmcHagfZcBkKcVRRKX9s5D3CNqoSxpVuWkTXeqcIBQPt5267qjiO7CvxnzMH3ZyqcHy2xrO3+k4FErZr4FXsidNoDmiVoOUN7YjOmSQZJLY6fg2FDL/x+/ZH4LzIbMS5CY3HZd584eCStRpe+XyF4AXfsA4Dmus/Xd+7mZzPA/T+vbLxtuSQt5DHlEKUNoAk9/rebaRH4HGl8/PTPtl4m41nAMVOolr1SHQUi6c2j5n3ZETjhPLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Do075TrsNt8mtS9+ADiQR21Am0fode/jObVOb/5A+w=;
 b=MA+lJnbG868EkVkJCRm3lp9TgUMjR1XTlYQ1owMj4Ogoryuhzi+1Sju3oYxn6Q1HKTm7pq0ufjkkbb9+1uVZmvv/Qdg4SEnNtNGkIyrOHV76uVmTwc61l4mQTqi1txhGqk6bUY6GsfpmBuGPnhw2OoHWaAuhHs66MbZkPuIWWgDcKKCU3n3UQqTYHg5ROna/52Efj8HmGazf0pOCcMnsdR3TFrA6/nhTgFqa/T8da2PD3Wh8TNBhJgvKh3MvySvui7W6v5tctjE5MzBpaBctJwaD/dT2zU64n965lEqziMyQDQXUHqO+Y7hWJpiYlckbGhBTugpclXdjyKYbfmcJgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Do075TrsNt8mtS9+ADiQR21Am0fode/jObVOb/5A+w=;
 b=tjgkbtVDKTIPBHJfRKZnn1GMjrXxa+xqjcjgn4rA+fgm7n5vth7ii7Qr1y+WJNTs8giPte54ysbj/L7tvogzc/EbDL6hF8KpaDkCCQdVVZwbYNOC0jM9xN9ea0KzqvC6oPP73I5zKsFBFKdGQA88aAOZBCewfWSG4OUUA7Y//Ccuventp4oo6Na2ItA1oAg7kQCYIUWcyqkFqEw9YlIHjq1Q39ffeF1IAV77QeTTuqVgZ91I52KPZmKk4ZKverXs7he87A8rlQvg+GNH8H6j7eP8JiERTMc7D3zrU5rmeYsOVmP2owDH4b2C6zT4xR2YDOZPTvzYGsgqoqsS8Xu14w==
Received: from DUZPR01CA0264.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::20) by DBAPR07MB6918.eurprd07.prod.outlook.com
 (2603:10a6:10:19e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 14:34:55 +0000
Received: from DB5PEPF00014B95.eurprd02.prod.outlook.com
 (2603:10a6:10:4b9:cafe::6) by DUZPR01CA0264.outlook.office365.com
 (2603:10a6:10:4b9::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 14:35:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB5PEPF00014B95.mail.protection.outlook.com (10.167.8.233) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Thu, 30 Oct 2025 14:34:55 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id B99ED202A3;
	Thu, 30 Oct 2025 16:34:53 +0200 (EET)
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
Subject: [PATCH v5 net-next 10/14] tcp: accecn: retransmit SYN/ACK without AccECN option or non-AccECN SYN/ACK
Date: Thu, 30 Oct 2025 15:34:31 +0100
Message-Id: <20251030143435.13003-11-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B95:EE_|DBAPR07MB6918:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0b699136-fa27-4cbd-62e0-08de17c17e9f
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?QroCBbrJWaRodIXRq2uCQ5DrzNATzmiIqWr8D/X37QbLlg7graPpE9LlAHAa?=
 =?us-ascii?Q?DTb2jYFFZSWAJ37ZzQEB9wIs7M7+msocKQY65IPm2wbwJa4eFvZcephviTRo?=
 =?us-ascii?Q?E0is16iQGkOXeq1v5VWt2Bv05qVIf204yh83bYN9oyqqLGhWhM2KFX51xOKy?=
 =?us-ascii?Q?2Nq+BSXng/Et3UUoYifBlnkd4FohJvOcrkXi9k10cGPlk0xv51Q1MKFkNjAr?=
 =?us-ascii?Q?ubkCUNJMRcvpHDfnakwv8Ss6Q7b+HP3a5TR3QvmoVumLeYIZKD1EvYni5lqV?=
 =?us-ascii?Q?xozDt9mncNQP7xDg7Wy1U1kqRZjlxBqm/GVwgo4e7FpzXgw8EWYs+RU+3cjp?=
 =?us-ascii?Q?SdEhC4Fu5KSW2RK16rjrcLcISRbCx83WFHlkpHdQoHodFPB03OAayZt9NWwj?=
 =?us-ascii?Q?uyg/kpd4CqrN25PwpYBCc2nyADL5+6fHTxknPpDm5GJPrjfFYpIoRqq+Crte?=
 =?us-ascii?Q?ANPEk4luW5zktFxlFjksaSvUTi2PZBEWW9hJWT3eiUYb5L5JC6zYVfGF7M1z?=
 =?us-ascii?Q?kTJNIuGz+gDx7Vy7xxrGo66WQIVoYPt2ZxDwhxwHKKBEiuuRyDEbgHOAiN/D?=
 =?us-ascii?Q?Cm/r11qiLwUi3U9fxP9H3wIn7FA6SXf3Vv+2hD5Je0i47enx4z7YhNA8QNdf?=
 =?us-ascii?Q?Vyju2D9c9F0PEbLFRckYfU4AsAC0EaPnFgyDJOY5GXWofo3Pwtl8GfDeiX0Y?=
 =?us-ascii?Q?WTHL3dEaiTIoZRTvTsJZUudxFTBbwf3Nj5ReF8dCP5GV9HXQmM8NC7qxj7kg?=
 =?us-ascii?Q?7q2ejnj7R44DA3sK073WmsQeXV1v+ZHN82TdWgwK1sUrUM8v+dXHLfvQ8f5g?=
 =?us-ascii?Q?MH95r2/9DsSCWZIGdEog7w7wX4sm8saw5/OLgPdRcrAULK30BD+sg7OLafC9?=
 =?us-ascii?Q?8NQri6Dv9saZuy2+Ul+nI0R3DqddTTwO/LF7MmKXPTxRuf5TxR55ZTCDGDp5?=
 =?us-ascii?Q?zH4QSUVutBRnTkniuXKhxcJIN1Rj4PRyd/5e5xWgZzFRoTzVc3EQrJge40od?=
 =?us-ascii?Q?OBvc3eMQvt8+6DdmhZ13IVXlGBxgxy9Sf0Eo+MJ82XHRLBZOeeELLZtrfH50?=
 =?us-ascii?Q?Qd59mLoNCedUZto3jTcisAwNHMbzugyteGKBMzUznVXYuMLAKzSerdmS6CyH?=
 =?us-ascii?Q?rZUBJc1fHXQ05fN73wt/arvVk7zZWvA8Du6BvjkqNC6NxkhxwFua049npbTc?=
 =?us-ascii?Q?7+F8iC25m9Dtsf4SJpCScs6vi02QMzViDDS8do0gBH2uQ9rNjwX189SLzL16?=
 =?us-ascii?Q?3aU4BYTexbQd6cqGKAIbRzhnFA1Yg1CR0pudZ9Z8bipunL2s22/XdDK74kEy?=
 =?us-ascii?Q?I0kkhqM3zn3u9BVBYQQ+OkZunE8f7xfHIJS9o2Ubi+3DgWAEKO0M8WJ0GRtv?=
 =?us-ascii?Q?skb73ceMBWNi0Tyj7m0+wNmG3DqUPD35ug7XNhxHuE17tcVBMVwrYbliik8q?=
 =?us-ascii?Q?RrFKfygD3jrluR7ZPryRWkdYpYPBw1Q5t8GvLPDkljxi5iQsTRf0nj/S1jfE?=
 =?us-ascii?Q?HUIi8rS4kE/KRkvVYNMPciPYje4hKk/LjB61x/5PO2Yn2fxjs+gK2jsNLKe9?=
 =?us-ascii?Q?FJQj59RzaCrdgJeNC6a71sERedp15BpdIH5XyUAy?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 14:34:55.2880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b699136-fa27-4cbd-62e0-08de17c17e9f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB5PEPF00014B95.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6918

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

For Accurate ECN, the first SYN/ACK sent by the TCP server shall set the
ACE flag (see Table 1 of RFC9768) and the AccECN option to complete the
capability negotiation. However, if the TCP server needs to retransmit such
a SYN/ACK (for example, because it did not receive an ACK acknowledging its
SYN/ACK, or received a second SYN requesting AccECN support), the TCP server
retransmits the SYN/ACK without the AccECN option. This is because the
SYN/ACK may be lost due to congestion, or a middlebox may block the AccECN
option. Furthermore, if this retransmission also times out, to expedite
connection establishment, the TCP server should retransmit the SYN/ACK with
(AE,CWR,ECE) = (0,0,0) and without the AccECN option, while maintaining
AccECN feedback mode.

This complies with Section 3.2.3.2.2 of the AccECN specification (RFC9768).

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp_ecn.h | 14 ++++++++++----
 net/ipv4/tcp_output.c |  2 +-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index c66f0d944e1c..99d095ed01b3 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -651,10 +651,16 @@ static inline void tcp_ecn_clear_syn(struct sock *sk, struct sk_buff *skb)
 static inline void
 tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
 {
-	if (tcp_rsk(req)->accecn_ok)
-		tcp_accecn_echo_syn_ect(th, tcp_rsk(req)->syn_ect_rcv);
-	else if (inet_rsk(req)->ecn_ok)
-		th->ece = 1;
+	if (!req->num_retrans || !req->num_timeout) {
+		if (tcp_rsk(req)->accecn_ok)
+			tcp_accecn_echo_syn_ect(th, tcp_rsk(req)->syn_ect_rcv);
+		else if (inet_rsk(req)->ecn_ok)
+			th->ece = 1;
+	} else if (tcp_rsk(req)->accecn_ok) {
+		th->ae  = 0;
+		th->cwr = 0;
+		th->ece = 0;
+	}
 }
 
 static inline bool tcp_accecn_option_beacon_check(const struct sock *sk)
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 90a71556b93c..37c04da4cfb1 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1109,7 +1109,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 
 	if (treq->accecn_ok &&
 	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) &&
-	    req->num_timeout < 1 && remaining >= TCPOLEN_ACCECN_BASE) {
+	    req->num_retrans < 1 && remaining >= TCPOLEN_ACCECN_BASE) {
 		opts->use_synack_ecn_bytes = 1;
 		remaining -= tcp_options_fit_accecn(opts, 0, remaining);
 	}
-- 
2.34.1


