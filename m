Return-Path: <linux-kselftest+bounces-37812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4021EB0D678
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 12:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF08189FD6F
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 10:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59ED2E0B64;
	Tue, 22 Jul 2025 09:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="nuS3v2Sr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013021.outbound.protection.outlook.com [40.107.159.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BF92E06ED;
	Tue, 22 Jul 2025 09:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178376; cv=fail; b=TRfWKvuMob2OPFwfmz8hoW9AuM3oKu4KSPom1VAU+t/zzRyJcj11XxJx6D+0/w2RSA+Qr6jM4VykiQ4QJfUXV6QKZkPTiS5xPp8ynA9VF4NuaS8kuunzhSkfOFb9P3sjVZq3gZ4R5VsTlgf1cwFcI7P7rXWi5h+rWXudOPJsGQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178376; c=relaxed/simple;
	bh=FfE8K0E1bxyIfANuT8ef9bwnkIg7dKViZawzHpmBaoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihPhBhnTzsvD/rUYd8GRkmi6v1Q/xp0dMpGDckp+JO/Yit7m7986rrmkIfyj64iroKH4JhYrOtrF38jy2HlOl7K85Qw7fRlZIBaz54torIvrdBv2QHVRZa3UgAFeALXr3ZMWzpsk35sp7UHbiGVq90Cl0WUNzEI2/g0rEFnfK7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=nuS3v2Sr; arc=fail smtp.client-ip=40.107.159.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovTDLxOMfSoKYLYKm77noqWaMsB07g+0imgYn/jED14iU5yQ2iiSkAuo5voZUA9qCtcaEUT1te2f1h187FwOW1FbXM+gYODFIAUuUJO9DDv+ssF9xXtt3oDTwWtzbegszP0pTrtXaAm97QR7uU+4H0Ka0t5YfWdIzwDd6dBYwBjK7efgeJc+tmhoezCPtH8Lpg6pCUbLS6+5A4fmLGMmwPE25UV3J6t8X7TRhLKcF24XdEx4fv2Zsw7r0K2PdE06aUs9Mx/obopG+bLCX1hXgfw2Uw6bUPage78OOHYJ19zZuulEZTmkgqQ8JmT1xe7k7zupA2lECsRB6AA4xXHBIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y92OUkhdcTtpuk/R+YGCswrouhqwC+rX9Ds3aUvQu2s=;
 b=FsnVeFlmlqbtZgaXLAH6k7IItUb42VjbPQsbnM3UFFdV3w2klbmaWw1lh8q5YwcLC/biQPKTmUW2DL3IoD+uB302XNALoXZN7AtidUc5QKxv8i5kKBZcrEptfTQTlVK42DsUH25+LyT+Se0c/bRt1e0w5R4VI6wzX6mJnGQCal80imUvPptAWGYJ5cXBA3D59NvWoAUrdS4NheqX/Lh3o5j7O/+c1qfcQiEmna6wCQ7myciKVlNwhZW5b7Wuq718aNq20EdFBLvhB7k3wO/qK4w1oyM9KbTTa72St6nH9yn55SI5rUNftxwJTRYQaBLnynzVzev10nCAssgmakwNgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.100) smtp.rcpttodomain=apple.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y92OUkhdcTtpuk/R+YGCswrouhqwC+rX9Ds3aUvQu2s=;
 b=nuS3v2SrzOublVca7pUZDo+ZxGnbU7ODrdXgOgoDgRT4QWWwDP5T4J3Wu1vJRA9zasLstDcNnl1DpngmB8ksy6lWbw4XNB1WF3qYmLCE3locEXe6jwd3zJBxPI2WyZBDeQVVV+oCGwiweQ1Rjrnr/xwq4wFpvwnFfM/3QUE1D/03S8pK78KIIMCqEebEb8x8EFcKPSdIZ6rb4y1ybZsyXZH/8iuwCsguooEGxtL1IlGN6RdaS4bIB6aEs0Gz/4Y3yCNOU0dhLR4w2QHMnEb10KrpwlJJjr+15cy89l8M+tTWm6URK0AM7lJbXOoihDdQ1hqmCLhvVsoIhPmYggMv2A==
