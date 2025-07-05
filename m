Return-Path: <linux-kselftest+bounces-36627-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BF6AF9D63
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 03:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD65D5875A7
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 01:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9955121930B;
	Sat,  5 Jul 2025 01:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WOz9b42E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB0C217F56;
	Sat,  5 Jul 2025 01:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751678083; cv=fail; b=rCZY9CnCSf55WN3cFoK9XVRahY9LW5e0FrWtQDeHQtX+7xV0qjwNGL1ValaVxyEUCxYPwBRKwSw2U9oS5mYW6M3ndBJr+JQc2gGCOoEWCmeryM8W91k+EU8HvgQ9L7BLGHU/0jY0nVqnmiMfClcuKkfbIVP5qJEB1u+inqAUIkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751678083; c=relaxed/simple;
	bh=t1iHCfRajO0uhwDsj8DBsxfolQuNkNYe+1csP6GF6X0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WUsXNkUSppciGFsvgJLfV97Cj8wTlquD2/5Nl7vGnpOnswF07fcXbSby4hNKNy+SSIYCKSVBYdLhyqzJLaKW4ApeyQzpy3WaQE4aEIuO6I4SZiRi+xoN5/RcmmYdpLLcCUmazd5oORb/PDZWo3dgtxGo/BqEVwKMdQMN9yECI0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WOz9b42E; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FD14mHNd9lvwlEG7H+j8B0867J6PDRLoTp5rc5CdlJyw5NzQsZOUMOMkaTRjS94+RU73HEbzLWXYSrukZb3+5R9YR62JmtBtMzdSv9cJgO81TECp6/BlMHs2j9B5ICquYmRmGX56PbQidr+kfODWZfi4LbkWXtnVg+CYGRa7V1oSihfxhVg0qWAr3uGTBWK1ioFm6gqS2cmKX8VG7fwmzRmDaAO6ydX4gJsA50G/hG1RNi/+dFFNd/1JIkKSqxFmI2MmZkpEdn/AeBhQ+vxGaFS541BG1yTLnEqkwyPj5lyX6MOl8BDk+L1sBDCbIA7ncwSUH8VZ/JIDHR//ze6qPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7nKlLhMFuvvQT159s7O7yk1+CbSermr3lmUn9j45C4=;
 b=v2tWQFr1qcpAL8HYTuA/NEHitcEE+WKzz1EwkzURmLKA3fUlVByfkxA7Y36pSb7hw5Eu6K54TJ3DMKLkRoIMzImcmhBKyVC4ZzrtaCk28BDz9DNWmOC2HgGBZIg2dIE/8YTI1hYA5nnIWgVhP7QzFr57XImDMrgcph/QHuTTBX8KNhwvbbrptigY8eWXtwxzVRMj0xHoLLMUei0uxZeD/smu9splOQeO2PqUHAWnO3wudriajf5eLe16ws/oNv7JZs0CKnwxbO5m8JGkB7Udwb88FR/b4BPCbplgndijB5nOeXeQd8lPQ5JY+6IRdfxTgdvFO3OCaWFp6Y/+AMsesA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7nKlLhMFuvvQT159s7O7yk1+CbSermr3lmUn9j45C4=;
 b=WOz9b42EacyyGf0sFpfW/r4QQRWo13hwtTOgFeI80LAyBLfbU0yLemHtWahJ8a38k9HqnOyZXgghS472vCsD8103IS4Ln1RVL0MAoInx4oXv8t++tc6NOQcGNV2Gc6+LiFyAMugs+dNOQsNFnXAaCjQckz0n7qMEswRQo15ks35w311/8n+TwgderKenNWlGVaLn1YKSpsQI1h6IFlXiIRjJEICoh0DU9uSyh5yThNxWWrDxPJ2lt0KQqIYBns3hpi5TQwG1DusGic1hami2cIHnDcZQEv7Fzf+Ceve5ZPEj+MKw4MzBa+ZkUzvNIjAnmq7BxHqtbMwfNR4XQ6IgGg==
