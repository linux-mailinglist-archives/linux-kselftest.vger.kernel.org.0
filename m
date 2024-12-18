Return-Path: <linux-kselftest+bounces-23485-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E9C9F5E14
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 06:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A09A1188FE46
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 05:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D174A158D6A;
	Wed, 18 Dec 2024 05:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HFMCFiGh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B16158208;
	Wed, 18 Dec 2024 05:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734498110; cv=fail; b=XXiiCd/GKbP+pIAtwIPAyNVaMZnQZg/Px0mUpWk8zj2+AlSwxTC4utwi2SGhFBnHNZ3tke2mbo4ej/CVSw1GuZUVT+gi2fcAeM2jME+Do7e6Qy2x0HbPhGoXI6fRmTT+ohl1EcRUYCgbRwhd1NsP0MHh/++vJ/KjFwUZSSPieQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734498110; c=relaxed/simple;
	bh=45sk1B9ywada71xFoDEX3z/mZGcr1araz8cMRy61VyM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DtT9CylKkssD3Hh2WxTmclQl0lKqWVSn3Kn0hJKCUzkdhR7biGMY1DLTE8K3dVnwfleNpCqWbOZ6umch+bec5SVqUwobCvcwJ57cnVRlvvhc8kNhR3GkN7Fo0ZBziYLnPQwotkS7xGDMuPwHKrCT7oRjh7xZD0FaQvd/4BqGsk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HFMCFiGh; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENngtST10e1H0N6PigOD4T+OqDkuQElyE1rFC5SRUxsKuVYRdLjr4VoSlU/s7njUYe90NgOT7tW5jKUNtX+Lv+PWot0PIQ+CGKDqfmE8djAV5I/C1WfEiPe3PFNsZuQu25BE49crjIlARUdLL773rS4q3RTd9LfHsQugsWKYIwW7JqtCKFdOLPoCj8yJ30WnVFjkSIQmrdXEuvX5zGKfz4xOahbEta8zKDtPz2Bgc2xix1WHQLle29iPxBHTw4QentILsaUdw1+lEFuQ9jA/C/GuE7wkgIOPR1c5rL1obrFzH71yP/8eGBE0B5AGEhanuqjYYiVJ+VPlJP3032/MLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5E1rhH/gFc05H3vxrOJntu+IeiP0nCaX1BdHTnF4ZU=;
 b=AFG8bTQuQuT/42bm8MoRoTIMyyiYrLBhZoykheuPH7KYwYu0Vd34w5DrfSBuEuW45ru3M0W0psowCg4sR2GP/hy+y0OygGg7UpIHeO4/hTTGtD+G4wI+BFHNQs/UN4dY2A5HBeMd/YNkDXhMvmukRDeNoKAn5H2ORD/Zp6D2+/uFIclfSaxlxMI69nHsfISEE2tUCJcMCZ2O+vIgrlYFbjupqTQa1Kh8/m9Z8AqSu+6kjFkn2wtLdzPWn48pgwr1vgOQEPNv198LHE3HmSwX2FDtVxPkmNwOYhRyqRY2pkqhOZD87LLdcZy0/M7XwbLWfCil56WlRTkGlBRqju8m7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5E1rhH/gFc05H3vxrOJntu+IeiP0nCaX1BdHTnF4ZU=;
 b=HFMCFiGhhX2I5PlbIEssRMKzvxymW+llThJi3BObjp0XOKcxiBYDMNErwRhFXhVagtj9/2NdbI4eysow7cKSpQuu0ZMb+QFY0JSFD7b3JxtwU1fPGcK9A35gaoAOsgHMxuTfOLMkZsIFPkIkmquTJ5HY4DAlFUWHLFKgOK59HulpXFky9mxzIb0qohDXmyzxUGYwgE9bcHzvIOrwEAR2s9+jJkV9nKFI0qqKy1Pxd/1V02Qnv5/aDQ5jV260wUc5xmm+KwiYf46QHttG85qxQU2S+FED5BhOr1nItxqcPvCbi+INJbf5HTVRBHDoFjcqzIe9OCci3eXntVjlCKkNxg==
