Return-Path: <linux-kselftest+bounces-16426-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF729614DE
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4CFB1C2115A
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305B31D1F59;
	Tue, 27 Aug 2024 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ee9R9Zh+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAF71D1752;
	Tue, 27 Aug 2024 17:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778117; cv=fail; b=XhT0gstIIzpXVv7OLLDTu2Q+kn4DhlIEqyTv5lUdy/YkUgV4w0xQ1mOUVfTWj5jEm7mI0biNcDzfXzWZ46fc3MWazmcoW6WD0JnNjkRXfyeiAAytjzeK70WV9GOPl8nXST9GrhM5lZ2LR39Fs4K8C12tZaDo+kQ9bN5+Hkm3t/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778117; c=relaxed/simple;
	bh=AcgTftsgFCWE94a09st6PQ6AzIbrDYAKI6dA7l9ZUnQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uf/uAASKVnwNZMy2QJKVltpSEKKyo4sQG43+LbCEKkPo0ZF+Osbp64neCFADAoKDE9xhfhOVZ5Gm2N3IsDvFE+caxIfiq0hoREIxU67LbPGqBP6NMWn4TCJ28tdmPXlcMN9SYDXOTYhS0ktiHM9PusYzcUsFOui52KD91pCs3d8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ee9R9Zh+; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJjw8MyvlUwnIBRZuENkhtrCwr+gqjs2XCDmQ+6TrqIJJoVt3iN4+3atDTqVzSSUf3CU4dKelSdeC+2WqkMGZ2eHZ5ZBAWdrFAG5pIbunPapz3+uhv1yAfko/JQ4N1yIJL0P925qnz/vHfWKfs1ftKyaH+6PrBxn01YfGbg128SKuHZqBVztBHqv8EwBj9dgUN1XkQFiCpyGKU9wFm9jk/oGv/khigHdNJ9C0S4J+Zvb/kiPr+xTnveqOuml0qTD1AsBEbCuQbputaRk2UMgA3cdAKuYI1Q3xNGBpJ4rMzoXOqOwXG66sHJX2I8Fgn09xjg6sJDTckU3UE/5znuPoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebiOam/XcwPXKNfo9r5+oOgFBW07nF+uKs/nfcrVn44=;
 b=lOX2lJM8JDg49zV3c64M3RcUpAv+CTjHP3NUUaQEnERimJhvpw8kdAL3tOYemBFlsIrAKsgjgOeUNeH/gEbV6ngXafTryzBaTYXws8g+i/0cAaWVD/n7WLxlqrw7csNCu7aGxG2cEIz6YmlP2EN/TPRqRO0vA+UU/tM3yERzEYWyxfklFPn8e7gN12auGnC0P/K8ODGOjP6EOQkR9l4muTxdFoxxWFkT0HoaMTmfk1F75DRALPFBeMzZVBPBiOtjrBHBjPfQ1iHIWEHzpAFvPl+uagn6VlrBStBi1JMZkf8BVXp+k2CNvPyMbopuzKIYvq1yKaD4ed0YU0y0d/54bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebiOam/XcwPXKNfo9r5+oOgFBW07nF+uKs/nfcrVn44=;
 b=ee9R9Zh+bm9lgMI5b89Qt1YnimMB6zWo4LzPcGE6P3qTMol776jxjvT9weLZAE58lxFAx4CAEV/poq1+sDmhwdjxeCzsZWn80ll6QARaa4sUCSpoS/02Fs9ruhtdG4BqGWL0axvJ9OtesDYVnCRuU8Uh8Px+1v9XV2ukT6JD0RC/o56NToX5WE7jF6EpbCkBeSOCED6UwxlL6h5k4MHOYOENuLz7AIxSrZaJ/QobUFusyrj8mYmkv75w718p2PtIm4+w0ZC4zWjhNcYWL1SBWc8as1Y5bXh0gS8jCDOjQ6f3bvztigOirH58Hup4YqLBPOXkZEHAdbAjG4s2VlxBVg==
