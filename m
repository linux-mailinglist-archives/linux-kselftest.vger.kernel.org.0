Return-Path: <linux-kselftest+bounces-32335-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBC3AA900C
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 11:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618B818966B1
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 09:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615CB1FCCEB;
	Mon,  5 May 2025 09:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="V8q7Hh2t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826641F3D20;
	Mon,  5 May 2025 09:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746438551; cv=fail; b=Ed72STx4bLXkdjiJHvfclpUZugmd+TeTgeGokoNKkHLwrHNRYBXa4I+K3B+aVJb48UEzFnnANZ5MmpPTUufyhwUZynKq5ozuUFrOQifPhB9+oXfKWwOi5LgNXAqUoYl4Zwx6hDJpUl8GwmB3wZjj65VhYDH24T9B73AxChfGsbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746438551; c=relaxed/simple;
	bh=HL0hgqi0eL29vDKLfeulUoU4Z6tEuSGW9iqN5dgz99A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P+AtuPh9fOo4Pbqz2YO9uTdDb6KLPdO1fQGGrJSBgkzETcyy3Q6BMKAzY1pEyG1HlnAD56RgHwbQlUqhwM4jl41dTZNlCmldqrDOeizjJ6ykmvt0zTEOd7+kZzP2xqgoPFP0UyEltmYyIQ817W4JvYSkEyxqzsLo9qoTzPqv2+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=V8q7Hh2t; arc=fail smtp.client-ip=40.107.20.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yo4bXiPv0YS6lrMxdb8OzIyIOFG54FCRZwUYNp8rCBCxvkacyJ/h04s9rx+BUU6vgxLi6PMu3J4AXxZhpFMJQdAAjqfLoqyYeFh/VBczhWbQac6lUnxcT2EpnrmpJDwjrXdi5i27NMrK29aQ+f8cJ95qqZ5RQmTZXyilpBpLyJdJW7FxwL9hZcEqMPx4sn1OlnbSLucdAy/6C5Fx8NgIdBtd27NQvC+vGQMKnh5zmIEIb0AxxN8KupdH/6zAs1Nn8pDYjIVoopfCW1jn2+aVhAhRtvosEhNLuJ7OXXGlK/T7Y8/tebgVfc6ApfTNhSYg8l9JDKPyEsHv79YlvosjoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2fTgJCEUI6Yg3UDYfahWtbC/gRqrMKJj684S3+LFZ0=;
 b=eQq+j7BgS1io+WYacjeuWFslVPpJBlOi7L/K3yhh5Fd8eyhQQCMyWmAXgDnpmySJyOUT6gAnP0QEE+EwDtITMB741hZehocYkELKtykX0Z7kikBrJxd/9fivcg0C37DYmI7kn5OuK54NLLll9F5b9a1iFqI/h3vkg5zfFTmBCIS7NvIv/XOIwGrX7Uai5skmo2PhXfvHj2iXjkgz4FJuQ2HxqYRD+9U7OGo+Vpd8fS4FuMIG77eEXTKNRz4XrdOvUUY/QWspTfa7sC3nyK22HBP6LbVzGI0cn5URuclUjRZ+8/Mk3mSwt6xZ9X/JYSuTvBrxnK4eRkQFJfk0JS0Y9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2fTgJCEUI6Yg3UDYfahWtbC/gRqrMKJj684S3+LFZ0=;
 b=V8q7Hh2t28GJWlpqpzItbyYuWwjG5Yu4dZxu20PuWvNse3Q+Yfx7DUp839CpsslJI+y5Ec0S/2NKTHESb97bcYNuSC9a2Fj9hOFQcrzhclLS5dT7hJlNOz3C1EUq1fopPCmvd7Jitb5KlXY5bybeqYLCT1bOoPBQUeTAToeJgFH52WUFF08N1Xe+Ukjfwm6Nsx7lJ9xthv+DKVmlTAex424BGm4C4AZu8qpEmGJ7s7OsbcOl95eRmBXmeWJaD/w7d5yspAtk7QSOYHD2A5rGZ9SBOsf947l8hloAry0c8La0o/5FYU7v1ZLJk7d3Y7sWDvcDtOkSGQxTnWRfswGrXw==
