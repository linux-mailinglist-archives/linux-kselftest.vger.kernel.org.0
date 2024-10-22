Return-Path: <linux-kselftest+bounces-20339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 464379A94AD
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 02:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB621C21E69
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 00:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3116129E93;
	Tue, 22 Oct 2024 00:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SCGIZLVz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97D084A51;
	Tue, 22 Oct 2024 00:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556429; cv=fail; b=E9wcQWybAtm4T1+ltbW1xhTksSf9aMGh09EdDnXJbpuwBnPYf1kw7v1cD1FdSLLlScp51iAkhzvZ5Ie87AYt0/kFxyKo3Yy3PPICyV/mE3qRm2bJX8tG+cnoff4WLsVSEYAbaG+DqEMMTYB3T9skI0PJRRgtVbRLkclx7XN0Y+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556429; c=relaxed/simple;
	bh=qLhswcpjU6K8MhIfaCkUrUbSk2ctdHEo4W9SvV5ZyzA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kLE0Zo/kQfMdPboPOeybs/rsNreFwqJxA1Fhb38Z8u6Wm70OU5GLfEcmJs0XRJ5gJe6lHxb6fqss/uCxwqw7BnM648uKBEmmsP5zNspxstXaBcbJ3NPMU3Kmh3wKuBXGnZ0xbT43ASp9CZaPgkfsYpQgK5e+BVv7L88vKCE5AO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SCGIZLVz; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwOENDxZUubk5R4KNvl8mtM0/Dw3Hj1cchhHAaWGtl5FGdmz6FtAt7bDn3XWzNhfV1PfI1h13YJyMgz/yEW2Z8GXBL2o7RfMVo3KIFejuUfnXRl2CZarQijZ7REwJvfSgWZDaXVhSxJlS8MIvEvIWZiixsvd7DBIzzuIp/8ddSJU1Mcg3ttIC6CcwMQyIfAdu3braeTqZfNTBi2h0zzfjcAigpxY7+6z0dA+l64ESy09aZ+7ToKZ5U1oLP5of4P/GrUKZ5KRxZeFYMnuYu7sDe+puO8QU1Cwl9MjGfZZOj1BVNaU9+HVC1ixC6WW3exuV2v7Dmr2C49UnGaZ5EjsNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAsGXKoE0NMi9fAvr1waWjg7ITDJ7ByaGMYwt099q/Y=;
 b=DzsnBqMd+vVPiqhxOkqi/t4oz3vLosu7SzTbY7XZ0dC6VNyjNkIGO6E/Fa8zQycbgRVXfjKxcz8jqaay20ITKigBnqddzQN6r/v3zgZAU33UUOE1SDV09mRJ/Lt0BSvzniqDxLd+WkUrX+4v6PGFU7jdItL/ANbAnYyE02Feh4qTkGlwmqO8eXsNavcNgTCNX+PzbfjAjhStfsKaCoo4DaISiTbBrrCCq4BU24Qk9TuZ8w1v4NayRZnYMz0oT4krSG69DOBzX/a7D/kbUEUvdyz8J7BVhOp3AMS3xUI8rsRHTSxo1yR4nEg2HK5/iljZtNFFfXrA0zyLGcIAlP8GvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAsGXKoE0NMi9fAvr1waWjg7ITDJ7ByaGMYwt099q/Y=;
 b=SCGIZLVz0tTbMLTd3CbB3iYhUFg2dBzTMy1ZVaAP1vzWqF3fGd8l/vdE8/kXqJo3z9Zo/x12WacCNv/6gMDLHpMLzdlnOl0AzIS5GFL0sCJvi4RvO3jjBBbr3jBxY29wFzc9LqEHG2IPsV+W615JYFGJD9xQctljTXdRSoja3Blbs1nBLH81NiTYZkz4kzTpHkibddascng7QRfyUZnICD99R1d6gPxNI6hglxF3p3fB+5Lp88mWcPQEvIqyez3JmaHtan72oFfoRFPJgi9tWxG7a2dfiqlgJ5muX+aLRhKY63DpMp9NtvJm0TtPFRQaVjZdZayKFTu7/bpcNMkdHQ==
