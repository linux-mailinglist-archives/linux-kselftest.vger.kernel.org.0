Return-Path: <linux-kselftest+bounces-19347-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D75249969AC
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 14:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ADE21F23DB7
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 12:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DE1192D68;
	Wed,  9 Oct 2024 12:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZrpOUSFG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9751B192D6E;
	Wed,  9 Oct 2024 12:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728475843; cv=fail; b=hNgm4p3kslQJcaxYJ/uwZLnRb9rN4jXtBPMyiMndaD4QXy/L6ju7oonkImqKa6Yg4yBY3HP53lnaD4fuWiOqtj6iLVCLpbnOKkob9qVIPe+D+p3H4inhwTkkkkCdKdWPpxasFmNIc4o81ASgJx/GYb+8EVW7hVKSwEs7TP0t6AM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728475843; c=relaxed/simple;
	bh=CGbzMlnE8NQ2E0+7jxlDy4cOi2zh+2y9Mz8URLCBqXY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Npj6XnjA1g/gi9+voNk7C8/4BHAGFMlw/hEui4OxoE0MhfoH1ESCoCYEhK3at6nmgb3CaBE/kldZwqoxdnveGnk4HCs13JVeT9XqgBIvVE9t5DTcOMdLK6e9xIDnhfvxudTcGVeaosUrfO8WoduOJ0pqYijaPzkk+uJhjkdcbMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZrpOUSFG; arc=fail smtp.client-ip=40.107.220.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFlAq/qi2RkSFvEd3FbgXn7WPg+NEIiumd+AGkfwkYzJmWUsoyyMW5u5SHb6VhpWUMOdmJu/Qi90CFuqv5gKgWrcjtFq1HrYeK+y9Di8U5v6qW/3Y/rucD6b/G4W1jcN4ly+4d11GR3RUvPu8MvfVRrbUVZyDk6/XQyhBENqxV3lBO/tPmJMdFsZ55EJYrbWr4AOgkxPh7DWgsV2kTOCxhkzHN5C7qVxJj0r8Kym440GuY9Xz7XXq41I9gI3RsnPC9DSWKk3Bc6LnZnwFh+JR13bpfT3H8lWPz8n0kQXP+BgB2vcIZracrvtg6o8wRkazsVdC9WRja9x8JMGoF/b1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jd6MnZn98keCO6B5yBoxOZkIOQOubnd8AutPhbtdt6g=;
 b=pd+CCfqV2ubzQndoWuqNzjPXM9wJFNOdUm+yKzohGKMHNanE3DPSBcBlmE7z5UdD47gFEPaXJIipQX3EkLbWN+KGV3KXzBptCGSLgov9qxDb/JlwtIko0Tj9Q5kNyL7UT/EgSVCtP5fUK1HyZIQt67O+Ff175Tl7pitRnuvh+DPBSIU4adcIryhTQJohdaWSbLOxB76yIj1rcbPpex3oIURW12IzKRdTBQNvaekMspmbxXKxbj74Xb8/dG+mxBfZZvBK5UqIKnqCztJy1YKYnc/vj64FaTaFyUKsbE5tZToRNpNOWxNaqZvuj3Y5Dc1EHJCQH4UHQdS4ywnwDjccYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jd6MnZn98keCO6B5yBoxOZkIOQOubnd8AutPhbtdt6g=;
 b=ZrpOUSFGP/4MCdj5rPfE1/HKfnFS/dyAMxe/IH36x6F30HgjCD4cthdXjAtSAxPNPZGiMUTHO8zG5Br9/ZXzNFJBy5nK0Ti/4KNqZSZ1ajgs/xllZYIrdxJqTDyic+sCxpIP6LNkFS6qMZCKrpCCvAsjK33bX818HRdxqqWlSYkT70jJhBLzdomFMr2N3Xxzrt6ufOEdB8XLq4Kmgygm4QM0FgjfUVf1m4YRByUdYUlNw8ldSgYWrFP6HaU5qIB8sDPZF9voZeeXD6+VpTLBzXlQCOjjOEgmK4SvFLmw9bA56knOgULNxOKcHALFiPdbBi2DFkls8oiqgEaX3gHPeg==
