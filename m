Return-Path: <linux-kselftest+bounces-14753-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 738F594667A
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 02:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F440283206
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 00:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0124687;
	Sat,  3 Aug 2024 00:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bf1JyPaf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF43363C7;
	Sat,  3 Aug 2024 00:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722645149; cv=fail; b=rylQ8Oe/LxJAB715RhGpx4ZVpHvwJV9tg8RH0DbRCXTprB7rR3rdyDhKjkqmvI39GW/gTZji0rtk31HFBdanUk1dACVphwWExVBFhzcq/nIdKs/VeX3x5HLmGRdyXoMCGGoQdMutvrpdcyQ5HMT9GUcqrwC0uuzaUnHYDCC+0Xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722645149; c=relaxed/simple;
	bh=NxeLTY+idNAHCbsBCAzriak3VvVxd215Egs8fzM2tQ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fzsPxKj8X7p92+G0m5ceQUHJsn/EQmvnrCbDPn0ZEFjNdERU4+IMWnnc0z/U9CaRBTu+s4P406XeuhNzfiZQ5BAlOJzsCAPPlnQ+kNCZP9E4/BvU+YMtzFRiIxGIJFXqryjFZZeCEpsPhf16ltwHu96KpNkGD4iUTQQ4iE3q3so=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bf1JyPaf; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xUtt05+1VqYxNVVs+gs3ehtK+JRpX/U3odUwywL3WmJdksSuifZ87RRDEtXvzPcLsp+5YNwCnlikzUsmHHcbuCqxYxSoEwuR3aNowA0v6oHiGQ+9Vl59qSjk7R3NPbp3TcaXBMCCf82e99SOLnfKerdH9ftcrua/8QnQaSM3pUyeRZJ1mB2rxG3Q1opmDSkWbBG9thzjKC/wr3CkKdexCPsQq0Pj6K8yTpp275SHYYl4Vv1jpwuVEg0KDJkLguyyvySvTxhM0zZu7SSTjDZf2hylGl12m30jbxb2ES9Vaj8XDd9o6xDGGaYgnkxnlW/SR1J43x8eSSit4XDRZGd1Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPNloh2bQ77p615itoyosI8JbhB/G0bhaNWiEafCAMg=;
 b=TARspqPsLnN2MAxp/rp/MZenBZ1e309nF6uJp9UYlJKCwG0DAMdOJw9nq3Ywrn9HIB6FXuFs6AWFHc1+9NDuFjXXal6BRr6gvM30zqBCeBhslJFMamF+7VECHvPYXXo6S7xu+Au4PXPVsSutpWaVG/UfI2CFcKHqqWWMoXv0ZI2lQFceWttsBSBj0KVsfJevQebVk03vJnVU0Q/WYIRfUifSebLNl/Q1jQntG6hbsQYJA/bqd7AAdsBSwecc84P0U6XjrXMrAY1Gkb04ZafCjkzjMLhLPEEcmVI9VRsKBtATRV3f+wNOMmnq7AXv5LubWmyQWjIerPJQXcu5OUvGTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPNloh2bQ77p615itoyosI8JbhB/G0bhaNWiEafCAMg=;
 b=Bf1JyPafK15gewIqHnERTQdaOrFvWwVR0FId265Eot4yF50Tb8KDyqXYZLLsztymuKDzH6FZ9ekBrK0+RXl0m61YIMhQZTiAinikymXnGoVpK4X6Y2FltDdrAPWYhj7OYIUUa8VWpTfnlu21/jvsD782PsGiWfbfEw3tWOauu/7MUqvT8S+4Ry3H14pXwRP5461+CMOnL6J5tDoEydn5UVnF5EWY+i60ckZzuBTcJUhIrADla7Ao/xDSI4WdZBAJS07JIVXmJ7kSS8KWbZVc6MKHJk84c3xiZ3qbjRJTgCXEbjSbcPlhpq9n3EVticmhHpfOEtwtC69ASSLpRDQYUw==
Received: from BYAPR11CA0060.namprd11.prod.outlook.com (2603:10b6:a03:80::37)
 by MN2PR12MB4301.namprd12.prod.outlook.com (2603:10b6:208:1d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Sat, 3 Aug
 2024 00:32:23 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:80:cafe::f7) by BYAPR11CA0060.outlook.office365.com
 (2603:10b6:a03:80::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23 via Frontend
 Transport; Sat, 3 Aug 2024 00:32:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Sat, 3 Aug 2024 00:32:22 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 Aug 2024
 17:32:14 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 Aug 2024
 17:32:14 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 2 Aug 2024 17:32:13 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH v2 1/3] iommufd: Reorder include files
