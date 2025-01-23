Return-Path: <linux-kselftest+bounces-25015-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93027A1A6B8
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 16:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A8B57A04DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 15:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83300211A26;
	Thu, 23 Jan 2025 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eMchakSr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD42920E711;
	Thu, 23 Jan 2025 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737645005; cv=fail; b=GNzueOJpmaQ2f+pYoD4afeBHYl0Zinnv8qiGKWyYXlG3gqv0pbZLxmRaG7+09KIQQaIr0jLjnTY/UXLyUGDkuo/q3gkh283YAQKRwK1/mVRLig8CP5yJFzlYvWOzL/8WOpncV35vbqaP7XRmpK2aQaYQRRnOsCqXZf98YkjOnDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737645005; c=relaxed/simple;
	bh=O92uHUIh1Q3x4j2A4VL/K9nptztlHAHfXOP6Ad3N9uw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KMK26Q/OUlF1jnSpT+Ka0b8UCT6NUIKGStoC+geEL0ZHxpAi9JuR8fp6IND+oGffE5VMXP4Da4m9Fl5AzzlL6kEa3k9AzaziZiGnwiy+berTEVxyOlALBiVPCpatRtrFSV6mP4ftUmeqyF/W9vTUHCmbKry+R+yotoTlGlW5/lI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eMchakSr; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vI5V7YKWiBT3xtFV3+ETEEKoBBixtEkythbVbf0x1RndclJpFXHjfbTNCjDLc/1zmEvYMmoCe+Y71nrgroL2D0C2Y2/kFEmYCpBX3TbOxN0I2fx3Fyo1cNB/zebF9qHAbNEQFMZcstn4mTuqjaivjceF0p+adun7sfg4AtasuoEH9pAzbUeD3y3PMEaK4QHsfCjyx11DMfxTc0qnfGH0m0knZGOxwGrzDWeGTvuIt2Z2J+L5Dk+ym1V1dOcWG5daCOBIgM09AXhjF22LPP8Dvj/9WC6D+w9QU0Y2YFF26/IErWu8mo7hU9dQCKK83Uj1eeqyAsVK8UcbMzJcbRoUiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10mCTQWPnjT4UaE5DswreRKFKzwbMSaB85ao6y8nAfk=;
 b=hXLDcALIRybqWWDVJGygJjNTrnaKWNwymlBBC5OrRi/0kD58SKuzHJi38jcaSPWFVUAO+8HBMZ7411p1+UC5C36quiuBI2SWvhpsE43qEfhpetqHGMubuxsbacbYr3NbsacBunbTkLqcrzxtVe5J4ca7KGik3SzTJz3RZZ9oIfvDw8MTn1ydQqj11Ugx0kJgjQJHKBCgR2PCyxhJ7NqdyQsayXcBz2MRn7lMVv6b27EofCp43+aAokPdZtX44B3f5CEitBa1TEjmnjoCAXBcqLAjuOXpO1h+j5AaJBcZjnfrShCIfK2+H8V5lVqJe0J2NsIZ7YMtiyurTOrnar9Usg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10mCTQWPnjT4UaE5DswreRKFKzwbMSaB85ao6y8nAfk=;
 b=eMchakSrPK6rpTedMhwyV6zCKN+Vwg7x6CMTwOsUuhouDZn2WD5VK2XJNxnn7CZFlt5WsRg6MD/pl1865pjM/A2zNvYZBnO3las27ghXw2v3moZwqoaFX0lPUDH4w5qZ8eBuPiyimW54ua2k1SfVbrRJhxQXoxYmkS0PmVxkJTv520tB6qAvLROO2V6XdAvDpGUo6HROl1c+Aq4OYKyC7CaPXwyb6VMve517MmewfjnL+h6p3AKoEcAed2l5GcSzmo7mwa1RW7H5H0XUc7nqAB/pJdn35MYxfny7j/vHNSUEPFPinzRAStO9jTMeeE0+G1BHD7vJxfLM+EAkMAL80Q==
