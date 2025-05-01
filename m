Return-Path: <linux-kselftest+bounces-32112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D09A6AA66D2
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 01:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23E00173073
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 23:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE75266B7F;
	Thu,  1 May 2025 23:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pAc8nHU7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867B5264F99;
	Thu,  1 May 2025 23:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140516; cv=fail; b=UXoxxR25RFnJput4oylrsiKM1QXArRxsgH4NLV3Kh8hhFgIsteUP63gH6GdESxaXIV5hwmEJRJGq6Tj9eix3bEL3RkgAVfh+DVE+sh2An+h7+td8VA5EpH2+YvGv8NRJ2zmZC6No8YWpz6sJu83CjYeXVmVFvg7AS9zQPTer9aI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140516; c=relaxed/simple;
	bh=aqBZb2lxBoQtM0cnsCEbE7qYUOd7l5R7PhquNvGjSig=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UA29+dfgOVyFnd8c5olAfJUAZWEtfUtxTWe0b96g7k5EFM850OQF3PHGHd4ZFFrBfLUfLONTnt7hUPrF0vDeZaUHYzr0sKrcWjQ2NUDI6PDI6bJxX+COJ14NhnhYfMnmTpLezEP4JsuuT3peUlB6i/WDmMA5pWIY1Tb6pF5Sfxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pAc8nHU7; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpFUPFWLVIKzU+839fEcp7NtOGiEej0Ezeq+1uGKjJJob1H4eHu8plfRU4iCMxyIWGt5Dm2wnM0QyNKqy0/RGYD+1EZXDgx1m1ksQjt47O6jq3iY7iIxSqR1gp7R2uktNt1PBYPX5ltYxrQS+48NEIfvan8SxYblzAS1/59WGDip9vx2jVIEvwoaz3dV1X+CRBO2b88mVZddAl0b353utqUNFiBHgeoKDnJCJcaKf83WOTsP987UZnK49MZvjASEiOrQyeXVf6S+agmrhiZ8II+i86f0+K4yo9wUiIVNOHGVqwIB9S5VPNMQsX2DLhqOGEOwBkAebIo0+sqQfntgGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCCcfplIonpAcwoOAGgQwS/AxWB3Zx4iT7qWbZrpypM=;
 b=JeIvnjhA9Q9lSxisUJ91sUHPgX0gfVXsbhr0ZaVUpt0LkDlOdKyvB8Lumz3GFeCo5d/L6jM05eu7OQAkOl3RN77L5+fmPlpYUSjhJMihqg7uIM8Z8Oh7SNpM03XsArcMIyjQt867+MvEP0FQVwtN/cg/7clRHZgCXRlcfiWyIRj+7Bh8yr9clgFyrxx2ftLJT0rdGkHnFPGx8TmBM+VWQQfHsKUlxxH83RuteJpe/9BJcF52CAvym1OVa6w7HQW5qAWLdlvgvaYEBu1N2ygcWMykmQQP5xvIauwrq04Zy8PCHXSycUtEMq6dlyUZ2tghU5k9XEPOsT+Qvrrj0XY9Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCCcfplIonpAcwoOAGgQwS/AxWB3Zx4iT7qWbZrpypM=;
 b=pAc8nHU7pQfy6vb4qvL4uAAZkwOOiq3ynnUvSK2S0QoBHyiJm/CSAPDs7cx4CVP0pDCil47rMCo0N3+MmPSObe6lsxapnAJN9WuvAsnv9sg1jhuv5ksYBxAvKrDwgtp/iJDxULi2G2ECJ58f2gpxrstAqeG3vzKohfk5ZWIzL8BSvFvtKzsfvkNjlj2s/NfGhTIu4S6sZKERoOEv/1slCeKu2Q8bgCdAg03A2Ka/JKxfFoNxlU5tfPVBkVQW7VHmFpQSl4IL64oZyk1nhBmclSSETC5i46fKKPon5SSFDQykjsZkGca2S/5N21kGa4+TCv7Wxrx0/cS9kCk+PhcqJw==
