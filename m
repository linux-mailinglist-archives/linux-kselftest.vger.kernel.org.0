Return-Path: <linux-kselftest+bounces-37204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7A0B030BC
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Jul 2025 12:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BE5D173953
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Jul 2025 10:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE81277C96;
	Sun, 13 Jul 2025 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="T5SkmTfe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010002.outbound.protection.outlook.com [52.101.69.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1537D262D29;
	Sun, 13 Jul 2025 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752403987; cv=fail; b=rk6prBP070HrAG2gWxiihGuIeQbyQhk+H0Id6mxK109oVs9BIVW2g0c3FG44jr9nk/UCOMlzsvKaJeT84l8ZZ+2QIulMErfgScY3L+9AD8XCchr1mj5UlOqWciA3mEeAleoC/IpwJoRTQbi4Eg2YR2yP15Qv3yLwZ6olDY6v4bY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752403987; c=relaxed/simple;
	bh=FfE8K0E1bxyIfANuT8ef9bwnkIg7dKViZawzHpmBaoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FsWApIb7wpMdB7Zlwi76ugc5MLnAnF8CfPX7casLCPSB0s8uY9/dMnnh60Rk8OUYWCKrnjraXSmNkcaHQYB75rNRr26H7M7226iGSVuPn8X+DFXcbX1d+mNedND23VbpZDezSpfnSbEyxPN9gV8zGGkz0qmNKfsTjMmDmjbzTAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=T5SkmTfe; arc=fail smtp.client-ip=52.101.69.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgmU1oeWIDt6aoyGTGP6nDJzXak4jwso3GZP2c7/+kcr8Djx+4NX06Uni+uszHLz10nJqlxUl/ROCqJUbQAMdQrslWx8/S002sn/Pc5FRLe/f/z2Kr4u/u6MdHshfUysvmlDklFzwYuRycwYCaehY6FR08IdsjhPUo9VjOwhfkOM74eHdsFEbX24XzH+C01W8I5KG/l32hCpc4i1a+4290CG/U+NDMkXfbydO+vWa3zA6EpAp9H5uzaKM3Y4jcyGWa7O4VhlPhIw2L3R6CeOgnext86Lnljzi/QWDxhvHd4VbYMkC0+YrzV7DhurLr4kDxkFJlXfVlQgLERIJZe2ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y92OUkhdcTtpuk/R+YGCswrouhqwC+rX9Ds3aUvQu2s=;
 b=JX9iGkKMZ/tGSDa8pupZ8oyQlTuXy+iZNaRNH5+d9V98f5BPj60/fbbr6rva+ijxFjIP9fWM4MRUrRqptKZky+k8IpVbOPwSki0PmzCJXpk7TlfWYf2lksVTnDtvjeGWFpQBMUAydkUKkO2vh7pd32dhrfKD18Y8NyHga31q7Ad58aUTfpYJCTEOWOQzL/dWe/LoPPsGbIdT+No74sZPtRjbfU65YmbgV5x/nn+V+zCA2MoG43golXwetGjFKnonxHfASOhsFZZtNarCJo+SboSz6VM94kaYMNMw94r63khLbuV9tfqlqjXdcoFI+0Zz1aJxJ6CtE5RSRi0XrUwNPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y92OUkhdcTtpuk/R+YGCswrouhqwC+rX9Ds3aUvQu2s=;
 b=T5SkmTfe3Lc7EW21ekTvQu0AmAycMcSIIr1k6Pa31xxVzNK3TBWp/IffhZrjWwdKXpcFMPvhykpPIY/n8EJqidtItjtwgUtYVmqOKVaHQ/oCIEtL1lYz2oYlSWn8pF5zIwPVJQs82vQk6aBx6z+kRrzCpot+yeH8ptvkeE0pPpMMxtebkdaj0UTQ3VMXfVH0c7Omft30i6D5lZXe1g7PsOZG7vFksj648hapm6ZMe2dX3pcbB2pMNWtut2m6jc4AO54Ye2b72wE9fBhXJ/v/DOzZDHcXVXhrIOjXfUB1mCMlWJ9xAztfpCLITvxpB/asrLuuxlgFxVBXL2Ci0JK1og==
