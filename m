Return-Path: <linux-kselftest+bounces-34988-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C307AD9AC2
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 09:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0501E16C17A
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 07:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CE620DD40;
	Sat, 14 Jun 2025 07:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pJH0ecrJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C0620C46F;
	Sat, 14 Jun 2025 07:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749885340; cv=fail; b=gS5XVUSgOL/LWEafVwZX+aCop8WDNIj6cJEk+iqHVKJACvF6hRFrM/p7TSFRDBUW1IUBq7GN0gEzFLSqjJXeSWsy9JfH062vWmM+TszF2wxWpKm9zBKfIar723AUNHO3lmlSI2xOs8IYR092YA+KthuHkMh36JqJfD6mhGS/GsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749885340; c=relaxed/simple;
	bh=Aud5bNYVvoTU2/2tXFFAqZ7HVmrPKFqvJhbsHRqZeMM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tY3ZBwlRqnwMBLtKG1ka1Q29nvRL96uwKyFv+DEYhui92kaX5KTin0dkDEJakP2xLd///4wAmSwgpru8aBs1uVBctdN4o20wcKTxNeVd0R4NNXflGZydw7bZSbt+oTopMCWtmRRJAlKdcaajnrDEISVnvkAEUoB/zme/JlKdQRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pJH0ecrJ; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qybxt0VNXbvGnk118z3F2TOgdnS5usB4T6XVxtn9t6dbgiWVBXtOkJYirccY3rUO6Xc1fo6sXB9nkzgpbI2CCNPDrCGQAA80ZfePyqk9o2Ta0IrD0LWUfiwKJN9tCWCz2Y6HWJa+Jc2DQAOjkIF9viwTTxwdLZlYGJTErB0qt6BKMvwGGcudAxVTdeMsat4rnKyBmDFecOYt4MosCKQ3/jM2+xDq74p/nt8ptSxbVHU1VEWBJdzEXU/OWfD5P8T8CSaThB1gv2qnVqO/MACImsq4qjPNppVg4F1uB//rR9OBnIuMtkY+6PsQR7qQQVr2td2/sV9WVynypExWohzoMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrU3iVxo/Ysuw4Jvr0PG6mcSiGFGD7mirBk9+ZSlUlk=;
 b=GF3oqyBNjN00iK+ZHjgaS2T3iMu+8EyKTWgmIl2xQuMmHj5o1OXdmTwLCbM3DP9Cn9/V8hZfs+fl9GpL8QqlNxO7tkmJaJKJXq1DEOMZT6Vdunot+H1N6OEa/mJoGTocGnsk40Yt7m2bjDLn/VQusQ2Teu8LhS55HTEDfLjZAyubFM27GsCftOFZ0VY3bF1GhJvaRzFgIDSq/v7tarlhh7AC4Q1virx88Os+z084n/KZZYsmMR6xJpBtYMWctB1Pcx1kH4Vzp+lOwrH7d/n5nWwBKsOU9QOg+DyqPj6NMA/WbXQisOaNiKqJ85dlW6vO/QZlrylO2EcPKqmYR7Gmsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrU3iVxo/Ysuw4Jvr0PG6mcSiGFGD7mirBk9+ZSlUlk=;
 b=pJH0ecrJN9uqcLQYGkXjyYXfb9xHAs1hJC2ixWnHL7XV1v550dokVme/0AW+vKN5WqAdIXlAuRxOoCKlibT1GTY+nrzMPv1hiCa9DcOplAFdxHF7G3nDybSDRlk3nuwtpIy5FEHLqiocztHySXJlWcNCDRRt0fdS1/7QdMcd2D6iBYAiFaEzx5MYSUvS+F8EX2n0HvThFj5zHn1xukQLjcLxwRr9PUcxxbmyA77Jvx8VON5jk+w+qNbEeXuRGkdeBy1446y1qd2yr8jCqUGrOzer9iwXjIvw37wlU7++Jbr2rfHaUV9c+i4Htk355MD1kLDwZorOl/20ckGXcEyndw==
