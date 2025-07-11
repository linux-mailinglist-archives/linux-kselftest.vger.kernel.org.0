Return-Path: <linux-kselftest+bounces-37125-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81400B01F31
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 16:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9B3566320
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 14:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86221898E9;
	Fri, 11 Jul 2025 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="VD4vIirn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013055.outbound.protection.outlook.com [40.107.162.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB486149DE8;
	Fri, 11 Jul 2025 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244349; cv=fail; b=sYMcesyFL8llTcXNjXkgtMyl6JkJIXpO63TMgKTkRSIOhyBbiVltb2UKUxPN28QA3JVvOSA1lvT9slRsdnFRl5b6ARnL5m9z/8Uj1OhaddLRqTCFt4Qfmeb56Ijst55v2bBAEaShiUCihz/7G5vuZ4pQDVfkQ8apcsgEQUeLqqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244349; c=relaxed/simple;
	bh=8rSiY1ztMBfRV3k7MQMOwyOclQZl+hl2CKcrLTE6wlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qw6OTA6B3Km7x6r3mwobgbYg1Jtd7ePLKvnK0ioBDevvnmC/asAI/cHcoFKH+n50ee5k4rRTY5/mNCgSIRYRvGdpgrt+IlU9Js34HOppd/mBTG1rSdTs92zIa2crioqLMQnyBVR7aaatpj8t/Kea2DDAJ6+9JWUyM3yn3T2FKdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=VD4vIirn; arc=fail smtp.client-ip=40.107.162.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKKlMBUT6E26uz6xlp3blmprfbz7NbaCrVCOM2AXGLtzMwxRGS2hSmQsMUDtX0Tm7+cHeGKasEop1NXQktOyNCnIlzm5j34z7TdzMFAJlRE9d6t1NG+OCDA3F/Fj3A7W6Aza+tlOvHMo/GwXks2bs9c8ajdNttUL0L5LaCUPKpz/oeIc44C7da7t30st1ZDrVqWdAA5I/f3nX3Q9UCkiJYGfbhHcLXMzLxd+KA/yPCy02nwXhT2hsxyRsV/q6dkbPutk6b/5g6phJrtfzqORdiWqEii2qGWNv/wWn0Ly52P+ttKod26TQF45mFx/7UvgdNk3PVuxXp9TdOvMJJ+8Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ztiqykwZxZumkvXd1Gc3L8gnveGDSoSzSvHn7farX4=;
 b=QnXMjq/mGLbaTAwRxPiQj8RyTdRXrqn+7K0i1NmdUmTl4rCg+4ziR2A0J8tTfJzQDxu6PG5y0GV76zpOESG/ZvMquI+G3Qro9F83DBds1dGyUGB3y82ga0LSNkr3XNZj42UQ19C01bCpkCaVDNlE9FLlUcfoecjrapb06dHq2pNbyWSKLp9kHTAhH93/0BzTPP7iCJEd6G50o55sUIfidUfC7G6iDsfGNtK+Vt97XB9AQXxSHT5l5JjAVP68BOZ8hfROK7CYKfPEIKXcAplW5VB+6nTWxmCf4hIO0AhDHAhbOObnkV8RmNOKWEquOEcoXiLkdzEs1GkWTHN4xAmsJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ztiqykwZxZumkvXd1Gc3L8gnveGDSoSzSvHn7farX4=;
 b=VD4vIirni8Qys73eCvRRjvQYeaGbEhkDXjYSFihX3N/CwBbPvtd35pG/0H1uzMid6Yh826mFpBx8rowP8GPWAUHzLL1FP6q/CKo0KSvNsUsUBKqjMSTWwzJXlZFVVYH4PptRy0Ya9gNQKCLs5xm0kMOtYq2u3WGoNmoDjSInPQKyAuqieRu+B5k45m+mSF5Z1NKyHvNhmA4wyHA0RsF5+QDuXyggVbVdJqLCuDh9H+CvfJP/R4uL1eOrH3+pDi6Lj3LZtnas6FEiTUs03TJaPUf7/X4UYjfeVHyqmEDSsCNHKph04Hr/z6NilUrcTKGkj/ZK4qMcsOUwxNfzoOF80A==
