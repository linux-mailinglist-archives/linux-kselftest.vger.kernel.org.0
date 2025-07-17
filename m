Return-Path: <linux-kselftest+bounces-37521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBC4B09732
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 01:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23C64A31B7
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 23:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A46246764;
	Thu, 17 Jul 2025 23:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ARpsnTNh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013013.outbound.protection.outlook.com [40.107.159.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27192417C8;
	Thu, 17 Jul 2025 23:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794684; cv=fail; b=LkTWqkoO1nt7wcyCM/hSTNNcNZBjICZPJfQ/kzRMRIu9m7XcAoF8nprq3rovTRcZ+SZJJ54RCynVHz09oLFY2QhqBw+0nKwXbVDfR+JEMsR993P5MWEU0wNO+j7FXiKwcZKGu7HYcetazEyTE6b0K9/t2pfpb78mSPziuo06H5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794684; c=relaxed/simple;
	bh=U1MsW9G6rYPaqilypstsBcvgoHSphGintSVLS6/n+rg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T0oc2BK+Tgu/P+D+K5X23SD/JZmH6dL2u9plajofHx4gOe4q2x9F26wiA8QdvCt2R/d0WGPLGD2PlmVrFnPKCdiyKT4KY1MpGp8XKLCH9vxMfDyxTjHlSOZVp5X0b5zY8QKqtSW8zu+DGVS3FLsi3SB50RV+9xi4by8kxUS4GCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ARpsnTNh; arc=fail smtp.client-ip=40.107.159.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/RhESGDs3WR1j3fYOHbiv5Ph9nKkeOTeAzxTEsTNVh0mtoD/JOZlZtAEM1c2mVsxatJ9+3xDSe57mQQDDhWIGWQERBA6y8oGsY9ieWyMRMK6vMW3HfB3GzEa+5kJLg7qiuDRpcSilfS+aMdtDQ3P5Bs1F6U9hRWVtKJYv+JIau7I88wCJEFNpfbBH5nN0tjUuvnNg/4emWySEkHerOE0eWZupMSJRj0HlX/5clez1w7y4W6ifvf+96OACVITyMcbao5UAqa6+8UfFGYXdt9wWrVJ1isTQh3izvWhXEENX2ichurva8JnPRvM2fl+yi+3/FBd65+ssEh05L6gX0Urg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5dsC7kmvFKaPo9Aijqe4jTuWAwB2GbgCoXGuEQ6kDE=;
 b=krY9CSnJOwlT9y1IwkrTJumSRsSZGxtU8AWAwzcNGVEICYL0Mra5WJAPsSBxN5UGGgSyciR4GtUKe364cHUm71zU3nRz6yXAU87P1miMI7MnmOa382+wBMNCkKhI9PoEEeTj0vcJxnJA3qpoAglD+LATa5RaHFzhp00c6ENZabke2gPjfMmwO71aW1mO0RW2+sz3Px8ubI4fZ59w6reyXrq5LwEuBUR4rCrTgkW24a8XCmpFUOD2ZKMLPEBHPl44R1fQCEgu3VtI4WdB05YdrJW7DT0cjD3ue9zaeCrRBsNK/tUBbdhp9+7ddh1tlezj3dwVEvGxc4etK9SXyfgRSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5dsC7kmvFKaPo9Aijqe4jTuWAwB2GbgCoXGuEQ6kDE=;
 b=ARpsnTNhoHNBfkqB7N7nbzkLrTfnDnpj1iWumBd7Gmm+QhAFgklfFNeWFpi44LHEY7wAqKD+f6YFioZ9WFMFLq65kZZophH4u3LBHnDMWIBqPvPGqgBGDoODfiFxCNznS9+IS0cm7JwuPHSO8oz+gc76QzB6CQzqO7L7Q+Xk+socgmrr+By7JmvPxIERv2E3adKWTQaYwA6NUuKnmh0goL1l7UiiynaUigLhaEObNpQXj+/zE5rv1V+4kPq00iFfUwtSAlYO0fjRrE2y2XPbBOBJTT55wtEjZh7WCRVFRFM+7UKtAlOA2fQlvQb2qu8ob3u4Dw53uE4QnfAFh4nXBg==
Received: from DUZP191CA0028.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::24)
 by VI1PR0701MB6797.eurprd07.prod.outlook.com (2603:10a6:800:198::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 23:24:34 +0000
Received: from DU2PEPF00028D00.eurprd03.prod.outlook.com
 (2603:10a6:10:4f8:cafe::33) by DUZP191CA0028.outlook.office365.com
 (2603:10a6:10:4f8::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21 via Frontend Transport; Thu,
 17 Jul 2025 23:24:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DU2PEPF00028D00.mail.protection.outlook.com (10.167.242.184) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21
 via Frontend Transport; Thu, 17 Jul 2025 23:24:34 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 002F168003E;
	Fri, 18 Jul 2025 02:24:32 +0300 (EEST)
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
Subject: [PATCH v24 net-next 2/6] sched: Dump configuration and statistics of dualpi2 qdisc
Date: Fri, 18 Jul 2025 01:24:23 +0200
Message-Id: <20250717232427.69216-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717232427.69216-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250717232427.69216-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D00:EE_|VI1PR0701MB6797:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0545af91-52a6-441d-5eb0-08ddc589171f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j+O4KcJQFAYnSWxeKsW/EfHTSIlkwihr4iPpsAiSF/R9OX0r5IoKDRhR9mzY?=
 =?us-ascii?Q?P0ieVqdM8Z/HxYaQYST+Ox/jsiWCq3vC/Ma5OOapgcSj+yCO3+PDCnwRFX6b?=
 =?us-ascii?Q?ZhBd3EiFSSJxGs1nKpyfXTGDvJNjB/hKJEpmGJWXxPhfymjOgtDASJdZzP1A?=
 =?us-ascii?Q?IleKEgpxXvbvV47+d6XSM0hPSzuoQO5D0UiOOE7RZEcJaQ0mjMtC9HAZoFJU?=
 =?us-ascii?Q?Msq3f5hYuOCeOJbqU9J5/C7ZD2n6ZI23pNQ3G9t6VthA6kXpaErosSS/uSjC?=
 =?us-ascii?Q?fF8IiHYliDq/uCTRxwAVrxeemxlFPvErPQd65dnVRZU+XpdA/wLj/UubOmXz?=
 =?us-ascii?Q?FVNT5TT5haXCGg453ki7Jb5KfWK0xczszb7ghUsM+9iA5KGyCioOIPINmXRa?=
 =?us-ascii?Q?u7a6Rjc+nkMnE7/KhgNrn8R92mUjIZHcFsXhf7AkZiokhUb0PqEIHAfyax7H?=
 =?us-ascii?Q?hSAqAFVNNkeMiPIAYdLrUhthewEf0bDq/6icK/lR2e8s6Bi29Px0Sm6brm6J?=
 =?us-ascii?Q?a7rVpYyrPk5kyFkmJJTNjylMu7Cd6+qgT/P4BeSPNwMtKo8gzVWv3ZM5SOHi?=
 =?us-ascii?Q?k7wR4cfpEWoAhfSAxxQCp/HAEbXypfUrHM/ERiHJnt1sCNW9J7L54ggIGKD2?=
 =?us-ascii?Q?aovpeYZOiOLyv13agYK8xrU/Mr4/jvqND6S+G+YUO1s6+lh7oPDw04J12y6S?=
 =?us-ascii?Q?LDJDPc/qJhWTnNJBBDLwK/E9TQYCqPfHeTfuC55iz0uh+APwTo6er2w7QRey?=
 =?us-ascii?Q?21fcmePdIkMAdbWoKdzZ/PDxFA63ETBFdfb4LTov2ISPKTZd8ziGH0AZQuaY?=
 =?us-ascii?Q?N/qgPK6WtBkWyKor4VPjOlCAz1w28tq3/CbSgYQ9eDMnRiRR2djP/Q4GYB5B?=
 =?us-ascii?Q?KYmjao3v8HNj0GS55RxEwMhHPWkaYwwSrHMgDp9YmZhH9crM1WbhmW8fZ7sJ?=
 =?us-ascii?Q?qibIhUxXOtCnhZRRNd0Flmm9qzdbbVi4Zh5/n2QprfmawH0gglhVMvdy4JKc?=
 =?us-ascii?Q?eCHl7Q94Cv4JtVLu+e+TJGy/I9VZh47oAUEwfK8RGg5oSGt8foDkigPItbgd?=
 =?us-ascii?Q?PLya5VpqCFiKvZfq7tlsRYxcZPosRvDyFbs3SKbwz7LW2NWThm4cgJCw1O8s?=
 =?us-ascii?Q?oyG8/ztObpGsMmyH02zezOv4oDy1IUUygBD512ySaKSV4f/MupPPiFb81Mnk?=
 =?us-ascii?Q?pwVyA2NgmPJkKYzddkDFJy1BfmdZO/SSIbaF5HKBkGRfJ/zp/rEMNoesgmAG?=
 =?us-ascii?Q?bK1gbMpeLQ+doCluL2loTCeD8lF2+N2fE5EjpHEOudh3wwO7mVyIyvjQxsyo?=
 =?us-ascii?Q?WXFPrln6JtQ9t8qbInqEdFoqGHWcDKHZyyeXMUFTRW0f7HlMPDx4VfexjtSf?=
 =?us-ascii?Q?FcrlEE6S3/G8dhgXY681vD57JqKpEZ1P6Rm4UpvT128EZPHUAo6EFnUuWerp?=
 =?us-ascii?Q?zCEgw0iJNhOxH729MXN/qXAqjmBJmyUhxBUyHIN0gP54L+H+f70QI8Lbi4ti?=
 =?us-ascii?Q?yAGsUzjTCfBl1QIXDA3s6m+5PiLcXTji73jIpypplkBh64yvAHuWGM9gow?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 23:24:34.5122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0545af91-52a6-441d-5eb0-08ddc589171f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB6797

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
index 03bd0a21baf7..15eb6720c377 100644
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
@@ -300,35 +317,36 @@ static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
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
 
 	if (tb[TCA_DUALPI2_STEP_THRESH_PKTS] && tb[TCA_DUALPI2_STEP_THRESH_US]) {
@@ -337,34 +355,35 @@ static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
 	} else if (tb[TCA_DUALPI2_STEP_THRESH_PKTS]) {
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
@@ -376,13 +395,13 @@ static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
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
@@ -459,6 +478,105 @@ static int dualpi2_init(struct Qdisc *sch, struct nlattr *opt,
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
@@ -563,6 +681,8 @@ static struct Qdisc_ops dualpi2_qdisc_ops __read_mostly = {
 	.destroy	= dualpi2_destroy,
 	.reset		= dualpi2_reset,
 	.change		= dualpi2_change,
+	.dump		= dualpi2_dump,
+	.dump_stats	= dualpi2_dump_stats,
 	.owner		= THIS_MODULE,
 };
 
-- 
2.34.1


