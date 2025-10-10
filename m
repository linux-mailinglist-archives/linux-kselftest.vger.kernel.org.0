Return-Path: <linux-kselftest+bounces-42953-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 866C0BCD1CD
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 15:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E7551A6738D
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 13:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A462F5A27;
	Fri, 10 Oct 2025 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="kcNrksGr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010022.outbound.protection.outlook.com [52.101.84.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9ED2F5324;
	Fri, 10 Oct 2025 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760102265; cv=fail; b=D4JpxPK0DgFT1ievLTNnCITBZKrQSkJFzP1WvDY+HFXzy8cEdncQxKYyrijhrw+wiugZv9ZFqcnZ/ar8Xm65jvQEMs3aK/YHIALgJs6lE59dB/JV/oViVxtC4wwlf/jbfWWNyklBxeX+CSUwQafqQ3FuynwxuljxqALu7el1+S8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760102265; c=relaxed/simple;
	bh=2kMgIi+77IQNnDBspgFqN0KOdbGQ1+/OQ8JIxTpQr6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1DHOcHFbo9LDZnBYG50cMQvDTAQGJq0CBc5ps0W17VJUG26fZMC71Dm1FbnfzuD7WB7BrLoBTZiUUmKIj+pRo2uazDGCGbBLGYU/Msbpb68gRnKVKZi2AV28m4MrIeD9xhVTKdKhIku7jS+wZKkkEJR9/zG8JVzW6k5keuYjuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=kcNrksGr; arc=fail smtp.client-ip=52.101.84.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMkA9G77xuBfjToP21pDWy6LOfCBwq88gLiVvexXexTkH2uf2jW6t1PXD7QGF/p0y0QZYQlsJ61WK5v5hFPd/Ksry1xG6rljNJ7n/BOKhGshwQCOJw+yQo5R2gHB1bHfq7nd99kVZdTCc9axjwz/7iAMkNPRcJgifEKUb+evAutBVyugBQJKWWh3Xeeh/FI5ZQ3102FURmlQcEOWXli+3c4HZZOPMjIswmAnyZqDh9iaQjb3R4eNs1OVV+im1dIyBmewtVeuBMeXSIT7ZujQH0/CQ+s3lEAHN+d/DH/SL4BdjlI5X0FvjU1c7KbQvvAI0r0417+9vZwkabVBpapnGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GaHuXPZcp/CMyZ9j39xv1Y1AMGVL8fIMGiZqvoPq59k=;
 b=Fp5GoS/sFICMRgupkrD6EXC1flW/VBfEwU6z0a6Lk3fXSp1HhbhnoELZxHjyQfxBFcAqrPV8KTIfBMTO4HBYRn1MwJ7iAOIh85tjJPZf8e60PkemAJuCzRGHtiHNMe7jt3dphYrCuNUqAcI4Ym8RRK8D7ovy2w3Uw3i5qKHP6b1Mo9TbykgI3tbkTw2tqTMfHw3a5Lg6QoxCSmv6ayUJ5RHGYyK8Vhv1zUPvOdswdH2Oq1LwjMq+/WwN+694j5HQrt05v/ElDDhT4Z/bkfwviDzy5ao6JIFnoHj0ndNrTVSWDcvTlKwmzrKBcnX9JhbT8siouvQGLaosp7cRoAXYsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaHuXPZcp/CMyZ9j39xv1Y1AMGVL8fIMGiZqvoPq59k=;
 b=kcNrksGriprPkmc3L/Te9geNaP5MWio/Uj8UoBBcWqcGcLS9jpUQ4qLMCPvLmkz8RXtmV36TpPMyif3XibunuLDOBf7DF0THTH+KSa1c+pWPXHnNnz8cuY14x1OqjYAwWh/9PYpT6OqKZz5bW+8saMMXbbYo4RxcTBaz318kePK9qA+Kxjh54wMjkLWUiH+5qQ/d2j9JDN7ayYGt5pfQ/WpB9nq3P9XtzJRXQ3gaJy4o227ZNSZNNS8TI87LLI46Ueaflj0v3HJisZHT7WSaEMbdP2jPBHtPbyGrQ8YpHXlWVUmdbzaXD8O/CU/5dauoTKCuEfe26GGZk+gcmF0wZQ==
