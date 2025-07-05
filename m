Return-Path: <linux-kselftest+bounces-36621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 490F1AF9D43
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 03:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F9F1CA13BF
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 01:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F9B207A25;
	Sat,  5 Jul 2025 01:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H2SNlkGw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC3C1F8AC8;
	Sat,  5 Jul 2025 01:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751678068; cv=fail; b=glNWpTMntzFqqMhe8iqIPjzPP1Z+fGzNpOdE/5kxGLSC3IfR7QLGEiWx6H6U0bceBBPoyMnd0Te+CH4znuuWFyTnGOQkLt+pgUWE+inCs6YvrtAcf+HAdlo46zjwKAQvFPbWgJzIQPpH4uFBZd6InFTDTCWNpp8zHVjs+LS6FV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751678068; c=relaxed/simple;
	bh=Gu0OuJ9HRi0SXGQlIik0jws5x4271cuFcTDmUnO63YM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=El+L0kz13ZyfRErVR/PUkFihgjYVBO2PZGLLvdgm/n6UD03kgi4W9ib2owAUyWVT4p/ZnZvSwOkdo+voKNDJ5Jct3IZAYSimmFii5VvCkLOUrUgHtnLStgigsJFM+8GAk1Gx/FSbxeO12d3dizeAH+4FYicPMBBYJZC071zkDsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H2SNlkGw; arc=fail smtp.client-ip=40.107.93.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uiry5ev3GjkwQsYxFBDT/GZ2AWv2BcEL3i9SGdFyPLATiS2u6WMDYY9QMXluSbm+VGMeOD0eGN7bI2tn/Q+LJlCRYlEp6R7enTTsW5GlTokFd76pYCtxqPqWNIMEIBZkv+HrBjmVx289sVzyjFYQvjMwkbihHNa1H2YU0/lV8EVYlmbzYSeHPx2VaF18dOJ0YoCz4FY/adsaYaiIeccncJjs+tA4NTAVDbFDZB7QfYfrNWkycYdTDC42QM+sD13e90GrvfClgB5MIUelW4EQXq5v7IQKefZcf9OFcuddlDBAef5Z3XnRhK7vlbM6s9fFgBr5D46F61rE1EXLo/cJPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acW0S5k5hHt+4NfoiCK3qvkmVvwOp9eUk47jacOLW/s=;
 b=NNPku82Q40uZqsqUt9mn+AD2cZB4CPAYgTUEw6DArrSmLLA2gL/vLkLK6ebQILGM8jQsJ8IWkkPN8ZGFNklKyc6wD4YE+aWxJBS8eCtU6VCGJaU+SLCZ4l8rDJd5gtML9Gd6MkZVFKAuogGZBLuKr8j0W6WwJqW/Pu6cTC76Nda+gK6uMCceTnuvqG0oWMkwMtv8oHUSXPIFYP86AgAhABqJmwQgadpOgKYEvGcdLLfHWwRyvzQUR/bvrBp9pqHaLVebWpddl/Bo+u+NlQI+zoeQV1f+qo+x2EOST5zk+VnjZq/LJcFdUuvG+rQfzoCjCcYBwWltlgt2I3HoHIvbFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acW0S5k5hHt+4NfoiCK3qvkmVvwOp9eUk47jacOLW/s=;
 b=H2SNlkGwS63aOm8F+Pc6h2fD84vAhWHjZX6+hS/7G7h1UIuLie9wzvYhB1QiSxwej9CoyKm3fKrnlE5SyarZ1LYULNpPG9YtAOWPu0+6QEjoAWmW8kPW6k0NCHSUhQatdjRHOu+qi85MR/w19OrnMEmaJh3SVi9ZB6sBjViBjfljqthIKnY5h4rcN/iuuLz8+yN7Z/8VGFCDsuHB4zV48fCPLuPLnWeeAzp6ITtDmcrZEC36vy/OFrFPBriWxbLdUD9fq/jt8kJBGslJ4Rlr3SwwT6LOFP6DpS8qygcjM/YhyKSHCHY1Clcrt2xREPvEcDwve8Re3+nHGwRxwUuwTQ==
