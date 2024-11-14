Return-Path: <linux-kselftest+bounces-22026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDF39C8CB9
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 15:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C016EB32B68
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 14:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E264CB36;
	Thu, 14 Nov 2024 14:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RcnZnmYj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C133BB48;
	Thu, 14 Nov 2024 14:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731593566; cv=fail; b=k6XeKDI0mMW02c9uqPxOutVmQ/sqB+pQ+A2jMupsV3dRpHGXOzGtjo90/7L+qoZVThc/XzWBcR3dmO3EAeU2oG8Eu3qTqcLRS0LghNA17nmBhrVujM6fK4/GCpOFvXNt9uWI9t/P+e7yPvJXEnBJC6YCtlpivWBJDUGlL2bXkV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731593566; c=relaxed/simple;
	bh=u034UZiNhiJu/r2dn8swqac1RxTUeAtyHs8A0b2YlLo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DH8aozBmJMsvBLP9MTBzL7cGMX320Z7Biw77O3GPApfKxDMjqaOxcMvsK5qlvC8RFOVOrQV0sUECUBFM0Dhbko9vdOGg5M8/nP44u29PZyyHg9QjnI4cOU362VJUe2XY0X3LTzTG1oEsqBclqUi20Kbmsrf+ZcPlb8dzG3gMlNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RcnZnmYj; arc=fail smtp.client-ip=40.107.236.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xi2bqU8rL1eadMrhjAGjWnnKQ5hzHz6vRzIrlPiZ0sKLicj3xXl8xw1+1b8soaFyUlWKixpFTFNs1DXxpVkp5YixzUl3YN1ky+9f9RiXV6vTcuRCEev2lQvafX8nLJIZmEJ0sLfrc1Y6wEWdFwBNcqUY9CP86L6A/rZgtzuFy6mykdR+AMcIh89zx3tOkpbWcNSFCaIra7/1t/tZdzfaOnFWIHLaiAC93WIFZ2J/aCrh0DEpatueaBuzlkhog4/MP1TfbMLS1MH26VknBJ3q/m5Aa/VNVGpdwQBJsBklr430emvYgNVoByuUU+fXzprCpdSHo9Hp5mcUOrD8n+qSGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0knMJxu5lwi7AglwJNczxaI1E/3P2LBzh1dlVNdMhyQ=;
 b=rz+EKavLjcX+xeFgH8j0KEMXFKlbg390K/22uEihLibCe3LyhmPhoRReVjQ1v3QqM6i6J5sMdGSv4hNt33cOPVH8OlDPG5YW+0MtaJ5RRJN+7DTdure+axHtCV9m/wUNyhAYJPkYp0JGxOxlJL8H4iwD3iomEMnf44oyd8npxN9bTaqq2FaVc0zCADK9axLQsFjcmuNPWcIGavNILolK5hyybM1fyukag9kEdmVeSnwknBwEcJCHFDMbJ8mMhS0PsLyf4cygTMWg1oKfQlPo4a9NKNgcyLBEu5LLx5WyZv95PyCAoxAWIAbtkahOCIwEfHO8KpepYJvPxHJG13SuVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0knMJxu5lwi7AglwJNczxaI1E/3P2LBzh1dlVNdMhyQ=;
 b=RcnZnmYjb+SMgtDLXAURNtMLvU/903PDXJnsC+H9jTjWgUnzyyV7URDIE2/zna1+UH9v4tQnoKzCOxl3q/YfvBQqiqihpN0ZGJF1uIWT3W7vTi1OGFaUVw89HcEhq7px2zW273xcS1N9rDN04hp2JsXIw2RHS1Qj8NmhnuL+S4LRR+TaXQU6LtoZTxpEUPTECcKZD9OuHeYK/ApO/euueiLb/rlcnaEAcY78Ey9HtSx8LRzejmeEKc7TTOqOoIbqTNaJuRl2qllZMDPCp8c7C1qu06too8HrJnRRMH625kG1UlNKB9DoR6+GNfImV7AJkFQv08JhsM9rTQqix45Vqw==
