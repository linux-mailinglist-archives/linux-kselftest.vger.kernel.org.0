Return-Path: <linux-kselftest+bounces-14755-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE3794667F
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 02:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1821F226DA
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 00:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFDAD2FA;
	Sat,  3 Aug 2024 00:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JBasZBI+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97536FC6;
	Sat,  3 Aug 2024 00:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722645154; cv=fail; b=CLe/MeDfLbKkr/lLKH6eCYejbVu5YPw/lYYSRO5yY3oQ04ZQhx4YeJ3qJuIuuytPExS1QE138Frv0VCRaoMJ0WIvBsfNW/iI2Jpv30BOG6WdKAHosGVbzWSCQOYiC+Ymut2cMJ4GVDooPKDes1IFu9Y6YXOvBxutBQb5c3fq3GQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722645154; c=relaxed/simple;
	bh=YixJdtIXobkvoXK+XyYaCZU6ya02eUA/xqxtx0TmWPo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vFxInBFW/bynZqXfs6hT2UktH5jMj7Vesxfk0TXF050+tfGJTiJSfby+Iz5uP/PmxwKJbAtOfnIRM9L7567JniEwewd7jlONMQ/VY8ZaJ4zEEKmMzSE5+vi0EgQRxCKpdv93rkFLcGKRA/rw1HcbNyRoWQsVF/nqqNgKtdrAJxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JBasZBI+; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWexlP/laxkiXE3R0mY9kan/hJSqVrUmCIJImy61E0xr/nSFiFNZjZsTJMOqaG7EmqzF2LheLtINoAWE7peFWfyghdKDu+2/21LUr3/00bwHjqoMtwAgB2jcHzjGWnV77Y8ge0Dsl/M1P96E8Da30SwnwqyyZSpIxea7Zlz9o7FMJAkwzkhMerF8EpeE2h8IDqNOyzBpVM/LIr7QuS+dWVXFWPotdupQNRpwrVGyL8I2IWLnhaZPwrGDMdlIyLDjXf6f5xdZRHd9R1gI749w0Ex1OtHZLmHEMD9U35hskwxtt2LFRPifoZXgNi9vf/yDC3PhrU0OA08NL8FAmuPwsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyKbSRLcxpjuAJABAoNdsbM/zfIVg6EM0uht5imBjZI=;
 b=kIVxeXmnDWgDoK6LmDG5lRaA/HbNOgjLYAn820Ys6fy8+h+qbkqVLkbslV3YaDT7z+HgA7puy0C2ac4V8rNzt/qupic7HV9pK4Lx9dNEU5AqfbvmlJIyznTYKHXQpwANGowg8sd5x/Anf39B8r0tg2alnRtndfAr40UuJb/0Lsb1hBot3OAdeRzIiB7A67kFjxbhSnA40gCD/lWzqEDWwZMFQsyUJ7lRXTmP5OXgWqIcTi9nqttINNKOFMBq2HdmJgQ5/pXbtsu9w/dXbVZXMvsVZ+TtkvBqq2TMwBRfyOQUJyuB1tX/DwFmLDgcsYhE4vW79Nvj6WTvLHzL2d3IMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyKbSRLcxpjuAJABAoNdsbM/zfIVg6EM0uht5imBjZI=;
 b=JBasZBI+T4td3kuna4WSm6uXkaKAsB9a5WE+BzyoxBz6UfpaFbFU+FIXuphaZ+Zkmg2/OzzPfVlz71ZbuG9S23itSCzNHdBrPbuBRyufhX4UdfF6m04fmF8/sZTw3C0yX7zr/9cGZG3V4fnSotHXDILvxMuFeMgQvDiFlPYr3hRFgS5iXZPcuymqw8BEePCMRNero9PyztICpkWmNB6UDPO1S0v6ZXVq30hrTtbCNd5M69OS9VsfSv1Brccxi4l1YQ/QeTNnzKjy/An6CwcOzGfYgptFcBtZas+QjcVFx0fO6fyIBVc6xHrwkpMfr0mWXLHcYsMqlWm6RUutI+CnQA==
