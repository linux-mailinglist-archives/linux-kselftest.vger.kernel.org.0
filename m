Return-Path: <linux-kselftest+bounces-14742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EAB9464FD
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 23:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A281F212CB
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 21:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19AA8248D;
	Fri,  2 Aug 2024 21:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gy5ssTyW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B356474040;
	Fri,  2 Aug 2024 21:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722633860; cv=fail; b=KnZPzOiPAv4iQItBR96Z0J5i8pPvrypMOboJv0DV4ZdAHfVNkuYxhx7kX+SvVDFv7ZnLZm0zLaM883KhW9XUHqFbi2RSD0CQ9vIaOKCgYIaOcPCQl3LV3NXjrUk/rVrG/xknZtH3jArRoFGiYVzUs8XmwnQ1eRK4XX+pKKlV+Vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722633860; c=relaxed/simple;
	bh=NxeLTY+idNAHCbsBCAzriak3VvVxd215Egs8fzM2tQ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dEifjPxP/Uw2Vp4m8NcHQgjg4dDHH65pj2bM0SA/2vqJrkVzeqjaY16uokIaVsuIQ0ysmJLsknkzB9nd5FCesgnAR89lSH35Dum9oOFrmI3Tj8JQeFcS+2uzQ17GS7ePQMrZeDbjW+m9idgT20PaDg7e1aQ/5KVgAf9gbZVMCYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gy5ssTyW; arc=fail smtp.client-ip=40.107.236.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eb0nXkd57kwr8v+pRHTnLuDV3EDnfSZNLLn5F+gULv+rslS/iPfBRPZ6qo6aPH6uDNnO4kU5BohmpMQIkrKa0ft6KbMJ8LE2XK0ok5Xi9GzmuygJQ6TCSYcRdlzz+3OO0pQYzsNDpecmsEX0ls4LrEipcE6HM1VMmk7x89sa5o+RmJBzJHCLsWFq8aaHD6uVSUJc5VDn4/9XAjW7+GGZo4MBARHHv7jdlVF7zruW0g2DLSg4EgSvkH01ETlW8Pz/u8KoRfMnnc40yW4t1oXnGMLdWlWCkd+i2KWyLTuLykTAzVsgmz8HrLMXsEwPFQWvnWZV6y7KDmGE4tp4GiAp7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPNloh2bQ77p615itoyosI8JbhB/G0bhaNWiEafCAMg=;
 b=J/2PPYK1PTXsLSd7sumVDkKt4PT3DxbW7RKeLeQLQoXVmBT91hqfQfqUj88O9wus7DXCdstVnvS29YEk4nf53MmFCtwimr+3RpO/K3SbcVVgf8X71qxT063UAvTYYPxPNofOHzMa9i85j970Vz887FwP2wza2gOur877n6YJfDQwSnzghZLHWbKbxadwPRMYroCtIZVb0I/VigozcmkbINsZXp5UnHtYyV1XGLZquGDy42FOVw2cYaDmbTJJcelOMs2Jy9X5gQrmG9UTmtrxbwZuCvAeM1lqldCRV7u9WSdqJiurep+l7jA9SgfbuvX7UCp9TgjLZjkkFq45zbCUwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPNloh2bQ77p615itoyosI8JbhB/G0bhaNWiEafCAMg=;
 b=Gy5ssTyW7DlTdApL1H4VJXG/xG6Jm2ufg3O2b2USEj1dazSD09KfUojtLPyCg6Kg1LMilq64z0boi5AfKx0Q35LlesNVbOVhDo0cx/G7Rba4fGYcYYFNGCPsUs7DzkXPkRDxFfJ0bhzcM2umwg+p/BGV86nU5EHMCRSd2sRV2SJjpak+K5i5QOfvxQrwDqWu6E8PSvPBJeC4N2mLU+bZEjnXL/N4cccKi7zlvX6Gkm8o6hAD6Okkx66iVebeuEVgVvu+3FRaMUpJMHekzq4ipWQ6tv0pmgplqFHSzhqQvWyHEdc4P5+4bjEOZ+0IIbJTHqlP3wDinPp3iNc+0wNDSw==
Received: from MW4PR04CA0057.namprd04.prod.outlook.com (2603:10b6:303:6a::32)
 by IA1PR12MB7758.namprd12.prod.outlook.com (2603:10b6:208:421::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 21:24:13 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:6a:cafe::a2) by MW4PR04CA0057.outlook.office365.com
 (2603:10b6:303:6a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21 via Frontend
 Transport; Fri, 2 Aug 2024 21:24:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Fri, 2 Aug 2024 21:24:12 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 Aug 2024
 14:24:02 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 Aug 2024
 14:24:02 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 2 Aug 2024 14:24:01 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH 1/3] iommufd: Reorder include files