Received: from CH2PR16CA0012.namprd16.prod.outlook.com (2603:10b6:610:50::22)
 by IA0PR12MB8930.namprd12.prod.outlook.com (2603:10b6:208:481::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 12:10:38 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::41) by CH2PR16CA0012.outlook.office365.com
 (2603:10b6:610:50::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 12:10:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 12:10:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 05:10:26 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 05:10:19 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
	"Benjamin Poirier" <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	"Vladimir Oltean" <vladimir.oltean@nxp.com>, Ido Schimmel
	<idosch@nvidia.com>, "Przemek Kitszel" <przemyslaw.kitszel@intel.com>, Petr
 Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 10/10] selftests: mlxsw: devlink_trap_police: Use defer for test cleanup
Date: Wed, 9 Oct 2024 14:06:28 +0200
Message-ID: <a1e9b237703eb76830898a5ec75e3936f73f3444.1728473602.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1728473602.git.petrm@nvidia.com>
References: <cover.1728473602.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|IA0PR12MB8930:EE_
X-MS-Office365-Filtering-Correlation-Id: d8133f0b-a2f9-4424-89a1-08dce85b632a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kHQH4bGdNUg5rPYRrEVl43vWcES+NFfWFP/Q/HDRVoU5aRMjJBTyutiLz+Bk?=
 =?us-ascii?Q?AIVTUYVka71JIX1X/7t2n8nP0Ols3s6XL4pD+bt1HFsU7mN5S77jhV7aOhUp?=
 =?us-ascii?Q?hqyLk/tpXMJRrRPl0RrmWXFBE3w/J0QWCuIa648WMw1MaoIqBqHiJ+qdXKfB?=
 =?us-ascii?Q?84ql0MufGgtyxkbsUJ/UANdMZ/NP0Ib00bSiUjrEKs29+Ld8Z02BjdSQDzPy?=
 =?us-ascii?Q?01HUuzxf/kH+xlzG2KELGriDv595OC3LgblM80CP0jG35l8L6f5eOTZgOq/4?=
 =?us-ascii?Q?dU7fvHBp2PXgotXNMr1mOv14csB1DRnZc+yqfNDUBDiSe3sqam4GzWuQV6EO?=
 =?us-ascii?Q?qpW2MawVuhtMTWurwkrqCBoVIKW5WNDXv6Gy84KT9S4GmRGCJurxs5936O5N?=
 =?us-ascii?Q?xBzFWXfw6/O0cn6rXftImWpThOBEGFLC4SWH9wwSrybf/Ym/Pt+mJEbC8iYk?=
 =?us-ascii?Q?b8sNz696Ii/DBWxrODwJvdoA4qS1BiWHF1kYox2HMfKtZTfbHJ1j/Ux1V2U0?=
 =?us-ascii?Q?k4dSx0dyyzAY6fOVlT+e7wSDM+gWJb1UmS0TjDXB4I6ex4aRw1st0bF57G5e?=
 =?us-ascii?Q?1Z0C57F+qFPKgzzMLNZEr8OoVuCN3o2SbpuxPItBv4Qa7iqS1nUGwbMAjmNF?=
 =?us-ascii?Q?xpHZzbvaGVwewgjibm46LE6HSKZ+AjCCGfnUOcAYiiUjzPQGKzFdmw7ovBiU?=
 =?us-ascii?Q?0xQ+0Dx/C42Shs7DBapJA+uRK14fVpSN8A1zBjBWp0U/JSkGyVh/gktXpAUg?=
 =?us-ascii?Q?PWbfCMILNjx3Xi7xTVsqj4S5kS6Wqv78hE1PLXU5cjIdAfFOHjmnB3TSDVNp?=
 =?us-ascii?Q?ldKAL5xboVV0g9uKd9b3c5hi55SSftOxDLIFjOR1FPqoeq3VwrfcMaBIsn6w?=
 =?us-ascii?Q?HG58tXSvJlr3Oy/3JPG+Wz+gpAJEWGS6SkHd3B78pVPqiS6WnI/wY3PFp1Az?=
 =?us-ascii?Q?6pAEJgaSZay4n0ARjWCotNMcPWYYVZnjfq7l1LgBccE47XRk6+JxvaO5pBSC?=
 =?us-ascii?Q?9HctVPEX9Pd2pFFTkXUbs/CyRIt5z1PrhQxlRdVPQZL6jOwMo/8GJnYKhZOa?=
 =?us-ascii?Q?sV0Q1gndTxA+VfAItTsfgHFBf/ju15aVPkDH11ykXifEQP3A4adeCDpABrDP?=
 =?us-ascii?Q?l08QdVuUP6WXiTgLOfkgUk1xcPmhazS36HTcEQBA4mrfEeaT2A4cDCqUEXev?=
 =?us-ascii?Q?3qEH+rRjnasxTdzQeqGpXW6+agI4KBkhY0i/b28Gz21Q7Gi39y8RHCDtGjx/?=
 =?us-ascii?Q?BriLL6eG01m9bLquc1KfxOuuX4NbH1mg1RslCgCiDZzbnE4sP+RjvJoFU9xg?=
 =?us-ascii?Q?yYzCbAKldoZcano+1gYDHQtFGFs2kLMWjJL2EMtpunC8NubC0Kl4w8zpFU3l?=
 =?us-ascii?Q?87h6KMAQ2qCje3g+/iCQhcAoJgXk?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 12:10:38.1761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8133f0b-a2f9-4424-89a1-08dce85b632a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8930

