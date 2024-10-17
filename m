Return-Path: <linux-kselftest+bounces-19942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DDB9A1ED6
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 11:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C68EF280987
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 09:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E78C1D9A59;
	Thu, 17 Oct 2024 09:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X+yA/4Fe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA551D95B7;
	Thu, 17 Oct 2024 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158461; cv=fail; b=OUw75SlxLA7HNlN1YjIsxbCyhj6hxDh84krBSrLf5J4E8+ctkg8kBhOUvwcI05/d4kTXksJixM9FVXpHJVcB62LorQ8VcNe11VKrmtfiA8t1uXXWF6sZ8NY7uFT+OfrIuRmrplpL/CU5SXhvKkMsUVcVTs7/eim4f0gISjij+sY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158461; c=relaxed/simple;
	bh=ObiP0fdv8RsUImjMI8KYX0sTHl6ImZ4hXXxgX03zWac=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dHyZmg8oBImaqvfGrXUKzbWhv5FJwBpG5V2LSrWJlbpfkA/rH33UtLC9wb8Sq82IZirDwA+9e8hC9qqLJ6tMqEigjskuFCwDm1FpencWyCgVhD62jylVljeWt7IfowF5lEt1uzMQ2Q+LAPJVWgd4MppQcuydHpvbS74Bd40IEl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X+yA/4Fe; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCxerneNtky99/BU+r97xQ+6tln8OHJM5aPBtiaawadvM6MeGa7zdjBC4YRIYybpxAFWkaF/r1J6/AUI2ErpJNOGoV1qwaULgRto0JqNMCFzrNTczn5QARfhSv+SCBHtKkZAb50nFGFrtlMgnsCT2er1oFzyiRK7HV2XRj9fo5Oye1PZjX76bQcutQdPK7tHxuQClw2xzzETXsb3Wj4Asr11T2I7U41ai7vnfdM6PT8vK3jhUQV5kHCSigU6FIAOIBUm96lq7ZnxI7ouC4vfIxcb+sMkJlQzxaII+MMu+4wy2AFMq1nh11+LPdKRY8rJlVnO+CviIydgG2rUr684Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUWwCXIicKaeDkEbKegr5aKgaKGTbwkoWH1Sy/opfow=;
 b=raE3dXx8ecUdUwydj6bR8jiO3NoX9tHxLGIylmSJmyeHQQphdamNlyScoUdeaFOya5RgRC05xiQjOKXpSjPCgQbYQyK9usP+fbsBMxvlkIUIDXofcoebctagROebwTevAY+23fUuYt1JQhPpgsBDINg/15fsw31h6TfzH+Bgm+7xjfbg/3LoEitbDbDf2fUKWzlqb374+Bv/fzi7fwzipC5XR6qVl6qKNGETre+++UiqSH6rggC6RXD78k4zgFVzAbhr43kI1eW7OLy9M5rABqo4dF9bu8vWm4zuvj7t1Un30fiWsr1Y36fvzQTgqjsTUF5ALSfK3vJ40AKAKzjE8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUWwCXIicKaeDkEbKegr5aKgaKGTbwkoWH1Sy/opfow=;
 b=X+yA/4FeAcT0Rdmsx2/DK/wkOd9rjL5RjIEiUI/SNXXNaH4s3FU87MSo4LD2C3jFRR+mBVCO/poxq0Z2KQCi7ewt+pVjPWf3OFx2L5iPaZYLnQr5LEicFk3aOpw78n99q253GIEyWy9fzBPCGHTex4+TNwf7SnHUDd6adngNGI9iZk+HEcoxJW/Zzdj/fNZWrOVzjz15VTB3df8+m1/erJeKtP2qsm7VcKjJ4atqB73jLYfl16js3pv4rcr2hOfxey4nggrpOg8EDv99qbKCwZLS/lHM+ggSoU/4gLQECw665S5K3iFCB5FBbI+K9DVjx5CqiQEWwGzXsRq4PMfiYA==
