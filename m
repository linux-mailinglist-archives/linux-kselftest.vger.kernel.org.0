Return-Path: <linux-kselftest+bounces-21478-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E5A9BD692
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 21:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86CBE1C228A4
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 20:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F944215C5B;
	Tue,  5 Nov 2024 20:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LqH2aDV2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6B8216A01;
	Tue,  5 Nov 2024 20:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837115; cv=fail; b=WAniLyErFXNtynC1uoQxjkH5hYwbqbkxEYV3cJ4kINB9r8Yw51B9nS40Phnb8uULlgwjdPCL09OGU0COTxVMCFkzwaKi5uM1AqibRZcZTvXyTkmVIW/Zev5wUT19fVYu7grXmIPoH057GyqkjAwQm+sbdLqaYSJ53inaJIf2lL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837115; c=relaxed/simple;
	bh=+iScv+JPH5qZd8WJf8hN+2Zy1gN2CgRyr1NqLkHDIe8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ul5D7Z+/Dj52HLNsX95QOLcPrEtlKSZKcE/KTyWySMdFUfGoOfPWGU8vXNTH/SIOxC8sq35+Lu2hMOY79HxQbpaRlG5ZBzml0zlZwTKMzxU2kGuXX5tLBYjgtEsS3/1Q7F+rqCyo6+wtR1TSRR6x177nEspYN+HYdYy2Ncpe14Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LqH2aDV2; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPWSTfC95OyAbRplIccjFNBa9zIk8369g4K2lwwKZNtx9rpa2k4ZUo2ALYx7XANFkwhCP5/L/nY6K4AQ8Ub9kbq6sYpGdlz9MZB1u1qK31jEfRGi1T1o5bgu+TQwIGApy1P/DTHZ28wVk6WwX9pr1BmXDsV3SGUKafyX8PcsUP4TXdQvv6qlae1tAj5Pa7Rcfwj76grhkrvxUSC70zSIhgGr7yq9mNKIgPW4Bn0EK6Eu0fDDljN4qWSn1uRg25+7U1G/M/mYl6Y8KcAP8DJ63LGGOzRfWB1/CR84eZapu0cydd64cJtAvnI0jRqwJHr83v5UajxeoIhRmgfdFLobXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37CS+mIDQfL06j1QvVP3AC2sA04PpVCXgVs/EoL/36Q=;
 b=vF1JtEcUbihGtJWA/Cd7F5RECL//wQEpz4Zuc5t5eEWCwkDofTW+41q0bXkTG/g39TC28kJkNO74nKEa9yZ4XwIy40Q5bCxJ/YnnRLyx+GR5Xz0M08NNhDE+9belA1PmpoWOdxxIdFik/lEdQfKQKIiEtVHTGX3re3JK5b1g6XE2AVl/rUGE/9ptXVc7aQc77qqhNBIRPU5WyBHI8Vywi5DaUO1dcQVy/yR5zdIw7NJ6nLerrAcnG8MIjSKQNzpJghXdNPfPV7gIkdS/1nkvSN43fovypXM16Yz4TJt3JbAKlEgHdb/OiCzdZVo33NrDopDxR9uO4h7P3A7warY2aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37CS+mIDQfL06j1QvVP3AC2sA04PpVCXgVs/EoL/36Q=;
 b=LqH2aDV2+1dtGtAcIhgbiHVT4gamj4o52sTbdV/WN5m2vGP4AbuC9xpw8EGjnuBngBHUrVSrXziwCsyfU4HbxHAH4l+piEqpATjiCzLmtmUyDK5Og7noJnwjJGAaKrN33dgaad0LBwLGj3a9fpRdhObJZKSNeveWJwUzC6xVtd433ybcBDJ69XMtDEaNQz0UIcVrAfSBPe0nL5Aymzms+wFL78GRhINzZutfphGFVdjVFeeLdl7qedpjXd11SuxVNZ9Oosbb5jUWK3Q5q7IAGQjxCbwieRyBfiZZx3J0rGy8A5zt3miSZWvcemlneVhnPvItT3adad3M1DTc3ZSyTA==
