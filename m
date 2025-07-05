Return-Path: <linux-kselftest+bounces-36634-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C61EAAF9D75
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 03:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74821CA18AB
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 01:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623EA22F76C;
	Sat,  5 Jul 2025 01:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c4PQt2Wo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FACC2264D4;
	Sat,  5 Jul 2025 01:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751678093; cv=fail; b=t/FasFUiqy+XR+Cyf4UEDBXFoGI8Phx4x1XI9IfbaTOZAtNrK0DNQ3lNGuVOQdJPpgbxIWBL1RxyGOUEwuz0uhNmna4OJBjMeQdUlKeejbEfCZ1SyGTnj6VI02MDzHiGRJVpoN+I+ISwzxIgNfQ2X0TYGPvryOFgzzt2eAVxrMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751678093; c=relaxed/simple;
	bh=8+sT5DAf2S6MwTgbXS4pRoUD8tc9X6LoULq+3teVljk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jkZd4hrwcK2vcvHmCf6KhUhenVVkfJZR435T+q3MSK+4A7/vl1Ul7I7hNlFgx48gyDlZqhZmg489HWmds+JAwlpiqRCsu+G2H3XYKN3aAjwgg7XvClkgS5zCD8b8SFWbW5BAub6ce01BEIb/CTQgKq+XiO54x0ARH0TOd8xHyKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c4PQt2Wo; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxQ1FH0L+y6nZ94bvuRHhyb0UxYe4s046mGy+sLO8SV+yYotiMw+Cr4CXYEnp7EeKAvM8TvOrlgQiTUWZLor1tZfx7ykTjDrWcw4dyP6DHiD39U7auCkmqPQ+rwDVIBSPASwc8HuwqksxSf6zkRgQRCi+ZP59iwSqHnFDc0UwbiDpwWL7Pho2DPyk5oeTHs/MdukcDqHANcr8ZQcSwprp5XcN0XqI3DRbKTZwCgdEyRmV50Ljoz7+FbNL27RUqZ2Kf61eI7C+BL11a0KkFA04j3CaBnwSM8mDuSM5sADPsOcV7NbQRo/lipqfzBd7VBqn14dUHggkjS4SpTmAJaYoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+S6yb4lBxaWahx4m6UxLICNa1zdj/hmIuInS19AP4ww=;
 b=VmNL/LNbO1o4tAr8SAkGtR3qIXunPBkyCC0dWaQkUwZtF7fjpRVg1DIeg5ajYg9DTRkBUyEi+zfDod5Y//q5tfErZMzQRd8n/N6xStTh5uF9OTsV/QAE+5zF5XZEAW7P2Oxs77QM+nJa6Ksz1xX23nxZOWytugmzlgQvBYfD+dEVsWVTXG6quYcKVLXPnzvKn88ca0fSO+8j95uuDrCJRp5hIqPO6zcWWjkpw685WBXjq2oxC2rqwWh1TTZkS66N9xpV4gKcrgchr0QCiGfPT27d0WoDlqqP5F0aLQY7QZvbzriNOMII8+K8eO3GGm8iL051xjP5KV2/XjC65IuEpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+S6yb4lBxaWahx4m6UxLICNa1zdj/hmIuInS19AP4ww=;
 b=c4PQt2WoqUNj/92jzg8pzG6PeVtzLdSypEIYyukOm51TQ8ixq9i4XIxQvZ4RVQtpi/obRjBsLxf/zf8RzCZ4GYDC7fRTB0ptCwsPhF1gA9ANHJOVA5QxachlsoSC5S0vP37Ibls0fz9xBwsg9s9jVgdI/hmf7G4VMWT6frCeCYKh7i5JwjKtyZkg2kN1N2c6FOdXEYKZ0pHiiHWu8YKOHrdjlD8vPS69C5aVit0MEBUiUYY920WhKM5dMbCXTpq/w8OhqODYsnHS3RUI0HZOD/2BJooVnJhZiccUgNFbLLHeIR2p/Xvf3YFzRGVA3dASjD3HEX1qj3n8xmH11YHYFg==
