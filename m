Return-Path: <linux-kselftest+bounces-32716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB13AB0872
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 05:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7909C521F72
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 03:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5A724C074;
	Fri,  9 May 2025 03:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ujhDSZV/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419BE24BBFB;
	Fri,  9 May 2025 03:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746759837; cv=fail; b=I5Jxq0gs2cpiEPehZ2NNZLo+KPgAhetELariNCK/4sdDL2VEwxkI/VnjnwvhV6yKaJ3jYHPqWFDt9yUvf80n+WP1an7sxqi0E5ag7eZQnyYBOcwV0C0/O6VeRGQgeOyNBRSOTN63/ziwEM5KKUok/hEuwcJ37bII7jYN+GNOMls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746759837; c=relaxed/simple;
	bh=KyE3fJc3VovfNHHiwiXK6GYimyyWmRLuuk44J8AkCJA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FkyCDDcnUxYgaS85MNCSz/TqYeymisIxKYeHdpngUzwuMnMBRC1EWQ2gygF/ALyfi4Vuk0EBP+f0QKAohgn3vF3yCzxULZMdVS6QJYk5KOH98yOFHmljmx7Q46UurFHVg/6Z8LbEGIiW4iAgJUThbI/UDzAyawq9TpkYb5eZMKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ujhDSZV/; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=asf8GKyVNHhRlYHIGzPsQDE9DI6cscE48pw4hVObTpqgYDZ5Tl5FJ7eb9FRjVQcvkFWxNmMCq1Go5g/ATleLwPbJO/BILwffXP8wP9mceGIVDhRquw5xaalVzKa/tf0XIIvYcMhCZePkeAbqrEMBWo/T83qLnUlTisz+WmDYNXyx7PcYCF9mqSIxKfPRcrNDAWTOum0KWyXn/NDDPjQ+JH+qBdsWKS8gkHtZDJKDlrFGTM6+U6J1JhSnDLZ6F3OELSexpdhRAUVnkPKFjCjatYnIZfnrZrhdQPCa2g8lQKaF3Ee019nUuw7phQ0i4sVmmPuFSs4n8NBYB68bQr6gKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jADjGRJju5t1Tl9BHdn76r56E06I5Anu4QVJl9M8064=;
 b=CbtpppHkp87+IMzMpL0JHPmHeDYOQTbH1w+h633xKHZKP0KHFhj8EULPnGlMAfQfgyXubkHSx3ygrcAJKgGf8KN7QileuLxmHYzCuHLZlNI3S+w/rkE+aMVFgYL7/VV6cHHcoW3LNTiY961nN1iCV5pf4iyZlNA1ZulS9oPyF2RogZzOCqTBcieUHNo6s3LanHTAEv/kH7bZUngWc1cSuLKRe6AZg4dXYYvahRn0CIcTjbe3lzwlnOHpDmicsR3emt09a0JOjQfdgi+hBh7P+hN7tj6Cp5iUHvI3/0NXj6+0GD3k1EyQVaMbjMpF4Ems3FeVGmKgovtpEtwuDT4EKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jADjGRJju5t1Tl9BHdn76r56E06I5Anu4QVJl9M8064=;
 b=ujhDSZV/oaaRM/yYU/PjWA5opEHZ+hrSVaLJTUUEYm+pErnWVduoxUM0NfwS8WzlA0EIGfRRhW7VU+i24nkZCA+sr8tP2JyI7neh+HAxLAIL1Ym2eZKrsSglataJoA9sNi2cflWq3rjHfRHNC77rU0Z8vuhJlleDvwsg0+tmpRCyjDI1GvbqwZGM1pOI5+db3JIkN2/s3yqEuTd/hfu85hi8Cul3sp3sJfNThQEhDdzQHAkl+cmIJWjs3RM1/VOWxCAstskdjfTON/TMdZCbJ0kSqqK+vh791qRiZbiC8Rh/EQbYaFebMlq6r+31PtBiq0mhqbz5ArO4Kkz4sHtzng==
