Return-Path: <linux-kselftest+bounces-36929-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8683DAFF913
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 08:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DB371BC3819
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 06:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFC8294A0D;
	Thu, 10 Jul 2025 06:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e8j/7QUF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC8728F939;
	Thu, 10 Jul 2025 06:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127256; cv=fail; b=kYAk+NsvDzesinbNEOcUibJbG60LSdr1PKq8Qh8BM5wMKviaA4GyrAwbgj8qF1LrA9lVr+tCM2WYcAhYKqfoc8rF5iU1J+sdfkbcsQQzQdZQ8Wgkpr7tqColhlAHPKJg6f/Ko8GZcz7wLSO7+NHTH7DZfzIb/NNtvhcgtkSVluk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127256; c=relaxed/simple;
	bh=f1xgMhEa4g9qRIfS1h2HSR18yXIB/C67rM1WvqgyBiQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pcTwe5W+zz/86K7PxzlyxbKlmn4Xk547gVdhhLH28ZaD4aqaUf/UzCBQqXeKsvRp8ll26EDle/46W1wkNneJ0g151cMrj6XZKgzQeYhvhs9ZAtHfk7ZA5o1r/1ttIG/aWEnuNSJubLh/9oByCtdQbXZVMseXlQF6CEiEd9P5sYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e8j/7QUF; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aWLamO/rrBym9NYddJdUyGvAY0fGwKqMA9RUNEXuvqL/7P2NDU78CUYIVjqzgbimnCoVRJ18lmGVzjy4/JXRpPRGmiNbz+0FhPyU91wnlAN2bO4WR2IcCb/tFs6Skflm6E+NyyDcT5HBtFsMqf+hMkmlf/kbenxQg8qUY3t0fhORH1+TMu5Z6Bj2ELpjQY3AmIPT4CQIef8YdnFRMLV7QZmNyXE389ASwruTDVRkioIT0Ig1aXORgl4Uu21hg+Jop29FBzZ7G5K6nmMbAld+JyhcUtH8OFF6fVgKc/XXO0xW7gdSM1K6Lb9qV10VloGDywZ/sNFJa5sBj1ctuMYI/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQI/ihxYiYZ/4SR7Mz0vueSnSEaxJDwyhkaGrvHqGos=;
 b=Swj7TONwkscxjWL8ojXvjgbvzpEfxIyWFwfbqtkNNqDEHDD6+DZlqg0Kfa5NtEPddtDoX+b7ZGOmwk4z5nOigWuF5au9L25fVx/g5zXH6R8xxJ1KR7HKRGtH3xmpVy+UoeeBt3yLnNWz4CCx5NdENHjPaRPoQlA4HI3vQ0gAktzy5CKEcIQddBKzVp0+kBS2o6JB88B2lTJ3omfMCg9ITENA8pROICVipi5LfSTweBpbiuUukBwNQmuZI2LK8E8WeVc42hMIBDcX/bISPKujw4934kZqNssg8zi+a1czYbThob7Qtwe36h2Ngs+KDOB9877mgWXBWpMsnkGeoCnczw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQI/ihxYiYZ/4SR7Mz0vueSnSEaxJDwyhkaGrvHqGos=;
 b=e8j/7QUFCwCUgKYk2AeE+Hd42nDQgeqjzen1nLKJ9Lj38vx2KYFto42saYOrbGnuMop1Rbdn1PRtumMIdr2vi4aRmU/Rk45tSSBwCm+FViZsrqksETQeHza54XOZ1rp6x7tmCqfVE2ae/vzlv/6IvpMCLdbvZ/nQdAlckO9zTeaoRKj+K9uadNaTVUIBvEgVt6xQ6UUlbttqJcYnuGKRrD7ax0r4NV1UnVLIr0wPK+7jKj4eJWcdC7FIByIunq6cSHSdQnISVC9xSSYr+WnuUUjvhKPTj5JaG8feXmvbAuLtMNruDsbOpQvxsYC7RRYnItSOmEZuISdIp3UvdKn9Rg==
