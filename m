Return-Path: <linux-kselftest+bounces-19345-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F509969A9
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 14:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1CCF1C22A14
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 12:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B267F192D8E;
	Wed,  9 Oct 2024 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pzuyFao+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2085.outbound.protection.outlook.com [40.107.212.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E177F19006F;
	Wed,  9 Oct 2024 12:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728475825; cv=fail; b=JeWK2ntgqwr6qOE/Fw60m5taYvBuTNkKshzPmJdvkX/ukT9GYFaoM6znLNoALJqgXPoSLzfuboOKF3M5/4SUZzepElqVBvZUQUoezk6LQ7Y78RXyxWDOHCkYUbL4M81D/wBqrmrDk3RE+HZ5xe96my5IL86es3Ci7gOnfwU+DEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728475825; c=relaxed/simple;
	bh=4UNfkLX79XHO8aKgsnUpO3c4HNv3wG3RVLnm1Ac4Z9I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oT2Pt++sqa5/98TH6PyZ13rF5IKnN7I+xdE6BIx8L/h8/uTXRA8xoxBxMJzA2pekW7zRlNJm6kAh+dZ6YbMYx8rowk9Iyxp7Jf9/UXAKy+AauHqhDBbAo6C2pg96W8wPiKak3H6+WtFWTp+/f3hMVel+JXqgBl9j55aWvmTNFts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pzuyFao+; arc=fail smtp.client-ip=40.107.212.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2VvOLdPKD1yI1SMLKgt9fl/f6dbtPaSDU4RqFLns0KzBV+Bhof8eXnlsYPLgMe37wV+qTW5uCGsxv+HXdieaTPkJgWlDY0ENeh3yjlsXihNykxwOU8Kz98YNfxH1x0c27aD/3ZCODJunQ/tBylVF+MHP2DmZOfwSEmVQcABOli63jD7yiEC+xsGiy4AaY04NjhwzycgdzLEWxhZmTR3iK70pnTCfLfio5E0zId2eq3l6Kis+Kmwmk0fJ04Nk9XVGxbU67AxGZRyV3ZFhLsUf1vvD20WvK/AfYz4fnPCDeaSQIz79/7FZMhUTZiMmUrILeD8vMeta/y3uJLDW8KgVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgdWFkLtUuUoAJpufCbEn6aSijjX17z8SapfV8QrB5o=;
 b=ZJRhtg9NE6Gn4PgVfT/r7eykqbtwpQxE/HYo3wyTc+oOA0nu89iyyx611ADSm9O2G3ayvlcFJNjluOglQW3tFXhwXAFqfRd4LbqEL8/qSPFuMWpiE/aS+qO4U7MSU7xs8YUeND+nG/iRdPlUGHQIkGr4jn9QAIK3vt6ykKS3VWyPT2DVW5x0WYueK/1QK+mwgKfPv/0PNOcPqJbD0J/xuQiGrQiaCPKQYfXXFhOVHe5cLKheXdMFFZFSPEs4+EtHdJw2RbBVkkfb9btDVggktFWLya/KLv2dHf89O4KkCyZ0b+20q9hQAXIXoe/m4LoRShDZipF2Xkkd6pzbTVjwdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgdWFkLtUuUoAJpufCbEn6aSijjX17z8SapfV8QrB5o=;
 b=pzuyFao+oofvmq/8A8U+PrIzeVV34SWkuqX0VcVTGqRX7gQwgYDF/j5/S0tMkmz0UnKPaE5qo3eWbMwANS0bD/WHtDMG2toHoSAjaTRpfNK29o1zNHtP/kmqeo5vD/I63pkKp4PYOP3GWEE4RfHP5QIctjhUI6qSpoCOUcGA1+6hbmR9T33qlhwOlb+PnGEGxCdkE8jhtECJTS/6rUOjwmgQ0i69iezxOYsUX9Sxs9pK2ZmXoyMUMeX40+YV7z1mAo2fdDQWdja+H7EY4271qWtUKKNBmGwhvLa2BSVX4rgpJNpgHSXO/9YsaTXuY7nBYMEQGZ7k1h3JBeCdFMRnAQ==
Received: from CH0PR03CA0263.namprd03.prod.outlook.com (2603:10b6:610:e5::28)
 by SJ1PR12MB6026.namprd12.prod.outlook.com (2603:10b6:a03:48b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 12:10:17 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::bb) by CH0PR03CA0263.outlook.office365.com
 (2603:10b6:610:e5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 12:10:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 12:10:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 05:10:04 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 05:09:58 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
	"Benjamin Poirier" <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	"Vladimir Oltean" <vladimir.oltean@nxp.com>, Ido Schimmel
	<idosch@nvidia.com>, "Przemek Kitszel" <przemyslaw.kitszel@intel.com>, Petr
 Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 07/10] selftests: mlxsw: qos_mc_aware: Use defer for test cleanup
Date: Wed, 9 Oct 2024 14:06:25 +0200
Message-ID: <d34593e8ad4cc795f570760e22a18c894ba2f42b.1728473602.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|SJ1PR12MB6026:EE_
X-MS-Office365-Filtering-Correlation-Id: 7457bc28-5e09-43c1-842e-08dce85b563b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N2X/WR6sf8kLEcGq6fiA8q0yQB3c9aJUJCI82+SCvsVeH+Qxsou6sxzk/a9o?=
 =?us-ascii?Q?VICxZv4BM84Ds+6q6TwJYhlgSREM5QPPhhDC8FE2EGfU0Bn5EJ4J5oK0zeo9?=
 =?us-ascii?Q?6RNJOtmyH9NGYycQPgp2mrLw+0+WXSjMOEJuey6dFT9aGr18quoiRUqvnoW+?=
 =?us-ascii?Q?yWh9kGiPpVtuSMRD0D6umpYmvWd28YG/DwgJzG7IzeCIb3+tO9B0MJ7+E8ys?=
 =?us-ascii?Q?hq0X+Dkj65EWYNHOk7gyyKqokbx/acd7BgLcSSjIic7/C8HrlC2wXJYIVSEo?=
 =?us-ascii?Q?cfNA2vYB+liRWiYYn0D8SmCspIIFtHpKevyJ6yKZF9KERblfBIe6gXw+K+a5?=
 =?us-ascii?Q?VZfFmAWa51aqfWQPeH26w57YW3epwW1JVL6+//QAiZlY2vPCbKTr1qPkIbEm?=
 =?us-ascii?Q?BIPrls7839hxTmFboqgFyQfMg/iPxMvQVoKhjjQrlHlPNd2K9ofWu6JF8Egx?=
 =?us-ascii?Q?2lJfZbeL2TkMJqGUUBsoIcJO5VSJu+cKiHlFKuKiCGWpzdkKnzv0dhNZjCL0?=
 =?us-ascii?Q?wvm8o13IxRKzB0SEZWmC+BWdYNiwDM0k8D3c+E84yllCDK91IzhHAnvsNSON?=
 =?us-ascii?Q?Ru/u+uKp9c/eYGnA5j7GJd/GXnKeIxFMiTdBMUyRP1DBkwh0WWL0pv3f9f1d?=
 =?us-ascii?Q?cvZwbF3ZeP+yoGGg2Oy8c1uR7BdMxhYKvmS7H67Sf9gkw92OTXjPshjFhh8H?=
 =?us-ascii?Q?O2nJMmVFmcBm927HweOq3JiuFtfIceBkPgU29ggneZthH2BzOi0QAlwt02hz?=
 =?us-ascii?Q?Vc1RtfhIngpQJLEckId0Bs3EpqafDmop1h0EU5W2NEKr0Tzvz5BCqUYvolck?=
 =?us-ascii?Q?uhkZt+ycHe1zPqvT+HQQcS8qsJeYoNLEIMoDDwwzSyTy7esHpl5cZzAbrnMB?=
 =?us-ascii?Q?tYsY/e49vP0Enf9BiosLrhmG+YLJjEdgniKR2ipzBVwnOfMFuTD9/2kzP2QK?=
 =?us-ascii?Q?fuOfW2j5t4/kmiucxycJVwcj96oYo1FJ9uJyiOlxAZW2VZPV18P6ebsXXE/Z?=
 =?us-ascii?Q?7iohEMMqLo/+ZKTDxsbG2JZK8E8EhmQ/GffKXfDzXoByXxyzQpVxrcVAzZ3a?=
 =?us-ascii?Q?zwNa/kB0mx9ZW+0AYx6en+nFr62MBFrKv2w7OUy3YhRkmI8c60zzWETtUSSK?=
 =?us-ascii?Q?VnHr+f1/J3Bzuc1+7g7vUfdkvjg9OLkJDCmyfxNd1mjOFVDcSY9F9heEIqlm?=
 =?us-ascii?Q?ORsi4vCz4PJ/8DwJN1Ru9w1X40g/lCRTkveMeQ6jOv0LsD4mvPcNL2Q9JuBe?=
 =?us-ascii?Q?FpK0nJnJdjV4K93DPxNlIppvnSCn719eQYwld/pzO3iBsFONFg46fkqnAdev?=
 =?us-ascii?Q?eKPOYXiJRz1f2FiUdUFpjbWg31li25C5pLVMDoSTpqAax+L3BmrZPCXe6god?=
 =?us-ascii?Q?oYZyFFQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 12:10:16.4770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7457bc28-5e09-43c1-842e-08dce85b563b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6026

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


