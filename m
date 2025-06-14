Return-Path: <linux-kselftest+bounces-34987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E54DAAD9ABD
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 09:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8CDD189C3E5
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 07:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE05620B7FB;
	Sat, 14 Jun 2025 07:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bGY9G/wy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A52E20469E;
	Sat, 14 Jun 2025 07:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749885337; cv=fail; b=QXrWd7oGoYYHDMV/W6KSi6CqZf5NIyNrQo5m4+jMDfsiDBTG/NH8zBHn19tADImLLlHdN905E0OnBiloN49BzWsl0uFeEfj7kaTFai4uQosvYH8wsZve185rUXGRjSPU3laKQ+50zple9Hz9Su13uRZeJ0NVcoFJrqcsoFH4Hbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749885337; c=relaxed/simple;
	bh=QsEHdJ5cMwoMeq8AdUvoahmY1jfT8zpfUhf5bEWUoNY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EZlMVEj9Rb3x76QOhD4Jpp4P1T7gybzTYShnmYes3I6oOcLPTiv2K4UFdXseL0mcUIdMoCCtazN22u0K6f98f6ZgR0oKYm33aWjAFYLdpwbZf/gmo3ex9v7W97ra1NbImOcjHxVbUpRawEdKLBCqJXNi/UBtVcjH2Q5oCaWtGRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bGY9G/wy; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6IwKZ3uV/kVJdrkKPy9VyzXrgZdPDTFW/uHA58W67si1sL/Zq5Wn34vUpGD5Tec5EuGQRWpA8ML+FLAA2LVL/OY5tbY9KzsJATzF3sxpBgpkUlVFc+hloDhqMb64TGZgiCh8es0zkpv22kG1DDJXvTW1IWko/Mb21x8jmQfKm6yrwMfrhjjXG+04fBnnhudh4pogDzFZ6NbN7u8vt+x/lSAn4i6/OICrAEWXleretcLt74uuW0oF7J7RarcAUvwLqdpetBZsU02gCYcQjsXbmfo+MGOqxY5gTI3szoIK1RKpHtWUCthz3EEklJMhgP4IFQ10ttb15C6ETw6K4CuOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBthVPf5aH8HpaVRMqmXjL67RRDO4ldfM1hMGx9TPu8=;
 b=Y2HPXl2AF4FY+otkLHGELCnsd3RdN/OrppbRdvM4eR6+FjPyzIanPfraoQoRPqCqu6TQ/Fmpn4zi1mOxKAlnrW1PjjFCKfIf2MfGfhFA1oltZ7mJtOS5dHebt+VcCm93OZkfRZF2mHeKtSHCgUxqb3xywmDC0Ji1kHHY7r3oBMVZcYm7ATa4emdw7Tl/orZU7KwX4XsbrIZH63HA14SxUBOWui+mwjtl+N9zuTN1WAbKV2z9eNQuSY5d/EXPwE05/S1YcSQLyy5P2oOscGWIyO9P5kBmhVzGGju/MrJ+tgS0aS40P0e8Y4AQWnvT9W0ibkiac87pUYRQhg1W495mdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBthVPf5aH8HpaVRMqmXjL67RRDO4ldfM1hMGx9TPu8=;
 b=bGY9G/wyrF3GYjuVHIOgaCiUwj0vtT5bz3J0vV6ixoROXytuyawIYAbxo8lG4VOzJt8s4aw00TSk8n6iuCFKIwUKq0B8wtyP1ZVMlJ0dtQ9bda6dNFBaYNgV0U/5+/nS/tP1amufUVCmEIo/02nK7Jj7hWK7U7+iWOr1gScscsuLW1JNaVj1JyE4UrKTP+PzWFqSws02NlJy60+0stAo/+a34uVnyt9+VNWckZLoK1cTVzHbA48nVC4m6rnKxotzWhaB3dLM/KP9IdvwuQMmS1jknT06OYIdSC3dqJifiwZ7CpFe9TZk8qYI3K9vv1fqTwg4X4Hg+TbjNwKTmhi32Q==
