Return-Path: <linux-kselftest+bounces-36908-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 946A2AFF8C1
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 08:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74411562954
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 06:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C032882BB;
	Thu, 10 Jul 2025 06:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jy2CKW50"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40652877F6;
	Thu, 10 Jul 2025 06:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127214; cv=fail; b=LPkQBfrf6jD/rOqvwxz47kWy3rnJv2R4I8i30ha8dZN9vWE8P0fDUxWeRHSi+4Ph5WKD2eb/e4UayGXHwuZ6FVTYRFgO3VyXLKN4z28x9s6hqH6Qe+sw5G9LR7gvqOBRUma95j8CM2Os0bI0ithmF5+XpaR+Mdd4jr9C522BXBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127214; c=relaxed/simple;
	bh=Ee4FouRTz8Ljq4wXHMqSR72luC+RPzcNVbZ6Cqon2O8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l+kmuFnieGuwuRDqNSrjwQGXq4m4RD3mySYNH3fHoZqThSoXPyZIWvoiJ4RVqiOBeXg4ChmSlqDdMmo0+dB6P2fzZh3s3nbQHUjrPL7WmMnU+XRgcDA+LL9ExpjUB3cRNNA89lfVM/sryLbc+acHa0wCJqFRmRz3gVxPLLxcGU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jy2CKW50; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1E0wLZH0Ayfvjj9uPzFZyWCX5e/g+DVFFzEvrFuHPrWQGs5EKpfidSlx1SdJ2iTZ+WM4Y3tacfUf8WSkCYN7Vkhxyk8w4o2wtz+lZfZlnY1qZD8aViYkOTqf0fCBx/piEnPy6ciNT5HTrPDQsxwS6e5IuwodMAzj0jSdAUsQXOt85UqlzwFMGZKQR9RDQ8AW2JzpU5FD9EclBX9FvLxa5aSnwAGR6rtzZYwFs6MqCf9X4Wm/cDnVyWWjjKmAJrm9ll0yfklPEWiyx3Km2GwKascP540iN3k6hRE1LKBejc6NmvN2s+S6JZ2yWdc/76a/SXUL2HAod1IZH+AGijqjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQU9nTEQ6XMlnP3p92syqwsf8q83UxxH9N2ZKCmvBJA=;
 b=k0I2arDION/lxHBKzb4t8Qxx1OfshL++VAJ+E2vLR8PduVj/T+RppXlj9OPiPnQF+f/wcmT3T4daqnSSa2MqcQTbSLmwHjxYTPizGLcSvlD+u6ZgzIMrzZ8GiFakLf5pKHwpZF1qLH2kaxeSnvozHRYBp70kKiuF+OOusXqKrn918Jpr2CoQ78KT3sJBR4OPdpYFHFWXJ1G0Sddn0PsJUnsSVKxGx6DRpYsLbHiMf/vL2FT9hfKMlmeRdONVzxiXs0cnz8acOoD5/jfI5GXu/4zs5tuCNiAIKUB8/hjENVtYU3xDTxMIxUnMjauQsXCK8VsoPycEWD+gR4xyCgddHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQU9nTEQ6XMlnP3p92syqwsf8q83UxxH9N2ZKCmvBJA=;
 b=Jy2CKW50KhZR9HUiwWtSLS7rqXyyKiINRwIj5VdM9odr7Bed87mUQbwCLz93pG209zfCU34zPUvpFwTS6iOy4HZacq28hSjfu/Sz5f8D/6DcnFMUbdnoJ42TVg5F64cI2so/L6d72tWj34PG9hI+xgcuHqklTIsioFW8OuieGPU/JsnSBCzya7FSQlW69kOdCYO0qEiR0d988wP/FmGxUAcJ5NBvTzm1IJeGkv0btkJGdRJF1oLTyROD8Z0eRhJcX3n5ZZkfhZUitT9VxTq4BPSllGTW6ejpg+MqRCoTpTJx4yJ0NQktiZBNroHEb5VlCaSaMZVHvVONFOh/vNWnsw==
