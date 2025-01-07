Return-Path: <linux-kselftest+bounces-24018-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CB0A047C1
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 18:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBD2C188826B
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 17:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DA31F4735;
	Tue,  7 Jan 2025 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sm42v2VV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B91D1F708E;
	Tue,  7 Jan 2025 17:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269870; cv=fail; b=n94yp7JuJigbUbUIXpViPG6qNQ4s7ANfPSsXyiRHISCYem/cvnsOFDtE8geabnKX5a0SHDKXDKcJ1JBL7J4NY//VTdA74kJtJgDx/4lhOcrm8oloLsFfhvlUAtrI6oNf7IpoMt34Km6jh+2Fg11OLG3C+GRcwXAehDpQVFk91uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269870; c=relaxed/simple;
	bh=aE5yjVO7meB9XwPIi6mLL3eVxHWUemX4ADqO1hfVfYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHijF8QRWlclp103zufRM4PifKBsEvxvb+NnVVNJ+3F98Vk6Rc9Nzy+iA3uSGh+53Otq1g7VJmfIxlVOoj9BwZckrfzeDCdvDjPCUuARVhjWzPchSEkK9wXPqTeZQB+1ShM8bQHwdI20rjLgaLE5sbwzvcLsmXc/nNSzxJPikAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sm42v2VV; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqHtt7cZgnGAc9fHSZb2K/3ksyj6htH/VphnY2mM1a2+Vk89cywghCEoGfVPGbClZj+2Ynu32BvfCLl/hQl4hP36mthqrJexMwfY2Z2S+oIqjCm3eaKu+Lg2KGj8BESLrZMqnqr0iHpzC57BQczsU8aqtenC507yITMk45UWovjUGVRnoChCGaANrw+xVK4V3qYCiV1KEVjbwOUGuzvt2hKPWjATB0oGO0Bwki7Iu8uwTGcqJE2aJp9NWjAmkO4evTvPiDsrxH6r2rlFy/51wm6if5H5405Ic3YoJqHcgvahJ85Vye0xNbqCKxAoAeksgB0cLj1ZxXXBgB4G6lPA3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERSMdPLo8m0QzzQ6QnVP2SGUYvy/03JE9NWR4O6wxj0=;
 b=HPCjawIwz9XnWXRKS1pP9fcciZK9LNlzL0u/l9d7IrPss6Amr6B9Jumrtyz8VKzS+cviCMLrqmMjSnSa4uvF5bigzR0Ul7pXeVL5QEByDUhG/w8qoLj+xECPM0nqehzmR7yKnNMuFtnGIpUjEnxZEtfuSPK8KQwszf8D4u6asi7KT85OSGF8+nuZgD9eXVC8/z9kW/PqO8G0WCgA6GkpwYhsZCWdj+scuoIMpRzunCmJ070FeseY7YoAjxFh05ayV/jWzY+GiaURqFuv9P49V2FAv9LhH7YjJ8rN/fg3Y7L2YhyQ9ZAr+PqSu1GFso1Z5Xjvfe1OPdadztwJyfqUoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERSMdPLo8m0QzzQ6QnVP2SGUYvy/03JE9NWR4O6wxj0=;
 b=Sm42v2VVY4ulR57dBTSo+Mp8WA0GkvD2FHxhx3q+8WuzbPF0xJbKKYYfrk8Dk9X/nQTd0fv7Yw8mQzGEXNQFUIMrhzF8L8Mk+9g4tzCGYeq1MF0CWocXnn02E2HEhMRKJ1sHgH+5q7bauPz1yLATNNpKuLXpXEqJ1pzm6rGm00UQAz6yoszV4dwiJ8XrXTAXWXr5R2gJxJjZm7DKcdhtzZV2FC8BbapUg+2f1yIqClj5lZb7VuCjJTi8oJKNwKb6ygCh+8LJKo73k6S5qF3Spk82eiwnlyMslb8yNmX+T21jHdAAtK1iLPlnTbkyDgcuNQFZH4hQtE0KlcHwOlropA==
