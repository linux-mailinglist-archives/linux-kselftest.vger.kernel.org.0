Return-Path: <linux-kselftest+bounces-19372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E50C99971F7
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 18:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 142231C2344E
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 16:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98F71E231A;
	Wed,  9 Oct 2024 16:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="spd7Mw5w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDB21E1A3F;
	Wed,  9 Oct 2024 16:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491953; cv=fail; b=sW91hhhwPHRiEWTqPO3b2HzZXcCZmJljEOxnDZpBy60Y71bfwYfj/KF/UOjEF6EuChfZJNR+yY7lMji+CAeTl6z9dhy/G38BtTFuT9w4gLQO4v25ajDRfB2DfbcD7A3BWh2VZDWJ5ZzxhPb3koS7beYZxfc2bUM93EoIs2eE8bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491953; c=relaxed/simple;
	bh=o4A1hjfVhyPN52avq/8qqR7dNJvSjSP0gpwJ6WMjSW0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SyyNNWfHzGRNTFner82qlSUTJDk7/7OhT28+xboJPdDJuljQgV0CE17+ATAP6hFe6EWAgSp0+V6Lc5jkS5ja8GefwAAfd4XbP5WEHXprgEBcLr2njh3bFS54G4ycp4un6ghPl1F4i65ylSbwUns1FE+FGGBNFE0OZTpfj1Tu/Nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=spd7Mw5w; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1dfZyf1iPomqBrKw/hZwXA9JGWfwlwii33zmK7bNOz5LKb5N3x+AM9S4JwJaYbxpPVJYY3TKKnuYpJr+lFPwG3FLwqOY3ZzFm0QaFFtvAF9rG16kTiubKNibP4A45wSKsRgxLy2XMoaVZIc+mB6KPDIh5ZqIs5ZqGMCmpQ4KTiN7zSmcGlnczJHgCVUh84tKwYZHe0keHMVTzuT4BcfAFfwu3c7YnVmOgOZV6lo18QRnHjjB4xzM4Ndi5BdhEkIP1FR0B4z1QZDVKoCp7diRDf9SOgMX8ZPUgXPFF4LaP29+0o5LSoH4Ej8tFC4YPvdS20Y2pb+jTd1gzQzPc719Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLy400uiJ+RNhHjJtJn6Vi8pTInvPlGsODVvzJl1GvA=;
 b=PAJK8QxdAUzEABV1Au7O1BvFTClUuZJ9zWez98NtyW4wt203ICWwZFhEqsSFhR7E7uj22MqcJo0sj/OS7w2QUCzmON0CPkqIPqJ8L7N/2lQSLfUJ7m7FoBLf7c8ghXLZ5xulSHOsFGA0p98zYpVqekV77DarzaKg1embuKdOG5O9HLGXKZCTKU7g/DUpR5bEn4cXzLpSSLaQnieAWIMswNilN0Dq/J5sRsacGTI/P5lEvrOkTaYWEPgtSh0cBmgJmRqG+yPcxzy/1lGaqwYdxcKbs4IaQF7FzvqHY4BOoMYCrhDRtGGoOOhh9LZT28hndJNqitW7m1ZMI3Z/h8dIgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLy400uiJ+RNhHjJtJn6Vi8pTInvPlGsODVvzJl1GvA=;
 b=spd7Mw5wBgQha/RtrK5JKiO0MpNM9eKv8jue/yJFavgS5W0N5KgVKqUC80sEkvTHSpl7Ahd+cYfGcyuj/NzWS2ZBSpMexXpzs1Qv0Flmx9Sz2TIcaEuk7asatpHpFWBNcO8CgpgRPHzr+vjEbAr2QK7i1Uzs3ZOokbsJLTxMZiosY1wguD7QbDt2y+NTAehLA9+01/GUCtXUilIfDRGc0oPkMReZAVWCm2xC+r1beOfgSQ93AaZGBpsVXFMBTE6jw2ul0eYZUnS7twTk6yQyvVAEnE10Z41Oc5x1Jc12bvlRwLV1letvwS8ObTPr12frA844RHA2lADUWLPNUNGcDQ==
Received: from DS7P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::15) by
 IA0PR12MB7601.namprd12.prod.outlook.com (2603:10b6:208:43b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 16:39:02 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:8:1ca:cafe::cd) by DS7P220CA0008.outlook.office365.com
 (2603:10b6:8:1ca::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18 via Frontend
 Transport; Wed, 9 Oct 2024 16:39:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 16:39:02 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 09:38:54 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 9 Oct 2024 09:38:54 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 9 Oct 2024 09:38:53 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v3 11/11] iommu/arm-smmu-v3: Add IOMMU_VIOMMU_TYPE_ARM_SMMUV3 support
