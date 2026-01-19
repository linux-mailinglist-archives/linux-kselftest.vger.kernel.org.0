Return-Path: <linux-kselftest+bounces-49401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFBDD3B68B
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 20:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E4F530C8263
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 18:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28683904E8;
	Mon, 19 Jan 2026 18:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="qXSK43dJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010071.outbound.protection.outlook.com [52.101.69.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11203921C0;
	Mon, 19 Jan 2026 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849160; cv=fail; b=bJdT6LSMRmC+okFqIyYTf0SnWA4tzRCzxPkyhwZtZtlaTauFot6bJvyCJ2zRkaIr9xmbMBWLVNOmI3oLzCxlLkQiMuVQl2qSseICxYbGNwf++VKfdxl4Fh04EfTFLftx7iDezD93/sA74CRry6JKKLcfblLBPAP4kfFtbJuo7M0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849160; c=relaxed/simple;
	bh=hqqW5h3aZis7Xs90ejJe5thxdAV5GTLU+JzTtigDg9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=atjnH83Yui6wVtcolrq6AaaDNME0vj0Wa0SKQQjYHYmO/QYf45B/+x5errzMqmrgsrFS2/GGOuCFcB50OiFPHGhGIYhEDdEAF/H85/cWEtlRk5247RuEEMvtEQ3rSlKsQZnrz/5Z4zTvKXihYQjEjXAOWNV4pz1TKoceFav4mqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=qXSK43dJ; arc=fail smtp.client-ip=52.101.69.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjFNsh+yZ2Lnf7+Osqw7u5DgOwLjp1QRW2Qk18d/JaEhHRSr+0EM/DFm4F8MzMGc/PydHNdQUTEbtmnuWii4vJPTzFwv2rY9YJoJDvUMgiPjdHkGoskNO/eKJbvJIgP1kUZIMouHQkoei06GGtW+asy3OBv4xm9KTqgrb07Q5bc/iRc+X17UNE2HaFXY1w1NSipAIaMolPIdeIk/bK9aHVnxIB5m11qDdMUIKrdY+hecW6SxPo9sEcK4Mb2MVIfh5wRi6SOJidDE0kphzpBg2X5efg/NV/CMNd9pGZCN4dIiHAhq8UzBNtruFsi9uCmZYXZs5AmeCx6yWGaYSVzw2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTarcG7vmQnP6XNzpbkbEJWa2YGHrUzLAZX7ccspYe4=;
 b=VgHi/gSEuBnq9knuHJLkY/hxTs3MoTO4wxQVfNzefitY1VOFTlG3DFfFo4YSkpt0HsFiMKyO+51B2/2aJbE1RbpwDdpaqGujtnFE8IPNN7ln4sA80acnWuuYnCM74n3YoeHGPXAAUpjmXzzrlbBtfRpUzgler9alOBdWhWx7y+4wvdLju/vuEK7B0uv+G23zBF6tPptG6uddVtPMzhGxNgREWZUtxFgonYtE1LgRcxExV4e41y5WxY/nFmJN4DG+DkZY4Fvhr6Y/jiR9pkLfysGPCvHXuqKV2mGlkxvoib73SV6qzmjm7pKydkQ5Nppf+Ouq6gUG0oTiPUnXT2bkvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTarcG7vmQnP6XNzpbkbEJWa2YGHrUzLAZX7ccspYe4=;
 b=qXSK43dJqCpCsVAok/8eL0Aidh+dtY+zWmzepnDSpWryRbO4RnWqlCU52TQ118YeC8ktOAAAyx1siswtBnD//jjUbSlOtJLtHi9Zk53guWIc7RZ607vpKka8ryxa164a1m6On+flfisXM2LH/rdqaeGqNoEEfTWt5z/RM8ERNeFhKijpMLk/4sgMDB4mazSLdsduFSloEUlTnZj+tE+EXhI1wOPHIRGJfNbbwNZPWSeJZSSwMSoeAHZQH/+Ks0DSAweME2VG7MhkKJUcSy9usHCDg13xkO0cEqKCFkXLfb86wYlM+lHPHf3Jeg41GOHYU9Q6RjBg6v0txCAuYOkWyw==
