Return-Path: <linux-kselftest+bounces-31718-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3A7A9DC84
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 19:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03FE174AB3
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 17:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD21225DAEC;
	Sat, 26 Apr 2025 17:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="TYOmoSA/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012040.outbound.protection.outlook.com [52.101.66.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B885225D8FC;
	Sat, 26 Apr 2025 17:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745688052; cv=fail; b=S2fMVHQDvYeBYAA9IzVOhewXh0xowAhzw+KcDiYmFQHvqefXi7CR9x4J/RzQnWBEVQjUIW42i/xBVlSxolVHDUOFOk9cEzIa5TbvG3DTelxqfV00DasYtRW806mkK/0qjbSOI82xTntlRdn2i8n1xQvKL5E750z7VGjUNCg08Kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745688052; c=relaxed/simple;
	bh=JV97YlYT/A0U4Xl0ID0GejxaJGnhYdflpuZXFVDaPxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s8MZ0XkXP7HfEYspGyFuDl6+J3Gh/VTOyvW7nUsJTvDe+wv+95ScC1c/fH19dk7jlKJlQRaCZTwLNAAjrfCThf2NShWmIlhuYPNg++wuGaC0JwhrgVY9+cLmECxCcLqyrEDgYPKHpTIuZKCtjNnpiZw8SuGAnZPuNNH7ltiBNik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=TYOmoSA/; arc=fail smtp.client-ip=52.101.66.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=plDx7OcvEuSgDTIzBf3wkKQ1fVnWxpZ4/FpDaxCTxYSwugfZ5Zk7KrgAjF9C/hc+51LVdtB99qrSK1aMmq+81dJt3vuxaPKGKjb82YBWyw/dVdre/zbIdV/DJElbKQ6jSAA4hX4oRYxacyJJpVATrNXMSpvhbvvzpAfSvaLgatLPtSZj0zx78JOllQmSCwAWfsPeSicBRSQe+3Z2BGelmqdRlj3XN03DpUWopLL4LM03zPn3DLiO5Vjfw0LMLc7uUccKHuegb22RlqWojXAd4g/Y9fzBqUjMLW01AofgwmJTBAanncS5pGok23yk2sBtCEUYd84qMEtC9Usj7SKZ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ANqb6t6uoHVOZ5jnsNXG8qE/ft8UIKeqHiAfKShfJE=;
 b=Mro9DZ7/6LMM1GclJL7skLcRO/d+o57kOAnr9JCFxxdJaAyO9WXa3Jrrn6ZdgvyZZwTychrtzmle6eYbHDyVC89XosVlJgN+44d031ZWyXQgLxgUmLvTZB1vlPcja0DGvAx//U4s2hUC/BvdsQAoe9M8Lqv+qJT+PzXJuO2cVxwfDntGunAFzQ62bzuXaCQ5h1A/rhlxEWSByrIXD2u9ESRI4eHh2ugeWlg1A+NCRP9ysXuOewjW/yTGZxCSFQbmE9GdXg4j3jHRlbGaxD33LMxAMbTbNJCYPFga0vglvqC/c7dQwomSXaOmkf4UvxUd3/8RCbJCFbuNzEv5EDSp+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ANqb6t6uoHVOZ5jnsNXG8qE/ft8UIKeqHiAfKShfJE=;
 b=TYOmoSA/DNFLA1GlOKz8zyAqwztVQDXz7r+0NOnJRiXvGqZIfm4FXD1oO2biumrJf8qMcKigDH2MhLH1y75zoXv2rVsegnk1C1LCC3T8JkpvETHC7fCraLxnTUtekY6sosEzJQGhQ7KDIvueSQhlsxmhnwkqoDkAYWAmhN90QOgOtf8Xu4yDxbDssfliGzqpSuCbyobtP0I9VT/8hWLTmJWCZnzpU9DU1dzB0ABv92haWzZx7rtq/Bv3fw1Dv2/Kfz3o4biL3Prj8L+yTQ2Bboa9L1p6RBed5DmtgqKn+wnsrV6zmGoPrOW8j2JWG2DvDj0MGrBTrpvVYKZsGZcfRQ==
