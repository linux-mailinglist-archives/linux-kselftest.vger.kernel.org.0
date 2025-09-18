Return-Path: <linux-kselftest+bounces-41877-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEC2B85F93
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 18:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36EB84E1A35
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 16:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D5C31987E;
	Thu, 18 Sep 2025 16:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="KnQn3I/I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011048.outbound.protection.outlook.com [52.101.65.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA653195FF;
	Thu, 18 Sep 2025 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212517; cv=fail; b=FDgU/2nm6L0U+pNHELNjk29nyOqeEpK12CtkHzmoxRnoU5NCcf3xWKCus/L70AT9OJyAaNNTqjeWWg2iKVEL5Y+frN8wkIv6M9IekOCdvksS9xytMyoZr5h+XcsxacnV/wLFyOCL8h8vOwwRHDFgiGCBfXmgM6UEZw141LPyR90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212517; c=relaxed/simple;
	bh=gO2hMsPJ1uEKU03F60RNF71cAyr35rU8x+yKqDUe8SE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gaRLx1t9KEypnvfVKe0UonbtQ3R6T9qlV0xhHo6nSSnQI9E5URMyadkwVoUU3wh6ubHn8DhPHqtF00kMmxRpnnOjesQprXfV1oO+l7UhEPT7Lh8F9PN4b9G5rfNK9nAWKtr7di1WAcv2Wo6e3tuKdz0n8rbmJY6njWODPuEw0IQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=KnQn3I/I; arc=fail smtp.client-ip=52.101.65.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8+fwalwGauKa8Hf31OnneWMrSuknammHJf8CNOyKvFgC4QP0FnC46ADkXb3Q4GDm/8nVRuqcSoY1/Ep4I4HcgDFJrkDGYFi2mSRnlOYyM8N8DdPQPC9HRD/T4P6EcXg9ugFPGvVPN4N5XCmQO+7jaDt2TYoBlLQFb2vqKykHWcdG8iA4fvjkJtAsMpzAwIbVYCgycSzHknfbEcSqfQv3ekSCDcsh3dv6c/ZV7zEjz+lyHUiwP2SxtTD56ARrb/jNJUTpqPgBPvPQ5iX7YeKgT3N2Kqv9q+OgtXSVLNZ9n9iJD79pyEO6yNpHa8NADwbKfty76FsqbPAmjKbM/BBNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ILIu0iFtTS3A/9w/BzXV9ahb9BVJ5cuAcNuOaCHT9w=;
 b=yCa2rrW8lihUwLvxbnQJszNBDzytnHo/YsjfkvXgZhD4IsKJQzm1IWZJUMj+adkYuAAPwtC4dBXk38r7YVSA9Ix5L3Iy1NuQ+VzAytBtc3xGPQYbj/9tbh96tIkMRyRLhrPghhZ/CdETdxTmjfeIRFdeOFGWCNdKddvouJgRg3ZIpeuZXyKI0YYueKZBoaXNlyN9SpckRX63PF1QJIOGXkc0CjGKmTzZx2Cmuja/cmLtbwPT3mUCvPwjzfWf1gg08rbGaXV2Q8lwpAn/rpc/0YHneS2BF+yWaDI5hLQNUSLhpvfip6j66hZMpIe5mrxqO3rCB3nCAHLWjhHadZx03Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ILIu0iFtTS3A/9w/BzXV9ahb9BVJ5cuAcNuOaCHT9w=;
 b=KnQn3I/Ic+CwnZTgAyiLGQ/SAm5mSYZ6YlAbGWcN+s36LwFlHVcN32Y+/q8cFZuVNflma9LELne3Hy89qhmURX5CX9q6Il6aZpMIY0T/NXc42dRHEwTnJfebhyAmb8w/Rb5zj5Yj3jT/3XfsQVP6IbnH0882W6oucoRTI756d5WlpvkVrPxu1aPTMwL9b3PejXI8cQlZfChx9W0YVDVplm//DK54JYGGqxjNgE1eJKptRHmGFZ8GGrBMaRWlcVMJcDi5KKmEPNxmlQi/yyPqJiww3inJ0WSPcMkyvzdUJXdXE3Iw4cUAbk65b4LVnZo016X3vQ16mPPastPoUVwZ2w==
