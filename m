Return-Path: <linux-kselftest+bounces-36911-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C58AFF8CB
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 08:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258173AB8DF
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 06:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FDB289E00;
	Thu, 10 Jul 2025 06:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HNEUwwkz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA41288CBA;
	Thu, 10 Jul 2025 06:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127218; cv=fail; b=dtjhRcaxlwTdWuvO7gkA9M+UD1lUM3JHSy7C2QSooxUamDLv3fIZv9GFS89zjw7RMnjeV04vOCc6/7iOJMs4A6zlcjALCY3DdYVywI2ppAgYtA/hHQIo0JO4L2IcBJUO7wMhO4DkX5RKuChFme2zA58uZSvS3iwYhJeTH9XbXjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127218; c=relaxed/simple;
	bh=RIFc9qbqL7XOKxSJG6fQBPq1yupb38NXOk53Zh0fhic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lv7HuNb1aAil4Uxys6PG+wibx78oDwepkA/2UQ97Zhh3kp0wOS8lVGyDtbpkwdqI/f9q2FiQHGYmvXws4Bnt6hhKhvsrFGQQ5HYEvDMq/KY1HT2RWBfQ2HD+ZuIidX8OexaUqgc9FZD4M5JrGhtMSIslINQjl2dlj4SBEPbyXT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HNEUwwkz; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVKpG+NfQs8VbUs49+qvk8Svt6l9Ewmq+R/vufVM2KLUzCFGnH6JdGkfeJ4MV0it3zG17JKhXHyUvJM5/E97jebU6avGi9durPpOjnhMsYSiCz0suqmgC+eE9xXY7f/L2RELw+4o/gvjeFrWtCx1J3d7VIhEud6rS2+Yhtza95/unL+9l1NH9ROb+vpO3a+5LicVXDtrnGSkL062aN5qZVLwhbJyXSPrWt4LJDX2clB6H+WA0qZjTPQiZJDB/wCsfPa3J6cn9aYKBZp+WzvO//PL9ghWzLoiKuxIVVF6GIXbL3qcXfzNAlxpWOFCEX1VV9yUDiXSFFVY2n6rmmzJWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkJdHHN3zWdtVYiy0N5ihgbZAPSxSVmrngRNpzfV91E=;
 b=HvEM1cVXuxln6UrdRA4zS4uq6dQ/j1E0V9EvhHJii+t2RvaiM3ex/ehKKW9nl95dko65WCN+wurReZwRMG8mfWbYY8+MAOVnLCrr+UylJfoO8jQojGq9JJ2Voonld6TYfky0DTUaUHS/hNOAtHNz6UhEsx/Zkv9V0TMoKPwxngc/XmVL1jL2tvmoElZdmZzzI9fv596FvKTsI4wtQEhwhCDB0g6hYAL4hDlV/KhUKmIjIN6wMHo8Oynlk98vf6X+SQ1WVrC1VH7Uu6ZPdhChIQBYJrOzx6VIWZ+4aJPP5eUK5E9WlMoXJeoQ9VviMGddv/fRmrZeKZuZYx6DPUhQUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkJdHHN3zWdtVYiy0N5ihgbZAPSxSVmrngRNpzfV91E=;
 b=HNEUwwkzkhCLvgPicxNwGQ41rOzid1P5cE1u0CZPwFWs++JF9rLbpvUepj5SXwaDZieUKYTyS9iJnoaFb+OPn2yAibAJ6aaxN+qN8SZ5A55GIFUfV6bBJaNl8PXBqwoZz9uq1xoIhHzD+WicUbqgl2ULEUnl3uHmbGj6YRjcQ6dVuEt0TttG2k1zqMq/LIa63phn7wQJfpxXsWOBuBkyaSazjr23el8c/ceyGehPL//LSnYLFVC5ohDWPFOqgLPcVGuL87/GXWDLF0yn6G8Ik2de2yaYT4mdX2+LiqHnkTyk4zgf1Ex4+a24SeVH4Qm6kkp+nTWhW6V2Wd4jXGhKZw==
Received: from BN9PR03CA0070.namprd03.prod.outlook.com (2603:10b6:408:fc::15)
 by LV8PR12MB9182.namprd12.prod.outlook.com (2603:10b6:408:192::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 10 Jul
 2025 06:00:12 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::35) by BN9PR03CA0070.outlook.office365.com
 (2603:10b6:408:fc::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Thu,
 10 Jul 2025 06:00:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 06:00:11 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 22:59:57 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 22:59:57 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 22:59:55 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <bagasdotme@gmail.com>,
	<will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v9 06/29] iommu: Pass in a driver-level user data structure to viommu_init op