Received: from BL0PR02CA0020.namprd02.prod.outlook.com (2603:10b6:207:3c::33)
 by IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Sat, 3 Aug
 2024 00:32:28 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:207:3c:cafe::fe) by BL0PR02CA0020.outlook.office365.com
 (2603:10b6:207:3c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23 via Frontend
 Transport; Sat, 3 Aug 2024 00:32:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Sat, 3 Aug 2024 00:32:28 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 Aug 2024
 17:32:16 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 Aug 2024
 17:32:16 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 2 Aug 2024 17:32:15 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH v2 3/3] iommufd/selftest: Add coverage for reserved IOVAs
Date: Fri, 2 Aug 2024 17:32:04 -0700
Message-ID: <544ab894a301c83eb9f9d7a6326f4cb87f517019.1722644866.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722644866.git.nicolinc@nvidia.com>
References: <cover.1722644866.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|IA1PR12MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: e1a5ffcd-060d-494b-e9e7-08dcb353c16f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rw833wmtMHcSFgQH2v0Qjh98ShefDPtKvu3XC57jel0irjR+ibemdGSSi4XC?=
 =?us-ascii?Q?oDDTJnxLUQy3Ftpj6WCtix+dxfEHz4entmQ+VH6x9O5IBBbfz8Cst0G6K08B?=
 =?us-ascii?Q?8RG+TxCQooY8crApW5Dj4TupbgGij83TGhV4XiAvaRKuVyt548exGIzDgsY8?=
 =?us-ascii?Q?kZnYCldW9x2YwG0d1NdOAVLmCZmkIgZBFA5wEFDUqX2cjkJtGHbZBTzt3FX1?=
 =?us-ascii?Q?cgSnvikg9Cwblhf7dd8PafVS6pLrRCLpn8h2zEK6XqnfEygypv26UDljT7IQ?=
 =?us-ascii?Q?lPoIT6Gb2Qd+DVPAyvvlv6OqZheZniKo0gWB+t+CZSH8xNHTxlxD9idQoC1D?=
 =?us-ascii?Q?QIdyBllHsZONBjC3mR09+BUaBDBTlh9hEYNv4SW369lEvhhmFP6uLu6sIQXZ?=
 =?us-ascii?Q?O+oTRifyy+A29cF/+ouBTtOk+/T48NV7Dpnl2KifbgiyTOURlYoMRE4DPZXI?=
 =?us-ascii?Q?bZ5bFCqU2b3hVZzjUeaVfjXut+DHSyyW9BXAQdsnpWF0A7Ks8vvwuMw2mLrX?=
 =?us-ascii?Q?TorLnG2D067pzEAIuOlYv42rWJugqB0KuaiRKYxo2YD0t2jBJ1QfChc0E3a6?=
 =?us-ascii?Q?TQ0+Cg0vxG4Pi5IgRhybdRTZkCq1hspZKwh4HY6nXWuQeptQ2nHV+pvHknxV?=
 =?us-ascii?Q?mRwMp98xP1Lipz1D+r5bzaAgvr23RbxEW7s11RmQOPe8Mp8x+k5jdFm5qm4R?=
 =?us-ascii?Q?JpTwCc/3KEfEI/SluIeK7wwpObxbBAL2fDLki7UnBLV5P6qzEskr3kuiqD+J?=
 =?us-ascii?Q?TFND6BatVDbctma2vbUVipkA+bCWlfzpzw7Rl0lPXe+ZmANkVmw/BY0ckmqb?=
 =?us-ascii?Q?0A32Y4jzfGyhXs5eDkBE8wWKlbKbh/+qZfZSM7N6yvSe17t9c/xeh5EBA9yX?=
 =?us-ascii?Q?YoEze6cXLowFvL+divtJGody7tya6BHmvJyvZpBRDoZ/+sqwi4CShvqTrJVU?=
 =?us-ascii?Q?ax8On4/ghJJz9PViDo3MJT5FkJ4NWs+NdQuc1O6ZbybF/kkzu+9dEltmayAK?=
 =?us-ascii?Q?ygt31+gxufd6a5XaueEk5+qewrI0wxmxzZlIV7QrW91cvnYGOPY4XkJVrDng?=
 =?us-ascii?Q?IZ3rvi+8yuOepp2hzEgbI9W0cXGc9ZpOCXyFXXGaQ4w8Wmaagg9Jh6+Pk9cu?=
 =?us-ascii?Q?/BLZ5GSUyvrxr4Q+fSdebKBIal0+5yHBEST5hVjlmG0p0heRe8XqEtefXZaX?=
 =?us-ascii?Q?nz36L86AeZGk+img4vdcNk9dTEsJpCv5LFN8rulZY81E4fri2rBVNOH9qmYq?=
 =?us-ascii?Q?Z3VVzQu+2cVZbd9uvIuF1R7hy3wx4BktwnJYVzjElqB65KpbTjRmYLJbx3yc?=
 =?us-ascii?Q?f8F32kmnjO6Mua5bt35yjWeXSGn2D+GgqI0MwOtHtpNeSH6rkWfXvnEQopCf?=
 =?us-ascii?Q?qodVQswCtb+odWMUsvsrJDDRZIHGiLc71SmN9B7exGBeJX8BkMqJiIUcNoXY?=
 =?us-ascii?Q?BAhzUH9jAI8t6y+kirshQN5FxZcrJTOi?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2024 00:32:28.6731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a5ffcd-060d-494b-e9e7-08dcb353c16f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7541

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
 drivers/iommu/iommufd/selftest.c              | 84 +++++++++++++++++++
 tools/testing/selftests/iommu/iommufd_utils.h |  9 ++
 3 files changed, 97 insertions(+)

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
index b60687f57bef3..642ae135ada98 100644
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
@@ -960,6 +992,55 @@ static int iommufd_test_md_check_iotlb(struct iommufd_ucmd *ucmd,
 	return rc;
 }
 