Received: from AM0PR03CA0051.eurprd03.prod.outlook.com (2603:10a6:208::28) by
 AM9PR07MB7731.eurprd07.prod.outlook.com (2603:10a6:20b:2fc::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.27; Sun, 13 Jul 2025 10:53:01 +0000
Received: from AM2PEPF0001C710.eurprd05.prod.outlook.com
 (2603:10a6:208:0:cafe::24) by AM0PR03CA0051.outlook.office365.com
 (2603:10a6:208::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.28 via Frontend Transport; Sun,
 13 Jul 2025 10:53:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM2PEPF0001C710.mail.protection.outlook.com (10.167.16.180) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22
 via Frontend Transport; Sun, 13 Jul 2025 10:53:01 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 051091C0033;
	Sun, 13 Jul 2025 13:52:59 +0300 (EEST)
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
Subject: [PATCH v23 net-next 6/6] Documentation: netlink: specs: tc: Add DualPI2 specification
Date: Sun, 13 Jul 2025 12:52:34 +0200
Message-Id: <20250713105234.11618-7-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250713105234.11618-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250713105234.11618-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C710:EE_|AM9PR07MB7731:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4a989e27-41a8-481b-9155-08ddc1fb6fee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DqXbSxBkfOsWLTsVyYNqD574VGb1rUPjl9bXgwwHrVYjJ1skWnZB8gW4FhLe?=
 =?us-ascii?Q?Y++7B2ink+C/S4xy9i9tztHoOXIML4ywZWKtrXqdvYXd3u7LECFN0h1dFK3n?=
 =?us-ascii?Q?2RMfzofQV+ohOM48Fl+7FFdXrmsCmj8kkxmbv08fipC/8JxZQmpGZYFYHd5l?=
 =?us-ascii?Q?jSsppM0eTixBQHQWJNV56AIWILt4ffrb3DtU6DTgSNHToIKLg+muhSG0UifT?=
 =?us-ascii?Q?DIwILN2V2ioXgx1F/Mcxc2jgohmC+tqIJwV1+OlgazhdZcGMpgkvjEtaOcWV?=
 =?us-ascii?Q?HF8RVXTiRSsZczo5FUaDAoQxsE4Gh82STKhiufbW8mMjvfVXVl+o1ZzkDRiB?=
 =?us-ascii?Q?kd+B99VPnm4/FO2PiM1VW+7MFEa1yoPSmAmzpct0CrTsG8iiln12U4kWvK+8?=
 =?us-ascii?Q?050DHnw/5jxm8VpmXK2dxtTyNAsrn5uaPRP5Bx7d2nA498g4czKao/V9sqiG?=
 =?us-ascii?Q?Qfrk3qkv2nSFFWBZfW5EqNKE+2JIWvMfZXUuh9TrJosPk4V349PxB3OTCkHY?=
 =?us-ascii?Q?batm8RPRHL7kvt+0Njatynl0UYiNJVU9p2l8HRpyHGLaLQ25n5ztBcMRkZUf?=
 =?us-ascii?Q?gX/ZB9YOzTJUDOO5aelvt6/fgvpgkYu/+AqKL7pMYNjy2uJhNX3wxJHrEWeE?=
 =?us-ascii?Q?MQ2ypHldre9h+eVA+ItipyPhjXevCCHv1fihDXEUX7q+aNLhPRmn6LvjCtJO?=
 =?us-ascii?Q?ZrK24FS/lCGHjcc1MD8JKldcr8s/gnEQK3tUO8G89F8iA0ss8Qv3xz2uF2ZK?=
 =?us-ascii?Q?rXsAfdQ/1HsHu/pRepGIsrek74L2mjbClrmW0ZHX++2iFJe6QqyYWEqGcaYx?=
 =?us-ascii?Q?XQ8i8JLGhHCkuZIBQABTriegmajlXv7V6mTdgMCJCMXdPAlzoJKwmidcoM45?=
 =?us-ascii?Q?AJWvng5c+FDY361qOOKMJHQaTpi2J6hxck4/UYoFbs39p5pbsV7MZWM7IwXy?=
 =?us-ascii?Q?y/WF/SytEjAiZDa3UZ3WaZIBHFFD/qOESzFn7CLiWv4Pj3tcT2Xh/XZJN/Oi?=
 =?us-ascii?Q?L3Q0Kk4um665u4I8G9wMJLynsS2eD0pSw7bv1mQwcC2ed+8s+6wRgVskfh/i?=
 =?us-ascii?Q?uIXgFlucclilYo5kKL2KQa/7cq3TGi0Q2gSVFEr/50VBCM3iRggRYFvNPXhu?=
 =?us-ascii?Q?xgiwSuMSQGS5tcGHJq++fvDWp3qBs7rGfyIvYkEBZFMbf/vketcGm6t45mRx?=
 =?us-ascii?Q?1FeM/J9BY+eVxx/LTkFqgKWfmtXmLMKbE2nTvjKvRfx6o9bUgnktUZM2xH2L?=
 =?us-ascii?Q?P+uYoMG/KSR4oN0J41OnsxECiP2f2yjCa+B/fnq7OjhkUKkKqCUxCBmXVWzP?=
 =?us-ascii?Q?khF7JRelb1bdTE0Ovo95AjP7HG+2FvzNxpzP9ly5gAufazaWjJsWJH5SoIst?=
 =?us-ascii?Q?DmOohrZQChDOXT0F/ZmDO7xor+rnsAEV+wQppG4ooBRlZemd3u0/n8uqfO82?=
 =?us-ascii?Q?HJCdCktr5QtJbfSYto3poRtbso2Y1F+0o9FBC4adPp5+6zBYfVumE88eBcPo?=
 =?us-ascii?Q?ytDdJjKmDN3VZ3o5Aq/B2cdC1wyHnWkHgbYvCKPcEKevTuSxFD94vkKtxT+E?=
 =?us-ascii?Q?NhVewu3vvXNAQ133Ibg=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2025 10:53:01.4927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a989e27-41a8-481b-9155-08ddc1fb6fee
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C710.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7731

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


