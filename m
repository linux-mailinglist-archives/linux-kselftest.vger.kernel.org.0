Return-Path: <linux-kselftest+bounces-25221-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EE9A1D4AE
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 11:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 248821885A07
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 10:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79C71FDA99;
	Mon, 27 Jan 2025 10:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f707YHJQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B01135A63;
	Mon, 27 Jan 2025 10:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737974542; cv=fail; b=NIqApVtmwIDRbvWWsiA0d9kQoZT7kp0cMybupWgucYP2HSz6u5kctVPrelW7dd/wq7wj99hT9sFGyFuuhljCm2uax8WK1qsvwMCh9L8KClaO2aYi3uWp7ZKHVNs9B8Su9cfYeQWJsIRu7jnzwRXWbtnC3EZO6fHI7rP91wTJ/7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737974542; c=relaxed/simple;
	bh=Xk9/assazJ66xjwe4C3VNHsarm3+SuL2YFFwuZ6uVjk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i7MV2puEWDzK/wQGuCo/cnygV+tibsSdcXkxlElOFU5tImSlVvVuX+GF5Iq26whxtyFMQ0GlMaYK402Qb+QmBjRy0x++3b8JkmoZ+uFYHZLRvF7W/fLOL+w1fh4c3zMXwfExz7zYjiL/v+M02WkAfD5f1SMrORvE6mNljQ/TryM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f707YHJQ; arc=fail smtp.client-ip=40.107.102.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hp3dYnyiL9Uc+rfK0SOWeGmIXadzzTxqE9yx0RaVtWkDRpzc0mxeuSHL2RjTEB+wCcN8KOz2kNmnsVkffopjZ4xDIvyLsdMgeC/XZQHa76SWTA/P7KTrL0LN9WOFoK43abGqCSfKVnfXOQB7Ky8LQiCVCs3XXQGK3Y5ZLPZ17fR+7VtYANM2fc6oyuRrIMu6E+RNvN6NItusvYsdnmcV3kP+MgCMoIa74c3de69aePhqRO9AqXca62EkaavJN84GSwngOt6rDmDWdCDtLe7iByLef6Su3j/TfS4/yvtpdSj9zb/cv7TcDVUtcGkBgly6Qb4qnQNbGWBlC2e2ZndxAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1EeLiqSsvOc80cSJiM92wL4HM2KOG8Nw2ulcT5jdzA=;
 b=QeV3OvoySCpb7NaEd0vnjKT6O2d0/+znyhXrOJCCuIbl5gRRdteZYL3Cr/W0xxY8wz+5gk2mYIdJo3ERChvUUbVjH5HkoJtFCDtaXK3jvAw3CP491SSZTv28DUpIgjqZhCSF35byM4/ywhsDVkLTqaNOmwlezPCue4FYa5jHDFgTNM3WxVZsIkL/UW5Wt3vIJi3qpUwftQyJGQSwIcpD49F51wvgwo/YjkPY5DK7mHd+eRuVZOXKz92CznnEA0mfnEwg7YvLRwYjdw8eo0TWaWM1eZfwqD9WcW1QnaAQH7SGdKkqAmS9vV068UZWv5GFLGX4KHahu6QBWaGM9wVwgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1EeLiqSsvOc80cSJiM92wL4HM2KOG8Nw2ulcT5jdzA=;
 b=f707YHJQOMyu7QUntvJCyIV96DWIzmuCBRel+LrmJ/IG7SJfPZjf2LddmxIsctjxV902oE+B5bmlho3PwKshYiA4ksK/5mb6SBEweUITTFIYfW9jIqwQnmmGCc/wq6XzMAGulapoVNDwRQ8AchDSUC1zTM9TxqLROi1UbEf4EojwP8n8DwtZDqdL+bIPl2ngpEinpkyt+ibjKMHsTDUQUf7YKFmREJxaZZFihxmCd2EOrr9VruCtGCSujHXh9MGQJWF6CtG8sutLf0XpYlPUQh7rfdW+kbiJ2ON0ILNyRwonwvgi0Jv+5hXJ+M6lj59RbiWMEwpHByhVAGplIMA1MA==
