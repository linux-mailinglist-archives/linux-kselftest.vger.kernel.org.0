Return-Path: <linux-kselftest+bounces-26082-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11834A2D4FB
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 10:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1843C3AB28E
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 09:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4080F1AA78E;
	Sat,  8 Feb 2025 09:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VVK+vxx0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3341A00F2;
	Sat,  8 Feb 2025 09:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739005404; cv=fail; b=jXdiO5DrzzadnzJAENbPS8ajvI1WAZWTT+0AY9KFQfj8ZxbPYFr5LQeIjwm5/We47abmdaAqxPaJFO6Zt5e3WktjrEkCuCotXcgcso2A4cMw1uURTOuCPGk9L0PQdrSSwoSCe9X0u+ooo1t1nC3xW4eM3xSsrqYlAibseCrlMwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739005404; c=relaxed/simple;
	bh=FheWkBMhjruQgnxgg0RyItMCXEO72CKXmE09MXP65SU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TMDfxoBx5+OK9EkrtNXJ5ha2MYmykDfSrGhDTYeBhhDAkRoB/sO5abPTlaciAIj99akbr69YGZ/431aUP78d5tJd1QObPMksc3hLsQ+kLWM5CJXhjYB+2Nw1tV9F3Jki9y5+tRJ2gwrTn1x3y4FqlHXKVCq6B1QTYgYD1cSLr6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VVK+vxx0; arc=fail smtp.client-ip=40.107.101.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNo5xzPHbnX7YUZ1A8oLyK/fBSjEqG+v6KR8iQ88T+f2UzXgtCQ/qOhZV6XiwIQezm7z7RMJrMQWTpyX23GRJ4JZBNLqldmCqaUpesGInAOpy2BKTf7on8vO0y1ZHgLk5lzE+G1uQ94tHnM+2LrmzKV+800eTcsaKN+bXtaneJbLo/nLj+0NFZ6xHRk7xa+SM5AevcACpS8kQKOT1lsG/hN8f7wmQ5sDtww9N0upHrUjbeBnHDWfKXCTqSx2KT7t71bnsjMfgUqkLWkgAyQtb+jSMgrpCz7H6H0XIh2169399KXeOD2QMs2ScFkN5647k+rVAZsl0MaI+VRQkr3bPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/AmL8qaAGihw4P5IwftJNsywAVlmmaEhofPXsynnuY=;
 b=fWu8tbzl9zxrUkJmsThqQTT9FQI7snMXdlyukXNgJOk2Dhll8hig833ktPPpQcs9WlZTkTzYi1QbmiW/9VwoERGkW8OuMbUyGiY9/cKVCdNHVLMrfDm5wLoJI8g6kOcmwGwVnngA8AN0GeiYqMKPYnWg1AwBVbuWmyRmLdbD4pBQlrN9PTn8dIvZKKblJ9utYCCM6Byl2stOTon3Ygpij1fLyqZUahon2CLVJVzT3HCzTXoYt3QZaIAGq4VYRChw1j7+2fI0gegwocGYwXMLGQY28mcvDBAQ1e/Lobs4IQjeM3lRIgoITftf13relg87z/caAAfRzBeLNSS1XUUm2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/AmL8qaAGihw4P5IwftJNsywAVlmmaEhofPXsynnuY=;
 b=VVK+vxx0kaWlc+8WcjEQVm0qYXb4js429suBLNT8B1d7DFtIZsngxZmUSb7gaoAMpXXcgMbcFBywjWxCflucvmTSRaD7SCHCo0h6rppXx4FlPPIjNVrqhmFlnWQ1gRbrqFZiu2npj0Bb9wSmi2bsM/4nDYZ2a98PxqWSLbstasuLRpMPw4wdQLD4nL7uwjP/1RLeGghPfSD4SvS1K9ja9cib5s0vgSWZOdS11FEAcBA3LBZGjInKfDPPqDjsoAb8jDLVhw33UvuSY/dLvIjVzgmx0nQOs+Pz13CXKVceJx6X111WiN5fDINmdd7p0nAMj6OFy2aQoMrpXI0Vzl/K9w==
