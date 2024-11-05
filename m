Return-Path: <linux-kselftest+bounces-21493-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AC39BD6BE
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 21:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63399283EC3
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 20:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83CF217F27;
	Tue,  5 Nov 2024 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rzr4nqM0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2FC217647;
	Tue,  5 Nov 2024 20:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837171; cv=fail; b=TJWLCxdKfwd93Qf+OVTmzVLd0RqSe5bapUl62/mEHBvQnNENLrm094/VX9JFvRgxrOJh4lAWdU74ES6QbeOXFVT2v6sB0+SKLc++C9bRAP/NwMOvGvGOJ5dZ58PBG2Zms3jBnPxS4BxZ4yodIEFS5QBLqCIW7Xl4KRBfBwHYOhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837171; c=relaxed/simple;
	bh=hn1V0kJpvZdfGHDiaaSZARwoRM+tVQsNUnsCI7Ikzx0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X2rj1WJ2HIr5rR7Vl3GYsZrgHK4+kzV2lObkI1L08M3GpumMEbmqHVgJnxvwInstCgRPS8o7ublE2L2pY4dGPmNnThJtj0VqnHQYtMigalUteiDPUapIjjRVfODegfw15qVcfKHxD4pfcDN0GdoOVg/X8Cq/Xge5i8/9x+DZo8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rzr4nqM0; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZS3lVyH1Iujbi3ehF1GvO0wHgrVA1aru7VE8iiPqWLVFuFK1nZxnLXkg09UHdjghbT4lOFzLzg6N4nF6HiY755ZTepzPZpxo9NEb5pMsCI8d88kC5Q9IgHK1xSGOh+iSHnkJlk83osPxoJrIMpUoYanHjOfUJJkRZLC5tjYgA6MVLnfPT9ArLKleLyLqeWz9ZhQn4eh2jGF/3xg5OqzPrJpQYEFkp0eSERiHdQopY4/pxQmQfY2k1o2evMN3ASZoLlw0lmnf5ECPJHieLpIP9DMOHzqNHyYqRupyIqsHk6RxSMly2t/q6tnz3TvJYMM5Sg9fLavagL9bei1XCtIuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vcpq0Z7O7Irny9RGQ41NfU8Uf4YNWmpmnI3hM91xpz4=;
 b=ovJEhWK6IDCj9fbETE+9S9dcHjBS6p1SRJ0Adze42Mv3jN6pEvfDb5EjcjJG4STP/Neu2InICxErMMQnD4g7eb6k5utHKaVVZKi8f3X6NULOI9S1CJgx2kdHg6EtWk0D1btcdlGvns0kN4ZtXIc5LDzbstJ1HdCZwIZhgwcWG/fADNGXzZIpTXVD+8ndzS2ylaCM3coDpK3M64tmOGunjk4vdxEniUrjzxZfyQSgx0IOTRCRPb0ZyVeZPUlqEzNZXAgxXGkfesf7PoGASNL2cP2vjHt0+w9XVZxDfalTKluek6qyFctcM3pKaK9KEdrdL54qDDODkUSybbB0EtnbjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vcpq0Z7O7Irny9RGQ41NfU8Uf4YNWmpmnI3hM91xpz4=;
 b=rzr4nqM0CVz5AkHj9eBMxBVPLkiW1r8/E83QghnC8IG+Usv6jNuRXbAHMYzidqNQX/Q0pQabte3uIK2M9qTCL70MfkDdmhIV41OVFbLxgFekvBI+rXHmTDBupSOOvYmXmi7rgatoeDdNiAkTwjzOX3iTX8QYffuS5rElsUOIoA5jwzpMke/UT4Rxh3E2JcErFvqPuhNJoDL+bzmXSrL+9xzPxJLdUig09gzBXVjkNh8iB9UE8srKdvoB74aQa0zIqK7/9jQ6XLN/7vp+/PR0mB52s1G4Eq3xp/DqQU45/n6YmRP2NZcd2qriBeGEYmTWMPfmw6XLltByFqSaUU7T0A==
