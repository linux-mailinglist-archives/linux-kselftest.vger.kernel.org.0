Return-Path: <linux-kselftest+bounces-43013-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3239BBD57DA
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 19:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE8D4C1B53
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 17:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EB92DA753;
	Mon, 13 Oct 2025 17:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="OEagFovc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011039.outbound.protection.outlook.com [52.101.70.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6C52C0307;
	Mon, 13 Oct 2025 17:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375040; cv=fail; b=p7SW5m0FFmGqqKv2GEq5Jp3BbuUo21hbQnfjPOWozDWkV+dqmprGq1REK6cC4FXPlbPxu9Our/BVvlY1mcPzOlQWaPChFFsyB5tTrgFgWtqvZ0ulkeRwPKv/eYkCzNQsUFhjaWd//l0ypZXrEYhS+lkKsqlv+DbLxArKmsZVb2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375040; c=relaxed/simple;
	bh=2kMgIi+77IQNnDBspgFqN0KOdbGQ1+/OQ8JIxTpQr6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g5McaW+Kgs/iApEBDdVjm1g84Ud7elZXfNt1KMoGfaNXJKVhQpczzDpZGHx6sdz39PTEhEWhOdxbr8pXP+YZFwyLJ3cesNwwK0sh0JzUeGC47lAnaww15eUR3xkvMw5QStdmjZxXBzl2cwN90e1d9WUR7SYubIVqJRNubBJLRgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=OEagFovc; arc=fail smtp.client-ip=52.101.70.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwupWutoYuvjcHX7+zUALYW6jyNZ+77LPB9mbzy6wMZysRWdFYg/oDCjtSdxVxpyshcnUbgepwaUg7ud0/Wf7/DGttD9DMXnyGlvICcgPKByBLOuUXz9/jivDA+mdH6wywsGiPNzQEsWTT4SI/vnhUOBJ8VS5JLqGb6o0GK2oKGG1ciY2rrg/4ncoRSGe1mox+KACCxW+2CrZ7FA+HEUkEfMrCmGeQU9fxf+Y0csolqsxUwJCfod9vac3MqyjZ9Pg1LgQcadXQbmu6Zc4bMMaP0R087mL6jbnTg+S9qcN2HBvzO0GRUwdtwubp8EuPYvPrfE7bndvA8dSMsmGADs4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GaHuXPZcp/CMyZ9j39xv1Y1AMGVL8fIMGiZqvoPq59k=;
 b=gQIaaW0gVrJwR4Uv8kY0kIUih95Q9O/LJVRWuul5hNG0FO9r3eKwxMAn5u8hEZjNh+vNTHR6VepNL0z0KlK+ukWtCkL11EE1uP88r+WMH6/fViSHNmRKmrb2C9WGWx96kAN8aM4jXQk0/GBw9cRVF5HLrq48xJdKTgEuQY9NvHBtQKtFlF2+sMgGYpxJZv2K6wYWxuCvqG9yBdVO4mC+j350HfKhP7FfVHU/l0Dmz3l2tqUp63h6S0Pe9glRGtRgIQjYaHwpBqJv0+1nWVHzfqrutgxhjhSZwAU5Jk+daKT8I3+i3u8lJxG6KeRSuxi5GKbJtO6HSXLlKo4s1Ygskg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaHuXPZcp/CMyZ9j39xv1Y1AMGVL8fIMGiZqvoPq59k=;
 b=OEagFovcKtBxMsBAYbB0jHo1q3OlmyE6qhUNLpBkgSf3JOkiWrgWBGERd00IcBJbKWVGu6XZc2s4TRM/nlJnkjMjQcwG+u8doqPKW6qKtyt5364HYxZkxfc1NFnbK7CnMdgwQqXrB+YzFeX2XP1GbRfm8VKpYCTGbsJlWIk1Z0nM1NfkO9GKZv6VD/6OJEj3tjeX+8MIYnJHVJizo4CYTKiAfkboShv1J/aHcUP3LNi6R77NG3+PZv3F1uZvXUaqi1jV/K7j7P2vC7OvjthaG+oaoesGPBDKJH/dj2HgYcdJJe/C5wqCqgjaorOToMJCvToxUMBifNJNO8XUt0GiMA==
