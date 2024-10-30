Return-Path: <linux-kselftest+bounces-21176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C6E9B6F59
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 22:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69591F225D1
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 21:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035C5218D8C;
	Wed, 30 Oct 2024 21:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JuhfXnBN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2086.outbound.protection.outlook.com [40.107.96.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B743218D78;
	Wed, 30 Oct 2024 21:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324171; cv=fail; b=J1cWwXyXaUQ9la/0+jwzo711KxcRvKme5eaBXAWzuVb1ppWX6Snf2g1d6XSVekmeF2W9v/k4Yw8IqA3ps4eR7uvZE7K+fMq17KFF5vpWHkv+8Rj2kB8bJzIvPaovYXDNCfFSxqQB5pDC4fc2DkwL4IRCt8RATMXH0Q052tKvdfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324171; c=relaxed/simple;
	bh=HoA+RdkssMco4DIWEuq4UJpgdlKrt83kFWlHqMN9V0A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hnV0PNF2bghgDE+mJ/invGGzfQTwXq7LdUGS5k2XGmX8f7KhPZijShR2tLcc9WwFYveINv/RWkgo9iuu9Ib6HkDW/siCHN1MkdMvXXOqvBmlAc/J/Ytwvu6vH3LtxMtd/sjW6/JM1Zlwb/p34qAQ7og3eAjk5/PXv0IPlMc9YS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JuhfXnBN; arc=fail smtp.client-ip=40.107.96.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qiXY7Zl7ZtVlII3/e2pRt3/cJ2Zlc4nPwPekbHJPuaTcnTgsaI2kFOeIJQDqn72SUObuUFysGeDNbkFwvKeo4oi92UnqZJoGoewRvMQPacy0kP2rWWy2CjE+DK48K/SdGFKrbkudY6RNEtxS0j0Xwy9Q4cTHbsNPHudm7fLFt7e03Wz6KlUX0Fxn2MQq2VIeNinI85GUmiJYKF/G9uaoCP46BdWssTwGxI6Wqz6G9Y3n/LVc3igvYV3tirg+EoVEscqA95oD5Tn2F/JQIReQHu6nrmc5sJ3b9reRK8Oby/HYONx9WVXa8AFl6mNdsergPLZRVkO9ymwwcTY7bJmm6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVLHRBxYbtcfgUrUc/V9J+8H64KeU3weasNGELhHKtA=;
 b=h9z52pXrYd+jUXKxk4y99jyEyC7rXzjBL1J4cuU1Gn22T4HAG6t5GMxveF/CMPqeOmz1canNX2u7jpYlJxJCSTdbB9wHiXlBKF3/zowUif1c1IQaElutD3tg81DN7QQIXrLx5jL9vxoQGFUVm6ojMV3ggE5diV1dArcHVK/W5MRYeD+IBctougWqDP8dBy7QvK3GhqMOG+8IGxx8gv9VFgFKKaacIHjNQAjEUDP9LkBvHgyV/yPHALyJOfW3kgJG7UgJKfWeOOoEkK2poYwTSSlNHET3u5Y5PPy6yUOHJAAIMt+4ksnoaSX4GLN7cqYfDNrh3bCmHLcc3Im1B7iIGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVLHRBxYbtcfgUrUc/V9J+8H64KeU3weasNGELhHKtA=;
 b=JuhfXnBNe9ZcvDZSAwKexHYGIXDHIUY2vxIPzS1qLXhye9ekeOQO/VSMG584UAuCH5Nm0UbcM+VUzBl5t9kYTuQTxigIqUacVjVLD/d6G8wvrQl337iYeVluYIiu5V9/OxSN6oSbgf+4/iG7VsPVLEMePBGKz2B+wIeWISuQmfrQByfnXVnOX47xIYXoXw+b20cac57aj9ARxl96XTv5o+gP3FpXfRpMiVxyCQLgUNd7lFQL3lw+RXu+4SLf5q9nFxJIsnqgV+2ZZxW97EXNqJKC9ghK5ZWtEhCFm2CkoXbfX5Pnf1owO54dNRFr8Y0rF0B4yt1MJIzQUPJPhTcz5A==
Received: from BN9PR03CA0500.namprd03.prod.outlook.com (2603:10b6:408:130::25)
 by CH3PR12MB8935.namprd12.prod.outlook.com (2603:10b6:610:169::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.28; Wed, 30 Oct
 2024 21:36:06 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:130:cafe::b9) by BN9PR03CA0500.outlook.office365.com
 (2603:10b6:408:130::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.31 via Frontend
 Transport; Wed, 30 Oct 2024 21:36:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 21:36:05 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Oct
 2024 14:35:41 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Oct
 2024 14:35:40 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 30 Oct 2024 14:35:39 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <shuah@kernel.org>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<baolu.lu@linux.intel.com>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<yi.l.liu@intel.com>, <aik@amd.com>, <zhangfei.gao@linaro.org>,
	<patches@lists.linux.dev>
Subject: [PATCH v6 01/10] iommufd/viommu: Add IOMMUFD_OBJ_VDEVICE and IOMMU_VDEVICE_ALLOC ioctl
Date: Wed, 30 Oct 2024 14:35:27 -0700
Message-ID: <19e20e54d41a0c1ab7403264e1016c4b19293135.1730313494.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730313494.git.nicolinc@nvidia.com>
References: <cover.1730313494.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|CH3PR12MB8935:EE_
X-MS-Office365-Filtering-Correlation-Id: 1051dd17-56f2-4afd-a25b-08dcf92adc1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?snMrVRImVd525dG+odoDr3mvA3dRFxTOiwmtmiycRo1IVY7ouX4xBwwTqrUN?=
 =?us-ascii?Q?JIIr1VvUlshpRVuGrCI7Tk335CUS6S6kQTEiy9Z+abrw6pmBJga9nDEYVl/o?=
 =?us-ascii?Q?+0rGZmoMBMGjVvw+AlPqT3k3njIwpbkvQO+ITPA5qmbz/HeNkyFPDf1cMfZ7?=
 =?us-ascii?Q?IwtfsG3/UyvNXZ0jD/hc7GWBQhgeeyGLqknSkglA8hb79bHgG7zhT2oZ+v24?=
 =?us-ascii?Q?koJV07HmUV8jaDGWx76Lq6ECtFHJS/p++BpOZ6KU33c0ItzR46iLAsAmYclh?=
 =?us-ascii?Q?Y9wN3vl8g0oGwSV80xuVdJd5cLbmZZOu1U3JEBpIQLcEyQxF3fdU53BljhYL?=
 =?us-ascii?Q?lm+oOZB7xdUejY+o2n5rjYi5w3s2Dmbl35PQgZVID47aFzU81cuMdF1SeqxL?=
 =?us-ascii?Q?lgn19+qTmjNXEcW+3Pg1si1D6oXV79oBQSJKoQBDCZHwMFAAOCAoBvcE+Z/f?=
 =?us-ascii?Q?ddZNlQsXXSw3XfzbwhZ0vYYpbqsCV/0d3rJI2iE20BzGDq58wIAkPfPKRrCz?=
 =?us-ascii?Q?/W7jgaG1NhL8m8mLJ9l8w6e2aCbncTXsZPmbYUevsWxmOTLHpdyQB2tdsrXE?=
 =?us-ascii?Q?6HQp8paI856zIg8A1Fr41cbiY0CQ5H4lH8SN18LI8dWcusiXDiyt1zv9Esnb?=
 =?us-ascii?Q?PjwTNDqWbahWeLOknzSxU8sqIXi2VamWyR8sDi0BWsZLrvYOZ9CF9LxUysWy?=
 =?us-ascii?Q?RjNRdlam15qqL4ObqGHzsLRUvBvaikRD6yNxZoUCMuadIhgrZ2BXcw4gThMf?=
 =?us-ascii?Q?QzU2NY0iukm4v/yL1XbDKe0poUc456DA5JFyaqa1Kg3hQOrVpVFA4kkiXIbU?=
 =?us-ascii?Q?SbojND9ujtS5oiLUgk3zriMAptMG6ebHV5SYtcLAeEPCNQ7c5IkcdlB4ObUD?=
 =?us-ascii?Q?eahs5esdNO+fqOYkRin5/NQuXMDzGwhfrJ7OsHPJP6M7LiIE2S1pT0t/K/Ur?=
 =?us-ascii?Q?G6rhc47oNY77tg2mGthN/TuD113OV8gXuKt1oGd73b8SS8HQiEajvvVZW3Du?=
 =?us-ascii?Q?qcU8hI4MaB144TzxP7lOP9LvXoA8CC5xsBF1tN3OA1yfdswHix5gdqjyQEvp?=
 =?us-ascii?Q?wQFVYv92DTYnKECtbjfx5bcZRVu4Rr4Hfo1BAzjDF530l/ycv9RxbCXy0SIs?=
 =?us-ascii?Q?jT4YBbkPtYX+G/tQ+USBb6MX9uSwoxiUv1+2mVZpNyoX3qBWmsTWHqxAp1dh?=
 =?us-ascii?Q?x4CcRthC/5dqHG3aObmKfr8DA336l8IRb+HQxClAFw8bnUWrbugSMC9oxrGr?=
 =?us-ascii?Q?QBLuusvJjrM1Pz7g2tKSB5Ut9AKaN7+zrq7FAByrQD9TNU2tifa8vmXxorVG?=
 =?us-ascii?Q?D7VBGULieT1zHu1DHXiG/WFnHAs84siFk4fxM1h3ByXxigCwOBglOYkZuXuZ?=
 =?us-ascii?Q?cOloSG0aNMrn9xkUN0q25djzCyHXmUykZlr39RXmC76XwyQdyg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 21:36:05.4477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1051dd17-56f2-4afd-a25b-08dcf92adc1b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8935

Introduce a new IOMMUFD_OBJ_VDEVICE to represent a physical device (struct
device) against a vIOMMU (struct iommufd_viommu) object in a VM.

This vDEVICE object (and its structure) holds all the infos and attributes
in the VM, regarding the device related to the vIOMMU.

As an initial patch, add a per-vIOMMU virtual ID. This can be:
 - Virtual StreamID on a nested ARM SMMUv3, an index to a Stream Table
 - Virtual DeviceID on a nested AMD IOMMU, an index to a Device Table
 - Virtual RID on a nested Intel VT-D IOMMU, an index to a Context Table
Potentially, this vDEVICE structure would hold some vData for Confidential
Compute Architecture (CCA). Use this virtual ID to index an "vdevs" xarray
that belongs to a vIOMMU object.

Add a new ioctl for vDEVICE allocations. Since a vDEVICE is a connection
of a device object and an iommufd_viommu object, take two refcounts in the
ioctl handler.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 18 ++++++
 include/linux/iommufd.h                 |  4 ++
 include/uapi/linux/iommufd.h            | 22 +++++++
 drivers/iommu/iommufd/main.c            |  6 ++
 drivers/iommu/iommufd/viommu.c          | 76 +++++++++++++++++++++++++
 5 files changed, 126 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index e8f5ef550cc9..062656c19a07 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -507,8 +507,26 @@ static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 	return iommu_group_replace_domain(idev->igroup->group, hwpt->domain);
 }
 
+static inline struct iommufd_viommu *
+iommufd_get_viommu(struct iommufd_ucmd *ucmd, u32 id)
+{
+	return container_of(iommufd_get_object(ucmd->ictx, id,
+					       IOMMUFD_OBJ_VIOMMU),
+			    struct iommufd_viommu, obj);
+}
+
 int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_viommu_destroy(struct iommufd_object *obj);
+int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
+void iommufd_vdevice_destroy(struct iommufd_object *obj);
+
+struct iommufd_vdevice {
+	struct iommufd_object obj;
+	struct iommufd_ctx *ictx;
+	struct iommufd_viommu *viommu;
+	struct device *dev;
+	u64 id; /* per-vIOMMU virtual ID */
+};
 
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index f03c75410938..ee58c5c573ec 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -10,6 +10,7 @@
 #include <linux/errno.h>
 #include <linux/refcount.h>
 #include <linux/types.h>
+#include <linux/xarray.h>
 
 struct device;
 struct file;
@@ -31,6 +32,7 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_ACCESS,
 	IOMMUFD_OBJ_FAULT,
 	IOMMUFD_OBJ_VIOMMU,
+	IOMMUFD_OBJ_VDEVICE,
 #ifdef CONFIG_IOMMUFD_TEST
 	IOMMUFD_OBJ_SELFTEST,
 #endif
@@ -89,6 +91,8 @@ struct iommufd_viommu {
 
 	const struct iommufd_viommu_ops *ops;
 
+	struct xarray vdevs;
+
 	unsigned int type;
 };
 
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index a498d4838f9a..9b5236004b8e 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -53,6 +53,7 @@ enum {
 	IOMMUFD_CMD_FAULT_QUEUE_ALLOC = 0x8e,
 	IOMMUFD_CMD_IOAS_MAP_FILE = 0x8f,
 	IOMMUFD_CMD_VIOMMU_ALLOC = 0x90,
+	IOMMUFD_CMD_VDEVICE_ALLOC = 0x91,
 };
 
 /**
@@ -864,4 +865,25 @@ struct iommu_viommu_alloc {
 	__u32 out_viommu_id;
 };
 #define IOMMU_VIOMMU_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_ALLOC)
+
+/**
+ * struct iommu_vdevice_alloc - ioctl(IOMMU_VDEVICE_ALLOC)
+ * @size: sizeof(struct iommu_vdevice_alloc)
+ * @viommu_id: vIOMMU ID to associate with the virtual device
+ * @dev_id: The physical device to allocate a virtual instance on the vIOMMU
+ * @out_vdevice_id: Object handle for the vDevice. Pass to IOMMU_DESTORY
+ * @virt_id: Virtual device ID per vIOMMU, e.g. vSID of ARM SMMUv3, vDeviceID
+ *           of AMD IOMMU, and vRID of a nested Intel VT-d to a Context Table
+ *
+ * Allocate a virtual device instance (for a physical device) against a vIOMMU.
+ * This instance holds the device's information (related to its vIOMMU) in a VM.
+ */
+struct iommu_vdevice_alloc {
+	__u32 size;
+	__u32 viommu_id;
+	__u32 dev_id;
+	__u32 out_vdevice_id;
+	__aligned_u64 virt_id;
+};
+#define IOMMU_VDEVICE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_ALLOC)
 #endif
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index cc514f9bc3e6..d735fe04197f 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -308,6 +308,7 @@ union ucmd_buffer {
 	struct iommu_option option;
 	struct iommu_vfio_ioas vfio_ioas;
 	struct iommu_viommu_alloc viommu;
+	struct iommu_vdevice_alloc vdev;
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
 #endif
@@ -363,6 +364,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 __reserved),
 	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
 		 struct iommu_viommu_alloc, out_viommu_id),
