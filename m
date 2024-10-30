Return-Path: <linux-kselftest+bounces-21163-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 680E29B6F2C
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 22:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4AA1C21DE7
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 21:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54879228045;
	Wed, 30 Oct 2024 21:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rAtVzuyz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31C1228033;
	Wed, 30 Oct 2024 21:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324106; cv=fail; b=b6lWyKnWhpB2FMUnIX/q29BD1rFbOSmJH8oxk5Ou8sFsg02Z38JrbWzsweoaXirgZCBxtkcO6HFjpX30g9kO3yLrGwubSdW16sDJAcQZ7wPAvADLSxkSQAyyoec5fzI4x7fZrNDc+aG3hrXqIqFEBq6UBGoeV0cf7HFUYIIgKac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324106; c=relaxed/simple;
	bh=GiBpWhwsK75jfmPmZ/LXdC9qTic4i+H4B+GSzktqjQE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lGRfxLAFNwUEJnDByXIDkp7Xi7CHtoPZcbgksIQt0p1uH3/XmGsr83yQSHjt47XkUBvNiEq4+AOzDAVPxbV9WfAm/YxjxREqAnoyShFX84SlEgU0H/H4aJGPrQ69GIIfkopnE/vqZzYjDeXRCjnVqnx8IuxoX5xudMYsupQOITE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rAtVzuyz; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJv6bJUYqyfg2FpLQgt0X0I0dtljm4lqKfa66I5wZbWqa3BB8yoeOf9akYxXzmfoQfKSP11dlzAFmTHedysQDpUpxZ+N/qpWrmAo/nWYEZUYtEhN9NwOAKh1pq7QWt5S93vxTv6nEqtLYq0hGLNtvUnxVXH9AIPz0U6AKOH5pfsOTolzU3KnmDSd+d5N4LtU3PpCHKJV+M2xQDXnZIYlpjSgcTvKGZ+Kw55nwJrBE/03bELjAyTbGa/HwKotEFCqGI30l6gCe2AAzpDWTNzr/AhBr1NbxuW1pDmIQWr252xRMeslZ7M+OuI/bS/fjjkNkV0wjYZ4pbnedZIO9tsYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCLUkSfs/dIbW6V0NnS/PLqmx9D9uPhl5/eSQ7tnUu8=;
 b=g9TJ8uJI4ZAnScy3dMQR4wemZosLHTaXTTcmsUfDmq0LMk/pNYyh4IlkpszjjVQTEJIoJEVON6rjSkENMuAoXzRUpWQldrMfEoOUMFQUQbn6TeB64d4TtC59sd8530kCFAm3SHsr47QrRWpaSqYvf28FQBOzJLX4BMxDGLImu6C20LY4mfgRlDpuUCxenckZ0CxbHDX+S2F00GJ5p2jNT4C/JzVx2WKhTGXZ4EIwFD2fklqXxzpJeysWd2KfqzHWyxdMKA8dCdfiOcNpL6lKghKKj9CeaVDdls6Cw+Omet0L6a45oXIwf075RLpcm7b8tnEe4x0yCy81SEMElMrHlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCLUkSfs/dIbW6V0NnS/PLqmx9D9uPhl5/eSQ7tnUu8=;
 b=rAtVzuyzla8hs8/nKLzqY6gApNVmq5mIJeILo65MUiAbpUVr49jRa/cNKuSiR9/I6R0ZKiWHuzTFmKfZxbhjhjt7bDVYYQE7WB8J754Qc8XhQAkNWOXf0uqTnfPIONfqOycweIbBinD3WE9XUPArafV5ylE2i68m5+7Qi6Hb67ErQYrOlOTdWc65TVGPB9ZLTHYmdVT+mnEhvaszqJ+7nu/1rupPqWwg2zE/IwM8nLdGAp7QrVAX8r4883lY1UcKyzdIEMYFnGlpm5XYJ9vBpPzOCuW+p48amzoOKcYqZ5XEWPsYwMgX06Whb5kBlk57quM7hAw3cF/MQS4M++w5YA==