Date: Wed, 9 Oct 2024 09:38:11 -0700
Message-ID: <562f2bfae1661e6ff6abdb280faa0dd49df9fbdc.1728491453.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728491453.git.nicolinc@nvidia.com>
References: <cover.1728491453.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|IA0PR12MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: a20c2570-0e14-4ab2-32a1-08dce880e1ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/ANdbQzA9G8jnzbou7rq1e+I+Cai09rWasWnUsQOcR6bb9b38p7audkKdF9H?=
 =?us-ascii?Q?9zQ9pY7TuNu5KRTmSvhTvGnvk+LJMO7WVh7oGjoU7VrixAbWejaVWCWSiIok?=
 =?us-ascii?Q?ttOoUzlgvanBVba2B2hZRpNkQhLDe1O10zUNvj9aagpuEN+zHLmfVGVfMeVP?=
 =?us-ascii?Q?Vqt+yH6Rd74QHMgbajIQvaXvSsx7Iuzh6q6sR6tNnj8FupluGNVyQ3vcZqTn?=
 =?us-ascii?Q?TKkv+Ms2gwNRPTsPdY+dWkzPLS/Uf181hQ0Ug9h7OySY3A4iqOE5pQtTvNnS?=
 =?us-ascii?Q?IyoySZwkN7/Cp9wOR2gpgxiFtXCQyqLUjpr35RqI4QGG4W5JJJOumkLS5pnZ?=
 =?us-ascii?Q?c5lYfeqBkHw1GLwXUSWwCLV6WXEKYmMIvLL3dhwyuADDIAo2A9kgHMdM5tS2?=
 =?us-ascii?Q?mpoOAb12f/yZfAbujsRctGtUy+7Dv+MUmcwFrlyKaUyBLI9KfPC7/3a1zzp3?=
 =?us-ascii?Q?FNdEfg+jqlPUPLDq/mJAPiqnBzmmKvzTmn0/cUaZ5rZlZlc4Z0FAHevI95Gq?=
 =?us-ascii?Q?3CYX0nQAM2PJyKJiYfJXZ4ls1cisBwePeNcuDtwdLVkKz6jOs7fKNw5C7q86?=
 =?us-ascii?Q?eEK2xbLZbXuFprFDTRrOpL0DoqVJcsJkN/XFpRzEeKNkYNjYYHi60U70DlR5?=
 =?us-ascii?Q?64Jy5EJOLI3cVie3QDoAiTUQeq6fhqpZgYShxZ/teCGPxoKWcA3xA5zgON3C?=
 =?us-ascii?Q?zESEGdTrJx+c9Ul8VkNAaIjppsnup0gea0pSzlwUwU/Vz3Re0O6nKjQYJXRL?=
 =?us-ascii?Q?p3TMgPTCr/mleKF0G4Wg3GUWisQbfgsEHRogMgvAbYGq9TCkjYXfx3+UTf3R?=
 =?us-ascii?Q?YTnGyxxy8cSWOlZjulVO/IQ0y1ZMfHmiHLllegnolIP5ONQvbcX/GWtDFWj5?=
 =?us-ascii?Q?0QaZIkOhtzlRbBUOmfeBhQmu9K7t/XNI1I6SMzHxd23kV4JYs3/csi62INhd?=
 =?us-ascii?Q?ojGPfuGiFkcwSLuPmVoCQCxYfPWCIPN746BDKZONGstXwUSCCW8+wKQEBu00?=
 =?us-ascii?Q?0RKzWzm4yZeHQaK4HBa/NPnbq7UdTE/XjxQLDF93AGMvyjw1xvOhJ6xruK52?=
 =?us-ascii?Q?yQUcbmLnv6g0Er0Ryl2iT9erOfbqeq0okyUDwfgHv5xJdgnlC+vUGZY0SKoG?=
 =?us-ascii?Q?W5ZXYq0VtDwC0vuOHyK1kNJK5n37SBHeTsIx/UEuet2p/P7nH5M5FNSmhwZW?=
 =?us-ascii?Q?FLpSxcy7d4aztvWYPDh0/AF45J2MSnM2qlIfXGqwG/JvNWDrjWm7AhVgpcVy?=
 =?us-ascii?Q?zSmCaRkKzF4hPFb3cnQS+OjHKi1a3MFkG00SfxH1brYnhyR+YOJH5c5vZv6L?=
 =?us-ascii?Q?+zAn8W6guLMImqDzdVOqRvrpAxaUkw0x4c3udy+F57PzgzdHc0Img68RpAoZ?=
 =?us-ascii?Q?syQI3hs5BqiHcVOiwyG+sslTrKB5?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:39:02.0100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a20c2570-0e14-4ab2-32a1-08dce880e1ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7601

