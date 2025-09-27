Return-Path: <linux-kselftest+bounces-42525-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7977DBA5B3A
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 10:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81D01189FFE0
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 08:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6709A2D7D3A;
	Sat, 27 Sep 2025 08:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="XYPw+nAw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013012.outbound.protection.outlook.com [52.101.83.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF952D73AE;
	Sat, 27 Sep 2025 08:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758962905; cv=fail; b=dn0vnN/YCSlAkSTNg/jfkGiGqOmhunIK52G95jSVzpU7x0BYDp6paq20sR2Aq2RzSLY872vm0L2bmcMSDH8E2/D71Vk/vDQXlwqICWsXyyNtYMIAG35VyMJylq1lE/0KtRiLJ4DNCk8pZZSyEgFGebGArYvFVCUV6ppWdPTUJ7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758962905; c=relaxed/simple;
	bh=2kMgIi+77IQNnDBspgFqN0KOdbGQ1+/OQ8JIxTpQr6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQ0ZQ1oQQywwp9Xte/xisfBWZY02torgUkoMMSg59Q/FARiWxBQD6lPfai08m8zT9qC+qqWlFg0HoYzo1XPsuduefd8LQwhGZGLZlxQGW+ZrqBXaTQStjw6pZIVlS0TG/EZhLshxNs5s5jfzF4abcSP4ne8z3JcQgRHbS4YUs74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=XYPw+nAw; arc=fail smtp.client-ip=52.101.83.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ThhTw+3j1sCyt62ljmd6ITrhrcmirgGP+hB8dEpdsxJuUT0I5I5FKEKEd1AOSqPhaS2el/bF6xXVwr2TsDKtLLAsIDRrB11xcsZURYoapGu2MZC+eQNZZ15CtanJVRhaAdARrgXRfpi3bUw+dn4puTdOCyYnDJcGHADUYYONvJ4gi9m3WXI4xkQKakuYDWj2OG4MjFOFHP1eYOAQupVr41rl8iHCKfTGQgmjAWuQY1+XnsumCgHIG4oJ/Vco9Hs63EbH44cdYTFgmU1XVoZ/sKyxIprZi5FL7+XR/9LRA5g4j0MB+Q3618v7oyY+VCFhAhd+uDXh97xDD5Gufkh7bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GaHuXPZcp/CMyZ9j39xv1Y1AMGVL8fIMGiZqvoPq59k=;
 b=ywDWfWv04BSGEtBPGhyaBti56HAkbIZrMyDD8f6izzcSO5jxuOBtbVQweV7lEeoCBZKYBE6uYsGXiQ4IUX0Ab9fzk3tViWK5mEg0pOQRmrx1RAQadbjwtvpaQR/fdnTmdyUS4szvMmVKuOsRVdmIOZnWrjX7XCuN7roEj2dlQP/QSCqU526tFAVryvkWuOG61N2sh0prBpawtysZoUu/aW34qpV95xOaMZinjLs+JKWC51PhStfzlxGTqxbhZ8rQxnGMZDjM25B0eXHMOahJYsgw9RsAe4P8w8RO09Mc3SMRquuNkF23edD74SMT/lOdX9reiAeVd6xZ7SdD/hU7Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaHuXPZcp/CMyZ9j39xv1Y1AMGVL8fIMGiZqvoPq59k=;
 b=XYPw+nAwT6yCRrMyBkJWEhmWq3rF2cpjQdmsJQUbgbywfH0eyHv9k7F9Uap/AiBP5KiYID4emjyM13los8W2O7i+u8hpz8psiAuaTjyiMVWd3IM8DR0rAKADrwfAk3MeDiUi+PTxHYzIU53q5Z5qD1ffs3N+CXNtDlBfieg72/dI9pHR0WtnhCo1G6Vgtn+jKgydxkWrRAVMC/h8fi7VrRobFnUo0oyhg/rpMhOyDRWfyam8QRpHwDnurAxNVV73fCCOByuzR1YtUI/5512sV8NDhhT5kj8HUgUmlDkJ3NpV1Fxm7/iDYI1jZn1MlX8ald4jOPonRDabf8J/PL50KA==
