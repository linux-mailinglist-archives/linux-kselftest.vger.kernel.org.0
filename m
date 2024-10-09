Return-Path: <linux-kselftest+bounces-19389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1A499721D
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 18:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83155281B14
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 16:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5581EABB9;
	Wed,  9 Oct 2024 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bLaWzkSo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACF71E909F;
	Wed,  9 Oct 2024 16:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491979; cv=fail; b=YyvdhB+gYBZZJKkReWgovt42S5Ghb1cNNQp9UXCWlzQHGl5+3Pq05DZejv1PjCVOZqk78+oETg8LKAze2ZMkJ2WBegZZvqQ0zF/FN1fr7wjQABc1CMlx0px0M/yedteKCRhEAyVHeh4nRrag3DAEL1ib1JL9Fy5Y6KkrHB4m0JI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491979; c=relaxed/simple;
	bh=4tVbGJUJqtNGaVcT8R0kiIUNsrETZdEzeMtjYjZZwF4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJyFOA9GsedimmSYxjAqeT+ydT30gT5xozBnAo67CbLwkJWBx8xb2akVqbfVSpwimULPlqAS9qX9FwOnmiPh2IpN5vKKMU8v4MXLPZqm2rKygw4+yLd6aUF0llxanQectJnBKJxmNB5JJA9MFaWQ3rGRiBLZ8TdV6EBplxTDXgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bLaWzkSo; arc=fail smtp.client-ip=40.107.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqQW/iuDu0OPAQSHMzb5UUmd+JmjC17sWS/bPIQ+2Ug6ovvB5vyHjdaEGE/fdSPDvuou5jfH2QcEmz4+o7Hhai2lTipVccs7q/zlXYA24gm8B6xOWnTuRsnlHwowjiM0Mij5B0d7MbpQHcc9eTM/a/SQ31azmfVOUbUVlI1zyeaiDi7ImtGOsIV76/v70mB7XeX1aia5T5NCtv+wIFZU6GBVMt1F4Skl5MtQE6YjzTMtTrzF4CgYIV+GK9yDigPXkny+j2jLiGPranxyP5pTpDgw77nmn4RA2zVSRolmHcndfdhuZp6ENvKvzmHnlA6KZRjZ3c94gO9vgxwAcpInRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhNOrtl8ngqFvDkhNDxq9eJsPpkGfYBdkM2wPGCOqls=;
 b=PxWKkXyNeKEljbRjE3967yQKocGcYsUJ9n6Otm0ciFKIVSdmvL49sHVLaaOBJvjK91/i6M+bvTupUsQxrM9E7DRY8OVInSTToDf2/URPc5T33fq/0/LblQ3cK1hET8OBSU7sLkNRtdvxnZ4CyxWwVd6aTHwfMH0mbpHhyCr9BABAw4Ja10O+keTm2WCjLLtutQxT8cJQb+KsDZexupoNPi+Im3jXMK12a4vTKNDGctnKS3KA6k/8zpiujcukcxCkDNDHwGhT5dZfgxMl/1+2ncL7fF/U9f2BgsiBbVRhF99IWTjfBiZ7C0Qio2v0Z5cYZA+P4OSWxEvA0mMqkbslAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhNOrtl8ngqFvDkhNDxq9eJsPpkGfYBdkM2wPGCOqls=;
 b=bLaWzkSoexE3I9fpEvt/PMDHfi7X0Q8cKQUVGKHoW8RlNBToHl0/mL9UfB7XQsbe+TwDaahgGfIqD99MIsymrzOdGZcZDakDmngbkFni6lUm+5gUkw5DovahWFZMXdyH+/JaMvYCu8KQH5mCPchM6Qe/6GZ9NzeVl8FTeJVEPDA7xypm5nLkgJw7tRFJY/58/H1mNYomPRJlG6R6zvUeicDLRE45tbsuR1CdhLKc7M6mpSYPfLdAWBJlNeuQFnxddOfmESsRUafRhWqkz9Bmunh4XrX2pTT58tWsXR8eQ9PKngC0SFIrL1ro3qq1cujbURqqjQ6R4MJnGq0+qm6D2w==
