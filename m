Return-Path: <linux-kselftest+bounces-19366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC99E9971EA
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 18:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA5D21C23545
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 16:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE29B1E0B7B;
	Wed,  9 Oct 2024 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ou8DOyd2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C511D4176;
	Wed,  9 Oct 2024 16:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491947; cv=fail; b=FZ8RdNGYqKwBHunuUinRWH9W2cI9nVOikGOJFVhkmZnPuuKyaypLOnaiOdMpc0JOTQhrLspy5kwKx/U6OkzFcagWhTrPldJyoMIlUzOsRZhxiXSx2S5TjXlwgzaFR3YyzGJ2Iwm+4reMJHmtzRkefDXZiWUObR2xxwYQ11s2PcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491947; c=relaxed/simple;
	bh=f7tbuO6MTwchzlxWzoZEiV+/Ji3dI8j5wHlV/MY/bdw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UvivPIbNg611eWH4/rjSqE6qWriV54kA4vfBYdffG7WFrAGC1zQqAmhf1fD3HCqG/koQwWXdCIh++n8JaSjdb5WifFiuae3GnMFNJ9kfptgFnKFD8oSwHEW6G6zAX8mUC4xERm5YNIULVAhY0Uo1331IPEAgqKiFTtsy+dkGY7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ou8DOyd2; arc=fail smtp.client-ip=40.107.101.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XA3yJB3hV9D8ezBKAr7b2NibOtxIop81Xq4r0NlkinNnmWTpn5ClylIPtItoGfH/x39Rr3H6EnQLv3pQl34brUnwyntd6+66LahyNnx1IthsBNIySo9prZfoVDAe2YnmFysm+gvUh1RCrjy1GhTV4+M6hhIpMXzHtC1gjh+hZ4r3fPt1PEOquaMfWkQ3FY+XJs4aUSrghkAF7YH+YCzPiwrVvdhsvXCyh1bjUbCt4Nh7ZkA7nFjuxJJb8XZWCnc4NQJtq9JJ5BxHoGpSDw5cTPL34grdWN94t2Q2EP4CQLJO/+YJuKOM1VEo8xgr44oqys4qCBABMyaVyARciJ1EWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbyxRVmZSVIo9+hIvLvnktC8eUsa67K5lJbGGR93RTw=;
 b=YUFjvzeDJvF/KA73srnkKC5S6okVs1yUsFQChTqK1wxjhuUzHUPbHgwIUSS/CpQWSi2gL979lca8ORX5DVon6fU6lqMEXRfvwNY5E6TlnirM/xiWtu99c4jY6qc4q9NnGY5/UT59RECGJcgsww6sqo0G3kgzKAhBE8oRslg9yWw9+AtHKTPyWuxU/u8WTZMHsHZJABXT3hlQslUhXTvU1OXvojUYOAayCJZuYiYe/SoQeTfR8czIbmb3nzP/tqyQsm34GQNVndV95gCnsSo/8URnjSoPpNfL07a+moQGlZ1beWhlmQl/HlK+9O1+erHflMOQuYgdeLLl7ExhyAit2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbyxRVmZSVIo9+hIvLvnktC8eUsa67K5lJbGGR93RTw=;
 b=Ou8DOyd2qVm3ot41iZWT7OxoSKUQIas8GJJ820bXvz4KM19rQJP0MHMh/8pZOci1d/I3cpiDX12iqXEMR7hnA48lErQ2GwYqRnC9FDeuuRp9faCf+k0JRq2f9A4Bux8sLf7rMGU1cDlurtLvjOuBAD9wK9+BzrDuFTSeiPCas89gUEqsK/hGdV2i2zZEfF1V3Hfj9ygHXTKNMTGMYVeHw2U9FMsiJ2bLZsrD5wkIU9sDDeQ8eK7CZjyhbJBTvoxBDlWdQu64FAEUeNRcZmJ/tK9BbLc3TF5VidXchgUS+th0oqhccAvBIYgnFN6OgLdGRah/k2WroevUP/wHmWibnA==
