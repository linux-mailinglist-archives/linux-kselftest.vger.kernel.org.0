Return-Path: <linux-kselftest+bounces-19367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A95419971ED
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 18:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD5521C23549
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 16:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F42F1DE89F;
	Wed,  9 Oct 2024 16:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HXGwpYer"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DB11A38F9;
	Wed,  9 Oct 2024 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491948; cv=fail; b=W0deJsqhne8sh65Qu2MwaaVnkTvUQyyGBxA1Wk3qgHMbn58/SFOq7IfWDIoqew3g9MIRvKLr7Qi3bZ+Fgu/smocDaPWIGpuQY13CEmz2prRUyh/636DgAtEb4lbJcF+eY368nwgCdZYXJIh0Wt7Pyl5MfEOgnP8IghUfB/LwhUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491948; c=relaxed/simple;
	bh=vlXyAJsYA1Ss59lPdz4KPpe1+BBb2puBEd2cDBaH2Cs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOfEhVngIrdm/WFAEdaZ9Dbwx5qkIS9TidfsT6pAFfIv8UXDJA0psYQjRjVumR+ZLRC6jY/xiy4pfMh6gMpf3D+TcpPkYNdFaw4phTxYL7Yg0P3IYxxt7mwPXlQSxdtnBoRjKuqJC+xLALADpiazHMqiTW7OxV+Qg6X7sh6gX5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HXGwpYer; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fIzTnFei4OJUnPUzZS7pAUyYyw/rmXVvsKUC+KKHaz61FLOcZZa+Beuo/6F7aTpSdpXUsmX7TmOvcbm9gItxxLeWQjBohmvi8Oye9ALNV9edwOJtw6+qiN8r2gurXR0IjJvu4rtL82pqDjrb/xg+vcvVDk/O+YQlNH4pOO1yC6PY4wURFuTPqtNaLFbnjm5x78vBjaarnvknC35gV8zjP+jvYVb5Epjlr6EEs4KQXhz97vuu9X8yUTK/DlX+EKKoslPZQ7EeYcX0jIuFx7POOumh/HmgPLU0We1KA+GZp31w3al51ZIn53V4vfprYL2/Uf1F9i3GOaFMXMmPdFvkqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SO955vnnyPg4dwPJcPG58qs8kKCjublLZ6A7fF6FpA0=;
 b=bZOd9CUEbrTzTrIiIllYf3oEDO2Pd2LvCPCbW4Bjb+7714f8UANNQsb2YhsHyfNbGA3Nc0tCaL2v3ePjv5syhU7p6BS4T9lALSd5/nlQGfn0uxRqd4CxGFa+hP7FCSFYN2rimcKFDw5DDOELP3Wf4RXEKGhLJOGf2yuuxd8pO9RnVe7mNiWA1lpArDn9vQmTomMpcaiVPy+5wP0qSmLVKatjL+2eyIIRat9Zzms0DzzBzGcDmvN2kpR3GWOYTiHLkljCAE7z7g6ja2CmaJLsUitr3thKxcpbuQNyjwAxYsr9lU7OxoNMW0fFhd2Oft5ln2zjjp6WfX+kqm+C6cUqmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SO955vnnyPg4dwPJcPG58qs8kKCjublLZ6A7fF6FpA0=;
 b=HXGwpYerTs7tVxuGw11H0vYpS6fRC/7RADvdxyB7GPWHuC/4HxWNyf5Je3RZl8PRLimMOCxwoUar6h5GNhHTEOZ0Mo7TphflxP5/PPxNKrRt51fS68Q6zmrrW8ux+diHOgyiKPfD6BNLPCR1v/UPbSXCXOf9wDlw5Wib+rIwYs7E4uuQ7ZwZ9iav2C0Ad9eDr+dG1ATPbGM2D4GfPrb8vqo0lHJ6aTLfLPZ1QjwYukFhEAGtQEjHCDZ4MDr5ljigBsep7kHAXF8pRPa832OQC8c0zk+fvAD0MLLBQ0IjWMpGOQp26v7Q4ZmYoDUEffv0YjTPerealh8gitQpkTVDJA==
Received: from CH5P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::25)
 by IA0PR12MB7650.namprd12.prod.outlook.com (2603:10b6:208:436::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 16:38:55 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::42) by CH5P223CA0018.outlook.office365.com
 (2603:10b6:610:1f3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18 via Frontend
 Transport; Wed, 9 Oct 2024 16:38:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 16:38:54 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 09:38:48 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 9 Oct 2024 09:38:47 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 9 Oct 2024 09:38:46 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v3 06/11] iommufd: Allow pt_id to carry viommu_id for IOMMU_HWPT_ALLOC
