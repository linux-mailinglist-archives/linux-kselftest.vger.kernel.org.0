Return-Path: <linux-kselftest+bounces-33255-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2438ABAD1D
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 05:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91A0F1897A00
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 03:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6541898FB;
	Sun, 18 May 2025 03:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eKk2WQmT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1285B35942;
	Sun, 18 May 2025 03:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747538534; cv=fail; b=Z5sExOG5Bv8iGLSLAK+8qRhP1jtqLbk5dOfG4QjjPb0Qe+e2CAy0ElsCOn9snV5g4c21V174Iapzmpgp2f8UMoxsdNIIZJ6GVXtoHlAYpD9YUBBoXlI9lKBucRcN30rs8hL2n8ySoqqvzBS179pYx14hghIHOVaovDMFyV0inEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747538534; c=relaxed/simple;
	bh=AeH2SALNxlOfDn4kOdIMGWgFx0qfmitvTe08NS0joLk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WTtZG9qLWqDs4flmtQCtdWxuwI8j2ESsicDuIpLa2iWKlHso9l5afNWpOq3MCDbAwKDQz9NHGNnrSbpLXNZB6dmkmpx1NjBeh+/0R2E/UDt12J5bDYQKCxNKLbMvzetrTQBxsbIIvg/Fe5o/tZTJ9ehH/C9t5+tBSxBOkncilwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eKk2WQmT; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9sRqxXVRbVd8+9o9xwunEdyOmFmXuY8luJHoW6AU8anVwx/lM7BesQHw/u5xxXxS7oM1bnKoSOAeYhstYZ6yR6hCWk7z7dzmf1kHoZcmFKoO42r1gfw9P/8ulY3YIeuZV/1iBTllG0o+wXejEkbldVa8DHXha6BLwF1+vR3DpMkdt0/0Io32zgQaEHzBm2i3XgSO+0UjWLOZVv62VP6++esGypQ4BYCJq+S7ElQanhoYhjbJnOQ6OFias0vypv+erJgRd1kl1vBd8EbM3q4iAhcRh7Cohr9FOuUOWYEl/mmXDb+0jtwaV5yd58bRIIetP8tCyaI/vGkx3WXt5TwRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/YxI/jM1n1KmWC3occse2dTG4+5+j9wiITbr6MfRF8=;
 b=LySY0E2KMEVgqz/W2ipvDPV8pISkF6x4mhi69DcoZjzqINPOcs6Jdh/w1PrSJA7pwVCDburIAEo9yArZFSgpu0CxOeH+WGS0OSQNEso19BBgtkU1SafArVs5kr8QrIQJo1aISfKXeDgKqqHavytRe/ZvfrlNnyzY1fxAMLstYcfncab459B8RardT8RG7H964qUQdlRuCUZ89EhB6zcgVsyzF/3FoZ2Z/azTJNXMovWQgofJoi6aSuTMU0QPvRKnc+lU+Eg/le/wURU886OBiEh7ObWqv2zoYDtaTeOvzIX0UWVzJzi06AUaLz+vzpIsPfyO/UiYD+xo3Eu4EaBbZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/YxI/jM1n1KmWC3occse2dTG4+5+j9wiITbr6MfRF8=;
 b=eKk2WQmTID8zSQ5ghkh/YSa699pfaLkhHL9l6QpcPgdChLVE5n0fBHd46a2DdLVaLVRIBobxKGzosju2QOfZvaST2+FCRTDgOehDAyhEDTxkXEa+2tJ6RPAlfBOYNMWawt9+ZD6GoafDGN3SW8nGqoHM5lCZYCbtjPaQjMPEGD4uZN8C7UnZDZ2Bx/0p24tt2tPWdP1S+iRy/nYl6gLcQGjY7KMeOYwfrKleLqV2GFKGqLcgOrEKiJXjYX5Ef9lvkNzEzjgzcKN1McGm6q1HuK475OFsj1BWFCCwO/FIy5SHWdvkyOmIKYIVpypVcz+Q85xaXaMrD4tVDFVp56QXEw==
