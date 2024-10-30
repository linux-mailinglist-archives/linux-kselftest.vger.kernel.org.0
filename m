Return-Path: <linux-kselftest+bounces-21170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C109B6F45
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 22:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4C5B1C226CB
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 21:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6611D2296DC;
	Wed, 30 Oct 2024 21:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rMWuMLpB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AC22296D8;
	Wed, 30 Oct 2024 21:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324134; cv=fail; b=AVq1yYbvVtg4o9vNkObsN7cMvV3zBCc3IGEOCm4ncQGZEoe/um7J/2yE6djDrz1ObBDIk89HIvr2Eq5jjSJP5vjH4WgiOgE63huUAY3BeNWvv2RTTmac+0Xugu1qmjBOKRPwnbuMpP3qWT8O3Iw1RCqR3VldMoW2SNT6Glg5IuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324134; c=relaxed/simple;
	bh=gGhsKUAuS3tN+ZVvOMxcUVmYnU4xo6EcIIjj8fa0HYQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dpfSSAQh6by+AOxAW45IuHRv7eS9Z2QRvyX8gJuG3Rn7CYDnfrL3yIjZPkZmvOqbV0bLrrFPRQUDkXifIt/Ox4CmdYND6NRCLzKTI+53gqMLk0Y7JUuktRmSeaBhTOM+scsVIgeLEP2Abnp9waoZxiuZtQ840iVjsFGn8v2KJEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rMWuMLpB; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CSsQwhmyyAPxgBBMZFe/qAOljT9d1hEE7ERciKGrxjqMT9hsA3WXmae/CwOnbFZyNzfFmCWwm0cYK8kphsjk4mEtIQ3miRN0iW6VjxzBg2SZs1zP+TxH42J4B3yGUxFdtsQG307Fw6VoTibujDKbSNRTv1KIG4ZItf9uuscuBcXknAAuDL7I1ZORvpFwVFolb4ZcM+1uefOKvnZFun0DJ6Xt1/9dLku3RuTgi3nIz4uVQtLVCssP0sIqqa8U6vcIPjoODTMDCFiKoQpfbXYTNgjGmBKgBao41SdLviIc1nsrqhEusro7PdpdAWI4pquUPk3iznG3Wt2ZJe63Uj4s+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUbjJXnib9EiC6H9vV18C3nn1EiLRyVYUNzy8Y9BqNA=;
 b=EtqxXhbqAmwUl4Rkt5VWumHZkxCEXpbgL2ucZdcyRcEUcM56rAQcmzRFwh9m5H1lpyUF1O1aaXm9xYAMXC57ZR1Nt47HdwQIy3HlDK58FQcFzPyLwM/HSmXHw9f5wdNTar+Gb1qJAvxZs6QW9SVz4cMeIDsKv6FdSCD0urVJ/tAXNw/UHi5kZlX6V4KPT++ksmS9aRpDefzeCD/yjoBcsG+khjhF6JSd5k74DlfA/SmOAfftrTI29u8jwD4S75oQUtRLgTn8+yrlFVGP07318FY51Dt6j/fXyuzwnIe94r1DmJLgu8sfhyF38KQkm38ZfjHz0fuUM6uq6yBHXvTRQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUbjJXnib9EiC6H9vV18C3nn1EiLRyVYUNzy8Y9BqNA=;
 b=rMWuMLpBYFzZLmYmpN1nfeh6M37A0UlcQw5YnyZEU6ZdUEo0Nc+0qXSUqpWZ9M6iQg9x0CD83TU+6nf+np7DMKteA4sbOZ3hKG6M08qkzYVttOrEc/aNQiCB3it2VPD+4nuwtNE8OP4y1OOl6leasdT3OUbI9u50mjOKF7L3baD90Qq6cQ63L/Q2rapnz/zKOTd1p8+qLuK/TxHtEqiFvXxalnBGpIXLrNBDkiixhuE4GZcqwHOE0yeCQRAFbE0t8/gt1zWfssXkHBVG4g9wGxYEa6LSMITgaHTAm2m8+Vb0jBaAxpBoIMBATi3kzB8pXir59JRxIrs+xWHplpChIQ==
