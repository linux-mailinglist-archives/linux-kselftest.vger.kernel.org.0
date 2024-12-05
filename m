Return-Path: <linux-kselftest+bounces-22870-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DBA9E5A20
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 16:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3DA716CB03
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 15:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D8E224AF9;
	Thu,  5 Dec 2024 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HEMeELrg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4246E222586;
	Thu,  5 Dec 2024 15:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413489; cv=fail; b=JRkHVbNi9TJJWHgDyHhJrLVoSydK1RMKQG5rkOjeeVhF7lOYa01YG/KUaJrkav/VzWODHwQICYz9v0T1G9mMo5eCtN96mm1ZVlWTTzGv/yOgUMjGVbruaY7WrcKdxvQRwjo4OYakIcRiz3zBe/mpisZnKDOR0lJxwjhO+bR0svQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413489; c=relaxed/simple;
	bh=cVfKjVqLaxBjvU8xsYDqwvrVmkq7fEKbZK6IxdezcGo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/l1/N6YLzpAAjdA/9Bjp5VnqJu1k1HHuOiFdW4IcdVlrzBY/VgLwfQDiMj1MPJbGFge1CaZQc2OT5KV9H6Wj5+LoQO/1x2c62lQ1TmeLCR1JOfv0WD/QMI7ppMaV9bOpBEUgt2a38OtmKJvDC2X6IJTOFoE3b8iF9trP0U+ylM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HEMeELrg; arc=fail smtp.client-ip=40.107.100.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0TsGgm9/QeaUVOnh02sm/4ebxRE6jVEzMk7yZDpmuBSYU5674G0zbmGrEz+mcWtdZUUOaN1ntNtd7EtowT8RYRL4+zscnVmgBoXxGN5ID/jyGh7ZnZ1J8ci7fyC+2uYQwTCcAoJi+p8vGI6xx9CMIZP7Cec5gdwNLsBF71GiVcTGVWzvmTZljKjr01Q7cIbB37GTHN8JNnZ/szXtebGfxFsFXwHEWPe0UENU75RZd7HHs5EHVJhYHNnkWwXtvxd2VcypfIJOr8shMsUSaOsIo1dgiTV5XfHXogavwSxT3X/gRCo2LhkhId+HwzflzTcN43fp0VLn38XJSSe2qYtEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVqdvTshHxNki3bZ3TKLjG68UTcnAHsRVq2A6Gcb6kI=;
 b=owimIt3fbL2Tbr6k8qr7p/OQTLNrfLtZwbOST1YYkNeEs5NchydMmJJrkYOq9z+prxZrseVD102XCYSjlSQbOBTKRbBU7SNRDgxMXeI1W00EZ3LzwwnFATg48CDR1wi4dZ697ZdHYSYuW79w8cMml9BZrROVG5Oca5YxYG4rNMYbXCVucs7cj71OdGnwDTNeMETnT7dJhJzGzS+s5Yl7/PWPCb/K4ftSKej4njf+He+Zj7/49FTaqvmxFnpvtFfSHscHQflfqyTmMOJeIM7fMm+SrDvt/Sqmrojv00kQ34LRDpux483sHbwCSin1rh8ZXB+dMLzI9kYNlY6EcU6/Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVqdvTshHxNki3bZ3TKLjG68UTcnAHsRVq2A6Gcb6kI=;
 b=HEMeELrgI/TXrgRTP7tlmzAyeINPJeoa77pDpwEUg6+VZPAx6A73qC4JjTKaiUp8DW6jCclyKFIyigVPECp6onDgMIIuIk2AvxjDdkDjPhhGtRgwqaL3eiMGENPitwCB1MihZKQirhicM37ETa75UbKHBCGXkWPx+NbkYAdYsXSfnITLWj7hCSpJ7E0zeH5S2TG8yJGI9VN0Lq8S3VzQcwU3/Th5UT2UEUDvTcZ3ZZSZJgWoWSFn3IOL+Kms7AFkhsCQsIXffOjPN/5C2qRcfjjlvQom1qTgYbwi3+wC+ZK4Ji3HFow4K0WvscwAXjIdQiaSZTM+cTJ3y9pEY9fOKg==
