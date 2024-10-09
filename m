Return-Path: <linux-kselftest+bounces-19375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A37E29971FC
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 18:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FBEB286318
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 16:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88141E2842;
	Wed,  9 Oct 2024 16:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TQs0yl0s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08271E22FA;
	Wed,  9 Oct 2024 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491955; cv=fail; b=F0b/BDfTm9XeHt9bC1OboOZH47oVI4o0BDD4C+L/ZUx7N01E/PvM5Fw/Xo8x06NALf0H0PcyzyZNlTnGWsQY+OORBbt6SoxNt1XF2J0dFfS7DUPeTLiySp/Ll4ILcmX/LVKJG+n0Kcxn4bjeMolTI048FzOJ1U5lnNjgFn2VDUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491955; c=relaxed/simple;
	bh=AxMlVyj9eIQXUIAE07DTvnmOSIC2dmvrPygvfWHVrTw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TYVFYR1g+YIi01U0FXy1nJmM/AcctkfXWLKS5wWGtSLd/lN6HdDrPwV6DZp8bfIXOoqPD7dYIFj9F/y+ShOOPIclvc+4HlEfVSVw2LUyyLUH6OZqciiXaXrX3rUi7BnjtVHxsaicg036hyrdp8kF7ETb+4uj8R0sPQjIW8pST+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TQs0yl0s; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rpP6IA1O5rChIeAoYe06F/b77d/Wmg4VHylR7DquPzP/vs+Wv9MKh+Z16Dn5aedKw6AbEAp3F431YA99BtEj6OFqKUODsmXjiGuODL9nLv8/KvUHWejuAQxFqEEIdqQkztt/PSZJ+gljw69jTNBTK2frFsua5z5BsW2DwinZT4CH5eGad2GKKXOgX4bG+IrhR70Bo5evnGQfwE1tOJ+Nbzsl6UoFQdWSebO7b1a6ZF9be9KzUWBFcD2lhLhbjnv73PMZy8a6G4zlXm5N+UjoCuTAs8Q23louj1gKAeMC8tEQSo3YapaKkaa6ObM1hi6RcmDX5gOEqnbUngaX9Y1N5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXa2VJQ8Fls05TpaX244UmA1ctsFhfXZXCj7XwzjBIg=;
 b=UYl5dFZXH3ojNBvOsdzVR5iRH2qwJd5ajdOLyVgh6c31eXgeLm/Pj99Y2Y9pjOvRngudpdeJ9DSqadNct7TF3Sq/1B1XO9YFD7yuE1+N4OscFljKl1YM1u+MryWeS2hzbcNyvXsQx2sPmsPJI5VYzHQcqRO753MRahdNZ+OyrhUV9XVhw1KSitwJSnM+I6vICkIH3Qjkmj7sqrNgjSghFs/zzjFMkQTfhQPYKyCdao7Ntmqln25SK4IH2xTwgOsZdsFs0DW8DdolGHEAcWAuZ0IfCvUPI/n/+ZjFhdtbWkxikvtPU5SrMI13Cv+XEwg50QP3Vjabobt2gxNDJaiIKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXa2VJQ8Fls05TpaX244UmA1ctsFhfXZXCj7XwzjBIg=;
 b=TQs0yl0sc282WuZftAojfHPa5nPQY9j5mCtF0g59zmxbOknhA7hDxxxrSpnvmTRwpgGF2dA3q39brcFxqCb9AP5WieMsYzww6HHJMx+5qwYpuhEC6bWUywwU49JSKOyDRWtCPTqBcNYOxoQL2V3rgOmfYNI2TLUwNzlSV8klktJZA2gTvHLMKIzkpymfxv/Rbv4H1iaB5LNPSAcR56Pn2K3P0kz1fBF5h2+nIZ3FsTA4r42Q73XOn7YL2eC7KUeuoi2jqg5g+uEdeMP5dACB9ugGlgVS5cOKplup56QYAfsDGeADzsZouHoO1LUqlj4WvDMFFQbRS3G9+/Qi5Ht5rQ==
Received: from DS7P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::8) by
 MW4PR12MB6900.namprd12.prod.outlook.com (2603:10b6:303:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Wed, 9 Oct
 2024 16:39:04 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:8:1ca:cafe::d7) by DS7P220CA0010.outlook.office365.com
 (2603:10b6:8:1ca::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18 via Frontend
 Transport; Wed, 9 Oct 2024 16:39:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 16:39:04 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 09:38:57 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 9 Oct 2024 09:38:57 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 9 Oct 2024 09:38:56 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v3 01/16] iommufd/viommu: Introduce IOMMUFD_OBJ_VDEVICE and its related struct
