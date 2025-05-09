Return-Path: <linux-kselftest+bounces-32802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B951AB1F4C
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 23:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54D3E4E747D
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 21:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538C32609C3;
	Fri,  9 May 2025 21:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="rOYWccOd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2084.outbound.protection.outlook.com [40.107.241.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA17F26159E;
	Fri,  9 May 2025 21:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746827301; cv=fail; b=Cvk7Xmhx07es0Zk/u50IPgN9Kz7VxCuRKNN7+eVHPeDVSWSf2PdptiXCMUAEmdQ7M7rHuUwjG2CGOw6r+7aK2Nunx84NM6N1pF0fyyqWhe2beGlJ7JvFslpoIhsJ7e7J/dUw3Uf5iXNdTVYAxDPKCof/q3Dq+69Qx5c3hp4bBgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746827301; c=relaxed/simple;
	bh=UvrjHyQvwMMKu+ydQjeNNzpfw0jebxZNRAg6Yv+RsUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UcPVZTF8BxWSmylQ1SeXaB5Q+EH7V7QJ8OWAlxSeGEDNSs96NLfCbqoDI9HnWIil7601xzFQ3kI+spdpgIOORGXg7XaDG3LsRgGn9tb7awVf9W2ZeSw7Mz4cxdstRWcRkVy1XCPTrdS1aY1+AZSOIWfJkg7VySrT72TXHFcn+/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=rOYWccOd; arc=fail smtp.client-ip=40.107.241.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0++pWyehFL4YjLra1rLq/kEp3uiE24v3VBp70THiTDjAPM8x0l/d3l+qhZ4OC9wdMZCcKeXxwxhsbjXD/MInRTAKjXCGQxX0ztAjQVwl0PrzykEbBTS7+etFtbO05ZGMfOOTCYA8aXwEm3YCWKGlk2gPEIUlXOldT49Dugmc1DpWFo/Cp2BTSnhfxk7BaLG8FcaUcRF0tcYBxRydqJsjTq7MdwBMNPi+tomL95cuRkqmdYXWPfFTOH8AKKi5NBxGwWIF2Nqx2P4RmAsDqU2mtbJiMR2xj3yv6qwP8p6ocCNtA2fWiTdWwdUFBbfCfMISs+EEhUrnjrAd5llYla+Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgG50skLVY3aVDgCGcIqWujSRWT/aldkRftaCV+XMwA=;
 b=upC8wtQrdgctWIMYMW0Dkn/iIBnrX2x0opydAu5+X5FsMnLLH+3KxoG6rLhWN7I7Ick0mEDB2BjGtTXPnwi0p6qfBjoUETJ//zRmNC4DKL5fMkNLYHdntFUyT/eMANVGmdnfKIYPp85mIybybQPpEzTJ7A+nZS/rwfVR7hpO3wyvxruByN0QB2jC9uRFVAhMsLTuDTMPCNN+SPBBRLJFVuvAun5atlGIqzdRYRO/yCTeAZ0Jh2XmxwdWQdgwvJQWlMBH6cm+XxBUUJ4kbfI5EiRf2oYGkC6bbldmeioaFUkk5IRzdPTMjG4ae/j+vu3ULJ/jEVaDgGFU2s7U5XNPmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=mojatatu.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgG50skLVY3aVDgCGcIqWujSRWT/aldkRftaCV+XMwA=;
 b=rOYWccOdnTkmqyypCD0UMHM78NJF3XuhzL3hUW8tZnPGN21wO6HiPKz2G4DVIE9t8qGFJQZUFsNfliQwjpfGT2MgSwWDOD2xsedZs6OwWUi/Z1BGkYpKrBnxooXmVnrsrx5mk9VPCjLHExvzwja/W5dFoAdBTsorlf/Mi00G3kcaO9ZsFlTWNAMouQeDd2SQ+3YgVeqP4CqfFObXNZzG+ZM0BHbiRzT6gbwdDqliXpalvSFQR9MjzOJMJ50syhxVdzOjl0MA2R8f+g5WPxLxmRnXIEZZOWS5pgmkcg7E0tFXW45DRFoAwsc255LSP+dJ2yhz0bD7JlNQWYMafZ4Z1Q==
