Return-Path: <linux-kselftest+bounces-34993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 665B7AD9AD6
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 09:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9467E189FFE3
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 07:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E17218599;
	Sat, 14 Jun 2025 07:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="asWwauhA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF482144D7;
	Sat, 14 Jun 2025 07:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749885349; cv=fail; b=Ndty8N6XTzYxpYNenK1yU57yzSL7mR+IXrGIHNcRuaG6oBa9cIotwsJBtNiHkLhTMs147wnTxvvxWaxArbjXxPTtDtGg9HErxpTyP00q4mMR2wPso5nLD8noEOqUZiSXX1PmvVsaa5L+HG6sFS/ibV/CXRM7ajYSz75XHZTMgKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749885349; c=relaxed/simple;
	bh=OYFQ0oMgmbYRsq3Qp+lWCQBK0vTfec5UfG84Lqonqiw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J3saq3F9Ljp4SFt7CXevKj3NnQUZfolbAtf6Z9RBDiSa8iuZEjWkdQ60CfoURijeHtnL60vh1jd5NuoExMWk6XBHb2hIWMA2ClUZr2IT+DqbMZcVoFpmmhrhlBnnpj/NPE1qDhcSg/QGzFxlbZCcn1phGzwjpsCSBNGE7KUaWiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=asWwauhA; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3I/8lDvfvGya37AlXXkotqCf/3M65AocYsHfbWfPLbia4QW+k+PcpE84UK6dIWWAqLt7JkZnZ2LNi+HDrwBO8VyAwzhDIAuklhet80AtTqheix8JfroDECHgHGjfBbjeuttEsqNfyhFF0aWkrd55naITNZPMGLKvpn5umpLidftv4otZ6QvfWqbhSEvYIcPlffrAs40gHxDBXGud6EbtV7htK8++oMZggOr1YIGZ2htGTRK2lHyS8cGkNDYBPCVY09zcZY/43uUPglIuJ8IEAgY+N3N5/jkq+0OnByHTCNoRyNXiQwV7qmShn5k+Y8hbdDn2y0sZjSAM+muTipUxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zOdno1w7ycGijPYpYDCnqPjNPUSkYR6iG6wmQll0Qs=;
 b=Wn/l68leu0MR1qo1e4XzSPorT86ctKfCLvl3v3zCBZy1ianpXP/VsF+kqQbIWXzw9vyVsbdLKV/PRYDhsmtY7s4hfvYMgJo2f8cGUWLE6KoRmsm+EQ8Ob1ljEsBN17j0ybYhknhepcMkxGpFDChOI17yEfQerbfwaxzeIvf1qsWImqBs4aECYOPtoJEhbudp89wMXKi5wgA39NovMR2Clkoul+Izy8ircZdwYbdX9T9UC9XKCFj4FHCPLWW0X/1dmrM/B/kVkdEsM0e4tjNjkudzptmzfUwry1MS2zqubILzMq6Q0BPjq4zMf+XShkVhMCBUZl1RAfS3qKzGb7Emgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zOdno1w7ycGijPYpYDCnqPjNPUSkYR6iG6wmQll0Qs=;
 b=asWwauhAAPIJcp07I976ydCweg6Ej8xCGTBKqmLhnkblLJrnWXcyYEmq+HiDEh+BER70M11IsYqlqiIW78pv0g9/hZyctfQShyzBRi3vNyUl9dBlpNOKc1tLdLDFvzc/4F88Tz2RhSAkBnP+pyTtCWBduvKjs5V4avWWSq8v65+pDF7OPhQrSQkVfAy6xKgl24HZOvMto0+578djkAOxrS2UfCJBswqBpGHNEn8sNqfOnNrndBW7iYwi1Fj4z16iIKEq8puV0yvhHiezlenLCo2NHO5l+9s4Rn4GTrT3fsz2KS9S/R/P5PvJ5tRDnPxUNo02TrchnnPxhNSbJhJyKw==
