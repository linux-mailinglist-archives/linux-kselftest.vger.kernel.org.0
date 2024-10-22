Return-Path: <linux-kselftest+bounces-20345-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B87909A94B8
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 02:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5811928499F
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 00:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3F313D89D;
	Tue, 22 Oct 2024 00:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UiEsvnVU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFE713B79F;
	Tue, 22 Oct 2024 00:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556437; cv=fail; b=AZdASZ9wlWBfTMMhGJzblqgimcV/xaU1BspwRDZ4NL1xmW6YjHBu6nZFhBoePjy8NwzHuowKLHuI55ChkRtOM4G1HySYUuD+XzuKri8pyBaHO8lqLGJzoZi4EJg2k0cCuGncMJtSJ8TJB8BE+8npo51nzpuP1BNz5qG60mng9Ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556437; c=relaxed/simple;
	bh=z/eaGSovBxvm4gvITyZo4wu91uL8a9SiQWDgai6aGUM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NXRTW8Q1zXXITYe0yplxI01ak1zZNj2B3FVHPaNQzLjnJRj5W7C4mrrOpOvaxnoHJTB74iGVT8zq1DJntIviakq8ES+41ewX4ETeC+XprWRMZ950QHX5YLSsDGtqH6xd+n3EEXVjdsIVVeTuG030R2Fwr42g8z0PTQsPyXW0ReE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UiEsvnVU; arc=fail smtp.client-ip=40.107.95.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdrdYZZVFxKuHkRPxRDgQplBsOYg80s0GDrbg0qzASGq+ewHvEHUyT51GitTZkkcqRnyns1e6qdXgfrXra3gNlvVKXdg7N2y8SeaY0I/9p24rDOGwKtk7X0+EQrBwcWlEHQWz/2RnlGrX9xJZ+/UiGNB1T35pYj9YOKVadqGipgej1UOFAg0UyCF/1A825DnbBRTSXVuRcV5k7W4hq6YJn1ylzRXuFiUiCv++u0/XL7lVJHS+Ji1vAhCLuw+l4vwVpJuXcKBSqobrG96FNFRHHt9OJQat8Sx1qpaATFkOTRrAP4xnpywWFDg/t7N0a2xFkW5Xxr4u52Jq+QwUMc6pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pv4VPS3l4q0xEzuM9E2RNzoeDh1ThJTm3rrynPATA+I=;
 b=MLO349mJHUnZIoQIoQe6oAm2Kn33JXIKgWZrM7hY7Bon/APG9Y3LkycB/32urMOApZIWYxKjWbDkuC7OXvwa137CxTL+0KAul6xSfuyvT/+3Cz0DVfVoYk4hzVHx2kRXqXKo8xKUve6LAr66v3prxzr3p74nExVEaFslFpm24QOFJCF7PN4jfdAXvTzb0eoZgIkNLuZD8akKb44tTI7p+ehXWVye25tpWIP3xzhKKPUwNrptZZrvJwBvR2656XY2Snrw9o1l7WkU+0bkbQH8/2h5p91KuNO4cDrccyL5XVVLQ91gicUTGFjnCjNrkGlLVbs8GrBEOArFbsn8LsSNbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pv4VPS3l4q0xEzuM9E2RNzoeDh1ThJTm3rrynPATA+I=;
 b=UiEsvnVUHZgqdqaslOMpKyZ4zEEp4o5tmVqG5a35CKcDCODIIF3RxHXC6rdorjO473rEmARNn5dWYQZ/onPe4aboKi/n7SSyYwjewyynvU8x07sRI2S70JASC1SGMemZSgfMYNzqs2YOYhJTOndwLC4NGmNIS/BDPzrrzidXhddfCa47x9yo/aR/xQhYNk4DwWDOUW353J7sqFqHLtaD1/mgGuRKjiabkvg9+E2yHGvwpOMpbT2EYpwE/8Nzk/sDgNdLa1z5x25IAueyLe4IBpU7z6LiOaXPLtaMz/QpsNCn6LnqPNWWRI1aPIphF8Ghx0TNsAL28WIHukea69FW6Q==