Received: from SA1PR05CA0023.namprd05.prod.outlook.com (2603:10b6:806:2d2::17)
 by DM4PR12MB9736.namprd12.prod.outlook.com (2603:10b6:8:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Thu, 1 May
 2025 23:01:49 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:806:2d2:cafe::17) by SA1PR05CA0023.outlook.office365.com
 (2603:10b6:806:2d2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.18 via Frontend Transport; Thu,
 1 May 2025 23:01:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Thu, 1 May 2025 23:01:49 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 May 2025
 16:01:40 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 1 May 2025 16:01:39 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 1 May 2025 16:01:37 -0700
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
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: [PATCH v3 02/23] iommu: Pass in a driver-level user data structure to viommu_alloc op
Date: Thu, 1 May 2025 16:01:08 -0700
Message-ID: <832c4116fde833ce36b3e6fd23f6bb98197a9996.1746139811.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746139811.git.nicolinc@nvidia.com>
References: <cover.1746139811.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|DM4PR12MB9736:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b48714-4e32-49af-49ce-08dd890427aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7JSQ/+JwdFA/rWHPsecqlJI7IKir6E2w76cdTMbPgA2DmJM8DNYke89UB/wc?=
 =?us-ascii?Q?cU1y85ZZbY0sC3mhXgiehxBXxEuwStUMz+xrdi6JyAQejzdnKM5cRfV6Tjpq?=
 =?us-ascii?Q?yztjcWlxx47WrHWLW0GlFpSLaBfcm+EnM3a9xFVD4yjzClV7b7vfIKIaxXYX?=
 =?us-ascii?Q?0C94dHCVvWSCNHcm+FeSYI0Wyu5u267RMqaKJaqSH9REZks2XG/poO4eyx4k?=
 =?us-ascii?Q?Dy57eeXdBFEt+n8U5XrQlM8OtylVPdMG1emr8MspKEFb2DK827Qzh4cUmMsl?=
 =?us-ascii?Q?vU2gcwoTcsWmEoZDGW2jX5znY3+BozKOgNNC75WmTJtyvvXHj6jg9ujV+jF6?=
 =?us-ascii?Q?6bWh15sgHMTYsmW7K7HO8cC2Pay5o+1fvdEkHzEeBbPLnGGBXnesEq7fYpt0?=
 =?us-ascii?Q?PSkHL6b/zrkuxRm4Uq32Q2rhOjcQyL9/6PU8DKsPJ2Teqz1UzuADghxByX8e?=
 =?us-ascii?Q?iru6M1lxSJQV9ul5A8VFPnLdwmabz3rG0+afc4iQL34TILusyjtPkTPv8iah?=
 =?us-ascii?Q?+7prPfimQCDrUmrH20TlkhnMM4yhrJtV1b0NjE930O+dL1tQClVxtbswADb3?=
 =?us-ascii?Q?QKHnjz5P4GJiFhsWciD91/gXW5L11/IDD+u3qDFUB/fSjTB43eblmvA/PoMA?=
 =?us-ascii?Q?uREsQD4x8gWECtgI1IOPJFw2dPRzT2QDJniqyzGar3SDOvSmH6OlJ8uuQh7O?=
 =?us-ascii?Q?5zNLQXCCLcV36hApxEEVZHkAdRQjPr1fJK/itHBh2OF6AzlpXRWmb/XKU6wm?=
 =?us-ascii?Q?I+qiceXk+hrWbd3DjOgfAuTFV183dd7lvn+AYPyh5iZScNwRhMnlGIr7iyoJ?=
 =?us-ascii?Q?x0fIi5j4loBsTXCxEdqwvXhWg3kzWKm5SWCsU5DtVoFhKk5Xu8yLYdiu5NDM?=
 =?us-ascii?Q?v/mohJ7zsiLHrKFbDc0wRxf+0bRnf0ErNOpFWrdkXeLj6BjR0kKufIwX4TN6?=
 =?us-ascii?Q?HJxwcoy6hiOPKWzPWu8Gd637ZBuSmGwVgefohMzi/ju6iyXD9u53+JwNiPGY?=
 =?us-ascii?Q?zJJTbaYDYMcBd3N90d+FpaHvBCR39VqTEp9rp+6ruPCrQ1gboMBnVfHzff/H?=
 =?us-ascii?Q?GuXLFy8NhVMY6zTaS1YkfswxJ6yTJNOF78Jp6JAQR1LrvHpXplY9m8+bbFOH?=
 =?us-ascii?Q?Dm3Fy++g7i3dTt22FlYpaDJEtXPzrPlliianwn6HRlNovxBPzJYwxEZsTZ/b?=
 =?us-ascii?Q?pZV3YirI50nBg1Or8RAqYf/X+DF3AkyEhuT7zQyBV5mzzTJl82+KDW8H7CoC?=
 =?us-ascii?Q?PH7ip9Yv1I0R+++ODCapyMR2iB/+G0bd0ho7hFP3Nhh5+wX9a+eTyPofr6Bc?=
 =?us-ascii?Q?8BXlqtIcNty266A45yhdKeaUuws67RLJMQowfgWuAPzHQpky2nldn0rnSm0E?=
 =?us-ascii?Q?wTeIS4bqRLfK2eH+RtTvVDzUmDIzTgfvHy8uT/rom1pWBKrO/fLTHtnMTn3X?=
 =?us-ascii?Q?f3/qgv+USbmj3drjQvoyhyHo5THf0H+6coaeccF1hXDW3ebo0O57B7KsvLRe?=
 =?us-ascii?Q?wxunjH2/fP8rWVejYAjaSvRzTfrgXB0wDSJd?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 23:01:49.3510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b48714-4e32-49af-49ce-08dd890427aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9736

The new type of vIOMMU for tegra241-cmdqv allows user space VM to use one
of its virtual command queue HW resources exclusively. This requires user
space to mmap the corresponding MMIO page from kernel space for direct HW
control.

To forward the mmap info (vm_pgoff and size), iommufd should add a driver
specific data structure to the IOMMUFD_CMD_VIOMMU_ALLOC ioctl, for driver
to output the info (during the allocation) back to user space.

Similar to the existing ioctls and their IOMMU handlers, add a user_data
to viommu_alloc op to bridge between iommufd and drivers.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 3 ++-
 include/linux/iommu.h                               | 3 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 3 ++-
 drivers/iommu/iommufd/selftest.c                    | 8 ++++----
 drivers/iommu/iommufd/viommu.c                      | 2 +-
 5 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index dd1ad56ce863..6b8f0d20dac3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1062,7 +1062,8 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length, u32 *type);
 struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 				       struct iommu_domain *parent,
 				       struct iommufd_ctx *ictx,
