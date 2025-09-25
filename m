Return-Path: <linux-kselftest+bounces-42391-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C62BA0E6C
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 19:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC3411C25012
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 17:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360C8312804;
	Thu, 25 Sep 2025 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j+Kxlh1l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011024.outbound.protection.outlook.com [52.101.62.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54319312826;
	Thu, 25 Sep 2025 17:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821639; cv=fail; b=MNTlsqFKXaxdGBX/jZHf+ocVn3vODyTJgWKUhmH1sO/jUFpK8EMhOr6faWEpQAl4p9HTunyWXN8jyTvgY8d7fnU0a4B5l/CiIi1mMxOn99FbNm3hS396K3YjXSlHNVGvk1CEAgNVwEmKdsMecX+oeTWeXLE/mKGZVqEb/lV8ejU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821639; c=relaxed/simple;
	bh=PFz0ll0eGyTDlydbw3o+Yv1tIYvjJ9Vw3iH2ksQZY2Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gb2cV4vyfGIgHb+S7l50RW6lYaX05WzfueA/nKK1FkauBYZK98bXGXbc5L3cX3wlB9vJNvKWiAXVxR5l6tfESsECzmQD1IqGAZPoFGygKW4jNk7Ui7XiLVzg/V2CghXocfPwL59b7NnHlMSUCxPGN+FpKxyfa+KriumAj12FlM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j+Kxlh1l; arc=fail smtp.client-ip=52.101.62.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJ7OTqgItv1t++EKWFkK9KUWTJE1xCgyWs5MFoGLiSpTEaPglrsqh92uQcc6IDKePsNjlj1Vw4FodRDHu4qJ/qixH++Ivqwu1Qpexpdmd9/KyXLasgF+8iDrPXzsVHRYP4fNVDXU9SKw4ubpjl8OOVG7WrQMZpOItjMiWCbf0dmf9KR4MeBEny9FDb/o14FJBCtWefIx+rRGB2laCTd17vJcHJnRm9X/D31/YQ+M2e1SdFwhopdHSGtedM1ea1Rf2IKkq2sH6qWIbHQT7UvnAVXOa5sO141o2DjAk9tqyQT8xZl34U/OV7IoeD2X2qX6/fz9rhHG/Z0/Pmzp6U4WaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdsHnt56zFrF6eOEohotWarMnZ6zdUxrHlL7L20fEV0=;
 b=ZX3vCTNcoiyrWaezFcao/8tAkyDDUNYw5KvB7hrqUTEQDsHwtaFOAicx8Pm+S5yl+zQeBrfhrmdTNcR5VcIdWx/fP8Ozz2NHieSxo2gZZ9YU80qkOAz6Mobn/o0RUTH0EcmBpeK7zollHda6vlTAV5g1CelQB1xtY0colMIAE0NK1jcAYo1dr9OZjfAyrftOLe0zHp1Vwtl1oRkehASI5Rp24F8WlScSzChIPbZez0nLDD5E28B2azZzj826zN44sZ384fyVMIohSALt6Xq49LCCk8iwsdZH0wAnzFmPoUW3Zf1BOzFVNeL58iXlVu2VWVFqUlg1xMxBJkZZVCkm2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdsHnt56zFrF6eOEohotWarMnZ6zdUxrHlL7L20fEV0=;
 b=j+Kxlh1lxvzhjPnDmSdjZgvkYCDXprNQO+zMXrgiAzrAhleqLeJnfOJ3psYthTP8Mvibe2Uw581PNje2eBzLECBQffeHdZkjFJ06ZR5UgifYY5boj/+fqQ4knnGQigBUaxhnuvbtCmFkDFC6AkLBgpoelKCzmMSINJccWfn31hBFn4FJctwir3LoZ3ycza55mW8JrE27YbbaA1890pyqXnoAW+UH6ddrk4+bcM96CM4A5r9Tht8QvFDSHWKPZDmoW9/LagrPsSTikx/h4Y3bwRoqYEERC5fU29BLrdTxoRxDYeNC/TLKnuGqp3JnXKKtZmD+BRTDXUd3e+gHvgt9GA==
Received: from CH2PR17CA0013.namprd17.prod.outlook.com (2603:10b6:610:53::23)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 17:33:54 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::e5) by CH2PR17CA0013.outlook.office365.com
 (2603:10b6:610:53::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Thu,
 25 Sep 2025 17:33:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 17:33:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 25 Sep
 2025 10:33:35 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Sep
 2025 10:33:30 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"Nikolay Aleksandrov" <razor@blackwall.org>, Petr Machata <petrm@nvidia.com>,
	"Shuah Khan" <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 02/13] selftests: net: lib: Rename ip_link_set_master() to adf_*
