Return-Path: <linux-kselftest+bounces-21182-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7637E9B6F6A
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 22:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96EE11C227C2
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 21:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA5422CC6C;
	Wed, 30 Oct 2024 21:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sR1g/Q3v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9EB22ADE5;
	Wed, 30 Oct 2024 21:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324179; cv=fail; b=EqyO6oeQqBM5S6WNIPst+BE5PB41DENUsS+ZOT7ePr7IHZNK6cCTBpqn6Zp1suQOp0QAD+pAIkZM00RVoFMnmm6GnQhHO4DtdKHoDTBnk3S0efYoDcuJjycX9rHgntUwxv6i6AXj/n2jNPZhtw6tEcIztRQaZlRw0UEsJMbgc3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324179; c=relaxed/simple;
	bh=qwzrYXDf0Dokp/OPBod3T9V6cUpFYqpTV22PWO16M8w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yb4X1uVL9DZxPBTu5d70015NT3R0Pu8Xq1sORCe8ZVAaNCzmUhcVznCSf2IH6ZdEk/qe5u5WIu8iMrM9KlrwnuLdLqXht0NJIkLcYvwwipHb8g9KFWBVU1A2BraIQp8LOxe+TNEvNxnitUb8mpJUYZ2DN7vCg3nugdCbMzSRJAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sR1g/Q3v; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K50zap0xmIhndWhOUn2CLNf5LuUcFdVc6w/lkUsvhqzwRUGehlvtk9PSgIMrby2ubU/q3uF/a6FHLdzidoUgRqNCAePbA4Pc8dbaimmiCLtUnQRvFh1xjUHkDESud2E3hb37N3lgOy2K8iVhJTldCqwIAvR/g5k1Z1YGbbich+TfaulKQ0M5yfMi/MbXFslgC06hllBl8TG1Fqj4wwh08sgoZI7MzPS5wCkLY3DPnLPtYJlAZ52yVa/ULX1IbAokC5SeO306mjbaSkht9mbigek03entyC08EACIOghEbR6EuqJP+c1HmCUOreHFQz4I2A/pYnrNbSVpjgPj9GIcww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n59SrwhwEDXmwe+pKSsglBRRe7iDjrUPfJoYe+id9Bw=;
 b=QGJgRrVHec3G0j5mkK0V44Hb+Me6YKa3QR18qozmbvsrUrriIbKpFqRfqhzKMcyvOBSIzP2mekqzJKM6O0ymod4QEpZ4tKszcxOkHhI19GRFXjobAlOJ3et/hxc7UhU1r0y94I0LF0jbamPrZpQytkwDphxiOPP2RAZl/kqFeKXz9MC/VpqfzYGuzFSW2qI7sJ7bYDxQubuPobbtqSL0BrSr4s2dsCAZNYcJ99hmo7dxqcqxaZabqBklSMrmcS3RgCJpgtEB8r3cCt5Mdw7kNujxHOiQ/Fjudm/O/uJrA84BjKNyD66pcgYTsruz65rpCcgnEeHTfrv7VvAia/3sJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n59SrwhwEDXmwe+pKSsglBRRe7iDjrUPfJoYe+id9Bw=;
 b=sR1g/Q3vR0Keeoh7eB3/Be8z0Za1DnGFegwPNyLeNnoK61OFurc4/RterKYXCJ1F1EBLmKz4t7LLTWNuGo3DfxtEwdFpQ9snhNTMbdelH3vScJH5wEPtC5nGUNUv/OOujJnhCds7Oj0GOh4Xkw4sTZgct7WUee1wsAye1wIwQs1XxdAlDztuZGdi1tD0V4gMPfGyzZvMa0d6PRc2jPkClnL2YnVVRGmwDx/z/UAorJnbxFqRk2GPYpwAcK0pDGNd9m0yxpcDHx8AEzUQ2+ZgrfMt1A9dg+qWdKftkx/26PIX3puElZ41165xmQpkG1Tjf4+mSG18/RKWrQodiZ0x8w==
