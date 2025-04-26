Return-Path: <linux-kselftest+bounces-31681-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E5EA9D7D9
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 08:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 430797B91DC
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 05:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1D21F78F2;
	Sat, 26 Apr 2025 05:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dwicOI/R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A061C6FF1;
	Sat, 26 Apr 2025 05:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745647156; cv=fail; b=XGHz9RAvnTOmBVx2gcjtZuu+zPn8MPK3gx6b9um6sisEsN0SBFn7+a8ljTBbcw5VNnNgM4aFRPzTf0KBLlb44y8JYcklDsRmSO3kNSqIC7rKMLeGWr4WHmOVR/4Lujhu54pv0JlB9rxhinFDvzxh6pbeKSfutA8zhhXiyob5MeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745647156; c=relaxed/simple;
	bh=XinIb6DnLTJCMYQvVppQi+P0TMoNTlqf+Z3MIKQMThE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L1X7txEQjDPZww/LictiG+IlOG1a6wI8FuukR7ekWFm9c71fwpAE2Lm9evXh1cpRcbYKRE8PJ5F6b4GpGOZDTv/0WpfMd6BtIyuIj60LQBIilJa+DsQe0r/Tog7BM4zIXxr+avN4+hm7BHNOLI3OaIvEmQFh/tye6j4KaNqbz/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dwicOI/R; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4pRi1tZ++lNUaSTR1WYUA/oyuCryRFC5rqvTxwneM3ZVBUZir10TCthxpc5pWcv4NhrxZ+4UrV6WIznIleypKmbc10nnncYml3IGpKzqCNUmq83fMWYi2lRvr2jExHST8Pbp/oRELk8qkjwJl6hJyz15wHmtcYHz3jjTgA0Q7gaTaIqmZg2iqO/hNOZgl5EwjiCkZMhutpMLWhiOVscxQ5pAztGuWhc3OTb+qllRT58NniJCWMhnSK39PVaguIMo82++JCIXPhNZ1FzmU9gRzZ8c8ouACyH8Pm1pUHV5YMIzFHEk9YfCxPQ0td4N3pRSs9COYGAWgxtZ7mG5+SUAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prHncsG8ZmvGvqxBs/nAt0Xba8x0zTBliZvmq4akvf0=;
 b=klqF8wnt3TrbK+JEd/tUeHfRUCu8n16UXaYGZue6FqKVt5hAMXlk+VKFQViSX8sRs+g1vgnZduk1H6Q9xVRgdggot3y5nmNuBN1C/UCAUP1emt3osIYACwVwgMv7YIKd5Ajn3wy+8+k+AWeZ9+LowV08/ITOsfv3SHNY0BXkx42NSYbZIgqD7BlhJ4xrOnPivhL1fH0SVTHQwI6NNsKh0aYkDgGnofpBrXCXqMz0T1ExlAmMRKn4GczjNr9giceWn13VdURrmfSbl6fZcfD7ZJtbxzci0dx46LrlbV3TUIqep7oyANZ8mA1zq0WAZQW4KYo3HkJYrWiJx48dv9CBWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prHncsG8ZmvGvqxBs/nAt0Xba8x0zTBliZvmq4akvf0=;
 b=dwicOI/Rxuc95xofF/UYq1jkD6bBBdDqZLfOWXYRA3lvFojtUHJfNuXM60S6AwAy/H7QAFTVtPU+JhNoc7I59wezr6FZDLs+KJJfnnKuz1MQw6NWjGgksyvgwqC+ykbPDrTVZvMf0B46CyU4NmzJu6DjfRSzvw1ELHc9lo18GvehRZP5qj35Fg10MwxiYso0Yc+YbcwfdJn5Q4nr/IPIqpyJmk93s+7EdKputEzDRjz1bOYz75M3qygiX7JHtqzPGwHur0nuTiSxT6GEvXgF+9L3OU0M5AGO1FdCiYlrOmiU7LAF4sOkxvnImVFXnHr82sJmlUtguZJjXwJYhLUSTA==
