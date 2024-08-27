Return-Path: <linux-kselftest+bounces-16425-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2869614DB
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F7E61C20B81
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6173C1D0DC6;
	Tue, 27 Aug 2024 17:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I9ZZBQ8N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4A41CF2B3;
	Tue, 27 Aug 2024 17:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778113; cv=fail; b=LF6IsUrCySr++SlRqOyc07cmhFxYLVfcHeXJBluLNlJ89jadPaN3hz0ER9OT0iKgyLfVnWMbpDTPLFquqWNK8/OCzPmSOQhzQms9+z5aB/6qeZ6xg2pw2U/ZNM3BFStLvBZjrSPHvv/AnNJG3nOHwTqXqv9O/J66q0jGMhXqfy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778113; c=relaxed/simple;
	bh=SZKgrD+e6LYshGsYVpasROFM9xfBX9K3MRR8qcdloic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dGoc4kUfdNR4UZ10aiSGVkHfbOI5p1IpVZRTZos7TaiEmkuswx9H2stDHkCub3vfYfiqnEglW3P0eXISLqxTDYBIFF2SVLwu2loBkg7XgewI59gyI1/1+2aVzjPvzjuAW5EmklQwt52Ri+UmzWrtlaGeeSqK8WpAH0uZ+mqzA4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I9ZZBQ8N; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IRBgY93mtyBQSyt1ZzmZnsDOXqTyp23o5j/LawXuKzqlfGY91zQJL2tKgG9+kuw9Py+xwKbcgvyQX0WveDhok/Qcv8g1UvbqNA7kBCutCEF4XUNAbseTtIRjapQTniMIF+cYxjsV8qCxwdBX3IOffcBh+/i+FVvRmlSzu3we4ZJeCc2YiFmV2yoP7MKW6I2nOyKukU+vnsn80nUSJXHYfCM9apIbtPKNlQbCq+eK9CNWu3KT1cgtLklIJeypob22pFJkn6RggMBtg664fQLbAR/ZIflU+IziqsSDdyLRPHLrZ3zsj3QahZsWCOH1eSd4mOzqlcw4viiFUb+Qkvqqxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoUgUa5I3AASs0dMmQBg6tBhqa5jJGLYAArew/bHCgI=;
 b=w3FuDNCWnXBIYDDjB3eQ65sSo0NZqJFOUqjmcWo5MZByc1VuOpNdCeyHqJg1Zs9gGNNTcRzbeOu63DoNzcxq6nqE8Q79b0fYpFAMA4CI5EQc+8cNPF0IoNxOGIzH/AP8Muo1C0pceSZWUJQ4ZCilOv3BjMEFtegt6LSQUarCewfwZXWkI4DWCmKj41sY+jARuRA8G3Y85fk2tUBVKzC4z7fQA+XS/B6i8vDFJChpLo76FPm0bmylI4NqDSp6ox1Fd7CB+1n5mVPIFH29V3OO5gH/Zg7XX5CR6+Sh7gFhTWQxf5FhlYUNonCyhH9MNGGEelgyIdFIUmgaAB5XpUZ/sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoUgUa5I3AASs0dMmQBg6tBhqa5jJGLYAArew/bHCgI=;
 b=I9ZZBQ8N2SGVXwtgLckBLHO6yIF+Uwr6hXx+18NNpArEf6kt0Qkj5JjprO5oD4IruqfxU2bhsSv8GglIBShuOTpuCG5+sZ0qkjjmovVQdPB/OZxxfOiLiun5znOtQIvMcE/fboIhspBxd3La83TLVYwBr4pW2f8uILu2zaGwEKchkmKsf+3FhtJBY3Nuraw1uEJEHmWV60KEpLC1HehN5dFZRSw3lFtGrd4Oh+Ezcq9gvTe+DGVEcd3SSmOcbzduHusKz72fjUsY3jqXdFLaI2qQ6ZGj9+3oJLPJaFGrlfQl5+T9LGtdWEJr+BpjSCI4Fd7j7iZsXUvZjgCnE1HPwQ==
