Return-Path: <linux-kselftest+bounces-21175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B527B9B6F56
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 22:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAECA1C22696
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 21:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCC8218D63;
	Wed, 30 Oct 2024 21:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S1bEz0OJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3C52296D8;
	Wed, 30 Oct 2024 21:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324145; cv=fail; b=caKxqQw4eyxypPIcPU98VmVXsvbXhR+OQOnBcgHqQKY2OTItqdQ2QuFnuuotUIEz+aaNzrE/HxppKfUtSL8Xd/VhSi0+UrYt0YeZHUUdTPvR2vpU8b/rV+0cawcJhw+ox/GH+Wsy+Cib5grybODeLQyBR3JYISRKhgbTVH4mLp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324145; c=relaxed/simple;
	bh=T1wbI6by0JBYmd//pmoH2ZvxWDittyZsftmpRBU2YWI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MfsgO2eL8gSgi+KR6lZ5XdRcT+m3xCF0AK6b9BwVizw0eNABIUZJkS7bQo7cfIb3l/+B9pglN5GZCI4RjwFwnOKjVK7xMdQ2MDNsKNKCwt86+0DW9vhleEmInn6Bm5KibZH1EeHapoQNRptg6lE5bdrh2WRpE8H5dXSWiwS4QQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S1bEz0OJ; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EpxAtOXUJG61JIyoCsTqbOkp2r7UgvdolK4AYRbS1O9OVTI40UPldVqAqQMN2jzw2+9EH+gHY3laS1XNYQOuzUbeGw+gOY+7M3+DvOSsQJhgl8f0cGtd5tE5o/CiD/5WE0ds3GkhXcDn9Ihpr5jmMoOvqRWXEPMaIjcJi3lyJCyuh1JuPPbT9UQv6r72eblwmtZhyCklE1i5BKWQ/HMHVWUCt5yhqde3ItEclZHbLUIxsyfjaeawCMEXjkllna1QDkzl5toqJ3a6cDa80sigfiVzgBskYR2iW7OB9DTfAFeMuj3EGicZttYTsf3nsET2BMlgW2YOfmJ2oxEfPLG/jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMSjT/egPflIojDvdvcXmjZeuSPlTWIFCl4jiFCu+gA=;
 b=dtxO+bGhVm6tTBhqXCkGrJmGNEeeWtnveDZE//qGckk4y0GM16/NyqGFkmASGfGkWQraEKYPOvEqi5Stl/hIfdKz5adKOOI9T3+F4A5YVP6h/wQglGXA1USuqPNF46/1BY5oPoRhS1jTmozz1X8K4NEn/Ym77SXqNemaVhIRe2yKvWPS/84PRNCNr/X9lju47C+GcPZDPI/FQES56IxSjJAI2oiFjFc5VX8XA2sZmMSmKT+YayisI5QMp/tyA7SitoBJ02W8oax8ouIk7s8zGoJYi3niPSjB1z1qGmtwPw82kDt35lzs/rFwV0db0i8VxFJLjC6Kc938Q/HBXWO+wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMSjT/egPflIojDvdvcXmjZeuSPlTWIFCl4jiFCu+gA=;
 b=S1bEz0OJmuF7alReda3XdQSZeUltDeITF3ctYY8V3LI0a8bzHxO8Xi+Nf3FEcGcll4XDhYSj4pxJG4Cj793Td6NOQS6kEsEAZHGY5gRAmGTetcSVSIDmPmIxRR3WsWBTfhzGBSksiAF58ptcPlBQBT0MHByD84x4XfRy61ySJ0tmOvvAx0tmdgFj8edQOFVpWeJwB3R893Q0GqRaaivlWuoRr8hMPTNgkK6NlRLFbKp9lzhUeDyKW0/jBYfRtNeJAi3OlKc9WcToyQFW7X138MQbnCoSBYvTlulUaW7CJnBcVqjns1eunVeArrfbw/wCIpbklDpXDSRP6fLkDhFfiQ==
