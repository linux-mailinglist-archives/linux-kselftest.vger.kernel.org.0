Return-Path: <linux-kselftest+bounces-19381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2D599720D
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 18:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19681C22FC4
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 16:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D141E5729;
	Wed,  9 Oct 2024 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TFLQNZTi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786E21E5016;
	Wed,  9 Oct 2024 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491964; cv=fail; b=mJTqRxrSjiWC8Xw3oqbd382fyze4je0dUqwS97ogMJ/ZV7wz2EmSYXJv5fxJYoWNPYcfFyHlSAWw8nVCHCz8S9R27iKzqtMMcX4HvsYgSU4YYiwuUAdiig/OakXZMzJenL1hQ0jrdCfsGSxotRWYeQKRgVkf45h4EZqUFSqWJhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491964; c=relaxed/simple;
	bh=l8DQ4YrAfLYQDQnUWKgYUkBHqEib4yW/TbAIW1AEPZs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bwx0hBRDyzEyG9jAS/++oEP/QgBKCG2m/19LlSK6CXoSU3nLY7Pqf8f0MoX6uJMwupdY+P5jH8IY+GfDrsLZnlsX2ZqDEKRZdZJl9sqXK1KTb/l6pT9+4KXIRsj56+S5PxmHbgmrmQhaIQ7bew9sqVajaM72SgKfAPhpVv1x6IA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TFLQNZTi; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5CxpI7KZe4tBCcgmSFI1ol2dZlFKmTsW3CO5Up56sZ55PU+PaMGb4b5Y5y8UXw9KZFear/NnEvdxCH3a8SpMQyH1P5cw9s2OEETY+QcZGQ5S1GjKR3Rftszw5bn5FGwHqv5rO2iXUqaZMz1vjJkdvIhQfvGrSJPdYtu+I6xupxqUom6bYhK87f9+oYtvFv/ol0IWKdTOyjiNjY/HUq6IvL82Eyl2YrYCfFtz68U6z+99Zh0R5jxiOkCzB8Ings4ho7rDyhjiyA7nH/wrOI6W42k0uK04jglUPZloq2voUhYsYB+9Ah1Of8Ha4FJetf5F7lYdt7ibiZwdGAY0wiNtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7Q8qwwTrrSSdW7fG33myEfWF0p4jjVxkA0leq9KTSw=;
 b=BuRfBJ1hyLGd7AfoQonHHalFe/ZtjMbnqyPPfq9u+PICHBZ6WWj48RRgjFk0P/k+5DBHVw4yaAqzO9a167GCNff7GxJN6KszlGkbHYIYsQmheErLpiIrazlDxX/sa05n49vypWXKGOUC3PXjn0oHNOlA+rc12vKOI2FHezz0eLL5dQYOj6sZ9CysWI26j+Uv+Zf4jfbZlUZ28ThcwH2aVQIdSPRZfA50ZlBFFlyS68+RxvMY3FKBrmzMRIU/DiTxCArvhxPkWRutB4DV40x74UKvvjyrwtVWBNrNKhAFEZmLulXDCzg/baQ4VUJTlcHtkTwHcCOxl567ml0q+S+bPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7Q8qwwTrrSSdW7fG33myEfWF0p4jjVxkA0leq9KTSw=;
 b=TFLQNZTiNjSXe9UHj0+keTAFY2F7HNhuDbBVhoIQyGpSSnGMqxjh7/0c1tsK2Irh+kD6/9ZTExBv//vvH5qHzwQBuo62QGulNyD+VPzzpMEExr0yaVO10J3b1sL7I5D3qtEOB3HQaJEtC8ys9Z6vtQtjxAIDr/GhAINi59iIm4VcszzMSBPDvwThIWbucF6qHE/O0ikYqzyFMvTHUpFSsOLEetwxmzEQwSP0090nvGKllWR+IpQKxw6o/vJwgKGE2F0a1RFO6mon0pCm918RC5XnseuFwtbeNES/gdBnCF9Br9Ja56DFeS04YE2MImevGCkr8YFqwDCcRM73Ieq7Ig==
