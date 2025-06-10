Return-Path: <linux-kselftest+bounces-34580-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1FDAD391E
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 15:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9729C232E
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 13:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7307929B8CC;
	Tue, 10 Jun 2025 13:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="WGEPTseT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010043.outbound.protection.outlook.com [52.101.69.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0768229A9CB;
	Tue, 10 Jun 2025 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749561378; cv=fail; b=mNBcgxmB7xzpcmVjpIy5l15R9ZIoNF5Gp0cQ7+s4lJuUFGgi2hQFlsIL1D8UxR+q+nhaek9N7n9SrBZFAcNGezUH0OYvX2PnTk/BnDRHOxcdpPpLRai9fk1D2JknM1Zio7OSZoxpc1kOp/ch+m0Pq4wRgZPFc/b4OSsCzx5EY58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749561378; c=relaxed/simple;
	bh=CKI07YyQ67u4Fkgi+cRbjrEyAElaDbkgngxYAQ5Fh+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lulBsxx7kofFrvD3bRM799e2kD+pVwP0aCIewLtcLf1ktHTYpL9LclUlLt4gdcTQ8z7rOlb2q89IiKjuWTDm3e59eR1LmL+dfm4h2YyLMLDpTm9Jk43NNFxyq/de2mRGxqNk/i3ivsno31SbAgt11bhz8ODJJ8FviOdl2GXyz2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=WGEPTseT; arc=fail smtp.client-ip=52.101.69.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBc/OZjpz6BPySiwoY8uJOkd4IWNLXr2IT/dSDiyUk5ofncyUDXTDPToPSIDwGjFwGQ6f4ka4zSA5CINK7vWERKM5LWwmphyIBKcW1kM2kAapTIhP42NhcvinFfV+IYvNbM8R04ubw6NmA6r9K8fLnTYRwRD3FhhdFiPN0/r3WumJf+a3zuFXV5CV6ceFXZzzlJPUhpT6ogqJ1gyn9re426MVGxNiaNM24VU1hEDoHxYPPdpjYhv4MN+JE//IRQE+06L++aI/mRrdECxOAy4SuUCVs42G7nvd7KKV8zYZgWlR6evp66BvnIg+ZlNkbwwq/s9pkZNuodZjLQgZDxnXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vn7rQSGtMl2hg/uvK0rAk40Hlp/GMVhEWJ+kK7f+G/M=;
 b=JlfQJAtIPwTcmAv35VLdu2eyy+SclBoJKIFeUCnASUfA1i5O3IPiMsxooRQ+ePEUVzdb78Y0ocAdhZZIwspntnQhAH99XpxAmSIJosqH9Zif9/+2A92w91vpUWARraRACHs5ciiZjm/dho1FHOfmkVjPEP/n9DJjLrbT3JP5D6Fy0F23BqNkQMXFvR5s+yDaFyROXNTiKy5lbWZmK8ns16hA1+XYf5x1P2jtWVS2GTkITAzOQjuMgDiRx+zzPvkq873YDLbF1KDmBT3zVU7c6lCV8R/5pueEsFiktGItsvmPDYjot/UNKvVZfyUeA/YQI33YVkjgy5NuDih/FpsbxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vn7rQSGtMl2hg/uvK0rAk40Hlp/GMVhEWJ+kK7f+G/M=;
 b=WGEPTseTlE174UnW3UJoq7OYJEr3riaHA60UzOLAlMHb9dTE3c853Gv22oiId51y/RG0SpkP++r7O30bKt4UeLblmwbmTzY8svXeZuYjMNPrHzCfkXZ/OhPwBKLsD5dy+Pv00XY8aI/oCYUIQiwjX5YyzcJuWrqHxZVch4hrLHjrRTtiI7imWDKkQ/5s9Ca3pvbdRFASPNW8UvrIEdFj+rNC7Oe2pIucv2dDAAXhj3Ylq8fbPWfUiSL2qVtfECE4y+k3M5XCy81VtH693PiHtPBUNATr1k5OtLgQp1tRZAogOvg5t1tgjnqpvSr+KbG6zj87+FsAGBm1qzMgmfCqBg==
