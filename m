Return-Path: <linux-kselftest+bounces-33278-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF59AABAD73
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 05:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A66EE7A214E
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 03:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CEF22F777;
	Sun, 18 May 2025 03:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UY2OyCqp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E16022AE65;
	Sun, 18 May 2025 03:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747538578; cv=fail; b=q0STdDvpHdGTHeQvAQNr2S3guIkfKFjuHUtRURY3jtWSqaLFm3S/EmAjeqPCfuQeedyrR5RrcqeLQQoOUrLBCcDFX2ziB+v8ruHRGFqGvPWkKwC0b0MaA6xN5JwBasZBc3I+qu3xbUWjTbwlDrtwqxlhYKkPq9slZZem5yszQl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747538578; c=relaxed/simple;
	bh=iDYkFxaay07RdzaqCGAsLHspwmQFsV4Pj4Sq5wHpUwA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JbGA7GTm4aTvSGBT1N7Eic2HF55HA1DiRf1h4Ogzsw511RlYqlprtAnSpL4NjFcJBrcpqkzVpyn8zdYNjZpi3AiRDuRbUEewjkHn+7ouQbWNy4lCCSzfUjTmnejtvUAy7775keQX9AFN7DcpaqxyV0xPfQYlHkrSknLePmypCGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UY2OyCqp; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Moq/GigurKYtqtvZBIq0kzZPzwJwAxn2t1Q/YaKBMF303JlNXfmcqtlrs8ZK14lEaoX/4UKcOFrhzCznnpl2hGwi+bJLFq922oLArpF9WLlLDnSI5GolRlfkEYrSGBEorg0dBjzyipl6/V4x99INGQ5lE8DvYO2MpFB+sWBrbI62Rq/vWP1Kmqt+uNKAq5+PM9ugCB8k+pTnYEEXfy/O50cUGufvKhkDfIFGmy4YIW4G9MmMF6QNGGMG1t/d0MVfr4kC+qTZIEllpYRs3Nk34vxQ6kZ6v6ulqJMNfpHOOAfwQa1MmBvEb+2HXeAvujyzl0Mu42tXH24SphjaBwRKbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QA/qWLEL94O0q4gdZ4TnOfRb+EjphqRfMAd/9EhhGmA=;
 b=n6D2KevW6EhxcZUFM+3RuFTuWZ2TqfM5ddiG801SDhrTd80dYClsUytg0OlBVoAyySfIO0523nrcU3o1bmRVhHJ4c/X5po0IXr7y33Sw/EdZ4PTMxPZYUBDx00qVNzT9igCUAgdZqINEpvhPG6DRkivYm5HR8NWRD8Eig6mzm29hTksTsTxr2c7YmZA19Hm7ifrghDoqnWFeyiZvdIxApPMfE9of3UD9SU3IBXyuQigKigqtDTKL1hjMXpXDT/1TyCnKAReMGEhU4qdglTbRw3kKjVGoxmxF8L2+RHjNSV/38fXcJHG3epqUxV0dis23xraWpk/1kvPMkCxobxgKQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QA/qWLEL94O0q4gdZ4TnOfRb+EjphqRfMAd/9EhhGmA=;
 b=UY2OyCqphdfEXnykD0adGwnmF0fdZSZYQnroKqmpf7Xh3dxKFEePab5js254cKqbaezT8KKYXBVVqGjIgnnTeS2mNOyuviwRwSqAvDw4+8RBfoE6tijRNkGkWOFUeN0pyDchCzu19HwPev54PacAi0e1uTN119+4dEc8rvizgvzkUUoaHCrLxhJKN+sAkSZBttPZLbuUZ8cB2j7o9J/URyD7NImO7Nvl4VX9sNdRsfi28pvMDSqxNFPnbtKX65zGjQfGxBDyxS9hz//0Rz3SkCZwVU1g6A0wxgTNIy1n7Q8nzkx5dGoWmuqSVpIvglH5yaR5GAQJFvo/6bgso6h8yQ==
