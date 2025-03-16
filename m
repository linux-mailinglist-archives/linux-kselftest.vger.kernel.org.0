Return-Path: <linux-kselftest+bounces-29157-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CFDA6363E
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Mar 2025 16:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288B5188903A
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Mar 2025 15:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92CC1C84A2;
	Sun, 16 Mar 2025 15:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="eVbtqxxv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F000A4430;
	Sun, 16 Mar 2025 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742138927; cv=fail; b=J3R1QrqSwpjutQjQUcpltpdLxLeG+rNbQ632SAyjG0d2yAaAM/gH1nokUAWUPtQXdo3hZWyQNCjRQfOHZhVDK99Vo1bMnRBYk+p5eE00QGjQ3O6rbCOOO+/gM/6st7YWjvA5CQwSqjbDr3rXRjs/tolYSeji+45r8O56La4UuAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742138927; c=relaxed/simple;
	bh=SLlQPPM9l4ELjeviRVeirRGq1RHs7hQgWbMdg2ytW0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b0Rmo9wZdPSxEZO58xsyPQeNIPDkmDgxUsslSTaqfqChGQaJprrICPAmWkVWJ/2weeEHqtggCvDzyEnp9OVsGdXokZmzVanmPN96XlHRghaOJBYQy9BS3XkChm9S+LKtU2gnojP+q+uZ5BQHSO6MZP8LR7ko9xyWCH3/MQ6fqWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=eVbtqxxv; arc=fail smtp.client-ip=40.107.22.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TP3nH6I5z2Qa6y1rdLbXY9n+rFrH9UNN1PfFoS1zynDm2Jes0EFtjGF32PdIeXKTA/E4EKU5QG6xRgT9YQ3+I9ymAOccnk2xrhNVYwHDu+n7PRcQlLayOprHhcXW68AT8wiEQE9ABpP4vsilHhzMvCjmGMBW79+slWtalmQCE+qM2Afu+vyhMlz7bqduwwMKiaRK0IYlSHPlAiCEY5NPQbdqMEoNA48OED6QV8rauE9DXk8tuon2g0K3Vbqf3HK69KAjXk3pRUxf8FTdfgSNmfRy1s//l1vzKYlM8ZHedZqsBVlkYSglDHalNpntihDtGSkVtItRUur6Wp1K4qlrLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fu1vNLJQ0IL12OXbhRVUKOTHsuAkzV/9kCvwSC71tpo=;
 b=U2tdK+MH2IUI7A1FgYo+2QnFouG/tCZiystrRaReXs1eF8RjPmhBSeoXUaqVs131WfwaVDna9F17uLjIZ25nfBCy4WfmK/9nIcNap1u0VDLwU98dgmg+lgzscdrPkaPBLuzy+DXNzWrTk1FtEIaRBxQWuoiTn6pfHYNDLLbfGffBlzw8S+DV9DPVYnJrqt2wBl617lFvhD4FwcQOR4sQK+J83p811YoCT5HATNJuG/CxCXTtgvHh9RkNoDtST+P269+YW+PRfGJrb++hj0hB7+3P8JiBbkCSZ7loBflMZTcLnxvNXDV6XvbZkmbAgOGbDRtvARdSnAQEAVw+waL3XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fu1vNLJQ0IL12OXbhRVUKOTHsuAkzV/9kCvwSC71tpo=;
 b=eVbtqxxv/N7TPaTkkoyCJctO8iWhml9uaPxl+JV0huzqvSnG57we0nTUCx0aG7KKvSsL0XOq8QNQCKMXu2hMYGChnNdDZRpWHRgQZ9G3ZgJ7e+ACbKnWX+m9IBwu6WOV7tR/yw1RXfNBO4rB9+0l4iY0RFUsYndnVHjNhTUFT3yjGfjKRIewGQ0uBF/uY9HHzjIf7FT55u6cmR2vB560dUkRfziMbSFOoN+QPc6gt7uyifFT+nRd0js6dnfOgNovWqshUu1T1YL6IXVsvHY1rVosIjqH6QqJXZVhiCmxigK3dKrIU7CMNe/uz706kBfyD6pxtI22c0qXPcoXjavJaA==
