Return-Path: <linux-kselftest+bounces-37650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7EFB0B1D2
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 22:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D29C1AA14D8
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 20:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663CD230BE5;
	Sat, 19 Jul 2025 20:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="rErjYVry"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011064.outbound.protection.outlook.com [40.107.130.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC7D22F765;
	Sat, 19 Jul 2025 20:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752957728; cv=fail; b=rLXqdEggCTjquVtULepCln9Unw7cNJjEYJ15G7pLwRRiB1iMsGw5w0LcKHFQXdNS1EcsPC0+BJIV8UaAGfQ5GRaFkKmmd9tXSDI4fLB239bE8xZlYmZWzikVfx8AXuu+joHbf8RNzmM5TQCjVLBsDG2BLuo2HLmDVkvrzN560mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752957728; c=relaxed/simple;
	bh=8rSiY1ztMBfRV3k7MQMOwyOclQZl+hl2CKcrLTE6wlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ur/WRSE5txxV9ZF7f/MBjzDxdH83nSl80SkzOMf1JuHjIJQi6vFihMkO3Q4P21y4Y1xH/JT2l/hvfTXfAxlTHMgpIcoCo+sR9MO+3nH32OEBvgPC8MuF3z7jUs1PZ/62YoNjJgieFgTbfIrhNWmVOWnH1sRgOsY+FBEfEMMbc+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=rErjYVry; arc=fail smtp.client-ip=40.107.130.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AF3NuokvBhJpyYAwalodyOmVL4h7IFNVB6cvhvzlufw48xJ3kv/K6LcFdQx8AELSw7nWZGRWjyw+KPgfdYwSzJw95bDpffTLyRH0f9xjVlNBN1efSr/K4pVZ7R2IvvkRreuEybJ+GphvYh1bZFxfhuHNYqOiu+UTFOfKmTY2PwuA8ao7pm+3U179A28X2L9AGrto9atSFPPC60hO8yr/Iw2j9SsfSkibD2x3cw29Fa9QOqeNp4pIZkEYRqnmBOuVr7dN31WyPgKsNaBEomqV5e48/FxHBg1TR2xQ10o+ksWLyoMDMkOhy87c2JdQF0qmrG0EfRPzMVWKR/hKl6kOHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ztiqykwZxZumkvXd1Gc3L8gnveGDSoSzSvHn7farX4=;
 b=TFD7z0s76eCJYirZLeQD7Ar7kTm7bgYN3iUl1rzMyRzr7EI1by1mfN3d0UlS5ExaQDh34zUJrEeg9uFNyccZU/dAls+DnyYvLKYQeFIFUuTAGjGAhfWtPoHnAFLBxlC2QJc7oMyvfBPNpAESx2PkGcOvbURohQGnr2iIZeCZTd2MeJ0z59sTqS95M1Gk+KPwDCBRROhcir1h3v/1ebTrKu4tpg0xE9qoefvetLO2iW1sTZv9GrxRW7PdkEhyxkFzRGKvau7ntUNwae7vkNiSIJIA0F1myJ9k/iwimifxL2YxUBU5Jo1y6IFZTa8Bgvj9u+kc4IK4NfJFvkq4IGVQHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ztiqykwZxZumkvXd1Gc3L8gnveGDSoSzSvHn7farX4=;
 b=rErjYVryLBCgrC99tIe8pdxwnYCnfs98tOC9aspp25VZiVtYErJm4Vk6O0l6ctAHey0eHD2nghrABXPw5xdx81/KXGAUJBGBccGG9Gi1nqoMrH5pFPzqm9Ie1QJ+jIIf4niKfkDClNFp0Cz6pCxPeGDdva8F2TfNIYaaD520ZV2Qm8SCJdrBm2h2sEGBGhfIipW6HLahU29YciSYC1A+UUGJ3HfFZyKfY8Nv2wYyusfvCjwmOLPj25OHXDDrvTyGa2aRhD9Film9fq9nxq3VyaO8lQxmWcLfNjEHsnsKTFO92cVsai0DNV343mqlvaq1MCNUHpzHZYXC6vqKlR07mw==
Received: from AM9P192CA0001.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::6)
 by DB9PR07MB8680.eurprd07.prod.outlook.com (2603:10a6:10:30f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Sat, 19 Jul
 2025 20:42:01 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:20b:21d:cafe::80) by AM9P192CA0001.outlook.office365.com
 (2603:10a6:20b:21d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Sat,
 19 Jul 2025 20:42:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Sat, 19 Jul 2025 20:42:01 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id E36231C002B;
	Sat, 19 Jul 2025 23:41:59 +0300 (EEST)
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
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH v25 net-next 5/6] selftests/tc-testing: Add selftests for qdisc DualPI2
Date: Sat, 19 Jul 2025 22:41:28 +0200
Message-Id: <20250719204129.15737-6-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000198:EE_|DB9PR07MB8680:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1d2bcf19-44a4-4819-f5f1-08ddc704b6b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?++H1yHDS4DtHfzO1uEmZOU8d1jzvoLIQbELXgHtIXUIj2Uy9Ivx/WJsoRqnh?=
 =?us-ascii?Q?JTzXOD3zPItnX0gcWfAfCpmwnoWv2jtdFBk2+zys8v29b89yDHIJlJRS1NhR?=
 =?us-ascii?Q?1vfItTEYtHMT2F7Cg2/hU50xrMA0d75fn/nrZtS/5PvpbuL4jqAavSds0+wq?=
 =?us-ascii?Q?/Q0ncbKM+oQWV5BYlsH/l58GT3NMRp6/YyYgz5itDtA1TTAHFscyO27F24dx?=
 =?us-ascii?Q?C43OP8X4aAHywZqghBIxgUhx9d8MtWY6qwaAS6F7EjjTpF+s2rVvtzJptzYu?=
 =?us-ascii?Q?i3dVwA1q0jfAPNYOm0UqL0m26mO/si/LV0FUSornfmv0sDjcZ6vxKX68b/Di?=
 =?us-ascii?Q?tCGTCBufSzomvpLB/gQJz8/fZ6SJZUC2BJ6muZaldfnPBk0GFIzAwv6CWeTS?=
 =?us-ascii?Q?694upl4cQ4JsAFJXJGGkGzGeEhAQDJXhDqaTbUTyqkhBN6Are9mOL4GHMv3Q?=
 =?us-ascii?Q?Bae1IpEVunbzdkwhScnnQMbgD9fOudWEqsOAK8jS2TZ2AOWhnHYofpb8A8mK?=
 =?us-ascii?Q?PlH28zcu1SdUcLWGoE7w/th808BJl6ZuKeRS1xb9QuMUaH1BhwpPvQs4u6ZY?=
 =?us-ascii?Q?eHuQid7U+s6jNM3tuOYTsQwOFkFXoZrtfIp9NcERJ85Mx2sMaHOUJRuktGkN?=
 =?us-ascii?Q?tgcN/cNd+00OMLdaTJxF80KENhRogpqB7Ietj+wZhxpZzgpW9M2Rf5dDtMov?=
 =?us-ascii?Q?Jw7KElX/TEf790Or+TkSPHahq1B/uMzHpXk8BpUUnk6m7J0r8KhgBZHr1sT8?=
 =?us-ascii?Q?rMdRvlRCiaHwj0fcQ5+fJXwRByjIXQqL4hZB+npxkbq+68sbxQwcWcVooBr/?=
 =?us-ascii?Q?LwVZixD5BJ62k7fKXJX4IadgpwmreyVkhTiZHUKG4M1B1MTF2QM6bczRwCl8?=
 =?us-ascii?Q?2QV2ci+tCF1x2mDzdGZxvTqwTMN4mvYgLAzYRkUUl6ll0IjaYrLMhbdpcnGa?=
 =?us-ascii?Q?v5AQnRSCj2o5Q9sdC4lFN3DnRZUi8RYGXMk7zscO/S9k+n7KGVKPIRQdXNqG?=
 =?us-ascii?Q?tfB+2cy2bjwufte/dtnmoDzdMm74eB5zavrkmneYah7bvQT+TbID0Y9p+rvq?=
 =?us-ascii?Q?w/PtFZvjXKQd4O203f1mDZBRpIeezqyj9eHb3ZQkNoA0/uC+p9WT7tYsVmKK?=
 =?us-ascii?Q?rFf127hOz/2aAz7Qi6eVoqOArDDhER6moNpNyl3R+YaqtfhL2m2AAlwxRUUd?=
 =?us-ascii?Q?nghvHNVacs2wGQFJm5yx4ZKtuAksoWETM9W/kDFGIwBlZmknQgtFKUC8zk51?=
 =?us-ascii?Q?YepCw/1eO7fALc52Pavzqo0Jx9E64l2pmlqmKOXRCuuez3qZ8CF16mHlS1Kf?=
 =?us-ascii?Q?fX7b7kEykW7ZyZ/9IBpvJl3DgdC/XJM9eCzdl2DA4SgppUfpnyiauqd7V3/G?=
 =?us-ascii?Q?qIIAtjEwuqTlj3EkKWnkquSLH/sEEP5w90cATH72NorGxQc046kmxU8cgjgD?=
 =?us-ascii?Q?kT9x56hkc4TXcZMDx5o+GnfHzP939W6P6Tix1SlWAIO3sICTlntsiMpfE09w?=
 =?us-ascii?Q?tdqIITkEE/CQ1TYyQBFH+QjZjd5VHCQvmre0dJ5g7qwbx4XoLmgAE1Tc2Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2025 20:42:01.4980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d2bcf19-44a4-4819-f5f1-08ddc704b6b5
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8680

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Update configuration of tc-tests and preload DualPI2 module for self-tests,
and add following self-test cases for DualPI2:

  Test a4c7: Create DualPI2 with default setting
  Test 1ea4: Create DualPI2 with memlimit
  Test 2130: Create DualPI2 with typical_rtt and max_rtt
  Test 90c1: Create DualPI2 with max_rtt
  Test 7b3c: Create DualPI2 with any_ect option
  Test 49a3: Create DualPI2 with overflow option
  Test d0a1: Create DualPI2 with drop_enqueue option
  Test f051: Create DualPI2 with no_split_gso option
  Test 456b: Create DualPI2 with packet step_thresh
  Test 610c: Create DualPI2 with packet min_qlen_step
  Test b4fa: Create DualPI2 with packet coupling_factor
  Test 37f1: Create DualPI2 with packet classic_protection

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
---
v19
- Update commit message
---
 tools/testing/selftests/tc-testing/config     |   1 +
 .../tc-testing/tc-tests/qdiscs/dualpi2.json   | 254 ++++++++++++++++++
 tools/testing/selftests/tc-testing/tdc.sh     |   1 +
 3 files changed, 256 insertions(+)
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json

