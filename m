Return-Path: <linux-kselftest+bounces-21491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 295CC9BD6B8
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 21:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DB101C229FD
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 20:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F6A2178EA;
	Tue,  5 Nov 2024 20:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bxtYXq35"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD1E21747D;
	Tue,  5 Nov 2024 20:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837168; cv=fail; b=FDvIcHfWruiP3TerbuEZ8dL2VMK9Vg+y+7iq3zDpbXe8EPb5Xk97oZ0Dlu2jPDj//Hw68fa3m/SivNI+alrgXuxbIFMvAQLs5/HgjwXHmYDLPOv1PjmI3rmsqb2RXQ/l9lrYkUYrYV1RBC1fTdmpwxk/kQr33IfFtDRsxXlPv0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837168; c=relaxed/simple;
	bh=TpCiws9NGqsa5GqvAFaPayBFDXJUURDTSSCzcowCN7g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PPQ3yTT16ozTGemRGJdi/dxCAzohJgWddww5kBm7PU+8W83asum614PmpSNpFB15TKvVI3P9j8fDsO6UaSWeN1lJs35wcqEIFlmxUY1pniiL15pULfNQGWhAYyuBwh6eDK0uWwHaS1bMZlzA+1Q70XUAXbX/jyP6zRgtKL1HN/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bxtYXq35; arc=fail smtp.client-ip=40.107.223.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wnmUF1wegwc+4ZCZ9hzBRuLpAr9ir5mvuMxjbTRL15CQicZSnJWJCVY36/Mewqn9XytRRrc0l8LB9xNm6YNBdsTTqUaBbhnYvmlJrJUKb44sqemfcWURQ92E2JXD+ZilGpm6Sn2q+GE+9yqehD0CzzZ1qFK23jdpSPYXWyf4YKwSZSJl2ZNN65fx0KMLGGMD84DtKp8WTNKlp4VtSAx29T5Cv7XiPbsB2DEx/XhiTsx1p6Kkv3xz/u3Cy/6uIX1TghpmHu5AYJcylSDR6oq/6h+i6pC9hKnbPJP0cxjnV7piJzNUa6mXrN0fdXEbsBpoufuSi3UHzx6kjQDua9avTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyIsS90yFFYJzJJAL1FK+nYQcFe7EQD+a0CxulFQXzc=;
 b=OPX+1zQwpabCcaIhsqZH2+2hT/jiXdiZZhle1Hlhd0dBn6AwlEdZ9pz1VisG4FC5hWHzupd6tXLPGapz21VEQwQeXZnvFvZNUbO/Az/IVAY2k4iZnnywD8nfu3Yw844ztI5H4w+Qae9nz+Q5wTdg02jyX7oxs7EdT2Yn+iMI+8zmG6CbSxhKJNNnBZN8HIoCN5VWBn0cXUmEC4cD/qsYKrKXYfDT3TFYHdwouEj7uUFvWyBCaNfC3yckNlUCqIBBLO70zYn8lQBbs84nf0r3KEVlRBLsyAOl57nEYyk1SpFKOB7xR1p2ewj18D2LtM77msnj8oLIVxnYsij/99/OpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyIsS90yFFYJzJJAL1FK+nYQcFe7EQD+a0CxulFQXzc=;
 b=bxtYXq35MlmwL0c9QkYoH+Ut+gLVUddbj1hSit/xCj1or6voiI3j8xjkdRRN0Bi9PmqYkXBT8zX93/Oc+NihgY8DpQV7kajMtWGTdNEpsnNhwXoM3HJoefq96OP5tTQDYRP06lZ0EmrZUMoGz2LJqxrwxDAGyb5/5i3hL7fPeTXtBOsoa0+U02i2HjCVuf799E0FNMgA+ob7RrSqp74KigkwFsq5HWDhODp96NZ74NusQoy9HzIsybJM00Nhsd1+WX92M6YC9RI8KvoO3guFqPxdifXHZO8Bydo8xtmY8L2FWfc6B027+ngMtdUnIrW+nCQ12nxARz55xBROQOEaCA==
