Return-Path: <linux-kselftest+bounces-44410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2F6C20A8B
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 15:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425F41AA04EC
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 14:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57BE2820B1;
	Thu, 30 Oct 2025 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="koL3EgXN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013027.outbound.protection.outlook.com [52.101.72.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB6728031D;
	Thu, 30 Oct 2025 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834897; cv=fail; b=SGEV+ziC4nqLQBRNw9JP8bzjT/avvaccVIpbcNkQUIamfUBfl9PLK1USJRu2rFILqnxeQ5Wl3WFZGSyaFBERiJbLJyIUiu/PFQh+DRXKFi2Uxb8F7kG1AcWY560tAexa/6MCqOgM6Y1Lw7C7nhyjOEDaGot9Lr5tCtnFlKjYfnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834897; c=relaxed/simple;
	bh=D94ZmNU4qLo7BDdPHP07wBdhqUoXRiT/2qou8PB9ogs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SKqsDl3EHCszN2rxMwSyUlb+5nIdbhxX2xR7uQkQp69LnYjAPfZhs4xJN8n+jqKQmUHZxMCB1oPdbxFzHRAmCaVoDXFPyZ/uhztnL2RHCwP/B6w+wXMSJsj4BgA55KI9DME/BRf7lafwCwIv9GVrPTtyjcukcdNm1RK6xpLCCLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=koL3EgXN; arc=fail smtp.client-ip=52.101.72.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbYzjizVk9ChUUf3YlvYQWmBBbMnAM+XRUseNhzREo7pS8GEhAEhBo7GW9Q1imbG2aqYbo1y7YdBNBQ66Luyu6FweWt1nfg1l8U4r1uZ7G1ZZLftoOaq0tXwAQqIWjdIYF3MiSCT4rljz7uuoVbYOc0wlRZ+NHjMJid8tDDkQYy97WnvoO71o4k8dml8BUSo4rhPfb/+ctEUY4ZVlLeIsC3hsEq6ke97ReJgaQwhWGvn6iN50VuoF5jgKd7PPYKXKGGjaOJKRNBHEd+Y08PD4Vs9sEDrCM8LksFWBM7kFgK1Gl41qFzINEpjssQasYNhPz9zi85vKR9CIIy5XjFd7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEBPCu3K4Dn/VCTOXYSXoIOEzv5IGDmN0n2aaq7TkKU=;
 b=oGzRfOg71g0gJyINaWDxEC3iDuzw2hRGgBaZrG0xKIcbFYyGVmgt6OFRMqmck2PocCBcmZnVpCaKewarLD9rGG8WUgAAwvWiqRXqDC4wZk5L1fU3Ko8TVoaqFJGKNFLbXtcAuf+ievHTTtpFfi0DKJMd3IAeP4KFeSOq/N4+fh2t8aMrJJpNCukNLfrx/zIcIrf3FqOtj2a0lqvcvLUH0cQDwWazkDfCQRLaeBJHLvvn1OwkuwDoJmAGn3IHyuesBs6Mj4qid042BadFy348gftFlZh6LEtmmvUfLD+2jkMTGYGGDKQftYG2jLFcRe2LfTvaNcLYtxK9OL7QDUEo9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.241) smtp.rcpttodomain=apple.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEBPCu3K4Dn/VCTOXYSXoIOEzv5IGDmN0n2aaq7TkKU=;
 b=koL3EgXNo2MZOgLuO+6qUAZZIliCL/kkQxrnLRpf1xTuNmrFo0K2loCtEeUqjrdGd38X3FjWdyOw7viMjiHxXdNqXtWONKBDvUvHKRnl7QDlJLLNzZP4fgdHs9++CCEEKKILUZKbk+w0t1DHxudwrkrS72LnknidK42BUYJOFXlTvM1yC3+V56M3WeTwOTpRKQfCmkfnbhUDUd/C8cVhXIZzGjeumD0KeN0nkGVSFYHwuN5vafihHKNAE5+ZrF3DYKBKpzxs9SuV7zxQaL6tIx64fpo2qM5xxUSWVv5mqwTaO1JvBnPBQVRxWibQZ7/kUJl721LUjrVzTC33f/F0qQ==
