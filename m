Return-Path: <linux-kselftest+bounces-20741-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DC89B1390
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 01:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2705282BA7
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 23:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7B421CDAC;
	Fri, 25 Oct 2024 23:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="asdZxB+Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BD321C2F3;
	Fri, 25 Oct 2024 23:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729900273; cv=fail; b=THpZu9xf2wTaQVoIhGFTF/bSk5UGua+FjnP9I60xRssdNyaeL6WSHQ6VTJ6KXxPT3GgNTYYhDGe57ahfo9a4uZKezfXIH0ip+mjFBs0EqCcw2iDwiQdrzJrlGrxEPdv0Dstm/9BuPd3ucwE2E6vePgNKiWir+Fkjh+NEqleVrcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729900273; c=relaxed/simple;
	bh=HpqTs2OCbl24wRfwf4gdplJz6Ywx4+00k9/ObzFdXdc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ohorxtwti9k+dG8c/2BJouUWN4PyfFo6/U3WBX60YW1lZewYkkEP6k2tVT0NY1+SNruyIwpnnna3D8Z2vETc1iDnWKUhtZO25Ik5VKy6OJen/Ov82EVGlcYIwci7vZ0S5zl6J99xSQ4qI1V8kfgOVbJTMLha176E4rJRyPUqWyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=asdZxB+Z; arc=fail smtp.client-ip=40.107.95.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxiDr3WRUoJykaYyN+5GusFOKmhJz4WONkWEDgLw0G2H8HWAXY5Q1P92sZycD2dgA25Tjq6h/csb3sYK+NBCXr9yOb/6cRm2cRaCJoFfEESMjoFsxErFMr2db2imgiM6r0ZSmkXhhCSiyQPrspbJDTezSzCMMibMrNRMlH8DsVbEgZwaiJlhTBCudsbn/HHVgX314Rt3rR8lZZI3XNDkC7wGiEqLfcWrdBxjpD2lHj6uhWJFFdhUFqxLIaNmNRayL7cFrHgS8QBq935TBLQNtudWvG499Y27a5UyiwIM9CBByvqGK9pz7TbDE3+RhrGsfMqPbeCvI3krqWtarMMAyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5xvtaY7clknzZUM/12glWweJr8m63Ne68v3ESXh+c4=;
 b=i6k9R7hhbVuWFm1sD/FGEhwAxNK3g9dXreTr/LRRvU/zQq3dkkHl6jC+4qAC0umZ2bRljgbyki6YjZDritaIGysCJX8Lz955jrIy5Hsuu+xi9/9rTNp2dbZ7f8f4fwyHUJcRcAClI4rDrZDixUMoT2yjuE9rp4slvM2FCff60xwwbE2kgUENrNRWzD5/hmoQilosbN2raiiIDJerRvz9Ftkc9QLZyDArQhcxry9LYw4U7vYLL4l+syoYaR6yGtRZxT9QmRm6TG9/xSfTi9nRtPv8K1aQBZ1heTaonwzMIwX3ZUxDwujSR6HDLjHBGS+9pg/58FMUGpc94jEZUpYxkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5xvtaY7clknzZUM/12glWweJr8m63Ne68v3ESXh+c4=;
 b=asdZxB+ZFORHPmh21bSJsPCUb+C1zy/y+fpre7/zP1JASRWDRvrs7uY8Kv6ftr8nKYyGf5Omq+S/NcR1p2xmlNuyXVeFr9i/PNwGZOVa0nA6s3n3iRHyYtYNrNt8eD/lv1a6Yu3rCL+UlOChK+pD0k2at3QMYCBSlfz9Zxg3CdVk701FMcIAhVtBD4Gu6MxEmd6MebHo5siE9WLyWYBcbSPaxHywmgJs3+L0sqHhg+EIvCkWflIWMgAqD4IEaYkr0MDkopGXw7g4rPP+8qonGCjDMlb/O/hljxj1Y62qaFAtLa/m25GM6o8bR/2t0XR5CHRnh2TJpjCOrkJSPuJFSA==
