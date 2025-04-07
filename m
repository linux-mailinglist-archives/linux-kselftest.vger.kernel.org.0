Return-Path: <linux-kselftest+bounces-30246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 769D0A7DF7A
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 15:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39E3C7A20D1
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 13:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082E1186E2D;
	Mon,  7 Apr 2025 13:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jKASQtKr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964A2146593;
	Mon,  7 Apr 2025 13:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744032998; cv=fail; b=d4gqX2i++5RbxM/mfKqqVPBUhX7sPS8cu8zZmW1DXS+E2KgaKK+R2legUjR0nnv4YuAwhvAWAyPQJxCXSTRDwCnCS02vsb3Jar55rmWUN3rZJboAFhuDvebDbqKtRzqhhV3Cv1oJjMoIUunFNrxSxDiQYMxU4pQF97z36aQ+huQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744032998; c=relaxed/simple;
	bh=PxpHMv3OwwafxhfofSf3Tq51XIvlMrBU5421PLZqqpk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XEp+P1R5Lmu1Z1VaDZ2yM6gpVFY9iRVWM4vSp4eJNvdTBIj4SQJavHRL833wfYiveRTFRj4SAg5I85u8XbY3JHcraZjq5IZNb/uGLBtrFUizwu77ls/QaBZW2jgZibPLR8GIZ3N4dMr8pB9BX7IlvQq2mpQv6z/xsrcQIzk9fMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jKASQtKr; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3pnV5Huir40AwgkgSkKGRcH8qArPCgmN3k1eR9ri7DEZsi3bD83jPU47/1UMkVJM8dtO+2sxf8ACfcUHm8rk/gkIx3hJSXXrGj/t6HoixOmDM5zETGphkrQm3BrDJ/dxNiVHae+JV9tQuUtyMfqGhZmo6HG2H7LWw2KdVtTAGJuI53a+QHgBnU7LN7sfEQxev6MhD50yB35Vwln09b6Tp2UGBml1xtdKruLl/6ZjA97cXEOO5Fhfgol3vvWIV0CA8viF41HmsWgaak/kueFwQucnujKQuPmUMD7Y2q389GYOA2XYm40d+ecuKbtd2wdOgUDDY3s7xccvAGPHCuAoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmaKZ2a1c8ZWuZwVRSCAmwfcPxFr+O+1DjrW1I+K6R0=;
 b=yYrgYLxVmJlHwRwH1B6KFSt+lhuL1kc0Xke5hOCJV9Wksf6aUpkCtiJAIzkL7882ntN2hqJvZ0oBsSV2HbExDnkYJR92yXzzfVk0FFNMPpHLa55FIGUTOmoaqwIVv4dPdo6hY4jO/BfQ5O61PXfdZ8pLzCY2S75MSTDCtk4+QUo8fyzEO0rU62cdQqYX/ZFs2duxJNDZeMgXbbe1tXkkUOw1k+6awvLEGQc9+euJpjtIUIag6uE3SP0fENcQpQjuu9l+enQjNOPpOO0a4SiOkiQkYQQbywI93nIsApp4EkZI0MP33pSjBkDcOs606Rr1P1G39sJxn93LrFbsrwNngg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmaKZ2a1c8ZWuZwVRSCAmwfcPxFr+O+1DjrW1I+K6R0=;
 b=jKASQtKrSr9iOQXcyGVGilLAnT3K7uSrUH3n0fVGncWCj5zkVBrCc1YiuvcUXeiPoCSuG7qekElY3aBgJZeuRIwRrXkdmPHlZSuSl3lH4HHWX1lVkbGyJ7qByJiTvdiHKsszl9GsusZB6bW/Ct9jG8KplOhuzPEtD4X59HCtjiY+KOEzYuRLFNeYssMjpMLm22S8qWR8GpRdPPqY1MHrjHKgL470BbaQX4KPseQnvFN4AjVxDPxu8PpO9dY/9deehSbvbcloGsfTqpbZJwKeyL8VTO4boC3e/qLpkkJRI1Bpm8MBxTFUZwyFMVoXXHLgEBXuMjNW2vnovv1H2OeicQ==
Received: from BY5PR17CA0006.namprd17.prod.outlook.com (2603:10b6:a03:1b8::19)
 by DS7PR12MB8231.namprd12.prod.outlook.com (2603:10b6:8:db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.46; Mon, 7 Apr
 2025 13:36:31 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::5b) by BY5PR17CA0006.outlook.office365.com
 (2603:10b6:a03:1b8::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.33 via Frontend Transport; Mon,
 7 Apr 2025 13:36:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Mon, 7 Apr 2025 13:36:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Apr 2025
 06:36:14 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 7 Apr 2025 06:36:07 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>, <cratiu@nvidia.com>
CC: Hangbin Liu <liuhangbin@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Nikolay Aleksandrov
	<razor@blackwall.org>, Simon Horman <horms@kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, Ayush Sawal
	<ayush.sawal@chelsio.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Sunil Goutham
	<sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, Subbaraya
 Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, Bharat
 Bhushan <bbhushan2@marvell.com>, Louis Peens <louis.peens@corigine.com>,
	"Leon Romanovsky" <leonro@nvidia.com>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 1/6] net/mlx5: Avoid using xso.real_dev unnecessarily