Received: from DUZPR01CA0213.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::27) by DU4PR07MB10468.eurprd07.prod.outlook.com
 (2603:10a6:10:5d3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Sat, 27 Sep
 2025 08:48:18 +0000
Received: from DB1PEPF000509ED.eurprd03.prod.outlook.com
 (2603:10a6:10:4b4:cafe::bf) by DUZPR01CA0213.outlook.office365.com
 (2603:10a6:10:4b4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.14 via Frontend Transport; Sat,
 27 Sep 2025 08:48:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB1PEPF000509ED.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9
 via Frontend Transport; Sat, 27 Sep 2025 08:48:18 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id C7188201F0;
	Sat, 27 Sep 2025 11:48:16 +0300 (EEST)
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
Subject: [PATCH v3 net-next 06/12] tcp: accecn: retransmit downgraded SYN in AccECN negotiation
Date: Sat, 27 Sep 2025 10:47:57 +0200
Message-Id: <20250927084803.17784-7-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509ED:EE_|DU4PR07MB10468:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9c7907dc-43da-4aa3-ed1f-08ddfda29b00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZfwQJnG5oSLORdoOBSs5kZ9W/NnamIP+arFU5zgyzveSZ+a611jzatE9vLmB?=
 =?us-ascii?Q?xMoV5vEEo9D6PDs9Sic0oOklMCaNv5lIAx5UwP11SPcovZ2FINsFUQsXdD9U?=
 =?us-ascii?Q?0MS5d9rNtg/iiB90bcz3kol4D6o4uZwcAgcZM03IU+imNRAHcI+pmmtqsB6z?=
 =?us-ascii?Q?6ajp0AuvaonpAtv1hpb2sC+jqTtn66Z8GNzl+66nfUWAanKpOxJIBSmxn214?=
 =?us-ascii?Q?GMKsv/Sy/uC4LSoL9M0OgfsRjX+ZBVeS7ibMWNefkErtWMTL7v2KwlKU27dl?=
 =?us-ascii?Q?ZaBK3HppAqwRus6db9F58avCrRwMJn7Vw1xp3GiLCsP78DRYji/58W5XCV/Z?=
 =?us-ascii?Q?ZYqywU7pSxyo8iD9rhJMVema2fpVBAqbB4DZCKoze9y0A/YvnawudTn3CXzH?=
 =?us-ascii?Q?3i+hs6lgTrRdCKlsGmd0cM7bX2vCrLhTrINUtWx910gg19VeXcH1nw6RJrEV?=
 =?us-ascii?Q?S2Ohz0TuxZUFh5tmKEnxThMppdFiFFVODLwdCABa7nfC6LoRTNLcswU2V5sy?=
 =?us-ascii?Q?yM4Izt8IYTfqHI263rFoPNdwjZrEpXyC0jH4bQ3wb1X20EaUj0wsr01hVH09?=
 =?us-ascii?Q?1bCjilaKn7v7K3HpCX6JiXqZ65lqqaszHrupA5/ByALoecjJ6OEIE2+jmrlU?=
 =?us-ascii?Q?e+c9NMSyfbk/RbnJpyXVDfhrP1KUR3Mp7HNjHq0uvudxLrVTUCJMW6ifXBbw?=
 =?us-ascii?Q?12s+FsaggM8HUksBcAu6ss4KXm33AF0/z+v+LV1AX5Zcxr2GA9IsYPT2wKLx?=
 =?us-ascii?Q?T87GPeUy412LXaeCkJHMk9OBqS4wAv7wtsBQ+keLuwLtf7rAK2CYD+V1F/I+?=
 =?us-ascii?Q?9/wL7NoedKn5gxdy3Co1Q0XNTKOWCWpELlXGN5rGCNbx6B+v/NG1iK7tTv+R?=
 =?us-ascii?Q?h3bzdUj9CdRUeCCdkkgdo/8HXsK1utdc4K/234cxl7SzBXws2cPZ6yCycas6?=
 =?us-ascii?Q?VjwLFy28dStpiBEOTfocA3sB1NhbKrGOHsjfp7OPH9QcHycFHb1CioQ/XUwI?=
 =?us-ascii?Q?QugsG4Rl0hQAE7qEQoZiOIIk7OfqRzB7uxNtxww+XPyHAyTGdih8NMdQQ63B?=
 =?us-ascii?Q?mJnefvYDGaRtJJHsAVSuGKAo9oihvWnNdH5UnIkJrxDp9prjCq7ujYWLecPr?=
 =?us-ascii?Q?E73B+jrJC/RU3qdJPE1GoolrpWuS1CydHtaX+tWd9brSCsesUADSkcrP5tid?=
 =?us-ascii?Q?49W/3UUdv8gESR0jNfGcJSuGNAm3L1WYVFA9i/IO0WmOaYUjq4A5AaYuiTfM?=
 =?us-ascii?Q?wLc8uHPEj5c4KzpfHK/1LHNbrw8RggNPax6MatV1pfZt0cUBx7hb7SisznjW?=
 =?us-ascii?Q?jeh9X7iF9sm7Ni1onayQO3Mele0SSuXwIc9DnUKhrxNTzjyxmqwAMXmFIjgK?=
 =?us-ascii?Q?9VRsQUaRrOnj1w64yPhAkLb5JKW0hsoDmnubGc10HaIL/OnAZYjBVfzhV1kB?=
 =?us-ascii?Q?TBifhbOFsOakb0rUbtvFW27k2LFLZunZ8TJBs9DV3ngn6/V4g52U1+CyK7eo?=
 =?us-ascii?Q?qD11oiovazcA2zy3BGc3pLtuMYBlnaVbfZbuwLZL1AD++/so1mkyToQTT6ra?=
 =?us-ascii?Q?KV3AKsqzBxZEywnYA0FK1PMbKoW5CwDkq+0olYme?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2025 08:48:18.2749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7907dc-43da-4aa3-ed1f-08ddfda29b00
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509ED.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR07MB10468

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
index c7b884f173d0..6e6fea8f295b 100644
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


