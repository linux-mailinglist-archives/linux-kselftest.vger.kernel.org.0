Return-Path: <linux-kselftest+bounces-30866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E00AA89E6D
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 14:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF7503B473B
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 12:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA09296D14;
	Tue, 15 Apr 2025 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="EE7djzGH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2084.outbound.protection.outlook.com [40.107.20.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41652957D4;
	Tue, 15 Apr 2025 12:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744721047; cv=fail; b=d98to1FSrdRJ6u3KOJkLjbO84LTnDBeYkQswloYuASy1XDSztjfLPCTbnZd4cL5ah2ZKa4Ghp7+k7Y3jeIeLv28h9U+hby/5tpRfRxO4Ugl753MuyFsJfUZmWPiIi7R5QWXnJRDZZlIDxfc6szwi3Y88+dDTjhTu/qFJ648Falc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744721047; c=relaxed/simple;
	bh=Qsku5tX58nzvcBjEl38SBdC5SKdfWDsit+kkLSrh8dI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RqK5so6zEbh1rjLQtwjfIDoNZjC45kOcItJSljApP0zBl+vY7R2KkreozDJu4GP9vmzESSVPraGg6nt87sjxzBf9ZeItgbjVfzsdGZ3PLo9b7iOJup2i2eh982Z8E8orbRikjwykEDIfBjElgBlUKIEV+wQBMCjoz1QXYMGYe60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=EE7djzGH; arc=fail smtp.client-ip=40.107.20.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jurL4YWhlayD580Y+YkjWJBNCOq/KwEfqpmzOA4BGaPZx2lHiiODJ52gGuZZASVqgeWAugM4B6k+od7cy4KtV9dTP+wTYYYt1ZEkoYjyPfxN31VTxcA2Li0NwoRniXJCFdZAQEAh20xOcVqxZMGN9ExtaCAqLDdn4B5LES2l66HmJlG27j2ajiwBSZnd7i/6E4q4ATVETE0r/2OM/dawepnb2Txfi0EB3me28sxrMHzCVrqelyFko242yfdm9bAf1GcolTvm8Qeo/9YXb7On7lHjlb4yR6RWfcqGJX4SRIbaqr4oJnt6KDBLe+iZnGiGrCfhvOIjUmNxascRqaAGmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLD5KOy1HvbdBCncUsYpNw8qHd/FqTsg2LKXPKcmRGY=;
 b=T7PQZ5s1I+Ucc3LjbUvkpg7vgWh9npwPLgS4Z8fxiAYOGYzqQOHf+6HeA9+eXdjdRu5IB8bYIv2GW+gtDgiMYu5NZpPzi/VPFtDVrPtq75MjJSXxZ+R0PKGud3GczTNKNYmQT35v2cn0KeJmL9QIh5nvayQfwQ5LpqscUtofS8GN2QLGGucyToYZDLRzybikqGX9NkZyRbnI9M4VzWIbhPojVhGy2u1RkAFKNpBVaT2HzNaWVie4IrcdL0fjqCqGyydm4gIpQ8uBX7DXPShXDX5UNLnTtqfHpFnc0LUKmtVNVZsyOviiooI50v7AAVIDcC9a3zrJWKTHN3nI+21Vew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLD5KOy1HvbdBCncUsYpNw8qHd/FqTsg2LKXPKcmRGY=;
 b=EE7djzGH/k3V/zp/RaQBSH4FJx1boeKVHTGDi6jmN2usWley5ylBV0DuYeFWNo7TBHeaYpI3zCl/q2HAJ1O3tK1UcJXLFFbHsudLlsDLuQMpv87Q8rGEWpVIUGzFtF8QBeLehHyB9en8cwA0QGuUf9mZ3FQOxhPUKYVX8D1jy/m+tFnZFNbym3xVZk9pJfJtNPCDtEQLgIy2vGuXFEHwcf48hKade2ttDwr9aqaR/zgpLhpdu+pQbWP+7H4P2OS+hKocuX348WNfjH0cvZETWC2qDWVgy2ZYF5lykC6kjMkinZkZf7sUQd02tZa2SIz2Qu1WJHQEMRpoA8SnEhRnxg==
