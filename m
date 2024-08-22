Return-Path: <linux-kselftest+bounces-16065-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D698695B7B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 15:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF20287693
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 13:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A903E1CE6F0;
	Thu, 22 Aug 2024 13:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ilvIkLK2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1961CCEDC;
	Thu, 22 Aug 2024 13:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724334759; cv=fail; b=UocE9jDfo/Sgm9ABxBA+AsgjNLQUCyjlYkHHVg0S+gDhXjVdjU23NulgTP/F0gfTaGn+OlWP8r1XvDPPrlWDiAVCralq9fcLKgXLqI6ABbyWg/txgCweIjUC/14Ct5sayjXk4vVGW75UT4x+L6VW9wgVBcB38FqM30iCpVBWxho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724334759; c=relaxed/simple;
	bh=TPihotGRDiRMCeG2dXcjw3hDnzf57sBNG0BJCHqt1hg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bYDxjvpyyILuXf37XZ6JWk1O5rI5ppB4DZeGF5JSYk1jk5zkPdsONnTfUxrhxV1wnLNoeRIf/n16oXPcVZrk2Cx8TTuigcr1EDekIjW0g4iA7nqQ3ZKwHbvJNCdm5/BSyVQD/MeNg9kQlr6Tzk2PikTNqxchxgVoXwztlbqT4AU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ilvIkLK2; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8D5a7dDC1PTSDmFLeelt33waakDL74/XgK7IvSP7lvNclKNfL8WxdhihTcdvX3O6RvbU2Zm6hLbiAreaItGHbtB+Jt9rL74ifDl47WLc6JIy0IiYqVsPFhQ32F3k3EbZwsPnwgP+6R1+ENJ6WUQ5B+gJVtlLOqBTHb9/CuWORRXbfG8JpYaf/ZWigBSEwz9rUMlFInn2jWdu/btqEncxnA8bb+rrEr6YKyfYIQy8HM///jaVEgSV+8oUj4zNzvSBlAKGMt+hA417UmALUjbFJvFJ2ZdYtaEHMfqjaPco9IKHWD1rlFEpC1qrmsVXAayD1FtiwOiUhO+/gP1i+1qqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uv87u9kUDdMqg9Gnr+g8FXFozGTT0scGyYoBDsooOic=;
 b=pj/tkkmnPaBUcSZvbkzOxialEVsMR8QQWzIggizj/5sOAoZJpR4OR3piWmp4E6/w5pp3Z+5Yw+BupBuH8Qoppk+6eVwgHILO6peWnJ6i/UmpEYVmHBdLx3dX8WVCEEPaInEC9i2o5hnFdV+tZgbc5WWv+lncnTUs9L/Yi/o2oUpictKFxR7ajaCMuQ27Yvv6G0MgOpTcgVFjGMwNZwfsvcDNePCx+8NJkUZr98PSyPmosnVKWYREa5oAynkrPpXWW56SDwVrsWckLqjjHa2iDtFDIP4HiSkN0wDlmPXqex7uS7kXTWG8+0fD6Zr365Sy3pHvAPxyt6+S1+Ko/OvRdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uv87u9kUDdMqg9Gnr+g8FXFozGTT0scGyYoBDsooOic=;
 b=ilvIkLK2vCd+KOnMqFAuK5WBckg35wCDqPwSim80OETgFhGpitPDGn59QPgD6kpTMiEacSod11d8jrSzxNiH5N8uAiy5ogtT4ujg6xg/1R6p3zC+mmj5SzmjnQXkl9dfMacqdG1buDZOy6hW5Kudb42e2j37LTku0k7q+HXPwYwdDXJOD9l7ljERrSWXIjs04YIZnCxX8pLyzTiWbzWokjscTJLVWy0jPICBZO924/yQPigL1PpoZh3OpnShJHnlAaFlbidSs11OW0UzEAeDmEvUYp/1pL6sUYXV8Ie3sUrQtaOX8ykqVx+5osuKjgf+XpuGAPFoiX6GBzKE6H1YMQ==
