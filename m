Return-Path: <linux-kselftest+bounces-14744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDEB946501
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 23:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 402991C219B2
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 21:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37C01339A4;
	Fri,  2 Aug 2024 21:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ryyDANbx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFF5130A7C;
	Fri,  2 Aug 2024 21:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722633865; cv=fail; b=eqgEH0GYXk53xKq09SL0cSWQkhE148aBvoUpQx+lS4GSXMXsO3zN7JRk7YJqyILjySw2IP5lhCWeYNBGENMxf9230y6KAWSNT4dt6+P2d7nAokq046FnzzTQ8MVU2N7UCqBZVvn+5gqkC9+Jys4FSke43MOp52GXbFDC7+O0nS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722633865; c=relaxed/simple;
	bh=d8FzJLWfmZr7crqDkuXTNYPepxZkVYCDvmqTXq2I0sg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p4TjHSmN7tkPQ76b/5TF19WIFYhLM0zDHw+FI2GXvBvaYJki18UitUwnudxvBPINQ+G2o7Q9Y5EhBD/KgvtYQIridIcczgbKeAwjWMWScUD6uN7vRS0E/qtZZI94B/WNUXNRtWqUcVVN/cKkYEss+N7OO42toe9lWM6v5nmMcrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ryyDANbx; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HIa54EIaJvtKVCsa47IVuffxYYNFOMt5uRBM7q9vTeq5IM4BhQz4EDq3hoymY2oeWnyoDU7b40u/7znMgthZBUPuK4vWMr5VFYBRBufIY4bnIawd7ciWCjuSTSJrs7QtEqdSoP8EUm9Oepqsm45YhAfZ2Gz7/GEGFw9KWzZWo072kg9wE5tiwUcAmUjIUlJuTDpfiwqY/5sRzcKYa3x0LjoZF+jV/l7dzCY+u1I/VHhMjZrXo8wmSMBBJgM+TqdiciL69P4Hpuz7LakEVH2AdB81L3+N7Jf2bFHbu4iYdqRuuyOmJMrEc6KjiblfAyHu0+0C6zHkVEbZm8GJR+4wag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLD1uSGDj5q41eX1MX6FQnqUcRtuaIH9gQWuG36ffVs=;
 b=l7mosx8oXyeNcLEPAGjZ1zz/+xD9W8I1GaxSp5H7hOuke+fOxjZk3ChRe0pVOqGoMWahlEanXDN7xNfWBWci/U04U3VA+B/vazle4cRcR/D6CWI3bMaZx9px9dSdxFLYx+WPrsAKcoP4XVcRiU7wD0g1pfuxPVZ3bNmWl3C09kSCf4dESuMkcmfwacBK3CaTNFVXv8LIdmjKpb2MQaRZkSIY3w+Txfa0I9d4V/4TCYabLMG8qfa3P5c5lgGMD57j03TIaKLNOqZUCeZXWvlt6jPdLVh9Iycv3fuCRBpU2Fs0FCyza2NyXfFoSmOgFmITbiuteZzYgaHJax8NL7VDkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLD1uSGDj5q41eX1MX6FQnqUcRtuaIH9gQWuG36ffVs=;
 b=ryyDANbxhppPbOTkEfAxGNRYzbnixDKbhhDgvexJ3P18cHLhE6r/FJyoiF9zNqYlsc/QRomBwiTn5yCIEyEFHIQm+GZeyzbicFvFy8FH3jvsSFBIvQ9vFY3tDfKp0klkgfbbh+UKYKSjXJMaIH639HKNmxX6rX6nrJ1eCYCqHWwUfOnYZ2vGWwh1AxrCzt9GjLtgqenoduVbN0owK57OTBoWMZ+fzKJCQyThTky/8WWQz/57D/euNR11oS0fkv6f3it7tBMQq/UDx/fKfyWiE8fqJ2kafgjAvR1h3rTDQeOvA/w0R45URtQ4Xav0GEhld6MoMgC1szvrgyt28sw26g==
Received: from SJ0PR03CA0154.namprd03.prod.outlook.com (2603:10b6:a03:338::9)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 21:24:20 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:338:cafe::91) by SJ0PR03CA0154.outlook.office365.com
 (2603:10b6:a03:338::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Fri, 2 Aug 2024 21:24:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Fri, 2 Aug 2024 21:24:19 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 Aug 2024
 14:24:05 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 Aug 2024
 14:24:04 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 2 Aug 2024 14:24:04 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH 3/3] iommufd/selftest: Add coverage for reserved IOVAs
