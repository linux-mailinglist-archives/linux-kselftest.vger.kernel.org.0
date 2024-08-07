Return-Path: <linux-kselftest+bounces-14962-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EE894B102
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 22:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AE481C22046
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 20:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173D71509A5;
	Wed,  7 Aug 2024 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xt4PHJly"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8396149C6C;
	Wed,  7 Aug 2024 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723061502; cv=fail; b=hwGbhzeKou8IkZAR3V/WPUSwkdnUCkG4F5VtetMZRLV0tLIIUNKrlITXwHNraXmjyeLT984BUzfnG2hgCMvWjijWUvRLRImGOdqxcJZ4yZb7CoxAlMCFVtPGzXSARWIqrP9KSrluJ8gT2zqh8YEHkQlZ4cbaN6ORGv22Fxqzrz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723061502; c=relaxed/simple;
	bh=9gYRCj9CrYJj2z7K1ecqr3ygeRVjF5iafXK48cxVm9I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTGMOz5DSBOWXitWcLOPhhIjsdjygQC5bOtZbEKapon6tHa9dzDkVCOiui4Kq4tm9RwPOLxVScTD7H3iZ+7bpf4R3JPSG0vtO2nITsJPM/OPt6rMbAA6lDDrROHR3AKFKFMsk7qmlnZOq7jOOPkXU9JsbKrIs6/ogc/9/alEiq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xt4PHJly; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0FjQnA6bc3qKMZsr86msfbJ9SrFJlymKpcLen1Gk8HgwAfZMk6rbpZueNVo2r2QjANWjpC3qRiPlZub5Zmi72Zx3xlZQIN5MNxMLdxekOe9Kn3zdsp51uwa7P991nNfDC6Pt2ebwAHHML8xtoQ94fyrsz/cTtR6nldM4SMfhS44QSFCACAxm7m31MO4GHmwa/7a+qj5JchWw3gP44bCnUDeds8byFxg3DGohjV0NiUB9eRFV+DMNh/74OTQZfdFgi2nbeD9q/qBqD9RmD/yZvn5a1+j106SmIsdFQZis4FjIkOaAvuNZm0GPWZ7KY19YXZaYNo/GF1GNV5drD7KcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KV/Q6SMkExA2HoQBd7r5qaLfNJF1CD8r+wXPjbVzOZo=;
 b=ydZWePNZhcajbzmUXIRfE+etkYryUqKnwSczlcF6yVxaiRdXn440RS7jsnxt30WBOP1pBfprfgNEA+M4BM2pQK4pVlDvqEU+flOzk+BIQII/R59qJ5ym/Dm0v448UPxw8pKNKMnw783wQgPGtDkxRAyX+UyuxJ7Emgbky1wPCYETJJQgvHZKhm0SwA2BpCyJfeFXvIUe41mqgVyWnGbI8110G8NX8pbsg/NWNsywvlzZ1nmC9iIp8IYiLAxaVX3yfJ3yr8zLDhuOD1WC2ch3Qf/YyfkSZ2gj5o6cmGvdIz3Bp6JqK449lxGrIglDZUQQN5gaakfosCul6i62aGxdXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KV/Q6SMkExA2HoQBd7r5qaLfNJF1CD8r+wXPjbVzOZo=;
 b=Xt4PHJlydFkhjj4yKKumpHg9vJreHxqqAVRyAXv7xyqtmVnPIivhsPuIdMtSzYxjsgFjS8F+Ec/5gxGbs+PhmqtjpWEr0tyUqqsbZyA9zZIyi/ftiGssPuh2xA8ykyqapDOTNdy+LA6inUAYhF8HzAKb4Y3HWKrmZLb7IYNLhJEAQH4kS6lboNbMY7D1ymHOe/+4SuR1FzwosLUMxBvyi3OaLtw7XUj/k8i3+OVcugIWTJ97UfYGDwVC7FscpU5BKXhMlcp1J02GqaOVxt2/JwR+4o8fGNRX2e4xKIFbgmG3hP4Tg2YFdlzBmWtS4ypTCEeTO5Z6MYD3SHYATKfL7A==
Received: from BL0PR02CA0111.namprd02.prod.outlook.com (2603:10b6:208:35::16)
 by CY8PR12MB8268.namprd12.prod.outlook.com (2603:10b6:930:6c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Wed, 7 Aug
 2024 20:11:35 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:35:cafe::5b) by BL0PR02CA0111.outlook.office365.com
 (2603:10b6:208:35::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13 via Frontend
 Transport; Wed, 7 Aug 2024 20:11:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.2 via Frontend Transport; Wed, 7 Aug 2024 20:11:35 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 13:11:19 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 13:11:19 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 Aug 2024 13:11:18 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 10/16] iommufd/selftest: Add mock_viommu_invalidate_user op