Received: from AS4P190CA0029.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::19)
 by AM8PR07MB7412.eurprd07.prod.outlook.com (2603:10a6:20b:24d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 14:32:23 +0000
Received: from AM4PEPF00027A62.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::d0) by AS4P190CA0029.outlook.office365.com
 (2603:10a6:20b:5d0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.26 via Frontend Transport; Fri,
 11 Jul 2025 14:32:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM4PEPF00027A62.mail.protection.outlook.com (10.167.16.71) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22
 via Frontend Transport; Fri, 11 Jul 2025 14:32:23 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id C28BE68003C;
	Fri, 11 Jul 2025 17:32:21 +0300 (EEST)
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
Subject: [PATCH v22 net-next 5/6] selftests/tc-testing: Add selftests for qdisc DualPI2
Date: Fri, 11 Jul 2025 16:32:07 +0200
Message-Id: <20250711143208.66722-6-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A62:EE_|AM8PR07MB7412:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8abde868-b97b-4791-9a31-08ddc087c02d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700013|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d/M3GCisETjaAVpLDJGcUU18v8DoUBRd5IDangfqeWoczkCt0bW2ZJgiyLg+?=
 =?us-ascii?Q?qp/ATfycvrmNhDz7KwE+alEPQqGLViseXYSyuzXJPNnx9rnrkusiYuxQ10LF?=
 =?us-ascii?Q?9PQuYAvIFtOuZ5GTvEfou39blUlpYOD9Ez3JHR11Hn3Q42pvL82rgseWMaIB?=
 =?us-ascii?Q?VU62lbfAK7lMVW24Z7O+J4asZ9ivQQYQfZ8UjDZOBh/B1EeVmhurhB6aAuXX?=
 =?us-ascii?Q?ZK8kI9hqZQzkE51lQLfaDHKctx/nsM5Bq1Rc00tHrslss/wYBQvVe4wag2Jo?=
 =?us-ascii?Q?1XkrGENDCzacw053vYU6CmcK+nExvsLprtU9SITv/xZ5qAyJ4f+edB4OKDYK?=
 =?us-ascii?Q?71dmNbFHBWzgbfOnqrsRydZny+DxbyqIES7ZQBFuHCuQNGH2wLrDLepLGyYj?=
 =?us-ascii?Q?tf5zFqkU1foHKlklf4g4sMWy6x1WRXw/VPvqM2YX2p7EP6QRD7ZULinDjhrq?=
 =?us-ascii?Q?w0l0z3txNVRctOr1KmDHBYBIt2NqL0NnXGwyR7P1i+Lfaihi6loBU4FBGp42?=
 =?us-ascii?Q?+TVkU/XBx9rI1qXUMF2rsCTMWDEc8UuLb094vNipHUT9NPA287Lsx+Orhc58?=
 =?us-ascii?Q?AwVpx/qOkHMVnxcOTmQnJeddfZwQ6lkKONtbi8n1nRVWyfOd0X9uLQrsT3og?=
 =?us-ascii?Q?lmh95d/cpreh0Ksll+ALC3ntvGSS0AYV9Xt9ySS2c/FKWWpE+gdkuU/DEIKc?=
 =?us-ascii?Q?SoAi2FPag4nkKNGoTyjFXfEl/g+5xy3sHt14gB2dfpL8yohWyDlzRiBDwJ+T?=
 =?us-ascii?Q?Nva9C9ZjqVQkS4JwCL5kmYUe91dwVxls/wuXzrhal+6jBQYWpaVFTgGxVgj+?=
 =?us-ascii?Q?dFuZbZR+WQBB3TfP9IVds6egLY9eGPLiARndUbC/kS1cCzMM8oMTMzFqbqmI?=
 =?us-ascii?Q?4Fcfoa/r/ecfQYEPC8NyQvfny1HDAP25+quT7jPFm52Nv5hjLcTOPyWOOA48?=
 =?us-ascii?Q?Tc5OqYTXphggVfKDQFaTl7SrgDyDFinSfM4IuExrVgwF/RNGMApm7puir5kd?=
 =?us-ascii?Q?xCeylg5N8XW1jd8Sy4ti14dQQ0DbOrQCt66JVrwKZuuvompQAhlMJ+NKEaqj?=
 =?us-ascii?Q?WaS6bssFa+xIrecInxIW3Uqah+T/XYhzLc8Fi3BKp0e0fcYGQMshdPqZ6idM?=
 =?us-ascii?Q?TJ3MlI81zvMQ8wqXxi9krVYHQc/tnS8k+8B7k1ouSzFVnuW3mnR/WVfaTy7u?=
 =?us-ascii?Q?jsHckuwcx/YQpJAE1JVm/+OIKFoI9+qkU0T8fYME8eqDmecTBhqD0kYFkOhW?=
 =?us-ascii?Q?/wIeb7XOMGRUGapBZ6Gt0oMSowBtzvOdJVLVZRaxQwoSqz1y0ZsCUWuDgl4t?=
 =?us-ascii?Q?VqukJvJMq5Qstl6N1EE9qtEjz4eUgW51IoXRW+yoq4b40nyWI1lX5zrVFmlC?=
 =?us-ascii?Q?OOX39b9aw1JNdgY6h6919Eh9Bb47IAmlIBBFAOceDjRPN6sdRb/UNcL8tB7Z?=
 =?us-ascii?Q?sMD2H41d/PSnE62pVz58yeaA2TzpbbeYPHKFhvPqJ7GZiQMtG/8xmiGP/pYY?=
 =?us-ascii?Q?QDA0xAyzkOJrs5ftz+dcG5+ZNrrNXI/WH1Nwwc+fTEfE1ZUMVgih5p1T/g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 14:32:23.3109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8abde868-b97b-4791-9a31-08ddc087c02d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A62.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB7412

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


