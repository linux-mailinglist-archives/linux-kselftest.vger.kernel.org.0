Return-Path: <linux-kselftest+bounces-32718-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A74D3AB086F
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 05:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FF717BFEB1
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 03:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF85A24EA90;
	Fri,  9 May 2025 03:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="goP0dr5E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A8F24C098;
	Fri,  9 May 2025 03:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746759839; cv=fail; b=I9J5Su+dgpEz7XXpiRWriVJeBin2ATZfAJYhsROOWnsMixNqWfAKKKsIYeAqvo3F6PHcxuzFMbMmuato/+CtP5TJke7zBLSM1XT1D/5I6c3tGGuVbBxPJScMR19bHEzJkpX/C6f4HfFp+MjN/sgFoI3D1u79rhzEaqxobw8yFd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746759839; c=relaxed/simple;
	bh=3rkEmrBg1e2KDrtu7aysQH6rDOdfRUkpZX9Ryvb51Qc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2QJpfPjg7AHkMJfcG+vEbVxtBxqNdLrku4BeLvFHQgdnpss3j5JIR769l896JEoTAKHMpFdQJlwhKar+B836cw0nscgzd3LJBEsssxAc3ppQXVBY5KrLF/uU4JB3cEh2+dz6H2q6KMsxXaN8tXuwzbY1caJc6LyN0JL9yq/BP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=goP0dr5E; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8fjivo7KMaQBqmH5E1JUongtFGsUG0mZnKrr5ZbYCVFRygK+eFhZsrPKIvje5yrMMChT63VSUpKudG6szTxg4XqcuQTmGZ2nFA7jBcIuVENUJT0f3tupzqpN48cgXRYthJZjaTaDMGxZzP4/WO6QnDX52a4i8haqGhT6FwxycnPEc7icpDql0I/BxQQVSaiOiOVnQ3UFSrfXAx1z12RBDZanKJWRaCHw0YflsZ4TfV1pXaCZoIOVe2kLrOK+Cj+rhXvC5r9an3wS0+supX1QxQWrTDqY9xP2BE5E5N1stj4dP7UhCjHXHbhc7v8OakbO456daFn61qRImdq01IPHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hn6044iiGT0BmuYHa+YrkuqRYn+AFrLF0MWGm0vklJM=;
 b=G0V/ELqknZ54TCCW4JsttcsVig7Ac90CXwKd+gb/FoK4OFOnMyMplb05EksrHAWZYUbkH++jltyFOSOX8IlgjL4BZX8EQdDEcflDUSMRy5A/ZL5imSPh0l81A3inZ/W19/NbgJWwxBS57HiOyHK/W70FmOZEvb7bduDqHa+7zPWDiwBKn3xnrW8wmIW4iy5o3QMhhMHac4NKqpHXo15iMiqd/R6HEgGWbJ0673At62W61OiYr0RoXuLFoxVXxnan0RVDoZLkmNPbi7sGbODyLUKa1WNqj0EZljclWnWq7vjHo7OjPmwF9RDF6Z3nrlq3CgMGQTHfQJ4APRpaXny6FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hn6044iiGT0BmuYHa+YrkuqRYn+AFrLF0MWGm0vklJM=;
 b=goP0dr5EOHOeJlqGxS0dEVFCR/iDa1I89XPQR5FFXk0+SbNqgQl88K2gpcECfhCka9EVgXY0a+9RTJOHOl05MkBmLr5IC65E2Hh1CMwOFoi1+30+v+8LnULMAA/ObIu+XeA9RovHPNmg8JmNcsxf3BWLo5w0RFpjVDbiKlVpRoHPBjImKSALiaBSyOL02C15am+LLB9Qi5U0Tli8nMUqgINri9EwiUGhPzniHVQ9zXwPmf+94fCPswmoTfVFdHhRSy76SB+wF4Jnhvq2Ocx4vXn3i/D8LMdsRdzxeP6ia66UtNEDkB7oBIUWcWtS27ZGRZ+TSNVP+9PR/MNJXr65GQ==
