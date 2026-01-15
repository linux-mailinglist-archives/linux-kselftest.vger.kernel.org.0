Return-Path: <linux-kselftest+bounces-49029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DB6D24801
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 13:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 353A43030D78
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 12:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3955B39C655;
	Thu, 15 Jan 2026 12:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="MDuc/DTO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013011.outbound.protection.outlook.com [52.101.72.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD4C399014;
	Thu, 15 Jan 2026 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768480172; cv=fail; b=UAwE3M1jLB+sE9fclhtsG17rUAp+CytPL/jQP+JvS0ro9LRRb04ZdXaGffrtlK1AKQ8xGbFeL1oKZaOvBG8wTEVfvArHLLaMFoTN4FBvAFdaXJnVBvB92m2l71y9XUFURJ8gN7OMYGUtkz14Yls1tktEBrshsGijonut7R83SZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768480172; c=relaxed/simple;
	bh=7ojpNkKwWUDh+eE+4Os/B930+fif6QD0C+jWqdudvYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J1TZjNdvvKD/t6RU3S5ZC5eyzoOYdgLiDapr5MndEP46g32RYd/Gs0kqTb9VZGgowq6+E24gcrmsq6lEAC+/J7Ad6jKYp5un2zbYa7VuiCB8rT6MzB2taTI3rVMGNznqvJ0uaoM7icq0f/jLvab2Jw1xaMGK/6pyeKSFnyDVIL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=MDuc/DTO; arc=fail smtp.client-ip=52.101.72.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULTB2DTSfBJu4nZWHcYua78e9MzNb+eFwVz6/ot8FJOgw8Qfqv2DXDd23P3ZsgADK4w+57Pa42YYjkySH7JCpJngoB9mFEjyJwxbGf8HPigyIVz34DtrwbKdKclRCYog0z2jb7/q5BRYmy8Izat1vzJcjJ+cULW1hkZd3dGC2uPD6+exahVUGK/Xg6SXHksNrHLpIB+/qa2JF12KeL43rdwfK8rAqQvzTTeNK6ugV0vY6o194RsBKFPshI9EE11kictrhK3u2YquFqWrFCBXQXx0/9rFVZ9DIhnhAKSCWPA3V3t+Exz8eV0ESXBFqPUeBwXUXqWNFz6+yYhENJNvsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+Q4yXxugPadglH5rTRVxqLxqqAbLIb/egmfb56CdB4=;
 b=Fuv3wZALYl0NrGR/ZQcX/IqLEknpNDgwVq5jKHy8inAheJU6ghGW994ovoAHJBN915l/WHHyOrx60thWnaMt2+8278BV9CqQTtXbS+V94aoT7qE8wkzP+NSs8O+IDoTzdDUyi0D2rMTEuj5FIaOqR3VVCyb+hsvcjgKnBS6mXtnuka1aqapwfPYTGK4snC0W11jRewsqrjXZWuJYsvmFZXEltE48C72wNSxNYr4NQJYX8y84s29XwVDyhJDgtRt3g07WeWWdQbDskfdp5AHdeVWOFhomZ8mI8uWnFnEXRWVbLzykl+2llRcyj4IZHS5LBTd5IxGB3wgc5WYfp4nTkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+Q4yXxugPadglH5rTRVxqLxqqAbLIb/egmfb56CdB4=;
 b=MDuc/DTOnoc9aidvm2DTxvblWrvswfwInUMzYAuWBSdRDExsMcOEahNNCSUx7yJP4ou91dtnYmWehMZKjH0wh3OLwgcdwn9lwe1JlrbWzv5wn4qavPoC6JA5ZDUR27hWT2Tm5m3p0CjH+u+uNdtC9AmG5zr2jonsixEjtJRGiXqMW8uZQ4WbiySOI5BjvWMd4rRsNBhH1ZOcGRiFtVAuHvqPWx9VH9amJ0WD+TYIuDZ9gJiGLrHLE9qmc9CMrZ4Zgsk3MSeAONhHweXqTm+WwNmEAOFgDFdZGY2U7Js74Z7y1erUHhg74tIO/aHfE50BorYUAepoo1/hwvsjntoW7A==
