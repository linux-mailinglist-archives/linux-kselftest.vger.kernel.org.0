Return-Path: <linux-kselftest+bounces-19943-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 388BE9A1ED9
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 11:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBCFD281E88
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 09:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846E51D9694;
	Thu, 17 Oct 2024 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="af45y+2l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A1C1DA0EB;
	Thu, 17 Oct 2024 09:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158469; cv=fail; b=iAxk70pUBx++r/GrYjl3PEO1ucAzkfLnc2XW9087QFWultwksDCX3UQZEEtO74w07WSzrqMby18foLA8T+wnPr2e1bz3Iym8mldT3aqkO1V06iEplQL1PVv/fy+sKQi8Nomnbs3uaGWRuyOZEX1hU4CgBDrPTcHUbdcKzVjrHP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158469; c=relaxed/simple;
	bh=QmP4JnLTev14VFwGS4zTXKTeNR1iLxBEnCTfB5mvUkc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JLcmXjqUAF1AjjZl0BqnHJD44Nnwht9t8B7MyZbA9JCpHy3UmVSU12ECD3AHC/5KTQxduwQUOnl1/qkW7d2/FGl0FdGlz1rOfpLR8Kpb+LEpX4dvdDmoh1pCpohxWELxbgG9HXADH4neXY+x/zKsTSxgtWRzbuOf+Yms9DNZHlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=af45y+2l; arc=fail smtp.client-ip=40.107.100.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DXL1GIWpljm3wx+uOWIk48zLb7eHtxqLMbBDZZdEd/8WkZ9xrSmKhV3OX72YNDNOID8JEg6rwAdIRAC4fxQXo308DK2Nq0B7E0H3msGq7ffFKV7Ls6N6PZXRuFjonupcs7uKRlYze+gvHlnWU83Kd1ZlsqSG7Zj3C/FZFwwUkEQvXydab/0usC4d22bSnO4JQWQSKcVHFYyyp7R+SKK+J+DffAoa2JnwzAgzDr+PZnngwfgCfE1Mce2FYukf7YAhq+IKQERfL6XZG6qkGiAzDQlbMgVMIKJ+9vH+irc/eR1AJy1tYn9nrWKqcA+4I1V4mjEiOvYGQW09r7V+ULO81g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XE4tiSQAFHiQC4a395xfqzFWq0VymUTdBw+LHLe9G9o=;
 b=xx5MHDMPjEZMojDT9RhQ9tAF1+IjUM/RjTsN9Bv/oHFSz6slHuREgvO3kVtQVKFuuMB5O1hZq1NJ+zw+kyG/pK4RzOIi8LqTJD+gYqBzWLESmZ+DbQVE8+1jbMoGZdwf6na80XUMbincXifLSk30gkdm46AAoYpjn3cVY2uLu5NOtNQUtM/GyBmZYw5BCpMx2xhtMdhunJvgRKWGLEZDP0JcA4qZUCeViJPouKD0JCEAqkVkTJh0NauwELzbbY8/LH9Hc9uNVBtkhGy/gCo2B5GYeDcyiOif/K3J5Sk+KoBgx6Knx3ToIwCgIfW9UvuAzY9GqwRkUEjR4JmuX2ShGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XE4tiSQAFHiQC4a395xfqzFWq0VymUTdBw+LHLe9G9o=;
 b=af45y+2lqv3nAwb7s1cbISNDLGuyy6F8jgbd+a06YTaN5Q19hByaLXrEffbJ/WSwpv56KrNcfdkPMuj1t269WbbAXBpxQtWxV9OR8xWZgBqOmbXw2lyrejaKkW3bs3szkbxnj4Qt3JnCJ2SyXFrNSa0OiDHWSpeGMbE7sKce93G8PKVb0+rlUWaCQswuWHui9pQoZcSwsqhqSmLITA6pXnAvQRZEda/dPATV8Vh7ojiCNy6rZfXlB4BwAY6N66VJuH/X3ecKZ0SFEzZI9cd5LOINcEnKQa9yYNHJXD+G886D48rSpJBi0nd6ntYJNoCoXOoFUyW/Z9K2hUXZYw1Cmw==
