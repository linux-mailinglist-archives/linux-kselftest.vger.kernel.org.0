Return-Path: <linux-kselftest+bounces-14956-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 720B394B0F1
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 22:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCFB2B20BAE
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 20:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922091465B3;
	Wed,  7 Aug 2024 20:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hoyvg7AI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915FB145B38;
	Wed,  7 Aug 2024 20:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723061494; cv=fail; b=sNbqP4L68rRezDf+n+7f9HdrKOjMPsW7raAWl8yhkeEjUB53d2P7nr+DjF3ne57OfvN0zDLBqOlI+ndyMq/ZX9vKW5npKPFnmS+QXefbhEAUiX6+DCCJFtnOb3dsjxGKUhKKalWP0MgHWPbVxa5CAToZWbX1QNmAtilsLmgR52Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723061494; c=relaxed/simple;
	bh=XCFXe9uG+ouiniGcS2m//Y7QfV7qzCshZlXZNKgVNrI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CNkop9RNdLTgSup6r1jwlqEAPiF391KLL81PDydq8vXd9+8+qbHbUNa+BPvKhlwECKD3RwCbD8aLvrhOEH8YfAP3xt8W6cJgL/TK/cvKsRZmxmRS6IykKzkB4TupWdscLl9sFb5oaXEraIzJ9z9M+GYF4stzPGAsV04nHvDwFdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hoyvg7AI; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOQUbgTQaOs528/2A5Yv7QocgDmKWYb1maIYiPaCNWjvwIVpJeRRgTNq7VaCa7vpq8fUG+6ypXyFBb92Y3x/cCGtTHTmNtUAQlm7/c9DVmGhylaien8Bc8no2y5Bc6+t2rNkRkowUl1sHFHVAGO8jBYEBc3ZZdcl4MfU/vvNVBvksGwDE6pPZVV5P+GXVCLwLNorTp0LhOBVA1BB0i8jvnVmfQYGPRp1sJEMdxPwYTYKcu7csKULy6ebZa3ScfQ2x18S+5K9cW15/VsdiVt4TFxTdKnzm2ErTMt9egiNNZ5oHe0Spc1K/Qgh/IBgMp07b/JOeqWhA+yZW7Q+7uBhbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9858rqDV1CFWhgdnWboF+QA8Bv5pFDo1GqZgaCeVgc=;
 b=xYm/2kji3B59Hc/kI0+Rb1qVAnCWmk8+FCkbjNo6b4lnROq5SRHBhf/c09aE5C4/e1BZe0RbI/auQskkLf5F8QpEFzV/OJ5x3E7h8gU426TSflzO8H3exFm8D5ne0McODz/JUpchLcmTz71NIwTjI/FzntZAchIqbZl5CBzJo5aws+iki+Gg1Wvm0NSJdIF6UL+QEPUcRdgWZrmphZh6+PEyu6zfoLHVnA9pF1ociUg2hv7dwe2yGWAx1QBmS1mrbKJ+NxUCvmWvRUDLlARbcVo7fF489l7hX3tNXy3FDfcDgkfpAqKP82aGcVQflHOdlv0pcYJhgkd2mr+7o4FXQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9858rqDV1CFWhgdnWboF+QA8Bv5pFDo1GqZgaCeVgc=;
 b=hoyvg7AIEIkKOI4ibybwsq2IBzjwXYp3eIfVhXxpuZaPREdDoadMmNa/RC84thWb/21TRjplBjJg1+Vrtb1AAI6Zy/EcrgmORTp6dhlBOGS0e1e7Ub5lRAzCIT4T3oO7r5gAGurn3ts+rz1n9zLF30ACn3i7NZHHtlSU+CD7YZ6DUwMGbA3XdiM61a+EjGWF425rti+8mYooa8O5TNvl6e01Wt9cHNehanGz+7EmG0zfrK5jhuGB22gxPFHvs5UCa7Bq4NPgdWEjnaFbj/OA/vq5jDOCn1WQmnI5aVzvHG4QHE1LDWq3eANU1HWyAf1vRX9rDRsSkjVO6hsWWDmMeg==
Received: from BN6PR17CA0041.namprd17.prod.outlook.com (2603:10b6:405:75::30)
 by SA3PR12MB9130.namprd12.prod.outlook.com (2603:10b6:806:37f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Wed, 7 Aug
 2024 20:11:29 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:405:75:cafe::80) by BN6PR17CA0041.outlook.office365.com
 (2603:10b6:405:75::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13 via Frontend
 Transport; Wed, 7 Aug 2024 20:11:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.2 via Frontend Transport; Wed, 7 Aug 2024 20:11:29 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 13:11:08 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 13:11:08 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 Aug 2024 13:11:07 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 02/16] iommu: Pass in a viommu pointer to domain_alloc_user op
