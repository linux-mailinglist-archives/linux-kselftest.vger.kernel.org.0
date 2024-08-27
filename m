Return-Path: <linux-kselftest+bounces-16431-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A0F9614E5
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 423A428468C
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835111D2F55;
	Tue, 27 Aug 2024 17:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G1IvgYTG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F621D27A4;
	Tue, 27 Aug 2024 17:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778122; cv=fail; b=Q0t/UYbVTrnPnpPp4NICGDTytcRDt1tgklp/eIJ/24jW+A9ursSib9QIg39GTSho35iWHD3ABZcPUA9iXoZDy5Os44makhoNBg6JL/2z5L/SnY+3wNoOyIH6SEy6xffExZ8S0IWficR3vIHeHKtctvO+zgRy/hxDrUcKGaE0p3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778122; c=relaxed/simple;
	bh=W7dS2XS29qzgHW42M63oQbyuxzBJ+WSNyId2nL5u7Pc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XtVK6DNhTyKnBiSVFx7NFQP1TLOMEfZpRbgCNKkiuQSVnvCECmES3QVlH/v3p1LTmxQi0xbjLO2Q908Sc6X3DDZg8hmsi+NPK164q699NnJmcRJCF5CaaHR0cHJ4eHiXYx90ga1f/5/oz8QTytJiefdmOFNa0SjFVqsqYhtFQJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G1IvgYTG; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bI8Czw4yYx/shx4cNi48bgg8ozYVsDJ6DS7Qqr6bcM4x6gYzqExQdsl18UQ4GDyBH8a1laztF7f1CMwIsKfWJ/9w1xsvpl2HyvUkkddFQuU/JfwdsvSArhQeVMXcs05K2MnjiuaHWcOltRq7ih32Ndl+PWc0bJjNyUG1Qmo9BEmWuzlzUp+EpMaD9BMXZdU+2prSpR3vgdxOWSL4mo++7ULGnNAtggYk9e2O0o2BW9cd5y8RkuoadTRRuUhpxA/qlqlMHRxHrJaiCdFeaw2caoPiq5ADKcj6tOg9Liz+mT37w2pnjPnAOZ74rPamjO3XMwTs+yXFqQQu2pm7yIWyTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPYOWHi+9nANoYua577/wdgH/ZY9XVaaaAI83InvJGw=;
 b=ESb0UYI8t2gHWnGva3DAWPUvTktOBfByq8yEyhWOHVYxOuK5yYgYnXl68/VEWVWdoufqJiFiJ8XsjK6Lbp3wZnrv6ctPYDblGUbyzUX9jGxXb4bQMK09QIayTOJdHHX7GwBXmjrUq8QhZL8pGsNOfhZwAj6p143ikMwB1QS032HFNk8CbtdT3K0Zd+aiciW1KLny8xUgPAmjf0yHnmrcfg/M6G0ZqOCsm4rbK/D5SqsQQFj1RZBZY6iUHbpC+7yC9hQAUVM9Pnl+Nrzg6RR6WLHiZFSMAfQSEoi6nEeHLBjCOcLz+4orhX1n6iOSiTxEmi1+arfeeAQmYExaOPDFtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPYOWHi+9nANoYua577/wdgH/ZY9XVaaaAI83InvJGw=;
 b=G1IvgYTG/3eACR9PMyMNF0NO+hiCl/RoDLAw1lEsBnfqR7/JEeLLeUWOntcAmuVUCnMbusWTJqhKGlhXUyOt60EhAM3N14+BwbYKdha5ckp/y4U66PEEYzh34h1b4kBkSxniKbAmNIJ6vGhYK4Vl+tVTRu+c5BF59Tou1RE/mkn5I6cajHDtiabtCxkAoZf7PinWIJxQKStvu0HXBmWxCzZZ/WLYwCwamkmVV6anBg2NjznWwE5OGp+yJPsrbACb/Ui55hjGEJ8VQvmfqW1T1gUPbZXFZKJm9zwAP/Zar6/lx5O5iTYick1A4YBpYAwLywNWsxXccAL66b0tMqx/Cw==
