Return-Path: <linux-kselftest+bounces-19378-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C177997208
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 18:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A628FB229EB
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 16:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AF11E500F;
	Wed,  9 Oct 2024 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B4JT+4yz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7BA1D0E38;
	Wed,  9 Oct 2024 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491962; cv=fail; b=pKHJOYPqsl1xsANl7GoHv3Jaj03vSy29mYiHViRy0E3rV1Q6xLqBxmhxUoUc0aCMdBHC6gUYJMvzP4asTVAWYEAZtvwAmqjBOyc/swMn5PKGbwV/DIFgQ3bH24ULKMWuAd97HWHUlzsJhfzpvsdvrPcZfiQ7mmvAXfrBfZJAu04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491962; c=relaxed/simple;
	bh=JH8wZvaPIWhmbtNUTotmbtO7xXlgCZGwbv0M2QK45x4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PmwhGISqIuZKWTCi3gYOgVcCHr7C/LRb6YdjnycyT58Cu59jWBz3T8J/+Wt0qKRCa2nQegbsrhclrv8kfrKp24rYD9P0PbedMJ9mofyFh9HsrGhrxvYNCc59XxlpPfc+WAW3vKrjIB9oVnRN6LQ4z8CSCxPE6fgvh5jSStVVGwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B4JT+4yz; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HrlEX9yzicleVOxQL/tZg/NGrphzS2F59L0EhpEVkAOtC2vQI0we/LTm63JtZjGsDIHoNz+n7cD4vJxefv8uJT29M8JUr1OQv2beHVMDxxxncl1yhHS/TwyrOPDIg49iiWHvIJXdoK+6fAGmKgRlRcAOljQAAY+iaZZnmbCDdr3Mhl8cq/t1wISTuLHSJD/atQ8VWOyTfL7IjNXlaRlQ2a9AGRtejhRe9djPIEfPcMIxPH90NuAlZNpX6HJLpDQR2o+Za1KXyMv5y5GwXO4ehHoNwb4/BPbaXKb/4a24l1X7eftiXZZ80OIjBkK6wTm1anWP5OGYoP+w7+6Zuf/fbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmPe546eXRnRwO5Ecz4tLVsC8DfRpXPdFWPF5RSHKVY=;
 b=xdk81qz2FYgV6Jtvh45P9IEJO2KykCcptgTZkOewrv+7wwaQHg1mvU5d9zUjKm3QDk5JrNmJ78oz8W6o4eioSYyKidpdU60XKvxC5M3ffhNzeQuyVUM9OS/5c4SprN5oS732X2cJi7X7vwUS4PW7kjq8cG5DmW/hgjixRj6ULPuPH76rqSMXAli4bk/cJm4g/plvElgwYPPIEB67Jup03kxiL/rEIc7aUg5pdn8acSqLE4LmkbBLT0/sL732673c/kcsLPz6gPCxaW8By4YTY9yGla1IjnW7KfUhb9IAhCAte1PWr3AOpO5EPtiZc/OVtSt6pGn5tSAvB/9Ef3NVHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmPe546eXRnRwO5Ecz4tLVsC8DfRpXPdFWPF5RSHKVY=;
 b=B4JT+4yz/SnAXrmbGkHxk9bU5IsRSr6Ddo5temXBJGBQH04mtO34yXrQ1mYrAQYNM3LmveQjVYAlBAo0CpgHSlpZ1YgLKzX4f+Xm/dTbRK0U6Ium+q65PJ0WX6RWhkHFwHjgCv8T0kah9no2bd4VWWQz3ROYqbvky+1VyVnqsG52fuFC0/1nUO4CzLIIDNrclPZJQiczFXDDXRUIcdfCz0NRW65+V/ugJXyDSXrbcUw41jdGGk1cKd8DD6PjaUy0ZYqABu50lZAlj6021bhZAONY7GZwDCzrCov6ylD/tqKFWfItdt+/XAWZlOQ5tNaV8So3c/vf7FPSuGUQZcjsWg==
Received: from SA9PR11CA0011.namprd11.prod.outlook.com (2603:10b6:806:6e::16)
 by PH8PR12MB6722.namprd12.prod.outlook.com (2603:10b6:510:1cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 16:39:09 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:6e:cafe::8c) by SA9PR11CA0011.outlook.office365.com
 (2603:10b6:806:6e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 16:39:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 16:39:08 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 09:39:01 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 9 Oct 2024 09:39:01 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 9 Oct 2024 09:39:00 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v3 04/16] iommufd/selftest: Add IOMMU_VDEVICE_ALLOC test coverage