Received: from SN6PR04CA0106.namprd04.prod.outlook.com (2603:10b6:805:f2::47)
 by IA1PR12MB8078.namprd12.prod.outlook.com (2603:10b6:208:3f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Sat, 26 Apr
 2025 05:59:11 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:805:f2:cafe::fd) by SN6PR04CA0106.outlook.office365.com
 (2603:10b6:805:f2::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.30 via Frontend Transport; Sat,
 26 Apr 2025 05:59:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Sat, 26 Apr 2025 05:59:11 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Apr
 2025 22:59:00 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 25 Apr
 2025 22:59:00 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 25 Apr 2025 22:58:57 -0700
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
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: [PATCH v2 09/22] iommufd/viommu: Introduce IOMMUFD_OBJ_VCMDQ and its related struct
Date: Fri, 25 Apr 2025 22:58:04 -0700
Message-ID: <8bab0069503fa21b48298ed2ffe29a06963f71f5.1745646960.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745646960.git.nicolinc@nvidia.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|IA1PR12MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: ed8cd406-be80-43b4-b0d1-08dd84877738
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x0Qh03CeP7D6C2xtvPvIrClmZl1/7z6YI+dUvr5EbnWYC/+FHBxiRYog57EW?=
 =?us-ascii?Q?2WHcexDvvAGgwD4jdjjoQiPAo4XkxTD6MhO9VxbqUwDGCdkli6s5CQubdWLF?=
 =?us-ascii?Q?VQ0VLG716Ng+1HoAen8mdqGFdzNGrfwru7pjCkVJyLkWO6wFfBeJg5StTMKX?=
 =?us-ascii?Q?BaqBSwuUi5VRqzMXiXatleF8jdCEhg6IwvJcAzPWylJSQff4f1MHj1Lrhnn6?=
 =?us-ascii?Q?3u/fW/kmfsQ7nQL5VvQ4X8TbgcdKX3lsKQBExJuUAwEDQ8ln0DfJvAXEbUD+?=
 =?us-ascii?Q?7vZ9NPe3QG2MnJC7eaQl60z8BrqBOoykNUTnynZ/bdRXeCE70UIlBIxFqu2u?=
 =?us-ascii?Q?vwjOq2BZj9oFZ7pAjEOkkUb4vdKnuiBIPBW+f1vTAGhwDRBjkBf5UlSuD4w6?=
 =?us-ascii?Q?b2tSz2MhFpsLMmGF/FvRgn0gYq2KY8YVRB49oCLpt++uufIrWYsSEp8YPLf8?=
 =?us-ascii?Q?b7uudoP41zpUyMh1ZxB1XPt1G6pZyCCfsOoNvV/oUOsEMrfURYviQciStHd1?=
 =?us-ascii?Q?YjYJbJUFS9/pMUesOmsDisbDTbpq38ayj4X9gACxvjNEdmCKgpxgLfXCe6pd?=
 =?us-ascii?Q?ptNbQw9BES/B9jAEUjsXFdwavvzlaQowZ2bQKRiVhairtUtr4bAD6y6h80LE?=
 =?us-ascii?Q?Sju+zayen7HH8DkQNzlPRmDFeucabXQ/XgUV0yto7/tq8pXLtEMIuMZoyMUp?=
 =?us-ascii?Q?v5yNTY2kxd3l7FYXOBeo5Cb13FID7QJ8DZVuXEKfstzUGjuCyaVeavJld/n9?=
 =?us-ascii?Q?LEtavNEBSrfo7f8mwjmvBazPWMKDKdoirOggjvS+o3Q+g3eyErnSymd26+oH?=
 =?us-ascii?Q?spGpAUFE6BIASuV2K5Vt17I/Wg5lOS8fKq5H9cQ4ihDqrBA8pz9Ebl8Hsr05?=
 =?us-ascii?Q?j3tYaMyPJL1iq3uzUICRykbXqD9c6haf/PGSh/GQLwxGHBiiBZXBHJo/sB2B?=
 =?us-ascii?Q?D922Hdrbg7FVkdu9ZXa1bItlPOCWLieCovS9wv7XngLF4YJlgk7ECYnDpUBS?=
 =?us-ascii?Q?amy1fc2uXNCpzctGRJY6ozFLwTp/qbvluvGfH+mnHtsn063/jz97bzqz6TZB?=
 =?us-ascii?Q?OoU2PiGaJFOfZ2Tn02Ib/kGRaOGoMa9G4JnydHfWcwwzBWn3iLJcoPWwARsc?=
 =?us-ascii?Q?gDneSoApfgiCWLU0VabOIJei8WljAi7vRyRMpEfuDkQyFHhxsW3oAmMO6hS4?=
 =?us-ascii?Q?d6PmNHp5e+dTEkkMmxqEM23ODjXVMGHL5YJpQ4+eRHoqygu/iiPfU76oBiZ9?=
 =?us-ascii?Q?C1iwKjkzlf80Dr1fSfue5D+esPAebf3tBNSLP1g3x6Eis1RC9WR0Em7Y816B?=
 =?us-ascii?Q?exR1zu2ZY7gwg22/4Num+j7/WKcb9HjdwktUEMWtNYZeORQb0ok8cOyhesJ6?=
 =?us-ascii?Q?FNMdUKLMyNOce30DcOTwXo7Kjmo6nCT4uSbKNRdBuOSCxACqZSrFPtI2Sstp?=
 =?us-ascii?Q?QtoVPIBY7cNzs0uxzrnpNniJNtDYal+rq/VxIvKsHozg7Ox4DJpaX6ALP838?=
 =?us-ascii?Q?vG4iBYd1wfO+y5mz3fuMP40LPHctbov44NjD?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 05:59:11.0727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8cd406-be80-43b4-b0d1-08dd84877738
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8078

Add a new IOMMUFD_OBJ_VCMDQ with an iommufd_vcmdq structure, representing
a command queue type of physical HW passed to a user space VM. This vCMDQ
object, is a subset of vIOMMU resources of a physical IOMMU's, such as:
 - NVIDIA's virtual command queue
 - AMD vIOMMU's command buffer

Inroduce a struct iommufd_vcmdq and its allocator iommufd_vcmdq_alloc().
Also add a pair of viommu ops for iommufd to forward user space ioctls to
IOMMU drivers.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index ef0d3c4765cf..e91381aaec5a 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -37,6 +37,7 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_VIOMMU,
 	IOMMUFD_OBJ_VDEVICE,
 	IOMMUFD_OBJ_VEVENTQ,
+	IOMMUFD_OBJ_VCMDQ,
 #ifdef CONFIG_IOMMUFD_TEST
 	IOMMUFD_OBJ_SELFTEST,
 #endif
@@ -112,6 +113,14 @@ struct iommufd_vdevice {
 	u64 id; /* per-vIOMMU virtual ID */
 };
 
+struct iommufd_vcmdq {
+	struct iommufd_object obj;
+	struct iommufd_ctx *ictx;
+	struct iommufd_viommu *viommu;
+	dma_addr_t addr;
+	size_t length;
+};
+
 /**
  * struct iommufd_viommu_ops - vIOMMU specific operations
  * @destroy: Clean up all driver-specific parts of an iommufd_viommu. The memory
@@ -135,6 +144,13 @@ struct iommufd_vdevice {
  * @vdevice_destroy: Clean up all driver-specific parts of an iommufd_vdevice.
  *                   The memory of the vDEVICE will be free-ed by iommufd core
  *                   after calling this op
+ * @vcmdq_alloc: Allocate a @type of iommufd_vcmdq as a user space command queue
+ *               for a @viommu. @index carries the logical vcmdq ID (for a multi-
+ *               queue case); @addr carries the guest physical base address of
+ *               the queue memory; @length carries the size of the queue memory
+ * @vcmdq_destroy: Clean up all driver-specific parts of an iommufd_vcmdq. The
+ *                 memory of the iommufd_vcmdq will be free-ed by iommufd core
+ *                 after calling this op
  */
 struct iommufd_viommu_ops {
 	void (*destroy)(struct iommufd_viommu *viommu);
@@ -147,6 +163,10 @@ struct iommufd_viommu_ops {
 						 struct device *dev,
 						 u64 virt_id);
 	void (*vdevice_destroy)(struct iommufd_vdevice *vdev);
+	struct iommufd_vcmdq *(*vcmdq_alloc)(struct iommufd_viommu *viommu,
+					     unsigned int type, u32 index,
+					     dma_addr_t addr, size_t length);
+	void (*vcmdq_destroy)(struct iommufd_vcmdq *vcmdq);
 };
 
 #if IS_ENABLED(CONFIG_IOMMUFD)
@@ -286,6 +306,21 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 		ret;                                                           \
 	})
 
+#define iommufd_vcmdq_alloc(viommu, drv_struct, member)                        \
+	({                                                                     \
+		drv_struct *ret;                                               \
+									       \
+		static_assert(__same_type(struct iommufd_viommu, *viommu));    \
+		static_assert(__same_type(struct iommufd_vcmdq,                \
+					  ((drv_struct *)NULL)->member));      \
+		static_assert(offsetof(drv_struct, member.obj) == 0);          \
+		ret = (drv_struct *)_iommufd_object_alloc(                     \
+			viommu->ictx, sizeof(drv_struct), IOMMUFD_OBJ_VCMDQ);  \
+		if (!IS_ERR(ret))                                              \
+			ret->member.viommu = viommu;                           \
+		ret;                                                           \
+	})
+
 /* Helper for IOMMU driver to destroy structures created by allocators above */
 #define iommufd_struct_destroy(ictx, drv_struct, member)                       \
 	({                                                                     \
-- 
2.43.0