Received: from DS7P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::7) by
 DS7PR12MB6119.namprd12.prod.outlook.com (2603:10b6:8:99::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.23; Tue, 27 Aug 2024 17:01:45 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:8:1ca:cafe::bf) by DS7P220CA0005.outlook.office365.com
 (2603:10b6:8:1ca::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26 via Frontend
 Transport; Tue, 27 Aug 2024 17:01:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Tue, 27 Aug 2024 17:01:44 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:01:33 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 Aug 2024 10:01:33 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 10:01:32 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: [PATCH v2 02/19] iommufd/viommu: Add IOMMUFD_OBJ_VIOMMU and IOMMU_VIOMMU_ALLOC ioctl
Date: Tue, 27 Aug 2024 09:59:39 -0700
Message-ID: <c6ac7dc5031e96abb4634db504a0bf4a0c82ca66.1724776335.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|DS7PR12MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: 2793cb74-2c66-4838-fade-08dcc6b9ee4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MFfTYyFvT9kKybYBToZi0gZAsY24hCVZILJjhwUnHXTbwy5QGrLNrju2qo6j?=
 =?us-ascii?Q?i6TUC4ZqpbajCljXmVYE0s0yBpTrgRZmGpNqNiirhLKGD6vuGl0X1bwxREmN?=
 =?us-ascii?Q?KQoQASd0gL0Y7Szyv2YDu+M21psSDaeTo72vSXY79qxjNr9Er4grU87vYlpJ?=
 =?us-ascii?Q?2n8ke4YIQVfF0rSs34o4c1lmUQ5M86HIZQUzoZwK3mcOuwZYIgErcKlpaEOb?=
 =?us-ascii?Q?VEIQ+FC809fsL7belSlOJM8UC5S8q9eMP0TMLwiy9OdlNGU6DivkxXQSnucz?=
 =?us-ascii?Q?4ad5gHO5Qm8HiN3/3KrQPvoe76W8AFhRjhHkKhckBO6BNGhWBVsc9ts4uptG?=
 =?us-ascii?Q?MqSATjTAL3wgDIaqRpqenxmtnwF2CECF37A3ZYRYow1/tCxbQC/od43NZzM7?=
 =?us-ascii?Q?5s4sCE81sczF59SYWZBMazNrtdZhMyOzdERRmwbJMkhpkW435JSSbrs0zkyh?=
 =?us-ascii?Q?Ka+E0cpZKFv+1BxlQkSHV3iecUzEmfqVR+AXOfbEvHVA2fCX0buYHISDNawY?=
 =?us-ascii?Q?f/jxXRtaa91n/tYBtlctVtf4J6F03pwzxpxI1mJz0AGzCisiqgi1eLZwgOXQ?=
 =?us-ascii?Q?AF1SgzU55orLTl84871+4s0deb9z1Kl16/IA9oPgE8JoD+iEc/UMF/ysFXAY?=
 =?us-ascii?Q?RV67gYlgSy2DP+NX06m9YtpvjJ6Tp1J4U0Qt2N/pPcrErWgTqlZsF+a/M5Vd?=
 =?us-ascii?Q?Zbu3mLMUz6ioayoydSxftqEI2RqRLLawTLIBYzVeby8nikd0VOU27elo6gAP?=
 =?us-ascii?Q?gHUf10KDStUc9M7DhC5jpI6bUdr8P6jqGT8Tfa/ymtytLB+Bsw9mQY4qlT2W?=
 =?us-ascii?Q?ZGYlZMun8B+SnmQ8k8seVf0eAXdqbBKPcs/YqtJiZkLTZ3f0gzsGrGxv/2qA?=
 =?us-ascii?Q?lpXOi3W0nkGyTT6YqOCY5lcfzCnpIxodu5WSxoWESJ6pp+IL80MOL9n9u0yh?=
 =?us-ascii?Q?TVOhcoyTPNT2iMnMXhkNxySHVVlYa4mFIqaKHvw0ozsKmx+R9szhngfQkZsT?=
 =?us-ascii?Q?ZEKuqnZF8QVElp6AY1lPWZmL/lnrZfrYzMP8NLfjoqlYeFuTYoDMfOUrM1oL?=
 =?us-ascii?Q?9cvOHCDNkusnIC57aWQXqJKb9UrGqv5bcqUhv87h5QyNnsgXNIhZ/S+YuQEL?=
 =?us-ascii?Q?SqZKtTX5ojslNkmxnuYrY+pHPgOIckrmW+8oyz6LiC6pWe9U47Cn1ORPze5Q?=
 =?us-ascii?Q?lGyuaeJbddk5HWqdtCZa9rp9Xv/aGcY7Ow/p3oCI8zKGjSMzmkxpZ+2Z3czj?=
 =?us-ascii?Q?dXGZDc9wQE18V4cEHueTh4KgrZfIEdBpphm0rx0je0mM5ZFpX5npCFYYTdxX?=
 =?us-ascii?Q?3YuqZRb8ga9RsGXMBukkGiXTflPVJHQu+QWBEMRnIU4apNKmIU8zmTZoWTt4?=
 =?us-ascii?Q?xx4WCnnzrV7WOy9rE35FqyZ1LgcXdvHznfrMyZQ08Kvtf/+eXLF32BsJKOJO?=
 =?us-ascii?Q?x/LvkUZFr7jifjpr13UunYZYjQyBGEZK?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:01:44.7945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2793cb74-2c66-4838-fade-08dcc6b9ee4c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6119

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
 drivers/iommu/iommufd/iommufd_private.h | 12 +++++
 drivers/iommu/iommufd/main.c            |  6 +++
 drivers/iommu/iommufd/viommu.c          | 72 +++++++++++++++++++++++++
 include/uapi/linux/iommufd.h            | 30 +++++++++++
 5 files changed, 122 insertions(+), 1 deletion(-)
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
index 5d3768d77099..154f7ba5f45c 100644
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
@@ -526,6 +527,17 @@ static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 	return iommu_group_replace_domain(idev->igroup->group, hwpt->domain);
 }
 
+struct iommufd_viommu {
+	struct iommufd_object obj;
+	struct iommufd_ctx *ictx;
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
index 000000000000..200653a4bf57
--- /dev/null
+++ b/drivers/iommu/iommufd/viommu.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
+ */
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
index cd4920886ad0..ac77903b5cc4 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -51,6 +51,7 @@ enum {
 	IOMMUFD_CMD_HWPT_GET_DIRTY_BITMAP = 0x8c,
 	IOMMUFD_CMD_HWPT_INVALIDATE = 0x8d,
 	IOMMUFD_CMD_FAULT_QUEUE_ALLOC = 0x8e,
+	IOMMUFD_CMD_VIOMMU_ALLOC = 0x8f,
 };
 
 /**
@@ -852,4 +853,33 @@ struct iommu_fault_alloc {
 	__u32 out_fault_fd;
 };
 #define IOMMU_FAULT_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_FAULT_QUEUE_ALLOC)
+
+/**
+ * enum iommu_viommu_type - Virtual IOMMU Type
+ * @IOMMU_VIOMMU_TYPE_DEFAULT: Core-managed VIOMMU type
+ */
+enum iommu_viommu_type {
+	IOMMU_VIOMMU_TYPE_DEFAULT = 0,
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