Received: from SJ0PR05CA0149.namprd05.prod.outlook.com (2603:10b6:a03:33d::34)
 by CY3PR12MB9701.namprd12.prod.outlook.com (2603:10b6:930:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Sat, 5 Jul
 2025 01:14:22 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::88) by SJ0PR05CA0149.outlook.office365.com
 (2603:10b6:a03:33d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.12 via Frontend Transport; Sat,
 5 Jul 2025 01:14:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sat, 5 Jul 2025 01:14:22 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Jul 2025
 18:14:14 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Jul 2025 18:14:13 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 4 Jul 2025 18:14:12 -0700
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
Subject: [PATCH v8 12/29] iommufd/viommu: Add driver-defined vDEVICE support
Date: Fri, 4 Jul 2025 18:13:28 -0700
Message-ID: <d6fa98ad18a44d3df2ad9c9320f364affa9c03f5.1751677708.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|CY3PR12MB9701:EE_
X-MS-Office365-Filtering-Correlation-Id: a763af50-e5d2-4312-4b1e-08ddbb614649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MTBInuOHZWxec3XM4yJ3arxo2rJtJZlWYHjXetAPaFXZ87SQCLVCSeXw7WtU?=
 =?us-ascii?Q?oje0FVhch1KjB/9+Kl2vb2GNgTU6F+ZT/HyiyDOQR92Oqd2Trp/aGtsNLdE6?=
 =?us-ascii?Q?ABy2MMqgnb3dInEq9heTfQYlG9PtU3TLN2p0t7XrMS89jG0GUYIazo9nWZYF?=
 =?us-ascii?Q?AwKKBfkpY7pk8Subd1mXadAOlLSn372DDB4yBt7r0rcMRP4edMzXgbiLxUdk?=
 =?us-ascii?Q?ydwroAQi6Gu50wrlkRiFwY/x0Hce6KE6FTaDsS3wU3fzDGbyqljXdNQKJlLl?=
 =?us-ascii?Q?hEuMbyjN4hzF9cxu3CZUTfAwwa0e3w53sIhTRqGu1qieGnNVzw697qruhOC1?=
 =?us-ascii?Q?z1aTQhW+Kn+rirI2SHR85syj/EgvVg9YtHE6tcXUalf6/Wn4P03J7eobB5Co?=
 =?us-ascii?Q?grVn2U6x2UrYQ5IvCvWNCtek0xGIifWJFolM9DyavX3JMuii6eeBPbZcdQUO?=
 =?us-ascii?Q?K/v0A6X7vbbK5wikySSncfjWc6xCwtKtkTD3Vw/0/tTrFFz47wNQAErx8ga7?=
 =?us-ascii?Q?i8JO1ZNiomm4Lb0YMKSERD0AX/d2hnntS8PY33wbau2zSksEj4FACxyAuCP3?=
 =?us-ascii?Q?sJGr+YUYHXnsDf+5NuCYNrgrDZMNnapxLabFzY2GV1qCeHDJUaLVliWH7eig?=
 =?us-ascii?Q?HsJes/so6ESprNNSHO4zSPrOtonhwKwZ9CIbRtBYKuaLQY00lFsMY8+tYH3X?=
 =?us-ascii?Q?EP6rUSieQB9CP6XbUJzNLAw8RhTRq6ypkjKbdM3M9/KcIWwBEGSK39/GYoyN?=
 =?us-ascii?Q?f+wTlTwCETD6g4JZYXp6U5OB/q/gDBxTXJGk83qo0UocxckfDEfonNuwyMgL?=
 =?us-ascii?Q?PTPxmrLgfnyUn+04PVALAo1bhpcE3jLrHXzWaSCGWdOYSty1pQ4fAGT8Avbv?=
 =?us-ascii?Q?YxOm33myM3tkSxeUPXpZbW4M69JlUK0SngffneB/JZUlc7vjcVFJzoR0K/Xj?=
 =?us-ascii?Q?imomitmuBrxodu0xznnj6RLHy55r6Ej5jb2gmO0zok7CH46InB+stGZm59E9?=
 =?us-ascii?Q?/F5hMFufuPcvADF/HJyLD+okM5fmFrr//feM69tAi31cDEiYFbeY7YBK1WAE?=
 =?us-ascii?Q?0adwqKjY0wf8rnQ4XFmUmmcUfyB08TiKTHAEiEv/73Cq72REf/nbV32Df+yY?=
 =?us-ascii?Q?K44BW0jYOpYGvXU+h0jAfRKge5NfRAgN32BiAIzjvUVOJZl1VNs/VotuGo/I?=
 =?us-ascii?Q?2g5ShqhFm/CDVAwUgRmmu4qrslopR8iMjowwGXKmo61Tr0ia3OadsNJOGvsW?=
 =?us-ascii?Q?e8dHFpi+42lEqvza8EOwbcpYFtBIezZ0O+ULPoI8C1AcbPw9R96zsMIpChe6?=
 =?us-ascii?Q?20Bjccqx/TuIVBZzjV/TJHiqL8ld/WK1/QfT1GCT4bk2NEtMywHtpC2EEScQ?=
 =?us-ascii?Q?grMaUjnwU6qLzucESaAxZuCosinG2SCPW3IT4ZfTgKmznLV/QzdPQJ4UO80+?=
 =?us-ascii?Q?Eikv59wG/imwOmzTomGQaMjYOWHxIXyBsRB2vMA78NU9LUMFfy2ixM/fR7bT?=
 =?us-ascii?Q?krDYsSxIvuvDIseVgBoRZbX5tnfrvi6Gevg7?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 01:14:22.0883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a763af50-e5d2-4312-4b1e-08ddbb614649
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9701

NVIDIA VCMDQ driver will have a driver-defined vDEVICE structure and do
some HW configurations with that.

To allow IOMMU drivers to define their own vDEVICE structures, move the
struct iommufd_vdevice to the public header and provide a pair of viommu
ops, similar to get_viommu_size and viommu_init.

Doing this, however, creates a new window between the vDEVICE allocation
and its driver-level initialization, during which an abort could happen
but it can't invoke a driver destroy function from the struct viommu_ops
since the driver structure isn't initialized yet. vIOMMU object doesn't
have this problem, since its destroy op is set via the viommu_ops by the
driver viommu_init function. Thus, vDEVICE should do something similar:
add a destroy function pointer inside the struct iommufd_vdevice instead
of the struct iommufd_viommu_ops.

Note that there is unlikely a use case for a type dependent vDEVICE, so
a static vdevice_size is probably enough for the near term instead of a
get_vdevice_size function op.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 12 ----------
 include/linux/iommufd.h                 | 31 +++++++++++++++++++++++++
 drivers/iommu/iommufd/viommu.c          | 26 ++++++++++++++++++++-
 3 files changed, 56 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 9fdbf5f21f2e..06b8c2e2d9e6 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -653,18 +653,6 @@ void iommufd_viommu_destroy(struct iommufd_object *obj);
 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_vdevice_destroy(struct iommufd_object *obj);
 
-struct iommufd_vdevice {
-	struct iommufd_object obj;
-	struct iommufd_viommu *viommu;
-	struct device *dev;
-
-	/*
-	 * Virtual device ID per vIOMMU, e.g. vSID of ARM SMMUv3, vDeviceID of
-	 * AMD IOMMU, and vRID of Intel VT-d
-	 */
-	u64 virt_id;
-};
-
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
 void iommufd_selftest_destroy(struct iommufd_object *obj);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 2d1bf2f97ee3..bdd10a85eeef 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -104,6 +104,21 @@ struct iommufd_viommu {
 	enum iommu_viommu_type type;
 };
 
+struct iommufd_vdevice {
+	struct iommufd_object obj;
+	struct iommufd_viommu *viommu;
+	struct device *dev;
+
+	/*
+	 * Virtual device ID per vIOMMU, e.g. vSID of ARM SMMUv3, vDeviceID of
+	 * AMD IOMMU, and vRID of Intel VT-d
+	 */
+	u64 virt_id;
+
+	/* Clean up all driver-specific parts of an iommufd_vdevice */
+	void (*destroy)(struct iommufd_vdevice *vdev);
+};
+
 /**
  * struct iommufd_viommu_ops - vIOMMU specific operations
  * @destroy: Clean up all driver-specific parts of an iommufd_viommu. The memory
@@ -120,6 +135,14 @@ struct iommufd_viommu {
  *                    array->entry_num to report the number of handled requests.
  *                    The data structure of the array entry must be defined in
  *                    include/uapi/linux/iommufd.h
+ * @vdevice_size: Size of the driver-defined vDEVICE structure per this vIOMMU
+ * @vdevice_init: Initialize the driver-level structure of a vDEVICE object, or
+ *                related HW procedure. @vdev is already initialized by iommufd
+ *                core: vdev->dev and vdev->viommu pointers; vdev->id carries a
+ *                per-vIOMMU virtual ID (refer to struct iommu_vdevice_alloc in
+ *                include/uapi/linux/iommufd.h)
+ *                If driver has a deinit function to revert what vdevice_init op
+ *                does, it should set it to the @vdev->destroy function pointer
  */
 struct iommufd_viommu_ops {
 	void (*destroy)(struct iommufd_viommu *viommu);
@@ -128,6 +151,8 @@ struct iommufd_viommu_ops {
 		const struct iommu_user_data *user_data);
 	int (*cache_invalidate)(struct iommufd_viommu *viommu,
 				struct iommu_user_data_array *array);
+	const size_t vdevice_size;
+	int (*vdevice_init)(struct iommufd_vdevice *vdev);
 };
 
 #if IS_ENABLED(CONFIG_IOMMUFD)
@@ -224,4 +249,10 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 	 BUILD_BUG_ON_ZERO(offsetof(drv_struct, member)) +                     \
 	 BUILD_BUG_ON_ZERO(!__same_type(struct iommufd_viommu,                 \
 					((drv_struct *)NULL)->member)))