Date: Wed, 7 Aug 2024 13:10:43 -0700
Message-ID: <41602c71a6b865734d34feac46cc596ff9fb7780.1723061378.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723061377.git.nicolinc@nvidia.com>
References: <cover.1723061377.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|SA3PR12MB9130:EE_
X-MS-Office365-Filtering-Correlation-Id: 362532b7-2dac-4a64-b510-08dcb71d1fa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MeWfrshpcbjzseiORYsT/fg8/n70DHBVvN9J9flRCk7pTTi3QsGkv6OOQdl+?=
 =?us-ascii?Q?UcTVWdj4o7F67/MfDuFzjwdhKShibW5odZd0i+RNMcbJW1yLiE6ekLWGD2vT?=
 =?us-ascii?Q?YbGHH5I9H/Se+wvLcz42uh4IKlYo702++iBFhgiGiw1kcK2DX0AT88GU/Xwt?=
 =?us-ascii?Q?k2+rwPZH/z8FYJP+Yfv+IJ0BxW28l7LY0p672eJ27SAXYggLABf4iHVaBEVN?=
 =?us-ascii?Q?1kJeaK4m0yfYMNo4s+b0UKxiZEWBCoTeojDu8BD2ysXf7uGoBRhRKyramYyT?=
 =?us-ascii?Q?uEDJrir2VuU3o9yuqlmHCu1JgkEdk4T+aR+YxzB6diTGxER0N+BGJaTNh++n?=
 =?us-ascii?Q?gJ8kYfL84xcRzqpjg+Dpte2d0Ke66XNaaXwLotzl3+UI/dq2TaTFZ1PCUKFW?=
 =?us-ascii?Q?5hkBEFGhvkY/otxwQfUYyBzXPCocyqGrwXxFeyFY2Es7dj0pk3z3lX/YvIr0?=
 =?us-ascii?Q?j1FTM8nRWVtXAhiSqNTAJh0lACgqiaH/9tgq3toGpWm4CGHb/r1Y6rWjOyQW?=
 =?us-ascii?Q?V8BJ6RKjnCZ4ZsTRugx8Oved54RW7qMK4Y0Pnepyfqcrz2Rim+f0DE9qSo8+?=
 =?us-ascii?Q?/fs0uq5CJdYNBYaFxzIbIarFcolMeMMERJk2pJT/giONwZDcX4fTEw830ftL?=
 =?us-ascii?Q?/DQiJClew5jEyoGnr89D/aDBJOd+0aOM9c+9wgKiGMEB5g3LlkXcsj1cmxpk?=
 =?us-ascii?Q?3u1ZhgZOdJqbZxknUcYK6afJTY+UrUi4LwMBM78KCqkTSP9JfqKzvmR+zplb?=
 =?us-ascii?Q?/M+oVqHZFq5jYJj9pLkpv+luDmnThWKcqzOGGY+Ovo7MZ5m18ZgaJxp8SHg5?=
 =?us-ascii?Q?W0Ngo8b5lt5sXTUPGozPsP6IMDmfczLMriEajFHz5RrvL12+BwcT6eS96lgb?=
 =?us-ascii?Q?JuUyhQVOXNoQu8fQZKDQdx4vHRpqPNyYN167PmCTxKR4190lU+7uWgU9jjeL?=
 =?us-ascii?Q?MeWvjVTYYXEPL5RpbMD3vsIydydKufkU5iRtgk6JuTQKd8vOw3wIa+uUXEXo?=
 =?us-ascii?Q?Q7ooK1hsKwx5JeZt3MqqUkxtNcsxxF9VffQ5u+HcafOssGKwcBggytjoI6QL?=
 =?us-ascii?Q?tOwyMRNf6eM+hdbtYJA4IFd7bwdwe7hiSQm/9eyQek1/eg6E72bWOau7Iu8u?=
 =?us-ascii?Q?QjY96D/pe1usOfeb9grQ+Z5VCsu9ahK47Vq+NwS/AJLaTVwdzgXzuE/2hdP0?=
 =?us-ascii?Q?hZK0CYg2i2q4AGQO72deaxbcaMK5jB5D0/DfpVUEbxDhb2XISJf/TEW803IR?=
 =?us-ascii?Q?Bj4o93sq2+3ZoKh/760i/iZSDsZixu081ppSgeF8QgNDeGFZ58F6VRSLFskS?=
 =?us-ascii?Q?607bk/1K7lraw7/oEVdzKtOUwTQPd6O8YeOiYStpRPzNo/F7gK/54OZX7Ccl?=
 =?us-ascii?Q?aCAwimB1gqaDgEu4xHTR+4kfJQxriCO64QWUnWINECMxj2yZDg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 20:11:29.0821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 362532b7-2dac-4a64-b510-08dcb71d1fa8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9130