Date: Mon, 7 Apr 2025 16:35:37 +0300
Message-ID: <20250407133542.2668491-2-cratiu@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250407133542.2668491-1-cratiu@nvidia.com>
References: <20250407133542.2668491-1-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|DS7PR12MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: edab8773-f0c3-4f2d-f27a-08dd75d934c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hea+SlU6BY7r5UEUFbxC/xjCsAYodA0KKSMLMId1ZnKzzCKlcpQCLDRcRatA?=
 =?us-ascii?Q?KPmx4aqcTu72Mdax45klXTcgkpvBNMY1ARHW6qFkzdEs38CT9wuQEQamVC94?=
 =?us-ascii?Q?3Dc4Fd3FJpZl1ljiLNML/LbFlr9ZNUMbo3vdEAR78LStUgNAi7so2HfxTVnd?=
 =?us-ascii?Q?YlJtUn6mcKVxVKqqDncFbFakcN1hdcvw2mwe9I9n1YenHFSxNQrC0aikb1bl?=
 =?us-ascii?Q?BaJVLHGsAqJMNs0V2mQK29mFSU11NUoFrRqAPGicHjZfLXnMVtN8e21XIHGi?=
 =?us-ascii?Q?gV9jB4Tt0iqx/XGFcz0UBF7xE/0zdDuNE6UfL+CEsbQZnHy720FbQO7NpZNW?=
 =?us-ascii?Q?Tf7K61Bh734J2rWTbeqpP83ORSFB/mV9Zwq8l07V8E8i45vmz8wfYFKBnf4G?=
 =?us-ascii?Q?+ui59/NycRguax9bwjhcNpcdk2ZsCl7C/cPYNkOnf+t+l+0ydSxTmTC3kqpX?=
 =?us-ascii?Q?nGeYHlm/jzXVxo6GEL7KMYxJ8H/ZqpNXCqJsHyCExU2/aRwddi0HUBO+G7jh?=
 =?us-ascii?Q?+ELGQYn2QpmwvkJli2LO2O4V1wC+mCObcfyXpoGAspxqGfXMrIVIShJS0xZ7?=
 =?us-ascii?Q?pSM/C/+ldTNHKuDJ1l4CCtMP/Q5ATzEJVSlKHiWdsL3uoEkO9D0KvPRIgYXG?=
 =?us-ascii?Q?WPIlVS4ZgTT1AfcGxBlFpwXZg06d37sCKiTjNuiJpYWkqtK/4rnyy8/0miPU?=
 =?us-ascii?Q?NvJiPn3zF37C6X83I0goj6qUJQU+Ys5MNAQFfMl6tqzVTqvv6UAfX4eYko8L?=
 =?us-ascii?Q?X+eWwNFMZLv7vf8iTo2YPAiy1cU6gFDRRQWEY/WYCf6uXCnvs4ppwRazH4s+?=
 =?us-ascii?Q?a4dBQ7OozuJ5Rjcq/fCU5C5HVkuK8peHIX/FnaDa+J6gRSsj8Lj9Ft9fWqGv?=
 =?us-ascii?Q?fhoDtYKr6b+FeQg/fT1bEfd7zpE7/6YiGvMMB77Frj26GoJhAcLnihjUcuGc?=
 =?us-ascii?Q?L6GoQkDgyuPNDXfh6L8QnzvZepiw2SjIfU4W2S4VXBiFmHb9jhzhkdk8bxZ7?=
 =?us-ascii?Q?oDlCgZDAmFQx2FvpculyHPGywURKKraQ/PMYyaxhIRgoytJpoat7MwsIhI1K?=
 =?us-ascii?Q?ZPImuV1reUspwJeuHvWbbopiYV7N7p9WEEpidoKOv73QrMNKAiZGwLXcfwaM?=
 =?us-ascii?Q?UCMrSDCLRHPAYarGvYvM97Xtd/dXg/tuCU2w5oRkpABvTBYNrQWtUBf8CX7c?=
 =?us-ascii?Q?DLtBVVvAP2kARDkdaOVdrqGQQItvp2wsmbO1VIoh2uArqI9HhAuFgu9033Oq?=
 =?us-ascii?Q?l93mE5N7xiJH3zGpG1OYnP+zCWTzFNmWHUJxGczGZSUrnSL/UkApDyI9a714?=
 =?us-ascii?Q?MOLTlZGlwRARoNYdS/CTkWGHod6jwW6FcnQQB1pVXrSdq9O0RUTdUjPlGTOy?=
 =?us-ascii?Q?6aa9QjdFV1Zjh8uVYomZ6aY2MuX1ghlnbj/7b81NtmedVD/AvYbNUdOPrzFG?=
 =?us-ascii?Q?Agn0NhfXy+o8bTsx7LmWA52Ek1K9JyZjqrEtdj+3Ji/g4sYf020NBrUZ55j7?=
 =?us-ascii?Q?Ku6+zwo01TwjnMw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 13:36:30.8918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edab8773-f0c3-4f2d-f27a-08dd75d934c9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8231

