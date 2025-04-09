Return-Path: <linux-kselftest+bounces-30423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF82DA8286B
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 16:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 657E04A379A
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 14:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F4926657F;
	Wed,  9 Apr 2025 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GlA1nyz3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373D53595C;
	Wed,  9 Apr 2025 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209745; cv=fail; b=n7lz5TTpF+fjOJwIbJzrlmJHs7qcaF8rBKS4IZuaWw+b4c6xstvFYXsy7wEw+MuAyb8u2Kk7yCjlaXGtacbAAlud9s0ZNKUoerjPItrAqofjkMv14Ntq9e+n5PHeg5gVeC1Ola/HmdD+X51WIjHFLl7N+mGInCej63DtaNS4mDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209745; c=relaxed/simple;
	bh=PxpHMv3OwwafxhfofSf3Tq51XIvlMrBU5421PLZqqpk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fpmueRmE0BX/0wU5u68Cr+qrH7i5zaamMUvx9GGWY+H83p3j0Ft5jxWMo52LUsH8b5d2vThMvD/jAKUU4ImtURTyvzuAK7oH94XWHzeO3tVKELlGlfNEsiUoP8qMTWx8PJnrmTSwf3SCqt/ZSH+qIjlfN8BUVyjBiyqQuFbyu+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GlA1nyz3; arc=fail smtp.client-ip=40.107.101.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KLRF4USP5QSnId80QHXgkxHElOCBkmwP44P+JgBcVO821TkZxRlCDDsGiDW1pcUjJi36Q62hdXwVA7TuxTuDLibxOiTOUuJOnHMCHKVQElyb8PDJRmM/bXb5kgZsVWLvvcOXni7YG4t+7tYVzlp+XlBE44QnohkJSTW5fJon/IppI69ZdraU+7099ndD2uN5xxRUinebR4wmYnXquO8UZESaQ26BNGaAJZyDDFlKfqhSZWCiWi2TG1yX1ld0f/btW9Y+KHGEAZOR1X8Z79eE5/EiEvUsfQHonqXvTu6q3tGGL45MarHYdsEocoHvraAa/p3Qf6P0V1QKpMNOmOQ95g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmaKZ2a1c8ZWuZwVRSCAmwfcPxFr+O+1DjrW1I+K6R0=;
 b=ogYJhVWDDEsa83+ya13/7cddrTj0PJDG2NVNQ0Qx2h+Qsnmq/b6REH8XgucJRAqm4oa6sz9GYsqvES7Pzik+qulRjmguugMpQmW6y0LuAPDQ3nQefCwWgNPv6QowHOKDjYdBLecyc2pg7jut9DPOj+2uiRI9T4+XUdq2YJMIyexP1dWcn34nks7d3Ap+hu7RiVouBId/gnPNadu4DRIF0vrObiTUNvR/sMz4Ev8JavLo0SJfUR2MuH4rKoYORZK4ySboK2FCx1CTnaXQx6xBm8hcZAx46xZ6fGuZaXlqth7Krz9usTs5aM32rDquZcb9n1dQHQWOav03ZNPto7j/IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmaKZ2a1c8ZWuZwVRSCAmwfcPxFr+O+1DjrW1I+K6R0=;
 b=GlA1nyz3PSgwq/vxplGCa/ekU81XOYatq/rX4jlC9kNs6LaxU+nnQQj3aflYkGj+r2Ni4ArUANw/2IonSZt6uZxEeT038QQcWut/iZNQUmsdro9iEX5AwQYQrYuFim68nOQQyrKw3x04QsJcEd0pKMq5DwlOPRtQUpOAPzbQQVe0MPrax5yH8rhoXskJM1Ca1xjiQHCqWgAUXAdnIouflZxbfF3xKDBqBHQ3TUkGmNy3Zcry1EDtxI8ttVvsJSybIT9bDTJS656Pl5CrSy9mkwEP8Y4/cGqqXdGoH4fJRKZ0gkG4Zq3hQGe0Ga9AImCpjDkSlxS5aMZwZD4aZBw0EA==