Received: from BN0PR08CA0001.namprd08.prod.outlook.com (2603:10b6:408:142::6)
 by BY5PR12MB4324.namprd12.prod.outlook.com (2603:10b6:a03:209::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 00:20:30 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:408:142:cafe::55) by BN0PR08CA0001.outlook.office365.com
 (2603:10b6:408:142::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 00:20:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 00:20:30 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:13 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:12 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 17:20:11 -0700
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
Subject: [PATCH v4 09/11] iommufd/selftest: Add IOMMU_VIOMMU_ALLOC test coverage
Date: Mon, 21 Oct 2024 17:19:31 -0700
Message-ID: <47e6077c79b9bf97476aa91317d35af2e8974240.1729553811.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|BY5PR12MB4324:EE_
X-MS-Office365-Filtering-Correlation-Id: c76aa39f-781d-49b4-6cb6-08dcf22f564d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tbg6d2CBLXZKUVqwkizu2Nzja9CTQ/1H7GUMS4MFB7g/q/ggyJXQCIo+ZtK0?=
 =?us-ascii?Q?cUPEgjAzVNDslnhJZOcU2UF1Blb745Olxp4+/fpPWUQ5Jc/b7pHkTNJykdYl?=
 =?us-ascii?Q?T+eWkq3Ac4gAZSW9pTvXf9ZQ1E0uzlUJXdt47MADMlpcyNAWKRsFHP3NUESg?=
 =?us-ascii?Q?pCodUFIA1/m979lgxP6j3wad3KfLzgc/Hm8MFE4Uo079Ov/J9Jr2NFOTtZNO?=
 =?us-ascii?Q?z8grvZXCBg7RHUUXdkb7cSqMwiNQ/IAHTIlL8KBlfj2LVU1rVpkgwTlcHkON?=
 =?us-ascii?Q?A0Zj9wG2XsyRCnSQJcw//pFtDVayfacdBofNymG5LGhSXQQAxSb4vSLABbrB?=
 =?us-ascii?Q?fOizDRtwsA+w2ljGIwXQ50U52JhGoZq+2tdJLlBEM9mE+yyMvMkmI0xXNiHA?=
 =?us-ascii?Q?2kFeAjeDjHY8B6s/6wGtPjTGem5gyzl+lXBGjwIqfnnmb4YmTZp9Mn7Di60Q?=
 =?us-ascii?Q?XXIjQ0PLJNLVvFZ35PXzS2aJwuTUmM9iHTZdxfo6ABp3qLikQrE3tIHWmX4o?=
 =?us-ascii?Q?9pPSuwetGu/6u5ZEEjQaraz2wkZlfl+HLz5RXuhLeZFylgouMsFfsJXFiiOu?=
 =?us-ascii?Q?2JvsVqVMRNdfj09xS2c0l8EIhi5NXe3rrEuW3Nh5rxK8An8rciaOr9HBEhw6?=
 =?us-ascii?Q?1rjS6fL+w9bKJOwASq4D29tWtgye7QUYZKxx6/aHDej8FgQ4nwq9fSx6DVGY?=
 =?us-ascii?Q?9P2V9O1+uhJ1calqf0cYQRjaMS0BC5uQ+ae7E4VVl38+z/F1mf4zakqH6Z3o?=
 =?us-ascii?Q?gb/BX40fMKVKFtXfpr5WBY9TNeu+yz5wzRuOaAoP90pa8PM+MZBh8yvxa+ot?=
 =?us-ascii?Q?wnnFwBy+icfj/4hnB8si5Sr2g75I1D9LxECAv/wyM6Cs3kh2vUso58Q8ty8l?=
 =?us-ascii?Q?0QxhLOK0YKZboC8MFWh19O6IUeNB3ptUKp29o2fpsrTklYevti8fQIQZVA4j?=
 =?us-ascii?Q?qyg03gqZHH/eWq/dMxKQ7v9wYOUDylUmiqEU2ScOdAtGxhyR32JoTT5Wk32Q?=
 =?us-ascii?Q?W3lDonwSpBb167FiTS+YxuM0DsQNlxGYrV1cZhTaOp3kowPXWkgHvq2tHUEv?=
 =?us-ascii?Q?/W7UWkc6Sgi4ZPujXz8arRZ1y4jjU/x7E11L5nxxhyndhzEvSMjjkzMGjmRv?=
 =?us-ascii?Q?Axo3m1ikUGyeTREjZ9pSPso3eaB1vCBdeOrNsyy9DlcOlYsza75+u/Fk4l2c?=
 =?us-ascii?Q?Euj+M5t69ZtpV3bNVn9LjEBEllLz4mjIt1abc54LN4VNj5YGdmeUVv1yD/mo?=
 =?us-ascii?Q?PxBHupvd/ZPOZWb8zB/IYr/Vf+Q5f+XZBRsn9bviEyeZGXfDPp74M9jFr/iN?=
 =?us-ascii?Q?pbhnPArtZio8TO9vz3EPByXhSOIrAOV3KnXnlq7do5oJkmlewJ0aWX9kxZ4x?=
 =?us-ascii?Q?6DJJRQwcTF7yjDnpRxJVqGB90vsD3RdVdu9j8njj8QpwC2LkxQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 00:20:30.3035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c76aa39f-781d-49b4-6cb6-08dcf22f564d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4324

Add a new iommufd_viommu FIXTURE and setup it up with a vIOMMU object.

Any new vIOMMU feature will be added as a TEST_F under that.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h | 28 +++++++
 tools/testing/selftests/iommu/iommufd.c       | 78 +++++++++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        | 11 +++
 3 files changed, 117 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 40f6f14ce136..ca09308dad6a 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -762,3 +762,31 @@ static int _test_cmd_trigger_iopf(int fd, __u32 device_id, __u32 fault_fd)
 
 #define test_cmd_trigger_iopf(device_id, fault_fd) \
 	ASSERT_EQ(0, _test_cmd_trigger_iopf(self->fd, device_id, fault_fd))
+
+static int _test_cmd_viommu_alloc(int fd, __u32 device_id, __u32 hwpt_id,
+				  __u32 type, __u32 flags, __u32 *viommu_id)
+{
+	struct iommu_viommu_alloc cmd = {
+		.size = sizeof(cmd),
+		.flags = flags,
+		.type = type,
+		.dev_id = device_id,
+		.hwpt_id = hwpt_id,
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_VIOMMU_ALLOC, &cmd);
+	if (ret)
+		return ret;
+	if (viommu_id)
+		*viommu_id = cmd.out_viommu_id;
+	return 0;
+}
+
+#define test_cmd_viommu_alloc(device_id, hwpt_id, type, viommu_id)        \
+	ASSERT_EQ(0, _test_cmd_viommu_alloc(self->fd, device_id, hwpt_id, \
+					    type, 0, viommu_id))
+#define test_err_viommu_alloc(_errno, device_id, hwpt_id, type, viommu_id) \
+	EXPECT_ERRNO(_errno,                                               \
+		     _test_cmd_viommu_alloc(self->fd, device_id, hwpt_id,  \
+					    type, 0, viommu_id))
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 4927b9add5ad..49ac144cf5a4 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -128,6 +128,7 @@ TEST_F(iommufd, cmd_length)
 	TEST_LENGTH(iommu_ioas_unmap, IOMMU_IOAS_UNMAP, length);
 	TEST_LENGTH(iommu_option, IOMMU_OPTION, val64);
 	TEST_LENGTH(iommu_vfio_ioas, IOMMU_VFIO_IOAS, __reserved);
+	TEST_LENGTH(iommu_viommu_alloc, IOMMU_VIOMMU_ALLOC, out_viommu_id);
 #undef TEST_LENGTH
 }
 