diff --git a/tools/testing/selftests/tc-testing/config b/tools/testing/selftests/tc-testing/config
index 8e902f7f1a18..c20aa16b1d63 100644
--- a/tools/testing/selftests/tc-testing/config
+++ b/tools/testing/selftests/tc-testing/config
@@ -31,6 +31,7 @@ CONFIG_NET_SCH_CBS=m
 CONFIG_NET_SCH_CHOKE=m
 CONFIG_NET_SCH_CODEL=m
 CONFIG_NET_SCH_DRR=m
+CONFIG_NET_SCH_DUALPI2=m
 CONFIG_NET_SCH_ETF=m
 CONFIG_NET_SCH_FQ=m
 CONFIG_NET_SCH_FQ_CODEL=m
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json
new file mode 100644
index 000000000000..cd1f2ee8f354
--- /dev/null
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json
@@ -0,0 +1,254 @@
+[
+    {
+        "id": "a4c7",
+        "name": "Create DualPI2 with default setting",
+        "category": [
+            "qdisc",
+            "dualpi2"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root dualpi2",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc dualpi2 1: root refcnt [0-9]+ limit 10000p.* step_thresh 1ms min_qlen_step 0p coupling_factor 2 drop_on_overload drop_dequeue classic_protection 10% l4s_ect split_gso",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "1ea4",
+        "name": "Create DualPI2 with memlimit",
+        "category": [
+            "qdisc",
+            "dualpi2"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root dualpi2 memlimit 20000000",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc dualpi2 1: root refcnt [0-9]+ limit 10000p.* memlimit 20000000B",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "2130",
+        "name": "Create DualPI2 with typical_rtt and max_rtt",
+        "category": [
+            "qdisc",
+            "dualpi2"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root dualpi2 typical_rtt 20ms max_rtt 200ms",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc dualpi2 1: root refcnt [0-9]+ limit 10000p.* target 20ms tupdate 20ms alpha 0.042969 beta 1.496094",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "90c1",
+        "name": "Create DualPI2 with max_rtt",
+        "category": [
+            "qdisc",
+            "dualpi2"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root dualpi2 max_rtt 300ms",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc dualpi2 1: root refcnt [0-9]+ limit 10000p.* target 50ms tupdate 50ms alpha 0.050781 beta 0.996094",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "7b3c",
+        "name": "Create DualPI2 with any_ect option",
+        "category": [
+            "qdisc",
+            "dualpi2"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root dualpi2 any_ect",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc dualpi2 1: root refcnt [0-9]+ limit 10000p .* any_ect",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "49a3",
+        "name": "Create DualPI2 with overflow option",
+        "category": [
+            "qdisc",
+            "dualpi2"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root dualpi2 overflow",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc dualpi2 1: root refcnt [0-9]+ limit 10000p.* overflow",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "d0a1",
+        "name": "Create DualPI2 with drop_enqueue option",
+        "category": [
+            "qdisc",
+            "dualpi2"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root dualpi2 drop_enqueue",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc dualpi2 1: root refcnt [0-9]+ limit 10000p .* drop_enqueue",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "f051",
+        "name": "Create DualPI2 with no_split_gso option",
+        "category": [
+            "qdisc",
+            "dualpi2"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root dualpi2 no_split_gso",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc dualpi2 1: root refcnt [0-9]+ limit 10000p .* no_split_gso",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "456b",
+        "name": "Create DualPI2 with packet step_thresh",
+        "category": [
+            "qdisc",
+            "dualpi2"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root dualpi2 step_thresh 3p",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc dualpi2 1: root refcnt [0-9]+ limit 10000p .* step_thresh 3p",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "610c",
+        "name": "Create DualPI2 with packet min_qlen_step",
+        "category": [
+            "qdisc",
+            "dualpi2"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root dualpi2 min_qlen_step 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc dualpi2 1: root refcnt [0-9]+ limit 10000p .* min_qlen_step 1p",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "b4fa",
+        "name": "Create DualPI2 with packet coupling_factor",
+        "category": [
+            "qdisc",
+            "dualpi2"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root dualpi2 coupling_factor 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc dualpi2 1: root refcnt [0-9]+ limit 10000p .* coupling_factor 1",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "37f1",
+        "name": "Create DualPI2 with packet classic_protection",
+        "category": [
+            "qdisc",
+            "dualpi2"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root dualpi2 classic_protection 0",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc dualpi2 1: root refcnt [0-9]+ limit 10000p .* classic_protection 0%",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    }
+]
diff --git a/tools/testing/selftests/tc-testing/tdc.sh b/tools/testing/selftests/tc-testing/tdc.sh
index 7a81088802d1..dae19687912d 100755
--- a/tools/testing/selftests/tc-testing/tdc.sh
+++ b/tools/testing/selftests/tc-testing/tdc.sh
@@ -66,4 +66,5 @@ try_modprobe sch_hfsc
 try_modprobe sch_hhf
 try_modprobe sch_htb
 try_modprobe sch_teql
+try_modprobe sch_dualpi2
 ./tdc.py -J"$(nproc)"
-- 
2.34.1


