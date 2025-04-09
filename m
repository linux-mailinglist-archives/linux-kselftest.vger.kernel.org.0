Return-Path: <linux-kselftest+bounces-30424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE57A8287B
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 16:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0941890F48
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 14:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF3F266B43;
	Wed,  9 Apr 2025 14:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hW1/Mmnr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6569191F77;
	Wed,  9 Apr 2025 14:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209746; cv=fail; b=GrMuqb9YGAJznfD2n5iFkVDoMXziDtOb8u0s7YJTj4SQXnLQ/tejIeT3Xp7g07nIAcXo1IM/z+35lA+ElUCW0HrBN+lXW047fSTpmexPjBTtJtrq9bYqQflsNZlA3IZGwrvpQtbRs5xDezssMHBlMta8jRg6rg0pCUUyilObRPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209746; c=relaxed/simple;
	bh=E7YAMbh4rhcCrP8GqyO5BHfECff1nYTF5Hqcd6c1fFw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aobIDUc18L8tNEJAxWZRVXFSjm4jEN70L73NpKcdhwanyTDb7u0wvYWzaktH7oTIEsv4sLwV9cf35mASawYwEe0WoQDgGpPqp9/bqIaRozfwLoCn9rrpzlTqsqhaNlFuZ5GCJ+5YtA9mcDMt/jOsJCJfQI2Ev08xgWYSE6ZfXWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hW1/Mmnr; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRgPSxDUco8Z4wMlLNh8Ln3q6kCLIsuEWFo35+xnxHaC3Zvgv2kqfD0VfDykj6LDQXApgMWIXl5lJnYsU7ugzHzaULpXlxxbXeeYB504qhB5G9EUAwWlBacw9mP58PqnEQZybt7NWXmMQtw15n+SrkiTLnHjgBj2sEDf5jJXZKM2p7iw93AsQnn/PCZNPz8hGGRjQgswy8IY5y/a7ckGEiwXCrxkr0guCDUM9usWsO8HzGeZ7gvWkiZAdg4xMyGnif7oQD3YODhmKXBhBby6dzUO7mymKDVeeGd3o1EV6Bd22lx2rdPWnKjT+H4ceZW52EKSPM4P/mCrlFgD0885zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JeP0oeFT1V1YZfI0RbwA8wpecEhr06zGkLkr7cOahY8=;
 b=BDwmLeXsq92P32fLvvTRnufpsb77FLWC8A86bE2RtPhPWC0gDdBXiDLi383VGLoAT2hWD2Jdw6RwjWml9WWUWxbq4H5uLhkBICbkVR8n45uOq8xl+lLsbSQnHXCgGd0kdikyyNl+GC0KVJn8ywDvWPM9JlK58GUACzNn7hgYgytAMLVYREesNWfNDKObrSN0a0mIKLs5U3rjb1qnB/44wFOfldr9W7fIXFeYfkO7mY7AUaq/dlOcOTPkTlvHnbPCUY0r4f1CdNYqZ5RCv3vqaZVLCjZ7LVuicpWghXFFmutv5EiO+f8zHd4mcOgr8DFPsaV6mRyonXHhVH7ac14oLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JeP0oeFT1V1YZfI0RbwA8wpecEhr06zGkLkr7cOahY8=;
 b=hW1/MmnrjqFBhJS5TX8EfxWBCid7BuOicRvdWQypkMvvlOSa/kqnrrL99BoA6e/foSfW66og8VWbzCQp5xO1JGDUJ+BPEBeF+shLEXm4wldAraConMX/IIMXZBEmsODPKQJ118e7hi5F6PrIyAVt3k4KFqPZx/KWLbIhluTBPj4utJuabMOTQOh6u15STi382z09B1XLru2QXfMUvYESO812DsmGQBWOcq7EhOnqHpXNiBOCmW55KA7uWtEOwzD8IPjJulgyibpYUgRCC4WT2QZnGcGHr6o/xMkQdW2boNkAKvIzBP4JTDe/aSfN0v20wqY/zYhJTyW3HjLTgoc2sQ==