Use the defer framework to schedule cleanups as soon as the command is
executed.

Note that the start_traffic commands in __burst_test() are each sending a
fixed number of packets (note the -c flag) and then ending. They therefore
do not need a matching stop_traffic.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../drivers/net/mlxsw/devlink_trap_policer.sh | 85 ++++++++-----------
 1 file changed, 36 insertions(+), 49 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_policer.sh b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_policer.sh
index 0bd5ffc218ac..29a672c2270f 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_policer.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_policer.sh
@@ -45,63 +45,52 @@ source $lib_dir/devlink_lib.sh
 h1_create()
 {
 	simple_if_init $h1 192.0.2.1/24
+	defer simple_if_fini $h1 192.0.2.1/24
+
 	mtu_set $h1 10000
+	defer mtu_restore $h1
 
 	ip -4 route add default vrf v$h1 nexthop via 192.0.2.2
-}
-
-h1_destroy()
-{
-	ip -4 route del default vrf v$h1 nexthop via 192.0.2.2
-
-	mtu_restore $h1
-	simple_if_fini $h1 192.0.2.1/24
+	defer ip -4 route del default vrf v$h1 nexthop via 192.0.2.2
 }
 
 h2_create()
 {
 	simple_if_init $h2 198.51.100.1/24
+	defer simple_if_fini $h2 198.51.100.1/24
+
 	mtu_set $h2 10000
+	defer mtu_restore $h2
 
 	ip -4 route add default vrf v$h2 nexthop via 198.51.100.2
-}
-
-h2_destroy()
-{
-	ip -4 route del default vrf v$h2 nexthop via 198.51.100.2
-
-	mtu_restore $h2
-	simple_if_fini $h2 198.51.100.1/24
+	defer ip -4 route del default vrf v$h2 nexthop via 198.51.100.2
 }
 
 router_create()
 {
 	ip link set dev $rp1 up
+	defer ip link set dev $rp1 down
+
 	ip link set dev $rp2 up
+	defer ip link set dev $rp2 down
 
 	__addr_add_del $rp1 add 192.0.2.2/24
+	defer __addr_add_del $rp1 del 192.0.2.2/24
+
 	__addr_add_del $rp2 add 198.51.100.2/24
+	defer __addr_add_del $rp2 del 198.51.100.2/24
+
 	mtu_set $rp1 10000
+	defer mtu_restore $rp1
+
 	mtu_set $rp2 10000
+	defer mtu_restore $rp2
 
 	ip -4 route add blackhole 198.51.100.100
+	defer ip -4 route del blackhole 198.51.100.100
 
 	devlink trap set $DEVLINK_DEV trap blackhole_route action trap
-}
-
-router_destroy()
-{
-	devlink trap set $DEVLINK_DEV trap blackhole_route action drop
-
-	ip -4 route del blackhole 198.51.100.100
-
-	mtu_restore $rp2
-	mtu_restore $rp1
-	__addr_add_del $rp2 del 198.51.100.2/24
-	__addr_add_del $rp1 del 192.0.2.2/24
-
-	ip link set dev $rp2 down
-	ip link set dev $rp1 down
+	defer devlink trap set $DEVLINK_DEV trap blackhole_route action drop
 }
 
 setup_prepare()
