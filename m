Return-Path: <linux-kselftest+bounces-32804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FB8AB1F4F
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 23:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79FE2A26DF9
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 21:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4273E262D0B;
	Fri,  9 May 2025 21:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="iHTbhJyU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010021.outbound.protection.outlook.com [52.101.69.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C8123A990;
	Fri,  9 May 2025 21:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746827303; cv=fail; b=m+5NL/Dawl+Q9ugQeD2/MuK+TDGgAvM3sF133BTra+6raB1VRjYs8SG7epvyKcg6Nt3xh0wUr+0OVstDRcasFgfgV7h6wuTpn0Ky5RNTWnLgII3n/vlMMOJA7ROerjVZVn8L5mliKLfkCAv7r6S1rdlRUKEbwgds3ZVJCNTWkZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746827303; c=relaxed/simple;
	bh=OoohXdZZVBCSCC6xZof74mAr8ZN0zT/IhQMNsb0R0Q0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N3/YdmO0L/Sw7/Xvqe/tkqZs+Hsutph4J+ufgBiYTePYtQGsot2sXb2VAftcMi/yZJMMA+H5ObqoMFB/TSpf/4h+aelOSNUPGQwTzpSz/sA9eSyw7/MsBfDD6KNWIdFF2JoFNuAlf3qEFbVzw/3oT0WuMuJL3XhjiHTbU8M5rho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=iHTbhJyU; arc=fail smtp.client-ip=52.101.69.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y45GKmWFawhNXsaLDd838XC7Rk0m2NK3+WI9/3JRwXQc3Fhn5KPValBZTQIAWhlTDkU1i4QHA+Bkhi+qmDrGPMmbp2DYKrvq0nwV1idg7NcRYFnKZhZ3enIqaXxuW5jfOkL+yhm/ezVJDnvmphEjuvt2Iq29OrctI2drer3c8MqhK/XrJYwyoee8S1EO9kZOz60e5l9izVfWL4VIBFOvzFaqOsrVdU6/TGw3YR4cNqLrs7NdWU5YMUH/gQrTT6EKakdV+qAuDbhI5gyLtv5KXp3SUvWQ1NFFBsRgERn1BTa4CU4/G+cZ83r3ktcGhiJN41mn4hWaU8Sr9CWXP3Ap4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ItrC85p1Pp0Pp3glIxMrAKti6jItpYmnYd2WYmVlCs=;
 b=Pvgy/QvYiZdrIByLPBiyhGNCM5dOlzioBlD3geCHYU6alp40tNU0mY9TuOQAElvc09MMvC1F+51xkKKhypvKstEZQX+xXOg+kYXL+BuesNIE+CDFjMJr4QYUWI9KXvQHdvdgMRXPhMw1NtNM1LVW/Kw8f726xMHvVgEf5jc1+dO7yx4je/9C8c4HfsEL1BrS4SZCempK1c9vk4XGflmTvRu18CMO6TsNZLHV6Czmu6iBUV4K9CV/OgfzfP4/x0H+pWpkh4Mt6TCNdimWBfzJRHM0c4V7mgAFURL0wwzlSYE1a1IxDOFeEUGdVQ4ieoIfPGD1gJW+4mZLGUkk+jsoYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ItrC85p1Pp0Pp3glIxMrAKti6jItpYmnYd2WYmVlCs=;
 b=iHTbhJyUCmfAGrLRmhCwuyYqQ4xcFb5g1QDBtbkveQBvzuDu55mGeWiLvMI0fU1rbu5WdAuAE8Vbkp0dm4ph9GU7rTS/sqvsNTkId8/g5ReV1+WITvzb55uYc/1tB2iFinxY0u8Zbkzrlzk8Tl8PtffJ+p8tyJedah4jcc6gksRaL0sDOCAhy5jnVAdBDdQuHSpj7XB1eL8mkXR0DEgUFjPaiytdL8jk4+yuBe1yX2KGBBFbChLPkOlMU4GEbC2s5Ae1YBXF/mK4LiphR0kV7L7a7PrHXQXosZ4aRSWo75vxxM1Zchwpbnh4c7eygwcXYsRf4x2N1/5D/GZTqW1OEQ==