Received: from CYXPR03CA0096.namprd03.prod.outlook.com (2603:10b6:930:d3::17)
 by CY5PR12MB6084.namprd12.prod.outlook.com (2603:10b6:930:28::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Thu, 23 Jan
 2025 15:09:57 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:930:d3:cafe::b0) by CYXPR03CA0096.outlook.office365.com
 (2603:10b6:930:d3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Thu,
 23 Jan 2025 15:09:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Thu, 23 Jan 2025 15:09:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 23 Jan
 2025 07:09:33 -0800
Received: from hive.mtl.labs.mlnx (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 23 Jan
 2025 07:09:30 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jianbo Liu
	<jianbol@nvidia.com>, Boris Pismenny <borisp@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, <linux-kselftest@vger.kernel.org>, Hangbin Liu
	<liuhangbin@gmail.com>, Liang Li <liali@redhat.com>, Cosmin Ratiu
	<cratiu@nvidia.com>
Subject: [PATCH net] bonding: Correctly support GSO ESP offload
Date: Thu, 23 Jan 2025 17:09:09 +0200
Message-ID: <20250123150909.387415-1-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|CY5PR12MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: ac6266ae-e698-4bdf-d973-08dd3bbfffa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L6nSZ1/P/CiJ3l2Hw2Y2ns6QxPLbVDuC9Zxr9pypE7+3WACasJKkfoazmvSa?=
 =?us-ascii?Q?rIkLcDaChbDHNaU17YzeH2A7cmSU78+hUywS/5nHpdwkRoSRrt+YH2jY/DAU?=
 =?us-ascii?Q?3Esfbv1ttmlSSh+2A3pYKFTg9t1/91Ug5Eg3GGgRqk22zMtkeeJakBmoonSL?=
 =?us-ascii?Q?h0h73kzPW19mWgENR9NVeJw15lcOk4wC8BgvtiPqbnPyx+2QPaDl/+zXLCDO?=
 =?us-ascii?Q?4XxevcolbLajjL+xFY0A7w3Pwr7H+Peqs7fRlouf+ANRtuzjpOY3YoGTnsAD?=
 =?us-ascii?Q?e+JDwZ12r2tSP177507dkkMUIywgjoc0aY4pxD9FOfGysYcAB+7WAHGnbubz?=
 =?us-ascii?Q?ZNiyiXJRhuJ4ufZG3bg0rC7LsypV5Rus/rndbk0vOVwOVi9A4bvmbLLk1lIs?=
 =?us-ascii?Q?XXBlELBq+Frk439Vg+7WR9ogdkM1Qrbw2LCa5bog2uZQyAgXVn3QX2B0u5eJ?=
 =?us-ascii?Q?J/YzJc6JLm+0X8ePAIcYyAyUhV7+RSPoMx0+Pn4TCj13fCoDt9h/LwXd2oDD?=
 =?us-ascii?Q?JA5TfqsanQq3viuTwTc3Rd/NoT8QI/oYAxZHsu8knAnTFQT8X7ifYRsFShkS?=
 =?us-ascii?Q?oVvNIuSAWuo8KIq3Q4U+ZdNRAepsRMqXexM5bFQ+J/AsNbJm+kGK5mYOdz+G?=
 =?us-ascii?Q?tCKLKxOTMSqwm/lC2PB2kgrVAFMTN77ukEdkmx4DhByaxSzjCIzjG0Bif3bL?=
 =?us-ascii?Q?apUnFA+W2yJnR4qkncOtMJzf5xFss5ZmVstdpk+rCxVl3m+VCS38p9zJPxo8?=
 =?us-ascii?Q?7tb9LgL5jX5d8t6r3n9IoxS2zOv/FyQf8QtwXpD5rd0lhrE78qSqlxF5H5a/?=
 =?us-ascii?Q?LzrG+mJ6j0OX+PsnQwGxg1V/RYBf/WUYNbx2QXVBjurcZqk2kvSttjyWShnW?=
 =?us-ascii?Q?anFsXI3Z1DUP/Bqo9Qx/hUV8Koq83L5JGUShHU+mhcLWZxQm1dyE3kRHKA+Q?=
 =?us-ascii?Q?ck/Ag4Rtec6N3DHjEAm5lnDArfXzHvpToy8lMjZlNQ1yKxkGjxYZ9ARUlUVU?=
 =?us-ascii?Q?h5reGhrfD2ON8kpEocrC3ADK7C/eazk6CE5og+qTWAZFiYXCUIHIK616PLPG?=
 =?us-ascii?Q?npivx5BpoRCK0vvzY24+5DU0S7P7MLHNoENItkV5Hk0trLvHMGCwxYK26nRl?=
 =?us-ascii?Q?2swN6itO/0pgaaQOE/A+1T0bjcGbFczAH39qzTnQAVLw3FTx4qCvtJeUodr4?=
 =?us-ascii?Q?B1FqBn+xSHYQ6vCT2764HYpGVC7zjYlckKC1p/6XfxkPIA0A2/QuFz+Hbn/Q?=
 =?us-ascii?Q?CjmmKx+FCMbGKnIJka4ajR/JXrLLxLvBhyTJxlCo4iM8YcBl/usMGBQwWDvq?=
 =?us-ascii?Q?qjZZOMH8AkZEfm9vtx/DbnHplQr4fAXKEVcQvDFfa48wDK6c5XJAq29rcpYh?=
 =?us-ascii?Q?0OBKyO9e790nKcWtRN5CL+1YbagannNuDcVDY9ICLALUzP7G1kWrGUbpVjQV?=
 =?us-ascii?Q?bAj23bxflZvmtpRuULaT6iQfqEmidB9w2wNrISuATXyiP5a9XezNpw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 15:09:56.8833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6266ae-e698-4bdf-d973-08dd3bbfffa6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6084

The referenced fix is incomplete. It correctly computes
bond_dev->gso_partial_features across slaves, but unfortunately
netdev_fix_features discards gso_partial_features from the feature set
if NETIF_F_GSO_PARTIAL isn't set in bond->features.

This is visible with ethtool -k bond0 | grep esp:
tx-esp-segmentation: off [requested on]
esp-hw-offload: on
esp-tx-csum-hw-offload: on

This patch reworks the bonding GSO offload support by:
- making aggregating gso_partial_features across slaves similar to the
  other feature sets (this part is a no-op).
- adding NETIF_F_GSO_PARTIAL to hw_enc_features filtered across slaves.
- adding NETIF_F_GSO_PARTIAL to features in bond_setup()

With all of these, 'ethtool -k bond0 | grep esp' now reports:
tx-esp-segmentation: on
esp-hw-offload: on
esp-tx-csum-hw-offload: on

Fixes: 4861333b4217 ("bonding: add ESP offload features when slaves support")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Change-Id: Iebd2a9d903d3e056e7717e8ca2527a9adf21b2e1
---
 drivers/net/bonding/bond_main.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 7b78c2bada81..de105868c009 100644
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
@@ -1598,10 +1602,7 @@ static void bond_compute_features(struct bonding *bond)
 	}
 	bond_dev->hard_header_len = max_hard_header_len;
 
-	if (gso_partial_features & NETIF_F_GSO_ESP)
-		bond_dev->gso_partial_features |= NETIF_F_GSO_ESP;
-	else
-		bond_dev->gso_partial_features &= ~NETIF_F_GSO_ESP;
+	bond_dev->gso_partial_features = gso_partial_features;
 
 done:
 	bond_dev->vlan_features = vlan_features;
@@ -6046,6 +6047,7 @@ void bond_setup(struct net_device *bond_dev)
 	bond_dev->hw_features |= NETIF_F_GSO_ENCAP_ALL;
 	bond_dev->features |= bond_dev->hw_features;
 	bond_dev->features |= NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_STAG_TX;
+	bond_dev->features |= NETIF_F_GSO_PARTIAL;
 #ifdef CONFIG_XFRM_OFFLOAD
 	bond_dev->hw_features |= BOND_XFRM_FEATURES;
 	/* Only enable XFRM features if this is an active-backup config */
-- 
2.45.0


