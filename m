Return-Path: <linux-kselftest+bounces-42399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E15BA0E9C
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 19:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 726FB7BA15B
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 17:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE08D315D3B;
	Thu, 25 Sep 2025 17:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n0VRadY9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013057.outbound.protection.outlook.com [40.93.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A1E315D2A;
	Thu, 25 Sep 2025 17:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821682; cv=fail; b=PV9H45s0lSjbIzhpP78amr1QLPdQU6jSBs44n+GTRBqYwMoBlczefA5buzHLJzrlzsVFRuzDHP4QKBi7LBw5SlkVHANJd5qLW1ujG7vRTL0oUTpBOQBWCO6wGpHgXbtI6OMqV58+pLUare96QNtsWPeSq0rmp4w2BIAb9+ocRpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821682; c=relaxed/simple;
	bh=ui8NoFXSlKk7zYzIRuF/xwWSeCFwbWYn6WI4YChzMqU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RNOacmYRBQjcb0bZ/l88B/1dRjstHWTGRUcjL7phZjMUHvkbMCftvLvxnf54S5xvb8QHHWAXjoHI/Rq6G11N7kWXNwWHNPqm5rJbid+yguT5SasMMRoNsf4AdMhvx/N9K+mCre/HLYWSmdNeX+K5P3sTY8ETJtBndn1ifVBn6dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n0VRadY9; arc=fail smtp.client-ip=40.93.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBZRvt1/JGwqSo9iXsg42zMWsKFh+ud51gARihaQouFwfdOeYOC2tVkJu86Y/ht1Q188JNQ5S89owCFaAONHZgmmrDI2s2VfSbxax38EKkG1y0IsavQznMCq0UrHLe7lNfCHDX6BGqx8E+r5Nk3mjn0WUgm3q6ooa6rqfIozIvpyAM9KQ0qtCaTxg5DPdH4hRxhbYcnrDOYwho4Abd97OMBj3n/D3Z9giCGMmq3oGEL5+2Eq9f9mDWWFGbu7WWtGdils4Zg3ThOO+2zYioK6FAVe7F0wMxJ1DEfLbf1D5KSF1QlBHD5hyM8XJuWIfaS/c5l+pF5CGrwp9HJTo8fMMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Vq+reGsThOy8crraLWc1x0tc06NXoS3euYihCtIXpk=;
 b=fFT8T6KG3kgP+UtYfurRAI0qvnPfyoTSF+K2GwRE1zbNMIQ4ImUHOpx9owWp7x3ko+ng1eh3A7Ru2aCmHoTdDj5VeaMEx+Cazgxf4aj2eUJFTBoz9TBmOOuVtfrn3OVYnqd4KIPW8uOQGNR6S6QUmlhZdWeA2V/QU1i3iSBBZQUkAkEZsL7n30DMY0KfRA/2B7so067LQKvoq8v9HdZYA5SJDH+SwxxJNRQIrdSIXr4dlytMAXKrKdZa2bs9PPMBxx5H/o4mYmnm4vLKuhjK/oIdAqy73l34t55JlJAI2p7X+WSqqRrQ0lqkM5c6kTb3uzk8o+DD7IESeu7aGYXt1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Vq+reGsThOy8crraLWc1x0tc06NXoS3euYihCtIXpk=;
 b=n0VRadY9vR4q1cJomNk+wHhzNT54QLsDWbLoDdy+871G5x445lM41ZXzDXMWoJX/ZdkC6UCxUzzqngH4wnC+x39aeXtAiEtBZEG/gIjXPH9LFyX9WeMZC3zssd2YpXGzbpuk7NDB84A/awbEkAeicJtHZTAYInTdVSmqLwdKkcq8njYAzGIDi+bop0MQKCGyDTP408jXHN+n1mAFix45BKTkHfHea7FeVp6NVHX8EwGEoGJ4McOlY1whpZZU54PIXyo+F6VY5DrwJcF/EfbL4vJ3gHqU5f5wLWY94POgTNzCvQmwYNdclQTECpam9GGH1JRUBD6UVCvpd7X+Y8raGw==
Received: from BLAPR03CA0176.namprd03.prod.outlook.com (2603:10b6:208:32f::26)
 by MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Thu, 25 Sep
 2025 17:34:38 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::82) by BLAPR03CA0176.outlook.office365.com
 (2603:10b6:208:32f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Thu,
 25 Sep 2025 17:34:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 17:34:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Thu, 25 Sep
 2025 10:34:20 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Sep
 2025 10:34:13 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"Nikolay Aleksandrov" <razor@blackwall.org>, Petr Machata <petrm@nvidia.com>,
	"Shuah Khan" <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<mlxsw@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Alessandro Zanni
	<alessandro.zanni87@gmail.com>, Hangbin Liu <liuhangbin@gmail.com>, "David
 Yang" <mmyangfl@gmail.com>, Li Shuang <shuali@redhat.com>
Subject: [PATCH net-next 10/13] selftests: forwarding: lib: Add an autodefer variant of vrf_prepare()
Date: Thu, 25 Sep 2025 19:31:53 +0200
Message-ID: <2f2000e54ae700d560a8d6128322dade3bd2207e.1758821127.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758821127.git.petrm@nvidia.com>
References: <cover.1758821127.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|MN2PR12MB4358:EE_
X-MS-Office365-Filtering-Correlation-Id: 89a9fc82-2254-4aab-9289-08ddfc59cd56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Y+1x8ssEQqkPV/KbWJaWdfSysEOeOLmrsdfNy0FWXPsetpkKJWJPO4FAcjM?=
 =?us-ascii?Q?JUpqjcgk4ax0xiQsFez0p8k/SeFkiVFwMC5iEjyfcFwssdBqotNREiuhPWtX?=
 =?us-ascii?Q?r2eHacLxgFR5OLK1QkM3Wz9rtCqOvolflfKhXlzGiKSJPv4tlyRc//Qcq2d4?=
 =?us-ascii?Q?HSL0UWRG7o451H6JTrB+LYnnxSIK9N6isuWZwwEOvFNOOzhHUYZhAb5mK/6J?=
 =?us-ascii?Q?7iMTawf4c0MMoU7ZC/LVCBW8g/xP7i31o3Xo8moPgQgr8ut/BkC14t/nUmIW?=
 =?us-ascii?Q?7t+5MABZgShMD0GdfdoGgqM0GLbOSkzr9Qyd3tI7+NP7NfxfI8zzEgmfOPPV?=
 =?us-ascii?Q?qDByqhATWw0gyoyH8X6bnZFIA36Ob+s/uzewbnPcs46SSBV0e/RBUyO+igqP?=
 =?us-ascii?Q?Ml4XD4pQisx0tqrK17f8xjgQxB+5kMSam32Y1MfTuiYKUbd7GvGB4+NfxM1l?=
 =?us-ascii?Q?hYgz5dgDn74Tt5BXdHiW75rMDiBDWcvKnz99UV2N/t2g/AHhBJNaIpyJJLOX?=
 =?us-ascii?Q?1MOqP+MLTsZQVvgS/f1g8+WZ8kwC2gGV535vYZoWfUrT5CMhxcgke9Rg7QnW?=
 =?us-ascii?Q?ZOLNJFlodVv1DD7X3lkrWmgcbo5sYnCqQLddGocOFGQcR3RhwhivmVWuMQHJ?=
 =?us-ascii?Q?P7T8wpLGJ7JV3J+Vxl47i3nYxXrNF6lVJYlHIOMEIBH84oaLHD3fUJ6Ikmdr?=
 =?us-ascii?Q?puu9w21xZnYbmCa300tQ4HPyoHPver/oM8zIl4hUy11nKw0NBdj4oocbkDh2?=
 =?us-ascii?Q?ZZe8ccYlQpd3ZJwdJ+mOjPeFg49rLQdYXrvNwrtiJ/pSMZGL/oSi2bp5hjLy?=
 =?us-ascii?Q?2M684OJ9tliAtOeDUuOncW/Itb94twJUMCroG6SZN8yEjIP5oETMAXTzvBeE?=
 =?us-ascii?Q?c5Yn/vCYWZn5AH7vVK4vrJTtSotNFq9N4aZiIr2oaqactgfvVRrvsOGzG6YG?=
 =?us-ascii?Q?msHrSiq7dGa5Vuf8TkumU5wBWL+jgTeI+/1twlES5edx5GsoOujK4NmKw0rp?=
 =?us-ascii?Q?0da3iKTcc0EsCNn+s5wx7sQomCEIujkwfLIrgU44tGu9UPFhgciaoLOz0Fs7?=
 =?us-ascii?Q?w9WRW3yPETw/Z1I8DWWC9PJL4tHKIOozzFVX5Qnky6Epefn3unuVq6/VqZUO?=
 =?us-ascii?Q?NTGJIi4nKtts5waGfMBPJHDRs74A+Qc19/TcnHUMtAFEDcN/Np2vO9sqJiQf?=
 =?us-ascii?Q?AjEfy8mHoMf5XbchalVjXZUAoSUqcwMX3jf8cbcLiFIz4ktrlrMyw3AJgRNt?=
 =?us-ascii?Q?sKruMcdlCaksChlJ+B8Ve2NjjKkT6MbJYEiGCaEoKT9W8CcI3OAQzfbxYm1V?=
 =?us-ascii?Q?hc0kPQZBXOKtZjDptw7UQTOj1mUheCiFS+mM7mFjvvhDyBYgOBVxCebqGds1?=
 =?us-ascii?Q?8ZcVm1ir64jocVPiFOCOLuXc88qUdJ/IFgy1LTqCDawgNc5cVJ6ew2pqoGpR?=
 =?us-ascii?Q?WqXcR/uMBVLLZEDuyqZMmZA61ClIG8FR7i9HI7msNuYub8G9SCL/3J9smFUx?=
 =?us-ascii?Q?fYKfiHRhxHoDlV+87Ex7/M+G9ioV9hIGWXw71wZ1w+c3fY59e1TN9DiBSsan?=
 =?us-ascii?Q?e5lHfCWND+tWtJ0Iu2I=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 17:34:38.1796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a9fc82-2254-4aab-9289-08ddfc59cd56
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358

Most forwarding tests invoke vrf_prepare() to set up VRF forwarding and
vrf_cleanup() to restore the original configuration. Add a helper,
adf_vrf_prepare(), which is like vrf_prepare(), but takes care of
scheduling the cleanup automatically.

Convert a number of tests that currently use defer to schedule the cleanup.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
CC: Andrew Lunn <andrew+netdev@lunn.ch>
CC: Alessandro Zanni <alessandro.zanni87@gmail.com>
CC: Hangbin Liu <liuhangbin@gmail.com>
CC: David Yang <mmyangfl@gmail.com>
CC: Li Shuang <shuali@redhat.com>

 .../selftests/drivers/net/mlxsw/devlink_trap_policer.sh     | 3 +--
 tools/testing/selftests/drivers/net/mlxsw/qos_ets_strict.sh | 3 +--
 .../selftests/drivers/net/mlxsw/qos_max_descriptors.sh      | 3 +--
 tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh   | 3 +--
 tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh   | 3 +--
 .../selftests/net/forwarding/bridge_activity_notify.sh      | 3 +--
 .../selftests/net/forwarding/bridge_fdb_local_vlan_0.sh     | 3 +--
 tools/testing/selftests/net/forwarding/lib.sh               | 6 ++++++
 tools/testing/selftests/net/forwarding/sch_ets_core.sh      | 3 +--
 tools/testing/selftests/net/forwarding/sch_red.sh           | 3 +--
 tools/testing/selftests/net/forwarding/sch_tbf_core.sh      | 3 +--
 .../selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh       | 3 +--
 tools/testing/selftests/net/forwarding/vxlan_reserved.sh    | 3 +--
 13 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_policer.sh b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_policer.sh
index 29a672c2270f..6cb5a7a7438b 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_policer.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_policer.sh
@@ -106,8 +106,7 @@ setup_prepare()
 	# Reload to ensure devlink-trap settings are back to default.
 	defer devlink_reload
 
-	vrf_prepare
-	defer vrf_cleanup
+	adf_vrf_prepare
 
 	h1_create
 	h2_create
diff --git a/tools/testing/selftests/drivers/net/mlxsw/qos_ets_strict.sh b/tools/testing/selftests/drivers/net/mlxsw/qos_ets_strict.sh
index d5b6f2cc9a29..ed217eb63cc7 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/qos_ets_strict.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/qos_ets_strict.sh
@@ -225,8 +225,7 @@ setup_prepare()
 
 	h3mac=$(mac_get $h3)
 
-	vrf_prepare
-	defer vrf_cleanup
+	adf_vrf_prepare
 
 	h1_create
 	h2_create
diff --git a/tools/testing/selftests/drivers/net/mlxsw/qos_max_descriptors.sh b/tools/testing/selftests/drivers/net/mlxsw/qos_max_descriptors.sh
index 2b5d2c2751d5..d10df3a19300 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/qos_max_descriptors.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/qos_max_descriptors.sh
@@ -178,8 +178,7 @@ setup_prepare()
 
 	h2mac=$(mac_get $h2)
 
-	vrf_prepare
-	defer vrf_cleanup
+	adf_vrf_prepare
 
 	h1_create
 	h2_create
diff --git a/tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh b/tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh
index cd4a5c21360c..6aca01ebb1ee 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh
@@ -196,8 +196,7 @@ setup_prepare()
 
 	h3mac=$(mac_get $h3)
 
-	vrf_prepare
-	defer vrf_cleanup
+	adf_vrf_prepare
 
 	h1_create
 	h2_create
diff --git a/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh b/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
index 537d6baa77b7..a88d61a84b98 100644
--- a/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
@@ -250,8 +250,7 @@ setup_prepare()
 
 	h3_mac=$(mac_get $h3)
 
-	vrf_prepare
-	defer vrf_cleanup
+	adf_vrf_prepare
 
 	h1_create
 	h2_create
diff --git a/tools/testing/selftests/net/forwarding/bridge_activity_notify.sh b/tools/testing/selftests/net/forwarding/bridge_activity_notify.sh
index 8ceb205fdca0..afce1c964d5a 100755
--- a/tools/testing/selftests/net/forwarding/bridge_activity_notify.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_activity_notify.sh
@@ -57,8 +57,7 @@ setup_prepare()
 	swp2=${NETIFS[p3]}
 	h2=${NETIFS[p4]}
 
-	vrf_prepare
-	defer vrf_cleanup
+	adf_vrf_prepare
 
 	h1_create
 	h2_create
diff --git a/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh b/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
index c1a506370c4a..052b2f757ff0 100755
--- a/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
@@ -98,8 +98,7 @@ setup_prepare()
 	swp3=${NETIFS[p5]}
 	h3=${NETIFS[p6]}
 
-	vrf_prepare
-	defer vrf_cleanup
+	adf_vrf_prepare
 
 	forwarding_enable
 	defer forwarding_restore
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 2c252423b326..1370d7a32655 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -599,6 +599,12 @@ vrf_cleanup()
 	ip -4 rule del pref 32765
 }
 
