Return-Path: <linux-kselftest+bounces-26089-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0291BA2D509
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 10:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DFC61886F25
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 09:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9E81BEF7D;
	Sat,  8 Feb 2025 09:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B8moX7oG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213401BCA05;
	Sat,  8 Feb 2025 09:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739005416; cv=fail; b=WPc33kCh4RDYfpsSXl89YuRexjMsMqObGweC8vI2bIv1Uaig0lUVQwBvqFk4MiPoPS+P0mdYQlfpxmlZkQH0zNpEslpY9VJjkkGCX4L4fXkaYq9HuQ1Z+F6XFmVeh5WIKM+2DzFkIuG0iW+PHm/F4qC/eX0pk7RJvDgbU4iAxOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739005416; c=relaxed/simple;
	bh=mNHUWADuE4/L8TfuGDTxBZQzbSA07WRpFSBpOD0u+Yg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sJMV9dBQNpcYP850zm4Ial5/eMtzNXcvxCjDX1b9icVLMr4q2zpwdDLpPj6h+b2UKM5GeD+jv0ZX++uQfg8S8KCkDMnl6XDjL/GCuV1WvqgFYSC/n/7wMejQlSot8OeMTbcS5BF+RavBvPYLNJARH0M06PF7yoyy2p68EpGkCa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B8moX7oG; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BsBqaLlkn2K2Q4DrIxqJkwcKGj4XJbxRRoHpVklHUtCTA/zMqCyvThq6MSxy3+ACHggtqY6Frn4VaZQoCR/6nzfeQPQnm6gsySdpT7nmWPjhVH1rsAzlXTvkQlXF3wJnNCAwUzZDshlA0zFYGumXvjIOz+9qCZnhpskUeDsMT1ZTS/1wWSwFvvEweY5U7kr841Wv8bz/7WMp+2rEUHOFMoao1bw7NgZ4t4LQLsuXoFyh47KOFQvd/fQS0pbfDzr5Gpn3TF/VwNZYQhpZhA6doSxAxCV6NgIhOt2PPFWTGRELbARWMz8t69XtgMIeWzCRSmI6NSDu6jcGcflC5jNW/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e10194nY6YCXaIkvrXqOGrpt8Z+odIm8Lm8AopAxOBg=;
 b=wq+MwYtET8g4dg9Ppc+4vYXHNfziQJ/4rI7dABnNUvgKomLVIlY6C6yaD5trng0fVD+b3mQ8bTh5Ofm2KiDk5wQe8w6jtj0++1zJcP23o+CY78oW2CuvA7mG7y/U73dY5GB/zaQOHjNe5g82FHWJyQdoB6UhG9g6PvhcJ4klwbhH4KA03VWqmwZ7zP0p6VfEiVm9IjOs686av7+KobFN0kA/+WYFq3SxDBLOFPYIHhrbkFxk8DoYqLvZkzUZUfMs/u1QEyM+3T4BJq9riD12SwuAkjuqtbFfiji+SbdKt1E8X6XSecdRi7EA6JsDLrGfPXrWgAgrTcimOqE0lgTI9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e10194nY6YCXaIkvrXqOGrpt8Z+odIm8Lm8AopAxOBg=;
 b=B8moX7oGV7WXjjlHEc/3g1NaHFiHCfEscty0h51MLvhA7tiUcCPEZMojoUAod5fhDT/5nByyVq5iprtq8T09VI8bY8UFQ4n8aQ3UphkMV82QjVY8OxhHrx2uHeTVZwtxffhlicWWFCX0q2BW8Yt25y40Kbov83bKEc9Sjh8iQRY/AaJw78+HdeogsZMUc8B3L3fapxynT2uDhHhW6IMp/d+bEVgng2CHS10YY7VAAAj3Lex3965lgEd8BKBdAamNKA3kLjTQkYIdIuCxQ1d+rKrJqhskqIawe75vDz/530nJbwGTGzYQL6Z66IFC6Fnh85b2KDEifRnmVQg9GOkM6w==
Received: from MN2PR18CA0025.namprd18.prod.outlook.com (2603:10b6:208:23c::30)
 by MW4PR12MB7334.namprd12.prod.outlook.com (2603:10b6:303:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Sat, 8 Feb
 2025 09:03:27 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:208:23c:cafe::ff) by MN2PR18CA0025.outlook.office365.com
 (2603:10b6:208:23c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.29 via Frontend Transport; Sat,
 8 Feb 2025 09:03:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 09:03:27 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 8 Feb 2025
 01:03:14 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 8 Feb
 2025 01:03:14 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 8 Feb 2025 01:03:13 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <tglx@linutronix.de>,
	<maz@kernel.org>
CC: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <baolu.lu@linux.intel.com>, <yi.l.liu@intel.com>,
	<yury.norov@gmail.com>, <jacob.pan@linux.microsoft.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v1 06/13] iommufd: Implement sw_msi support natively
