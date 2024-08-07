Return-Path: <linux-kselftest+bounces-14953-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A0094B0ED
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 22:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF64283889
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 20:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18000145B16;
	Wed,  7 Aug 2024 20:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ajeUVhfJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA49145A0A;
	Wed,  7 Aug 2024 20:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723061491; cv=fail; b=g+GKS7Z5oFPWMRvg5FZlXmHWfaDVUHzc3QkLrqOTzPADiPJX2n9W0c6HPwus43/8ALb1JNGOYwjOTM+HPQ20Jb4G6hk2cVL3WFYduPvZNFLJIr8p4dP5LzfqC5qQHnx4Aj3fM1iMNX4OcBhGdD17zkskSq4Dj43YWLQrez/u4aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723061491; c=relaxed/simple;
	bh=BYyCQ6/eCPxkzkYRqyVc2BX60Dnx5CkS8CUKZpO7vUs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fCuE8ZKDHSnnY2986MCNXZe5nwOQDAz6dNH9Y/2gTjSyYo4WSOxnaEBxAyAoem5DhmH9V3S06LmVubjy8wtJ/+LbW4WOtCUw9nVN+Y97iURZSggEvi7dIZOlbd/O9V5xx8dOiC5Blr5pTOiVLb1dmroFQmiEgKVPoV4It//s1pE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ajeUVhfJ; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4PiXV3MW+qiOSSpxwRbQ4AVlEBsQ9ftqXaa6OSSRI9szzWucf6dixKF0gkjm/xTj8Nrn0y7k0IdvIZiP7KZSzqHTkEQutzeB4f9lePIHlVU+8aqRQZ+bXn2bMJ59VmEb1LzRetM4X1K1YWKDjafUc/DUQQODQrS3wHdyCr5K3jbZ0/ZBbDQ6NPJGeTrPyh0wwjr0hjtZ0vq9cTEQR7YNUWnxFrndsGRFnPy2sOMqlGCjup2Cu6ePRjEhBS0JowTltrdlRizDztpFfSKaKnndzxoBsGsG16P+LDSbSjtvuAmA4MRVDpR3TagyEf7SZpTXFmTi9PluutwajzFYfk2Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HFa6QLMqlPOiy/eJ/OPp7DO2RpkYF0EwEmAbfXRoto=;
 b=zARq1rzitZ/gXUaQhbuFCyprKj3P/2+FBZ5pXtvHNwaREjjQzMy29WCnK3jLdUki/IPQB/4+h9hA9K+DvXw7yrF4pPFob/pF9wspFNpKW8X4zxWH4hFpIhPeKbt+47heY9a/Gh1zXP1Jp+Ltp4H7A96kMQzFB9OzEW6Onvpfa759g5Gm8WlHO7wInDnxv3lavnuhcQV1BNDhXRASg212RP/LaodIth66bco6AD8Cj1LNIAVhaaaZWNSqmEhipwOQ3vhmVUQ1QjWrXvhm0DtnLTzQA6/DUAu7wwB/FI6uPPJ3pcMKpTonSE9bacdLGT3FLxBE6mBxp/x3txpj+c9R/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HFa6QLMqlPOiy/eJ/OPp7DO2RpkYF0EwEmAbfXRoto=;
 b=ajeUVhfJnZrsnrOHtZ6zySlqNU6uJD9/iXaQaZw0pEhVsY2l/vYy9h0OB1g+gWAGh0l4jFaZKIwSMJ+XLwnmW5CoA0c7sOMOV+mkJZRJuDDc0jcwfwDp4+F62qTXeGb0BRUkM1V/dwi8bTnJKaCMuemUH6hpTPreoBdI6AXy6lke3p2RJjQqp+Bm0g/3xBVeotaS02eImmUpglbaHSW2wZLQkreLMUQYaV3c/qTz3Qp9Vbp+p8gpW1rKVtNyFOZtaop+fx5V4KBqOVh6VnTYr2g2+2fR1oL9v+0Ue5ImOV6b5HFjZu67atxkX23kUejdLPwCnRaWbYBT/Rksq6sMlw==