Date: Fri, 2 Aug 2024 14:23:46 -0700
Message-ID: <7524b037cc05afe19db3c18f863253e1d1554fa2.1722633199.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722633199.git.nicolinc@nvidia.com>
References: <cover.1722633199.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|IA1PR12MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e9a498e-6751-4b7e-3a22-08dcb339742c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9N7IBdz9jvS4kp2CAaV/942CQL3ywXbZJkn9J6+hSLFf1plwHKJ+RFT48pdI?=
 =?us-ascii?Q?tGSLAfcD87q7Du5vfnnFceHNLEKC/jc8i2NPMnsZ65/yNkira/xQPc17PAN4?=
 =?us-ascii?Q?LwVxboAMrszp5U6Me3j4N8J0NWzrHNZ93sjHMCCphkVCboN10uvQ1OQO4deB?=
 =?us-ascii?Q?54y4lCxizxvJhKqt174fnbYTlw8oB1Hpu3yaj2EDZe6o4mWhQLibIdsLbIiy?=
 =?us-ascii?Q?McTTcLLswY/s29uwgCs9EQIXqtYpxcVFOmu7ChR0GDZfGLlHmAG5jI4zenKT?=
 =?us-ascii?Q?3hCGEVxLjJnXUixh0EgLmoVx7dXDjXYfYyxlwHls3IigTL8mxbhnyOWKotaL?=
 =?us-ascii?Q?HkZzF9sr211oD87K1SrWJ2FNXAtQRzWFMOwfUZNSn2f7jgWullziablM4rVh?=
 =?us-ascii?Q?DN6Tsxv+2goKz7CwrU2phgnol7RRNBnSX7O5h68GZLOwUtAtcDo9htokTL+s?=
 =?us-ascii?Q?DrHxHMYnkqbz//oe6NpZY/h8jNFiZj7zB8qx0pzFdgfd47rti/n8zI8P2R3C?=
 =?us-ascii?Q?dPTY1gzY+bqtXIoMQDsFHk7lHYf2B1htrbEOMgtwG3Zc2R2zFtUXO3kw8Dhj?=
 =?us-ascii?Q?Dfc89aOW+hFHgTv7C6tqPaYKNhEKUg+Bt4218q88X6/YWejyqQQPXlT7Npwg?=
 =?us-ascii?Q?YT4ePWemXGl1cnucFWkJndWWIN+DUlYYB/C6FgEMwKJlZsKGe6B18xlQvHky?=
 =?us-ascii?Q?KTscCcZTN7lki1uacWmZ2ohgRaTApmNR0F6BC4xYSHwySnCByRPuhvgH7Qol?=
 =?us-ascii?Q?N0sr6cgIGYv5+Qzw019e2a8rvmqsVsRZUhg2RyzEm5Cw1LPfdtFS+uRFKZHE?=
 =?us-ascii?Q?A+13z1nThaig8gHY1Vz7gCuEqxdWpHk1RTqJnnWkItJsa3bqDJcP0HL/moM7?=
 =?us-ascii?Q?3isF/k6ELkxIb6177Z/XlITiaeQGIqNm7hYNni/lbKKIGoI7l1lIqkM+hbc3?=
 =?us-ascii?Q?ceQzRZvUXpiC/HH+lN25rS0h2OiN4bpyHFYcrUf2lTw60TgOMkcT88yhiiUw?=
 =?us-ascii?Q?E8a+LhahF1LmripA1AfPHZBPzU/eGqTDXXLKWXEDZ9lQb/QSFvwbaG1TM0+7?=
 =?us-ascii?Q?7JcazAQP9nW9Z4pJ8IzXD0A4GlTfRw/z0NrcDUAl4mlIt6vZ5LpsfGOOidxK?=
 =?us-ascii?Q?0uasrdFZcffV2CZLZP96HFK3uZiX0G1TH40iITbj0iKr3tFzRW/ILm8euyIR?=
 =?us-ascii?Q?dtCcx0Oe8/fOzKoPSsRo7MBlXaOHObO9u1ILVoekTb7znsuXd9XgBZkPne6k?=
 =?us-ascii?Q?+LPouz5DxasCdZArJqGRZT0jz+1qfJ3Nv9oVdUEhKWZG10kvR2Ek5HDB7NTR?=
 =?us-ascii?Q?73qOzol9AB/GxnW7+G/xHYMyfQfxr3BgYizVbl3T707nHwphmdIWRVwhYnQU?=
 =?us-ascii?Q?PLPz07L2wJq+X4O9/cmQYYVzdN0IbFlxo/iDel0BgL4s7547zUUPnr1kYR3P?=
 =?us-ascii?Q?6xgi86hHfMTEG6MK5jPGeosPZn5bQJbJ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 21:24:12.1924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9a498e-6751-4b7e-3a22-08dcb339742c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7758

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


