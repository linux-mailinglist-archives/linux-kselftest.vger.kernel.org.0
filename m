Return-Path: <linux-kselftest+bounces-42390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E449BA0E87
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 19:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1FED4A18BA
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 17:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB3A3126C1;
	Thu, 25 Sep 2025 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OqY4unkM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010039.outbound.protection.outlook.com [52.101.56.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27EF30F812;
	Thu, 25 Sep 2025 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821635; cv=fail; b=RrtMIa+P241CQ6GXWy96+JpHLG66XtmdPMrMWUOBaRWwcSVDFDIo5h1fhP+t/+XOzixAerkvq5yMweiePS65GTbdUWS10ffDDGFlGtgELtXzbB1QqbNGa2w38gO1qfoFa0DlQqxl+0X1hkF3fMZ3A1hhMLtKwxWds/AkX4Y9sNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821635; c=relaxed/simple;
	bh=jwTZFOlgkChV3JHdTlZNbZpG+76jwbQUeqhWCGbekK0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pn1cOy7CGK5NbEX9m5dbZpd/ISDHbzjiys2EiRQe3FYWOaZxknqx6jauhXtMNNhEg8gxU8Uf7HtgMisjtK3qqudSMgpD1hGg3G0zEdyfkb1HvHhZ4tSHuKcsrr7QBATtAtAIpzRib9dzw0g1a2LVSIMZLrj8II9ultN9U1uwnsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OqY4unkM; arc=fail smtp.client-ip=52.101.56.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yy1OGVConngJFsbojH5wxVJ6EyyXo/rEt6SbfNu18u4wiXfVO81yKLbzdJh6qn7zAbJSEOX+DPEQp3S7uul2WNkC3h6SqNB2/9eyZbaw/hyjt7DwG5iyd5txQtFTPi0d9VH8IP7L7zdv7+GxIVcuV4qsv1oCgq4AtqAWo6AcQ7/dyYSuduQ6v3x3m697WtLI7KkKV2ayrS7KXF2NLX3fMYtQn7ihfysrRr3E5ONgOfflnJ5Lw+tgR51PkpqcXL4hndAf2f2b6ogCjjJNO2QEia1AdOwPH5BDIahJyansr06QjHw4DSTUvZshKG9/DwjiuVdEkLTJDaTv0bH06HBrHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncTN+GXpq5pxfIScfO6zahJoz8BSp8/l0Aok5moy0WI=;
 b=REAwJo/gag+uSyMfe0fyRWc2MjGwBsIAaxnSNpunxYI3LfOc7udnUy5Qs69EI3SS6urHuCxP9+ahMCbXTiKOCbnMARinksHowFQ7rN7xup8L1l+z4ImjGR1WAUBtOad+RGbynkFtRlORNqR3nbYcWORYbR+ihygWFqSnMSzm2EXozg1qcMsGo12OVgCl8sB1BwHOzAkynZH+fYXS2ClAnlTS9LE5pBquaHrpa/+o3n0Zr2ygjRCvmqw98MmT0YelmQBc27BsOzYllxu+jS6ZcV2K76efYI53+TaRAY97dnhvpr0NvJQgQcU6+vd3H8PcQmbfFtmtrcEbMmxo0/b3zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncTN+GXpq5pxfIScfO6zahJoz8BSp8/l0Aok5moy0WI=;
 b=OqY4unkMc33we89ayBBj9CLAElBAjR1732V+3J6UQsD3zUV5GY7uzEI8fxkRSmUJnMlBiX3G8r5abXoF3Dz1YF3Ub3uFxidE0kJngBgwOWyc42l+UBWsbMv2v3gIV8K2KbZyY98JDwc8FA0IEXma1kTIeuzpa9JRyWNFO5+qQzDX211f84HsnjUkxSNCB5EBbZjIUGBmE81dxtloWGa9hacwxlgooLVSw0IWDcXkEkH4Fq324GAG/dbqgSudUyE4xxB3xMIKAriJE02OWBNKTyf+/MqdiXO3ELhc7phO34KIoNXwXyVkhBRtiUYf7ifuRsp7+fUWcSVLFbTyzrfcNA==
Received: from CH2PR14CA0024.namprd14.prod.outlook.com (2603:10b6:610:60::34)
 by BL4PR12MB9480.namprd12.prod.outlook.com (2603:10b6:208:58d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 17:33:50 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::ba) by CH2PR14CA0024.outlook.office365.com
 (2603:10b6:610:60::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.11 via Frontend Transport; Thu,
 25 Sep 2025 17:33:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 17:33:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 25 Sep
 2025 10:33:30 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Sep
 2025 10:33:25 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"Nikolay Aleksandrov" <razor@blackwall.org>, Petr Machata <petrm@nvidia.com>,
	"Shuah Khan" <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 01/13] selftests: net: lib: Rename ip_link_add() to adf_*
Date: Thu, 25 Sep 2025 19:31:44 +0200
Message-ID: <0b163cca1bf2ec44270e0fc89108f488d99d9c9d.1758821127.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|BL4PR12MB9480:EE_
X-MS-Office365-Filtering-Correlation-Id: b173c936-1433-4a96-d1c7-08ddfc59b008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wBijJrrJw0Uy4gLAbiqFh9IaJeiKyycU9pwTHwixCLVLo4M3aX9QO4JnEaxX?=
 =?us-ascii?Q?qX/NWHxoCdtP3RXdvgW5LQzQVRn+KB4m4DZ0BtD0ByNs1o31WPo9l82qGWIf?=
 =?us-ascii?Q?8pz0kZQPugyIfIioyW2wEMYJF1g5e+53LljovvIhqe4ed/+Z4kxUh/Mtey5j?=
 =?us-ascii?Q?GiBebP8UlRyygDIM2uKGnByuL8SQ/V0R8aBxmg080XeTrGvQKmor7PgJCwCa?=
 =?us-ascii?Q?S2V+mAmzLVXJAP7dxrohLQt5HYLxLDGDo3QJYE29oDlx3f0hzZjJQpPG8rpJ?=
 =?us-ascii?Q?L1SoC/G4SkLYhT3E+U13RxVXVexMF5ZZ1vGEpW5QiTve/ZsoGoLAUQ6xy0EX?=
 =?us-ascii?Q?SQ9bvuoQdrpV21lWb0eprnBYuzshzHERhUzdOaJfYEkL+gRCCtpPIi9s3hkn?=
 =?us-ascii?Q?ORoHs9mHtD7SCaLy+xY8HnhCdKqz3LZOX9MWQMD9/jxLp7nOapPe1Hyk9mY6?=
 =?us-ascii?Q?DHF/HUYuNfGP1IK2D1xNptxp80kbHAQO2qkP8+udLB4tpwRDK1jBNZ0iNfzS?=
 =?us-ascii?Q?iNvJrGqugw0jPzlQX70v4zmG8g4lymX3Q9t3yFLhZSgoGu4bB3KwV00mOn6E?=
 =?us-ascii?Q?GLirWoPUVWA+WxNOYvp3wp904auj5W7YLw6vdJedqsVasnAPy4upZNWVXG+F?=
 =?us-ascii?Q?LDh9OWHGBk+wjlcSlm62YbczPekxQCWX7U+7IOT57C+ooK/xH7mKTYXbQrEJ?=
 =?us-ascii?Q?UhKP64ZkciQiYMKJ085tX+SP0w6sMBlb3Jp7lwYKOnwleAMqw4OKgBIkjaFJ?=
 =?us-ascii?Q?tVGItujgYWYJD3lw8taT1UjDzgqgPt4NJkPZzW7Jxkdney+AMaFOW4P+moLV?=
 =?us-ascii?Q?I49NSO0JYFHIAgEctzCmIZxWmATu+nXnjppIsSBh710oIfjKagpDdgxcgWCb?=
 =?us-ascii?Q?TVlWQcmF+skwytWtC84xbrUmJcbXWT8Dm9W7OWG05te1MFlI2UESzXhK0jfq?=
 =?us-ascii?Q?hOVP38SrpVgSSK1Xks292ns0kjO1x6i4kbTjcqm+MHZ1CE3U/VA98GUPefTj?=
 =?us-ascii?Q?LNDdS46CoN+RqeWRpW7usSqRkTLdNCNVpCrQwoiwlkjwFuAx3bA5l+wZ8Mye?=
 =?us-ascii?Q?XPThtO6XrEmswVK/gPdfFqmqPt6qyrDrcuxIcwz+I6qs+Bo0MAY98gR58G3Z?=
 =?us-ascii?Q?JomPBEj92ecWPNN9M+ahpPw5jDpOD9NHjUvkTpVViusMurVTt5az4yTnJciC?=
 =?us-ascii?Q?xOz3ShNBiPotJTws0f/KUpyEqUHWKZiUFpRs2F37L5c6oMJnzazsmaDCzj/n?=
 =?us-ascii?Q?Ri010f4elhcIVxXQEzLjZJeLkonZqY9EOVD7ZTVHt8M5XWFVmoQxheO9whGt?=
 =?us-ascii?Q?cF9OvwvOS5bn/FgmkPjB+2Zu6pPZi2bCfihu3pUWL8QBH+YUGZHNvIdzjK+Y?=
 =?us-ascii?Q?B/LF1MXtv3qYpwihU+sPvIMwD7QdTT5ztiWqE9WYJ1atyhLpE5x78Z5cY2BA?=
 =?us-ascii?Q?y0bXZXPepRUkwgtqG3fglFpwQ3R7SyRS0XeMHKsk8OgxLyJAWEzzeToYYeQK?=
 =?us-ascii?Q?BpkyIV3woXVeV1DIfTOn8a9TI/ypkxAA//Qq?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 17:33:49.0959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b173c936-1433-4a96-d1c7-08ddfc59b008
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9480

Rename this function to mark it as autodefer.
For details, see the discussion in the cover letter.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/fdb_notify.sh     | 20 ++++++-------
 .../net/forwarding/bridge_activity_notify.sh  |  2 +-
 .../net/forwarding/bridge_fdb_local_vlan_0.sh |  8 +++---
 .../net/forwarding/vxlan_bridge_1q_mc_ul.sh   | 28 +++++++++----------
 .../net/forwarding/vxlan_reserved.sh          |  4 +--
 tools/testing/selftests/net/lib.sh            |  2 +-
 .../net/test_vxlan_fdb_changelink.sh          |  6 ++--
 .../selftests/net/vlan_bridge_binding.sh      |  6 ++--
 8 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/net/fdb_notify.sh b/tools/testing/selftests/net/fdb_notify.sh
index c159230c9b62..0a70f6383bfc 100755
--- a/tools/testing/selftests/net/fdb_notify.sh
+++ b/tools/testing/selftests/net/fdb_notify.sh
@@ -40,15 +40,15 @@ do_test_dup()
 
 test_dup_bridge()
 {
-	ip_link_add br up type bridge vlan_filtering 1
+	adf_ip_link_add br up type bridge vlan_filtering 1
 	do_test_dup add "bridge" dev br self
 	do_test_dup del "bridge" dev br self
 }
 
 test_dup_vxlan_self()
 {
-	ip_link_add br up type bridge vlan_filtering 1
-	ip_link_add vx up type vxlan id 2000 dstport 4789
+	adf_ip_link_add br up type bridge vlan_filtering 1
+	adf_ip_link_add vx up type vxlan id 2000 dstport 4789
 	ip_link_set_master vx br
 
 	do_test_dup add "vxlan" dev vx self dst 192.0.2.1
@@ -57,8 +57,8 @@ test_dup_vxlan_self()
 
 test_dup_vxlan_master()
 {
-	ip_link_add br up type bridge vlan_filtering 1
-	ip_link_add vx up type vxlan id 2000 dstport 4789
+	adf_ip_link_add br up type bridge vlan_filtering 1
+	adf_ip_link_add vx up type vxlan id 2000 dstport 4789
 	ip_link_set_master vx br
 
 	do_test_dup add "vxlan master" dev vx master
@@ -67,8 +67,8 @@ test_dup_vxlan_master()
 
 test_dup_macvlan_self()
 {
-	ip_link_add dd up type dummy
-	ip_link_add mv up link dd type macvlan mode passthru
+	adf_ip_link_add dd up type dummy
+	adf_ip_link_add mv up link dd type macvlan mode passthru
 
 	do_test_dup add "macvlan self" dev mv self
 	do_test_dup del "macvlan self" dev mv self
@@ -76,9 +76,9 @@ test_dup_macvlan_self()
 
 test_dup_macvlan_master()
 {
-	ip_link_add br up type bridge vlan_filtering 1
-	ip_link_add dd up type dummy
-	ip_link_add mv up link dd type macvlan mode passthru
+	adf_ip_link_add br up type bridge vlan_filtering 1
+	adf_ip_link_add dd up type dummy
+	adf_ip_link_add mv up link dd type macvlan mode passthru
 	ip_link_set_master mv br
 
 	do_test_dup add "macvlan master" dev mv self
diff --git a/tools/testing/selftests/net/forwarding/bridge_activity_notify.sh b/tools/testing/selftests/net/forwarding/bridge_activity_notify.sh
index a20ef4bd310b..6f7df6325da5 100755
--- a/tools/testing/selftests/net/forwarding/bridge_activity_notify.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_activity_notify.sh
@@ -38,7 +38,7 @@ h2_create()
 
 switch_create()
 {
-	ip_link_add br1 type bridge vlan_filtering 0 mcast_snooping 0 \
+	adf_ip_link_add br1 type bridge vlan_filtering 0 mcast_snooping 0 \
 		ageing_time "$LOW_AGEING_TIME"
 	ip_link_set_up br1
 
diff --git a/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh b/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
index 65f74c46c2f3..d9de3ad6e162 100755
--- a/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
@@ -134,7 +134,7 @@ adf_bridge_create()
 {
 	local mac
 
-	ip_link_add br up type bridge vlan_default_pvid 0 "$@"
+	adf_ip_link_add br up type bridge vlan_default_pvid 0 "$@"
 	mac=$(mac_get br)
 	adf_bridge_configure
 	ip_link_set_addr br "$mac"
@@ -142,8 +142,8 @@ adf_bridge_create()
 
 check_fdb_local_vlan_0_support()
 {
-	if ip_link_add XXbr up type bridge vlan_filtering 1 fdb_local_vlan_0 1 \
-		    &>/dev/null; then
+	if adf_ip_link_add XXbr up type bridge vlan_filtering 1 \
+			fdb_local_vlan_0 1 &>/dev/null; then
 		return 0
 	fi
 
@@ -375,7 +375,7 @@ test_q_sharing()
 
 adf_addr_set_bridge_create()
 {
-	ip_link_add br up type bridge vlan_filtering 0
+	adf_ip_link_add br up type bridge vlan_filtering 0
 	ip_link_set_addr br "$(mac_get br)"
 	adf_bridge_configure
 }
diff --git a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
index 462db0b603e7..503b1176d55f 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
@@ -122,11 +122,11 @@ h1_create()
 	simple_if_init "$h1"
 	defer simple_if_fini "$h1"
 
-	ip_link_add "$h1.10" master "v$h1" link "$h1" type vlan id 10
+	adf_ip_link_add "$h1.10" master "v$h1" link "$h1" type vlan id 10
 	ip_link_set_up "$h1.10"
 	ip_addr_add "$h1.10" 192.0.2.1/28
 
-	ip_link_add "$h1.20" master "v$h1" link "$h1" type vlan id 20
+	adf_ip_link_add "$h1.20" master "v$h1" link "$h1" type vlan id 20
 	ip_link_set_up "$h1.20"
 	ip_addr_add "$h1.20" 2001:db8:1::1/64
 }
@@ -161,7 +161,7 @@ h2_create()
 	ip_link_set_up "v$h2"
 
 	# br2
-	ip_link_add br2 type bridge vlan_filtering 0 mcast_snooping 0
+	adf_ip_link_add br2 type bridge vlan_filtering 0 mcast_snooping 0
 	ip_link_set_master br2 "v$h2"
 	ip_link_set_up br2
 
@@ -186,7 +186,7 @@ h3_create()
 	ip_link_set_up "v$h3"
 
 	# br3
-	ip_link_add br3 type bridge vlan_filtering 0 mcast_snooping 0
+	adf_ip_link_add br3 type bridge vlan_filtering 0 mcast_snooping 0
 	ip_link_set_master br3 "v$h3"
 	ip_link_set_up br3
 
@@ -205,17 +205,17 @@ switch_create()
 
 	# br1
 	swp1_mac=$(mac_get "$swp1")
-	ip_link_add br1 type bridge vlan_filtering 1 \
+	adf_ip_link_add br1 type bridge vlan_filtering 1 \
 			    vlan_default_pvid 0 mcast_snooping 0
 	ip_link_set_addr br1 "$swp1_mac"
 	ip_link_set_up br1
 
 	# A dummy to force the IPv6 OIF=0 test to install a suitable MC route on
 	# $IPMR to be deterministic. Also used for the IPv6 RX!=TX ping test.
-	ip_link_add "X$IPMR" up type dummy
+	adf_ip_link_add "X$IPMR" up type dummy
 
 	# IPMR
-	ip_link_add "$IPMR" up type dummy
+	adf_ip_link_add "$IPMR" up type dummy
 	ip_addr_add "$IPMR" 192.0.2.100/28
 	ip_addr_add "$IPMR" 2001:db8:4::1/64
 
@@ -241,7 +241,7 @@ vx_create()
 	local name=$1; shift
 	local vid=$1; shift
 
-	ip_link_add "$name" up type vxlan dstport "$VXPORT" \
+	adf_ip_link_add "$name" up type vxlan dstport "$VXPORT" \
 		nolearning noudpcsum tos inherit ttl 16 \
 		"$@"
 	ip_link_set_master "$name" br1
@@ -295,7 +295,7 @@ ns_init_common()
 	ip_addr_add "$if_in" "$ipv6_in"
 
 	# br1
-	ip_link_add br1 type bridge vlan_filtering 1 \
+	adf_ip_link_add br1 type bridge vlan_filtering 1 \
 		    vlan_default_pvid 0 mcast_snooping 0
 	ip_link_set_up br1
 
@@ -304,7 +304,7 @@ ns_init_common()
 	vx20_create local "${ipv6_in%/*}" group "$GROUP6" dev "$if_in"
 
 	# w1
-	ip_link_add w1 type veth peer name w2
+	adf_ip_link_add w1 type veth peer name w2
 	ip_link_set_master w1 br1
 	ip_link_set_up w1
 	bridge_vlan_add vid 10 dev w1
@@ -315,12 +315,12 @@ ns_init_common()
 	defer simple_if_fini w2
 
 	# w2.10
-	ip_link_add w2.10 master vw2 link w2 type vlan id 10
+	adf_ip_link_add w2.10 master vw2 link w2 type vlan id 10
 	ip_link_set_up w2.10
 	ip_addr_add w2.10 "$ipv4_host"
 
 	# w2.20
-	ip_link_add w2.20 master vw2 link w2 type vlan id 20
+	adf_ip_link_add w2.20 master vw2 link w2 type vlan id 20
 	ip_link_set_up w2.20
 	ip_addr_add w2.20 "$ipv6_host"
 }
@@ -377,8 +377,8 @@ setup_prepare()
 	forwarding_enable
 	defer forwarding_restore
 
-	ip_link_add "v1$h2" type veth peer name "v2$h2"
-	ip_link_add "v1$h3" type veth peer name "v2$h3"
+	adf_ip_link_add "v1$h2" type veth peer name "v2$h2"
+	adf_ip_link_add "v1$h3" type veth peer name "v2$h3"
 
 	h1_create
 	h2_create
diff --git a/tools/testing/selftests/net/forwarding/vxlan_reserved.sh b/tools/testing/selftests/net/forwarding/vxlan_reserved.sh
index 46c31794b91b..692644c3a489 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_reserved.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_reserved.sh
@@ -60,7 +60,7 @@ h1_create()
 
 switch_create()
 {
-	ip_link_add br1 type bridge vlan_filtering 0 mcast_snooping 0
+	adf_ip_link_add br1 type bridge vlan_filtering 0 mcast_snooping 0
 	# Make sure the bridge uses the MAC address of the local port and not
 	# that of the VxLAN's device.
 	ip_link_set_addr br1 $(mac_get $swp1)
@@ -200,7 +200,7 @@ vxlan_ping_do()
 
 vxlan_device_add()
 {
-	ip_link_add vx1 up type vxlan id 1000		\
+	adf_ip_link_add vx1 up type vxlan id 1000		\
 		local 192.0.2.17 dstport "$VXPORT"	\
 		nolearning noudpcsum tos inherit ttl 100 "$@"
 	ip_link_set_master vx1 br1
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index fea9c37fe338..7fbd9e5ce2be 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -543,7 +543,7 @@ require_command()
 	fi
 }
 
-ip_link_add()
+adf_ip_link_add()
 {
 	local name=$1; shift
 
diff --git a/tools/testing/selftests/net/test_vxlan_fdb_changelink.sh b/tools/testing/selftests/net/test_vxlan_fdb_changelink.sh
index 062f957950af..1443b57a6501 100755
--- a/tools/testing/selftests/net/test_vxlan_fdb_changelink.sh
+++ b/tools/testing/selftests/net/test_vxlan_fdb_changelink.sh
@@ -21,7 +21,7 @@ test_set_remote()
 {
 	RET=0
 
-	ip_link_add vx up type vxlan id 2000 dstport 4789
+	adf_ip_link_add vx up type vxlan id 2000 dstport 4789
 	bridge fdb ap dev vx 00:00:00:00:00:00 dst 192.0.2.20 self permanent
 	bridge fdb ap dev vx 00:00:00:00:00:00 dst 192.0.2.30 self permanent
 	check_remotes "fdb append"
@@ -74,12 +74,12 @@ test_change_mc_remote()
 {
 	check_command netstat || return
 
-	ip_link_add v1 up type veth peer name v2
+	adf_ip_link_add v1 up type veth peer name v2
 	ip_link_set_up v2
 
 	RET=0
 
-	ip_link_add vx up type vxlan dstport 4789 \
+	adf_ip_link_add vx up type vxlan dstport 4789 \
 		local 192.0.2.1 $(fmt_remote 224.1.1.1) dev v1 vni 1000
 
 	check_membership "group=224.1.1.1 fail=0" \
diff --git a/tools/testing/selftests/net/vlan_bridge_binding.sh b/tools/testing/selftests/net/vlan_bridge_binding.sh
index e7cb8c678bde..7797507cd14f 100755
--- a/tools/testing/selftests/net/vlan_bridge_binding.sh
+++ b/tools/testing/selftests/net/vlan_bridge_binding.sh
@@ -18,10 +18,10 @@ setup_prepare()
 {
 	local port
 
-	ip_link_add br up type bridge vlan_filtering 1
+	adf_ip_link_add br up type bridge vlan_filtering 1
 
 	for port in d1 d2 d3; do
-		ip_link_add $port type veth peer name r$port
+		adf_ip_link_add $port type veth peer name r$port
 		ip_link_set_up $port
 		ip_link_set_up r$port
 		ip_link_set_master $port br
@@ -74,7 +74,7 @@ add_one_vlan()
 	local link=$1; shift
 	local id=$1; shift
 
-	ip_link_add $link.$id link $link type vlan id $id "$@"
+	adf_ip_link_add $link.$id link $link type vlan id $id "$@"
 }
 
 add_vlans()
-- 
2.49.0


