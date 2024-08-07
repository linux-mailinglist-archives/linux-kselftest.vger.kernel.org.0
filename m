Return-Path: <linux-kselftest+bounces-14959-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D949294B0FC
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 22:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC071F24932
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 20:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8D51494AB;
	Wed,  7 Aug 2024 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XyR5ehBk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE391482E3;
	Wed,  7 Aug 2024 20:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723061499; cv=fail; b=BuBUh9FsZFcPXwxqdzbNymLg0hjhA7z5jSkONkjPFjITuwuA86Qw191PaqsAg6NOeQqex+g9OkqQmYQU57OVRqgq2fXGnYSO+Yx9uL9gFD2U1TN2zMZuv8q3kYdt5esPVbS3PODsF9X8xtvZPBKudps8r4xsPkn2mrVBtxa0H1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723061499; c=relaxed/simple;
	bh=LiCgA174787ViQ2lIbYwce1pvzevFdcghztSUGuQyz4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WyUYW/KlGkZHmZCJd6Id4Iv5QzKRPdSkdRi8dk1yHuO9WnwvbkPJ2NN0H2XhS2/+o3FHC3Ti0P0ePHBltzt5WvY+ubZWGoVqkeFtGDUr6QKYdivuZPLm8rm+6cGB5aIMp1JRFWtyIHonI6SJdhbUxS0C6g1vb792vf3jqXHLd3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XyR5ehBk; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJFzI9PKUI/0WxHRRz2my+4HHruh4IczrCCJghed944XS7+6FwFSbLUamlK9VabWqwafTsiSazqDEQ6F7xUDtVYYm3VblUmbwG/tkN+F8SQcQyTG//rHXwJLAkoVGDeVkvxcRnAuTS6iGPV3OkXQSFIG3/3K53LxSHrZw5tjuzib03s1wJHDSX/JmbrdxutNfIr3r/aVGsu+ROCay6qEwYq2XRoq3hPtauWBW7FqIdnqjrP5TRO6Hebbb6RrZEieAH/g1cQQlbemez97L9tKsxOAlNWP5d18FE3QHDqSS/F/eQzxyZZnTLpDeTajO287/5td3rKefTIBlA7hVBZtfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JYkKwU3A8mqt4Tl1OfDIeLhlon28+Jp/qcEf71GYtA=;
 b=w+m1s7bCFkTnv7O+ngQewuYjY2RHEZA0eTaxZlxUwFiOZzjUHr5JKRwSNxEOl4XhqucXivh8E/RE57WHMykgVim9D2fdYkT+IZ2yhvhGUvA08HFYwAzUVOO1z2ZUeqfZGCbnrGG6CCsFjIk5uZcgFvBlNlKbUtLmxbrnmZPN/1wX5zHS4rhsIIM4pP16PfRWipyqvS6a0/eckRCFmfeLLAeOIbMSYTcj2riV1l2yBNpj2HhQBwevkLVTY5yffKq532WWLDdEwTSzlBpscrERbjADeHWhhyqLV57wAU1G1hZFi57P2bAyWG0r/hxpBVxZPEbYKj2ms4Kzw4QNsSrsIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JYkKwU3A8mqt4Tl1OfDIeLhlon28+Jp/qcEf71GYtA=;
 b=XyR5ehBkio8SMIjvjHigIHt43oT+SXZeCsQUydl9STAQ1RCih9/AmzbYXEvf/+LI4LoiWle7yJhuj4cNBLe0AXHK0jlqII0e9UfpJ85tqpdRZ2NQPY3Gk8ksmKM9EJ/SeDQiIxcKWXK7KHzK1D8QmZDMavXo7YTTD/jPX+Amn1M2yF94QAm8BMflHQdiELImIRnShwYwRqug68R7ITRDKWCTvrRqisuf9xWo0KbzTcYPuI5Ua8Wwa3SyiGv3pzlxZyV8KJKXqyGq7V0Ps1cbdYYKzlTOJ6Hx/eikepejImRNEaPweU9avt8He5FzEdM08PF3pEMzwVo/HDP79lrASQ==
Received: from BN6PR17CA0043.namprd17.prod.outlook.com (2603:10b6:405:75::32)
 by CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Wed, 7 Aug
 2024 20:11:33 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:405:75:cafe::16) by BN6PR17CA0043.outlook.office365.com
 (2603:10b6:405:75::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Wed, 7 Aug 2024 20:11:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.2 via Frontend Transport; Wed, 7 Aug 2024 20:11:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 13:11:15 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 13:11:15 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 Aug 2024 13:11:14 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 07/16] iommufd/viommu: Add cache_invalidate for IOMMU_VIOMMU_TYPE_DEFAULT
