Return-Path: <linux-kselftest+bounces-49024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BB065D24804
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 13:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4280730251D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 12:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AC2399A72;
	Thu, 15 Jan 2026 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="nChegnlb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013046.outbound.protection.outlook.com [52.101.83.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056FD399A70;
	Thu, 15 Jan 2026 12:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768480164; cv=fail; b=frrtJDl6mFgjKfGUfMUTgNobNjGWioB5pC4NE+M7FOdY4BmJdwE13ARcU0x3tSRrRmCFQ0EcQbpEVwxuOIoCf2tPK+78UZtLlf4adKsY6kDkpoe7gIz8LVr8IQ/4z9VCIgk1CU742fd/7tf9hQDCgaFh2JEa3RCSTA5LLtAnyho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768480164; c=relaxed/simple;
	bh=RdE0azBAqrzUooSXJD5kV5KoQVEF/9z+FqiVkbLvCGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rWdaztY11G4SkE3WmdIih7/nEY6Hoq5Qmf6X+qBSrRVJ1Lr359WBUxEHgfTTIRLpH2F4VMg5x18Hpn4YIOMQB78KBmgnpfRR2UvMBwWCacuRzbar3vUFgfFlqZ4jRk+HBIqy0PPUv8GfXGcwHtm2oQ8XUH4QHJzez6CjWVNTnec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=nChegnlb; arc=fail smtp.client-ip=52.101.83.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nCXT1KG0wnf4EnqamI0JornKQqmUNmme0tN/Nv5V7ENwImTwE8KeCkgjcHfCpcxIKcORbC0sCK4wlUE3hH+vTncO5q9/S/8Tktc+GI2ZJcetSnAdySx6WlnzLqQU8dUyzORn8xvpXk8pnV5ZZf/ezAykyCQZyLBTQVrr10zxp+qUNZ7xoJRZvAQrZUo0Gfl6hDP8f2gxJN/wWj42MpMgUjP+ncSjjqTGXauKO4gLtCOfq8+Jc3nvUjaM3yCx+Q9zhjMmG3IcbmoaVYTuBgqPZjaNQb0qPsGvC75j9ZVYhZWV0iIeTHheWdxhsTRbIheWhwkZCUuMo6VkvfH6vwvufw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g54Fi50yyPdkmNoxSeJ9cGjbIf4Ao89nYI8BgOHs2Hc=;
 b=IgFRAeK7rGOZKBIro+gIhHvFyWgUfZjlr3ac4l4h2Ya9QZJFo6W7fSm2h0VXWOw1VcRU4GpaCiaPIobEhlbZdfBka+4mSRQxHSiW+rEBiQWmmW+Lj+FcO/CnG1uM+73VS6SzWObpFdHr9+ytovZps9st+4h8XhiJYmLN+aoZRWgidPgAfH60y8flOWz5+tJ8JmNDccNg5p768SFDXTGYe9zDUIH6V4jC79JMGNwT9xT2vWTBRSYQ2d3An2UyNC97V4/Nd10odrilgqT0aSLfGgneluUKVt2O5xITTSx3Op+POAklxIgEshD2dwMhBYpsQ9lyHSCqJfm/PSERut15ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g54Fi50yyPdkmNoxSeJ9cGjbIf4Ao89nYI8BgOHs2Hc=;
 b=nChegnlb3fxuJfF0tApWX+xuYqmEzHd6pwjX4GyQDtbb17rDHGBekRKGVZnreX7n/R6VrulsgA2cwxC2n8vlbRopSAQHKGyatq88p0BHMxwbZkgvogmNsClqdy+crTJtOpdtc+xD9dhwAVIsf8FUD4BP6LohrCJIajdd3zv/Z0ymreQO9xS7xC7Bb+FkDc1aGQf/MMICWa1+fCg4KXIsPbLsuKPZGbtlxVuLVbHZx2rsmyS0Ap4Rv2SdTl5Qmg6GL2fh/qPi4JM3I/wN/rSjxkTTzWnWuZ88CZKAZ2acqvSKUJSAHSjDCyCKyBNZGt6BGZINMPK4KUCSdkrQRtWTsg==
