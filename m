Return-Path: <linux-kselftest+bounces-35010-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E0FAD9E2B
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 17:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C2E3BAD50
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 15:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBBF2E2F1D;
	Sat, 14 Jun 2025 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="E2oC3N/i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010067.outbound.protection.outlook.com [52.101.84.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8122DA767;
	Sat, 14 Jun 2025 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749915766; cv=fail; b=mRTEA2zeU/fXONljssNSCjBwEZkyUHPmfvW7/X4tuHhgYhHWi3tZftgGzOa+S6+K9iYT0e4RRTrkcnleSZUvzBT0xIV+GzOG7fHyqyxMutOEvkZ55dhph/jktX+t7STJkW9LlNZEr59s6hA4AyPQrr2TxxPCU4+9v1QcxlBD7v4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749915766; c=relaxed/simple;
	bh=4H81meyVt3Xmv3NaxCEeI75O8yArn2dmD82PNCFIaM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FjAAOjRVSLfZHixc/rgsv7d0brCOu3RMXPdtQEKwp91xFY72RvieZiVPznPDBm9SFk+cIgZBojLL2RwpvN//Bcn9+AKWdkBfUjD8SDM9Pl7r0bLkQbKTfhtsBfnw6IptYaSSGz00thKkQ9qYDFAxWlBeqeRr0DkYNQ0qrXFU3Kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=E2oC3N/i; arc=fail smtp.client-ip=52.101.84.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DssuMWz3FuhIFhSljdcXQyMqF96IsvDMJfcO+shvSiza8FoB36QWYhNcN1ALctafFZDGX/xKhuu7atWSxA2uDSY7NQPHg5GXEc9rpcyGeNsnHW92C4n3Ase7PIjAvBd9CDTlCiHPIvaVAzv9FcWoKcQQ+Efqdk3cusWUCaCcP6JSzyThN1omQv8hUizPFeU/YKsja4PocfSa2UD3PhI6vkb9ueiKsEfRgpEFLWTR+EQDARzHkqiWHhGymzae8pVO5Iiz6A/rwL1pyFFtQgWMjuQe3ROFCp3IFOXRYDDJxsPFUkzQXr/aCC3l4P5jw3U2eS8RLiIZEzD4pgqbudFKtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KqoVfaptwEVZXn5TFG17OjF/dPhcQDuKCGj8euCEbg=;
 b=S0cXNFeuvvuZWuWHMRIN6+vjlLA99VA1uSHbYMaxjm7wVdFCCP4f1Ff1xH7AtTyxY71d3N7npcyDMkAr4Ff3w8kpB+UUelyF88tFus2VuLhOWMk37VmGrxiSCO3u3q8t4m7nBEWSQ6/JfZwqsGVDU9VLiEg4Uiy1aXP27k48bfIzjUdTMR3qpxYAcTqZ0ugrzD/6nRIIvcfAXYi2bfSWAiAcijG6N4FogVLOXPdlJbjuXepiRlew9L+MI5ecT5dAVDlL1lLQl6pIBEf9kFhyePrVVK9oJ+37gmV7DrQVFnf+0mtOAu1jDWUEowMO2iwz9SkkkTXOWJ7ApJn37h5fiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KqoVfaptwEVZXn5TFG17OjF/dPhcQDuKCGj8euCEbg=;
 b=E2oC3N/iCfouQmGs/vgkBcXyAFgyuQvQCPtihrp4qtzs+eEMmxqnefStwjhxYl+N8Yr7lcqd5+BfCD9S3FAlzUWh9htgk/AN+Y0dDJAe6FdyT9TWo8HekS73D0nm6yO2fnuhUU06YfHqIkHhh1wGFpJajsLqa1ez7Y+TwNdDRhVvGsIHAMPabxO9GvSWCQWPELsbZWm9i7I4n8XweGDSsi02xc0lUOL8Tit8ymNrkrzhdQEskcAzXK9VjF7Un+SukhY/Tq7fnh89iMnEFmB7m94oZTLdhz/mFuNGrKzujgbH90vlkyp3i9P/vYcwTLvj5eNL2eYow5FN7KLilRV34g==