Received: from DS7P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::8) by
 SA1PR12MB8118.namprd12.prod.outlook.com (2603:10b6:806:333::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.26; Tue, 27 Aug 2024 17:01:57 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:8:1ca:cafe::bc) by DS7P220CA0010.outlook.office365.com
 (2603:10b6:8:1ca::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26 via Frontend
 Transport; Tue, 27 Aug 2024 17:01:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Tue, 27 Aug 2024 17:01:56 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:01:43 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 Aug 2024 10:01:42 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 10:01:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: [PATCH v2 10/19] iommufd/viommu: Add vdev_id helpers for IOMMU drivers
Date: Tue, 27 Aug 2024 09:59:47 -0700
Message-ID: <6ccdfb27c7aa5a5bb7e153165cf90114cae4687c.1724776335.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724776335.git.nicolinc@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|SA1PR12MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: 7832d643-22d5-4711-ba37-08dcc6b9f565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dxWj7BjQWkYg5VXNaZO2MzDGuRSMtmPZoBux72VHeUxYB7VWkAqDq0xDgneC?=
 =?us-ascii?Q?uW6EvIp9CvcOZoabEdtghl0AZ77O2BzZsC4Ti+vG1s4ls2F25LO6PktN/iYx?=
 =?us-ascii?Q?N+ZsuiSZKdAn3NKSwtxoESsUtJ065/VwMNxe6PeQxPR2NCXlRMht3qy5geNK?=
 =?us-ascii?Q?02jmvM3jasrTCIg3i6Q0QMn1jFEQOGRXWC4VZK7IP0+kvSyofK/L0v5H27op?=
 =?us-ascii?Q?CEs3tCKyFFn8O4d3jZae+4jk0f4/avJxjeA5uEIQwlzpYWCeXmOFZIYW0Wwh?=
 =?us-ascii?Q?OQp1YLACsplMVQ8bth6pg92aXvvt7DiS3n+FJxjy0PVVqzbBr7A+6vvPJ2uJ?=
 =?us-ascii?Q?OJhEWss2c1AbhjgoUE9DQI3iTX57+2cuchU+fmWQwLNG+uXffSK4DGzYfAMz?=
 =?us-ascii?Q?OuiUANtvtFmUSTbD3I9DR6gGeEYdR8Uqvz91QLYR80jpn0x1S7hszwglHGsO?=
 =?us-ascii?Q?x0lEg65fYJXqUo0DInX29ETnPUbw6VJjrpLXF+7QH0iXgqSFYlOxIHcOoYAK?=
 =?us-ascii?Q?sEP+iH+kIY+Ths4jw9XoOm4OhycPox91A0WsO97s+hzJjAmd1hjQq5c8iBS2?=
 =?us-ascii?Q?WbC2KUa0e+L21l852QSs7Y3vqVDnJYLNi6DtSd+ZWcIApFQaEzBEdAD4ZC5W?=
 =?us-ascii?Q?HMcuMVrHN+Tq2i5/3rO43aq7oohBwKqWo+gGwXUpsBs9ffUzPFzIKSDqVzRU?=
 =?us-ascii?Q?vrS6F011d0a7iK1NpmPjd9DMTNdpgAQbjAnxuVzicXkprbO2eTZ97SgVhwbO?=
 =?us-ascii?Q?O041r6KVclVMvqUMDXW0VJDQhP4Fr0ugi1SXy3MYdGTn4cKnR0YmzbfFR+OE?=
 =?us-ascii?Q?2awk2FPm+LLHhFk9urDdrLV8oOO+Nqv6JtJk+RcJK/RwG6jVy56DzZjYMWi1?=
 =?us-ascii?Q?F3V2pkdVU5eP0Tih2LSwrrV0ve0yHvlzIbdKYjYIelPd+X2NZ1WufkSe/syD?=
 =?us-ascii?Q?95xd2LG+zGrS+93qanYkVJuBEiyIdoozEldkasLjxnOowDZ24Z3hLaLW4+Bd?=
 =?us-ascii?Q?vz5rpKbUoXKDE9z5t1H4iCGK7M7WlXYuaLaLLeoSVjZns3JPV80FaLTjVe5N?=
 =?us-ascii?Q?ZFAJnaCeAzvh9LKmYBfDEp88UvsLV+mq1xMspvQe9UbfFOwdfTYxqZLuWi/k?=
 =?us-ascii?Q?IhhTgfG/ipuBVVeCI16WRg67ipE0YC3pxKPtFOasJl7zAVJzwW8fTm8n5Npt?=
 =?us-ascii?Q?ILGwU42TsPsuAbbLN8eHZ8uiL4KUo9qeQJ8hOfPdChycuv6rlCwjbQdb4KlF?=
 =?us-ascii?Q?5ipd2TbZJLouzh0MjNVCG6z6qdTrDgh363RJtqsQiw3+0fekayybq/nucCyu?=
 =?us-ascii?Q?N3QPyXpSZILG9dEwYDvNny8hClWms0Y3MmSOE4VY/E/EXSLiANr3Oo9ShcUR?=
 =?us-ascii?Q?dpFLBtSCJ+QQGxcAlUyxYPcdufAb+7YI12wDsi0GcUOY4ajEyXgM51BDqz/h?=
 =?us-ascii?Q?Jx0JZ93tdc/IUZtF6prHkP8jlxmDNaiR?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:01:56.7008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7832d643-22d5-4711-ba37-08dcc6b9f565
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8118

Driver can call the iommufd_viommu_find_device() to find a device pointer
using its per-viommu virtual ID. The returned device must be protected by
the pair of iommufd_viommu_lock/unlock_vdev_id() function.

Put these three functions into a new viommu_api file, to build it with the
IOMMUFD_DRIVER config.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/Makefile     |  2 +-
 drivers/iommu/iommufd/viommu_api.c | 39 ++++++++++++++++++++++++++++++
 include/linux/iommufd.h            | 16 ++++++++++++
 3 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/iommufd/viommu_api.c

diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index df490e836b30..288ef3e895e3 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -13,4 +13,4 @@ iommufd-y := \
 iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
 
 obj-$(CONFIG_IOMMUFD) += iommufd.o
-obj-$(CONFIG_IOMMUFD_DRIVER) += iova_bitmap.o
+obj-$(CONFIG_IOMMUFD_DRIVER) += iova_bitmap.o viommu_api.o
diff --git a/drivers/iommu/iommufd/viommu_api.c b/drivers/iommu/iommufd/viommu_api.c
new file mode 100644
index 000000000000..e0ee592ce834
--- /dev/null
+++ b/drivers/iommu/iommufd/viommu_api.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
+ */
+
+#include "iommufd_private.h"
+
+void iommufd_viommu_lock_vdev_id(struct iommufd_viommu *viommu)
+{
+	down_read(&viommu->vdev_ids_rwsem);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_viommu_lock_vdev_id, IOMMUFD);
+
+void iommufd_viommu_unlock_vdev_id(struct iommufd_viommu *viommu)
+{
+	up_read(&viommu->vdev_ids_rwsem);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_viommu_unlock_vdev_id, IOMMUFD);
+
+/*
+ * Find a device attached to an VIOMMU object using a virtual device ID that was
+ * set via an IOMMUFD_CMD_VIOMMU_SET_VDEV_ID. Callers of this function must call
+ * iommufd_viommu_lock_vdev_id() prior and iommufd_viommu_unlock_vdev_id() after
+ *
+ * Return device or NULL.
+ */
+struct device *iommufd_viommu_find_device(struct iommufd_viommu *viommu, u64 id)
+{
+	struct iommufd_vdev_id *vdev_id;
+
+	lockdep_assert_held(&viommu->vdev_ids_rwsem);
+
+	xa_lock(&viommu->vdev_ids);
+	vdev_id = xa_load(&viommu->vdev_ids, (unsigned long)id);
+	xa_unlock(&viommu->vdev_ids);
+	if (!vdev_id || vdev_id->id != id)
+		return NULL;
+	return vdev_id->idev->dev;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_viommu_find_device, IOMMUFD);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 85291b346348..364f151d281d 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -89,6 +89,9 @@ int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
 int iommufd_vfio_compat_ioas_get_id(struct iommufd_ctx *ictx, u32 *out_ioas_id);
 int iommufd_vfio_compat_ioas_create(struct iommufd_ctx *ictx);
 int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx);
+void iommufd_viommu_lock_vdev_id(struct iommufd_viommu *viommu);
+void iommufd_viommu_unlock_vdev_id(struct iommufd_viommu *viommu);
+struct device *iommufd_viommu_find_device(struct iommufd_viommu *viommu, u64 id);
 #else /* !CONFIG_IOMMUFD */
 static inline struct iommufd_ctx *iommufd_ctx_from_file(struct file *file)
 {
@@ -129,5 +132,18 @@ static inline int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx)
 {
 	return -EOPNOTSUPP;
 }
+
+void iommufd_viommu_lock_vdev_id(struct iommufd_viommu *viommu)
+{
+}
+
+void iommufd_viommu_unlock_vdev_id(struct iommufd_viommu *viommu)
+{
+}
+
+struct device *iommufd_viommu_find_device(struct iommufd_viommu *viommu, u64 id)
+{
+	return NULL;
+}
 #endif /* CONFIG_IOMMUFD */
 #endif
-- 
2.43.0


