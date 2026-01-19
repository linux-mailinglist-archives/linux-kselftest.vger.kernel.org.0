Return-Path: <linux-kselftest+bounces-49406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E725D3B6A2
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 20:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA7D53107B9A
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 18:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E6738F953;
	Mon, 19 Jan 2026 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="QHsrSoV3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010014.outbound.protection.outlook.com [52.101.84.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9449031D366;
	Mon, 19 Jan 2026 18:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849176; cv=fail; b=bUg5jRRfqQyMPLrneZaP9328KLokMIp4+z/1RzApUZJyC/6t6tLFiITa6VJwvJZ1tAl2LgkjpQDPQ323crnjy6D4OnUo20WY+FwR8rwM9cw1tbn43FLPemOx+MvOWRvVm58AYaXEZenUujGMNpBB74J59oBArJGdrbm7xpEROTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849176; c=relaxed/simple;
	bh=d4yI9DT/FM0FSTlrR87geX9IQHl6S2bf6ucpS5Jt+jA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VYbEOQdcsiqU5Uk++1KIE7aBszDGmAFVY4B5/M1cmuI6LQFkU3hsKLoQgAqOQszs3JNM9dOsgzs8DC8OOquHyEhi+Qsr80BtDotW+RL5ZPIcK7BhzkOloOwpkunVYPLzcSHW4Xg5g1Nd3j2f/qiHyRg7e/q8SCPVthf+gAFy6Dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=QHsrSoV3; arc=fail smtp.client-ip=52.101.84.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXHEIpykXL1F/LkzcWOpn3nTyWxfOKnYzuYTyhkLvzdbtzxy7H2uAPnbdT0xzTaLqwF0x23Tb+bBif6XQaskTTtWECSkmfyK8HOuGZR/q6+omfST4u5Xw0eNB8X5r4AAPC5Ck1bj5IKjmBFi06H4NN70opqBs6szZQTioiV/iRidyoqaivILMJSxwx8QxNZBsw4d9WZBN5chLbXX9vUfIsTVUQR7DS7HLQFh8RDu2cmRLx4dxTWDq5GVN6tTQgRXfyweGlLUiReZyPHghICK0BW8804zEBNOvkfNxFElV8F1jDJMErGOK4e9Az/jABOhN3wcmLapHElrx1JhniNDhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4VpCraQzd+TntMfJs7ZiJN9Q9x3RnOzYQScqxN67XY=;
 b=aPeFaBojh3fivHri8oEkKw4n/zsUXPKRgofSu+E3vpXHlJ8HmmzwSsvP1qtRgWNm6DtbXx4qH7Uq8r4/zXV0UsZ6EVA3RFbs8xUcFHMWXDN62TUBc/LKXJPMZUEE7dUjpNmQSNc+bbKQp4FK1ZVtP6c+aFhcPdc/3368rh5xYdKj5TS5mNPFh4N6Ktg8slZC8WVeD4zvA1eRVNMPJf6sUAIZi2QEy0RHRMTM7IsxIjAC3OXZUeMButI/wW8GmiQU2cMBAmKML9qattRBe922UB80gEkV067iE22RWR8DzPr95qpSRZtKTgGwv5R3aB4nPO6oidVb5cL0quQY97i7Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4VpCraQzd+TntMfJs7ZiJN9Q9x3RnOzYQScqxN67XY=;
 b=QHsrSoV3i9+REQ+5+0Ewjc1PDeAi84onaHccJnSsuY1XtkrW7cFXAOq0zK9uEDVJPb2HMAvw3d9JRhwm5WFAd9NUKXgVL4Lt7VA+2wFKX0TNls/HNbwidC4Vvi1FaIi7KXdyHwf7iGD/hSk9TaMN7JYEGQGml7TBPIzOaihFlO+yPZRgcMgYo0EnmTJUUQMNlHP85NAD12us6ZiHmlGxyuBCH6hLbNIW68UJP0Bk6NfErNJ7haWKJasqNJ4MdJi9G0ca3NkPngDc5gKX96I1z4gX1gCHZLPYXQyZ47X+C87geYp2Ep6zyvpdSUlMpNAY+/ap0vsc4n8RaS9jWZSEdw==
