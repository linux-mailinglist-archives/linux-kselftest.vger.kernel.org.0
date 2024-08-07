Return-Path: <linux-kselftest+bounces-14968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC8994B10F
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 22:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 516E51C2233A
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 20:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17010145FFA;
	Wed,  7 Aug 2024 20:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BQwEgn6K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADB8158DA0;
	Wed,  7 Aug 2024 20:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723061515; cv=fail; b=FpwvTuyYATtA1WmTy5LAHTeYIXD3Q53ORcE9yGShbkMCcRLTC7KxDvtbqoE2rRNr2kAhbc84Pmz/VdWHLqxsJEg6c0wMjXqV9qFAmrcvqcDT4J5RKKVcAEk6eZuN1cN955TLhQp4wEXesBGFJ48yA/HLA1jiTdzXq36c3oPhBmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723061515; c=relaxed/simple;
	bh=1SMve+Gq+JpAII1UUvkJS/1v71+0U8ezs47k67e2C6E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FLiCzYQiZQ3CwZO8yIvz1aRqnHaXU+ZtQgPtQfkSB+09+L8U20sBRd97FT8Vw3u637Ksq805+wRccYcXSrIjQuDscWIgWFBk8V5yqlSOLSn1vvng/XUmnTJaHn4CxVFJY5Gst4c4QaMCKMCYdLvAr9SfD0DdyGgCPyH1z5ggUWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BQwEgn6K; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+8aj+e570Ux3syfMi5glUypvm7+D+V0tflm3kKZ2lzDZHV3gF/w7QDsoWeQE2kGqC9amzZv30b4zUeWd9lfsScwAvOg2UIBRHVZkpyM46bvn2KHCirJ2HTMm0WZwZPOiipyuv1KNGzta2/Z0e3DyKRNveYS5lFUpdRKXtIKnWCejJmBumMG/WG9Mqc3s+g9k9nVxCoZ84kqcOOWlBk1q9IkiOG/dl1XOZyRoeKGbNj7RoNHYedTUcCyG77WyQTGou+tLXQptJ+D6bowoOZ954yj13rDwp8i/9JeyY7K7ZHELr1khnmBJ7dKA6yfIApOiIPI4qLNCg5g6ZquCQFxJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZrvfVns3n+wE19BdpBxEW0UC6D8M1vjafDg+cBNr3Y=;
 b=t0y/R9TmNJzWyyMiS4WcROmC/XGjPyXPSIyoHbHks+Txw2V+WAhAP/qjceKlpmWgwQ9zINMn9PZPfZXf4+O5Etd48oVSHrb/TF4Wjs6ztzNasM0genL9y1Y8D5DqeP+0H6EaMk/j7bLxUEy1q/w+3UNc7oACG6+nTbhJ7gHtfihXFe7fWb8Rtj8oIJsiDY+5BFHnN0Lks/dTOGffpShyLZe+PqK5Oezhg1jRACIw55qjFv+Ijy+7mh+YToRd1PsyP6ihq9Uzi9s6CJj/jCzZ9y7Zu2+37Qg3sTMqoRg4cRj1vjbP9VK+tfO3fI7jR1HP+lbE87P3fB8iDYG9e+DocA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZrvfVns3n+wE19BdpBxEW0UC6D8M1vjafDg+cBNr3Y=;
 b=BQwEgn6K4lAosxLyX0nMiyUoV0KbyjKEHtaSQtHFr1u+An9hXgyX7ZIyI/Nlsb5waN3AJvsYrJ6qCLFZ8k6rLFLPXp5BC2e3O7jUddVyMqQaApD+gobZTMrXbuFdGIPsc3KjqagoaRBQR/NPfdH8ttuLUvf00okVbm4f3a/uXSbx4KEvt/CCf4G67MFmtkMnVPGmbXrBADm4HgEBC5aeHkOiOTHQ+paTwcvFmSITKjHdSGp3F7dyI9AggakOYZF4AephPkcvdxBkAr5H71coWKwB+zywpDVZfjukBfpn1YiUT3ih6MXHtvjNVUmgbTw3sCvBadw38ARRckePQshjLA==
