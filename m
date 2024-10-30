Return-Path: <linux-kselftest+bounces-21174-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF06E9B6F50
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 22:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35D9BB2417A
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 21:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D678229B4C;
	Wed, 30 Oct 2024 21:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qNDtXNc5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FC6229B22;
	Wed, 30 Oct 2024 21:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324138; cv=fail; b=gKsWn29mfB3YnqzYzkxIP2IdHNq90rU5PSMMGd8WeZ+YdmCGUT/umnOV3OE8/zhK6aTTOH6qeBKmEjV7wcLh9kA0VPS7phoXHNW1UcQPH63cVo1G44EQ0IZYy7WaV/M1KkuILPLCzBOyBbC+n41vyAXuQVq/AkU4tWcZ9WMl8NA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324138; c=relaxed/simple;
	bh=+iScv+JPH5qZd8WJf8hN+2Zy1gN2CgRyr1NqLkHDIe8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lt3qeDqoQNetI/Qk68h164kyEO7KpR3dRRU6QDPOan3lRe/g8y6pzxv+/B3/cim5Xw0PSSkhPCtEF7EHAkzY6GHZ2MtPJ2IZ5oMCwhA5mou5xNosDpjmSX7JGw+hZADhik59JR4NdchlbtUJKyU6XlxdSxvGpfHqSDlOeGUscCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qNDtXNc5; arc=fail smtp.client-ip=40.107.101.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QB47W5lLwDpKOSha1lhoCj4wnKRxRfDFRYDA4XzU8TwZg70qpPu1qXgR9lZuwjSKHbmrJprzGRge8YCsgLhM1KR0LlSNdg7YEVlDFlOQsGNCOaSrDnFI/NyTq+FWXtqQYH+j1dOqkjisLH1Yo5zifG9VZ8PcJ3YNpQR4785LWPDVA+bP7u+e35m5r0qf689yYWhvyJwJ2wQppUnZNrYcGJDY+rg4hp+aXpe7CVnnTFg9ncSlcQUx4gdhfNBrEAGcclXeucoY34+SSaITR1UMjX36gNPjUpBdkfGzYmggHqrSzi5N1nOo1Qrvy3mgUYP3vy2h//K6Lh0Z6hPVOHNoLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37CS+mIDQfL06j1QvVP3AC2sA04PpVCXgVs/EoL/36Q=;
 b=qbtWee8QIFpdzZZYCbtbKjAPXmzO040cOvXiKvPc8VNsUBenZIK8fmvNSWfWnDjPo97bmMVl5u465gC2oEpYVhGCb4Z3SN0NRFn9jVDfQSkRzbv/L/wMtONHStS+qykkBlaZxuYdsgvanSytOgdwpAqW8Ccm5iIbKJ2ZRq/T7QJe/XKyZ0I/Q7J40GanWYYmJ6a5IkVqh7zmq0QCp6zDCFA1L4jmQ0NkQLmtRRgpsPD17SFeyqjCjW5Cr6PicLol3hr64e/KETuawESVcZvrItQD1Ge+b/Gn0W0IPQY5LZ+RbSp0kEe7/HeMjSz3XAuh823CJXLeX3cOSZV7Hn0BCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37CS+mIDQfL06j1QvVP3AC2sA04PpVCXgVs/EoL/36Q=;
 b=qNDtXNc5Oet2kfcwNhBSmUkQ229LG+dp92LGI9r7jp/TLP3O2xkafbBLNruta0J3lHJZD0xKeckmUZH3NdtzQOx+ppv6RNJygnDbXxROXnsrC2V0hFoPrhJeSpnsS1RjySZBtaMNY3S/TgI9psqOFqD/qSezHTV5lgG1v7oPaDfL3K9DuAixuYnf+uUqlttdndWpkS7fKj7XULuKdDr3H+F6p7nc4PQoAapidjSPxnBDF36ebZUhqJHcxvg7TamhJHPSZETzrNVdETkodzD0uXwL6V+XzEm1iqeVJyP1XvZ2lKQ2N9Gx5FWOW96QNFas20FjNesdPAwRu2EgOS/uEg==