Date: Sat, 8 Feb 2025 01:02:39 -0800
Message-ID: <98233d5817e66bb7363090526b53422436894051.1739005085.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|MW4PR12MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: 245a0729-4ce6-4dcb-c966-08dd481f7381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U1kp0WGwiB7qbk9aKpspKKxlHwbT7t9CXqlHOSpNmu57qCo1Z4lI+J11JcWB?=
 =?us-ascii?Q?f7XibUnxmlsJh6Kva0codYYIaisO6f0UycBcYPtfmR2sb99/rC0eUckVsJUL?=
 =?us-ascii?Q?UeOniGuKnqde85H23xvfzcieCfCSeCyhpQYynOFOAFAWmSFEHU9UvEKAaW7g?=
 =?us-ascii?Q?jWZy23nBZ/gLODgl1N1IL1k8KAP+HBR9dDazQVpEXor5WHsKRBNFv6ZmZUcl?=
 =?us-ascii?Q?orBFU3+mm9I0Puk3E6GzckR84OiS9Af8uSOzdg1UXYCCrkgVr77pqvik0Bs9?=
 =?us-ascii?Q?2iu+gDGcHCBzPpYcpZSkjWnfE/cbJUihkAhWS1RsL3An1YsB780y4zunUgSK?=
 =?us-ascii?Q?SB1WUBlPoYcneCFUadxZ/2vQDjimQexJrWazl2Wb8IcDavcT+U24tX+fc8C1?=
 =?us-ascii?Q?+TAccj/qWX3gMbQ3xnj1QqQ0hLZ4whRgjEEg0favI5W3KyHd4ZwIoTaMK2/W?=
 =?us-ascii?Q?Q7sVCHIgWc7Y24kxH3zeNcB9M0bjf03qr+aDWA3/iaiL6g7kiIwFVISas1+0?=
 =?us-ascii?Q?LaRVV1T2pcaZBzTl0MPMfVIkdh6JIBxtjjsB2M/qn4Oa+P/u3Xt04Vx3jW4L?=
 =?us-ascii?Q?wLmNT2FqjcmOLOmEqaRW12l1uNqo7d+G9eNM8PE835pPq26TkVdWgaGwf/U4?=
 =?us-ascii?Q?aF5AvDZsgUZ/e87N/nO2C8B7zpnyz6nzIW6V+hsD9ALzyiE/8tEf/w8lYpnA?=
 =?us-ascii?Q?JqR/1TeYO/OzYnHahjmR+GtBzwy9VoqU0L2zJmmKUp8OPCM9pS8uzUiv7VoI?=
 =?us-ascii?Q?gwJ0Tp3zJOVmwUqnQGr+eu4BRYUKPXLHTsq+Zgiwz+Jf3ccU3nM06RxJfAQL?=
 =?us-ascii?Q?dnGpPYRBkwgmZJ7nZbPh9V9FyMMJ6HB9G+Jl7Fq9qBaYaN84y+yNpeoKK6Yj?=
 =?us-ascii?Q?6LoPaOu6d5GDDbWGWWxnxFSWxqIAeHZcusNYaspbolEutm4Juj87irQPpTar?=
 =?us-ascii?Q?WtNrSxCTOdyEAD5xBlRPevm321C7xqV6wF96ly5CgdiBF6uyNsyWUMqQb1YA?=
 =?us-ascii?Q?rG967laN7nVCDAQAhK4VIGAWBPm9Q/soX1WubzgWCXlO4UBoiVCSK0p6FifZ?=
 =?us-ascii?Q?yjkpo7tqLFZoPU9ff60lLrtDOX/WjFgqch8d9DGcjmgRlfIQZqfqvu7wdN2M?=
 =?us-ascii?Q?qldl8HXOmq7BUTmyEX3bHM7ztn4P+b3WPhu8G/QH0+O4//5AYPvhUhOot37/?=
 =?us-ascii?Q?sdBf4fgzacZaKdrc6FvuVksJmrdQUQhZDtM/CKxc12Mj07nfym89jnm/4829?=
 =?us-ascii?Q?vDrtrZyGewia/vrIUPxh3a6w1DOimJJYJCj82wem92KGLML2wa6BAi1i5k+r?=
 =?us-ascii?Q?rLYJb6dLg7Fc6UJA5ob+RK7oEOasxDQtCpMxHGOpv0EnijLLbUhFY8QbA2Zz?=
 =?us-ascii?Q?MGVx6O8mdVPckjpswVS5OwoYMkvCoIZEKqZJb/mhUbpBvIPICmCBi+K+bNi8?=
 =?us-ascii?Q?K5hSSf6+Gl9/9JOGbCDzDN225f22wt1ZZ98/H1dnw7QNzKfIEwMrfvcIPANS?=
 =?us-ascii?Q?mov6loplYETkYcg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 09:03:27.3362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 245a0729-4ce6-4dcb-c966-08dd481f7381
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7334

