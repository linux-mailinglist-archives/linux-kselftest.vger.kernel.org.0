Return-Path: <linux-kselftest+bounces-36927-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08818AFF909
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 08:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE1C189FD3E
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 06:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6777A2918E9;
	Thu, 10 Jul 2025 06:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f2YoMGLl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C54228FAAB;
	Thu, 10 Jul 2025 06:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127253; cv=fail; b=o1Mkfvi5nvjumMULFP3NIaHpXQ+zlgA7WmIZwLTDY6bIm+2nSWMnuwZnpmVqneHez8xp6DrHoDkS63rdMG2e3ylxDLjEOs8zl4A5pirfGCan2Yi4QfPFZWp05hTkWKRKitsWQaTo+7TAlI224Ir+fiCrfb4Vxb1+jkqqRYdiLB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127253; c=relaxed/simple;
	bh=qORugV+ZkL4DFzkPsQHcioEi3scRU8qGK1C8ujE4b7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QoEh30NuB1FsrRlXl4Yqjro3P5t3Jbh4ogDb+hA6oNtQd9q3IruF8wtYnypIRTnG4chdY7jxgn+AqKvLWgsU824QHP1cPhs2HGg1ExInpezfftJX1KAI0f4+oR/WJbQTlvvjc1JKDxHJaocarKAcwF2syRarXEy3HNlhvMCHubI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f2YoMGLl; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kh1WEevpt9p9vKeqXdguTBOdyvAM9XtuzBtrEB/iNAju8vR5oArIszkloAJnQJDAXd94kJSTM2majVAbm+6XYCbC1nVdT5v6jGQ32feg8pwoPosugFwAuuYOuv0iYEy3VFrBeZ61JVz/pMhXM5DdzUUFMv7hFLSI2qpuJ61rz1cEK7gs44m3mgUdwrDlKEqo9ggcPs4RzBu4cmrXFFOj9UB3q2rS1lzykWkTZTRc6784LicsMT4p9Beg5XYzcX8UQ5IziL6Nxk5hC2LaZEvzpPPBAoT4V6x/xxeEm0kjmTd6vIBlm6k89pUQ0GXD+59iXGsHWLQoIflp+gcqvq7Dgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUL8oWtULdhuTJLc+uoqLIWkUYqfIRWborrYbf7Bb7I=;
 b=VCidHdhWTKciFDytB7+kdWZaIIJXQ7TLoFlJr5r37EKGwzauTKvK+j+En0bq1J6UQHmLh46AIdQJHjXbmeLsT7Alh6QmzluizyAMLS22eTqtl1f46Jv5yLAWZ0hOMrEjK+WECau+vLOAT/turU0QNekse6QCLOrFWro6GmcyUlys9Y32nylgVgd/eTooed0tmsVt6bOFmX6Y1I7ZkoiT2fLg0KH6vJcbiYLIDrza5pPbPj9JsLuFEkEquOmrsKFgB9RUXCVzGgtZg5udho09txkiAhok30/sS1cmHl8rX/0ysBUxzlAwvNA7vt6VYJar66ul9aAgr54exZzQd2/TPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUL8oWtULdhuTJLc+uoqLIWkUYqfIRWborrYbf7Bb7I=;
 b=f2YoMGLlVITLxcjh5ignsHgaDLJ02pZv8oBn++obX0yROCpOLyOhdtqdIUKmn0aya/0m1oWy84LSgnLye5/Q1Ya8N9HCcd3ktl3fOmIIF5qzUlAZk2EC7dwCSOjaYivr6g/M/crdFR5bq/CmhIxlO4+fILyapEQCc+ZLn0hljisbjf1gsEQmwJ5Af37111y8ap18cN84GGUgH2c7ryPPoEezVNH/Aaxkyk+fj+uGqEObNr8U18ahVhD6NvNwfW4L9kE2GBfgsRMPY9Bsd9p4j0+8Lk+K7m4qfqnI1aCDsgkeKC7nWDjyhMSabEKh7eqKJxPAQ1KHtMXOY7yE6Isc9A==
