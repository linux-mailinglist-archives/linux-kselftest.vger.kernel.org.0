Return-Path: <linux-kselftest+bounces-28766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2CDA5CFB1
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 20:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22146189E73B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 19:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8370F264A63;
	Tue, 11 Mar 2025 19:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jxrrug03"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A028226461A;
	Tue, 11 Mar 2025 19:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722335; cv=fail; b=sv8aaPUZFBI9NzpS7l5nLguqobBVGGFIr+HhBdisT7qQMcsN3Fcqh+n2rzXmiT2n4riMpfypP6Y1XQ1P9w41H1yR69kESiBBMu9fODZF5Sqb2IQVU5TX08DrfMuIAXcGp6Ip9rl1uzeb3HpQ16rfDXc/XfnmH4x+jiThmPaaIyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722335; c=relaxed/simple;
	bh=K+5L3HSdgIfiT/YMZGM1NRRJ+WNYbPntlxZb6t9GOh0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KDx/HGaXSacXeaPE3GpDCYvZyMbBMQJdMxy8BD5f6mUtzawCnGlvrdGdnplUPVLqq1aW8VkTTLcADcAmod3Dh4fsCT1seV9yeUkQ1mUjv45Ta6v5i5nb8DURjrXaN1OGPatT+p1DRFRrNi6BGVVLd6pyLomDd0sdlaisg8Z4GDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jxrrug03; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/70mEF+PT0Fut25SLEw7rKRW+2IxF1ypmZUmtZaq6oznv9TPdGAWwxPDnm3nxCaRlsGhIGe8pm6NjZDb0PfbAidPSRdb6m2OmKELi2ME5E42z32k0turNnh+zQK9z6fpAE7heldVmY/4OP6yfjzk2CGr39mUJHfRDeiz/fQar2bp8Y5Oeuby9uMMKhQO5llmNWybpoafLw6MUBPqOIHvaFVcv3KPAN73DPByHDGj98vd+r87Ud61rrjYMZJYDT+So1R9T39pBkzCRiZPu+rHJNeog4OY3vY3KqX7SVkXsntpwM4AlE8bJ6FT5AEw8kboMrwKIISGhjbrt+brfqLWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qhvw+OY5rWzXvgenwxNHj4+yj2zdbIVe/Hrx8rdxbSY=;
 b=sLUDllr8yobe7LGvwSpszNg6/Gs2aQpYmWQ/KXgCjAAaTGQl+2LSNOLODywoZPCH1nzpytVwBTRb1ulFGNuM9m2aSC+GMeUDDiav6hirNNZbtzQ1E4FhPJLqjCNt5wnGqOe0WIM+ubuWABviqskTDf5Q4O6SJ6RKS+UW5CmTBo4RkpRDGoHI2zP9PZ5vp2NYCUTtKP9TmcjBBcHUrxbUr7nU/clX9VzhTL1rMPCOlPnqEqV1wLFvhSBBwg/ddg4tPTRnHOqgWaibqijOCkymSL9tHv9RXpphFvTtClrhPIu3Ld310k6NJ5CyhxOxoZw1MlNSRNLWJF5sO9O56euCUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qhvw+OY5rWzXvgenwxNHj4+yj2zdbIVe/Hrx8rdxbSY=;
 b=Jxrrug03lCKqEEo/wpLJ2TbCVNt7SPj4deZ63/MFkm7kmrIe++z5YyTHOfRz5lTHqcWZEd3Lp8ZX2B+XwqxhODkQEF08ik9IRHVLYylvmkE+n6XmJeaSMI8D4+OmtTJz1icYv+uAbh9r3H9P3fyjEtKO9eNzmnlTu+fUmfhFQRHjXf5wvavD16SWT+NMJPBJBOu6IBMcqLdIMTaX6OpPX40RXmuQ6MjJM7ILD21UL3y4CJPSCsVPCyfm6I4KV53uuiGDLughdZI3yM77zOvMwggamX4x9XAwViVFE64gNiIDurykXrOnhmelONDTcVc4hp2hq4YTe9YvpGl9enNXWw==
Received: from BY5PR17CA0061.namprd17.prod.outlook.com (2603:10b6:a03:167::38)
 by PH7PR12MB6563.namprd12.prod.outlook.com (2603:10b6:510:211::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 19:45:29 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:167:cafe::72) by BY5PR17CA0061.outlook.office365.com
 (2603:10b6:a03:167::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Tue,
 11 Mar 2025 19:45:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 19:45:29 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Mar
 2025 12:45:14 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Mar 2025 12:45:13 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 11 Mar 2025 12:45:12 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <praan@google.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v9 04/14] iommufd: Rename fault.c to eventq.c