Received: from DUZPR01CA0139.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::14) by DB9PR07MB8474.eurprd07.prod.outlook.com
 (2603:10a6:10:36e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Fri, 9 May
 2025 21:48:16 +0000
Received: from DB1PEPF00050A01.eurprd03.prod.outlook.com
 (2603:10a6:10:4bd:cafe::1f) by DUZPR01CA0139.outlook.office365.com
 (2603:10a6:10:4bd::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.24 via Frontend Transport; Fri,
 9 May 2025 21:48:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB1PEPF00050A01.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 21:48:16 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 549LmPMs011840;
	Fri, 9 May 2025 21:48:37 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: horms@kernel.org, donald.hunter@gmail.com, xandfury@gmail.com,
        netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
        jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, andrew+netdev@lunn.ch, ast@fiberby.net,
        liuhangbin@gmail.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v15 net-next 5/5] Documentation: netlink: specs: tc: Add DualPI2 specification
Date: Fri,  9 May 2025 23:48:01 +0200
Message-Id: <20250509214801.37306-6-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509214801.37306-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250509214801.37306-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A01:EE_|DB9PR07MB8474:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 44eadb78-4107-475d-f39b-08dd8f433480
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?Wm8mQDCosGCrMUTOQrZWsvhpB8IIqcRmIUDMOMa27Sry+c8M0M8XQr//Dc5p?=
 =?us-ascii?Q?Q67LhT7SVtICwf4DEXSlB5u18zfU7AoAPiijojpDlQwHcnlINusLxzOeXwGR?=
 =?us-ascii?Q?hJRNQgOJM8nsnfCsBZoPFfJXxLtLsgUOsco6GYNpsegqg+6s1eT6hy7uNzsl?=
 =?us-ascii?Q?Yz1s7il267fGcZwn9akWfeHmLlKbsboyb3V+cWgW/XaXtwReHLqavVX5tq9I?=
 =?us-ascii?Q?rJ7saxwEtaAnWzhU4c4SHo29X9U43gj8VmW1wgiUIZFIwACyb1UtJNK6C77C?=
 =?us-ascii?Q?WaoQqyXd5bFxJrvOUVvCF+yTKc9ccVFeBOp/sacQOLLa8mLBwk9kQazbe7o7?=
 =?us-ascii?Q?uHoYJMlaj3GpqLN3pk48ZX1bevvw/BDO7fUsIAHfEmGS7hdoYtd9kfjedkh5?=
 =?us-ascii?Q?6AmieBX8EFIKVL6ExWXvkcE5Kf8JZak5rTgIvjhwWD9ExpUXI1EKFsthk9VU?=
 =?us-ascii?Q?Q4fsibzzH0m6ElKD8/Q0qlgX6wZlaYP9ra5BobCv+a+rxDu3Uu2ZYlqb5rgO?=
 =?us-ascii?Q?HolHsQXQ//bbjv1RVVuaNS3f050QXuz4x0YBlYTWW+Sdy/mTd8hkOrBF2njh?=
 =?us-ascii?Q?oq+bNAS2KR32kXr1mpnGuAzXmyv07vpPNXzIKbLEZWFAGWLYuDHfFuTSWNQr?=
 =?us-ascii?Q?02cdXF1TM9b+SYY3TuaD7BbfslvZcZ5Tx8y4QLov8UpDIwY83EsD2A1tbgbN?=
 =?us-ascii?Q?MjY6iry4D9ffGt3jwtbHiKdJgBXyLuHwYA6oLi8oiVEMC99/x1VEIrMsTZlD?=
 =?us-ascii?Q?XtLEmGlpU4S8ejfZzhtCtVvttxgDzv9pIv4OMWer72Ja+wZKdmHOa4UQs/Ra?=
 =?us-ascii?Q?ypIILJIxQ/8nvDNJTEzbRriaoAW8G+0wAe3olZX4aQDhGwU1mnQkRBzL1WlU?=
 =?us-ascii?Q?PZ9mCNA7QoigB5OiQlN5zZaACfS9EcPbJX05PIelOhgIqCm6+kdU6K3EBB/a?=
 =?us-ascii?Q?7fb+xDJJCugJqPiPli3iHFCYKbEM7rmoRhfya7ig6KSTUWp74W/8Ad35op/S?=
 =?us-ascii?Q?lmZs5xmGWm3kv0ugTnpYzZRzkkuTST8QUBfHpPsEz+nfhdCCKEN6nm8/36eq?=
 =?us-ascii?Q?imyukjXh+U7abLbc1lZqFQC0QlivyIkwcVu9QGZUxvCjQSdNWMlLPFmFe9do?=
 =?us-ascii?Q?itCWrRPQz9S5cJM5MlxTadn5tmrPfUw0r6qVeBfesNpmJ5OMs5cTDwolmpjz?=
 =?us-ascii?Q?Y4GyjPOZIJImBh4kpQePDKePpn/M6Z2zucPsfFY+fLMlNB666zLECarPi0zf?=
 =?us-ascii?Q?0cO5nGK3Qx7GNU6Vl9XsHzlpHEWJ4z7/610S1dTfWY8FCwzNhypji/YOg29l?=
 =?us-ascii?Q?Lwm8GIPMXSYMf8S6bS81RPrhN5R/vUhhgfAG0sTtig4vt6nkJn0BpASI5vqZ?=
 =?us-ascii?Q?GIhDibYp3cdkz7SkXGIVL3gyZF1bKJFF8m9ZItLXzURe8TIhsvhANILEFrTT?=
 =?us-ascii?Q?NQXvpVV8uY3jdw9pw4B7r+fnhc1TFAdfyZUe/oTuNOJOIvM8HFK1cU01kasC?=
 =?us-ascii?Q?8W3bJ2eE8yUCZd/k31mHGPHX8uu8HL5ZhXxLQXEbkh3TsjtKW+XboCXQoHZK?=
 =?us-ascii?Q?XEEpL8WUeJy87OiVxos=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 21:48:16.1820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44eadb78-4107-475d-f39b-08dd8f433480
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00050A01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8474

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
index aacccea5dfe4..d9398c91aec1 100644
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
@@ -2299,6 +2382,73 @@ attribute-sets:
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
@@ -3679,6 +3829,9 @@ sub-messages:
       -
         value: drr
         attribute-set: tc-drr-attrs
+      -
+        value: dualpi2
+        attribute-set: tc-dualpi2-attrs
       -
         value: etf
         attribute-set: tc-etf-attrs
@@ -3846,6 +3999,9 @@ sub-messages:
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


