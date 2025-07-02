Return-Path: <linux-kselftest+bounces-36253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6883DAF0938
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 05:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAAE74436E8
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 03:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC431E834B;
	Wed,  2 Jul 2025 03:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="rUiyDmL4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012071.outbound.protection.outlook.com [52.101.66.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A99D1DACB1;
	Wed,  2 Jul 2025 03:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751426917; cv=fail; b=pOkcgqf1rK8jmZWXXgVd6dElPENq70hPog8bK2rbhZTnsTk0NPC+otbHZ5/18p+rYwBrdRZ5kANNS+VWYqW66O+7pLBXTTvyt8PlA10S8q3KKTVSYAEErjowkESqI4V0wxlZ7Rj5UWzfiWhiFaaMk1mFNFGpc6ec55ncdHwHsIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751426917; c=relaxed/simple;
	bh=pzpl0CY/R+nN+DG2BeIfM76DFjYBParwq9vZA1VApd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aYtCtvArr2t771j39vQRNGLe3WBXaKUF9/HDvNkfaKT64o7ituvl7iTJd86ueu7QN6LqJUT9LZU/dipuyPfMtxw/WhWQN8H46f/timXJEdr1Xm/6bp/DY7p34b4ZCS95XLYNYZ7QqT72sGDZtCWQeg4nTCarwDihNqJHhm4OHV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=rUiyDmL4; arc=fail smtp.client-ip=52.101.66.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNf0+9lFd8RiO12wVPQqzuMI/PNesULn/vyH0cjjMXaEXtaKi/WYHcJR/SR03qJGp2znAE20woYRPn1yl9aOKbssGXgjcNpYq+sKOTE4BMu+i2BZu7icGC72WUGzo/F2CRNon9wCJaGJvYEkZjE9w817wSQ78P1+51mSpvn7PlA1mg39j1siZZgsBF3mIRcvBH34UGzgh7IkYaisO8U8g1UP7TfoE1qMBH4ns6adnu37BP9sfN5rhvO0ppr5qv3A7/0Zjg4qMM+OgG26i64RmPb+YPV9dCbDhDUJscoR9XEmwv6DepuP+uu9alMD7IIahMNX06uqqSEk+JJ+NEBJvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kZd+xMYmqRJgREmehQiqgrPjnCizDW5fT+4INzI58c=;
 b=A+oWnyKnKmO7UuRMQwAVzpcK/iHX7OrFWX82FrmBCu/Mm39CDBNaH/mUIVRLKaxH/HoKxXktskM7WK1PZYCIj2cYRVfOy2DopJTL0LRFevLU7TLZgdVlLN3GDvV3hveEFZI/gulJPEi/p/uZlOXlHB0QNE4lMtT1kfIl/x9S356j7v/Ndmi9DTk/wxJnS8SlRHB1oA4OVfEnK0SV70MKTCP1gZlxHZI4A6uRuqQEIzwV3OhiuDgK/5km7aw40Ra6AN4bl2me9JO2gZc65B2tzuOkXlLcgEHJeJ8LZKJcZhCwTrfPmZuky50EAnzKtJQMjaHivqSxpY/g03aJqilWOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.240) smtp.rcpttodomain=apple.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kZd+xMYmqRJgREmehQiqgrPjnCizDW5fT+4INzI58c=;
 b=rUiyDmL4sY6ps7uUNyoysiex+Z82WJy0Mfc2MNXYFGbotx7tjkegCyPYLjmAVRCTwynZ8M0/GzRgLgXwENwTXBQhscWgsS96+PnRjBYXoLp0OKWEz8LCMm6bYoccj2HqT+L8EWraWOZO2QEdlrxHIgTaFlXC7Wrmnvo8hn3k4sPE6ToAwSq7UeJBIhsDnE9Tz4zHwU6GvRcLYBJlzlNg5BDeCpBYvrHR4CBBrBVRuy8XiuiqdyvKX4ZsAixXEhLWHD8ceDfzP994x4kK3IwQPkMZZ8Ch3+mNC9mTgCd9aeEMrH541XDN2gG5M8XndZ+cMbrUX9+5o0xJbsUBj8xyqw==
