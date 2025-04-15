Return-Path: <linux-kselftest+bounces-30865-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E30A89E6A
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 14:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A0E11902713
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 12:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E154284679;
	Tue, 15 Apr 2025 12:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="AXRpBEp5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DE322F01;
	Tue, 15 Apr 2025 12:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744721042; cv=fail; b=qvuWe7Taf11d7VellAnTqqcPlrvtZMXg5chWhiGSvqWhurx0uk2S8OG8p67SkDPBOAf61GM1evzHHdDpAqlnaveIGBdswrxuISylB6VJjxavBGrQ20NLyChPv74RetlXICO6PsrEMA4+48VfgQklc5YDrVQ/hMR0gi/iu6ZRZho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744721042; c=relaxed/simple;
	bh=T6YdsXWfwagRJ6cY/dLM7kc/mNBPfvMKVPvHgKbzyso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wxxh6IYeXbxsskssosRjon/69QkFEY/gkxWdFECjwgsafYfBfc43abrPvszjWb50QCbWyNANKt8xbWJY0umLcetFviAjVsPN9cQcVj1r9hMyGfhm+gloG9nM1PrKGRjzwFHeHFTg3NJlniSCh9x54mgPy+pk6++JEx49csu33Ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=AXRpBEp5; arc=fail smtp.client-ip=40.107.20.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MdALz4I4V1nsoyNyR9XaqEIQWB9XKYiuNtHP49n9hM2iXDrmU/Qriqira09izxdqxkh3g8DETqb50d+JM1+IJiENsnfloSPEKHABwNOYPWm7dM1/TIsPxmwYhkAW+QrNBCZChHDSBmbGmlCqnzqYZ52okqA/qo9YAMIxPmTOftZRqtS/hV3NL1ShvN18erVUpM53DQkvJzrab8234LrjyAHWcoDAyqF8okQRAngSUJptecjwrG+OkCp+x0q1TV3B4BkMwqt9BOv22Wy970758SEM8E6OtQKVkmBBE/sOsoogebauu76olZ/U8or6xshsbuLi6Fjfvts45LyAk73phg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAruTQFdDsbzZJbN3TZIoGPXKG4aOYZ4bOtIlakumwI=;
 b=MRPBkpIJ2UV/PIeKg/aMPl8eP9y0z0XlLWFz77TO7vtYJJYf9xc8YAuYoQnhEFoZH3wxnIJm/qDVy2bdtj5t/WE17AQyMU0DEWx6mrBm3hYU0BmexgBb84X4tJD8Xo7WMY9dwQWrV7nGpmPl5IQbjf/7X/TDSYxDfMUVG6mivKiyhTeouUrC2qlDNTQkT6wqc1cUEnZstQq98a2oOI498Ch/ALcxQbLBniTzaxHcuEJmnEy+0X+GMtTB0xNhJgZcT2a4BmeTcwkxtlXDhFCtHyK0DnySZ4jN1dIl4aEzJP6AJ39+57410aU+A30/069PLU9XzeIuMC3azBCzT08qQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAruTQFdDsbzZJbN3TZIoGPXKG4aOYZ4bOtIlakumwI=;
 b=AXRpBEp5turQP9DUlY/BNvvb501arTmXb1UfYWCJivCLX+ApdqbgaOa95NK4GIqRfyfqn2EaNrREzfGki6E7BdwUPtYCahJEBbqoGtoFEj66kR5T7nMLW2LrlvAERSUUVUGwq0BGqP8VHsWAjr63998HgjMp1XVxKDm7hE5+Ymnof+2udsAq9PIeqFoIgqYTpRYvbwwsdt5ALXk+aYtk5BbQUd5SQYvO2oXokzGd6PoQVWeEP3nUCGzw3QXoZexiAY2X5JILKBlcsATDoYtaJYDo2kKKhr73azfQ9c1EsPlTRsht35xuX8nDqLRB92ncObhwPyYUXlDjQlSoalw5ug==
