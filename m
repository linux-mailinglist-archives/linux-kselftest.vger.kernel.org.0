Return-Path: <linux-kselftest+bounces-24282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 528F9A0A079
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 04:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D673AB057
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 03:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3515C152514;
	Sat, 11 Jan 2025 03:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tBykNP9j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6780D4689;
	Sat, 11 Jan 2025 03:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736566376; cv=fail; b=fvCiz1c3pXLJt6q2t0gQnXwQqGxUYcMwyX+xTTyYue7Nmq2ppXKMR15fFjCRAjr8nA/tRJRNhEBIUwSUinTCX4gQkYa/3PV2OoXtH2RzrC9hBHA97ouU0ucRJd5bBgHt4lfmvE+U+3VFEBVZ+rCE7g+fdzNLL7+XQqZ3+6hsd3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736566376; c=relaxed/simple;
	bh=aBnR19QzrJ5SRl8aqggymwLHehBAnbBJU+jn/LqY48Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tWSxd6fpTeFwFK8Gna5nq3S/zxadHUx+7okTiPTRby8Th4qjevMbp3VQwwHD+Zm0BRAQr+bnHzz5SH/lsjjD0xOw1F53fBGWWO5BExVaxFLiyeqWiuWRobKG9aCHSSWz02e3qqU9eVMX0zkyTW64iBDOZeITgFoAHUbEnYtwckk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tBykNP9j; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nA8jVy1wASRq8xlqwer3PV8VoGEn7BfNr09o/QRaYTANtSyMMmwt7fN5VPxxLG9EEtDJXZZEFQoa5QOguc3E2/+phdLQlDpsT4sG+G4mGSPRLLvO//T/n20ZODdEPo5zDD0maFRDnUck0vlBJVuAZgo1MwbEeD41/cyxTe3dTjF/wJMp2HIZOpqjFONQVV90HEX53kX6MR5GEI+x0U7IjRD2mPVFq/slUfYjmOAauYRjNWAMH8mcRy2PLMIt1WR5TLk6+Zb7+MEjZpOaCi51vD9Xjl9DgfxWfBCUOQ6nf+/CnN8uAoMG8DO8OlrLZpVTq+grdG1cjHjNl52E1xuIvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPeyU3lRqM4dpATbzaAdOE36h5QXLbQQIwpWONiGNKQ=;
 b=w+UAcEJLd3ZZivlPaQRHb7OdMg6uT7P7WKU5luAKStX31mIIdZ7XCG4IZQJ895j6svubILj6n5jkVE1t16Z9/5kVuBm3YaF1JeJ9vOhql/vf8IQ+IMs1fC6h382ziCvI+6i1G+JqhtoSgJaJvJ5gaCpbDex+f2M6EtDlpOcXYw1CmpwU6o35mmTJlpbOqkIctU5b9vMwiAzyX4c7J06V4Y0Zu+/KKKnB5gxQyHZ1wy5qmGepXSzz6oauoNInuMT4wGXKL6RKDzkrIqU+qbvaKtExjPzwfbrGLVrMBad2eXbfYXBRDQXPZ79z+33mO5l9K2nEqw0pu+VpuWHIHmKU3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPeyU3lRqM4dpATbzaAdOE36h5QXLbQQIwpWONiGNKQ=;
 b=tBykNP9j4CgxI4Fswodoi04b2nMyuy9O5eXXCYjV9DIVJE1wdHs9uiZw7zYISWAiXsZRILq+aEUnQTXMIoqHgVnZRldKrNaAPyMpnVX44eyRZbbdnkK/1yYAPXSuFL2RnInnJHnoA5TqbDe2vdi2EYAg8Eroi/ZECuPPBkL8Rt0mFakfas280/FRB9fQizWkPjK8IPep10KUdTwIYG5H7BWHrXLjxZ1JCpPjDoZwm1b8C/lnGy0xWGpvgOw9YN2ORFNPDkm2oiRXxdw53ZorA89oN+w/8uHyhVKslJeESfxfu9coIdCm7kH/ijLFWB1vL41+A1Up5zuh90MGzVR3KA==
