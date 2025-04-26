Return-Path: <linux-kselftest+bounces-31691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 936CDA9D80E
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 08:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93EE89E0367
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 06:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2F6214235;
	Sat, 26 Apr 2025 05:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tP3860TH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28372066ED;
	Sat, 26 Apr 2025 05:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745647184; cv=fail; b=JLJgALvKsK5GXlpqiI8mmfjrq/bwa1wdkvtmDJA10MANunNO2DWBiJcEQC8zY31H6sNAT9UNa41orZHcX7zxUr6LvLe81z0WEIK1NnDxUg7M/3LO6eD7NIujlUTVAAd7eThBkzAfCWiGtY2sLt7U+YycehBXitz500wZ2ltmZnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745647184; c=relaxed/simple;
	bh=siNVqlqwBFScDOG9zjJaFeiENNUR7ups28x6GGTp19Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2gxl6jcHXB9SkDvIBHGbbg06YO8hnPgwrnp3mUc8O0qImFnPCfdpA5f54IFr7AXP907mgTKuJHJ5RfKQ/KzZMkrOg7LWpN1T4/3a/rGuE3soBnVEOJol+sfbpRfn02JSC5AOtgv+oiXka66XwTuBiLfdjHbg2HBcAltGi0F0Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tP3860TH; arc=fail smtp.client-ip=40.107.93.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anJ/U95JUhu91dMFBy0aH2qjQwS2CnzB5HgHzi+r6g+q49uScvWAXBLE72tlAC5ZXSwNC7+aF851JLKaVhyGuDPeANWYcAI6hvdI/XBeroW3DJ2eLzJYVtkYmLxslGEspn8ARbuuJUDvElmR6Q/eMCdAqDivloA6kMDGkOmbWwWN2vqPcoZKFoBALbH7/vECw8B7w+YNT+xMTFCuuj4miqWtia3PvK1xfkHpVnOqx4/i083uPW/HBxeU+QCdUmfO6lrdsDmz/n8kV7icZIuFPhqWAsWBZG55xxDHaKwJYRvlQsqaJnRQAn1wkED/wLbscFw1o062ILLuVZZ2CJrZgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhJ4jHPIPfd9sP3ZZSE/RbD4k2DOj2ay/A1QDkWgtvM=;
 b=DIDWtV4zhD71s+TGVjIuEXEGkbmILRT0jxk6lSmXEEJDcn2TpDct9Qp8Rdh1ZiYMf+3L51uTuZXzHJrcdAuB4hMesIIRuGUPIqxr1PFnCuptZpmanbI83gey4wgyhcxy6zVUQhlQ9Q8fuLc+9Q7uC1dENo4+hRMZkb+HfDxddUCxWfxdFk4skWo7ZXKPtwMCK4Teh1er0Jcyo0KFQCuA0NANvLzrjrUV8JcSBbSpCwQzDi7l/RclIs3DH2hHLyfA2TGTurAIbrDpKCClxtrpBlYdYMSmnGKdL9EsXv/MObgCI/zSFDZfFMUbP0nstgFS/Y4cmbsPJ525j19TJiaRMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhJ4jHPIPfd9sP3ZZSE/RbD4k2DOj2ay/A1QDkWgtvM=;
 b=tP3860THEmSAj68i/Pp/30f6AKgvOyi9cGZzo0LrnmRRxJtbEAZhFA21AOg0mrgBdajwngWGd2kB5UAk3tzPPJJzKSnG2mOIA7xdw1EIppDg3eEJpJ/m6JLKFe9m6qz+DBab298/d1ox59mI9N6J7WI5H7KFIgRwYFt7zYmR3JbGohqvYVK+38XEJt3DneRlFzr8Fkhlt5wZFNuofeTvYpg5gJ/Z8koPWPCMsZNq5T0cFrKVySd/f5GByiK5GZGmQ2i/Tef3mgVnc5I7eB6PlXxZUGO83v/GwzWb1AikAUvkuwrv4FcU7lJgv+H2jyqsO4fJHgummA3RpAxES2vsfA==
