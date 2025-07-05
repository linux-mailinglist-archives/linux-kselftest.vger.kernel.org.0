Return-Path: <linux-kselftest+bounces-36624-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6C2AF9D4C
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 03:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5A11CA149E
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 01:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3D020F08E;
	Sat,  5 Jul 2025 01:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nBnlShZp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9778020013A;
	Sat,  5 Jul 2025 01:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751678070; cv=fail; b=KXsuKgoZlgPmZnb996h6ZTut2CY45hlgN/Zey8FjtbvWD7U09YNNtu7ikXKmjynuF1t6AKHcqpUhtVwL+2GPhPNRgQ4P44R6/j6f7Alr0qkhw1GnRQtWSqux5pNXpad1RR9m8jqBDZl8hHBZmVNMYjVYnR4JxLdXRJEZ5jk8mxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751678070; c=relaxed/simple;
	bh=66bAbCQev10GaaPewwh9RqbAesUfiojO2t+84sSPI8M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tqSzp8RMMYOiUxV4N6/Ms3w+FKLwKVf90/WL3V66yqjjCwvOuyxZbgvS9DXmUUrnvZm8nnibYmh6gzULM6AH/uNGQoj7o0cx47kBJycjvIkP/PUBIGPjn/zj7VovxDZIcJ19QMBtCH6D71bb1jkjs9BU5a/yyYCHxTEuyhNAnTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nBnlShZp; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CttJBEzuDUkcWvO447RY31r/VdgswbqaNzkXbHYJvJj5QfkG9iHaHxCLd1IVwZYT4r0oMJ0FbEL5OB8uGPaXW0lxlYCiiYoIUU23tdFULq4m47Q1NNUfPmdBW4R9cYoajEnvn8zMu1uhkxs4mRRW9+EHSzsdksuF6NibKUx3IusMSfBLQYbJn+CiRCHM67iNjgFSsGjkUkyq3aSkNrV6fhKqvSmuFj5zSINPUQ3CUUPM4oPDJHav/xZ4KEeVGD8vBAgwmcB5hxfaRdZzo1xFHqhpnocSz7F0HHHBKD0eCSMXoiRBpmAW1JfOsmaivSxhgJn9KZwOoE+64h5PJjpoHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phvqptz3tv6aVk3TAUiP28H3NGbjOPqJi+4Z4SmdGxE=;
 b=Ode/+WodbI08/auV4jWqZNFjDiKCFThZWSaW0cnuicpgb2QjXZQjTAqR7e1La8p7k6VRLvCKqZeC9wJ1gc029H9Kuq9P/CK7h2hqqx5qjYUTZvuHQZlv+znOEUEFwQ2LQEfsiPgWuY0VroNcCT4iUQ9j0ylk0Db6wntl/L2RKcCFbURggraBaaVymAnRU5vCastmvVtuYFPNmt1cM8S90cvWJ3wj91Kb7zFkXnUnT54xWSj032nBPe86OdRHFTQ7OI0hIcZ6gXjNLNduVWplAa8QQsEjrbqTFvYsJhDd+h8iwbjFprWlwG1lAuQa3bXemtmehA1SFoKD5xvLhe3dLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phvqptz3tv6aVk3TAUiP28H3NGbjOPqJi+4Z4SmdGxE=;
 b=nBnlShZpcriYgn4S8wD0+2iQ+FTOzKfHTOh9j3EHrc/mHb7HwfSYEH5KGIzfJSRPZSvkBcorpIqtRqmO5zORvZcv6qa1K4le25NonMpSjXxI5o94tzjSlU/KwTLcxb3wXbZ3G2KKkz1Ad+XfjX6ldS6jASnFA4yxqs7WghiG1OcBNJ4MxNVw7992EgGsGmsr4mvZz5teeUbzUPoTt2YCRVtqsRvP4paW76j0y8spFBwrwOJEakionFjmuFZqjvdRVlptpJm9U+JmSxEr/6eMoiyrUPLW0felaCEAH5BIUwCgoLppLT8qmCABFmeGEY4txwE8kvhjhfV9eMc2pEIZzw==
