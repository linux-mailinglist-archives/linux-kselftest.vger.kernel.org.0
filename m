Return-Path: <linux-kselftest+bounces-37524-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C83B09739
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 01:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75A4A46D5A
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 23:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC242451C8;
	Thu, 17 Jul 2025 23:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="B2vIfYzs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012028.outbound.protection.outlook.com [52.101.66.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D174245019;
	Thu, 17 Jul 2025 23:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794690; cv=fail; b=cRab/6BNOPhxfnzuM2OHrXmt0xSxrg9yvSEDaY2GXfnFh7LifUM00zej6iz6rWoEATWE3CAocpJndN789fGkCS7Taq1NdLg5uAHgog1HvCAq6mSgtupxSXDvtJ2e9631UKcGxFfPwp9D2b8Sj4hacCKsny7QOR4d5zn9jyRSV2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794690; c=relaxed/simple;
	bh=FfE8K0E1bxyIfANuT8ef9bwnkIg7dKViZawzHpmBaoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KAbl8TB/sM8RPF1afq76j0OVixhFUTs2OcI0bObX2l8lKDnzZdQJ7Td2Bp6M/xO5HNiHYTsw6v97/EojzKNXAe0ZNrAIyHywDmlOylFEOFwhzLgKvldxy9NYp9fHflMO5P0xPsn3lkCxwdgHuZ97GK1tP89OH/KCPy659ofG5D8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=B2vIfYzs; arc=fail smtp.client-ip=52.101.66.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tp4usiEQi0Ngb9F6beCfzvQQdgveiHYeoTzoJuUvUQc1K0xcypD7FpOr6ZH4AOlH7ZmAakNKsjDsz8fmHvZE6zi9b28k0QM8qhv3OxZojO++hdf0Vt3et097mI1uBJugcqUPzmhjRa4dlfENtCwf+ciVRotm+TX7u/d/cfJsuVmpZ6DxyD+yWGY6uGpjdAu5a1cn79LAaYRSmWYbZ7ktOT0jkLXxCR4txRMqj1bEaNO1mQ8k7THtHNRP/WM4i3T7zdtI4XX1LnSuNvvfw/O1rqSrkzLU23kiQ7c9CK8m81zA0w2P+v/wdu7krk74E2pyEFR5refBRhkPfbA4F+CFqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y92OUkhdcTtpuk/R+YGCswrouhqwC+rX9Ds3aUvQu2s=;
 b=ne13uQ3xxf+pVu5FDfKeAdr9FlSJJSzZHTOqiz0eajHaV/vFDI/OY2RS3UVG7OFJjT+TUPs8/bSHJPZc+/sWHsFp3YYUK+x3W0PxO+ci6IVeU+IpMx2L6S/Q3C/z5DXagEhNJ/J1pftJDpobPMaZO6zMtmlfu91SV1BFqEZrFNR3SCYkK7WUwFFg+Fq9kMP8p4cjTn+ONbkUttE6jd3q/60zUM4778TOylhNY7GhSFPevqpBepYPGcWiOj1fp6wuGo/xHLzdsMNn9MaOd6Pu54KoyeQm0A1Az4RyAYrqgB/SSMl655s5wxofjaPRaC1BoXGL/K2K0Vqh/Cguo118fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y92OUkhdcTtpuk/R+YGCswrouhqwC+rX9Ds3aUvQu2s=;
 b=B2vIfYzsT2HGmeUkAwrBtc8whNqbLjtaGeeOxRFo6u7luxQ+DPPq5cC0g98clafpp7u3fDMIAcZqsnZZha6RP0d4LjErLimZrmTe27UuvRRV1wEcKML2OtM2qmZrbt18TsbY0lqRrAvGe/8NYJAo/ZgDY5UoL1Yzl8TY3jFltQhxCQv2mWv+1xWzAGifcnQ8uZoP3WW+U6743qT1T3RSqCbM8nIzPJlroHDM4NxthoVJsf3aWZsBH1FRSoITyfQSF4W7ExcW35SpoF3b6sIrhLBE5JE09k/+Gt8vvd1HB0agyUFMbtWcnhxRXGTGSGaAwapimMtHWcrkXeYBPlLF/w==