Received: from MN0PR02CA0020.namprd02.prod.outlook.com (2603:10b6:208:530::31)
 by CYYPR12MB8871.namprd12.prod.outlook.com (2603:10b6:930:c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 17:11:02 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:208:530:cafe::f) by MN0PR02CA0020.outlook.office365.com
 (2603:10b6:208:530::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Tue,
 7 Jan 2025 17:11:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.0 via Frontend Transport; Tue, 7 Jan 2025 17:11:02 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 09:10:45 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 09:10:45 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 7 Jan 2025 09:10:42 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: [PATCH v5 07/14] iommufd/viommu: Add iommufd_viommu_get_vdev_id helper
Date: Tue, 7 Jan 2025 09:10:10 -0800
Message-ID: <1dc30375464927950e12a5a52ed0433c3b01b8d6.1736237481.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736237481.git.nicolinc@nvidia.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|CYYPR12MB8871:EE_
X-MS-Office365-Filtering-Correlation-Id: 0acf61c5-feaf-4123-3337-08dd2f3e43a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cUlKZvPFPPuc8M0/JNfV/6ypkHjUrL26W6pYVmBKzX/KE3qU0mqS2Vv8wbQD?=
 =?us-ascii?Q?nkx7p6H1x936Ip5P3VkwMsio5zNCB3aEmbfWI1UO9vC3EQPOLnmmtLuqE7Ag?=
 =?us-ascii?Q?+Ek7NQNKvr+5uLrQveJUM03xw3q43++437nCExdzkHweMWrPRd5HsyuWEq6D?=
 =?us-ascii?Q?erjF1e02tARvjqh1wUBs3XATqbxcSPcWtreP62pflwqSDfmI6WhCa8Rx2PBP?=
 =?us-ascii?Q?8DDcKvG94R/sCJd34jHJJ80Pw/Lcwb1TWzpF86fWrsyurK1D8/6b8f2ItZvw?=
 =?us-ascii?Q?WimcZyZg3BYvCriiTFo+/zdXO+khws4Xr2FlFtqn/2IAi9kMphkGevZyyswt?=
 =?us-ascii?Q?ud6HwaQA/wsaF84XarJglYPkXkmR144dh6TqZ5MZowZLUOzyEr4t4z2YA7u6?=
 =?us-ascii?Q?uerXVZtc9jQE/6JvC2H4b8p5n6ASSfwQOdOjj9WUTFr7Tap73rWDOqWc536V?=
 =?us-ascii?Q?gsQ4ERx2I1DOkyBNtE1x+ubukvmEIhRgluTs3/4lOVuM5CpEatcdcds0tK+/?=
 =?us-ascii?Q?F+a7tcubAwIFXMoaUil8s6GndPXT3SpBl0Izu10z12NiVteK7d2fASZG9g7i?=
 =?us-ascii?Q?pE8MGPLPg9Zuz8mFrS8+Fh484vrMD5MAvwwY+Z78bv8WKJUs+H/vwAWJMtNK?=
 =?us-ascii?Q?R9A+0+q4wH9/J4YiLcXJQIj5JaqQFkPZdv1ORSoGKQZo2csUu2c5HEvlDAC4?=
 =?us-ascii?Q?aCbYGa50aQvXKT21wn3ImZHNlPdUnu+GeH60FwRAa3ZVkYUONC6/B/0t29Nm?=
 =?us-ascii?Q?vhUFfCZ5SaS7xjDhMVldDe20eZIRNeEhK7pdrKhzAT4uVWQt9w/OHdGxnEpM?=
 =?us-ascii?Q?MZn5FMqN+zmSj+N077xx4wLZgHvWe8QI/gCG6O9jNxse1jlKwM5dZyGWEyL0?=
 =?us-ascii?Q?fG3SPyM3liJ14ADmfMWBs3u4aVZ1cQP8OQTya6WaBW9ip+NFTELFoXyTw/R1?=
 =?us-ascii?Q?B6Hy5u9GwZSgvaZeaTGOXvHYTKgz0Dcd2jaj2atKTsRNPjrpdwEPrWqwhfYq?=
 =?us-ascii?Q?+wPPLUYeWbrSNfHOoB/5/izB6LTYzOdT2EVWfFpDDm69lMprxPPQy8arAaq4?=
 =?us-ascii?Q?R/4OU/iHThjq2fL3Oa4a0fd+jYzlfFdOtvFQDMZdZ+WuCUaiNzzMFWucPb2h?=
 =?us-ascii?Q?CDqoRp8LkLlkLbLs4MPQwoCl0JLsqzMFTg0Jrzrew6/uZwK3W8rhZmhvHyd1?=
 =?us-ascii?Q?OgXTNOHZHsD/LGUYHKRONPUMutmUcPpr6zk7fR3VUse7be+uGjYj6OMfwjN7?=
 =?us-ascii?Q?BbdZi1akXxmfu7TjEgoKoLecPypRjW0nDqUqWnFxflv6KeVhj4pL0GU8CPic?=
 =?us-ascii?Q?yUg0qkhwAhYHHPhZRa/pPxA/otJBluBNgdrmMuT3P05QbLgRR/srrqoofme9?=
 =?us-ascii?Q?CvXsnsZKPFDsFHu9pZ+66B6T6hDf7Mmw4Kk69RYCw7tJgeqTD8dFwrrSUgSz?=
 =?us-ascii?Q?x/HnXjiQ1GQoNWP+LKZ5SWf9/OlIpkhpwAYLoZT7NSc6XtWriwHBtMTtIKlb?=
 =?us-ascii?Q?nztdLCj2W1hSJb0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 17:11:02.3497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0acf61c5-feaf-4123-3337-08dd2f3e43a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8871

This is a reverse search v.s. iommufd_viommu_find_dev, as drivers may want
to convert a struct device pointer (physical) to its virtual device ID for
an event injection to the user space VM.

Again, this avoids exposing more core structures to the drivers, than the
iommufd_viommu alone.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h        |  8 ++++++++
 drivers/iommu/iommufd/driver.c | 20 ++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 941f2ed29914..a6dd9f8edcf3 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -192,6 +192,8 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 					     enum iommufd_object_type type);
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id);
+unsigned long iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
+					 struct device *dev);
 #else /* !CONFIG_IOMMUFD_DRIVER_CORE */
 static inline struct iommufd_object *
 _iommufd_object_alloc(struct iommufd_ctx *ictx, size_t size,
@@ -205,6 +207,12 @@ iommufd_viommu_find_dev(struct iommufd_viommu *viommu, unsigned long vdev_id)
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
index 2d98b04ff1cb..e5d7397c0a6c 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -49,5 +49,25 @@ struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_viommu_find_dev, "IOMMUFD");
 
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
+		if (vdev && vdev->dev == dev) {
+			vdev_id = (unsigned long)vdev->id;
+			break;
+		}
+	}
+	xa_unlock(&viommu->vdevs);
+	return vdev_id;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_viommu_get_vdev_id, "IOMMUFD");
+
 MODULE_DESCRIPTION("iommufd code shared with builtin modules");
 MODULE_LICENSE("GPL");
-- 
2.43.0


