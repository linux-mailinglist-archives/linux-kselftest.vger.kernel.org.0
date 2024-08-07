Return-Path: <linux-kselftest+bounces-14964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D5294B107
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 22:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4EC2B2448A
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 20:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C05C15575B;
	Wed,  7 Aug 2024 20:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nU4mHu1g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39774153BEE;
	Wed,  7 Aug 2024 20:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723061507; cv=fail; b=U0yu/PunS0zyrY82YDPks340sqHMG1LQ89fMCMCpU1kcUu7HclDq2JvCKiRzOCzmBYwt1Y56TCCP/RUwWmIs28mZadGr7IiDcgV5H9LG93/p3q0BYmICyXvzaTtm0QeU0rbqWHta1upFgyOdsugsPRRrK/5aih11tQ7M88xj8NE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723061507; c=relaxed/simple;
	bh=STVujtEmaej+o4fGhAoymbibYt7ZwoJv9MHSSlVqfp8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A3HOOOvz94tb0JypGcZxVJk9rzYV/64q8Cnqsd3XczCaPKb62BzQ7BRfibMMUpZkHRfKyJbcQStuEDJAMygrRVpnM3EF751ZjANDL8Xp8aNxMH2sIxKgtGfsulzCF2+3Kn8uzrKUdo3DmOm+IaeSftO1wAl/efLHxfzkO4AZpVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nU4mHu1g; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kChEWfB9nSJP9UoYC7ERGCZ4nJ34ln7+0FCcEw1s5d3kGgBt22NcUIrKcAULFeeYBhuHZ6q/dWN4ImtggKdorbvdYf1CGv1JXdosfnmhAQtCdrwsYYrsIvYcGxL161isR1A27strHhtAoHu5GbbY8Mm2goJr+2I5isJbn5m9EtocYFafhijE3Qr5yBRAr4ea8HHGf6TvcgOlwh7hNgHxIMvB+j3etOV01vUpZv6juJnpFjFcbjzS7rsgp/JbuFlRyd4hrUoIy8sDQLyBc87w/mgBDRQLETV0AP3OZJ6kNvUrfzQumC5CjEIJiZOMj/HNVj7Llkllwkkjkmgi+DrEPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idQMeIUexF32BsXmRN6jzWro30nXOs8dLCnokv5Ijkw=;
 b=VJkAuBMqoLpk/ycWkjdHYNOCnpPFaSux6FuuJSOdihq1QTxblSUgyIsZXLBGidEsbKvh1/Nouq9iPhIPufVnUiQsqH0yixCRzHo+7bECNF22bb2sl3T+0NlUJTKOMBvPwAh74VgYnR1SV8a587agV8KphhA4cCmDU1FbditIzt5Leej5g/1so+rudfLvRfZQDiEuBJXKn7XY1FN+0IN6CEGJ2HsvStoYCDfBBXk7N8LGcH7AMcD9DHw03KauC+qz4tk3/LZaqyFEZ9yl4v8NpuCObZFR8mHqDRgDDsgvdWpQ/7wrjRiAH8+k6ej1/vlAmHOtM6SGuwk5RSICBf8uDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idQMeIUexF32BsXmRN6jzWro30nXOs8dLCnokv5Ijkw=;
 b=nU4mHu1gDkoLBDxbYhB8zQEmTMLzkHuBP2pOXiDl9Jl7S7MAUhjWSobZPyNcung+K/7IhrCUK76qtyO3V0c6XafwSTGku9853M+gEzULI/sXtCT3mlfkrYhWaQ+6XTlStCq/tEKOHzpiqKpqExxmxMRshweLrtGN8OJtHc6y2mGHAZhW2/FAZmXWNz6mj8Gqmpdn3Zd11Z9dYwq9fZ0/v0WbkMMwMGFpJ3dyCbPFD2oBGJhaO3PXfDWTmR7mBiLEWHnRzWRoPJS0EAZ7kdOCi5/agh7BpNed6ztYgApnoa2hpd4FVCuhk6jeEHGyRrSZCh6kBJONLL++EjkhgEtL1g==
