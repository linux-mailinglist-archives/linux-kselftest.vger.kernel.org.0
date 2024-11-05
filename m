Return-Path: <linux-kselftest+bounces-21479-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 557C59BD694
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 21:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86DA1F23AC2
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 20:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D31E216A2C;
	Tue,  5 Nov 2024 20:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YXdH6RTK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B669216A0A;
	Tue,  5 Nov 2024 20:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837116; cv=fail; b=TtjWVcoM4tutGrXY8cwvVB7lK4o3mPul77fpb/dwTCynxFjLkXj1RU5ckl5Z5SIGmrYTRykpZPGiE/uWAWTG3fpGiYWPVrNgDJ3e7nNoj9oym6LrbZwNt5SsOCh4UthpytodlJW3EMa5PDCHo+IHKrBpj3PtpH3HgMMsA4KBc08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837116; c=relaxed/simple;
	bh=XAnHHsXmfB9omCBKJVEBuBtMUpCwsE2Iax9K1of39lY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WP4H1eux8ynne/4v0vbVg5V39t4fjbn8EnR5EzsBH+ORmnPZoS0k9UN+AvwkOpe2CV32Q5bUMUVGLS9gC+a9UcYJE/qhmvdFcr3LHQlI9OM6U+fXw3+kAlRncrz2rbTPfAa+gjpfr4nhbMWnTKJfPGNSjAmRUB4TvyldOwykPkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YXdH6RTK; arc=fail smtp.client-ip=40.107.100.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3jAqIYZKLRUwQtqVrDfErdrYhlIYYNkBRGx/qMZ2Sfqpsvd8qZriLXuhvcJRJcbHkudUM1N5XQs6Y7HTElVx34nJmfo/2UbCrYFeUWNlJY1KcepUxxeDtqEYwDj1Rqfzq3tPCWIzzdQs04gn3bio3W0yZI/9PSQybt1tIOHRBhOmk/2a+6He9GLtiEuDKLFwdSU2lpLguAI2hIIyLuqyDDBFGNV62P5dDj9RogIUCbgkIi59ilSbL9sSoIaca75ZT+TiwUwV9CQy8SO7vIUm7VWTBHxir8UJLl/D0Ydn2lPJcZvKuIiTWEyqTaPFikdiMBWsHQDiO6N3e1ajJilCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KzkVgcFO0ftegl7pn6y2UsVmj7zwEHZ8Ed8lJfivy8=;
 b=Nf17FhKG6HZvUKiC/dtjtCRsdDzJJSWYG6y1VXTL8+NW1AiVQVWxwpkGfTPxzJY77/91koOwH79ytYMubwsy2p7CaqvipNTxYqwKL66Hk1m2rorGYs3vdFSfbwwNND14ffR+dBA8GFlSNjxXQzXRINcc+v04yGDL76QHdJVu/oquXG2TaiBKAW8YXCEgLmlhTAw0GnuLW0E/HPHZKjCCuJlv518EsW1S/sCuMqEb8Oe6xY1rM4UkSkSvLCZg3AXhADWZdPAPpz/WNRVReB/Wil6/vpoVlLIHdgQocCcz2yrTJmLw+WJFfXL/yDJnoNbBCoTlyJhHovlfjwgwyx4DSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KzkVgcFO0ftegl7pn6y2UsVmj7zwEHZ8Ed8lJfivy8=;
 b=YXdH6RTKiUW2SEgYHUl0wgvG7haYYnldkIbP6h+5lxoZFVH9t+gvWctNmSd2ibsH1I5XsoqneV/4yCU07liBrnTHDOl32vOJEM/YOVe7rVpRNiXFkjqL9c9XuRa2zQ63rWe3fM30vsxxk073oWt0IPxsVKQeKnxqdxi/qAeBG/2gJxmMZNWJwAiY8AWUW7LRkDv0YlgYtMHDmfcuqAnACokABjNKqtZbIr1CKiVoENxWxyxU9KKMtBTONPL3hu4ke8aKKQPWTcK7nvHsnc1xAfrPvD4yv9P5pziczGxUlgl9tO8BRTrR6fBmZ6uj0Oqt2g7UEGlasp7m/aYFLxF2EQ==
