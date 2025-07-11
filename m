Return-Path: <linux-kselftest+bounces-37126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 889EFB01F32
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 16:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40071CA4F76
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 14:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26112E92DF;
	Fri, 11 Jul 2025 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="e1+ghqTs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011013.outbound.protection.outlook.com [40.107.130.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8B02BAF4;
	Fri, 11 Jul 2025 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244351; cv=fail; b=g5WmPhf+1JBf1teAk+QO7Y8t8sDvrXPBueCKSWpkATVFnMROwd1rEUurWRYfdjeKHfRnJ/BZ9dE1Jq6PlkCcinrgNcFeFF3nnI3vhFEOA9Grz+6jMc5TuOFuIa9iUbkrx13NbUius6SbjJKwBBaYmGW2NGcbHhKM7uzKwgGpKuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244351; c=relaxed/simple;
	bh=FfE8K0E1bxyIfANuT8ef9bwnkIg7dKViZawzHpmBaoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rHQoD/Z+AQpus+YKxqS0EcZhJQnOrum0p8ZaOP4V0fx6xKSI7129bnD0hiC05mYG1ZY2vkNj0uwwhNMz7+w1xNcwfhZ9XZ3d48my9M2hkifrsmpStQc+OnsDiM7RSj1SmFySI97aeuF1rUv9ScqzhiKobQafUR2xqOKQXnTk694=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=e1+ghqTs; arc=fail smtp.client-ip=40.107.130.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1iBvAME/juv2HUwF8wXJi8smxWuMK+bLhwY1JBRmStBgUP+WZ+53GWQJFn2uWx8YCaqXL9M/TJ3fF+r8Fh23tGzjYIa+GuBt23cp6UR5ds6Ijrsy1kX8bmSw1T8eR3V4CMsWFkC4G/Eop4hdM/YaTgyFciYTRQj+MdqSmWwbe87qJPbfYsJMtvD3uY4XXIBUr2ZivVrKpp7/GOOPLyTlNvcWYdNw5EuOddVsnU0kLZa3PuRDfioM3KelKuOETsBYnww6h7k4RZbqLu9ASB3Xf9Equ/3ieR27P8bYtQX0wRGmXnHuIUsJLyq0rIxC5ikQyuBZpjc92KOf3V9Zl6jiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y92OUkhdcTtpuk/R+YGCswrouhqwC+rX9Ds3aUvQu2s=;
 b=mA8a1LsxMqxx5CvhSZeGJv62BjbU9UOpS93iKUD9t4JK04ec3HDLqjXdlm73gP0F8yj7i4p6BoHROe7zJwOXo/PsRzuAequRyiCed5nKG7eLvUCU9IVz33Vn7KftcaQJlRU3SXesPgRXbm45iU2nQhcewfRRRfpmvMxbaxt5udRaaR9mceATSdLZCAR3z2+g61f/Y2GTDN37My3hNoZE6dJii7xn7yfNE9UuwQPQwYmzC8B32sHKtSs1dD2aGpiJ6RV5KFJLheJ39Hr/og2Fi1fLKjaLtSm3NMOUSyJRY5H0BnwtNLJRGSCgpiCBA15zs26Pd1psVaQKXYEM8WKldQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y92OUkhdcTtpuk/R+YGCswrouhqwC+rX9Ds3aUvQu2s=;
 b=e1+ghqTsOlXaPnvmj/Jq5uTlXj7J2G/05N4kwXyVm1M7GaMyMtD4P9q+IDTIGrkVq/p7/fHZjKybVYegtgU9osURBqcuHrbIbNNfGKGX4XIGZnKiV+lvw2vKmSb3yEP2C83BlvmbrDD5PKzBV247MjYDKvfoiii5ypWlycJoAKYQ4tgUB6PFZOlYIrAhlyauEboqQMbrAwOJv0hnlRmciLlQGCNTBHoCSockgNl2Wkjgz1Ve+nqszEL9sDXwBSYMkjkgXIPv+MxMR8Fu3AxVjgcMN6a/gIMbCDMTGYJ5uHiy74ytj++7dBGRvDNlFTEIVMQHSiVX0YfCHHJ4u7G84Q==
