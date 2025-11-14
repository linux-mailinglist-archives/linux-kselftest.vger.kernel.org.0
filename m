Return-Path: <linux-kselftest+bounces-45626-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCD4C5BC25
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 08:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BD064F3535
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 07:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB13D2FD1B7;
	Fri, 14 Nov 2025 07:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="FNDaKYkV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010031.outbound.protection.outlook.com [52.101.69.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E432FD660;
	Fri, 14 Nov 2025 07:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763104468; cv=fail; b=GXSwbXeiKNgn43zDYjP0MWyDcCMLWJNgGKlviXgKivGWjBLlPpSEzKJ2aZCqPmrILjcuBw2n0UEYQwXGnCoLHtzsdO6f0dwZ+1cVClh9rxj9r8bpqQ4c6wKzK+TlyHLk4rjdKRJOQ/LdAOKruHkL5qzuTn96c8NyjLqBvZrZ68E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763104468; c=relaxed/simple;
	bh=ENae/ue/fP46WcX9cZh+j8lYMjBKM+6val9yR5VowDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J27hhsGKvZTViBSfl1DmumWpZlb/G6aBsFAnI/ggJ4Y1EgWF+U4bXf4kLtpsKUCpNlvDc+vPmUuf8xFi2dr5/AYOZcWBRGjTHxX8t5gGLac/jFjASpr9vzBabUiB98z4NyTOfol3dzBKoPxdPzXk3SYmxmah8dPA685DclNg/Zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=FNDaKYkV; arc=fail smtp.client-ip=52.101.69.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HKrYnLYklBp77A+71hXX9AjxLGSgx+yGQRirf0pbmTtSTdLdG4+wC/iy70LAWNFkAt/kF+DS+lEcgOffq58qi6hoRm7r4nYgpmyhvdXgbwAj+hOeXY4ezEGraqkRFwVFKZ7lIs74X278IMbAN9OJ4cKBbT99uO0gimW+dGjp2Vk7HALW64lFksM8V2d25/GBe9vjmIkt5pbd9jE+rljyam6ydc/YqjqvUEZYslfhZXl7TfYkW0WeFu3FLn5Mj3uSw1UrYb6kQAGuzRMtsrasRBgZRqRSX5nO2QF1ViJMnuIrqTgY60biF9GT5i9N9/lCDZdy2PTFUb3dn9/EFxQanQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdWVREeVt01RFG5GyeHBLHoGz0yLCnyJ+3uzs7RdloA=;
 b=VRfnriyrL8+toioQgEYxxeC7Ek29pBWpQ/6Hv+Gzns5Odv4lbDNPl2brJgeYXHhcipTaYl6ZmlotHCigZekFcMkdvkdgZDmyC2xAji7J1oAGi0IlFtV8eDcoMKJiR2ZXKJD0il5rN+b4Z7EcFZK7Aqw4r6Te0ly8RklDcljQrnjz1nyjARlh2/V+6jZ1URasO4ASRUzFlr4okszNY2M8MgX/8Y2b2LYPX8YG2kr8Z3hwpONq+dLKeJFf/rt4N3xiY8TPASh9wzy8lah42hDkRgW/pGxzv5AKujT3SQdSI1fJ1IQ+4ne1kEPv8K8rpH/cy92D4alXG5AD4Hri+TWYXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.101) smtp.rcpttodomain=apple.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdWVREeVt01RFG5GyeHBLHoGz0yLCnyJ+3uzs7RdloA=;
 b=FNDaKYkVXRw1SbJ8I/gtrtOSnxDvhfeBGIrQvbRnL7/NCm+UMdDh9HOtTxoCvfIy1Pj/TEUKc13VfRMSmQMRGxLdScisgxPudaCQzIenMw3PjJ1XFDvk7Smvp2m25sCrVFtX42go+Yv2T8sHP4WRStNqjJEdWSWGEruKARpvVnSaZTjzubxJRvHvVIAjV/4L1bjKcMBpm4Z08F5wtzXz0qZsCMasgR6441SRgW+NLyInWiotSWJc1Bhm0UqNnNWYLmKuhDqyalrznp1LF19s7HenuDsDIziYLrUR41OcWrI1duZBbxl8PewbvDdZCYaeYUEKLgzL9PDMa/1TPHlO1w==