Received: from BN9PR03CA0064.namprd03.prod.outlook.com (2603:10b6:408:fc::9)
 by SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 06:00:07 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::5a) by BN9PR03CA0064.outlook.office365.com
 (2603:10b6:408:fc::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Thu,
 10 Jul 2025 06:00:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 06:00:06 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 22:59:54 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 22:59:53 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 22:59:52 -0700
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
Subject: [PATCH v9 04/29] iommu: Use enum iommu_hw_info_type for type in hw_info op
Date: Wed, 9 Jul 2025 22:58:56 -0700
Message-ID: <651c50dee8ab900f691202ef0204cd5a43fdd6a2.1752126748.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|SJ2PR12MB8109:EE_
X-MS-Office365-Filtering-Correlation-Id: 34829054-736a-404a-6cfa-08ddbf770586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jkr//4uAnhDxhJidgrTsGcdVsoNudXexLFsBUGQIiMP2gsdUuFhAPtbGgtGM?=
 =?us-ascii?Q?kcK7VGEA+ZI4AWrBZUvk12jMeaXTaUD9na7NVufWIlwUbr1Fnj831qkLMpBd?=
 =?us-ascii?Q?2VX06cvzxdWKC0bdS51M/NpFUcgavww+2JOQ/4+ibCsxG+4XqI5GqByTKUfo?=
 =?us-ascii?Q?QubR9A6yzCp6f53tnSltcZnhnbz7/ZIdzrSc0DUDa99Zve1QvORLOyi8tPEz?=
 =?us-ascii?Q?j0M3qxTIuKqjOl/Aubo6mSKX2s5xmrs5patL4/KbIW5+atp+n3ERQMz/CI06?=
 =?us-ascii?Q?A6KZQZjV4JVET8yzBenb81V/9L7cFat2xamc0H9aAWzLdTCS031xoMi9nFl7?=
 =?us-ascii?Q?eaIPZ5JjfsTB5wWyowau5CtOujV99X89CrxWc66R9VU+s5+7NPKy3zAy67gg?=
 =?us-ascii?Q?rS3mIIbcScx22sSDuIxTChwaaEmH0JyKoZiqYZEtdwlpItGP9murJWk2eDDS?=
 =?us-ascii?Q?nm/8kT7lun9HFybDTEG60PyVdJvYmntIhhIxVHGKcB6Ou6lvmkttyMGcyh5J?=
 =?us-ascii?Q?7ESQFdX8QTcsnuK/7ll/jtyB5xnFOVtDc56nkuzyjovMxiFL5yrU9y+4+oma?=
 =?us-ascii?Q?Z8IomXKkqqS2gPVFiP9Tjh8nEQOZ/ZSc7qJSzPz89x+IqmPy+9MJqwIlB+Bl?=
 =?us-ascii?Q?+iu8ReKXXQAFujVOawoaMl9nbOxyGySMyffHXsVaIesgaRyOgkvVUPOStx08?=
 =?us-ascii?Q?NxTZge5NbVcziL0jROx0E5/QvhODjrDcimMzx1w40b6ZmAOYmz6GGbS0IV99?=
 =?us-ascii?Q?CpUi6rWqIMsrH10+fuZrqmwGoID5SF37v5tWZHFBjJNlvnntzKyEyz9iOGke?=
 =?us-ascii?Q?At4R8MtadpfvaLYW99ItrmA7LXEOK/XdFtpA/AqJKH0icsFJ1/BehCXNT9mh?=
 =?us-ascii?Q?Y7fIS7pmdz1906S3JKnZYnNyyrj5rEoGyNxin0X4Saqzr6w1oTbG6MHK7+L8?=
 =?us-ascii?Q?pqaAaXhifCoJXx5vOUwLAXNahiX4V9fjOhNm9h5yAwbqNFWfxz9mAqRW+Fnp?=
 =?us-ascii?Q?rf0opOssb9UxEVBgzDXqPo9/jRk43w6+jUXkmEv3ybLq/I2i0Jfv+j4TDovk?=
 =?us-ascii?Q?MDHPPZYxUibhJeauYzCqa5aYjJf+aC4VOCjOm6tbCZyNRPHmy3W5+KvPPfOl?=
 =?us-ascii?Q?sW5FmG+qBuTT3XceMr7M9iZvW6i17QpYgLEmvTpSvWJ+czIb9Nom8fmyIgf6?=
 =?us-ascii?Q?bC9xVlNNAEhnD+aNNWUVbJ0Cbc0iggmLCGmNzPk1CpaPEdh6dj25ado75CEr?=
 =?us-ascii?Q?lOUtV+H1mZPHiaZ5476CVMrDNbRTKInhCDzg4usXYAg2iSyqvnIfubjVa+oN?=
 =?us-ascii?Q?Soyv5ufP3/QmW1RJ99PB6vNkDFC152If40tcQuApFXTdolsm/S9Zab38fjTs?=
 =?us-ascii?Q?5A8MNgVZtVsTPDXG5H6Ag9Ms20grQyVEpM8h9lfN/djAw8dv6fhW+mQgAiaW?=
 =?us-ascii?Q?jFY3pJz2MQDgnJs+fSjl1Lc6OMFyJWBUrbzmI1cLIHbFg+3OnCBs2cIFMN+5?=
 =?us-ascii?Q?j0tC3GUVSefrHKdAQsTaibdCb+mU9+s1djO5?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 06:00:06.9469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34829054-736a-404a-6cfa-08ddbf770586
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8109

Replace u32 to make it clear. No functional changes.

Also simplify the kdoc since the type itself is clear enough.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 3 ++-
 include/linux/iommu.h                               | 6 +++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 3 ++-
 drivers/iommu/intel/iommu.c                         | 3 ++-
 drivers/iommu/iommufd/selftest.c                    | 3 ++-
 5 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index bb39af84e6b0..04463a4aaa26 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1033,7 +1033,8 @@ struct arm_vsmmu {
 };
 
 #if IS_ENABLED(CONFIG_ARM_SMMU_V3_IOMMUFD)
-void *arm_smmu_hw_info(struct device *dev, u32 *length, u32 *type);
+void *arm_smmu_hw_info(struct device *dev, u32 *length,
+		       enum iommu_hw_info_type *type);
 size_t arm_smmu_get_viommu_size(struct device *dev,
 				enum iommu_viommu_type viommu_type);
 int arm_vsmmu_init(struct iommufd_viommu *viommu,
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


