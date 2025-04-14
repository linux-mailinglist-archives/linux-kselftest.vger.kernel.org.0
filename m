Return-Path: <linux-kselftest+bounces-30682-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F34A88143
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 15:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8001F176154
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 13:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9513F2D1F55;
	Mon, 14 Apr 2025 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="lMm348bk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2055.outbound.protection.outlook.com [40.107.247.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EB22C3769;
	Mon, 14 Apr 2025 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636344; cv=fail; b=Y9BGzxfHhwF86/FZigRFHFrgvMEqQmoEKSqqDJoyr2NBubwqlkTlJP8j7ch+EWmiqay5l/yqC6Ckbi0X9KBb823q1QlEzBp/ZJVRrQ3KMSN066E/7gl8Y4JOtxmKGyLDzxd7ype0+SzX2g/I6OSEpkc5v3BWVmKIidpdqKg2iFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636344; c=relaxed/simple;
	bh=T6YdsXWfwagRJ6cY/dLM7kc/mNBPfvMKVPvHgKbzyso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pzxx0a+mI4BrdXNgI+U+c2gnYsxLihwzRxhXYxr2eB6CpMaTdeliISmy87si03XMqZYRjkkNSKrxomlHYZ7Fo2akVLwXcT53tyKMYf2l6DmMKe/38VB3OHAkiEckRD70DEWSgKMsqBMy5hUh6tuAhtfF5lb1iemmHHhkUZxl2oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=lMm348bk; arc=fail smtp.client-ip=40.107.247.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDFQ9ZIouCNbGGPBy0dlI6V8+ue6zgNqeujmfHnNEA7MR4k0Zp1kALV+/lnMX7ljf5rsrqYj8Tqcv6ra1z2LPTB1djxdSE0S6+pbvKbgpF1eSYYMjrdmziYNxoBSNFWzJQPmFPoSvUc0Gp4yylntuD1Qas8i/F/VOWo8b8eI5PC7Oni+mSG/1NkjMYj/Nzq9rWFPFRZr5Qh/xMWExrUL92zA636KaDkmyHR/JOPw9+BA1iWm0otu39EkptKcBf44+V31mvawX1kmviUqscTfQxCOPcZinieEIkm0dK4shwtVRIhkPycMjunA6VzkHgAqxbxWCvwmHJUNl90YsZEiQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAruTQFdDsbzZJbN3TZIoGPXKG4aOYZ4bOtIlakumwI=;
 b=jmSZdShMSBV/WGVpezKMheYx/1Kx4Ggja1uMJrTZE6LSXcEzWfsZt5lbeSCX3B+k8XdqC/Ll1uLnBqjYWgBUmJyVS9bhr4/n1SKN5VJ3gDsnxipD4M0leCtV7ESYZuzZdsF/JPnA00iyWVHOkKwVDPvEeKIW+lp+HHnV+YRqmP5pSBmRHaJ3/FkSqhnXVrBCNGayr8ffRYS1PC3z2LIKhaqvDkdpIQV4GYUlUtfjeqcx82NlM8Ibq7WCR1r7Kjw4hDo2CU58NV9wAOSIJlw+d9WF/fGm1xHwsdh2DUy8PZtd49jnQgfOwYWDmOEtR9G6CY/kPRhXQmgkui4cQNBW3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAruTQFdDsbzZJbN3TZIoGPXKG4aOYZ4bOtIlakumwI=;
 b=lMm348bkhHACSRMHirFUN0j4/msZkoibHeFYpJ78RhhKMw8+mnNvcwdCb8vHXRYJPv5JpLrQLfitT9kZWBA70mQukIQ1s+16yt9CjgxdUg109eM2qDp8xkmJrrkpK63VAzbf8drbKcr/xSav2LS0Cne345r179TFLcYcD+CPbWcP9Awub6P3f783jVtE+xJGuk+OnHhhc9KT3luiD2lJEJzAxnQmtUskuHIskn4XWMKEBJoSSj6ELOacPpYS/3bVm6iV3EwBXtYml0bvcRSWepswT6fBevV1vwVa9fK8JWZNZyloe1kHRPUzwiaJrZ+996a7vAUGXKWnV7Jq1vIyYg==
