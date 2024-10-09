Return-Path: <linux-kselftest+bounces-19368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8907F9971EF
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 18:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14F471F26755
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 16:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8211E105E;
	Wed,  9 Oct 2024 16:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s6lTxhEB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344E01A38C2;
	Wed,  9 Oct 2024 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491949; cv=fail; b=tB7irU8HFNvLRjk9h56dPNFStUWiCXWxasSfNXP1YiLpJQzEKZ8iZNPC2Xab+9D4TvMSniaIuuuMCtLC+nV9RyYvo8GQbDdDI1DCO1DrSdfXNyrI+5PI5MLRO18VjmLDjK2p1bjb+F0uYVXQJTPxLLIU0WkjM233sqBeE8AjGLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491949; c=relaxed/simple;
	bh=Lp7ocXBl4xGBM8NReU3D5evAboRUH6+3ZD7roWYEbOc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sow4x0atf4lIXEvPtmeRQYOrOo+pCYuXfdH3S9FWKKyc9a+r+6O5dRvwVTI+VMRDanjSCpxy2c0c+dHjbq9NIolYmVt5RgTusl1WeYqnfzzgdJnXTHaY9j0Vy3R865N8G3Ybz1deoKFA5lZERD99Qx63UFRKT1Jlt0M3pzE/u9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s6lTxhEB; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6eyTYRLwPSP6vJoOTLSSiMhM9eGd2/CmwbO9HgtmWC0gkiXzFJ3eAQflvFh7Rp5e043SjGpX/0LwTeia/drDoA6As53I23v3v9mFQfq+UDN/en+H/balyrkKE8aZIO3MZrcXuy7FLBMZvHD/bqFA7OGeO71UBGTNyy8ABW6GLwX/GPAtsYENDXX5gY9kGKCKOLnwRHk5zkYuzd2KZwDukx37XKiBpO/Y6ncGLzRUpn5i5cbPAhSyw9RqU6PcsYuOFaQpIg7oJJuslpsUEihFgJGL3h7qItiin+a2QdXmdicbh+cUQP9v4Y2BwsJ98PCnxFlWwsMPwUAFlmN4MTcJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mGsrTnbsmY4X85s6BenaoLrJrpAH3MtQiiwHnt+EI4=;
 b=SF7Q2OhpcSi6cib8jq3aYHzCAcOl7608uycMKMrWjr82CFj02HWiiKNxk4P+hoJUVIgwmve1qTL+6qNII24CajKR/pun+9+5ktPde14KoyzSX/0M3s4KZ+Anr0tHWtzV/OLDoRYSR5XhXT152xcOqs4IurpOGdXe21YmdT+sJ/VSaSyQTmBkOO7DA/tPpVWrohOoT74/WmszcheeCg8hGk9wlkX4crwhf5KQ/Ao4jE2hDiiAYQayrZvjgXAJq+tLAraPbSgVQsV0zw363cFC+BuRmr12a1IAFqhq1GHcC+iPIuRTexFm0pGMRPU1z0qnL7p1w4IFPIOZrSOW8E7jOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mGsrTnbsmY4X85s6BenaoLrJrpAH3MtQiiwHnt+EI4=;
 b=s6lTxhEB1Amw3UoAZ3by/oEovgfyoRydiOKWc29GsqqaGfZkDKorqQ3vap7AN2gnq1cArcgqbhjYH82BR2ecKKgv4odsRdZe2C5nSEr1SB4aiY1rKBC6Y91+L6pj3limwxc5qBV7nYj2/ZUrXpYJEhjfk1NAxU9XynKUKiwzjum9+wD+ZXBMKmKfySjf+nRrhQ31Xt7/HBYh0f6JMukbAZxrlmbTSXSgMLZSOy5/eF5o5hgdX4K4WNJnf2kPhtttaa8qqjH2cIi8ppUX+g1D475rxHZ60IYfIHhovB5hu2CvmBsHbVoxKVmrRawOk/q2PanSRyDBdUyb2AfXGdFi0w==