-				       unsigned int viommu_type);
+				       unsigned int viommu_type,
+				       const struct iommu_user_data *user_data);
 int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
 				    struct arm_smmu_nested_domain *nested_domain);
 void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 3a8d35d41fda..ba7add27e9a0 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -662,7 +662,8 @@ struct iommu_ops {
 
 	struct iommufd_viommu *(*viommu_alloc)(
 		struct device *dev, struct iommu_domain *parent_domain,
-		struct iommufd_ctx *ictx, unsigned int viommu_type);
+		struct iommufd_ctx *ictx, unsigned int viommu_type,
+		const struct iommu_user_data *user_data);
 
 	const struct iommu_domain_ops *default_domain_ops;
 	unsigned long pgsize_bitmap;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index e4fd8d522af8..66855cae775e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -385,7 +385,8 @@ static const struct iommufd_viommu_ops arm_vsmmu_ops = {
 struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 				       struct iommu_domain *parent,
 				       struct iommufd_ctx *ictx,
-				       unsigned int viommu_type)
+				       unsigned int viommu_type,
+				       const struct iommu_user_data *user_data)
 {
 	struct arm_smmu_device *smmu =
 		iommu_get_iommu_dev(dev, struct arm_smmu_device, iommu);
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 18d9a216eb30..8b8ba4fb91cd 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -733,10 +733,10 @@ static struct iommufd_viommu_ops mock_viommu_ops = {
 	.cache_invalidate = mock_viommu_cache_invalidate,
 };
 
-static struct iommufd_viommu *mock_viommu_alloc(struct device *dev,
-						struct iommu_domain *domain,
-						struct iommufd_ctx *ictx,
-						unsigned int viommu_type)
+static struct iommufd_viommu *
+mock_viommu_alloc(struct device *dev, struct iommu_domain *domain,
+		  struct iommufd_ctx *ictx, unsigned int viommu_type,
+		  const struct iommu_user_data *user_data)
 {
 	struct mock_iommu_device *mock_iommu =
 		iommu_get_iommu_dev(dev, struct mock_iommu_device, iommu_dev);
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index d4c7c5072e42..fffa57063c60 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -48,7 +48,7 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	}
 
 	viommu = ops->viommu_alloc(idev->dev, hwpt_paging->common.domain,
-				   ucmd->ictx, cmd->type);
+				   ucmd->ictx, cmd->type, NULL);
 	if (IS_ERR(viommu)) {
 		rc = PTR_ERR(viommu);
 		goto out_put_hwpt;
-- 
2.43.0


