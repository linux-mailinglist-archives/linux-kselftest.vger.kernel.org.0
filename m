Return-Path: <linux-kselftest+bounces-37519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94386B0972F
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 01:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D7421C23346
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 23:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4AB242927;
	Thu, 17 Jul 2025 23:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="IizPLFB2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013001.outbound.protection.outlook.com [40.107.159.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7704D241676;
	Thu, 17 Jul 2025 23:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794683; cv=fail; b=UIK7nlBtzoxykIURM/64IeEw2QBG++UtCNnGnZQoFEBhqnfE2TqcC71K/x7BNduuRpzO1/gB7XxzwUp38Zyie6lje0nf7jxezPGAiT5QAgx4c4f3kRMz8afE8ImOjE37OrhgmbKiO5Uq9SLRoRafyWk6w4YsHeMP8197yefCGYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794683; c=relaxed/simple;
	bh=fUVjuYoLNj9yXHZgdcoYi+NbV7IMj9ks1mGmSDPdQEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ejPfzj7mWpBjuGDJhibpQ8D+UrvbEd4Y3xGwto0Wy8YyED4kRoKw3LOe/TKf1ymhZlVaD8Cj2P8eSetE5P8PNx38h5bDmyUplXaBJD9U+dmycrs8QIBDi99B1gpEeIh1Bi+mLnK3Y4yuLOO3UhfzQlYbp3rRiPorTRONHZwuE0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=IizPLFB2; arc=fail smtp.client-ip=40.107.159.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1bZ/IdH8noBeb/CeO/NKT2KIBE7hnPa+ij6A4ZSuNswYo4cPZwjMnuHACgdmET61xrasUjVbXw+2ju7pVYeyhjYbAQopCFsiJJtiqBl85x5jk1mLrT1crj0ac4BXCaGu0oRMnGpjhKTOtmkAi50gj+u7B2qfTsrZkqIk8OAr1YPxUvSf+5LAXb6NHZZGo460IZH9X9WyURaF6fr5Z1ms90R9o6yx5f/fZ8cDNHEmqLf0C00+mKX6ivIR+w/2o081rV4cS3gEY+Pux09UgnYHUyJCVN/a7uzIfviuxEU+6s4bPI+/tp+bVdQzd/OSZA4OifEeZAPgkMl0S9pLPu5EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPris9QmZmeojaUMF70HYi20sU1Rb6bfsFBg3Rwb6sg=;
 b=AgEeYNzYiMQp5F6A2i65kRLzMQLcwy6aHTDEVLmdV50iGfogpYSiH4AgDh/+1KcRGw4dEkyiHr8pLzIMntjcS5rYue8Z5z3y4tLjTnYACtQAufbdX33CBgl3uFGVkILStFFS4vGmTTWkBu7K5AYT8AvyIjbIRBXrW5WB92CozpoyeWjXDdmuq8DSGjrFjiVoxXYnL8BXKmsM9//8DsU/YVU4NCmOJ4RG66wrrdPNCFV5DLd4kMq3Vcqd8SG+HxyNL7oA+XCYzvg0EWgWu8+JE1dLCC89b5Stvgu5HUyI13S6k0qomUUcl+zswJVsP7boNbpgf4bveg07NcutY3yUnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPris9QmZmeojaUMF70HYi20sU1Rb6bfsFBg3Rwb6sg=;
 b=IizPLFB25R+CG+AlWw3/fjeHdLgXg3RabyyUJCNBBOB1HJ0QAQDL87APqiQTEDRVrFO8J4B9OHl+ETuyR28/l+zcNygF7QQx++3ElTXiCL2oI8MWBdZm3buL7Di0pft6f/oqVymGvXk1DhJp6enO4p4h1fxxPl7CDg9sRiFhUZxPTSsmhT8FO4CPMpL9pc8mx/1NJIWdIo4UkumKVjKl52oI1lThf9MOhyIKqyZHEV+jIFRWjO3ga03RzWMsJdUdS8bVcDlYYIV+frDwmAiLx4D3mWCftvAlc5NMH0I/oHnM+hFcoi+vOVYW0EkwtKVcqiKaYpmPvJu+t7YF/OYXhw==
