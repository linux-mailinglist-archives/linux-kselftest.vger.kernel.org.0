Return-Path: <linux-kselftest+bounces-35544-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEB0AE2B7C
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 21:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7321B16DF1F
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 19:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F061C84B3;
	Sat, 21 Jun 2025 19:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="AmpbhFqJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012039.outbound.protection.outlook.com [52.101.71.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3830219CCEC;
	Sat, 21 Jun 2025 19:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750534426; cv=fail; b=BNhe3onmx2Znx9ZMFe2BNa/rHHVtPQVEv6w2tjBo49iB7Q5DyfHRTfFSZGHf31ubO1A2Uh7GX6ksiD7CBrPc/Syg/LggMuHa18oU6L/mcYYTYcE3OHBSSGcScT1PhV2qOweIs3DVJX2lNfoikjsPO0tCECpL6CAKdzVXlrCzcY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750534426; c=relaxed/simple;
	bh=MsjM1e9DS7MV4cgz17rgEaEN63s0+GaBWaXZG3fJC30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ObEmsPkbCYK687z/nQ9v3GkadLtGXCsuzgDMFnr7uqBQBpb1K0Qxhen3BdavdQjPL1E1yWCc5eBuHPOn1KkS7XLI4mgKDabe6yu3SRy8ICSgbcL8S7q/IoZ2l0C1JZj2Pr96pl5lefRwlSLBPhAA9rd4UC1cQxU5OleUCCRVRKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=AmpbhFqJ; arc=fail smtp.client-ip=52.101.71.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7ciyh8ESLQrNKAyaFzq4vVy6U+8vTzoD1HYBr8axLxKspJVOR7LKmDOfyU/b8yAti4cFi7W/zMD7MQI246FQJUBBsPFvwJgcwMNBaZOR2B8QkqM+vnPaphHNSaebjF5i6l8V3kOUM05H7fBh5nDMsp4cCe9ZvUGHFjr7G7ps/aocEznx2MVp94Gv40SnYsD9ZTsKttqCfKZVcvKDktG5KbpNAWrihsiC4fO8/lrTQLtfS/BSLE4/FO2liIheJ/A0A+GzdxiA/KQ0c1RVpXODPVInUWDqHNgYTq9op5l9yq/MoattvUhIY/OciQAlq7EyYrVrUHcXe9V4AfCfae1dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPPPQUogFfEhggAgtmUcTjg1Hkxnki2uF1SYk8rGWRo=;
 b=VROYyedzGrdP54N8hV5/3Y5qs7/DSvbyaa72T4c3CWN4tlE+mRrPttVdPtHb7QH33ZV437gcnj8DcTEEuuHaN+3mF7zEbGum/WnUkvHYAQBYf0IbBIxSgGxcIDEAW+5KCqJmwtoRkOJdnTwSYBhRQGHhTDX2SAIw4DOx9Iq3FCvtWGV3hjAg6iIf3oLnvcYZKfl5+STTdPZC6XuuTbztJx9tQ/if01IXj50GA4G4F1lavCzetHJJJa/GTF0roQXfPxDsBTjVdksPapgu9BJDOg1cnD4BDK6xBoJhSeh/d6qBID1OIz0e37gjAubzcN9LTacyW8Fo/sGy7iIvUGHIeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPPPQUogFfEhggAgtmUcTjg1Hkxnki2uF1SYk8rGWRo=;
 b=AmpbhFqJNs9dTaiCmsWk7H1KZJf/OcCIv5EUaeyZPeMcaR1nL/AJOaP/5n3L+BJ24gw/Glc7Y1+uR515PH32CsefbtzcBZLzQde40tUDAris4NQdD+b3wCoOzjRWiN9OlAKutWqlwllrI2axwJ77gNWykDpasNxzG/XTz/SBj3F1xoTkmFWaMrhnsyZWJ5/L+NFX5hqXI8x/QCWdhInRca6Km+cP8ONwnaG4cpV6ZLye435SYS+kxo9wrDQ2tfcz46ir3rsL3v7oelv5gi/iq1HZ5Z3HkyH7kGpl0r/6y9L0KBxac9z8Ws1b9FrDu+eFjC6gqTWlDGAwZ3xv6kgbRQ==
