Return-Path: <linux-kselftest+bounces-32114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B05AA66DF
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 01:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 466B1981D11
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 23:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E2C268FF9;
	Thu,  1 May 2025 23:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GJ8Nz+fe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCA62609EC;
	Thu,  1 May 2025 23:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140517; cv=fail; b=Rusobyl9KzjwSLeOUnxXsDFOcNo5pfNYbsoUNq7rhgMFrvij6uGbnLxgtgKhxfD+3H6oRe+Tsr7SH5OvyIqF2ahvfjJsrAfdoGAvAP/dz1koqjg0+mtvXUk7ZLjj+O7nmj51hIied5Bzc7YUlsbSnd9pmH2p592RjvPMFGC54BQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140517; c=relaxed/simple;
	bh=FznnIvHR/NCSVSd2l31WKODQu4YmPmFERUkUUf+uaQs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VDos0YV9nAbbIU9qKG10MCsKmY/5T0jTztRFdEx+GtzhehFN6GdRSYdhaBq0QlKi9GrRHbfFU4RILbe8QOpdJYr/UpUE7lrjWUUk2s0y3tzTwEPkXtvY8MZJKHwo5CD6MOqADsN1rA+wsJvFdiM2kc3CJO5xFw0BPsPcNkJsDTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GJ8Nz+fe; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQCmz3CZQ15U4vf6SvdWOWcf/hCHd/0XFDzrsFo77aDqBtEHqJQjq6dGHwyJcnJzP1iiurZxuXDKm5ZLIWMYoAWV+ZRY63eZPZTrl3PfhAfAHGiWBl+j5VvwHM3qWbDIznSEukrb6IP3TTKjP+2zhkPdEr05z2xxYfOfeujdwt53KC+KFAhvH4YfsFC1DoAfbof9WdACNvBzQ7+4T9yp4dAzNXwnjfzyt5WPvsejPAZ8D2ze512awykfiexZUgIiy6wC1ZQQgvYikc3jjMBxSNQA3nUv/O9wlxHa1ty1NB4uI1xoI08m2BpwZh3N9LGP+Ih+7X6WrXUcfoCn70HvhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6APJmLaezdJ+/awjyB2MB1TMj3/uXeB438YQ0yzJAs=;
 b=XZJLjvFRKRNkOvhx8nTV3ho64A+dyPFZYTmimvp6hk/3R1uNdK8TVJrwogdvEQMp7mgdudF4vUx/qLHItRzEYAG8mxq/Q+22DtkB7ifsFOW6QnhpIhmn9QELX0tueENe1gw5yxHL9bSFaZzAD1tUEomeSJRuA/DA2iUH/rbkqpwro5UvBswcdRpEy35ko50qCYfCfAt5DgSPsQkS6UqComIJ4gj1Lp+dnR3KNGPWgJVJqLZL16znED6CQknC/4VEohaVkazV9ZvBL2Sxxcv4rqjwYY8Z6yxCW1vVLKJmV3U5ubNdwz2Wdy1VG7kstE9owOjIo3CZ1xsPNKpsFt4EUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6APJmLaezdJ+/awjyB2MB1TMj3/uXeB438YQ0yzJAs=;
 b=GJ8Nz+feUa6sq9oLv9Dt9mMG2SfIz81fB5kxcGatCWntrUvj26pfZcUFkzqYXk503CTEPYr41p7pFak1mM/IzQOJEo487Pgze5U3FvhHwMOanudexwGZybrs28nEiCDMUxgieSUSuZRbbR9X9XEAzC9xqQftjjwFRa1oqVCEs9lZBz5w5xRI244IlALr/Tz6I8lNyYXmHgUA3HO0ERipUZ+xXfczdXHwI5lR/wyx3h2zaItZ8F6nACnbtp5uWF3Mw9ocFpi+HDmYGdYCz6PyYBGxE/PPhALxbs/I5N1ikpU9sZ2z+g3dOD4x/+LYKziMUVuYnTiboEAJRlUQ2j2mrQ==
