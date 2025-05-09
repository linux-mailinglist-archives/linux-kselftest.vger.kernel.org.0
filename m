Return-Path: <linux-kselftest+bounces-32800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51843AB1F49
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 23:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FD0DA25C6F
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 21:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0A7261388;
	Fri,  9 May 2025 21:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="CjPpb/UE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011048.outbound.protection.outlook.com [40.107.130.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC4F25DB18;
	Fri,  9 May 2025 21:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746827296; cv=fail; b=S2Hr+gSFA8fXQyvGTH+OKcmVb2pRInTYKrqt5MngUbXREYx3GR9c7mO6pbTvAagmGZ49QkM6L4xfy0pClemGNbiBKvxFf4Tcl2rBVQLYPvZ4SgeEMtYGGxxyK4eqoHkHwHTUuf0ZSxD+Cz+qLGrh0xLjDxDDHo+rmnm39fFA7FY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746827296; c=relaxed/simple;
	bh=DO7zm6jEimu8KmObX7nR3afIznN4WzV1k8EUDMiQbBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKKlSig8L6mmsbeFRgOAjlE5sRr7jQo0wYieX11plkQvPhfBQosLBcx6kJdQ/WGM9Ttp7oJx8sQDwjM4Mv4A2OKmzv44ptEVhCAU5BBXYU8fF+tcVVVh7FcXG1b+svjyaKifn/iNPoHXhFJEAGjfb+wchEKS2496P6oJx7zLCnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=CjPpb/UE; arc=fail smtp.client-ip=40.107.130.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMWtf6/UA7b2wzjpv8WN3HiNJINLGxEDNgXF8zLAaOoO8UN7vVA85N7qtX+oiCwek0c1c0yGfXvVLh6S3NC+hsnna5vzrvIEgfOj05LrPNdfGgBXQ1AKBLA2PXTvCqt2JawSac9bdd0sj8qifv9Dp/KVsUyHV5G0EfalU/axoiJpHhBITBwPxJT84M9fbab7rfp7hIJYoPKzk3k+86xh77ihkyU7kAJcxA8174S3q6vzlSJTt895Nwu0afUNIP7+esIY5iic6tLXYfJg8PMez0l4hN3W5u1UmsNzHOpk34V2/rXCYHmFlCF/30b6Jp/QGi3CioMjwPjyr9jocWxwgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6riyknnfpF6sFMWvXNLx6mByDxXPZfuK5J/wIMUwOE=;
 b=NWmUZpM1goGQWl5B7b24SD1tonzxsdvikaZ6OZqFcs+LPlFhTn/d3ChDFRuxlAHWjk7vg3JArRzKogiXWzogvtKh/8S/hNQtuDJX+TbGBnnuRWji6zB76Q2uClPxBfyl5P3ZJguEQQP6kr/rNEjHYKA6I63vK3Muwg4OagCnBWERP68ILHT07ipqiZZxWBYqxrz/bMfduhYag3ZTZVPbecZjAtzGjn27jT9L0HfIM34FUMTZ8AM7NQIt3SER1aVLHP5Kl4bHofAr+3x6Ul5nvXRR6SG7KecjLyR9EQEaQK01bZHvPP1/OhO51E6u/+FkXjzgy0PkkVowd3EF4lnJIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6riyknnfpF6sFMWvXNLx6mByDxXPZfuK5J/wIMUwOE=;
 b=CjPpb/UEwLOiIe8zxYBLDgBsNNfUec1V/tUP4IhdXukfJTT259WYgy3urcG/cILfvhaFozhpxzoKy7n6DV7ym86YKqvzPh5+/8J3H35FbGzvHSTUT4CP/geb8JPpOTvPpj0LUdwOOv89P0AdVjlWDx7q69XcDX+tU68pVE68CB6tdfJNHioEmIYC9g4pDvC+fKuIGgIpm9hsRx1kI11036t+VGPtzboHbqIOlvD+Dh6r2NhIsJjUZRsytM6+h9rHRet4DBiPjMBUwC33Pwr9aLUcPGOKnPvrKeJUyhPBAu7X32gnSZdCFzczNlEU4eRyPQyIHdeMDh42BhFEBZ3wTw==