Received: from BL1PR13CA0383.namprd13.prod.outlook.com (2603:10b6:208:2c0::28)
 by DS0PR12MB8503.namprd12.prod.outlook.com (2603:10b6:8:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Tue, 22 Oct
 2024 00:20:23 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:2c0:cafe::ad) by BL1PR13CA0383.outlook.office365.com
 (2603:10b6:208:2c0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15 via Frontend
 Transport; Tue, 22 Oct 2024 00:20:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 00:20:23 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:05 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:05 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 17:20:04 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: [PATCH v4 04/11] iommufd/viommu: Add IOMMU_VIOMMU_ALLOC ioctl
Date: Mon, 21 Oct 2024 17:19:26 -0700
Message-ID: <9da2cf334a182ced4d4ffa578b87889e9c0856f3.1729553811.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729553811.git.nicolinc@nvidia.com>
References: <cover.1729553811.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|DS0PR12MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e28250-ebed-4e9d-80b5-08dcf22f5236
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NZeavq9/hTHZxs5QyBBpkGTQt63WYMpowOyf8TLZy6/4PXdU5/TS8pDylGEf?=
 =?us-ascii?Q?Pr0UomHdtY5UJ0iG/jigqN44lCUKV2xrk0+404UaeIdSNZbp9KwJxpXzqqDK?=
 =?us-ascii?Q?cSGSVXSXfvwyd9KmUv55ZeE5aHtY8OSFcos3gRT410j5Mh5HtA0O1MYWDG+M?=
 =?us-ascii?Q?u1R2ZubvwFNOicLUGQRk+5HlJ5D10JGE+ucyISnGp/T8emR4QoHloZCmCQFF?=
 =?us-ascii?Q?U7j7Lqg4zIMrRowWIHyZF3HuauKWa5W0cmBQvAlyML+5Pn3vLlKA96gXfpdZ?=
 =?us-ascii?Q?MrwlzZ3OyuLXIpQL+FkTUN3NVPAA4X1lBk+zYymjcc6Qbu16IyugFeUWr70T?=
 =?us-ascii?Q?Q+ZZEGgucgvNSz+HN8f3tqW8H/vtMfgNJ1C47wa0JZgBbKnrIWYDl5FCi0wh?=
 =?us-ascii?Q?3UYAJpnw0jXcLwzr5PFwdC/zyT7L295D85nunSbKegAx0HBYwdPVBM9NBGZO?=
 =?us-ascii?Q?PijQXJSGm/pcQZcK79U2frgMe3tK8xXQKxb6Z3/s6vVT8i6UlP//NFgCz+Mm?=
 =?us-ascii?Q?XUyBAg+7dSc+OFh7ULXZ7v7vW4e89A67mmSSw2zcOj64graINhI96F+v1chN?=
 =?us-ascii?Q?1ElVzTTAvmOTtUQdxi/2RKW5F6dmLJWKij91qMrC3Ow2g2r6KqwPFex6wZxI?=
 =?us-ascii?Q?pqPYbjp7XoCSLDVScjHh63a4XDdmi+VyqaqIb2o9n4OFwA5ai7Sr6famsZAg?=
 =?us-ascii?Q?WSPUTKWXc0kOgrj5049WiZa/7RT0J2bhtHRYfich/0WdeGQ5IWAuZuYQdYLY?=
 =?us-ascii?Q?/fgWwl4mUs3ta0cWTIV7tDKy6NgGbcClHp+QidPxUgErzB7kjAfaB8oRf2is?=
 =?us-ascii?Q?W3Sj/EE2Ct7NUJppE98TILigYEhMPS8M0ZUBPoZX1fpRcg50xOZ/v+ZZphpy?=
 =?us-ascii?Q?gTQQr78BR4E5iVKVgYdrr7hESampBNftJZb2Z2PvB2fEEQVY7tvGtVGz7b5R?=
 =?us-ascii?Q?4Ph86Q+s2P22duBEGAjeHcww/Lt1NLiyvHweyzu3TeaREohkaAl0NcKdRwcO?=
 =?us-ascii?Q?iEiIgLbt7dqcp18L8aazdw2H7vhhmb4wEhM7itsPQUv/445Injt9Jy52wKM/?=
 =?us-ascii?Q?baWcFeww4vXekCSrKWnmBLzLnPru6hFoTTdNPQ4s+dftGyg/0XT11cRe3aBU?=
 =?us-ascii?Q?bIM9IhrNffEbQPsw+lmFGMwf+39rpGwcMvTc+fKyk40Nh6g9/vz4Vy7VAM8+?=
 =?us-ascii?Q?Kn0MtSxhWxS+yv1SRXpQsvxBZwnEFZZdKlAOACrYeTDfU/2dcs3tDTtQomPh?=
 =?us-ascii?Q?nIfcrRp9j1HiUeG0lZot/L5Lijulv5hZVN6yDTz70HDrFDURXPfA4f0ZtzLk?=
 =?us-ascii?Q?14te02Odmxiq/KZs5hGBZx6LCmz/YnPXFYZpzgagzwWgY37jTiFZNVGTnc+6?=
 =?us-ascii?Q?Fz4xV7WW1AAN1/dzp/qCu6fp56+Q2W6PJtAf/KKhCwBdkmGHtQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 00:20:23.4424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e28250-ebed-4e9d-80b5-08dcf22f5236
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8503

Add a new ioctl for user space to do a vIOMMU allocation. It must be based
on a nesting parent HWPT, so take its refcount.

If an IOMMU driver supports a driver-managed vIOMMU object, it must define
its own IOMMU_VIOMMU_TYPE_ in the uAPI header and implement a viommu_alloc
op in its iommu_ops.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/Makefile          |  3 +-
 drivers/iommu/iommufd/iommufd_private.h |  3 +
 include/uapi/linux/iommufd.h            | 40 ++++++++++++
 drivers/iommu/iommufd/main.c            |  6 ++
 drivers/iommu/iommufd/viommu.c          | 85 +++++++++++++++++++++++++
 5 files changed, 136 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/iommufd/viommu.c

diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index 435124a8e1f1..7c207c5f1eb6 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -7,7 +7,8 @@ iommufd-y := \
 	ioas.o \
 	main.o \
 	pages.o \
-	vfio_compat.o
+	vfio_compat.o \
+	viommu.o
 
 iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index d53c1ca75532..9adf8d616796 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -504,6 +504,9 @@ static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 	return iommu_group_replace_domain(idev->igroup->group, hwpt->domain);
 }
 