Date: Tue, 11 Mar 2025 12:44:22 -0700
Message-ID: <d726397e2d08028e25a1cb6eb9febefac35a32ba.1741719725.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741719725.git.nicolinc@nvidia.com>
References: <cover.1741719725.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|PH7PR12MB6563:EE_
X-MS-Office365-Filtering-Correlation-Id: 71232a53-3dc8-4130-864b-08dd60d54716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?avXwV5fn2xcFbR7gtB/hFyn/CchU6xlJalql+KAI39v1EqBc3TOgFy4IN7Ei?=
 =?us-ascii?Q?W/i1JzUZ+kscqKkGU8adF7w5gMuteqDsfG+niZq5yponNb8xBBwn6+THst2O?=
 =?us-ascii?Q?8lE3EcygZSCQfjDmVNsqji2ztL+GOg3L+MGSL1/6eg174WJWLyOrhuJ1cjMZ?=
 =?us-ascii?Q?fE6xziKMxkxHdBkgP7yZSojhlgXBH0XQnhNXzSgEuD/daRX/FJvmbSv4ByVh?=
 =?us-ascii?Q?uLHWu+tHVgxl2YyGdrpvoEealvEdWZ3Z37+44cbFx3ffbybjmclGEKTU/bfq?=
 =?us-ascii?Q?d6ki0gt6MSA2Udj6CLVDO18sIjuXc8xM50qRbenK2TB6dfF/wCl0tiDG8whN?=
 =?us-ascii?Q?baDWvoY9FQ+Cmpqz60DB7XXfO/F6bdSoBPPcG0JTlUEXw8GfEEJm69cUJB5P?=
 =?us-ascii?Q?7tMdiYMCyszklGzzoCL7MiWqlDgDNTgMYnuu4+uMQzKsC0R5yvwB+hlUJ+wb?=
 =?us-ascii?Q?zTWw9zs7rL4ICzOicjfvkoIR9adUOeDJhzbRlU/sBMAfJqD1r6JoStdRoq+6?=
 =?us-ascii?Q?RcmHCfNyJX+4nEou2Q9gxM1ZBGgbkaqd9GaCSDIMGoJk+KorT38vN70djcF7?=
 =?us-ascii?Q?yOBBC0PHYUkjJJtjww8coGRn4IKBjBuK3W1abFudgzj8rkezizfqBK8FCXsI?=
 =?us-ascii?Q?1HUp+Akn2r55XasFm845KZSnOEf1yr82aTUO6eUHWp2Uv0A/psCuXnBPB/6N?=
 =?us-ascii?Q?DlSdDtdi1gc9lG4mLucE6NZnxqFIhjk1I1oB82qABaxBrxqxDl6xPJpgm18q?=
 =?us-ascii?Q?RmW1/hurqw+Fn3hKnfjdr5FqjG3lMft0w/Z6nZG12jSRIyTTD912m4wFoOYU?=
 =?us-ascii?Q?lFaU3W0VW6vxW4ZeKpRy1pze7I7I3V8WzDSOZm2tAfqw+rGRWqix+HjPws+M?=
 =?us-ascii?Q?6OkC9EOK/qf52iY0XIjXYhUAXalZQaUYgkwieEhQV4yX3Q5kFCjCU6XLTllZ?=
 =?us-ascii?Q?P0pG7NHkOZji1RamoM+a+1kucDJGNofteJW3x4sPPqG6j9VVfMx+w5t6Hadg?=
 =?us-ascii?Q?ijS7N0/xyKBhof3smfbkQJyf4ft1sAtKKQIcfuALz2eYdE94+v+S+XKgAtlc?=
 =?us-ascii?Q?hRD9UNYRqio+HycgDUgpB8JWUG+IBIeWFZoQC13RyMl5kjP6TyywhmYsdT6p?=
 =?us-ascii?Q?Fn/7sSjR9xN0/HKMK7jv4FfEgTFCE0kjUtxQihiT8yLhvS1epBWnO1HTifzU?=
 =?us-ascii?Q?fErkeaJMwdOaq68x5h+ehKWkK51rfHW4q6dZBuhqVZgaO6mbre+kKnHEbBy0?=
 =?us-ascii?Q?u2UsNrpRQDlOC2OiJcyvmoXwaxeTglvPu7UeD7Qyqh6VvQmHlcL7qTfp5o+4?=
 =?us-ascii?Q?pY+oa8SUppPqFW+1tYt0MuwS/Rgbw8kVNQxQH1jjAhzMN3GbLakDuJlskR8K?=
 =?us-ascii?Q?7VTMYAEtnvBi44MIHZV8Kq9ZMA3Z4BoE2ZLkY0Qu/xRtc3qdForQdJWIIfQb?=
 =?us-ascii?Q?FurZBOU5due4njzqAZswnTeAC3xq4w9tgO6s+77qh2FYqz51phLGmQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 19:45:29.2968
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71232a53-3dc8-4130-864b-08dd60d54716
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6563

Rename the file, aligning with the new eventq object.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/Makefile              | 2 +-
 drivers/iommu/iommufd/{fault.c => eventq.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/iommu/iommufd/{fault.c => eventq.c} (100%)

diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index cb784da6cddc..71d692c9a8f4 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 iommufd-y := \
 	device.o \
-	fault.o \
+	eventq.o \
 	hw_pagetable.o \
 	io_pagetable.o \
 	ioas.o \
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/eventq.c
similarity index 100%
rename from drivers/iommu/iommufd/fault.c
rename to drivers/iommu/iommufd/eventq.c
-- 
2.43.0


