Return-Path: <linux-kselftest+bounces-35006-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA19AD9E22
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 17:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85AB8174F69
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 15:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7F02C15BB;
	Sat, 14 Jun 2025 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Cp97hDVh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011048.outbound.protection.outlook.com [52.101.65.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D8C1EDA0F;
	Sat, 14 Jun 2025 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749915758; cv=fail; b=nzpVS+n2caO+cO9FvvviTtaHYONrCI6qyaRKOuVfgPyXOLdZCmank3O23+Y/Dhq+rgIVPvOfC7x8/fpK5YGYiNNTX8Te5FK60N5QJIqcvlQKfUe0TTjDwMz5K8akEV/DsJXcsxnAOiLbjK+Gkj79KNc8HqLCLb4oBeUtKU6HCbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749915758; c=relaxed/simple;
	bh=ZOjRHXeBDUdcohO7T2ZaWDcS15GyV9QwMJA5npG7JY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nan6IZj1vGMDSkf1HreR/YRMrP+nq4oS6i5AOzQrBSEH7PRB77HuoXQwU6TlM3eI4hdBBS5iUFP5oh/ffOdP4icsg3jP9+GzLADQhUAzaZ04ZOnfK/gB+sdheZrq/j3W7V7dTSCv8YEBRMQD42FlQuiH5rEZklEIsd9RQzrev4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Cp97hDVh; arc=fail smtp.client-ip=52.101.65.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=prDmLJFVac3jWxqGNnAJXXvQSz7uOi4yBAY8Ue/f7s6M5T4AbVkZmzC1dnsEprSuTFB8p2RM9nb+5jj2yXim/YgP0SBp9MI39KYuOb6z1o6ADTq88Sdnb5KJyPOdBTPg4kabjXIBemYT3VR7NqJ1+qC4ePcl2AV2+O2L/+9sbDHwxOYfQtlGpez9WK02ye+xYaRhBFrvF9IfspurFQHPAjEXEPbCoMSmW/kSlcPewYJScqPFszwFG3c5nOgaA4jI2U7C22lXBUsy6hPy2vqq+iALnBU6+hi9Vp+TcnDOM3wocYHP0jLzFijdcUI4hNcm1WproiBjGX0mWtByvCxf7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOqVbF/Rqhwpm8PpVrSTVJv2PWsmnWCdOlkGsODHsr4=;
 b=LIkZdyG0S/YynJK/7JW7yKV/EFT8D7R9hBPXTI+L7eJVf8c2u10JkDfkAd/sgsc0aLHC2Bk1TC5WvMCFQrarYPpctKpUKEMETFxJQVdNAc/TXQqSKgpS158tmtc+vLL3dLybXQMDAm0Hr4XAkbYO6CtOF5V7wb4r+ijB+X+8tSudwSVUst/zwfoXAj2a/6ig9wwVm6hAQfx15Kh4TFEKQ7EaIcDqv8CSiHrUrFPdEq55dCMm9IyXQ+WOVzSp7f0iXurudMEf8dEEBbbBTo83otySdxDKheVKh77o1s2CxN9ozTfcyPYsONzZ3mNTnCMbO9bu2IcrgHh6Gu1JrzgThQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOqVbF/Rqhwpm8PpVrSTVJv2PWsmnWCdOlkGsODHsr4=;
 b=Cp97hDVhFcj3jxAGmNlLANmsYd5ks3s3fbLwaRR9XGi4dQZ/jYIPxvQ7mPApVyNApiXAkZSs3o70Ma13IBBp9jwAwSFs00kK3CsMyxYbBLnpS0dHe/H+9/Yamvorx29yKPI2jWsLZHuwElG35BN26NZkA2NLDim2a7gLfbmF7fGZYEMXeH4NQnarL5f90VfiCu6EgIXDPqUMYd6hZ6/q6feUKjvMYFT5nBMjznBKv3sTp1BfQXndYRSHOE8SblmRY+QIaw7qOA0RCLbrha1AC35RLqSFE7fLwKtbEwOD7+Ds6P8mqQIIp2I5mOL+HPLF/qfgVhsyy3RKI+Fb7RclvQ==
Received: from PAZP264CA0110.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1ef::14)
 by AM8PR07MB7458.eurprd07.prod.outlook.com (2603:10a6:20b:245::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Sat, 14 Jun
 2025 15:42:31 +0000
Received: from AMS0EPF000001AE.eurprd05.prod.outlook.com
 (2603:10a6:102:1ef:cafe::e4) by PAZP264CA0110.outlook.office365.com
 (2603:10a6:102:1ef::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Sat,
 14 Jun 2025 15:42:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF000001AE.mail.protection.outlook.com (10.167.16.154) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Sat, 14 Jun 2025 15:42:31 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 099551C002B;
	Sat, 14 Jun 2025 18:42:30 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: alok.a.tiwari@oracle.com,
	pctammela@mojatatu.com,
	horms@kernel.org,
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
Date: Sat, 14 Jun 2025 17:42:20 +0200
Message-Id: <20250614154223.11026-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250614154223.11026-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250614154223.11026-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AE:EE_|AM8PR07MB7458:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cf3d6400-b36b-45a4-744c-08ddab5a134c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dEiHPcAvg8+akF7O4lnJu2kEZVfDacOxbjeqM/CCuo2oCTBS+YeSmuQB9yNf?=
 =?us-ascii?Q?it+QjUGseyJ9kS1Slp6xT8g3+E90Xi4wY464CrhZpQZ1/8DeLBJCjBrz2kOp?=
 =?us-ascii?Q?pXE+95/AY1WNurSpR/2t6gFJ9eNzglJBLi3ko2sE0qZT4fCI8FnWT0JzC6AZ?=
 =?us-ascii?Q?D211ndMaNb9/eqwiuKxwUhSkio8OjBo+I/ZLL3ApGR1pq7r15zOuuqw/1EQp?=
 =?us-ascii?Q?E+jinOBy7WX15dF1ISsS/UoVNZuiXiGeB5+YeFlEa0nlLe9Bu1p2Rp15Ev+O?=
 =?us-ascii?Q?0yjLX7IGw/V5cK2XCvtKalEJTBP3lKifA1w6PQ0Op8S8hGVw3cP/xmO0TPf8?=
 =?us-ascii?Q?Veg1QP4rGb0MAn/TxfQ/SwY9r7PFFu7YeQ7QajBcb/28ss/0GCQjTAluc8Zl?=
 =?us-ascii?Q?ixrIv53el1AnpFyHwR7NL8ZyDz4hWnwjnNk4FZGXnlwd4AHFhodUc44Q7jD5?=
 =?us-ascii?Q?DCsuINqHaMDrKiflNh3haNpNatrhSmsrokLUJkbtvANedWYZH6vhH2oBPChx?=
 =?us-ascii?Q?mgWPCIznobHnF0J/qx5zpIOonaspx7k5FORE9JpsISLhpg2aJX8zu3SCjOH3?=
 =?us-ascii?Q?7FB2620CWhODNpq2Sq/s9W9Fr6rtozVYPOJeskXD8Ud8teIWhsHeNtwaG5ke?=
 =?us-ascii?Q?nVZlDLdTA7A7jYkMNQR34Ft7rp9dhGa4OOFEXQfoo7myGbJZfDQcWz0uGhmL?=
 =?us-ascii?Q?yeaxpRsHDsoGwShTJ//apH1bSRR2dAtNC3DS7pdKxtRXRxwGzk8fTm/qRLnr?=
 =?us-ascii?Q?jxJH0iTNTLPvopiaMkISS87bZPZGiLlv942c3kuJtT+YE5D1xorb1rKJGDjp?=
 =?us-ascii?Q?fTned3Ik70Bo7f9X+ON4e5DNt1NY2bLdWgwzDKuCgdEGjSeOtmyavRRheRWr?=
 =?us-ascii?Q?JaMf6b4EGP2V1A3U1XdfjjBtGnfUdr+1AXNvHbwy17CQdsqphmo9krDXyOc7?=
 =?us-ascii?Q?kB3BP82rdoC01Q7cMtHoOPxr5/xrhDBbYT+AmCcxuxk3uphsBvSt3FNbp5RD?=
 =?us-ascii?Q?rNP3vQIfPqWAS0VarRt3Gsy2eXGfw/BDdgqXyuBsGeiuWgJ7eq1t+X6tbcBb?=
 =?us-ascii?Q?YeecS0fUmjjF24HNg1bUSyfa3j5VJZP4BBppXQua6W9j0Pn/k89phJyHBmWi?=
 =?us-ascii?Q?sS7Fw8q13mB3toTrrmipkWwK3Lj8tAq0eGVbVUdgCapLRVbmSAmeLzf20wLy?=
 =?us-ascii?Q?sbNxCCELCJnpUCH6/0XPooqoJzEh4SGxiXoZwCXn7iaOohtprmo1GuBOUGvX?=
 =?us-ascii?Q?YJcFoaKiRGeD275xv9dswStLn8FFqPwTDlW4HnnsKHvmrxt0Q6RTB9tJh5oz?=
 =?us-ascii?Q?04maBZpp1HvWWd6Xv1WpfRhoeo1GpURyWeGQZV+1PYbxUGInamWAcIbLFXri?=
 =?us-ascii?Q?HlejOmBmRiHGYT83iM0UVmCBHimYtxYvHW/+dJzhfsuDTT8GG3zuIpxyoGD6?=
 =?us-ascii?Q?p4/9eFTxgDqR7Tnh8vd45319v6U+nSPMYRUt+e4yd7knvZksPUvFaYOx+nLN?=
 =?us-ascii?Q?gF7HBjDCERAb4kZaStE5cv9jOml0NaI7nK7Z96U1GsJjR9Rs6oiuhuKDaA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 15:42:31.5232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3d6400-b36b-45a4-744c-08ddab5a134c
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AE.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB7458

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