Received: from BN9PR03CA0209.namprd03.prod.outlook.com (2603:10b6:408:f9::34)
 by CH3PR12MB7524.namprd12.prod.outlook.com (2603:10b6:610:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Sat, 5 Jul
 2025 01:14:20 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::a) by BN9PR03CA0209.outlook.office365.com
 (2603:10b6:408:f9::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.23 via Frontend Transport; Sat,
 5 Jul 2025 01:14:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sat, 5 Jul 2025 01:14:19 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Jul 2025
 18:14:17 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Jul 2025 18:14:17 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 4 Jul 2025 18:14:15 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v8 14/29] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC ioctl
Date: Fri, 4 Jul 2025 18:13:30 -0700
Message-ID: <49a93d92ce657cf6a0d588d2b31ad3600ace21f7.1751677708.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1751677708.git.nicolinc@nvidia.com>
References: <cover.1751677708.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|CH3PR12MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: c7b4830d-3d6a-410d-4c70-08ddbb6144fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xb2FOe5F+pLhw581/jpNqxBh7Qx6CiSxS8AQ7P8vAeY19pn9rU8j7TtJ4W4l?=
 =?us-ascii?Q?ysg/IMp9d2/pYuJYWA1TQJRwbz8J+61q1ixtZlAfrGC8H3DKF9ZrIVHiAXLR?=
 =?us-ascii?Q?fNXnPKTjpTozoC3/1aM/wSI+Ib6Ftjt78VQ0GoTC6NFJvoHi+18BrEbpF9A5?=
 =?us-ascii?Q?LcyHTdqz4ysGwlO1xkvDQ5+g60brMqjboq9tc0wBzoitchg9OeztYD0T6D05?=
 =?us-ascii?Q?rN0CLbNsW2lgGrC/OaAe/5wkBx6x84oOOAEAeoBoF88/iSwo4OSevjSCm6+s?=
 =?us-ascii?Q?W1YVLHUOqzaipXoWag4QM1EIUfwigTfB3mtWwjtRxEZXQluWiiYNv3VskUMJ?=
 =?us-ascii?Q?L9uLvh2b8o50qlkRocNl51ENd5YbKgggKTcF9Na5GwjGSHC7Tg0DcLiJPji1?=
 =?us-ascii?Q?4o2head/Ox6CcOchUm4zen2uCaU1FDTy0jpyz12MDj4YOY5ULDiXYftdh1d/?=
 =?us-ascii?Q?xwM7amlzgix1474hQz6qB/9FAvithluU1GOzHT5q1YyHydFOPALAQadFJzJN?=
 =?us-ascii?Q?4mSJBWIiEmWvCiqAdL5+Ip0t4XzkTPonefBqI/iFOTnnfBYiOrnr7tjaMBs/?=
 =?us-ascii?Q?DCaPhdSzsi5DCkUlSfLDjIyCU6TO3Jy73pSVjbjKEaCVFapQkgGXkb3ae9D2?=
 =?us-ascii?Q?OcMJ4PcL2euMT6q0jRR3f2qB+PvcYNl5RPS02FhU+a+bTQvKxgESjW1kC0bL?=
 =?us-ascii?Q?yfZiVno8wgfUImr6ZgjGXhbdMO/diZh2HpakLYAlb7o9TUC7SQPLcQ52avUo?=
 =?us-ascii?Q?7V+uH8lkkVBC9E7vqWoef90aw1obnFINRxVSj3GhuUBVG3H9+3zbxod+n7S9?=
 =?us-ascii?Q?eJmfccYq0Vn+YfOEPHk144zf4t6W62iBqRSxbWCP8AiQJnBhcQc3izst//Je?=
 =?us-ascii?Q?iUUM266iLCg9wLk+iOquXdIR20dHMcP9Dic+XJzNGfkT+HW9pMGZg5e4Qihr?=
 =?us-ascii?Q?BNO+fhhMdeYGBQ6OlFZ52uFUI/lLhXrmkYNkFU2R6ht+7VkZxRKdkRXR2Wgk?=
 =?us-ascii?Q?YK/L1SUXC3F8zN5299DV6sg39RVaAWJCytlYocSryv8K90hPTsWoJ3zXIVsT?=
 =?us-ascii?Q?XZzqt0JLkZzzFWtWmiXyu56mHLdV2xqNSjGWfYUOjCJafZY4boKPANJxxr3K?=
 =?us-ascii?Q?UFYrF0gukrKyAdjf/+Fe+F2j3M9J+COMtAHCvGR3iX68ig6FVLxlu88jkG7a?=
 =?us-ascii?Q?4P7Fn14g61XAl6nWTNmJm2S+rM5tP5LIl+z8Cm44bo6HzQ5cdoKSvTi7Somu?=
 =?us-ascii?Q?bdAL6/SxdbSErqK7LeuWcowza8rpb7a8e02eiIsdnzwmSGjVHOGGEy9Jh5lq?=
 =?us-ascii?Q?lTVskMSTjiHaT4GDntYPyLkGW6+n3SSdwEH+XdvDe1oTMIiufeLz+hOLikID?=
 =?us-ascii?Q?NRjN0CYxSycRLo6jXQTANcy/uWpaOmWXXCU17n73LpEp3/gJwkLLneMBSvYT?=
 =?us-ascii?Q?cYrMWVhmJo/URXAzy4ely8v+WEeqotQOgDP2kJtX4dIOWD0G4KuxELaW+Zyw?=
 =?us-ascii?Q?QPknTMv7S4nKKdYNSi6inMFFr3mkxSNr82WG?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 01:14:19.9047
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b4830d-3d6a-410d-4c70-08ddbb6144fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7524

