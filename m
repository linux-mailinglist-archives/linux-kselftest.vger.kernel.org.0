Return-Path: <linux-kselftest+bounces-20722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF62D9B136A
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 01:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F35631C21AA4
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 23:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE28E215C56;
	Fri, 25 Oct 2024 23:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D/y0mond"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E519F214427;
	Fri, 25 Oct 2024 23:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729900222; cv=fail; b=i9pYwO2nzbLb5RBeRY5sKHOZftDiorvi5YafXMnUpS3kl0LD2eIWk4UurY0fBBg2ifacQIA7Ar6TvQg12fC1UxwW9qhTHNJUyfdr8jMuirH6KoHGJElpufZPkkdSbbpz1sKvakB3+0fsuLd6se3F5z5vJYqXhAgzDDaZZpTYL+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729900222; c=relaxed/simple;
	bh=1VF+u3Kh5ReSeV8Kri0F+7weSUCU6QD2Ad8gJn1DYbI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bStWgNDa6b5rakCHhlzzOnNc/N30i+LBkt7JoIcQxcj2i3nc92ikD0ml2AgxbiomZ0pviBluEumLFp3WlmQf9xeILW4dOWW8/bPfBNzJOCwWe0yMlmOxg3iGmdxu7g08VhrM8KBvac4S47ci7dfn0UZYtELqefdUKZ0u5piXeFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D/y0mond; arc=fail smtp.client-ip=40.107.236.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=taxMtRD4Fw/JAv0R09ZiYUEOxkF1uUC6OOWZEkOE0voy5U5i/JTfvuTKLXjeqX/VBlvNLOGHOCkqa7C4M6TAY4kYqhFzGngBnsk0UQm+KZM2Rk7K4z9It0DThxNtmS+6S+1JwF6ZJcDVPUGlAabfJ/FtH5xOIOal6A+/1N/U37FXp3zWiAtjnvAr+Fwj1TPlPNeoxFC36p3SXv5ayzbzF7x+rmqGknDSw6/BNKVu2YFkECil0FL8/ryYNODw4bCC3Y58uN2NqRi+Kk/5mADxkuI0mdSgEDYxTUVsNBPM6rxSqIBgNUqrU31nLTZbZOLxkPwNgOXkxSKgJGQsthCw/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsFJTqdCqEGng1DoCDG/32Ye63kq59YqYkP89ybWGO4=;
 b=vNMGCvZSiMrUOKl95WEGfgYsEO5aEFMuRnPjs3+1OigMhdZ+oRDMkExQT4zTgnftJ6AH169PIezNWDxY6XXb4h6y7D2cW6eilHsooDWuqgJ0bHDWK+MJ/SuqJuYtFQPu8UrB/3b3LzSBvx0vun+t8f1N8Ylikx0CA03hGi7eDfnH+J4p0WX/YsOrvmmyaLSRiWD605h3p42dELCJVsV/mA8DtyPDgbqIFgCclZcJM3njD/Xf6ORs7Gn2EZL9InsBHSBYbeETHsf4Nw7l/xjFqB9sLtNq+hO6lGsRwD+UgCtZqS/G82BTE0Jm4LviAfid4lFKB5IcGPR4NrwEFUISSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsFJTqdCqEGng1DoCDG/32Ye63kq59YqYkP89ybWGO4=;
 b=D/y0mondmD1V6L4zJg9//UayNstUt5cPtB5x28eZIKCKuuX8q0An8NufDrn7C4wHTmrG3EnDShm49ajs4/tLmLEutJJHr/xOt+z1ddD85JpXI/YrtHjKnknp0kqeHtqOrFGsDuoD+HgRU1xiwKXNmzwtHgRHBNn91AHtD6fdNpZBV9nlRB2o+OcLrWxEmNj1IbrFgo/+JswhnH88nvfCW7zALT61CeukxyyIJZS/B1LdLTOFgKqqp2DEwvut9X0VjdZ2uErkmzG7121HgKImnkXx5E+sx9AAyP06fppSUX1z7oC1p/quPhtzjUhl1UsrfUHpmzJwE4IzRky1Rob9qA==
