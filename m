Return-Path: <linux-kselftest+bounces-33277-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BB2ABAD77
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 05:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D513AF162
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 03:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7699C22DA17;
	Sun, 18 May 2025 03:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bwu+wpp6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EC922836C;
	Sun, 18 May 2025 03:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747538576; cv=fail; b=sBztmFYJH9PFWBsglmhi5XkhgK6oicPjflJw7OBPwklQTIKCUu04RHwwnyVuUv6gacVPVKPIToak4LSaO0vvsXUhM+T1aVyzMsKUNA0v+tlILoW35+6xKFTwmYflFHJCkO7Z7KD2K5ToJG9BmVT3pmFhVhtqDGY4zqauKfyZPpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747538576; c=relaxed/simple;
	bh=d5fbsTEREgx3RowD4C9k9alZ5lUmpc/j1mwXy1Qg+98=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OzFMmuJYpsPmbsrYVxPpULijp29Ae7oh3uAqWnT7U5fPmZsHQPJ4goJuiTYPiFmFvubICEFOjHOGAa4akO4X09WS61pCiwEt4x0s/YM5f0hv78v6ZridhZjednEwXYqQBtljoUyhkXsiNWmQBWoSimr46zF/5LUU4GvmHX9PyxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bwu+wpp6; arc=fail smtp.client-ip=40.107.101.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnepywbi2QRevQDE303kTZxPdjMFg6tBl1YpacyYD8Z3FMHki57GeM2HZwG7T0E5lI2ThV+3A8jTlhncNG6Q4kU5DPPTCKSgoyrsFpTWkDCUz00aYKFE6eex3ddYSY0ghN6aJa/0QhBYOcSWiKtV+Yldc/HKQEQ0dtuiA2DBP/W4bJfZeJVT8ZRazDjs03yrR/cvmMMg8tgU26l6BQf3+kmEkzbLkuYD+KPlakoUtcpp2UNn2Wet/8tnwNTodGMbT4ufjPUYHenoSbBj+gRRsk/SN9bQbMPGPrQoCAhtYArn930Kpkzw11y/sROf4JlLPfmhQbY4oynAZkWqT3c7lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWcYO41pXnpoZlHcRyY6TLZlL2QvihN+/PDc2nFnidg=;
 b=cAZkWU40PR8eBV7728n6YBW/shnY4VjOpyP+Zo6zzQ7I2jZZIS1LMBB59Raj2PBPUXfbBjLBQdYxP5WinROpaP10vCAHdeNiwSG07+xvDar6DoBmKzD57ErSxVAqDj2WESnphXiLh7Ejo8rzMjmFDIn/L4BSWGT2ylkfaFiZNW/hfP6n+QoBQW6PQ9zQBFAjtmKuJeJQnWIUI9E19uIadpsJSNK25MUzv7Yj/3NFAwlr8Z0uqYbk0aZOrhAYlUDG01q58YkB+3DQSotJlGsP9j+1agdrk6bbN6ZdFhDIf3s2D5/m/YY1HXPHfg2WvgbHBWL29+DaE/jZfiFfI0tXHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWcYO41pXnpoZlHcRyY6TLZlL2QvihN+/PDc2nFnidg=;
 b=Bwu+wpp6Cp188dvHdZNhtGlgxSoH1Fw4cxpI4+9Yt6yyu+uZPdHxT6C5ah5O8fJh34pmK1nGeoKlH5zaSW9ewqnVet0+p8Z4vJbfhrRHkwmSOsFJd8N/rmL9PeF473r5BYdzNYKRRqMqEJBG0qvEpxdFcjs3Mvx3np8v1I74IjQHKiGpriP68K68mewINn0NagtK1prL60P6g71Q/J0GOSXbMdX8ybbnlbRX4isS0LgQlGQw3zdeLyIo873DtLwOx+QKdF0y4qC0RXWgVihwl0vY8j6HZG9yMKDllqQPhosgnlZ7CNtAohwaAjXb5c5spsXf8uMRQAgI6kuB4HnFEw==