Received: from PH7PR17CA0072.namprd17.prod.outlook.com (2603:10b6:510:325::20)
 by SA3PR12MB8440.namprd12.prod.outlook.com (2603:10b6:806:2f8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 17:01:49 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:510:325:cafe::96) by PH7PR17CA0072.outlook.office365.com
 (2603:10b6:510:325::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20 via Frontend
 Transport; Tue, 27 Aug 2024 17:01:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 17:01:48 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:01:34 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 Aug 2024 10:01:34 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 10:01:33 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: [PATCH v2 03/19] iommu: Pass in a viommu pointer to domain_alloc_user op
Date: Tue, 27 Aug 2024 09:59:40 -0700
Message-ID: <d6f9be955372adbee1e53621d349acde0c79aad4.1724776335.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|SA3PR12MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: 712faec6-6a0f-4521-de8e-08dcc6b9f05b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?liz7OOjYtB8wi8tC9y496dZnfzZF7aTdUzxonWFnj/Nrc5O1WttRqcM3DkxS?=
 =?us-ascii?Q?8WEXksTkkrGeX7U6ZYLzDTzgrm1SRMszFxPi/EDRtvNuffEO60fCEtzpFVoG?=
 =?us-ascii?Q?yUQU4dCg+7330TByY7rFBgPLt0Gp6BY89/nH64cibiQn2ZrOMP5KfSBm+jfk?=
 =?us-ascii?Q?vyS1Z59hUWRCK+8xqpU138i3FWfmpAemQ1XwRLC7/z6hRKwSF3oByRtGOdsN?=
 =?us-ascii?Q?u10uDiskjc4IvZ8DBbLHpZ7CFk0UUSSO/OGJLkiy8BQ4nT0y2a2UeeSiQ/62?=
 =?us-ascii?Q?WoiSoaERpFKyfrgqbA2UzbpDz+57anv3zS47uZHiHWLRBwmL44Pk5LY94vVI?=
 =?us-ascii?Q?ZXuwhlInXhlueVVkthSGu7Zj4X0+lOQZ1cid1F9KcxOKsBsxW3WTXl486xzi?=
 =?us-ascii?Q?QrnlvRidWOCsoRoFN3bdt0bmZCLv/fcj6Sia+o8tcx34kpb+JmcWWmv9+222?=
 =?us-ascii?Q?uWo8g50DV5t09pYOxC+OLPyGAyWm9YMHdql2AJeTxYGxa+L/MELW9I1zr70O?=
 =?us-ascii?Q?M8J25UZ1AkdrKnzj34QpmSuUX0aAw58t72xsQMeXQ82wtB9HTE81xWOCm94e?=
 =?us-ascii?Q?Ja0VOliTSTCmgdGrBnEFQsayJpVvPVKkoBg83E+lYrvOr/omztwLRKS1IPNr?=
 =?us-ascii?Q?i1eTjvKcgW5FCwgsWkHB0oKpn6RjKAkj6TYMEj6+3nEEQewdm6vjcgITVo+1?=
 =?us-ascii?Q?X+/JWxM/ngsa8T4ILFsEFZHImGigZxxV8ip6HFTZ8OXs0oaLXXahYqygO/RT?=
 =?us-ascii?Q?EVUqr7fAteyA+fqGaM6J1Sg+s3pT99p/4+2Fcry3mUZDH4dMG2Zc37MmoRad?=
 =?us-ascii?Q?X18f+VLnpwHRZzUx20xEE7RH4Wnc3gNrUwLWVE9Y0qKiI66cN8mbsHciOhO6?=
 =?us-ascii?Q?WlnRr6zkSFdwN8PX1UteTLD/MeLIpUYIPuSJloQGXsG8mwewSVk9P8bsgxNZ?=
 =?us-ascii?Q?gr3FMSz5EHvBOWTko8LtIsfXPzriMzodhvUHeZZsvqP/ZkLRjMvhI5cZFCuc?=
 =?us-ascii?Q?jocSL0+0zZW/omDVZu019BHnRXAHDPstzJOfCBb5xIN9ZOnuxW+Lb96mb18X?=
 =?us-ascii?Q?xo7Xy/xBGeuP2z7Uw4wGXVD7atqpOgrbOLsOVDvVNz8Yfp5rGKM9Cv8bjDOK?=
 =?us-ascii?Q?wu6zwW88iFMNoNgLy4OmrIBKXxs2cjhy1uydpO37MSsy+QJiMIo2vQTRDXD8?=
 =?us-ascii?Q?tpsQPLntQ7fApJHpIWDpQPHi0DhyTYDSwNpPbXOFWb3x9juYIkEK+neKvRRh?=
 =?us-ascii?Q?f8dbpgsQ3G8esrEo0pb4hdC+BtGLpVzB2X8psClVXIF9pvdQ1Bg9sM8fEwc3?=
 =?us-ascii?Q?JVgvwxDcKaJ+lk1o8y9B4qj6BT+mhZIpdtVgLdy4D9Mb9AD4fmBicEdqivJ+?=
 =?us-ascii?Q?G1de2YthPz/K/iNQkwNyGU/j1N61rqGGixnM+osllOHKMq7kATBVS2dAONr7?=
 =?us-ascii?Q?sleB23007ar/iSo/ZvwfgtLxC/QrD3De?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:01:48.1382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 712faec6-6a0f-4521-de8e-08dcc6b9f05b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8440

With a viommu object wrapping a potentially shareable S2 domain, a nested
domain should be allocated by associating to a viommu instead. Driver can
store this viommu pointer somewhere, so as to later use it calling viommu
helpers for virtual device ID lookup and viommu invalidation.

For drivers without a viommu support, keep the parent domain input, which
should be just viommu->hwpt->common.domain otherwise.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/amd/iommu.c                   | 1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
 drivers/iommu/intel/iommu.c                 | 1 +
 drivers/iommu/iommufd/hw_pagetable.c        | 5 +++--
 drivers/iommu/iommufd/selftest.c            | 1 +
 include/linux/iommu.h                       | 2 ++
 6 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b19e8c0f48fa..e31f7a5fc650 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2432,6 +2432,7 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned int type)
 static struct iommu_domain *
 amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
 			    struct iommu_domain *parent,