Received: from AS9PR06CA0677.eurprd06.prod.outlook.com (2603:10a6:20b:49c::22)
 by AM7PR07MB6580.eurprd07.prod.outlook.com (2603:10a6:20b:1a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 14:32:25 +0000
Received: from AM3PEPF00009B9E.eurprd04.prod.outlook.com
 (2603:10a6:20b:49c:cafe::9a) by AS9PR06CA0677.outlook.office365.com
 (2603:10a6:20b:49c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Fri,
 11 Jul 2025 14:32:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM3PEPF00009B9E.mail.protection.outlook.com (10.167.16.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22
 via Frontend Transport; Fri, 11 Jul 2025 14:32:25 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 876D9680034;
	Fri, 11 Jul 2025 17:32:23 +0300 (EEST)
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
Subject: [PATCH v22 net-next 6/6] Documentation: netlink: specs: tc: Add DualPI2 specification
Date: Fri, 11 Jul 2025 16:32:08 +0200
Message-Id: <20250711143208.66722-7-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711143208.66722-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250711143208.66722-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9E:EE_|AM7PR07MB6580:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bd1564b4-7d08-4ea7-53e5-08ddc087c135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BZg01WbUJCNAni/46eGK+H3wktcwUcy6dEn4hpVNKaEDRWOElOas6+mY11Gp?=
 =?us-ascii?Q?Kti4sJUI8L7LIIhweW/G6DmkTQQYzd631ROJc4zeMQ1N+o+UIKK/rLe8hEHo?=
 =?us-ascii?Q?OzBAScOaPlPJdZ0NHbiIzB0siLxq02CvNxReUJ7n/KpKklhI4TqvIEIB4ylz?=
 =?us-ascii?Q?SmC99jHyZ2cgMgIHRNhmAWeQGY67rFAvV3TlNJH+6ze3OTuvLgzuHpL6+KbA?=
 =?us-ascii?Q?udavmaIPn+1f0WtuXtU6wAD/SQNOUs7RfjWIqlxKJwSHtJM6tJeGVPddsiur?=
 =?us-ascii?Q?2Uvz3m9VUmjov1eSTnVdeANwI640ioMzPQZN/9fH4o0/+HFTo32CqjY1Xynw?=
 =?us-ascii?Q?h9ErjEg5sOPzuvg4HWOPrpvzqABBPHKKfF8zcnCggFi2IidikgOQ2+SlWeP7?=
 =?us-ascii?Q?Z/rDt1CS8nN4dQgLvYxtwXIpEBWSDsqun4lMA8v+Zk2fLlJ/d7DSWLPjtpR6?=
 =?us-ascii?Q?KtgkF/gHlWNMOLlWh8S8R5nhQKFDhf2zGs4EvsgQ6ULFmO3wWX7wcwi0z9g7?=
 =?us-ascii?Q?BhSroeGLpX+ld4tsEoO2pZ7kHd2BtzMeEZDoYXi98TZ+KoWNeN+ErSTFN0EU?=
 =?us-ascii?Q?VghvxCIzZ9B0/8L43QH7MEtH08OW5CkikV9XGamM5u5SMrUgFrRwWLHlnyMH?=
 =?us-ascii?Q?P1S3cw1hOUdL8T7A9Vev3VRYL+p3ZhfpO9tUQq/1VITWYOj350ZlBNd3xtxp?=
 =?us-ascii?Q?oUEmaDubGY+Ldn8tCu6uRZuZvutvOpLYQe7j0jfFVemOdxW8SghFoN5oK6Yg?=
 =?us-ascii?Q?ALUL2aX8yOr/YCV38/hW8iOfjFaQfaHlhy96ScvgweaQmOtYgMoWsUG00F1b?=
 =?us-ascii?Q?F+JclwqOU9csoF+NPFOxwWj20Ya2xiwQOXrjCDxbjzqgTyTQQCXKckAwK3CM?=
 =?us-ascii?Q?RGhX1sfSVPmG4wzR0TJP3Gr4KRycCsJD2UjUU+uS2IfoOnSlH5SA3FScNIDL?=
 =?us-ascii?Q?3BbDyMud+g3/yfw/qb80rzPfyYdfwJNzieGvTiykciQJ86chAwcmzj0ZOOv2?=
 =?us-ascii?Q?CS02Mau7/pRmZL9f/1HvfNmwfD3lBUcpmuJW4KUHY9gV7DQ6JmreDY/5lMUz?=
 =?us-ascii?Q?XwddjaQwIb9iKPOh2kP2Pv7g4w9vuMrhYlaDWkZQbEgorZSsK2h26d/yFHnP?=
 =?us-ascii?Q?ifdslVQzIiRgNDJtMurzxMKL863FtFMwhb0bjtfpTqnSlqjLe5Y51aKjvpR1?=
 =?us-ascii?Q?FIDak01GLU+saHV7NWy4CAnK+RVmHrZZj2md0cH41ipfA7C80UjrQnIsmoal?=
 =?us-ascii?Q?MQl0FYorgnTnpRT5ciD9PpB4Omz1pJ6+QpE0PGzt4Qctt8fYneXF6dSBeBKa?=
 =?us-ascii?Q?4DHxjCztBdFXiEAovjNIZyQaOS3mQXWpDLfU2qt01UPj2dHid1r/IUZcBq1c?=
 =?us-ascii?Q?/y5U64ZwSyCElXh86XBodZF27QlqGtzOJ8dglMFrop9JHgpT9lE4heS3btKV?=
 =?us-ascii?Q?euW2xMvtGB5RQnw2+/8Lew8HlW+1xCjbxWse9U6iHRVlu4QYfYrZNIGTrosY?=
 =?us-ascii?Q?KTuj+84MkPNiP5diCbgo41X0+5K1VxE5iRWr+xA7Z+sRUx/FgMp0plGwa0F+?=
 =?us-ascii?Q?i9+26RXUPSvGznuS68Q=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 14:32:25.0643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd1564b4-7d08-4ea7-53e5-08ddc087c135
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6580

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


