Return-Path: <linux-kselftest+bounces-26092-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C9FA2D50E
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 10:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35BAF16A6F7
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 09:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833E51C6FF4;
	Sat,  8 Feb 2025 09:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UTsI5KZq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED851AE00E;
	Sat,  8 Feb 2025 09:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739005422; cv=fail; b=knGRGJhYsk35bydVDYhiY873Nqs8Ht4aZ4Ra034yDAiyqiYkI7trWd2S3uJCJ18O67PTdsSfFbi1VDYcG84inkYVR439NZb7kYEo5ufHkEO15fsJcuWZdTet2KG2nkwaAvz8psf8ZNvsp/9tkYrT8rpM7KDCbeHBP+fxXdskdIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739005422; c=relaxed/simple;
	bh=1+eOWesKVuvqeNkiiUg21K+tQI+6q1exNdWqThNj8uE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dAtVpyCbzEiL64Qe5DR99uNYNO807819mi/oB5j30uY/QV1CC0l7id1/TANqsZnHdx8kWzdmtBu+xOnMhT9f4j6SXSQDZAAFghnOHnU382Iar344VELwqiuu27ZraOkBzqwMSYbaxTUvbTB74J1+UJ0hb/mpPDOmf/HmkTaxT9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UTsI5KZq; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5LU1VzELO7u7B/QuDGoS3VNfa1Do9c6AgPkeLhgHBP9eC0dWuOrkCx4aKI5TqmybAFjw6c+WQDqcbuhgWmt+cEL/LMTojSbKth+HCWxqDDC4HfFUzxqB/xWYx1d4H3Vrpk6bPqdNBfUwddGLlz7LZHUMLqmFua1p7O5RX5MzWT2ovq51eUaMxQ2t1xR+P7e1E5foWy3dpgYymDQMJ+rUKK464KU845WFgJZvOJ6Ay8d/kF5OnYXM1rMvgUtofPe/6JvpZtnnkt9o2nyx+mzERlXb1sUxkMnru4g993S4puB8+H4hEDCkGqtUEnq2KAoSo1LUIYBOW8kBdQ9LAFw4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHRb2/rDTR1ziVcb52A/gFWpDhGXPSIt+KjWcDb0ugs=;
 b=BQ7P0YvXu///4qL1qT67ClrwLsE9S5MgcOrZpmcWS6COSuHXOVkFoGnUhKXv8jFGt97cIZJHgFCgWAdtBgwvupcU/7Dzp/ZIs/hvEd9wawp7uY1FNR4mSq+XTiBWBYQrxqM98VT+w+WlG+T9DpWno1uwexPOvLayc/qqoN8p81m7pPgfLDRbnY1yP7HxAhpkJiItEkkNmPaMesk4OZ9g8rKrrNe7w6bl9qehXtmWSo/OxU2esJnlSsdPH0+P1sLJQMpImQq0q4mg7eJ7wX8h4fBMN0WLFk2GQv5+Igo6XSCMRAZBntHqCaPMvJnofEOeu2dovsO7NS8Ejpfq4h/MWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHRb2/rDTR1ziVcb52A/gFWpDhGXPSIt+KjWcDb0ugs=;
 b=UTsI5KZq0uXtY9Iw57PYn4NCaTExlUo5a0qfbTr203RYjcw9o+WyaA0Qn1LYv2TFKnewFV5EoY21TV/5fXHNJZ8OSE/RjPJYkALpdPdz/WVzOR6T1XN5MN3qCRkfiiissB+mmziZsLNrXNVoxw7DNzIQhl8mv4u9NQ9aQGKhAAd7Cc31tjq2i9sUJeHywb6XQezXhV57idOA5Zcw3h3UXLNVdsAD70zsnBFHOFZxBTuFO81rBuK0cmtwmnzPxt9NNjsA5fE6ZqlR+kgJ+ZHHZs8v3KAPdTD4QZ1sbXcdE24NSGWSeNElUBKGqCUj4okL807cxiU8hEVehngeVNM4rg==
