Return-Path: <linux-kselftest+bounces-30427-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8DDA82872
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 16:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8AA64E417F
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 14:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F7F266B4B;
	Wed,  9 Apr 2025 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iISuY5Tx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA38B3595C;
	Wed,  9 Apr 2025 14:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209768; cv=fail; b=GTyHvU2VqoVpr26mEbk/8X8XSYwzcHuUHZ+I0x+RIE9wr+LcZsFcyTnKstgKGnDTaBINdiklHSl24xrX1QjiCqSMws26DMN0Ej9N8gjeDZ+BAb0zsNWzj1MZLLx9wv/dsBmxWzaFU67Ca4TUG1tvwe9NteUa4IcHBsLx3LIBZmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209768; c=relaxed/simple;
	bh=MFuFXAZKX/zELc9iwDF0+1EBnNWXnA/ZarTIcf9j4Hw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qq+pZ+a091uwg00/ikuDsncuQBZtsHVBoeZ5AHqHUh8vIYTEyEHIxwxKK1qnDe4oy8FlVVzLmrQ6QnYjGootDLaSUS1eBxrhPl4DCcgE63mDYTduyBrpxUwlKoanS4Ji8iNdbIMkJ/RejmDU8n9JD4yG89VP3RCHgidTNQBzaog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iISuY5Tx; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LyTDJqhSeBk4uqR97V9T2eegvefoUj11Wb6MXt195HA/y1SS/75L6xndzuabLy+reV587rtDsTtLDVy//wHnM3vSw9rR+jHNrBOXm3lrVTflNl4AcBdwGISoZPNA4JCWWBfg1inwW6OOEs3ESDoJAF8Iwx/sGceN9gOY+0Jqlwo0lzacgo9yl7xgh/wc09DgBydZTfA1I7XpRjOlmsAB5hcv+uR83szVFKuBYhutvUZrFxh5D0Ijc8LPMmIxoSpd3IqM0mp3thtyjPN1xRehMVa/oEqG/FXM0fgReKJv7RSLQXI1zcfM9YUasb5MVFZqFkr3TVjUgXVL9x0cwKDuDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKpGJFbfwYtNmQUdTvDq8ThlJcCDO3lmdr71RUd2RZw=;
 b=aOtKMNOQdEr3dUn8okDrCg604rzObCYeV+ZJILY4AFkz06eYsU4rhBjDUA2nHITF8LHEUkzVaZ0Ws1QtM5SC6ec1G+4Zy7DJz+txLETzfVZPkz93irV0YcZDolJEn2WeeJromeg5zLZyKY8RsExsJfmY4eEf5Go2bNQySDDxEBV5difwN3Qf86Uk1Z7rAIqtbStRvet2j0wervm26P94117ul+CmAGriZXp7B9LSgdLVOGuiTGupIVOLvm0u/YRfAwX89Nu19uX1dTVegQztHHIUPwKtj94NsCMqfzjsPqWleC1xMfcUYDDgk8ez5ImhgrriMYNxYoD7Fr0hlwte0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKpGJFbfwYtNmQUdTvDq8ThlJcCDO3lmdr71RUd2RZw=;
 b=iISuY5Txr/ddI7MkY1dyc3bDuPHRkJF9i9ApvAQnQrwbiPueCl0gLRNOhJLtFuSqUVoAyxorP/v0xnt5CU04qer/92BnE3N/rIux1awrVfe1W4fM0xTDchgDuj9Iod0IUot0qXsLOeFZbElggNu7TW2nA9Wd139XkvOqwgTFHYpCs3vYK6m4VPoRTchRwLJ/Rni7Xiihp8qG9mfA0dHmR5F+KTPhTHwLSHudkkOqigBDBrgBgx2CLRM3sYDkoQw4HocX2XtokDlknt2KmFaBkldDzixXebJuAzX9z05JCL9CTaqVQsnfB1IyZMQQyxib0l/RfmGyiiIzrJyZcJM9sQ==
