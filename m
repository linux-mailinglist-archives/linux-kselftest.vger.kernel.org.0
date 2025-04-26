Return-Path: <linux-kselftest+bounces-31717-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8D1A9DC82
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 19:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1303616EB5C
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 17:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020DD25D21B;
	Sat, 26 Apr 2025 17:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="fClgVoPb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013013.outbound.protection.outlook.com [52.101.67.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F2329B0;
	Sat, 26 Apr 2025 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745688049; cv=fail; b=kQzn2fNwMpF2L+ObYJQHTb4gTnhM8IeUaRRRQ5q2NnbxXCgnIsawU7fK2vGrAl0PHK5ODSxK1zUo1WNmDskm/ivSuSirhmO8qz5GP6TT9WSD5/bUs32qHMI4wsQ4T/DztiDZv16U67PK+hwtSie80ENE9AOQqEBaslpzxlsGQDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745688049; c=relaxed/simple;
	bh=6+6/QwErxZeZabcU3X5N7lJBZqNQAX5aFJjmLdHyuDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I5SJE2mVEDT6xxa2FYmWmyjG6WTMj12IDh9rsJb2G8mkAf4NFQxvT9x8VKVBjTM/iEGX4u98tWaWzlXdENVZAER89lB6W44z+9qzYSumjuHAcIO2le34ZdcdxBDZ5aEarlpgWa6rYTjKxhMa2wlpe9QFIZfqzKRvOhH7NYo3ls8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=fClgVoPb; arc=fail smtp.client-ip=52.101.67.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6GvEF4S5JtYBOnb6Hl3avkDIp/bbpaNtef/RzvfWNWcg9hkF7G1OnR5PlhIAgKJ+tQqnN991SlfpP4PRd8xnUpwsue1RAxU38hKKs/JgNDpOeoH2RWb823uOsBFsnIbE50V0zBAiNyacjv8eQy7r20JySRo8waIMfkpMeNo857xZYRDVZv0s83XZ+c0hITti++nKYkn9B2s4mblxdtjekbrhUpXc52jIY0rBJjokfyh1vWD/nrkPJOm3J/YW8BQgj/r1+qKVAtBEd1ve+gq8KZG0NIu3BI/tAFxSDfTnPtRsjpiauyPW3ZMmHsCRw73vYq9li5NTiq1j3BxgQMB0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VUjaYA8Uh+F7/dbXG26q4H3NeoAThq+YZD5sRwGXd0=;
 b=RhWreKiePi4jbj0Sl9suIQqBTu/6WQPMgzsUI9yiGDBoYwDTQkIA/ULsP+SygzLrnbf8sQTe5p403mOqQ4gmc8xleZIHmui8vt8gMvG2d3EWGiHFAnLTJPRrsxQQQEZmDF7TXKYTyjtgLj7dZC6/nALpj48Rmdx7v06X+8b2dzYEPyxEk9MuRB5NHIXkIzRDu70WdX6xDawSlyEBnelJlI2NaepCvjrrdmp1YXu6z6RQ9iJ+YmIU1xYqLGonQi6cwwGSZUAn/W7OUwPd4wFGTtnM6HJ4368EAO73u6RsMWc+stR9rdzygGTYail8fteX9ihZSnUHOQMeZ8m5z9dICQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VUjaYA8Uh+F7/dbXG26q4H3NeoAThq+YZD5sRwGXd0=;
 b=fClgVoPbDnvy088ycWI5BiZsm+uKh+zoTtP74pWnqcLidQkUDemh0Y4druzlARY78Xk7Sd1jTLCqq5K5dYezieNDxvXVxgkxKq4yyNup0DpbhtuwcuZJhM9+VpAfZ+YBWdxJ3Rn2ZL6OA5DdV4QSvytL61B73rVnlzbyVCwEUSTZ4t6im8sgvtnAAcHyZjmYUm+j3WXka9HP1tP0/HvsFAxy8rWrND5SyrFp+IKMH+I6qJzNVdkaBnmhZl/0JXLr510tifsdfBaJwtrMjETajSPvoEFhMvHQK92xECUk7tQx2xGnX10iEfBsqun3TQX4G40AIY4K/8eNxzlrF+A+wQ==
