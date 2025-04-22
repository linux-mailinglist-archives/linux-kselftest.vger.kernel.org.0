Return-Path: <linux-kselftest+bounces-31355-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB28A976A8
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 22:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D281617AFA1
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 20:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8408E2980CF;
	Tue, 22 Apr 2025 20:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="O+/Joa1P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010062.outbound.protection.outlook.com [52.101.69.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765B7298CD2;
	Tue, 22 Apr 2025 20:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745352989; cv=fail; b=lU5xMsgzO6vDAi9fGdMfkOgWrqvmuD4Q0Sm4kXVTeZ0Y1IkbJ43A1kLyQYPDB0ekj7LUWqddmtFl9jAvV3N7qkwswn6rp/pPMK76Kb6OlUSggMCQe9ylVl6DqznT/dwtk/fs23s1TWSOD4LiRfz/usw11rQpKN0SdJe6uIC+pFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745352989; c=relaxed/simple;
	bh=pZw3VEU60z0NW8GpwNJv01sOcwMmnMpbO3F14K57vsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hr1OeyIfceeGqTQ7Bc3kkUh5c+UBOXBCM0iqlt5xj+FCdH/o73/AyKqW6VoQYa+c6l1TtlBOQ8fwSaZBBjAdeIDBOtI6hnwrVtPn+2uIBVE68q80JjTIhyMxHCCj/eWfypFX5djTzm0ixBriOQl7JURZV15gedZj2RhrldDB3sE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=O+/Joa1P; arc=fail smtp.client-ip=52.101.69.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggSLnAYIMJ5NyvLTB0E4qFs9nzDMPUtSJn/QkvhJO6zL3a6J3qPw3DSC5rbPPXqurghhMtgWnm+ylDTw8xaIuwZMVupwGtyiTkFS+9fghdGa3Ktz4IYrtQBYlEFKwOsCSXjYTlzPWA8Mxc6NlwA2QQdLHjqCHZMRjtKnGZNlFhEfQ10KhA4CuyaA65DpzuTjRDAI0iHzxt2l4/jdtg+Z0aqUeQXRKUQW4miiav3umHAc9NCPErynM3kIvlmbH/NZIFlWBotrWSShRrw9usxe2IundTq1B4FpZyqFN50J9cxqWD6MzSG1ALJai5nGtFf/neG4ocG+bn8h6xw/5+2q+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOmbsgXuO167t+Qgob+vanVapI6mnf3Wk5QGNeJwHo0=;
 b=lmzZUpnDhoA5lkYEMh1LgjTBcDVDfGLNbID15bEj/7CGPZnwxMGqAWTagjjMDe1IQ+N2dzQo94izK/bvfFKOswAXQ4DrKHezOkh7j2aAxeyG/Zc1jvDEP+bTYkLL6W8+xIrLQc/BxIyPDN6vLTruwR07Xg73jCpQA7aJx7ZGaEMJFEUimRstYNw6i/1vGoAEzZvbYDC9AwonjUSIqWAHOBKDtUWKHhJujo5AYowjTrDWuPWTp6vj3LuwzNErudrQY02FMbnmDEIaeufA4QgsJykHaZ3Rz+rlyePNbKAQLBnMjBB3S7JQvgkusqF3wb7gJpAfpM+ASq2feQo7gz4sew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOmbsgXuO167t+Qgob+vanVapI6mnf3Wk5QGNeJwHo0=;
 b=O+/Joa1PiUUxF5n1drJSsdqp7TEIuUG0gDBg+OYQDdDjr/uBQ+lRXePTcsW/uEAZtWta67J1Bh5w+uNxZlEwXTauo6DR9GOm3M92Rc/Yf9D7nV264ozumjHhBjeRt/7DwcOq7HKMp95h4Yq7ObgL/qWzCAOmbMwPYaxaOwQlL50oBy87WWjapX1eBOncW6nbV/kbJvtNAA0fvfkjWnGtUa2PJnDKCI46hlo92qbwUJVqZKClbj6t6KXzF0gaLb3UVzcv7lTWd/PzNbKloZb1zxeWyFtFhXBYYUt9kdsSumpMRxPWa9MrZDumxutt99wt3IXi/pW+rIeeCvtwEpg5yA==