From: Jason Gunthorpe <jgg@nvidia.com>

iommufd has a model where the iommu_domain can be changed while the VFIO
device is attached. In this case the MSI should continue to work. This
corner case has not worked because the dma-iommu implementation of sw_msi
is tied to a single domain.

Implement the sw_msi mapping directly and use a global per-fd table to
associate assigned iova to the MSI pages. This allows the MSI pages to
be loaded into a domain before it is attached ensuring that MSI is not
disrupted.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  23 +++-
 drivers/iommu/iommufd/device.c          | 174 +++++++++++++++++++-----
 drivers/iommu/iommufd/hw_pagetable.c    |   3 +
 drivers/iommu/iommufd/main.c            |   9 ++
 4 files changed, 175 insertions(+), 34 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 8e0e3ab64747..246297452a44 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -19,6 +19,22 @@ struct iommu_group;
 struct iommu_option;
 struct iommufd_device;
 
+struct iommufd_sw_msi_map {
+	struct list_head sw_msi_item;
+	phys_addr_t sw_msi_start;
+	phys_addr_t msi_addr;
+	unsigned int pgoff;
+	unsigned int id;
+};
+
+/* Bitmap of struct iommufd_sw_msi_map::id */
+struct iommufd_sw_msi_maps {
+	DECLARE_BITMAP(bitmap, 64);
+};
+
+int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
+		   phys_addr_t msi_addr);
+
 struct iommufd_ctx {
 	struct file *file;
 	struct xarray objects;
@@ -26,6 +42,10 @@ struct iommufd_ctx {
 	wait_queue_head_t destroy_wait;
 	struct rw_semaphore ioas_creation_lock;
 
+	struct mutex sw_msi_lock;
+	struct list_head sw_msi_list;
+	unsigned int sw_msi_id;
+
 	u8 account_mode;
 	/* Compatibility with VFIO no iommu */
 	u8 no_iommu_mode;
@@ -283,10 +303,10 @@ struct iommufd_hwpt_paging {
 	struct iommufd_ioas *ioas;
 	bool auto_domain : 1;
 	bool enforce_cache_coherency : 1;
-	bool msi_cookie : 1;
 	bool nest_parent : 1;
 	/* Head at iommufd_ioas::hwpt_list */
 	struct list_head hwpt_item;
+	struct iommufd_sw_msi_maps present_sw_msi;
 };
 
 struct iommufd_hwpt_nested {
@@ -383,6 +403,7 @@ struct iommufd_group {
 	struct iommu_group *group;
 	struct iommufd_hw_pagetable *hwpt;
 	struct list_head device_list;
+	struct iommufd_sw_msi_maps required_sw_msi;
 	phys_addr_t sw_msi_start;
 };
 
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 360ba3ed8545..e435ba13a8a5 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -5,6 +5,7 @@
 #include <linux/iommufd.h>
 #include <linux/slab.h>
 #include <uapi/linux/iommufd.h>
+#include <linux/msi.h>
 
 #include "../iommu-priv.h"
 #include "io_pagetable.h"
@@ -293,36 +294,152 @@ u32 iommufd_device_to_id(struct iommufd_device *idev)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_to_id, "IOMMUFD");
 
+/*
+ * Get a iommufd_sw_msi_map for the msi physical address requested by the irq
+ * layer. The mapping to IOVA is global to the iommufd file descriptor, every
+ * domain that is attached to a device using the same MSI parameters will use
+ * the same IOVA.
+ */
+static struct iommufd_sw_msi_map *
+iommufd_sw_msi_get_map(struct iommufd_ctx *ictx, phys_addr_t msi_addr,
+		       phys_addr_t sw_msi_start)
+{
+	struct iommufd_sw_msi_map *cur;
+	unsigned int max_pgoff = 0;
+
+	lockdep_assert_held(&ictx->sw_msi_lock);
+
+	list_for_each_entry(cur, &ictx->sw_msi_list, sw_msi_item) {
+		if (cur->sw_msi_start != sw_msi_start)
+			continue;
+		max_pgoff = max(max_pgoff, cur->pgoff + 1);
+		if (cur->msi_addr == msi_addr)
+			return cur;
+	}
+
+	if (ictx->sw_msi_id >=
+	    BITS_PER_BYTE * sizeof_field(struct iommufd_sw_msi_maps, bitmap))
+		return ERR_PTR(-EOVERFLOW);
+
+	cur = kzalloc(sizeof(*cur), GFP_KERNEL);
+	if (!cur)
+		cur = ERR_PTR(-ENOMEM);
+	cur->sw_msi_start = sw_msi_start;
+	cur->msi_addr = msi_addr;
+	cur->pgoff = max_pgoff;
+	cur->id = ictx->sw_msi_id++;
+	list_add_tail(&cur->sw_msi_item, &ictx->sw_msi_list);
+	return cur;
+}
+
+static int iommufd_sw_msi_install(struct iommufd_ctx *ictx,
+				  struct iommufd_hwpt_paging *hwpt_paging,
+				  struct iommufd_sw_msi_map *msi_map)
+{
+	unsigned long iova;
+
+	lockdep_assert_held(&ictx->sw_msi_lock);
+
+	iova = msi_map->sw_msi_start + msi_map->pgoff * PAGE_SIZE;
+	if (!test_bit(msi_map->id, hwpt_paging->present_sw_msi.bitmap)) {
+		int rc;
+
+		rc = iommu_map(hwpt_paging->common.domain, iova,
+			       msi_map->msi_addr, PAGE_SIZE,
+			       IOMMU_WRITE | IOMMU_READ | IOMMU_MMIO,
+			       GFP_KERNEL_ACCOUNT);
+		if (rc)
+			return rc;
+		__set_bit(msi_map->id, hwpt_paging->present_sw_msi.bitmap);
+	}
+	return 0;
+}
+
+static struct iommufd_attach_handle *
+iommu_group_get_iommufd_handle(struct iommu_group *group)
+{
+	struct iommu_attach_handle *handle;
+
+	handle = iommu_attach_handle_get(group, IOMMU_NO_PASID, 0);
+	if (IS_ERR(handle))
+		return NULL;
+	return to_iommufd_handle(handle);
+}
+
+/*
+ * Called by the irq code if the platform translates the MSI address through the
+ * IOMMU. msi_addr is the physical address of the MSI page. iommufd will
+ * allocate a fd global iova for the physical page that is the same on all
+ * domains and devices.
+ */
+#ifdef CONFIG_IRQ_MSI_IOMMU
+int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
+		   phys_addr_t msi_addr)
+{
+	struct device *dev = msi_desc_to_dev(desc);
+	struct iommufd_hwpt_paging *hwpt_paging;
+	struct iommufd_attach_handle *handle;
+	struct iommufd_sw_msi_map *msi_map;
+	struct iommufd_ctx *ictx;
+	unsigned long iova;
+	int rc;
+
+	handle = iommu_group_get_iommufd_handle(dev->iommu_group);
+	if (!handle)
+		return 0;
+	hwpt_paging = find_hwpt_paging(domain->iommufd_hwpt);
+
+	/* No IOMMU_RESV_SW_MSI means no change to the msi_msg */
+	if (handle->idev->igroup->sw_msi_start == PHYS_ADDR_MAX)
+		return 0;
+
+	ictx = handle->idev->ictx;
+	guard(mutex)(&ictx->sw_msi_lock);
+	/*
+	 * The input msi_addr is the exact byte offset of the MSI doorbell, we
+	 * assume the caller has checked that it is contained with a MMIO region
+	 * that is secure to map at PAGE_SIZE.
+	 */
+	msi_map = iommufd_sw_msi_get_map(handle->idev->ictx,
+					 msi_addr & PAGE_MASK,
+					 handle->idev->igroup->sw_msi_start);
+	if (IS_ERR(msi_map))
+		return PTR_ERR(msi_map);
+
+	rc = iommufd_sw_msi_install(ictx, hwpt_paging, msi_map);
+	if (rc)
+		return rc;
+	__set_bit(msi_map->id, handle->idev->igroup->required_sw_msi.bitmap);
+
+	iova = msi_map->sw_msi_start + msi_map->pgoff * PAGE_SIZE;
+	msi_desc_set_iommu_msi_iova(desc, iova, PAGE_SHIFT);
+	return 0;
+}
+#endif
+
 static int iommufd_group_setup_msi(struct iommufd_group *igroup,
 				   struct iommufd_hwpt_paging *hwpt_paging)
 {
-	phys_addr_t sw_msi_start = igroup->sw_msi_start;
-	int rc;
+	struct iommufd_ctx *ictx = igroup->ictx;
+	struct iommufd_sw_msi_map *cur;
+
+	if (igroup->sw_msi_start == PHYS_ADDR_MAX)
+		return 0;
 
 	/*
-	 * If the IOMMU driver gives a IOMMU_RESV_SW_MSI then it is asking us to
-	 * call iommu_get_msi_cookie() on its behalf. This is necessary to setup
-	 * the MSI window so iommu_dma_prepare_msi() can install pages into our
-	 * domain after request_irq(). If it is not done interrupts will not
-	 * work on this domain.
-	 *
-	 * FIXME: This is conceptually broken for iommufd since we want to allow
-	 * userspace to change the domains, eg switch from an identity IOAS to a
-	 * DMA IOAS. There is currently no way to create a MSI window that
-	 * matches what the IRQ layer actually expects in a newly created
-	 * domain.
+	 * Install all the MSI pages the device has been using into the domain
 	 */
-	if (sw_msi_start != PHYS_ADDR_MAX && !hwpt_paging->msi_cookie) {
-		rc = iommu_get_msi_cookie(hwpt_paging->common.domain,
-					  sw_msi_start);
+	guard(mutex)(&ictx->sw_msi_lock);
+	list_for_each_entry(cur, &ictx->sw_msi_list, sw_msi_item) {
+		int rc;
+
+		if (cur->sw_msi_start != igroup->sw_msi_start ||
+		    !test_bit(cur->id, igroup->required_sw_msi.bitmap))
+			continue;
+
+		rc = iommufd_sw_msi_install(ictx, hwpt_paging, cur);
 		if (rc)
 			return rc;
-
-		/*
-		 * iommu_get_msi_cookie() can only be called once per domain,
-		 * it returns -EBUSY on later calls.
-		 */
-		hwpt_paging->msi_cookie = true;
 	}
 	return 0;
 }
@@ -386,17 +503,8 @@ static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 	return rc;
 }
 
-static struct iommufd_attach_handle *
-iommufd_device_get_attach_handle(struct iommufd_device *idev)
-{
-	struct iommu_attach_handle *handle;
-
-	handle =
-		iommu_attach_handle_get(idev->igroup->group, IOMMU_NO_PASID, 0);
-	if (IS_ERR(handle))
-		return NULL;
-	return to_iommufd_handle(handle);
-}
+#define iommufd_device_get_attach_handle(idev) \
+	iommu_group_get_iommufd_handle(idev->igroup->group)
 
 static void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
 				       struct iommufd_device *idev)
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 2641d50f46cf..7de6e914232e 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -156,6 +156,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			goto out_abort;
 		}
 	}