Received: from DM6PR03CA0098.namprd03.prod.outlook.com (2603:10b6:5:333::31)
 by DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Sat, 11 Jan
 2025 03:32:50 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:333:cafe::dc) by DM6PR03CA0098.outlook.office365.com
 (2603:10b6:5:333::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.13 via Frontend Transport; Sat,
 11 Jan 2025 03:32:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Sat, 11 Jan 2025 03:32:50 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 Jan
 2025 19:32:49 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 10 Jan 2025 19:32:49 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 10 Jan 2025 19:32:46 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <tglx@linutronix.de>, <maz@kernel.org>,
	<alex.williamson@redhat.com>
CC: <joro@8bytes.org>, <shuah@kernel.org>, <reinette.chatre@intel.com>,
	<eric.auger@redhat.com>, <yebin10@huawei.com>, <apatel@ventanamicro.com>,
	<shivamurthy.shastri@linutronix.de>, <bhelgaas@google.com>,
	<anna-maria@linutronix.de>, <yury.norov@gmail.com>, <nipun.gupta@amd.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>
Subject: [PATCH RFCv2 01/13] genirq/msi: Store the IOMMU IOVA directly in msi_desc instead of iommu_cookie
Date: Fri, 10 Jan 2025 19:32:17 -0800
Message-ID: <671b2128c193fc9ac9af0f4add96f85a785f513a.1736550979.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736550979.git.nicolinc@nvidia.com>
References: <cover.1736550979.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|DM6PR12MB4220:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c8dd264-3da3-4ef5-fbe2-08dd31f0a01d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1vonUtL68tFrCzgxyCTJVwkcnt58I0caVgANFtU+8GgBY7DwMy4Y5KyySCTC?=
 =?us-ascii?Q?BWCslMkawxZysZaJJGH5g5EFhQqkgJm72ls0FXeJ+SJM1qwwstlo3QYI0jmm?=
 =?us-ascii?Q?hNnz2Q3eSZIKAH9oAajCLEaK/ru4LQllxZ+yLmbrVWrjXcHPnxEhZB36L1CO?=
 =?us-ascii?Q?0turttedjnzV3r9KVRq/4KccdViI/v7/AuzqFoUsgum78/diXDFg8nE7FJwI?=
 =?us-ascii?Q?61/viqzPzp4QJZxfo3bBTmoucR3P2zBYEiwC3u3Yo6OT2teTJ+MSYFECyy06?=
 =?us-ascii?Q?XR24k35VHzxUyZrrzLs87eTkQ52JtkH2VOjnQvmRZolmsDkua/hZRTwPz+WP?=
 =?us-ascii?Q?qqWU5WK1vae1nuQo6AgoEAS8M/dPOuAsIiG0qf3xbd9SSOMuqI/wVqyJCK4R?=
 =?us-ascii?Q?mssoXcPGT4IcmkgxXXXBbdX78lpBT2l5fml3PqwZXfBwvQV0iH0QQwGwLSGh?=
 =?us-ascii?Q?DI/oEO3Ksmvz7Wb1l6GQvx3oiULy0w3IFjyxGoUbt0wPlvUU8nDJWbCV6pf2?=
 =?us-ascii?Q?nNHi+FgJ6xHvFyaHIuDroz5/2XzYdBLft0yhRtRkcrZuur28HtgyA1hxpOYO?=
 =?us-ascii?Q?/IBfRd3PDDnE0PLKnY2Dl5IUX23guk6U8HsSjkbqdX2Yy3sjyqdvaTy4jPwb?=
 =?us-ascii?Q?ThO3Df1Zc5FhRkbEY3iRbILHRyvLvxyu7qXGu5oD8v2/OA/o0QJxEjBJ25zw?=
 =?us-ascii?Q?vPNvlpwNEo6VtUm+9MHsyjlvJXb54vTYG3NkDkTLG2Ji5OKcR9VLVpokoc85?=
 =?us-ascii?Q?Zyn3Pg1pfZDJZ+ehIW2iRmFPpSXSVayyK6Pxos1r5IvPl6/D9tQ6DZ25isU/?=
 =?us-ascii?Q?6ooUI4Ol0q/k8sHYI5R94Go8UgEMAkm1sqJW8tLYQyBv6F0EM4LBsUgJKpbr?=
 =?us-ascii?Q?3zs243vVxJnCnkAM5zp3zUU4jruM0lXE+7uH6nGY0voLMfODGWOQeqWTiTxj?=
 =?us-ascii?Q?/xuLMrps2gHSVpsxSP7+WRmOy/lfkQAlLwS1i2hXRmgB9vdzJRWprDHBpmUg?=
 =?us-ascii?Q?kNFE4Lv3XT0u1AyChy/bhm350zo7hxHIlEtwfZxXiT4dxt9p7bZjRCAr8Kqq?=
 =?us-ascii?Q?mMmRRn4wtJiqk1KVYU1qDxcDQEYsi43u7/RWqjyrg12aSjsNjHM4dMBdHHWk?=
 =?us-ascii?Q?4XXQOThW5Z+ZnaTle8n3rENQdMXFlzPz+mJgpgbS/hVwbIoEUO4NEJp0OBEk?=
 =?us-ascii?Q?MWJrdKXU32YSQQxkTUTlehunp8UnumDhSjlg9SVtfQwe0myp1t4umJwjYKE3?=
 =?us-ascii?Q?kE6c/uwY627RfNFDKnKNe6GrcMNRjefmggEscMB3VnAAwN7QCOhFOuzEmKbZ?=
 =?us-ascii?Q?gBrX9sOeWnHlbFFTPDrhy6NLP1sQd+LPQftxrblq3lc4hhn6UvIKu9osrZ8r?=
 =?us-ascii?Q?drqll7yqo829OmeLiy74SoQ7Bpj3qbAtS999b6EoLqF4FeLnUTpuOyEGbOWb?=
 =?us-ascii?Q?f5pk4ws5F1kLVFMSaRDWtseQD+N8IovhWtOxH/gHbcHGeSqtx6P+fqlF4gJO?=
 =?us-ascii?Q?L6qIjxl4MBiUIhk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2025 03:32:50.3616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8dd264-3da3-4ef5-fbe2-08dd31f0a01d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220

From: Jason Gunthorpe <jgg@nvidia.com>

All the iommu cases simply want to override the MSI page's address with
the IOVA that was mapped through the iommu. This doesn't need a cookie
pointer, we just need to store the IOVA and its page size in the msi_desc.

Instead provide msi_desc_set_iommu_msi_iova() which allows the IOMMU side
to specify the IOVA that the MSI page is placed during
iommu_dma_prepare(). This is stored in the msi_desc and then
iommu_dma_compose_msi_msg() is a simple inline that sets address_hi/lo.

The next patch will correct the naming.

This is done because we cannot correctly lock access to group->domain in
the atomic context that iommu_dma_compose_msi_msg() is called under. Today
the locking miss is tolerable because dma_iommu.c operates under an
assumption that the domain does not change while a driver is probed.

However iommufd now permits the domain to change while the driver is
probed and VFIO userspace can create races with IRQ changes calling
iommu_dma_prepare/compose_msi_msg() and changing/freeing the iommu_domain.

Removing the pointer, and critically, the call to
iommu_get_domain_for_dev() during compose resolves this race.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h     |  6 ------
 include/linux/msi.h       | 45 +++++++++++++++++++++++----------------
 drivers/iommu/dma-iommu.c | 30 +++++---------------------
 3 files changed, 32 insertions(+), 49 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 318d27841130..3a4215966c1b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1513,7 +1513,6 @@ static inline void iommu_debugfs_setup(void) {}
 int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
 
 int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr);
