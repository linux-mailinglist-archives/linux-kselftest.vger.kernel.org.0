Return-Path: <linux-kselftest+bounces-20338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255DC9A94A9
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 02:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 440A61C22BA3
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 00:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2E180025;
	Tue, 22 Oct 2024 00:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I8EpLWOn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB233FE55;
	Tue, 22 Oct 2024 00:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556426; cv=fail; b=gE7RCtruZNkEcqgY/d0eV0P+vQ1wiUR/uQXdOnLjhL7NstBTJB6q/9gJI6MkiX6ZmxtNspCHoy+pRcdinYO3ywLYuliCiX5kEtqFXAf8vf5dLbaxh1ySetkAZP5uhczckFp5qWavQHmexYGfKAdFhuY+MYv1luy3X/kK6nGJ/T4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556426; c=relaxed/simple;
	bh=TiLK5K+fdj2/tU/yCDcKo2OE2ok/BlAw9f0TfCGAUm8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O/KXcm08Ht+T90Ncgmba7IX+oOln/B2Tj0PW+UTmS1j7Pgdl0YMicNRlxCul8hq6ogulMzNkZtf4VDQ/65ZVxSVtMw8R2tDRWHv6leQFw0+eevo4z3n5iMy8dfDyuWTrP4v9SjE0AiJYcSnULwkKZKPDAdVf1+UYle40C8cfDKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I8EpLWOn; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mokEfbEAfqh1zlxCbh0Ln3rOmb6/QhDam6EcY10hxq+VPZcHy/mX4wWDrt6FAlF2yQ5hJN/hh44YvQiE2fgBcS1lkq4Pu5Mu1kKQbd/JL+AC6tNrGJdPpalbJqqQ6K1xBM1tg/P5ew/JKi6ncqY9RJLhMIy/EtRMf7GhCVKJdmTltv57Fgl6W9hI0J1bcJ6XaPtagsw6lDA25S7jl0aaosOhl989SuKfZfxrdkzSF0y89CyBlXyaSc0Tr14RZJuLS3AxmftndWPV+9uewYAwybIoFM5lR15m2l909MvecRXvQE6qMKn8MNPE9BU0RhmluXJTN4yvcH//LDW7BqEa6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIR0JAgwvXPvD4kxK81kzaELwIN2DXninNWOz0ykJ7Q=;
 b=rsmw+YH21Hq4sBBNQoFDAPdIGkkj4iwiJfxET745CtjxbbSaqE9a5QIH7vwjB7Os/XeqUYbXCS7Ecl2QsdBU1hN/iQhbPbSscYNQ+S14lqFsJXAPA96DK0AChc2sK8rZpw2zXW+OhRc4rDZxaXFX97HxjwHST8Zk7l+aovmdiq+AXvHyfxOVzX0kR85voW7QqqH///cwPPuMlk/Wr0HW1Kjir04eBmtoqlFK7oOjZv+MKJx1lV1V3mCwVEj8V1PwQLEw9D7Wqh4I6z7WdyNNeyQUqqp7k03+otnvLYktMuKngRraMGYnb5Gb27/lTnRaD2ldo4nggmfvj6oNW9LysQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIR0JAgwvXPvD4kxK81kzaELwIN2DXninNWOz0ykJ7Q=;
 b=I8EpLWOn+WqgUgxI8dEJUiOyEJPokLYz3e4WwqKfqETAIqPTPoeF7suGm9qSL/1fz4OdmZmLE4QOLNblGpLtQYweuvdyakN1XFeTrv033cwagF4v2iRWzjpxvKDUJlst2vkPBDRQbv4pIHQBS5STfYP6jYQ+IUalJXK8zAfRwv9s39IYM5Ej8K01pNe+9D6Ja2CVUI6wtuL3JrXUzjlxsjXFGu2QPYaugHl2goDD15nZZPm0WoYkpnWFuBYHTj3p7pqdvT6gBF1AqoTpxWLhcig8xNSUbWKPaz8vi5mqndsPvYOd+sflWT0dEp2dBHZUu2SZ4R+DKhqN7bkZj7r6zw==
