Return-Path: <linux-kselftest+bounces-21181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2079B6F68
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 22:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DF5BB20E1B
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 21:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AE322CC48;
	Wed, 30 Oct 2024 21:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FuOyCgye"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6509F22ADCE;
	Wed, 30 Oct 2024 21:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324178; cv=fail; b=cknXQ74TMU9yMy56llQL4v1hIC+vICpsjZFXcLc08l155347djNnYFs7UI0cVb6zE5mwCr71QjCIkvvWy/FHMOadDxyWQevPIPVRUmNZnnRj7raM0i/V7b75cAJicQo6wx6mdLaC0dQPk7t57oWSVTCFN8euF18Z9odxRsrfFx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324178; c=relaxed/simple;
	bh=oqaX/VgMNtwv0I+trJVeHcJFhZV59S787/gBe+xifGw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OCCH4MHVjKOW93/2Oc1g8r3c1iuB1/3bcaU+nkxCI+QKZhdtcPBvhuWE9CttTW4Gcyv8lZRRj302VqNjco957At2rVVMslB4XCUpvHGwzKb2gqqUgpDUhNQ/ekwi0aAYsAUB9wekniscKHSMmTkIrdukoluWZTq0+eR0ZXn8WBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FuOyCgye; arc=fail smtp.client-ip=40.107.243.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yuiptlocfw5iC7kDdnf8Ti8B9xRjWJN+Zq5WMVme2OlY5mbcxUnGbo7im12JXg+2x0dO5MEzLYlEYV4PNI3BxVML84FpL5aa5kDZC2Mz7sIy151/YOHoET8gZ23VJ6YFxyHCod6FAnqlgaxIyoa1c/Dx9IAv9QbxdK7nOVFMiiAhAp1TRxpiiTZ46e7RkgJjm6Wu7LnZOUIIj6WCA+maQBxGh5T0J230KHvxgWc/newD+Ay1ihyeqxMiE+M4JMxDOM4Z47K2vMQqe9JuofAQNOExD8WqS6OnP5FzQh0V+sYsee2Txsjt8Le1XRBwkmqZ4+USi9n66Tt23w2VsUP1Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRnbRz8Gnud9Jru6EUuKpQ9YTVIVMPlWrZeCjfE9DY8=;
 b=vE0fcpmziDD5/NCYvtOTAw/uSE9hT9j8bSTB6hFaKg6zhvow5jHlR2yLR9T/NkNKZFwu7JBvsOLouQ8kWuQY+G9HFolh9I2w3TvRGWAVl3oqWqPjsnoHgv2p5enKj12I+FKQa/W/gOjufnIIGOac4et1kO9wgPBDZYZVmLCPOcq/L4ncLz9HF9ZRFS2IptzOo0lBp69cIUD9FJoXcTGaIyxChrJxc8jxGdMgXXGpFMGZWec7tvxUu7gRAeO335REzT3NkIHph/V2Qp4qokTktlx6wnQ1T2uivyTUVlP7VPhlW+9hQ4p2RL0nDUxzAr6NavbZ97UF7pAliUUolq0kaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRnbRz8Gnud9Jru6EUuKpQ9YTVIVMPlWrZeCjfE9DY8=;
 b=FuOyCgyeI1RvhdD2ApmJQ0PKY2UoiYsnSj5iEZPt+yxvWkuFrWtptETutrzOkvx7z4qX5xKGo6HuC3ot7vlNbNPHknnPD3HLLg0KkY+cuZU8aRvXoKvZ0AITmP2Nv6ycscXpkz6MEWdxspPj78JlqqQbEIidXqLU6Q00dwF0ln096gsw+4vwkpmbJaQ0RTgj5B47QRYWth9UBnFLomc+F86TIKjgNhB8cLNbAbVjJKg6HvwrpQeb/2ROtMduzgEaJP4gURz8ZdmZ+8GPcFdKLeGEx6gi+pY+TuqYep29RXD+2ZQaFkVNX3OiRoA5zs07oP1ySu5aA7fGodVobUUDEg==
