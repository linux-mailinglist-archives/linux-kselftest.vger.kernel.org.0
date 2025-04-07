Return-Path: <linux-kselftest+bounces-30247-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133ECA7DF9B
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 15:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB7B3A9B04
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 13:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E90714375D;
	Mon,  7 Apr 2025 13:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y8oMtg8J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76D83F9D5;
	Mon,  7 Apr 2025 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744033007; cv=fail; b=P6BkUi561Ly4EAmVEUFmuQQvoWnw0aaww5FKAGOm0a8Jj40SZFwm3rxnU4HZiyqUYg2x1ALcW9ta7/V5xp/3NlLo8Xd7yHSd0yI6NhiPrXqL1GvzrvccDfbDEv/+RM0YaYDBSvm3FseOUPOsBc0tW1xeuGRM3bB4raYrVh3lQQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744033007; c=relaxed/simple;
	bh=E7YAMbh4rhcCrP8GqyO5BHfECff1nYTF5Hqcd6c1fFw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcGGBfEucWTtOjnL0tA8FgIcT+jyze2zeyIzhV67OVIhcenHSlD4JFdXMhsrPfV8fsgV6ILJyxoF4hmBg3zAeQXFEu4n2JGwJV9TOfoiRZl8T78J3EnZE+wQ69MmKgSuBnZKVAbzUiB1lOlohTbXQKAGUk55hTqaLNVQqQnjGYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y8oMtg8J; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZmTHPJ/1HEkHgHe02K6Mw0p365GGTE4rGDrRJy5nt+rxLMTsyQdoWLRSA6nkg3NKIiuwnIMBRVgZnepM+Yp2vpwzzK8tmYchsJZAT4Da7sgl/Dr8clHh586lfT/wqP/QhXjSxQ9IJjSyacXgOgDRW/mejI4+lBDLvYYfjp1dBwceQPCNNWL4gwsrCzSYTKHYCjRA89lUb61WFbvLG6ElPl34le/WTqCA8tWIOykKXYoauvBkW3HmqZufOaZpVvG8pAElq8E5NcLxKTIRYPodnQmI/UP2C/8WbLyv8n2dZz2LF2BJelgP+aBTz0OmSr8BL8uRabXt605MQt3CKe3kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JeP0oeFT1V1YZfI0RbwA8wpecEhr06zGkLkr7cOahY8=;
 b=rNlOgb8BnHUtiU2p6s4gyshI1LQqu324I2FZBoLYEGSueUc0ZQOmgnGUFlkEjP9iJPhEIH0Eezji+oJ0HRARMC5gaMbaHNFnuBjdvxIJXIIVeIg3etTrZDgmQ6wyo/gG09G1AOFzypoqwNvcAPEPHpXzP/3+KB6ngwWYq8G+CfpcuVWwOLfoaBwOQuHPEIgjfBQZJ1Z7Wj+vbHlSdMMIimeLRyepX/FLsyv1pDCJLqoIX0aAq1VfD1ruQkwsgtgEtxqH9efx960X1HXNJTQxz118DKZa8sdzJQ8pqn0tHSmOcDgs3sqkF4TPrtyvDOSbURObjNdW5C/iRYPVyab93w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JeP0oeFT1V1YZfI0RbwA8wpecEhr06zGkLkr7cOahY8=;
 b=Y8oMtg8JVPeu5sLv1ROo9VXFM9VRHYmPrQgT9oex+DWvXL3rVlLp0wyOEHACMibghRiUli8MqgQ9DXFcw90OYXlyEdRqM5zV2RyBA3iMGrweo6BU0hSSTzxrLaozq8PoYATVHJ1i8LgLtrw0I0IKsvNDtQADD13v3BNqulv/M3/EwWwTVaOcLrkSexf2UvsEcGUdeb8liJhrGou36HtljE444fE/sBH36uQm30syxyS+MPobIPrO39vAR+qeDVHcwyjzI5F8gKLl2F7snUpvdtV0xP+xsP9rr3PeTeG1isK/oz5HwCkgiNdSazzKuMNmpAecsLZITMHndEvE7pis0w==
