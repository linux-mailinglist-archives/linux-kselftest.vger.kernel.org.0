Return-Path: <linux-kselftest+bounces-19348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3564A9969AE
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 14:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594D61C23D22
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 12:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C02193432;
	Wed,  9 Oct 2024 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cQqwm/g+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83CB19006F;
	Wed,  9 Oct 2024 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728475844; cv=fail; b=kTF/Ry9FsiAkZm2Kh5k2XpQr5in87R3ULZXrDxR1r2wCi47Kc9PM+Sm0C+z2Tow+6pL8rIMDJjaC6FTXlsgF0chkvu8WRab5Sg44XcFt4G7FrjLwl7OQYQpuFFtQiRMwqnGYP9g82vKrL6tvtf9xYw4BK6aBdylTk9y50VNDl00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728475844; c=relaxed/simple;
	bh=9PGRiBQm/ApCeGx5PATZWY6/Ljsu3RCC40RCRLULLhQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iFNWCYrH9XBDSRifu3d2910+avxmBRBCzZf8pTmud4vK2WL8DCwnA9GAwOIUcVzEvX6KntLIle/tYriMXmAmBufdQMmhX/XArGFUjcTTjf9vVKk+nO5LtjgtIeUGlUi29kGGw2nPJe4LIE7d6DuyX6WNZTK4R6pzdMGnK4KoNk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cQqwm/g+; arc=fail smtp.client-ip=40.107.96.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2uX2f4WcCcKWvqYguwTaMdm2rH94ie4rE/E/wsCIFx6CrzPsWl9GolvugoL6lcajdV75yUAWvq5/CNymVHjyJaih6NCXhUpKI5h6G4gBknQzwNNw63p4LcB+oj5OaUzsmHZYRxz6T3GdIUWmW5CZOSsPWQgngAVELk+aCo1KGXzUeqwvW/q3spXNFQttqQSI/7aFqA/mwbpXtT4h9aOm0mu2nozGqR52Aaoqu3ksGXb4Zwfq7DrwEq7o7+eSdx0EFVs2ZIkhgwl5hMzknvlvtxglzw3wc8H3DSF6R/iF0kIKQchhuTbovqv2v10IXVxU0eDyEc/mDUzzn3XzqtbvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/1i1D71+QW3wXnzlxEgi0qBWvlZaqrZR/7tsBQ6nkQ=;
 b=y/fEFMSwunj40QIESce9OPQ+riMOtbMNKYNhqLPq1n4/tNw5WbwnkWs74Nl2LVcBjEvwnF/pTUDgTbOZSB7uexFiOITfNraah6XLvaFOv3TzmOufhTMKSGplGxscmXQ3T9t92at7AxGKQ3DPEIaOXiRYEskLx/cJ+njeolzzScyhN04QFYhpmPKUD8j6M4AFh7BzQKyurC8ZWovOw64K/TYufyv6sYtgStxJjYHXj7MeXqMxOB1K29A8qHqxOb2jkcZrHhvYZir57aPYK4Ecge/KP30dekJ965Fl5i1Q9RzWXvZI4/XiPF3X1HTW5cuILy3L6QijzUwJScE6VRqIqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/1i1D71+QW3wXnzlxEgi0qBWvlZaqrZR/7tsBQ6nkQ=;
 b=cQqwm/g+KXlpCaGxDkhI6kByQcd6JSi+qqSgxTytCbisURIukJGEBLLe/8X0WSzlA7sGOe/CPpAJ4Q+Fn9Re3A4nAP8TVx1MIQ7J2c7tdRGoPBlh1awCazrB6/8zkNhfLTA01whZB1hy4hkLD0ZCbYKua3V8CJ6XUPmuKZcAxY71TsrXco3jhgA8TIP7+xZgtJx7zsZ3dsah+/z0TxuI9SMqhRM3wOYFnRPWXPBOrPQKwstqs19LZtNU35cdi5almib/06rTcHzVqEUW8qNo0br0AO3dkx2xM6SX28VWtpX/2wOGwlUGWvJi8Yr6AVwcsw6CFTkM/qsFkJTZSg18EA==