Received: from BN9PR03CA0674.namprd03.prod.outlook.com (2603:10b6:408:10e::19)
 by SN7PR12MB8103.namprd12.prod.outlook.com (2603:10b6:806:355::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Sat, 14 Jun
 2025 07:15:34 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:408:10e:cafe::5b) by BN9PR03CA0674.outlook.office365.com
 (2603:10b6:408:10e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Sat,
 14 Jun 2025 07:15:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Sat, 14 Jun 2025 07:15:34 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 14 Jun
 2025 00:15:18 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 14 Jun
 2025 00:15:18 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 14 Jun 2025 00:15:16 -0700
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
Subject: [PATCH v6 11/25] iommufd/driver: Add iommufd_hw_queue_depend/undepend() helpers
Date: Sat, 14 Jun 2025 00:14:36 -0700
Message-ID: <e3b195d74539d065397f6b1382127438fc256ec4.1749884998.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|SN7PR12MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: 6efe7595-c9da-45b1-5798-08ddab13415e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5gdTt2tUxU4iQ3ewCwuCc248ZrtlezcQBUWYz+tvusBv/aA7w1q4ct3uhznL?=
 =?us-ascii?Q?NEPJg9qftkmHDwIwF+dBcNgtbSza9iYTKY++UqUg02O0yvr8OWPcCxPw5ePx?=
 =?us-ascii?Q?nHyxjXxHFA9FsRypZ/UmYk6rJr+MOuiXsYexYECk/sZ8U+oufNSMrmHKJRt9?=
 =?us-ascii?Q?1uDyn5fEekRyp0EsKyYFZ2NUrheA9/z+kIl0tRpJwV3CZ52QGDc47DimRRKC?=
 =?us-ascii?Q?qmKTA9C5o96ysnrUWgTR7Y2Tqs3qp0DFXFGJ2J+aHRF2I77vajNQ3Q5j7gt/?=
 =?us-ascii?Q?SpYl3Oa33NYIEZ3EkAcXrj5H+kf3ofUlpC2OpOCfU9FmRgecfFLK8rXKcPS/?=
 =?us-ascii?Q?Hz9J51oJDX8QpLhOG5JRu67b8KeADtUj62BU4xig0yuqKzCadW4MmGzybw4K?=
 =?us-ascii?Q?A1eegXperTF4WG7Q4SoK7cdNrhkuJlygUTIacWd6GKtoWXmemo05RRA+lkq2?=
 =?us-ascii?Q?riFErLA+iql/303eZyRSp/Brf4XUqyZZvFogbjG9j/uU23A3WdzzFWzeyfYn?=
 =?us-ascii?Q?3uCbok4VYCLk0vET8hHuh6CSDRaFpl9lS+z15Gl+Ky2+8EwC4XTX7zqDjooW?=
 =?us-ascii?Q?qTmKybIB5P/7zfIeMXQLuY21HOiUe9CZDsM/CUQ/0faZ63AnoVXY/AJAmBTv?=
 =?us-ascii?Q?EtaCU6N6eSuOdPThOggCUzmEKWvHWuU6So3ZCS/H84StSjQYGDPKWZWAfwec?=
 =?us-ascii?Q?7zC82nJyuBqlxfEPnnc3kriLznfK2lU3a3NMQ2zJgd2J2su7278YqVVmQHHq?=
 =?us-ascii?Q?f+tWgFHHiM8QlahhHwF/DFqGi6jE+YL49aIixRjA66dFojrN51fXmHIAZYFt?=
 =?us-ascii?Q?d93DLJb0+/w8+yYAkpeh0bfmFTZvNqJPWLCiIa/pV4Ug80QDsCGzYQCgTKmx?=
 =?us-ascii?Q?etUcytu5645mADDNneR4QotQRTv0FhWmPp/9BhJdvxY3YCZ89bqS4R6pTaLp?=
 =?us-ascii?Q?0VofGDd5TwWPVJKZFhW+CrTGNGganWWr2+pMkkzY9a1vopkGUb87PmBhxMqv?=
 =?us-ascii?Q?z0XedSkoo9APpEuncL18rGTTSujnW9sEePe8qPQvY4pG3wy7g/ITfRfGI6MJ?=
 =?us-ascii?Q?7H3bzBcCMoAXgvv0miCY0fq+y/pklHa9vFIzVcZbkgNFczpaHw4WM5tdgVOa?=
 =?us-ascii?Q?GJ1VOlFZRjvAaFgb8ArV5TS0n2T7cELPf9FWQP3wH1nWptpvytnFtExUy5Z+?=
 =?us-ascii?Q?5pN/tf5qgLC+blOZziAoVDwqzcIXpJqTckjOvhfhDPXM4fpvf1NIG81L8UqR?=
 =?us-ascii?Q?hArKDfYTq7a5z4wEuDt8Qs9QU3Waz3g/koMGvq+6n0twuvnNvwuezfqg/nhz?=
 =?us-ascii?Q?WE+javliAuRNd/07dK7Bbg26ALTBKsJr5qm5YRE2CHBWMlJGG6/kdjY6Qhdp?=
 =?us-ascii?Q?K9JuIQ+hxhP/QvdmmsrqqKms62gfkOjy3eqeTzudYrb+7aZ8hQf/ypKD5zNZ?=
 =?us-ascii?Q?7B+9GREesb8BZqByWV7k4PCMuIwoxvBtyrhCG6ZsQMCoV4HwxECr+5PWXaiB?=
 =?us-ascii?Q?BrL/LiXdnyW2X2RySuX9uK1quhD9ZBhNCAYt?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 07:15:34.3937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6efe7595-c9da-45b1-5798-08ddab13415e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8103

NVIDIA Virtual Command Queue is one of the iommufd users exposing vIOMMU
features to user space VMs. Its hardware has a strict rule when mapping
and unmapping multiple global CMDQVs to/from a VM-owned VINTF, requiring
mappings in ascending order and unmappings in descending order.

The tegra241-cmdqv driver can apply the rule for a mapping in the LVCMDQ
allocation handler. However, it can't do the same for an unmapping since
user space could start random destroy calls breaking the rule, while the
destroy op in the driver level can't reject a destroy call as it returns
void.

Add iommufd_hw_queue_depend/undepend for-driver helpers, allowing LVCMDQ
allocator to refcount_inc() a sibling LVCMDQ object and LVCMDQ destroyer
to refcount_dec(), so that iommufd core will help block a random destroy
call that breaks the rule.

This is a bit of compromise, because a driver might end up with abusing
the API that deadlocks the objects. So restrict the API to a dependency
between two driver-allocated objects of the same type, as iommufd would
unlikely build any core-level dependency in this case. And encourage to
use the macro version that currently supports the HW QUEUE objects only.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h        | 44 ++++++++++++++++++++++++++++++++++
 drivers/iommu/iommufd/driver.c | 28 ++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index b38c6631ad85..acf0e8f0c630 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -247,6 +247,10 @@ static inline int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx)
 #endif /* CONFIG_IOMMUFD */
 
 #if IS_ENABLED(CONFIG_IOMMUFD_DRIVER_CORE)
