Return-Path: <linux-kselftest+bounces-36250-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 605BCAF0931
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 05:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B471C07456
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 03:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD2F1E261F;
	Wed,  2 Jul 2025 03:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="K+wDUOOa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011008.outbound.protection.outlook.com [40.107.130.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD5F1DE4FC;
	Wed,  2 Jul 2025 03:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751426911; cv=fail; b=YfLMqk34m1Na4BXib0gKS2KtcrwuXs8q8c8ULSa/kD/MS6xRx6MLStLSHYDRmzG8Inht1z5lzKM1vKVnmmvXiy7eMi+mTfKGq6j7JQXmtNdKNDf7ulnR7d4hXTvbVu95/Z6jlm9HZ5rat5SoeuSqnQNjkh3fJS4/dvLvXoTcTdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751426911; c=relaxed/simple;
	bh=uOj4H8eK06bu4i7I2Ge7EUKR85oUhBCadim1xP8oXqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aB2frCJfSnIG+8d61b9XUTY/8WUKZ0xEp5BETjiOhU6kScp35H5yb03RMBkEE5AqWId/pp5zZaXmxKG2gvIAtyFnlPvK4RM2PDyHdeyE+7+qe5dRJXooWD4NE/+CPiHTnswzIioBIXI7arHYtYBy1RqrFYEFGMV5gobz8y0mHkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=K+wDUOOa; arc=fail smtp.client-ip=40.107.130.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2wg8HNnckNOU4acwD+3zAvWS78FJV85sMLbqiowdPtEZdxKZ75C+emyObb+5XdX3WwIRI3nPAW9AFAkBiue7boCd0pjrI+HT/r/aieYa2XSQLGE47jNTODmLG6MpsGMhtIEaNmhuvYpqCk0QEX6I+ZybMc9Phv9+hA6HfcaRry1/Y7D4q1vdrqA+3B7+IQgLNYaXo0evWJBRJidjIqKJxPHnnHdLzMULLKFXf7GmKEaXTT+snDd7nCflKxsf7nBiUtik5rwerrdIG/mSF4mJsMimuHmM4bp91rV9nriaWEfrtPfoU59utVaX3BlAsVm0roGMz8qaqpd4iul2lZ0dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRj+ZmVunb4itLt/KTX+yV41GR/E8L+7HpuLvyzE9T4=;
 b=n+Id7rdFBeeDh+tq1/1tZ0ybwPwyBRP9dOgM6XCmXq1acpzBXpe7ZHuZbXdFZ6IVweBC6McRuDkHccGb4H2L3rSRlIlkOj9xnd4QLM2Op5UXqSjJyBREoAyD9cKGr3038YdOmJy4MUBUNZBZHZLWDF9oZ2zamTp8k3y4fu49MZJfGCBhmwIb+I4Pp1zpNRi8Wwh3U+yVoQ0+IYdD77hiiZzNiBYqYdCZEw0AeMpFm083KNIawLQdp5WkW2crtX27vDvJEWE9pplZHRMqc2rdzULaJoQo+9AIsAgYvoD05o1VbOFpgR6hSmUqcUNz8z8zVj5KYEiGzozwzb5vQ/cQdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRj+ZmVunb4itLt/KTX+yV41GR/E8L+7HpuLvyzE9T4=;
 b=K+wDUOOapAK5o8X1wUutQEN7/DPDHGYv3jtzX4jcX4k3/kiZcLZm2YGE1USCP1ZTj+jeugkYAOrRVWvJhoMKxX+MrbTlIfiOIRxxmFRvCubN+69QasYfFsKQq+Bt+qSpyUpEyBcbNbw/XJyzzkt7aA7g1EiPTHzjA52uHWTh0mngMD57j6YLneRmDKkTnNK4TxNRegJB/gWgWMFlM2MVe+0fA+Wl+haECiz5gOuud/oo4ChqZB6FOVWjNQ10d9jcrVy9VNY8VKqTnEiojzGYJ5jiyhO1J+goIs1lSkLv09TB3TZWCPXwZzjNe25Dda4qXHWApkQDvLCJ97BKrPpDig==
