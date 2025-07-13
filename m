Return-Path: <linux-kselftest+bounces-37203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C645B030B9
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Jul 2025 12:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7124E3BE013
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Jul 2025 10:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFCC2777E8;
	Sun, 13 Jul 2025 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="fKAxgaxS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011061.outbound.protection.outlook.com [40.107.130.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BC724BD03;
	Sun, 13 Jul 2025 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752403978; cv=fail; b=eERHL9HxtwTn0LSVLmaq55YTIGuhwd6D4GFTcV1aTL3MOl/UJVVtavb7s/waJqY5AUjv4mOA9h7snjKC6j8p67UJ0WrDSYSD3dWI21W5/gnayPrrkE4eaoHpvInFf9yHOfNLYJ0eyjJtxs8hFUA0XZ0cmjKE0RaCx/tze1MC/NA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752403978; c=relaxed/simple;
	bh=8rSiY1ztMBfRV3k7MQMOwyOclQZl+hl2CKcrLTE6wlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sgb+McZF8s8KkBP3UNlEbR1TKB0I3scj0jfqXC/iS76pTPQz+E3RFU4j2qG3gVtcUO10MgIDHMlxQwuNMXiVVLc1XgjXXYoC8gSKDQPIlwTXcXr7ldp9LBv6ayRAut5IbYZXaR59kXT3ERAtaMQbh8U11s3HAUUAahbSWxatQ2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=fKAxgaxS; arc=fail smtp.client-ip=40.107.130.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wbBYqfJrJcqO6loLTfEtNNhhF8bbbTQSQUxRm24Zdnk8DrjriUuMu88tE8RfZUeqgqFA9C+D/Vkhd6PXizdM5hf9wWhQ89IfRSEc+k/C7kEZGpUb4F/VHcrR11Of/iSNAy7JBWLMByb0e1Xxwzq0Xl5cEE0fEPXSR5eUxEUzJIF+Rrjt3Exn1J0qskQlBxrUhr4ZFZhDsoi6AkV+bh0tYi44+TVrwloqvmWyNsU2QvdMyI/cxkJgQdUj8WQcqrCiBnyzeJxrJUZ1w5/X3RN9BQC3/nwWQCa70zMpv4PuTWo9AWJwiEGhu3pxQ8YkKi93o0m7LwUzx2f3qyNRnW9CQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ztiqykwZxZumkvXd1Gc3L8gnveGDSoSzSvHn7farX4=;
 b=XLTV6LnUT9B/+an/ckWbrGoAYT+42WULXxS7vf3oZYoZn8nbibTeZtpFoRe4f5hBgDIEBbQqyNvdkfhDGaRiT+wFgFoxZb8u0gS0qtJr2hn8uFdnrP2vQwr/lzLlEtxMW+gJrDIZpjwOWXNBLzhyweDsbCJAsucU4atPqe5vXG5n4qAglfb9sDSlvL+hoAew+WbE3mcijmFruCYENOBMQmugZmmjfYoZ7krC+sz3fwKGsuFK6L5yqXdud6Yk/5HrSC9+eYiM7okCXhlhoBvX/oUkMHVOKJcify4JJkEXkNGJMS7HO1huPthxFzmdo99mKIQQ9rnFkTP4KF/sc6ERdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.101) smtp.rcpttodomain=apple.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ztiqykwZxZumkvXd1Gc3L8gnveGDSoSzSvHn7farX4=;
 b=fKAxgaxSlbj2DaaP0TWeHGROx00BfIfz+y1txubmUwRnICd4KMcoFMkeeKTDjO3ufJlF6EZAhFVsrrAfXdX25Fz1rWUDXLS7vMyGNDRFIt4X71wbvT1IYDKAxouOQ6Y1d166930c2ELfS3PMPPZhKIDp6qNvnkR7pma4kcnrkVYwXJnFLWnuvQpRClhMVUncXkQyTYAKOsRs6xJN//RBLj5OaUh+IUuHNUFAfB/9SVn9k3CgmrB4EmCdWqstNTplTl8F63wsQxjFMTZKKdfcQstU4KyPO9AT4EdPa+/HK8OsoanXhNk7njRO/SUDVuRah1yIkXxFQ6PnoypWOYZiuw==
