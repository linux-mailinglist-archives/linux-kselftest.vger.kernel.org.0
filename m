Return-Path: <linux-kselftest+bounces-20729-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C77279B1378
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 01:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566BD1F22490
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 23:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CE1217663;
	Fri, 25 Oct 2024 23:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lrJ6g8x4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C283D214435;
	Fri, 25 Oct 2024 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729900237; cv=fail; b=I6iaBfxUVTRfHsAeOfnOl8FuiRpKur6n0f2hg/uiuLYsumjdEuSxynqvf+vD74TZ9niqK6nt7lPW7WhBgxsm2UR/Knp5R09WAPSGDiJ17uK8C+hycWqkwWy0Mpz4wftj/W2bDCzcyezjYCNcTi/zj+f/9GKZMQOdieKR3kQwiZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729900237; c=relaxed/simple;
	bh=bwACzcBAafAqVUp2e5iOeBGDd9q9DRJbWzNDt2bEavA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FmAuPKgJWMM/58rBfwU9uYAoUDrOvCUOxnnR4TEAG2UF7JLSQHhjd8Er89yYpawqmNQLSjZjHW7Pf3S2y42TVnWZXJDyjci3S1RGXvY+5AT5ZO8B8NT9YTQrNjE74jgPPlgvShJDfHJpgnYedRFLJq+rRdEaq6WdroqyXSwKevo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lrJ6g8x4; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aw2zaoo5AKsvRpbXELPAxFfGsDKIBFtnkJB3lX9HhDiDVLi1EOe1ZGPSaAbzyUJosBrd/BDepqpamScmETACNkCT1q2vGBF50YKld+KBSkJPI7Xy16EDyKhLFiFZx4x5dYosZC5zclq1wtYMcqNbPS3cOqzQGf65dCwmL1x/JtELfZug0OJ+e5kBcJ8D6yXHQKiHl2s66XDNENUzZibtUmIsedLdC13FvcviQd7z3T+C0vRN4N+QT5xMXfFMHlK7XhM2pC1Ruk/07xHO8MQLIV5DEVpTtMBiS2PKNLfjAhFGAAD0FEH3nnxgfkDPc4l6oDAg3INAWGjRDYVFIFqKyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5O3rHBAqM8z/SyW1LReeB/G6Z0L+h/rr1RoTNnqO8ZM=;
 b=qUpGrGHGz1P2FVSMDiHLdk7vgk4ZSnSvrdWAJCDBJP4Dox3xAbw9uE7Kado4UzA+DQ95TKJIdhn2hr0l5Hl7RF8dTx5acVdiYR2UCA2N98zs8Lq4BLts97f7MWqgZxr/YwcNfoDjxi7h0PyKkGutV2/U59syT5ntXp1C46nBNVzHbPAAiOa+9cGRV6mES7GsF5mrmgOeSOQphdC1WEFe62tRRg2liD8+pY2ehQ1E7da2QKkRgwClkT6ad9guIvQoD/Hr3RRbQcz2+b4llgjhmHJyF7hYOmWNxAGPTxY8IwpNVZhfm00U685D+Wtt7P/JHrRW0XOXW+52tE/bKxxmAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5O3rHBAqM8z/SyW1LReeB/G6Z0L+h/rr1RoTNnqO8ZM=;
 b=lrJ6g8x4PYcZxf/sg+yCyG0yX0PHENOPJ3Md3Fok7X6uw5Kbf4Q/hJvuPjUE4QexLA9XoXVE2Gg5tFaNroUC62gwAVwl/5lU/k6JL5o0MMzLZSS8cN4DSysoq5HDdD/QrI+jwP72lRnh54w2ps8J9hoA3r0jo+N9aN+gdqgh2hZcNx/MGuPr8wqdlP6d1ImQbL0CoVWV2mW53CloYqiGSQzDoLaUcnMlLEUl7yHUrjzmyuw7ucLTpMkwJseAxNzI42SmTLWHVVXLwHXSFdvR5SOJjMiu/ZSmkLEtqCTmDkRlbPQI6zthYnN+4RYgztAomTkTnFd3OtHlZoT+sLfOLQ==
