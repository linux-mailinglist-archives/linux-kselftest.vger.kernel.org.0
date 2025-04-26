Return-Path: <linux-kselftest+bounces-31720-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F31A9DC86
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 19:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003B91BA2D4D
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 17:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4793525DCE4;
	Sat, 26 Apr 2025 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ftFSfCFP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2059.outbound.protection.outlook.com [40.107.249.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F4A25D8FC;
	Sat, 26 Apr 2025 17:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745688057; cv=fail; b=mFZwrrdtxo6OtQ8DMg1baU80uqMHbqjMQMq9c4U2lavxHnojVhGuYLDpKDpvEmDYb7GkPKSpXDl3MNZZfTAAM3WArK8Lp2xF0YUVT3vNr11vuW+WB54QIOpRxSy4cducQqBgygrM9B6IPyBH9WE2XJk07vDoSZhT5+JcMnQoZDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745688057; c=relaxed/simple;
	bh=L6Wfvu1MzB7rab8ZXQlsYGVi4wbdTIzHaazaK4n3Noo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nJjNv3lFeheCeiABzCtVohVQBXkeWGYcDrlgzixUHhkfrXq44m+APUyE8mdt/s320iuoTeSiNDX73boQq0YAsG5IWiDu5Lf1p1b1te6BTX25iRbIUMfgzjcTvAdRaQh7dAXtTna9knp7nF9fYLyfib+BW27TxNorrkjWqrR6Gl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ftFSfCFP; arc=fail smtp.client-ip=40.107.249.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hW5J7goO/mnRoX6aR7ZRCQzBLtVno41xUGjpYMSvcC3+Gn5Ub5sEN+Lt8amxYRZHBW9Xahjb3yvColQMovTUDbvPZoHR65Co2/CKb4WAcpedtS8pSNl3AMZETGOiXUoIUvrY794TIzHDZKHltsedNEbPo0/XAq20Ou+zRCJJC5Fwkg5kbhak6ET0LWch5Jwh5RJZPKjFRbpxbJbJWeSiCGWFqyjFjR8pR0ClycyR+ESZeLwERTbjPMfZFaGvZjP70mQCS3Bh+zhR3jiAFdYDw1paHRE2tWW8RNKmrnTHM//dqix6LvygOW8gEFB0w0vEUca8fwIYWUMxs1/7SLxZlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dnj8yC5eJCSJHgdvdD4ad6Cyp9kIyxDD+8M2jdmNDs=;
 b=h7VimLjl9P7CNHoA5ccsCfoyt3u8GkLTrlA5LE5KRjkuOCsLWkUyPPgTnF1C4N6NumY72EUkhOnwD4FXpEdVfXslmMmLeBqkT/Jxe3d0qEkJtJSQsxNIuUxHuZS2GgXfRoMTFeqLw48rkkJeJgiOdU4xqDbX7ZMPW2zvO3rPSgk2BTUQiT7y3aEd3j202eIoiK6pqjOYwxUir9ODNVM54ll6UG7HBS/LQhCYK0oR2bniPS/mEkct17Yiso/PIv+yx2sJwEGsZ84S4ho6+/NgYX1OYl8isIqlRTwEsi+IahxbM4JxsiSnhbaqQGsVINWp6wkfrrv9+x0/VxM+zNWLXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dnj8yC5eJCSJHgdvdD4ad6Cyp9kIyxDD+8M2jdmNDs=;
 b=ftFSfCFPmZ8la2hjejxVE5bruvVUoiUlLp+drXV4RpCuKtL6nhRy35NvGT8ui3r4pT0ZNMECvielknhaVyqtj/qw4FLq8bpZmw1LV2B1gk0ZNEmOAFAG+/DVWyIuEw1F6GmLKIKuQovxwHVNucah9aWI+LJjwfgxAleqAzDUaG4zTuTmrrmf4c9IDIbD3VODkj1CxpAghEkDAuwKtmdQtExZmE6v3/yOnt59O8QDU58Te22xiRVF4g/467i0XTjUzJg+tVUWpBiKJqJbnTxQ756lHzhaye1xlUEnPLoPmGpuNScGuekZwawH07fP70ZkfRfuzNKs0UPHDpfuyPKmZQ==
Received: from DB8PR03CA0030.eurprd03.prod.outlook.com (2603:10a6:10:be::43)
 by DU0PR07MB8972.eurprd07.prod.outlook.com (2603:10a6:10:40c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Sat, 26 Apr
 2025 17:20:49 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:10:be:cafe::86) by DB8PR03CA0030.outlook.office365.com
 (2603:10a6:10:be::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Sat,
 26 Apr 2025 17:20:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB1PEPF00050A00.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Sat, 26 Apr 2025 17:20:48 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 90A452012A;
	Sat, 26 Apr 2025 20:20:47 +0300 (EEST)
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
Subject: [PATCH v13 net-next 4/5] sched: Dump configuration and statistics of dualpi2 qdisc
Date: Sat, 26 Apr 2025 19:20:24 +0200
Message-Id: <20250426172025.9459-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250426172025.9459-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250426172025.9459-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A00:EE_|DU0PR07MB8972:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: abe892a5-61ad-4e7d-b300-08dd84e6b03f
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?2DrpvpM18GUsN48HcKdzMRRnUR1TL7mrsxRos+LlQcbepiZH2/QsYykJJiXD?=
 =?us-ascii?Q?h8r5bB241yeJ/8mLmMbUMf89Vk8Qjq2YduSHSYhUTKCH0SbPPsynMTPPAEbJ?=
 =?us-ascii?Q?NVf+q552opNprvt5gJLJNwd96K+w4r/h0zObzQFlbihBAr5I7edCVKV9JU+x?=
 =?us-ascii?Q?pWijmBiu+/1eigWGPoNjEVSOswURTeCpkSpVayGi+n7+YTza0x+rtvtk4FLD?=
 =?us-ascii?Q?kh35gOi/9iPiQr/Vj/KECBxT+BKqV7yYFZfqUyHqb9x/pBwOEogYa54sfy5z?=
 =?us-ascii?Q?jeLOwHOZbsnlOubtAXEYOIhv8+M3BCHJ2eCkBZg2T4ct94hhbo1f7dw/HXg0?=
 =?us-ascii?Q?bfHk8UzgJrR+IGXAdzCk8dGjF/2k204dNj3w6urTOz+lEJpNh/3C04LUVxgT?=
 =?us-ascii?Q?GQ4eOxafKWr6ZC/irVH+tfM2IERU+Me8WHHwJFW7DHNKOEm9ul4lyNjm1LC/?=
 =?us-ascii?Q?0sKdQhk5brFxALX2XbJmaGecXri4IfsuYCNYRh7bA+PE0S1JxUsyacGoAHVW?=
 =?us-ascii?Q?GapipKF0yvGS2ozAn1tzsmwBPk9uldaebZ6luSwlCTv8Hy2ghQOp6d/RYsc0?=
 =?us-ascii?Q?7ajNif0F44dwrzI2s94EfWzM939EtGI9xFsKtFOcn2Iacaaua0KP/ps53tLt?=
 =?us-ascii?Q?wJe0dyjyyFQnqXTrU35xrH95Pep0KSAIxYw4EzzDxGqXot2pXvLUNU/SF51X?=
 =?us-ascii?Q?pXWQfz1zbMjNcR60PyTH+wiZjt8Ddk+9+5TecFqeN/Yq9WqAHZpodid32KZh?=
 =?us-ascii?Q?92ab4vqQYhpa0XbfaiDP/gMb3+UUOzpqyhXQN4UKWgpwVIzqAcCpB/SeFFvH?=
 =?us-ascii?Q?Mxw/qInf4/YdhQ6+PKQwlWx//Z+ZCKy2xSND+b9CaH0wyNVZ7o3KLNs1xHad?=
 =?us-ascii?Q?z1d1s3QKLxpz715o9ECyo07bToYS+SEogKn/aKls36TpDRNGAMuY+xjUl8Fi?=
 =?us-ascii?Q?LB6cOtPELYA99TlEkpeArEvRKYwVL2ODzPg1yUP01rag6DU5IiJBQ1MVkcKJ?=
 =?us-ascii?Q?H0SEp5qF+jQVd1aMYH+s+5z7X8hciervN7mDy30ocijt2v2VKAhxBEqEbLA/?=
 =?us-ascii?Q?6oDpXa7p92Mcm3k8OJTtOMfO3vEn/ddafcHJl++5OAq7aBKkPn2JlLiXUaJx?=
 =?us-ascii?Q?2ZFhlf3+ejtLWzXZ4A5kQm/WKhe8zhXlSS1AX4Pk1k4X4PUo3SaW00bfUQPF?=
 =?us-ascii?Q?MnByZ8slxBceUScwd3c4VL7jc5NYvD7czteGxEXl4hU2Jr+X9BoTdgiIGtbC?=
 =?us-ascii?Q?K7iiVyQVSPgHiley2UFkTpwhQdZ2UNBEPh5SLgac9Sgq8JdQ+lcEcm7bWF56?=
 =?us-ascii?Q?jvjXkeOGX8s4KonZFnhfX1QRG4WPwZ5UIATlOzY/ORZB9BWo2F71a3eri+vZ?=
 =?us-ascii?Q?UM30DHXfFraLAp2Uvuvc4462nIhH9I27GmpNG1OvBWA7xHNiBVsmKR5J/K3p?=
 =?us-ascii?Q?DF3TheGwBcL8glWJJcE5C0kP9Mwp9et27bglNI9G8SJE8pGurRl2E4Tmy1yM?=
 =?us-ascii?Q?RqCFOZJSLBF0VdJwpiwnrOVQgxoNwgrSsEC68WmmdA0vDBmes53Wcea12g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 17:20:48.9850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abe892a5-61ad-4e7d-b300-08dd84e6b03f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8972

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
index bb3d9982b572..3c39771e4314 100644
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
@@ -423,6 +431,82 @@ static int dualpi2_init(struct Qdisc *sch, struct nlattr *opt,
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
@@ -527,6 +611,8 @@ static struct Qdisc_ops dualpi2_qdisc_ops __read_mostly = {
 	.destroy	= dualpi2_destroy,
 	.reset		= dualpi2_reset,
 	.change		= dualpi2_change,
+	.dump		= dualpi2_dump,
+	.dump_stats	= dualpi2_dump_stats,
 	.owner		= THIS_MODULE,
 };
 
-- 
2.34.1


