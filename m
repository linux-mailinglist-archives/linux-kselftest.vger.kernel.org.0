Return-Path: <linux-kselftest+bounces-34739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FEAAD5A01
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 17:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1627318990A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 15:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BF119F40B;
	Wed, 11 Jun 2025 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="i6t7L63w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010003.outbound.protection.outlook.com [52.101.69.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A49717B506;
	Wed, 11 Jun 2025 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654559; cv=fail; b=GLxZIO4or0Z8mDM7f4jvYSg47STa4Al7H7s/or80BatvYaEH6FeeDqSemx7syZbhJy5/M06jQEJDdeCIVIqX5b44cA3nExEBKBufEsApEyeL2ru7odbBKmxCOsNelTIRteN3Zb25kT/6NZPBtWGFqaj2EjKLaErZbzNwVJijqb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654559; c=relaxed/simple;
	bh=hLCYnrVuwoduCLUbqkPSjHb65SPeNMhDXd5OveZiOcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PHxvFncjlevSCcykCkgDDXRv1qUlH8nBQAhoY4B7qMhxTiUPg50pFpk8ejAm8ORjiSkmQaf3MoU1nDc9TWoSpp+tu7ZrOnFlc9dWEiZ1nhvuVQkpGMRUuxpU6Z7LKjUqVrldPbV4ZEyJLF4BBeKdKuESM2qRZIg1oLblduTvK+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=i6t7L63w; arc=fail smtp.client-ip=52.101.69.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0Y2dhAEh4t9WRB0fkf+7Wu5LL7fOcx19uA5bWVnQBXJSLUw9sh7Hudz8vT2dx1hdFw+NohczZ2fHj/+ztwATTi+K2JHWv+FdIKijSnmce1wnnrcITs6C1VzeYJZOZpVqFbqRDMDXI53Ad+/u0EnEUiiqM4/omBcoaKr1e/ZxJbxDrZzUAKoucmTlOF34/8/41GFfZnzHQJgFKO+u1GdfVV4NUtqphZDOwfjhdPjd+S0YXdewj77X1X3z6xfp5egqb0ZwQ51aflDCrSaypzCVWZFlVorWWfjnMECI6xg3mW+GJ8U9Pzq3w4YTLM2JHotdVHAsXMB8a36z6z1URLv2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hoOeTBQUHnUi66jC4kNiiQ8svzr4H5iPoNHR3+qvgxQ=;
 b=Netkz1o+uUY+Y2LhSsDgvQoltP4FyMRy/3JToGe8Y8j70f2ohZV1Vbt2EXo5yUv9zY3nPx881zr60gGukBN4mj99HPVo9JFzBvmjzRobHMxbWQwUCrSp0rV89wZMu17k6GqoLHQNRBwkre5AA+qqBvoN0NPF4wcb4/C7tYJ13rpki1KeQ5iGRSZ8yz37FkTUeBcRono5RhjrnCziBjiWEPATukDIviLrIizHhryVlJ0mEDf4ZETx4yEyajBAC/G9x7WJQ9EmRj+hYVhdT19hhOGVNkS/OqQZWQ76OL19Zy4YmYlw8aFNHEktiOTC8Jp7il4K58wDWKHuFiLZU+6Tyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.240) smtp.rcpttodomain=apple.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoOeTBQUHnUi66jC4kNiiQ8svzr4H5iPoNHR3+qvgxQ=;
 b=i6t7L63wNTL4qt0vt6kKoEkenEsmuMYyieLmS6F1p/lQkbldwEtq/zB8GDxzq+bpQrgVhx0Lq7uD/UofHk87YpmuhDPDMP91foU6LG6RF8mmacBCRTuqKe0LEp2kuCveK/sNUYYD5CJybHyz58SDa40GFHIds4hHvW/MN7voX3KrsbqqQXooYCernl8E9uMDWmWJNswhIsZ17BVSwF8MO1k7R2doPsVrvV7zag16CTICMnLSRpNALmgYTVnRwbF5+JdhNHsX2Dg1f6I1foay06h9mFVqGVy4gO27cjJxKmtoklPNfkaKiaCX8Z5tilOuyOVgnkkxUlPQffm3VyzYPw==