Received: from DM6PR01CA0023.prod.exchangelabs.com (2603:10b6:5:296::28) by
 IA1PR12MB6212.namprd12.prod.outlook.com (2603:10b6:208:3e4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.29; Thu, 14 Nov 2024 14:12:41 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:296:cafe::e4) by DM6PR01CA0023.outlook.office365.com
 (2603:10b6:5:296::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Thu, 14 Nov 2024 14:12:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 14:12:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 14 Nov
 2024 06:12:22 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 14 Nov
 2024 06:12:15 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Andy Roulin <aroulin@nvidia.com>,
	<mlxsw@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan
	<shuah@kernel.org>, Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu
	<liuhangbin@gmail.com>, <linux-kselftest@vger.kernel.org>, Jiri Pirko
	<jiri@resnulli.us>
Subject: [PATCH net-next v4 4/7] selftests: net: lib: Move tests_run from forwarding/lib.sh here
Date: Thu, 14 Nov 2024 15:09:56 +0100
Message-ID: <a6fc083486493425b2c61185c327845b6ce3233a.1731589511.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731589511.git.petrm@nvidia.com>
References: <cover.1731589511.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|IA1PR12MB6212:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d7e8761-0a16-4227-cbe3-08dd04b66608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nShFgMVgGBwvD0lxY/nH3zHVN7hs0jXkwJios/Oer/Mrpk4gB+p5iGfEypbs?=
 =?us-ascii?Q?ahIUjASazWTluf/0aR+OG6oCQErLAvzBOP993ry93eP6NZDOS8sRQEWSXfau?=
 =?us-ascii?Q?TTuVZNTOhce6vQXQAhb2Z41Q89p+7kK45Sc3N1/8w7fezHRGQmddH9m5MkPy?=
 =?us-ascii?Q?AXSsZ4qeF1PcJpzNU9dDHW7xPDzcqcooBGSYNwu5pAqz5eoZR1pug3YexvBL?=
 =?us-ascii?Q?vxEg0PZ+c+IyfyUX32CBnYsmZkRcpKp67evWcui/cxKvOoA/ps7nO3MQ4oFa?=
 =?us-ascii?Q?eXol9Z7Yr5W6h7tE2aeI32cRlA29LCjoyfjyONjtA2L9fQYv9J/zWiA0AafW?=
 =?us-ascii?Q?pdVQA+xZ7zQ8mNrHdyFjy6feTCfveoc/2ENzig1U65LskzvbgbdeMo68es/h?=
 =?us-ascii?Q?RiMrqP8IlFwqOsewuJ3FukeYpDWkzPK4WoH1zmwIP5r9CtlGW3IrOYyt2dCZ?=
 =?us-ascii?Q?BRSsNou8UdxvaT+HhmTjhfv0q0o85hzAj0oK7SncR1ciPsUR1XxWatE/6Luo?=
 =?us-ascii?Q?+FA+d73iiwm6uv2ex2YjcHay+leToHzUpHckA9qXEHAV6FjMfy66cfNFDYxa?=
 =?us-ascii?Q?+wCOVU+b2qPns5AGkqDUkHN7/Sc76lIjY075XnMdpxbHD9AJovhvbjgAWoxi?=
 =?us-ascii?Q?WZLRBYXuBf94Es9vhwowh5LL5UCITbZFLADQ96/knUyzxCZL78IH864+llMr?=
 =?us-ascii?Q?jl43DQwicSws/FhvjUWaMkuLlRhfPPjAkxLSsUdxAsPSBDPYUDfkX4L2V7gj?=
 =?us-ascii?Q?M1Scn2YVtvv9JD+7df4yWnjrEMiCextMdvoywuS47b2hYfKw3DbRuidIsF7x?=
 =?us-ascii?Q?0wx0JBuyNnqSSrgGcegq1bob4X9FQFKiTwRlHca8g+RyN6ojaalzC3Mqcu74?=
 =?us-ascii?Q?fdX8pd5MEK3b/8QINF+nX+AHRy3uIw7o79QkMQ5vudDgA6U6k3SVj1iSrkmv?=
 =?us-ascii?Q?QScSW9pohF+J1prDnu7RVm98DxzVViEHZ5ektlJ9EWamruiF2TMplSMztWLt?=
 =?us-ascii?Q?1mqV63YnUdb/9CtICk3fVG6ngj8NBVGSjVYxmn3YMNwRSqzbZN+/mzdmdE44?=
 =?us-ascii?Q?ji8lmSAXk+zHENFyT+8wS22v1F4z5oZQEiD2uudt0FaMaG7PszuDDVNtUEoq?=
 =?us-ascii?Q?VTmCiueoH4gq79GdtTle8yD2OCwo6aBlaoYbB4ulMJCWbz/z1Yz9Ra9B/KhN?=
 =?us-ascii?Q?8omdHtd1av45wj/PjbdBT82kk9JqpBuhLXyi66KEtgajOF0W9p3JJc/PwJsF?=
 =?us-ascii?Q?OdWnA3M2pMhm+61zU0W0RCtGKuUKyM2ypmRw0qsr0OaxG+4rFJKP6QVOCITQ?=
 =?us-ascii?Q?h8PURGhAp2tbsS5QPzGVAPQfNWi4+D5Spo3CnWdI6ZjDK8qP1SHzN15rhqGq?=
 =?us-ascii?Q?SDRIVBjR496Iz0G1lOfrkJFgPZXCgjEZeDXXe84TjakgWZk8XQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 14:12:39.7327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7e8761-0a16-4227-cbe3-08dd04b66608
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6212

It would be good to use the same mechanism for scheduling and dispatching
general net tests as the many forwarding tests already use. To that end,
move the logging helpers to net/lib.sh so that every net test can use them.

Existing lib.sh users might be using the name themselves. However lib.sh is
always sourced near the top of the file (checked), and whatever new
definition will simply override the one provided by lib.sh.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
---

Notes:
CC: Shuah Khan <shuah@kernel.org>
CC: Benjamin Poirier <bpoirier@nvidia.com>
CC: Hangbin Liu <liuhangbin@gmail.com>
CC: linux-kselftest@vger.kernel.org
CC: Jiri Pirko <jiri@resnulli.us>

 tools/testing/selftests/net/forwarding/lib.sh | 10 ----------
 tools/testing/selftests/net/lib.sh            | 10 ++++++++++
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 41dd14c42c48..d28dbf27c1f0 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1285,16 +1285,6 @@ matchall_sink_create()
 	   action drop
 }
 
-tests_run()
-{
-	local current_test
-
-	for current_test in ${TESTS:-$ALL_TESTS}; do
-		in_defer_scope \
-			$current_test
-	done
-}
-
 cleanup()
 {
 	pre_cleanup
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 691318b1ec55..4f52b8e48a3a 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -351,3 +351,13 @@ log_info()
 
 	echo "INFO: $msg"
 }
+
+tests_run()
+{
+	local current_test
+
+	for current_test in ${TESTS:-$ALL_TESTS}; do
+		in_defer_scope \
+			$current_test
+	done
+}
-- 
2.45.0