Introduce a new IOMMUFD_CMD_HW_QUEUE_ALLOC ioctl for user space to allocate
a HW QUEUE object for a vIOMMU specific HW-accelerated queue, e.g.:
 - NVIDIA's Virtual Command Queue
 - AMD vIOMMU's Command Buffer, Event Log Buffers, and PPR Log Buffers

Since this is introduced with NVIDIA's VCMDQs that access the guest memory
in the physical address space, add an iommufd_hw_queue_alloc_phys() helper
that will create an access object to the queue memory in the IOAS, to avoid
the mappings of the guest memory from being unmapped, during the life cycle
of the HW queue object.

AMD's HW will need an hw_queue_init op that is mutually exclusive with the
hw_queue_init_phys op, and their case will bypass the access part, i.e. no
iommufd_hw_queue_alloc_phys() call.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |   2 +
 include/linux/iommufd.h                 |   1 +
 include/uapi/linux/iommufd.h            |  33 +++++
 drivers/iommu/iommufd/main.c            |   6 +
 drivers/iommu/iommufd/viommu.c          | 177 ++++++++++++++++++++++++
 5 files changed, 219 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 06b8c2e2d9e6..dcd609573244 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -652,6 +652,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_viommu_destroy(struct iommufd_object *obj);
 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_vdevice_destroy(struct iommufd_object *obj);