Received: from DM6PR02CA0146.namprd02.prod.outlook.com (2603:10b6:5:332::13)
 by CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 16:39:29 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::38) by DM6PR02CA0146.outlook.office365.com
 (2603:10b6:5:332::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 16:39:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 16:39:28 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 09:39:16 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 9 Oct 2024 09:39:15 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 9 Oct 2024 09:39:15 -0700
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
Subject: [PATCH v3 15/16] iommu/arm-smmu-v3: Allow ATS for IOMMU_DOMAIN_NESTED
Date: Wed, 9 Oct 2024 09:38:27 -0700
Message-ID: <6c6a25c296eb988d590883c296c21ebbedd53f72.1728491532.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728491532.git.nicolinc@nvidia.com>
References: <cover.1728491532.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|CH3PR12MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fb22699-253f-4f66-b349-08dce880f1d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?maQjsK/scGjNzLapr+wPuvlvX7d6caK/9hF1tYo7phZauhoe7RW20GAjGf/Z?=
 =?us-ascii?Q?upFPF+mci0cJsnw1Nb/jJtS7OprDhCwF5QwICm1ZtNqNxkEnHWCM8X965BeW?=
 =?us-ascii?Q?dhu4mYrXLk/eaNHQls10NvgvzkL3yo10UrPr2KmV4sD5xaSvpH/otbLFk0cx?=
 =?us-ascii?Q?7B4fzUP5SK1yL874iJEn42I5GG22FSfkD77IL00kQyp+opO9FY3G3Aqd9PAV?=
 =?us-ascii?Q?9Vk1WE/yPpBXEbgpzGasNZJNs2N7+fG6G916Z7b+jE8PpK1DiRdDo3J9qRl+?=
 =?us-ascii?Q?06dvFN15cICpBRU7JuPZPMa2NOKgj0ZxijhBUJv86z0anQml1L7O2shSQD8Z?=
 =?us-ascii?Q?TDGAnCn7hIARQXijvbTzGtvQGHLB9DZ5/B3TCS6cUeBG6bwNGDFdPeFnFrN9?=
 =?us-ascii?Q?HMCwqHlXdNKFUh5GwCDZVm1y8+trLgDOe9AtluenSONsvf/uhkQdsHrv+RzR?=
 =?us-ascii?Q?m5O8YR6c7Uxgk+lHANfctqLdYPUqwzf1MFKAr5rZOiBOI2gzLHjSib+xxw1s?=
 =?us-ascii?Q?hUvZCray+OIdDhP8zM5wJ6Ktr9E2VaJvmcGSSdlSSaTfPInjeqB8Tj6W8X2l?=
 =?us-ascii?Q?4Du8gNdnL1Txmfzg9uN50olQEyRGcaM1czDN05IbG+QCudCD6MaMOYNgsxGB?=
 =?us-ascii?Q?WguNndnoPs6C7ZEFAbKRA8DcuUqDTCdw1shCuyscrwhHcxFyqSJmieF3d9hj?=
 =?us-ascii?Q?GJwHuX/Lj9dDzhsOICIVojTrtp+/QbgpyfNELZbQbacCl40dtgPIUccPgcoG?=
 =?us-ascii?Q?lUN8HInz3XS4gd/Q6BLhZohtj1JGmqoYusUak4TWsUh2sK6IRsrUEUTYxs4S?=
 =?us-ascii?Q?BE0eMbqb4nuIyMCVn8P+QI1evRnekOYHNjqcmj2cm8W8zMkl19IbFQHQFoiW?=
 =?us-ascii?Q?f+E0B4LmwP5hkjfghhtNl7dluzPPsgbqgIR5xYqvdyyMormnKAS7VlYZQ4An?=
 =?us-ascii?Q?bgcLOfeGLE1IovhQYBjWlGHZShQYku7R0xqer13TcTCMfMhvLuXjteJ+fpVA?=
 =?us-ascii?Q?aXMMqrXdqQEBPUmQ1kY1om3SI0uWQej0w1ST+ynVZxkPd1pXM7f11upVNse2?=
 =?us-ascii?Q?MlCBggltwGtSZJPZfIZkJf7qww9JC0/gnBtKC9Zf80Qa5V9PLdlamTAIpoSZ?=
 =?us-ascii?Q?xtsPsz8kq3S7JUTdxrYXhaXgNYN3xSRhjA4rsa0PX4wA/VEPw5Y43iFVaorG?=
 =?us-ascii?Q?z2vFnNCdpCnJ38+DGxCFaPMQuUO5PV/e6tHquL1kcZ7+pPmWrkxV30waanoD?=
 =?us-ascii?Q?vOsloTQbd0iKqJrFqrb7EgnGqY9Xd9kteIucU9MiwQQF6VphX8rNwBRypEQn?=
 =?us-ascii?Q?GGc1r1IfccEUztbqmf1FuKnlks4uuPj23DYOENtI5BqBAhXaVtarpdN3+rmR?=
 =?us-ascii?Q?k0GpwQc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:39:28.8936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb22699-253f-4f66-b349-08dce880f1d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8403

From: Jason Gunthorpe <jgg@nvidia.com>

Now, ATC invalidation can be done with the vIOMMU invalidation op. A guest
owned IOMMU_DOMAIN_NESTED can do an ATS too. Allow it to pass in the EATS
field via the vSTE words.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  4 ++-
 include/uapi/linux/iommufd.h                  |  2 +-
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 31 ++++++++++++++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 27 +++++++++++++---
 4 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 000af931a30c..470bc3ee25ef 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -305,7 +305,7 @@ static inline u32 arm_smmu_strtab_l2_idx(u32 sid)
 #define STRTAB_STE_1_NESTING_ALLOWED                            \
 	cpu_to_le64(STRTAB_STE_1_S1DSS | STRTAB_STE_1_S1CIR |   \
 		    STRTAB_STE_1_S1COR | STRTAB_STE_1_S1CSH |   \
-		    STRTAB_STE_1_S1STALLD)
+		    STRTAB_STE_1_S1STALLD | STRTAB_STE_1_EATS)
 
 /*
  * Context descriptors.
@@ -838,6 +838,7 @@ struct arm_smmu_domain {
 struct arm_smmu_nested_domain {
 	struct iommu_domain domain;
 	struct arm_smmu_domain *s2_parent;
+	bool enable_ats : 1;
 
 	__le64 ste[2];
 };
@@ -879,6 +880,7 @@ struct arm_smmu_master_domain {
 	struct list_head devices_elm;
 	struct arm_smmu_master *master;
 	ioasid_t ssid;
+	bool nested_ats_flush : 1;
 };
 
 static inline struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index d9e510ce67cf..9527a4ecfd56 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -404,7 +404,7 @@ struct iommu_hwpt_vtd_s1 {
  *       a user stage-1 Context Descriptor Table. Must be little-endian.
  *       Allowed fields: (Refer to "5.2 Stream Table Entry" in SMMUv3 HW Spec)
  *       - word-0: V, Cfg, S1Fmt, S1ContextPtr, S1CDMax
- *       - word-1: S1DSS, S1CIR, S1COR, S1CSH, S1STALLD
+ *       - word-1: EATS, S1DSS, S1CIR, S1COR, S1CSH, S1STALLD
  *
  * -EIO will be returned if @ste is not legal or contains any non-allowed field.
  * Cfg can be used to select a S1, Bypass or Abort configuration. A Bypass
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 1b82579eb252..b491017921df 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -103,8 +103,6 @@ static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
 		.master = master,
 		.old_domain = iommu_get_domain_for_dev(dev),
 		.ssid = IOMMU_NO_PASID,
-		/* Currently invalidation of ATC is not supported */
-		.disable_ats = true,
 	};
 	struct arm_smmu_ste ste;
 	int ret;
