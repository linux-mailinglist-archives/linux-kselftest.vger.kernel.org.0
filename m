Return-Path: <linux-kselftest+bounces-16438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9049614F7
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A19101C2293D
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883B11D45E4;
	Tue, 27 Aug 2024 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lwQMN/yM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2047.outbound.protection.outlook.com [40.107.212.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CE71D0DE4;
	Tue, 27 Aug 2024 17:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778131; cv=fail; b=KYoTIe+z3jOJHyHQTYQKZBPJ5kAJGNbtHrb4Lxq+Rbg6g7ZvUDw/mJyA7EiTiFU4atqSFXgtiPM0YVePcSiy24dpjU2w+LKDrt+0Ja2B/zEVrahYg+zKWq9FNE5frLwepD930TiCKSIgfZGZYFhqVV5nnTnoBeh1E1a+1C4fHqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778131; c=relaxed/simple;
	bh=xnyGNHjGocnlsbj9W6i134TLcyJ+LM+AAJts3mn8n/8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QkeY9Am6vhZ8fL2e19Pfj8H1Sh1xQJL4plC5B/QBYBjik+/q8GOiRewQ0pOhZmmRl+Yn+H8QomBIzYQGAPx2hlRulfNxrNo78GPoJRhf7bs3XDXFG8xirDzXA1wkTJqyatzdAuybQj9Ey/DHhY1i8RAFVXBY19cInGYFuq3E5xM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lwQMN/yM; arc=fail smtp.client-ip=40.107.212.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oehV5GHTHkgGzoSxlFP3fmIF+R1QaTcDIopDiWwzhAcqmCAvtDq/3ocPJOG5DulGKjT+ZsKGEP61SRAD0tB/0J94NpImrZhZBx8nYFl5V7P7EgoojU3GkHUovudxM/WOZTc8CznAzImv1WRAIX/+B7+01SAce0XgnbFNbRjuOWolFVT9LOXBgMqa0xQMFe4T1yHzlBxjSVHWjHl61XFTXQ88Vc1qrhxlnIZGL2l1RvaurUBHavqFJ90Rd8y8lpcHzEuM4qYTtnbhOE/xrsfs4A+xu2eAxkGUka/HLdSk/KnfHRKR9AQ6dCEmY0hHwOIR+gQ86eL3JeTvY5q5fIZIeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Pyph0r5FsokZPup8TAbFXRQjzjHbhzcfuIokg7cvBg=;
 b=e7palDS9y1dTs/ELBK1gF9zSvHp6lvqYeHpxKT6/GY3v+V9D7TqyZVok6SbTYFGOK3FdkZEXT+a8ckYwBT7ztIi/OZ7DExCMtXCbIdFjvWintBMG6tK6wQC57MP31aDMAqLpBpbEQa2pi/jhDvTwQxdvh0KcnmXZ9hLV/oyK3cCrsehxkftSPksHyHrn9MJ4zx3EFzESzJoODhm2UH9/+p4MqcAcQczmrZ3aM98Rzb9PIUXeOWRcw2Cx/Za2TvA0W405B2ddqrYuq4yonpwMY5GPjhHNk8xaV6xxMdni29S9JqaZuUYvJNCVX+67T/tANlwSAhzIFlnW+Oyf83a7vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Pyph0r5FsokZPup8TAbFXRQjzjHbhzcfuIokg7cvBg=;
 b=lwQMN/yMBl5Jl0n1xTfy6eyoXC8BzM14tX73RNbvUpWfJ17cZLaXvCUCpFcUzBy0uSh8MIJOPn0K/cjQoV/UWqgbRW7jeET7WABaBA2E079W8ThLxUDobzw2ZX8fAZZPiy1sHunRgvrriFN+fNv8vipu2bzcwyVnPw5x3tO1FqS3lElaxpK8Y2A8D87krDKozSRkBOoJGnFgcB7HPxsp/GGdApuPlCdGZYZEzQ/8Cpg24r9Mq6W1eCw7aVqMyOxdnknKEd7GEk506mREhPyQ1NO7h+skKD427dpK6YgDanHihBuqsobl+7SDxhpN2B6vqxaytjoPx44/l1rxTVSzkw==
Received: from PH7P220CA0110.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::21)
 by SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 17:02:01 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::a1) by PH7P220CA0110.outlook.office365.com
 (2603:10b6:510:32d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Tue, 27 Aug 2024 17:02:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Tue, 27 Aug 2024 17:02:01 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:01:50 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 Aug 2024 10:01:49 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 10:01:48 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: [PATCH v2 15/19] iommufd/viommu: Add iommufd_viommu_to_parent_domain helper
Date: Tue, 27 Aug 2024 09:59:52 -0700
Message-ID: <a854f9737306de2db49296078a37e263c76266c6.1724776335.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724776335.git.nicolinc@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|SJ2PR12MB8784:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d6dd6a-279b-4d06-f52e-08dcc6b9f825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sHy2VatqK8VQMyLWw3pvj4blC2V1ntgNfxvDlz/yiMIo7GVCKf8I3O+H2UNs?=
 =?us-ascii?Q?9xbx5W7IgU9g1DtUN6e6Lrk8LVxtb4gqE96deiWfOGaJOZCeYh8i5XJYUeLX?=
 =?us-ascii?Q?poG0dyovDMFlOcAIn5OdsoKh1RuL8nCj67gLYWKrfQB6GJSQRBMSHiaz9egw?=
 =?us-ascii?Q?/cgUV9jVcfOsq4TWGFx+pxKICQ67789ymQd2Y2CDwFq6k35UlrYNk7vTm3+a?=
 =?us-ascii?Q?+Le1PRIZDjkPS8A8ihiF3eGEt8fUSCWAHJhC45F/c328pq+ThNRCPXfsbPSx?=
 =?us-ascii?Q?q/syP0FtdwiBuTy2R1JJk0N/SY9aDBRWi4vgcQvEQufb2qWRuOto/pA6Fcd3?=
 =?us-ascii?Q?jdTiOKNsBsiH6MgV3YxEA5Z35mlJ89syR1Ce2HPI/BLK13n92YXKyz6PifBY?=
 =?us-ascii?Q?PScIEDgmpcZ0EPQPecTYp+Em/oVvbGcerHX9HwLVTna5z8JUfU2kIhnqYU0v?=
 =?us-ascii?Q?9WkPRjE76KW2/K1PCL8NJZu2F0QhwV2NOXWLYHoOcUch2fnLgLPnjvQ3wlCF?=
 =?us-ascii?Q?JcIvOTo/55nXEDcHCrxFreOYW1+ZjqxVKVbOwteJF+wMPw3Bri63JIvRSLcE?=
 =?us-ascii?Q?dRI1qrfrvAYhd18GCp1G+aqk1CWmAFAqQbC6l/3WGPE6ciBgO1Jit6ZubyDr?=
 =?us-ascii?Q?lpMzVsokv0AfPd2od8wHyACQnUZwfAQNlBhcAQ4Ql8o5zBH1Fvti9Ug9lOGx?=
 =?us-ascii?Q?IUI3njHgaw4RUPZDfGWTxD8rHC1ZPezwiDHj5xNILXQ5IltgUnsKMfOB2UhL?=
 =?us-ascii?Q?iBju9qn5qz+YZa35GdhC4XDiex77BAXQO794S8eNQ857C17qxtAKTTnbpc0L?=
 =?us-ascii?Q?wNzpKcQI4PCbcRhBQMPN0CYWEo9snCWhSOSjJhNduwLCqSZ2lmoP2TFvIB8l?=
 =?us-ascii?Q?y/sUp/DjKKDtbB9btgRBAz4DqBOR4nsoQuZBOYj7Zt33RTjoO9gF6J2rtTvM?=
 =?us-ascii?Q?jPJN7bsf+YoBuSaVKKvsuVHNCspAvAKUfazYdr3pPZQu+T7yPSFtemJfwxbs?=
 =?us-ascii?Q?B4PCZa1n9FLhEPGKOnFBXRH8x9AlGo0pTc4empMOpqAWAeRSiz/cNRLrN7W7?=
 =?us-ascii?Q?0UXExOuGW7XUy0SprfaAcgTEDB411gCFVjjv3ARGyAyYZp+2gMrw1cQs0/cr?=
 =?us-ascii?Q?zAognrwsuTnVKjCLsRcrOq0alVRfQDT8q7XdA+cwhryXkulS7Vx66E/6NdfE?=
 =?us-ascii?Q?Ke9acWrRTT2w2YRQCMzvY4L/QoGfmYO5ZLAaO1Y2KW8wwIqGmhcqTjbO7pD0?=
 =?us-ascii?Q?KLewP8G8r4D8QqDIP7QnNeEKX4+NkF2L9segCXuA20Vrr+E3bMtRbNFRy53G?=
 =?us-ascii?Q?VKGuOdsO3YLvQpU0PhoGmtp8jkuZNeYRwdxUWW5HLe1j7B6CzxMOTFiFN1ez?=
 =?us-ascii?Q?irXaKtOS3S7nt7aG/C3oeSBoFtJcRuoj/sGttGXZJV8dvHOVRSl8FMlWdexS?=
 =?us-ascii?Q?ODbRP88Y6W+F3j2aYyTWXFZYvRYNGNWE?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:02:01.2535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d6dd6a-279b-4d06-f52e-08dcc6b9f825
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8784

Allow an IOMMU driver to convert a core-managed viommu to a nested parent
domain for the info that the domain holds.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/viommu_api.c | 14 ++++++++++++++
 include/linux/iommufd.h            |  8 ++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/iommu/iommufd/viommu_api.c b/drivers/iommu/iommufd/viommu_api.c
index e0ee592ce834..3772a5892a6c 100644
--- a/drivers/iommu/iommufd/viommu_api.c
+++ b/drivers/iommu/iommufd/viommu_api.c
@@ -37,3 +37,17 @@ struct device *iommufd_viommu_find_device(struct iommufd_viommu *viommu, u64 id)
 	return vdev_id->idev->dev;
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_viommu_find_device, IOMMUFD);
+
+/*
+ * Convert a viommu to its encapsulated nest parent domain. Caller must be aware
+ * of the lifecycle of the viommu pointer. Only call this function in a callback
+ * function where viommu is passed in by the iommu/iommufd core.
+ */
+struct iommu_domain *
+iommufd_viommu_to_parent_domain(struct iommufd_viommu *viommu)
+{
+	if (!viommu || !viommu->hwpt)
+		return NULL;
+	return viommu->hwpt->common.domain;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_viommu_to_parent_domain, IOMMUFD);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 364f151d281d..f7c265c6de7c 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -92,6 +92,8 @@ int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx);
 void iommufd_viommu_lock_vdev_id(struct iommufd_viommu *viommu);
 void iommufd_viommu_unlock_vdev_id(struct iommufd_viommu *viommu);
 struct device *iommufd_viommu_find_device(struct iommufd_viommu *viommu, u64 id);
+struct iommu_domain *
+iommufd_viommu_to_parent_domain(struct iommufd_viommu *viommu);
 #else /* !CONFIG_IOMMUFD */
 static inline struct iommufd_ctx *iommufd_ctx_from_file(struct file *file)
 {
@@ -145,5 +147,11 @@ struct device *iommufd_viommu_find_device(struct iommufd_viommu *viommu, u64 id)
 {
 	return NULL;
 }
+
+static inline struct iommu_domain *
+iommufd_viommu_to_parent_domain(struct iommufd_viommu *viommu)
+{
+	return NULL;
+}
 #endif /* CONFIG_IOMMUFD */
 #endif
-- 
2.43.0


