Return-Path: <linux-kselftest+bounces-37651-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E513FB0B1D5
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 22:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB2BCAA05FA
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 20:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CB42877C4;
	Sat, 19 Jul 2025 20:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="XLQTM7H+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012032.outbound.protection.outlook.com [52.101.71.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D5323027C;
	Sat, 19 Jul 2025 20:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752957730; cv=fail; b=ZvO56EthGTmI7jSSdYZC3/Zl31lcUMIKJTHr669+WQMa0OH1XAJWjQ04eHFCX5mtfhABUsCiL1m5DLxEnnh/OdL2KQCFQtUD2XFt5cl4jjBdb4uowHPWYofkI2BfIGEkY6rDanPJ9sdHkeajKl8jwk7WFOoHFxzvjqxxiPx8eIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752957730; c=relaxed/simple;
	bh=FfE8K0E1bxyIfANuT8ef9bwnkIg7dKViZawzHpmBaoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tqo4E45E5Vadu7WCtdzlzfpqvmepeqBA34YCvb2ThICcmr25xl/v9VfMTLrgYaZkB1uTmH9FcoDJN5RwGJzQxIwt9psaG2uKq75+tru119gQXVhzTZuRzYL6NHIbO4i13vglQliMCJ9CXvTXL8u6CAe3t68iud7pmS99QR2qYPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=XLQTM7H+; arc=fail smtp.client-ip=52.101.71.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDdR7ayELivCwl+hrUp9r3xWQfUVeVs3T6CcT/CF45ii4Q1dsEAigft2Ad9KPv12qfqrba5sq4kVd0hG5jLCKZci5r3+I6AxJ82ZWNOIZHtqJg59Tp3GKCbBJ9RzkQlyzLd/XzEKt75gtEE3mRuVhlWhghZuBbst+lw808TZm2lMZ8ivgM98TpYhTcbDMFJLyeh3TWp281Ct/5yACRbjtluMyOfPK5mRyQl+VWZM3xis9UCpCJ/RcfwRSpyByH6U21Xm5zTemY0MHLguckKHtm8Yhlxsitp3zWWfQzQ+/mMlnC7aI99mPcut0oFsjrEWa/I3UsmmYToEUe/irFRemQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y92OUkhdcTtpuk/R+YGCswrouhqwC+rX9Ds3aUvQu2s=;
 b=In4JJS7rxCIZ6mWqT8Qc0x+jRCtMzV6SgYRn2PcYHoGO6dHLFCMWbDNYlbwTw5hYVa4bl2wakqkqCszvz0H1sw0zsBEZh7c/0kQRasuY7jC1p0nALfZTMyVjAYyS3Rlie5mw+Y1CdksDUKsCeDJeCpW1PGFk0yEcsodavoDZqDr6UsWD8/gy7NKiCoujSDkOai+cZ80yPchj8yA+WA4008k7OvTxjfnfndbotujM32svhZgdOgsgfdnYrjg6LZFeUbhiXXsbk+UAFnstTNcB4rpZ+W+frUlqgVNwOQghuLhKbpA9+us5G/w4ehKO2Vj+Zuhx6Hej4LvQd0WkAN2HnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.101) smtp.rcpttodomain=apple.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y92OUkhdcTtpuk/R+YGCswrouhqwC+rX9Ds3aUvQu2s=;
 b=XLQTM7H+1LQ5tLTfD9K6O0tWjQehtw1mJ1Putgs5g8i/Wui/ufSCNWD2ftzfrqA2B5ToInd0grfTVfQxqkUNGvjVkf9WuE+DCXOF6cRVqIkIi6Cf+FYDMs3QdBbEXc0AGsJuWxpzNkArsVwTV6rJ+eGvGn7i3npuX95t3f5x2TPsEWnJHUi1jRtVpkglEBzEQRKsEA7fJL1Loymg2WPDXsvDp0nQB4plJkyE9flYH8eLTtfkk67Vp82IoEQsh6FjtnWyOETWSNchsI9s4ET6yyl1MPVodc3rtIeAB+X/Fdb3R1a3XM+hr23o/zRbzG2/LPSMGN5yc5SnpUpLT0qEvw==
