Return-Path: <linux-kselftest+bounces-35901-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E22DAEA6C0
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 21:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37FBD4E2AE4
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 19:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF392F532D;
	Thu, 26 Jun 2025 19:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pkccsAqo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072F62F4318;
	Thu, 26 Jun 2025 19:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966551; cv=fail; b=pHWc5xBThiJjlM5kRUquGRWCxXNhPV2hw4MJBQlpPHCBwdJ7H6bER5MgtgiJESksbq53b/LTiNpNkZBcL1vzqia81XQRBl+tA83AJJgMfICBEOa8uOfg+92t0LdGuKfV8tmDBM7wS0VgSsDJC2GfDf76obI7Ocvle3qWoeoHvoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966551; c=relaxed/simple;
	bh=yE6sg2si6rxjlZpnaVRZNC6khwKHwtESFz6BXRUEPQo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LWBdKjGAOSXJv9vrvjLv/JSch0WjyS6XrFPlLEl8s7r+mFvPYOHPKLeQ2CodXTbX7/v2AH8Ox6NecwDZRgJ2swSGOcvJnJOb9DaQ9u2te7mJLNCC/T/xvBSKhvLuty2JmPUPqDf2xqOfMrqApc6PHALwWn+W3iX5ZCjGQ+kmuao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pkccsAqo; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyG6XKz1e0Z0FK3560bgB43oD1ou+aCty3txnQiymU0ihxAKdbOUkN7q1sWrF/pPRlgtKHxD/v7MtpQApt3MkzkWDpdr88QFxNuRZFnrWy9X/suzbXpH+aKTagNUBE39Uoq9wfO+v4UhHIp7XaCwRUA3W2hIdjKAGbVfm7ynAPHY+iFOpbu3+LFpFc6Hp+bERaQBEJqBpN8X6eu4OTCR1oTnxCw1J60IetjbwZS6VKbdnbg6K4soVHalxTSxjxIXGNim1UMnqTf32tpqVJiqROzw64M4nD6GiMxTbAHL4aCDcC1ypOp/9As3AF8W3BWOnZ3fN6Ft4TS68t5oYmUJpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swctkMnu7meFA58Tvh8OwfnNkgKz93zfiocbfO7V7ag=;
 b=tlOq8zNKup+BOMCssrjbRjPC8s8O6KVbc9YpPhEbnEQBgsQP8Cb8rTftECn07TqurvGqb1u77OJ3CyG8grZQNHeMU+8ATURYLHHqR/vZ5Q9/UH7r2GaQPk+iGP5iw/uisTvT5uvodxfGcdSbZZz/0P5Bup+6M/m5VkL7FNPIw1E7BJzJT5LfPWNXnmamyfGROcUAi/lxzrfevSrgXYxz//JZ4r5go9Ts7cgbqTbpd3QD/ZRLR+G5Sqrwx9oOD+WyAKdWKET0336RVaWX0QwrgyeiJRJVCipnVdJBFqo/2HjaHz5hvKKWqE1sXQonLsaFVk2F7CFWf3CquEj9emVJ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swctkMnu7meFA58Tvh8OwfnNkgKz93zfiocbfO7V7ag=;
 b=pkccsAqoSo2dGscdpDLPC32T8p/Uc28ELG7nPRnatzNePUyAYjc2EpQKE4uk1PYy2/g80ciRrWlCOrPm+Mqc/mACVsmrQLxC0TYsCSU7noeTc16JT5HeOye4qEchT4rVeHiIPgY0jm/nF7R1wvnEj9f42Tqt8lhPjnS4zndEkYeU78GRsZuce/zT+R2DRMbOGJOS8LEivUaqj7FJ0vJ8j+ktC4V/soz7qWZaf6l+dTARRnGybZu4SDKSJj6odq9AS5QkzI17sVsC1a2m4WxFvp+HJOOnbaXlKbQCcK/ILqMj5S9XIz9xSHCgzWQFZn8yjF56Yqus0fNCsJgNPPYe3Q==