Received: from CH5P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::27)
 by BL3PR12MB6426.namprd12.prod.outlook.com (2603:10b6:208:3b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.12; Wed, 7 Aug
 2024 20:11:39 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::76) by CH5P223CA0001.outlook.office365.com
 (2603:10b6:610:1f3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14 via Frontend
 Transport; Wed, 7 Aug 2024 20:11:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 20:11:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 13:11:22 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 13:11:22 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 Aug 2024 13:11:21 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 12/16] iommufd/selftest: Add coverage for IOMMU_VIOMMU_INVALIDATE ioctl
Date: Wed, 7 Aug 2024 13:10:53 -0700
Message-ID: <bb2948bc90acd7eb6dd553ef673ec290538d3726.1723061378.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723061377.git.nicolinc@nvidia.com>
References: <cover.1723061377.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|BL3PR12MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: f7f5e987-542c-4198-3b7f-08dcb71d25aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AK5cpAJRaydcBQzhvYTRd1J6TK8LZKuzdihk1WlwP1qKgD0Cqvq0JI6x2yIH?=
 =?us-ascii?Q?lHQLncSX8joqUbOviEoIGXNyUgGRatGkRRXEdXzID1dxNv4hblsBDBXvIkfY?=
 =?us-ascii?Q?lEYQ8NKmk2JpmBLw40nadzuckM0eBOGsuThTfBQwW9amk+iiRSG3cKxBJMrc?=
 =?us-ascii?Q?l4xMgqrufQMT7b3Pk3iqWNcXQ7AUvInD7OupM8mYYv89WX0hPRSxDtaAsQeS?=
 =?us-ascii?Q?FFJ52MM5QxPv49rlJNKoulSDR14GAcWi+sI+FewMDopXq8K5ojtk2+ZzEg4Z?=
 =?us-ascii?Q?kmQVQ0jzDrAtk9/iej+s1bqf79AhT/rMjC8vtlSO60HVJs5NrKgS6Bd8A9Ze?=
 =?us-ascii?Q?kwrzZth4tffW3UAKUbYVmDCogdL7V0tn9fMlHltJPNLPXsTGfCiRJV6ni74C?=
 =?us-ascii?Q?FFnnzTpJX5YdJSN9OXb6pKYKdKyj/WZ3PSbT8wFplmd/zuiDQjrQ/w1v7NxX?=
 =?us-ascii?Q?KAuc6FwI3/Nut/VbDiS5t14eAf/TdZ22cW0+sLM6DQusdpSMiH/r23++pKG7?=
 =?us-ascii?Q?uq5GqRcZ+B+vuas3ipKCurWTPM3egvQlgqNn/4vwSfZV1AINj6dDktJfu/qC?=
 =?us-ascii?Q?zT6X6/kj4T2EWrYZcZ0EVWCKl11pwLb2XRLYS3w+evp4bd21HAQo0Ae5aUx7?=
 =?us-ascii?Q?kF0UV/VVkAzoH2xbYUjfmWRVe/EWQcNioZTEqJhRm1v/Orw6RVJzirulTjPX?=
 =?us-ascii?Q?3bg1ovuMX0y/O0MXPoghSsm8DZOnn2lCH5PqKw/W4K8Oj7nmgs8KST0MooLl?=
 =?us-ascii?Q?eHyY7hyYfEPqSGbZUJ3HKeRFnEHFvHy6TuxaiuDzgig8T0Uv/GmKuE4tfvQO?=
 =?us-ascii?Q?+aOtYwnfchIgXbgpC0Gzt91lMkpm0fNFbrQKGMiVQTY3r9UkJeyWaEyneWxZ?=
 =?us-ascii?Q?ro3RZgH8P+gaeM1DfnxmkrEp8GckQzJ21KA+LVqgsb1hN7ipKOdvhoG7CPP6?=
 =?us-ascii?Q?Zrka6eJ3l412mTjvoQRdrlzIGDPJ9X5WO9dBDcT2zVFIoSvu/VbAfey20MCM?=
 =?us-ascii?Q?+bCQcF5NBd6D7uNwIoWaxrNz+IgySN0KDbEo6rGffAeZvPPWWc3gqHgGdlFl?=
 =?us-ascii?Q?VvyzW2nQ2TYzI1kq1M1bpKpm3cRw35caUa00tTRmfxViL9hwJ+nJ1t4vBRQu?=
 =?us-ascii?Q?riJ27PYIRtRAklslF/IOj1M5K+wxrlwNh7iDdhVtAK912ibBknd7xTGDdS2g?=
 =?us-ascii?Q?dDyqHlk8lIiUJPJYhWgEArJ6b+tpDFIhh5GAwYkaEMRVH06Ga5rxBFmWuuNH?=
 =?us-ascii?Q?usbeOIZc+3VQcD8bCIunl3+4mE1na0aI9ARCh9Pe8NphYDeqFx1kuIxaNT0I?=
 =?us-ascii?Q?Z6dvRyvyI/Nk5em72cfVq/GuNDU2DCepjiN0+EcX76DKtKWAQw8Mr6aRjPiA?=
 =?us-ascii?Q?0XjoQcm6M7QnV8dynJgDKTgyDcgLLf15Q4Abuorn+ekyyX7piaIPoBSTkXYS?=
 =?us-ascii?Q?VN5DUzz/FL9leJAjLVFDgh8jbbKc3xIJ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 20:11:39.2053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f5e987-542c-4198-3b7f-08dcb71d25aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6426