Received: from AM0PR05CA0083.eurprd05.prod.outlook.com (2603:10a6:208:136::23)
 by PA4PR07MB7517.eurprd07.prod.outlook.com (2603:10a6:102:c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Sun, 13 Jul
 2025 10:52:50 +0000
Received: from AM1PEPF000252DF.eurprd07.prod.outlook.com
 (2603:10a6:208:136:cafe::9) by AM0PR05CA0083.outlook.office365.com
 (2603:10a6:208:136::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Sun,
 13 Jul 2025 10:52:50 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.101) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM1PEPF000252DF.mail.protection.outlook.com (10.167.16.57) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22
 via Frontend Transport; Sun, 13 Jul 2025 10:52:48 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 6D8541C004D;
	Sun, 13 Jul 2025 13:52:47 +0300 (EEST)
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
Subject: [PATCH v23 net-next 5/6] selftests/tc-testing: Add selftests for qdisc DualPI2
Date: Sun, 13 Jul 2025 12:52:33 +0200
Message-Id: <20250713105234.11618-6-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250713105234.11618-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250713105234.11618-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DF:EE_|PA4PR07MB7517:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f4bd9731-ce42-48ff-c617-08ddc1fb687e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XFwdTgjPtzuvN7VhNUw2NRl/f7ndG2sFAejTBa7badzEkhZJ6LOk7dpcrp2e?=
 =?us-ascii?Q?aqZXSUyQPrMCy93z/j5d9GZXZg1t5JgDy6AEcI8aXbeP+GwCSutXC1hBe/tS?=
 =?us-ascii?Q?ODBW6G91E0x+nbaTJaBhezkuWMeYRJomeRR7iMYJp3yhSeuQinCFaMY0Ae6l?=
 =?us-ascii?Q?mm53h2xxUHcHi/R0IRbjoklGcSMOkGCNxNvL1jgsD08/6oJqMY0PPk3k+Q6i?=
 =?us-ascii?Q?juQqFTamzWU7adoWXFd12PePYTvb68QGozGYPN3JyBXZgs75n2oXo36ZS1Tx?=
 =?us-ascii?Q?qLFuNBYMlxIHWwl7F1SGvhRoB2c1xoL79w0xJVkYxm7PndVejBZgFIAM1M6z?=
 =?us-ascii?Q?pu6aQYeefYs+o3MEttx2iSRdVzXxfCzhu+uL6ZZJehRpytaEVHNo/PngP6HS?=
 =?us-ascii?Q?SiblaqjNheSs4yQ3eZiFKLU7SBfO3eRRxj4RYgLi2KYwZ2oQLpVcSk/iQaoX?=
 =?us-ascii?Q?s03h9ocmdufyakP29MQR2P4LNWQDIXKhaW36YzlOH4elEH6RS68GO2jKatWB?=
 =?us-ascii?Q?Jvdz7NkcGqkw7Gcr8YHNKG3Jk2O/RMjtcBPD94BX4j4WeeAwshr6Hh2MEzMe?=
 =?us-ascii?Q?RdUfkUxIvre+iMM4Od5dOsBKyBlKrud149SUuUI31kbVZz2Ri0c9pCcVmFLE?=
 =?us-ascii?Q?r8ErwQl8kaMzPYtSHM8u6EnJLC/PL428z8vUiuuASCEIe3QR2BmJxLdR5xG0?=
 =?us-ascii?Q?0qJwVGBYMX7/CQoVbMdXtK3dhzYqHBbWOSiTLzICk9pxLL7/2FUrALUcOnZj?=
 =?us-ascii?Q?EjvlzhXWGkjHwFpGna6dbqZ5un375uf2nBsq9TgmyVum4areuPBKHWPcLMVy?=
 =?us-ascii?Q?lYfKKfJoAlwF+lQA6867AJVvgLdQ0WyfmMCc/dcEYWiT9mVSgoHR6L03PLnJ?=
 =?us-ascii?Q?N7pNZIE9ld+AoS49PzDoVk1foF5XuWlE63btEDCTGiF67ueiUgcCs2t0f1Bn?=
 =?us-ascii?Q?PAhSNvNmzRneLAx8rN5RGVWUrkKy1NjPw4e6SsbzCvXMZ1HAPyA3RkXUPofX?=
 =?us-ascii?Q?YZ9sigvj41rJVUE8PPsJ3oyCz+8/fwBRqhmGP0j8uADFbkTnTMYa8SQ4whQb?=
 =?us-ascii?Q?u+87+mI/C6jM4ay6KmDdU6cyZT7ysEhHLECSzHDKZOyxWWtIeU+AKCxHz9Uh?=
 =?us-ascii?Q?3Vk3E3TNiD1FDGrHNtvfeWCgTsCbkggu9SWapmHDcKanZZX4aW/Qa7onCvvr?=
 =?us-ascii?Q?5xMb5kFERJIOrEQIxoHa9v26PeNvtab0j/R0L4a6YA8D7ekiQUeZpMZljqTE?=
 =?us-ascii?Q?uKUIn9y1v6J1kE/6QLL4kExfHfu945cKyDZ562DhlpJV8wKyELNn7NdM7VR3?=
 =?us-ascii?Q?HQPyHmOUmQU06Y1wr/IBmgAZ7c0mv4+qWwXIvK3h26Nl4/BA6hubFhymIGEX?=
 =?us-ascii?Q?phFOGUWgqW4vzeap5wG/PG4qrDTBOCKipsE20/6q6u8DN60cMkYrxhns+2xN?=
 =?us-ascii?Q?Pl4FgFDmRWn5qA/z7O2f3RgeWsfPlgrM5jtWRpahpE9sjS3NEF8fdf6p7WTr?=
 =?us-ascii?Q?k3tglORWUAA7tdvr4Lvb0TH8dppfXDMZvomnkzbFmCVMfhsm99OTL5snuw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2025 10:52:48.9881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4bd9731-ce42-48ff-c617-08ddc1fb687e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DF.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7517

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


