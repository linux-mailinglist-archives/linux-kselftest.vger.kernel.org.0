Return-Path: <linux-kselftest+bounces-33145-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B659DAB92F7
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 02:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6832FA04C95
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 00:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38791E884;
	Fri, 16 May 2025 00:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="oOe25xby"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013059.outbound.protection.outlook.com [52.101.72.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D9A4B1E56;
	Fri, 16 May 2025 00:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747353742; cv=fail; b=ZTF1OTm/2N96mUCzeR11FEgvavD1epZ8Pk0AqB1jZRFgWn6fXaeVo11favXQogj9oZmB3+JkLdDJcBckV4M5HYLEP1qldgrNAQ5PPaJP9bY3uh6lAD5/q1Zoq5hr6tZEF1xL9kz4+tQhaoFedE6TN7Mm5nTGnAtMZdAHdMRCNMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747353742; c=relaxed/simple;
	bh=jo12Th1sx5V3lpZB1ufGmJ9Fog1TSWM9cgjNLPuQSJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SbYhDchn5QCwa2ylv80d7/dh/gItg9V+8vwEfpPsLQPXJDOdopBkPnxtwS1/vtRv4CSLenLzsfG0J2eU3oyW9U7EWRw3kfk4QNs73Hdd9hiB+ON3dZgUnyfgAxjnCkgmfh76U232tZ7uCaXKZYki9T23H32O+DAX17/OeHUdEOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=oOe25xby; arc=fail smtp.client-ip=52.101.72.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLv1LPAm4OnZh3yKxaR8BoTgDh2DfEt9P6ACEfCBHP92U3ERNGfq/3XRJJ0zHIOw3axK8BVD88ABdUYw1SryfI4QQDFhSFVZZqY11BxkoZxEWGj8xVdXY2JuLAQEbgFg00uC5pc/1weRkh8aSc+OOqxBbg7L18guoTJ8LyHxLvsKCWjde2bMSK3P7XSZjnwGyBTGqsLnbmfWOcHjVT8GgnhwElumDFWKcLcm9bnvOQXnZUqI+6q4eUc2EQ97LX2jwEEeHMUf3PDl5cnNb3mZMS+y1yCvoitda2CJrmv2W5KiErTsVL4rt79l31bGDa+MykK9p7tQcpzsqERsSz59KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4Qqn85lp5ZhHAI4TQDZ2QEFL6yh7PdmpL7Z92m32+8=;
 b=T8HSwNN83UKbtg0Ktxz77pqKAe/TsAWhO14mVHaJQELlMRXvBeqK7HyM9466vrjvLOnL46o9L0843xobKuuyztUKHPLMVDJ0peukCMfu+xKx7h0+Hppm0vHJAEpzvmuMfyb+9FJ02JJprrOsPmIikLVCiOBepxB6SodZnkM8JgOfMbvTIpHLafQrEmVzlFrciBFoSQbl7wULS7Wi/VAKhDSN5qQv0aAU16/yizoiAV68wxPj6aUHYVJ9rvXwFSnitzexn/O5brJPKUe2g0K+y9le+dg7oK9x+Xl7wrC+v/c0nnmzKxgI9aZd5ZvIzYXWjvRQR81D1lOVjz9ltVD1Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.240) smtp.rcpttodomain=apple.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4Qqn85lp5ZhHAI4TQDZ2QEFL6yh7PdmpL7Z92m32+8=;
 b=oOe25xbymaJ2mYRVs70C4XN3i5Fd9q32Q5OIKZNzJ5kKDG/x1utj4WDzze1oQfXM75ND9N2qb9t/7tFqb3tzq3CV9ky5AbzdJGwD/OY3yEsGuIOEjerQUzBwrxNyB0cFHlO5dVlM30LpIkOyLWaEd16CFoTKvHzH9nPal49PZZcEzRJUvBQBIYHMT+XqW7TnoYDYzhQ7RRdlzm14k+Vg69SiQh8QSzJ0dPHWHNqbD3w1CNQTtn4Pq6bSbsZqVdEq8wU+UbNDBM9ixL9dJf/8/QuXj0pqTLw/V+Hq/10vP2UQpAlb26sbTgB+ZfEc/6U6tcw/9Y+z+Vd7Azr+z3aDdA==
