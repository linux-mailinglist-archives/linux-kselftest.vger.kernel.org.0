Return-Path: <linux-kselftest+bounces-36622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22330AF9D49
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 03:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671901CA14DA
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 01:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D2620C48C;
	Sat,  5 Jul 2025 01:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GX9F8v3G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA331FF7DC;
	Sat,  5 Jul 2025 01:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751678069; cv=fail; b=qBRkARX6XBKvyJIq0prN2d/dgh66pfeHJ6L7R153qIeHk7XGrMGOFJdl7nX8tECHnJBbrgE9YIlpb5Ze4xIn04hPft2t/okqPQMiYL5zyl6eUvvfNfY/sQjNO6e3tR9jsAIF8CIYunyLTpTGv3/O6LDyjyHXHtDlEiI1WDNbVWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751678069; c=relaxed/simple;
	bh=sdRV38YfffU8VpeKJKLy8aD23uMiABTs9JAcT6qZvwQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lPahhPiXE3gUPF4Q4ErIgbwK/jDLGy5fD5Ke27n6xYbBraYeZx8xTBkRZcEdzT5+VXkuefFfpFUudh2nYXrDXzFXesFOvd3AfDdmHp2/x2AoMvRYeABG2v4smMOel6Ila7levk5GW5zrgKt8jHtDIYxWigdrdCRPY57qkqPEjPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GX9F8v3G; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytGouUKzeLV2mtme4wmWlj6qRc9dyow0QBKDEj0kOKBVhdFQBXKZou/rPXhNRXAdjY67cYuW7GLTEZlYyQTjjZBzICiirNvi3HGJZ+nxzPMNVb+KLOr8Bswfj8+JMYaVQBsOI4/4PVvqG0kih7hGSOLeMDY+tUHp3aRVYJeu/LeGZ0V279bUGDzH9dQkgJtJh2378D30v9yu2yOetnm2r9ZGv5Pv4144LO+npbCQKR1nJNMAlQbV5xx0yl7XFnnmnKOobbx/+glZH73iYmAgorwgKvrle31NYGWJ8acRBc3LWV6fSZaFhbXMoYPG7z+paalF56KpF8nclzpP+HRWFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJ+3QmhJEyvGvTTXuFFBDc1ZXP8tUN77scFN3bhW228=;
 b=jres29i8/0Fcgd/hR1xgsv575SxGQXCIeEp+qDEjbpEWQK7riZ0OGSKspovuTkAaHvUjgNf6ehRA3EaXO2Gf10qBpilfE06Pz/a8MowEW1o/zAfsoLeyc33SEFAtke5xidcae7pVZVLOAi3/45819SD14P7X6nu2vlv/JJ77VSZeIXstMQGVMh0nwA77Dzojz/ljSgLZPckJqiSKclpoiLrrk1zcT35H+/zCAX9R36BWWNg6AoVM+aSMJGDSGEykCMYQr8AfKQahyqg09bMQ9oFkDDEinzmBTH60vxAgtdkcmOY+T6kqpyuRfIjTJlBAPv72cCZN/J9NABQ1znlIRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJ+3QmhJEyvGvTTXuFFBDc1ZXP8tUN77scFN3bhW228=;
 b=GX9F8v3GQhjNFgm13Si6vQA6pAEn2K+njGcJCmu+WuyMWsIMQeUk6XaC+nIE+/yVzzaEsRLwf1QmhcjDbbuATOUwLYnfoyCi9r28aHC4Lg7G3U97FfleR4jlcN1jZ3YRJT+P8snjR/s5epcxMsDAvRQ6mcK+aNBCHAsdrrLsLoqpkfMrNKr2CD+2nm5QfvAaLnDtgWe1MT5epS+VcutxeOPvAckw+8jv7ZXMMo0L3t7Rnkog97PQRrHMu84XrKspCW++wz7s7uTH6CFNokPROmctdJYBphkHAGdutn6jBzO7ImACNdQmaBnvsHOBEn1nwgrhAWliKs/Q4/NFuBs/QQ==