Received: from CH0P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::9)
 by IA1PR12MB6161.namprd12.prod.outlook.com (2603:10b6:208:3eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Wed, 9 Oct
 2024 16:39:15 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::19) by CH0P223CA0021.outlook.office365.com
 (2603:10b6:610:116::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24 via Frontend
 Transport; Wed, 9 Oct 2024 16:39:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 16:39:14 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 09:39:08 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 9 Oct 2024 09:39:07 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 9 Oct 2024 09:39:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v3 09/16] iommufd/viommu: Add vdev_to_dev helper
Date: Wed, 9 Oct 2024 09:38:21 -0700
Message-ID: <d5326ed6354a9f480a90b3557744ae0a7452c8bc.1728491532.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728491532.git.nicolinc@nvidia.com>
References: <cover.1728491532.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|IA1PR12MB6161:EE_
X-MS-Office365-Filtering-Correlation-Id: f4cdfb1d-4df3-4ceb-1662-08dce880e96c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oItx2jOkrrQvONCqxDCrtrEXhNvgU5hdh51R/+7SLBvOl7J1iXxp93nWj3LU?=
 =?us-ascii?Q?RjmKxXTQyVT4wR4wvtb963XbpuSvfp0NnEggeD9V3gykpnLmSxuBNgHAsu+u?=
 =?us-ascii?Q?DjrfpvkCPq/ZQJwhKxUQk07U4NfDA3V79rGkt2fRYjC7j3DjqsFf1sTuEcA3?=
 =?us-ascii?Q?n15lqTGls5Pfr9vWmKgMnlMnZEEa7ZUeQ6ia5ByT7yeWj9n4pPFLhcUAsw1Y?=
 =?us-ascii?Q?FrVQfmaHm+0N2eQgsuqsJPdSwKD2qTNdUkVw4A1E8hOcYLg6XthGKY6Obe3s?=
 =?us-ascii?Q?1MPfuBbfIS3guc5+RiCnwKjaB5qNjXxFHySjRVIRArhXJIoBXx03+/WsWkSq?=
 =?us-ascii?Q?FIyIgmnMqi0a/NkTL40ZeB6Cw2sZ0I+zm3SFWPm6LwAexZb+h/zOhMNc5BcB?=
 =?us-ascii?Q?HnWsORR1sFnvOHlExTMG+af5FW46JQSGeBYWLcqUmYkBxtCJv5zD3Mka1y1z?=
 =?us-ascii?Q?OMFQwYR2dj2ge/GKczB9qxpIOzXuqxEbbWya627voGjQd79/vjVNRYfkV5p4?=
 =?us-ascii?Q?CvQv8eUys20MlihZEuPNa6Sb5etrv+wnZvcInACpC6iGdbRqwrIP9+/P+pcZ?=
 =?us-ascii?Q?JdljIQSSKjEQzRgGRD/wRMrrbkBMKbnGU4WXG7Mp5q6OITWYS7Knk8ex4bs5?=
 =?us-ascii?Q?BbcQa/ATmM4+yER/OIYEQaX5DiQ0V92ZP6ThMSUewerBBPfFO8cgwyb+DDzu?=
 =?us-ascii?Q?9oNX2kPFGrbiYsT65RgSvgkSIWia7fJl1xMei28ino5615cLosxpV9fcY7o+?=
 =?us-ascii?Q?5NbcfmjAAgHa55p0ZIgxO1Oe9gGo4qF+Do3S2Batu1Kbfqt1vDHeZGzjWjVg?=
 =?us-ascii?Q?jAG971zCg8/sM+NER/XBE2kcGwN2dreXErFPd6iJUTa+TWvh8pdJmxTxsb4d?=
 =?us-ascii?Q?JOEcv2QA5VHeeF92lmE8u6Z4FGNv6uSq2uKrgvUpuWWtrnicZQ7CmyxVQJM+?=
 =?us-ascii?Q?51Qrgex6gp6AnnfnqqV7nisyoeBH87mDMha2hFE0EB0ek8UbhBmwcNrTU+/0?=
 =?us-ascii?Q?w067/+Zwn5lyLLoEpDGO3sCG8JTxqliyJCaRWURDwaT57O8OmTzNJ6t/DVUl?=
 =?us-ascii?Q?tYfW7TDQQyV+DRyW6Q8+fQ4DqSCvt/1EAtMF4OAmjY/CCCd3KLhK8ySteds9?=
 =?us-ascii?Q?21JwpOVYUIVUOcXP2RXVOGW9xYU3yDH3uIeEsmIfzTJWg1Z5zi6z+HCjpmys?=
 =?us-ascii?Q?ccErMJ91KzKbQR+j1jyTAIXDY12ORFlZofvX/K9szObV+tTit+WiItqduCh3?=
 =?us-ascii?Q?J68z211U1oUBucm3986+3pjlGHJB0EohPsyb4zXnHiS6n2Wmk2TdPz1/y8Yl?=
 =?us-ascii?Q?hpipEwdCM+okYNazpv6C2kZbRLo145XG1qrz7j8ANnENbJosURLNg0QFNGpX?=
 =?us-ascii?Q?QR75vFo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:39:14.8150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4cdfb1d-4df3-4ceb-1662-08dce880e96c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6161

