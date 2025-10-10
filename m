Return-Path: <linux-kselftest+bounces-42961-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEF5BCD23F
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 15:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A3E64278FB
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 13:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB05F2F8BEE;
	Fri, 10 Oct 2025 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="BFACBSJA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010018.outbound.protection.outlook.com [52.101.84.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2282F5324;
	Fri, 10 Oct 2025 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760102281; cv=fail; b=tWxWwMwDzhnFs7+AMJEicZT6wnLpr7mn8UtfzzKX3gvKPy+SvqGIN4ARfWLxmElFvibZRe4+nvuSYXQXoj/l9hnvIds1Wmf5OG+O5/T2M8pvfDfOUV70j3hqMj1yuTzP4bO+UdpEU1CppZRg10MHDJtrhJDStAM7B8zrSXOYeYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760102281; c=relaxed/simple;
	bh=IgfwsYj9udgeByQfBHitRZoZDXCgLD3/iu5UjEBqGk0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X3UZx2uHOTUqQRY5zA2C2rvgalBkgOWDIUbz6W+yqmdknuGUYol3UBwRnLym+Nd7eadELLJlqI52FOKPX6S6hcnnCaDFaD6mCWEUjxIKULsJ1B95sDV4DaYfJKTwNYJ41KjG647Vws7o+hP4EsIaZzZcfky2JbJT0i13SxVF8dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=BFACBSJA; arc=fail smtp.client-ip=52.101.84.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wB9JQtKmq876U2cnUuXEi33FSh0ygdQ91K/q3q6sZOyl/eloz02dmHctNAn6DYxmDaEW8bHmugCDiis5XNd1tDj5Uay1A42a66CIzIbNyHImhn6OhEbVN0vyLwN5CMLSWHsnQTGI4hpSqNAQtvWxQV7yCC7pCnN+buOS8D5we3yueRTZioMZglp+nFwKxfJKvir8f6BDZkYNTqpIgEIAwT70W8MZTrpbKELAchUGNrRt0sQjPFy2TIRdDeOLE4c4hH0464VT93syazLBHRnoRxQseZ+Lz4vgWuOpXklj+cgupCuS15rD6CWfzFkuv12OHnPA0EC2DMgv9A11GCALSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bCBhHKmIXyDyyfj2FBvUAGe846Jjtj4wQuXm+WbOS8=;
 b=Um8HbcimBHh/kdO/cptKZMjACH/aNQn3Tx/RVypk3U6SmOZ+SeP3/f7V41HaWLgaQsvfAZ8Fd9/kAa0OApV4FKkhbvnMlMLpy29SwzICXDXq9d77dS/tTOCsL+zPD7qStR9zoEVJ4CUiq1DKh/R54f/heL1kXTHVWvc2bDV9BWTmdXndK+yu/f4YWF3jcwtnYFLhvJYZhnBGowyNRKuKTrSbTBKCXPysL/LrkFgQdc+q+8hwCNlOH3WK7i0RQiU8h32sj4O9NpFicocUPTPFj89CODOaSdMBIripA8fgWbjzgZ7kSNXvYhCp/82Wv6Lma8etZYgbmaeEWt1wcTLkVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bCBhHKmIXyDyyfj2FBvUAGe846Jjtj4wQuXm+WbOS8=;
 b=BFACBSJAaU/uk7FMnJeLxcPgNo7FD+xVl78gcYdHJBoSvrt/uBRrAQKdHW4F7Hd2gUeQUS23G1Nj42Pp/UnkrG28VfJCqc8jhA+G/p9zawbw7oBOuyaEGm+mZTabm6UIPFT4Hb+CxT1PFSRt524WlmWp1v2pi8CWK118zYX83QAgMVBmVTRGVFV1qv2JhXNBsPnfhvfNzjzusRzQMS/gwjGfE4EK4Ztz2fp449UJtlhcgrsVHT/marjkU1yCUcPcltU5yEADnEvJ4/Imxf6wrNrWv16ZtmxuVcfjjBCblzdipQBuy96FKDjKkI+q10R1LcAbLN2PFbnMJNYWyfGxsQ==
