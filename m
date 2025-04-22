Return-Path: <linux-kselftest+bounces-31352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34617A976A3
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 22:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCA113BE145
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 20:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF62329898D;
	Tue, 22 Apr 2025 20:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ZOFxlO/F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB5929A3C9;
	Tue, 22 Apr 2025 20:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745352980; cv=fail; b=fE9KhnztYnkGw7/HeIkX4oaGkELamrPq1axC5S3UqMLs29Kc009v8QvUhDA6fTKadke20JHzKCbpNDoVWCQmDqDxC2wBjLHdlFQ0pURXlZFtXJ7LVbyrAeFJyn2PN4zm+2MgL6fhNjEMPrP2otH72LRfmAKjJzzrEblNusSqyj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745352980; c=relaxed/simple;
	bh=+xbw3iOrpSQdNvQb1JDspBMDeyDx8wIJfEU3Zb0PfhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9h7OF7mcNOiKm52hZysrW6iRKM5C3pw0A5gX0nkVl3Q1bTtIopmEGKhTMzOnJUVNnYNNxVOmyygaTKWnRIgz4YYDxNNCJbX4zJ80ow+aFWcvYysZwrFKGjMebwtPyvJ6jiuhiaAAbXkt3wifLTICQof+rmcZ1yRhglgZyOaceY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ZOFxlO/F; arc=fail smtp.client-ip=40.107.21.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZDPoLkk//g78IGiiRz9pFsUFLUPfnEwHzACN6B0H5cI4jwmKKnEpCd1MsK794tIU9lOHi9sflqPNaZ+8g8P/vskvpRLo5uRP8snk5qyYNROIf2aA4eYQNDX5a07hhWRk5hgcv+lE7nBjjG0aTwmHY4KfhVB6q/bSD9urNuwXjPxY5i8Zixdi4/PECr7zJdPcEtLkC1B/xTQ1LFravKgHgqn7CLrESWlEFwzC0yuSOyZ4SRK+PdQ6TyMip63n9GsE/n1QOWxWnGwJyPVjDzpdQEpg9usB7kR3soqhV8XaVuVl6d4VJh3sn/lCq5IoGMG1hUTEO3cG8ggPzHQUiWXAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kr0pL1AtNwtDjv6vNp/n4X6px/yUra2w0mMf5xQunAo=;
 b=ec/Ohya1yptQs0duT0IAKxBmUFex2N8RfjdJidWSdWvOW7VwAz6zb2kZneRks+dGlKFOEgCDH5KanMPrZwHPWHySf5feGOaf67mVGUcape4SiPKdW2BBcX99qkTYYvYWZ0+fsaPUeGFrSKC8aX3DDdY+7DP/zDMIj8n29v9TYlsL/yZMtwogqfBVmQg4UeAgnl0v22yQnBAupKdv9gwvkEOyy1f7w+gPw/zUqDUS8gFcos6+eP1XJ/fY5PnSG28vivxF5eBTzx6iahrLy0oV6BrJIhuGziIwhLSUmzIaKYMMLhVOXUJNPX+SsdvakzurFlGgw6jyCbn0k+6PmISoXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kr0pL1AtNwtDjv6vNp/n4X6px/yUra2w0mMf5xQunAo=;
 b=ZOFxlO/FSyHtnujkWzcXi2NDg8qgX+LM/a1NyGETQxfaFqUE8Z0+GaXKFBJEQDjldLWfK6tcMGWpKgiWVJCiDsFIgJwGPgxcb7lznOCherFLCXWhhz+GwwGCTCPhlWBQLkfEdiCIFy2xUEGeQud4sty1T6qCIJJbp04hc8V6LDPEk2mNElU0Iqoi8Xzqg5vbaxUqC3JYTqHfZi1YBJTEvG+fcB7AijoMtHHghjFddqcmqSkBDcYXSsACzU6ytj4wHGg5Huw4yIvYnsKN3D9nlT7uiva3eG9qKMw9HICmiTNoy8GSczN+kYtxCfc9VJet+iUn9/tjacR+CYQaEK0h9g==