Received: from SN7PR04CA0182.namprd04.prod.outlook.com (2603:10b6:806:126::7)
 by CH3PR12MB7546.namprd12.prod.outlook.com (2603:10b6:610:149::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Thu, 17 Oct
 2024 09:47:31 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:126:cafe::b7) by SN7PR04CA0182.outlook.office365.com
 (2603:10b6:806:126::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20 via Frontend
 Transport; Thu, 17 Oct 2024 09:47:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 09:47:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 02:47:18 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 02:47:11 -0700
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
Subject: [PATCH net-next v2 04/10] selftests: RED: Use defer for test cleanup
Date: Thu, 17 Oct 2024 11:45:46 +0200
Message-ID: <028390b4f8b61024eb58265b71fa09bbf506d615.1729157566.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|CH3PR12MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d5694bc-e840-441f-72df-08dcee90b7f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HM5UNuHqi5y3fLHfkkbqXcdECn+x4KNK8q4zvgsASBaENeEtA/eagU6t3x6j?=
 =?us-ascii?Q?ftsl+MWGZACZJox58OI6iCuH3IO/xc4q62fEQoZ52AYVUBjmYGQRhcLszafP?=
 =?us-ascii?Q?TaeEFyVslVqqn/cx2s3OR1soa8zI+0tifFxePwXOpDXL8wQvM3jls6lriro7?=
 =?us-ascii?Q?0Y0SrdrJkcoxpRChuHgkwYKHFiWizaRV7D//yPWC6KVLEOZoewt0tVZ2Sxiu?=
 =?us-ascii?Q?jrW+E1OLxTvWCAoJUxMMBp4AbNvknrMTCqS/+JMTHg1RpQagwdt9TqjxXjDN?=
 =?us-ascii?Q?y8Qi2c1YJAIxl2YRR7l5f+TH1tjjtHEqtDdaypBBCsgcoZ6gtelk8kfcmt5t?=
 =?us-ascii?Q?6vLYh6kyVcaRFaS5Alcq6klr9aHS6k7xfu3FU/UWCoPm5iAm3m2LYC2FS6bK?=
 =?us-ascii?Q?gGUMyxH/UhuxD7pxbTn4ICF19036tyB5zAc6GNteWvU4KFfQ4y4XBTutT9dH?=
 =?us-ascii?Q?2kB0a07binHMUhf315s08xJZauiIBZCecUilNgBrYTnK6h1LHyiQga/ujX4s?=
 =?us-ascii?Q?2IZjrnZMs+aKZSLOmL/GsT32bmkKRREhX7X7efRqgkiu383fRWjwk8kZ0C7/?=
 =?us-ascii?Q?NPFXhPdnGGCShIDUwlZXVAa1xAPvSseguuwdTMl/p+9NVcLZBrbYqdIodORx?=
 =?us-ascii?Q?3edID/oTOKDGS12zcr40vtUbYlzoKY9T4MFv4U2X0fxmkZPKpXVsGW8L7YJt?=
 =?us-ascii?Q?k5TsOSr1csr0/4HJ4fgg/6gGijF8/4VuTEPJxCuiJee+rLShUX/WJplmsoUE?=
 =?us-ascii?Q?xPCbIgsUgH4HNE1npDPxjD8z2a/aV6fIf+NcsbtJI+6UqxyxrROpFSAfE50H?=
 =?us-ascii?Q?Mpg95oB6j/5MN6QgoW3x3Jyyvy7g2Jw74zxZA8lYUNRcyXtRbeMHBsoAbfVh?=
 =?us-ascii?Q?fQQEDSUejaUxD2CiT9DUVGsIM6qc4xHpQbRuQT4ZniLoBiUta57eTxUujr/+?=
 =?us-ascii?Q?Bw1m3p8T/4UH2TIDS21ErsLSZi5FhkGR96/AtZHXMZcw10VPg3VJ80uwp5It?=
 =?us-ascii?Q?NPDTLE6bCb7dpUrPMN1pgKLC1/jkevtemiDYFw8LRNIUilLuuPfxj+qVpxAQ?=
 =?us-ascii?Q?iAXweD304hID4fEsOLJxzNizieBi838WlwnFzK81jCSi4cg86zIiGZf+DKcW?=
 =?us-ascii?Q?wo8yhhnreBvBMgq09TNUHsrx7KjhQQ68W727E1O+78BEiLaHPjlsyBDh62aU?=
 =?us-ascii?Q?z3cFnwedoPz3604V92tpJDja51iMl5zJLpDsm57ZN14WgeZpV+Yg3rhsl3qG?=
 =?us-ascii?Q?kY6AfRvymTiOguL3Nn9ktRpEMyxf0ylvQuC/hKSOZgxDm4fQ2A6U9JXxH3Mq?=
 =?us-ascii?Q?J4pnUaJgeaYdryatlS2vca/WcEKRdQOELl0HhLCOFFUjJp+oMdmsgCZxgZ4Z?=
 =?us-ascii?Q?6P3C1v3ECcpOemYDf1saX6ZIzwK+tb+T2NWuY00wh7MvSbBAfA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 09:47:30.7495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5694bc-e840-441f-72df-08dcee90b7f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7546

Instead of having a suite of dedicated cleanup functions, use the defer
framework to schedule cleanups right as their setup functions are run.

The sleep after stop_traffic() in mlxsw selftests is necessary, but
scheduling it as "defer sleep; defer stop_traffic" is silly. Instead, add a
local helper to stop traffic and sleep afterwards.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
    v2:
    - Defer stop_traffic including the sleep. The sleep is actually
      necessary and v1 was wrong in that it had the sleep prior to the
      stop_traffic invocation.

 .../drivers/net/mlxsw/sch_red_core.sh         | 185 +++++++++---------
 .../drivers/net/mlxsw/sch_red_ets.sh          |  24 +--
 .../drivers/net/mlxsw/sch_red_root.sh         |  18 +-
 .../selftests/net/forwarding/sch_red.sh       | 103 ++++------
 4 files changed, 149 insertions(+), 181 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh b/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
index f4c324957dcc..537d6baa77b7 100644
--- a/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
@@ -75,6 +75,18 @@ source $lib_dir/lib.sh
 source $lib_dir/devlink_lib.sh
 source mlxsw_lib.sh
 
+stop_traffic_sleep()
+{
+	local pid=$1; shift
+
+	# Issuing a kill still leaves a bunch of packets lingering in the
+	# buffers. This traffic then arrives at the point where a follow-up test
+	# is already running, and can confuse the test. Therefore sleep after
+	# stopping traffic to flush any leftover packets.
+	stop_traffic "$pid"
+	sleep 1
+}
+
 ipaddr()
 {
 	local host=$1; shift
@@ -89,39 +101,31 @@ host_create()
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
@@ -139,13 +143,7 @@ h2_create()
 
 	tc qdisc replace dev $h2 root handle 10: tbf rate 200mbit \
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
@@ -153,40 +151,54 @@ h3_create()
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
 
@@ -201,49 +213,25 @@ switch_create()
 	for intf in $swp3 $swp4; do
 		tc qdisc replace dev $intf root handle 1: tbf rate 200mbit \
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
@@ -263,6 +251,7 @@ setup_prepare()
 	h3_mac=$(mac_get $h3)
 
 	vrf_prepare
+	defer vrf_cleanup
 
 	h1_create
 	h2_create
@@ -270,18 +259,6 @@ setup_prepare()
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
@@ -450,6 +427,7 @@ __do_ecn_test()
 
 	start_tcp_traffic $h1.$vlan $(ipaddr 1 $vlan) $(ipaddr 3 $vlan) \
 			  $h3_mac tos=0x01
+	defer stop_traffic_sleep $!
 	sleep 1
 
 	ecn_test_common "$name" "$get_nmarked" $vlan $limit
@@ -461,9 +439,6 @@ __do_ecn_test()
 	build_backlog $vlan $((2 * limit)) udp >/dev/null
 	check_fail $? "UDP traffic went into backlog instead of being early-dropped"
 	log_test "TC $((vlan - 10)): $name backlog > limit: UDP early-dropped"
-
-	stop_traffic
-	sleep 1
 }
 
 do_ecn_test()
@@ -471,7 +446,8 @@ do_ecn_test()
 	local vlan=$1; shift
 	local limit=$1; shift
 
-	__do_ecn_test get_nmarked "$vlan" "$limit"
+	in_defer_scope \
+		__do_ecn_test get_nmarked "$vlan" "$limit"
 }
 
 do_ecn_test_perband()