+	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
 
 	/*
 	 * Set the coherency mode before we do iopt_table_add_domain() as some
@@ -251,6 +252,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 		goto out_abort;
 	}
 	hwpt->domain->owner = ops;
+	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
 
 	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED)) {
 		rc = -EINVAL;
@@ -307,6 +309,7 @@ iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
 		goto out_abort;
 	}
 	hwpt->domain->owner = viommu->iommu_dev->ops;
+	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
 
 	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED)) {
 		rc = -EINVAL;
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index ccf616462a1c..b6fa9fd11bc1 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -227,6 +227,8 @@ static int iommufd_fops_open(struct inode *inode, struct file *filp)
 	xa_init(&ictx->groups);
 	ictx->file = filp;
 	init_waitqueue_head(&ictx->destroy_wait);
+	mutex_init(&ictx->sw_msi_lock);
+	INIT_LIST_HEAD(&ictx->sw_msi_list);
 	filp->private_data = ictx;
 	return 0;
 }
@@ -234,6 +236,8 @@ static int iommufd_fops_open(struct inode *inode, struct file *filp)
 static int iommufd_fops_release(struct inode *inode, struct file *filp)
 {
 	struct iommufd_ctx *ictx = filp->private_data;
+	struct iommufd_sw_msi_map *next;
+	struct iommufd_sw_msi_map *cur;
 	struct iommufd_object *obj;
 
 	/*
@@ -262,6 +266,11 @@ static int iommufd_fops_release(struct inode *inode, struct file *filp)
 			break;
 	}
 	WARN_ON(!xa_empty(&ictx->groups));
+
+	mutex_destroy(&ictx->sw_msi_lock);
+	list_for_each_entry_safe(cur, next, &ictx->sw_msi_list, sw_msi_item)
+		kfree(cur);
+
 	kfree(ictx);
 	return 0;
 }
-- 
2.43.0


