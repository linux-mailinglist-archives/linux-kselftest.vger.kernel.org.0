Return-Path: <linux-kselftest+bounces-35903-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D40AEA6C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 21:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165EA1C42B71
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 19:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423162F949F;
	Thu, 26 Jun 2025 19:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eFB8HAso"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A082F0E31;
	Thu, 26 Jun 2025 19:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966558; cv=fail; b=dDRIcl1vMmUKVl4TuJWW6Qq7CsbVTrm/MaE0i+94njHEfgLiB7+r27duhtVnKJZttoUlPSuAnf0pekl5qlb366S185MRn1i+qs/PkClnP+L1ZfhzvpkOYFsF82I+/CzgYxPp+rXem0qn6Islqc6f1boyNJgU6OVtLVVdX2D8FG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966558; c=relaxed/simple;
	bh=urSN8xy12xmEFH+Z7oAVLPea/WGIWi4SVR5qdET6odU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JstWkPIysSElwRjNN1ghVp4bCsSbD/ulHXqLhtt9PpJoHvLs0TeJebt0M8lDX4HMeipHBDDCIM6PVQY2d+lbDrb9aZ064zoOcFvPzQJ+QybO5jt9nFl/9J9aYf8Vw6bXjIK9hNFC/4JZ5Y/0OPqc3eTBiG8iq4vtMoUhteDx5Yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eFB8HAso; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Daq3SOHEOaYu1iqHlgDpET06ieg+9gYtc7BdGBN9FQEebei2Dnzrlr9v6J29bROEXAwBww6vL+hGIKacPx0i/beGa3nbmMLlORuNKM1GkOIWLUx3gBC/h81AC3Qm6IdEOAk4FNWpoGqTASHKfHCASBLnt4CprqQz+JiYoGxmf3f1Km3gt0cveDs16Fee0R0KezKFdWXEIS1/PpbRjbqx/QVBd7BV7TPpnr6PWsdHRj0sJOQt1ajJTfZKWdy3H1K3pbdGaRZruLr3OlBqrCnegbsj1U1QzGT0JqamVNcUoZACvNpIhgZB1kyZWECgJwCGY7AAIS8vFmR3sp+avPbVcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgcTm+2HBXH3vgXca1YUZNQGsZd1JBuAN8TJH0JG8TA=;
 b=NA9X/HXcvyj3v73xHuJKHLN11mYF+OmuAtcvebI8Ta12YGSjf8MXoGTJ8o7e2n8tDNvX92DjuIgTd41UwdZMk71xm543+azbV0iFVNgQiC9OPPoVvQ/swt5GJRiM97nOn60rAFoVEKIPddgCf0JwS711uUaNjgiLsmaKQ+wSPti0ZqlQ5seZ07KhQHYMxtxqO7rMbiT8ZcRbLfzvr6/9HCrULm+h+2zM5Vpy43/ordcMf6yHBAjC/nYsGU8W0sdrDfno3ghPq4Mvbi2Di8Kc4FIF2nRevyyHt7ks0IgBLCK/gVVgX3gnHeyS3zdSV3xZDVfPWBZ5KTYHLcM4gbynDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgcTm+2HBXH3vgXca1YUZNQGsZd1JBuAN8TJH0JG8TA=;
 b=eFB8HAso13so3kId+6q4pCr1yC7avbMM6pGwt5Nk95JNpEEyQCFLz+8N27dk5wHT3NBusi6VpzlBj0H/AxzpCX1lIOOt1azQYZ6yNSdo9LGgcsVAhOkEWGxrjXb6r+qQT+owo+A/X6Ei/LYdyJy/JDJk4qzc0DKAlX2aHgKj+iENw8/d83LFht8QqEMB8NqFppdkc317Rb2OkJu0D/hPGdWCB660nI+Hzqmu9/oWPd5fNGPDtjLppnny8T72izT66MkWqfpu/rutmOwqTU/KVFMuUSSq86rlZ1TrDQ51rvJhXlxuzEI07EcRDAeu99qTdrDluhY16efuDK+ZLv1wjQ==
