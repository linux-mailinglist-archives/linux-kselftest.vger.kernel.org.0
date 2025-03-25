Return-Path: <linux-kselftest+bounces-29754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D46CA703D1
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 15:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37ECC3ABE3F
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 14:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C9925A341;
	Tue, 25 Mar 2025 14:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="MDlA7gnc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2060.outbound.protection.outlook.com [40.107.247.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A1125A2BB;
	Tue, 25 Mar 2025 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742912955; cv=fail; b=MO2u6UqUfTsaUUHDjJXJuQZhp0wjaGxzzoUHY+AZ9OfbFc9lT3epEsrpS5JewkQSymwWSNmQkZSMGWWt65t0JtlOzti83JzIaiav27wOb5WBpYbkBDCqqfTLws0m0yrEnte7YrPPqqWr3H0K90FR9rryeeKuZ4ZkcV2vrA6INYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742912955; c=relaxed/simple;
	bh=6NwKGOPJ8asxsqOZA0hgsCIQXbsdyUNcBRhPazaM7Fg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HXa4cHff3JIhHGJY6kwh66l2iuloe4o/0fczD851TyTfHq5tK2WFe2E/O5PfGsOMLlM+UmQcFNTkh0C/zNWYqmGdihj6/9A9rM5eIFfc9UJO6fCXH7moio558IMTsi0828pGmnEpISXyvv1C1MuSddrKFtWsTtJ3yoUXhVW8/VI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=MDlA7gnc; arc=fail smtp.client-ip=40.107.247.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktz3c4amLpEdAgn2v/Q0nZdFEH8MAb0ry6GlsYsvq+v5kYU5ZyukUkfRG2HRkzaIfxAgYcBImf9lMbmG4VsE1zCeWEYtLzkS+G/Ge6gQuHgbZ1VZfo9/CsEJqxUWBRBevWy/YDXbVFmGt1oL6jkqgFQtRuhXfSR4lDDy5WN3StpF33rKLl84aWWc9jHA98ALWeZUV1X8GCIcu9+9CXIlZnR769iTJvjO3QNYlsXsrPaLyv4wvpZixl3Wy8LaNu8xAi6QJ7Rx0aoFhnh6U0E+ILw9ivI1PXCtM5vxfvZU0x7D947bkZ3xaB4jM1urh0VTxHspgG4WScLsFmyPgraBpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmxEfDSqhYSMcPij2RNNEIX0ObyhqtzoghHADLcJBEU=;
 b=sBxazabVl4LSqARQ9cwtyAeJ2nMbgZ3QYrO7yP7svddvoa1DEqnSDW5z2cBdnVwbI5bOYJWNwMofjt5g3E4QaRs7HIVp+jgI309YOKkogdunCJNv8bHfuRU3lOhhg40KXgzKaYqKHuj1CS9B9BjTyHeUiiaCogk2W0f+Mbpc6lAxbVzD2E54qlRFHUf3afmBfyTMY41JcMM7ZnTag/vW3LMpn6KblFYi4LfsknuQdKOzWJfZVlF9XOL2UbwLkDse4GiM2S0M1p+71c+966UJ4ErFXuA37l6h51XaUUOlXdB8CJAqiGmmdDOUZ0XXgKQ4wIA+IshcXwPjY11r+Img7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.20) smtp.rcpttodomain=apple.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmxEfDSqhYSMcPij2RNNEIX0ObyhqtzoghHADLcJBEU=;
 b=MDlA7gnc+zQ5NuzVCrW++Z2xStZKfF/HFDdSgTH07h87QXCbq6Gnfy5MBvBW8N0Xrxfj4SXluRmdBB7mjUOlXaXDIHBp+ghH+WHdpHErCVsQo9YgvRtMvF4KyQfddpheUmMePJBrkvS4wYyLdCqJplEA9UzeLMLY/P4BtqESwEQXSsXVXXEujkLVzLIYryfkOZaezxkzXF8T7z82CWWAOybjyeczmzCkiNDidcg8Ddy0YcrwYKeeepZ+z26HoQqp6h0NplEU9x6hzqZQwocKVpVOp97a9nHU2DJAFl7ET0ZEVsl2kWBHkkFpSpmow4Z9f3gFPNFjxiNkiteI7HWphw==
