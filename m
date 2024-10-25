Return-Path: <linux-kselftest+bounces-20730-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BAD9B137A
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 01:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E450B22D02
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 23:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C73217673;
	Fri, 25 Oct 2024 23:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IjRC+iRe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FB1217641;
	Fri, 25 Oct 2024 23:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729900238; cv=fail; b=FJDgOALim+sFRL3hqOoCVkjgr5qfuaEafKiGfv/F7yLLM3OofDE/1z/TGgQ/+hzxkVtzidfrZpUfH5YFQ3inB0/byaMyuBw3deMLwRPLipyaBAoExOsccDuAgtDtytpK+WpNIN37Agik7z6jPyFeiiHg0j0o9wkwF5ve8NwsrDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729900238; c=relaxed/simple;
	bh=LyjjlwkPnDD+suGCU8gPALNzVtIQbAJpFRF/rWyNOxg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E0pxyF4+Ui+SGlI+AwOrP3YA57DOFHPK50Cqc6xRpO0r/kWsGRZIPyxLAbVk92sOx4STFnFlmC9Sg8v8qbTKHOOxBYsyufNn9aaa6yU73Jpcqe2ILkD44KFQU+hwO0b3bs6toSgrqPCIXy7qXoB4YSNP4077gJvOci8Nf7S2lZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IjRC+iRe; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfbIrEcwqi5/vPrz0FywjUvFjdxHwG8vU5lhfwTNln8LZ5mD3RweVZgBh/Xqo+yThDw+ehXpKryRWIR483kFwo3X2S5ASVF9cvds8yDU5FfFiVjuqM2/RwzjtclQadFM2gaWzJPR79NMzxPD0ZZnuA4W02frcrEjTDJblf8bCiVWfuKidB7onkd5f8eEvXQ5x1nO3gEikQS/i2/E2V3bsAyHt6zPw/GngWCXFBccwD9LbqrN/jJptS6lTJnxs2g+NCWgLlMoenOkSv7H3QDni97Z3V2wPzSesFa+ysVgq6jQhCPSdoKWMSFYczI/u2i7AuMDkfmPnpl6+AcGS+Q89w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frk/klNtmWr7P7UCik2rYkf9A0JaMkyx6vg+fWB9bz8=;
 b=WJnle6tdtZ7pYHB6gP91fdbWYFdnUICs2h0g7n19pitw68EEgtaPP1jO6m9nPNfJgrvpwf5ZebX2qLhhZalKb6lpETfk7e/DOz85+Feptc2EyKfvlggO5hT2R/UtvdcPnJtX+XB+DnTu2lajO64AESTitZCmbrQ6WephOdLZZIhXfvmNJ/9C2+lvkr31PozyAzNBnvJKE+eea2Eua5MqmJpBzgTrJS/djVY/K9DRxb1pXM3oFMbeMoXISNSQEghfN6y/VT+GSsbF2Dxa2Yx17HDLrmLC+CBs2cdyQ6Up/0//mRBwQRKsTwxdQwSFl8si7t05jIAxF344eVMh4FG55w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frk/klNtmWr7P7UCik2rYkf9A0JaMkyx6vg+fWB9bz8=;
 b=IjRC+iReKQQnU/O8vzrDxxfmCmKPKpi+RVPPh8EYCvky6xFcWx5gHXIRnC60wK5YhtXAbv9bv+MAdoAQ9aAYPVmpXnzYU+aP3lE1L6fsDgPoHL1r4fAAYf+KNqpIdpZvA00IuuUEUNG2enk6dMOG+AhPRUPAoVh9r741LgtNJHDpINh1RO4l6UFytM2iRmTYoU9efAs1jBVUZW4DzSLBH36gZArdtqw+QezlP+OXKwfLJ2dJokDQty6lPZGooaVY2O/TqpNTqXgNyg7vMdZI6DPfjN24/omRoFG54uGkMIye7/HwMLoPGWLX5R3+WilhejSLcUorcG6yS8ya13NhVQ==