Received: from DU2P250CA0005.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::10)
 by VI1PR07MB9683.eurprd07.prod.outlook.com (2603:10a6:800:1d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 16:21:50 +0000
Received: from DU2PEPF00028D12.eurprd03.prod.outlook.com
 (2603:10a6:10:231:cafe::68) by DU2P250CA0005.outlook.office365.com
 (2603:10a6:10:231::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 16:21:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU2PEPF00028D12.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Thu, 18 Sep 2025 16:21:49 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 740AF200E5;
	Thu, 18 Sep 2025 19:21:48 +0300 (EEST)
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
Subject: [PATCH v2 net-next 07/14] tcp: accecn: retransmit downgraded SYN in AccECN negotiation
Date: Thu, 18 Sep 2025 18:21:26 +0200
Message-Id: <20250918162133.111922-8-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D12:EE_|VI1PR07MB9683:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 44fe528d-6405-4276-8762-08ddf6cf78b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y614TioT9dSF4BUK+ID9Po4dUBCzUPKbq5twgvB8IToxlQbogf836NdZTDtT?=
 =?us-ascii?Q?ny85LVDZaEA4DIk45MmVBqk1eYLSqULpErQ9NtYMSJr3jCK+6MQ9NoKlHYxT?=
 =?us-ascii?Q?w2K/AWWE+8LnPaXMg3+eendCTsBl4tkSy2HBWK0HWlyynasN1cBNNn8uErIr?=
 =?us-ascii?Q?SSWclbQIlyEExhcMjoktYUHcVWAOaR1vlGgbVTJKdBYsU81pLfPOlxF75GsX?=
 =?us-ascii?Q?cKCziycCHpMdwpASP4djzVC/gUT9Iq+rv7NGKRbBftNxcPEhN+g2GZxpavm1?=
 =?us-ascii?Q?yZ1GuFPzLc0XBYy5NWkOKAE8tufegoSG6HMApO85kKmiaNjKbJwy8/IRZ0tq?=
 =?us-ascii?Q?sMWi7n/BcDuBmidbqRY5Ddgbzh+dHGFibm3PxBaERxh/v2S8BIgyPwpsG8hV?=
 =?us-ascii?Q?HupNCb0F3j7+A8RDws/RZ3aOzEaJ9O+cUXtPoYl3BBD/Q2l/F459tY3P1K8q?=
 =?us-ascii?Q?zjnBMz+YQMq24DBYQbEGENeNeQEC7eFEvc8PGQwz6vD8Dy6rSgMWNC20KfI1?=
 =?us-ascii?Q?wjCS85Dk8CTyFr4vp07Lg8Lf5UKGUKyiX8M0UyAX1lOV2YTESkSvdqIvrj83?=
 =?us-ascii?Q?LWDIFaTy/0J82MBHoCRQliQDFHYPQCUNs3Hr8Yh8YTjdOYZfwNC1Z1ZnnhkR?=
 =?us-ascii?Q?2aOhpsuV3pspxKUC+vQik9MKXyvbRRT79SsVqp3sBobg9nmUyXlczM+jCfah?=
 =?us-ascii?Q?TFpH1om9WYgV4upzBNuWXyRZ68i0BXKdMGOL0o5vUFAB3Ndb552EU+KT/uDb?=
 =?us-ascii?Q?m93nOA4NwNLCdIFt2HfF4mrPGf7zx96g0qwYNq673ehqwwrrrsjp/6NjwjS4?=
 =?us-ascii?Q?vT8qQlJNVOa/ngiO9vX18fLa6r21zEFWY+T6GePIFXK0FuXzQKgEJsC88ctW?=
 =?us-ascii?Q?4K91e62Sf9VpUe04c8uQj/r4E1AEO68O4txbRrVFpitLX+Y4VfGHSfU7ossO?=
 =?us-ascii?Q?YhcaJBU+jvjn15TXBRs/wMxQLXBFVwvxHnsLHVPOiGsovKZ3sdkVjPkn5GRK?=
 =?us-ascii?Q?BLua2J0A+62wlX2umUBzFRYpjGgGkvV1R2vcwQvo7uhpJI5SGCYsR5tny5Dj?=
 =?us-ascii?Q?/3QBZ7bLf9Qh3j0jrwCbWgSBsWymh8zPl/HZh1VIniDkXVmOx/zaKtliOncx?=
 =?us-ascii?Q?8MR040l8NY9tT7nUSppRTk14VpyIsAephxuAIAWntf6j/zrwlsf28JBQ2910?=
 =?us-ascii?Q?Evq1de2PKsrLRw5WztEaxKmIM+L7+OHnakVjpH15CFI+39JQrc3tR7sLkuPS?=
 =?us-ascii?Q?5HQUbCOLa5bnywMxEVv5yF+GEg25esEUow3IVNy5kxKEQIzPsoYS4XTRQCN6?=
 =?us-ascii?Q?IC4hFB7sGH2LwIxAXyVmI1+9Bu0+5Pxz4uMwaMGNkrk7ykoTuYt6g9lFe1kZ?=
 =?us-ascii?Q?l7Xp99o3bIqaJ9cZMx6kzk0ecLLrrXfCkNjiA5gdbojNotNY7LDnXzLNcg2O?=
 =?us-ascii?Q?AW3+u9nvDTh/UYvlUtcaYUkVwEU4QfE6IW+P0FqgfXKHzyIiQoJlwJIOmjdA?=
 =?us-ascii?Q?Pj2PuwsBnpr80iNw9JLoGaGiQtPbQUnn8/Q235k5/Yl+bRRsY0S8KHMUXA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 16:21:49.9170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44fe528d-6405-4276-8762-08ddf6cf78b0
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028D12.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9683

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Based on AccECN spec (RFC9768), if the sender of an AccECN SYN
(the TCP Client) times out before receiving the SYN/ACK, it SHOULD
attempt to negotiate the use of AccECN at least one more time by
continuing to set all three TCP ECN flags (AE,CWR,ECE) = (1,1,1) on
the first retransmitted SYN (using the usual retransmission time-outs).

If this first retransmission also fails to be acknowledged, in
deployment scenarios where AccECN path traversal might be problematic,
the TCP Client SHOULD send subsequent retransmissions of the SYN with
the three TCP-ECN flags cleared (AE,CWR,ECE) = (0,0,0).

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_output.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 18bbb30381f0..1c372fe0e57f 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3563,12 +3563,15 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 			tcp_retrans_try_collapse(sk, skb, avail_wnd);
 	}
 
-	/* RFC3168, section 6.1.1.1. ECN fallback
-	 * As AccECN uses the same SYN flags (+ AE), this check covers both
-	 * cases.
-	 */
-	if ((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN_ECN) == TCPHDR_SYN_ECN)
-		tcp_ecn_clear_syn(sk, skb);
+	if (!tcp_ecn_mode_pending(tp) || icsk->icsk_retransmits > 1) {
+		/* RFC3168, section 6.1.1.1. ECN fallback
+		 * As AccECN uses the same SYN flags (+ AE), this check
+		 * covers both cases.
+		 */
+		if ((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN_ECN) ==
+		    TCPHDR_SYN_ECN)
+			tcp_ecn_clear_syn(sk, skb);
+	}
 
 	/* Update global and local TCP statistics. */
 	segs = tcp_skb_pcount(skb);
-- 
2.34.1


