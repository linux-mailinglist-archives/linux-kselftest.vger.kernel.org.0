Return-Path: <linux-kselftest+bounces-44262-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CADE5C18FA4
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 09:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E751CC3D06
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 08:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C9732B9BC;
	Wed, 29 Oct 2025 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Ret1Uf54"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013002.outbound.protection.outlook.com [52.101.72.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42196313540;
	Wed, 29 Oct 2025 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725201; cv=fail; b=FvrhMYw1t9ipNUNaAAmrTAKQkW/5cq2gbyxWc1zOLvcMvNyhCbfmEhK6GTx/k8p1L33cPX5yctiN9SStTU0cu2TNEmlCfOJW3xxqcaaS8yIJLTGm/u5TiNJXC8PB7Jgyq58wS8KjEAXSAkSYAM4cRX++y90byjS61CuWwm5STmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725201; c=relaxed/simple;
	bh=D94ZmNU4qLo7BDdPHP07wBdhqUoXRiT/2qou8PB9ogs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CcZmPV9UfHKwmyZfXm4mRz153Nig+UjsOgrNazGPjNKQ2vV5hUgnZU0TY0auFeP/luYNJT/GFfFAbFAKtIZy933amMcuGrR6t+zRqnDDV9ep+N72u/f3eN2lYkLCrQEAmrUo1lKpPXdPITY9mj0GjA5Op8cSlGLIAtTXBLmTjtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Ret1Uf54; arc=fail smtp.client-ip=52.101.72.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkS8wjC9DBM3ISQBZpA7srMhyXwQ5kWohRDcdZORTgrhNWhftqFOb04WVq49SGjsE9mcncXdpFAK1BbQ9f7/y1QH7ZZ9wjjiHaZquJeX7zSYvmulMIDp9jReIOTJWWx+v8rpq3ISDbd7GHe4ajxUx+hEcHl7pAujcSpXvHw/F8y9rdULUeJPzJvXlnknyIVhNeu5oAFgJpPhDI0aDXdqbM7EvhtQ1fNKjtHN53OPw0JTiUsat90gwJsM3T1qAv281QjdYi7GETyxjcUX0cVE+k773g3I5Sec6nZCHXV+m0uRE9H5PUGmDRjyOo4jaSdN45TJdPumpdCJz/18fpiKFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEBPCu3K4Dn/VCTOXYSXoIOEzv5IGDmN0n2aaq7TkKU=;
 b=qI0NCQeuoeNLlRdbTuUZaO1XSrw30URDvA6s4cbx+klJ3Nh4lSFBLDq97TsQLCSUrVtIC/iHTMhejZ8WO5f8OIWr+jEW4uz3k+UKDl+TvTmAOEZIfDYClAIgUecZw31VVyYdsLS7tgOakyZo6aBZ8+o187IFmNQqGzp9uuDQhi31JUC00DNmKi1qeyImZx8g4Cgzo/vWW1c3S+qp3SNYf3Thw0wUXkPdqUEtXaVJ923UaKEDQyEr74pkASjbYBKBUHMUscM43hCABVq5uA9UH75hi61Qd+hOuKw80iZRKvZYrK+38CcQwckU1Bv9nuq7PNxGNZfRErWFmYjh0Urp8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEBPCu3K4Dn/VCTOXYSXoIOEzv5IGDmN0n2aaq7TkKU=;
 b=Ret1Uf54sv+wu1l9TTNFAAGmMXf4X+2rp760BKmZUgudWz/AeIYeYo18650qEjJDJNRt7Npu4VUjfzB34P2k6HPTJM7QP3CDC1WShpxw8+rrRZ1IU3P2uv+/VFSh0GZiWU8lu4GNQjwldJMKUNZt0BIsYYM8f/Q2CYKiUXx0P5xu+9C8xutjF1xjjDrnfnEQnjq0Lt0/GhachwRBA5dn+ndTi+ph2+VUGC95y1IhuuHwnHEhTHpL0cmpOkIC/7mc+2M/O1QZThLuF1/aJIVMyY593Xlix3FR2IOgbRdBPbP8ZtD+yhkpK3iZU3hSgfRms4craAiMkCGHpk38VRKj8A==