Add a viommu_cache test function to cover the new IOMMU_VIOMMU_INVALIDATE
ioctl with similar postive and negative cases to the existing iotlb ones.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd.c       | 190 ++++++++++++++++++
 tools/testing/selftests/iommu/iommufd_utils.h |  32 +++
 2 files changed, 222 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index ce2e8c9ede9e..b8f20eeddd5b 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -622,6 +622,196 @@ TEST_F(iommufd_ioas, viommu_default)
 	}
 }
 
+TEST_F(iommufd_ioas, viommu_dev_cache)
+{
+	struct iommu_viommu_invalidate_selftest inv_reqs[2] = {};
+	struct iommu_hwpt_selftest data = {
+		.iotlb = IOMMU_TEST_IOTLB_DEFAULT,
+	};
+	uint32_t nested_hwpt_id = 0, hwpt_id = 0;
+	uint32_t dev_id = self->device_id;
+	uint32_t viommu_id = 0;
+	uint32_t num_inv;
+
+	if (dev_id) {
+		test_cmd_hwpt_alloc(dev_id, self->ioas_id,
+				    IOMMU_HWPT_ALLOC_NEST_PARENT, &hwpt_id);
+		test_cmd_viommu_alloc(dev_id, hwpt_id,
+				      IOMMU_VIOMMU_TYPE_DEFAULT, &viommu_id);
+		test_cmd_hwpt_alloc_nested(self->device_id, viommu_id, 0,
+					   &nested_hwpt_id,
+					   IOMMU_HWPT_DATA_SELFTEST, &data,
+					   sizeof(data));
+		test_cmd_mock_domain_replace(self->stdev_id, nested_hwpt_id);
+		test_cmd_viommu_set_vdev_id(viommu_id, dev_id, 0x99);
+
+		test_cmd_dev_check_cache_all(dev_id,
+					     IOMMU_TEST_DEV_CACHE_DEFAULT);
+
+		/* Check data_type by passing zero-length array */
+		num_inv = 0;
+		test_cmd_viommu_invalidate(viommu_id, inv_reqs,
+					   sizeof(*inv_reqs), &num_inv);
+		assert(!num_inv);
+
+		/* Negative test: Invalid data_type */
+		num_inv = 1;
+		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST_INVALID,
+					   sizeof(*inv_reqs), &num_inv);
+		assert(!num_inv);
+
+		/* Negative test: structure size sanity */
+		num_inv = 1;
+		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+					   sizeof(*inv_reqs) + 1, &num_inv);
+		assert(!num_inv);
+
+		num_inv = 1;
+		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+					   1, &num_inv);
+		assert(!num_inv);
+
+		/* Negative test: invalid flag is passed */
+		num_inv = 1;
+		inv_reqs[0].flags = 0xffffffff;
+		inv_reqs[0].vdev_id = 0x99;
+		test_err_viommu_invalidate(EOPNOTSUPP, viommu_id, inv_reqs,
+					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+					   sizeof(*inv_reqs), &num_inv);
+		assert(!num_inv);
+
+		/* Negative test: invalid data_uptr when array is not empty */
+		num_inv = 1;
+		inv_reqs[0].flags = 0;
+		inv_reqs[0].vdev_id = 0x99;
+		test_err_viommu_invalidate(EINVAL, viommu_id, NULL,
+					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+					   sizeof(*inv_reqs), &num_inv);
+		assert(!num_inv);
+
+		/* Negative test: invalid entry_len when array is not empty */
+		num_inv = 1;
+		inv_reqs[0].flags = 0;
+		inv_reqs[0].vdev_id = 0x99;
+		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+					   0, &num_inv);
+		assert(!num_inv);
+
+		/* Negative test: invalid cache_id */
+		num_inv = 1;
+		inv_reqs[0].flags = 0;
+		inv_reqs[0].vdev_id = 0x99;
+		inv_reqs[0].cache_id = MOCK_DEV_CACHE_ID_MAX + 1;
+		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+					   sizeof(*inv_reqs), &num_inv);
+		assert(!num_inv);
+
+		/* Negative test: invalid vdev_id */
+		num_inv = 1;
+		inv_reqs[0].flags = 0;
+		inv_reqs[0].vdev_id = 0x9;
+		inv_reqs[0].cache_id = 0;
+		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+					   sizeof(*inv_reqs), &num_inv);
+		assert(!num_inv);
+
+		/*
+		 * Invalidate the 1st cache entry but fail the 2nd request
+		 * due to invalid flags configuration in the 2nd request.
+		 */
+		num_inv = 2;
+		inv_reqs[0].flags = 0;
+		inv_reqs[0].vdev_id = 0x99;
+		inv_reqs[0].cache_id = 0;
+		inv_reqs[1].flags = 0xffffffff;
+		inv_reqs[1].vdev_id = 0x99;
+		inv_reqs[1].cache_id = 1;
+		test_err_viommu_invalidate(EOPNOTSUPP, viommu_id, inv_reqs,
+					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+					   sizeof(*inv_reqs), &num_inv);
+		assert(num_inv == 1);
+		test_cmd_dev_check_cache(dev_id, 0, 0);
+		test_cmd_dev_check_cache(dev_id, 1,
+					 IOMMU_TEST_DEV_CACHE_DEFAULT);
+		test_cmd_dev_check_cache(dev_id, 2,
+					 IOMMU_TEST_DEV_CACHE_DEFAULT);
+		test_cmd_dev_check_cache(dev_id, 3,
+					 IOMMU_TEST_DEV_CACHE_DEFAULT);
+
+		/*
+		 * Invalidate the 1st cache entry but fail the 2nd request
+		 * due to invalid cache_id configuration in the 2nd request.
+		 */
+		num_inv = 2;
+		inv_reqs[0].flags = 0;
+		inv_reqs[0].vdev_id = 0x99;
+		inv_reqs[0].cache_id = 0;
+		inv_reqs[1].flags = 0;
+		inv_reqs[1].vdev_id = 0x99;
+		inv_reqs[1].cache_id = MOCK_DEV_CACHE_ID_MAX + 1;
+		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+					   sizeof(*inv_reqs), &num_inv);
+		assert(num_inv == 1);
+		test_cmd_dev_check_cache(dev_id, 0, 0);
+		test_cmd_dev_check_cache(dev_id, 1,
+					 IOMMU_TEST_DEV_CACHE_DEFAULT);
+		test_cmd_dev_check_cache(dev_id, 2,
+					 IOMMU_TEST_DEV_CACHE_DEFAULT);
+		test_cmd_dev_check_cache(dev_id, 3,
+					 IOMMU_TEST_DEV_CACHE_DEFAULT);
+
+		/* Invalidate the 2nd cache entry and verify */
+		num_inv = 1;
+		inv_reqs[0].flags = 0;
+		inv_reqs[0].vdev_id = 0x99;
+		inv_reqs[0].cache_id = 1;
+		test_cmd_viommu_invalidate(viommu_id, inv_reqs,
+					   sizeof(*inv_reqs), &num_inv);
+		assert(num_inv == 1);
+		test_cmd_dev_check_cache(dev_id, 0, 0);
+		test_cmd_dev_check_cache(dev_id, 1, 0);
+		test_cmd_dev_check_cache(dev_id, 2,
+					 IOMMU_TEST_DEV_CACHE_DEFAULT);
+		test_cmd_dev_check_cache(dev_id, 3,
+					 IOMMU_TEST_DEV_CACHE_DEFAULT);
+
+		/* Invalidate the 3rd and 4th cache entries and verify */
+		num_inv = 2;
+		inv_reqs[0].flags = 0;
+		inv_reqs[0].vdev_id = 0x99;
+		inv_reqs[0].cache_id = 2;
+		inv_reqs[1].flags = 0;
+		inv_reqs[1].vdev_id = 0x99;
+		inv_reqs[1].cache_id = 3;
+		test_cmd_viommu_invalidate(viommu_id, inv_reqs,
+					   sizeof(*inv_reqs), &num_inv);
+		assert(num_inv == 2);
+		test_cmd_dev_check_cache_all(dev_id, 0);
+
+		/* Invalidate all cache entries for nested_dev_id[1] and verify */
+		num_inv = 1;
+		inv_reqs[0].vdev_id = 0x99;
+		inv_reqs[0].flags = IOMMU_TEST_INVALIDATE_FLAG_ALL;
+		test_cmd_viommu_invalidate(viommu_id, inv_reqs,
+					   sizeof(*inv_reqs), &num_inv);
+		assert(num_inv == 1);
+		test_cmd_dev_check_cache_all(dev_id, 0);
+
+		test_cmd_mock_domain_replace(self->stdev_id, hwpt_id);
+		test_ioctl_destroy(nested_hwpt_id);
+		test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
+		test_ioctl_destroy(viommu_id);
+		test_ioctl_destroy(hwpt_id);
+	}
+}
+
 TEST_F(iommufd_ioas, hwpt_attach)
 {
 	/* Create a device attached directly to a hwpt */
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index a2b9a6bbcfcc..69c51151238a 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -298,6 +298,38 @@ static int _test_cmd_hwpt_invalidate(int fd, __u32 hwpt_id, void *reqs,
 					     data_type, lreq, nreqs));   \
 	})
 