Received: from BLAPR05CA0011.namprd05.prod.outlook.com (2603:10b6:208:36e::26)
 by SN7PR12MB7131.namprd12.prod.outlook.com (2603:10b6:806:2a3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 20:05:09 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::fa) by BLAPR05CA0011.outlook.office365.com
 (2603:10b6:208:36e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.17 via Frontend
 Transport; Tue, 5 Nov 2024 20:05:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:05:08 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:04:56 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:04:55 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 5 Nov 2024 12:04:54 -0800
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
Subject: [PATCH v7 10/13] iommufd/selftest: Add refcount to mock_iommu_device
Date: Tue, 5 Nov 2024 12:04:26 -0800
Message-ID: <33f28d64841b497eebef11b49a571e03103c5d24.1730836219.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|SN7PR12MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e6871cf-2b42-4526-c1fd-08dcfdd52611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oHHduxOXQEZCCnq/QGGJFnoVKOssNKkw+bwX7eLcciDDg3hRR8gjdjJJZYND?=
 =?us-ascii?Q?gYpNjY8pWO9K6kb0nAi1ZpzPBX7PBBpKUrjryW8MtmexuGTjy1INFTHo0AtI?=
 =?us-ascii?Q?wOBcxQP5u3QYBVXWM3Ec4ycuCgXKhgrc+WliT1AgFLSSvkFb6Hd0ipYb9gYW?=
 =?us-ascii?Q?7asEjID/NTBtwsf5TCHDCUG6FR7EQtDT/wEPeLE0kcC/cMvVwC2h9gL9TosP?=
 =?us-ascii?Q?4ls8e1aD2GUDad9E+v3nnQ63sNTKAGjqfyH0TcEH3K/oEuTWWYx2gYgJl2vy?=
 =?us-ascii?Q?tOwO4G7MBSiAjVWeuQ2dSLnO6Y2sZsYCNaQwnZ5fJcAbIKCYdkuEl32iNTK7?=
 =?us-ascii?Q?yO4aSTY5h8W00XgDeSjiDovYeecQv0rQzZMPCveP8rFAJh6lt4sfouri5HbG?=
 =?us-ascii?Q?GkWVFNj7Uv2cIPIcaHpbe3mOctpqQ9vZhZLw1udstLy9nYvgGpbzt19JX80o?=
 =?us-ascii?Q?lxIX7cseD8TuRRjg75H1X4cCG5l0UJMHX+n+B76I+1kQbj3CT05wQk7nOq/M?=
 =?us-ascii?Q?7grsbw6/7NLDv5rk7GLCnOhixIA2zhTFpq1VpTk3W8sai3VPA4gvMi6wxuuY?=
 =?us-ascii?Q?NjqrpWKiAbTlci0DY3bUu/wbVayo1H4GkBtixy9t0xfQdZLyQ67Tblh7RP8V?=
 =?us-ascii?Q?PsdJZ9D30JAGehoLKSOwACiS28qBVLz35T9EM0GVIdJDHwnAkFcpXMNK0LsT?=
 =?us-ascii?Q?SHlSphqF2nx+o07wlG+YcN67uGkNhBYsuBuRCdtUQLJHYPuHPffS9LGFGwMg?=
 =?us-ascii?Q?k1bFrpWte0gTfhuv79D4YOBQGuMUQdojw6Ljtp/SefN9N6XUGQwYjtKHVABe?=
 =?us-ascii?Q?5NqJf9roHewxANZtYpYNHZ4snD4IAmstcWOMiLT4e/5RkaUBKmf4ueMk4dK/?=
 =?us-ascii?Q?UWl+VukjgSy2aQd3saKrPHnfljpzOncfAZsffEYDj33zbDPTD2VfnDTxK7/c?=
 =?us-ascii?Q?shouEadGJRS8414UPbnybqyCVk2aDJgSeId+TTzLsDwzapilD8ERjvE+YNeA?=
 =?us-ascii?Q?THnQYbYKZCy6vPZkGmIkJ8nGLqHFEVxHZrKJycEy9vO5YvjDUM6n7vHy7/Rc?=
 =?us-ascii?Q?rgnTZab2HCfHfJuXSZc+fZVWBoDjoDUaKV5uBE6pvUZcyf7Hwnqr9BMT23TH?=
 =?us-ascii?Q?UMZfTuRNjqEwPh5dv95WfoLHXKbrg3QPKw8SsJsfoTBBCPUgbrGmWZVBUaP7?=
 =?us-ascii?Q?M1b4pqSRhJndn76YOFF/RB95lovCbAYwCvYFyeivU0tG+EpNSgfmO1Ngvrmv?=
 =?us-ascii?Q?BPvVaU+nqoqEm9y0UEttDOBU+IiCmC3rqICDggKCT0y2yb1cWMJvpyeKRsiB?=
 =?us-ascii?Q?zCjdwfGvhsevM1P3n26vQ1LU9jqVxLAHRQRF3WDEkEdqDHwJWQmudlC5FNFX?=
 =?us-ascii?Q?9UkEferh8LKqLw2m0EzwP1OdGi4J0Z2gNyhGtUvNWvkDyJboMA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:05:08.6295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6871cf-2b42-4526-c1fd-08dcfdd52611
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7131

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


