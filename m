Return-Path: <linux-kselftest+bounces-34584-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E33CDAD3940
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 15:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9987B9C312B
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 13:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C222C0333;
	Tue, 10 Jun 2025 13:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="eHolMo1k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010035.outbound.protection.outlook.com [52.101.84.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE1C29CB32;
	Tue, 10 Jun 2025 13:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749561385; cv=fail; b=Z/1Di05iw3iqFQYgDeAF9QpHueAsvbeg5lVSNiPwUICwXzK8Oclu1MUX3jR3hlNDcPi4Vr99pyevWXJUgEoiIVbv+2+HxU4CiaUlUqq3/wi1mkSeB1CPqX8xAJfU3fzb0cNPZL8AQJFc6gcOJHLzD/rp8rjMvklX91pxvnzjZ6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749561385; c=relaxed/simple;
	bh=hLCYnrVuwoduCLUbqkPSjHb65SPeNMhDXd5OveZiOcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aoNR8PMZi7TVt9rkBpRgRAnMzzO0NDcETB+fvyw7cOsMh5JK/uz0pQas2jAz8M6if/YCNro0Gaf6qFcrRZB8v0zRVEdZP5x3VfLqrt01ZukJhvWx/5j8+KSGEdOA3Ihi5gNmiEy774gkeDGEB7Pe+1n3O3ZwjQIyM9UsDEfKwx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=eHolMo1k; arc=fail smtp.client-ip=52.101.84.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jtGNmdSR/OIwfR41B14Wiz1KYLNut4JPxpxsxFXLg9/HgIJTbwZaBwI9Qqy+NPUrReJ0S7wuEwgcUAvv6y7l3T8bWiFpjHwSUcklcFLMdDTfW1vtpLIFwTc3/xJGkRcNka4cPt4RsxENwr4+c3ayfc7iMf5PrnZN7a/HwOlWO9IK67wScWFuy3wdFNw3vFuOHxN89e2Iaf4UTdG5u+2TpN1+o4rlFOuYbI1OSoo1erdlKly8RYPxJfgSjaPQxGrer+N9ZlVO4ZKK6OT+PzA956CFtyu8nN+1p2xfRYPY0K9z1ZSb0xpJWHhYKbB+dV8VBPZten1uUYMmNw8K0val6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hoOeTBQUHnUi66jC4kNiiQ8svzr4H5iPoNHR3+qvgxQ=;
 b=FSR8QmkijYRVkoAVDbkvQy/1V8nnVQWgEFBCdkhWGZOYFxRkrKJS4lqafh6Wb5UmO0dSaalJTGvp/VHytDbr2KZex/w1pZL6B+4Quo+7i3QQ0ZutryYJlrkLeeYDLCOF4icWf02DgdQA/c3mtLWxrb4R9FafTtBugDUlzYmHE+WwX02l5xt7gmM/6CHmyFPv49MgAUVCw8IX15HMXnAlDPogNFsyKCxZU0jQVRwoCgS7yFCa6HzlLLIirb+cawdwR2TnTKwp7FT3zhfwytmI828mBLzc0irKpVgrJJ0jRrerpFdFUsmT7c/iNFcjJJ4EQHeSOLVOpGnvVgs4DY5ASg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoOeTBQUHnUi66jC4kNiiQ8svzr4H5iPoNHR3+qvgxQ=;
 b=eHolMo1kIYoWa+zug3/8TruipX98Q5r7zBB9BaM8bX+TFIIwyR/884SBiMhMcYq0RC5xrmupprn/aRir8OnW5mBwu6YpOjlD2zxt1TZZ9zLIDL3FDF7JpXFPdK7prvaTpu1M6E6XgVg1tqICsL4SOe/CjTOLhk9vI928q3T9f9ZKtzeevn1yfuQBxx6w5wK5tej7IEIEqLfOh51O+y91z5Uig5MTTByZzE1E6bBrtZ1L6ut6BsikQp+neBzYKC1MEP/VZV/QJMF+v/LMJWMzDOM6VOKcLr/KzmYMfsrz8Lzry3i1pUbeEReO02W7C/oSQ2S8Br6S2BAj+pQVjc7Isw==
