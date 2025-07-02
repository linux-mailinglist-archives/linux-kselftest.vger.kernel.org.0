Return-Path: <linux-kselftest+bounces-36249-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A64AF0930
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 05:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAD45424700
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 03:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537831DF742;
	Wed,  2 Jul 2025 03:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="dw0C+ros"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011041.outbound.protection.outlook.com [52.101.65.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CA51D54FE;
	Wed,  2 Jul 2025 03:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751426910; cv=fail; b=iir6M0LIqCINjmCSnhxgSZ63RfyzzbZoBnaxFvaleh+fRtrK6klDSgfrzyZkhp+bbQWEZzKj1VuIVKCOKuJyKF5KcAVT5V8D1ePl4I1+Br48ZmaBoIRMfpazg3Ivh+ddAwObMXzrUzUMY071oM27dqnfbMrUg5VwTjL17baeodc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751426910; c=relaxed/simple;
	bh=kTUu2pXLbS7yWaPFAmuW0iclYH72+ZHPKJcTo02gNQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SUYs3TkfmnMappvmWgh1S9qkAmnMTYqQ7NiEgHMcYJwJdQGC4Fyz9jam6Sgugq28NfCmEygLn5z8cN56Tb3u4rCi/KEfplEh0WYMV+5udNU25WTrBsf7sxJ8CgNMkzwXWJnLSq3jbD/CaWgu3DQLaYrSH4f+m8mM3Mz/M+7yQ+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=dw0C+ros; arc=fail smtp.client-ip=52.101.65.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vtPlC+1YYRm3kp8B95NxjnNsyVEdNzmBRrOfqyMoxVTcZgtlyPHl2ZQfTDjtet9b9pDn49NkbGJKmhka/RgFyZTqLY/+58nIDrGsR+tjgfvBQRP8qPRAuhYLO265EfNo0KY3ji67m7K5puGBhs9QfvuxJDgkUYSiprcWfdXPYWW6J92/yN9X5olunEwyZ6Rq8JDmC71ri3lSZxpfUWlSZxnuWdeEUzpT7hAYVtrSDqUgrppO/hgrsUftxBwG4wusDHAzymPqDvqz0FACw0Fa6xdkWlJNeBUqontOof+6EeEoxZlm93iO+ogbuUYZMQHzVuRzNjl/F6ZXzY6yhpaKqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcZt/JHtAMZ1rx7lot/hU5QC/NdfeEBXeV8FirwivIc=;
 b=A6ltrwFq3S8j+awu3g3crnNvYkzYJZyS3hzqYJ0URGEI1YGOS1BE/6yX7u1uGLHmXwvAS5OlLrmU6Y34lNwh4c8lvYVMMzCfpKowIEiahvrDlc1IkldgR9n2GDEA9VYq3l1TwjzsgFngjAl4V1NcMFkm1ivSAhtsCCGO4ncvEMZu3MJ8bYwL0vmylM3HzjCyETdREKU/qLa3/sA+LtRapLo+lWx+Vj6RGg4kwykUz3HgpGV6uOU/6TcwQtb5yj4ag3RJ7dsijXHClaw7a/+7qYF/AmuhNcGu7jK56O4WAA9ate2r/tDy8PF0R369vm47CUKp+0hfEUi4ZRaKY3G9Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcZt/JHtAMZ1rx7lot/hU5QC/NdfeEBXeV8FirwivIc=;
 b=dw0C+rosNLHwfcBDICuXQXb0Dwr+MxRL/aS7SV2Np0QaTJIBrOx49fWZcsSlWweAX/RbUI1sqEpbWUHpLJUAuxGym0K0gUTl9kOfq1TmTeT6HsloM81YyZR5Z1dX7kazzqfqJ+dU9i7syML5BOh2Fs8QUMgspYZs+Rqz5AOyTOTe3XNOXwH4Uw9lH/wwfMfT15komXXfe9dTqIL6MoxRCPRIEgQXNsSQPfioHsY2v0ZzQNchKRJHiteXWFcFpOHqTyUZUHoHbidF6QUEC7/B5rFSxSU+npceSsiTwDe1WYR7eyE2s4wC72KVIGFi/kQVajbLoEL54Emowj8LDEm44g==
Received: from AM8P190CA0009.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::14)
 by AM9PR07MB7268.eurprd07.prod.outlook.com (2603:10a6:20b:2c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 03:28:22 +0000
Received: from AM4PEPF00025F9A.EURPRD83.prod.outlook.com
 (2603:10a6:20b:219:cafe::da) by AM8P190CA0009.outlook.office365.com
 (2603:10a6:20b:219::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Wed,
 2 Jul 2025 03:28:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM4PEPF00025F9A.mail.protection.outlook.com (10.167.16.9) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.1 via
 Frontend Transport; Wed, 2 Jul 2025 03:28:22 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id E1F2E200A2;
	Wed,  2 Jul 2025 06:28:20 +0300 (EEST)
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
Subject: [PATCH v21 net-next 1/6] sched: Struct definition and parsing of dualpi2 qdisc
Date: Wed,  2 Jul 2025 05:28:12 +0200
Message-Id: <20250702032817.13274-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250702032817.13274-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250702032817.13274-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9A:EE_|AM9PR07MB7268:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b76eaa8d-5815-4a43-c41f-08ddb9187f64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YTXS5tzZBiYHhAhWUojZzoCfIvasLxR+VNrQ5Einfl6yGK1D99CIR5mVgTTx?=
 =?us-ascii?Q?GCebBV4Clhk6hHp2bI5LwwJaunOmWGS9Gl5I7c8SisudUyU0ONnTe5AOWa9f?=
 =?us-ascii?Q?1N6wgGkS8kXNMLinQOrTTTyxph1ChnPOhP98OxmofiKgW2A7BkJ/YSijqK8A?=
 =?us-ascii?Q?5zexHc1gWtXzwzx6SQrwS68bIeafBOwcmAamtXbrSLGbSd2FdQ2YxFOwW1rr?=
 =?us-ascii?Q?7YKIi8qL1fO6qPmEHFn4sG7k1aCzyEKwAgh6RxOTwdhzfFlrDqooWL1ZO6vr?=
 =?us-ascii?Q?PCphLVCQn9PZZPAhaT44N6zmteG7bm/jcjTBVvEGM0+tseoAr9Idcemrl93d?=
 =?us-ascii?Q?9xPxphZ4NNbNVhCgzPgiqZnI8fv2Xngc4udUDhcy6NgcJQH1gSgegD8Twjxc?=
 =?us-ascii?Q?LRhN4tFRps/HbsCPM2t9QrKqwNzX0P5Zc/RDGnglH6lryWjnBsVXk3S0KM6f?=
 =?us-ascii?Q?U7tUsfdrq54/6gnDXtGP71m9MBEugXr9nv3q12uTAxMYieI7oh+/xp6FccEB?=
 =?us-ascii?Q?MKWZS9tp8g6gGqwp4j30S6uTk7EKep8742J3gtwMnWoCkklwWsypNWx3cFuR?=
 =?us-ascii?Q?iXG+FYaCZ4VjtkwzAL7Nz3iBXHR40A6sqVIb+kwdO/ne5q7F69gtG2c1tZi2?=
 =?us-ascii?Q?GQ0n79ZIg01y3Il0RmZOfytZItkWryAkfRM+nJ+e/aMH8barnugUYh29N995?=
 =?us-ascii?Q?93fjvdXufkfnUH6r1vyLRp3Uk6MxqCpfx1SfTfD6IcrVlhD0bxSheBdd+s+v?=
 =?us-ascii?Q?Mck5ipXVtMEEmr8k8GhMAwldfsBfXYx/kIGSTmbhMDzO16rrycFzGIiRMKmV?=
 =?us-ascii?Q?z64MeqLkJ1Wu31VfounZMBY+BW0rnxuA1/zQgxtrlZMbeXRwWR/Rl5Axb27r?=
 =?us-ascii?Q?aSr+Ye9noNpgpiknpWsfovhoNpFfuJEh5QMp4XWE4H8va08Fn788gzisB0rw?=
 =?us-ascii?Q?/pjWUhSHE0YyXyIHqoNnyyVFyhZVo94xZ9MMPrb3OdDaprFqMECdKnAEn6x4?=
 =?us-ascii?Q?BcJBIK0ifPDGEFe9A+jA3cYpvFk5pToSxKzxz7izdTa/F+pWmLv/pZ8vG2Jf?=
 =?us-ascii?Q?jr6btDk2D7yimqufBF9o/deDeu4zAilJvac1QSz9xwhcLXB5ENdwVJMfLY0F?=
 =?us-ascii?Q?ZFypNfs4WWhczVRCzX9EJ5a+A4pXXybN52D1Fx/0YRVAPrPTiBETx8kVT3+b?=
 =?us-ascii?Q?HH8RrhFaIpcVOwNVyNUp1h1XZprqpENf1jB6CZgIg6DclFUcNA8kPPUugfEP?=
 =?us-ascii?Q?OZisI2bqZe5Jh/0ivbTRqjoKUsBZJMRkig5bNBWLXR3no3ey06vuqXklJz5z?=
 =?us-ascii?Q?VvUVodBCK9nUsjYiOMu4HBfxTGk6iYhmlUVsOzexgdGZhsIVG9Gv1lwiLmAM?=
 =?us-ascii?Q?+Ghk+Mr3S28d4S+1SfsCPUDEM1qj01Xc3y2EoZtUXjo8ladmrv3LWpDJTYgZ?=
 =?us-ascii?Q?AnlPhuD0NjLTh6BkKAyJMEdgP7rjdVbUGSZWKl1CUI4xCtAZyQchYCS2KxxZ?=
 =?us-ascii?Q?2iMstF6PxMbcG7yDmBIqMgk1JtPXup1mM3sDnGZS833xDQAQ118EHIEIzw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 03:28:22.3219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b76eaa8d-5815-4a43-c41f-08ddb9187f64
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F9A.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7268

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
index 000000000000..c6907c862efe
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
+	if (!opt) {
+		NL_SET_ERR_MSG_MOD(extack, "Dualpi2 options are reuqired");
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
+	if (opt) {
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