@@ -480,10 +456,11 @@ do_ecn_test_perband()
 	local limit=$1; shift
 
 	mlxsw_only_on_spectrum 3+ || return
-	__do_ecn_test get_qdisc_nmarked "$vlan" "$limit" "per-band ECN"
+	in_defer_scope \
+		__do_ecn_test get_qdisc_nmarked "$vlan" "$limit" "per-band ECN"
 }
 
-do_ecn_nodrop_test()
+__do_ecn_nodrop_test()
 {
 	local vlan=$1; shift
 	local limit=$1; shift
@@ -491,6 +468,7 @@ do_ecn_nodrop_test()
 
 	start_tcp_traffic $h1.$vlan $(ipaddr 1 $vlan) $(ipaddr 3 $vlan) \
 			  $h3_mac tos=0x01
+	defer stop_traffic_sleep $!
 	sleep 1
 
 	ecn_test_common "$name" get_nmarked $vlan $limit
@@ -502,12 +480,15 @@ do_ecn_nodrop_test()
 	build_backlog $vlan $((2 * limit)) udp >/dev/null
 	check_err $? "UDP traffic was early-dropped instead of getting into backlog"
 	log_test "TC $((vlan - 10)): $name backlog > limit: UDP not dropped"
+}
 
-	stop_traffic
-	sleep 1
+do_ecn_nodrop_test()
+{
+	in_defer_scope \
+		__do_ecn_nodrop_test "$@"
 }
 