Date: Fri, 2 Aug 2024 17:32:02 -0700
Message-ID: <7524b037cc05afe19db3c18f863253e1d1554fa2.1722644866.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722644866.git.nicolinc@nvidia.com>
References: <cover.1722644866.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|MN2PR12MB4301:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f688b3a-9249-463d-b90a-08dcb353bdd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gjugpoyOH6JbKtu9gEgMD1lRJqlrQacstwil3iSj3SM7Fl6LoqstDJaxloj0?=
 =?us-ascii?Q?No3vQkwAIZzdB4WPxqIXK+j4TyYMEzRyUbX30+W4NB4avX9i5oXXUBVI0NQz?=
 =?us-ascii?Q?IRWc582R00UICQnVnXFfJF+qxqzs91aYBLZzihxoK2XelMxSgi7fbu5shW10?=
 =?us-ascii?Q?lbkidELTkGKUoKqJqGHcBvoD6lnlUT68I1S9s8iRRM9PMCkCsU7CV8J/Y9Rl?=
 =?us-ascii?Q?fkJ3rcC/u0pJTFzHYTKk18eBdXD0fu4JV/nwRnMkgQZPIJ2OgnGn4gZCpwlU?=
 =?us-ascii?Q?arVROGVBB2amkrpkjTaMevp+umZuNxsf6EhZjNWmSJxr3MS2HWDRTNO81JSm?=
 =?us-ascii?Q?yb9qvkCEQ+f9X0DkfX1uTr6TI8PjzMgAmmq5QZ4+eOvZ2wcW6uDUBoT7ncGr?=
 =?us-ascii?Q?6Jd+evKK3T1Xfw1r6t8coWIr7KpuJUk7aa3QM2R5f/daIf8WZnTRwL9HGr8J?=
 =?us-ascii?Q?ssfSNz8y9/pWMCPsarcOT6OFOeiE6cmV3MBjVUoXpiG+jLCvkeJhtlMnkJ1Q?=
 =?us-ascii?Q?dRJtxYHkLAaC9yAekKzhZFfdDpaRvCN5qIs5OogP7oyivsT8+bSYVInA3bmo?=
 =?us-ascii?Q?PquhayEhb8nZyy12cHM5K+64WfXNhy4R4M7xabr3CXzFA1kgKfII0AUBf/Fv?=
 =?us-ascii?Q?uDUQL7hVoxoqgHC/mXjZhveZt8kYSgsDssiFfp944hZ+Xz1j4sw3TaFAulX4?=
 =?us-ascii?Q?HMyrrhJ+0/q+eVh2DSOdw9QVmaVgAaWL2q05o5xklc+VLMTWITJmekQ92hLU?=
 =?us-ascii?Q?mc9KdR4H6hzPPcuB754f9ShSIu9h58rhiIO0XY0q6yetHqBM+ijuUrFKV4e5?=
 =?us-ascii?Q?FvvqMk3ddGqHcevmejQaUYlyOGlAgpyfhDwndgCNj0ItLuwdpudg5CsgxdZA?=
 =?us-ascii?Q?O5sKf0mVbJQN7tq+NlAPx57iaQTgMqSUTpNsJb0TSu0E2aUorYg8KVzC8rFv?=
 =?us-ascii?Q?paN+CKvhS+yQkaC4FS/PBVZOc2PM+/06Q3+6igAhRiT6ifcxL/D+oVsE59s9?=
 =?us-ascii?Q?kHR3Rn0X5WGwmPnrQDsuVGPbuNeg+wyv7t3D5MrY7LLW8TJY3ZKUsO51kKLZ?=
 =?us-ascii?Q?rKFlf5sTxpui74iivxmizFo56Pe/b9ZiLqQ/7XOJWcIrJ39giDXpcbQ/VeD2?=
 =?us-ascii?Q?XU3FcnaytfZUi2f1HiTtoP0YHZcHSuIN+5PZ2qht4nVN7Xt3hInJqk2KoxJb?=
 =?us-ascii?Q?1N0uW5vjxWlm9aCFdlDGuRxnKuO557Ynm9a0oHTqe2vUVUse/0or+OvHI3rC?=
 =?us-ascii?Q?7knSiYLQbuPsrPXSr11rRX5HhSCIjuHK0fQ3pHhbQ5X9ucyMWRbcORvIWJD6?=
 =?us-ascii?Q?2gZmmfBJbyZQ//4FIOrDGZ84yrBPjOfiasJoVG/zMEExJI/n7ZUdKvWe/adU?=
 =?us-ascii?Q?WKyfKkd2PR697ZwvfEm5GQwdzwU0QDVuhaZY80Edbn7Irmpywif/SWmWcww+?=
 =?us-ascii?Q?kjVAzrzxKHGVzjH1etd6HNtR3C/dCgb5?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2024 00:32:22.7141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f688b3a-9249-463d-b90a-08dcb353bdd6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4301