Received: from DBBPR09CA0031.eurprd09.prod.outlook.com (2603:10a6:10:d4::19)
 by AM4PR07MB10966.eurprd07.prod.outlook.com (2603:10a6:20b:6e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 10 Oct
 2025 13:17:41 +0000
Received: from DU2PEPF00028D0E.eurprd03.prod.outlook.com
 (2603:10a6:10:d4:cafe::93) by DBBPR09CA0031.outlook.office365.com
 (2603:10a6:10:d4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 13:17:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028D0E.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9
 via Frontend Transport; Fri, 10 Oct 2025 13:17:41 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 9A9BB1C0050;
	Fri, 10 Oct 2025 16:17:39 +0300 (EEST)
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
Subject: [PATCH v4 net-next 06/13] tcp: accecn: retransmit downgraded SYN in AccECN negotiation
Date: Fri, 10 Oct 2025 15:17:20 +0200
Message-Id: <20251010131727.55196-7-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010131727.55196-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251010131727.55196-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0E:EE_|AM4PR07MB10966:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7e5da2bc-783c-4021-632f-08de07ff643f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DaqjFbTVYjILF97GDo50LFZWkS7LQKJ1/3tUnGsv+2ry6oQxPqqAuhxeLh2e?=
 =?us-ascii?Q?ACIXuG+eVP91IyDDhc/HuPPy0w6CnqNdCZHZ9ZQv95Jp4du4wCygEC1dfH+d?=
 =?us-ascii?Q?y/BUzmMo6DDqsYDpXd28BRnMlGbfR78BYrNlCyXgMXA6O3z7dUDNEF0j1XOD?=
 =?us-ascii?Q?H6arVW5pQdU5MBunchbPW7mJ31hxYX1UDuwHZSeyWUq1OkYuedTeHSLickc/?=
 =?us-ascii?Q?Bp76snesoi13tZOvLwqVRW2jTU9MB7jQhbXCzZn3i5Q+z+h+1a/mEAtwYn5F?=
 =?us-ascii?Q?1BliAVhAkArD39Xw2jY9ABDCUYPbawyUIhFg7/TVTybkDXwiW8KMdL+zqq6W?=
 =?us-ascii?Q?CJqxPUNWSFea3lyGoDBHcRPaw9Y7kOELOzx/AhEcdIC5J+YOFVC4/jGFApmk?=
 =?us-ascii?Q?aG7g1+tin7HRlchp6My0012ZtRxtknybRNlGYTkw0o6KdQ26soZoo+hp+XmB?=
 =?us-ascii?Q?AoV6AIfzciFTGpuYGteB3CGYGgSX27BgKMNDJjlZHfFJo9RVYzgrLc7rfykS?=
 =?us-ascii?Q?ZwszZrDoNjJ/UxM4V0uiRRydtZc+Aby+PPcN2r0cH8B1kr+mIVlMrDCFxxcA?=
 =?us-ascii?Q?d0gln1Y5sK/P/eU+LLYiFUHqxNiqVeR0/wgMvzuWoTREWBrNycbsSgEBkLhk?=
 =?us-ascii?Q?T9HfQq5595QfOOIO1DRCv0mo0NgN46X5ZcSjgN/ryPPBXXNK8G1i/DIssl+G?=
 =?us-ascii?Q?+077ROCnTFh0q8c/XH+QQOfLP3GhoKnyfg6Hz27P92kR/EDYvGqL1VeU8pAw?=
 =?us-ascii?Q?KpigXjWNdkzXwzx4qmh98Q96VMXoNTXJICgFIDURt1Son6kZmEt4hN9Ac4NA?=
 =?us-ascii?Q?QXIke3pSC1KprGYWKmppibDWCxGcgnv65uF4IUtr2xIAfxSVmLUBeloWi2hD?=
 =?us-ascii?Q?PMSAzh3vJr26wx2DwTkhYq4hM5Fui30/Oo9a3fPU3I8FPrAMmUiVQ07LXDFt?=
 =?us-ascii?Q?17GVoyx+Gpn/L9hXnr7gnVQ0d69o11xtsosdzjUF2yukpmR+vHgC7PlW2CIz?=
 =?us-ascii?Q?2oUDVWztIdEwRb6YWzS2dE8vHz71/30MASlS7ncUYv8zeEw3rs1UGtJe5i4L?=
 =?us-ascii?Q?V8Tt+rdgabmB70qXhX7UYe2z/u/XXeA/7d66ID7cS2BwGLpAGvacLAJ9Fxyv?=
 =?us-ascii?Q?efy7r4XTVujctZRQDciKB24lmXLz+9Z8ktKjT5ZlfVZXizkFPYy/JLtJzRCp?=
 =?us-ascii?Q?S1TdeFnHzIN5mfYE41vtRIs1lGRd1CfOai380s77bhZWbocWVt/5RcSiiWk+?=
 =?us-ascii?Q?bXideg+hode6kCcv1P10n8WwkFgxBrRfHqFdbfq/k+i8MtXrkVk2yD5fqNkZ?=
 =?us-ascii?Q?t5cjMMX1eR2Bj6ziyAWs/6vrQctn05yAEzXJ2B/ZpZhY5XefXMs3Gf3aAXfz?=
 =?us-ascii?Q?cwXN/ObiIDr8xCbLLIY2Bw/ZXgTqLDq8bDWZBLD8AEtFNf5aApvRur5XkX8w?=
 =?us-ascii?Q?2fiuXbZK0ozkYy2qIcFYp4nfDjgGpApumSguDhIT/0R0FxoNF5Y9jH+48um1?=
 =?us-ascii?Q?IbuGp2rff0ZCIKRL3n0+M0RYGCwFs7W+u9bopzapbhrlax0cAQxOSgCRyrXH?=
 =?us-ascii?Q?UEYK+9Eri2DpN67xp0f/Beczm23BfSy0npctEN+g?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 13:17:41.2325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5da2bc-783c-4021-632f-08de07ff643f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR07MB10966

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


