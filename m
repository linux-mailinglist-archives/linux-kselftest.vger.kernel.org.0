Return-Path: <linux-kselftest+bounces-35011-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3551AD9E3C
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 18:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36FE43B76A9
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 16:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2FF1B043F;
	Sat, 14 Jun 2025 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="GgSuqQT3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011046.outbound.protection.outlook.com [52.101.65.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E49256D;
	Sat, 14 Jun 2025 16:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749917358; cv=fail; b=iSoy8mQ+QBLcBBIACk7UuDrgyBVFU8euexIst931ZTqhyNeG7KZedZuzjm4eOxP+RLIp8YdP/b3Oy3C4Mb2FofmSGahtlpMCvqp8Z582APcJ3mrwNFcfRpIbKrSd4HZKwQSTTrLk5+uFbaAnxmQm7h4k/EFnuJskhpzHLyFJt2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749917358; c=relaxed/simple;
	bh=MsjM1e9DS7MV4cgz17rgEaEN63s0+GaBWaXZG3fJC30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R/kMn9B75JtMDRvxUJCI6FL2gsQDBSzZjUz4HtuOZS7RDtBzja4EfEyPW29huPEtvnovpMtpmLFAyxeiacePgsVsNgCCreebQOr/lAYhO4a5vxpuqNCq7rlxRFd9AqdOgadqYCoIV0Dz/TdD88rBPk1fiGLs4xNW3uTVHLcJu0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=GgSuqQT3; arc=fail smtp.client-ip=52.101.65.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYDFCpdpU4OjU/65vYXY8mc401yKVuiYAlF2qgj5re1eBpED80x1AzVb4ijZ2ojLvbbAdaF4mF9OVCSFuO0aGdvQTqYtMmedFtOUtmH99206yAdUFJDpUW+F3lX92YQYMApYmN6rauoNmqzIfbaOFJ4603f7r1E7fU9OkyChqQYgBsTh56EcVETivL8AhtSSym8stBV+8Mq2jmt2GIbqgVvJSf5BGRbhlBjSS+phD2q2T+GYgFOwIVKQMIH1QWxxnKIptsosk9r4/984E3O8pk9pnX+4qW+nHW8K1muNQo+N1xnudS+bKHoSyWOfbfSevNvNnTDhg78b0TLyaozm8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPPPQUogFfEhggAgtmUcTjg1Hkxnki2uF1SYk8rGWRo=;
 b=RlgWJ6GYYCdIY24bbimEx7LNzTEh9zraK+VFOJQoi/zmRGMzymSjzoRHxl+CKvEvP/TUxY3XrrGqYpyIKLa8R+6gnxj6L9Ti6kuhznfBjEjDQknxFq6CB8syqzLh7q8vNe/tlki762gJeJ3m1UGVCxWg8iatZTbEVM22BmCBjBbYIEkvHsvwWAIPYgSg831hkmnXdFYX/1zOOcmFAbl5BcAk1dUh2bH0baYfFId+37k76CvQomKEb8AKdjH87XsKGqRB2gLMaFiB+llvX9G1v7RGFO8zjd2CVbNQzyj6wwefo+HCuydfPfuGC/CDH/Tr4ETqD3575GL48JFcrUA+3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.241) smtp.rcpttodomain=apple.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPPPQUogFfEhggAgtmUcTjg1Hkxnki2uF1SYk8rGWRo=;
 b=GgSuqQT3IdyN+pNFZp1H8HhCtnCLuLNWG3lk+71Q3Qr/mCYwWEip1O/zkB03APXE4dsbTOhMpKFEMIP9ZPjdAaq+d7064xvj17Jz1aYDr9M/0sZT8YbRYtYUNVeJTmMli5chOvCieekggXqI+YFm65HNiSj9PVwZsH2PMdAzumXye9LsUSNlmfMgtA0WcBVJRa8+pYiUFAt7vUDGXHbBEZ1lxikbSv8sAlNLh1JHQvpnAFPvxxyBdMkUMbgHE6vNo6/wQOG3uv54eO4BH9Mo0PzNWgCVnpd8WXYsWnfLRfz85/wkM/J9BLwXMQ0uXiJyDgKG0SL+lzJ7u216qPVBLQ==
