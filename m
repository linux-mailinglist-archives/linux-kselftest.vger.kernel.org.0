Return-Path: <linux-kselftest+bounces-23891-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 445B9A00E88
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 20:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1470E16495F
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 19:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD3B1BEF9C;
	Fri,  3 Jan 2025 19:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V9HU8vnt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2BA1BEF65;
	Fri,  3 Jan 2025 19:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735933484; cv=fail; b=RHuFwZa9Ww5Z5F/ZBC3zbcqQsp8WLkGYpjE75414IVSeQdWM+TsevyOb7jePF6taQYhrirgKB2jrIUF5WyemH6A4VSnUj9SyUr482J9w5BaCL8DEeYkI9t/nsfJmP9FIcbkKs+1Rys7a0HkJKklTPwscbHhhQLDN0LHFXKsjLCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735933484; c=relaxed/simple;
	bh=fM2f2PyzAGblshpPBG7IpOfxnbm6FtHhIpdaCtuLMpc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e09Y8lj46Ag03YG53oai/aO9G6JxRNsdCP93RD0BT7SPR1EI4UmkALW6Pp8I+Brih714wJrEwJrtYVKXnqek/7BJwW2+w9vt6vdduqkBEGQOqT49abxztJ4dIYQoGg0Bjq3umWNv+Wyohq7bJIKGvdoACDn39Eat7j4ctWRvlVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V9HU8vnt; arc=fail smtp.client-ip=40.107.100.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgxfb+wi3wPFZz+/t1XECGDcOanw7XXqMADAP/AjSZ2r5bBVvAQcxJ/2OayBNAoDiukyu+46woWLWX5HZ8pOrCfiKTWbjNcKBxtijb/WA/g/2qodcP6eMqPkhy1/RUMgLBW3jpjHA/aAtb2e4s5uQOx/zhdD5Sp4s3yXAJd/cWI+OeCK/USfYqALee7dxk82OFAziKqgM5f4ClqBGSvQhhks4WQd08SKwaDVs+3DHf/xMn2WdE5aS0FxRUGZKSfR/Kkcikr48hdVdNbqMMMZG5ZJnPgFGiasACjTR8sIqnxg28I3CF934dObFVb/0sm7LeK+cyix/pI4F6U1T85ICA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rS8glOESCY7MtGcKcpxCCp7pQ7TodetWuu5N4pB4Knc=;
 b=HOAcETORGSL3jFVRdkSFuArQaB7AJVauAdjvWCjmrdxWLj2ukMIvKP1iOiUMMX0rx2jlWEdMOhYmkNdR0PcJoqf+eYlW6JxYUCZPJnC6DnRrP+KjafWbwJ1R4Y4ZWs81nX1/uPOoyXJxIr/BnVHHWyN9V9qej5oLoL8pVclTM9Dl5IJzhrNGHEazZ5vsBWApZoGqK+lOoI9dwJwZQMvfPksJJB5NOjB0vnQlh7KG0wOmyng9WFmRkYuKXxCdE3ar//CKiXLB2OWxyt1lriUB9cUJwDGFYmDojAoG1hkvbZiPUe+xrRh6gvvcr4qzs/09eqrqWS2MqjzRVxkRDX8yzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rS8glOESCY7MtGcKcpxCCp7pQ7TodetWuu5N4pB4Knc=;
 b=V9HU8vnt1ZrGUuq5PPE0/9FAxMXktTlvjgFlDHPWZscaoN5a3lRQN1jz77jQDz69a5nALKUqMchhTFO1N8FzzcK0T6dnfUZO+yyhikWopcrS6jZOEuqLC8cu7YdvOfkMHQj6DLqtSzdCmyN2cT2yCACBJfpWS6QzXaBRACzy9KWsaUHEVET/3aG5xtfe4qS5spGQJeA6V/2C6n3Cz9efd8/H9uvVODARuSo5imlAoHj7RKK21G3FBjVT9FS+Fr2cFnvhEvcWFXY8r3MOIOqYmAl6UM+cxAyyirqUB7spp0ym+Pe0B6GR9yWHhHz4slXi9/hdGQfz5XDOluUBTgZ4gA==
