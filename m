Return-Path: <linux-kselftest+bounces-34916-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A73AD918A
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 17:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 950EA1BC42CA
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 15:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5449D1F4625;
	Fri, 13 Jun 2025 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="BItE+c9j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013013.outbound.protection.outlook.com [40.107.159.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0F21F463B;
	Fri, 13 Jun 2025 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749829066; cv=fail; b=J99xSSAHggQ3SMcAxgDrhCH4pBzxGh+iD2NH6gaWP4YZfhrQbDdL2IC7SLbhGWUZK2xDkfFSptTP6lQ2MkzM9lchug/WqZrjg4Y8YVbsq0W0y6FMDUgsCCANX8DkwZijz1VkQi2YwvRuR3ABFzmlIKFiW1izPwJ5CEh2NvNdHWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749829066; c=relaxed/simple;
	bh=ZOjRHXeBDUdcohO7T2ZaWDcS15GyV9QwMJA5npG7JY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J+4vzCfOKyCYhgTugmUKdwn3HPE9XBoqKm7LO79lxFcmgxESNLKlQjNREaCebF69d2xvnGqBaJXDlfVzz9OvLpQJQ6iJj9U0nczOGlqIh3CMRrD+/qzBanmsIt9+/0wvQZsXewIAnlDjiLfO99K5snn+NGPv5FOCC+4+bj3/t/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=BItE+c9j; arc=fail smtp.client-ip=40.107.159.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNyjw3Tke9dWoediTLxDAF35A3H+3ZTXDdjqkHA6+9pw3pU6HQ0xCh181/UnNbD03fiJL2o7EF1g9qYUWBcIg0mxKJtzKfzYDK7Ec6u4BDdzgFM35f5u/mIiNWPRcX6K3HBAR3CPZ6mUf/3+hECEP4a7oja8oqD70j+K6sSlk/YPsczg0dNmannaCcHUmnHFSQSAaXYu8w+UhuM8kRiHWjiEpsbBSTVYMVYzh4+hnLc1a6hKyiopa98HdQ5cxoYvo7Ug4ijWjBjo9lT/VzkCgcs3VTqJ2M8cRsi9pmmrnucCQoPD4gJ80Mm89kZ4YaMZJfzw+kTA/NbyvC+jJmIcAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOqVbF/Rqhwpm8PpVrSTVJv2PWsmnWCdOlkGsODHsr4=;
 b=dIPJRSI2TVtyjo1Xcw+53t6ak0cbZ3pAkhb+BemH5JEH2dB9N3TdtI8BiXrC/bj6ffqYfDqT8i63TShIJ04pUYRwp6dZeSTZwcXRsb/6zTzVElMPB0BgmQfyrZc3AbVUMDdHyFdd9/F08JAIpdz3cu+YiVf2BF3vi1hi8LO+MwkesZTAYENgaWUn1kCGwAlAMPzHns9cvl81qnH7GoT6wY6lhZ0m6cNSj0U0TCZQ0Pjp/g0FethoxRopbGkd1h2uoFZsd9nDEG/CvdbPQTfqJjYfiuv5jwcw1zbaZE6dNFovq8cEw0i5Mq584scJ12WORL/AnDAuA0Hh4bfwPuc0gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.240) smtp.rcpttodomain=apple.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOqVbF/Rqhwpm8PpVrSTVJv2PWsmnWCdOlkGsODHsr4=;
 b=BItE+c9jQfBuS1bgSq3qp82L/KUyLZM1JByaj3MJRBRFzZ1VPA38Rzkd5iMtdHoBuvw1k2UQT8n9m4B87t3/YATf3rfwZEj9B27dGYZ7ddz0FtvSreTmWRZXKvhGo89rEoy3fplfux00r2HEpdacUllarHKmZch/G6XKuKmpqKcSYJIxJQOr5VStGX19zVOO4LPj8bYLBh6vFPeN7hma0HoL1YeZFK3x4n8fJXSseT0YCeUzWj6pifAaPhmF381eavpU41gMzW8YFe0p7e3HbAt2p0S9HhmVC5Xug0llc23JYSzUh9UtCHgYZDUsoUHL52KECb3rYDPc9oOZhyk6FQ==