Received: from BL1PR13CA0370.namprd13.prod.outlook.com (2603:10b6:208:2c0::15)
 by MN2PR12MB4064.namprd12.prod.outlook.com (2603:10b6:208:1d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 22 Oct
 2024 00:20:17 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:2c0:cafe::72) by BL1PR13CA0370.outlook.office365.com
 (2603:10b6:208:2c0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15 via Frontend
 Transport; Tue, 22 Oct 2024 00:20:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 00:20:17 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:03 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:02 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 17:20:01 -0700
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
Subject: [PATCH v4 02/11] iommufd: Introduce IOMMUFD_OBJ_VIOMMU and its related struct
Date: Mon, 21 Oct 2024 17:19:24 -0700
Message-ID: <74fec8c38a7d568bd88beba9082b4a5a4bc2046f.1729553811.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|MN2PR12MB4064:EE_
X-MS-Office365-Filtering-Correlation-Id: d3648a2d-7efe-4fd4-8643-08dcf22f4e6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f2NuYkkBsRMrBdG4CiF1+X08YybDhS2H1S8lYJ17LfRAtZ3XN1ahDsRVuCvp?=
 =?us-ascii?Q?JRQbEC0B3v77eRS5pXTqf68BRx9OWPLdDTFMAJVuHQ26L8uL86p9S1tglvPj?=
 =?us-ascii?Q?eROWfsdOBf+08gU5DwCs5YLFIAgQNXnY2wlR8sq+YJMzxs+AjcYDsN63MVXV?=
 =?us-ascii?Q?fMZa7YQ8/Ep3sDwqnKFJwDR46ioQNoGF6feD8wFuSl8fYWDrKvA73JEkETr7?=
 =?us-ascii?Q?0um/gHG4t70gmyS4W2jlPEOYPSxJpSsfSLqVjIpv7K0hWQeUi6EbAihQL2kx?=
 =?us-ascii?Q?Q5PPB6jCg5DPYLSaaYDup8p47rtdp+MVAa8E1V8IiGzd4OygtJ2HdPbpTqpz?=
 =?us-ascii?Q?Va4lQfQhaBp0jdVDQJkZRqksI82mKDiGRzM8brpGVMJUxT29+CL2Tid/brsr?=
 =?us-ascii?Q?94QCJmgf5MBhpxZa6DwyNbR03XS5U26TxRgKkteIs72Ydi+oaJmMwzI8VBjM?=
 =?us-ascii?Q?gWOZ0fsSkS487Ivtdik63UOG6c20P2bEYUPssbpncDCreZYHP8QPpXHko7jf?=
 =?us-ascii?Q?lUpOv2JxhVU0+CyD6yNsNlSMIMCRgbilRJvdX+sX00m5SiwKAUak3pws+rf1?=
 =?us-ascii?Q?u+N2Fp806VMGHMWe73c9euJY6RKGTdlcExtW76k+XOHIbdR8nP+B5ls27OH8?=
 =?us-ascii?Q?3x8fO3unmy4yiPBa4eh0MkPhP1TAOu8zhTXbPyHLHDhCzDGJF/7y90NY+QYK?=
 =?us-ascii?Q?8hkK+vEOAyOO8OYnoocUyYs+GPUWdD6N8fhLxc8sp+pE4U3rFwvZ2GsXuhIb?=
 =?us-ascii?Q?9RurJPuOtSYIjgSCCyfNv0D1QyBb3FoiqJMLWM1LIphYoQUW2+llbh3Q/a14?=
 =?us-ascii?Q?HaFHsvQ3blOtQDkGndJT8d/Sl2FHJK8XlQ5WEPb4sXmRYVTYr7hh28+JAb75?=
 =?us-ascii?Q?ikT204AQuNyMBDm5K/4wBUCTNbigGlu5E4OlkF7Ou+ZHRo+ncMIZ7vDAwPLV?=
 =?us-ascii?Q?HhXnXK1YRLFOA9FD0fsW5flzwtxDRHD6pULoMNPjUp3ihGCvpCPUKXmHW3aC?=
 =?us-ascii?Q?FhGGY3VHoMTE3tJUPHi9YQq+4vMfhdNtNHScGc4mM5egDpi4q65PEVvwUCWz?=
 =?us-ascii?Q?YjpfHTE3UMwjeP+F2YnAHrBDyv3sUZ6GYwB0d5ddrmM/bnob4mqJTi77yFYE?=
 =?us-ascii?Q?4Em45Bzh8m0kwkFeIm9R+vCy5DdygIJzJl0v9/Pht7IRzgntWn/TCD0S5/Dr?=
 =?us-ascii?Q?lj2Bc9hcjvVe4YHOIejNlqMx1PPwPNzddtCW050991IyNUrflfIOtBE4oM+c?=
 =?us-ascii?Q?2ZjCffoX/3c/stmYhLLHYXarcZTlE8oi42Dbj9r7Ky8WdJ5W1Us1AI0JC2Eq?=
 =?us-ascii?Q?//6H/dPe5Eyn/vhtHFbsEiu2Mg7sZhB6vtVY3qvM4GdPNs9NpyR8AwxjmgsD?=
 =?us-ascii?Q?gKP3uTmQb1gW7O8isIXHc/3SafdzDA3xUc8xAZ8TnbiIsKCOOQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 00:20:17.1612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3648a2d-7efe-4fd4-8643-08dcf22f4e6e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4064

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
 include/linux/iommufd.h                 | 56 +++++++++++++++++++++++++
 drivers/iommu/iommufd/driver.c          | 38 +++++++++++++++++
 drivers/iommu/iommufd/main.c            | 32 --------------
 6 files changed, 109 insertions(+), 37 deletions(-)
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
index 22948dd03d67..55054fbc793c 100644
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
@@ -135,4 +157,38 @@ static inline int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx)
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
+		struct drv_struct *ret;                                        \
+									       \
+		static_assert(                                                 \
+			__same_type(struct iommufd_viommu,                     \
+				    ((struct drv_struct *)NULL)->member));     \
+		static_assert(offsetof(struct drv_struct, member.obj) == 0);   \
+		ret = container_of(                                            \
+			_iommufd_object_alloc(ictx, sizeof(struct drv_struct), \
+					      IOMMUFD_OBJ_VIOMMU),             \
+			struct drv_struct, member.obj);                        \
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