xso.real_dev is the active device of an offloaded xfrm state and is
managed by bonding. As such, it's subject to change when states are
migrated to a new device. Using it in places other than
offloading/unoffloading the states is risky.

This commit saves the device into the driver-specific struct
mlx5e_ipsec_sa_entry and switches mlx5e_ipsec_init_macs() and
mlx5e_ipsec_netevent_event() to make use of it.

Additionally, mlx5e_xfrm_update_stats() used xso.real_dev to validate
that correct net locks are held. But in a bonding config, the net of the
master device is the same as the underlying devices, and the net is
already a local var, so use that instead.

The only remaining references to xso.real_dev are now in the
.xdo_dev_state_add() / .xdo_dev_state_delete() path.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c | 16 +++++-----------
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.h |  1 +
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 2dd842aac6fc..626e525c0f0d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -259,8 +259,7 @@ static void mlx5e_ipsec_init_macs(struct mlx5e_ipsec_sa_entry *sa_entry,
 				  struct mlx5_accel_esp_xfrm_attrs *attrs)
 {
 	struct mlx5_core_dev *mdev = mlx5e_ipsec_sa2dev(sa_entry);
-	struct xfrm_state *x = sa_entry->x;
-	struct net_device *netdev;
+	struct net_device *netdev = sa_entry->dev;
 	struct neighbour *n;
 	u8 addr[ETH_ALEN];
 	const void *pkey;
@@ -270,8 +269,6 @@ static void mlx5e_ipsec_init_macs(struct mlx5e_ipsec_sa_entry *sa_entry,
 	    attrs->type != XFRM_DEV_OFFLOAD_PACKET)
 		return;
 
-	netdev = x->xso.real_dev;
-
 	mlx5_query_mac_address(mdev, addr);
 	switch (attrs->dir) {
 	case XFRM_DEV_OFFLOAD_IN:
@@ -713,6 +710,7 @@ static int mlx5e_xfrm_add_state(struct xfrm_state *x,
 		return -ENOMEM;
 
 	sa_entry->x = x;
+	sa_entry->dev = netdev;
 	sa_entry->ipsec = ipsec;
 	/* Check if this SA is originated from acquire flow temporary SA */
 	if (x->xso.flags & XFRM_DEV_OFFLOAD_FLAG_ACQ)
@@ -855,8 +853,6 @@ static int mlx5e_ipsec_netevent_event(struct notifier_block *nb,
 	struct mlx5e_ipsec_sa_entry *sa_entry;
 	struct mlx5e_ipsec *ipsec;
 	struct neighbour *n = ptr;
-	struct net_device *netdev;
-	struct xfrm_state *x;
 	unsigned long idx;
 
 	if (event != NETEVENT_NEIGH_UPDATE || !(n->nud_state & NUD_VALID))
@@ -876,11 +872,9 @@ static int mlx5e_ipsec_netevent_event(struct notifier_block *nb,
 				continue;
 		}
 
-		x = sa_entry->x;
-		netdev = x->xso.real_dev;
 		data = sa_entry->work->data;
 
-		neigh_ha_snapshot(data->addr, n, netdev);
+		neigh_ha_snapshot(data->addr, n, sa_entry->dev);
 		queue_work(ipsec->wq, &sa_entry->work->work);
 	}
 
@@ -996,8 +990,8 @@ static void mlx5e_xfrm_update_stats(struct xfrm_state *x)
 	size_t headers;
 
 	lockdep_assert(lockdep_is_held(&x->lock) ||
-		       lockdep_is_held(&dev_net(x->xso.real_dev)->xfrm.xfrm_cfg_mutex) ||
-		       lockdep_is_held(&dev_net(x->xso.real_dev)->xfrm.xfrm_state_lock));
+		       lockdep_is_held(&net->xfrm.xfrm_cfg_mutex) ||
+		       lockdep_is_held(&net->xfrm.xfrm_state_lock));
 
 	if (x->xso.flags & XFRM_DEV_OFFLOAD_FLAG_ACQ)
 		return;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
index a63c2289f8af..ffcd0cdeb775 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
@@ -274,6 +274,7 @@ struct mlx5e_ipsec_limits {
 struct mlx5e_ipsec_sa_entry {
 	struct mlx5e_ipsec_esn_state esn_state;
 	struct xfrm_state *x;
+	struct net_device *dev;
 	struct mlx5e_ipsec *ipsec;
 	struct mlx5_accel_esp_xfrm_attrs attrs;
 	void (*set_iv_op)(struct sk_buff *skb, struct xfrm_state *x,
-- 
2.45.0