Received: from DUZPR01CA0151.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::13) by DBAPR07MB6774.eurprd07.prod.outlook.com
 (2603:10a6:10:195::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 12:29:16 +0000
Received: from DU2PEPF00028D10.eurprd03.prod.outlook.com
 (2603:10a6:10:4bd:cafe::57) by DUZPR01CA0151.outlook.office365.com
 (2603:10a6:10:4bd::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Thu,
 15 Jan 2026 12:29:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DU2PEPF00028D10.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Thu, 15 Jan 2026 12:29:15 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 4AAAF20118;
	Thu, 15 Jan 2026 14:29:14 +0200 (EET)
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
Subject: [PATCH v8 net-next 08/14] tcp: add TCP_SYNACK_RETRANS synack_type
Date: Thu, 15 Jan 2026 13:28:40 +0100
Message-Id: <20260115122846.114576-9-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260115122846.114576-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260115122846.114576-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D10:EE_|DBAPR07MB6774:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6bba6085-1a36-4a0b-ee25-08de5431b297
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?fORrg6ZJaY4k/0NYClXeFERYzUXAPHcLddqx0Nn25dM25R5K1Dsow63VY0T3?=
 =?us-ascii?Q?ECdmPSJm684ZdAolLNqsWhBXN4Sc2A6RDb33urPnk44HULKT/t0gefhWHT0o?=
 =?us-ascii?Q?XPOz/SDaxG4leoNtypmfTddXMOf2QZ2avMGilY1TT0oRQ44+m7zkQRRJd5Nu?=
 =?us-ascii?Q?gVdwVKOMCVJCQtBl/FqlaOpbcBBTN7w3Se8u1Z1i1JaRjVpIJExpMqyW72yN?=
 =?us-ascii?Q?vtYvs1f7XzWQQTkU7ZOJPgFqBMABm+HX3bzbHqfRLAq9Wj1BtHLBsjzhupgK?=
 =?us-ascii?Q?LcZ0hD13b9B6GwjZD+cFGICaMKSKiCSBc8lvXG1385Ek0CNI1Xv3oUh1ODMc?=
 =?us-ascii?Q?KOkd30AnL4YCdjdzjBGYfNXeQx33aePka3wFHylKYsRd6K9RTA4uK8GGlsbA?=
 =?us-ascii?Q?gKXZAtECHEqXCHlkCW5sk6vrkj39VjOyHQK2psKwZaaaPJK33nVZTGb1UE6u?=
 =?us-ascii?Q?uAMZsY5V60YLYl5RMwrh06cUELFgjaHYNv0sqLmRc8GofkN7rDfPj3Uwu5yg?=
 =?us-ascii?Q?+MIFBqSdUZfJJnfXShi5TP0OvObQlXvYAMjteW5537/1dfgic2JxzQRABhYb?=
 =?us-ascii?Q?jnwJ/YASO4D73fRKbANWt3i7s5HmcuF+brkRH5P4uQc4sYw46ofDEdyltz8b?=
 =?us-ascii?Q?u/CuhIiZKP3CzgIydqTDryc4/kxyxMOXcSYPuPXRE/dE8e3h2uD0u7KkrFQ/?=
 =?us-ascii?Q?Q32jU9UY/LBDTuMhS2IZSyJtJ4TOLk8qR6QXbszA7/hE+fEYa0kqMOQjyX8k?=
 =?us-ascii?Q?YJsooFE/8OFwjb46J09XVdwMdrmGvw6ToBqgaSnAnGXuDK3x+Msd9WrRywCu?=
 =?us-ascii?Q?xWQVRXkgY1PYhmqZeNl+EKY5D6nDmwCC+KpRqEuaFisweqvz3U4Md7n1vtEk?=
 =?us-ascii?Q?E7KziDEwLU10rp31H8HHwQGhxF+jR86A4dxULAF/KoBYvjmHRLlq0a7nxWiL?=
 =?us-ascii?Q?W02iBiZ1+7aKgXfGuY2gqt/brJ8a8I1nSdvapBvhTRjmIjyiespCCrRL+RWR?=
 =?us-ascii?Q?Iv1peLRhSAvmAtgW4ZYDGWVq/P+RfiUYYd6sTvgKWkCn/0sLp76zxEJDhazf?=
 =?us-ascii?Q?otv8LXaA9NjxRyxEzzjmFa4c+L8y0RnD4FgJAExzP7o3kWt4Wwj2H993zNzb?=
 =?us-ascii?Q?qRR/9YvVGuhpGkS3M30jKGPapoNMIr4tY+4iOnQRKEkOc3htetQlaeBsjs38?=
 =?us-ascii?Q?bcakCS5F93qdNG7fANmF2nQvys/5ECmVHYDznPKVAduAHISjC9xQn8x1cjeL?=
 =?us-ascii?Q?HNr54DKdvk0+3NdyTow4+yft6xGDB4YNrgxtlVDGM1GbbImHaCpkHtDJJEPm?=
 =?us-ascii?Q?a8zY6WCIEz8ej9eK+lYqlAVBl9xZDjWTJ5TlCbklGOl/Bm4Vs+oz/iGVHNpi?=
 =?us-ascii?Q?mpA61lNNZSNACMCBsf07KW8AJacjQvCFqm8XVhoCwH7US1CHbGahxYmOYF1I?=
 =?us-ascii?Q?gggt1tCEsKUS/Vd7fD1e1quGK9IUHEbHfL1GdM+vn0mniFsqCHiUFjL0YRWE?=
 =?us-ascii?Q?11uBkeXkdC0lAAjh1/sr1/qnD7NGd+I6PtgjgYRH9YVj+C08VQXl3XFg3O39?=
 =?us-ascii?Q?78k4Zz+J3iHpijKD3XbeZ5Y+2TBIdcyQV7xS/dAbm/e5e7/yevurx96Ub6gL?=
 =?us-ascii?Q?+0do/Teamz1vYLKcPEAusIP1+RZ9INSX80UvbCiXthn7ArKWkeDFlpfhWmQH?=
 =?us-ascii?Q?dIFCXA=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 12:29:15.8802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bba6085-1a36-4a0b-ee25-08de5431b297
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028D10.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6774

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Before this patch, retransmitted SYN/ACK did not have a specific synack_type;
however, the upcoming patch needs to distinguish between retransmitted and
non-retransmitted SYN/ACK for AccECN negotiation to transmit the fallback
SYN/ACK during AccECN negotiation. Therefore, this patch introduces a new
synack_type (TCP_SYNACK_RETRANS).

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>

---
v6:
- Add new synack_type instead of moving the increment of num_retran.
---
 include/net/tcp.h     | 1 +
 net/ipv4/tcp_output.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index d0d8769e2a60..8da42222d13a 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -541,6 +541,7 @@ enum tcp_synack_type {
 	TCP_SYNACK_NORMAL,
 	TCP_SYNACK_FASTOPEN,
 	TCP_SYNACK_COOKIE,
+	TCP_SYNACK_RETRANS,
 };
 struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 				struct request_sock *req,
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 8039c726d235..5fa14a73d03f 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3921,6 +3921,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 
 	switch (synack_type) {
 	case TCP_SYNACK_NORMAL:
+	case TCP_SYNACK_RETRANS:
 		skb_set_owner_edemux(skb, req_to_sk(req));
 		break;
 	case TCP_SYNACK_COOKIE:
@@ -4606,7 +4607,7 @@ int tcp_rtx_synack(const struct sock *sk, struct request_sock *req)
 	/* Paired with WRITE_ONCE() in sock_setsockopt() */
 	if (READ_ONCE(sk->sk_txrehash) == SOCK_TXREHASH_ENABLED)
 		WRITE_ONCE(tcp_rsk(req)->txhash, net_tx_rndhash());
-	res = af_ops->send_synack(sk, NULL, &fl, req, NULL, TCP_SYNACK_NORMAL,
+	res = af_ops->send_synack(sk, NULL, &fl, req, NULL, TCP_SYNACK_RETRANS,
 				  NULL);
 	if (!res) {
 		TCP_INC_STATS(sock_net(sk), TCP_MIB_RETRANSSEGS);
-- 
2.34.1


