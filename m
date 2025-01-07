Return-Path: <linux-kselftest+bounces-24024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9372A047D1
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 18:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4603161CB6
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 17:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4461F8921;
	Tue,  7 Jan 2025 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oBa/cgNB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9981F5407;
	Tue,  7 Jan 2025 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269888; cv=fail; b=gdWQpHiF5UzgSKludur3PSWu5tb9gld8eC6BG/Xhqsz+IjQKdErvVTyZLSPhI4mfv9q/r9cW9QxsFrghl/KqDdgsOzLmvlEq/EWcudRfZRyshECqBk9g+zrAweF6NM0bPbKStqri96YvlFwVNO1EAxK7pO4qVuNRLYLxq1FdfmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269888; c=relaxed/simple;
	bh=YkenH78tOCC6SUgR979itYHRNLbUNPbjFXTJe5WouaA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PcIxSoQ2SGl+vCk2YCNkbT+qWSuReizsX/+Y3SN4t7IwTMPxtG/99pFuDg34BNLam36mr76EA6BsmXugLDQ4KxVqmLxZCTwE7RcSH8/3TUmbPflT8KbxxOWpJa/Cq0n/F8XICHGPA42803S4DzNvHp+OpjXtOC6gaQhIfayhnFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oBa/cgNB; arc=fail smtp.client-ip=40.107.96.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TftiZTqtk4itukZRn26cH3JHTPjvZiSmuamyyC9dPvR9HDFcwoPXCVhtzW77P8BxBz3TruwL8orjjfq4OCSPwUrAXWqnUAVYMjOSk2NxcXN+Di8nVWdM4PgQPi17zHAzk+IX9vPQxD/cb35lW20xjxIPoxffLpnY4IMXruKlSQouRMQIV85+10tujpeZBbzn2PdCPq4ycIhpDXYvb35+kf9xQEHZS778IDLxHNtVEO8zmh4fqx29GeX+ZHcIAksH0Y+o67UFgAUIjR/O4ntZgBsDjHywF1K7MKT7FdLT+xW4CaK8KpidYEW/GUMC+BR/GzllVAIJtbOHNnQNSFSwHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owksryRUWHVUTKc9EwdqafuNcbtKA7Z/YWtyFiy6EL4=;
 b=RVKsf9+VTWtCkxaJe7b0AdpWZ1us/JXAjeq8h/Yj9XR+0V5w6fRb82i8g+uj8j5FR5IEA/sxD79vLifK1qm7HLvhhGSgoXml8QCiyrGf69cxZPhgPnfBpGIA2cztnPTbzqzuKvc3eeKcp1FMDO7uYxe4XP0Vg8jmiyICzLxgHAY8LyoEWazZP6T9jrQp46QX0XuLMufNUgdRg1PYdyArKh+GBPZPwD7gM2pKHHU47k7vZ/AhAWxLM6jmNBMR1z7EIT+V1aStQlt6CVAwS0OPKYXkbf5nHjl99I1uWfyRY8vYNATE8HYwX2W8s2aMg1lLZyqtLHczN0bjtGWKAu5Zbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owksryRUWHVUTKc9EwdqafuNcbtKA7Z/YWtyFiy6EL4=;
 b=oBa/cgNBPDcV/ZZ+YT5XevfWDbqT7arw6bBa5xO0KiBPWn+zS7PPsKOJIXpoHExn9WibCvKQbjFwMaG3A8CG6ZWr+lZsPo6HY2yhkxyGAxpIkJOGEbTF6Kdb8QfjhCdx8kduU7jRXCWC6e4Q1bwee0FNoV/qktUBAxw2Z6TXus6728qbmI/K0y47Zm6jtcrBSDmhojgmbSw7sn5xLAlQW7OABtILVlNMETaARb/PgbvXrGO4l4Wnq5bUQUfTxOyl7cNhnMaBzcuYJc3HjwVoNMv6IviLbNpKZcr8qTq4ggmucYdVCKHdU+hu4XUVgNrBwMGh9Z1NZMIAuEed4Okphw==