Received: from BN0PR07CA0017.namprd07.prod.outlook.com (2603:10b6:408:141::31)
 by LV8PR12MB9109.namprd12.prod.outlook.com (2603:10b6:408:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 13:52:33 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::85) by BN0PR07CA0017.outlook.office365.com
 (2603:10b6:408:141::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Thu, 22 Aug 2024 13:52:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 13:52:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 Aug
 2024 06:52:17 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 Aug
 2024 06:52:13 -0700
From: Petr Machata <petrm@nvidia.com>
To: Shuah Khan <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, Benjamin
 Poirier <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, <mlxsw@nvidia.com>
Subject: [RFC PATCH net-next 2/5] selftests: mlxsw: sch_red_core: Use defer for test cleanup
Date: Thu, 22 Aug 2024 15:49:41 +0200
Message-ID: <bc6a5bf947f0b1fedfed218ae172d823951ef9cb.1724324945.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1724324945.git.petrm@nvidia.com>
References: <cover.1724324945.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|LV8PR12MB9109:EE_
X-MS-Office365-Filtering-Correlation-Id: 082eedee-03db-42a0-df81-08dcc2b1ac2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JkuWHCEiECByUw7ZROMU9/ocM03asLrRIjqzEvCdno+XoSqn+YsgOjapjnwC?=
 =?us-ascii?Q?rKDu3EQt5rv4xYBwMKHec+Gt7G3UzovW4cqYQEiQo0NNRgDiwmZ9FKl5aN6Y?=
 =?us-ascii?Q?f25HCa/4uNP/eaDfROc/oFKDTWKDidpFUBmXFXO8vAHHrmSXS3sxnHNzyXIm?=
 =?us-ascii?Q?igR88hvKx7A7yhmylJFyHrAwV15FXBSJgndgsE54YueJ/Wrr3AdIt2x4U+/A?=
 =?us-ascii?Q?zMNGYxoDYYbDL3Dy0aaJ5gLphn2BMUNDr0sBcFycnJBmIkQzsp4AhSEP351/?=
 =?us-ascii?Q?I7CpfBmWFpwzbXLCaAEBnpHROxmAVDcJAEgkSXDOjVkwC5ZRE9HqZIlTXPZH?=
 =?us-ascii?Q?mwnSrkHgM9uW66OGX5cFONqGeO6675xJC4g8NDZwU8JQ8b3RMQgwBvCivSrN?=
 =?us-ascii?Q?Og2BpFW3/FSpcJ7wney0G7fxqSN38Q6bnaBj2721qta/O6j/lSbJpjB1ztlY?=
 =?us-ascii?Q?gdf1SXeyo76RsdePk31BEw1rBSdxuL6yKxEHSdQr4f+wO9ErDnf4I1rCdxCk?=
 =?us-ascii?Q?QGL+wYE5zSxbbFSFea4T7WRdUxYPsWrwdlgn35yCB9RkHZW0egKi8NN7HXnM?=
 =?us-ascii?Q?BLqWWf5hSEYtsbYMyoLoN6OmoFPTNz4BXB0UqBeMrNvWxKjEh7RZbarzu5gF?=
 =?us-ascii?Q?8h/igS5SoVBRVXPOMfNpWfE3UfdPbJJ4bz7VgZJaKxTgImguzpoxTGPBcLNN?=
 =?us-ascii?Q?AoOCRtDNY0E8AWwpNGmTwqKXupN6y0chVdjlaePQ/esJHk1Su+mAgR/qV5Eg?=
 =?us-ascii?Q?oJM75BbHUkYPXeuYzPmhyV68SMNB1Ce8nB1m1/vTcRSqteST9+QVO3gFWJU6?=
 =?us-ascii?Q?jd2pOL/zs0+0cpX+8keIpSIAQBokhJGxkGEZqACWE3bugzRNaaFqDGkOPULN?=
 =?us-ascii?Q?yAZQ82JQyds9CcPYlQxHLHJp2oxpbSSAXXU55SabNGSh5OFfIjnHaTYYPELN?=
 =?us-ascii?Q?dqrpkCfIbQkXLnMlnXNB36EBiKvFxnFnYrfJv9EwErnMPurQ2KuZBpEW8Xzi?=
 =?us-ascii?Q?1azuh8fwgoDiChqAWBy6iuHcFL9pdW7DiOxC1knLfAC8k2uAg6f2NcQgGwTQ?=
 =?us-ascii?Q?7wmZCDmwXTX1SIixYQkZOq0l8WSjIiW1X4bOXY1Ea6d6tXB4CDTIz1rOtyzg?=
 =?us-ascii?Q?yMrcRKES7RbVx5tPzYwIEHnTU3Oh4UOGzDYpsgRtU7GENSKCE1Q0MlKzkaDg?=
 =?us-ascii?Q?HP0aHDqtRkumzp24/CbPe5W9VkQiCIRgxYHfblJUxlA1Y26PGo+iRVmRR5U7?=
 =?us-ascii?Q?h3fxzeH5rxZzajwBupA5+Pn+K+WlIBK2VbFDjH99OgbGnEPIOhvd2tlXSDl3?=
 =?us-ascii?Q?NhoLNsj/QVlWSFzuC8bcLXUyxcGkTsMtYZdjQ7+WyxOSaYTeKos4Equ/jsDo?=
 =?us-ascii?Q?3HLZw+xnMusQIM2ZOfL+KoHIWkFoe5zZ7Hf4a3MEBDUca4Bb3sbNsDjWvqoS?=
 =?us-ascii?Q?1TvNp8KAcjiEKjy12kibA7ki4/m5hz/m?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 13:52:33.1489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 082eedee-03db-42a0-df81-08dcc2b1ac2e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9109

Instead of having a suite of dedicated cleanup functions, use the defer
framework to schedule cleanups right as their setup functions are run.

This makes a dedicated cleanup() moot, instead fall back to the
lib.sh-provided one, which invokes the necessary defer cleanups as well.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../drivers/net/mlxsw/sch_red_core.sh         | 109 ++++++------------
 1 file changed, 37 insertions(+), 72 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh b/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
index 7151b0c7bf8d..117a99fdbba5 100644
--- a/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
@@ -89,39 +89,31 @@ host_create()
 	local host=$1; shift
 
 	simple_if_init $dev
+	defer simple_if_fini $dev
+
 	mtu_set $dev 10000
+	defer mtu_restore $dev
 
 	vlan_create $dev 10 v$dev $(ipaddr $host 10)/28
+	defer vlan_destroy $dev 10
 	ip link set dev $dev.10 type vlan egress 0:0
 
 	vlan_create $dev 11 v$dev $(ipaddr $host 11)/28
+	defer vlan_destroy $dev 11
 	ip link set dev $dev.11 type vlan egress 0:1
 }
 
