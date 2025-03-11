Return-Path: <linux-kselftest+bounces-28681-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30117A5B20B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 01:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9F33AE697
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 00:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA74F9D9;
	Tue, 11 Mar 2025 00:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="VcMtFDQY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D67C148;
	Tue, 11 Mar 2025 00:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741652146; cv=fail; b=NJYHGLDtxMHfTpBMc08Da+XyKjKfFH0vemS0S4hRwvqD4/npjp1Vo2ppU11V+fKSFfKSaB1O7BGoio2eoZDI6qWwtIxPJdeD7xzOMXMWRWi/0Imv95+Nc1zf5GiKjm4FRmrFkkLgCo/T4WePLF+Mc06MDyDFI+3/xCDWG+SYZDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741652146; c=relaxed/simple;
	bh=iP/STF8ok1+98e5rPJHqDAipkAHspJ1AcUq4q3Y7PQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GSMBTfBc+JSUHShyi/bkV+LoeadQ0HLvBfZQo8BFQFmZrsi/h+k0XhOPWSgXrJP8oKhfK0FIdBPU1psk3s5DQVwKT+HMi2AwvlQ4XngGJCSIgNKPXS1Rdhso0YjDuWW8ZhU5o5tEyYRhjIeZNtIdAsYRvupfW9LM4O12R1HRlow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=VcMtFDQY; arc=fail smtp.client-ip=40.107.21.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7qNyVS9xJa12X+w5XqpS0i5iy+bFLoREmQBjNyw1U7Q6q0ClAqGgz2dxfKf9eP4rUB2xoXAqcOYHs8tLfDNJfvR4vQC8Qd5ccDrU74IQKki57hpjgTbkQ4PAk8x3Cl0VN7x35m2k5hJlV6ZHfqsA8s1yIJZRYixtpkklhacEpSZwzrg+iMWCj8cltNRIQd45EoKn/ovv8UbZu1p9/k6XclMYkvZKE+ADWZ9rvJc5obvPYv/PYROwXTdf6hvP9kuDuSAd3lNbBGoMxo887SPzC9rND6pGLNefrlgn1eRzPufm6lswok7V9cbwDOhjQugWlo8siWqvPTE0wH7+2PlxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4pHs4D7ubMwdVZrWBYe1fIwLx9MFoNG/E1FF+/pNTU=;
 b=TN/Ky3OUzJV1JiwwdmUiDoBa/Cnu2O/g7vkjNeMLadXT4Rp07KbLzHYkYjaVmg4FpTwdDuqI4OPclFxpUR5JSpmu+poREX1WEsjDYrKfTcJ/V3lleZwXNWX+z4m0c+9K/gfu12c/mDxFai5greKobYsOwbXa9H5iM2E2Mw3ljG0ImALZn7H0/l0CQPs77UNhHduAnvBYlXxSIXCSzTYjvjxOOojPXwVkWnRyHaRMvSx4CSwu92gD7YT6gzUXv35e5wFF9lH+ooUSUCUu69tTaTuQwBNZELeK1sMEJ9gxU9SAgGFFORHeU+kcRYq+5VmYUfPipUBat1G2PQMrjFqy9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4pHs4D7ubMwdVZrWBYe1fIwLx9MFoNG/E1FF+/pNTU=;
 b=VcMtFDQY/9l57qNvD/PrGI49MfmZhdcvOZ1wi9htGLnP4jMk+MkfGCSBYMJlSVyp4exFf65KiSH1RyU8hiaPRHkS4x+73WnYUyAmgb03H/90av9B9rQoBUxPFhaBP/3NErO1Pvgn9GemxeTjfz2iiUvp83SW3tVgf0xjg7/e3s5OnfsI8Hz2i9Zyq4vuzKNBDofeGOEJIDhNkeW8g6Wa+nyNcd4RvU2H6FvFTaKOSVsMSzdSZ+rsb/qjK+PCh/cwmHz09lxuPMb2CQIL7xuHmzK7y7AfGxw3nKB61HqQw8TbBuRJmacEkQccXGf0y/TME0umxxOM+zz4Ij/P5MHmZg==
