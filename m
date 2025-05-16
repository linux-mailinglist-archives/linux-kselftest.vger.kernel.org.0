Return-Path: <linux-kselftest+bounces-33147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB59AB92FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 02:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8D4C1BC6DA8
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 00:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E241042A9B;
	Fri, 16 May 2025 00:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Nr3zBZFX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011047.outbound.protection.outlook.com [40.107.130.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD7138F9C;
	Fri, 16 May 2025 00:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747353746; cv=fail; b=ISNValZp2t7xeM/Av6eX6pAoXuqzAvRoHLjNPP8lYPfgEkya46IEXuphkvgI/do+aAAPcqIM1uT+ep06FBBZM2i+tKsd0px7NhEne1ucr7HbwvyHXLTOCEyAXlhpDFMuNb75ZWaMF8F500s0pgBQxaWx3c1AM5BNEkxC0CpN784=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747353746; c=relaxed/simple;
	bh=xdxSyLFyOIXTIhAymGBb0hCEyLIUHA9WMMcisE5eMR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j16wFWeWLt2AIwoMDzlQU04l6ddertX/M1OjyvVvtrmEepQR8bcgvPfc4pK+4o8NiAGyE7VkcZXC4wGNIhgBruH6ySS59P77NBFsXaGpPzJldbZ8LytCNo5DQaj56tsjJrLD721kT1yW3CyyhKaiGnC6vzx5WoLysHwhQsH8W7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Nr3zBZFX; arc=fail smtp.client-ip=40.107.130.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBBNp+JDYlpndKUaOUPkJ1z7jsn64CnSRPf5U1anAG1S/6mYDJYJ/YhIwtKMxXYBLiqeEQDnvQy6vMis/r5L+ug4xLs+eoUNQMx1PID7xJfrdeoocCwoqj29ztGN6yXjfJRaluZgSBSb9W4TKiLmqDifiPPp/HQvWc5gSQ+KK+M90FdoxUrjguxzqIb1rS33lJ1s7uK+h2SjQFNP9b877yM+4iy4c5SLFvf9mpuJlRBbNQCys2xe9ULVwSWeHCNkbwnHV3WsjVlqgkM4BiS4gPflqN1AR7h1oRkPE7xK1HnwuOcmkJ5YpSvD4Zi/WqNEBd0gdy0NTYRB+RQIZfYcsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yjs7EfoRvocJyC1N/EOGQqNJcfS4cQPSVORc2zRKOE=;
 b=cPtp0Tu9BI88XTS1rFGHJYdZC9jEETBUqgYSUxd9oVl7n61BnTvpWDpP4P7mf3s2ATzKCX5upqodKVyC53GRM9opxOk5ljO2ioXZOqc+AcWOn2iF/viz46egqglTn0vsac+1WmPUIDOVN3QpMSvLoREbFkIaISZ1HnLMdVA8g9myShtLL5Kqo7akMK0S/EoVmBPaawJVrA2PBsJmZaTaQ60rCKZOTprKl7vmKH0PrhnkHDWBu+Op7bnAaGs4LoP9ZjrG5+c0W3HHddpiv8TC0/oKPX3S+4xxvmYS26iPy3K1TiGCcXClpp/4OGdGbNbhdRAgDgYBLqITEDBz5ogEsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.240) smtp.rcpttodomain=apple.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yjs7EfoRvocJyC1N/EOGQqNJcfS4cQPSVORc2zRKOE=;
 b=Nr3zBZFXWk2SGmNzWV+BHn5LARC9aEKwPPjdorQfCk/GgDMAeKfXa6F0iwq8yWrx7/kGKNaaEIrWgRgCmCErj6/tfL27N/OiZD4iJi9q/VzBY2LX08/Vd94clSzcxeo8vZxo3n0AOiN101KJ8pkN1J9dPXCXpVISv4UVH9FPKbZ/PTyRHZQsk5uEwUT+5LHaWA3BAHm9cpUCm/q9AKmV7eOEOjLcISlBhA8Y7I3IW3/rY7ThMuQ0upLsvIH1hZjRcz+8zyxNNnkAEys0yhbb/h5p/+XpnLjPmpK/FAFzWVYdWD2H2/YeR+wygsQbHrrqjSYT672B9CyIntwCH6TM+g==
