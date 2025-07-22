Return-Path: <linux-kselftest+bounces-37808-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E40A7B0D66B
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 11:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F00BB544DD8
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 09:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8BE2E03FD;
	Tue, 22 Jul 2025 09:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Gw+PYYtR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012035.outbound.protection.outlook.com [52.101.71.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE0C2DA765;
	Tue, 22 Jul 2025 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178369; cv=fail; b=cwteAU7Td2vA01+O/KB0iGbt/QSdmWo3E5d1arQgWm2LwaamG6/3rKif5Bu9JNjpyBHJA7Jh9fx2awXe4FedmLfWe1dKKlVT1mAjDTKvb4Yp8xIXGURe2zia1iVStW1wGShpRjG0b/QsaQk3ZBqH4zjG61oUlk4ONC5s7lFthv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178369; c=relaxed/simple;
	bh=DjVyqdR1TG8i7qJtN5pN9AnMXQO2iP5yvim9Xb8IbpU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VHz6Y6kl59NhiJWY9Ok17kP3SCDoDbDieqMASl6yysKX4Uy9QBKW3DAs77UVh5ghSjPJjY+I2kE7u7jrTve+JWCUIOtDDY0fMX+jPtR919XjekiahvEVEozu5QJg1rBfsSfdWJIXO/oWpweV76myaQb8E5pM1GvlB/lhSeFWupo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Gw+PYYtR; arc=fail smtp.client-ip=52.101.71.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3UR+FJoev9buzLUZivsYxIro8pH3w91NfmXDcHGtOo2haGnK65WV+VeKS+VpM+RFxEYrs15jJkviJ6HfLcbMLNyqXzdAGDeTFOjXeMXSBS01ySxaDTiTBIcUESg97SOa2QV5mkQMELSAqSlUcu3eXs8yd7CptT8fZm/TzTG2/NhsQGex5I2wCdCpW0JLpyTEJz9mnQWoBxaOo0YKTjhDayEBGCN2EB3FwnUNbxlHcpN53fTOQlVXolDSVH3i6Pp78g88YZeQOYlL3jzkNbLYtuBTFWM7rmZvWqB/oQ3AljV543pXu0k4ltxIpTOxmKUgGHKmN47sk++25N0cWrL8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IvQ+fRxwm6th8Un79a4Wjr6BmRKS7RCKR36zVeePZ4=;
 b=OAxDH6m5hGGWq+KtHpqhkFk9QKL7LimcFQyrAMWCck9DznXnEQxmybDXm8sQfV0h0NyCUoGy/45OibXhO96A0cFOMQDmPaq5hOPdnUnvuYI5rxwWZy2tJ8HyXjh2+bNncNfwhrNUfkNAFmSoL5uGZJ3yxsj6a84sn9Fj9GsRc82oD8JdIUXoupzpsPkY0sjK6akLCgbNdp+dHIMA8hlAFyGun3KbeaGnNRlh1ff00xzmnXcsK8bND0dmns4Ta+piOxu7piMdCwtZTPfFW3KF4XxtYjC+XK2KRou5KG/ZdmB0ak+vzD9lW+NuEsE8YirCm72kBpgSvAblQpNmg42Flg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.100) smtp.rcpttodomain=apple.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IvQ+fRxwm6th8Un79a4Wjr6BmRKS7RCKR36zVeePZ4=;
 b=Gw+PYYtR0E5IQmNvBCgboA2fmWEqipge6qsyxc3m0HNlVgSQgnyD8i9yTXAyzHKh2EH+8D4A9RSt6rOn6HNbhxmlNjlaNJ01MnhxwRgniHffDO7Fx3kYkLzt/vRlDokPzBxXdwLK1fUQP3JE5M+00J2YFSadsC40cnNJLzoj1aYTb17CIvTtIWs8WxSJ7iFe4oKIdRPbrYca+8eX6uOyHlBuGrv4B8jYOPkyE6bj4OlB1uAKYazn4+2d2SZ6YLdE4aTlN+5PfCxB2lBSErPheb5yPNfLUTQHV1q/hewkjhpgtIi8hCYq3vR8qGzreQNFc477NYOZyNEAmzfTXCxHAw==
