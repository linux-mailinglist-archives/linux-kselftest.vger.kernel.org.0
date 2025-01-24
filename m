Return-Path: <linux-kselftest+bounces-25076-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA7DA1B20E
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 09:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867DD16D6ED
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 08:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239CB218ADD;
	Fri, 24 Jan 2025 08:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="luahqCv8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA441DB134;
	Fri, 24 Jan 2025 08:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709105; cv=fail; b=f3BevrBYI6Fklfa2mrX3D0ynfSkZjBnwg5sFz+/gVvwWiO6ZIn6Y4GPY3SD3bqmfTf5olBqld7KNal0DUHIgT2Q9Xto2itcAAfatx05P0a7rJe9O5YXdjEtY6qffAsmlZjPbdhuHK/N/mrHwOCCpSUoPd3e5nhhY1yejh4dC3lM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709105; c=relaxed/simple;
	bh=wDSa0FNd/FuoGoJrcyW9VOOhKcWImqm08jOu1JMBBAU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YAmb9gTJaHQTJQ5ROi9Vu7KWfttKk9ZddRU1J+R7ojya3JMRPM09gXzALvDRmknLSCuVA/MtzEr3bTl1GC3tlW+H2MuODatLUbzyJ7HGKciOP/dP6+EDFxr8loJt+EVkvOajGNVH3sWsGEJQUbQltjOfc9PVXNJ351Ide6pHQKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=luahqCv8; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+zFGbRGo+E6Lgv8CIJsz3KiPxcS76Mp/fomcaOUDK5dzU3cEb4hlRUBvgLe2yjItbYrHGoCxZskFBn9B929g2uBs9AdVZPmao/dRQxtMhxROyYlS2EWrKkdR3Ew74+3/6Nqex2UlQ73K6RfLJJ8pUZFNu98nWFBFnEp1RMaFwvOE1IyTQ2RmLJOW6WZWnYecaBHHtHC9NaaXxV3Bn3QZ3xsIunZxMrNWPRSH1FeQZBaCiekgb4C69kEVKEJroAlkGZMH7x36UhfHwzrQ/KvfKjsyUCbdTi72ILYJJAin2lTEwx3U1l6hoX1VwcrlgdKwi6hhOrtucwRj3KNztVs3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0CQ4c9BN+1qBH8d8JT5Ce48I6s/vWQCUg6BVPk7gEU=;
 b=ZBZk+qxA9tJa9+Y/i13rc71WQxuAAxxFni1gH2ySA7zWHqM3X4Az3hgloVKQgDOAY0Wu/sAFsvoirdh7JdfA/PhMoc5Q+lejCuAP0vl/5l079B798r61rkUKwVedG7Ps/uA2gbN4ERsHaXGvI5iVFkAGJbdgpuEIkyE+vJxGuvkude1dO90ObTSUjyQpxhlTNUROkEJUxaQpbDaIBXgFen2sFJKhW64Z5CEFNaqmwVEFNVqb5G8nqdMxy0j6KSATCQOXBSNerZDG5F9klnbS7bJAOycF3SRhrpiLvOaMYzZ9q2F1vMkC24241YYiTv2otdPgOTsNB6vCyoWvmq4+Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0CQ4c9BN+1qBH8d8JT5Ce48I6s/vWQCUg6BVPk7gEU=;
 b=luahqCv8waazlnJzTyvsZBLY8CXzf9yGS3wzfVXbiwlO0bjBH0msvhOzjVl4ItL8lEl8G5n9njYRX8Wl+NjcBMlQbRcF5czl5f9Oe5Sx+n3bUI8HNa76DgH7yZoSa3TFrxg53tvHVfwzDJc+NZ08bVMl4H+n/ik+Dvtg4zRMzLIuz95AN3rEOQX9XYVta32+bmz/pRBKRSm2XYHAaYlPKcwNUe+eMamY/+4oIucxnwVPrVNHEy5sIuYFzdE7Xm/QyJaRq6Y7Ztt8UbNQnHdLyhybVmEveykGDflakti3JeFSGW1Cd+SmlqqZK11KsqKArwp60yBmMx1rqI5NvU+s0g==