Received: from DS7PR05CA0021.namprd05.prod.outlook.com (2603:10b6:5:3b9::26)
 by DS0PR12MB8503.namprd12.prod.outlook.com (2603:10b6:8:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Sat, 8 Feb
 2025 09:03:17 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::f2) by DS7PR05CA0021.outlook.office365.com
 (2603:10b6:5:3b9::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.6 via Frontend Transport; Sat, 8
 Feb 2025 09:03:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 09:03:17 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 8 Feb 2025
 01:03:08 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 8 Feb
 2025 01:03:08 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 8 Feb 2025 01:03:07 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <tglx@linutronix.de>,
	<maz@kernel.org>
CC: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <baolu.lu@linux.intel.com>, <yi.l.liu@intel.com>,
	<yury.norov@gmail.com>, <jacob.pan@linux.microsoft.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v1 01/13] genirq/msi: Store the IOMMU IOVA directly in msi_desc instead of iommu_cookie
Date: Sat, 8 Feb 2025 01:02:34 -0800
Message-ID: <a580069c5e494ffffa668218b6fe3a207b01efec.1739005085.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|DS0PR12MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: b7aa029d-703c-446c-ef15-08dd481f6d9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PndUM65KHMprDwWHaCUjOyGs8hSf+37qo7tSlkXItXp0xmPUTYQ61uif+LLk?=
 =?us-ascii?Q?8lgXUc0KN2lCP5M4zkwW33XBgzHd/apv8i8JZqAgSYhSFWq0ffuLPLWxoK37?=
 =?us-ascii?Q?G0B2v/IaKL2zlfEh1uBIg/A0ylPXh+l3TTxje0HlGDJF6qzif42M0wf850Ld?=
 =?us-ascii?Q?3rzHGm/NUjkD+HZP83ujZIsFR5fX2PwuoDbpBFoPYuVJiHk6lFSpg/gtT45J?=
 =?us-ascii?Q?NcVBkzar+h8AeMEXlOHk+rXnlMwmenpjwGXKb6H6+komkfoKl9D8L1WA4Km0?=
 =?us-ascii?Q?mpc+DM28GMoiJdOSiQ2czWUPu9iN52f88FvBjfAhmupxDaS5HdPz12ZfPN/g?=
 =?us-ascii?Q?zuAKiNC/6+QNgvRouzNYPEozuU0HaLVjOi9QiAudbjiXk+0n6AAQca/BthtV?=
 =?us-ascii?Q?Fs89BKxsaqfsZ0arA0VmItgI3xmn+p0uew2IHoGP0C5fTt3tHnbHuZJk5QkB?=
 =?us-ascii?Q?FHjln8v0xmvQ+8nYRrLSq4GeMeHWeKvf0rcX0f71EJiaKIGywxxVE+Son1GZ?=
 =?us-ascii?Q?Ev2BpU/P9jNHZLJyIBaIt3ADBw0LP7YveRHCi3DzV7UVAT0PVuYdn6yCzZBh?=
 =?us-ascii?Q?O8dmWrE4DrXZYLbKz991WDkj/RGl+mGxGYPjU0tvjYyqTA9vX0ynUHm0oq/d?=
 =?us-ascii?Q?Up1pObzgmj+czxwaFlniLYl0SebLsVck4ltUjt0gbY0U7EKKiQK7jtgG7TS9?=
 =?us-ascii?Q?8QYB/xpX58Y+UePR5jiSLxopo5j0WWGGLg9RQBYmEcrhrwxJoAnPfG2cw5NC?=
 =?us-ascii?Q?OSB0F7a0U1BX8KafqLRkEa2cPtqpb49uuySVcHAIF4n/rUG+tEIRRD1Aoo9X?=
 =?us-ascii?Q?lHuBepeSHJaPc70FK36yw523iSMH2LEUP+U9Bu5rc7XBA9m6I3mi2G/b5llj?=
 =?us-ascii?Q?wNxXjGDeHhldXZk7axtl6enamSdqLdY1CiNtBHyfFbEzORU5iRBF0UmaBmUp?=
 =?us-ascii?Q?avEbxMPOQog9tM7bbI2BsMaj4vQeieDWRDFLWHNmLhVDtPc21vBi6dGB01BX?=
 =?us-ascii?Q?Juu0LIk8kYl/Vid64WAxESmDveLfwbUBsCKtr2WnzonYHsW5qjUWVGLgLvET?=
 =?us-ascii?Q?ID4AZ5MYjlQP+rnu0Gs7tQlPb0Ki+GvUvQG/2bz/3cTFNDPt5WxGQhGEUzlg?=
 =?us-ascii?Q?z4u/W25/UL+AucU4SVxpoX0DkqRyxCNNIzSsz8Fa2RkaEcPT4uoQRqK60HCT?=
 =?us-ascii?Q?brzRCr4RJYqyV3+MF/pF2Wb/O5JDO5gIQZsRgGolJ+LlG/hxgNvNi67xFz7v?=
 =?us-ascii?Q?gzXB08jTaX+6hmi+FaHsf6zA/We6SxNmMXDtU7TAo86YMBARbInKALrugsZl?=
 =?us-ascii?Q?18EXITE7Hqj3L5EQfZuslCa/3JQdcRVfmtqVUB1E/CEwnZ933rVLKp9U6hHU?=
 =?us-ascii?Q?bagHBdJjlF5QhEgAVEYzgOGG+ltE5EPdKWWMZEvTg76PalF9Es0lEG3DSDB1?=
 =?us-ascii?Q?OQVJB9UbulgeCGk1D3QfoR5iNzLywPOtDj4kk8K5PWFenclLygrHzTqDXPZs?=
 =?us-ascii?Q?8vmTt0UTASuHP80=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 09:03:17.5390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7aa029d-703c-446c-ef15-08dd481f6d9e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8503