Received: from DUZPR01CA0122.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::26) by DB9PR07MB7131.eurprd07.prod.outlook.com
 (2603:10a6:10:216::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Wed, 11 Jun
 2025 15:09:09 +0000
Received: from DB1PEPF0003922D.eurprd03.prod.outlook.com
 (2603:10a6:10:4bc:cafe::47) by DUZPR01CA0122.outlook.office365.com
 (2603:10a6:10:4bc::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Wed,
 11 Jun 2025 15:09:15 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.240) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB1PEPF0003922D.mail.protection.outlook.com (10.167.8.100) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Wed, 11 Jun 2025 15:09:08 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 1322120099;
	Wed, 11 Jun 2025 18:09:07 +0300 (EEST)
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
Subject: [PATCH v17 RESEND net-next 5/5] Documentation: netlink: specs: tc: Add DualPI2 specification
Date: Wed, 11 Jun 2025 17:08:52 +0200
Message-Id: <20250611150852.23218-6-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611150852.23218-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250611150852.23218-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF0003922D:EE_|DB9PR07MB7131:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 90ec1f22-6824-44d7-bd24-08dda8f9ea54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vz4UVttmlnORUa/ARWdxl6xkK9uJW9UaQV5oPakMrj4vdwWsBtoWhnEnAp4v?=
 =?us-ascii?Q?yhHuI+BgEHWfPYCffL+m5Et8XqRLGWV9/k1vOT3oct/37mWjGNqZiJ3+s/jO?=
 =?us-ascii?Q?E4ITMN3Aeed/Vc60DD+KaaRYyf8kKItuZPy1MjcUUXy8PeMOHyC3cVDrTQ+S?=
 =?us-ascii?Q?wLO+YutQdpsu6Edqv/Tpvgr8JTvHVHax7PiYvcXEuoCRg5wbWHLlwfBziuKa?=
 =?us-ascii?Q?dD2tVc5OtQWylAEfzOQg2WWN8NnMYC0TOY1kHdk6fFbPruiMnncL3RR1xeYT?=
 =?us-ascii?Q?luN4OqHApReq8y5GL0PrexTj7fAa8/97+ugJGkw0tj0pDwIXSxsYE5fX5ZoK?=
 =?us-ascii?Q?37LPA6HkPAcldgbN9+Oya6h5eERhnn5V0eMyvzq/VyGfCn3pfhRTgaUoLNXE?=
 =?us-ascii?Q?oaadAZ/pbq6J6PIZqn59nieQkRb0lr6gtZdmFyDvknNfx/kCVMVsVnNnzhK4?=
 =?us-ascii?Q?Je0lCdvUuNfR+bdbgRwU94Q11BIRBJEvH1+lHwIv8Zb7yUQOBcW08cKfPfZL?=
 =?us-ascii?Q?T4Tc9hB7ZCxeiN3D8qYKQ3ZRwwzfSbiPeLQu9B2cpMqmBW5ajxdZYMY6wwl9?=
 =?us-ascii?Q?tg8naSc9Qo5vdt6TFtDKD9X+vw+c2BhNWZPjEVEjc5Mj0QgAlC+bMdwMOJYH?=
 =?us-ascii?Q?FQlL9BEjH4f9ZhLO0E6F68tos6/rDDSlT+elmEPqlzYdslLO3F/7r21ty20x?=
 =?us-ascii?Q?MURg4/+DCeola4x2We3r6AlINVHckfSZBtlASjOSTPGamG9xQyW660RdyF2Z?=
 =?us-ascii?Q?F0dUI24DZNJjBwhyRDZpqR6qsE/vl6V+RECQ2F2KIwHv2bLBrcYzrmOlNAjE?=
 =?us-ascii?Q?OthIQ/KdDsRa4dBSHNrMKomVPNIL8t8E72I7gKRi7wKk45yfcclSC/rw3Iqs?=
 =?us-ascii?Q?xDJftGTifp4v8bBlYMXX658cBeRC9xkwu/eYo/Wkm+EqxtB9Fl/ulPDXPQHP?=
 =?us-ascii?Q?5V5BiPTawjNEwGVAfGA9x2oVLAbEVKsiiCWygpwa5K+sdNMMlgsS3bPEHD76?=
 =?us-ascii?Q?tPLvmZ8gBQC2pq3sDaiX1SECEhqvBn0eRuIN48UXq6V4MY40JxvxOzMkSjGz?=
 =?us-ascii?Q?j3g4im8nzyWGVKTly86sXjbqed2gsvBODsAJNW1K9GC7D8nwY83Xk11boZy9?=
 =?us-ascii?Q?7VSrCFNVyE0r3GhQt00EQwYamSnJbKYV9ieg5EKBtIytwE1KptytcQHEsA+Y?=
 =?us-ascii?Q?5Vc1w9gdtLrNJG0YX2WnWd2F1yiKoY+RWBGZe96nCpEDK6x/a3CqWgoBQP0p?=
 =?us-ascii?Q?WDvrIP8HRL6dD/skBlNmPfwjMcnF8KBl8dHdoYv/Q/Uk2fS9ipdGFLLJYQZA?=
 =?us-ascii?Q?VMvZcjyl7zCqqmBZ1/2hK1Jptpl548EWJN4iqLFWh1FyULyJHa3R3J/MK6B8?=
 =?us-ascii?Q?zjacQ610HsHrv937qOiFKmejzpcnkUeldLmNaVl4HCgqbslhBtJPrUk/0ec9?=
 =?us-ascii?Q?rDtxhTqhkkICUC96F6yPEGoj7jWQWIuFXEfdGsAG2bRqRse0clLKqIntJGQE?=
 =?us-ascii?Q?AQoIOZax9kl3Yze2hdIF/nNUZiER/l9oYO58titD0Oxesn1+0Eao5qDYMQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 15:09:08.7144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ec1f22-6824-44d7-bd24-08dda8f9ea54
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF0003922D.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7131

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