Received: from PR1P264CA0101.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cf::9)
 by DB9PR07MB7962.eurprd07.prod.outlook.com (2603:10a6:10:2a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Sat, 19 Jul
 2025 20:42:04 +0000
Received: from AM2PEPF0001C710.eurprd05.prod.outlook.com
 (2603:10a6:102:2cf:cafe::a4) by PR1P264CA0101.outlook.office365.com
 (2603:10a6:102:2cf::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Sat,
 19 Jul 2025 20:42:04 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.101) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM2PEPF0001C710.mail.protection.outlook.com (10.167.16.180) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Sat, 19 Jul 2025 20:42:03 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id C69561C003A;
	Sat, 19 Jul 2025 23:42:01 +0300 (EEST)
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
Subject: [PATCH v25 net-next 6/6] Documentation: netlink: specs: tc: Add DualPI2 specification
Date: Sat, 19 Jul 2025 22:41:29 +0200
Message-Id: <20250719204129.15737-7-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250719204129.15737-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250719204129.15737-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C710:EE_|DB9PR07MB7962:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c5d1071a-0035-4a33-5fbe-08ddc704b7c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/ZwBEBkuXvG52EG5FAIQKiMmlTnGSRf339tMJq+GilcmPq3N8T9BBW4ouwvh?=
 =?us-ascii?Q?r7Lu4TchlAXUlT3w2g6iwbbXk/FRqntcfiXj+7qSDxikwE3EtBVjJB4YHPAM?=
 =?us-ascii?Q?/Ukwcq0SNVK48WzDc+tMnOvurE0GhMelJVcX6MyxF2kfgtpXM8g4XOEai2ZG?=
 =?us-ascii?Q?aAqib0qpq4ULtPtZriT9nwMT0k9Q9BwfZkhdxdOoCioG0cV6ep05YAPE5LXs?=
 =?us-ascii?Q?t4twInkhsipTnZN2e4qoQJ6ord/NXub3T7BBnbY7xNt5Lls8/UV+FxFoN9Vk?=
 =?us-ascii?Q?+0aXqhrENrZJSwXnfkuuys+cU0iTGzFUt44tv3UFnL86G/bZnSY9AUAyoJFy?=
 =?us-ascii?Q?Kd3BmrlTwjKxtr2EM/ElC0aHq/NlG7ETYgo9i8NMLwsTrzqyAB8143KWF7uQ?=
 =?us-ascii?Q?/l0tHXN21qzgF3R6Bc/6gFi31Zrk+9u3cUVfxef2ygxXyMUDb5oQSKTBd72d?=
 =?us-ascii?Q?f5MHI9eZvaGN8Trx+QaHxeEONmPH6S3Ro80wGCHq3zNharu4AUwqBRQA/aNQ?=
 =?us-ascii?Q?iWR5fWfDdjiS4rIZ8diJSHM6ZQe3DfjUhWMUnZOHcCC6rHyJUOfvnvyDcIcm?=
 =?us-ascii?Q?5z2MxElpNPai9V6SNg5OsmoSzvVkAMNlaRNrAzIVpOnA2xUaP7O2xgXjleVU?=
 =?us-ascii?Q?TpQUuqPbAVr+1KxX3+nqH5ne8C1Dx/eCSN1YU5srREBdJg09HYQC5pAq1Z94?=
 =?us-ascii?Q?1VgBLIxJtQBdW83DWELMpyqYlAXQsFJzPCbeeIsW4Ke7J48MtE103DAYI1Zd?=
 =?us-ascii?Q?L0McEFhgVz+5tVBtG7RrqWrRauPXfmGU1VEv0fdjYJQ+AJVMF/3Gi5yWsxN/?=
 =?us-ascii?Q?icTXwnhbDP6RWYi49F+8ZPKHN8xVB4Jw1Z84yMPPnizUW0fC18D4UYd9TO4+?=
 =?us-ascii?Q?R7DNkNah0ifKK1mzhZ1ZrAp01q619/lN1o0vFGJchwId8ecb/JUGaNiVSIFx?=
 =?us-ascii?Q?c9QJluUk+mSX0uweuGsUhS0xr7LEyYK5BRpUtacWiX76HpYGSSK2bKx+BiE6?=
 =?us-ascii?Q?yBjyXr2/+nn1u0IfT9KGN10AORC1KNQBW3IvRQWVHNXXxCv2PQ1vwBux/nwV?=
 =?us-ascii?Q?r569GYjwZfN6E3h0gMKpGh+lyqaIbuZbF0UnxPyGTpqyb7WIvMoeIMkPm4Wh?=
 =?us-ascii?Q?g0SQsDiVCUtIM25UUzM8u8rg3FjZ758JkRIRg0FESKn/YzFbLDf/rMl6al57?=
 =?us-ascii?Q?FiRxmHG9jrcAQR9nBkOWXju4im4Nh82QOvdiBKg29wm0M7ujD22v/QF6LjkL?=
 =?us-ascii?Q?CI7FDdg39+rjoYXOi17hmLNk0eSDu4UAEXkIOBIQjOEf1v2tOQk8qrcKlyGV?=
 =?us-ascii?Q?szhVuWLAMfvMGl9SNawh6OcY1XmFmHvbVIZJIg8lBHjzjUZrA5i2IN8Ho/KQ?=
 =?us-ascii?Q?lIsF4MeaslpbPw1um/73CLmDiUtxhJ4LsJzcGPO9dq6lVC951orlz2Y/nspD?=
 =?us-ascii?Q?/bRXFjLdn8/lE3cpMUMUfGYz4aKHBf/SDCF7Q0jIVrZWgo1KeeXreup8BIiP?=
 =?us-ascii?Q?TF2W8afXqb6s8e2AhVcMp+i6syrQ3g+NzIbC9gYMnn1L4J2mV4C95IcQ2+Xd?=
 =?us-ascii?Q?obd8jTNNe8gBJLh1jw4=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2025 20:42:03.2959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d1071a-0035-4a33-5fbe-08ddc704b7c4
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C710.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7962

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


