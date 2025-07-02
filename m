Return-Path: <linux-kselftest+bounces-36254-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FACCAF0939
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 05:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AADFD189B277
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 03:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBF91EB5DB;
	Wed,  2 Jul 2025 03:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="RH1lgVmU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012035.outbound.protection.outlook.com [52.101.71.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE5E1E991B;
	Wed,  2 Jul 2025 03:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751426919; cv=fail; b=sFvF3SIvABwE8Q402CV8fqXuGgLWUc8FyaypfFw9WzIqWhNq4pVzbFE0XE5usblfXENkuknesnr1vHR5wufAs+Zq2/5QJTrEtWXufAKo0tGPd6GE9Hk6DDnUdgYk+P6C45rrmA36IzzfE4ykiQyPt7vlBERnPVvdgb/CHiXhXdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751426919; c=relaxed/simple;
	bh=FfE8K0E1bxyIfANuT8ef9bwnkIg7dKViZawzHpmBaoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NGVQjWbqCPjJhjgvcXW783ziczsrYL+wtI9bdKKFp8yOtKF42jDE9pZsROKgaqkhSq6dUqHs08/vHaNQPvrWWYD1rW49d55xfcrL7TbQ9gVN4NRTvvETPK9aGzbAwuibyvblPekYeZf2z7oecciMkUL9oZYchi6EQRFoNX3hIrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=RH1lgVmU; arc=fail smtp.client-ip=52.101.71.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7vC9u7aSV+qfC4PyEuU17EPLpHoMcqlRKo6vKnQXFpRNtyI9gwCnCo56FO2hQrvY6kD81aM3HxPM6tRTuT2+R9njJ+MsroTYSbRq2x2aZloPDz/aotBbR6GBvnkK6iWVFWCSv4NjyHTpuyDDclVGxCq4Tj6uMTepizCvexa3jYFSeNcCXrY0nbjHFxkwx5RxpkkxP3n2eRCVlHYKSeZFjD1BP3/6fjhs/Zo8WCazGCoOyKI4XCokZo6yAF0HcTuIZUINm3P8GyIbZm7xBhUd5Jec6QgyJUw4mL5R0WDFR64L4xgpgjYInujDcHLEPQds1/9O0No1B5TqeaiG5/nIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y92OUkhdcTtpuk/R+YGCswrouhqwC+rX9Ds3aUvQu2s=;
 b=V2Q10eesb97Jhate3KbLVspqL2XmWZPQJpr0KLlt0wIHv5D6IL2AjrzIga70wkzSZjkoXmSzBI2iO8BPSJEO3VGGltkqUT3LpBqRcFO9wAS6PLHFxqThVplsscrE4i3iShGYvR15LkbX5IG+3ZGUOxJCsiKyLDMNuJxqF1K9BooPbkq8h9voNZaeH3yXtfgjqCv2hW+ncbCt8J2wgsTo5K5G0hl777Nd1arNs1SKv5aYo+AgF2rcSEbn/kxFlcAPzqpmTbAoyXx+/b/SDSre+nj8+3KcJSWUO5C36c3N3TuC0zX/Dn0PYdNmd+AHQvX2jv5XcXW/g/dTZAy/Ng+wHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y92OUkhdcTtpuk/R+YGCswrouhqwC+rX9Ds3aUvQu2s=;
 b=RH1lgVmUwnwPkIDzISCHt25XrzjqYvSexnvUi0u38tdQLeemhWxwMcBSkSXlJFlYQAXDrxoH6vVPdslC3lYmX3ERr0hDcqePWCRTYHzpJKeIht+cxEOn5Ln91DmhXwH1LF8Mx2g+sXvUgUumha83HX8034slxNzFULlGK5LZVmnEkm+HbOj0erVU+ryxtx1ON07fmk/O2ha9Wri7jTqvTaIFiVdL3veLoM2Xuqn5plaKRNYYq+KAYIM5kUExcszCgUlS+7/6VYfoN7VvZ5qDPGtEviFzFYuJwLrw4LX8AfFSTYZRfFSPBggB+iq7w3ZDHO0Lu4t/J90GoXoRjHZNiw==