Received: from DU2P250CA0030.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::35)
 by AM9PR07MB7842.eurprd07.prod.outlook.com (2603:10a6:20b:300::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Sat, 21 Jun
 2025 19:33:39 +0000
Received: from DB1PEPF000509F0.eurprd03.prod.outlook.com
 (2603:10a6:10:231:cafe::39) by DU2P250CA0030.outlook.office365.com
 (2603:10a6:10:231::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.27 via Frontend Transport; Sat,
 21 Jun 2025 19:33:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB1PEPF000509F0.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.21
 via Frontend Transport; Sat, 21 Jun 2025 19:33:38 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 6B5F6680034;
	Sat, 21 Jun 2025 22:33:37 +0300 (EEST)
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
Subject: [PATCH v20 net-next 2/6] sched: Dump configuration and statistics of dualpi2 qdisc
Date: Sat, 21 Jun 2025 21:33:27 +0200
Message-Id: <20250621193331.16421-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250621193331.16421-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250621193331.16421-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F0:EE_|AM9PR07MB7842:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 29b571df-ef92-43ea-f13a-08ddb0fa85d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aoTJhYIp+Pt43r66TeW1dY6pbz/zJnzQ0YfHGpCThx8IcWit/ZVzlRHs5kda?=
 =?us-ascii?Q?Y0Y6DKQU8X8AQd3zwKtYiJZIWREwwsttpd5sumdDsmXg8s21N2V8VD9AWAgF?=
 =?us-ascii?Q?MiBWFPWZMo/XqLD2OEvFnPr4nSIiyEHLrLFtNVsl3kcOyGRK32IGFgidwUfJ?=
 =?us-ascii?Q?3fDi8NmNq9ybalBUgmzuDXaj4wjUlX2gB770a1JqxBdce1c1udiy4kQReDh0?=
 =?us-ascii?Q?AY37q1g/yctYYRcoMEDrMhUbuvcVsjITdzPeFXVC2aaB4t8eq4tDwIbaDlD5?=
 =?us-ascii?Q?JkxQAMcrfc6B5a58LDFYadeBmWIlsz7b8RSk5DNkaYgRHd40hIZox/8roCOz?=
 =?us-ascii?Q?CU+cvuGgDhe/Ryoude9QGpp/pJChrWkz70LNSS4INHpNDoVlhfBIosiCHz+s?=
 =?us-ascii?Q?g5gJUF67CaNlysX7zQRid8KhosOwrWnLV6AsVui6mhiViqh8JIqj0KWlYnan?=
 =?us-ascii?Q?Z/HgYuaxfTD71v2FNxI1bX3fHdVRrN/wQyVYD95cuw86GwUB4StAEOqu+sv+?=
 =?us-ascii?Q?F4SoeyKwlSTlq3pJNB2IK2bfGnR+1v+FXEjkrWHlE0k/tCMJSvQlDjniadm8?=
 =?us-ascii?Q?LnbIkcn2eBxVGke0VBpAj6hPN8/c7eYe2o2ySvnOdQradTLp/PdFeSD6d3FK?=
 =?us-ascii?Q?lAznb3LBJxnFywj2Vao0G/Cyr9K71rv7iiOEUh6Pkh57iEXvNF2oxIz3ig3b?=
 =?us-ascii?Q?nDuvBMvhod3MejQeCJaOgkixCzRQENsUHnbnDeKBAWmxuRj2g+vD6HV84Tga?=
 =?us-ascii?Q?+GoE1+ziUrL7BDxZ5Ub9CubmFBj6U+gndJQVW8WceRNkrMY+rW5gwJelM0pc?=
 =?us-ascii?Q?bauwcYysTiQANoz5CltBFKRnLqTIvubzZXDsvwABhfY0Bxu3siv+oir5iXxx?=
 =?us-ascii?Q?jiJVDzfaNGfsK7b9LqnwLcvZiLGx3IYO2YM1azh9uOxLsVo3DiVYuCNc6jm1?=
 =?us-ascii?Q?VGpfq3jFrh6RTQo0zhqpfqCT6kC/s7asdZbn+zg8sZurFvMGS09bNpQSJC7F?=
 =?us-ascii?Q?uCH/o0+Hq+m6rJzLV0Umx3/OISEPQRFxLsQ7fR58mYyUJBRqaUoCkpaSLY0p?=
 =?us-ascii?Q?0P3nBsklcVaBWCzh7awEbIkAe7EfIcayVQ+55zHyLIV2xgA/lxNiXBDHI3ZE?=
 =?us-ascii?Q?ehi/yBQByacGbg5GSvR33AKra+lTNkQlxl9qX48rVKTC5YWVsyAAPY3lL+tO?=
 =?us-ascii?Q?qmw/z2NjmMREprATTOvSG13St8p6ZZEh4pLRyoU2vMMuzkk7FpvPelQhR8i7?=
 =?us-ascii?Q?YVHnfVZG4j88ecTmYO8rTKaQWFbOMDseqXpUPCpcqtbN30sGlTVE+ZuVW5S1?=
 =?us-ascii?Q?G38W7JcBEX9xqxRL/CLUAryR6ZJ7r6HIEU3yMJAkVFcIqhWD4fZK/pU/cF9T?=
 =?us-ascii?Q?X4bBJWYG6wK+RcjFWTWS4gtCFoT9N9CRMKLLL5jXz+viCaqFhsZyvDnpa/AX?=
 =?us-ascii?Q?tiXr0PDd695iFsVFZJ1Z0tREZoPQmw9FlopTqGVNzCr2Zn+c/+Mj0xfyFfeM?=
 =?us-ascii?Q?iPYISY7tfkZJywIVuJTm65LvXNBI+EyOlR/xMOm3t0kKqWYrWogIq338fA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2025 19:33:38.9721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b571df-ef92-43ea-f13a-08ddb0fa85d9
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7842

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