Received: from CWLP265CA0465.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d4::10)
 by DB9PR07MB8449.eurprd07.prod.outlook.com (2603:10a6:10:36f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 16 May
 2025 00:02:16 +0000
Received: from AMS0EPF000001B4.eurprd05.prod.outlook.com
 (2603:10a6:400:1d4:cafe::e4) by CWLP265CA0465.outlook.office365.com
 (2603:10a6:400:1d4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.20 via Frontend Transport; Fri,
 16 May 2025 00:02:15 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.240) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AMS0EPF000001B4.mail.protection.outlook.com (10.167.16.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Fri, 16 May 2025 00:02:13 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 8F69B200D7;
	Fri, 16 May 2025 03:02:12 +0300 (EEST)
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
Subject: [PATCH v16 net-next 2/5] sched: Dump configuration and statistics of dualpi2 qdisc
Date: Fri, 16 May 2025 02:01:58 +0200
Message-Id: <20250516000201.18008-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250516000201.18008-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250516000201.18008-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B4:EE_|DB9PR07MB8449:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9efcd538-b3cd-48af-796a-08dd940ce9dc
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?NaVm8AnLlB4N9WRGpsbJH915hF4sT9vh/JFKRez+9xx3ohbge5duyCqdK8zO?=
 =?us-ascii?Q?irL1wrJMPw9fBSG8LL9y12aZorGYQDutScc6i4sibytwCqoAyzYk2XY341Lc?=
 =?us-ascii?Q?pLvteQxpI51PnM2Nk0R5Dd9GTGOJUcbu+9p1QBJ6uybWaynKun3OL2C6M4oE?=
 =?us-ascii?Q?a5JuyO23pr8uAZLX93EnncUpqRECk6BP5Cs+Bk93nYWVhXfFZzW9yszn+l5U?=
 =?us-ascii?Q?l0wVcDMBmYCPM4BXtUJxYCOAzdTwzaq8HXzUYTqBhzafbWjqlzo4JNR2u1AA?=
 =?us-ascii?Q?8j+L++QDKmrXPHE6MRmb/PAHtiJTwAYQrlRUH4NHHOKM7GziCHpx0hNG2nky?=
 =?us-ascii?Q?waAhQRpfRSHNtx0z79kTfTAp12OkVjtWebvBLrjwlY00Ns/aGxJUZ4pKLGzq?=
 =?us-ascii?Q?UsKJIboaFNI4QiIGfX4pbhFdYsFG+du7xnREDMzxc4KSh3JSH21bOv3KSWQJ?=
 =?us-ascii?Q?4VnzIQcbiIPzTu5pVzmVfiQsFZjtIlXcyEulmGTx2YaH0vCY6+IneO/yXkvA?=
 =?us-ascii?Q?o/dALdz1eZHzhfyoxqJ8QGkQGVqGRFkIqGlbpXe/3ybqIPpFPPrlHEcITGhg?=
 =?us-ascii?Q?Ko9trSd0atmzcr0d/ZeLkAZdguFbqohGAW8VFq5JwAyJFzl6LiDoHtNCGumo?=
 =?us-ascii?Q?DozUk//umJEsT2uqe1Up7pKTAAQlBcJhOiZCwBtwgFk/y+XVpbrsnNcfCT0p?=
 =?us-ascii?Q?0CjyW2hqFk0TocUuFn1ioq9tihQhN0P1QU5RxTJevN6CaXCraqL57u3anHmK?=
 =?us-ascii?Q?KDInK1v2waOqeCSOGLrVmEKxlJl3roZsvWoWfr7jQ1xFat/izTB3uU77pg14?=
 =?us-ascii?Q?OeEZBeX2K+NeJSRwteA50lyfDD2Hn/xRwzT63ism3cEd8pYtiZEbgHEq1/Vr?=
 =?us-ascii?Q?CKxifYTnUyN+GjFmGwk38zJQtisqu5Pz0IfaiCmdXdZwOXE7WbQM+0N7dvJO?=
 =?us-ascii?Q?lb+T/2MkqmnxZHw4Ti/O5uXpdl2piFH9IhYnFn3ekhSMbv/m9JzOh8YyjwC3?=
 =?us-ascii?Q?fooWeBHJnhtq5Jdm+zZGkDrUXRpEf3tC9vUAa+9eBK1X3DzLgROQ2yxSm0PM?=
 =?us-ascii?Q?UhMKJW1JLVBHlMaS/FtaL3/blTFeVfwB0vh+LQct5wcjduA7ETkbA3Ph/Ru1?=
 =?us-ascii?Q?HJYiJNbx8r/gw76t9Qi2OtKLKAYGA/8fQZqkDNGB3rDA2zmEO3h/M72zWJaa?=
 =?us-ascii?Q?6js+Id5TTPEkm/wir8+ptSo9vcJ+GgUH8TP/eVi7hp3tRXP5BmLzQSDCLRqf?=
 =?us-ascii?Q?uSKMjQGCPqeWsaEKqRo9Cr15W52fPujlnVfDmeZ/426HborQ8YLGaFmh/PMR?=
 =?us-ascii?Q?x0+uLzG4jM3ZlsGxCiOJY+uKfl3DYApbQ79XBmxQ0r9X+PsN8U8aCrCCfhSx?=
 =?us-ascii?Q?6ETTJtIWPpBrfJ7h+l7eUYLB8l7h7iIQb2l8dBGL1vjHiWjBtiIB+yuCAgN2?=
 =?us-ascii?Q?WgapN9LL3dPcm+ltQqmKWbjD7+VYL+zm4d2erfL5WNlcO8LYJHAH8FMRJn62?=
 =?us-ascii?Q?d5JCXi+1yMXNDzjNc/wlG/4cNYfL+nzEowF5U4tN6RdvOVphUb5Tmgg//g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 00:02:13.9334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9efcd538-b3cd-48af-796a-08dd940ce9dc
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8449

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

The configuration and statistics dump of the DualPI2 Qdisc provides
information related to both queues, such as packet numbers and queuing
delays in the L-queue and C-queue, as well as general information such as
probability value, WRR credits, memory usage, packet marking counters, max
queue size, etc.

The following patch includes enqueue/dequeue for DualPI2.

v16:
- Update convert_ns_to_usec() to avoid overflow

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/uapi/linux/pkt_sched.h | 15 ++++++
 net/sched/sch_dualpi2.c        | 89 ++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index ae8af0e8d479..a7243f32ff0f 100644
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
+	__u32 memory_used;	/* Memory used of both queues */
+	__u32 max_memory_used;	/* Maximum used memory */
+	__u32 memory_limit;	/* Memory limit of both queues */
+};
+
 #endif
diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index ffdfb7803e1f..97986c754e47 100644
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
@@ -223,6 +231,15 @@ static u32 convert_us_to_nsec(u32 us)
 		return lower_32_bits(ns);
 }
 
+static u32 convert_ns_to_usec(u64 ns)
+{
+	do_div(ns, NSEC_PER_USEC);
+	if (upper_32_bits(ns))
+		return 0xffffffff;
+	else
+		return lower_32_bits(ns);
+}
+
 static enum hrtimer_restart dualpi2_timer(struct hrtimer *timer)
 {
 	struct dualpi2_sched_data *q = from_timer(q, timer, pi2_timer);
@@ -458,6 +475,76 @@ static int dualpi2_init(struct Qdisc *sch, struct nlattr *opt,
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
@@ -562,6 +649,8 @@ static struct Qdisc_ops dualpi2_qdisc_ops __read_mostly = {
 	.destroy	= dualpi2_destroy,
 	.reset		= dualpi2_reset,
 	.change		= dualpi2_change,
+	.dump		= dualpi2_dump,
+	.dump_stats	= dualpi2_dump_stats,
 	.owner		= THIS_MODULE,
 };
 
-- 
2.34.1