Received: from MW4PR03CA0252.namprd03.prod.outlook.com (2603:10b6:303:b4::17)
 by SA3PR12MB8021.namprd12.prod.outlook.com (2603:10b6:806:305::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 23:50:30 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:303:b4:cafe::40) by MW4PR03CA0252.outlook.office365.com
 (2603:10b6:303:b4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23 via Frontend
 Transport; Fri, 25 Oct 2024 23:50:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 23:50:29 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 16:50:16 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 25 Oct 2024 16:50:16 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 25 Oct 2024 16:50:15 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: [PATCH v5 10/13] iommufd/selftest: Add IOMMU_VIOMMU_TYPE_SELFTEST
Date: Fri, 25 Oct 2024 16:49:50 -0700
Message-ID: <30f593e688e881b8cfee007e2ed2eb7a190a01d5.1729897352.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729897352.git.nicolinc@nvidia.com>
References: <cover.1729897352.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|SA3PR12MB8021:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b819e88-d332-49d5-8365-08dcf54fce77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QRpvsfX+rcSj397wbGSC1fGQFUC1Mms3SwS1Oa53oywuUoCuHDD0ThSFP7Td?=
 =?us-ascii?Q?Yu+d2u/O2IyMS0TPYRbkXsk9dOXGz8WAd8KHkvjcZF/LhG2ILt1/9VVEvam0?=
 =?us-ascii?Q?5lLJ/LJZ0TcXpX8eGAUgWEff+7qDKDuqE+eGQT7zkq6rGDxsSmUMqLNEruM/?=
 =?us-ascii?Q?f9AozAEWyrMvkv3PepKmomPeazODv4FGwDmOiH+vlb9BRn1NbIDehbZ5+rNM?=
 =?us-ascii?Q?7luXmZ3g4R7dmBNu8a/pDX2D8M1d+QcpiDFWzSeVWHAAOIZoAaQTH4BDY8O/?=
 =?us-ascii?Q?Xd8lg283jvhTiJY2rEvKUoAWJ9ouMDuZ1gbCNhLPsn+VWxcSXYxH5LN4kRR/?=
 =?us-ascii?Q?UDufi2wEyhwxFb0XjrCq1G+1e/N+HI2ufB7oB70PEcfZYOS2Um8QMtPM7sdg?=
 =?us-ascii?Q?2HMTjOtpOtnPPKwW+rZOsrjER82PJwOGWS+j+Eg8gIsXnWxOF0ENU9GRNYMq?=
 =?us-ascii?Q?ymIYi723MPT7Gw7u1B2BnN6J3+LkpUeDtuVFf3p08avqsQXr4pJSL7TYlmXe?=
 =?us-ascii?Q?/BXSoBZx5w0DCimAf9PE85nnrcvbRvFDiqIxh+aRFtBT+JOolepaW0OTcHSK?=
 =?us-ascii?Q?e3dIO2Ojkf13mCzykX58FVEJUmGQyQLyykqwXM0/Q1THY42VNJaWSRrIYSAR?=
 =?us-ascii?Q?edawXvfJQzemlRHb+cO3MIoxwSaR/k25WF1dJqRmvDVzk/mxcdcU1K2KCkZW?=
 =?us-ascii?Q?Il+fVRs919UABzZPiWsHoHPltlKIDEeAvoQwC7HK0Fp5AlD2Z2HopNx5gzlF?=
 =?us-ascii?Q?Nl6psRRy4o+u7BZVjXXJgdyyGHggn8g/QIiwk3CxHHo81FgzgqJ4hboEaBfI?=
 =?us-ascii?Q?FFDDU2qKRDMYkSjGhV5SEEsa3iZ21OuRDJ6lOmEFhOmMiEfftvUGd0PrzxxO?=
 =?us-ascii?Q?2N3Y9/utWsojDUErKqy9yYjC47OfCtr1yZ9qG6sQIxn3jxJYkxonuv4K2KCU?=
 =?us-ascii?Q?f7mLFqkqNZp8x2CieJd/JSDzNSM67ifr1JX/G9jlliKHxVy2p1vHygvsHE1S?=
 =?us-ascii?Q?DYzr3vBiI8TkVw2TE0d4yDj2UHJ6D0j+elbDaM1VuFx3YYibKtFTVRdAiHJ/?=
 =?us-ascii?Q?jeB/LiASbzTUJ/a0q9pOJ81xUaFbLIXw4Bc/7MXheNQPVDCeDds8n2D20Hts?=
 =?us-ascii?Q?nYaUnUYBd/DgsLkyM35XxwpIMIAGMTnxs1uVNvF6UhRvdPS8tWApbNIPInn1?=
 =?us-ascii?Q?LzdVg4OcpN8+8+z5tUzAS3cBDPhCUNLa1UZ3uQHcngOE7kfQUFNqtHpfxOWx?=
 =?us-ascii?Q?LIznY/6K2b2eyCDGF0dNwbTojNoC4V9ZRmixuNkUTSEfnR96XaQxtvqF7XSA?=
 =?us-ascii?Q?89Wxi0F9lTZ8diF0veCdyvxw4UiKBu0Ky6VcHNl3lp3ZoF9F988W472yBHcL?=
 =?us-ascii?Q?UT1o95hF8CyIWlD7TLEdEPZMjVTfradyyFhHjRQYIjEkCzUwAw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 23:50:29.4146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b819e88-d332-49d5-8365-08dcf54fce77
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8021

Implement the viommu alloc/free functions to increase/reduce refcount of
its dependent mock iommu device. User space can verify this loop via the
IOMMU_VIOMMU_TYPE_SELFTEST.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h |  2 +
 drivers/iommu/iommufd/selftest.c     | 64 ++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

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
index 2d33b35da704..33a0fcc0eff7 100644
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
@@ -569,6 +580,58 @@ static int mock_dev_disable_feat(struct device *dev, enum iommu_dev_features fea
 	return 0;
 }
 
+static void mock_viommu_free(struct iommufd_viommu *viommu)
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
+mock_viommu_alloc_domain_nested(struct iommufd_viommu *viommu,
+				const struct iommu_user_data *user_data)
+{
+	struct mock_viommu *mock_viommu = to_mock_viommu(viommu);
+	struct mock_iommu_domain_nested *mock_nested;
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
+	.free = mock_viommu_free,
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
@@ -588,6 +651,7 @@ static const struct iommu_ops mock_ops = {
 	.dev_enable_feat = mock_dev_enable_feat,
 	.dev_disable_feat = mock_dev_disable_feat,
 	.user_pasid_table = true,
+	.viommu_alloc = mock_viommu_alloc,
 	.default_domain_ops =
 		&(struct iommu_domain_ops){
 			.free = mock_domain_free,
-- 
2.43.0


