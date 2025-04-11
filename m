Return-Path: <linux-kselftest+bounces-30503-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAA0A85439
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 08:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2BD57A88D1
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 06:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616AE27D781;
	Fri, 11 Apr 2025 06:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LsZfSH32"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8341327CCFA;
	Fri, 11 Apr 2025 06:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744353502; cv=fail; b=juz/C+jVgULCTBtl13hr+NKJ5gkZY8CxgUeWkWmQIixD3y7nmQRJ/KJRKO1u+fCbSJ64DaPkYnMAXy1Q7+/T9ag4Xsi9eit9ViRi9eWkqVsUxkUoJhJwsacBp7QmB1vrfsQAg5mXcVO90EQY9Vmd8l+bNVQhvjJGf9HLVSgRqBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744353502; c=relaxed/simple;
	bh=y9XZ5NbYttRYsiioE4owjFLvfy7kC2A5koTcGaDRG90=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TEIDnpH87Q/qbaZXKfBM+mQerffQqHDqOcJdSiv96P5BzfbKkFKvRFX7Ay2b8aAOEG+8E/HULVq+ZWZU1SP7zCNDDY8j0VH/kmmFBqnh6E3DTd6fPUnKeC/LWXEizBMZ6wqD7jbeWlKIK82C2ZPrgT8kOqbw7t41O9MYPJi2pX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LsZfSH32; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3b2/H1Q4Re1Op5MSf1YzGZrQIN81t7Bm4a3CCUDzpeTp15ToKHrNZt+OTW6rOSMOkKjIWXSCL2Zzlxa4M4f7DyBIM7w3IGFIb4gajAqEr34uiAlwuBfvQ/WvJLrwDWLwAAddxYk+QLXEuT/X7o9TMmDOqxibspoSSpkT/3WLyTwxtS3cyhAlaU/C4YdM6B6swn0GdK0FWNSCjEVinXmnRBLB+ulU38Y5PlueHKgc/TWK8vgOz1NUM3VXoWHX5DNACE6KFDlyCbY/mDHY3/IAfwGXvJb/i9oTPLLvCbpY5TV/7gi0gMs3aUQEBCgOj5TVWGb2bFT4XxNIRcXaFaaOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcAgOgX7VVXuUEWNKXjRw6fvcPV106wHDSGblFgdF4A=;
 b=X8tjmArOZMQJ7wemZ9Jow1zanzMbjrwRU1cERu7gUKITUj2wy3Auj4faYEeZROtfntEQX2B/rDvwJqnRPLfrdDCDoaIbkalyzXY0eTVK7dsiveyt5ExXSjsBEXIbz7uzQw6dglqP7asCOcGzUqkY4xF7/wXElYnvdlyhXKazN17y+k3eFLHVWqut/S9nEoVy8QkDOXSjujJtewK3SxDJ1fzAJmLRulrnF+YbsL9bHiv46HzccogVAbljJD5oNA6NK/j4fMJrZoimL3maYnxD7EWuPKmjQt9fMIN611/aJfd6sGrPtGoaQpPJ8xjGWfpP8PjeJKEoFpmNvXCTotZQzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcAgOgX7VVXuUEWNKXjRw6fvcPV106wHDSGblFgdF4A=;
 b=LsZfSH326Jz5UXBa7xKP5HySHl/TRz76tK1v7N5EJl0dTDR5Pnlc1wk5Wbrd7Xh+ajlPPevyQI5ZlnItsyH7mDZQ5yCTuwhx0wxIq5p8oOqIfZYJgU4Rt2TdkU2zB9E7W/JiFMwvnmO3Q/DHBWAwl+LfU5Ykl97tNwJNAMofwhn2MU4i0Rvxyvu4LPRLRg7gyjaobb3uvm3Fx25DS5dH6ssZIYLB4Kr1lOvMcUbHRR5wD8ingvsxcXSHE7plkqRzgnGBz6Lr6ch9cxHe9WgHFrpJHqVt6er9ROndIoMiSe77W3zC5Kq+p34asjNRn3Liof7aPBQBo2vy3mMtcJhUeg==