Received: from DUZPR01CA0083.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::19) by PA4PR07MB8461.eurprd07.prod.outlook.com
 (2603:10a6:102:2a4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Sat, 14 Jun
 2025 15:42:40 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:10:46a:cafe::8a) by DUZPR01CA0083.outlook.office365.com
 (2603:10a6:10:46a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.26 via Frontend Transport; Sat,
 14 Jun 2025 15:42:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB1PEPF00050A00.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Sat, 14 Jun 2025 15:42:39 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 646CB1C002B;
	Sat, 14 Jun 2025 18:42:38 +0300 (EEST)
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
Subject: [PATCH v18 net-next 5/5] Documentation: netlink: specs: tc: Add DualPI2 specification
Date: Sat, 14 Jun 2025 17:42:23 +0200
Message-Id: <20250614154223.11026-6-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250614154223.11026-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250614154223.11026-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A00:EE_|PA4PR07MB8461:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: adadb79f-eb3b-4bc3-61a1-08ddab5a184a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ccjRYCGcG+v1zfaNllbscQg5n6UP5xt9KMCIRCmjeOaRWbBLWDLhL/18imev?=
 =?us-ascii?Q?1XdgKXP12DeksGzbrzNQs4AmcqEoScoTFslWK3xq700GTJN8JDuI1ZTz7WZ1?=
 =?us-ascii?Q?dJputfXI+f40nCFENzd6p9R6kU5r+ZtvGmE95MopbKeVNvcZ9lOwXTWMU1CF?=
 =?us-ascii?Q?Q3xX28gw2CRevX2B4eJdsrubWpSkLE/kiMbax751/cfOvYXEYNgtLeCLInNa?=
 =?us-ascii?Q?OMBYc1I9qy7Ew5QYKE0rE7CIg/SIzNpsd2sTewCVqP61/jTRvu+Ybd0rIH8b?=
 =?us-ascii?Q?sj9I2nsAMo2FepvUtsrWpAoktxaVO5EOE0CszbmOnUG3uBE6v0TniL33Fvcz?=
 =?us-ascii?Q?L4+IHb8+Ou0DFJ3I0/sIoH7aAbNCs1FcE1sCWGjEWL5LgeBWweYlRIJO/jjc?=
 =?us-ascii?Q?WCXfOeYp63Ou7Z9xmgRnPBQZE6oHRn1lOjPu24//PQfUb+N4q18T3FMgULrd?=
 =?us-ascii?Q?2LWlcCWD6Nn+eABkKQ7dTaVXk/6YjLLyACyJhlca+0zA1WRa/PR4kRHyR1yY?=
 =?us-ascii?Q?oJcjC7tF1nzbfR/b0w+WGls8GQtWtufHuwlCtf/4asZIuieRDoNes5dLxveT?=
 =?us-ascii?Q?IjtjuX1BaIzvRA2SiJwefSLa0T9/0pPmPLH8Y0gJfnTzQaQbPCKffp0JXTTF?=
 =?us-ascii?Q?jjzhKHOoQNtCUsdrYxhdrs8r0Uyrtw1TJVAXugf7cbygEqPSEPEs3c0awfsb?=
 =?us-ascii?Q?Bk4haU0id8vg0r3v2+nGybCPZdIO0Q1E6qtlSDw63RQQR78CMQCDpB9RyBFL?=
 =?us-ascii?Q?U0QdoUlLF+mtUwrcj+vikU7UC9xvDfMD9TekKXTc85Z20Jq3pl1gVmnQ9fvS?=
 =?us-ascii?Q?sDitf8YP2trDkHp49zEa34XOZlFAwysIfFLQ8bUNLZBSWdbBKaw0eAcMqoDH?=
 =?us-ascii?Q?FFOVrHYtnPtWCVP2QgFPs1CNAPY98zqSg9aaFBcqs6OBx+DfiG+MiSFnmWL5?=
 =?us-ascii?Q?JmZwQGzbw6CCuIrgompmsP6FgJz/lU6MX8rShWjDFXSTKnAnQp+Kxoq+gpoh?=
 =?us-ascii?Q?xeRkXI96hjIW3xYLmteWmJRC58ZgHanZCZvYSHkxtGA7IoI7F6tGFgksxeeQ?=
 =?us-ascii?Q?fMOwYCwSFkn5MvnY5Sjph4EVjo2TA9a/UxHjKbTMU9bxYt6TUR+Aqv07ZDpu?=
 =?us-ascii?Q?7svECKJCD2lnNgSe5Fy+aoevK73Xyg1tWqrbUJuQH+8gccBs9C/oU+E2uEZ+?=
 =?us-ascii?Q?YaoKdj4JRFie/QOEziUYz7Ah9iNXY7uKGskCHpjYPaWZfTsazFOsjNTJFR8u?=
 =?us-ascii?Q?1LYaPuK9e/+f7cwHnKy6F+1HAYSTZmn4sgUtt7Wlug06qIzAItb33f5ZDFpx?=
 =?us-ascii?Q?A2YIhuMIfBG3jizHcRfyYXil9rzhGyYrmeT+UzcZ7oPEaw5v4iQe2vMOBPBV?=
 =?us-ascii?Q?nN6XJS+wcyi3PLhPqk81akmXqsrE8RqhkMOQlOjgm32ztDhFh6E05sJcvSgV?=
 =?us-ascii?Q?IQX0zeJxy0O8DGWr3L46oUp3wxILpsH85Ql9G3C8OXAQtjmGx+hMn/YGagTZ?=
 =?us-ascii?Q?us73Atk3bjPWCsWHvKWYS2G8GlQDnBYbvW02Rj5McoRivD6b2Pu70PWmcA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 15:42:39.8934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adadb79f-eb3b-4bc3-61a1-08ddab5a184a
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB8461

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Introduce the specification of tc qdisc DualPI2 stats and attributes,
which is the reference implementation of IETF RFC9332 DualQ Coupled AQM
(https://datatracker.ietf.org/doc/html/rfc9332) providing two different
queues: low latency queue (L-queue) and classic queue (C-queue).

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v18:
- Fix name and name-prefix of DualPI2 enum and attribute

v17:
- Rebase tc.yaml on commit ba5a199b2401d and commit f9aec8025ab5f
---
 Documentation/netlink/specs/tc.yaml | 161 ++++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index 4cc1f6a45001..e0d349106026 100644
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
@@ -2284,6 +2371,74 @@ attribute-sets:
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
@@ -3708,6 +3863,9 @@ sub-messages:
       -
         value: drr
         attribute-set: drr-attrs
+      -
+        value: dualpi2
+        attribute-set: tc-dualpi2-attrs
       -
         value: etf
         attribute-set: etf-attrs
@@ -3875,6 +4033,9 @@ sub-messages:
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