Date: Wed, 7 Aug 2024 13:10:48 -0700
Message-ID: <00cd7da4abfcaa700064327a5087df8e7661116b.1723061378.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|CH2PR12MB4216:EE_
X-MS-Office365-Filtering-Correlation-Id: d91216c9-140f-4d05-1065-08dcb71d220b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j4Z1XPhyzFoNNEQhI2srTnWzqIUaLNDdpH3LmSPBUsYpP8Y0S2MPkJ3oiB5l?=
 =?us-ascii?Q?yIhNRchIWT/M1akkCD6+pUKI8QZuFpcaPZ53e4QcV0RGY/nHqWZEQXMbrcR7?=
 =?us-ascii?Q?9742qggEfIXHxoeoEmpAVzeOtxmgiz9kSQlJEkQWzJjBQ6kIQ49uSfsgTkHn?=
 =?us-ascii?Q?GPNG9OV+LfJuGEBWZvFpv64feE8yJT0YJcK/SA8fb6hbo8aBagMcwu2eN79z?=
 =?us-ascii?Q?toCq26K1mhKqIpqNaDAPGVkJmCcz84ps0pU3T5N33664XteUBvvzisLNCZjZ?=
 =?us-ascii?Q?PklSbXk5kgv2/r/oLPslBHYH2sH/m4tnIzjRmU64VLSH+Cswc4o6wL4h/1jY?=
 =?us-ascii?Q?GSh0b+9WZ2CM54aA7QRV6lu5UZEDUDQm/Dia5pVMTAFaJF4YKPZnKQFBsY6V?=
 =?us-ascii?Q?N3yXgodODNHb95v6L9R4llNNfb7ROUHiQjssFlgav5QsamuG9yGAtlD8oVaY?=
 =?us-ascii?Q?CNXNPuWxhc5UU3ZWOEHxMA0967qyQjmb0AclgtvW1Gc99aQ9l748/Qq+ltaZ?=
 =?us-ascii?Q?pBStrdeL1dhJwN0xLmDj2urCCAcQJiSKuW2qdHPpPC1KiBQaxWT9sLCgBupf?=
 =?us-ascii?Q?4Nb6MW7SbV7Gr9XDN/+F2w3vytzDkrw0qrUj2WGhkEMctoJHyNiAJzBMCn/K?=
 =?us-ascii?Q?QcMGQ8RKlF/1GBP2242GtPxcMVSc3XuadIBfed6j900YcGT2MwHWaXvHF0DQ?=
 =?us-ascii?Q?E16qsOtL8HZ4kmy7Ox1GIJ0YOSGs0jXP4v1k7jKN/4lu/hEAA6p0RdDSvb4J?=
 =?us-ascii?Q?ykUWeqO7yq+jd1cz+fBOsiaoWp70OGFYWNesWHYTqJ+gMfsxGc3/1filGSUR?=
 =?us-ascii?Q?yWypOLmmepeJ5ymOuP+PUDyx+B+yS81GtgtlaoP1bW66n3hJFt+gDFsJYYhV?=
 =?us-ascii?Q?lTEqIGBIrik34Hn0JPOEhkO+BZOVIlYJ5wYD1CcOjmwIcu65uEsH7FmldrWO?=
 =?us-ascii?Q?atxrQSmKXt1OPjleVWhxhC+g8BB333f/9MBEkG5c0+ka8p/h2D6uCZmgXTie?=
 =?us-ascii?Q?d/+JmBLPoffiAXrJccCwTR/s+jsdFMcZ9P3qiEmrKZzDRVxlTk17YpQ4wLiL?=
 =?us-ascii?Q?r5m/uTWFfl170ejkHrg2bV0PoS0kL6D1TZI253USrfejR20obpPKvEl1UNF7?=
 =?us-ascii?Q?378PT733fVpeK32X8S4Nphpz8T2gZQnIoKMXvuFRilAvro329rlDqwSLeQb6?=
 =?us-ascii?Q?bscvD0TUxGQD3xhOCsAwts+G9dsCTuy44IJ3urj0h3woExnGQkIMLDNUvPBW?=
 =?us-ascii?Q?1EmCqxdS7ADSaJ3glq891UnCcpBKmuqm/x7uOErMnvf058/yGOMc9mnZzvW4?=
 =?us-ascii?Q?6PXJJz8au13vtZhyqHpcMJYB5Yrc+szatqeTONnhw6giDm0DrQ8Vdi1YWc1o?=
 =?us-ascii?Q?o7fveufA40YwZx3MgHGAakub6CTpWZC2hCrwpk9ZConJfc4Bzg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 20:11:33.0821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d91216c9-140f-4d05-1065-08dcb71d220b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4216

