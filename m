Return-Path: <linux-kselftest+bounces-36925-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C3BAFF904
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 08:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A13483B08
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 06:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B3828FFDF;
	Thu, 10 Jul 2025 06:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rsqRrL2z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7902E3B280;
	Thu, 10 Jul 2025 06:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127251; cv=fail; b=I8zKL8uIxUznV/BdDMiopYeequryl4/ZHSb8zVcU1PmXVNreNdJG/5KX8ZUyH0QLWrVgDGGwVLLnP285Y6R3TaFCpcTHsmknJZp5fvPy0KjPpTwto7fej2QKkRpCmddCFMp3rhfjr+wqApdJrnD0nbkRhJNAoJBagYrZ2OULBQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127251; c=relaxed/simple;
	bh=t1iHCfRajO0uhwDsj8DBsxfolQuNkNYe+1csP6GF6X0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mg/+wBfJp53N4t6gaJSK0qj/GXV6f3MutSB94bfnedpVtDjleC+MRU8Boi7cVppi+RTD2HddzBrhSN//pSiKGO7vBp61zTkbNk585CeHAP2HCpFi2RzMfh7hDTfLdCWrWPod84EfRlYf5TbYm5q+8ltcFbxCKVuyS+E4bQ09AWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rsqRrL2z; arc=fail smtp.client-ip=40.107.96.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORoKjT/YyKzT3ZrJhAEocZLt2tzOdAXjLufkLBVbu45Hs3asV4DNckNjplG5wrg6FFBQA0c5E98bpCoKIsWU3wLY+PSaCIYPOmFLCVM3MqOa4rKqS8vRCGvA9jZ42/bb359UDsL7mpzOIWSqgf2l1NMUnT3dZF9MCQP/mppah4y4X4RhDLyXTcIaXAQO9oZUAunMVOHzmAyjO22UKeEU/tp5MHGJeJ2TnoeZIudarG/GpRY8c8Fxv8F0t84apJiZQAZBDmS2PXcxzCPhdCkv0PRsag5+SPwDKvliUhVpY0XB2OO/Dp99jbwnnP53TH6PU2pSzWpra+dvU56UKkq0cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7nKlLhMFuvvQT159s7O7yk1+CbSermr3lmUn9j45C4=;
 b=Pr1rCLgH+T9J3dY1njdOgldt1+oP+EuaJk3COP1bp3U+Gnr6nnhbcaOYjSjE/hEMVNEudgSWEHaXl9IjHVJZ4D6k1kp9XYARKA8dsCXX/KCyyV8DMToYRY0a4nV60fr8sGgQAhTVzl6nkCPgh+IpvMHG5Zn9UTaSKuIgTA9HnB6mAe0d1L3DdNWPv0QWP6+JDarlQQ8U6ggq6B/qExsKoKkTNPIiXf4hxrQHAv5EoAxz7lynVgTUYrwQePi/st4Ns3Dd4kcOOgURi0T2SWWPssytr6cqL2jUiCgcn2A3gk4+nRM5TzovIPiuwla5kaw2aJUBtjaeAUWLl01r7gl2vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7nKlLhMFuvvQT159s7O7yk1+CbSermr3lmUn9j45C4=;
 b=rsqRrL2zGrcwll3RcxgHoNW6WK4S09H1JI/vEPaYYfB3MfcjDVejNnST9mgvxE6Wgp+vahBw6URRM6MVDVW6762dAoNl6xwkdogrEaZ/EXgq1nNZD12VIouOUVADFzJvpq4uFKYDJZazRJOQxOV8AtHb5KBtUWY3+R5NH1N89BAGedGxmNrOUqJtB2Z1fdIlU1K5n/a2TYXtZlHf18Hpav3ofcYKeTrKSYJB6B0rHudtntjBI05kQNrSACB61sdtTKHNEefxzKd8dmjdoo4AyzcAepC8GiPxfpGXiL6cnD6G7QIlXKAvdReh79D4NbbwTTM4/0iv7KCFtQq4EHNDYg==