Received: from BN0PR02CA0040.namprd02.prod.outlook.com (2603:10b6:408:e5::15)
 by BY5PR12MB4321.namprd12.prod.outlook.com (2603:10b6:a03:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Thu, 26 Jun
 2025 19:35:41 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::7e) by BN0PR02CA0040.outlook.office365.com
 (2603:10b6:408:e5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.23 via Frontend Transport; Thu,
 26 Jun 2025 19:35:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 19:35:40 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 12:35:26 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 26 Jun 2025 12:35:26 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 26 Jun 2025 12:35:24 -0700
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
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v7 14/28] iommufd/driver: Add iommufd_hw_queue_depend/undepend() helpers
Date: Thu, 26 Jun 2025 12:34:45 -0700
Message-ID: <69bdc5e483a0d736703960ae85bd7712a2f6c099.1750966133.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750966133.git.nicolinc@nvidia.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|BY5PR12MB4321:EE_
X-MS-Office365-Filtering-Correlation-Id: a5b5858b-f498-4be9-473f-08ddb4e8a285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k2/UGUbvTAznr5017BdKJ/t6NzNe93lWoB9At1aYneYiicWYa0iyG/70EMLj?=
 =?us-ascii?Q?qFOk6TjjVlEOZ4QEewoVk+JI1zdSNASPBS+isIi7XsxSvDqYxKwFELqJEHnb?=
 =?us-ascii?Q?/pqE9jj3o0jrF1K/+j22ehy38s60t1HW31q718MQO348lKMa5/V9aUIIdGTO?=
 =?us-ascii?Q?zOwDGboy0jiiIXJ+okFjt7yMNn9txLUGLa3pr58p/FOvP8dLrSrlVhmdnXIn?=
 =?us-ascii?Q?dKZBQnK5IcBTWX0Uqps/Uki1aMGw2lMI5wLvmezbO2kZH7IGKkT5+Vgq7V7T?=
 =?us-ascii?Q?YUgjD6eyQt5Zy3m3jZmMQEZXLaAJtCGIk3yYKLkRggdkDtZ6obaWUKce63xT?=
 =?us-ascii?Q?gWNjsjMkJfcia81GecieobvtLKysCc4Wrpz3vUllVwZy67HbcUbHeFeNhGD1?=
 =?us-ascii?Q?9SobMsCbrwrwQysEvizo4/EOGgYa/qmrzuyNRlKf94R1bINKIlhpmUerTjPO?=
 =?us-ascii?Q?ks1GMyq86cDppYtg5wHFjV7EUM8SESzGLvsOTV5PtWczFydy5msqI6Wu5n58?=
 =?us-ascii?Q?UI/eMeueQtdM/G0gNWWHM0Jm+OUEvS4lLcKRvWw112e6JgwtCLzzWrK4A97d?=
 =?us-ascii?Q?GzgBxF4wqkOjtbIayfJ11q5geo53jjOfHzlmFFProhBeXjIsNdDh+e5T6v2i?=
 =?us-ascii?Q?mrT9j7KvTqsgMaOis9Nft+tE6UrBOiSs1211w3mlyiJaN/32u23332GlHk6D?=
 =?us-ascii?Q?nvQ/EaRWXm7hB4ZkfuQScGOBsTzAnbz1htwAej5tfG2tqB2U8sepLXZ5VRzI?=
 =?us-ascii?Q?s6jSpYIKXCqZBWxAUcbnSmYOl0Ct0adtwC4ugPrSxDMrkbjC8hO6azAWOXg/?=
 =?us-ascii?Q?leVOkwiZes+SdSG+ANraKGaWj6wnK8hYSJFRVCBcWtHhD8JaqDtkH7UMkv7R?=
 =?us-ascii?Q?a7W5/TFGCSFUTzrplir6db5cScdg9LMh4oeRvVl2E3tTUCGUUOvsA+IKHjRW?=
 =?us-ascii?Q?HQqJDzphnJAfviRyVz58WVVOajTYx8acNKR7VSE58ayDdby77MtVDSP8pd+s?=
 =?us-ascii?Q?qfIdHeSneh2FVW9VVjGdWaLnM6LxeqC2TzxetVytD51VGcWN1d2mige4CHbA?=
 =?us-ascii?Q?FxqraoQBtaoCH5WsRM4rvMErYcmwXoENlZ1xs/qxx5EGw4iYE+dpGtnTCJEg?=
 =?us-ascii?Q?UOkjm1PR5NmhK7zfipt1ydaiGUp1W5MPAnL5N2bKSJ6/42W1pHiGF+1Jd/i2?=
 =?us-ascii?Q?GRL+Ec23x5YPkvESros3r5G+t1EGjFyT1ALWndwSm7UF75zG5F55pl97HD3b?=
 =?us-ascii?Q?Wi3JsMWKSIdW5mV00YRfyZNpGCsOECsNC9YbGNvYPiv3cPUgJev3aGypKgfg?=
 =?us-ascii?Q?XMKA11QGOOZx2x4UzlZQ55NG+DKvdj5ho/GJBSXVsefzzoVFJZhfEsCs4uqw?=
 =?us-ascii?Q?O50hzd3MlTnnVAe9UkuBM4lp0QkbCKHPNjJXqTGQb7ei8s/ByinFHcOcuYKk?=
 =?us-ascii?Q?F1qZ4h0VkZPO26KieosF0cemXMBoMgu7n0ibW87Ewys4kqEEsuopKCcTMcW9?=
 =?us-ascii?Q?VKEq5+0e+t60JMq7+ZvjyN26TlJAyBrAdwoj?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 19:35:40.6715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b5858b-f498-4be9-473f-08ddb4e8a285
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4321

NVIDIA Virtual Command Queue is one of the iommufd users exposing vIOMMU
features to user space VMs. Its hardware has a strict rule when mapping
and unmapping multiple global CMDQVs to/from a VM-owned VINTF, requiring
mappings in ascending order and unmappings in descending order.

