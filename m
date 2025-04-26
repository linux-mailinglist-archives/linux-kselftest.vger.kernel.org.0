Return-Path: <linux-kselftest+bounces-31719-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9796A9DC89
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 19:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50213AE631
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 17:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0CF25D8FF;
	Sat, 26 Apr 2025 17:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ryx6hWWN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2076.outbound.protection.outlook.com [40.107.105.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1637225DB0D;
	Sat, 26 Apr 2025 17:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745688056; cv=fail; b=MEDuQOZXkCfigr/CJKZbLUZZrzy9MDcgvRw7pFVe4gOzuuCTRPMWzthlZe4Sp3X7hxTPDVvtdzh5A7jguIWp+YuoeDfiRwv4aQLJZIpOZ1LwNsZkj+UfhmneGqdtmrc5ur8Tg3cAJWDkaVsK61wlPOcJw9piWKINLTHmrdl4eqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745688056; c=relaxed/simple;
	bh=vIYkg8K93ETM2zplJD9NH8ktUJhLCV+6aI0HXjNkMuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jb0vCDuOPsbqYUURa3mzq5cALL9Tg/FBgN/+pxUJZU9hSkwuhAy09RGkBI8JZNhd4BYaqf7nKFvUoSD1kgSwXpk9js83rgHdz9sWESnOm24sNyhgL/jcBWzTmWPYDZzTACizsUR0t5QQWwhwTcNPSevWEcCERYD7r0PfuGIIVrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ryx6hWWN; arc=fail smtp.client-ip=40.107.105.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWbhyRiUy59IdbNAvF/GMRbd1Q6aYp1Z9Al7Q7BEICHrwBOrVcYHZgSXl34RNrGV+AjWr/1xdift4SmeK1dzsDNqTqhO93FJpl8IF5t9xeWto7YeqkjcnhzjpHc/G46Fvt588W/wzKKP8HfBMyoeHNcovw4eVF9BgavdKC4Qk4PHVEKv852ORw4gmO8pxrHX94TbeAfpbFnSURvK6Yy8Dgm4ZpLP6MrxHS2uS2kMHN6N5+IhBnloWxscDRjMPhL90Uznv8aUYDoNsOEgFgnP9f5RzSPeNX9Ba2B7aCZZwZz739H6BMBoAjjrMdNlFCvJLgBxZPYAGcWBDqPlNBW51Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxWmUBchBqCw6Dmy0au+gbErejODetXnd3G2CuYiWlw=;
 b=a674eUlChSH+fDDqeZ7A9chJKhxSJLgnDWP6roahAfV7UOCpRvG3I2b3GThBd9z41qvsx6/X5O/Fr6Q6V9EpjZ76EtI3Ayfk5JRClPFSYamR8V1nyQ/WJs6h0lqWjwtA8DGqqkMrdYA9EpxdxvgQmsHvqM0Jf21hPj1JXFurz4cYClZt5hHSE3vrIy9Xevog5PbIln20HzoK8rZbL419YP+HLtLPrSCUWmcpZY/sQcHx0mrKEHTKmOMGQPvsHDi8igLRQqBfqlSy3Wu9XQX0HKpjJWHEqH2BT0zCkuoh3eL2T0I+wxFxuQ5HZVwzNQ88l13Pdx9vL9pEzJ564uehJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.241) smtp.rcpttodomain=apple.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxWmUBchBqCw6Dmy0au+gbErejODetXnd3G2CuYiWlw=;
 b=ryx6hWWNCroXBiPUqm7SXP6FKUZ5wcfzQmwz3KxuZm4RhdhmOcqiiAz3dHz0v4n4onyAJswUNkZaEr7SENSk29g3TPmeClFaddbtvc1a5ZKbjaTBomawop/7keQKO8dopuSZpqmWZv0DXfrdMea0JuaypbgdCJ1WOzbzvNSBTSU/cr0xlNhykbcNOilQJXjdx6kJ2vmbsY2F7GPHwHc2tfxmikKQTzHjislk0J9ovKnflbqHPf/ZE28+3sMIq8nMvleWZZP+qHWQzDSMaOXBCvYAvwog+I3IAIyzGzxmnHyCBE6kKwEtt2OUlgc4ShLzQ5Nn2vTSeFy1j+uXucNm7Q==