Received: from CWLP265CA0358.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::34)
 by DB9PR07MB7161.eurprd07.prod.outlook.com (2603:10a6:10:21f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 15:37:36 +0000
Received: from AMS0EPF00000192.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::9c) by CWLP265CA0358.outlook.office365.com
 (2603:10a6:401:5a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Fri,
 13 Jun 2025 15:37:36 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.240) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AMS0EPF00000192.mail.protection.outlook.com (10.167.16.218) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Fri, 13 Jun 2025 15:37:34 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 0ADDF20094;
	Fri, 13 Jun 2025 18:37:33 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: horms@kernel.org,
	donald.hunter@gmail.com,
	xandfury@gmail.com,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
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
Subject: [PATCH v18 net-next 2/5] sched: Dump configuration and statistics of dualpi2 qdisc
Date: Fri, 13 Jun 2025 17:37:22 +0200
Message-Id: <20250613153725.7983-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250613153725.7983-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250613153725.7983-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000192:EE_|DB9PR07MB7161:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a5dbca3e-6453-4a4b-db90-08ddaa9037e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jzIorOJmUUtKMUP9TLT3ufgTgd5yomtKWK5IUF7GJ57iepC5LSOWxcpq6JRU?=
 =?us-ascii?Q?4rEC7Ppl9cokGN2DGDierdzEs8lFhzs4BictWdyRgvAIsUJADB/ZnOxYS9of?=
 =?us-ascii?Q?q/EumwZdgE0AgvxjS276rEuQZdCe3tMdfZmzAjr2vh5vD7+2UkRW6meOTHC4?=
 =?us-ascii?Q?g+UMPdg1OYhII8BHeO2DppaU9PoYsiXmJtkZJNySQR1V7Np28MGMZVtaN8m8?=
 =?us-ascii?Q?MZEiq5nFUvQzlq1C//8J9D/+cUAcM7UTYyjwq3pY7SNz52KG2pavhLolriia?=
 =?us-ascii?Q?prIXBbTItIfLphgHIC+lz8Ql4MUQUFmzX9idnsoaHnMEi1MU9xPknjfqEwUJ?=
 =?us-ascii?Q?qMsZDQUEsS2MZCaFdHh9XsukzkrQb+UuA0CDrGa/UEmW9Q/o0P1XHUGsMCIS?=
 =?us-ascii?Q?kHLMhF2RUM7Ys9QCgrgwzBNeTcuJoIWOFymrgR98J24gKMQRoQgX3OpVsUBH?=
 =?us-ascii?Q?y8zlJRxysnLJJUPiNkMaDAt0Xm8doE7wqNEY4NvU38uidGoEBKuU8bpW2LSI?=
 =?us-ascii?Q?oGBxsSBxKoVFRzGYQRMnDL1OA4oDSsMSRCxF1jYAygE7hfyl9VK4mpqa4z05?=
 =?us-ascii?Q?vuDUVq0jTLO7mSQHSsWE68A2avMhvlMuAiE0dQ8HkKi/5fRKI5/dSGIqoDC7?=
 =?us-ascii?Q?b4AEFu8DrDmI1qREA2l4gXWMpZ1jYt0EQNJ2kkGsEsRH6NvP20pARqkyD94p?=
 =?us-ascii?Q?jPazn68BPzMyV9tsdwG0jQM6EfHMzzFR3c/K/pgDSv4eFA4J2B5ndbr15BuI?=
 =?us-ascii?Q?F+CA7qo8NotWt/GPlYj3LwGL3ADUq+kDJq5ZC0NKLFrDH8EHh6uwaeoT07wl?=
 =?us-ascii?Q?tZROcYSvSR0DrvJJzwYDPajOkaaOIExBr1gdAmTaFTXMiqPD9uq7TpWwzJuJ?=
 =?us-ascii?Q?wAc0Xy42Blr6vjnmBAlZ0arzrGJ84GkLIufqJZDaqTXZ0p+TatzqDZJBAwjB?=
 =?us-ascii?Q?Vnp09h81CLqMfi8HjNZAmgR/Ibrp8P5QcJNEjQt1uY5DE+f0mVN2nCvHlgq9?=
 =?us-ascii?Q?6HOuf7jD94a4fpeCto2c3axIG1wVPsBuLAlgMuEO0CFZiWfj7mMOy8bQRTp2?=
 =?us-ascii?Q?RAepgQYmXTJGauMDjH0jq0+3aaoaH8/j/9lc5zYD9QlOaZyjYo7mznliAl8V?=
 =?us-ascii?Q?wSpx5BXTJQ7hv5cMYbBqW/MbELQgksdK3IGIKB0Zw3ZaP2wfqhwyNFExK0RE?=
 =?us-ascii?Q?3Cb4AIRFLxyfrntnR+N+eokEFT5dBhBLltuooSc4UGa2HAi2Dw+Afv6I0zhx?=
 =?us-ascii?Q?KXPxnz53O/xCuflTCRqVDB0ArFt79c7sDrwb3TCGoPO79o3Lmls7RSl8f+TH?=
 =?us-ascii?Q?7TtmK4lahQCy7aVEIuBH0WvYtAbZXzTHO0qO0XUuAt1+KtIO7x/XZo1jlWOR?=
 =?us-ascii?Q?ufcz6OaccuyEaGTksScaQX8dUoaQEOeLHc5xebAxGgudwVTtDDM4BT+9zjPd?=
 =?us-ascii?Q?agGyZbBlBt16d8woklrjdMcTQ8fJQwojmPNq1sE/D4RW+gpsbfWe+ygStfO7?=
 =?us-ascii?Q?taX7Aw+rjGt1JXMwDIlLNvhPFpldhhaLhWKgwomXEb4lprSy2bYbxu35UA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 15:37:34.3939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5dbca3e-6453-4a4b-db90-08ddaa9037e0
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000192.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7161

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