Date: Fri, 2 Aug 2024 14:23:48 -0700
Message-ID: <68e3341f9e993b2a248d96f7fee5104d485d4a03.1722633199.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722633199.git.nicolinc@nvidia.com>
References: <cover.1722633199.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|MN2PR12MB4288:EE_
X-MS-Office365-Filtering-Correlation-Id: c2372a5f-00b4-41f8-3e9f-08dcb3397872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5EJUABCraL801MHRwxZ8OP/0SHyn0GkHpj7An/Jx3mUiDw8dn1o+ML6lqzzF?=
 =?us-ascii?Q?3ILZHYKJ5fIlBagIc6fsIt/kDoUJ0D5looOR+HHvtnfjzxxYl/VXMIvp9x7K?=
 =?us-ascii?Q?/k0vTq+8LDk3OzKTtz5JJ2WMV/+rLB7sviZDrdoTMhmivuZez1xOOsUjOfx7?=
 =?us-ascii?Q?VcEUrNaDD2c29fHGgASezNsiuEgk2mFOAelHjeCblmFqV7NYW+kG9TYEebkK?=
 =?us-ascii?Q?utpCyYsj4UwBaVySEkbB2YFWgS4uaRH6X5UsHlEv5jP5osQU6Ey9obwf8npo?=
 =?us-ascii?Q?414Lz087XeCFealPJwMP4PJwE/klGp2vekeOwBeyaHkMTtoMDoizCoJpCQRJ?=
 =?us-ascii?Q?BWJAJzHzpuxk0LAwtV045jzmBbkWfg9yzblmkky4CVizuFTDXHnqObq1VdFr?=
 =?us-ascii?Q?vmG8ukI7Xe+WemMwumHq4Gq0rlMN6AwOHBelpTYII1aiyDaWDgi85uuA/38C?=
 =?us-ascii?Q?HloIHtSFPHU7ZehtSJuEBtfLbRV6t7cZVxwpJ9Xjxiw9weO4LBpa1IaVgBuk?=
 =?us-ascii?Q?9wWRIq3xM64VBOBeJda130+8CK7/DbjOgW6jl5/mBQDh9DJjToBjBc1zD4FL?=
 =?us-ascii?Q?4YBokEPmvN/7zeD3GNYP1jW2nD6Xw/5f/3IJIDU1MTipZxi3KA+0/A2B100g?=
 =?us-ascii?Q?3EOXjI49wK7W5w+FH4u29EaNZPUsRbjyJLNSzkzUlC208XxiGsvpSwgTRyss?=
 =?us-ascii?Q?LYnkzUPWVxGJRzkVXIpJBKE5PfcaK3SLPd0NgQLiookwiGVAlidJKsCBLnMU?=
 =?us-ascii?Q?I6QWpDJwM3C919h9uDm6X8z52MwfMxsTTSNMdrkejz1lBov6tNhWe2CkyjyU?=
 =?us-ascii?Q?xxn7YUoiWGGZa2ZkB4qiIIUjYDyTotiYnEpKyfl0v/6BmvCpar2gvyluHVeg?=
 =?us-ascii?Q?TIEZu1c5VS7V2mo95svoa0LKzoaYTqekWD1DkO3FZd1+R87EtQWDB20BAdO7?=
 =?us-ascii?Q?IN2u/kPlt75OsF0ZJFyoNd5zY4xfPvuZyrLk0QixomTiBTaj0UoqSvn+I6ur?=
 =?us-ascii?Q?JXHPcXhSpPcqSLMj+s2f1Xb1oGgrJc1AUoQLXdIBAy5PTXROHa/fAhP40OW0?=
 =?us-ascii?Q?qQUqcWv4jh826eIYhwc0zC/PaTG58Z3QwZ9kA9P0hay8Cti6zTzbMMaFi0fN?=
 =?us-ascii?Q?fu07MmvZ+G0PZBQAuDJOprH2VVWo4H0iC52LKHo/aJjlPvPyU98a+NjgeBJH?=
 =?us-ascii?Q?TeRbx3sC/GDvLndCRjzxiiurA8PH5lgGXw1EfTqJ0hOWrYKgi6LrRSC3iMC/?=
 =?us-ascii?Q?RbI376ecJpLUwbeBkwHAdo7H6bKJmQ+q40+JwbVD6YDqOMRUv49ERZXPIXju?=
 =?us-ascii?Q?HOKY2/0yVOAB4Jc6LgtHqwOGdTWUjaUM4Z+PCBPc97Lpo6cCxQncgN7Dz/x9?=
 =?us-ascii?Q?4llfd+5y6KzCDZWoxJ4NRGixUrnyDGCY88WgwkUlkjNt6gJEWYRrogx4QktX?=
 =?us-ascii?Q?8oE6cr/4Rl8LBRdCZ5UhN4OGQmIu5cnh?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 21:24:19.3466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2372a5f-00b4-41f8-3e9f-08dcb3397872
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288

