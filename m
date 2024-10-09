Return-Path: <linux-kselftest+bounces-19383-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A21997212
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 18:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 452B01C23694
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 16:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FED1E8829;
	Wed,  9 Oct 2024 16:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nEpfp46P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C7E1E7C23;
	Wed,  9 Oct 2024 16:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491970; cv=fail; b=T7Mu1SRsZHm3EdoA0RlS8g/2W04/O7f134YCaDL1opVvjcnfURrVS5yDJhP2hHf1AgQluhqELUX3tgjZgRyy4zLNJeVG/508QnPvmFbNMRlVuww/5jXoIZjWkGYy12ZHRxgBOR7PsD/xHkXFqkdBQDjvnyF5CTip0ImnK+0C1ZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491970; c=relaxed/simple;
	bh=f6fl64N6js2IaFK0+EmgOU99KyGuN9GrsV3A8LgrdvY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uepr1skAGErM+MOzmbc5lTUDI99y1VVX+uLvqcpB5Z5pW5QaroB8hFnTL65FHZhNjruhrMEk2Gh9jeePmrX+LXzFEgxpC6gVdOaFoyZDyQzCqzUlDWfvTesRNzmHMsKjAMeINErcRUbskxk7yAWtpaig9tZDhXnq6z/jPX1e+PU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nEpfp46P; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkO74zRJTDl1wwtTce/dkx0DeH9OhRH9veMFthkbpx87MUhnUOyZ0cW9n1gUBCiCE7UfsErdbjOjxbWyd9IKH9ToUMgeujVD/waF804QQqqFrZ66zxGVvoSjThDtdByuJdsXG9fHjSYdWewfVegfDjR43tG9VbvmOWEMm4XxUheIT6IOUxGvdF3kvQ98aQgIGZWV5ApPp7ezu9SZckGF3p5MC/1FRQajtJ13zCDPX0INFja+Ecz4C+hCWfPe6LxrAL0hmH4ye7fV7KjQtSPXqqnacBE1z2clVol8n09TZ1/UF7FJ9ryIZyHIGYcob5mYt7d5GPgkwLAq3i5hbrVGfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2hNGL8HNWFMZjoZoP0wFRbNYBNWQfrIOfJAbXCxZBQ=;
 b=vHhOBQjMoLsMmX/rEccmK45BmmhPgiRfs3ru/KXkCUXc6LujhBXzEUfMD77S2kpIP5G1LRgRoLkJvc5SbCWF/6VjT85SPmw4nROk+sRfh3pBZdudR7Ix9TXvTBNFaRZlX3CgeqLZqz5di6BK+06WzmNNTE+oyhwF7+3FL7m0rguHRqnzzUIuA6hrUSXQqk/xb3DK8DR4u8xFOXU5ucy7laFjz0SpyOfBfx0m6epNCm+AanRAB0thE5Mvs6m8joVGFJ6UeLXEtxlrW8Rn1zHHP1QB4YGmgPBujRk1+aNkrTw/x6sR0hIoK796+oJ1RawRPYSWKNFmAbEH8XHmwQZKUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2hNGL8HNWFMZjoZoP0wFRbNYBNWQfrIOfJAbXCxZBQ=;
 b=nEpfp46PxsDf0C204fr//Y9z+HV297eu/reJRcOWOiXMzB2FCjH+W46K0EDQLxboAdI6zSj/ljFaxCa4DNSfkvnr1rre7cMBVgdPU16q34EPx+dZHB1c8fgJ/X2pDfyQuZruJ9XW7kHUUKGXnodKnjPKCgfr0NqAXlgwcC1uNz0iQcIGgA8pN45c4OXa3H5O9N5/B6iANEHxXxLLAbASs0aFtHJk25u5OuCizCHECgKiyzVJdZBnm7mBAltIdeyOW94E70jsvgxcINeZSUCWo0N4Qa+VJ5o/H5BrPXJiYNom0uy7TOo7KPabAKHMkwSUeW0LqfDaWXkuVKBWdt8pXA==
