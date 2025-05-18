Return-Path: <linux-kselftest+bounces-33259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 083A0ABAD2C
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 05:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44EBB3BCFF8
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 03:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D3F1DE4D8;
	Sun, 18 May 2025 03:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="erzmHDBu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EEA5A79B;
	Sun, 18 May 2025 03:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747538538; cv=fail; b=D165CxgCFdoSeehq+3FuclbdbaiJd4cazwQCFqGnHwLpgfaAMBDXsJOXLKfMcK6Rji1E08VW2kW08TVdpHxHVboiitw+hoBaJYWoGW/MU9R7FS+PxpNibMPWN9949tmKIOIhE8OaNYYLyZ4zxtiYqIZrBG/ztoYTUbb7KTNVTm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747538538; c=relaxed/simple;
	bh=oj2Zh9dqJArS0MZ3e51ms1E60bkIaK3QHOk0kKJGDig=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oG9uoztMVxrkN99E1Ld5aT9yd92oQ634ei93oxqRI+ZcdBHMuJFRhSbdim8YE3s31nSEVUhva+sSbmoxziWg5rmD/p12Z4zWZA1e1NxUXhOFkhBvjpVxlOLvK5x0Dxng3rYSTqWhd79BZxAVhYlcipm7bEwGM0BEEs4XMzdFcBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=erzmHDBu; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLysdzPKuf5+9Zj1lBuX8ZyTtE4GsZxcS1canAABJK4utGPkHrxmgOisW+nyXO56hZ5pqSPKNS4Fg8YPiXnzjSBtbPsLUiqr78I0Tr0AhUCMFqurJsH/h3YFzGbieAMs1BpNIPYAIRez8S8ZnrUVu+xdV+DYvB8Kn9P1eQGUkmvvEt2Hcv/IIn7CwCEW5iMWsRxFq2ACrfNKXcWmt0sXQUR7HHR4utUGvFWXWbvtzH+AuItZlASUrylksiXAqjRqij9SZEEx7yC8G/B9deK4bRYrGqI1kH/C1IlEedc2/R4w3DyyNKah21phRoMWWqRR+cjRF5lYMTsOjxiw73GPFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdPGoimqVL+3/u2b/t7/kmroaRSAteAAcUKobORetUg=;
 b=kTslMVssaFm9DJOq/9TcrNVekQFIa1BMkig873wocOamez1BB/dcMU4c+wD5/nDMXJVO6ltGZu4NM2w1ps1Wo4gNsW8ZsT7L23jbWNwWmawqNifvVUIFgJLWscacXBGjrRVZWwtBwmwfw3Mw9RqtB3XtYflCKzP22aXi/4GsSoAUetd6c5Mt7AoxAxmBF4bfdMX035g4p90HeB4iLMzIEZQMk8myy916tUM2MeyV3ksmnZJ4wTPPD2B2IZBQIEBmKGsNGLPLT3f5T1HkCpE34PAcG234b/e3h3mlSOPxgkoc9oKIzrASqWyyszqXWA/OicR96RNI/dPcyyBIkVH35g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdPGoimqVL+3/u2b/t7/kmroaRSAteAAcUKobORetUg=;
 b=erzmHDBuzC/HaG4kGDw0RI7bZQUzm/3u52V/+wKL6JHfSzRaAo2KJKqNV+IU6dL93/8HRZT9VKljqW6FeRGR3c5iwHV+frsl2f+G83E1r2nGI7u3lBituTRRmIcaBapFhTn6yd1lZy5VRsC3pJXhqNtHi7867B7ouagGnoqWMcneoysJcfyB8Q29ZZlYLORALPhyOLSz/R+yIReBFLMKRQR9wnPFW8kmSiiJJQGy1idlAQ1KPUoG17OCKkvUR2XXfAJaKFc4rnuMaQFp9uCnWRGCbHP7JRW++v41iA4u9C4pwLgmqsuJJmWDq9RKu5YIgWe13lM+cABsibFnsX41BQ==