Received: from BYAPR08CA0040.namprd08.prod.outlook.com (2603:10b6:a03:117::17)
 by CYYPR12MB8654.namprd12.prod.outlook.com (2603:10b6:930:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Fri, 9 May
 2025 03:03:53 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::23) by BYAPR08CA0040.outlook.office365.com
 (2603:10b6:a03:117::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Fri,
 9 May 2025 03:03:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 03:03:53 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 May 2025
 20:03:43 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 20:03:42 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 8 May 2025 20:03:40 -0700
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
Subject: [PATCH v4 19/23] iommu/tegra241-cmdqv: Use request_threaded_irq
Date: Thu, 8 May 2025 20:02:40 -0700
Message-ID: <e653cf3b204b97eafc40e40606ffdcfeec8a9837.1746757630.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|CYYPR12MB8654:EE_
X-MS-Office365-Filtering-Correlation-Id: 15af35ae-5e8e-47a3-5493-08dd8ea62155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v6TsWseU3XpisAPKT5r2j4vcZqmrIYhm8EZPCfwgXfltD9O6ooKo7/dqH9kR?=
 =?us-ascii?Q?fleusnGSvdyJDtA3+0zByJsaMTZs1VR1SpaursbUxFklx0yPOals4PPvaf6y?=
 =?us-ascii?Q?IaSdn6NIj6bE2CuXDwfzSOW3x+Yut3BeunJAVKtBDDZGBGyCPJsAIanqQPNq?=
 =?us-ascii?Q?QwTuqAgZ+Yknl+LncR2yNSliWm5iaglb7fgyh+wHGFkeBdCyTibYaPxTJlU/?=
 =?us-ascii?Q?JeeVvtkSkIG1ws7FAYKYX3A1K6POrGlFT3FGdgmZCg1UzZU/yGWTivmGss9R?=
 =?us-ascii?Q?iB4Svf5152jdpUdscC5D/dc6AuX+enO27s9nzy7PkcP/NXhG9VSJIhGF/xYg?=
 =?us-ascii?Q?vkxs3KDUIQkFzdIK5AItzotaQi6tj69k9myfo7sJgkf9TGX0ad0ucnSMLLTe?=
 =?us-ascii?Q?eIxHVI7FlRfMeRlA5WlX1IIXQOomeukXiaQH6nmC2q18vZMCvokAKB/w+pOt?=
 =?us-ascii?Q?kMdJKxtYfBWu1prHg2cWbhIMDGS7UGDX9mdx7C8Moyd2PyJpyZpmvL/dxgnR?=
 =?us-ascii?Q?avoE9fw+7kTPc7fmzQuSizBnZeIg28bQhdEg42dTTY89nQ8eALBXm1hYCrKu?=
 =?us-ascii?Q?GcMQqP2yjHzQueh5XY5mH8Mmb4KeDMtcZp89+0iahez4ONDbAHqROyzpmWYg?=
 =?us-ascii?Q?0kTXV+CfAtWrtlMdsGBpz+F1c+M3eInoiZAbFvz3LfioLpZRbZFT5xjTbwly?=
 =?us-ascii?Q?Odiq4T5okM0y6nVCe+BHiW0hoH3+ojkEgadSDQrSmk4+dbn/mtJvZt0iIjjt?=
 =?us-ascii?Q?Po0/Kr5FLMN1K0klQYm5rIrphWLSUt+VOOfG8IgXZBfABQ3QAnYNOAsCsJuP?=
 =?us-ascii?Q?Qc6/9nRffkjnAh4RlMmj3B4e5wIGBwmIViYCEfMo07CoBe2V/fmclRBzCtNt?=
 =?us-ascii?Q?iyMVdaD4XAEZprZpqLjXJPZRgqlVaWFnzdJGdpZ3657Nsjw/k2JfWtqAjLb9?=
 =?us-ascii?Q?IGEt2+fXvSVSerT/gcd20eacgMdd7pFhtYTloKVy/LCNEPKZnFHc2ihNzkZE?=
 =?us-ascii?Q?vXMeXVZ6GqoZaa4JcQTTlbRojV1cMpPyVpDiAeJpKZWGMIKxq7ixm1kiI+vh?=
 =?us-ascii?Q?ns5qAZh7xJGED2VsYJVnZkRRUp3eBCA7A90hos/ZZixmLyuiqdmAtMx9NL1s?=
 =?us-ascii?Q?3z0Nq1lPV6IlM56KzeBUZiLRAKmw89Y2gw8wO6ongjAcqQbgn3/wkSFd5Z5P?=
 =?us-ascii?Q?sSFGVlxq0Ac3V7LOQOFOLWl6wCkiIS8cESBW8stEQAdK1IzpJiMloMVWAlF9?=
 =?us-ascii?Q?R8r8/D5UGIS0mr346me+g+stJQikBOLJbYg+6cuhnCQ70ip+25np9AxfcE6z?=
 =?us-ascii?Q?snXRB/LBiMKCdxJ4FoyPirCtK1VW8MGwpsOpjKzO0mZKQBVL4VStaIVUTiTb?=
 =?us-ascii?Q?0S405FQjEa+1FRDjMl8n9NtOOuRVUGyumm8r6Sxn7C2xsrra1/Lp1FGSzz1H?=
 =?us-ascii?Q?dPBEq1ttOuRubZZkJyE7KK2S0oKHcAjcNqkKkzDWJESZ5lBtRMXJwAGeeZs6?=
 =?us-ascii?Q?jt6NLtCKr1I2OMsf+mGM9hnByUZhxYApHtDA?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 03:03:53.0110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15af35ae-5e8e-47a3-5493-08dd8ea62155
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8654

A vEVENT can be reported only from a threaded IRQ context. Change to using
request_threaded_irq to support that.

Acked-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index dd7d030d2e89..ba029f7d24ce 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -824,8 +824,9 @@ __tegra241_cmdqv_probe(struct arm_smmu_device *smmu, struct resource *res,
 	cmdqv->dev = smmu->impl_dev;
 
 	if (cmdqv->irq > 0) {
-		ret = request_irq(irq, tegra241_cmdqv_isr, 0, "tegra241-cmdqv",
-				  cmdqv);
+		ret = request_threaded_irq(irq, NULL, tegra241_cmdqv_isr,
+					   IRQF_ONESHOT, "tegra241-cmdqv",
+					   cmdqv);
 		if (ret) {
 			dev_err(cmdqv->dev, "failed to request irq (%d): %d\n",
 				cmdqv->irq, ret);
-- 
2.43.0


