Return-Path: <linux-kselftest+bounces-35913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9038CAEA701
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 21:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FE7A18992F0
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 19:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8052FE324;
	Thu, 26 Jun 2025 19:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GRl/RXRf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1762FCFEB;
	Thu, 26 Jun 2025 19:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966568; cv=fail; b=GVIUU9wpRvGb/cJX+aktpErhbT2q9rmYrZ62Zs1YYgVwnPgfnQj0aC4wO0XfjTeF6FyYV7oYIljtok78ZDHxMLPJIJnL3/39fi0d6jkZ101RFXa8591yjtOzxqdX2YSwKG4vp9Qikd8O+t1rL+TUSWLwxnbFrxp90+pVjA6zCgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966568; c=relaxed/simple;
	bh=aOQV7q5Rh+wOKG7a2JXRyReyFSc6WjZwicPo/YTohyY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fQwE1yRbPfDrzy8cVcCP8AQdEoSdkVFAUe60Rnjrjr1I+hlHfVKGbdCpT210MenKuqeJ9UW+DDGP12FtegW3frwsB5BSWE182HCL3XCjF055n4ZkQnCPM/fbQeZOA4hR4Wsmg9a5VGZPf3PEJQgE0+qkr3K2dyNHLoVKXeYlsLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GRl/RXRf; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/pCZOAsN1gOsNQ4SPgk3DRSxS7g37W4JhttW3rBDwv19qMLZs6WUOJruDI/DG/YlmrFakqCMLX4YFYOSfLuFga6CoDXGYObiprFJUxpOTI3kGcPG+YW/pvW3EjZvOSiCs2w9PgiS04nbC9NFfCJRvYL4+gaiFsitjks6OUkvWXwZzBEoipzdjakTttTuMZjaji6pJUUSqCOKX6wV1frfh+CEuuhI8MVQXEIs4ivLSYpREwgKIGT9bBwBQHuMaNH+ANL/mlPwgiNA9BgoinaiEEEahITmXG+3qsqcaD0W+Is+VaD7rWCq6FDYewr1rL9ow6em/ZITz5TdjsO3h9P7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGQv4nX3+fVhV2cw+RUxw8zCOhYFEiT5kmRO1XEu5Xk=;
 b=Ndm1zx6DkyoN8YBItpB0AzkPGQElRwGm7o79FpEfpoMyFzt/D/IMgkyBFveaQ0kwVz6RV6yNxI4Q81SDj2VqQu+jv/Y6W9/hbiLVm5KQK3nbcPNgaLVmCOL3p0Ii1Iko2WuJ/XsrPVAafWShq01SrKlLpa08QRCT55H0CQ4+qP57FlbW5YlEC1LRrwW1ctsgI07moCVm0GTKLBfbPHmcBI4c8CbguyEkGkMCv0vzBqeJw0+R94GGiV3hUH3x1xZo2sHkOVNpjdniTK/ggl+Pi4gKr0lv/kuZUTZAMjPMdGgLOZpkUHqyfDS5vp5DwxiCYKAiFuZnDgqw8WBGjfvhAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGQv4nX3+fVhV2cw+RUxw8zCOhYFEiT5kmRO1XEu5Xk=;
 b=GRl/RXRfAhmhTLJ6qgcPACpx6lQaMI3rv3nOwwwxrHV+ExkDiQ2hjxeSruJ0oK86asP/q1201h9vI7jPS5/AyaDzVPFRYtp2g8Y/ERtObrJFuhU8R/kyWHcP6yRXAmFHGyWmvIgq+1Op+YtzQ7gZkRnW4jRJ6ztLmStPB8T9E/PgOnRAbGHqX+UvDDPcxDDgcIpsbGUzmZnbp+HmgpYh4QnwbYvIpPIKnYy8sJknNIkgPo+s/wkzBj6ruWik8kBZmUNuCm4gtw8uPCx6/qYe6L32cLLelIaC8pnGI8hHOHQkKfBKYrquYckXdUNKuMbAq7Z3pxLcvpmBwFn4o6tXqg==
