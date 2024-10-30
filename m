Return-Path: <linux-kselftest+bounces-21171-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FA49B6F46
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 22:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F981C2257F
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 21:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A74C2296E6;
	Wed, 30 Oct 2024 21:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MfFN2WQP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501A52296DA;
	Wed, 30 Oct 2024 21:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324134; cv=fail; b=Hc8wDzX4ybxe0soKJnp9we2scVhHZ3Mf7LDQwTowRjJrmE1tjTlzzFIsy3XrxC6SVA++Dw6d3PN9poMQDZh6Lq/mKMtSYp/MPWXqFcQEHzphzXcNiEIog2Erv4qyUHgZoT2NVJxr7F/tbM/NTwtPo3T7VPsgz4Emjdh2zar9woQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324134; c=relaxed/simple;
	bh=XAnHHsXmfB9omCBKJVEBuBtMUpCwsE2Iax9K1of39lY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cnlsfyXVCSRMC6kzVoWLb3GPaNEzUX1AzN74C7PaWi3+xMuCi32LEzkMOrXhoSSsgEBhz+IyA+rOtAuDykG0tDC4jKZn+rqxuWYf53C+A2KzUwr0jew+yO44bIoDRkxoiyt87NMB20F48njsVjJazK1Akh9dgQQcL/Hcd8i7ey0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MfFN2WQP; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKN/kb+SMl5z/AcdUGKgBebNRSJFEsSH7r3FfKUbjqpCRNMs2KjuKG7+psSTge4JcqmumgBqGc909+UO7KYOoA6lbV2qDMSBISjY2aFV+E/TsrnSaLW4klZauSL8G70NEuXtBZT8vkhJcmwL0t/XFwBto/7lKvpshgFmhST0KNUDGhRs2h466hoydHLtc/526qPDKsDd7XLtfpVDAAjcGBB+9t9NmQhyWxD/mMNfjoA2EAVgEivXwHYtr5UobfmXAa50mZZYZm3GuQFqJXnsvROfKVYoqvYTLaqsLb3pjqtqxIfmeHW5ayN/53kOw3+mHCp87MhPiRuQdAloJTOqyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KzkVgcFO0ftegl7pn6y2UsVmj7zwEHZ8Ed8lJfivy8=;
 b=fmor5LrRIX5DD5aER5ywVYL3pvM/Jk/VDjroO9IXuz3+4aA8uEM04S+6abuPC0mgjGwbl/KVCcNOzlgM5ACnHLCZFMu0rkUVtbp2/5ymyDT1eT+eFo0ajVlS6Ka8eDZdVF3CU0naD6usRxp3c67kzr3655H41WYWgASuWJbIodU+xcKz2hGR2TFVye9cAWjwGRuzRLAS9sCgQQwGYPECxHE+Kooowe+3LxCgC3J5ul0GTfjCq7k04FsyU1pciBzVriTq8AbakK+sMitKfTIG+TYZBML3GWqwc8Yo6oUdYYdVMfQ0ytA6VR5B5lZqUF2SX3DLocUEJZi96PWKfLs0yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KzkVgcFO0ftegl7pn6y2UsVmj7zwEHZ8Ed8lJfivy8=;
 b=MfFN2WQPgzuUrhAWjp6F8lc1NlDRwQuDap8Qi7u3jgpXz0NACbmsksSxqLtIAZ9fiMJtI7GpqsEBKeEorHmZHpngn+I6YtyhRT8nkqMZaJTp8/FCQ361s5QLvztL4pTQHqacl60JjJ2NSrqyD8itm8DHLAZACh5JOXoOANfA+ATy7qmWAggXHfYKHPGM/WlMIMmoO5J9UQhekj/HUhc41rChmEqNtOkm12oTAOBh7qW2jEd0CkL0hvNGnsl1l3GKmYTQMLHDRKwXuYWiiEhETqfFie9Ts7X/06ukROfnARXm8F10krz+attjGwJxBWF+vKXhT3q66LfG7ed/aEntkA==