Define an IOMMU_RESV_SW_MSI region (within the mock aperture) as the ARM
SMMU drivers do.

Implement the get_msi_mapping_domain nested domain op to allow dma-iommu
to find the correct paging domain.

Add a new IOMMU_TEST_OP_MD_CHECK_SW_MSI to loopback test the MSI mapping
using public dma-iommu and iommu helpers.

Note that iommu_fwspec_init is a must for iommu_dma_get_resv_regions().

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |  4 +
 drivers/iommu/iommufd/selftest.c              | 78 +++++++++++++++++++
 tools/testing/selftests/iommu/iommufd_utils.h |  9 +++
 3 files changed, 91 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index f4bc23a92f9a2..0bb30275a92f7 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -23,6 +23,7 @@ enum {
 	IOMMU_TEST_OP_DIRTY,
 	IOMMU_TEST_OP_MD_CHECK_IOTLB,
 	IOMMU_TEST_OP_TRIGGER_IOPF,
+	IOMMU_TEST_OP_MD_CHECK_SW_MSI,
 };
 
 enum {
@@ -135,6 +136,9 @@ struct iommu_test_cmd {
 			__u32 perm;
 			__u64 addr;
 		} trigger_iopf;
+		struct {
+			__u32 stdev_id;
+		} check_sw_msi;
 	};
 	__u32 last;
 };
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index b60687f57bef3..5fa8d204bb098 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -7,11 +7,13 @@
 #include <linux/fault-inject.h>
 #include <linux/file.h>
 #include <linux/iommu.h>
+#include <linux/msi.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/xarray.h>
 #include <uapi/linux/iommufd.h>
 
+#include "../dma-iommu.h"
 #include "../iommu-priv.h"
 #include "io_pagetable.h"
 #include "iommufd_private.h"
@@ -539,6 +541,24 @@ static int mock_dev_disable_feat(struct device *dev, enum iommu_dev_features fea
 	return 0;
 }
 
