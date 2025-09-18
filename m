Return-Path: <linux-kselftest+bounces-41881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1F6B86065
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 18:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F7CA1CC07B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 16:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4173831B811;
	Thu, 18 Sep 2025 16:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="NFf7yRqX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013004.outbound.protection.outlook.com [52.101.83.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F21A31B10C;
	Thu, 18 Sep 2025 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212526; cv=fail; b=N3nBdlky1gzMh+XgMZERfXWFFUJm15udkQKHYzJ9ZjPrPZBL8HZepAjnhMQAoBe13QFYaWARkwxncQegLKCHHwFvn7nW4H9S78KOFesIOv+Z/AtqXuLebGhcnx1Bk43TDa5Axr9VtXVjkgEsWGQy2+5c5vo7ZnEea8dzE+smTgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212526; c=relaxed/simple;
	bh=jdNJpmNm/6WpIytAaTwLjkpJKN7ovZpuA9vZgaVnu0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iCcjk/rvvmC6rGtanFpZFuLdbzHcalC6gAr5zl5YEYcJ0qCpes2icVt2lXnDyOI07lPwJyFjQol47mQcT6XNHeZV8OYbtOSRRulDZBU9pb1qc4BNKeBvIdtT82sTpW5437J4ZBZ4/r2Xk/n7uJ2giYqPWFPxcC9d8Z4VAVmzHQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=NFf7yRqX; arc=fail smtp.client-ip=52.101.83.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4frJuW43VZDVxXsr1ADyS8I58cjLOoMji32w0Gn0Csn0NWmQhV28gkpPi2YhxKlsEPkuSNPUm5nEsOqwTiYbhzsAaM0wu+NEry2/I4xbyMBKNSUP3N3sWzq2T8+oUODjdoAYSzCMZ5PLqakx3mJhptORuBnigj3anb96KzEvMwXKJjT6YH9l4NukkOeQOtHPuHL6twZiePz7SVBYYt+X2vP4E2b5XO72c/k/3+fnIv2U1sa7LB6ssMSsdgO2wonrpaTnhd9ZGu5M0N54emR6SxgIEWki+K0mSBIcOua6r+65R3fu2cJ+oMSfQyqrxXAVP1usUpFFEw7NNdSo4T9WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnBVFCrgcIYv4y1bz1f8mUazilVkoE+f2Ji6tM2hgsg=;
 b=ZSsJmc2sI6esI/NgzFjCW1V9otmU5hAne87OJ6ml2vqjEZaGJqtWmLzLLH5qXWboYz5jhpGrDBwMhmrwQqDUUHHYiclkP5BOlSisSYQTBNysBcbqC9NoK454pWO1qs+l8r6qTqt+rUGZehe6FGD8IRFihVMgvC4ssYMt41d53MdRgMyZVJhVfxQ8IhPVNb0wdOeEujPY6FM3fwka2tvo50BaLtIMST/ntPmqgvYbP41/QrFHcpz9jVLlZhCTptR4YHJMqV7cwzpsUfLtMpRRH+L3XbbjdNIEPBLmA9yjtW0LthdxcKYSs+wV48rVmoRpPPCkkrp1LfATG9IViPy4hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnBVFCrgcIYv4y1bz1f8mUazilVkoE+f2Ji6tM2hgsg=;
 b=NFf7yRqXMIk5Trmdwu6ZvcmzuGcg+ByGnGgVXPrdQ1coArLsXgpdu8mIXPk/qDsmjQG6ilRtTYhJpsYVyw3UORBkVzvUby6m2hk7R+ueGzX6+/Yln7cnktlLCUwRXOdivQQPeJXRSRu59NNreq44jxPioW+dG9sdSEWUhAgoRqGCdBKz8a3Op4gStaguYS6Kl6a9XBCt9IsDmMaUVGWwkkgRTiH3Q5XqHAEFQjm4iYjobzseyoqfDq/P91O37imRlZ/TKBp8TxLDytVh+F/6Z1gU1CLr/umNqOIF+7ZlwnFEHSSRMn7SLyTJfyAm3aVzvJ51WxoarkqfaMfBvhGsNg==