Received: from DS7PR03CA0319.namprd03.prod.outlook.com (2603:10b6:8:2b::27) by
 PH7PR12MB8108.namprd12.prod.outlook.com (2603:10b6:510:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Sun, 18 May
 2025 03:22:07 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::ff) by DS7PR03CA0319.outlook.office365.com
 (2603:10b6:8:2b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.20 via Frontend Transport; Sun,
 18 May 2025 03:22:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Sun, 18 May 2025 03:22:07 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 17 May
 2025 20:21:58 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 17 May
 2025 20:21:58 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 17 May 2025 20:21:56 -0700
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
Subject: [PATCH v5 02/29] iommufd: Introduce iommufd_object_alloc_ucmd helper
Date: Sat, 17 May 2025 20:21:19 -0700
Message-ID: <4cc3e95520bbade9004615d04fdf5624e0b2d51d.1747537752.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|PH7PR12MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: b81a3c70-a1ef-4c15-4364-08dd95bb2b2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R5UgzD3tHpcstv/A3fcIpxfK6hA1JetpZvHx4Wu35KqxE2XZn+TDoAvI4qhU?=
 =?us-ascii?Q?p6Lc/QaO8OcM69AdJ6yBAn5tmtMUwhFht1IvukQgJ4jfJwXiNrIS0jhDIR1x?=
 =?us-ascii?Q?kYh9vp6QUfQdxkdjrSNAOZeGIxPJ6bFaKqrVybztUMRngb7h1tM7Rrnq29DX?=
 =?us-ascii?Q?wpqlpANHZyH+6YrqLl85FP4Zz2PQPl7t9VuHceAaEHwaJ2HIV2IBfQndXV7E?=
 =?us-ascii?Q?Qjj7CFro0oOR553akSQGZeVcdY+m1thFMNLOGG0XMplqRe2immziQ1VkPTRF?=
 =?us-ascii?Q?3Ijtrm8DDwUVgYw8hSkjILz91bjqYhNhHw4++58W2G/gLgsdLZYAEyXGKduH?=
 =?us-ascii?Q?50s6YN/dT1MCt5L0DwRKICcV7WHuZPmNnsVVBjVNnsfC0zjdhzLradEtAUc+?=
 =?us-ascii?Q?wcvaFB+vytouf/FRLNbPHsJu/c2a3h368iSFR5IivM4A1kjqjC7LkAmdi1K8?=
 =?us-ascii?Q?QNvRHdMYbHBqtm0jn3arddAOsVeHIGrVI5rj19L6R+CHbpO8m+t/ssRthTGA?=
 =?us-ascii?Q?flWwrJwYXmwbAFb6ngauQrP2tS8jSb8QkixaC25bdlYf8jbQMQ5+jCpRE0iJ?=
 =?us-ascii?Q?BONRaIHm7FBaGG1TtIzHfxapwS1NUyS3pWPO8Xehh88pJGA+77UCeUVt8mmc?=
 =?us-ascii?Q?U0Q+SNCb/RPS4Uf3Rp+R1meZG+6/q4RkJAVR7sREoScG9DAcFg8bpcfdwPB7?=
 =?us-ascii?Q?+NW+GnBrE/jWhSHOQNOrLn//ezRD/I8MCrIG6kZQsoVi2N9rJim6meJ6dXZ7?=
 =?us-ascii?Q?cun7k/JU4w2Fe2+HTekj22Cutw1w0qVAxDPYTYEX5C9r0H6EY4irFQEOOwsD?=
 =?us-ascii?Q?+fmczgQ57lrJgBppmn43qJBKKDCaVnPLN6z9Z4Q6JwlV3ztr3PVnLH+tHjGA?=
 =?us-ascii?Q?zw8/2cQV+Kqklrivr03JHQ3DFtDErqib8PFmgD4fTBXGABwT3xVzhKwRdNWu?=
 =?us-ascii?Q?6do4WSNmP++cBOrkF27Mn5ci9QNRZrSwWc71cUmm8d5L/qnVADW0YSAG/qca?=
 =?us-ascii?Q?il1/OngVJYkYVtlB2KWVO/Y6+o6dDnObCNKWTZL+3ukXf4iH0gyWn8vQGIts?=
 =?us-ascii?Q?+wCe8CGEJX485aDVrK2nFE5wifNd7ltcnNthQO1oIY9qV+Yb127Ihk0gNrL+?=
 =?us-ascii?Q?87NrHRPE9YltJEQaeeYVHi3BT1Gh/26A17WE4F6Dz5nSolkWCgwYKWMeiuKQ?=
 =?us-ascii?Q?mwQOFXp3gByQalgH4P09Rv8NQPpdcvKaQyu8T1ZjdFXv5vVvMjYt3nKMrBub?=
 =?us-ascii?Q?8uK/hg+8JQK5QphcVjZv9moa8bknKhDqFe2Z5SASXKFRj39xf8T3VkkybSVC?=
 =?us-ascii?Q?iwwJt/TWGm3SRuSufy4CjnaZd6eCccQ/Tl87rppUhGrOjeiD7Usp6Gc9akwm?=
 =?us-ascii?Q?kPK69PIZsL7iGzEBy81yh48LFqJRrFh6+vVa72yYlreZK4L1HKC/yUgZTLft?=
 =?us-ascii?Q?f06WgHSFdw7PgES12b5xVTPaYJic5BvLTGGL9CevVt6YaLcnIO6kh4qFua5L?=
 =?us-ascii?Q?nG3LUqKZ2gS3qURqFEuk3se1PEvIXcDC3k80?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 03:22:07.0961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b81a3c70-a1ef-4c15-4364-08dd95bb2b2b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8108

An object allocator needs to call either iommufd_object_finalize() upon a
success or iommufd_object_abort_and_destroy() upon an error code.

To reduce duplication, store a new_obj in the struct iommufd_ucmd and call
iommufd_object_finalize/iommufd_object_abort_and_destroy() accordingly in
the main function.

This will also ease a driver-allocated object so that a driver can simply
return with an error code to trigger an iommufd_object_abort_and_destroy()
instead of doing an abort itself.

Similar to iommufd_object_alloc() and __iommufd_object_alloc(), add a pair
of helpers: __iommufd_object_alloc_ucmd() and iommufd_object_alloc_ucmd().

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 include/linux/iommufd.h                 | 23 +++++++++++++++++++++++
 drivers/iommu/iommufd/driver.c          | 18 ++++++++++++++++++
 drivers/iommu/iommufd/main.c            |  7 +++++++
 4 files changed, 49 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 10899e2cd34a..16767c231580 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -135,6 +135,7 @@ struct iommufd_ucmd {
 	void __user *ubuffer;
 	u32 user_size;
 	void *cmd;
+	struct iommufd_object *new_obj;
 };
 
 int iommufd_vfio_ioctl(struct iommufd_ctx *ictx, unsigned int cmd,
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 498c9a768506..47f38034f5e7 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -22,6 +22,7 @@ struct iommu_user_data_array;
 struct iommufd_access;
 struct iommufd_ctx;
 struct iommufd_device;
+struct iommufd_ucmd;
 struct iommufd_viommu_ops;
 struct page;
 
@@ -51,6 +52,18 @@ struct iommufd_object {
 	unsigned int id;
 };
 
+#define __iommufd_object_alloc_ucmd(ucmd, ptr, type, obj)                      \
+	container_of(_iommufd_object_alloc_ucmd(                               \
+			     ucmd,                                             \
+			     sizeof(*(ptr)) + BUILD_BUG_ON_ZERO(               \
+						      offsetof(typeof(*(ptr)), \
+							       obj) != 0),     \
+			     type),                                            \
+		     typeof(*(ptr)), obj)
+
+#define iommufd_object_alloc_ucmd(ucmd, ptr, type) \
+	__iommufd_object_alloc_ucmd(ucmd, ptr, type, obj)
+
 struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 					   struct device *dev, u32 *id);
 void iommufd_device_unbind(struct iommufd_device *idev);
@@ -193,6 +206,9 @@ static inline int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx)
 struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 					     size_t size,
 					     enum iommufd_object_type type);
