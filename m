Return-Path: <linux-kselftest+bounces-21483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E3C9BD6A0
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 21:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64FA41C22A64
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 20:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BFB215C7C;
	Tue,  5 Nov 2024 20:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g5lvnbj0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC2C215C6C;
	Tue,  5 Nov 2024 20:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837121; cv=fail; b=aZN6hB5x6pTtX+spbBp06bQ1xQbhIfOVYItbNeZfKztoQAiqU3fsNYhnGkCthDCp9/p20MbM3adTXyWUfZ49kiYePdEjeLjZufjlxhhTuZJ43wmoc6HZalJi0dMTqhpxEUvYvHhvHwcP098qntudPSmpWwUPilURVXGbaaIzMBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837121; c=relaxed/simple;
	bh=UFeNtUCfE3Sycpaa1cglfzuNKH62h+f73QJE7bmmOg4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZJbOdY1/nCHMFz3vuBEaIpJv49mpQbwpjMM6CJGmGVFJEMcBOxEcqdGagx8f31yPsJ7yrAvA+doRjlPz7BJjGMmhjjsKZ29abiI/JQlNg0YAh0QJaG8tJ/49DNeTPhXoz1deV/6Bybi/FaNLSAxJi7kOZUM1s86sORaKruMqIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g5lvnbj0; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpRoU583KBDGUoHoCqwupx26wIlEqUbv5gqE78/yV/pp+Myy97FGUZ/gm8XW3Ov7hZ9Ks2R2bI+GvZzjv8fnRpKHyvwD4NHaQAqCvjOEqqmFuBJ4nXITPVspQDm6qgt0Yu3kNHqMnhy9cAX0+zWhM5+lhbqoQqJE6Q8GRaaw4lSlpi0RmozU2fKfXU2h2qQBRgZjrHioMDURUIRIyBy6AIFLpuvBa8Mv/Zkg7A+OLz/iVPucS1zSaZFZVeQnB0SFpwMpU9v7ZF45saZM335bGdPCOzwhTYzXvwdBNfmnsC4yAWGih+E2a9j7CO/SXSlL9nrs6pFbFzZmG30f/Gb1tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5BUJhxm/I2QYALcz0voEjRrzsULOrrfaKjMZN/4xEs=;
 b=k27xFgv/Zzzbcxu/aa0Mw0NCZ2ONr4db1vr4f8zfqixr5C43pQDFyow1nFvnsHIP61WQq35IfZzCT9Jtf2MRX6ya+LvHw5AEp5f9z5wypkgc+tf0JnQ9hkM6Lsxh06znEejhyP0dYWHR+WRXzlqaiLhfOoSY8uzuXmeM3T1cjQWmMk9buSWa81v0GsVA7C5dp35eSkWt5F2HdVKbLzIFb4ZtNI5KYCvj6YcvsVpy4vAQKxCUreNZN11HvnALZ74+axkSNpaV05OdrH6K6VqSEb3qLgiTlM3jdft8Bipa+ySEj3mAu1Y5qgrYJTk9KlJmt8vgePSpzz7iMr/K3S7jFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5BUJhxm/I2QYALcz0voEjRrzsULOrrfaKjMZN/4xEs=;
 b=g5lvnbj03NKozNTu9jB5gaGKZXBagFtba9hV9lWlSUVbx8/igOi8ixVBB7e8jOsTWva2ZtUj/v6L2plYKl1gppAxBEz/duH1Tt4/RG9qTDPS5f7DS8iyn7Zt7SCqxDF9qzpKD7MyNBypriRPsoGbVtVAJjjY4t+YCLjOdFe6S363XNTjBHeR2Vh8o84PYyw1wqWXJFBLPnFFubfATBDtsmGvK6qa+xG6WKHcEdbJsbGZk/jVX++BMbK/wf8IBD05drhBpyQecPij4UkPtccTzDbaR/mqS5c1obE5n2wKb++lVxzDE+yeWsSkI3xF/AfLojVhx5sCLuV2iWbJBMSNhw==