Received: from DM6PR21CA0027.namprd21.prod.outlook.com (2603:10b6:5:174::37)
 by DM4PR12MB6010.namprd12.prod.outlook.com (2603:10b6:8:6a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.19; Thu, 5 Dec 2024 15:44:36 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:174:cafe::93) by DM6PR21CA0027.outlook.office365.com
 (2603:10b6:5:174::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.8 via Frontend Transport; Thu, 5
 Dec 2024 15:44:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 15:44:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 07:44:20 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 07:44:14 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>, Shuah Khan
	<shuah@kernel.org>, Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu
	<liuhangbin@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next v2 09/11] selftests: net: lib: Rename ip_link_master() to ip_link_set_master()
Date: Thu, 5 Dec 2024 16:40:58 +0100
Message-ID: <fbf7c53a429b340b9cff5831280ea8c305a224f9.1733412063.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1733412063.git.petrm@nvidia.com>
References: <cover.1733412063.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|DM4PR12MB6010:EE_
X-MS-Office365-Filtering-Correlation-Id: 2781b555-79ea-4949-2554-08dd1543b8e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sKoBhp2z+QS72fEPO4d60fb7IvrJm+cZ5je4cvqsypN40xWOrkisqrjwg/aR?=
 =?us-ascii?Q?cJv27YBJFSH20Fss8SFwFkrybY/jU8osGQYttOz6HfXcdavvSg3oO5EyizOK?=
 =?us-ascii?Q?FmcgwwLnk+xFZsDlq5hGzEWfsIbUv1I9PgxuxvJB3jJL4/I6w4vryPpoTYnA?=
 =?us-ascii?Q?vgIqUaE8tXEXJHhDw31FtARA/SQFdes1C66Qul06qpM6NVdVwz/R84Ij4A2u?=
 =?us-ascii?Q?tIRQqCQ/Mw2B+uP9eL5YIxXzSn/Owp1cUIsm8ceHPGHkhG6+OF7Z+Fq8DcIx?=
 =?us-ascii?Q?yGhV9IBU+EdVrFy2auHx0P77mxeq5MGEJpiwkv/RVISaEj48u5DgweRd5DG5?=
 =?us-ascii?Q?nbzX9jxx7VeLpyt4BpSDgGIwqwqGthIWvVCWCv6LV+LrZ5XrVriBd9lYLWQV?=
 =?us-ascii?Q?iS/V36OTEC8n0CfYx6TMtoO4vCEmPbbH4sR04i5FPVKBC9xBQEFi2z9cJ/js?=
 =?us-ascii?Q?zG8eMr7K0vidEokzLB+8SPlxnxP+4Lv/nG+RBd/0mcfYM8+f6/jKMXFM04ab?=
 =?us-ascii?Q?f+oQq2yTyZd3UFDLpmrUBl3hB+ABeKQhDEsBjBHQauvKAlgolaPnCvPltTq7?=
 =?us-ascii?Q?zc2vDT+ZJJL3pftskj2uIsCIHxvCYxediVl+I3Sp6an2JAJ6nglE0piow/Yq?=
 =?us-ascii?Q?kvXOEDcydr65eOHDwY2pU0Jk47LEhHAzh3uneCyBEhgcKW0hCG7C0zTByLfD?=
 =?us-ascii?Q?yNNlvpDNuw1ifP8qN3HZNNl88DJWlqG3LbVuo29dekO9HUiwjNefSr0DyIb0?=
 =?us-ascii?Q?6NbeKn0qUASDV2bniTYqDgXJQELQ6yTV576LwASOdC8aBu+2Uo0qPhV5pjPY?=
 =?us-ascii?Q?7Jeom5KjwAtUVPdZpjZgs64jYc7mdJisiidL1ZpOMfuYqZZ2Rl9SEhRQfb2O?=
 =?us-ascii?Q?cp0IDH+B7ZGKG0KxN571VGtJqU6+opPT877QqIsbWBq8suQzesmhATVEoyTm?=
 =?us-ascii?Q?DlArQnicElioej+sw1CdMAx1OjZR2m7pWkgg2w/Le3IPRU1coelYEWz/M6Pt?=
 =?us-ascii?Q?DaAPVTtNByTg1LrAP1QnKE/VZMI8izv6DPNkhwwpgHq/McwRJk3SeODIPZ8e?=
 =?us-ascii?Q?eEpgkeRyxVcQeFwrMUw3AekAvPQG4S9H3rfHFdxXkvOJqGINusNZ1mlw0rtI?=
 =?us-ascii?Q?paDHjTxbPYrpJk2kVBobaFev3NnWi/kI7TB+ZfqF5wFBj/Srq8C9aWSzHryD?=
 =?us-ascii?Q?2sToeDkjY6SKnWY+5a78mUXmY/SbvkWOeD9vXsy9bqnRr6dIhjZVinpQYy5x?=
 =?us-ascii?Q?1SGgFumhncZ3ZdzIUKztiXmtvQXotuDWGJP8vlIzkWWUtJ2c7kZjomZvLCiT?=
 =?us-ascii?Q?Ts489TK4hm0r9u0EaAmEJNApJEdYoARwqGURG+46nGp3Ou9ZWFzlemAN3x0C?=
 =?us-ascii?Q?aSB09Pae7Ke0vRTk8twLoEZdVfxigGdp3W4fyKG1+vqrYlX3SrzSl52LyWJT?=
 =?us-ascii?Q?mMdvhV4XCOdXt7dSYHZSoBdQ82O24d6f?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 15:44:36.3736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2781b555-79ea-4949-2554-08dd1543b8e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6010