Received: from DB8P191CA0003.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::13)
 by DU2PR07MB9486.eurprd07.prod.outlook.com (2603:10a6:10:493::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 21:48:09 +0000
Received: from DU6PEPF0000952A.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::d6) by DB8P191CA0003.outlook.office365.com
 (2603:10a6:10:130::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Fri,
 9 May 2025 21:48:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DU6PEPF0000952A.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 21:48:09 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 549LmPMp011840;
	Fri, 9 May 2025 21:48:30 GMT
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
Subject: [PATCH v15 net-next 2/5] sched: Dump configuration and statistics of dualpi2 qdisc
Date: Fri,  9 May 2025 23:47:58 +0200
Message-Id: <20250509214801.37306-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509214801.37306-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250509214801.37306-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000952A:EE_|DU2PR07MB9486:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f47f3a95-e860-4b4a-0acc-08dd8f433077
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?9IaJuS5qlLdZq4jd0hwcvOMu0m5DmIDXBsQu0/P0XClp2HFusg+AgYsEl5lU?=
 =?us-ascii?Q?l3Mq+yCCa6AgGxTHezip4IwovLQQXJJS+eRRkB2Hoj1nRgX43dFpQJ9jX9ns?=
 =?us-ascii?Q?bWHk1U1ahXkmo+tKRSDAPkC6lWhdr6IWNtjG3Te75m4yNzncm3qt6t9ZY/qg?=
 =?us-ascii?Q?0eIQv86LtOwxSWe3I0AqfZrpZcmSlnYImIYKXYNfxBwWCE6AEUGphrR7uHeE?=
 =?us-ascii?Q?Qw5ZKc9Ox0pwvBSq5Zot4Yw5v46zfFyuyJ1E9UDmMO1OO3YBVe1t9hHg/0zi?=
 =?us-ascii?Q?7HeVkSqYSrHAQAJ3YWA3pj7Qxkt1GNPmO+C9byKJ4ZdCtQ+sPmSMMqjw9DzI?=
 =?us-ascii?Q?ijVnjxVLNgqnL2CcrPBJwFlSCIwENicvAg+LNCsgs4vqrHS6sIt6c0TNm06+?=
 =?us-ascii?Q?4iLRWoROCAABC34xjAx4627IUcG3zj0i+utlo/kHys4H/3KcEnDr6GdllVap?=
 =?us-ascii?Q?e26uBSVi24rfz8DkKmOzMlgmsRAUM6zDO8LD5bRL+Ow9B66kZ9WuscJFkO6P?=
 =?us-ascii?Q?onSCBN7Bvryw2W+A+nGNdU+H5APGvpTxZ+wEzLxDiC7rcMDkbSD9nOXGuGsW?=
 =?us-ascii?Q?sqyzL64axD3lo4v6cOPq+yAkJ+h9bmGmU3bwXiWF8Qq9XEk0W/de1bJMKoIu?=
 =?us-ascii?Q?sBGG1N2jZP2gq5QfT7ZULpf7U2GRV2aZblYOYrSF9y9x0fLE/shzpc3Nclay?=
 =?us-ascii?Q?gwgms4zr+RvlvrHhsAtB0MUJUh3D7CAAvLGL3oRgAtyctb38TKGUdtCyBb+5?=
 =?us-ascii?Q?hWi5jc0C64+HcjcnHqoshC7zA0NoZhSxvfZwYkrAX7e3A5AOXibDfi5MF9uM?=
 =?us-ascii?Q?F7wIyv6LGuhEJxmjBSQnHJ3Z1xHL8S8alD4eTvStPDIWCa8jJgXzUskev5tG?=
 =?us-ascii?Q?GNOhu8i+001gsuOud4x/AIvDpyz2fdhEv+NPId8xvrMF3VgOpbBUv88NFv7o?=
 =?us-ascii?Q?mIfHROWXTZraSEBBcbZOnF26AAUn3N4nsKv0yNCjQpf4Lil6qhjKaIkvHcYM?=
 =?us-ascii?Q?lwxDIuJrjntMgE1huW1LNcAzoj1wXkkjnHW3UTaRqcqefgSpsielYP9BKkG2?=
 =?us-ascii?Q?G+6aw+7xTT4A3DEeZq/9c6CXu+v54lFi1JwjjaVvFcTikcLradeA4w+E9YSV?=
 =?us-ascii?Q?FkLur7prwYW438nW8X1ympdNz+ToiKWtS9swODujcZeai39ParW4e4qZvYtI?=
 =?us-ascii?Q?wF23G16Xg3ovwxCKC8pO0Cv44xZ4n0arRjQejvktCaJ04i/nYCMsvZxAfPC3?=
 =?us-ascii?Q?btT1aKXl4bkq2anKa9WK6LtCzeoEqjsIpH0JkQyWcMxb8dbPQHPLD1/+nfJq?=
 =?us-ascii?Q?eweIM+a6hbpBg0BcHVfL2TyLxl15bEK5iq+kXABPlEnIqjKoftxatRlvvX68?=
 =?us-ascii?Q?ATr3Z3beDxqLsw2aMm4o5F/NY7wS4adLvvReBWauQ4xwz4WmAZqx9PrY8YUi?=
 =?us-ascii?Q?bj0IGvsNBbxZI8lUbM1FREd8Mz/8ia0NNrFJJP75aTdKPZiJOo+tc2GqqFJ8?=
 =?us-ascii?Q?cbFproo4Mgm4KnJKELDi0jxR019nbyZV0BAjJjIgZRgTCcGDNS/jediY4g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 21:48:09.3071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f47f3a95-e860-4b4a-0acc-08dd8f433077
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000952A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB9486

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
index f897819b1624..bc248fd49f6f 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -1263,4 +1263,19 @@ enum {
 
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
index 4bc75c0b3436..81e238b5aaa9 100644
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
@@ -440,6 +448,82 @@ static int dualpi2_init(struct Qdisc *sch, struct nlattr *opt,
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
@@ -544,6 +628,8 @@ static struct Qdisc_ops dualpi2_qdisc_ops __read_mostly = {
 	.destroy	= dualpi2_destroy,
 	.reset		= dualpi2_reset,
 	.change		= dualpi2_change,
+	.dump		= dualpi2_dump,
+	.dump_stats	= dualpi2_dump_stats,
 	.owner		= THIS_MODULE,
 };
 
-- 
2.34.1