Received: from SJ0PR03CA0050.namprd03.prod.outlook.com (2603:10b6:a03:33e::25)
 by PH8PR12MB8431.namprd12.prod.outlook.com (2603:10b6:510:25a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Fri, 11 Apr
 2025 06:38:15 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::ee) by SJ0PR03CA0050.outlook.office365.com
 (2603:10b6:a03:33e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.36 via Frontend Transport; Fri,
 11 Apr 2025 06:38:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Fri, 11 Apr 2025 06:38:15 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Apr
 2025 23:38:07 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 10 Apr
 2025 23:38:07 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Apr 2025 23:38:05 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <shuah@kernel.org>,
	<praan@google.com>, <nathan@kernel.org>, <peterz@infradead.org>,
	<yi.l.liu@intel.com>, <jsnitsel@redhat.com>, <mshavit@google.com>,
	<zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>
Subject: [PATCH v1 01/16] iommu: Pass in a driver-level user data structure to viommu_alloc op
Date: Thu, 10 Apr 2025 23:37:40 -0700
Message-ID: <4613641ff3f67b73eaf1074d5bf9b066014a7813.1744353300.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744353300.git.nicolinc@nvidia.com>
References: <cover.1744353300.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|PH8PR12MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: d8306fe1-64ac-4a6a-b889-08dd78c37040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pI0O/cX1zT1vP13G072nrI8RPwzlCK0JPzyo5WheH8qYCh4P4pl41dxI8muh?=
 =?us-ascii?Q?Q+BivX6z+gg4iJe/u2DHGbjqvyDtfkx4tFmbW8Egn8jD8gIYBnvvsAsdXi1S?=
 =?us-ascii?Q?VYbZ+F8aD/XE7CWYTw3er9o3pTzFewBGwuCnKLIklVN9A3elttOBYpmXEYTi?=
 =?us-ascii?Q?U115BdC9j2o2bhdm0aBwepnAJsXPAy02sFPB3HN00108vNbWnBLtsreoZG1Y?=
 =?us-ascii?Q?rbbuCql1vldLfbBTKZxOI5H6F6NBU3LJuen+ZKRX+qepcA4fIO7PpquMePdV?=
 =?us-ascii?Q?+umQTxpDd2zj2MS/1CElx/tkGABdrikwpLCvsxLu15jbnAMjN/9bOKV6qxpg?=
 =?us-ascii?Q?lbSyj8pxtpCo3Lv47DSdjeDDE8UE4H3qVPS4Iz6FhUZyKX6ipwb8omGA1iku?=
 =?us-ascii?Q?5lSwGxgymowIMrmWbu2sHeBcoRjUTHINGJoNA9zpR5gHAu0QrdMzhk909hqN?=
 =?us-ascii?Q?Qu+JReRHUseAOvPrCkVPMUmJ/JvhowpDKeFNkodVHjQhu65NNrKyaxM0nGXb?=
 =?us-ascii?Q?EB/dcs2E7O350uwzyNkAtkliBIzjvR50SoJachaEhJ5rW4HyRgXnxuN3t2c5?=
 =?us-ascii?Q?KdQ19AdxgzZcffV5v1hun3Zsrz/pmiCkTaSf5/wBobvOzILKXzzzP3FR8fmg?=
 =?us-ascii?Q?nrZ0s96eyKSmacZuXAfokKyZhJG87VAL4bzzeDWThAGi0KVX0JfULRClgTz8?=
 =?us-ascii?Q?CunScK7jiE3ENdWBuN9OIE6C1P6IBwrcaxEcqxQXqpaYzl+v/5bnTT7u63v3?=
 =?us-ascii?Q?u3GkMj7UWtR1CUiHCYeG2TdnAenA4kVQDPXSLytiHZMzzBmyy2aJmm3PzDaS?=
 =?us-ascii?Q?2K2qgL9aW9AZnEFx27bRoufBHLUtQRWfWkKYVfRkzS60i9wngCfKR8Vpf8WQ?=
 =?us-ascii?Q?8kJgaimWan69Sq0Gj/xUYj5ifhCsu4Rq+LQjrF2ONQt9yghntdYpWnjuvCDz?=
 =?us-ascii?Q?85p8Cgji3MLBiGgN7Nke/6GDFpXMG3qBOoplrTPWKLgAozKz4FMKfCkYFbeX?=
 =?us-ascii?Q?9klvBVFTHphaFJcDXrSE8fuL50f97px5uVzaByS0a30tCQPyvItI4QFtUT2m?=
 =?us-ascii?Q?gwnesfDIHyIhUmSknWYAFeSQQlahSkWUtK3haOLPmMZeXAEr1ZP8QJd0dHIQ?=
 =?us-ascii?Q?CwElfXz1wDmaILcJoBBjvHvav3Xy20W/Qn1NC91NQvvaUt1P2hF8YvzehDwr?=
 =?us-ascii?Q?0bPQUkDpDVypBhwAHmHZy39HuHuNnlhLLjqysHdswaBPtbhV6X8q1JODMofg?=
 =?us-ascii?Q?Zfdhz2p2yx/LQ2Sa7DVKho2MALDrLl+R8hmaz1ze4Qzqp6PNljgRWFFPxl4r?=
 =?us-ascii?Q?Wny34hSN5fZq1VPxZO+4e7s+/rw8VYdol2+S56B5qvIY1mJP6ZTlG0Prs1/R?=
 =?us-ascii?Q?dNGNVhAryTEpZrs8fq3MW3njskvjy63nWRMNeX7pTS5DBvc/0/3yhHZA3XSm?=
 =?us-ascii?Q?2D1hfte5+LNBm5JnqRHEkcBhtTTYT6B8t2Sp7T5M39uhH4B1b/Uv0nKQOr4V?=
 =?us-ascii?Q?gdCggn32wp7ZysCcq+oVTg777cjviVaCOoIJ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 06:38:15.3411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8306fe1-64ac-4a6a-b889-08dd78c37040
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8431

The new type of vIOMMU for tegra241-cmdqv needs to pass in a driver-level
data structure from user space via iommufd, so add a user_data to the op.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 3 ++-
 include/linux/iommu.h                               | 3 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 3 ++-
 drivers/iommu/iommufd/selftest.c                    | 8 ++++----
 drivers/iommu/iommufd/viommu.c                      | 2 +-
 5 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index dd1ad56ce863..6b8f0d20dac3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1062,7 +1062,8 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length, u32 *type);
 struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 				       struct iommu_domain *parent,
 				       struct iommufd_ctx *ictx,