Received: from PH0P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::35)
 by CY5PR12MB6370.namprd12.prod.outlook.com (2603:10b6:930:20::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Wed, 30 Oct
 2024 21:35:27 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::3d) by PH0P220CA0012.outlook.office365.com
 (2603:10b6:510:d3::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Wed, 30 Oct 2024 21:35:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 21:35:27 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Oct
 2024 14:35:08 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 30 Oct 2024 14:35:08 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 30 Oct 2024 14:35:07 -0700
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
Subject: [PATCH v6 09/13] iommufd/selftest: Prepare for mock_viommu_alloc_domain_nested()
Date: Wed, 30 Oct 2024 14:34:35 -0700
Message-ID: <5b8362c4b2ee64cc777a5b223661e7202a3fbae9.1730313237.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|CY5PR12MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f37c0f5-627a-4e21-5ec5-08dcf92ac554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wHlw3G4IZixTiXaet6OLK5t7slf3LFYSH1CeWAGDibmjGdffT+QETs5SllMB?=
 =?us-ascii?Q?GDXQE1cU/aZFVzDr0dqpfRGaq6gESB7C1LjPbg7Dw17e+YaXJ9HN1T9tXsUX?=
 =?us-ascii?Q?xBiRxS1MQcDCjCaerPEropOHDLBbV4Y98ELO9CUXqs346JV7o5UCuVBJAN4L?=
 =?us-ascii?Q?Tjb+wF1j8trwgBMzOHbiOtCanmUZJfQ4DMCJ2+gFg7Y0guV3Os3ANQyOhKnK?=
 =?us-ascii?Q?nhtX1bUoXEJ3eiV82cPz7SokRSoSVUcfAWjeL1/QBQepdaftIa5+QIKiLxsD?=
 =?us-ascii?Q?Dg/bDireCrj5BxKU93yFy14hUrbifTvhXYbj1YMUlPzBSpzgzDv0bjlKIm6H?=
 =?us-ascii?Q?VlVFboK2zAnQSvUkvZ+MIDs7j1IN8VWgwwmxn87OGZ4Wnqt6/W6VBcIwu594?=
 =?us-ascii?Q?ycDbbzuekeUexbv/s13CxNiLTwmKwzmh+T/JYvtSXKx/JbGoBd7WeEBYt+fC?=
 =?us-ascii?Q?KSRED7bqqkAvzagHdU1vznKKo6J3GiRCLXc/xujL0qcyrGxgK+IbIyG+ZvhM?=
 =?us-ascii?Q?OMZRuyf5nuFgga6WSE9TGT6LTo+ZY97Hoi//T4rEPJ87LIOoO0lJDjFTmTj4?=
 =?us-ascii?Q?duEyJPPLktfDch1Y44k6ERPsQKh0rrRpX79bBqmcg5ip6kQ3ddD07epWTgQ8?=
 =?us-ascii?Q?KmGBnCe24W/zR+R2IDWIOpbfAP4+U0B68x20uvCUOeM4FBuIALmAOvubqFFv?=
 =?us-ascii?Q?GyBHUFQGlPJhEOIjT7cLYoD4yOWOGRaVGgPRPqgGa/g8eeoS8KIKTqVc1bud?=
 =?us-ascii?Q?N8dhNflNaTRgdj3GnEWQLupoCGgv4G0WzKGhEe+BzndRGc4HyR6bTAO+HzRj?=
 =?us-ascii?Q?opFpIV3DgYkSTlOvnyezz82i0VIIfVEgA/BOONW7QMgVwWUyUpXnN0sEC0Mb?=
 =?us-ascii?Q?1PDtkM54CPU7olTm678HsH9WV1MhE+5JjafIVVW0FACNMz1JvJCJMjIX/H25?=
 =?us-ascii?Q?EH+JBRdvXmIL94IL7ZW68rhHsjQHI+mTE0l+fqxYfYYVNXq8XrHfK969q6D+?=
 =?us-ascii?Q?z0KYtk55L0WfASgobaDt4eNXFLp5hFv/0FP6EyWqm5dF6PntcjaFanx8AI1O?=
 =?us-ascii?Q?USrmAvhyfLaKieXCPUjBgu2sm7cqiamQlGge3aeRXZ3rT03eXInpuSkhEpSX?=
 =?us-ascii?Q?ExTlpx/PSPkJqKPTmguJyO9NqFXlIpqZTJYGj4KcFUvjZ/ZNDuP+fjzenCU6?=
 =?us-ascii?Q?/RvnJkbKnO9AwuVwPX85xvKM+4a7YXLZQrex0R99j4RVT64hc0ymasQtp3jJ?=
 =?us-ascii?Q?oR/hYh/3YHwGyEzGzcpFiUWv4debERj9FGUOP4ddiHzjEXHlAel98Ev/1GSy?=
 =?us-ascii?Q?QAotdfNoEEbysaUWr1eyTLxMQvbalHy3BWGdQoDuef4Scfwac0Zf7iwt/tCk?=
 =?us-ascii?Q?31bYSAWRGTA3tRrKkrZbEiAciJUhAP4oXou+pmZSU2L078d4VQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 21:35:27.3101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f37c0f5-627a-4e21-5ec5-08dcf92ac554
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6370

A nested domain now can be allocated for a parent domain or for a vIOMMU
object. Rework the existing allocators to prepare for the latter case.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/selftest.c | 89 ++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 39 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 322e57ff3605..92d753985640 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -318,55 +318,39 @@ static struct iommu_domain *mock_domain_alloc_paging(struct device *dev)
 	return &mock->domain;
 }
 