-do_red_test()
+__do_red_test()
 {
 	local vlan=$1; shift
 	local limit=$1; shift
@@ -518,6 +499,7 @@ do_red_test()
 	# is above limit.
 	start_tcp_traffic $h1.$vlan $(ipaddr 1 $vlan) $(ipaddr 3 $vlan) \
 			  $h3_mac tos=0x01
+	defer stop_traffic_sleep $!
 
 	# Pushing below the queue limit should work.
 	RET=0
@@ -539,12 +521,15 @@ do_red_test()
 	((-15 <= pct && pct <= 15))
 	check_err $? "backlog $backlog / $limit expected <= 15% distance"
 	log_test "TC $((vlan - 10)): RED backlog > limit"
+}
 
-	stop_traffic
-	sleep 1
+do_red_test()
+{
+	in_defer_scope \
+		__do_red_test "$@"
 }
 
-do_mc_backlog_test()
+__do_mc_backlog_test()
 {
 	local vlan=$1; shift
 	local limit=$1; shift
@@ -554,7 +539,10 @@ do_mc_backlog_test()
 	RET=0
 
 	start_tcp_traffic $h1.$vlan $(ipaddr 1 $vlan) $(ipaddr 3 $vlan) bc
+	defer stop_traffic_sleep $!
+
 	start_tcp_traffic $h2.$vlan $(ipaddr 2 $vlan) $(ipaddr 3 $vlan) bc
+	defer stop_traffic_sleep $!
 
 	qbl=$(busywait 5000 until_counter_is ">= 500000" \
 		       get_qdisc_backlog $vlan)
@@ -567,13 +555,16 @@ do_mc_backlog_test()
 		       get_mc_transmit_queue $vlan)
 	check_err $? "MC backlog reported by qdisc not visible in ethtool"
 
-	stop_traffic
-	stop_traffic
-
 	log_test "TC $((vlan - 10)): Qdisc reports MC backlog"
 }
 
-do_mark_test()
+do_mc_backlog_test()
+{
+	in_defer_scope \
+		__do_mc_backlog_test "$@"
+}
+
+__do_mark_test()
 {
 	local vlan=$1; shift
 	local limit=$1; shift
@@ -588,6 +579,7 @@ do_mark_test()
 
 	start_tcp_traffic $h1.$vlan $(ipaddr 1 $vlan) $(ipaddr 3 $vlan) \
 			  $h3_mac tos=0x01
+	defer stop_traffic_sleep $!
 
 	# Create a bit of a backlog and observe no mirroring due to marks.
 	qevent_rule_install_$subtest
@@ -617,12 +609,15 @@ do_mark_test()
 	else
 		log_test "TC $((vlan - 10)): marked packets $subtest'd"
 	fi
+}
 
-	stop_traffic
-	sleep 1
+do_mark_test()
+{
+	in_defer_scope \
+		__do_mark_test "$@"
 }
 
-do_drop_test()
+__do_drop_test()
 {
 	local vlan=$1; shift
 	local limit=$1; shift
@@ -637,6 +632,7 @@ do_drop_test()
 	RET=0
 
 	start_traffic $h1.$vlan $(ipaddr 1 $vlan) $(ipaddr 3 $vlan) $h3_mac
+	defer stop_traffic_sleep $!
 
 	# Create a bit of a backlog and observe no mirroring due to drops.
 	qevent_rule_install_$subtest
@@ -671,9 +667,12 @@ do_drop_test()
 	check_fail $? "$((now - base)) spurious packets observed after uninstall"
 
 	log_test "TC $((vlan - 10)): ${trigger}ped packets $subtest'd"
+}
 
