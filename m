Return-Path: <linux-kselftest+bounces-44269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2D0C18FCE
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 09:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3861C636B7
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 08:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDC9330338;
	Wed, 29 Oct 2025 08:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="C3gP6yTU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012008.outbound.protection.outlook.com [52.101.66.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355273126C0;
	Wed, 29 Oct 2025 08:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725213; cv=fail; b=f8Iz37PPihh813jOkSfGwuvGoGsPl7QcJfzXfpq2o7zh53EaC5G8I0Dg/17HN+S1mYzaLwpyhMydN0F93pPO3HZJtpriGNw85yKYAry/CE6j3jEH96lhVHM0TsLnUSw+syz980QslW+btX2+CaKIPeS9pYhmNiJo1uRWAfkFL9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725213; c=relaxed/simple;
	bh=8850ndzH5B1aT/IxWPlGIPpJKtTjWWtEry31wX6aqWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cN1wNWxrRiWwMrh3zm9rP/vwCuHTLdnmtEr8rSJAb6pJzO5x+UefGW1X/iTZcU6v08hcc950w+GfhBmVBvMi7D78maZKdn7rc8CqNnDJOzotYzrrrwJ0nZFqdGyBgurC3GQxWNCG3bHXvrUwqHZPIaCb0hlqKHnx5TvLZ9bMhuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=C3gP6yTU; arc=fail smtp.client-ip=52.101.66.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ioyxZAJtf58AJDLHaaIGxAMgRNWb1XdgdSztPYlsPyiDZLVWkBXx+GBSAnRWZlI/tav5sg1NoxGz0BAbh3732X76Kz+zWZuq8j2+9/Wzb5A2iWL7wAetHhnhS4PckfZa8ZyT8LNC7DXMZJ5N5LYDh6hFpwRxXEun+RA6396RPINjdjvnCJQ3vrrA9Q1XFaDreAqxiQLpkUwQVmmxXGqa47ysyqZnqFgV/UM7ZD9+ukLfkNqMJLz86ndtlN3R/c+3QNtv4Rgmj/7/OvhX+hT1cW9qCqy8kYvfw7QYx14t+3emuObTU6BoQhEvMdEiydThfbHKnIu0we9aatXqYx28Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrA30uj+gGU8p6Le1/lccVv75+H/SkFHkrElhvnrsJM=;
 b=wVpu50KRaBvytjF4PDLfxZ+J350sXbYoOb3w25225BXISNW4bwBYBfu/vKkTKwfchvn9RO3Okcm6E5YAjbxTgsMUSXdOwoztoJLQI4tjBj5+qUr+v2CuYfiiovSsi8BaefJiEFVdnWNBsijo3K9nkSUNoQBx8a6bJyazLeGZ0aMYx/rkYA3bdk+LObQLsW5kHjH6N2FktCVKg5HPDxLDLjKkuJaX0RgSGOhUVZv4f4D6X7bjvYbQ/AHuDofU+Ps1RTMhB8CUk6WY1/fIUfWnqUo4Q7GQKriEDFfFMpKCSEaQAS7N00jqAfdWGl/M3mwh57VTKR2BkZThZn1lY6JedA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrA30uj+gGU8p6Le1/lccVv75+H/SkFHkrElhvnrsJM=;
 b=C3gP6yTUS2Knt2ekbUBfY+jGmgkG7Zg+SyXzjCugfqC9u14/lLp3hp+YCmZhZ/rxTTQC5kMa8zid2JbqYQVNsM9u+A3zX289RwMi781jTcrXE/Worlca7XeNbtiQH9sCEauOnVvR8oSh3TcYlmC5sLlqUpB1W2HNq4raAycnnSbl8NHr7n9/pHackRrQ6dy/oYtJYj88T0ULcdD3M7XvdIWSEVDI0T07l9DqIu6t+lT3yR4nyP8j8+8EmJs44zjo+r4KqWQUZ2xxJE5QO5uQjJTa/8g3suyfshlXeulO1IWqQ1R9t/fpNTq4XkCA9dXM+Xn4Y0dqo60o+d+N1YHTfw==
