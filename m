Return-Path: <linux-kselftest+bounces-37523-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D922FB09737
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 01:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFB96A46D6F
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 23:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D49C24502E;
	Thu, 17 Jul 2025 23:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Mka0x4g/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011012.outbound.protection.outlook.com [40.107.130.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331EC2AEF5;
	Thu, 17 Jul 2025 23:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794690; cv=fail; b=tmMYRgs4s3+P0/vdEJCuAz+mHrVAcHZFNBh125TD1p0F7Ha8MUTz9wiZio7sW0SJaGFLgXICdHo0o/Vck4sMi8gkb+Zj7GoB6zx9jmOoA/XMYuUdJeyAmZRvbIUHiagunnSRuiAaqomA8L0K7zeTFFGyPls3UJuGhfbwZWdAob0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794690; c=relaxed/simple;
	bh=8rSiY1ztMBfRV3k7MQMOwyOclQZl+hl2CKcrLTE6wlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s0pko82MP+Xx2HWlYc7QaNxajbHFCWrZW2MBestQndn9UWy0xyVLebYQO7E9xiWsfazOvX8VUj79SK4xZhTJnKbNYVWPAHiQs0cjcCl7tjTU7rBNpLgfX3xQqV1I1LDQN0nAId0U5N29gYd2qWUg2/JSqSlpvM6Btqq2bA1XFKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Mka0x4g/; arc=fail smtp.client-ip=40.107.130.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r7qKuC3K+ksKWh3URjWLqE3ZascoF4jzhMYwsbvilcfTJef7Ac11+B+DI/AbOxZo6mxO11+Wt+pgdPGVa+G5dq0MQD/3jw7YAjLpyJ7IBRumpDLdCAhRREc9A74pvZ6VyeoII9wrhECT3iC7+PU3/SyJ/8ucyTLegoTqX1J0MlBuVYPk9dAJBL31i9PANXMVBn5hiujWw5UZ2+95v5EVqvf92dd6qNvz0iLhSGO/GOwPXHwF3anQPQWgGHsplUX5Gj5y+iy7s7tm3I3BLVhl0OWfckv9YrH8x7QQll8rohismUcNvSJolDcur3YZGaz1SQNHayV8b9ZdaLhLQjRYig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ztiqykwZxZumkvXd1Gc3L8gnveGDSoSzSvHn7farX4=;
 b=bfCG6SqOzHo5VypqrgpBDeQHxS7YlKRSoQLm5fi+mFhRc5c6uJUo57MlloSHuOpT1N+E3ztJ//97GphNWO61CvDA3WStVSBsnpRTT1fNghLwVFWZmd/XWKvJkY4uFTnTx7aplcdGhelUtBcBAf12aXpa6dmOJqyhnCIwG2wlHlw1aFh5JR0FmUmlW5xcOAto4W5KZqMadJB+RQlCpwnTT4gxfqfq1xqFdRZPLfc7EBoC9Fibmhtj6SjyTUTPSOBq/CnhyLbFon8kOiAu9RdME0pZyVLYmPsl28Azi+p/c2Kmi5pXMeudoLk5sd+rjiB/LD6NcH70rAcK6dHlAwnndA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ztiqykwZxZumkvXd1Gc3L8gnveGDSoSzSvHn7farX4=;
 b=Mka0x4g/uVoNDeT794Dhu902zZHEQ7WG49F80kd3Zc0CXjVN465Mg/YVfv+TpXgLJXJvKx8kYxDu6luiPMtR3s+4t7XD9+gSILqQATvkAxRy5RwXT4KuGJ1uyVPda3ZVSTtLGSoFanEbT1hcXCWqJ8Fcd7q5nY4qoebkd0CmMh9Lu9UTqy4CJoqHFfDPsGSiDFxtp7psh+gMovC5TxOCrasXA1QvJunEU4fmoU3te5QhO3SVauEeUd2g8xDnBVMKxYR6Vz9yHV2xONmOtA/2NTAI7h0naDRxLgoXiUlzKdmra54NDonIBirWd/kb6aZcvBqRWROf8vgCNJI/CZCeoQ==
Received: from DU7P195CA0018.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::18)
 by DB9PR07MB7722.eurprd07.prod.outlook.com (2603:10a6:10:26e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 23:24:43 +0000
Received: from DU2PEPF0001E9BF.eurprd03.prod.outlook.com
 (2603:10a6:10:54d:cafe::d4) by DU7P195CA0018.outlook.office365.com
 (2603:10a6:10:54d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Thu,
 17 Jul 2025 23:24:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DU2PEPF0001E9BF.mail.protection.outlook.com (10.167.8.68) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21 via
 Frontend Transport; Thu, 17 Jul 2025 23:24:42 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 628C9680045;
	Fri, 18 Jul 2025 02:24:41 +0300 (EEST)
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
Subject: [PATCH v24 net-next 5/6] selftests/tc-testing: Add selftests for qdisc DualPI2
Date: Fri, 18 Jul 2025 01:24:26 +0200
Message-Id: <20250717232427.69216-6-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717232427.69216-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250717232427.69216-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9BF:EE_|DB9PR07MB7722:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b3416b70-4f7c-4e3f-398a-08ddc5891c2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q/of1PcjnES3Smdz+mgWgbNdluWMV/IxwZ/Sse0yzFHp84NOFFTVuEZtuqqK?=
 =?us-ascii?Q?ImP1dv1SBbmYlZUVjUym0z9k9Vbq1bADSRauRDCrIw4B7YbjjWemiWemDbKz?=
 =?us-ascii?Q?6+GQ17Dn1MhnN9vA6FRcuvIZ4rTXKBCTK5rxQ/N1S8T2LZDboZPDExx68sPT?=
 =?us-ascii?Q?fLMOM0Ueg7Unvzjf3dAo3vfHU8R9r/SyBy1ldtXNUxEwQPyaTXUg9J4vL0pN?=
 =?us-ascii?Q?MiAp4ylsIBd/ShrUor8iaTFW1WgYmv7fzs9dMuOIeY/QRP5s4LdVZr6MTodY?=
 =?us-ascii?Q?dyxSsbSUindaZ1ySWVfgksRQtfyqRNdlDPZD+DJV/QOTuClw7xZkKDqKTZjZ?=
 =?us-ascii?Q?nFrv4ZYI+2WUISPO0W6u6VjoerYNJQMhoZJbEGMjZjccFsBVxyEfsyD56vja?=
 =?us-ascii?Q?4jwiJXapILXXSCjo5JDnpqlp/IYRfyMDVQ5NI4lKbdBUi+TNFKq6z22z7htx?=
 =?us-ascii?Q?X74dbJ3fsMPa36EDpojKXvZWVroFyj6Aq4qBrmp48gL11ByMTQ6lUL1qpxbF?=
 =?us-ascii?Q?DMJ6m+p8ZC8iHozkKMN3h56dDKa/wZsf/O+RaWqQrhbqTvRXUSLVPybIrvvf?=
 =?us-ascii?Q?Mkz563UI2gc3Cxk+W3ge1kjNnCe0p0L/PGQ8Bn9VZK6WWQBEsyy1eeVorIlL?=
 =?us-ascii?Q?8tjXmDR8+pdG8JIoVE7qpFKp56SxSbiqPgUkPzoCNimMhKedpklir37yjgG1?=
 =?us-ascii?Q?yo26OgkFs2fm/ZCH50ZFueXh6oXjjnlNe2qTePH4IfFpSYI4r1hqjTgdDtYm?=
 =?us-ascii?Q?zaRA9R5dZuWqAeRFT/U0owx0EJXFgCkdwhlFvd7P5GVe8YmxkLEZXXf9aaID?=
 =?us-ascii?Q?uEuZb+iit4qUuriJh5jXEjDpVFkME9VaALTHrY8iaVEfxnoPof8TD7cgWwp/?=
 =?us-ascii?Q?9DLo37mPyt+vQpcgTGI8CkTQ/Zkssi1u4LOYPKG0xDAAjVM0LmgpTcbRjhrX?=
 =?us-ascii?Q?0h9RvUYWXRkKYioqEa9rjoy/ciZh5qFyS/lbAqkWYYsh5t3x3GglY9Q07a0k?=
 =?us-ascii?Q?4HKq4MT4p3psYAujAYO9wVAzJFPFqJMaPLx4sX1Ix9y0Er55/sshwveV+cLv?=
 =?us-ascii?Q?dwL6VRecAB1BzDAHBn9njOprOzyAfBFPKmv89cN4CSYY+sdDGlnFHnHOjSRR?=
 =?us-ascii?Q?nv4lnbz3m8E/pi30w3wBgSIeaSqIuwCIl6ws8vqJ6xh37A5Gpa4TS/uSJNiu?=
 =?us-ascii?Q?6PH0Ae0vp/fZCA+WXUq5sTcN7faO/tEOdOfK+vn487MCzMekpzoxYETEbtH8?=
 =?us-ascii?Q?44qXUyCuLPVRhJuxT9zcOOQfJaE9tvchXzUrpNSvxneiLpEaHsc7g4GkCht9?=
 =?us-ascii?Q?ZCXIID0vH+gOHlakQy7SjI/uqOtkeyKmIqIfcd1ZWcSIezB5mm/PZNXSREXs?=
 =?us-ascii?Q?lHPboWdEtpRtcB+UYtNdteWlGUn6UfkioF2QoMiVixZ35+m9Eh3oR4kQMtwY?=
 =?us-ascii?Q?78O9h+SKf5/JbsLBn+9hGjA2R5emSfp6Ilraf31ooAopzTcxEAwYJzahtDUW?=
 =?us-ascii?Q?AEVhI5CWTyoXrTX0nNt1nDOvTu5V2Z5au4JsUFkmpCieoSaPLXH+6BODHw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 23:24:42.9669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3416b70-4f7c-4e3f-398a-08ddc5891c2e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9BF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7722

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