Received: from AM0PR02CA0169.eurprd02.prod.outlook.com (2603:10a6:20b:28e::6)
 by PA4PR07MB7246.eurprd07.prod.outlook.com (2603:10a6:102:fc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Tue, 10 Jun
 2025 13:16:13 +0000
Received: from AMS0EPF0000019E.eurprd05.prod.outlook.com
 (2603:10a6:20b:28e:cafe::3d) by AM0PR02CA0169.outlook.office365.com
 (2603:10a6:20b:28e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 10 Jun 2025 13:16:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AMS0EPF0000019E.mail.protection.outlook.com (10.167.16.250) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 13:16:12 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 55ADGITA016767;
	Tue, 10 Jun 2025 13:16:39 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: horms@kernel.org, donald.hunter@gmail.com, xandfury@gmail.com,
        netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
        jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, andrew+netdev@lunn.ch, ast@fiberby.net,
        liuhangbin@gmail.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v17 net-next 2/5] sched: Dump configuration and statistics of dualpi2 qdisc
Date: Tue, 10 Jun 2025 15:15:35 +0200
Message-Id: <20250610131538.18777-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610131538.18777-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250610131538.18777-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019E:EE_|PA4PR07MB7246:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3c45fd00-843b-4267-7167-08dda820f940
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|82310400026|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?KMMZ+sLZixq1TCVRf6iapLHzyZ8/HGGJ/X9um9LAtBn+zj0UIhZAJbRE/eSN?=
 =?us-ascii?Q?da697FTy8GWfUDuPEcJA1LBZHm/QYI8KrdVXe508+VPTvv5Wrz8n2IicfBcN?=
 =?us-ascii?Q?DyXBAWk4xYEvXCUqoutS3fwT0iys3mMPRYwBsqkA4FyDpziwgWZqW3dPWzxy?=
 =?us-ascii?Q?GKhIJ3305pPIE0wcXJpl+qzxPOXrcGyTCrNvfP5n/Pw6CakBqWO8EWRjXksQ?=
 =?us-ascii?Q?avv7gu5QeT4vi/mQ2hZFBSDIUwFXjMejLj26e1TiUjgnlvRftLjKdZwqK//a?=
 =?us-ascii?Q?qEDolzCzbyBY7ma0PlUVGaa1QcdxFFVqOGkMwFACX1QXp6pQK/uCiGjEhtr8?=
 =?us-ascii?Q?lDlnQ4USKzBJZgKT4eG7n93C25eDr4RTKFmMgAZOjz/UaA/1LAVf4ylD8XmU?=
 =?us-ascii?Q?Nym8pPS82oQpgLC3gx6ZVzl3YSvnoVheBtXlIAa7whVaLTJfALj17VHZ/Wzs?=
 =?us-ascii?Q?/XtaaE73wAJ9yXMyvSVidpvtKVOFO/kkWuMP6QY7vn4/XN8z236u3dKK/IrQ?=
 =?us-ascii?Q?BoZ1LJfwF2Uwpz5pVwTf8EfTLkZY+Zf3up4O1UBpQSl6TJz8fjUvVOIeEY//?=
 =?us-ascii?Q?HgVcgJa2iENAliGBJGf6kZneR3ZPzSVohHNnrhMUNsi4MS2hjVI3VZtRJ1tA?=
 =?us-ascii?Q?/zVVsdb01lBN6wRz9oitGFAfiot21LTln5kh0zjGaEO/vCEu80sLWym+oDv2?=
 =?us-ascii?Q?1YNs0cXkBiW6QxsWQ/fcabU75QHQrzBPOdW7jKLGStbr7aD0e90zeGiZDSdL?=
 =?us-ascii?Q?B/NEszmqTvVUv8G0AdoRxAKV2R1lHM1snwhP55fjmyNaE3b0pEcuUrwNiUCN?=
 =?us-ascii?Q?SqhHBlYb9F4ByhH6Wdy6RUAjO0LcQnH8JayIu7YI2PvFuGetDHo6xxE2VPhE?=
 =?us-ascii?Q?WBlyvRMtvSpg/dbKHjhr7bVBYMhkoqVB/TYy7pZoKjG5dh5cluFOCdSUSa/D?=
 =?us-ascii?Q?fz2Hzd7kAyp4WG8oa+bB11l0tvJIcmOJEEmaBzNyL9352JVmF9kiSHUznY98?=
 =?us-ascii?Q?3YcyWzSRpoIMF55bDvCGIJfZR8ajINmIgHhkHVDmqikrt6roCxWPzRpQjh2o?=
 =?us-ascii?Q?MuSnbsw3C8xQKnt9D30hDOqgaEJmWJN/mk1EMJU2x+9yGWiL/VwK+/Rrmkys?=
 =?us-ascii?Q?bwgBo0nSHQ42nscxltjBKnweY0dg8h1P0RNFq+HGG3LgkFg9XCRe0/uDSMrk?=
 =?us-ascii?Q?FvSxIsXTmOg+i1aIToVZE0BOi09pKBKmoEg1PixpSp1Ck4FQhm2RX+L/HcdB?=
 =?us-ascii?Q?+Sp9guFrHLYoCiCtLCfetWZvSfU0FYPRi+ivyTqjqHAlkYNsnocwBZxi84OY?=
 =?us-ascii?Q?GhLQY/HCo6o2dIoEgnbCldLNZtavIwcU8hZ6cTy7HoQ5erbLN0zYCuxsXTJ5?=
 =?us-ascii?Q?eK5gIvg6/3OTS3R/TSiTb5dCmPS6G3uC9xbt4aTyeUlduoc2mxYV6BOXUlDp?=
 =?us-ascii?Q?t/N2CoE1QMDhpBQROWHRNCBE7qAMMzRtExyOVm6lbsvZ9b3VUrgcGpnJpYw2?=
 =?us-ascii?Q?OF9G9rKL6arqWw5KqXEIv5gHhhWOVxGox0izSdDxfctVxKJA+g0bZPzCZw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 13:16:12.9657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c45fd00-843b-4267-7167-08dda820f940
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7246

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

The configuration and statistics dump of the DualPI2 Qdisc provides
information related to both queues, such as packet numbers and queuing
delays in the L-queue and C-queue, as well as general information such as
probability value, WRR credits, memory usage, packet marking counters, max
queue size, etc.

The following patch includes enqueue/dequeue for DualPI2.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
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
index 6c510bc321d2..2d7a83cc03f2 100644
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
 	struct dualpi2_sched_data *q = from_timer(q, timer, pi2_timer);
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


