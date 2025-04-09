Return-Path: <linux-kselftest+bounces-30428-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F75A8289B
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 16:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786113B52A5
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 14:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3832620CA;
	Wed,  9 Apr 2025 14:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V+kpGxpT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D203595C;
	Wed,  9 Apr 2025 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209774; cv=fail; b=GLxY2coXQEKBaNqs74GpMW4Q1UcUOzaFm7E1l2MqGvFHl51JCsvvo7f2+UO5UApJUd+n1akqemy7r9OXBkVJO0SHkJC1Bt+PGRoaZwxLls2k/PhA1IY87YCiB9+QoGKNgquo/wAYBBnF+u2Bf98KU2nVb9GVW7AASL0r70WhBgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209774; c=relaxed/simple;
	bh=XA50F9kdZqWA0zEegRaUGvUlcWGWZ7Pr6YOrSThbLfU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=smWjJCFYvhd4PJVLbbibNNBnNGg2tpb/sWTmwR17Gk54b3/s3p0f+4Q99zmnGRyktHLvaPyr74rh55oORip1dGdL0Nc3QUCvsuNKfz1UTvPn9vS+0Wm0THUyuX94xPYm4xsJtEL1BNCeuL6c8SkJm2lb/4sQn+EzmPLwLSLc6yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V+kpGxpT; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AlJ+zfqo4QMtYwbz5ctrGFRNzn//JmAn/iyGZpGIg3PIiStPnwzfiZI95YkjtdRKjs13UR77y+6ufnY8Jp4fxI2R8u2j89pYLRY7fmOUrS/HbJ9ZqsAk0mMgu4eYEbdYybwjKCVmOviG8ZlLj/geWOCsqlNYCNHQSmZxNTNvBPw0Cj97M33Um14hnoYONRwWa7g97aSr8SWPNHTYcGYu7wy9df18Z+OORez5g4nu4WU1Q12oKiY56d7+OkXjpbpjHxz+Iz5UpJbflXAqkSNtRexkEhiLA8Cekrmyfp5sAYjZbMUfbjO7wjJZdPxfvCYXFzt6ugEUinI2Ke22uHN4Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEivdLeKR1r4QovkPXdsPMCbCTwvDwdTA4idnSvG+Vw=;
 b=zN6+bce5yb4OrLlsLMPK45c6VuOaoJgC01Bh0Eqz4kHLeY/Ac7IldSedodwcThgRYiTu7tBac2Lpg76ZgabH6793bLL7oviEGC56IGQMS7YD7d0+cW0Edr5ys+8ldH5O4n29qXvvDG7eMfIQb+e722zxGOOK5IZqWJ5GM/zL38DV/0q0iPEopAV5PMDUviaMcqlHuq65ryuZ904QLUOAcBRbn/0fgHURYyfdj5pLqd3IW7RnBBgCwqn5ldVQCwubo2qSvfaiR6/fHsracSuddb+AuqIYhLWNYMXjMQVsete+5sqNZBQyS9BkXUCp0HsaZygW0zW7nkJRpjNzz5X8Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEivdLeKR1r4QovkPXdsPMCbCTwvDwdTA4idnSvG+Vw=;
 b=V+kpGxpTKTa7V717UtwRu4YqdSYQugf3+xw1/4GJQ/Hnyq4/VSExuzzdHMFAU3gQWC0Y3AAWlma4Xdkeb3iOitGqLFt8emFdv1L48f0X1K1ZFpDBPt/hPj9+BUZm4ucdsNf6EUxFisQdmAiBKkr0KhyRnoRuw5hKuMLRMR4WqyqrSOdXgMx/59qsOFIExBWWPA+UZnRBFHjsQ9aHh48hyNVs9twr+qE9HfGDf8ry08CuYm61hATxErY0MpGpkmBeUUujERxdXG6VnK0ncUsUFd1VNH1gNgjsPr8upcZno6R9UxH4owjwCvxVdIJDtyqf8PuoA4I5pvyhXFugOfUWEg==