Received: from DUZPR01CA0130.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::25) by FRWPR07MB10621.eurprd07.prod.outlook.com
 (2603:10a6:d10:183::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.40; Thu, 17 Jul
 2025 23:24:32 +0000
Received: from DU6PEPF0000A7E1.eurprd02.prod.outlook.com
 (2603:10a6:10:4bc:cafe::ae) by DUZPR01CA0130.outlook.office365.com
 (2603:10a6:10:4bc::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Thu,
 17 Jul 2025 23:24:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DU6PEPF0000A7E1.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21 via
 Frontend Transport; Thu, 17 Jul 2025 23:24:32 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 27D04680042;
	Fri, 18 Jul 2025 02:24:31 +0300 (EEST)
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
Subject: [PATCH v24 net-next 1/6] sched: Struct definition and parsing of dualpi2 qdisc
Date: Fri, 18 Jul 2025 01:24:22 +0200
Message-Id: <20250717232427.69216-2-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E1:EE_|FRWPR07MB10621:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3d50041f-3273-4c42-283a-08ddc589160e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BYfswnZAmgz1mXXQOSiHxQLRWgMQDi0BNX/1ivvkokGmCZatagBISiyQW/hC?=
 =?us-ascii?Q?1Ahc0UD2V60QYSA3d4PbL0Lo6LNkzrEkCTaRZGFZsudA+gYquhBA/QwaPj4C?=
 =?us-ascii?Q?7TzWaf+N2gOrIny+kWTsq7WWevUAv71W/PIajnMJ5pY+XAEX7GuMGt99hewe?=
 =?us-ascii?Q?tUAwMnxn7gCz+Jq53/MA9T7LMEIhTFbio8kh3UelM0BNpZVI8Fq3TFpFEnQ+?=
 =?us-ascii?Q?RwWigKwzgoY0VxkF4lAqNlW9gM1+gRbs2xgQ/sitRWS/USfesIv9k0hk0ys9?=
 =?us-ascii?Q?gDS+S8Nl+82JoRXs6Yar4KhtIb+dMPYaEXmrE64DbTa0DICjSw5jV+WmKRLn?=
 =?us-ascii?Q?dQaKnHKFm6vDx9rgzyOq0/NBFaKmizwfmDyCwz1Tfigh8C2wxHmypmz0EtlK?=
 =?us-ascii?Q?1fWST4RHtIR7KthFan6Or+LDJ5zxxD6SBwABCcN31mzy3wfvcQ5Qgn4VOKK3?=
 =?us-ascii?Q?SRaQuBEcr/F8E+kMhxagXSC8QYeRpIyAHawqYmGazVORnauYgHEkA/fhXWB8?=
 =?us-ascii?Q?Rd/cA+m6rHB5v1+QNZnj3sko2LNGUxNaNoqUr183Q/+xuxkyeGJacZYLsc2Z?=
 =?us-ascii?Q?wr7v+w+J4vYihmOAycX+NqZMYcqYGdwrcRKcHK7XrWA2x7vI9ncPi4sRItwy?=
 =?us-ascii?Q?ZyudKX9WSNV84/XzbRfFNc9RQQL+bbAoUMhzhh+5mgIWGg181oq2a7+tFKID?=
 =?us-ascii?Q?IM2T+SMUpsyxLcdr2KznmITIY28cvWEWK6rPeALxEv5Nl5wdsZlkL4xS5n5U?=
 =?us-ascii?Q?Q1QO9ANP18P7Cpiehxv30Ix0JLNcYKhkaeQ56ZTj0n4QmjGLXU7q3KlPGCuV?=
 =?us-ascii?Q?8fVuynebT5C/8trbIHM6ud585yzfTjabygRbUWgg4f5fz1qz03axpLbKsg1L?=
 =?us-ascii?Q?r0gqqHKQMYwZAF1cmPaYKLJKLycOUmUzrrm/Hpm9JGsMFJB2FGssAPANT/cg?=
 =?us-ascii?Q?jAeQb8DwASV9sB4dSnOYZ24cTlPxPgFuwNyUYzKdj4vS1cLz+3dmsT4n1HIU?=
 =?us-ascii?Q?T8Huux5OqIUfqWWerh0Ai+jDjEgEu8aQQ4sNK9nCMsNAqEcz6u8RiCmb3J4P?=
 =?us-ascii?Q?fLM/nrY9kQ6LDptTLdRh8Vfw9g/S7EptZoV3MIDq3/xymRJEPiKYvpZ+w+q2?=
 =?us-ascii?Q?m8n4JD6ZXbScdl34FnrslLFHvbh3RfESzfNqoSYNfauDZygtTZ2QsJS48v/x?=
 =?us-ascii?Q?bSOxrlJLAVE4URcI+MGkUY6T15472c6zO5RKR7JwAkmvRLVqs8WRb+IzFkmE?=
 =?us-ascii?Q?l+AwL1ABVZidl/JX6FodEh4TsO4M26cqB9lzcTq2UysoUhIg5igz5vyk6qpB?=
 =?us-ascii?Q?OgIa1mkFgi53MJSX9sshAnRQ09x+ucx97odoToFgG9Q/IqlE5ld8sAy1hqtM?=
 =?us-ascii?Q?+3Mn/fM3Uikt7ZTfIc5C4+AvyOiPt26iOJxOd9B0giZpMzRoYP3DOKe3YmLo?=
 =?us-ascii?Q?A/XpPlZihHF4ahrdBlKo7Mkm4GPCqSAmGeEekF1A8rJv4vuVw7S0qVDwcaRp?=
 =?us-ascii?Q?Z56L5lKpKa6uY3a1xR6xBNaKieP3m9Al7YcXACX6CV9ro1IDmy7uo9f8Ww?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 23:24:32.6858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d50041f-3273-4c42-283a-08ddc589160e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR07MB10621

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

DualPI2 is the reference implementation of IETF RFC9332 DualQ Coupled
AQM (https://datatracker.ietf.org/doc/html/rfc9332) providing two
queues called low latency (L-queue) and classic (C-queue). By default,
it enqueues non-ECN and ECT(0) packets into the C-queue and ECT(1) and
CE packets into the low latency queue (L-queue), as per IETF RFC9332 spec.

This patch defines the dualpi2 Qdisc structure and parsing, and the
following two patches include dumping and enqueue/dequeue for the DualPI2.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v24:
- Replace TCA_DUALPI2 prefix with TC_DUALPI2 for enums
- Report error if both packet and time step thresholds are provided

v22 & v23:
- Fix issue when user would like to change DualPI2 but provides an empty
TCA_OPTIONS with no nested attributes.

v21:
- Replace STEP_THRESH and STEP_PACKETS w/ STEP_THRESH_PKTS and STEP_THRESH_US
- Move READ_ONCE and WRITE_ONCE to later DualPI2 patches
- Replace NLA_POLICY_FULL_RANGE with NLA_POLICY_RANGE
- Set extra error message for dualpi2_change
- Drop redundant else for better readability

v19:
- Fix one typo in the comment

v18:
- Add the num of enum used by DualPI2
- Replace from_timer() with timer_container_of()

v17:
- Replace 0xffffffff with U32_MAX
- Use new helper function qdisc_dequeue_internal()
- Add s64 casting when calculating the delta of the PI controller
- Add comments for readability

v16:
- Add qdisc_lock() to dualpi2_timer()
- Introduce convert_ns_to_usec() to convert u64 usec to u32 ns w/o overflow
---
 include/uapi/linux/pkt_sched.h |  53 +++
 net/sched/sch_dualpi2.c        | 590 +++++++++++++++++++++++++++++++++
 2 files changed, 643 insertions(+)
 create mode 100644 net/sched/sch_dualpi2.c

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index 3e41349f3fa2..75d685ea8368 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -1211,4 +1211,57 @@ enum {
 
 #define TCA_ETS_MAX (__TCA_ETS_MAX - 1)
 
+/* DUALPI2 */
+enum tc_dualpi2_drop_overload {
+	TC_DUALPI2_DROP_OVERLOAD_OVERFLOW = 0,
+	TC_DUALPI2_DROP_OVERLOAD_DROP = 1,
+	__TCA_DUALPI2_DROP_OVERLOAD_MAX,
+};
+#define TCA_DUALPI2_DROP_OVERLOAD_MAX (__TCA_DUALPI2_DROP_OVERLOAD_MAX - 1)
+
+enum tc_dualpi2_drop_early {
+	TC_DUALPI2_DROP_EARLY_DROP_DEQUEUE = 0,
+	TC_DUALPI2_DROP_EARLY_DROP_ENQUEUE = 1,
+	__TCA_DUALPI2_DROP_EARLY_MAX,
+};
+#define TCA_DUALPI2_DROP_EARLY_MAX (__TCA_DUALPI2_DROP_EARLY_MAX - 1)
+
+enum tc_dualpi2_ecn_mask {
+	TC_DUALPI2_ECN_MASK_L4S_ECT = 1,
+	TC_DUALPI2_ECN_MASK_CLA_ECT = 2,
+	TC_DUALPI2_ECN_MASK_ANY_ECT = 3,
+	__TCA_DUALPI2_ECN_MASK_MAX,
+};
+#define TCA_DUALPI2_ECN_MASK_MAX (__TCA_DUALPI2_ECN_MASK_MAX - 1)
+
+enum tc_dualpi2_split_gso {
+	TC_DUALPI2_SPLIT_GSO_NO_SPLIT_GSO = 0,
+	TC_DUALPI2_SPLIT_GSO_SPLIT_GSO = 1,
+	__TCA_DUALPI2_SPLIT_GSO_MAX,
+};
+#define TCA_DUALPI2_SPLIT_GSO_MAX (__TCA_DUALPI2_SPLIT_GSO_MAX - 1)
+
+enum {
+	TCA_DUALPI2_UNSPEC,
+	TCA_DUALPI2_LIMIT,		/* Packets */
+	TCA_DUALPI2_MEMORY_LIMIT,	/* Bytes */
+	TCA_DUALPI2_TARGET,		/* us */
+	TCA_DUALPI2_TUPDATE,		/* us */
+	TCA_DUALPI2_ALPHA,		/* Hz scaled up by 256 */
+	TCA_DUALPI2_BETA,		/* Hz scaled up by 256 */
+	TCA_DUALPI2_STEP_THRESH_PKTS,	/* Step threshold in packets */
+	TCA_DUALPI2_STEP_THRESH_US,	/* Step threshold in microseconds */
+	TCA_DUALPI2_MIN_QLEN_STEP,	/* Minimum qlen to apply STEP_THRESH */
+	TCA_DUALPI2_COUPLING,		/* Coupling factor between queues */
+	TCA_DUALPI2_DROP_OVERLOAD,	/* Whether to drop on overload */
+	TCA_DUALPI2_DROP_EARLY,		/* Whether to drop on enqueue */
+	TCA_DUALPI2_C_PROTECTION,	/* Percentage */
+	TCA_DUALPI2_ECN_MASK,		/* L4S queue classification mask */
+	TCA_DUALPI2_SPLIT_GSO,		/* Split GSO packets at enqueue */
+	TCA_DUALPI2_PAD,
+	__TCA_DUALPI2_MAX
+};
+
+#define TCA_DUALPI2_MAX   (__TCA_DUALPI2_MAX - 1)
+
 #endif
diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
new file mode 100644
index 000000000000..03bd0a21baf7
--- /dev/null
+++ b/net/sched/sch_dualpi2.c
@@ -0,0 +1,590 @@
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+/* Copyright (C) 2024 Nokia
+ *
+ * Author: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
+ * Author: Olga Albisser <olga@albisser.org>
+ * Author: Henrik Steen <henrist@henrist.net>
+ * Author: Olivier Tilmans <olivier.tilmans@nokia.com>
+ * Author: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
+ *
+ * DualPI Improved with a Square (dualpi2):
+ * - Supports congestion controls that comply with the Prague requirements
+ *   in RFC9331 (e.g. TCP-Prague)
+ * - Supports coupled dual-queue with PI2 as defined in RFC9332
+ * - Supports ECN L4S-identifier (IP.ECN==0b*1)
+ *
+ * note: Although DCTCP and BBRv3 can use shallow-threshold ECN marks,
+ *   they do not meet the 'Prague L4S Requirements' listed in RFC 9331
+ *   Section 4, so they can only be used with DualPI2 in a datacenter
+ *   context.
+ *
+ * References:
+ * - RFC9332: https://datatracker.ietf.org/doc/html/rfc9332
+ * - De Schepper, Koen, et al. "PI 2: A linearized AQM for both classic and
+ *   scalable TCP."  in proc. ACM CoNEXT'16, 2016.
+ */
+
+#include <linux/errno.h>
+#include <linux/hrtimer.h>
+#include <linux/if_vlan.h>
+#include <linux/kernel.h>
+#include <linux/limits.h>
+#include <linux/module.h>
+#include <linux/skbuff.h>
+#include <linux/types.h>
+
+#include <net/gso.h>
+#include <net/inet_ecn.h>
+#include <net/pkt_cls.h>
+#include <net/pkt_sched.h>
+
+/* 32b enable to support flows with windows up to ~8.6 * 1e9 packets
+ * i.e., twice the maximal snd_cwnd.
+ * MAX_PROB must be consistent with the RNG in dualpi2_roll().
+ */
+#define MAX_PROB U32_MAX
+
+/* alpha/beta values exchanged over netlink are in units of 256ns */
+#define ALPHA_BETA_SHIFT 8
+
+/* Scaled values of alpha/beta must fit in 32b to avoid overflow in later
+ * computations. Consequently (see and dualpi2_scale_alpha_beta()), their
+ * netlink-provided values can use at most 31b, i.e. be at most (2^23)-1
+ * (~4MHz) as those are given in 1/256th. This enable to tune alpha/beta to
+ * control flows whose maximal RTTs can be in usec up to few secs.
+ */
+#define ALPHA_BETA_MAX ((1U << 31) - 1)
+
+/* Internal alpha/beta are in units of 64ns.
+ * This enables to use all alpha/beta values in the allowed range without loss
+ * of precision due to rounding when scaling them internally, e.g.,
+ * scale_alpha_beta(1) will not round down to 0.
+ */
+#define ALPHA_BETA_GRANULARITY 6
+
+#define ALPHA_BETA_SCALING (ALPHA_BETA_SHIFT - ALPHA_BETA_GRANULARITY)
+
+/* We express the weights (wc, wl) in %, i.e., wc + wl = 100 */
+#define MAX_WC 100
+
+struct dualpi2_sched_data {
+	struct Qdisc *l_queue;	/* The L4S Low latency queue (L-queue) */
+	struct Qdisc *sch;	/* The Classic queue (C-queue) */
+
+	/* Registered tc filters */
+	struct tcf_proto __rcu *tcf_filters;
+	struct tcf_block *tcf_block;
+
+	/* PI2 parameters */
+	u64	pi2_target;	/* Target delay in nanoseconds */
+	u32	pi2_tupdate;	/* Timer frequency in nanoseconds */
+	u32	pi2_prob;	/* Base PI probability */
+	u32	pi2_alpha;	/* Gain factor for the integral rate response */
+	u32	pi2_beta;	/* Gain factor for the proportional response */
+	struct hrtimer pi2_timer; /* prob update timer */
+
+	/* Step AQM (L-queue only) parameters */
+	u32	step_thresh;	/* Step threshold */
+	bool	step_in_packets; /* Step thresh in packets (1) or time (0) */
+
+	/* C-queue starvation protection */
+	s32	c_protection_credit; /* Credit (sign indicates which queue) */
+	s32	c_protection_init; /* Reset value of the credit */
+	u8	c_protection_wc; /* C-queue weight (between 0 and MAX_WC) */
+	u8	c_protection_wl; /* L-queue weight (MAX_WC - wc) */
+
+	/* General dualQ parameters */
+	u32	memory_limit;	/* Memory limit of both queues */
+	u8	coupling_factor;/* Coupling factor (k) between both queues */
+	u8	ecn_mask;	/* Mask to match packets into L-queue */
+	u32	min_qlen_step;	/* Minimum queue length to apply step thresh */
+	bool	drop_early;	/* Drop at enqueue (1) instead of dequeue  (0) */
+	bool	drop_overload;	/* Drop (1) on overload, or overflow (0) */
+	bool	split_gso;	/* Split aggregated skb (1) or leave as is (0) */
+
+	/* Statistics */
+	u64	c_head_ts;	/* Enqueue timestamp of the C-queue head */
+	u64	l_head_ts;	/* Enqueue timestamp of the L-queue head */
+	u64	last_qdelay;	/* Q delay val at the last probability update */
+	u32	packets_in_c;	/* Enqueue packet counter of the C-queue */
+	u32	packets_in_l;	/* Enqueue packet counter of the L-queue */
+	u32	maxq;		/* Maximum queue size of the C-queue */
+	u32	ecn_mark;	/* ECN mark pkt counter due to PI probability */
+	u32	step_marks;	/* ECN mark pkt counter due to step AQM */
+	u32	memory_used;	/* Memory used of both queues */
+	u32	max_memory_used;/* Maximum used memory */
+};
+
+static u32 dualpi2_scale_alpha_beta(u32 param)
+{
+	u64 tmp = ((u64)param * MAX_PROB >> ALPHA_BETA_SCALING);
+
+	do_div(tmp, NSEC_PER_SEC);
+	return tmp;
+}
+
+static ktime_t next_pi2_timeout(struct dualpi2_sched_data *q)
+{
+	return ktime_add_ns(ktime_get_ns(), q->pi2_tupdate);
+}
+
+static void dualpi2_reset_c_protection(struct dualpi2_sched_data *q)
+{
+	q->c_protection_credit = q->c_protection_init;
+}
+
+/* This computes the initial credit value and WRR weight for the L queue (wl)
+ * from the weight of the C queue (wc).
+ * If wl > wc, the scheduler will start with the L queue when reset.
+ */
+static void dualpi2_calculate_c_protection(struct Qdisc *sch,
+					   struct dualpi2_sched_data *q, u32 wc)
+{
+	q->c_protection_wc = wc;
+	q->c_protection_wl = MAX_WC - wc;
+	q->c_protection_init = (s32)psched_mtu(qdisc_dev(sch)) *
+		((int)q->c_protection_wc - (int)q->c_protection_wl);
+	dualpi2_reset_c_protection(q);
+}
+
+static s64 __scale_delta(u64 diff)
+{
+	do_div(diff, 1 << ALPHA_BETA_GRANULARITY);
+	return diff;
+}
+
+static void get_queue_delays(struct dualpi2_sched_data *q, u64 *qdelay_c,
+			     u64 *qdelay_l)
+{
+	u64 now, qc, ql;
+
+	now = ktime_get_ns();
+	qc = q->c_head_ts;
+	ql = q->l_head_ts;
+
+	*qdelay_c = qc ? now - qc : 0;
+	*qdelay_l = ql ? now - ql : 0;
+}
+
+static u32 calculate_probability(struct Qdisc *sch)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+	u32 new_prob;
+	u64 qdelay_c;
+	u64 qdelay_l;
+	u64 qdelay;
+	s64 delta;
+
+	get_queue_delays(q, &qdelay_c, &qdelay_l);
+	qdelay = max(qdelay_l, qdelay_c);
+
+	/* Alpha and beta take at most 32b, i.e, the delay difference would
+	 * overflow for queuing delay differences > ~4.2sec.
+	 */
+	delta = ((s64)qdelay - (s64)q->pi2_target) * q->pi2_alpha;
+	delta += ((s64)qdelay - (s64)q->last_qdelay) * q->pi2_beta;
+	q->last_qdelay = qdelay;
+
+	/* Bound new_prob between 0 and MAX_PROB */
+	if (delta > 0) {
+		new_prob = __scale_delta(delta) + q->pi2_prob;
+		if (new_prob < q->pi2_prob)
+			new_prob = MAX_PROB;
+	} else {
+		new_prob = q->pi2_prob - __scale_delta(~delta + 1);
+		if (new_prob > q->pi2_prob)
+			new_prob = 0;
+	}
+
+	/* If we do not drop on overload, ensure we cap the L4S probability to
+	 * 100% to keep window fairness when overflowing.
+	 */
+	if (!q->drop_overload)
+		return min_t(u32, new_prob, MAX_PROB / q->coupling_factor);
+	return new_prob;
+}
+
+static u32 get_memory_limit(struct Qdisc *sch, u32 limit)
+{
+	/* Apply rule of thumb, i.e., doubling the packet length,
+	 * to further include per packet overhead in memory_limit.
+	 */
+	u64 memlim = mul_u32_u32(limit, 2 * psched_mtu(qdisc_dev(sch)));
+
+	if (upper_32_bits(memlim))
+		return U32_MAX;
+	else
+		return lower_32_bits(memlim);
+}
+
+static u32 convert_us_to_nsec(u32 us)
+{
+	u64 ns = mul_u32_u32(us, NSEC_PER_USEC);
+
+	if (upper_32_bits(ns))
+		return U32_MAX;
+
+	return lower_32_bits(ns);
+}
+
+static enum hrtimer_restart dualpi2_timer(struct hrtimer *timer)
+{
+	struct dualpi2_sched_data *q = timer_container_of(q, timer, pi2_timer);
+	struct Qdisc *sch = q->sch;
+	spinlock_t *root_lock; /* to lock qdisc for probability calculations */
+
+	rcu_read_lock();
+	root_lock = qdisc_lock(qdisc_root_sleeping(sch));
+	spin_lock(root_lock);
+
+	q->pi2_prob = calculate_probability(sch);
+	hrtimer_set_expires(&q->pi2_timer, next_pi2_timeout(q));
+
+	spin_unlock(root_lock);
+	rcu_read_unlock();
+	return HRTIMER_RESTART;
+}
+
+static struct netlink_range_validation dualpi2_alpha_beta_range = {
+	.min = 1,
+	.max = ALPHA_BETA_MAX,
+};
+
+static const struct nla_policy dualpi2_policy[TCA_DUALPI2_MAX + 1] = {
+	[TCA_DUALPI2_LIMIT]		= NLA_POLICY_MIN(NLA_U32, 1),
+	[TCA_DUALPI2_MEMORY_LIMIT]	= NLA_POLICY_MIN(NLA_U32, 1),
+	[TCA_DUALPI2_TARGET]		= { .type = NLA_U32 },
+	[TCA_DUALPI2_TUPDATE]		= NLA_POLICY_MIN(NLA_U32, 1),
+	[TCA_DUALPI2_ALPHA]		=
+		NLA_POLICY_FULL_RANGE(NLA_U32, &dualpi2_alpha_beta_range),
+	[TCA_DUALPI2_BETA]		=
+		NLA_POLICY_FULL_RANGE(NLA_U32, &dualpi2_alpha_beta_range),
+	[TCA_DUALPI2_STEP_THRESH_PKTS]	= { .type = NLA_U32 },
+	[TCA_DUALPI2_STEP_THRESH_US]	= { .type = NLA_U32 },
+	[TCA_DUALPI2_MIN_QLEN_STEP]	= { .type = NLA_U32 },
+	[TCA_DUALPI2_COUPLING]		= NLA_POLICY_MIN(NLA_U8, 1),
+	[TCA_DUALPI2_DROP_OVERLOAD]	=
+		NLA_POLICY_MAX(NLA_U8, TCA_DUALPI2_DROP_OVERLOAD_MAX),
+	[TCA_DUALPI2_DROP_EARLY]	=
+		NLA_POLICY_MAX(NLA_U8, TCA_DUALPI2_DROP_EARLY_MAX),
+	[TCA_DUALPI2_C_PROTECTION]	=
+		NLA_POLICY_RANGE(NLA_U8, 0, MAX_WC),
+	[TCA_DUALPI2_ECN_MASK]		=
+		NLA_POLICY_RANGE(NLA_U8, TC_DUALPI2_ECN_MASK_L4S_ECT,
+				 TCA_DUALPI2_ECN_MASK_MAX),
+	[TCA_DUALPI2_SPLIT_GSO]		=
+		NLA_POLICY_MAX(NLA_U8, TCA_DUALPI2_SPLIT_GSO_MAX),
+};
+
+static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
+			  struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[TCA_DUALPI2_MAX + 1];
+	struct dualpi2_sched_data *q;
+	int old_backlog;
+	int old_qlen;
+	int err;
+
+	if (!opt || !nla_len(opt)) {
+		NL_SET_ERR_MSG_MOD(extack, "Dualpi2 options are required");
+		return -EINVAL;
+	}
+	err = nla_parse_nested(tb, TCA_DUALPI2_MAX, opt, dualpi2_policy,
+			       extack);
+	if (err < 0)
+		return err;
+
+	q = qdisc_priv(sch);
+	sch_tree_lock(sch);
+
+	if (tb[TCA_DUALPI2_LIMIT]) {
+		u32 limit = nla_get_u32(tb[TCA_DUALPI2_LIMIT]);
+
+		sch->limit = limit;
+		q->memory_limit = get_memory_limit(sch, limit);
+	}
+
+	if (tb[TCA_DUALPI2_MEMORY_LIMIT])
+		q->memory_limit = nla_get_u32(tb[TCA_DUALPI2_MEMORY_LIMIT]);
+
+	if (tb[TCA_DUALPI2_TARGET]) {
+		u64 target = nla_get_u32(tb[TCA_DUALPI2_TARGET]);
+
+		q->pi2_target = target * NSEC_PER_USEC;
+	}
+
+	if (tb[TCA_DUALPI2_TUPDATE]) {
+		u64 tupdate = nla_get_u32(tb[TCA_DUALPI2_TUPDATE]);
+
+		q->pi2_tupdate = convert_us_to_nsec(tupdate);
+	}
+
+	if (tb[TCA_DUALPI2_ALPHA]) {
+		u32 alpha = nla_get_u32(tb[TCA_DUALPI2_ALPHA]);
+
+		q->pi2_alpha = dualpi2_scale_alpha_beta(alpha);
+	}
+
+	if (tb[TCA_DUALPI2_BETA]) {
+		u32 beta = nla_get_u32(tb[TCA_DUALPI2_BETA]);
+
+		q->pi2_beta = dualpi2_scale_alpha_beta(beta);
+	}
+
+	if (tb[TCA_DUALPI2_STEP_THRESH_PKTS] && tb[TCA_DUALPI2_STEP_THRESH_US]) {
+		NL_SET_ERR_MSG_MOD(extack, "multiple step thresh attributes");
+		return -EINVAL;
+	} else if (tb[TCA_DUALPI2_STEP_THRESH_PKTS]) {
+		u32 step_th = nla_get_u32(tb[TCA_DUALPI2_STEP_THRESH_PKTS]);
+
+		q->step_in_packets = true;
+		q->step_thresh = step_th;
+	} else if (tb[TCA_DUALPI2_STEP_THRESH_US]) {
+		u32 step_th = nla_get_u32(tb[TCA_DUALPI2_STEP_THRESH_US]);
+
+		q->step_in_packets = false;
+		q->step_thresh = convert_us_to_nsec(step_th);
+	}
+
+	if (tb[TCA_DUALPI2_MIN_QLEN_STEP])
+		q->min_qlen_step = nla_get_u32(tb[TCA_DUALPI2_MIN_QLEN_STEP]);
+
+	if (tb[TCA_DUALPI2_COUPLING]) {
+		u8 coupling = nla_get_u8(tb[TCA_DUALPI2_COUPLING]);
+
+		q->coupling_factor = coupling;
+	}
+
+	if (tb[TCA_DUALPI2_DROP_OVERLOAD]) {
+		u8 drop_overload = nla_get_u8(tb[TCA_DUALPI2_DROP_OVERLOAD]);
+
+		q->drop_overload = (bool)drop_overload;
+	}
+
+	if (tb[TCA_DUALPI2_DROP_EARLY]) {
+		u8 drop_early = nla_get_u8(tb[TCA_DUALPI2_DROP_EARLY]);
+
+		q->drop_early = (bool)drop_early;
+	}
+
+	if (tb[TCA_DUALPI2_C_PROTECTION]) {
+		u8 wc = nla_get_u8(tb[TCA_DUALPI2_C_PROTECTION]);
+
+		dualpi2_calculate_c_protection(sch, q, wc);
+	}
+
+	if (tb[TCA_DUALPI2_ECN_MASK]) {
+		u8 ecn_mask = nla_get_u8(tb[TCA_DUALPI2_ECN_MASK]);
+
+		q->ecn_mask = ecn_mask;
+	}
+
+	if (tb[TCA_DUALPI2_SPLIT_GSO]) {
+		u8 split_gso = nla_get_u8(tb[TCA_DUALPI2_SPLIT_GSO]);
+
+		q->split_gso = (bool)split_gso;
+	}
+
+	old_qlen = qdisc_qlen(sch);
+	old_backlog = sch->qstats.backlog;
+	while (qdisc_qlen(sch) > sch->limit ||
+	       q->memory_used > q->memory_limit) {
+		struct sk_buff *skb = qdisc_dequeue_internal(sch, true);
+
+		q->memory_used -= skb->truesize;
+		qdisc_qstats_backlog_dec(sch, skb);
+		rtnl_qdisc_drop(skb, sch);
+	}
+	qdisc_tree_reduce_backlog(sch, old_qlen - qdisc_qlen(sch),
+				  old_backlog - sch->qstats.backlog);
+
+	sch_tree_unlock(sch);
+	return 0;
+}
+
+/* Default alpha/beta values give a 10dB stability margin with max_rtt=100ms. */
+static void dualpi2_reset_default(struct Qdisc *sch)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+
+	q->sch->limit = 10000;				/* Max 125ms at 1Gbps */
+	q->memory_limit = get_memory_limit(sch, q->sch->limit);
+
+	q->pi2_target = 15 * NSEC_PER_MSEC;
+	q->pi2_tupdate = 16 * NSEC_PER_MSEC;
+	q->pi2_alpha = dualpi2_scale_alpha_beta(41);	/* ~0.16 Hz * 256 */
+	q->pi2_beta = dualpi2_scale_alpha_beta(819);	/* ~3.20 Hz * 256 */
+
+	q->step_thresh = 1 * NSEC_PER_MSEC;
+	q->step_in_packets = false;
+
+	dualpi2_calculate_c_protection(q->sch, q, 10);	/* wc=10%, wl=90% */
+
+	q->ecn_mask = TC_DUALPI2_ECN_MASK_L4S_ECT;	/* INET_ECN_ECT_1 */
+	q->min_qlen_step = 0;		/* Always apply step mark in L-queue */
+	q->coupling_factor = 2;		/* window fairness for equal RTTs */
+	q->drop_overload = TC_DUALPI2_DROP_OVERLOAD_DROP; /* Drop overload */
+	q->drop_early = TC_DUALPI2_DROP_EARLY_DROP_DEQUEUE; /* Drop dequeue */
+	q->split_gso = TC_DUALPI2_SPLIT_GSO_SPLIT_GSO;	/* Split GSO */
+}
+
+static int dualpi2_init(struct Qdisc *sch, struct nlattr *opt,
+			struct netlink_ext_ack *extack)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+	int err;
+
+	q->l_queue = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops,
+				       TC_H_MAKE(sch->handle, 1), extack);
+	if (!q->l_queue)
+		return -ENOMEM;
+
+	err = tcf_block_get(&q->tcf_block, &q->tcf_filters, sch, extack);
+	if (err)
+		return err;
+
+	q->sch = sch;
+	dualpi2_reset_default(sch);
+	hrtimer_setup(&q->pi2_timer, dualpi2_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
+
+	if (opt && nla_len(opt)) {
+		err = dualpi2_change(sch, opt, extack);
+
+		if (err)
+			return err;
+	}
+
+	hrtimer_start(&q->pi2_timer, next_pi2_timeout(q),
+		      HRTIMER_MODE_ABS_PINNED);
+	return 0;
+}
+
+/* Reset both L-queue and C-queue, internal packet counters, PI probability,
+ * C-queue protection credit, and timestamps, while preserving current
+ * configuration of DUALPI2.
+ */
+static void dualpi2_reset(struct Qdisc *sch)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+
+	qdisc_reset_queue(sch);
+	qdisc_reset_queue(q->l_queue);
+	q->c_head_ts = 0;
+	q->l_head_ts = 0;
+	q->pi2_prob = 0;
+	q->packets_in_c = 0;
+	q->packets_in_l = 0;
+	q->maxq = 0;
+	q->ecn_mark = 0;
+	q->step_marks = 0;
+	q->memory_used = 0;
+	q->max_memory_used = 0;
+	dualpi2_reset_c_protection(q);
+}
+
+static void dualpi2_destroy(struct Qdisc *sch)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+
+	q->pi2_tupdate = 0;
+	hrtimer_cancel(&q->pi2_timer);
+	if (q->l_queue)
+		qdisc_put(q->l_queue);
+	tcf_block_put(q->tcf_block);
+}
+
+static struct Qdisc *dualpi2_leaf(struct Qdisc *sch, unsigned long arg)
+{
+	return NULL;
+}
+
+static unsigned long dualpi2_find(struct Qdisc *sch, u32 classid)
+{
+	return 0;
+}
+
+static unsigned long dualpi2_bind(struct Qdisc *sch, unsigned long parent,
+				  u32 classid)
+{
+	return 0;
+}
+
+static void dualpi2_unbind(struct Qdisc *q, unsigned long cl)
+{
+}
+
+static struct tcf_block *dualpi2_tcf_block(struct Qdisc *sch, unsigned long cl,
+					   struct netlink_ext_ack *extack)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+
+	if (cl)
+		return NULL;
+	return q->tcf_block;
+}
+
+static void dualpi2_walk(struct Qdisc *sch, struct qdisc_walker *arg)
+{
+	unsigned int i;
+
+	if (arg->stop)
+		return;
+
+	/* We statically define only 2 queues */
+	for (i = 0; i < 2; i++) {
+		if (arg->count < arg->skip) {
+			arg->count++;
+			continue;
+		}
+		if (arg->fn(sch, i + 1, arg) < 0) {
+			arg->stop = 1;
+			break;
+		}
+		arg->count++;
+	}
+}
+
+/* Minimal class support to handle tc filters */
+static const struct Qdisc_class_ops dualpi2_class_ops = {
+	.leaf		= dualpi2_leaf,
+	.find		= dualpi2_find,
+	.tcf_block	= dualpi2_tcf_block,
+	.bind_tcf	= dualpi2_bind,
+	.unbind_tcf	= dualpi2_unbind,
+	.walk		= dualpi2_walk,
+};
+
+static struct Qdisc_ops dualpi2_qdisc_ops __read_mostly = {
+	.id		= "dualpi2",
+	.cl_ops		= &dualpi2_class_ops,
+	.priv_size	= sizeof(struct dualpi2_sched_data),
+	.peek		= qdisc_peek_dequeued,
+	.init		= dualpi2_init,
+	.destroy	= dualpi2_destroy,
+	.reset		= dualpi2_reset,
+	.change		= dualpi2_change,
+	.owner		= THIS_MODULE,
+};
+
+static int __init dualpi2_module_init(void)
+{
+	return register_qdisc(&dualpi2_qdisc_ops);
+}
+
+static void __exit dualpi2_module_exit(void)
+{
+	unregister_qdisc(&dualpi2_qdisc_ops);
+}
+
+module_init(dualpi2_module_init);
+module_exit(dualpi2_module_exit);
+
+MODULE_DESCRIPTION("Dual Queue with Proportional Integral controller Improved with a Square (dualpi2) scheduler");
+MODULE_AUTHOR("Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>");
+MODULE_AUTHOR("Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>");
+MODULE_AUTHOR("Olga Albisser <olga@albisser.org>");
+MODULE_AUTHOR("Henrik Steen <henrist@henrist.net>");
+MODULE_AUTHOR("Olivier Tilmans <olivier.tilmans@nokia.com>");
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_VERSION("1.0");
-- 
2.34.1


