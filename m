Return-Path: <linux-kselftest+bounces-29158-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE478A63640
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Mar 2025 16:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72CF97A2D52
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Mar 2025 15:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9185C1C84BE;
	Sun, 16 Mar 2025 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="pVhHSZvS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2044.outbound.protection.outlook.com [40.107.241.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A331AB6F1;
	Sun, 16 Mar 2025 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742138934; cv=fail; b=bwJxbzULx+ZRef/yTvkoLxja0pLi9vmRBNFsvlJuBo3I9skLk2fdm84f2UjKz+c5SVTHjzzJRKnFp6CQ11ezWD0ChQGROOV1cku3DKbtfOSObNc02h5uw0WRHXAooGE87iw5FrBlhKVETJdwna7gLoEn/r+ve0T+MpBAT6P2TMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742138934; c=relaxed/simple;
	bh=6NwKGOPJ8asxsqOZA0hgsCIQXbsdyUNcBRhPazaM7Fg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hP1Ha5kL6smApBdr3p8SNzytSv1q8hPj0TGlUnwdKxV01ZVhXelLPBTKZU9mLJwNvdLz3lHlY8e/BtloLd+GBy/ErTBktY/zXRHhc7tBPXFSY8aGAtRep1DeisObdFo1gyX6yDA46jUmJuHfgqia4AvdV86M8/OCt51YXSbwrcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=pVhHSZvS; arc=fail smtp.client-ip=40.107.241.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBKQp+EF9eyc1/zdB00wLHEf6chvDMSUX3IV/wfLg1p7l3unii8Wsjirn5mi2vdePUg5TE3vKxgS4Ng/Owr/43hLk7oFGd/8kkr8GBLVVZ5CsO+koMBmrLnUKh9aFkVsXLAVkMgaZNOJNlgJkVs4UZHJiWCEIWWVRCCzgXk7T9oo7Xzrhr9T50dDzUuUQtCiMzBubCXKMPGtPMoVXkd+hvcmKIvkK2FCcgxYTUXAj1Gsh+XIpDMQr5YQP0nB7h99fDc4p1zXUIxHbh460lcCCaSuShe3qW+06+aW0ZWjqEjEYMuIinWhtqE+3a3wDVQ1IqF/+sAPAnDcSp+cnXYJew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmxEfDSqhYSMcPij2RNNEIX0ObyhqtzoghHADLcJBEU=;
 b=y0BDsWrsQ7g+tPwdI3gtr9WfgZZ+gyPj5zJGOc/SHn1SMszMUNnKlDiUimJWccx/c42o8KtoWU8AVp77WnYykxwFFkfKO4r+TGNScVVr1WP6pNqwVbqx0LmMreVSMDJtEDxbuz4lLNQqcqxNOv7qfUP/5tRHdRM+1G1jO3ub8/l67SBr1hCtj0tvi4XYWbtEUGc6lxHrBBJK6i2Xn/ZswyteJnnT8pDo47FHcPtf5KmMrp9wY+kblPO/kCAoAqNMvxVHIZGtMxkYhIJF7+0YZZjE0s3CiTD4F0nVHj7gsgSQEFCnAiTI8aSNpmMhYVzYNABPU5IFULEgq9h+eoUhQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmxEfDSqhYSMcPij2RNNEIX0ObyhqtzoghHADLcJBEU=;
 b=pVhHSZvShJebrewOF6RvLy/D+XN0/4GQc4YllqboMKvOQ0gc/V3YS2fcID4bwE1Bbukcw3wG+Dx1zk05DJ7kamE+lS6WlFJI2R7YFt34Pd/ozh7UwjbW+aLmtGLUdBowXcwtMS9U/R/I2pL/g+TrquGETQi9rL/KsZVKpNwdPxN1jstbNASBEWDc+9NEhmE9jhuswJoj6r3VUuwBpl+CAT081NF8herg2pdPe+7Ha/pjax0mnamuLO3YSr1fay7fWdAEmTIdti1RIeZl0u9gQTHglbdRuP0uV3Leka2K0hKGv6I9NF/uZYNu1tnd2P9O+KPp17yPlsgPbLnIU8QiYA==
