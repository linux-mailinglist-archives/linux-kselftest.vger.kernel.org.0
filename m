Return-Path: <linux-kselftest+bounces-49023-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F7FD247B9
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 13:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A7477302A84B
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 12:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FF6399A7E;
	Thu, 15 Jan 2026 12:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Ny21Ljq5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011007.outbound.protection.outlook.com [52.101.65.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBA2397AC5;
	Thu, 15 Jan 2026 12:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768480162; cv=fail; b=uKRymDwefmJ5BkK0ZAQ8QcG9kk/uM1vttG8g09Kq/oYCnVn94TH85hQpX/FShipXrPgS+NQxy12Ubkg9t4TfKht6IIFTqGTGXbi6G5MPMzcxu4aT/9CK+lgJphzNxQpHCqF1hCpQzcKeEh+iub91xJ2+HJAIFx9eopeQGDaUdeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768480162; c=relaxed/simple;
	bh=Tbxrku9UDXe1WskClpxfRhgbDqQVukHy16K6i4RtDXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S7tB+Gxnrl9Kkjm1Iy0Lq0yD8E6SXF+sNnV6u1kVqECTkbdDAyz869QvlcLd9uh+BkwFt43sJqgv+x+CMiGKR9RFvW+tTs96D5cPwvx3vUWE2hWW9qEeggNHFcddfeJKbUiEYHSpwaUePRnlgGKMrQs2AlUL3wy7QWXsAb8gXHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Ny21Ljq5; arc=fail smtp.client-ip=52.101.65.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NdjjFYsSvEDFFAB7vo6yJA2oR8SARwaAbAoKKGONCFopVTnFOAOsj/FgSM6EJIDe4kcP96M/RpCSzFt46RQwaNQQNnsfoiw33GTmWuQCowXMpmIOnMdMBYtNk72NZIPDL6yPSYj94uRHygGHwgI6yEA6tmuRqC/chOVeGokh8VgeuX/F1ZGASu/SAYgTpCJ5MvUyXXf00FeoWrwNv2xbe7ryEaxa5Xoz3PVGSvy8H80m4K1H7tn0r5PoKxoZ3kwPHnBGHUOM2rPKy6/4GBQys0ZH77GgbQewmbc1DgGU4tNXrG6z9KnEm0jJ03B57t8KYY0twitAtCZtDxMG+nOViQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7B1UPys3cw1Ek16aEc45ZhAPLh7QDV3dwz1Cz2M08s=;
 b=JJumyWA8kwilPHr9DbPJdwW/7L6NUfz6X1gBajYYSvMyV3V3ABULusOOgyAQbv8LVq6p815ybMf6SSP77Ziz8yH8n8uKwokb9k0wHpUep73+zAPYn0w1FlalPQxLXpX1KyTBTv+2o7t2fXGCQ9aJjYPlT6MQt+2EmIcJ/x37+yYj84XGKfycX/IQ7U8y0FnggTi+x6aLHeV1/AaW9GDCRQ9KM8KXW7a2fuByRmvyj5D4fqCVwH8XnIaaGStlMHCQBHZkJ0VrGZ8w8KNWZ3c94NhiYJt7m+ICDdRHM6utFF1nrZpSoiOXl9MLxuVKWqjqqf+XNZOFYYYP/dcvCABgzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7B1UPys3cw1Ek16aEc45ZhAPLh7QDV3dwz1Cz2M08s=;
 b=Ny21Ljq57YX523NYXUcPU78eLi8VTWLC2NPXIJtBFMaeOcBwDxvOHOhWp8I+vHySZtKwHs+UEC7LzvMZnvB8g4rom2QXvkb/8BBPAgW9N7ZQtx79Y3lsWhuWWdPRAcJ2pDmhZf/lbrfgxjobLxEhxuANxvco5AD0SCBK/mpWabQmCdzgQB6rjMVJy5ItY+XP1ZtoO9G+VB2TyUQYySsBrYItdSMJJ2EpsPjLUoSn+cef7fcXqs2m2JicflNpd2F3ajbLw1PNHP8LU4bu4s/yQEou7CLejGDcI3NGbby9HGq/8OuiKwa06SSbc6JRsIlbzheKOHe4E2eRv6nxRob6Rw==
Received: from AS4P251CA0022.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d3::14)
 by DBAPR07MB6936.eurprd07.prod.outlook.com (2603:10a6:10:17e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 12:29:14 +0000
Received: from AM2PEPF0001C715.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d3:cafe::d3) by AS4P251CA0022.outlook.office365.com
 (2603:10a6:20b:5d3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Thu,
 15 Jan 2026 12:29:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM2PEPF0001C715.mail.protection.outlook.com (10.167.16.185) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Thu, 15 Jan 2026 12:29:13 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 7B84120335;
	Thu, 15 Jan 2026 14:29:12 +0200 (EET)
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
Subject: [PATCH v8 net-next 07/14] tcp: accecn: retransmit downgraded SYN in AccECN negotiation
Date: Thu, 15 Jan 2026 13:28:39 +0100
Message-Id: <20260115122846.114576-8-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C715:EE_|DBAPR07MB6936:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ce133f49-fe64-4167-9991-08de5431b179
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?FMuFnixiCoTcvajmOaHSw0Dj+eKREPc0kqcsntwc3pPg5VuMMUdDnH7kwH3Q?=
 =?us-ascii?Q?c/O3p1yBEDw369ZYPeOoHbef/U9rGPKrE2NC6HU41chR0YLZq6xIbAVV9S7n?=
 =?us-ascii?Q?u+r+0GnYEKE26vPZQMGV55mMDv6TVjPhrcxd7W+CKo5aNuk+mxPLTwOO6ccp?=
 =?us-ascii?Q?/E4NOV2kkhqBwIcYbVPy24PD6QJ5YNBWffcu/NXQwANng10XR6saEaGRREq8?=
 =?us-ascii?Q?W/q/8pHJCCTjNUOpsDgYCoqeYOnO+L6I7cYcWPAOjqiCEmt2/giM9vAA/HLm?=
 =?us-ascii?Q?DjU6BWLZT0jQTBUNg5dcWUZEScoRnBz8FtCpoe0pLEmb8gt2QjEoOGX84LB2?=
 =?us-ascii?Q?3Txq4Bdm1dYXWn0kCUjwP7pc6V1DY8Ag6AMH+8Lj+EVnrPLlxga6aX2e5BwI?=
 =?us-ascii?Q?hvE7ZVF7W2kESIdqdKPYtTqp4+1Mew0S+f45B8yINDy/T2hcwW4Vc5XrJ8VB?=
 =?us-ascii?Q?d+UeJJkVttqHM2fB4TuEwifzY3MPRhg7C7wppuMX8UO1VGYf3f4/and6S3B7?=
 =?us-ascii?Q?uSyn6eBz4SWxje7vt3gbTo4QhYPop4AjBxSkDYgbzQREjQKP2cET8pYPnNbF?=
 =?us-ascii?Q?2rjnUDw/GextKfBK4xsx9UH5ldEOyX4ht+lw30CVNCYooc9rc3Uv1yqAgb1J?=
 =?us-ascii?Q?y5D6j3u+J5MjufqQbHLL0j0/E4UpEwDVsiCIImEEqWyoCNd9dM1T6uuhTlEl?=
 =?us-ascii?Q?/Ae8dkJ9zudfE2WhVamv+WmB34hhR70qwECNs57+t8pfCs82mwwP1bMMdb3n?=
 =?us-ascii?Q?ivElUwrgHdqIQsBDs3E4KkMHG8+aUYDEx+hw/JMHDertBTgq+hc+otQDlQLF?=
 =?us-ascii?Q?oJ6ffRbZXVXuJS2T3bKlmleHnFB1rCiieWS+Con+G8Q/XcIPNTw/6x6pz00P?=
 =?us-ascii?Q?rZrI0RPhAP4aJPIKNz65YjvYv97yOojKgESru/x1+BzRYMYM9r51Jr2VavXp?=
 =?us-ascii?Q?Z0an3asyBb2GReQasQkVgh0EJ7Fhu8raDusqNLP182OQSoe7zm3yD43CarPm?=
 =?us-ascii?Q?qe/XgBi1TYIvLuYyxnCXc88S+NXj1xuNACeoaE1wiZ948ZAzNH7pQVyYEWo4?=
 =?us-ascii?Q?1zPay3u6OqQ3ShXPlSI0A3gBLoZhwMzx4a7SVR6piXl5mvd2vNBGDmpu6TRu?=
 =?us-ascii?Q?NW6nqeEEexLanzgec/Laigm5mUmx2ifW3Jtd0oh9GfuoCgpCSuM3CPJA8QmN?=
 =?us-ascii?Q?tWUkzJKAEvgjVuKC83NUsjiKrS8+/nHKaXJ3MEMa53s+gMKs4IQ7Q0LEvQJS?=
 =?us-ascii?Q?3g3HCUYw0IyO1s6I6QduTG5KeLWnGrrT2ucuhmoXTPUrgP19QzXYq8aoet0G?=
 =?us-ascii?Q?aIJbmeEu0ohpmuH1/uXhcQP9tmlzRwv3aT/tnOfGvPpEW2OjPErcNPRvdUZ2?=
 =?us-ascii?Q?5yc+2Oy4dUkq3Hh5rFqmQxZI0hXI1fzEGXru2AqD4hxJgnaqrkbKX8vs1uTi?=
 =?us-ascii?Q?7XyCc2gPrX5QYQdaHZA6jD6m+le4M6WnHtrTLtKevw4MWT4oWJfvZcuhGUiP?=
 =?us-ascii?Q?rHxvyhDPU/QnYBetQKsaIo68JPMTUDtVFFq4BNj5gVWjaBRkFEbozIdI/X2U?=
 =?us-ascii?Q?fmdPLYggfyZs3Dp8uRjmYnDIAwi9ZoRfP3c5M+5UX+dDBsn1ENkpKd1C0Yc4?=
 =?us-ascii?Q?oulbIaLhzI9ONiA/6ciW45AnruRHfWhUSyejWTvo0+RdTYUxTUKhVPpcdwB6?=
 =?us-ascii?Q?RBfFbhQ7H/gcG+BsO3hefiZ2zt8=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 12:29:13.9902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce133f49-fe64-4167-9991-08de5431b179
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM2PEPF0001C715.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6936

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
index 479afb714bdf..8039c726d235 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3571,12 +3571,15 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
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


