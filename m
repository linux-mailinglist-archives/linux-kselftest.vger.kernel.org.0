Return-Path: <linux-kselftest+bounces-35911-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 398B9AEA6EC
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 21:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768C91660D8
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 19:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A13A2FD868;
	Thu, 26 Jun 2025 19:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ExZWxPgq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382192F94AA;
	Thu, 26 Jun 2025 19:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966566; cv=fail; b=uAk9giYrmL0SCMkgCyVC13kihPLY6IAqVgOPHCBJo+iyB69TFE/AMkHCdtKIQTpkh08FbMssJ7rbiaTJKpahF0SL81JFcdsdRszcWxMMq5QQEO82xwhWvgK6gv2tQNm/WrEZytIytgR4DnSY3m1EFTwa8HcnLyDh4bOut6l2qfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966566; c=relaxed/simple;
	bh=RgTt//w0Aa258Jd6p6y41K5Ak6ceIvKnbHdK9u9qB2c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZYTbifNL+GZns+LIki/S2xfMeDClxD5tMaN/YqQq3CxDpn/VQ3D+HkvNniQKIyOTkDPxY4SYdto30pbn09PwiRmx9OObKoKXjoy6uIFMO7RvnYvl+SC2Lr4gZlgyQ0tc6l4BazHR+tLrlHsgV7THS3lSIqVI1nMbBg92suH1h3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ExZWxPgq; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8wUnXOkru3g34ONiLo0SJuV/xr/c74HRF3KHTikYuvOv91uRWCHljZ1PizzT3NcdX7CNXqhsxGdYZ/uLvoTYZMyf5DJ0p8ADQe6HtUbRKxPzB6qzsPZea4ZEdfaxHFOMq/Zx6PW3tA/aYzXtNPMMqM06VaDkb4UocqUaz5VmMT5J7X/GD28NF6fv6OS4Qpx5FfyWoG3L2SYU49gQu9qaeNTNgc5duHDuJW7I+ersWG5bNPMbp8P2mjnhKjwiYb1kNBFN3RPrJIrJsiHJi4DR1ny6iHggWDKZEQ4eD2yTnEnAFNCu4ASEgh9Tm//BDk/v9sW9vqFbqPbESTs+stqxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tM5a/VpJnPOQ1SwAAILFReHvHS4NIKun00hNORa/tMM=;
 b=CoPUwt6LvOZ+P+Bj/LJedxoROkGjovXY0Tu7cs7f5avVyJkfnhZAoO51Bkg8V8na2ROBEjb7Ess9W0g7cmm8Y3YvbDZLooJAhCMUrIVmqnkFK9+FSwrjo0ccT7Gzr/qjePf+ltjySJQ6loPkbwtLE+wtM9sEuHdHNsQ+pHNHyMjPw0Pq70Vs2rer/Y97yfJB23EvtEKOsn+twL4iIYMrU2C30GSwLML6/T+qjrvlfXVXdrvSfMvgLWZlpMuQvglHpkjBTS7d31ZyEfUu1XQJpa1FiGNYGa//f1kaxev4wyWmIFhMLlmKVXsn9vmepDwGCiS4C8sVZNP/mxfjvj2pzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tM5a/VpJnPOQ1SwAAILFReHvHS4NIKun00hNORa/tMM=;
 b=ExZWxPgqR1J14KpuVTXrT22AVlK8uoi/xpIX47FzTV0NT1eO7CzPXke3NH75196WH6yOwH+H0tWCtiFneinSNaD3QhYeJ9jLuxmbzVdTjLOGNLHdiLHKGMZHV0q5NpPqv9pYQju/ccGSJc4+7DOeV4smlx97qzqqpUGr7s+0Nl8PTkH+cgExSzWiTkXheneY/sisu2Qd1K4fscT+1yIZx0Z8R0+gJV1j6jD/l4rWSGqjHujqXhbbD84InZelWXP9qSLF/+ggmaVEzMNM/3aErXRUzn2NN0e7KJwYieZHCeJTjNY0DXxRGimUFiZS27LHBNWkX54qwN8ABzFDKIF14A==
