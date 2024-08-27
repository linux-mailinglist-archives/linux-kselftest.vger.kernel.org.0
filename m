Return-Path: <linux-kselftest+bounces-16429-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 665639614E3
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89AA81C22596
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D861D27BA;
	Tue, 27 Aug 2024 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LhYZKu/F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3941D279A;
	Tue, 27 Aug 2024 17:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778121; cv=fail; b=VeveZ55S98382+lYQVPe2OYYee9f5SdhvyZlBd8HfJPXJcX7i2Ii8y2lHoh0xNu3x/TLHg/8eUZreDB1yhOBVVRgDSnLsDgusxicFQeRMI5BMfvk58a+iZzM0RdzmUYUfIvnx6pnAbK+BzF2FxsxERk8fNitl9UD9NT0E3CZrNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778121; c=relaxed/simple;
	bh=kobA1afTYmDPHJS9m1k0dinkRlUtTqL8Of0S2cpkGYA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kHHnqmDRsAy67g9TOD/TLcvt7JGVt5mTD7Ct0a1jcylVq/LR2EnivPNChujCgHLEQAcyNVmissN2MMCYmq95ee4NW/Oxr3ZCPvzO/D6KDG6jsMmcQ9MGtrlzelrAoxqsaI9gsO6LpLV4A+Fytp3bLp0Tcp/p7n+/CFMmpE+J4Jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LhYZKu/F; arc=fail smtp.client-ip=40.107.93.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qcw6aNYIweJAGQwGtMzVeGm1//wMkW148/yQUAoUJGQKJ/FSSAAOiTs364wHyz4nD2K8o0xiS92xc0AXqQ3+KyWQDDNDDUX1Q8eERXlb9G8k8I27t50LforEPuBgJm1PGBujb1+9qlmi1MEU5EpUGxDIt/tz8gZ+rixhoz/pMPr9b4YUD3TZ0ksPlzoTUT+MH0Z1hqvWfGMyByvFM4OaXB8d68Up8kXkBhkDCMgWlqjLq6u+UMAZm7/qf2YZFUBJ4uiX9Bi0KysYzxFPpbZ/4iel9b7Y1horiB9nNwFBr3HcPfjKtiKDutEv9eyRSXdU69QEP3ZMhcLSHKgDRUDYOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/DAxjipE88O0r3lbewOow/hSZcf92YrldrW2X4I9q4=;
 b=iP5de6z7PkR3S03pKCNi5Txvs9Z3Qr7+RDGMb1xJuhgxwBR80r2V/Q5VHfL7yjdfd4U20SW7kHO/k0NLdGitaQNh0XZeGEYsx0tyfoDzVNHLegoqHuYamMJTg/kAM8QVp8fP1PPnSQdnVDbIOfnuSSE8IR/0uKfjplY3YVgdkMtw6BYWljrHma4uxmR06MIBOaxQogoEScpkLKc3J1noJ3SE1Yo8ShT8bQJ63d4xtxxE9mr4awme0+PyZWpgD8s2NfPbfc7kgmDQFTubkxdZReU5SNJGfx1JCQP9sSypVaF8GKhqY5ZKPHzaN0GzzaPyd7kQJSsdT5D+Fbf59jf/NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/DAxjipE88O0r3lbewOow/hSZcf92YrldrW2X4I9q4=;
 b=LhYZKu/Fk1sXEuFeHHbmTbThakx7OH2lCqH5+tRrFY/RhtALtruuKRolhX7z0b2brp3vcciI/VgLNK6OC98tS/X1+q/gIaMwp/0B59xW1yQ/kAmwrujc/jmvYqLGy768jT8HLrhfwVbaw0csUx3SerySHMLYicCKXqlRY2p4nWQBkzGN5h3heszuE1HaFNhPBuYvSrvHZM6gAe2Aj3WUCVg+/8moU7b+w0jFYu8wkPYbJ6Cz30/+mMAqAM9ugy4bJwesDAa5PpR78scE8VQgXYISbkPAMcfmMB6tGPtikfssoPgAzYjxJbIPJPSPdTF2s6CsPGcq2DYlIPZTS9uvvQ==