+adf_vrf_prepare()
+{
+	vrf_prepare
+	defer vrf_cleanup
+}
+
 __last_tb_id=0
 declare -A __TB_IDS
 
diff --git a/tools/testing/selftests/net/forwarding/sch_ets_core.sh b/tools/testing/selftests/net/forwarding/sch_ets_core.sh
index 8f9922c695b0..f9d15b2f4615 100644
--- a/tools/testing/selftests/net/forwarding/sch_ets_core.sh
+++ b/tools/testing/selftests/net/forwarding/sch_ets_core.sh
@@ -251,8 +251,7 @@ setup_prepare()
 	put=$swp2
 	hut=$h2
 
-	vrf_prepare
-	defer vrf_cleanup
+	adf_vrf_prepare
 
 	h1_create
 	h2_create
diff --git a/tools/testing/selftests/net/forwarding/sch_red.sh b/tools/testing/selftests/net/forwarding/sch_red.sh
index af166662b78a..8f79a86cb15b 100755
--- a/tools/testing/selftests/net/forwarding/sch_red.sh
+++ b/tools/testing/selftests/net/forwarding/sch_red.sh
@@ -125,8 +125,7 @@ setup_prepare()
 
 	h3_mac=$(mac_get $h3)
 
-	vrf_prepare
-	defer vrf_cleanup
+	adf_vrf_prepare
 
 	h1_create
 	h2_create