Received: from SN7PR04CA0194.namprd04.prod.outlook.com (2603:10b6:806:126::19)
 by IA0PR12MB8984.namprd12.prod.outlook.com (2603:10b6:208:492::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 17 Oct
 2024 09:47:40 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:126:cafe::cf) by SN7PR04CA0194.outlook.office365.com
 (2603:10b6:806:126::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Thu, 17 Oct 2024 09:47:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 09:47:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 02:47:30 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 02:47:24 -0700
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
Subject: [PATCH net-next v2 06/10] selftests: ETS: Use defer for test cleanup
Date: Thu, 17 Oct 2024 11:45:48 +0200
Message-ID: <b135f66b2a769415dd0be81a62aaff6b78e80eeb.1729157566.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|IA0PR12MB8984:EE_
X-MS-Office365-Filtering-Correlation-Id: f3eb8f07-5d0e-43cd-9523-08dcee90bd67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oH0JaVfBQjeTs3NvpIvR054RQVI2UeSKxzT3k9d9VfBpBm+STwHa/PsaPkcE?=
 =?us-ascii?Q?jEarUErqjhafFRuE1Pt1AN95Hf3Eo2imHAR3pgB2q5Sp8TKC6o4krk2ie7Oi?=
 =?us-ascii?Q?py6HNnzK9PDeNicehicI2L/04fATlcmcPsgyAvAKK0xm68FZEl/k5azwGjiI?=
 =?us-ascii?Q?p85VxQnXOuCFvyS1pW++EW+aAs0TTqYlpM/KNNtEm912kB6yfEIthxZrKqAR?=
 =?us-ascii?Q?ce8fh26n1IMBhoH9gtK7eNJSdxJBS5cPja5XvZR1Cq9Ck7KlxAtBQH5zGge6?=
 =?us-ascii?Q?EgGj+NdsS+y0CTDK7EBKOuvyru/wtoS7qhbZPEfPSIAzQOnE0terOsXaglMf?=
 =?us-ascii?Q?6tS++kw1elEhGgt8qjQoUcz0Sv2jGAt3i5gJjekzU3dlQ9ym/fsBwVmt5B+o?=
 =?us-ascii?Q?mVuK2ZoKTDPrwZUe1o5xItsDKmy/pUYqovPVF72gExe4Wpyu+uSdq7RYVw+/?=
 =?us-ascii?Q?+Snl4N95CPX7PK9enq0+h8kchhV9MyoMuBw3KjOP7B8ZI2VF9gBDF9Qb4Dy5?=
 =?us-ascii?Q?doOb6wvRZ+jJglAHfACE4iOuLm1OpadIVeleXtgg/AdsyYhSWegBAu7It9un?=
 =?us-ascii?Q?wfjW/jtyGvpJXFK07292MjJDvxqVTTU74oItEVyb7SZ0JW71Ut1FAw5qj0Wu?=
 =?us-ascii?Q?kNYErKCG9XzgWIw2dlRrDtEBHL5b5IGWCU07fptkPwYkuI6krFAIOwKSKU1F?=
 =?us-ascii?Q?jgcpvycO/oQA1mnq6TSOgpZxn4XaaVGQ9wzgakbvolEUDeM6mbbi30fA1KxB?=
 =?us-ascii?Q?Zv+Q3X3xAUszITeHMoLFi1MVQxqVJWZnM0BQl3h7Fg+fhuGaSOH5FjQb5UxT?=
 =?us-ascii?Q?et+znhv+HstTQAG6HRF35PlYyIumRDVXaiA3E79iNW1DlUthdbWms/uoZbnj?=
 =?us-ascii?Q?mmnhvMH5tsytV55cdImyn2TSgFd/SD9kr+ePpKibwYvQGXcvwJP4TfD8849W?=
 =?us-ascii?Q?AwJ2RTbacJIraR6GUt/le0Gass5M8/r8n29ULua4CF9hi1AscPeduVSR0TuB?=
 =?us-ascii?Q?c4j9YWxwddJfNt3OcWeN39KTHMCX4G7NvO7T0xy3D1+skXTi2LRR2uTXKhpx?=
 =?us-ascii?Q?sN0flZyj2HHHewLYkK3JvvsVQaYWzv2B7UYjbx3DKHMM6RoGXs5xFXE0axl7?=
 =?us-ascii?Q?0xYrNMi98DTCIDeaBH6si/HRh0XKPRoV7SNHbOYLzCxbYQcf8Ir4iAAQjygk?=
 =?us-ascii?Q?Ex+AcQlNwe+7y82O8CP4P6KZRTjz9Qgv9k4BAlz+xrWODI1p5OXkODPMasCA?=
 =?us-ascii?Q?3rLwgwKuC1cpb/APfTQVfmgbuov80DoYl8v2woI2LNhfv2D4xuNBou7eHF5/?=
 =?us-ascii?Q?SWfme0btFVKwMCtbHYTYpToWDMBT7EEgDbAj8ajhCYyLrUepM72JSulP3F54?=
 =?us-ascii?Q?7r/2NcLtHfNuETPXizSVNBaSWyCpMKF2GViJO1UF7Vh7EV9Gtg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 09:47:39.8745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3eb8f07-5d0e-43cd-9523-08dcee90bd67
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8984

Use the defer framework to schedule cleanups as soon as the command is
executed.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../selftests/drivers/net/mlxsw/sch_ets.sh    | 26 +++---
 .../selftests/net/forwarding/sch_ets.sh       |  7 +-
 .../selftests/net/forwarding/sch_ets_core.sh  | 81 +++++++------------
 .../selftests/net/forwarding/sch_ets_tests.sh | 14 ++--
 4 files changed, 50 insertions(+), 78 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/sch_ets.sh b/tools/testing/selftests/drivers/net/mlxsw/sch_ets.sh
index 139175fd03e7..4aaceb6b2b60 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/sch_ets.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/sch_ets.sh
@@ -21,6 +21,7 @@ switch_create()
 	# Create a bottleneck so that the DWRR process can kick in.
 	tc qdisc replace dev $swp2 root handle 3: tbf rate 1gbit \
 		burst 128K limit 1G
+	defer tc qdisc del dev $swp2 root handle 3:
 
 	ets_switch_create
 
@@ -30,16 +31,27 @@ switch_create()
 	# for the DWRR process.
 	devlink_port_pool_th_save $swp1 0
 	devlink_port_pool_th_set $swp1 0 12
+	defer devlink_port_pool_th_restore $swp1 0
+
 	devlink_tc_bind_pool_th_save $swp1 0 ingress
 	devlink_tc_bind_pool_th_set $swp1 0 ingress 0 12
+	defer devlink_tc_bind_pool_th_restore $swp1 0 ingress
+
 	devlink_port_pool_th_save $swp2 4
 	devlink_port_pool_th_set $swp2 4 12
+	defer devlink_port_pool_th_restore $swp2 4
+
 	devlink_tc_bind_pool_th_save $swp2 7 egress
 	devlink_tc_bind_pool_th_set $swp2 7 egress 4 5
+	defer devlink_tc_bind_pool_th_restore $swp2 7 egress
+
 	devlink_tc_bind_pool_th_save $swp2 6 egress
 	devlink_tc_bind_pool_th_set $swp2 6 egress 4 5
+	defer devlink_tc_bind_pool_th_restore $swp2 6 egress
+
 	devlink_tc_bind_pool_th_save $swp2 5 egress
 	devlink_tc_bind_pool_th_set $swp2 5 egress 4 5
+	defer devlink_tc_bind_pool_th_restore $swp2 5 egress
 
 	# Note: sch_ets_core.sh uses VLAN ingress-qos-map to assign packet
 	# priorities at $swp1 based on their 802.1p headers. ingress-qos-map is
@@ -47,20 +59,6 @@ switch_create()
 	# 1:1, which is the mapping currently hard-coded by the driver.
 }
 
