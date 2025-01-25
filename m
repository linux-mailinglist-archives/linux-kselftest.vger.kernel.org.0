Return-Path: <linux-kselftest+bounces-25146-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 188F4A1BFC2
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 01:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CB0B7A2D71
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 00:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F407081C;
	Sat, 25 Jan 2025 00:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XJvy5a0V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136D85672;
	Sat, 25 Jan 2025 00:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737765082; cv=fail; b=gyWOONmD+k8nkgNvDc9uMTf6LehLGCKm66c0Fw0IQB+LyCHo1dH9rBzqIPTlr2Xyz+Q/4ncbkCTHyOqMQPnjicAofxB70sRP+D70Mi0xXWv8rqAWpWjKTIuqvDfaqJUBVLWwx5fh777qrvEs5pP6XbqlyotH/4x7FRgR1gAb/bY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737765082; c=relaxed/simple;
	bh=cwpfqoFgyMu7WCQ6H96IbTKX31Wqqt06+7e6dpjn3aU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=noFZ3145UMPp5Snjt1RiXazWw3u9CZgi7HN+hIT+PrGNhNfSzGuTT+q/aPQd7RVLA9MldaKekr6TJwCczQEkp0lyRyDAXRLVKF3oNI6n+9vwiuPcwATxvUML+iICAk1F5DZew4gOG/SK6WHkjugUJD+8NBFWxZZnqqEAOAV63NI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XJvy5a0V; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buCVwgRYbGyHqe2UJCbLEtW6SUqOSUSBZblBRSsC1D4Z96vrfq6OdqV7hFJOkrF6juzkFZhjWHr8OEeWYRzz2+ENRUiZtOTazMqSCV7cXSLXPVu6esZJlJqIG7iYUzOXye0pWZWNS4Hxr5NruFZsYoUjpRZz55iWl+tyYGEuBnm/XF5vngFcqhCF+YnHX0T9rFvkDcKY6H44CdKrgIU2rq5xAkmC/VJDRKoqr5PWjchiqGxQfFwga1iQBIvVKActrALiuqYtnBIDUc9ssjP9T5uZuHUQh8QtkPgdZZAxGlRCR5c9m9ruKG+13X8PPeYq6sm7xP63FrlQaTjEhQwInQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+1YxygOtMUzpOMI4yja4ip0mFKhLkLH+kbEUjzJpzc=;
 b=qmnwH5oVu/tdX1wUGEavoDi+dEhEuJS3il0t7YZm1hxvnTjo/FFeWjUOnhPZTdUgpc48NO/AuQ+FuAS2z4cd+dCmLbUhC8NdSK/sVaqFVU8pxK/IeCoQcj8eQBew0+EETParBxlVHP29YbKD5kfhOU+81FS4RvUgryAsMSM9sW0AF4vT2GbJLWwGS9j71NpQqaD7E6GdwkQuKPyFRRlCwXuucKZSnqclm/rOn+00dg2vsuAIvycARfK/P8bv8Cmc1vP7s1aUvp4KBA04FXmpWdDyEohFwKnXhvJ3YBAXCQjXEbKsgLAmKicVbR7FPFpVHiRGmkGjJnKWN2RzA/Y6dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+1YxygOtMUzpOMI4yja4ip0mFKhLkLH+kbEUjzJpzc=;
 b=XJvy5a0VBZoG+ZIBeUNujFKqv7/H4S/8vreCb8OGFt5dDzRw7L2Jnvi+M+YC62EYXb3wsLvauYwSS3ENCvAZwYxuyKIXUW4gYA3wjVfBDv7xU+pVYW3v0iMQyrGNaBh2AQkWub9hBuVEuef3lRZ9peySmAGw9TiEGcpsa85vzJTDJCea49942jpaAVCmiw1ZS4dOjhO4Y4MDd5I+lyuOLYtBoHoZGxk4sH+NbOxxz/Ai/4BXp0C3Ootrjqie7J1O7TntDE3c52z/vEpVFmIokc9qp7n098inyLjDRn7tZDzgKiR8Bt9V7rK7F7o1g1zgF1hA3Fv/cSTCm61x6rDGkg==