Received: from BN9P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::21)
 by BN5PR12MB9461.namprd12.prod.outlook.com (2603:10b6:408:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 20:05:13 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:408:10c:cafe::c5) by BN9P222CA0016.outlook.office365.com
 (2603:10b6:408:10c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Tue, 5 Nov 2024 20:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:05:13 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:04:59 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:04:59 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 5 Nov 2024 12:04:58 -0800
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
Subject: [PATCH v7 12/13] iommufd/selftest: Add IOMMU_VIOMMU_ALLOC test coverage
Date: Tue, 5 Nov 2024 12:04:28 -0800
Message-ID: <abe267c9d004b29cb1712ceba2f378209d4b7e01.1730836219.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|BN5PR12MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: f4907721-3aea-40ce-eba1-08dcfdd528c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5z3icSKAqRqZHCkn8Mdqh4gAUbxxP3HCrnuRt8Adn851dY7LzBqyjl8XSVD3?=
 =?us-ascii?Q?JBXyrdT+mWSLWjWk11KVw1YQ021EQGARXmiHGTIInLyH/lzUXBICKUWsU8uJ?=
 =?us-ascii?Q?Ih4OwT/IxE3MYzBSk3P0VOqEAnL8i+LroHgWy7MS+eGIcjN2P196+G3xu5Gy?=
 =?us-ascii?Q?/3ULXtNPwn30oQEi3FSvhMLLqzswwQqtbPhqDfWd2VMGmTkSM+LlBB6heqhY?=
 =?us-ascii?Q?AX/AMy0S5e18kCCepszO17PctgdNHAG1dWoX0GUax80mImdHVSB69Mqsw30w?=
 =?us-ascii?Q?4fPP99PCEoQ+5OjtxPVjqORywpiqRB7fy/uCe1frS/eRuyLF/lV8oJi5qoyR?=
 =?us-ascii?Q?Pj4hMS6etyCk4UL7VFWS2JQlvyC220cO12zqaAN6RvUEycSRF96riFDona0w?=
 =?us-ascii?Q?oRGSr65cVdnJpJvAziPLCn49TZAqisR9Kc4hKCInC2Wrl8pWyUIW8ZIXGv/N?=
 =?us-ascii?Q?PQ5/L05tRsroklIWK3hoVNUSG4wxeufs/4convdKzPzW8S/fUGrtO0FXerHZ?=
 =?us-ascii?Q?OXbGcMNuwCtP20iJeGWRJw9AoGsBQjk6eyozypOKDuZq+7V1D6SX0FN3vVeh?=
 =?us-ascii?Q?8FI5v2OvuEXgzBIzsRdkjGT0DxrBhjVQ7/hg/j/uGHUdNkLTMaDT6nvS2mnW?=
 =?us-ascii?Q?GcjwbajsCTLgBF8vwUDFaUdSxrHxMOvOy9nzheVp2JCpFneDuu58LsSspo0K?=
 =?us-ascii?Q?Q+GzexXelnvb3SGVCASyuHJrVgE1/pAwEJp+cxLHQ4J3P8DBjGGdfhoZky+8?=
 =?us-ascii?Q?/lXoTZXAfPXVHDNnmeRJJPgTwJQYYFTTrlraq3/lxQfytOBuWiTpSYEBIHdl?=
 =?us-ascii?Q?cgfWizOY91HySUSp0wFbGo+frjjzUFE+aJcdusbzo9Ku9owtxsznncvkQzpq?=
 =?us-ascii?Q?/s2TThoGHnybU06ORdUrEqroZ7wydfXiOeKssoCOCu4QuNDTk/Vrwp4TCDSJ?=
 =?us-ascii?Q?2+PgJ0iDoK9mUtAeBGKZz8Cuht8SiM5vbDK/3nzSsHWkNW2ZJRG1Ml/aX9b6?=
 =?us-ascii?Q?uMTz2YZg0N3dYHDWxeoRwskfRT/2EE4R4mkJP01d24fWkv/R/wLQOvFMZjaC?=
 =?us-ascii?Q?lPilRQv8YVTTfT6/TlEI6ggaGSLnZCJaOPConmW2uLwLmF8c69bz+EOsbSMW?=
 =?us-ascii?Q?oc+0FhPEVPyJJh3TCspKpxJ9O+bzA4MxowwaAIIl976UvHMFwB9g+zXXv8CR?=
 =?us-ascii?Q?nXeGStmgVfhMfWWQTp6JIErWiU4W0wA+TQp4wF6O6gepn1iDHEXVHRyI+9wJ?=
 =?us-ascii?Q?4BAdk2rFi6k4XhYy9Gvk0Q44c5AyPFo7/0+LLDaZQbSGmX/JSpQdVEPVxddA?=
 =?us-ascii?Q?l0byxCbXB/UkUtWiX8f/F0/vVHJUh8VAgweqYx5CDezKp85mlmDmQqOMaxXA?=
 =?us-ascii?Q?fIpDvyl1Vf+QiQ6CDRko/wdTSxrysdeGczGDkui6jrOTViEpUA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:05:13.1697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4907721-3aea-40ce-eba1-08dcfdd528c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9461

Add a new iommufd_viommu FIXTURE and setup it up with a vIOMMU object.

Any new vIOMMU feature will be added as a TEST_F under that.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h |  28 ++++
 tools/testing/selftests/iommu/iommufd.c       | 137 ++++++++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  11 ++
 3 files changed, 176 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 6a11c26370f3..7dabc261fae2 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -819,3 +819,31 @@ static int _test_cmd_trigger_iopf(int fd, __u32 device_id, __u32 fault_fd)
 
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
index 88b92bb69756..37c7da283824 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -133,6 +133,7 @@ TEST_F(iommufd, cmd_length)
 	TEST_LENGTH(iommu_option, IOMMU_OPTION, val64);
 	TEST_LENGTH(iommu_vfio_ioas, IOMMU_VFIO_IOAS, __reserved);
 	TEST_LENGTH(iommu_ioas_map_file, IOMMU_IOAS_MAP_FILE, iova);
+	TEST_LENGTH(iommu_viommu_alloc, IOMMU_VIOMMU_ALLOC, out_viommu_id);
 #undef TEST_LENGTH
 }
 