Received: from BN0PR04CA0145.namprd04.prod.outlook.com (2603:10b6:408:ed::30)
 by DS0PR12MB7850.namprd12.prod.outlook.com (2603:10b6:8:146::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Thu, 26 Jun
 2025 19:35:53 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:408:ed:cafe::94) by BN0PR04CA0145.outlook.office365.com
 (2603:10b6:408:ed::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Thu,
 26 Jun 2025 19:35:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 19:35:52 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 12:35:34 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 26 Jun 2025 12:35:33 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 26 Jun 2025 12:35:32 -0700
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
Subject: [PATCH v7 19/28] iommu: Allow an input type in hw_info op
Date: Thu, 26 Jun 2025 12:34:50 -0700
Message-ID: <d8c395d6956045fd1fa1349538d29e3b6f9fada8.1750966133.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|DS0PR12MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: f08f1488-0ae0-468e-bd63-08ddb4e8a9a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/mPCt44Q2Rhj/HJwWEZJ70GcxyZuqOj/Rtr8cQ/Ncw8UsWfaAKEbBp1vNx4F?=
 =?us-ascii?Q?V9x+ZehPaWFe1qHVkNvCGdJhnFkot0bl9Naw2VdBP3Z0HFhvwn2jhIgrKnjq?=
 =?us-ascii?Q?u6zU9DgNGUIcvn/WVuhV9LdrBbUiN2JD2bRYzCqJGqezGx/yB43zYO1jw2Qc?=
 =?us-ascii?Q?dcOGqG1uoBI7MmYgffjiyVEeVS+O9sEoBaWI48YEx17iEgajX7X/BmYGVm49?=
 =?us-ascii?Q?ciyO4VhC4S6Rs6AFIlKaeNiylqTDJNqyCs90n+zqBHifyX/W/MzmLJDznNXE?=
 =?us-ascii?Q?DANYe5/thHpHPb8jHjb2+dgAZJ58VNw9zyNL0qvY+Eb7u7rxoddWPbnOgWlc?=
 =?us-ascii?Q?1dLOr7WAt6UARkJ/m99H3ZmwNdkMfrivx4E39ti/1jrJhx3jiRjcvSnOT1if?=
 =?us-ascii?Q?iFAqAPiINZrRQpCJcgQ4VR+uzxpRoaPnsgfA6YON9j4yJ/qKG8K0Bt/ruH6m?=
 =?us-ascii?Q?HA7vySNI5GtubAEoeBPteXFHCYp5EpdCO3B6WdBgTgb9tCcXgkZeWZDk1TfH?=
 =?us-ascii?Q?2KzHuEq+nq7LHgwL3K/txdVcChsIsAF+7AxmZsIXRQ7yjf19zCSD+APqffUD?=
 =?us-ascii?Q?BJWJ17YblBENnPy6xqD8Y0abF/wkP0+wmXj4ANcqytzMifuARmOtjS1Kyx35?=
 =?us-ascii?Q?qfN1+tD6lZjPCXokcTRRByKyUUteIrMAjgBG+Hwz3Ub8z9ocuAnvC42ZwjTv?=
 =?us-ascii?Q?lkZERcF5AstiClub4XRbqRgqG02hGZ5937zwy2nRCGjJyg+HNOeroE64QW+5?=
 =?us-ascii?Q?fMjZFMdS9VkUC+0V0U5ny3cxLS//a+v4ydfkbxcC16+qCVYiMRVTjwUpqcZA?=
 =?us-ascii?Q?s1pdjYAmS1K47PrGIP5qPI4lcwd0Yl6H/vjz2PjFoRIRvnkFXsItxDCAPYaF?=
 =?us-ascii?Q?EntiAL0GntkMy9HTbgrn2i51LFzlAT86tAHBTBy9CmhXqrVP2Q2Gt9MhIIp5?=
 =?us-ascii?Q?d/la0zYmOaEnuGwMzlhwlwzt19FSdWv9aOX0r6nZfL/GrxW02M7AUr0mcsiP?=
 =?us-ascii?Q?hvwV15LuDiXstrKW5yiLtDUED5n8W0Mnt8Babquwf1R1THfmnpGI2w/Q+le5?=
 =?us-ascii?Q?6fSKvY10QLNwqjxsb92QO+xqurIHYADYi6yYumGd1rwKl8iX7SmBUtudE/yz?=
 =?us-ascii?Q?B9AehSBv4iN9GjAG/fF/cpVorR6/3AEId44ALCiHFDiXXBM1vEnZ2c11Svxh?=
 =?us-ascii?Q?tCj4nxenZ+//CTosQcmx6VYFhr1I6e9P3xjA1cniQuJiQEOZcLUeo5YJjczQ?=
 =?us-ascii?Q?+C/pmaSWuQCtkYgOVWExowJNIMl+3u6fx/RvPOhIbv4e8nmCIffnx0ZxxpnE?=
 =?us-ascii?Q?73XSvgUGf4p5642gYGm5m8J88df20IRELJwgRTEhmRIYS6iUQ4DTE8CjkSQb?=
 =?us-ascii?Q?B4RJBejoAnwsRjUb4rs8dLWkghZQs/NPGrR2TmgsfKDrirTbBsPUF2OfyJWn?=
 =?us-ascii?Q?LI0t7e+loF3D9/7GHWAFM5da/CFbRS+Dg+GG0syHUmiPJlFV94bcaHQuilEG?=
 =?us-ascii?Q?/c4SG1lPzKPB6F4pn+yikk9G20up/OAlLUir?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 19:35:52.5983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f08f1488-0ae0-468e-bd63-08ddb4e8a9a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7850

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
index f091ea072c5f..6ad361ff9b06 100644
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
index 8f078fda795a..64a51993e6a1 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1519,6 +1519,9 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
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


