Return-Path: <linux-kselftest+bounces-35699-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8CDAE6E05
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 20:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77DF45A21CF
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 18:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E702F2E6D20;
	Tue, 24 Jun 2025 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W196X5NL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752702E62B3;
	Tue, 24 Jun 2025 18:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788081; cv=fail; b=ukco5Sex7e8cyQMVeTv5fw6qaJOyVyTU5zzsgEb2guCJO7zfIpcqLkj7rrNARjtJyGSq0UvPRWcyunXsGmCOmBe+7rH9ArEklGYfoDvJtIM6FabTsPWl2QNsRidUTlv+FAGnzm+W4datPHXinid9fR6cTP9cdUP0rAhJJs03lIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788081; c=relaxed/simple;
	bh=TVAZESO6eMlJRQxUWV37Lp688BbaFvzN3aYBiCNGxWI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TsDZzroRPzkQ4FZ0sNMVENnn8zTaZWvKS3w7ek6wHXGuMQaRCLDBrre+QQmjgHjeIGjX55mHBleTQigH5eG50By6NdXcIAj/L7pTTFe3hS9XOVpwrM8jNmOiP+MvJ5f6ViT2m1yitoSzXAaPRDmjghXj/ujk7FTgWTFw2Vr0XdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W196X5NL; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQ3QuFptTSuTGTtXzeoMTr5vpgdOCDeJKDIOAUHmcsqJ0PAE1Gmu+78aYdw9lmoux3KIfQldx2/1cPpCRldWNnf2dzDSn4lQwaOGNrv8MvvLBhjuEYcq7A855eHibi1S3BbdhS6DCAsG+5IFgwMdwcg+63XNDqHkQC6JIczHXMFmm+m65fsom0GCR2wX8DxvdZlqRgRXUeb0DMaVhI7ngcPLsDEtiqOgjF6oFLNhlicHSSxcMqEyfAEUQoJPWn6z/IAe5g6hj20I57YWrIBWPY0iLoGcYKbn+o352/eAqVeT1QlDSguSgpuhHaeM/jxeksgyfVn8KfxgbM/cg6HfRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMgFP8VkwrOWN3KeVrHlV9smNmEx1d/QYkXIzKEjZCM=;
 b=xxx825RZdrMkadC4IcNipdvqXvSV/Rqb+WlRbUoQowJIt/MDar0LMHI/jqCaJVDO+tKpoZWsmDAMZEcSOKjcQ36EnJFJDZwwnO3blw9pbQU8gl8whRJ4t18uOmrqvqZ+MupZ0zXlt+lzL0dYNGQnoYihrnyhJAQ+K65Z0NSUSDIBCZ5op9febDF+21tYREOX2b+94muueJeUVweSa3S5Fy7RKDi1VIdfJp8TShVE9fiSbB6pefJyz7wKzc18+nD3GvOMtczTLjAcVvBofKuE2yHHq/ri1ztwSEfO7UA42ATT8VkG1F1bXw4w6JvvI/EY+HXJQTbb0yRpIhTHOQYlWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMgFP8VkwrOWN3KeVrHlV9smNmEx1d/QYkXIzKEjZCM=;
 b=W196X5NLUED4SWxSP2uMIQ0gERE2Tq86Aht5I/BPE4f86Npv8lQOhgPDR9/XFfa8YIjIo41yppssSlWjSFAgvz6RtOdlFPd/89RBewEmfxVi8RHZfWN1WPFDSNqpSfKd6AoMQAAetN8ZQsMkVn46pii860CYrfywiICo8IcfVFFUVJnUMF9Uw8vLuoNWEahiLbi/cSgeqLZfdVf5L4dWESVf8jnBuA+FhRL3fVBYbAiJHc2jFkxDELIDvrZ5IsPRaPIkqCbLIA/goSxCqSwogdWq6kYAUzxKGzwL6YMBUDLvT1H9q41w7uAXphzM3diVwFedEskDeiohnVhoR4j+CA==
