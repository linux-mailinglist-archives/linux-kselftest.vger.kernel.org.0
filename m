Return-Path: <linux-kselftest+bounces-33750-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20097AC35E1
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 May 2025 19:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE464170527
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 May 2025 17:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C0225B1EF;
	Sun, 25 May 2025 17:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="mWxHoPo7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55876219A86;
	Sun, 25 May 2025 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748193577; cv=fail; b=j8l4SAl0VAfusRlOVT18kaa3frmbEzuKQxjRJE1dDU/gXXYISNipyzN/C42rdAEU/x42d7CcBmznadYq3u4MkReeXYlAuAfwwW16968lpi9I8nua3qBe9/npFkwRqzBp632pD02Fr7U2Mv6eot1prGxVMe9ZfRkYJeaqWpUTrT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748193577; c=relaxed/simple;
	bh=CKI07YyQ67u4Fkgi+cRbjrEyAElaDbkgngxYAQ5Fh+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lbTWeHet2aEgIuEeA4Lpv/iQFKj2hxfWik3SFdjs9zkph/f32saUdiOdagEyiyzWPFNinMIBuZ2PEev+DwCwmQDTovFan3qC4iEbTrKbv9PjI4YLlmsQu9cRa6zEd3Ws2elzDdfuhcaFobBwpiaAvTjTy5avyQIxJVXY9v9pIl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=mWxHoPo7; arc=fail smtp.client-ip=40.107.22.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PMxAgAOZOVydzvZ1RB62Hegig0gs4Kos4uMURMgcX477tXg+/GVh7E2UqhR3WsB04V62IxWOor4EYQrBM4znzxTefA4yJkwEOTS80TzUC2LKX+9C+zFCnsFUakyiprfIsIY2CdSQwOlM35pOhEV/ncm+TKzt6pZDF/Vsq3dW74jw1Q9T/Ht7cvAp6OFvnJe8FkHg88ei3I0oViRZj4XQRSGSM5RIAs65xROnYAJQ6IQIDUBC1n+2k657kHbHK1r6H3tcuV6OLFEvVKkUZKENEAfmqX3ISs93Hxoxcb24bCTZUpgZFCOvFx7Ily/dd62F7d0FusSI30ybYo8i6IKZAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vn7rQSGtMl2hg/uvK0rAk40Hlp/GMVhEWJ+kK7f+G/M=;
 b=uVuTw9mtsxuHD/7oUAO9ndJTlhDUVU+7xo6SCTtkE14ljViwzADRWpkkF2RBRJJc/wqAQFoiT7wPoqxxwbL6sjAe0zEfiMI1hZ5D15Jr1Nh1OnZMeUlu8KEwoi0Zq2OcRcSSc9gBGEpEnzMg//zhkbyYqqQLOejVcxA7f5khctCU/TefS//7OS1C2+RQomctWHDu9WL6E6ImGyf1J+a6jZdROmloACtHSDQHFDHuXbJjver3Ph6I8ioCAUU0NwF40kRnt8H79l47XlwkJygr7Wg99XEHcO+hO4tDDJ80nrVOjUFERidgoyu1RV4lHLQq+73luu4cI0VFXRK1Lq55WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vn7rQSGtMl2hg/uvK0rAk40Hlp/GMVhEWJ+kK7f+G/M=;
 b=mWxHoPo7bdFQu4Va1g5iC2we1n6Qt+urq3Tcoqzhi37CTGE7bdh+RKi3yDoIhFzu2fGRqhBcB6ArG1EQT1GTb1ekl+rP/LFAZ/3zTPR372wOJfjxLRgxHx2g0Y+smH5PAK63cTSTS8D1IXBhEaJO7URYOFXWimgZVOQ63uzRIe7XWmnBEOZ0VvFkIhYxi8wK9ffqghJpmg9+PknEz3anjkvvZVl27dTIBK2Qq0dQiXbohe0fMC6aMAlYQ5sI76qz9+GPb2gjC//uP95cnmI+FStmQvKDT3XtpJ1u35A/dBX7x4MwKc6H+2nPdla+HsM46vYXdxi0fLXlr7os6zcUSg==