Received: from BN9PR03CA0306.namprd03.prod.outlook.com (2603:10b6:408:112::11)
 by PH8PR12MB7376.namprd12.prod.outlook.com (2603:10b6:510:214::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 17:11:13 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:112:cafe::e5) by BN9PR03CA0306.outlook.office365.com
 (2603:10b6:408:112::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 17:11:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.0 via Frontend Transport; Tue, 7 Jan 2025 17:11:13 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 09:10:56 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 09:10:56 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 7 Jan 2025 09:10:53 -0800
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
Subject: [PATCH v5 11/14] iommufd/selftest: Add IOMMU_VEVENTQ_ALLOC test coverage
Date: Tue, 7 Jan 2025 09:10:14 -0800
Message-ID: <293e82ce0591d541d35dda0043411a64b4f66a58.1736237481.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|PH8PR12MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a5c2f10-2cd8-45fa-ecce-08dd2f3e4a47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/KIKy1oBaddbXI5sBldAxNkpnMvPTNkOe65vqeqRZPArr+AlqW2vmlzm7y6I?=
 =?us-ascii?Q?03JFPhgpXApQCrjuPYxx4NjrVissqQxKr/n/lWtTr4fEDPJhgSwNsBqEE6pk?=
 =?us-ascii?Q?sI6KKstBkOYWGeDLi6oSWdI75Z/ON/j1GKTl4UhhpkS9OWQ/2vEjZZcV16BH?=
 =?us-ascii?Q?PTtCabF4WgIjV4DpQd9UPc7+yMT49ZxDdcncSwlnZ5u2qeunli/SB1bFcv8A?=
 =?us-ascii?Q?ABv2pT8C9m7LCwABOzDPQ0PfwNROqC/m23y/nSSixQ0ayM/d27US/wjtFem1?=
 =?us-ascii?Q?Vrlciq9yP2fxHFPo6aosTvregV8YmiFSGDGSrkfsturR0AI0JJm0+6kmGcAu?=
 =?us-ascii?Q?siLD8xHVnDkLFbL6/uxNL22Ydm1bPo6ERmBJMOOQlqsA7LQf/YlttZKPl9/N?=
 =?us-ascii?Q?ZoefDEm+HSqyYpnPyFW1hNlViyJj2utD1P/MDJvgRfZNLy2RyhrxEIrsMNmc?=
 =?us-ascii?Q?lG1qL24WtuOZjKDg1n2tLphYGQijPtKSyVv3HpAuGdsmJCFvjauSxhTMw5eh?=
 =?us-ascii?Q?iGYts/PC2ZsBNSG8vOzvXXRowyeTfQvSdsrhYCo06RC+77iRD173mJEaBfHr?=
 =?us-ascii?Q?p/g5TpJH2RB7RHMxq7jQdO/fyz3ZRRNFXFUhP7I0lmm8u/sHRTz2qAW/goXn?=
 =?us-ascii?Q?kyp0UecHpf9Wta8z6QJ8fmBHoV5vIXDIbBycwEgh5oVJ7S1In1YxaHjifx/d?=
 =?us-ascii?Q?M4IM41mdNyguQxLBR8RN1IYdvOfcbGm3RwOiV+88dl2uiICBtS1pQkjrU571?=
 =?us-ascii?Q?HdcgMWTAton1MMafmiFAs2+OL/BQ1X2oOqhUJWw+HG6+y5av7Ok73hthevV9?=
 =?us-ascii?Q?cFy7YmUGzNd1YFy4tjoWhP6SPOlwn+Y+FZY9ClwdGsJOc7F+AU/laBH/1DT5?=
 =?us-ascii?Q?MG7az8nYays76hcZiiqE0RqfnL1QYhNBpDmVrttpgz/CsZUXmAIbGV13pXND?=
 =?us-ascii?Q?uZoRgmmbV6FU9+x1bwxPDfOOszZ8acqwKllO4ytn5PNjIxjbiujHH+XYEzWb?=
 =?us-ascii?Q?SIRonin6vDAiSPiEzzUBlJHA1gTH8WAx+fb4SvYqS3ibxEMzi5nPVJF6tNpc?=
 =?us-ascii?Q?xbfBS95zvwL81VkXiWUUpOIOw2tYh2NdcM6pX8IKLe2Lq7Dh1Qfbcj2hCGLI?=
 =?us-ascii?Q?MHfrGG8y38JF2/HZNd8fm4SI/YihUFy1tZP5WQAihKn3rJfRMsFka7ZEd9Hf?=
 =?us-ascii?Q?+Yk0sinQr6jMqFUKDdG4Ygc7Bie/kURhA6t3Ovw3hu8mmrbO0y6xxkGhVIIq?=
 =?us-ascii?Q?GQVldIQRisds8fKthJSqtgollbUUulzZ/XbnB2TN/s/dvZlB2MmvO4cVuZB+?=
 =?us-ascii?Q?mJuBcqGzjBf7+TOgy4hHtRx7aL7QiM3Dj7squsBvbFinVR9xdtCo3Empjnow?=
 =?us-ascii?Q?f6uGCnXxhKWIxH2lUwH9WsqaEbnSGieJf3svmiA9QgrXLJ+19262ljeRq7Rs?=
 =?us-ascii?Q?oNEW382HJ5ZmPGBolQMRUjtEcxvyMQ+OTzRbed74lQOOsG2SIqIJJCylxBOh?=
 =?us-ascii?Q?ogYuizgadFbdKnI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 17:11:13.4996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5c2f10-2cd8-45fa-ecce-08dd2f3e4a47
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7376

Trigger a vEVENT by feeding an idev ID and validating the returned output
virt_id whether it equals to the value that was set to the vDEVICE.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h | 65 +++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 22 +++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  7 ++
 3 files changed, 94 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index d979f5b0efe8..15cf28b88332 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -9,6 +9,7 @@
 #include <sys/ioctl.h>
 #include <stdint.h>
 #include <assert.h>
+#include <poll.h>
 
 #include "../kselftest_harness.h"
 #include "../../../../drivers/iommu/iommufd/iommufd_test.h"
@@ -936,3 +937,67 @@ static int _test_cmd_vdevice_alloc(int fd, __u32 viommu_id, __u32 idev_id,
 	EXPECT_ERRNO(_errno,                                                 \
 		     _test_cmd_vdevice_alloc(self->fd, viommu_id, idev_id,   \
 					     virt_id, vdev_id))
+
+static int _test_cmd_veventq_alloc(int fd, __u32 viommu_id, __u32 type,
+				   __u32 *veventq_id, __u32 *veventq_fd)
+{
+	struct iommu_veventq_alloc cmd = {
+		.size = sizeof(cmd),
+		.type = type,
+		.viommu_id = viommu_id,
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_VEVENTQ_ALLOC, &cmd);
+	if (ret)
+		return ret;
+	if (veventq_id)
+		*veventq_id = cmd.out_veventq_id;
+	if (veventq_fd)
+		*veventq_fd = cmd.out_veventq_fd;
+	return 0;
+}
+
+#define test_cmd_veventq_alloc(viommu_id, type, veventq_id, veventq_fd) \
+	ASSERT_EQ(0, _test_cmd_veventq_alloc(self->fd, viommu_id, type, \
+					     veventq_id, veventq_fd))
+#define test_err_veventq_alloc(_errno, viommu_id, type, veventq_id,     \
+			       veventq_fd)                              \
+	EXPECT_ERRNO(_errno,                                            \
+		     _test_cmd_veventq_alloc(self->fd, viommu_id, type, \
+					     veventq_id, veventq_fd))
+
+static int _test_cmd_trigger_vevent(int fd, __u32 dev_id, __u32 event_fd,
+				    __u32 virt_id)
+{
+	struct iommu_test_cmd trigger_vevent_cmd = {
+		.size = sizeof(trigger_vevent_cmd),
+		.op = IOMMU_TEST_OP_TRIGGER_VEVENT,
+		.trigger_vevent = {
+			.dev_id = dev_id,
+		},
+	};
+	struct pollfd pollfd = { .fd = event_fd, .events = POLLIN };
+	struct iommu_viommu_event_selftest event;
+	ssize_t bytes;
+	int ret;
+
+	ret = ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
+		    &trigger_vevent_cmd);
+	if (ret)
+		return ret;
+
+	ret = poll(&pollfd, 1, 1000);
+	if (ret < 0)
+		return ret;
+
+	bytes = read(event_fd, &event, sizeof(event));
+	if (bytes <= 0)
+		return -EIO;
+
+	return event.virt_id == virt_id ? 0 : -EINVAL;
+}
+
+#define test_cmd_trigger_vevent(dev_id, event_fd, virt_id)                \
+	ASSERT_EQ(0, _test_cmd_trigger_vevent(self->fd, dev_id, event_fd, \
+					      virt_id))
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 212e5d62e13d..c225f6e5108d 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2774,15 +2774,37 @@ TEST_F(iommufd_viommu, vdevice_alloc)
 	uint32_t viommu_id = self->viommu_id;
 	uint32_t dev_id = self->device_id;
 	uint32_t vdev_id = 0;