+	IOCTL_OP(IOMMU_VDEVICE_ALLOC, iommufd_vdevice_alloc_ioctl,
+		 struct iommu_vdevice_alloc, virt_id),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
@@ -501,6 +504,9 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_VIOMMU] = {
 		.destroy = iommufd_viommu_destroy,
 	},
+	[IOMMUFD_OBJ_VDEVICE] = {
+		.destroy = iommufd_vdevice_destroy,
+	},
 #ifdef CONFIG_IOMMUFD_TEST
 	[IOMMUFD_OBJ_SELFTEST] = {
 		.destroy = iommufd_selftest_destroy,
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 888239b78667..c82b4a07a4b1 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -11,6 +11,7 @@ void iommufd_viommu_destroy(struct iommufd_object *obj)
 	if (viommu->ops && viommu->ops->destroy)
 		viommu->ops->destroy(viommu);
 	refcount_dec(&viommu->hwpt->common.obj.users);
+	xa_destroy(&viommu->vdevs);
 }
 
 int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
@@ -53,6 +54,7 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		goto out_put_hwpt;
 	}
 
+	xa_init(&viommu->vdevs);
 	viommu->type = cmd->type;
 	viommu->ictx = ucmd->ictx;
 	viommu->hwpt = hwpt_paging;
@@ -79,3 +81,77 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &idev->obj);
 	return rc;
 }