Received: from DM6PR12CA0028.namprd12.prod.outlook.com (2603:10b6:5:1c0::41)
 by BY5PR12MB4131.namprd12.prod.outlook.com (2603:10b6:a03:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Sun, 18 May
 2025 03:22:45 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:1c0:cafe::84) by DM6PR12CA0028.outlook.office365.com
 (2603:10b6:5:1c0::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.18 via Frontend Transport; Sun,
 18 May 2025 03:22:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Sun, 18 May 2025 03:22:44 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 17 May
 2025 20:22:36 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 17 May
 2025 20:22:27 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 17 May 2025 20:22:25 -0700
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
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v5 17/29] iommufd: Add mmap interface
Date: Sat, 17 May 2025 20:21:34 -0700
Message-ID: <769a7395def9f68c1ac684fa08a0221957e0de6d.1747537752.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747537752.git.nicolinc@nvidia.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|BY5PR12MB4131:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b613306-cd46-41a1-cea8-08dd95bb41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P55xQcII5hvZgBvNwdpwtuMcBMwvHYsDgS/Z2QVDrmrBIxQ7/BGDNUIAen3s?=
 =?us-ascii?Q?Q7kE5Oq98OdQTXUC4Ejz3AURWhzaoPRsXJxiFQyRYwZhvbhGAQKPvmekOvam?=
 =?us-ascii?Q?zh3NgfcsDLMlCnXU0q3eT8c3ArzHGUOzEWooY5I6HnC8Vq/5KU8QhETRzrPD?=
 =?us-ascii?Q?cvCc5oRfM7IDKrl1noXdS3AwbDraK3EwRSPga+O/+kgXZWZB5T5cIisVzXAB?=
 =?us-ascii?Q?4yKDU1ZJpIOv1BKi3gn1C+nPBKgNMOyyT7EUcPhOvR807xQW2bWLlQrlfz9B?=
 =?us-ascii?Q?tjxQuIBsHRyhAuw4Km09T0GfjWcRyWAZMyHRSdgCMORdTy47S1gvJuRbwLow?=
 =?us-ascii?Q?mb5d7++qXeKHgiytje6YRo4Ti+r03tB1yVXUvA5Ifd8kDjLQhpzLInHTVwOW?=
 =?us-ascii?Q?SvkyHaJQPvcVswsJtpXJMqZhtaE9GhEvVc25PtZHfXWJXvVBzyTq7mFh2jeL?=
 =?us-ascii?Q?d14aluIcEpQyXCwUfHPFaP7kI6/zMdrEnyzpXm0RrNTkwElq8IufVmE/7EUy?=
 =?us-ascii?Q?nJpLKYDUTXsEdAPDTskd/tTDGyBikG/z77gh3tL163WoERNfFdYz7Co3MQ5+?=
 =?us-ascii?Q?g7mP1hlF19UEEde8/mIgYRiNX+EjaGOwtF9dgUMmx9XKa2kX4UHq84qLj4te?=
 =?us-ascii?Q?rItdF/G31aiv+lodGnKmRcr/OjCS2XkuMEOYRiP2wly83DqKh13oaQe+wqbh?=
 =?us-ascii?Q?r6NGA+qog6BxIt7LwEASJESh6vcG7Hp5ktHzeRVV8CCkXEdRNvVJxG0HqW+o?=
 =?us-ascii?Q?yRnCLFLBOHv6B2Ixf/SjuYpopJSM8nXmVEcDz2w4fWfMmR49ifPZ3ekdNyME?=
 =?us-ascii?Q?o+I3mJ+ddGPPOUfq4nKd9zCNZ65YkwY395+6NQnta++kA3IdeJk2hqL/qxy6?=
 =?us-ascii?Q?ZZv38C7ZoZRAT3Vn43HBIaeQe9zXMYJ0U50HemDKKcf2Hx5IRwkOyLoDuZXe?=
 =?us-ascii?Q?D7sr+xFiAgKMeX8l7KQRsAS/saaJBwtXTeImGENvpWYOEaCH77/D5Q/HyLHB?=
 =?us-ascii?Q?oQffVkWWXjg3AHVVYkNlB33s4rxJKqG9ylAFTrd9twK8cEZWPrzseOnnPTIN?=
 =?us-ascii?Q?Y1w0oDCkKJyIi8zeYnP2tUhLTLU0heuq1ufK1Etf7R+9z2o64ukvCdMtnAWz?=
 =?us-ascii?Q?x9jZNCX61Tm64BNfEbI+TVz+ZYWZXC4pwwFBxoTsQOhHat14lUrQHj4ejKIV?=
 =?us-ascii?Q?6dPGO9aJTipwt3k24JD9QIU9Kb6V2sUSIHADd3AxzoDt8WU96MhK9qFAo/4H?=
 =?us-ascii?Q?zqdICaQvVDW20DDONSF6KIFB1p69G/UycJiPVsO4T81pMm4tvVAZitveZiw0?=
 =?us-ascii?Q?kPaQoGPV4rft7cjlHMMAKXvCWdJLgPe5YIZld/NnEwV/bKbgb4U8AM7R98pV?=
 =?us-ascii?Q?D1DKhyAcWblhW1TF/O2TzRJcRiHc49U/S6BSmbD0wTOUA1GjbICGEji+Fkq5?=
 =?us-ascii?Q?SjIodiLluLBrnAfdxgavu7eE7a5Fd99wQG+T/rPkrD0OUIXJdRx9X8J/nyNU?=
 =?us-ascii?Q?wYXibW5yh0xwL5FR2OJVLMifjOtfMYuva4Yc?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 03:22:44.7904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b613306-cd46-41a1-cea8-08dd95bb41a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4131