The configuration and statistics dump of the DualPI2 Qdisc provides
information related to both queues, such as packet numbers and queuing
delays in the L-queue and C-queue, as well as general information such as
probability value, WRR credits, memory usage, packet marking counters, max
queue size, etc.

The following patch includes enqueue/dequeue for DualPI2.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v18:
- Fix typo in the comment

v17:
- Replace 0xffffffff with U32_MAX
- Add READ_ONCE() in dualpi2_dump_stats()

v16:
- Update convert_ns_to_usec() to avoid overflow
---
 include/uapi/linux/pkt_sched.h | 15 ++++++
 net/sched/sch_dualpi2.c        | 89 ++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index 11ec95f3461f..34fc0e2150ac 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -1264,4 +1264,19 @@ enum {
 
 #define TCA_DUALPI2_MAX   (__TCA_DUALPI2_MAX - 1)
 
+struct tc_dualpi2_xstats {
+	__u32 prob;		/* current probability */
+	__u32 delay_c;		/* current delay in C queue */
+	__u32 delay_l;		/* current delay in L queue */
+	__u32 packets_in_c;	/* number of packets enqueued in C queue */
+	__u32 packets_in_l;	/* number of packets enqueued in L queue */
+	__u32 maxq;		/* maximum queue size */
+	__u32 ecn_mark;		/* packets marked with ecn*/
+	__u32 step_marks;	/* ECN marks due to the step AQM */
+	__s32 credit;		/* current c_protection credit */
+	__u32 memory_used;	/* Memory used by both queues */
+	__u32 max_memory_used;	/* Maximum used memory */
+	__u32 memory_limit;	/* Memory limit of both queues */
+};
+
 #endif
diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index 862ca0fbd192..76a3e3dd7c59 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -123,6 +123,14 @@ static u32 dualpi2_scale_alpha_beta(u32 param)
 	return tmp;
 }
 
+static u32 dualpi2_unscale_alpha_beta(u32 param)
+{
+	u64 tmp = ((u64)param * NSEC_PER_SEC << ALPHA_BETA_SCALING);
+
+	do_div(tmp, MAX_PROB);
+	return tmp;
+}
+
 static ktime_t next_pi2_timeout(struct dualpi2_sched_data *q)
 {
 	return ktime_add_ns(ktime_get_ns(), q->pi2_tupdate);
@@ -227,6 +235,15 @@ static u32 convert_us_to_nsec(u32 us)
 		return lower_32_bits(ns);
 }
 
