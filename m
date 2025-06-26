Return-Path: <linux-kselftest+bounces-35900-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 163B6AEA6BB
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 21:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10A411C28908
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 19:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1084B2F4A0D;
	Thu, 26 Jun 2025 19:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LvbeqBgh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2053.outbound.protection.outlook.com [40.107.96.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7572F433F;
	Thu, 26 Jun 2025 19:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966548; cv=fail; b=HfhPjNAlt4xYdbMyYgqfRv/cjrUga9VdZSddHESyOI0KVsIkWxEohexnB3CPKByLvg3yBqcHB/mEeYSsMVd3x12Z4MoGV9JIjDhvbkLRgxB4T5Noei/vLCcwebQGCfCea72Yhk6RRVyH51mDHyuoZTDNZm0CJa6sFQzhAWD44e0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966548; c=relaxed/simple;
	bh=YNYGeBRBSEIudxrv2+ou4J44dcx1D3Uc9lJUQTp3qHs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sqaXBslCe72/hD39JO3EVDFUcGuu53+qCPvDJ1VOZGx217vUwg5lraPvEu7H141qnL76xgfGjlL0ht5eqyRzJIg+bV8p5x3meQAR1stqKLFhmJ4CC0kOMqQVe+5GcHTbkE/c6trC5pBZKRcZ5Y245uL3kyD+Yoxjsnjj5dEhYLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LvbeqBgh; arc=fail smtp.client-ip=40.107.96.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZ9523EoF+q9nIP7MU9Dh0Y+qIMneKmRyTQyhI7TL61QrB5ElNVlfEA+NM5BwrUtWpG7nOGdO1tCkzSfbYfj0GibdjsTmQvOpSIsj+HjMeQXV1NS5v4v1BdFo+p79RXfwcNL48WYAoh+oKGj23xNyzziEM0ag6VlWC5zIa4kWYwIGV0GMTwggkjYEcuDcZ47EaXXypYw6W8mECnbBj0o8g4OsomtChe3hJqWhzmMiLUnejXJm+KE0Tdhd+uqWe31zL4Bjy5RSsTwHvL4VGuwuXR7vLk002m9300qq0uB1atln+NKbVLF33WPoIpl7hhmbF4VZWJkrGhD1ttnVdnrSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZaLWdG5k5vnmVHyObanoRktV+fNZANa8Gc26New3Uow=;
 b=HA45Bsp5lBVVB1toREw7uEAptPtsiIgXn8p33lsMDgGvtmR3vzQ6HgHMigCBOdBUR7ed5n7qfYs5QlzGif2kT0BYziVPLnzO/uNnT/v8pQjQEsvSCSMygoDVCzYI8CDewky6rqmEd/GB4u814s9nSfR5Kjx0lt600xHKLDUMjxoEvqC/M+udntk6Nu4XVW5bXj3AawxZ+JT4YoG1DNd+pEo5y8pTgws9qmKhDF92Kr3DFh01dBaahV+oTRFuxHU2YTRPZYqQI1kWoN+Tqy4eu1NcoI72mzaq9gSwPYGrHWItefihIV76ec2dBaayzkx/5REgRi0xawdBoQ8TKn4fgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaLWdG5k5vnmVHyObanoRktV+fNZANa8Gc26New3Uow=;
 b=LvbeqBghyQcEs8LxUaFST7cFWZmmHN/2ehB+7NDNreLMFdtTpaKRUbLIUHRqNdGzZeG1X6b7IqVayXZrRy2pprORbCL/vUQ/NFDtcTnIrmVaRT44gnrODgMbiS4lhyZ/UcPYkHDuTbhmnuFt5JCNd71CNISEXC2ZcxLKF3fzhr8SS1E5oIUV42NkMXYioUN0ve4slXtnHfoGrp0KFrpnO8cQd+O1AphLAla94EusCJYW78q7/qQyZiyKXeC4la6LHXHyEIaaZs/56hNkHlPDbrKc0UfEFvz2+FoG0pyG6cwvtevR/+iA5zgW0V7ObcvBO2h3Ex+okZyx34I64/2JHw==
Received: from BY1P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::8)
 by DS7PR12MB5767.namprd12.prod.outlook.com (2603:10b6:8:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 26 Jun
 2025 19:35:43 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::ee) by BY1P220CA0012.outlook.office365.com
 (2603:10b6:a03:59d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.21 via Frontend Transport; Thu,
 26 Jun 2025 19:35:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 19:35:43 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 12:35:23 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 26 Jun 2025 12:35:23 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 26 Jun 2025 12:35:21 -0700
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
Subject: [PATCH v7 12/28] iommufd/viommu: Introduce IOMMUFD_OBJ_HW_QUEUE and its related struct
Date: Thu, 26 Jun 2025 12:34:43 -0700
Message-ID: <94490b0bf4e986b7425269f1deb7618907d065f1.1750966133.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750966133.git.nicolinc@nvidia.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|DS7PR12MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: 147efa92-d683-42a5-c123-08ddb4e8a43f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mIkqlpRsJ+tgswYhnAqEy1aW8sJD3kG7b7JJZpaSTHZRWHQNKz/PPFhUwo+r?=
 =?us-ascii?Q?P5AOMnLfDDmUFUSsqlpgD3gbvF6SiVIGKd/4CnMwOSo4qbe+FMkYpjUPg8Dj?=
 =?us-ascii?Q?EXa9Vxz1MWLZi0U9m0UMdbc1HeiqIz1cQPoNVP2ZpSReRNkPxoAAuRt27SGl?=
 =?us-ascii?Q?h7iqUtrTJ/UQt/OFXg+Pn1J+kW9eOssN+uMaCU086xfZ4v1hB10fAKdEoy3s?=
 =?us-ascii?Q?260RMOEyVcA5sVB87TDrW0bG435tce+m5Nd1EO+U8otPDO85MPRYhIGE4TxM?=
 =?us-ascii?Q?V9jDLFchx2Xi5BMLKaJs/EyjI7Z9bxLLO4rMGGDbDKUgpqRXsUWYdqXl7CmY?=
 =?us-ascii?Q?lhrK3zq0WTaQm9OOvUEZ1SQNTF6ZuLs0/UVTox8WyTfxDcuhFo8e6hHYBjeI?=
 =?us-ascii?Q?HMHi9rVABbDqgq7zpbPNFKLp7LGqdZNvESVbCpNPbtqr6FrTm3Va6rLtPDh1?=
 =?us-ascii?Q?+sprRwVcuSJdAcCQBxrR+pIq3Ucd7CHx8MnOxXyJfFolQEbhQIWcCpk42yau?=
 =?us-ascii?Q?5uMBDp8iGHDf/fCWvE7J12tc2/j/Zkqlv2xGfoJlrz7tdJdQy0v4ehOgF3I8?=
 =?us-ascii?Q?vndO0Z6SAfTJ3WcoN+I49osrW2lH8tGm9CixjUg0OuuLfkcjLmsCXl3yif1k?=
 =?us-ascii?Q?02NeV0JJLTFpTQkcExJ3wKlPeC1t64bTvlL1hflgOow/6lgW7FoCTJZNSfQ7?=
 =?us-ascii?Q?V5TwuWi//zLVALEJrBsrH220NZiP/P28VFyama/Gjw4FK5bRfhGK2u4qWMyw?=
 =?us-ascii?Q?xcZ3FiJVMqLGA72EiVnG3Fe9elpiCHz/vjXzkZjpfcFw9YJVL5/QVRkZHMtU?=
 =?us-ascii?Q?XPZ0/2Pt1ivUCAEGkwi2/EAfnNL494K5ME2At1pHfOqjdXE+nVFz5TxnM6hP?=
 =?us-ascii?Q?jKaIP2a5jS2Iw1mOlQWeu5GYYAibuQOGfPwtTBJXt/m0v5Lm3CXAPO1n43dW?=
 =?us-ascii?Q?KoK5vIALSFWkbfDEAmDYkfxuSXsqd86MWHiMAcWW/KdhrT6TxLFTbrXkWml3?=
 =?us-ascii?Q?8XHOhU8ZccVpFtktDbFDu4e6HrRxJt7+33VQLlWB/40W3oOYglIN2otMRpEK?=
 =?us-ascii?Q?XkThEasWYfuEM0VlWnwYjCGH9W1fMeJ8hMMd65XfaZCkWDvLunufjgJnRLsy?=
 =?us-ascii?Q?t7TIusyzEsL86IXXUW0Aq6fZl81HIHqUjtCoAlwXNj5m1SFZRuGyaecG1Wbf?=
 =?us-ascii?Q?QIrSrpb1aSfzMJU9Uj+OVMUg0LvMjbnmcYQJFb83VfJxgJZ31r2I37SgO80V?=
 =?us-ascii?Q?F1GhnQcNuioNRJBMnE5Nq16ytJXChmegcKjMzv14AdVyfZicIn2ISRnTDJsY?=
 =?us-ascii?Q?+R5uDeH5+RtPqHT4ljE//AqEMv9cZK3tl8o93IsHilTmTeitmpKVc3JbsXqB?=
 =?us-ascii?Q?KC3mkqrv372IPWVoTWlc2mNOu305kjJMWUu9nPG8C5L22OMAk0ce6/qtxBuw?=
 =?us-ascii?Q?z6A5ZG1kAPpzU2vETu0bvc5bnnAfEKwRpYk4moYHiur3sLGQ7DdZ4sTKMuOE?=
 =?us-ascii?Q?eopjPwV5m6Rg0lUl4hHceU0cuQ4WB1Ir4yZ0?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 19:35:43.7265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 147efa92-d683-42a5-c123-08ddb4e8a43f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5767

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
index 3709b264af28..808536ed97e0 100644
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


