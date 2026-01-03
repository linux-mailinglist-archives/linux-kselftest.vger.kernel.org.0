Return-Path: <linux-kselftest+bounces-48116-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC30CCEFFF9
	for <lists+linux-kselftest@lfdr.de>; Sat, 03 Jan 2026 14:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE77A30ADEBC
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jan 2026 13:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B7230BBA3;
	Sat,  3 Jan 2026 13:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="U5VQDwVu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010024.outbound.protection.outlook.com [52.101.84.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7153B30BB95;
	Sat,  3 Jan 2026 13:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767445862; cv=fail; b=IiEjQOK0l3oAuO+f0sltmWNt87kdbJA4KW/X2ABw8stx9ZmCu1FDb5hjv3bGC8BuD/fTLWzN1QVjxJ5CD0TvzEGX4JnV5UehvHmOQUxC/infge3/EZPFQntwdwElih4N5KZDhm1utYwKMrqnnx9y+zCnsObLco0GmXwfZUZToXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767445862; c=relaxed/simple;
	bh=j9ZeZNSfPKfB6IEsLFGub6uScWn4IgxqnPRDldPpxlw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EwqGbRP8pTcuf2Wonfnocl9/y0ib0LE9BWMXIfiaw3yU7/YIX8tH2IQQlOXxRPNPfmnYgllrKn9AGHptCHCu1xxcOm9a7OIjAYUnVzIFKCK35T/X73qdDrFQTLLmEvzNQWOvXYuBFdTiGlZ9TbTB6mNzMOVnzaLfy/8yOYh7IUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=U5VQDwVu; arc=fail smtp.client-ip=52.101.84.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSXfvdNjOngVD5Qfrh1RfU5GX7BPvTXd6rb1Wz3s87HmUO1kuVKFMG8+ESuGh14UnmRKCXJlu9nNLZTwQMrXwbHS8HFuknwkbkvyexN6fNeltayF07lYsoO+up9LkUfnD6OmLtcyC2Ku32EbDok9kIn9/S3SylNdGUHi5uDTmXb/rmxgmvqUScL1OI2OwA/XR+6A4UjFkQXXs+03koazHPW5GcFkL5HxaGBJXC6Z5H5SBQdHjS7tw5gzbBjQhAAoRKNBrd+qyuVz41kQYP45xcHo7YR+jsMBmFGKCXOVM9MHTyagB6PJ8iyjqS8nmCGXDMxkjVFDjbcUliTzFTUv9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEGmg+y+pRqp1QE/S29vVIDBeUQBeOHoV9hEhC7UYkw=;
 b=oKfg9t/MLM0KDa1fiNDhK3wuMPuXpUEOgjCDe1ZF8DRFDkTCzej9tmgrIZ9hKAxdCWS5qzneaZx4SH7hv0sqLVrEDGwC++GP5qYgWdqmGgCUyFzzi1vYzRt5w5SmRfquZYBX1MQNx4KZB65zRdI7T9IG3UNhVIpO+XjHhjs1x0Td3PdVih0SdIaxy79GN+wSFhBE7iz8kKNmtd1c60kXjW1HTBhv3VPkW3Pq05CThXw0avR6D25h+EuCN9aIpL7eeiR1wYbRRhU/vacvOHEsz7AHu/QK5OCRhBExb+YQa4Tp+fzs+snmXMWnTBpi/cbCOod6rubY3bvuisjMTug+DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEGmg+y+pRqp1QE/S29vVIDBeUQBeOHoV9hEhC7UYkw=;
 b=U5VQDwVusYWehgz/gxLm5G6lbnz7pTRI5Is1r6RGEf2ptgVudSFrlhY/fmKtOmGeCmak0Rp1PZNwlRvxNB1Es3YOVWoGrva6vcWr2CycluXHevvPXPpvRxGFSbZ0ozZi4GBckXbYBooEKINx6RlZyJLKIccql2tz7QyU+O2Gs73v4uQMhcJjXwtg95AheAKJ0ZsxF+HF2757ojSHGfcTksphBhsiwwsqCwSsOlPW2Gy7Ocdyjtdk0cA6X/XuiIqgp1P+/jbgdHVk+8IZ2Uy6ZleEhZ7RmldkOm+0+kg6e/d+RpZR6MdOBAI3a/9FQ80HYcDdyisNf9UUOahLTa2F7w==