Received: from DUZPR01CA0247.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::17) by PR3PR07MB6842.eurprd07.prod.outlook.com
 (2603:10a6:102:77::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 12:43:57 +0000
Received: from DB1PEPF000509EF.eurprd03.prod.outlook.com
 (2603:10a6:10:4b5:cafe::95) by DUZPR01CA0247.outlook.office365.com
 (2603:10a6:10:4b5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.36 via Frontend Transport; Tue,
 15 Apr 2025 12:44:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB1PEPF000509EF.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 12:43:57 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 53FChgEe013987;
	Tue, 15 Apr 2025 12:44:14 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: xandfury@gmail.com, netdev@vger.kernel.org, dave.taht@gmail.com,
        pabeni@redhat.com, jhs@mojatatu.com, kuba@kernel.org,
        stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, horms@kernel.org,
        andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net,
        liuhangbin@gmail.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v11 net-next 1/5] Documentation: netlink: specs: tc: Add DualPI2 specification
Date: Tue, 15 Apr 2025 14:43:13 +0200
Message-Id: <20250415124317.11561-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415124317.11561-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250415124317.11561-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EF:EE_|PR3PR07MB6842:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9ec3974d-ca9d-494a-8917-08dd7c1b3051
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?rPbxDU7/Z/Ah1b1gbSYdcccrQPaw99SFRsYO6vd/6X+iMMIgckoShNpPo1nA?=
 =?us-ascii?Q?obCRtXFfpxzD9RSLbfJMT3WNlWm9k7494ShbwOJsQcLbbxtJno2/q0/eQu2c?=
 =?us-ascii?Q?5YBOleeXX+G3ChgM27xhQborydpNxfiyzaz1RciNBv9Lw5Ji/U02Ozi2b1FB?=
 =?us-ascii?Q?EMHTtpSwtZVw6o7ycjbxbihAPOAu/QugvB3uTnBbAx5j7PPX89prqKatgCDV?=
 =?us-ascii?Q?pnDmJNbrP8hT660ibAqxPJiAaUAZFlGKuMiduyB3Yzvo1/6AfuiRhSMc6NUd?=
 =?us-ascii?Q?xuTMPQQij9HXFyvgDjl/dDdfeAWO9WCxTjVhXZI3Zg4A0dgNzBOF2+X8xjpF?=
 =?us-ascii?Q?Z9TqbcmE+05ubzmtZLCIjGY2wcK46zMOsPLS8IrBI7cKrsURbKnp1mxNkCH8?=
 =?us-ascii?Q?XSS8MOL7Rg/r0POCDB3s6xY7YMNdU+Og9aByjKSTza9SU9ojw4F4O0fXykK2?=
 =?us-ascii?Q?ZhmsxZb+Xdv04qNChJhKFM7vV07rH3+uHG2XUhjfET2KrM0tlbpmklpn+Ajm?=
 =?us-ascii?Q?VnIw3acJM4WpGp3qn1qPINNMn67Si2YnTXbmB79v1Vr72+bEIZ3+SFPVdYUh?=
 =?us-ascii?Q?2bGizWvTMUKEmObhb6f/dj72N47obCwrxKCkXCHonWdAD0X+l2+g4EHbHLBE?=
 =?us-ascii?Q?piWth/swR0dHnAeuM1p7AChn37R3xUp+0SF0lfJlfN4ZZsS3i/QvauvHbhKM?=
 =?us-ascii?Q?8ps3sQWGvQgLa6nY5U250uuNR1fP4Q7mxg7PnE7PKR7yT2CCUW/BhvQGkTni?=
 =?us-ascii?Q?LiXmSRt3f0kLz8fb9hy7UrSa8gfvZ9L5xmtiUKI8PAllClWiZovlSyNYNT/S?=
 =?us-ascii?Q?TSRjYplykMmgylYlmqa1sodHiCAUs6RsvEDix2Yp1qoAsIA/q7HnXQyiqviT?=
 =?us-ascii?Q?N7dVYz37MaxBhsmojUndhBUbav8uV981K2jZn/Q6M+Hav62z460LS2AyIp5X?=
 =?us-ascii?Q?XRrFAtgShUO5BY6v4QBQMV9wqYBBp5/7aZI3K7eAe8MzaupNvHjhJjNrcPLo?=
 =?us-ascii?Q?QV/vWmwUXr96bPQJfGwp7RvFzwQZvsH9OENKcd4g0YG9rtKYF2KGjClcBzmj?=
 =?us-ascii?Q?38tvaUkvLUxJMgSVquj6b8kiXo4c/6tDQc08WQrsV5JeLTCTCrLFrsdRA8Mi?=
 =?us-ascii?Q?K5JoXfrv8eu94ioHGEJffWHrPp/q4clzAqjfn6vihPPDmuCIWaS27RWMykUE?=
 =?us-ascii?Q?qyDDG8vhnae+qYg3VHKts7a56HUi4rsXPRkkt8sCh9Cg9Vw45RRopZdKt4gE?=
 =?us-ascii?Q?J1bQ/p5Xsl4QV6ZbVI6WF9BM8b56hEbxP76wtqUcemVs1WsTumHAUVAGrGUR?=
 =?us-ascii?Q?1hi0/nkBo2wxgQkz8Luk7RZAVXCvLgDYQNZAHsSufjMbQYxM76GCaHowYRSS?=
 =?us-ascii?Q?+WU+L5ydZg+y/TMG2qWqKZBPKn2Rd6QuLYRsRSi7CwZD+NETtku/qFJPC1xn?=
 =?us-ascii?Q?M3/a/n1bEcwzoWqit5xPscmgLbw9kPhzRNWgLDfJiNcpbuY5docvNimV/wL6?=
 =?us-ascii?Q?AJRo70r8hR+Ib9hoGT7TKTN2DOCCvTtwHQKbDYzDtL8aITeCaz+z7/4gTg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:43:57.1839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec3974d-ca9d-494a-8917-08dd7c1b3051
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509EF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6842

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


