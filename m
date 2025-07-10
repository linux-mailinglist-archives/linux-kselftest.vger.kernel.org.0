Return-Path: <linux-kselftest+bounces-36919-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C794AFF8EA
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 08:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00CD31C81BF9
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 06:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D7028C2C3;
	Thu, 10 Jul 2025 06:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZC17FrAG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E389A2877CE;
	Thu, 10 Jul 2025 06:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127240; cv=fail; b=N1gznW5UvPIgvKKkNOJWmDTQ5AfOXht58yE0p5nYQU/2Ju5CHvRzWij8qTqKgICohyTYfcMtVlZGU4OSQzqPDqYZ4whSfNAhnRZGlUjinzoEvmFJ7q5tDXqOmLV3C9cYu0Lh6oICNFwPPcH6KkG2D2CpD3hzu5E8/pc1q6ZBdMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127240; c=relaxed/simple;
	bh=pAMXVO8Q6pgfvvUgng6YLyujEo/N4fpMJvrISigLzls=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DGAvc1H904YxT12rDy2bgmJNrU7e/zx8NH/zO/XI0l1eC4qTpkc9FHgZ/8a1Pm623u458JfwokXWL2WkHGU1BzAj0E+Cjm8BspVjgaPaqwN0GtCg244AjpdO50zf79JeK8noT2ic649iFWYx8iQUGA21btwelyAdt4XsJ90iuEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZC17FrAG; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bj1GpFOHdIA1TMxW3N2jDdtG2k/GGErb+Qndpdrr5cIM3jLYVHf2CWYaxZ+CBkJMkUFUY8WUBhqC9qcX4XsAY/Na1Us2GnoE5WiP1v4Y/AFgpiRQ/qqqwqIXOv14WUDwwOQROkwVeS8NlyAr+Jg0EBEWuPwsFe8FxFNa/GXLARA7aJQOodI8iqSTZtcSNUdw8BB/jVCR9tGDj55gPfx6XpBvLdc4iqXcuNSmCHdhX4ere7HyvrZKfiTihBN6QJm0ozsKfIsqwVzCN9w5UrcStCbZiPM1Q/l0Cx16b4EuFgkhfqpcYwQyfWvXQZYVY5HBQkJW5jQig5IZz9sNprsPhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKhmEjVohefFqifBxcPk8Vy2F7mQIREO9bbjlZadeHc=;
 b=a63ptSR4gKvjAHuK9FUW/CbTseKhrN8shG6vPb2DkCvPFMkBsicnjIJCN55VWNPWX09D56HW1CsUVw6k/YzAYtEkcby9gbB8SJHmloPr8DlQNAXw1axRiWdgVp4vy1VdjTa1tfMfZCc2ovpQH8f9G/cdGO3VkQXv3VjwBoAVhziPQWf8boFIivahw4pHLUXDtlBzfpq9BDs+O85vORFsiDWlKp9Hmuf60StGQHV8NtLSQqmroQGUgYflvvBeJ0PnvR5V7qL0gdmFE0op4O4q33i0mQibvdHuqs414jHd+hf4JLgpfDKnDCYMV6FdxTnITLiIR5weLl4K5MM+nB0Znw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKhmEjVohefFqifBxcPk8Vy2F7mQIREO9bbjlZadeHc=;
 b=ZC17FrAG+BHt1E/EDW/V9oGDsIF7v+LYEyeE1+qf272SAoCkZ77g+1GHyQpA7MGIA2bEZIcWk+xaZcT6OS9QYzNeRwzX1ZXxtR69LyAF+J1DsQtWK2rNVP2kEJ7+DuixJjk+AMiIJJwsRQZi02i4h1LT3rnHSOuMAuXvldnvIjywxuruyetmM6ERXagoPm0OjUxxfOWwZfHjXz2+rN4HXtnf8vk3U/6DYKDa0UimXV6OCZenpvSGU+FGd79YtBx0CGZ+j9RfYpC+5p/tCPte82qejUoLpWKGdtiVeZzjzwtjEOJmHFMzibEoUyo29vIKcuDaUasrLurY1xd+/ihaqw==
Received: from CH2PR17CA0012.namprd17.prod.outlook.com (2603:10b6:610:53::22)
 by IA1PR12MB6603.namprd12.prod.outlook.com (2603:10b6:208:3a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Thu, 10 Jul
 2025 06:00:33 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::10) by CH2PR17CA0012.outlook.office365.com
 (2603:10b6:610:53::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 06:00:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 06:00:32 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 23:00:12 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 23:00:12 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 23:00:10 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <bagasdotme@gmail.com>,
	<will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v9 14/29] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC ioctl
