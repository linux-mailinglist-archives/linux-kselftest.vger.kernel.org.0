Return-Path: <linux-kselftest+bounces-35040-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 081C3ADA753
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 07:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E81165686
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 05:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB27D1DD0D4;
	Mon, 16 Jun 2025 05:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BB6NdGuO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132CA1D63C7;
	Mon, 16 Jun 2025 05:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750050170; cv=fail; b=PpadIciMJfWOpSuQCRBWiKbYB3IfH0kgtM1FrxZQmpeb/+6145fG6bD3m2lPGabDpXn3/5rvHedenhWZ06LWivA624O6V4qQBwi5SQqGSIfcNxD2Ie/VN4uyzdNtUrw44+S+iulUN3ZssKNOdFzpK8xMw9Wjw2BquBnrZufSh9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750050170; c=relaxed/simple;
	bh=OcaSu5upayMqXAnVY3F5G71gnxO4Bf+QEGcG5++SEOg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PdwOLU9eo60FWv9ZGVZjxz8XmqgqytaBdfWBmxQbka9TnmX5O7TCTWHgpYtMv10alDUOwLfqwNF5wuwsyY5Nrr1rqPxDuss7nBbn1uMbfNWB5G9yu2vKukfaYqPWr7can2ryLm5b72Xt4/98lG6kA7mIZ9pIynLgh3XqrbFWaA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BB6NdGuO; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WyzEyg0FX1yC4wlP3QMbwEr9/jAyjPLdHztNOIRQ8DlRiEeU4Wnf2ihWishTZBWLVt9pFYfZKWOhiLBICwgho+i5tIdRIUvkejRgepKlNRgp1MdWFFkG2EGnPZify775raIzyQlSo2+7GYy4yHiZvqmXK5ZZc336PRxN5VgIZJ4Mnbuo2u+qDi+bD3i11w5v6P2DmfxTjU3wNTCnuZRkm3qG5kLW0ivefhHXZ+AkWI3yGz5K2zRqaIOhwSlckPLhK+l8Lq5EcW31jXR1hpDC5Bc9F0vyfs40L4GcPpISO0PyqlFo8QORy/gIfbz3oJQRh9Ptomkbg4d68UweeYVzHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6EA4sxPELEgtEIyjs+802VjbqVx/acNNDcI4XIxzS4=;
 b=gz+O7tjgqMgplmmb/hcgX5uKySj6L3+XiOxdsvaMnsNSxaNIRDJtBzAnJFejwPvw2oj68RhNXTgfOZY1JFAPi3bHwoyfyPs3wyxLPIOkjXXnvbSngJQ0JkoRxJ9cefsSuFogauQZPS3awc+DNwtd9fzR/7nr7xt9wr8Vtck3JB47FqmVcmjOHGQGojJOwIwfl2ArHzCFw7/sHdLXrUoMQAH05XLPRcGCMwE7oD+lOt7HyMrahFKF1WggxZ3HUJRcODcr3slj806wJ4388nBCU8RS5Ac3hbhNr8b9SrzItBQp6xxzZIiutqhBzggOfs2MCDncXRl82ahqoMAtmBomPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6EA4sxPELEgtEIyjs+802VjbqVx/acNNDcI4XIxzS4=;
 b=BB6NdGuOmH7otcA74efyiW/LAyU+0L379p/+qFRB3cN8nexjbcHyRobnaKtAWsa91JWCdtON9zRgPIl/D9vvIz3WG5XzItpruqVqHHOIqmosaqXcL/5vorwc5ydRxkWdgyUXqt5eeykafDg1uSv78CAU3ytvR9XJoz8FN6qGnchlZwH/q0jvfKNY++fiWEgh2oZbuZTKCLlAKcbofRa7IGSpNBrknyP+tTGI65qjurpP1ot+qnDTbCrSAwOTrcrMoCKl4jL7s9FsxiBJNpROylFkBPl9YRIDhQQ2+/27dKnpLZyWrCULapSwUf50kBg72Mi+DKGWiQJU9NxmroRr4g==
