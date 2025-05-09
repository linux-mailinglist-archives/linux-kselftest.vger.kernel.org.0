Return-Path: <linux-kselftest+bounces-32714-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AD8AB0867
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 05:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9279E491D
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 03:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC21B248F71;
	Fri,  9 May 2025 03:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RFrnh2HD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4F223E320;
	Fri,  9 May 2025 03:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746759834; cv=fail; b=SdHKtVL5VP080VOCiCQpEYz/2qxrzQQEL+kLa3A5Jw7n15IPKjgbA7YPLvOL0Rsq1STG6gvLbqaEbFysdQWKakj2iKcDZ9TTEp+RAN1mBwQCmgIN1p3zBAknEozV4q08oYzYRYz35nXpLTbYC/rLxbC6ecaD8ZPXgEFSkypNDOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746759834; c=relaxed/simple;
	bh=/gs2kaYBxBcB5VXdwQLiLFviabAYHSn5e6sebsEt1y0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IlH5Juah4IZez2CW0mXAOykK44SR35JHfIPQqWX94jhX4qkgj0NOuxdCNkdXPC52SfdhFPD5RYN3/E1ygyRfpzgdwhjq6S6RZcyD06u9lQvICeO5o4AxFZIVom4ekf5fvofsOaVeTcVDtqE/o42qvL6YbFOVnxAgGCUA1ZPQTLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RFrnh2HD; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZW+9nUeUnx5MF/ezwrlPw9fBc6i01XOwGCJvV/KyaWm1BLI6TEnB5qSS7yYk43V/mQnqgTWz57EwlxBG+s42e6Cd78XZzvsMtfOh5SVQQLAx4VAX3i70LUmToQUJ7J65lBpn7u/o8zkTpk7egIw1WpcwYb5OO9XKOISuCJ7dRawl0b/BLEFXC9OD7Ef4blfd9G/rAjlnCbGHTzZ/1GenE28S2Spnwt57FjIn7+u/QpTlwesYXLio3uteKOUoAzmPUCeseOUswRYIq2E+MBfe1eoN4/X9d7jGQptEiDi9hfiE0VJ7Dnyh1iTrGJMGgSLW/6VLJCoUXXsFh9HSmci6Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+RQR3IJbHeeE1lL3T/6+RO9Y9EMS3q9xEaDtjU2VUs=;
 b=MdkTkjuBzrUUMVSQgU6PR8T/zuT2Xyw+wlPb/P1XtXvT96oPBrdn5ss0kOCRw/i0UGNFwOGAMMxGfX+dqv9xMfRkoGVdOlphkoY0SRKCRgvPOR3TvpXVWLqKgHTeX0iYer2BqeLcth4OaENjzw6Z/xDbcUCo7Z5Urll1PWO3g+A6WC6vjeKRIHQAzbvGHnM3Eyjc2VWNZtY94fHY74WBchvtS8OKV2g1x71H5h09IvP8stlpzqZqr0QtUjjOz42zCv/2Y/RY6fmayvWN7SOiRSFTWbUuC9effKoB60IvXPOZtppYR2t/9j8LAY07cSJe7a9v81bzLQeeNBe72njZNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+RQR3IJbHeeE1lL3T/6+RO9Y9EMS3q9xEaDtjU2VUs=;
 b=RFrnh2HD+CdjZtKmg5W8S6UvUyqIwP5V1j4iySd2fWA98NShG71jxukuyZOTb1UH3c5kudnPLd4J6bZmW4sbdVHtdANUYmiPrp4oeVNadzoojDhFb0Ox/CcKK2lTnkh8X23yOBHeOLbkerwyCWWewCJdsZxZ03z/9KjoRcmCoo7chDgnArP/hBtCRdEfmwndCJGZtmBwOalX748CHds3ufzq1qderaKqJ/ltrnqLIXLw6qfKadeqz0KJtRgR1E+t94gOPDi2MgQzj0CUYx/qPh7O2D46dWjLmNCJkAg89mTMbqYHFtthyUcBFdXxghmLXD5nAbtI3DVsvttAoSb6iQ==