Date: Wed, 9 Jul 2025 22:58:58 -0700
Message-ID: <90bd5637dab7f5507c7a64d2c4826e70431e45a4.1752126748.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1752126748.git.nicolinc@nvidia.com>
References: <cover.1752126748.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|LV8PR12MB9182:EE_
X-MS-Office365-Filtering-Correlation-Id: a20e846c-3b82-4735-fb53-08ddbf770885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iPzTJIlJq8IcWGODp6FdO7raVKNjv+DjCpWUU+Q0fp5Ln5Sj27TzyeEtawOI?=
 =?us-ascii?Q?y6MX5T9fPC/9u8fyT7EtWoo1jAItKvZ0NCni5/hLzv+rKnl6B9wdEney5vVV?=
 =?us-ascii?Q?oUegz+hBTjlx1gqzs5n4b+yZdqG/gHma198iAS/GAKkEbdFNgprovr4tYDJe?=
 =?us-ascii?Q?8lGbDl7bgJO8cTokMUoTA338QamFGGtIJgTjZuAdTOUMCuYBb3hOX+fxUsPF?=
 =?us-ascii?Q?X/Bu0tY2AM6M1CxV4GAYz6ZIBj/nzPLU24StZ6GgILpor3YiXp7psCQVfono?=
 =?us-ascii?Q?Ze4qwHZRKWiayfDytVkHC74h+H4TSUQ9UOvTABMGjNyKUmnItLLE2rGpas36?=
 =?us-ascii?Q?Ui1cKWUJ+/AJBIXkZZ9YuzJPl5DJHZ+Y7ApsW5qvnMDQwY2J0bc7Ivlx+vxE?=
 =?us-ascii?Q?oxMeRY8X4h3gTUz3iwKWDRsB4zHlLF4MjmAiAj7o01KG8e/uLr7BbGfV0y7M?=
 =?us-ascii?Q?HIDqrTFeN1ET6UdYA8jZsnUvicz3HdZfvVlmQDDzF5UOD+084r4YmoMCSQ1p?=
 =?us-ascii?Q?dwBw3gU0dE6uI/MtVXtX4L9xYqm8k74kaciib/0jOKHnaVcugKfAMUe/n1dM?=
 =?us-ascii?Q?v1KyFMAShYl6VOYM7ohVHFfkehEMhCtaDl/J+Ciw7kD1vz8f9YNHijDV7p2B?=
 =?us-ascii?Q?P8N1lr2Ja4hCc8NIFxpgNYIZ0NwoxXitU5w+6qPJAvM3AScwZc9SPzb2KBdt?=
 =?us-ascii?Q?14My8M447Mww+wNEXJ6f0OR+1AyBJbKmN4c64pEtDlSwa+FekNoll1V2wHxk?=
 =?us-ascii?Q?sczptSH6uOAdx5Ja5M5qSCDSgUAgDuZkFx5ZaTPjIa5TGYz1/UWlyMo1wTOI?=
 =?us-ascii?Q?xeBuWEmD1T44gyWstIvWld3+j/CuuzIb5CT9Bo0UBNSk/olx7fmiI4R4Wx6X?=
 =?us-ascii?Q?URAO8ySpWpzko408Z8xW9L/OVjOiR0aX+OtkUzZv9epGe8gkBn4V+Bn8OU2p?=
 =?us-ascii?Q?qdnM++zpMLNI+xHc0ECS2OP8Lg9h9xNz8kOLMvi4N6MHdeCZgGT/s1uoWyxr?=
 =?us-ascii?Q?7PSnEetocxSnYeCvAt+GpIY5kZIwNFeErxGJJWluwQ83dElzERI0bLLphOaT?=
 =?us-ascii?Q?xWB/VFee1froUaa23jCP//6IpYmvKP6nBHJTtAyiuujLBrnmLTGt0f/chorB?=
 =?us-ascii?Q?zRqIZfgS8gfbDlQjCxVFcdEGqz7Ti6EnaXf7IrHx8uwBodaW/utCmqMt5+72?=
 =?us-ascii?Q?IOFgpVmDwYAdiA0tIgdUi3rr1Ok+8njv2dgcS/ypkg0xXloNSjfrZ1MFx23+?=
 =?us-ascii?Q?TmDplzVOOYUtZgD/kbCCqRvKo/tvnyZhtdAdvjr+gRhpazHkoke9Q9nobpYj?=
 =?us-ascii?Q?oSVyY3j4hcXHMDTfFbNdumLY0wvq8a5hWcE5arOBxw17DJ1O08sUUMqtihch?=
 =?us-ascii?Q?6EXp+cmU8im/d8G/KPSdFB1ws/0Az3M1t8HmSIDtET1coITWTxHDqCPdXilS?=
 =?us-ascii?Q?kAMjSLyUuT5zCGF93eDUSjSesISmZlcozacyPDqw03Rpf5Co336DEsokxTPj?=
 =?us-ascii?Q?FF9dKTjR9Gkrt3VTlDwGM0zMI6c+wF9qWN4C?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 06:00:11.9602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a20e846c-3b82-4735-fb53-08ddbf770885
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9182

