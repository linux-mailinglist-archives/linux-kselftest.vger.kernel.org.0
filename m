Return-Path: <linux-kselftest+bounces-19369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3811D9971F0
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 18:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 097171C2359D
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 16:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5301E131F;
	Wed,  9 Oct 2024 16:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RKAURvSj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5FF1E049A;
	Wed,  9 Oct 2024 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491950; cv=fail; b=fjgQPj5XnEnkRV87RMOtGl8GivVaYuUUXt31+1meoDrxclCLzLcOfWItwlZYrNf+OzL2q2O5Al2VFvdFrk14pOrt/xZqiL4/bOY5ujxCJ84KpF1hXI2MCYrjmY++6JFEgSGt28SyMGaCt9G47tAaO0bxGBspiZfXJENDfEMZ2dY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491950; c=relaxed/simple;
	bh=x+92imxMgbu+/RFm7FCHE9IzmvRFdF5thPf9KebusaU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EKLiOrIVn0iH6CyTLrTNXPAXnQQ9cygTJqQzHtmOi7vwX1m5QMqOFfaI5bdrQu5UNaLEsOI0sXyoWhhEnvQhx+tLsh+OIyi4SnNqYGdDn4G6WJVT9e9Ha/aKZIRrIX/+ZjsDNCLBA/4Ubbt/9T8iVP3MB0nkdxIyQ/aBvyAc4UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RKAURvSj; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AydIAkLIupGdhcIoO2zFrLuiOYXYGyDhM8xhTpcepDdJ0Y4a37dX05qzY8QZKCfex5O4Osz+M6d+QNGzZ9H9nhncSOulY/Jg4ykbFmhs9HO2fRhDzCss30OsryaqC5ooml0fKk6HJ4cn9Nk8ZN+xBnZzyfhDHlD75nu2t93a1ODfdUxUlqvYjqbnd1LCLIp/gb0nvDnWilfjX4wcdKSvdaihi0DaX8PqfCuqmRJ3PhUvqXpBwSmG4MlTZxJf8VhKKlBVO6TZ6NlWixfKh3iUGw09j6EO/Lod/D05UTZcY87wqQYQut24HxqOXKN27PxVHbzblnt3sKQeeuUtLv46/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJPXnw1z3/nAaP9wIoDOg+vj1ThKk1M63vI6aqkurSE=;
 b=DtKwF+ffg+CijHHxtV9dVBTR/Jzlsi3sBDJt/Yw5Mwz9XX/1k+hBEgCDlJIGejVM0Tv7jNfMMPOKM5W4yuQ2vlNmPVBl/QOOiB0DOTA4p2WzYFAN3ef6DUfUqMN00699uXcxFRVyKRpv02yHMcmJkcsMJuBx/Xpr0L0CGf/G5T+Z14DHBJa0rVso5j/KBQv7p2YimrK59vL42OmO3odkHpHUD2H7QTPAmFk2IuOsRJ5vMz8xwohZcKVCsq9FPJtiOIIOwUTu2r5lUCZ2+riY6H9JkhXSap+WJDXJR9ScJm/Awf4hFks/gHumYj+2i8sXXXSavKUVtqdpKfoIsfZpxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJPXnw1z3/nAaP9wIoDOg+vj1ThKk1M63vI6aqkurSE=;
 b=RKAURvSjwBjcA9iibW6GmR6c3gIUPDnLy4quoO9DgNrvlasrLbcCzUE2VelZZJp4qe90P4RnH+jmamLDRK/DhkqZjbYgJjU8ScTO/UirCST6VaSJvWHJ5XeMj7QbnVlIqC7So9xAX9Pg0ArTipMTHq26u945nAipRazGtU9fwG+joTAIuos1TpP5J9DWXVUQ0C5tCsdEm8a3LiJCXmUBqnFrBOaT8bkFHhsiwU/Puz4nVy6xz8O6qFIBPGlb1ItBwXuBc7m9pFXI8TYFiJFj3WaWTetr1LNNX+qXtAcdZnVlZDV4Ew4QGSxnIUhJga2vqi9FzYvpEzdL1aAxSpTmDg==
