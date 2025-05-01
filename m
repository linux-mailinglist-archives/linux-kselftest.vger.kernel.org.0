Return-Path: <linux-kselftest+bounces-32129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF689AA671E
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 01:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D371BC3419
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 23:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58EA27CCFC;
	Thu,  1 May 2025 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XdaIOkuH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBED727CB07;
	Thu,  1 May 2025 23:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140555; cv=fail; b=cjDPjI/hKNojdQeU95pvhNHpsq393c/kkkW7HWx6UqlLszsBFoeJwTkOplCNiRhmsktpLBruXXqKOw96S/2XstqzhAtDDDl1gJMRaAEaeYEfCDuOGmQmUW5yBKRJbLCCJ83VRM+77mm2GM9lctUsEBPPRalQo94auHmwcInLDXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140555; c=relaxed/simple;
	bh=bWSr2cQmtdnTLysffyG+Z7DKHZtCpGUoZDKbBjxGjVw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k133bzMov2ASHCweUfnlC1AVsyX4OnqcyWKZOa/BbkeivnteiXZmwlSdZBjYyrkQn1kIlAQ+IZ0F2Hioj62/KnqNfpCtymRLniZ77Hh3wv8tfutv/S1mnZL8pAiJ4q7d9pCXVX4b6S3WKqCfNuIIRjUmBfL3WGN/ZoMjjJ1YruM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XdaIOkuH; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fu4WuNjmfRyP9gJvputMm/TDxOEtLVkJsymQwVzFAQ3I8aElbnREOklFSCxGsC6SrCgr8bc3n7sl0GNFHzFmZZTg7/fVIsurQ1PCZJClKT+A040USX/2ebYud+7a1Y3InauPA1+6Ju0P5dNtd7u7ZUVpFN245YbcCUFTtbfiWCdT63/c9XtJyYa3xB64sgtcgdOfcsYEPKfWf6IhZNFgsxuu8xT6UwlRgSTB6KJI0j9KQ84a2B0DQcWAd40MiA7+CO4MSswmaWA2LpKvOCYPgMRn5PHmJUwJ6CtKhR9frxX2B6Ab2195fuKFRLi9q6gh2fjVjwmSiMx86rCy+Pj9Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PDeeySHkei+3c4CjcMqhOzmlcYCWtfY/k9xWAhepJY=;
 b=F3mVcuM9g2OM7aFPrK5q8TDDHlJLIB1Kh1/DOOriNKROqW1RFkcRKlPJJYMBdt+SdbLqCJRDRH5O+CZhkq8v8EPL34LGfddY9u1Yh5J8WxybQ1DtqgegFmfSD0KjJhvhIX6H8coWckK5S2YYlk1r+JGvouxs3DCbTp9FFB7fUA8ijonqNuutL8RuwELUR+5xK4DV6oBA7Ld3aMwgKCNIedXjX2TpB7dQWoJ1ZYY88eLkYSPG44OugV3W2IfIxHqqRDJZej0MHRK6FZizV3qacyAsR1d0KGULNPUjCVRlFTjt9MwHf9QqtXmegFvEELTjurf52aOggxy6MdT4KbRKgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PDeeySHkei+3c4CjcMqhOzmlcYCWtfY/k9xWAhepJY=;
 b=XdaIOkuH4vvYKjzBTLcB21nG+vTDh29kpiye7TB7x6WArtnKCS/N7WKXwzEhNFU7tA9tYh8/pcA0dYr4ogUNPMc0RKUdVqOEdJMK5oxmJkQoCxM7j3md2YW1Bpwf8rtfdQORscvGd56An82MF30owJQW5Nf71kDyxsGFUMJpaxXEY6qLIbxK9FpG0K2IXN/d3zYSECdyLCz74mCdT6LDSH2AxguHFM4ok6zbN3QejS6gT+8UlRuUDNbykFkPHzamE5hnhkxDmDOfEIXd2iO5q7oA8KNpuMY5bOWj0sT4U18oJxu9LpXjoBzL7xCE1GvxLbEWO7FW+cgz/3DC711t/g==
