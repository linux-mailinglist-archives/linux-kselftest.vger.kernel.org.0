Return-Path: <linux-kselftest+bounces-19944-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D26389A1EDE
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 11:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01BDA1C210B9
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 09:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEE41DA0F5;
	Thu, 17 Oct 2024 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ej/d9Fgk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2085.outbound.protection.outlook.com [40.107.212.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F021D4150;
	Thu, 17 Oct 2024 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158476; cv=fail; b=QqPVdhZFZ+X5AEhrlIzPmKdxb1g6DyF/cosBKokczECJiIkXkWE2K/EDy11R/LJhKIX7kxsYNKLHI0cN2XKd2NRtCsehR3FnLVBEPsZ/24oFUSrbhyprHJZ0KH7BSPoy0opUSbCeb61rJy09Aqn1ufif7v+P03CNqTrkk5jOCkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158476; c=relaxed/simple;
	bh=4UNfkLX79XHO8aKgsnUpO3c4HNv3wG3RVLnm1Ac4Z9I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SLAxLBg4AD+ySGOsbcaaYmJL8bGKDcK3tVoL0t1QQJk/BjtUb9JTB4iIwFXV03zf2rMQrlmMAHuJNCVGYTAOy9OE4yln/cGGi2kHTIGKQUiP3f+s7wKD4oFRv9ARwrY9E6xPURepMqSHDUEGb+qDbkYkoF54ZqOk1jneRGS8Kos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ej/d9Fgk; arc=fail smtp.client-ip=40.107.212.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I82vD+CFA87di32UBd1bTS1gGo6IqyR9gLu9khZ+XGvPb18j8j94Zbk6NrecI4BoOyRWAHkb94D7svl+P4rKoGJDj0P2ixA9dZuBrBiYWmmack12W/Jt1mQ6lofDJct1ed7/HtB1WY7IP3TWFX9nIeiHbmRKZri5ARixSqjaehkQoxBCwV3PWFmb6DNJ9Hc2G93N8mzoSl1ih+ISUYecn08g4/Y3rcUNX17ez6D2vC3YjWq1kE8z5uHA1QTGER5bVDAJGKYGtH6iIjjs8wLnTsISkc9aexNfj1Vq/yOaBWZheX2oRr+ztEzdiNORiM/6CpDEB5YeSys+MeNpwbB+PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgdWFkLtUuUoAJpufCbEn6aSijjX17z8SapfV8QrB5o=;
 b=upZYWKfQus7HKhwSb/5J2VBT5bfiYWY8+21/PC+HDp6xaWkR/e51EWOQgi/CIo3pRp17Q6onBZaEZI9aOJmvR42kdzpq0IPZOH1M4+BDIB+fXFGa2O8e2HYtml0b3pdh5AmiSYzbfUflaXAN3rQDexFmddSgLsLwyNwSPAxwPWU3vgXXf/Zcq3HO7Mi5oaY/XRkHAVawHFa6AJO4BdDqaglhKx2dUslhMyYjBn/8eaF5ZxQ0DOUKtr7gYa0X6RLdGJGsyv8mH8fwlUDuBf6vZK0kW62qN6vlb8kJVTeoUvQW+Yusinknhv0FzMkWyI5sn7k2eQzEk3oTSrfrki2sig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgdWFkLtUuUoAJpufCbEn6aSijjX17z8SapfV8QrB5o=;
 b=ej/d9FgkdsEfY7vE1hwkmINFBHR8572K7fL2U5sciRF3WJ/f0M7SmPcr3x3BpQXOi6wMMb4WRVuD7BgUBhjF8C2Xq5e2MfjKfdN9dMDwINSl+gWxQQgPB/1H2TTulilbvbK8Xug2zs/J+f917U5gkCuIlJx59mJ+mrP8Qt6j54m5kg3Ru+sx186R1bvfZAn5yUkIOvuNLBUOSzOVVmVrwlonYKsb6BLwsl7z+LLAGkw4YgAfQsB/8B17LOLw1PfDg24TjwwGdf1hZmazbclrSgNTCCLik9BsG9w2TMKpwj0t4R7aBdm4r2kestA7wLVMQahIAZrWNdo9aMD6OPQlfQ==
Received: from SA9PR13CA0089.namprd13.prod.outlook.com (2603:10b6:806:23::34)
 by PH0PR12MB5645.namprd12.prod.outlook.com (2603:10b6:510:140::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 17 Oct
 2024 09:47:45 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:23:cafe::9b) by SA9PR13CA0089.outlook.office365.com
 (2603:10b6:806:23::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Thu, 17 Oct 2024 09:47:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 09:47:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 02:47:36 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 02:47:30 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
	"Benjamin Poirier" <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	"Vladimir Oltean" <vladimir.oltean@nxp.com>, Ido Schimmel
	<idosch@nvidia.com>, "Przemek Kitszel" <przemyslaw.kitszel@intel.com>, Petr
 Machata <petrm@nvidia.com>, Willem de Bruijn <willemb@google.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v2 07/10] selftests: mlxsw: qos_mc_aware: Use defer for test cleanup
Date: Thu, 17 Oct 2024 11:45:49 +0200
Message-ID: <2eaee7a73a65f435a39df0a4b8f83b0702fc7832.1729157566.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729157566.git.petrm@nvidia.com>
References: <cover.1729157566.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|PH0PR12MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ac20efa-48c0-4096-aea8-08dcee90c04a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ay8ZJb3Rudi+jHo4opu6oyMIhmDRcs703s51V3HxemDwe3hX7tTjXzqUOhsa?=
 =?us-ascii?Q?QcVeH1//FMc06zUNr2b8q6GP3L9ChOiL6r9kWPpjnBLvkRmHI6hMIAeiLmqT?=
 =?us-ascii?Q?+PzzDIX0P8LzxVJrA6nm0GX+/JstCpBaJvo0bb+dllAVEiZrqyq0gNOToPe8?=
 =?us-ascii?Q?0sPWqQd/rqYd45/e20tgFTAKlH8CY+kYY82ZYIeqQVQO/Vf6a1JxD8EJe0nD?=
 =?us-ascii?Q?8x9fZqoFGqwQIiwaFlgJR+TUDoOTh1dqbwjgqNTV27qJBs9H0F/hbdbc/LW7?=
 =?us-ascii?Q?fwThxd90HPhEwgHiEmbWZ0O/6kbI0h9DqsJt9PsEloarCtuRfn/vqZqyBayR?=
 =?us-ascii?Q?ttiq3yTl7mUknQoeSS+oh40tMt3nucGxjwV5tmHjXfMg3fxvbkc/IIT1cxoL?=
 =?us-ascii?Q?DH13/Z9uJmaD0uefXIS40cXKVllAHAJBmBenBdmRLkq7LA2Ws9dtoi94H6Pu?=
 =?us-ascii?Q?w51OMB3N/5TIdJ59PtvwB325gMKA1dhjGcbwxj94vkZCPUhetDxfyXuQe0As?=
 =?us-ascii?Q?1Xe7UI0ioi9EMB+vUjQ+HWt4sFkMbOzqOapzqNL+/JFEzvMez6jz64x7hSxS?=
 =?us-ascii?Q?XWOBtXgT2bRnpEMRjLke6DtEd8BdCTSkTZqzf66b7NXcncF4G7Nn4s7wjOnj?=
 =?us-ascii?Q?IG2CoSVXHhZ4WN5Xhp/AlwMOhQt6Ip4/2PDqUZHc3IXklRMFKl/b41WJ7D0J?=
 =?us-ascii?Q?QSsHHH1EPp7maQEzfSIWfQDXmLDq1G6iR8MSgUy4na1GiT3/Uq6TtddatN1d?=
 =?us-ascii?Q?M6SOIz+7TJAnvHg0E6zqv8R3xttIoZJyY4EmgUjvf0LHamO4T41+ocPEoUGn?=
 =?us-ascii?Q?FeCkEqnuvgWT+MXyw4nrXKRkS6wTSXKnkI4symJN/GDHHE5b1WSYLGG49dTj?=
 =?us-ascii?Q?IJIuKI4tC3CFpd5zyOemDNWt69Ye0UKNr91stKYJ0EZnSQLpAvI5to+v0TBr?=
 =?us-ascii?Q?eHug+zknGiadziSmDASHHrHkf0Huai6tMhBASIhHGWm4mFNaQB9w0T6BYzsC?=
 =?us-ascii?Q?KH8sgo64EcqXhtaLe0yC+AR+us00NW1Qh6D8977HgtKOiofSLr7erhc9bPFS?=
 =?us-ascii?Q?nOjp919da75wv3sFJiXtAwumgxVN0Q3GqMzX6UoV+f9r2E9hIdLs6QONiG4l?=
 =?us-ascii?Q?KaX6CMHgs5rHyBf9GmxWBWHYYAJt5L3Ou7URVfF/DHq+p+eGz1sBxOHcS5aN?=
 =?us-ascii?Q?A/9alZbje1ySsAfW1FCnvN821KxFnHc+jmQzvBL335L0u8Wh8wSMbMSLPRJL?=
 =?us-ascii?Q?lkgwjqe5XEApewyfMW2gNwOGv4UsnECXeIEolbL81Cm6hniSnFK7F7ouNWM6?=
 =?us-ascii?Q?BCT6Ti8R4UNVE/of153NdkOWBj1tTlrDUuuCiABGTQbKuLvFNI6WO+MWhFJh?=
 =?us-ascii?Q?RP1eGMS7+vblReJ7kjAGdmo6ccZ0qALWnXuVjbdbY6X4HkSsNw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 09:47:44.7182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac20efa-48c0-4096-aea8-08dcee90c04a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5645

Use the defer framework to schedule cleanups as soon as the command is
executed.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../drivers/net/mlxsw/qos_mc_aware.sh         | 146 ++++++++----------
 1 file changed, 68 insertions(+), 78 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh b/tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh
index 6d892de43fa8..cd4a5c21360c 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh
@@ -73,122 +73,114 @@ source qos_lib.sh
 h1_create()
 {
 	simple_if_init $h1 192.0.2.65/28
+	defer simple_if_fini $h1 192.0.2.65/28
+
 	mtu_set $h1 10000
-}
-
-h1_destroy()
-{
-	mtu_restore $h1
-	simple_if_fini $h1 192.0.2.65/28
+	defer mtu_restore $h1
 }
 
 h2_create()
 {
 	simple_if_init $h2
+	defer simple_if_fini $h2
+
 	mtu_set $h2 10000
+	defer mtu_restore $h2
 
 	vlan_create $h2 111 v$h2 192.0.2.129/28
+	defer vlan_destroy $h2 111
 	ip link set dev $h2.111 type vlan egress-qos-map 0:1
 }
 
-h2_destroy()
-{
-	vlan_destroy $h2 111
-
-	mtu_restore $h2
-	simple_if_fini $h2
-}
-
 h3_create()
 {
 	simple_if_init $h3 192.0.2.66/28
+	defer simple_if_fini $h3 192.0.2.66/28
+
 	mtu_set $h3 10000
+	defer mtu_restore $h3
 
 	vlan_create $h3 111 v$h3 192.0.2.130/28
-}
-
-h3_destroy()
-{
-	vlan_destroy $h3 111
-
-	mtu_restore $h3
-	simple_if_fini $h3 192.0.2.66/28
+	defer vlan_destroy $h3 111
 }
 
 switch_create()
 {
 	ip link set dev $swp1 up
+	defer ip link set dev $swp1 down
+
 	mtu_set $swp1 10000
+	defer mtu_restore $swp1
 
 	ip link set dev $swp2 up
+	defer ip link set dev $swp2 down
+
 	mtu_set $swp2 10000
+	defer mtu_restore $swp2
 
 	ip link set dev $swp3 up
+	defer ip link set dev $swp3 down
+
 	mtu_set $swp3 10000
+	defer mtu_restore $swp3
 
 	vlan_create $swp2 111
+	defer vlan_destroy $swp2 111
+
 	vlan_create $swp3 111
+	defer vlan_destroy $swp3 111
 
 	tc qdisc replace dev $swp3 root handle 3: tbf rate 1gbit \
 		burst 128K limit 1G
+	defer tc qdisc del dev $swp3 root handle 3:
+
 	tc qdisc replace dev $swp3 parent 3:3 handle 33: \
 		prio bands 8 priomap 7 7 7 7 7 7 7 7
+	defer tc qdisc del dev $swp3 parent 3:3 handle 33:
 
 	ip link add name br1 type bridge vlan_filtering 0
+	defer ip link del dev br1
 	ip link set dev br1 addrgenmode none
 	ip link set dev br1 up
+
 	ip link set dev $swp1 master br1
+	defer ip link set dev $swp1 nomaster
+
 	ip link set dev $swp3 master br1
+	defer ip link set dev $swp3 nomaster
 
 	ip link add name br111 type bridge vlan_filtering 0
+	defer ip link del dev br111
 	ip link set dev br111 addrgenmode none
 	ip link set dev br111 up
+
 	ip link set dev $swp2.111 master br111
+	defer ip link set dev $swp2.111 nomaster
+
 	ip link set dev $swp3.111 master br111
+	defer ip link set dev $swp3.111 nomaster
 
 	# Make sure that ingress quotas are smaller than egress so that there is
 	# room for both streams of traffic to be admitted to shared buffer.
 	devlink_port_pool_th_save $swp1 0
 	devlink_port_pool_th_set $swp1 0 5
+	defer devlink_port_pool_th_restore $swp1 0
+
 	devlink_tc_bind_pool_th_save $swp1 0 ingress
 	devlink_tc_bind_pool_th_set $swp1 0 ingress 0 5
+	defer devlink_tc_bind_pool_th_restore $swp1 0 ingress
 
 	devlink_port_pool_th_save $swp2 0
 	devlink_port_pool_th_set $swp2 0 5
+	defer devlink_port_pool_th_restore $swp2 0
+
 	devlink_tc_bind_pool_th_save $swp2 1 ingress
 	devlink_tc_bind_pool_th_set $swp2 1 ingress 0 5
+	defer devlink_tc_bind_pool_th_restore $swp2 1 ingress
 
 	devlink_port_pool_th_save $swp3 4
 	devlink_port_pool_th_set $swp3 4 12
-}
-
-switch_destroy()
-{
-	devlink_port_pool_th_restore $swp3 4
-
-	devlink_tc_bind_pool_th_restore $swp2 1 ingress
-	devlink_port_pool_th_restore $swp2 0
-
-	devlink_tc_bind_pool_th_restore $swp1 0 ingress
-	devlink_port_pool_th_restore $swp1 0
-
-	ip link del dev br111
-	ip link del dev br1
-
-	tc qdisc del dev $swp3 parent 3:3 handle 33:
-	tc qdisc del dev $swp3 root handle 3:
-
-	vlan_destroy $swp3 111
-	vlan_destroy $swp2 111
-
-	mtu_restore $swp3
-	ip link set dev $swp3 down
-
-	mtu_restore $swp2
-	ip link set dev $swp2 down
-
-	mtu_restore $swp1
-	ip link set dev $swp1 down
+	defer devlink_port_pool_th_restore $swp3 4
 }
 
 setup_prepare()
@@ -205,6 +197,7 @@ setup_prepare()
 	h3mac=$(mac_get $h3)
 
 	vrf_prepare
+	defer vrf_cleanup
 
 	h1_create
 	h2_create
@@ -212,45 +205,45 @@ setup_prepare()
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
 	ping_test $h2 192.0.2.130
 }
 