Received: from CWLP265CA0528.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18c::17)
 by AM9PR07MB7812.eurprd07.prod.outlook.com (2603:10a6:20b:2fe::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.30; Mon, 14 Apr
 2025 13:12:18 +0000
Received: from AMS0EPF000001AD.eurprd05.prod.outlook.com
 (2603:10a6:400:18c:cafe::d5) by CWLP265CA0528.outlook.office365.com
 (2603:10a6:400:18c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.35 via Frontend Transport; Mon,
 14 Apr 2025 13:12:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AMS0EPF000001AD.mail.protection.outlook.com (10.167.16.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 13:12:17 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 53EDCIJE000852;
	Mon, 14 Apr 2025 13:12:34 GMT
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
Subject: [PATCH v10 RESEND net-next 1/5] Documentation: netlink: specs: tc: Add DualPI2 specification
Date: Mon, 14 Apr 2025 15:11:53 +0200
Message-Id: <20250414131157.97425-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414131157.97425-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250414131157.97425-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AD:EE_|AM9PR07MB7812:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 94be8119-73f6-42b7-fd9a-08dd7b55fb78
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?YnBXtHklphn8khaKPURxB7jNGjT7Xv/b0FH1x39Q7H4XITkVOenMtP7Bf8Ht?=
 =?us-ascii?Q?tWfd2YTcjdBRZlU1IMghAtHfAvc/IXwOk0P/TYp8YvT33d9r94GVB4uo/Po4?=
 =?us-ascii?Q?l1lMK6cP4Zecbv+n9410+E4rtBwZSxfFy/kY9kUi7lMDCb8Fec894ISZnZs0?=
 =?us-ascii?Q?k9oFs9mPPAPaiUAsUtlLPaS22Rsgj7AY4mECjl65cqxwn6LaaV+vtnvBTz5Y?=
 =?us-ascii?Q?l5YHalzXY9eKt3AI7pF+S22AE8g9+WkSHOPRgOej7+DqY09wXOaSwDZBMxAt?=
 =?us-ascii?Q?64jGCwHO01BpnKwdAa4/NNF2mE+HP8AyYq+cLw4edFK4Ggazmk8nPPS725S1?=
 =?us-ascii?Q?9tfW2B+z9t8KY/Fj7VhdgG33+VGqR4xVvS0kpB9l2aE53xNGDT8Z5B/JQ0Dl?=
 =?us-ascii?Q?GW7OnO687MShh8tCHCmIJ/TYWCyrvA6xbuIGBhONdI+y/AYZgOofstU0c/7o?=
 =?us-ascii?Q?gTN+WyOflm3ebW2dL5JWLNAaLHYThWVRzEq3YOEAKL9XdHUOjK4UJcvLWMCO?=
 =?us-ascii?Q?whaPGs3Gwu2wxA9/hHdhhkl6EtCMzeoscDAqUiv/J6/QE7Km1+Cuoo6TDcyw?=
 =?us-ascii?Q?mbnswfkyKKjTDmDsDCBA4lp8y/9BCTJejFtX9vhWUMhZE0bd5q7mbOg6GqJD?=
 =?us-ascii?Q?2uHnJWNivWJwT477hmXo0hF9W8NnfmwgeTUo4fEKtcBdr9RcERVkmB+rK0QU?=
 =?us-ascii?Q?h2QXJ03C+2RkJ5Rl2JZFaljapjjlcYMhuVg68AE4ONVg4I5/Txd71j1aGJXR?=
 =?us-ascii?Q?Ca5LQn0dVlTqaMx0WMhZ7RpWyvrg8BO11XR6+2X6rxLXxU+EXWD0EtbNtJc4?=
 =?us-ascii?Q?6oY97aILx51EdRapSRHje80ey9z+mDE5vc3o9mJmYAx359+Vx7bD7vD5n9TG?=
 =?us-ascii?Q?9Q1L7OPmDjnn9bK4fkZ2jFe22av15msnv01BhuU3LXhjGbzNWhxPm+ZhlPoB?=
 =?us-ascii?Q?Y3jnzpc4XvJn3zH7sI79wLKGg74lI1E86gODARl3LrvWTfd+ooVeoUiPIFVs?=
 =?us-ascii?Q?kF0n6Xfrm/pauRtV0i9QLeFE+EeMfYgRyRWVV2RC6F0xr3FOPeBdNk+kll/H?=
 =?us-ascii?Q?7YNPV0EEemldVmAHUReFFkqenTHs5Rp3B8NWiZ5ct9SDCB46iSXgoSX7LrKc?=
 =?us-ascii?Q?WNKnKlRnC/tIJzU42wenB5JIqQ+8eHTTMRkSw1noTt/HeUgGKErhW+1NnsD6?=
 =?us-ascii?Q?jWdpMro3YbQo11LRN/OFDsgyw1FyBG4GiVo0NvQHijVHqV/lJjje59eqVe6q?=
 =?us-ascii?Q?xb5/EtyTjAZA8ixmn2GcoYyqFZIZ10ab+EUk/eSud+kF2Kp2/COyaSOmyLWo?=
 =?us-ascii?Q?vhA8oFmoY0y9L6WdMa6PJywS4JaWiB1JKrsp4kfrifzS+z08VtLg3KsBPkuu?=
 =?us-ascii?Q?NuxsrzLnZljImHaEg7RLD+VywKyGr6X7lrB51zG4D94kXwuUYfvTczOd2GoI?=
 =?us-ascii?Q?fVQvQv0kosVll40w4I0B0MWdC2rvpVfBfVt6hwaW8Tfb8SyspyT2zLLDzRCD?=
 =?us-ascii?Q?mH9sltThz5QprMQ7pMB28EXRZeByLeTMbYf+YbWOwGxZAjzkZIoz86QAbw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 13:12:17.6831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94be8119-73f6-42b7-fd9a-08dd7b55fb78
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001AD.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7812

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