+static u32 convert_ns_to_usec(u64 ns)
+{
+	do_div(ns, NSEC_PER_USEC);
+	if (upper_32_bits(ns))
+		return U32_MAX;
+	else
+		return lower_32_bits(ns);
+}
+
 static enum hrtimer_restart dualpi2_timer(struct hrtimer *timer)
 {
 	struct dualpi2_sched_data *q = timer_container_of(q, timer, pi2_timer);
@@ -462,6 +479,76 @@ static int dualpi2_init(struct Qdisc *sch, struct nlattr *opt,
 	return 0;
 }
 
+static int dualpi2_dump(struct Qdisc *sch, struct sk_buff *skb)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+	struct nlattr *opts;
+
+	opts = nla_nest_start_noflag(skb, TCA_OPTIONS);
+	if (!opts)
+		goto nla_put_failure;
+
+	if (nla_put_u32(skb, TCA_DUALPI2_LIMIT, READ_ONCE(sch->limit)) ||
+	    nla_put_u32(skb, TCA_DUALPI2_MEMORY_LIMIT,
+			READ_ONCE(q->memory_limit)) ||
+	    nla_put_u32(skb, TCA_DUALPI2_TARGET,
+			convert_ns_to_usec(READ_ONCE(q->pi2_target))) ||
+	    nla_put_u32(skb, TCA_DUALPI2_TUPDATE,
+			convert_ns_to_usec(READ_ONCE(q->pi2_tupdate))) ||
+	    nla_put_u32(skb, TCA_DUALPI2_ALPHA,
+			dualpi2_unscale_alpha_beta(READ_ONCE(q->pi2_alpha))) ||
+	    nla_put_u32(skb, TCA_DUALPI2_BETA,
+			dualpi2_unscale_alpha_beta(READ_ONCE(q->pi2_beta))) ||
+	    nla_put_u32(skb, TCA_DUALPI2_STEP_THRESH,
+			READ_ONCE(q->step_in_packets) ?
+			READ_ONCE(q->step_thresh) :
+			convert_ns_to_usec(READ_ONCE(q->step_thresh))) ||
+	    nla_put_u32(skb, TCA_DUALPI2_MIN_QLEN_STEP,
+			READ_ONCE(q->min_qlen_step)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_COUPLING,
+		       READ_ONCE(q->coupling_factor)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_DROP_OVERLOAD,
+		       READ_ONCE(q->drop_overload)) ||
+	    (READ_ONCE(q->step_in_packets) &&
+	     nla_put_flag(skb, TCA_DUALPI2_STEP_PACKETS)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_DROP_EARLY,
+		       READ_ONCE(q->drop_early)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_C_PROTECTION,
+		       READ_ONCE(q->c_protection_wc)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_ECN_MASK, READ_ONCE(q->ecn_mask)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_SPLIT_GSO, READ_ONCE(q->split_gso)))
+		goto nla_put_failure;
+
+	return nla_nest_end(skb, opts);
+
+nla_put_failure:
+	nla_nest_cancel(skb, opts);
+	return -1;
+}
+
+static int dualpi2_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+	struct tc_dualpi2_xstats st = {
+		.prob			= READ_ONCE(q->pi2_prob),
+		.packets_in_c		= READ_ONCE(q->packets_in_c),
+		.packets_in_l		= READ_ONCE(q->packets_in_l),
+		.maxq			= READ_ONCE(q->maxq),
+		.ecn_mark		= READ_ONCE(q->ecn_mark),
+		.credit			= READ_ONCE(q->c_protection_credit),
+		.step_marks		= READ_ONCE(q->step_marks),
+		.memory_used		= READ_ONCE(q->memory_used),
+		.max_memory_used	= READ_ONCE(q->max_memory_used),
+		.memory_limit		= READ_ONCE(q->memory_limit),
+	};
+	u64 qc, ql;
+
+	get_queue_delays(q, &qc, &ql);
+	st.delay_l = convert_ns_to_usec(ql);
+	st.delay_c = convert_ns_to_usec(qc);
+	return gnet_stats_copy_app(d, &st, sizeof(st));
+}
+
 /* Reset both L-queue and C-queue, internal packet counters, PI probability,
  * C-queue protection credit, and timestamps, while preserving current
  * configuration of DUALPI2.
@@ -566,6 +653,8 @@ static struct Qdisc_ops dualpi2_qdisc_ops __read_mostly = {
 	.destroy	= dualpi2_destroy,
 	.reset		= dualpi2_reset,
 	.change		= dualpi2_change,
+	.dump		= dualpi2_dump,
+	.dump_stats	= dualpi2_dump_stats,
 	.owner		= THIS_MODULE,
 };
 
-- 
2.34.1


