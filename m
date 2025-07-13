Return-Path: <linux-kselftest+bounces-37199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670A6B030AF
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Jul 2025 12:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 803FE17DFF0
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Jul 2025 10:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B1B277C80;
	Sun, 13 Jul 2025 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="dutsQ0H6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011014.outbound.protection.outlook.com [52.101.70.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E29A24293C;
	Sun, 13 Jul 2025 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752403971; cv=fail; b=aAa4rlIVSDZflvLtUquKEHxFiLQzWviu5uG0XoOJm2ImFKO1r+eAzVR3osGxI/ErhUSxn+QI5MKg3dy4tfEL9tUW2kkYlJXouUdjL1wAnh0obqZ9b9F3k1YACsQJ4G2RufU1SQmjL/tSCym58tqtcbDeCThbvDOjFID31bYLdRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752403971; c=relaxed/simple;
	bh=/qIziZsi4SpuD/HfIQDbbpQafDVjGbLwiIjBnePcTMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KI19KAG9atfygxvwxqxkS6peHuQt14YNGucBLqXvHMKfN29OdVJ8gIfXe/W7hb9MC1SzbO5JLBnG7AAABORpoFNjUJxNW0W2hxKVQF+fKSyYOzk86QYMnQgEDlVksrD1+rr31dW5BXIYyo89OhoodGw703xXUB/rTfKTe8PUBAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=dutsQ0H6; arc=fail smtp.client-ip=52.101.70.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENCE8HOiziBFeJtM411VuZxWAA0jI5lyegoSkKSmi2gzgoGshMKLK9mJ1OLG3h4ppPiwmajqRDmbgV5SPgN9udodGhh6ONSNjXcsh7rhZlK/ELXk8OBb6CVreNEz73g4dexulFvgELDDdyKOqRWB59MUA9Pava1H08Tm8KMG06uCswrCkowJujz9G2Wx4UldHIxACY/PTUTsB4rIaJe8f07Za29V9RIrURc6oTn7g7nzBFp4PrypXfseE8gUOa693iqWWOMjbYxQocmUj0Wb33PkVY+Fmm0OS39e7+weTWM1UeuRPAFy7B2RCPiWrUMoyWq7e3oS4hXaOVxkGsPNdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6/k/cv4LAmD4OgNDkeGBZI3VRbO95huvapAeoDGVec=;
 b=DlxH9Xt0J6N4EFPnS8zdzrWkMcysdTKyCvw4QLn/iSSeTrHAAOq1Ve87hiZrQmUjcTAjYmQRcpxB9qwJgta4kDazUftLOYXw0b5F5rldXEVCPInBoRGa0HFYLlurpxUE0w77GtKxNF/g5Vg+TapkFtZPjydOXaLWXIJCamTV3oSFnooOvxgF8vlA8Z76MEXS/8sBKYqXSKFBjDFGDiPtyqIHQuNmO67rK2pRN8UfnVTNsm/HvFYggBP3DDjm3aK4pOUTefOrx4nit4hjeF2suRIc6/90vsSHpg28uNN+jaXdMQT7EactNS68AK7kbYGOsxiCHiHGXNXdqOzasQgqNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.101) smtp.rcpttodomain=apple.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6/k/cv4LAmD4OgNDkeGBZI3VRbO95huvapAeoDGVec=;
 b=dutsQ0H64iNk9sKt0Z/FLKOHvEay/5ufHFO2h2+OOoEfxKimwVRCPKKLzBLC3pMlzxZcAKQMxZrboGvDtTXaURPvN4phLaer5kJaOquzwHlIl6duf8pJmj6qfS+EDJNuzHK9+ieVK20Q7JWCGb3QCAsyzSbavcLdfH35vATioLk3VdS187ws5UGVkKL+6KuNvvFtBb2tuOngV3Le1FOgfT4cuDbuvwPx52H9nFvtxW/JVM9wO6xJ6ZresNrd7LqOIvtcA5gkMt+yR6gPCW8BOzM/poH3nlYCZQ+mt8wEpUI2Ma6YZ3qKY4VSkQvgMokFntM5FFKp/vPHXU88tZxXPA==
