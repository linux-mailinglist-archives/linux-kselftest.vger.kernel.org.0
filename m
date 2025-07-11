Return-Path: <linux-kselftest+bounces-37123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3491BB01F2D
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 16:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF2587AE767
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 14:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C4B17A2EB;
	Fri, 11 Jul 2025 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Pg4nB2Ee"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010032.outbound.protection.outlook.com [52.101.84.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C9D14D2B7;
	Fri, 11 Jul 2025 14:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244345; cv=fail; b=IQU1cUS7L/0nJycj1xmLghlKAgY+EiiSe4TPm2b1bqYYY/TnyWn9U+n27iJKlimu1YBl2xvpcswSEVhxdcmGO7+ZOTqbkrLUnHsq2ZmWvfz/MurGAWwaUjJ6U2HTBWlys1nZWPEmF6xWfWRpTWRwlOJ+Zqn99CbwQvyJxxGaQwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244345; c=relaxed/simple;
	bh=6qPxu4YaaibptGQPB4LpcypMaGAH0sTxFNtGfzGt6GE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nQhld60vRHOyb5yK9PBNPbXyGLgG4FyYsZFHCbuox6ydt9sM5JHwgO8xb8Jc/EQPnUVDucveR0PN3RoS8VdbwQoYnf0L6d4Gp0EKRU7Uhs7MEqjSd0weRndCPJziVB5q93VfL/HQ29pAVS1aQqrVV4M3f0mOruAq18y513TYPlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Pg4nB2Ee; arc=fail smtp.client-ip=52.101.84.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=heueaAogqPphr2UbKxxbR/u64KrFw++OOlI16+J3zLLEiwoIuKYP49KRwABc4Ho7kYdgEEd/HtglWBMM2RIsuyARqGc8rJBjp5v0JVPWpMmqUA4Kwq0fdridc2aemBnrBNvqu172xI7Ja7DkDii/aJpUm+eJ4eQaQ8B0PYVeQ525a5HCTneEWYPTngrX55QU5PbRgZkt08BCi2UjtorIiTW+5JrOv231H0h4Wxaf2it29Bh4tvwI1n1xcvUJC2bLv3mXPzwSnzNmNgGv8I5Zwhz6kb7Gtnwsy6gDkcC/esWbGG+O6kIs0EpvYx2rjxyYlWEUp5M/IQYrGOZq5648Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePUm57KdbiXcu9VIvzjmfckW6+KNw7ey81oApuaQfiA=;
 b=dOeV8IWhRF8xbYaCf1GyKBLPVCY14VIv1SgeVSsKjvMJcsbeQ0XZA/5QzMjMWLKzr4yTlwQqg5OHbQLbuedJ503nkne6OGVREN2ZJPn1iFyeuSFqKBCaZEHKJK9qN0GR0/Xtc1kikv+ZMloz/YYk8ztT+uU0phZcc/3I1TEcbK0hoN2eZyAiWds3jAVxDHc07frOhAeXKf8ZFLQyBxB2JrdSyD8SCKNW+DEUU7Ut5XgsJ+2O7spCsFNt0YLxggWyJxgdAWD62Lxxg8KIu+CjCniEnoRKTjExDl8AVoXIbaWbXvQ00WY3E9Pff6Hw07cA61q87N8606g1hqnWBTiteg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePUm57KdbiXcu9VIvzjmfckW6+KNw7ey81oApuaQfiA=;
 b=Pg4nB2Eeh41GjyaR5mMDs+AZM9xDMx7FHTXJy6RxfU2LekFQNq/37xOHYFGdpaYjY/mKE5ACX21oUm54c1yXtHasa+9wuYXZdBRJoxPNmUuBi2mqfHWV4n89bilmHykaIIa7ZgmzV9+0PXctXaotI8//v4uuRHb+p0TkemkxZ8JgmesotT8mEh2O7Lf5jlaiAIWp1cU72w4f+OHCRL95DadEssPTGcIAQFyjips8yvxE1GYFy4fMn9346Osm/71M1n3rlcIJ7BV/GzIIRYnTpISHDLTYg3RPJTF0/N8bmNZfX4KkZu7+Lpbp9Jss5Vpgogr4bLW9yL37PLchlNemww==