-	stop_traffic
-	sleep 1
+do_drop_test()
+{
+	in_defer_scope \
+		__do_drop_test "$@"
 }
 
 qevent_rule_install_mirror()
diff --git a/tools/testing/selftests/drivers/net/mlxsw/sch_red_ets.sh b/tools/testing/selftests/drivers/net/mlxsw/sch_red_ets.sh
index 576067b207a8..8902a115d9cd 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/sch_red_ets.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/sch_red_ets.sh
@@ -80,36 +80,34 @@ uninstall_qdisc()
 ecn_test()
 {
 	install_qdisc ecn
+	defer uninstall_qdisc
 
 	do_ecn_test 10 $BACKLOG1
 	do_ecn_test 11 $BACKLOG2
-
-	uninstall_qdisc
 }
 
 ecn_test_perband()
 {
 	install_qdisc ecn
+	defer uninstall_qdisc
 
 	do_ecn_test_perband 10 $BACKLOG1
 	do_ecn_test_perband 11 $BACKLOG2
-
-	uninstall_qdisc
 }
 
 ecn_nodrop_test()
 {
 	install_qdisc ecn nodrop
+	defer uninstall_qdisc
 
 	do_ecn_nodrop_test 10 $BACKLOG1
 	do_ecn_nodrop_test 11 $BACKLOG2
-
-	uninstall_qdisc
 }
 
 red_test()
 {
 	install_qdisc
+	defer uninstall_qdisc
 
 	# Make sure that we get the non-zero value if there is any.
 	local cur=$(busywait 1100 until_counter_is "> 0" \
@@ -120,50 +118,44 @@ red_test()
 
 	do_red_test 10 $BACKLOG1
 	do_red_test 11 $BACKLOG2
-
-	uninstall_qdisc
 }
 
 mc_backlog_test()
 {
 	install_qdisc
+	defer uninstall_qdisc
 
 	# Note that the backlog numbers here do not correspond to RED
 	# configuration, but are arbitrary.
 	do_mc_backlog_test 10 $BACKLOG1
 	do_mc_backlog_test 11 $BACKLOG2
-
-	uninstall_qdisc
 }
 
 red_mirror_test()
 {
 	install_qdisc qevent early_drop block 10
+	defer uninstall_qdisc
 
 	do_drop_mirror_test 10 $BACKLOG1 early_drop
 	do_drop_mirror_test 11 $BACKLOG2 early_drop
-
-	uninstall_qdisc
 }
 
 red_trap_test()
 {
 	install_qdisc qevent early_drop block 10
+	defer uninstall_qdisc
 
 	do_drop_trap_test 10 $BACKLOG1 early_drop
 	do_drop_trap_test 11 $BACKLOG2 early_drop
-
-	uninstall_qdisc
 }
 
 ecn_mirror_test()
 {
 	install_qdisc ecn qevent mark block 10
+	defer uninstall_qdisc
 
 	do_mark_mirror_test 10 $BACKLOG1
 	do_mark_mirror_test 11 $BACKLOG2
-
-	uninstall_qdisc
 }
 
 bail_on_lldpad "configure DCB" "configure Qdiscs"
diff --git a/tools/testing/selftests/drivers/net/mlxsw/sch_red_root.sh b/tools/testing/selftests/drivers/net/mlxsw/sch_red_root.sh
index 159108d02895..e9043771787b 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/sch_red_root.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/sch_red_root.sh
@@ -32,45 +32,51 @@ uninstall_qdisc()
 ecn_test()
 {
 	install_qdisc ecn
+	defer uninstall_qdisc
+
 	do_ecn_test 10 $BACKLOG
-	uninstall_qdisc
 }
 
 ecn_test_perband()
 {
 	install_qdisc ecn
+	defer uninstall_qdisc
+
 	do_ecn_test_perband 10 $BACKLOG
-	uninstall_qdisc
 }
 
 ecn_nodrop_test()
 {
 	install_qdisc ecn nodrop
+	defer uninstall_qdisc
+
 	do_ecn_nodrop_test 10 $BACKLOG
-	uninstall_qdisc
 }
 
 red_test()
 {
 	install_qdisc
+	defer uninstall_qdisc
+
 	do_red_test 10 $BACKLOG
-	uninstall_qdisc
 }
 
 mc_backlog_test()
 {
 	install_qdisc
+	defer uninstall_qdisc
+
 	# Note that the backlog value here does not correspond to RED
 	# configuration, but is arbitrary.
 	do_mc_backlog_test 10 $BACKLOG
-	uninstall_qdisc
 }
 
 red_mirror_test()
 {
 	install_qdisc qevent early_drop block 10
+	defer uninstall_qdisc
+
 	do_drop_mirror_test 10 $BACKLOG
-	uninstall_qdisc
 }
 
 bail_on_lldpad "configure DCB" "configure Qdiscs"
diff --git a/tools/testing/selftests/net/forwarding/sch_red.sh b/tools/testing/selftests/net/forwarding/sch_red.sh
index 17f28644568e..af166662b78a 100755
--- a/tools/testing/selftests/net/forwarding/sch_red.sh
+++ b/tools/testing/selftests/net/forwarding/sch_red.sh
@@ -53,71 +53,63 @@ PKTSZ=1400
 h1_create()
 {
 	simple_if_init $h1 192.0.2.1/28
+	defer simple_if_fini $h1 192.0.2.1/28
+
 	mtu_set $h1 10000
+	defer mtu_restore $h1
+
 	tc qdisc replace dev $h1 root handle 1: tbf \
 	   rate 10Mbit burst 10K limit 1M
-}
-
-h1_destroy()
-{
-	tc qdisc del dev $h1 root
-	mtu_restore $h1
-	simple_if_fini $h1 192.0.2.1/28
+	defer tc qdisc del dev $h1 root
 }
 
 h2_create()
 {
 	simple_if_init $h2 192.0.2.2/28
+	defer simple_if_fini $h2 192.0.2.2/28
+
 	mtu_set $h2 10000
-}
-
-h2_destroy()
-{
-	mtu_restore $h2
-	simple_if_fini $h2 192.0.2.2/28
+	defer mtu_restore $h2
 }
 
 h3_create()
 {
 	simple_if_init $h3 192.0.2.3/28
+	defer simple_if_fini $h3 192.0.2.3/28
+
 	mtu_set $h3 10000
-}
-
-h3_destroy()
-{
-	mtu_restore $h3
-	simple_if_fini $h3 192.0.2.3/28
+	defer mtu_restore $h3
 }
 
 switch_create()
 {
 	ip link add dev br up type bridge
+	defer ip link del dev br
+
 	ip link set dev $swp1 up master br
+	defer ip link set dev $swp1 down nomaster
+
 	ip link set dev $swp2 up master br
+	defer ip link set dev $swp2 down nomaster
+
 	ip link set dev $swp3 up master br
+	defer ip link set dev $swp3 down nomaster
 
 	mtu_set $swp1 10000
+	defer mtu_restore $h1
+
 	mtu_set $swp2 10000
+	defer mtu_restore $h2
+
 	mtu_set $swp3 10000
+	defer mtu_restore $h3
 
 	tc qdisc replace dev $swp3 root handle 1: tbf \
 	   rate 10Mbit burst 10K limit 1M
+	defer tc qdisc del dev $swp3 root
+
 	ip link add name _drop_test up type dummy
-}
-
-switch_destroy()
-{
-	ip link del dev _drop_test
-	tc qdisc del dev $swp3 root
-
-	mtu_restore $h3
-	mtu_restore $h2
-	mtu_restore $h1
-
-	ip link set dev $swp3 down nomaster
-	ip link set dev $swp2 down nomaster
-	ip link set dev $swp1 down nomaster
-	ip link del dev br
+	defer ip link del dev _drop_test
 }
 
 setup_prepare()
@@ -134,6 +126,7 @@ setup_prepare()
 	h3_mac=$(mac_get $h3)
 
 	vrf_prepare
+	defer vrf_cleanup
 
 	h1_create
 	h2_create
@@ -141,18 +134,6 @@ setup_prepare()
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
 	ping_test $h1 192.0.2.3 " from host 1"
@@ -287,6 +268,7 @@ do_ecn_test()
 
 	$MZ $h1 -p $PKTSZ -A 192.0.2.1 -B 192.0.2.3 -c 0 \
 		-a own -b $h3_mac -t tcp -q tos=0x01 &
+	defer stop_traffic $!
 	sleep 1
 
 	ecn_test_common "$name" $limit
@@ -298,9 +280,6 @@ do_ecn_test()
 	build_backlog $((2 * limit)) udp >/dev/null
 	check_fail $? "UDP traffic went into backlog instead of being early-dropped"
 	log_test "$name backlog > limit: UDP early-dropped"
-
-	stop_traffic
-	sleep 1
 }
 
 do_ecn_nodrop_test()
