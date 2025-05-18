Return-Path: <linux-kselftest+bounces-33268-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 332B9ABAD56
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 05:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BAEB17563A
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 03:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65202153E8;
	Sun, 18 May 2025 03:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fVzPnnPO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6854204680;
	Sun, 18 May 2025 03:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747538559; cv=fail; b=jd4ku1Gzx5H1Oo3Z0FbefmPQyxQL3dYcGPY4/g0KAvVHx7ohzyuVYh1cJTdWNfADbErx2Xlq8ylOs2fTXF/FFO2QygOnGtJxpNVg/9dXZ577XWrFaOFD3UcxlZ2aUOr2Ve8Rnu2UtvvKmpfrHQM+vfncSXs+ERYRfwWyVZsVIEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747538559; c=relaxed/simple;
	bh=yE2XerHf8MjIPK/58gi5Gcbdi1Y7CoEDFAoIXmiCTbo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DL2+4vm/gi58nxRZsmUR0OjX2ya0XyVD7VihlPSVL8OuOwqzicZX97jBr7jXW+6tt1OvPYYXpaR/NrJZImYkh2xhmb5zcvZmbqRPl6RWjh3jpYeC64f86tuBjLSMw/ekChA1kazylIbUDUc2sKBcCZMjMDs8oowwG+u7vnycI8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fVzPnnPO; arc=fail smtp.client-ip=40.107.101.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYYH/pqu4gwiyOZXnubrHIHO6pRuzMoQjUp8QXjNMj1PC2yC3MeGOHPNOHkaJ98G0g+TGVhBv4nbg5a40BEflPvdD6H21raB/d8tMPJc2LA9l2mdRi6qJEgu7dag5Gp76e90RU86OeTDI4dyW6a3kzvEJ2G98Q9D0Rj6Yd/LbbTupVZaQe3DOlZu2yXKyb+e3+Iu0/YY9dXVguH4GhFPmpgltazAAHASgg+xQXggvf8Y7ZEB+ksj61AINxgIDE5fLUsk6bC+33YNErnH1IXK6wxTDY3STf6ERlSbUx4wB7o2GN7T7/WCpgt60zJ62W3d4AUI2xlTXtLBexDH6enIgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSXDji3sI+FruRkBIWk9S9cugWUpwa10VvkcKod5Gzc=;
 b=DM+7BfW/XA/Wn3mgWAmDRjwbCYRBG4Q2ustV2bd1s070ogsX3hNC+PEoxprM9weuvLJo0NBeB2RQK1GrHjCQx/KwP51QnfFP9bvdwhNjZzNe8si8cuwXmr0UEzvMYfsY/tFH/X/oFqVmYtmB33Wn+h8ojIypu+UZUcxIe7pp6P/qLozYvyZi0XyEJ9eiluTdT2pFnNfWq2KMZY/hITgp5U44KPx+ast1jx9/wYP+xAvWSAEzkkvWVQ1b+qmrEX7g7rcQQZoro3oH2RtULgZdmyVWbV4qBv8nueHWv9r0krd7GKzv19H7n1OWVVS4RZI0ftIQ49JvHmRENtG8pqVy7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSXDji3sI+FruRkBIWk9S9cugWUpwa10VvkcKod5Gzc=;
 b=fVzPnnPOcusRmqGkQfZu4TU7bScDqmZMcU+SmteFWbQ3nZuQi713ZAOKnP0iYi+gIVXuw1qn7hDhROO4ycBoXareG4oMBe+F/l/yLr6cLrfZ7WaRJ+PdqdlEitUdUCJp7E3wMBVHcZP/zSnSk/PcZwmGuxK51oML1rKgs0jTusH168F0GxVypSgMpVpMpaNhSzZE8jafsONbPiuDgPgruuZpfV+P7BxG4gIm6uRE05G/gqdJMbxY8/LAa1TbQ4d1mweJivaqPBQOoaKN2IdeJYIQ50k/4LU5Oy4XASqJuj1aMMnLm8f47S/TP8/TOMCmVk3XHYwtlNA6FaGUJfbP3Q==