For vIOMMU passing through HW resources to user space (VMs), allowing a VM
to control the passed through HW directly by accessing hardware registers,
add an mmap infrastructure to map the physical MMIO pages to user space.

Maintain an maple tree per ictx as a translation table managing mmappable
regions, from an allocated for-user mmap offset to an iommufd_mmap struct,
where it stores the real PFN range for an io_remap_pfn_range call.

Keep track of the lifecycle of the mmappable region by taking refcount of
its owner, so as to enforce user space to unmap the region first before it
can destroy its owner object.

To allow an IOMMU driver to add and delete mmappable regions onto/from the
maple tree, add iommufd_viommu_alloc/destroy_mmap helpers.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 14 ++++++
 include/linux/iommufd.h                 | 45 ++++++++++++++++++
 drivers/iommu/iommufd/driver.c          | 51 +++++++++++++++++++++
 drivers/iommu/iommufd/main.c            | 61 +++++++++++++++++++++++++
 4 files changed, 171 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index a94d04ab0d2c..718a3161d3fa 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -7,6 +7,7 @@
 #include <linux/iommu.h>
 #include <linux/iommufd.h>
 #include <linux/iova_bitmap.h>
+#include <linux/maple_tree.h>
 #include <linux/rwsem.h>
 #include <linux/uaccess.h>
 #include <linux/xarray.h>