Received: from MN2PR01CA0042.prod.exchangelabs.com (2603:10b6:208:23f::11) by
 DM4PR12MB6399.namprd12.prod.outlook.com (2603:10b6:8:b7::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.28; Thu, 26 Jun 2025 19:35:58 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::d8) by MN2PR01CA0042.outlook.office365.com
 (2603:10b6:208:23f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Thu,
 26 Jun 2025 19:35:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 19:35:58 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 12:35:41 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 26 Jun 2025 12:35:41 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 26 Jun 2025 12:35:40 -0700
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
Subject: [PATCH v7 24/28] iommu/tegra241-cmdqv: Use request_threaded_irq
Date: Thu, 26 Jun 2025 12:34:55 -0700
Message-ID: <4ed4bda81a656eee60635f7d706761ee33a07f2a.1750966133.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750966133.git.nicolinc@nvidia.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|DM4PR12MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: ef6290a3-0224-4e47-db27-08ddb4e8ad2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h5AK52igxpYxgFIHKWPyxvSQFcqMIU0P7JOZjs6cls513ei8PEw5wC01S9Jk?=
 =?us-ascii?Q?SOmcnHhkcuu5Q2W5r+b7Pnpb/gxwH83NJrDF/5cp7LAdGUwSCj2FibTsXfs4?=
 =?us-ascii?Q?4dMyK6JGpB+p9ooclehBN2xBWiUvxqbEzJFPUJeg4l7NJ2MPJzWnRcBDCp5b?=
 =?us-ascii?Q?aWVcC0q5xAGUAQRWnHZcI1mzgz1t9qjASldSfsmF6+LTibbndQtI9LB3F6yY?=
 =?us-ascii?Q?2RAzMTi+BEdSUSvzKznnIZMz8v3WT3l8k/+207Zw6cIZwhqSUnxCYDZqeiyW?=
 =?us-ascii?Q?nvhavcaGfLcDjYNjgnouEwgC/1Ls1ONAQ3X00VrlmQHhoR8aHVHw6NelAwOo?=
 =?us-ascii?Q?I04iPMKcfFZaXwVUlr6nWE19IQ666InJQOThPOapmAdaUbnMcAmkK1ODGbkP?=
 =?us-ascii?Q?/7Fg/U8wV1gpu64LlmI48ZllNpqXYQjAjPd+sJ+WfmZwGHM4cR2KfMAD2546?=
 =?us-ascii?Q?/1TellzJtdkz0y1T8BqbEmPKD2yJ2jtLmqf9E0GVdkJe/PoxkdLAXvGH42/4?=
 =?us-ascii?Q?O701aVT4Mnx/LsilYxbzmVs6iE+NV7fne9PiTDS0gqGVkisewREk7GyRrz2I?=
 =?us-ascii?Q?GbAyIezuYjpKsjNXEn5z9rNdKGYRFgmH1fsliqujJh+74YJEl12UKnGsihef?=
 =?us-ascii?Q?HMLiydB2R1JJiy2+bjPNuvItLPIX22ZxKES/RPbOMdE8VjNee5Eku4G4DYkk?=
 =?us-ascii?Q?GYGxL/o+S2k+bH9F/xwWJ07sPEcuUoysLbSg4Do0+A4q9Y16STssF0AUDShd?=
 =?us-ascii?Q?twqF+Nj/mopr2vwdYJzdiVCSCX0yIKV46WGE8hqh9Ml1q2b+auwVyCJ/mHQ6?=
 =?us-ascii?Q?GQcXwJLOTSP8xVe+IvLaBEJbwSDPxx/GIx04/gg9gRgapyuB+VqzIhXAP0NU?=
 =?us-ascii?Q?Tt7xaB25clHrTDy68BhcLUHTVlBU0J+yxB8c+s6M5WaqWnzKSYbzB8umYHeF?=
 =?us-ascii?Q?sB9cvpF1tmUz2I9nCm9lkcNJ2HUmU+qgjcsPu3cOrZO1FqmLmX1/cLgOu4vL?=
 =?us-ascii?Q?SOrwLELAcp6WkF8sfiJLMrodmmwB6Z1mpwcnuUMVCnbNK+dIfOWpP3Lk7lS6?=
 =?us-ascii?Q?7zCyD2Y0XS9K9kiQiKYpUpV19+404YEHXIpMQNBQCyadYcEr2BtnZL3K5b84?=
 =?us-ascii?Q?SUUBqnT23asi3nxTZTj0+rxjUR4Cd/3l8pJrsMVtjqY77q27dHtSGgYzQE1r?=
 =?us-ascii?Q?nkH2D9KYw7yFXDnqyF85zaGmSls2H2wEf7OPdMY/ggYJzaWp0THYOWS5h0fN?=
 =?us-ascii?Q?1vW6P6CA5fYUk4k9QiHWmrTAa3lahCZFixd5F5syFQjxorHmYwt2PL8Xm5Rd?=
 =?us-ascii?Q?UjEYl6YnUoET+wdosruDtfQ2qdUi3AILozr9Ql1MiqeCi4Bs0GekkTvJGgE8?=
 =?us-ascii?Q?gHwcxiPmvoFNJyg/lhUdnMgyiDVqHDhJ7ubKrxPpowOhRzjPfi9QotrWHzqC?=
 =?us-ascii?Q?hJZAzDtymHuh5kyM7X63cvv3hYrAEdd7MuPKGdnCkTSDwdov5zRNJs79IXOp?=
 =?us-ascii?Q?ddVoWGnVFhfmYH1b722S9IBnK0y68j3CNBSm?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 19:35:58.5458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6290a3-0224-4e47-db27-08ddb4e8ad2c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6399

A vEVENT can be reported only from a threaded IRQ context. Change to using
request_threaded_irq to support that.

Acked-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
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