Received: from DUZP191CA0068.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::29)
 by AM9PR07MB7890.eurprd07.prod.outlook.com (2603:10a6:20b:303::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 20:16:21 +0000
Received: from DU6PEPF00009529.eurprd02.prod.outlook.com
 (2603:10a6:10:4fa:cafe::42) by DUZP191CA0068.outlook.office365.com
 (2603:10a6:10:4fa::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Tue,
 22 Apr 2025 20:16:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.20)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 DU6PEPF00009529.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12 via
 Frontend Transport; Tue, 22 Apr 2025 20:16:21 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id A7AFF20094;
	Tue, 22 Apr 2025 23:16:19 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: xandfury@gmail.com,
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
Subject: [PATCH v12 net-next 4/5] sched: Dump configuration and statistics of dualpi2 qdisc
Date: Tue, 22 Apr 2025 22:16:01 +0200
Message-Id: <20250422201602.56368-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422201602.56368-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250422201602.56368-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009529:EE_|AM9PR07MB7890:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 49ec4b32-bd38-49c4-33cf-08dd81da8c32
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?88w9FJ7uUkROgRZuPeCtBgYpq60c81lNKrAqqmc+nj0TSPJRsI8KEjotqR9Y?=
 =?us-ascii?Q?Snu7ADe2vgKuynBIo1nRbR+LrW+YNGeu3lOphR+/kYRr4JyhGnHKuMgbM1VG?=
 =?us-ascii?Q?JSV6H7VZFxg9OWTOEP2Nda2Bu/sdyRO1Ciud1v/SgLKrVQNS9VmYmo8AZ1Ua?=
 =?us-ascii?Q?05MKeUBR5KGHcVB0IyETdhPyQy0EKS0u2AaZDyq+9amq/YTD/YE5SAJJlcOG?=
 =?us-ascii?Q?5ex6g8ZiHML9xwospEqdIJSrMNnX4Y4kcI9uQDei7pnx/iOEB01rN52GQzAl?=
 =?us-ascii?Q?qhmigbS5LGI2buEr+r59tRZ3jbxBVAiBv1LIqV9EMsZbLwY1kx5yL5uNLLTl?=
 =?us-ascii?Q?cJA1ldCxSEzLs7MhvaAx300sodbgqd3O1sa12HxbvCSJMXA6LvzExvPnw3Il?=
 =?us-ascii?Q?3/aUuMjNKBBFC4KjyOf/hH8A/2yRPoSeb7I7mkgWnbHpo13eioH+N9DW52xu?=
 =?us-ascii?Q?SDof7I/q8VHLiO9POWKfLhYALrotJmDySEWt9SCI2hHCgiA2YMEJkdwN8hGw?=
 =?us-ascii?Q?SfZPnTd3GAHfnJZE/cp8/8wfBMnGWsAnLYtkxUB/NbX+EQrNf1077hcmHs8s?=
 =?us-ascii?Q?BToh6bbqJHoKuE0zcEmJSLIEbP2IdqzA3LKTM85HkApipFL30ShbkfMpPISB?=
 =?us-ascii?Q?pRsVhGH0C6Dt8ytCrhGmxBMkl3KpejGHuivwQP5qF1PpguDdeI8J2T9eXrdA?=
 =?us-ascii?Q?w9qbtFFvdJzBAOyZTIMDGK/Uwf20PA45CJRbCa96VaTXZPYSVmC0XGt2GgPh?=
 =?us-ascii?Q?Pj+txwgCutIMRuABc+0ptgchYicxm09ySDOc6jOuEQeKFJnAzBrU9KeCkMFW?=
 =?us-ascii?Q?aigmiPMk3sWkaAW1x4i/NQT+6qlkljkm54WEda7Wl+L/G8GcYfN/fJzu/n4s?=
 =?us-ascii?Q?uaXFDQm8+W0XkoWg2487gaNxHPtyww+fmDGY0wnLwgYi4oFhBtfIF4PVk9/3?=
 =?us-ascii?Q?aKpRe6sWsXVQgCyrIOl+NiRiHRYVa7oTKvkmNJcjhD3qr+bEmyNw4AD03POk?=
 =?us-ascii?Q?VFs6sNFbez4ooNap73dQ5V39//6Ywyar8ORKwV2ugU+fo5hwpAz6iaP29qME?=
 =?us-ascii?Q?gP1GwJss+9ASkADLA8yalhkQOEsbCrHsy7597our7RtO6s6cn03lNxr25VAR?=
 =?us-ascii?Q?ReoPF41rlP0sIacVSzaqzvIZKwnLKwPYZ7Rj0+RfkZAhrXJy+xMphglOHpWW?=
 =?us-ascii?Q?2CZ4cVCWQdXuHv84v31fNkOwPJYnS9XquMsVf4q+jLnLgEvBObGOen+JM1iN?=
 =?us-ascii?Q?nlz4rIVG3wrozdALvzsOIWFW5hD93fN9JVxkWILEkmgzQ6VM0cHhLNWRbltx?=
 =?us-ascii?Q?LrWsox3mOCdZhC0Cp4oL9261SPQ++pa0DiXNb+HSGxcj2bsBLgGAXvWsoCll?=
 =?us-ascii?Q?LHrhgk3wpVoZ+/ENaO6oSd42IIIP6XAZ7L63kDi3YTWZXuunkpkbt/ncMhF+?=
 =?us-ascii?Q?U68or06M8On66vPv3l1qPAZqihyojCC/BiuXXvJWMyWj/JEMi9LpDG+Hh/GH?=
 =?us-ascii?Q?bI2T+H8X2BA7shjl/6c+LhgIidSlGeKJ3HNITqXB8QfHmq36x7SUV+zhjg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 20:16:21.0386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ec4b32-bd38-49c4-33cf-08dd81da8c32
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7890

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
index b4caeccbea72..284e3e8bc43b 100644
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
index 573c7e5ba746..58be54315393 100644
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
@@ -430,6 +438,82 @@ static int dualpi2_init(struct Qdisc *sch, struct nlattr *opt,
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
+	    nla_put_u8(skb, TCA_DUALPI2_STEP_PACKETS,
+		       READ_ONCE(q->step_in_packets)) ||
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
@@ -534,6 +618,8 @@ static struct Qdisc_ops dualpi2_qdisc_ops __read_mostly = {
 	.destroy	= dualpi2_destroy,
 	.reset		= dualpi2_reset,
 	.change		= dualpi2_change,
+	.dump		= dualpi2_dump,
+	.dump_stats	= dualpi2_dump_stats,
 	.owner		= THIS_MODULE,
 };
 
-- 
2.34.1


