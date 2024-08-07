Return-Path: <linux-kselftest+bounces-14947-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE2094B033
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 21:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBB431C22339
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 19:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A42145344;
	Wed,  7 Aug 2024 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y6TOY7jl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44215144D39;
	Wed,  7 Aug 2024 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723057252; cv=fail; b=e5mau/NYACLfb3MG2hHwelSJ3bGSv7EzSXERaMB+DxA/MOJckLUP4hp5FXZLEK/c7hUmtfv9AUNFqs883nvvvd8qYqIMjSEIC6r/IzHizCejH3RltjwkWMbLIAhwtgDWtgLo19kt6/0W/kwMlYtGxtnNO7GvFo+l15GogBpbytM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723057252; c=relaxed/simple;
	bh=22uuRlL9u8a7NekSfq8s4Hfwd/xI383yVclJxY10xLc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V+IOEHBSMyoslx3HpLwIyXpn9GToArn98rB1bR/l8w5S2jaGKz4oUJSOaEC5wMvg/u9KWnyPWs21p47B2+gIyLD7I44wlQRwDtYQop/gvlMHccvVp1uxX67G9jNQIjxnxtjiJ2bCoD7ou7+dqynAjB/oVeuQGoDQT84Dvz6Djik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y6TOY7jl; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9vWwsPzvcy3tYBlgWXoXPvtemUSRp8V3M6ujn/CKSzaX05NHNkoBO7mZKkGxS07uKuINr2kF5dQtPGQgzrMWArZpDP7JljYN6suN9fJzvaLN0nbVqIldKUHqR3e02/So7hTMPMqyV+eM7ao+GuP5CgTemFEquaCQhrfrrHQMNhls+OsFycX99/BIfSzxdl0EVIV4Gz9E+HS1IqGFWt+wKVx8cqcR9RkrwAXsyuTWoMBFRGRCmVlvECHzElAoDECNKsHlqyQBqMEKSAMMc5x5RTZkY7bPoktYI2KRhZxGcc5wW3sHLQuUstmOPwlyi3UY8TWwPxnr1PjmlbFBsVInw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sTOXZIMz1kQhRzXFPc88kMeugXEKpUnl8VdJXc+EDI=;
 b=BpgewvHn6PqlLeIZT1HFn/k5HPhATeGBWkEZ71RoTr+FppxcK2SoFNCXK9gvYWHHApr65TfwSiTYNjG9A3HeM7UwtdjgMklCMgE8BNMVFJJFY40euZydXx4h+X0U2tBuDR1VhpvTP8CfTTL5KUOesVCvu6uQVyjO1dK/1QQij4OL8K+bIPrxXY0l+4idaCz1cS7ICM5KzzIyW17uMW4Tbgzdq/nzln/bQtdLSMy6eXZSaVFG8GnFz8yQqOfe242gLlixpVg4lTVB/eHx1pkkYkBy3kMmc93Q+zDaEGzrCg0AA5weDNntMHHo0T+aqhOcn4Ho7wXm/PHOtZHHT/ZB9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sTOXZIMz1kQhRzXFPc88kMeugXEKpUnl8VdJXc+EDI=;
 b=Y6TOY7jlzaXgsJZGNaPEbUAeF7f41awpxo2wMdd51DIEdKHEXu8tv5o8vaP4rT8nGdvnNr9PsNfAwMozfqK+YQpXAXYJBj2CdxRRROeXW1EzyRCbB9CHTAdxZpmhpKycsuY8QmqPzF+z6434Ez9iCcCA9ezIt4VprZnCZ6KOkLRWeocupJwfVC/vdcv6qaQxpVP+SV/OwaQWCoSenV24VymCuot+MXAh6rve3vqvzC9AIIQxSNCCeixijNiGUkTSbP1zSkbNLsbVA6JhW7nxKVmeAeKEcCFRBe3vbV2O/+iwINX12S4KDNo38mddkJan8Vl68j3QctKyolFoHWXXIA==
Received: from SA1P222CA0097.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::24)
 by PH8PR12MB7445.namprd12.prod.outlook.com (2603:10b6:510:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Wed, 7 Aug
 2024 19:00:42 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:35e:cafe::9e) by SA1P222CA0097.outlook.office365.com
 (2603:10b6:806:35e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23 via Frontend
 Transport; Wed, 7 Aug 2024 19:00:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 19:00:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 12:00:22 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 12:00:21 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 Aug 2024 12:00:21 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <shuah@kernel.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH v3 3/4] iommufd/selftest: Add coverage for IOMMU_RESV_SW_MSI