Date: Wed, 9 Oct 2024 09:38:16 -0700
Message-ID: <afbe4bb0a3071a27f6e93ce201ebe335e7f3b62d.1728491532.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728491532.git.nicolinc@nvidia.com>
References: <cover.1728491532.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|PH8PR12MB6722:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db9b211-4d67-4c93-49bd-08dce880e5c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fqh9pR2YNANsPPmUqtJ5iZaaWO85JterV0LuN4YF7DOlTEEdZp0tsrZm0ddf?=
 =?us-ascii?Q?4b0GEuF6esiXNU2IEsfn4i4j6bXkLm/7k4jX97WwApTzzGC+KmdJShXETyGX?=
 =?us-ascii?Q?0aNvQI2BQ1RuSzX74d9rtoDILrIrCk16zj4ztjmmD3iGSm/QN6I+4Q3QlDvm?=
 =?us-ascii?Q?uL982pucm9GMWsMd5xTWtyDUZuJZ+C3/qKbWgEVcKWZmqpDFoRk9mcR7hd9k?=
 =?us-ascii?Q?cBzxQBRtnfoi5Vja/9LnYvkvkxEihdo5a3iXw7Tv1YmVgnknVm8F2j8n0ECl?=
 =?us-ascii?Q?tY7D2ns0nvT2FtJoXr/xesG5KMIu/FXNxkrHq7gO372Aq6XwJJnT/1FxJ/Eb?=
 =?us-ascii?Q?ljfCtIaUGQHkdP2O4yr2Czz2HYiElUM2WMg/cb/Wu9laOlulJ2tyWTlOMRpK?=
 =?us-ascii?Q?CE62yu7Z2lgYNWDe32WLsOidnYwYU0Gy+7bcTXx9regQ/R9eK6/0BZcyuoxz?=
 =?us-ascii?Q?x8p0ZNy2WC+ElW3h3msvnt+zdHffEkles4odm1ABmjea2gadOfpiQxC1dgHx?=
 =?us-ascii?Q?na5ItOfj6Jxggu9F64t5T5oPDhBcGpLNzciJVGR7MRkvK7A5Ruj8ho3Orfy1?=
 =?us-ascii?Q?KKr8jx3Upnwug73Y2wbj7SCAv0TVUXwjCOpnPrxkaRc1vn+plhRPc5wog+sx?=
 =?us-ascii?Q?/fbdIFVDUKLWqEqBKbKISoPxTDTEB+4V85J/ZxENjsOL7oMXduPkMmfAkRun?=
 =?us-ascii?Q?OLUgGOKWiTOlWT5qRnSILHSL2V1tzrhTf9+J/aVHcAHk1UGUXXXQv6qiz72P?=
 =?us-ascii?Q?Z7vjPHqFgxPb/dJvBlYdxeXXFnVGYNzdID4+H1HZqBEQYG8T89cGf5e5/sk8?=
 =?us-ascii?Q?ZE8eTCWX0oOS62HvZG0Q+WUYFj97nB0rhpbupOuEHytVH9tJ5yoJAprH4FbH?=
 =?us-ascii?Q?d6IeaW1WNEPs1tOJ/RIWRmLC3WFvcrOfC21hH/BSlolJBUcAxpLofmKqM/ji?=
 =?us-ascii?Q?HFl6aE0kGcN1Q+nlhBQu4QnDSfqZ2bw9iw8OtwjhL0QNZCUbrlF/1jgJQ0dL?=
 =?us-ascii?Q?zIqSl7pWbyu3KETsXhz4+dRfEVSLr7SmjqunVxHqMfKMoiUpmh6VIFzEnj2B?=
 =?us-ascii?Q?AXyprWEnsMig46vQ8CbA4Acbc+VPSoNzunHCKgMUKbARm82do+vz646Mv/QW?=
 =?us-ascii?Q?G9OSItioASjo/dw4+FTcjS2KnWY//EjGAa3fssy1gSAYLq85Zu0cBTvWvS/f?=
 =?us-ascii?Q?H0acnXbsDJyrtP9kvHC0nvrPugh61ptZr5Dy18zfOTTcdw/eXZ6NrgX0cg2w?=
 =?us-ascii?Q?B/Suf2XweZ/H0ohFSzFBMcDp8HgmLDzNTwz8tfp2e2Xbb35hTgv4Wiz+TJQE?=
 =?us-ascii?Q?u5DIXz4SGt5HcYBFyCzoo4B4yRr1fWi7vmhbPk1LoZ7IHlR1HG9D6dKCrXiy?=
 =?us-ascii?Q?ciNqvvg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:39:08.6600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db9b211-4d67-4c93-49bd-08dce880e5c3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6722

Add a vdevice_alloc TEST_F to cover the new IOMMU_VDEVICE_ALLOC ioctls.

