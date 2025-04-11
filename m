Return-Path: <linux-kselftest+bounces-30524-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3642A855D9
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5C64A3DAC
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 07:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580DB2857D8;
	Fri, 11 Apr 2025 07:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U9kp9NxF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8809127CB35;
	Fri, 11 Apr 2025 07:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744357844; cv=fail; b=qQnHqjGPUDh6gFGDr9jJkp/M2xeWhpBjr5ju54RaOEiMFA6dPvNOJ/KQuTu/zKn0SLSOLfwgz30LasrQ+WJRIQI6g5xqEBJhOZ11KspcUxFQ4CB3HMYcaFuF8SbXgUOymyN8u3ahSTlxRLTSnTwylw5vhdkYweEtp1beiqnB7rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744357844; c=relaxed/simple;
	bh=PxpHMv3OwwafxhfofSf3Tq51XIvlMrBU5421PLZqqpk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ys4reChtudiOmrxC4/+v4wkU8VcET0o4iGHuN1stUeY0ys2yFWQ/ZVsOJzFe5T/E+cgXUWYy9F8mUih8bPlel93MfbB6knSBb/bv7RuoIVldWjbHGE77kSpVI5LCsXqlLYKdMJDUXmHuUXf+syK9inclmMwOXhrwrdKpkqmizrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U9kp9NxF; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gU32upvu3w/HcFkzcsN9AtsscGE9q/bPbyoH3X3Pr/bAOsDp0uXbaa6fFGDz1wLLQivtLfJ4ax5E609vK/G+ZGgR+WePgcTuhnvFp6Z3pewK383vISyFd8dLL/BtbwwlU2gmu4TIItPl4ohrf1aCJx2q0K5++5wXX3TCcQU2wPhsEg6C05NcR+u0X2+k1SBScxfuLXWY5vWYAnxLppWc+tQhY2X7w24TjAFXiDGVDF3g0OD5YsSu4V4+PVFzva7dVPsDYsvX4ze0+4LTB3oWDJYSq0q7JdXwL1Hud1LhJGjFfdXKCuHrMmWcb9kO257wcGCn+Ia447wvsdKg3aRU6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmaKZ2a1c8ZWuZwVRSCAmwfcPxFr+O+1DjrW1I+K6R0=;
 b=yEGYNnZkV9yf7dFZFYq3DXcj5sdRADS+z5loNmzt5maULyJLJR3Y7FhUph/rknYKeiuC7VY72jjja0bq20pf9PbM1uDKcJeUBSrACMSttZ7QIARv4uYZMMZfOAKuHWJGGQG4OM+uXV471+pvIlGUufwOktiHlygte/arE5XiFwlIVi14IsH63Mw5Vyi0PcrqoJ8hUdr4l8Qp6lst69vACa5xgOhtuaP/cMBCFuB2NW8AFloxdHRIT2wYRCj4HbsbL34+X0A6i0Cim2Z6D5MZhtxdYgWsngt5NhwoCjXFpg9eZWchJ67xoi889b+kv9EGYHmYhuuMs099dZJCkZaUFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmaKZ2a1c8ZWuZwVRSCAmwfcPxFr+O+1DjrW1I+K6R0=;
 b=U9kp9NxFGpAwuke7FHP4RNFdWW7A4Rjo3d0l4hAyr6vPyvygA+BMxTAfan3cb+zyB2OkLG7+U3mTx8VwMCd5DDHS9ki12MUu65PURYsVLYxFj/xhywh4fHezJY4sk5ARYUqQ+oRZomENHk2UJtv7iC9gld7P8DBPBgLpvZ4J0/PxNFJbGYPY+q+OOdL8CetlUEfJAnQn+dywiqpcfvmE24EHTNbBo08VEHBomv0NDw52daOq32trzj9yj2oAcA+h7sTiDS1zOMLWnBGiWCwrSMCZ4l+/Wi1GhEZ5d+SmIP7SGFS7J5/oLkpaneZMvO2YSVRYf8UKOm0vcmuyDRCV0Q==
