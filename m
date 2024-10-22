Return-Path: <linux-kselftest+bounces-20360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 285819A94DA
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 02:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94740B227E8
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 00:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3772003CF;
	Tue, 22 Oct 2024 00:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f3Hf27Zy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9179820011E;
	Tue, 22 Oct 2024 00:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556472; cv=fail; b=iYM0adMd6NmmzCMaIesgD/mu7CO2BQnis+7N6WcSfp5AGhcisX3DuxiMvgvLkC55CkDU9YRwUFngHa4Kem4KZcLDGXdxEH+IwdiJ3UrclNXaEX5yPDlV0cBOmiVPtlGEXaf98lH67Zl1BpMlWapLKDIGcPtrDPfNIDwBO1NaJhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556472; c=relaxed/simple;
	bh=O+g/HedavNV7vIxDL5pnB751vNA7YwzZ10eZjus8GzQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eg0WtJnlqYYrCsbcHuMGXdAQb92xe5jMUV+3cPvOjRGpS57Z2ol8tYLu+z4Uro/WYsTTh2K8mwF8A5cQpm8jEverEPZicbV23VV6bHp23bJiAd0LmnhxYREsVsAhdWv1Ij3NaV3qB2Zos9VfNJSX7xD0JdD2ATDHPZgU5gfAFRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f3Hf27Zy; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NwtCUxkYAO+cQw6BmShV5uMYE8tnWqOKhNkCUFHI2r1/yx/1EUqrtnqGZNfWtd014Bv6+9hp44nVkWmvS9gNr3mna+wGzasHQF8vdzf5SVfUgebWaocfayL0rYjhSw1yv+XEdo9O09Bz/XymM83fSK9J/rS835ZtFKUDRMfYyaiFsYqSUYvodM/B4DQ2xE3Z4n8KnxpGmd50X/q0+QR+cgK327l9lWDjkvBViNUMMFSHujxZNJ9FeouxQZJPD53U3MPVJQG/j1592YQsZi1seBW5C4AmN7QmMjLyt1klG/ZiUpRdpveaZ055we39ZlZIR6Y27/ZRqhGmAG59xDmA6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkbjB6MPGqPPgs/c0xA0TIyOa8/EQJUEk05eRbXJMas=;
 b=so8Hax5C1pJ+PJ9cjP5dABSl0eAFxtK9K2JnPNHgieMe7rfMbAa8dlnVqSRqSLxgzNzH28rZ8R4pvPSyis/TMVZ5R5E9YLUEkjKGdcYfS9iqrLuInfHGvytVZTFFHmbSb76yrUCNiAqWLb81VQMaGg9Yr5p9YJY4i0NbCczymauvjJG2juQBAWTmCFlE7qY7blNKx75PLXDaIYmdBnCqBtZ1xk5FeYkhdH6b16WsooyxdFJTtTYwn0oUxDU/E/Rn8JuaGn/y/aVUXcsSIevibhdOqb4ywACggX3FxZRuZ2uvAXeCAq695OWnf75SJGxfrwMUZoVCv+fS9mVC0lXRAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkbjB6MPGqPPgs/c0xA0TIyOa8/EQJUEk05eRbXJMas=;
 b=f3Hf27ZyOAcw4hTwUfEhUVP6JsscBKpRCepLuR1gr/glyo7Z4OxVmnJW83pT1oUyMbyt9GgyGe9jwD2/cwIH1GljgeqgoiphNL6B+AHIzoWSWz1pe4afxqkC99/ZkCUvZFeJnvukuzkc22OHVKVw19Y/z+fKMbb4Nuti++pc4MbFvHwwh9l9LKE07jRLadOrscnWFomNLjuxdaxkvYBHi20Dl43FeGMLhXao8sohDFg8LUNRbz8rT9l2+KQAdca3shZJ+3HpNXj0mUwr/OJZMXYLZBNnzAqee6yPS/6ExkjCoo2AmVjXX+nRguddb+oJb3BjguR++e2KPRV0X5k6fA==
