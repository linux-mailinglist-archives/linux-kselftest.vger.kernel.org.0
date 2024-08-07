Return-Path: <linux-kselftest+bounces-14946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC33194B030
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 21:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC329B21266
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 19:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D600C143873;
	Wed,  7 Aug 2024 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ans0Plp1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF901428F3;
	Wed,  7 Aug 2024 19:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723057246; cv=fail; b=YVbyxGb+2yJr5v7bHGMal3p1aJL0PFbBKDOHrZo+LANhg2pRayNG9CFooeazMr+a2AEE1qrkJFxlbRBHYOteJv0MvYtg9KvPS1ShRBSumJuLxN4gqbTE8MgnUc144zIy9PMYNmSiLgXlTnR1p6q3GgzExBokXfgqy/fItsBl19M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723057246; c=relaxed/simple;
	bh=fEKkrY7YwhXWlFDLVUhbUmi18zOaTxltmSUYMlU1Hxw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TtDPxDMw+AO4HQhrC8/bT+qOh9z4NIMyf/NhtD8EB3wCgNxfCSL9CDmJXh4PLI29V7IAhecu6WvDJx3KZ68BMBpNy/vxcn4rAAuCR7JwIOQ7vpZlIepBnt5DiSU6q/rgdij6YVnqmzZtnzEGi3YsoHTD7cDf0fdfTrpgTAWyWK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ans0Plp1; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bsyq5XSdxJ5e5mm154x6czVb+gqxkkcOCw0Ug7YFhTVkWDZtbDixJKVhGiGLmvoXjtlnEq0FdZzzagKwCuMzuUqEp95WdUFqN2gkINYnII5XMI5TuMLdd6eVPkWuG0LX/1LgXRNapNJWBXtz9+d4rQxg2pJoRFxSgeJvCCJYMkiQggSypwupxfwTJz8M/ABu9o3BTIFNqk0+f6i0vEwHBJsyz/PQ0GfDmySVd7lW5w1mjfwsyqdyoXgT8PDBvq86Ul98J1JUsrc1NFkMiEDLSZfeoM55gY1uq1hjh3+MZyVUbfU9IflXMo4jI1PlJFW3/z2cz1fYLPVBQuD2Gf5cgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRSIeP47Q5fSho8mxyLN4SSHM3LnVn9nduewZx/YizI=;
 b=j6N60P2Vn82/PmgEVX5BV92AVrNJPoLLFqHfZ9t35T5N57xEbW0V9j0STf917O3xyMuC6XvPD5T7yBAjpatqu1iiEHGlgkHLU06GGF51hgRW9D46S2ZuVF2VovI2aIUiJ/ruc6kZHAobeqF79LXMXRjM1lWE4nPkn34xU76g9qYUPU8J814b1wd6CCEwVsAhmYkvrj0t1BlNE83U1eijaxPOsX2qg8XALtqjSbsDAvOcZyAOu8rb8tGdzGJ5TRqpY/sKdixvtZ9uTfgnUVzal7R9OA3BkFLVO8FlSGr3MIeJvCp7DCiMKQu9Iaot1uH3AJgy0kGRFmEAY66y9z8zbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRSIeP47Q5fSho8mxyLN4SSHM3LnVn9nduewZx/YizI=;
 b=ans0Plp1sDLemW87aS6ru5ZdwsMvcYUlwES23AAHIN3HXIF5HXt0wQyaI4exqA4D0jOOsHu/EG7akKUZfKs8al1R0MyUdQEe14ZN+TUVqLj8zSip1BXBaiDQkL3+DVBKn4IndiOqIjzzy/IjVheNqj89rbbQzJvWz5mFrBlDiPnuMSpaaJuuRndv2Ihe/04dN1T7Dvcni+65Qfc2mSBGVhU+pKMShSBx6zc3XglBF9qAb/VAY9OEREWElp5IPLSnL27cMunKqaPUA3fh+0eXbQ3VH8usExMCTzQLGsbzmpxbo8oBpkqAcB4++w7fzZn1uQacl7QtczzGo9WYiO09QA==
Received: from SN7P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::16)
 by MN2PR12MB4094.namprd12.prod.outlook.com (2603:10b6:208:15f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 19:00:38 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:124::4) by SN7P222CA0016.outlook.office365.com
 (2603:10b6:806:124::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23 via Frontend
 Transport; Wed, 7 Aug 2024 19:00:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Wed, 7 Aug 2024 19:00:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 12:00:20 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 12:00:19 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 Aug 2024 12:00:18 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <shuah@kernel.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH v3 1/4] iommufd: Reorder include files