Received: from MN2PR11CA0027.namprd11.prod.outlook.com (2603:10b6:208:23b::32)
 by PH7PR12MB8427.namprd12.prod.outlook.com (2603:10b6:510:242::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Fri, 9 May
 2025 03:03:48 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:208:23b:cafe::6b) by MN2PR11CA0027.outlook.office365.com
 (2603:10b6:208:23b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Fri,
 9 May 2025 03:03:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 03:03:47 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 May 2025
 20:03:38 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 20:03:37 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 8 May 2025 20:03:35 -0700
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
Subject: [PATCH v4 17/23] iommu/arm-smmu-v3-iommufd: Add vsmmu_alloc impl op
Date: Thu, 8 May 2025 20:02:38 -0700
Message-ID: <80465bf197e1920a4c763244fab7577614c34700.1746757630.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|PH7PR12MB8427:EE_
X-MS-Office365-Filtering-Correlation-Id: f9420df9-94a4-499e-899d-08dd8ea61e3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TZO5byV7xLs8gIq6dO4NfRNTVUWFb+XE8/tP7lr0Q9AGncYm42g6YUiAggSr?=
 =?us-ascii?Q?XH9n+WDrys6jRQR37ksuT3BPIjEYCYzgdkwXwJvNyBfH8OCrI+7h1eLTxHYq?=
 =?us-ascii?Q?WYdJ6yP+qJyxr7EkmkEnTqHAsqwIpUrjd5mZcNQ8s87MWemq+H8fGY+2TgRA?=
 =?us-ascii?Q?9IRRplbbmUD4csfZyZuC5VMEsNNK7MZ68ZdKGmmbf/dBMYj+st0ecnogib1P?=
 =?us-ascii?Q?YhcIJGH/HZ1wlEjLWJWCINFD4V3ainVLFLQfcKMiCtkZshXyeTaVr2zN+IPN?=
 =?us-ascii?Q?MBqa7PJiCkU8nvAGbacg5VJ1SvCxjHrrDdMZj14jgUqPXVnXguhCOmfF7ZNF?=
 =?us-ascii?Q?DooKnrHbHoybTs2zyeg+5IHNm84HkX1QA/StpXpc75vydgjsoy7bhIylqNXY?=
 =?us-ascii?Q?xYm9ay4YOoQKK53xSHbkwF7UjdR3Aa8CXT+m4ukpwLipe012GVdNzsRAZIcl?=
 =?us-ascii?Q?NY8JxPCICBvORYz1YpygjvRQjZtEwCVx55olmKiMbUO6q+ZDGIVS/Woz8J/h?=
 =?us-ascii?Q?ZmYAy3DDBKR1SSQQCr75LCm2gIR3esIAmOI2P36o6j9Bgojc6R8LBki3nQKE?=
 =?us-ascii?Q?ANOnhSYBcs+ylzqI0SP9UpjvBHUuSufwO6rF8CvOVZvmLID4t6pP9hsxTf1h?=
 =?us-ascii?Q?p0JuIH0VgOhy/RQbCoS7Mo4+oDskCY7b9U8mc3NOeAG1lpcy+hpoFstnMBzG?=
 =?us-ascii?Q?gItjwFag4lQKGIsKiQX6fe+AcXgMe+/xhCEM33TfjN2f920sxL9KPP2LyDol?=
 =?us-ascii?Q?2kekkxtRLjYGmGvl1/mOHuh1QcixP+I7goe1NEMJ9CjhIFnD5VOtZBr0KjRl?=
 =?us-ascii?Q?stbsyAQB56S6DUQdlC2VwoARjtdqspeTXlDeBaOnolmOSMDdS9z4Kmc143zs?=
 =?us-ascii?Q?fD+fGWKs5/w50EzGl+NlSz22xUOWDbuaBK/eQwiQZPhaNga0a7rfLHKF8F+3?=
 =?us-ascii?Q?l/FZcL0la3IRMXh7TPCsq1ohONAnywEY1cQ3AH6z2Do/PkFRmrsXqGJ6MGFv?=
 =?us-ascii?Q?kiXK8m4cWsWh/bnk9VQtwF91WCjg2oHng+9LoSB7J5ys81YDKlMX+KQLL1pn?=
 =?us-ascii?Q?DqXbXyJpY123b5BQ+Cv485fjv5bWZMQNwrkAgLa3U9gDKw5zVDF3AqZQGdc5?=
 =?us-ascii?Q?P0yjrdR50+gs3MYMFstsmy9TgGS6vbYUU5DrCN+Bk67mO/CgK7smhVc7vizz?=
 =?us-ascii?Q?BUDquOBVjtcLbCGnh7am9CYssquUXCnldhSuRerxbTkhLYlmthDmS3iWHgxh?=
 =?us-ascii?Q?zuIfkgm8qA/zi0KmtsGxMmwb8V0523dsRGNUgulWLdqSVZD27JuWeAKDbBlk?=
 =?us-ascii?Q?NklMNTYILiYgUsFbXspA01wHhUs+haIsbI+iXiE7H5crXrP3l8X4gqtnzebt?=
 =?us-ascii?Q?zx7orjPyD6wyWz9ZE8fccIjpgy5ltWfrAkIiQy0MSf36RHWtH90Apls5NJgi?=
 =?us-ascii?Q?oH/Ojj/xk7z1OIl+BXB7eVGa2YzCR1wp52icw2vLyGyy9yzFRANluqgBLOG1?=
 =?us-ascii?Q?XtxsVPxQGIZ6ByoMySKkWxlYel9IfumkjI0s?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 03:03:47.7661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9420df9-94a4-499e-899d-08dd8ea61e3d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8427

An impl driver might want to allocate its own type of vIOMMU object or the
standard IOMMU_VIOMMU_TYPE_ARM_SMMUV3 by setting up its own SW/HW bits, as
the tegra241-cmdqv driver will add IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV.

Add a vsmmu_alloc op and prioritize it in arm_vsmmu_alloc().

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     |  6 ++++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 17 +++++++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 6b8f0d20dac3..a5835af72417 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -16,6 +16,7 @@
 #include <linux/sizes.h>
 
 struct arm_smmu_device;
+struct arm_smmu_domain;
 
 /* MMIO registers */
 #define ARM_SMMU_IDR0			0x0
@@ -720,6 +721,11 @@ struct arm_smmu_impl_ops {
 	int (*init_structures)(struct arm_smmu_device *smmu);
 	struct arm_smmu_cmdq *(*get_secondary_cmdq)(
 		struct arm_smmu_device *smmu, struct arm_smmu_cmdq_ent *ent);
+	struct arm_vsmmu *(*vsmmu_alloc)(
+		struct arm_smmu_device *smmu,
+		struct arm_smmu_domain *smmu_domain, struct iommufd_ctx *ictx,
+		unsigned int viommu_type,
+		const struct iommu_user_data *user_data);
 };
 
 /* An SMMUv3 instance */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 66855cae775e..b316d1df043f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -392,10 +392,7 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 		iommu_get_iommu_dev(dev, struct arm_smmu_device, iommu);
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct arm_smmu_domain *s2_parent = to_smmu_domain(parent);
-	struct arm_vsmmu *vsmmu;
-
-	if (viommu_type != IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
-		return ERR_PTR(-EOPNOTSUPP);
+	struct arm_vsmmu *vsmmu = ERR_PTR(-EOPNOTSUPP);
 
 	if (!(smmu->features & ARM_SMMU_FEAT_NESTING))
 		return ERR_PTR(-EOPNOTSUPP);
@@ -423,8 +420,16 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 	    !(smmu->features & ARM_SMMU_FEAT_S2FWB))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	vsmmu = iommufd_viommu_alloc(ictx, struct arm_vsmmu, core,
-				     &arm_vsmmu_ops);
+	/* Prioritize the impl that may support IOMMU_VIOMMU_TYPE_ARM_SMMUV3 */
+	if (master->smmu->impl_ops && master->smmu->impl_ops->vsmmu_alloc)
+		vsmmu = master->smmu->impl_ops->vsmmu_alloc(
+			master->smmu, s2_parent, ictx, viommu_type, user_data);
+	if (PTR_ERR(vsmmu) == -EOPNOTSUPP) {
+		/* Otherwise, allocate an IOMMU_VIOMMU_TYPE_ARM_SMMUV3 here */
+		if (viommu_type == IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
+			vsmmu = iommufd_viommu_alloc(ictx, struct arm_vsmmu,
+						     core, &arm_vsmmu_ops);
+	}
 	if (IS_ERR(vsmmu))
 		return ERR_CAST(vsmmu);
 
-- 
2.43.0