Reorder include files to alphabetic order to simplify maintenance, and
separate local headers and global headers with a blank line.

No functional change intended.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c          |  4 ++--
 drivers/iommu/iommufd/fault.c           |  4 ++--
 drivers/iommu/iommufd/io_pagetable.c    |  8 ++++----
 drivers/iommu/iommufd/io_pagetable.h    |  2 +-
 drivers/iommu/iommufd/ioas.c            |  2 +-
 drivers/iommu/iommufd/iommufd_private.h |  9 +++++----
 drivers/iommu/iommufd/iommufd_test.h    |  2 +-
 drivers/iommu/iommufd/iova_bitmap.c     |  2 +-
 drivers/iommu/iommufd/main.c            |  8 ++++----
 drivers/iommu/iommufd/pages.c           | 10 +++++-----
 drivers/iommu/iommufd/selftest.c        |  8 ++++----
 include/linux/iommufd.h                 |  4 ++--
 include/uapi/linux/iommufd.h            |  2 +-
 13 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 2ac26a948987e..eaa1fdf71bb0e 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1,12 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
  */
+#include <linux/iommu.h>
 #include <linux/iommufd.h>
 #include <linux/slab.h>
-#include <linux/iommu.h>
 #include <uapi/linux/iommufd.h>
-#include "../iommu-priv.h"
 
+#include "../iommu-priv.h"
 #include "io_pagetable.h"
 #include "iommufd_private.h"
 
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index a643d5c7c535f..df03411c87289 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -3,14 +3,14 @@
  */
 #define pr_fmt(fmt) "iommufd: " fmt
 
+#include <linux/anon_inodes.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/iommufd.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/iommufd.h>
 #include <linux/pci.h>
 #include <linux/poll.h>
-#include <linux/anon_inodes.h>
 #include <uapi/linux/iommufd.h>
 
 #include "../iommu-priv.h"
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 05fd9d3abf1b8..bbbc8a044bcf7 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -8,17 +8,17 @@
  * The datastructure uses the iopt_pages to optimize the storage of the PFNs
  * between the domains and xarray.
  */
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/iommu.h>
 #include <linux/iommufd.h>
 #include <linux/lockdep.h>
-#include <linux/iommu.h>
 #include <linux/sched/mm.h>
-#include <linux/err.h>
 #include <linux/slab.h>
-#include <linux/errno.h>
 #include <uapi/linux/iommufd.h>
 
-#include "io_pagetable.h"
 #include "double_span.h"