Received: from SA9PR10CA0010.namprd10.prod.outlook.com (2603:10b6:806:a7::15)
 by PH7PR12MB7938.namprd12.prod.outlook.com (2603:10b6:510:276::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Sun, 18 May
 2025 03:22:10 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:a7:cafe::1f) by SA9PR10CA0010.outlook.office365.com
 (2603:10b6:806:a7::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.24 via Frontend Transport; Sun,
 18 May 2025 03:22:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Sun, 18 May 2025 03:22:10 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 17 May
 2025 20:22:00 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 17 May
 2025 20:22:00 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 17 May 2025 20:21:58 -0700
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
Subject: [PATCH v5 03/29] iommu: Apply the new iommufd_object_alloc_ucmd helper
Date: Sat, 17 May 2025 20:21:20 -0700
Message-ID: <c01f145f9fd9a803a3154c3e7221dd76b4f8adfd.1747537752.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747537752.git.nicolinc@nvidia.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|PH7PR12MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: a2ed19d0-2de9-4bba-d336-08dd95bb2d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oEsdEjFrES48PSN1wPv9vUuSd3GmydUtAd4TTVWNxMaQMtYDN+IRb3fGoVvd?=
 =?us-ascii?Q?qbZ+gZORMtPkoFD9ut8CFbUf/ZV/zcAdFQnPvtPfMfieYislZKJeTaRKw08I?=
 =?us-ascii?Q?9jQyPWi/aZJUn4QzmFlRsp3g+PEHrCmwoLTXeyQSKZFPqsggMyiQTVte8X68?=
 =?us-ascii?Q?4Z+ly8+78oDezr5maiKlyWiha6wMD6kgoxXCYoTpAA0T+ZyM05ZC6GAI8YVK?=
 =?us-ascii?Q?/IgjQqdMj3hXNHLnUq80VGOcUX/INgVwUGpC+2gQBHFDmz6B07QMHsHIdACk?=
 =?us-ascii?Q?Of2vU3erDsCd/3q18WsS3PDE0GIJjaUs35sWh9EzrNmjGs1sddBy0t1XSnNJ?=
 =?us-ascii?Q?lzIVA+UWIQpIwZ2djxlqHZlfksBaVBH1uchWRqBeZ2wMGBxmcXVdrnpV8HmO?=
 =?us-ascii?Q?IAVz1qLY4ewmpQd/4uzn88ctigWOZAtOeLyf5tzu8QPL7FWgZ4GmkSuWcEvD?=
 =?us-ascii?Q?JYvADZnE5xSl5kkJw1SvotfbpDNCOcmDmE4WdckSSBjZMFLp7RQkbBIoUtO2?=
 =?us-ascii?Q?pEbNWIR+f5i9jnow8kXr+tU55xswv6Y2jqut5NMSNC2LDbm4Nkn5Uc57fv6p?=
 =?us-ascii?Q?h7/8SDNgDxZiVejO3pRjJFhykqWPp7ngOPScigCLqxnUHXIGzq0z37+bkLJt?=
 =?us-ascii?Q?ttnqUbtxfAYQrnlqdJh1ATHmOZrW4AsEWivLOQfGHk7ijDLIyibhK3BTBd25?=
 =?us-ascii?Q?gcJP09YeDTQWsnyzzTM7t8eJAeTvbfm476+XgsR5wRmK4RfkPln+Ojzs9iDh?=
 =?us-ascii?Q?toqvoloTAKIEsKdWKuZpwdXgZuql9WOnyv0ihXXUFQgKlvbmRVNDIq/V97wa?=
 =?us-ascii?Q?3RhA7y5QIPU44f+8GEejb1Lv5UeFyXkgGOi11Ka1d4SguW238tGIWfUk83DR?=
 =?us-ascii?Q?5XGXiMCf4Bj8xtH/Ef4YN/7Zn3kD79/PTk/oYMzrz7H6MX83BA+Oj4JMStPR?=
 =?us-ascii?Q?mhYrqOLhuHKkNiait0iD2a6w9dNkls2vG62Oa+627zOTyVqarUJY2LYX2Iqt?=
 =?us-ascii?Q?Kli5CpuLywQn/x3Jupzn+aWzu2CAA2yJ/rMuemLAlBkY2ecjh0aLe0xt+rLd?=
 =?us-ascii?Q?vBrXqV2L/SR4LpGjAZqfyrpelyMonQYEFIxBMg75/mHKQ/CENUG4EehcheCX?=
 =?us-ascii?Q?ktsuXr9Ntx7TmycMkpkblziyqW6vv/ho5fKiQTBGFYUBf3lSvPzpWkCl5sm2?=
 =?us-ascii?Q?R5qWLT9DNcS9X4joKBTPmD1cy3rkwq10okXxQrnD3zyra66mcNjA+xN9Ko7w?=
 =?us-ascii?Q?9Iyjn9J/4zY8opzoNWrcWhXEnwVC6hdZBUGT9bp21+9Tl7DK8nQ2kCZ2kosb?=
 =?us-ascii?Q?4X7iwQPEIc5JMvi0WwSDWzaMUUI3vhNxjwuoJ2dLiQSE3VRWKGNNlHm6zp5X?=
 =?us-ascii?Q?fLwPKSSV0sMQg1wwhERFWVzusGJD9qrkL8NOHmhVhUXF207vu8baA85JSyWe?=
 =?us-ascii?Q?hxxihnUCFmjwXp6GgGrhgx3iTsfQxlnuvukrNZAbzW4xOjXIVyx1lR4J4YDx?=
 =?us-ascii?Q?Ox8cwrS1sqYhBnr4jznFg9lOYGt1D1bWYZAL?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 03:22:10.3482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ed19d0-2de9-4bba-d336-08dd95bb2d20
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7938

Now the new ucmd-based object allocator eases the finalize/abort routine,
apply this to all existing allocators that aren't protected by any lock.

Upgrade the for-driver vIOMMU alloctor too, and pass down to all existing
viommu_alloc op accordingly.

Note that __iommufd_object_alloc_ucmd() builds in some static tests that
cover both static_asserts in the iommufd_viommu_alloc(). Thus drop them.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 +-
 include/linux/iommu.h                         |  6 +++---
 include/linux/iommufd.h                       |  9 +++------
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  4 ++--
 drivers/iommu/iommufd/eventq.c                | 14 ++++---------
 drivers/iommu/iommufd/selftest.c              |  4 ++--
 drivers/iommu/iommufd/viommu.c                | 20 ++++---------------
 7 files changed, 19 insertions(+), 40 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index dd1ad56ce863..4f9aacad0091 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1061,7 +1061,7 @@ struct arm_vsmmu {
 void *arm_smmu_hw_info(struct device *dev, u32 *length, u32 *type);
 struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 				       struct iommu_domain *parent,
-				       struct iommufd_ctx *ictx,
+				       struct iommufd_ucmd *ucmd,
 				       unsigned int viommu_type);
 int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
 				    struct arm_smmu_nested_domain *nested_domain);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 3a8d35d41fda..0db39f922775 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -43,7 +43,7 @@ struct iommu_sva;
 struct iommu_dma_cookie;
 struct iommu_dma_msi_cookie;
 struct iommu_fault_param;