Received: from BN0PR03CA0004.namprd03.prod.outlook.com (2603:10b6:408:e6::9)
 by DM4PR12MB6256.namprd12.prod.outlook.com (2603:10b6:8:a3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.26; Wed, 7 Aug 2024 20:11:24 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:408:e6:cafe::f5) by BN0PR03CA0004.outlook.office365.com
 (2603:10b6:408:e6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Wed, 7 Aug 2024 20:11:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.2 via Frontend Transport; Wed, 7 Aug 2024 20:11:24 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 13:11:07 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 13:11:06 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 Aug 2024 13:11:05 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 01/16] iommufd/viommu: Add IOMMUFD_OBJ_VIOMMU and IOMMU_VIOMMU_ALLOC ioctl
Date: Wed, 7 Aug 2024 13:10:42 -0700
Message-ID: <536c5e908af3847649d1f4b7050af17d77d8b524.1723061378.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723061377.git.nicolinc@nvidia.com>
References: <cover.1723061377.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|DM4PR12MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: ed7b691c-367f-494a-b116-08dcb71d1cd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?36VOfOefxPjmIgCZzs2BLv2V3sB78ae5ZFtT4agoecC1sDsOtIrg6vjAX3DC?=
 =?us-ascii?Q?Amxt2hfwlibGcT4KlZuEY4Ud72BZVsjwK1fMXOBkEmkwCGPeQJR0nDHCK0nt?=
 =?us-ascii?Q?giHNkvThoHQIFIg5H+itkOr0Z0LWA2D5CANHORKYCpGRdOsN7x2Tz4WOSu2R?=
 =?us-ascii?Q?VNjURHbBIS5X7gcaai4sgXktIih9cY+10UmQN0TD44rh7IN9jIeyv9bvDSgJ?=
 =?us-ascii?Q?+ZLYMzrVSUQodQ4sXaqDCBXbD7RWLzdRT/Zqz6G5MQo4MVF/KtugNtiMQuAk?=
 =?us-ascii?Q?u+t18OzzEUZQ5oB1nyu0khmpaYH+jsgnsSdALgk3KJGamjMl0X1h+48ftkUw?=
 =?us-ascii?Q?obeWuvVQukqV/PUZBoENbPjBirur62l1UDTOMPFvQjrlCBPSzhan+k82wONr?=
 =?us-ascii?Q?ggjOLO5hMOZR6q17ncFev2bNprtiajNPod7JllvIDP5x15eTfaFrL95dXUjS?=
 =?us-ascii?Q?vwKgPpyM6ymZWzn0aU8XCFjzFVNpozIrcPp/AS1booM8JP6JQa/mWvNiSsvD?=
 =?us-ascii?Q?A39zWTnFcf8a9D+9rdF2zPyM1Qs7AhZ8KlVygDzH2sKpshpuLU86HEz8lbjM?=
 =?us-ascii?Q?RelSzTQLLUR3qDUOOv08KZD9B7rq6+fezajbothHNaQg8N900y3Vd1eIFGCP?=
 =?us-ascii?Q?pEePRjkOJU93ry2t/bIUQUsj6E0rDfWoap86qzs1QDD4Isn7rj6nysWbeNIb?=
 =?us-ascii?Q?2Kvt9lkKzpZWkasBHt22RFLJcd1nIEFLLchxdeFB8MBhL9hD2z7dOY4cCmYq?=
 =?us-ascii?Q?zIwyjzXaGdlQEtTonb8bvxONTiD9REGGZvdpAvOqfsTn+5+nYIgPu5ABeDUS?=
 =?us-ascii?Q?eKfYsbeQIIDTMj4ZXFPIC5q0/uSzSY40RCgnt5VyS0oLylDCbg67Q5/KaRDL?=
 =?us-ascii?Q?wsFqbjqL4Um/KTZou5LlOIVOnetZGEPirPeOImVNMsvYot1F7eLNqkOCmXAs?=
 =?us-ascii?Q?dRqmUibK9Z4nCVUqdVmzLJtbCNPUcTHgby2LT4RZf4PFwh6EvCsOzyFpbRZQ?=
 =?us-ascii?Q?uBARVU369kREpbHW9Pr6EVZr6p/xu8zfOFk2d5exhNXGVOW1gf1BQYvp+CN6?=
 =?us-ascii?Q?4S6wsChzc+DHo5uhj2fkvEoikiIKCSnOBq7y5m7mifN3swM2vIc8vd0SVQhy?=
 =?us-ascii?Q?7a3xtiqGoFhikGZaETfvZv+rYkSfJXi0G2/jkqybFixMsq2E2Vr55WthgajX?=
 =?us-ascii?Q?b0+2UQ2ATlGeg6Kgem/wZQ9Q3C1iqvHGBszMwlJ9skmx67zvg2cX2xCf1J41?=
 =?us-ascii?Q?bsfE+Ta/WhqeLKvuVhoskTJcjae52P8/ut6Y/xItOFO12qVpycGFbsNDG7/w?=
 =?us-ascii?Q?y8w9y7YQW7o3r0RoF5sL4r9IgSTpRo+KAopMaOvgR9sbEroluGmQPyKuM1Xm?=
 =?us-ascii?Q?/ebiGYLl1eN+CwD6f+Ktzs1EsgSOUxJnzZQKdHrEovkhPIrXZmwIckpVXnsQ?=
 =?us-ascii?Q?Hk6NJ021rfIARM+IpKASpC4iq9Cye/dH?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 20:11:24.3195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7b691c-367f-494a-b116-08dcb71d1cd4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6256

