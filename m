Return-Path: <linux-kselftest+bounces-29753-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FCAA703A8
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 15:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79F147A354A
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 14:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC52F25A332;
	Tue, 25 Mar 2025 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="BqrAwwcu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011009.outbound.protection.outlook.com [52.101.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844602571A8;
	Tue, 25 Mar 2025 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742912954; cv=fail; b=OzyYV1FjO2W0JGXewsGEuXYgslDSA6M7uBnDZFnXcMO39TEcyhF4DymXZuyBEFckpcp7ax03plSf0Wfuu1cCZoeU3Pju2tpa9sgPp2xZRDTvtJVDFQlSHKkH85BnTlQUlRHNkUdf0P4+M2sYeNBRI8H7SLqbrQ+nfuGFGeVJjc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742912954; c=relaxed/simple;
	bh=SLlQPPM9l4ELjeviRVeirRGq1RHs7hQgWbMdg2ytW0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DGUavfy8u9rPSa4CtbODPoYNIKS+5I35YTo/RyVsW77QloWR0Rmy9ZrlWrN7FN2N6gVwGxYtxW+cxjdUKF8xSrKMWR4dY12NOnhf8vsfaAIAgwDvyGvCtx5JJDxdchgzdg3aseMgwX4IUEGTFTTccRt9wPbG+ztmImecaOfowfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=BqrAwwcu; arc=fail smtp.client-ip=52.101.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wzdEmo8IZlzZz/zTwp7eIkWX5O62YkeE7nNO6DexeQpjP84NDPPrS8gdPmcVzILD1az3rqWa8EzwbEvgm+/9eWI8LTIiRn+nlpZR8o/vUETGMLnrlJVs8vDXZWYDBZuvVuPt9v8cpH8ajQu/R+aZwrkP1UTcBEYWX+V7SvAaxa2bH5eO5+vYBYG2qVB7ypF51nQNsSNsOF5ST5Ex+H20S2Dxr2fLDJQ7Dq0XoKZWXeZRw/Gie5Q+whysyiNySSq1lgGd1O7dTyA0HKb/rQexenXQqCuLmMeZSXce4WMeiK2TuQk/06MM/mnRauFkeujfzUxqOblv9R4MVh3nfD0UVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fu1vNLJQ0IL12OXbhRVUKOTHsuAkzV/9kCvwSC71tpo=;
 b=D/L+aVSfXvNsETWw40wLTH5N8K2cxd512jbF/F/qnxlJlN+IC3s7PXOObrtKtmglieCqMSBsDlyqQC/PB2PUBYhhM3KyKfHThVyuYD/L5gpoTMIsSEpFppXEpC5aEfQJUNUPa1FA9AkSt9iE/ZfBDZm4qI6nCueKmmPOXVfqexKYLI2tMTYzyho6bXtcm4kyY8am8892BHyRBHmwjHPP9V2WBMuUEIHKPMGsjGGHiR8aj4pklzT8ZqTUTUPkgSKz5mrDBh2grq9Idw3mRnOvdfF9DgJICZM9w3wypXRn6y6O2nWW+dR7mjSa4haxlT4MB1mEe2gdtPg8Rb6CCfrU8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fu1vNLJQ0IL12OXbhRVUKOTHsuAkzV/9kCvwSC71tpo=;
 b=BqrAwwcuK5zPs6wwsM8UXBzsEmzWpKOOSqs2e/IexskZYta6crq1u3ByS3883+DwXkwSxFbMP9BYYUojCKCTfdN57qw2/GolH63fIYAT/FnZW1wS46xpYayN/FXg3YK2YUkZrMVN8LHuEGd1NqT8c0xTgKdBdfF9zBLEmUA0Ui56BJI2fiidprEc0cbCZewwUBoCOVr8okG1RWwfs9Hl5RLYOromnd4jtlgEZPClo/J1DXfZCrC+kmCHdYY9pDR2xYeWK2SNPJzMZCll+6e0pQY6yFwPYSO4aEpofy2JwMBNnZ+SLgSyBXOooKKT5Th9sjjtAsRqkRpXvrQt3r/1MQ==
