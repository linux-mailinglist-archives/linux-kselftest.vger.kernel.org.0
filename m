Return-Path: <linux-kselftest+bounces-34738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C940BAD59D1
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 17:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E5F73A8886
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 15:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728DF1A5B8B;
	Wed, 11 Jun 2025 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="X1uEzk4k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012025.outbound.protection.outlook.com [52.101.71.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451DE1A315C;
	Wed, 11 Jun 2025 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654552; cv=fail; b=Khic+875miopqwqM/Ra8yKj1Iu9DOm9Ht+pqH64NrSIryDvJEs7ceKSw6dnRc9HBFULID0qRU8CRJOaNIvl8zUTCx91mMwgXFVKqUvkCKpPZB4sh33020FclSuk04VI3OpCkt6G8zzwNucDqmnq9AnJE0oXMPiLrl8EXWbvfYLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654552; c=relaxed/simple;
	bh=UvrjHyQvwMMKu+ydQjeNNzpfw0jebxZNRAg6Yv+RsUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qiEFdpIZpbPYIEcM/vmCsgYjBuHm0oVTNN6M9Te5dkYCiwm4uSWxTi7dj7AB90y5U3ak08NR5FjuO87KgNAwQez3gfwPrj138xzLE2Fb0eDGw48IpOqbPZjjrX3o9JfAs4D0f5AXaVPJHnP0wEp42VMnOm/e6Yj6N6/RhxG46Ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=X1uEzk4k; arc=fail smtp.client-ip=52.101.71.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OmnGUHCU1+FXT140bm7eyTh7MaCc+ipRjjp3xwHCTj2zwTn7/3OtZgzWY7ARCudfrSsDJvb4/vF+D7yUpw6MD4RuddeAqMRTxAa6vKqVM+qkyMwcZj6UjUO3UiZqIHP4Agxgws4VSEkTi1YpOD08vhDyFRFqMx9+AWDTU+jyAtFZIUy1+KJ+oTKa/OruCQ63NKhiP1zjE/bc8NPEVJUEIUJQZHnBoKe0v3/UCQxrA8NsdvfdDjc74VVajhYC0iSD5nxPPmjlpsHKQD0ns/4FqYajz+LrxkD6YtgGQrY2xPotOfgejRpwY4E5IrJnW9e2D8U7few/1XnpxVA9gylkVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgG50skLVY3aVDgCGcIqWujSRWT/aldkRftaCV+XMwA=;
 b=ancUtbgEwtERWeGDCW7ztFHKpaoqYv1QQaLDOXJs7IF7kOR+ytlKQo0sdf8zrFCv93ZCoww+CSUlkhiWntPJaQ8eVvJ14Af5dVaFfoa30oLw8QHW0Yu+mo0Dnk0SkbYloU+7a9WJxpBQxnxvMtMwh+qb87hw5ykBRr7VNnU6aEb/m1OVWLjSiZseqSF5pDmkU/XyI9FGjUk81ugo7NpGx0QHuSEMWk5RERSD+ZCh3oKmdtBPohIZ0R047xmn2gmmNtl8WsAkmywkX0E/K7cqiN87CYO/YepufFE9F/Cf66tEZoqdP/CND6kbW87tdaLELQvRrWthQQS4aL62i/jgXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgG50skLVY3aVDgCGcIqWujSRWT/aldkRftaCV+XMwA=;
 b=X1uEzk4kMjvEIhQ+DZxtLmCM3W8eV0RMh9b5FOqLV29FOLkacnewo+WKNUOCqtIpsZB/d5ulLZLwxCOh/cbguTzQ+6GqoYpTcvkoYLJE6sAYaKmApbbYH+jWQwJldm6KvHrGG0mGLWaAsDKsOBKe7gO672A5fwehez2pkI1hyWIS0lA4Ipcfz9d6lcehfhwaqd4Wgv/A/ml8j34dM/qWJ0oofCoAD2+X8rgjyBRrgxPDPvSkt8XkCnpkZnluTuDxYfTDUOn2ROqWeAtOyquRMkvYNZi2csQzOsFOl9lVbJJPlHNKhJgq2L9+jWnfs9PTbJT6jltebnA3WRp96eGkyQ==