Add a new IOMMUFD_OBJ_VIOMMU with an iommufd_viommu structure to represent
a vIOMMU instance in the user space, backed by a physical IOMMU for its HW
accelerated virtualization feature, such as nested translation support for
a multi-viommu-instance VM, NVIDIA CMDQ-Virtualization extension for ARM
SMMUv3, and AMD Hardware Accelerated Virtualized IOMMU (vIOMMU).

Also, add a new ioctl for user space to do a viommu allocation. It must be
based on a nested parent HWPT, so take its refcount.

As an initial version, support a viommu of IOMMU_VIOMMU_TYPE_DEFAULT type.
IOMMUFD core can use this viommu to store a virtual device ID lookup table
in a following patch.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/Makefile          |  3 +-
 drivers/iommu/iommufd/iommufd_private.h | 13 +++++
 drivers/iommu/iommufd/main.c            |  6 ++
 drivers/iommu/iommufd/viommu.c          | 75 +++++++++++++++++++++++++
 include/uapi/linux/iommufd.h            | 30 ++++++++++
 5 files changed, 126 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/iommufd/viommu.c

diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index cf4605962bea..df490e836b30 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -7,7 +7,8 @@ iommufd-y := \
 	ioas.o \
 	main.o \
 	pages.o \
-	vfio_compat.o
+	vfio_compat.o \
+	viommu.o
 
 iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 5d3768d77099..0e3755408911 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -131,6 +131,7 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_IOAS,
 	IOMMUFD_OBJ_ACCESS,
 	IOMMUFD_OBJ_FAULT,
+	IOMMUFD_OBJ_VIOMMU,
 #ifdef CONFIG_IOMMUFD_TEST
 	IOMMUFD_OBJ_SELFTEST,
 #endif
@@ -526,6 +527,18 @@ static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 	return iommu_group_replace_domain(idev->igroup->group, hwpt->domain);
 }
 
+struct iommufd_viommu {
+	struct iommufd_object obj;
+	struct iommufd_ctx *ictx;
+	struct iommu_device *iommu_dev;
+	struct iommufd_hwpt_paging *hwpt;
+
+	unsigned int type;
+};
+
+int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
+void iommufd_viommu_destroy(struct iommufd_object *obj);
+
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
 void iommufd_selftest_destroy(struct iommufd_object *obj);
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index b5f5d27ee963..288ee51b6829 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -333,6 +333,7 @@ union ucmd_buffer {
 	struct iommu_ioas_unmap unmap;
 	struct iommu_option option;
 	struct iommu_vfio_ioas vfio_ioas;
+	struct iommu_viommu_alloc viommu;
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
 #endif
@@ -384,6 +385,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 val64),
 	IOCTL_OP(IOMMU_VFIO_IOAS, iommufd_vfio_ioas, struct iommu_vfio_ioas,
 		 __reserved),
+	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
+		 struct iommu_viommu_alloc, out_viommu_id),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
@@ -519,6 +522,9 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_FAULT] = {
 		.destroy = iommufd_fault_destroy,
 	},
