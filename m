Return-Path: <linux-kselftest+bounces-34583-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C37FAAD38F6
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 15:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2FC316E702
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 13:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CEF2BF3F4;
	Tue, 10 Jun 2025 13:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="N4iXYNOZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011017.outbound.protection.outlook.com [40.107.130.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1318829AAEF;
	Tue, 10 Jun 2025 13:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749561384; cv=fail; b=qFuTOy42vq9YHkhmGITA96KT7n96/1OpFsOf1BWfxwKAZjSU/+RXOVJg/DUqD5nPvlJtIFV7iqyKnr5y/A0VyhPlPgY2Pu8Fh/WOKwqyXHLJM56vtp3q84aBRt9c+kkGTRhiGGJhdXhXe3U8W4Tw6VUGxe+rqRPPw72hYkFYq5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749561384; c=relaxed/simple;
	bh=UvrjHyQvwMMKu+ydQjeNNzpfw0jebxZNRAg6Yv+RsUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qKSc1RQmpqpCBkgShuPCNMnpQkugn90mDe34wacx2AO3XCVM0xA2AR6vaAFkuvazQHcjvOj5iqUWjIGJOom+fGFUt0Zy5v8Q21S+2qqtCvqGmDuJgRoJtQBc4mLDUQH5PY/WdnUNO9Y9pIzZvbFhIqImev5KBUDbd7/HiQIp5Vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=N4iXYNOZ; arc=fail smtp.client-ip=40.107.130.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m1grO3+V48/cA1t/KV+bJ/1r6+CB7Exx7U6yV/Zfsf0BHK5FVH3VjV7WTr+1w9pGqOWY7udkZt3nP8EAbpdtASUhCzW+9G8NwKB7QFJjy0ucl3ydY821dhrjO5Q3FeTL46sy6Wkr0L49L3u/AnWLHli4qGvioveyohXnrgzfi3R/z+/VbiD8QljG4TUPc5nsx8AMmO36dFClJZ0z/laTrtSrG7rB6Fqp72OpbJjxJZzkjJBdnzuAWKZgB4vEJwTmd7U2ey5q9zd3Hvdvy5DvzD0LSKqW8upRyM+HCkyypwuMkgtkbr2R1lO9evQg5Q2dxoFHuJCCcdN2bdBqzkVNzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgG50skLVY3aVDgCGcIqWujSRWT/aldkRftaCV+XMwA=;
 b=AG28VMRKCeyC+EaHC5OOh7tsDMdxFFHh6wrAkofAIPRRbWpysT/v86SC5mMUZWpgtRQXvVpOAsr9oiiMM01RDNAvC07ENZU4WYQI9ru+/wzBw8Invy6lwE+fLGhfnIUd0gjEKhDOcJ+hPwC8hl0d7VG+zIQ9iMjYg4KA43HuVx1fjU2A6lShisX2fxtSuLQPwgXW7My3V6tK4gMAFyUufEaJ7odwKYDikApL4bcZZ/kLq5XHaHtp5ZyICuif9pGeP5y5yKMuXJwuhgA2ZHrr4dyDt/Kps8OayvqihNOj5iWFwMj+dUbsdn/lsMm0POISwsQZPZ88vminVjz9U3ryzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=mojatatu.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgG50skLVY3aVDgCGcIqWujSRWT/aldkRftaCV+XMwA=;
 b=N4iXYNOZw8rUw3ZdUj+BPEgcVEfC0ZhtVgZn5oxP8KtjsahjxXa9IMlp13ZdiFxMnjni5wr+N069jxL6c9MlXvubmK6Nopef0WiRYWiS8uiWFV1SWGDVaObxyAVBAtQHpXp6df4d9126UIl/7/lQVCHqtQGQMYqp/875DrC46hZMXPiUMSbUGM5SKltAGNHcDUXbOdwqYv8M9DusBcb+fesI/C+SyRaRVOK4968tXHQa8dP/nidDJvMaLvb0b7GN9iCnsKP9b//n2wEOapufU0y31KnVmL8obHtcJgT6dtNTXuc4JkL678n7EzmoDpYOyoFvazJRvP4Ljm8AKMRi4g==