Received: from BN0PR03CA0024.namprd03.prod.outlook.com (2603:10b6:408:e6::29)
 by LV3PR12MB9355.namprd12.prod.outlook.com (2603:10b6:408:216::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 00:21:06 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:408:e6:cafe::e5) by BN0PR03CA0024.outlook.office365.com
 (2603:10b6:408:e6::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 00:21:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 00:21:05 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:48 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:47 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 17:20:46 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: [PATCH v4 14/14] iommu/arm-smmu-v3: Allow ATS for IOMMU_DOMAIN_NESTED
Date: Mon, 21 Oct 2024 17:20:23 -0700
Message-ID: <18e46cd5b8e79664bec57d4cfca5954670a53185.1729555967.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729555967.git.nicolinc@nvidia.com>
References: <cover.1729555967.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|LV3PR12MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: ad380c71-e80c-440f-5657-08dcf22f6b81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9sMVCgUjWjRd2CqWrQYpOp/yDpg6UK5V2QBciZ9f9Jzk9PZ6fUPpgG3DTk0u?=
 =?us-ascii?Q?nPBnl2bm4vwjYvrWvKr9hijW8uVgUsWS/40l1mcW2/YlJ68nVt0boTNSxjbp?=
 =?us-ascii?Q?X0HZTpQHV6tR+wztwl3wKQm0ln3GAorenxMMfrnB9DhrqxIlU+yjZvPwLV+x?=
 =?us-ascii?Q?AZK7Z+bwwlRdTeSa6RxTw1/L/HW/ZXpVcGasXmOl5Lqe4AJaWLgTSxkmv94R?=
 =?us-ascii?Q?wiK8/2m7j+d6GZ1cQd5uSkpH6F3ZkfkQAh3UUfMRmoYsOJNEZJZzEmda+6xV?=
 =?us-ascii?Q?lqtj6MtrZ8Q4U0eex0MKaaOLV3MgF8W63ajOlVCTDUkT1QVNYkWIymN3eu3y?=
 =?us-ascii?Q?T14atlICy/tbIo37pq9whltCNXLVGNy3lGn7qYQaL/yNRkpJYGplgukyl/4I?=
 =?us-ascii?Q?5/nWsZoBYgQc83/MgeUpwAwnmEMArEuO/9kupm7ZaBDRKSL/MUjwryWzuL+v?=
 =?us-ascii?Q?ttu0a0nqXtBXfkpTP6JSsudIkWyaUvP3JXri/CI8dFGOhZAjJCnURN3GHv/Y?=
 =?us-ascii?Q?ek3pv1Fjuq1W51b3ZjzBSix6Q+QEgvIaNdyRr9hT1KzM/DdkK7McgPujZhB7?=
 =?us-ascii?Q?vzWeGl17l1PQrvsWfK7V037q1Y/PmHIG4TNc8L12GYrg6e7YBZGoi8rh/Jw6?=
 =?us-ascii?Q?nHY/2ju+jRjbkZNHcWDpaWKydC1FOvoU4ULWUP3rjwq1gHU+jxqz2NXFR3Wl?=
 =?us-ascii?Q?1WkX+X58DUJ48sUABa6tVWagtDjYrRR4Rds9Own2fn7BKx0ulGPtfM/bqj8s?=
 =?us-ascii?Q?p7tQF7i9Hr0B7TfkIrGd2tkc1wP4wHlidDxtcQfgEKm+4O36w13xfuLB94H0?=
 =?us-ascii?Q?sb8EBZGlfUzsacHxX2tqoTZQ7oXGYqYERoLjtDrjs4uwXpwv+nISiddOYne8?=
 =?us-ascii?Q?RU60aLM7HOFEICJx68SbuJDxyvBERkWESVaSAU8hx8GW7ytotTGpNHHSndS/?=
 =?us-ascii?Q?5hyz1GKBI7xPwieK3wVNA6zJqVYsbhjNTy2u7oINZKZ4KiNMiSVmZffFxDeM?=
 =?us-ascii?Q?4WhcC6deTTyVkSLnGYkBO8XF5T3HZi49gwW5NLcFEzdeQpG1wAYqVgqswwge?=
 =?us-ascii?Q?joKsuq2aUIRAvAW0MQ8WwDe+BC5xWz0lSgPbIOk0wzWm86hcJpNwCJcpULV+?=
 =?us-ascii?Q?751s06vgVpTTI6Cs+Gtt3KRsqF+0iN7pOnkGM7wZBldNph734gSPAQemgqXp?=
 =?us-ascii?Q?edt+ieM2cC+0vDOhp0/75C1srR078bKRu5oAMDAC3/1cVC2N7Ocr1QOI74Yx?=
 =?us-ascii?Q?RBdlinAwgcZxYFGWjdr3oReYNGkz8nLI1soM08Nyv5HSrwTUs8wCOHpxDRpA?=
 =?us-ascii?Q?mP7pQCpwPfit5sLiHIpmVbXuuwcV8NbDvUXRWb0RlM1Y+e6xh49HgyfbXYnE?=
 =?us-ascii?Q?MAJ3YFeGMcdT0JpUIKOsMF52C6lzFkz6VzGELUfSTue9O7CkrQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 00:21:05.8603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad380c71-e80c-440f-5657-08dcf22f6b81
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9355

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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 26 +++++++++++++---
 4 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 8bd740f537ee..af25f092303f 100644
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
 	struct arm_vsmmu *vsmmu;
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
index 007e4b5ebe34..c38ce44ae6f0 100644
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
index 6f53a2928c36..59b8eb776f1f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -96,8 +96,6 @@ static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
 		.master = master,
 		.old_domain = iommu_get_domain_for_dev(dev),
 		.ssid = IOMMU_NO_PASID,
-		/* Currently invalidation of ATC is not supported */
-		.disable_ats = true,
 	};
 	struct arm_smmu_ste ste;
 	int ret;
