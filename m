Return-Path: <linux-kselftest+bounces-30685-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07693A8814B
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 15:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10B2188736D
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 13:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B602D1F50;
	Mon, 14 Apr 2025 13:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="sn8BXpHu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2049.outbound.protection.outlook.com [40.107.105.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1402BEC5E;
	Mon, 14 Apr 2025 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636355; cv=fail; b=FJgfCBqTyqkJnXXAvkUpXFrnK3dPn3J65zJvfnzi+/O82Cb76dcS1q9z35T3Q/EQzYYSVP3oAn8QVo9rQfebZrEyCewXduhg1g9N2OKDmUBBkdVUEAdL8uwhlIc4MlpflbqhyxjJIRp97YfTvBmW04yZU8XlzSI4VHgMKJyvRNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636355; c=relaxed/simple;
	bh=Hz9/NQoNXXSFKp+EgWqGC2AObfBBJuzhsp7YG4NV79g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ak63uUu86XfuQcpa58ZuCnljFLqrtqClw8qTZGJXgBohl+DwkW8d++va7yRQUehIaf+42W42YOMkQPoEjMElqohbeDyjcj0hQAmyDqqqMEzlx8LuDlNt1Hr7wY6YVHXNNUxQhgFw3YrylrOP5F88f2MgokEIM+uYkzUCiuTA/Fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=sn8BXpHu; arc=fail smtp.client-ip=40.107.105.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S63ZMFqy5OLGeMSW+B3lHz79v5djOdGr9iX5P06p1Vkgjldy1vn7Ed5KI96QdIY+IoBcXhpc1BYmFgvwem8ohzXgyzzMAyLSGadMD7PbyiqrDYToT3vpHReAaqEaHcfG27XZem7RwOWTy5GZ21VW4PdiN2MVlE7M6T1O0xWjaDwfouojGpqQva3EL1po/HCq7RhBcpxnjSDVJ3UaMxLSiXq1M0FfuNM+mROOekGfmwWNgnUp2zeUs/DmUvuB9j1zAwobkq01cCa5U4CkDa1nXyij705qxKGdMP5lON/v32yoKc2VaaHCHl4QRk4eMWcaSDNY63vwvSWUt9TFvMQI1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4z94/8FeOZZpuBaZWInJzpc+l1R4kr3qXVxURIkYsw=;
 b=h46/eXM0G6QFWaaFqrn1e2gM8fqiCC90NHLihakHUMtFPb1iprQQr3XAbcbdeInqfoA9700hlqVfxIHWgwoHTfQtBGipnuVd72AAkL05/AJODM9Qg5IsLqAYly+4smaorZaa4WejMQvlOHM9w/A5CV0OaDceTH0UlmR2Db+6e6cXhVmsA7bFEvWWyMzAMXDholTVQJJq9TdFVJmo8i+7jNeCqFm1rA4bstfq1rXzopZkwpcQ6WVr5frTI0F+tswEXfCRdoSvDv0wKINq0n2dMsqaIvuY+Im/8j4bcwPkYkaAfGZv0FfbZfa9W+DHkZpijVOHvseo778cUdhYllBURA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4z94/8FeOZZpuBaZWInJzpc+l1R4kr3qXVxURIkYsw=;
 b=sn8BXpHuKecNc/vqAdF0XnWrBqgrIcWqKDq0fZrDIElYPbT0Xx9qXKe44WY2PLz3DsaM2JQrmoYN5EIU+lI/Mq5jPPzpUhucdREs4TaAG15lInDJUCX9E2Cvc6VKoPxsF1HpE6CduIsPMxcd17uykH4G47dcRaZ6xWhuDsCksg7bjvO2a0ZrLcbMYuUg+nQuX3ReEVqbQmot2Y5y7uFcaKn+PHqW6j9HY3l10lsWOtj/4RX3KgZKN27A8zfXpvc+OUm3KnRMvoPYIAdLWUDHsOKjxrBaTHOuVizPtqNPuM278jatWTic7TfaZWTKom3uOh0yUxnknjJnmAGyHxBUMw==
