Return-Path: <linux-kselftest+bounces-19946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7379A1EE5
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 11:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713F51F21A24
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 09:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ED11DC068;
	Thu, 17 Oct 2024 09:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VxO72ksG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201FE1DACA7;
	Thu, 17 Oct 2024 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158488; cv=fail; b=TjTZqPeJ0RXI/2RvottYinczrkscowaZYS51oA+ATdMJqnXafmt/nAsNBLifERBY7C8/znu6cijVibAEMsYgZvqMOOeVtAU4NyMNN1jmT8m0HzaDAuKs/qrR87MeP1ZDlMszqy8w0zl+Cha83Y44GL6kK8UCVUnhVDPdulBeH3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158488; c=relaxed/simple;
	bh=9PGRiBQm/ApCeGx5PATZWY6/Ljsu3RCC40RCRLULLhQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NRVK0cKCywmU9kafegY0qETHf+I4wGtUFx1CP9pj0uuRUobqulvpjziEtX8Jz6k+idSUPawDHcvFGKDqoH9dj+LematrWthpCGJEW8PMuCSdggz0NWpEqZd4m9NbSjdSdMfGstkolljx7f6OZcv+aQym1X+8dyD6dT8ipbvRfbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VxO72ksG; arc=fail smtp.client-ip=40.107.92.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEnkLrL0W4ZQpMwrrZ1202vwALk3ADb+5N9OzkBvSLp3ZBFhGvyIiKbSvlVYR+W15yVF8ReIRj+p65iLYjlhBCM4uVOhaJihBNNlBc0LpEqXnESyDFM6AxSBH3WWYB9QW+xLhWuFIfkbKpVbl8L6zqRKcntebo8OTagpVoFxzG0DVLrHdXAX1X5ThpnFbJryTeraOis/3bV0qTQ8vyQ8ABqT/MICQtCxIO72TKIg373fuoXQlENP6Xbgm4AGGVT3f26yRCmjR9UwkBT680Zd5AlkfnhZ0svY5s3rXsFDzjR2ALiH4MdZhvgcpvXcPhm0tTcYxPe7wDiACYgFcyutHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/1i1D71+QW3wXnzlxEgi0qBWvlZaqrZR/7tsBQ6nkQ=;
 b=iXO6fS3njF9sOFGrTKtOIEclGvnhxRJGhbp9quL1vXJ+zbYO955xSF78OyaTluyXaH5roMArBvh5L+i+AP6CHXhI3NwZ7sX1yaHvH+y0n+36ot1YhWruPEdn/l8Nu4/HGco9yok6IPkZwT6jlBmmsDkTzGZxbjMQFoHTvfReWoonEgNXlxs0r8PYHnF3LZ4Ey9Wgls6TJ/wxXRcVPE2BC7lyZg7+Ik7xZlnFB0NimBjX0SYAmyzKlZ4l5s5WErXD/ceeOxkZCHdvdkP/BaBLjAMP/MOWEiF18OE2yLTPAFZrFKpz/L72N3+xurYPQIqduIDA+wZBU2akf3dgDDj1tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/1i1D71+QW3wXnzlxEgi0qBWvlZaqrZR/7tsBQ6nkQ=;
 b=VxO72ksGHtLVup59wWQH0KUWnvu9OC+4itMgZZFDLGzxEhHfzP5ZluGnBVt583jqSyWQ2RLYP8vOOj0O+MwgffbyLqmaeOePEDhpUDM8sOkDG5ghqx3y9VtGWM4fwrcFjzbTV1gaKdo7uWz+fM6EsNscTBwlPX80gAoJqqZKvrv3mIQqKbapldZ00SmT63hxTNwTe2SKD+y6n25Pxfpxxi8J6Kh9ZLRSioXdbIhs7nn9VKLt00ayJa9ZN++HDE972/MDVDwfQW5vy1zBNcIG2UwY2xA4MRJ+E/cufrnCD8O9Q/fgcH4SYAKImF9znjF/G/EoxMWvgAj34VHQcQ3svQ==