Received: from CH2PR20CA0003.namprd20.prod.outlook.com (2603:10b6:610:58::13)
 by SJ2PR12MB8978.namprd12.prod.outlook.com (2603:10b6:a03:545::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 21:35:35 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::a8) by CH2PR20CA0003.outlook.office365.com
 (2603:10b6:610:58::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Wed, 30 Oct 2024 21:35:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 21:35:35 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Oct
 2024 14:35:13 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 30 Oct 2024 14:35:12 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 30 Oct 2024 14:35:11 -0700
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
Subject: [PATCH v6 12/13] iommufd/selftest: Add IOMMU_VIOMMU_ALLOC test coverage
Date: Wed, 30 Oct 2024 14:34:38 -0700
Message-ID: <8188b47bbee49e071907e1df37a3af269bd840b6.1730313237.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|SJ2PR12MB8978:EE_
X-MS-Office365-Filtering-Correlation-Id: f6bff9da-87e6-4025-3581-08dcf92aca14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zdFZTYXB3PNvbO6JcFx3+ynp+Nip9RMHE3Sxme3bKvZcPZkWOZVnOxTePD8b?=
 =?us-ascii?Q?nsB2xkDQ9izcLC8cTZSsLWqNHZf1/LtUonFAPKF5wpflP9lWV1ShrcjZgxQA?=
 =?us-ascii?Q?40CAeKuahBF/61j5dnvXqFlM/VIirx+LBK7LZdwueppFX7lraq6vziUPVFds?=
 =?us-ascii?Q?4HOMXyxT6N19JqVxoK+72DznqQRu/DfpI1SsypgrCguw3GGTnfhDx6n6Pz0W?=
 =?us-ascii?Q?ZL8FhmDjHzb6wleNVrJMsJhWVSBwDEP3EbfQ8bYfXNNtZvAPWB73p/6Xfgop?=
 =?us-ascii?Q?iUkh4W5F6yJgmJNcTc0j2c41V/xSagLsQoxjH92YNpXKMmkoaHypTSSV0LO0?=
 =?us-ascii?Q?o3pH+feo5zH0pAS6bbSg6yl2kvUBYrBbG49fVxM66x1Bswj4Ypxw9oqFmJAQ?=
 =?us-ascii?Q?LGil/r8q/8l2r39eODK0EJz05Jsn7/o6KmqzV4erU99aDAz8vfH/r6fZCugi?=
 =?us-ascii?Q?NVLXhBXXECgyAm84oGeZNrwi8k6ht2rsze32T9qrkS36yyR3JAJe0nzVOKCw?=
 =?us-ascii?Q?7Fw1Sl9fp44xTpwwxTAog5uUk7Kv11Ro/43CyWpsToGjgCFt1sbOzdpJ+hWb?=
 =?us-ascii?Q?2O7MyudxvHBX2PnSYxelWYYj1WhXADSQ2UrYUnQ6GMrvmKwp1C8B6VsvdHVi?=
 =?us-ascii?Q?py+zVaTslbYTqad5wWTzLPUHJBsp2/fu3KHPI1MCoY7XC6QfyaT3fAVi0iid?=
 =?us-ascii?Q?s72zDDqWol880/+AqDUAQt4IBLFBIa9IIac/VsVt3Ko2WRxfv2z02MhSUhCN?=
 =?us-ascii?Q?pPUJPgWFd3+c1lBxudqa/toEFa3LSCIowArppf+naOYYhSLWcuib2ZPbiQE7?=
 =?us-ascii?Q?/Ayy11bXN2/2SeC7DCwIGocsH4rGuMDqdyBBkHHttT3iwI5RWA2GPsZH5eo0?=
 =?us-ascii?Q?5ApeSz2un52Sgt6XY5CqJoj4eI2wB/82Ywg9JXDiRwiOAUbAuY8S0G6nO9Jz?=
 =?us-ascii?Q?PpaiSObj/xEY9oRUSy581B0+GVMmKwccCPRtFxdwM8QX92bmJI+VMu4DzqSq?=
 =?us-ascii?Q?CeHxFt8TUfJ+P8QRugTJ5LjmEA+G92L83KZlIIbvq+R0Jd+Gf6xhcS9kQThc?=
 =?us-ascii?Q?wwcd/+xSYFruJNnG3fJpF814lZFtRX2OzUIlc0U+DkotaiU6R7UqAHc2OX09?=
 =?us-ascii?Q?SNznj8au2MtZr+Yj7XLPuNe4unLXrsPd5Nu7sdLHQ3s/Ec+ceawmhX16IPO6?=
 =?us-ascii?Q?ywT6FfKBlSRq3Umg06yJFs0ZpEAUxrnIHNs6mpun5laO/CIk3kMkUQn/2c5P?=
 =?us-ascii?Q?HitltVOCR4ogDaYa/uAvsVOqQpwcMinUihlv2LC1T0xw/l/bxXc6YAAJAF2h?=
 =?us-ascii?Q?ZlrFpuggUKELPHotZQ/knrZnfffvem+zu4N8CKWMkfd6RxSfjtauyqGY3tre?=
 =?us-ascii?Q?7xeqiEjmT7QWo9Kb7HNLly/Z/5GmGgyh9fEiVjdpyFvUwgOdDA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 21:35:35.2626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6bff9da-87e6-4025-3581-08dcf92aca14
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8978

Add a new iommufd_viommu FIXTURE and setup it up with a vIOMMU object.

Any new vIOMMU feature will be added as a TEST_F under that.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h |  28 ++++
 tools/testing/selftests/iommu/iommufd.c       | 128 ++++++++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  11 ++
 3 files changed, 167 insertions(+)

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
index 88b92bb69756..3142819cc26d 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -133,6 +133,7 @@ TEST_F(iommufd, cmd_length)
 	TEST_LENGTH(iommu_option, IOMMU_OPTION, val64);
 	TEST_LENGTH(iommu_vfio_ioas, IOMMU_VFIO_IOAS, __reserved);
 	TEST_LENGTH(iommu_ioas_map_file, IOMMU_IOAS_MAP_FILE, iova);
+	TEST_LENGTH(iommu_viommu_alloc, IOMMU_VIOMMU_ALLOC, out_viommu_id);
 #undef TEST_LENGTH
 }
 
@@ -2480,4 +2481,131 @@ TEST_F(vfio_compat_mock_domain, huge_map)
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
+		/* Allocate a nesting parent hwpt */
+		test_cmd_hwpt_alloc(self->device_id, self->ioas_id,
+				    IOMMU_HWPT_ALLOC_NEST_PARENT,
+				    &self->hwpt_id);
+		/* Negative test -- unsupported viommu type */
+		test_err_viommu_alloc(EOPNOTSUPP, self->device_id,
+				      self->hwpt_id, 0xdead, NULL);
+
+		/* Allocate a vIOMMU taking refcount of the parent hwpt */
+		test_cmd_viommu_alloc(self->device_id, self->hwpt_id,
+				      IOMMU_VIOMMU_TYPE_SELFTEST,
+				      &self->viommu_id);
+		EXPECT_ERRNO(EBUSY,
+			     _test_ioctl_destroy(self->fd, self->hwpt_id));
+
+		/* Allocate a regular nested hwpt */
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


