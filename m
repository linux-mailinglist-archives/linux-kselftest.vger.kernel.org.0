Return-Path: <linux-kselftest+bounces-37646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 812DFB0B1CB
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 22:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D343AC343
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 20:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A826122FDE8;
	Sat, 19 Jul 2025 20:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="fZfTDWnN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010058.outbound.protection.outlook.com [52.101.69.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CCB225419;
	Sat, 19 Jul 2025 20:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752957716; cv=fail; b=d78PhqifQ5o5YjC7W0wXzrEgq3sIT2Bt5nbFvEdbvRapCeMRL/mBDRafwOJzSBK81JCV7IQ+jZiZ4XLxOioFijOMJTSXVBE/QTHwnFBugREBSTde9/AsHLEYChXyDzGZlz8u+xroDL0vbGxV/eHGeaZotn/FEmBwSSlWBfQTLrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752957716; c=relaxed/simple;
	bh=sAnM95F+qXisO6nkLapfT4We4CAQdA1oC2P21p4kwEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yz+n3YibZHJemwDgHPz4I6z2MdhdKQVTCvTjQ8ZR78XsxWPKREixUtRiWMvMZPogVz6WD4kJar/p1VxQfdTMXlOfRG0XUEJc3kBks8zYUP5SM8TgQft0ainP8mfC58yaicJeO5uYaJ2rnFTHqMUrVied1bNCsdRVik2HtzyiTJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=fZfTDWnN; arc=fail smtp.client-ip=52.101.69.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcAhenNKXmjNp3qOENau+wcTEqORvToHYXYFNX/P+OKIEcvhue7b2Xj1GnDrMJg5Jc+PUPxBC+a9tsUwmxL4qVQ8ckHrSGsXJln007ADF51B/HCvPsaN1NV+iBTyteH3DS2xuBkiUEViY0GVv951hAStEMMeEE2VVt3PlHhRHpQFPn3TTCvMyr+yV2VaRs+RRExevBsUqhcbjPRVVG347DXDz0XofcwHq5os/0iw0KMz6K/lNZ2c9xcgdi2RBH1TIKv5sIo5jGh+GooTtaMYna+UQExWVZU+MmqoSd1eu+f3IbTK7mRgtE9d5f6Eh/Mlk77Doe6fT91qoKj9cmjK2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiJ+sZtlW1+EYgnKiqUbjxCdMz/QCPAHXG9joj4tJcA=;
 b=tU6cMMLOM4BbgblKnyGyIVdG7SgopoK+1giMDImi1wcQVfpMW0zXkHAUtDBtCL3aTJJvJeuMTJV1oUouKIzB4vlOmKDHXZ5D1NQSvgk6MTcNYDWezMGBjUrgTyynIqKi4U8dHaLCyuvKtWwXrT+N18v4NnsoGzEnsAxSKHWCaoQw4kt/Uafzxtm48kOgIS57Y2tBTaZnJY+ZIpMQd7XMG6GPuYBOto2wKGpndY2eGVcdsN6idM8HoGrHE8Y7gScFn3BS8OVmZjSP/PNohr1VUeIaiRjNOprDiuTtqXlOjKZ0f1WZ3Lrj+zT2Y9Ud42oNK4ctrmRKd5BH5Oo1mOP7jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiJ+sZtlW1+EYgnKiqUbjxCdMz/QCPAHXG9joj4tJcA=;
 b=fZfTDWnNvH3jl00FP6WEYLaF5R0ptDsEyMUA+SsnUyMBklDMqqyOdT7Hq+VmbHibiujnInx1i6hoLSeU9oqxSh2q/DSTcoFV5zLAHnMGicAt2IPMWHwVnAwWdNz9zeNXPreVBdafQB+RKudK271EXJUONvzVs0xXHoB80KYpOd0dCvRTYqKcs8e/S61y65acCwohnJWu1XG/hp/VBwRPeJ2r9KTnu28kZNrvPJU1NxcnLh8RTS57HqSL6lfZjqBfMstZggGEBJO4IKkiW+JMhIm7mAL2BE8oAS0XiI+8pBy7TIyBPzFzF4LFWId39SC+vGDd34kiz5FAaJHGp+EIKA==