+#include "io_pagetable.h"
 
 struct iopt_pages_list {
 	struct iopt_pages *pages;
diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index 0ec3509b7e339..c61d74471684e 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -6,8 +6,8 @@
 #define __IO_PAGETABLE_H
 
 #include <linux/interval_tree.h>
-#include <linux/mutex.h>
 #include <linux/kref.h>
+#include <linux/mutex.h>
 #include <linux/xarray.h>
 
 #include "iommufd_private.h"
diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
index 7422482765481..82428e44a837c 100644
--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -3,8 +3,8 @@
  * Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
  */
 #include <linux/interval_tree.h>
-#include <linux/iommufd.h>
 #include <linux/iommu.h>
+#include <linux/iommufd.h>
 #include <uapi/linux/iommufd.h>
 
 #include "io_pagetable.h"
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 4a23c675ddfda..3f4ba3181fe91 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -4,13 +4,14 @@
 #ifndef __IOMMUFD_PRIVATE_H
 #define __IOMMUFD_PRIVATE_H
 
-#include <linux/rwsem.h>
-#include <linux/xarray.h>
-#include <linux/refcount.h>
-#include <linux/uaccess.h>
 #include <linux/iommu.h>
 #include <linux/iova_bitmap.h>
+#include <linux/refcount.h>
+#include <linux/rwsem.h>
+#include <linux/uaccess.h>
+#include <linux/xarray.h>
 #include <uapi/linux/iommufd.h>
+
 #include "../iommu-priv.h"
 
 struct iommu_domain;
diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index acbbba1c66716..f4bc23a92f9a2 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -4,8 +4,8 @@
 #ifndef _UAPI_IOMMUFD_TEST_H
 #define _UAPI_IOMMUFD_TEST_H
 
-#include <linux/types.h>
 #include <linux/iommufd.h>
+#include <linux/types.h>
 
 enum {
 	IOMMU_TEST_OP_ADD_RESERVED = 1,
diff --git a/drivers/iommu/iommufd/iova_bitmap.c b/drivers/iommu/iommufd/iova_bitmap.c
index b9e964b1ad5cc..d90b9e253412f 100644
--- a/drivers/iommu/iommufd/iova_bitmap.c
+++ b/drivers/iommu/iommufd/iova_bitmap.c
@@ -3,10 +3,10 @@
  * Copyright (c) 2022, Oracle and/or its affiliates.
  * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved
  */
+#include <linux/highmem.h>
 #include <linux/iova_bitmap.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
-#include <linux/highmem.h>
 
 #define BITS_PER_PAGE (PAGE_SIZE * BITS_PER_BYTE)
 
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 83bbd7c5d1608..b5f5d27ee9634 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -8,15 +8,15 @@
  */
 #define pr_fmt(fmt) "iommufd: " fmt
 
+#include <linux/bug.h>
 #include <linux/file.h>
 #include <linux/fs.h>
-#include <linux/module.h>
-#include <linux/slab.h>
+#include <linux/iommufd.h>
 #include <linux/miscdevice.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/bug.h>
+#include <linux/slab.h>
 #include <uapi/linux/iommufd.h>
-#include <linux/iommufd.h>
 
 #include "io_pagetable.h"
 #include "iommufd_private.h"
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 117f644a0c5b7..93d806c9c0731 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -45,16 +45,16 @@
  * last_iova + 1 can overflow. An iopt_pages index will always be much less than
  * ULONG_MAX so last_index + 1 cannot overflow.
  */
+#include <linux/highmem.h>
+#include <linux/iommu.h>
+#include <linux/iommufd.h>
+#include <linux/kthread.h>
 #include <linux/overflow.h>
 #include <linux/slab.h>
-#include <linux/iommu.h>
 #include <linux/sched/mm.h>
-#include <linux/highmem.h>
-#include <linux/kthread.h>
-#include <linux/iommufd.h>
 
-#include "io_pagetable.h"
 #include "double_span.h"
+#include "io_pagetable.h"
 
 #ifndef CONFIG_IOMMUFD_TEST
 #define TEMP_MEMORY_LIMIT 65536
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index f95e32e291333..b60687f57bef3 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -3,13 +3,13 @@
  *
  * Kernel side components to support tools/testing/selftests/iommu
  */
-#include <linux/slab.h>
-#include <linux/iommu.h>
-#include <linux/xarray.h>
-#include <linux/file.h>
 #include <linux/anon_inodes.h>
 #include <linux/fault-inject.h>
+#include <linux/file.h>
+#include <linux/iommu.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/xarray.h>
 #include <uapi/linux/iommufd.h>
 
 #include "../iommu-priv.h"
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index ffc3a949f8374..c2f2f6b9148e2 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -6,9 +6,9 @@
 #ifndef __LINUX_IOMMUFD_H
 #define __LINUX_IOMMUFD_H
 
-#include <linux/types.h>
-#include <linux/errno.h>
 #include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/types.h>
 
 struct device;
 struct iommufd_device;
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 4dde745cfb7e2..72010f71c5e47 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -4,8 +4,8 @@
 #ifndef _UAPI_IOMMUFD_H
 #define _UAPI_IOMMUFD_H
 
-#include <linux/types.h>
 #include <linux/ioctl.h>
+#include <linux/types.h>
 
 #define IOMMUFD_TYPE (';')
 
-- 
2.43.0