Received: from SA9PR11CA0009.namprd11.prod.outlook.com (2603:10b6:806:6e::14)
 by BY5PR12MB4321.namprd12.prod.outlook.com (2603:10b6:a03:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Wed, 9 Oct
 2024 16:39:16 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:6e:cafe::fd) by SA9PR11CA0009.outlook.office365.com
 (2603:10b6:806:6e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 16:39:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 16:39:16 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 09:39:05 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 9 Oct 2024 09:39:04 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 9 Oct 2024 09:39:04 -0700
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
Subject: [PATCH v3 07/16] iommufd: Allow hwpt_id to carry viommu_id for IOMMU_HWPT_INVALIDATE
Date: Wed, 9 Oct 2024 09:38:19 -0700
Message-ID: <75cde75987bf4a73ec34335e1c13efda93791989.1728491532.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728491532.git.nicolinc@nvidia.com>
References: <cover.1728491532.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|BY5PR12MB4321:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd9872e-e719-4d7f-c5bb-08dce880ea2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rs5Jc/mtP5mRzU/zdWkeb8EP81zyYaWHhaA5Wba/octCH1A1+PtSwKxPvz11?=
 =?us-ascii?Q?vX86qP7V3K0krGRLJSGD+s+wZ7ILm1AxSDHIhmGKUCLGYb3hlVh1bflFLOF3?=
 =?us-ascii?Q?se/rQflEN9Qip56XOM2vsXK8s2/S4jQ0Lro8liOQE7mrauRI28gCfG5ZwgBq?=
 =?us-ascii?Q?LfRg3OQkvw+kVWGCDilOiacnn/WEyIxxg7sdGa1RpUj/8PiifEB2fFdNoda2?=
 =?us-ascii?Q?NV+8Itpn4n6eCamovy/n19QZoF6lKp4Nv76ULdBCm23ABebDeFtIB7LkGDED?=
 =?us-ascii?Q?O0CwOWGtWigwkeJafTmC6TQWmAfk8PoTqMxDYir3OM5+IfPcYzr8A8eaua5C?=
 =?us-ascii?Q?nJoDLbL2ULDNgjrS6WBvB6nza4iZtCHj+4yiyZ1KL7cWfCwDqSDH/RnBrlxO?=
 =?us-ascii?Q?t3iWgttVEL+nM6/8XQUO6Y9gepkjsWaoRgey9fxgslt1SOaWGWoi1sz3iNd1?=
 =?us-ascii?Q?4kc07chVFFp5q/LaJwFV0e7iBN0VduW2PU8PwFMv12Aqzj3UM8C8NWKbvvao?=
 =?us-ascii?Q?EozPYttGol+EUFLnLiS7Rzh3naQ6UXsbY10vbPFM23ep3WsrrFP8IQqCbBmh?=
 =?us-ascii?Q?OPDPO+UXSSUr3b3lmU2OcYjxUS/7utbJrO2NIt2sXdmMsIUGbwP7CFuKEpSj?=
 =?us-ascii?Q?uI43F69QUsCA395U2eriH5bMn35sY6ScQDI7v9Jlr9Da/oHG9SBjnnrA4UWr?=
 =?us-ascii?Q?oBb9W/JThLt/2l7zlRHoX+qxA3/9QLMO8yq6DDWJMrAmTf2TsP4A9FZOTM9h?=
 =?us-ascii?Q?+Am6WWEhWFBCeqfealRq7sdsqfWCSDfu9NJn2GK7qbaNpkuzFYDCYCyEAI33?=
 =?us-ascii?Q?gyGU8TpiVqJBX+EAO+FpOr7KJ+U8ewcbxdlGLKGVfE4sk8pDcTrWDOiwWJwy?=
 =?us-ascii?Q?yPMQUJx71RLmKWmUm6LGmZNHpWdC+C87qtQyHEZD9CAbZFmxGHoJ4vcEmqK6?=
 =?us-ascii?Q?/EuZ45L249DEY61zmc+JtE7ih9LPa53M4M1HzaYtE3l+/YDuy+IS9ADRlCXK?=
 =?us-ascii?Q?0ZfSjObU63u3tHhqA6CnBdID6SGRGKtfPiFff4EtI2Mzz1emhsPe51N25wIj?=
 =?us-ascii?Q?SgGIkmuVghT+sqAUYIljLoLAiXM2KcHzMcXuz6ah8VwIiYgoyWU/DmyGkwIA?=
 =?us-ascii?Q?L2LA1EReNLnBu0uZQMlhHqSqFdiIRELIi2W0oMcUVvttheTLX7DYMQS8kqOi?=
 =?us-ascii?Q?EcS21q1Svj63aQJau5UjY5rVtjE9MwveXCtJLhHQgKRDLpKMYD5AQXDYlWlG?=
 =?us-ascii?Q?5PSaWqGgqeibc9dLVwMLJi8jzmERZxGRUru+Z5fbCTN7IyHkjQe+Xj3UZpkK?=
 =?us-ascii?Q?icHUxp/RC4ZNDH6KL/WOCNuriqjQ5T8uq0enkPkKLpRo3EhTtj4iL8pa/QdW?=
 =?us-ascii?Q?A2BwTE8LHwzwga5bcnawUYt50Azq?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:39:16.0818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd9872e-e719-4d7f-c5bb-08dce880ea2f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4321

With a vIOMMU object, use space can flush any IOMMU related cache that can
be directed using the vIOMMU object. It is similar to IOMMU_HWPT_INVALIDATE
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
index 3039519d71b7..cd9e135ef563 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -728,7 +728,7 @@ struct iommu_hwpt_vtd_s1_invalidate {
 /**
  * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
  * @size: sizeof(struct iommu_hwpt_invalidate)
- * @hwpt_id: ID of a nested HWPT for cache invalidation
+ * @hwpt_id: ID of a nested HWPT or a vIOMMU, for cache invalidation
  * @data_uptr: User pointer to an array of driver-specific cache invalidation
  *             data.
  * @data_type: One of enum iommu_hwpt_invalidate_data_type, defining the data
@@ -739,8 +739,11 @@ struct iommu_hwpt_vtd_s1_invalidate {
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
index ccaaf801955c..211b3f8b4366 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -444,7 +444,7 @@ int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
 		.entry_len = cmd->entry_len,
 		.entry_num = cmd->entry_num,
 	};
-	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_object *pt_obj;
 	u32 done_num = 0;
 	int rc;
 
@@ -458,17 +458,35 @@ int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
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
index af00b082656e..2651e2b58423 100644
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


