Return-Path: <linux-kselftest+bounces-34736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED15DAD59CB
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 17:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 564FC3A7FD2
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 15:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B88B19EEBF;
	Wed, 11 Jun 2025 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="WAy2QB8p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013058.outbound.protection.outlook.com [40.107.159.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6414A195808;
	Wed, 11 Jun 2025 15:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654549; cv=fail; b=mCR44CzKQDBJHmiJEBKjFmWEf1CxuclO++jzAqvZRzw0DLVJt9BIXsLg/hhwarkJstw+/lYaRNNFxr0Wj9DZejjO7hJmYmdxdB5eOlq742UQKTiB3XDYuu4HtDJ+fkQuOWi31kJdfleELpkD+akp1RdSl0DK6crvN5ZYNzRuZgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654549; c=relaxed/simple;
	bh=CKI07YyQ67u4Fkgi+cRbjrEyAElaDbkgngxYAQ5Fh+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ilsegdXtQGO7Zq78Hdv/4UqJJ7SLH4FpYrwGdEJlBuHJPblhjCHTSjwa+CTiZWbBgmncO6lGOsgvZ2hfex0DiztxYYA4HQ/7ekmOe4qPmIDKpvsLe5J5KjfhiIDtV93eKH/FtTMe5yTp2B+IxkM91WQsCf2In3NQvgpoeHX4NMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=WAy2QB8p; arc=fail smtp.client-ip=40.107.159.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/hzAkfvVsW2BCFPojuBAcSQA7TvqdRjCyhpRNrxwOPpLuMqlo8g1Zh84AOFY9VPb/ixWj/FH7ofkd/ij4rHgVm8f1pg5/NF/EdkaNx0ISa673bzOFDmLy44ZhTe9/KLOvzj1CYxi48SIpa3fpxe2Bpo1SUBiHfetJNRav8L+DeJ2qewxpfZxDPnrbilpaniIDBmb5QJgnxIdE6ujElOiddCbEq0ANQtCr7F9JqwmHopRQVpJztaN19nUiqHcf06ShTP24SLqVTjVBTdf3Kh5V6gkAB53QPXE00syOFU27GvmcruW0vt1JK+gdeu74r0LdXh6IYVnE3ArOXA+ElZiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vn7rQSGtMl2hg/uvK0rAk40Hlp/GMVhEWJ+kK7f+G/M=;
 b=PKPOFctnC/xnNJv7/dfPi9q6DFSw8iBSmOHc65WuR6weAOi1ajCUV2CrkIsmWc+AfEt3uqc7DWNjBRXVwDnLnsiN3mMm3WM4EQvAwC2phYHytiTb0C8VWcjg6tSzYHx0kXN1e5V1ULx+Wk8Q6xreDkzlAUKWAQNYRJnuabIS3cRRDYsSRpCIYzm/axU5U0YfTzsOZD29nOEpYO/A1XLX0aiglHJZWwVrzw9rTBNVWlZpZs6XPzy8MUoNEA5pRtEivicu5FucK8t1czA3TxSGzFUSxOsNmlbU4bHuyaED98NEtK1lLL4GVsRrtKF8yg3jZ9Jqwmne9zjm3zr1GbZXsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vn7rQSGtMl2hg/uvK0rAk40Hlp/GMVhEWJ+kK7f+G/M=;
 b=WAy2QB8pNvybX8Hi3g3ejj4wqshVC0WmU/5BloEUPAR188p/WfdWwi5BBlLn7SGlh74TAK7UXlYGN4DphkeOZ3BYsLKwp/fv56G8If2qXdcNUEnPY1a2uSuC3SU8x9O3EkJqt2HtGiOTS9f7//Z1M2Th51HoHmJ6ieVAehUGZSBTuKrLIUgo6VjaZh19XeFYsgzMnSstP/TnFnDjpgOMgpirU4nHWB6spUQHk88Cj9VwV7qThdIDjjrkcw6TcvkxjQdrGq0TOsUUN91LIKfuxfjLKyC7mW7mUlaAD8b+O5eTteRq53ZCdc6V0JGgRxJ3P4tHUBYo/CF+pwJf8LT33w==