Received: from MW4PR03CA0331.namprd03.prod.outlook.com (2603:10b6:303:dc::6)
 by DS0PR12MB7677.namprd12.prod.outlook.com (2603:10b6:8:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Sat, 14 Jun
 2025 07:15:29 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:303:dc:cafe::62) by MW4PR03CA0331.outlook.office365.com
 (2603:10b6:303:dc::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.22 via Frontend Transport; Sat,
 14 Jun 2025 07:15:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Sat, 14 Jun 2025 07:15:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 14 Jun
 2025 00:15:16 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 14 Jun
 2025 00:15:16 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 14 Jun 2025 00:15:14 -0700
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
Subject: [PATCH v6 10/25] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC ioctl
Date: Sat, 14 Jun 2025 00:14:35 -0700
Message-ID: <7dfb002613f224f57a069d27e7bf2b306b0a5ba0.1749884998.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1749884998.git.nicolinc@nvidia.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|DS0PR12MB7677:EE_
X-MS-Office365-Filtering-Correlation-Id: fa2f45ff-a1aa-4532-05d8-08ddab133e59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5PxSXnu+Z8jNN8uWZyY0vxaVbNWt484iy85O1VLJj7SQPm/XeH/veYqCx6cu?=
 =?us-ascii?Q?MFiEdiaf7aXE5q4E5T1F2UBZf+sXIU9zz9WZRJIwl+2W6kYj3TpOs8CstzgI?=
 =?us-ascii?Q?mY7Rb8348qvy8F1uMMEx1disXctedY+CIBO6uuKocRHOU0R6qpkp1rQaLGJV?=
 =?us-ascii?Q?5hWN4dFfqJ+qas1tzptDns5S6QGcbzCtnEE4Qb4ovVpDa9Co9RKG5dSVRASJ?=
 =?us-ascii?Q?BuyZ5f0tODIIAWuWS47HANnHTLsGnskIDSWUf7EWkke/JbaQaG8U9suVe36R?=
 =?us-ascii?Q?+2TAXMSy3wRBd3BKTElxwTwtlXOxdkjC3JKQL9hkYMp2bjpW34tcve+H6qgz?=
 =?us-ascii?Q?Wemx/8nW8uFbHGRYs1xzjIFpHzk30UMAF2x4dwRExLPaIgEFuTk1PYoXV6bA?=
 =?us-ascii?Q?Lovy7oMP3mT3OIwSfVhlQAm9s109LgMMax5F4HgO+nCKVgPzDSKDfe4//ITr?=
 =?us-ascii?Q?HinN/3Sr0A+WLChjvpyhfcW6U8bVFdX+T2szgHCoWHjMQ9MV6cWdmwT/V2ra?=
 =?us-ascii?Q?+zyZPnevHBMSNLfqKcQhzeXET7Mnndg792sZA28ODd/6uO+J/Qz2AqfW4MUh?=
 =?us-ascii?Q?And2wYGBOTifXFZEoCZ6NMht+/pgu4O8cAdjtyHax+yQDIx28lUbdSc6vygO?=
 =?us-ascii?Q?8KEX0o3HEIQWedgsXuwozsG6Jy00uKxGAKE3tne73I1U3HQST5ODER3argAc?=
 =?us-ascii?Q?/DSHNR9V2QKu89Dt1LGoe/dEOFuIGlYj0n10jCQarkG72Q9a91AcmssuFHvi?=
 =?us-ascii?Q?xyktUi7nPxi/LH/RWf5blTp9qtZWYJPnrKDkrm4PIxZJaZlbv78Inh2GkoYR?=
 =?us-ascii?Q?OweU+j0qcWzOOJfZzJ1Izp6y2DrlM95YBv85CTb6JKuu/nC9PjvaUO+npTib?=
 =?us-ascii?Q?fdSdkLYQny+oCXg4wzDEZlCgkMyj7rkD3I9A4z6ewprZb4HjFLJ7J+HY7nBZ?=
 =?us-ascii?Q?ubYp3gWsLxcG3Eynwim66+kTSO7sSyLS4xCs8cpmTb/sE9S5dLPMD7dG8VY7?=
 =?us-ascii?Q?hnwnjPLIdE9al71mfyXA3Hg5Z2WKotKoR3AtZ+adrAPUx8Mj4/TOmf1jR4Z8?=
 =?us-ascii?Q?BtgrS8ttzegwutvWi/1seNukRMsZ6repz+2Hv0VE0v2IgUneHNcakIb4fQZI?=
 =?us-ascii?Q?uY5nk+99hbAw7R2QZTm/i3A5AEt+lm3Z++x4BI+ulREka+fASV7zeQ088nd9?=
 =?us-ascii?Q?GDUeDvexD6WxOTh3vMGOukHO3sw0bpH/5zwP7NrMcUU0MRI17wX0b/skf/ur?=
 =?us-ascii?Q?uHDID3ZBDf35EqQGnJ0ljh0Ee/mPOEWzM5D+pgzKBDlIcbNAirfXGSF9Odse?=
 =?us-ascii?Q?YO6Jh10uXoFtkYU72sd2qKxsnKYdVrNNkIXRaPuqzPUpb3er+KnbAnLDaX0L?=
 =?us-ascii?Q?uI6mkAWheTl13X40FjLIxoMF0O6MK436PhXahrr9ldplV4oFyxFNgoQOBBwb?=
 =?us-ascii?Q?8hc47Yt87pvH44e+8yrGn6wQY0iTU2sBXzUD41E5hVeenksZpl2Y9sUEzVFN?=
 =?us-ascii?Q?0CuBFVlMjprrMUQTmMGPd6vlp8wO5dTb5SJe?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 07:15:29.4240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2f45ff-a1aa-4532-05d8-08ddab133e59
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7677

Introduce a new IOMMUFD_CMD_HW_QUEUE_ALLOC ioctl for user space to allocate
a HW QUEUE object for a vIOMMU specific HW-accelerated queue, e.g.:
 - NVIDIA's Virtual Command Queue
 - AMD vIOMMU's Command Buffer, Event Log Buffers, and PPR Log Buffers

Since this is introduced with NVIDIA's VCMDQs that access the guest memory
in the physical address space, add an iommufd_hw_queue_alloc_phys() helper
that will create an access object to the queue memory in the IOAS, to avoid
the mappings of the guest memory from being unmapped, during the life cycle
of the HW queue object.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |   2 +
 include/linux/iommufd.h                 |   1 +
 include/uapi/linux/iommufd.h            |  33 +++++
 drivers/iommu/iommufd/main.c            |   6 +
 drivers/iommu/iommufd/viommu.c          | 184 ++++++++++++++++++++++++
 5 files changed, 226 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index e6b1eb2ab375..1bb1c0764bc2 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -637,6 +637,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_viommu_destroy(struct iommufd_object *obj);
 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_vdevice_destroy(struct iommufd_object *obj);
+int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd);
+void iommufd_hw_queue_destroy(struct iommufd_object *obj);
 
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index d6aa2a5eea9c..b38c6631ad85 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -119,6 +119,7 @@ struct iommufd_hw_queue {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
 	struct iommufd_viommu *viommu;
+	struct iommufd_access *access;
 
 	u64 base_addr; /* in guest physical address space */
 	size_t length;
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 971aa19c0ba1..f091ea072c5f 100644
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
index 28ea5d026222..506479ece826 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -201,3 +201,187 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
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
+	struct iommufd_viommu *viommu = hw_queue->viommu;
+
+	if (hw_queue->destroy)
+		hw_queue->destroy(hw_queue);
+	if (hw_queue->access)
+		iommufd_hw_queue_destroy_access(viommu->ictx, hw_queue->access,
+						hw_queue->base_addr,
+						hw_queue->length);
+	refcount_dec(&viommu->obj.users);
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
+	int max_npages, i;
+	u64 offset;
+	int rc;
+
+	offset =
+		cmd->nesting_parent_iova - PAGE_ALIGN(cmd->nesting_parent_iova);
+	max_npages = DIV_ROUND_UP(offset + cmd->length, PAGE_SIZE);
+
+	/*
+	 * FIXME allocation may fail when sizeof(*pages) * max_npages is
+	 * larger than PAGE_SIZE. This might need a new API returning a
+	 * bio_vec or something more efficient.
+	 */
+	pages = kcalloc(max_npages, sizeof(*pages), GFP_KERNEL);
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
+	/*
+	 * FIXME once ops->hw_queue_init is introduced, a WARN_ON_ONCE will be
+	 * required, if hw_queue_init and hw_queue_init_phys both exist, since
+	 * they should be mutually exclusive
+	 */
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
+	/*
+	 * FIXME once ops->hw_queue_init is introduced, this should check "if
+	 * ops->hw_queue_init_phys". And "access" should be initialized to NULL.
+	 */
+	access = iommufd_hw_queue_alloc_phys(cmd, viommu, &base_pa);
+	if (IS_ERR(access)) {
+		rc = PTR_ERR(access);
+		goto out_put_viommu;
+	}
+
+	hw_queue = (struct iommufd_hw_queue *)_iommufd_object_alloc_ucmd(
+		ucmd, hw_queue_size, IOMMUFD_OBJ_HW_QUEUE);
+	if (IS_ERR(hw_queue)) {
+		rc = PTR_ERR(hw_queue);
+		goto out_destroy_access;
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
+	goto out_put_viommu;
+
+out_destroy_access:
+	iommufd_hw_queue_destroy_access(ucmd->ictx, access,
+					cmd->nesting_parent_iova, cmd->length);
+out_put_viommu:
+	iommufd_put_object(ucmd->ictx, &viommu->obj);
+	return rc;
+}
-- 
2.43.0