Received: from SA9PR10CA0025.namprd10.prod.outlook.com (2603:10b6:806:a7::30)
 by CH2PR12MB4070.namprd12.prod.outlook.com (2603:10b6:610:ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Thu, 1 May
 2025 23:02:29 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:a7:cafe::f1) by SA9PR10CA0025.outlook.office365.com
 (2603:10b6:806:a7::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Thu,
 1 May 2025 23:02:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Thu, 1 May 2025 23:02:29 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 May 2025
 16:02:18 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 1 May 2025 16:02:18 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 1 May 2025 16:02:15 -0700
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
Subject: [PATCH v3 18/23] iommu/arm-smmu-v3-iommufd: Support implementation-defined hw_info
Date: Thu, 1 May 2025 16:01:24 -0700
Message-ID: <73d0c6790c1b1c6871041745e238fd08c33c4f2a.1746139811.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|CH2PR12MB4070:EE_
X-MS-Office365-Filtering-Correlation-Id: ff27957f-6878-4e99-29ac-08dd89043f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pTDn2yp4BgOzVaBLyqqIJIjkkYKsardUipYbadLEq6ayIbqaybcJoEyaPObC?=
 =?us-ascii?Q?nxnlUstcTJwtt64gMck8Ck4zX/YKLS+xJ2jcSbX1tXAXIcSPvXaJ246DIrMn?=
 =?us-ascii?Q?WMdO+KMtZPTfj8KpkYTrugCPZGQJQWlCmvE6raU3jRimIegdQShrS6c8Q/Oo?=
 =?us-ascii?Q?s8DCwQCErJKnTsBGqxxTPTyts+1ZZUBQyUZtPd7yWn4syqHJ919lsGX6JY4f?=
 =?us-ascii?Q?86YInlCCefCXEUqlERNJVAfpb+lhItmE0c0g1td/kka1H2r1b1/RAZPbAb3q?=
 =?us-ascii?Q?eLJ99Y/wscbUj6B3/5e3ILUa34hP2Bedm+mEBlTvedsT4+qtJCq3dTJYcgcD?=
 =?us-ascii?Q?VcKPzjrGv6/jmxmQYOg01tR2lI/NKisDGQlLcMTDkAM9hckOJ6tcTTbZLoj+?=
 =?us-ascii?Q?1cFopJQQCoWbxF2+p72OHMGNRZlJ16gbL/PeiR1/0/06At9llQ7uAqRZaGp0?=
 =?us-ascii?Q?ajkCICpXorj1G3xPWsAMoQo8CTC2Q8S5nI/goX+DEYqlwsPqYcrydPqRl32n?=
 =?us-ascii?Q?27wRruhruWcMQoixEgV4D78tHO25qrgG2Ney3WeKYM1OgQF60tizZk4yffMf?=
 =?us-ascii?Q?3Hw3R/a0dqPnJj7CYnFvJqpc0yQXAIsNRsj5ZwluoUuIrINNMVZnChDysx7Z?=
 =?us-ascii?Q?9/5SoTl/PxQgnOsIHKEfyW/jgMmnHdBrnPz38s/nVRdI0i/fwdnJem9B51BZ?=
 =?us-ascii?Q?82rPh/vEMU4Chgqya+3iuZ1TBU2yiNLrlzPCeAf59tvkRqmMthLvKMnHaa8I?=
 =?us-ascii?Q?xGCCgdTq8F+SxdJVomlRaA68fi5MKaiujbA5gN/7SB/QD3DYVCSM1rdNdYEF?=
 =?us-ascii?Q?YeVaauXxooCMAjrkGgGsPgmQjhx2ddi1z2GMKguHMN9oRuTfWfAiiVwEd9cF?=
 =?us-ascii?Q?2KJXD5uu2ufoLJmPdU5CsDN3hWq1n2whtQ6N2AABL9K/iIq1w08ypEYgo+GP?=
 =?us-ascii?Q?SFcSew46j/IcON4/nZb8Ned975V/a17kEOk/YeuWG/yfBoxEL00+/uuL20Eq?=
 =?us-ascii?Q?xbSAiyuIxpKVRKgpPke8U3Nba1FxasshXTgP4BU7JnI2wn7f4cPFVnZUm7Q6?=
 =?us-ascii?Q?SBBAPnZS/Vpz+ImKEASoIVmQufwq7pMEu3wnfOULBG/bLbCjLgi//t9UE1Is?=
 =?us-ascii?Q?Kvj208Drv0cSpHoYmJw6Jf+JLxrecD6bzaENe7t5ADmbJXihZ/FpCz2Ircr9?=
 =?us-ascii?Q?eRqs+N9laatHZ9uK8nToVFLeCvKXcz9yOTwcojhBMBYSW8gxM83DP35aWTZv?=
 =?us-ascii?Q?HIeoqs0pXgi0MdGT66kNDPhIUXnCGWYZ7vWP2QhfbGYSaJxp8HE9KQUirAQx?=
 =?us-ascii?Q?Cjjk2KCUHlqkuibeI0fc7KVTKUiBgIeEVpqYTy6BJWFvCTHZ3bgHgkO9tNtz?=
 =?us-ascii?Q?Wgv/epUp+IpT8jm+bhLt28d/ywUjvOyCvke+lPK541BXwVqnPKCyUbwCUaQ2?=
 =?us-ascii?Q?ZAufrRnaOblft6pRU5REb+DzSARHon0gcaHsCt2TCQtysEmiATEt8iK8Uw0Q?=
 =?us-ascii?Q?qNANr0fmnhKNO89bymgpi2/m+XRdN6fHLSVs?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 23:02:29.2330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff27957f-6878-4e99-29ac-08dd89043f6f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070

Repurpose the @__reserved field in the struct iommu_hw_info_arm_smmuv3,
to an HW implementation-defined field @impl.

This will be used by Tegra241 CMDQV implementation on top of a standard
ARM SMMUv3 IOMMU. The @impl will be only valid if @flags is set with an
implementation-defined flag.

Thus in the driver-level, add an hw_info impl op that will return such
a flag and fill the impl field.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h      |  1 +
 include/uapi/linux/iommufd.h                     |  4 ++--
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c  | 16 +++++++++++++---
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index a5835af72417..bab7a9ce1283 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -726,6 +726,7 @@ struct arm_smmu_impl_ops {
 		struct arm_smmu_domain *smmu_domain, struct iommufd_ctx *ictx,
 		unsigned int viommu_type,
 		const struct iommu_user_data *user_data);
+	u32 (*hw_info)(struct arm_smmu_device *smmu, u32 *impl);
 };
 
 /* An SMMUv3 instance */
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index c6742bb00a41..fd9089bfea01 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -554,7 +554,7 @@ struct iommu_hw_info_vtd {
  *                                   (IOMMU_HW_INFO_TYPE_ARM_SMMUV3)
  *
  * @flags: Must be set to 0
- * @__reserved: Must be 0
+ * @impl: Must be 0
  * @idr: Implemented features for ARM SMMU Non-secure programming interface
  * @iidr: Information about the implementation and implementer of ARM SMMU,
  *        and architecture version supported
@@ -585,7 +585,7 @@ struct iommu_hw_info_vtd {
  */
 struct iommu_hw_info_arm_smmuv3 {
 	__u32 flags;
-	__u32 __reserved;
+	__u32 impl;
 	__u32 idr[6];
 	__u32 iidr;
 	__u32 aidr;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index b316d1df043f..f8bf89a80eb6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -10,7 +10,9 @@
 void *arm_smmu_hw_info(struct device *dev, u32 *length, u32 *type)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_device *smmu = master->smmu;
 	struct iommu_hw_info_arm_smmuv3 *info;
+	u32 flags = 0, impl = 0;
 	u32 __iomem *base_idr;
 	unsigned int i;
 
@@ -18,15 +20,23 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length, u32 *type)
 	if (!info)
 		return ERR_PTR(-ENOMEM);
 
-	base_idr = master->smmu->base + ARM_SMMU_IDR0;
+	base_idr = smmu->base + ARM_SMMU_IDR0;
 	for (i = 0; i <= 5; i++)
 		info->idr[i] = readl_relaxed(base_idr + i);
-	info->iidr = readl_relaxed(master->smmu->base + ARM_SMMU_IIDR);
-	info->aidr = readl_relaxed(master->smmu->base + ARM_SMMU_AIDR);
+	info->iidr = readl_relaxed(smmu->base + ARM_SMMU_IIDR);
+	info->aidr = readl_relaxed(smmu->base + ARM_SMMU_AIDR);
 
 	*length = sizeof(*info);
 	*type = IOMMU_HW_INFO_TYPE_ARM_SMMUV3;
 
+	if (smmu->impl_ops && smmu->impl_ops->hw_info) {
+		flags = smmu->impl_ops->hw_info(smmu, &impl);
+		if (flags) {
+			info->impl = impl;
+			info->flags |= flags;
+		}
+	}
+
 	return info;
 }
 
-- 
2.43.0


