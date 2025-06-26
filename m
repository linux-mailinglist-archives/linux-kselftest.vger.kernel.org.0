Return-Path: <linux-kselftest+bounces-35890-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7CDAEA694
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 21:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B9811C28635
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 19:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2582F0E37;
	Thu, 26 Jun 2025 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mJJfsGbp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A621F2EFD96;
	Thu, 26 Jun 2025 19:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966532; cv=fail; b=coEWr6HX8tVO2B4yxY8BLDO+gfz8Bj+oktUTUOF4JxTNobGOybVslU/dW6CIoc0eGfwas9bdlYJYo67tZZ6tYNnYB3yr7ygv6UGCqpNTrSILOXJ4e3WSKiDqCBQy3WT4Eqmjhd+jao6o0V6UkW1MBscuoj3FNnRSLTq/v5qOikU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966532; c=relaxed/simple;
	bh=1DZmhR1aeHyiZ4JwJcItyjlpLHhgr+AUd5NKXqGfiXE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j8zlztoIY8kpSE3ZavYnujQ3WcF1FUuCQHtyVlii3REAX77Hdj3ytyFqWgnpNTltIJkIo7tm1zOUlXIdZ7RQflzlYJ1ZmGPgstohi3QvVaVBRj8YcbIYi4eYkhRaMN2ykZF3rE2Z1HLXdZaf+adP71r92leSHnSPk4Sa5BLuF/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mJJfsGbp; arc=fail smtp.client-ip=40.107.243.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IO9Gu1fv8PYW/sLTpmwQ9CCI4YbaSuKZjoVzwYfyteaugGuhMF0xMBQwy3aHdXSnKHW7d3DTIG3sgT/0djbdv1YUU0wSaIpnDZQvXp/cWKwx59WGoT6EWHfwF611RT+6CtYYVrt/2LOVafCV52sF2B3ZaaDQeeVXy4i8rYZYRB+rWpNyt/dbYYUmIlGtZRihQITls28JTQqakNMhGyCuIiunYfpmJVzRz4IqBaTqcCIHLj5MctO6IaRkxQv9LdWjVukUOBjM6uikfHgBXaCAwY8BO/3d1ntTJlTYIRNbx1dJtDCTf/hQgwv0y9hIzyy9B1ZmQnT9yXQKFx1YWVg2ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8II8dWrvdzrpIaRMbssKd4gz1LBqmxhitYxLwb/c60k=;
 b=IxRD7jSXM8uhQ4f49iPegDDX0YKTYQKNPfs6nacJZwCWhbVtP/Q91cmLMWue/c56VbdFuFtFX2CmlwH5oUADiZNmJEI2h40Zz1WRTQv4jtkavmW0vvqaX4dXdprIUH7vxtOm+H2r0/Qw9UGTqjoyRrdwnlWC4BeHR1I0azG/gyM4ULUhWoZfcbdmFpJg0M31bZU+eLQw7g1MVW1PXdoiKvHmwhox+piYT9LdPb4V3vFp8ZnuJDNyDdPz6vHg1OYMjpJl6fRAjuGMphki3eCtnFTdCqsVKwkNChcBNBSnwCxZwzLQf8+Hm806zjjGeKt+AJQF8Yn8Fbzqv2f4CK3udg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8II8dWrvdzrpIaRMbssKd4gz1LBqmxhitYxLwb/c60k=;
 b=mJJfsGbp65KjIDWzhoatTSvDqsCYtEvvAFQDNx8LcjPC3hu4j6xZcIg8SSr1zcpu/Psgw/xb3YT0A9YYcrxoy8E0eJK/+uAvb4aVmoG+V9K6Ueb9iPpv5j+qYHlBDZCEzpA2SLLaDdeZqfQqt0zoQXTHTBigv9cg0YNL6GnwnItc693VgSH5GAVB6NpYSBNwMcpPgeVoTvicB9VQ68Hmaree5khNWZUrxDybXnsXg3bP5fBZ7CRCvtf2XJir+KkRKM7AHdoqE9FHuEN5MbH9l5MkctiYvAKNUOqFRcLGhju83K2/o6/gFJ/yDUlLWcjFQtDi5HJr0/MZzQ7Iy2ou2g==
