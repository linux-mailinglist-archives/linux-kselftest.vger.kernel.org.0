Return-Path: <linux-kselftest+bounces-31353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2410AA976A4
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 22:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B634D1787C5
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 20:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FA529A3E2;
	Tue, 22 Apr 2025 20:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="BDH28TTJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D02829A3CE;
	Tue, 22 Apr 2025 20:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745352981; cv=fail; b=fSED+qjbbw5PpRnrnfYVJS1b0Jxq9tJfKmEoksIAsTfPlHE0YSALIZJ2TEnMDoZBtYzhQ8MGUS56WWmnEjuFseq2D+5jgNL5DUYrYMIw5qQWZKj+qqrpIyf3WPRIsA0cPj+jXKxpLeCotWwuIX/EJsKA4OoqpRUNTcxvR35vm2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745352981; c=relaxed/simple;
	bh=VZgMI1y10ZVzF/3MeUylAlSR4ZOEC0ddARrj39wpx/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AWMQ7dk5k+k59lzVmUqJeVRObnEwLwboM17O01jpHvPkcRkJocZvUWsbghul05Z9XFTTpat7v30CfbAnFZUe0N2XAMq/rUqwzKUqYYPGFkpnXzeqaBOfPwskX4NkZx/H45YEgpO3d7iDcFPYVcBCKAkIUopS6eKdf0jWuASVAn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=BDH28TTJ; arc=fail smtp.client-ip=40.107.20.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCuN70dc4I5+3KwbIWzoGV0M5off81Z8XBzAv9RiJn4XiiqoQlZ08Sq5ZVW49CU/PawWd/NPX/XbG58lS18KRwxCotaCkKKSNITAQNB7qRUeK6/PntivqfgWTxVE41ChKcH6QHwDCdLMs8ezbA533/WBJstWeOp/MScZ0FxVyxoaxM7z0CONnIeLmM0yPDvImn+H5IXCIn+r38UapwsbXlr9Pjh1gpBkZe0dG0VHCNs4jZmFOHLo5B6/jDsPov0Ni+JrkiCb+Ov+4naaHhxQDDVbhuaYXYlbNcmnB4jk1sCteriHnOZEomUmpmFw1g1q1MVO+0it8WiIZj7yU6r4fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2D5UsmPw9psFHaj2XdKAgmCDcGYqhOrougPnEqggbxo=;
 b=arBrmQnUJ9+eApd7WWWRyFIvnteucezdsLzU5ifN18hfhKpOGcVlnO5ftreVn8UJv0SE6WIsGd9lNnt8qgmNVirWucPVptvg2B03c0jJ3i7pix59370n8xdHHMSuMJtt8/NZXQyUDgHGTSXtri5jCQkJqAux6jgs2BwnJ28G3+d7g0NSBbWctPI9vSMdVRFzIGHyCzrFLW3bLm+VC50Webpo5llzXaftgZm//vWvDXkgIAwpzIcGNheSB67jJNnCcLvL92Jo8rtzs6eFldSQy/07O4MtdRr3TNPWJlvQqnNT/l2K9Z8lcueuyDtTkvMEwTyI6Y4f62gqpRZcNAIikg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.20) smtp.rcpttodomain=apple.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2D5UsmPw9psFHaj2XdKAgmCDcGYqhOrougPnEqggbxo=;
 b=BDH28TTJfz8+r6+X3dyplEWkmt8V+Z5BSOdJSSIL/6rSfkQhEcSsmtlKRaLhgG/VFIUTBg4bXhU9O3+WXX2mHcTNVjHHakCvmNuBO0NOhN6xz2Losxq/DcvWcYQ9md9cvIOaU/sYKKdzrYk3pD1sQEnEM1GCG/B07ww7Zi5UbxjZDgtZNwlJ4yIFfZwHYoMbcKwBhpek3m9S1ZObdy24bBaZYfo+AEGs64D6edQwb/DCxPzi7fmgK4gZW2qhS85i4u1o+HEtdo8hc058y96wv7ftwdAH7yN4y8GCNI3Ity8zHH+kqC5t3+4HBndgD1TepVBwkov7A2Ks/urHYx7TOg==
