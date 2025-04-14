Return-Path: <linux-kselftest+bounces-30683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F261A88146
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 15:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91DFB176D2D
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 13:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B742F2D1F7B;
	Mon, 14 Apr 2025 13:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="e3+dg0zi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2059.outbound.protection.outlook.com [40.107.105.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8CD2D1F63;
	Mon, 14 Apr 2025 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636346; cv=fail; b=hpTZGlGS7KUR7DFI6bd3+4jiSNxNnfZoiUpFlWZStK1d5iH2EneT086dh9Jk2QsQDifIF6BEDUQOTVRGJ/Kolzq+HyNbKXyTiqHrKTXOKNNLZPBiqBDIaDYT3vWyl9AShPvHzQkMxbgLiH9sTewNt+aUz4sMxETpSeuEH8K0tyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636346; c=relaxed/simple;
	bh=Qsku5tX58nzvcBjEl38SBdC5SKdfWDsit+kkLSrh8dI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=njy+TxzVPPw6X2rdU+f/uXeqQCmWovM6gjtlyYpLrmnli/epKe7nmWCXtuFPatQ+Mxj4qyuQY3cv2+lT1MAdMcEIMLoYFs841po6kAPU3RJ9eEXxtoEoZDpbfWBRAtIGoyMV+HYF6tw/LPbyO2VK3YAmkhu49OJR9K8QLHk7aVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=e3+dg0zi; arc=fail smtp.client-ip=40.107.105.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJfazDvkMxNmtvg1yk7AlhWgm1WAfkEYh4lTk3vbjb8D7XkJGOzyeGzuqWD0DgthL/7FtznCvNdl19A63iVRYiLR6BzbA4/eUkGh6zVSx/VAbMHr/pICuJ6RS3Sy8GqeavuMvu2zFH0zUGun//4F2LhrWabHOfqGu+FTIvR7iU2Uq7UBKwCDpp0Bcrp/E4RD1RxxScg3CWWid+n7eXM3AGmDUya3AG0DKp4GLMnP53DG5lau0QlzyjMV2VzAg+x48URglzRLdwgYMwKKmRSC1/X1j3L6U5st2SqjfvWX22L203kmGkJgjuUW+merrmFRm9n8NMhIlYbdMTCjaLpwFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLD5KOy1HvbdBCncUsYpNw8qHd/FqTsg2LKXPKcmRGY=;
 b=uikpMQKZbN5mVubYxEzH+UcbYssmwDPrkWFRIsBK8XKlngLz6Fm/jYn2srB7jps+Ts2Ch5XFuYdWFqbaRYNZsZRyiHGHpRzNarm1pEugO8nFLHCqQcE4lPk/5jYLkV7te08dMeFCimXclMg8s97u1uFHYjTNfMSaKAW0MkzkVW1Mo0w/zu1fvBN20x+AltBUFXjA+KV9Fyac2lj95w5c6SWT3YbHjbTLotA/8icRnbJXQ8j8Om/ohPq8skqvVrIPp7YgEdZDK/W2SDq5DFNKYhX/Nxf45BQ/BIJ4pFUCgF/dy1W+MCep7KzJIUJEKEO8POHcTR3mB4ko0xHarn0DVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLD5KOy1HvbdBCncUsYpNw8qHd/FqTsg2LKXPKcmRGY=;
 b=e3+dg0ziPENi/nFpWWjazCenbrIt7Ri0p9+KLgrkeuX5WwEZE79DIlNYkcSi5HC1ZdGK8kwzHveChhDh3rP6gJvf6TbJFEDyAaej3bgy3U+nDTwohbYkP9v4nIk4yEvb029+r5xWsYb25P5FQWl5tIMwQfukuF4spSn59I6UPtvkNnJUl6SGGsKGVzQYGL5jnOhZgwZPd7U08XQf1XBPxXAy4VmBIPZlO5kmjxE4Kfw10cGZWbN57iuCoOu0GhkYm9Xz2mbF5NLWOINmHKl8rFindtp7/3E26mE+4zA8Z7jrLFCNrIdNF4O7BA0mPCp+32aKfN4hDFh/ihyMo/qk0A==
