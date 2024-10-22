Return-Path: <linux-kselftest+bounces-20343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8046F9A94B4
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 02:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A18481C213F0
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 00:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AE813CFA5;
	Tue, 22 Oct 2024 00:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CUc+VHTh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB4B17993;
	Tue, 22 Oct 2024 00:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556436; cv=fail; b=gKVMBdBT2rmgCXlRv9u/p+jR5StCBZjgFP6FxF2AL+i0o4wkefLJvAlMlIllJJj4+MZX2IvzWLGaLDHnKB03XNuEMJ/twbHi7PKkZDTU+dIM011ssq40qxa+K1pJGzN8bClE5Y8BaLuv2M+Ox4Sx03fOmtqZE2xzMZJhTbyI2Jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556436; c=relaxed/simple;
	bh=6TCHv/bumDCJgyHu0k2K//unc0BlMbXWMuOAWeX4NqU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uzqugJeC0Kc7luUYDT/YBJml22Xv4SozK2kugN7llPZxquk4wH+Ir6wLSfAOn1tsnqmvHs2qCs/alG44fOY0J5HIBjDNaGLpNCHUJPAhgEe4HSZ8yRdq25sUmBikjKEcWcl9JNr96C6W6rE+dIrSDOnbHBQeZOE9etd4cYxH3J4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CUc+VHTh; arc=fail smtp.client-ip=40.107.220.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGplvtHd6lFSpoHwyK0CSIgDZLtVKSAkMqmo36OkWZrZURjTB21RBMPCiDLnkGFOCmvQZEa9y2+567DRQzrlsojJcUIkWpM7RR0SfNuM2TOshN29DB1FcafvRYV8TpCU8dSWfY9JLTwe39A1DiiajMr3C73WtawPv4FtXhwInQIP5l2FcF0QFuy1i0pUWpmRmYq7Ha6pF0jvIOA8BjnXrUcnXVCVySKfTyaBOTZgbVCaTux+RHfsE6GFJ3Ke8Xvv4jpVa3YuDNCk6YyZm11+dxATqfTzB9fkF6DwGyKuq1LsSxGbRqZilchoq5CLVP8fO4wKPjQS74FeDuMeKJx/3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/hOxjPXfh6nod+qLqLb4dDI2P5tGR5GF7bgkJhIi9U=;
 b=THDiVOHQv5F6g1UM1XYHu3bABe8qZDMr0D2PDG0YCglX1eSOqvG44xxrjzWBMZPWp/7O3NMslcJGK3LKp3xjEsoActR+3hH5eewe6+djC2ioxZF1UpVocHUiZJ5vRKCZOgWVFOvx3O7fqDnb0NESj+p2eMytYPT6QnGOuQjqSmfgdRSUNln8IohCyMeroFLF2raOfV8XseHBXGOaTGLW4rEFC41Cs9upj7sN1UNpH0d3fb3w/aSp846/8GHmGvcsI/xu1oFupB/UA8QET/LF/fdO2ukMYGERBAKfh5EWfN8bvsMrAWNOtX1PfAgIWREuDZfwcsawxBDp4N+xoJe82g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/hOxjPXfh6nod+qLqLb4dDI2P5tGR5GF7bgkJhIi9U=;
 b=CUc+VHThVT1Rmrb00kyWhfhqmTUxXSJ1206SKFCc/kVJLf6EAxZTpUxBLqke2DZOfZ0p25Cx0WY2OTDFLusoBY9yEpkJvGnDKRnShAjqx+rr5thMAAGcQ+a9OMQSgzZXiTgj0o6AJoS3lHikyeE14yI9AmDIc5/nVCbG7arj8AeulMr4ReUs4/2aEKh/LnjZMYD6lX5pK++rVu0n6Wt9LtLOj/KS7JhnByQkeAxzbI1qHsX/KWMV2FJ3E0SStP4QmOpuZLsblI2KVjgLFdJh3lqQcPExVJWVbbYw0YmL5J2H0DXJy0OXj8tbRNa+vCksjHfcPJ+/6hEebtRFaIdJiQ==
