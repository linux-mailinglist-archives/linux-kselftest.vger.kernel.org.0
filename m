Return-Path: <linux-kselftest+bounces-20740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E40EF9B138D
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 01:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6740A1F23294
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 23:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41C621CD97;
	Fri, 25 Oct 2024 23:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FhMqh2rC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDEC215C70;
	Fri, 25 Oct 2024 23:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729900272; cv=fail; b=YiQInhXnHW45TYMcK34RPdvRF8JJnDaipaUPmxjzz/aERbP1uIkUJQJPZEaBAIk/89HHGP649QlcsQ5AOSNKAJ5S2ZTsubjiERsaRujEAgLujGtXeJmv7OGoQdzESo/y+jVD9Qcc544yaoUGEwSt0wo0ZxzeX26u84EP4j9RJ1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729900272; c=relaxed/simple;
	bh=IGTx5FrmS1qBGXsG+jeNnQdJA7XqIrpOoSKctvM8QIU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8GCoWITsDo3IQ5u/4PaKZRwbJgPND+EEOjmsOkAh7p5RIcEhU0rQH5QcHiO5wisGFQA40RmHO4pOldCLkFRJEMtK0SHTHh9aoMxwgO6VEb7ZU0P1zuVdo9zXeIPjY5iWL3cHcFawYEYLbrKH6zn+iJOn6FRdZyScGQXbBSl3LU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FhMqh2rC; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yx5OtB+fB4XB51KswsFc/1hiKnAgPP9mWMKMyX4f2fX4D4lJq+UpO2ONiqVGiY5wqX+3gQ0/SnEVvIiosNO0hlCjOU1d+X+SxazEmgHr9KYqoZLmWDUSAkrHh+zLXUcgmB4aFROPl2N51wyUdwYt+ymgatH8TyN0abRKayU7+haDVyu/kU674Tm9mthMAmQc7kd1hGOsCF0TJkJ7X0Vopclq1pNIPbAPo677Ld0tuad4uoOnRK5fYR8sKxwGjLpJjaVfxTEAn4zKJ5LNFGfthk7XQMEjY+0HBJKq/C4PuYokWrp2xn/ZddAYKd50pX48stcGOQoVC8IZxBTz9gOi1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nSBZ4LqKfElNvT7voQBCikyGQCQjd2n14NLCSZ5K/M=;
 b=mzJXl712WopqAvdOazTeOGqTBPEiLITPH5ImFVo/0tuNvosaPAHccJVPe6JGsAEEeo4DS3roJ36EJCAFa6tReCJjXqpmju9plb4TsTXOrIT1/+J7dAWJg/ur/soc1DbI4EbJsSTZzoSo6b896LZdy6HR/G5rzrPxxoBPhPXKc4AW5zJl8V/TjImir5qRxnAoXCQIxdp69La16eHtGejpoPiaYOKKi7HadMgQkjWVj1jpxdjj/KgP00QIKzln/TNEWKRdQlizV+Cg3iLk1HL1rlMYsdlw+RUHXMFLgyB6YBduMT41tCV3R/z4dqzfdGt7xPnCAK/W4TdcCG9XYuToVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nSBZ4LqKfElNvT7voQBCikyGQCQjd2n14NLCSZ5K/M=;
 b=FhMqh2rCRH3WxGx7Sv8HX96gLmFQRI7KaBi/KEgcplPr8a8JlQNJnvEHjRZ1vUaFY2p+BzPyY/s6C+Ph2eINFulSeUqG6gEiUIWapw7WyOfoE3Vn2Y4v/qF1qN1U4UYRxvetOZ5MWTlneJXqCCiVtvGlISauGkfvj0nmc79Epa5sXAGs3RJV3jm/ixJDCpLSJ0TZQfzXAHYZHa3PY/ipa5CJ6+qoQu3l9dSXnaSfPOBChkRoHmhoAjReO4kwLED5tEdu6zqLVC7c0CuqHwnLYwXsxiHPAWX4IQow7oAmmjerqxXyBh//uPnliwZ4FxM02QiiFGo7O5TDap4IG24gdw==