Received: from CH5P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::27)
 by SJ2PR12MB8009.namprd12.prod.outlook.com (2603:10b6:a03:4c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 16:38:52 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::c8) by CH5P223CA0001.outlook.office365.com
 (2603:10b6:610:1f3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18 via Frontend
 Transport; Wed, 9 Oct 2024 16:38:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 16:38:52 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 09:38:46 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 9 Oct 2024 09:38:46 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 9 Oct 2024 09:38:45 -0700
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
Subject: [PATCH v3 05/11] iommu: Pass in a viommu pointer to domain_alloc_user op
Date: Wed, 9 Oct 2024 09:38:05 -0700
Message-ID: <781b5bddb195bffa2ba80e5a04cb10336db74c03.1728491453.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|SJ2PR12MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: bf181ab7-f500-437e-1a74-08dce880dbef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yuFiYe+MBhhorhxkxZShmIF1suacZbhEYNm/GTu9yzjVYEEDDU9oMvO5kITa?=
 =?us-ascii?Q?16bIYrZTNqrCzvxW6aHFMFRlNKvyvh4KA2wOxyUv0r8TexChVDJQQI7Lizrd?=
 =?us-ascii?Q?MYYEoRlL0j4qdxRbm166xwkZC1r5tInCYbA7gXSI1zTcSHRRh0oKlztAnsH8?=
 =?us-ascii?Q?JQMXOlKb9w9EnCyNJypf8BB301rXfRnGzAQWpfk171tJTAV89uRd4jsNSMlp?=
 =?us-ascii?Q?SP9u02IXHxbPWXoSSQxAGqyxwZOnin7nzb5eHp3rRPujo/oAMTaC8blVdfR0?=
 =?us-ascii?Q?UR/ur6gsQGABRfS479wumlxZL43eZI2mjwX0HcypdF5yX+wpQqtczrS0y3M7?=
 =?us-ascii?Q?2YlO/EHVwEzNfi3j2BvIRX2EPn6yYMd4LFUBqo4qj+cyc2K+stpuqUYhgwnv?=
 =?us-ascii?Q?kSsvUl9TjSPHor1htTO8qF9hI7FsDquRk/8nvy5X9HVE6rcL6peRYDBRfXHW?=
 =?us-ascii?Q?20PI0i+LskBvXkbz/H9BkxjnLZvQbSSJMpPoLRDUY7BHGvTO0Rj/AfSBCpOt?=
 =?us-ascii?Q?if32jQ4VbxjaCJfn6DGXvPtpaD1sjcYX+bGShNLvN2Wbp8jDQEsa5EyG+Lu+?=
 =?us-ascii?Q?Dk5maA7J7PhZAVHip4/QiO8FfsnhHnvgZsnQT26uz59ITqmVwqBXNy7ug+IA?=
 =?us-ascii?Q?1qg1pFeuXM3VyLfywDZNvN02kqSXBccG3ewz+pxoqueNOP+3PYxAjJw+3CLK?=
 =?us-ascii?Q?ienn9QBL6l8xQEBIJuEfvS8y0yS4dCihG0Vq05Gvej3tk8xc7m81Pgd/gVY7?=
 =?us-ascii?Q?v2YwcAZRm38R/Qlo7McaJVT0jyFq3tt+biT+v7W7VmIUXHFT9CaFPDOPJamM?=
 =?us-ascii?Q?6A1ZRRK3qqafSZmdlqVb5z7umIobVcUcUQuJWMvvtiAcYf38O4/AhAeZgaOL?=
 =?us-ascii?Q?P+Hho7BHRqOpZwTqxIveAlv8P7XUsYTg+7eG3q99UmZtJrRj6W7nLL6sQ5i6?=
 =?us-ascii?Q?GTwjY7DNmD5n03pFr69MFtI7BbCQFltZc4E885CJwKk5OAxxxqxlmgTGM4IO?=
 =?us-ascii?Q?E/TBaLPFA7q7MjpkPx0lP482zXA11mT47WuDS1RTuPkEA8swg5EjjxU6deY3?=
 =?us-ascii?Q?WhvWoRXYVi6bsJTcvPj04B0JLZXW0USOFo/xlGM+uMWnAkrQxoLwif6xIugR?=
 =?us-ascii?Q?xxL9FLuYb+gWv+V/Es1oMq6C626CcGh4VGUp2Ga8hC05SNGPK6QwYC6sjY1n?=
 =?us-ascii?Q?3SZyN0ArvwwpB/a1pu0OsQQvoxHqIKqeiQLT4IBR6vJvfbMAnhcbNH0idHoN?=
 =?us-ascii?Q?n5FRWklKn48cNpOgAbijD3WpoTlFxNcHHDtl7ST2KC36kO3TTfCImtcrh5p9?=
 =?us-ascii?Q?ZC801OxYiX6fs/NuleN+U1Fg1jSnWPuEPg4dqbhx4uUgtx8T61OS8yntirUV?=
 =?us-ascii?Q?HRkhrzGPyOcN44DTfZ49krUycOiT?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:38:52.1699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf181ab7-f500-437e-1a74-08dce880dbef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8009

With a viommu object wrapping a potentially shareable S2 domain, a nested
domain should be allocated by associating to a viommu instead.

For drivers without a viommu support, keep the parent domain input, which
should be just viommu->hwpt->common.domain otherwise.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h                       | 1 +
 drivers/iommu/amd/iommu.c                   | 1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
 drivers/iommu/intel/iommu.c                 | 1 +
 drivers/iommu/iommufd/hw_pagetable.c        | 5 +++--
 drivers/iommu/iommufd/selftest.c            | 1 +
 6 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 3a50f57b0861..9105478bdbcd 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -573,6 +573,7 @@ struct iommu_ops {
 	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
 	struct iommu_domain *(*domain_alloc_user)(
 		struct device *dev, u32 flags, struct iommu_domain *parent,
+		struct iommufd_viommu *viommu,
 		const struct iommu_user_data *user_data);
 	struct iommu_domain *(*domain_alloc_paging)(struct device *dev);
 	struct iommu_domain *(*domain_alloc_sva)(struct device *dev,
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8364cd6fa47d..3100ddcaf62e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2394,6 +2394,7 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned int type)
 static struct iommu_domain *
 amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
 			    struct iommu_domain *parent,
+			    struct iommufd_viommu *viommu,
 			    const struct iommu_user_data *user_data)
 
 {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 4e559e025149..4b836a5e9fde 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3117,6 +3117,7 @@ static struct iommu_domain arm_smmu_blocked_domain = {
 static struct iommu_domain *
 arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
 			   struct iommu_domain *parent,
+			   struct iommufd_viommu *viommu,
 			   const struct iommu_user_data *user_data)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9f6b0780f2ef..a8a66a954c27 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3522,6 +3522,7 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 static struct iommu_domain *
 intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 			      struct iommu_domain *parent,
+			      struct iommufd_viommu *viommu,
 			      const struct iommu_user_data *user_data)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index d06bf6e6c19f..77a1d30031d2 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -137,7 +137,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 
 	if (ops->domain_alloc_user) {
 		hwpt->domain = ops->domain_alloc_user(idev->dev, flags, NULL,
-						      user_data);
+						      NULL, user_data);
 		if (IS_ERR(hwpt->domain)) {
 			rc = PTR_ERR(hwpt->domain);
 			hwpt->domain = NULL;
@@ -240,7 +240,8 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 
 	hwpt->domain = ops->domain_alloc_user(idev->dev,
 					      flags & ~IOMMU_HWPT_FAULT_ID_VALID,
-					      parent->common.domain, user_data);
+					      parent->common.domain,
+					      NULL, user_data);
 	if (IS_ERR(hwpt->domain)) {
 		rc = PTR_ERR(hwpt->domain);
 		hwpt->domain = NULL;
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 540437be168a..f4be87b49447 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -319,6 +319,7 @@ __mock_domain_alloc_nested(struct mock_iommu_domain *mock_parent,
 static struct iommu_domain *
 mock_domain_alloc_user(struct device *dev, u32 flags,
 		       struct iommu_domain *parent,
+		       struct iommufd_viommu *viommu,
 		       const struct iommu_user_data *user_data)
 {
 	struct mock_iommu_domain *mock_parent;
-- 
2.43.0


