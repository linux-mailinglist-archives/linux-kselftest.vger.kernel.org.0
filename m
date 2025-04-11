Return-Path: <linux-kselftest+bounces-30517-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC31A8547E
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 08:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 456084C5B49
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 06:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEABA28A3FB;
	Fri, 11 Apr 2025 06:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s2kGtqtV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B87284B40;
	Fri, 11 Apr 2025 06:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744353535; cv=fail; b=J59ayAzNVhVQobLE1E3gUvJe+eJs+mANCFx3s5sTkiolT9IjS7n/cJxdYGdRXPxN0nsqcOD0RN6858GpqNaJRlc648xtYYkWNWatSLbkGeUsiBebFZ+2HKm8E2DSRH3v8S3a66zoTgZR7+IWXVPfE3KW/TOsTTUN715tsvBsXHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744353535; c=relaxed/simple;
	bh=siNVqlqwBFScDOG9zjJaFeiENNUR7ups28x6GGTp19Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MAXPkRMRnoK4OvqFzpcmXpgbT8cEh/NzWtl4LfBuVQwImMzq+3owaw4r43CpeD1sB8L6V3oMo7IkmXdXr42v1m2QZ5ic6wTass7IzRYhS8h5t3GtJpVXjtxpomltVa1LJUUS5WFU6upysi0JTu8ewFMpopcmZPyl/9tXu/YgGx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s2kGtqtV; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xz4i9GQW8RkzDr9/bQAIlDAWpyBCtjhdynJpLBRMuLRUjh5EDAHctLKQYT4EfIBJ5tZmyE/L2p+vD0NtoMnoXcyzNqhBndqVHOEY75YLHcEgQ44F3OpW4M0+6+tPGKwXB5EhC+mzsS4H/tEVf6cTWeuFPZaYY1asGmwNNHgMhajixgb1Bdnf2yoHx0K0XojnCRV+YUtycKIA9AX7K2Y3uKQP7vmG3ODk6p9X4AsAje7RZ6UbLHSC0qC9RuONRXbYCOZ0J1u4/d7LXqZJkAaf1z8BRJtTZrnhNIQaPYTG97jqOb7dtWvaqVkoksLRE980qVncwBgZc+I4W5R0T4jQ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhJ4jHPIPfd9sP3ZZSE/RbD4k2DOj2ay/A1QDkWgtvM=;
 b=NIqYYpznNd56UFNrwbvRYsd4m1hlvQyCMhwUe0QCnKmvVTlEC0L3A+rkCJPaID9708RdJ+5EnoTtxvkIGifcR8qCzcHfmmqNUCzCEXvNIvcolDm0jSRDZ4xWH3+aRWHrbbW4JxfFYxu7ghp4QiNAXKLurAPqeg7glfiLj2IQmRg5DRqJc3UHm5Ssi01UJeBX7rok3WRBVGofwApTqK20EDAo0Sj9UNRi4tbrP7zLFErWXGdjOdT61l+MDplraimdORtfsOwvvrxSisCCmiLOgf4zZ+kdHCRIj18YoqUpEaGhLywNQlSdngEo3tBxmuLXHVWWcg2ABsAFz+c2ZndMlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhJ4jHPIPfd9sP3ZZSE/RbD4k2DOj2ay/A1QDkWgtvM=;
 b=s2kGtqtVN/r5TI1a9ZMKFG4nOZj3k9bXWDux1wHWVzM7VzplNo495fCn1bblmZjusaakm0LRLuLguQaXUQBnVH/ftZCesJytNk7+qveP5PSHr1PpbSYOVqlJ28BfnXtnnXrRgI4ZrSLpARsmfRKBznaD9tD6ThD80H1XKTU51PX0PNjyVvQ2pJSqE8RGkTT3rE8nr+EM/xgbOhAb9b3sE4Tx46rotFqrVz/xvaOPk6YI8qCM0bHUV02ED/fo28MrzwWIssa5Ap4TlhfEuVFoyPBrZssXkwJjPulSVJd0G3D+H9I96+hrNhN0oJRZv+hmvaxUgzLZTypBFo5cr/fkWg==