Received: from CH5P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::8)
 by SJ0PR12MB7036.namprd12.prod.outlook.com (2603:10b6:a03:483::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Wed, 7 Aug
 2024 20:11:42 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::98) by CH5P223CA0013.outlook.office365.com
 (2603:10b6:610:1f3::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14 via Frontend
 Transport; Wed, 7 Aug 2024 20:11:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 20:11:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 13:11:25 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 13:11:25 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 Aug 2024 13:11:24 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 14/16] iommu/arm-smmu-v3: Extract an __arm_smmu_cache_invalidate_user helper
Date: Wed, 7 Aug 2024 13:10:55 -0700
Message-ID: <fd1b869f32664210ac29e3d0ca916f1a535233b3.1723061378.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723061377.git.nicolinc@nvidia.com>
References: <cover.1723061377.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|SJ0PR12MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b1aad55-d505-4642-ef22-08dcb71d2722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/cQrJXafNOFvPVC0IrT1IE5C9HsVjjDZY8SURwcHI4ANp+b8EFZCEX4ft/mG?=
 =?us-ascii?Q?7KJ1SAhA92rpVwdgzemKwAXh8b2drqGh8KZMgRtskd8oAut9lV3biW1ViIEb?=
 =?us-ascii?Q?+ddmyAIyrkisnzR0GM+Mcz4qB1rTDVTh1yosSLheCzqAzqfoap+jHwYETnG6?=
 =?us-ascii?Q?maQb+KUM+H1hMD+bAu/wETpN0Lzih58p3G6H9cK8LRZGR55B98xjTArO0Arc?=
 =?us-ascii?Q?P9hCMD4wAVCOneVD4wC+zZwIWvmu7x+7rpL5XDrBLBFh9cAp6AH/1kb75INf?=
 =?us-ascii?Q?nQvUBdanNcntdj1xUJgfbrqvWAr14DcEdb54SdwEQEVgehOq/xifOxp2onwe?=
 =?us-ascii?Q?nbFYslu+8NETICgui3UPWbRO2KSr3PE7tAdmcdxSBv6vEYuzSMJV5h1IHPaq?=
 =?us-ascii?Q?x9znrgICi62KqbPDVNLWEywsxA7HxVC1nu0Nq9RBZT18HknxMadMWmXFMmE8?=
 =?us-ascii?Q?f7I0p5OtAQIC1OuTBbEDxhotpLmLfqGOlKDO7OE6l0YwS56myqrXGxjtCLXu?=
 =?us-ascii?Q?tVxSRXaVkbllL0ey/y2e0RUI+9P4iuihKQgn3c7aKK53df21gna+EP/DFT4u?=
 =?us-ascii?Q?HNUSPBsdvSfvKTGBv82AwpSDV0SBK0RlOUmbDlXwsQ1snFxqarFBeRV/IWdf?=
 =?us-ascii?Q?ojfpXWcxdcFuVhaLD0Kpz66Jq7mCEnVF2Rh2AyfY4PhzGZgV5Z9ues87nzqo?=
 =?us-ascii?Q?pxXn+FB2pSJgsEImQ3oSFXwKjn++xGG6K9r7pl4LXj/1Vz+oAdXfKecdYndJ?=
 =?us-ascii?Q?9fVAmKL69e6iYIfI1Dc5dBb5dxv8zBf2m5oMVhrR0qrDZ8anLavaWsyx2n9A?=
 =?us-ascii?Q?hoNsjrIsIbJYQkFfTxnRXsan+Xoa16E7nSqxbH1LEBQRfZru2luiuJ7GgFlE?=
 =?us-ascii?Q?InCBFePShW2RDOF9s9ridgjWaW+00rmoqniIit8VRapXnigTQK0DRDPUZ6Q9?=
 =?us-ascii?Q?RB35CCkKvCxKffwwWvHQChsUiT29i1ky3pjcp85mjA0q5FNwWK+BdYL0iqRq?=
 =?us-ascii?Q?aZrZB91Zd2s9XtiB2q2pPg64IXqfjgGg39Z1/SmUwXPWNj0nVzs+kd/JQltN?=
 =?us-ascii?Q?sXUerIh0TNCnUGXfrQyLlp3KmDKw7zIMVdUb2xYYnD062wA6IM3dOMZ1kIBF?=
 =?us-ascii?Q?0i8EYepoNqIFvENMMX3/kRgCPlMU9Qwq6caYc+LMMrS9skGlcfi4XB3AggsX?=
 =?us-ascii?Q?h7tYBJE6F4RhAs36Xx2Kr41TOpRDxrlwMMVJD8jYlcSY1wZKeKrsvoN8hBbx?=
 =?us-ascii?Q?vneOKYZrudaSZYTi7TZZx+kyg4RhCsCfUE5KYYm6CzPMeEz2qjFeWyaorG7L?=
 =?us-ascii?Q?6AD9sHu0H2fnkVWmbtthyWf6hTh0Q+S/DDqC1Wbd1zi9KtaDkvMohZeEzQ6q?=
 =?us-ascii?Q?SUdqYjREg/DcB+YO/jhOlL/8EgL+WcbDxPnehyyD7ZqS7gtLh+fmi+X/EvnE?=
 =?us-ascii?Q?WyWCJTKv496eSW71A3sHug1HUMTlKumQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 20:11:41.6897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b1aad55-d505-4642-ef22-08dcb71d2722
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7036

