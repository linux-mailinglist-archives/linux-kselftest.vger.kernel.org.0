Return-Path: <linux-kselftest+bounces-29756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC653A703B1
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 15:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCF58188E004
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 14:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9005F25A326;
	Tue, 25 Mar 2025 14:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ATuCGVcJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013029.outbound.protection.outlook.com [40.107.159.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA7125A2DE;
	Tue, 25 Mar 2025 14:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742912963; cv=fail; b=V02bFAqo+0mUTgkQvNRZfbf3QGN9Ug1pVVjE9+LKK2qTuulKAnBOVaOR4gmpZirN0a9BvfKwTDpp3Q6E/dbjtIUt34K9/yY2Ub5tHpA2LmNgAKvbtvE5mQHxW229h8hoE4ZcxZO7aJ2oUO5TsX7IwecovINmKfd2t4Yz6N6thr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742912963; c=relaxed/simple;
	bh=0A9TPHTyha+Bhj/TEMEc3oRnfPMX8v2XuztrPzg7hZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FhSVHzUC4yIuPwEhRTNUZCo0/SWz4l51LnGakvgi8n1DWrRwwnkAU4IxBJ4bi9uKZDMm3/k7U4psmozKrI0kbxNLvKH/RQmwwdh/TFXpaHYqskWtVak7J0kQFsY9x8cq+8MunwgSO6+voX+YhNPDYNcqad8wapuQLFVeRDl3L58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ATuCGVcJ; arc=fail smtp.client-ip=40.107.159.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wu76W6m+iyrLbb2v0K1Xmpl4Sjvy4m1xMGruiWcX3UytWibiuK0nO/0XTxofydoWlIo1LsGO8E20l3ZHUnCWSRi0vtQX1V0SzTuezw1+Reb7mrnRWmWloyqr51zpfMwbjeMZj51guJN846MphrYzWBcMnItpXkWwVmKB+8UTuVyzg5nytt12VfuUvwrOYxFM6hP8/RHhTcBH6imLuiUoeQf1931S7Qlcq7gjxz0QNdz5++rrUIY+FzXttj0Q3dLWiwbB9gmQ4iL4shsGfE6AC+T/OMQsNykraaVDhfeZ6w+JCxRgk0TKePmY0GdrfrqrGLuqxsoyD7eb6kn8iq5wNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXB6w1BxSsKtWdGvG9rcC5TzbKqkxABbbe3byTh0RaA=;
 b=Sehf19Vl65uEkrAN2kHyiUtnGybqF/w2oNZssmf89gxzItMEJOjm5sK69ntCpC0kgiHPjrl6qXQI2zAleASXW70+glWU3yS7s5DbyA7Gsq1yqZ5OpxL6w7nUEuehxIAAJYwvGfV+4gk1A7n88AXFgIIeQ+fiRaf49SP6hZosJhbcPnKwH1WMw31Y5iUcwv2DatMEMrKA+9Xo3kOkVUlmRFcTcoeg7pRPvDmZVNKZvExYcPH626m4bFaf9QkVM9NoUoCh6GwvH4ihm2WcR6xdUqXQLUYZu2s7FQ5A0/wi02zjWS7wK7WqWgUBp+uf7JswHR3Y4Xpd1LttU3wSgJC+0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.20) smtp.rcpttodomain=apple.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXB6w1BxSsKtWdGvG9rcC5TzbKqkxABbbe3byTh0RaA=;
 b=ATuCGVcJ3CbXtvVzReo6xmJSiFtmyqMutyFEhGw7/KbIteRvCogCfAvYRMwwmKV/sown5xQEiCbf+3JkSiGBJmGpSoiaz3ltqdyd4VdUOaJyUdKZvlhSbDvbWktlutSYILfAe5DeVLH+PTdoFDaDXegI2jEUJGLm2z/LeJbFD2vz8hnmVUADXWYi+ZBl+j4bgNnZCxuBKxWBoi9DB+PIUoOoPHDJyg5u38nby/M4Fv6KiZ1wauDUR+HSnrxFphNrVoxkq0I5G+cyasccRZ6aX38/9/Khh8wwl6R7RIDhMNL66udm2sxNb5wfdJXzwhPwmJi7SF88l5Gk3lDAftJ7Fg==