Received: from BN0PR08CA0005.namprd08.prod.outlook.com (2603:10b6:408:142::20)
 by CH3PR12MB9429.namprd12.prod.outlook.com (2603:10b6:610:1c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Sat, 25 Jan
 2025 00:31:15 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:408:142:cafe::5e) by BN0PR08CA0005.outlook.office365.com
 (2603:10b6:408:142::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.19 via Frontend Transport; Sat,
 25 Jan 2025 00:31:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Sat, 25 Jan 2025 00:31:15 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 24 Jan
 2025 16:31:03 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 24 Jan 2025 16:31:02 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 24 Jan 2025 16:31:01 -0800
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
Subject: [PATCH v6 08/14] iommufd/selftest: Require vdev_id when attaching to a nested domain
Date: Fri, 24 Jan 2025 16:30:37 -0800
Message-ID: <3d943ec41bcdc2a3a8ef78c9433e5558be19bf81.1737754129.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737754129.git.nicolinc@nvidia.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|CH3PR12MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: 7446c40b-9b01-42fc-764a-08dd3cd7940e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xAuYkhNHV2lT4Tg2XdQTV+34M60n0jOgKztzytrXNMKs6cIFZ6Aip4/HB7+J?=
 =?us-ascii?Q?huos5pkZXjJFhImWcZ+evZds2NFy+oLF/FeZtowJKWOhyVIfHQxQQdpA9uAi?=
 =?us-ascii?Q?Kh7JNUAPWiBV/trjXHH0qPYOfB0Q+Bim4BHFJxaSFK3X1dxvYl0hJBA0HjFY?=
 =?us-ascii?Q?/Epz9D0gU+OKO/ygykRlv6KumunhArIUbQTFI+h1bu0DxTfwk6xbj0GwQrok?=
 =?us-ascii?Q?N9P9h681kp3HB8U23vKkIMNKquvLhEB1Sh2u54mQMKVagNtRsy3CC4eVSu9R?=
 =?us-ascii?Q?E83E4Vulx77osGieCsiq5Js1UnIzRcHwXq70Uwdd5LG1peH7KheXPLlj/Rjo?=
 =?us-ascii?Q?hRAsREWr0iK7jT9qQZNhjjWqkF+UBY2W/rNptbqae8MQBkdrEoFeeU7DXkeL?=
 =?us-ascii?Q?vMkmE++FLxPEzYbAa4Z7SXa3Cjd3u1IXdwkRLXODiie21UVkqAHe2NEnhZlK?=
 =?us-ascii?Q?RXzKTxi2CWXi7f1yiu4W4Bi4bpfya6AoSXheziMK6/4m9pod9LcEQif0uJwZ?=
 =?us-ascii?Q?Eh767sDpl7YpsfWeIhqw41kzAhJnhO8TdV6C9A5aluE+vkM5lzyVtSQ7qaDi?=
 =?us-ascii?Q?NDCnqmwk1cf0ZbxllAB6RGGZhZ65B783cx1sJ5b/5hJzYz9733XQ4ygpJ+Ds?=
 =?us-ascii?Q?5exrAD7lyTUg4+3M7lgCLrhtikjrLPoz5VcrYrOCHYT3xXPGJ2y33MknUqfC?=
 =?us-ascii?Q?lgt57VHQ9NcdYB5QdYIvM0bqjjXP6VhaRtZFz7a2aBDWJ9XPjwoys6CwcopR?=
 =?us-ascii?Q?2Hw7c6BHr9F/jo9jZWdB9Or5Rx14yKmIrZlimbP5oqF68gmicWxR35wegR/f?=
 =?us-ascii?Q?XATDeCB4Rgohon0/8cDN+5eSGFbQYgjdzhPTERYqf3qVAJc0U/l+gBFUPiI9?=
 =?us-ascii?Q?Zu5xNaX1XitEt3R4YwuXVns9TlfwBZt0qLHrVq2V4RxsSnvdYtHnhq5waQub?=
 =?us-ascii?Q?ofndyYuXVoR49++40IJkIQKkPoS//FzLk4IMsfZdRRJFyc8GCjTn6Yq55eun?=
 =?us-ascii?Q?zgGAB52bnkiiHxKn8Z2rK5NrKk/TbLBSM7iryr70OaQuhDGQawNgZWtnyRmz?=
 =?us-ascii?Q?yirB9QSXsBxwvljaeu6Gu/0KFndXi/f5qEoqU3AzWwoWI9291qn+g1SDn02R?=
 =?us-ascii?Q?NMK/vvIhhtx2KdiXlghElo4Ys35Xgnqeuz2XSB3zT7vVGwp5SZcDvCI4PjAG?=
 =?us-ascii?Q?khVsD3LIuqmtpnz1+sVUlS69d/L3ISWvOgz9wKHzhR8Yb7qQK2ApHSg3GyZf?=
 =?us-ascii?Q?ERHyZ1nvsFF4h6MPCOEq5E+Q2rOzTJ9OFiD05jturvSoya0wm3ZhYMycekY9?=
 =?us-ascii?Q?fGjp1vk6kyhjANup+KkXyXphfXvHsd7Q9LtJeXrdnk4jtdY5yBX+hX/RZRCT?=
 =?us-ascii?Q?zJSkXYDAdSFho/Gsu5gjlt7i9w8lr1bJ+/coKkL5peW/h5wn+f9u4BPXW1Z7?=
 =?us-ascii?Q?27qWIw7wQsCnjTZ0O91pOfJqBpu62/wJwGoKbbcUj3F7APF67FQuJkLFQkS4?=
 =?us-ascii?Q?Wey/GGBPqRPkr0s=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 00:31:15.4058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7446c40b-9b01-42fc-764a-08dd3cd7940e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9429

When attaching a device to a vIOMMU-based nested domain, vdev_id must be
present. Add a piece of code hard-requesting it, preparing for a vEVENTQ
support in the following patch. Then, update the TEST_F.

A HWPT-based nested domain will return a NULL new_viommu, thus no such a
vDEVICE requirement.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/selftest.c        | 24 ++++++++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c |  5 +++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index a0de6d6d4e68..d786561359c4 100644
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
@@ -193,10 +196,30 @@ static int mock_domain_nop_attach(struct iommu_domain *domain,
 				  struct device *dev)
 {
 	struct mock_dev *mdev = to_mock_dev(dev);
+	struct mock_viommu *new_viommu = NULL;
+	unsigned long vdev_id = 0;
+	int rc;
 
 	if (domain->dirty_ops && (mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY))
 		return -EINVAL;
 
+	iommu_group_mutex_assert(dev);
+	if (domain->type == IOMMU_DOMAIN_NESTED) {
+		new_viommu = to_mock_nested(domain)->mock_viommu;
+		if (new_viommu) {
+			rc = iommufd_viommu_get_vdev_id(&new_viommu->core, dev,
+							&vdev_id);
+			if (rc)
+				return rc;
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
 
@@ -861,6 +884,7 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
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