Received: from CH0PR03CA0217.namprd03.prod.outlook.com (2603:10b6:610:e7::12)
 by PH7PR12MB5619.namprd12.prod.outlook.com (2603:10b6:510:136::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Wed, 9 Apr
 2025 14:42:49 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::9e) by CH0PR03CA0217.outlook.office365.com
 (2603:10b6:610:e7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.23 via Frontend Transport; Wed,
 9 Apr 2025 14:42:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Wed, 9 Apr 2025 14:42:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Apr 2025
 07:42:32 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 07:42:25 -0700
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
Subject: [PATCH net-next v2 6/6] bonding: Fix multiple long standing offload races
Date: Wed, 9 Apr 2025 17:41:33 +0300
Message-ID: <20250409144133.2833606-7-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|PH7PR12MB5619:EE_
X-MS-Office365-Filtering-Correlation-Id: f315ddcf-5b72-41a9-4a76-08dd7774ccbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MVPVb601NDBacU122iYozPOSAx6wPSKKcnjnNqXRlbE6WnMbpi6Sb2dJx3DS?=
 =?us-ascii?Q?BMxvExklK1qkyZNTj/ijn8n/6qEC1VAIi7OPwEYtr4YKQxK86XgheZ99Wrwd?=
 =?us-ascii?Q?SdzxXDH7H4AQgdPU+3PvEhjKIB4CcvhS11dxJraSupBueU5ICn/RayFSKvL7?=
 =?us-ascii?Q?/HNomfvu1s4ZUj+r8HPmmDzn9eeR/HfCYUghyoeIz9g2V0pNtbI0g0ueW4fL?=
 =?us-ascii?Q?nlVqMxHh1a8GxRQvljxPRpBWyZJxArPehDeqcKM1GHN9v3E2JEHHKvcpaVMf?=
 =?us-ascii?Q?0aPGcfRli1fKCVj7HZ4gt8KplRPanDGoZKVLEBLbr/WcBl8vDPw+GIlPW59x?=
 =?us-ascii?Q?rZ5D2saI/D41P+ZFwLK+XsCIl6QIhN0bPUx7+84sDnaxqim0HB5paV8Gm7dg?=
 =?us-ascii?Q?jQ4pxhOsNYjxLQCV26jxzR4nTrqP3iMo/7Iq429lIOaUpvwKyp6pviDNCHd/?=
 =?us-ascii?Q?yzBe1Ya/MLO/23pKSFzEgqPzGn+MoDppJRNtv2dgGDvktg1ONNj6VyL7Cic+?=
 =?us-ascii?Q?QqCvGeNMxP1eW5PYDAhmzlNfmOpNWmRT5shI8wsrHbjnWk0C5/EjQz7s3Zff?=
 =?us-ascii?Q?yMLl8H5vg11OhWwnAL1iUiOeatIyrPG074DPZrVO+XCbCVzaKaQtkBXUcR6S?=
 =?us-ascii?Q?+Sx0Ar8rpSSBEtGm4dxPCthA/kBpJ3b7mPlQIgaNhAeTnVS1b620CGZeN3fe?=
 =?us-ascii?Q?Sw41BaEAbGeTXyOVjngAjVnZMSj1HJa9nEvvMNRFFcPmgxApheYYyDa+sj/d?=
 =?us-ascii?Q?2cr1stjCXO3eLptqsuRCNO4B5Lkkx8fWsiT0F7NcdYlTBPbvXqsx8jkZoXew?=
 =?us-ascii?Q?BTVZDO8M3q3MzLT6wAPNsBMGINYxNUE+wiBKwo9AdrdmOaCEYKLGncHCz1+u?=
 =?us-ascii?Q?Oru+5UJyftfM/nmG9NrJ6tVYJgcI5Km3bE3SAt5UgBrm35GnvG2ih9aXPtxk?=
 =?us-ascii?Q?3nH6cGzDjIySq3bcXYRVYTltAdV6VnxVVlWUz6wtLgbY617piFzX9vn8+n7/?=
 =?us-ascii?Q?WuQ11BNnaepFY3w83dspiQXQBt0+oZW4qIh1+Dp4uI8W6VXM5T/Zi4vRwdDT?=
 =?us-ascii?Q?NElT41B4SiO0BYwWWa24aPevkqVTibtqXeP+Kj7I0bpawAunnanwe0LE7I3J?=
 =?us-ascii?Q?+UdBSIA98+Dmg67Z+7EA6GQEg3PF1/QH+E8CYw2oIXFn+GevtZ/Jxk8RMOKr?=
 =?us-ascii?Q?rG8vVE+qJUlz+lrwqQmj/oZ4665cz2n2RWgfuHPDB5h5u/ktWcymqMYqDdc1?=
 =?us-ascii?Q?NZNvbuEwDsIbAHXTFYF+bMoQHagGlAe8abmQ1vTd0MV7bJgM0vAswcZw5yUu?=
 =?us-ascii?Q?GE5EKBz1uUd0qknP3wOEpXfV/DzzNVTNO+HI47MzldZXNJAnXN0noladYjlA?=
 =?us-ascii?Q?vX/kpPDHJ5tx9Qm9nvAEBPuPSxbexOgvgON13rLOHz4PdLha+RwfxxUb/k4M?=
 =?us-ascii?Q?wFlyiI55G6Zqkzc+2y2WXTtHWIND9yhiHMfzE5Y7TsojAh6Hil7t0Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 14:42:48.9850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f315ddcf-5b72-41a9-4a76-08dd7774ccbe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5619

Refactor the bonding ipsec offload operations to fix a number of
long-standing control plane races between state migration and user
deletion and a few other issues.

xfrm state deletion can happen concurrently with
bond_change_active_slave() operation. This manifests itself as a
bond_ipsec_del_sa() call with x->lock held, followed by a
bond_ipsec_free_sa() a bit later from a wq. The alternate path of
these calls coming from xfrm_dev_state_flush() can't happen, as that
needs the RTNL lock and bond_change_active_slave() already holds it.

1. bond_ipsec_del_sa_all() might call xdo_dev_state_delete() a second
   time on an xfrm state that was concurrently killed. This is bad.
2. bond_ipsec_add_sa_all() can add a state on the new device, but
   pending bond_ipsec_free_sa() calls from the old device will then hit
   the WARN_ON() and then, worse, call xdo_dev_state_free() on the new
   device without a corresponding xdo_dev_state_delete().
3. Resolve a sleeping in atomic context introduced by the mentioned
   "Fixes" commit.

bond_ipsec_del_sa_all() and bond_ipsec_add_sa_all() now acquire x->lock
and check for x->km.state to help with problems 1 and 2. And since
xso.real_dev is now a private pointer managed by the bonding driver in
xfrm state, make better use of it to fully fix problems 1 and 2. In
bond_ipsec_del_sa_all(), set xso.real_dev to NULL while holding both the
mutex and x->lock, which makes sure that neither bond_ipsec_del_sa() nor
bond_ipsec_free_sa() could run concurrently.

Fix problem 3 by moving the list cleanup (which requires the mutex) from
bond_ipsec_del_sa() (called from atomic context) to bond_ipsec_free_sa()

Finally, simplify bond_ipsec_del_sa() and bond_ipsec_free_sa() by using
xso->real_dev directly, since it's now protected by locks and can be
trusted to always reflect the offload device.

Fixes: 2aeeef906d5a ("bonding: change ipsec_lock from spin lock to mutex")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/bonding/bond_main.c | 76 ++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 40 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 14f7c9712ad4..78e1d5274a45 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -545,7 +545,20 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
 			slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
 			continue;
 		}