Received: from DUZPR01CA0059.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::13) by PA4PR07MB7503.eurprd07.prod.outlook.com
 (2603:10a6:102:cf::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.27; Tue, 10 Jun
 2025 13:16:17 +0000
Received: from DU2PEPF00028D10.eurprd03.prod.outlook.com
 (2603:10a6:10:469:cafe::bb) by DUZPR01CA0059.outlook.office365.com
 (2603:10a6:10:469::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.17 via Frontend Transport; Tue,
 10 Jun 2025 13:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DU2PEPF00028D10.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 13:16:16 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 55ADGITC016767;
	Tue, 10 Jun 2025 13:16:43 GMT
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
Subject: [PATCH v17 net-next 4/5] selftests/tc-testing: Add selftests for qdisc DualPI2
Date: Tue, 10 Jun 2025 15:15:37 +0200
Message-Id: <20250610131538.18777-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610131538.18777-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250610131538.18777-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D10:EE_|PA4PR07MB7503:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: df39ce9d-a370-47f2-1e09-08dda820fb8e
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?r6f2joFImBRaFfMA4gDJxG32jkghnsSEg3+jSvXw4XRKLnnTsm55wQW2LhXM?=
 =?us-ascii?Q?WyXDgLwiNMVVGAlmYD4Y8Dw+gcpWs5PNx8PY3paq5Mgsl21rDlAmgyFNMl+r?=
 =?us-ascii?Q?uNDw/zk1PXpIMvFwXgEbVDdBDkO4EAs7Ub3ztxhXvvfdJUmzjO5Pup/UAmfn?=
 =?us-ascii?Q?sdNZ0iF8DvWgLFpsFzq79xy688ZgjzKrmhdlgyOMrBwF5qH8niPidZnq/A9F?=
 =?us-ascii?Q?qTIEA0IUgqd/L/WQQcktfiHux7rH055ufcRuh1X7AspaA0WgMsS4aMQG2BI9?=
 =?us-ascii?Q?wM5wEaWd9Qfy+njs3ZYjJQAyYCQqCS9xH+ucx4YqmYHvw0wjea8TTLqRiCN8?=
 =?us-ascii?Q?NgHiqug7ugupdPyUEvK8aZ7CFzjBTYNMFX7XOU2D2nXMe9U6QQCcOyvefr/5?=
 =?us-ascii?Q?xHcRNZbvZzTXMmYn23yOxGhXwOLTRWWH3W2AXmDPTsZIw5Mu4k+PMMp1B7vh?=
 =?us-ascii?Q?wIRsKkqS5DegO2UcYArUckuLsZ0/8Tqg2nZkqOa35LCkTCgE6YQOUAoq1eSP?=
 =?us-ascii?Q?jr4BNceUZAeWO9c7/C+GC7TPvfdcobrBgERbNupkDzanARFJKXg59nUVc65H?=
 =?us-ascii?Q?ghYr5lsFbOEK6JzoptZqm2zPfrn5kg0vW90BOyE49JyePi0HIeBYqYDRxo8W?=
 =?us-ascii?Q?NhTndYlwGsqw6bV18CS4D61+4HqrgP7CB/kJofbSY7eJcxkL9TIA7aUZdLhT?=
 =?us-ascii?Q?rdliMc8bzbKMH0clCk3pTgv6aEfJQ5r0yWfLjuwWK41xTfomvjBD3NuEd4Mo?=
 =?us-ascii?Q?owu0NrLtqZ/sDovRdPxtO29EalN2u61dfjxCbGpnVLUIS/jl5qlj7f4gBWdx?=
 =?us-ascii?Q?9GacABbuYR7kGTTrDA9C/WNWcVLxXNbZRcl5eDekzbEz3eVK0P96WMh069Sr?=
 =?us-ascii?Q?Re1xgbFQO2XAcRO7vGBkV8TdBSSEfN9fiviamkYMBBibtPqhs3e3yiq1+JGL?=
 =?us-ascii?Q?yvMCz7wxY4QaxIg0uLduLSQa/IC8Xv6viHD+oVbjyd/F5GFCzQ3bXF13OvYP?=
 =?us-ascii?Q?bivGiXcEHkUPrbpsV9IZZ6z9JjYoDKy8wOSuzRlOXJVu34Cw48ZvVM8vOkWc?=
 =?us-ascii?Q?l/vHnmtTnkQiXL8gWvcHU42g7+UStG0uAlYkhMl5P1u0xaRGWwv6ah+wjOOq?=
 =?us-ascii?Q?pCmIQiLkX2gTTwbCUNRtKlmQhaDCRWqoEo68cby8QeKYZUiGuRhXI36Ts9yI?=
 =?us-ascii?Q?J1JtKy1wk7ZFxFrkqVBV26FXwDbUqkgown3BOXRInlZaeAnvPeVNNeZHqE/Y?=
 =?us-ascii?Q?iqCOVvd03XaHjDbz3cCEEmRy2Gf6JuLOP0YSeBcdq/SvUZBObPrrHxh5t6X9?=
 =?us-ascii?Q?PZ99g0w6vMVzN/enbz6Vpoondh3ZWLvCvEjx8sK4bkj15/81sHlCOfK5PxVi?=
 =?us-ascii?Q?FjzOfmAuoNJMcLiDGd3myZAJ0zOYKCB8RxXqDpro9VAV3a6OJh4kdELttClB?=
 =?us-ascii?Q?3FEGP9jnBQwNeGnIXLQZyrQDndif3f3zPFw7XcGryxL/NPL5o4LK/UazJkbq?=
 =?us-ascii?Q?60mkDa/O5esEp+eDCDXFCXQvkfKZzyXLlxrngb7Fi3ygrORLIyBQQwScFA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 13:16:16.8077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df39ce9d-a370-47f2-1e09-08dda820fb8e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D10.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7503

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