Received: from AM8P189CA0009.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::14)
 by PR3PR07MB6811.eurprd07.prod.outlook.com (2603:10a6:102:7c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 13:17:53 +0000
Received: from AM1PEPF000252DF.eurprd07.prod.outlook.com
 (2603:10a6:20b:218:cafe::76) by AM8P189CA0009.outlook.office365.com
 (2603:10a6:20b:218::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Fri,
 10 Oct 2025 13:17:53 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.101) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM1PEPF000252DF.mail.protection.outlook.com (10.167.16.57) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9
 via Frontend Transport; Fri, 10 Oct 2025 13:17:52 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 393681C0049;
	Fri, 10 Oct 2025 16:17:51 +0300 (EEST)
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
Date: Fri, 10 Oct 2025 15:17:26 +0200
Message-Id: <20251010131727.55196-13-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DF:EE_|PR3PR07MB6811:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4719639c-6bb4-4693-93c5-08de07ff6b1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QwbHRmdyzFBE5fOR1Yuyzvlv1uBl2s2bfEikC1I8HTi0HMaRN8eFKu1RZsiC?=
 =?us-ascii?Q?UTc+azv7Qcf71CV57Z7vPTtO00OjwebUOwotRh+Cwge7i8Utvuzrh78A+N28?=
 =?us-ascii?Q?x1Agn7dZuWo9wR6xuF1NC/BgT8twJ8J8VDKRNzoSBk0jpaCOOAHQKLKxAXDH?=
 =?us-ascii?Q?6S6s3tok5AizC6IUZGm6vaYma4HhUq9RavBtEXLFxYzMaQ6AndZQZCWzdC/p?=
 =?us-ascii?Q?kB8FTHKtOKcGqjy1JQXCq67xLOTAaCtNCuQvrjxLifewRIafnt24gkNKqLV2?=
 =?us-ascii?Q?8lx/3B48AM3QdWY2iQ5vnkJgQKzJj9EHgP/BHSKc9yR0cuW397VQ6lFanIC5?=
 =?us-ascii?Q?4siAwCnQo8DjPI+31swgPBHQXsT7NzZFWUrws7xxx2sdprMp+OBzZa9rZRyh?=
 =?us-ascii?Q?QjhqVc+pEODC/gNxXzdP0AQPQOB2qT+Tmj3hGMFSRfRhTzTyi4VStZ85yMZs?=
 =?us-ascii?Q?WI72GfiCXuA4EtL9hX2t0HDhE7YYuR65OFLztFpzY/NxBtfGGaMxCVxFCC29?=
 =?us-ascii?Q?bAJB+RImIEkmSrfhs8F/r0C/Oy2FUE/8ste3rY+cC+OD+LL9xxbTiWMWSP4Y?=
 =?us-ascii?Q?l2+a00BSKkwcvNZPKWjLcuh87gy/RMuGasAt8KkTqgplHL/vudBbAg6MZPHF?=
 =?us-ascii?Q?EW1t4+TNpgVnZsBPotoDGLEkS7YAxA35y3wfm0I+8jDoMrO69GMSOnQxUnJp?=
 =?us-ascii?Q?lxRIsbFtXCc8LMYphY/M5lapVdWc5NQnGLg7CwbJlogVKwVoaxNqSwhswWnX?=
 =?us-ascii?Q?KMY73/wS5wmr4ilh1F1BgL48lyqQZkEkhSbVCrwBblKtonQ/wlkjUlsEFf9Z?=
 =?us-ascii?Q?Ud9f7pC7/K0P9MCwvoRggmMlaLi9aqN4DCpAUTlA2QTvaNxtt4EhUQBa/hzD?=
 =?us-ascii?Q?xBFxYkrEprsnrXAaqSKNhJObMmWTQS/NldoJ7QjmQrsGJH4gyG1wLXRrChN0?=
 =?us-ascii?Q?XiiBpJOKaDTXtyoVCL8Dh7ABpAhTWwM74oxiUHgzahmkZvCNTCyr6A/7QB+G?=
 =?us-ascii?Q?3WZq+H677aVQrxhwyJ1Q6zKxzPvSg1CfDAu3U5bqea+ZrdM5bD8U7uwuHvUf?=
 =?us-ascii?Q?mB08odjlNfTsMtimYwHbyUSZxUinySt4rsNaDlMdfHrHqT3zZ0r6Wsr3z6u3?=
 =?us-ascii?Q?d0hUtwBiw52fr43RVXbCXcJasVuaYq90mUgPdVumX9t+nAPNXAzRVzYGNWja?=
 =?us-ascii?Q?6YzHSnXl5R94wnOVoqLyrDdOChPB1I264hgiC0HdwEqQn23JWEtwer0kt0OG?=
 =?us-ascii?Q?aJMMhzZSLXBMkAvblzYaq9+06O8f2hwRsogC2Phn6iNNcY3YUDjwdCT3ZMXu?=
 =?us-ascii?Q?64WrhUsiihI8E1q1YDDDjxY7YqA4ndPlnyw3HqTUdjuIZ6ftxZQOl2IbQvgd?=
 =?us-ascii?Q?7HTrJavFeWiyaUVgN5VTEzvEMa3M1gex7h1xp1ywpbZmBcAw+7f3gDyKS2Th?=
 =?us-ascii?Q?WXld2+gdUeOpsYF0x1dw0srl9R1eW9gB3fs45Cqj7a/i07JtsQ6mUvRcrK6z?=
 =?us-ascii?Q?Hhbwy/492D1/35/pza/bG3HLUiQ2c55hLQZml2X74+HDYG3vinsENb7R2gf5?=
 =?us-ascii?Q?lZSLSO6W8U8H+UsCuKcHEfqHb/3SC/XkYsrE96i8?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 13:17:52.7448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4719639c-6bb4-4693-93c5-08de07ff6b1a
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM1PEPF000252DF.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6811

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
 Documentation/networking/ip-sysctl.rst | 2 ++
 include/linux/tcp.h                    | 3 ++-
 include/net/tcp_ecn.h                  | 2 ++
 net/ipv4/sysctl_net_ipv4.c             | 2 +-
 net/ipv4/tcp_input.c                   | 9 +++++++++
 net/ipv4/tcp_output.c                  | 7 ++++++-
 6 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index a06cb99d66dc..773d2271de92 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -483,6 +483,8 @@ tcp_ecn_option - INTEGER
 	  rules outlined in draft-ietf-tcpm-accurate-ecn.
 	2 Send AccECN option on every packet whenever it fits into TCP
 	  option space.
+	3 Regardless AccECN fallback policy is applied, send AccECN
+	  option on every packet whenever it fits into TCP option.
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


