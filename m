Return-Path: <linux-kselftest+bounces-36917-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5BFAFF8E4
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 08:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4CF560DED
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 06:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CA128C030;
	Thu, 10 Jul 2025 06:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UK7F43cI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D41A28B7FE;
	Thu, 10 Jul 2025 06:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127239; cv=fail; b=qtohZCG9i5usRxJ//mR3UpF4Q0yjF6UM4IlP22jw7Q0BQ0tcM2pV89eM/d9g3cD5RKW2T5rjuv5OCDzvypYdVgMs3mVq2Rv/bIDjRvb+LzqQr5YZ/W3BS2Bd1FTYmtC4HeH6gA+OSnJQ4OtlL/GB8Nvu3D89wLGQF+M9PB7r6qA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127239; c=relaxed/simple;
	bh=sdRV38YfffU8VpeKJKLy8aD23uMiABTs9JAcT6qZvwQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BEUaV4TgHSmSSFt1QwtzhX3ImfAiDm9nk/okXX8am+fZ76qzsveL+HVQ+iQOtuqwGqHlTUXhZ5OzWToYqc6gNE8z2B+qldY4F1146C8Ra3dc1x9fu1TPYMtIDE3xo5eU0HPHD22yMY3qQUC0e+05Va0qiz9sy4juOzdAT8RZ4cU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UK7F43cI; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ze29irV4E6rIhwzVcWIFfM90kKy0qo68X4ftyRZvr7uMlp5t1KedBVijZgrm1mfBceovQhHcQo944mpK7lnXMAMd0XbFscdEQamcWr1btAFsd/KeReQbL0meZ7eaH/qLJP3+W5IIBPWs1XcNn3qCutQzJnGHjk2CcQyEXJxF8/xUuzO77oFhzvy696Y0vJZCJu2SZ/cGsfkiJLsPI5P50Z62lm9AKj0PBwVhejPHNEn/JREKNd451HX/UUKpSk6yqm3554Q2gR3kOyc7IGS3TzIgVv6TK1A81EjxQKjL/RsqRBRsjF+DOQ/Ipj5/8CoN3AUhz7FdtK0eLGoT4Y/kXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJ+3QmhJEyvGvTTXuFFBDc1ZXP8tUN77scFN3bhW228=;
 b=uUwxLEamu2Rw4WrNc6Qc3rEKLXRV0hZ6jw2Z8yN4TZ8IMZM4k+mBKwcNwjMs2L9QbCwIf+hERb9/NYfvRvNaXN6THQgfnFp8mhHO/Vj6Mql5fx28+ghWAy4O39GuunABUtxzkniyfpNIiWRTG4wKIkZqYL1wLxdeE72aWNglWUtcFscIzp6/roSLcbKZtZKQk1Rfso/nEYK7nlH1J0aa6x+ig8qIyUNTc2NYDyzNqrLhL2yFy3MDuWy8q8UM3010n5ghB8KaXQLzBiUPcnQ1icwhZvO+tiUSIm3UxGsdaDoUQL5JwDQzdkkzVN0RfP5IUSmQAKODMU2AZeWMBqM2Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJ+3QmhJEyvGvTTXuFFBDc1ZXP8tUN77scFN3bhW228=;
 b=UK7F43cIrCMqUlkV4usIAgXaeEkWuoQG+86XGLwoW+Nxao+OufT78Z+nfzITEvK4vs++sWgFh1Jiqvhjl1X//QiJwHIMccSJgrP+qQA8zV8W/YB1RNMD3GloYfvD0zchFQlmJ70lA+ZNhfJ/SL2Wz0HJ4rlTR07SGnC0Bqjh0oqjKtsqU3TFrutIuBDqgdR6vCD/O84mhpzMlvHfkZfT7872f9peFXnFNTHR6xRwzhvjXe0n9/GBC7gXCJWTzpIcG9LG9/orxBP9MuOhUj1zOdUV0F8Bl0tCJnQXL72Qnf5v+B6+UiWEZr5jUdQVvgT+oQPXbysONNPJ4XOHzdrobA==