Received: from BL0PR02CA0111.namprd02.prod.outlook.com (2603:10b6:208:35::16)
 by DM4PR12MB5913.namprd12.prod.outlook.com (2603:10b6:8:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Sat, 8 Feb
 2025 09:03:37 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:208:35:cafe::fa) by BL0PR02CA0111.outlook.office365.com
 (2603:10b6:208:35::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Sat,
 8 Feb 2025 09:03:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 09:03:36 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 8 Feb 2025
 01:03:21 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 8 Feb
 2025 01:03:20 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 8 Feb 2025 01:03:20 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <tglx@linutronix.de>,
	<maz@kernel.org>
CC: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <baolu.lu@linux.intel.com>, <yi.l.liu@intel.com>,
	<yury.norov@gmail.com>, <jacob.pan@linux.microsoft.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v1 12/13] iommufd/selftest: Add a testing reserved region
Date: Sat, 8 Feb 2025 01:02:45 -0800
Message-ID: <4882654aa73b39756393b12d7455626a3837b52c.1739005085.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739005085.git.nicolinc@nvidia.com>
References: <cover.1739005085.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|DM4PR12MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a55aee9-389b-4649-d597-08dd481f793d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sg0WPKlvTh0YRIyQvhsq/Hfb230ckqPxQ+xToEHEhyc1QB7DtRepirNhCI8T?=
 =?us-ascii?Q?WE5ZfPabgC/ijup6/laQhWjpbshJG5oMoOUncTCFA37qh1XZFcCXyLXsrRhs?=
 =?us-ascii?Q?gUT0D/oQ1R/L5epiB/9xPMCY5ABOrzqFcg3ZGp8tnRCxleGW14Y+LicTZVzL?=
 =?us-ascii?Q?uN3X2aIQ/HvqUOVfficPk9d4eH90BQzs9cOTPsUP+lO4t14MQIUb1+o50Lz6?=
 =?us-ascii?Q?G2WVWq+7iW2fyDkm+CjuwOpAk3clN5Dvpu+HCXA8hRy6Ti3gjnCjq5XoS8i0?=
 =?us-ascii?Q?OgahBLF8gEqIDRmQDtTmwG6MUKyHrdvfgh90qiFc2HFIfnQ39XHPMbuXkrbe?=
 =?us-ascii?Q?g3fxrJtQPOFo8M2Pk9a272rwy8SnSNqlMpijBAz86PDmqKw/f7j5uvCJXbZi?=
 =?us-ascii?Q?QjJslIPXQVCOzSNSbXnYh79XhycwulWE13xMKIaMlZZ6fhPFvxP4LcyUnHQb?=
 =?us-ascii?Q?qdT3jZmu7aoisj4QiZxNre2iJk2RKIJqMadVrkrZvx6H2gjKpiPQfemPc5Y3?=
 =?us-ascii?Q?G/hUkl80uYs32QL8Sv7pbttohCpk7zY2t9/btlO7PqLmhAHwN+xaNZT/ORDt?=
 =?us-ascii?Q?U58uIPbF7DwnUq2gLNyTuEFpHP+2mqZU+VNf4CDpaCwnvXhxoq5klK112U+6?=
 =?us-ascii?Q?gsjeVdZl7hnnS9/FZt7NQr40prHI93QbutJwkCRulxgeTP3ppXjudNS7XGUd?=
 =?us-ascii?Q?Az1zEdlUyMs6Dscpq3ZUXawjVSgofTzSONUIFcfrO6wnG8gb3X2/fyjUepsP?=
 =?us-ascii?Q?VC/HvEzL9nRnv4EedB2OMHn183WcCI8PFvZWJZajvEFHfpkgwGDF71tUZcay?=
 =?us-ascii?Q?yz6epLfpwJya9ud7JdJaHa4D4rHr2nM/Ldh7ZlIxJ4x5P102vlmTxOS6KsEt?=
 =?us-ascii?Q?thBeU2w6JBwktiTFatt31ObrBx89zy0+ZrEbF3QmPFvFTEMS7lhW9qfTxVZp?=
 =?us-ascii?Q?qJ2pQ3UHnqKFXPTh0NGD809d+i8dLt1J3RQLocAKGtdhGCJhRM1S80H2yRlD?=
 =?us-ascii?Q?FpkBS+0132Bq0bgD2AXWAciqIiw8AaeEVYNsnGTXFYizdm4HOHcSUb6djXNB?=
 =?us-ascii?Q?IIJNzPpP0k6uoUfl5G3ZPuWl3NZpFc5SOX7H0/uWSo5rhxjGFhO0EkAkyE7e?=
 =?us-ascii?Q?ufiYWe33gnHGaSUqQBN/ZiPA+DP8Fh7CkdsXHRLxd97Orjd+PcxXvB39b52P?=
 =?us-ascii?Q?RbkWUVVDDmQ2PA/uGWZVIQQ8hUxJaU6SfXjjLLQRqt8r54lqj1IUAh/soYUr?=
 =?us-ascii?Q?itUYWMF9zLDRKvUh6YMdeDJNMeWWLRA6rHM9/4dvrT2HQ5GV0F/nxdZhOy+F?=
 =?us-ascii?Q?ss1emgs5Y999VoPeaNQvzQotJWoDre9/mZ89HH3eSjxIip+gJHvl2Fw0spr6?=
 =?us-ascii?Q?goOZPaM4vZNWdkjXV8OCQZEvrZyFYk7V6pIWK6HFPsKLT03uDfIKGga0T5mq?=
 =?us-ascii?Q?6p6k0lB7FgvPh2B41EguqrpFsF4TkWfAexUwblG13NwooK3hW55w7S9Ugy1p?=
 =?us-ascii?Q?r+aPMqNOADiEwlU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 09:03:36.9728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a55aee9-389b-4649-d597-08dd481f793d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5913

