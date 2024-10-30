Return-Path: <linux-kselftest+bounces-21180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 599ED9B6F65
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 22:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18EA4281078
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 21:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4B422ADF4;
	Wed, 30 Oct 2024 21:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E67c2WQR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BD0219C99;
	Wed, 30 Oct 2024 21:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324177; cv=fail; b=hQ2+WTXSid+6kW0E4r2fTW5RnJFVguN3dZnjuep9GuLLlwww9bOGrCe2XqGqzBbmN87bACJ1bgxKIeVQsonjt9Y8IP9rz/emmz2c1Lz5simJrlkxIKiQ2pxgP6J3x1O8TRdZGDsm8IB1H3JL3NllzDOLWPsLk+6ofOza/PIszgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324177; c=relaxed/simple;
	bh=GKDohMoXIcmSwcs6Ehiu5O+p6ai6TLOI4k/w7mgXPfQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=azhi1Xt+PvQUtQdL8Pix5Sb22JpwvDAEmnI8B3DFCVNYf1OFdrsdpexY7yCtEUwKQ+MjlixX4w7z3CNsHpFs8CTyjP1LyBcY/7ijZKDBHWY/yrSDaI6Mv2YswfowbR2rtIT9yXzPrOtnN+042Lu1WF4yAgmIw8GtrWfRNySEPXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E67c2WQR; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gYVTdLhVZRITiwXegeLmTLPMWBu5KK2fii45vX1ZDWkecV64IqHaRa5v9mFLq6Y12W1kmDXpTpxLgLkNcafffbLpEkN0FDRioqKV7WKKPmDX57ZMi1/NdT8pY367TdelHDWS5GLmUZ6sasI6a+9eYve1cWxpr2vqmcxfA+oGZep4i1jhViYm2eQ/zbvPpmd8h7DqP50e6wPLmkJDTywIVAWLpAE9hWP/LjZf3MYUjpHAFHBHpwWQqPW6iRrHy/SPe/WdPqjypr6v3oCsqNHUnNrOY84dDvj20tLjxy6kQjrfzyeGAn23dVDvQySP4arwDPMCL+jxoLR07xBskiE94Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lN3VYjymBm9L/faFD9qLALKP72fQXayN54xedq7q8L8=;
 b=p191tKDY18V15F6hNldi5MqxoZiGDk2DwxxSbifR+i7+4HjBcSWrUsfXpznVkXOyxyLbTeGiIR6Ie+hoOrJ3o+me2LhvnUYDeCbMjBP38EYzB4GDXja6giVkjo9Z880Mo+Buhve7ta1EjjduGCwJnrEQxgTA+360v1UCciZooA5tJTQPm/UUC8BbYQaKjHYZAnFrMDe+30HkpDbVcoqTrUteAkbi2Lwu/ZyNP3S8siJpXYIZZjzEtkgryGw4Pw59MagVuJ40xyFFUcRv60yYXibJXPZrj3MfoJttHL/gs2dM51M0SDhSzAKO1nfaVsaKc9vYJmC9q7hZtnopPPE8LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lN3VYjymBm9L/faFD9qLALKP72fQXayN54xedq7q8L8=;
 b=E67c2WQRv1kep+4RTVUNe7I8okrExJFFctJo+5HRJONZKSz0/qxNwhhy0jbbEm0iS711hZVpALeDEV1eZkiOZj75mfO0YHSRVJQhecQOB2WvRBIFLs1SZ6g++9kEZewbuWRT4XeO4j6SRc8FnXN/sqST+UghGTsEShIPCKsfo87O1HQoMlvGAWj80G5H0ku2SzmzJvXVRS1KQnmkUZS3KHj/BapouZznV9mGlg7Q/kVVU2kK/XhXoNnvOtxW8TWb/gCKVVcPyKk8ELosP2PO/TAepVDKhR7XSeVVtVDSHzDqI6EpTdhrIHgytWijoLCVqLP8GhiUUnFMDYRqpPuNZg==