+	[IOMMUFD_OBJ_VIOMMU] = {
+		.destroy = iommufd_viommu_destroy,
+	},
 #ifdef CONFIG_IOMMUFD_TEST
 	[IOMMUFD_OBJ_SELFTEST] = {
 		.destroy = iommufd_selftest_destroy,
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
new file mode 100644
index 000000000000..35ad6a77c9c1
--- /dev/null
+++ b/drivers/iommu/iommufd/viommu.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
+ */
+
+#include <linux/iommufd.h>
+
+#include "iommufd_private.h"
+
+void iommufd_viommu_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_viommu *viommu =
+		container_of(obj, struct iommufd_viommu, obj);
+
+	refcount_dec(&viommu->hwpt->common.obj.users);
+}
+
+int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_viommu_alloc *cmd = ucmd->cmd;
+	struct iommufd_hwpt_paging *hwpt_paging;
+	struct iommufd_viommu *viommu;
+	struct iommufd_device *idev;
+	int rc;
+
+	if (cmd->flags)
+		return -EOPNOTSUPP;
+
+	idev = iommufd_get_device(ucmd, cmd->dev_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+
+	hwpt_paging = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
+	if (IS_ERR(hwpt_paging)) {
+		rc = PTR_ERR(hwpt_paging);
+		goto out_put_idev;
+	}
+
+	if (!hwpt_paging->nest_parent) {
+		rc = -EINVAL;
+		goto out_put_hwpt;
+	}
+
+	if (cmd->type != IOMMU_VIOMMU_TYPE_DEFAULT) {
+		rc = -EOPNOTSUPP;
+		goto out_put_hwpt;
+	}
+
+	viommu = iommufd_object_alloc(ucmd->ictx, viommu, IOMMUFD_OBJ_VIOMMU);
+	if (IS_ERR(viommu)) {
+		rc = PTR_ERR(viommu);
+		goto out_put_hwpt;
+	}
+
+	viommu->type = cmd->type;
+	viommu->ictx = ucmd->ictx;
+	viommu->hwpt = hwpt_paging;
+	viommu->iommu_dev = idev->dev->iommu->iommu_dev;
+
+	refcount_inc(&viommu->hwpt->common.obj.users);
+
+	cmd->out_viommu_id = viommu->obj.id;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_abort;
+	iommufd_object_finalize(ucmd->ictx, &viommu->obj);
+	goto out_put_hwpt;
+
+out_abort:
+	iommufd_object_abort_and_destroy(ucmd->ictx, &viommu->obj);
+out_put_hwpt:
+	iommufd_put_object(ucmd->ictx, &hwpt_paging->common.obj);
+out_put_idev:
+	iommufd_put_object(ucmd->ictx, &idev->obj);
+	return rc;
+}
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index d42e0471156f..ed6cdc2e0be1 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -51,6 +51,7 @@ enum {
 	IOMMUFD_CMD_HWPT_GET_DIRTY_BITMAP = 0x8c,
 	IOMMUFD_CMD_HWPT_INVALIDATE = 0x8d,
 	IOMMUFD_CMD_FAULT_QUEUE_ALLOC = 0x8e,
+	IOMMUFD_CMD_VIOMMU_ALLOC = 0x8f,
 };
 
 /**
@@ -876,4 +877,33 @@ struct iommu_fault_alloc {
 	__u32 out_fault_fd;
 };
 #define IOMMU_FAULT_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_FAULT_QUEUE_ALLOC)
+
+/**
+ * enum iommu_viommu_type - Virtual IOMMU Type
+ * @IOMMU_VIOMMU_TYPE_DEFAULT: Core-managed VIOMMU type
+ */
+enum iommu_viommu_type {
+	IOMMU_VIOMMU_TYPE_DEFAULT,
+};
+
+/**
+ * struct iommu_viommu_alloc - ioctl(IOMMU_VIOMMU_ALLOC)
+ * @size: sizeof(struct iommu_viommu_alloc)
+ * @flags: Must be 0
+ * @type: Type of the virtual IOMMU. Must be defined in enum iommu_viommu_type
+ * @dev_id: The device to allocate this virtual IOMMU for
+ * @hwpt_id: ID of a nesting parent HWPT to associate to
+ * @out_viommu_id: Output virtual IOMMU ID for the allocated object
+ *
+ * Allocate a virtual IOMMU object that holds a (shared) nesting parent HWPT
+ */
+struct iommu_viommu_alloc {
+	__u32 size;
+	__u32 flags;
+	__u32 type;
+	__u32 dev_id;
+	__u32 hwpt_id;
+	__u32 out_viommu_id;
+};
+#define IOMMU_VIOMMU_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_ALLOC)
 #endif
-- 
2.43.0


