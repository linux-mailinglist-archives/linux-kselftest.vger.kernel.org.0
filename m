Return-Path: <linux-kselftest+bounces-20727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DE69B1373
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 01:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3921F21CE4
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 23:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09849216E08;
	Fri, 25 Oct 2024 23:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ex3TFaAG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AED22161FF;
	Fri, 25 Oct 2024 23:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729900228; cv=fail; b=NEvtRG2ZaoXOZirS7K4PGQpIgRFl5DQSk1vyIxJ+Ykid/uvnxsor2jOXDUFbre/v+nxZuvKbCOHIZvInHEG81tEbm/tGauJFZE/nJI21VSYM33ZQWS6OHfDoMGugIQjO2uyr+Epo0jMxeinrDnAomVHMpA6mtkguI1Y9hdaQ+Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729900228; c=relaxed/simple;
	bh=OztQlquL6GNStwdSkRjCYvBak+3sVN1r5h6xE25PqxA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dtklmSbkQ6go7FIs3X8sPdm6MXx48SGy0Y7Re9nJn3luhhzjiAL52RpZ/JMOL8Nmx523nQQuQl5jmp4FcbZU6LpwfrjE/3t4q57eI4AeHJqtPxnagge59TElFDUvyg7SozOBllcwhmDaBFiBvfBkD8vF7JBC5NuhHllycd5Cv4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ex3TFaAG; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQBgKTEYrAJjhW7WjBXGvLPhilQAfgIZ5FVF5x6sNZun2V2o0fE1ZXhfR1U51GPBn5xLf6t5fBuTH2y1lsDwEBI0iT/sNwJ5XxqEhnsANFHX96kpp9/Q7wlK9XizlXZAjRBxmOHb99PFYIasXNt1K3tiL8SbHm6wAiNUrRkmiOLhpTwOPXBmtwbY3F+rjlfoINqq1VV24C0sUYfDF2Hvi6TItE+AF96lQL/zbUDL+EKBQyoTVMrXEFolcmL+7qZNGTxbt6C6tdx6EnbaGRcX9PPlJGT8aWSbSHdh1xMsPX0rXcmm0b66UBSjYI1wuozZG6LBFeNYhnsrIOmwXNCmKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXxW/f3tyjE9trj8JE6HQq4R4K3snvWlheDtXpQyrOg=;
 b=Vj1ckXmMDSAa/jAM/oyXGf96JU0V4ivVn6RVHhfX/RYdZYBk8jhzkZ1/7Zl3J6gYwPeDPTADx3FV2woily5KvgjsMwuvcnm14bAUdob3RHuy76aJM+4tBVYfcStQBkCXyNpuw0iddXfXw4c6thprgB3xgajeWfYX20zm59o7PZB+p8/6qdLB2MjxwbJ4JdXEkeqPiG0k3sXyhiribWMpy9fOS65BodO/yo0W4PBhNEdny6oyJ767q9eZoLRwO2dKzSjOivzd3FmGq44rVyLOdMepG/OdyUPPUjoBboGmu9/FnnGKJl7Hw7kIU2lrU5oubFdSV72eyirKr5VLP5A46w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXxW/f3tyjE9trj8JE6HQq4R4K3snvWlheDtXpQyrOg=;
 b=ex3TFaAG8ZlMn0zjarAbBcczn4graEH1Qmdg28rUQyG1IeqxWreUFN8dVXMs+XB/uEqBCjoIRn+Pysplg/8xDhGtOQjk1ruDsg0TqtYEZC3B+W6xj3fUc594SjEwW40PO6tDzCrO+6NzVNtRV9cAwlML5qO7pb7JusqjZ6CMJkXfNawgC7KMkkmtn74aKpxKI858G+UtN2gn9SuzGh+ta5yJ3p8OEMSGqqKPRJWtvkgdg5pKCDsDPcF87TImQ7g4TaaSG5gf6EDnlUTYm02oDP7DNdAdkehU/0+UUOfJfY5qTVvmC2RP2tvFcjWcxzoS4a7L+Oz8v06NDeaDQ7ll0A==