Received: from SN7PR04CA0110.namprd04.prod.outlook.com (2603:10b6:806:122::25)
 by IA1PR12MB8467.namprd12.prod.outlook.com (2603:10b6:208:448::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Sun, 18 May
 2025 03:22:49 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:122:cafe::77) by SN7PR04CA0110.outlook.office365.com
 (2603:10b6:806:122::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.26 via Frontend Transport; Sun,
 18 May 2025 03:22:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Sun, 18 May 2025 03:22:49 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 17 May
 2025 20:22:39 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 17 May
 2025 20:22:39 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 17 May 2025 20:22:37 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v5 23/29] iommu/arm-smmu-v3-iommufd: Add vsmmu_alloc impl op
Date: Sat, 17 May 2025 20:21:40 -0700
Message-ID: <97892d8efef8569788fd53dcc2c3698d0a262be1.1747537752.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747537752.git.nicolinc@nvidia.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|IA1PR12MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a15d005-28d4-45a6-780b-08dd95bb4430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ihk5HN/oqpcSYE0hJzcz90t6XLKlIxTJfWnqKQRoRNTeEJrGDI5B9u4kJhUu?=
 =?us-ascii?Q?fNGybJaObMQ0chpJyutZoyGpGZdyKpzNBpVGlTYezz0U4NB4fuzXkya6dGLk?=
 =?us-ascii?Q?S1n6F0oWTseNGpYow/Vyv79Nrg5qHTiaRUUduRtfy+LBWmqYvkvUoyoAdQF8?=
 =?us-ascii?Q?kJoSAvLoKOvyFOEB0yC9Cmz9KRA6zb1n+AlzYud6x7ba0+Hvu2rUGtLUkyA2?=
 =?us-ascii?Q?KGdQlFMKVHrYKtkHsLgMOt1rRcBbf2x7DrUoasphCmA0XiGaYnmpR7iZJq5o?=
 =?us-ascii?Q?6boq2RuyQp6oQz7HS8PqksyZXWV5PTYsfvQafnyyI6QfbRYCbU3OY5CtAK+p?=
 =?us-ascii?Q?1vkZR1uWtYPSg3n8CkO3sKyQpvYy43TzMUoadFdNJgz0hJSduWerYfUdU8oa?=
 =?us-ascii?Q?zvw2xFF83zI2lu6PRzpdK7/Qp0uiZPE7Rqi/CKsBSjkrfNL+XbIyuvax1H6p?=
 =?us-ascii?Q?UOehDL6ilifZSWe5etPR3QqfPLrTfaeMZFnWp5HbnEv9ql0oQ8AjpBM5LScL?=
 =?us-ascii?Q?iZlOEh87Xi7HcbpUDseIUH6aGqCF33IvYzMlim2IOwgttM3OJlknCY0nYJe2?=
 =?us-ascii?Q?h0i1JrqgLMPfGIWbIzmw6qZdpNRS93F+fDbNwN3DNT9zwvEtm8vQr26nelQL?=
 =?us-ascii?Q?/34jlewswj8KcyOFrYD7zgY+RUUMCuWZnViP7NIzVFcnHDbcQe8PjZNGPj3j?=
 =?us-ascii?Q?J0AZTbGM+RzagCdfDg0zCRRKQn4AobCFuoNiqpf+stCipuULPHKPgXuDE0ap?=
 =?us-ascii?Q?In9mv8l2Pw1FMJYcoErIzW6K6V+HyxpV5cwGRYZegDM0e7SH9KbTwfgcg5Wl?=
 =?us-ascii?Q?yI2vIjDbm49Cu2vPVE/OETTLad17/VD4/n0MJaCpuuhGNgnYZooys6lb7tS7?=
 =?us-ascii?Q?O6UGpTzRyGhx9mcRPWM1rGMw9nOLXWE67Pt7HBvgYzLxlbv3uWfdw/Tv4w/Y?=
 =?us-ascii?Q?ukB9lrPn0cKPRpjRcgXg2Huf2z14gFI4HwqBrrq+w/O1t4AaM2laStcN6iAv?=
 =?us-ascii?Q?ZX8M2h8iXNXJoa8lhRjgjb3GpM9ug/OtAphbpnfyndD9vlPYeQC7wh72/IYE?=
 =?us-ascii?Q?S3UJZh8f/XxzTL7547ES7BW7sFI1nLMldQ+1pbtWxVzQ7t/rUdOXFM8KWeWn?=
 =?us-ascii?Q?8LkmtZCDhBIN85VF1WByob5JRo4XYIH7Qr1w4RsWXbnhnqP1Ol/vGNOXonKl?=
 =?us-ascii?Q?eNzlpW2DWFTqdCRFBA2q85ICd5ZK5q0PYnQuzWYEpD5e26kFuC83GlgviciO?=
 =?us-ascii?Q?WC1kvSySIox+j0JaqFBEmCspn5cXt5+W/9wTMcxQmhawCcUBoCMZuInePLY5?=
 =?us-ascii?Q?Wac1gOjTcF18uF4iPX79L4t/2+VvZHVaoamPfwbzOi5wcHCGgXyguIBLXdjl?=
 =?us-ascii?Q?U8LqATerC/SHIXR48XQyUDCIK2AEsoizZYGRrK4mLLmxum+r3DwZf07HGr10?=
 =?us-ascii?Q?QgniyU+AEumvWODrtcMKYcJEiP0I3xh+IS+wVWrcW8RHm7BW524EFqI4kmbu?=
 =?us-ascii?Q?k4fv4kildduBUAf9rdGbFgtpQVyBAmwT1wQf?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 03:22:49.0986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a15d005-28d4-45a6-780b-08dd95bb4430
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8467