Received: from DU2PR04CA0043.eurprd04.prod.outlook.com (2603:10a6:10:234::18)
 by AS1PR07MB8406.eurprd07.prod.outlook.com (2603:10a6:20b:4c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 16:21:59 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::1c) by DU2PR04CA0043.outlook.office365.com
 (2603:10a6:10:234::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 16:21:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB1PEPF00050A00.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Thu, 18 Sep 2025 16:21:59 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id CFA4F200F3;
	Thu, 18 Sep 2025 19:21:57 +0300 (EEST)
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
Subject: [PATCH v2 net-next 12/14] tcp: accecn: verify ACE counter in 1st ACK after AccECN negotiation
Date: Thu, 18 Sep 2025 18:21:31 +0200
Message-Id: <20250918162133.111922-13-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A00:EE_|AS1PR07MB8406:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bd37aec6-12a3-45ca-53ea-08ddf6cf7e4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pa7fPIfqvss0HRI4X+fp7VtaA1R12uWcbADsLIh6SOfdBPb6lhAleo3lxmE4?=
 =?us-ascii?Q?Wa0OE+HvGAo3C546R09T+G0iKv+QULmwrdWuUltHIfSfqoU8PbXEsEQ1RJoj?=
 =?us-ascii?Q?beEsNT3QEcwgHp6f+IE0JmMMEkWcvkARKItpEt9IhN4twEcEhLLMy8nSXQF7?=
 =?us-ascii?Q?bUPJRvkmCQiyuej2iqR7iJ3dLuuGMzymaMBbgSAuem0WH9ysBGpyqopPFS4r?=
 =?us-ascii?Q?AODQ/hvyTW4mD4NTyw/ALSkFYaXh0vcOL3mjKcyZRECE3ImZ6JwnadInVk6s?=
 =?us-ascii?Q?XEP6CLUnBits+BrEV76QU8Wsl4Btzw7hi2319txp79NZXbSXTmA0Twh05Y7I?=
 =?us-ascii?Q?ajJpvZ2q/QFhPOIu3/5iCn/Q0HRfIzz1ZaAAX2ilgHRxnAauZhzZTaHUmPuj?=
 =?us-ascii?Q?1uhEphEt8IKT+M9/w0vZNuCiZTiW5iuqmn4o2ixsZasTgaecP+IC1tTSfRkD?=
 =?us-ascii?Q?7+Q3kIF41VKl82Y1uydNP3PIO+ckLeXixXjUqHDlYEKVy+44Zg/HpGmyi9dR?=
 =?us-ascii?Q?4ptjbeY2Rv0PrBmwG/yYlyyLX++7zb4XoSNevpn/wrVcWq8iMt9oMDH5/bFP?=
 =?us-ascii?Q?C5DFfojC1S/5JvLobyEI6m5EMImjJZXq4L4QkwSLwIJplzkc4Jtpe3uLU6O2?=
 =?us-ascii?Q?9xexBMGUbfh0OA2+P55oGj7maXTgO3muho7z7b9f9tntwqKjiWbHPzDVNxVA?=
 =?us-ascii?Q?o7nXVeSnfdKguG0TUyZxClzZDwLYW8uafvKnRUMu/zorjGZqFl4N8IOqpyL0?=
 =?us-ascii?Q?SR8WxkT/+XmIGzKFqGTVGNeCP2r5skH9lKOza7ld6uScjZ1oDjwZX/4+TeWO?=
 =?us-ascii?Q?e5S36MofcvhXo4Uf7QzPCSIiUd4nlV97noUIqin2yZxKvS1olv60ZfhbekjQ?=
 =?us-ascii?Q?XQ7njobMS5EuYdRD0f5WubvgaGrsxfiPwAZ/4tNG+2PusGyM4BhHREuU3KDQ?=
 =?us-ascii?Q?f2SW2aC5UOpFcnQUvqU8NDlgwEdQnZMMjSBBkPxVDVnGnYWcoUKthehN50XQ?=
 =?us-ascii?Q?rnQGB5v5c+DECGGtPvueIBUUBVdTP4q4TqwV2vn5wtzfOj8KZ0MWTXaxJ0Rl?=
 =?us-ascii?Q?cauPrjKhC8s+Y8vCSi8d7/9lvDd/LdQvDaiXOhpiCLdTYGPy0U3J1tmzYfyE?=
 =?us-ascii?Q?cb93eaBcBGd8xCFfdXvf/TLUWjDZDE6Q3AiAd0H+JDdQa94OUEj40bVmUvbb?=
 =?us-ascii?Q?t6BXLUO17hp/gk7rcJKhDhMG1EM6FrtJGdS+bwUffP1wQumr8pOPtPRmiWI2?=
 =?us-ascii?Q?V0H9tl3kyc5NmC5EZelPj3ua1WbbsXC3P3Y12vYYXDywy6Mrgt4jEYIHUmvI?=
 =?us-ascii?Q?RFXgOppsKdx+yCYaeNuGCPi8+is05kL7zASacXRoMOnUTYnKE6Qn/RYUR2eM?=
 =?us-ascii?Q?H9MrOrHhCQfUlu3Zu6UmQAlZDLjiTgG2gyCEmPjQsFzeJZ3P70GRjNUNbh9u?=
 =?us-ascii?Q?LnqGceyaUFivsRPVJ/X4hhyVeZmz5m/sn7sE1OVSgiD6/OCA4F8kq2eEinhh?=
 =?us-ascii?Q?+N6lxsWAnpi5Yyd9xqYAA1bt8B7oYQuZU4gAW6Y35Upmk54efT9jY3ZmdA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 16:21:59.3331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd37aec6-12a3-45ca-53ea-08ddf6cf7e4d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR07MB8406

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

After successfully negotiating AccECN mode in the handshake, check
the ACE field of the first data ACK. If zero (0b000), non-ECT packets
are sent and any response to CE marking feedback is disabled. This
follows Section 3.2.2.4 of AccECN spec (RFC9768).

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_input.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 752251268cbe..f250b4912a0b 100644
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
 
@@ -580,13 +590,14 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 
 static void tcp_accecn_process(struct sock *sk, struct rate_sample *rs,
 			       const struct sk_buff *skb, u32 delivered_pkts,
-			       u32 delivered_bytes, int *flag)
+			       u32 delivered_bytes, u64 prior_bytes_acked,
+			       int *flag)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	u32 delta;
 
 	delta = __tcp_accecn_process(sk, skb, delivered_pkts,
-				     delivered_bytes, *flag);
+				     delivered_bytes, prior_bytes_acked, *flag);
 	if (delta > 0) {
 		tcp_count_delivered_ce(tp, delta);
 		*flag |= FLAG_ECE;
@@ -3997,6 +4008,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct tcp_sacktag_state sack_state;
 	struct rate_sample rs = { .prior_delivered = 0, .ece_delta = 0 };
+	u64 prior_bytes_acked = tp->bytes_acked;
 	u32 prior_snd_una = tp->snd_una;
 	bool is_sack_reneg = tp->is_sack_reneg;
 	u32 ack_seq = TCP_SKB_CB(skb)->seq;
@@ -4116,7 +4128,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 
 	if (tcp_ecn_mode_accecn(tp))
 		tcp_accecn_process(sk, &rs, skb, tp->delivered - delivered,
-				   sack_state.delivered_bytes, &flag);
+				   sack_state.delivered_bytes,
+				   prior_bytes_acked, &flag);
 
 	tcp_in_ack_event(sk, flag);
 
@@ -4154,7 +4167,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 no_queue:
 	if (tcp_ecn_mode_accecn(tp))
 		tcp_accecn_process(sk, &rs, skb, tp->delivered - delivered,
-				   sack_state.delivered_bytes, &flag);
+				   sack_state.delivered_bytes,
+				   prior_bytes_acked, &flag);
 	tcp_in_ack_event(sk, flag);
 	/* If data was DSACKed, see if we can undo a cwnd reduction. */
 	if (flag & FLAG_DSACKING_ACK) {
-- 
2.34.1


