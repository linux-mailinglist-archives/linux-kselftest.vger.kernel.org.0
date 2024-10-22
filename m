Return-Path: <linux-kselftest+bounces-20347-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 173B59A94BF
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 02:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8A7284AB0
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 00:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CFD149E0E;
	Tue, 22 Oct 2024 00:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mxImxf1s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CAE1474A2;
	Tue, 22 Oct 2024 00:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556453; cv=fail; b=LuoH8i0k/U6pTST0y+qSNeXOHSimzzw3kAfOi6GcYdPtQr+qxMW46lsSes2PArFHbIt7bNyFqJ0TN5Yp9vhqDYd7Iq052iclqCBhGi/Lj/JWJ5DfD12m+MuyoDVDea5cxVR5UlO48NLVsx3U/UUPd0GyQWufDyH7tzaAkMwsN5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556453; c=relaxed/simple;
	bh=VlFL/hdOknL0i6uz7/R6bQdn69KKzLGiXa0PUBr040o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dFL3kjnDMmsEsGiHJ+oWGx6qWumYlxhXadoAPKiarIDKfH8/fSQic6GjRpnc9tuhOnfWcI99I2l+QVcOjZ9hbs/Or0IExXdlYJ04uDbjMw1SLJm9thV0ULnkpNsaHO/sF4WGjN+JK6vdqrhU780L+qnoulTTUlU+fHIiMFPlspM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mxImxf1s; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XcJ4qe5th0qMHOseLsIqoT+tr3H9CDv2WQe3Uys6e7wdJQjpM69yrJTEjg41TAn02yR6xoJuA5mwB3k3JTaafQ6NBmd9sN6aZ3bRsPm2pL2+mOiOoSVn1B9RKZ/gQpgNSwungtqYxHKKf0CirjkeG8rCmLXHG+6P9D7GzZFllwe1Il4HhiSJsBQIW5+upzEzGLF7p3yPM4jH4ulxTo4DUVND65p2TetiHzuNG+yZBM6NG63e+YV3Z2ty6UmB0Og8/OQBXtOciU+WbdA5rAvUpWLin+odwSmOY0jZTLugrPJHcjQdsTBs7+u5p2rlpQ1QVF6hG7CiqDlSz6VqLgyjRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMe0xkfbfek3oUJ4u9XgY3o5rKA8I+tIawv0GGelrJ4=;
 b=VLQ4NXEoMKzkrjlrKefam2oSbeV4tCNT6FFFhkru0GagYvd0xuObYKTX80deh4s6EJjUubWYjVVHM9/fDWAN9rwzWV+MMRByC7mcyBwrMnV8W9/Rjbq4J0cBTmgouQXhxYKX7ycsMPtmvFokUkL/ra905sqZLRcio0aQ+dko9mrrd5ddhQDZ3Yo8KK6jqejp09TTJ7Mb+xNPeXzVtfssRQxV5TEqFouTw15Uj960045RRqdYjHl20Dko2vI+gM2IWc8i2I4BH8eNV/8YkrskhCgp50/nv3kNZb5WptP1kP7RrfE66RYr7eMm/yNF469S4zALccOstwCqpUKcIJbdNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMe0xkfbfek3oUJ4u9XgY3o5rKA8I+tIawv0GGelrJ4=;
 b=mxImxf1sMYkmd1s+NO5wbBwMqPMt+/Yxt3GO5KABscHSH6uaSjRPCkfJNfRC2Z7Qdv+LU/Ik9v8R0UlhBsKWHvB6kmmAHOhgXl7D55wErPr++oGtlzXdCFBe98Orn2XGhnFLzgDTp08xp+xoVZgsMP91y067tREVpR4n3Dka9zgp2EkvHIrf2KaYLZgPylNumAAsLhQ/Rf97XAcI2t+jPINd/ljxIp6Pb8FdDKloD7jzz8F2irNxSdfzaG5tOg/w8i0+drdhYjYb6lDJ4KDfCEdMOYJSM7ehtqI/SgkxQAZrBcfndodOZg79pWXhp9lUTkTKOaPVxsNIMKYRDYFw+g==