Received: from BY5PR03CA0015.namprd03.prod.outlook.com (2603:10b6:a03:1e0::25)
 by PH8PR12MB6746.namprd12.prod.outlook.com (2603:10b6:510:1c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 23:50:15 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::63) by BY5PR03CA0015.outlook.office365.com
 (2603:10b6:a03:1e0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 23:50:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 23:50:15 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 16:50:05 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 25 Oct 2024 16:50:05 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 25 Oct 2024 16:50:04 -0700
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
Subject: [PATCH v5 02/13] iommufd: Introduce IOMMUFD_OBJ_VIOMMU and its related struct
Date: Fri, 25 Oct 2024 16:49:42 -0700
Message-ID: <e172d2370223a5a012a70aea76175b71a95964f0.1729897352.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729897352.git.nicolinc@nvidia.com>
References: <cover.1729897352.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|PH8PR12MB6746:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca2d7d8-59de-43af-2933-08dcf54fc641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3iXfU8631Ifkzdd97uQnWOtYp+ojlaMB2Js504xzMlfBAz3rgF9VNU/xfdDw?=
 =?us-ascii?Q?4Gc7n8jscy/CWV4rcRhsAbFmq1iaLbcjj8Efa9IkUTmG3TYPe1oHpyO3q7Cg?=
 =?us-ascii?Q?n2hinvMvGr+1W1Ul/cTplB+XSqvCGUtylowMXCaaOlRWXpDqnxivRZ+7igmS?=
 =?us-ascii?Q?BQGMOh/7yRacYemIwoz9/mW4rIhS88M21unoGtVpiVEH5KkrelNjOo96MFZG?=
 =?us-ascii?Q?AoURF0LJdbkK4u3QtLg/UCYUm5J7jApbeXQVjBkTuJIk563tz5QnnBX7J0P5?=
 =?us-ascii?Q?mYbJQXreUcFgDQks/msKs4XRT3ty/ATMgslpJOJk/y+aqG3MBrlMCBwH5TaA?=
 =?us-ascii?Q?EFUE+uF+OiND/H8CJVI1XiaSD8fwKqBywakwB2ez62pmHxedQsgYeCClXpfO?=
 =?us-ascii?Q?Vvjwt51lMi09vNe5GHV8lR6wpeA6lfKSL66PHJdu+SlEwKAaRzE9TRgSeW4F?=
 =?us-ascii?Q?+AIafqjWGNx7HlkO5uK3OIcoUJDwMR7NNIZGyamZnxGSv3iOX8n7k1TLdrIo?=
 =?us-ascii?Q?EKCo/w3bSefZxjX7nkey/ZO0vD+B7irXAZO3Sx0RdGyKDuikciQIdCESaSXa?=
 =?us-ascii?Q?FLIyCt7sXESQ2JxG+tLwkIDjAqnAex/+j6M//HIfJAykszFZlzfckkd+i5f0?=
 =?us-ascii?Q?w57t4bS0Bt8UTKWctmgO74SNcnr2cL5AeakX/dMDCqE5knNXC7MlGp2xOo79?=
 =?us-ascii?Q?XKDHYxGFycMjnRZuU5PulIbYvHlNEAdS+Rz624flS7cpT5jlhttGdwZ/4E7T?=
 =?us-ascii?Q?tCC6hBcp4zy1TXIQF/SxAPZAcKzJh0OqND7Hh5MSTiPG+KXl2mcYU0I33fc1?=
 =?us-ascii?Q?SYSS5wjM+0xwGAqmYQ0zOGpKtZfKwb67okr3pDMaCHgCf5mzH8n4qzGYq0ov?=
 =?us-ascii?Q?aXOk0+UQZCPlqqDhNf4TJw5e2MO+7wG5tidnA0mKcZ5K4Fxiz5TchiHYYKbc?=
 =?us-ascii?Q?C4mhGn7yepePlSgG8yBceonbIjn41bjLbGRou9zDJvceKIsEji4635UoFqmv?=
 =?us-ascii?Q?fCcW7B3BJiV4SdOSByFNQaj9nTmjfHY6ux1TmBjN6N9siA0wTylxyJwLBkpn?=
 =?us-ascii?Q?ZCjFzg/nAiN8h5J310TfyGtokApy06x2DD+zUy9YDedSw+aEQYYW/vXJdvkS?=
 =?us-ascii?Q?AhAbjjONws2EZ0QOiuI07+bnL2fh/tf775NyPR4sJr/qvTSZLVkw+zDoQZWP?=
 =?us-ascii?Q?SRuEv+mtnchcqY4/DGXMc27tvYpSjWU7IPv66l9Fzfeayup52QehbHtCkD4U?=
 =?us-ascii?Q?x1gJFZg+avzjKUv2FE3KnT+4wvz8iWKFQumK0sWmUCgWvX2v3dyO45Ucev8X?=
 =?us-ascii?Q?IBE3ljSiMQb9W9FkIZnOj/U0mpAa9K2TLuDT42jfHR6s6JhPXGQgZwFOgIUU?=
 =?us-ascii?Q?1zAzdRS/EHV7Uv9IFEkHuzhr/wkqq+7ywBOpxyrFJ9+QreD1LQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 23:50:15.6367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca2d7d8-59de-43af-2933-08dcf54fc641
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6746

Add a new IOMMUFD_OBJ_VIOMMU with an iommufd_viommu structure to represent
a slice of physical IOMMU device passed to or shared with a user space VM.
This slice, now a vIOMMU object, is a group of virtualization resources of
a physical IOMMU's, such as:
 - Security namespace for guest owned ID, e.g. guest-controlled cache tags
 - Access to a sharable nesting parent pagetable across physical IOMMUs
 - Virtualization of various platforms IDs, e.g. RIDs and others
 - Delivery of paravirtualized invalidation
 - Direct assigned invalidation queues
 - Direct assigned interrupts
 - Non-affiliated event reporting

Add a new viommu_alloc op in iommu_ops, for drivers to allocate their own
vIOMMU structures. And this allocation also needs a free(), so add struct
iommufd_viommu_ops.

To simplify a vIOMMU allocation, provide a iommufd_viommu_alloc() helper.
It's suggested that a driver should embed a core-level viommu structure in
its driver-level viommu struct and call the iommufd_viommu_alloc() helper,
meanwhile the driver can also implement a viommu ops:
    struct my_driver_viommu {
        struct iommufd_viommu core;
        /* driver-owned properties/features */
        ....
    };

    static const struct iommufd_viommu_ops my_driver_viommu_ops = {
        .free = my_driver_viommu_free,
        /* future ops for virtualization features */
        ....
    };

    static struct iommufd_viommu my_driver_viommu_alloc(...)
    {
        struct my_driver_viommu *my_viommu =
                iommufd_viommu_alloc(ictx, my_driver_viommu, core,
                                     my_driver_viommu_ops);
        /* Init my_viommu and related HW feature */
        ....
        return &my_viommu->core;
    }

    static struct iommu_domain_ops my_driver_domain_ops = {
        ....
        .viommu_alloc = my_driver_viommu_alloc,
    };

To make the Kernel config work between a driver and the iommufd core, move
the _iommufd_object_alloc helper into a new driver.c file that builds with
CONFIG_IOMMUFD_DRIVER.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/Makefile          |  2 +-
 drivers/iommu/iommufd/iommufd_private.h |  4 --
 include/linux/iommu.h                   | 14 +++++++
 include/linux/iommufd.h                 | 53 +++++++++++++++++++++++++
 drivers/iommu/iommufd/driver.c          | 38 ++++++++++++++++++
 drivers/iommu/iommufd/main.c            | 32 ---------------
 6 files changed, 106 insertions(+), 37 deletions(-)
 create mode 100644 drivers/iommu/iommufd/driver.c

diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index cf4605962bea..435124a8e1f1 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -12,4 +12,4 @@ iommufd-y := \
 iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
 
 obj-$(CONFIG_IOMMUFD) += iommufd.o
-obj-$(CONFIG_IOMMUFD_DRIVER) += iova_bitmap.o
+obj-$(CONFIG_IOMMUFD_DRIVER) += iova_bitmap.o driver.o
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 1bb8c0aaecd1..5bd41257f2ef 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -202,10 +202,6 @@ iommufd_object_put_and_try_destroy(struct iommufd_ctx *ictx,
 	iommufd_object_remove(ictx, obj, obj->id, 0);
 }
 
-struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
-					     size_t size,
-					     enum iommufd_object_type type);
-
 #define __iommufd_object_alloc(ictx, ptr, type, obj)                           \
 	container_of(_iommufd_object_alloc(                                    \
 			     ictx,                                             \
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 4ad9b9ec6c9b..14f24b5cd16f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -42,6 +42,8 @@ struct notifier_block;
 struct iommu_sva;
 struct iommu_dma_cookie;
 struct iommu_fault_param;
+struct iommufd_ctx;
+struct iommufd_viommu;
 
 #define IOMMU_FAULT_PERM_READ	(1 << 0) /* read */
 #define IOMMU_FAULT_PERM_WRITE	(1 << 1) /* write */
@@ -542,6 +544,14 @@ static inline int __iommu_copy_struct_from_user_array(
  * @remove_dev_pasid: Remove any translation configurations of a specific
  *                    pasid, so that any DMA transactions with this pasid
  *                    will be blocked by the hardware.
+ * @viommu_alloc: Allocate an iommufd_viommu on a physical IOMMU instance behind
+ *                the @dev, as the set of virtualization resources shared/passed
+ *                to user space IOMMU instance. And associate it with a nesting
+ *                @parent_domain. The @viommu_type must be defined in the header
+ *                include/uapi/linux/iommufd.h
+ *                It is suggested to call iommufd_viommu_alloc() helper for
+ *                a bundled allocation of the core and the driver structures,
+ *                using the given @ictx pointer.
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  * @owner: Driver module providing these ops
  * @identity_domain: An always available, always attachable identity
@@ -591,6 +601,10 @@ struct iommu_ops {
 	void (*remove_dev_pasid)(struct device *dev, ioasid_t pasid,
 				 struct iommu_domain *domain);
 
+	struct iommufd_viommu *(*viommu_alloc)(
+		struct device *dev, struct iommu_domain *parent_domain,
+		struct iommufd_ctx *ictx, unsigned int viommu_type);
+
 	const struct iommu_domain_ops *default_domain_ops;
 	unsigned long pgsize_bitmap;
 	struct module *owner;
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 22948dd03d67..4435f21bd833 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -17,6 +17,7 @@ struct iommu_group;
 struct iommufd_access;
 struct iommufd_ctx;
 struct iommufd_device;
+struct iommufd_viommu_ops;
 struct page;
 
 enum iommufd_object_type {
@@ -28,6 +29,7 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_IOAS,
 	IOMMUFD_OBJ_ACCESS,
 	IOMMUFD_OBJ_FAULT,
+	IOMMUFD_OBJ_VIOMMU,
 #ifdef CONFIG_IOMMUFD_TEST
 	IOMMUFD_OBJ_SELFTEST,
 #endif
@@ -78,6 +80,26 @@ void iommufd_access_detach(struct iommufd_access *access);
 
 void iommufd_ctx_get(struct iommufd_ctx *ictx);
 
+struct iommufd_viommu {
+	struct iommufd_object obj;
+	struct iommufd_ctx *ictx;
+	struct iommu_device *iommu_dev;
+	struct iommufd_hwpt_paging *hwpt;
+
+	const struct iommufd_viommu_ops *ops;
+
+	unsigned int type;
+};
+
+/**
+ * struct iommufd_viommu_ops - vIOMMU specific operations
+ * @free: Free all driver-specific parts of an iommufd_viommu. The memory of the
+ *        vIOMMU will be free-ed by iommufd core after calling this free op.
+ */
+struct iommufd_viommu_ops {
+	void (*free)(struct iommufd_viommu *viommu);
+};
+
 #if IS_ENABLED(CONFIG_IOMMUFD)
 struct iommufd_ctx *iommufd_ctx_from_file(struct file *file);
 struct iommufd_ctx *iommufd_ctx_from_fd(int fd);
@@ -135,4 +157,35 @@ static inline int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx)
 	return -EOPNOTSUPP;
 }
 #endif /* CONFIG_IOMMUFD */
+
+#if IS_ENABLED(CONFIG_IOMMUFD_DRIVER)
+struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
+					     size_t size,
+					     enum iommufd_object_type type);
+#else /* !CONFIG_IOMMUFD_DRIVER */
+static inline struct iommufd_object *
+_iommufd_object_alloc(struct iommufd_ctx *ictx, size_t size,
+		      enum iommufd_object_type type)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+#endif /* CONFIG_IOMMUFD_DRIVER */
+
+/*
+ * Helpers for IOMMU driver to allocate driver structures that will be freed by
+ * the iommufd core. The free op will be called prior to freeing the memory.
+ */
+#define iommufd_viommu_alloc(ictx, drv_struct, member, viommu_ops)             \
+	({                                                                     \
+		drv_struct *ret;                                               \
+									       \
+		static_assert(__same_type(struct iommufd_viommu,               \
+					  ((drv_struct *)NULL)->member));      \
+		static_assert(offsetof(drv_struct, member.obj) == 0);          \
+		ret = (drv_struct *)_iommufd_object_alloc(                     \
+			ictx, sizeof(drv_struct), IOMMUFD_OBJ_VIOMMU);         \
+		if (!IS_ERR(ret))                                              \
+			ret->member.ops = viommu_ops;                          \
+		ret;                                                           \
+	})
 #endif
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
new file mode 100644
index 000000000000..c0876d3f91c7
--- /dev/null
+++ b/drivers/iommu/iommufd/driver.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
+ */
+
+#include "iommufd_private.h"
+
+struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
+					     size_t size,
+					     enum iommufd_object_type type)
+{
+	struct iommufd_object *obj;
+	int rc;
+
+	obj = kzalloc(size, GFP_KERNEL_ACCOUNT);
+	if (!obj)
+		return ERR_PTR(-ENOMEM);
+	obj->type = type;
+	/* Starts out bias'd by 1 until it is removed from the xarray */
+	refcount_set(&obj->shortterm_users, 1);
+	refcount_set(&obj->users, 1);
+
+	/*
+	 * Reserve an ID in the xarray but do not publish the pointer yet since
+	 * the caller hasn't initialized it yet. Once the pointer is published
+	 * in the xarray and visible to other threads we can't reliably destroy
+	 * it anymore, so the caller must complete all errorable operations
+	 * before calling iommufd_object_finalize().
+	 */
+	rc = xa_alloc(&ictx->objects, &obj->id, XA_ZERO_ENTRY, xa_limit_31b,
+		      GFP_KERNEL_ACCOUNT);
+	if (rc)
+		goto out_free;
+	return obj;
+out_free:
+	kfree(obj);
+	return ERR_PTR(rc);
+}
+EXPORT_SYMBOL_NS_GPL(_iommufd_object_alloc, IOMMUFD);
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index b5f5d27ee963..92bd075108e5 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -29,38 +29,6 @@ struct iommufd_object_ops {
 static const struct iommufd_object_ops iommufd_object_ops[];
 static struct miscdevice vfio_misc_dev;
 
-struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
-					     size_t size,
-					     enum iommufd_object_type type)
-{
-	struct iommufd_object *obj;
-	int rc;
-
-	obj = kzalloc(size, GFP_KERNEL_ACCOUNT);
-	if (!obj)
-		return ERR_PTR(-ENOMEM);
-	obj->type = type;
-	/* Starts out bias'd by 1 until it is removed from the xarray */
-	refcount_set(&obj->shortterm_users, 1);
-	refcount_set(&obj->users, 1);
-
-	/*
-	 * Reserve an ID in the xarray but do not publish the pointer yet since
-	 * the caller hasn't initialized it yet. Once the pointer is published
-	 * in the xarray and visible to other threads we can't reliably destroy
-	 * it anymore, so the caller must complete all errorable operations
-	 * before calling iommufd_object_finalize().
-	 */
-	rc = xa_alloc(&ictx->objects, &obj->id, XA_ZERO_ENTRY,
-		      xa_limit_31b, GFP_KERNEL_ACCOUNT);
-	if (rc)
-		goto out_free;
-	return obj;
-out_free:
-	kfree(obj);
-	return ERR_PTR(rc);
-}
-
 /*
  * Allow concurrent access to the object.
  *
-- 
2.43.0