Date: Wed, 9 Jul 2025 22:59:06 -0700
Message-ID: <dab4ace747deb46c1fe70a5c663307f46990ae56.1752126748.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1752126748.git.nicolinc@nvidia.com>
References: <cover.1752126748.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|IA1PR12MB6603:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f48136-17a8-4911-9f9c-08ddbf7714ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2/eSukthBQYJrJrhi5aERUEUy15fk/WghsP/7N/lBI4XRhFNVIEr7NMesd2S?=
 =?us-ascii?Q?EuUaIHL+rBoWxWkM/0XJJrc46Efzxj9frLaCzsMygExEL9BqdBRLljGCfjJ4?=
 =?us-ascii?Q?Qwr55SUQdbi1LV8+KgUHYeA4iTwJKExJDGWwrpIV+DZnALYlXfziRerjfKDu?=
 =?us-ascii?Q?Fv4dMbF1lgWmAGW45OyNXo/StfGAbTO97PPZuadS1K4h6TXMJpat5zI0deSj?=
 =?us-ascii?Q?P0cT0fii8uMjTHqLx0lE6ebSz81yt1EFtr/6ZYFdJDXWSU13dVrpXlLQpUAT?=
 =?us-ascii?Q?yfKhNsMMMgnaervCtOMLOFFB/LlwQ1UeBdEFkrVu+QdxUiVx5nszsI6mLdoa?=
 =?us-ascii?Q?fvOLruLsmOw0fqXJjzKu7YgT6oS0e3o9GcC0vXub0CRgE9eCMlMklyrqhmvs?=
 =?us-ascii?Q?5bl5QR8Qy3MHskS72qgkChHo/hF6vDBuK4zTNowYKvu/ud14BRJf0SBMcV/F?=
 =?us-ascii?Q?KnbrSMfDBF+kgvzd81fN3ts/eMNa6jV1ZM3R/0GDSAj/warF4Hb9bNd29LAL?=
 =?us-ascii?Q?3CjXNU2a8Uyp5xy/sHoWN/OWzRxCtgpZYhsMaT69gRN4R39BpXGT5AFaGhDf?=
 =?us-ascii?Q?CTg/AEjb3sIUuIBNmXwZuBOJPwftz9gWH+Q+vnk1xD/WspKW3xpPyUJkMUHX?=
 =?us-ascii?Q?MYeeYHaeZS8kcFjTWMTgUArrMK0CS2RLsWAGwgi+UEp70G5OF84iyF5KbufG?=
 =?us-ascii?Q?O4nO5Golc4bdzuT3Lj8goL5ELtCont5yXSBJ88y8t8aL+x4WMYC/8w54SeXz?=
 =?us-ascii?Q?DP5zQ7HGK1zX/eCo5ZuXrHt32wXNqC7QoB7oe3QpVAykiARv+NJ7tJJxENyG?=
 =?us-ascii?Q?Kd6uX4Tm8LHCXt3DYgrKxZmQ3zWveD4iS94wUzO2f1U4HExQd1EjP6+fEqpn?=
 =?us-ascii?Q?6dYj8+/M57urqO115jBAdQTT/loGqlDjzLmHCdVQuIT/51qG6nPRX6KnK4+j?=
 =?us-ascii?Q?lOL9pl9heD/H2aGGS7IQOhxCpyl0T+XSiVZ9yTWv59bKpVP+C96tMFZuTRC6?=
 =?us-ascii?Q?yj1cgtg2k297y+7PHG4Lghu+p+khmQcwy/CTgR9PfVweZDNlcfo7b308nxal?=
 =?us-ascii?Q?ZVaM3f86vpRm+mVNmRkMLnSTpEKJvQ0tl+XZZMy+pV6pXNuczD4sEyUlDZPN?=
 =?us-ascii?Q?P2DCxSH5YdCz6+GR5kBrLjAcFQDyHBRASHu+QSQYFFWib6CZrLkpO7d9c678?=
 =?us-ascii?Q?N225R0RETutVTS4gOkKYIB16se8YAtzR884DOjI5nO5p2Vj+lmFAQCyRDwnO?=
 =?us-ascii?Q?ng0JqF2UCdMbhiHPEhlXPYhpiTLbH8B/oQZ/qxJYiulOlgfy4pWZIIrxzXje?=
 =?us-ascii?Q?MOsTovT+hvXUVJyWEZvIkhgIChuc+9QCsjGRfJ3eNvXTbq3u5UVnsp48oHxr?=
 =?us-ascii?Q?bbPfEFKG9bLZMRsZJfDkHace9iRKk6O+w5wZlJQYph/Mxjs3xkAQoHBlSVe2?=
 =?us-ascii?Q?5uvmqpPCSHOKCoeg1t26/bkkhRwfnrJ5ui4Qq/0z2dqmxe8wdYd5Au2HBohw?=
 =?us-ascii?Q?okWO0e1zoakLZEoUDYYRqkHyCi2spQDb52wu?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 06:00:32.8232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f48136-17a8-4911-9f9c-08ddbf7714ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6603

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
 drivers/iommu/iommufd/viommu.c          | 180 ++++++++++++++++++++++++
 5 files changed, 222 insertions(+)

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
index 081ee6697a11..91339f799916 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -201,3 +201,183 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &viommu->obj);
 	return rc;
 }
+
+static void iommufd_hw_queue_destroy_access(struct iommufd_ctx *ictx,
+					    struct iommufd_access *access,
+					    u64 base_iova, size_t length)
+{
+	u64 aligned_iova = PAGE_ALIGN_DOWN(base_iova);
+	u64 offset = base_iova - aligned_iova;
+
+	iommufd_access_unpin_pages(access, aligned_iova,
+				   PAGE_ALIGN(length + offset));
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
+	u64 aligned_iova = PAGE_ALIGN_DOWN(cmd->nesting_parent_iova);
+	u64 offset = cmd->nesting_parent_iova - aligned_iova;
+	struct iommufd_access *access;
+	struct page **pages;
+	size_t max_npages;
+	size_t length;
+	size_t i;
+	int rc;
+
+	/* max_npages = DIV_ROUND_UP(offset + cmd->length, PAGE_SIZE) */
+	if (check_add_overflow(offset, cmd->length, &length))
+		return ERR_PTR(-ERANGE);
+	if (check_add_overflow(length, PAGE_SIZE - 1, &length))
+		return ERR_PTR(-ERANGE);
+	max_npages = length / PAGE_SIZE;
+	/* length needs to be page aligned too */
+	length = max_npages * PAGE_SIZE;
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
+	rc = iommufd_access_pin_pages(access, aligned_iova, length, pages, 0);
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
+	*base_pa = (page_to_pfn(pages[0]) << PAGE_SHIFT) + offset;
+	kfree(pages);
+	return access;
+
+out_unpin:
+	iommufd_access_unpin_pages(access, aligned_iova, length);
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