Received: from CH2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:610:50::35)
 by SN7PR12MB7347.namprd12.prod.outlook.com (2603:10b6:806:29a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Wed, 9 Apr
 2025 14:42:34 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::b7) by CH2PR16CA0025.outlook.office365.com
 (2603:10b6:610:50::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.22 via Frontend Transport; Wed,
 9 Apr 2025 14:42:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Wed, 9 Apr 2025 14:42:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Apr 2025
 07:42:18 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 07:42:11 -0700
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
Subject: [PATCH net-next v2 4/6] xfrm: Add explicit dev to .xdo_dev_state_{add,delete,free}
Date: Wed, 9 Apr 2025 17:41:31 +0300
Message-ID: <20250409144133.2833606-5-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|SN7PR12MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: fc02c4bf-e285-4453-1468-08dd7774c3ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2TwwTV5yGFPYMwF45cvs9hAQ1t5AhQl71M4tKQpSHHuwfpo5i842fBXxcwFY?=
 =?us-ascii?Q?ZcJmnHTPeVArA4F1m5fKfuy5LrpxmUIeaR7a81gStEb83FVtGfJCLX2g4oZg?=
 =?us-ascii?Q?CLqbUWg47KD7JLGPPMUOlKAbzfDNgISyicEM3j8N6oNCb/GRQmWjhwLrTqPD?=
 =?us-ascii?Q?vg2h5E44HctwTeINQfAF5Z/L5OLxRdPjeiajQl8kfpuJkq1H0rxARHhoV4Pd?=
 =?us-ascii?Q?sAFrwLRcfTy9yT1D67LQUGxN746aPzRNAM8dNRCYKNxPK2L6pTOMNzFWZf1P?=
 =?us-ascii?Q?8922mHYIr6MoXGq0dQGv15SHa+28gPNFdLkCb7NzZYjffrZej/ylf6sfjnrN?=
 =?us-ascii?Q?hj/RT3Ty14qOJYWD5SV61EasegqobD57PSZO/39VjJrxNaFkZUhgs6k0awpy?=
 =?us-ascii?Q?llD8rRX6dAT0vLKaZKRszPXuvwDYQm+odpVTMb9Pix8yrL+5fl1PT8Desw8D?=
 =?us-ascii?Q?mUuGvhBEJHzPuF5OAz51KZB8VV7pEN93eknxlWQYg0dRg4dH23Y507MWKrG/?=
 =?us-ascii?Q?z2vPm5wwkhWs0doqgGxbvN2EI2I52GPy+GoOAfSpGwFLQqwkB/muNkSo2efv?=
 =?us-ascii?Q?vmuT20a9FZyX1ty5aOpZpOLsL/JR8j2Z6uBNVKwVOZkuya7jP+cGMEI6SrH3?=
 =?us-ascii?Q?tkycAb7etziYeHJ0a8r7sejPzDBRbHpj3tUxcoaeAY6CIww9eCdxrXHlhjN/?=
 =?us-ascii?Q?u0dmH2YtnzCgHlREmS7iWL9Q95cQy7vUAQ55J5RUmbeNJyNZyVG5JscfBEEy?=
 =?us-ascii?Q?df6QgpE3yzwuWgaEpDjpwNSPPQgkPAB2pmhSWJ3pBXqbmC93ZErpunoWlrYY?=
 =?us-ascii?Q?kmuh6uO6oTdAD6f2sKyzdIQee/wb/T+0EfVf7LNcuzxSQhTHF2wcvjLcpoQA?=
 =?us-ascii?Q?gX/cusc4ecWWOM/seF1DZ1e8NiHAbRl0SreO0ZJ8NOiuJUpBk5ecX3NoC0n4?=
 =?us-ascii?Q?5w2T6/SR7HP0bYaXpImgD6kht9lj5T4shU55rL3Y8XwnwInJ2lAonXmF821n?=
 =?us-ascii?Q?thaSGBVmWsoPgp3FBGuDo0gO6VHhq0FUKn/FHcm18LS+QNABOrnaE0Ph6bBd?=
 =?us-ascii?Q?eA/cB4Y7hEDvxqw8+MudnxrYG4tWzCXzpWI9kpEnJF7Q+OViG8UOKIuPeqip?=
 =?us-ascii?Q?MedpOQxVQd2xbi+VCeIhibvNXqrLbIrwTva2OKM+j9Roi55lub4qQVQUn9t4?=
 =?us-ascii?Q?ghG3dW2frsXYWXdxN3a/waJDMSIXD1HUYRK2Ztcx6kipVthnewWe6m0pJ6zx?=
 =?us-ascii?Q?r6HRoZcHMgHiRaX2vyM8hBYbXN8bXjoBMoxsv209TYKnbdbXtj/7Xyt4Slb7?=
 =?us-ascii?Q?sTVAHxNOYpTC4ZUqPtrO5YhRT2otgCzFx75KTyv9SHAjYJ2kNzocNCfK1TbO?=
 =?us-ascii?Q?Yyl4cSrtSR2MxDEMQitCZ3PovlZagnRRDe/Wx2wuE5QHxUqWPiP2ftTaGjDx?=
 =?us-ascii?Q?WOIQe6Ey3UzuG1VdjNA7/mly2933ZxLIauSfzBxkTjKXSO67MT4YPkXrnF8v?=
 =?us-ascii?Q?ccmnoHuxfrP3spI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 14:42:34.1921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc02c4bf-e285-4453-1468-08dd7774c3ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7347

Previously, device driver IPSec offload implementations would fall into
two categories:
1. Those that used xso.dev to determine the offload device.
2. Those that used xso.real_dev to determine the offload device.

The first category didn't work with bonding while the second did.
In a non-bonding setup the two pointers are the same.

This commit adds explicit pointers for the offload netdevice to
.xdo_dev_state_add() / .xdo_dev_state_delete() / .xdo_dev_state_free()
which eliminates the confusion and allows drivers from the first
category to work with bonding.

xso.real_dev now becomes a private pointer managed by the bonding
driver.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/networking/xfrm_device.rst      | 10 +++--
 drivers/net/bonding/bond_main.c               | 33 ++++++++-------
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   | 20 +++++----
 .../inline_crypto/ch_ipsec/chcr_ipsec.c       | 18 +++++---
 .../net/ethernet/intel/ixgbe/ixgbe_ipsec.c    | 41 +++++++++++--------
 drivers/net/ethernet/intel/ixgbevf/ipsec.c    | 21 ++++++----
 .../marvell/octeontx2/nic/cn10k_ipsec.c       | 18 ++++----
 .../mellanox/mlx5/core/en_accel/ipsec.c       | 12 +++---
 .../net/ethernet/netronome/nfp/crypto/ipsec.c | 11 +++--
 drivers/net/netdevsim/ipsec.c                 | 15 ++++---
 include/linux/netdevice.h                     | 10 +++--
 include/net/xfrm.h                            |  8 ++++
 net/xfrm/xfrm_device.c                        |  4 +-
 net/xfrm/xfrm_state.c                         | 14 ++++---
 14 files changed, 136 insertions(+), 99 deletions(-)

diff --git a/Documentation/networking/xfrm_device.rst b/Documentation/networking/xfrm_device.rst
index 7f24c09f2694..122204da0fff 100644
--- a/Documentation/networking/xfrm_device.rst
+++ b/Documentation/networking/xfrm_device.rst
@@ -65,9 +65,13 @@ Callbacks to implement
   /* from include/linux/netdevice.h */
   struct xfrmdev_ops {
         /* Crypto and Packet offload callbacks */
-	int	(*xdo_dev_state_add) (struct xfrm_state *x, struct netlink_ext_ack *extack);
-	void	(*xdo_dev_state_delete) (struct xfrm_state *x);
-	void	(*xdo_dev_state_free) (struct xfrm_state *x);
+	int	(*xdo_dev_state_add)(struct net_device *dev,
+                                     struct xfrm_state *x,
+                                     struct netlink_ext_ack *extack);
+	void	(*xdo_dev_state_delete)(struct net_device *dev,
+                                        struct xfrm_state *x);
+	void	(*xdo_dev_state_free)(struct net_device *dev,
+                                      struct xfrm_state *x);
 	bool	(*xdo_dev_offload_ok) (struct sk_buff *skb,
 				       struct xfrm_state *x);
 	void    (*xdo_dev_state_advance_esn) (struct xfrm_state *x);
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 950d8e4d86f8..4ba525a564c5 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -453,13 +453,14 @@ static struct net_device *bond_ipsec_dev(struct xfrm_state *xs)
 
 /**
  * bond_ipsec_add_sa - program device with a security association
+ * @bond_dev: pointer to the bond net device
  * @xs: pointer to transformer state struct
  * @extack: extack point to fill failure reason
  **/
-static int bond_ipsec_add_sa(struct xfrm_state *xs,
+static int bond_ipsec_add_sa(struct net_device *bond_dev,
+			     struct xfrm_state *xs,
 			     struct netlink_ext_ack *extack)
 {
-	struct net_device *bond_dev = xs->xso.dev;
 	struct net_device *real_dev;
 	netdevice_tracker tracker;
 	struct bond_ipsec *ipsec;
@@ -496,7 +497,7 @@ static int bond_ipsec_add_sa(struct xfrm_state *xs,
 	}
 
 	xs->xso.real_dev = real_dev;
-	err = real_dev->xfrmdev_ops->xdo_dev_state_add(xs, extack);
+	err = real_dev->xfrmdev_ops->xdo_dev_state_add(real_dev, xs, extack);
 	if (!err) {
 		ipsec->xs = xs;
 		INIT_LIST_HEAD(&ipsec->list);
@@ -540,7 +541,8 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
 			continue;
 
 		ipsec->xs->xso.real_dev = real_dev;
-		if (real_dev->xfrmdev_ops->xdo_dev_state_add(ipsec->xs, NULL)) {
+		if (real_dev->xfrmdev_ops->xdo_dev_state_add(real_dev,
+							     ipsec->xs, NULL)) {
 			slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
 			ipsec->xs->xso.real_dev = NULL;
 		}
@@ -551,11 +553,12 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
 
 /**
  * bond_ipsec_del_sa - clear out this specific SA
+ * @bond_dev: pointer to the bond net device
  * @xs: pointer to transformer state struct
  **/
-static void bond_ipsec_del_sa(struct xfrm_state *xs)
+static void bond_ipsec_del_sa(struct net_device *bond_dev,
+			      struct xfrm_state *xs)
 {
-	struct net_device *bond_dev = xs->xso.dev;
 	struct net_device *real_dev;
 	netdevice_tracker tracker;
 	struct bond_ipsec *ipsec;
@@ -587,7 +590,7 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
 		goto out;
 	}
 
-	real_dev->xfrmdev_ops->xdo_dev_state_delete(xs);
+	real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev, xs);
 out:
 	netdev_put(real_dev, &tracker);
 	mutex_lock(&bond->ipsec_lock);
@@ -624,18 +627,20 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 			slave_warn(bond_dev, real_dev,
 				   "%s: no slave xdo_dev_state_delete\n",
 				   __func__);
-		} else {
-			real_dev->xfrmdev_ops->xdo_dev_state_delete(ipsec->xs);
-			if (real_dev->xfrmdev_ops->xdo_dev_state_free)
-				real_dev->xfrmdev_ops->xdo_dev_state_free(ipsec->xs);
+			continue;
 		}
+		real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev,
+							    ipsec->xs);
+		if (real_dev->xfrmdev_ops->xdo_dev_state_free)
+			real_dev->xfrmdev_ops->xdo_dev_state_free(real_dev,
+								  ipsec->xs);
 	}
 	mutex_unlock(&bond->ipsec_lock);
 }
 
-static void bond_ipsec_free_sa(struct xfrm_state *xs)
+static void bond_ipsec_free_sa(struct net_device *bond_dev,
+			       struct xfrm_state *xs)
 {
-	struct net_device *bond_dev = xs->xso.dev;
 	struct net_device *real_dev;
 	netdevice_tracker tracker;
 	struct bonding *bond;
@@ -661,7 +666,7 @@ static void bond_ipsec_free_sa(struct xfrm_state *xs)
 
 	if (real_dev && real_dev->xfrmdev_ops &&
 	    real_dev->xfrmdev_ops->xdo_dev_state_free)
-		real_dev->xfrmdev_ops->xdo_dev_state_free(xs);
+		real_dev->xfrmdev_ops->xdo_dev_state_free(real_dev, xs);
 out:
 	netdev_put(real_dev, &tracker);
 }
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 551c279dc14b..51395c96b2e9 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -6480,10 +6480,11 @@ static const struct tlsdev_ops cxgb4_ktls_ops = {
 
 #if IS_ENABLED(CONFIG_CHELSIO_IPSEC_INLINE)
 
-static int cxgb4_xfrm_add_state(struct xfrm_state *x,
+static int cxgb4_xfrm_add_state(struct net_device *dev,
+				struct xfrm_state *x,
 				struct netlink_ext_ack *extack)
 {
-	struct adapter *adap = netdev2adap(x->xso.dev);
+	struct adapter *adap = netdev2adap(dev);
 	int ret;
 
 	if (!mutex_trylock(&uld_mutex)) {
@@ -6494,7 +6495,8 @@ static int cxgb4_xfrm_add_state(struct xfrm_state *x,
 	if (ret)
 		goto out_unlock;
 
-	ret = adap->uld[CXGB4_ULD_IPSEC].xfrmdev_ops->xdo_dev_state_add(x, extack);
+	ret = adap->uld[CXGB4_ULD_IPSEC].xfrmdev_ops->xdo_dev_state_add(dev, x,
+									extack);
 
 out_unlock:
 	mutex_unlock(&uld_mutex);
@@ -6502,9 +6504,9 @@ static int cxgb4_xfrm_add_state(struct xfrm_state *x,
 	return ret;
 }
 
-static void cxgb4_xfrm_del_state(struct xfrm_state *x)
+static void cxgb4_xfrm_del_state(struct net_device *dev, struct xfrm_state *x)
 {
-	struct adapter *adap = netdev2adap(x->xso.dev);
+	struct adapter *adap = netdev2adap(dev);
 
 	if (!mutex_trylock(&uld_mutex)) {
 		dev_dbg(adap->pdev_dev,
@@ -6514,15 +6516,15 @@ static void cxgb4_xfrm_del_state(struct xfrm_state *x)
 	if (chcr_offload_state(adap, CXGB4_XFRMDEV_OPS))
 		goto out_unlock;
 
-	adap->uld[CXGB4_ULD_IPSEC].xfrmdev_ops->xdo_dev_state_delete(x);
+	adap->uld[CXGB4_ULD_IPSEC].xfrmdev_ops->xdo_dev_state_delete(dev, x);
 
 out_unlock:
 	mutex_unlock(&uld_mutex);
 }
 
-static void cxgb4_xfrm_free_state(struct xfrm_state *x)
+static void cxgb4_xfrm_free_state(struct net_device *dev, struct xfrm_state *x)
 {
-	struct adapter *adap = netdev2adap(x->xso.dev);
+	struct adapter *adap = netdev2adap(dev);
 
 	if (!mutex_trylock(&uld_mutex)) {
 		dev_dbg(adap->pdev_dev,
@@ -6532,7 +6534,7 @@ static void cxgb4_xfrm_free_state(struct xfrm_state *x)
 	if (chcr_offload_state(adap, CXGB4_XFRMDEV_OPS))
 		goto out_unlock;
 
-	adap->uld[CXGB4_ULD_IPSEC].xfrmdev_ops->xdo_dev_state_free(x);
+	adap->uld[CXGB4_ULD_IPSEC].xfrmdev_ops->xdo_dev_state_free(dev, x);
 
 out_unlock:
 	mutex_unlock(&uld_mutex);
diff --git a/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c b/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c
index baba96883f48..ecd9a0bd5e18 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c
@@ -75,9 +75,12 @@ static int ch_ipsec_uld_state_change(void *handle, enum cxgb4_state new_state);
 static int ch_ipsec_xmit(struct sk_buff *skb, struct net_device *dev);
 static void *ch_ipsec_uld_add(const struct cxgb4_lld_info *infop);
 static void ch_ipsec_advance_esn_state(struct xfrm_state *x);
-static void ch_ipsec_xfrm_free_state(struct xfrm_state *x);
-static void ch_ipsec_xfrm_del_state(struct xfrm_state *x);
-static int ch_ipsec_xfrm_add_state(struct xfrm_state *x,
+static void ch_ipsec_xfrm_free_state(struct net_device *dev,
+				     struct xfrm_state *x);
+static void ch_ipsec_xfrm_del_state(struct net_device *dev,
+				    struct xfrm_state *x);
+static int ch_ipsec_xfrm_add_state(struct net_device *dev,
+				   struct xfrm_state *x,
 				   struct netlink_ext_ack *extack);
 
 static const struct xfrmdev_ops ch_ipsec_xfrmdev_ops = {
@@ -223,7 +226,8 @@ static int ch_ipsec_setkey(struct xfrm_state *x,
  * returns 0 on success, negative error if failed to send message to FPGA
  * positive error if FPGA returned a bad response
  */
-static int ch_ipsec_xfrm_add_state(struct xfrm_state *x,
+static int ch_ipsec_xfrm_add_state(struct net_device *dev,
+				   struct xfrm_state *x,
 				   struct netlink_ext_ack *extack)
 {
 	struct ipsec_sa_entry *sa_entry;
@@ -302,14 +306,16 @@ static int ch_ipsec_xfrm_add_state(struct xfrm_state *x,
 	return res;
 }
 
-static void ch_ipsec_xfrm_del_state(struct xfrm_state *x)
+static void ch_ipsec_xfrm_del_state(struct net_device *dev,
+				    struct xfrm_state *x)
 {
 	/* do nothing */
 	if (!x->xso.offload_handle)
 		return;
 }
 
-static void ch_ipsec_xfrm_free_state(struct xfrm_state *x)
+static void ch_ipsec_xfrm_free_state(struct net_device *dev,
+				     struct xfrm_state *x)
 {
 	struct ipsec_sa_entry *sa_entry;
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index 07ea1954a276..796e90d741f0 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -9,7 +9,7 @@
 #define IXGBE_IPSEC_KEY_BITS  160
 static const char aes_gcm_name[] = "rfc4106(gcm(aes))";
 
-static void ixgbe_ipsec_del_sa(struct xfrm_state *xs);
+static void ixgbe_ipsec_del_sa(struct net_device *dev, struct xfrm_state *xs);
 
 /**
  * ixgbe_ipsec_set_tx_sa - set the Tx SA registers
@@ -321,7 +321,7 @@ void ixgbe_ipsec_restore(struct ixgbe_adapter *adapter)
 
 		if (r->used) {
 			if (r->mode & IXGBE_RXTXMOD_VF)
-				ixgbe_ipsec_del_sa(r->xs);
+				ixgbe_ipsec_del_sa(adapter->netdev, r->xs);
 			else
 				ixgbe_ipsec_set_rx_sa(hw, i, r->xs->id.spi,
 						      r->key, r->salt,
@@ -330,7 +330,7 @@ void ixgbe_ipsec_restore(struct ixgbe_adapter *adapter)
 
 		if (t->used) {
 			if (t->mode & IXGBE_RXTXMOD_VF)
-				ixgbe_ipsec_del_sa(t->xs);
+				ixgbe_ipsec_del_sa(adapter->netdev, t->xs);
 			else
 				ixgbe_ipsec_set_tx_sa(hw, i, t->key, t->salt);
 		}
@@ -417,6 +417,7 @@ static struct xfrm_state *ixgbe_ipsec_find_rx_state(struct ixgbe_ipsec *ipsec,
 
 /**
  * ixgbe_ipsec_parse_proto_keys - find the key and salt based on the protocol
+ * @dev: pointer to net device
  * @xs: pointer to xfrm_state struct
  * @mykey: pointer to key array to populate
  * @mysalt: pointer to salt value to populate
@@ -424,10 +425,10 @@ static struct xfrm_state *ixgbe_ipsec_find_rx_state(struct ixgbe_ipsec *ipsec,
  * This copies the protocol keys and salt to our own data tables.  The
  * 82599 family only supports the one algorithm.
  **/
-static int ixgbe_ipsec_parse_proto_keys(struct xfrm_state *xs,
+static int ixgbe_ipsec_parse_proto_keys(struct net_device *dev,
+					struct xfrm_state *xs,
 					u32 *mykey, u32 *mysalt)
 {
-	struct net_device *dev = xs->xso.real_dev;
 	unsigned char *key_data;
 	char *alg_name = NULL;
 	int key_len;
@@ -473,11 +474,12 @@ static int ixgbe_ipsec_parse_proto_keys(struct xfrm_state *xs,
 
 /**
  * ixgbe_ipsec_check_mgmt_ip - make sure there is no clash with mgmt IP filters
+ * @dev: pointer to net device
  * @xs: pointer to transformer state struct
  **/
-static int ixgbe_ipsec_check_mgmt_ip(struct xfrm_state *xs)
+static int ixgbe_ipsec_check_mgmt_ip(struct net_device *dev,
+				     struct xfrm_state *xs)
 {
-	struct net_device *dev = xs->xso.real_dev;
 	struct ixgbe_adapter *adapter = netdev_priv(dev);
 	struct ixgbe_hw *hw = &adapter->hw;
 	u32 mfval, manc, reg;
@@ -556,13 +558,14 @@ static int ixgbe_ipsec_check_mgmt_ip(struct xfrm_state *xs)
 
 /**
  * ixgbe_ipsec_add_sa - program device with a security association
+ * @dev: pointer to device to program
  * @xs: pointer to transformer state struct
  * @extack: extack point to fill failure reason
  **/
-static int ixgbe_ipsec_add_sa(struct xfrm_state *xs,
+static int ixgbe_ipsec_add_sa(struct net_device *dev,
+			      struct xfrm_state *xs,
 			      struct netlink_ext_ack *extack)
 {
-	struct net_device *dev = xs->xso.real_dev;
 	struct ixgbe_adapter *adapter = netdev_priv(dev);
 	struct ixgbe_ipsec *ipsec = adapter->ipsec;
 	struct ixgbe_hw *hw = &adapter->hw;
@@ -581,7 +584,7 @@ static int ixgbe_ipsec_add_sa(struct xfrm_state *xs,
 		return -EINVAL;
 	}
 
-	if (ixgbe_ipsec_check_mgmt_ip(xs)) {
+	if (ixgbe_ipsec_check_mgmt_ip(dev, xs)) {
 		NL_SET_ERR_MSG_MOD(extack, "IPsec IP addr clash with mgmt filters");
 		return -EINVAL;
 	}
@@ -615,7 +618,7 @@ static int ixgbe_ipsec_add_sa(struct xfrm_state *xs,
 			rsa.decrypt = xs->ealg || xs->aead;
 
 		/* get the key and salt */
-		ret = ixgbe_ipsec_parse_proto_keys(xs, rsa.key, &rsa.salt);
+		ret = ixgbe_ipsec_parse_proto_keys(dev, xs, rsa.key, &rsa.salt);
 		if (ret) {
 			NL_SET_ERR_MSG_MOD(extack, "Failed to get key data for Rx SA table");
 			return ret;
@@ -724,7 +727,7 @@ static int ixgbe_ipsec_add_sa(struct xfrm_state *xs,
 		if (xs->id.proto & IPPROTO_ESP)
 			tsa.encrypt = xs->ealg || xs->aead;
 
-		ret = ixgbe_ipsec_parse_proto_keys(xs, tsa.key, &tsa.salt);
+		ret = ixgbe_ipsec_parse_proto_keys(dev, xs, tsa.key, &tsa.salt);
 		if (ret) {
 			NL_SET_ERR_MSG_MOD(extack, "Failed to get key data for Tx SA table");
 			memset(&tsa, 0, sizeof(tsa));
@@ -752,11 +755,11 @@ static int ixgbe_ipsec_add_sa(struct xfrm_state *xs,
 
 /**
  * ixgbe_ipsec_del_sa - clear out this specific SA
+ * @dev: pointer to device to program
  * @xs: pointer to transformer state struct
  **/
-static void ixgbe_ipsec_del_sa(struct xfrm_state *xs)
+static void ixgbe_ipsec_del_sa(struct net_device *dev, struct xfrm_state *xs)
 {
-	struct net_device *dev = xs->xso.real_dev;
 	struct ixgbe_adapter *adapter = netdev_priv(dev);
 	struct ixgbe_ipsec *ipsec = adapter->ipsec;
 	struct ixgbe_hw *hw = &adapter->hw;
@@ -841,7 +844,8 @@ void ixgbe_ipsec_vf_clear(struct ixgbe_adapter *adapter, u32 vf)
 			continue;
 		if (ipsec->rx_tbl[i].mode & IXGBE_RXTXMOD_VF &&
 		    ipsec->rx_tbl[i].vf == vf)
-			ixgbe_ipsec_del_sa(ipsec->rx_tbl[i].xs);
+			ixgbe_ipsec_del_sa(adapter->netdev,
+					   ipsec->rx_tbl[i].xs);
 	}
 
 	/* search tx sa table */
@@ -850,7 +854,8 @@ void ixgbe_ipsec_vf_clear(struct ixgbe_adapter *adapter, u32 vf)
 			continue;
 		if (ipsec->tx_tbl[i].mode & IXGBE_RXTXMOD_VF &&
 		    ipsec->tx_tbl[i].vf == vf)
-			ixgbe_ipsec_del_sa(ipsec->tx_tbl[i].xs);
+			ixgbe_ipsec_del_sa(adapter->netdev,
+					   ipsec->tx_tbl[i].xs);
 	}
 }
 
@@ -930,7 +935,7 @@ int ixgbe_ipsec_vf_add_sa(struct ixgbe_adapter *adapter, u32 *msgbuf, u32 vf)
 	memcpy(xs->aead->alg_name, aes_gcm_name, sizeof(aes_gcm_name));
 
 	/* set up the HW offload */
-	err = ixgbe_ipsec_add_sa(xs, NULL);
+	err = ixgbe_ipsec_add_sa(adapter->netdev, xs, NULL);
 	if (err)
 		goto err_aead;
 
@@ -1034,7 +1039,7 @@ int ixgbe_ipsec_vf_del_sa(struct ixgbe_adapter *adapter, u32 *msgbuf, u32 vf)
 		xs = ipsec->tx_tbl[sa_idx].xs;
 	}
 
-	ixgbe_ipsec_del_sa(xs);
+	ixgbe_ipsec_del_sa(adapter->netdev, xs);
 
 	/* remove the xs that was made-up in the add request */
 	kfree_sensitive(xs);
diff --git a/drivers/net/ethernet/intel/ixgbevf/ipsec.c b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
index 8ba037e3d9c2..65580b9cb06f 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
@@ -201,6 +201,7 @@ struct xfrm_state *ixgbevf_ipsec_find_rx_state(struct ixgbevf_ipsec *ipsec,
 
 /**
  * ixgbevf_ipsec_parse_proto_keys - find the key and salt based on the protocol
+ * @dev: pointer to net device to program
  * @xs: pointer to xfrm_state struct
  * @mykey: pointer to key array to populate
  * @mysalt: pointer to salt value to populate
@@ -208,10 +209,10 @@ struct xfrm_state *ixgbevf_ipsec_find_rx_state(struct ixgbevf_ipsec *ipsec,
  * This copies the protocol keys and salt to our own data tables.  The
  * 82599 family only supports the one algorithm.
  **/
-static int ixgbevf_ipsec_parse_proto_keys(struct xfrm_state *xs,
+static int ixgbevf_ipsec_parse_proto_keys(struct net_device *dev,
+					  struct xfrm_state *xs,
 					  u32 *mykey, u32 *mysalt)
 {
-	struct net_device *dev = xs->xso.real_dev;
 	unsigned char *key_data;
 	char *alg_name = NULL;
 	int key_len;
@@ -256,13 +257,14 @@ static int ixgbevf_ipsec_parse_proto_keys(struct xfrm_state *xs,
 
 /**
  * ixgbevf_ipsec_add_sa - program device with a security association
+ * @dev: pointer to net device to program
  * @xs: pointer to transformer state struct
  * @extack: extack point to fill failure reason
  **/
-static int ixgbevf_ipsec_add_sa(struct xfrm_state *xs,
+static int ixgbevf_ipsec_add_sa(struct net_device *dev,
+				struct xfrm_state *xs,
 				struct netlink_ext_ack *extack)
 {
-	struct net_device *dev = xs->xso.real_dev;
 	struct ixgbevf_adapter *adapter;
 	struct ixgbevf_ipsec *ipsec;
 	u16 sa_idx;
@@ -310,7 +312,8 @@ static int ixgbevf_ipsec_add_sa(struct xfrm_state *xs,
 			rsa.decrypt = xs->ealg || xs->aead;
 
 		/* get the key and salt */
-		ret = ixgbevf_ipsec_parse_proto_keys(xs, rsa.key, &rsa.salt);
+		ret = ixgbevf_ipsec_parse_proto_keys(dev, xs, rsa.key,
+						     &rsa.salt);
 		if (ret) {
 			NL_SET_ERR_MSG_MOD(extack, "Failed to get key data for Rx SA table");
 			return ret;
@@ -363,7 +366,8 @@ static int ixgbevf_ipsec_add_sa(struct xfrm_state *xs,
 		if (xs->id.proto & IPPROTO_ESP)
 			tsa.encrypt = xs->ealg || xs->aead;
 
-		ret = ixgbevf_ipsec_parse_proto_keys(xs, tsa.key, &tsa.salt);
+		ret = ixgbevf_ipsec_parse_proto_keys(dev, xs, tsa.key,
+						     &tsa.salt);
 		if (ret) {
 			NL_SET_ERR_MSG_MOD(extack, "Failed to get key data for Tx SA table");
 			memset(&tsa, 0, sizeof(tsa));
@@ -388,11 +392,12 @@ static int ixgbevf_ipsec_add_sa(struct xfrm_state *xs,
 
 /**
  * ixgbevf_ipsec_del_sa - clear out this specific SA
+ * @dev: pointer to net device to program
  * @xs: pointer to transformer state struct
  **/
-static void ixgbevf_ipsec_del_sa(struct xfrm_state *xs)
+static void ixgbevf_ipsec_del_sa(struct net_device *dev,
+				 struct xfrm_state *xs)
 {
-	struct net_device *dev = xs->xso.real_dev;
 	struct ixgbevf_adapter *adapter;
 	struct ixgbevf_ipsec *ipsec;
 	u16 sa_idx;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
index fc59e50bafce..a6500e3673f2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
@@ -663,10 +663,10 @@ static int cn10k_ipsec_inb_add_state(struct xfrm_state *x,
 	return -EOPNOTSUPP;
 }
 
-static int cn10k_ipsec_outb_add_state(struct xfrm_state *x,
+static int cn10k_ipsec_outb_add_state(struct net_device *dev,
+				      struct xfrm_state *x,
 				      struct netlink_ext_ack *extack)
 {
-	struct net_device *netdev = x->xso.dev;
 	struct cn10k_tx_sa_s *sa_entry;
 	struct qmem *sa_info;
 	struct otx2_nic *pf;
@@ -676,7 +676,7 @@ static int cn10k_ipsec_outb_add_state(struct xfrm_state *x,
 	if (err)
 		return err;
 
-	pf = netdev_priv(netdev);
+	pf = netdev_priv(dev);
 
 	err = qmem_alloc(pf->dev, &sa_info, pf->ipsec.sa_size, OTX2_ALIGN);
 	if (err)
@@ -700,18 +700,18 @@ static int cn10k_ipsec_outb_add_state(struct xfrm_state *x,
 	return 0;
 }
 
-static int cn10k_ipsec_add_state(struct xfrm_state *x,
+static int cn10k_ipsec_add_state(struct net_device *dev,
+				 struct xfrm_state *x,
 				 struct netlink_ext_ack *extack)
 {
 	if (x->xso.dir == XFRM_DEV_OFFLOAD_IN)
 		return cn10k_ipsec_inb_add_state(x, extack);
 	else
-		return cn10k_ipsec_outb_add_state(x, extack);
+		return cn10k_ipsec_outb_add_state(dev, x, extack);
 }
 
-static void cn10k_ipsec_del_state(struct xfrm_state *x)
+static void cn10k_ipsec_del_state(struct net_device *dev, struct xfrm_state *x)
 {
-	struct net_device *netdev = x->xso.dev;
 	struct cn10k_tx_sa_s *sa_entry;
 	struct qmem *sa_info;
 	struct otx2_nic *pf;
@@ -720,7 +720,7 @@ static void cn10k_ipsec_del_state(struct xfrm_state *x)
 	if (x->xso.dir == XFRM_DEV_OFFLOAD_IN)
 		return;
 
-	pf = netdev_priv(netdev);
+	pf = netdev_priv(dev);
 
 	sa_info = (struct qmem *)x->xso.offload_handle;
 	sa_entry = (struct cn10k_tx_sa_s *)sa_info->base;
@@ -732,7 +732,7 @@ static void cn10k_ipsec_del_state(struct xfrm_state *x)
 
 	err = cn10k_outb_write_sa(pf, sa_info);
 	if (err)
-		netdev_err(netdev, "Error (%d) deleting SA\n", err);
+		netdev_err(dev, "Error (%d) deleting SA\n", err);
 
 	x->xso.offload_handle = 0;
 	qmem_free(pf->dev, sa_info);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 0dfbbe21936f..77f61cd28a79 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -689,17 +689,17 @@ static int mlx5e_ipsec_create_dwork(struct mlx5e_ipsec_sa_entry *sa_entry)
 	return 0;
 }
 
-static int mlx5e_xfrm_add_state(struct xfrm_state *x,
+static int mlx5e_xfrm_add_state(struct net_device *dev,
+				struct xfrm_state *x,
 				struct netlink_ext_ack *extack)
 {
 	struct mlx5e_ipsec_sa_entry *sa_entry = NULL;
-	struct net_device *netdev = x->xso.real_dev;
 	struct mlx5e_ipsec *ipsec;
 	struct mlx5e_priv *priv;
 	gfp_t gfp;
 	int err;
 
-	priv = netdev_priv(netdev);
+	priv = netdev_priv(dev);
 	if (!priv->ipsec)
 		return -EOPNOTSUPP;
 
@@ -710,7 +710,7 @@ static int mlx5e_xfrm_add_state(struct xfrm_state *x,
 		return -ENOMEM;
 
 	sa_entry->x = x;
-	sa_entry->dev = netdev;
+	sa_entry->dev = dev;
 	sa_entry->ipsec = ipsec;
 	/* Check if this SA is originated from acquire flow temporary SA */
 	if (x->xso.flags & XFRM_DEV_OFFLOAD_FLAG_ACQ)
@@ -807,7 +807,7 @@ static int mlx5e_xfrm_add_state(struct xfrm_state *x,
 	return err;
 }
 
-static void mlx5e_xfrm_del_state(struct xfrm_state *x)
+static void mlx5e_xfrm_del_state(struct net_device *dev, struct xfrm_state *x)
 {
 	struct mlx5e_ipsec_sa_entry *sa_entry = to_ipsec_sa_entry(x);
 	struct mlx5e_ipsec *ipsec = sa_entry->ipsec;
@@ -820,7 +820,7 @@ static void mlx5e_xfrm_del_state(struct xfrm_state *x)
 	WARN_ON(old != sa_entry);
 }
 
-static void mlx5e_xfrm_free_state(struct xfrm_state *x)
+static void mlx5e_xfrm_free_state(struct net_device *dev, struct xfrm_state *x)
 {
 	struct mlx5e_ipsec_sa_entry *sa_entry = to_ipsec_sa_entry(x);
 	struct mlx5e_ipsec *ipsec = sa_entry->ipsec;
diff --git a/drivers/net/ethernet/netronome/nfp/crypto/ipsec.c b/drivers/net/ethernet/netronome/nfp/crypto/ipsec.c
index 671af5d4c5d2..9e7c285eaa6b 100644
--- a/drivers/net/ethernet/netronome/nfp/crypto/ipsec.c
+++ b/drivers/net/ethernet/netronome/nfp/crypto/ipsec.c
@@ -266,17 +266,17 @@ static void set_sha2_512hmac(struct nfp_ipsec_cfg_add_sa *cfg, int *trunc_len)
 	}
 }
 
-static int nfp_net_xfrm_add_state(struct xfrm_state *x,
+static int nfp_net_xfrm_add_state(struct net_device *dev,
+				  struct xfrm_state *x,
 				  struct netlink_ext_ack *extack)
 {
-	struct net_device *netdev = x->xso.real_dev;
 	struct nfp_ipsec_cfg_mssg msg = {};
 	int i, key_len, trunc_len, err = 0;
 	struct nfp_ipsec_cfg_add_sa *cfg;
 	struct nfp_net *nn;
 	unsigned int saidx;
 
-	nn = netdev_priv(netdev);
+	nn = netdev_priv(dev);
 	cfg = &msg.cfg_add_sa;
 
 	/* General */
@@ -546,17 +546,16 @@ static int nfp_net_xfrm_add_state(struct xfrm_state *x,
 	return 0;
 }
 
-static void nfp_net_xfrm_del_state(struct xfrm_state *x)
+static void nfp_net_xfrm_del_state(struct net_device *dev, struct xfrm_state *x)
 {
 	struct nfp_ipsec_cfg_mssg msg = {
 		.cmd = NFP_IPSEC_CFG_MSSG_INV_SA,
 		.sa_idx = x->xso.offload_handle - 1,
 	};
-	struct net_device *netdev = x->xso.real_dev;
 	struct nfp_net *nn;
 	int err;
 
-	nn = netdev_priv(netdev);
+	nn = netdev_priv(dev);
 	err = nfp_net_sched_mbox_amsg_work(nn, NFP_NET_CFG_MBOX_CMD_IPSEC, &msg,
 					   sizeof(msg), nfp_net_ipsec_cfg);
 	if (err)
diff --git a/drivers/net/netdevsim/ipsec.c b/drivers/net/netdevsim/ipsec.c
index d88bdb9a1717..47cdee5577d4 100644
--- a/drivers/net/netdevsim/ipsec.c
+++ b/drivers/net/netdevsim/ipsec.c
@@ -85,11 +85,11 @@ static int nsim_ipsec_find_empty_idx(struct nsim_ipsec *ipsec)
 	return -ENOSPC;
 }
 
-static int nsim_ipsec_parse_proto_keys(struct xfrm_state *xs,
+static int nsim_ipsec_parse_proto_keys(struct net_device *dev,
+				       struct xfrm_state *xs,
 				       u32 *mykey, u32 *mysalt)
 {
 	const char aes_gcm_name[] = "rfc4106(gcm(aes))";
-	struct net_device *dev = xs->xso.real_dev;
 	unsigned char *key_data;
 	char *alg_name = NULL;
 	int key_len;
@@ -129,17 +129,16 @@ static int nsim_ipsec_parse_proto_keys(struct xfrm_state *xs,
 	return 0;
 }
 
-static int nsim_ipsec_add_sa(struct xfrm_state *xs,
+static int nsim_ipsec_add_sa(struct net_device *dev,
+			     struct xfrm_state *xs,
 			     struct netlink_ext_ack *extack)
 {
 	struct nsim_ipsec *ipsec;
-	struct net_device *dev;
 	struct netdevsim *ns;
 	struct nsim_sa sa;
 	u16 sa_idx;
 	int ret;
 
-	dev = xs->xso.real_dev;
 	ns = netdev_priv(dev);
 	ipsec = &ns->ipsec;
 
@@ -174,7 +173,7 @@ static int nsim_ipsec_add_sa(struct xfrm_state *xs,
 		sa.crypt = xs->ealg || xs->aead;
 
 	/* get the key and salt */
-	ret = nsim_ipsec_parse_proto_keys(xs, sa.key, &sa.salt);
+	ret = nsim_ipsec_parse_proto_keys(dev, xs, sa.key, &sa.salt);
 	if (ret) {
 		NL_SET_ERR_MSG_MOD(extack, "Failed to get key data for SA table");
 		return ret;
@@ -200,9 +199,9 @@ static int nsim_ipsec_add_sa(struct xfrm_state *xs,
 	return 0;
 }
 
-static void nsim_ipsec_del_sa(struct xfrm_state *xs)
+static void nsim_ipsec_del_sa(struct net_device *dev, struct xfrm_state *xs)
 {
-	struct netdevsim *ns = netdev_priv(xs->xso.real_dev);
+	struct netdevsim *ns = netdev_priv(dev);
 	struct nsim_ipsec *ipsec = &ns->ipsec;
 	u16 sa_idx;
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index cf3b6445817b..4dd07aaa2649 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1012,9 +1012,13 @@ struct netdev_bpf {
 
 #ifdef CONFIG_XFRM_OFFLOAD
 struct xfrmdev_ops {
-	int	(*xdo_dev_state_add) (struct xfrm_state *x, struct netlink_ext_ack *extack);
-	void	(*xdo_dev_state_delete) (struct xfrm_state *x);
-	void	(*xdo_dev_state_free) (struct xfrm_state *x);
+	int	(*xdo_dev_state_add)(struct net_device *dev,
+				     struct xfrm_state *x,
+				     struct netlink_ext_ack *extack);
+	void	(*xdo_dev_state_delete)(struct net_device *dev,
+					struct xfrm_state *x);
+	void	(*xdo_dev_state_free)(struct net_device *dev,
+				      struct xfrm_state *x);
 	bool	(*xdo_dev_offload_ok) (struct sk_buff *skb,
 				       struct xfrm_state *x);
 	void	(*xdo_dev_state_advance_esn) (struct xfrm_state *x);
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 39365fd2ea17..3d2f6c879311 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -147,8 +147,16 @@ enum {
 };
 
 struct xfrm_dev_offload {
+	/* The device for this offload.
+	 * Device drivers should not use this directly, as that will prevent
+	 * them from working with bonding device. Instead, the device passed
+	 * to the add/delete callbacks should be used.
+	 */
 	struct net_device	*dev;
 	netdevice_tracker	dev_tracker;
+	/* This is a private pointer used by the bonding driver.
+	 * Device drivers should not use it.
+	 */
 	struct net_device	*real_dev;
 	unsigned long		offload_handle;
 	u8			dir : 2;
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 0be5f7ffd019..3be0139373f7 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -309,7 +309,6 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 
 	xso->dev = dev;
 	netdev_tracker_alloc(dev, &xso->dev_tracker, GFP_ATOMIC);
-	xso->real_dev = dev;
 
 	if (xuo->flags & XFRM_OFFLOAD_INBOUND)
 		xso->dir = XFRM_DEV_OFFLOAD_IN;
@@ -321,11 +320,10 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 	else
 		xso->type = XFRM_DEV_OFFLOAD_CRYPTO;
 
-	err = dev->xfrmdev_ops->xdo_dev_state_add(x, extack);
+	err = dev->xfrmdev_ops->xdo_dev_state_add(dev, x, extack);
 	if (err) {
 		xso->dev = NULL;
 		xso->dir = 0;
-		xso->real_dev = NULL;
 		netdev_put(dev, &xso->dev_tracker);
 		xso->type = XFRM_DEV_OFFLOAD_UNSPECIFIED;
 
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 33d1f5679e8b..e9b6e25508f6 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -767,7 +767,7 @@ void xfrm_dev_state_delete(struct xfrm_state *x)
 	struct net_device *dev = READ_ONCE(xso->dev);
 
 	if (dev) {
-		dev->xfrmdev_ops->xdo_dev_state_delete(x);
+		dev->xfrmdev_ops->xdo_dev_state_delete(dev, x);
 		spin_lock_bh(&xfrm_state_dev_gc_lock);
 		hlist_add_head(&x->dev_gclist, &xfrm_state_dev_gc_list);
 		spin_unlock_bh(&xfrm_state_dev_gc_lock);
@@ -789,7 +789,7 @@ void xfrm_dev_state_free(struct xfrm_state *x)
 		spin_unlock_bh(&xfrm_state_dev_gc_lock);
 
 		if (dev->xfrmdev_ops->xdo_dev_state_free)
-			dev->xfrmdev_ops->xdo_dev_state_free(x);
+			dev->xfrmdev_ops->xdo_dev_state_free(dev, x);
 		WRITE_ONCE(xso->dev, NULL);
 		xso->type = XFRM_DEV_OFFLOAD_UNSPECIFIED;
 		netdev_put(dev, &xso->dev_tracker);
@@ -1551,16 +1551,18 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 		if (pol->xdo.type == XFRM_DEV_OFFLOAD_PACKET) {
 			struct xfrm_dev_offload *xdo = &pol->xdo;
 			struct xfrm_dev_offload *xso = &x->xso;
+			struct net_device *dev = xdo->dev;
 
 			xso->type = XFRM_DEV_OFFLOAD_PACKET;
 			xso->dir = xdo->dir;
-			xso->dev = xdo->dev;
+			xso->dev = dev;
 			xso->flags = XFRM_DEV_OFFLOAD_FLAG_ACQ;
-			netdev_hold(xso->dev, &xso->dev_tracker, GFP_ATOMIC);
-			error = xso->dev->xfrmdev_ops->xdo_dev_state_add(x, NULL);
+			netdev_hold(dev, &xso->dev_tracker, GFP_ATOMIC);
+			error = dev->xfrmdev_ops->xdo_dev_state_add(dev, x,
+								    NULL);
 			if (error) {
 				xso->dir = 0;
-				netdev_put(xso->dev, &xso->dev_tracker);
+				netdev_put(dev, &xso->dev_tracker);
 				xso->dev = NULL;
 				xso->type = XFRM_DEV_OFFLOAD_UNSPECIFIED;
 				x->km.state = XFRM_STATE_DEAD;
-- 
2.45.0