Received: from CYXPR02CA0027.namprd02.prod.outlook.com (2603:10b6:930:cc::17)
 by IA1PR12MB6306.namprd12.prod.outlook.com (2603:10b6:208:3e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Sat, 26 Apr
 2025 05:59:38 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:930:cc:cafe::ed) by CYXPR02CA0027.outlook.office365.com
 (2603:10b6:930:cc::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.38 via Frontend Transport; Sat,
 26 Apr 2025 05:59:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Sat, 26 Apr 2025 05:59:37 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Apr
 2025 22:59:28 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 25 Apr
 2025 22:59:28 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 25 Apr 2025 22:59:25 -0700
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
Subject: [PATCH v2 18/22] iommu/tegra241-cmdqv: Use request_threaded_irq
Date: Fri, 25 Apr 2025 22:58:13 -0700
Message-ID: <fb97e2407ebad5240f3981bbf4121a75ccd1ea57.1745646960.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745646960.git.nicolinc@nvidia.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|IA1PR12MB6306:EE_
X-MS-Office365-Filtering-Correlation-Id: cb4ad569-f5fe-467b-d70c-08dd848786fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qjuKk0Bg2N9Zb0yme7eCYetBbwfrHVgqFr8F/UgocHllRbaWNOfJFrcKu3c7?=
 =?us-ascii?Q?pmX9yo0rVj0AOPaYAecZld01N1pg67fEAZgPXYv/H0Wzk6TaF5u725Nnbrz0?=
 =?us-ascii?Q?2cMP6kKsZM9haYgLVNHTEf13fIkDZncmACztmPLHl5Lwg1dOoQazTJoNRHYt?=
 =?us-ascii?Q?T751pVacKPBh2XO15Cupm4bbyJbTkx9LZwEXqywu1S54popRVbXRcdFkRoDX?=
 =?us-ascii?Q?hkso580id02YEjCVeyXSFA2KgJIluD+8F6yUYUUtZXsY9NBd8fiUWtVbZUGk?=
 =?us-ascii?Q?qFdcnqibpDJj/pQbQvQjvqrBfjUSnVYGBD5bM0EQiL2/C0bR6S1WOa1s3s4Y?=
 =?us-ascii?Q?EcKOjHO+5lt616sNuqHJWqa4AbntV/vCUePfEnk8e3+8o0QEzn+gxm+2ZwGN?=
 =?us-ascii?Q?tHsYeZ6TwOhwG32PZTuwHrXJPqE8JwHAr8OUOUSNT9Ly17n78S+rwVD4VMWx?=
 =?us-ascii?Q?fAtrXrbX9XVXCr2KQ5ervIJIeMHsobU6WjGC5njoIxpYTyvSD9VYD8u1L6iG?=
 =?us-ascii?Q?klLqpZEnUCNdO9aHkUWUSqvkkxN77Akay2gAdyvuHwlVFPRiOXZk91f1/bl9?=
 =?us-ascii?Q?8QYc4DqNz3Oa9qPv+zZUEskDXho+zldyXIPlCi1KLY9XZMifAfPXbfzqBWvI?=
 =?us-ascii?Q?vtZ3YlKUMKGtO5s2vr6m4cxPZWwLV3Xjqv4KnfnCFutUiHGbgBrj/AVrEdPm?=
 =?us-ascii?Q?3p3s0imV7qARkGebsSSKh7W9QOFK8dOM4M9gHF6KmjiGUZO3H7g88gOGJ/1h?=
 =?us-ascii?Q?CUawYukB6tmxneJNQaO1T9Uwlzww/KeNnSsTMtqau+o8EyzZcK1CEJw+MHpB?=
 =?us-ascii?Q?2UuRBaAzRTrZuuuDZr3mW5e9Ob2O02yMS0sI0fRreusnjpipXpj5Pr5HZ4Oa?=
 =?us-ascii?Q?k8eeJZgH0IIYK/NC8pigGqKUQprx4lcxvlSYcjDF9DkC3NacZ3hcFi2b3FyK?=
 =?us-ascii?Q?Z3iXtXXXfLxpSJaRzFe63QGwEMN95HQhnd8XzWiv8E20eKGJTdlnPF6oTWcK?=
 =?us-ascii?Q?7NpChp9vcB88xLTJ9DHBVzU0lUyn0/hcdV+gs0ijtmPtLqgnRZMoO6syMKBF?=
 =?us-ascii?Q?mT6espt9K6Sa+zUZav1uWBqBCFgcq5rT7lsMYvBEvbIiI6GSY93IWpSsuq/C?=
 =?us-ascii?Q?B7j5YUYpysRGMvh+Y/VqynQJlb5oxM1Pe2dNjvl4btsSBjNpg0HArvK8h8A8?=
 =?us-ascii?Q?lE+3aVle+HB6naoHfBY14r2zWxwfbQdOoMhEj2dujz7yqJl4wRcjic7h3U+n?=
 =?us-ascii?Q?HlQMEUv/jrMpq6E7rsIp6rkxjgVXSy5WSihJIP4s04QklZmnMnzZFfyxvrVI?=
 =?us-ascii?Q?KdVB2pMP1Pb7G2JNIQCeJcxoWPdN3S3SPeD/3izkKk8wB/QQPNKIbefK6fc/?=
 =?us-ascii?Q?67yeYcp/8xNRPrJpCUut3pZ2VY/GNy2k9yaKQevLOhYrFM6Na9bEW2TvZrCl?=
 =?us-ascii?Q?m4hC7mfquwgxqyzgG8EaVPMnWN4/REsDgF62zaQAdV1ELrbYdiuS/AnuJvQV?=
 =?us-ascii?Q?JG+FRdoGgfTGLINYaZX+X6CYAxjnzfRe5EAo?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 05:59:37.5306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4ad569-f5fe-467b-d70c-08dd848786fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6306

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


