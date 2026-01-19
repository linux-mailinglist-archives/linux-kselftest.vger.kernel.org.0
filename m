Return-Path: <linux-kselftest+bounces-49399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA061D3B67B
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 20:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA7A930A1418
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 18:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818743904C4;
	Mon, 19 Jan 2026 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="jCibv7fj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011069.outbound.protection.outlook.com [40.107.130.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46BA38F935;
	Mon, 19 Jan 2026 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849155; cv=fail; b=iLcGYP9PEqTu5dq1dyn02xv+r04lPFermqPHPSIYkkOd9zlV/Na+fGn+S7CXLwPlktHuZcy4kAjtKM46SxTkzvMFidoCSlMt65e6MU08poKYuuvH7jp2jIL+okAoflCGMLlbf+WdE5W7AU8tmRugips+dEDJqQKjg9h/1U9SiIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849155; c=relaxed/simple;
	bh=qhUdabS43GHi7aEzF52u1483YECMRE5mtn+ehFpAmiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dFW4Lrmm40Aq33bve1DlcPdbdd3F0txVh9iNwvB0ZFLX5XAxLPpLKrCyXa/NgjIY1b56I2BKDV/bQHTx5yImqcSJ5XDr2CQbSLeB7lG7XhkkXIyAzX9h+CrJn4xyiNLeyURuF4iNlWzxjQDeAQRpZAjnjBMvreuaXUW8NEM8uNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=jCibv7fj; arc=fail smtp.client-ip=40.107.130.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ImZWaY9PcRl1+DB4Hzb7/v1uUZm1oS0hSA1Muls8yND1DfhXRWxrvYNWV0PyBQ9T/TN15kkG4QRkYZc4dQ742ZiYa/g4eHW9D/i3W6oRWJZvNl2g/nJTOxzBg0EvZw3U0Ho8jqjgaHKR9OejSUqn/INS5mdNIrPKFP48pvnE0g/mZY0acfxxHSWCJFcpU1lvb0QkZOxsfK+iyui/5uCgNb2cdCdPsIpxrowWitPzAmpHzLoOmPRQmrqblt8jHO4kcxzMCTd1Vb4aPyad/U9GOmWzlI7MyU2CPOXtzMebORQHopLy7migQz2gqVZfjkY2JoaCvEFImNvsSvWuuxDwtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMaz6EocwPyxDgX7qOlfzkGZa3TaxZlgX9Ex16jLXFI=;
 b=lQW5CAR8griECWmSeZosdMvBXOzf2qbXjMhXdZFV9CXUdo2woIY7u+QC1a/zaqqxnHXffW+V+rO4Ndt2Igha2tblQuDOEp6F5B3CU4e3gAjqcZ+/Cn4JObMgIWPWxeYM/Ez16IuIkMosUXMQ7HYzNcDEZiNfaG/iAICqeLvuVNnPfwRM0lrrxD+dYt0WFAIromNte0qm/FwAswEZLqhai41/S1+WIz3RJ84Q/ATHr3L6pHJrDkfxpdtMMpiNR9km0CVpvsI6X1hzbNzRGK0HzpkhVuCkPoiPSxwbPsC7TSO20kMahcKFQor8yG8PBOTqoG6Z79Z9bdDsPTRifSB/IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMaz6EocwPyxDgX7qOlfzkGZa3TaxZlgX9Ex16jLXFI=;
 b=jCibv7fjm1xA4RmJgDOnlaRlLA8ad2UTSdUDJbu/w1y87Q78aZB+dDL7e3ID9r1C4OkMtk0foQfS8K0c0mLR0yOUNFBF4o62w6G8nhLILkymAtazcGrIMdFC0OFi381vL/5Qnx89vO1c/bDFiBnZPEGsoNob7iIb8U3ismwZIhUAqKS0OVxNC3ah9wVQ/v3eAd/P33n2SfnE++ewpqUnVL59RcCMd68MYM2V3iSEOk3PfCdQoUVvZ50jNBQncxlPQyxdNwDpI6pYdb1Jwe2CRwEwBTlRPVFuRKU+BeY3/ZPLTtumVSc3zZDONlNYXoyEQkoPgCWZUofHOzJvXLBgvw==