Date: Wed, 7 Aug 2024 12:00:04 -0700
Message-ID: <f5b7fbee5fd5d964c43895f87a23d3295d0cd98c.1723056910.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723056910.git.nicolinc@nvidia.com>
References: <cover.1723056910.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|MN2PR12MB4094:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ef7adc-0140-46b3-7f74-08dcb7133998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n4qBaasPna6N00AGP5R9OaVpl02gRoTh8EfVQgL/KMn2l2vnNVR9IVa8X3fL?=
 =?us-ascii?Q?Jgr6sSo2okqEKcmBeWbtf51v94jgW9hUgyDkbZ1V//xN6KexNAX7oyXcNX/H?=
 =?us-ascii?Q?hzAOY1xPwEnVlOUyyuihclHx0eq1xWlnkFKgm7X3BO8RXTeUXsfBGSxoelTi?=
 =?us-ascii?Q?MXwm+lJ0fwzSNGu9Nw705mt0dvFgbAnULdGaLSM5AtDniDmf3sLrCOZf4IgS?=
 =?us-ascii?Q?mVp49NHnUNgvnnn9VAS6h5AjnZn+seT3fguv8zw0ddt7lur+scvxmI9qwcpn?=
 =?us-ascii?Q?YQNpV8Fs96Q9kUi9fUCdbNhUzRwLw3bgc7gOTD/27FZQT9rE4GWWNDydNP/Z?=
 =?us-ascii?Q?G221DIbp/qKtnSB3ymOhxt/yDQwTs3Riwcz21SrgExkFUqA9sn3tVmB17FSa?=
 =?us-ascii?Q?i1JJi0pjsJEBBTst07Pa6qUzz9eZW8ISxnwZpPtZ2RGiqVuF4ICVdypGwrkw?=
 =?us-ascii?Q?zZ2b7xiJxXmFOqf7I3qsAbduqYPAR0d4XmBpaxr4bUpfjW7xgvjwKGtuhwSk?=
 =?us-ascii?Q?GV6KiayMT0V0z7P6yywsfWzxnSM9umSHian4ooPILt121FWM9Xr4pZMpnhkJ?=
 =?us-ascii?Q?g37vCIk6RV1q9dacEU71q7aUOzeezKTqMNrYBQym8lx9FwA0Np2BLjI3yVXe?=
 =?us-ascii?Q?iIab+6564ppHvbrwE2cuhAVLNth2DJC6Mo0ajRnV6JW5WKL0DzKkvVkrwx/t?=
 =?us-ascii?Q?JRVzXuDG1yZkvUYe3P1Ic+k/VfUPw2Erp6MdzMFXQNQ3+M8difczfYtaGQKI?=
 =?us-ascii?Q?cVynY9QPlifDz8msQlBQYgo9cMFiF7A6N47Ae9uXlXeW2Ti2iO+FOPofdyUp?=
 =?us-ascii?Q?dZglEF0Se9ghId9H6DT2ZScCdjoKLKOzkBNJAuT+jRkjEmnQJgbl+X1JZLbN?=
 =?us-ascii?Q?xXWxasv7molk8d4aH49FSKhUES782H3U5KqBA9m+MBpnDZid+TQf8vyd96fG?=
 =?us-ascii?Q?VyZ3ST9dz5kMKEhNUTryQf0Kioz3IYch9b7CFtbqh9jZoJuhWoOYIvJy0bfL?=
 =?us-ascii?Q?G5S5wmaLmLfauLfWuXNn8BiuF5zAXN9grkPEu91yze3NCPAVLHM6BzY4q97U?=
 =?us-ascii?Q?YiLfkjqYgZLxWdg3IwcJbL0OFeK7BDpmrFO8KUikiGjAh/QcJD5NJtb+yZUO?=
 =?us-ascii?Q?5MzpmTCT1GwVwBcz5P9LwIBvU0ABZxWfnevq68LoLPPk7YwepT3GuzuMIPz2?=
 =?us-ascii?Q?lBIuflhX6hHLKofKqepHxbKfTApY8POCe4h9skrROFLbZ8yqaCn4E55Mb0Uy?=
 =?us-ascii?Q?qKvUH8PMurvCcR+3fdxPW7R69UTLwPZ1Ch1MBwq73bhxNGEL+lLZzypqdKPD?=
 =?us-ascii?Q?GNdKQFSGD3DojcvT/1XvaTGmhslbQM4JhbcHyqwL9/GjrxNX4D0FoEf4CFNF?=
 =?us-ascii?Q?UCCoMCOw12awN4HSS70vcmcmOnFp/yT9qmn9cv7mc4N3x1y1nzsfiSaa8U8U?=
 =?us-ascii?Q?TDz3aLZzFE8aRopk8gAh6RMmDuSRF2kt?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 19:00:37.6918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ef7adc-0140-46b3-7f74-08dcb7133998
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4094

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
index bcbcd6d94062..5fd3dd420290 100644
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
index a643d5c7c535..df03411c8728 100644
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
index 05fd9d3abf1b..bbbc8a044bcf 100644
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
index 0ec3509b7e33..c61d74471684 100644
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
index 742248276548..82428e44a837 100644
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
index 0bfacaf40c05..5d3768d77099 100644
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
index acbbba1c6671..f4bc23a92f9a 100644
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
index b9e964b1ad5c..d90b9e253412 100644
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
index 83bbd7c5d160..b5f5d27ee963 100644
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
index 117f644a0c5b..93d806c9c073 100644
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
index f95e32e29133..b60687f57bef 100644
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
index ffc3a949f837..c2f2f6b9148e 100644
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
index f2d1677ddec4..d42e0471156f 100644
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