Received: from DU6P191CA0029.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::28)
 by DB9PR07MB7755.eurprd07.prod.outlook.com (2603:10a6:10:2a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 21:48:13 +0000
Received: from DB3PEPF0000885F.eurprd02.prod.outlook.com
 (2603:10a6:10:53f:cafe::2a) by DU6P191CA0029.outlook.office365.com
 (2603:10a6:10:53f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.24 via Frontend Transport; Fri,
 9 May 2025 21:48:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB3PEPF0000885F.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 21:48:13 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 549LmPMr011840;
	Fri, 9 May 2025 21:48:34 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: horms@kernel.org, donald.hunter@gmail.com, xandfury@gmail.com,
        netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
        jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, andrew+netdev@lunn.ch, ast@fiberby.net,
        liuhangbin@gmail.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
        Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH v15 net-next 4/5] selftests/tc-testing: Add selftests for qdisc DualPI2
Date: Fri,  9 May 2025 23:48:00 +0200
Message-Id: <20250509214801.37306-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509214801.37306-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250509214801.37306-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885F:EE_|DB9PR07MB7755:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 76d4a13d-6274-4958-da21-08dd8f4332ea
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?nczN81o4IAxnIM9WbOnRIHjlbRF/k43O5CLmcVmIrX7XJeF9uX1mphbXBJ3h?=
 =?us-ascii?Q?zEUJ7RcQIdZ8Bm7ZF6eRii4vDYTeDH81nckniLLeqLnUMFcNUp5m3xw0oE8z?=
 =?us-ascii?Q?a/+KR+KMvJGe06rR1Uvq/4JgmDY/Lz5ATDrJUmXIdB19jCKLECmsyxqj+EM6?=
 =?us-ascii?Q?/aez8rYoOZreN78yQxLyRwhCbW7HzeuyEUUcP67xXshWxDkvGTNN7xCoKEsx?=
 =?us-ascii?Q?840pvFRbvlKfD7DeCOveSRMluvIGLJKNTIOeNwV4CztrT6znq2/KwiXO093O?=
 =?us-ascii?Q?EaaUsjR2Dr4k3CVkaM4Pn29wOvXPIeUfrUPfGQyEXJbhB3ML7FCsUaR6RKKI?=
 =?us-ascii?Q?Q0rtcnIO/2kJZVtRse/OQIJwNXkb24P5zCLLobfBT/bBZrfGU9EK0YzNBkg2?=
 =?us-ascii?Q?sgpAFBcTTmtEZXHVstlW780vzBJsBJSHiVkAcweGQqlK01uOThdhqICjZj7q?=
 =?us-ascii?Q?GLQeWwwfqhnb5xhRPJQezVOuBlAiw77U743ezOhHnlObDFInKD17dXm+6RcM?=
 =?us-ascii?Q?JRfZoj5Wh+cri0kI9LiiPcpjGZs0OAQ2qpxAYH/sXRF7WuxEzTtoomn2D5wW?=
 =?us-ascii?Q?H/XcOQc8Z0kxkmaIGdOkNBZEmuxa/OBRHN+7guVvTKFO0qwgETdumzpu97hA?=
 =?us-ascii?Q?nPORSEL/IFzJgGEBXIdADUnHlYNM6e/7R4SxqyuLTpQW8ubqTk5dyW8divvY?=
 =?us-ascii?Q?xgIH2eQ/uqg3bbaMVQ+6mrDXrSvguWs342v3Mi7Lp9QeXgOE7y4rPvL5mMXk?=
 =?us-ascii?Q?zlkkSBOeZxDJnsWqIV9TZedSUEAhGQP60q6Jow2dHwQBa9bYPzuUZCooH0/g?=
 =?us-ascii?Q?azXIXbZQCJrz6U3n+HSgqBUPiI4JZy3dyBzLVmw+Eg14tnkJl8tMPy1bPv7e?=
 =?us-ascii?Q?ppla9rDQCmGkePeUQowiLJ00SSnGroU6TNaD85y6OWFw4sZGLTRIko/hZSxq?=
 =?us-ascii?Q?O41wrLApQAGe1wQ//0w3hVgeOUzdYo/6n4RTyZwYjfp9P5zvsKjIJhAJBSlH?=
 =?us-ascii?Q?5ezhFTDWfTYq2EVgoum3bO+PT6sMCCcSs+KqAjVlDE6lS03HELuvsrGsLz1u?=
 =?us-ascii?Q?x+f/AuQ6zDwx8Fzs1ul3NvSzGhtUZ5bm+kzwVNMLX51c6vDUyJOiJLuhpUUm?=
 =?us-ascii?Q?acOHcxm6HEkWz2BZqIhH9Mr+d7W9nH/d/PeRWu8ROopcVA1Mhybdb+1K+xu8?=
 =?us-ascii?Q?10rrbnPpRybWJMGhig3kvLRZjDKt4Vl9sO8WOM21T+0LHHvrcmKGpLpweUax?=
 =?us-ascii?Q?RCLdTUobApOXz6YEJGyhrQJYIttbdy8HA9lxeH3+lWeJpqKOWY9JTVfaX03b?=
 =?us-ascii?Q?QYbLGnO93rhxicFVD5yrXF1bTeos8A9ySzsvYSh6C5zDodNwjEnnvesZJvQ+?=
 =?us-ascii?Q?CBEL1rIB/m5S25VHBpIZjXTevZC3ziGzcNfGKs1uQnGe0uDFGAsdnuJUw9vg?=
 =?us-ascii?Q?t35ViBdP0OJBjJUw/ZQJNkS1zVsS1ZCtBKxjgKaFI4k0ilsiyhCQLqzJDVvr?=
 =?us-ascii?Q?KX5SksQVFv1Hnx9s4k0pZE2kKN8hBz9yOasS4lVD3GNe8Tynq8oQwQmnyA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(7053199007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 21:48:13.5176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d4a13d-6274-4958-da21-08dd8f4332ea
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7755

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