Received: from SN7PR04CA0113.namprd04.prod.outlook.com (2603:10b6:806:122::28)
 by SJ2PR12MB8980.namprd12.prod.outlook.com (2603:10b6:a03:542::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 21:35:00 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:806:122:cafe::85) by SN7PR04CA0113.outlook.office365.com
 (2603:10b6:806:122::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.29 via Frontend
 Transport; Wed, 30 Oct 2024 21:35:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 21:34:59 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Oct
 2024 14:34:59 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 30 Oct 2024 14:34:58 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 30 Oct 2024 14:34:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <shuah@kernel.org>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<baolu.lu@linux.intel.com>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<yi.l.liu@intel.com>, <aik@amd.com>, <zhangfei.gao@linaro.org>,
	<patches@lists.linux.dev>
Subject: [PATCH v6 02/13] iommufd: Move _iommufd_object_alloc helper to a sharable file
Date: Wed, 30 Oct 2024 14:34:28 -0700
Message-ID: <52abef167409b25bfee559a0c03f2607ce77be3c.1730313237.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730313237.git.nicolinc@nvidia.com>
References: <cover.1730313237.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|SJ2PR12MB8980:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d9c392c-cd56-4bf8-36e9-08dcf92ab4ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xi7vyM8ziiWSknomYqQK4aRZ9PQvII3NEjhu4TqSAbgzvIKee2m1Mz+417Dt?=
 =?us-ascii?Q?vmF0nRXpZHYW0REDAUEP56L0pQGX6p8bxRD29QtSYd9j3qXn8f/qdA8qoln6?=
 =?us-ascii?Q?o+BYNBcPhvscuy82UmFfW5aiUdLr9Awahh10V6cZT33oGWzvcYR+6Xv4bx4G?=
 =?us-ascii?Q?rSFyCY33trNxdtEdnPmT9GQQiafy8VeEyOq3FryaAN8ygh/zFiD/XdRNkIZU?=
 =?us-ascii?Q?EFkzUvyP5sZRl+5t41WH5HuYQvTQKt2f4IFdMYgrdTc4eDLIVANrWqbBc7mP?=
 =?us-ascii?Q?uUgQyTYhTXm/TImgSSo78h0QexauN0ZGXiP/SsEZXQpa4tBppXUcJe3dTVhu?=
 =?us-ascii?Q?4AavYC7XkpmW/qsCMWaFZmCZTNvxzOJLiDqtp1ajfQ9YDKzvqzCvFu5cCphy?=
 =?us-ascii?Q?Tr2tBVnEQ3U0o30j3pPX6JPKXRzKENOzhrFgDVUl884iCM5yvCAGVhJM157r?=
 =?us-ascii?Q?mcIHAK/JR3bE8LifwoZ1oazAfsT1xBC6pGJXcGUGTUYf+SFBRo2075uUMAvz?=
 =?us-ascii?Q?Kcd4o3dMJ4bxKirx3W1wLEdMuCkmm9PKh7nWFpJj7kdSh1cyO+Y0X+j80QA/?=
 =?us-ascii?Q?+qQLYb7MVtDgtA3YUFmvjjLR5csKsEKmqvnWcmSdu2GCFYDvnaoY9SaDPKYJ?=
 =?us-ascii?Q?qPQQa0yTJdr21+GV5lhr0K73fbD4kABPJATujZY/DKvwyHJe+k59gQwq0ODK?=
 =?us-ascii?Q?EeKuZC09sWXZBc0B8wLxaKyxp7o3Kx/rfPJiQonddairHTQJS6O31P7Ev9kE?=
 =?us-ascii?Q?akKUNdd5POJaS65h4XI1BXL4R+TlHGukoj7nWnyrtjDD2+gjWY6NJzk8/cGe?=
 =?us-ascii?Q?mjl9sOPRzAUFC5AhWS7O56absx8rm89aoAog3lARm0lbB8J4BN7tgjpZnrwX?=
 =?us-ascii?Q?g19+QckTizWHz7+62mWLuJv9OyZdLmNOTLWD8JSh8Yo6jsx+Mx8wFluXdeJe?=
 =?us-ascii?Q?iFVsznrIZouJhTBEi9Oc06ofv01a3qpXJs2axu2TXLzpsEBILxBX23zvUC4F?=
 =?us-ascii?Q?MjAXb+htLjtgq1/oXwBB5tfuzmxYOqwYy4IJeILwSsrO0zq6wha5v2FVloQ7?=
 =?us-ascii?Q?3+QhySDg/KmBFT7gYBKN4Yr1pPDej85Uy7AqLaCmDgNakIlt9+uWO9Z84FL0?=
 =?us-ascii?Q?MRZ3Rzn6s+JdTnjhgdLY3g+p88SAyAnMsWVyHbcd+Rb+uYeb6YEquDZ5b0fP?=
 =?us-ascii?Q?a4KDqDVLnurm7aI1AaNtQPDVVcEeMxT2k4hZZuEUtVUTE4QJhGTC/3sWRtqx?=
 =?us-ascii?Q?JtFsL4cihtdDTpF4CitmtUsJZhCm9r73cRVe+hOLKRhWiYH5YmUUb3N5jj+v?=
 =?us-ascii?Q?vR+ioxoP5Wg4ak9Fb2wsxlb2OSPc1jognqYigpnAN62qbTPfO/Vv5Rs1fnA1?=
 =?us-ascii?Q?j08u9igsePC5CrD5z72SIM9b9EjoXatjcZ0l0ae+buVwCYBDhA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 21:34:59.9241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d9c392c-cd56-4bf8-36e9-08dcf92ab4ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8980

The following patch will add a new vIOMMU allocator that will require this
_iommufd_object_alloc to be sharable with IOMMU drivers (and iommufd too).

Add a new driver.c file that will be built with CONFIG_IOMMUFD_DRIVER_CORE
selected by CONFIG_IOMMUFD, and put the CONFIG_DRIVER under that remaining
to be selectable for drivers to build the existing iova_bitmap.c file.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/Kconfig           |  5 ++++
 drivers/iommu/iommufd/Makefile          |  5 +++-
 drivers/iommu/iommufd/iommufd_private.h |  4 ---
 include/linux/iommufd.h                 | 10 +++++++
 drivers/iommu/iommufd/driver.c          | 40 +++++++++++++++++++++++++
 drivers/iommu/iommufd/main.c            | 32 --------------------
 6 files changed, 59 insertions(+), 37 deletions(-)
 create mode 100644 drivers/iommu/iommufd/driver.c

diff --git a/drivers/iommu/iommufd/Kconfig b/drivers/iommu/iommufd/Kconfig
index 76656fe0470d..83addbe2ff7b 100644
--- a/drivers/iommu/iommufd/Kconfig
+++ b/drivers/iommu/iommufd/Kconfig
@@ -1,9 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0-only
+config IOMMUFD_DRIVER_CORE
+	tristate
+	default IOMMUFD_DRIVER || IOMMUFD
+
 config IOMMUFD
 	tristate "IOMMU Userspace API"
 	select INTERVAL_TREE
 	select INTERVAL_TREE_SPAN_ITER
 	select IOMMU_API
+	select IOMMUFD_DRIVER_CORE
 	default n
 	help
 	  Provides /dev/iommu, the user API to control the IOMMU subsystem as
diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index cf4605962bea..266e23d657ff 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -12,4 +12,7 @@ iommufd-y := \
 iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
 
 obj-$(CONFIG_IOMMUFD) += iommufd.o
-obj-$(CONFIG_IOMMUFD_DRIVER) += iova_bitmap.o
+
+iommufd_driver-y := driver.o
+iommufd_driver-$(CONFIG_IOMMUFD_DRIVER) += iova_bitmap.o
+obj-$(CONFIG_IOMMUFD_DRIVER_CORE) += iommufd_driver.o
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 94cfcab7e9de..be347f726fda 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -206,10 +206,6 @@ iommufd_object_put_and_try_destroy(struct iommufd_ctx *ictx,
 	iommufd_object_remove(ictx, obj, obj->id, 0);
 }
 
-struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
-					     size_t size,
-					     enum iommufd_object_type type);
-
 #define __iommufd_object_alloc(ictx, ptr, type, obj)                           \
 	container_of(_iommufd_object_alloc(                                    \
 			     ictx,                                             \
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 22948dd03d67..2f72452fad27 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -94,6 +94,9 @@ int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
 int iommufd_vfio_compat_ioas_get_id(struct iommufd_ctx *ictx, u32 *out_ioas_id);
 int iommufd_vfio_compat_ioas_create(struct iommufd_ctx *ictx);
 int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx);
+struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
+					     size_t size,
+					     enum iommufd_object_type type);
 #else /* !CONFIG_IOMMUFD */
 static inline struct iommufd_ctx *iommufd_ctx_from_file(struct file *file)
 {
@@ -134,5 +137,12 @@ static inline int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx)
 {
 	return -EOPNOTSUPP;
 }