@@ -310,6 +289,7 @@ do_ecn_nodrop_test()
 
 	$MZ $h1 -p $PKTSZ -A 192.0.2.1 -B 192.0.2.3 -c 0 \
 		-a own -b $h3_mac -t tcp -q tos=0x01 &
+	defer stop_traffic $!
 	sleep 1
 
 	ecn_test_common "$name" $limit
@@ -321,9 +301,6 @@ do_ecn_nodrop_test()
 	build_backlog $((2 * limit)) udp >/dev/null
 	check_err $? "UDP traffic was early-dropped instead of getting into backlog"
 	log_test "$name backlog > limit: UDP not dropped"
-
-	stop_traffic
-	sleep 1
 }
 
 do_red_test()
@@ -336,6 +313,7 @@ do_red_test()
 	# is above limit.
 	$MZ $h1 -p $PKTSZ -A 192.0.2.1 -B 192.0.2.3 -c 0 \
 		-a own -b $h3_mac -t tcp -q tos=0x01 &
+	defer stop_traffic $!
 
 	# Pushing below the queue limit should work.
 	RET=0
@@ -352,9 +330,6 @@ do_red_test()
 	pct=$(check_marking "== 0")
 	check_err $? "backlog $backlog / $limit Got $pct% marked packets, expected == 0."
 	log_test "RED backlog > limit"