+int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
+void iommufd_viommu_destroy(struct iommufd_object *obj);
+
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
 void iommufd_selftest_destroy(struct iommufd_object *obj);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index cd4920886ad0..d1c99285eda0 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -51,6 +51,7 @@ enum {
 	IOMMUFD_CMD_HWPT_GET_DIRTY_BITMAP = 0x8c,
 	IOMMUFD_CMD_HWPT_INVALIDATE = 0x8d,
 	IOMMUFD_CMD_FAULT_QUEUE_ALLOC = 0x8e,
+	IOMMUFD_CMD_VIOMMU_ALLOC = 0x8f,
 };
 
 /**
@@ -852,4 +853,43 @@ struct iommu_fault_alloc {
 	__u32 out_fault_fd;
 };
 #define IOMMU_FAULT_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_FAULT_QUEUE_ALLOC)
+
+/**
+ * enum iommu_viommu_type - Virtual IOMMU Type
+ * @IOMMU_VIOMMU_TYPE_DEFAULT: Reserved for future use
+ */
+enum iommu_viommu_type {
+	IOMMU_VIOMMU_TYPE_DEFAULT = 0,
+};
+
+/**
+ * struct iommu_viommu_alloc - ioctl(IOMMU_VIOMMU_ALLOC)
+ * @size: sizeof(struct iommu_viommu_alloc)
+ * @flags: Must be 0
+ * @type: Type of the virtual IOMMU. Must be defined in enum iommu_viommu_type
+ * @dev_id: The device's physical IOMMU will be used to back the virtual IOMMU
+ * @hwpt_id: ID of a nesting parent HWPT to associate to
+ * @out_viommu_id: Output virtual IOMMU ID for the allocated object
+ *
+ * Allocate a virtual IOMMU object that represents the underlying physical
+ * IOMMU's virtualization support. The vIOMMU object is a security-isolated
+ * slice of the physical IOMMU HW that is unique to a specific VM. Operations
+ * global to the IOMMU are connected to the vIOMMU, such as:
+ * - Security namespace for guest owned ID, e.g. guest-controlled cache tags
+ * - Access to a sharable nesting parent pagetable across physical IOMMUs
+ * - Virtualization of various platforms IDs, e.g. RIDs and others
+ * - Delivery of paravirtualized invalidation
+ * - Direct assigned invalidation queues
+ * - Direct assigned interrupts
+ * - Non-affiliated event reporting
+ */
+struct iommu_viommu_alloc {
+	__u32 size;
+	__u32 flags;
+	__u32 type;
+	__u32 dev_id;
+	__u32 hwpt_id;
+	__u32 out_viommu_id;
+};
+#define IOMMU_VIOMMU_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_ALLOC)
 #endif
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index e244fed1b7ab..ab5ee325d809 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -321,6 +321,7 @@ union ucmd_buffer {
 	struct iommu_ioas_unmap unmap;
 	struct iommu_option option;
 	struct iommu_vfio_ioas vfio_ioas;
+	struct iommu_viommu_alloc viommu;
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
 #endif
@@ -372,6 +373,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 val64),
 	IOCTL_OP(IOMMU_VFIO_IOAS, iommufd_vfio_ioas, struct iommu_vfio_ioas,
 		 __reserved),
