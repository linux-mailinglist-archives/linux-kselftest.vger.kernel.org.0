Return-Path: <linux-kselftest+bounces-32331-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAEEAA9006
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 11:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2992916A39F
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 09:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99DE1FBEBD;
	Mon,  5 May 2025 09:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="EsOoiH1a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2048.outbound.protection.outlook.com [40.107.103.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EE414A4F9;
	Mon,  5 May 2025 09:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746438543; cv=fail; b=k/VctMxIrKqKusqVIiAaVRzkvyoDKrTUlyYb56Vafq47mtWB2uk/dgarPFHIeg+TqcutULvpnMjdSne7z0230GyJUvnZeH1Dm2bAgYNqo6sGl0YZpXGL4BfMnjgz1OiO37/+ZwOk3FCUJPNJWR6J/EAzI8J1NyXCa7R3jKHDVsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746438543; c=relaxed/simple;
	bh=FRZ53tph8VVHLx7Ke5P+F3vShlIFXtNXGZZmO8kvVuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CrUDodPSWgHOqPBqX90NH3hQkjH0H4kDRdSIUBgq+NYvWppCs3y1QMi5hLEpHT6LzgiEyMMhMvJnG05IDhDadlQTIbrFcUpyL2Dn209dlmAof6+wDabIcLNsHKECKXxGMZvCdvOcjGQWLQ9HFr2TJFGiAWH3lvwYctax57wyXgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=EsOoiH1a; arc=fail smtp.client-ip=40.107.103.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rg/uTiyc13hxsTR0WZF55Jt3bXetQHm2Ix0ilU9CyJHzrOZk3MGkVB8hnoO9dgONGENZEQbDQrPspLOf8M/wP9NVsUibgZwS+tGopCsBMpNtIq4hiaFreucwzDizgd1hu+Erp3lY84/70+fPMfNHgc2J/lnAmNUkoy9R+kYNRyMa/PS3ke9ySxHpo8ziq7hwvkMomjKYkH2TbJVDUjn09p34zzPQ6Um2BDtTh/F+cyP2k/AQpZN4ZJ5RbpnczYdZVlRsj0wkcfUuGHDV9d2miU/H/yt8xi4HvmsSYt8rWop/nUFv5JjA1u4rGVGK2wBbN0n5jutfO6BjCEvUeMsRFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7EDUfdgfYcN/oRDs85rdOA3ysu5t1xMoPYXGy6QhRw=;
 b=lcsYgPe5oAjejtaQ6f1v+CoB30fJUaQ//P8UY/4HLY4TZyRj14tvQIF33iXjzhE/QVur4NXjZvp0bH4tBFe1adPCCQXjexsA8PzmBIX61WWfQp5E6rY0X+ijYPM3Fy/Q/sMg/2wUDCgTTjwbuh2iBH2srTSrZCNz53Q5usq1NeyLbGoGip3RPxMYg0/9NcrHP2DE0A7F+03AMPAAUstbd0fNcJGmKbjjBZbt8Nl6CTWXMQZPUiyjxQqtROyth2NbbMDwJmBrHE3M7AN/ZgFTUMWKhXeGDKhT8PK8ACCHbr+FdeGWkjY5dXKcLRIdPyrlF5CYUbSWFe3wwtHjWaiIKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7EDUfdgfYcN/oRDs85rdOA3ysu5t1xMoPYXGy6QhRw=;
 b=EsOoiH1aknrCh0X7VSqHQ3RgCXVwW2jd43vK9A3Ks1gW+9CeFdGkPzhioJk5TVadhnhU0AG2DaKdPlqrXXcIkarQnCIgSLmwJTOJmv4gSgxjzrrCLd6D5R/nkqnjBq3zLVPxGNQh3Zrc9Eq1I59DTQEJ+SSUuJlEFDlF8j+MyAaIOiioxoKdxT3W9yeOkhq+mLXAE7PQ9UTwalPqsbZVq2Oy1XE4yZVQV/Q1Noa7MM9I7LehlKz2DT7jlR1lT7uPGKDyXNsh29YN0eT2KJUJVCLTvgqsq1pEwAQjWHJSYLltD66TrAjkupdWsUWLNXrEmRJh+peMp8+k0/mOZm978w==