Received: from AS4P191CA0005.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d5::15)
 by AM9PR07MB7955.eurprd07.prod.outlook.com (2603:10a6:20b:307::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 18:59:08 +0000
Received: from AM4PEPF00027A5D.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d5:cafe::31) by AS4P191CA0005.outlook.office365.com
 (2603:10a6:20b:5d5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 18:59:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM4PEPF00027A5D.mail.protection.outlook.com (10.167.16.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Mon, 19 Jan 2026 18:59:08 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id A66602053F;
	Mon, 19 Jan 2026 20:59:06 +0200 (EET)
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
Subject: [PATCH v9 net-next 06/15] tcp: accecn: handle unexpected AccECN negotiation feedback
Date: Mon, 19 Jan 2026 19:58:43 +0100
Message-Id: <20260119185852.11168-7-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A5D:EE_|AM9PR07MB7955:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: db97cbea-f771-4f89-ba59-08de578cd332
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?AmA4of2PXEg4faEEwq//ONotxZOnIzY46lpiR+1l8e98yZuul3XL/JA2Omyk?=
 =?us-ascii?Q?qEMEr9lVN7KCCq9tO0PgDax+7YAfjDWQoL5pp+Sx624OXNyvh8UzG2m/5cEm?=
 =?us-ascii?Q?ry9XlWqCaPb8ppGzw+WWX7Bnj/KhmVUTbDViqlTZhlf1vfb5Qi1MLvViQ0N2?=
 =?us-ascii?Q?KeJEXqw8A75G/JMHg47dRPXt4ZStPDuFQsKmcRHcZhB/aHOrktcqZzq7X6aP?=
 =?us-ascii?Q?LvJ2z0npyYfGhkn/jVp8xIvtnZL0gVOUVA0946VP2L5fh/8menSl+LwomCus?=
 =?us-ascii?Q?k04FOHZKLZEVgCJJJRCJXjlWhXeyPMLISJzpyAfLErSqnQoL4KBPPeJ3PPMV?=
 =?us-ascii?Q?ph/9lqYMAWuQsh6PbUK6gcuzWVi6gRCITrnRbqnSSTJ7k/G1HXxg0bNAeZS5?=
 =?us-ascii?Q?Y6FEVZjqu8Wl00i1llt/j+zj0SAG+K5eRWSoQJ9sAmeex6hef1VobMcpBJRq?=
 =?us-ascii?Q?owDRiCX9SHYWbgGpaQCRj4ag74Oj6MOp17cnUVJgIjYnmVu/wEJfDhL2Vpii?=
 =?us-ascii?Q?xhJhaa9IGQ+b9uuk6ISaVNZ7UYD97yf/SOeotNA3xuY1EdOBit2ciMowXZqC?=
 =?us-ascii?Q?Vr1c7V2elDgxQg0k+094IyL0brHArcWI3kfn0+TaA76/kWLeZo0mWEPjxX21?=
 =?us-ascii?Q?2NttW6TuPkU42hxrzcNJsRUWwSlObAMcFs+kL0XUHhxYQFm5Os3o1p8zPfj2?=
 =?us-ascii?Q?cVURI8L4ZBmBrd7XdcgVnISi8q7jDgJGOJm23q3Cg3NE5oC46byCqRcUmsL2?=
 =?us-ascii?Q?uqpmgbHJrDRsTdYt52OFjPPOVTEQ+Ufqr8vx5JBZ36fq3mJYDcK5ru2VYeVp?=
 =?us-ascii?Q?R1siYehvG3uyxzhVEJHwqG43c109DB7WuOvZa9Tuktdk7nXp/YNfQRWgF2We?=
 =?us-ascii?Q?QTZ+GkK4X1YNjX4zP2ldt5jNYd+OtmGbjLOnI0qfQObkR4/hqrNzGshbTa4w?=
 =?us-ascii?Q?UA8yOmXkR/GdKi8M7+3PCD0C3zqjpDW6zAxenZx6OWjePY0ztOxROHnHVC9K?=
 =?us-ascii?Q?VGS80MeoK4Ca7GYH5Y3RdM70ZflGH6O9AWAFwSqWoh46M5ZlcyRwyZKjRQCk?=
 =?us-ascii?Q?FH8BJrxb1lQWaR1Mt35VNskBtnMmY652m7xWm8TzUb8vzIq1HrbTl/5BU/1J?=
 =?us-ascii?Q?1vguZs7lsV0Y1ViAOH4GZQDgzkUaA8YU05qx1fW7VWiyUaW+WQuhf3tl3paR?=
 =?us-ascii?Q?CIAEnXI5F49ExLX4z/T78vRSqH5FJfAOiKb37i8O2+23tz967NukacdSh4Co?=
 =?us-ascii?Q?k1ivOohg2fbM/Ut1BUzAlcU+NIi+T2e69pZeT9TvCjRJl0CIKfpa030rMCGS?=
 =?us-ascii?Q?WWzftUzcf46FCBfJXeELLuPQNgD238HWW96Vzkg3avZZS+ySDZJYIN7g6zyH?=
 =?us-ascii?Q?ZPExQ5TcAxfIMa3QAwi/ionuMImBfhyLzEQ9tRWU9635fFr4qZNqkA6KENb8?=
 =?us-ascii?Q?dESRwtBB8GGQh6dWA1P0C/ORTJ8mVJxtxqEk8kWg1QPB8E746N5kQw7uRLPQ?=
 =?us-ascii?Q?BFGX5UJiCx4V+8V4Vdd6rPBnuYHtwaTTD6qj7vx3UfmCCK4eRVWUrMQeWLOJ?=
 =?us-ascii?Q?IX8LxrCjMx46otPa5EbXBiMAIxNZXFDkGNiuJwqhxwih62W2+pKLt7BYs5JY?=
 =?us-ascii?Q?PqbY8HJUCQZZt/nMmZDpE7mlAw+5u+O8NK1KeCHSlAeFuem0l9Rp6N7hSV8C?=
 =?us-ascii?Q?DB4Jv+W178ISX1hL+wM5ZrCm58E=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 18:59:08.2840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db97cbea-f771-4f89-ba59-08de578cd332
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00027A5D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7955

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

According to Section 3.1.2 of AccECN spec (RFC9768), if a TCP Client
has sent a SYN requesting AccECN feedback with (AE,CWR,ECE) = (1,1,1)
then receives a SYN/ACK with the currently reserved combination
(AE,CWR,ECE) = (1,0,1) but it does not have logic specific to such a
combination, the Client MUST enable AccECN mode as if the SYN/ACK
confirmed that the Server supported AccECN and as if it fed back that
the IP-ECN field on the SYN had arrived unchanged.

Fixes: 3cae34274c79 ("tcp: accecn: AccECN negotiation").
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>

---
v5:
- Add "Fixes" tag.

v3:
- Update commit message to fix old AccECN commits.
---
 include/net/tcp_ecn.h | 44 ++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 2e1637edf1d3..a709fb1756eb 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -473,6 +473,26 @@ static inline u8 tcp_accecn_option_init(const struct sk_buff *skb,
 	return TCP_ACCECN_OPT_COUNTER_SEEN;
 }
 
+static inline void tcp_ecn_rcv_synack_accecn(struct sock *sk,
+					     const struct sk_buff *skb, u8 dsf)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
+	tp->syn_ect_rcv = dsf & INET_ECN_MASK;
+	/* Demand Accurate ECN option in response to the SYN on the SYN/ACK
+	 * and the TCP server will try to send one more packet with an AccECN
+	 * Option at a later point during the connection.
+	 */
+	if (tp->rx_opt.accecn &&
+	    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+		u8 saw_opt = tcp_accecn_option_init(skb, tp->rx_opt.accecn);
+
+		tcp_accecn_saw_opt_fail_recv(tp, saw_opt);
+		tp->accecn_opt_demand = 2;
+	}
+}
+
 /* See Table 2 of the AccECN draft */
 static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb,
 				      const struct tcphdr *th, u8 ip_dsfield)