Received: from DB8PR09CA0025.eurprd09.prod.outlook.com (2603:10a6:10:a0::38)
 by DBBPR07MB7545.eurprd07.prod.outlook.com (2603:10a6:10:1f2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Wed, 2 Jul
 2025 03:28:31 +0000
Received: from DB5PEPF00014B98.eurprd02.prod.outlook.com
 (2603:10a6:10:a0:cafe::c0) by DB8PR09CA0025.outlook.office365.com
 (2603:10a6:10:a0::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Wed,
 2 Jul 2025 03:28:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB5PEPF00014B98.mail.protection.outlook.com (10.167.8.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20
 via Frontend Transport; Wed, 2 Jul 2025 03:28:31 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id EF45C200B9;
	Wed,  2 Jul 2025 06:28:29 +0300 (EEST)
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
Subject: [PATCH v21 net-next 6/6] Documentation: netlink: specs: tc: Add DualPI2 specification
Date: Wed,  2 Jul 2025 05:28:17 +0200
Message-Id: <20250702032817.13274-7-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250702032817.13274-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250702032817.13274-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B98:EE_|DBBPR07MB7545:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5b9d8a91-fa0d-4c8b-59bf-08ddb91884ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nKVHWBEEUlv/y6e283bQrknHX9gBNRqMHPXqAaaX7WR/HSGxJpoclAZjCAdA?=
 =?us-ascii?Q?4GbVGSS1iD5Mv/DVaxCUPNvnIcPwqZGBGb0s7g3BmF6dhYQFGX3+Si5BpfGy?=
 =?us-ascii?Q?N+a2B3Me49gZ3ZDbmoss0acPaJhHUrTWU0H+9FqAnTOGEDhmk1MLM0Yzo4Yn?=
 =?us-ascii?Q?bU/hYzfyC95ezEpzpdUCYFtPQSiT9zSjUZxHgv3HDZ1jSzRE3Zl+5CBFeUu/?=
 =?us-ascii?Q?CYES/LAvq7b3Fc4NgXNbWwwGYC1f6/Tl1aTmi0EBhq38IO01b4t3yLoAw06B?=
 =?us-ascii?Q?PHHiJRJCXjTmbE1ITkegStZF3Mm/YBeg3jsj0X0lCfbX3l89Pu/dVs/mj8/l?=
 =?us-ascii?Q?nRI7UEcDwRwUqkqwzy7Jdul9cfjm4JHZ+c0vsOEFyLoAytCXOtU+iP0m7YCx?=
 =?us-ascii?Q?kAMyxATXz5YXQBSt3gbziea3dKn/4B9K9AAMciqPu9TdIb7lUQHz3CbRbeay?=
 =?us-ascii?Q?ezNwGKgji84gNfbrFSKJelZMBc3XLF7VQsmoqGDUtAfT4U4X6YMl4Jb1xtRt?=
 =?us-ascii?Q?q88MdC3pApcrCHVWRCzB7wjcNTdigkimeoiMWm2wO91XCCM2wTUJod/LrQ5V?=
 =?us-ascii?Q?qTP87ClbJ1QER1Uj/arn4IIp6jwjfG3gFXefjmsByz3Ny+bP7CITqv5M7QkT?=
 =?us-ascii?Q?yQM2hJ56u8Imh9rBW6XX1AhyJNNfgRu3mp/NReVxyC8tvXjKj3JG8ZsWConW?=
 =?us-ascii?Q?pDwYXBG/w7FmyEgbUYPb8ck6BnPlqy04kMLr1SAH9Z4Wa7pQwFqPbUa2NokD?=
 =?us-ascii?Q?itt06hzW81I3q6wSCaU56l6yDsRK1Y1upMY9i8/lzy6LsfK3KAUdDE5CKflb?=
 =?us-ascii?Q?Y61Q67FiqajwiiFGp4QcCb5rDwXsCg7DNkNW7cz03Foa7OyI7W6SadJ9xfSU?=
 =?us-ascii?Q?+Sc1B1FKNrUfeGTP9uNdD7/Q5FPgut1pYH2V5Eg9RyFsa+exWnX/hfMhFNtR?=
 =?us-ascii?Q?etQjFA6NJlOmwTH9JupZR+ecClmQSgATOwXy3Q+OCoyNb2zWc8dHv8mXB9gB?=
 =?us-ascii?Q?MaacMxZA8skRYwfZDDLWtn3NbD9lWKIEujaIWpLywvX0EBQI8HkWhqryBvPu?=
 =?us-ascii?Q?MvMasqQGx4NsbRiFqH2ydAzYKO+mJZtCOmnVMwmhfN3CQiOT5vnlsDflq7OQ?=
 =?us-ascii?Q?A7TcyRax8+xYQ9KKn95W7J/JblgkAY7OeG1hp6NQBBBfsLCyp0mKdNuTqxNu?=
 =?us-ascii?Q?rMQvz8q1uHqN7VxGTzEpDGULDGdT4U1NIYwhQUvC6tM6O4nV7uofcI2HeLDE?=
 =?us-ascii?Q?5b2JkCItq4Pgu7pjW73Rf+NoL1z419YicBwfPLVtczNjcokBz2iFTq77+SaI?=
 =?us-ascii?Q?4PRxwaVPZNwEmtPDcNLXd151U2C8zXihylHGKqcO6zcspJhiwnvGpLLn/YVG?=
 =?us-ascii?Q?hVvq1yMVfl7eiqKwFHu9znagTWetSDvHb5lzZmJ9DGNxdXOEn2yHvk99n9hJ?=
 =?us-ascii?Q?t1Kt5ZGvXzh0GTorOzLhs1m2BSciJsVRbXWWDIoYOVETLdkq6dW0sNjIVB4u?=
 =?us-ascii?Q?1gabcJYTpOZuwJpHIF91gIeUfzqH7hzxlmcQ38yri/PDonHSrr0UnZoqGA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 03:28:31.4433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9d8a91-fa0d-4c8b-59bf-08ddb91884ce
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B98.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7545

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Introduce the specification of tc qdisc DualPI2 stats and attributes,
which is the reference implementation of IETF RFC9332 DualQ Coupled AQM
(https://datatracker.ietf.org/doc/html/rfc9332) providing two different
queues: low latency queue (L-queue) and classic queue (C-queue).

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v21:
- Replace step-thresh and step-packets with step-thresh-pkts and step-thresh-us
- Remove redundant name-prefix and simplify entries of dualpi2 enums
- Fix some typos and format issues of dualpi2 attributes

v20:
- Remove double-prefixed of "tc_tc_dualpi2_attrs" in tc-user.h

v19:
- Wrap long lines to within 80 characters

v18:
- Fix name and name-prefix of DualPI2 enum and attribute

v17:
- Rebase tc.yaml on commit ba5a199b2401d and commit f9aec8025ab5f
---
 Documentation/netlink/specs/tc.yaml | 151 +++++++++++++++++++++++++++-
 1 file changed, 149 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index e983c0c82eb9..b1afc7ab3539 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -56,6 +56,23 @@ definitions:
       - tundf
       - tunoam
       - tuncrit
+  -
+    name: dualpi2-drop-overload
+    type: enum
+    entries: [overflow, drop]
+  -
+    name: dualpi2-drop-early
+    type: enum
+    entries: [drop-dequeue, drop-enqueue]
+  -
+    name: dualpi2-ecn-mask
+    type: enum
+    value-start: 1
+    entries: [l4s-ect, cla-ect, any-ect]
+  -
+    name: dualpi2-split-gso
+    type: enum
+    entries: [no-split-gso, split-gso]
   -
     name: tc-stats
     type: struct
@@ -825,6 +842,58 @@ definitions:
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
+        doc: Current base PI probability
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
+        doc: All packets marked with ECN
+      -
+        name: step-mark
+        type: u32
+        doc: Only packets marked with ECN due to L-queue step AQM
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
@@ -848,7 +917,7 @@ definitions:
       -
         name: ecn-mark
         type: u32
-        doc: Packets marked with ecn
+        doc: Packets marked with ECN
       -
         name: new-flow-count
         type: u32
@@ -991,7 +1060,7 @@ definitions:
       -
         name: ecn-mark
         type: u32
-        doc: Packets marked with ecn
+        doc: Packets marked with ECN
   -
     name: tc-red-xstats
     type: struct
@@ -2284,6 +2353,78 @@ attribute-sets:
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
+        name: step-thresh-pkts
+        type: u32
+        doc: L4S step marking threshold in packets
+      -
+        name: step-thresh-us
+        type: u32
+        doc: L4S Step marking threshold in microseconds
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
@@ -3708,6 +3849,9 @@ sub-messages:
       -
         value: drr
         attribute-set: drr-attrs
+      -
+        value: dualpi2
+        attribute-set: dualpi2-attrs
       -
         value: etf
         attribute-set: etf-attrs
@@ -3875,6 +4019,9 @@ sub-messages:
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