Received: from AM0PR03CA0020.eurprd03.prod.outlook.com (2603:10a6:208:14::33)
 by DB9PR07MB7129.eurprd07.prod.outlook.com (2603:10a6:10:1fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Tue, 22 Apr
 2025 20:16:11 +0000
Received: from AMS0EPF000001A2.eurprd05.prod.outlook.com
 (2603:10a6:208:14:cafe::b8) by AM0PR03CA0020.outlook.office365.com
 (2603:10a6:208:14::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Tue,
 22 Apr 2025 20:16:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.20)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 AMS0EPF000001A2.mail.protection.outlook.com (10.167.16.235) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Tue, 22 Apr 2025 20:16:10 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 55B9C20094;
	Tue, 22 Apr 2025 23:16:09 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: xandfury@gmail.com,
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
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
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
Subject: [PATCH v12 net-next 1/5] Documentation: netlink: specs: tc: Add DualPI2 specification
Date: Tue, 22 Apr 2025 22:15:58 +0200
Message-Id: <20250422201602.56368-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422201602.56368-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250422201602.56368-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A2:EE_|DB9PR07MB7129:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2d44210b-4b7d-48d4-fa8a-08dd81da85fe
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?Z1ook4BGpBY+P2YoM3dGfApIrJ8sAT74QkBdt3DralMb3ixVK9Qaj1GXpT2W?=
 =?us-ascii?Q?+Jt5Ni6zB/SdndZSASudOFhh+G3JicbA9JvDUg8ZJkEvMDO8RQLssIad8H5I?=
 =?us-ascii?Q?eecUDP5q92DY9Y743XPdwGUZqm4+KSpofKZHKuKaSR/ZjqZJzLr7Jbrav88G?=
 =?us-ascii?Q?cCiYKTjDX1j/2UIJlMsU5HLp+sIEi8OkPdzoZLJEScPi0nnlz7YrtSeGeQbG?=
 =?us-ascii?Q?D9rIkVkJb+YlKTeJOQ4Ue1nGDJd36OfOnFwK+vz0WCnc6qsITfW/Hu1SaeAQ?=
 =?us-ascii?Q?wFn4nId2Um5O1nv5V7GxaB5r5FIFGw1kb5i6I40qhFBr6sZEXG8Uerb8YGqF?=
 =?us-ascii?Q?vpna1n8VauOBMf0D3rYdq0XKoC2v2kVbGmMKqThx8mrGqSMa0UhlOigSEgf3?=
 =?us-ascii?Q?IaZbgjPg6T6BZxcWCZoFreFQol/+c/TK1/0c4eloSu8vP4jH8k9I500P28JY?=
 =?us-ascii?Q?n7nwMnT3luBnfdL+H1WXPEzyrCiClez5aO7gNJ8RuxhUrcV4QoLNdTyWtp+P?=
 =?us-ascii?Q?X6fb5CeN/wkSLs9LlGSQZchJwHFzH3XtOoXDNsPdJ/AWcnq/SPEKXpa36Yn+?=
 =?us-ascii?Q?E5afvw91G7D9OoUxqkq0j1dw9Nb1ra7O8vdsqQmM+Cyi9xBvEscbpyhqD9zB?=
 =?us-ascii?Q?ApW1xEBXIJKJ0aJzd9eoeeXfYQvIXQa0npBSTctJ8/6NiuRePwsrb7BsEmXj?=
 =?us-ascii?Q?G0hkgr5PPpJGrLLOe0iL2ku5imCgrPWpX6zMMclLJKBijY7hXOY4CBTgQ3nX?=
 =?us-ascii?Q?Oyn2jysr5MvrrJ+z0hNJidtrtHcn71IPB4MneW20nqv5RbixjsfzGxQhfH6B?=
 =?us-ascii?Q?Tu7aZHPOEWjrJpe9qrVhiwpRMvn0eSNDworocjIuV8ROJBEd2ATWnUKVJ3VF?=
 =?us-ascii?Q?ecw9Htl5dP95Me3GYhb0hK2K1b2yjWI6JV8rt5MUYOaFZcHPayDSjcu+PcnZ?=
 =?us-ascii?Q?dsB6qgMDV26L5whvbsZgJr9RfJ+orpgND0GyWmnoM19vfItMR9fD915jqRwR?=
 =?us-ascii?Q?nI0wyeP0qPYLBOrJjbrbsgRYvNl9MGe5aDAWGqIFrSG1cOoTbpzZWv86q+Yu?=
 =?us-ascii?Q?qMZuyRDOJFI7yf9SG2c6Hkl77qFvugx3rr0uigf2V97dXKMyI69VZbrlXjWN?=
 =?us-ascii?Q?Bn1GbO1IT+Zj7oZoMJBv3X6UV2k75aUMfG0hhZIAfSPyc0mTjIwxRkujyPm7?=
 =?us-ascii?Q?JJCJo+NH52YpgajeHYS7oC4CSmC361f2KAHfmPwXy1rmLaXQkrEdzoc70AFy?=
 =?us-ascii?Q?mlYmSeIB3rx+Dbc4yp2GW9yx3SuZHCfdJW5v+rfbkABKA/c9v5zi3KjJS8tj?=
 =?us-ascii?Q?WcjxmebYJTjPFA6LfZgiX7uBuKEn4b/iajsf3nku3uy+2u2sWi+8dxzewUwd?=
 =?us-ascii?Q?J2DfH7zbl9tYOkCn1mfGR2NBqTN8EgmICU3n7iCUj1Q5klpbMJKfRqWywlNU?=
 =?us-ascii?Q?nyIPDnsHL8COHN4Mo4JzK9FOUDsRrDnHFDZz2O8QNW44mlj8p+KkIqUHalNB?=
 =?us-ascii?Q?0TNdM/BeXMyFnyUyndF0IyulCM9S6zU+1dSRHPw+XRx+jsubNZoI4ZW/2w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 20:16:10.6474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d44210b-4b7d-48d4-fa8a-08dd81da85fe
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7129

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Introduce the specification of tc qdisc DualPI2 stats and attributes,
which is the reference implementation of IETF RFC9332 DualQ Coupled AQM
(https://datatracker.ietf.org/doc/html/rfc9332) providing two different
queues: low latency queue (L-queue) and classic queue (C-queue).

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 Documentation/netlink/specs/tc.yaml | 144 ++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index aacccea5dfe4..08255bba81c4 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -816,6 +816,58 @@ definitions:
       -
         name: drop-overmemory
         type: u32
+  -
+    name: tc-dualpi2-xstats
+    type: struct
+    members:
+      -
+        name: prob
+        type: uint
+        doc: Current probability
+      -
+        name: delay_c
+        type: uint
+        doc: Current C-queue delay in microseconds
+      -
+        name: delay_l
+        type: uint
+        doc: Current L-queue delay in microseconds
+      -
+        name: pkts_in_c
+        type: uint
+        doc: Number of packets enqueued in the C-queue
+      -
+        name: pkts_in_l
+        type: uint
+        doc: Number of packets enqueued in the L-queue
+      -
+        name: maxq
+        type: uint
+        doc: Maximum number of packets seen by the DualPI2
+      -
+        name: ecn_mark
+        type: uint
+        doc: All packets marked with ecn
+      -
+        name: step_mark
+        type: uint
+        doc: Only packets marked with ecn due to L-queue step AQM
+      -
+        name: credit
+        type: int
+        doc: Current credit value for WRR
+      -
+        name: memory_used
+        type: uint
+        doc: Memory used in bytes by the DualPI2
+      -
+        name: max_memory_used
+        type: uint
+        doc: Maximum memory used in bytes by the DualPI2
+      -
+        name: memory_limit
+        type: uint
+        doc: Memory limit in bytes
   -
     name: tc-fq-pie-xstats
     type: struct
@@ -2299,6 +2351,92 @@ attribute-sets:
       -
         name: quantum
         type: u32
+  -
+    name: tc-dualpi2-attrs
+    attributes:
+      -
+        name: limit
+        type: uint
+        doc: Limit of total number of packets in queue
+      -
+        name: memlimit
+        type: uint
+        doc: Memory limit of total number of packets in queue
+      -
+        name: target
+        type: uint
+        doc: Classic target delay in microseconds
+      -
+        name: tupdate
+        type: uint
+        doc: Drop probability update interval time in microseconds
+      -
+        name: alpha
+        type: uint
+        doc: Integral gain factor in Hz for PI controller
+      -
+        name: beta
+        type: uint
+        doc: Proportional gain factor in Hz for PI controller
+      -
+        name: step_thresh
+        type: uint
+        doc: L4S step marking threshold in microseconds or in packet (see step_packets)
+      -
+        name: step_packets
+        type: flags
+        doc: L4S Step marking threshold unit
+        entries:
+        - microseconds
+        - packets
+      -
+        name: min_qlen_step
+        type: uint
+        doc: Packets enqueued to the L-queue can apply the step threshold when the queue length of L-queue is larger than this value. (0 is recommended)
+      -
+        name: coupling_factor
+        type: uint
+        doc: Probability coupling factor between Classic and L4S (2 is recommended)
+      -
+        name: drop_overload
+        type: flags
+        doc: Control the overload strategy (drop to preserve latency or let the queue overflow)
+        entries:
+        - drop_on_overload
+        - overflow
+      -
+        name: drop_early
+        type: flags
+        doc: Decide where the Classic packets are PI-based dropped or marked
+        entries:
+        - drop_enqueue
+        - drop_dequeue
+      -
+        name: classic_protection
+        type: uint
+        doc: Classic WRR weight in percentage (from 0 to 100)
+      -
+        name: ecn_mask
+        type: flags
+        doc: Configure the L-queue ECN classifier
+        entries:
+        - l4s_ect
+        - any_ect
+      -
+        name: gso_split
+        type: flags
+        doc: Split aggregated skb or not
+        entries:
+        - split_gso
+        - no_split_gso
+      -
+        name: max_rtt
+        type: uint
+        doc: The maximum expected RTT of the traffic that is controlled by DualPI2 in usec
+      -
+        name: typical_rtt
+        type: uint
+        doc: The typical base RTT of the traffic that is controlled by DualPI2 in usec
   -
     name: tc-ematch-attrs
     attributes:
@@ -3679,6 +3817,9 @@ sub-messages:
       -
         value: drr
         attribute-set: tc-drr-attrs
+      -
+        value: dualpi2
+        attribute-set: tc-dualpi2-attrs
       -
         value: etf
         attribute-set: tc-etf-attrs
@@ -3846,6 +3987,9 @@ sub-messages:
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