Received: from BY5PR03CA0019.namprd03.prod.outlook.com (2603:10b6:a03:1e0::29)
 by SA0PR12MB7477.namprd12.prod.outlook.com (2603:10b6:806:24b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 23:50:21 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::5) by BY5PR03CA0019.outlook.office365.com
 (2603:10b6:a03:1e0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Fri, 25 Oct 2024 23:50:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 23:50:20 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 16:50:11 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 25 Oct 2024 16:50:10 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 25 Oct 2024 16:50:09 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: [PATCH v5 06/13] iommufd: Allow pt_id to carry viommu_id for IOMMU_HWPT_ALLOC
Date: Fri, 25 Oct 2024 16:49:46 -0700
Message-ID: <4f5ed9d75c23a503ffe672a85cf9010569652794.1729897352.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729897352.git.nicolinc@nvidia.com>
References: <cover.1729897352.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|SA0PR12MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: 617f5c88-4f17-4511-b55a-08dcf54fc958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ODOJfphHc2MNgMl4qFLzauAGNj5l1hOBAqUbDEbGoaVaRxaUoiaY3nCUtzSD?=
 =?us-ascii?Q?gezeRQPBu3F5hSrqfWcJhOMTQ9a+DxtktLN7J/QOstB0goOCZn243hPbHSzW?=
 =?us-ascii?Q?6p+UxF1otxvAeUwbN/IZwfZH45naJiQnFjmzbWsvijxgZzMnIjGlGvIOqPNm?=
 =?us-ascii?Q?PhaI62eNK5RrsAp9TY9JVkp7UUUSJotYFjsXS38JJofHKlsf89IC8B+vp1N6?=
 =?us-ascii?Q?kDekDXq5AaMLnay7eBcljqn+cB9+ImY7XRTKzaRV/1qLj584Pv5JuL6dJUoe?=
 =?us-ascii?Q?dKMPuuiDtMMERaq/3yHcErS9Qz9DhA03rWfA00FbatKcUjfSJZUVH/7kKP3H?=
 =?us-ascii?Q?EpycV9Kpas5Gg8TVLOelVYrhO6HNFFz3LZCg2yOxIPZCWs1I6GdqlJXoufw3?=
 =?us-ascii?Q?bMaPXlP6sQk4DNlZ8KnWwj/5EhVmefrbQVAUB4HTX5pyrau8wcagX8uUjKjL?=
 =?us-ascii?Q?+sbvzPrPHcr+fSDxxQMALAfiK3ahJKKoBfkPhuooYwSR0mxXa+3ixTvnjt44?=
 =?us-ascii?Q?JCgnSOjpn2w29XxEGeWC/4FuwT4ds/Ot/P8TSdTzwy4ZeDj8ERj8FlB9fl+F?=
 =?us-ascii?Q?gP0GL0p3l2JmQPEbmIdqwDKs7ixPvTwvU3AhExW46uh6Zy+cpYyswozfbdXD?=
 =?us-ascii?Q?cccev2rMvxDSFjAqAAW3jMDMEDatvhZBfwfwKpwx1fbhzEK3TtXfM3P6AZfd?=
 =?us-ascii?Q?UQ49F6knIfVRfHbrMRLZhfezAgcsiso4Px0Mje4Ux5n2tdl20n5NHd9fwHE/?=
 =?us-ascii?Q?U0HHZotqLQ961OCVBH/P3qq2tP38kEqpINvgL2aSCCSxXGssQe2LQTyFfaC9?=
 =?us-ascii?Q?KTMf4BwsIwc6i0lb4RkbiRK0nmeEyo899ew0l+t1meFZZ8WcoIRmj8dwGA8b?=
 =?us-ascii?Q?SH80r7lmUS/N7gNnURZSFOpWj+BkjFdOIH8yNyYl3+JEI8DJS+YXBxaRyAi+?=
 =?us-ascii?Q?NNbAZJsdKiHRVsklf4m1oYIELI/7YmRdP7SS8qbjGpwxFcY2ZMfqsqfeghFY?=
 =?us-ascii?Q?0ZRA/Lr07N+72MBuZI4sU3mVADVN0sUUsFqtswPw3OsnaTfKbyY/tQIL7Ni2?=
 =?us-ascii?Q?7u/UkrNcYEgaQbdMU106gS35kwjVNFqubKoehUpb0+v7lEIO3xmRJiJUAaZ7?=
 =?us-ascii?Q?IAjqaXpe3cxwa9gHeEg7igbYaLhy+yJbQm5KNYPIVaJUdaC8RJqTy6OSTa+y?=
 =?us-ascii?Q?ngWQr4VTLqqOKz7mV8k16xfpfRK6oSuq7D9CRSiTTC6G4EyqFdVZkTVk6hLF?=
 =?us-ascii?Q?+DvxR+E3UF7mP4cCKN1aY/Y3RaWm+2a0kGhwYV1I96SspTMz7eTes8xfTUA8?=
 =?us-ascii?Q?dCGlqjWlxdtfq+AxWheCAgvkvP7f/9ONkFkgJsfPdbWubb00M87eGGpWX/EM?=
 =?us-ascii?Q?0EhrkOEKlVIzfU8svU9m6vM8ZGnGOQ4UBXAAFhzp+6v1f8yVUw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 23:50:20.8242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 617f5c88-4f17-4511-b55a-08dcf54fc958
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7477

Now a vIOMMU holds a shareable nesting parent HWPT. So, it can act like
that nesting parent HWPT to allocate a nested HWPT.

Support that in the IOMMU_HWPT_ALLOC ioctl handler, and update its kdoc.

Also, add an iommufd_hwpt_nested_alloc_for_viommu helper to allocate a
nested HWPT for a vIOMMU object. Since a vIOMMU object holds the parent
hwpt's refcount already, increase the refcount of the vIOMMU only.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 include/uapi/linux/iommufd.h            | 14 ++---
 drivers/iommu/iommufd/hw_pagetable.c    | 71 ++++++++++++++++++++++++-
 3 files changed, 79 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 9adf8d616796..8c9ab35eaea5 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -288,6 +288,7 @@ struct iommufd_hwpt_paging {
 struct iommufd_hwpt_nested {
 	struct iommufd_hw_pagetable common;
 	struct iommufd_hwpt_paging *parent;
+	struct iommufd_viommu *viommu;
 };
 
 static inline bool hwpt_is_paging(struct iommufd_hw_pagetable *hwpt)
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 3d320d069654..717659b9fdce 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -430,7 +430,7 @@ enum iommu_hwpt_data_type {
  * @size: sizeof(struct iommu_hwpt_alloc)
  * @flags: Combination of enum iommufd_hwpt_alloc_flags
  * @dev_id: The device to allocate this HWPT for
- * @pt_id: The IOAS or HWPT to connect this HWPT to
+ * @pt_id: The IOAS or HWPT or vIOMMU to connect this HWPT to
  * @out_hwpt_id: The ID of the new HWPT
  * @__reserved: Must be 0
  * @data_type: One of enum iommu_hwpt_data_type
@@ -449,11 +449,13 @@ enum iommu_hwpt_data_type {
  * IOMMU_HWPT_DATA_NONE. The HWPT can be allocated as a parent HWPT for a
  * nesting configuration by passing IOMMU_HWPT_ALLOC_NEST_PARENT via @flags.
  *
- * A user-managed nested HWPT will be created from a given parent HWPT via
- * @pt_id, in which the parent HWPT must be allocated previously via the
- * same ioctl from a given IOAS (@pt_id). In this case, the @data_type
- * must be set to a pre-defined type corresponding to an I/O page table
- * type supported by the underlying IOMMU hardware.
+ * A user-managed nested HWPT will be created from a given vIOMMU (wrapping a
+ * parent HWPT) or a parent HWPT via @pt_id, in which the parent HWPT must be
+ * allocated previously via the same ioctl from a given IOAS (@pt_id). In this
+ * case, the @data_type must be set to a pre-defined type corresponding to an
+ * I/O page table type supported by the underlying IOMMU hardware. The device
+ * via @dev_id and the vIOMMU via @pt_id must be associated to the same IOMMU
+ * instance.
  *
  * If the @data_type is set to IOMMU_HWPT_DATA_NONE, @data_len and
  * @data_uptr should be zero. Otherwise, both @data_len and @data_uptr
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index d06bf6e6c19f..1df5d40c93df 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -57,7 +57,10 @@ void iommufd_hwpt_nested_destroy(struct iommufd_object *obj)
 		container_of(obj, struct iommufd_hwpt_nested, common.obj);
 
 	__iommufd_hwpt_destroy(&hwpt_nested->common);
-	refcount_dec(&hwpt_nested->parent->common.obj.users);
+	if (hwpt_nested->viommu)
+		refcount_dec(&hwpt_nested->viommu->obj.users);
+	else
+		refcount_dec(&hwpt_nested->parent->common.obj.users);
 }
 
 void iommufd_hwpt_nested_abort(struct iommufd_object *obj)
@@ -260,6 +263,56 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 	return ERR_PTR(rc);
 }
 
+/**
+ * iommufd_viommu_alloc_hwpt_nested() - Get a hwpt_nested for a vIOMMU
+ * @viommu: vIOMMU ojbect to associate the hwpt_nested/domain with
+ * @user_data: user_data pointer. Must be valid
+ *
+ * Allocate a new IOMMU_DOMAIN_NESTED for a vIOMMU and return it as a NESTED
+ * hw_pagetable.
+ */
+static struct iommufd_hwpt_nested *
+iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
+				 const struct iommu_user_data *user_data)
+{
+	struct iommufd_hwpt_nested *hwpt_nested;
+	struct iommufd_hw_pagetable *hwpt;
+	int rc;
+
+	if (flags)
+		return ERR_PTR(-EOPNOTSUPP);
+	if (!viommu->ops || !viommu->ops->alloc_domain_nested)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	hwpt_nested = __iommufd_object_alloc(
+		viommu->ictx, hwpt_nested, IOMMUFD_OBJ_HWPT_NESTED, common.obj);
+	if (IS_ERR(hwpt_nested))
+		return ERR_CAST(hwpt_nested);
+	hwpt = &hwpt_nested->common;
+
+	hwpt_nested->viommu = viommu;
+	hwpt_nested->parent = viommu->hwpt;
+	refcount_inc(&viommu->obj.users);
+
+	hwpt->domain = viommu->ops->alloc_domain_nested(viommu, user_data);
+	if (IS_ERR(hwpt->domain)) {
+		rc = PTR_ERR(hwpt->domain);
+		hwpt->domain = NULL;
+		goto out_abort;
+	}
+	hwpt->domain->owner = viommu->iommu_dev->ops;
+
+	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED)) {
+		rc = -EINVAL;
+		goto out_abort;
+	}
+	return hwpt_nested;
+
+out_abort:
+	iommufd_object_abort_and_destroy(viommu->ictx, &hwpt->obj);
+	return ERR_PTR(rc);
+}
+
 int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_hwpt_alloc *cmd = ucmd->cmd;
@@ -316,6 +369,22 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 			goto out_unlock;
 		}
 		hwpt = &hwpt_nested->common;
+	} else if (pt_obj->type == IOMMUFD_OBJ_VIOMMU) {
+		struct iommufd_hwpt_nested *hwpt_nested;
+		struct iommufd_viommu *viommu;
+
+		viommu = container_of(pt_obj, struct iommufd_viommu, obj);
+		if (viommu->iommu_dev != __iommu_get_iommu_dev(idev->dev)) {
+			rc = -EINVAL;
+			goto out_unlock;
+		}
+		hwpt_nested = iommufd_viommu_alloc_hwpt_nested(
+			viommu, cmd->flags, &user_data);
+		if (IS_ERR(hwpt_nested)) {
+			rc = PTR_ERR(hwpt_nested);
+			goto out_unlock;
+		}
+		hwpt = &hwpt_nested->common;
 	} else {
 		rc = -EINVAL;
 		goto out_put_pt;
-- 
2.43.0