Received: from SN7PR04CA0067.namprd04.prod.outlook.com (2603:10b6:806:121::12)
 by SA3PR12MB7921.namprd12.prod.outlook.com (2603:10b6:806:320::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 14:42:19 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:806:121:cafe::1b) by SN7PR04CA0067.outlook.office365.com
 (2603:10b6:806:121::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.35 via Frontend Transport; Wed,
 9 Apr 2025 14:42:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Wed, 9 Apr 2025 14:42:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Apr 2025
 07:41:58 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 07:41:52 -0700
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
Subject: [PATCH net-next v2 1/6] net/mlx5: Avoid using xso.real_dev unnecessarily
Date: Wed, 9 Apr 2025 17:41:28 +0300
Message-ID: <20250409144133.2833606-2-cratiu@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250409144133.2833606-1-cratiu@nvidia.com>
References: <20250409144133.2833606-1-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|SA3PR12MB7921:EE_
X-MS-Office365-Filtering-Correlation-Id: 956ecca4-4193-4435-65ca-08dd7774bb40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?94+xlnRrLbIUMHnVOP+VSQvv7BtY2qdJmPJEh9Brs1E6lHCkEtLuIoAK1zld?=
 =?us-ascii?Q?Nm7TWEVGdfpMWOV8qK66SxCxkd8BhzHpixlvt+OdyetCben7wurSIQuVGMar?=
 =?us-ascii?Q?LlpdAZurdMnn31nzWHwudJPNGBsQ47bKvrmP4+Ify6NC0ff/Xi0h2Ig1S/CZ?=
 =?us-ascii?Q?CHI1pIKRWTAn3mJgXDEJl9CPLIQl4qYJqS0Aa/wDP9AcG+KS2wUSCZ0eG/l+?=
 =?us-ascii?Q?O4X2C8rfDsj7CjcREK37DKkuAmJ24erwSD6/se1aet5GdCAycagJFPHkW1DR?=
 =?us-ascii?Q?stvW+RI7Op8J7/udm9qvwRCixbvXpS6vsFVGaVEdvgpRpCuKGOQStSfaqdWs?=
 =?us-ascii?Q?enfGBG1QFZoP0Nz5IHEPLcZBRvUeloaki/f1QjjYUEajULD0jvHYocMWk+Rt?=
 =?us-ascii?Q?zTQYehkv43AmHsto8YRdMewzmcaiFyZEoWraW0d4CEkHUtVdZP6U2VXyQ7YS?=
 =?us-ascii?Q?XsViLYJrpxgP8B8Xlei6kQldYnGRpUdzczxStQGD7YZ7aJbXJQR9lzFN3vVA?=
 =?us-ascii?Q?bnN7ukaqqoo4zY5H04Md+nOJdBSbL/mZlA7xSFagDebsBjV7OElCKDOIXBQu?=
 =?us-ascii?Q?TarujmkxPnpEiUzlhjK12OMZ0aHFmiM86r0j+suZ1atwsPJqc+oOZt+TMQud?=
 =?us-ascii?Q?SHqhC/JWdE6r57ikg98WZv3Zg4qPE71YmE+TmRs8KUNNsecAVdB35SAG4B9x?=
 =?us-ascii?Q?pCIPSyD1+/RVGKx2ZbAq2jIg2e4LNmZhRmQ/v/IkQtEGDky9O8ksqyt2eEII?=
 =?us-ascii?Q?Pu3tXCGdl1MWHiE8+TsDoyHhQ467HshVMAxnEJQY/CfktdHJtTWS3UY3nxwv?=
 =?us-ascii?Q?ClUaZsk5uAHbmkaIpwYJ7IwkVkGUaloi1ieqgOfEA8TzUvgXna39e4ipjh6+?=
 =?us-ascii?Q?dVQxCV87n8u1EQ5dYg50UwbgUzvZu0wXw5vyqYe7LJpLkgVklsxTbt/mVhp4?=
 =?us-ascii?Q?OcY5opjgUwjeDGog0qiYAz2Sg0oN4oKbcIXo6G536J3r6Wzv/KBUUzLrnxuG?=
 =?us-ascii?Q?r+xxGoY6f6JgoEGjXBEaCIfbsSRjx8FAeQH6MJFEwEGWEnjN2Ud/4Fu+eorU?=
 =?us-ascii?Q?zJ5zAKkDebAg2tRbneXy/9c779LJX93ydQhWE247ONYYodGGxUEkyKCn7xl5?=
 =?us-ascii?Q?C5D5ytZajBekDhjtXKNu1mMN5rQkAE2GvGG+5PwUonf1JeqaUdoa2vNYXuXM?=
 =?us-ascii?Q?y6DGCTYJjACTby66VsTAIGRhj3cIE/1EMJUympQHVUHGgMxLl8aHoQig5w+q?=
 =?us-ascii?Q?MjLAUpLVoiVOcp5JXue3ezlHMRvJHaGKEcV6wWOWKjICiDGPHBeNpQb/H2Pj?=
 =?us-ascii?Q?4mO7Tb9cknUnGd5cLy1C/oc0L9JAH3ZDFvJKrwGnT+UOrfuD4cN9MTo4aGzX?=
 =?us-ascii?Q?zTEMUUhUYrXqRmEsiMkh1aI9v6Q84T9cN/Wc6oVSiiljcJD3mHxjmTEE96Bs?=
 =?us-ascii?Q?s9zKk3rTLTFrrOOkTdf3FTXVAsad8tsczYhb6fr4WZMzEjDGDo99xYDzx0s6?=
 =?us-ascii?Q?5exT9GgzOojbZGWINRo5kQpfja74IHYNmypB?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 14:42:19.6543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 956ecca4-4193-4435-65ca-08dd7774bb40
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7921

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


