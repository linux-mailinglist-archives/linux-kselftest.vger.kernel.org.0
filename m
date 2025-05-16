Return-Path: <linux-kselftest+bounces-33146-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A712AB92F9
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 02:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57D32A05E4D
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 00:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A666FC5;
	Fri, 16 May 2025 00:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ZDHIlE62"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFFB2629C;
	Fri, 16 May 2025 00:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747353745; cv=fail; b=NcvTckcbQPpODHohpV33ciG6s0DQuSk+f9+18zaDAw5CJhAaGbn7x5QSSc9BBnL1z0ZydSOFnrMyWd+jr3qI1hjQBauV65zvDbZwt7nb4j1yKMTw+m5znsUzblABTufp0czAXJkv+5XPvza1Fxid3imxfpuRS3w0DAXOXLPPU/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747353745; c=relaxed/simple;
	bh=UvrjHyQvwMMKu+ydQjeNNzpfw0jebxZNRAg6Yv+RsUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KphCBOoQfrSdlvIOwNrLnx7dUskg2NoCr+fohC+tnPvSCqmcZn2OCnqO6vwsqwPLyR7maMyAZPEAbUsmbzls1NLCinuKi0Bay7c6JUnEpSHwskA4Xr+P6SpGNZIHrgichTrdQ25yU0seDbb9JIM3ASPBjd/qR6U353+GCPMNqoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ZDHIlE62; arc=fail smtp.client-ip=40.107.20.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldCzLX6HOt7zUwe31IyX/eMhNEHNXy+eurGxZd+bPTPmnIFktbgGDhsGuvo02X72izknRE8p19GLEUutRtrkpxb5zHaUxeLrCUxL10EBJcXUupyVXhB6cjGr/Urk3cbJPcgtiFlpeN5NqshTMD6gVW3CBiCSJJdWj2w+RNeN6yq4muwOzps15Eb8gejb4aDiYylTB514/IwuvUdeQN66ntJcTkBe+mkuyrQ+qK5fIJk/wLcZhTodWO5BiFcAR8xjI0FcJR9OFkuyetabw9qgMVlTy/TO7weEqDEcQhirxlrmYoaWUuJAFl9YILfm1m4xS4CwS13QDOnJNNd0qpgDvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgG50skLVY3aVDgCGcIqWujSRWT/aldkRftaCV+XMwA=;
 b=ZslRHnfILwjSoLzF++A8I4+i4HvSb/4DNRlkq4ZEuR9EIspc5xJMOv0l/K2H4c7x+z9U4i0N/I0pa9mlN6HqRhpuZxA47Af75GZhD994eBGh2Gw4D81X9+1ToD5+0hV7MdpbMtKXoSTKg6K9MAhLkDFFy9CuvtH0Fnrb7fy4JWASTpi+P7tmKwjjae/MOuhudkiPQh1YWt72jkcjYu2PD0ssnRKWvS92rxfM2zPwCYv1lCDvB+09FVmvh8W4p1w1r3gGOrnpj/Ehft/ErFXJSVrPh7SU+WeqNPMHM1KiVQLtwBS/XhGmbxkkwJ/oTsBnex/wktYw3Zuji+WL7YmjkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgG50skLVY3aVDgCGcIqWujSRWT/aldkRftaCV+XMwA=;
 b=ZDHIlE622Fps1TcCp/NrSYCKmEncbOs+qsEkWepPL3sFFjn+oWnf2kY3xmk/PmFQEt63vbUl52oXZcVZVZNlkBrREbP2Vdq6udsLDEZHaKOkBmhJYxj/pgZm6yQDE+aLlQ4qgs+bcJSeI4tayPt17mh31vcqUNEvTT2JaSGZXIeh9ElO2MC7sYX+xI+2rpNYvoGf7tD+PX7kyykJddQnNx57oVCE0rNHkgVHYnYgdnPkz1Hmhjhy0hl5bkT9C4oZEDu63SITTharpmQYngZyYG8rOhNGfmAk8nVvkibKX1Wv915ac+0G03Vk1/k6ldX6DFcX8FO2M2r/0oCStSJRbQ==