Received: from MW4PR03CA0219.namprd03.prod.outlook.com (2603:10b6:303:b9::14)
 by MW6PR12MB8999.namprd12.prod.outlook.com (2603:10b6:303:247::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 25 Oct
 2024 23:50:31 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:303:b9:cafe::4f) by MW4PR03CA0219.outlook.office365.com
 (2603:10b6:303:b9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 23:50:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 23:50:31 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 16:50:18 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 25 Oct 2024 16:50:17 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 25 Oct 2024 16:50:16 -0700
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
Subject: [PATCH v5 11/13] iommufd/selftest: Add IOMMU_VIOMMU_ALLOC test coverage
Date: Fri, 25 Oct 2024 16:49:51 -0700
Message-ID: <db4c0aa6e95f46f8af040af847139a54e57c29d2.1729897352.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|MW6PR12MB8999:EE_
X-MS-Office365-Filtering-Correlation-Id: 45bd1463-52a0-4e5e-dc13-08dcf54fcfd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8QSqnR+pq0XeNEJczb6qrxii0iUqdQ6f/aHSNFA257SjjFyLhnmKn9aB/Wce?=
 =?us-ascii?Q?Skd8Iq12ILOOshTwoo6f7FU+z/zaOMuXevFTnmszDxIZ3H9mJciaD9eLKEEC?=
 =?us-ascii?Q?+4q/b0M8tYq0NpfnTEi+a5o8qLMe/EnhXb3p8LQivZL4K+/ZU9N/YMqRGNkl?=
 =?us-ascii?Q?1MVTaZXI1ESZnd2C6rQX7Pf7GWfWybbJ47nMEx3lOetbpngpj9Cm0iK/89gG?=
 =?us-ascii?Q?SV4CBb7MuYSoz2a4QIgM+m1304A4Ur2MZmB633gEeba47djX05tlr+XxMBD6?=
 =?us-ascii?Q?5x0EmMVNKlreAaze+lgbmZ7PIS0yV5vnkxdZHGn9WamzR/G1UOLwfdiZM9y1?=
 =?us-ascii?Q?qtLRG6ZSGagw986QMFmqxTDS4TJHBm1g7bHgBN2/cELL8zWfCy5fX/VFEHJf?=
 =?us-ascii?Q?B8hYEVW0TF9p9O2/deCCYXknzARsyc7PECxt+O/1SE1zxPvpfMYLhBb/4xsu?=
 =?us-ascii?Q?wteMW31bgmAfv6lEf5h4EKyj95Odz5rhkrBFFKs9OdupatAP0gAsMbDT8K5e?=
 =?us-ascii?Q?QwMjz1OLqqGnLny7Lm+qLSZMFoUzg9MXGs5M9r4D/TdtfqD+eIu86iCYX+n/?=
 =?us-ascii?Q?fuu1HL8SYCk5nEGPHuUUHvLD0omvcqkJhlSue11ppgD6h196BoSzUzxa9KOg?=
 =?us-ascii?Q?ozcsN8SOJg2HTJifTGHPWl5lKqWOomvVC9p6hPAxiaZa2Awy0+EKNMnqMntX?=
 =?us-ascii?Q?1BLnpJW5vvXxDkmlML4HusZrbrFqJ7YlovK1R6u8ILlSLW1OUr6ygc719qBe?=
 =?us-ascii?Q?anNQNUE3lYUMb2TshRvl3hyOnQTpPVRejSHTOeMWBwCgiLwKrooiEuKqCvzo?=
 =?us-ascii?Q?rDn7eAMsFEB2wRYm6TqEZph3AwZVRacrI5tGmIebMpdFoJE6NB5K+pmCyH33?=
 =?us-ascii?Q?lLB2JhRaxBZKJiDl5uE6pgn7CFK+nT/JRv4oQ/44NduNUn1oZSFPa5hBTUtA?=
 =?us-ascii?Q?UnbapZsPh3E+GEJ111/GnBBsSRRBPBc8FPKMCeSq8OYV5KYyeMw1CdheF7C8?=
 =?us-ascii?Q?JrnlWNxdTf18b3TPGSH9KJ12p3+++n2UkBr4MQM7/rg6xnVmVLd1wjpNsku9?=
 =?us-ascii?Q?yZSMWLKUbShdrsSOdKJRhZQDNZ3eNLoKwXCda/m4qgB4fKHH4LD1+ohmWVqB?=
 =?us-ascii?Q?eT+Nv3hbcS+1+k2JNO9bgbARHbQmEtW6dpZaiNS4rrFZisOmJpirrltp27bN?=
 =?us-ascii?Q?8HeLb7DL9fj5vwswbI4Mhwo5jb89NwHaXfaXmMACH36OXhHIkDvsoH76Nu4e?=
 =?us-ascii?Q?djQV0G3WF5nOOVLH4ITz0HFEWxpM8PXW5Y2PPyGBEh0cdk+GhPQxyxes1asw?=
 =?us-ascii?Q?XcTvcCLRpKs3P5Xs/Lfe7s87LDyNW9bBUoNyWM3uYWJceync4h+ybmg8vAuV?=
 =?us-ascii?Q?PaiK6DDGeWl/rxzg1ytv8NR8k03tc1SVQFyfQ5ZsNhbdNiwCFA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 23:50:31.6623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45bd1463-52a0-4e5e-dc13-08dcf54fcfd0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8999

Add a new iommufd_viommu FIXTURE and setup it up with a vIOMMU object.

Any new vIOMMU feature will be added as a TEST_F under that.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h | 28 ++++++
 tools/testing/selftests/iommu/iommufd.c       | 87 +++++++++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        | 11 +++
 3 files changed, 126 insertions(+)

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
index 4927b9add5ad..b48b22d33ad4 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -128,6 +128,7 @@ TEST_F(iommufd, cmd_length)
 	TEST_LENGTH(iommu_ioas_unmap, IOMMU_IOAS_UNMAP, length);
 	TEST_LENGTH(iommu_option, IOMMU_OPTION, val64);
 	TEST_LENGTH(iommu_vfio_ioas, IOMMU_VFIO_IOAS, __reserved);
+	TEST_LENGTH(iommu_viommu_alloc, IOMMU_VIOMMU_ALLOC, out_viommu_id);
 #undef TEST_LENGTH
 }
 
@@ -2386,4 +2387,90 @@ TEST_F(vfio_compat_mock_domain, huge_map)
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
+		EXPECT_ERRNO(EBUSY,
+			     _test_ioctl_destroy(self->fd, self->hwpt_id));
+		test_cmd_hwpt_alloc_nested(self->device_id, self->viommu_id, 0,
+					   &self->nested_hwpt_id,
+					   IOMMU_HWPT_DATA_SELFTEST, &data,
+					   sizeof(data));
+		EXPECT_ERRNO(EBUSY,
+			     _test_ioctl_destroy(self->fd, self->viommu_id));
+	} else {
+		test_err_viommu_alloc(ENOENT, self->device_id, self->hwpt_id,
+				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL);
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