Received: from DU2PR04CA0187.eurprd04.prod.outlook.com (2603:10a6:10:28d::12)
 by PR3PR07MB8051.eurprd07.prod.outlook.com (2603:10a6:102:14e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 14:34:53 +0000
Received: from DB1PEPF000509E3.eurprd03.prod.outlook.com
 (2603:10a6:10:28d:cafe::f9) by DU2PR04CA0187.outlook.office365.com
 (2603:10a6:10:28d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Thu,
 30 Oct 2025 14:34:47 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.241) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB1PEPF000509E3.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Thu, 30 Oct 2025 14:34:51 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 50F9F20103;
	Thu, 30 Oct 2025 16:34:50 +0200 (EET)
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
Subject: [PATCH v5 net-next 08/14] tcp: accecn: retransmit downgraded SYN in AccECN negotiation
Date: Thu, 30 Oct 2025 15:34:29 +0100
Message-Id: <20251030143435.13003-9-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E3:EE_|PR3PR07MB8051:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0709f524-7aa0-4154-9e4b-08de17c17c9b
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?4JdVT/1WH1FH2G3idvb/9CBymYBX5h+mrC0mhs7+B8v6ZlxWtgqOeY+loppZ?=
 =?us-ascii?Q?bgcfztrLBX8n0wYsB7GcNjU0CgXxUuPKYEmDOXs+peQuXyDbdRA7cGIeiRJM?=
 =?us-ascii?Q?EMSYOdqjZb2vOILbNIbUgZIdgvsAe3RnJ957G8nY3tp/ZNHpSwmA+xQJW5en?=
 =?us-ascii?Q?+Z5rKk0diPtb3VRKYYlLTK1DXLKWof2KgPXUFwUX6DXDApsQfro1SXzzf2/8?=
 =?us-ascii?Q?DHnz3tOlYOe06OupiHerGAhRqbyUE0QkGeO4ZTCQOKCoEuInf+jQ3VpMU8h9?=
 =?us-ascii?Q?a2u6lG3t5qpMgd2wVNSPFFLqC2VJvmzCTJofW7Pl1OyEEm/2jExGfrPKVCif?=
 =?us-ascii?Q?UaOQiWcI82+ML8mVpXd59/YKr5Pmew0fmDM+p4o1igRPAQpv1v+rydODlyYz?=
 =?us-ascii?Q?5MiV5jwxMkLKIzr+8LrndM1c/VZc3JUql6Ks5NNA9MvPhZ0H/m6vVIVV1Ds9?=
 =?us-ascii?Q?RfVPcuYf2LDWXiKbKWMN54UBvoJPGmG4KVmv/YthTHYzGkVWfY0UqbzsdIad?=
 =?us-ascii?Q?FVk5Z1O3uKEoQf1kxyuOYSlDlgAqCFutsXhSizE0mrmLQcHfbsspF1Q4fz1K?=
 =?us-ascii?Q?XdYXFq1pyl9W9MM6AO1wpVPS3+QYtn6ISYGt0frSLt1zT6MPYnUx/B4YYSzC?=
 =?us-ascii?Q?rpMykksTwSEqP5X45q0Rz5iawwImjxw4OnYFqFmVArtxRQeZ5NWBRMY2yBSB?=
 =?us-ascii?Q?0mSTtbZgzOLoXbGahapwlxH2mUdGrBiMMMfgYoiGWkZZlB1uEcBoPojwvKe7?=
 =?us-ascii?Q?C926FJBvy8+6xQpp20SesSX1RBKQL+M+EYYWx1s229R262nkByTJHyrkcCbt?=
 =?us-ascii?Q?gBBiluZNqux15Hcz/z2kWn//v5LTXtkv4mDFyUdUVrfHN9jl39dlWiKSesCT?=
 =?us-ascii?Q?UO+UPOAB+BFSbx8h1kbWeqJp36ywDQUvlQeGvPtl72S6oob8y6GyyyTaA6fu?=
 =?us-ascii?Q?81K6Keu2VkNPlriAHZ1vAwqTIDKsUbnydvdDvG6e0qFQU1VPM+RuUXUWa1QE?=
 =?us-ascii?Q?PAkBfnYpJlElHGAS99IX4VkxRP6B52pUtVHEoRvHOD5YzAQ91F5i4spgeHzd?=
 =?us-ascii?Q?syKuAlm7PMmC06ESEAqS8z0BtJDSo3NNGLY4AQp3SexO4osoeGrhJihGl+8A?=
 =?us-ascii?Q?eO3nm4quD0WyBZ9y7OYBeZ6HeWK5ciczQ+XK3XcvxrXs9cP8MhDH5iXYypGv?=
 =?us-ascii?Q?7GAj3XWcllKJgNRGD2rDvwABpDG8ikzLX5BgZcRnRcegAvn54TMx1AGq4vlA?=
 =?us-ascii?Q?HJwC4bKJVYm2QVoMrY+25PxOLBR/PUwvAmKtrd3Tz6qdYINlP27ZRfyOq2Tl?=
 =?us-ascii?Q?EFD0x0twkpgFqBFpPlFJDU5UvZ++FeuXekBOGwNO/6IxWESZzg8jRipDOWKG?=
 =?us-ascii?Q?jnN3ejQXYmbx+BUdi0KDIDp+yDhtEuGEZRSwRmu9CbeKHxwRYWI/3ez4oc5r?=
 =?us-ascii?Q?uZ/uWR5etLzIURJJRZvABbjz5bLVKUpUl7XaYrqWPCSCIcBX6ultvduK5afD?=
 =?us-ascii?Q?s6ta+cMrKRMtqAqu4aTDjUe2drhUTcU4mpkAnoT2MxBp1SP2Zblunrs7wNer?=
 =?us-ascii?Q?mAVgFu1PPckmUbrvQcaSR6ZPJgv29RKQYrfb3xmn?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 14:34:51.9079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0709f524-7aa0-4154-9e4b-08de17c17c9b
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509E3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8051

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
v5:
- Update commit message and the if condition statement.
---
 net/ipv4/tcp_output.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index d475f80b2248..71f65bb26675 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3574,12 +3574,15 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
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