+
+		spin_lock_bh(&ipsec->xs->lock);
+		/* xs might have been killed by the user during the migration
+		 * to the new dev, but bond_ipsec_del_sa() should have done
+		 * nothing, as xso.real_dev is NULL.
+		 * Delete it from the device we just added it to. The pending
+		 * bond_ipsec_free_sa() call will do the rest of the cleanup.
+		 */
+		if (ipsec->xs->km.state == XFRM_STATE_DEAD &&
+		    real_dev->xfrmdev_ops->xdo_dev_state_delete)
+			real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev,
+								    ipsec->xs);
 		ipsec->xs->xso.real_dev = real_dev;
+		spin_unlock_bh(&ipsec->xs->lock);
 	}
 out:
 	mutex_unlock(&bond->ipsec_lock);
@@ -560,48 +573,26 @@ static void bond_ipsec_del_sa(struct net_device *bond_dev,
 			      struct xfrm_state *xs)
 {
 	struct net_device *real_dev;
-	netdevice_tracker tracker;
-	struct bond_ipsec *ipsec;
 	struct bonding *bond;
-	struct slave *slave;
 
 	if (!bond_dev)
 		return;
 
-	rcu_read_lock();
 	bond = netdev_priv(bond_dev);
-	slave = rcu_dereference(bond->curr_active_slave);
-	real_dev = slave ? slave->dev : NULL;
-	netdev_hold(real_dev, &tracker, GFP_ATOMIC);
-	rcu_read_unlock();
-
-	if (!slave)
-		goto out;
 
 	if (!xs->xso.real_dev)
-		goto out;
+		return;
 
-	WARN_ON(xs->xso.real_dev != real_dev);
+	real_dev = xs->xso.real_dev;
 
 	if (!real_dev->xfrmdev_ops ||
 	    !real_dev->xfrmdev_ops->xdo_dev_state_delete ||
 	    netif_is_bond_master(real_dev)) {
 		slave_warn(bond_dev, real_dev, "%s: no slave xdo_dev_state_delete\n", __func__);
-		goto out;
+		return;
 	}
 
 	real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev, xs);