@@ -44,6 +45,7 @@ struct iommufd_ctx {
 	struct xarray groups;
 	wait_queue_head_t destroy_wait;
 	struct rw_semaphore ioas_creation_lock;
+	struct maple_tree mt_mmap;
 
 	struct mutex sw_msi_lock;
 	struct list_head sw_msi_list;
@@ -55,6 +57,18 @@ struct iommufd_ctx {
 	struct iommufd_ioas *vfio_ioas;
 };
 
+/* Entry for iommufd_ctx::mt_mmap */
+struct iommufd_mmap {
+	struct iommufd_object *owner;
+
+	/* Allocated start position in mt_mmap tree */
+	unsigned long startp;
+
+	/* Physical range for io_remap_pfn_range() */
+	unsigned long mmio_pfn;
+	unsigned long num_pfns;
+};
+
 /*
  * The IOVA to PFN map. The map automatically copies the PFNs into multiple
  * domains and permits sharing of PFNs between io_pagetable instances. This
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index a89797307379..5111a6b312c2 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -276,6 +276,11 @@ int _iommufd_object_depend(struct iommufd_object *obj_dependent,
 			   struct iommufd_object *obj_depended);
 void _iommufd_object_undepend(struct iommufd_object *obj_dependent,
 			      struct iommufd_object *obj_depended);
+int _iommufd_alloc_mmap(struct iommufd_ctx *ictx, struct iommufd_object *owner,
+			phys_addr_t mmio_addr, size_t length,
+			unsigned long *offset);
+void _iommufd_destroy_mmap(struct iommufd_ctx *ictx,
+			   struct iommufd_object *owner, unsigned long offset);
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id);
 int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
@@ -310,6 +315,20 @@ _iommufd_object_undepend(struct iommufd_object *obj_dependent,
 {
 }
 
+static inline int _iommufd_alloc_mmap(struct iommufd_ctx *ictx,
+				      struct iommufd_object *owner,
+				      phys_addr_t mmio_addr, size_t length,
+				      unsigned long *offset)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void _iommufd_destroy_mmap(struct iommufd_ctx *ictx,
+					 struct iommufd_object *owner,
+					 unsigned long offset)
+{
+}
+
 static inline struct device *
 iommufd_viommu_find_dev(struct iommufd_viommu *viommu, unsigned long vdev_id)
 {
@@ -403,4 +422,30 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 		_iommufd_object_undepend(&dependent->member.obj,               \
 					 &depended->member.obj);               \
 	})
+
+/*
+ * Helpers for IOMMU driver to alloc/destroy an mmapable area for a structure.
+ *
+ * To support an mmappable MMIO region, kernel driver must first register it to
+ * iommufd core to allocate an @out_offset, in the context of an driver-struct
+ * allocation (e.g. viommu_alloc op). Then, it should report to user space this
+ * @out_offset and the @length of the MMIO region for mmap syscall.
+ */
+#define iommufd_viommu_alloc_mmap(viommu, member, mmio, length, out_offset)    \
+	({                                                                     \
+		static_assert(__same_type(struct iommufd_viommu,               \
+					  viommu->member));                    \
+		static_assert(offsetof(typeof(*viommu), member.obj) == 0);     \
+		_iommufd_alloc_mmap(viommu->member.ictx, &viommu->member.obj,  \
+				    mmio, length, out_offset);                 \
+	})
+
+#define iommufd_viommu_destroy_mmap(viommu, member, offset)                    \
+	({                                                                     \
+		static_assert(__same_type(struct iommufd_viommu,               \
+					  viommu->member));                    \
+		static_assert(offsetof(typeof(*viommu), member.obj) == 0);     \
+		_iommufd_destroy_mmap(viommu->member.ictx,                     \
+				      &viommu->member.obj, offset);            \
+	})
 #endif
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 529968126f85..7acddffb04b3 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -82,6 +82,57 @@ void _iommufd_object_undepend(struct iommufd_object *obj_dependent,
 }
 EXPORT_SYMBOL_NS_GPL(_iommufd_object_undepend, "IOMMUFD");
 
+/*
+ * Allocate an @offset to return to user space to use for an mmap() syscall
+ *
+ * Driver should use a per-structure helper in include/linux/iommufd.h
+ */
+int _iommufd_alloc_mmap(struct iommufd_ctx *ictx, struct iommufd_object *owner,
+			phys_addr_t mmio_addr, size_t length,
+			unsigned long *offset)
+{
+	struct iommufd_mmap *immap;
+	unsigned long startp;
+	int rc;
+
+	if (!PAGE_ALIGNED(mmio_addr))
+		return -EINVAL;
+	if (!length || !PAGE_ALIGNED(length))
+		return -EINVAL;
+
+	immap = kzalloc(sizeof(*immap), GFP_KERNEL);
+	if (!immap)
+		return -ENOMEM;
+	immap->owner = owner;
+	immap->num_pfns = length >> PAGE_SHIFT;
+	immap->mmio_pfn = mmio_addr >> PAGE_SHIFT;
+
+	rc = mtree_alloc_range(&ictx->mt_mmap, &startp, immap, immap->num_pfns,
+			       0, U32_MAX >> PAGE_SHIFT, GFP_KERNEL);
+	if (rc < 0) {
+		kfree(immap);
+		return rc;
+	}
+
+	immap->startp = startp;
+	/* mmap() syscall will right-shift the offset in vma->vm_pgoff */
+	*offset = startp << PAGE_SHIFT;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(_iommufd_alloc_mmap, "IOMMUFD");
+
+/* Driver should use a per-structure helper in include/linux/iommufd.h */
+void _iommufd_destroy_mmap(struct iommufd_ctx *ictx,
+			   struct iommufd_object *owner, unsigned long offset)
+{
+	struct iommufd_mmap *immap;
+
+	immap = mtree_erase(&ictx->mt_mmap, offset >> PAGE_SHIFT);
+	WARN_ON_ONCE(!immap || immap->owner != owner);
+	kfree(immap);
+}
+EXPORT_SYMBOL_NS_GPL(_iommufd_destroy_mmap, "IOMMUFD");
+
 /* Caller should xa_lock(&viommu->vdevs) to protect the return value */
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id)
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 0750e740fa1d..18c636fbc035 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -225,6 +225,7 @@ static int iommufd_fops_open(struct inode *inode, struct file *filp)
 	xa_init_flags(&ictx->objects, XA_FLAGS_ALLOC1 | XA_FLAGS_ACCOUNT);
 	xa_init(&ictx->groups);
 	ictx->file = filp;
+	mt_init_flags(&ictx->mt_mmap, MT_FLAGS_ALLOC_RANGE);
 	init_waitqueue_head(&ictx->destroy_wait);
 	mutex_init(&ictx->sw_msi_lock);
 	INIT_LIST_HEAD(&ictx->sw_msi_list);
@@ -429,11 +430,71 @@ static long iommufd_fops_ioctl(struct file *filp, unsigned int cmd,
 	return ret;
 }
 
+static void iommufd_fops_vma_open(struct vm_area_struct *vma)
+{
+	struct iommufd_mmap *immap = vma->vm_private_data;
+
+	refcount_inc(&immap->owner->users);
+}
+
+static void iommufd_fops_vma_close(struct vm_area_struct *vma)
+{
+	struct iommufd_mmap *immap = vma->vm_private_data;
+
+	refcount_dec(&immap->owner->users);
+}
+
+static const struct vm_operations_struct iommufd_vma_ops = {
+	.open = iommufd_fops_vma_open,
+	.close = iommufd_fops_vma_close,
+};
+
+/* The vm_pgoff must be pre-allocated from mt_mmap, and given to user space */
+static int iommufd_fops_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct iommufd_ctx *ictx = filp->private_data;
+	size_t length = vma->vm_end - vma->vm_start;
+	struct iommufd_mmap *immap;
+	int rc;
+
+	if (!PAGE_ALIGNED(length))
+		return -EINVAL;
+	if (!(vma->vm_flags & VM_SHARED))
+		return -EINVAL;
+	if (vma->vm_flags & VM_EXEC)
+		return -EPERM;
+
+	/* vma->vm_pgoff carries an index to an mtree entry (immap) */
+	immap = mtree_load(&ictx->mt_mmap, vma->vm_pgoff);
+	if (!immap)
+		return -ENXIO;
+	/* Validate the vm_pgoff and length against the registered region */
+	if (vma->vm_pgoff != immap->startp)
+		return -ENXIO;
+	if (length != immap->num_pfns << PAGE_SHIFT)
+		return -ENXIO;
+
+	vma->vm_pgoff = 0;
+	vma->vm_private_data = immap;
+	vma->vm_ops = &iommufd_vma_ops;
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	rc = io_remap_pfn_range(vma, vma->vm_start, immap->mmio_pfn, length,
+				vma->vm_page_prot);
+	if (rc)
+		return rc;
+
+	/* vm_ops.open won't be called for mmap itself. */
+	refcount_inc(&immap->owner->users);
+	return rc;
+}
+
 static const struct file_operations iommufd_fops = {
 	.owner = THIS_MODULE,
 	.open = iommufd_fops_open,
 	.release = iommufd_fops_release,
 	.unlocked_ioctl = iommufd_fops_ioctl,
+	.mmap = iommufd_fops_mmap,
 };
 
 /**
-- 
2.43.0