Received: from SJ0PR03CA0138.namprd03.prod.outlook.com (2603:10b6:a03:33c::23)
 by BL3PR12MB6377.namprd12.prod.outlook.com (2603:10b6:208:3b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Fri, 24 Jan
 2025 08:58:19 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::f3) by SJ0PR03CA0138.outlook.office365.com
 (2603:10b6:a03:33c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.18 via Frontend Transport; Fri,
 24 Jan 2025 08:58:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Fri, 24 Jan 2025 08:58:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 24 Jan
 2025 00:58:00 -0800
Received: from hive.mtl.labs.mlnx (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 24 Jan
 2025 00:57:56 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Jay Vosburgh <jv@jvosburgh.net>, Nikolay Aleksandrov
	<razor@blackwall.org>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jianbo Liu
	<jianbol@nvidia.com>, Boris Pismenny <borisp@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, <linux-kselftest@vger.kernel.org>, Hangbin Liu
	<liuhangbin@gmail.com>, Liang Li <liali@redhat.com>, Cosmin Ratiu
	<cratiu@nvidia.com>
Subject: [PATCH net v2] bonding: Correctly support GSO ESP offload
Date: Fri, 24 Jan 2025 10:57:44 +0200
Message-ID: <20250124085744.434869-1-cratiu@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|BL3PR12MB6377:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b0708d4-ceb3-41ad-6230-08dd3c553f64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/HvNAnO8dSDb/VJghK1YDGywMHHzbGv+RdspJ/oNstVFWzdoiIdd8mX/m5m9?=
 =?us-ascii?Q?YbcPZHPB4JRqUKzri8kIpCgWb8i1eYrzIPsXrR7KOjijWiTX+Cz+L6T1KQ2P?=
 =?us-ascii?Q?yLPDd8wSsuCXM27bSSl8qgjIzqt5AW5xSEWa6Tw3Zhug9Crt1clkm+4SpmtC?=
 =?us-ascii?Q?XlQMiGvdnWL2x0SEwPaAfao9tnQLN6psTtHhoo0IPbQTKfUGezXkSO5tom/A?=
 =?us-ascii?Q?QullFdYIOlMTk5epBAQRAL7nLtueCTpCATqZmHlky1sFvo1JRBTwc8AtdVGQ?=
 =?us-ascii?Q?VDh9qOwfFbs7bT3pvxyiMMkjL05gtNgb/9bsM8DKBTJmOqouUyYjD22pT5k2?=
 =?us-ascii?Q?ws3MYQBYu5k3Y95aBHjxnE6sEE7AgDEJAOzw5nZa/M4w+CJCWG9u2vGAmFci?=
 =?us-ascii?Q?q+amiWTE1u/4oc+vtns5RjNyvIpuoRcX3ro+8TNIP842RhBTg6EVHvheTmuY?=
 =?us-ascii?Q?VFbMQngkbhDxvbQSdFJb2LjbFPTd10i0dgO4sxodxGU0LbYIew1eONepVLzW?=
 =?us-ascii?Q?tLVoa+FVO7rz4313j9+yYgImlGPrVPiOza8ZfTd9HtjJLlSAJtJg6ggL7jpk?=
 =?us-ascii?Q?v5obDUDgk+lF6ar6BGCb9X/kSVJdofG3WLVyGzsGbBaifE6foLwyS1IhSTy1?=
 =?us-ascii?Q?ZdAMGn/V/4bgksgpQSf3cwZCm1NkMs+TwR7RgEez6fakpB9+wSOH+EiVVtYH?=
 =?us-ascii?Q?GFiw5nwWnlXHePnuVw24iROtbS0JaGH/0LtUeHLqTUE5t+ZrBlbK9ymoasFo?=
 =?us-ascii?Q?L6Jsq51kDv6GdjnZT5DX6fzxWy2SosO1AaFPCt9+UeqR4q5rXU+NG/g1tdLW?=
 =?us-ascii?Q?t+DBSORXgqQRWy3clauyt+08vNBQWwl7WkFAzftY/Gv9g6fRHLjKjk+aRwTX?=
 =?us-ascii?Q?8pFhr+ewdfsUIg+2Blc+plevXnd6tQ1QjbVZkr0rVQp6uTSWm7wbUDGtfD+z?=
 =?us-ascii?Q?1a9kXWKr01OiVc1X8J3O0j1AVVKUq0H/6dd5B7rypQ3cgSpRLCP/nsIgjksH?=
 =?us-ascii?Q?kKme4Twa1KQxljhCWlXGQzUtLepGRo5cjE4doLtP7gNd9NUWILYTBy2OdF4G?=
 =?us-ascii?Q?+SCvuT0Q2BC/obboi9PCMtECiSWs8zlddB7+l+yIMneceZMphR+djkAD4yef?=
 =?us-ascii?Q?PxgqlrW4mSii2iSaaf0SPEkhM68psRJW+64zZoiuP++CGDTo7c0bl9T7qBj1?=
 =?us-ascii?Q?XRHb7MeQ3h2O+d3JFdSZWJstoYtnW8xbb2ck44g4gUbRNz9wzbwn2peBU9SQ?=
 =?us-ascii?Q?xNJbMjDcMnMA1DW+8xPzILheyt2S00ZgMKfHbxtaDb/BjBS/Iogcbuo8U7rw?=
 =?us-ascii?Q?UPW3x7fsd4sfje3QfPBmLIKlw+/WLVo+b8ijsO3RAWx+AJKM+/cMWnRAUuuH?=
 =?us-ascii?Q?uqobg25wzh88M3be/5QJawfmGKZakuWxavx0lweJB7V8uJ1QSbe+odONHBwM?=
 =?us-ascii?Q?IBx10WWvP688s9ed/H/6a5nL0z7JikAjRgRvWQ4acVEOgfahUfIxyMACvn7N?=
 =?us-ascii?Q?5OBXsAhkWqwRFtc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 08:58:18.8658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0708d4-ceb3-41ad-6230-08dd3c553f64
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6377

The referenced fix is incomplete. It correctly computes
bond_dev->gso_partial_features across slaves, but unfortunately
netdev_fix_features discards gso_partial_features from the feature set
if NETIF_F_GSO_PARTIAL isn't set in bond_dev->features.

This is visible with ethtool -k bond0 | grep esp:
tx-esp-segmentation: off [requested on]
esp-hw-offload: on
esp-tx-csum-hw-offload: on

This patch reworks the bonding GSO offload support by:
- making aggregating gso_partial_features across slaves similar to the
  other feature sets (this part is a no-op).
- advertising the default partial gso features on empty bond devs, same
  as with other feature sets (also a no-op).
- adding NETIF_F_GSO_PARTIAL to hw_enc_features filtered across slaves.
- adding NETIF_F_GSO_PARTIAL to features in bond_setup()

With all of these, 'ethtool -k bond0 | grep esp' now reports:
tx-esp-segmentation: on
esp-hw-offload: on
esp-tx-csum-hw-offload: on

Fixes: 4861333b4217 ("bonding: add ESP offload features when slaves support")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/net/bonding/bond_main.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 7b78c2bada81..e45bba240cbc 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1538,17 +1538,20 @@ static netdev_features_t bond_fix_features(struct net_device *dev,
 				 NETIF_F_HIGHDMA | NETIF_F_LRO)
 
 #define BOND_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
-				 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE)
+				 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE | \
+				 NETIF_F_GSO_PARTIAL)
 
 #define BOND_MPLS_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
 				 NETIF_F_GSO_SOFTWARE)
 