Received: from CH0P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::21)
 by DM4PR12MB7743.namprd12.prod.outlook.com (2603:10b6:8:101::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.11; Fri, 3 Jan
 2025 19:44:32 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::b8) by CH0P221CA0020.outlook.office365.com
 (2603:10b6:610:11c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.15 via Frontend Transport; Fri,
 3 Jan 2025 19:44:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Fri, 3 Jan 2025 19:44:32 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 Jan 2025
 11:44:22 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 Jan 2025
 11:44:22 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 3 Jan 2025 11:44:20 -0800
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
Subject: [PATCH v4 09/14] iommufd/selftest: Require vdev_id when attaching to a nested domain
Date: Fri, 3 Jan 2025 11:43:32 -0800
Message-ID: <e7a204359c74bb5840544f887f7d3797d961439b.1735933254.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1735933254.git.nicolinc@nvidia.com>
References: <cover.1735933254.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|DM4PR12MB7743:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dde4138-d5f4-4874-1eb7-08dd2c2f0b97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iUq8PUuu3x5iMYs81p05loWlOFM1LsRCSFzy2R+1HpK+TRNxaupSFleD/wRX?=
 =?us-ascii?Q?LBITGWtXXAtmLTfH2+64a6ne+nUlu0ajJ/YPvzVyWSZPZZl3qnDQAD45UOFA?=
 =?us-ascii?Q?6x01314YMno2I+f/QELE47J5HZGFVHypyM21RQXwHyiICGmPoZ/ALghR6H/i?=
 =?us-ascii?Q?WxGMboF2xQS45f2msvxRUJm7sVeirP/0YM1jQooyir7zFgKCMuoNTSPZ9XuG?=
 =?us-ascii?Q?zrUh2wq8tQylmusPN0jtXqxWVNXjWXGYiyyuY1U0GuDojf4p/gaaN+gSZJP6?=
 =?us-ascii?Q?QwMoHdkhdPTfBwIUOETp+88Fyh6HQG+TBPg4tRU+dldXAXG4dGjSJUpIE2P5?=
 =?us-ascii?Q?s4Q4QEYijwFOosn67yUk3cKNtsRcedTsaSCH5/VJaDTsRXaZkpTUy2LQUJaQ?=
 =?us-ascii?Q?0F6Set1P19TVpXDHIWGHcJ2jsSc9Thr7ZyjectYMBjydssFnGHSlFYJe1eVL?=
 =?us-ascii?Q?5/7kB1Z7z8CSi08ksay5k3VKQb/C6uMa2vqw5lMMifcFQtaVfUXfOXwjEfLK?=
 =?us-ascii?Q?2aSH0/GJ7qYyqiGB/qi0B9Q0DXDpLatPFG51ydtqtBaf5QlGMK4QrKDD3/Mr?=
 =?us-ascii?Q?tCOdXh/n9HXMgPyKP/FIY5MdIvlDj5n5FYD/D7b/TwwDHQEoUvvucKeUX5iG?=
 =?us-ascii?Q?+vCNQJcSpm5PeBfcc+Yw9JCH6ejfvrJ5sWxxw34yT1lcASg81xOXNyRgwrlg?=
 =?us-ascii?Q?gTYGIY6DVH1swtrX8kTMhF0svJwlbffXwOD9xYmkntvtA6FPcn2df2mwiTBG?=
 =?us-ascii?Q?S7sdHlvZmQ33VukP0P4UwvA5MlD3kE2IQUx13t+m78iGo46pxIBF//kVUk3i?=
 =?us-ascii?Q?3CHriz16lvQJbNIzUF3Zb1qa+2U8eICUiQeO4KpaOLxmITdPQLCuo+6+XtmW?=
 =?us-ascii?Q?1b0ryHzsmrM7gC0HvWJUxIRhi3AsFpXXec01EmObKD8B9skuQjEUFuSaRb8g?=
 =?us-ascii?Q?oB+lLT6mJgAHuL33MYZf0/v87zMDkp5TxAW3L6e3CnKVQ6vVuqYJvQ81DsFq?=
 =?us-ascii?Q?KY+bmOZihN7/2LxiRYgNdQ6c/WAZqf8ni0Np7sm5wB1aeM4eppnvaxB22Kn3?=
 =?us-ascii?Q?JiXwJM0TneN7qQh2VFa+dd5KYAlA5Qxuu/9xhX/dOp1ln/mfUSQUE+E1l+Hg?=
 =?us-ascii?Q?vXbckVsmXFe+jPGxRuwXMN54tqsOtdFL0TFGwy8h62q5Z0SNGD6ocCODqDgq?=
 =?us-ascii?Q?lj8bB8zF3Tn8baNysXS+GQAplWwGj+qZx/ykP7n10BfgLIZqF2FuiM0/t77+?=
 =?us-ascii?Q?ncQibJOQSq82ehZ4OO0Uyb/nXsz0KFrG7OiQ+7C0HGw4YzNAbzhFTGOLIyZV?=
 =?us-ascii?Q?UzUG8SOuU35gorkTIEZHsiPvZGYsrTYd/C6U8GtiQ+Q4Iec4jPTddQ+DzJuQ?=
 =?us-ascii?Q?pfclbfY6ojTBgGWxhJWRdE3X1ehfeCI4ZP99E+3DFu30wXZHfrCHNAdvSM36?=
 =?us-ascii?Q?eaNFBb/2atOrGwXO1uOPXw8off4n3KuW/d+LKKkRZfIRrICUjvXK2/OpKR00?=
 =?us-ascii?Q?oGXHK44I9I7Qy7E=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 19:44:32.4454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dde4138-d5f4-4874-1eb7-08dd2c2f0b97
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7743

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