+int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd);
+void iommufd_hw_queue_destroy(struct iommufd_object *obj);
 
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index f13f3ca6adb5..ce4011a2fc27 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -123,6 +123,7 @@ struct iommufd_vdevice {
 struct iommufd_hw_queue {
 	struct iommufd_object obj;
 	struct iommufd_viommu *viommu;
+	struct iommufd_access *access;
 
 	u64 base_addr; /* in guest physical address space */
 	size_t length;
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 640a8b5147c2..55459b9eee31 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -56,6 +56,7 @@ enum {
 	IOMMUFD_CMD_VDEVICE_ALLOC = 0x91,
 	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
 	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
+	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
 };
 
 /**
@@ -1156,4 +1157,36 @@ enum iommu_hw_queue_type {
 	IOMMU_HW_QUEUE_TYPE_DEFAULT = 0,
 };
 
+/**
+ * struct iommu_hw_queue_alloc - ioctl(IOMMU_HW_QUEUE_ALLOC)
+ * @size: sizeof(struct iommu_hw_queue_alloc)
+ * @flags: Must be 0
+ * @viommu_id: Virtual IOMMU ID to associate the HW queue with
+ * @type: One of enum iommu_hw_queue_type
+ * @index: The logical index to the HW queue per virtual IOMMU for a multi-queue
+ *         model
+ * @out_hw_queue_id: The ID of the new HW queue
+ * @nesting_parent_iova: Base address of the queue memory in the guest physical
+ *                       address space
+ * @length: Length of the queue memory
+ *
+ * Allocate a HW queue object for a vIOMMU-specific HW-accelerated queue, which
+ * allows HW to access a guest queue memory described using @nesting_parent_iova
+ * and @length.
+ *
+ * A vIOMMU can allocate multiple queues, but it must use a different @index per
+ * type to separate each allocation, e.g.
+ *     Type1 HW queue0, Type1 HW queue1, Type2 HW queue0, ...
+ */
+struct iommu_hw_queue_alloc {
+	__u32 size;
+	__u32 flags;
+	__u32 viommu_id;
+	__u32 type;
+	__u32 index;
+	__u32 out_hw_queue_id;
+	__aligned_u64 nesting_parent_iova;
+	__aligned_u64 length;
+};
+#define IOMMU_HW_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HW_QUEUE_ALLOC)
 #endif
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 778694d7c207..4e8dbbfac890 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -354,6 +354,7 @@ union ucmd_buffer {
 	struct iommu_destroy destroy;
 	struct iommu_fault_alloc fault;
 	struct iommu_hw_info info;
+	struct iommu_hw_queue_alloc hw_queue;
 	struct iommu_hwpt_alloc hwpt;
 	struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap;
 	struct iommu_hwpt_invalidate cache;
@@ -396,6 +397,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 struct iommu_fault_alloc, out_fault_fd),
 	IOCTL_OP(IOMMU_GET_HW_INFO, iommufd_get_hw_info, struct iommu_hw_info,
 		 __reserved),
+	IOCTL_OP(IOMMU_HW_QUEUE_ALLOC, iommufd_hw_queue_alloc_ioctl,
+		 struct iommu_hw_queue_alloc, length),
 	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
 		 __reserved),
 	IOCTL_OP(IOMMU_HWPT_GET_DIRTY_BITMAP, iommufd_hwpt_get_dirty_bitmap,
@@ -559,6 +562,9 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_FAULT] = {
 		.destroy = iommufd_fault_destroy,
 	},
+	[IOMMUFD_OBJ_HW_QUEUE] = {
+		.destroy = iommufd_hw_queue_destroy,
+	},
 	[IOMMUFD_OBJ_HWPT_PAGING] = {
 		.destroy = iommufd_hwpt_paging_destroy,
 		.abort = iommufd_hwpt_paging_abort,
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 081ee6697a11..00641204efb2 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -201,3 +201,180 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &viommu->obj);
 	return rc;
 }