Received: from BYAPR03CA0003.namprd03.prod.outlook.com (2603:10b6:a02:a8::16)
 by IA0PR12MB7602.namprd12.prod.outlook.com (2603:10b6:208:43a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Mon, 7 Apr
 2025 13:36:41 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a02:a8:cafe::ce) by BYAPR03CA0003.outlook.office365.com
 (2603:10b6:a02:a8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.33 via Frontend Transport; Mon,
 7 Apr 2025 13:36:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Mon, 7 Apr 2025 13:36:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Apr 2025
 06:36:20 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 7 Apr 2025 06:36:14 -0700
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
Subject: [PATCH net-next 2/6] xfrm: Use xdo.dev instead of xdo.real_dev
Date: Mon, 7 Apr 2025 16:35:38 +0300
Message-ID: <20250407133542.2668491-3-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|IA0PR12MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: 713d755e-f6e9-410e-1e66-08dd75d93a8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MIdOpxvoVuf8zucaapwbDWmBepyN1aaqQPSY+44vezZLFKYOV/VWOCOOwEKQ?=
 =?us-ascii?Q?7N7JaThCPTQB6Fi61TYtnPB1UkjLHqyBdpdz/CBOBwnkPzWB6DphO6GxJP6T?=
 =?us-ascii?Q?Ub1O8Uz9nps/GyUaWZaPQmcUrSQ01UW8Z1mRrttoFfE6evVCiyAXYHm5PiF1?=
 =?us-ascii?Q?PLtnolAWOMNIQdRNEITCCaaLg5IjGA24/PDz6gmd0Icv56ODruFCtHdntyho?=
 =?us-ascii?Q?UzdGiB/i6R1f8tTrHlHHYUFY3l90Mx7o7V3jrToBMcd5TTc0uF9cHkmCKkNx?=
 =?us-ascii?Q?ez/F4Ov2s4gsOeYXsvVauhYVfLxBiyJm/CbQyJiWE4Rx4HenfQaatHgPYOa3?=
 =?us-ascii?Q?SKI0qZds+ZV+RiAu2nKep4USNbn5ItjDkTJPOh0Y5owxSBfkwN0iDLAiTA8Q?=
 =?us-ascii?Q?Fkp5aOOtjawcCsVdsO3eASG/ssa4t1rEXo8+Wsay6BiqKjzWKFRXoPBVk6Q2?=
 =?us-ascii?Q?oNGvuIJMq26XTgn6lOFTb6dpnIvibBLdSTdW4f38zc7Ug1kAoSJt9InamMBn?=
 =?us-ascii?Q?yitkuZyHAS+CMnqJqlDzprPgNXM8I0ROyWyFW+kWK8qRsRxCIZdBtOzT/neA?=
 =?us-ascii?Q?WRXP7KDUaVMRDYtEkZwgb9wQjvXghL71NWEw7adoHFMbYNiyq9VP0EFw8EAy?=
 =?us-ascii?Q?pYxODEKwGoj5TA4FF/ILptA8D0T3/6Qr1fZr5X5lDPOqsQC5Lc0A6Ib68KDm?=
 =?us-ascii?Q?dbuFRPTNv3pLP/vNtCOlckaxplEPaCClVHsNVl0OfY5UTxpMVN68kHBPKK0g?=
 =?us-ascii?Q?noWForI9273wryCUqZ/jgU3oY5Yc8XfOF9ZgBEUFk/LzOk2FCLHA/S6xqCFl?=
 =?us-ascii?Q?Ze7pgw88UzrRIrg4nCwxIwAbCOc5d0J5ueocR5WmFZvO3oQI42WU6wEIWmqu?=
 =?us-ascii?Q?g0gYk9vE1kCUofqL/5U9pceJNzj1y9BRRi1hz0njGCsXRDLKOxBnCddc4y5t?=
 =?us-ascii?Q?Dx+D+P81SoRQhQw6KgQVMAOboOIvP3vucUCCIrJ5ytC2i5EeXC6aH7Yqme/c?=
 =?us-ascii?Q?uSX8Lu4ctafhu/YWkDszkO83wo7wqLBdZeVx30cQ1Fe6b1idWHSGMjtb4OUJ?=
 =?us-ascii?Q?LUQUIP44vqtRcCWiuE9uLjyLOJYY+vmMj4HC7JpqiBh4lZFlmKY25BIGcBZy?=
 =?us-ascii?Q?TWBLxSkdWfn68z9XGIiD4duoFVEBJ41pPfhXukUtzuwkBzxmA3ruOUUOPZrb?=
 =?us-ascii?Q?9FiVgM08C/KvGv4dmpFFUHC1Z2ZF1ESnQTxdaILjRo+dLuh1gu9cSLwOA0z9?=
 =?us-ascii?Q?r4/Okxu1T5rj8QamnHjv5UEivTNDynqyyZlLhVmUCAPEUks9M5EJI+efCGVd?=
 =?us-ascii?Q?CAFCCs+sj1ZZW+3ZIt9RfUyrOi0PZRshQGz236CKo4PgIhhtWBLh+SWJwnX4?=
 =?us-ascii?Q?IMSoUFcGkRFXGY/qkNtuKXGlyrGfB7jZKsyw5i7g1zmS2QBJa1kAkGFnO9Eu?=
 =?us-ascii?Q?G0V5kjLLi7fOP9gXOPSdUoHKT4WLTL06gYDDAvwQKuVOXNCFxbUxrjrPTRU4?=
 =?us-ascii?Q?GSrJ5gfxqajgrE4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 13:36:40.5399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 713d755e-f6e9-410e-1e66-08dd75d93a8a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7602

The policy offload struct was reused from the state offload and
real_dev was copied from dev, but it was never set to anything else.
Simplify the code by always using xdo.dev for policies.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c | 2 +-
 net/xfrm/xfrm_device.c                                   | 2 --
 net/xfrm/xfrm_state.c                                    | 2 --
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 626e525c0f0d..0dfbbe21936f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -1164,7 +1164,7 @@ mlx5e_ipsec_build_accel_pol_attrs(struct mlx5e_ipsec_pol_entry *pol_entry,
 static int mlx5e_xfrm_add_policy(struct xfrm_policy *x,
 				 struct netlink_ext_ack *extack)
 {
-	struct net_device *netdev = x->xdo.real_dev;
+	struct net_device *netdev = x->xdo.dev;
 	struct mlx5e_ipsec_pol_entry *pol_entry;
 	struct mlx5e_priv *priv;
 	int err;
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index d62f76161d83..4f4165ff738d 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -378,7 +378,6 @@ int xfrm_dev_policy_add(struct net *net, struct xfrm_policy *xp,
 
 	xdo->dev = dev;
 	netdev_tracker_alloc(dev, &xdo->dev_tracker, GFP_ATOMIC);
-	xdo->real_dev = dev;
 	xdo->type = XFRM_DEV_OFFLOAD_PACKET;
 	switch (dir) {
 	case XFRM_POLICY_IN:
@@ -400,7 +399,6 @@ int xfrm_dev_policy_add(struct net *net, struct xfrm_policy *xp,
 	err = dev->xfrmdev_ops->xdo_dev_policy_add(xp, extack);
 	if (err) {
 		xdo->dev = NULL;
-		xdo->real_dev = NULL;
 		xdo->type = XFRM_DEV_OFFLOAD_UNSPECIFIED;
 		xdo->dir = 0;
 		netdev_put(dev, &xdo->dev_tracker);
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index d896c3fefb07..33d1f5679e8b 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1555,7 +1555,6 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 			xso->type = XFRM_DEV_OFFLOAD_PACKET;
 			xso->dir = xdo->dir;
 			xso->dev = xdo->dev;
-			xso->real_dev = xdo->real_dev;
 			xso->flags = XFRM_DEV_OFFLOAD_FLAG_ACQ;
 			netdev_hold(xso->dev, &xso->dev_tracker, GFP_ATOMIC);
 			error = xso->dev->xfrmdev_ops->xdo_dev_state_add(x, NULL);
@@ -1563,7 +1562,6 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 				xso->dir = 0;
 				netdev_put(xso->dev, &xso->dev_tracker);
 				xso->dev = NULL;
-				xso->real_dev = NULL;
 				xso->type = XFRM_DEV_OFFLOAD_UNSPECIFIED;
 				x->km.state = XFRM_STATE_DEAD;
 				to_put = x;
-- 
2.45.0