@@ -495,13 +515,11 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
 		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 		break;
 	case 0x1:
-	case 0x5:
 		/* +========+========+============+=============+
 		 * | A      | B      |  SYN/ACK   |  Feedback   |
 		 * |        |        |    B->A    |  Mode of A  |
 		 * |        |        | AE CWR ECE |             |
 		 * +========+========+============+=============+
-		 * | AccECN | Nonce  | 1   0   1  | (Reserved)  |
 		 * | AccECN | ECN    | 0   0   1  | Classic ECN |
 		 * | Nonce  | AccECN | 0   0   1  | Classic ECN |
 		 * | ECN    | AccECN | 0   0   1  | Classic ECN |
@@ -509,20 +527,20 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
 		 */
 		if (tcp_ca_no_fallback_rfc3168(sk))
 			tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
-		else if (tcp_ecn_mode_pending(tp))
-			/* Downgrade from AccECN, or requested initially */
+		else
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
 		break;
-	default:
-		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
-		tp->syn_ect_rcv = ip_dsfield & INET_ECN_MASK;
-		if (tp->rx_opt.accecn &&
-		    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
-			u8 saw_opt = tcp_accecn_option_init(skb, tp->rx_opt.accecn);
-
-			tcp_accecn_saw_opt_fail_recv(tp, saw_opt);
-			tp->accecn_opt_demand = 2;
+	case 0x5:
+		if (tcp_ecn_mode_pending(tp)) {
+			tcp_ecn_rcv_synack_accecn(sk, skb, ip_dsfield);
+			if (INET_ECN_is_ce(ip_dsfield)) {
+				tp->received_ce++;
+				tp->received_ce_pending++;
+			}
 		}
+		break;
+	default:
+		tcp_ecn_rcv_synack_accecn(sk, skb, ip_dsfield);
 		if (INET_ECN_is_ce(ip_dsfield) &&
 		    tcp_accecn_validate_syn_feedback(sk, ace,
 						     tp->syn_ect_snt)) {
-- 
2.34.1