+int _iommufd_object_depend(struct iommufd_object *obj_dependent,
+			   struct iommufd_object *obj_depended);
+void _iommufd_object_undepend(struct iommufd_object *obj_dependent,
+			      struct iommufd_object *obj_depended);
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id);
 int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
@@ -255,6 +259,18 @@ int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 				enum iommu_veventq_type type, void *event_data,
 				size_t data_len);
 #else /* !CONFIG_IOMMUFD_DRIVER_CORE */
+static inline int _iommufd_object_depend(struct iommufd_object *obj_dependent,
+					 struct iommufd_object *obj_depended)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void
+_iommufd_object_undepend(struct iommufd_object *obj_dependent,
+			 struct iommufd_object *obj_depended)
+{
+}
+
 static inline struct device *
 iommufd_viommu_find_dev(struct iommufd_viommu *viommu, unsigned long vdev_id)
 {
@@ -294,4 +310,32 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 	 BUILD_BUG_ON_ZERO(!__same_type(struct iommufd_hw_queue,               \
 					((drv_struct *)NULL)->member)))
 
+/*
+ * Helpers for IOMMU driver to build/destroy a dependency between two sibling
+ * structures created by one of the allocators above
+ */
+#define iommufd_hw_queue_depend(dependent, depended, member)                   \
+	({                                                                     \
+		int ret = -EINVAL;                                             \
+									       \
+		static_assert(__same_type(struct iommufd_hw_queue,             \
+					  dependent->member));                 \
+		static_assert(__same_type(typeof(*dependent), *depended));     \
+		if (!WARN_ON_ONCE(dependent->member.viommu !=                  \
+				  depended->member.viommu))                    \
+			ret = _iommufd_object_depend(&dependent->member.obj,   \
+						     &depended->member.obj);   \
+		ret;                                                           \
+	})
+
+#define iommufd_hw_queue_undepend(dependent, depended, member)                 \
+	({                                                                     \
+		static_assert(__same_type(struct iommufd_hw_queue,             \
+					  dependent->member));                 \
+		static_assert(__same_type(typeof(*dependent), *depended));     \
+		WARN_ON_ONCE(dependent->member.viommu !=                       \
+			     depended->member.viommu);                         \
+		_iommufd_object_undepend(&dependent->member.obj,               \
+					 &depended->member.obj);               \
+	})
 #endif
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 2fee399a148e..70b7917da0cb 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -3,6 +3,34 @@
  */
 #include "iommufd_private.h"
 
+/* Driver should use a per-structure helper in include/linux/iommufd.h */
+int _iommufd_object_depend(struct iommufd_object *obj_dependent,
+			   struct iommufd_object *obj_depended)
+{
+	/* Reject self dependency that dead locks */
+	if (obj_dependent == obj_depended)
+		return -EINVAL;
+	/* Only support dependency between two objects of the same type */
+	if (obj_dependent->type != obj_depended->type)
+		return -EINVAL;
+
+	refcount_inc(&obj_depended->users);
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(_iommufd_object_depend, "IOMMUFD");
+
+/* Driver should use a per-structure helper in include/linux/iommufd.h */
+void _iommufd_object_undepend(struct iommufd_object *obj_dependent,
+			      struct iommufd_object *obj_depended)
+{
+	if (WARN_ON_ONCE(obj_dependent == obj_depended ||
+			 obj_dependent->type != obj_depended->type))
+		return;
+
+	refcount_dec(&obj_depended->users);
+}
+EXPORT_SYMBOL_NS_GPL(_iommufd_object_undepend, "IOMMUFD");
+
 /* Caller should xa_lock(&viommu->vdevs) to protect the return value */
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id)
-- 
2.43.0