@@ -114,7 +103,11 @@ setup_prepare()
 
 	rp1_mac=$(mac_get $rp1)
 
+	# Reload to ensure devlink-trap settings are back to default.
+	defer devlink_reload
+
 	vrf_prepare
+	defer vrf_cleanup
 
 	h1_create
 	h2_create
@@ -122,21 +115,6 @@ setup_prepare()
 	router_create
 }
 
-cleanup()
-{
-	pre_cleanup
-
-	router_destroy
-
-	h2_destroy
-	h1_destroy
-
-	vrf_cleanup
-
-	# Reload to ensure devlink-trap settings are back to default.
-	devlink_reload
-}
-
 rate_limits_test()
 {
 	RET=0
@@ -214,7 +192,10 @@ __rate_test()
 	# by the policer. Make sure measured received rate is about 1000 pps
 	log_info "=== Tx rate: Highest, Policer rate: 1000 pps ==="
 
+	defer_scope_push
+
 	start_traffic $h1 192.0.2.1 198.51.100.100 $rp1_mac
+	defer stop_traffic $!
 
 	sleep 5 # Take measurements when rate is stable
 
@@ -229,13 +210,16 @@ __rate_test()
 	check_err $? "Expected non-zero policer drop rate, got 0"
 	log_info "Measured policer drop rate of $drop_rate pps"
 
-	stop_traffic
+	defer_scope_pop
 
 	# Send packets at a rate of 1000 pps and make sure they are not dropped
 	# by the policer
 	log_info "=== Tx rate: 1000 pps, Policer rate: 1000 pps ==="
 
+	defer_scope_push
+
 	start_traffic $h1 192.0.2.1 198.51.100.100 $rp1_mac -d 1msec
+	defer stop_traffic $!
 
 	sleep 5 # Take measurements when rate is stable
 
@@ -244,7 +228,7 @@ __rate_test()
 	check_err $? "Expected zero policer drop rate, got a drop rate of $drop_rate pps"
 	log_info "Measured policer drop rate of $drop_rate pps"
 
-	stop_traffic
+	defer_scope_pop
 
 	# Unbind the policer and send packets at highest possible rate. Make
 	# sure they are not dropped by the policer and that the measured
@@ -253,7 +237,10 @@ __rate_test()
 
 	devlink trap group set $DEVLINK_DEV group l3_drops nopolicer
 
+	defer_scope_push
+
 	start_traffic $h1 192.0.2.1 198.51.100.100 $rp1_mac
+	defer stop_traffic $!
 
 	rate=$(trap_rate_get)
 	(( rate > 1000 ))
@@ -265,7 +252,7 @@ __rate_test()
 	check_err $? "Expected zero policer drop rate, got a drop rate of $drop_rate pps"
 	log_info "Measured policer drop rate of $drop_rate pps"
 
-	stop_traffic
+	defer_scope_pop
 
 	log_test "Trap policer rate"
 }
-- 
2.45.0


