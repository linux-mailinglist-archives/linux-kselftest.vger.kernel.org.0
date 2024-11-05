Return-Path: <linux-kselftest+bounces-21489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078359BD6B3
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 21:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE9B283F58
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 20:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAAC217449;
	Tue,  5 Nov 2024 20:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U4KaPdA2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4501F217454;
	Tue,  5 Nov 2024 20:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837164; cv=fail; b=Ty8v/oA8CvYmgxLugks1pPdGJLIeeoMfQiZcc0XB1Y9JfjIRxnvYpl+cqIpvkdso04v5x0qmBr6SaXf95Mg5Od5a5JWZRr/P/UILCPFJBTO7+fK5pkNDNUWmNCcpapxBZUdu3YdHnGO0VbWflxNFbjpkV51xSaA0rsK6UiqUQAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837164; c=relaxed/simple;
	bh=qH442Fpj7VLKwn7HZkppFh4eNxOKp25jSWmRyn+dYAM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPh/Wu0x6wXDdU5xLLYZzWKFmwSoqoSj3Y4wiTiOjGKlDkB98Y03HGnBWTHz7qrEYr1/VSDA3VyZO3rQZySgf4EweI35Wl7LkQjjERWw9eO6zOSvFqNW0KFH1utA3p20mWTLiBzrWYpEGrjJhAdLyvyVUcW20FGJ2sS3aisKGqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U4KaPdA2; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wwdfUc+ZMMrFeIzcIK862STf0vzOqMiJKwtQz0jtvEIr9Q8R/aW1WZUAB9eN/rKmk0zpyPHXDBa7Lu0R0IUH7kqtqtidQZkDws3JWY4KQ6bAj3KynqgdO6AekUWr1lyTRwFqzL1dzx1U9hQ1iza6UT2yUUISheoClSv/7OUBYNKDfGPJZrASqvVIlboPkLsgusB2zWmlT9oe5g6/xuaoIfQKBnTNe1JNzRCha3coTkQVWecgHxogFnzx46Bt8M65fqcqVbXd23V2QNwp+3JRs5DC0reO/drYXXXR8ZCB+F3ChVpeM52bScbyDlAAXCumAMrrJ2lWGyPxsYdLMIVccA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZaUCIMitHuPzF3KdR+88QWSNUCVdOJm8LCVmIem9Ho=;
 b=bqmMZmjnEkF/aBEBtMyr9rM4I+oje/1BSfe5abTQ5XxpU197bodWS5KPV/qdWgLCgxYicLDeDeU6Bap/t/y7GykGVf+LGX4GaeG18s8EPe8y05XFMfycZfzE+n1LmRuZfFbXJrdKkcdM2Se/3q1iJH+xSOoj2EnN6Knt81WSBnnYMZ2xbGnkakrngtn/kDIg3+jJfE9V1RIkWvPyNmMzT6yK0mrlV5ImPBJWe6BQtyNjBRteJCnlCg/EXBswuGim3t/pbd3SXq7cNamDlO0ErsZi4ahggFRMRoSgdfU7Gw+bvRgh25FwJmOGs4zY9EVZEA2HZUd985XlcPkgPbTiAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZaUCIMitHuPzF3KdR+88QWSNUCVdOJm8LCVmIem9Ho=;
 b=U4KaPdA2Y9Dcl1ewo4mW2lyqlwqntZAX2rdy3MPG6cOnlBCRtlHvFcELi4Q6sUf8/3H0ICF8eg+tvI2ohRJnPdPBKaKKnIRwQ0UHPgjET/uyGM1LCqCzSBUgLsL2NtIxhR/9+V1CEPZdfXmiFCFWvmHwceHN1T+E1wU13ASjsmbvy0vha3Fq7PTruse4HWfPtrMzA0kTfQVi449VFRaRRoiV+UQfb6hkYjixGcVAUAx3VmSlGlst3rzEGiEreKeUQOPr/jN6wXJnONVLX5gXwQxXC6mH51H4Yw188UnfzU4rzo4h2V8qIOkYQl7Vhy9/YWkSwqTacbA31REt/E5INw==