Received: from AS4P250CA0030.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5e3::20)
 by AM0PR07MB6257.eurprd07.prod.outlook.com (2603:10a6:20b:152::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 08:06:33 +0000
Received: from AM3PEPF00009B9B.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e3:cafe::b3) by AS4P250CA0030.outlook.office365.com
 (2603:10a6:20b:5e3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 08:06:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM3PEPF00009B9B.mail.protection.outlook.com (10.167.16.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Wed, 29 Oct 2025 08:06:33 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 14CFF200E9;
	Wed, 29 Oct 2025 10:06:32 +0200 (EET)
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
Date: Wed, 29 Oct 2025 09:06:02 +0100
Message-Id: <20251029080608.92428-9-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029080608.92428-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251029080608.92428-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9B:EE_|AM0PR07MB6257:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 35a6cd08-c37a-4da6-90bc-08de16c2135d
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?U3cHycvskK+BB8e9pyWORjd1E4t4yngXoZPdFa2/bFu3Mo5fSZQhHhZbDI39?=
 =?us-ascii?Q?OUm0+N20/HQY0mkMqew3DoJCsSRz7BXfrNLZvA/v2JnoRuCSD4Z1eedPHa1N?=
 =?us-ascii?Q?CXpDAdrehCYsx/3sG/deBpPz+SceKz3gEtjZ8xsbOwrBK5szgyxIgyw6WdwV?=
 =?us-ascii?Q?A8Ezhlbe3DvbGnR1vkGH1K5KcCppMJywsm8HHJ9gm/hyeJoFuEz0ptO4xOjF?=
 =?us-ascii?Q?DhtrzAnysifRyyK4PqT5edfG4RrpHqfpaEUZ1DFDxgtxp8OwprIq28LEhC1X?=
 =?us-ascii?Q?204DKcCUEL2NuV4RoJKpvVMFG0m+iqcOL3NsMrG0r5FFZrPabs3JHtupY22v?=
 =?us-ascii?Q?ZhhcFrYF6HSdpmceBDCu+lim75wTJZ1dA1w9HjhUvgxCB0iDuqPlLdPtFclL?=
 =?us-ascii?Q?Vr2s7BXNohs+Pv+2LJprsyZeKQW/ewv3bZTLRwGajdv306NOyxyD56qEFCk9?=
 =?us-ascii?Q?mh7QmwR+Pwek3CUbGEkke+b8ndLLrqY4gXgG/1yoQnu56XyKviXUNrOcPwQd?=
 =?us-ascii?Q?9ZoHUc6X+xmP96m69PdG9t+spNCFOYHUlz4OWTmWaMuyoh/4dHmasx5Weceu?=
 =?us-ascii?Q?IBIvMgE+TDsAd52Srawur+fi6Sdu3RTwL5FCpvjvemKg+QyXhKhEeR96jmkV?=
 =?us-ascii?Q?tg+tZIesU2yx4/X6yuX69ymYHisnt8FfK2tOg7YmzD3kVu3eqpk8hLIQP5te?=
 =?us-ascii?Q?ZMeOsvp8fGFBo6UMpgeTijPVWvHLmvcVA4HURvruhMOFClIelu/tpjUVTYCO?=
 =?us-ascii?Q?mvp4XETa2dG+tXEwNmmjqoXJ9iXH2rhHGoZomP6RfvQjfunpYtrEMamI2Ul4?=
 =?us-ascii?Q?65/uGDjkjinOriCPvdUE/Yr1Hcpi/Q4+bAT/sAq5zK2i6XH/w9EhFS8KQc91?=
 =?us-ascii?Q?5VXleL9m3VRbf6NarNOQl9Gza/zxkHDBzuiQYqntCgPppR3J05pD3nUNyl8F?=
 =?us-ascii?Q?goxHPjYz+6eLsSdVb7vpUAluWUZF3opTDzg4fQymaLeAOlurGxaKsgc68KBz?=
 =?us-ascii?Q?w1t3R5ajyBtavff3ce9/AnfWM0n0QLCgCoDFi4b60N+7UjoWITlpViVESpPA?=
 =?us-ascii?Q?05UWLq5JNZGXpfJcH0MLs2DoEv5QylKPpvOiyWUQy4n7IadB4ELUFg8ikRsX?=
 =?us-ascii?Q?JN64r104zK+ZEqbPid34+cst6xYKL35eL53ObvNfLABuPq4ii9AV3qqffLq9?=
 =?us-ascii?Q?Y2z20mNh87Ym4qmFsQbTG/ph6hNmDwtG+TbUC58t20lY9u8hJpVcjdB7rqFE?=
 =?us-ascii?Q?CEnhsEBFiAbCPS884DESN8XqO87gTVUp58qqUC6Av4Z6QU5wiPKpKa7ixlYx?=
 =?us-ascii?Q?O0XxXRiGM1CNB6o+wqFH5yL2GIA/IbWAnY3Z5V6Pu0xKdMj3z8AxLUrs6eQ3?=
 =?us-ascii?Q?OoxOjwhIckNVsIA0aE10XPSbtSuREgS0+RS9wyCtRIgYbcdjTXLWG39Uqyfg?=
 =?us-ascii?Q?faPjbyXKLCTwpkD0Tm9RDyPQhdEPuVS+xxlJ9Z+bM4M2rAaqOw/83/hGATpS?=
 =?us-ascii?Q?FsCk4rN8188YSvf+Xb93pbvoUbaWtEEsBpI184hv8QijfgiElYMjQP5yNbuF?=
 =?us-ascii?Q?6FGIYeL/6Kd6VdFC1Eem3RHwWtoxDa5k05hDEkB9?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:06:33.5919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a6cd08-c37a-4da6-90bc-08de16c2135d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF00009B9B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6257

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