Received: from AS9PR05CA0288.eurprd05.prod.outlook.com (2603:10a6:20b:492::12)
 by VI0PR07MB10805.eurprd07.prod.outlook.com (2603:10a6:800:2c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 17:03:53 +0000
Received: from AMS0EPF0000019A.eurprd05.prod.outlook.com
 (2603:10a6:20b:492:cafe::66) by AS9PR05CA0288.outlook.office365.com
 (2603:10a6:20b:492::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 17:03:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF0000019A.mail.protection.outlook.com (10.167.16.246) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Mon, 13 Oct 2025 17:03:52 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 642251C0010;
	Mon, 13 Oct 2025 20:03:51 +0300 (EEST)
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
Date: Mon, 13 Oct 2025 19:03:24 +0200
Message-Id: <20251013170331.63539-7-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019A:EE_|VI0PR07MB10805:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ed88ea01-1089-4281-74e3-08de0a7a7cde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bT8FY9epoZl46ZDc4XHOicJuLAAmFKtZwZ/Or2STjWqYkbXQeq+VuVNuxlU9?=
 =?us-ascii?Q?W65OoPA23wWv2dPabIZTfV00xGfK2w4jl9AAfStHz1gT9b+NOMc9GosLNZtZ?=
 =?us-ascii?Q?+4oKYGxDs5nV4Jy13c9aXvf8bOy8ykBa66mbDNvJi/TiIOCka6uLSVGj2fdT?=
 =?us-ascii?Q?Z0NJy5zSgGpe3YvHckV5yH9R3lYpUSz2CVrdCro9PczzAdYsO6c0M/fQxfEU?=
 =?us-ascii?Q?OrLSCmKgE0zHcZmH5AAib7pFvwBSyH2bIX7grVqPkN4FE0grHyoB16WvT7J9?=
 =?us-ascii?Q?uSLFuiHaBXolzqnK7MbxdE/FW/bWKEnk2ttlYt1zj1dbw+CKX0VzwhmB+kTx?=
 =?us-ascii?Q?woTPbcf+eHNc4d85YBTXMQkYZUQayANfoZgewPXoB/UX/jRoyyT/y9+Hg29o?=
 =?us-ascii?Q?Q9+0mXx2ZnqdL2hkQ7IdexCEOcIOfTuQpcZsPwSC+HdWKssqmP4Kecaujl/6?=
 =?us-ascii?Q?NHqWJfosI87f1qZKtY/dgvbi9tK0flCR9c6LXR2zkDkO+2KRXsiQcZYfa8bE?=
 =?us-ascii?Q?yQ1nMMcWObZBVY5vIoPnp0OWupHeftHOR0fbUMFl6FO7fSZKorMLg45RdMBg?=
 =?us-ascii?Q?FMmQYHeVqkNY0ZnYnLaewMXasrLAWFns0iHMqoZgDraQlTbWGfsyL9WfS7AZ?=
 =?us-ascii?Q?UTRt/UU5JnSdysR/WiGSuL7MJZA9uEWhbC747AzD+xVWLB0zTjBRjDlZRsDP?=
 =?us-ascii?Q?5j3cZnWrYeDE4H84HOFqcu0qr1+ua7CVLD3vKnMxpRHIumMuSIYHyC9SDlaG?=
 =?us-ascii?Q?Nl6rzWYxifENe7EsWOYaXoULWioXBEn6d2CAxOyw11gsbQSU8alTxDAx7DCT?=
 =?us-ascii?Q?YD5YOpszkd/oUy4RP1sguHwXC0pR3/jZTqWfzqLA9BeDm9XXNantLHOqmBqw?=
 =?us-ascii?Q?YCP3V7m6WXwxmYY4RyRunkxFp5S60jAi+MFIdu0KGHyTqzxiWzpvEUabLL4/?=
 =?us-ascii?Q?CX/np8jjz2ZtqcxHJ6Wx2sZ+gpZ7aQy7tQgaIIrBc2qgTHCvjAp8KLTiY6OP?=
 =?us-ascii?Q?H8aq7ZQ5+1Z0mHTGUek2QEgGTQjnBsmqf64esHjpLGZZUTfhGwnWBNoZCTcD?=
 =?us-ascii?Q?d3tKK+l1xUYJXk+o3wQ/jSAurql6NrnAuNgnYtlH4cnKGYUI28Ha8IdLQ+3a?=
 =?us-ascii?Q?I+jtHe+IGDcUYrQUTsUb5fDnNd2TKkk7QHu0TZ+DXqj0j60Ma5z0S1q/mrNB?=
 =?us-ascii?Q?TYx3T87RxwMJQAATnBNxVIu0K2+ce1qS74sTHLvRPdQfNxt3RYyikSjTYcH/?=
 =?us-ascii?Q?ZuaCyP0yNt7LsAILyb4Z0L5rPCVqOuuM0u1+RBYRFrg1j3Hvsv0FhYZYt3Qy?=
 =?us-ascii?Q?VvK17/NsFoSOTGBQRTGqIYInWedgxnRRP4qdEnBaVub4Ii7HRRUu0VSEhr08?=
 =?us-ascii?Q?7ZZ2b8/8KPruB404cQTqRUK/sk6TD1X5TnYz7q3VX+/5Zq2XUehw3vvTj12H?=
 =?us-ascii?Q?RVGYc6p2mWkUjAysGYVnSWSear7mpjDmwKaSmulJefnxYb4PsHiP4HZQ1Mfj?=
 =?us-ascii?Q?Vg3qbyw7Q4dODVfxqUNOTEWhuJUHNw5nud8pzwrWIY72TbJQJfRjH3iH0Cf9?=
 =?us-ascii?Q?Lx/pyZ00WTHMNcn8DNYiEdSQ1IHFncG8v9lEY4ca?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 17:03:52.9740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed88ea01-1089-4281-74e3-08de0a7a7cde
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF0000019A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB10805

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