Received: from BYAPR05CA0092.namprd05.prod.outlook.com (2603:10b6:a03:e0::33)
 by DS0PR12MB8456.namprd12.prod.outlook.com (2603:10b6:8:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 23:51:04 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:e0:cafe::73) by BYAPR05CA0092.outlook.office365.com
 (2603:10b6:a03:e0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.8 via Frontend
 Transport; Fri, 25 Oct 2024 23:51:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 23:51:04 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 16:50:55 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 25 Oct 2024 16:50:54 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 25 Oct 2024 16:50:53 -0700
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
Subject: [PATCH v5 05/13] iommufd: Allow hwpt_id to carry viommu_id for IOMMU_HWPT_INVALIDATE
Date: Fri, 25 Oct 2024 16:50:34 -0700
Message-ID: <6b8bb8f2319bf26ead928321f609105e4e5eecf4.1729897278.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729897278.git.nicolinc@nvidia.com>
References: <cover.1729897278.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|DS0PR12MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: 666c01af-2ce1-4125-6306-08dcf54fe366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xg6YK6l24WISqCsi5u3fs4tN8/XcFjP9sM+WDeXKv8xTPRw62AKtTmJOtAUW?=
 =?us-ascii?Q?GYb3PShax5+OQhqnJuCwJNDQvAK60VzvqqMLzBy+CPuD9dsJjoEe20aM7JOR?=
 =?us-ascii?Q?PDSlxcDeBDaOC7CTuHv52lSPX7Ag7wfIEF8u+J4/xg0p0Op7jLdk9ihrvWNL?=
 =?us-ascii?Q?lT/jkMOSggOlY6GbrO1QRMvY8uz91h0WGSy8rZdTwLmm//HKdFk8RJQdhqBj?=
 =?us-ascii?Q?IEe3+z5CYJ5mSPa7hjL8RPXAbjwKR8+KenAMFErUq1KyV5RDLANnaH0mIhNV?=
 =?us-ascii?Q?GQVcPF7wcF1dEH6fstxmq4Ap+0vizkcp17AyvdBa/rNp++PUc+ScaDIsi2v+?=
 =?us-ascii?Q?4UQypmPngM1jBBXAkcN1/aR/F00wLqGbvQ7jALSEE0e7h+WsoA4kIgIGg/oG?=
 =?us-ascii?Q?jbIxlfDuhZirTzGdmJSCF/+OX0mYjQen1mouWona88uSXOGy88lrWkvhoezw?=
 =?us-ascii?Q?K9Ln8/g8XiJ9haplhlouCdurPe607YnIQsgV5YmyP1khOd8qrd6A3OhC85Zj?=
 =?us-ascii?Q?f93+snn/stzZHdChiyAu8Uz69c9aPW9UgiEJFZWmvvYr1Xpdir/EyttRDeTd?=
 =?us-ascii?Q?+jWMUT7J8S9V3gQ9lsQX48/xAHVMePpwkFSJ/wF7NRAuirpDpiGGwgmoPrXO?=
 =?us-ascii?Q?XchI7Bs77R6cIaaRXsycu/Nlp3Ems9xdNwKgh+d1wNYuSDzVzFS8zQaMdjMJ?=
 =?us-ascii?Q?Onim0thn8PZvZfk7Vuz++i/8dFTdYxtLAfKNDoPq+yGaEP0YDKJXWHPZM0Gc?=
 =?us-ascii?Q?wvq47ZgAc/f6IHWHzk01Hc9Tlo3l4APKczyL6T5EwbDti/mZHJT1tvJ30pDN?=
 =?us-ascii?Q?BZbyrXT0oP+BpcQmt+BCR2UkE76sadeSG0bTy+bGWlaKRGn+oKmCznhZupG5?=
 =?us-ascii?Q?GHvWBG4tsmBiXpy/tJvGWay3RSlKKis70iPAMYCaJrMfoRuizMi8+LY+RxdY?=
 =?us-ascii?Q?CKBbhU/i7/8FP0Tx5IDeoU80JZc6t41jsOQ3JCFgcuvc0nvUeMCDdsj4ngVT?=
 =?us-ascii?Q?ja67qTyi1jh3PmrRqawSflo1hwiFL7Xd1XLcbCsRDhHdUoOv6BQQCSaBgMeg?=
 =?us-ascii?Q?1JOwwEq4BN/K+TiiVStUDn8K+lr57QG8GIKkFfJ9SmuO1TjuB/b6IAR4tqNq?=
 =?us-ascii?Q?rmEmTxci4QwW4FGvezw/gMbZU6+fL7MeId4Pxyz2q7TAoPEd0f8zCHTe6lm6?=
 =?us-ascii?Q?xD1JQBN2VEjxWxRg0hnZ2iHCuyO4O6+Q915PVijgZEBZvK31tSNlIQK/ysLA?=
 =?us-ascii?Q?tU+hyr515VGwd98PuBRIZbCW3Ki4iuG9ksnTNAbrhF0FkCKthR/tM+7I/MrM?=
 =?us-ascii?Q?vRm9vTD7LXRQPlvOw5aEPV986yMPsiG7fuAQ8oi6Tyt4SBvwvepczITk8ON2?=
 =?us-ascii?Q?gJqBAK8DCj4xl22jUZak1Wrcnk21Zx/rVzYhqnmBE/nnqtDqmg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 23:51:04.5814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 666c01af-2ce1-4125-6306-08dcf54fe366
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8456

With a vIOMMU object, use space can flush any IOMMU related cache that can
be directed via a vIOMMU object. It is similar to the IOMMU_HWPT_INVALIDATE
uAPI, but can cover a wider range than IOTLB, e.g. device/desciprtor cache.

Allow hwpt_id of the iommu_hwpt_invalidate structure to carry a viommu_id,
and reuse the IOMMU_HWPT_INVALIDATE uAPI for vIOMMU invalidations. Drivers
can define different structures for vIOMMU invalidations v.s. HWPT ones.

Update the uAPI, kdoc, and selftest case accordingly.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/uapi/linux/iommufd.h            |  9 ++++---
 drivers/iommu/iommufd/hw_pagetable.c    | 32 +++++++++++++++++++------
 tools/testing/selftests/iommu/iommufd.c |  4 ++--
 3 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index b699ecb7aa9c..c2c5f49fdf17 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -730,7 +730,7 @@ struct iommu_hwpt_vtd_s1_invalidate {
 /**
  * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
  * @size: sizeof(struct iommu_hwpt_invalidate)
- * @hwpt_id: ID of a nested HWPT for cache invalidation
+ * @hwpt_id: ID of a nested HWPT or a vIOMMU, for cache invalidation
  * @data_uptr: User pointer to an array of driver-specific cache invalidation
  *             data.
  * @data_type: One of enum iommu_hwpt_invalidate_data_type, defining the data
@@ -741,8 +741,11 @@ struct iommu_hwpt_vtd_s1_invalidate {
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
index fd260a67b82c..5301ba69fb8a 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -483,7 +483,7 @@ int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
 		.entry_len = cmd->entry_len,
 		.entry_num = cmd->entry_num,
 	};
-	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_object *pt_obj;
 	u32 done_num = 0;
 	int rc;
 
@@ -497,17 +497,35 @@ int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
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
index 93255403dee4..44fbc7e5aa2e 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -362,9 +362,9 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
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