Received: from SA9PR13CA0087.namprd13.prod.outlook.com (2603:10b6:806:23::32)
 by BL1PR12MB5706.namprd12.prod.outlook.com (2603:10b6:208:385::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 09:48:00 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:23:cafe::ea) by SA9PR13CA0087.outlook.office365.com
 (2603:10b6:806:23::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Thu, 17 Oct 2024 09:47:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 09:47:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 02:47:47 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 02:47:42 -0700
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
Subject: [PATCH net-next v2 09/10] selftests: mlxsw: qos_max_descriptors: Use defer for test cleanup
Date: Thu, 17 Oct 2024 11:45:51 +0200
Message-ID: <0386ddc48de2fb35608e4976262856a33d63c681.1729157566.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|BL1PR12MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: a3041ac4-83d2-4641-bd6e-08dcee90c936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3kmDgyblQeXL1HVfNkP69+U+qM2a4p5dVfT7cHsCib7DR7Ou3Bc5t6B+hRC9?=
 =?us-ascii?Q?XS2rbBQaKHbW5jbf5de+O/WSqXICW/a5H3JHXuGhizo55ja9ecz9RHQ213rL?=
 =?us-ascii?Q?hCvZTN1OGYyLlf0JAFjpjByw4dUHckoC1Rv0zv06NmQVOMnHsZjoYnE91DLa?=
 =?us-ascii?Q?RUDx9CutRau89oUx+yZbIEhyOtmJ69i8MO0snFlvhuUtF2P+Ui0Y9JbTe0t0?=
 =?us-ascii?Q?xHr0FyPdcB38Dn1W2MExXlp1ndy6ESD68CtpXQS0Bj0t47zyQ83BpM05umCl?=
 =?us-ascii?Q?aPGF1nN2nYT6ObaRjMXohUAgYR7a7AOzYt82nBSUYPpai9RkkZghc44Z8aMk?=
 =?us-ascii?Q?1d9SsY6/VkOVB87m/8Yejts1O+eBMR2rmDyiwQusYIn1wmvqbcjpFbLSYOOC?=
 =?us-ascii?Q?9KNipPJh3CaAuDgZ8tAYwFpg0AsU24YQj6Ko8T1/caNdR4Tt9VrTQ3qwW3BV?=
 =?us-ascii?Q?Zpvjpjthkm3QENDXuYqhjE6a90/NzawJmP3/vws+pAKcuYF3eazhEAvCtjxu?=
 =?us-ascii?Q?Adi72CIg8dUpTW9zPAigTm9UivCHDwVQEemWnAjffAdP/W3rO/fZHMjJLfEZ?=
 =?us-ascii?Q?zZfvRxZZMUa7QRs6/IVbwCs+lrjUI9ItLjnjhLI8rXzGLIxud5wY36QGjQDx?=
 =?us-ascii?Q?EgfgXcMIzZwj5ABoL/xEjiHJaQvZSAsNpyXQy4jrRGlbd91ja3ewlLgHPhw5?=
 =?us-ascii?Q?SQMkqn4XrWLhCnJ3Nj9EBYgWKaO/oIhtZQzUW7hMKPpHl//fqdTKFJjAJXda?=
 =?us-ascii?Q?bNIfywvuE8CKhefyzx3ZsOlzwcqMoVom8N7sLHorN+0D+HtABxdZ+j7Ys1yf?=
 =?us-ascii?Q?ODSGHd+5RagILWQtAAPZEirpR1eNjKHOldLFuu6ZehlSFfy5NYkmHKvnUXMA?=
 =?us-ascii?Q?/yR7w6mlaBbnfCYtVQVQEGOLxS0PGnLHhzebuhE9y5fKf79FqPOezSP0Qre3?=
 =?us-ascii?Q?+2yZXV2L9rFHDpcIWHphYhwcXRaMha4UHbXw78ObkNnZ6/9Fet6LBBen5ycW?=
 =?us-ascii?Q?OOB3OlrpdSqIQH0h76KtJH2ho+Thj5AVCeVOuOB17XIvaguXWrLB4QTpdFl/?=
 =?us-ascii?Q?T0qf8uxDi6pGUnB8bjxROZRZUDLzHu9wIZSvVQCumf4M8sIf5Tg+R7HCTBkm?=
 =?us-ascii?Q?gkp2JJ/pC1ew8ZBe3Ou3OANPKUqI254g8H4tJQCwkjriqAIdobH5P4DzvPbq?=
 =?us-ascii?Q?Nb07LRgqFgdF5XKXNN25Z5TTycvGa8FfaGPuIODYaCeZqosoZ3vGH0HgAsme?=
 =?us-ascii?Q?diBaf80JF2Z9xfjGfWGBO0bde+2HoBO4Vw1/XqZpfBu8JjI+ZL1FA6AAbavZ?=
 =?us-ascii?Q?JYJ5FnHm3omNe/FuAyTfBveKD1a74WOt6XwYWo4qazh9BRPhDb/yC9iZwF1c?=
 =?us-ascii?Q?WjJCWEazKjhCdsaZ18x/izQL9F9cBmnzg+cjhprOf0rGT6rJrg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 09:47:59.6870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3041ac4-83d2-4641-bd6e-08dcee90c936
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5706

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