Received: from AM8P189CA0017.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::22)
 by DBAPR07MB6807.eurprd07.prod.outlook.com (2603:10a6:10:19f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 11 Jun
 2025 15:09:01 +0000
Received: from AMS0EPF000001AB.eurprd05.prod.outlook.com
 (2603:10a6:20b:218:cafe::84) by AM8P189CA0017.outlook.office365.com
 (2603:10a6:20b:218::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Wed,
 11 Jun 2025 15:09:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AMS0EPF000001AB.mail.protection.outlook.com (10.167.16.151) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Wed, 11 Jun 2025 15:09:01 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 691EF20099;
	Wed, 11 Jun 2025 18:08:59 +0300 (EEST)
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
Subject: [PATCH v17 RESEND net-next 2/5] sched: Dump configuration and statistics of dualpi2 qdisc
Date: Wed, 11 Jun 2025 17:08:49 +0200
Message-Id: <20250611150852.23218-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611150852.23218-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250611150852.23218-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AB:EE_|DBAPR07MB6807:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 49ff8592-1258-4b27-3e2a-08dda8f9e5bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z5UbyNeun09Nf6auB2S8+VCUubGkY5rj6oPAXSOF8hhqkBjh/qsLJJ6C7AQd?=
 =?us-ascii?Q?p4uPI+VQq0eAGY9U2HHcl7tfqSwZGWOaAu/b/8Syg5LEYbr4c0+PV4c9tGvr?=
 =?us-ascii?Q?97OSQazIr7O+14C5CKyBokfx4tQlA0koXpPAqX4RGdAFi8ziclz9mD1RbLmk?=
 =?us-ascii?Q?wUHbAMNgR+mIHyfuee0I9zRpleyw/MpOXQ+4QCbS0thcuGE15mq7tdk72cPs?=
 =?us-ascii?Q?WR2jvDHUyd3LZiVfIml8Hv0mpZ/TjqkRZTPgm2t5qFi90ktR55KgWU7lDZ7A?=
 =?us-ascii?Q?/KIgDt/JHBczp4gLFu4q2KPl2L3DDuc8nTIT2tFspaeFwZtmQnvGxgreNK2K?=
 =?us-ascii?Q?z5vc7ptzzYwwBPDwISD4+yyECGqenDqFQNhsnoSx8AAIoEzPDYK0BSrqCT9f?=
 =?us-ascii?Q?cIV7s5TirTu6Gu5hkbUcH+Y0Rl/46AD2fSQGP56M1oYwCabhpBl7+3GXVRnD?=
 =?us-ascii?Q?IjRQRFqtqbqYvtwM61VRWB9CheMH29yF91UvxpADzjZioINo5UviiSAWpoSv?=
 =?us-ascii?Q?30XnoMro8rBAAYuX3LFCzm4G5wdXH7BJqjpewERvT+ipL/hNd7KeJng84SZt?=
 =?us-ascii?Q?gKrhjC8u73RwQsWaSvIdEkKgNebo+RapVYQ3Nfv+nX+AAjnLfleVpUq61qex?=
 =?us-ascii?Q?G0u2aDVcAXcDIUqd/M4/pWIFdHhUaKlW42bVJYJJ9u9LDHibAqsGxZTXWV9c?=
 =?us-ascii?Q?fjP3BQ9fy5yHWeF97J2oJ+n5/ZNEcYt9Anp9sIAVFz8drKalfTChNtLNQy4y?=
 =?us-ascii?Q?YiL5R622B+F1sf2Jmhcc/yquowG363ojBaTrqAPL+j0S1pbHCVtdN71uHHq/?=
 =?us-ascii?Q?Ex6jMvaMhWWjTw0eiPFEEG4IFebSslRdvvwnKjvkflpxzVc5E2R46wrZmFMi?=
 =?us-ascii?Q?AD9rcSDP4SJgCB0PTofAugD+7RwNxziiPhQW6CsuF5m6TsPR4YnS8d8xmi+Y?=
 =?us-ascii?Q?Zij9VfFC1SCWqL2WRjtJE/yP9mFvlaWxNwMbkgcTKQcbwrF6aeaQfsDSrJJR?=
 =?us-ascii?Q?Ylmzq0k0St7K8u6FuutM7U4KtNwfwc4UqUtiuOe4+XuBXAW3R/0kv5MJi8V0?=
 =?us-ascii?Q?rJCDlJwJ5ADawZpA4wah6lXCfEF6AbqW6fiOA4RfrM/0o5Xk8+Fman1pUS6I?=
 =?us-ascii?Q?TL/1xBExKxFLvnHDASpb++byxaBJvHwXddArC9HhVlBHbaX2AbfU3orN60h/?=
 =?us-ascii?Q?5SU1dH8ZC93wAwywny/FlkX3NH02uXGz75Z6vB+sTBl+GRTUcxNiwhley6va?=
 =?us-ascii?Q?AJ2WbQePrhdg82tB17p13O9AIoeB7CqGxMcyN0+OWdCYkxV/Ke2p/jrWAWB/?=
 =?us-ascii?Q?WLG4O7UDgwcIWsY0m1ca0C2S4kF4wOntteaUoHXHplOz9jTjUQMoTjrFk7kN?=
 =?us-ascii?Q?TPW4TwZfgo9WB0U8+NYAsbj2W95o/c3BJivhKisoCyW8jFAP6IEVoqGwGY6C?=
 =?us-ascii?Q?RiqouteWirtmtdOVDB4A8z3A3ANFx2w0DXe1IR8UIlKdq9UNJPlw1ZXOr3sk?=
 =?us-ascii?Q?qrHFZwf3Babzr+pWhnhgh44h7rH4KHZ+uH7X5jHdiBLe12DhoADaSEAZgg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 15:09:01.0171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ff8592-1258-4b27-3e2a-08dda8f9e5bc
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AB.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6807

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