-switch_destroy()
-{
-	devlink_tc_bind_pool_th_restore $swp2 5 egress
-	devlink_tc_bind_pool_th_restore $swp2 6 egress
-	devlink_tc_bind_pool_th_restore $swp2 7 egress
-	devlink_port_pool_th_restore $swp2 4
-	devlink_tc_bind_pool_th_restore $swp1 0 ingress
-	devlink_port_pool_th_restore $swp1 0
-
-	ets_switch_destroy
-
-	tc qdisc del dev $swp2 root handle 3:
-}
-
 # Callback from sch_ets_tests.sh
 collect_stats()
 {
diff --git a/tools/testing/selftests/net/forwarding/sch_ets.sh b/tools/testing/selftests/net/forwarding/sch_ets.sh
index e60c8b4818cc..1f6f53e284b5 100755
--- a/tools/testing/selftests/net/forwarding/sch_ets.sh
+++ b/tools/testing/selftests/net/forwarding/sch_ets.sh
@@ -24,15 +24,10 @@ switch_create()
 	# Create a bottleneck so that the DWRR process can kick in.
 	tc qdisc add dev $swp2 root handle 1: tbf \
 	   rate 1Gbit burst 1Mbit latency 100ms
+	defer tc qdisc del dev $swp2 root
 	PARENT="parent 1:"
 }
 
-switch_destroy()
-{
-	ets_switch_destroy
-	tc qdisc del dev $swp2 root
-}
-
 # Callback from sch_ets_tests.sh
 collect_stats()
 {
diff --git a/tools/testing/selftests/net/forwarding/sch_ets_core.sh b/tools/testing/selftests/net/forwarding/sch_ets_core.sh
index f906fcc66572..8f9922c695b0 100644
--- a/tools/testing/selftests/net/forwarding/sch_ets_core.sh
+++ b/tools/testing/selftests/net/forwarding/sch_ets_core.sh
@@ -166,89 +166,78 @@ h1_create()
 	local i;
 
 	simple_if_init $h1
+	defer simple_if_fini $h1
+
 	mtu_set $h1 9900
+	defer mtu_restore $h1
+
 	for i in {0..2}; do
 		vlan_create $h1 1$i v$h1 $(sip $i)/28
+		defer vlan_destroy $h1 1$i
 		ip link set dev $h1.1$i type vlan egress 0:$i
 	done
 }
 
