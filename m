Return-Path: <linux-kselftest+bounces-41883-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6673B86014
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 18:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B73D97E1315
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 16:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A5F31BCBD;
	Thu, 18 Sep 2025 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="M3D6VQTu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013017.outbound.protection.outlook.com [40.107.162.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B0A31197F;
	Thu, 18 Sep 2025 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212531; cv=fail; b=CHYsu0yRvVthPoWo/2PNNY9CW53ntGs/ishzWCMjkbJKzX9CGMCdGIc0R1mFPZpWPlexucZEcSKAa/qyOFiumfKvSa6FcVkIx02cO+uJl9P2LOraV0qBbmW+flxe2ea6hjMxv3fmlVL0w42YdGxu+XKN6o7qFlU9oQnGSmPO2/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212531; c=relaxed/simple;
	bh=2FbTA+6rn4V3Hyjscr2WfbgaJGWsd11NLV0GCVWViWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kKHQfkLk2m8xT1c+GsK+EOsX8+2gcPYyVlE46UawNPkZmMbcU3xmUeNllVn8oXBf8RlhXabU2zYcyqkf1nk4M+x0nfaC6yqhZnEXKx/WpMW3CLEfG66nrdz20EAxMoiIr5otMQNWm8pFqthCuxZbLJF2d+embIaBy7XhBop45lQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=M3D6VQTu; arc=fail smtp.client-ip=40.107.162.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZIvoEI/K3TGD84fcdY5+SYEydSPlwpO7C0q3oAie9Ymq82UenaibOQFuhQXtqBYr5xbtCUbXZ3FCoDmz8tNFn2fQbZ25LBlpPYvYQaqMaQOJCaDA1LMV+re0ErLhDj/z7UD6tn0HP+Yf5q6xoFZsEqDIl5ZP0YsIPySgeFHuB/TQ0PeWQQpEB1o1NNLx2uLjI+IXP7ze5pnb4AaaoB4dlp7+yFocnFdGq+cmLwjVyenYopIaB9k4irUcD7g1kBCXXI1Sk+6zeFuPRVPsPwsKscUv8umerzEKCM2HSQRktfBLoJq4bcHF9CWyTPCYByiUsv+ueDoitOMo63DJyyHVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Anf5Q6lZg3T4/yZpfbSzt26k6yj8hfW+ZkWoWFYseO0=;
 b=SVS6B2UpqZMBczPwgSGXHY0pdG1qTR7YxEN7JgZkxzlf3ZWL25LZZlrNaSe29UkNACMNTK1DVjDT/yobLmuul+6X7VNHUo9qg6xfsBEXIiHZ7F5SGIkQppwdy+tr7NFf3VLAy0SCrffTkzEj0Kq/zIMPhO+SJ0T6lDzrye6RzqToFK4cdTUpNeBBX2xGzRsKppSctB0GvujniGSNG3TDoDZ7/aXi6fIY3f2Lv8pVuuKTLGimE1kyJdZiEmJPNv9N4QklthMTe++UEB1TvR+byme8AbWIp62ujSbj8RP1sBF3U2Y34M+qP7crreBTj6WXIH9egW6fwX9Q42ZNkWtpCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Anf5Q6lZg3T4/yZpfbSzt26k6yj8hfW+ZkWoWFYseO0=;
 b=M3D6VQTurxT0d3TS6D2CWEV4xiGH0OdF/jim8RJJ9vINMieYJG3IXz6OF6Yun+E1dkU4Yq5zQrGyvb6bthyC/hyF/RlJjkbQ2dNRKGzO1hZYPMIzXnlccUNOFoCqiVZHPv0rLRk+3dYqWpNCzReW7odtHmt/+n17U0K5rfPqOhs3foYVwZ74eh+/VvQ7yEy0HeRlq1LmvDT7v4QWcAFCoafZE4pjOc+nMrzwGTe1El5aVOLPJ5Wmo2nT/9T3PQzYOPtpUPy+7V/HqYRq9Xmncf/kOQImwN8QZxC2vt71ft1viciqmu74VUCH0n1xnF8diuT1Xu95p6q184FOdQvaRg==