Received: from DUZPR01CA0061.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::19) by AMBPR07MB11912.eurprd07.prod.outlook.com
 (2603:10a6:20b:75b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 18:59:26 +0000
Received: from DB1PEPF00050A01.eurprd03.prod.outlook.com
 (2603:10a6:10:3c2:cafe::eb) by DUZPR01CA0061.outlook.office365.com
 (2603:10a6:10:3c2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 18:59:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB1PEPF00050A01.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Mon, 19 Jan 2026 18:59:26 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id AEF3F2014A;
	Mon, 19 Jan 2026 20:59:24 +0200 (EET)
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
Subject: [PATCH v9 net-next 12/15] tcp: accecn: detect loss ACK w/ AccECN option and add TCP_ACCECN_OPTION_PERSIST
Date: Mon, 19 Jan 2026 19:58:49 +0100
Message-Id: <20260119185852.11168-13-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A01:EE_|AMBPR07MB11912:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4b616a6d-5831-4787-321b-08de578cdde8
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?OZFbyIlaDerUDdv7Yb2PjpIo06UkZmJ2pkwrwEOFrvrR9pHJAiruiKhM+yAR?=
 =?us-ascii?Q?e4BkhfwcqQ8Jzkt/hKam3EBSzXX791fIV8SqnNhUW6yXDqO7LDzrZKXjY4VS?=
 =?us-ascii?Q?HKmmuBVrFyRtRcJhtP+ZzRaGz6WzhSOpffL74LWQ8uWk0JjyEfPdVI7T9lYT?=
 =?us-ascii?Q?91v0qH7Bp5WXVRTP2lF4KBfeIp0iBhteJC17jEuhadRZetuT4am0p/zwfoL+?=
 =?us-ascii?Q?ffj28tPm3q2WdjTWMTdQ/a001t3XMILgZpr6wbsmSTAJEpgYavao7ygCvJ88?=
 =?us-ascii?Q?X5LTkM9AOJ4wK9QSvT40hhqBsO41hMzlRX0CFpUWtMUt6wurc6j+g4gBdzq1?=
 =?us-ascii?Q?YmZ7xC6ilzT/uh6AvUr8JtCVeQPVlA+2WgUVQzUkoZhv6hKc1N2jSHpMkfua?=
 =?us-ascii?Q?1dm6/fZQXYjlRGzosZSrHrCV9bUxLTmYedmibbEFj+9BrGsTqD+WJBGAQc2p?=
 =?us-ascii?Q?sUmj0MHXjMtAxpGmTb4E93+/ukNQyxewb+GfMX3CGOYqs4/9ewb+599K1Co5?=
 =?us-ascii?Q?K6arNDopYiwNnWvaFuvOUxxJa5ubhsMKeC7nEPf+NUhZink4ErfGdrBoK17U?=
 =?us-ascii?Q?+ABEktCdRSKCVhwPtBaAHGTdhQH3Jo1EU/AgN6tloet04Xoo3TWK2gQdMXf7?=
 =?us-ascii?Q?VcE/16wPHquuairhJ103UQEgR9dkKw4RlI4yhLLhqsOgIx4n4JR2BD7wQTOM?=
 =?us-ascii?Q?1AGqoimH48BccuwadT67QBPkk3mqcUegupgdK0WrjlYtI9dtpMbQDylppEwz?=
 =?us-ascii?Q?KQxlV0tpfI/YTQAeAZ5L/8yITopKvrdY+RtFB2WDTJnjclGP+yWwBaQnBzRD?=
 =?us-ascii?Q?4gcg738bVD2T4P+MMx3T478MLiaOBopGnH3/eFgT6b2D5mNdAMEqv5ojQT4D?=
 =?us-ascii?Q?UH6t8m7WRzIFLcoeUIsQMmbDVZeDt+ys90BOCs2Q1aKUGGYYjxt/wlvp2it9?=
 =?us-ascii?Q?naozohtT7jXQ6RSAiTLNesGrjhT7YUIuFQXF7OaItCsAcx8JqrRFGuvvk6Ck?=
 =?us-ascii?Q?lg735plBLpTXcr3oB53/lE7SqNvVhsCP6Dza0ztJv89PYuHfp/szp5O7SZo3?=
 =?us-ascii?Q?YTeSVGrQIoz9GUNoNMnb5KgaR7JPYkSDsq/ULSW++54SPikFpdPsuMbOeoF5?=
 =?us-ascii?Q?z5s4Mxd71V3DROJ7GRLudJIWJFIiGfR3c/AZrXsVENUUpFCZxmZYPSbYRURz?=
 =?us-ascii?Q?KkW8rY8FpUOlM589Q7Q6GLk7t3SwV1V5xign2xMug+OfQk2yQy0RXg5K9Tdv?=
 =?us-ascii?Q?O03e2H7Qnna5+JFKvFLF0i8XuVWBWNSbvLerLIiiIuCLLi4KkW4lFG4gYtb7?=
 =?us-ascii?Q?gEz2zCNWdjHH6VQcH7gUP/bWK3ygF+OvxB28dEKDg5L0KIrgkyulbIWPG7xT?=
 =?us-ascii?Q?rrUk/ONgGC+CEfD6EIUBFH8JPh8wcEnAN2tYF6PgWaoDQmJLvwvLVdYUxdOa?=
 =?us-ascii?Q?uiCsG4yd7YhEHkc2rpNEx4zqHX53UCUfAl8VBuWWY9dJ2TrIztUjkyvkVZ8u?=
 =?us-ascii?Q?1vE1eQaj3/oqNmsTK//6MvPvCieH6uIc1ztMbd500V0u7XNA3Yr5R4duZkIX?=
 =?us-ascii?Q?D0Fgh00J2/6j+sj7mzyN3p0nF/Y46h4FVFVmYyEi0+9gJI/BZXqUraV4Rdaq?=
 =?us-ascii?Q?2zx7Wic5CFExC8v4q0/ubTMFZ1sTE6sGW1XrUNm7CQozMbSCRe1e0UrFLYxQ?=
 =?us-ascii?Q?X46rXw=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 18:59:26.2397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b616a6d-5831-4787-321b-08de578cdde8
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF00050A01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR07MB11912

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
index 042e7e9b13cc..0cbba38ea87a 100644
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