+#define MSI_IOVA_BASE			0x80000000
+#define MSI_IOVA_LENGTH			0x100000
+
+static void mock_dev_get_resv_regions(struct device *dev,
+				      struct list_head *head)
+{
+	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
+	struct iommu_resv_region *region;
+
+	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
+					 prot, IOMMU_RESV_SW_MSI, GFP_KERNEL);
+	if (!region)
+		return;
+
+	list_add_tail(&region->list, head);
+	iommu_dma_get_resv_regions(dev, head);
+}
+
 static const struct iommu_ops mock_ops = {
 	/*
 	 * IOMMU_DOMAIN_BLOCKED cannot be returned from def_domain_type()
@@ -557,6 +577,7 @@ static const struct iommu_ops mock_ops = {
 	.page_response = mock_domain_page_response,
 	.dev_enable_feat = mock_dev_enable_feat,
 	.dev_disable_feat = mock_dev_disable_feat,
+	.get_resv_regions = mock_dev_get_resv_regions,
 	.user_pasid_table = true,
 	.default_domain_ops =
 		&(struct iommu_domain_ops){
@@ -625,10 +646,20 @@ mock_domain_cache_invalidate_user(struct iommu_domain *domain,
 	return rc;
 }
 
+static struct iommu_domain *
+mock_domain_get_msi_mapping_domain(struct iommu_domain *domain)
+{
+	struct mock_iommu_domain_nested *mock_nested =
+		container_of(domain, struct mock_iommu_domain_nested, domain);
+
+	return &mock_nested->parent->domain;
+}
+
 static struct iommu_domain_ops domain_nested_ops = {
 	.free = mock_domain_free_nested,
 	.attach_dev = mock_domain_nop_attach,
 	.cache_invalidate_user = mock_domain_cache_invalidate_user,
+	.get_msi_mapping_domain = mock_domain_get_msi_mapping_domain,
 };
 
 static inline struct iommufd_hw_pagetable *
@@ -701,6 +732,7 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 		return ERR_PTR(-ENOMEM);
 
 	device_initialize(&mdev->dev);
+	iommu_fwspec_init(&mdev->dev, NULL);
 	mdev->flags = dev_flags;
 	mdev->dev.release = mock_dev_release;
 	mdev->dev.bus = &iommufd_mock_bus_type.bus;
@@ -960,6 +992,49 @@ static int iommufd_test_md_check_iotlb(struct iommufd_ucmd *ucmd,
 	return rc;
 }
 
+#define MOCK_MSI_PAGE 0xbeeeeeef
+static int iommufd_test_md_check_sw_msi(struct iommufd_ucmd *ucmd,
+					u32 mockpt_id, u32 device_id)
+{
+	struct iommufd_hw_pagetable *hwpt;
+	struct mock_iommu_domain *mock;
+	struct iommufd_object *dev_obj;
+	struct selftest_obj *sobj;
+	struct msi_desc desc = {};
+	int rc = 0;
+
+	hwpt = get_md_pagetable(ucmd, mockpt_id, &mock);
+	if (IS_ERR(hwpt))
+		return PTR_ERR(hwpt);
+
+	dev_obj =
+		iommufd_get_object(ucmd->ictx, device_id, IOMMUFD_OBJ_SELFTEST);
+	if (IS_ERR(dev_obj)) {
+		rc = PTR_ERR(dev_obj);
+		goto out_put_hwpt;
+	}
+
+	sobj = container_of(dev_obj, struct selftest_obj, obj);
+	if (sobj->type != TYPE_IDEV) {
+		rc = -EINVAL;
+		goto out_dev_obj;
+	}
+
+	desc.dev = sobj->idev.idev->dev;
+	rc = iommu_dma_prepare_msi(&desc, MOCK_MSI_PAGE);
+	if (rc)
+		goto out_dev_obj;
+
+	if (iommu_iova_to_phys(hwpt->domain, MSI_IOVA_BASE) != MOCK_MSI_PAGE)
+		rc = -EINVAL;
+
+out_dev_obj:
+	iommufd_put_object(ucmd->ictx, dev_obj);
+out_put_hwpt:
+	iommufd_put_object(ucmd->ictx, &hwpt->obj);
+	return rc;
+}
+
 struct selftest_access {
 	struct iommufd_access *access;
 	struct file *file;
@@ -1470,6 +1545,9 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 		return iommufd_test_md_check_iotlb(ucmd, cmd->id,
 						   cmd->check_iotlb.id,
 						   cmd->check_iotlb.iotlb);
+	case IOMMU_TEST_OP_MD_CHECK_SW_MSI:
+		return iommufd_test_md_check_sw_msi(ucmd, cmd->id,
+						    cmd->check_sw_msi.stdev_id);
 	case IOMMU_TEST_OP_CREATE_ACCESS:
 		return iommufd_test_create_access(ucmd, cmd->id,
 						  cmd->create_access.flags);
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 40f6f14ce136f..ab9fa5ea48915 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -130,6 +130,14 @@ static int _test_cmd_mock_domain_flags(int fd, unsigned int ioas_id,
 static int _test_cmd_mock_domain_replace(int fd, __u32 stdev_id, __u32 pt_id,
 					 __u32 *hwpt_id)
 {
+	struct iommu_test_cmd sw_msi = {
+		.size = sizeof(sw_msi),
+		.op = IOMMU_TEST_OP_MD_CHECK_SW_MSI,
+		.id = hwpt_id,
+		.check_sw_msi = {
+			.stdev_id = stdev_id,
+		},
+	};
 	struct iommu_test_cmd cmd = {
 		.size = sizeof(cmd),
 		.op = IOMMU_TEST_OP_MOCK_DOMAIN_REPLACE,
@@ -145,6 +153,7 @@ static int _test_cmd_mock_domain_replace(int fd, __u32 stdev_id, __u32 pt_id,
 		return ret;
 	if (hwpt_id)
 		*hwpt_id = cmd.mock_domain_replace.pt_id;
+	ASSERT_EQ(0, ioctl(fd, IOMMU_TEST_CMD, &sw_msi));
 	return 0;
 }
 
-- 
2.43.0


