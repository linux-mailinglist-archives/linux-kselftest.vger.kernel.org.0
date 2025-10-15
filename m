Return-Path: <linux-kselftest+bounces-43150-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA71BDBEB6
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 02:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24A3B3E7142
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 00:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1165220C477;
	Wed, 15 Oct 2025 00:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CN8Avwd1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010050.outbound.protection.outlook.com [52.101.61.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491001FDE14;
	Wed, 15 Oct 2025 00:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760488289; cv=fail; b=L+lU/smVKXNL5cnAs6b0XMYy2ExPgmfROr5W/TeHQFJHTaxDr3qpOEpBKgcZMS5nSy5noEzwTU+mglqtefMWkv//4UgmzKelRtJitY1BFV6BiIKTw0Jkwn+HTl9mXUrJYHxuk2+3+B32qrJI/2GprlnfB749HHzYPCUAuSxQ18I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760488289; c=relaxed/simple;
	bh=EBkPli3pn0BYxCPIxCEVU+w4nYS5miY6hkYMaRwCyX4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IxhXax0fIN6MXWh26NFweoYelKYAnPLofCI4AbsWNVP4h4eKtiu6wcCi3ESvVrGfjUKnuaqytjqlOAXU9zer2sTpm1Sk6GU5+ZnEEYHAd5GyRWdSGPqSbG9xHQuJtKupKEzPqPkUOCBQtPjH/fKU/FF82HkwrySQAUyFHAORlPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CN8Avwd1; arc=fail smtp.client-ip=52.101.61.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJoE0tzVSg+ERodwL4F9ZApdbIBni1fsEdaR9ybDPTr/8KFdkANBw8LhYcE5vOvvW96PZyLa5nxCRK4GMOJSOqFOrhUpxZrhpKXnkyoVsuKPi8STGdqGi4yuFSLO3bgk0Dzbc34tXtqneU16f5gQdX6grGAooUA0GwbB3V3XXuMPmuNfb6IMQLYGrON5DHb6KBbSK3nxvvUx7A5/TeLjNs/8gOxsMebp4lRr56coXnxzbLN8RMgUdglWsFx3LqkmnepHxdlp9w3J8LnWqs4Nuawy2007IqaJQwveR0kIp9j+ScP9JOmbdCwIYQdTALXmmmfWza4/wHaFkVT4+M5IqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBpyXuUORvQP4es71wGwsTGl+/KZUyaFViURzymSNOQ=;
 b=B5zRcZ4p3Bj2Hn3ly2xjyIV7u+/ewY5idty7qYDuj5d427syn3GwDPE9NmgXATOszD78TAa9zZNTfQ0tU20Hzd0BMRdx0R1TduwT1slFTA1+FefD5iVqLGSrAv+tHJdEjo8QhfVpTj82Nrb25zhXcg71D2xNRZZiVsnvBD/p4F7SVIv6MUu0wSRu5IJrvR01/eJXT3jHnMmZmw8x76R8um/FuPNdYMENjhKAOs4v7jFLL5cOxgzpUiTwMxxlE1FY/EcFah+BSrQK24OuU/rg2C5Fg49vOnvnRWJ1xeg6/glfJbIReudneYbrpvxu+Bgnq36Qc/6PUGsrirgW1NIn0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBpyXuUORvQP4es71wGwsTGl+/KZUyaFViURzymSNOQ=;
 b=CN8Avwd12z7WKHnZmkctHzw+GXvjHZ/E1jldVQmUBgT2arCBakHagildpFApo7wxjlVcVvODfIa3XT15lztJDRUmKyWpx9b2a1VGRHZPLVbO/T7DyENbubTfGKnmAGGf1mHwCMhOijxQrk5hgr+mlj4/4Ki6+z8J4Ve+kr2/aBd0LIDjOc6YSpV3geqhQ7s5lbv4aWTnHrPpha8SGNKOQZPKhiGmnrIt0wsLvZrbjxYC6MwBc1uNNAWfHtex0peqSKsVwwvF8F6EIy/GVM/sdKt96Mj2DGlR7N7fq6E5JduCfgKF4dFunzdJBv0deh+7PHzti8BasQW+RPuFZjMBYA==
Received: from CH0PR13CA0040.namprd13.prod.outlook.com (2603:10b6:610:b2::15)
 by LV8PR12MB9641.namprd12.prod.outlook.com (2603:10b6:408:295::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 00:31:23 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:b2:cafe::29) by CH0PR13CA0040.outlook.office365.com
 (2603:10b6:610:b2::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Wed,
 15 Oct 2025 00:31:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.0 via Frontend Transport; Wed, 15 Oct 2025 00:31:23 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 14 Oct
 2025 17:31:11 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Oct
 2025 17:31:10 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Oct 2025 17:31:10 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <shyamsaini@linux.microsoft.com>
Subject: [PATCH v2 6/7] iommufd/selftest: Add a testing reserved region
Date: Tue, 14 Oct 2025 17:29:38 -0700
Message-ID: <9b34cc12f1d829fbbd4379445c82bc512cff3ab9.1760487869.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1760487869.git.nicolinc@nvidia.com>
References: <cover.1760487869.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|LV8PR12MB9641:EE_
X-MS-Office365-Filtering-Correlation-Id: 77e0c9bb-90a4-4bb8-f922-08de0b822b85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rmOxU9RycBwIpSx7rRVDH3JpPROBf97+s4IPKQzbMCJDaoWKe0lIaTQn1fZz?=
 =?us-ascii?Q?7WCiYro2wsrHCnnBJYaLNzBOudscX30L6Cq4Wv+g4sLkgYnYEwMPGVAel8va?=
 =?us-ascii?Q?xlItQc8QGOP7MibmgLkOMyEGh0TpSFFw6zi/tu3xgaZoFgNWrIzwI04Ot217?=
 =?us-ascii?Q?rGRVUFA/2/jP8lcfJ/DRRWf9isMibSR8Nh6Dku+AtkXwkQ5A/pCV7ZKRQbYA?=
 =?us-ascii?Q?vDg3n2KOTtYMFMsEyb3su20Fgi8G1O/VNe5hCFRyfySq5XSa8pc7GaI4Zo/1?=
 =?us-ascii?Q?P4tAZe61gY/yt85uWWSi02K4fF0hB0RaK9GrW56SS3XWJBjGfXqHFu8xZrnH?=
 =?us-ascii?Q?u7Zo8RxR6fYplQuvANgeeX37f0kOaEpL/BMCItM00/XvPoLgYNrk6LgZBge7?=
 =?us-ascii?Q?EEWx6SXGFWPs6WNRhkSt2L57rAPPuw1QF3HtbGfQ9xXpTrYxxjsZj0bn3OSX?=
 =?us-ascii?Q?aRuaD0r/6VkxP/jDi+qTQJIFy8eAg0Q1tQdfaZjZmXdzRBxKvzCWGF+A0yRw?=
 =?us-ascii?Q?5k7ZFi9YCehRmwxeuJEf6cUMi/wtZdpYZfVgEiD5lQ0c2kr5LO0hmD7wZP8t?=
 =?us-ascii?Q?9qHUyUc7g1RZMvDDJjzme90FgMVJcgpOFYe8IwDbBqDXAPmplHEPRyb9qfkp?=
 =?us-ascii?Q?+o2vCa3qXOG6IFvIfSHYIn9uKmKoLYEmZ7RVBVfzc1I0jrF633AeLP7+NjH3?=
 =?us-ascii?Q?96K4sfxLjowaiyDzbBxCvqnTC5mM2r4c3A3cynzJtdp4AlaMufMXg63USYS5?=
 =?us-ascii?Q?MXqjT8wy3aSDhF5SZaAdiI01UwTFL6aJ15eFezumil9S/2WaInB5gdmzYzkd?=
 =?us-ascii?Q?E7gQ/vYA6P0LOWElPu2/z98Ni7twIhaFd56ga4WZxMEYImHBOTX5laeUN2U0?=
 =?us-ascii?Q?eT7RJbBAs1XZVrLUUrDsvV/HqKU/vXjD4w5g7N4uwKChbfDqlDQkgXA1BiW3?=
 =?us-ascii?Q?N/m60q56t7pYbtiuwZ6oMtYC3gX4mJpnHLxuY8mEKKg6aJY9vX/G8OBZXxVn?=
 =?us-ascii?Q?1pX2MsMpogJAuyUsiEv87YI0SEK6+YqOcDxCgHoy0kFixJ92DDzDzsECSpbR?=
 =?us-ascii?Q?Upz6zikFAVPTeGKI21vxyRHsW3nwKUuiB7laRXbhQiGWzIF4I6A0gnlFFu/4?=
 =?us-ascii?Q?olXEwqwgMyDIa07TJPheQD1HeQGAAmE/eYEt8ARCxAF3kwsvmYoIItTndVvT?=
 =?us-ascii?Q?37IVtm/VhEH2k/15Soaeyzp9w4FDxdAVJrjBhFbcwPdl7q7U6PTClwfFbivQ?=
 =?us-ascii?Q?GDbL9cKlbZeNo2uvAL847Fz9WluQRpdi9qyn/FaSSCLewMZDRqAzydfBW9sj?=
 =?us-ascii?Q?V92rR/7/QqnWbrlnRHf33gS5WgTogqIj4S4JgcNG+D5ClBDCRst8PTRzFISz?=
 =?us-ascii?Q?lrXKW8rJFrr7rwWa8PXXak1Wb8OLyyDhm+8ByWXrFCkeqdH8Gp11i/SLcBO+?=
 =?us-ascii?Q?uHNDZl4k9/J8O5NZ7tCFplFykPZbjW46iSu3BNQoiVljnrZuiq8HEmWvQATr?=
 =?us-ascii?Q?0wBG2Fl1EeVkZ9KvFDx01UKUwJNT+aJv9m09pB9kr1hEHv0OupfpUOlmEkY+?=
 =?us-ascii?Q?u00Fy0cmFZLm86iGmZc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 00:31:23.5684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e0c9bb-90a4-4bb8-f922-08de0b822b85
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9641

The new IOMMU_OPTION_SW_MSI_START/SIZE must not overlap with any existing
device reserved region, so add a testing region [0x80000000, 0x8fffffff],
on top of the normal IOVA aperture for selftest program to run an overlap
test.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h |  3 +++
 drivers/iommu/iommufd/selftest.c     | 18 +++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 7f7ffe5d670bb..34fb12a36621a 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -273,4 +273,7 @@ struct iommu_viommu_event_selftest {
 #define IOMMU_HW_QUEUE_TYPE_SELFTEST 0xdeadbeef
 #define IOMMU_TEST_HW_QUEUE_MAX 2
 
+#define IOMMU_TEST_RESV_BASE 0x80000000UL
+#define IOMMU_TEST_RESV_LENGTH 0x10000000UL
+
 #endif
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index ee5671d7e55d8..2c660c021ed27 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -480,7 +480,8 @@ mock_domain_alloc_paging_flags(struct device *dev, u32 flags,
 	if (!mock)
 		return ERR_PTR(-ENOMEM);
 	mock->domain.geometry.aperture_start = MOCK_APERTURE_START;
-	mock->domain.geometry.aperture_end = MOCK_APERTURE_LAST;
+	mock->domain.geometry.aperture_end =
+		MOCK_APERTURE_LAST + IOMMU_TEST_RESV_LENGTH;
 	mock->domain.pgsize_bitmap = MOCK_IO_PAGE_SIZE;
 	if (dev && mdev->flags & MOCK_FLAGS_DEVICE_HUGE_IOVA)
 		mock->domain.pgsize_bitmap |= MOCK_HUGE_PAGE_SIZE;
@@ -688,6 +689,20 @@ static void mock_dev_disable_iopf(struct device *dev, struct iommu_domain *domai
 	iopf_queue_remove_device(mock_iommu_iopf_queue, dev);
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
@@ -952,6 +967,7 @@ static const struct iommu_ops mock_ops = {
 	.device_group = generic_device_group,
 	.probe_device = mock_probe_device,
 	.page_response = mock_domain_page_response,
+	.get_resv_regions = mock_dev_get_resv_regions,
 	.user_pasid_table = true,
 	.get_viommu_size = mock_get_viommu_size,
 	.viommu_init = mock_viommu_init,
-- 
2.43.0