-host_destroy()
-{
-	local dev=$1; shift
-
-	vlan_destroy $dev 11
-	vlan_destroy $dev 10
-	mtu_restore $dev
-	simple_if_fini $dev
-}
-
 h1_create()
 {
 	host_create $h1 1
 }
 
-h1_destroy()
-{
-	host_destroy $h1
-}
-
 h2_create()
 {
 	host_create $h2 2
+
 	tc qdisc add dev $h2 clsact
+	defer tc qdisc del dev $h2 clsact
 
 	# Some of the tests in this suite use multicast traffic. As this traffic
 	# enters BR2_10 resp. BR2_11, it is flooded to all other ports. Thus
@@ -139,13 +131,7 @@ h2_create()
 
 	tc qdisc replace dev $h2 root handle 10: tbf rate 1gbit \
 		burst 128K limit 1G
-}
-
-h2_destroy()
-{
-	tc qdisc del dev $h2 root handle 10:
-	tc qdisc del dev $h2 clsact
-	host_destroy $h2
+	defer tc qdisc del dev $h2 root handle 10:
 }
 
 h3_create()
@@ -153,40 +139,54 @@ h3_create()
 	host_create $h3 3
 }
 
-h3_destroy()
-{
-	host_destroy $h3
-}
-
 switch_create()
 {
 	local intf
 	local vlan
 
 	ip link add dev br1_10 type bridge
+	defer ip link del dev br1_10
+
 	ip link add dev br1_11 type bridge
+	defer ip link del dev br1_11
 
 	ip link add dev br2_10 type bridge
+	defer ip link del dev br2_10
+
 	ip link add dev br2_11 type bridge
+	defer ip link del dev br2_11
 
 	for intf in $swp1 $swp2 $swp3 $swp4 $swp5; do
 		ip link set dev $intf up
+		defer ip link set dev $intf down
+
 		mtu_set $intf 10000
+		defer mtu_restore $intf
 	done
 
 	for intf in $swp1 $swp4; do
 		for vlan in 10 11; do
 			vlan_create $intf $vlan
+			defer vlan_destroy $intf $vlan
+
 			ip link set dev $intf.$vlan master br1_$vlan
+			defer ip link set dev $intf.$vlan nomaster
+
 			ip link set dev $intf.$vlan up
+			defer ip link set dev $intf.$vlan up
 		done
 	done
 
 	for intf in $swp2 $swp3 $swp5; do
 		for vlan in 10 11; do
 			vlan_create $intf $vlan
+			defer vlan_destroy $intf $vlan
+
 			ip link set dev $intf.$vlan master br2_$vlan
+			defer ip link set dev $intf.$vlan nomaster
+
 			ip link set dev $intf.$vlan up
+			defer ip link set dev $intf.$vlan up
 		done
 	done
 
@@ -201,49 +201,25 @@ switch_create()
 	for intf in $swp3 $swp4; do
 		tc qdisc replace dev $intf root handle 1: tbf rate 1gbit \
 			burst 128K limit 1G
+		defer tc qdisc del dev $intf root handle 1:
 	done
 
 	ip link set dev br1_10 up
+	defer ip link set dev br1_10 down
+
 	ip link set dev br1_11 up
+	defer ip link set dev br1_11 down
+
 	ip link set dev br2_10 up
+	defer ip link set dev br2_10 down
+
 	ip link set dev br2_11 up
+	defer ip link set dev br2_11 down
 
 	local size=$(devlink_pool_size_thtype 0 | cut -d' ' -f 1)
 	devlink_port_pool_th_save $swp3 8
 	devlink_port_pool_th_set $swp3 8 $size
-}
-
-switch_destroy()
-{
-	local intf
-	local vlan
-
-	devlink_port_pool_th_restore $swp3 8
-
-	ip link set dev br2_11 down
-	ip link set dev br2_10 down
-	ip link set dev br1_11 down
-	ip link set dev br1_10 down
-
-	for intf in $swp4 $swp3; do
-		tc qdisc del dev $intf root handle 1:
-	done
-
-	for intf in $swp5 $swp3 $swp2 $swp4 $swp1; do
-		for vlan in 11 10; do
-			ip link set dev $intf.$vlan down
-			ip link set dev $intf.$vlan nomaster
-			vlan_destroy $intf $vlan
-		done
-
-		mtu_restore $intf
-		ip link set dev $intf down
-	done
-
-	ip link del dev br2_11
-	ip link del dev br2_10
-	ip link del dev br1_11
-	ip link del dev br1_10
+	defer devlink_port_pool_th_restore $swp3 8
 }
 
 setup_prepare()
@@ -263,6 +239,7 @@ setup_prepare()
 	h3_mac=$(mac_get $h3)
 
 	vrf_prepare
+	defer vrf_cleanup
 
 	h1_create
 	h2_create
@@ -270,18 +247,6 @@ setup_prepare()
 	switch_create
 }
 
-cleanup()
-{
-	pre_cleanup
-
-	switch_destroy
-	h3_destroy
-	h2_destroy
-	h1_destroy
-
-	vrf_cleanup
-}
-
 ping_ipv4()
 {
 	ping_test $h1.10 $(ipaddr 3 10) " from host 1, vlan 10"
-- 
2.45.0