+#define BOND_GSO_PARTIAL_FEATURES (NETIF_F_GSO_ESP)
+
 
 static void bond_compute_features(struct bonding *bond)
 {
+	netdev_features_t gso_partial_features = BOND_GSO_PARTIAL_FEATURES;
 	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE |
 					IFF_XMIT_DST_RELEASE_PERM;
-	netdev_features_t gso_partial_features = NETIF_F_GSO_ESP;
 	netdev_features_t vlan_features = BOND_VLAN_FEATURES;
 	netdev_features_t enc_features  = BOND_ENC_FEATURES;
 #ifdef CONFIG_XFRM_OFFLOAD
@@ -1582,8 +1585,9 @@ static void bond_compute_features(struct bonding *bond)
 							  BOND_XFRM_FEATURES);
 #endif /* CONFIG_XFRM_OFFLOAD */
 
-		if (slave->dev->hw_enc_features & NETIF_F_GSO_PARTIAL)
-			gso_partial_features &= slave->dev->gso_partial_features;
+		gso_partial_features = netdev_increment_features(gso_partial_features,
+								 slave->dev->gso_partial_features,
+								 BOND_GSO_PARTIAL_FEATURES);
 
 		mpls_features = netdev_increment_features(mpls_features,
 							  slave->dev->mpls_features,
@@ -1598,12 +1602,8 @@ static void bond_compute_features(struct bonding *bond)
 	}
 	bond_dev->hard_header_len = max_hard_header_len;
 
-	if (gso_partial_features & NETIF_F_GSO_ESP)
-		bond_dev->gso_partial_features |= NETIF_F_GSO_ESP;
-	else
-		bond_dev->gso_partial_features &= ~NETIF_F_GSO_ESP;
-
 done:
+	bond_dev->gso_partial_features = gso_partial_features;
 	bond_dev->vlan_features = vlan_features;
 	bond_dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
 				    NETIF_F_HW_VLAN_CTAG_TX |
@@ -6046,6 +6046,7 @@ void bond_setup(struct net_device *bond_dev)
 	bond_dev->hw_features |= NETIF_F_GSO_ENCAP_ALL;
 	bond_dev->features |= bond_dev->hw_features;
 	bond_dev->features |= NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_STAG_TX;
+	bond_dev->features |= NETIF_F_GSO_PARTIAL;
 #ifdef CONFIG_XFRM_OFFLOAD
 	bond_dev->hw_features |= BOND_XFRM_FEATURES;
 	/* Only enable XFRM features if this is an active-backup config */
-- 
2.45.0