Date: Wed, 7 Aug 2024 12:00:06 -0700
Message-ID: <090f0d98be7a023448e34a6eaf499ec50f4680d1.1723056910.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723056910.git.nicolinc@nvidia.com>
References: <cover.1723056910.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|PH8PR12MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: 37637d37-c0da-4594-2b57-08dcb7133c84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4YCMs/oC+SD8fGP42Jo8t9tAR998zvJn45w+914TiM6kZM/gAo5EdIrP/4D9?=
 =?us-ascii?Q?qmYqYIvsbiAiWzt9g/5kZE9Fg2Msef+/vDUDqI2P25il0F8u7995DBLy9qjP?=
 =?us-ascii?Q?v2Mn5ieq1S/c4/IuWCXFk0Vx7NfEl1mBbiOJrGYaUeJ3Z4PBGxCCaetgSOAv?=
 =?us-ascii?Q?LToJRftn7TD2y8IyXm6EMKRogttXni1pqBRqvH7iVKPlU9I/cP1TUaVgqbR8?=
 =?us-ascii?Q?+M+Xq0zvezIQYAsyGGhF0uM5hdo/SHBBhwcTizn+twqQ5cmPU6WQB9aVzScC?=
 =?us-ascii?Q?6DdJGzEoZbvXfqfEGgZwv67CGpEzp/JPGEa5tuNyHNgdfABXIfddqo884DsT?=
 =?us-ascii?Q?6ve4nyKiPXrrMUEPzlrVZRI8wklYoYabbjYqqi9ZlvoBZDWN9hEwsv/u2Alo?=
 =?us-ascii?Q?pHBob3flOT8FN/oB/sDZlD45FWzp8JHCUN179SwMixMhq/Cwp3iXxrTug02q?=
 =?us-ascii?Q?SqaNlWFx4KESGeY9oHD37K5KTUBHhBCq81OgKGiTXHG0uSnypPzB1c4tKTIK?=
 =?us-ascii?Q?SaGi/1ryDQG0wXaCOZBqxEEkr2gj/2AUuVWeu/+prpl6RTcaLgdZ3bPil+R4?=
 =?us-ascii?Q?sKsKm03GuxuVlYv7EeAulSNhaeUCosvzQP+pljfLaXnCtaNv8OnTb0UsD8D4?=
 =?us-ascii?Q?P2ixUfJNxejhq6f0EKZ/OHQ4M9inls0Ub4JtzpgdFN7shvgGTkItoNClBfRM?=
 =?us-ascii?Q?DWEdWA0gdAX3gCY4gL09746uGnOACwyw2MMl3Aw4R4L9Hgm4zd56/NZqjK/w?=
 =?us-ascii?Q?gXck1jp2VNbvqnTJnWj7vyaCub3pPiZ1AjgrOfBhAMuY+r0HHDe1iJy6Yfh6?=
 =?us-ascii?Q?qaxta24Hs1KAMAK9xmnYSeUixVxlHzz3IAel84Kqe5TsZgZh9un4A9HQe/Ni?=
 =?us-ascii?Q?nfNqLuPu81e3G/lIfxiC47N7WC/RePjt5UDusucl6yH4UUQ3WJ9hqOMRIkJn?=
 =?us-ascii?Q?heJLhOhVNw2hJsK9g46NK72waF1eHw6jQ/xDky/04wU1tHM9zv5kWk8QBhbN?=
 =?us-ascii?Q?Ojqx2nKsbGpt8uMERmlVO8/p27xMsPpc8fc3YyBRmJB8uPYv8YLlgYMpSx1g?=
 =?us-ascii?Q?VUQr+qKi0oD7PvFxkIgOZih8MWHe5JoXg9pUY6z7oUobwN3iDcLK9fQuMaw2?=
 =?us-ascii?Q?y3V5K67H/GiOgxI+ug4wI6vhZRf/OOuBPoHczgxp2/gEISJ0nh2BvRaW1cqF?=
 =?us-ascii?Q?EvaFPS/QAtsEO9uP8J/Oc27xiQRj8JRm6DwVdHJlSAlIZ4yN2Ukn19OkwALd?=
 =?us-ascii?Q?SJXjFUbhrxdv3uOH8imx5Fs4TqPnnApuKB13kI2tnYPTd2xkgbjyfRUu16YU?=
 =?us-ascii?Q?29DHcAwFHdE77s5VndYgWa8FHHahNJXzfgVKt/n3eGSlXhy916odUWEfJKBv?=
 =?us-ascii?Q?CJHGWU2zCbAHYIqb20TkciRsViRDsnNGIVKp905J9dQaoz1Pk05lnEj08/Wy?=
 =?us-ascii?Q?s0CuMFON5SYCVk8FMPTaeMIDuJxzQgPB?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 19:00:42.6074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37637d37-c0da-4594-2b57-08dcb7133c84
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7445

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
index f4bc23a92f9a..0bb30275a92f 100644
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
index b60687f57bef..642ae135ada9 100644
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
index 40f6f14ce136..bc4556a48d82 100644
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
+	assert(ioctl(fd, IOMMU_TEST_CMD, &sw_msi) == 0);
 	return 0;
 }
 
-- 
2.43.0


