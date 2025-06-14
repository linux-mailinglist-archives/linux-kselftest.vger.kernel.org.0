Return-Path: <linux-kselftest+bounces-34986-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EE4AD9AC1
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 09:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6133B6F97
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 07:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09237206F27;
	Sat, 14 Jun 2025 07:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UY4PORdt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397401F150B;
	Sat, 14 Jun 2025 07:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749885336; cv=fail; b=ajr+bVOJIXS2BERC5QFNTfnEcL+rxAMcFhLWXJybSDSp1r6FmBrNTcFH/Fn0qWZh6Bq2KSHiQ7DkgdZfpD5xubhcjsYQPijWPvQ2Sxyn8AKWL0fdLWOtvKgztvjicqAoDeNC1fE8bud2570ao5vDlTwQu3XAxe1TtpLHafjPAt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749885336; c=relaxed/simple;
	bh=Fo9IPPGmVVp7XbvzXneQH0b5t3VrTarnrWycGqeDSLA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DVHbCHPdBKlqBKqdyjiC42rhXsuZ9hESCMdJgfz6Z5HW9UomoqM/DUSxiVZs/DIhtk3yoKSaJwg/Xdea2sQnBz5xyfnvU7olraUvoIyheBVgtYZSIMsWIJTt4HQ+lkU+hhKxD50ljUvFcxBjLOhbrtbMwR4ulfqOzIBlQpnLRg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UY4PORdt; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ynMGGmodJcv7L+1V5AfEU4bi3DU2olKxeP/PLf4g/wnmcjA0j6r5/fpAPW3c510hONxGWs1iCSXrOFtk5eKhMg6FJyMoK2e1/j3VK4eVQVBtNWiOZiJ2pKnpF+jOfb6c/Ihc2FcpStd4DSqyRMDJpyCVaPlkhm3tMsj3GCY0N2cgS/IFrZzuFr65A3cVoyMBhU95H+lgh/ilxwDIt69I8vQJFD8KgPdnUsQ5nkCdbeWWYlsQBHehpN9KTvQIrS1cxqs5lDH5OMUtPfMTpT3e/qcQu7y5zVgnPCjiwloDMqLThf9fNR5mD7e82qj7ZgqUDPYmOmivIVaZyHhcBbwOGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hMFU+r3RLdUVRNgD+JNE0kVRgRja+NuQILBGxUYTyQ=;
 b=m+9z/n81yjTy9KNZl5zJ+KEJxxos7c71izQ9dtGIBMTYWvZ2ReNfxnTxP6xAZgIN+ZlRV58tGKJ+kWZg/G9BAj9hiwX7eJtTioBDZBgweQPmIWmJyyIiwdi8farnqs8P0VYT7bYt9PiR5AqG70eOw4dWSRkIlQDyzZEPGs7L6mZnp7yCdn7IjDTV3SDQpqDft9NLtZq3A++MXbI3P/v/GEiS33wPADZnpK7VOTJyuy4kjcUJ8cZa+pSK52OOHrCHPrzKObLTvFkBJ85uIO2CWADiCRrAz34rc0k7G362alWbUyOTOmltuGgSGGCSZoJrReheDYJU7NORldcOrRR8sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hMFU+r3RLdUVRNgD+JNE0kVRgRja+NuQILBGxUYTyQ=;
 b=UY4PORdtAPyqu4wsSo8Ui5Fj4+8bRruwIyGlmgKG1Cwvh8GQ9dFjP01A9Z+2mqH/rCGI/rohOjVg1Mpe0rlIEXD9Q6dX0f7vT6HKsCYzXlsJbe0hiaJCHNoyGrwok2ivKRiuc/GG+LOlo9Em8vLnm/nkHTamn3TnQINaVwWYwqztqWibfoae7ZOG7V8eCl0sQqap5NrOb2IPHYT8ipkFEGZb55En0pLh8X9KC2izdHepCJbEAJFs6XLXzxoEalt+iNmQP3QLg5pTecreKjsHb/oOF3aqApR29ewH6dk8nyJ86U928PDN4y7LMzSvIrjHGxuzejhc8dtS3pzzVL41bA==