Received: from DU2P250CA0017.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::22)
 by PA4PR07MB7646.eurprd07.prod.outlook.com (2603:10a6:102:ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Wed, 11 Jun
 2025 15:09:07 +0000
Received: from DU6PEPF0000952A.eurprd02.prod.outlook.com
 (2603:10a6:10:231:cafe::55) by DU2P250CA0017.outlook.office365.com
 (2603:10a6:10:231::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.17 via Frontend Transport; Wed,
 11 Jun 2025 15:09:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU6PEPF0000952A.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15 via
 Frontend Transport; Wed, 11 Jun 2025 15:09:06 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 6608020094;
	Wed, 11 Jun 2025 18:09:04 +0300 (EEST)
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
Subject: [PATCH v17 RESEND net-next 4/5] selftests/tc-testing: Add selftests for qdisc DualPI2
Date: Wed, 11 Jun 2025 17:08:51 +0200
Message-Id: <20250611150852.23218-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611150852.23218-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250611150852.23218-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000952A:EE_|PA4PR07MB7646:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9cc07a4b-ce18-4a51-12ba-08dda8f9e8bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hMZfz7KysGniywQ9MGo794jS0iibAwSC+nDDETseva+hAiVfgBcod66Rsz9V?=
 =?us-ascii?Q?8X4i059TKW5qIf0lrR8CoyxtjDUtPJkZiCbqE76E18hVhGTHT1JWLq1EIJCd?=
 =?us-ascii?Q?0JqgxMa6laEiYWgibvWiFb1hr7D1K1SFMYh9dR0XteWnBQLqMGuF4VQj+ick?=
 =?us-ascii?Q?zEssOCDboq4Ayf0FkRlcHjGBqrvBEVCT/ujn4mr7CYYFvk0xBgmubJqIkWsE?=
 =?us-ascii?Q?Wk7EVfXdPplIP7XZMA/5in77ZUoHkYyv9VDXCyKvRsV+pvghnAsLHHTWXTIk?=
 =?us-ascii?Q?JZWhhNAF2o5VQRJIdkteLvub0sbdlJaPmbWmWVDl5WFcpcco2MnmeQHDeNLI?=
 =?us-ascii?Q?9HKPxQmIHmzcmu30/JUASAxu8g0k3jtYfzK2uPbj068J1OR0SvOHhPK2HN7S?=
 =?us-ascii?Q?CbhxghUUDWxIsMoS//F4WTWvpAyY4WkQubYQ3f0LC+8NGH9T8iNyajIZ+q1d?=
 =?us-ascii?Q?jlD4FQvYjLPMPqk53Uab0pw3S9Nt/v1gttT7372/Nd+HtuRueWtrbBCHpwIb?=
 =?us-ascii?Q?CnrlhN7aBHc4KHWA7QjyJvtsslTtldcfIYFcDqAPnP+BiTyDZUa5frnZotpv?=
 =?us-ascii?Q?rhl3GKc5O2Spz3gkbbWudkv5glfiZNxcR+p71AOHEUVPS+gkSTMX0JTs6tG1?=
 =?us-ascii?Q?6j+G/v8tjD7+KVhFAIT8wJwwV6eKOWXI5/YTjDd5vJ6ih/39lG9lAFqpaNVB?=
 =?us-ascii?Q?KFOWiNtMh70LXj+WgIs87bDwkYkljP0+M3VKtymmb/u67GhLROSL2K6SfX8p?=
 =?us-ascii?Q?3hwGoGTaHkHlUKIDmlXMXpFyZ66gqL2/DghasyzlHrPz96gQMwHB8bkRRz1Y?=
 =?us-ascii?Q?6ETkYJ5JMpeihl5T40L7Lp/QF/OiNGtug9xZ+mjo8AEX7vBMYmOKUr08z3Eq?=
 =?us-ascii?Q?NhOsScZQeFn4VOAfvGiQYk6HGvA78KMzF1aXAvxC68Hg6jIk18MkXhUJolZm?=
 =?us-ascii?Q?wUb7zuyZNOEoQenidOJz5qyxza1TagB1K4wc8FlH1SrQmMqiVCzy4SQMIROd?=
 =?us-ascii?Q?Vv0FQB9t0nv89DT8ZyzODN2Yps0+mYNt090744Di1ULkmc190B2BbVAiy3Kt?=
 =?us-ascii?Q?u7ovwxQTeSg7GjBA57FNGCo68itWCIYkHtLUcUToS++xGMh8g2CCaaCndAHw?=
 =?us-ascii?Q?dj2BkIr667cfdqUrC7WbckHjrz+jIkrBjUnUOj2RCPkWMoX4Vq4KenzVk4e+?=
 =?us-ascii?Q?AsCjnvKyRgS+teCeHDOydn3fdVbewHNEdWQBvWL/OSnu2bKOnkWge0GwdNSQ?=
 =?us-ascii?Q?13KdGzmhecvvNEJ7lL/DmjH3W53YLM5ikPpmJkpGpTtap8S54qS4Uh67Vsbm?=
 =?us-ascii?Q?82BkUVCJQGkIvVs0rv5KkQOXuqergzoBKKVNMzLQyxLy/R174l9+kRiau6Ww?=
 =?us-ascii?Q?r+qZFl+onIEcR/j25TopvDTNy79SDrJ2tc2HotWoPqURAIDkfJA9ROwU8eHn?=
 =?us-ascii?Q?MQYo80Hl3xSDx1XIRV5YDEpNFPDfB2vFwJUDptp3rB1IJvVJnWVlQhRjeN+C?=
 =?us-ascii?Q?ce2EmifhSrNQISfrOg6OBfd9pQKC0H69FiWRvxBl9kRfBloVAV1b6EITSw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 15:09:06.0318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc07a4b-ce18-4a51-12ba-08dda8f9e8bb
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000952A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7646

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