Received: from AS9PR05CA0071.eurprd05.prod.outlook.com (2603:10a6:20b:499::8)
 by AM9PR07MB7844.eurprd07.prod.outlook.com (2603:10a6:20b:304::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Tue, 15 Apr
 2025 12:44:00 +0000
Received: from AM4PEPF00027A64.eurprd04.prod.outlook.com
 (2603:10a6:20b:499:cafe::fc) by AS9PR05CA0071.outlook.office365.com
 (2603:10a6:20b:499::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.36 via Frontend Transport; Tue,
 15 Apr 2025 12:44:00 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.100) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM4PEPF00027A64.mail.protection.outlook.com (10.167.16.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 12:43:59 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 53FChgEf013987;
	Tue, 15 Apr 2025 12:44:16 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: xandfury@gmail.com, netdev@vger.kernel.org, dave.taht@gmail.com,
        pabeni@redhat.com, jhs@mojatatu.com, kuba@kernel.org,
        stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, horms@kernel.org,
        andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net,
        liuhangbin@gmail.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v11 net-next 2/5] selftests/tc-testing: Add selftests for qdisc DualPI2
Date: Tue, 15 Apr 2025 14:43:14 +0200
Message-Id: <20250415124317.11561-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415124317.11561-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250415124317.11561-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A64:EE_|AM9PR07MB7844:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 690a9de8-b5a4-487d-a70c-08dd7c1b3175
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?zI/Uv31zpLnwZR4yN6mpzDNio6Q0fUGOausJ+PiXzT4LpXBMpwlYffbbbZGu?=
 =?us-ascii?Q?dNtW6O+sCrXx+UklZaPjD9IoXdEXD5GOcXKbE8O4JGO81V6IpNVVO0DIWIFe?=
 =?us-ascii?Q?Q2ApcUb/kvV9bHJDJmYFPDAcZWQu7dZAuMAdrvjo9A7CM26nzuMLRDn6ktor?=
 =?us-ascii?Q?+MscreF4EJUbne7vGbHTPybX1BwpKOGxQsSIKHJ2+8gRdJwPxVJRXE4iZMpi?=
 =?us-ascii?Q?9tkNMp+W28+MDYRxuYaJGb84WwUBpepduXZ7tpH1U8PuhsQznJ9qSAbohGKq?=
 =?us-ascii?Q?HNGpYB+jZ3KV/I2r7MVDTxvIaTA7yHPytbmqvZKhUWqnq6j57cf6IhvIYMOQ?=
 =?us-ascii?Q?fDb/sHd0yGqMA9DYSXd19yMmEhtf96ZZFnBjUx89j4vRjHr8yR//YI0NGk/G?=
 =?us-ascii?Q?7nupOliMVoahLLt9m8siOKP/Td2VlkqH3vGVq9hVCkZq4qwBb7gdKYWnVYS9?=
 =?us-ascii?Q?R46y2/pvH6WdN5ewtq54enBr9bR9yTLcHgW1Zu2T3bVC2Dh/qrkSvuZMytXH?=
 =?us-ascii?Q?l2Z8yFFApjXioWSg8MaPvBUOBHhPYYuj29diNz67iZ+s/M7zfQ41La9ynE2B?=
 =?us-ascii?Q?Bh86xa80XL/Mv4vBi6riF/XepdNsQKUkD6IzuvEgxZJlSWBswzASWKQmm/mG?=
 =?us-ascii?Q?8+oOVoQP3PaS/yh9+fNAjzvdj+SYlaz2RU/RqUPp2roCyaIn5xJKo+zHB3Rq?=
 =?us-ascii?Q?CMWCAMHstA3g3T7WT2UGdul0CF7+UJTtzG6PjKK8Z/tGakYaYoM7EvksbIM/?=
 =?us-ascii?Q?bI/7I0Kzu7gRkkWjh/fhSEK/egf7ZXoQVQ/G9z2Zgp7XQDQApjIHwrq/9rEz?=
 =?us-ascii?Q?KuP5P6FD0CLcO6f8mkh4rO1w3kAA4J3yIpIoDC/8flebzG4yxIwRRH21iT6/?=
 =?us-ascii?Q?DShtEVUzZiEM1fxMMyGcq9ARnKdRvfVA82dnqb9DPI/pg66QMiAUxtOhLvqo?=
 =?us-ascii?Q?IPV5uWCexBOOq8zBikWV01sq3n5JnKMpJcGiXejhdrM548ZDsGE11RqBJl+z?=
 =?us-ascii?Q?AGBWqJq+Y4f1avNV3dGeNvInG3+QtpKXR7VAIQpMEIBKbaVNQmdPvL2jBr2o?=
 =?us-ascii?Q?cfT3z1mAuIgsxoYW9vHfrP8QE0sRSIr35h3rLSNp+61M8AgdPF3favB+9PgE?=
 =?us-ascii?Q?8JgTFmbkxAXyUI2chG8GqVzGXqTZ/i0o5/iQjIy/kgk/IpWVeAxxsa9hLCyN?=
 =?us-ascii?Q?6tnzvpX/smvugEHf4tIAHMubdfe/pwI2F/JQL+p8W0EsGOaW5lTMdCADjrNg?=
 =?us-ascii?Q?QshxC50eZslddHf9Ddj1w+GmC4c4W9mBAQmmexiuahBtM7+tlndxEs+AU9Od?=
 =?us-ascii?Q?AqvsCaGfruMzSFJhGANIUuxSuWrnu08OFBWtIrUE2NBu+Yu4Sq/+ALFbkWMh?=
 =?us-ascii?Q?kkjOiehWRAoX3RTlyofe0jI/kcdeTdKVIFz4ozZssdLnwzUY1YHv8xo6hGcZ?=
 =?us-ascii?Q?NsJ6O9PGhIUMGpGN7QYXNlR1kqbStG/3RHf30L8xyGO1mTSh0IDNReAcT9OJ?=
 =?us-ascii?Q?Vd9lq99ankR8Ntd7APvkeU0EJxNiJ7XllqWEM4N1ke8/j0LuGJIMOWnhRg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:43:59.1139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 690a9de8-b5a4-487d-a70c-08dd7c1b3175
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7844

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


