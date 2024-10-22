Return-Path: <linux-kselftest+bounces-20356-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1B59A94D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 02:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C669A1F221B9
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 00:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54DC1FF7C9;
	Tue, 22 Oct 2024 00:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TSCK94s6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60191FF7AA;
	Tue, 22 Oct 2024 00:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556465; cv=fail; b=iKN9fLwrz3C49nq0R8Y0+ZL8EeX8Ln2IWDlUwRmz0Mb6EX7EyjTsgfu96T8AyXF31UjO/kXCk0/oDHLAhV2QgXWwz6MD6FXDo7z9pVr0Ro1UtgU718xrUzvA36oShRwF2b1LZbJjtbORo6WeuUZuo8mWAR3Q+GkUAgDuQ8ekdD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556465; c=relaxed/simple;
	bh=j8mUcufDMAGvEjiOnONdYz7K9wqvEc2nwig7K5AoPOY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IP3A8epW4mG0x3x5T1swjP3GLj8snuc0gZfbtwuX5Uk1ssbwSXdkLlKdI5Pn/QEFczlu223VEwQZ7Bhc6Yz7PduVa5mbYlMGBIJM/WuiGtskdEOEFF5+zriPKH1lATjs66+zdWUgd1IdOc48oJslbI5vdEe6qxvJhrDhXzARVBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TSCK94s6; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/qTESu7iQH/UqfNaQU8Gc7AecgKh8puZ0+5G+RJOi0OxBOcRBExuTwThmAuXyeH8hQ1lMATqlLdm8oxiy/Wry1QoMQK/n4uKhDwxGPWDz5MTyBgfbRm4Jito5C4MLfuh//CoStgmBjRE+Rh/aI59Wc4kL6K60qJc0u1P895IP4odNm6Hkbt9Ks3tCK28VZwd3I/ViQWDpGP9D6j30J/Bk6gl2ZvWDYYmA/0ShN8sB/s905weYctKaRStRIu7GK5F/TEuh6xU6GR3CoFr0BaNQ/tI/h3a8/IrvGoigO9iepceYNs+az/v1nvLYgz5DM7xzDcgq58aYZJYsjRAiU/yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JElYh/Nh0IGKVHBiwRRxcTw3OB5K3UWJI3xV77tXG/M=;
 b=l5sg8AMdYQ9TkrdIvznPvQ1nQb5n7GVAId9A6XL6kxXS+Q1Sfk9GUvtNgKMvgppZPEWoheitnmOSxoBbJv+1pa1atLTllbntgHKtBZOp9g3d/4eef11yHEo9T1UgzHaYOMfZSrbGXN0uC5s56Sle3PYHGm4z0iKwF6vI93BprXH/2SQ5zlOK2ZGq1KOHD8jJCXxmvgkI7XP8TsDwe8GyK2vdLspVYscXDVv4S/PTQyWsMIuxCSd/rC/Jq+nQtfQ1N5I8jMo4eDatSmT9j5WbeejdKGH/r4eGkwCP5upQdjSpDynZhrf2+hAfNySDM91ifMUagg2bhvRMIFylWuU+7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JElYh/Nh0IGKVHBiwRRxcTw3OB5K3UWJI3xV77tXG/M=;
 b=TSCK94s6/B10iR+R+DwNBQ2PtUrWwYQM2XJmfizdZ90Y+Fc7SN7wDnW95eSn5fkdpRbv1wLFVFMPb6gSjdScl0bWGYqK0AYZEawEv4U4bZgNrGhodT80qNUwEjfe6Y/X5nOMe3X7pCSrPt0Q+nVnAKXobm/Ecq6XTH8L3CIamN+WqfH3soFhrEVz0OV21ho/EwmUcG3MJBLV84/665pCDOy+jYzxhuhOP9FKU8m0VyorOdtS2rGyBz4PzY5AlT90ttvp5+9ZT6S7IlsCfTO1VNpL9zvSd8iugHHMgFBgnhgKjh3rt9m74BkoYRW4w1xA5F4UR5WhwVd295v1ejOy0w==