Date: Wed, 9 Oct 2024 09:38:13 -0700
Message-ID: <556347d2e69e8b236ec946a93132181385344d4f.1728491532.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728491532.git.nicolinc@nvidia.com>
References: <cover.1728491532.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|MW4PR12MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: 31dde2ea-0a2b-4962-37b1-08dce880e313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yh/feIL9Pam1eaNXAiTZ/JfzsClKom6cEoIXFqtWEw7jAmLWlLy/WC+s6pex?=
 =?us-ascii?Q?ObjAAtIoeNRV+y6ArZ5t9iX3ADguZXosAWV/JQ2S3JDqwtX+KdklsRGZHPOf?=
 =?us-ascii?Q?9/YkHWUaL9CI9psz+eE73n9aeYq3w45eQxxvhJArfQSE9bAyp6n4gX/MbN3t?=
 =?us-ascii?Q?9Xe8zSZmTvL9PNejA7H+xDNX1wa6b+mF9uhuTNzOM5X8x2tmispGnHqMWNXe?=
 =?us-ascii?Q?dmy8hyUt9/85qsMkOXwxehljDkpDNmAk/dchpjZV7pFrYRxDdWG7cpmeXo8G?=
 =?us-ascii?Q?5P/zIHDDROVSjjaqsZMJ6FUy8QzyrbOV3WFpqdgfYTnoJJhtPmsZjOoDnQRH?=
 =?us-ascii?Q?ezhe6nGRpZxAU3+GJ8vcNaJtizRvMEx1RY5PBjMjyMa67eyOY9T6m1aYz0+S?=
 =?us-ascii?Q?ebjDv59oietp/3p+8OmXD5UiJuYw5vban5xJeENblMqHttPTyHwifQzeFP67?=
 =?us-ascii?Q?Bg/abc3ruXAgUSgHgDrYYIPrh2HjyPZ3XA7w6PF8sqDisqPk4P5x9aVw0its?=
 =?us-ascii?Q?4oRkA/6l94sKEbAwxlBhll0jwukWr8YTZIba0/dGy/l4qDvEoa7C/HZZUyOt?=
 =?us-ascii?Q?h0EEm2KD03d82XDMADn21pCO295kpoi15kiHPwCo/rm4oAxoefn4EKz6oB0I?=
 =?us-ascii?Q?nbQOF3aB97zAirXAbMuGvYcC99TNgADUnxctzSvSYkg69SH46/og6MEKq/qW?=
 =?us-ascii?Q?piUDUiO7T8zj8m/VuBlfNX0dDrIJdFYRWIzbWcV14bXhxEeT4HMK4DQxROTB?=
 =?us-ascii?Q?zV0pF9wI94wZ9NP2uZ26FdP2YHdlX1+Xb7G76uWtNeJbfMFiFO07WZyaBqqm?=
 =?us-ascii?Q?Lhv0D1mk/1BTQKA8vsTcgw5179urqWm2P0dTM9ELMmq4txEW4Zvj8N7k/3uE?=
 =?us-ascii?Q?1CDhb7nEbw/Kc6wk16oMCJJvPYzEfapUvfxWYBVIBK2yV7EcfGH5K4yVcRUO?=
 =?us-ascii?Q?M3PDdpCglkZnEM1f+FC6YsoUeBtteEB7cgPaLKGwpKX1uj8M3FRwVIMHTxhY?=
 =?us-ascii?Q?mZrpH7BOUDt80BRXMg8a0pk3doTXoaBR6CcfQsk0Vj2rPnKUsq1nCayXXun3?=
 =?us-ascii?Q?1lHn8Sg5O2UYadWQ1+NubogLCebDfKMbqYYa6TaNDW50RP8JJ7PA1IdqJu4p?=
 =?us-ascii?Q?7Zit81jrJyIjzQhYa19XVIGRd1iKwrpJo1OkG3zu6ACKXd4x1/uki7jkgyOE?=
 =?us-ascii?Q?nv7X/6JD8wRHdGDdRba61AnMtBTmLfP81RniSDKzhK1dFMgzpRITq89yHH1D?=
 =?us-ascii?Q?P7VD8mez/EY1iID/9sETJQyumN/V/Vop+YgE28y5WSk9S+QqLJgQwkFzQZ42?=
 =?us-ascii?Q?nXS1/EM4umODlARbWAbxIptFYmrudrFd858ai/m1yLY2mqjmfPDN2Et0nC/E?=
 =?us-ascii?Q?FkABRTfBce2jreMkeCo1aKGdcWuD?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:39:04.1663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31dde2ea-0a2b-4962-37b1-08dce880e313
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6900

Introduce a new IOMMUFD_OBJ_VDEVICE to represent a physical device, i.e.
iommufd_device (idev) object, against an iommufd_viommu (vIOMMU) object in
the VM. This vDEVICE object (and its structure) holds all the information
and attributes in a VM, regarding the device related to the vIOMMU.

As an initial patch, add a per-vIOMMU virtual ID. This can be:
 - Virtual StreamID on a nested ARM SMMUv3, an index to a Stream Table
 - Virtual DeviceID on a nested AMD IOMMU, an index to a Device Table
 - Virtual ID on a nested Intel VT-D IOMMU, an index to a Context Table
Potentially, this vDEVICE structure can hold some vData for Confidential
Compute Architecture (CCA).