Extract a helper accepting an s2_parent input directly so the following
patch can take advantage of it for viommu's cache invalidate callback,
which doesn't have a nested domain but a viommu object linked to an S2
parent domain.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 24 ++++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 558cf3bb24e0..ec76377d505c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3227,10 +3227,10 @@ static void arm_smmu_domain_nested_free(struct iommu_domain *domain)
  * Enforce the VMID on the command.
  */
 static int
-arm_smmu_convert_user_cmd(struct arm_smmu_nested_domain *nested_domain,
+arm_smmu_convert_user_cmd(struct arm_smmu_domain *s2_parent,
 			  struct iommu_hwpt_arm_smmuv3_invalidate *cmd)
 {
-	u16 vmid = nested_domain->s2_parent->s2_cfg.vmid;
+	u16 vmid = s2_parent->s2_cfg.vmid;
 
 	cmd->cmd[0] = le64_to_cpu(cmd->cmd[0]);
 	cmd->cmd[1] = le64_to_cpu(cmd->cmd[1]);
@@ -3255,12 +3255,10 @@ arm_smmu_convert_user_cmd(struct arm_smmu_nested_domain *nested_domain,
 	return 0;
 }
 
-static int arm_smmu_cache_invalidate_user(struct iommu_domain *domain,
-					  struct iommu_user_data_array *array)
+static int __arm_smmu_cache_invalidate_user(struct arm_smmu_domain *s2_parent,
+					    struct iommu_user_data_array *array)
 {
-	struct arm_smmu_nested_domain *nested_domain =
-		container_of(domain, struct arm_smmu_nested_domain, domain);
-	struct arm_smmu_device *smmu = nested_domain->s2_parent->smmu;
+	struct arm_smmu_device *smmu = s2_parent->smmu;
 	struct iommu_hwpt_arm_smmuv3_invalidate *last_batch;
 	struct iommu_hwpt_arm_smmuv3_invalidate *cmds;
 	struct iommu_hwpt_arm_smmuv3_invalidate *cur;
@@ -3282,7 +3280,7 @@ static int arm_smmu_cache_invalidate_user(struct iommu_domain *domain,
 
 	last_batch = cmds;
 	while (cur != end) {
-		ret = arm_smmu_convert_user_cmd(nested_domain, cur);
+		ret = arm_smmu_convert_user_cmd(s2_parent, cur);
 		if (ret)
 			goto out;
 
@@ -3305,6 +3303,16 @@ static int arm_smmu_cache_invalidate_user(struct iommu_domain *domain,
 	return ret;
 }
 
+static int arm_smmu_cache_invalidate_user(struct iommu_domain *domain,
+					  struct iommu_user_data_array *array)
+{
+	struct arm_smmu_nested_domain *nested_domain =
+		container_of(domain, struct arm_smmu_nested_domain, domain);
+
+	return __arm_smmu_cache_invalidate_user(
+			nested_domain->s2_parent, array);
+}
+
 static struct iommu_domain *
 arm_smmu_get_msi_mapping_domain(struct iommu_domain *domain)
 {
-- 
2.43.0