Received: from BYAPR03CA0004.namprd03.prod.outlook.com (2603:10b6:a02:a8::17)
 by BL1PR12MB5729.namprd12.prod.outlook.com (2603:10b6:208:384::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Thu, 26 Jun
 2025 19:35:58 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::80) by BYAPR03CA0004.outlook.office365.com
 (2603:10b6:a02:a8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.21 via Frontend Transport; Thu,
 26 Jun 2025 19:35:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 19:35:58 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 12:35:38 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 26 Jun 2025 12:35:38 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 26 Jun 2025 12:35:37 -0700
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
Subject: [PATCH v7 22/28] iommu/arm-smmu-v3-iommufd: Add vsmmu_size/type and vsmmu_init impl ops
Date: Thu, 26 Jun 2025 12:34:53 -0700
Message-ID: <d7cb46694a628cde0482a3feaac1106d37ccbeba.1750966133.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750966133.git.nicolinc@nvidia.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|BL1PR12MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d25698-861c-4230-e90b-08ddb4e8accb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/CVUVz204v5L88Xj0m9JgAaf0XSGP+1u/bzNky0L4/Sk+a6EVw0/NXQtGAJX?=
 =?us-ascii?Q?bVNnlGqsDYRTxv7FCXEEYvzX/467aInucpYHsntqZQ17F/4IZFf0LDQai3z5?=
 =?us-ascii?Q?4xtT7WBk7H2Y6XBk5coIGv2iF2LOXQuzP2vZ7RxQbA6+ICtazd/goBVGTcIB?=
 =?us-ascii?Q?YqfL5kS0FTp+3HWMvzo2ktDMb0b8ZWt7XqtZqVnhX0CJH+pJT5spUKyYVtYk?=
 =?us-ascii?Q?91+4kFqXtEteqWBWNv4sjz6gD/rls8oDOgMf4oYujFIDAhWCi/VwEq60MEvA?=
 =?us-ascii?Q?AmkkXcfItzHLZzdT1d1lrP7jAXh43B/uMfbHwiBCIXKS/0mOEVc2bt/01gMY?=
 =?us-ascii?Q?90tG7HQ5xmI6ifKGBPDP1N/TtPeDRRpFD4QYfDAQ6N95hVPKQE1bfu7YxuT+?=
 =?us-ascii?Q?NOTLESYD4vRSJcfQ3+x6eituSZfXELrXWzOMu7BwvWZpUq7iRV6DweGX/gBi?=
 =?us-ascii?Q?dKCwaTgqpUwkS70ELSraPGOCr0WiyEhaJNZM3arlUgaz95rhsj01ixtbwEwY?=
 =?us-ascii?Q?bT8Dehb/wOlIFhu22gx8pcCQasFVwZitXoj/dO3JkKQE3nOaYUb015t19nh4?=
 =?us-ascii?Q?HChG5+s4CPCHHlGODPBa+R/p0rt3zPBgZts7qvbHrYz7l1aOeMYHa1k2on6b?=
 =?us-ascii?Q?1sZ9/RjqymhvTq88y5CIskUHE74i2YCkEx1YCUk5x3RkZfYNZhHeyjKqtJJ7?=
 =?us-ascii?Q?uyQIYOUuMp4tUGtXRK0hG+w/UUjiI4OE/WFGK/troz4jcLkXMLxVksyxaGtB?=
 =?us-ascii?Q?BGwf/7OkhLzg1pGIrE6H6S857BE0+wKg/oEpohE8kjdl1gonkc7OMMKgmmUw?=
 =?us-ascii?Q?X2XtWRjiNaH0xrvKIT33JURHn/zDDVmp8v02I5vjotPxzCbt94ny1Kz9ldvp?=
 =?us-ascii?Q?LtskMx1AF89VbMGIsllqwB5E/JB5m4XcDH9r0mt2Wl7NVH6NlYvuL1Rixq73?=
 =?us-ascii?Q?Gi/9Et2O/hm6LoMcv2uxwZVYlBOFn6AXxWUoChg7OtwFSwE81Qm5sqoVsF5f?=
 =?us-ascii?Q?PySLk3XisxhPw3MuiW5gsUG6XREW/Bk08oN1bBQkzOkx3Trd2N0tq0qeqY3B?=
 =?us-ascii?Q?Waq66hsFrba9AA/pt5TM9H4t9NsMkNA5R/aR3kKRyazl8imf83k/PigW8IwP?=
 =?us-ascii?Q?2P930pVqkJIaUa5sRqsUuI/uH/PpaVZZiSSpHnZ0FdAQmvoFnAWIrdWU1t/X?=
 =?us-ascii?Q?YhRDJi784BN0D2UmncGxIjtl+N4KpSjxgyG5TDBZTfSyyPa8oOvsU8MhGx12?=
 =?us-ascii?Q?eNgFfZljuW7/hKTAfVtSuyPIZdA4Mpuu5sAOlw4PZHuht+PmH71JhBgEjGOB?=
 =?us-ascii?Q?NOHULr4fwHkFmKcICuwycazfaU5CeK9qjorZGXjajjt2LjyLaDid9pHqYX7f?=
 =?us-ascii?Q?r7LR9aMIuQJZf0Bh28fVkVLDrXorPFfGs+4kVZSpERVohoEzuP0fl6oXWttz?=
 =?us-ascii?Q?+7sI8/ClvGTWSM4EiM+2tGb8S5PVXSIPAE16IjGONTQ9Jpks3BXJ3KX0eQxl?=
 =?us-ascii?Q?Xku+dtCF2bfkKJjm0uZZLbkv+TjhBhFU3iCR?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 19:35:58.0248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d25698-861c-4230-e90b-08ddb4e8accb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5729

An impl driver might want to allocate its own type of vIOMMU object or the
standard IOMMU_VIOMMU_TYPE_ARM_SMMUV3 by setting up its own SW/HW bits, as
the tegra241-cmdqv driver will add IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV.

Add vsmmu_size/type and vsmmu_init to struct arm_smmu_impl_ops. Prioritize
them in arm_smmu_get_viommu_size() and arm_vsmmu_init().

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 5 +++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 7eed5c8c72dd..07589350b2a1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -16,6 +16,7 @@
 #include <linux/sizes.h>
 
 struct arm_smmu_device;
+struct arm_vsmmu;
 
 /* MMIO registers */
 #define ARM_SMMU_IDR0			0x0
@@ -720,6 +721,10 @@ struct arm_smmu_impl_ops {
 	int (*init_structures)(struct arm_smmu_device *smmu);
 	struct arm_smmu_cmdq *(*get_secondary_cmdq)(
 		struct arm_smmu_device *smmu, struct arm_smmu_cmdq_ent *ent);
+	const size_t vsmmu_size;
+	const enum iommu_viommu_type vsmmu_type;
+	int (*vsmmu_init)(struct arm_vsmmu *vsmmu,
+			  const struct iommu_user_data *user_data);
 };
 
 /* An SMMUv3 instance */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index eb9fe1f6311a..2ab1c6cf4aac 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -416,6 +416,10 @@ size_t arm_smmu_get_viommu_size(struct device *dev,
 	    !(smmu->features & ARM_SMMU_FEAT_S2FWB))
 		return 0;
 
+	if (smmu->impl_ops && smmu->impl_ops->vsmmu_size &&
+	    viommu_type == smmu->impl_ops->vsmmu_type)
+		return smmu->impl_ops->vsmmu_size;
+
 	if (viommu_type != IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
 		return 0;
 
@@ -439,6 +443,10 @@ int arm_vsmmu_init(struct iommufd_viommu *viommu,
 	/* FIXME Move VMID allocation from the S2 domain allocation to here */
 	vsmmu->vmid = s2_parent->s2_cfg.vmid;
 
+	if (smmu->impl_ops && smmu->impl_ops->vsmmu_init &&
+	    viommu->type == smmu->impl_ops->vsmmu_type)
+		return smmu->impl_ops->vsmmu_init(vsmmu, user_data);
+
 	viommu->ops = &arm_vsmmu_ops;
 	return 0;
 }
-- 
2.43.0