-h1_destroy()
-{
-	local i
-
-	for i in {0..2}; do
-		vlan_destroy $h1 1$i
-	done
-	mtu_restore $h1
-	simple_if_fini $h1
-}
-
 h2_create()
 {
 	local i
 
 	simple_if_init $h2
+	defer simple_if_fini $h2
+
 	mtu_set $h2 9900
+	defer mtu_restore $h2
+
 	for i in {0..2}; do
 		vlan_create $h2 1$i v$h2 $(dip $i)/28
+		defer vlan_destroy $h2 1$i
 	done
 }
 
-h2_destroy()
-{
-	local i
-
-	for i in {0..2}; do
-		vlan_destroy $h2 1$i
-	done
-	mtu_restore $h2
-	simple_if_fini $h2
-}
-
 ets_switch_create()
 {
 	local i
 
 	ip link set dev $swp1 up
+	defer ip link set dev $swp1 down
+
 	mtu_set $swp1 9900
+	defer mtu_restore $swp1
 
 	ip link set dev $swp2 up
+	defer ip link set dev $swp2 down
+
 	mtu_set $swp2 9900
+	defer mtu_restore $swp2
 
 	for i in {0..2}; do
 		vlan_create $swp1 1$i
+		defer vlan_destroy $swp1 1$i
 		ip link set dev $swp1.1$i type vlan ingress 0:0 1:1 2:2
 
 		vlan_create $swp2 1$i
+		defer vlan_destroy $swp2 1$i
 
 		ip link add dev br1$i type bridge
+		defer ip link del dev br1$i
+
 		ip link set dev $swp1.1$i master br1$i
+		defer ip link set dev $swp1.1$i nomaster
+
 		ip link set dev $swp2.1$i master br1$i
+		defer ip link set dev $swp2.1$i nomaster
 
 		ip link set dev br1$i up
+		defer ip link set dev br1$i down
+
 		ip link set dev $swp1.1$i up
+		defer ip link set dev $swp1.1$i down
+
 		ip link set dev $swp2.1$i up
+		defer ip link set dev $swp2.1$i down
 	done
-}
 
-ets_switch_destroy()
-{
-	local i
-
-	ets_delete_qdisc
-
-	for i in {0..2}; do
-		ip link del dev br1$i
-		vlan_destroy $swp2 1$i
-		vlan_destroy $swp1 1$i
-	done
-
-	mtu_restore $swp2
-	ip link set dev $swp2 down
-
-	mtu_restore $swp1
-	ip link set dev $swp1 down
+	defer ets_delete_qdisc
 }
 
 setup_prepare()
@@ -263,23 +252,13 @@ setup_prepare()
 	hut=$h2
 
 	vrf_prepare
+	defer vrf_cleanup
 
 	h1_create
 	h2_create
 	switch_create
 }
 
-cleanup()
-{
-	pre_cleanup
-
-	switch_destroy
-	h2_destroy
-	h1_destroy
-
-	vrf_cleanup
-}
-
 ping_ipv4()
 {
 	ping_test $h1.10 $(dip 0) " vlan 10"
diff --git a/tools/testing/selftests/net/forwarding/sch_ets_tests.sh b/tools/testing/selftests/net/forwarding/sch_ets_tests.sh
index f9d26a7911bb..08240d3e3c87 100644
--- a/tools/testing/selftests/net/forwarding/sch_ets_tests.sh
+++ b/tools/testing/selftests/net/forwarding/sch_ets_tests.sh
@@ -90,6 +90,7 @@ __ets_dwrr_test()
 
 	for stream in ${streams[@]}; do
 		ets_start_traffic $stream
+		defer stop_traffic $!
 	done
 
 	sleep 10
@@ -120,25 +121,24 @@ __ets_dwrr_test()
 				       ${d[0]} ${d[$i]}
 		fi
 	done
-
-	for stream in ${streams[@]}; do
-		stop_traffic
-	done
 }
 
 ets_dwrr_test_012()
 {
-	__ets_dwrr_test 0 1 2
+	in_defer_scope \
+		__ets_dwrr_test 0 1 2
 }
 
 ets_dwrr_test_01()
 {
-	__ets_dwrr_test 0 1
+	in_defer_scope \
+		__ets_dwrr_test 0 1
 }
 
 ets_dwrr_test_12()
 {
-	__ets_dwrr_test 1 2
+	in_defer_scope \
+		__ets_dwrr_test 1 2
 }
 
 ets_qdisc_setup()
-- 
2.45.0