Received: from BN9PR03CA0487.namprd03.prod.outlook.com (2603:10b6:408:130::12)
 by SA1PR12MB6970.namprd12.prod.outlook.com (2603:10b6:806:24d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 21:36:11 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:130:cafe::b2) by BN9PR03CA0487.outlook.office365.com
 (2603:10b6:408:130::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.29 via Frontend
 Transport; Wed, 30 Oct 2024 21:36:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 21:36:11 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Oct
 2024 14:35:51 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Oct
 2024 14:35:50 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 30 Oct 2024 14:35:49 -0700
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
Subject: [PATCH v6 07/10] iommufd/selftest: Add mock_viommu_cache_invalidate
Date: Wed, 30 Oct 2024 14:35:33 -0700
Message-ID: <abcd04d5548acbfa57aba866e0a1897f2cccd130.1730313494.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|SA1PR12MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f4bb7f3-f9ca-41b2-f085-08dcf92adf75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uB/YFJwCfxVDbhVeU657UlHgBrLC8GEBqqCOviwpCe4rXjBFOZV6wpiWmK/o?=
 =?us-ascii?Q?B/DTwxZACmlZkt2y4b1MdiFR07xNbrvuMffgLAQ8CxnpvfM2Iw8StX92I3Sa?=
 =?us-ascii?Q?JSLkkeAUaM+l1oeycNlWt8aprAOKoV87mDWeaSkE0H03YA6t1O1kEQ6xmiCO?=
 =?us-ascii?Q?zu+/XdrEj+ctg05yMOXv/Euq7CJVpomIAUFXfDRXGsNG6JXkLZ/M99WFEJ7d?=
 =?us-ascii?Q?Z2I5P+/CUQVsc4qhGoJX/RydhfYiPGKQ8N/TUP4lb2x9nhufgvZPYyaob/OJ?=
 =?us-ascii?Q?mIzT5KgtUp3CjIB3OaGLKG+pe7XY5l2GseQJNcZgMI3GMUyP3g4IshDj+M0N?=
 =?us-ascii?Q?8pM/V2POI1U8iW6ReSDCP08CsbI8E69zLz4wiBxV43cFrHHxboTnQG/ngdkI?=
 =?us-ascii?Q?FYmy7ntlNWL0iBmZkPj+mdIgYNa6IPTZpS2fM9hInvTtJaQTik5Cu53faLUb?=
 =?us-ascii?Q?NXgwI/gejQyJT5KWGADzv1c8OUTY0mQ3nC4Xk0sFSS+g+PMgEN5LuhH+I9Gk?=
 =?us-ascii?Q?0gdUfgZkHUP/C6SgQP8ScbjUfJqykr7q8YzPeNLgco8NR7Y/75LFGA2dmd0o?=
 =?us-ascii?Q?o4EoXeIxc5lMCCNXgfQ3JtTcD/+UOCfz60x0VPIos4gxKp4m7r9c0TXY0QnT?=
 =?us-ascii?Q?KLcn4GNuGjUTecoDgzyXAXmtf7vl13ai5OH1DgZerOy0AdmwHQ8Jl9iGwsaH?=
 =?us-ascii?Q?m09OFdgffaVPPWzkClBqByziZiWKNZ9aYsb+FkWT5qkVkLrsFzZ2dA7cRyNG?=
 =?us-ascii?Q?LYtIUD2FR+Qi3umEUvLi1ocRVQ0VKvBhc0ZaZ0JnIBw+WOxqmITwwVRBB/KG?=
 =?us-ascii?Q?2qzsKS5EZZhe78rfEkBRyGYz1fA8IiriKZatY/r9H+em7wWKG+o5cphqUhrI?=
 =?us-ascii?Q?kfeQoeA15oT4yAbhnx8ZkbYG5traCppXhO0XCQyDVCk/iBP5mSYsH3edLN9B?=
 =?us-ascii?Q?3AAg8Yyx9RlCbfdcKPHJBaYkBDfX3v3rI0ix2V11lp1YqnMG7McuEkm3kx4f?=
 =?us-ascii?Q?f4cdbJ/1Tm7D48AQILFpnd6bTerYIu4DmPGXyHaix+CBVN3FXzH1XIJxsM7X?=
 =?us-ascii?Q?TBaO+Isbr/KFbIHxuchaA4xTLxv2hus4hVI5GYX5VZ6WltQKT+LERzNHbVZG?=
 =?us-ascii?Q?BdOFBwhnpguP9FM3sUJtzUAB41XWQ/6TgEre1XdqAWly0UO7kbBHn0iL6jj0?=
 =?us-ascii?Q?NGrcx2tZlOJaX8qNnj/xqGMxqgBl4Twd2Z1dAfXcesVvktY4t/cU51zcr2xI?=
 =?us-ascii?Q?TrAJX4rtrchpXparIhBpb2/NrEzAPnU3E0UEQhe35rxaK0caQSsnI0bnisz9?=
 =?us-ascii?Q?Psnd3q5kBQLGVKZVi8ANvRl38cCzMDJ1Of03Mqog0j9KqbzVSEAuyvedACSZ?=
 =?us-ascii?Q?SQpgrZ/3PxCBElTVSKQBeogfdUxeJNHCEYI2x+rnThj7C0DTfw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 21:36:11.0571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4bb7f3-f9ca-41b2-f085-08dcf92adf75
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6970

Similar to the coverage of cache_invalidate_user for iotlb invalidation,
add a device cache and a viommu_cache_invalidate function to test it out.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h | 25 +++++++++
 drivers/iommu/iommufd/selftest.c     | 76 +++++++++++++++++++++++++++-
 2 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index edced4ac7cd3..46558f83e734 100644
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
+#define IOMMU_TEST_INVALIDATE_FLAG_ALL (1 << 0)
+	__u32 flags;
+	__u32 vdev_id;
+	__u32 cache_id;
+};
+
 #endif
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 31c8f78a3a66..e20498667a2c 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -163,6 +163,7 @@ struct mock_dev {
 	struct device dev;
 	unsigned long flags;
 	int id;
+	u32 cache[MOCK_DEV_CACHE_NUM];
 };
 
 static inline struct mock_dev *to_mock_dev(struct device *dev)
