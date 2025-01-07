Return-Path: <linux-kselftest+bounces-24022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A96A047CD
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 18:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AEA73A048B
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 17:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB0F1F8689;
	Tue,  7 Jan 2025 17:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="frcCm7zA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E921F76D1;
	Tue,  7 Jan 2025 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269884; cv=fail; b=sTHaoxq5rTJsuUiqvv+vErxzd1C8zz9ED12MFcsjdKZcLTZ7LFwFYm/rP4s+ZATyRUhNr62uMErSEN+0c1agpQjDeEwZn9Reaw6ldjfMrgEyFi/e84365gib3ZJlagPpzJV8y/oILY3f+NPAQJHEyPdYm5/VQafwveZGHzFjjaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269884; c=relaxed/simple;
	bh=fM2f2PyzAGblshpPBG7IpOfxnbm6FtHhIpdaCtuLMpc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B7SbiMVqUajwCbZ32un4egKPiBDc/9m76bcx9iIyoL+jLBNONg3kkikkA7tyfbYVSJ0t+Gz6lOceaQgNpQsCu1KxTNuldYSZvs/w/P17qlR4Fs1SNUByHLcSILLIvVFG7h6hcm9C7Neq5toPt5/MDi9ddeUUGDY22gnkO07fsGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=frcCm7zA; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oInDzetp3+jfe9tf1/Yd591l5kIdEfK6glB+B1xs1JF89Jf3vhWfbAsksxXLx8Nv6fk8MWQ8MKFr4299piqBwfbROZJrD9Pc/1ryWb4sWnXuHAOHh5+4uMtrnm1Yb+4T7kPzq9F8eLdCd3dgsl0rQuGBzWie+bItA+h9VZLnwE78YEzJDNmPf1V0D1JzRATj6b8sO2lk9w9mAUDf+2Y4jbv7IBLMnApPhUwynGubRNbc4Kq1KDZY4z7BbvYeIOeZDa2iou7cjqOkRK7gsn5byfYlHb1hGTcPti3TrqsaDy2OVTQKYKkkqtW6MlYShKbhzTxT7ZMgO2z5GHmGGGTyIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rS8glOESCY7MtGcKcpxCCp7pQ7TodetWuu5N4pB4Knc=;
 b=lcjNQGITC8jyvSqOiwwSqwLfmrKk/nfiZMTmA4Z3mqdtSIDu0NfdTDr9IpAQUGWx1hDfNG9vryn1xyMJspwRH/c3BOkS6SbAB8QgkC89/7TwaUrO42bXANxYErlNKQr2ZKcvflAHiFw+cgMhUY2qO27nVrn8mIbSrjqoXDt9Gm5OFcZqH3PhXciXlwbi2cHek+jMa96xdR0v2lqC9yz27/6VLO5tkwXelwrPzAJN/STt5kifkB6fIsnLSmXp68PmnxrqKd3wwPU9Csr2r4cFZ3by8zwlCuSojxSn1/kYjGZZklD8mrDesVoWnStvXD69vyKgJAhmEyXR0+zaeBrLgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rS8glOESCY7MtGcKcpxCCp7pQ7TodetWuu5N4pB4Knc=;
 b=frcCm7zAA8l/QNv9tPqoUVBswJX6dq8tVFHTGudIe/r8WHPl8ybDFcpWI4ZZbcLRAse1FaZBWBLCQ9bNmh2edt7Mxe2sFfNtPanJPMD0qATYxcBpTTNSBQOoFUtoO1EKwt2y6ZIHfAumyxf9Ndm+Mb2zgcEGEPDEWjB6ZZ49QCXONx157k9tnedOK4HYhnT2SYvdfmkRwT9MCiekdgjGQTbHWPV4GzeGoMRN3s3WOXHg2cbhaVbDE9c4QUNdPY5Rd7Mjl6psENH5MzeTpnajet6pHMZ3Z1UyExEz5xYAd+jU0PViu2xCwk2lF6vq0CXUlI/7OoHCPdZcyLeb22ox+g==
