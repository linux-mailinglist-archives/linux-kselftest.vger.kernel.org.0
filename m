Return-Path: <linux-kselftest+bounces-20342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5DD9A94B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 02:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EF2B1C20A87
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 00:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2D313C677;
	Tue, 22 Oct 2024 00:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TUQ7ttPM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0005313AD03;
	Tue, 22 Oct 2024 00:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556435; cv=fail; b=ROasHfHrox/vRpratt2kArnFn40qgMg0SNusgrknZQyEfnxWVroKbnavOt28wec6MT6DLQvPL7oqLO+Tr5s1Qe89zRMLrCFluJULDl0/e54cis34rNMRhz2NLktT0DjW1Tx/n9HRk8sU2Xejmbl9xF90QEdUSmpARRuga/Idx1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556435; c=relaxed/simple;
	bh=uuGzRXZGIR1348PzemGxHzk/Sf/Zw9Pg41eEpvcVkZs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FgINJmHK+uoSwflrtTorK1pThOhVqcy6Ejg2z2vHTqru/hpdgO3XZv1Wy2mmRI0yN059Hip5uF75gE1OGIgTqDAeqkJcoDubzmDiN2gLC0jO1undY6LtbgyITrupuQLxh1RaFNJhI8ONIERcvq3h+9+22N22c9aIeR3Ntyt2j8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TUQ7ttPM; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EvaEpxUGyqivCzfRqHTEj6evwE+u1IY4F+woT0HvwwFYavumRAig6LM4R5RbIMZOuUFcawq36fnSIQcTsMmLqRcAYQbb1bhkPoOkwAJyxFqakqW/6NZuD4SqBFSdaXEibmT4TOfrS1b7mDgQTUQtKx58KckM/+aPXyP9PuV/HJVT6PZdkzAy2SkpMkwVf6rEvGD81alSCj+UmBOyuhMGJnyofpMRIKj+Jzi6WLGKYBjAm3Uze7Y9w6l4GoBRk1veREyP6qfCNBXx0TVRA28HZ1B7f0AMaiTD/AmdSlpPyc7nUY2Zxl3MvsnFLB19C6Gat6SZjC8F+mSBjcJ2BDxSgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppccpeyy1L2Rk3cWFAMsyZahdwqz/tSFTOoVMVOcQpI=;
 b=ot/5/DIiC5T2gg9w8YYubvwvEcjgDLcCRK7Svo2VwZDNU8ItFanG4PjXsQ2EhcNZ9vpwsb4OXyHwmE+ZMSO9Hes3/MbsEXXJ40QZQpc1nMWq+oDKzwG+/UKxpcomOiMxPV5lbHeYp33F9X+oJEwDnvGvybSJsv8N9VOjJELhWoXn1axuGZWM9Rlk08urVNm2N91qC0Ert4WlZIunbijcLCmqW4DJ03R4tUzLK2Jh/cLDJwlPwEtuBPPjYpvNAlcE4InaLiYKMAg9m7pPKlQi1gkZR/kp65aXGQ4K9cx6N/qpQ6AEwpISTOj4/BpQsd5YVFJqxRXDb6Tm5wd6Uar0hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppccpeyy1L2Rk3cWFAMsyZahdwqz/tSFTOoVMVOcQpI=;
 b=TUQ7ttPM3JNVX1sHLfBM20kpeENvTsjPpDAD2Uray30YVlZ+/leB1+AgyQHkJ95VBrlePvboOKobnHL7CCtbK210ogCrwat4yekDTT75GLQC93rKlTpMUoOSpK2gvC9GyUSTzSAbiFn0a34TYB7omor/ZM1nzjKqg8+iZ8du4CkVYhNx2E6vBXFY+BCbCsoEts+mgYBPsLj/Cd63J0FgTc9FrWIxfwYlo1zgNgzikG6ukwNLuGZ2xZ0RRpWQtY9HJNpeI0ugFtuKFDj6MLBZMwPQQhCzz573K6aFJeL2G61H7dJNy60SURXErAcHK1KZa999rmO6NUkA6sxPca5+4Q==