From: Jason Gunthorpe <jgg@nvidia.com>

All the iommu cases simply want to override the MSI page's address with
the IOVA that was mapped through the iommu. This doesn't need a cookie
pointer, we just need to store the IOVA and its page size in the msi_desc.

Instead provide msi_desc_set_iommu_msi_iova() which allows the IOMMU side
to specify the IOVA that the MSI page is placed during
iommu_dma_prepare_msi(). This is stored in the msi_desc and then
iommu_dma_compose_msi_msg() is a simple inline that sets address_hi/lo.

The next patch will correct the naming.

This is done because we cannot correctly lock access to group->domain in
the atomic context that iommu_dma_compose_msi_msg() is called under. Today
the locking miss is tolerable because dma_iommu.c operates under an
assumption that the domain does not change while a driver is probed.

However iommufd now permits the domain to change while the driver is
probed and VFIO userspace can create races with IRQ changes calling
iommu_dma_prepare_msi/compose_msi_msg() and changing/freeing the
iommu_domain.

Removing the pointer, and critically, the call to
iommu_get_domain_for_dev() during compose resolves this race.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h     |  6 -----
 include/linux/msi.h       | 49 +++++++++++++++++++++++++--------------
 drivers/iommu/dma-iommu.c | 30 ++++--------------------
 3 files changed, 36 insertions(+), 49 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 38c65e92ecd0..caee952febd4 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1508,7 +1508,6 @@ static inline void iommu_debugfs_setup(void) {}
 int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
 
 int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr);
-void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg *msg);
 
 #else /* CONFIG_IOMMU_DMA */
 
@@ -1524,11 +1523,6 @@ static inline int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_a
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
index b10093c4d00e..74c6a823f157 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -166,6 +166,10 @@ struct msi_desc_data {
  * @dev:	Pointer to the device which uses this descriptor
  * @msg:	The last set MSI message cached for reuse
  * @affinity:	Optional pointer to a cpu affinity mask for this descriptor
+ * @iommu_msi_iova: Optional IOVA from the IOMMU to override the msi_addr.
+ *                  Only used if iommu_msi_page_shift != 0
+ * @iommu_msi_page_shift: Indicates how many bits of the original address
+ *                        should be preserved when using iommu_msi_iova.
  * @sysfs_attr:	Pointer to sysfs device attribute
  *
  * @write_msi_msg:	Callback that may be called when the MSI message
@@ -184,7 +188,8 @@ struct msi_desc {
 	struct msi_msg			msg;
 	struct irq_affinity_desc	*affinity;
 #ifdef CONFIG_IRQ_MSI_IOMMU
-	const void			*iommu_cookie;
+	u64				iommu_msi_iova : 58;
+	u64				iommu_msi_page_shift : 6;
 #endif
 #ifdef CONFIG_SYSFS
 	struct device_attribute		*sysfs_attrs;
@@ -285,28 +290,36 @@ struct msi_desc *msi_next_desc(struct device *dev, unsigned int domid,
 
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