Received: from BL1P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::28)
 by DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 00:20:57 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::17) by BL1P222CA0023.outlook.office365.com
 (2603:10b6:208:2c7::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 00:20:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 00:20:57 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:40 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:40 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 17:20:39 -0700
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
Subject: [PATCH v4 09/14] iommufd/selftest: Add mock_viommu_cache_invalidate
Date: Mon, 21 Oct 2024 17:20:18 -0700
Message-ID: <9d0762fc3b50d5010768b93e6999f013c78eb224.1729555967.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729555967.git.nicolinc@nvidia.com>
References: <cover.1729555967.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|DM6PR12MB4123:EE_
X-MS-Office365-Filtering-Correlation-Id: dc080f27-a300-455f-0922-08dcf22f6641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YBL27bcNUd3cNC1N5yj86/Fv24zUoDFwKCzo4E4d9r9HQxIsjxXI/d3FAA4j?=
 =?us-ascii?Q?DFC94HDeMK3FPVc1clUS1AM2PN2wSSRXqqaocC/ZY6vUk8TFtdi4mR4+kMSH?=
 =?us-ascii?Q?sAX2TSyyPkVlfXUGTlXTXjs0GKLF9bxes7vjo8bzNWXnFQoT3LI1Z1Yaeo2M?=
 =?us-ascii?Q?jC1FY7+IBSs4PNhgPPviuwpF78PsxzErrmC9cPaUYZ2DpUpzSk5f63asOVlt?=
 =?us-ascii?Q?eoXPI5nnSHkIOzXfE5SVxTGC3y6c3yYWsqVBTDQk2RklTRXujN0v1j/Z+dLv?=
 =?us-ascii?Q?UyuugGSs0kLE69kl4xR3vMuKP1iTKYAT+IsQ3b84TeNQhk0QWw44l6CKXyiA?=
 =?us-ascii?Q?l4rxokxG6SP5/7dL6rnNhvdTjASjtktQa/SuEgv9uoLCM75OziDWbZxUh634?=
 =?us-ascii?Q?CcUyhFfhek/sJ0yDmZTiov132/WFBeUKhRKmw3K0XVNnVFsD01JmIyHbKJU1?=
 =?us-ascii?Q?y9ihaRJcguGmjsnzvEwj5gyp/TFeS4/lEUX9QYcflqZGwHUS47nEHJuaqihN?=
 =?us-ascii?Q?1uAqaGS6DnzkFbXZl+sRWXzSCfsJfv48jqPFEoPODpwv2XItcSW1Zwpi/MrO?=
 =?us-ascii?Q?AFGup4gXMuEwPUOQOcCbcxlJ8bAEzp/k48KUU4REbJ6fJlHdfDMTYfF784d1?=
 =?us-ascii?Q?d8OaIA95SajgI+ADA6kV2MRAm7TWlyMkrh7dJ4XGF371XpWf699imiZNAAb1?=
 =?us-ascii?Q?V+2mVPuaEgZjbyDD4VjwYjgU3UGA2G1uUVGdc3p8q/0IbEPnRnbFhHbJ1RL8?=
 =?us-ascii?Q?q06fSqCa0+ju+pkjiVgwentSX14S5EjoCZJIsTldLhW/itNXB8Gt3RDGlHXE?=
 =?us-ascii?Q?k0tk95vsKyj0Iz1+yovK4Xtlj06x91rEF55kWo0675Ge24xZIBcyqUyYUjrC?=
 =?us-ascii?Q?3uQ66Bo8VkuPYwcICtjYf9ftTl5MeZsJatZwipoAMvTJ5awQyMuORE8NpVGS?=
 =?us-ascii?Q?9ddSvQGEmYE1mN/O6+NTCz+LzL9CfU3+L8bV2XkIGxjRbnqmidqKP2aqJW2/?=
 =?us-ascii?Q?mgXpfBzQVD9h0wYgoysRqLkvBjRmBLk3lk25LYUnRbgvBD1An4ek6xvCHVW6?=
 =?us-ascii?Q?jNqO+iHq+LEueu+JWsDw2pHXeTZLCIHHCaPbrHicuSfj8yG0lXzzNuB5D50m?=
 =?us-ascii?Q?7beofpFtrmgH3gzHH5sieM1id1OlgMvu7qgr46ByxRvIB5t8HngSmboZspDC?=
 =?us-ascii?Q?HsbaLjKJjiQRtgTj/F6JM5Ri0rfTW9PQa3yxSi1RjJQ1B2AEvXvMujdRXFpd?=
 =?us-ascii?Q?pNGczP+/dig35mW405dzqjw0CL7xRiwQdxZyVGAs3aaGtAQP0vo+BXvQqNXg?=
 =?us-ascii?Q?QtQq0VxnXoIXYyK5GfdpqTScea7IF/jCKYJqvhxP5Cdsjrv+S5MdHJ90XXLr?=
 =?us-ascii?Q?54Nwv3DGsyxCocwSVf3bILmn4lMFmd/WaKg9ouE6P82f9hU5VQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 00:20:57.0503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc080f27-a300-455f-0922-08dcf22f6641
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4123

Similar to the coverage of cache_invalidate_user for iotlb invalidation,
add a device cache and a viommu_cache_invalidate function to test it out.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h | 25 +++++++++
 drivers/iommu/iommufd/selftest.c     | 76 +++++++++++++++++++++++++++-
 2 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index edced4ac7cd3..05f57a968d25 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -54,6 +54,11 @@ enum {
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
@@ -152,6 +157,7 @@ struct iommu_test_hw_info {
 /* Should not be equal to any defined value in enum iommu_hwpt_data_type */
 #define IOMMU_HWPT_DATA_SELFTEST 0xdead
 #define IOMMU_TEST_IOTLB_DEFAULT 0xbadbeef
+#define IOMMU_TEST_DEV_CACHE_DEFAULT 0xbaddad
 
 /**
  * struct iommu_hwpt_selftest
@@ -182,4 +188,23 @@ struct iommu_hwpt_invalidate_selftest {
 
 #define IOMMU_VIOMMU_TYPE_SELFTEST 0xdeadbeef
 
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
index f401c565143f..11e0c81c77c4 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -148,6 +148,7 @@ struct mock_dev {
 	struct device dev;
 	unsigned long flags;
 	int id;
+	u32 cache[MOCK_DEV_CACHE_NUM];
 };
 
 struct selftest_obj {
@@ -574,9 +575,80 @@ static struct iommufd_vdevice *mock_vdevice_alloc(struct iommufd_viommu *viommu,
 	return &mock_vdev->core;
 }
 
+static int mock_viommu_cache_invalidate(struct iommufd_viommu *viommu,
+					struct iommu_user_data_array *array)
+{
+	struct iommu_viommu_invalidate_selftest *cmds;
+	struct iommu_viommu_invalidate_selftest *cur;
+	struct iommu_viommu_invalidate_selftest *end;
+	int rc;
+
+	/* A zero-length array is allowed to validate the array type */
+	if (array->entry_num == 0 &&
+	    array->type == IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST) {
+		array->entry_num = 0;
+		return 0;
+	}
+
+	cmds = kcalloc(array->entry_num, sizeof(*cmds), GFP_KERNEL);
+	if (!cmds)
+		return -ENOMEM;
+	cur = cmds;
+	end = cmds + array->entry_num;
+
+	static_assert(sizeof(*cmds) == 3 * sizeof(u32));
+	rc = iommu_copy_struct_from_full_user_array(
+			cmds, sizeof(*cmds), array,
+			IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST);
+	if (rc)
+		goto out;
+
+	while (cur != end) {
+		XA_STATE(xas, &viommu->vdevs, (unsigned long)cur->vdev_id);
+		struct mock_dev *mdev;
+		struct device *dev;
+		int i;
+
+		if (cur->flags & ~IOMMU_TEST_INVALIDATE_FLAG_ALL) {
+			rc = -EOPNOTSUPP;
+			goto out;
+		}
+
+		if (cur->cache_id > MOCK_DEV_CACHE_ID_MAX) {
+			rc = -EINVAL;
+			goto out;
+		}
+
+		xa_lock(&viommu->vdevs);
+		dev = vdev_to_dev(xas_load(&xas));
+		if (!dev) {
+			xa_unlock(&viommu->vdevs);
+			rc = -EINVAL;
+			goto out;
+		}
+		mdev = container_of(dev, struct mock_dev, dev);
+
+		if (cur->flags & IOMMU_TEST_INVALIDATE_FLAG_ALL) {
+			/* Invalidate all cache entries and ignore cache_id */
+			for (i = 0; i < MOCK_DEV_CACHE_NUM; i++)
+				mdev->cache[i] = 0;
+		} else {
+			mdev->cache[cur->cache_id] = 0;
+		}
+		xa_unlock(&viommu->vdevs);
+
+		cur++;
+	}
+out:
+	array->entry_num = cur - cmds;
+	kfree(cmds);
+	return rc;
+}
+
 static struct iommufd_viommu_ops mock_viommu_ops = {
 	.free = mock_viommu_free,
 	.vdevice_alloc = mock_vdevice_alloc,
+	.cache_invalidate = mock_viommu_cache_invalidate,
 };
 
 static struct iommufd_viommu *mock_viommu_alloc(struct device *dev,
@@ -752,7 +824,7 @@ static void mock_dev_release(struct device *dev)
 static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 {
 	struct mock_dev *mdev;
-	int rc;
+	int rc, i;
 
 	if (dev_flags &
 	    ~(MOCK_FLAGS_DEVICE_NO_DIRTY | MOCK_FLAGS_DEVICE_HUGE_IOVA))
@@ -766,6 +838,8 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 	mdev->flags = dev_flags;
 	mdev->dev.release = mock_dev_release;
 	mdev->dev.bus = &iommufd_mock_bus_type.bus;
+	for (i = 0; i < MOCK_DEV_CACHE_NUM; i++)
+		mdev->cache[i] = IOMMU_TEST_DEV_CACHE_DEFAULT;
 
 	rc = ida_alloc(&mock_dev_ida, GFP_KERNEL);
 	if (rc < 0)
-- 
2.43.0


