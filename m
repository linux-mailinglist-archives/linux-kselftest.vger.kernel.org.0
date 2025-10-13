Return-Path: <linux-kselftest+bounces-43019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 08638BD56FF
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 19:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AABAD505F82
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 17:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048B92C0F7F;
	Mon, 13 Oct 2025 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="dccUjx/c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011051.outbound.protection.outlook.com [52.101.65.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C994304980;
	Mon, 13 Oct 2025 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375049; cv=fail; b=cyf80K2lS6Oc4UMr3LhiHJtq0Aae+vQ1EG1GndD1MILndbdpItVgUMegurn6WJHUl3TeQhRGrlFL1Tb0alnmFNjaeO8L4+orQ4aNUkjwzJTPJxmFSETTrE0KsHKXR+MNLn6Z4ERrC8A+BH0tjRQ0dDY8to1ORyUa9MBELGKtshM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375049; c=relaxed/simple;
	bh=gxYXMIX03x4zrPZwMbylbLjmy1iqmbe8hBQKIJVwOV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G53+ChEvvhgueScqXO1RjJsQkk/3DwOIVzYq5GQFHeyeCFGUZTxEAFB2Rw0DxVqriNXIQ1iTF7D+0Fi9hqo/ahd6WwCLSbVW9jAkXDxLZnMn3txCPUrq5BeZ0gH78+ea3S1F7Fa+Uap/ra/3um2hWR9/G7tIVYHsy2Mh03yQ8a0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=dccUjx/c; arc=fail smtp.client-ip=52.101.65.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJGnzOPI7/bByacInRaeudX8PA5M0iFXNgHV9Ei1a1BjlaJgOVDqpxBxfRFsa8zvVlScxjUAq7zCYmL1OZtYt0FMy7ST7uB+rgh9LjT4L0PvOULda4oeP62HlYZtNTADlZV38Eyus8Tc0ut7NTxfp6vT5RaDF7tSFTRFmOo4sFTIWTsMI8JIalk0fj+Q4UIWE+EypD9Nwc5gXQE+Jc6xV1qtB6Omny9H4K6d/t/+M9FVEk/DHXK0co4nzXYY1TYrjZDDS6Wn5UhWW/r8Xa6aIDNBht+AuQl8sQgUOI2zfDzhWarZGJeX0/bvSubWnlIccLe5x7VC8iH4rf+7gqlGgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcWoS2xkl//YukgkUEH0jurLeLh+0P7TXyiZyuy61Yg=;
 b=U1Fk/vl7mA4ZlGqe/yQjFnWQ5MqdxqKffZRRpG65S2wVHo8bhnf/jfzsTgQA7SepUctzPZgoH6S1D4CbpugQkJAv02C3iY1+9nveZUzBQF2dCvDUxiJVDiRja42Hz4Ax+0pgzob2sjvBD+zkLHFU0ETulRbCLknlmsvlmhiKdCLDiZJn9LgI21jqB0fTjkxzxisD78MPxAPkjbEV4viYJl0m592GgTAcpKM9cqrJA3OT0eKkJdWOj01wcQJ07ZYp24So+RlDMmlotvESj4g6Y5BTtqaKZwlawQ1gWQLRxzmMnCnyqileV1dvySnkjXIO9cMoKQaJgeylLCJj167/3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcWoS2xkl//YukgkUEH0jurLeLh+0P7TXyiZyuy61Yg=;
 b=dccUjx/cgTRQ/UntldFhKt5mQf0OjbwAQ3UfMIMDbYxYeJ9nBJU557KoZRCfEyEpycu9NEyLiWmJtxxKxVgHDE0isBU/ey3nbAk7r7MuRUSYMB+KMEHoSPovGKdVD9PpEOsxnjTbpveOKYzKySiyy5fPKDUh2jmq3JniFbtYeX3+KxRI/ZWZJpNSvk1yHZpwioK4IdUSStzaqzYIoPINq/SIMkoHtlmn3JvIktvFsu4RwQOxlVJeRSbNp6mFX95aSg8Zhimj6lxxVVhyronXODCS9tTIOsBe6YRETQgQnpweeTQ4Pk9jevB37w/QIw66Xh/eJHQVVUAg7yXn0f+Ytw==