Received: from DUZPR01CA0150.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::7) by DB9PR07MB9888.eurprd07.prod.outlook.com
 (2603:10a6:10:4ca::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Sun, 16 Mar
 2025 15:28:39 +0000
Received: from DB1PEPF000509F6.eurprd02.prod.outlook.com
 (2603:10a6:10:4bd:cafe::c6) by DUZPR01CA0150.outlook.office365.com
 (2603:10a6:10:4bd::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.28 via Frontend Transport; Sun,
 16 Mar 2025 15:28:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB1PEPF000509F6.mail.protection.outlook.com (10.167.242.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Sun, 16 Mar 2025 15:28:39 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 52GFRT2t000613;
	Sun, 16 Mar 2025 15:28:47 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
        jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, horms@kernel.org, andrew+netdev@lunn.ch,
        donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v9 net-next 1/3] Documentation: netlink: specs: tc: Add DualPI2 specification
Date: Sun, 16 Mar 2025 16:27:15 +0100
Message-Id: <20250316152717.20848-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250316152717.20848-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250316152717.20848-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F6:EE_|DB9PR07MB9888:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 91572bfa-3b21-4b8e-dab4-08dd649f3a25
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?ClfgQNY3yKf2iU9QqGwEWnnFpROpeVX1uO9SGbRclyb4ptyhmDNh2Xf+3pXR?=
 =?us-ascii?Q?UMqt8gb8K/38q7p9p/CEH03JasAgcQ4wWu3NqaC7mslkm3GwH4Ew3zHlF1k3?=
 =?us-ascii?Q?jFt+bS/SgOZYxQQs7fduvOPlsnELnZ9ssfcMA1XNQvZB7ubGQAqxJz2Vjgkn?=
 =?us-ascii?Q?Pu7lcAFNqEMULpD6uB+KpOwu7JYjQM1mui4XolE0gDpPvWq7R6ASCe/idlkU?=
 =?us-ascii?Q?b02jMMtI+YFJFUP9Xg4loyI6LAiNlQEZTtrxs3G0OK2HZLrmetkMGPYyY/41?=
 =?us-ascii?Q?Cef+C/HJ2q5CZnt/5tLnjUnZrzFUR5XVDYpVtOYjlQmL9NTVEpFUuMno6Hfh?=
 =?us-ascii?Q?eoWXZGsyyd6/yJqAtt1GmTrXTo4fGomaG0Ro3UBJhTXFsMDv1QT2Wc3my/Wb?=
 =?us-ascii?Q?MzaNrXOnLtNWhgI1OqiWF8uOQ5tPqgVVCFv1Y2DiDbYkohr1/q1+v+uMBItG?=
 =?us-ascii?Q?skZg6LUX4N3FhUAK7m+5iUKu4z0zKAsbGLfJt5sl0j3C1F0kgrkJ3qrXGn6V?=
 =?us-ascii?Q?TjyG5LCZpsOHbtwTahZDKv0jEDZHH3iQXWgTYq9hELkXR3hWzoc38hGdN2Kr?=
 =?us-ascii?Q?X3JjgfLmIpr2PdEvooyU/AbGiW9XIKI/i6smWRPjHzAQeSWdfNswizkykXmk?=
 =?us-ascii?Q?ffgosxn68TCEa5yTwAgwnLkuQQuX6MU51HCU2zRiLpjt54IygsJD2Nv5bmco?=
 =?us-ascii?Q?I9cN6/0nODJUk4NkzUAin9IueVZXKz56RhWJ+wCOTHl2y1E+tDPdlgJgT7bf?=
 =?us-ascii?Q?xqXex6vTERyFx2iuA8LEs6LtHbe09ZKRIgPO16aK3KhyhXI/03H22a3Rx1mx?=
 =?us-ascii?Q?s9OFjJty4OPCCmVzwL6YbulMydDX2cXfpy47R89BFE1eGOyqSEmCOngLjljR?=
 =?us-ascii?Q?WMth/n2exHbIgEmFOtrdlMKnOaHSm/pk7nQscYnhT9fz3WIjFw3txxxfR+R7?=
 =?us-ascii?Q?BRQoeCSmUhYOBM3vuzI9/E94jhQ1NrcNtowK3zHBsVAUDVf1KFI+A2ndXyu1?=
 =?us-ascii?Q?rNPxKY2W72kT+o2ieAmU0UkFubN4MPsxoeVWsndb0lZA1lbpLZ2paEmemw9q?=
 =?us-ascii?Q?udVhNwo98RsEXlnXpy6tGFJjx3q+Pic2I8Tlt+bGmfNkoHsYaqvy8D+YXesW?=
 =?us-ascii?Q?QBSS1rQsDlshetpj65TcQ551Uo4t23qMpnQGA5ZgfkY3gw9o0YJAtQL1TYZ7?=
 =?us-ascii?Q?rkxMYUqUXG+2tHMTl4sfYc+yWDWbE9eGESMMLAY7Y+9sfEF555JlNKVlmL4X?=
 =?us-ascii?Q?DS6GLVQhbTsL+iL+eNEo3/uNpvbAqG4S8opXHcPXkq+OBHg0QcFe2fvSH89G?=
 =?us-ascii?Q?LRK8feQx/ST2HFC7YU35PceDssuyRbpfL+AyoRknQJSrh3sfEEWM2iu3CrDW?=
 =?us-ascii?Q?aXOzKh7cQyACrfSqUcB2r2STCgpZn31VzCNHDtHWhJGQo4vgjlhL9KAZDnrw?=
 =?us-ascii?Q?qSm6AxejDmdBCmGHACSOOkYpeEQ4bBSiRKqw4M5hzbr3flW2CTJ0FDtwUL5I?=
 =?us-ascii?Q?+Bzdx66f8pzaQtUzMIMIn0Zngz9ObgG7Dxc/?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 15:28:39.3677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91572bfa-3b21-4b8e-dab4-08dd649f3a25
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F6.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9888

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Describe the specification of tc qdisc DualPI2 stats and attributes,
which is the reference implementation of IETF RFC9332 DualQ Coupled AQM
(https://datatracker.ietf.org/doc/html/rfc9332) to provide two queues
called low latency and classic.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 Documentation/netlink/specs/tc.yaml | 144 ++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index aacccea5dfe4..0fb971935285 100644
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
+        type: u32
+        doc: Current probability
+      -
+        name: delay_c
+        type: u32
+        doc: Current C-queue delay in microseconds
+      -
+        name: delay_l
+        type: u32
+        doc: Current L-queue delay in microseconds
+      -
+        name: pkts_in_c
+        type: u32
+        doc: Number of packets enqueued in the C-queue
+      -
+        name: pkts_in_l
+        type: u32
+        doc: Number of packets enqueued in the L-queue
+      -
+        name: maxq
+        type: u32
+        doc: Maximum number of packets seen by the DualPI2
+      -
+        name: ecn_mark
+        type: u32
+        doc: All packets marked with ecn
+      -
+        name: step_mark
+        type: u32
+        doc: Only packets marked with ecn due to L-queue step AQM
+      -
+        name: credit
+        type: s32
+        doc: Current credit value for WRR
+      -
+        name: memory_used
+        type: u32
+        doc: Memory used in bytes by the DualPI2
+      -
+        name: max_memory_used
+        type: u32
+        doc: Maximum memory used in bytes by the DualPI2
+      -
+        name: memory_limit
+        type: u32
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
+        type: u32
+        doc: Limit of total number of packets in queue
+      -
+        name: memlimit
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
+        name: step_thresh
+        type: u32
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
+        type: u32
+        doc: Pacekts enqueued to the L-queue can apply the step threshold when the queue length of L-queue is larger than this value. (0 is recommended)
+      -
+        name: coupling_factor
+        type: u8
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
+        type: u8
+        doc:  Classic WRR weight in percentage (from 0 to 100)
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
+        type: u32
+        doc: The maximum expected RTT of the traffic that is controlled by DualPI2 in usec
+      -
+        name: typical_rtt
+        type: u32
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