Received: from DUZPR01CA0194.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::19) by PA4PR07MB7341.eurprd07.prod.outlook.com
 (2603:10a6:102:fd::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 20:16:14 +0000
Received: from DB1PEPF000509F4.eurprd02.prod.outlook.com
 (2603:10a6:10:4b6:cafe::bf) by DUZPR01CA0194.outlook.office365.com
 (2603:10a6:10:4b6::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Tue,
 22 Apr 2025 20:16:11 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.20) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 DB1PEPF000509F4.mail.protection.outlook.com (10.167.242.150) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Tue, 22 Apr 2025 20:16:13 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id A0C102004B;
	Tue, 22 Apr 2025 23:16:11 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: xandfury@gmail.com,
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
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH v12 net-next 2/5] selftests/tc-testing: Add selftests for qdisc DualPI2
Date: Tue, 22 Apr 2025 22:15:59 +0200
Message-Id: <20250422201602.56368-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422201602.56368-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250422201602.56368-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F4:EE_|PA4PR07MB7341:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0f52ebdb-8242-4e26-5200-08dd81da876f
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?omHTZDU5Gk0KMl8Ddyp6bdtieg4jChJKLREmgMqGBhDJW5V9pmPZJbUZtMjf?=
 =?us-ascii?Q?kR08ITeJFfFKjmO8zpxMVLVFX/q1VFq+IaMKeA+GyObXNVIqKln6XmcRmg+X?=
 =?us-ascii?Q?xmg2ZDEHqW8lPcPqzfNlkiYHIlHPvIAr8jFCBIWS3gO+S3VcUrz39Lmk29O6?=
 =?us-ascii?Q?Kqgf2y8pKwAg6Dos/njSZA3C1nQm6VqWji1ZiDxxRzgV1nhcAhyu7s0IF1xX?=
 =?us-ascii?Q?bP5kCx9BvfUG+29NoIdkQYMCaDv+PHdkuBiSWejGwlPBDbJpxTOYBEG4mjkT?=
 =?us-ascii?Q?BCAI11G3wk4Vp5Ty5HTPkq9aS/ElOSG3yi74QaA67IP/4R4NlYIOhQSyNEOS?=
 =?us-ascii?Q?yNav1AdhxhUAqLmawPqnXTiDpTkNpB5nPkB5Afd+0RU5k/wROlGLcUFjpyJx?=
 =?us-ascii?Q?EkGyEGBSMa5+c5ofW/FIqfhZyf+rwnhSoJL7WS4AxRVppNwmOKqkkgHBBDZV?=
 =?us-ascii?Q?j3fZ9wUl+3MSTWeYlwiLKWAqc4awobzYHJzArap/TavanUv3og7WjX4DBx2T?=
 =?us-ascii?Q?Wxiczf9hdCz+ff2bk9dqg6mXLn1aQFApLdtN4Jj+qP+0G8h+hoM/ny5Jfqwt?=
 =?us-ascii?Q?zSYQMVbCMphQey9pL6NhzlCGZogM9GoaNf8cwgdEyxkMgLrNxtWXHZ5TF6pu?=
 =?us-ascii?Q?qFARvMOrQbJMYyIQvHVWEIiBhToq6E4qY8hfgmEhZEaWT9dYe5vxreYVBFf4?=
 =?us-ascii?Q?0aYHVCRsJCzyTTT5WHuqAmRULLf7puZgW3DLG+D6AKXDmo1FBUbO/vDjtqmZ?=
 =?us-ascii?Q?2iWYS8SfY7/YxW0/oEG5MlcMaAM8YLAVe0xVk/D4aBvPMp3Tep7YDYPEmmax?=
 =?us-ascii?Q?fpCEvDQErKBCwcIxydz02f6r/J/vccSYQ3a5W76ikPSWA2/nG62+Uh+143UY?=
 =?us-ascii?Q?d3TS3GYtS4ScF9VkXYMtd5aE35G5npvRSpO6B/seqA2Oc2WHnFksWsGttjGj?=
 =?us-ascii?Q?EzHq7fX4bvU01Ow5LK2ZWgoHTuTc4aZgOn0cx4YsZCUJ1sYuHeKk3rhcrNqC?=
 =?us-ascii?Q?r2DXbVppCvpWO6JzdgAU2jVgQYW9w/suOSWZaaUipYmTDmIQxliZSLJ4BrUf?=
 =?us-ascii?Q?WnIlbJPqjYE8PIch6/97NH1+kiEFg+uBZgs5cIwuQZV16Q3PEVBjZk6mZ6RJ?=
 =?us-ascii?Q?xqjWd0CMMLQv0dFmAtjvOnj06SvzfJMknT6sDxXbNcfggLSfdWbdVcnTA5y1?=
 =?us-ascii?Q?tBYm0CHAkZDTgJOkV61jpkZiCp1NG4/LI2AfVgJ67frCXmcaaQub2pXKihBp?=
 =?us-ascii?Q?sGbl7AHOpC8y5zqWIYXOzLL+A8BkppRoHzkDv0TvOPb3bMxxoR46eb8k38Lm?=
 =?us-ascii?Q?aliq0K0I5s0tmi2syrd9rvZl6mNJBXOMHjW5qmZ9vm9NfBnl84SmZjZHKcDL?=
 =?us-ascii?Q?S70IcvVuMDKeKd36bHlK9xesCL6zpP3mIoPQ7ZprKEjAOW4s6tNtl6iWxfjh?=
 =?us-ascii?Q?oidWn2lv5HefdZTx6PUM+zg+xy1Yec5J8OAXg4nhm1k8jUVWAXDE6uhjYoqu?=
 =?us-ascii?Q?cxuoNYhjY9QzAzmIruYRJ/P4WSxvOQx1Zqyz6jZiR2f18AuMGo1rvKEfQg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 20:16:13.0516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f52ebdb-8242-4e26-5200-08dd81da876f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7341

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Update configuration of tc-tests and preload DualPI2 module for self-tests,
and add folloiwng self-test cases for DualPI2:

  Test a4c7: Create DualPI2 with default setting
  Test 2130: Create DualPI2 with typical_rtt and max_rtt
  Test 90c1: Create DualPI2 with max_rtt
  Test 7b3c: Create DualPI2 with any_ect option
  Test 49a3: Create DualPI2 with overflow option
  Test d0a1: Create DualPI2 with drop_enqueue option
  Test f051: Create DualPI2 with no_split_gso option

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
---
 tools/testing/selftests/tc-testing/config     |   1 +
 .../tc-testing/tc-tests/qdiscs/dualpi2.json   | 149 ++++++++++++++++++
 tools/testing/selftests/tc-testing/tdc.sh     |   1 +
 3 files changed, 151 insertions(+)
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
index 000000000000..1080074f2650
--- /dev/null
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json
@@ -0,0 +1,149 @@
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
+        "matchPattern": "qdisc dualpi2 1: root refcnt [0-9]+ limit 10000p.* l4s_ect.* drop_on_overload.* drop_dequeue.* split_gso.*",
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
+    }
+]
diff --git a/tools/testing/selftests/tc-testing/tdc.sh b/tools/testing/selftests/tc-testing/tdc.sh
index 589b18ed758a..2316bfdd0b4e 100755
--- a/tools/testing/selftests/tc-testing/tdc.sh
+++ b/tools/testing/selftests/tc-testing/tdc.sh
@@ -67,4 +67,5 @@ try_modprobe sch_hfsc
 try_modprobe sch_hhf
 try_modprobe sch_htb
 try_modprobe sch_teql
+try_modprobe sch_dualpi2
 ./tdc.py -J`nproc`
-- 
2.34.1