Let's have a verb in that function name to make it clearer what's going on.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
CC: Shuah Khan <shuah@kernel.org>
CC: Benjamin Poirier <bpoirier@nvidia.com>
CC: Hangbin Liu <liuhangbin@gmail.com>
CC: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: linux-kselftest@vger.kernel.org

 tools/testing/selftests/net/fdb_notify.sh | 6 +++---
 tools/testing/selftests/net/lib.sh        | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/fdb_notify.sh b/tools/testing/selftests/net/fdb_notify.sh
index c03151e7791c..c159230c9b62 100755
--- a/tools/testing/selftests/net/fdb_notify.sh
+++ b/tools/testing/selftests/net/fdb_notify.sh
@@ -49,7 +49,7 @@ test_dup_vxlan_self()
 {
 	ip_link_add br up type bridge vlan_filtering 1
 	ip_link_add vx up type vxlan id 2000 dstport 4789
-	ip_link_master vx br
+	ip_link_set_master vx br
 
 	do_test_dup add "vxlan" dev vx self dst 192.0.2.1
 	do_test_dup del "vxlan" dev vx self dst 192.0.2.1
@@ -59,7 +59,7 @@ test_dup_vxlan_master()
 {
 	ip_link_add br up type bridge vlan_filtering 1
 	ip_link_add vx up type vxlan id 2000 dstport 4789
-	ip_link_master vx br
+	ip_link_set_master vx br
 
 	do_test_dup add "vxlan master" dev vx master
 	do_test_dup del "vxlan master" dev vx master
@@ -79,7 +79,7 @@ test_dup_macvlan_master()
 	ip_link_add br up type bridge vlan_filtering 1
 	ip_link_add dd up type dummy
 	ip_link_add mv up link dd type macvlan mode passthru
-	ip_link_master mv br
+	ip_link_set_master mv br
 
 	do_test_dup add "macvlan master" dev mv self
 	do_test_dup del "macvlan master" dev mv self
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 8994fec1c38f..5ea6537acd2b 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -451,7 +451,7 @@ ip_link_add()
 	defer ip link del dev "$name"
 }
 
-ip_link_master()
+ip_link_set_master()
 {
 	local member=$1; shift
 	local master=$1; shift
-- 
2.47.0