Received: from AM9P250CA0018.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:21c::23)
 by AS8PR07MB7143.eurprd07.prod.outlook.com (2603:10a6:20b:255::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 03:28:31 +0000
Received: from AMS0EPF0000019C.eurprd05.prod.outlook.com
 (2603:10a6:20b:21c:cafe::cf) by AM9P250CA0018.outlook.office365.com
 (2603:10a6:20b:21c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Wed,
 2 Jul 2025 03:28:31 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.240) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AMS0EPF0000019C.mail.protection.outlook.com (10.167.16.248) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.14
 via Frontend Transport; Wed, 2 Jul 2025 03:28:29 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 35DA6200B6;
	Wed,  2 Jul 2025 06:28:28 +0300 (EEST)
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
Subject: [PATCH v21 net-next 5/6] selftests/tc-testing: Add selftests for qdisc DualPI2
Date: Wed,  2 Jul 2025 05:28:16 +0200
Message-Id: <20250702032817.13274-6-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250702032817.13274-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250702032817.13274-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019C:EE_|AS8PR07MB7143:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 22f6a3ab-032f-4a95-ccdb-08ddb91883bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tWZiECFEhtBToqne6QnGl6ghrtOzCzYchGG+qP2agnuTfQu91vSVzIShSoOR?=
 =?us-ascii?Q?/JBt2yde8zfFTwtHIvM8JJlI/Hb6GmJPcgZVvhpH3W0Do6T5dLns6t3dD7Hj?=
 =?us-ascii?Q?Ti25+s9qna2TWA05YDzKLUZj9Qc33mxDAnehdhaxYFYuelZgM74hmkmaZ8MU?=
 =?us-ascii?Q?0oEZ2CbVlNTJzr7hvr+wG5G7xTlnDrfu1tzREmNB+v+LbaDlVtfsoVAM7yEd?=
 =?us-ascii?Q?+/CtRcBDG9Y+l6ZGG1NEYIJIJ2/aj/GfHPHC41JWYmnKqlt4SZkQetTlYALh?=
 =?us-ascii?Q?/IhKIN4iA+eALhc9y8fHN1Fhf/n+HDbAh+ePgoR34xQGDgFTmue1cgu2vzDj?=
 =?us-ascii?Q?p7hbi2dX6OwYaB4HjkSPfWg7zS+w4f7LvA/tvcaKZOe9yVfk5xW6Hq/bxH5z?=
 =?us-ascii?Q?VAFXYuxdC5l+84F2VtE0QIr/2BA2OctgPqaUAjL9Pn3/Bey1jX+zuMiwmUMP?=
 =?us-ascii?Q?M8+vtDfPAOfe9QG4B2pLnZhILpX7npdkP/xEuo5HKTboqKgckEXPG/8udxeX?=
 =?us-ascii?Q?rUDTGu7DDWkr4o19n3M+qP0ptns0/tehIx7UWmmaULG/0BBk9JlCmPvB2Le+?=
 =?us-ascii?Q?/fMnWI+p44eManWe/gMh+GoS7yHqEp9VMTxeNz05LSZrGPbVtTOBqKSuxlBM?=
 =?us-ascii?Q?2WU6SxL3+O6TQht218b4+OEQ9v/ZK9VPGJ93MEds7U9HbuUllROyR1m2+5Nv?=
 =?us-ascii?Q?OBaMGq+hnZ/Ak0MetvsVnFFfIRxc1x4oClszjZsHaw38K1G4KM2dux1nrLMd?=
 =?us-ascii?Q?Swd25WERHgUjosWrI56Qu5pEJd9sm4S3ImFX6EijP8N+3+3YRVQgcuNCFuW9?=
 =?us-ascii?Q?eq2cLRwyC4mksCdC3pw6FI7db/+pHPqKzQ3YOeVPbcKBu0u8Xrd8O5LQbqR1?=
 =?us-ascii?Q?MmgJzpHp6c45UXOtX5KEUTQaI3H/ehEUCKr4NjGQpnD9SI+yE8l4sVI46ILo?=
 =?us-ascii?Q?j6XvppNgmzN88nD98TgahvtUULQrDd8P3/meV/mhXzrWZl3hNw8QBljVMj1z?=
 =?us-ascii?Q?XbRVqXelS/Ose28Zy82LaUjM04TdgHTwa9BNY9vgDECQtcimnLy7h4BnjgCc?=
 =?us-ascii?Q?PLt5PQuKIcHh111SIQhugPnrQN93Vhwldecoc/BiQdV3Zo0j8IMvwV+yFxjp?=
 =?us-ascii?Q?2557DtTUGgDOWZKMBikTAy7RulykCfE8+VNvIbSt/4K6dVxlwv6gyMlVfNlp?=
 =?us-ascii?Q?9NK8IzEDNh+1YR2BFh74U0qyiUQ6mUrmyaV/FL6wGL9VURS+a0WoHKUULUTq?=
 =?us-ascii?Q?bBkvuv0m2fmSDNsjeyVrlyJifsk0m5YhsA83JzYMjL6dgCIN99hbLJww5u5V?=
 =?us-ascii?Q?B22BuDTYMBF6torq07Vj5vBzdPnYHs3wuDjtHyeGyAmGT2neJ4xn8xEIOGBr?=
 =?us-ascii?Q?sCWkKhQp4xftL9iCBc8hYNI4nD3h8CdUhWfsmMGi9zjbOy1UC/jRUYpoHeWV?=
 =?us-ascii?Q?wtrg7H9XILO0JFgj998fnpw8mav+R+9qId332OtyH0jzXb0/LrM9IY8bCsDK?=
 =?us-ascii?Q?W7cQN7NqgoiLNNWaCVbuiEys/LPu7XlVnNax5g7yQkxoL5+i1VxLmwrCgA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 03:28:29.6079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f6a3ab-032f-4a95-ccdb-08ddb91883bc
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7143

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
index db176fe7d0c3..72b5f36f6731 100644
--- a/tools/testing/selftests/tc-testing/config
+++ b/tools/testing/selftests/tc-testing/config
@@ -30,6 +30,7 @@ CONFIG_NET_SCH_CBS=m
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


