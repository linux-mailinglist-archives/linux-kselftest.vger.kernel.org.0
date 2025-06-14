Return-Path: <linux-kselftest+bounces-35016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98292AD9E46
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 18:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F6A33B81D7
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 16:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CBA256C81;
	Sat, 14 Jun 2025 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ht9OXUTY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013002.outbound.protection.outlook.com [40.107.159.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D742E62A7;
	Sat, 14 Jun 2025 16:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749917366; cv=fail; b=mCAYWt1g2RnZujKPKKZdcmbYK5SE9uSP/Hr44L4hWhTQXB80yG/1eoAVOzPItyyhWclCg1e+G5eynU3W9KNTBlA9CST8iTBz3ILFYkMeTk3FG9fMRwnH1puuGJsKJYXy1aVbp/Gmr6+eoc2GNzdmoz8e6BsW1T/qxYXmaNzBZSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749917366; c=relaxed/simple;
	bh=cgbAaC8RE23M3UEuXEUwWRROlh5Ds6LijXO0Dc6Onjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXurqwwi+Be+QuUhfB8MZ9H+pVkJ/mEPkPbF8lSg2gAaMWmRfcsnX+ZUZvTlY1pvkq/rdxh/4vTf44/B8FV0bXk+EQD0xft18Sknf7xsP6NLf4zGxwnCh1sr3ISQf/1AjGRqqCzOnGe6y8r78Sx0fb21K+hUoPGh6dOPpoTXONc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ht9OXUTY; arc=fail smtp.client-ip=40.107.159.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yCt2DLsu9ixUCs8YqUnj1Vw6zV/Mdx+zc208EdjOLXznj5JcKjVX6KMDRGz0V2Aew2ed7nr8Jo3R6o9hYs/zdnb3zHDMBC3dtueChk9Sbfazy7ZnkMp0DzalsYl0DPhQUNlLjf+EBiEDAIatDld+UJiHnParXB3CsYzYhk1/tNoJz8F4b3brc+ILwAIT7DVGiptZr1YJ+sh3TolDfL5A4MHj6Qd4qfgexoKIIsc8f/WjtffqigN7CmEVQTJc/tYJtG/CxrAsIXad2OCM+thHYnk0T76LL94qDHeIk45ieObRbT5zaR0HmuikVfLeMDMhzZNdhLb2WKAqsqJ8XFfvRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t599j5plMJYroq013xu4Fxwv+tNn3u4SrrkWt3rd+cs=;
 b=l1NFOiV0VjZ7XWyJZEj2sxny7A3zsQe7pb5QlTQV9map8p3LN9XdNejXQ4Fv0ThEbpUfnwwY23B5VYUMJ6AuDWNUW/wBfCvHvL2j7j/5Lh+PNemPM6QHvNyCnIWhkuzDMmBGQD10TfXKcPGSx6PBdTHAS9VXzk6hHW7kqY+4yz13zn/TTiy2o0d3Qkvgu0c+XBwR/CvD7tObMALnH8C2N0kyaSdT7+ry6yX6FoiYLb4KWTfuKa9Tp6SPWP02USCs1fE6L/E0joKzsYjy/r4eXeUPSqrMCsN1oSp73IT3z/P2R+EnHDL+B1h9gb6ImISItqTGyvqBBO1kQkRYm/9DVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t599j5plMJYroq013xu4Fxwv+tNn3u4SrrkWt3rd+cs=;
 b=ht9OXUTY/eXtysPiamFFgLx8v9OWU88LJgLjhjRTc+/LroY1oshU+cL3GXExOc8HvKiYBa9z3jU6zV0D6knI4OxOce9ECTOuUNpJYCugiGqZuVh3SOsl9HuwXVL3dmO/ltmrhbcCK0FG5SMhtVdtDJYm34KW566SbJ7lGlwwp02ePA6Emdd8j+U6JvPfMM1HdAFt0slZDYmggYOrUyaSUvOr7D+sLcclLYOzlzb+NqQx4DQV/c8sj3Mlk3TDA4zWVoY82u33QW6BznO/dowP3hTqg4Gm0/4NlFYl1/IDSvUwuQP+hE/VnFo7UYym0f7fx0S4+oyvmNIKEzEzl2oLdQ==
Received: from DU6P191CA0072.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::25)
 by AS4PR07MB8827.eurprd07.prod.outlook.com (2603:10a6:20b:4f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Sat, 14 Jun
 2025 16:09:17 +0000
Received: from DB5PEPF00014B92.eurprd02.prod.outlook.com
 (2603:10a6:10:53e:cafe::69) by DU6P191CA0072.outlook.office365.com
 (2603:10a6:10:53e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.26 via Frontend Transport; Sat,
 14 Jun 2025 16:09:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB5PEPF00014B92.mail.protection.outlook.com (10.167.8.230) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Sat, 14 Jun 2025 16:09:17 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 526CC200E8;
	Sat, 14 Jun 2025 19:09:16 +0300 (EEST)
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
Subject: [PATCH v19 net-next 5/5] Documentation: netlink: specs: tc: Add DualPI2 specification
Date: Sat, 14 Jun 2025 18:08:50 +0200
Message-Id: <20250614160850.11087-6-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250614160850.11087-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250614160850.11087-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B92:EE_|AS4PR07MB8827:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c71e0df1-9964-4e22-b291-08ddab5dd0b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1875L6giQzqc5t0eNLyAP9vpWvncPBdZGZoeqjOhsSaLTUYO+8/ZduBVfCVx?=
 =?us-ascii?Q?pn0/kCHaeED1MIfU+NEGQZmxXPYY7cfc3FnW39HmmJwzsIzm+4KaOeWKR59A?=
 =?us-ascii?Q?rl2vgNum2GGxvv28LSYQ19iTN6BUbUXcnJyafiKtVroL0LHAjjgVhi94+Fj5?=
 =?us-ascii?Q?OR50z3xkHk43rSzOrSj0TCx1Ti9T1V7+3iKxLgbO8IAB4FNBLYz6X5pmoPfH?=
 =?us-ascii?Q?rj72bOsbOVrakkGzbvdFkkX3PivdSfDumVU8uzUVBh9+TROpOYwZ2G1s061F?=
 =?us-ascii?Q?IFqlZcoHaeU/FSWEnravEAaukvudYwLkG0UNxbonYzWh/dUII3Vkgrje3gLa?=
 =?us-ascii?Q?cQtUmSXdrBoqiYe4Lkf/w53AjGmUxCu+upMM1MjCnEnChjUEo04x9qQVvTCF?=
 =?us-ascii?Q?w6gmiFMSdVxYM2/QVv6GQ+KdMDN+qtq4q5eDg+SaOP6/T+RFkUSjjzrEaxI0?=
 =?us-ascii?Q?DJmpbTOXfSAWr+iuXOeZTFas3FptLAdaMfzYwOBJOoXJqSEJjOU7iW4epOB6?=
 =?us-ascii?Q?C8hBrAfyJ3m/LZ+ctuannL0uwnUHL629uPhv76x9RreiKTHVDgcRUweHixRb?=
 =?us-ascii?Q?mQdQhfGShfLrUoO5IOEqb9uy0hk2RYEubx45HazM7Q7ptpBu2Tg7dL+Lf6Bm?=
 =?us-ascii?Q?Cz2DetWZq8iWjimeqC+RhThqf8h907KoAi7OMDGpvtoYPrJgEK/2PNt7tDvp?=
 =?us-ascii?Q?5AWxG0MwSR1L33JbBLHJIe2HI9E01eaG76yfrBpxXarh7O0d4FBfVbpCTNnB?=
 =?us-ascii?Q?WkXNstlDO0hzZbgXU5W3dnL+Ilc5/b259/eF4Fv0XF8FxqHGSmni9vLagUNN?=
 =?us-ascii?Q?CD52aXBaY8u/ZHixPgy5aOyr/FtifWpezCSEPxIeAAxkkZEnbGtl/sNr/8iV?=
 =?us-ascii?Q?PXn4vDihcgE+sI05lPX7Tm5RBxeRO0Ci19Lo5Mt/EdJdm3oiZ3j9rdjz/87R?=
 =?us-ascii?Q?2A7nUuMkBz0J4W1xJAsI4VoEUGjQvBkKn7ye393SvtM5KIobBiX2Z3ANObC5?=
 =?us-ascii?Q?CxuDLr4jiwAjAC9++Ov18S6dtdUsr/Z3dtb3VR5iEVTS19YpKTjlrEviEio/?=
 =?us-ascii?Q?ehGjs5IrcF/W4gRAi8qYSPflwShfdtJJvJxXcMKvL+v8hF43873FNhNG5Wl+?=
 =?us-ascii?Q?ZShnm/gDWdey4yHR2L4FmYygpXxyTE5BZ7YBTlc3YxQU0UoI9rwJKk7M9iqx?=
 =?us-ascii?Q?D+RnvuF4ePqx9w+fQTPGqEIk8VTsI6eO5juJ2X6MmmAHEq9kMoYpWKe6SmPG?=
 =?us-ascii?Q?jItsOO+2iCTNjFk+DzWS9oZdvbXa6jLy2t5f+TglNRcUvcgus6qHVn2+U5so?=
 =?us-ascii?Q?0YaJbRG/rCgvGC3503XTK8DrLBV7eG5Laajn7CBWFzKw8+OemdMtiwI6YPvK?=
 =?us-ascii?Q?3UK4eOLWACwA2TWgTcxH928Kxc2e91n2B5Z5nhrnikj82EEENcinYNhSSd9y?=
 =?us-ascii?Q?ytn69Zwc/23fAeMVO9kHbvdXOnIHxtn9Gekvv1EkRIxc7fsYfvNyRmSmHXKo?=
 =?us-ascii?Q?o4pJDgf12A7Tpo5/ZNI/4IstXOeePzYRcVEpoWDKC1KaPuBiUejqBfmFYA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 16:09:17.7811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c71e0df1-9964-4e22-b291-08ddab5dd0b4
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B92.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8827

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Introduce the specification of tc qdisc DualPI2 stats and attributes,
which is the reference implementation of IETF RFC9332 DualQ Coupled AQM
(https://datatracker.ietf.org/doc/html/rfc9332) providing two different
queues: low latency queue (L-queue) and classic queue (C-queue).

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v19:
- Wrap long lines to within 80 characters

v18:
- Fix name and name-prefix of DualPI2 enum and attribute

v17:
- Rebase tc.yaml on commit ba5a199b2401d and commit f9aec8025ab5f
---
 Documentation/netlink/specs/tc.yaml | 166 ++++++++++++++++++++++++++++
 1 file changed, 166 insertions(+)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index 4cc1f6a45001..8fe91e887c27 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -56,6 +56,41 @@ definitions:
       - tundf
       - tunoam
       - tuncrit
+  -
+    name: dualpi2-drop-overload
+    name-prefix: tca-dualpi2-drop-overload-
+    type: enum
+    entries:
+      - overflow
+      - drop
+  -
+    name: dualpi2-drop-early
+    name-prefix: tca-dualpi2-drop-early-
+    type: enum
+    entries:
+      - drop-dequeue
+      - drop-enqueue
+  -
+    name: dualpi2-ecn-mask
+    name-prefix: tca-dualpi2-ecn-mask-
+    type: enum
+    entries:
+      -
+        name: l4s-ect
+        value: 1
+      -
+        name: cla-ect
+        value: 2
+      -
+        name: any-ect
+        value: 3
+  -
+    name: dualpi2-split-gso
+    name-prefix: tca-dualpi2-split-gso-
+    type: enum
+    entries:
+      - no-split-gso
+      - split-gso
   -
     name: tc-stats
     type: struct
@@ -825,6 +860,58 @@ definitions:
       -
         name: drop-overmemory
         type: u32
+  -
+    name: tc-dualpi2-xstats
+    type: struct
+    members:
+      -
+        name: prob
+        type: u32
+        doc: Current probability
+      -
+        name: delay-c
+        type: u32
+        doc: Current C-queue delay in microseconds
+      -
+        name: delay-l
+        type: u32
+        doc: Current L-queue delay in microseconds
+      -
+        name: pkts-in-c
+        type: u32
+        doc: Number of packets enqueued in the C-queue
+      -
+        name: pkts-in-l
+        type: u32
+        doc: Number of packets enqueued in the L-queue
+      -
+        name: maxq
+        type: u32
+        doc: Maximum number of packets seen by the DualPI2
+      -
+        name: ecn-mark
+        type: u32
+        doc: All packets marked with ecn
+      -
+        name: step-mark
+        type: u32
+        doc: Only packets marked with ecn due to L-queue step AQM
+      -
+        name: credit
+        type: s32
+        doc: Current credit value for WRR
+      -
+        name: memory-used
+        type: u32
+        doc: Memory used in bytes by the DualPI2
+      -
+        name: max-memory-used
+        type: u32
+        doc: Maximum memory used in bytes by the DualPI2
+      -
+        name: memory-limit
+        type: u32
+        doc: Memory limit in bytes
   -
     name: tc-fq-pie-xstats
     type: struct
@@ -2284,6 +2371,79 @@ attribute-sets:
       -
         name: quantum
         type: u32
+  -
+    name: tc-dualpi2-attrs
+    name-prefix: tca-dualpi2-
+    attributes:
+      -
+        name: limit
+        type: u32
+        doc: Limit of total number of packets in queue
+      -
+        name: memory-limit
+        type: u32
+        doc: Memory limit of total number of packets in queue
+      -
+        name: target
+        type: u32
+        doc: Classic target delay in microseconds
+      -
+        name: tupdate
+        type: u32
+        doc: Drop probability update interval time in microseconds
+      -
+        name: alpha
+        type: u32
+        doc: Integral gain factor in Hz for PI controller
+      -
+        name: beta
+        type: u32
+        doc: Proportional gain factor in Hz for PI controller
+      -
+        name: step-thresh
+        type: u32
+        doc: L4S step marking threshold (see also step-packets)
+      -
+        name: step-packets
+        type: flag
+        doc: L4S Step marking threshold unit in packets
+             (otherwise is in microseconds)
+      -
+        name: min-qlen-step
+        type: u32
+        doc: Packets enqueued to the L-queue can apply the step threshold
+             when the queue length of L-queue is larger than this value.
+             (0 is recommended)
+      -
+        name: coupling
+        type: u8
+        doc: Probability coupling factor between Classic and L4S
+             (2 is recommended)
+      -
+        name: drop-overload
+        type: u8
+        doc: Control the overload strategy (drop to preserve latency or
+             let the queue overflow)
+        enum: dualpi2-drop-overload
+      -
+        name: drop-early
+        type: u8
+        doc: Decide where the Classic packets are PI-based dropped or marked
+        enum: dualpi2-drop-early
+      -
+        name: c-protection
+        type: u8
+        doc: Classic WRR weight in percentage (from 0 to 100)
+      -
+        name: ecn-mask
+        type: u8
+        doc: Configure the L-queue ECN classifier
+        enum: dualpi2-ecn-mask
+      -
+        name: split-gso
+        type: u8
+        doc: Split aggregated skb or not
+        enum: dualpi2-split-gso
   -
     name: ematch-attrs
     name-prefix: tca-ematch-
@@ -3708,6 +3868,9 @@ sub-messages:
       -
         value: drr
         attribute-set: drr-attrs
+      -
+        value: dualpi2
+        attribute-set: tc-dualpi2-attrs
       -
         value: etf
         attribute-set: etf-attrs
@@ -3875,6 +4038,9 @@ sub-messages:
       -
         value: codel
         fixed-header: tc-codel-xstats
+      -
+        value: dualpi2
+        fixed-header: tc-dualpi2-xstats
       -
         value: fq
         fixed-header: tc-fq-qd-stats
-- 
2.34.1