Received: from AS9PR06CA0765.eurprd06.prod.outlook.com (2603:10a6:20b:484::19)
 by DB8PR07MB6314.eurprd07.prod.outlook.com (2603:10a6:10:13a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Wed, 2 Jul
 2025 03:28:24 +0000
Received: from AM2PEPF0001C70B.eurprd05.prod.outlook.com
 (2603:10a6:20b:484:cafe::80) by AS9PR06CA0765.outlook.office365.com
 (2603:10a6:20b:484::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Wed,
 2 Jul 2025 03:28:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM2PEPF0001C70B.mail.protection.outlook.com (10.167.16.199) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20
 via Frontend Transport; Wed, 2 Jul 2025 03:28:24 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id C6CF8200BD;
	Wed,  2 Jul 2025 06:28:22 +0300 (EEST)
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
Subject: [PATCH v21 net-next 2/6] sched: Dump configuration and statistics of dualpi2 qdisc
Date: Wed,  2 Jul 2025 05:28:13 +0200
Message-Id: <20250702032817.13274-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250702032817.13274-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250702032817.13274-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70B:EE_|DB8PR07MB6314:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fa960bb9-72fc-4c4f-f88b-08ddb9188079
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h197lb/zDxrQfaK1eIa8Wr44+Rp0yp9ZhYOyu1T4yWypS9vlMwEGtAh3syxO?=
 =?us-ascii?Q?mnHhJXtfi136Hhf4+PpL1ONP4/Mn/lj5u8pVzw8cQh6QxSCUJTZhVFAgxjxZ?=
 =?us-ascii?Q?rFpm7xyAMcgCxQvsg1w5j4Q8lyqog6BaznSOfMQ+vyILDVh5xKoiZlKLgsj6?=
 =?us-ascii?Q?pHMCwyTlB/OFZxZAH5N7LGGJrI+VoB1eJz0X549iZxzICrmZiCpnv1fcy1R+?=
 =?us-ascii?Q?SAAMQLXOkYho4puvOuajaDTMgou8v2g65gxpeWTEq9IS7JEJdCwlyCHsDBv3?=
 =?us-ascii?Q?OMjpf3x5lDJHF95C6c4m36b4n/qcr0H+08xleeWx/84tRrRZqMIJcgoGhpkf?=
 =?us-ascii?Q?XoNrIao5j1vz52C50ZZDI/BJZkPfEU5GtvAo5RYPgJw5hEWDJPhbFsEJa45w?=
 =?us-ascii?Q?P29DQtBUXWoDoh7Eblduu4Q3MHGXWkXehD6EBQWqcpyg6UIEWqxaHzOm9jTz?=
 =?us-ascii?Q?HZC0HiSOG7c2Ved4m/axjn4sAYces7i06MlqqKNy17pj83QBYEhEzb7+G6D5?=
 =?us-ascii?Q?AdZRYlQACrsDoBRyYjG27cnVT0czGVpqIK74cNMzHG1F+oY5jS6fJZb8b0++?=
 =?us-ascii?Q?VnMKr+Vj7yve4WY2e8L9kUi2hORh0fYyqC9dwm2tgJEoeU6GZGFA91+rR5zy?=
 =?us-ascii?Q?0AIv6fajJuZZehPam51AMvqZhW72VtGiywBOpkkv9hxNftJ4DnVolQhu2qfd?=
 =?us-ascii?Q?TzElXEcMkjYuuXIdyzw7evlKAkxGRmbHJWkdwjMMb1IbqbUmsDxkMv7hZr4S?=
 =?us-ascii?Q?8nTM7qDWkEjtbxmb2vpL1iIDV31KEyEuoVxRck1NsI6vAOl2Cc6C5Oj4m8tt?=
 =?us-ascii?Q?fGH9UXKefXK0eKfOAaAQwANWiD759E1cvqMR/Ef+ytDzNq4PGwptK8OyhQ4x?=
 =?us-ascii?Q?wNm2VOWZ/8v07SdNgClvUDcLFQNGGhEWgi8R4QQ5+tLSyaQQOcaFLc8btci3?=
 =?us-ascii?Q?PfQr0kchSbnaDP75u2gGsN7Na6UZLGyx+rLZMwJr/A1DgWN6k+HZJ7LvsI2X?=
 =?us-ascii?Q?BKS2jJPbdWyWRu1YBJyQfMGMnXXGdWPDyCNcQY8D8gWkuNvQGrmrWp5yR4QM?=
 =?us-ascii?Q?LGUatR2bVa6mTKdYBz7MtJ1Vym8G61lqpIh/WIVkcqkkuGBmpL/NyEntjpFP?=
 =?us-ascii?Q?GT2TOO5qoO/vrxAHwAV/1SU2+ASYyPkMzKDfXe9PR6nBTQuKFTAkwjHYO3n6?=
 =?us-ascii?Q?vNUb94v2gifIIkAqddO7PlQ4L6FJTk1kk/hXl/jS1RgPuI3D4/uvpb45sau6?=
 =?us-ascii?Q?e5K2kphVWvqpKorLvdJcNCePgFNqvp/ousBnhowr1GOBwQCbwUCFyZSaM0Qb?=
 =?us-ascii?Q?EcfETVRPQNMcJlv+pIbCr/dBeEt+PO4LrccWrHMv/UwEGWobrjOcMrAifeyu?=
 =?us-ascii?Q?jqhbDryQJBdVeqzK973+uuU1a4R9mXPNLn2sDQgOs5RYca4VTzOo5Bbtg02p?=
 =?us-ascii?Q?NQ4qfGbjkOfZnFCalkQ5DtQckHjpL+T0JIs5/whFoqKJzGRLumYSQTG2jIFG?=
 =?us-ascii?Q?ql+dM2AuaSaq7Uayne1zVFAbaPzA9MywOPo+Y80H/lXHYva6ml/7ALXbLg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 03:28:24.1801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa960bb9-72fc-4c4f-f88b-08ddb9188079
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6314

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

The configuration and statistics dump of the DualPI2 Qdisc provides
information related to both queues, such as packet numbers and queuing
delays in the L-queue and C-queue, as well as general information such as
probability value, WRR credits, memory usage, packet marking counters, max
queue size, etc.

The following patch includes enqueue/dequeue for DualPI2.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v21:
- Modify dualpi2_dump for new STEP_THRESH_PKTS and STEP_THRESH_US

v18:
- Fix typo in the comment

v17:
- Replace 0xffffffff with U32_MAX
- Add READ_ONCE() in dualpi2_dump_stats()

v16:
- Update convert_ns_to_usec() to avoid overflow
---
 include/uapi/linux/pkt_sched.h |  15 ++++
 net/sched/sch_dualpi2.c        | 154 +++++++++++++++++++++++++++++----
 2 files changed, 152 insertions(+), 17 deletions(-)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index 1eeee2f8c8dc..39edd57d3d9d 100644
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
index c6907c862efe..e54a427dcc67 100644
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
+
+	return lower_32_bits(ns);
+}
+
 static enum hrtimer_restart dualpi2_timer(struct hrtimer *timer)
 {
 	struct dualpi2_sched_data *q = timer_container_of(q, timer, pi2_timer);
@@ -300,68 +317,70 @@ static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
 	if (tb[TCA_DUALPI2_LIMIT]) {
 		u32 limit = nla_get_u32(tb[TCA_DUALPI2_LIMIT]);
 
-		sch->limit = limit;
-		q->memory_limit = get_memory_limit(sch, limit);
+		WRITE_ONCE(sch->limit, limit);
+		WRITE_ONCE(q->memory_limit, get_memory_limit(sch, limit));
 	}
 
 	if (tb[TCA_DUALPI2_MEMORY_LIMIT])
-		q->memory_limit = nla_get_u32(tb[TCA_DUALPI2_MEMORY_LIMIT]);
+		WRITE_ONCE(q->memory_limit,
+			   nla_get_u32(tb[TCA_DUALPI2_MEMORY_LIMIT]));
 
 	if (tb[TCA_DUALPI2_TARGET]) {
 		u64 target = nla_get_u32(tb[TCA_DUALPI2_TARGET]);
 
-		q->pi2_target = target * NSEC_PER_USEC;
+		WRITE_ONCE(q->pi2_target, target * NSEC_PER_USEC);
 	}
 
 	if (tb[TCA_DUALPI2_TUPDATE]) {
 		u64 tupdate = nla_get_u32(tb[TCA_DUALPI2_TUPDATE]);
 
-		q->pi2_tupdate = convert_us_to_nsec(tupdate);
+		WRITE_ONCE(q->pi2_tupdate, convert_us_to_nsec(tupdate));
 	}
 
 	if (tb[TCA_DUALPI2_ALPHA]) {
 		u32 alpha = nla_get_u32(tb[TCA_DUALPI2_ALPHA]);
 
-		q->pi2_alpha = dualpi2_scale_alpha_beta(alpha);
+		WRITE_ONCE(q->pi2_alpha, dualpi2_scale_alpha_beta(alpha));
 	}
 
 	if (tb[TCA_DUALPI2_BETA]) {
 		u32 beta = nla_get_u32(tb[TCA_DUALPI2_BETA]);
 
-		q->pi2_beta = dualpi2_scale_alpha_beta(beta);
+		WRITE_ONCE(q->pi2_beta, dualpi2_scale_alpha_beta(beta));
 	}
 
 	if (tb[TCA_DUALPI2_STEP_THRESH_PKTS]) {
 		u32 step_th = nla_get_u32(tb[TCA_DUALPI2_STEP_THRESH_PKTS]);
 
-		q->step_in_packets = true;
-		q->step_thresh = step_th;
+		WRITE_ONCE(q->step_in_packets, true);
+		WRITE_ONCE(q->step_thresh, step_th);
 	} else if (tb[TCA_DUALPI2_STEP_THRESH_US]) {
 		u32 step_th = nla_get_u32(tb[TCA_DUALPI2_STEP_THRESH_US]);
 
-		q->step_in_packets = false;
-		q->step_thresh = convert_us_to_nsec(step_th);
+		WRITE_ONCE(q->step_in_packets, false);
+		WRITE_ONCE(q->step_thresh, convert_us_to_nsec(step_th));
 	}
 
 	if (tb[TCA_DUALPI2_MIN_QLEN_STEP])
-		q->min_qlen_step = nla_get_u32(tb[TCA_DUALPI2_MIN_QLEN_STEP]);
+		WRITE_ONCE(q->min_qlen_step,
+			   nla_get_u32(tb[TCA_DUALPI2_MIN_QLEN_STEP]));
 
 	if (tb[TCA_DUALPI2_COUPLING]) {
 		u8 coupling = nla_get_u8(tb[TCA_DUALPI2_COUPLING]);
 
-		q->coupling_factor = coupling;
+		WRITE_ONCE(q->coupling_factor, coupling);
 	}
 
 	if (tb[TCA_DUALPI2_DROP_OVERLOAD]) {
 		u8 drop_overload = nla_get_u8(tb[TCA_DUALPI2_DROP_OVERLOAD]);
 
-		q->drop_overload = (bool)drop_overload;
+		WRITE_ONCE(q->drop_overload, (bool)drop_overload);
 	}
 
 	if (tb[TCA_DUALPI2_DROP_EARLY]) {
 		u8 drop_early = nla_get_u8(tb[TCA_DUALPI2_DROP_EARLY]);
 
-		q->drop_early = (bool)drop_early;
+		WRITE_ONCE(q->drop_early, (bool)drop_early);
 	}
 
 	if (tb[TCA_DUALPI2_C_PROTECTION]) {
@@ -373,13 +392,13 @@ static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
 	if (tb[TCA_DUALPI2_ECN_MASK]) {
 		u8 ecn_mask = nla_get_u8(tb[TCA_DUALPI2_ECN_MASK]);
 
-		q->ecn_mask = ecn_mask;
+		WRITE_ONCE(q->ecn_mask, ecn_mask);
 	}
 
 	if (tb[TCA_DUALPI2_SPLIT_GSO]) {
 		u8 split_gso = nla_get_u8(tb[TCA_DUALPI2_SPLIT_GSO]);
 
-		q->split_gso = (bool)split_gso;
+		WRITE_ONCE(q->split_gso, (bool)split_gso);
 	}
 
 	old_qlen = qdisc_qlen(sch);
@@ -456,6 +475,105 @@ static int dualpi2_init(struct Qdisc *sch, struct nlattr *opt,
 	return 0;
 }
 
+static int dualpi2_dump(struct Qdisc *sch, struct sk_buff *skb)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+	struct nlattr *opts;
+	bool step_in_pkts;
+	u32 step_th;
+
+	step_in_pkts = READ_ONCE(q->step_in_packets);
+	step_th = READ_ONCE(q->step_thresh);
+
+	opts = nla_nest_start_noflag(skb, TCA_OPTIONS);
+	if (!opts)
+		goto nla_put_failure;
+
+	if (step_in_pkts &&
+	    (nla_put_u32(skb, TCA_DUALPI2_LIMIT, READ_ONCE(sch->limit)) ||
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
+	    nla_put_u32(skb, TCA_DUALPI2_STEP_THRESH_PKTS, step_th) ||
+	    nla_put_u32(skb, TCA_DUALPI2_MIN_QLEN_STEP,
+			READ_ONCE(q->min_qlen_step)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_COUPLING,
+		       READ_ONCE(q->coupling_factor)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_DROP_OVERLOAD,
+		       READ_ONCE(q->drop_overload)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_DROP_EARLY,
+		       READ_ONCE(q->drop_early)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_C_PROTECTION,
+		       READ_ONCE(q->c_protection_wc)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_ECN_MASK, READ_ONCE(q->ecn_mask)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_SPLIT_GSO, READ_ONCE(q->split_gso))))
+		goto nla_put_failure;
+
+	if (!step_in_pkts &&
+	    (nla_put_u32(skb, TCA_DUALPI2_LIMIT, READ_ONCE(sch->limit)) ||
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
+	    nla_put_u32(skb, TCA_DUALPI2_STEP_THRESH_US,
+			convert_ns_to_usec(step_th)) ||
+	    nla_put_u32(skb, TCA_DUALPI2_MIN_QLEN_STEP,
+			READ_ONCE(q->min_qlen_step)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_COUPLING,
+		       READ_ONCE(q->coupling_factor)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_DROP_OVERLOAD,
+		       READ_ONCE(q->drop_overload)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_DROP_EARLY,
+		       READ_ONCE(q->drop_early)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_C_PROTECTION,
+		       READ_ONCE(q->c_protection_wc)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_ECN_MASK, READ_ONCE(q->ecn_mask)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_SPLIT_GSO, READ_ONCE(q->split_gso))))
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
+		.prob			= q->pi2_prob,
+		.packets_in_c		= q->packets_in_c,
+		.packets_in_l		= q->packets_in_l,
+		.maxq			= q->maxq,
+		.ecn_mark		= q->ecn_mark,
+		.credit			= q->c_protection_credit,
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
@@ -560,6 +678,8 @@ static struct Qdisc_ops dualpi2_qdisc_ops __read_mostly = {
 	.destroy	= dualpi2_destroy,
 	.reset		= dualpi2_reset,
 	.change		= dualpi2_change,
+	.dump		= dualpi2_dump,
+	.dump_stats	= dualpi2_dump_stats,
 	.owner		= THIS_MODULE,
 };
 
-- 
2.34.1


