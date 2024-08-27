Return-Path: <linux-kselftest+bounces-16430-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6CD9614E6
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61095B23371
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F2D1D2F52;
	Tue, 27 Aug 2024 17:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YmgbnHjn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDE01D278C;
	Tue, 27 Aug 2024 17:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778122; cv=fail; b=ujO+u9/Gx3OmLZmYQXtAldAJn8CORVnDlhbT+U++AZgc+7Cvp+PXnM/6kUb4MKo+6VHFLQlsyQ8tKBelEIi2Q0CCUQjxMhsZj0Z4bIYae6HBoO9/ptoeE2UhWrdYqXnrRX8Y/KxFeSFg7xOM/9pCBGSGuG5RKS/efAyi5CzIoms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778122; c=relaxed/simple;
	bh=cM2Fje7mbQAlmYllEI/wktppd789Zri9q+YN4tnjiZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qpPE88JMrYyH/SstiN8hvSagDCAqMnV8axpu/7eC0+dB2YXXvVgPXDazYKaRu+bZAd9kC87cPcE783thA/qz5n9Vbbg0RjQGX3gxM61DputXWOtRj4ZLKscu/Hl9f3H1ZTQPdTofBmv4EJ9GsW+DYWeDG6/ylohPEpjK+3LzYAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YmgbnHjn; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7BL8IwioVhIQQDYaQmhCbQfowhUTvPIrwJn/hGpJcSCnzJY/dO60jhUaKbiDNVz1nMy/djHEFFmIRumyWuYHxwSg9gzDWVnYOpEMiNfZ1+xA1cu6ffDnr5+jnIq2VUDZzaX9XtOGbzWQQp0BKOYq4gNHmFuL9DnGEYefTh2nlyYRL6ngIYbd+raU7APenWPzQxERx/2GniwaP6ruvR7lOpKDjx7K1US1JgbpABqg5Gdx/ErMMFthByY6a++eX71J2tlzSl7dFI8PrHjwtbmrwZqZVg1xKkr0ApuVeeykT+8j5G+j4Bfmcl+r8szdUjhwcljaGwZy5kOmyDJXSkiHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GaZekLxJyKo3YV5xZmPs125vc9+IjLQeHSWASfqbaw=;
 b=Q/2SBF/NeHlZhkpRhQpQN7EdFcYajTKxVZHEuRGy3/oVYY3Penvd/pFbXpt4fSG/TjrHyZqH20QmTXcEwdcPBQzFq+1mIwfbO3J4967BIp19PBf98O9T7wouH6lKcMp0Js+Kt4sAnccLGPg0n8Jxzi/WtmMv5JUUZTmQUM55nMN5V0CMBfUOrH/4SgnEDuzxmJXXNredwaFVdRkminVIL22pMSWGp3YVo3E23dwB8bLmvkYXJfEQxGcQObvu12KzHANy9NWb385UeTECRDVlUZrnHaW/esp5Rji02X8TftuS1BrAsW8vKH1IB0xcNO3r4U32zDFr3tXXkZGAj9dkHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GaZekLxJyKo3YV5xZmPs125vc9+IjLQeHSWASfqbaw=;
 b=YmgbnHjnxa8nxwgOrq/Ztt7narVjBgUKq6hMMfqLBl1/6s5TaqBtls568xzUSv4rXzwFl98k6rZ1iYROYc9+XKugczQWk0rWta6PpQgTeW17FfjGdvjpCkaetLHtp8Fs6GLloWdCrGTANOJb/riOaWTtasZaqjyievKIhVPydLeVccu0+fRlVSBR74EivfYG3wB7MkfqJ/Kz5HAwi09+iO1JFVJ3RZPesNOvGvL/qnso9ROx1F6XqWMceceort8KKmAYw4OcffqfwdJltLOYLKOw5EorQmTYAQI+r7v7wx8h0y8JEEruzxPDFlRY5zDrgAQtbIKrDgEX20LzQBM1GA==