Received: from BY5PR20CA0002.namprd20.prod.outlook.com (2603:10b6:a03:1f4::15)
 by SA3PR12MB9226.namprd12.prod.outlook.com (2603:10b6:806:396::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 10:42:17 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::85) by BY5PR20CA0002.outlook.office365.com
 (2603:10b6:a03:1f4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.22 via Frontend Transport; Mon,
 27 Jan 2025 10:42:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Mon, 27 Jan 2025 10:42:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 27 Jan
 2025 02:42:09 -0800
Received: from hive.mtl.labs.mlnx (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 27 Jan
 2025 02:42:05 -0800
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
Subject: [PATCH net v3] bonding: Correctly support GSO ESP offload
Date: Mon, 27 Jan 2025 12:41:47 +0200
Message-ID: <20250127104147.759658-1-cratiu@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|SA3PR12MB9226:EE_
X-MS-Office365-Filtering-Correlation-Id: dbb64f77-aa48-42e2-e306-08dd3ebf44f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fovarKgPeL+8RTtdALjPvxBgPg7HW3nR7ciggXaKQnUt4Nc3kaHXf0U6R0iL?=
 =?us-ascii?Q?Zs29O5Sj55Q/oMfyK80ACMQTi+aa1cnO/lmsnIN258deJIzISvohQ3JWR+DQ?=
 =?us-ascii?Q?InQ+NSx6pgHn055mu6lls6BilLVeaoK1XZo0UxFIRz+X8H6Yvae7/nYDEtzH?=
 =?us-ascii?Q?rdsKwohBoX1DDZgS9mpnTZzNruxW2yMarR2ZgVWuiqKNnbyrF5fNtUx91X1+?=
 =?us-ascii?Q?ouFsbpV+5SINnsIjWdTBh1HVUrjrei3XtMrhShSc39fa5VTPaHzQ8cbelFUY?=
 =?us-ascii?Q?I8vraldkUC3AFgGLOq6qOMj003QKMDbvz0sNGMDslUQzeMj8GiJAFvmXNsQT?=
 =?us-ascii?Q?jp8F6MgJFUl4WfKjKhn+lNkIBigBiplsrmNJCCL7O10HQ7z/QPUUAOF80m3t?=
 =?us-ascii?Q?ecN+8Jd6mnAeq4u0etCC3UpQ2SG38uPVffKTnG6CJ/AypG/ze9xtTuirsVBz?=
 =?us-ascii?Q?PJHK2qG82YYzwfDVOQ0+7My7u/i72uh4SCtA6BJK3DwdCBiPqcxcXvzngk8d?=
 =?us-ascii?Q?pz5WlieGd85bQki59mtn0E8d16zaEw8ZgdZnOsbJXfPskqVG1vgC7gyDoKRN?=
 =?us-ascii?Q?jVA4zGOXNxS61q9gRA5aTGvuT6Z0dCp4PMZ7086Qb6/g46RBOSd2P5TQyW9T?=
 =?us-ascii?Q?KbkWdriNR2lkUpEUH8meFE+epZE1W9wxtiY2rtODRscnzFnApmTWINQg+9Q+?=
 =?us-ascii?Q?xE7H7Em8EVEAH01nMuExBSTXBrR4J4W1RXI24le99UfCVJObJMB0JWGwnPPL?=
 =?us-ascii?Q?PghEAdbzOYX8knZhmbshvKT8Z849uzZaZVDb/RaMt4NxrEjak/2NomFtIH/K?=
 =?us-ascii?Q?hYIJ+Pw0769aXFi+BtE4X8wv5tywz271rhXAWp3yVHyhF9T/bCOyl8ht4E/x?=
 =?us-ascii?Q?wgKeUno+N0bMuzxVIUG7JRX7V3QMrBLfq5JfL3NZMYFuhuVprDWP3JiwB/7Z?=
 =?us-ascii?Q?v7fKJBIlR7ze7MXFveClSoo4GHoa2c/E0Oobq0PT7amrpKjbhqdTvze8hLsj?=
 =?us-ascii?Q?TF/JRojfMCRGKjRDVxwc/GdZq9d5pmjnP/HlaOTIe0X3zwagzOdSf7+s45pQ?=
 =?us-ascii?Q?f+lkQoJ/HpszZ50AlxbF3mNfqBp6Y2PwIk2elTrCT7tNXONJ0wATZV3Uz0LH?=
 =?us-ascii?Q?Wu7FxcpAd9EFZfgYoKlgCzzTnz42ylfax0OfntdjqKS8rKqtvs3RD+ZWIo6E?=
 =?us-ascii?Q?ZaY4PD+yTACv4sXFkDkDCEwc59vDvEYglhK7g4KmrH1NtqDxBoPgFQeou3rd?=
 =?us-ascii?Q?ifLgtSYC6cpjQodqzRs0VSf67bsbu5jGUnxi2VL8idPy4dy72hJ/nuVTLcFX?=
 =?us-ascii?Q?aAMg4C52o7I9dlmrIkFssAkJdozeb0XqZUTDB6TtDKX18ITu9w1vzVn3aG5c?=
 =?us-ascii?Q?WHwt2o1aIk4r24eaQfbO2G0ZUA43k5ZHEgVjT5FT+xwzaIEmnPmOPWWZykr/?=
 =?us-ascii?Q?hPayG/bm1odk1tjYbtvqHziR5m7UXW/nr7TKacO95npzb6jrIU5URDmarFqp?=
 =?us-ascii?Q?EFxBL0Kid0L2YpM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 10:42:17.2065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb64f77-aa48-42e2-e306-08dd3ebf44f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9226

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
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
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


