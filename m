Return-Path: <linux-kselftest+bounces-21472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B611A9BD67E
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 21:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9D771C22870
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 20:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96113215C7C;
	Tue,  5 Nov 2024 20:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rmh36dPF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BEC215C5D;
	Tue,  5 Nov 2024 20:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837099; cv=fail; b=hOkvITUJe2fiyZtn6E8Scv3m7nOMK99qQgcoJ6gIHGyPT6gm4cnsiy0XJ9g7QcDReL2z37ZZ63LvzQC/+qMtDZ5zYnzT5j1AtLl0szdpg/d0NMpm/mQvDmUfg/V3tt4JKDHzesh/mSVi3H9Q/98x6Pf2rxxVD20QxDXl1DqHfwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837099; c=relaxed/simple;
	bh=+7G84GbJ1qm2SnmW+79pepnB/CPWxnn72/ACuXGmj9I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MrGhaFGwLoefsAOBgEV8z9QGRJt2oTjxTKyJDcm/x07pku1apDpXqVGcKbFv9jI1saVmSN+n/WTrTWZdKzpKURy0s+D6uc64GuQvLdCuUYEhRyI1v4Q1SV0bBGMWHLLr6tt8UYZK3AFpdN4Gf0HW7GhvS/IijfPeKI6uKDLYzek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rmh36dPF; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnD4NnhDY65iXDbowzMpFFNvBtIUAdt0uSavVguLkQEkGjL6EJrnLzySkBhuA1hiTkmxV7Du5hvu09Jy8NtKzovI6E16vwlUeEPRA0EIzSUngQAKTIYOrQPQmW9jKFrgfhVviDROrskC+zMB6nIBINz1LTEjUIDgKC6vzWPlniqyKVBFHgYOoOEjsQJ7US79DbTKKrrWmfIWIhgDww8ergBfSOyFr5ybMzwPn58TzTJwZxQu/0LviyUFWv/ZsPjoinqPnP4TFGJEMVhPyEzLWnA6sII+nXvUGvCuVe6NbUttvTpk7QL8q9l0yUpWnaraIUwVc/HuxmS8XbHw+/wAeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpmAKFbTicc3QQsUhPxVbnnt92yo4QQil7k4I7tGIrQ=;
 b=jOV7F7FyfZ0tNLeH0cWY+P9u7PIrkhMJ+knFDNcJqL7jOkYptvM2m7bkd1QWHLC3nOLRfzvaL/qbgQuGcxRdeJbgXpvs/Wrl6DZuUg71NqEL+NlcgGujY2rEydwVGXwgYlsEn+Y/Et01d+XpPnrC05TN+IVliayUmSytFeAD2RIf6trVvIm57jDRqoHbLB/0rrn6TqNG2tO7U2FuQEyUf5eWxO+OHr7D+0iXc7eaVpiP7g+B8uugqoOVbIXoA2LPDpzy1EDKC8OwDAhkCCC1hZHSFzyBrVemGPy+/sZ7svDWDtttbujU1wpy0MuocXB9szDH00e4vV1wQV0j2wsnsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpmAKFbTicc3QQsUhPxVbnnt92yo4QQil7k4I7tGIrQ=;
 b=Rmh36dPFZSGOToifRnrmQ7qW3x5E78eOPkYYO5kDPzpVownTzHBDoPO3Vkr2BWnVkDuMS0hX5ANlQb0EOOdahHCAGU2Egu2DHvG0X7Aj0KZPfUvizGD56e9QIwK9TXqwW1aWsFxIBqzEMremvRzqtg04eIVu9ekXoqlJRmMbam+cz+7uWOc8oajZDR6apPzrjkOAYnI9iwZ46KfwqsYZPYjYPswVvDYxDa58rcLkdlEeSIuAGZ2yvy/KKdkorMfEh5kkHswIDrR+wn1p8hngvZyKoqAZ04K/ZDmx8f/+v9zqfaqxYbRlg4fN76N02FmVc2Za/O1xtb9mTv/QRT4Tug==