Received: from BN9PR03CA0326.namprd03.prod.outlook.com (2603:10b6:408:112::31)
 by BN5PR12MB9485.namprd12.prod.outlook.com (2603:10b6:408:2a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 17:11:10 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:112:cafe::97) by BN9PR03CA0326.outlook.office365.com
 (2603:10b6:408:112::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 17:11:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.0 via Frontend Transport; Tue, 7 Jan 2025 17:11:10 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 09:10:50 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 09:10:50 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 7 Jan 2025 09:10:48 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: [PATCH v5 09/14] iommufd/selftest: Require vdev_id when attaching to a nested domain
Date: Tue, 7 Jan 2025 09:10:12 -0800
Message-ID: <a3e837096ec5a4a322abd61838091d0fef0e7841.1736237481.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736237481.git.nicolinc@nvidia.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|BN5PR12MB9485:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ea0dac0-75b3-4339-b523-08dd2f3e4849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tChq2wkNgue1G2talPEA29h7ELiPI8dnez6A3Wbz0jI902+K+7Zy054SQcPd?=
 =?us-ascii?Q?F61VmGTbZ/0EBMP0vJQPZPotuVZLg0Y1eLkxm5KhtMqao4x8Fp3Dqs6BWGoD?=
 =?us-ascii?Q?H+XXQBR8GQQg0q2z6w4WYvRUlYARCSKKp7u4SDOspI680eAKiHpyteP7ybbp?=
 =?us-ascii?Q?n2lC6pduXT0y0hzkAiteZd0jaJm2Y4o2Qr2R2jnHmaXl1WGsts4j8Sr9yD0o?=
 =?us-ascii?Q?12K8L5FL+6ww5naTiLxvmts5AblrjGy8ikLuEtx0tjciPaI6MewZoNLEb/uW?=
 =?us-ascii?Q?L1VKhSFiPKJzG7WPGjpG8gPWF6bAtueA7lVN8JyT9LwUJvK28h1TmC9hNWbY?=
 =?us-ascii?Q?KTZPCr1pSvI1hxExPkx/a/vAzVJno9fmZcdnz3o9dTV7N/pt5eJxGOoVB4r1?=
 =?us-ascii?Q?fD5W6COGLgGovfF1d3DHW1uOfG/h8MZ1n51/5cmEMqwHvhvWfgwrZDH1B6cV?=
 =?us-ascii?Q?cD49OiKsk8YEV0bFPCKOcxDbkMYiG4NznSOMjbV/LSgsHbohpiW7Dpl02GlG?=
 =?us-ascii?Q?ijiF1raTQiqT5HXuadc3S9E7WZ+cg+dghXNaV8xie+Vr0+KnAwSoQN7miP4t?=
 =?us-ascii?Q?FY9rfbOcSzcWgEHR30J+iqtfTHoGxK/l4pbPVRYPSwvHR0jfgPzVa48kz5MF?=
 =?us-ascii?Q?iRA4q++jqZ3f9PPgqFW13CUDDm55oiNhJDzUvKB1FUvwPTDVjR0x+v1m0b9J?=
 =?us-ascii?Q?TH4Aoj//BEqq2iRhOpdOXwpeQTPF6tYr41yqz3YvA8yRjUY0osfo6ym/mxvw?=
 =?us-ascii?Q?iNUKLhEPqo5oyKNS2E4mnL62OwBitSu7kgqGjH5kvAQw5NLuR8fADlRjWnLt?=
 =?us-ascii?Q?Ja/KJEYJI5F6WGM2ZV21AdlWC/HNVluMWi52FyvU78P81ZnntPVWJKRlTgCV?=
 =?us-ascii?Q?2kBsmWAYbvoKa5/l8zUPpG2ukC7Pmztkl1Jz/agKA2KKIkVF314ACXnjZZfW?=
 =?us-ascii?Q?DvMRKvohFnL3ahmz1A3veA+c+BnJ9H9SzT+3cjJbMhBZYZSffHMZlL3X9Hmy?=
 =?us-ascii?Q?jH1goZpBBlfe7LVvZttCfSHJis2McLrTHyBb0ts216DZdevB6Ew4vebeuM0z?=
 =?us-ascii?Q?yX2j6Gv3hCz7IXmH/zKxI4EgBAncMYcCg9wu2D/U+9/2FQzZFuT9MNkdi4nM?=
 =?us-ascii?Q?li+VoTUXLGaVD8j6hW5FcobTdsYgFY7LHLYGVEcCf+6P6cbfiA7tlKJms92G?=
 =?us-ascii?Q?TAZuK8uTx8GshVuHCjgLvPjMZzJkP4qqwS7ZQ/x0WHAsUGhPrWXeSh2vtVgp?=
 =?us-ascii?Q?zflXVyDuuLkSk8bfDj7zPX1NQHNLRtKRusL76e5k0xamV4DpNML4wxn9GwFQ?=
 =?us-ascii?Q?aoSYaY9r0nAhXSgj535YELWZyagPyotqDPUcSbgELhbTseWD6uK50kNp9TDh?=
 =?us-ascii?Q?JBARZlo4qG26SfZPbbi66x6vrF0Eh17ztPzyOvyebKnXTVpWKoBh+catigjj?=
 =?us-ascii?Q?lPoLrCEraSwiTb0G5f1b1C/QGndXlu3GPfEQSWrFsomnwMuu22OZhiHNdv/x?=
 =?us-ascii?Q?DuaRjgT2etHgZ3A=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 17:11:10.1558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea0dac0-75b3-4339-b523-08dd2f3e4849
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9485

When attaching a device to a vIOMMU-based nested domain, vdev_id must be
present. Add a piece of code hard-requesting it, preparing for a vEVENTQ
support in the following patch. Then, update the TEST_F.

A HWPT-based nested domain will return a NULL new_viommu, thus no such a
vDEVICE requirement.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/selftest.c        | 23 +++++++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c |  5 +++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index a0de6d6d4e68..d1438d81e664 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -161,7 +161,10 @@ enum selftest_obj_type {
 
 struct mock_dev {
 	struct device dev;
+	struct mock_viommu *viommu;
+	struct rw_semaphore viommu_rwsem;
 	unsigned long flags;
+	unsigned long vdev_id;
 	int id;
 	u32 cache[MOCK_DEV_CACHE_NUM];
 };
@@ -193,10 +196,29 @@ static int mock_domain_nop_attach(struct iommu_domain *domain,
 				  struct device *dev)
 {
 	struct mock_dev *mdev = to_mock_dev(dev);
+	struct mock_viommu *new_viommu = NULL;
+	unsigned long vdev_id = 0;
 
 	if (domain->dirty_ops && (mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY))
 		return -EINVAL;
 
+	iommu_group_mutex_assert(dev);
+	if (domain->type == IOMMU_DOMAIN_NESTED) {
+		new_viommu = to_mock_nested(domain)->mock_viommu;
+		if (new_viommu) {
+			vdev_id = iommufd_viommu_get_vdev_id(&new_viommu->core,
+							     dev);
+			if (!vdev_id)
+				return -ENOENT;
+		}
+	}
+	if (new_viommu != mdev->viommu) {
+		down_write(&mdev->viommu_rwsem);
+		mdev->viommu = new_viommu;
+		mdev->vdev_id = vdev_id;
+		up_write(&mdev->viommu_rwsem);
+	}
+
 	return 0;
 }
 
@@ -861,6 +883,7 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 	if (!mdev)
 		return ERR_PTR(-ENOMEM);
 
+	init_rwsem(&mdev->viommu_rwsem);
 	device_initialize(&mdev->dev);
 	mdev->flags = dev_flags;
 	mdev->dev.release = mock_dev_release;
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index a1b2b657999d..212e5d62e13d 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2736,6 +2736,7 @@ TEST_F(iommufd_viommu, viommu_alloc_nested_iopf)
 	uint32_t iopf_hwpt_id;
 	uint32_t fault_id;
 	uint32_t fault_fd;
+	uint32_t vdev_id;
 
 	if (self->device_id) {
 		test_ioctl_fault_alloc(&fault_id, &fault_fd);
@@ -2752,6 +2753,10 @@ TEST_F(iommufd_viommu, viommu_alloc_nested_iopf)
 			&iopf_hwpt_id, IOMMU_HWPT_DATA_SELFTEST, &data,
 			sizeof(data));
 
+		/* Must allocate vdevice before attaching to a nested hwpt */
+		test_err_mock_domain_replace(ENOENT, self->stdev_id,
+					     iopf_hwpt_id);
+		test_cmd_vdevice_alloc(viommu_id, dev_id, 0x99, &vdev_id);
 		test_cmd_mock_domain_replace(self->stdev_id, iopf_hwpt_id);
 		EXPECT_ERRNO(EBUSY,
 			     _test_ioctl_destroy(self->fd, iopf_hwpt_id));
-- 
2.43.0