Received: from SJ0PR03CA0349.namprd03.prod.outlook.com (2603:10b6:a03:39c::24)
 by CH0PR12MB8577.namprd12.prod.outlook.com (2603:10b6:610:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 21:36:09 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::bd) by SJ0PR03CA0349.outlook.office365.com
 (2603:10b6:a03:39c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Wed, 30 Oct 2024 21:36:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 21:36:09 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Oct
 2024 14:35:46 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Oct
 2024 14:35:45 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 30 Oct 2024 14:35:44 -0700
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
Subject: [PATCH v6 04/10] iommufd: Allow hwpt_id to carry viommu_id for IOMMU_HWPT_INVALIDATE
Date: Wed, 30 Oct 2024 14:35:30 -0700
Message-ID: <9dc0f34fcb886f4c9db8d7cf8c558950049b8968.1730313494.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730313494.git.nicolinc@nvidia.com>
References: <cover.1730313494.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|CH0PR12MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: f0218f30-3968-442d-15f9-08dcf92ade5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EfUfKsCqwGTvTAZH95VfDTHaWgVYH1sQEAYtjDzOSmQH+a/ukEXjka+h8qQW?=
 =?us-ascii?Q?Pr4r07Hju1pFrzrMJXgPHATqjmrDdpCHMKoeb3h2KhGTxwW3+Dn22Pw6SFqR?=
 =?us-ascii?Q?P5kjaU5lryDDBwfBA4pLhLU0EZ86PcMFgYerBi2yGQEOODfB/nMpSSSDmlfi?=
 =?us-ascii?Q?n4erX4qBgBBOfAh5HpI+6pbyp2iUg2GJgnOD0yqbGZLU2lodimduFLWN0O05?=
 =?us-ascii?Q?XkF3zn2yCPZhHrA99u4Omo4JtDYpWQmtSOqLv0hRx3PGxpPGroFt7wVordlV?=
 =?us-ascii?Q?jW3VIKN/DdmV4NO+OEZLK6Vxp3ctGQHDwp56Lutr2Ek6uMUxISVfwdIpcVsB?=
 =?us-ascii?Q?aGZpi+9gyPcXS9ISCjebpppzbRQ2twbk5+f4KKNeSRbQkvXqsimBFVd9wi51?=
 =?us-ascii?Q?8wwdyUiNSYf0AUu8apyEhPpVdiKEJXTRx923wHF9sLv/tytmPpAcxz8U5V2Q?=
 =?us-ascii?Q?PtmhSqnrF8vXPJEl4waFzpGtBki0moawNosJxT2qL1wnVD0PugJImD50vf+B?=
 =?us-ascii?Q?k5kwZvnIaNROltRa4GdbE4+4m0ABn3uwZty176qvODn2mxvW7KDHrVbyZPAy?=
 =?us-ascii?Q?I9fiYJ+tin5JCAuwUBJ/n0wCQRXMQ3GrqPVxsdWBiEzyEi+nHKCVhxOIY3fm?=
 =?us-ascii?Q?wWHmmDdbMN9Y70GkjyYQJDwbL2c9KDVYA27XRLRLVnxT6a/5gJGmkXc+jXFi?=
 =?us-ascii?Q?2S4Elc+Nq982Snkm9LRKk2eO27zMCVI0ZtK4K0vzx0dX1UHEyNsE1TCpNZBe?=
 =?us-ascii?Q?9hQIOYvLRTP/D+UrwQQf3a6Vxce0t/SH3aZs5oVJY4TlCia+FOEj2yCvF+MS?=
 =?us-ascii?Q?lbC0hGcTZpwgUHsxb+stTgy+NU+EebVpmj/hrZCQhbPGQ05+jaXRBLH62pzR?=
 =?us-ascii?Q?//Wka9lHYbLcDAeKUuoR1/8HujYL7FXEWMOWSogwfNnhlUS78M2db6mhFsjp?=
 =?us-ascii?Q?9Hs6U3x7nZhEhL3VKmQfZREIcZAMriWklSCWES7mbrGsR/rd5FX8BKdVSqGA?=
 =?us-ascii?Q?+7DStmG7PoPAuK26iADsmA61wOLnaJT+WBZJkexdpQfVISPdUNK3cAi/U7CM?=
 =?us-ascii?Q?LNuP6xFATDsLFfk/8vpJlGe+V8b/0Vw3PgvdzJiD7RQKmsbIct7ID2qJic+d?=
 =?us-ascii?Q?HsfF6aV9E0Oeu9KQj9pQqozjBpeIEAqDqEE6itRWMf8USvVVzSgKQ5dEpH9t?=
 =?us-ascii?Q?BnmenwtgyHhIHqzrsT0lBe5AC35Tl5A8fJCVeOTorxK3H79LH01TGsMUMVMn?=
 =?us-ascii?Q?LfCKBt3shWyfl5Ky+uesFMbwejoD4arzEBMPYQKGO7N2NbrCoDF+KAJ+3zqC?=
 =?us-ascii?Q?/ACBosZwdpYktcNrpSuCnTAAsgAkrgTfyvb/BLavqU9Qwb+TMqKDzd/ncCMm?=
 =?us-ascii?Q?9N/F4o6vgOuBJeY54VCNFcNFcrbe96kHSftQvMvYzHu1Qjuv2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 21:36:09.3480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0218f30-3968-442d-15f9-08dcf92ade5e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8577

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
index 384afa374d25..d8f8b0642a26 100644
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
@@ -482,7 +481,7 @@ int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
 		.entry_len = cmd->entry_len,
 		.entry_num = cmd->entry_num,
 	};
-	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_object *pt_obj;
 	u32 done_num = 0;
 	int rc;
 
@@ -496,17 +495,40 @@ int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
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
index 2610117cb39e..c47ad6502efc 100644
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


