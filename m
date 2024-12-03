Return-Path: <linux-kselftest+bounces-22788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F34169E2EFC
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 23:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53727B44019
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 22:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D4320B7FB;
	Tue,  3 Dec 2024 22:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JX7pUGDX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8939520ADE3;
	Tue,  3 Dec 2024 22:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733263867; cv=fail; b=bg6AeMyxq+u3ACbRNi3q3P/Kk4a21HuJ0/H9i5TiSDNWpmhThYlT50dRgs99DHSfWZOUCknFfkphaiF/kOeV/bVx6I9s9DUTsC0OwDkUi+Kygga9m9MfbWzf8ZZcryCxhRx0VvBexqZy7AZ3rh5YMWR4ELT4XRIboCZAbpEUuco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733263867; c=relaxed/simple;
	bh=Nha40DaDofJn4iEEDWXheHROxUAYdUBXCi9vbUTisTQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ax2/eqHy93KGuTQkT7nIkymQJ9wYgcEEumeHgHShTx2KI/bbs99cgQh4omZlBnlUbxIcp5s8dTbJb+gsg6JUeE0uLtakA8gHIiwbwNti2z4/5bDzA8piB6f3h4uRO6hilTUQwhmXURf5DRKG3dREk5cMzUtWgBUOa4ggr9BrNzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JX7pUGDX; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXWe3RahJdkHBLQBcCmuvx+77l+CTb7z77Kg6QFouclmywSnZdgY0p7oylKgNMva0MejWTmPzdDaCbTyd/5EGz9dUjryp9Fe7iJZGOABTswBIRHepoUT2buoS6IbL6kJFAsKp6y2Zh3R28xrs7Z8jxgoxkBwuQ9HIf995fFHhqjeAPEVlGRh7Q8xoFt/VBzfy62+c8OhgBJPvrpku46s17bbqelQjIgEiZ4DUyweKRZYdxB1S7oj1csqfFn8m9hutI8vD3uC+mSHg60lQ+Ux+LyxXcMDxTqvtRtLnhlC4keUIsJQBNKzztqymIl2dp7//95Z0j6jL8tE3TddapWl2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obMyJQ42mC+PmQHcG1ivSAWlOiM+/BztEyoGttJbdvE=;
 b=jpEZlE7k9c7Pcn7+upO5ndA7COEyjlbwBN8FMUURD/3OC06NanBYnrZAGsjBgiFEL7nwxA4cAUoEPqBJeMReevoOmkM4QXEaNLRlxej8AvE9Y6BFudf/QYqMOsEgs08lLBoT/2/aRN8yfnWAPCWAzQtoom0HnjOWoaYYQ3ChMNqe8Zz8itiagP4NtfHFsrrcO4mTPQbyxdbjOVk8fRMuWKqfjagv8xzG+3UBETRM4f+TBx2JdHaSW9R2Zbm+xO2/aau9IR5L2+mi+1lQOzykNV5NboLICB+ISkmrUGUQh+XVvzb20rG1+bLB0oAqpSfdMmGJw9PvmZL5umUJa8zgBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obMyJQ42mC+PmQHcG1ivSAWlOiM+/BztEyoGttJbdvE=;
 b=JX7pUGDXc22KRVouu/Bm2yVj59JJrM1O9AdjQzz0F6ghak/IsL2XiGzh/Q1n1iTjEVAw4gXodvbFEvSbG8UssMLkKA+ukLs3rpLplctmUXAK43AoosupSpsvC48WGiWbfFdk8zHeYwvmX+E5Frmrs3rsPL/YDKMspkEe5mEGPyWz8ERCkXozoe8L9oGzj4Hnaq98LChMk9OLHxzwe/znr8MA1euNWhBOjwYvkv/cuW5ypKNkMPDiPHVur6QfUqxx/QVWnM5DWMpAx0ojfxcw/LnDmsAGGqrIlv6B9dlpbtXyP7GRNM43lDpU3M4jCJnbtBcEOaWWWAy7Crc4GORn/g==