Date: Thu, 25 Sep 2025 19:31:45 +0200
Message-ID: <53ce64231faa1396a968b2869af5f1c0aebec2c9.1758821127.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|DM6PR12MB4042:EE_
X-MS-Office365-Filtering-Correlation-Id: 61097a1b-c923-4c3d-f873-08ddfc59b2be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+MsCmZJo5EpGh9Mkym0KUFTyaeLYMOmcYMMDgtusWRWwfQ4Tcg3aYmF1HvJQ?=
 =?us-ascii?Q?26Q3yLc0dRkCa12YqYyxmVdJIrneb0Ypl+LEt+saah6AJ7Ll4+Lr8OcHds92?=
 =?us-ascii?Q?JW5eFkWPPg8/bVtYtie1yhWe/lWQAHBTXfPM/UyeKMWfZNAn6yN/jtysmwy/?=
 =?us-ascii?Q?7kC11l4/228m0huKAXBD4yPmIrUErTwq+HbjHzX+8+DqDK+lIi9JYSUrx1n5?=
 =?us-ascii?Q?csHmnlXBvJKTwL9Wx3lbFImdqOiIoFQRWdXQ8tkk1wzJK4L2xJKVansLzUlr?=
 =?us-ascii?Q?nij/q6QvasA48xN9UQbDDnKV/RZmDfNHg711iPCAkdxo3wFPo5e/svkPUMV+?=
 =?us-ascii?Q?fKHCx+ObkQM29meLoTKEQTd9zONmidkvjmNtD4WQx9+qmy8oght812oAyB7H?=
 =?us-ascii?Q?w0FHHqez0F72S5w3IdtN+bwwHdjxQxPR5Anh4U1tk5a1A/Hgv1NUprnI1d2f?=
 =?us-ascii?Q?kKB2GBrdZwgIMd6AvXyGQ+jD9SKFQed8MRFCV7sVPpn1UHLMxyUSSJNi8QGW?=
 =?us-ascii?Q?FAiPaVaqK9MrQb/ZYUphYeLMo3leJsUqMcW9Pz1ohpq0JUKBtfOUe0IwMp2x?=
 =?us-ascii?Q?ECVRONfGfHuE0nNkLMfuj2Y3S8m4xoaYnA67adxaZxDWsXrsE1V9Ik3uOXXm?=
 =?us-ascii?Q?IFboYJONzbVn/PWdJMJ/s+WNvkCEDweNdFeWR2it8VHDqI7/IzPOQnPf7KBC?=
 =?us-ascii?Q?scKZsORvYZeq3nh07JX4W/p7YQh+x6Ss0/MAjjoOirUuWGc5oIVtLVruyW2q?=
 =?us-ascii?Q?ZfpB8EDiCbB1dvf66dUquXuBQ0RnxA89d1T5sToZhXKOS+B+DhhQXKRqB0zh?=
 =?us-ascii?Q?I4KCz2jfnmioysD1cDfsBRlYACeUw6+kQiwWY00eR5Y+JBv3IYhTp3i0gEUz?=
 =?us-ascii?Q?wA3d51/+cMm3ZREV++QsQfxAn3r/iFRbHmT3b6W1OQcooFVACO26cQyv7WYj?=
 =?us-ascii?Q?IE8W8SjTldAjRc2rtVhK1/JRs5D9b+ZF+cO8rGFvakmcIy1OMdof94ViDqIo?=
 =?us-ascii?Q?TGVn4nXL/TfpaV/KnHuCrla0zzVQt/1NJvOxecjaavS07ZYfDvBF+LdjvKou?=
 =?us-ascii?Q?YyIWwg9b3TZ/W6l/B+YVqymVuaV6t/SP4Qf9/cBgIvI5RzmRYuzUq9rrntvZ?=
 =?us-ascii?Q?k/W2OxtRYLj+RgLCAk2gkd8ae4mXqaKVP0//Gt18YEAuOJmd2j1EGHADxN3W?=
 =?us-ascii?Q?em7qA/rnvHg1MM8fJvSF7kH+sQcvexWV9N2UGdWs2nZYxh3uj/5WlUZKiPyw?=
 =?us-ascii?Q?/mloI6ujq9xOzMbKLX8Lt1McoiHuNH0PIRwtTLXymaCZW7k+bDm7SbOApp+L?=
 =?us-ascii?Q?rpVnZu9fRMPfhSBqVPmCAwTFxdn65gfJgeoLp1NCI/csUO0z3lUksVm3Gxwa?=
 =?us-ascii?Q?Z6HHf6p6qv/bNyDQ6xnR3XMSzrdUE7wDV7+C3PghFy4jUbJ3pEb+jMzDy615?=
 =?us-ascii?Q?kiVOEMqDSNkU/PyqANqwN3lviFYIyoVY+5I/WG4w5N9DxSihrO69Ein/DWx7?=
 =?us-ascii?Q?o5cwNQ5fGMP+T9vE06OLpdrrxl+1GrZ5nnzj?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 17:33:53.6027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61097a1b-c923-4c3d-f873-08ddfc59b2be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042