Received: from AM0PR04CA0113.eurprd04.prod.outlook.com (2603:10a6:208:55::18)
 by DU2PR07MB8379.eurprd07.prod.outlook.com (2603:10a6:10:2f2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Tue, 10 Jun
 2025 13:16:20 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:208:55:cafe::2a) by AM0PR04CA0113.outlook.office365.com
 (2603:10a6:208:55::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 10 Jun 2025 13:16:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 13:16:19 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 55ADGITD016767;
	Tue, 10 Jun 2025 13:16:46 GMT
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
Subject: [PATCH v17 net-next 5/5] Documentation: netlink: specs: tc: Add DualPI2 specification
Date: Tue, 10 Jun 2025 15:15:38 +0200
Message-Id: <20250610131538.18777-6-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610131538.18777-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250610131538.18777-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000198:EE_|DU2PR07MB8379:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 44d8ba7b-740f-4ae8-47b4-08dda820fd59
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?LXBJLuyG2/U/h+arws37jgnLmtpNHS6ge7fzuPwTduuECX9WD4529rDqY/+x?=
 =?us-ascii?Q?viBoakklB6jvefGHXiPz7u0o+UcF5njN4XxiQsffBfjySVUF2lvRULyH52lb?=
 =?us-ascii?Q?5m0J+DlfOdT5gnxgCCc794/9FpfUWJHopiuA2j3hDumaEajTNM3GMJwhFlJW?=
 =?us-ascii?Q?E3Y1N6qzu1lopzou1MFnT/7Rv8i2/gadFq5DUntfQ9vOA0GAEOYj10Jql+r9?=
 =?us-ascii?Q?dh6mx0Dp5Z9tWgB7ALl/1ITZNqnFp15q2EUixL3sRbmavtW4L8T2HFKxq9wO?=
 =?us-ascii?Q?rPQ/tV6SUZejSMyG8Yr6iTMB605EDWXpsG3TGKu4b1xHuKfmykGF9frYDKNP?=
 =?us-ascii?Q?aJEZulTLYD7fuF8nVvBnnjr7TpLcm4deAL88MKZFVRA8jC0znV3E9tj9jmD4?=
 =?us-ascii?Q?flg6CKQfFvrFpciFIM0b+HVRUqdLSpAg1kdXeeXuca8iOZbNoUMuvmGXxDjF?=
 =?us-ascii?Q?IW9qKhXomXAtedWOVqQ60jdT7lVEDhmmNPlJRvTdscoz5DkIwdTwYeS9+mfi?=
 =?us-ascii?Q?/ZzxSolQ5X3ekDCZp+TB9itd90GP4W//S528ukfMqp1L7R/K8RVq0+btrJqS?=
 =?us-ascii?Q?EZqrbUudG6Tg8gbr/8tKSVFk/inRs70DWt910aFWBTPSGwHwgNrPAPxGyAYW?=
 =?us-ascii?Q?KCU+hfO/v6WIwOHv7OhNnJ5SqOrV/oxeSONRzAW6IvgtlFbdvHuTgP7kpv1/?=
 =?us-ascii?Q?VZeBM4qusyD/+y42K17qvyry4UIfy2IEUkc2prAQ/BbPWLmAw7b9f4MxQCMK?=
 =?us-ascii?Q?ia2Jvb3u5EBE59vuS4jprYQtHvjVe/x3STnBHue3015XV4rr9KNHNwm7L8A4?=
 =?us-ascii?Q?/LHiVxsfpwfX2LjLRxEZR+mqcVgHVGrB7I1aiffpj4n7Dvg8ivRcpjm4EENv?=
 =?us-ascii?Q?Kfp06tOlu2/rsqhSRYv5+dO7MsVMD9UINH5k6DHSwB/zOIJjg4gxr/idB2o6?=
 =?us-ascii?Q?5Kp59ZgKKLCcMxRXOxxPisucpfcRuggZhBWn3FgwwNteLH6stbTqt6FxNec5?=
 =?us-ascii?Q?eFeC2CQawgug/tsWNBI3SoqbLT/PL/ETuuZ0VEUDlAac1f5UwtfMIPwXtrpZ?=
 =?us-ascii?Q?4YfVHKyRtTKIooZ7rOtbiCVBh1aqScZBOeIDCFSWlOnJFHGXpix1wvNLscJn?=
 =?us-ascii?Q?kwG4DrocTrgO7pt71e+rivbmcgdToUW2N62BGunJoW5V8NYJFPDGimloyuiE?=
 =?us-ascii?Q?sCxLpxT/0/ZTgJbvRlEaML0uLjCexJp3eRCZK+qPjX+zgYZn1tVGadJTnGSE?=
 =?us-ascii?Q?9PB+dMEc2Vvi/dbmY9XYhg+Vhl9c4eyhsg95yvSTsACCZ18mhDrbhRuDZA7d?=
 =?us-ascii?Q?0MySXV5ew7bGMBzcW45Yb7ouSlGpwEte/+J9QBWS3eal+gmc+3xoDXEXpVhA?=
 =?us-ascii?Q?vr2n3j/vHK0Lsp1ljtaAu46dKpQKUhA3ZR2TnChO3TNKpGpd+jTDc/P7EvBS?=
 =?us-ascii?Q?8KWFwMj3v62XESK4JBGyovZk0swNNYXNrkI0ju6oukusHn6PX8TzfiAgJBFY?=
 =?us-ascii?Q?zFHbIS0a66W+04G+IujuNAjGcyWe0rrw49/uBeEb60ZiqPliQpZ3rKFuqQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 13:16:19.8376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d8ba7b-740f-4ae8-47b4-08dda820fd59
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB8379

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Introduce the specification of tc qdisc DualPI2 stats and attributes,
which is the reference implementation of IETF RFC9332 DualQ Coupled AQM
(https://datatracker.ietf.org/doc/html/rfc9332) providing two different
queues: low latency queue (L-queue) and classic queue (C-queue).

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v17:
- Rebase tc.yaml on commit ba5a199b2401d and commit f9aec8025ab5f
---
 Documentation/netlink/specs/tc.yaml | 156 ++++++++++++++++++++++++++++
 1 file changed, 156 insertions(+)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index cb7ea7d62e56..dbec0fc748be 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -56,6 +56,37 @@ definitions:
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
@@ -822,6 +853,58 @@ definitions:
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
@@ -2281,6 +2364,73 @@ attribute-sets:
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
     name: ematch-attrs
     name-prefix: tca-ematch-
@@ -3705,6 +3855,9 @@ sub-messages:
       -
         value: drr
         attribute-set: drr-attrs
+      -
+        value: dualpi2
+        attribute-set: tc-dualpi2-attrs
       -
         value: etf
         attribute-set: etf-attrs
@@ -3872,6 +4025,9 @@ sub-messages:
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