Add a new driver-type for ARM SMMUv3 to enum iommu_viommu_type. Implement
the viommu_alloc op with an arm_vsmmu_alloc function. As an initial step,
copy the VMID from s2_parent. A later cleanup series is required to move
the VMID allocation out of the stage-2 domain allocation routine to this.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 18 ++++++++++++++
 include/uapi/linux/iommufd.h                  |  2 ++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 24 +++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  1 +
 4 files changed, 45 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index e394943c0b4b..844d1dfdea55 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -10,6 +10,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/iommu.h>
+#include <linux/iommufd.h>
 #include <linux/kernel.h>
 #include <linux/mmzone.h>
 #include <linux/sizes.h>
@@ -1005,12 +1006,22 @@ tegra241_cmdqv_probe(struct arm_smmu_device *smmu)
 }
 #endif /* CONFIG_TEGRA241_CMDQV */
 
+struct arm_vsmmu {
+	struct iommufd_viommu core;
+	struct arm_smmu_device *smmu;
+	struct arm_smmu_domain *s2_parent;
+	u16 vmid;
+};
+
 #if IS_ENABLED(CONFIG_ARM_SMMU_V3_IOMMUFD)
 void *arm_smmu_hw_info(struct device *dev, u32 *length, u32 *type);
 struct iommu_domain *
 arm_smmu_domain_alloc_nesting(struct device *dev, u32 flags,
 			      struct iommu_domain *parent,
 			      const struct iommu_user_data *user_data);
+struct iommufd_viommu *
+arm_vsmmu_alloc(struct iommu_device *iommu_dev, struct iommu_domain *parent,
+		struct iommufd_ctx *ictx, unsigned int viommu_type);
 #else
 #define arm_smmu_hw_info NULL
 static inline struct iommu_domain *
@@ -1020,6 +1031,13 @@ arm_smmu_domain_alloc_nesting(struct device *dev, u32 flags,
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
+
+static inline struct iommufd_viommu *
+arm_vsmmu_alloc(struct iommu_device *iommu_dev, struct iommu_domain *parent,
+		struct iommufd_ctx *ictx, unsigned int viommu_type)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 #endif /* CONFIG_ARM_SMMU_V3_IOMMUFD */
 
 #endif /* _ARM_SMMU_V3_H */
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index ff8aece8212f..6ee841a8c79b 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -857,9 +857,11 @@ struct iommu_fault_alloc {
 /**
  * enum iommu_viommu_type - Virtual IOMMU Type
  * @IOMMU_VIOMMU_TYPE_DEFAULT: Core-managed virtual IOMMU type
+ * @IOMMU_VIOMMU_TYPE_ARM_SMMUV3: ARM SMMUv3 driver specific type
  */
 enum iommu_viommu_type {
 	IOMMU_VIOMMU_TYPE_DEFAULT = 0,
+	IOMMU_VIOMMU_TYPE_ARM_SMMUV3 = 1,
 };
 
 /**
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 51260f63be94..5e235fca8f13 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -212,3 +212,27 @@ arm_smmu_domain_alloc_nesting(struct device *dev, u32 flags,
 
 	return &nested_domain->domain;
 }
+
+struct iommufd_viommu *
+arm_vsmmu_alloc(struct iommu_device *iommu_dev, struct iommu_domain *parent,
+		struct iommufd_ctx *ictx, unsigned int viommu_type)
+{
+	struct arm_smmu_device *smmu =
+		container_of(iommu_dev, struct arm_smmu_device, iommu);
+	struct arm_smmu_domain *s2_parent = to_smmu_domain(parent);
+	struct arm_vsmmu *vsmmu;
+
+	if (viommu_type != IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	vsmmu = iommufd_viommu_alloc(ictx, arm_vsmmu, core, NULL);
+	if (IS_ERR(vsmmu))
+		return ERR_CAST(vsmmu);
+
+	vsmmu->smmu = smmu;
+	vsmmu->s2_parent = s2_parent;
+	/* FIXME Move VMID allocation from the S2 domain allocation to here */
+	vsmmu->vmid = s2_parent->s2_cfg.vmid;
+
+	return &vsmmu->core;
+}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 4b836a5e9fde..6a23e6dcd5cf 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3541,6 +3541,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.dev_disable_feat	= arm_smmu_dev_disable_feature,
 	.page_response		= arm_smmu_page_response,
 	.def_domain_type	= arm_smmu_def_domain_type,
+	.viommu_alloc		= arm_vsmmu_alloc,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 	.owner			= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-- 
2.43.0