Received: from CH0PR04CA0098.namprd04.prod.outlook.com (2603:10b6:610:75::13)
 by SN7PR12MB7155.namprd12.prod.outlook.com (2603:10b6:806:2a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 21:35:30 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::41) by CH0PR04CA0098.outlook.office365.com
 (2603:10b6:610:75::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Wed, 30 Oct 2024 21:35:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 21:35:29 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Oct
 2024 14:35:10 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 30 Oct 2024 14:35:09 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 30 Oct 2024 14:35:08 -0700
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
Subject: [PATCH v6 10/13] iommufd/selftest: Add refcount to mock_iommu_device
Date: Wed, 30 Oct 2024 14:34:36 -0700
Message-ID: <4229037558d2c8103ec09674bfa3fd748bf7ba0e.1730313237.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|SN7PR12MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: 229a4851-be51-4f70-08f0-08dcf92ac6d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+DSXRsJKO+rh2bqjqbDnmSXBGD/A9UOuAbW0gPtng5In4Z5LIxqryAvjPY4J?=
 =?us-ascii?Q?2fVYSkAwnYIVeovPfX0uq66BW8oyYCVP0/1TUFVncHTBxXC5/1gJeItA2EOe?=
 =?us-ascii?Q?zFI03BAdb9pgjxkz9Xq9GmX2z7KfF8B0Wrg2mQnZijlodTmLI17dqgOytjtJ?=
 =?us-ascii?Q?3l/V6i2MM+Q7iqLhPnhv2Ce9ESvFoqcmzdnyZpA5tSeNDjMyj2TdyCkJ+K+g?=
 =?us-ascii?Q?Yk10wNeKSMj/Fuo2q2xI/sopS4G9wrEMbDZRtaziOEkEKHDgDaQ9JVLRR50f?=
 =?us-ascii?Q?vwubjfjYNQdf2fgf0eXa3dd3ZBckucCVweRMX0OL6K+bCOTmc2tKAAIejeMK?=
 =?us-ascii?Q?uhHfRNhK6TY43TEIWisHYmdxwRVBLTec5enBHCPzJnqpOLTIbkWfCyZrXg0m?=
 =?us-ascii?Q?qghwmGNoWlACQvj4wbURbhgLuonA8OHeTkhG/R4F0JL80S3wHWycQfjD8Uon?=
 =?us-ascii?Q?sdeDVYm0URBTfUVwNVGb8ZHcqt0szg+4PcvILisXplDSkJ7MfnZdaBSZcexP?=
 =?us-ascii?Q?t+MW7J2ERt2lMVm9ASAkgwKXg8gkCJBOD9UHs/BqCzFya2X+DjzvK1mHi/Z+?=
 =?us-ascii?Q?Dw/I0iB7QHrJQ+pN4lt3XEghK4+wo873A3JeUWzJohNzyRyYDmCK0QmPWzgs?=
 =?us-ascii?Q?YpIBYT5Qc7cRwBY9hWW5rEIHJcVH99e9yKhwCSS4Ktf8lVSNDAnaW/O3+AmH?=
 =?us-ascii?Q?OQW7FGuXWhG3+iAQjD3oGoe/XL8Wsjxc8uKhbgX0X8VI8QqNR8Xb/5Zn1tTc?=
 =?us-ascii?Q?o9w/dWD2V9Jfu++sTpU3QfNuckYdOK+tBO1vMs9O7J6IyddOthak4EtAL0TG?=
 =?us-ascii?Q?+Rc5WW1yvyjSRnUzBpNo5yCQ+nkuMhX2flOKvcx653Hvtc8S4uxoJSiqyAZX?=
 =?us-ascii?Q?OwPIpLy2kX7lgxfZ0BKZ7NA2xjHkiwDmBm1PX7K0dqTA/7yEc9+lz/Gn0UZP?=
 =?us-ascii?Q?rmbNt7FwoM3XhOVEOti5690wmWOkChzxOQoKLb09RvFkWpA8mmk71EAwSsSb?=
 =?us-ascii?Q?IM/0+w9xpBDxqQ7J0oTJ2Td8b93uGIx6msc05SGsMOBCZBDLsCJlbuMmzu0N?=
 =?us-ascii?Q?WUvBs6y7P8ZJNri+7KT6waqxB8FK78cUrfp35TjmJDP+kU23TCk/eM1JhKv1?=
 =?us-ascii?Q?87RPoOXDRQjiJqquryqiuTSMqZzWi35/xjEI07Lh14a7fIGxbpbZxZTcagYA?=
 =?us-ascii?Q?Q9h5YSKqYzhD73p+msCpogIK4yM9y6Hvz5Kwr8kuB0at9psgL32auAhBv7bZ?=
 =?us-ascii?Q?Bqb5yKHH5VS8J+1GPo7tEHrtRX2HW6UWSgGK3uFLj8DMza/hCMD/rywEUBQE?=
 =?us-ascii?Q?zFv3rLDsN10Zykut5mdsrhd2D2n2R0Xn1fYA3wmrmsayO1TGnIa9XDd8Npcb?=
 =?us-ascii?Q?vAaLKp/7eARthNT9tzE6M0PUYWGoTMiqSbTZOSOg/2BtzRXcCA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 21:35:29.8270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 229a4851-be51-4f70-08f0-08dcf92ac6d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7155

For an iommu_dev that can unplug (so far only this selftest does so), the
viommu->iommu_dev pointer has no guarantee of its life cycle after it is
copied from the idev->dev->iommu->iommu_dev.

Track the user count of the iommu_dev. Postpone the exit routine using a
completion, if refcount is unbalanced. The refcount inc/dec will be added
in the following patch.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/selftest.c | 39 +++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 92d753985640..4f67a83f667a 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -533,14 +533,17 @@ static bool mock_domain_capable(struct device *dev, enum iommu_cap cap)
 
 static struct iopf_queue *mock_iommu_iopf_queue;
 
-static struct iommu_device mock_iommu_device = {
-};
+static struct mock_iommu_device {
+	struct iommu_device iommu_dev;
+	struct completion complete;
+	refcount_t users;
+} mock_iommu;
 
 static struct iommu_device *mock_probe_device(struct device *dev)
 {
 	if (dev->bus != &iommufd_mock_bus_type.bus)
 		return ERR_PTR(-ENODEV);
-	return &mock_iommu_device;
+	return &mock_iommu.iommu_dev;
 }
 
 static void mock_domain_page_response(struct device *dev, struct iopf_fault *evt,
@@ -1556,24 +1559,27 @@ int __init iommufd_test_init(void)
 	if (rc)
 		goto err_platform;
 
-	rc = iommu_device_sysfs_add(&mock_iommu_device,
+	rc = iommu_device_sysfs_add(&mock_iommu.iommu_dev,
 				    &selftest_iommu_dev->dev, NULL, "%s",
 				    dev_name(&selftest_iommu_dev->dev));
 	if (rc)
 		goto err_bus;
 
-	rc = iommu_device_register_bus(&mock_iommu_device, &mock_ops,
+	rc = iommu_device_register_bus(&mock_iommu.iommu_dev, &mock_ops,
 				  &iommufd_mock_bus_type.bus,
 				  &iommufd_mock_bus_type.nb);
 	if (rc)
 		goto err_sysfs;
 
+	refcount_set(&mock_iommu.users, 1);
+	init_completion(&mock_iommu.complete);
+
 	mock_iommu_iopf_queue = iopf_queue_alloc("mock-iopfq");
 
 	return 0;
 
 err_sysfs:
-	iommu_device_sysfs_remove(&mock_iommu_device);
+	iommu_device_sysfs_remove(&mock_iommu.iommu_dev);
 err_bus:
 	bus_unregister(&iommufd_mock_bus_type.bus);
 err_platform:
@@ -1583,6 +1589,22 @@ int __init iommufd_test_init(void)
 	return rc;
 }
 
+static void iommufd_test_wait_for_users(void)
+{
+	if (refcount_dec_and_test(&mock_iommu.users))
+		return;
+	/*
+	 * Time out waiting for iommu device user count to become 0.
+	 *
+	 * Note that this is just making an example here, since the selftest is
+	 * built into the iommufd module, i.e. it only unplugs the iommu device
+	 * when unloading the module. So, it is expected that this WARN_ON will
+	 * not trigger, as long as any iommufd FDs are open.
+	 */
+	WARN_ON(!wait_for_completion_timeout(&mock_iommu.complete,
+					     msecs_to_jiffies(10000)));
+}
+
 void iommufd_test_exit(void)
 {
 	if (mock_iommu_iopf_queue) {
@@ -1590,8 +1612,9 @@ void iommufd_test_exit(void)
 		mock_iommu_iopf_queue = NULL;
 	}
 
-	iommu_device_sysfs_remove(&mock_iommu_device);
-	iommu_device_unregister_bus(&mock_iommu_device,
+	iommufd_test_wait_for_users();
+	iommu_device_sysfs_remove(&mock_iommu.iommu_dev);
+	iommu_device_unregister_bus(&mock_iommu.iommu_dev,
 				    &iommufd_mock_bus_type.bus,
 				    &iommufd_mock_bus_type.nb);
 	bus_unregister(&iommufd_mock_bus_type.bus);
-- 
2.43.0