-out:
-	netdev_put(real_dev, &tracker);
-	mutex_lock(&bond->ipsec_lock);
-	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
-		if (ipsec->xs == xs) {
-			list_del(&ipsec->list);
-			kfree(ipsec);
-			break;
-		}
-	}
-	mutex_unlock(&bond->ipsec_lock);
 }
 
 static void bond_ipsec_del_sa_all(struct bonding *bond)
@@ -629,9 +620,15 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 				   __func__);
 			continue;
 		}
+
+		spin_lock_bh(&ipsec->xs->lock);
 		ipsec->xs->xso.real_dev = NULL;
-		real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev,
-							    ipsec->xs);
+		/* Don't double delete states killed by the user. */
+		if (ipsec->xs->km.state != XFRM_STATE_DEAD)
+			real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev,
+								    ipsec->xs);
+		spin_unlock_bh(&ipsec->xs->lock);
+
 		if (real_dev->xfrmdev_ops->xdo_dev_state_free)
 			real_dev->xfrmdev_ops->xdo_dev_state_free(real_dev,
 								  ipsec->xs);
@@ -643,34 +640,33 @@ static void bond_ipsec_free_sa(struct net_device *bond_dev,
 			       struct xfrm_state *xs)
 {
 	struct net_device *real_dev;
-	netdevice_tracker tracker;
+	struct bond_ipsec *ipsec;
 	struct bonding *bond;
-	struct slave *slave;
 
 	if (!bond_dev)
 		return;
 
-	rcu_read_lock();
 	bond = netdev_priv(bond_dev);
-	slave = rcu_dereference(bond->curr_active_slave);
-	real_dev = slave ? slave->dev : NULL;
-	netdev_hold(real_dev, &tracker, GFP_ATOMIC);
-	rcu_read_unlock();
-
-	if (!slave)
-		goto out;
 
+	mutex_lock(&bond->ipsec_lock);
 	if (!xs->xso.real_dev)
 		goto out;
 
-	WARN_ON(xs->xso.real_dev != real_dev);
+	real_dev = xs->xso.real_dev;
 
 	xs->xso.real_dev = NULL;
-	if (real_dev && real_dev->xfrmdev_ops &&
+	if (real_dev->xfrmdev_ops &&
 	    real_dev->xfrmdev_ops->xdo_dev_state_free)
 		real_dev->xfrmdev_ops->xdo_dev_state_free(real_dev, xs);
 out:
-	netdev_put(real_dev, &tracker);
+	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
+		if (ipsec->xs == xs) {
+			list_del(&ipsec->list);
+			kfree(ipsec);
+			break;
+		}
+	}
+	mutex_unlock(&bond->ipsec_lock);
 }
 
 /**
-- 
2.45.0


