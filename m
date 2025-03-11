Return-Path: <linux-kselftest+bounces-28682-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15979A5B20E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 01:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8667C171768
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 00:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C4217BA5;
	Tue, 11 Mar 2025 00:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ZJ1erm2X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17705680;
	Tue, 11 Mar 2025 00:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741652148; cv=fail; b=FGxfpNL1v/uS6nk80Ad/XpHwGGXSryX54XBp+SXscShu2qi+RGVakMxk+fSbzRudUgrxAKa54gxZv0rurMOQYh0QYWjo/zcLuSeHQ7IjXa31ymJ+8qPEWVSz33Is4vPIX1dJKCHHQg+KqNMLIjh3eC5vbwdn6ZdMl9gegL1Vr/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741652148; c=relaxed/simple;
	bh=6NwKGOPJ8asxsqOZA0hgsCIQXbsdyUNcBRhPazaM7Fg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnPLtoL2e3jsCH0rJBCExD4XkDJcYI7+XG9M5wDrV6sU93fxg5z56mOiMBhIXHWknNcrlygO+0GkEJkkG1mEo5ctBg+8FvuDJfNnmSx4gI1EZT4oMnTULQRIY5sG81ohxp7+tajxO2L3mwHBMfqmdwlg6LNxMzEFPWsg4Jk9mLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ZJ1erm2X; arc=fail smtp.client-ip=40.107.21.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jm5K5TYEG0lz+PkvbEEflv7q9S1pgKlgdgQPnLHvEn5lPNNSwT4X/6XfHQKF6JW/dhWYwOYzRZtxS2FsnL8iEScRdCl2nFdH0nestGWhwxNRVKXChfGwvo3bBkKiXDfDn8dqLOuzn2gCa2+6hYq7OtRCbwAWwlkRgWCYmoi0+lEPbe1vPhCWAXCsCx9EGMREzy2YIBUuFAtwqZQeoLLfxjr/rESnFsNQwdJJYw+3KBuaBWtwOt6ZRh4dqdFe0Ilb0qMdlEw0N7Do3PuwKbQX5vs0+5GomcDRfeyDi6s7BKSQURRvSykkv7A2rq4AHPO24kGV432dVRsGN73KkP4zXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmxEfDSqhYSMcPij2RNNEIX0ObyhqtzoghHADLcJBEU=;
 b=kSe4w6odSAFz35rh+VhSgDdG7EdvLLqsO0taOjNzBnJoCO3bT0WOwRMsfL6TLbAqCKKJPr9FYU6QuHG4Fg7iS9tc112iKZMHO2nJv5fbIwMpU0vXtbhn6NbGwX5hQe6W6/sqAeEoDnwPcgFHCkA6ULOgMgO/h8iNr8+uEomm12Mvv5M/g2CuqOIsDJ1B5q/SMVwY7lT6od34vvDfqZx6b2tyasab6A2x+LZRf8F7hoerCWui/5iZnuW5PhMFxw+vBGRRiLj0mpOqgnZ1877dkxY3BBXRF5WuoAb487P2Vr/kA62DZJyn24lwdB513HZAfye8fMXSUHKWhwWyLgcElA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmxEfDSqhYSMcPij2RNNEIX0ObyhqtzoghHADLcJBEU=;
 b=ZJ1erm2XDxrfoB5NUsvEFCHYCUU99wsydf6m1cpzy9Erv0Iu2Sl7b9TXwOa4GTYLEuOufSvu7/Y62AKKzW38caLW17VDUT4PgOtWDS9ILrr48IOdQzTS+kfO1aj1MSPc3eAWo/faD+60UibVWoNDCVTqNpZ2Ip4tcR++cNJvv5tM0jficDFMgZdsDKCwn53T8vkKuRDwCw3SN+U5uVW7hU6u8MAxZC4UDvVBIC/H4CjH8jxS7fjMY3be0ui51YnTxUL4hseWpp+zvvwf7XncRho5xfeku/7hEJ4c9jSNKtwnQCJq+bGmzcG7DBM1ocWQUoEcBRpxl2fVLbLJ4EkvsQ==