+static int _test_cmd_viommu_invalidate(int fd, __u32 viommu_id, void *reqs,
+				       uint32_t data_type, uint32_t lreq,
+				       uint32_t *nreqs)
+{
+	struct iommu_viommu_invalidate cmd = {
+		.size = sizeof(cmd),
+		.viommu_id = viommu_id,
+		.data_type = data_type,
+		.data_uptr = (uint64_t)reqs,
+		.entry_len = lreq,
+		.entry_num = *nreqs,
+	};
+	int rc = ioctl(fd, IOMMU_VIOMMU_INVALIDATE, &cmd);
+	*nreqs = cmd.entry_num;
+	return rc;
+}
+
+#define test_cmd_viommu_invalidate(viommu, reqs, lreq, nreqs)                  \
+	({                                                                     \
+		ASSERT_EQ(0,                                                   \
+			  _test_cmd_viommu_invalidate(self->fd, viommu, reqs,  \
+					IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST, \
+					lreq, nreqs));                         \
+	})
+#define test_err_viommu_invalidate(_errno, viommu_id, reqs, data_type, lreq,   \
+				 nreqs)                                        \
+	({                                                                     \
+		EXPECT_ERRNO(_errno, _test_cmd_viommu_invalidate(              \
+					     self->fd, viommu_id, reqs,        \
+					     data_type, lreq, nreqs));         \
+	})
+
 static int _test_cmd_access_replace_ioas(int fd, __u32 access_id,
 					 unsigned int ioas_id)
 {
-- 
2.43.0