+#define MOCK_MSI_PAGE 0xbeef0000
+static int iommufd_test_md_check_sw_msi(struct iommufd_ucmd *ucmd,
+					u32 mockpt_id, u32 device_id)
+{
+	struct mock_iommu_domain_nested *mock_nested;
+	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_object *dev_obj;
+	struct mock_iommu_domain *mock;
+	struct selftest_obj *sobj;
+	struct msi_desc desc = {};
+	int rc = 0;
+
+	hwpt = get_md_pagetable(ucmd, mockpt_id, &mock);
+	if (IS_ERR(hwpt)) {
+		/* Try nested domain */
+		hwpt = get_md_pagetable_nested(ucmd, mockpt_id, &mock_nested);
+		if (IS_ERR(hwpt))
+			return PTR_ERR(hwpt);
+		mock = mock_nested->parent;
+	}
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
+	if (iommu_iova_to_phys(&mock->domain, MSI_IOVA_BASE) != MOCK_MSI_PAGE)
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
@@ -1470,6 +1551,9 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
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
index 40f6f14ce136f..4c76689e804f4 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -130,6 +130,13 @@ static int _test_cmd_mock_domain_flags(int fd, unsigned int ioas_id,
 static int _test_cmd_mock_domain_replace(int fd, __u32 stdev_id, __u32 pt_id,
 					 __u32 *hwpt_id)
 {
+	struct iommu_test_cmd sw_msi = {
+		.size = sizeof(sw_msi),
+		.op = IOMMU_TEST_OP_MD_CHECK_SW_MSI,
+		.check_sw_msi = {
+			.stdev_id = stdev_id,
+		},
+	};
 	struct iommu_test_cmd cmd = {
 		.size = sizeof(cmd),
 		.op = IOMMU_TEST_OP_MOCK_DOMAIN_REPLACE,
@@ -145,6 +152,8 @@ static int _test_cmd_mock_domain_replace(int fd, __u32 stdev_id, __u32 pt_id,
 		return ret;
 	if (hwpt_id)
 		*hwpt_id = cmd.mock_domain_replace.pt_id;
+	sw_msi.id = cmd.mock_domain_replace.pt_id;
+	assert(0 == ioctl(fd, IOMMU_TEST_CMD, &sw_msi));
 	return 0;
 }
 
-- 
2.43.0