+
+#define VDEVICE_STRUCT_SIZE(drv_struct, member)                                \
+	(sizeof(drv_struct) +                                                  \
+	 BUILD_BUG_ON_ZERO(offsetof(drv_struct, member)) +                     \
+	 BUILD_BUG_ON_ZERO(!__same_type(struct iommufd_vdevice,                \
+					((drv_struct *)NULL)->member)))
 #endif
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index c0365849f849..081ee6697a11 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -116,6 +116,8 @@ void iommufd_vdevice_destroy(struct iommufd_object *obj)
 		container_of(obj, struct iommufd_vdevice, obj);
 	struct iommufd_viommu *viommu = vdev->viommu;
 
+	if (vdev->destroy)
+		vdev->destroy(vdev);
 	/* xa_cmpxchg is okay to fail if alloc failed xa_cmpxchg previously */
 	xa_cmpxchg(&viommu->vdevs, vdev->virt_id, vdev, NULL, GFP_KERNEL);
 	refcount_dec(&viommu->obj.users);
@@ -126,6 +128,7 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_vdevice_alloc *cmd = ucmd->cmd;
 	struct iommufd_vdevice *vdev, *curr;
+	size_t vdev_size = sizeof(*vdev);
 	struct iommufd_viommu *viommu;
 	struct iommufd_device *idev;
 	u64 virt_id = cmd->virt_id;