-struct iommufd_ctx;
+struct iommufd_ucmd;
 struct iommufd_viommu;
 struct msi_desc;
 struct msi_msg;
@@ -609,7 +609,7 @@ iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
  *                include/uapi/linux/iommufd.h
  *                It is required to call iommufd_viommu_alloc() helper for
  *                a bundled allocation of the core and the driver structures,
- *                using the given @ictx pointer.
+ *                using the given @ucmd pointer.
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  * @owner: Driver module providing these ops
  * @identity_domain: An always available, always attachable identity
@@ -662,7 +662,7 @@ struct iommu_ops {
 
 	struct iommufd_viommu *(*viommu_alloc)(
 		struct device *dev, struct iommu_domain *parent_domain,
-		struct iommufd_ctx *ictx, unsigned int viommu_type);
+		struct iommufd_ucmd *ucmd, unsigned int viommu_type);
 
 	const struct iommu_domain_ops *default_domain_ops;
 	unsigned long pgsize_bitmap;
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 47f38034f5e7..d74c97feb9b5 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -256,15 +256,12 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
  * Helpers for IOMMU driver to allocate driver structures that will be freed by
  * the iommufd core. The free op will be called prior to freeing the memory.
  */
-#define iommufd_viommu_alloc(ictx, drv_struct, member, viommu_ops)             \
+#define iommufd_viommu_alloc(ucmd, drv_struct, member, viommu_ops)             \
 	({                                                                     \
 		drv_struct *ret;                                               \
 									       \
-		static_assert(__same_type(struct iommufd_viommu,               \
-					  ((drv_struct *)NULL)->member));      \
-		static_assert(offsetof(drv_struct, member.obj) == 0);          \
-		ret = (drv_struct *)_iommufd_object_alloc(                     \
-			ictx, sizeof(drv_struct), IOMMUFD_OBJ_VIOMMU);         \
+		ret = (drv_struct *)__iommufd_object_alloc_ucmd(               \
+			ucmd, ret, IOMMUFD_OBJ_VIOMMU, member.obj);            \
 		if (!IS_ERR(ret))                                              \
 			ret->member.ops = viommu_ops;                          \
 		ret;                                                           \
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index e4fd8d522af8..5d50bd8f4c2c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -384,7 +384,7 @@ static const struct iommufd_viommu_ops arm_vsmmu_ops = {
 
 struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 				       struct iommu_domain *parent,
-				       struct iommufd_ctx *ictx,
+				       struct iommufd_ucmd *ucmd,
 				       unsigned int viommu_type)
 {
 	struct arm_smmu_device *smmu =
@@ -422,7 +422,7 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 	    !(smmu->features & ARM_SMMU_FEAT_S2FWB))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	vsmmu = iommufd_viommu_alloc(ictx, struct arm_vsmmu, core,
+	vsmmu = iommufd_viommu_alloc(ucmd, struct arm_vsmmu, core,
 				     &arm_vsmmu_ops);
 	if (IS_ERR(vsmmu))
 		return ERR_CAST(vsmmu);
diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index f39cf0797347..269b667152b7 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -473,8 +473,8 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 	if (cmd->flags)
 		return -EOPNOTSUPP;
 
-	fault = __iommufd_object_alloc(ucmd->ictx, fault, IOMMUFD_OBJ_FAULT,
-				       common.obj);
+	fault = __iommufd_object_alloc_ucmd(ucmd, fault, IOMMUFD_OBJ_FAULT,
+					    common.obj);
 	if (IS_ERR(fault))
 		return PTR_ERR(fault);
 
@@ -483,10 +483,8 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 
 	fdno = iommufd_eventq_init(&fault->common, "[iommufd-pgfault]",
 				   ucmd->ictx, &iommufd_fault_fops);
-	if (fdno < 0) {
-		rc = fdno;
-		goto out_abort;
-	}
+	if (fdno < 0)
+		return fdno;
 
 	cmd->out_fault_id = fault->common.obj.id;
 	cmd->out_fault_fd = fdno;
@@ -494,7 +492,6 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 	if (rc)
 		goto out_put_fdno;
-	iommufd_object_finalize(ucmd->ictx, &fault->common.obj);
 
 	fd_install(fdno, fault->common.filep);
 
@@ -502,9 +499,6 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 out_put_fdno:
 	put_unused_fd(fdno);
 	fput(fault->common.filep);
-out_abort:
-	iommufd_object_abort_and_destroy(ucmd->ictx, &fault->common.obj);
-
 	return rc;
 }
 
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 8cd98a72767d..4b021dc50758 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -735,7 +735,7 @@ static struct iommufd_viommu_ops mock_viommu_ops = {
 
 static struct iommufd_viommu *mock_viommu_alloc(struct device *dev,
 						struct iommu_domain *domain,
-						struct iommufd_ctx *ictx,
+						struct iommufd_ucmd *ucmd,
 						unsigned int viommu_type)
 {
 	struct mock_iommu_device *mock_iommu =
@@ -745,7 +745,7 @@ static struct iommufd_viommu *mock_viommu_alloc(struct device *dev,
 	if (viommu_type != IOMMU_VIOMMU_TYPE_SELFTEST)
 		return ERR_PTR(-EOPNOTSUPP);
 
-	mock_viommu = iommufd_viommu_alloc(ictx, struct mock_viommu, core,
+	mock_viommu = iommufd_viommu_alloc(ucmd, struct mock_viommu, core,
 					   &mock_viommu_ops);
 	if (IS_ERR(mock_viommu))
 		return ERR_CAST(mock_viommu);
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 01df2b985f02..6d874d6a4c00 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -47,8 +47,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		goto out_put_hwpt;
 	}
 
-	viommu = ops->viommu_alloc(idev->dev, hwpt_paging->common.domain,
-				   ucmd->ictx, cmd->type);
+	viommu = ops->viommu_alloc(idev->dev, hwpt_paging->common.domain, ucmd,
+				   cmd->type);
 	if (IS_ERR(viommu)) {
 		rc = PTR_ERR(viommu);
 		goto out_put_hwpt;
@@ -70,13 +70,7 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 
 	cmd->out_viommu_id = viommu->obj.id;
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
-	if (rc)
-		goto out_abort;
-	iommufd_object_finalize(ucmd->ictx, &viommu->obj);
-	goto out_put_hwpt;
 
-out_abort:
-	iommufd_object_abort_and_destroy(ucmd->ictx, &viommu->obj);
 out_put_hwpt:
 	iommufd_put_object(ucmd->ictx, &hwpt_paging->common.obj);
 out_put_idev:
@@ -124,7 +118,7 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		goto out_put_idev;
 	}
 
-	vdev = iommufd_object_alloc(ucmd->ictx, vdev, IOMMUFD_OBJ_VDEVICE);
+	vdev = iommufd_object_alloc_ucmd(ucmd, vdev, IOMMUFD_OBJ_VDEVICE);
 	if (IS_ERR(vdev)) {
 		rc = PTR_ERR(vdev);
 		goto out_put_idev;
@@ -139,18 +133,12 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	curr = xa_cmpxchg(&viommu->vdevs, virt_id, NULL, vdev, GFP_KERNEL);
 	if (curr) {
 		rc = xa_err(curr) ?: -EEXIST;
-		goto out_abort;
+		goto out_put_idev;
 	}
 
 	cmd->out_vdevice_id = vdev->obj.id;
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
-	if (rc)
-		goto out_abort;
-	iommufd_object_finalize(ucmd->ictx, &vdev->obj);
-	goto out_put_idev;
 
-out_abort:
-	iommufd_object_abort_and_destroy(ucmd->ictx, &vdev->obj);
 out_put_idev:
 	iommufd_put_object(ucmd->ictx, &idev->obj);
 out_put_viommu:
-- 
2.43.0