@@ -108,6 +106,15 @@ static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
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
@@ -132,8 +139,10 @@ static const struct iommu_domain_ops arm_smmu_nested_ops = {
 	.free = arm_smmu_domain_nested_free,
 };
 
-static int arm_smmu_validate_vste(struct iommu_hwpt_arm_smmuv3 *arg)
+static int arm_smmu_validate_vste(struct iommu_hwpt_arm_smmuv3 *arg,
+				  bool *enable_ats)
 {
+	unsigned int eats;
 	unsigned int cfg;
 
 	if (!(arg->ste[0] & cpu_to_le64(STRTAB_STE_0_V))) {
@@ -150,6 +159,18 @@ static int arm_smmu_validate_vste(struct iommu_hwpt_arm_smmuv3 *arg)
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
 
@@ -160,6 +181,7 @@ arm_vsmmu_domain_alloc_nested(struct iommufd_viommu *viommu,
 	struct arm_vsmmu *vsmmu = container_of(viommu, struct arm_vsmmu, core);
 	struct arm_smmu_nested_domain *nested_domain;
 	struct iommu_hwpt_arm_smmuv3 arg;
+	bool enable_ats = false;
 	int ret;
 
 	ret = iommu_copy_struct_from_user(&arg, user_data,
@@ -167,7 +189,7 @@ arm_vsmmu_domain_alloc_nested(struct iommufd_viommu *viommu,
 	if (ret)
 		return ERR_PTR(ret);
 
-	ret = arm_smmu_validate_vste(&arg);
+	ret = arm_smmu_validate_vste(&arg, &enable_ats);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -177,6 +199,7 @@ arm_vsmmu_domain_alloc_nested(struct iommufd_viommu *viommu,
 
 	nested_domain->domain.type = IOMMU_DOMAIN_NESTED;
 	nested_domain->domain.ops = &arm_smmu_nested_ops;
+	nested_domain->enable_ats = enable_ats;
 	nested_domain->vsmmu = vsmmu;
 	nested_domain->ste[0] = arg.ste[0];
 	nested_domain->ste[1] = arg.ste[1] & ~cpu_to_le64(STRTAB_STE_1_EATS);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5c652e914a51..2a9f2d1d3ed9 100644
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
@@ -2631,7 +2640,7 @@ static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
 static struct arm_smmu_master_domain *
 arm_smmu_find_master_domain(struct arm_smmu_domain *smmu_domain,
 			    struct arm_smmu_master *master,
-			    ioasid_t ssid)
+			    ioasid_t ssid, bool nested_ats_flush)
 {
 	struct arm_smmu_master_domain *master_domain;
 
@@ -2640,7 +2649,8 @@ arm_smmu_find_master_domain(struct arm_smmu_domain *smmu_domain,
 	list_for_each_entry(master_domain, &smmu_domain->devices,
 			    devices_elm) {
 		if (master_domain->master == master &&
-		    master_domain->ssid == ssid)
+		    master_domain->ssid == ssid &&
+		    master_domain->nested_ats_flush == nested_ats_flush)
 			return master_domain;
 	}
 	return NULL;
@@ -2671,13 +2681,18 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
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
@@ -2744,6 +2759,9 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
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