@@ -2386,4 +2387,81 @@ TEST_F(vfio_compat_mock_domain, huge_map)
 	}
 }
 
+FIXTURE(iommufd_viommu)
+{
+	int fd;
+	uint32_t ioas_id;
+	uint32_t stdev_id;
+	uint32_t hwpt_id;
+	uint32_t device_id;
+	uint32_t viommu_id;
+};
+
+FIXTURE_VARIANT(iommufd_viommu)
+{
+	unsigned int viommu;
+};
+
+FIXTURE_SETUP(iommufd_viommu)
+{
+	self->fd = open("/dev/iommu", O_RDWR);
+	ASSERT_NE(-1, self->fd);
+	test_ioctl_ioas_alloc(&self->ioas_id);
+	test_ioctl_set_default_memory_limit();
+
+	if (variant->viommu) {
+		test_cmd_mock_domain(self->ioas_id, &self->stdev_id, NULL,
+				     &self->device_id);
+
+		/* Negative test -- invalid hwpt */
+		test_err_viommu_alloc(ENOENT, self->device_id, self->hwpt_id,
+				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL);
+
+		/* Negative test -- not a nesting parent hwpt */
+		test_cmd_hwpt_alloc(self->device_id, self->ioas_id, 0,
+				    &self->hwpt_id);
+		test_err_viommu_alloc(EINVAL, self->device_id, self->hwpt_id,
+				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL);
+		test_ioctl_destroy(self->hwpt_id);
+
+		/* Allocate a nesting parent HWP */
+		test_cmd_hwpt_alloc(self->device_id, self->ioas_id,
+				    IOMMU_HWPT_ALLOC_NEST_PARENT,
+				    &self->hwpt_id);
+		/* Negative test -- unsupported viommu type */
+		test_err_viommu_alloc(EOPNOTSUPP, self->device_id,
+				      self->hwpt_id, 0xdead, NULL);
+
+		test_cmd_viommu_alloc(self->device_id, self->hwpt_id,
+				      IOMMU_VIOMMU_TYPE_SELFTEST,
+				      &self->viommu_id);
+	} else {
+		test_err_viommu_alloc(ENOENT, self->device_id, self->hwpt_id,
+				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL);
+	}
+}
+
+FIXTURE_TEARDOWN(iommufd_viommu)
+{
+	if (variant->viommu) {
+		test_ioctl_destroy(self->viommu_id);
+		test_ioctl_destroy(self->hwpt_id);
+	}
+	teardown_iommufd(self->fd, _metadata);
+}
+
+FIXTURE_VARIANT_ADD(iommufd_viommu, no_viommu)
+{
+	.viommu = 0,
+};
+
+FIXTURE_VARIANT_ADD(iommufd_viommu, mock_viommu)
+{
+	.viommu = 1,
+};
+
+TEST_F(iommufd_viommu, viommu_auto_destroy)
+{
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index c5d5e69452b0..e9a980b7729b 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -582,6 +582,7 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	uint32_t stdev_id;
 	uint32_t idev_id;
 	uint32_t hwpt_id;
+	uint32_t viommu_id;
 	__u64 iova;
 
 	self->fd = open("/dev/iommu", O_RDWR);
@@ -624,6 +625,16 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 
 	if (_test_cmd_mock_domain_replace(self->fd, stdev_id, hwpt_id, NULL))
 		return -1;
+
+	if (_test_cmd_hwpt_alloc(self->fd, idev_id, ioas_id, 0,
+				 IOMMU_HWPT_ALLOC_NEST_PARENT, &hwpt_id,
+				 IOMMU_HWPT_DATA_NONE, 0, 0))
+		return -1;
+
+	if (_test_cmd_viommu_alloc(self->fd, idev_id, hwpt_id,
+				   IOMMU_VIOMMU_TYPE_SELFTEST, 0, &viommu_id))
+		return -1;
+
 	return 0;
 }
 
-- 
2.43.0