Received: from AM0PR04CA0127.eurprd04.prod.outlook.com (2603:10a6:208:55::32)
 by PAXPR07MB8723.eurprd07.prod.outlook.com (2603:10a6:102:245::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Mon, 5 May
 2025 09:49:03 +0000
Received: from AMS0EPF000001A9.eurprd05.prod.outlook.com
 (2603:10a6:208:55:cafe::1f) by AM0PR04CA0127.outlook.office365.com
 (2603:10a6:208:55::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Mon,
 5 May 2025 09:49:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF000001A9.mail.protection.outlook.com (10.167.16.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 09:49:02 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 5459mcwG006243;
	Mon, 5 May 2025 09:49:00 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: donald.hunter@gmail.com, xandfury@gmail.com, netdev@vger.kernel.org,
        dave.taht@gmail.com, pabeni@redhat.com, jhs@mojatatu.com,
        kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
        jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
        horms@kernel.org, andrew+netdev@lunn.ch, ast@fiberby.net,
        liuhangbin@gmail.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v14 net-next 5/5] Documentation: netlink: specs: tc: Add DualPI2 specification
Date: Mon,  5 May 2025 11:48:37 +0200
Message-Id: <20250505094837.7192-6-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250505094837.7192-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250505094837.7192-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A9:EE_|PAXPR07MB8723:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9a3310a7-75cb-49d4-b900-08dd8bba1134
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|7416014|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?vag40TsJ7eK2MdC8Dc9tnG7IWtrCjhGPCI+RX6nV4CQq3CLDQUbA4oACETN3?=
 =?us-ascii?Q?zy/iG8rEiH1nSCKwedNSi18F8XfaRWRg1ohSQY6qhrEM+ZlUjnw5GTYNudAs?=
 =?us-ascii?Q?Pl1tkvLk25TZ8H2lsIA63m0Nb/Hp2Q09TBphcYczOblueFmGW2XI2PMyWdxn?=
 =?us-ascii?Q?FlhQOBeVbnqhDCOQJPfj7FphTydlA51FB7QQgFxPfw964q0H9t6cVIY/G7Cn?=
 =?us-ascii?Q?cIwd0oE/I/IY6pbFVYVc/VSl6bvx84acI+gG9XIehRjxSqjbGPSpZevNlrg5?=
 =?us-ascii?Q?w4P0cm9loYWFLSuHhmZQeJb3MOda+5UJB7l9BgkgCsQVgez4LNyRXopOIowM?=
 =?us-ascii?Q?Y+IKAMvej/yxMfdI6aYTLgmp/QVu+dzHxzBUIjP7cFjUqpHDny4YeWY5/N0y?=
 =?us-ascii?Q?mJWrIz56P6xoswy1Oy5QIN7NmLnXeRVK7sh6tARJunkgXFm4yC8OyA3ws8+6?=
 =?us-ascii?Q?ueVohX9lwsvaCYBAdtHb9yuwlLyDGNP4D7As41/+Tknu9uvJDV2Dzm6Sh+Oa?=
 =?us-ascii?Q?aym6tl/oMEu33RRtSkRwhnkrPbzE/EHHXdwg8RcceYB3cJtqb4hmemHp1/T6?=
 =?us-ascii?Q?7KIee837SC81ZWxjqBCFGfSnNzjWPy08zh3nY/ba2NegekXfHwRnyJKVLbZ8?=
 =?us-ascii?Q?dC/tkdoetMCHT2Xf5KKke6jzdgbN83eYIvN6xIb4pAVneQoI29TEvXqGekya?=
 =?us-ascii?Q?V6c5gXuuPwWlkMEirnYqQk+TV793P6C9VGvuZPG2gx8Inx+Ay3Pls0QxvLfT?=
 =?us-ascii?Q?9RuhnKRi8qKFSdNgsdv3Cb4UjkJj/mxJ/Oosf0EewYwzFEdxhRyMbiGIvw2b?=
 =?us-ascii?Q?mehX6CGnJysknIXlg3BdaWkZtTx2rJuUtIbAY/WwJGPip16EpI/WPeeWlyqf?=
 =?us-ascii?Q?8q+w1EVTXb3BADsfqPGObi6g42FR5oS1tkOOldxlBiMRvShC3vEDjSkjr79U?=
 =?us-ascii?Q?kJ+Pev6a/8XLD/zDEBhybsULuMEtd0aUI3lLRA8A0/3UppXYo1wEs08rK0IC?=
 =?us-ascii?Q?Jk2It4B2qak751/qEKIhWPQOvcfLULENKd1ASUIzeK3DsEVjszOseBH7m2r1?=
 =?us-ascii?Q?hikxuL3jylUgW6lH+G2BuHeNvYpSWcZZOiAyKQzUhKF4cyjtK+i3lJ3N2Htr?=
 =?us-ascii?Q?f1qtA/3pLK2Yy/9myc8sKK7gB2WHketSDCv3lIWQ+uqPkhVZEAABhAhLdDv1?=
 =?us-ascii?Q?teGeEt8VPjNAhBx3aVczDnEMA6GEeEc8pBwG+2NI53n9b1tCohf71wI3Xnvw?=
 =?us-ascii?Q?9R5FYKsRjDru7UiSrxwCsrP4S6CFifflVeWC1Zlolw9X0EtMLgq/L/7LTeJM?=
 =?us-ascii?Q?EsduNQA+ugdrPBIHttuP8CsWxulm9Y5dgEmJfxCtRtWoDkzyQm9AhXRVwhBO?=
 =?us-ascii?Q?LYjzDUdZUcGw9aiGIeRoyJJyQZfG8uB1gRgY5Ap4+cNftsRlb0+UZL7uhQWh?=
 =?us-ascii?Q?A05gWZOu4kguUQx6CcfIOpgBaFp/Q40Mgh6/e+qf7q0AS7UY1pVgQzNePVg8?=
 =?us-ascii?Q?PJCf11Lt5xRyC+WHEQeto8iVhPzkJ/0m3uK8SAH3rbRPg4EhexG4iCjaehNw?=
 =?us-ascii?Q?xbiaa3MQd2IBarNDljc=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7416014)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 09:49:02.4248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3310a7-75cb-49d4-b900-08dd8bba1134
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A9.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB8723

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Introduce the specification of tc qdisc DualPI2 stats and attributes,
which is the reference implementation of IETF RFC9332 DualQ Coupled AQM
(https://datatracker.ietf.org/doc/html/rfc9332) providing two different
queues: low latency queue (L-queue) and classic queue (C-queue).

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 Documentation/netlink/specs/tc.yaml | 153 ++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index aacccea5dfe4..1490dc2b6adc 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -51,6 +51,34 @@ definitions:
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
@@ -816,6 +844,58 @@ definitions:
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
@@ -2299,6 +2379,73 @@ attribute-sets:
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
@@ -3679,6 +3826,9 @@ sub-messages:
       -
         value: drr
         attribute-set: tc-drr-attrs
+      -
+        value: dualpi2
+        attribute-set: tc-dualpi2-attrs
       -
         value: etf
         attribute-set: tc-etf-attrs
@@ -3846,6 +3996,9 @@ sub-messages:
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