Received: from AM9P250CA0027.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:21c::32)
 by DB9PR07MB7692.eurprd07.prod.outlook.com (2603:10a6:10:21f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 00:15:42 +0000
Received: from AMS0EPF000001A0.eurprd05.prod.outlook.com
 (2603:10a6:20b:21c:cafe::f6) by AM9P250CA0027.outlook.office365.com
 (2603:10a6:20b:21c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Tue,
 11 Mar 2025 00:15:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AMS0EPF000001A0.mail.protection.outlook.com (10.167.16.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 00:15:41 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 52B0F9Gq007427;
	Tue, 11 Mar 2025 00:15:48 GMT
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
Subject: [PATCH v8 net-next 2/3] selftests/tc-testing: Add selftests for qdisc DualPI2
Date: Tue, 11 Mar 2025 01:14:46 +0100
Message-Id: <20250311001447.114579-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250311001447.114579-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250311001447.114579-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A0:EE_|DB9PR07MB7692:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4bf93e23-ae38-4591-bfa0-08dd6031dc14
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?ppHmNn+87vnFHLKEf6kUMf9zJeH6M7nl5jf/JGON7EEWe/NqgS6VGxwWdBoL?=
 =?us-ascii?Q?ZE1XnPo3pvqUASjGLZs2OwGoRvhAcpZL7Rb4xO3GabkD5NFqF38muBv/Ncfd?=
 =?us-ascii?Q?uqGb00faV0hIvCBvRRXlI+5qD2KOqYUkizhyGImoFME8DzO5NFddFqjYMptC?=
 =?us-ascii?Q?cuoY7qlLQtmyPFRoxwT5UMXVdgsWMMOS6xh5wSUWzGa/K0jh4FElYvDWcB3r?=
 =?us-ascii?Q?10SG9zPeCHqXQfEfjkb7HVBXjE8kPbRoipzHWi+6ASWpLKTwauvSCRcwsicq?=
 =?us-ascii?Q?2pveFqYpVv1b/rHCib9nWR871IU0PQPC9/8vQWPM2/LJFNVciwg53LhCVZ57?=
 =?us-ascii?Q?y7ji7KdCU4O/oG8sCLkpraXBm/rqPMC40KYobhz+5f0JKM36FN8/TM/Xhy/e?=
 =?us-ascii?Q?Z6f2PoXmi9SK4DLqLm95OUDfGV85AAzjjt0eUpmJ9HRX+LvdeB3pFLAjLwoh?=
 =?us-ascii?Q?QJO5EEEuwxAS1ImD3Dn/K1/JwK+d3HHzFMK7T94B2rf4A9iUKj0X3IISZ1jX?=
 =?us-ascii?Q?amXCQtUc1KzsLoN6SlZ2jcwE2RDMcLAs27na7j0lZy6DBkZvU0UQEF+7ZoMM?=
 =?us-ascii?Q?lcdM3C2RrE8FT/8h8W03rn3v/oJ3oKS+OUgxxlaqKAZetlbwxdv0PnI/D+CF?=
 =?us-ascii?Q?BRdYEaL3b8NDu0X3doxp/GJ9ftXQgE1k0uHYjW6f32Kb9PKGrbtbBFy7T3lQ?=
 =?us-ascii?Q?QBQZUdPCaCyku/Pykzl1KnlCQuI6xV3n8TcvrVomaHhbe4VyHmjNIXsJgV7j?=
 =?us-ascii?Q?kK2VOPIpr4BR501eK0K21ocMhFl8SPt5tQpXsEZZSL0Zp1q1PN8Bjcvbcxm2?=
 =?us-ascii?Q?qBOyhmAm13y8oSi+sLKaKDbtX0Xcf/PaT4aDluCldT4BEBR7AFJELFPV1QiA?=
 =?us-ascii?Q?b0aWxk1FneMYZyoOoV1RjpvDS4NG2AgscP8zKmHjcbMOoScAClGtSTVLEQf1?=
 =?us-ascii?Q?0kT9mSURnIggkyElJv7lV4Uri6uByaFVQOW7fOKy/4V9XrK4d1U41My/NUAG?=
 =?us-ascii?Q?hxJaTLTqkUfacA8SDna5WmOKNaWLYJwN0ClZ09JvIxw6cQEO0tWMIljK7a0e?=
 =?us-ascii?Q?IQ5gEIMMsAzGJhrHdkDjhtKvlaLuqHvqIoPEhbV4DeBuyutjqKNJzhUiBibM?=
 =?us-ascii?Q?VgXLLFGrUWoMDh/r3W605gjdgDnZkIL3KHa6yyHmgjuv/BTCeDv5IGXoufNq?=
 =?us-ascii?Q?Hoq5VLCp32dj2zz6f5uviQTCxcwVOPgDf3iG+Gx26lJ8IFekhdy3FVSC+NMK?=
 =?us-ascii?Q?O18/axZtSJwEEdncsRmvtUgrp115M5khYSWJWvxAUcGaEsnnt7XcOkyBsFeq?=
 =?us-ascii?Q?AYQLy88bKeCIwGhbt2pHjHjetEIWqAhp4ZfWeZ8ocKiK51U6Fju2QiIgqYr1?=
 =?us-ascii?Q?qwQ2xZPC+GcCLymJ9rYzaE0gRlt0/RML6vXHAaMKdl0WYtZsH35ImtFwPj2O?=
 =?us-ascii?Q?kFzD/+jUcyTL6fBlLDk+aiVkhbaSKSgmTnEcFbK3X6cqmCHF8p1HHBARM/5H?=
 =?us-ascii?Q?egPtNsJCNdFZfVM=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 00:15:41.7708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf93e23-ae38-4591-bfa0-08dd6031dc14
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7692

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