+	uint32_t veventq_id;
+	uint32_t veventq_fd;
 
 	if (dev_id) {
+		/* Must allocate vdevice before attaching to a nested hwpt */
+		test_err_mock_domain_replace(ENOENT, self->stdev_id,
+					     self->nested_hwpt_id);
+
+		test_cmd_veventq_alloc(viommu_id, IOMMU_VEVENTQ_TYPE_SELFTEST,
+				       &veventq_id, &veventq_fd);
+		test_err_veventq_alloc(EEXIST, viommu_id,
+				       IOMMU_VEVENTQ_TYPE_SELFTEST, NULL, NULL);
 		/* Set vdev_id to 0x99, unset it, and set to 0x88 */
 		test_cmd_vdevice_alloc(viommu_id, dev_id, 0x99, &vdev_id);
+		test_cmd_mock_domain_replace(self->stdev_id,
+					     self->nested_hwpt_id);
+		test_cmd_trigger_vevent(dev_id, veventq_fd, 0x99);
 		test_err_vdevice_alloc(EEXIST, viommu_id, dev_id, 0x99,
 				       &vdev_id);
+		test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
 		test_ioctl_destroy(vdev_id);
+
+		/* Try again with 0x88 */
 		test_cmd_vdevice_alloc(viommu_id, dev_id, 0x88, &vdev_id);
+		test_cmd_mock_domain_replace(self->stdev_id,
+					     self->nested_hwpt_id);
+		test_cmd_trigger_vevent(dev_id, veventq_fd, 0x88);
+		close(veventq_fd);
+		test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
 		test_ioctl_destroy(vdev_id);
+		test_ioctl_destroy(veventq_id);
 	} else {
 		test_err_vdevice_alloc(ENOENT, viommu_id, dev_id, 0x99, NULL);
 	}
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index 64b1f8e1b0cf..99a7f7897bb2 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -620,6 +620,7 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	};
 	struct iommu_test_hw_info info;
 	uint32_t fault_id, fault_fd;
+	uint32_t veventq_id, veventq_fd;
 	uint32_t fault_hwpt_id;
 	uint32_t ioas_id;
 	uint32_t ioas_id2;
@@ -692,6 +693,12 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 				 IOMMU_HWPT_DATA_SELFTEST, &data, sizeof(data)))
 		return -1;
 
+	if (_test_cmd_veventq_alloc(self->fd, viommu_id,
+				    IOMMU_VEVENTQ_TYPE_SELFTEST, &veventq_id,
+				    &veventq_fd))
+		return -1;
+	close(veventq_fd);
+
 	return 0;
 }
 
-- 
2.43.0


