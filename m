Return-Path: <linux-kselftest+bounces-33279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2684ABAD7C
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 05:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BB501891698
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 03:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704F123184D;
	Sun, 18 May 2025 03:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cJoazKMq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B522B230BC2;
	Sun, 18 May 2025 03:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747538582; cv=fail; b=PU9gIWHGglTK7dZTBI9uY8qCOi131/dIUODQKDnYUFPTND90YNhZrpTJN9pUt1PazcjbyEKCJZRcIO34dE8tXqnIdOTZH6b/3DI0hgw6+5jshlvqQngrYmdopT0nLBknq5zLPPmWKRHobfNx3sOHq3vaIwJe/2PLNovzdxOvoxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747538582; c=relaxed/simple;
	bh=2s4Ba53ilhqSMH6VzdP8+V0E8VwEPbemHo52nebLA2A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fPvwh+UhOUome+ElrckPd+9G85kB1GUgSIe5iAzPZZgkBqjez6VfnE/bcrfC+W+FtFn9mq3IUEYq7YLKYZPs42LR4kBaErZViWCluK1A/doiH3oBaIeh5QqHV8AxFH8u9P3GZxOOleDT0TJfA5ub+eM9uUe8C/ud8RX4p9E+408=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cJoazKMq; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q85rdCv+gvUYAJbufcsUgAhCiq/LBVcaVRQOazXZOH+PVal7cGWQ3UcCvH43SABMWvPcv+XC4WuZCRSA/IlfRfaZecXp93OdhSSS1Fi6DVG6V4vGVaVJKhdfAxneAmAwCf8qmWyOJP24aRV5N8MIMXGrfygbpMHtq9zrB+fpBv8Rt1pben/4nK8RgYLevBFSz6qAEOSlpfDAnwMoEwmN+We2A1nSUzCi98dGB815f5XZLeLr5pVQ34eVxRh55HX3RgIv1vXUutKu8n4c4/c9hNfb2c3JVwoD1gwOmkgukCvjK5h8b474uqCnkDrP0l06S6xOI98qAiYsA9mCim0I4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTgd7vkTwSBV7muZtGHOWsG9fvFUOTZRKs4/tMnH+So=;
 b=FE7Wor4JbwRUrf5d01KkfjqhfFyXIeJyPdg8QB3uFVnz4jt+6GJ7n7j61kNfSV+UHrVr5j/g1a3BLT9z/mXyj1Y18IduTcRHn5QEYW5r0AFjQ7NKvRPoyOMXWLEbvcgPRYgXkIqMSqveLfkx7Hf3xprxMiMSgb3xY/1wp/KW6+qmZmJOMx1OZDXOO8qbk5Y2O1tkONOgAvvwU2RD7QPMPAk4dGWfwIzJZemuPOHORVtYkMpFvCZdj1UlsQfYviKNWsBAiJFe/7pJXg50CCKDg1OS+E3sxi8RQ8WsXgkVIHMR3tgDcYbEB/x7P6MhOIymZGei+nPffuuxDd4tRbiMsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTgd7vkTwSBV7muZtGHOWsG9fvFUOTZRKs4/tMnH+So=;
 b=cJoazKMqEMCOYwb5gVuDUMbHxEv0xXvYUcU+hoEKXmdk25crH9rhJlRqzGoYCssyHHwW7zkNanxN2ds9E79XRZsALb0Hsy6AxMFQ3gVoDIjRFIiH7ufjzYCBcRL8CqUhg/Kc7uxdHbuf3a0zxnq/YqejOd8tQS09+8vh8OOf2Co5zLb2AqfBB5WMl2DiV/VAFO0r6V7x8S86kRIloAEsXwpJnpgV9ZXDTeBRNG4sKRKUbnMkol6k5VP4aMp1CIh+gPlNAeVLBohzj1AsGFswcCklJtao54TXVAl8Jrc4vQ1oPaVZL9Qt9cD14uxwZJZ63FBdQL4OFObGvNURTJ+Pvw==