Received: from AS9P251CA0007.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:50f::9)
 by DBBPR07MB7657.eurprd07.prod.outlook.com (2603:10a6:10:1f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Sun, 25 May
 2025 17:19:30 +0000
Received: from AM3PEPF00009BA2.eurprd04.prod.outlook.com
 (2603:10a6:20b:50f:cafe::26) by AS9P251CA0007.outlook.office365.com
 (2603:10a6:20b:50f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.25 via Frontend Transport; Sun,
 25 May 2025 17:19:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM3PEPF00009BA2.mail.protection.outlook.com (10.167.16.27) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18
 via Frontend Transport; Sun, 25 May 2025 17:19:30 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 5153C20130;
	Sun, 25 May 2025 20:19:29 +0300 (EEST)
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
Subject: [PATCH v17 net-next 2/5] sched: Dump configuration and statistics of dualpi2 qdisc
Date: Sun, 25 May 2025 19:19:21 +0200
Message-Id: <20250525171924.15603-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250525171924.15603-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250525171924.15603-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA2:EE_|DBBPR07MB7657:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 318dc79f-8d94-458a-2bc1-08dd9bb04f8c
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?5q4OAQHqdP1IzE/OKuHFo/cmwB+/5Sw/8Tcg+2hFsR3bJiXAbieJIBMEVcyp?=
 =?us-ascii?Q?fG/UOHY/XDyAuXbQAdS3ib4BWsiuKRJTzRMoJgUYJvNnfK+m4qv30cLzsZOY?=
 =?us-ascii?Q?jsTIosAdPfhm0bWmcPkzLIFQB3SPfLOK820Ha4rvG81mehcYjEYz3mUqF3iq?=
 =?us-ascii?Q?1wQSVT2CVwU8UvRwgIMOFL+dxOmYPhkTNbc3K9eiYC219eq5zwlmIErLNN70?=
 =?us-ascii?Q?sq5AJQwHS1n7rP/Km1MGnxf/MyHicQEleMNfpw5WlcgJ+PtfyBUMiN4PRp5s?=
 =?us-ascii?Q?P0kmgU0ZxA3qePL8hnURYZZ48+P4Xl1Xq6SB/j1pxhh7VVuX7JzVyHHS+NF6?=
 =?us-ascii?Q?meMoecmUdvcmkX3IWrH8Ny5lUQ4yD3vPzZctP6C4sGyTHfC0fhkt2gskGM4E?=
 =?us-ascii?Q?UA/3CdsQCWp3PCdl6MyEUwGYEOCPFiPceQKC0gpxEhptNM6TzzyimZo6MS+v?=
 =?us-ascii?Q?dKEfQNYmb0uAW2QBacNVRrm695IfApugYFxLNHsu3AMbQK6KGobKibN8dPAe?=
 =?us-ascii?Q?IxtLbabsx++l2Gv26H6KwZJOnZHrg4vdfyyerRFSEGh8aXdMKWSvnHEoQ2kq?=
 =?us-ascii?Q?QVIWgxamQiOfI21eeFafJmfCgfVDs7EFI7rrJrUyaLo+Hswp8V+a4oHpQ1KD?=
 =?us-ascii?Q?TYLxNKZBJgQZh3MiEtaPTjOpU631DHXkbKtmIku0FhJ/F1c5fM3ME1HTDg57?=
 =?us-ascii?Q?PlDFWL2hSC0Z3FPABkU5wCzrnSGcHELzijoSbhlemUwrQ4zjkGPgws7TdR0/?=
 =?us-ascii?Q?FJWRVskCFQ2+LELOstJU4UcchWEMFOj+V88o9lz+A027wuwjEg7mVzswF2h8?=
 =?us-ascii?Q?3mnzsqoyr18fhC0kzyjcY972Px9JFr9wt8xTVtIhhwetwRpH7I6zrJpPDWE9?=
 =?us-ascii?Q?E/pRIstzN4vCGM8nogd3Be+x/X96tZuRtRoKTyTJSX+RJsuceXXEWvj2Qgdg?=
 =?us-ascii?Q?9KWFd3kKjSP3U7BjX0DMD7GO7pmuOhVsmeI9aA/n54s+GkrXb/NCmkhY0Yf9?=
 =?us-ascii?Q?w2oayHSHaKzeT+A1mJ71Wzn1BpbEvEcq4UabJgxOWKVVnqcYE9YhrW7xEz4f?=
 =?us-ascii?Q?s6zUFitWgWlSwKrU1v4HHILowr5FlNnzNQTPC5PaDnn8yhMJa8zK9RvDKKn6?=
 =?us-ascii?Q?e3kwgoRqGomQnGMcQPQCZvl4kxIDVnd6D3ZKS87IrqIne1G9+As5gJuG0sy6?=
 =?us-ascii?Q?H/cPoLMYHIL9fCu8ECBBhOM9b/nNNzKypmBGpa9hlxDRmlWBmzTPO3DO2j1L?=
 =?us-ascii?Q?PbOJpbGnxMxK8Z8LlHpv8C7DzYY0xjWliBU4lxM+pZkKlXxNyKcuHU/bxGVv?=
 =?us-ascii?Q?zm6yNFyiIOhminMCjzuh8XAFHmSaWHF/SOOKqk5a635j86smhx3ux2T9pvAt?=
 =?us-ascii?Q?2dg3vBTDXZEoqxs1sqDiYMJowZXfQF2dWz0WqYN+GaycZyrHxKuqAlYo72SU?=
 =?us-ascii?Q?drawvctU7YO0ompe0u2eEy034ponmijXWt+awSyVZ6myGqikcMQF7DF4/ErI?=
 =?us-ascii?Q?pbLfglE4U05xGI487l9ltD+S+9PgHF9obnzbTUUh2IAJkWS3IYg1ox++eQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 17:19:30.6680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 318dc79f-8d94-458a-2bc1-08dd9bb04f8c
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7657

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