Received: from BL1P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::7)
 by IA0PR12MB8713.namprd12.prod.outlook.com (2603:10b6:208:48e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 22 Oct
 2024 00:20:30 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::58) by BL1P222CA0002.outlook.office365.com
 (2603:10b6:208:2c7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Tue, 22 Oct 2024 00:20:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 00:20:29 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:11 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:11 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 17:20:10 -0700
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
Subject: [PATCH v4 08/11] iommufd/selftest: Add IOMMU_VIOMMU_TYPE_SELFTEST
Date: Mon, 21 Oct 2024 17:19:30 -0700
Message-ID: <c69afb47e5cf212d7611e951e539d0f6793c9bc4.1729553811.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729553811.git.nicolinc@nvidia.com>
References: <cover.1729553811.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|IA0PR12MB8713:EE_
X-MS-Office365-Filtering-Correlation-Id: b4b90187-1ce9-4e88-92ea-08dcf22f560c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P/QA11pKMOGDu9e5cOekM7XMbFc2f9tVJSj3MnTDwjJdIeJf6UpIfrJX3Syv?=
 =?us-ascii?Q?1DUS/2gLd2Cox0Vahka4xXEqpu0lI/Laqi6sEC+0S0B/i2pd+bfNVJNfL9Jl?=
 =?us-ascii?Q?RbJTHu/NRcNUKTPMBlLAIsZqL3C3XaI2A4Or77XdzzKXjvpMUV+0JHNis+1z?=
 =?us-ascii?Q?hsUgpItS5jIXVeF4pBvlKygCdmYVnYJlgLjuHJAM0IaskH1qOaXtjnKqc7si?=
 =?us-ascii?Q?ftKbsU56Xz20s0YPdI/Y81eK3fOzepuBfqxmwkrI1cLQF31qW9spPxQR71mB?=
 =?us-ascii?Q?ygl+AXl9USBU5nsUp2ZB7Py3AaH+hr7RMGqHdQz3JrPm5MWxQA03JwrXZmCB?=
 =?us-ascii?Q?DRAoXc+OyZZkYnNCq3kztkA/sOFQEOIObWEkecH7D4laTqa8pGY56YEh9HP9?=
 =?us-ascii?Q?Mi8gosMbX+rlQ5l/mK0ZZFgpwtYGtcGify4XhFpf8dko0pZ0V3Sf1jNGrmNO?=
 =?us-ascii?Q?3IKsyfqW3S2aZPx8dGegPDNPJ5v1qBwab/yvmaQSdefUyokHoLCp4Wd4+fF6?=
 =?us-ascii?Q?1+0TZ4258pzFBBsGVfqToApAKJjvC1CHi0dvxqGD+7WU3XRlYcWQQJ/lgSjw?=
 =?us-ascii?Q?mpn5sZw9qSqFB3wsPwpiz40sPZISF5H4Ac9rDgI6bsiM8nIt3tSI1jamvTQ9?=
 =?us-ascii?Q?pcIrWGf4mzRb6wek2Ci/p9LPA/ZWEXmcf4dcpz7LYIjEcnD/GGkKny0NxFmQ?=
 =?us-ascii?Q?kRpgrDsTT67MzllsEHoWPtVERm+w/Ifb7rrezJ5vHKTuAHrJcJuW1CMk5Yn7?=
 =?us-ascii?Q?TBdlxeronRuK98IGDMqk1Nza5kE2F7ihfXi8LyEqFb71GNwGPxN6DAZmIBqi?=
 =?us-ascii?Q?VpCY0qQSm8EsoVL7J6XDhEtaqPCKinrSaUSJb22Y+LJQviQVWAvrowze+W5j?=
 =?us-ascii?Q?uOcvaEli6+rataEMk9gBcmflSylEZO6uCp/Vn/K1mwI3MpYHavGaf+0Oz1jT?=
 =?us-ascii?Q?IhZohW0pQKxdum/snSTTfnWWRCyqAZzZcIQym4m7zSGtgbIvkvXZdZIWRd0i?=
 =?us-ascii?Q?rdKLp2ZmqsdNnwsNrvmzSn+mEru176m2ZjBxe2qGRkY1NuZ6OJ3tUc4BPBzn?=
 =?us-ascii?Q?IqifZKedbaNrWEq0TFXnIiJUcBQAlff0mMUwBHTumrl6wknUlQavLe9FSmV0?=
 =?us-ascii?Q?O1XHsH06/MdcftxYyk938O4UGPUefO0lWBNHiZaD/CiUiiQUAg5vspg+UUTL?=
 =?us-ascii?Q?zEJmqQP97nL7lvtKwkkX9oRaZkVhQ8S0wtejfpLIEtkiD15C6eermIVrlFZj?=
 =?us-ascii?Q?wIiBv2W0nm1TzHuV0NNvZPdBSiLNiqBxOFf43LZIPk9Ohs2gwsV39fY2TZPc?=
 =?us-ascii?Q?iMG6c4lGi1ETX4GeAfkyx8G/HtOhmLYGFrcqXPLZedFPIGSLVoVt/nMdaL2n?=
 =?us-ascii?Q?xBFA4MgdoTS5U30vimKjlpvQYBYNn9Pfm4OCEI4enEFyOVlAoQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 00:20:29.8629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b90187-1ce9-4e88-92ea-08dcf22f560c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8713

Implement the viommu alloc/free functions to increase/reduce refcount of
its dependent mock iommu device. User space can verify this loop via the
IOMMU_VIOMMU_TYPE_SELFTEST.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h |  2 ++
 drivers/iommu/iommufd/selftest.c     | 41 ++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

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
index dbd2a78c1074..04dd95fe24ca 100644
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
@@ -543,6 +547,42 @@ static int mock_dev_disable_feat(struct device *dev, enum iommu_dev_features fea
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
+static struct iommufd_viommu_ops mock_viommu_ops = {
+	.free = mock_viommu_free,
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
+	mock_viommu =
+		iommufd_viommu_alloc(ictx, mock_viommu, core, &mock_viommu_ops);
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
@@ -562,6 +602,7 @@ static const struct iommu_ops mock_ops = {
 	.dev_enable_feat = mock_dev_enable_feat,
 	.dev_disable_feat = mock_dev_disable_feat,
 	.user_pasid_table = true,
+	.viommu_alloc = mock_viommu_alloc,
 	.default_domain_ops =
 		&(struct iommu_domain_ops){
 			.free = mock_domain_free,
-- 
2.43.0