Also add a vdevice_alloc op to the viommu mock_viommu_ops for a coverage
of IOMMU_VIOMMU_TYPE_SELFTEST. The DEFAULT coverage is done via a core-
allocated vDEVICE object.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h | 27 +++++++++++++++++++
 drivers/iommu/iommufd/selftest.c              | 19 +++++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 20 ++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 307d097db9dd..ccd1f65df0b0 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -790,3 +790,30 @@ static int _test_cmd_viommu_alloc(int fd, __u32 device_id, __u32 hwpt_id,
 	EXPECT_ERRNO(_errno, _test_cmd_viommu_alloc(self->fd, device_id,   \
 						    hwpt_id, type, 0,      \
 						    viommu_id))
+
+static int _test_cmd_vdevice_alloc(int fd, __u32 viommu_id, __u32 idev_id,
+				   __u64 virt_id, __u32 *vdev_id)
+{
+	struct iommu_vdevice_alloc cmd = {
+		.size = sizeof(cmd),
+		.dev_id = idev_id,
+		.viommu_id = viommu_id,
+		.virt_id = virt_id,
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_VDEVICE_ALLOC, &cmd);
+	if (ret)
+		return ret;
+	if (vdev_id)
+		*vdev_id = cmd.out_vdevice_id;
+	return 0;
+}
+
+#define test_cmd_vdevice_alloc(viommu_id, idev_id, virt_id, vdev_id)       \
+	ASSERT_EQ(0, _test_cmd_vdevice_alloc(self->fd, viommu_id, idev_id, \
+					     virt_id, vdev_id))
+#define test_err_vdevice_alloc(_errno, viommu_id, idev_id, virt_id, vdev_id) \
+	EXPECT_ERRNO(_errno,                                                 \
+		     _test_cmd_vdevice_alloc(self->fd, viommu_id, idev_id,   \
+					     virt_id, vdev_id))
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 4fcf475facb1..87bc45b86f9e 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -136,6 +136,11 @@ struct mock_viommu {
 	struct iommufd_viommu core;
 };
 
+struct mock_vdevice {
+	struct iommufd_vdevice core;
+	u64 rid;
+};
+
 enum selftest_obj_type {
 	TYPE_IDEV,
 };
@@ -560,8 +565,22 @@ static void mock_viommu_free(struct iommufd_viommu *viommu)
 	/* iommufd core frees mock_viommu and viommu */
 }
 
+static struct iommufd_vdevice *mock_vdevice_alloc(struct iommufd_viommu *viommu,
+						  struct device *dev, u64 id)
+{
+	struct mock_vdevice *mock_vdev;
+
+	mock_vdev = iommufd_vdevice_alloc(viommu->ictx, mock_vdevice, core);
+	if (IS_ERR(mock_vdev))
+		return ERR_CAST(mock_vdev);
+
+	mock_vdev->rid = id;
+	return &mock_vdev->core;
+}
+
 static struct iommufd_viommu_ops mock_viommu_ops = {
 	.free = mock_viommu_free,
+	.vdevice_alloc = mock_vdevice_alloc,
 };
 
 static struct iommufd_viommu *
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index c03705825576..af00b082656e 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -129,6 +129,7 @@ TEST_F(iommufd, cmd_length)
 	TEST_LENGTH(iommu_option, IOMMU_OPTION, val64);
 	TEST_LENGTH(iommu_vfio_ioas, IOMMU_VFIO_IOAS, __reserved);
 	TEST_LENGTH(iommu_viommu_alloc, IOMMU_VIOMMU_ALLOC, out_viommu_id);
+	TEST_LENGTH(iommu_vdevice_alloc, IOMMU_VDEVICE_ALLOC, __reserved2);
 #undef TEST_LENGTH
 }
 
@@ -2470,4 +2471,23 @@ TEST_F(iommufd_viommu, viommu_auto_destroy)
 {
 }
 
+TEST_F(iommufd_viommu, vdevice_alloc)
+{
+	uint32_t viommu_id = self->viommu_id;
+	uint32_t dev_id = self->device_id;
+	uint32_t vdev_id = 0;
+
+	if (dev_id) {
+		/* Set vdev_id to 0x99, unset it, and set to 0x88 */
+		test_cmd_vdevice_alloc(viommu_id, dev_id, 0x99, &vdev_id);
+		test_err_vdevice_alloc(EEXIST,
+				       viommu_id, dev_id, 0x99, &vdev_id);
+		test_ioctl_destroy(vdev_id);
+		test_cmd_vdevice_alloc(viommu_id, dev_id, 0x88, &vdev_id);
+		test_ioctl_destroy(vdev_id);
+	} else {
+		test_err_vdevice_alloc(ENOENT, viommu_id, dev_id, 0x99, NULL);
+	}
+}
+
 TEST_HARNESS_MAIN
-- 
2.43.0