+
+static inline struct iommufd_object *
+_iommufd_object_alloc(struct iommufd_ctx *ictx, size_t size,
+		      enum iommufd_object_type type)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 #endif /* CONFIG_IOMMUFD */
 #endif
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
new file mode 100644
index 000000000000..2bc47d92a0ab
--- /dev/null
+++ b/drivers/iommu/iommufd/driver.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
+ */
+#include "iommufd_private.h"
+
+struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
+					     size_t size,
+					     enum iommufd_object_type type)
+{
+	struct iommufd_object *obj;
+	int rc;
+
+	obj = kzalloc(size, GFP_KERNEL_ACCOUNT);
+	if (!obj)
+		return ERR_PTR(-ENOMEM);
+	obj->type = type;
+	/* Starts out bias'd by 1 until it is removed from the xarray */
+	refcount_set(&obj->shortterm_users, 1);
+	refcount_set(&obj->users, 1);
+
+	/*
+	 * Reserve an ID in the xarray but do not publish the pointer yet since
+	 * the caller hasn't initialized it yet. Once the pointer is published
+	 * in the xarray and visible to other threads we can't reliably destroy
+	 * it anymore, so the caller must complete all errorable operations
+	 * before calling iommufd_object_finalize().
+	 */
+	rc = xa_alloc(&ictx->objects, &obj->id, XA_ZERO_ENTRY, xa_limit_31b,
+		      GFP_KERNEL_ACCOUNT);
+	if (rc)
+		goto out_free;
+	return obj;
+out_free:
+	kfree(obj);
+	return ERR_PTR(rc);
+}
+EXPORT_SYMBOL_NS_GPL(_iommufd_object_alloc, IOMMUFD);
+
+MODULE_DESCRIPTION("iommufd code shared with builtin modules");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 826a2b2be52f..3c32b440471b 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -29,38 +29,6 @@ struct iommufd_object_ops {
 static const struct iommufd_object_ops iommufd_object_ops[];
 static struct miscdevice vfio_misc_dev;
 
-struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
-					     size_t size,
-					     enum iommufd_object_type type)
-{
-	struct iommufd_object *obj;
-	int rc;
-
-	obj = kzalloc(size, GFP_KERNEL_ACCOUNT);
-	if (!obj)
-		return ERR_PTR(-ENOMEM);
-	obj->type = type;
-	/* Starts out bias'd by 1 until it is removed from the xarray */
-	refcount_set(&obj->shortterm_users, 1);
-	refcount_set(&obj->users, 1);
-
-	/*
-	 * Reserve an ID in the xarray but do not publish the pointer yet since
-	 * the caller hasn't initialized it yet. Once the pointer is published
-	 * in the xarray and visible to other threads we can't reliably destroy
-	 * it anymore, so the caller must complete all errorable operations
-	 * before calling iommufd_object_finalize().
-	 */
-	rc = xa_alloc(&ictx->objects, &obj->id, XA_ZERO_ENTRY,
-		      xa_limit_31b, GFP_KERNEL_ACCOUNT);
-	if (rc)
-		goto out_free;
-	return obj;
-out_free:
-	kfree(obj);
-	return ERR_PTR(rc);
-}
-
 /*
  * Allow concurrent access to the object.
  *
-- 
2.43.0