Received: from DUZP191CA0033.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::29)
 by AS1PR07MB8904.eurprd07.prod.outlook.com (2603:10a6:20b:47d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Sat, 26 Apr
 2025 17:20:48 +0000
Received: from DB1PEPF000509E2.eurprd03.prod.outlook.com
 (2603:10a6:10:4f8:cafe::d4) by DUZP191CA0033.outlook.office365.com
 (2603:10a6:10:4f8::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.23 via Frontend Transport; Sat,
 26 Apr 2025 17:20:48 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.241) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB1PEPF000509E2.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Sat, 26 Apr 2025 17:20:47 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id D2E07200F3;
	Sat, 26 Apr 2025 20:20:45 +0300 (EEST)
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
Subject: [PATCH v13 net-next 3/5] sched: Struct definition and parsing of dualpi2 qdisc
Date: Sat, 26 Apr 2025 19:20:23 +0200
Message-Id: <20250426172025.9459-4-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E2:EE_|AS1PR07MB8904:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4325df56-171b-45f2-7ace-08dd84e6af41
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?Rza+2PWYsMctGjCPbmg5NPX7vJU+33HMZohiF0xzkX6kRJuMMYfwih3jEDkh?=
 =?us-ascii?Q?cbzLlziCXM3MHWHMMG/pVMO+dEKEeNcBbF5mtsI+9ZGtzGIZuS8w1WCJZzhX?=
 =?us-ascii?Q?d5w5jB9erKuC+HjlzVZjh8sY+62NNsidbYY+XijPm3haEPyWYJ2Cb4+XlxVT?=
 =?us-ascii?Q?uBqo1+Mxw+Q4XOFcF0ytiib8joyD7hb0U58/Dab1GLzm4CyexE1kgAP1zsv7?=
 =?us-ascii?Q?3xburBrwM2xomZd5NgTSe3qCuDRTxv9ByqV7jIRMc9bWgdhmW4pSH5mC02Ei?=
 =?us-ascii?Q?g1jSIMYMNcytU9yHCILka9K3QueunF9sEsp5KO3eMV78OVWV77z4Cw3EWKvm?=
 =?us-ascii?Q?i8sY7caa8gngJiQ2/c33bpuEiin9uXBlFGLgJ+BvPglm14SnGJnKCi2e41O9?=
 =?us-ascii?Q?OFV6+md2RlnUMN3FwAzGUmX3+ERDErxTZ5D5hJ5L7McCYwPfG5kv3E5+x7Id?=
 =?us-ascii?Q?8zTRPEK/7iwkOfxA/FHBo/7aH4dSvKrhstVz2pEfNkWygFAXYMwor977/hiW?=
 =?us-ascii?Q?3ycLzafOcBve9CPYM22STtN6i7lN1KN2qkoFIMLwWCwU59gnlHSbva/Rie8r?=
 =?us-ascii?Q?DsvK1zFgiJ/ZvnBTrwg+nk6YX9KhCcmb11LN8eh7bVBRMNWGreBTyDHgDf6g?=
 =?us-ascii?Q?8Xi57h+B7zZ8cajMFiUDB9rH9EsHXmVcONkl4b/PS5ailM6RVr1LBTIB7d/E?=
 =?us-ascii?Q?3EABuBEkCjHCN3A/QcyL72UGUYLCfTx+W+pIOm7gAKR5SAuxxiHghx+htej2?=
 =?us-ascii?Q?kcHANorlnt3V4B6npQOwQEjFMeXIdoGd2PM20uz0B1M3IJXYx64uOLiGbcm1?=
 =?us-ascii?Q?l6ePGxH/LNc4P/QtS3DX+7zSbkC6tLknySw5puUwFg6WVtMTBFlJ1excQ6JD?=
 =?us-ascii?Q?XR2TfvwOC3FmNvByfHr2NhEPHHeuuSjJcviqhlv2EWnrcSpZhUscptlwHXHx?=
 =?us-ascii?Q?sh25bmgif7peTb8D6i0yxI/+cwFtfqlicBxKJuMpTLkvxw6RjkucJf7MenPb?=
 =?us-ascii?Q?diLkaRTLk8lCSfCA7ij7WDbFYTBXjpWnJ0cAWbF+JmgJHzQulFzoYz5eTnzH?=
 =?us-ascii?Q?7vFrerDvYMqSxE4jhJAyfcXmjmS7H15vnq82fv2tmFenDj9/+Ik0K1FUf5Q/?=
 =?us-ascii?Q?WohC2Tm61+V5ZNDa1tUNOp5yDXo4NwdOOXvZGda3Qj/N9Au7hv+3V9T0eJfe?=
 =?us-ascii?Q?MvKe86F+z2FezihhWwM5wNDrp9HvWVi7BvAQYslSvx7ns8FpK31RNq0JJFS0?=
 =?us-ascii?Q?1TaKMNjtjL4pMbwas7H/GrD2hF+gCoWgRPqB3Ilyznx4IFczpzY+WUi3q+p+?=
 =?us-ascii?Q?z05t1I5nEcUWIqfXmPUtjbqPXazA4bRmEIX0ohyViGwVmC1W2gb5sno6LJJ8?=
 =?us-ascii?Q?0bPnbR3WWsMd6epaeQyHoX0rULNCOsLQOiCYYAdtZcgn8dQ+dUywK0rcr3aS?=
 =?us-ascii?Q?JUTk3/s59fhi4/uE0ysjzamoXyCtA3Wwkz35/qIQBCharuxrCZzW3jp4BHTa?=
 =?us-ascii?Q?6YiX9PNtnV8iGD+vDmapJeYquu7vrFjHuGkiGNvFRa4pBeTbCEDx2C2tzw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 17:20:47.2876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4325df56-171b-45f2-7ace-08dd84e6af41
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E2.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR07MB8904

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
 net/sched/sch_dualpi2.c        | 554 +++++++++++++++++++++++++++++++++
 2 files changed, 578 insertions(+)
 create mode 100644 net/sched/sch_dualpi2.c

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index 9ea874395717..b4caeccbea72 100644
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
index 000000000000..bb3d9982b572
--- /dev/null
+++ b/net/sched/sch_dualpi2.c
@@ -0,0 +1,554 @@
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
+	bool	step_in_packets; /* Whether the step is in packets or time */
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
+	delta = ((s64)qdelay - q->pi2_target) * q->pi2_alpha;
+	delta += ((s64)qdelay - q->last_qdelay) * q->pi2_beta;
+	if (delta > 0) {
+		new_prob = __scale_delta(delta) + q->pi2_prob;
+		if (new_prob < q->pi2_prob)
+			new_prob = MAX_PROB;
+	} else {
+		new_prob = q->pi2_prob - __scale_delta(~delta + 1);
+		if (new_prob > q->pi2_prob)
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
+static u32 get_memory_limit(struct Qdisc *sch, u32 limit)
+{
+	/* Apply rule of thumb, i.e., doubling the packet length,
+	 * to further include per packet overhead in memory_limit.
+	 */
+	u64 memlim = mul_u32_u32(limit, 2 * psched_mtu(qdisc_dev(sch)));
+
+	if (upper_32_bits(memlim))
+		return 0xffffffff;
+	else
+		return lower_32_bits(memlim);
+}
+
+static enum hrtimer_restart dualpi2_timer(struct hrtimer *timer)
+{
+	struct dualpi2_sched_data *q = from_timer(q, timer, pi2_timer);
+
+	WRITE_ONCE(q->pi2_prob, calculate_probability(q->sch));
+
+	hrtimer_set_expires(&q->pi2_timer, next_pi2_timeout(q));
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
+	[TCA_DUALPI2_STEP_PACKETS]	= {.type = NLA_FLAG},
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
+		WRITE_ONCE(q->memory_limit, get_memory_limit(sch, limit));
+	}
+
+	if (tb[TCA_DUALPI2_MEMORY_LIMIT])
+		WRITE_ONCE(q->memory_limit,
+			   nla_get_u32(tb[TCA_DUALPI2_MEMORY_LIMIT]));
+
+	if (tb[TCA_DUALPI2_TARGET]) {
+		u64 target = nla_get_u32(tb[TCA_DUALPI2_TARGET]);
+
+		WRITE_ONCE(q->pi2_target, target * NSEC_PER_USEC);
+	}
+
+	if (tb[TCA_DUALPI2_TUPDATE]) {
+		u64 tupdate = nla_get_u32(tb[TCA_DUALPI2_TUPDATE]);
+
+		WRITE_ONCE(q->pi2_tupdate, tupdate * NSEC_PER_USEC);
+	}
+
+	if (tb[TCA_DUALPI2_ALPHA]) {
+		u32 alpha = nla_get_u32(tb[TCA_DUALPI2_ALPHA]);
+
+		WRITE_ONCE(q->pi2_alpha, dualpi2_scale_alpha_beta(alpha));
+	}
+
+	if (tb[TCA_DUALPI2_BETA]) {
+		u32 beta = nla_get_u32(tb[TCA_DUALPI2_BETA]);
+
+		WRITE_ONCE(q->pi2_beta, dualpi2_scale_alpha_beta(beta));
+	}
+
+	if (tb[TCA_DUALPI2_STEP_THRESH]) {
+		u32 step_th = nla_get_u32(tb[TCA_DUALPI2_STEP_THRESH]);
+		bool step_pkt = nla_get_flag(tb[TCA_DUALPI2_STEP_PACKETS]);
+
+		WRITE_ONCE(q->step_in_packets, step_pkt);
+		WRITE_ONCE(q->step_thresh,
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