Received: from DUZPR01CA0303.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::27) by VI1PR07MB6606.eurprd07.prod.outlook.com
 (2603:10a6:800:185::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 12:29:23 +0000
Received: from DU6PEPF0000A7E1.eurprd02.prod.outlook.com
 (2603:10a6:10:4b7:cafe::d1) by DUZPR01CA0303.outlook.office365.com
 (2603:10a6:10:4b7::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Thu,
 15 Jan 2026 12:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DU6PEPF0000A7E1.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1 via
 Frontend Transport; Thu, 15 Jan 2026 12:29:22 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 3AA35202C7;
	Thu, 15 Jan 2026 14:29:21 +0200 (EET)
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
Subject: [PATCH v8 net-next 12/14] tcp: accecn: detect loss ACK w/ AccECN option and add TCP_ACCECN_OPTION_PERSIST
Date: Thu, 15 Jan 2026 13:28:44 +0100
Message-Id: <20260115122846.114576-13-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E1:EE_|VI1PR07MB6606:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 188297a9-bb6a-4d10-0005-08de5431b6b1
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?9oky70URQQ0RYn7dGJAJUPDiikfhdh6Bp9ttns1d7HxSmWk4QiURjFWmDO1c?=
 =?us-ascii?Q?nzIBKRAzOUT8YqzlHjcIXNvSnpz/KRNMRi/6GeOKLKRoVKTEV7uReHBwCZi7?=
 =?us-ascii?Q?nqaXbTMhWON3LhXpCck2kIZW2jAY7dD/Opk0j+x9SAams98HPtPv/S8a1j47?=
 =?us-ascii?Q?WFOOcbY0SzKGLLNBpbVm8UjiNywZNX+ihCROnS43fvKXAb+ElhUOWRBGuN5c?=
 =?us-ascii?Q?y/KnizHyXcVopmlNSdjnRi2MXmi8noCghodt8dB150EfhS+zJ4QH2Y82Gtso?=
 =?us-ascii?Q?4xxkeUrc45ZXclNp0nMTpbhcu3HTkwz6TZZ41bDWzo00xBxxQUi/LsyLGDG/?=
 =?us-ascii?Q?R0ctdRDSNJKeN4+qBc/n43Cdn4BZLq5JTHyjtrNupwY9FbI0BEngVGYcX0kE?=
 =?us-ascii?Q?0plrTQ+WKeR3Fzuhd2VqZ47AfYTfWYHNLW9nIUxYDIdfUdURyx4jMQ8YUHUt?=
 =?us-ascii?Q?rSdNNJ4Wadf846qfSG1frnr4vA1XCvkjVhoTLqQ66vpiu5inrJJivZgXKo34?=
 =?us-ascii?Q?SfxaBzgZhZB3VtX/pjVbgtJT30qSWP7aaWwH3jQ9wgRGu3Xia0tvRdZVtfKX?=
 =?us-ascii?Q?DjWIW3tioF02is7XiQ9kVgkFieHb07Th9JQR3xLsRhuWUFScuphoy8dzPzml?=
 =?us-ascii?Q?emv1OtzNb76KNcb7QfwTwpMyLfXUTqycrGbIMVYa/2GTLfjxipsJOBbIv6Et?=
 =?us-ascii?Q?ytZHd0lRgEgBUxjtmhDEW5aLzYYQHwnt4zGIje5kaEZzsxunGIb/JP0zeO9O?=
 =?us-ascii?Q?1ByF9NCwIDv2xZVAA1mbGmxR/C9G7onNTV9PoDZHHt9Vgud5N6S4Bf9jwr80?=
 =?us-ascii?Q?XQHpXGjNU5xsREIKvnl5LFkCI/pmFAQ0UYk9IBBwb1bkzEDcQko2Uq3abPFr?=
 =?us-ascii?Q?S5fek2dcub9MsNW4E6jHIxASFpTUvlN5rgVtLsBqQKvEJcj30b0K4arF9VGN?=
 =?us-ascii?Q?L6TVCGjRLDUiG6wu4HACSlo30/kyMPN7wvxUPJVEn6T8+yPjgX7SbmDnIUvk?=
 =?us-ascii?Q?6BFS7otgVeORhXUrjcTF00VyzFPXM8Y4p6pJwABgc/3bMsQtt32/Y0EbSaM5?=
 =?us-ascii?Q?p+ZvNaeA06VIAj4mIcn/vL5Ve+Vi3yFy8MB3jEQoaw0KfCyrl328INbWQofU?=
 =?us-ascii?Q?lN1QeOfdK4UoeDasBM9NtM8P4QpgG3YxPq5uVhtwM0ON6CgMgedWfQm0MkKW?=
 =?us-ascii?Q?RsIHQEuzQCURG6lvaiVFLS1QGtAx1mdpWvZPrkZxKRwkl8g87ZsNC8ocRuPZ?=
 =?us-ascii?Q?QmeTmpPz3Wr1i1ueCoacz1Jw9bG0G7fphfyusmW4ZbAZnm1U2GC18g2wqBrB?=
 =?us-ascii?Q?uTFgf2LMD0ogpVT9XNW+oc1t9pppzrP6Zn5duU1rnVqQXKtmUWG5p9TFqW7J?=
 =?us-ascii?Q?OLDLI8jkZw1FaryS0eALDQ/yKcGT4Jo13loe3LdgDxMR/WD0WMCKn5CXLAkk?=
 =?us-ascii?Q?TiM6ErQ0Ped0Gh2ZlutoKy7Ik9G8IAilDB/qQVbb/j0ETsqMrttTs+FTmOSx?=
 =?us-ascii?Q?aGWMHvTW3iIsG7UPCsUZO60jJP8y7gnnsZzrZOUXQbnHDcgBqslZyzSG8N5z?=
 =?us-ascii?Q?yMiafznSTX9IPv1vFRn8buxXRE0N/UYQnxOA3eOckqFb0C7m9nicr8vqGs0G?=
 =?us-ascii?Q?Z0NXCBJuPMW6yFLhCqx5V7fRZxHHMHh1z50pQtZeCxosWa5k5v+6JlyVCSfX?=
 =?us-ascii?Q?s3sxRw=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 12:29:22.7552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 188297a9-bb6a-4d10-0005-08de5431b6b1
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6606

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
index bf7d3f9f22c7..41b593ece1dd 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -29,6 +29,7 @@ enum tcp_accecn_option {
 	TCP_ACCECN_OPTION_DISABLED = 0,
 	TCP_ACCECN_OPTION_MINIMUM = 1,
 	TCP_ACCECN_OPTION_FULL = 2,
+	TCP_ACCECN_OPTION_PERSIST = 3,
 };
 
 /* Apply either ECT(0) or ECT(1) based on TCP_CONG_ECT_1_NEGOTIATION flag */
@@ -413,6 +414,7 @@ static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
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