Date: Wed, 7 Aug 2024 13:10:51 -0700
Message-ID: <3242ded32a55b4d5f95c06b9b2dfb6809a0b1b9c.1723061378.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|CY8PR12MB8268:EE_
X-MS-Office365-Filtering-Correlation-Id: 59e0e7a4-c3c7-4278-a6cf-08dcb71d2347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WGwbw+Hb6cssShANUFJqj38lGMjg90rXFUEnCWtlDSElHsfInygWfkD2p8eo?=
 =?us-ascii?Q?QFcdeEn/DOZpg9Uhtqb4yVGYwBRjW1uYY4d+Z6FmdJziiYlMmWS5Z+Jt00lC?=
 =?us-ascii?Q?qHJpVO8Ajf31/2vsFat1WQavIWAHVi+bVB4OqNZ4gTbQosvVl1OBFR6lyoqq?=
 =?us-ascii?Q?uwNMKajrRgaNT3t880VD+nA8ouhlfqsaLz5OI9TPTCBiZ2lP8k7CFzEreNwe?=
 =?us-ascii?Q?ADsdC74jZhQZIYIvyitixlwCZZ0EQwiaEj/7ntAvlPBWmnFmTgoS4q9LpzK4?=
 =?us-ascii?Q?HvtRJ+LsIkVxyvv08iMXGOsxVQNpd1ICsqI/HjeNFK9sozTPW7u9Z+xlujVU?=
 =?us-ascii?Q?vytczM1HavCPLlsRYIMrqkNIUY8M5UJtfJR/Hb8zXbl4Z8w9fasNs4AE+/t7?=
 =?us-ascii?Q?LC/LnNzct+mYEyPiDR6UXtn2QgDKq2y3Mi5yh1448A8wQzRYON140cUrrMsA?=
 =?us-ascii?Q?zxVTd80QbaSqvRuOZH8I8WIIPY+O0rznHXHq0msecOA2bUprtkDzy2IqxTkY?=
 =?us-ascii?Q?/94DV6X04mk7/uo5/aHp1bCuPMJb1j2hLzB0PpBU2oUzhIUikilJhBTXd/fx?=
 =?us-ascii?Q?TpfxkwFO13Yze49tdl5pestaOKMcLWCF7MBt8eoEG49BbZUzbNwflYTG8bry?=
 =?us-ascii?Q?anY3mhsKcHZkhT8q6KX+o2829kiJiCXbEkw0Ky59SfCPCLpikfB/qqxwpOLc?=
 =?us-ascii?Q?E8YnyNDGIRMwrzriWTC3iHtDspBT/qmvPcVK44r2zNzhxiumar78GvqYovdo?=
 =?us-ascii?Q?iNSTZM658aAqv+eiWrO8jIrZ2McQc2Cwkge+E36IcaSwlIejg/4toWJ1pvLW?=
 =?us-ascii?Q?ZPwGdLFBlg8wKpdr1CTZNionMYbFDcPZN1gn+NmKQITutmj6rIJe/85U1NqN?=
 =?us-ascii?Q?iJMJuIgsQJHru0DEuFehOFCFWdSF/k4CiTmm+n3jlmbyEzlnX0dn0hLwvbc8?=
 =?us-ascii?Q?LL59Kp95dLS4XTPzKs2MjSj2M27x0eSo6WFRaK9SJbY+kq2pz1JVTqsyq77V?=
 =?us-ascii?Q?vdS5aaVcjF+VxMXALJI7LSUhO086mpmszykV7p1fZ8Dnstd5+L5VCp45dYgG?=
 =?us-ascii?Q?45RgvjRdY7Sg0oz5fUTWHB+SJS3+sqPQpoV79XZFui9mrvM9Ug2xgRLKaFR/?=
 =?us-ascii?Q?rx/VAwhOZvVb71/hE/TyFVXOPBzWL4nd/p7HAAU5N0iigWJK39iwTIfeOW+L?=
 =?us-ascii?Q?y6eP6/oc1zXvhmv4WynasOO8z329pjcUc8ag3U+1OjBF7Ypn/J7FRmMHrv+u?=
 =?us-ascii?Q?KeH85h5/p8LrCJmFE6pqb7ZkMmFgE/d8Y0CFPfeVpj/FPnI2/0u7tiquzaeu?=
 =?us-ascii?Q?zsQOLTbNFCS0y8os7NfvS/tAcwBAjxCQaxwitDizsn/ynqD3GKjTS7/RULEx?=
 =?us-ascii?Q?94i1oKpqGV8AlOMykMjL3R26sUekHh+Wuieci3w9/FyNLu1jCTRmxolNu/Xr?=
 =?us-ascii?Q?jPmW/9xOQrGsLB8gEN86SLIzBUoK0TmT?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 20:11:35.1725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e0e7a4-c3c7-4278-a6cf-08dcb71d2347
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8268

Similar to the coverage of cache_invalidate_user for iotlb invalidation,
add a device cache and an invalidation op to test IOMMU_VIOMMU_INVALIDATE
ioctl.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h | 25 +++++++++++
 drivers/iommu/iommufd/selftest.c     | 63 +++++++++++++++++++++++++++-
 2 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 0bb30275a92f..da824b58927f 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -55,6 +55,11 @@ enum {
 	MOCK_NESTED_DOMAIN_IOTLB_NUM = 4,
 };
 