+			    struct iommufd_viommu *viommu,
 			    const struct iommu_user_data *user_data)
 
 {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index fa75372e1aa9..6d40f1e150cb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3347,6 +3347,7 @@ arm_smmu_domain_alloc_nesting(struct device *dev, u32 flags,
 static struct iommu_domain *
 arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
 			   struct iommu_domain *parent,
+			   struct iommufd_viommu *viommu,
 			   const struct iommu_user_data *user_data)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9ff8b83c19a3..0590528799d8 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3703,6 +3703,7 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 static struct iommu_domain *
 intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 			      struct iommu_domain *parent,
+			      struct iommufd_viommu *viommu,
 			      const struct iommu_user_data *user_data)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index aefde4443671..c21bb59c4022 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -137,7 +137,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 
 	if (ops->domain_alloc_user) {
 		hwpt->domain = ops->domain_alloc_user(idev->dev, flags, NULL,
-						      user_data);
+						      NULL, user_data);
 		if (IS_ERR(hwpt->domain)) {
 			rc = PTR_ERR(hwpt->domain);
 			hwpt->domain = NULL;
@@ -239,7 +239,8 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 
 	hwpt->domain = ops->domain_alloc_user(idev->dev,
 					      flags & ~IOMMU_HWPT_FAULT_ID_VALID,
-					      parent->common.domain, user_data);
+					      parent->common.domain,
+					      NULL, user_data);
 	if (IS_ERR(hwpt->domain)) {
 		rc = PTR_ERR(hwpt->domain);
 		hwpt->domain = NULL;
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index b60687f57bef..4a23530ea027 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -318,6 +318,7 @@ __mock_domain_alloc_nested(struct mock_iommu_domain *mock_parent,
 static struct iommu_domain *
 mock_domain_alloc_user(struct device *dev, u32 flags,
 		       struct iommu_domain *parent,
+		       struct iommufd_viommu *viommu,
 		       const struct iommu_user_data *user_data)
 {
 	struct mock_iommu_domain *mock_parent;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c16ffc31ac70..f62aad8a9e75 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -42,6 +42,7 @@ struct notifier_block;
 struct iommu_sva;
 struct iommu_dma_cookie;
 struct iommu_fault_param;
+struct iommufd_viommu;
 
 #define IOMMU_FAULT_PERM_READ	(1 << 0) /* read */
 #define IOMMU_FAULT_PERM_WRITE	(1 << 1) /* write */
@@ -564,6 +565,7 @@ struct iommu_ops {
 	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
 	struct iommu_domain *(*domain_alloc_user)(
 		struct device *dev, u32 flags, struct iommu_domain *parent,
+		struct iommufd_viommu *viommu,
 		const struct iommu_user_data *user_data);
 	struct iommu_domain *(*domain_alloc_paging)(struct device *dev);
 	struct iommu_domain *(*domain_alloc_sva)(struct device *dev,
-- 
2.43.0