Date: Wed, 9 Oct 2024 09:38:06 -0700
Message-ID: <44578ede3488d7f500a113929d44ca4f34fc2052.1728491453.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728491453.git.nicolinc@nvidia.com>
References: <cover.1728491453.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|IA0PR12MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: fb43ad6b-9a2a-499d-1ad2-08dce880dd95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lym1ThesbsTZfxj2qCH3FtzYMjRpOtc5vkNgq4ggyDXOVbyuTFvMb0Wvgm3h?=
 =?us-ascii?Q?jvq8t433vYvYAZySG79yJk4xnXotgcwQ71+/INTVmARhz/1BjAXDRaU9wMGJ?=
 =?us-ascii?Q?sLqSZnc0bPqnvTGsflfSYn4lyjdrSn7UTmnE0gL5LDGSYJOrWqwK/AHUqxGc?=
 =?us-ascii?Q?pj8WK2ROFLqv0ZFX3yYHl7BukRioL6NKabhQsbKEjSvWaNGfCk85q13Vrr6X?=
 =?us-ascii?Q?DnVYnnexOkr5wubCQ7zYl6S3dpPSFPlsMCaUt8GJQi6cDv+HAa6yzk1SzO1Z?=
 =?us-ascii?Q?U/XchykKhcafrAhUX/cZzkIL5+RwEl1n00V9TWGa2eQlhzN+cdLap0NJ/44+?=
 =?us-ascii?Q?578AE5hpVPT48F+XTlU6EPdLA6eZRZe2STaXRYo7tPA2bzGI34kHT1QKFlEh?=
 =?us-ascii?Q?IxMmHBj1b0wUqfiVILqbnKsi3mW3L/hiK2z0ibmbkKIEd+APktFLh1BGSeRc?=
 =?us-ascii?Q?mxPJCkj9/3OeSxAUQ2mrTYnbLwFbb4FZsPwC/xx5fdZmXL8tHdIovPQlAGs5?=
 =?us-ascii?Q?1Qhi3hUWXe+26AcCzZegwKmaVqe7jsYL7t4N5IyNu8qy5VvlEWbMziuKoQCc?=
 =?us-ascii?Q?GLbwrXsjj4+NN9vOpO/gMh2CBadFCnySZvkIDwCth3X12wwfp7Lj/R09G9V/?=
 =?us-ascii?Q?botGpUETH4UtMI5NMxpw1UHE8RqUgXPAyhmGFQyHYzVR7NJy+M78AB7GksJe?=
 =?us-ascii?Q?bV9rhnBKCMloJ8Lj6yU6LHXla6Kjqbm34N0Sw4o4aLqLFxDRjUVfq8lHh8W3?=
 =?us-ascii?Q?YWZPVE4WeS1kulMmKrFoMWLyk3x0ZpQGaPCwPBrzthDAvj4mBN2PCrZ8Qp8n?=
 =?us-ascii?Q?EIEoKNPk+p51q/m86tsd2bM7D6GywicFYqR7g57DkptC8DQ2M+9/akE52HQd?=
 =?us-ascii?Q?cwKjCZmiqOFjiDJSOwcyqCKfFtCwVx4XQQXIqVPrEs04t4OvRFBdb/wOxRy6?=
 =?us-ascii?Q?+KLU5lcY4Vm7HfAbgUfuaJ04KKAEhIVe9eu76Qe9bUcHHXzO08rh0qrPsB4P?=
 =?us-ascii?Q?2pZjRMy4nXcCt7Y4zLt6L857TVcOwpbDHsrMdSOljD0jAVantnQmYh7hJgqn?=
 =?us-ascii?Q?aaVntEfqLIgl+r8l2bp3iUKmoXsRu3/u9uwdU9GkxljLkTk9ZIoqvcOCr/48?=
 =?us-ascii?Q?3omta+QukH8Ww6duX3qB/dAvVU5zrlhpCwlmFj8Qg22Mz66x6Ze2TTadwCQm?=
 =?us-ascii?Q?0T0k3uij4S9VPXLCpZg8CP1y1MH5bqVGcZo8qwUkmYUG5ZcPCvkdPJ7PsqES?=
 =?us-ascii?Q?CQdFX2FkTmlfEUGgrYJ8X3ZyuGmK/K7FShjvPbsh6/ey57ffe5DF2CY2D2K0?=
 =?us-ascii?Q?HAotTYAoacE9oEATDSMOqMhVyp79BkprMqcHYvHGj4CaNwwZjK/TRlXZEk+m?=
 =?us-ascii?Q?G0IMyE5lm3+OyCipmMGxuebHYzoH?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:38:54.8731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb43ad6b-9a2a-499d-1ad2-08dce880dd95
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7650

