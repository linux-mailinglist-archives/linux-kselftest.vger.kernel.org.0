Return-Path: <linux-kselftest+bounces-37811-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5628BB0D672
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 12:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55A623BA565
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 09:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465C52E0B45;
	Tue, 22 Jul 2025 09:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ZHO0pKl8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013055.outbound.protection.outlook.com [40.107.159.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3B22E093B;
	Tue, 22 Jul 2025 09:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178376; cv=fail; b=AWVf/E6i+4naw0TWbXOSUVVzi5kfVzpDVIFTQxzmAZQHizSWWquR964P7Zl7kYC8ePo7iDRN/DA7qfK5BI9gKd/xvPPm6k8DIt1bIS5RXZRtiPCY03QxQNpqGWiwmjqmNSI7Hdp5jomVb69l79xU7UJIoxX3B67xaxe/5jR61KE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178376; c=relaxed/simple;
	bh=8rSiY1ztMBfRV3k7MQMOwyOclQZl+hl2CKcrLTE6wlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fuou70BGiXpA7qTCNRp3qpquMp22spnhgjB3gwXBuVYQ8WPhZirMoS9VojWFONG6J7+qVtGwjK7YGXifLI32wlEVmrLr1s2SdBOP6OGWQjH8SbmR4uWrYCCyxJyAON2ou9atuvGv0qjBCnyJnW3yLvi+a8J4u55xeOWe8aqWJ0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ZHO0pKl8; arc=fail smtp.client-ip=40.107.159.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1jJ1qn/NFHvSd5GQAM0rBAAD2GA6fortKhPpANUPZqVl6TSVA2ozXwsfv+VC8v07HXJQG2W4PIv3YtvJOm7l/qLImn4CCjMp97l3dlYOTOf9YYmg6jo4uwsQPhvT/VH4Yb1Ipv1BluTTjqolyv40MQZ86JjWe031BcElpTFB8yX8j8PX2l0MQoLJutge84irefMgLa7lBW1TTC1LmNt5PWfBtpaaCmli5g5XL4fpPwYLU5En2aca0TGluYjNTG+eCmzVzMei49dVk6ingYf9zFZge1p7IHQBynR7lSJ856Xnqj9znG84OzYV4UayDfJercEUwimigHwFljJzDDSKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ztiqykwZxZumkvXd1Gc3L8gnveGDSoSzSvHn7farX4=;
 b=ZYj5J/dSli5wkZBOpDcffc5ihbcsf7d5ZwKyq61mv2mA+yKvvEiAvElvLjkKwzBDOBDfus6efVgJTbj8YrKMSDdFdI5/aAY6Sd1nxWZiljziW2QDpwNxZpPrTZ5M3FKBNaT1d6yLCYLmrFhUc/y1FNjKbiawD2NJZ/ZiBZ+fMxNptqvSRDyTj0JPVVoJH7K1pJPbc8ixGdf/j6Qgy1KSQ/xZ1PYmxenaLE3upQxs7pFBGY+Fel5V8TDVHRBZxIS14i74ln9NHo2z+OYIF3jP9YD+B483zCbHDf2c0u5mGhLUV9drJ+eqwJg3mmcYnzNLVvSenXs8VrZQUg8ADG+uKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ztiqykwZxZumkvXd1Gc3L8gnveGDSoSzSvHn7farX4=;
 b=ZHO0pKl8CeZNn+QnMzrWAYTD4GNMnOj0YNkvpqFyTdDIgvB2E68/uJzSi9GhRw5XHGttRPk/9hLyl9ZtCx9dN3tuoiK5/DZ2+msFm9GcMTYif2ofz4UleqzClzNwhVT5OKz31oDNzGa0yvxSbmKwpj1r8R4oXRXCbwLGbWL/ak67nPam3JiYi9/jYeMsxJsjrJ3hgWj7CMhMmtNQlBW447SYOIcdbxJ6btVS0D3J1q8Gx15UMazLFmVpeSn2SeCDIDt4gYY1lwHWVmzeTm5Npq7wBGR8xH5Ff0Hjf6qmKYTPl1LVqpXzSkjWrFGUz5qENvR1ps2C4HEumTXIVfqiWg==
Received: from CWLP265CA0469.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d4::7)
 by AS8PR07MB7976.eurprd07.prod.outlook.com (2603:10a6:20b:352::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 09:59:28 +0000
Received: from AMS1EPF00000046.eurprd04.prod.outlook.com
 (2603:10a6:400:1d4:cafe::3a) by CWLP265CA0469.outlook.office365.com
 (2603:10a6:400:1d4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 09:59:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AMS1EPF00000046.mail.protection.outlook.com (10.167.16.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Tue, 22 Jul 2025 09:59:27 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 41A87680048;
	Tue, 22 Jul 2025 12:59:26 +0300 (EEST)
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
Subject: [PATCH v26 net-next 5/6] selftests/tc-testing: Add selftests for qdisc DualPI2
Date: Tue, 22 Jul 2025 11:59:14 +0200
Message-Id: <20250722095915.24485-6-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722095915.24485-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250722095915.24485-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000046:EE_|AS8PR07MB7976:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 95427dac-a203-43a5-e2f0-08ddc9067222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k0l96XQFs2eQJIc3h7Ivg+/cA62CCx9q4R62R/nBcferQ/5N0l7dMfzFRrU7?=
 =?us-ascii?Q?n62lpwRt2GYdntqbXp+7he637poqyr2EJQ3N9Bth+sJaq7Hl8Lz+37Lml6uO?=
 =?us-ascii?Q?jdgbynA8kfoZEUtRVMd31/yBOnnYqy7xjXhih1HZROIjl/5N40W0z1F2qWsG?=
 =?us-ascii?Q?C0o8kz7rrh6bm9Yt6nGAqAW9txq+6va0eEa21zko7Ot9ZQrFHR/zQhU9yRIf?=
 =?us-ascii?Q?1IysqFRX2AFHeqVjUPcyrMZT3TUwkB+EiK5hL94jQVNFaPYXb0pGrnCZhpmY?=
 =?us-ascii?Q?fdAmpJa76nUOTnkSkzCsstmeEJNp2ihUZgu3BOJsVK8pER8Gig6q+p7TCjL0?=
 =?us-ascii?Q?czUL/SqbluZHv0cyHzHodsYQ4TadfEpqt967Xwpwvtgf0mWCxM1Ckihi3I20?=
 =?us-ascii?Q?Yo1oHWtDKvSuhyiUlnrTm2okNqiRgztQ6Xo6mjsU7ypBzOaC7fVwmuV0vb2c?=
 =?us-ascii?Q?BVFyYIUvRTEe//7LCHngpedJn8rLYQvIwHfcrydzNdVqrTL8chAhw94HGtat?=
 =?us-ascii?Q?rER0hvU5Wd2Lq4fMc8NPsMXmUM5LY2pJ8WPJPfmT4SZUYHnCHngpLAvD+PfO?=
 =?us-ascii?Q?wAz2NrQqEPQVH2/ggEs3oY8Q2kloNuM7snWvBO23xEDAxF83/yIgAXND0x4p?=
 =?us-ascii?Q?/sRm9TmlLybfHpelWl3Hnu4doB74szOlDojWtjV11fwJbfJMG7xFe+g2jYAa?=
 =?us-ascii?Q?1ipqU3V5wrk5mUEZA9gIYEXHib2LyoePqcTLmndaTt8uWVebEhmRDTWatfPH?=
 =?us-ascii?Q?3hUx7iIAUaql48r3TTR0wfoBGDW4W5FTuBnXaXxk60sW9qyNopdAJdVZWnqj?=
 =?us-ascii?Q?jAsHlwncO/LsjM8tCgnAo4IOZ5b8sLHlYXYqbRKU2A0qwcqgWgo+wKSJyWXw?=
 =?us-ascii?Q?P9+8Vd054zvnAHMtGh2t6ladlariW9e3/V9qnUa1ZL1QyXHHodvLO9Z6xNca?=
 =?us-ascii?Q?mXzjsTRC7B6Jf+jw/igQdzyHD002cQqnYgo+B44DHf9fv0cAnvOpEvbeo+kK?=
 =?us-ascii?Q?pbUdbCAn9JEhepS5zqeE9/Si272lKjiPXW5v2wZ/QcFmjAskW5SgEUhzcf+4?=
 =?us-ascii?Q?BLX3SIrkYF9C1rZ+eydhBu+k4CrIJw1iw9bz6pDGXv13fSn53z1I1AneRJB1?=
 =?us-ascii?Q?RztJIXYJptnzgHa1yJIMp9FwXarqmOMj3RQd8TwP3fDs4AH4hV2pswGkUbSW?=
 =?us-ascii?Q?xweCljaYrGRiSWkSumYgyGu7ACeekPNLybIi0AV+UGRDdZW1WGKhdmdIHrnA?=
 =?us-ascii?Q?znxzNBzKifjbpY4bBuRTVqlSyW4arcG0dRZLfh9Ipavm0PWuFh9zc8jUSO1j?=
 =?us-ascii?Q?5jD1WY8EIU1Bmauqctt5e+mEKC2rnDI7sShuV/1fpcbc2vidcZGhhe05bnfG?=
 =?us-ascii?Q?a/gIS6m8pfTG73gNpVjVYr42EucfNEnTaAIPR5qMMQP+gGQtMYOlmQXMPMEp?=
 =?us-ascii?Q?ofW/WJ+QAf46EAgEpv35Sn0LJZ6dF5e24k5wMpWBhzGkXQqDkJhNs+Tovi56?=
 =?us-ascii?Q?WFO7sMY0pPkO/Tvit9RSaojN3NlsizGwp3tr6dEQ64VIy+uGfyrQ5+TRYg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 09:59:27.7456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95427dac-a203-43a5-e2f0-08ddc9067222
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7976

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