Received: from DUZP191CA0011.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f9::9) by
 DUZPR07MB10102.eurprd07.prod.outlook.com (2603:10a6:10:4da::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4; Sat, 3 Jan 2026 13:10:56 +0000
Received: from DU2PEPF00028D0E.eurprd03.prod.outlook.com
 (2603:10a6:10:4f9:cafe::6f) by DUZP191CA0011.outlook.office365.com
 (2603:10a6:10:4f9::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Sat, 3
 Jan 2026 13:10:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028D0E.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4
 via Frontend Transport; Sat, 3 Jan 2026 13:10:55 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 2E6861C0030;
	Sat,  3 Jan 2026 15:10:54 +0200 (EET)
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
Subject: [PATCH v7 net-next 12/13] tcp: accecn: detect loss ACK w/ AccECN option and add TCP_ACCECN_OPTION_PERSIST
Date: Sat,  3 Jan 2026 14:10:27 +0100
Message-Id: <20260103131028.10708-13-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0E:EE_|DUZPR07MB10102:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4a0589a8-f8a2-42d8-fa7c-08de4ac987b4
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?7tNHgsgoMpAnV1AtpFJgLQjR8Lz3e8MmSeRWPak1OQmCrC799i0YPLyxFphf?=
 =?us-ascii?Q?LyYjhF00NNDrRQHDpZ8/7mwf0DdEQsbcBO2Y0oCKGqrl280uZrssE8yddHiM?=
 =?us-ascii?Q?iWZhLUD6f4uEinwjFrVD/O+wc6vk9vArS+FopBtQHD07xe+VhZ1515oDkE+J?=
 =?us-ascii?Q?gqp8Lycm9PI98rV2thWO2qweJA1A94xMWAHJAK9zbm+wYlRUdjfSHP4T5eRW?=
 =?us-ascii?Q?0ba4855dl3AT1AqVtd/YWX+h4yhww7tfrN67IAA9RZQ5E+ancEbYlNR1eCRr?=
 =?us-ascii?Q?oxsIrKdSWDpFk3yc/rZ/fNvSNVx7b/IslnX1r3x9fHVALN132AQZpHJ6OS2x?=
 =?us-ascii?Q?8yD2ikywPB8QlMFGxdoIUZLI19Xk6G5KgshiWahjTJH1291nhiEx9ZAxDfhj?=
 =?us-ascii?Q?wSV7EIf/7F0/ZGHXiUF6CRo6MZleWaYEeI7u/RarPHV9ByoB9rK7R+CaO5s5?=
 =?us-ascii?Q?vrB9d0rG6aCcNTxLmVFBt5EzY+dE/88iF5X4yNWTbx4NaGQ7GFw/W4w1hkA4?=
 =?us-ascii?Q?n/DEYnXHGPnLL1L4/yE+y3Gyk0UV+K2xtm9MgR0cfPUZDicwMuxtcbcc3rkD?=
 =?us-ascii?Q?QMz0oi8DVmOBKAUNPDgfYmdb7glr3urXoOhYm0Hax5MmebRafZmR5ySzwvGZ?=
 =?us-ascii?Q?UfOR6GflLF/ronq8JRNfojH8Yh4X2zp/g9e0UpyP1VtvTP6tqfMQMA6SQUsM?=
 =?us-ascii?Q?y5eSZfV81ZvBcHqT6l0rCutsog8X5Wuq3QykicjeX9ltvS9dNXE+fvt8/Smn?=
 =?us-ascii?Q?bFHNTPfQ16ZMBO9JxrLYX6jKqQrxAGvIHBKI3cjUfFnts80l/Q8+LIkt+oOr?=
 =?us-ascii?Q?pw1xYpRLjT2BRyHe5dwzw/ewE/nC7iX15zitDpA1L2CP6McdJWj9SgSJOTI2?=
 =?us-ascii?Q?G8UVkg1tjNAiilqEloxYHMmvWms2PyhsMFFrYFdZztNuRYEcV6Jfi+UrXuRQ?=
 =?us-ascii?Q?1j4B8B+g63AvMSkT43dMuXtw23a8s9PBAfkEIVW9w1OOfneVMITDquUyHTCL?=
 =?us-ascii?Q?6NxzxrGK4fMOEVj2smO/+Iy4K8un0skCD6mcJ/Vrf605B1rRMB/8V0heHjtu?=
 =?us-ascii?Q?7xo+9JAKdRH+RXMXvveTTM+swOMO8ccSgqqlcRO09hdI6rv2tgBXPyqXeAPu?=
 =?us-ascii?Q?pL9RR+dQIXvFGOrtp0fOzI+gpOUirdydoDR6STY2nEFGbQ/ne/OxKLcZh/Gn?=
 =?us-ascii?Q?szpZDu4nnWLuKv7bBnvfxzm7NL9y37cEiposDWvI6lSBZ0iWuB2S/jKvcvUe?=
 =?us-ascii?Q?Gw+3+P8SOU+E/txiRFSYVrS0a8P4tXJuz0ygOXb98mJQm9+ZHAwlgoM5dvVi?=
 =?us-ascii?Q?Dz3TygK3nlBipocY3K2U/oQRjTl1bjePoIC16mkgIp9gGtkN8TKCxgIPE9ao?=
 =?us-ascii?Q?jvoEX9idOjNt0AyoXej6sIwZiAz+c39PtzAEX+UOGvlVpyr5V9wQm0BvZADh?=
 =?us-ascii?Q?Sz5tZxQyq4xRqRlxnwAUH6LtVUdy0EvLyKcfmMnaUhOsuZ9Kix3iloNrVqQH?=
 =?us-ascii?Q?F9CcHOeI3su0XsM7GgipYXOX8UgdfCEAebeLwgzJE1Poj3kHZwbFxVvfa06n?=
 =?us-ascii?Q?O2SITx/EL6gPpM7F/vGbnFBIjq6wn4ASQdgfitMX?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 13:10:55.8017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0589a8-f8a2-42d8-fa7c-08de4ac987b4
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR07MB10102

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Detect spurious retransmission of a previously sent ACK carrying the
AccECN option after the second retransmission. Since this might be caused
by the middlebox dropping ACK with options it does not recognize, disable
the sending of the AccECN option in all subsequent ACKs. This patch
follows Section 3.2.3.2.2 of AccECN spec (RFC9768).

Also, a new AccECN option sending mode is added to tcp_ecn_option sysctl:
(TCP_ECN_OPTION_PERSIST), which ignores the AccECN fallback policy and
persistently sends AccECN option once it fits into TCP option space.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>

---
v5:
- Add empty line between variable declarations and code
---
 Documentation/networking/ip-sysctl.rst |  4 +++-
 include/linux/tcp.h                    |  3 ++-
 include/net/tcp_ecn.h                  |  2 ++
 net/ipv4/sysctl_net_ipv4.c             |  2 +-
 net/ipv4/tcp_input.c                   | 10 ++++++++++
 net/ipv4/tcp_output.c                  |  7 ++++++-
 6 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index bc9a01606daf..28c7e4f5ecf9 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -482,7 +482,9 @@ tcp_ecn_option - INTEGER
 	1 Send AccECN option sparingly according to the minimum option
 	  rules outlined in draft-ietf-tcpm-accurate-ecn.
 	2 Send AccECN option on every packet whenever it fits into TCP
-	  option space.
+	  option space except when AccECN fallback is triggered.
+	3 Send AccECN option on every packet whenever it fits into TCP
+	  option space even when AccECN fallback is triggered.
 	= ============================================================
 
 	Default: 2
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 683f38362977..32b031d09294 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -294,7 +294,8 @@ struct tcp_sock {
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
index 49e0b865fe02..bbf29f3e4fc5 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -29,6 +29,7 @@ enum tcp_accecn_option {
 	TCP_ACCECN_OPTION_DISABLED = 0,
 	TCP_ACCECN_OPTION_MINIMUM = 1,
 	TCP_ACCECN_OPTION_FULL = 2,
+	TCP_ACCECN_OPTION_PERSIST = 3,
 };
 
 /* Apply either ECT(0) or ECT(1) based on TCP_CONG_ECT_1_NEGOTIATION flag */
@@ -406,6 +407,7 @@ static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 	tp->received_ce_pending = 0;
 	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
 	__tcp_accecn_init_bytes_counters(tp->delivered_ecn_bytes);
+	tp->accecn_opt_sent = 0;
 	tp->accecn_minlen = 0;
 	tp->accecn_opt_demand = 0;
 	tp->est_ecnfield = 0;
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index a1a50a5c80dc..385b5b986d23 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -749,7 +749,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
+		.extra2		= SYSCTL_THREE,
 	},
 	{
 		.procname	= "tcp_ecn_option_beacon",
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index db361daebff8..2aae397b9d66 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4819,6 +4819,8 @@ static void tcp_dsack_extend(struct sock *sk, u32 seq, u32 end_seq)
 
 static void tcp_rcv_spurious_retrans(struct sock *sk, const struct sk_buff *skb)
 {
+	struct tcp_sock *tp = tcp_sk(sk);
+
 	/* When the ACK path fails or drops most ACKs, the sender would
 	 * timeout and spuriously retransmit the same segment repeatedly.
 	 * If it seems our ACKs are not reaching the other side,
@@ -4838,6 +4840,14 @@ static void tcp_rcv_spurious_retrans(struct sock *sk, const struct sk_buff *skb)
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
index 9489cda7322e..63c7f448037a 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -713,9 +713,12 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
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
@@ -1187,7 +1190,9 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	if (tcp_ecn_mode_accecn(tp)) {
 		int ecn_opt = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option);
 
-		if (ecn_opt && tp->saw_accecn_opt && !tcp_accecn_opt_fail_send(tp) &&
+		if (ecn_opt && tp->saw_accecn_opt &&
+		    (ecn_opt >= TCP_ACCECN_OPTION_PERSIST ||
+		     !tcp_accecn_opt_fail_send(tp)) &&
 		    (ecn_opt >= TCP_ACCECN_OPTION_FULL || tp->accecn_opt_demand ||
 		     tcp_accecn_option_beacon_check(sk))) {
 			opts->use_synack_ecn_bytes = 0;
-- 
2.34.1