Received: from SJ0PR13CA0059.namprd13.prod.outlook.com (2603:10b6:a03:2c2::34)
 by CH3PR12MB9027.namprd12.prod.outlook.com (2603:10b6:610:120::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 22:10:59 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::cc) by SJ0PR13CA0059.outlook.office365.com
 (2603:10b6:a03:2c2::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.8 via Frontend Transport; Tue, 3
 Dec 2024 22:10:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 22:10:58 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 14:10:41 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Dec 2024 14:10:41 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Dec 2024 14:10:40 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <corbet@lwn.net>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>
Subject: [PATCH v2 06/13] iommufd/viommu: Add iommufd_viommu_get_vdev_id helper
Date: Tue, 3 Dec 2024 14:10:11 -0800
Message-ID: <d1e5f16d2fa4e9950e9caa93c5f98a5115c1580f.1733263737.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733263737.git.nicolinc@nvidia.com>
References: <cover.1733263737.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|CH3PR12MB9027:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b2e817f-6c61-46fa-dfc0-08dd13e75dcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5gyoL8X1VNRoQKE9ytdDpYVaQZXXYspyft9D18LzFUqCNqn2G+IC2KIpseg+?=
 =?us-ascii?Q?fRi2hHqVD/z/dlKi17iQLlHUVYUqVE1QW6LgN/vvhdoaUGTlqoycYpImZnmY?=
 =?us-ascii?Q?95ZO23/nD9y9F9OJB0M1FCVmZgq/khWhSfrSKsUAyUpmk8WQUapXCLeLnT+T?=
 =?us-ascii?Q?PWVc6WBz/+81fqbOujJhoiWg7syCmj80PnLlDlkbEsR+Dxt6MQojZ86huql4?=
 =?us-ascii?Q?SupDVrJGZTdIlr1fc7rCUaXme7oiPDMw9Halr+U0Uxzf4guQJ3l98Ne9ZzF9?=
 =?us-ascii?Q?8iDMkXL9nbvYbbs3MPchgyDpXvFRaA52anPgNnj42nsupolHNBfjlE+mgdxv?=
 =?us-ascii?Q?D+lYNxGH0/AhE5Nwe0syGbhVEv6S6l5jZUgF1b3SXzv7QNDZolBy4rk+gXK5?=
 =?us-ascii?Q?eCeh8Sn0dTsTBbvHX4bQ0lTV5thwtvKkayY5FG9fVcbLtUCYkoFoWlsTiDVg?=
 =?us-ascii?Q?bQq7dVgpdq73qOA7abkISs6nbpKzfR4R8938V4bvt4KSmFq+pfYvEGSc1A8R?=
 =?us-ascii?Q?bgoesG9AyHglcZp7JTSwF85Yy9XX3nXIFyrfXzyI5MsdLkX+UH5Clzv1FZOs?=
 =?us-ascii?Q?WvcIa/Q+cCo3h95yanLvCn90WpkR/T58HWNObK8qLdxthgtkbaXWcvZZ+jz0?=
 =?us-ascii?Q?KhkPSK4EYtjN0odKbw6T+LZIrHsmopOzwc/EP6CXzro7N4p9xXznPF517d1o?=
 =?us-ascii?Q?Pn8Q2CyyziTVIVNZz11fP6jZ/oWeLcmkUsW8UINu94s2GDTGRLzhzlWmW2vN?=
 =?us-ascii?Q?vmhN5f+t5V/EkKRz8yztBYT3no5eYVMIw7LQCHtn5pJfUo2yWiDdN1NIp7mh?=
 =?us-ascii?Q?CNPWODONfJpd96avvgRqTVjh4Ium66euergJ+OENCBPk2cf4gQR6jKQRqcJM?=
 =?us-ascii?Q?aMFeLC0K9yL+i9s0VIWi7DwxMv/YIL4EdJKo76ciyGzb/MvC3TxwTHFdfArC?=
 =?us-ascii?Q?hVIo0Von5OcElLGXKb1a2conyLbyDoBIab0P14p6B4qt0AoJ+0eZ6bDSxQU8?=
 =?us-ascii?Q?8b3zPBNTPvfhHp8uefRDZeHF5mWoFqzjNpGI4FqKU0OG0EIEtKqluDZcw+Vu?=
 =?us-ascii?Q?tvOAOHGLgKyLIuP+SDjFJVGkRdujzuH2szszvYDg6azVKyciC/ReMEJUVMVM?=
 =?us-ascii?Q?1cOVbY88btyh0/22jBtvOwSUzFAmfU7XZGHo/CLjxbokYJNVZ+8QgnPeKBMm?=
 =?us-ascii?Q?nUjPoBNNgeW0RaijYQ/VhepCPIwJd9oJ4QlqBDcsqsTKC7+XqbebvsuG3Oep?=
 =?us-ascii?Q?AV5HB8vfuxcwO9in14K8dL+CajqNNXV+53YzeQRVP4119894qSKcugAchtP4?=
 =?us-ascii?Q?f3jwy7ykVIW8GHOtUD2b7uB7LZ+/rPq9zy7a9UNuI9ePj3t2aR9+XvuaknyH?=
 =?us-ascii?Q?0hDPeVDShycZE9bts5H79X7jNYvKZR3Tk5fnKfA6wCiXOaYEj/c/FBoxWJTV?=
 =?us-ascii?Q?U5hdqN6sf8U3EcT2MUERpcHgQ1dnHSCb?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 22:10:58.8337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2e817f-6c61-46fa-dfc0-08dd13e75dcb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9027

This is a reverse search v.s. iommufd_viommu_find_dev, as drivers may want
to convert a struct device pointer (physical) to its virtual device ID for
an event injection to the user space VM.

Again, this avoids exposing more core structures to the drivers, than the
iommufd_viommu alone.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h        |  8 ++++++++
 drivers/iommu/iommufd/driver.c | 18 ++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 40cc9bbb1d24..1f5376476cfa 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -190,6 +190,8 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 					     enum iommufd_object_type type);
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id);
+unsigned long iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
+					 struct device *dev);
 #else /* !CONFIG_IOMMUFD_DRIVER_CORE */
 static inline struct iommufd_object *
 _iommufd_object_alloc(struct iommufd_ctx *ictx, size_t size,
@@ -203,6 +205,12 @@ iommufd_viommu_find_dev(struct iommufd_viommu *viommu, unsigned long vdev_id)
 {
 	return NULL;
 }
+
+static inline unsigned long
+iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu, struct device *dev)
+{
+	return 0;
+}
 #endif /* CONFIG_IOMMUFD_DRIVER_CORE */
 
 /*
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 7b67fdf44134..817e430a11bc 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -49,5 +49,23 @@ struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_viommu_find_dev, IOMMUFD);
 
+/* Return 0 if device is not associated to the vIOMMU */
+unsigned long iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
+					 struct device *dev)
+{
+	struct iommufd_vdevice *vdev;
+	unsigned long vdev_id = 0;
+	unsigned long index;
+
+	xa_lock(&viommu->vdevs);
+	xa_for_each(&viommu->vdevs, index, vdev) {
+		if (vdev && vdev->dev == dev)
+			vdev_id = (unsigned long)vdev->id;
+	}
+	xa_unlock(&viommu->vdevs);
+	return vdev_id;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_viommu_get_vdev_id, IOMMUFD);
+
 MODULE_DESCRIPTION("iommufd code shared with builtin modules");
 MODULE_LICENSE("GPL");
-- 
2.43.0