-				       unsigned int viommu_type);
+				       unsigned int viommu_type,
+				       const struct iommu_user_data *user_data);
 int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
 				    struct arm_smmu_nested_domain *nested_domain);
 void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ccce8a751e2a..ebde19aa3c28 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -662,7 +662,8 @@ struct iommu_ops {
 
 	struct iommufd_viommu *(*viommu_alloc)(
 		struct device *dev, struct iommu_domain *parent_domain,
-		struct iommufd_ctx *ictx, unsigned int viommu_type);
+		struct iommufd_ctx *ictx, unsigned int viommu_type,
+		const struct iommu_user_data *user_data);
 
 	const struct iommu_domain_ops *default_domain_ops;
 	unsigned long pgsize_bitmap;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index e4fd8d522af8..66855cae775e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -385,7 +385,8 @@ static const struct iommufd_viommu_ops arm_vsmmu_ops = {
 struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 				       struct iommu_domain *parent,
 				       struct iommufd_ctx *ictx,
-				       unsigned int viommu_type)
+				       unsigned int viommu_type,
+				       const struct iommu_user_data *user_data)
 {
 	struct arm_smmu_device *smmu =
 		iommu_get_iommu_dev(dev, struct arm_smmu_device, iommu);
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 18d9a216eb30..8b8ba4fb91cd 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -733,10 +733,10 @@ static struct iommufd_viommu_ops mock_viommu_ops = {
 	.cache_invalidate = mock_viommu_cache_invalidate,
 };
 
-static struct iommufd_viommu *mock_viommu_alloc(struct device *dev,
-						struct iommu_domain *domain,
-						struct iommufd_ctx *ictx,
-						unsigned int viommu_type)
+static struct iommufd_viommu *
+mock_viommu_alloc(struct device *dev, struct iommu_domain *domain,
+		  struct iommufd_ctx *ictx, unsigned int viommu_type,
+		  const struct iommu_user_data *user_data)
 {
 	struct mock_iommu_device *mock_iommu =
 		iommu_get_iommu_dev(dev, struct mock_iommu_device, iommu_dev);
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 01df2b985f02..b861ca49d723 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -48,7 +48,7 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	}
 
 	viommu = ops->viommu_alloc(idev->dev, hwpt_paging->common.domain,
-				   ucmd->ictx, cmd->type);
+				   ucmd->ictx, cmd->type, NULL);
 	if (IS_ERR(viommu)) {
 		rc = PTR_ERR(viommu);
 		goto out_put_hwpt;
-- 
2.43.0