Received: from CH3P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::18)
 by IA0PR12MB8421.namprd12.prod.outlook.com (2603:10b6:208:40f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 05:01:44 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::ea) by CH3P220CA0019.outlook.office365.com
 (2603:10b6:610:1e8::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Wed,
 18 Dec 2024 05:01:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 05:01:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Dec
 2024 21:01:33 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Dec
 2024 21:01:32 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 17 Dec 2024 21:01:31 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <corbet@lwn.net>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: [PATCH v3 07/14] iommufd/viommu: Add iommufd_viommu_get_vdev_id helper
Date: Tue, 17 Dec 2024 21:00:20 -0800
Message-ID: <21d7e63b97d81d0acf9127418a67efe386787261.1734477608.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1734477608.git.nicolinc@nvidia.com>
References: <cover.1734477608.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|IA0PR12MB8421:EE_
X-MS-Office365-Filtering-Correlation-Id: 6100b00e-b8c1-478d-f0df-08dd1f211138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x4BIct2BF0H89XuJUwYe0WJEoyIlWlQYU28Su+YwwU3aClfp6Dgkp1m6JqlS?=
 =?us-ascii?Q?QJrfoVwWH0xJCAAaXi14w6TxZm9piijTLQHPm0E3zo0bKWESlW3pnKANEcx4?=
 =?us-ascii?Q?ZJX7eGi7kXs5bJqEa8u3EVe7ILoUisogVfoGNF0k9kAM2B4Y8OAdgePPXq64?=
 =?us-ascii?Q?btV9v7nrnQhY6Oo1ubSpwxv42mlndNflvC+UpWXRhEeSpPVsY0gXStGfWe6l?=
 =?us-ascii?Q?H1k7xZLvWrY0h1JHi2JnGNdreQbb9jcVn64WkJT3s0mjZaGrnScswJ8YgY4j?=
 =?us-ascii?Q?yvn0j+VdIWVbhbTFq6/T564HDMGj1u/Q0b/FUKl3Sye66bJG8C8QQk3mJ3Yt?=
 =?us-ascii?Q?JXGIeWerEjeNEDQEIIZX6GyNlwAtZ7Fv3QED4di0I3GtHaEE8uRZ0073WoU6?=
 =?us-ascii?Q?h1k/nAEmEQQJwnltKp1kJAW3oVn/c9QsdVU1gdsu9X/S+B+NLsHaOfa9wT4n?=
 =?us-ascii?Q?lI1Jb/vsQHxlLcSxXP0LQ7SIwx5sbZ6sZeMGFC59YmbrcWz2Pc2jjgJFKB/W?=
 =?us-ascii?Q?NBt1BFt9T9nJVJTdVLJzg1F5qbjWD0q0Se5mmhR328zcrJ/sMsUHwFPPfoLb?=
 =?us-ascii?Q?ArqcIL7K/iUoM611dtifeHH5gmIeZPoUD8UyIS+t+7Rvao0JU4QvEp6RzDFM?=
 =?us-ascii?Q?Ca9J8PEtdv8c01SKzwR1wUxukzUAfpk5F5G/X78og9o1WDGvNVHKYCDVdhMl?=
 =?us-ascii?Q?zAEIwfavNYkioVFKb6lkMFY5Aw9hbJaaqd+g01mEiyKoQrRyLijtTkDWlrRS?=
 =?us-ascii?Q?2KgHodJy0X5h/lRQfv+sddUVc6o80dSMPD0S+ErYD36r+LXDqDBl9F/UmD6g?=
 =?us-ascii?Q?HMNWCarQ00GXM2e1RBod6vNhAGd8MryRGJufk2ZNZLXaV/8IF2zXgcRz1hwv?=
 =?us-ascii?Q?3UjGrB1lTxwm3p0ilkIZxNI8EeSLy17W6GDVLKZVJ+G/Lm43OaBpi2nTn0Im?=
 =?us-ascii?Q?FlGJDtU9WfFIDZlimEeX/WY2iHOrlwomNo7Mb63dq8TVYidwRATc+G3mdBrs?=
 =?us-ascii?Q?oOW2fY1jTZtcwshYJ7dTBJmTk8RA5UK/jp0O6bg2i6WVl/V/+HNLxKmLY2M8?=
 =?us-ascii?Q?AZ83+pFxXK8OtjPNgVPTc5rGMYk7s1pq0I/nTXCGKbIiwCqxMeNBlW19FXIt?=
 =?us-ascii?Q?OfDZx1CUy4tw3Xr13g/fxcxqtpup9uLmPIbUz9SUnTKWUsmGNhaUDfz6VQCH?=
 =?us-ascii?Q?ylGMEOS2j2yOmQxD+N93fXmnpsmgcwrBIo0otQUUSc5HVXjB7+e+81oIMVcK?=
 =?us-ascii?Q?hkejGubTJwqCK4qJ+KKJAl1czWYKOTN3hq/r1LEwzvCT2f6sf7t0jLFsSBxj?=
 =?us-ascii?Q?SmcX3Bt9/oA6AEZTGbaCTvjP5a95k1WuwaWyfCR0LK9xP8OhBqPH+WFOZEuK?=
 =?us-ascii?Q?GoJCgMMQR4DZbv5gNGbj0wRmT3/9BhraFQS/DKpKpuB3dq1JJEXu6NIhbZk5?=
 =?us-ascii?Q?3ThKJexxnFTqGmLZ1bVF8EyKrB9sNlYjVc9raeQaECkZ9LjBv5eE4in2vtf9?=
 =?us-ascii?Q?O/f5BPqYvIgc6XU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 05:01:43.8554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6100b00e-b8c1-478d-f0df-08dd1f211138
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8421

This is a reverse search v.s. iommufd_viommu_find_dev, as drivers may want
to convert a struct device pointer (physical) to its virtual device ID for
an event injection to the user space VM.

Again, this avoids exposing more core structures to the drivers, than the
iommufd_viommu alone.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h        |  8 ++++++++
 drivers/iommu/iommufd/driver.c | 20 ++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index b082676c9e43..ac1f1897d290 100644
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