Received: from DUZPR01CA0157.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::21) by GV4PR07MB10436.eurprd07.prod.outlook.com
 (2603:10a6:150:295::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 09:59:24 +0000
Received: from DB1PEPF000509ED.eurprd03.prod.outlook.com
 (2603:10a6:10:4bd:cafe::8e) by DUZPR01CA0157.outlook.office365.com
 (2603:10a6:10:4bd::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 09:59:49 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.100) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB1PEPF000509ED.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Tue, 22 Jul 2025 09:59:22 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id DD2B0680048;
	Tue, 22 Jul 2025 12:59:20 +0300 (EEST)
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
Subject: [PATCH v26 net-next 2/6] sched: Dump configuration and statistics of dualpi2 qdisc
Date: Tue, 22 Jul 2025 11:59:11 +0200
Message-Id: <20250722095915.24485-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722095915.24485-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250722095915.24485-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509ED:EE_|GV4PR07MB10436:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b6f75d79-20ce-4472-3371-08ddc9066ef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/ZV/45Q8nflK77m/Xn2e6tcx1Q8buO4zww4Ec6g12HPpfXtoPJhj7MXA0zrL?=
 =?us-ascii?Q?3V/KDpzxzkT5Mo9sLw9/B7Dj+Qh3jEblSm0YfxTn/XCGFs3wUHiRnWDEBpDf?=
 =?us-ascii?Q?0Evau8vF3ugnB/RQ0JAtudJkzP1FGLULnbRzMO0Uhsk6XNjtPCEKgTQGscMW?=
 =?us-ascii?Q?2Ot7Yj5r8pgKGG50/+M+b+G1OFNlSFRaJNI6nRNta/Dl3JqW6kHD00k2I2vx?=
 =?us-ascii?Q?2M1ehlZ9o6ny9I4Uytl9EdfPnmXPpI1bvocB5P8Six4woadWvyZOB2iRTaAY?=
 =?us-ascii?Q?buhqXg5LoH9i8y6RV333lpFkjuRc9ewR48EnJz2weKNp2N8365BeLAknhDY4?=
 =?us-ascii?Q?OPhVMNZOyG3/2KzAmJDDeLEbNcm5LEgueuiALq+j1MrpLXUvDDoU5jC0e1TN?=
 =?us-ascii?Q?8ptwqYVEqLuU6tRLbEET7me+BY8fzk2HIPlWPScdK2gXrQAnyIz9Rd4uBCPW?=
 =?us-ascii?Q?inrVeDcctnoNeci1zNPQ3zLmzt+G4wyZ90rDlZIPT9NrenKF2J9Oa+UlK4ZV?=
 =?us-ascii?Q?iZKynUvV+3r6VsO/LMONujpVz7gZXi/r42ZxGeK2oKkmc0VShe0rKuSm4zwn?=
 =?us-ascii?Q?RZGufVP1o5Q93OLkMeMbtf8Elih43h/pxv5CPgrqzqwcsud8c/x/Y7r/bfEU?=
 =?us-ascii?Q?qfdU0BxaejyTKOANoeyDHl+OzpOcc7V3t9mwcykZM/3WSSPdeqtcbkoImlwL?=
 =?us-ascii?Q?56wgnnYgUjCnwfPS6BkokFsXqr1hlGXeFLMFXHopjif/Q+NAMy4z/qOcRFHv?=
 =?us-ascii?Q?vhlJnChMoQ/rcxHFiIiu1WBrd9piTbLPDbqrX2AX/NyYyAk8R29Gb6Xs/jIW?=
 =?us-ascii?Q?z8iVG1HVN7XrixWdTiTZXTouilcq6Q03HMjiGhO3kNQUHpH1VVzLkBxkr5ZB?=
 =?us-ascii?Q?4b/8vbB4AMX09I8781ynyDIMn3UZcIRjJ9AOAnD5qNqVKEYkmrl4IWDZSkK8?=
 =?us-ascii?Q?outMDsxFXcNJhuzjqnY+/GfcsCL6p3mOp/xAXIbTZgW2GcKlUXz4/5ejR8p7?=
 =?us-ascii?Q?YTGabsL9DEsIJjMCHo4hMG9BURhMLki2U3jm80ooEWeawQ6TzPD+9mB/6Giu?=
 =?us-ascii?Q?IL5To4+3BS0eYZ5P5lV/17QrYTVj7UN8KA68rxxPYTyJD4U41QMrREX05YI2?=
 =?us-ascii?Q?JsHGU7M8SBAAEPoaIzGwotB35DY/PnjKLp51GT3WkXLPCTp+029J5XliSKHO?=
 =?us-ascii?Q?0Gq9Iaa2ENS08a4CtyoixkrqGT4QRV4H2x6IL7lhyGOj1XM+rxoJfVps0Ka2?=
 =?us-ascii?Q?omUWBauVhDtvz1JCdAN+vS5zAtXdbaOonWscSOKp6THVFWYitRvvZWW4/0p7?=
 =?us-ascii?Q?6+y45+Mzv76BJkQx8g6MxziuQggcodrTiNLNB9XA7yXNUx3hDoV8VzS77+Rd?=
 =?us-ascii?Q?KANqMlYMZed53ggfdMYJ6YLtruKXn6GTR6f4q5BBaum53d+xPQCGK6khkwpJ?=
 =?us-ascii?Q?QMqoiFbbosQoa3EpMOG1lwiKM17snnt/3Q9v0Qi6RxD8WIArMKFur+C2cfrC?=
 =?us-ascii?Q?6Baxm2HyULw+/dayjOEtDMhBjokItAuc2wNcKceJ/64KeHv2GEYGb2VmPA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 09:59:22.4219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f75d79-20ce-4472-3371-08ddc9066ef0
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509ED.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR07MB10436

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
index c11ec66786d4..0a96d57c40d1 100644
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
@@ -304,68 +321,70 @@ static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
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
@@ -377,13 +396,13 @@ static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
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
@@ -460,6 +479,105 @@ static int dualpi2_init(struct Qdisc *sch, struct nlattr *opt,
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
@@ -564,6 +682,8 @@ static struct Qdisc_ops dualpi2_qdisc_ops __read_mostly = {
 	.destroy	= dualpi2_destroy,
 	.reset		= dualpi2_reset,
 	.change		= dualpi2_change,
+	.dump		= dualpi2_dump,
+	.dump_stats	= dualpi2_dump_stats,
 	.owner		= THIS_MODULE,
 };
 
-- 
2.34.1