This avoids a bigger trouble of moving the struct iommufd_device to the
public header.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h            | 7 +++++++
 drivers/iommu/iommufd/viommu_api.c | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index e58b3e43aa7b..18d9b95f1cbc 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -85,6 +85,7 @@ struct iommufd_vdevice {
 	struct iommufd_viommu *viommu;
 	u64 id; /* per-vIOMMU virtual ID */
 };
+struct device *vdev_to_dev(struct iommufd_vdevice *vdev);
 
 /**
  * struct iommufd_viommu_ops - vIOMMU specific operations
@@ -134,6 +135,7 @@ __iommufd_viommu_alloc(struct iommufd_ctx *ictx, size_t size,
 		       const struct iommufd_viommu_ops *ops);
 struct iommufd_vdevice *
 __iommufd_vdevice_alloc(struct iommufd_ctx *ictx, size_t size);
+struct device *vdev_to_dev(struct iommufd_vdevice *vdev);
 #else /* !CONFIG_IOMMUFD */
 static inline struct iommufd_ctx *iommufd_ctx_from_file(struct file *file)
 {
@@ -187,6 +189,11 @@ __iommufd_vdevice_alloc(struct iommufd_ctx *ictx, size_t size)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
+
+static inline struct device *vdev_to_dev(struct iommufd_vdevice *vdev)
+{
+	return NULL;
+}
 #endif /* CONFIG_IOMMUFD */
 
 /*
diff --git a/drivers/iommu/iommufd/viommu_api.c b/drivers/iommu/iommufd/viommu_api.c
index 8419df3b658c..281e85be520d 100644
--- a/drivers/iommu/iommufd/viommu_api.c
+++ b/drivers/iommu/iommufd/viommu_api.c
@@ -69,3 +69,10 @@ __iommufd_vdevice_alloc(struct iommufd_ctx *ictx, size_t size)
 	return container_of(obj, struct iommufd_vdevice, obj);
 }
 EXPORT_SYMBOL_NS_GPL(__iommufd_vdevice_alloc, IOMMUFD);
+
+/* Caller should xa_lock(&viommu->vdevs) to protect the return value */
+struct device *vdev_to_dev(struct iommufd_vdevice *vdev)
+{
+	return vdev ? vdev->idev->dev : NULL;
+}
+EXPORT_SYMBOL_NS_GPL(vdev_to_dev, IOMMUFD);
-- 
2.43.0