@@ -609,9 +610,80 @@ mock_viommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 	return &mock_nested->domain;
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
+		cmds, sizeof(*cmds), array,
+		IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST);
+	if (rc)
+		goto out;
+
+	while (cur != end) {
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
+		dev = iommufd_viommu_find_dev(viommu,
+					      (unsigned long)cur->vdev_id);
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
 	.destroy = mock_viommu_destroy,
 	.alloc_domain_nested = mock_viommu_alloc_domain_nested,
+	.cache_invalidate = mock_viommu_cache_invalidate,
 };
 
 static struct iommufd_viommu *mock_viommu_alloc(struct device *dev,
@@ -782,7 +854,7 @@ static void mock_dev_release(struct device *dev)
 static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 {
 	struct mock_dev *mdev;
-	int rc;
+	int rc, i;
 
 	if (dev_flags &
 	    ~(MOCK_FLAGS_DEVICE_NO_DIRTY | MOCK_FLAGS_DEVICE_HUGE_IOVA))
@@ -796,6 +868,8 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 	mdev->flags = dev_flags;
 	mdev->dev.release = mock_dev_release;
 	mdev->dev.bus = &iommufd_mock_bus_type.bus;
+	for (i = 0; i < MOCK_DEV_CACHE_NUM; i++)
+		mdev->cache[i] = IOMMU_TEST_DEV_CACHE_DEFAULT;
 
 	rc = ida_alloc(&mock_dev_ida, GFP_KERNEL);
 	if (rc < 0)
-- 
2.43.0