+
+static void iommufd_hw_queue_destroy_access(struct iommufd_ctx *ictx,
+					    struct iommufd_access *access,
+					    u64 base_iova, size_t length)
+{
+	iommufd_access_unpin_pages(access, base_iova, length);
+	iommufd_access_detach_internal(access);
+	iommufd_access_destroy_internal(ictx, access);
+}
+
+void iommufd_hw_queue_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_hw_queue *hw_queue =
+		container_of(obj, struct iommufd_hw_queue, obj);
+
+	if (hw_queue->destroy)
+		hw_queue->destroy(hw_queue);
+	if (hw_queue->access)
+		iommufd_hw_queue_destroy_access(hw_queue->viommu->ictx,
+						hw_queue->access,
+						hw_queue->base_addr,
+						hw_queue->length);
+	if (hw_queue->viommu)
+		refcount_dec(&hw_queue->viommu->obj.users);
+}
+
+/*
+ * When the HW accesses the guest queue via physical addresses, the underlying
+ * physical pages of the guest queue must be contiguous. Also, for the security
+ * concern that IOMMUFD_CMD_IOAS_UNMAP could potentially remove the mappings of
+ * the guest queue from the nesting parent iopt while the HW is still accessing
+ * the guest queue memory physically, such a HW queue must require an access to
+ * pin the underlying pages and prevent that from happening.
+ */
+static struct iommufd_access *
+iommufd_hw_queue_alloc_phys(struct iommu_hw_queue_alloc *cmd,
+			    struct iommufd_viommu *viommu, phys_addr_t *base_pa)
+{
+	struct iommufd_access *access;
+	struct page **pages;
+	size_t max_npages;
+	size_t length;
+	u64 offset;
+	size_t i;
+	int rc;
+
+	offset =
+		cmd->nesting_parent_iova - PAGE_ALIGN(cmd->nesting_parent_iova);
+	/* DIV_ROUND_UP(offset + cmd->length, PAGE_SIZE) */
+	if (check_add_overflow(offset, cmd->length, &length))
+		return ERR_PTR(-ERANGE);
+	if (check_add_overflow(length, PAGE_SIZE - 1, &length))
+		return ERR_PTR(-ERANGE);
+	max_npages = length / PAGE_SIZE;
+
+	/*
+	 * Use kvcalloc() to avoid memory fragmentation for a large page array.
+	 * Set __GFP_NOWARN to avoid syzkaller blowups
+	 */
+	pages = kvcalloc(max_npages, sizeof(*pages), GFP_KERNEL | __GFP_NOWARN);
+	if (!pages)
+		return ERR_PTR(-ENOMEM);
+
+	access = iommufd_access_create_internal(viommu->ictx);
+	if (IS_ERR(access)) {
+		rc = PTR_ERR(access);
+		goto out_free;
+	}
+
+	rc = iommufd_access_attach_internal(access, viommu->hwpt->ioas);
+	if (rc)
+		goto out_destroy;
+
+	rc = iommufd_access_pin_pages(access, cmd->nesting_parent_iova,
+				      cmd->length, pages, 0);
+	if (rc)
+		goto out_detach;
+
+	/* Validate if the underlying physical pages are contiguous */
+	for (i = 1; i < max_npages; i++) {
+		if (page_to_pfn(pages[i]) == page_to_pfn(pages[i - 1]) + 1)
+			continue;
+		rc = -EFAULT;
+		goto out_unpin;
+	}
+
+	*base_pa = page_to_pfn(pages[0]) << PAGE_SHIFT;
+	kfree(pages);
+	return access;
+
+out_unpin:
+	iommufd_access_unpin_pages(access, cmd->nesting_parent_iova,
+				   cmd->length);
+out_detach:
+	iommufd_access_detach_internal(access);
+out_destroy:
+	iommufd_access_destroy_internal(viommu->ictx, access);
+out_free:
+	kfree(pages);
+	return ERR_PTR(rc);
+}
+
+int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_hw_queue_alloc *cmd = ucmd->cmd;
+	struct iommufd_hw_queue *hw_queue;
+	struct iommufd_viommu *viommu;
+	struct iommufd_access *access;
+	size_t hw_queue_size;
+	phys_addr_t base_pa;
+	u64 last;
+	int rc;
+
+	if (cmd->flags || cmd->type == IOMMU_HW_QUEUE_TYPE_DEFAULT)
+		return -EOPNOTSUPP;
+	if (!cmd->length)
+		return -EINVAL;
+	if (check_add_overflow(cmd->nesting_parent_iova, cmd->length - 1,
+			       &last))
+		return -EOVERFLOW;
+
+	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
+	if (IS_ERR(viommu))
+		return PTR_ERR(viommu);
+
+	if (!viommu->ops || !viommu->ops->get_hw_queue_size ||
+	    !viommu->ops->hw_queue_init_phys) {
+		rc = -EOPNOTSUPP;
+		goto out_put_viommu;
+	}
+
+	hw_queue_size = viommu->ops->get_hw_queue_size(viommu, cmd->type);
+	if (!hw_queue_size) {
+		rc = -EOPNOTSUPP;
+		goto out_put_viommu;
+	}
+
+	/*
+	 * It is a driver bug for providing a hw_queue_size smaller than the
+	 * core HW queue structure size
+	 */
+	if (WARN_ON_ONCE(hw_queue_size < sizeof(*hw_queue))) {
+		rc = -EOPNOTSUPP;
+		goto out_put_viommu;
+	}
+
+	hw_queue = (struct iommufd_hw_queue *)_iommufd_object_alloc_ucmd(
+		ucmd, hw_queue_size, IOMMUFD_OBJ_HW_QUEUE);
+	if (IS_ERR(hw_queue)) {
+		rc = PTR_ERR(hw_queue);
+		goto out_put_viommu;
+	}
+
+	access = iommufd_hw_queue_alloc_phys(cmd, viommu, &base_pa);
+	if (IS_ERR(access)) {
+		rc = PTR_ERR(access);
+		goto out_put_viommu;
+	}
+
+	hw_queue->viommu = viommu;
+	refcount_inc(&viommu->obj.users);
+	hw_queue->access = access;
+	hw_queue->type = cmd->type;
+	hw_queue->length = cmd->length;
+	hw_queue->base_addr = cmd->nesting_parent_iova;
+
+	rc = viommu->ops->hw_queue_init_phys(hw_queue, cmd->index, base_pa);
+	if (rc)
+		goto out_put_viommu;
+
+	cmd->out_hw_queue_id = hw_queue->obj.id;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+
+out_put_viommu:
+	iommufd_put_object(ucmd->ictx, &viommu->obj);
+	return rc;
+}
-- 
2.43.0