Received: from SA9PR10CA0017.namprd10.prod.outlook.com (2603:10b6:806:a7::22)
 by IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Sun, 18 May
 2025 03:22:33 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:a7:cafe::84) by SA9PR10CA0017.outlook.office365.com
 (2603:10b6:806:a7::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.20 via Frontend Transport; Sun,
 18 May 2025 03:22:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Sun, 18 May 2025 03:22:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 17 May
 2025 20:22:22 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 17 May
 2025 20:22:21 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 17 May 2025 20:22:19 -0700
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
Subject: [PATCH v5 14/29] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC ioctl
Date: Sat, 17 May 2025 20:21:31 -0700
Message-ID: <5c509f092ba61d4c0852ba57b530888ffb864ccb.1747537752.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747537752.git.nicolinc@nvidia.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|IA0PR12MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eeb89c3-1094-4b96-fd60-08dd95bb3a88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KWGrGbFZkUFMlkbyyvwa89lVD9+x1YNZvmnVCj4OiqhbxRXeqIOX1oKsl8jZ?=
 =?us-ascii?Q?UeHUlzFWlX7hUnYGncqrsx3NGNFQYvq+tk4mSrEEVvymebbzvBqgvV0AFTm3?=
 =?us-ascii?Q?nVAmjWmCqXM16pGnbY/hfAijky0MpHjjmjp4DM7yhLdtA+U71etiqPDXu43/?=
 =?us-ascii?Q?hvILIPkhbyjF3BQ2czlkJEEITSp5V33PSX/hL+C8fGOz00PlTZ4Cdih45LFc?=
 =?us-ascii?Q?/eA5V1ItPxq7kplC3zpXpw9z7e2Zd2q0YZJpHtO2a+0hqXIZJDd77We38bCc?=
 =?us-ascii?Q?pRSrkNt4HdesjJ6/GEYDqZlM/UZavf+GQhsiwntGXvtrRhwpXJmx6DaroUMX?=
 =?us-ascii?Q?ZkGSFVHEG9+X2PiemNnW+UUz7J5QznXCMk3bysSgdbgpAtl+Sm197/U7Aq6w?=
 =?us-ascii?Q?fyVuw0+JmywmjlzPks7CuqiVVN0rpaozXKNftYTthhm0FipgUKKrFby5Tdp7?=
 =?us-ascii?Q?Wb50r8D2lvjnlk/sJXTqf2HoZ5WjvMfqh5TuISmLtXyfXWXvwa8Ei3iUJ4Vn?=
 =?us-ascii?Q?0gW6jWsQVoHNWVm7VzwtJxki0kVtCLyHq1hll+q2D4+m5o5y3pCwGjezSuby?=
 =?us-ascii?Q?hCRVOPlLKilVDotkJwAIKPvgtotnoV2s0iAihQYy80VdOWLq0u8yG6+3SBNN?=
 =?us-ascii?Q?8xOOEAKMWSc24DlcrXeYAw9BXeVDoVJ9vz5+HHR5gswtFZwSpRM+vq7I8ucv?=
 =?us-ascii?Q?MPg+t8QDoHzXcUKB8Ut8w9jwMog22+DQ+2G8LW7rFktQKDBa2jseMphuBUBz?=
 =?us-ascii?Q?+Z7KyGJOlcyRaAHrFw8UOQdmLvmHY2nBLoq0C5zrF1Xr/71gib1w07/jv240?=
 =?us-ascii?Q?5YsH7gCZTtXeefZZfVf2tBrhcnBFR/RBeUSoToiVopeDYgG+WQSBi/wjN9Z5?=
 =?us-ascii?Q?SelJyqceRHqrNnEX8MFx5rJYxcYlifo1r71sXy+/TisCjz6hrnAD2ySkblfX?=
 =?us-ascii?Q?+ziOZuO9rsXcE3MALETgulPj8Xf0lMZhrwA7pNsWVMkGPH2mxU/m6HcIrLKk?=
 =?us-ascii?Q?1JDhe2cVrERWFOK5DxLLxsNmShwX2nqA3DtbYRjzVwMF0yu3/gorLxM/BI9v?=
 =?us-ascii?Q?w0Rf28AL9+2WHcLOK4AntF6auGQK0mJjwNGoW0nUexTvw6AaFB5jZZBLDrWl?=
 =?us-ascii?Q?QvLH/rfJjOQRN/36yfTcc4TVpkQiC45ogGMjqluzezaG7lQ+HHv56Kj8xGk4?=
 =?us-ascii?Q?RB6RDCGu0p9LiiZt3xEgZ3OJDJpPO/eowPlZfmxttc6jYe9ZF12xQO57izHu?=
 =?us-ascii?Q?zYYYvJZcoeWQ0bpU3gsZPxHbcMB6yb3nYjtZKPy0Hap8H6vul11i6vaLKUZI?=
 =?us-ascii?Q?hkSyupz0Nr28LMMQfk9Wufz7dTGrFzfLEHd9xkKA3gpnzNdho5oq/mmWfcCI?=
 =?us-ascii?Q?MytwXR5SbnvI3FmUSODkfU5iDTRaMpMlrjwKATaoRaZ2jVztFnyyvWnM/QPT?=
 =?us-ascii?Q?4PiulKxwy1yNygyfK4/hv8x9Lsa12FTWn4sNbxwtULeNZQNLJ1l8lSMxDXE7?=
 =?us-ascii?Q?sny4v9t7NBOqyQpbfBGPjkJnnWtcVxr6Ebmt?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 03:22:32.8939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eeb89c3-1094-4b96-fd60-08dd95bb3a88
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7625

Introduce a new IOMMUFD_CMD_HW_QUEUE_ALLOC ioctl for user space to allocate
a HW QUEUE object for a vIOMMU specific HW-accelerated queue, e.g.:
 - NVIDIA's Virtual Command Queue
 - AMD vIOMMU's Command Buffer, Event Log Buffer, and PPR Log Buffer

This is a vIOMMU based ioctl. Simply increase the refcount of the vIOMMU.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |   2 +
 include/uapi/linux/iommufd.h            |  45 ++++++++++
 drivers/iommu/iommufd/main.c            |   6 ++
 drivers/iommu/iommufd/viommu.c          | 105 ++++++++++++++++++++++++
 4 files changed, 158 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 35088478cb07..a94d04ab0d2c 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -603,6 +603,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_viommu_destroy(struct iommufd_object *obj);
 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_vdevice_destroy(struct iommufd_object *obj);
+int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd);
+void iommufd_hw_queue_destroy(struct iommufd_object *obj);
 
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 272da7324a2b..aeed0127553e 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -56,6 +56,7 @@ enum {
 	IOMMUFD_CMD_VDEVICE_ALLOC = 0x91,
 	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
 	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
+	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
 };
 
 /**
@@ -1147,4 +1148,48 @@ struct iommu_veventq_alloc {
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
+ * Upon success, the underlying physical pages of the guest queue memory will be
+ * pinned to prevent VMM from unmapping them in the IOAS until the HW queue gets
+ * destroyed.
+ *
+ * A vIOMMU can allocate multiple queues, but it must use a different @index to
+ * separate each allocation, e.g. HW queue0, HW queue1, ...
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
index c6d0b446e632..0750e740fa1d 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -304,6 +304,7 @@ union ucmd_buffer {
 	struct iommu_destroy destroy;
 	struct iommu_fault_alloc fault;
 	struct iommu_hw_info info;
+	struct iommu_hw_queue_alloc hw_queue;
 	struct iommu_hwpt_alloc hwpt;
 	struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap;
 	struct iommu_hwpt_invalidate cache;
@@ -346,6 +347,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 struct iommu_fault_alloc, out_fault_fd),
 	IOCTL_OP(IOMMU_GET_HW_INFO, iommufd_get_hw_info, struct iommu_hw_info,
 		 __reserved),
+	IOCTL_OP(IOMMU_HW_QUEUE_ALLOC, iommufd_hw_queue_alloc_ioctl,
+		 struct iommu_hw_queue_alloc, length),
 	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
 		 __reserved),
 	IOCTL_OP(IOMMU_HWPT_GET_DIRTY_BITMAP, iommufd_hwpt_get_dirty_bitmap,
@@ -509,6 +512,9 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
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
index 7248fb7c7baf..9b4e99babdb4 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -164,3 +164,108 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &viommu->obj);
 	return rc;
 }
+
+void iommufd_hw_queue_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_hw_queue *hw_queue =
+		container_of(obj, struct iommufd_hw_queue, obj);
+	struct iommufd_viommu *viommu = hw_queue->viommu;
+
+	if (viommu->ops->hw_queue_destroy)
+		viommu->ops->hw_queue_destroy(hw_queue);
+	iopt_unpin_pages(&viommu->hwpt->ioas->iopt, hw_queue->base_addr,
+			 hw_queue->length, true);
+	refcount_dec(&viommu->obj.users);
+}
+
+int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_hw_queue_alloc *cmd = ucmd->cmd;
+	struct iommufd_hw_queue *hw_queue;
+	struct iommufd_viommu *viommu;
+	struct page **pages;
+	int max_npages, i;
+	u64 last, offset;
+	int rc;
+
+	if (cmd->flags || cmd->type == IOMMU_HW_QUEUE_TYPE_DEFAULT)
+		return -EOPNOTSUPP;
+	if (!cmd->nesting_parent_iova || !cmd->length)
+		return -EINVAL;
+	if (check_add_overflow(cmd->nesting_parent_iova, cmd->length - 1,
+			       &last))
+		return -EOVERFLOW;
+
+	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
+	if (IS_ERR(viommu))
+		return PTR_ERR(viommu);
+
+	if (!viommu->ops || !viommu->ops->hw_queue_alloc) {
+		rc = -EOPNOTSUPP;
+		goto out_put_viommu;
+	}
+
+	offset =
+		cmd->nesting_parent_iova - PAGE_ALIGN(cmd->nesting_parent_iova);
+	max_npages = DIV_ROUND_UP(offset + cmd->length, PAGE_SIZE);
+	pages = kcalloc(max_npages, sizeof(*pages), GFP_KERNEL);
+	if (!pages) {
+		rc = -ENOMEM;
+		goto out_put_viommu;
+	}
+
+	/*
+	 * The underlying physical pages must be pinned to prevent them from
+	 * being unmapped (via IOMMUFD_CMD_IOAS_UNMAP) during the life cycle
+	 * of the HW QUEUE object. And the pages should be contiguous too.
+	 */
+	if (viommu->ops->flags & IOMMUFD_VIOMMU_FLAG_HW_QUEUE_READS_PA) {
+		rc = iopt_pin_pages(&viommu->hwpt->ioas->iopt,
+				    cmd->nesting_parent_iova, cmd->length,
+				    pages, 0, true);
+		if (rc)
+			goto out_free;
+
+		/* Validate if the underlying physical pages are contiguous */
+		for (i = 1; i < max_npages && pages[i]; i++) {
+			if (page_to_pfn(pages[i]) ==
+			    page_to_pfn(pages[i - 1]) + 1)
+				continue;
+			rc = -EFAULT;
+			goto out_unpin;
+		}
+	}
+
+	hw_queue = viommu->ops->hw_queue_alloc(ucmd, viommu, cmd->type,
+					       cmd->index,
+					       cmd->nesting_parent_iova,
+					       cmd->length);
+	if (IS_ERR(hw_queue)) {
+		rc = PTR_ERR(hw_queue);
+		goto out_unpin;
+	}
+
+	/* The iommufd_hw_queue_alloc helper saves ictx in hw_queue->ictx */
+	if (WARN_ON_ONCE(hw_queue->ictx != ucmd->ictx)) {
+		rc = -EINVAL;
+		goto out_unpin;
+	}
+
+	hw_queue->viommu = viommu;
+	refcount_inc(&viommu->obj.users);
+	hw_queue->length = cmd->length;
+	hw_queue->base_addr = cmd->nesting_parent_iova;
+	cmd->out_hw_queue_id = hw_queue->obj.id;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	goto out_put_viommu;
+
+out_unpin:
+	if (viommu->ops->flags & IOMMUFD_VIOMMU_FLAG_HW_QUEUE_READS_PA)
+		iopt_unpin_pages(&viommu->hwpt->ioas->iopt,
+				 cmd->nesting_parent_iova, cmd->length, true);
+out_free:
+	kfree(pages);
+out_put_viommu:
+	iommufd_put_object(ucmd->ictx, &viommu->obj);
+	return rc;
+}
-- 
2.43.0