Received: from AM0PR06CA0124.eurprd06.prod.outlook.com (2603:10a6:208:ab::29)
 by GV4PR07MB10906.eurprd07.prod.outlook.com (2603:10a6:150:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.18; Mon, 13 Oct
 2025 17:04:03 +0000
Received: from AM1PEPF000252E0.eurprd07.prod.outlook.com
 (2603:10a6:208:ab:cafe::6c) by AM0PR06CA0124.outlook.office365.com
 (2603:10a6:208:ab::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 17:04:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM1PEPF000252E0.mail.protection.outlook.com (10.167.16.58) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Mon, 13 Oct 2025 17:04:03 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id A03321C003A;
	Mon, 13 Oct 2025 20:04:01 +0300 (EEST)
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
Subject: [PATCH v4 net-next 12/13] tcp: accecn: detect loss ACK w/ AccECN option and add TCP_ACCECN_OPTION_PERSIST
Date: Mon, 13 Oct 2025 19:03:30 +0200
Message-Id: <20251013170331.63539-13-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM1PEPF000252E0:EE_|GV4PR07MB10906:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e77ae328-6cbb-4aef-fefb-08de0a7a82f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qwEZFbZaBfnH1+yOphW6kem4sFbZPxtFORK1D4HpVeqM1uhQkE7QedI8pnPg?=
 =?us-ascii?Q?NXbL7P1XCiHk8p4wGM5qySE9+ehQOZveOtPIiUXoJ7Dlma3UCud+amK5EEMk?=
 =?us-ascii?Q?Js3c1miWhSRQ5Gi1Hmer5Hf3TZZslMY7BrIwnnqYbMWCB+fESRp8TIvakWJf?=
 =?us-ascii?Q?DEx1TKOGdN9h+DHfh9GRyMNhO5FAWBUly8+q1ry2SM+kUqWKsJTE2xliEOSc?=
 =?us-ascii?Q?VI3xjhEB4Qsxoz13ZbWBl2PLrPEnE/bSGmk3FO2s5IFHyxVNry1igCvqMAwL?=
 =?us-ascii?Q?qVhZ6Fjgd7QwPcSJzVuG08O8r81dhZvNeEaNp+a/oyNQ6PZXg6v6JXoUQ86J?=
 =?us-ascii?Q?qSIAd4kLlI4oaReHLp/s3D0lps38hSzkHINDC0B02bzCpMtQwXjgGiimbx7j?=
 =?us-ascii?Q?KYwzANMk+eSnCLx4WAs2167thGd8cNydoDZQ8dMRsBCaZQVCgFyMlJpx75bp?=
 =?us-ascii?Q?FWJKT9a9ocrc+L3VFJRgB2R+m6fAktZymJcypy5luxU/uE8Gp4Zal+f7hY4b?=
 =?us-ascii?Q?I6qqXdlD4srgPdFimGjffkejeocbYRcwSgBXUXE9OjVIXsXVSOIcqkwWALyX?=
 =?us-ascii?Q?urw4L02PXQJwRuG/IYGIDliZv0/a9jom61c6bhbyCFS4tTBtw/4+XTkd2Sag?=
 =?us-ascii?Q?6ERq2yCw9yc3pHzITVtMVm2J+Oso9qXZRg/KfIWPRflmJbsjAC4GbLJbJaHn?=
 =?us-ascii?Q?XtpymYwydiukC7pjRl3O+nNipdD/Pe+Knbly/dKpu2lISZSHI6kccei9pk5V?=
 =?us-ascii?Q?D+VEUENuDyevXRzg1kZN5WDM7Ur3CySCihT+n00zbs1wbQ2KvfGeU8odbsV/?=
 =?us-ascii?Q?0nZoQ/xsRgFgHIIWClSrYVnjGsx5QW630MUs90hHKYjjU3+B6hTeupKJJ2zL?=
 =?us-ascii?Q?1EJjbmrXti3yOUk2G/G1wpiqHuSTzDYfcyyQDNIj2idHgm9cZ09hjt6ymQub?=
 =?us-ascii?Q?KfRvoHZFmGeduUi81iUhEsUKAKMh1yHI3hJzL6pE6RhLQx3bh3D8CYzHOhva?=
 =?us-ascii?Q?wLs3IFabTJFqJ1QVjhatDtl2C+RiqlF52wX8Z88x7qsAdu+U6HxMBCeaBpM2?=
 =?us-ascii?Q?wY9n1veGXl6v7gTROLoEXSk1bVbWVLJRUqSrQpW4JCiCSVQ27Ou6ELwU15km?=
 =?us-ascii?Q?rNMjFe+6mvyYzDndoHqcad7m37uSUX9TUOUdEAmZp601WSfAtDcZW9QKD3Un?=
 =?us-ascii?Q?xNr0VHv0//HMQfWXiiC3IjTGl1+xRY+hxsdn7h7Q6RAbrOfF71ZeMbtcwfxr?=
 =?us-ascii?Q?02I6q/a1S8SXtYS4blqDZitE2/hihVN24nsIdwbEVtry/HDCRoEOm+BOjsA5?=
 =?us-ascii?Q?acsdgzTCVsaQncRmIGcKCnOS0fkR66PDSOogS9QYXlFYpGlOzMv9xNV9x96U?=
 =?us-ascii?Q?NjugFKAD7gxwJNdDHZjvw3/rREuhHKUVEw/fSrLOHotjqrrJpiQGw9CLpDp5?=
 =?us-ascii?Q?FvujDTwk7FhnrbRmdbLjzxVrmtUT+6t1PJcB7NX2gQk8vuadcF+wUCIqIZoG?=
 =?us-ascii?Q?Q9fQE9OwCfZgTS+gstreVIqOgmGS5x7kviO7547VfyrWyAiIr32NVRdo8Fu6?=
 =?us-ascii?Q?e///NN0HN9tgvr5QJnOkTuVUCQJmrHEl08v8KHko?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 17:04:03.1821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e77ae328-6cbb-4aef-fefb-08de0a7a82f3
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM1PEPF000252E0.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR07MB10906

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
 Documentation/networking/ip-sysctl.rst | 4 +++-
 include/linux/tcp.h                    | 3 ++-
 include/net/tcp_ecn.h                  | 2 ++
 net/ipv4/sysctl_net_ipv4.c             | 2 +-
 net/ipv4/tcp_input.c                   | 9 +++++++++
 net/ipv4/tcp_output.c                  | 7 ++++++-
 6 files changed, 23 insertions(+), 4 deletions(-)

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
index 2dfd2fda085d..13315adb5bc7 100644
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
index 61aada9f3a6f..edfcce235d2c 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4808,6 +4808,7 @@ static void tcp_dsack_extend(struct sock *sk, u32 seq, u32 end_seq)
 
 static void tcp_rcv_spurious_retrans(struct sock *sk, const struct sk_buff *skb)
 {
+	struct tcp_sock *tp = tcp_sk(sk);
 	/* When the ACK path fails or drops most ACKs, the sender would
 	 * timeout and spuriously retransmit the same segment repeatedly.
 	 * If it seems our ACKs are not reaching the other side,
@@ -4827,6 +4828,14 @@ static void tcp_rcv_spurious_retrans(struct sock *sk, const struct sk_buff *skb)
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
index bd718e342638..207b45a86938 100644
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


