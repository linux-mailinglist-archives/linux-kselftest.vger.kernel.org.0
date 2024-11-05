Return-Path: <linux-kselftest+bounces-21490-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 892EC9BD6B6
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 21:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5C0FB221D8
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 20:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5327D217655;
	Tue,  5 Nov 2024 20:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r0/ejGQu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C0721745D;
	Tue,  5 Nov 2024 20:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837166; cv=fail; b=RgWo/uEErvFZk+4yLSZPn2SKAH8QKyF6R5NPq9NOmKR8Bl7sI2OR4YdFBRn0/RQVErdkcLH7bOO9y4QRUE5LJPAHzNNc2DlHycgsOKupS+RXxsbGBvrreKGrd3z6vCpKfQnw5ap1VzVK2sahA/7FeZFjI9p1msIjFMdgw/RvW1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837166; c=relaxed/simple;
	bh=oqaX/VgMNtwv0I+trJVeHcJFhZV59S787/gBe+xifGw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D0JODB4kgbQ6ADTpFj+9k2JTGg6OSlOETTnqJBfC7bIOhb/sPbJIcCYKTdGW1GWnKO//L6C+kqjlXxWyvFf4VPEa86wP6GkMV1ZjuEJYIEKSwxEma8k+R0Ijbm+UZOT7UJN2kkJUBpKBBEFybht9V5l29eM4/FiZ0pKrlRFCHUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r0/ejGQu; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKXkaDtQzT/1Mhen/CxZ2hHznzC3EfenYIsOtIWAspW1T2gCmO6XK8RH01WGCIXv4TtsFKU5IiKyVtwrsH0ku2bYy2+zszYDjOEXoDKjgsEMgszYkbRHQOiSLBqUdk5XEqNS8pmL/k1zCa5VxWeTZ/YNXPC181RyO8oqwIlRoIFW9RJOHU7/KwWz1j86XV7HkSN9HM8rXtPM38pX0S1EqQVGfXLXDlbQ6qxR0uZoNDm+0Fc10bDo+5OIwF3kI3ER6jDC1818qLSg5oPKMxIz2+SVpgxqsQHQtTYWJG66Z2xrHSKRL0YjhJJHI66o4KHmGzsaVjEfUGs4XlDKYa+gQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRnbRz8Gnud9Jru6EUuKpQ9YTVIVMPlWrZeCjfE9DY8=;
 b=onbc3fDmKsd55Tdf/PiDgSnC/wXIRkIyhLPOV0aQRAN9lmlfnbYuglM1/QplnLLlAxy868Mho2c/Rs8v9GXBIPJGSXLmTufCsSlS9rEiXsRlnf0z7p/SLoZ8yPVySlCrXA0lyQU10kcFGNPxfLTO1OogEKTw7Kgarc4kij8j26N5RuwEW7d0Zj312yjGhG8ATIQB8nKKCE2w/hNTbMU2Ei+8z+obFfLqIVh84kGt5b8As5kITHOd9f+ljIxgcSIdyT7TyV3FjcwAft12OWqj5pWQ86S7MCJ+6YoaVOnlufLUeWp/IPAOKfKfu6GiIlpyFeddP5ziHHsy7A8DmDNX0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRnbRz8Gnud9Jru6EUuKpQ9YTVIVMPlWrZeCjfE9DY8=;
 b=r0/ejGQuJ9gAlqqz1+cZMIRncsQnY5ahtujUr3LrmmqvcIxBXa7+5d9pDABRpAbM1Pej0yajQNP/MVC8bemCPwFB8yDXwFcM9IYJS2ZTT2E5wNPt4z19jmDHpkr/5KjBBeJ284uzoRLxW9Ewq/ia9H9qaj0sJ+vof9f3Q9XYqEwZMG3JfVN0XD1lXAc27Nt9Za1LH/Q7I6XCzEI3yrd7lfRRBV72fMgZj+mzmKw6YYiDyYxYJI4Pya0iw6wTi98teWhhSW504NrFRShxImHGiF+xrfb3bUi7sCyWlPNzHaKIwqymbmcj+LGbY3NOj4fmxUFAw2KFQEMeNbFo4PKfQA==