Received: from PH7PR17CA0040.namprd17.prod.outlook.com (2603:10b6:510:323::26)
 by PH7PR12MB7793.namprd12.prod.outlook.com (2603:10b6:510:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Fri, 11 Apr
 2025 06:38:49 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:510:323:cafe::7) by PH7PR17CA0040.outlook.office365.com
 (2603:10b6:510:323::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 06:38:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 06:38:48 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Apr
 2025 23:38:30 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 10 Apr
 2025 23:38:29 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Apr 2025 23:38:28 -0700
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
Subject: [PATCH v1 13/16] iommu/tegra241-cmdqv: Use request_threaded_irq
Date: Thu, 10 Apr 2025 23:37:52 -0700
Message-ID: <a9d379e8150ec22b46af005962178b47e0c1b0b7.1744353300.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|PH7PR12MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: d54d38c2-5942-4083-a508-08dd78c38463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ht6ikZ+3/DK9SwXzO6+Ui3t5U1N5HnSUPgeaJ2ctDh3KbpJ3PSiX06ZQzizd?=
 =?us-ascii?Q?69m1dTIaDxrFYt2juxFaXw9iXRgbERdzIdqVMojDrgbDpmwj8+eUrvRc5FCo?=
 =?us-ascii?Q?3ZXGce9AIIJ6zCjuSNPKkVIJtSvRKPFXJcDqWspE1+oWihP2QwTh2SPffliK?=
 =?us-ascii?Q?oE728TmJQtqJGa6fau7QBHMqAtN5g2xWz+HB7agFbzMRMMifqFZzdZasrBZI?=
 =?us-ascii?Q?mPQYxl6d8JlInJwYfNtFQXXLLjczkVnrPbkaNhGg6K2yN1Q7bzWV+7tPw69A?=
 =?us-ascii?Q?4kdRdCFiC5pPhGvqvIKDoJL1xJZSwytRcsQmiZGg3j4oyLorzQt9cAK26pHW?=
 =?us-ascii?Q?oLamte1iLEejU0RIck8LhppBPG8yZ4/Ga5IrLdGTLk43N15p1eisQvlrrZun?=
 =?us-ascii?Q?6W4sz53tTLGQsCqOAFn/a+rI1KAYXIObH+xxwqgBkFfqokeWNfM6JESTDkp1?=
 =?us-ascii?Q?fa4gAEh9Pn0jPrgOR+1TYLbxzKfO7ccWSJRZfdFD5k64Nysi2YxHGteMEBzk?=
 =?us-ascii?Q?Mj8UxoffZASR87mtiTXw/AbVwhOSRaeUsCL3cVaPHwaZgwFedr11KZIeegrN?=
 =?us-ascii?Q?JnEKuY/GdVJv1rg0zx/aKsUsp5RFEpoFT2+kdXzjeW1MV950lUpRyw+2x7SZ?=
 =?us-ascii?Q?1oKQuuGPwpN5k70hFzdlzd2PErVrD0pc0llOFAPFiNZyCM3Si9DFf1hWfkiP?=
 =?us-ascii?Q?BZEfECLQNTlTBatjXUmg/i7wtQRxhvrs1dxjZrSsc+lWkwydzC0jurtByMAA?=
 =?us-ascii?Q?HKKnweFKCRDabL91N9KzZuoTo+l8jLErhngr045wqfdoCmOaJ+qmWu4N0x+U?=
 =?us-ascii?Q?1JNtmyOM0otwLYOqXYCLC5KLgrGYKgsb+XWr2PNXBESznhoTXSJVyGb/MHl4?=
 =?us-ascii?Q?GgIIs1scGBvdpYA+KQPx1RtqgIVSyf0M03SsTGfJEjFOoqMSHcD1MwiS74U/?=
 =?us-ascii?Q?u2Sw4ijqwcAMV6VNtxMHtIGbO62f4loX0UTul5vkhEo8KUYkiy88DsMuWnu1?=
 =?us-ascii?Q?Tfc/sC5xT7otdV1LdH/11eo40jnrRWyhrzIz00AK5ixFALOYc6v1u+ppFLZ4?=
 =?us-ascii?Q?kVNm7mPpkRqnqhH77EYG/nzzIjKM5ZW9NPLJIZwlZR7NHwig/+RMR3Q++yWQ?=
 =?us-ascii?Q?bcdz9motMpnwNTS8C5Y7TveGNhGrp+C0nBB6/ydYByFpv3jk8L/p+4xd3kOS?=
 =?us-ascii?Q?DWAisQ0lqDjxwMigY1Iw6YCW48R5Qbh/klIOUw1Y94wNhOegXEYfpNqZC1SN?=
 =?us-ascii?Q?DW1zmi7ERmnPcw/4GRxO6ioqtpWTLI3hDIyvv28xrvjkB05Hwi+Hn5H6DNtV?=
 =?us-ascii?Q?AD1a1cubBu1EpyW+YZM4XE2dxIdqgIa91jsu/oXgeYZovJlyUnpYUZmlDxeX?=
 =?us-ascii?Q?7hpIwyZRWU9Yc3dZG1UiCpx03Jo+6pTcaYfsvcWDLqNbEjcgygI0Ni/Wbsg5?=
 =?us-ascii?Q?BO6TmbU2GeKOHgFVqpzjI5MtrVazs8NaejcA1aIDWgQTd6pqfc4aV2ENJ+k7?=
 =?us-ascii?Q?bVY8Ygkbn6aAS0rFp/O1+DIXov5wuzBzPAzL?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 06:38:48.9994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d54d38c2-5942-4083-a508-08dd78c38463
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7793

A vIRQ can be reported only from a threaded IRQ context. Change to use
to request_threaded_irq to support that.

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