Received: from LV3P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::24)
 by DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 20:05:10 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:234:cafe::8d) by LV3P220CA0023.outlook.office365.com
 (2603:10b6:408:234::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 20:05:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:05:09 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:04:58 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:04:57 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 5 Nov 2024 12:04:56 -0800
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
Subject: [PATCH v7 11/13] iommufd/selftest: Add IOMMU_VIOMMU_TYPE_SELFTEST
Date: Tue, 5 Nov 2024 12:04:27 -0800
Message-ID: <9d755a215a3007d4d8d1c2513846830332db62aa.1730836219.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730836219.git.nicolinc@nvidia.com>
References: <cover.1730836219.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|DM6PR12MB4297:EE_
X-MS-Office365-Filtering-Correlation-Id: 353d9e5d-1826-48c1-ba48-08dcfdd526af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p0Zvd+x+eAtIXY3R5grbqwjyEmmoNY272PH1Hh/EFmndYV+IOmEwxcfx/OAu?=
 =?us-ascii?Q?DHbYxPXMDQ95Ap5Mpf1H8mTdx4fa1XEpohBG8EHuaZt7hy1OCOzCE0DdjJf+?=
 =?us-ascii?Q?hTbWCjnRebcAzurNopSDVtmcq4gpXA1ck+qPRUnSdWLKXxd8oY1GDKmjbuvH?=
 =?us-ascii?Q?W1fKnER/QwtyMuntBtfyrx5oPh+EBmwnsIr2X4Xfcz+XT+8NmnR3xa7BCxVZ?=
 =?us-ascii?Q?srRVx3aSZ3wLhxVPqYWOy2lo/LynoU4Kprp777DSa3hxaBPbLMDbCNqjgHzC?=
 =?us-ascii?Q?VmslfbM5Y6yllZloXyYYZxpCwB1kyMo7NPobcuqi9q6Dh+tGy42c5y7XvaNV?=
 =?us-ascii?Q?OxZbFeTVV0HW76QCtIVKjV5S5GmN3W44MYh+/F/jAPbPW13uPHVprwYaMhiR?=
 =?us-ascii?Q?TXEUgxKItoFPrqhmnWdoYXrlPUATDUyAg1PONnBGG6gtgUz2cnwpKwYD60D8?=
 =?us-ascii?Q?q8aeIavj+mx7e5+QVxby2+AC4oIlKTJH60f4CSEKlFEKGhsB/WcGd9jn/oZM?=
 =?us-ascii?Q?xDEZwkv79st1G0RU5wqgb6tBMU+uqqFUaagJOkoFsEoia30ZAyC9K66gBuvt?=
 =?us-ascii?Q?hgpXuV/32fQ6kDq3p2vINsatzjrUPDWZAOxRe8vjjvhUUJ7zZpzvRFjwOxB5?=
 =?us-ascii?Q?Ri9PouOl98hkpc/YV7JhuhRST9OqmWuNm3NMb3Qb42T4OqNjX7QDu5r0hKTY?=
 =?us-ascii?Q?ZoklHwmlC/vd4rOwwNg4LurdZrJnik6levyInCd61j06lAhEPTKKFnZxUaph?=
 =?us-ascii?Q?5WBC46Vp496l196lBsf7TXVwmP6mRnZK9IRmEZR7a/agQW/gNUOwS/poSKUv?=
 =?us-ascii?Q?y/jV6oLruPkSQBTIBBRZqN2XzddXfpjxxrTVn9MIIJrakFprruQAHTEyTY4X?=
 =?us-ascii?Q?3hzXeucalqkFPNDh+suqe3STcaqhFavwGZlhyu8kd1/E0wGU6zute0V7RWve?=
 =?us-ascii?Q?zWhtdwQSqiYxq3gEaedm+80mdBpPPMQzIo2vOhJ5SItePoxwH6XifTpoUAnq?=
 =?us-ascii?Q?UmQ5KfHtdRckNE1uxbf5xSkAK9L22pTqBkiCncBf6Ng6cWFEPN2KIj9tyt9b?=
 =?us-ascii?Q?a5n/3yPySjbxgzBNK6nqqPJ2q5HJbg9k0teFtKOIc3DvAd61RbGIOPozwzKL?=
 =?us-ascii?Q?bJUNQ6YhiCPI1KHmUgBchHf7KMIfKq0ejxd2gRxWbG8eOZMj3OXHOFy3VCDG?=
 =?us-ascii?Q?yHKxq/p8aZSPiz2xRYgsO4jdyJf4mj4qhdGkkhK2PuD0a8YQJ8kHr9rj4wi0?=
 =?us-ascii?Q?3NebjDnOBC9R1vfJIin36XP8hPjXpLLYioIP4gV0lsCMLe6IMFtcJZiLoJuN?=
 =?us-ascii?Q?pQAnk3gO16ebM4gMl9/r2Ni7crP69FCIz5Vl5ZWCGU/391CRwx7ymf6HYjfh?=
 =?us-ascii?Q?dbpDxwph07+49y4ZThS+sLK6VBJxbeL5kCq2s4xaN/raUWwMAg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:05:09.7117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 353d9e5d-1826-48c1-ba48-08dcfdd526af
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297

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