Received: from AM0PR02CA0196.eurprd02.prod.outlook.com (2603:10a6:20b:28e::33)
 by DBBPR07MB7675.eurprd07.prod.outlook.com (2603:10a6:10:1e8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 14:29:13 +0000
Received: from AMS1EPF0000004A.eurprd04.prod.outlook.com
 (2603:10a6:20b:28e:cafe::a6) by AM0PR02CA0196.outlook.office365.com
 (2603:10a6:20b:28e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 14:29:13 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.20) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 AMS1EPF0000004A.mail.protection.outlook.com (10.167.16.134) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Tue, 25 Mar 2025 14:29:12 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id BD770202D1;
	Tue, 25 Mar 2025 16:29:10 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org,
	dave.taht@gmail.com,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
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
Subject: [PATCH v10 net-next 4/5] sched: Dump configuration and statistics of dualpi2 qdisc
Date: Tue, 25 Mar 2025 15:28:35 +0100
Message-Id: <20250325142836.47048-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250325142836.47048-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250325142836.47048-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004A:EE_|DBBPR07MB7675:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2de054f8-34a9-4657-a214-08dd6ba96992
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?alhOA6MXObA+9nFK4AYEb8wqEMR+4u2c8ucJkG1PpkPGkbMGNQ2NO+qiSeQz?=
 =?us-ascii?Q?vZ+19yhGf5++rGBJbSxcaQQJCsd71kDoF6vH2ciZpTf2031NFC5/P6Ekuo4H?=
 =?us-ascii?Q?1yJMrD7/HHsksBsvcV/SboIzVSS0NWJ9yal/KDTCvtvPxNKjajqqCovACanX?=
 =?us-ascii?Q?obEjwuHjqpjm2K192NO2buw5K8UcP+UbUK2j/HOkj6MOQ89x0K+tQYmgm3qK?=
 =?us-ascii?Q?AZCc1QzjmeGKx755uwZcq4sCIPVylGwcntToEhd8n4tOPO1YG/jqwR9vo4TY?=
 =?us-ascii?Q?7QnlZFV8wWQ/S5D+nc6+KoYDJemz88amlVb5WZDgDwhBWy2pWhLzr140Wg/K?=
 =?us-ascii?Q?mj3KpXEOGi+jqQc2RUG/t8YfHi03ISPsUZTq80GQlmcNs/7XdZVnEEhPTyKv?=
 =?us-ascii?Q?wTUeHzJ6ecse/3IT3zc5+wiRRmwnLO8O/Hj8KMUGoBaakDkuP3TgRAUqcD9V?=
 =?us-ascii?Q?eh7OkatHfEsW+F+JN3tUn1IEr0zzR3AnFcvOg/2jSTetgGuZf1YHRouuxuzN?=
 =?us-ascii?Q?ZIo1fgwLhu5PRDsRICZJuGpELTL4nxVuLfs/6Jv7aIlxtoeYIFo1Qv25RQOp?=
 =?us-ascii?Q?hZvRnjY6wBUa71KUkCboxRqruVeRVDwezLDbVS1Na9jUBlzTXLQUzWINumf/?=
 =?us-ascii?Q?t5GYH2huAk9bUZ/tvweBi8AdDdIgPf8BLwCaDAQIyYHILbAd2DjEwj/K3Ty5?=
 =?us-ascii?Q?PE93Pk5B0II5vJdtsuiB1mui22M1eCZBNE2opeilEFqrLIjJz+Q1mttHZrJ1?=
 =?us-ascii?Q?Lncr8GErDE9ifmBcMApqPBrvoQw4PUz46XM7pfxgBX4NkNAs07KXuQI3LTqD?=
 =?us-ascii?Q?JQBBqyGjtYI1jTQjmkoMZCFMSO81G6bm8BJMaM9HK4KHK/OoMd4w9qGIev8h?=
 =?us-ascii?Q?AH3WeMUEMlrKMkve2iEsjXKldi4cK/rlB4CJkvpIt3FEHuS4HbRenw3axwz2?=
 =?us-ascii?Q?z8ZRH3MaWI5gSYx6NirPQTbtK+JMaSQcG0K8hp0ACP95QPfRwkkHgBD5vdpK?=
 =?us-ascii?Q?cAvR1CYaZuwip60iyFTDGPz9f7+E7d11k7q08gM/jp/OMrPXRgHlB9+RygIc?=
 =?us-ascii?Q?vBdQO7a3zym8QhUsUCABTv+Ai0vBjHt6N+0N9WZGM4LWRRtQkLHMM4tFT6zS?=
 =?us-ascii?Q?10CPBrxHkEDodqiaUPHhYJ78gHT3R7dGGP4pIp96i9ZpqMxdzgV38Fbw9yea?=
 =?us-ascii?Q?ePTU2h020ooXs/2A4kiSPCP7Zfw30KaT5wVk9tdH9FYtOERTRZxvFeLOON2S?=
 =?us-ascii?Q?u8WHbXVZoztFnybgywhulMWQthAhBurC0wV01M/pJ01K0DnlBMEyccqE49yj?=
 =?us-ascii?Q?W+KeJY7/tZZZhJRdrF+Q+CQwfAKMkFNjZpPB7mQXPcFlE78RBUAXVmnf1sTg?=
 =?us-ascii?Q?ScJYxWhmDWXrPkLZzUkdMmKVTtA6u2ZhfujU4Sg/thdd/EovkC7Jl9iimIp/?=
 =?us-ascii?Q?jF0Ultz5xRb6NUWTYoEaAJ+KT7vpLYPVxX4FyBhiZOzNc7WOwJ/JbAGA9s6F?=
 =?us-ascii?Q?Z7MsSaL70AXp8W3spNjHmr594HU7hu9qFbY3kf1aZfdF0KHGOdEizsA0iw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 14:29:12.0403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de054f8-34a9-4657-a214-08dd6ba96992
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000004A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7675

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

The configuration and statistics dump of the DualPI2 Qdisc provides
information related to both queues, such as packet numbers and queuing
delays in the L-queue and C-queue, as well as general information such as
probability value, WRR credits, memory usage, packet marking counters, max
queue size, etc.

The following patch includes enqueue/dequeue for DualPI2.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/uapi/linux/pkt_sched.h | 15 ++++++
 net/sched/sch_dualpi2.c        | 86 ++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index fd5bec118cdc..62fec34c1005 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -1234,4 +1234,19 @@ enum {
 
 #define TCA_DUALPI2_MAX   (__TCA_DUALPI2_MAX - 1)
 
+struct tc_dualpi2_xstats {
+	__u32 prob;		/* current probability */
+	__u32 delay_c;		/* current delay in C queue */
+	__u32 delay_l;		/* current delay in L queue */
+	__s32 credit;		/* current c_protection credit */
+	__u32 packets_in_c;	/* number of packets enqueued in C queue */
+	__u32 packets_in_l;	/* number of packets enqueued in L queue */
+	__u32 maxq;		/* maximum queue size */
+	__u32 ecn_mark;		/* packets marked with ecn*/
+	__u32 step_marks;	/* ECN marks due to the step AQM */
+	__u32 memory_used;	/* Meory used of both queues */
+	__u32 max_memory_used;	/* Maximum used memory */
+	__u32 memory_limit;	/* Memory limit of both queues */
+};
+
 #endif
diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index 3bf9db6d3bb3..50d40e71deb0 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -126,6 +126,14 @@ static u32 dualpi2_scale_alpha_beta(u32 param)
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
 	return ktime_add_ns(ktime_get_ns(), q->pi2.tupdate);
@@ -422,6 +430,82 @@ static int dualpi2_init(struct Qdisc *sch, struct nlattr *opt,
 	return 0;
 }
 
+static u32 convert_ns_to_usec(u64 ns)
+{
+	do_div(ns, NSEC_PER_USEC);
+	return ns;
+}
+
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
+			convert_ns_to_usec(READ_ONCE(q->pi2.target))) ||
+	    nla_put_u32(skb, TCA_DUALPI2_TUPDATE,
+			convert_ns_to_usec(READ_ONCE(q->pi2.tupdate))) ||
+	    nla_put_u32(skb, TCA_DUALPI2_ALPHA,
+			dualpi2_unscale_alpha_beta(READ_ONCE(q->pi2.alpha))) ||
+	    nla_put_u32(skb, TCA_DUALPI2_BETA,
+			dualpi2_unscale_alpha_beta(READ_ONCE(q->pi2.beta))) ||
+	    nla_put_u32(skb, TCA_DUALPI2_STEP_THRESH,
+			READ_ONCE(q->step.in_packets) ?
+			READ_ONCE(q->step.thresh) :
+			convert_ns_to_usec(READ_ONCE(q->step.thresh))) ||
+	    nla_put_u32(skb, TCA_DUALPI2_MIN_QLEN_STEP,
+			READ_ONCE(q->min_qlen_step)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_COUPLING,
+		       READ_ONCE(q->coupling_factor)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_DROP_OVERLOAD,
+		       READ_ONCE(q->drop_overload)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_STEP_PACKETS,
+		       READ_ONCE(q->step.in_packets)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_DROP_EARLY,
+		       READ_ONCE(q->drop_early)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_C_PROTECTION,
+		       READ_ONCE(q->c_protection.wc)) ||
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
+		.prob			= READ_ONCE(q->pi2.prob),
+		.packets_in_c		= q->packets_in_c,
+		.packets_in_l		= q->packets_in_l,
+		.maxq			= q->maxq,
+		.ecn_mark		= q->ecn_mark,
+		.credit			= q->c_protection.credit,
+		.step_marks		= q->step_marks,
+		.memory_used		= q->memory_used,
+		.max_memory_used	= q->max_memory_used,
+		.memory_limit		= q->memory_limit,
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
@@ -526,6 +610,8 @@ static struct Qdisc_ops dualpi2_qdisc_ops __read_mostly = {
 	.destroy	= dualpi2_destroy,
 	.reset		= dualpi2_reset,
 	.change		= dualpi2_change,
+	.dump		= dualpi2_dump,
+	.dump_stats	= dualpi2_dump_stats,
 	.owner		= THIS_MODULE,
 };
 
-- 
2.34.1