Received: from AS4P190CA0036.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d1::7)
 by AM9PR07MB7171.eurprd07.prod.outlook.com (2603:10a6:20b:2c9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 09:59:31 +0000
Received: from AMS1EPF00000045.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d1:cafe::96) by AS4P190CA0036.outlook.office365.com
 (2603:10a6:20b:5d1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 09:59:31 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.100) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AMS1EPF00000045.mail.protection.outlook.com (10.167.16.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Tue, 22 Jul 2025 09:59:29 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 1FDEF68003E;
	Tue, 22 Jul 2025 12:59:28 +0300 (EEST)
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
Subject: [PATCH v26 net-next 6/6] Documentation: netlink: specs: tc: Add DualPI2 specification
Date: Tue, 22 Jul 2025 11:59:15 +0200
Message-Id: <20250722095915.24485-7-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722095915.24485-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250722095915.24485-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000045:EE_|AM9PR07MB7171:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fcc62c77-5a2e-4475-1b1b-08ddc906732f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NCw1fi42cK3P3aCk3Nq4O9a8R8zJA03Fr7eG1MB7UgediVLihvkyQ8t5mZSv?=
 =?us-ascii?Q?w4828py885GwmeBjFTGNZu7RdpGRmLIpeqYVTz/e+gtEewiPN/Rz2QNmnKiv?=
 =?us-ascii?Q?O6sRC21q4Qtx37kqYoTL/bZrGIN1Nn9FZbrwo5eRVNGfiiIFWI2udlJ5wGpi?=
 =?us-ascii?Q?B0/DVVrZauR84XjItOFrl11zCsieacxu1278NHvEQoGJFEtt3hBGFng7fObO?=
 =?us-ascii?Q?THPbehtDp9v9s5KJwDVob2lXpH5SPDoVA4i7o5IpqtkEy+Sm5jwfejrKpmek?=
 =?us-ascii?Q?+eh2GP+Cbd4e31OnAlohZ2KTPgnuzksfZxXIVlcwZF7Q0VAMEyzyyKpQJjCf?=
 =?us-ascii?Q?VrLBWZTcDr6Y8Ixg2hmThKUAoFh0HCt2EW26wOnoYrMuPeeUmrZLKeFvUuBk?=
 =?us-ascii?Q?A4CvhNbdo16/2hGQmp996hQRCfvdTRheue27b5oGlVIQ11Av0OjQKTGE3lIF?=
 =?us-ascii?Q?JDm5lrl3mPecQZT+cqqaXOwo8kzRNoNG2usNe32hicAssnAJTB5ibvvqZ8Ug?=
 =?us-ascii?Q?6dNBdQ1TaMqm0Y4Uty44Q8llFpxIBYDF/O5T7RKDNOmrywNqyfz2/+cHL6xX?=
 =?us-ascii?Q?ybylMCSTEJl76ayn4anRennGRntoqT28jDBZzj2PBEB58wZu7Q5UIx10K/F1?=
 =?us-ascii?Q?5CP8njcCH3MTmK9GRDZZrC428jENv62UJRJo4Ez5hnkhV3w7b2RoC9buJKyc?=
 =?us-ascii?Q?QXiM2mKPWWBcSdRYBJ62dMvr0v3CD0OWoK2LvRF9ofLnL0RIZx8DbBXbRAhn?=
 =?us-ascii?Q?7+fCoDWW/xAnF8vIf7MGUyTK6xb8PsRboXK86UNjIwu1eayxKxYjiZoWxudo?=
 =?us-ascii?Q?wi27ZYrm3Piy1nnA2OT61S0rS6ukW+PaAPjNchN+DKWqOAmg/gpKSm8PrwKA?=
 =?us-ascii?Q?wofYcSXpxKqZCXGJzj2ADgcZ7Xob1qsit77N2ZdSdwLBSVU1urag7K53mH43?=
 =?us-ascii?Q?c7S/zyN1/7nn+srpE4F+zJuvgPPkOnCZuyZdsDcwVoMg2WnsF+wJBDJI/ycv?=
 =?us-ascii?Q?yh7FwG1hyK8lkLF+MLFWOCxYwByPEZqKqkEa4yQWlm+mUI/oixQHiJJp1YY8?=
 =?us-ascii?Q?6Kq7HiZ8TUjbYWN0MOBAQAJSLUhEwB1Qqk4aU3gJXeP3Mogd2NJXFKao1Dyb?=
 =?us-ascii?Q?ZerbzxLR8Fou0sLz0+YI7uI3S2qm/8ANFqbLLq1Y5ZLpW2DABXAWw13KjIMs?=
 =?us-ascii?Q?A2md2QSp3WXnZcEi4LbMNHxG1t8vdWxHK65GeWO10/qofyi5wJS5FAdtcUiD?=
 =?us-ascii?Q?w37Q8dYcRz3caPRBT/KsP/lKx9YtazNkUOI1KMzp4ZVJ/dKXuInjXC5U7wXA?=
 =?us-ascii?Q?moD95Pv1kkm14a/yoeecDL6B0njTktUYQbWy2o8vgrfDbaR0CgT24j7ijxMV?=
 =?us-ascii?Q?1KCv5yHQrdBZT/ca+Xb9GL4yszqY9crohOVkgUlgawtsx44ocJ0R6dv0+ax4?=
 =?us-ascii?Q?gOAMmeKFuCWViks0nlRUOZhIA6MyM5ON5XghE2u/DmcumrSJC2Vu39pwN5+X?=
 =?us-ascii?Q?c2I6bbBVjpzE6DkU6s269akA0sEd1sUvkfLXBLr5EBz9Td1iq35E/3MBdiou?=
 =?us-ascii?Q?mT9kEHiUee9gaiBXN54=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 09:59:29.5442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc62c77-5a2e-4475-1b1b-08ddc906732f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000045.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7171

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