Received: from DUZPR01CA0058.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::12) by AS2PR07MB9492.eurprd07.prod.outlook.com
 (2603:10a6:20b:644::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 25 Mar
 2025 14:29:10 +0000
Received: from DB5PEPF00014B8B.eurprd02.prod.outlook.com
 (2603:10a6:10:469:cafe::60) by DUZPR01CA0058.outlook.office365.com
 (2603:10a6:10:469::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 14:29:08 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.20) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 DB5PEPF00014B8B.mail.protection.outlook.com (10.167.8.199) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Tue, 25 Mar 2025 14:29:08 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 30360202D1;
	Tue, 25 Mar 2025 16:29:07 +0200 (EET)
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
Subject: [PATCH v10 net-next 2/5] selftests/tc-testing: Add selftests for qdisc DualPI2
Date: Tue, 25 Mar 2025 15:28:33 +0100
Message-Id: <20250325142836.47048-3-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8B:EE_|AS2PR07MB9492:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 17d4e237-7b41-4e2a-b6ed-08dd6ba9678b
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?KbVk+PQZLmozZIE7Whwg8c3/4ISwrAO2lPLnEIFPM96tUXn9iPYeHxKDEzLe?=
 =?us-ascii?Q?x0aERQMrasCxYbh6xIWY3QxrPKGmOVkARP06zEBUzMu94bPoE8Co/2AY761G?=
 =?us-ascii?Q?gRCCdgmP3xqjcTB0mzoQnCvMwN7C9B+Xo3Qp3CNbMeZmONrf4qBZMbozlzQf?=
 =?us-ascii?Q?edLhGg9M+Wyu6CpWf8Pbeb9tnYhIe/Oa24smuTJPz5XfoTWf2yQaIDQK8sbX?=
 =?us-ascii?Q?u2OKVAIgwwvznczLNln7JtGL84g7ZY7nsKqgoKzQ0sXXAaAIemVPnjE82bsb?=
 =?us-ascii?Q?wrWIgTVQr/AdOtyOd5NVwEbdLClKnR4s91WZoi+vFkzGoxTU0LjsenieT/Vr?=
 =?us-ascii?Q?tE3sOOBXbq/4yv5+NCPfH3KrImTNJBkOVngSNOQTNs0GxVM3hX/9rAg7ykK7?=
 =?us-ascii?Q?GF84+TkwjipgV7zRuZIDPfVOJd1gxFrUuTwsO6oa8pgYxBeTJOXNeYGVbJda?=
 =?us-ascii?Q?VCdtV5NnbWjouG+QbP+rVWyHOxrwZYQwHiG3GbUhrnriHnm+D01qsM/nB4rN?=
 =?us-ascii?Q?JlFXUt2v9j4xU++YR0yC+RZ6vkkSGzC/50EkGCXL2lHxpiqO2P8A7KkApNYL?=
 =?us-ascii?Q?ZoOvFTvnet6GZVSbGLCgDxkqBY3D20XZB2mY2Ou+5UYXFoJm1R6SmkCFTpak?=
 =?us-ascii?Q?K1j4Ga3f3Z6uiQPBQG6BV57myB2CtJ0t8Uht7DkKcK2bvIRSnrK/WeKtsmL0?=
 =?us-ascii?Q?md7HwXbSpYKKbR5uu/AEZbYChaagU1J8Ul4WLHcfMHeH0+zmbeX6/n1XfOOZ?=
 =?us-ascii?Q?EFUK3xqte2q0sbWoxmV1W2Amnru69LJAnMuUYunPHjo+Gv94OFXI0uhYIGkk?=
 =?us-ascii?Q?EFQg8fa+Lz1vuBKdSghAS4lt/97yBVHqfmNG/d0M1AqiktrRLC3JnZu/S3X0?=
 =?us-ascii?Q?4V7qGqya/L1Lc1w5EfXELtkATorFwGrdY18mA0KNNG7NE6vxUkuoC0U5bI0Q?=
 =?us-ascii?Q?ASLnBV+xLNiVmkVb5O1Lc95WD/KlggjLv2qq5Dij3FoYzL4leJEW8HMYEnse?=
 =?us-ascii?Q?qda1iadsBFERCJQfyMvg2KUOX9Ez1lBpe/oJBEziC6tGc4232MO+UEJ63Nx7?=
 =?us-ascii?Q?B4QoJDNgPuTazHZpjLvNrHRWgQnggguJLNhg6wotudAIPhwIFrC+cfxunXeR?=
 =?us-ascii?Q?h7oRYLgmfxmshF0RNgiIqBIEXUK6HM/gKBzCdxFPWhPXP7iP3unFaMfcBAkj?=
 =?us-ascii?Q?C73gN8/r1WEdVE/A8LxyX/JTN4uEk5XCzwNUk0l9wHYhaMdF/pBz03Lql8XW?=
 =?us-ascii?Q?abyGST+FnMFAshrVHh5QS8uHSRHh+zeKVCN3XPSkHoW+QILxeAvigHIJkUEH?=
 =?us-ascii?Q?9woGER6sQUWB6vDR7PujBFnniS73retuxCRpuevdjDKJJhoPV4ReQrVTHrab?=
 =?us-ascii?Q?hCYNh8Pm4q6F4dqUCNYqzFDi5Lh6Eh8in9hqyDKdch4q99jc7+GsD7vWrtsH?=
 =?us-ascii?Q?0V1newBYMhlO8JZTxi+wNjSEMf4khtBjDyooPhy+sfwHQct/CVhUWzb/X3uP?=
 =?us-ascii?Q?mmx41AjEWiKtsqh44Bm8GepnoNws4cjHVkDAkt6iaic+0wL2uNm8oi4vfQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 14:29:08.6239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d4e237-7b41-4e2a-b6ed-08dd6ba9678b
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B8B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9492

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Update configuration and preload DualPI2 module for self-tests, and
add the folloiwng self-tests for DualPI2:

  Test a4c7: Create DualPI2 with default setting
  Test 2130: Create DualPI2 with typical_rtt and max_rtt
  Test 90c1: Create DualPI2 with max_rtt
  Test 7b3c: Create DualPI2 with any_ect option
  Test 49a3: Create DualPI2 with overflow option
  Test d0a1: Create DualPI2 with drop_enqueue option
  Test f051: Create DualPI2 with no_split_gso option

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
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
index cddff1772e10..e64e8acb77ae 100755
--- a/tools/testing/selftests/tc-testing/tdc.sh
+++ b/tools/testing/selftests/tc-testing/tdc.sh
@@ -63,4 +63,5 @@ try_modprobe sch_hfsc
 try_modprobe sch_hhf
 try_modprobe sch_htb
 try_modprobe sch_teql
+try_modprobe sch_dualpi2
 ./tdc.py -J`nproc`
-- 
2.34.1