Received: from AM4PR0302CA0017.eurprd03.prod.outlook.com (2603:10a6:205:2::30)
 by OSKPR07MB10565.eurprd07.prod.outlook.com (2603:10a6:e10:9e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Sun, 13 Jul
 2025 10:52:41 +0000
Received: from AMS0EPF0000019A.eurprd05.prod.outlook.com
 (2603:10a6:205:2:cafe::2b) by AM4PR0302CA0017.outlook.office365.com
 (2603:10a6:205:2::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.30 via Frontend Transport; Sun,
 13 Jul 2025 10:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.101) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF0000019A.mail.protection.outlook.com (10.167.16.246) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22
 via Frontend Transport; Sun, 13 Jul 2025 10:52:40 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 2F2521C0010;
	Sun, 13 Jul 2025 13:52:39 +0300 (EEST)
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
Subject: [PATCH v23 net-next 1/6] sched: Struct definition and parsing of dualpi2 qdisc
Date: Sun, 13 Jul 2025 12:52:29 +0200
Message-Id: <20250713105234.11618-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250713105234.11618-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250713105234.11618-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019A:EE_|OSKPR07MB10565:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6a52a4a0-8cce-4135-d600-08ddc1fb6391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DCk0m5YCBXQfPCy4ex4lVSR0JC2xpTJLjeBmZO3nH3JXCk92xq5rCz+Edwkh?=
 =?us-ascii?Q?/r8WWb11ajjaFs/hLwjWMNS86Lah1qmPm6RpSsLdPZX+oJGNjh0d8/1vwYDF?=
 =?us-ascii?Q?F7OJM+XFbTCw4dGGbsMZiaVJllYFCJ2saSmjW6xvYE1T++R1AehQKheaylze?=
 =?us-ascii?Q?NZc6f0B2Rqeh+LHSLyKFDHGuJ6XAI8stu69ghCrH4Q62E1EU5XgXFrqkybDc?=
 =?us-ascii?Q?POAjngOpE0pjgkISAMjT+p6r1P48mAVMfnpAgSz0/jmsXSx5WE4t1UQorJop?=
 =?us-ascii?Q?kXSGHMx+GP7fNGegZq67twrj084ksHZFBGido4UrcI86b0IaRYWH4W8ChI1x?=
 =?us-ascii?Q?jxXCCJtacJqeLN8eJpRBtPOEVx47hpnhIXyZHkGJWNJxoxLxbxthDGUwBqcQ?=
 =?us-ascii?Q?EvYUhNS3Yo0v/+XXdKyBklzULpP+KCDKvSbzF9dNw5gH5SI5GeHnE4Qdm2uK?=
 =?us-ascii?Q?BAuBcDnh9ucdD6HyrROPZl3sD7Op3cbWYvSJj0JsyjRoVCLFdY1ugjdwq3lJ?=
 =?us-ascii?Q?3UioZdPcpsyfIDZ+gviLmbetS1qRTlPhPBTvNAgMwMRf8ZRDWb46hzX0tJlh?=
 =?us-ascii?Q?1hSvS5dItcCsJkcfoWnBIUqJzVQaUCQnbkjqNGIwwz4PT5h0lp2hdI2ff9hC?=
 =?us-ascii?Q?oNRRwwkE6p4ESJ9MkYw6D245ccD6wSJA2XYslXv3KKPKFccrg+xVFg+Xbb2h?=
 =?us-ascii?Q?hSyBDQHEt6DhknkMcZhhCcHnXi7RpAbuV1seDfdQ460q3gJk/Dv1VNDokft5?=
 =?us-ascii?Q?A0pVm8Oet1T8xS69vSO/tUPRPLhkXWXdbi7tszCM5GOpINtqkMNPGwbS5AHt?=
 =?us-ascii?Q?9QPIIix57JO7GM/xrz1pgyf9KRLHATsZz4TMkZRMKKOVO865r/JGhOsNdvYy?=
 =?us-ascii?Q?khfR0eNFdlYkde8LhcFA0zxssIO6i+cUsmfuyVmGplwV0agL31AIhPDClcz9?=
 =?us-ascii?Q?RXPPFIJZAAGV6KL+R/O+4tZPZ01+GaDfsgGUFEZQlw+gOrq22L50r6Z/vOhA?=
 =?us-ascii?Q?oXaMgTNeWkdvLCXQ08Fy3/FK7XpqR1pRD9gPcFDluuryapEOOIPC5TymOeFH?=
 =?us-ascii?Q?UYidsJLQP8VT0KZu8ujgN74q4jVfEPqlezjrgxpIeskOxSI/lyBIAgN9SN6e?=
 =?us-ascii?Q?jo+3dB7P6XYUT57ZCMXtW7yGOUkXDoPB+U/R4O+MSqzFF3C7eks4DUvtPiQD?=
 =?us-ascii?Q?0xDVT6u5ZVix+FkVl2+fuxmzgWW7nZBbZxRtIY1m0x6JE6RXnIJPikIk8SD+?=
 =?us-ascii?Q?JX+C55TIOr2SuoC0dufT58Q9mDk8ImGBp65HXTOc/ejL+djSFY7gQoGYYTE2?=
 =?us-ascii?Q?NXx1YBLGW8WCH6/crmh1ZRFV78GUTAOlrkIq9TqQuvgpp57XZ9/lWyQ8hvRG?=
 =?us-ascii?Q?1xaTfcTMf6WgPMts3GREPHjJPW9IxAGRQIo66qLFJZovZqJeFkb/D/9mMzBW?=
 =?us-ascii?Q?G7Vlbtzbt1SzEihfaSxnMXL51Z/55nuadfJXnqLdNlXPHOMn3p+0V2/FLmTE?=
 =?us-ascii?Q?Q6HHcu39i/kakCz6abJCWzsz538Jj79GTm+oDKqd+WMKngZjz5PMUcSPqg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2025 10:52:40.7255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a52a4a0-8cce-4135-d600-08ddc1fb6391
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR07MB10565

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
 net/sched/sch_dualpi2.c        | 587 +++++++++++++++++++++++++++++++++
 2 files changed, 640 insertions(+)
 create mode 100644 net/sched/sch_dualpi2.c

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index 3e41349f3fa2..1eeee2f8c8dc 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -1211,4 +1211,57 @@ enum {
 
 #define TCA_ETS_MAX (__TCA_ETS_MAX - 1)
 
+/* DUALPI2 */
+enum tc_dualpi2_drop_overload {
+	TCA_DUALPI2_DROP_OVERLOAD_OVERFLOW = 0,
+	TCA_DUALPI2_DROP_OVERLOAD_DROP = 1,
+	__TCA_DUALPI2_DROP_OVERLOAD_MAX,
+};
+#define TCA_DUALPI2_DROP_OVERLOAD_MAX (__TCA_DUALPI2_DROP_OVERLOAD_MAX - 1)
+
+enum tc_dualpi2_drop_early {
+	TCA_DUALPI2_DROP_EARLY_DROP_DEQUEUE = 0,
+	TCA_DUALPI2_DROP_EARLY_DROP_ENQUEUE = 1,
+	__TCA_DUALPI2_DROP_EARLY_MAX,
+};
+#define TCA_DUALPI2_DROP_EARLY_MAX (__TCA_DUALPI2_DROP_EARLY_MAX - 1)
+
+enum tc_dualpi2_ecn_mask {
+	TCA_DUALPI2_ECN_MASK_L4S_ECT = 1,
+	TCA_DUALPI2_ECN_MASK_CLA_ECT = 2,
+	TCA_DUALPI2_ECN_MASK_ANY_ECT = 3,
+	__TCA_DUALPI2_ECN_MASK_MAX,
+};
+#define TCA_DUALPI2_ECN_MASK_MAX (__TCA_DUALPI2_ECN_MASK_MAX - 1)
+
+enum tc_dualpi2_split_gso {
+	TCA_DUALPI2_SPLIT_GSO_NO_SPLIT_GSO = 0,
+	TCA_DUALPI2_SPLIT_GSO_SPLIT_GSO = 1,
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
index 000000000000..29d698c1b4d0
--- /dev/null
+++ b/net/sched/sch_dualpi2.c
@@ -0,0 +1,587 @@
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
+		NLA_POLICY_RANGE(NLA_U8, TCA_DUALPI2_ECN_MASK_L4S_ECT,
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
+	if (tb[TCA_DUALPI2_STEP_THRESH_PKTS]) {
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
+	q->ecn_mask = TCA_DUALPI2_ECN_MASK_L4S_ECT;	/* INET_ECN_ECT_1 */
+	q->min_qlen_step = 0;		/* Always apply step mark in L-queue */
+	q->coupling_factor = 2;		/* window fairness for equal RTTs */
+	q->drop_overload = TCA_DUALPI2_DROP_OVERLOAD_DROP; /* Drop overload */
+	q->drop_early = TCA_DUALPI2_DROP_EARLY_DROP_DEQUEUE; /* Drop dequeue */
+	q->split_gso = TCA_DUALPI2_SPLIT_GSO_SPLIT_GSO;	/* Split GSO */
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