-test_mc_aware()
+__run_uc_measure_rate()
 {
-	RET=0
-
+	local what=$1; shift
 	local -a uc_rate
+
 	start_traffic $h2.111 192.0.2.129 192.0.2.130 $h3mac
-	uc_rate=($(measure_rate $swp2 $h3 rx_octets_prio_1 "UC-only"))
-	check_err $? "Could not get high enough UC-only ingress rate"
-	stop_traffic
+	defer stop_traffic $!
+
+	uc_rate=($(measure_rate $swp2 $h3 rx_octets_prio_1 "$what"))
+	check_err $? "Could not get high enough $what ingress rate"
+
+	echo ${uc_rate[@]}
+}
+
+run_uc_measure_rate()
+{
+	in_defer_scope __run_uc_measure_rate "$@"
+}
+
+test_mc_aware()
+{
+	RET=0
+
+	local -a uc_rate=($(run_uc_measure_rate "UC-only"))
 	local ucth1=${uc_rate[1]}
 
 	start_traffic $h1 192.0.2.65 bc bc
+	defer stop_traffic $!
 
 	local d0=$(date +%s)
 	local t0=$(ethtool_stats_get $h3 rx_octets_prio_0)
 	local u0=$(ethtool_stats_get $swp1 rx_octets_prio_0)
 
-	local -a uc_rate_2
-	start_traffic $h2.111 192.0.2.129 192.0.2.130 $h3mac
-	uc_rate_2=($(measure_rate $swp2 $h3 rx_octets_prio_1 "UC+MC"))
-	check_err $? "Could not get high enough UC+MC ingress rate"
-	stop_traffic
+	local -a uc_rate_2=($(run_uc_measure_rate "UC+MC"))
 	local ucth2=${uc_rate_2[1]}
 
 	local d1=$(date +%s)
@@ -272,8 +265,6 @@ test_mc_aware()
 	local mc_ir=$(rate $u0 $u1 $interval)
 	local mc_er=$(rate $t0 $t1 $interval)
 
-	stop_traffic
-
 	log_test "UC performance under MC overload"
 
 	echo "UC-only throughput  $(humanize $ucth1)"
@@ -297,6 +288,7 @@ test_uc_aware()
 	RET=0
 
 	start_traffic $h2.111 192.0.2.129 192.0.2.130 $h3mac
+	defer stop_traffic $!
 
 	local d0=$(date +%s)
 	local t0=$(ethtool_stats_get $h3 rx_octets_prio_1)
@@ -326,8 +318,6 @@ test_uc_aware()
 	((attempts == passes))
 	check_err $?
 
-	stop_traffic
-
 	log_test "MC performance under UC overload"
 	echo "    ingress UC throughput $(humanize ${uc_ir})"
 	echo "    egress UC throughput  $(humanize ${uc_er})"
-- 
2.45.0