Received: from CH2PR07CA0022.namprd07.prod.outlook.com (2603:10b6:610:20::35)
 by IA1PR12MB6652.namprd12.prod.outlook.com (2603:10b6:208:38a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Thu, 1 May
 2025 23:01:47 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::7) by CH2PR07CA0022.outlook.office365.com
 (2603:10b6:610:20::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Thu,
 1 May 2025 23:01:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Thu, 1 May 2025 23:01:47 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 May 2025
 16:01:37 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 1 May 2025 16:01:37 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 1 May 2025 16:01:35 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: [PATCH v3 01/23] iommufd/viommu: Add driver-allocated vDEVICE support
Date: Thu, 1 May 2025 16:01:07 -0700
Message-ID: <b9f703087ae6232d3ebd471d1ed5ad16b3ccea31.1746139811.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746139811.git.nicolinc@nvidia.com>
References: <cover.1746139811.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|IA1PR12MB6652:EE_
X-MS-Office365-Filtering-Correlation-Id: 6331ef14-c03a-4af8-fa68-08dd89042673
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7IXg4ew1oUk5uFVBNWpanQXZ2LcC2qBqSSJoqdopQgehrsDDHK+jDK6nEisR?=
 =?us-ascii?Q?fPMOR9JZAwP54lJzq2MZzflddglcWxfP/qVx5AY9kkUiNEiTrlh/aZyBpBuX?=
 =?us-ascii?Q?p369C3AmHbUtTCKGmwLfUcqzdH0ThdWWqYHbuOUJHHTtu31b1OjuTr57hHJi?=
 =?us-ascii?Q?MGp1gdSUZ4gmTzP8TIoHurpdfAeYl/xrmBlK1eKKLS7ncSD3Wc3mrTLh7RuL?=
 =?us-ascii?Q?UbuNOMPrfmzOlit9JDoofrdOUmY/OcIn8PxPiB5Wh5uRsfK5lpWiBlDAT8WP?=
 =?us-ascii?Q?+f3/lcE2QQi5vY1KUf3G4FSUp/a2YOhKFnJ8XLi/qJU12xU3IyShPi8HGq3F?=
 =?us-ascii?Q?MJyInOgywOeq6VDFtXg/CeYdHGLG6CvUd6klqCja3KKzAfVCDpjYDf37EoRc?=
 =?us-ascii?Q?CFhZNqAQvupWMjIxnrSDCwFu2uTjrghBgcRgNpSISirAU7SjMI0OnbvIQLKl?=
 =?us-ascii?Q?51K2IniEPq3mjSbXGpy+t3usZFLTKG7SPoQsOs5Er/7w/KUawsIzEpkRHrF9?=
 =?us-ascii?Q?O3BzExEokilIXiFsoaGAamj1azm/tFNLumeWx3Buw+VymUS1Luu41GlYl81L?=
 =?us-ascii?Q?YwoNU258GQjLdO8xr98sHwO1vMKBJl0fVgyUefJR88gXEgJkHlfunQBmoNy5?=
 =?us-ascii?Q?WM/b1kf7Y6MW0ER9EZF6YpjHQbeTjABzEwX4gvi+jBlJH0AnRpQ+T9RcJ8wT?=
 =?us-ascii?Q?mnm291Ho5X3rKVr243EBAJJiijdVwf+4nRU6tUqtcKC3b+k0sm3zrlP6ss+U?=
 =?us-ascii?Q?hnXAP2jzwWStLqIeD11wHxjhTAXf7rjkHZB39vbo68VcNktx6Hb5uWkXgNKU?=
 =?us-ascii?Q?JeMxRlr1YMSuoyFBkRrpccr+HzuaQ/6FsNMUOAopFWTfB20yLd8wteXzZHvH?=
 =?us-ascii?Q?dGDpV5IYFx7qVHRh3jj2tOmbewpgTGgsHlhO9Zdjdu4ucREim0Sq9nzjXfS5?=
 =?us-ascii?Q?x0T8mQL7B8h+4zjP/bC/YH2aojXtL1I5hjKSGhVYeP/AQK8lVWL4MlfNQdId?=
 =?us-ascii?Q?jVGo17uSTkfm1aixlVMA9GIuI1OjrojdTlErW+FT5YVOFo0D6STi3IMiM+Iy?=
 =?us-ascii?Q?tiZrMcs9n4Pxd5i9+vPPtoVPCoNUeoQCFGTzKcktu6iKzVrOj086yKsuZz7m?=
 =?us-ascii?Q?YnMM+h53uPbVK7R/51Y24UCsHZh1f7+PkvP8VKi4ZhKsYTluE9gMoFt33ALf?=
 =?us-ascii?Q?CKIepmoJbqB4+ywU4I5xN9lturWWx/fGco42QRMANysuVSZHcr2/BJscTDf7?=
 =?us-ascii?Q?RJI9gie56Eit1ghq8MsbrEg87zjD76UvAPZVFqGnIrgeatDUTmrqUnyCVQfp?=
 =?us-ascii?Q?uo5ji7249/QaYTIMtoLAIjJsFw4Y4pedPYzBTphyzL8FSifqsvcKnjjKH1Lg?=
 =?us-ascii?Q?m+eeXdnmY08a27by+cWhTk40p1Jew8rdXmm0Mnuza/5gXqQ8IgvCtik/4n6C?=
 =?us-ascii?Q?lCcvMYZ47VG6azpGPQrI+nQMZEWkNznLrGkmhmOC0HsgFaF047B6ycnL4NYq?=
 =?us-ascii?Q?fU3guCxmaXPbFq/lnGWCjxynjJWvURDIYeqr?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 23:01:47.2936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6331ef14-c03a-4af8-fa68-08dd89042673
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6652

To allow IOMMU drivers to allocate own vDEVICE structures, move the struct
iommufd_vdevice to the public header and provide a pair of viommu ops.

The iommufd_vdevice_alloc_ioctl will prioritize the callback function from
the viommu ops, i.e. a driver-allocated vDEVICE.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  8 ------
 include/linux/iommufd.h                 | 38 +++++++++++++++++++++++++
 drivers/iommu/iommufd/viommu.c          |  9 +++++-
 3 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 80e8c76d25f2..5c69ac05c029 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -607,14 +607,6 @@ void iommufd_viommu_destroy(struct iommufd_object *obj);
 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_vdevice_destroy(struct iommufd_object *obj);
 
-struct iommufd_vdevice {
-	struct iommufd_object obj;
-	struct iommufd_ctx *ictx;
-	struct iommufd_viommu *viommu;
-	struct device *dev;
-	u64 id; /* per-vIOMMU virtual ID */
-};
-
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
 void iommufd_selftest_destroy(struct iommufd_object *obj);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 34b6e6ca4bfa..422eda95d19e 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -104,6 +104,14 @@ struct iommufd_viommu {
 	unsigned int type;
 };
 
+struct iommufd_vdevice {
+	struct iommufd_object obj;
+	struct iommufd_ctx *ictx;
+	struct iommufd_viommu *viommu;
+	struct device *dev;
+	u64 id; /* per-vIOMMU virtual ID */
+};
+
 /**
  * struct iommufd_viommu_ops - vIOMMU specific operations
  * @destroy: Clean up all driver-specific parts of an iommufd_viommu. The memory
@@ -120,6 +128,15 @@ struct iommufd_viommu {
  *                    array->entry_num to report the number of handled requests.
  *                    The data structure of the array entry must be defined in
  *                    include/uapi/linux/iommufd.h
+ * @vdevice_alloc: Allocate a vDEVICE object and init its driver-level structure
+ *                 or HW procedure. Note that the core-level structure is filled
+ *                 by the iommufd core after calling this op. @virt_id carries a
+ *                 per-vIOMMU virtual ID (refer to struct iommu_vdevice_alloc in
+ *                 include/uapi/linux/iommufd.h) for the driver to initialize HW
+ *                 for an attached physical device.
+ * @vdevice_destroy: Clean up all driver-specific parts of an iommufd_vdevice.
+ *                   The memory of the vDEVICE will be free-ed by iommufd core
+ *                   after calling this op
  */
 struct iommufd_viommu_ops {
 	void (*destroy)(struct iommufd_viommu *viommu);
@@ -128,6 +145,10 @@ struct iommufd_viommu_ops {
 		const struct iommu_user_data *user_data);
 	int (*cache_invalidate)(struct iommufd_viommu *viommu,
 				struct iommu_user_data_array *array);
+	struct iommufd_vdevice *(*vdevice_alloc)(struct iommufd_viommu *viommu,
+						 struct device *dev,
+						 u64 virt_id);
+	void (*vdevice_destroy)(struct iommufd_vdevice *vdev);
 };
 
 #if IS_ENABLED(CONFIG_IOMMUFD)
@@ -245,4 +266,21 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 			ret->member.ops = viommu_ops;                          \
 		ret;                                                           \
 	})