Received: from BL1P223CA0035.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::19)
 by SN7PR12MB7452.namprd12.prod.outlook.com (2603:10b6:806:299::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Sat, 14 Jun
 2025 07:15:30 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:5b6:cafe::a1) by BL1P223CA0035.outlook.office365.com
 (2603:10b6:208:5b6::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.27 via Frontend Transport; Sat,
 14 Jun 2025 07:15:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Sat, 14 Jun 2025 07:15:30 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 14 Jun
 2025 00:15:14 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 14 Jun
 2025 00:15:14 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 14 Jun 2025 00:15:12 -0700
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
Subject: [PATCH v6 09/25] iommufd/viommu: Introduce IOMMUFD_OBJ_HW_QUEUE and its related struct
Date: Sat, 14 Jun 2025 00:14:34 -0700
Message-ID: <c9ce52fdbcc7a049b6e27e93875fba4cbc516220.1749884998.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|SN7PR12MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc9253d-f427-4353-657e-08ddab133edf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7IJyt6iONsZ96W+ocP2nAeIPdJTeKFYNlwlXgv6JHp3GjgXnO7wCQnc/pDrN?=
 =?us-ascii?Q?q+lIuOddWoU8pxOio6jFYiYHjwU7AbKab06ct+0J3Tx1E5fwm0aJIyr2vH2s?=
 =?us-ascii?Q?yvJstk/tsL9V6icZ3LRPF15/Iqp1BViEtUpTkTIU7kyqd26+BkD+ERv2lSsa?=
 =?us-ascii?Q?GROXY8T8yoptQuLWl+/sx5XzwvuTGxjkHe8QrnXeQHxzQK1Jz/4b1efpxp0D?=
 =?us-ascii?Q?sdSu366+wpah//CEImI3tDhL/zOT7ANRNq9Ha3Di0ngNulhahOiAFznFoRtU?=
 =?us-ascii?Q?BxNtTqn/7AiWs1i4up0nrU6L1AJNYFXiClPzNqnw4QeyjjGoxLamv6LT0Xw0?=
 =?us-ascii?Q?Th2SOSM05BgRGdPO9i5OBnU6WKAlVuXkU1OmxQURDWEoMN2QczpdIU9Db4tj?=
 =?us-ascii?Q?ibjY5qNZsfPW+oP0gOzVAtFQAgXwchplgs5iwHnZcuSDz4pE2J/+ID7crv3I?=
 =?us-ascii?Q?EMExf6M7dbhbptQ7OVhpQzEzGH9qqhYWsrsuAnLpcOv7JUHkQz3wT0jtRWbE?=
 =?us-ascii?Q?hce7YWPXaBT47E8hv73GMphSueUEeFmvwHov3SimReA8oeap48AhMcDvmtCH?=
 =?us-ascii?Q?zW79jRIXOwObHvOfAfriVBFn2J6/mZhTVlJw08umDeKS2geM2Aeg/76PN/+V?=
 =?us-ascii?Q?+yxga9/TUVWlXvLyjUXdtmhb3/Z3kTMpBd7MNYxOKnBJqmkZ0YPyUvlgJMOQ?=
 =?us-ascii?Q?gIqrJ3rl3Kpu3ycFgxvtZDEMgixhK7wtrpkgpzst7jtFct3+2EOFSxR/aeOv?=
 =?us-ascii?Q?GqizeNUXrRpV9vKx65mxCMq3U1UdK+Pd9FHl5kMBdo3WybkJM3ErcyXDCeZv?=
 =?us-ascii?Q?LOwLhMs0SOZlW/Z7+gcfcdXXy409PvT2eIHJm7mCtZy1tHwCzHDlcAdo5vxr?=
 =?us-ascii?Q?w3bOpERVpMXOkL4jdUoH8LQeqsEzYDzEQdxr2eAhQlDsuK1lJYQhLrHB/oR7?=
 =?us-ascii?Q?XBWDIlVGnW04au/WYsr0RBLtaQ9SUd9q9euzU9LszhllLLd3zom4CbfoO6nT?=
 =?us-ascii?Q?70MHwE3PxwwsfMj1TScGM+GcCprAYUw0f+OAx1QJIwG7jehM2exvWgeJ7l3G?=
 =?us-ascii?Q?I2mVLSorV4X48zJnJbXxnTLIuCqHZcPiPOSt7jqAg8WSJzu+YT4CSSQEbskZ?=
 =?us-ascii?Q?FBbK/AbMm/UvbSwP15sQ/25BOYYPlMiksU1tnstjO+tkSXxfO9mEf8gwagG5?=
 =?us-ascii?Q?L0fKF2ABgNT6+7gUDEGjrabBHEZhNxAC8iP+h2nRRGxN4MFZojrSVrbHWNA8?=
 =?us-ascii?Q?LcpvBMXlJjhXxBknJFsQcf2mYl2HU/y0RXEJMVss8jXd+orKiS+D1PRN0Ihb?=
 =?us-ascii?Q?LzRn67RELXTIcIKrHHt6vSiOx9LjnNB1dbIcqZ7H2shMb6GgHI2ImtM3Dc4k?=
 =?us-ascii?Q?MVRkCcBEr1RF8SRH8i86AGfda7MyObDO2mqK1p/dk+3WZ55HTPLiLqNLhwQl?=
 =?us-ascii?Q?0OmPOSViVTf8EL7Bn+4i6pp8jZz7kLg2KJuxm3gkXXaq7Gg+QK0eTIqCjznr?=
 =?us-ascii?Q?Q4F/T0Cgp05IVfSo9SwmqQ5p4+ql6sL1B/5f?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 07:15:30.2107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc9253d-f427-4353-657e-08ddab133edf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7452

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
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h      | 43 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/iommufd.h |  9 ++++++++
 2 files changed, 52 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index f3b5cfdb6d53..d6aa2a5eea9c 100644
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
@@ -114,6 +115,20 @@ struct iommufd_vdevice {
 	void (*destroy)(struct iommufd_vdevice *vdev);
 };
 
+struct iommufd_hw_queue {
+	struct iommufd_object obj;
+	struct iommufd_ctx *ictx;
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
@@ -138,6 +153,22 @@ struct iommufd_vdevice {
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
@@ -148,6 +179,11 @@ struct iommufd_viommu_ops {
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
@@ -250,4 +286,11 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
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
index 272da7324a2b..971aa19c0ba1 100644
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