Received: from PAZP264CA0056.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fd::9)
 by AM7PR07MB6914.eurprd07.prod.outlook.com (2603:10a6:20b:1c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.28; Sat, 26 Apr
 2025 17:20:45 +0000
Received: from AM4PEPF00027A67.eurprd04.prod.outlook.com
 (2603:10a6:102:1fd:cafe::e1) by PAZP264CA0056.outlook.office365.com
 (2603:10a6:102:1fd::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Sat,
 26 Apr 2025 17:20:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM4PEPF00027A67.mail.protection.outlook.com (10.167.16.84) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Sat, 26 Apr 2025 17:20:45 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 066262004E;
	Sat, 26 Apr 2025 20:20:43 +0300 (EEST)
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
Subject: [PATCH v13 net-next 2/5] selftests/tc-testing: Add selftests for qdisc DualPI2
Date: Sat, 26 Apr 2025 19:20:22 +0200
Message-Id: <20250426172025.9459-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250426172025.9459-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250426172025.9459-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A67:EE_|AM7PR07MB6914:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0f59c267-2771-432c-bf23-08dd84e6ae1a
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?L3+e3G4h6Z1wM9z9ub1uoxaR4PDprr0SAbAs+R3qe09KYSXawUol1CZOMn6r?=
 =?us-ascii?Q?1WCNBM7nJv+mHzhMKAsoxlFdVwF/DzCwPiB/4uNssWIZUCvNGa3Ut4kB08iV?=
 =?us-ascii?Q?BjMhLyjK9aBV0+lEjyI4jJJwTJfbD4vcsSshsRD0NvE50u1EXWXD+h2yXjQ+?=
 =?us-ascii?Q?XxpIze1BIacZa2NuIOefjX0qZAy7btCn+8hfTeFOVHfPYPjAUysYnSoehatd?=
 =?us-ascii?Q?5KeuUdDTZiq4yEXOOqK/n88YkxR9FuCOI05wGVb3/IyGS4/4nnFlAGE9I5Gy?=
 =?us-ascii?Q?2pwyEWkHIvr6nTU9dnOkcLqieyYH19+5D+rdldywaHqYtzOWhPvtBosUydn4?=
 =?us-ascii?Q?RI4+rAjkCAcz3hp7gKdwSra0tpsC7XdGJIR6n+A1GnWRNnRIY7zSj8BSMgUa?=
 =?us-ascii?Q?72nJkrUgsXibY+CCe/31oNc4V3fqdwEpJYZOTiAAIqO7HeWghw1LJqw5XPE7?=
 =?us-ascii?Q?bioEriwrI9Sirnj08Q/xwuWNoEIg25STA8hsXbbcOGUYaolynznToIcaJaKg?=
 =?us-ascii?Q?0yERSidgOxoLxxxa6S5+MSoMsAFihi5gG4mw+CFGzYooaV8mCiOgDTKzXl+K?=
 =?us-ascii?Q?58O7SGnyv+x+zrUsGCWGrbrhrDKN4n1DWZk4FOlODsniE+rpHd5YxbQ7z4vI?=
 =?us-ascii?Q?CvEPzTvMtNOO7yKgHpSdk+s1gH8Pr9IaXs8K+3a2fgMJuj91ZCR8fX6+W3n7?=
 =?us-ascii?Q?Q4EAhv+nomwEFBD82oZbjny0Fay5lEfIKfwfKOWctbw3dQkDx6pqkBc44X9r?=
 =?us-ascii?Q?qFZteBJI7W27j+S3jgEr9unuAckcnJKfE6N8/j2+dHBgO5gGxvFhuXHROZqV?=
 =?us-ascii?Q?N33xAwE2+P8hIEiji18txjic0zb4wFYdHH+ceuRG9dSLriPD/rDql9bzMlLi?=
 =?us-ascii?Q?epZUbGSYk35D+Hhh4M/Vw9ib0euu2ijmOZ7pyfWJFXssyQKznx6uxf4UHGy9?=
 =?us-ascii?Q?pHXmKBQJFUqLEi6ZcGeXKcy68y3/+aY/X5kwZdD78gNXXjMbn/v81K5SWbrl?=
 =?us-ascii?Q?1AMrpsut1xg6+pbXalQhlFn8E0LrN6ex2OC0EPelQ2RBIur/dF3IJfpVmSUI?=
 =?us-ascii?Q?tidivm5nyp2iKW58mbg/DKlyCvO0PFeJSB0n4Nn7ckFxSBnjyVCJ8rA4FWNd?=
 =?us-ascii?Q?UZXS3iMZuvqv0KxtwXkMEFP6mG3qO0sF5wy5v25QUjtvbI4qqJC4Bv2w32Mx?=
 =?us-ascii?Q?X3KDYSaNDaL+zTHIUsNNJ/McPCkWDW4ao8Dl10ttpegn/RLj47YNtVQPNjic?=
 =?us-ascii?Q?HyF77HPqd4Q+gM2G4yiUX9/4YLpgR/uakj1fr7IvRxuZnzPbRpoE/9AaHnKQ?=
 =?us-ascii?Q?hE8xBbzZMVA3YH6lDdzlHFVYh9coWpGHKdWeJwJ/RTceSxRjTaAmSxxlXNmV?=
 =?us-ascii?Q?Gdr+07kF34BkjnNKTKMaGCv0ooWd+2L6D36GgWHWN8ft+2m4xo9ZoX78NmkV?=
 =?us-ascii?Q?5u4YyaSEMJlvWLWEUsmOfFU3/socj9ZuUu4j8eo5m3G8t5fj87p/uQk3CGf8?=
 =?us-ascii?Q?z/at4kNWoyNnMC0cp24qVQKwnJ+yHBWYAri/nOVEnwa48UyGxxc7x8IzaA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 17:20:45.3873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f59c267-2771-432c-bf23-08dd84e6ae1a
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A67.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6914

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
index 000000000000..b2f14e934b7f
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
+        "matchPattern": "qdisc dualpi2 1: root refcnt [0-9]+ limit 10000p.* l4s_ect coupling_factor 2 drop_on_overload step_thresh 1ms min_qlen_step 0p drop_dequeue split_gso classic_protection 10%",
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


