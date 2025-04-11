Return-Path: <linux-kselftest+bounces-30525-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B9CA855DB
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36E527B4516
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 07:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B68528FFEA;
	Fri, 11 Apr 2025 07:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PtefoDzz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C127D27D796;
	Fri, 11 Apr 2025 07:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744357845; cv=fail; b=Zh+QCnMWGVFCsVprUF77oahMoipV4tMVrDRNrUoKWZZUOO4iZfrg+g9pvQ/6rHfQnpnbix/twatvbAoVKRek3BXz0qoUXTF03a2pUub8yEpxK51ePKSxwTHMh4klVFK9Q+jBBdjlCaUpyQ809FHWWAjOkxWaO7wQh1zcBJOdPnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744357845; c=relaxed/simple;
	bh=E7YAMbh4rhcCrP8GqyO5BHfECff1nYTF5Hqcd6c1fFw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ph/9+/o3Jz/sxpQuqa0rDp/ZPqcZDJd+Kajgab/Eii4xYdmfmoa+MsUl6hew4r1NeXnhFm6uDW8lANO4clGKGoR3Kks4t3TQI6A7dEC3ZCpFn4XN4FsZ4T3aw02UTR5DnXuOP5TEqHmFxNTiOPZBN5g9VIWxURI1xV1wougWABo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PtefoDzz; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=soSbYujKPmHPEgN0F3fDfZpP/tq8i8bc9T6AvpeDeUtz2Q6aMIcDUhQIQasbpd0IOeWQbAifm+mBkKefdWvgNer2AcqvA67iG0AjVbATHO0fs9J/g5vgsXRoF/rXNUprU9I90d+nT+rjmoqi7KDsPZO7cQDSGlo13ttw4ztrpjpUJnkdp+Vtn5xJq0ziW0Rug0defHrhDDJnitj0ONbCPEw+AW0bR54Mg2INQafWCLD2JEfqmQJyguXUqXiYb45ziX5tidmGFcS9f5aB+ulfcPtEdtmwJOL7QUIWLXjVlJVZpuD4n+i4YMOyJHslFdD9BwHci0KGC5TuI7qe5bwSIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JeP0oeFT1V1YZfI0RbwA8wpecEhr06zGkLkr7cOahY8=;
 b=h3enhx+euIVM6jKX9hA/d3YlrU1o/L2gPHMZlGkO3nP0k/XFeOTTBDnuJx4pWbOygCLwyr/CDJx8vtvL6tK/3rNm/fNsaw+ICEItGd4BJaAY7sL6kyiUGlxTzYCm+AAQlK7UaJLEJdfkcPrLa7fM4aISx1Ucu2WYjp6VCB1Rglk8vn60ZfUXnNRkK5z/CN7cwlELF2kHydwXSS1wTsZg8JLQ6iHJBe1xz+VY5wS11kJScl6eYW8dJfsher8MszmuV+z9PN8VLUWLHXGNUwMTEIY/0q572LzTueKXQeplUtruvSnKJXMyVIsSG8CxZrYAaFta0qsJ4bogOwfbZGOVjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JeP0oeFT1V1YZfI0RbwA8wpecEhr06zGkLkr7cOahY8=;
 b=PtefoDzzQW8vKt914gl2M2ue8h3IECUERl9AQxC/jj0kO4fPU6aKYoh/E+Fuqb+lCmZErU25rqOOwlVrDE2SGYrjpuecB6Ig06b89g9g/TnAlRLpzxD1evtUKzVqpL7fMK8JNHwELuTenr6LoPu+6OVjIp11RHsVxt7FwFZFuDMK42PTP/LzsZcSwIcIRnaK/AAPBq0OAct3gd6FZroADKsS1s6LGhHGWOL/lugmIu6nfbgKQjUORpGArudgMmZR/5eR8EylFDRPCXsK/crm6JWubDTS/ylYJS0mmZWBXCWOf2X18wZsfszz4qzeKXibvfh8BY/noOZeSZrDgEpubw==