Received: from BYAPR02CA0014.namprd02.prod.outlook.com (2603:10b6:a02:ee::27)
 by PH8PR12MB8607.namprd12.prod.outlook.com (2603:10b6:510:1cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 21:36:13 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::60) by BYAPR02CA0014.outlook.office365.com
 (2603:10b6:a02:ee::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Wed, 30 Oct 2024 21:36:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 21:36:12 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Oct
 2024 14:35:49 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Oct
 2024 14:35:48 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 30 Oct 2024 14:35:47 -0700
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
Subject: [PATCH v6 06/10] iommufd/viommu: Add iommufd_viommu_find_dev helper
Date: Wed, 30 Oct 2024 14:35:32 -0700
Message-ID: <3f0240cf9f2169750d929ecbc8cc658ed5bc3734.1730313494.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|PH8PR12MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d3de943-6d18-4520-d9fa-08dcf92ae06f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KWunIye4XY5HiKc8oXrfwbU+YlLWg7M6fmjdsdS5H2eIR2OG8HYbFuc4yUT6?=
 =?us-ascii?Q?HYdnFrxA6m91SKEmtsei7OGW+phsc8DNAIsEiyV02+lp2cPWFGmv4R8xBxIp?=
 =?us-ascii?Q?Khe6zYtXXlBOkhDuX89u+qizEjELT7sp//5dxfZBszuIy3mKIv5JX/Abggph?=
 =?us-ascii?Q?cfxzPUMGdd+5RBu0HFcNvUj4Cp7tctL4Zj9KlOCcNGUhZBNKquQJbvQiuyh2?=
 =?us-ascii?Q?wi2BcKW2iS4Dl2bFp9QGmxSh52Y6QsoKNTg8l4up42t7nMnp563FHhxHqHHW?=
 =?us-ascii?Q?w0sOpK/oGXiohS+HyLk+MnW8lOG6f/tvsJYtXJMv5CAke71cu9lfEoUOFYCz?=
 =?us-ascii?Q?PbV4GAagL+g0YsouIhPnsYuY+shD/wQXBKGVG1jegCMo1IU/JGBeo/FhCe+D?=
 =?us-ascii?Q?Qc2wqVAKZ2UoF38oKYbg3PMG03SJ8ygbP/wUfCfrVnHK8Vj1l6CcsIYbqveQ?=
 =?us-ascii?Q?jpb7hskOrSku8rEL0IDq8Oj7oiRCh1PakzA0GndnIzThljG+FtdUciDwRJ6S?=
 =?us-ascii?Q?P0jLw4k1uMQM1my1XTqtkILPHZKQqxUu4Rm37SOg3ZFk9qgtBcLV3K2Wcekw?=
 =?us-ascii?Q?r0SOzQEuuowmT/PwNuE+8WtrrTlOft8wC6rYGkVyCJduwpOaoyH8sUcAQjGZ?=
 =?us-ascii?Q?fu6Xhlnq6f9KMB+3y+pp3SbphTzEqBVxTyUmH1cAObgk9B/uUH2Ok43LfV2M?=
 =?us-ascii?Q?Z5YPpaLv4EepwuTRP5uKkwhYE/jLsFMk0LUvlSfmAVGOnJc7tTBP6mlFhIz0?=
 =?us-ascii?Q?RpVcRvWHvLAXctGQWf8Uq+gbVIJKw1iv5NetFnmlAn/a1qg/sOOqn+RmedWx?=
 =?us-ascii?Q?LRnlhUbNNfMJAbI7kKkueG2nF56AIeNaNJ7fdx2CD9IIGjWdPnyOd8WoqL6I?=
 =?us-ascii?Q?QMSNlWzPzb/XZGDK4HESXq4u23sCbt01jngpxf0fYrC2gfeQSMvnOHGzt+Nl?=
 =?us-ascii?Q?Al+V0l4Iwc+HsQjlbF2hCihfsPiusBzOIp/TfYZPKZizaYl2uJtQxUt9LiVM?=
 =?us-ascii?Q?7lgqnD/x/PhDp0uD3kRZH5UrAb9VCWxBMadSXYa+Ju1zs2WTxTj9BWJ/UMfr?=
 =?us-ascii?Q?FypMeNqGYtMXYN1rfYc2BnFQ6QYXONLQJYoSpzpISuehM40D8nCwvVAbOIV5?=
 =?us-ascii?Q?+hn92M7M/63wfmPwpxio4NtEoFLRtRFPTPdAZbMjdSeTxIZimcZvFJb14gBy?=
 =?us-ascii?Q?ECqfkjq5HVLNPNBDZf6+BOUHho+Unynr7LJxU67Wujdj5c8NibqsNnkRQuiA?=
 =?us-ascii?Q?kukZMGpmoF42PyXLvoEjZOZM/xp0bN1G+eOynoh6edzqOa+wIL7g0dRnMVKA?=
 =?us-ascii?Q?8wL+sVcWQMI4WuMXroSSBLxe1N4Ocy4S3Vjwxozfke9BmYqrTAef+goST1Ua?=
 =?us-ascii?Q?OIPEaMpsgSo3773RiSJEEk8DXPlIL4pZhSeRpgRK1Wuf0Gv2Fg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 21:36:12.8199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3de943-6d18-4520-d9fa-08dcf92ae06f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8607

This avoids a bigger trouble of exposing struct iommufd_device and struct
iommufd_vdevice in the public header.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h        |  8 ++++++++
 drivers/iommu/iommufd/driver.c | 13 +++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 4e59af87a524..d263bd9fca6b 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -142,6 +142,8 @@ int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx);
 struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 					     size_t size,
 					     enum iommufd_object_type type);
+struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
+				       unsigned long vdev_id);
 #else /* !CONFIG_IOMMUFD */
 static inline struct iommufd_ctx *iommufd_ctx_from_file(struct file *file)
 {
@@ -189,6 +191,12 @@ _iommufd_object_alloc(struct iommufd_ctx *ictx, size_t size,
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
+
+static inline struct device *
+iommufd_viommu_find_dev(struct iommufd_viommu *viommu, unsigned long vdev_id)
+{
+	return NULL;
+}
 #endif /* CONFIG_IOMMUFD */
 
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