Received: from AS4P190CA0020.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::8)
 by DB9PR07MB11218.eurprd07.prod.outlook.com (2603:10a6:10:60c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 18:59:11 +0000
Received: from AM4PEPF00025F9B.EURPRD83.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::7e) by AS4P190CA0020.outlook.office365.com
 (2603:10a6:20b:5d0::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 18:59:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM4PEPF00025F9B.mail.protection.outlook.com (10.167.16.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.0
 via Frontend Transport; Mon, 19 Jan 2026 18:59:11 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id C1D6C20392;
	Mon, 19 Jan 2026 20:59:08 +0200 (EET)
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
Subject: [PATCH v9 net-next 07/15] tcp: accecn: retransmit downgraded SYN in AccECN negotiation
Date: Mon, 19 Jan 2026 19:58:44 +0100
Message-Id: <20260119185852.11168-8-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9B:EE_|DB9PR07MB11218:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b2aa5125-0ea7-4d15-ee73-08de578cd537
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?iYaqQVD5eWSKLHjLW+/AofhrfggBuYVf3WBOjvM7lXYN9F1iXuUR43k/U5TK?=
 =?us-ascii?Q?JpUVVMVeEsis9KssKjKKJspLQGF3QdczmRhJAacIywS69fvZ6AKJbWxxM2ML?=
 =?us-ascii?Q?wI4dhs20SJ+l4tMYs1hFHqlbOiSJV5x7wZHWwPI3+V4ecUfUDvPZb/4uKAJV?=
 =?us-ascii?Q?429/xx2ecDqAwUDIdzE4B9gJ7CFFkdoJmB4NGndj2CsxkifjfPzCbhSM7fPU?=
 =?us-ascii?Q?4O6t3s/4/oO/PEZErSAbj2ns06q7StBIpUyB66oI2/rJt7goBuKKRRXUOxQL?=
 =?us-ascii?Q?U0WF5QYygpX12CSMw7FWOK9gxNvgHASaIzL+YgdCKJjlfEndkJRMjzUizUtC?=
 =?us-ascii?Q?OCdsMYNY3E2fly8Ws24bhgxOuaGXs2bJcHBnGsBdfT9YG9HTtLTP2Hbz4Xd6?=
 =?us-ascii?Q?iFkmtY7TrCGZlY0Kd2bD2DzyhCWu7BbgHFdT/WS/7Wh3zj7PF21f35DKAoVU?=
 =?us-ascii?Q?rfwZunWH+PzJ81TnpQyZezLwj503o1Z2lGRUlIPQevCuKLW53kMxAWO39gpx?=
 =?us-ascii?Q?qjkXpCmmHkEW73UjaZejNtLpZXlmIzkDkkZO1JNqLKq/CpH5JWAToF10TF/d?=
 =?us-ascii?Q?ARR8ZvWphj9rIUKcG48A8GWqJmQkAeltxess4bIgo+0bYtjHkV1tinx1xgkD?=
 =?us-ascii?Q?zEgF2r1qYw97P+3QGciJCalkcM/HTH8Fm8/OaCXUr4pjkyZMj3ZIcnequ3jT?=
 =?us-ascii?Q?RQyGZbZtRdYt1waVlB0FnHAevS5myTbAz/XenCBE9NdrxAPLoOfTiY5Jersl?=
 =?us-ascii?Q?fyzP8itBt1qskQfVHigTW0WzizXXUUVxAQLpio+WrEZhjWll6J9Wj0/lQO3b?=
 =?us-ascii?Q?EVvS4LJrG8EesC/hdjXBpt9n96TkD+BDuc+FWTnVwe0NMyxYSkGTdpT1I1vL?=
 =?us-ascii?Q?5M7P6LPcTpNtAMpiH9yoPj8mjpnkCR0zSUsednbPp+4X83R4y8Ebcy1ajFIs?=
 =?us-ascii?Q?f1VnCtDIZnputLicYrPGnTr6DiURgwJRcQuDFx7bp9Cm39Olwon7hEBG1duB?=
 =?us-ascii?Q?DQHagCaHdRinl6ZK4lclLVVoAu3Zg83ltD9fR1EXTPd5Ck8lmEpat69SNvi5?=
 =?us-ascii?Q?vqvyhPOsLTpMKhkreLosUD/Zrd9tbvhQroHG32q8Q/1iTS8K0wTsbUICttlI?=
 =?us-ascii?Q?Jb0ybD8urQ29ffPuBpX45spBuFSSEngK0rK/EKk+QJNJ58GpK3izNaB7Kpja?=
 =?us-ascii?Q?MLRR0SqKrAYAP6oVigvQOxifscAGKZX6HTHFRtkdycr+ZoGwT3iaiGs57XRW?=
 =?us-ascii?Q?1gqFQ/X11Ea6x5SIghR5BcN8mPh5/RhgEA7WQHNvBHqwtpXA/ta4KFEoXEly?=
 =?us-ascii?Q?AuOmOqYj0NWrPZefmzoNKJmqrqhZmONxlunHOpCxYVEzg8AFH2BXCuIM1ZVB?=
 =?us-ascii?Q?LeX4w8E3Jy7b4afHDektNpIWLHxZIrwnnaWvqvhB17/Y0NS9c3ntwswuMR8t?=
 =?us-ascii?Q?f0rYPWNEc3qXb/5kX6BJK/Sp0Q0KFgHZjHBzYo9l1uSlMh1ye/ITP06KvV3/?=
 =?us-ascii?Q?ilra0xVL6WJovPCkaWCJ+apyu2bww2Eo+lXoNhRuWZHWThur/r69hKTLwzUN?=
 =?us-ascii?Q?xie1CokHjn70kH6/53XbwMSD4v40U/+mXLJAq3c0/7Hn29TXc4zJxZ88rV5d?=
 =?us-ascii?Q?ck+6++CBGvxTAlr4KydR5KjGfVJo0VvFCSRbwATk/n2Cwup0Jg4I0ME3z2wa?=
 =?us-ascii?Q?7We/a/JbXz2cXCtDABPamShIats=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 18:59:11.6711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2aa5125-0ea7-4d15-ee73-08de578cd537
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00025F9B.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB11218

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
Acked-by: Paolo Abeni <pabeni@redhat.com>

---
v5:
- Update commit message and the if condition statement.
---
 net/ipv4/tcp_output.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 256b669e8d3b..d5d695a501f8 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3606,12 +3606,15 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
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