Add a default_viommu_ops with a new op for cache invaldiation, similar to
the cache_invalidate_user op in structure iommu_domain_ops, but wider. An
IOMMU driver that allocated a nested domain with a core-managed viommu is
able to use the same viommu pointer for this cache invalidation API.

ARM SMMUv3 for example supports IOTLB and ATC device cache invaldiations.
The IOTLB invalidation is per-VMID, held currently by a parent S2 domain.
The ATC invalidation is per device (Stream ID) that should be tranlsated
by a virtual device ID lookup table. Either case fits the viommu context.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  2 ++
 drivers/iommu/iommufd/viommu.c          |  3 +++
 include/linux/iommu.h                   |  4 ++++
 include/linux/iommufd.h                 | 19 +++++++++++++++++++
 4 files changed, 28 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 10c63972b9ab..65023211db47 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -536,6 +536,8 @@ struct iommufd_viommu {
 	struct iommufd_hwpt_paging *hwpt;
 	struct xarray vdev_ids;
 
+	const struct iommufd_viommu_ops *ops;
+
 	unsigned int type;
 };
 
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 05a688a471db..209d419fe5cd 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -27,6 +27,7 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommufd_viommu *viommu;
 	struct iommufd_device *idev;
+	struct iommu_domain *domain;
 	int rc;
 
 	if (cmd->flags)
@@ -46,6 +47,7 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		rc = -EINVAL;
 		goto out_put_hwpt;
 	}
+	domain = hwpt_paging->common.domain;
 
 	if (cmd->type != IOMMU_VIOMMU_TYPE_DEFAULT) {
 		rc = -EOPNOTSUPP;
@@ -61,6 +63,7 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	viommu->type = cmd->type;
 	viommu->ictx = ucmd->ictx;
 	viommu->hwpt = hwpt_paging;
+	viommu->ops = domain->ops->default_viommu_ops;
 	viommu->iommu_dev = idev->dev->iommu->iommu_dev;
 
 	refcount_inc(&viommu->hwpt->common.obj.users);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 0b71b2b24ede..c884b2b9f8ea 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -680,6 +680,8 @@ struct iommu_ops {
  *                         array->entry_num to report the number of handled
  *                         invalidation requests. The driver data structure
  *                         must be defined in include/uapi/linux/iommufd.h
+ * @default_viommu_ops: Driver can choose to use a default core-allocated core-
+ *                      managed viommu object by providing a default viommu ops.
  * @iova_to_phys: translate iova to physical address
  * @enforce_cache_coherency: Prevent any kind of DMA from bypassing IOMMU_CACHE,
  *                           including no-snoop TLPs on PCIe or other platform
@@ -712,6 +714,8 @@ struct iommu_domain_ops {
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain,
 				    dma_addr_t iova);
 
+	const struct iommufd_viommu_ops *default_viommu_ops;
+
 	bool (*enforce_cache_coherency)(struct iommu_domain *domain);
 	int (*set_pgtable_quirks)(struct iommu_domain *domain,
 				  unsigned long quirks);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index c2f2f6b9148e..7da5140fa1b0 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -17,6 +17,25 @@ struct iommufd_ctx;
 struct iommufd_access;
 struct file;
 struct iommu_group;
+struct iommufd_viommu;
+struct iommu_user_data_array;
+
+/**
+ * struct iommufd_viommu_ops - viommu specific operations
+ * @cache_invalidate: Flush hardware cache used by a viommu. It can be used for
+ *                    any IOMMU hardware specific cache as long as a viommu has
+ *                    enough information to identify it: for example, a VMID or
+ *                    a vdev_id lookup table.
+ *                    The @array passes in the cache invalidation requests, in
+ *                    form of a driver data structure. A driver must update the
+ *                    array->entry_num to report the number of handled requests.
+ *                    The data structure of the array entry must be defined in
+ *                    include/uapi/linux/iommufd.h
+ */
+struct iommufd_viommu_ops {
+	int (*cache_invalidate)(struct iommufd_viommu *viommu,
+				struct iommu_user_data_array *array);
+};
 
 struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 					   struct device *dev, u32 *id);
-- 
2.43.0