Received: from DS7P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::14) by
 SJ2PR12MB8782.namprd12.prod.outlook.com (2603:10b6:a03:4d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 17:01:54 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:8:1ca:cafe::b2) by DS7P220CA0007.outlook.office365.com
 (2603:10b6:8:1ca::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26 via Frontend
 Transport; Tue, 27 Aug 2024 17:01:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Tue, 27 Aug 2024 17:01:54 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:01:41 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 Aug 2024 10:01:40 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 10:01:39 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: [PATCH v2 08/19] iommufd/viommu: Add cache_invalidate for IOMMU_VIOMMU_TYPE_DEFAULT
Date: Tue, 27 Aug 2024 09:59:45 -0700
Message-ID: <224732696abf91f220585bb26fa44314d7d2f425.1724776335.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|SJ2PR12MB8782:EE_
X-MS-Office365-Filtering-Correlation-Id: 553db148-648f-481e-df99-08dcc6b9f3e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5aRPw60qprdi3u8yowL/w4zz7BkBuAErqxrqKIcF55b6MfSamP4r+4ek/bAH?=
 =?us-ascii?Q?LVbhpvMjfg9n1T3Ud9jF7q0zamtmMz50dQXDiJVaFR2uPorFZke+dIuLfyhN?=
 =?us-ascii?Q?wDC8fxI+utafgf2qOqOYICLI5hcn2c+najR7ecKLD3erchi72MDS8eEdhZDC?=
 =?us-ascii?Q?QMkzL2lI3UE8OsYjmkO+HUM1pJhd08UoetGYS+WhgIpegn7tuePKLruphzDG?=
 =?us-ascii?Q?G//LG+sVXdJOSMxEGSuVTq+vOSDWqYoNg+tYiDseAud8BKf7Fe6VIKghNuUh?=
 =?us-ascii?Q?gztkBr6atqVYCjndAXQV/Nt/H5SAUrcxuaxXmFR5xKuaLQMhRNL2qvZOXTqs?=
 =?us-ascii?Q?HtDo4VM2dWATENpU+6iRQUQ+ytbOm2gcgcsDX1NzPH18pN7tJ2xikihQ5PsM?=
 =?us-ascii?Q?7FZPXJsleLjXY5eqs42QxQ2kjfwa0kyR6lWwdR7NgH2JqZjZP0reawc31y+R?=
 =?us-ascii?Q?rNq09jiIUmyfZLz9LcVrzprFJuqjmOAUHH3wvpX7Q8lp2zhbBsqLPTAhlzeG?=
 =?us-ascii?Q?gGDp9bDMZOGpoF36i3z0B83M73ZvqTEJLvJZKtUSifnZLoOlQp3bjZCaWFdL?=
 =?us-ascii?Q?SL75zfU1b4acXOfScmkMSdc1cZO1+xO0roDSMdFoP5hDos1PcjBJaVMXXiTe?=
 =?us-ascii?Q?BhXLEHfpWUCh7M/wdEleztdnbXp3c0i4n7L+I4UfgOGSj7Z0VY0IM0OvPV45?=
 =?us-ascii?Q?/gs7qHRU7UJnvzMmZmxAZM4uRZM0gHU8JmKWhdCdBEhSiTZ/0wcjkRecefIy?=
 =?us-ascii?Q?vDyrZ/DLhS4gbsVwweSUtnmdB+DHj1fbHGwk1oR1uc180EMFbDzvJGcLMQ/x?=
 =?us-ascii?Q?Vw8Nhw/9Bewcd97bnw+3oU94bc3cDaAJghMPPdHXY/1RCk+9pEAoZFb3mhHZ?=
 =?us-ascii?Q?grC87jawRRYwJsAgKYKm99tAmoa50imBo5L16NJhUTKc5zPQogJUTyGMUS3Z?=
 =?us-ascii?Q?pNViYr7T1iBUX0W3Fa3k62hi0ZhfZjAaQ7zr/gPt2FQacC8q+qr0Trv778UO?=
 =?us-ascii?Q?8mlJYbkO43EVS3PZxO4NPiuMN6dP30xKO7U9oqpqr3CyfPCzmtREUj/TW9NR?=
 =?us-ascii?Q?RKgKRPXN3PaRq+Uxskz+MihADPaoTz7jA+qle+XFHM15ka5lyX9zKjKaF4Qm?=
 =?us-ascii?Q?hAYjqq0LR/bsanQVHee259ee0qRiOVYBuElbeyvtFK4dAEPnCIPvptDx5pyM?=
 =?us-ascii?Q?0s+pBjfBwavGrKkfiGb1rqr+urQMxJaYZCOYpRuvt8QeEO8L65af2CQf7Mpz?=
 =?us-ascii?Q?fHY1Hl9x8l03dAok6jKRS86R3NgfcH4w0mIQs3z/6AFrAHWivQFdy8FMQ8lB?=
 =?us-ascii?Q?b0CUdW3C0x1v/oeDyi8Zag4weQ+WTOZoB67eZxKcM2vDqDesr58oSlRuhTLr?=
 =?us-ascii?Q?YSvkyEPV4EGNVEE/0pqWeqYytOyZV4blWuyHT9skJZb7bCbEAjlBl/wxlwVi?=
 =?us-ascii?Q?WC9FQ7TM6sPCwJxAnYRGAf8aWkwd80po?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:01:54.2320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 553db148-648f-481e-df99-08dcc6b9f3e5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8782

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
 drivers/iommu/iommufd/iommufd_private.h |  3 +++
 drivers/iommu/iommufd/viommu.c          |  3 +++
 include/linux/iommu.h                   |  5 +++++
 include/linux/iommufd.h                 | 19 +++++++++++++++++++
 4 files changed, 30 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 2c6e168c5300..7831b0ca6528 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -5,6 +5,7 @@
 #define __IOMMUFD_PRIVATE_H
 
 #include <linux/iommu.h>
+#include <linux/iommufd.h>
 #include <linux/iova_bitmap.h>
 #include <linux/refcount.h>
 #include <linux/rwsem.h>
@@ -538,6 +539,8 @@ struct iommufd_viommu {
 	struct rw_semaphore vdev_ids_rwsem;
 	struct xarray vdev_ids;
 
+	const struct iommufd_viommu_ops *ops;
+
 	unsigned int type;
 };
 
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 8ffcd72b16b8..a4ba8bff4a26 100644
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
 
 	xa_init(&viommu->vdev_ids);
 	init_rwsem(&viommu->vdev_ids_rwsem);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index f62aad8a9e75..8c1034cc3f7e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -43,6 +43,7 @@ struct iommu_sva;
 struct iommu_dma_cookie;
 struct iommu_fault_param;
 struct iommufd_viommu;
+struct iommufd_viommu_ops;
 
 #define IOMMU_FAULT_PERM_READ	(1 << 0) /* read */
 #define IOMMU_FAULT_PERM_WRITE	(1 << 1) /* write */
@@ -633,6 +634,8 @@ struct iommu_ops {
  *                         array->entry_num to report the number of handled
  *                         invalidation requests. The driver data structure
  *                         must be defined in include/uapi/linux/iommufd.h
+ * @default_viommu_ops: Driver can choose to use a default core-allocated core-
+ *                      managed viommu object by providing a default viommu ops.
  * @iova_to_phys: translate iova to physical address
  * @enforce_cache_coherency: Prevent any kind of DMA from bypassing IOMMU_CACHE,
  *                           including no-snoop TLPs on PCIe or other platform
@@ -665,6 +668,8 @@ struct iommu_domain_ops {
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain,
 				    dma_addr_t iova);
 
+	const struct iommufd_viommu_ops *default_viommu_ops;
+
 	bool (*enforce_cache_coherency)(struct iommu_domain *domain);
 	int (*set_pgtable_quirks)(struct iommu_domain *domain,
 				  unsigned long quirks);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 30f832a60ccb..85291b346348 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -13,9 +13,11 @@
 struct device;
 struct file;
 struct iommu_group;
+struct iommu_user_data_array;
 struct iommufd_access;
 struct iommufd_ctx;
 struct iommufd_device;
+struct iommufd_viommu;
 struct page;
 
 struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
@@ -54,6 +56,23 @@ void iommufd_access_detach(struct iommufd_access *access);
 
 void iommufd_ctx_get(struct iommufd_ctx *ictx);
 
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
+
 #if IS_ENABLED(CONFIG_IOMMUFD)
 struct iommufd_ctx *iommufd_ctx_from_file(struct file *file);
 struct iommufd_ctx *iommufd_ctx_from_fd(int fd);
-- 
2.43.0