The tegra241-cmdqv driver can apply the rule for a mapping in the LVCMDQ
allocation handler. However, it can't do the same for an unmapping since
user space could start random destroy calls breaking the rule, while the
destroy op in the driver level can't reject a destroy call as it returns
void.

Add iommufd_hw_queue_depend/undepend for-driver helpers, allowing LVCMDQ
allocator to refcount_inc() a sibling LVCMDQ object and LVCMDQ destroyer
to refcount_dec(), so that iommufd core will help block a random destroy
call that breaks the rule.

This is a bit of compromise, because a driver might end up with abusing
the API that deadlocks the objects. So restrict the API to a dependency
between two driver-allocated objects of the same type, as iommufd would
unlikely build any core-level dependency in this case. And encourage to
use the macro version that currently supports the HW QUEUE objects only.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h        | 44 ++++++++++++++++++++++++++++++++++
 drivers/iommu/iommufd/driver.c | 28 ++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index c98edfce5081..563bdd30a8bb 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -251,6 +251,10 @@ static inline int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx)
 #endif /* CONFIG_IOMMUFD */
 
 #if IS_ENABLED(CONFIG_IOMMUFD_DRIVER_CORE)
+int _iommufd_object_depend(struct iommufd_object *obj_dependent,
+			   struct iommufd_object *obj_depended);
+void _iommufd_object_undepend(struct iommufd_object *obj_dependent,
+			      struct iommufd_object *obj_depended);
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id);
 int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
@@ -259,6 +263,18 @@ int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 				enum iommu_veventq_type type, void *event_data,
 				size_t data_len);
 #else /* !CONFIG_IOMMUFD_DRIVER_CORE */
+static inline int _iommufd_object_depend(struct iommufd_object *obj_dependent,
+					 struct iommufd_object *obj_depended)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void
+_iommufd_object_undepend(struct iommufd_object *obj_dependent,
+			 struct iommufd_object *obj_depended)
+{
+}
+
 static inline struct device *
 iommufd_viommu_find_dev(struct iommufd_viommu *viommu, unsigned long vdev_id)
 {
@@ -298,4 +314,32 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 	 BUILD_BUG_ON_ZERO(!__same_type(struct iommufd_hw_queue,               \
 					((drv_struct *)NULL)->member)))
 
+/*
+ * Helpers for IOMMU driver to build/destroy a dependency between two sibling
+ * structures created by one of the allocators above
+ */
+#define iommufd_hw_queue_depend(dependent, depended, member)                   \
+	({                                                                     \
+		int ret = -EINVAL;                                             \
+									       \
+		static_assert(__same_type(struct iommufd_hw_queue,             \
+					  dependent->member));                 \
+		static_assert(__same_type(typeof(*dependent), *depended));     \
+		if (!WARN_ON_ONCE(dependent->member.viommu !=                  \
+				  depended->member.viommu))                    \
+			ret = _iommufd_object_depend(&dependent->member.obj,   \
+						     &depended->member.obj);   \
+		ret;                                                           \
+	})
+
+#define iommufd_hw_queue_undepend(dependent, depended, member)                 \
+	({                                                                     \
+		static_assert(__same_type(struct iommufd_hw_queue,             \
+					  dependent->member));                 \
+		static_assert(__same_type(typeof(*dependent), *depended));     \
+		WARN_ON_ONCE(dependent->member.viommu !=                       \
+			     depended->member.viommu);                         \
+		_iommufd_object_undepend(&dependent->member.obj,               \
+					 &depended->member.obj);               \
+	})
 #endif
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 887719016804..e578ef32d30c 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -3,6 +3,34 @@
  */
 #include "iommufd_private.h"
 
+/* Driver should use a per-structure helper in include/linux/iommufd.h */
+int _iommufd_object_depend(struct iommufd_object *obj_dependent,
+			   struct iommufd_object *obj_depended)
+{
+	/* Reject self dependency that dead locks */
+	if (obj_dependent == obj_depended)
+		return -EINVAL;
+	/* Only support dependency between two objects of the same type */
+	if (obj_dependent->type != obj_depended->type)
+		return -EINVAL;
+
+	refcount_inc(&obj_depended->users);
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(_iommufd_object_depend, "IOMMUFD");
+
+/* Driver should use a per-structure helper in include/linux/iommufd.h */
+void _iommufd_object_undepend(struct iommufd_object *obj_dependent,
+			      struct iommufd_object *obj_depended)
+{
+	if (WARN_ON_ONCE(obj_dependent == obj_depended ||
+			 obj_dependent->type != obj_depended->type))
+		return;
+
+	refcount_dec(&obj_depended->users);
+}
+EXPORT_SYMBOL_NS_GPL(_iommufd_object_undepend, "IOMMUFD");
+
 /* Caller should xa_lock(&viommu->vdevs) to protect the return value */
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id)
-- 
2.43.0


