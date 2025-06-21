Return-Path: <linux-kselftest+bounces-35550-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B97AE2B89
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 21:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AE651739E6
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 19:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED2B2701C5;
	Sat, 21 Jun 2025 19:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="bDx3M7Ot"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012032.outbound.protection.outlook.com [52.101.66.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15B327056A;
	Sat, 21 Jun 2025 19:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750534433; cv=fail; b=gYrr1xv12doZQO5Y6yJhalITgatFNrDm/orqm9Z4ALzNdmrczut/OFTnDvpXQCCJeM4lSxNEymtR1pSzsf2xw+upyQc4rvykzfNo7xJ3pRn4drG4KtaiFrRBGa0F2YL6CNNUTcyfPNsTbE+n0k16cIRiX4Cbrw+XMVoHE46P5EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750534433; c=relaxed/simple;
	bh=zkQK5pqR26rpBNMdKoOUt6Usw0LJw2JF/PVJuSrcE0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7niIUAbp21gVnqW+f2QmhTL6LxzklxKKWm2Watiee/moDoHa+qIkxnt7iTQXIzDyCNUfkKPA6CdL2ZxvEw4w+ivGtjWBpG2cUL+k6+HTADs/Vvtvf5HjwaptVYN88qrtpQWBtuAUqccW90uIc88M1Cbv8mgL50HFyXrw2nzsao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=bDx3M7Ot; arc=fail smtp.client-ip=52.101.66.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylTm7MlhQyn0GAiCKjQ9WGdvWhUTG4zSlZ8VAIl5vWuX+mZqvKOtE/NwatC+5MT6mu422o7bl9rplXIUuNMGilw3DcybBXLoMVguWcVuCCBQ9x+QZcxH6kjtq6Ie1D0DALPgP5N5yyt93gJd/BOa2DPUzYWNpjSON4k8sSGoq/PGj7Xmosf75q/Fp4QT6TNokcpOjB6ajcYt+v3oizbcMaptov3f27k9cbv763kGwJ91tuKjW8dFP03TUvl37p7rARdlpZ9zejhhDn7e7R/hqbA6VEzThYO0wb/AfCUk4yvwULDjg/M6ZoL8QUKh7AeHSnr98VOA7tHrgMoZyFUfIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLnRF1RbcvHpKLq5a0P3Q6UvfSI1er7t5VklcXOnTcU=;
 b=ZJHsbKzoJcy0zTFF02xPayZNS3xG61r9OCIWiuu3L2uTir7U6rxj2FqrUxgrSevjldQ2z6p+uEIaqVloW7x/B8np/pCSGL/HIRCwFj+aYty639Ot1VOD7idjqYptmr41QDXKJiPi9RWv9HGbDOz0TE7AfpqY082epS+7FKl7dnOUvYzZubheWmyaHBZExVS54v1cMeEP4eSiR3isYqEf5kf0+5UQYuRKJde8ZYYT3VCeD7kFcTGuh/3mEK1X9TNOsHm+gPmPLNWnbhfXfoi31XhVK5OE0Zm0a6pNo9sZaJ1Y/tdzkkyyRleTewxkdBbgmSEy1vieeKzcX0MYbJBp1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLnRF1RbcvHpKLq5a0P3Q6UvfSI1er7t5VklcXOnTcU=;
 b=bDx3M7Ot6mzjsuzAFZlzAOpRnlg9nVyw4Ji/evYmP8qqcmncLO/2ZLcoYrh1t8bypfOG6RrSYKziqOLawbbKrabKExVM9wUC4d34zfoBzLPXEkhjaeRlAI8IKBcprzcNatdKcUQ+Jjqdke/kSC5CtM9ibHmk+klRiF3n8F42grnE2j9nUqEgMRo4eDnv5NuYMRluYA76QlwaP01dE+ZTQvZ3ahp7jwGOaRKETZNsdtl/F76jQYdDaJy0XG3v+rt6n/0LUEEcNH5QY6sipomu0HA1Lcw6GEOzxvlnmg09Y3vKFTJKmhPSFursmEGNVqoi3cbi3S6nH7VQO7CUtycMHg==
Received: from DUZPR01CA0011.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::19) by DU4PR07MB10159.eurprd07.prod.outlook.com
 (2603:10a6:10:585::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Sat, 21 Jun
 2025 19:33:47 +0000
Received: from DU2PEPF00028D09.eurprd03.prod.outlook.com
 (2603:10a6:10:3c3:cafe::75) by DUZPR01CA0011.outlook.office365.com
 (2603:10a6:10:3c3::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.27 via Frontend Transport; Sat,
 21 Jun 2025 19:33:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DU2PEPF00028D09.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.14
 via Frontend Transport; Sat, 21 Jun 2025 19:33:47 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id F14C6680010;
	Sat, 21 Jun 2025 22:33:45 +0300 (EEST)
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
Subject: [PATCH v20 net-next 6/6] Documentation: netlink: specs: tc: Add DualPI2 specification
Date: Sat, 21 Jun 2025 21:33:31 +0200
Message-Id: <20250621193331.16421-7-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250621193331.16421-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250621193331.16421-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D09:EE_|DU4PR07MB10159:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e2e268d2-8f62-4495-928a-08ddb0fa8af0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ADDIwWU39S/ckZzYNdrR0H6lklWuA1V+KRZDtxD+Avc08JHrn66EG+wlSfmC?=
 =?us-ascii?Q?gspwIVg3Gc0VVJFyIqkbBXQ79i+t1oShrXZZaZLq4opePUfN8vdB86qS/LWD?=
 =?us-ascii?Q?iMRP4facW9AgzV1qDFguVoCW35fAstXXX+z2ML0KBqFEzHB/BZWu9VrqrCDR?=
 =?us-ascii?Q?IvuyClbs0Ph72muUj+cvrE9hxRbYkbSyIKQfgi9aNGfJVWMIgmhmup/dbJ+S?=
 =?us-ascii?Q?2yZtzVeF/Ej3QEnxXyTiS07c6gJABHd6IBKY9VU7hvjm/zJtkUkxcQRSRGbj?=
 =?us-ascii?Q?2ejUrvRZQPu4T7yMf6QCSAeYlx0abqv8tOAzkqmS5hYdFLxgvZAqtkvOLHuk?=
 =?us-ascii?Q?ajE73Tr1vDQcxPxFQ+0eElgG0ukvyXUKivNxxAppUrU3olOimg1dXGn6gCV9?=
 =?us-ascii?Q?lou77vg+KAV94E7TepN5L9QpqowrD5VsaZ34fAsJ9NXgJKFUGh1lX+/6wMIS?=
 =?us-ascii?Q?TJij0XI8As5Fw4v4MG+XLNqaW0pVGYRJN4zNicbPJ3FhnI15RX1iU4MC8B7Q?=
 =?us-ascii?Q?5iiLlLxXqEIqgXTaPLBGs3Tf1iEOSZjFHr4sWIHNV34G6Y08bo2xTPjmdTU/?=
 =?us-ascii?Q?GsD2dgn1SINrb/gvjfvXWhQaFcI82DWkwTahCwIHtMlUOXw84deY3Z2Og+Go?=
 =?us-ascii?Q?NIVaEXKSi+s8rFARdv5IfxIXI1TSx6TCuH6/n3JesZNtjG34AJjE9fP/bWu6?=
 =?us-ascii?Q?C0qDCbbTFetyyntWYkp2XK8b/SStdbQR26vrCvJ9r0n6yMcygfrz+Sd0a/EH?=
 =?us-ascii?Q?ZX9sQHMkc2Vs4dfdtLnX5yyeaeMRopgz05FaGikE/1/qhJJPqlIeh8kc7BQ4?=
 =?us-ascii?Q?kqboV+mYxzlwwHVrAthk8bV20XM1lX2uXbGQKSz2P2Ig/jyZ6KaMsFUUCmEn?=
 =?us-ascii?Q?qXpvIbcdf8BDAMr2zaySDUVEsIqIiZ+fRbuCss7TvrWqZgX6/xJiVvgmxefY?=
 =?us-ascii?Q?Ern6u8kUlsJ5B+ywF+tVKiNyLAcQQRGkB7pa7wgxMNEi0ZtOvjB8igskjT4m?=
 =?us-ascii?Q?60Y2771e7VqSiwSxi+c08Jlm7VRX0I7v/CIc3PuJOVM8meLUr+OBpi1uFxoS?=
 =?us-ascii?Q?aGCrI097w9k0zXyNkqstz4Bb3fw8xSsN+WAH6djsWWphaRsYLh0k3Fno0IZJ?=
 =?us-ascii?Q?FhQDKzRfVKtYB1FrD5+joonMXyW8E71Y75ds4dXjVB2Kp7ZLjaPVdPOEbXuh?=
 =?us-ascii?Q?MjhnlSzb0XjF9eEzyYgXX9WABbmXfEojKceg3X+st/sCE3GF2yBVT057h2rv?=
 =?us-ascii?Q?MR9kF015DU/E9NdhrDOEMGdPljDNHJEq60ij0Esc00byjJsS1hOJHPUFaRGJ?=
 =?us-ascii?Q?2kcivnXcnOP++mgUM05bZ5AvUAB2FPfLjdSiFn22nQX1bdEgepwAi0EACfEH?=
 =?us-ascii?Q?qJHewYQwvksygGg3Dtr6w4CmXgotrkTeVg7rYF/fWGun1pEqu+QZZkzMiY+H?=
 =?us-ascii?Q?heQKotDj7F3VaLgZ1P+OBxK0KS5i7po1gQ6zUSK/NvmzPIvyXA1N27AjuT2P?=
 =?us-ascii?Q?6SYBh7omr4KAlcw/I1bhtuUWMn8OSQQvlaJD074pzSBZe+vxI8+tY3U+vQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2025 19:33:47.5282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e268d2-8f62-4495-928a-08ddb0fa8af0
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D09.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR07MB10159

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Introduce the specification of tc qdisc DualPI2 stats and attributes,
which is the reference implementation of IETF RFC9332 DualQ Coupled AQM
(https://datatracker.ietf.org/doc/html/rfc9332) providing two different
queues: low latency queue (L-queue) and classic queue (C-queue).

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v20:
- Remove double-prefixed of "tc_tc_dualpi2_attrs" in tc-user.h

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
index 4cc1f6a45001..8a183799dceb 100644
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
+    name: dualpi2-attrs
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
+        attribute-set: dualpi2-attrs
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