+enum {
+	MOCK_DEV_CACHE_ID_MAX = 3,
+	MOCK_DEV_CACHE_NUM = 4,
+};
+
 struct iommu_test_cmd {
 	__u32 size;
 	__u32 op;
@@ -156,6 +161,7 @@ struct iommu_test_hw_info {
 /* Should not be equal to any defined value in enum iommu_hwpt_data_type */
 #define IOMMU_HWPT_DATA_SELFTEST 0xdead
 #define IOMMU_TEST_IOTLB_DEFAULT 0xbadbeef
+#define IOMMU_TEST_DEV_CACHE_DEFAULT 0xbaddad
 
 /**
  * struct iommu_hwpt_selftest
@@ -184,4 +190,23 @@ struct iommu_hwpt_invalidate_selftest {
 	__u32 iotlb_id;
 };
 
+/* Should not be equal to any defined value in enum iommu_viommu_invalidate_data_type */
+#define IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST 0xdeadbeef
+#define IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST_INVALID 0xdadbeef
+
+/**
+ * struct iommu_viommu_invalidate_selftest - Invalidation data for Mock VIOMMU
+ *                                        (IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST)
+ * @flags: Invalidate flags
+ * @cache_id: Invalidate cache entry index
+ *
+ * If IOMMU_TEST_INVALIDATE_ALL is set in @flags, @cache_id will be ignored
+ */
+struct iommu_viommu_invalidate_selftest {
+#define IOMMU_TEST_INVALIDATE_FLAG_ALL	(1 << 0)
+	__u32 flags;
+	__u32 vdev_id;
+	__u32 cache_id;
+};
+
 #endif
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index a165b162c88f..4858c74c67be 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -141,6 +141,7 @@ struct mock_dev {
 	struct device dev;
 	unsigned long flags;
 	int id;
+	u32 cache[MOCK_DEV_CACHE_NUM];
 };
 
 struct selftest_obj {
@@ -560,6 +561,61 @@ static void mock_dev_get_resv_regions(struct device *dev,
 	iommu_dma_get_resv_regions(dev, head);
 }
 
+static int mock_viommu_cache_invalidate(struct iommufd_viommu *viommu,
+					struct iommu_user_data_array *array)
+{
+	struct iommu_viommu_invalidate_selftest inv;
+	u32 processed = 0;
+	int i = 0, j;
+	int rc = 0;
+
+	if (array->type != IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	for ( ; i < array->entry_num; i++) {
+		struct mock_dev *mdev;
+		struct device *dev;
+
+		rc = iommu_copy_struct_from_user_array(&inv, array,
+			IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST, i, cache_id);
+		if (rc)
+			break;
+
+		if (inv.flags & ~IOMMU_TEST_INVALIDATE_FLAG_ALL) {
+			rc = -EOPNOTSUPP;
+			break;
+		}
+
+		if (inv.cache_id > MOCK_DEV_CACHE_ID_MAX) {
+			rc = -EINVAL;
+			break;
+		}
+
+		dev = iommufd_viommu_find_device(viommu, inv.vdev_id);
+		if (!dev) {
+			rc = -EINVAL;
+			break;
+		}
+		mdev = container_of(dev, struct mock_dev, dev);
+
+		if (inv.flags & IOMMU_TEST_INVALIDATE_FLAG_ALL) {
+			/* Invalidate all cache entries and ignore cache_id */
+			for (j = 0; j < MOCK_DEV_CACHE_NUM; j++)
+				mdev->cache[j] = 0;
+		} else {
+			mdev->cache[inv.cache_id] = 0;
+		}
+
+		processed++;
+	}
+
+out:
+	array->entry_num = processed;
+	return rc;
+}
+
 static const struct iommu_ops mock_ops = {
 	/*
 	 * IOMMU_DOMAIN_BLOCKED cannot be returned from def_domain_type()
@@ -587,6 +643,9 @@ static const struct iommu_ops mock_ops = {
 			.map_pages = mock_domain_map_pages,
 			.unmap_pages = mock_domain_unmap_pages,
 			.iova_to_phys = mock_domain_iova_to_phys,
+			.default_viommu_ops = &(struct iommufd_viommu_ops){
+				.cache_invalidate = mock_viommu_cache_invalidate,
+			},
 		},
 };
 
@@ -722,7 +781,7 @@ static void mock_dev_release(struct device *dev)
 static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 {
 	struct mock_dev *mdev;
-	int rc;
+	int rc, i;
 
 	if (dev_flags &
 	    ~(MOCK_FLAGS_DEVICE_NO_DIRTY | MOCK_FLAGS_DEVICE_HUGE_IOVA))
@@ -737,6 +796,8 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 	mdev->flags = dev_flags;
 	mdev->dev.release = mock_dev_release;
 	mdev->dev.bus = &iommufd_mock_bus_type.bus;
+	for (i = 0; i < MOCK_DEV_CACHE_NUM; i++)
+		mdev->cache[i] = IOMMU_TEST_DEV_CACHE_DEFAULT;
 
 	rc = ida_alloc(&mock_dev_ida, GFP_KERNEL);
 	if (rc < 0)
-- 
2.43.0