An impl driver might want to allocate its own type of vIOMMU object or the
standard IOMMU_VIOMMU_TYPE_ARM_SMMUV3 by setting up its own SW/HW bits, as
the tegra241-cmdqv driver will add IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV.

Add a vsmmu_alloc op and prioritize it in arm_vsmmu_alloc().

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |  7 +++++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    | 14 ++++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index cb93eff4d9ab..a455ff97e53e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -16,6 +16,7 @@
 #include <linux/sizes.h>
 
 struct arm_smmu_device;
+struct arm_smmu_domain;
 
 /* MMIO registers */
 #define ARM_SMMU_IDR0			0x0
@@ -715,11 +716,17 @@ struct arm_smmu_strtab_cfg {
 };
 
 struct arm_smmu_impl_ops {
+	const unsigned int supported_vsmmu_type;
 	int (*device_reset)(struct arm_smmu_device *smmu);
 	void (*device_remove)(struct arm_smmu_device *smmu);
 	int (*init_structures)(struct arm_smmu_device *smmu);
 	struct arm_smmu_cmdq *(*get_secondary_cmdq)(
 		struct arm_smmu_device *smmu, struct arm_smmu_cmdq_ent *ent);
+	struct arm_vsmmu *(*vsmmu_alloc)(
+		struct arm_smmu_device *smmu,
+		struct arm_smmu_domain *smmu_domain, struct iommufd_ucmd *ucmd,
+		unsigned int viommu_type,
+		const struct iommu_user_data *user_data);
 };
 
 /* An SMMUv3 instance */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 61a3f9134a9b..8a13d0102c05 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -396,10 +396,7 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 		iommu_get_iommu_dev(dev, struct arm_smmu_device, iommu);
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct arm_smmu_domain *s2_parent = to_smmu_domain(parent);
-	struct arm_vsmmu *vsmmu;
-
-	if (viommu_type != IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
-		return ERR_PTR(-EOPNOTSUPP);
+	struct arm_vsmmu *vsmmu = ERR_PTR(-EOPNOTSUPP);
 
 	if (!(smmu->features & ARM_SMMU_FEAT_NESTING))
 		return ERR_PTR(-EOPNOTSUPP);
@@ -427,8 +424,13 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 	    !(smmu->features & ARM_SMMU_FEAT_S2FWB))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	vsmmu = iommufd_viommu_alloc(ucmd, struct arm_vsmmu, core,
-				     &arm_vsmmu_ops);
+	if (smmu->impl_ops && smmu->impl_ops->vsmmu_alloc &&
+	    viommu_type == smmu->impl_ops->supported_vsmmu_type)
+		vsmmu = smmu->impl_ops->vsmmu_alloc(smmu, s2_parent, ucmd,
+						    viommu_type, user_data);
+	else if (viommu_type == IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
+		vsmmu = iommufd_viommu_alloc(ucmd, struct arm_vsmmu, core,
+					     &arm_vsmmu_ops);
 	if (IS_ERR(vsmmu))
 		return ERR_CAST(vsmmu);
 
-- 
2.43.0