Received: from CH0PR03CA0322.namprd03.prod.outlook.com (2603:10b6:610:118::27)
 by CH3PR12MB7522.namprd12.prod.outlook.com (2603:10b6:610:142::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 10 Jul
 2025 06:00:30 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::a6) by CH0PR03CA0322.outlook.office365.com
 (2603:10b6:610:118::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 06:00:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 06:00:30 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 23:00:11 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 23:00:10 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 23:00:08 -0700
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
Subject: [PATCH v9 13/29] iommufd/viommu: Introduce IOMMUFD_OBJ_HW_QUEUE and its related struct
Date: Wed, 9 Jul 2025 22:59:05 -0700
Message-ID: <6939b73699e278e60ce167e911b3d9be68882bad.1752126748.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|CH3PR12MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: d8bdc798-be1a-4168-3323-08ddbf7713ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2kbXqclFYo73SP+EgoWQtyrSgZdJ9uZjfRutfGbTm5977lxTjwCYv2P9ZG+/?=
 =?us-ascii?Q?NmVxfZtdmthQ+7Favo/Ua5hSaGE0NtiWJ5yAUzqIlAmYwDdJcqkAWGJMtZZJ?=
 =?us-ascii?Q?luaYN/QsRXOum+P3TeLAk2hVhGU3k9wHl60tBeTfdXj2IGkfJiiddf9n7Lyz?=
 =?us-ascii?Q?RDLUzUucqluHSquE5Iv9HxwDRHkLzX1dvZ8wmH9moEAjtfioIr6ne7ZEJ8OV?=
 =?us-ascii?Q?+vHyURdoIq0lBr818fWO0SglKpAdVV6hk1ScPIdrEx5aCSBKXmbnuf9ukrOb?=
 =?us-ascii?Q?LPo8r89m68qiI2LmYKwDwO4JVjNbqRA6hVDC2qXXU+ieR3kG30ZebV6JGvpD?=
 =?us-ascii?Q?AkAKiC+i+xxsDighUIwrbmTdfWBcn9CiFiCTHQn/Sbwj6E8NiQhM0ZtW/wQd?=
 =?us-ascii?Q?+RnseHRaqFj6rvrkWF3t2teQc22dfcue8JstaB64mWp2+rISHa6OGCuywS+x?=
 =?us-ascii?Q?zDD8pUW6FC4+fkG7bstV2XiLuQdBem8EVvvlBrYwijbRLz2MnnU2AYn4T/Hp?=
 =?us-ascii?Q?zUcW6zUPFHdiZzJXyPJx5qfYFsB6G7FhnHU4bXyVutfMSDs3eBR4PgrO6/gP?=
 =?us-ascii?Q?ILT0DKIG2Oc/4qLJ2RBU9dbKN7B8BPUG6Idd0SCHhak3AbLy3Ju8yD9bc12l?=
 =?us-ascii?Q?4Ov4SHHkfn33tzfWO7TJA1M/8e2FsDF5CUp1keoEs7BykEDs7XJ+qhp4cDK2?=
 =?us-ascii?Q?HIKvkQ7fLXFnBcsE0VMfrlPgf+7ev/jpKJSQnSfV/HMKCe7lneXgHS+mgMr2?=
 =?us-ascii?Q?JyXeDJ2hjP0ouChf1e93bhetZpZkQRzlJaABQ6SgsPEd1oN1SQOVjoxby3+w?=
 =?us-ascii?Q?B9kyeKbpEUUPY++jgyAP6FTdvvsR5Uza57roFj8aBch8kPPnW9qzC6b6OsTa?=
 =?us-ascii?Q?jfbr6u0mPnoNgTb0/U4r4UHr8IAeKDZLIn/TdQ9NV+Hk9UrfIfTFCwMPKJv6?=
 =?us-ascii?Q?opOtP6BsF/ISxiIeBs3//QwdwowQ3uBka2vKXMtyMoDqNjZGxapo8VEsMHVG?=
 =?us-ascii?Q?ZPuMq1R3VJymDUBxQH0BhcmMZctPGDn5ZjSxFGCyqPAVXAieRfAx+aVCKZHx?=
 =?us-ascii?Q?X8mrD1AVX0AY0dPK+gHTtwiRUogCKaL99MvoUqiYOMnr5Z2vfO0EK9OVjGO+?=
 =?us-ascii?Q?2ztDeooiuRGEgvUBa97IO0trymK6+Eer2Eb0zxwo5WZcKb1Neey1mTgne9Z7?=
 =?us-ascii?Q?SR5DHgSyZMzYkxbNnCBpT11jMgrLVaTPjYhbie82EdnuKqGQDyY+FobxnjsD?=
 =?us-ascii?Q?zeou93bO+XIvN4q2HQbseXJq/DfqqsyV/PgBXO7JYX/2EFV8xortEl2GTSWB?=
 =?us-ascii?Q?8lecBsuuN4yumYZ2v8+gE2tTqh7ierua4IJTgvZll3rFGCBlX7U8F0WW3qqx?=
 =?us-ascii?Q?xFBuUhmpWV31iBGAK7IsAMzZHEZ+6CcxCEwSXBRsSKdM3siKi6YQkW79Utf+?=
 =?us-ascii?Q?Qh+9CCcPbEG0TN4i2Zzk9UMduQ0avxYzWoi8VPQ1oQNkMW4SAJQ/ycQQbhFR?=
 =?us-ascii?Q?tibexuEhzhXHdeVE6ZUjA36qIHkIGyHzsTpH?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 06:00:30.6649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8bdc798-be1a-4168-3323-08ddbf7713ad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7522

Add IOMMUFD_OBJ_HW_QUEUE with an iommufd_hw_queue structure, representing
a HW-accelerated queue type of IOMMU's physical queue that can be passed
through to a user space VM for direct hardware control, such as:
 - NVIDIA's Virtual Command Queue
 - AMD vIOMMU's Command Buffer, Event Log Buffers, and PPR Log Buffers

Add new viommu ops for iommufd to communicate with IOMMU drivers to fetch
supported HW queue structure size and to forward user space ioctls to the
IOMMU drivers for initialization/destroy.

As the existing HWs, NVIDIA's VCMDQs access the guest memory via physical
addresses, while AMD's Buffers access the guest memory via guest physical
addresses (i.e. iova of the nesting parent HWPT). Separate two mutually
exclusive hw_queue_init and hw_queue_init_phys ops to indicate whether a
vIOMMU HW accesses the guest queue in the guest physical space (via iova)
or the host physical space (via pa).

In a latter case, the iommufd core will validate the physical pages of a
given guest queue, to ensure the underlying physical pages are contiguous
and pinned.

Since this is introduced with NVIDIA's VCMDQs, add hw_queue_init_phys for
now, and leave some notes for hw_queue_init in the near future (for AMD).

Either NVIDIA's or AMD's HW is a multi-queue model: NVIDIA's will be only
one type in enum iommu_hw_queue_type, while AMD's will be three different
types (two of which will have multi queues). Compared to letting the core
manage multiple queues with three types per vIOMMU object, it'd be easier
for the driver to manage that by having three different driver-structure
arrays per vIOMMU object. Thus, pass in the index to the init op.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h      | 42 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/iommufd.h |  9 ++++++++
 2 files changed, 51 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index bdd10a85eeef..f13f3ca6adb5 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -37,6 +37,7 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_VIOMMU,
 	IOMMUFD_OBJ_VDEVICE,
 	IOMMUFD_OBJ_VEVENTQ,
+	IOMMUFD_OBJ_HW_QUEUE,
 #ifdef CONFIG_IOMMUFD_TEST
 	IOMMUFD_OBJ_SELFTEST,
 #endif
@@ -119,6 +120,19 @@ struct iommufd_vdevice {
 	void (*destroy)(struct iommufd_vdevice *vdev);
 };
 
+struct iommufd_hw_queue {
+	struct iommufd_object obj;
+	struct iommufd_viommu *viommu;
+
+	u64 base_addr; /* in guest physical address space */
+	size_t length;
+
+	enum iommu_hw_queue_type type;
+
+	/* Clean up all driver-specific parts of an iommufd_hw_queue */
+	void (*destroy)(struct iommufd_hw_queue *hw_queue);
+};
+
 /**
  * struct iommufd_viommu_ops - vIOMMU specific operations
  * @destroy: Clean up all driver-specific parts of an iommufd_viommu. The memory
@@ -143,6 +157,22 @@ struct iommufd_vdevice {
  *                include/uapi/linux/iommufd.h)
  *                If driver has a deinit function to revert what vdevice_init op
  *                does, it should set it to the @vdev->destroy function pointer
+ * @get_hw_queue_size: Get the size of a driver-defined HW queue structure for a
+ *                     given @viommu corresponding to @queue_type. Driver should
+ *                     return 0 if HW queue aren't supported accordingly. It is
+ *                     required for driver to use the HW_QUEUE_STRUCT_SIZE macro
+ *                     to sanitize the driver-level HW queue structure related
+ *                     to the core one
+ * @hw_queue_init_phys: Initialize the driver-level structure of a HW queue that
+ *                      is initialized with its core-level structure that holds
+ *                      all the info about a guest queue memory.
+ *                      Driver providing this op indicates that HW accesses the
+ *                      guest queue memory via physical addresses.
+ *                      @index carries the logical HW QUEUE ID per vIOMMU in a
+ *                      guest VM, for a multi-queue model. @base_addr_pa carries
+ *                      the physical location of the guest queue
+ *                      If driver has a deinit function to revert what this op
+ *                      does, it should set it to the @hw_queue->destroy pointer
  */
 struct iommufd_viommu_ops {
 	void (*destroy)(struct iommufd_viommu *viommu);
@@ -153,6 +183,11 @@ struct iommufd_viommu_ops {
 				struct iommu_user_data_array *array);
 	const size_t vdevice_size;
 	int (*vdevice_init)(struct iommufd_vdevice *vdev);
+	size_t (*get_hw_queue_size)(struct iommufd_viommu *viommu,
+				    enum iommu_hw_queue_type queue_type);
+	/* AMD's HW will add hw_queue_init simply using @hw_queue->base_addr */
+	int (*hw_queue_init_phys)(struct iommufd_hw_queue *hw_queue, u32 index,
+				  phys_addr_t base_addr_pa);
 };
 
 #if IS_ENABLED(CONFIG_IOMMUFD)
@@ -255,4 +290,11 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 	 BUILD_BUG_ON_ZERO(offsetof(drv_struct, member)) +                     \
 	 BUILD_BUG_ON_ZERO(!__same_type(struct iommufd_vdevice,                \
 					((drv_struct *)NULL)->member)))
+
+#define HW_QUEUE_STRUCT_SIZE(drv_struct, member)                               \
+	(sizeof(drv_struct) +                                                  \
+	 BUILD_BUG_ON_ZERO(offsetof(drv_struct, member)) +                     \
+	 BUILD_BUG_ON_ZERO(!__same_type(struct iommufd_hw_queue,               \
+					((drv_struct *)NULL)->member)))
+
 #endif
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 04eee77335cf..640a8b5147c2 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1147,4 +1147,13 @@ struct iommu_veventq_alloc {
 	__u32 __reserved;
 };
 #define IOMMU_VEVENTQ_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VEVENTQ_ALLOC)
+
+/**
+ * enum iommu_hw_queue_type - HW Queue Type
+ * @IOMMU_HW_QUEUE_TYPE_DEFAULT: Reserved for future use
+ */
+enum iommu_hw_queue_type {
+	IOMMU_HW_QUEUE_TYPE_DEFAULT = 0,
+};
+
 #endif
-- 
2.43.0