Received: from DM6PR02CA0060.namprd02.prod.outlook.com (2603:10b6:5:177::37)
 by CY8PR12MB7633.namprd12.prod.outlook.com (2603:10b6:930:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 12:10:36 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:177:cafe::60) by DM6PR02CA0060.outlook.office365.com
 (2603:10b6:5:177::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 12:10:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 12:10:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 05:10:19 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 05:10:11 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
	"Benjamin Poirier" <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	"Vladimir Oltean" <vladimir.oltean@nxp.com>, Ido Schimmel
	<idosch@nvidia.com>, "Przemek Kitszel" <przemyslaw.kitszel@intel.com>, Petr
 Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 09/10] selftests: mlxsw: qos_max_descriptors: Use defer for test cleanup
Date: Wed, 9 Oct 2024 14:06:27 +0200
Message-ID: <1871e147c5f3ea3af68bd5fbc7285895d123d869.1728473602.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|CY8PR12MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a41d884-3257-4ed7-8177-08dce85b620c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3h0S6WqCRHXpUNIODYRCY2FfeXIN5V9FJP7Z35CxfXsBcG+JlYHV3hpOosIl?=
 =?us-ascii?Q?T91D1Bkqmwi6LffqWWyWYQqIfXnvRCFQB/xCgqCGNqYkil/QO7T9VIIrVpBE?=
 =?us-ascii?Q?fZmezmbjNTDytH3RMh27ym2oy1lbjGEipoXL0Lwe78z/zepbq9pJqgsRRMSU?=
 =?us-ascii?Q?SHyobXmOXdMLhDsapTsmp7DzQgAPUoItUXrB273TH/2lx1Auon4q2PLKhryy?=
 =?us-ascii?Q?v02GqLx+Xd/FsLPZz9J3zxyV0hx3A+ugiPfKtDH76MiemYusKy6huYo9HT0S?=
 =?us-ascii?Q?y1KeXktr+i/iKknFIh88Jl3dLHEVKsojXFLwbXuLvcyEancDopEk74e6ZNhG?=
 =?us-ascii?Q?bzBSD8QSEZkDldM+4lNCaRYRI/V5ggnFbYlyytP2aWfelyn2t0Rcb7VqUIJT?=
 =?us-ascii?Q?SMBHL81GmviGtnWtP1iHvdAM9ZY4pvDm6lIfLT7Ojj8aCd5ZPh0K8OQOZvV6?=
 =?us-ascii?Q?pO6l7MhPhN0z86TP/OGYq0bMEGvq1Wc4I2cnFTQxN3djYEbQH54F2a3qnRHl?=
 =?us-ascii?Q?G2xze9hYt570842smvPwQyfCMN6N1lEWy6V49hGeAWwbMWJMnnzDIRCfg/9a?=
 =?us-ascii?Q?gJOkxHpi079A282bQbRmd2pfWtYQro7M3IEYTrGEYSleo3mcznDxp/xmoVbc?=
 =?us-ascii?Q?osx/Z8JIOfydZ1k2zOXW625eBXCw+hZZB+nga3YDAIZGcDauEAZWS9w6PRTp?=
 =?us-ascii?Q?CEcELOoIDAxbshI/nuRhu+knPR+bksfgnJD5XG3unyu+dbU9gq4h/kobebwi?=
 =?us-ascii?Q?XQdgnSEws3uGovIE7zRDcL0/HujKGUrWfKrbsVlnr6AFV5cUpPcmedb0PcI7?=
 =?us-ascii?Q?ePfjMekS4rh+quQRTi8CJyuVIbTFbGJM34enP9ckacnF/yL+a0Bs0irThuAA?=
 =?us-ascii?Q?Vx7KtIqqr895G00fKf/LVGg3VNMu4xdjx0t908rXWhPy9HLL8g9Rt1U8wuG9?=
 =?us-ascii?Q?6IL67PwmfcDeH+BERL34A3mLogk15O8vIGMejmooQeurXLNgMAuRjUIkeQr5?=
 =?us-ascii?Q?iWwao4pnqlbzDvqRbR1iZ5jhTvBTwcY39wIM1ZjZgkKBvRQdxORQUcR8KF6a?=
 =?us-ascii?Q?GetOLpIgyP+pr5QUKYNe+HC4MUvwYgCTQUGpNvXTeOmCq/vCOX/byQzO2lk1?=
 =?us-ascii?Q?byh6dgj3oaeEcL8ZN3gPVkZ513SHLIiN8oogNV4GBcUq9FeTKy080kpy0sdU?=
 =?us-ascii?Q?UtOr6yFQYlNv2pbvoladQARsoe60l4VXGG0SZW94ZsSQOy1BVvhEtaTXLS1j?=
 =?us-ascii?Q?yObS/Iwo448TKUqVspmWoYkPYMhGamIAKT0A3V1LJPRosO6SZqd2lS94uPee?=
 =?us-ascii?Q?Ck65E409a1LZYHJD8Qq0wpfLXMxomJvn/qG/LBOToGIExZeN6KNjFJB5bNRS?=
 =?us-ascii?Q?E4PWr1E=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 12:10:36.2860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a41d884-3257-4ed7-8177-08dce85b620c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7633