Received: from CH0PR03CA0306.namprd03.prod.outlook.com (2603:10b6:610:118::35)
 by DS2PR12MB9592.namprd12.prod.outlook.com (2603:10b6:8:27c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 06:00:47 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::d) by CH0PR03CA0306.outlook.office365.com
 (2603:10b6:610:118::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 06:00:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 06:00:47 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 23:00:31 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 23:00:30 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 23:00:28 -0700
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
Subject: [PATCH v9 24/29] iommu/arm-smmu-v3-iommufd: Add hw_info to impl_ops
Date: Wed, 9 Jul 2025 22:59:16 -0700
Message-ID: <8a3bf5709358eb21aed2e8434534c30ecf83917c.1752126748.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|DS2PR12MB9592:EE_
X-MS-Office365-Filtering-Correlation-Id: bd6b15fb-6c4c-4ff6-969c-08ddbf771d88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8rMolesbhA+iShjsymiIluqhcJfxPdOw/KYMLzR5FZOhv4LWyrzERmsxQpcj?=
 =?us-ascii?Q?KFJti1WyY6sTaz0cR4Rb9L0S+W18G1Hn5v7TuVPaYvHwxzpond05UU0oqX1V?=
 =?us-ascii?Q?G1dMnLNmxev2JxXDoXRlk2GaIo2oQLr1PoKRRWumdywHU2LdX0KfJSetrmIP?=
 =?us-ascii?Q?ZNujyE3LwRkHw6LgVGezX6OIndoV9PqRqvCNbzNDm1vjO2a8lg2afP7lCENd?=
 =?us-ascii?Q?OyQpUnHbFzlVC+1rvqckniTg++BCyPlkiBpAhz65Ws01pBWT+e1pI98H7tna?=
 =?us-ascii?Q?4GotUNw250IYF3k6xyxJBpirc/nUXoSpHb/PVo3bXMzhYm/cFjk1vyi/FMer?=
 =?us-ascii?Q?72OeqpCPypkx1+uSbreevJ4tCLMr2KiGFHQIC7eygsLALUxUpXTEcjqWAv0z?=
 =?us-ascii?Q?8v20uhmZULLxE0yzUdeDhud91m0PqiOQYu0DAVYjMVzRaJmvzJM5oLIfEKpG?=
 =?us-ascii?Q?6bbCN51DHaChgYHdZ6svTQ+p3EhTOi2ZcrWHOX7g5cZ2Vqvbpb8QFEaiqfSC?=
 =?us-ascii?Q?+B38sPDfO9kH4rhwJWXNEXNesQxFPVb4NIns6/4SBy+Lx4Spzv3vBbZmw/Zz?=
 =?us-ascii?Q?GU06ilkO+vYcNtzMpLcPhKkGYgi37dTcL5hxNIgGUusskXnXQ/tVpgxcQbNb?=
 =?us-ascii?Q?6ZpCyr/UD0A/uBbs6Ae5tR//8fAt1drtJXTDaIfHa38Sp8+7qdsMm18ThVu7?=
 =?us-ascii?Q?f/DI3wQ5D6v7GgITCQFccOdBwXq8ZGUCrkrMZ3D0bZ69fifF79YjwBMSgSIs?=
 =?us-ascii?Q?cpMQeMH73tgoZ9u2oKahjn5BrAmclAMj519D6lWKX6Y9boZVTgDPWMdtXkh9?=
 =?us-ascii?Q?2tEK+G1Cznid0eSjUVeAYPtebGkbPGiGB49EHQvhpVy0CwY7M111l8+6uRTs?=
 =?us-ascii?Q?eqLZiIVHqyQuRG90vuzMm64w4tn48hHpimwlWc83Y3J2HYo1pJiX39RLPTc1?=
 =?us-ascii?Q?JwPjBw7uwdhLEAkr+ZphXxT2fAew5NxflEcWp+SZakMDyvorypctSPNBPwFd?=
 =?us-ascii?Q?DPFP/VpPpA5Q5asaQRqix+TwGgMz+ROUPVgYlNqJ8DOTzfhQleNEGixJ8Ulx?=
 =?us-ascii?Q?Ns4R6HLCkub07SuBLQkMu8BT83jsN25T6bHSxHdEkVlk8s74HxmLyNz/PS1O?=
 =?us-ascii?Q?cn0/soHTY8czbc/ktMNHm+BbmToAgj9WgHIURw0wzbKnf0+PST+sO4mgwq6u?=
 =?us-ascii?Q?A0Qri2mGbRwvtf0ujpmrp7HkkSMhkPCy8fhTNBImcEDUY0wPh2wVwbtcFVA8?=
 =?us-ascii?Q?rfYWqf1QQEkSSYtT8zArgW7XDajtfA3oiS8XuOzYON3W1WnW9C401TgNitLT?=
 =?us-ascii?Q?LpnONz5gWlqvvInxDyg/nFGq5AjFpNr0LpZvueks2lxQWgMdtxyS2GIl0h9S?=
 =?us-ascii?Q?IWQupjvyy67M8c+QTDgxw56ZZ/9/DzmtGZL+13MXAts19HDhB3Oipa62JpVt?=
 =?us-ascii?Q?hm9AldOmAoHyYno9T/bYDTmy7k35YEhl6DWY9ATlEdIRg+MkwERHhOiVg/Uz?=
 =?us-ascii?Q?OAtNBTRo5rrGF4eW0imssVom/RY5GZIuauei?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 06:00:47.2631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6b15fb-6c4c-4ff6-969c-08ddbf771d88
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9592

This will be used by Tegra241 CMDQV implementation to report a non-default
HW info data.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 7 +++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 8 ++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 6183f212539a..b7c7fdef531e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -721,6 +721,13 @@ struct arm_smmu_impl_ops {
 	int (*init_structures)(struct arm_smmu_device *smmu);
 	struct arm_smmu_cmdq *(*get_secondary_cmdq)(
 		struct arm_smmu_device *smmu, struct arm_smmu_cmdq_ent *ent);
+	/*
+	 * An implementation should define its own type other than the default
+	 * IOMMU_HW_INFO_TYPE_ARM_SMMUV3. And it must validate the input @type
+	 * to return its own structure.
+	 */
+	void *(*hw_info)(struct arm_smmu_device *smmu, u32 *length,
+			 enum iommu_hw_info_type *type);
 	const size_t vsmmu_size;
 	const enum iommu_viommu_type vsmmu_type;
 	int (*vsmmu_init)(struct arm_vsmmu *vsmmu,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 2ab1c6cf4aac..1cf9646e776f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -11,13 +11,17 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length,
 		       enum iommu_hw_info_type *type)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	const struct arm_smmu_impl_ops *impl_ops = master->smmu->impl_ops;
 	struct iommu_hw_info_arm_smmuv3 *info;
 	u32 __iomem *base_idr;
 	unsigned int i;
 
 	if (*type != IOMMU_HW_INFO_TYPE_DEFAULT &&
-	    *type != IOMMU_HW_INFO_TYPE_ARM_SMMUV3)
-		return ERR_PTR(-EOPNOTSUPP);
+	    *type != IOMMU_HW_INFO_TYPE_ARM_SMMUV3) {
+		if (!impl_ops || !impl_ops->hw_info)
+			return ERR_PTR(-EOPNOTSUPP);
+		return impl_ops->hw_info(master->smmu, length, type);
+	}
 
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
-- 
2.43.0