Received: from DU2PR04CA0344.eurprd04.prod.outlook.com (2603:10a6:10:2b4::17)
 by DB8PR07MB6474.eurprd07.prod.outlook.com (2603:10a6:10:13f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Fri, 16 May
 2025 00:02:17 +0000
Received: from DB1PEPF00050A01.eurprd03.prod.outlook.com
 (2603:10a6:10:2b4:cafe::fe) by DU2PR04CA0344.outlook.office365.com
 (2603:10a6:10:2b4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.17 via Frontend Transport; Fri,
 16 May 2025 00:02:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB1PEPF00050A01.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Fri, 16 May 2025 00:02:17 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 1DED6200D3;
	Fri, 16 May 2025 03:02:16 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: horms@kernel.org,
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
Subject: [PATCH v16 net-next 4/5] selftests/tc-testing: Add selftests for qdisc DualPI2
Date: Fri, 16 May 2025 02:02:00 +0200
Message-Id: <20250516000201.18008-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250516000201.18008-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250516000201.18008-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A01:EE_|DB8PR07MB6474:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ef4c41e3-4322-4a95-1cb7-08dd940cec03
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?1x+LLyhEVavkPoLM6GcpqmDc+ibsh1oDPrXpeYrqzDXN3ZIBn309zbKqFl6F?=
 =?us-ascii?Q?Rl0RVzy1dUeYYzYdBlh0kFfALqX66L48LrQsNIZRFjO3Unb46dUOTRxJqHU4?=
 =?us-ascii?Q?ZcIs0XmvDEmPrCfAEH3quDwquSFdNUkHm/WU89Igxh1AdCPh92XW/zpniGSp?=
 =?us-ascii?Q?Iikw/m7Ko90VeOUd4Wu6nkb/oj+4es1NOrrCH8RYPYPqkO330X0hvr9x00wA?=
 =?us-ascii?Q?l3v+452enlm2wmSncvnpJALmXf0/4Wnww+z7wrKb4pH2ZoyBc9HNTZo2DR9b?=
 =?us-ascii?Q?iX8/RooGW4LFkHWrgbLfQhObepHuj8xlH6o3ushsYyhtET/I1kM0aZqF2kcg?=
 =?us-ascii?Q?bmhKki3Ya8t21TyUwf+ITYD8Pmor37KP05DK5sAO8JbhxYi6HzlISzAdMf3t?=
 =?us-ascii?Q?I0dhCk6cqBqB3cc71CG0DrK9sXBp4sVQeSx6neiI8BqDgAV5Oz3bYkMMQrOe?=
 =?us-ascii?Q?jcW8i2fy4ci2CvDg2TL3vE3qqCK+RdzV0NBOFQrUIrZYBoMJSROc+pFHEOEO?=
 =?us-ascii?Q?1m1YDQ9zVUz6w8sbG1epJbBHTZx+fscvIUCTYEIQ9QQMiCADtX5Lz358UkQ6?=
 =?us-ascii?Q?sjlopPDum0+V4MyZAK77MxN9RLJk4ozYPwPlpE2jbw4fz//z21UOs8UD5IMW?=
 =?us-ascii?Q?Vy96+aFxABbBO+pcAVMme1jHtL7lkyjqjl6xluakZ6JQdJ9AGnMuM7baCUmX?=
 =?us-ascii?Q?+yG0odXQCWS0M7wowyP7JVXRMKmGQDE1UAzQQ5l0O52JduQjCgJrqBWW/Rc3?=
 =?us-ascii?Q?o4eZfT72ftAonY2eFyFqfI5I8vtGIOelMPn9XMOSdT8bjkEsWPOcd++RrG+P?=
 =?us-ascii?Q?SI2CXsKDkk6aK7xLd8FkKpFq2mBiYJcHArLUHtb+MLgK9lZlMgXKPrP84XD0?=
 =?us-ascii?Q?HxDJOPY9NMbQgPz0oCLWGXAMIKh+Fqabfv3Sr6fbRMYmaePAqBkuvD2nlPcW?=
 =?us-ascii?Q?+Fq4hFatUoYOeKnloECrmeN/c4CBumyBpKwQzS7wh4bD5Tlv7FVlyrn2kOsK?=
 =?us-ascii?Q?DKRdPQ8G7BKcv1PUe/ettK7CZHh+3N6oOvy5yrorBoO3SiI2vlWLefx/PwcR?=
 =?us-ascii?Q?pDAF+W8UGHgO9A8GfY7uQGAarfnTwYUZjYfnwYMWB1BDM2tuzN0A8SZvfP3F?=
 =?us-ascii?Q?b/6U1jqyNL0MvmS6TogCaVF8cMoiyUln0eICaGuKXUdIt+Efh4V+NdPzfabt?=
 =?us-ascii?Q?VVKtOIR6/9bOlLfdjcZx1zMkQuEZB6n2+p3fVqw9uzl2vBp6vkdLlJvSfphf?=
 =?us-ascii?Q?rvBgV3J6fE7uQAtZjrmFIYnj3hSzseflVBknUOQ1C9o3GWrgfB5ByV72uz2F?=
 =?us-ascii?Q?HC0W6jTaByoNJ9lBW2oLRFemZKF6vueAa8fSlxwU6FJd4j3sAe2xa84G9Z5s?=
 =?us-ascii?Q?YD8rvD7YfLyCiknTJqR2ct1Ps+puzW4+Ka0VZ+BbsQZxikB1vcSEsQcHXfyM?=
 =?us-ascii?Q?j2HCzRMY61gqdrQ7bAiMK+OqEXRnQhwlEYTUn3PuCEUGQ7M3EmIXiqZ/nwfU?=
 =?us-ascii?Q?SDcryI+PMXiScuL4Z4vG74bsq+Q4HKSwDo5pZ3NyFE6+i7bpE5uMESGdhA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 00:02:17.5579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4c41e3-4322-4a95-1cb7-08dd940cec03
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00050A01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6474

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Update configuration of tc-tests and preload DualPI2 module for self-tests,
and add folloiwng self-test cases for DualPI2:

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
  Test b4f6: Create DualPI2 with packet coupling_factor
  Test 37f1: Create DualPI2 with packet classic_protection

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