Received: from AS4P250CA0027.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5e3::18)
 by DU0PR07MB10633.eurprd07.prod.outlook.com (2603:10a6:10:59e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 14:32:18 +0000
Received: from AM2PEPF0001C709.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e3:cafe::12) by AS4P250CA0027.outlook.office365.com
 (2603:10a6:20b:5e3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.26 via Frontend Transport; Fri,
 11 Jul 2025 14:32:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM2PEPF0001C709.mail.protection.outlook.com (10.167.16.197) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22
 via Frontend Transport; Fri, 11 Jul 2025 14:32:18 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 99D6C68002E;
	Fri, 11 Jul 2025 17:32:16 +0300 (EEST)
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
Subject: [PATCH v22 net-next 2/6] sched: Dump configuration and statistics of dualpi2 qdisc
Date: Fri, 11 Jul 2025 16:32:04 +0200
Message-Id: <20250711143208.66722-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711143208.66722-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250711143208.66722-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C709:EE_|DU0PR07MB10633:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b75d974d-8e22-4cea-03de-08ddc087bd1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UPE9Iz90VeGgTcB3w7kNGV2ZsE8Nuy/bfjUw7U7X29k+c/iMbE11FHBiQcqg?=
 =?us-ascii?Q?mOcCnHolezvxpsGmVh7ztXl/R5lZwy87tDzEXCd1Fi8nCeWR+tfT+xRaK8ht?=
 =?us-ascii?Q?OkLt1DlhSGzHGQ01FzjsX/IDCEgixTdic/gqzoJ+9pWUZEir6OI35fvmpcsH?=
 =?us-ascii?Q?0JW8ulCPai5CM9LmprPq6HTt/e4QwHN2VPlX5ULx0Yf5ktwAJgWveQCcYR8v?=
 =?us-ascii?Q?sxp0VOBRgcKhlIiEeJLa436N9Z+3aT4yuCoMjO4utNCAwl+vqbvWNaxj1zvZ?=
 =?us-ascii?Q?5ldqnvoT95Px7dO/FXcCu/gL+YteqeBedZzy5fiZT5x45+lylt1PUNmQlGDI?=
 =?us-ascii?Q?mSiLpaxnEChvQeWiGHyd1MMU9g9otosFu0oJPJRxI8ABmMinWijDpcikwWoQ?=
 =?us-ascii?Q?MKd5oK8DxOoEUbXlubL+Ee4QB7/AaEeyQ4QtLheGUb+G/dFoGZarjCrBBkBA?=
 =?us-ascii?Q?4zJy4DWK7ytYiYzuKz0T9Cbm2ZaWJRVW0gzp2jCcD6td8YZNXxAZiIkPLbig?=
 =?us-ascii?Q?HWht+L1dwyIHA0Eq9mZpg82p4UcjnN+XvCg9VByuWeTnUeypQa8enTxrDVi+?=
 =?us-ascii?Q?WxOP99EYva5TLktI3bes7ItC9fHaG+HLfVkfcw0Bml3MOoHEX65zMasqQui0?=
 =?us-ascii?Q?SoTppRtphKo6xM+NKLJ+Ie7XsgTvig5K804UqyWazkGKMexEzHJwO/2Nqtbo?=
 =?us-ascii?Q?hVeeq4yV+3VOR1C6Sv0bixXr5vRow9LLtTgAr+V4MJOBOcx7MGeDdGbOTyJ6?=
 =?us-ascii?Q?jBa3cfzQJ7q/+OxHaHFumKbBEXVcY+5RPfj8r5oIyoLJa7EjCL3i+hUqkpWd?=
 =?us-ascii?Q?FKNwj2AxifQWBP8An29Eto3RzPa11tVwF3/OE7Y3jJzNtD+U7oOTV+3vcicB?=
 =?us-ascii?Q?8bx/3hruovZG7g9s6N57ddumQDSx5Z8fZlt0vuLQE1wvCLnTsH3KELii+ZgZ?=
 =?us-ascii?Q?d6pQGvGeo72TpAJc9V8xwZ4qxH9YsMtkP72zb3zJTL8ZEKrr1AUabLA2Gnsh?=
 =?us-ascii?Q?UqB8xM2DFMFQsshNwJPvppMtgOFQRNq4gossY+MFcuy+m3kS534VTZbshUGj?=
 =?us-ascii?Q?1V7wBaCT1SSkmPJ1rsNVqpdlCcdjlYZh3rGpGzlaM5PZFQ+U8Prgq4y+wznt?=
 =?us-ascii?Q?ddozsnG0PZ5FUQLaNYGDdLCmcMLTVyUJrCffP2Lad71HjIx+s7XA3XmQcRLg?=
 =?us-ascii?Q?eaCf34pi2FOqPxH9kRE3B7lRISLfu+3leUD9ReDGe/GpBzJtiw1XmfE0+OVt?=
 =?us-ascii?Q?TYp31jeUnbjrba/t7c7627i6mtchhSaMgu/G0xbTfYcb8VQJrlRuXUucE7z/?=
 =?us-ascii?Q?DW7HuFJeM1rOxeG/wvgeSuVFakzVdeoUHjgaOdn+PvJ5NhmndNkzQfq2naJz?=
 =?us-ascii?Q?3kN+Rph0WYjh9heZj6lndvbZ0aEtdZPLbyTAAmsmq4G1csXqLuImv6T6vBw3?=
 =?us-ascii?Q?UkGW18sNfOkYKFueb0Qwn2L+tpp7v6s/qQ2fqoj4hDZQTqRW+0QYaDFrXyap?=
 =?us-ascii?Q?D6SwOE1UtvPbJGgAVflCEttIaANNTrA2adJ/MsN4yJRSQsz8xasioA0hHg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 14:32:18.1411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b75d974d-8e22-4cea-03de-08ddc087bd1a
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C709.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB10633

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
index 1eeee2f8c8dc..39edd57d3d9d 100644
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
index da7c15a743d1..ceee9190696f 100644
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
@@ -300,68 +317,70 @@ static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
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
@@ -373,13 +392,13 @@ static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
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
@@ -456,6 +475,105 @@ static int dualpi2_init(struct Qdisc *sch, struct nlattr *opt,
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
@@ -560,6 +678,8 @@ static struct Qdisc_ops dualpi2_qdisc_ops __read_mostly = {
 	.destroy	= dualpi2_destroy,
 	.reset		= dualpi2_reset,
 	.change		= dualpi2_change,
+	.dump		= dualpi2_dump,
+	.dump_stats	= dualpi2_dump_stats,
 	.owner		= THIS_MODULE,
 };
 
-- 
2.34.1