Received: from PAZP264CA0163.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:236::13)
 by AS5PR07MB10058.eurprd07.prod.outlook.com (2603:10a6:20b:683::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.24; Sat, 14 Jun
 2025 16:09:12 +0000
Received: from AM3PEPF0000A78E.eurprd04.prod.outlook.com
 (2603:10a6:102:236:cafe::9c) by PAZP264CA0163.outlook.office365.com
 (2603:10a6:102:236::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Sat,
 14 Jun 2025 16:09:12 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.241) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM3PEPF0000A78E.mail.protection.outlook.com (10.167.16.117) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Sat, 14 Jun 2025 16:09:11 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 7ADB92014A;
	Sat, 14 Jun 2025 19:09:10 +0300 (EEST)
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
Subject: [PATCH v19 net-next 2/5] sched: Dump configuration and statistics of dualpi2 qdisc
Date: Sat, 14 Jun 2025 18:08:47 +0200
Message-Id: <20250614160850.11087-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250614160850.11087-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250614160850.11087-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A78E:EE_|AS5PR07MB10058:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0413c675-191e-458c-a027-08ddab5dcd33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|82310400026|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yS9GY4Ik7pgbHuBKpPSROHQy9e17G5+f4Juf6zBhZhgQTJjHZwWS0HwGPcyA?=
 =?us-ascii?Q?q2sxyKQj6nkxCVrJsubiRsqB1MJGyYbceiGSBcazDC9k1Lsmu5/qFHgKF/1M?=
 =?us-ascii?Q?ykCdrhU7InfOxb4uw66Pdo+auM5cwWOez/e/i4lQ05Lz+8SWTzM7HBcUWXhL?=
 =?us-ascii?Q?uOMIqrWKn3J050PrPSAWRP4YhTD31gb6j5z/W8e8ANoZzYDBd6bAQTCFrVfc?=
 =?us-ascii?Q?POA1GMhrlse1wKbZcwQ3EXipuMezKNbd+tsGedUHf5yvfu7aKcL6YtEcpNZ+?=
 =?us-ascii?Q?sOxypZE5MngsjLC4xLsm4NYUXf8Qg9nAjMwFKu6Nx0NJuVrdMYE3j3Ys6ISK?=
 =?us-ascii?Q?2UBJKV6mCLr0SET6KBSI2udpZ/61cwNQVojT4odUKX3WNo5r2VKTQzRamwt/?=
 =?us-ascii?Q?Z/N/6fUkSvmUxYLqR2HefYtUPBRBExsK0m8nSGD1SgHBbuNYjFwb9LU4efe7?=
 =?us-ascii?Q?YPjPNJil670+T05CoWBIEAKX7h0iV9Mxinu4THwg+L4e1qJPKFpvC7Hcf2mv?=
 =?us-ascii?Q?y4Iqc7QqJCaDRAjRnNair+Bj5FuMj1Y66o8RNG9jFRBASs3BIwyMQFsXivdC?=
 =?us-ascii?Q?WYCPmFK1uDnJjic7BpOgVFrG9HOrqTXtEJPawVyhEhE4etdfZX8h6UXagMYr?=
 =?us-ascii?Q?XAvDGEnQRnvvPZNjnTB031K+D52DxJ5dkA+RtXhGERGl5XznH3rg3GBLWAX4?=
 =?us-ascii?Q?YBAB4HwEOVneGIVhrORVk/wxOs4kZmjm+GtMvelaEExpMScd8tZbiYfh2Yi1?=
 =?us-ascii?Q?95wTx0KSQNH8eVHLTextQI8pxFaj9BY37R6F6oV4ISY3ULHKogwNAXKQO3yf?=
 =?us-ascii?Q?QKYpF1DJSwRHoaVKrlzIjrOPT9aZ365OQRdTe976qO8PTeefWubzlEBgymye?=
 =?us-ascii?Q?hISP/U6hjBB6FAhfXOKLOBPjQA3KrIW1AP3nbC5wWL842keP2Gf0W/pSw+/F?=
 =?us-ascii?Q?i0too93IimuvUtHPt/3Z897qjlqaorZztT5wlBR/Xwrjg+NHKnI2qAQ6g3rG?=
 =?us-ascii?Q?8MhlVPS5fRAI3Fe0/uUbkDQmjPhbBEGw8h/OymUjTQcDT+XgZP8H0E299P9y?=
 =?us-ascii?Q?QcquM5E/9RHiFTTeDgsp6VW4MYv/Wi7EgEWPmqX+cML2xJdYAvmiXApUiBsd?=
 =?us-ascii?Q?6waMqWBk3U7oSWvu9bj9ouDyd6mYp8qPHKPdX8kb08L54cJNiADre+9Ly49a?=
 =?us-ascii?Q?k9IpMu8ABIMmyg5nlFkiBvlo36RMko1D5yH7hYwlZnX94Stxs3M6HeDFBJSb?=
 =?us-ascii?Q?E+JIH/9Wd2bchqGWeAeYUHnwSM9fN4BbBcdrlum5JuWZwCgIlqsJ+6f/sA6a?=
 =?us-ascii?Q?pVbc9fbJqLhs84ZhBt0Lppl5ByDkXmRpvciEySKGWBTf6oQh1ygHvpUbwUpH?=
 =?us-ascii?Q?N2soD5/G1SFAXnpNzTadnlbaua6KZMYfRTaFH+sNViVeYSV/vrW56vSXGMS7?=
 =?us-ascii?Q?upXAhPgh+K4+f1qRlPNDfLgJm/UR0HlP/nYFDGxBniFFejBWsfEe4OCSJ+Zs?=
 =?us-ascii?Q?FMiawwVbftkPFg7cIljPfHySa/Rvp39hh9vM0F77fsEg7oncpDjjrzisWA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(82310400026)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 16:09:11.9070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0413c675-191e-458c-a027-08ddab5dcd33
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A78E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB10058

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
index aa0d04754c9e..978676451e2f 100644
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