Received: from BN9PR03CA0611.namprd03.prod.outlook.com (2603:10b6:408:106::16)
 by DS7PR12MB8321.namprd12.prod.outlook.com (2603:10b6:8:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Sat, 14 Jun
 2025 07:15:42 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:408:106:cafe::2e) by BN9PR03CA0611.outlook.office365.com
 (2603:10b6:408:106::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Sat,
 14 Jun 2025 07:15:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Sat, 14 Jun 2025 07:15:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 14 Jun
 2025 00:15:28 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 14 Jun
 2025 00:15:28 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 14 Jun 2025 00:15:26 -0700
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
Subject: [PATCH v6 16/25] iommu: Allow an input type in hw_info op
Date: Sat, 14 Jun 2025 00:14:41 -0700
Message-ID: <2dc47d6016bf5f6ad6062ad7d84c7220b789b429.1749884998.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1749884998.git.nicolinc@nvidia.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|DS7PR12MB8321:EE_
X-MS-Office365-Filtering-Correlation-Id: 17a71033-0edf-4e05-fd55-08ddab1345bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EOLcOBwSViAXU63jCjCEK8Y41+J35cSDI8O4G48r4ldYlIBS5P2uktJuGZms?=
 =?us-ascii?Q?H11QjFSaC1HD0sm2fhKpCqsTmUuszbNiDN2Xjsyr/94jJ/iEVDxlP9INgjGO?=
 =?us-ascii?Q?2nf5/R0JxzOJRG5qS+KsixwLZxCvhxPy4hL3zLrlwUPdADcoPDkr+w/KdEBp?=
 =?us-ascii?Q?7tpJ7NLHVt6Fnu8GGtSUWpVQXK5nOMQ7PHfnldwuD12l1efP856zc3cWCXOQ?=
 =?us-ascii?Q?tR2HieU9QTT9uvaSm/UO4bNbK5gsi9fDFqsxiMrVuFaujy85E9Y8DlkKtEhd?=
 =?us-ascii?Q?wj902FKbRvni6PeVilXV/Dppko1xzU0hfSLUpn7rYPZwA1f/d0k28usPo238?=
 =?us-ascii?Q?iUkLW/xxak8MaaV7inX0c2e0PGufaAo7qpkemr9fTJJ8iHP/LQzKAtpiE5fc?=
 =?us-ascii?Q?mfTMD8xxVdA6yLin2ol1Vq60pllSrlGVqsYv+6BbT2WhcUEXsWY5mMZX/MOm?=
 =?us-ascii?Q?gNJVoiavch5XBvjDp76OFh1ni286S79rmtfsFwRFx7a9DON/QWD0TY/3CBiA?=
 =?us-ascii?Q?dSjR8ImztBz8p06GVV3QrMBxiY95uuNNRug80N42atbvahz+XLiZH2Srr6ND?=
 =?us-ascii?Q?3M/mS/1ZNYJOhb3YqQyAuwQMUhf0T5R3uK0wyzH7DBz1zRzhzpC6aVYk+Mbx?=
 =?us-ascii?Q?GXDrxI6WYihuARy01alr5GnxBQway0Siumir/ZVFUd42wVHSIM7XgbcJLXm3?=
 =?us-ascii?Q?efTSjWOnm2Ah2GObmXYPqL/Gh/LlF1xpqqePXstYr/TOzuDvrJ/v4vm+D+EZ?=
 =?us-ascii?Q?OZft2AygcimiwytEWxOrnVCHJfr8pCS4KKs5jdjBXtApLZluwGTYRU51MO1m?=
 =?us-ascii?Q?gN+MOLs8UH5B34qCuAaVSpGTbZDiXIvFkbxhvw6M+7WXAaiDA+JfsT2qVSzd?=
 =?us-ascii?Q?9btVc6k39y8Lr1YJ9q3NDAKm29CJzF6Vp8JNyVRfuCfsHj78Ynbq/u9EVbsb?=
 =?us-ascii?Q?7LSmeZBmbk70FW4VzL5WKJ5sJgIX5/ChN1tYZSlyl9tfBA2nTxhs0jrYyKsh?=
 =?us-ascii?Q?dTQ5XO29jQUj7oLN4I5rrDcNV1e3zbTFVEBrZNuvl6O5m6ouqbluWydRbCmD?=
 =?us-ascii?Q?XAkS7JbdEtsOlNs2yCO0Bc47/Gfug3PDSK3MbUlpIEOX2Comgpj8UWeWrvIx?=
 =?us-ascii?Q?ChEJ4q93W9sEDDPyMGlU7V3+WtUkt/vIKKdv7x5z74Peku/TjCDu7cXLNQe3?=
 =?us-ascii?Q?p1TCNGUDRu+cSwZGJEjg6anggVMdp6OOKWJWhzdbLi7rDAjuaM+XcB9uXya3?=
 =?us-ascii?Q?QEFnecZEQ4uQWAO2fY7LmbNBZ2+qNatVw3xf9f55fGcooI5MpsyYRQ4N3zFd?=
 =?us-ascii?Q?sASHlECCQFGuBJGWc3LTuFMlfIEPra0XrtxOs/PUbf6iUgGInaNmMq7XYUW+?=
 =?us-ascii?Q?I8D7KVC1fcKvDI//3FD7MvbKKyswQOBSHiy6e5JAxDEifBQmgezFam9stNYR?=
 =?us-ascii?Q?D0/39xnc2c4doCObh80wL7J50cNgDVueK2zb0IGeumF7xUMVyZiLzX8NU7uH?=
 =?us-ascii?Q?4mexJM5Rky0OayhNYKw7dPQwm+qVTFDws3gM?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 07:15:41.7355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a71033-0edf-4e05-fd55-08ddab1345bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8321

The hw_info uAPI will support a bidirectional data_type field that can be
used as an input field for user space to request for a specific info data.

To prepare for the uAPI update, change the iommu layer first:
 - Add a new IOMMU_HW_INFO_TYPE_DEFAULT as an input, for which driver can
   output its only (or firstly) supported type
 - Update the kdoc accordingly
 - Roll out the type validation in the existing drivers

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h                               | 6 ++++--
 include/uapi/linux/iommufd.h                        | 4 +++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 4 ++++
 drivers/iommu/intel/iommu.c                         | 4 ++++
 drivers/iommu/iommufd/device.c                      | 3 +++
 drivers/iommu/iommufd/selftest.c                    | 4 ++++
 6 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c712669f3055..95e58ef9cea4 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -603,8 +603,10 @@ __iommu_copy_struct_to_user(const struct iommu_user_data *dst_data,
  * @capable: check capability
  * @hw_info: report iommu hardware information. The data buffer returned by this
  *           op is allocated in the iommu driver and freed by the caller after
- *           use. The information type is one of enum iommu_hw_info_type defined
- *           in include/uapi/linux/iommufd.h.
+ *           use. @type can input a requested type and output a supported type,
+ *           either of which must be defined in enum iommu_hw_info_type in
+ *           include/uapi/linux/iommufd.h. Driver should reject an unsupported
+ *           data @type input
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
index 78d9597d7b86..c14f7e6b4dae 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -14,6 +14,10 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length, u32 *type)
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
index 7aa3932251b2..d0de98cd2529 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4097,6 +4097,10 @@ static void *intel_iommu_hw_info(struct device *dev, u32 *length, u32 *type)
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
index ad33f1e41a24..50f6c27fde32 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1513,6 +1513,9 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
 	    cmd->__reserved[2])
 		return -EOPNOTSUPP;
 
+	/* Clear the type field since drivers don't support a random input */
+	cmd->out_data_type = IOMMU_HW_INFO_TYPE_DEFAULT;
+
 	idev = iommufd_get_device(ucmd, cmd->dev_id);
 	if (IS_ERR(idev))
 		return PTR_ERR(idev);
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index d100ba27f205..71251d9ff1da 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -309,6 +309,10 @@ static void *mock_domain_hw_info(struct device *dev, u32 *length, u32 *type)
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