Received: from CH5P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::13)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 16:38:58 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::8d) by CH5P223CA0017.outlook.office365.com
 (2603:10b6:610:1f3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18 via Frontend
 Transport; Wed, 9 Oct 2024 16:38:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 16:38:57 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 09:38:49 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 9 Oct 2024 09:38:49 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 9 Oct 2024 09:38:48 -0700
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
Subject: [PATCH v3 07/11] iommufd/selftest: Add refcount to mock_iommu_device
Date: Wed, 9 Oct 2024 09:38:07 -0700
Message-ID: <1d34e8eb85efbe7e4e47d0297b6eabfc147e5336.1728491453.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728491453.git.nicolinc@nvidia.com>
References: <cover.1728491453.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|SN7PR12MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: 62dc2214-72e0-4be8-2e14-08dce880df4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qJ7Lh5Ku/R4R0bs45B4Sel6UknkC2t7VCUvnqj4nBjhJZBLjw0jaHdEo03ZM?=
 =?us-ascii?Q?XLbxvyfiAlGNqqzjKpPnHJAPSTunhgzDdaNs+qCvOTdGhdeFUN6319VU4Djb?=
 =?us-ascii?Q?ISOBM3F2zCr4wfGAIi1nCFEFRdBqp65E+UvbvQm59CHPZio2/l+IZRSilftf?=
 =?us-ascii?Q?S3/2IVLFp+I/wZ8spHg+F6eic+/r/syd5PbIAo8O9rbrj/H0Is+4QaJTumXi?=
 =?us-ascii?Q?si0leqx4JMti6t1fdFptscMJXwCZDKxMxPwVwFT3U4Fo5bjtCcxYHxLwHIiP?=
 =?us-ascii?Q?YDVGYeTO9pirPjZoXmmR/BqcAEMkeRLyRt7PvaqFRXTGk0NL+RzmtmMfIi2b?=
 =?us-ascii?Q?kwrcGT+7/3ad5qGQ42Qz5rBUfvpPkBLPl2ooGbj0EYSMQW6hjo8JktSH+Lu/?=
 =?us-ascii?Q?Xzq9SIYGiF7wgi+y8Opfmm3jicXXIw9GWPHoROqjSOx6/YromXVhX26W9dg9?=
 =?us-ascii?Q?x7fMEYe1NcKeYrshP9pAJbh4hMRGdAxgottd9RXSwDhkeuaQs0fBpNzXUbcq?=
 =?us-ascii?Q?rvY7/7clKVWDlPjYPvr4eaAwCjsPWvl12P4Dt4SudF8GVf2vCkhaQW7P+0l7?=
 =?us-ascii?Q?hcjLelEJbcojiFDlgUkvrDEIZ6jh2hhaYtXnVAwUMjw4i/UpUX3ywlqJJ67s?=
 =?us-ascii?Q?BAgwTsue80k6Nwq40wn6kmTJXmeFmUFOR0zXBbXOUI9Ys/cDVXcJdmKygsCg?=
 =?us-ascii?Q?X/gldpzqD+omml/MzFCcAr4n8huy6STX+F7yH4mFvkBXVR7gmtPJlGYs7jlj?=
 =?us-ascii?Q?BjWzsUISmBsORGS+1sNGRY5ZFET4UOnpyCDo2MI9jn7TE3XFdw7fEhfZtNEz?=
 =?us-ascii?Q?VJ1pb7xCxZLWSIdj393LE8yWsJAQviYodzLNt7HWQPJ0A+TryuwLf++DmMu8?=
 =?us-ascii?Q?8JmuNprJGfFggON2MRIhcGWdBSoQlaRNf/1/FrgYpJfB70hcqw0A68vs5mop?=
 =?us-ascii?Q?zm/Ogz95AMe+xmfLJz69a3t9SPMUCr+OHETknizwn6HJAFg5/mQShtZbUX8i?=
 =?us-ascii?Q?qrUUeiBA2BJeQ6rz/XtBr0aI7b9Ez0ZCjQAf1AaqHKF2EXyvvNv9r27Gfgbd?=
 =?us-ascii?Q?5de35FfB54eViVcLSxgQ3jvSBoRIBPtLjTytWdjeC6nzRdl6TEgdG7enpKAt?=
 =?us-ascii?Q?oBnUNDtEFf4h2Q1ZF/EePUHGxIGBjT3Z4F3LUVrFV4h0582YNKABG7FzHDbr?=
 =?us-ascii?Q?5M6cXVfpWhAFEpGTNolnLTbosD2LPndImtGXN5CaLyCTp8/ETetzbRl4Eoi4?=
 =?us-ascii?Q?zOw+KNrY75Nh/04qOUI8IUozuikPhFQX4uKtc1HabnyJuHyZ1R2A/hcvGbQ4?=
 =?us-ascii?Q?Br5w7SUwz66hnHtWuzQqzu7aINey9Xyci3eb5GX/YKzwQ5vHVkj/CbFSUvE4?=
 =?us-ascii?Q?mDUQUN8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:38:57.8418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62dc2214-72e0-4be8-2e14-08dce880df4e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201

For an iommu_dev that can unplug (so far only this selftest does so), the
viommu->iommu_dev pointer has no guarantee of its life cycle after it is
copied from the idev->dev->iommu->iommu_dev.

Track the user count of the iommu_dev. Delay the exit routine if refcount
is unbalanced. The refcount inc/dec will be added in the following patch.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/selftest.c | 33 ++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index f4be87b49447..a89a865617db 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -508,14 +508,17 @@ static bool mock_domain_capable(struct device *dev, enum iommu_cap cap)
 
 static struct iopf_queue *mock_iommu_iopf_queue;
 
-static struct iommu_device mock_iommu_device = {
-};
+static struct mock_iommu_device {
+	struct iommu_device iommu_dev;
+	wait_queue_head_t wait;
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
@@ -1537,24 +1540,27 @@ int __init iommufd_test_init(void)
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
+	init_waitqueue_head(&mock_iommu.wait);
+
 	mock_iommu_iopf_queue = iopf_queue_alloc("mock-iopfq");
 
 	return 0;
 
 err_sysfs:
-	iommu_device_sysfs_remove(&mock_iommu_device);
+	iommu_device_sysfs_remove(&mock_iommu.iommu_dev);
 err_bus:
 	bus_unregister(&iommufd_mock_bus_type.bus);
 err_platform:
@@ -1564,6 +1570,16 @@ int __init iommufd_test_init(void)
 	return rc;
 }
 
+static void iommufd_test_wait_for_users(void)
+{
+	if (refcount_dec_and_test(&mock_iommu.users))
+		return;
+	/* Time out waiting for iommu device user count to become 0 */
+	WARN_ON(!wait_event_timeout(mock_iommu.wait,
+				    refcount_read(&mock_iommu.users) == 0,
+				    msecs_to_jiffies(10000)));
+}
+
 void iommufd_test_exit(void)
 {
 	if (mock_iommu_iopf_queue) {
@@ -1571,8 +1587,9 @@ void iommufd_test_exit(void)
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