Received: from PR0P264CA0124.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1a::16)
 by DBAPR07MB6584.eurprd07.prod.outlook.com (2603:10a6:10:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Mon, 5 May
 2025 09:48:56 +0000
Received: from AM3PEPF0000A78F.eurprd04.prod.outlook.com
 (2603:10a6:100:1a:cafe::7e) by PR0P264CA0124.outlook.office365.com
 (2603:10a6:100:1a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.26 via Frontend Transport; Mon,
 5 May 2025 09:48:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM3PEPF0000A78F.mail.protection.outlook.com (10.167.16.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 09:48:56 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 5459mcwD006243;
	Mon, 5 May 2025 09:48:54 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: donald.hunter@gmail.com, xandfury@gmail.com, netdev@vger.kernel.org,
        dave.taht@gmail.com, pabeni@redhat.com, jhs@mojatatu.com,
        kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
        jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
        horms@kernel.org, andrew+netdev@lunn.ch, ast@fiberby.net,
        liuhangbin@gmail.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v14 net-next 2/5] sched: Dump configuration and statistics of dualpi2 qdisc
Date: Mon,  5 May 2025 11:48:34 +0200
Message-Id: <20250505094837.7192-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250505094837.7192-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250505094837.7192-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A78F:EE_|DBAPR07MB6584:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6f308f74-18a0-4359-35a3-08dd8bba0d8e
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?YXyyH9tdnuXv9IIk2uki5asGMRYpPfL90ROsri5oFAibqDIruycLHbRz6heR?=
 =?us-ascii?Q?3HeytoBBtqqaG2TvpyhZGT7avUVwIfYsq1wj/5PMGCgV7iNN0rHDw1ivpPWs?=
 =?us-ascii?Q?LbBG3WODKg6RGnx9KZVbZS9MZ2rjHIXLvcqyOEqO0L7CGMchVWH6/lOQ3sUI?=
 =?us-ascii?Q?JVEFGVR3C6bYfICkOXlgM3UqrzYXtRC1/v+6A82KJKEaXEZHQzcqBw/xf9K6?=
 =?us-ascii?Q?VXAhWwvPD9R7l3KQwD1B71ZwLX3JlDTKt2ycgvhDsI2EnjVIVeK3jKaGHNNz?=
 =?us-ascii?Q?PT4V7Rzuo4N1hrSWyHuY5l17/3KsFRhA4QR1/oK+BM8/nnmHNjPww1STtZX6?=
 =?us-ascii?Q?x6m4Uq9mPqx3rN1M2xjqn5ST3XNWJIiRLqbEO06f/RMkX23Y4iJSYDHviyZ8?=
 =?us-ascii?Q?o6FfIRtpIIoYtOmI7GUDw9Iq0PI21HnYJd4tGweSjsc0y/U0A9bHO0FE9TKf?=
 =?us-ascii?Q?bb1HIGZSeS2D6OpjMjW29u3LrCEQ3I1dHN9g6XKTH2xZnMU/grlnL7xtlZxM?=
 =?us-ascii?Q?Lkf7nvi6aKyyAc5YUN2qe39++++1pP8e5QHwWN0KNOqhrIU3O0l8WZq3lj7b?=
 =?us-ascii?Q?+JtyCMNYMajFvafPBSZtM6bISHFAooPG2pT5/fCUFKV0Wj94xvOBnhhpr1xj?=
 =?us-ascii?Q?/9d1hmzxryBWWoTINMMwIAjbgYU9ATjoZ2NxurxSw2MRmc+1vepauF8Ke/o+?=
 =?us-ascii?Q?2sWNQBJK12btrCaBn3HqyUrPktZOm31IhTzLPPEBZv9Zl7iTIG1ciyl7UjFZ?=
 =?us-ascii?Q?GoS9rJurkvdEScAEDMb6ZQx+71s7ci4WwVdOC/7uCaeCo8/HgxX5H+talDvp?=
 =?us-ascii?Q?3lir2y+bi11DpKhmw1PQ2PFqHCL9Xs2zh4qx1x0DA30cC2cmPIyhExJg57k7?=
 =?us-ascii?Q?NS9S7kGWKJ/NXaai34+cHp433GvTQwAVhWCJXVKgEXCQnCKyH8d2FgDqajKI?=
 =?us-ascii?Q?AcSOLb5UJmzu2TeXIgewgwODWoKVrK5k8F4yYU/EO4OcisWpxxLmCJysI9F5?=
 =?us-ascii?Q?99Yk0+Hy6EaUg1Lff3daZODhRtBYwydXhT0xhOOTutfge3GbMnw9gHpPqobb?=
 =?us-ascii?Q?RB7b8SCZj5FAJJEU7IQ+oxPXhaJ/k6D2wPeMGNIqos3x9Hsk+/gT+3K1Z8kX?=
 =?us-ascii?Q?0p6aaS4V4za+tMGNF+0DEyLCrZNTUbRLqpKeTrAYP8z8+ceYePMRehB21cbK?=
 =?us-ascii?Q?5aFM8UX0A9VcE1DhEUKwULNJ0FyEAl68aaJFk8O7xAmzUha6ovGYqQmdt0PQ?=
 =?us-ascii?Q?sZcfOKRhj+sIbMtmi2cAodQajbXx13dXjk1zZ5leGIIc+dJG8FpESV6USbkb?=
 =?us-ascii?Q?G0qQTYfx/sGpxC/xNt2PZOEq+sf8SZnFZhgrahOfJeHN25XFt1jKnQq4AU1s?=
 =?us-ascii?Q?ydHQMXedcjYBFZM6h+50xlzMEZEQD3qltLX4gsMbKtv3SifbbjbSOVrEZCKI?=
 =?us-ascii?Q?5aehGFqCLxsS1hJpzJEv2Xg3LYN91XpFLd9uY7eyynF+LDa6Ym1JbdhNhCHj?=
 =?us-ascii?Q?nCVfccyEv6XFZjksaHh0SsljYaJShSqm29Hm2D09LBydFeNebzq3bcsbrQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 09:48:56.3160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f308f74-18a0-4359-35a3-08dd8bba0d8e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A78F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6584

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
index dfd903814746..ffa6b057aa88 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -1262,4 +1262,19 @@ enum {
 
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
+	__u32 memory_used;	/* Meory used of both queues */
+	__u32 max_memory_used;	/* Maximum used memory */
+	__u32 memory_limit;	/* Memory limit of both queues */
+};
+
 #endif
diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index 9a2f020d20fa..0bc4603912ff 100644
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
@@ -443,6 +451,82 @@ static int dualpi2_init(struct Qdisc *sch, struct nlattr *opt,
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
@@ -547,6 +631,8 @@ static struct Qdisc_ops dualpi2_qdisc_ops __read_mostly = {
 	.destroy	= dualpi2_destroy,
 	.reset		= dualpi2_reset,
 	.change		= dualpi2_change,
+	.dump		= dualpi2_dump,
+	.dump_stats	= dualpi2_dump_stats,
 	.owner		= THIS_MODULE,
 };
 
-- 
2.34.1


