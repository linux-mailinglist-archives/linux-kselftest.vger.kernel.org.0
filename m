Return-Path: <linux-kselftest+bounces-33754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70139AC35EE
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 May 2025 19:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCBB01893887
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 May 2025 17:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813FB216605;
	Sun, 25 May 2025 17:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="TrXn2qTr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010049.outbound.protection.outlook.com [52.101.84.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6776433C4;
	Sun, 25 May 2025 17:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748193874; cv=fail; b=JdGlyf4iGR2awkHxLP+5sd6SLlab+S18ZzBqcsB5IEI1PKNWSonS7rFAg5dmUop/xplTyNPyiXhj96/QZozRKxskXx7EoUjRnhWbyzYefmNbH0cT1oCBacYTwFcPTNhNtD7B2ysV1T+GQ+rMSnORFTJexofN/yibFx4YfSZGw6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748193874; c=relaxed/simple;
	bh=hLCYnrVuwoduCLUbqkPSjHb65SPeNMhDXd5OveZiOcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kta6YvaRPhIqTRn2OsepkjPi8ADc2dg8s7B3pXrtX6YlX8/8P4l+MHpenexD2hFKDb19d5N9BCIpzjlRzvgipdVolOcjeYIgMbtZ45yFiFhrFO/U4SMFL+aqgKSf/1Hv81dRSyaG4zZdKgApiIc0AkX8QVRUhD5VM61nk8/a1F0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=TrXn2qTr; arc=fail smtp.client-ip=52.101.84.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0O9p3qdwqHJ36bETmINM2menSqi12kZHYiXWP/sIr3v17T9in9fcZ4IdhQ4uDzTULxjrkmjzBhiSUlfotkThoDjHyQCNDcBowV0jRpKhigOhRmSccRNN1eoHqOPF3NsdcPW4mqCRp2jqW/ZcAx/KqeTJTU9t0T8gDWFyeTg4Xv4TikGk6e/96nl7UGxkKDjZBPyomsuqGlPOFufrDloo1zkstLEmkzeHLVsEKR/h0Fp+VViB49I8ckFXPfRinhXmeKSYdoaMj8EnQjQyBTkmaJ3UEGRUGTaSXi+DTyiWkBmL1o9cLXDDpdAAnOz7DdEIkmH7YWWVinbd4jaKopHtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hoOeTBQUHnUi66jC4kNiiQ8svzr4H5iPoNHR3+qvgxQ=;
 b=iPoIDiGnWdrmxtwF/GZaip/Me441QMZj1bQEasT2/oS4waAHj3+nRlXmIg4XtoekszIIStXA9fI8ikfKcbuoh6bemZllP0CEl+BCEHYluRlUwA2orjYYSiFLO7L4JYqou7YqkFDz6T7kJsTv9pWw/ne+il7c23rf8rniPBn9bl8hC9/DXz0pcIOk+p997gMxY2nzYLZMclB7w8erwVQAhQyZSrQbit9Bjf4uQRACydXJgfZBWs4giCJeAfrZdIs7CslHQM3qRRD41Hcw9KP6rTGv6cXgaCbDXqfjGI6vHcXpAVvhwyLJrxlvJ5ohzTagXZpMZFX1pj2rcEumAG7+XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoOeTBQUHnUi66jC4kNiiQ8svzr4H5iPoNHR3+qvgxQ=;
 b=TrXn2qTrifFY74pTJ8l3dyhlD7TWL6/UkXVpXtuPGkjwFXzY72RfxRycFY2uvG3CXwgxEm957v6kO99Fu3ksOllkehcstMGIaFF1uXaG8WVlczfN6qDL9fAKCqkOJQzEmavtR7ZMY0YZqxBcRphYdQr8vDe4G/f4NL30PAgMLuwn5/aMrSqyfJJbeL/jZQkpIVrkGe4WQDt1XN7S7c+MMnE8WM5zDrWkZeBGK81Bq7ero3YXzWdonOTRvIINUpSVtaXKF4JcX159IUBaiQq6kTnIn4hK0/7uWia5jau4szUx0CfMhzszhPjtUqdocpL01NF6Cri/M7PIr2dhegB3Dw==