Received: from CH0PR04CA0047.namprd04.prod.outlook.com (2603:10b6:610:77::22)
 by MW4PR12MB7440.namprd12.prod.outlook.com (2603:10b6:303:223::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Thu, 10 Jul
 2025 06:00:46 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::8) by CH0PR04CA0047.outlook.office365.com
 (2603:10b6:610:77::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 06:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 06:00:46 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 23:00:29 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 23:00:28 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 23:00:27 -0700
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
Subject: [PATCH v9 23/29] iommu/arm-smmu-v3-iommufd: Add vsmmu_size/type and vsmmu_init impl ops
Date: Wed, 9 Jul 2025 22:59:15 -0700
Message-ID: <375ac2b056764534bb7c10ecc4f34a0bae82b108.1752126748.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|MW4PR12MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a192b3e-81c1-48ce-e6c3-08ddbf771cde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aHryjJ78v7QNvzdnMQim8unInat415eCWomWVpBdFGhYWgH7aFda2c/YbF2t?=
 =?us-ascii?Q?aR1XuzaMPm+AIcenKdU9fgO3jnfb6OZl1NhTNnPycKPqx99I7OtAIhIJtw3m?=
 =?us-ascii?Q?dKWeMuT3jLlI3eHa8pDFd9NYx11sSoxNgOr74tNUng4Rm0ksbmkfJddeFR9d?=
 =?us-ascii?Q?F82ObQIXtXKPipmctxQijgo+qJ3DSmQdtZEywxHGYpFStrRUP/OuKBO2l7OU?=
 =?us-ascii?Q?JYsDrLV16Gc6LdOELFdGF1eL2XxyCM5iq4TxP3bkVzOsZKNjqPmhleswc7Bx?=
 =?us-ascii?Q?DGxKHukUuGLdZlpk7y6OKWBzpJQynloYupIdrN6GTPpIKO5PWY2KDcPifa+X?=
 =?us-ascii?Q?+DOW919uMQ5bv12II5JXu9q28hgLCyUXw6MfTKbX8nVQ4iLzIiEsOq3lqPda?=
 =?us-ascii?Q?M54Hys0sBhC3Lgg+JzgCB/T3FQ0XRlx4nhZm223WizXgLrAKcoAGJf5+3SEV?=
 =?us-ascii?Q?zdMOlvmP5YmlOCTfmMLK03frEUniBvh0IetFJCVW5qo9RWoI3CqCoJzlLYWr?=
 =?us-ascii?Q?jC0wUckJMnbOEL36bWAGL5y4X31sNtAfoymHP8UMsrAg0lPc/ajWF8oNS0JL?=
 =?us-ascii?Q?6dkXHEnEVLgDwEzS4MEcDlDFY+H35kzUoDp9Vi+XcLWgCEh9+m92SkacIyDX?=
 =?us-ascii?Q?4NvxJgO3jJevRjJ7RALl4oPoioa/6G37pLGzMVUmQRJbm1aU3tg6DKu9WfbS?=
 =?us-ascii?Q?h2ppCyJmI2oOKWV1u73q3Ke1oX1HeFBkLm+EIqaSwaGrnskoPQvnH+i/TCZF?=
 =?us-ascii?Q?s7z+Q8pHrcH65+qnBuXjLcGaoGGWWhkjdfuBhPpunRNfvTa0FGDycn5L/HFs?=
 =?us-ascii?Q?zY1ggm+m1d9AjE6zHeqv5J1jLvnM8mzJIxnVS24z8UDGGiv9utW7T3aGp1yW?=
 =?us-ascii?Q?X9rug0a/ZtY3qtPNxx7TbgOSwsyjy2bvSyqagdUV38VdIL3yequI7185x1dX?=
 =?us-ascii?Q?+jRZScYG/UITQT22w2+Kb51gq116+gSuI6oCwT92BMNVsJ0X03DRPuvzdJ3+?=
 =?us-ascii?Q?nYNjb7WrX9fj7TDVwp30cke6KXFt8OwFLErVJQ2EYz55I2ztSErxMBxyhbwz?=
 =?us-ascii?Q?Zw8ba/x7VW9ye0MQjsBriTATM2SetbTjZDSFCJN5Ufm7tfe0M7pb0CMtOy4y?=
 =?us-ascii?Q?v2f2sx9biPJoss6ire9f6AgwYeGQnvfdl5RE1sRrfXl+f0MTRTGJGoZhu7pX?=
 =?us-ascii?Q?dulP/7gSO704stwGsGOpuIyW8BvrStXD9Vgr0b5LXSAJImINcaP3AGPkS0zX?=
 =?us-ascii?Q?gLScA6Ybd466x3FbYkoFlWI6w8jIPuu3MMPbm/1zwSCGeuqUjayQp84R6Do8?=
 =?us-ascii?Q?uuoH/lUFS21ooPfE2ZOPJIn/LF0kg4XNUbZZryO0AiZ5a0VgqQVypoHnSQJC?=
 =?us-ascii?Q?Ue2YsjdOTPmQC1MeAW8O1AweYir+nQu0Y3YUGBxUnvqgJInbWGkCr0cD5eNT?=
 =?us-ascii?Q?H7hofrRxOJSUlZYAOmbcJFRj4lkcL3TJAvpRuio/Nuw8iVo2iUZvxETmz7Qi?=
 =?us-ascii?Q?kKopZbg7ayXklyOt/NApBaYheeG3TRI5zfJP?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 06:00:46.1276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a192b3e-81c1-48ce-e6c3-08ddbf771cde
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7440

An impl driver might want to allocate its own type of vIOMMU object or the
standard IOMMU_VIOMMU_TYPE_ARM_SMMUV3 by setting up its own SW/HW bits, as
the tegra241-cmdqv driver will add IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV.

Add vsmmu_size/type and vsmmu_init to struct arm_smmu_impl_ops. Prioritize
them in arm_smmu_get_viommu_size() and arm_vsmmu_init().

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 5 +++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index c1ced4d4b6d1..6183f212539a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -16,6 +16,7 @@
 #include <linux/sizes.h>
 
 struct arm_smmu_device;
+struct arm_vsmmu;
 
 /* MMIO registers */
 #define ARM_SMMU_IDR0			0x0
@@ -720,6 +721,10 @@ struct arm_smmu_impl_ops {
 	int (*init_structures)(struct arm_smmu_device *smmu);
 	struct arm_smmu_cmdq *(*get_secondary_cmdq)(
 		struct arm_smmu_device *smmu, struct arm_smmu_cmdq_ent *ent);
+	const size_t vsmmu_size;
+	const enum iommu_viommu_type vsmmu_type;
+	int (*vsmmu_init)(struct arm_vsmmu *vsmmu,
+			  const struct iommu_user_data *user_data);
 };
 
 /* An SMMUv3 instance */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index eb9fe1f6311a..2ab1c6cf4aac 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -416,6 +416,10 @@ size_t arm_smmu_get_viommu_size(struct device *dev,
 	    !(smmu->features & ARM_SMMU_FEAT_S2FWB))
 		return 0;
 
+	if (smmu->impl_ops && smmu->impl_ops->vsmmu_size &&
+	    viommu_type == smmu->impl_ops->vsmmu_type)
+		return smmu->impl_ops->vsmmu_size;
+
 	if (viommu_type != IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
 		return 0;
 
@@ -439,6 +443,10 @@ int arm_vsmmu_init(struct iommufd_viommu *viommu,
 	/* FIXME Move VMID allocation from the S2 domain allocation to here */
 	vsmmu->vmid = s2_parent->s2_cfg.vmid;
 
+	if (smmu->impl_ops && smmu->impl_ops->vsmmu_init &&
+	    viommu->type == smmu->impl_ops->vsmmu_type)
+		return smmu->impl_ops->vsmmu_init(vsmmu, user_data);
+
 	viommu->ops = &arm_vsmmu_ops;
 	return 0;
 }
-- 
2.43.0