-void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg *msg);
 
 #else /* CONFIG_IOMMU_DMA */
 
@@ -1529,11 +1528,6 @@ static inline int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_a
 {
 	return 0;
 }
-
-static inline void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
-{
-}
-
 #endif	/* CONFIG_IOMMU_DMA */
 
 /*
diff --git a/include/linux/msi.h b/include/linux/msi.h
index b10093c4d00e..d442b4a69d56 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -184,7 +184,8 @@ struct msi_desc {
 	struct msi_msg			msg;
 	struct irq_affinity_desc	*affinity;
 #ifdef CONFIG_IRQ_MSI_IOMMU
-	const void			*iommu_cookie;
+	u64				iommu_msi_iova : 58;
+	u64				iommu_msi_page_shift : 6;
 #endif
 #ifdef CONFIG_SYSFS
 	struct device_attribute		*sysfs_attrs;
@@ -285,28 +286,36 @@ struct msi_desc *msi_next_desc(struct device *dev, unsigned int domid,
 
 #define msi_desc_to_dev(desc)		((desc)->dev)
 
-#ifdef CONFIG_IRQ_MSI_IOMMU
-static inline const void *msi_desc_get_iommu_cookie(struct msi_desc *desc)
-{
-	return desc->iommu_cookie;
-}
-
-static inline void msi_desc_set_iommu_cookie(struct msi_desc *desc,
-					     const void *iommu_cookie)
+static inline void msi_desc_set_iommu_msi_iova(struct msi_desc *desc,
+					       u64 msi_iova,
+					       unsigned int page_shift)
 {
-	desc->iommu_cookie = iommu_cookie;
-}
-#else
-static inline const void *msi_desc_get_iommu_cookie(struct msi_desc *desc)
-{
-	return NULL;
+#ifdef CONFIG_IRQ_MSI_IOMMU
+	desc->iommu_msi_iova = msi_iova >> page_shift;
+	desc->iommu_msi_page_shift = page_shift;
+#endif
 }
 
-static inline void msi_desc_set_iommu_cookie(struct msi_desc *desc,
-					     const void *iommu_cookie)
+/**
+ * iommu_dma_compose_msi_msg() - Apply translation to an MSI message
+ * @desc: MSI descriptor prepared by iommu_dma_prepare_msi()
+ * @msg: MSI message containing target physical address
+ */
+static inline void iommu_dma_compose_msi_msg(struct msi_desc *desc,
+					     struct msi_msg *msg)
 {
-}
+#ifdef CONFIG_IRQ_MSI_IOMMU
+	if (desc->iommu_msi_page_shift) {
+		u64 msi_iova = desc->iommu_msi_iova
+			       << desc->iommu_msi_page_shift;
+
+		msg->address_hi = upper_32_bits(msi_iova);
+		msg->address_lo = lower_32_bits(msi_iova) |
+				  (msg->address_lo &
+				   ((1 << desc->iommu_msi_page_shift) - 1));
+	}
 #endif