Received: from SA9PR13CA0143.namprd13.prod.outlook.com (2603:10b6:806:27::28)
 by PH7PR12MB6665.namprd12.prod.outlook.com (2603:10b6:510:1a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 21:35:29 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:27:cafe::d3) by SA9PR13CA0143.outlook.office365.com
 (2603:10b6:806:27::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.16 via Frontend
 Transport; Wed, 30 Oct 2024 21:35:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 21:35:29 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Oct
 2024 14:35:11 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 30 Oct 2024 14:35:10 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 30 Oct 2024 14:35:10 -0700
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
Subject: [PATCH v6 11/13] iommufd/selftest: Add IOMMU_VIOMMU_TYPE_SELFTEST
Date: Wed, 30 Oct 2024 14:34:37 -0700
Message-ID: <3f2c6db0a7a5ad0209c61304b6c5348a8d3df6ec.1730313237.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730313237.git.nicolinc@nvidia.com>
References: <cover.1730313237.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|PH7PR12MB6665:EE_
X-MS-Office365-Filtering-Correlation-Id: a47c069b-b154-4706-1918-08dcf92ac673
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?an9fYIR2N6W6XVIBID+5+bJzvkxgs2wXDotrHtooaDbqGx03OYHCGaZZhZw2?=
 =?us-ascii?Q?rYvpoYHgfvTJHazGWdS9tMzhzejIuWtNhl3ukp3nrTP+NCd2EIDqkQE/dkWL?=
 =?us-ascii?Q?Y4IlS5ah+Yap6yOxj/lIuPb8eCLjlrKfDFUmHvDBAvWMEiIO0hVl2FrDhUwG?=
 =?us-ascii?Q?lVbxr+V/6Rr+MEpaL9rEXiAO47Ne1NfC8T4VEpj+I6i5A75m7d3eb2ybGaS9?=
 =?us-ascii?Q?2H3O8jotwZ4S9/ZUM/oSWGHV/dhmdn+51ffJEw11h4fA2153AjbK0iVrOgvr?=
 =?us-ascii?Q?4B3pRCckT+QRYdQFqogGadhyY57lsrl2aIIR2ROw37+RfbIfRFr1zHVdCz5N?=
 =?us-ascii?Q?8aG2dyEC965XYkJpcLvRB1wylp7EFBSj4Woc77/pECdJQ1KSbBctjGUeFFcB?=
 =?us-ascii?Q?7/FjWJYJAlqqoAFK69CRR5pnl7UrRMx+/WGFGUnPAE3kRf9MGkib9lkjPEG/?=
 =?us-ascii?Q?/qY90csaAczgwyuQqkKZS2U3yeJcW20z9NoOFsoycyeDF4EDKMliUVhBqByu?=
 =?us-ascii?Q?kax0h3tJXDNet0CWel4XThXFCbLp6e8BDzv7G8RbtE/2PButoYOS27W/sWtr?=
 =?us-ascii?Q?l4bdToP1eVA13wzzIfkZFgrg+n1lO26MYLe86QMc2rhNFKBPRQuHIpcwGpoJ?=
 =?us-ascii?Q?/sjBVfZWIPVLTkfatUbIpVIGEoA47E3fUYq+1iJLYGJjLj/MWiJh8pJTymZO?=
 =?us-ascii?Q?4JPvnwIS1Gj7kHWTxP1tqnvLKObJ6/tKpBtMzc+T8v/9ySecn9r1riFYW+z6?=
 =?us-ascii?Q?EQkEj8YvFRVmjWnOn57cTj1Dl7ktSMKALKBSAgdSr18Hd+1A/DsXifIH6b2X?=
 =?us-ascii?Q?NQaCdMplnzgr6b8wSEi5ctCTUa4BHjiQWnx2uZv+/OCnJmnRQuOoiHDh1Nrl?=
 =?us-ascii?Q?K6pcNQrpksMv4lZQzeM5gcJoamrksfxAvAK38AO4qvXYkHZGBSgln3F+T5BO?=
 =?us-ascii?Q?CEBICVtyn9XgC00dy5/NXY4bM3l+Ii+BtVNeebyw3B/q1UqkCz7i+KBpVNFK?=
 =?us-ascii?Q?BTiXWdBPJc5VxZKX5hf27k02ozQ63z7wMv2D8bEzMOZLu9+C/Ub8Zz44Vl5s?=
 =?us-ascii?Q?AUJZB5lAfnXOOml2e1pSLyjAIkXr0IUUaApNn57uYdATryOUyDuBBiXso0pO?=
 =?us-ascii?Q?jsOCN+hEVfhwEQ07N/jPZiwxbqYhv/BLSyOFuDQsYhSHUyppAZCT0boIpccu?=
 =?us-ascii?Q?tHN+KoRxVSOmcyDLcYa6hFij5h2hMVVQjTqTgRDVDwvO+xqN+Jnhz7Dr3qtR?=
 =?us-ascii?Q?eFZgkuJ7+EsRZB9X9Dl5BsLoMf0GbF4EFTM0csIwv7sliRCUR7uJ/pFmumGB?=
 =?us-ascii?Q?XtvkNm5rusJ/MznReFpmQSKtfl8VnNWRe4rU/KQRlcZPrEb1CfF4tGJx8Jab?=
 =?us-ascii?Q?uX+ohVeMez2uK/TEZAQGrHFY6Lb8ztAVukF+70P1Nth1aUW4ew=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 21:35:29.1736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a47c069b-b154-4706-1918-08dcf92ac673
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6665

Implement the viommu alloc/free functions to increase/reduce refcount of
its dependent mock iommu device. User space can verify this loop via the
IOMMU_VIOMMU_TYPE_SELFTEST.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h |  2 +
 drivers/iommu/iommufd/selftest.c     | 67 ++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

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
index 4f67a83f667a..31c8f78a3a66 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -134,6 +134,7 @@ to_mock_domain(struct iommu_domain *domain)
 
 struct mock_iommu_domain_nested {
 	struct iommu_domain domain;
+	struct mock_viommu *mock_viommu;
 	struct mock_iommu_domain *parent;
 	u32 iotlb[MOCK_NESTED_DOMAIN_IOTLB_NUM];
 };
@@ -144,6 +145,16 @@ to_mock_nested(struct iommu_domain *domain)
 	return container_of(domain, struct mock_iommu_domain_nested, domain);
 }
 