Received: from AM0PR02CA0177.eurprd02.prod.outlook.com (2603:10a6:20b:28e::14)
 by DB9PR07MB7226.eurprd07.prod.outlook.com (2603:10a6:10:21f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 16:22:03 +0000
Received: from AM4PEPF00027A60.eurprd04.prod.outlook.com
 (2603:10a6:20b:28e:cafe::73) by AM0PR02CA0177.outlook.office365.com
 (2603:10a6:20b:28e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 16:22:03 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.240) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM4PEPF00027A60.mail.protection.outlook.com (10.167.16.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Thu, 18 Sep 2025 16:22:01 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id AFF73200E2;
	Thu, 18 Sep 2025 19:21:59 +0300 (EEST)
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
Subject: [PATCH v2 net-next 13/14] tcp: accecn: stop sending AccECN opt when loss ACK w/ option
Date: Thu, 18 Sep 2025 18:21:32 +0200
Message-Id: <20250918162133.111922-14-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A60:EE_|DB9PR07MB7226:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 996dbb6c-40a0-4569-3663-08ddf6cf7f5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|36860700013|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G5af2+MaHRMMeqGcg5ZLS0Y38ILJ2x+5mzBKchXvKtGGFxmgeX30WwGrB9AQ?=
 =?us-ascii?Q?IqHAf7PzgxvM2aG3VLCTzdYjbvCNWOaRsmOCzGTvMSn2diKhZg/djRF8L6D1?=
 =?us-ascii?Q?BHf5WZB8RGup4qnQvnhL1m+YDD9SSqgZp6UzRI/WN5qmwt8aANbY7mDjG4r0?=
 =?us-ascii?Q?fGvZlsCLifhbEEEbR2Kd/bDoZUW1WW5Yj3zp5y//51rLsZum419ChScrNbBj?=
 =?us-ascii?Q?Nk1tf4PYHxxx2LsmyV3E2JOJX0RissWXke+0lbOiVmpwDK+oT3Qpj0+OAqbN?=
 =?us-ascii?Q?sknDRpfCK8XEX98Yy9MkNYuNbwQByltJq2/KiLqHaY4vQLz31XLmqDEqYqyg?=
 =?us-ascii?Q?bS7QvN0F3D3mZUsjW5tzl9EYmsDjuJ6Cs4NNhcvQeeJcudHIAxCgzMCfwLoR?=
 =?us-ascii?Q?ObZKCUVaQacK/jvqBESmoc4gbAuHQlgauALkA/WJI5WdQEp19cXBUT5KBZ4q?=
 =?us-ascii?Q?I/BEL6EtE3n1Xzcg1ZS46gudnI2NI6emktqUjRKPen9L79iWoCL+S7l2VXtU?=
 =?us-ascii?Q?pw/0kBl6jB24/4nzBsNsJDV1EdCtpI9aFChbkHU7NpGASniAZXI1yb1ZwuI9?=
 =?us-ascii?Q?tgpNam3HPSJ0758ytGnBNs1tpwv3mln8uUFZkymWDMPGY1NmsYagnmA1q1HX?=
 =?us-ascii?Q?1322GyMikVEo0HOpE0E4xdUGW/amAQD38Q8mZQiZmrNcrz1wYNYiAvgRtivu?=
 =?us-ascii?Q?IGC1YPmldA2kp3VVubTqrBmPVCgW+94s8T9fqG1n6vV7LVDTqksmw/p5/aDg?=
 =?us-ascii?Q?WMqX8fdC0qDgZwdrkZlaG0QOJxOKvexbR4qzHem2qahxoOyptS8kin5l6xcY?=
 =?us-ascii?Q?3MVWoXHQyWCR0cpHGWBcivYndvypa5CtH28wgrAM3jVpWZQUNh5KM+H7LaaF?=
 =?us-ascii?Q?TIDgdUZblGxx/vp77EUkT4gGokfKWrA+TFxTSzNVWvTpmjAnchLExvGxH2Se?=
 =?us-ascii?Q?UoeTItISLbrCxV4IGhI1igOcYUPl0lG6nyvNgGPBOThqyl5LS0xz84ufoXdm?=
 =?us-ascii?Q?iBYicdR8y5nhocL+PfVxgxUWhxAhg21y38+mqXhKmvQ9cUPw0aHXLD0W+mjO?=
 =?us-ascii?Q?zBZbRrSPSnZHYdntgXlJSCVHe2fnTD9SxqCG66UTX8hzBtg52kcFWOcP0fW4?=
 =?us-ascii?Q?9W1YN6i6yv5ov8D1hcG+OVZ69ZCtXUgPieYMSfSl9vB2jeSbESyc0ZOnlwS5?=
 =?us-ascii?Q?YrKS73ihDvny99BOD12otfrW5poY9+IHv1F+wHej9INdom7ddqEr7ILQsuEu?=
 =?us-ascii?Q?8P8EstM9ssu10b1Bm8KBO1PUFzfbF5oZLbs2sWuH6SZmvC5HYx8nU9PHmRhq?=
 =?us-ascii?Q?0HWqgQb7KkurtqFaApeXtYlFA3VMP7sRODcq+04SUuHYYNJyG0Eo4iqEUmI9?=
 =?us-ascii?Q?HF74KIICNTKTNRyZ7pE2NXd0n0Dtwu0KSvowGmLBZCl2LITrjFugV8Dkexcb?=
 =?us-ascii?Q?z6zJj3ZTzrLGKTTqHuoZXkutMnDgoaLOTFllhhgFDvIw+mU19dbqbDzrVDO8?=
 =?us-ascii?Q?iGUOg3WhZz/9GV8BYMcFuBv/klbiCJfF+G7WG9EuGuWSIdReA9g2RZ8zjQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(36860700013)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 16:22:01.1246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 996dbb6c-40a0-4569-3663-08ddf6cf7f5d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00027A60.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7226

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Detect spurious retransmission of a previously sent ACK carrying the
AccECN option after the second retransmission. Since this might be caused
by the middlebox dropping ACK with options it does not recognize, disable
the sending of the AccECN option in all subsequent ACKs. This patch
follows Section 3.2.3.2.2 of AccECN spec (RFC9768).

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/tcp.h   | 3 ++-
 include/net/tcp_ecn.h | 1 +
 net/ipv4/tcp_input.c  | 9 +++++++++
 net/ipv4/tcp_output.c | 3 +++
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 53a4a0da35cc..f3b72fb6fa76 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -295,7 +295,8 @@ struct tcp_sock {
 	u8	nonagle     : 4,/* Disable Nagle algorithm?             */
 		rate_app_limited:1;  /* rate_{delivered,interval_us} limited? */
 	u8	received_ce_pending:4, /* Not yet transmit cnt of received_ce */
-		unused2:4;
+		accecn_opt_sent:1,/* Sent AccECN option in previous ACK */
+		unused2:3;
 	u8	accecn_minlen:2,/* Minimum length of AccECN option sent */
 		est_ecnfield:2,/* ECN field for AccECN delivered estimates */
 		accecn_opt_demand:2,/* Demand AccECN option for n next ACKs */
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 8317c3f279c9..3eb450b4b648 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -401,6 +401,7 @@ static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 	tp->received_ce_pending = 0;
 	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
 	__tcp_accecn_init_bytes_counters(tp->delivered_ecn_bytes);
+	tp->accecn_opt_sent = 0;
 	tp->accecn_minlen = 0;
 	tp->accecn_opt_demand = 0;
 	tp->est_ecnfield = 0;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index f250b4912a0b..6083260133e9 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4804,6 +4804,7 @@ static void tcp_dsack_extend(struct sock *sk, u32 seq, u32 end_seq)
 
 static void tcp_rcv_spurious_retrans(struct sock *sk, const struct sk_buff *skb)
 {
+	struct tcp_sock *tp = tcp_sk(sk);
 	/* When the ACK path fails or drops most ACKs, the sender would
 	 * timeout and spuriously retransmit the same segment repeatedly.
 	 * If it seems our ACKs are not reaching the other side,
@@ -4823,6 +4824,14 @@ static void tcp_rcv_spurious_retrans(struct sock *sk, const struct sk_buff *skb)
 	/* Save last flowlabel after a spurious retrans. */
 	tcp_save_lrcv_flowlabel(sk, skb);
 #endif
+	/* Check DSACK info to detect that the previous ACK carrying the
+	 * AccECN option was lost after the second retransmision, and then
+	 * stop sending AccECN option in all subsequent ACKs.
+	 */
+	if (tcp_ecn_mode_accecn(tp) &&
+	    TCP_SKB_CB(skb)->seq == tp->duplicate_sack[0].start_seq &&
+	    tp->accecn_opt_sent)
+		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_OPT_FAIL_SEND);
 }
 
 static void tcp_send_dupack(struct sock *sk, const struct sk_buff *skb)
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index df07b76ba84f..a2f897b044b9 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -719,9 +719,12 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 		if (tp) {
 			tp->accecn_minlen = 0;
 			tp->accecn_opt_tstamp = tp->tcp_mstamp;
+			tp->accecn_opt_sent = 1;
 			if (tp->accecn_opt_demand)
 				tp->accecn_opt_demand--;
 		}
+	} else if (tp) {
+		tp->accecn_opt_sent = 0;
 	}
 
 	if (unlikely(OPTION_SACK_ADVERTISE & options)) {
-- 
2.34.1