+	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
+		 struct iommu_viommu_alloc, out_viommu_id),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
@@ -507,6 +510,9 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_FAULT] = {
 		.destroy = iommufd_fault_destroy,
 	},
+	[IOMMUFD_OBJ_VIOMMU] = {
+		.destroy = iommufd_viommu_destroy,
+	},
 #ifdef CONFIG_IOMMUFD_TEST
 	[IOMMUFD_OBJ_SELFTEST] = {
 		.destroy = iommufd_selftest_destroy,
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
new file mode 100644
index 000000000000..e612f3d539b7
--- /dev/null
+++ b/drivers/iommu/iommufd/viommu.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
+ */
+
+#include "iommufd_private.h"
+
+void iommufd_viommu_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_viommu *viommu =
+		container_of(obj, struct iommufd_viommu, obj);
+
+	if (viommu->ops && viommu->ops->free)
+		viommu->ops->free(viommu);
+	refcount_dec(&viommu->hwpt->common.obj.users);
+}
+
+int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_viommu_alloc *cmd = ucmd->cmd;
+	struct iommufd_hwpt_paging *hwpt_paging;
+	struct iommufd_viommu *viommu;
+	struct iommufd_device *idev;
+	const struct iommu_ops *ops;
+	int rc;
+
+	if (cmd->flags || cmd->type == IOMMU_VIOMMU_TYPE_DEFAULT)
+		return -EOPNOTSUPP;
+
+	idev = iommufd_get_device(ucmd, cmd->dev_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+
+	ops = dev_iommu_ops(idev->dev);
+	if (!ops->viommu_alloc) {
+		rc = -EOPNOTSUPP;
+		goto out_put_idev;
+	}
+
+	hwpt_paging = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
+	if (IS_ERR(hwpt_paging)) {
+		rc = PTR_ERR(hwpt_paging);
+		goto out_put_idev;
+	}
+
+	if (!hwpt_paging->nest_parent) {
+		rc = -EINVAL;
+		goto out_put_hwpt;
+	}
+
+	viommu = ops->viommu_alloc(idev->dev, hwpt_paging->common.domain,
+				   ucmd->ictx, cmd->type);
+	if (IS_ERR(viommu)) {
+		rc = PTR_ERR(viommu);
+		goto out_put_hwpt;
+	}
+
+	rc = iommufd_verify_unfinalized_object(ucmd->ictx, &viommu->obj);
+	if (rc) {
+		kfree(viommu);
+		goto out_put_hwpt;
+	}
+
+	viommu->type = cmd->type;
+	viommu->ictx = ucmd->ictx;
+	viommu->hwpt = hwpt_paging;
+	/* Assume physical IOMMUs are unpluggable (the most likely case) */
+	viommu->iommu_dev = __iommu_get_iommu_dev(idev->dev);
+
+	refcount_inc(&viommu->hwpt->common.obj.users);
+
+	cmd->out_viommu_id = viommu->obj.id;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_abort;
+	iommufd_object_finalize(ucmd->ictx, &viommu->obj);
+	goto out_put_hwpt;
+
+out_abort:
+	iommufd_object_abort_and_destroy(ucmd->ictx, &viommu->obj);
+out_put_hwpt:
+	iommufd_put_object(ucmd->ictx, &hwpt_paging->common.obj);
+out_put_idev:
+	iommufd_put_object(ucmd->ictx, &idev->obj);
+	return rc;
+}
-- 
2.43.0