Rename this function to mark it as autodefer.
For details, see the discussion in the cover letter.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/fdb_notify.sh      |  6 +++---
 .../net/forwarding/bridge_activity_notify.sh   |  4 ++--
 .../net/forwarding/bridge_fdb_local_vlan_0.sh  |  2 +-
 .../net/forwarding/vxlan_bridge_1q_mc_ul.sh    | 18 +++++++++---------
 .../selftests/net/forwarding/vxlan_reserved.sh |  4 ++--
 tools/testing/selftests/net/lib.sh             |  2 +-
 .../selftests/net/vlan_bridge_binding.sh       |  2 +-
 7 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/net/fdb_notify.sh b/tools/testing/selftests/net/fdb_notify.sh
index 0a70f6383bfc..0b8a2465dd04 100755
--- a/tools/testing/selftests/net/fdb_notify.sh
+++ b/tools/testing/selftests/net/fdb_notify.sh
@@ -49,7 +49,7 @@ test_dup_vxlan_self()
 {
 	adf_ip_link_add br up type bridge vlan_filtering 1
 	adf_ip_link_add vx up type vxlan id 2000 dstport 4789
-	ip_link_set_master vx br
+	adf_ip_link_set_master vx br
 
 	do_test_dup add "vxlan" dev vx self dst 192.0.2.1
 	do_test_dup del "vxlan" dev vx self dst 192.0.2.1
@@ -59,7 +59,7 @@ test_dup_vxlan_master()
 {
 	adf_ip_link_add br up type bridge vlan_filtering 1
 	adf_ip_link_add vx up type vxlan id 2000 dstport 4789
-	ip_link_set_master vx br
+	adf_ip_link_set_master vx br
 
 	do_test_dup add "vxlan master" dev vx master
 	do_test_dup del "vxlan master" dev vx master
@@ -79,7 +79,7 @@ test_dup_macvlan_master()
 	adf_ip_link_add br up type bridge vlan_filtering 1
 	adf_ip_link_add dd up type dummy
 	adf_ip_link_add mv up link dd type macvlan mode passthru
-	ip_link_set_master mv br
+	adf_ip_link_set_master mv br
 
 	do_test_dup add "macvlan master" dev mv self
 	do_test_dup del "macvlan master" dev mv self
diff --git a/tools/testing/selftests/net/forwarding/bridge_activity_notify.sh b/tools/testing/selftests/net/forwarding/bridge_activity_notify.sh
index 6f7df6325da5..3d5f868b261a 100755
--- a/tools/testing/selftests/net/forwarding/bridge_activity_notify.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_activity_notify.sh
@@ -42,10 +42,10 @@ switch_create()
 		ageing_time "$LOW_AGEING_TIME"
 	ip_link_set_up br1
 
-	ip_link_set_master "$swp1" br1
+	adf_ip_link_set_master "$swp1" br1
 	ip_link_set_up "$swp1"
 
-	ip_link_set_master "$swp2" br1
+	adf_ip_link_set_master "$swp2" br1
 	ip_link_set_up "$swp2"
 }
 
diff --git a/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh b/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
index d9de3ad6e162..561cb9f253b6 100755
--- a/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
@@ -123,7 +123,7 @@ adf_bridge_configure()
 	bridge_vlan_add dev br vid 3 self
 
 	for dev in "$swp1" "$swp2"; do
-		ip_link_set_master "$dev" br
+		adf_ip_link_set_master "$dev" br
 		bridge_vlan_add dev "$dev" vid 1 pvid untagged
 		bridge_vlan_add dev "$dev" vid 2
 		bridge_vlan_add dev "$dev" vid 3
diff --git a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
index 503b1176d55f..9fc956caf961 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
@@ -162,16 +162,16 @@ h2_create()
 
 	# br2
 	adf_ip_link_add br2 type bridge vlan_filtering 0 mcast_snooping 0
-	ip_link_set_master br2 "v$h2"
+	adf_ip_link_set_master br2 "v$h2"
 	ip_link_set_up br2
 
 	# $h2
-	ip_link_set_master "$h2" br2
+	adf_ip_link_set_master "$h2" br2
 	install_capture "$h2"
 
 	# v1$h2
 	ip_link_set_up "v1$h2"
-	ip_link_set_master "v1$h2" br2
+	adf_ip_link_set_master "v1$h2" br2
 }
 
 h3_create()