Received: from AM0PR01CA0136.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::41) by DU0PR07MB9363.eurprd07.prod.outlook.com
 (2603:10a6:10:449::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Sun, 25 May
 2025 17:24:28 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:208:168:cafe::49) by AM0PR01CA0136.outlook.office365.com
 (2603:10a6:208:168::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.25 via Frontend Transport; Sun,
 25 May 2025 17:23:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18
 via Frontend Transport; Sun, 25 May 2025 17:24:27 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 119F32004B;
	Sun, 25 May 2025 20:24:26 +0300 (EEST)
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
Subject: [PATCH v17 net-next 5/5] Documentation: netlink: specs: tc: Add DualPI2 specification
Date: Sun, 25 May 2025 19:19:24 +0200
Message-Id: <20250525171924.15603-6-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250525171924.15603-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250525171924.15603-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|DU0PR07MB9363:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 37734d98-6118-4f8c-567a-08dd9bb10077
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?PaOO5f6Kr4T5NvPeJlHoAIew0Y/8cXcCOyVR+Vfl4Cpe3qUJaosQcvPPlQYj?=
 =?us-ascii?Q?1XHFkR7dP0+/zqxDTxNMEuBqvAMbwS9UTTfV6kwLSmOaDJ+Q6OoNklXYswg0?=
 =?us-ascii?Q?WwyD7c/VRJsNkJwtnarI3yxtzbmQetxoEPt2HwsHJiKsrv6iWacIBVAIp8a9?=
 =?us-ascii?Q?cjBaO8LvmilJubWMOjTrtJWieWKhkLj4XeRltV2PtKUPuLR2uiFDEZOB17yQ?=
 =?us-ascii?Q?TD1EFS/2Bm4EYiF2z6cWlhMS2ou+umbWYcE0V1Q/Y+BYzlXhOoHSIFNKNy+O?=
 =?us-ascii?Q?NmPaxW1Dg8XxJleDTY8codo+va3LPcgca9kFR/bE3x24F3ocQ3FUFxvoc4ev?=
 =?us-ascii?Q?W+cWhqusk373goo/vG+EtPnFYQkh7eMW4RmhfyaX/fZJ3eN7XpvvgznXJpns?=
 =?us-ascii?Q?NrlaNeUSeSRVcTczcqpAJemg4LcfQ1jMSWSAh1BeghTIlzo//fzkk5O6o071?=
 =?us-ascii?Q?IHHMds+7SWr6GCBGj4vLu/UVVkBMJ4pqdWkNvnT/6rnmrpTew6pLRVii0ARt?=
 =?us-ascii?Q?QS+a2IPfJ2+YIllcspYYEO82tSwKggKM55t+LoT6tdoeiOolsMmSq2aNr7kR?=
 =?us-ascii?Q?vqxDWeknR1h9VWiGr9PwDtsf83iz7y61pGFGO1ogshm7acJMkW+rO38OEaaR?=
 =?us-ascii?Q?0i2Ykd/0jJFTVv9beVoBs6anvsIldlB27W7CvbcP++1Rg98w7URyqeHvZoA2?=
 =?us-ascii?Q?YbQmU/4RHux6/8fD6rSLBHOfWkTsTfjcvbU8hvn+sHC8ExSvBNy5OL20cPgd?=
 =?us-ascii?Q?ckSDHntMSrmyMEJU1iyYxADq+vhliqbHvRUIYx7hs73vjOTszVr5v55XcAIC?=
 =?us-ascii?Q?ysLl8NYRFj6uhPgrpbvAzMBhLA+m+b0km6TbkxOMHsXclvNZXCduKpv7+dyo?=
 =?us-ascii?Q?q/cjwtnA9nZhbIYJWv5NI7RC3I7xuxObKK4PY6eSd0nfpcZO8y6tUfwlG0pF?=
 =?us-ascii?Q?4ADm7a1HpUe9Ndnw5GFNsGpjXhxMUyQSpC+d6NvXeJPjpT9KhFyliXw/dq5N?=
 =?us-ascii?Q?B+B9KAvUDOXDUza8GjEdpi7C8F7ZHpVkguE8mIsy4g4oekI4xEuIcmR1LpiA?=
 =?us-ascii?Q?gQHXjlLMSaAzTOUAY9dMSP7iSnZzD0JGtqoFjEVyslVgExtn2BUF5F+A5jhf?=
 =?us-ascii?Q?g6FbLS0oslOmnYJIET/zMbIMfA5VPecrG55/U2Kqo2qMs85zuh7rJtJZXXaz?=
 =?us-ascii?Q?Dqpyuyhrmo+gLiMfj9X44FUxryW8JS+HhVBRzIGNt81tAAqg8LYq8ShAmA6b?=
 =?us-ascii?Q?SJUpJE5xCeRAROB+fQl6RA5bBGmz4HAI9G0iR3m8VNkOhmhbQkFfdBUumNtY?=
 =?us-ascii?Q?g1WZaYKg/toynb9xprXub9ea8zYT6d/qJcl2zN9cD3wxTodpEzN6ceXpFZTS?=
 =?us-ascii?Q?JRqRuZtBRKWQEgPoCvBckS8nLIXF46i+KW4XY9OCbcmgwsaA/DoQY+8pC/ps?=
 =?us-ascii?Q?J8rbq7rCkum+6EyydKjOLR/ShbqsZUmZ/h0QKyUmRX16IyEhXsfCq/fOuB0q?=
 =?us-ascii?Q?ddNC6YDgtcnPgjDV8lJO7WlduGJp96AekHxQLziHx+HMLs+CIiGGnoQYCw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 17:24:27.4884
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37734d98-6118-4f8c-567a-08dd9bb10077
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9363

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