Received: from BN9P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::19)
 by CH3PR12MB7547.namprd12.prod.outlook.com (2603:10b6:610:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 20:05:54 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:408:10c:cafe::9) by BN9P222CA0014.outlook.office365.com
 (2603:10b6:408:10c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 20:05:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:05:54 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:05:34 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:05:33 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 5 Nov 2024 12:05:32 -0800
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
Subject: [PATCH v7 04/10] iommufd: Allow hwpt_id to carry viommu_id for IOMMU_HWPT_INVALIDATE
Date: Tue, 5 Nov 2024 12:05:12 -0800
Message-ID: <b411e2245e303b8a964f39f49453a5dff280968f.1730836308.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730836308.git.nicolinc@nvidia.com>
References: <cover.1730836308.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|CH3PR12MB7547:EE_
X-MS-Office365-Filtering-Correlation-Id: b26d233e-0068-4851-38bb-08dcfdd54153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nndD9KGoZuPzvLYxCLY7LdZaiEfQMe4SOC3iBSTBFpsnuI2Dfd5WENPQobkn?=
 =?us-ascii?Q?mYqhOQMn/c2dB55ebsSVrwsp4PpP9EOyzNn5squABWt8Zd3QI6u8zzMzMWPT?=
 =?us-ascii?Q?mUbrhA25K4yeCb96cfJcl4PEBI80ww5SUDVMeAPHdHbVModFl5yY2i7Jx/m+?=
 =?us-ascii?Q?GsfclFl0XZB8mVzTy9q833qSgr4Khs7Mp0yY3+dlQDpqL0jyQ/G8ha8LVtVF?=
 =?us-ascii?Q?mIjzRp6G7esrfxtRjKeTNPZ3En65Ao4EgE2wvMdz1etv3Hdz7MXVSBManTog?=
 =?us-ascii?Q?e2FyRqYNqgg6tX4rEzWRDj5+ao9xbUSZdDxGPLBP+AXZYVdMyPsgMQ+iz2Ob?=
 =?us-ascii?Q?k1hXhnnaoepjEcxwU8Gwa1s9gF2kKfUzUQPjDcRUo1dRPNVVBrO1L55KMKim?=
 =?us-ascii?Q?Fa2uZZfq1it56ei2iz86giUeZCQTtoIrkX3fsB8HbzXduX2jH2sR0hXoALaf?=
 =?us-ascii?Q?g/KJJ972m6ycS3fVQ+uspWlQrYyoCRd5bAZwk0/iy8EgQYctZ2pH02EGHYeT?=
 =?us-ascii?Q?S5imJQWUYsD6DTz4bxWn3gcs2FaoCv+gZUJWZ/tLiasoP/JCIaBwh1Xho/sp?=
 =?us-ascii?Q?kpoEDKI4hr791rDChmx2DGIou6jZxAwbtfAcauTf3J4MS9t0POruLUcyMElQ?=
 =?us-ascii?Q?5pcawyWLl0v48C/j7ixlAMejPB+DzNIWZ0MbjeWI5XoYgetyjBWRibi/68PR?=
 =?us-ascii?Q?4Xm8g/i5F/y+EHHn8C8U01t3u45ftmuhyJ3jmWlvmf0+qKBHzUrjA1STStcN?=
 =?us-ascii?Q?EJlyET/DobrpibIHLkEyICmRkrCzTSKmBd1bWEJKXfznS9aJ5zD5+P1OSDE3?=
 =?us-ascii?Q?U/YZ9/6DBGFpeH5mLxTPFIb8lYmIWhyyDu0dBpXHLmXfs/86eC+X5KCFKgVB?=
 =?us-ascii?Q?y7fCZrllvIQvIZW7bc96cBFBL3TQR8NkyVuXPhU3s5qb37MtgZVJZeLMmaDk?=
 =?us-ascii?Q?NdlaPgu4dckLevWvneriNzWc90+xEBTKH88LZbeKT2Ik9/AfhMpgliF3H5aH?=
 =?us-ascii?Q?yIfwZk1IWPZuXIPb/ulnJEoGWaX5LF3dPR/3OjM5HfqgZI7nVpadeBWBITKZ?=
 =?us-ascii?Q?jc7L7qpfHwY9MA330hZso3LzXNq6mtCGqVb4QU9IEKJUqGOh0jUMLzLqqPYG?=
 =?us-ascii?Q?ZjbW1e3nluIKCeVs9FlPQVL5ZCkgQoXj9v0V3/idRXmD6xrQM5N2NnjP1Rpl?=
 =?us-ascii?Q?ba0hsPepmrk1ebZC48lFM8Ufstf9AD1NY7DUc4LA5ulBZn6hCF8axw0YlBky?=
 =?us-ascii?Q?VRc+C42LXr/vqf8Fs6grXjTvSVk7lsYTmTh0s1d/qP402bX0fXi/8aUJyq5I?=
 =?us-ascii?Q?VKJwytvzt3xhh5eFpPvCtUYVGAWktLyjhvrNMcfjwcrWjRoIXhWLf+OZFZwk?=
 =?us-ascii?Q?BqBVlC2ebf6+U/GotTr2yBc+WsUmT/FFkbMQSdSy6uoPl+SJZA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:05:54.3414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b26d233e-0068-4851-38bb-08dcfdd54153
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7547

With a vIOMMU object, use space can flush any IOMMU related cache that can
be directed via a vIOMMU object. It is similar to the IOMMU_HWPT_INVALIDATE
uAPI, but can cover a wider range than IOTLB, e.g. device/desciprtor cache.

Allow hwpt_id of the iommu_hwpt_invalidate structure to carry a viommu_id,
and reuse the IOMMU_HWPT_INVALIDATE uAPI for vIOMMU invalidations. Drivers
can define different structures for vIOMMU invalidations v.s. HWPT ones.

Since both the HWPT-based and vIOMMU-based invalidation pathways check own
cache invalidation op, remove the WARN_ON_ONCE in the allocator.

Update the uAPI, kdoc, and selftest case accordingly.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/uapi/linux/iommufd.h            |  9 ++++--
 drivers/iommu/iommufd/hw_pagetable.c    | 40 +++++++++++++++++++------
 tools/testing/selftests/iommu/iommufd.c |  4 +--
 3 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 9b5236004b8e..badb41c5bfa4 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -700,7 +700,7 @@ struct iommu_hwpt_vtd_s1_invalidate {
 /**
  * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
  * @size: sizeof(struct iommu_hwpt_invalidate)
- * @hwpt_id: ID of a nested HWPT for cache invalidation
+ * @hwpt_id: ID of a nested HWPT or a vIOMMU, for cache invalidation
  * @data_uptr: User pointer to an array of driver-specific cache invalidation
  *             data.
  * @data_type: One of enum iommu_hwpt_invalidate_data_type, defining the data
@@ -711,8 +711,11 @@ struct iommu_hwpt_vtd_s1_invalidate {
  *             Output the number of requests successfully handled by kernel.
  * @__reserved: Must be 0.
  *
- * Invalidate the iommu cache for user-managed page table. Modifications on a
- * user-managed page table should be followed by this operation to sync cache.
+ * Invalidate iommu cache for user-managed page table or vIOMMU. Modifications
+ * on a user-managed page table should be followed by this operation, if a HWPT
+ * is passed in via @hwpt_id. Other caches, such as device cache or descriptor
+ * cache can be flushed if a vIOMMU is passed in via the @hwpt_id field.
+ *
  * Each ioctl can support one or more cache invalidation requests in the array
  * that has a total size of @entry_len * @entry_num.
  *
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 982bf4a35a2b..702057655a81 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -251,8 +251,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 	}
 	hwpt->domain->owner = ops;
 
-	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED ||
-			 !hwpt->domain->ops->cache_invalidate_user)) {
+	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED)) {
 		rc = -EINVAL;
 		goto out_abort;
 	}
@@ -483,7 +482,7 @@ int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
 		.entry_len = cmd->entry_len,
 		.entry_num = cmd->entry_num,
 	};
-	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_object *pt_obj;
 	u32 done_num = 0;
 	int rc;
 
@@ -497,17 +496,40 @@ int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
 		goto out;
 	}
 
-	hwpt = iommufd_get_hwpt_nested(ucmd, cmd->hwpt_id);
-	if (IS_ERR(hwpt)) {
-		rc = PTR_ERR(hwpt);
+	pt_obj = iommufd_get_object(ucmd->ictx, cmd->hwpt_id, IOMMUFD_OBJ_ANY);
+	if (IS_ERR(pt_obj)) {
+		rc = PTR_ERR(pt_obj);
 		goto out;
 	}
+	if (pt_obj->type == IOMMUFD_OBJ_HWPT_NESTED) {
+		struct iommufd_hw_pagetable *hwpt =
+			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
+
+		if (!hwpt->domain->ops ||
+		    !hwpt->domain->ops->cache_invalidate_user) {
+			rc = -EOPNOTSUPP;
+			goto out_put_pt;
+		}
+		rc = hwpt->domain->ops->cache_invalidate_user(hwpt->domain,
+							      &data_array);
+	} else if (pt_obj->type == IOMMUFD_OBJ_VIOMMU) {
+		struct iommufd_viommu *viommu =
+			container_of(pt_obj, struct iommufd_viommu, obj);
+
+		if (!viommu->ops || !viommu->ops->cache_invalidate) {
+			rc = -EOPNOTSUPP;
+			goto out_put_pt;
+		}
+		rc = viommu->ops->cache_invalidate(viommu, &data_array);
+	} else {
+		rc = -EINVAL;
+		goto out_put_pt;
+	}
 
-	rc = hwpt->domain->ops->cache_invalidate_user(hwpt->domain,
-						      &data_array);
 	done_num = data_array.entry_num;
 
-	iommufd_put_object(ucmd->ictx, &hwpt->obj);
+out_put_pt:
+	iommufd_put_object(ucmd->ictx, pt_obj);
 out:
 	cmd->entry_num = done_num;
 	if (iommufd_ucmd_respond(ucmd, sizeof(*cmd)))
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index f3cb628753c9..8cb3e835ca97 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -367,9 +367,9 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
 		EXPECT_ERRNO(EBUSY,
 			     _test_ioctl_destroy(self->fd, parent_hwpt_id));
 
-		/* hwpt_invalidate only supports a user-managed hwpt (nested) */
+		/* hwpt_invalidate does not support a parent hwpt */
 		num_inv = 1;
-		test_err_hwpt_invalidate(ENOENT, parent_hwpt_id, inv_reqs,
+		test_err_hwpt_invalidate(EINVAL, parent_hwpt_id, inv_reqs,
 					 IOMMU_HWPT_INVALIDATE_DATA_SELFTEST,
 					 sizeof(*inv_reqs), &num_inv);
 		assert(!num_inv);
-- 
2.43.0