@@ -2480,4 +2481,140 @@ TEST_F(vfio_compat_mock_domain, huge_map)
 	}
 }
 
+FIXTURE(iommufd_viommu)
+{
+	int fd;
+	uint32_t ioas_id;
+	uint32_t stdev_id;
+	uint32_t hwpt_id;
+	uint32_t nested_hwpt_id;
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
+		struct iommu_hwpt_selftest data = {
+			.iotlb = IOMMU_TEST_IOTLB_DEFAULT,
+		};
+
+		test_cmd_mock_domain(self->ioas_id, &self->stdev_id, NULL,
+				     &self->device_id);
+
+		/* Allocate a nesting parent hwpt */
+		test_cmd_hwpt_alloc(self->device_id, self->ioas_id,
+				    IOMMU_HWPT_ALLOC_NEST_PARENT,
+				    &self->hwpt_id);
+
+		/* Allocate a vIOMMU taking refcount of the parent hwpt */
+		test_cmd_viommu_alloc(self->device_id, self->hwpt_id,
+				      IOMMU_VIOMMU_TYPE_SELFTEST,
+				      &self->viommu_id);
+
+		/* Allocate a regular nested hwpt */
+		test_cmd_hwpt_alloc_nested(self->device_id, self->viommu_id, 0,
+					   &self->nested_hwpt_id,
+					   IOMMU_HWPT_DATA_SELFTEST, &data,
+					   sizeof(data));
+	}
+}
+
+FIXTURE_TEARDOWN(iommufd_viommu)
+{
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
+TEST_F(iommufd_viommu, viommu_negative_tests)
+{
+	uint32_t device_id = self->device_id;
+	uint32_t ioas_id = self->ioas_id;
+	uint32_t hwpt_id;
+
+	if (self->device_id) {
+		/* Negative test -- invalid hwpt (hwpt_id=0) */
+		test_err_viommu_alloc(ENOENT, device_id, 0,
+				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL);
+
+		/* Negative test -- not a nesting parent hwpt */
+		test_cmd_hwpt_alloc(device_id, ioas_id, 0, &hwpt_id);
+		test_err_viommu_alloc(EINVAL, device_id, hwpt_id,
+				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL);
+		test_ioctl_destroy(hwpt_id);
+
+		/* Negative test -- unsupported viommu type */
+		test_err_viommu_alloc(EOPNOTSUPP, device_id, self->hwpt_id,
+				      0xdead, NULL);
+		EXPECT_ERRNO(EBUSY,
+			     _test_ioctl_destroy(self->fd, self->hwpt_id));
+		EXPECT_ERRNO(EBUSY,
+			     _test_ioctl_destroy(self->fd, self->viommu_id));
+	} else {
+		test_err_viommu_alloc(ENOENT, self->device_id, self->hwpt_id,
+				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL);
+	}
+}
+
+TEST_F(iommufd_viommu, viommu_alloc_nested_iopf)
+{
+	struct iommu_hwpt_selftest data = {
+		.iotlb = IOMMU_TEST_IOTLB_DEFAULT,
+	};
+	uint32_t viommu_id = self->viommu_id;
+	uint32_t dev_id = self->device_id;
+	uint32_t iopf_hwpt_id;
+	uint32_t fault_id;
+	uint32_t fault_fd;
+
+	if (self->device_id) {
+		test_ioctl_fault_alloc(&fault_id, &fault_fd);
+		test_err_hwpt_alloc_iopf(
+			ENOENT, dev_id, viommu_id, UINT32_MAX,
+			IOMMU_HWPT_FAULT_ID_VALID, &iopf_hwpt_id,
+			IOMMU_HWPT_DATA_SELFTEST, &data, sizeof(data));
+		test_err_hwpt_alloc_iopf(
+			EOPNOTSUPP, dev_id, viommu_id, fault_id,
+			IOMMU_HWPT_FAULT_ID_VALID | (1 << 31), &iopf_hwpt_id,
+			IOMMU_HWPT_DATA_SELFTEST, &data, sizeof(data));
+		test_cmd_hwpt_alloc_iopf(
+			dev_id, viommu_id, fault_id, IOMMU_HWPT_FAULT_ID_VALID,
+			&iopf_hwpt_id, IOMMU_HWPT_DATA_SELFTEST, &data,
+			sizeof(data));
+
+		test_cmd_mock_domain_replace(self->stdev_id, iopf_hwpt_id);
+		EXPECT_ERRNO(EBUSY,
+			     _test_ioctl_destroy(self->fd, iopf_hwpt_id));
+		test_cmd_trigger_iopf(dev_id, fault_fd);
+
+		test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
+		test_ioctl_destroy(iopf_hwpt_id);
+		close(fault_fd);
+		test_ioctl_destroy(fault_id);
+	}
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index 2d7d01638be8..fb618485d7ca 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -621,6 +621,7 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	uint32_t stdev_id;
 	uint32_t idev_id;
 	uint32_t hwpt_id;
+	uint32_t viommu_id;
 	__u64 iova;
 
 	self->fd = open("/dev/iommu", O_RDWR);
@@ -663,6 +664,16 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 
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