Received: from BN0PR10CA0019.namprd10.prod.outlook.com (2603:10b6:408:143::8)
 by DM6PR12MB4154.namprd12.prod.outlook.com (2603:10b6:5:21d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Thu, 26 Jun
 2025 19:35:27 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:408:143:cafe::7c) by BN0PR10CA0019.outlook.office365.com
 (2603:10b6:408:143::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Thu,
 26 Jun 2025 19:35:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 19:35:26 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 12:35:10 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 26 Jun 2025 12:35:09 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 26 Jun 2025 12:35:08 -0700
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
Subject: [PATCH v7 03/28] iommu: Use enum iommu_hw_info_type for type in hw_info op
Date: Thu, 26 Jun 2025 12:34:34 -0700
Message-ID: <f588bf6a47cbaf350a03e5a1680074b852fb5502.1750966133.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|DM6PR12MB4154:EE_
X-MS-Office365-Filtering-Correlation-Id: 079d8ab6-5499-4a94-eb3e-08ddb4e89a3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gL5sH67dozW/g4UvnHqsiU27uNLIvPZoocpV7ub3DviZ73rbBbMBdZtv/mDa?=
 =?us-ascii?Q?xTX4HCL0etSX72tjaReY7gB4q4/UFsmyrWkCvGaiL4nDP7/l/e8I60bsYlcU?=
 =?us-ascii?Q?f4MFDjhVxv9ucyCQNWEQe7h1YRu74jEaC4ptaMx4ig2v/0NioAvjk+63CPlC?=
 =?us-ascii?Q?+oHvPEtwdKDQv4OqmL8edknERvuMM0K1/kiKlJ08S1gx1H9kB5gswewVnLRC?=
 =?us-ascii?Q?aYDRBp2hknT5buV50+loLOXzRcixAzuB2rMNlvnrf3jy+OoNX/7urFyMqQfa?=
 =?us-ascii?Q?yh3ah4PeZaIGnHp9dB6APe1ZdQ3b4AECJZckjZ6YXSeMTcw+xmlrg1wSCN5w?=
 =?us-ascii?Q?HZtgHEwaLIlwnGY26o6aGcg0MMSw8ay0lEltOanNcc78EDDe4r+KVQMcN8gA?=
 =?us-ascii?Q?nsrxDbwon8ZTuSXpxZ8WsApAwtNpQtXIQo+vR4Zll/erY7TmnAd1cVr2l/I8?=
 =?us-ascii?Q?gMH9xGoJ3kCwlBhf2eQI1u1B2f6JaGoo1/kdZAahI+xnzzcC8lV2HHt9OY8Q?=
 =?us-ascii?Q?z9TgflGsu5z8hgQvgemAJ5anKXEnk/AZ3M17VcHbxprGZ05KDA64cBaf1omQ?=
 =?us-ascii?Q?G70XMjjelRGcON8SfnOhwGqadavPOEfUUkmdGnSYohDrSQhCGE4ETRbhGq4O?=
 =?us-ascii?Q?06Wu0xs8TPaSLoFfqP+EMcfSRflaPAjOtfCWuYcYkcEGuYAGTdTXaFOAT6eC?=
 =?us-ascii?Q?Fise5Hrd0mGr1S0ghxsoxBjPjoXSfIGh1qfwCA5NwJZDcip4PGH2yJihmW/C?=
 =?us-ascii?Q?FR/t7WNZVYFXxvT9z3Cg/Un54SPVmY6GpzMsnUHPJJQvuOk5euq+HpXSmIZ/?=
 =?us-ascii?Q?IIEtUgHafKAv++Wey4Sqnko1EhjM5p5/Y01rgCaeh+3sbAFGtZ5/TzUMGvZV?=
 =?us-ascii?Q?fpl+yah0UfgyhnHG1QMpB0O0CK7ckVgpCJyZSMkE90TX9dz/SN/colc8pFAR?=
 =?us-ascii?Q?Kn58UEvCkzfKQoJMPVZ8ZIRb6LXtrOOEH6mA3HcpqS2wSAQB2D8ld9nLxnjv?=
 =?us-ascii?Q?ikbUQ5mb3SIf/M154J2fouU5yWx8M3LPiioS86UnfGScjzX8Vj3S4ae5BwU7?=
 =?us-ascii?Q?QmtQe/h+d0h0ePCz8j0ZyLiSdGqDB8/IVVoYGo3l1Wf0pPpJTL+UeCiSCKq1?=
 =?us-ascii?Q?KZ3Rjhpd+GoNLqt/x/DUXK37BDZ8scr2irU/CmhAlYAzsCGDQITmGsuaVtQb?=
 =?us-ascii?Q?LiHYMgTzX5hX+VN2l9hpvLgAGCeghq8lL/e6s6tvEyV5oMzCF79Fo3O4DAVW?=
 =?us-ascii?Q?bn7lMr4dacoo9ZmXfC2Wl6HS+EMdqIaXF1CBOcspKbAIynmvjJr2T5zof/2S?=
 =?us-ascii?Q?HYc7TWJN0K8yt/QUe0r2kmCThef6k2lgub3flusPxEwWj3qHOflhi5nCWnZP?=
 =?us-ascii?Q?P6l7qJ6Um3wYUB9Coe08reQ/OlGwPlpZvJIGK6jnEveQBiHebhquVKvZehhq?=
 =?us-ascii?Q?/XGf7U7v7LByDs2ACeELwBmcXMvKDlqTbe4DiDfo6z20TRk1tzbm0cPfu+re?=
 =?us-ascii?Q?wP1ADkRaBdk76G4YjmxrrPxHCV3Kio1jNSKl?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 19:35:26.7848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 079d8ab6-5499-4a94-eb3e-08ddb4e89a3f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4154

Replace u32 to make it clear. No functional changes.

Also simplify the kdoc since the type itself is clear enough.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h                               | 6 +++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 3 ++-
 drivers/iommu/intel/iommu.c                         | 3 ++-
 drivers/iommu/iommufd/selftest.c                    | 3 ++-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 04548b18df28..b87c2841e6bc 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -563,8 +563,7 @@ iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
  * @capable: check capability
  * @hw_info: report iommu hardware information. The data buffer returned by this
  *           op is allocated in the iommu driver and freed by the caller after
- *           use. The information type is one of enum iommu_hw_info_type defined
- *           in include/uapi/linux/iommufd.h.
+ *           use.
  * @domain_alloc: Do not use in new drivers
  * @domain_alloc_identity: allocate an IDENTITY domain. Drivers should prefer to
  *                         use identity_domain instead. This should only be used
@@ -623,7 +622,8 @@ iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
  */
 struct iommu_ops {
 	bool (*capable)(struct device *dev, enum iommu_cap);
-	void *(*hw_info)(struct device *dev, u32 *length, u32 *type);
+	void *(*hw_info)(struct device *dev, u32 *length,
+			 enum iommu_hw_info_type *type);
 
 	/* Domain allocation and freeing by the iommu driver */
 #if IS_ENABLED(CONFIG_FSL_PAMU)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 9f59c95a254c..69bbe39e28de 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -7,7 +7,8 @@
 
 #include "arm-smmu-v3.h"
 
-void *arm_smmu_hw_info(struct device *dev, u32 *length, u32 *type)
+void *arm_smmu_hw_info(struct device *dev, u32 *length,
+		       enum iommu_hw_info_type *type)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct iommu_hw_info_arm_smmuv3 *info;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7aa3932251b2..850f1a6f548c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4091,7 +4091,8 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	return ret;
 }
 
-static void *intel_iommu_hw_info(struct device *dev, u32 *length, u32 *type)
+static void *intel_iommu_hw_info(struct device *dev, u32 *length,
+				 enum iommu_hw_info_type *type)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 74ca955a766e..7a9abe3f47d5 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -287,7 +287,8 @@ static struct iommu_domain mock_blocking_domain = {
 	.ops = &mock_blocking_ops,
 };
 
-static void *mock_domain_hw_info(struct device *dev, u32 *length, u32 *type)
+static void *mock_domain_hw_info(struct device *dev, u32 *length,
+				 enum iommu_hw_info_type *type)
 {
 	struct iommu_test_hw_info *info;
 
-- 
2.43.0