Received: from BLAPR03CA0004.namprd03.prod.outlook.com (2603:10b6:208:32b::9)
 by CY5PR12MB6300.namprd12.prod.outlook.com (2603:10b6:930:f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Tue, 5 Nov
 2024 20:04:53 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::3d) by BLAPR03CA0004.outlook.office365.com
 (2603:10b6:208:32b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 20:04:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:04:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:04:41 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:04:41 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 5 Nov 2024 12:04:39 -0800
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
Subject: [PATCH v7 02/13] iommufd: Move _iommufd_object_alloc helper to a sharable file
Date: Tue, 5 Nov 2024 12:04:18 -0800
Message-ID: <2f4f6e116dc49ffb67ff6c5e8a7a8e789ab9e98e.1730836219.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730836219.git.nicolinc@nvidia.com>
References: <cover.1730836219.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|CY5PR12MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: f1e4483d-34bc-428c-7b97-08dcfdd51d0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gzpdkgTtMxlGU9euBxvtQ4LO7fsWkSUMpl0RPscwtZl06azUzpfudFSfCJBD?=
 =?us-ascii?Q?qVwC0XIktyUUprFoIYe6vKwNoGgP/A62i16hUzDjQVtuHu/Rn7uPXovER0RR?=
 =?us-ascii?Q?K6GABO4QZMEqLmtJnMq5qm0Yy4Ht5Tq3exWTrnVo8vj0hOU0trtspwG7o6Jh?=
 =?us-ascii?Q?um2c9t93vZuvdHB1Lduj6fqgjEnW6OoyHoGOJPerMNB4EP14fNrLlzfWORxv?=
 =?us-ascii?Q?V8ic4fr4R4qgN4qKa3NNVbgns4l+leF2JXBtTeyP9gSL2XgScVrXrv6EgEy7?=
 =?us-ascii?Q?YM8Jb5T8EPl1BhwTU8xl6KMvRyTafz1Ev4sftcMKsDtyu5Ky18m50xyEs14i?=
 =?us-ascii?Q?p365Q9SdQ+ot3hgtf8ih7ApaqoCDsAJ5XWWm4MN69mJDG0lBEAkFAr92OYp8?=
 =?us-ascii?Q?ENQq6QLy3Lbx7Cgg3WeeCVPJFu/BU0ZTjMst8PkeIo0f940+KIUaIPzriGba?=
 =?us-ascii?Q?XIP/7EtojJpWJOkSoyar8tLcOQ2Vg4lajw8JrkdePEHo8NeuJoCvtasgL+3o?=
 =?us-ascii?Q?+fEDdljfNdeS5wBP5Gnf1czjp8H9tJ/nNWQgsUKscymZa16C8DGi81/qVcvI?=
 =?us-ascii?Q?AZTcx7lvvAajYdQnh2KmyJZgB1z0CeSXHcFaYS9J8+7XNNFiZKE2C4bZCIxg?=
 =?us-ascii?Q?P9HFOtuM/W/yDDXn19gnic2pYEqMHgA4DiiHFmI9aVfd0/3xMWgZwtnC6FVD?=
 =?us-ascii?Q?zoNloSm3G7pzhJFMMTRpkJOnA57EwvlwuPdxNPgIEBOwFxdf2xv9MrkbH0eO?=
 =?us-ascii?Q?/7r9MSXRN01O7uQu/m6E7Bs2duUSMita2gkkTJ3pV2E2GjxlRdbyjGlQ5V1a?=
 =?us-ascii?Q?lwGGD5pX0EfcOlXOk7eoZr5/OnqFCqd3fOoWgwV27g1NOGuUUmOK/Pb8kbbw?=
 =?us-ascii?Q?faVltkMIdUyYoe1oZUzo4B/0Y34GXx8qHi4hZxW13Et9r7n0iAqkbm4/1+2t?=
 =?us-ascii?Q?ngLA1OuYbd3N1io05Eu/5V3NIllkt6tjKGnbVjP5u1M5xqNl0nNAb4Wh6H7u?=
 =?us-ascii?Q?nYDMsdxNNsfjV6AU2FJxz0XsylGe4UeHeNMnyRl4ymuaB8WEgL5Xayp/bURH?=
 =?us-ascii?Q?6RbqcvGhhAEcGso59gLvN7Z+US1BokCcpqRuXuB0uQaMQpsBXzikL4SltLBm?=
 =?us-ascii?Q?0gN3Afo/8tol5ge/x12TEa4DSSHkru9whg/WA05zor8iAj/z8ZtHAYmmUO0a?=
 =?us-ascii?Q?3g39zVOlfNEjxmBQmhDboCqcQJAs8k7ng4cZph6iKJfYlQ43B3xlCwv26bn/?=
 =?us-ascii?Q?Spma6Zmj/g9D2GjwmhgUCc8H3qjv0c3NVtPxlC+KdXScrVzai9wREPqzRnyq?=
 =?us-ascii?Q?jvHa7dGzbSeCUobMX8ozbeULRLPYKo+HzW3Sx467PAw2PRiMi9ADEPBzkYdI?=
 =?us-ascii?Q?mo4yy7uTi9DlOgPTtfo2CyuULTM44NB4fBCrIU6SgegUxSEO6g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:04:53.5292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e4483d-34bc-428c-7b97-08dcfdd51d0a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6300

The following patch will add a new vIOMMU allocator that will require this
_iommufd_object_alloc to be sharable with IOMMU drivers (and iommufd too).

Add a new driver.c file that will be built with CONFIG_IOMMUFD_DRIVER_CORE
selected by CONFIG_IOMMUFD, and put the CONFIG_DRIVER under that remaining
to be selectable for drivers to build the existing iova_bitmap.c file.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/Kconfig           |  4 +++
 drivers/iommu/iommufd/Makefile          |  1 +
 drivers/iommu/iommufd/iommufd_private.h |  4 ---
 include/linux/iommufd.h                 | 13 ++++++++
 drivers/iommu/iommufd/driver.c          | 40 +++++++++++++++++++++++++
 drivers/iommu/iommufd/main.c            | 32 --------------------
 6 files changed, 58 insertions(+), 36 deletions(-)
 create mode 100644 drivers/iommu/iommufd/driver.c

diff --git a/drivers/iommu/iommufd/Kconfig b/drivers/iommu/iommufd/Kconfig
index 76656fe0470d..0a07f9449fd9 100644
--- a/drivers/iommu/iommufd/Kconfig
+++ b/drivers/iommu/iommufd/Kconfig
@@ -1,4 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
+config IOMMUFD_DRIVER_CORE
+	tristate
+	default (IOMMUFD_DRIVER || IOMMUFD) if IOMMUFD!=n
+
 config IOMMUFD
 	tristate "IOMMU Userspace API"
 	select INTERVAL_TREE
diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index cf4605962bea..de675df52913 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -13,3 +13,4 @@ iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
 
 obj-$(CONFIG_IOMMUFD) += iommufd.o
 obj-$(CONFIG_IOMMUFD_DRIVER) += iova_bitmap.o
+obj-$(CONFIG_IOMMUFD_DRIVER_CORE) += driver.o
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
index 22948dd03d67..94522d4029ca 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -135,4 +135,17 @@ static inline int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx)
 	return -EOPNOTSUPP;
 }
 #endif /* CONFIG_IOMMUFD */
+
+#if IS_ENABLED(CONFIG_IOMMUFD_DRIVER_CORE)
+struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
+					     size_t size,
+					     enum iommufd_object_type type);
+#else /* !CONFIG_IOMMUFD_DRIVER_CORE */
+static inline struct iommufd_object *
+_iommufd_object_alloc(struct iommufd_ctx *ictx, size_t size,
+		      enum iommufd_object_type type)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+#endif /* CONFIG_IOMMUFD_DRIVER_CORE */
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