Received: from SN6PR2101CA0021.namprd21.prod.outlook.com
 (2603:10b6:805:106::31) by DM6PR12MB4249.namprd12.prod.outlook.com
 (2603:10b6:5:223::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 16:38:57 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:805:106:cafe::98) by SN6PR2101CA0021.outlook.office365.com
 (2603:10b6:805:106::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.6 via Frontend
 Transport; Wed, 9 Oct 2024 16:38:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 16:38:56 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 09:38:50 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 9 Oct 2024 09:38:50 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 9 Oct 2024 09:38:49 -0700
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
Subject: [PATCH v3 08/11] iommufd/selftest: Add IOMMU_VIOMMU_TYPE_SELFTEST
Date: Wed, 9 Oct 2024 09:38:08 -0700
Message-ID: <240dbfe0bec59b39e759d610485ff062054c370f.1728491453.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728491453.git.nicolinc@nvidia.com>
References: <cover.1728491453.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|DM6PR12MB4249:EE_
X-MS-Office365-Filtering-Correlation-Id: dce43afd-9f1b-4a72-3192-08dce880dead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EdRk2ErIyQOQKWUvbucQJpaiYbNtkVqmVKwNorwRBMSPfwdMt7SBeCWHD3VV?=
 =?us-ascii?Q?ffhK4bBb7pkV/OCtP9+wyvxavyg0fES0/uTccZ9AMhzooJVZIb5paDp6I+i3?=
 =?us-ascii?Q?oNSD/5SMfdEG8Z/RneDkztm8U2Rj2X5alDbog5dcOe9MXYYnYz4WZmMEIwGe?=
 =?us-ascii?Q?slOW7vVG+UGQfluW/p/w0Fny4W+5jTU6kk3IAsjjPrvbUmSjBQyLSlmIF9YC?=
 =?us-ascii?Q?+RyO8yRVOHtb2GkIcZ3fR4YngEbmxOyMX11Ov2nwRXp4CcCDFmL89lsO9mYa?=
 =?us-ascii?Q?aUZzxBs9r6DxDhRbXekRwqv6BcaMOqSh5dHEMTc32oAUq34tcrF590L/cdTo?=
 =?us-ascii?Q?yymw/SsCfW775D2wNhB6yPCl9dxOBvQjUSHupzK2F29iZzc4HPmB9DJsnXor?=
 =?us-ascii?Q?DeP0lBKALDN6oYkdb+/JH8XRVN0Dt5GxjITYihBhLiebPIazvkfnqwEyIeBn?=
 =?us-ascii?Q?R+qLdxuYaNsgc3oVxZjmtZLVJ34yX6NaHa1x6deLk56hZTH8zgpKAKyPcewP?=
 =?us-ascii?Q?yba0XNKHehJi8IGiR1enO4njcOBx6PyZ66g/LDC6cAyrKz6nR6pIU2EjPoZP?=
 =?us-ascii?Q?219yQpigRD+qNIEMYNc7YEq5/ZLMMpEIRLqthmE7tZRVPon9SGMbDZfTbmwP?=
 =?us-ascii?Q?1S4+/o7YwbNaCIoGY1Jkk24icx69+TAplxJOxXjBsKP7b7UTOQUSJ+bQw5T9?=
 =?us-ascii?Q?yD0RSY6mOuyNiUakXKxbp3QGx8jL03UY8SyTBNRIM6p4RMgJXRFx/Jb5LU9o?=
 =?us-ascii?Q?ePyE80VtrEMoX3s7apYVcQ5tu+n+PVFg5yHwN4esezYIkdMahM3edVXJe2CT?=
 =?us-ascii?Q?phXYLyKir9D2wUI/Ld/D1hn4XiIa98nAt0iep7r89R7Vtc3P26xiH8IASd1w?=
 =?us-ascii?Q?iGIdpzGK/dAhtAiAv97KSDTN/X1sDpRgBkht/1JXYw4YlYDuFUVYOHl6KDGw?=
 =?us-ascii?Q?e2zgJJZmgafYZWa/Smkekx89+GEcEyt3hyaeLCYwdzmJPv2VmqYmekj6kc2W?=
 =?us-ascii?Q?rZoRTHx6XIZLdMuMlhDYDDnyzFX9WgmBNXlqWLOIiRwrwZr6JRnVTdeUIbJa?=
 =?us-ascii?Q?b3vK8KJbLhCy8D4f5/27chBzhAehTVplDhF/ein43PwJySK7eVBG3rhSUqcX?=
 =?us-ascii?Q?l9IJ++JXb/xCWRRHdofBKgRkiUIgyTNvx4NY4kAYbe7XN4z4w/MqqtFsfKvZ?=
 =?us-ascii?Q?17IG2ijT3yLYyz0V9Z5Gjolye1SIWyiAzDV7r3JjKSXl5VHtwV0kUXX6zorw?=
 =?us-ascii?Q?kVQc7uts1ATf8vPTiaT6uv+L5jxWuq2EhADpOe+Bz6pUGBncp3LKlIy1JS5T?=
 =?us-ascii?Q?uR0XNKYYyG3drBzFPNaHHv7vRZnz1mKTnsmL7VLuFfe7IV74zJfeW8tc5O5Y?=
 =?us-ascii?Q?4sUsmzDl2Q5d2NJCesi11khiJgUi?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:38:56.7711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dce43afd-9f1b-4a72-3192-08dce880dead
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4249

Implement the viommu alloc/free functions to increase/reduce refcount of
its dependent mock iommu device. User space can verify this loop via the
IOMMU_VIOMMU_TYPE_SELFTEST.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h |  2 ++
 drivers/iommu/iommufd/selftest.c     | 45 ++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index f4bc23a92f9a..edced4ac7cd3 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -180,4 +180,6 @@ struct iommu_hwpt_invalidate_selftest {
 	__u32 iotlb_id;
 };
 
+#define IOMMU_VIOMMU_TYPE_SELFTEST 0xdeadbeef
+
 #endif
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index a89a865617db..4fcf475facb1 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -132,6 +132,10 @@ struct mock_iommu_domain_nested {
 	u32 iotlb[MOCK_NESTED_DOMAIN_IOTLB_NUM];
 };
 
+struct mock_viommu {
+	struct iommufd_viommu core;
+};
+
 enum selftest_obj_type {
 	TYPE_IDEV,
 };
@@ -544,6 +548,46 @@ static int mock_dev_disable_feat(struct device *dev, enum iommu_dev_features fea
 	return 0;
 }
 
+static void mock_viommu_free(struct iommufd_viommu *viommu)
+{
+	struct mock_iommu_device *mock_iommu =
+		container_of(viommu->iommu_dev, struct mock_iommu_device,
+			     iommu_dev);
+
+	if (refcount_dec_and_test(&mock_iommu->users))
+		wake_up_interruptible_all(&mock_iommu->wait);
+
+	/* iommufd core frees mock_viommu and viommu */
+}
+
+static struct iommufd_viommu_ops mock_viommu_ops = {
+	.free = mock_viommu_free,
+};
+
+static struct iommufd_viommu *
+mock_viommu_alloc(struct iommu_device *iommu_dev, struct iommu_domain *domain,
+		  struct iommufd_ctx *ictx, unsigned int viommu_type)
+{
+	struct mock_iommu_device *mock_iommu =
+		container_of(iommu_dev, struct mock_iommu_device, iommu_dev);
+	struct mock_viommu *mock_viommu;
+
+	if (viommu_type != IOMMU_VIOMMU_TYPE_SELFTEST)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	mock_viommu = iommufd_viommu_alloc(ictx, mock_viommu, core,
+					   &mock_viommu_ops);
+	if (IS_ERR(mock_viommu))
+		return ERR_CAST(mock_viommu);
+
+	if (!refcount_inc_not_zero(&mock_iommu->users)) {
+		kfree(mock_viommu);
+		return ERR_PTR(-ENXIO);
+	}
+
+	return &mock_viommu->core;
+}
+
 static const struct iommu_ops mock_ops = {
 	/*
 	 * IOMMU_DOMAIN_BLOCKED cannot be returned from def_domain_type()
@@ -563,6 +607,7 @@ static const struct iommu_ops mock_ops = {
 	.dev_enable_feat = mock_dev_enable_feat,
 	.dev_disable_feat = mock_dev_disable_feat,
 	.user_pasid_table = true,
+	.viommu_alloc = mock_viommu_alloc,
 	.default_domain_ops =
 		&(struct iommu_domain_ops){
 			.free = mock_domain_free,
-- 
2.43.0


