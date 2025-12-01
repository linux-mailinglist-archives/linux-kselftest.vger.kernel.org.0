Return-Path: <linux-kselftest+bounces-46824-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2C5C98526
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 17:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4FF74E1687
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 16:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5CC3375D1;
	Mon,  1 Dec 2025 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="V07e02Hx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013031.outbound.protection.outlook.com [52.101.72.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD8333710D;
	Mon,  1 Dec 2025 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607126; cv=fail; b=YU3FAzBQH2IdVhXv0H7+1L52KbiZgZeRDvNJ3z2LQW7tWQdFP7P5I7fsfT7KPBJ3YlaBH/0NvxY5gbff3eHdiTjEkf9ja89x3L1O8gQaFt8MEpYvwc8HQGo6Oqjt2oOgeyShN2STFrtMMzCG0Wdvrw453mgz+hk9TxJeBnddZA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607126; c=relaxed/simple;
	bh=j9ZeZNSfPKfB6IEsLFGub6uScWn4IgxqnPRDldPpxlw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J2nIt4U1Ol1PUiujf9TuMUfh9uz7OG7p54jEPKWfdKrrkdJVkX2IJc5upYZDdFyDTQg3+39N+aAqiDNDiq7I+L1/+5QNEQDq7iqwIsha7y0vZayEtn3yggtpStKdKwziCx6YcWmsLfVhLt97gqzcJYXXbaZSvRyNA14dmG81JxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=V07e02Hx; arc=fail smtp.client-ip=52.101.72.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edu0oAu+oBMsOibsDunDelhGZR9nF3YJHUAo+uLGGaV3au7Nmh+hTRicF7qjWninLWOXXkY5fwyJkQrBsNji62bPD9JvWOUXY1UW8iVaLuN1OAk9n8UfxHNNMmFfNZLKMACMAjEt/nXjtFTgMQzfT4HYLiOJI2XP6UReSInpoOpypqu3DnRj5IFTMeQIQA7dTG+1STbu125+ZzKL2li3ctkfMfwe5r80Mdwe6oP1ZlgdKWsG1B7T/2q0hO6C8MwEGc4bzJNph8WNSecfBilhkyvNsBy2Lh7wt82lQnJ7gc7ghGt6VHaZFv56zBRG/yFD+xuKgj1XC58Vll3NXaVydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEGmg+y+pRqp1QE/S29vVIDBeUQBeOHoV9hEhC7UYkw=;
 b=FPuwrPrzW7RPWDZSPfLOSHD6Q5cDfO4USB0hzH6zxdjC0nJxJnWkdVpFUgFuQWzpjWedYJA3yw+ezkGdm2qCbuok/9+jwVTxmgH+B0JLWs2x82IMPvBdYwTcKmqofJ4Txum3aGxhjKVQqCtaTfUMH/sTkETRpcYyvGL4hX4gdvqDNdTq7ESU8P6uV6co5Q/1YTR7RCcIUXI9qDdZ9jK4QV8sZabPRXpPG+T2defZk8/q4lIZmbLf6eggB7S07utgCXiofZxPfq4OmWxH4ss8LHzOjvsQgAdFtSuPDTUd+4d371x34UO8HjvUhaTLpylly5lbSubOHZOy+RfXcCmFww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEGmg+y+pRqp1QE/S29vVIDBeUQBeOHoV9hEhC7UYkw=;
 b=V07e02HxMCwF9DL+WtpN8t1xFlNsc7dp6gWEarfeh9g3lFjOC56+84wpgFCsoYKBH7AZIHQoOOoSX/C8gpHB3I0gmvVJD1C+acw9k5FkTw2j3qbrNogVvOPTJXPItP/IxB98nZUOM9N7A7MWYTprU7dJXzEPUhJblpwSN6z4Vbt87i2Z0JzsPoEoytgCEoCDdypS3mtR6OmM5H2GgmR1ZOgieZrBuV9Kp1UXhU90l73QB3GAx5Uw2P67SBEhrFLobidfpFaBds7MmgCuVcP8OiqHNYbGgNQDUmFBWapAVJ2eKX4GkpjJEKckt8oAg/8WuuPV5mvBgZO0jBzP5ke21g==