@@ -187,16 +187,16 @@ h3_create()
 
 	# br3
 	adf_ip_link_add br3 type bridge vlan_filtering 0 mcast_snooping 0
-	ip_link_set_master br3 "v$h3"
+	adf_ip_link_set_master br3 "v$h3"
 	ip_link_set_up br3
 
 	# $h3
-	ip_link_set_master "$h3" br3
+	adf_ip_link_set_master "$h3" br3
 	install_capture "$h3"
 
 	# v1$h3
 	ip_link_set_up "v1$h3"
-	ip_link_set_master "v1$h3" br3
+	adf_ip_link_set_master "v1$h3" br3
 }
 
 switch_create()
@@ -221,7 +221,7 @@ switch_create()
 
 	# $swp1
 	ip_link_set_up "$swp1"
-	ip_link_set_master "$swp1" br1
+	adf_ip_link_set_master "$swp1" br1
 	bridge_vlan_add vid 10 dev "$swp1"
 	bridge_vlan_add vid 20 dev "$swp1"
 
@@ -244,7 +244,7 @@ vx_create()
 	adf_ip_link_add "$name" up type vxlan dstport "$VXPORT" \
 		nolearning noudpcsum tos inherit ttl 16 \
 		"$@"
-	ip_link_set_master "$name" br1
+	adf_ip_link_set_master "$name" br1
 	bridge_vlan_add vid "$vid" dev "$name" pvid untagged
 }
 export -f vx_create
@@ -305,7 +305,7 @@ ns_init_common()
 
 	# w1
 	adf_ip_link_add w1 type veth peer name w2
-	ip_link_set_master w1 br1
+	adf_ip_link_set_master w1 br1
 	ip_link_set_up w1
 	bridge_vlan_add vid 10 dev w1
 	bridge_vlan_add vid 20 dev w1
diff --git a/tools/testing/selftests/net/forwarding/vxlan_reserved.sh b/tools/testing/selftests/net/forwarding/vxlan_reserved.sh
index 692644c3a489..839def391b6e 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_reserved.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_reserved.sh
@@ -70,7 +70,7 @@ switch_create()
 	ip_addr_add $rp1 192.0.2.17/28
 	ip_route_add 192.0.2.32/28 nexthop via 192.0.2.18
 
-	ip_link_set_master $swp1 br1
+	adf_ip_link_set_master $swp1 br1
 	ip_link_set_up $swp1
 }
 
@@ -203,7 +203,7 @@ vxlan_device_add()
 	adf_ip_link_add vx1 up type vxlan id 1000		\
 		local 192.0.2.17 dstport "$VXPORT"	\
 		nolearning noudpcsum tos inherit ttl 100 "$@"
-	ip_link_set_master vx1 br1
+	adf_ip_link_set_master vx1 br1
 }
 
 vxlan_all_reserved_bits()
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 7fbd9e5ce2be..c9a15fe5448a 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -551,7 +551,7 @@ adf_ip_link_add()
 		defer ip link del dev "$name"
 }
 
-ip_link_set_master()
+adf_ip_link_set_master()
 {
 	local member=$1; shift
 	local master=$1; shift
diff --git a/tools/testing/selftests/net/vlan_bridge_binding.sh b/tools/testing/selftests/net/vlan_bridge_binding.sh
index 7797507cd14f..ad02d406039c 100755
--- a/tools/testing/selftests/net/vlan_bridge_binding.sh
+++ b/tools/testing/selftests/net/vlan_bridge_binding.sh
@@ -24,7 +24,7 @@ setup_prepare()
 		adf_ip_link_add $port type veth peer name r$port
 		ip_link_set_up $port
 		ip_link_set_up r$port
-		ip_link_set_master $port br
+		adf_ip_link_set_master $port br
 	done
 
 	bridge_vlan_add vid 11 dev br self
-- 
2.49.0