+
+void iommufd_vdevice_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_vdevice *vdev =
+		container_of(obj, struct iommufd_vdevice, obj);
+	struct iommufd_viommu *viommu = vdev->viommu;
+
+	/* xa_cmpxchg is okay to fail if alloc returned -EEXIST previously */
+	xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
+	refcount_dec(&viommu->obj.users);
+	put_device(vdev->dev);
+}
+
+int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_vdevice_alloc *cmd = ucmd->cmd;
+	struct iommufd_vdevice *vdev, *curr;
+	struct iommufd_viommu *viommu;
+	struct iommufd_device *idev;
+	u64 virt_id = cmd->virt_id;
+	int rc = 0;
+
+	/* virt_id indexes an xarray */
+	if (virt_id > ULONG_MAX)
+		return -EINVAL;
+
+	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
+	if (IS_ERR(viommu))
+		return PTR_ERR(viommu);
+
+	idev = iommufd_get_device(ucmd, cmd->dev_id);
+	if (IS_ERR(idev)) {
+		rc = PTR_ERR(idev);
+		goto out_put_viommu;
+	}
+
+	if (viommu->iommu_dev != __iommu_get_iommu_dev(idev->dev)) {
+		rc = -EINVAL;
+		goto out_put_idev;
+	}
+
+	vdev = iommufd_object_alloc(ucmd->ictx, vdev, IOMMUFD_OBJ_VDEVICE);
+	if (IS_ERR(vdev)) {
+		rc = PTR_ERR(vdev);
+		goto out_put_idev;
+	}
+
+	vdev->id = virt_id;
+	vdev->dev = idev->dev;
+	get_device(idev->dev);
+	vdev->viommu = viommu;
+	refcount_inc(&viommu->obj.users);
+
+	curr = xa_cmpxchg(&viommu->vdevs, virt_id, NULL, vdev, GFP_KERNEL);
+	if (curr) {
+		rc = xa_err(curr) ?: -EEXIST;
+		goto out_abort;
+	}
+
+	cmd->out_vdevice_id = vdev->obj.id;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_abort;
+	iommufd_object_finalize(ucmd->ictx, &vdev->obj);
+	goto out_put_idev;
+
+out_abort:
+	iommufd_object_abort_and_destroy(ucmd->ictx, &vdev->obj);
+out_put_idev:
+	iommufd_put_object(ucmd->ictx, &idev->obj);
+out_put_viommu:
+	iommufd_put_object(ucmd->ictx, &viommu->obj);
+	return rc;
+}
-- 
2.43.0