Now a vIOMMU holds a shareable nesting parent HWPT. So, it can act like
that nesting parent HWPT to allocate a nested HWPT.

Support that in the IOMMU_HWPT_ALLOC ioctl handler, and update its kdoc.

Also, associate a vIOMMU to an allocating nested HWPT.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 include/uapi/linux/iommufd.h            | 12 ++++++------
 drivers/iommu/iommufd/hw_pagetable.c    | 24 ++++++++++++++++++++++--
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 4aefac6af23f..c80d880f8b6a 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -305,6 +305,7 @@ struct iommufd_hwpt_paging {
 struct iommufd_hwpt_nested {
 	struct iommufd_hw_pagetable common;
 	struct iommufd_hwpt_paging *parent;
+	struct iommufd_viommu *viommu;
 };
 
 static inline bool hwpt_is_paging(struct iommufd_hw_pagetable *hwpt)
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index db9008a4eeef..ff8aece8212f 100644
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
@@ -449,11 +449,11 @@ enum iommu_hwpt_data_type {
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
+ * I/O page table type supported by the underlying IOMMU hardware.
  *
  * If the @data_type is set to IOMMU_HWPT_DATA_NONE, @data_len and
  * @data_uptr should be zero. Otherwise, both @data_len and @data_uptr
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 77a1d30031d2..b88a638d07da 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -57,6 +57,9 @@ void iommufd_hwpt_nested_destroy(struct iommufd_object *obj)
 		container_of(obj, struct iommufd_hwpt_nested, common.obj);
 
 	__iommufd_hwpt_destroy(&hwpt_nested->common);
+
+	if (hwpt_nested->viommu)
+		refcount_dec(&hwpt_nested->viommu->obj.users);
 	refcount_dec(&hwpt_nested->parent->common.obj.users);
 }
 
@@ -213,6 +216,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
  */
 static struct iommufd_hwpt_nested *
 iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
+			  struct iommufd_viommu *viommu,
 			  struct iommufd_hwpt_paging *parent,
 			  struct iommufd_device *idev, u32 flags,
 			  const struct iommu_user_data *user_data)
@@ -235,13 +239,16 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 		return ERR_CAST(hwpt_nested);
 	hwpt = &hwpt_nested->common;
 
+	if (viommu)
+		refcount_inc(&viommu->obj.users);
+	hwpt_nested->viommu = viommu;
 	refcount_inc(&parent->common.obj.users);
 	hwpt_nested->parent = parent;
 
 	hwpt->domain = ops->domain_alloc_user(idev->dev,
 					      flags & ~IOMMU_HWPT_FAULT_ID_VALID,
 					      parent->common.domain,
-					      NULL, user_data);
+					      viommu, user_data);
 	if (IS_ERR(hwpt->domain)) {
 		rc = PTR_ERR(hwpt->domain);
 		hwpt->domain = NULL;
@@ -308,7 +315,7 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 		struct iommufd_hwpt_nested *hwpt_nested;
 
 		hwpt_nested = iommufd_hwpt_nested_alloc(
-			ucmd->ictx,
+			ucmd->ictx, NULL,
 			container_of(pt_obj, struct iommufd_hwpt_paging,
 				     common.obj),
 			idev, cmd->flags, &user_data);
@@ -317,6 +324,19 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 			goto out_unlock;
 		}
 		hwpt = &hwpt_nested->common;
+	} else if (pt_obj->type == IOMMUFD_OBJ_VIOMMU) {
+		struct iommufd_hwpt_nested *hwpt_nested;
+		struct iommufd_viommu *viommu;
+
+		viommu = container_of(pt_obj, struct iommufd_viommu, obj);
+		hwpt_nested = iommufd_hwpt_nested_alloc(
+			ucmd->ictx, viommu, viommu->hwpt, idev,
+			cmd->flags, &user_data);
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