+}
 
 int msi_domain_insert_msi_desc(struct device *dev, unsigned int domid,
 			       struct msi_desc *init_desc);
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 2a9fa0c8cc00..bf91e014d179 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1815,7 +1815,7 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 	static DEFINE_MUTEX(msi_prepare_lock); /* see below */
 
 	if (!domain || !domain->iova_cookie) {
-		desc->iommu_cookie = NULL;
+		msi_desc_set_iommu_msi_iova(desc, 0, 0);
 		return 0;
 	}
 
@@ -1827,33 +1827,13 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 	mutex_lock(&msi_prepare_lock);
 	msi_page = iommu_dma_get_msi_page(dev, msi_addr, domain);
 	mutex_unlock(&msi_prepare_lock);
-
-	msi_desc_set_iommu_cookie(desc, msi_page);
-
 	if (!msi_page)
 		return -ENOMEM;
-	return 0;
-}
 
-/**
- * iommu_dma_compose_msi_msg() - Apply translation to an MSI message
- * @desc: MSI descriptor prepared by iommu_dma_prepare_msi()
- * @msg: MSI message containing target physical address
- */
-void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
-{
-	struct device *dev = msi_desc_to_dev(desc);
-	const struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
-	const struct iommu_dma_msi_page *msi_page;
-
-	msi_page = msi_desc_get_iommu_cookie(desc);
-
-	if (!domain || !domain->iova_cookie || WARN_ON(!msi_page))
-		return;
-
-	msg->address_hi = upper_32_bits(msi_page->iova);
-	msg->address_lo &= cookie_msi_granule(domain->iova_cookie) - 1;
-	msg->address_lo += lower_32_bits(msi_page->iova);
+	msi_desc_set_iommu_msi_iova(
+		desc, msi_page->iova,
+		ilog2(cookie_msi_granule(domain->iova_cookie)));
+	return 0;
 }
 
 static int iommu_dma_init(void)
-- 
2.43.0