Received: from SJ0PR03CA0086.namprd03.prod.outlook.com (2603:10b6:a03:331::31)
 by BN5PR12MB9538.namprd12.prod.outlook.com (2603:10b6:408:2ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.34; Sat, 5 Jul
 2025 01:14:23 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::c) by SJ0PR03CA0086.outlook.office365.com
 (2603:10b6:a03:331::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.23 via Frontend Transport; Sat,
 5 Jul 2025 01:14:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sat, 5 Jul 2025 01:14:22 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Jul 2025
 18:14:15 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Jul 2025 18:14:15 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 4 Jul 2025 18:14:14 -0700
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
Subject: [PATCH v8 13/29] iommufd/viommu: Introduce IOMMUFD_OBJ_HW_QUEUE and its related struct
Date: Fri, 4 Jul 2025 18:13:29 -0700
Message-ID: <40fde2d6d418f8ccda5915eeb9a57c08ce0b46ae.1751677708.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|BN5PR12MB9538:EE_
X-MS-Office365-Filtering-Correlation-Id: 417e6a4f-0f05-4e7d-0773-08ddbb6146b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8KPlqxh4/NKGrX9iJ5DtJvTkE0kTpgevQYMWvEZa80WVtjp6MjcgIJ/in4yM?=
 =?us-ascii?Q?FefIZlAQykRoOMvTeQ9YyhTpInG/AnpLmht9FopUyVfW1MxLzFQbnIjHpm6E?=
 =?us-ascii?Q?PhPi5XZFCI6vDo6CDPqcVgJ+PXMEBRiPKmi346KAfggqrG22T091VwCIbeas?=
 =?us-ascii?Q?kY/nGoKvNgKvSAyI5zDkOpUhhVmH4oPO4Dp7/AIJ0z2Sq3pBZYHWgzsR3eIs?=
 =?us-ascii?Q?ykIWwjsLLyHyUTxoIMWlglEeJBXPWleXWBWQNljQ4BQi1p+qZzhO1LYbc/dW?=
 =?us-ascii?Q?+CjhZWd+/A550J8HtmzT0SpGF1BpXoK6DkJL03ujlUG/GWM3dPpIQSAXtTCt?=
 =?us-ascii?Q?6Nx7oLARsXlgRrC3P4vwPzYGU0LEW6synabj7xPE/dSovLZDSHSO1mRDgHC2?=
 =?us-ascii?Q?0kmI0pKhjG+d333QWvaDWXORZKOZjAKAdGfD26ZKs7+CUowEtbifuEbhf2T9?=
 =?us-ascii?Q?3lrfLEW/gRpc62F4kYqKza27dfplLiQ9tqSdc9YZg8aXttdRbYZ0VXIl3RqX?=
 =?us-ascii?Q?PnjLQYeSLTTV8zVtxMDmPU4pWci5WmlLw+w6vtA2vpZ/wLYr5Bny/IUR2pmQ?=
 =?us-ascii?Q?lFSZ9lWIZGeRilTUEhjN4ihmDmHcW43bpAhRdUAxeevv886L2nTHJ93d0jDK?=
 =?us-ascii?Q?SanEWyYHBlom4oi8yowwNHMpDud405rClWtuWEBGBlaw+02QomQNFn5Rq/A0?=
 =?us-ascii?Q?XxrF/9uy51ST6rrxIbcKvq7iXRUTkDkymE6M5iRGtt0Zsx0oyC0mD0TJYrNT?=
 =?us-ascii?Q?SiHEuq9UQyORLC2G8MCE3nwLdZzC2wpsFMs9RSdtOs74YF5rXo2Xq0/Zqk+B?=
 =?us-ascii?Q?/QaMbnD8/wkwB1A/XNUbrThgNj5nwVHnGqvP7H0tJCGE7fgGVbBflAitRQZj?=
 =?us-ascii?Q?JsV8H/2Ab0N4PZ26v6QBiCrWKKmcFzdE8M/Y+5oncVKt5lfxuVKmtUQU1uNs?=
 =?us-ascii?Q?gxEj8FJKSQ/sfB9Uj8eqmer7K7liyHukz3NIAVwqjOUR7f907z2oHSTl9B0a?=
 =?us-ascii?Q?LT+kHI7VzUq9MiMEr+KGMwAczqn9Ave6Gvdbv3xUj1NDhsrbHfGaMzkPJEc3?=
 =?us-ascii?Q?P/+m7PcM7Y5CoBWBh7zweTR7w/ttIFfG3F6Nr9HoF0uZ9gy5NSaqwfyA8icd?=
 =?us-ascii?Q?4k5UmJ24DdzoDZYFnatnEOZfd0jY48KKVWekRK6CH8lhO78oFWBYmK7gBShj?=
 =?us-ascii?Q?Kv0N74XhpPgntcCQep4ec653DwaapQU0B8VCHChQdqdRAuR2DVNQpFZaaGE9?=
 =?us-ascii?Q?5xpiqlHBWTGJ4LWonqIxZQCxicy/ChhH0tP1UHJFs7r2CjCwudAvBrUM4jPe?=
 =?us-ascii?Q?mZ5krPs402JM/5IjcCubTfmHJSrdbo8/+bHD69gGGquNlNTlMEzLIPSXlBsb?=
 =?us-ascii?Q?GPs+isCYqjqoIMQhF5zavmn3CD8ez5h+HnfxKfLgZxcyiL3tkCs0g8fhgrt0?=
 =?us-ascii?Q?keVSQ5KcUW+Qt5k/QJkPf8WUgXou3tG9PRFJKcsPuvtm6FIt0AM4SWRtaWrI?=
 =?us-ascii?Q?IvQgaSpZtZ8vLDv27ci2xQ6GVWgHZwt8G0w/?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 01:14:22.8517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 417e6a4f-0f05-4e7d-0773-08ddbb6146b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9538

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