-static struct iommu_domain *
-__mock_domain_alloc_nested(struct mock_iommu_domain *mock_parent,
-			   const struct iommu_hwpt_selftest *user_cfg)
+static struct mock_iommu_domain_nested *
+__mock_domain_alloc_nested(const struct iommu_user_data *user_data)
 {
 	struct mock_iommu_domain_nested *mock_nested;
-	int i;
+	struct iommu_hwpt_selftest user_cfg;
+	int rc, i;
+
+	if (user_data->type != IOMMU_HWPT_DATA_SELFTEST)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	rc = iommu_copy_struct_from_user(&user_cfg, user_data,
+					 IOMMU_HWPT_DATA_SELFTEST, iotlb);
+	if (rc)
+		return ERR_PTR(rc);
 
 	mock_nested = kzalloc(sizeof(*mock_nested), GFP_KERNEL);
 	if (!mock_nested)
 		return ERR_PTR(-ENOMEM);
-	mock_nested->parent = mock_parent;
 	mock_nested->domain.ops = &domain_nested_ops;
 	mock_nested->domain.type = IOMMU_DOMAIN_NESTED;
 	for (i = 0; i < MOCK_NESTED_DOMAIN_IOTLB_NUM; i++)
-		mock_nested->iotlb[i] = user_cfg->iotlb;
-	return &mock_nested->domain;
+		mock_nested->iotlb[i] = user_cfg.iotlb;
+	return mock_nested;
 }
 
 static struct iommu_domain *
-mock_domain_alloc_user(struct device *dev, u32 flags,
-		       struct iommu_domain *parent,
-		       const struct iommu_user_data *user_data)
+mock_domain_alloc_nested(struct iommu_domain *parent, u32 flags,
+			 const struct iommu_user_data *user_data)
 {
+	struct mock_iommu_domain_nested *mock_nested;
 	struct mock_iommu_domain *mock_parent;
-	struct iommu_hwpt_selftest user_cfg;
-	int rc;
-
-	/* must be mock_domain */
-	if (!parent) {
-		struct mock_dev *mdev = to_mock_dev(dev);
-		bool has_dirty_flag = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
-		bool no_dirty_ops = mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY;
-		struct iommu_domain *domain;
-
-		if (flags & (~(IOMMU_HWPT_ALLOC_NEST_PARENT |
-			       IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
-			return ERR_PTR(-EOPNOTSUPP);
-		if (user_data || (has_dirty_flag && no_dirty_ops))
-			return ERR_PTR(-EOPNOTSUPP);
-		domain = mock_domain_alloc_paging(dev);
-		if (!domain)
-			return ERR_PTR(-ENOMEM);
-		if (has_dirty_flag)
-			domain->dirty_ops = &dirty_ops;
-		return domain;
-	}
 
-	/* must be mock_domain_nested */
-	if (user_data->type != IOMMU_HWPT_DATA_SELFTEST || flags)
+	if (flags)
 		return ERR_PTR(-EOPNOTSUPP);
 	if (!parent || parent->ops != mock_ops.default_domain_ops)
 		return ERR_PTR(-EINVAL);
@@ -375,12 +359,39 @@ mock_domain_alloc_user(struct device *dev, u32 flags,
 	if (!mock_parent)
 		return ERR_PTR(-EINVAL);
 
-	rc = iommu_copy_struct_from_user(&user_cfg, user_data,
-					 IOMMU_HWPT_DATA_SELFTEST, iotlb);
-	if (rc)
-		return ERR_PTR(rc);
+	mock_nested = __mock_domain_alloc_nested(user_data);
+	if (IS_ERR(mock_nested))
+		return ERR_CAST(mock_nested);
+	mock_nested->parent = mock_parent;
+	return &mock_nested->domain;
+}
+
+static struct iommu_domain *
+mock_domain_alloc_user(struct device *dev, u32 flags,
+		       struct iommu_domain *parent,
+		       const struct iommu_user_data *user_data)
+{
+	bool has_dirty_flag = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
+	const u32 PAGING_FLAGS = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
+				 IOMMU_HWPT_ALLOC_NEST_PARENT;
+	bool no_dirty_ops = to_mock_dev(dev)->flags &
+			    MOCK_FLAGS_DEVICE_NO_DIRTY;
+	struct iommu_domain *domain;
+
+	if (parent)
+		return mock_domain_alloc_nested(parent, flags, user_data);
 
-	return __mock_domain_alloc_nested(mock_parent, &user_cfg);
+	if (user_data)
+		return ERR_PTR(-EOPNOTSUPP);
+	if ((flags & ~PAGING_FLAGS) || (has_dirty_flag && no_dirty_ops))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	domain = mock_domain_alloc_paging(dev);
+	if (!domain)
+		return ERR_PTR(-ENOMEM);
+	if (has_dirty_flag)
+		domain->dirty_ops = &dirty_ops;
+	return domain;
 }
 
 static void mock_domain_free(struct iommu_domain *domain)
-- 
2.43.0