With a viommu object wrapping a potentially shareable S2 domain, a nested
domain should be allocated by associating to a viommu instead. Driver can
store this viommu pointer somewhere, so as to later use it calling viommu
helpers for virtual device ID lookup and viommu invalidation.

For drivers without a viommu support, keep the parent domain input, which
should be just viommu->hwpt->common.domain otherwise.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/amd/iommu.c                   | 1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
 drivers/iommu/intel/iommu.c                 | 1 +
 drivers/iommu/iommufd/hw_pagetable.c        | 5 +++--
 drivers/iommu/iommufd/selftest.c            | 1 +
 include/linux/iommu.h                       | 2 ++
 6 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b19e8c0f48fa..e31f7a5fc650 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2432,6 +2432,7 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned int type)
 static struct iommu_domain *
 amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
 			    struct iommu_domain *parent,
+			    struct iommufd_viommu *viommu,
 			    const struct iommu_user_data *user_data)
 
 {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3962d5a55519..558cf3bb24e0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3403,6 +3403,7 @@ arm_smmu_domain_alloc_nesting(struct device *dev, u32 flags,
 static struct iommu_domain *
 arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
 			   struct iommu_domain *parent,
+			   struct iommufd_viommu *viommu,
 			   const struct iommu_user_data *user_data)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9ff8b83c19a3..0590528799d8 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3703,6 +3703,7 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 static struct iommu_domain *
 intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 			      struct iommu_domain *parent,
+			      struct iommufd_viommu *viommu,
 			      const struct iommu_user_data *user_data)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index aefde4443671..c21bb59c4022 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -137,7 +137,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 
 	if (ops->domain_alloc_user) {
 		hwpt->domain = ops->domain_alloc_user(idev->dev, flags, NULL,
-						      user_data);
+						      NULL, user_data);
 		if (IS_ERR(hwpt->domain)) {
 			rc = PTR_ERR(hwpt->domain);
 			hwpt->domain = NULL;
@@ -239,7 +239,8 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 
 	hwpt->domain = ops->domain_alloc_user(idev->dev,
 					      flags & ~IOMMU_HWPT_FAULT_ID_VALID,
-					      parent->common.domain, user_data);
+					      parent->common.domain,
+					      NULL, user_data);
 	if (IS_ERR(hwpt->domain)) {
 		rc = PTR_ERR(hwpt->domain);
 		hwpt->domain = NULL;
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 642ae135ada9..a165b162c88f 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -320,6 +320,7 @@ __mock_domain_alloc_nested(struct mock_iommu_domain *mock_parent,
 static struct iommu_domain *
 mock_domain_alloc_user(struct device *dev, u32 flags,
 		       struct iommu_domain *parent,
+		       struct iommufd_viommu *viommu,
 		       const struct iommu_user_data *user_data)
 {
 	struct mock_iommu_domain *mock_parent;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 20a40fd6c4ba..0b71b2b24ede 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -42,6 +42,7 @@ struct notifier_block;
 struct iommu_sva;
 struct iommu_dma_cookie;
 struct iommu_fault_param;
+struct iommufd_viommu;
 
 #define IOMMU_FAULT_PERM_READ	(1 << 0) /* read */
 #define IOMMU_FAULT_PERM_WRITE	(1 << 1) /* write */
@@ -611,6 +612,7 @@ struct iommu_ops {
 	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
 	struct iommu_domain *(*domain_alloc_user)(
 		struct device *dev, u32 flags, struct iommu_domain *parent,
+		struct iommufd_viommu *viommu,
 		const struct iommu_user_data *user_data);
 	struct iommu_domain *(*domain_alloc_paging)(struct device *dev);
 	struct iommu_domain *(*domain_alloc_sva)(struct device *dev,
-- 
2.43.0