Received: from DUZPR01CA0288.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::21) by PAXPR07MB7888.eurprd07.prod.outlook.com
 (2603:10a6:102:13c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 00:02:20 +0000
Received: from DU2PEPF00028D11.eurprd03.prod.outlook.com
 (2603:10a6:10:4b7:cafe::76) by DUZPR01CA0288.outlook.office365.com
 (2603:10a6:10:4b7::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.20 via Frontend Transport; Fri,
 16 May 2025 00:02:20 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.240) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU2PEPF00028D11.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Fri, 16 May 2025 00:02:19 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id CFE15200D3;
	Fri, 16 May 2025 03:02:17 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: horms@kernel.org,
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
Subject: [PATCH v16 net-next 5/5] Documentation: netlink: specs: tc: Add DualPI2 specification
Date: Fri, 16 May 2025 02:02:01 +0200
Message-Id: <20250516000201.18008-6-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250516000201.18008-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250516000201.18008-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D11:EE_|PAXPR07MB7888:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bd23dfdd-ee05-440b-3c84-08dd940ced02
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?HkfExVt/oMDQS9bZOO79zrL9uhOCZSn6o+JESszfX+3CPYofduL8Tu5P/5/q?=
 =?us-ascii?Q?I6eq+hBvnq34eIixq+es+/VphXjmI8SyAu7ktSm0baKRUYsX59RcDhwjtwXr?=
 =?us-ascii?Q?7aL2K2w28+LYTOva/1mq70CPOtzgzIpa472CTzf1Ahj7EcgHOXQRBy4LluKg?=
 =?us-ascii?Q?SXCvpz395l+8NfP5UKz1/wVYOgxVCa2qIoWuJCMBf4RQwRIoDd+pqMl6ntDh?=
 =?us-ascii?Q?zM6Upr7atcsW0FtpX4l1/uqbbd8TamEQU79OFZczU3+9vqrYDuuEJzdtjfHT?=
 =?us-ascii?Q?nMNApwDeSSbRl10gpmblgYMjyHnvkg2FM119vR33tvsX5nbMrREaFMQZ3bob?=
 =?us-ascii?Q?NgsHWpbU5Kcd+Z4tQYuky+QsNO9A0hlXr8VBpZm/JTIjpA5/qhPCP5T6t0Yr?=
 =?us-ascii?Q?bUOt6AKwEd5wU8z8MU/5CWKSZ/HCGGetmPIeDatr1XX1Yo4tkGirY3tqv0Lk?=
 =?us-ascii?Q?EXbZ6u4rlvQFoJmrTPuVjTHZD8kC/SYVUh21GPgcFxVBUWePecuLa3Cczdql?=
 =?us-ascii?Q?TNp43aG5SslwCp8qDH1ZqTeIrE6u469INKas3Lfhc1XaJ1U0e6bwv0683JND?=
 =?us-ascii?Q?87BnvBh83aP9/E+tSW3/aJBr7VJqiF4Zr1nIDQXY5BmcuffIGeKaGqPZuKtM?=
 =?us-ascii?Q?wcifGnMdQpK2BlK0XsB1sl0c8wsVnsV1i1pGj14k5iOc2fc2WYDPlwpzsunp?=
 =?us-ascii?Q?YunSMawd+Q0xKk/JSkYlcTiZYFKW9gvFl+5Fsc13UU+iKQJy8gJKY9kZ+KIV?=
 =?us-ascii?Q?6Ipli4eLGAfcyi3nMQg7fBbVh2+rOkPBLEJ0iDUPfi0OevAVrmIeW4FoawQv?=
 =?us-ascii?Q?2YdtEsKzv+QogtY8yPGEIaHLtPod5K5zQQmJK9HxhFZjYLhdeUArlRKT6Di+?=
 =?us-ascii?Q?V/n68514SNb3EZPGJLDkzL6YmX0ZbCpaBGhVGjZm59ZjqBQED6SQ3u8WuW47?=
 =?us-ascii?Q?ljb8laX2T5nNcnlLXplVMZb061H6IhqZRZhnXErKrS3NicOHmaE5ft/O8D+h?=
 =?us-ascii?Q?DqmUTy3RaYDom32UUVyDqKh/34e1+mjpcdvTInuVND/zWZ1tKuTAeK/9Jf6H?=
 =?us-ascii?Q?kRoBD99EA9ShDjl5SkLQTOZpL7cg5YFk4o3MM5o9QUb2Y5spTdC0jHl5BGO7?=
 =?us-ascii?Q?h/VWkY9qXTgp5nQTr377Nvc9H+UHjN0jSjjXCJBFQWAcy42bQ5Zw6syBbKpS?=
 =?us-ascii?Q?o58knMZRNod59Xw+no4rLvG9nJJ3BSqN72waWQWG6gSQvaWBAJ3k6y/fxsvl?=
 =?us-ascii?Q?vSWCbrnbuGZTot3wzz7pSvXhH7v3tnKJS6VwQ1uyXPnFiDe1DQzBhkQl8mTm?=
 =?us-ascii?Q?Qi+SURJ1B7+WP0Q9LrKihiXxXc0mDQgpb8+K5TgxKd01AhkTco+VhRC4sVCP?=
 =?us-ascii?Q?uCwJfnmHusQCQYaqC7TTh31flpI5Jdwm5RyI79RMp5Yh9WTW2vHpCuzNm17E?=
 =?us-ascii?Q?fsX3vFY0PEkYw3njTjP0rEHaTZGPZpaFjCYqgoeUUv5tEbHpipKFdla7ZWbH?=
 =?us-ascii?Q?yaOz7qTMxx3mpvsSxDpbO/ReJmY+Kprg90Id7Hx+Mx9xv5nUJXLomcfLIQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 00:02:19.2292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd23dfdd-ee05-440b-3c84-08dd940ced02
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB7888

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Introduce the specification of tc qdisc DualPI2 stats and attributes,
which is the reference implementation of IETF RFC9332 DualQ Coupled AQM
(https://datatracker.ietf.org/doc/html/rfc9332) providing two different
queues: low latency queue (L-queue) and classic queue (C-queue).

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 Documentation/netlink/specs/tc.yaml | 156 ++++++++++++++++++++++++++++
 1 file changed, 156 insertions(+)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index 953aa837958b..162c38755446 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -51,6 +51,37 @@ definitions:
       - tundf
       - tunoam
       - tuncrit
+  -
+    name: tc-dualpi2-drop-overload-enum
+    type: enum
+    entries:
+      - overflow
+      - drop
+  -
+    name: tc-dualpi2-drop-early-enum
+    type: enum
+    entries:
+      - drop-dequeue
+      - drop-enqueue
+  -
+    name: tc-dualpi2-ecn-mask-enum
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
+    name: tc-dualpi2-split-gso-enum
+    type: enum
+    entries:
+      - no-split-gso
+      - split-gso
   -
     name: tc-stats
     type: struct
@@ -816,6 +847,58 @@ definitions:
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
@@ -2301,6 +2384,73 @@ attribute-sets:
       -
         name: quantum
         type: u32
+  -
+    name: tc-dualpi2-attrs
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
+        doc: L4S Step marking threshold unit in packets (otherwise is in microseconds)
+      -
+        name: min-qlen-step
+        type: u32
+        doc: Packets enqueued to the L-queue can apply the step threshold when the queue length of L-queue is larger than this value. (0 is recommended)
+      -
+        name: coupling
+        type: u8
+        doc: Probability coupling factor between Classic and L4S (2 is recommended)
+      -
+        name: drop-overload
+        type: u8
+        doc: Control the overload strategy (drop to preserve latency or let the queue overflow)
+        enum: tc-dualpi2-drop-overload-enum
+      -
+        name: drop-early
+        type: u8
+        doc: Decide where the Classic packets are PI-based dropped or marked
+        enum: tc-dualpi2-drop-early-enum
+      -
+        name: c-protection
+        type: u8
+        doc: Classic WRR weight in percentage (from 0 to 100)
+      -
+        name: ecn-mask
+        type: u8
+        doc: Configure the L-queue ECN classifier
+        enum: tc-dualpi2-ecn-mask-enum
+      -
+        name: split-gso
+        type: u8
+        doc: Split aggregated skb or not
+        enum: tc-dualpi2-split-gso-enum
   -
     name: tc-ematch-attrs
     attributes:
@@ -3681,6 +3831,9 @@ sub-messages:
       -
         value: drr
         attribute-set: tc-drr-attrs
+      -
+        value: dualpi2
+        attribute-set: tc-dualpi2-attrs
       -
         value: etf
         attribute-set: tc-etf-attrs
@@ -3848,6 +4001,9 @@ sub-messages:
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


