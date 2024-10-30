Return-Path: <linux-kselftest+bounces-21169-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287279B6F40
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 22:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C2E21C2246B
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 21:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F7B22911A;
	Wed, 30 Oct 2024 21:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FYko5vp3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FFD218593;
	Wed, 30 Oct 2024 21:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324123; cv=fail; b=cMGjanUkxnibBQ/eBsghl8kxCGWQgNQ/gD2OW+xGTtKLCp9xfClvYQgHY4sdCMdeet+6vI6JYSnnHtrIbvlmI7xtyhPFl37c55e6lbSsqt2f78xYU64IfQFH66UVnpYWPEvp/EurvYI6lrDN4VLKJu/FhCRr+0mQ2sqmOWMQoP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324123; c=relaxed/simple;
	bh=cDRLYdzQm1IPPhP1XTJs7cXDmg1Xn1Iosk4EUessKQo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BkHKdmcevCVh6z/mxm1GriVlko4TcBUm+gOTaqG8mBjEFXKpAgdjEhW2UAps2F5CxpSXhX70YIkPjJutRk3MfRgN3JwGk7e0tn+O33OF8lCyqAJZReVH8LJ8kej8wjMsureub08P6QQXiRkrhdycPrdVV35P0NXEECB9giZCxjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FYko5vp3; arc=fail smtp.client-ip=40.107.212.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYMSpoBJ5ZqProYXHTl0Wxg0W9nHLCC6thXp+9RcfRNLUQam8thz0akogniAWOIaEbRbnblw0D37nssXtw7Z9pFCi3/Ttznes2LFPoIvZyRN9PoyFqabuFnipb1VmeJtV9qYRJ0OtPNS1WojtBMZGaoZXC84Xh2eYb/lUKlvaX7B2XpAgLuATZH9si4h2jiCu11Cleh3Ht2E8YrDpAAGoiZs0jt0M0p8YvBMifBXJd4ZgUn2LyfLD9EkBbZr6xtoamj8lXcg25nyuQC1l2qih2ScJczu2HLpLpkEmOr91QMPTMWV3Yq/H27i6lWroke2M65BliUxDSVu8w38kleiOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f17+eqxu4c7DRCvtR6AHha02sBOO9Y9368BrSi4yXRU=;
 b=CDpPzuPq2JaHFExjHcxoXndLrEiTy0R6uAY50GUrn36QEk/BqLGYlL1fwFySMPN7jbxizGfa5a5tmXQmuqVAhNrG2W1yO8hXEODkv8qRjRaiHaDDR3pGZEQ6OAg5kzUlG3PZDc9lSQ9sJhAAeUyrrQu/PDFUa0pijhXzoKdIwUD8tPXEr59s0CmiY+q0f2V1pPkxJgmXBrqnmvUPd3sW36/EZJcXGYhXzDBlEqon+diPNuYCJS40FC3lUc01EQNxHUwQay82FmJfSCeB8g6ozk4a0VfA7SLa8kupAY60axMGwr6H4sr3eFCDkY3x15PSvmJKdoopyv2ox3t2Zqw+lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f17+eqxu4c7DRCvtR6AHha02sBOO9Y9368BrSi4yXRU=;
 b=FYko5vp3IhKsb/AhjaxU1tCZfY7oKwO4MPIO77d7U6sNXxO22Sg+oAYPjGBO05R9/c5CZ8zAlyGq3DLm3t8ssXdXOuVtvEfG5lWm2hJD0AoJhUuRUu39jrMb3n9peLtYzwmJrK6WOa2Wi6IWR/YUvffiF6Kx2fvezdOBsAeacPB7tdPKYyyIujsD5uyyGIrlrDNydQ4sy7Z5y7ntMpK329LYZ2hLpqEXGoO3vWoVqaqkQQ/S097RyuO8drJB2F35sLO9VG2FCn+S8WVqDBvgDLPbCvGlkGi/nb3HwZ7ApTBvDv8Q+D9t31mDsq6hOH6OZZ9rUlVFpcGGlw7fiKw3wg==