The new type of vIOMMU for tegra241-cmdqv allows user space VM to use one
of its virtual command queue HW resources exclusively. This requires user
space to mmap the corresponding MMIO page from kernel space for direct HW
control.

To forward the mmap info (offset and length), iommufd should add a driver
specific data structure to the IOMMUFD_CMD_VIOMMU_ALLOC ioctl, for driver
to output the info during the vIOMMU initialization back to user space.

Similar to the existing ioctls and their IOMMU handlers, add a user_data
to viommu_init op to bridge between iommufd and drivers.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 3 ++-
 include/linux/iommu.h                               | 3 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 3 ++-
 drivers/iommu/iommufd/selftest.c                    | 3 ++-
 drivers/iommu/iommufd/viommu.c                      | 2 +-
 5 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 04463a4aaa26..c1ced4d4b6d1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1038,7 +1038,8 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length,
 size_t arm_smmu_get_viommu_size(struct device *dev,
 				enum iommu_viommu_type viommu_type);
 int arm_vsmmu_init(struct iommufd_viommu *viommu,
-		   struct iommu_domain *parent_domain);
+		   struct iommu_domain *parent_domain,
+		   const struct iommu_user_data *user_data);
 int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
 				    struct arm_smmu_nested_domain *nested_domain);
 void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index fd7319706684..e06a0fbe4bc7 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -700,7 +700,8 @@ struct iommu_ops {
 	size_t (*get_viommu_size)(struct device *dev,
 				  enum iommu_viommu_type viommu_type);
 	int (*viommu_init)(struct iommufd_viommu *viommu,
-			   struct iommu_domain *parent_domain);
+			   struct iommu_domain *parent_domain,
+			   const struct iommu_user_data *user_data);
 
 	const struct iommu_domain_ops *default_domain_ops;
 	unsigned long pgsize_bitmap;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 69bbe39e28de..170d69162848 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -419,7 +419,8 @@ size_t arm_smmu_get_viommu_size(struct device *dev,
 }
 
 int arm_vsmmu_init(struct iommufd_viommu *viommu,
-		   struct iommu_domain *parent_domain)
+		   struct iommu_domain *parent_domain,
+		   const struct iommu_user_data *user_data)
 {
 	struct arm_vsmmu *vsmmu = container_of(viommu, struct arm_vsmmu, core);
 	struct arm_smmu_device *smmu =
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 7a9abe3f47d5..0d896a89ace7 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -779,7 +779,8 @@ static size_t mock_get_viommu_size(struct device *dev,
 }
 
 static int mock_viommu_init(struct iommufd_viommu *viommu,
-			    struct iommu_domain *parent_domain)
+			    struct iommu_domain *parent_domain,
+			    const struct iommu_user_data *user_data)
 {
 	struct mock_iommu_device *mock_iommu = container_of(
 		viommu->iommu_dev, struct mock_iommu_device, iommu_dev);
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index bc8796e6684e..2009a421efae 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -84,7 +84,7 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	 */
 	viommu->iommu_dev = __iommu_get_iommu_dev(idev->dev);
 
-	rc = ops->viommu_init(viommu, hwpt_paging->common.domain);
+	rc = ops->viommu_init(viommu, hwpt_paging->common.domain, NULL);
 	if (rc)
 		goto out_put_hwpt;
 
-- 
2.43.0


