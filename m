Return-Path: <linux-kselftest+bounces-16448-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF2996150D
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBBBA1F21591
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FCD1D6780;
	Tue, 27 Aug 2024 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mtLP0IVC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCC31D61A2;
	Tue, 27 Aug 2024 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778174; cv=fail; b=WIeK6vKUawzxMs/pvQvD8pcTcTldtk0FieWyXPYyFr8IRkarXkIiEH92LCuO8mdhOUV7d3O8eMDmTcCyBBXDT/vL2ud08SCxH881hODd5uzBVMIMiN3ubgqR3tOPswHxdhlEKMyNVcf+OaNRMdGmNXHDdivwhcToJc4Ecm2lzoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778174; c=relaxed/simple;
	bh=pqHWPlmyin6Vx80BAqJKEHjqMAjn5JuGd1IS6EwLj9s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pd/j+x7WpG/Lf5gZP9qQ32oAf+2u/gBTWq95w6HpoQGttSTbeI7vmcZJ9/BtJ6o5krNvLMFEJa5aPoV9s/lMN0WdfBaEWVRKD9yqR3aSsBye6832HoxInIK03emJQbjo+FkrvgJN8wpXS6LPRqqNWICrKZJbfhB9K0QLCjQeeno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mtLP0IVC; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=isqcK1v073uqW2Cg7/dVZ/lqHEEX3cSiiBdOB72xW4ZOp/SM9eBA6B+EtaiN3XFZUCKiIj589koPdxNutblBEhrR+5nqUIyJWxzKDYR75HWET3+QAOVaCLh59ffsJ+qrqRIBT+LHEypijV3QyzEqNCJrKeqnMvrSmF0bzfIJbXZXtthpgFnxjyyNfPPMv3UymvwrU10uAkLCX+P5uqwxeqKI4WloEw4BT7VEIwFzdvF+UIsU9Ahe+9HhOyisz9hgz94EKxfKpTQmntogjGJCRqDVuV/8fopwww9FAqlJ+w2C9mJznICNB70qcAOKExJpIzA7TdsdVxu8XaGCgfAD7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjHK0Mmz06BlScrMGlT/QFUlxKbZ8+hHetw9oZzo2R8=;
 b=JnMGPWtPStgUh6bAWFcsOCeXxkFYiF/4vVxZ5XIZYHH2FItW7uWd+d4UbM40VLxe5QyXvMEF0SoqTdpebUPMoDe+PMLAJDdnhl0yzLgMJz4etHx5CZrXGRjMYP5t37O9LnBvf+yhX1OuzVJyPiNgWkCB4vudyhKEDdg111R3rIj1hhLDMXe4mhMYSDZJGQOM3OqxUgb70CA5qKNm+TdaFBgIKZ+o4wVKd6508jPMflOVA1Hl1GFttVI33xmpilss6oEvR56NbBxgg3SGEZqzYhSeSFhky5je+k9wmUEsg6eqzAbnDqMkRmpmRZ5WCG8X2lxxmC8sxk1XsZIoggKl7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjHK0Mmz06BlScrMGlT/QFUlxKbZ8+hHetw9oZzo2R8=;
 b=mtLP0IVCJbxKV+h8jKTHo0+kYizW/a42eZmztDImQUNAyXUw/sJQZPMv87Uu4dlwgw24XtqwPEXM0xy9Og4A61nDjBQfagO6f8nNLKEhRrlPQ6BC+O27mFDUXi+CjPORU3mo/FMyqBbgyttqrXbEJrp/klzCgMXe4admb+T+HdQJKXawLp48hb+wBo/8kYE38ji9SD8SWqw6ixqZRkAywkRNHrGw1w2ZnXPTF7HldolvvLFmwAFPH/C99C5C6KyxmsO4Kkfk5HtkhCuKEDlSVWkcHv2Q6BwpUEa4EY+Z5594K5IsvYUrRw3WdcmSZZxaIVdRKz9zWes6cNmbxevDtw==