Received: from PH8PR07CA0020.namprd07.prod.outlook.com (2603:10b6:510:2cd::12)
 by CY5PR12MB6058.namprd12.prod.outlook.com (2603:10b6:930:2d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 17:01:55 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::77) by PH8PR07CA0020.outlook.office365.com
 (2603:10b6:510:2cd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Tue, 27 Aug 2024 17:01:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Tue, 27 Aug 2024 17:01:55 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:01:42 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 Aug 2024 10:01:41 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 10:01:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: [PATCH v2 09/19] iommufd: Allow hwpt_id to carry viommu_id for IOMMU_HWPT_INVALIDATE
Date: Tue, 27 Aug 2024 09:59:46 -0700
Message-ID: <31c866485c79a0b43dec0d69d1fc6f23fc654e29.1724776335.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|CY5PR12MB6058:EE_
X-MS-Office365-Filtering-Correlation-Id: 12a78cb5-f90c-4b4d-2ad1-08dcc6b9f46b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vsYIOn6nUASg8j8aIRzvvazEn26flrbZ4HliO/rWurlsf/ZX3rvrHnNoRyPw?=
 =?us-ascii?Q?lzL5ImkeB99/MjkWLEKPhHPRSEwVfjq3udIA3iD/hvnP2NBQqHYeHVEiKEfa?=
 =?us-ascii?Q?KHYqJvsK2AsUqf4maB1uiWZyx5gQGpx3UUsdjYqxlWFhuEQrEi+aZuXoTOxO?=
 =?us-ascii?Q?bN48nMA6mvw9D7whajVPGAtCNbv5PKlxGg/Z63380+aWtznYVdcsi1ML2jwW?=
 =?us-ascii?Q?olCsi055XPJDPS9po0FD/s4wJaIk8J0K92mkxkHtfKiZhjRy6nLR9GmtHsol?=
 =?us-ascii?Q?cWOmZeQGAOCJ041JeTjHyEoYUwtwBTiz+RyiSUA8nGZMOsuhx2zzNgQBMTzc?=
 =?us-ascii?Q?oKnfShdO1wBwHtVPsaKajXjskcIbuMb5yQ4J1qkNzw5KyC5+GB2SCCh0jOsp?=
 =?us-ascii?Q?OutkQ9nYCIqRkjKGTqL4zXJcQqV9MiFevEDoJVw3Xkxo91WV7lgjL/n4J42t?=
 =?us-ascii?Q?0Flbg7attnQe2+pC8v5OfDTkJazSoweurtX5WQFuBBJ2cK/0UEh/113bwrDz?=
 =?us-ascii?Q?nyrdwmOXfcrUENePgCwUp1a+mfiyeZcjRmcbkXDQqZh6RGGx0nyrZWw2pcRj?=
 =?us-ascii?Q?FPMAQVfFBOHvLql6S0KieizF0IHdJc3bXKiDSMTGRVDRb7DBq3NMqdvwVnen?=
 =?us-ascii?Q?W4Mmapx4sFw9+UAksAb70vw3KpBDxh2QhtGHiQF1LJxy8b9RCHob3jiC2JL9?=
 =?us-ascii?Q?iTPTraXEFLMpD+HQnDErwC+KkG7l3jJIcGT3HZzK9J6ZWIcT2Gw8JwAdspkh?=
 =?us-ascii?Q?NQrjsb4Q5qyeJJvYOZLSb9vIEG3dXhzxwfA2OPB4YKO296HAXkzMUvlqOXKh?=
 =?us-ascii?Q?gHRIqGA3hMuh3n6DNOByq0y2OiQsJrkKPIwTTn8QxLVLcQ4EjBHVBU7bBhV0?=
 =?us-ascii?Q?apZJRg9oeP3kj/EjzYFsesXT6Nno+DWqnrcavTy6iByYEdinQSJqiopSJI2s?=
 =?us-ascii?Q?4HN573sOw+2W7ep/CGL5R2hIJgi34AmWQu6PwV6xZ2PY9RNXg1uTmdgkyvGv?=
 =?us-ascii?Q?IJ0r0ZsoRhEBhIdl18PNh/mbIdV/cGYQN4osCq7GPHJZWGWAfcBMNfY7SCST?=
 =?us-ascii?Q?1QJqL300QEX6Fx/S7y0rmMSWPIl302xaGhgsNdvqhjWAowIH200MVrM2d9GD?=
 =?us-ascii?Q?8nG2s3ZDufV15FPsZxdZeKUmHsH1buOZMRDSYuvAARisgiC3AsieFhNYQQ5j?=
 =?us-ascii?Q?Le2VQZgNlt0h5J9wGWHRdVLExwHA2qC1dIzUaVocvyhSp5bQlNa4Egh7oLLg?=
 =?us-ascii?Q?7n8V+gY/enpSzwQ7BfVtGPdthAx27W/F96IT3qD9xITNfDpQY8Dx/BaDk4vd?=
 =?us-ascii?Q?eeZLNhaBEdZFc4B8TgcB+Vbj/UX0YQjqtImMVbUynxSdt9mHOok1gPmL6xPG?=
 =?us-ascii?Q?nzEPrjY85YOIOcQDcxnHszMzzfznaz70Hs1HBk/hJm1zcKJCaUsBZFT/+3Rh?=
 =?us-ascii?Q?AjQut5l8YJaHlS7SEgQSfSLLHXK9Pj2i?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:01:55.0743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a78cb5-f90c-4b4d-2ad1-08dcc6b9f46b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6058

With a VIOMMU object, use space can flush any IOMMU related cache that can
be directed using the viommu. It is similar to IOMMU_HWPT_INVALIDATE uAPI,
but can cover a wider range than IOTLB, such as device cache or desciprtor
cache.

Allow hwpt_id of the iommu_hwpt_invalidate structure to carry a viommu_id,
and reuse the IOMMU_HWPT_INVALIDATE uAPI for VIOMMU invalidations. Driver
can define a different structure for VIOMMU invalidations v.s. HWPT ones.

Update the uAPI, kdoc, and selftest case accordingly.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/hw_pagetable.c    | 32 +++++++++++++++++++------
 include/uapi/linux/iommufd.h            |  9 ++++---
 tools/testing/selftests/iommu/iommufd.c |  4 ++--
 3 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 06adbcc304bc..6aaec1b32abc 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -432,7 +432,7 @@ int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
 		.entry_len = cmd->entry_len,
 		.entry_num = cmd->entry_num,
 	};