Received: from BYAPR08CA0061.namprd08.prod.outlook.com (2603:10b6:a03:117::38)
 by IA0PR12MB8422.namprd12.prod.outlook.com (2603:10b6:208:3de::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 03:03:50 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::97) by BYAPR08CA0061.outlook.office365.com
 (2603:10b6:a03:117::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.23 via Frontend Transport; Fri,
 9 May 2025 03:03:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 03:03:49 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 May 2025
 20:03:40 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 20:03:40 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 8 May 2025 20:03:37 -0700
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
Subject: [PATCH v4 18/23] iommu/arm-smmu-v3-iommufd: Support implementation-defined hw_info
Date: Thu, 8 May 2025 20:02:39 -0700
Message-ID: <f70cdcc21df7cf07ae1da02aba8a5aa932718a25.1746757630.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746757630.git.nicolinc@nvidia.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|IA0PR12MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: 54fed90b-a10a-41f3-6b72-08dd8ea61f3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9qssmmD/13WjxIU7Ld0/rvOEVEALkr9fUlojmP9JBVqeBBk/ACn4QjKV+37y?=
 =?us-ascii?Q?J4Q3zVyCLwkLxbMtoVH68ZiSAz8quT5FYB9PZdk6Y79/Llrm76DIK4mcLZbI?=
 =?us-ascii?Q?j7Gh/NYuO4buqIS7O9F57oVCVbCb2aFnPjoyOfDD/7rTnhvTSChSORVMivrr?=
 =?us-ascii?Q?Y6b7Nht4SavxW0QKtO8ONvDD68ctKPLrFVo69awPD/pAQmFRuBXroxmTcQ4O?=
 =?us-ascii?Q?DG3e6PGyCujwBeJI6QsNKv4j8ShCBkcwyt3KwLES+tOqcCnq1bNQgK8gl7VB?=
 =?us-ascii?Q?fI/boCKQGWNKCqTx0TfF4NlodOjIePTTnABRQKDZEGZQzJEb0S+4AwtWA8TX?=
 =?us-ascii?Q?1XdVIDAR646tQTga6gSFnZMDy4ZBorb176mg7qZQ4s+Kn/Lx7xeVnisxkNaR?=
 =?us-ascii?Q?syNmuRRN4UOia1BOFiWRUTtom/5rMu9/wEHT1YlMj8W6AQED41dSj6isrdBn?=
 =?us-ascii?Q?BJJLYdeygnrFi0uxSqHFgFi3GnMflBVD30I36qsNGVj8QbjOmwORnDdzWZ9g?=
 =?us-ascii?Q?vix3qhcWBjT/FYlLGpCAJHbEBIK69FmFBiWHuhPBLwmqngmY1Hepm44WoWM3?=
 =?us-ascii?Q?45yMi/v0qk2Mv/bYAUD/lEDmIRV/vW80oBh7d4dGFVw6AKITk69LZsZEwXxK?=
 =?us-ascii?Q?GhRXRGBWLJJMXneFPo0B/8KBurhH3eW+b3Lzq9jVIparRcTX2voU2rOeX9i1?=
 =?us-ascii?Q?1CkBKBu+KJ0hkAwJlIcBhY300BoFGV9oF+V0zHG1D4S2HMK5lsjP7F//4Olf?=
 =?us-ascii?Q?UjrJ45qLCBxfd7XF9yJX+hrVwTqMzDSl/2yHFpMiGhPaevziYpLtJm1ZdVBG?=
 =?us-ascii?Q?5dMO0PvRbCrBZStBSx171MDzg3xQa3Ub0QqV7KFOK/D41MNWUF7oeJ2uBTO+?=
 =?us-ascii?Q?+MNMIDcoFLDiVFCc28ZtMjO2ySGWb/mh2q8EljQY9pK6Ohm1S2g6fXpLD7so?=
 =?us-ascii?Q?mJawaEump5wxQFw6+dRSqEdCc0qANojvIIjarrxGOFAubSDcENfVoKFBKKna?=
 =?us-ascii?Q?2D7S53ZVcAHcUe5g8HZvN0v3Dxuf9TuKzaJPtK4ojvGd+lpDepKCHzrndz1/?=
 =?us-ascii?Q?QiaExjpet5t3aWwPLP4fmjtoZ+qs8QyvccP2wx+1XbDtu7hIyOYLnKJiZMEq?=
 =?us-ascii?Q?yIBHarynRvclJKx/P5UOT5k0oWTk5/AljgdV/P2bHaw7A0D7sdt6NVwOws+h?=
 =?us-ascii?Q?DCY+aU63uap5f+5EZDMDMQb7ScLufaJF29GDIMmnOCBiu85vqFiafULcFr3c?=
 =?us-ascii?Q?ooGMpZM135oRk3AHkKsrcDNdyShmfwDkh3HdI47cbCEaunXXo3n3MB7Za23h?=
 =?us-ascii?Q?51gygan8CrgbbIK5uOkUSyS6kjo/YXMRGPDj7OrKxoVMsqjjR1D32xJYURkh?=
 =?us-ascii?Q?yiiIHq73UVFRMttyzbqs/eqZaVSfnIH2JCaX6DRXsm1RJ7IqCggpVXFBqT65?=
 =?us-ascii?Q?i2OmVr1ZQzyaK7Ua698MblCCKUghTh5L3Kr88Mvj/oXdIHGQDo7X9YscGIjF?=
 =?us-ascii?Q?17zUYIbDQopHWLzSYPhwgdv/Sdr2aktNAaHV?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 03:03:49.5154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54fed90b-a10a-41f3-6b72-08dd8ea61f3f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8422

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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     |  1 +
 include/uapi/linux/iommufd.h                    |  4 ++--
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 17 ++++++++++++++---
 3 files changed, 17 insertions(+), 5 deletions(-)

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
index 001e2deb5a2d..28ab42a85268 100644
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
index b316d1df043f..8ea9a022e444 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -10,6 +10,7 @@
 void *arm_smmu_hw_info(struct device *dev, u32 *length, u32 *type)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_device *smmu = master->smmu;
 	struct iommu_hw_info_arm_smmuv3 *info;
 	u32 __iomem *base_idr;
 	unsigned int i;
@@ -18,15 +19,25 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length, u32 *type)
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
+		u32 flags, impl;
+
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