Received: from DUZP191CA0033.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::29)
 by AM7PR07MB6246.eurprd07.prod.outlook.com (2603:10a6:20b:139::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Thu, 17 Jul
 2025 23:24:45 +0000
Received: from DU2PEPF0001E9C0.eurprd03.prod.outlook.com
 (2603:10a6:10:4f8:cafe::ba) by DUZP191CA0033.outlook.office365.com
 (2603:10a6:10:4f8::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21 via Frontend Transport; Thu,
 17 Jul 2025 23:24:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DU2PEPF0001E9C0.mail.protection.outlook.com (10.167.8.69) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21 via
 Frontend Transport; Thu, 17 Jul 2025 23:24:44 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 522A5680034;
	Fri, 18 Jul 2025 02:24:43 +0300 (EEST)
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
Subject: [PATCH v24 net-next 6/6] Documentation: netlink: specs: tc: Add DualPI2 specification
Date: Fri, 18 Jul 2025 01:24:27 +0200
Message-Id: <20250717232427.69216-7-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717232427.69216-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250717232427.69216-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C0:EE_|AM7PR07MB6246:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9d70a5b3-21a0-4a3a-7ebb-08ddc5891d52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FOt3AYMv4LdBkVcA4EKqfQxFMuBVBoHLyIiibkZMjwyeBjdzQqR2FYuSwVNR?=
 =?us-ascii?Q?+bt4QWsyUYLWrMkuzlpBi5RhZW3AXYg76u/ctsszr27CVcNWmJd3Ijvl8FI+?=
 =?us-ascii?Q?PVfjPrGgVDUx7Rr2C3IgnVZHzyei/f13B3gQ57pyK+lHtKbtOPxrQQNofMX6?=
 =?us-ascii?Q?F9rRur5w65qg2FY4roR18qJFvPmbhjW9jpbdLqFpEOUwIltEfyDGNrC8qZkY?=
 =?us-ascii?Q?rOOlgBpNrAC8xnwxpSIp7KPEhlmZ1E7meTNJyRjfcNBqIpA8tgY6bATOkQA7?=
 =?us-ascii?Q?34+0cH0yyB2jP8SDfi8+QskrzYya02rQGRA1ZE5HH+7O30FaXmGFrsNuWDHo?=
 =?us-ascii?Q?PH9dRmv4su5neK5nFZKBg0obWgjuGb0cWgo8cJ/BClfNn94hXELAsesJYsAK?=
 =?us-ascii?Q?sLMftkluO1vidlAk/qZirSmsL6V6Wcy4bGkBdidoKv8N33YhtWeYbujKTwme?=
 =?us-ascii?Q?0b/ZCyZaiA5fmt2Q6YF45LV00ptLgG3G5wVppzFDtWcjsXuEVJtsX9BWROLP?=
 =?us-ascii?Q?DZTfzN06de+06gaSFvSZygI3V0pehaZa8flE10WDYyAhgJebvNvydI9jNatB?=
 =?us-ascii?Q?OKoqwLoA/VOcl3yQwMsXxF0MTrKLkuWhummFP8pbHkTGPwSX1sR+myAEb6f4?=
 =?us-ascii?Q?PSfOKDjYxec8vrQNsx5fJ275MXSrOB61eNztnFesabtcP3BeRm1DUCoduJXb?=
 =?us-ascii?Q?9NJyy0v7IzvrUX8LKyfBNlDcIx8o/fvCMNW8sv0RBJaNrKAVt6z3hZ5GweYc?=
 =?us-ascii?Q?zggdYOYjeFypbmvmixbt06QLiuTZ4jwIlS3CQj/6QdE0FyS3mzsxs5bv5Rb7?=
 =?us-ascii?Q?c66OhwBy+9XEoDkp4IwoooxP2vcR1OO3fm83m5EZOYVMavG98VX4C0NRrkxx?=
 =?us-ascii?Q?vUMrV0seBK+C8YchMC8ORxlYaAm5cRutHifzamv02PYFtM3nt8We1mXKIEaK?=
 =?us-ascii?Q?LCvVr4eR+Lqd63zKyMk8sxwCF4/KC2hsBZJ3AhDBMdndFkWQYyZuiYMln+W2?=
 =?us-ascii?Q?36jCqMq6QvHK/wLlerDpcyFiauOcpWnlotq853IEUOFBIVbqjZ7vROj22tdC?=
 =?us-ascii?Q?/+i5NUoZAfzb6y7xDl9UvwOUiV6MgHY+5p6CMoGkQPANxRp2uLa6NWxAg4ZM?=
 =?us-ascii?Q?9YoxvBo/m1dgkR77wySTITWG8XWfMmRguESqHQ7pOAw6jhLAaYJJbwygFper?=
 =?us-ascii?Q?+yhpFAjcl+gakSZhbnj1sCXZuRddi0suPXqYM032oBm8T+U6s6WB2Jlj/YAw?=
 =?us-ascii?Q?dplwGo/kOEgRPCp/M2XLmiHYY3qsTHasGpGGIURKywHPqaI4EL91H1G3rXqB?=
 =?us-ascii?Q?Z0IC4t3/AxOyxA4jOpDASPCT0/zfqZV85uZMkMfrYka638BN7xYwJT4j6MgX?=
 =?us-ascii?Q?2cvi132wzHvtlWM6uPYWeHvFr7bdevZuzJmaUGAEG+nyHqWJl02S3G1q5uw5?=
 =?us-ascii?Q?ez/dN0U837bF4iUvVgFXAOM50//ZlElEZWfgC6P1yHHwM1QjpPISApUaJrS1?=
 =?us-ascii?Q?UCUOjGoUP8eleyDUGpu6dzLSYozi9d5c37K/+KABV9bukoej+Gl/ysKgvmEJ?=
 =?us-ascii?Q?5PoQgP9Rw9WaFyOsnHw=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 23:24:44.9137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d70a5b3-21a0-4a3a-7ebb-08ddc5891d52
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6246

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