Received: from CH0PR03CA0417.namprd03.prod.outlook.com (2603:10b6:610:11b::6)
 by LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 17:02:49 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::5c) by CH0PR03CA0417.outlook.office365.com
 (2603:10b6:610:11b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26 via Frontend
 Transport; Tue, 27 Aug 2024 17:02:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 17:02:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:02:33 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:02:33 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 10:02:31 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: [PATCH v1 07/10] iommufd/selftest: Implement mock_viommu_set/unset_vdev_id
Date: Tue, 27 Aug 2024 10:02:09 -0700
Message-ID: <383bb9fabff0051bee9c0fbb5d32163f1e0cf87d.1724777091.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724777091.git.nicolinc@nvidia.com>
References: <cover.1724777091.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|LV3PR12MB9404:EE_
X-MS-Office365-Filtering-Correlation-Id: 8effce88-3043-48a3-1ed0-08dcc6ba1425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z0n1FM38GPuF25sZ722gtCjAOCnr3wacsyQfmBGpN7b5w1oXiQudOcx1Lxcc?=
 =?us-ascii?Q?/fON4pFDS4TM9WeMiKeMz42ZlK/EbxD6furI02oyWfVdACiDR1YE08o55l+2?=
 =?us-ascii?Q?PO4VPF+JdCByuMyMs0YAAH4ga276ZCPu6v1Rp5pd5ceDb0FjrovWqd9K9KU8?=
 =?us-ascii?Q?tbP33cl4b9nbSijY16WeLqeEXy2MDUq2dgfD1jTN5aFlea8DZ3ShdBrTu9lj?=
 =?us-ascii?Q?PsvatyeBsCXatGi6/WEpfhYerCALdUaDd1H2IMIMmlQtYL7wPn6pTKHEkeKq?=
 =?us-ascii?Q?hKL+9PpvmgjQPg5xGSrDsLuGWJsc6pmM/9Qmixp4V3nM+Ux9xy+aw1bmD9tB?=
 =?us-ascii?Q?gih3IlF2ihYZ0w/qoDIb4pTXKPd9/11/wi21DVu2us5TSNNRElWHSLIeLJbB?=
 =?us-ascii?Q?/osWarHi2J7L0jycxAkzywU8T/4PYfqCSiq4y5bKyWqjXA9lOLQ9HPUyHUSQ?=
 =?us-ascii?Q?gQy7eMGZIZCY+zyrDhmKbDPzPSE8S7t9wLEKssCZPavp8hgwgjHpiRK66/MC?=
 =?us-ascii?Q?ThqnuIZb5ofoA6+igesP/vSqp9FpBv6zcXcuoZi01yygIRahCvHwuTMUrRaR?=
 =?us-ascii?Q?d4I1iKRO8SWhlFAPidjJgEfdOB2IBePzHxBpvVTabzB18wkUaR4fEIwt9OFa?=
 =?us-ascii?Q?XDefTYSyYYdw4pq4LTJgGfUlOhsQBuv3KVVtFCbzuMmf5Kdq00wBvbWiivFf?=
 =?us-ascii?Q?KW7p/dfLYql0fk1DhcK+4hFsJgsU9A1dIbJiUTIby/Sy+7j6YY9Os8+6sh46?=
 =?us-ascii?Q?tAqXjN6xppti3gGFNSdQ2ajevUVTFNPxCgUrNqJ7FeeCctvGoB/cuxi3O1Jc?=
 =?us-ascii?Q?3uRz3X8yBOdZ+cAYa/C8MsBAL+XHoUbQ/4uE9XgxuvNqlRfDFjcrLEIKRUn3?=
 =?us-ascii?Q?S1/f2JP6UOgpKjr+iy7BbEAeU199n/gTY2LXpP9AlJ8cYBsnYfBEqMSeFJrl?=
 =?us-ascii?Q?lc6NUE5LOI/bDDOnLfOdKComB5PLWGhDAFblP9Q+mplRrIt4bRS6vLR3R60P?=
 =?us-ascii?Q?9TLF8v/VJil0/22vJ5EozWbGF1bUmYwA2xz3OYOCnqQPIgPYYAuzTbTmf8zp?=
 =?us-ascii?Q?5PFmeKkfO5S7bcb0mtvcKJPbuUH0gKiYs1PUEJv2Fa0y3/poCCN4Yo57Intz?=
 =?us-ascii?Q?vPX7xHSVLJHedek+eEQWP80u2qmy6yJo1T7l2bxoUC+33lWFNk+kt2CtQKRx?=
 =?us-ascii?Q?BRtT4Ok+lVloCIl2Hpzc0n5Y5+vkt0huvzazBHLvjfGV11mhLGQIl0rFhuhT?=
 =?us-ascii?Q?CIdFbXbIt4fdfRig+KV759eHUkrWwV8zU9aTTQ6LZ/gMDZd92RiSh/M0LoLr?=
 =?us-ascii?Q?ghczwXZBd0BIJlyOQEYfcAZcEbyVUiYJj5zk7oYBaCER+F3cwFDzL8GJpqBm?=
 =?us-ascii?Q?RvQKB4FrcZFThv05IQAvea3eJhn750+QgoWPiX3J93X73b4sL6/QkihkHLJf?=
 =?us-ascii?Q?Gk62eWfk4NuWsglCU9XX0CZwrnoM5Gtw?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:02:48.2242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8effce88-3043-48a3-1ed0-08dcc6ba1425
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9404

So that the driver can take the control of vdev_id's lifecycle. This will
be used by the VIRQ feature in the following patches.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/selftest.c | 36 ++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index f512874105ac..ea2861d34b4a 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -137,6 +137,8 @@ enum selftest_obj_type {
 
 struct mock_dev {
 	struct device dev;
+	struct mutex lock;
+	struct iommufd_vdev_id *vdev_id;
 	unsigned long flags;
 	int id;
 	u32 cache[MOCK_DEV_CACHE_NUM];
@@ -541,6 +543,36 @@ static int mock_dev_disable_feat(struct device *dev, enum iommu_dev_features fea
 	return 0;
 }
 
+static struct iommufd_vdev_id *
+mock_viommu_set_vdev_id(struct iommufd_viommu *viommu, struct device *dev,
+			u64 id)
+{
+	struct mock_dev *mdev = container_of(dev, struct mock_dev, dev);
+	struct iommufd_vdev_id *vdev_id;
+
+	vdev_id = kzalloc(sizeof(*vdev_id), GFP_KERNEL);
+	if (!vdev_id)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_lock(&mdev->lock);
+	mdev->vdev_id = vdev_id;
+	mutex_unlock(&mdev->lock);
+
+	return vdev_id;
+}
+
+static void mock_viommu_unset_vdev_id(struct iommufd_vdev_id *vdev_id)
+{
+	struct device *dev = iommufd_vdev_id_to_dev(vdev_id);
+	struct mock_dev *mdev = container_of(dev, struct mock_dev, dev);
+
+	mutex_lock(&mdev->lock);
+	mdev->vdev_id = NULL;
+	mutex_unlock(&mdev->lock);
+
+	/* IOMMUFD core frees the memory of vdev_id */
+}
+
 static int mock_viommu_cache_invalidate(struct iommufd_viommu *viommu,
 					struct iommu_user_data_array *array)
 {
@@ -636,6 +668,8 @@ static const struct iommu_ops mock_ops = {
 			.unmap_pages = mock_domain_unmap_pages,
 			.iova_to_phys = mock_domain_iova_to_phys,
 			.default_viommu_ops = &(struct iommufd_viommu_ops){
+				.set_vdev_id = mock_viommu_set_vdev_id,
+				.unset_vdev_id = mock_viommu_unset_vdev_id,
 				.cache_invalidate = mock_viommu_cache_invalidate,
 			},
 		},
@@ -757,6 +791,7 @@ static void mock_dev_release(struct device *dev)
 	struct mock_dev *mdev = container_of(dev, struct mock_dev, dev);
 
 	ida_free(&mock_dev_ida, mdev->id);
+	mutex_destroy(&mdev->lock);
 	kfree(mdev);
 }
 
@@ -773,6 +808,7 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 	if (!mdev)
 		return ERR_PTR(-ENOMEM);
 
+	mutex_init(&mdev->lock);
 	device_initialize(&mdev->dev);
 	mdev->flags = dev_flags;
 	mdev->dev.release = mock_dev_release;
-- 
2.43.0