Received: from BN9P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::31)
 by DS5PPF7856D51FE.namprd12.prod.outlook.com (2603:10b6:f:fc00::654) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Sat, 5 Jul
 2025 01:14:38 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:408:13e:cafe::f7) by BN9P220CA0026.outlook.office365.com
 (2603:10b6:408:13e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.22 via Frontend Transport; Sat,
 5 Jul 2025 01:14:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sat, 5 Jul 2025 01:14:37 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Jul 2025
 18:14:27 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Jul 2025 18:14:26 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 4 Jul 2025 18:14:25 -0700
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
Subject: [PATCH v8 20/29] iommu: Allow an input type in hw_info op
Date: Fri, 4 Jul 2025 18:13:36 -0700
Message-ID: <291aa4bc3f0f4c84c322143ada14521160fe228e.1751677708.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1751677708.git.nicolinc@nvidia.com>
References: <cover.1751677708.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|DS5PPF7856D51FE:EE_
X-MS-Office365-Filtering-Correlation-Id: 59ba9e22-763a-419c-f6ff-08ddbb614fb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GcM91PlU5vTa2ZJxCLobaiCQo44ac7SiQzPj86Ws93YQWzp6twK9GNJ6qnhx?=
 =?us-ascii?Q?b9iq91UdAYb3prFKb3KjC/QISOomeakVgAWDMYUUiv02OR0w0O9DT/w6w0N5?=
 =?us-ascii?Q?AUCWwYUWTitoxqUbzJRhUOK44559PiTNNsRcjLtFvltzzNYNwGAj6np3jBZt?=
 =?us-ascii?Q?FyBK149nyN8ISWYcFEaLfpaY77qdbLzszpIX0fEHFQlQXxinnLU8a167mPPq?=
 =?us-ascii?Q?ixu2dXOzZ9Ri+ardaFBFUodiUJo5MO3KMQtSIw24ye2hmwsjewGPUs1Wx8Fz?=
 =?us-ascii?Q?L6sfp6ZNSDTT3bmY2VSy3iZhqplhR+AOlAOBk2IcBgkMHuH64ZAytpFrajkZ?=
 =?us-ascii?Q?e5tplYdjrAp3Ir6Z2ofI+OH6WeIYbRSM0VikvSK+AHp/X3qoxid6PiUFHl40?=
 =?us-ascii?Q?2Q8WmlPnJBoDuzIOUAsJtyRLDZILRdy5WemW51inNeoxinZ0AfvI+IL1CCjK?=
 =?us-ascii?Q?Lx/fGZka7WmXEfeoQjGOJBD7FUCmgtUZb2OoMKRCunzXedIZevPkupuy+70z?=
 =?us-ascii?Q?JMLgfnR1GbmDKDX+Qd/6S+2RYWbDgbShsscM91XNuig3aULdWGay0YjMqglK?=
 =?us-ascii?Q?HhuNk43SPB0FnPdanWFJ16HzNk+4EFlr+QeH7pclvnJHG6AH36/P7qcEyXj/?=
 =?us-ascii?Q?VhjVlWFb8qIoL0Vxv9TS4NRw/rmV8Gixd7rPBCmOLzOEPtCIPa6OKYAh1sth?=
 =?us-ascii?Q?xzIZCY0zAxuW8ZBheIdvORTIDmQxuuYa/9INgBAIjQzfFPsAp2eiHFrmhfoB?=
 =?us-ascii?Q?z/p0y4ZKdOTjdjpZTV57rE/nKIVb/18hMvTRaQJcnfkEGezYZr6dXXAXNJ65?=
 =?us-ascii?Q?MtIgs0yKuSeP4xdh76d5K8gHh247yoPdEn70EbwOCGfBk5ZGAs5XZ6M0Js9K?=
 =?us-ascii?Q?0+FMHbo0n4ILRtBGB42kvJ3jndOLwAO0y07kYEaE0eX17e2eXugbeFlsX57I?=
 =?us-ascii?Q?opuTf8K3IQ1EzlKgbAx/ZRLtLxTwOxSOCgBAFYV6dmvXtutmJhi9GXI+Mrti?=
 =?us-ascii?Q?nPZcRJ32kkbkKWleUE1PpkfgwxJx/MQxLwBE6eD2k2bkkQKsjAWMA0DBgJOk?=
 =?us-ascii?Q?iiIezRanErWk0Zp1573JbvZihww0U0uMD96Ou2aP28NKrso/nEMqAO/hrrXt?=
 =?us-ascii?Q?Dnr27IteOuHEHNDKUXF+jEx8pDOc/IOxpQpmsrK2DFFPTQKDZXAuydptL0VK?=
 =?us-ascii?Q?/wn2FUw7/QYXIyEFJWk4x7rklpPL+YXhJsg91ZAUqHvj3bOeHO3vPIi2B6D7?=
 =?us-ascii?Q?5YVYbrT0PBwM9Lc194aWqZgKWjSato74fGMyfuLLBeCEF5RIjM+EugDcCv+5?=
 =?us-ascii?Q?09ZJ2VKbv/Z3ff+s2ieoHfcj9HwpR7y54rWA+4FTv3gfHTpTjVObcbMzAjOn?=
 =?us-ascii?Q?qkUSV12Mu7IC5r1n5CM8rj6RdL0AitYkk1d4tvtF5JRj98U13NI8PJVx0h5f?=
 =?us-ascii?Q?lgEoha+neEUILNE3mRIQgro52je8Js3N3HcDab+j36gR/YlGKkb0Zk0Ga/VN?=
 =?us-ascii?Q?uWz2cTvAcGTG2yugFr3pbYRA4h+X8zpfoiJ5?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 01:14:37.8101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ba9e22-763a-419c-f6ff-08ddbb614fb4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF7856D51FE

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