Received: from CH0PR13CA0024.namprd13.prod.outlook.com (2603:10b6:610:b1::29)
 by CH3PR12MB9453.namprd12.prod.outlook.com (2603:10b6:610:1c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.48; Wed, 9 Apr
 2025 14:42:21 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::75) by CH0PR13CA0024.outlook.office365.com
 (2603:10b6:610:b1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.8 via Frontend Transport; Wed, 9
 Apr 2025 14:42:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Wed, 9 Apr 2025 14:42:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Apr 2025
 07:42:05 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 07:41:58 -0700
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
Subject: [PATCH net-next v2 2/6] xfrm: Use xdo.dev instead of xdo.real_dev
Date: Wed, 9 Apr 2025 17:41:29 +0300
Message-ID: <20250409144133.2833606-3-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|CH3PR12MB9453:EE_
X-MS-Office365-Filtering-Correlation-Id: 91b84a2a-3f77-4ef4-d9dd-08dd7774bc3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bh/3NbByT0ENbWJfjLeLXg9GHl3F3YV2SkcIjsdRqtzkGN1tp19JLEjpDdil?=
 =?us-ascii?Q?f7E33qsQO1xJ3pmGEpTTe8Vzoqt1rqfAiGsZeBzTpGq5RtBbUNTMOKck4AX7?=
 =?us-ascii?Q?zjbq4c2245O992uaVnREo4vGO9ocySMEtI6AWM3VmVAOk6XxA8Y1EwoCFYcG?=
 =?us-ascii?Q?y2U3TfIkPIQBCGeeuMaSGhTytj/EBbVkY8rVHm9S9I772IzkfCJjSshOyykd?=
 =?us-ascii?Q?F/AuowSE+Evg8AK9NgLM/9D+HHaBoK/9wRiTB1a2tgpWVtn976VKbKY5Pnbt?=
 =?us-ascii?Q?1GvSCxnwIKc6bJ5+Gv+cMLIfNjmeDaxhGvzIkewNHWM4o2o7RC9wzylWE9ej?=
 =?us-ascii?Q?RKneFj5RD7tMQ+t6GPSDNY/XBhK/V92TopEe+wPcY7UmQhSMXR+CJ0N2lyng?=
 =?us-ascii?Q?0oBCr2odaner2rldrlG3XvZme28wIyrDGzdRi+l3KP1WAYRbQeSIMbgELUTi?=
 =?us-ascii?Q?2udKrxEmv3LAMiauytURFZIEuY6Y+oh98EJkmSQ9LtcrkOS9xBkHK1Js1A6B?=
 =?us-ascii?Q?Z6rUSrrlvPTbrA7KyPzXMq08gzxDATr5jSoisileW/2XmRPh8RYVgdoIVuu6?=
 =?us-ascii?Q?CitjcePFTRELkp/AJqFRVuTKifG1s4DgVlQptfY88JwD62l143e8HCeLK7hn?=
 =?us-ascii?Q?jKw2LSlG8pEVRczNltNCodKN8RJSsK4dqt6Ff+q1lS8C9YoVsAXHVSZN43B6?=
 =?us-ascii?Q?IT9IK09dCisRfiOQDWIv/YOcwQJPeWQ32ji1CNmtEed4Mn6zTA2wd+zF0ZgU?=
 =?us-ascii?Q?Dd/g9nGYp/K+nyjqIokkmxH2ltnHGdZWWeRu1sappAEg5MgTTsYzH/hNnE51?=
 =?us-ascii?Q?xf4eebE2n0YwP875HTUlYbjmAq7sjfP5VETNdlTCz0Sm4x5z12YRt1yX8Qmz?=
 =?us-ascii?Q?nttEIcYycqkhAWfi5c+UFemgQUSBOSbREGCzjhZzwbxTKofEp0s1wG4cxU08?=
 =?us-ascii?Q?DRyYAfKwUP0jJM4hS78PY9runbin94ohkLD6ZJkWoQ2gbpZQf2nihQRx0p2j?=
 =?us-ascii?Q?U6XdXp/KjTTJrMNTJzCYqjIn7HnuCg5XasHmwZvy9W3uGCy7feCoAN9GLwpv?=
 =?us-ascii?Q?lNFuxJjqDs7baR+EwlsvWGomhG6UCCN9Mdkt0zT3ZcMGRQdCrGe7k5o+R/kj?=
 =?us-ascii?Q?/ZkjNJqsWLVbokH670GOK0DXahxYvpcjCHMZRZnbjtxWUb5RH3NSU9Rq3EWa?=
 =?us-ascii?Q?WeJYpDOruhBS9gv+jp9gQGSUj+E7buz9UEQt1oBEp9ONnC9E0m6QqXZbZ6Iv?=
 =?us-ascii?Q?Fo0RkWnZoBIdnLO011SBIOITm08i9qAbxRoIyXWUS2Zd5GtOLJP/XFQv5bs3?=
 =?us-ascii?Q?80iVBxAtvCtks7g6dxUyu1Kf9xtljPkJ02c5qfSZGqhD77K8KqDromMPrX6L?=
 =?us-ascii?Q?ezb/0XgmC9vVezBOzjH2fBxMVVBOkkwO1W95zWW4Er4zqiTPNZqJKGOTNeKF?=
 =?us-ascii?Q?hpsNoG+t9WuN0mk2ifc29XFweHDwQGJICJLWZSQo4Noh6rixkYDI/KFpJr7o?=
 =?us-ascii?Q?lA+qx4o8XNZxodcqqvcybsWQl631dvMTHuO1?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 14:42:21.3063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b84a2a-3f77-4ef4-d9dd-08dd7774bc3e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9453

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