Received: from PA7P264CA0138.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:377::14)
 by DB9PR07MB7162.eurprd07.prod.outlook.com (2603:10a6:10:211::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 00:15:39 +0000
Received: from AM4PEPF00025F95.EURPRD83.prod.outlook.com
 (2603:10a6:102:377:cafe::6d) by PA7P264CA0138.outlook.office365.com
 (2603:10a6:102:377::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Tue,
 11 Mar 2025 00:15:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM4PEPF00025F95.mail.protection.outlook.com (10.167.16.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8558.0 via Frontend Transport; Tue, 11 Mar 2025 00:15:38 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 52B0F9Gp007427;
	Tue, 11 Mar 2025 00:15:45 GMT
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
Subject: [PATCH v8 net-next 1/3] Documentation: netlink: specs: tc: Add DualPI2 specification
Date: Tue, 11 Mar 2025 01:14:45 +0100
Message-Id: <20250311001447.114579-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250311001447.114579-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250311001447.114579-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F95:EE_|DB9PR07MB7162:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 032f0c1c-d849-48e8-ac2f-08dd6031da60
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?TaWq+d7YcrRdTIEB5wekEQXC/YT+eko2DcEMdTAEXClgCB+ASvW+wDVrvBEG?=
 =?us-ascii?Q?YfcPjGIxlqKzjKaiRFjb9TuWniDhR2Fom3lgSvXbyeACIP8ZwDDyR9ebbdlk?=
 =?us-ascii?Q?A+Mb7KU/K8aJ3wNrzyBmNy2YD//NeTycSj/jrGGVEE7GX/kwoSmhTXjALZq3?=
 =?us-ascii?Q?01u+KrvxNZY/THCoPGvnEuY5RGqwzznIzihlyXp+FkQJH5drbvl1FyFW2wR7?=
 =?us-ascii?Q?MtpQuZJCmrKJqZoQJhmPVujzcxjjQabS9PfyBj53RML7Ma+gbvNoZmkrOzDj?=
 =?us-ascii?Q?boO9n4REh5a9GjnHjq7CIe/go8mt2JpiPNSNWIrgHCrRNvQp9xvo7dlVKaoL?=
 =?us-ascii?Q?E8QaYSvuz2o4N3BLTPnFGlc/C4yt0OiUewHe2gpy9hx44TV2Wcj8h4n2mZ1b?=
 =?us-ascii?Q?SqA2L4sf0guDepay5//RD83dNUl41BT9uZyZRAhi5mGhxaKUCem6sMzppCN9?=
 =?us-ascii?Q?0dwc3p1TWqlELL9iFBQUvgTiH1furq7epm6o4ew8olxXBIOVPNOaVej8o7Zs?=
 =?us-ascii?Q?MSo+kdvjU1DGP7t07eDFKKWZyScHOVQeNCe2G5SUWbsUQ2S3KxjM4PRD9hPG?=
 =?us-ascii?Q?+LHXpQkb3dOUc1Xxex3aIB/ZjxwIuB4g5tOHgc4qDQWyh3Z9bUCjx+gXldHP?=
 =?us-ascii?Q?zWpgwRzM/4jH80ejzfhUA1TXhqS4gdWLgFrlDEJvPv13RvYQCNI1QHqtva23?=
 =?us-ascii?Q?szVjzg9ELEoPw2PmGnexD4nneFgRkfyg+9hmNGEEoNbAgCYDJ/yHC4bIp/uu?=
 =?us-ascii?Q?2CtvTP594i3L2wC8etziynlFG9nAmB31Naw/rx/x5gXgdMSE6sZ0pnUclX98?=
 =?us-ascii?Q?2j1hfFr3OLRZjYENqxSQvGeB9JNZhftvgbyvGTMdeg+dMtmq1w7oOtrTWwaq?=
 =?us-ascii?Q?hohBon1MVTh0Eod8RnxLsoRPLrQHoBLhHhXNXOPTbYks2uihQk9DNN9mFWuo?=
 =?us-ascii?Q?lLSk4epe063ChEJZ4hRQsLg3wE1oI3D6cRD7we+AMxAa+x9noaJL+5+zvRJO?=
 =?us-ascii?Q?QDEsiuPDIjmV6tYJ/RmSOMM/dnRHMRljBfHFOwTy5t9MP8hXEjsRiahxNfLg?=
 =?us-ascii?Q?lqo1qoFC1511JVUavG9raLHXn8ppvg/mCICEPTLgczcy0qIneSpENX+4rjof?=
 =?us-ascii?Q?emTZTnjO/vGoFmPKeHZon/FIGr+fuCdsjbGwjQya3gs0RLBxie/QZpYg9j7P?=
 =?us-ascii?Q?3iKMG+AMqUKNtMkJwVGzeCdZA5vcEYWostImzwJKS6MY/C1o52BRj5EQ2+Ga?=
 =?us-ascii?Q?wNrp2tIokHL4hLn1QomMXHUfViVtWHxEMCuX8MQkHvUscMAW1cKtlegYAmNt?=
 =?us-ascii?Q?/bsMPZkwmyeTJaC0uiu/93vh7h7jEWLxBp0KGuLleqTTB+Q+nlawtCrQJDNl?=
 =?us-ascii?Q?r/oZvkehZyAU4m17/OqQI/NYPty8psOXaSrIQFv7HorN+vPGhxOXk+4kDswb?=
 =?us-ascii?Q?M3DnFYWSC4H00CxIwtPPL8TgNPKP828b?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 00:15:38.8036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 032f0c1c-d849-48e8-ac2f-08dd6031da60
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F95.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7162

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Describe the specification of tc qdisc DualPI2 stats and attributes,
which is the reference implementation of IETF RFC9332 DualQ Coupled AQM
(https://datatracker.ietf.org/doc/html/rfc9332) to provide two queues
called low latency and classic.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 Documentation/netlink/specs/tc.yaml | 140 ++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index aacccea5dfe4..43678c3bad4a 100644
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
@@ -2299,6 +2351,88 @@ attribute-sets:
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
@@ -3679,6 +3813,9 @@ sub-messages:
       -
         value: drr
         attribute-set: tc-drr-attrs
+      -
+        value: dualpi2
+        attribute-set: tc-dualpi2-attrs
       -
         value: etf
         attribute-set: tc-etf-attrs
@@ -3846,6 +3983,9 @@ sub-messages:
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