Received: from CWLP265CA0469.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d4::7)
 by PA6PR07MB11290.eurprd07.prod.outlook.com (2603:10a6:102:525::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 07:14:20 +0000
Received: from AMS0EPF000001B6.eurprd05.prod.outlook.com
 (2603:10a6:400:1d4:cafe::6d) by CWLP265CA0469.outlook.office365.com
 (2603:10a6:400:1d4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 07:14:19 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.101) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF000001B6.mail.protection.outlook.com (10.167.16.170) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.13
 via Frontend Transport; Fri, 14 Nov 2025 07:14:18 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 05E5A1C0030;
	Fri, 14 Nov 2025 09:14:16 +0200 (EET)
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
Subject: [PATCH v6 net-next 13/14] tcp: accecn: detect loss ACK w/ AccECN option and add TCP_ACCECN_OPTION_PERSIST
Date: Fri, 14 Nov 2025 08:13:44 +0100
Message-Id: <20251114071345.10769-14-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B6:EE_|PA6PR07MB11290:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 85a1fe4a-3ac5-4e08-826f-08de234d6d4c
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?gcutDMq8TFvJHidnac1dlwW8L3H4LjYVyxPCmmFzuCKPx2mUiAZRYDWzgAq0?=
 =?us-ascii?Q?6uh7LS7lJTAW5Hy8yffm8HvBf9/4shsTAG+Dt37i5FjDBZ6QCNMZVhrvzD7e?=
 =?us-ascii?Q?o6imkmy3ixNqNbLiQDTArdHbeKW/7ggEvKP2xbyhWE6kES/3rxuA0+xYkse1?=
 =?us-ascii?Q?ur2md8dDCIJUFnsUHoN0cxvbqmwKZ8kOHAYPfZCJ3cVKmUSXEFS1jRpBjVDx?=
 =?us-ascii?Q?ejHasEdQxYnrQPJTVcVbzDoFAvtk36DiOWGvPzhwpAZYo4DnRQSxSPEezGmd?=
 =?us-ascii?Q?e/MUUCEllBUiuG25Wl9Uv8e3sySQHM+LkRRfOd71Yv7nk/cyDm8IOGWbs0TX?=
 =?us-ascii?Q?I8E8jHBYuFi9NlH0O+M2BC8ddEHYhZ48wgTzAWTyXZUVvywsOgmzbl6UfX2t?=
 =?us-ascii?Q?ifqk2QyGKrJUzZtnyXDJdft9Ojp1SrlxPTG1w2E7W2VF1TWcpPUsbZWOhcGW?=
 =?us-ascii?Q?eA1T65JRt8rFp/RdnQyVzBGbmr7FCvREvb5krOl2pKxwERaT3XYCe76lDFpY?=
 =?us-ascii?Q?ZmenOkLco827Adx5MnRM2VJXRaUccYiJ2I2aGGp7QEJaB9BKnur3qkbtk5vN?=
 =?us-ascii?Q?9gHRTqyhj0hjhm53/bb4Cebdkr24zcLLR4xJbRw+y7QGTzHBqVbIc40rfJuI?=
 =?us-ascii?Q?08YYRKzUOSxDdoa+W0Q3geEVSplzveLue3B07oGQJIKrxd5/TCKaljlKRRQC?=
 =?us-ascii?Q?0HJoO3D7LQLXOebKLMbvXq1uI0qhVxmCftGmw/xbXyg+g6/VX7jJhGuMHpIb?=
 =?us-ascii?Q?16Y3a4v6qxa91t4p6s+K8vsPMo2FbvNQyOG1YzX7BGxWxsgrIiBzgmER3g2L?=
 =?us-ascii?Q?e2qR5+4en5NUMhbZAYNkRFTNg4fuNGFRgurfu0bOWnkIwBHde2nZt7XF2wmW?=
 =?us-ascii?Q?/0/PUVJuE69Ej2qcUOZhKjIRp0u1saT2ndg5xjbFWM/t2IzkhJB442PF/C9X?=
 =?us-ascii?Q?2FAL3YKU7MvRYsnyKuLASLvLSRpm0RYKtoZlfhC4asNqFYOFYrGDPukJerVk?=
 =?us-ascii?Q?xj/7fw5WdLyT/mWCLd93zwa79n9R+iUg62mgBdZFkdbaX8ZstBvxkXEUaZvt?=
 =?us-ascii?Q?5igC1mki/iCWAa5hsmXlaf+coKMQ7WVN+aYUjLIQaEO0/xVw0E2no/6W2gyk?=
 =?us-ascii?Q?r74n3jHDgByCIFt7dQCyNVetwOEPXQ7vpLFR5wTH+l6SLUl7hhWhquXrSULd?=
 =?us-ascii?Q?OSQqSOU92G2AFYe91vrOCop1sPBpUCT0n5YE9ITBMposHGZPo0A2OMi6Q3HI?=
 =?us-ascii?Q?VPIAksAiZvuZNWVaw88yLT4flNVSKL6LrDH2Zd7rRznoONrFnpK2j3Uq/Sz2?=
 =?us-ascii?Q?SQYyn87pF8SrmpQ1KLnPAdkhaOGB+wCthpqfqPOv42v46DubisyifROGeMMf?=
 =?us-ascii?Q?QMdyemwDFqJgvDyeYQ6NV/vSsckAOv+VnFPT+oARQa5oGsZGnbTWHvIsibb1?=
 =?us-ascii?Q?xfP7nNiXURUzFA6IKxhyPTPd7kLKiBnxWrS3jyTvWr1AO7RbRiKq7ur0EWZZ?=
 =?us-ascii?Q?LcSMZJIkiLzJu1BHaa7N0ibm8dgC/nXYHMIAliwRU8Tj3imTSybjtwmrChV7?=
 =?us-ascii?Q?DTWZ5R79OQw9FPMRMZVuoL2d+I0RwbIzYPTMCnhf?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 07:14:18.5434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a1fe4a-3ac5-4e08-826f-08de234d6d4c
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF000001B6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR07MB11290

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
index 2bae61be1859..db2b45b34f17 100644
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
index 42fd28d818aa..c15891711f77 100644
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
index 35367f8e2da3..ef21a85e021c 100644
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
index 7638aaa8befb..87ca6e3515b7 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4809,6 +4809,8 @@ static void tcp_dsack_extend(struct sock *sk, u32 seq, u32 end_seq)
 
 static void tcp_rcv_spurious_retrans(struct sock *sk, const struct sk_buff *skb)
 {
+	struct tcp_sock *tp = tcp_sk(sk);
+
 	/* When the ACK path fails or drops most ACKs, the sender would
 	 * timeout and spuriously retransmit the same segment repeatedly.
 	 * If it seems our ACKs are not reaching the other side,
@@ -4828,6 +4830,14 @@ static void tcp_rcv_spurious_retrans(struct sock *sk, const struct sk_buff *skb)
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