Received: from BN9P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::25)
 by PH7PR12MB7455.namprd12.prod.outlook.com (2603:10b6:510:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Sat, 5 Jul
 2025 01:14:45 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:408:13e:cafe::8f) by BN9P220CA0020.outlook.office365.com
 (2603:10b6:408:13e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.22 via Frontend Transport; Sat,
 5 Jul 2025 01:14:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sat, 5 Jul 2025 01:14:44 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Jul 2025
 18:14:33 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Jul 2025 18:14:33 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 4 Jul 2025 18:14:31 -0700
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
Subject: [PATCH v8 24/29] iommu/arm-smmu-v3-iommufd: Add hw_info to impl_ops
Date: Fri, 4 Jul 2025 18:13:40 -0700
Message-ID: <ae975714b449c0f0d2f1aaf4c7afb669b998e6e8.1751677708.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1751677708.git.nicolinc@nvidia.com>
References: <cover.1751677708.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|PH7PR12MB7455:EE_
X-MS-Office365-Filtering-Correlation-Id: cc902c77-38ba-4d42-dbe1-08ddbb615398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kjVTSfev1SEKHIN601B6k55KPNsxVp+c+md4NtS7wiaUB/7BX2cIDi5Eioq2?=
 =?us-ascii?Q?9HUfQKAgD+Se/cpzy+VvcQumhVqWWyazcLkSYFfyoqWUEGdy3JgaulRFKWsN?=
 =?us-ascii?Q?UaCWS+e18YWkqN45JkMTMYigffCjqxJycvp5Vuhy/IgSZHRr5cg2HNDADu7e?=
 =?us-ascii?Q?veMGXnOZZ6SYw/ooE+G4U3XF+0/LdTAL56V36FvT40bMmjgYVXxl+HI14FRq?=
 =?us-ascii?Q?4TZYLkc83DphuIMgEAvxnVtIXA8rHOnduaIOFA4QyWfQEfGhjC425A/WIux1?=
 =?us-ascii?Q?wQg6k57fFALSgEkh91vmEZzgbUFOqUvs8WgIb71d/f2qOipDIHXZJ7RAZCPW?=
 =?us-ascii?Q?5GFH9sv2Y0oseS1LLADbGqA7MVJHV0gxiDH93DMMxLhjdNHrBu9FusJQfa/t?=
 =?us-ascii?Q?P8NosrcUpiRv/kVBoRvzUanudZuufF/H7Qz7gTTuBu54hn//spNd55Op6+zt?=
 =?us-ascii?Q?uGVUDbU4Q/7kPWJZlqM2hmfhr9cutGGmODnaOqvghU+w4u7zqiUJpyBv2wm7?=
 =?us-ascii?Q?ZSZbmk+VbYRrmPBLx6ffkSAxlSnhttYj0oZvLyL5Afa3teOiaoK5nJHURO8W?=
 =?us-ascii?Q?hl40IjFeAlL99xTkpULGMwP3Y7K1dw6wcWuhPIyTPR0xl4k3yt4FtMfxMZ2H?=
 =?us-ascii?Q?Uajh9zDdskckMeUWgMkZVlGzwuddHwYZXbVpV5yr9uYgdkAeAgNXy/F3Zsom?=
 =?us-ascii?Q?OYGAliaADYRzYNQJDkaorerk7lrwfFonAfYCI6bx39dbLRvhqNr+06Y/r6WI?=
 =?us-ascii?Q?P8WM2FqCDkpT9fR+FZOkLB4aIx0cTr18DnDcGAHEj+RI2ynPIwZ5zGLweVBD?=
 =?us-ascii?Q?iUjSDWcFw1JVwsA8I/d9eMZznDxmnszaHyZ8e9PRj/xLJmwKPrKjQjv7mpxC?=
 =?us-ascii?Q?5pIJli7WJvzPJUltjkuctWDGZ4ILu1wuAG22IuqHOvnZpyHbdpq6xH9KNYmC?=
 =?us-ascii?Q?yMYToJcaL6fbPQ0In8Q4S4aWIOBRMqvai82yLsckw/zEYPEwAGpWPN5Yhk8V?=
 =?us-ascii?Q?B2oHgXSBz0AoVWTfL3gAdXv+XXqhBy+fVyOWjf41X1xIBHQoknz9emI6JGZ+?=
 =?us-ascii?Q?1kzuY9Cj0xCJp6vGr+WAoezOkBVoBnKQlGoFBYNksIOx9Pepi3alnw2aSHOH?=
 =?us-ascii?Q?BpbkHbNupqPFRw08GtclGGHCs/Mj/dXPyZKUNFvS4iECR4dHUl7uama92AFn?=
 =?us-ascii?Q?6suuceOP8f5/ANCQUauDriAYD7DOQGo/oFW7BnDnCfHPESySIj61q5c0rejV?=
 =?us-ascii?Q?d5N0PjcGMfXZDZ1eTRhQT4SfqgnCAVQuvULKNbTv3tdNlG0Vxt4qwUoc2AtY?=
 =?us-ascii?Q?x1QCkixdhczoU8q2pFvYe4UjSGCobQY5fepOcsyuXNIJ904rQ0dvwlfr6QXV?=
 =?us-ascii?Q?NHgEfbvH7qpaETtZYNWnmFAkmXUAvrkkY2eG8jkWtGoh2+VMteMo6Vz5n76Z?=
 =?us-ascii?Q?T/jbB6mqgDfZ/95fgaxOFh1T1CE9870jHQWZf/TwprsTsLgSTUErqGVGqnT5?=
 =?us-ascii?Q?q0eqLvfsnsVWa7cMxvTFa1dGmnhbfYk4knon?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 01:14:44.3414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc902c77-38ba-4d42-dbe1-08ddbb615398
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7455

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
index 07589350b2a1..836d5556008e 100644
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