diff --git a/tools/testing/selftests/net/forwarding/sch_tbf_core.sh b/tools/testing/selftests/net/forwarding/sch_tbf_core.sh
index ec309a5086bc..bce9ab3cb24a 100644
--- a/tools/testing/selftests/net/forwarding/sch_tbf_core.sh
+++ b/tools/testing/selftests/net/forwarding/sch_tbf_core.sh
@@ -149,8 +149,7 @@ setup_prepare()
 
 	h2_mac=$(mac_get $h2)
 
-	vrf_prepare
-	defer vrf_cleanup
+	adf_vrf_prepare
 
 	h1_create
 	h2_create
diff --git a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
index a968a3ecbcbf..9beb5d512b8e 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
@@ -371,8 +371,7 @@ setup_prepare()
 	swp3=${NETIFS[p5]}
 	h3=${NETIFS[p6]}
 
-	vrf_prepare
-	defer vrf_cleanup
+	adf_vrf_prepare
 
 	forwarding_enable
 	defer forwarding_restore
diff --git a/tools/testing/selftests/net/forwarding/vxlan_reserved.sh b/tools/testing/selftests/net/forwarding/vxlan_reserved.sh
index 6fa1668986cc..c564d7a3af0b 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_reserved.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_reserved.sh
@@ -88,8 +88,7 @@ setup_prepare()
 	rp1=${NETIFS[p3]}
 	rp2=${NETIFS[p4]}
 
-	vrf_prepare
-	defer vrf_cleanup
+	adf_vrf_prepare
 
 	forwarding_enable
 	defer forwarding_restore
-- 
2.49.0