Received: from AU1P273CA0007.AREP273.PROD.OUTLOOK.COM (2603:1086:200:64::7) by
 DB9PR07MB8587.eurprd07.prod.outlook.com (2603:10a6:10:306::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.31; Sun, 16 Mar 2025 15:28:47 +0000
Received: from AM4PEPF00027A66.eurprd04.prod.outlook.com
 (2603:1086:200:64:cafe::84) by AU1P273CA0007.outlook.office365.com
 (2603:1086:200:64::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Sun,
 16 Mar 2025 15:28:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM4PEPF00027A66.mail.protection.outlook.com (10.167.16.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Sun, 16 Mar 2025 15:28:44 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 52GFRT2u000613;
	Sun, 16 Mar 2025 15:28:52 GMT
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
Subject: [PATCH v9 net-next 2/3] selftests/tc-testing: Add selftests for qdisc DualPI2
Date: Sun, 16 Mar 2025 16:27:16 +0100
Message-Id: <20250316152717.20848-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250316152717.20848-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250316152717.20848-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A66:EE_|DB9PR07MB8587:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 83472149-a17c-4f22-ac98-08dd649f3d99
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|36860700013|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?7At/xdX3JfQwR2n9zYDZm/uSJVPWwcmGQARIO99O0ZWIrWniKxoIQ+DfdsS7?=
 =?us-ascii?Q?NEommQCHdtXgZzxuYmy0Cbk5ygmjtJgVoozYw0TxS7BZpIsj2sywiwzUxX8s?=
 =?us-ascii?Q?bRwjTFoRaJ87oQls0sDKwxMz5EgClO70WibRAYfWGSjA9B0L0Sdd7sLQhm+s?=
 =?us-ascii?Q?+A2qWiiwUW7kZvnACb2zahkxw5Xv2ZmX+MaGfvtxnDVtAuXM7uT/+/ddDGPP?=
 =?us-ascii?Q?hdUIlqlhaOju1h9DgWNMb/P1P4S85OPCghmBBulu7HT6HZQkuEX94OltzNtm?=
 =?us-ascii?Q?EaVd8WVR7Em1Rv/HyfBvBaXOmPipjpnOEra3RjlApI/d5c5imEkrIKvnacAz?=
 =?us-ascii?Q?vzj+ykjos/kKcgYxGIHsb7XVv0kexdjJF7Nm3x+k1EgQ3bNDH7O6/iXzj3N/?=
 =?us-ascii?Q?nVVmATrdPYEr7R1S3GMW4o1isDeyz5pqVoT9unOGEfojbo4Ov2S5ya2//ww6?=
 =?us-ascii?Q?VJeeynCI/j1yMRphcuu72LMOz5Xd55tFbLcddBIZLlckHx69lpw/lUAwkafw?=
 =?us-ascii?Q?cq60jtfYdF5q3M1y43RuDk86560MxbJP8xY9mRx5AC/RHaMyRLJy4EuHzOpQ?=
 =?us-ascii?Q?4uh3LyfWdw/kbrsGTLipjLy+boUe+BhyVR8qvGc/SvI7hWQ6U34QhcnlS1WD?=
 =?us-ascii?Q?Y4kf56eR3evFWLTWivUP2Bazb3o/t8Yiw/SCZNcb3ARC7dO774XQfouycTNl?=
 =?us-ascii?Q?MdAOyH37L26tT9iOAdDr9gTGrAMZ3INaeI/ehdwlbavEu0q7RwS/swloe1OD?=
 =?us-ascii?Q?C6t425xjQ60Krxk9jVW3gRofaz/zri7t8m1IVbCc/ZrhsJaW44PGxcATNu+y?=
 =?us-ascii?Q?U1pQXJU1sTWX3KwnOvcf1XwYs/OxUQOsQwG/1g/q9bT4hGg83i7E8pmjH80a?=
 =?us-ascii?Q?80wMOu0dFJuIslStYKgBuUW65YF7GwghZDV763/GHvMgeaBBs/AzUVIObbr5?=
 =?us-ascii?Q?vKwYH1PiM7gUguPUFKYaLiH1gYa1VreIUfxOFObWYlc03gFmSaD6Lw/RDI4H?=
 =?us-ascii?Q?yT6ZWhTpGcwycd2/gWAt/ybkbrS1+YeCL/AvNnUquLjSUhqUgf8HfZFku7GT?=
 =?us-ascii?Q?x5Wy1waomIYty5h48tOuDyj4k/OIcZTghtY0MPEpu1NxrcJIs1ANGAjsJeYx?=
 =?us-ascii?Q?MLdyXxSlUr8dBqm8ib7kcrlhAR22QM2LT4wN1h6dpHkVEA+u+Nirmk7Ia/dW?=
 =?us-ascii?Q?zX/n39mP6qtXPmfceyeJo93UzICwR8m/gqocJWh6o04hpbFhvgTSZt4YHGeA?=
 =?us-ascii?Q?vhmU5o7shpWTpkE+mlZoLkEKUfJfj64V5rXUJL03bcA3N0UdzSvrQtVw+HUE?=
 =?us-ascii?Q?JHocyy4UYFrsLQBmG9VqqL8dIMgOV38H94G+BOQaPnueSfbqrjh2bzUlwHtN?=
 =?us-ascii?Q?RhzJ0HHHy9mOcQ0QAJsMlcvGX0btOsVOcujzAWmuukbMgAQ8PDLFowbmbBaz?=
 =?us-ascii?Q?LcgnrshnEx6BaLT6ARw78gjRkKXeKkTPNppYobPTmmqA5IUKIpsrBRQ18evz?=
 =?us-ascii?Q?ga15dxiLgMHlIAY=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 15:28:44.8162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83472149-a17c-4f22-ac98-08dd649f3d99
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A66.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8587

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