-
-	stop_traffic
-	sleep 1
 }
 
 do_red_qevent_test()
@@ -369,6 +344,7 @@ do_red_qevent_test()
 
 	$MZ $h1 -p $PKTSZ -A 192.0.2.1 -B 192.0.2.3 -c 0 \
 		-a own -b $h3_mac -t udp -q &
+	defer stop_traffic $!
 	sleep 1
 
 	tc filter add block 10 pref 1234 handle 102 matchall skip_hw \
@@ -396,9 +372,6 @@ do_red_qevent_test()
 	check_err $? "Dropped packets still observed: 0 expected, $((now - base)) seen"
 
 	log_test "RED early_dropped packets mirrored"
-
-	stop_traffic
-	sleep 1
 }
 
 do_ecn_qevent_test()
@@ -410,6 +383,7 @@ do_ecn_qevent_test()
 
 	$MZ $h1 -p $PKTSZ -A 192.0.2.1 -B 192.0.2.3 -c 0 \
 		-a own -b $h3_mac -t tcp -q tos=0x01 &
+	defer stop_traffic $!
 	sleep 1
 
 	tc filter add block 10 pref 1234 handle 102 matchall skip_hw \
@@ -428,9 +402,6 @@ do_ecn_qevent_test()
 	tc filter del block 10 pref 1234 handle 102 matchall
 
 	log_test "ECN marked packets mirrored"
-
-	stop_traffic
-	sleep 1
 }
 
 install_qdisc()
@@ -451,36 +422,36 @@ uninstall_qdisc()
 ecn_test()
 {
 	install_qdisc ecn
+	defer uninstall_qdisc
 	xfail_on_slow do_ecn_test $BACKLOG
-	uninstall_qdisc
 }
 
 ecn_nodrop_test()
 {
 	install_qdisc ecn nodrop
+	defer uninstall_qdisc
 	xfail_on_slow do_ecn_nodrop_test $BACKLOG
-	uninstall_qdisc
 }
 
 red_test()
 {
 	install_qdisc
+	defer uninstall_qdisc
 	xfail_on_slow do_red_test $BACKLOG
-	uninstall_qdisc
 }
 
 red_qevent_test()
 {
 	install_qdisc qevent early_drop block 10
+	defer uninstall_qdisc
 	xfail_on_slow do_red_qevent_test $BACKLOG
-	uninstall_qdisc
 }
 
 ecn_qevent_test()
 {
 	install_qdisc ecn qevent mark block 10
+	defer uninstall_qdisc
 	xfail_on_slow do_ecn_qevent_test $BACKLOG
-	uninstall_qdisc
 }
 
 trap cleanup EXIT
-- 
2.45.0