Received: from DB3PR08CA0018.eurprd08.prod.outlook.com (2603:10a6:8::31) by
 OSKPR07MB10448.eurprd07.prod.outlook.com (2603:10a6:e10:9d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.28; Sat, 19 Jul 2025 20:41:50 +0000
Received: from DB5PEPF00014B8F.eurprd02.prod.outlook.com
 (2603:10a6:8:0:cafe::b8) by DB3PR08CA0018.outlook.office365.com
 (2603:10a6:8::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Sat,
 19 Jul 2025 20:41:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB5PEPF00014B8F.mail.protection.outlook.com (10.167.8.203) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Sat, 19 Jul 2025 20:41:49 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 70E3D1C0031;
	Sat, 19 Jul 2025 23:41:48 +0300 (EEST)
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
Subject: [PATCH v25 net-next 2/6] sched: Dump configuration and statistics of dualpi2 qdisc
Date: Sat, 19 Jul 2025 22:41:25 +0200
Message-Id: <20250719204129.15737-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250719204129.15737-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250719204129.15737-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8F:EE_|OSKPR07MB10448:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b1b734ef-a254-45d8-c0d6-08ddc704afca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jk9ZzcSufgKC9RR0H2NmaSd0C96yrIkSP6xUSIGANldGIEMx+VpEgi5nH1qw?=
 =?us-ascii?Q?U6zMY0Br0vRSxlFitRPS9zkS2rNeu8r+S+Bx3Oc1WG73dSTtE5hA830rQfAr?=
 =?us-ascii?Q?Puvw0+ynzBf3tEq07e603X0SlE75eoy73cb6TIoU22ZBYDG8Q8ziTuEOpI2i?=
 =?us-ascii?Q?qCyH+wTmm2U6gJv4r4CtuWf3tEuPqFG+pZw2GXMAt43sH0UMpfkvfiCWFHSu?=
 =?us-ascii?Q?VRc8mN8DG4u0qaqRj3CsBDm3e7/hIqssIV1sTiS8OWivcnmBmENnGWzCFF6t?=
 =?us-ascii?Q?SXsJkOKZVjzWrGez3xrsFWIpDOJGdk3uhKgIw6CS9zGR8j8LpFAJ8DORat+u?=
 =?us-ascii?Q?D01VTwFTor+WKBvahyQr6gqsOCGEg/FcL2j/q77rZ74nYt/i7V0OQfwdfdU/?=
 =?us-ascii?Q?SQkyqWnCN6qMo17aW+pzfQr/fCog+FNq7fCe7jejQ8/FzNYNqP+dQWzJRzBl?=
 =?us-ascii?Q?Kkwgp8r5LDNX39amwkKp5f+bVwojmSMMYEKyISt8GdAk2s8ZHycKDZIokUEb?=
 =?us-ascii?Q?SW8bWoco/AquiHER1xcDP/g7L8jqt9bIURXf5Q37s2wJSjxrNMiaZ9elMGqb?=
 =?us-ascii?Q?XYnQrKHIJF40TClvJsUV0BBU2g9vaWLkmFSBHV0ztN+lTMBO8hB1LTztRCjL?=
 =?us-ascii?Q?UCYdGZxI6c+yLxGa9lg8uue2tIBlp4DHR/AFWIu4MoLxHtw8tC/6nIgbrPi0?=
 =?us-ascii?Q?/W76m6TtTQZ8yNVQpQM5Vj5jOcVW4bPj9tNkpGB0v2hFaqRRw8wzQ1nYiKS/?=
 =?us-ascii?Q?LcT7/OGWEK+nkNhBA2qyBoo9s4GtZ+kh7gLZMr2NoMHUotLQfuIAzhTjR0LA?=
 =?us-ascii?Q?nhAY7MKUo+oCBGxKIKrw+OI/thSUa9wZI0fPm47RYOzqBsAcAdi3XF06qt/a?=
 =?us-ascii?Q?G+ljMKR0TPfbQhdgSEr47SGuIl2D21tQSr/04lKlNZQe08LZWiQ4g0k/DBKy?=
 =?us-ascii?Q?54rqw8ZmAq8+nVOWV1ZjDdMGHyyDtsXw7KHDAXhun7tv4HWcM3kvxFA9Ftbr?=
 =?us-ascii?Q?V9eJbI+a/R6kEUbGeQRlWXOL/zuyWe9XSC2yA4//f+veMVqPq1NIXnNXL6JQ?=
 =?us-ascii?Q?owaDW3jPjdFRC+cXeBfE9VnE2RZgkKfnlX9+coxq5hrnxY4jdGKUC2laEwPo?=
 =?us-ascii?Q?b+T0JhjM6+Y0zzrHcSW6AFgcr4FGeMGWEmdRwKZ8I5cpZO1c9FZu+QZTFGob?=
 =?us-ascii?Q?Ql1Qhx9FQo1nEvnn9TwYlt6NZxiPGOyxSJy5aLd1w0JsXit6XxaM0Cjwg1/3?=
 =?us-ascii?Q?8eHQnjiqagNgzfaShaafui/Nv/+Xv4ybbsyV1+JUAfCyUNG+TTANlqj6TeNx?=
 =?us-ascii?Q?9GoS5Qg5EYFJzKUJGQhbA8VN1xlz3oU0DrLQy1UbaPWABGrxLSvcfHCmyUkz?=
 =?us-ascii?Q?Df8FNz+EhscqCiiPx6BwyIBxokk6IXpeapZVv4ByLBBLB8G+hPQba81AkvW+?=
 =?us-ascii?Q?pq1m5KtqpAZi4Lwt0g0c4B/r6wvFsYns+Ry1WRT4I6BoVJXZTaSfH6EXCmhS?=
 =?us-ascii?Q?HshjeOhMDH71QF4h8nbsUQWQJZOJ7dshFwvd9KZJMCZkQ897Wm7eNCSFKA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2025 20:41:49.9051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b734ef-a254-45d8-c0d6-08ddc704afca
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR07MB10448

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
index 75d685ea8368..c2da76e78bad 100644
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
index 86a7f01f29ce..c1e96e643c5f 100644
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
@@ -306,68 +323,70 @@ static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
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
@@ -379,13 +398,13 @@ static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
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
@@ -462,6 +481,105 @@ static int dualpi2_init(struct Qdisc *sch, struct nlattr *opt,
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
@@ -566,6 +684,8 @@ static struct Qdisc_ops dualpi2_qdisc_ops __read_mostly = {
 	.destroy	= dualpi2_destroy,
 	.reset		= dualpi2_reset,
 	.change		= dualpi2_change,
+	.dump		= dualpi2_dump,
+	.dump_stats	= dualpi2_dump_stats,
 	.owner		= THIS_MODULE,
 };
 
-- 
2.34.1