+struct iommufd_object *
+_iommufd_object_alloc_ucmd(struct iommufd_ucmd *ucmd, size_t size,
+			   enum iommufd_object_type type);
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id);
 int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
@@ -208,6 +224,13 @@ _iommufd_object_alloc(struct iommufd_ctx *ictx, size_t size,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline struct iommufd_object *
+_iommufd_object_alloc_ucmd(struct iommufd_ucmd *ucmd, size_t size,
+			   enum iommufd_object_type type)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static inline struct device *
 iommufd_viommu_find_dev(struct iommufd_viommu *viommu, unsigned long vdev_id)
 {
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 922cd1fe7ec2..28dec9e09720 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -36,6 +36,24 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 }
 EXPORT_SYMBOL_NS_GPL(_iommufd_object_alloc, "IOMMUFD");
 
+struct iommufd_object *_iommufd_object_alloc_ucmd(struct iommufd_ucmd *ucmd,
+						  size_t size,
+						  enum iommufd_object_type type)
+{
+	struct iommufd_object *new_obj;
+
+	if (ucmd->new_obj)
+		return ERR_PTR(-EBUSY);
+
+	new_obj = _iommufd_object_alloc(ucmd->ictx, size, type);
+	if (IS_ERR(new_obj))
+		return new_obj;
+
+	ucmd->new_obj = new_obj;
+	return new_obj;
+}
+EXPORT_SYMBOL_NS_GPL(_iommufd_object_alloc_ucmd, "IOMMUFD");
+
 /* Caller should xa_lock(&viommu->vdevs) to protect the return value */
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id)
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 347c56ef44d8..c6d0b446e632 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -416,6 +416,13 @@ static long iommufd_fops_ioctl(struct file *filp, unsigned int cmd,
 	if (ret)
 		return ret;
 	ret = op->execute(&ucmd);
+
+	if (ucmd.new_obj) {
+		if (ret)
+			iommufd_object_abort_and_destroy(ictx, ucmd.new_obj);
+		else
+			iommufd_object_finalize(ictx, ucmd.new_obj);
+	}
 	return ret;
 }
 
-- 
2.43.0