Received: from DU7PR01CA0034.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::9) by AM9PR07MB7331.eurprd07.prod.outlook.com
 (2603:10a6:20b:2c1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 14:29:07 +0000
Received: from DU6PEPF0000A7E1.eurprd02.prod.outlook.com
 (2603:10a6:10:50e:cafe::a2) by DU7PR01CA0034.outlook.office365.com
 (2603:10a6:10:50e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 14:29:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.20)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 DU6PEPF0000A7E1.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20 via
 Frontend Transport; Tue, 25 Mar 2025 14:29:06 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 59CBC32F87;
	Tue, 25 Mar 2025 16:29:05 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org,
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
Subject: [PATCH v10 net-next 1/5] Documentation: netlink: specs: tc: Add DualPI2 specification
Date: Tue, 25 Mar 2025 15:28:32 +0100
Message-Id: <20250325142836.47048-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250325142836.47048-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250325142836.47048-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E1:EE_|AM9PR07MB7331:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 12b14e39-ec23-4fb8-51ae-08dd6ba96665
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|1800799024|36860700013|82310400026|376014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?4DU8CzvNQsEnAD9IOKPbKD3W0+cT2mRIUp3UH0KIZJOz0/t6iM5H5ehuwaZQ?=
 =?us-ascii?Q?7K1YeuOMAGgFgb7HVAWLVxc8pRfLVghf3xjLdP7ICfC6L4dtQnU75kWjK5o6?=
 =?us-ascii?Q?P91B26TPMvRlIa8kkjnNQOi2VTTsbbc0IZhssn7FPOm9JcHtxH9ghUuXJH0N?=
 =?us-ascii?Q?qIMyOFjObL/l4rEYyrTNm2D2EE6IAyS0s86iYXzK9ClcW+BFuP77LkbS8AwK?=
 =?us-ascii?Q?1OFPUVwG7oo3y0CUFVd3qXvid20Bky4yj//RuK9iAX/nCq0PTMk93jMmaank?=
 =?us-ascii?Q?lp1vGq7HNzieWeX1LIjaaKBMmUVlVUKlSlkm7ZZ6+sUra9u+mEnbN7T1X7MZ?=
 =?us-ascii?Q?uRhag+A9oB2glwpXX65oxIH1BK2Ghlhx6h/S7FVc8UIYakmgU4TIU7cEIP2y?=
 =?us-ascii?Q?bmHVi4x7+n4qtBP8IWYtdP5jORL8DEVcExifWxoOXsLoA/bQWfWD8cUhTPZz?=
 =?us-ascii?Q?8dgV/ZaLRZU00C8McXitizfXArT2EyxQLG5DaENECDV/Vag1nEDY7zzXfPLP?=
 =?us-ascii?Q?lW55wRZFV14XfILk3PDsZ5umrgwJTeCNiNN58F0f9SF3o1StsK4UjnDx+gYe?=
 =?us-ascii?Q?z4nqH7PiTGY7R1AWMAzedKTGGpDn9Nv5JMko3TzZIwuV/2j2a2Ii7tp5nukm?=
 =?us-ascii?Q?McOATYKfJGOMYhzv/ZQFTnRu/a0MHILDDZrYzMP23Wb/u/XUJRTDucokp2R9?=
 =?us-ascii?Q?nJzAlUGQ+ZOzVKYjCS6Sw/jwDU2hRFI1UzRHUp+EepgMsFG9BD5yNUxRaY0Z?=
 =?us-ascii?Q?xoaUjos/wS2NgN2XtKnXt6KcFTVgcRQzLUZ8vEIxukQzKzDXC08ALpOBj6nk?=
 =?us-ascii?Q?s4mdA9Nqk9DxGR44GPwQh7WyguTRXutwhQjGV+lMzPJHaDjjhHNA+tOulF/O?=
 =?us-ascii?Q?Jr3+9xezqeReHDxLOzRpCxUOBEqB3GOsrGbPlc8jlf8H+Tm07YPO5WFIcBy1?=
 =?us-ascii?Q?BiBvcdsrYy5Anlxin84DJ3TCvbzMGVRo4o+fUOi2puaUGMLfgiisJeKMPJWs?=
 =?us-ascii?Q?bn92WmmioID9+94lfhNB/S3pJM7nV3jwjMKsjhWjzYjdXXQXpiuYcrzQzHVR?=
 =?us-ascii?Q?rvXNSixTaTjjbcDW6vh42AdTByMDLqSD4jQtU+fGYDzLYKvLkbK5y3YOXNWL?=
 =?us-ascii?Q?70/cDdhIS4X/7ey+K8K+ppsq4FlHjz7ggLHw8vYF2j3kn5hEMtqQl6vMC7Sr?=
 =?us-ascii?Q?Qh2cqRgCM9SgGnctF0uIgIa8H1X5QkUgyM3pce3KZkOhWS0UkzXPCRXgRTAz?=
 =?us-ascii?Q?ToLKOodEtbg/ORkKlSJL8hFhAb+aChp++lQ29ZjRjlX3Wh24wVWf110ix0jl?=
 =?us-ascii?Q?xzN/wYdq5Zyxie6eiQX8tA/eDuUiLmx6HHaGeYdgB5FkJar6vJHRnE8a2emW?=
 =?us-ascii?Q?qqNQXOht+qW+T+0zXIAk6Nwx78wggD3xyPQ/AQIg/ovxbzqnAvXCKFU1Eefq?=
 =?us-ascii?Q?BKQQC6sJ96INW8m08NnK0w/dFuhlDTIBiSoB9FR1+omU7FqeVfJKGqpsfvfw?=
 =?us-ascii?Q?d7Ua/ZaPnHNuU529hvPLvBa2DZDNfLyJpSct5Hx29d6UsDxpcO7kZJosSQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(82310400026)(376014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 14:29:06.6945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b14e39-ec23-4fb8-51ae-08dd6ba96665
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7331

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