Received: from CH0PR03CA0310.namprd03.prod.outlook.com (2603:10b6:610:118::33)
 by DS7PR12MB8290.namprd12.prod.outlook.com (2603:10b6:8:d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 06:00:43 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::3) by CH0PR03CA0310.outlook.office365.com
 (2603:10b6:610:118::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 06:00:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 06:00:43 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 23:00:23 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 23:00:23 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 23:00:21 -0700
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
Subject: [PATCH v9 20/29] iommu: Allow an input type in hw_info op
Date: Wed, 9 Jul 2025 22:59:12 -0700
Message-ID: <00f4a2d3d930721f61367014717b3ba2d1e82a81.1752126748.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|DS7PR12MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: 82ae6675-9700-4eca-a214-08ddbf771b2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2M23AxlHklNZLCkhAUMTNu3xuFhBBCT9Ba5azCGSyJvzEBNI3XA/HdVWEYcM?=
 =?us-ascii?Q?jo7EEOG5ZjxQvJFpMwc3kbW+A9zyz/tX6KWTsMba07DbHee1cHKiygIEXlK2?=
 =?us-ascii?Q?XzANRjIKViO9P3WbxWEgoDhDB6KQz7ut7cQszLWrilvsMAj845APpMy38B31?=
 =?us-ascii?Q?d5zGSVuD/7VjFZrZAhjghEYx+Z5SzS4xTyqsSGUfYpOskesaQd98mz7SS4g0?=
 =?us-ascii?Q?omu7J3YTTOGuCrK2g4rMu1nw5Uls1V1HgmeZCt4QiK8H9GYbdRFAeQSOf6rm?=
 =?us-ascii?Q?1zfZ/8LYkJ+Cw66qemUf2kqODIN+qgnhTLfRJk+eFU4ilh6KVP02wAXsBHwE?=
 =?us-ascii?Q?ppKyL4xG0U3TPYKVHE7X0g8S+g3CDv5xnnhpDirSkBYOkOYvzJ+/3n/M9MPm?=
 =?us-ascii?Q?ruYB9/vXsvPnT5odKmVeiOA3NGv56NXxcRkyqsGIBgTWiCdQ8N037c4MjZqo?=
 =?us-ascii?Q?9RUL4HW9vQVCNaos3kH5989OItoJELWeCeSJ5xUjfVZyOP4OpCKPoJti/3UZ?=
 =?us-ascii?Q?XSrKEQsGq4ZEb7Hta2cNvQwKhREvCiRULL8q0hFZEicSF7vyDUk+XzbQ75Yw?=
 =?us-ascii?Q?6de6WKTLE0WFRPgWnmPTiBFju7xzks3GC/QKIjdGkLLcYKptOa3PXN5vctGc?=
 =?us-ascii?Q?4mjL36NabyvGF/2ZDrpbAQ9HFpIidRaSCCCiV2OjObe+sYh1GCzP6IQzK9Ah?=
 =?us-ascii?Q?ODZqreTB9kkDqVCruQ/JITU/zUkwBRknfqpXxDKwEnougjV+Aj6aGlc6zWaF?=
 =?us-ascii?Q?+TW9RZcxHm7J6QkbrCJY/RwIxa+ZiVcGO/b48KkNe68UGewbzEqjjVDG4xVV?=
 =?us-ascii?Q?l9hHA2Yx+IP33M0IwrYb3vbgtpJjr3TQGlUItzlZnnHzE83q3/L0m78J8C1s?=
 =?us-ascii?Q?tpVuIo3dZA5Lb/TTOhb4foz+8pkEbOTk5FQ1dC5G0WF5P8WwhF7VzMF2YhEL?=
 =?us-ascii?Q?y6cBiu87v0olWyGYJHrk6rbYuVmN0DDhkYlsvJiL4JZaH17hABw59qt9ooIN?=
 =?us-ascii?Q?X7FzSjreFgwsgaY2iNvbgJkbAGgv7+QZ7lzunZ150TNUyKmQjJL4Rv13ZIg8?=
 =?us-ascii?Q?mCK50bu+CxsykeCL/2tjE4n2tEDmRNod0b0/Yb8K9dKzzDfbx6Fhl29eJTLT?=
 =?us-ascii?Q?NyhI7m/DUWJa3NoP58zErahrqmgHrqCCx3uysJys+Hi1K3dJn24uT6Vw78Tb?=
 =?us-ascii?Q?s6j5I+4FdqmMgkGvL985Z7i9vyiLqubCJhdw3ShFI3cNn4gVuW+RRv6S667x?=
 =?us-ascii?Q?UnBs+fx5ln7fwGL2WQJ/+oqZvQxxZMIuY1NUUTB7LB2SmdPqbktRdTd48kmD?=
 =?us-ascii?Q?v/CV9HfU6FsyaW4+7X9ErVjVPCxcJ7rWM7c0QRNXWRYeTs3bVEZ4C3swhV2L?=
 =?us-ascii?Q?j1lDeBDGegxNiOOpImHBTaRFnlh/SF9Jg1KblMN2U2FgOI0B8i2x6w3EVatl?=
 =?us-ascii?Q?117RDsSL/vyj2u9nz07Vl3/QYcVBtJ7+xu//QLENknN2T4k2AS1lPMvRCeh2?=
 =?us-ascii?Q?z1AtNrPB/DRhw8np3lDs8uGGC7z64PCIO2dh?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 06:00:43.2674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ae6675-9700-4eca-a214-08ddbf771b2b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8290

The hw_info uAPI will support a bidirectional data_type field that can be
used as an input field for user space to request for a specific info data.

To prepare for the uAPI update, change the iommu layer first:
 - Add a new IOMMU_HW_INFO_TYPE_DEFAULT as an input, for which driver can
   output its only (or firstly) supported type
 - Update the kdoc accordingly
 - Roll out the type validation in the existing drivers

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h                               | 3 ++-
 include/uapi/linux/iommufd.h                        | 4 +++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 4 ++++
 drivers/iommu/intel/iommu.c                         | 4 ++++
 drivers/iommu/iommufd/device.c                      | 3 +++
 drivers/iommu/iommufd/selftest.c                    | 4 ++++
 6 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e06a0fbe4bc7..e8b59ef54e48 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -603,7 +603,8 @@ __iommu_copy_struct_to_user(const struct iommu_user_data *dst_data,
  * @capable: check capability
  * @hw_info: report iommu hardware information. The data buffer returned by this
  *           op is allocated in the iommu driver and freed by the caller after
- *           use.
+ *           use. @type can input a requested type and output a supported type.
+ *           Driver should reject an unsupported data @type input
  * @domain_alloc: Do not use in new drivers
  * @domain_alloc_identity: allocate an IDENTITY domain. Drivers should prefer to
  *                         use identity_domain instead. This should only be used
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 55459b9eee31..fe4b8f9a3403 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -593,13 +593,15 @@ struct iommu_hw_info_arm_smmuv3 {
 
 /**
  * enum iommu_hw_info_type - IOMMU Hardware Info Types
- * @IOMMU_HW_INFO_TYPE_NONE: Used by the drivers that do not report hardware
+ * @IOMMU_HW_INFO_TYPE_NONE: Output by the drivers that do not report hardware
  *                           info
+ * @IOMMU_HW_INFO_TYPE_DEFAULT: Input to request for a default type
  * @IOMMU_HW_INFO_TYPE_INTEL_VTD: Intel VT-d iommu info type
  * @IOMMU_HW_INFO_TYPE_ARM_SMMUV3: ARM SMMUv3 iommu info type
  */
 enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_NONE = 0,
+	IOMMU_HW_INFO_TYPE_DEFAULT = 0,
 	IOMMU_HW_INFO_TYPE_INTEL_VTD = 1,
 	IOMMU_HW_INFO_TYPE_ARM_SMMUV3 = 2,
 };
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 170d69162848..eb9fe1f6311a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -15,6 +15,10 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length,
 	u32 __iomem *base_idr;
 	unsigned int i;
 
+	if (*type != IOMMU_HW_INFO_TYPE_DEFAULT &&
+	    *type != IOMMU_HW_INFO_TYPE_ARM_SMMUV3)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 850f1a6f548c..5f75faffca15 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4098,6 +4098,10 @@ static void *intel_iommu_hw_info(struct device *dev, u32 *length,
 	struct intel_iommu *iommu = info->iommu;
 	struct iommu_hw_info_vtd *vtd;
 
+	if (*type != IOMMU_HW_INFO_TYPE_DEFAULT &&
+	    *type != IOMMU_HW_INFO_TYPE_INTEL_VTD)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	vtd = kzalloc(sizeof(*vtd), GFP_KERNEL);
 	if (!vtd)
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 0567faff5680..14955dc43892 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1512,6 +1512,9 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
 	    cmd->__reserved[2])
 		return -EOPNOTSUPP;
 
+	/* Clear the type field since drivers don't support a random input */
+	cmd->out_data_type = IOMMU_HW_INFO_TYPE_DEFAULT;
+
 	idev = iommufd_get_device(ucmd, cmd->dev_id);
 	if (IS_ERR(idev))
 		return PTR_ERR(idev);
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 8b2c44b32530..a5dc36219a90 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -310,6 +310,10 @@ static void *mock_domain_hw_info(struct device *dev, u32 *length,
 {
 	struct iommu_test_hw_info *info;
 
+	if (*type != IOMMU_HW_INFO_TYPE_DEFAULT &&
+	    *type != IOMMU_HW_INFO_TYPE_SELFTEST)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return ERR_PTR(-ENOMEM);
-- 
2.43.0