Use the defer framework to schedule cleanups as soon as the command is
executed.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../drivers/net/mlxsw/qos_max_descriptors.sh  | 118 ++++++------------
 1 file changed, 41 insertions(+), 77 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/qos_max_descriptors.sh b/tools/testing/selftests/drivers/net/mlxsw/qos_max_descriptors.sh
index 5ac4f795e333..2b5d2c2751d5 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/qos_max_descriptors.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/qos_max_descriptors.sh
@@ -69,127 +69,103 @@ mlxsw_only_on_spectrum 2+ || exit
 h1_create()
 {
 	simple_if_init $h1
+	defer simple_if_fini $h1
 
 	vlan_create $h1 111 v$h1 192.0.2.33/28
+	defer vlan_destroy $h1 111
 	ip link set dev $h1.111 type vlan egress-qos-map 0:1
 }
 
-h1_destroy()
-{
-	vlan_destroy $h1 111
-
-	simple_if_fini $h1
-}
-
 h2_create()
 {
 	simple_if_init $h2
+	defer simple_if_fini $h2
 
 	vlan_create $h2 111 v$h2 192.0.2.34/28
-}
-
-h2_destroy()
-{
-	vlan_destroy $h2 111
-
-	simple_if_fini $h2
+	defer vlan_destroy $h2 111
 }
 
 switch_create()
 {
 	# pools
 	# -----
+	# devlink_pool_size_thtype_restore needs to be done first so that we can
+	# reset the various limits to values that are only valid for the
+	# original static / dynamic setting.
 
 	devlink_pool_size_thtype_save 1
-	devlink_pool_size_thtype_save 6
-
-	devlink_port_pool_th_save $swp1 1
-	devlink_port_pool_th_save $swp2 6
-
-	devlink_tc_bind_pool_th_save $swp1 1 ingress
-	devlink_tc_bind_pool_th_save $swp2 1 egress
-
 	devlink_pool_size_thtype_set 1 dynamic $MAX_POOL_SIZE
+	defer_prio devlink_pool_size_thtype_restore 1
+
+	devlink_pool_size_thtype_save 6
 	devlink_pool_size_thtype_set 6 static $MAX_POOL_SIZE
+	defer_prio devlink_pool_size_thtype_restore 6
 
 	# $swp1
 	# -----
 
 	ip link set dev $swp1 up
+	defer ip link set dev $swp1 down
+
 	vlan_create $swp1 111
+	defer vlan_destroy $swp1 111
 	ip link set dev $swp1.111 type vlan ingress-qos-map 0:0 1:1
 
+	devlink_port_pool_th_save $swp1 1
 	devlink_port_pool_th_set $swp1 1 16
+	defer devlink_tc_bind_pool_th_restore $swp1 1 ingress
+
+	devlink_tc_bind_pool_th_save $swp1 1 ingress
 	devlink_tc_bind_pool_th_set $swp1 1 ingress 1 16
+	defer devlink_port_pool_th_restore $swp1 1
 
 	tc qdisc replace dev $swp1 root handle 1: \
 	   ets bands 8 strict 8 priomap 7 6
+	defer tc qdisc del dev $swp1 root
+
 	dcb buffer set dev $swp1 prio-buffer all:0 1:1
+	defer dcb buffer set dev $swp1 prio-buffer all:0
 
 	# $swp2
 	# -----
 
 	ip link set dev $swp2 up
+	defer ip link set dev $swp2 down
+
 	vlan_create $swp2 111
+	defer vlan_destroy $swp2 111
 	ip link set dev $swp2.111 type vlan egress-qos-map 0:0 1:1
 
+	devlink_port_pool_th_save $swp2 6
 	devlink_port_pool_th_set $swp2 6 $MAX_POOL_SIZE
+	defer devlink_tc_bind_pool_th_restore $swp2 1 egress
+
+	devlink_tc_bind_pool_th_save $swp2 1 egress
 	devlink_tc_bind_pool_th_set $swp2 1 egress 6 $MAX_POOL_SIZE
+	defer devlink_port_pool_th_restore $swp2 6
 
 	tc qdisc replace dev $swp2 root handle 1: tbf rate $SHAPER_RATE \
 		burst 128K limit 500M
+	defer tc qdisc del dev $swp2 root
+
 	tc qdisc replace dev $swp2 parent 1:1 handle 11: \
 		ets bands 8 strict 8 priomap 7 6
+	defer tc qdisc del dev $swp2 parent 1:1 handle 11:
 
 	# bridge
 	# ------
 
 	ip link add name br1 type bridge vlan_filtering 0
+	defer ip link del dev br1
+
 	ip link set dev $swp1.111 master br1
+	defer ip link set dev $swp1.111 nomaster
+
 	ip link set dev br1 up
+	defer ip link set dev br1 down
 
 	ip link set dev $swp2.111 master br1
-}
-
-switch_destroy()
-{
-	# Do this first so that we can reset the limits to values that are only
-	# valid for the original static / dynamic setting.
-	devlink_pool_size_thtype_restore 6
-	devlink_pool_size_thtype_restore 1
-
-	# bridge
-	# ------
-
-	ip link set dev $swp2.111 nomaster
-
-	ip link set dev br1 down
-	ip link set dev $swp1.111 nomaster
-	ip link del dev br1
-
-	# $swp2
-	# -----
-
-	tc qdisc del dev $swp2 parent 1:1 handle 11:
-	tc qdisc del dev $swp2 root
-
-	devlink_tc_bind_pool_th_restore $swp2 1 egress
-	devlink_port_pool_th_restore $swp2 6
-
-	vlan_destroy $swp2 111
-	ip link set dev $swp2 down
-
-	# $swp1
-	# -----
-
-	dcb buffer set dev $swp1 prio-buffer all:0
-	tc qdisc del dev $swp1 root
-
-	devlink_tc_bind_pool_th_restore $swp1 1 ingress
-	devlink_port_pool_th_restore $swp1 1
-
-	vlan_destroy $swp1 111
-	ip link set dev $swp1 down
+	defer ip link set dev $swp2.111 nomaster
 }
 
 setup_prepare()
@@ -203,23 +179,13 @@ setup_prepare()
 	h2mac=$(mac_get $h2)
 
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
 	ping_test $h1 192.0.2.34 " h1->h2"
@@ -251,6 +217,7 @@ max_descriptors()
 
 	log_info "Send many small packets, packet size = $pktsize bytes"
 	start_traffic_pktsize $pktsize $h1.111 192.0.2.33 192.0.2.34 $h2mac
+	defer stop_traffic $!
 
 	# Sleep to wait for congestion.
 	sleep 5
@@ -268,9 +235,6 @@ max_descriptors()
 	check_err $(bc <<< "$perc_used < $exp_perc_used") \
 		"Expected > $exp_perc_used% of descriptors, handle $perc_used%"
 
-	stop_traffic
-	sleep 1
-
 	log_test "Maximum descriptors usage. The percentage used is $perc_used%"
 }
 
-- 
2.45.0


