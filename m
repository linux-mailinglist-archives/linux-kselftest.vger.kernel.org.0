Return-Path: <linux-kselftest+bounces-34917-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11667AD918E
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 17:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 483533BBEF0
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 15:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D31A1F6679;
	Fri, 13 Jun 2025 15:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="M8C+jhby"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010071.outbound.protection.outlook.com [52.101.69.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEA71F3BBB;
	Fri, 13 Jun 2025 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749829067; cv=fail; b=b+XwLxvvMBLqT0pdYqr/S19RofVQ4Ax18A0FGVmpt5v1R6hG1ni+YjdGJy0fnAJ/kX5RbXCBzAbffPcXtJka+y0/IC7lJkt9GBT4dNO10uxCdMQENHYy8qP8G+4k+jkV/RcQpV0a2CIjhAeQtG1PkR0I9t6dSCGiWuNobTphNvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749829067; c=relaxed/simple;
	bh=UvrjHyQvwMMKu+ydQjeNNzpfw0jebxZNRAg6Yv+RsUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N00iTjU0xd8CeJWaDFsvVQSBtldQJ3jdxvHE63M0ex6T3HKLnSNXG22kQTNZX0w6SYABguBDdZUHmzrD0AfvTCnDHTWL41+QqBnO5WU/qcvn+s49/RigMuVkjLOQK9VBOD0nQOfrqlT4j5JS2xcszRITjzQci+5BwWZ2qAGs4g0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=M8C+jhby; arc=fail smtp.client-ip=52.101.69.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H99dd5GSzl1CDgXKtvzqgMv0CjS7bZFMylXxQRyh+bX9Wl95sJQy01S4WlpldpGU05LylVGBmd8PQrc3mBjjoPH7hleADI3RM2jB11LCmQQ8vGWDtZ1Ukv0jXO8DoP+uwJHIW2VrnV7zscFCeuvhGhGRvQGOKDGksTV0WxFkso5Mv1uXHmU9a1GNdfgvxaOYcVjQZYbW9vk9M464607PziMB3LZJmgWi3VLaUYS4Ogm3T+eMBsXWQoOX282SAEu4dtAjtHKEu4cxIfEEgFnQCZWsVJ/ANJuPWMvPUjmjYHu9qZwolCUNoaBc4QmlXhbwSmIR9qps2NHPNJCmmDj7vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgG50skLVY3aVDgCGcIqWujSRWT/aldkRftaCV+XMwA=;
 b=waBVjLXtWN73+TTq1L8WeiVOGoQvMJeu5Xwcj4bTv8Tr8ylEZdDKunrBg8lk0LQ3DJsuOqEIq2yV16sI8vpXLGnkmxG+RN2KrFr8s5Vo434AVqOfxFjJjgG3AGVgy+ozjm9R3NcdjajOWhLDAdgW6zBKWhqNL2R81ppUqe0AuEs0x3olOs0M4RgVuOiltqN4mw/wvrW5AzM6HqPRNmVPdRVJL4rkmQs2mComPSkWSBO3NLUfOM9LGOzFlXusHYEoDqGy7p9nxxZGGlwivq04+wiy54mVtgWrioVDCTfby02kalCZSKV71SaAhhpgpjADxJrI1CWGYIWpThJTYazYfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgG50skLVY3aVDgCGcIqWujSRWT/aldkRftaCV+XMwA=;
 b=M8C+jhbykuq2nk1UAe9AN7tynqbSYpT6ggIcjiJQhZuUE3cwDFv35G8wN7AGtG1IQXlr6OTZmOH7VEFOlKa9nyb6HPLNlxEInHb7IiGb1kbDhbqcbMEftXbFQaAucA/PEb3rzMSHdJbE0CGJVugQzx/r3ApBKWgLG5gNKNYKvqEudx2VkoGyHbOGBY42P0+z6hPsQoDdVtPfxN2Efq8qHGM6WBd5e4f7lNtl1wegEmvhS7IDhm6+pguz4DjpNnWI8z+I6jh6Fsnj1d0DYh1B7+UPNgKIvci709zzgixhPDbgLl4VrFlGI2Jm2UgIqVsYJuhGPFH9Af7Y8gcV+85wyA==
Received: from AM4PR07CA0018.eurprd07.prod.outlook.com (2603:10a6:205:1::31)
 by DB8PR07MB6394.eurprd07.prod.outlook.com (2603:10a6:10:13b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 15:37:39 +0000
Received: from AMS0EPF000001B0.eurprd05.prod.outlook.com
 (2603:10a6:205:1:cafe::7b) by AM4PR07CA0018.outlook.office365.com
 (2603:10a6:205:1::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.18 via Frontend Transport; Fri,
 13 Jun 2025 15:37:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AMS0EPF000001B0.mail.protection.outlook.com (10.167.16.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Fri, 13 Jun 2025 15:37:38 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 6C1882004A;
	Fri, 13 Jun 2025 18:37:37 +0300 (EEST)
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
Subject: [PATCH v18 net-next 4/5] selftests/tc-testing: Add selftests for qdisc DualPI2
Date: Fri, 13 Jun 2025 17:37:24 +0200
Message-Id: <20250613153725.7983-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250613153725.7983-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250613153725.7983-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B0:EE_|DB8PR07MB6394:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f51d1021-1ac4-4ee2-8d8e-08ddaa903a75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vSOhl33vLRkwAarsVBGgwyZI4g1PvmEf63EQuEZzzUM/y/TMiwExe/O7Ip4X?=
 =?us-ascii?Q?FcJ5Ra0zaPtweo4TZFZmX6nlw8TRLNZxlfP1S7ri1hgFdQZXCrz7A6cGsENw?=
 =?us-ascii?Q?+XaZw92w4mIh5LAmJBt2gTpZFabVfDq+tYZxSsrV0bCJi8mbVYiMq853cjSu?=
 =?us-ascii?Q?cjZCuV65SzCklldi4ZXmzJVhzVDfMsqE96hW+HokzG9MYfBLpwUoAprubsMu?=
 =?us-ascii?Q?n48XoqsXVMysufJfjrz4IW5m4lI+GZ3mhP/L/En0Q9qTfmKOQtd6STmxgQ+l?=
 =?us-ascii?Q?ccTOQdHVKZvJiKCBH4aqlCfUZyAxR/8SkXeKzLPZDKkp+DSWW2+JbvRQ7Iln?=
 =?us-ascii?Q?5M1HuK5642GgXWgLSRO3YwPxljPqnDB9cIirKxm/jLojv+iHRLXVKtGW75cW?=
 =?us-ascii?Q?aRl/FNKH1loq6yhcbxa3gnAJGriQ/FwfoL9gpfduj+AJ5nejhHVj7QULq+Ru?=
 =?us-ascii?Q?PWHjSV3Tdd2v8VmUJJaQLXHWOFbn5+etOGI1CQnEtKLUvpjsy1lzG3+dBq4R?=
 =?us-ascii?Q?zmFjujyJDaqV0FKnPPjeHqHfWatftzv7oaQixgGc2HRG4YIOCc/z/VlNw4q5?=
 =?us-ascii?Q?b1pPr2U/XmIOpueqgMANvzMnh7r5NopXgUXnSNYZLdS9/UcaSRJ1zeySF+hK?=
 =?us-ascii?Q?6R6UVBy7p69tHa53cQ61xJmU5kHagEqWgf82QV/gAip/Ah9jLE1txEexPxLs?=
 =?us-ascii?Q?ZlRfN/aRNs1dsP0uFCYjzK7rnScHb70kxTvI+w/ND+t1yGPrK8100dDLIp5p?=
 =?us-ascii?Q?H7K3srP0EE7XPAopaKRAF00aV9iLi2FhcVzVRmFgM7YZEYmfpnH9VCg+H9ra?=
 =?us-ascii?Q?YqCmELLAtFdXWFVa2ZtGCi9SU2kaHriLPFvhAqTn+cTSOZtVm8XDbeBtndQX?=
 =?us-ascii?Q?/3MsuyL8flQcIui5APZFzk04B1mYoRVDV3vphNdamj90kszvbDiywrwDqteD?=
 =?us-ascii?Q?XnUOInloxjBMBPgGz/iOZjwTrWUVCSBLoo7BLB6NSJMn6UCEGiMm3agB9Pwt?=
 =?us-ascii?Q?0WUe6zlFR8GpuCJ1+GdBB3uOoIFTmyeKKIQq4ZqPaVWQeTr7hnN5ahNNhZyb?=
 =?us-ascii?Q?rKJiYaKkjYcL7QkPOMmUt9KUgiqNHI+6PA4rktuby3bMLU5VqlhziaN2/Y8d?=
 =?us-ascii?Q?1XxUm7R3fwMn+gInqyMssASZwRxoSHwzUqIEVs8rKQXwD8wAIhbTkGE3UThb?=
 =?us-ascii?Q?MLCwyfHei8aLO9AANYC6+zg6NOrqb0ZiizcbuUjWOh73/aJZokLybkDMYcQ4?=
 =?us-ascii?Q?TnpFX/wQ9yOUUxGBcKHNmrp0IWp8KJBzk/Jl3nhcSOe9d1znnIYosPilYkpO?=
 =?us-ascii?Q?A8qp107czdF/JeTpUWNWqcbDU4e9TNcyf3a3crKTVLXSTDJ5Sx2CZYyVijkn?=
 =?us-ascii?Q?oFaKCp+CYiofC8TEet7y77MRBDbjHjwQx00CP3neovEJT4bOnw+cAeRh3SF/?=
 =?us-ascii?Q?57jLe+tKWccEysF8o7vTHVe3QeCvppgZAdEYgfq4I0MVZFsB96Txkce2bw0n?=
 =?us-ascii?Q?TiABvZBZFnqmlJofz5rpT1hiaig9kPBNrXA/oyPNM18MeFaMQYt4MQCg9w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 15:37:38.8331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f51d1021-1ac4-4ee2-8d8e-08ddaa903a75
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6394

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