Received: from SN6PR08CA0014.namprd08.prod.outlook.com (2603:10b6:805:66::27)
 by LV2PR12MB5847.namprd12.prod.outlook.com (2603:10b6:408:174::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Fri, 11 Apr
 2025 07:50:41 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:805:66:cafe::fb) by SN6PR08CA0014.outlook.office365.com
 (2603:10b6:805:66::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 07:50:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 07:50:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 11 Apr
 2025 00:50:28 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 11 Apr 2025 00:50:22 -0700
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
Subject: [PATCH net-next v3 2/6] xfrm: Use xdo.dev instead of xdo.real_dev
Date: Fri, 11 Apr 2025 10:49:54 +0300
Message-ID: <20250411074958.2858496-3-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|LV2PR12MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: e0c7acc4-5931-4efc-9f58-08dd78cd8e8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uyTqvCfRo3uEI5zKoUX1eohlG7tYFiNpNrI/k+Sf0SjEDGvg/ztvIp2H/IqA?=
 =?us-ascii?Q?TlWz2HvCzPmrlBDeX6HiHI1zuaHAShUI/Ig+MAzHuG0jlVjke8N3U67IOW2i?=
 =?us-ascii?Q?rENiUkWBRQsb922DSpfwIp6ohvDxP7qQ4dW9dBCNNWYLxbgLdcM9npm4fQYG?=
 =?us-ascii?Q?akJXe7AtkNz9WH4dQbts8K6yAzZ6rdQHi3Q4ZkSOE85Xn2FiGpnR948KGGRZ?=
 =?us-ascii?Q?Z3Zz/yFE/leiFLMe/GWfywFe4FBCBeFAiitYG32epE8gcqfO3HTvIMLOXhAX?=
 =?us-ascii?Q?OFOZlcR61bEcxRjPascA21i9zZV72RbAkKI8jFwl9DomRFJP1aqU9E44LQSB?=
 =?us-ascii?Q?GyoV++hIv0D5GkDFQ0iSFJQSGXFVJQp/gfHLER90uOea/MGquWg+NJY+kZw2?=
 =?us-ascii?Q?BShnIgzRVgSmBw1W5yalim4uaFCak/aGTzliBk3uoD/Y0hm4pr8Nzz2zQGzr?=
 =?us-ascii?Q?trvIS21+wpfOP529UCdNXZbPewuhagI9x1wWWy9JAr4GoLURgR23nytX/gw1?=
 =?us-ascii?Q?w2PgsRR5ryVClUIGrTx0wmgGwVEVu+4D8s16QF8Jlvo7zOguaZfPIa/p1x5U?=
 =?us-ascii?Q?5XOE6trMOPCdoNatq69rrk9Q4ZXXKF8OTJJgzLu+ney+xkPYTBlICfj8zOCm?=
 =?us-ascii?Q?1fQWyTEuaRecVc9rtwHLnER2e4CCv8eijs5p8InN7KSemDa6UYBzdhbS/hh/?=
 =?us-ascii?Q?o0Ir5CxuTbmtH6gfVZZswKuKEqo7KLQSZvZ2xt0rHn2wo7i9t2dZtR2Eg40g?=
 =?us-ascii?Q?tgbomSSrlZD9oaHf/TycTFq3wh7CjyErjGnJ/wR96XqkaZFVujJvOHSYFPfq?=
 =?us-ascii?Q?kWGcHMYUWvtBFNVMgx8T8n6euNXbfLGdomkABxCrUX8JIRmS/DXrdXuA6uS5?=
 =?us-ascii?Q?IqoSRFeV308emF/LHtiFzbWB9WTXeMEUNWlXOcJlx8p9YDAvZRAoBBH9PVXI?=
 =?us-ascii?Q?ZM2AxyZXeAe+5kxhCA21kIr2f94PMGI+/gG0T5JltjVh8X0Zg9Y3jXpyMFJt?=
 =?us-ascii?Q?H5qJQCkl6duqdUHAatTOaU82QgmZtsDPz9xMKJFUju4AeAxf2MjUB+dGwp4F?=
 =?us-ascii?Q?c1dYdxze/388RfHiadULoOTPQj/7VW0fK1w18x8t9atjZV/HT7+JJVgapj32?=
 =?us-ascii?Q?lrHIS5uXbAcjBeoppT6dR5Gv9G83bARws+Acq4ZJxm1GN7w65nm6TzetJp8i?=
 =?us-ascii?Q?dMr0TWtn40iF/2fBhhlMuIdbVlSzX6SOh+DX0QMk6bsBmEciCUtb8cKC6nSS?=
 =?us-ascii?Q?0ywSMGeB80I51vS+oNMkNEE16NkFFKt0R+IQVda4G9H/hjOfBwrntcS0kpKo?=
 =?us-ascii?Q?+PqE2+aq9f492ui20esX2BrSlRpH66HyMnC7kConHk3isRjWIP9yAjmUnRt7?=
 =?us-ascii?Q?VuXNj+lY0rxbwzxwMd+etf+ZhClWiRQvy3eCKDnfwDO2r0sa9yUfLoa9GyR0?=
 =?us-ascii?Q?Qc7jA6cAf4o118QDyl2PefO5HdZ+vgs+LgDVw/9gD1yuxIFUDIQYF8pm5ss+?=
 =?us-ascii?Q?Wxi3rPtj9MyUxldt/jcpa6v5SYfjigqLnMaE?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 07:50:40.9590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c7acc4-5931-4efc-9f58-08dd78cd8e8b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5847

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