Received: from DS7PR03CA0303.namprd03.prod.outlook.com (2603:10b6:8:2b::19) by
 SJ0PR12MB7035.namprd12.prod.outlook.com (2603:10b6:a03:47c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Sun, 18 May
 2025 03:22:54 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::26) by DS7PR03CA0303.outlook.office365.com
 (2603:10b6:8:2b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.20 via Frontend Transport; Sun,
 18 May 2025 03:22:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Sun, 18 May 2025 03:22:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 17 May
 2025 20:22:41 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 17 May
 2025 20:22:41 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 17 May 2025 20:22:39 -0700
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
Subject: [PATCH v5 24/29] iommu/arm-smmu-v3-iommufd: Add hw_info to impl_ops
Date: Sat, 17 May 2025 20:21:41 -0700
Message-ID: <9296d67c92ecbc5a6e33a1162d8f41149b2f551e.1747537752.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|SJ0PR12MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aa54e4c-6155-40ca-8880-08dd95bb4723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/ai0Ky6CGHQi917t/Nmk1uoVCpg8q9aAQ6bzqcI46zhLOSl/HGZa+WllM4Qy?=
 =?us-ascii?Q?RJXlDQMGO6SorKc2Q4WnO/1mnWlL4RauBijG25C/4U6wDgTYp4rTiJbadXwi?=
 =?us-ascii?Q?4KkKOwglZxEyIB/GY1c0pSJn7BLAG8pq2rxgCb4iQj3VjJJv0ZgMPfwl+jH6?=
 =?us-ascii?Q?Q233kR/eUaRgYSu3ZxQX+t/NMUUd0vMCLcE/8XdyewyZOT1ktr3yUgMh8Rnv?=
 =?us-ascii?Q?FRlkEnUj8ktyB4blgUv2JDe7HVQ1+lS8qLdTcSXRgfy/o8vND0692witnhI9?=
 =?us-ascii?Q?YD6LE3zmlCsWOx/ZLuKQ6K0Bg2oc210qbMdQ4ClMYlDvSNhT4RKSO37790nb?=
 =?us-ascii?Q?x1sQ44KdBRgGPzWLBGje0tKZminFlru9wv/YSJuFji7SRA2imJggwRGM88+R?=
 =?us-ascii?Q?E2sx5k8GLYdhnWNwKni4V9U9CbwTGDNmpgs5+TtvLhu0WhXESNYgZBKFTQnY?=
 =?us-ascii?Q?vfmlaGLRWxkLULtSQfxTdt2OjUhAaq47lfTOCP/9w2DdcREyuC31elYdWVDF?=
 =?us-ascii?Q?sLGPdOvN1n1huPE4WWNnQjF57zRS7r8XsQzHxIHxI2Fw/O6czXIGSlCXAzvg?=
 =?us-ascii?Q?ALL2Pg84eC26f/QdM7nRWOM0fzdyZctrppypmXrRHcUXErnLKJ/037IF+n3a?=
 =?us-ascii?Q?okc6dBuZ5q9THIr9LVGwVjse9LluJMxug/nOfqLRnWLH/DYKpeL1Hv6gjdH/?=
 =?us-ascii?Q?GhijCF8ZUjIFSJqNnOaGp5UgIQh+PSv+Xs2oSsd26BfFfaGdYQZNKs9RsQsY?=
 =?us-ascii?Q?cSob1YBcKLuDMpQiwlBBY6EiA/U9r8oNBP/49ZblqwhkLOGcA0i+MXSZP+FH?=
 =?us-ascii?Q?KhtFh3kcohnBWp/gPY8kBPDLAjDll8ym2uU1sxNh3jXCG1CA/L3IkvfRoQg0?=
 =?us-ascii?Q?5fuFS1XYTDtJtmSQOV4aikqv14z4ADwZkalXaVZU1mSNwFBznuykBADxflue?=
 =?us-ascii?Q?qtij+3z3gT+GEjSJUnlgKgKhDOcO1IIzkkEtLEWDZNngnS6UdRX/6VyqvTK7?=
 =?us-ascii?Q?QSTe10a/0O1h3aq8Kl3mqIklzsCLHAdy8GyC6+jl1TivhtFmeztTcXE4QiUZ?=
 =?us-ascii?Q?gqJOkgggPxUOb6zSW5BIs4sTKvbpPjdagtxNVXwojC3G/Drd3NxQ4XS2242e?=
 =?us-ascii?Q?jpWYtdHjXYNriSjpDsFJdYni3f+WiFeSUYZroP3Dp3YmLIQkYd+H3T2VEliy?=
 =?us-ascii?Q?UnIXNmDiJaWIZp0SOy9v8uBDg6qKVSSWfkX5FqUXovpp8EPNQj/qg+xiRCrz?=
 =?us-ascii?Q?B5H15F3hIrk6F+Hs5mxv01AS8gBW+jKfepjjXztYmZSDQu7U14FzSACDN4hZ?=
 =?us-ascii?Q?h0beyqg3fXJ9WjCY11cbB7FGvo0ZAM6QP8PiudgVSHavhqlow5ngQqzQpWDH?=
 =?us-ascii?Q?xClpd5iEkoEcQ9/Bb6G7QOL9jrhu2NGllaNGSpLSm7t59shlAQn35kYYZRG+?=
 =?us-ascii?Q?MPXwxbjmoqyAlq4i9feGr/hsZ27PkXOmu4KmeU53+jzBRL6JIx8SpvMlg7Lp?=
 =?us-ascii?Q?gkUYQrMHpZcr59s0IFrF0b3G4upDUABDFYYH?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 03:22:53.9873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa54e4c-6155-40ca-8880-08dd95bb4723
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7035

This will be used by Tegra241 CMDQV implementation to report a non-default
HW info data.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index a455ff97e53e..8328c8cc1899 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -727,6 +727,7 @@ struct arm_smmu_impl_ops {
 		struct arm_smmu_domain *smmu_domain, struct iommufd_ucmd *ucmd,
 		unsigned int viommu_type,
 		const struct iommu_user_data *user_data);
+	void *(*hw_info)(struct arm_smmu_device *smmu, u32 *length, u32 *type);
 };
 
 /* An SMMUv3 instance */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 8a13d0102c05..837f15e2d40f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -10,13 +10,17 @@
 void *arm_smmu_hw_info(struct device *dev, u32 *length, u32 *type)
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