@@ -115,6 +113,15 @@ static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
 		return -EBUSY;
 
 	mutex_lock(&arm_smmu_asid_lock);
+	/*
+	 * The VM has to control the actual ATS state at the PCI device because
+	 * we forward the invalidations directly from the VM. If the VM doesn't
+	 * think ATS is on it will not generate ATC flushes and the ATC will
+	 * become incoherent. Since we can't access the actual virtual PCI ATS
+	 * config bit here base this off the EATS value in the STE. If the EATS
+	 * is set then the VM must generate ATC flushes.
+	 */
+	state.disable_ats = !nested_domain->enable_ats;
 	ret = arm_smmu_attach_prepare(&state, domain);
 	if (ret) {
 		mutex_unlock(&arm_smmu_asid_lock);
@@ -140,8 +147,10 @@ static const struct iommu_domain_ops arm_smmu_nested_ops = {
 	.free = arm_smmu_domain_nested_free,
 };
 
-static int arm_smmu_validate_vste(struct iommu_hwpt_arm_smmuv3 *arg)
+static int arm_smmu_validate_vste(struct iommu_hwpt_arm_smmuv3 *arg,
+				  bool *enable_ats)
 {
+	unsigned int eats;
 	unsigned int cfg;
 
 	if (!(arg->ste[0] & cpu_to_le64(STRTAB_STE_0_V))) {
@@ -158,6 +167,18 @@ static int arm_smmu_validate_vste(struct iommu_hwpt_arm_smmuv3 *arg)
 	if (cfg != STRTAB_STE_0_CFG_ABORT && cfg != STRTAB_STE_0_CFG_BYPASS &&
 	    cfg != STRTAB_STE_0_CFG_S1_TRANS)
 		return -EIO;
+
+	/*
+	 * Only Full ATS or ATS UR is supported
+	 * The EATS field will be set by arm_smmu_make_nested_domain_ste()
+	 */
+	eats = FIELD_GET(STRTAB_STE_1_EATS, le64_to_cpu(arg->ste[1]));
+	arg->ste[1] &= ~cpu_to_le64(STRTAB_STE_1_EATS);
+	if (eats != STRTAB_STE_1_EATS_ABT && eats != STRTAB_STE_1_EATS_TRANS)
+		return -EIO;
+
+	if (cfg == STRTAB_STE_0_CFG_S1_TRANS)
+		*enable_ats = (eats == STRTAB_STE_1_EATS_TRANS);
 	return 0;
 }
 
@@ -170,6 +191,7 @@ arm_smmu_domain_alloc_nesting(struct device *dev, u32 flags,
 	struct arm_smmu_nested_domain *nested_domain;
 	struct arm_smmu_domain *smmu_parent;
 	struct iommu_hwpt_arm_smmuv3 arg;
+	bool enable_ats = false;
 	int ret;
 
 	if (flags || !(master->smmu->features & ARM_SMMU_FEAT_NESTING))
@@ -204,7 +226,7 @@ arm_smmu_domain_alloc_nesting(struct device *dev, u32 flags,
 	if (ret)
 		return ERR_PTR(ret);
 
-	ret = arm_smmu_validate_vste(&arg);
+	ret = arm_smmu_validate_vste(&arg, &enable_ats);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -215,6 +237,7 @@ arm_smmu_domain_alloc_nesting(struct device *dev, u32 flags,
 	nested_domain->domain.type = IOMMU_DOMAIN_NESTED;
 	nested_domain->domain.ops = &arm_smmu_nested_ops;
 	nested_domain->s2_parent = smmu_parent;
+	nested_domain->enable_ats = enable_ats;
 	nested_domain->ste[0] = arg.ste[0];
 	nested_domain->ste[1] = arg.ste[1] & ~cpu_to_le64(STRTAB_STE_1_EATS);
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a2bbd140e232..1cb4afe7a90a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2107,7 +2107,16 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 		if (!master->ats_enabled)
 			continue;
 
-		arm_smmu_atc_inv_to_cmd(master_domain->ssid, iova, size, &cmd);
+		if (master_domain->nested_ats_flush) {
+			/*
+			 * If a S2 used as a nesting parent is changed we have
+			 * no option but to completely flush the ATC.
+			 */
+			arm_smmu_atc_inv_to_cmd(IOMMU_NO_PASID, 0, 0, &cmd);
+		} else {
+			arm_smmu_atc_inv_to_cmd(master_domain->ssid, iova, size,
+						&cmd);
+		}
 
 		for (i = 0; i < master->num_streams; i++) {
 			cmd.atc.sid = master->streams[i].id;
@@ -2630,7 +2639,8 @@ static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
 
 static struct arm_smmu_master_domain *
 arm_smmu_find_master_domain(struct arm_smmu_domain *smmu_domain,
-			    struct arm_smmu_master *master, ioasid_t ssid)
+			    struct arm_smmu_master *master, ioasid_t ssid,
+			    bool nested_ats_flush)
 {
 	struct arm_smmu_master_domain *master_domain;
 
@@ -2639,7 +2649,8 @@ arm_smmu_find_master_domain(struct arm_smmu_domain *smmu_domain,
 	list_for_each_entry(master_domain, &smmu_domain->devices,
 			    devices_elm) {
 		if (master_domain->master == master &&
-		    master_domain->ssid == ssid)
+		    master_domain->ssid == ssid &&
+		    master_domain->nested_ats_flush == nested_ats_flush)
 			return master_domain;
 	}
 	return NULL;
@@ -2670,13 +2681,18 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain_devices(domain);
 	struct arm_smmu_master_domain *master_domain;
+	bool nested_ats_flush = false;
 	unsigned long flags;
 
 	if (!smmu_domain)
 		return;
 
+	if (domain->type == IOMMU_DOMAIN_NESTED)
+		nested_ats_flush = to_smmu_nested_domain(domain)->enable_ats;
+
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	master_domain = arm_smmu_find_master_domain(smmu_domain, master, ssid);
+	master_domain = arm_smmu_find_master_domain(smmu_domain, master, ssid,
+						    nested_ats_flush);
 	if (master_domain) {
 		list_del(&master_domain->devices_elm);
 		kfree(master_domain);
@@ -2743,6 +2759,9 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 			return -ENOMEM;
 		master_domain->master = master;
 		master_domain->ssid = state->ssid;
+		if (new_domain->type == IOMMU_DOMAIN_NESTED)
+			master_domain->nested_ats_flush =
+				to_smmu_nested_domain(new_domain)->enable_ats;
 
 		/*
 		 * During prepare we want the current smmu_domain and new
-- 
2.43.0