Received: from YQZPR01CA0107.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:83::19)
 by MW4PR12MB7239.namprd12.prod.outlook.com (2603:10b6:303:228::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Mon, 16 Jun
 2025 05:02:42 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:c01:83:cafe::f0) by YQZPR01CA0107.outlook.office365.com
 (2603:10b6:c01:83::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.26 via Frontend Transport; Mon,
 16 Jun 2025 05:02:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 05:02:41 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 15 Jun
 2025 22:02:24 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 15 Jun 2025 22:02:23 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 15 Jun 2025 22:02:23 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <shuah@kernel.org>, <joao.m.martins@oracle.com>,
	<steven.sistare@oracle.com>, <iommu@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<thomas.weissschuh@linutronix.de>
Subject: [PATCH rc 1/4] iommufd/selftest: Fix iommufd_dirty_tracking with large hugepage sizes
Date: Sun, 15 Jun 2025 22:02:03 -0700
Message-ID: <9515eb5cb58bc8dfec083df51550bd9ae6d60da9.1750049883.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750049883.git.nicolinc@nvidia.com>
References: <cover.1750049883.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|MW4PR12MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca8a423-e186-4a52-c83a-08ddac930602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pBwUDKokLgTch3yweUgAjr5sLkRb62UwaLKQ2ywZseFIq8uttXIk6H1xvHID?=
 =?us-ascii?Q?WxNw7vDbG7Cynr0h7eFqaoZGCg7r8qEi+FEbjZCyUvj82FnFB9ZXfOaIZ+e2?=
 =?us-ascii?Q?GuaWQU3OxE544UkpasKVlvd90c/9FN0bC83HE4N/fDAaBfheZ9Tiy3MdtNlc?=
 =?us-ascii?Q?G7Qs0KFN+Ks1wbRZFtdbhpu1xyWIjAROWASb70bDUMQZJxr8Z5MfNd75UKFv?=
 =?us-ascii?Q?+zxF5cNQRQ8hdpKV90Ti4lBJsAoyI1dmIPThLMHJxPNqBy2p6yl9v/K2nBgM?=
 =?us-ascii?Q?/HWFdcVJw8Z1i6kbGQBP6M4V3Cclv+ci8SFGIw9zdkRz7Rc4p9MB3XjMqSVM?=
 =?us-ascii?Q?BIDYk8DxGXhU+He4CwTgini8xLsg9FBz05Dv2vXc7BfSz0p3uPP8gurKZmIO?=
 =?us-ascii?Q?+bB8P7pgX9mOHoVB+C47GnSN1wMWn383LPVAJMw3r5otsyISFkHXCBzteMWe?=
 =?us-ascii?Q?yC3CeNRdxhDPT7LJ3B6e9OFouZX3MYuvNULlPn5mIKeoDdlBkb0b3lPbqp9K?=
 =?us-ascii?Q?KNvregDPDr/tOnFPSfTkfKB2WGeyobFO8xE4MyK6uRfO2MelNQ1PSoWQZWc3?=
 =?us-ascii?Q?AH4+tbM7YEwLAdg4EGkGnKUjuDNxMkVD3Dg//0gwpwhGogc4UKMb2JNLENEK?=
 =?us-ascii?Q?kC5PX27q8sFRVjW1qZhSKoyTnKdTatvgz/CwjQIoJb7Ye/KGayYatI/LEGtP?=
 =?us-ascii?Q?YLSXBJWQbzlL8tLpx/rtQNiJml93px0PftdIum4mKRO0lwtqw99ALzxi5kni?=
 =?us-ascii?Q?2KmOBKpUPTWNAv6tvmU5fbYu4hq86vqR11oI0zOPU0kTHOXyLuKH8flccAl0?=
 =?us-ascii?Q?bIbcK7ezsALIYPRFQ5JB23fhnk6u/ICAkHBXh/vNHSOFtl++iK4VDR2WI0+d?=
 =?us-ascii?Q?1odcb6x1KTNjRGk2uyxHJ4pESzc0Y3Wm5SBrLOL4DPkWWc8lnFU5r1qfM+St?=
 =?us-ascii?Q?XJv7qzwUzVfrOoGUWxmQIX13Zu29nl7rEoAz9STnWmIUHG0YiFEuWsuZ7WMY?=
 =?us-ascii?Q?XZ4hFLP2o1Hcsw6eGpv8y81UMOgdhxVYmzfxTv03Mqas5DWdbzdLc7JmDzGT?=
 =?us-ascii?Q?+FcR1Bz6vYVIWkp3S1Rhex6qHUgbL3JV8SrFV6rDoElFsGt57hpwY1cYntvT?=
 =?us-ascii?Q?Yx2LUMFzhEmYm18Fz7ab3qEqPfvHVvewOSOepf7jGOtPXrk9FrRnwpklWxd+?=
 =?us-ascii?Q?L8WrtQV2YorY4dT8ymkJLA7zqWnO0koes5GFGY8ZZHOtEMNfcd9h1TuAA5u2?=
 =?us-ascii?Q?+dRyEjIXfEo8Cj6+CbzWdExAqM0s7Cb0x4OxstmDIK4qquEOQyCN5O3XHW/a?=
 =?us-ascii?Q?T6aOAnVPjQeIc1RIyQd7yre26smNVOx1KS40NYMxxSJWzQ9vThxmP4p/EVr8?=
 =?us-ascii?Q?6h/uCikAlnsCQ9FTDLoo+zvQX1HQqUzmvh+LShdDnZGKpf823ecmAHm0QQf9?=
 =?us-ascii?Q?t+EsyAi/wEcDFvnDKrxNHTmT2oQ4Cr2Yg9dZDb5oYQaLm/pRZNH21xi5nYwI?=
 =?us-ascii?Q?S+GwQUqD8ZCL6K2EybV17XvcdqMMrQQHi8n3?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 05:02:41.6061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca8a423-e186-4a52-c83a-08ddac930602
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7239

The hugepage test cases of iommufd_dirty_tracking have the 64MB and 128MB
coverages. Both of them are smaller than the default hugepage size 512MB,
when CONFIG_PAGE_SIZE_64KB=y. However, these test cases have a variant of
using huge pages, which would mmap(MAP_HUGETLB) using these smaller sizes
than the system hugepag size. This results in the kernel aligning up the
smaller size to 512MB. If a memory was located between the upper 64/128MB
size boundary and the hugepage 512MB boundary, it would get wiped out:
https://lore.kernel.org/all/aEoUhPYIAizTLADq@nvidia.com/

Given that this aligning up behavior is well documented, we have no choice
but to allocate a hugepage aligned size to avoid this unintended wipe out.
Instead of relying on the kernel's internal force alignment, pass the same
size to posix_memalign() and map().

On the other hand, the munmap() handler in the kernel doesn't align up, so
we have to manually fix the munmap length to prevent a size mismatch.

Also, fix the FIXTURE_TEARDOWN(), as it misuses an munmap() for the bitmap
allocated via posix_memalign() and forgets to free the self->buffer.

Fixes: a9af47e382a4 ("iommufd/selftest: Test IOMMU_HWPT_GET_DIRTY_BITMAP")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd.c | 28 ++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 1a8e85afe9aa..602f8540242b 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -7,6 +7,7 @@
 #include <sys/eventfd.h>
 
 #define __EXPORTED_HEADERS__
+#include <linux/const.h>
 #include <linux/vfio.h>
 
 #include "iommufd_utils.h"
@@ -2022,7 +2023,19 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
 	self->fd = open("/dev/iommu", O_RDWR);
 	ASSERT_NE(-1, self->fd);
 
-	rc = posix_memalign(&self->buffer, HUGEPAGE_SIZE, variant->buffer_size);
+	if (variant->hugepages) {
+		/*
+		 * Allocation must be aligned to the HUGEPAGE_SIZE, because the
+		 * following mmap() will automatically align the length to be a
+		 * multiple of the underlying huge page size. Failing to do the
+		 * same at this allocation will result in a memory overwrite by
+		 * the mmap().
+		 */
+		size = __ALIGN_KERNEL(variant->buffer_size, HUGEPAGE_SIZE);
+	} else {
+		size = variant->buffer_size;
+	}
+	rc = posix_memalign(&self->buffer, HUGEPAGE_SIZE, size);
 	if (rc || !self->buffer) {
 		SKIP(return, "Skipping buffer_size=%lu due to errno=%d",
 			   variant->buffer_size, rc);
@@ -2037,8 +2050,8 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
 		mmap_flags |= MAP_HUGETLB | MAP_POPULATE;
 	}
 	assert((uintptr_t)self->buffer % HUGEPAGE_SIZE == 0);
-	vrc = mmap(self->buffer, variant->buffer_size, PROT_READ | PROT_WRITE,
-		   mmap_flags, -1, 0);
+	vrc = mmap(self->buffer, size, PROT_READ | PROT_WRITE, mmap_flags, -1,
+		   0);
 	assert(vrc == self->buffer);
 
 	self->page_size = MOCK_PAGE_SIZE;
@@ -2066,8 +2079,13 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
 
 FIXTURE_TEARDOWN(iommufd_dirty_tracking)
 {
-	munmap(self->buffer, variant->buffer_size);
-	munmap(self->bitmap, DIV_ROUND_UP(self->bitmap_size, BITS_PER_BYTE));
+	unsigned long size = variant->buffer_size;
+
+	if (variant->hugepages)
+		size = __ALIGN_KERNEL(variant->buffer_size, HUGEPAGE_SIZE);
+	munmap(self->buffer, size);
+	free(self->buffer);
+	free(self->bitmap);
 	teardown_iommufd(self->fd, _metadata);
 }
 
-- 
2.43.0