Received: from BN0PR08CA0029.namprd08.prod.outlook.com (2603:10b6:408:142::15)
 by PH7PR12MB8105.namprd12.prod.outlook.com (2603:10b6:510:2b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 00:20:28 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:408:142:cafe::20) by BN0PR08CA0029.outlook.office365.com
 (2603:10b6:408:142::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 00:20:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 00:20:28 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:10 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:10 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 17:20:08 -0700
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
Subject: [PATCH v4 07/11] iommufd/selftest: Add refcount to mock_iommu_device
Date: Mon, 21 Oct 2024 17:19:29 -0700
Message-ID: <3e03b60ba01ef48d1f10fc41caea0dd9649d19ab.1729553811.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|PH7PR12MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dba0f30-868a-48b6-186b-08dcf22f54f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i1UNals/xnbOJ5T/TTZRQieOv535bfmYSc0XV/JXh7hGyb0Kyb2a+omSgbkk?=
 =?us-ascii?Q?enj/oaLV24EMsPQ8jyYEZsGBjHx8+cP2jgUmqYruRXZl00bI8oEZJa9VLEPE?=
 =?us-ascii?Q?dgnTcIq0wlhIEPezqn83MqOV0Omy1UDc0LkZN0OM5YfR+8Yelj+qNmOEIh3s?=
 =?us-ascii?Q?87fb6OyjmqfUS/XIW4DXqB4MBpcqzJCbvhQ+EKaSzpwwQ01GV5FvnSSSVFkf?=
 =?us-ascii?Q?ra4GhF0D7T+qehUuYE70QSZXpTlazUzGeIBiXraNhwQ4Y0UHL+Lp/rPVerlu?=
 =?us-ascii?Q?ZYk45KKSAAn8YIeffK0ixLKCtXBlZcatsWhJlQfuPX8cpHZiGZs9r03nWxdh?=
 =?us-ascii?Q?ystMzCEsbMvusZKuoF0Nj7xS+izoHxrSrsLNpXp2PKRZiAqNuTOJONVZAPkl?=
 =?us-ascii?Q?Ewl6atHUvDNYJVfxxd81629mGBOqXg0XkcNpUnxpK5NlGEKlJU5SomFAOmOL?=
 =?us-ascii?Q?83BqZmvyxS6blVVIjOSx07uCA5l30njtv0tzGQdINqoeZHkVUoemH6Bg/NzC?=
 =?us-ascii?Q?Rva7uUFK3jsX945kwjmTSRK09+AaqdhlIJtWUardZ174JCqnZo5dBZ3XnfnF?=
 =?us-ascii?Q?QFBwV229xVh5YbthSFB86/g4QEMeQit+MzBKB2+HuEBurGsHamMNX/t0+C+1?=
 =?us-ascii?Q?BGKp0IBe6b8uemck2JVIxdfHNEPnGpedac2HssQZcpGCZCrjNnS33s3iCBs/?=
 =?us-ascii?Q?qiECITk131OVzVJVgV7w1wPKK5xY5cGyMy1iqAaULddS/TQDcz+/Zgmmzl/H?=
 =?us-ascii?Q?zmFkgRI+cNZTrbdP5FbgR+alxuJ8BKHC+nO1k3MdAjDnwdZxhbTRUXMLJzbb?=
 =?us-ascii?Q?0BQu2RU9/r7a2EM8irN87jK9lAGAArtt1bsQynhZLhm7wgmnEEimSECy7ieG?=
 =?us-ascii?Q?CtlUriTpFQIlUO3inDNsKuO+9PITZGEEAvpI5NS5znUO54ZKREebaTjEvafw?=
 =?us-ascii?Q?6WJoQulVsDg/ZfuHAf3g6gwH+07zOQLmj5WisCayGQYOTFBUyVm1nhuvljY9?=
 =?us-ascii?Q?CRLEe2Lle4khEdTYjueJx1CnnB7g1aLT3oC8/0k4oPywxoE3dxv/DqVC5AKB?=
 =?us-ascii?Q?4Dlt8ZntRjNERZgcdpjTu/RA3bwXNzRVoFiP0ZDhIdGk245Q5PCB8Y3zZFmt?=
 =?us-ascii?Q?HBOxWjqIs5GX5iK6TwQ7GMgUTRp+/3pWZnthGCYHISbJ4C4ZjnSoqlBKoXvV?=
 =?us-ascii?Q?Uziem3s1l//GCNhTMHMS8UPgD2zsYIdErBHSKkIaMhiB0J51ivpppyCmJuPI?=
 =?us-ascii?Q?EhfErAIcIstaqZkNcMb85zM3Eet8TZx+tsPiR2ojSHUlkmQItM5mkYBY7pvQ?=
 =?us-ascii?Q?eKpptEgFi5Sqdr18Lp+buR8MoSE+N3zbISdzj85Qqqi1YRi8p3cJHFixBHYJ?=
 =?us-ascii?Q?b9B3IpGdWVfGMhMK5VCCwQhEidm/gk1h2WMS5qAilRnM+TYNIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 00:20:28.0535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dba0f30-868a-48b6-186b-08dcf22f54f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8105

For an iommu_dev that can unplug (so far only this selftest does so), the
viommu->iommu_dev pointer has no guarantee of its life cycle after it is
copied from the idev->dev->iommu->iommu_dev.

Track the user count of the iommu_dev. Postpone the exit routine using a
completion, if refcount is unbalanced. The refcount inc/dec will be added
in the following patch.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/selftest.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 540437be168a..dbd2a78c1074 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -507,14 +507,17 @@ static bool mock_domain_capable(struct device *dev, enum iommu_cap cap)
 
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
@@ -1536,24 +1539,27 @@ int __init iommufd_test_init(void)
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
@@ -1563,6 +1569,15 @@ int __init iommufd_test_init(void)
 	return rc;
 }
 
+static void iommufd_test_wait_for_users(void)
+{
+	if (refcount_dec_and_test(&mock_iommu.users))
+		return;
+	/* Time out waiting for iommu device user count to become 0 */
+	WARN_ON(!wait_for_completion_timeout(&mock_iommu.complete,
+					     msecs_to_jiffies(10000)));
+}
+
 void iommufd_test_exit(void)
 {
 	if (mock_iommu_iopf_queue) {
@@ -1570,8 +1585,9 @@ void iommufd_test_exit(void)
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