Received: from SN4PR0501CA0023.namprd05.prod.outlook.com
 (2603:10b6:803:40::36) by SN7PR12MB8820.namprd12.prod.outlook.com
 (2603:10b6:806:341::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.18; Wed, 30 Oct
 2024 21:35:16 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:803:40:cafe::76) by SN4PR0501CA0023.outlook.office365.com
 (2603:10b6:803:40::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.15 via Frontend
 Transport; Wed, 30 Oct 2024 21:35:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 21:35:16 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Oct
 2024 14:35:06 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 30 Oct 2024 14:35:05 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 30 Oct 2024 14:35:04 -0700
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
Subject: [PATCH v6 07/13] iommufd: Allow pt_id to carry viommu_id for IOMMU_HWPT_ALLOC
Date: Wed, 30 Oct 2024 14:34:33 -0700
Message-ID: <41800674501340c4503cc3ad79affd19449a9ee1.1730313237.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|SN7PR12MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: acc5200b-2a04-4f46-b6f9-08dcf92abee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wWsCt5i8g2XJKoRVLHDJq/hPNUn5MnBzVbjUONCpQbwzkaLszpCPbmPIcwv/?=
 =?us-ascii?Q?7Sltyl704Y3xMVyXqdGt/+U/hNeGiPryR336LLbnTzx3TZr76CSCL3IKi8if?=
 =?us-ascii?Q?4JDHArxQBJI3CHuCLHDjcO1lQ8Jj+dHcp+wyUsOF730WGt+x/WNlcTzv1qUV?=
 =?us-ascii?Q?2tLQr7E7bAuW6RuCRVffsAvWCmt5bCT9F2xwrzjmEoyziBCenND+dBKadbuR?=
 =?us-ascii?Q?Q8fYLl80nPpcet8x3aMPei8jywvY5BYQG6B1OQzChoNIxJkJYuqtXCbtXhf4?=
 =?us-ascii?Q?YPpzYT76ygdzG01AiFsL6juQoOuOyaH1Df5VlctBd8z28DYpFnqSfSX8Idrv?=
 =?us-ascii?Q?ziLmt/HYY9AZaMO2Co+HQge59R5t860oyHB6QVB8F+75MW3bS0c+LUMYjvSW?=
 =?us-ascii?Q?ClmAjbZq4TMchwMifu2hDsDPgs7GvhxCuICNlAanDaTdzzkWerUB4F6ZnNMY?=
 =?us-ascii?Q?IIIoOIORtl4dx33IUCg8jvllnhzhqsN3+ZfYmkqppspkocMgwgZJYGvs4QhW?=
 =?us-ascii?Q?edCN27VedUV/fI+VD+VNObYAUde8ILWDxwEqxqGWCQ3+aO9T1XlUYUY7BjVe?=
 =?us-ascii?Q?F6mSNt7QuydSQaaQAAZmckb5aKRiQazKBXnDlUKmGzVodf6oll6L7WBE2Dt4?=
 =?us-ascii?Q?4GjmZU6Bw7uj30pGthmxPlygbggQZe2MsKIAsZWbiGoQL7iit5VFkEw1ecQK?=
 =?us-ascii?Q?fUpRHPY3hWG3CC30VcMk/Za777JCiB+J2znEbL7Av4pjSPGI62mMNLazIBB0?=
 =?us-ascii?Q?T5S+HKNCLBkHK2lhWnSYvu6gaT1WkpappadiMcyeKDyS2JCfFae4wckKVaaQ?=
 =?us-ascii?Q?4s7Umt6LaqZQELJL4H9s+FwrbssyJFQPYFrXjKEivHWfooPmLw1UxBZZVdAx?=
 =?us-ascii?Q?VLeVCdDYDkn20m47rMwhd+gL/n40XY3dDFRSGxWDmrikX3c93C7UbXaEvb/p?=
 =?us-ascii?Q?LKGqxqs3W32U3fxshApDy+gBRb+J1aWRK7F8764ix+1cXb0stJgq2OxrBbxV?=
 =?us-ascii?Q?4c+oKROsBqwawi4xQwpqOVHko+7IckHllt5VgDLiNnM63jgISV+s2Y6c78i/?=
 =?us-ascii?Q?4y9EmMWpbB8ELzFttVbZYYT+U9EqowveUA2hkg69pKiLvnHGBsAC2T1xjlTT?=
 =?us-ascii?Q?7cwWfV/WcaNGKco9Uiw1TySGD1w29HTK73DJ8zk+qmkV+O79VXYqBdAdzdYT?=
 =?us-ascii?Q?9lMPJezfu0XpyWxb3l14kvw5RO+jV12y5bfbaQ5htQVBebSCAFPZFgDk0KkL?=
 =?us-ascii?Q?xQl/KkAQHyv4zdHYas7L3r5paLXcoe4ACzPdN7+KhnmWCy52c8BjyraOuEQm?=
 =?us-ascii?Q?Yv7ynGneAi1N0iA0tWb3KuadoLvkOdVY8umE0Ur3AmpwSli6TsGFOW0O7WeS?=
 =?us-ascii?Q?mOVQFi1OZZnW77ko0X6Cr7GQiDRXJMJSq6h3hWw4B/S6AfmPqA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 21:35:16.4923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acc5200b-2a04-4f46-b6f9-08dcf92abee1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8820

Now a vIOMMU holds a shareable nesting parent HWPT. So, it can act like
that nesting parent HWPT to allocate a nested HWPT.

Support that in the IOMMU_HWPT_ALLOC ioctl handler, and update its kdoc.

Also, add an iommufd_viommu_alloc_hwpt_nested helper to allocate a nested
HWPT for a vIOMMU object. Since a vIOMMU object holds the parent hwpt's
refcount already, increase the refcount of the vIOMMU only.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 include/uapi/linux/iommufd.h            | 14 ++---
 drivers/iommu/iommufd/hw_pagetable.c    | 72 ++++++++++++++++++++++++-
 3 files changed, 80 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index a8104d9d4cef..e8f5ef550cc9 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -290,6 +290,7 @@ struct iommufd_hwpt_paging {
 struct iommufd_hwpt_nested {
 	struct iommufd_hw_pagetable common;
 	struct iommufd_hwpt_paging *parent;
+	struct iommufd_viommu *viommu;
 };
 
 static inline bool hwpt_is_paging(struct iommufd_hw_pagetable *hwpt)
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 302844136b02..a498d4838f9a 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -435,7 +435,7 @@ enum iommu_hwpt_data_type {
  * @size: sizeof(struct iommu_hwpt_alloc)
  * @flags: Combination of enum iommufd_hwpt_alloc_flags
  * @dev_id: The device to allocate this HWPT for
- * @pt_id: The IOAS or HWPT to connect this HWPT to
+ * @pt_id: The IOAS or HWPT or vIOMMU to connect this HWPT to
  * @out_hwpt_id: The ID of the new HWPT
  * @__reserved: Must be 0
  * @data_type: One of enum iommu_hwpt_data_type
@@ -454,11 +454,13 @@ enum iommu_hwpt_data_type {
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
index d06bf6e6c19f..384afa374d25 100644
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
@@ -260,6 +263,57 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
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
+	if ((flags & ~IOMMU_HWPT_FAULT_ID_VALID) || !user_data->len)
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
+	refcount_inc(&viommu->obj.users);
+	hwpt_nested->parent = viommu->hwpt;
+
+	hwpt->domain =
+		viommu->ops->alloc_domain_nested(viommu, flags, user_data);
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
@@ -316,6 +370,22 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
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