Add a pair of vdevice_alloc and vdevice_free in struct iommufd_viommu_ops
to allow driver-level vDEVICE structure allocations.

Similar to iommufd_vdevice_alloc, add an iommufd_vdevice_alloc helper so
IOMMU drivers can allocate core-embedded style structures.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 include/linux/iommufd.h                 | 31 +++++++++++++++++++++++++
 drivers/iommu/iommufd/viommu_api.c      | 14 +++++++++++
 3 files changed, 46 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index c80d880f8b6a..0c56a467e440 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -132,6 +132,7 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_ACCESS,
 	IOMMUFD_OBJ_FAULT,
 	IOMMUFD_OBJ_VIOMMU,
+	IOMMUFD_OBJ_VDEVICE,
 #ifdef CONFIG_IOMMUFD_TEST
 	IOMMUFD_OBJ_SELFTEST,
 #endif
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 069a38999cdd..510fc961a9ad 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -75,13 +75,30 @@ struct iommufd_viommu {
 	unsigned int type;
 };
 
+struct iommufd_vdevice {
+	struct iommufd_object obj;
+	struct iommufd_ctx *ictx;
+	struct iommufd_device *idev;
+	struct iommufd_viommu *viommu;
+	u64 id; /* per-vIOMMU virtual ID */
+};
+
 /**
  * struct iommufd_viommu_ops - vIOMMU specific operations
  * @free: Free all driver-specific parts of an iommufd_viommu. The memory of the
  *        vIOMMU will be free-ed by iommufd core after calling this free op.
+ * @vdevice_alloc: Allocate a driver-managed iommufd_vdevice to init some driver
+ *                 specific structure or HW procedure. Note that the core-level
+ *                 structure is filled by the iommufd core after calling this op.
+ * @vdevice_free: Free a driver-managed iommufd_vdevice to de-init its structure
+ *                or HW procedure. The memory of the vdevice will be free-ed by
+ *                iommufd core.
  */
 struct iommufd_viommu_ops {
 	void (*free)(struct iommufd_viommu *viommu);
+	struct iommufd_vdevice *(*vdevice_alloc)(struct iommufd_viommu *viommu,
+						 struct device *dev, u64 id);
+	void (*vdevice_free)(struct iommufd_vdevice *vdev);
 };
 
 #if IS_ENABLED(CONFIG_IOMMUFD)
@@ -103,6 +120,8 @@ int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx);
 struct iommufd_viommu *
 __iommufd_viommu_alloc(struct iommufd_ctx *ictx, size_t size,
 		       const struct iommufd_viommu_ops *ops);
+struct iommufd_vdevice *
+__iommufd_vdevice_alloc(struct iommufd_ctx *ictx, size_t size);
 #else /* !CONFIG_IOMMUFD */
 static inline struct iommufd_ctx *iommufd_ctx_from_file(struct file *file)
 {
@@ -150,6 +169,12 @@ __iommufd_viommu_alloc(struct iommufd_ctx *ictx, size_t size,
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
+
+static inline struct iommufd_vdevice *
+__iommufd_vdevice_alloc(struct iommufd_ctx *ictx, size_t size)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 #endif /* CONFIG_IOMMUFD */
 
 /*
@@ -163,4 +188,10 @@ __iommufd_viommu_alloc(struct iommufd_ctx *ictx, size_t size,
 						struct drv_struct, member)),   \
 					    ops),                              \
 		     struct drv_struct, member)
+#define iommufd_vdevice_alloc(ictx, drv_struct, member)                        \
+	container_of(__iommufd_vdevice_alloc(ictx,                             \
+					     sizeof(struct drv_struct) +       \
+					     BUILD_BUG_ON_ZERO(offsetof(       \
+						struct drv_struct, member))),  \
+		     struct drv_struct, member)
 #endif
diff --git a/drivers/iommu/iommufd/viommu_api.c b/drivers/iommu/iommufd/viommu_api.c
index c1731f080d6b..8419df3b658c 100644
--- a/drivers/iommu/iommufd/viommu_api.c
+++ b/drivers/iommu/iommufd/viommu_api.c
@@ -55,3 +55,17 @@ __iommufd_viommu_alloc(struct iommufd_ctx *ictx, size_t size,
 	return viommu;
 }
 EXPORT_SYMBOL_NS_GPL(__iommufd_viommu_alloc, IOMMUFD);
+
+struct iommufd_vdevice *
+__iommufd_vdevice_alloc(struct iommufd_ctx *ictx, size_t size)
+{
+	struct iommufd_object *obj;
+
+	if (WARN_ON(size < sizeof(struct iommufd_vdevice)))
+		return ERR_PTR(-EINVAL);
+	obj = iommufd_object_alloc_elm(ictx, size, IOMMUFD_OBJ_VDEVICE);
+	if (IS_ERR(obj))
+		return ERR_CAST(obj);
+	return container_of(obj, struct iommufd_vdevice, obj);
+}
+EXPORT_SYMBOL_NS_GPL(__iommufd_vdevice_alloc, IOMMUFD);
-- 
2.43.0