+
+#define iommufd_vdevice_alloc(viommu, drv_struct, member)                      \
+	({                                                                     \
+		drv_struct *ret;                                               \
+									       \
+		static_assert(__same_type(struct iommufd_viommu, *viommu));    \
+		static_assert(__same_type(struct iommufd_vdevice,              \
+					  ((drv_struct *)NULL)->member));      \
+		static_assert(offsetof(drv_struct, member.obj) == 0);          \
+		ret = (drv_struct *)_iommufd_object_alloc(                     \
+			viommu->ictx, sizeof(drv_struct), IOMMUFD_OBJ_VDEVICE);\
+		if (!IS_ERR(ret)) {                                            \
+			ret->member.viommu = viommu;                           \
+			ret->member.ictx = viommu->ictx;                       \
+		}                                                              \
+		ret;                                                           \
+	})
 #endif
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 01df2b985f02..d4c7c5072e42 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -90,6 +90,9 @@ void iommufd_vdevice_destroy(struct iommufd_object *obj)
 		container_of(obj, struct iommufd_vdevice, obj);
 	struct iommufd_viommu *viommu = vdev->viommu;
 
+	if (viommu->ops && viommu->ops->vdevice_destroy)
+		viommu->ops->vdevice_destroy(vdev);
+
 	/* xa_cmpxchg is okay to fail if alloc failed xa_cmpxchg previously */
 	xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
 	refcount_dec(&viommu->obj.users);
@@ -124,7 +127,11 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		goto out_put_idev;
 	}
 
-	vdev = iommufd_object_alloc(ucmd->ictx, vdev, IOMMUFD_OBJ_VDEVICE);
+	if (viommu->ops && viommu->ops->vdevice_alloc)
+		vdev = viommu->ops->vdevice_alloc(viommu, idev->dev, virt_id);
+	else
+		vdev = iommufd_object_alloc(ucmd->ictx, vdev,
+					    IOMMUFD_OBJ_VDEVICE);
 	if (IS_ERR(vdev)) {
 		rc = PTR_ERR(vdev);
 		goto out_put_idev;
-- 
2.43.0