-	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_object *pt_obj;
 	u32 done_num = 0;
 	int rc;
 
@@ -446,17 +446,35 @@ int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
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
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 1816e89c922d..fd7d16fd441d 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -729,7 +729,7 @@ struct iommu_hwpt_vtd_s1_invalidate {
 /**
  * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
  * @size: sizeof(struct iommu_hwpt_invalidate)
- * @hwpt_id: ID of a nested HWPT for cache invalidation
+ * @hwpt_id: ID of a nested HWPT or VIOMMU, for cache invalidation
  * @data_uptr: User pointer to an array of driver-specific cache invalidation
  *             data.
  * @data_type: One of enum iommu_hwpt_invalidate_data_type, defining the data
@@ -740,8 +740,11 @@ struct iommu_hwpt_vtd_s1_invalidate {
  *             Output the number of requests successfully handled by kernel.
  * @__reserved: Must be 0.
  *
- * Invalidate the iommu cache for user-managed page table. Modifications on a
- * user-managed page table should be followed by this operation to sync cache.
+ * Invalidate iommu cache for user-managed page table or vIOMMU. Modifications
+ * on a user-managed page table should be followed by this operation, if a HWPT
+ * is passed in via @hwpt_id. Other caches, such as device cache or descriptor
+ * cache can be flushed if a VIOMMU is passed in via the @hwpt_id field.
+ *
  * Each ioctl can support one or more cache invalidation requests in the array
  * that has a total size of @entry_len * @entry_num.
  *
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index f383f3bc7c8b..12b5a8f78d4b 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -360,9 +360,9 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
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