+struct mock_viommu {
+	struct iommufd_viommu core;
+	struct mock_iommu_domain *s2_parent;
+};
+
+static inline struct mock_viommu *to_mock_viommu(struct iommufd_viommu *viommu)
+{
+	return container_of(viommu, struct mock_viommu, core);
+}
+
 enum selftest_obj_type {
 	TYPE_IDEV,
 };
@@ -569,6 +580,61 @@ static int mock_dev_disable_feat(struct device *dev, enum iommu_dev_features fea
 	return 0;
 }
 
+static void mock_viommu_destroy(struct iommufd_viommu *viommu)
+{
+	struct mock_iommu_device *mock_iommu = container_of(
+		viommu->iommu_dev, struct mock_iommu_device, iommu_dev);
+
+	if (refcount_dec_and_test(&mock_iommu->users))
+		complete(&mock_iommu->complete);
+
+	/* iommufd core frees mock_viommu and viommu */
+}
+
+static struct iommu_domain *
+mock_viommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
+				const struct iommu_user_data *user_data)
+{
+	struct mock_viommu *mock_viommu = to_mock_viommu(viommu);
+	struct mock_iommu_domain_nested *mock_nested;
+
+	if (flags & ~IOMMU_HWPT_FAULT_ID_VALID)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	mock_nested = __mock_domain_alloc_nested(user_data);
+	if (IS_ERR(mock_nested))
+		return ERR_CAST(mock_nested);
+	mock_nested->mock_viommu = mock_viommu;
+	mock_nested->parent = mock_viommu->s2_parent;
+	return &mock_nested->domain;
+}
+
+static struct iommufd_viommu_ops mock_viommu_ops = {
+	.destroy = mock_viommu_destroy,
+	.alloc_domain_nested = mock_viommu_alloc_domain_nested,
+};
+
+static struct iommufd_viommu *mock_viommu_alloc(struct device *dev,
+						struct iommu_domain *domain,
+						struct iommufd_ctx *ictx,
+						unsigned int viommu_type)
+{
+	struct mock_iommu_device *mock_iommu =
+		iommu_get_iommu_dev(dev, struct mock_iommu_device, iommu_dev);
+	struct mock_viommu *mock_viommu;
+
+	if (viommu_type != IOMMU_VIOMMU_TYPE_SELFTEST)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	mock_viommu = iommufd_viommu_alloc(ictx, struct mock_viommu, core,
+					   &mock_viommu_ops);
+	if (IS_ERR(mock_viommu))
+		return ERR_CAST(mock_viommu);
+
+	refcount_inc(&mock_iommu->users);
+	return &mock_viommu->core;
+}
+
 static const struct iommu_ops mock_ops = {
 	/*
 	 * IOMMU_DOMAIN_BLOCKED cannot be returned from def_domain_type()
@@ -588,6 +654,7 @@ static const struct iommu_ops mock_ops = {
 	.dev_enable_feat = mock_dev_enable_feat,
 	.dev_disable_feat = mock_dev_disable_feat,
 	.user_pasid_table = true,
+	.viommu_alloc = mock_viommu_alloc,
 	.default_domain_ops =
 		&(struct iommu_domain_ops){
 			.free = mock_domain_free,
-- 
2.43.0