Received: from CWLP265CA0377.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5e::29)
 by DU2PR07MB8361.eurprd07.prod.outlook.com (2603:10a6:10:2f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.28; Sat, 26 Apr
 2025 17:20:43 +0000
Received: from AM3PEPF0000A78E.eurprd04.prod.outlook.com
 (2603:10a6:401:5e:cafe::bc) by CWLP265CA0377.outlook.office365.com
 (2603:10a6:401:5e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.38 via Frontend Transport; Sat,
 26 Apr 2025 17:20:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM3PEPF0000A78E.mail.protection.outlook.com (10.167.16.117) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Sat, 26 Apr 2025 17:20:43 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 1DA17200E1;
	Sat, 26 Apr 2025 20:20:42 +0300 (EEST)
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
Subject: [PATCH v13 net-next 1/5] Documentation: netlink: specs: tc: Add DualPI2 specification
Date: Sat, 26 Apr 2025 19:20:21 +0200
Message-Id: <20250426172025.9459-2-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A78E:EE_|DU2PR07MB8361:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9a7bb4d2-2b04-4422-2cb2-08dd84e6acee
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?hW9D2lGLJPEX/w9zkueHdXtJXIX5nMFxjk3gmYZIONvjyat3LxRWNiQlWGES?=
 =?us-ascii?Q?lzcXG07lL0YEtRdH6gsLSGURm/Dt3SI5yZmi3hRT9cZsROdu7fqb0ROgjqLK?=
 =?us-ascii?Q?SMJNjS94Bn5M8/oKvkkzg40IB8xHxcvhzI8tkS1WTe5y8b1zjGwdo55xO/eP?=
 =?us-ascii?Q?Djolp4OBjHAe9A3aeOz4N7O805PrHWXXssEv1AENPiny9eJVOdU6tV4CU5MQ?=
 =?us-ascii?Q?+IiheT6D0lVs9F/YjpPQHyKk+NSqw+GiPUoJlR7kEg6GL1o8rYnqoCk74ghy?=
 =?us-ascii?Q?OD6xrkwtFVdy427vxMlyfjkl9T5dCMhT6GLuQIWe7TEU8Qv7DSwoCPIxWoE5?=
 =?us-ascii?Q?iC3CtHLYRcwlbjb7p08xRc+7MDWYikJxqx3c48jqP5Gxv8qjPBQSXW1mrBYq?=
 =?us-ascii?Q?a2z9tkoCGfzrL/MkMBWt7weF+bsG2aftN9L8FAErgBR6bxGtgcMye/TG3VIj?=
 =?us-ascii?Q?+bet7ytfq3OLiahQbMjZkPjrjAR7yYQNeQa1fLzLcfwYz1dMtYI/vlB1oRkr?=
 =?us-ascii?Q?FL1HD5kQ6WCXGcwC2niH452Rg7H3LqD7aanpwbeyBEgqXRyJJA8DIDRN7RLq?=
 =?us-ascii?Q?6w66U8f1I//TlaNqGARTEH8XtDSg+Z15VItvzt04avSaeGSbWYSsNbf1rtMj?=
 =?us-ascii?Q?eVI0j2cIXljIujRTrOXGFSVc6upkKqgEcfwIQq4qpbICOWFkLvh2dm1qGL4T?=
 =?us-ascii?Q?dy9euDwKSrCYM7sQlJzORT1dM6bKkdxYobh2PesgQNJpFOzryKfaYdpfLMQW?=
 =?us-ascii?Q?ejQo5Jg/7L14YzXAqMovPSJHKTtPC9+DaocdM5ltF9pKi9BkhwNor2K5r/J3?=
 =?us-ascii?Q?JYc8qHCcO+VtGdZVaw3yG81u83vHXTNNrROFfp7jm3LKoMK/+CY/7InKC+kk?=
 =?us-ascii?Q?kdLxZK9sployzA6iqd9MW80x6rHqq9dqvLksb3cSIFhyKc77y6st/qrjZKO+?=
 =?us-ascii?Q?adzQGaWF+I1CJXvJeGU7vwaMaWTy3L259PG7/kOcGWxRdTsOiRv3yv0ImHaY?=
 =?us-ascii?Q?/r0zA2fS3kjmQLzGQHc9AyMtiWFe7NH1SzM1knW1geoDt2lBAkKONntfvxQ2?=
 =?us-ascii?Q?gKB3Xtin1A5/tgk8bzrEQkoYmV3XB+fF9w9fRerwfeGFzLQLO6m00VSaI+Qx?=
 =?us-ascii?Q?ibzoyUvCjse9ePv2tBybOHzmdBxQ8IGPnKih98I8Jpu9nWIvENtysqnZkHK7?=
 =?us-ascii?Q?3KMtBVS3NjQvj20JswFHUcLa+SXThuyBxJ4KkSZeJiRJlPQdfqi0uINUNWNA?=
 =?us-ascii?Q?q+PN+R8JetQktb5qxBes7L7FAzpioYtwWVbt/51lVIESwHxZR/vKi9t7th1p?=
 =?us-ascii?Q?CfoSN6rAYTW91Ov4ZreCRRqGhUKgkx0VDcKj80Wm8qPdPS96ZpVtaO/IBltp?=
 =?us-ascii?Q?ZUauVqC0Vah0pTCuWnEOZmsfP6ahcPPbs6Bjm81SO8tnQjAQcHJSgJk+VjlU?=
 =?us-ascii?Q?RhVJctFRLsAhGuU+y8L1WiztmHvNk10FA3uaVPK/95nyjcsU1oXIlYUCrZrp?=
 =?us-ascii?Q?BrJ+WECY4eX+o/5enF2k3rz5mIRK+l/Ca8S3aKN7lscdXyfW9r0XKj9fmg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 17:20:43.4175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a7bb4d2-2b04-4422-2cb2-08dd84e6acee
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A78E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB8361

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Introduce the specification of tc qdisc DualPI2 stats and attributes,
which is the reference implementation of IETF RFC9332 DualQ Coupled AQM
(https://datatracker.ietf.org/doc/html/rfc9332) providing two different
queues: low latency queue (L-queue) and classic queue (C-queue).

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 Documentation/netlink/specs/tc.yaml | 166 ++++++++++++++++++++++++++++
 1 file changed, 166 insertions(+)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index aacccea5dfe4..9eaab15cc216 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -51,6 +51,31 @@ definitions:
       - tundf
       - tunoam
       - tuncrit
+  -
+    name: tc-dualpi2-drop-overload-flags
+    type: flags
+    entries:
+      - drop
+      - overflow
+  -
+    name: tc-dualpi2-drop-early-flags
+    type: flags
+    entries:
+      - drop-enqueue
+      - drop-dequeue
+  -
+    name: tc-dualpi2-ecn-mask-flags
+    type: flags
+    entries:
+      - l4s-ect
+      - any-ect
+      - none
+  -
+    name: tc-dualpi2-credit-queue-flags
+    type: flags
+    entries:
+      - C-queue
+      - L-queue
   -
     name: tc-stats
     type: struct
@@ -816,6 +841,64 @@ definitions:
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
+        name: credit-queue
+        type: u8
+        doc: Current credit queue
+        enum: tc-dualpi2-credit-queue-flags
+        enum-as-flags: true
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
@@ -2299,6 +2382,83 @@ attribute-sets:
       -
         name: quantum
         type: u32
+  -
+    name: tc-dualpi2-attrs
+    attributes:
+      -
+        name: limit
+        type: uint
+        doc: Limit of total number of packets in queue
+      -
+        name: memlimit
+        type: uint
+        doc: Memory limit of total number of packets in queue
+      -
+        name: target
+        type: uint
+        doc: Classic target delay in microseconds
+      -
+        name: tupdate
+        type: uint
+        doc: Drop probability update interval time in microseconds
+      -
+        name: alpha
+        type: uint
+        doc: Integral gain factor in Hz for PI controller
+      -
+        name: beta
+        type: uint
+        doc: Proportional gain factor in Hz for PI controller
+      -
+        name: step-thresh
+        type: uint
+        doc: L4S step marking threshold (see also step-packets)
+      -
+        name: step-packets
+        type: flag
+        doc: L4S Step marking threshold unit in packets (otherwise is in microseconds)
+      -
+        name: min-qlen-step
+        type: uint
+        doc: Packets enqueued to the L-queue can apply the step threshold when the queue length of L-queue is larger than this value. (0 is recommended)
+      -
+        name: coupling-factor
+        type: uint
+        doc: Probability coupling factor between Classic and L4S (2 is recommended)
+      -
+        name: overload
+        type: uint
+        doc: Control the overload strategy (drop to preserve latency or let the queue overflow)
+        enum: tc-dualpi2-drop-overload-flags
+        enum-as-flags: true
+      -
+        name: drop-early
+        type: uint
+        doc: Decide where the Classic packets are PI-based dropped or marked
+        enum: tc-dualpi2-drop-early-flags
+        enum-as-flags: true
+      -
+        name: classic-protection
+        type: uint
+        doc: Classic WRR weight in percentage (from 0 to 100)
+      -
+        name: ecn-mask
+        type: uint
+        doc: Configure the L-queue ECN classifier
+        enum: tc-dualpi2-ecn-mask-flags
+        enum-as-flags: true
+      -
+        name: split-gso
+        type: flag
+        doc: Split aggregated skb or not
+      -
+        name: max-rtt
+        type: uint
+        doc: The maximum expected RTT of the traffic that is controlled by DualPI2 in usec
+      -
+        name: typical-rtt
+        type: uint
+        doc: The typical base RTT of the traffic that is controlled by DualPI2 in usec
   -
     name: tc-ematch-attrs
     attributes:
@@ -3679,6 +3839,9 @@ sub-messages:
       -
         value: drr
         attribute-set: tc-drr-attrs
+      -
+        value: dualpi2
+        attribute-set: tc-dualpi2-attrs
       -
         value: etf
         attribute-set: tc-etf-attrs
@@ -3846,6 +4009,9 @@ sub-messages:
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