Received: from MN0P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::13)
 by SN7PR12MB8791.namprd12.prod.outlook.com (2603:10b6:806:32a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 20:06:05 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:52e:cafe::7c) by MN0P220CA0015.outlook.office365.com
 (2603:10b6:208:52e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 20:06:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:06:04 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:05:43 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:05:42 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 5 Nov 2024 12:05:41 -0800
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
Subject: [PATCH v7 09/10] iommufd/selftest: Add vIOMMU coverage for IOMMU_HWPT_INVALIDATE ioctl
Date: Tue, 5 Nov 2024 12:05:17 -0800
Message-ID: <f317f902041f3d05deaee4ca3fdd8ef4b8297361.1730836308.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730836308.git.nicolinc@nvidia.com>
References: <cover.1730836308.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|SN7PR12MB8791:EE_
X-MS-Office365-Filtering-Correlation-Id: c26ef448-df8d-49e1-6a5d-08dcfdd5477a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cYu9FimrewE+zUPiuuYL3jCE3CZFl7beKN9bAXCuhK8Afyba7qfIsj5QcD7k?=
 =?us-ascii?Q?W9brcdlFowDAxLtM4tudCH+MZWXfojDyKTKwqJWHRUQRncHVL+tuwXJp8E1h?=
 =?us-ascii?Q?9WYHj1gtDK1JCk5ttKYHAw60e7mSMhaarBjklD9S2wZ2gALAGwWgDiSYlsW/?=
 =?us-ascii?Q?sqydCVoGPVSbtJ6IEKf4JpD4VgJhxNRo95GzjBEGEc5lufw4fwUHkX6DggWA?=
 =?us-ascii?Q?owwNjRATUYD2o6pJctxE9txceHXyHUG1h1VJj7YhPh9DMaSJnAkclb5qrUZg?=
 =?us-ascii?Q?k3BXGqCgqZawTt+RkhtsfI8CfkvoDRN6YTWBSbawbcEMLY8MD+RRDUcos5bC?=
 =?us-ascii?Q?oXobQlTAcR0SHogeZ/sZzQLDD4TBM3UFx/ZXpe6GiIRPCdGgnd5KjwrCspbU?=
 =?us-ascii?Q?X1B7hjul3w8VyLT8Skm8n27nEmpHNRG4XIHXJJ44ixm2LbIqQjPSucwfUKNO?=
 =?us-ascii?Q?fnFiql/8ro2744FJ/d7AFLUamiDDJ4C9xCSqn7LOglpATNClH1S5/IfyxW8J?=
 =?us-ascii?Q?FxS+L86CWTk74d9iAMAp6Q6YEAtgBHT2jRCWD0x40V0Gatnt5JeHL3z55Xv4?=
 =?us-ascii?Q?ypxSUoMNO3TblHYTFGlD6nHVNnjwZzhfO1wMny29JjZ2n92JX0KUMQ2sDgG6?=
 =?us-ascii?Q?Srr4ZDQm9RHaT3OzfXP73DssjX8ALhtKWfmWEPo0lfAmB6HJctwb+6bco1QB?=
 =?us-ascii?Q?WJJ6KtG0oK3iN9i+CwcfURDF2biE6vGYcv6SPORvWDc8LO5jE+PinOUVbLiY?=
 =?us-ascii?Q?dBno8lOc0ARcoPLk4lStmtoZ6bS+rxrSnN/6ZAPO28Q/zZoNmyz2umQlP07i?=
 =?us-ascii?Q?wUtNw9CHdTij+iGsUH/XJIgV/xtxoqNGAFvTR4D5xj6aE2Dg9yqUrZXB71/Y?=
 =?us-ascii?Q?svk89dNTcsP1xU3YndXaqXM9LJvzEkGNkprMwMmLGMbGkml6zYBrO//h8U4j?=
 =?us-ascii?Q?+kcjhHGxX35SfyO7XfBy3E/G+QLE7xp43dCWn7mPv1LTUfhlHpm8Lo1lhiUT?=
 =?us-ascii?Q?nACDm2MYuihWOURO8wVLXP6euozrcPcoKSH+sg/q3j7Rc9s5ZgOjt3SWAzQG?=
 =?us-ascii?Q?+HM8q5NWkH6aaL6T100BpinbH86D76y1UdA4azsQtypkNpKjtIGZ5c364yKH?=
 =?us-ascii?Q?yd3KV3xQ1abMORDMsGk+oJ1ioOAmRJdOLE0uOD90XgEwV3JMU/ZoV5HFYp2j?=
 =?us-ascii?Q?FwBYG4spk7IU4V3fbcmGT/vhDHVC9Dq4p0wXmz49SKq65M5E83hul5rKihSS?=
 =?us-ascii?Q?Dus3x5Vu2otJdb+1xr82psR+8SdUZEKR8R9mAcDEd/k1NYNCpJM75mOhkE3M?=
 =?us-ascii?Q?KOg78q8VcV7ZFehmo138Ye/ZuNhgN0Y5jiyNp5XJEPAxoUq7C5rtkhLyb7On?=
 =?us-ascii?Q?qiutgBi+3IFhd3dUml5UaYvOSHD0P9ldI22eI/iaVFZkMU4amg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:06:04.6802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c26ef448-df8d-49e1-6a5d-08dcfdd5477a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8791

Add a viommu_cache test function to cover vIOMMU invalidations using the
updated IOMMU_HWPT_INVALIDATE ioctl, which now allows passing in a vIOMMU
via its hwpt_id field.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h |  32 ++++
 tools/testing/selftests/iommu/iommufd.c       | 173 ++++++++++++++++++
 2 files changed, 205 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 619ffdb1e5e8..c0239f86f2f8 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -305,6 +305,38 @@ static int _test_cmd_hwpt_invalidate(int fd, __u32 hwpt_id, void *reqs,
 					     data_type, lreq, nreqs));   \
 	})
 
+static int _test_cmd_viommu_invalidate(int fd, __u32 viommu_id, void *reqs,
+				       uint32_t data_type, uint32_t lreq,
+				       uint32_t *nreqs)
+{
+	struct iommu_hwpt_invalidate cmd = {
+		.size = sizeof(cmd),
+		.hwpt_id = viommu_id,
+		.data_type = data_type,
+		.data_uptr = (uint64_t)reqs,
+		.entry_len = lreq,
+		.entry_num = *nreqs,
+	};
+	int rc = ioctl(fd, IOMMU_HWPT_INVALIDATE, &cmd);
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
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 4bc9dd2e620a..94fe038d2eee 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2642,4 +2642,177 @@ TEST_F(iommufd_viommu, vdevice_alloc)
 	}
 }
 
+TEST_F(iommufd_viommu, vdevice_cache)
+{
+	struct iommu_viommu_invalidate_selftest inv_reqs[2] = {};
+	uint32_t viommu_id = self->viommu_id;
+	uint32_t dev_id = self->device_id;
+	uint32_t vdev_id = 0;
+	uint32_t num_inv;
+
+	if (dev_id) {
+		test_cmd_vdevice_alloc(viommu_id, dev_id, 0x99, &vdev_id);
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
+		test_ioctl_destroy(vdev_id);
+	}
+}
+
 TEST_HARNESS_MAIN
-- 
2.43.0