Received: from CH2PR04CA0028.namprd04.prod.outlook.com (2603:10b6:610:52::38)
 by DS0PR12MB7746.namprd12.prod.outlook.com (2603:10b6:8:135::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 07:50:36 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::86) by CH2PR04CA0028.outlook.office365.com
 (2603:10b6:610:52::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 07:50:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 07:50:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 11 Apr
 2025 00:50:22 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 11 Apr 2025 00:50:15 -0700
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
Subject: [PATCH net-next v3 1/6] net/mlx5: Avoid using xso.real_dev unnecessarily
Date: Fri, 11 Apr 2025 10:49:53 +0300
Message-ID: <20250411074958.2858496-2-cratiu@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250411074958.2858496-1-cratiu@nvidia.com>
References: <20250411074958.2858496-1-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|DS0PR12MB7746:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a334409-c87c-48f6-8674-08dd78cd8b9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?37ZPxVWqepluddvSedcJpCxnOJk/AlMEaciGPPi5n5/gAbv4HjlNjIDGT04v?=
 =?us-ascii?Q?qhDoqD4zRmj5H6WVrEHKxkOicoSNo6DII6pySIkLtP4y9+JtmqbTEZz6Jt/9?=
 =?us-ascii?Q?3qXRVbrJNykPn+pi0XZvocjREEt2Yz81/YC8HZ2WLy1DEaSM7uDHRaoq0geB?=
 =?us-ascii?Q?mltBlYVoHALepZ3CT6h398WoMXa9HNJLGSY+2UfYFG4iWyeWGbtxfDqtHrZz?=
 =?us-ascii?Q?1BPVaV9PaXPKCZfqlG6Lhpz0dX7WYpEOQljrfQq9LBXlRsvzUHOnWTXEX0B5?=
 =?us-ascii?Q?8FF/PUafNoCgG4dUBD+6/5wyvZ9dLGyPhcXyAPdCf355mRo6/ea7ei3hBBcz?=
 =?us-ascii?Q?ayX3zexZTa3nbaNr5W6Zk4sUf9jYfry/Xqi9IbDRlTCGwWopkyfCOyDBxbA5?=
 =?us-ascii?Q?+EUIQiK3CiREtIa9c+FYHx1t22CwWXWemQF9QEkVfQBCKKYMlJOywc42lqCP?=
 =?us-ascii?Q?6XsoCheVcI1r8Y7ayZ8S+JtuTbx67ag9nYUgH9mm6NZlC9AcgCcyX+ZYhg07?=
 =?us-ascii?Q?U37eRAxbB+DTxQSY/l0wVzDC7UHmw0Gmv7zG4ir8BxBXlo8YJqfR3ZzJ80yR?=
 =?us-ascii?Q?HOTE+it0jz3XeSo++ppbM2wVD8EW3K4tdmv3szziT3kc0ISGDzZ0GjCpKigx?=
 =?us-ascii?Q?9LzuUi++5gZLCDPV15h/6kxnTdw8Lruu2e5U6Rmg5n1/Dck75/ONIqYc3JUQ?=
 =?us-ascii?Q?gY1YcNxgmU3mQFnaYPoCgaExbNTKR6sGKfx8dnwzJDu8tEFMdRoQOqsFKN8V?=
 =?us-ascii?Q?Rj6T/en7gsQYvfCVIVznjdGyDIgWTlSpucrGfkZpr/9cBDKmfwj5a5JjkViC?=
 =?us-ascii?Q?tmKcVGVcOjYM1QJOmLNIADTBqhK9J48frXVl4XJ5q875ICOxnxMFnhLcdSQt?=
 =?us-ascii?Q?im8Y+YqbFwsKtf3y6tOX4rWbBAZOqezrMzB5J7NRRmDn/diMPOPzfpJiVlzs?=
 =?us-ascii?Q?ijCJay4vQ0yg0+I9mlNxRMHiHurLkHRuxhmK5wgE66MdP7EF73vhBIyUSaaf?=
 =?us-ascii?Q?RaQDOYsziV3kpQFSCOL4iDFUUmDAROE6ERFFCp4kgI34OdXhT5bORTn5dJBr?=
 =?us-ascii?Q?pFIOrx+dLxneOFAkpZWLAZy6gLEXXx10mtl31bEQGVFZ3HSPxjSfLYYFz9x6?=
 =?us-ascii?Q?QFiMG6K03GtZfhygwNJwJSlI87G3Whxh8RkTIcVtVJ/DD9J75Lzpbu/alnRj?=
 =?us-ascii?Q?84FY7K7bJQqVg6DCi+qY0HtfszOd8NSQJD7vP3BWUSRxekwP6DP4G+9UY0Ur?=
 =?us-ascii?Q?NVD9vEIoJUACpLVIYbX6qLzZr4OnAf68FqHDNNUzkVHqY6AYnmpe+8tSWbga?=
 =?us-ascii?Q?oMYlwIH6Zxk8KEFjTYo5G4huRrnE94xhT804lMBBQFlTrsnyJxv3TgaJCLx9?=
 =?us-ascii?Q?yO7GucHy4GRe9WFLuHCzqRw5pz44R0fTLPjp6j5JtyvRS8brI0H8hV4VX+A1?=
 =?us-ascii?Q?tg7X5hhVhu5+CX2oI9E9GugLDQPdjNQqiC52sUQGayZT/klsFigwtbyD+5ai?=
 =?us-ascii?Q?NU0nY7d8wC4kmGyfsBopYbMGisozTGiBhx1U?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 07:50:36.0745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a334409-c87c-48f6-8674-08dd78cd8b9d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7746

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