Received: from CH0P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::15)
 by CYYPR12MB8704.namprd12.prod.outlook.com (2603:10b6:930:c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 00:20:43 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::bb) by CH0P221CA0010.outlook.office365.com
 (2603:10b6:610:11c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 00:20:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 00:20:43 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:29 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:29 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 17:20:28 -0700
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
Subject: [PATCH v4 01/14] iommufd/viommu: Introduce IOMMUFD_OBJ_VDEVICE and its related struct
Date: Mon, 21 Oct 2024 17:20:10 -0700
Message-ID: <ec230c740b649bba1ca4d2ef054d90c79be4be28.1729555967.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729555967.git.nicolinc@nvidia.com>
References: <cover.1729555967.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|CYYPR12MB8704:EE_
X-MS-Office365-Filtering-Correlation-Id: 606f3953-a316-4161-5419-08dcf22f5df1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tiw4slHGcZjLpRU4o5GL1WyuTnsdlMXjW1oNc91eoicNgChyuyXpr+UScnz9?=
 =?us-ascii?Q?gN7rJO9WPXJYMVFPEeGXeqWN9PrIdT1HJEbizsdebVWPEd/F5Zmg8sV+alXP?=
 =?us-ascii?Q?fR6hnGE0GWxUGNR6yIZU3s4yNCuUjRoormOyGrTDxvPHn8iHFhSmw2jmMZOw?=
 =?us-ascii?Q?HIn1UK0qVjnN5JCNEr+BMYEe0BpC0HjSt4U0kDvHeXT5KpZkkI+1wZ5Ic0xa?=
 =?us-ascii?Q?RDUB4xfNj9GhaxrabNRujCduyTBwmDY0NEEppeMdQs4AdFEXAS+obUOhlfK3?=
 =?us-ascii?Q?in21tCkanAGlJ28FAy+BL22mbztDWq/l7/s8aAiqIW57Va1TjoNBV6rv9HMH?=
 =?us-ascii?Q?9xXcgMTD0alWzTsMYaqGV7NGHZbL46ZUM0jn3NDCo6GwgosgG0P+6qg0Trbp?=
 =?us-ascii?Q?/mx/ichSAAP42y6eJIUYtYf7JniSRMEjV4Ze/ahyHSlUq5XHiK3UsBVeI5xm?=
 =?us-ascii?Q?0DNZYI/PS90KX7k27idZL8rGESqGZ2OY4VH6pAYb+CsIlBkoHhKLtp3bRZLc?=
 =?us-ascii?Q?//1neX6hHBDQHxNXCbWCy1eYxnJrKO+uuEnI8QuwiYEEKpuxVBYgpWlA3hgr?=
 =?us-ascii?Q?xaFiw5Bg89BnJbcyDH15D4eJZYHV3JIy+8Yw/bfV1Plaz5Xyy1Bn+6DoCTE9?=
 =?us-ascii?Q?8aMymDWiZHXt6jaStRjQ5W4usIWGWPaqfX5I/0ybMg+xEYlR6ZzHiY7Q35Fz?=
 =?us-ascii?Q?pLtgasDeu42bS3SIZ+T1VxWFE880ZN3XApXuqHRW5nD1feL+dF79r2cjwLLD?=
 =?us-ascii?Q?L7i8WViY+2RGt8fK9rVbVHAp0r7sBIqj44rXC+HXRRxwzdhumwijKl93Yw0G?=
 =?us-ascii?Q?jbW4V8PP98JHTPXekKDYzQ/B3zl3qd0ukFFLrfBqSha2bFbrnDmUnJokULyP?=
 =?us-ascii?Q?y+DQ7EYBXQOtSnPQBxAYKDgGTgtpTte05bJvTCrHHHVXo/ZsgZXsaecta1mx?=
 =?us-ascii?Q?/1JxxJ3HhgkoK1Iskg7OUdmPDVCyh7co/iH4mNkTUuNGEUPUluwZ4uwYjTGZ?=
 =?us-ascii?Q?f/1sogFj7Y1+9CyTeNuyKdglLwZoA/zTW+MD9pi/7RJ1g0ou+GfMiTijkasV?=
 =?us-ascii?Q?z9xdb/+M9pT8U09MBoD0vK9pgj/azS4+Xn1kRgf9e4azbFCLYHl42INgTsia?=
 =?us-ascii?Q?YOCkQpe+Hhv1tC6e732MQtELzmRbvggnTB6+SSrh1QVy53QJK7sx2A1Mfbdj?=
 =?us-ascii?Q?8Eud/WfxhDHNdwlOT29h5EFiXOOfFTP2V0K2gIC8lGL2/7n/BN8AxwCTuJ21?=
 =?us-ascii?Q?n2mvc6P8gBXy0KeHxccxuy1YX8304Kh+TlxHH2eapJjLTiz0br7XqMgwzJky?=
 =?us-ascii?Q?M5bU+c6HfsEmf3nNegR28zLG8p7KN8KaBZkPL53uDDhws6DMgv4BWtjESpqC?=
 =?us-ascii?Q?lqSnMI/X6xyBEzDqrWNg3ZC2N21kc0BnkQ4ufOHkAXMAY2H2dQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 00:20:43.1530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 606f3953-a316-4161-5419-08dcf22f5df1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8704

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

Similar to iommufd_viommu_alloc, add an iommufd_vdevice_alloc helper, so
IOMMU drivers can allocate core-embedded style structures.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 5c13c35952d8..5d61a1d2947a 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -31,6 +31,7 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_ACCESS,
 	IOMMUFD_OBJ_FAULT,
 	IOMMUFD_OBJ_VIOMMU,
+	IOMMUFD_OBJ_VDEVICE,
 #ifdef CONFIG_IOMMUFD_TEST
 	IOMMUFD_OBJ_SELFTEST,
 #endif
@@ -92,6 +93,14 @@ struct iommufd_viommu {
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
@@ -101,12 +110,24 @@ struct iommufd_viommu {
  *                       must be defined in include/uapi/linux/iommufd.h.
  *                       It must fully initialize the new iommu_domain before
  *                       returning. Upon failure, ERR_PTR must be returned.
+ * @vdevice_alloc: Allocate a driver-managed iommufd_vdevice to init some driver
+ *                 specific structure or HW procedure. Note that the core-level
+ *                 structure is filled by the iommufd core after calling this op.
+ *                 It is suggested to call iommufd_vdevice_alloc() helper for
+ *                 a bundled allocation of the core and the driver structures,
+ *                 using the ictx pointer in the given @viommu.
+ * @vdevice_free: Free a driver-managed iommufd_vdevice to de-init its structure
+ *                or HW procedure. The memory of the vdevice will be free-ed by
+ *                iommufd core.
  */
 struct iommufd_viommu_ops {
 	void (*free)(struct iommufd_viommu *viommu);
 	struct iommu_domain *(*domain_alloc_nested)(
 		struct iommufd_viommu *viommu,
 		const struct iommu_user_data *user_data);
+	struct iommufd_vdevice *(*vdevice_alloc)(struct iommufd_viommu *viommu,
+						 struct device *dev, u64 id);
+	void (*vdevice_free)(struct iommufd_vdevice *vdev);
 };
 
 #if IS_ENABLED(CONFIG_IOMMUFD)
@@ -200,4 +221,15 @@ _iommufd_object_alloc(struct iommufd_ctx *ictx, size_t size,
 			ret->member.ops = viommu_ops;                          \
 		ret;                                                           \
 	})
+#define iommufd_vdevice_alloc(ictx, drv_struct, member)                        \
+	({                                                                     \
+		static_assert(                                                 \
+			__same_type(struct iommufd_vdevice,                    \
+				    ((struct drv_struct *)NULL)->member));     \
+		static_assert(offsetof(struct drv_struct, member.obj) == 0);   \
+		container_of(_iommufd_object_alloc(ictx,                       \
+						   sizeof(struct drv_struct),  \
+						   IOMMUFD_OBJ_VDEVICE),       \
+			     struct drv_struct, member.obj);                   \
+	})
 #endif
-- 
2.43.0