Received: from DB7PR03CA0107.eurprd03.prod.outlook.com (2603:10a6:10:72::48)
 by DB9PR07MB9833.eurprd07.prod.outlook.com (2603:10a6:10:4ee::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 13:12:21 +0000
Received: from DU2PEPF00028D07.eurprd03.prod.outlook.com
 (2603:10a6:10:72:cafe::91) by DB7PR03CA0107.outlook.office365.com
 (2603:10a6:10:72::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Mon,
 14 Apr 2025 13:12:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DU2PEPF00028D07.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 13:12:21 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 53EDCIJF000852;
	Mon, 14 Apr 2025 13:12:38 GMT
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
Subject: [PATCH v10 RESEND net-next 2/5] selftests/tc-testing: Add selftests for qdisc DualPI2
Date: Mon, 14 Apr 2025 15:11:54 +0200
Message-Id: <20250414131157.97425-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414131157.97425-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250414131157.97425-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D07:EE_|DB9PR07MB9833:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 38c8c2f3-c2dc-4389-7b9a-08dd7b55fda2
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?UofQKe5K2qkwQdkTLhfugRNSq6WTc/avSUXriXTHr5VOKIZ3j4lzR01pty4l?=
 =?us-ascii?Q?t9duPj/HgpH4UtZDH19J+N00KzE6VBWQWD2rubAp5d9sLUlZZkFkVPddNzB8?=
 =?us-ascii?Q?TnrW6nfzohCykb4jiPHeQdIzuYjxEEKHaOSvyeBFlHMoCdpPupDLNcX7LUqe?=
 =?us-ascii?Q?49hXeeYrnAcXI8nGY2UTzTOlCw0QXT02tQ4bIHeivG2Dr16eYMhnd2kKcnt/?=
 =?us-ascii?Q?N3W1AaGbkjciN67wlmrR8IcyEAKpjhwV7CnRnmpkWA0T64V/vEXH1cj08AHH?=
 =?us-ascii?Q?eVBzBXHP+Yz7RQ77lCy0FDQJ78+CeDtXCterMvp2s0lUdHwyAc1jXjw5czJX?=
 =?us-ascii?Q?G1azxpjuqxncFrAB+yMUvdfmcvWQORzy61enSb5RkoLz3E1HkqoJnaG4mlfO?=
 =?us-ascii?Q?9MYtDMlfANrGAM4IZCbq0U3gpkmiXRKMPljwFcdBe+xvaHn/oBhrft23Hq7N?=
 =?us-ascii?Q?XxG/dMMarW3gIGfPHCYLDvV5KL/8o/6/2L5k3Vw3kC+E0GwLpxBb7JqLkZHY?=
 =?us-ascii?Q?T4wSOFnj+y/AFTwXWO2bWAUZScufh1iGRqVzcC5XwAF/rWjMDM+YevSqkQKA?=
 =?us-ascii?Q?Y7swXIP98tuqNKtQ14PjsMvbgh5iJ5CuuwPVxiTElX73EEjgkkRSRANZP9Po?=
 =?us-ascii?Q?CH0Yg4cFmPcWHjFY+wksgs/Rm4+DGK8/+290EUEtN7jSgVlXO7pH9FLUBcmh?=
 =?us-ascii?Q?r8bC8IyUnankJWRruJwCx3Tj+d8ai5HYI4i0t93Kxsq9Bq9ZPSzeSu7Qrj2W?=
 =?us-ascii?Q?Fr5gQMJrbmy3+8SQ3Tb9czMRMtzybM+TZkROiEN0a7okwsHxyEnz6C/YSl/z?=
 =?us-ascii?Q?A3RxnEOghlD58AMmfXGZKbP6cM4EpS6JrOtv2qvxf+WDqgNqpCc3Ibl4ptBl?=
 =?us-ascii?Q?3EfpR0IzF03Hv2+n/zFDruJ+NDuMZ8UZJokVfm8d2unYfAw/Gt1bocl3LDRQ?=
 =?us-ascii?Q?hIuN/6thLzZSvpmrOHjkAiKYcb77ZBFaKNTLnjm2p4ALmCvTGrXTS1SrFVJf?=
 =?us-ascii?Q?BGMhA86B4UmTFemJ1CffspYW/6qURpG95t7BBQqtJ8Xc3F7PnIm3/Mj7D83a?=
 =?us-ascii?Q?eRFm4lgF+98OxneL8Z+z/BAJ+rgyTPK3fzWTjjMw4y42VG8QxJqxccxV8gIP?=
 =?us-ascii?Q?vkKJv5/jLl74mU/x8eODriBGffMaSfOUDplCMF128z496FpnSua4UQfxiJqE?=
 =?us-ascii?Q?1ZvW9C+BAPi3jiv723Z3Ztr7f5z8BjefKq7bhRozOfhqZqXYqT/fNMy87oO7?=
 =?us-ascii?Q?mNPf1+9XCmvnoiYPPLuyihfGcKlzdCKVw/ltOAa0KVz4zudjt30aJqOOqQ0l?=
 =?us-ascii?Q?EVIxzLNNoN1jUiInRaP4EI762m5HKyCiiScfll2UD2fyFUbDzyi/H7Q2R3jN?=
 =?us-ascii?Q?y5JVZnDHQiYqwvejIEoS4zLMshAld/maFM5lzIxGR60XTStTGhnMjqCui12X?=
 =?us-ascii?Q?JVcN7hoftaJxMMW0MNLCteKfUt0pMgaV/pNUEDQ5g8kL8F5IqyFGivTI4zuB?=
 =?us-ascii?Q?8ydCJR0L5/57d8XFL2bdKLTd7vWBbFVs79EPRjilDnQ8yRcI9ReTpFHMRQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 13:12:21.1855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c8c2f3-c2dc-4389-7b9a-08dd7b55fda2
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D07.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9833

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