The new IOMMU_OPTION_SW_MSI_START/SIZE must not overlap with any existing
device reserved region, so add a testing region [0x80000000, 0x8fffffff],
on top of the normal IOVA aperture for selftest program to run an overlap
test.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h |  3 +++
 drivers/iommu/iommufd/selftest.c     | 19 ++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 02be242f8f34..53e2e30570fc 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -213,4 +213,7 @@ struct iommu_viommu_invalidate_selftest {
 	__u32 cache_id;
 };
 
+#define IOMMU_TEST_RESV_BASE 0x80000000UL
+#define IOMMU_TEST_RESV_LENGTH 0x10000000UL
+
 #endif
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 37a5cb89e27c..f4ac443d73d6 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -13,6 +13,7 @@
 #include <linux/xarray.h>
 #include <uapi/linux/iommufd.h>
 
+#include "../dma-iommu.h"
 #include "../iommu-priv.h"
 #include "io_pagetable.h"
 #include "iommufd_private.h"
@@ -379,7 +380,8 @@ mock_domain_alloc_paging_flags(struct device *dev, u32 flags,
 	if (!mock)
 		return ERR_PTR(-ENOMEM);
 	mock->domain.geometry.aperture_start = MOCK_APERTURE_START;
-	mock->domain.geometry.aperture_end = MOCK_APERTURE_LAST;
+	mock->domain.geometry.aperture_end =
+		MOCK_APERTURE_LAST + IOMMU_TEST_RESV_LENGTH;
 	mock->domain.pgsize_bitmap = MOCK_IO_PAGE_SIZE;
 	if (dev && mdev->flags & MOCK_FLAGS_DEVICE_HUGE_IOVA)
 		mock->domain.pgsize_bitmap |= MOCK_HUGE_PAGE_SIZE;
@@ -567,6 +569,20 @@ static int mock_dev_disable_feat(struct device *dev, enum iommu_dev_features fea
 	return 0;
 }
 
+static void mock_dev_get_resv_regions(struct device *dev,
+				      struct list_head *head)
+{
+	const int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
+	struct iommu_resv_region *region;
+
+	region = iommu_alloc_resv_region(IOMMU_TEST_RESV_BASE,
+					 IOMMU_TEST_RESV_LENGTH, prot,
+					 IOMMU_RESV_RESERVED, GFP_KERNEL);
+	if (!region)
+		return;
+	list_add_tail(&region->list, head);
+}
+
 static void mock_viommu_destroy(struct iommufd_viommu *viommu)
 {
 	struct mock_iommu_device *mock_iommu = container_of(
@@ -711,6 +727,7 @@ static const struct iommu_ops mock_ops = {
 	.page_response = mock_domain_page_response,
 	.dev_enable_feat = mock_dev_enable_feat,
 	.dev_disable_feat = mock_dev_disable_feat,
+	.get_resv_regions = mock_dev_get_resv_regions,
 	.user_pasid_table = true,
 	.viommu_alloc = mock_viommu_alloc,
 	.default_domain_ops =
-- 
2.43.0