Received: from CH0PR03CA0320.namprd03.prod.outlook.com (2603:10b6:610:118::25)
 by SJ1PR12MB6244.namprd12.prod.outlook.com (2603:10b6:a03:455::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Tue, 24 Jun
 2025 18:01:14 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::40) by CH0PR03CA0320.outlook.office365.com
 (2603:10b6:610:118::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Tue,
 24 Jun 2025 18:01:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 18:01:13 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 24 Jun
 2025 11:00:56 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 24 Jun
 2025 11:00:56 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 24 Jun 2025 11:00:55 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <shuah@kernel.org>, <joao.m.martins@oracle.com>,
	<steven.sistare@oracle.com>, <iommu@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<thomas.weissschuh@linutronix.de>
Subject: [PATCH rc v2 1/4] iommufd/selftest: Fix iommufd_dirty_tracking with large hugepage sizes
Date: Tue, 24 Jun 2025 11:00:45 -0700
Message-ID: <1ea8609ae6d523fdd4d8efb179ddee79c8582cb6.1750787928.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750787928.git.nicolinc@nvidia.com>
References: <cover.1750787928.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|SJ1PR12MB6244:EE_
X-MS-Office365-Filtering-Correlation-Id: cf3192b5-7af2-4267-3a41-08ddb3491bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bqozCCBpcOD/1dV+5RRN6w0Cy3WBh74eqYZNMzMbP9Ju968MCKwPpZMIFpxs?=
 =?us-ascii?Q?iu0MR/i2FF6xJ2RqSTisdFGKIB1Jy7WczxE1keIZ5VAXQvy0208KdH1ZV/JA?=
 =?us-ascii?Q?/hvRl8nCHRu5WGhszjwnJ1Y53xjmjUHiMa91UTIwMcSFfqVCQD2MX1fTZPyJ?=
 =?us-ascii?Q?Aa0tdovNJQ599yfKHdfMekrvSs1wC2S0U0Wq7DPbIpWNytlG2brmjjREvzt4?=
 =?us-ascii?Q?Dt6qK2T7zstOuamIXLgkzo/kzbEeIEkn/Dro4iYbgKbXfrZ9PcOOvaecTYIp?=
 =?us-ascii?Q?kqQkngl0O37Nm2eZ0EBfneGArKgUaGJ3/7VuBhPRks1iObGO5JnIT94roEWl?=
 =?us-ascii?Q?dcwr05qhTps9U9ub0t5+v5tM7VEBmTWtqqzGm8EoFo/NeeoiRMuDMiDYUbGf?=
 =?us-ascii?Q?mDyAARyCSQr7J/kNiiyuUdtPJYc5+Xq5Y95juPt0Fap2lJ1iScqwzcbmvwlw?=
 =?us-ascii?Q?XAD2JnjFk03fbXoAI0q5MsGvOcslBoiyI3pO/ifyDED2D2qf42df+cEIuhFN?=
 =?us-ascii?Q?J8DJ8V7O5gXq4vuRJiF32h/dAVgw3luigUFlFocGQpvayOu1Xh86dAZ5m9zK?=
 =?us-ascii?Q?pQUhjPmnReaFacnX/4I2L5ZYTphbnV8kj9pipBLBtob+4/o/A0+PtwtvXx2u?=
 =?us-ascii?Q?SuLw1hEOvU21oMcE79RBIqpnony9eR3Cl87DgJy7C/d95qYO62Yn8Vd0WoXm?=
 =?us-ascii?Q?wMkFbdUiUWhbGlyjcorSExUw/2bsauB5tMC/0T5yeB26RvK5/0o0QKx2z9wP?=
 =?us-ascii?Q?Yk91uRL07vJK5ef2ghIsD/ZB7FGTSg8yBlOGTnTm8fne4mzQMpCLAAQymd3W?=
 =?us-ascii?Q?VA/jD6fO8NilQb6B5KiKJjViVIes0rlVZ5dRi0zb1nhYDl/+eIOsN1dHJXAl?=
 =?us-ascii?Q?1yzd8TTDKio52KiIiDnjG8DweLIiAoCVXRo+5h2ZTZb2qAhG3BMC+VLQV7dr?=
 =?us-ascii?Q?XvJF3sZlgaImZ7wG75vVW8AKKB1OCM4pIbghY5Qp6X0f83NSEAbQU54JyhSo?=
 =?us-ascii?Q?kGcZLJNj0aJFqlRyx9VW+ObsNV+E+3boUGZm/AH950VQMVFBSmj0P2NUPS0C?=
 =?us-ascii?Q?YgmlvWF+PpveMuePW1T4UK16oLKKqhKL08pzQ5FG7nL1QtmURF8lpK9yIso+?=
 =?us-ascii?Q?ibZ92NbyLwSkdUdEYt9eF7rz0aI19/FJNYU7LYoOX04VZEP18pAZMxRYcuEA?=
 =?us-ascii?Q?dwKV25NV5rFoJX8psMu4P5endsaWlMTynrdXS4PZihbjDmD/ZsLh1nANE9C3?=
 =?us-ascii?Q?CqgXfb/COQdP9IgVSWUaNNkSnIAnzS1tnktn2h4Ybd6JrmuSZJHr7zXkfzf5?=
 =?us-ascii?Q?XmzD4zHuFVlyYlVucki5xhIEzvjikNjaE39M0nCCWhfxdctw8qqgEBKrvUZL?=
 =?us-ascii?Q?5/ZmrFgqz221wwuf54gLahvQWhcAiM3kepbjfGe9noxQfA7dtM+E1l4sNSX3?=
 =?us-ascii?Q?JiZQCwhV0Q1A6FMYWRNs76t+k+xptMEs3EZTeJC58JbJs48cObvZJQpoUwr1?=
 =?us-ascii?Q?tJ/2gUj7P/L1YtZrqyPluikZgt8ia6cy0pH8?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 18:01:13.4342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3192b5-7af2-4267-3a41-08ddb3491bbe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6244

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

Also, fix the FIXTURE_TEARDOWN() misusing munmap() to free the memory from
posix_memalign(), as munmap() doesn't destroy the allocator meta data. So,
call free() instead.

Fixes: a9af47e382a4 ("iommufd/selftest: Test IOMMU_HWPT_GET_DIRTY_BITMAP")
Cc: stable@vger.kernel.org
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd.c | 30 +++++++++++++++++--------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 1a8e85afe9aa..e7eb11a94034 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2008,6 +2008,7 @@ FIXTURE_VARIANT(iommufd_dirty_tracking)
 
 FIXTURE_SETUP(iommufd_dirty_tracking)
 {
+	size_t mmap_buffer_size;
 	unsigned long size;
 	int mmap_flags;
 	void *vrc;
@@ -2022,22 +2023,33 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
 	self->fd = open("/dev/iommu", O_RDWR);
 	ASSERT_NE(-1, self->fd);
 
-	rc = posix_memalign(&self->buffer, HUGEPAGE_SIZE, variant->buffer_size);
-	if (rc || !self->buffer) {
-		SKIP(return, "Skipping buffer_size=%lu due to errno=%d",
-			   variant->buffer_size, rc);
-	}
-
 	mmap_flags = MAP_SHARED | MAP_ANONYMOUS | MAP_FIXED;
+	mmap_buffer_size = variant->buffer_size;
 	if (variant->hugepages) {
 		/*
 		 * MAP_POPULATE will cause the kernel to fail mmap if THPs are
 		 * not available.
 		 */
 		mmap_flags |= MAP_HUGETLB | MAP_POPULATE;
+
+		/*
+		 * Allocation must be aligned to the HUGEPAGE_SIZE, because the
+		 * following mmap() will automatically align the length to be a
+		 * multiple of the underlying huge page size. Failing to do the
+		 * same at this allocation will result in a memory overwrite by
+		 * the mmap().
+		 */
+		if (mmap_buffer_size < HUGEPAGE_SIZE)
+			mmap_buffer_size = HUGEPAGE_SIZE;
+	}
+
+	rc = posix_memalign(&self->buffer, HUGEPAGE_SIZE, mmap_buffer_size);
+	if (rc || !self->buffer) {
+		SKIP(return, "Skipping buffer_size=%lu due to errno=%d",
+			   mmap_buffer_size, rc);
 	}
 	assert((uintptr_t)self->buffer % HUGEPAGE_SIZE == 0);
-	vrc = mmap(self->buffer, variant->buffer_size, PROT_READ | PROT_WRITE,
+	vrc = mmap(self->buffer, mmap_buffer_size, PROT_READ | PROT_WRITE,
 		   mmap_flags, -1, 0);
 	assert(vrc == self->buffer);
 
@@ -2066,8 +2078,8 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
 
 FIXTURE_TEARDOWN(iommufd_dirty_tracking)
 {
-	munmap(self->buffer, variant->buffer_size);
-	munmap(self->bitmap, DIV_ROUND_UP(self->bitmap_size, BITS_PER_BYTE));
+	free(self->buffer);
+	free(self->bitmap);
 	teardown_iommufd(self->fd, _metadata);
 }
 
-- 
2.43.0