Received: from BY3PR10CA0011.namprd10.prod.outlook.com (2603:10b6:a03:255::16)
 by DS7PR12MB8084.namprd12.prod.outlook.com (2603:10b6:8:ef::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.21; Fri, 25 Oct 2024 23:51:06 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::eb) by BY3PR10CA0011.outlook.office365.com
 (2603:10b6:a03:255::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19 via Frontend
 Transport; Fri, 25 Oct 2024 23:51:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 23:51:06 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 16:50:59 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 25 Oct 2024 16:50:58 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 25 Oct 2024 16:50:57 -0700
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
Subject: [PATCH v5 08/13] iommufd/selftest: Add mock_viommu_cache_invalidate
Date: Fri, 25 Oct 2024 16:50:37 -0700
Message-ID: <6ecee6aff136af1a1b8c13adb0210a74c1974ee7.1729897278.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|DS7PR12MB8084:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f9598c-bf60-4542-abf6-08dcf54fe4b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m+MxbWh7CPFmMJhytnU1EkrO/o3S2e/+MYkgn/0YQZmroIBfxDk1ZhDSxksV?=
 =?us-ascii?Q?5ZVOxyxkaV1yLk0i21oGE39HfWClCcyDo+pYJJCs7+wzsrKn4/qRyVa7A597?=
 =?us-ascii?Q?+v39qc5a/CBDyGyh5cuNfen3csg/5kO+6dpvLE1SRmCLvwZvTBkgELdi3nhk?=
 =?us-ascii?Q?gPTruumerS+rFIna5Hw1agvD35pI1LNn0NhlJ01scSjBSOqBFoDq1u5WC82i?=
 =?us-ascii?Q?xHbWphN6E94HNPBHdLzsD14ReHB8nV50CQ+oBL+9lin5Evcq93nUZU2rv6Cp?=
 =?us-ascii?Q?nLqPCKnSTfGoz32PrtS/Sz98WHt6F4JtQmsz/Pwcc1qwaQZdY9vDOR0QONc+?=
 =?us-ascii?Q?S0U611dJLSnnzEgcAzbNU816wPFQK0ou8wFqDBgpAV7m2w7BvP9WKS4mQTH4?=
 =?us-ascii?Q?QcrRJ+Kb6zbeNPVpywxW9tTIaOdnARhAjjexDcVs7clpDU6U9KuxP7LgiUDu?=
 =?us-ascii?Q?HINdhphFnVUlVqWL1etY1XchTeDwW8/TJPL1ujMepJ0U9Q0fx2DEM1Ggs/Uh?=
 =?us-ascii?Q?jJetWHqHujlCiko2G18ClDMljsIyy1WEV0MrQ1P4i42oeeO+eSkCYagyT5F5?=
 =?us-ascii?Q?35h7xi3iJ6RPhG5MXLkC0hSWl1IzGmT4+1ZaZA701TJVv7VG+pcSbZT4Prg6?=
 =?us-ascii?Q?lD77XLdNE0H3YJVa0N31YTRJc3sER3bFur/xBSjMAjQHAzNozhRia6kR1W8/?=
 =?us-ascii?Q?svgp7JmS08WCrQhR/DJqJwffQ2G9OngufmjbCVVTwyrpTi2zxF3RzsUZpM7O?=
 =?us-ascii?Q?kL0/iEL8Gp4M2jla5WjsrmV+bi1IjhMpW9kU/sdw5e2H2uPKxRKhrepjnrL0?=
 =?us-ascii?Q?nlWn7N66AZbEFEHr3gBiKHEGf8l7Kaf3bWmRq2x17UKbeQjs+k6FLhbWcoft?=
 =?us-ascii?Q?Eo5uWR8NuOYzSmizUTVmW3xf0afEAdZCtMpAOfsLkmkxFc8Y7mA3UtmMiQRA?=
 =?us-ascii?Q?pjYr6dvHTMKzVh0t6J1ZrQ+043h5+eib621W2T5ZfbhYslc4ay+Adz9QrSYm?=
 =?us-ascii?Q?lOio8ykyhod40DuI1XNWJdwwywzcU/jHHlBuHywy5t1d970W+YuZEK8gEqGU?=
 =?us-ascii?Q?2g/sox1VQJlwAUH15hunCChyS/Blog6Q58qiP8ETqRgsQTw+LhN3KXsXQ1Tq?=
 =?us-ascii?Q?XSSNV/LV198evGVScOvv7Y6vvmf6BgVmP6/OpAR4uitHZ8xM+Ysy7P2L+ceQ?=
 =?us-ascii?Q?iK8FxvK+HekkXQxnyH/Er83kKFUuBogShSMzXZtFM4EhZEG5s9DQ7cyfk4Vt?=
 =?us-ascii?Q?aE6S+Rrl4CB+I7fKHMnEljmP5mGp9Cc+Jb/17bRf2XRydQe4cQR+F+S3U3Fn?=
 =?us-ascii?Q?cyfXO+RrX/iiMIFdv1idnhECE2N/8lUrhMnc/n+1a/8AGcekUYQzqwcBJJp1?=
 =?us-ascii?Q?SZp8wO9wm2SDSwY1S4Ncucrw37YIX7ntMdA0UjAIoYPbet+E9g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 23:51:06.7747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f9598c-bf60-4542-abf6-08dcf54fe4b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8084

Similar to the coverage of cache_invalidate_user for iotlb invalidation,
add a device cache and a viommu_cache_invalidate function to test it out.

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
index 33a0fcc0eff7..01556854f2f2 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -163,6 +163,7 @@ struct mock_dev {
 	struct device dev;
 	unsigned long flags;
 	int id;
+	u32 cache[MOCK_DEV_CACHE_NUM];
 };
 
 static inline struct mock_dev *to_mock_dev(struct device *dev)
@@ -606,9 +607,80 @@ mock_viommu_alloc_domain_nested(struct iommufd_viommu *viommu,
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
 	.free = mock_viommu_free,
 	.alloc_domain_nested = mock_viommu_alloc_domain_nested,
+	.cache_invalidate = mock_viommu_cache_invalidate,
 };
 
 static struct iommufd_viommu *mock_viommu_alloc(struct device *dev,
@@ -779,7 +851,7 @@ static void mock_dev_release(struct device *dev)
 static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 {
 	struct mock_dev *mdev;
-	int rc;
+	int rc, i;
 
 	if (dev_flags &
 	    ~(MOCK_FLAGS_DEVICE_NO_DIRTY | MOCK_FLAGS_DEVICE_HUGE_IOVA))
@@ -793,6 +865,8 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 	mdev->flags = dev_flags;
 	mdev->dev.release = mock_dev_release;
 	mdev->dev.bus = &iommufd_mock_bus_type.bus;
+	for (i = 0; i < MOCK_DEV_CACHE_NUM; i++)
+		mdev->cache[i] = IOMMU_TEST_DEV_CACHE_DEFAULT;
 
 	rc = ida_alloc(&mock_dev_ida, GFP_KERNEL);
 	if (rc < 0)
-- 
2.43.0