Received: from DB8PR06CA0061.eurprd06.prod.outlook.com (2603:10a6:10:120::35)
 by AS8PR07MB7143.eurprd07.prod.outlook.com (2603:10a6:20b:255::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 08:06:43 +0000
Received: from DU2PEPF00028D05.eurprd03.prod.outlook.com
 (2603:10a6:10:120:cafe::be) by DB8PR06CA0061.outlook.office365.com
 (2603:10a6:10:120::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.20 via Frontend Transport; Wed,
 29 Oct 2025 08:06:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DU2PEPF00028D05.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Wed, 29 Oct 2025 08:06:42 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 21E6C20105;
	Wed, 29 Oct 2025 10:06:41 +0200 (EET)
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
Subject: [PATCH v5 net-next 13/14] tcp: accecn: detect loss ACK w/ AccECN option and add TCP_ACCECN_OPTION_PERSIST
Date: Wed, 29 Oct 2025 09:06:07 +0100
Message-Id: <20251029080608.92428-14-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D05:EE_|AS8PR07MB7143:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cf222dab-b067-439f-321f-08de16c218da
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?e+b0f8MgAQ7gVq+oDYxmfKM8q0Nv2AmZfL4IdB2Mn4mcjYaTjv7t2FXDQde9?=
 =?us-ascii?Q?Ph0WZOkhehMhYcBI+nxZNchxR6CjXUi7fTA+U3CmREuSjVdX3krND2iUAyfq?=
 =?us-ascii?Q?3HRxZVJChOuKZKOpcn/dhUFmt9AyO/Dmw+JSkfn+6N6SYaqiMKg/iBxRHyPS?=
 =?us-ascii?Q?ldMaaPiwmQeMh8dLMBco5i9EVkZhh1iHF1rhvUHThws8ep+uiBn9AxYCjqkZ?=
 =?us-ascii?Q?4fktOo5rXUUoWN03wCYse0Qb+gXxeLIzvNN+rmGRWXSVqlLi94trsCPe7ngF?=
 =?us-ascii?Q?2R/10mJ7U18c8AO+FKgtY7C/LOt9gV5cb360WhcqPLI8ZMdC5iEDBLVHFBu8?=
 =?us-ascii?Q?9wzbrbGhk3jHU6BGbZolGqSXQ2qchxs5DiM9xkDKI+7S6JxMqVoNK6yt7T0S?=
 =?us-ascii?Q?7KCHcoiWH27FNmCvuEED4cqWiXDnmsmuPeNl+oj/iUG5j4vPnBCHGQcsqRz6?=
 =?us-ascii?Q?RmxVJLOZwmNCQoyWeeppkTLMW2tB2Laws5l8AiXSC031Epvk4vDXEiX1UOku?=
 =?us-ascii?Q?9QYhQpFg4AntXtqIiGa2jqVKvgFHX0DOtLvdvp8aQhwM2wb4cSXkWK83/FcD?=
 =?us-ascii?Q?yGmuqats3cTGTFbTB/fZdJts4OCnZoWmaB/Leq6SzL4QgDnuWffAhjv1uzby?=
 =?us-ascii?Q?3DjMuQC6gFdGKuZwcXXeNzC3a14Xg3r3InBZmfIkNiRxUKTdATqBTs0puDk3?=
 =?us-ascii?Q?wRl55GDBfVcveRRLlKTIlB1NGrF50DxNEulDf2vJk+w+1jAMWJif54g3YR32?=
 =?us-ascii?Q?AUWEM/n6zH66yLVRbSOC12ilmNEIN/AMosL3up5NjI/W/92tZWuKUVv+AwrA?=
 =?us-ascii?Q?zCwyAzNbP+N1RQyehyfBaSe4zjDMD0889dY8ZyiOW8jCydeTr2VlvRPZJ7Yp?=
 =?us-ascii?Q?31nNj0HY+5CTdUDKcj9QEv/iWr3IiRM4Pe7YfYak4rMvO1xWwEzxoLGBn6/j?=
 =?us-ascii?Q?mR/R8IUYDo3KwOshnOffJtQlHFMWt4elsVP4R4f/KX2BCuu892o65yeNwQ1D?=
 =?us-ascii?Q?y/23nB8zL4c48D5g5trDKe66qqCrYevlQ9Zu6A+PiracvKm92sqS94xoK4CQ?=
 =?us-ascii?Q?bDFckRTKcqXEEiZqNY/5abGbrTr0SwXGnfvMGv8IbUYU3BFkii3bpQtPqvaG?=
 =?us-ascii?Q?y1p7dEg2FpUVEO441boc8spU5Vu55BB7szXyltB4m119fLOn6giq7Iwrs3nH?=
 =?us-ascii?Q?EwwaXgEUdjeR2+RV4y39Uhj6VS86m4eibDa+KXyTJzcfQoGHOMT1vMQgC26e?=
 =?us-ascii?Q?t4grVgo6+tnFh77qndj+PhkYV6iTYpwvH2/1yWJRJpJe0U9b7EKdLrgv2Waz?=
 =?us-ascii?Q?PjGaysJ6d8e0hqm/ptMCVdF8VsyrM7ZLfuH5F2WXdywkXtA3tAm1IvZ3ywQG?=
 =?us-ascii?Q?V70xFIlkvCT2kkp+wLqlHCSoGdsU+9c/Y/Ysr+8fnUMNmfsRzQUf11bma2Ho?=
 =?us-ascii?Q?i81r31YrpV42vHsvrafQNft/FfqhaNoNg+T77GeCbz/0leAc3YJgGqOGkOsN?=
 =?us-ascii?Q?atpzaRDFWvqhwSowFtr38O478qSQ9Vt5RV7emS0M5accT+75CmsrfCqxtxF9?=
 =?us-ascii?Q?QMZj83Fc6Ijq6elQPy66OJte8vZ3DFqLynYNQakh?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:06:42.8789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf222dab-b067-439f-321f-08de16c218da
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028D05.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7143

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
index a06cb99d66dc..88ce54bf2a02 100644
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
index c82b5a35db28..d6ffa8492365 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -29,6 +29,7 @@ enum tcp_accecn_option {
 	TCP_ACCECN_OPTION_DISABLED = 0,
 	TCP_ACCECN_OPTION_MINIMUM = 1,
 	TCP_ACCECN_OPTION_FULL = 2,
+	TCP_ACCECN_OPTION_PERSIST = 3,
 };
 
 /* Apply either ECT(0) or ECT(1) based on TCP_CONG_WANTS_ECT_1 flag */
@@ -406,6 +407,7 @@ static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 	tp->received_ce_pending = 0;
 	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
 	__tcp_accecn_init_bytes_counters(tp->delivered_ecn_bytes);
+	tp->accecn_opt_sent = 0;
 	tp->accecn_minlen = 0;
 	tp->accecn_opt_demand = 0;
 	tp->est_ecnfield = 0;
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 24dbc603cc44..91a90c34a810 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -738,7 +738,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
+		.extra2		= SYSCTL_THREE,
 	},
 	{
 		.procname	= "tcp_ecn_option_beacon",
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index cc39056d446f..ebedcf0ea0d0 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4802,6 +4802,8 @@ static void tcp_dsack_extend(struct sock *sk, u32 seq, u32 end_seq)
 
 static void tcp_rcv_spurious_retrans(struct sock *sk, const struct sk_buff *skb)
 {
+	struct tcp_sock *tp = tcp_sk(sk);
+
 	/* When the ACK path fails or drops most ACKs, the sender would
 	 * timeout and spuriously retransmit the same segment repeatedly.
 	 * If it seems our ACKs are not reaching the other side,
@@ -4821,6 +4823,14 @@ static void tcp_rcv_spurious_retrans(struct sock *sk, const struct sk_buff *skb)
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
index d52229d32b4d..41e9a7a50538 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -719,9 +719,12 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
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
@@ -1191,7 +1194,9 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
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