Received: from BLAPR05CA0016.namprd05.prod.outlook.com (2603:10b6:208:36e::22)
 by CYYPR12MB8990.namprd12.prod.outlook.com (2603:10b6:930:ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 20:05:59 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::99) by BLAPR05CA0016.outlook.office365.com
 (2603:10b6:208:36e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.17 via Frontend
 Transport; Tue, 5 Nov 2024 20:05:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:05:59 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:05:37 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:05:37 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 5 Nov 2024 12:05:36 -0800
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
Subject: [PATCH v7 06/10] iommufd/viommu: Add iommufd_viommu_find_dev helper
Date: Tue, 5 Nov 2024 12:05:14 -0800
Message-ID: <84fa7c624db4d4508067ccfdf42059533950180a.1730836308.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|CYYPR12MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: 28eb027e-1006-49cc-3cdb-08dcfdd5446e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HcznK8xTclZHm9MExgI9aLbvUo9Ew1kfLer89l/RukrH6mMEUhwdvvzfb9hR?=
 =?us-ascii?Q?rnhRJklZdpkmmClsJ4qld++jKVVgeu+s4KXhabeFjQBSJ9d/omvO6taFIko+?=
 =?us-ascii?Q?7jURCg3BoefD8jOeSR9Wx36VadI8QmEnaqTvLkqUFJnqaDo4ERHApvsg0+GT?=
 =?us-ascii?Q?xvbohK4iBgPfOy2M7WfGT2uDngn8T7Br+mEj5FW41xjUQaUHRDk+5Umyb7qw?=
 =?us-ascii?Q?Jmbd7Za9pLMbuZKI7snygS1zwQGvXvW1JvlzxHElr80cnL+b/9IbI56XUItQ?=
 =?us-ascii?Q?/m8OeZP5k4EzFKWrvc1e5sEJdnzdjSOsX3AE3WwoFoMKheFBm1Pl1xhkEhvy?=
 =?us-ascii?Q?UbAip7AEkRxh8teKizmPBqGkQDY3uenqfA/RbLT4ay+s14FcSCsZNRcch5Rz?=
 =?us-ascii?Q?1y9Hf5p3CfpqBXdjj4ziWOUAENwPW/Uki0ppKRn7edZzSujtbxsGwRpndZ7M?=
 =?us-ascii?Q?eERMq+uhntkMPC/qvuhqjXe4tghlp3eYWECj9A/gcMOLR3qs0ulxFXkztqif?=
 =?us-ascii?Q?f4L4hj+MtlZERzDXVmRqDNAjDAQI/WTMm9oo6StuZ5NiOpme+FJ/adibrNOm?=
 =?us-ascii?Q?urfPVi+3yXTrexTTyaxt5mlPg4iYh6w+RMfWOf9hjt2+7LpuiCo/zbkEtBPf?=
 =?us-ascii?Q?tC0nB4jSyz0Z1Ja3+3YgCE5Po80ItB7W+hhx1wG48yIYkiGGQqvHnOuB6Ph/?=
 =?us-ascii?Q?RPGJkc5SvvMWouRe1eZsECb4VFpH+OCviSX+C+Tw0pcV0rzE1HYG3f0tmoGK?=
 =?us-ascii?Q?aNwvVHQPehN6lQuVyEpxzJryt+iCShoiTFxMhPGdJEGsXSDj7fQiJEoDfTFJ?=
 =?us-ascii?Q?7o/YFSNCuuMbzz3cUNWYnGepKT9t/sH6e7nGlrqO+LjyOSvYFX2itmayb2RK?=
 =?us-ascii?Q?Jz+56tnhBdryI8ce7L2zFaCWl/47bUE6NGBae9jnkR5I19gPiaPdRGQG86wM?=
 =?us-ascii?Q?3G8vRMWt4GrOL1EYJH6Vuz05lX8Zik2sKVu0bGv3dA8t/qqAUi5vW/H9y25b?=
 =?us-ascii?Q?0U5K5FQx/AbKcAeZDfzhKeudZjcfcGCXlzAekgTcffVrJBmPxJOPc5l5kA0+?=
 =?us-ascii?Q?h0sUGW+647DgaSGq3R5LjWpaS2KYdNLM63Nw+kCmJYfnmrG8UDqrjku7VDkB?=
 =?us-ascii?Q?3qeTnwjb7CgIKw+zG/0FxuhNBsqhQE/F90scRxi8jgf2VNMmcG41SWyHPKU1?=
 =?us-ascii?Q?w97qp/KpMX/7LaLl+WpOeGMearldh+iiWI6MJgIK2yXFZ/EK1cxuWhI1yV9v?=
 =?us-ascii?Q?oLTVDEw7xg7ZbTUqU1hCydpXPFAu0XXMlq90AfsV0CaRj6eaKsl4x37XBEX+?=
 =?us-ascii?Q?h/cGmV/Ae+Qxgfupn2dwguZ7w2h+K0cKLQUrCjhU7LAOH9rInMs6LdgJyGMP?=
 =?us-ascii?Q?SVAUHPmOtGF5LB/ZhdzUzml0WWHKETk5i9ybBF1+iHrhUBlcYQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:05:59.5673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28eb027e-1006-49cc-3cdb-08dcfdd5446e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8990

This avoids a bigger trouble of exposing struct iommufd_device and struct
iommufd_vdevice in the public header.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h        |  8 ++++++++
 drivers/iommu/iommufd/driver.c | 13 +++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 2bc735ff9511..11110c749200 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -185,6 +185,8 @@ static inline int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx)
 struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 					     size_t size,
 					     enum iommufd_object_type type);
+struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
+				       unsigned long vdev_id);
 #else /* !CONFIG_IOMMUFD_DRIVER_CORE */
 static inline struct iommufd_object *
 _iommufd_object_alloc(struct iommufd_ctx *ictx, size_t size,
@@ -192,6 +194,12 @@ _iommufd_object_alloc(struct iommufd_ctx *ictx, size_t size,
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
+
+static inline struct device *
+iommufd_viommu_find_dev(struct iommufd_viommu *viommu, unsigned long vdev_id)
+{
+	return NULL;
+}
 #endif /* CONFIG_IOMMUFD_DRIVER_CORE */
 
 /*
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 2bc47d92a0ab..7b67fdf44134 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -36,5 +36,18 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 }
 EXPORT_SYMBOL_NS_GPL(_iommufd_object_alloc, IOMMUFD);
 
+/* Caller should xa_lock(&viommu->vdevs) to protect the return value */
+struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
+				       unsigned long vdev_id)
+{
+	struct iommufd_vdevice *vdev;
+
+	lockdep_assert_held(&viommu->vdevs.xa_lock);
+
+	vdev = xa_load(&viommu->vdevs, vdev_id);
+	return vdev ? vdev->dev : NULL;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_viommu_find_dev, IOMMUFD);
+
 MODULE_DESCRIPTION("iommufd code shared with builtin modules");
 MODULE_LICENSE("GPL");
-- 
2.43.0