Received: from DB7PR03CA0078.eurprd03.prod.outlook.com (2603:10a6:10:72::19)
 by AS8PR07MB9260.eurprd07.prod.outlook.com (2603:10a6:20b:61c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.31; Mon, 14 Apr
 2025 13:12:24 +0000
Received: from DU2PEPF00028D07.eurprd03.prod.outlook.com
 (2603:10a6:10:72:cafe::2d) by DB7PR03CA0078.outlook.office365.com
 (2603:10a6:10:72::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Mon,
 14 Apr 2025 13:12:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DU2PEPF00028D07.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 13:12:24 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 53EDCIJG000852;
	Mon, 14 Apr 2025 13:12:41 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
        jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, horms@kernel.org, andrew+netdev@lunn.ch,
        donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v10 RESEND net-next 3/5] sched: Struct definition and parsing of dualpi2 qdisc
Date: Mon, 14 Apr 2025 15:11:55 +0200
Message-Id: <20250414131157.97425-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414131157.97425-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250414131157.97425-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D07:EE_|AS8PR07MB9260:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c5674e4b-7b2d-4a45-7866-08dd7b55ffa5
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?FrGKiK45TrUrxanjoK9thIXOjh8ylVU+Zi2R9Mw0gY60RNMTm6jDnTtaxu0w?=
 =?us-ascii?Q?Ew1BOIIwVS6ROOgHh60Ggu7DYsblZjTbRexxkRrorwF2qs/YhLszcZnFEY88?=
 =?us-ascii?Q?kpEwOdaGtXo2XWl7SlS44Jnaa+hDrIkvShD4k6FFW/VfTFx0CbUNSjOuZvq2?=
 =?us-ascii?Q?yT3p4KhOVa3qd47ffBocIvCP/Ij3VktsfOwbg94oaPg79tOAiVWWNMd0laE+?=
 =?us-ascii?Q?2anrst53xLnvMYwwuRWSpzTj7s7UiTfHTOgY7NRa+IbQlEEPIpgSGRhELTde?=
 =?us-ascii?Q?947HbIQUi/8/HsnZCHyp9SqkDrECCbH8rPyxxLvtWqd5QbTYe/tmFmcF1vNg?=
 =?us-ascii?Q?hGC6ap9T9vRgUlXtRtmIwtVKmGoJcvYZpxlswqew5lFv2+e1CcGTjlvegYak?=
 =?us-ascii?Q?FC/324nXxPe6vL+bEPUqJc+upGe8fibYTOdOWOKFHiac2pst95U85cMqp6s/?=
 =?us-ascii?Q?I5Rul9Nvvok4ZNx/y2T7yNAIWMUQQpC88DaX8ysQ6m3znL2KZ6T1Y8Bo8/7V?=
 =?us-ascii?Q?B7PWL2n822WFY/de9EZP297+WX6hqn+AGmjA4/dDK07i9Pufe0n+N0Z8pysF?=
 =?us-ascii?Q?gKXTWJsKkuZOHmjdLYJRA7PYwNFXFd5cSEMr/vnfnTW5FDpE1lRArlb+FprY?=
 =?us-ascii?Q?U7PSmiYgswT4TmZ4sUok4zdNUN+4PpjBazKpcuGLoJzKAsDNaBPg5VGxQzm6?=
 =?us-ascii?Q?PWP7CgXqFyXTNtIUWCsK291n6JBIKEqAr+smsIcggNvy4+Qpma6tRJVsvBrH?=
 =?us-ascii?Q?3ppMVxeRTptRjAKNxxUlpfcwq1/VVDcNKdTvMdRRDfZzFGVgqERngyfw1rml?=
 =?us-ascii?Q?1b1tKWw+dbNqWM6fd01AugiT2hYroDh4+MaiV+tN+ltmm8pDjQYrxTMKXppz?=
 =?us-ascii?Q?F0ZUGVw40SaYnKvCPVPlSTMYm27K7ZEy0nrBHGyDbigLldLNljrTA+KFmrUy?=
 =?us-ascii?Q?SXPPAORTvDzX3Uz5MMl0mY9BqfydRFUOPR7Tqx3Uja6VU3mWhEw0MFUVUt+C?=
 =?us-ascii?Q?qTVISzTppwKRaQONK+eIyjW3QkXKiXPubXYE+yxS5YzW3Z/7gsZcSDEo+RCD?=
 =?us-ascii?Q?tGEq5NSOaBZ5Pxa0sNxMqYpw14xA0UZsjTHfaTsbySG0jeosJQwQM++0CW8f?=
 =?us-ascii?Q?jQ4k8BShv7PGpJtTRPmKBLnCGa/aWs4Y+YBptQOWT1S2MxIR6Ak4hls1yQbr?=
 =?us-ascii?Q?nFGr5U5m/o3w0QnDtz2+pxg4IwW7MFusb2Hovk99EcL10xQSHOhjl+HT4w7g?=
 =?us-ascii?Q?lWHeE8bnljuW8yGyfDGljKmOnM+btmKk9NjJJWr7ZfSlxyRN2IXMUl9aDa38?=
 =?us-ascii?Q?Lzpbf9qGoG7cTHtjF09aP/6X0KkPq+oYl+geUTA7vAbQcZDznkBMZatsJMP1?=
 =?us-ascii?Q?HXWiAYHtOiY7JThsxs7xaBpykngYJDYqeMGhkUZRc2SgjUu35T601LBjy4Af?=
 =?us-ascii?Q?kFv/bZdfacyIUC7FQyc3enr/YhnmAA+RCMAu7f4TZ6C9d90Hkjdz/tOHpsfn?=
 =?us-ascii?Q?xdmNWfq8BM9Q/ysEJz5SuALp8QU+E4xwgYtm6v/OHs5xPHcP6YVwrMbpxw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 13:12:24.7011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5674e4b-7b2d-4a45-7866-08dd7b55ffa5
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D07.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9260

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
 include/uapi/linux/pkt_sched.h |  24 ++
 net/sched/sch_dualpi2.c        | 553 +++++++++++++++++++++++++++++++++
 2 files changed, 577 insertions(+)
 create mode 100644 net/sched/sch_dualpi2.c

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index 25a9a47001cd..fd5bec118cdc 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -1210,4 +1210,28 @@ enum {
 
 #define TCA_ETS_MAX (__TCA_ETS_MAX - 1)
 
+/* DUALPI2 */
+enum {
+	TCA_DUALPI2_UNSPEC,
+	TCA_DUALPI2_LIMIT,		/* Packets */
+	TCA_DUALPI2_MEMORY_LIMIT,	/* Bytes */
+	TCA_DUALPI2_TARGET,		/* us */
+	TCA_DUALPI2_TUPDATE,		/* us */
+	TCA_DUALPI2_ALPHA,		/* Hz scaled up by 256 */
+	TCA_DUALPI2_BETA,		/* HZ scaled up by 256 */
+	TCA_DUALPI2_STEP_THRESH,	/* Packets or us */
+	TCA_DUALPI2_STEP_PACKETS,	/* Whether STEP_THRESH is in packets */
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
index 000000000000..3bf9db6d3bb3
--- /dev/null
+++ b/net/sched/sch_dualpi2.c
@@ -0,0 +1,553 @@
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
+	struct { /* PI2 parameters */
+		u64	target;	/* Target delay in nanoseconds */
+		u32	tupdate;/* Timer frequency in nanoseconds */
+		u32	prob;	/* Base PI probability */
+		u32	alpha;	/* Gain factor for the integral rate response */
+		u32	beta;	/* Gain factor for the proportional response */
+		struct hrtimer timer; /* prob update timer */
+	} pi2;
+
+	struct { /* Step AQM (L-queue only) parameters */
+		u32	thresh;	/* Step threshold */
+		bool	in_packets; /* Whether the step is in packets or time */
+	} step;
+
+	struct { /* C-queue starvation protection */
+		s32	credit; /* Credit (sign indicates which queue) */
+		s32	init;	/* Reset value of the credit */
+		u8	wc;	/* C-queue weight (between 0 and MAX_WC) */
+		u8	wl;	/* L-queue weight (MAX_WC - wc) */
+	} c_protection;
+
+	/* General dualQ parameters */
+	u32	memory_limit;	/* Memory limit of both queues */
+	u8	coupling_factor;/* Coupling factor (k) between both queues */
+	u8	ecn_mask;	/* Mask to match packets into L-queue */
+	u32	min_qlen_step;	/* Minimum queue length to apply step thresh */
+	bool	drop_early;	/* Drop at enqueue instead of dequeue if true */
+	bool	drop_overload;	/* Drop (1) on overload, or overflow (0) */
+	bool	split_gso;	/* Split aggregated skb (1) or leave as is */
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
+	return ktime_add_ns(ktime_get_ns(), q->pi2.tupdate);
+}
+
+static void dualpi2_reset_c_protection(struct dualpi2_sched_data *q)
+{
+	q->c_protection.credit = q->c_protection.init;
+}
+
+/* This computes the initial credit value and WRR weight for the L queue (wl)
+ * from the weight of the C queue (wc).
+ * If wl > wc, the scheduler will start with the L queue when reset.
+ */
+static void dualpi2_calculate_c_protection(struct Qdisc *sch,
+					   struct dualpi2_sched_data *q, u32 wc)
+{
+	q->c_protection.wc = wc;
+	q->c_protection.wl = MAX_WC - wc;
+	q->c_protection.init = (s32)psched_mtu(qdisc_dev(sch)) *
+		((int)q->c_protection.wc - (int)q->c_protection.wl);
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
+	qc = READ_ONCE(q->c_head_ts);
+	ql = READ_ONCE(q->l_head_ts);
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
+	/* Alpha and beta take at most 32b, i.e, the delay difference would
+	 * overflow for queuing delay differences > ~4.2sec.
+	 */
+	delta = ((s64)qdelay - q->pi2.target) * q->pi2.alpha;
+	delta += ((s64)qdelay - q->last_qdelay) * q->pi2.beta;
+	if (delta > 0) {
+		new_prob = __scale_delta(delta) + q->pi2.prob;
+		if (new_prob < q->pi2.prob)
+			new_prob = MAX_PROB;
+	} else {
+		new_prob = q->pi2.prob - __scale_delta(~delta + 1);
+		if (new_prob > q->pi2.prob)
+			new_prob = 0;
+	}
+	q->last_qdelay = qdelay;
+	/* If we do not drop on overload, ensure we cap the L4S probability to
+	 * 100% to keep window fairness when overflowing.
+	 */
+	if (!q->drop_overload)
+		return min_t(u32, new_prob, MAX_PROB / q->coupling_factor);
+	return new_prob;
+}
+
+static enum hrtimer_restart dualpi2_timer(struct hrtimer *timer)
+{
+	struct dualpi2_sched_data *q = from_timer(q, timer, pi2.timer);
+
+	WRITE_ONCE(q->pi2.prob, calculate_probability(q->sch));
+
+	hrtimer_set_expires(&q->pi2.timer, next_pi2_timeout(q));
+	return HRTIMER_RESTART;
+}
+
+static struct netlink_range_validation dualpi2_alpha_beta_range = {
+	.min = 1,
+	.max = ALPHA_BETA_MAX,
+};
+
+static struct netlink_range_validation dualpi2_wc_range = {
+	.min = 0,
+	.max = MAX_WC,
+};
+
+static const struct nla_policy dualpi2_policy[TCA_DUALPI2_MAX + 1] = {
+	[TCA_DUALPI2_LIMIT]		= NLA_POLICY_MIN(NLA_U32, 1),
+	[TCA_DUALPI2_MEMORY_LIMIT]	= NLA_POLICY_MIN(NLA_U32, 1),
+	[TCA_DUALPI2_TARGET]		= {.type = NLA_U32},
+	[TCA_DUALPI2_TUPDATE]		= NLA_POLICY_MIN(NLA_U32, 1),
+	[TCA_DUALPI2_ALPHA]		=
+		NLA_POLICY_FULL_RANGE(NLA_U32, &dualpi2_alpha_beta_range),
+	[TCA_DUALPI2_BETA]		=
+		NLA_POLICY_FULL_RANGE(NLA_U32, &dualpi2_alpha_beta_range),
+	[TCA_DUALPI2_STEP_THRESH]	= {.type = NLA_U32},
+	[TCA_DUALPI2_STEP_PACKETS]	= {.type = NLA_U8},
+	[TCA_DUALPI2_MIN_QLEN_STEP]	= {.type = NLA_U32},
+	[TCA_DUALPI2_COUPLING]		= NLA_POLICY_MIN(NLA_U8, 1),
+	[TCA_DUALPI2_DROP_OVERLOAD]	= {.type = NLA_U8},
+	[TCA_DUALPI2_DROP_EARLY]	= {.type = NLA_U8},
+	[TCA_DUALPI2_C_PROTECTION]	=
+		NLA_POLICY_FULL_RANGE(NLA_U8, &dualpi2_wc_range),
+	[TCA_DUALPI2_ECN_MASK]		= {.type = NLA_U8},
+	[TCA_DUALPI2_SPLIT_GSO]		= {.type = NLA_U8},
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
+	if (!opt)
+		return -EINVAL;
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
+		WRITE_ONCE(sch->limit, limit);
+		WRITE_ONCE(q->memory_limit, limit * psched_mtu(qdisc_dev(sch)));
+	}
+
+	if (tb[TCA_DUALPI2_MEMORY_LIMIT])
+		WRITE_ONCE(q->memory_limit,
+			   nla_get_u32(tb[TCA_DUALPI2_MEMORY_LIMIT]));
+
+	if (tb[TCA_DUALPI2_TARGET]) {
+		u64 target = nla_get_u32(tb[TCA_DUALPI2_TARGET]);
+
+		WRITE_ONCE(q->pi2.target, target * NSEC_PER_USEC);
+	}
+
+	if (tb[TCA_DUALPI2_TUPDATE]) {
+		u64 tupdate = nla_get_u32(tb[TCA_DUALPI2_TUPDATE]);
+
+		WRITE_ONCE(q->pi2.tupdate, tupdate * NSEC_PER_USEC);
+	}
+
+	if (tb[TCA_DUALPI2_ALPHA]) {
+		u32 alpha = nla_get_u32(tb[TCA_DUALPI2_ALPHA]);
+
+		WRITE_ONCE(q->pi2.alpha, dualpi2_scale_alpha_beta(alpha));
+	}
+
+	if (tb[TCA_DUALPI2_BETA]) {
+		u32 beta = nla_get_u32(tb[TCA_DUALPI2_BETA]);
+
+		WRITE_ONCE(q->pi2.beta, dualpi2_scale_alpha_beta(beta));
+	}
+
+	if (tb[TCA_DUALPI2_STEP_PACKETS]) {
+		bool step_pkt = !!nla_get_u8(tb[TCA_DUALPI2_STEP_PACKETS]);
+		u32 step_th = READ_ONCE(q->step.thresh);
+
+		WRITE_ONCE(q->step.in_packets, step_pkt);
+		WRITE_ONCE(q->step.thresh,
+			   step_pkt ? step_th : (step_th * NSEC_PER_USEC));
+	}
+
+	if (tb[TCA_DUALPI2_STEP_THRESH]) {
+		u32 step_th = nla_get_u32(tb[TCA_DUALPI2_STEP_THRESH]);
+		bool step_pkt = READ_ONCE(q->step.in_packets);
+
+		WRITE_ONCE(q->step.thresh,
+			   step_pkt ? step_th : (step_th * NSEC_PER_USEC));
+	}
+
+	if (tb[TCA_DUALPI2_MIN_QLEN_STEP])
+		WRITE_ONCE(q->min_qlen_step,
+			   nla_get_u32(tb[TCA_DUALPI2_MIN_QLEN_STEP]));
+
+	if (tb[TCA_DUALPI2_COUPLING]) {
+		u8 coupling = nla_get_u8(tb[TCA_DUALPI2_COUPLING]);
+
+		WRITE_ONCE(q->coupling_factor, coupling);
+	}
+
+	if (tb[TCA_DUALPI2_DROP_OVERLOAD])
+		WRITE_ONCE(q->drop_overload,
+			   !!nla_get_u8(tb[TCA_DUALPI2_DROP_OVERLOAD]));
+
+	if (tb[TCA_DUALPI2_DROP_EARLY])
+		WRITE_ONCE(q->drop_early,
+			   !!nla_get_u8(tb[TCA_DUALPI2_DROP_EARLY]));
+
+	if (tb[TCA_DUALPI2_C_PROTECTION]) {
+		u8 wc = nla_get_u8(tb[TCA_DUALPI2_C_PROTECTION]);
+
+		dualpi2_calculate_c_protection(sch, q, wc);
+	}
+
+	if (tb[TCA_DUALPI2_ECN_MASK])
+		WRITE_ONCE(q->ecn_mask,
+			   nla_get_u8(tb[TCA_DUALPI2_ECN_MASK]));
+
+	if (tb[TCA_DUALPI2_SPLIT_GSO])
+		WRITE_ONCE(q->split_gso,
+			   !!nla_get_u8(tb[TCA_DUALPI2_SPLIT_GSO]));
+
+	old_qlen = qdisc_qlen(sch);
+	old_backlog = sch->qstats.backlog;
+	while (qdisc_qlen(sch) > sch->limit ||
+	       q->memory_used > q->memory_limit) {
+		struct sk_buff *skb = __qdisc_dequeue_head(&sch->q);
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
+	q->memory_limit = q->sch->limit * psched_mtu(qdisc_dev(sch));
+
+	q->pi2.target = 15 * NSEC_PER_MSEC;
+	q->pi2.tupdate = 16 * NSEC_PER_MSEC;
+	q->pi2.alpha = dualpi2_scale_alpha_beta(41);	/* ~0.16 Hz * 256 */
+	q->pi2.beta = dualpi2_scale_alpha_beta(819);	/* ~3.20 Hz * 256 */
+
+	q->step.thresh = 1 * NSEC_PER_MSEC;
+	q->step.in_packets = false;
+
+	dualpi2_calculate_c_protection(q->sch, q, 10);	/* wc=10%, wl=90% */
+
+	q->ecn_mask = INET_ECN_ECT_1;
+	q->min_qlen_step = 0;
+	q->coupling_factor = 2;		/* window fairness for equal RTTs */
+	q->drop_overload = true;	/* Preserve latency by dropping */
+	q->drop_early = false;		/* PI2 drops on dequeue */
+	q->split_gso = true;
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
+	hrtimer_init(&q->pi2.timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
+	q->pi2.timer.function = dualpi2_timer;
+
+	if (opt) {
+		err = dualpi2_change(sch, opt, extack);
+
+		if (err)
+			return err;
+	}
+
+	hrtimer_start(&q->pi2.timer, next_pi2_timeout(q),
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
+	q->pi2.prob = 0;
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
+	q->pi2.tupdate = 0;
+	hrtimer_cancel(&q->pi2.timer);
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
+/* Minimal class support to handler tc filters */
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
+MODULE_AUTHOR("Olga Albisser <olga@albisser.org>");
+MODULE_AUTHOR("Henrik Steen <henrist@henrist.net>");
+MODULE_AUTHOR("Olivier Tilmans <olivier.tilmans@nokia.com>");
+MODULE_AUTHOR("Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>");
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_VERSION("1.0");
-- 
2.34.1