Received: from BN9PR03CA0592.namprd03.prod.outlook.com (2603:10b6:408:10d::27)
 by DS0PR12MB7535.namprd12.prod.outlook.com (2603:10b6:8:13a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 20:06:00 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:408:10d:cafe::f7) by BN9PR03CA0592.outlook.office365.com
 (2603:10b6:408:10d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 20:06:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:05:59 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:05:39 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:05:39 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 5 Nov 2024 12:05:37 -0800
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
Subject: [PATCH v7 07/10] iommufd/selftest: Add mock_viommu_cache_invalidate
Date: Tue, 5 Nov 2024 12:05:15 -0800
Message-ID: <a29c7c23d7cd143fb26ab68b3618e0957f485fdb.1730836308.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|DS0PR12MB7535:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ec1b0d4-741b-442c-95e7-08dcfdd544af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QyfsAp3Ww2KpcJFGTQa7eHpHxPdAeSla9Q+a+gwtEyZ/NlRIfCtbeZjI789B?=
 =?us-ascii?Q?0uSLlhDojMluMVawb+zPsf/3iy8DjJ6hSoKSHD27LcQ1xChWR2RBSh+xUdXL?=
 =?us-ascii?Q?pyo/2RkUe3TYP0IlJfNsOv2RsdeNyMcpXB9M5E43Z/5iypYx5s+l4OQK0Zxe?=
 =?us-ascii?Q?1U24wvfBKqfSrutuIQvX0lEegJ2xsnxebvCqDsF38kvEc/0fHBJAuwGQTe2m?=
 =?us-ascii?Q?DMBES5GULEfXdZK2bleUWyVsPBA+mA1fevzwUOHE6d4VvEHis17ZJUPiKmsP?=
 =?us-ascii?Q?ZTeM/hYSyQ96zkvbsKO0BytQ2anHVu82OD0MBMQhRJOdpPh69FMdlmTDxxtO?=
 =?us-ascii?Q?ncJS0IRaVa9E+fIXdZCL6NIh0D8Oyou8niprhVDml2PL2dFLIWQSll/l2mPe?=
 =?us-ascii?Q?vy3nwmJm9kauDUeqTvHYwgCESY6Yvqlter0+hUhXcU+R98UrRZ6kWccwoy9H?=
 =?us-ascii?Q?bXwAtwR58CvCodyaBJDjfHBsfDJT+pFa7/Z+XrTURHmEWLMdghTUi5PXMpuh?=
 =?us-ascii?Q?ByGX7td7zwMmf8ZP/Et62ADOuqT8/Uj4+eSoong+zvFyUCzvz6kCP5+GAi1O?=
 =?us-ascii?Q?ql1YntL54s74rf12U33exONfQ380LWQf24no2NmR/eoF5GMO7GDT9tExPL+R?=
 =?us-ascii?Q?jChDnszN1I05fqAKK2W5IGFPLEfRm2tiO6iWPUtKpJDCaJLr2/6ceExXDaHE?=
 =?us-ascii?Q?wV6DeXk1e6u/c/8OYVt6m2g/U2fhMpHrB0tE9lfTrylbk5gHD+OeHIQmc8aw?=
 =?us-ascii?Q?M0l+NgqqOS8qDU0V5e3WuqhDy6hSOX1VKg4zvsU9Nf649Eok7JuGs8eXQx4+?=
 =?us-ascii?Q?EsKtAEcfaKRo7Y6T41BZGiKx6coQMFSMqgKLxE3saOHZja1cSxn/zxZSw2zo?=
 =?us-ascii?Q?QMPHMotKsYhag/mph5xOA10QPezhFPQXdyNBYp9toeL0K/1RsOCGyifpbCcf?=
 =?us-ascii?Q?FKMhl/5rXKuQ5PVYMOTRG5H/N2ix+YL+bYi2zNmYeo1Lfpj/8thfA2K3zbWR?=
 =?us-ascii?Q?hVg3jG912YLqCe55n9+sh2HMr+ERC59FpAUemDoA5Uc1FOomVZUHUKeMQvDL?=
 =?us-ascii?Q?CLFyr/8pjZfJ3096HPGVe4YLXkAVvIpbFn/WzwjvgJ5k2Ye/XGK1jVTIkM85?=
 =?us-ascii?Q?z1gn2CP9cJv5v9x8/G8JGkpOyOkyWI7hLP4iPrU8fa17uDNmt7SpXkdyCkKw?=
 =?us-ascii?Q?H0Y7CflGZpuI/FVPE59pmxNwMdCwRk2u9tTZ+DhDOcXfgJiCOzsZcDVCgqjQ?=
 =?us-ascii?Q?hBvUy8LpJQCkscxCJ9TCDlSLTXcC76yxn13syOUc+WJDbFS91PELc01pBWRF?=
 =?us-ascii?Q?yGaOsfGRCa7fRjnQ0OnY8EknuWlcU+RrBrQvq2hY7EMlRm9A8GPRd2rT0H6Z?=
 =?us-ascii?Q?J4FOwxTxsjHl8ENkluqZU8sUbSwjGAEfkFRXbmR+bE/WhlHEpQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:05:59.9955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec1b0d4-741b-442c-95e7-08dcfdd544af
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7535

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