Received: from DU7P189CA0030.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:552::34)
 by PAVPR07MB9310.eurprd07.prod.outlook.com (2603:10a6:102:313::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 16:38:38 +0000
Received: from DB1PEPF000509FE.eurprd03.prod.outlook.com
 (2603:10a6:10:552:cafe::d1) by DU7P189CA0030.outlook.office365.com
 (2603:10a6:10:552::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 16:38:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB1PEPF000509FE.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.8
 via Frontend Transport; Mon, 1 Dec 2025 16:38:38 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id CFCC668004F;
	Mon,  1 Dec 2025 18:38:36 +0200 (EET)
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
Date: Mon,  1 Dec 2025 17:37:59 +0100
Message-Id: <20251201163800.3965-13-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251201163800.3965-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251201163800.3965-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FE:EE_|PAVPR07MB9310:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b080de53-9ec5-4e34-5cd9-08de30f8147d
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?lK1Fn4boqCI5+bF/qb5/Bp0sZvqTGuUGQMT5xgDxhjaUMGjZbPZLDNf9M7l2?=
 =?us-ascii?Q?V4Zp8hx17PTDBKBTcBlWNCvKtoEuolX9fHhMnCn6M5TGg23vv72GM+NyZvxk?=
 =?us-ascii?Q?YjzL3rSFJ/0h+j3uF4uHAkyWGlltpZ8dOxmlX0NY4BquveFa3Oht/KmTFcbS?=
 =?us-ascii?Q?pyt2+oXZc9MzTOwadDrXHIkwBIi3QcKJ/mTqAr80d2nrXdF3RDoo5D1NW4HF?=
 =?us-ascii?Q?LOQcINfXecqdNzkD5HkYoMch4Q6TlcvtKT5U6YYz/qx3G30RK9huNQne9o32?=
 =?us-ascii?Q?UpHRKTgy/QxtFBYJKZ1+wiO5NMBJN5MaFmDoJkVLTNJ3Qr3d2sPJdAMgyLRj?=
 =?us-ascii?Q?BHJGSaL/3aP9Fav0ZNhh43pqDLb5uAj2pZyP3qS3GpLFG+oJdh0v9xKLL74V?=
 =?us-ascii?Q?yMYnFcUsKXTuZBX8Sh+vfcs0TuxbI+07bEKVGDhTWXZvqd+/v0NZgZNbR2Ix?=
 =?us-ascii?Q?h64AWLRubJkeKIcwrQ9i19szmGcATCGimYo3l1ct19frD3DgCGzNfvuSTZl+?=
 =?us-ascii?Q?2jGMWMAiVOQrPgUoClVFYLuqnx/e0hr8yQ/PSyyqmt8SydGQibS1APonDMLp?=
 =?us-ascii?Q?d8qcnUZPF94SuGNKH1oT2ZY7QE6EkddnrYGNPi53NMWs2SLHVGPr2ZuBZ7Sd?=
 =?us-ascii?Q?6C644FlKd9X7C2rzmIGa4O4c5NZ6y/P1EYc5sV2iGfPjjqJgWkwkI/FTINOs?=
 =?us-ascii?Q?2RAnwwCaY82lTW0iudlgXuax45MrKE4z3QEM9/zSSjcbNNnc7lVqNhRRwpH1?=
 =?us-ascii?Q?L3LVvYqxp7wexLRsrd065rnX7lV15zBFPdK4enDqInvxsCUwPPC8txO/2lKT?=
 =?us-ascii?Q?OLXz2oKP2NJATjax+lBUrj3WcPsx7o3SZNrup/hXKjv3fMbVVftryR5skCKG?=
 =?us-ascii?Q?kWf1OLCuaKaT5s3V5HTFeB+vgAma+NvoOiE0QuiCOX0G4tZlbDyFl2njccfn?=
 =?us-ascii?Q?P+GVPjY0pye4jZv0Sg1sOgD6QdRSlGPRy9H9VTfgnnIp5jyDJWu3aQGI3+cP?=
 =?us-ascii?Q?e9P6AMuKzQnZrqCtkyzmw/TQ5XhKlVKcj3wVZWOg0tF3JomU7T2uQJuLFXEl?=
 =?us-ascii?Q?lwyhZOWzvN1NZHXBmWGY07aO0/w9AGLfkAhS3ASGZc7I4fkLuNxJY/pBStqi?=
 =?us-ascii?Q?XMDkC0URg7LI0BbGXQ4L65KTs+bAgeYnxVyJkq3tneaBDJMOiRjnSyrohQFh?=
 =?us-ascii?Q?eMXCsASZuHWAdGzUD6aUGNLpfbrW9MV0pm+mmQTULjUaM6DaDctXo3i6NM4a?=
 =?us-ascii?Q?yig7kgRkkdX0cUjJ3R7vDvbFEZ49/2if9hCSZWvMLUlMj0W9WIW2uERU05xq?=
 =?us-ascii?Q?b4zq4i43VQ6IAJRfjHp/meHT53SqCyRy2Vhx3XNfAAnRJI3D+exFxFSpHZst?=
 =?us-ascii?Q?bXYJ2E6rV4DrTPQ/LpYunNo5A4oqLk2WUlW3CJPn53TDS/77GfKq3ccS4n7h?=
 =?us-ascii?Q?SWrDNAqwVCxne5Bi+YHOedt2PfYINHDSq+F2JtzCW6pkQHSj3WaUFhr/HIbS?=
 =?us-ascii?Q?jvyueoV/yXbHyc2xJNk7TEEPqzIgbrJWm4vdK8UVqM5yjoFhrT+oRoprm0bZ?=
 =?us-ascii?Q?fAY9r4ksI8W0Im3/CUxXnQOqgLWUYzyOvLleYVnf?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 16:38:38.6156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b080de53-9ec5-4e34-5cd9-08de30f8147d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509FE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR07MB9310

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