@@ -150,7 +153,22 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		goto out_put_idev;
 	}
 
-	vdev = iommufd_object_alloc_ucmd(ucmd, vdev, IOMMUFD_OBJ_VDEVICE);
+	if (viommu->ops && viommu->ops->vdevice_size) {
+		/*
+		 * It is a driver bug for:
+		 * - ops->vdevice_size smaller than the core structure size
+		 * - not implementing a pairing ops->vdevice_init op
+		 */
+		if (WARN_ON_ONCE(viommu->ops->vdevice_size < vdev_size ||
+				 !viommu->ops->vdevice_init)) {
+			rc = -EOPNOTSUPP;
+			goto out_put_idev;
+		}
+		vdev_size = viommu->ops->vdevice_size;
+	}
+
+	vdev = (struct iommufd_vdevice *)_iommufd_object_alloc_ucmd(
+		ucmd, vdev_size, IOMMUFD_OBJ_VDEVICE);
 	if (IS_ERR(vdev)) {
 		rc = PTR_ERR(vdev);
 		goto out_put_idev;
@@ -168,6 +186,12 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		goto out_put_idev;
 	}
 
+	if (viommu->ops && viommu->ops->vdevice_init) {
+		rc = viommu->ops->vdevice_init(vdev);
+		if (rc)
+			goto out_put_idev;
+	}
+
 	cmd->out_vdevice_id = vdev->obj.id;
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 
-- 
2.43.0


