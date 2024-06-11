Return-Path: <linux-kselftest+bounces-11715-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F879046D9
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 00:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 138D61F22BE3
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 22:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC4B152DE0;
	Tue, 11 Jun 2024 22:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mftvuLQp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAEC38DC8;
	Tue, 11 Jun 2024 22:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718144325; cv=fail; b=eVI7zSRl2WZ5HffL0QEigFPwFt25Xb7mpD/QkJQvmRP9ZhrbKV9eXDnYrX1a6wVhmmCjrFrQ3rayhRtGxC5c4eNOyHjoidgXs0x4DQX/+/fGSHNx5zEHLQE+zy1EE+9AONmrnWq+WQ+XfUgRmT9xQM4iB17uhhyjdVItPXtcp/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718144325; c=relaxed/simple;
	bh=PNgMVDVq/DFQgf+dmQ2MexV1n1SoZw0pIArr/AXZjRQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zxz1wYuySqI2+qqJbSHA+/Lc32/hxub2H85OX2EGf0BOjrMqo3qR4mkpmXGRzsQYkje3Diq4H0Tx+Mn3O+NFgO8gUzGawFIYQWIsdttuQZYmViDkmZL+WQPADBPMrF9FmyAM6+CEHwfjoVe6tvudtG/12szZuOzLsuMv30lO84Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mftvuLQp; arc=fail smtp.client-ip=40.107.101.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ui54omT3+isAkVgYFYZo3I/lly9zte+jUTVNl+E+fiLCYHCqNeOMplxchHfvzcwZT7N+JfiWVKVv2P53OPaaOs5ICKE5WUS+YIbN+x2zmarQkwIiBiliDxnnwnlnnfzs+pCLAa9jNlruXqmk78AFGM4O/cDFDemR/9EcdQYJ9xpUG/l7rG+xgDdcPqyIytcYQtS39C2hJY2vUCzvmdrUWvDOdzrEDpX/mbUCYU19lIkWw7pbw39aj8W82c+deD4my/0Z2Gi8Rt2gmm6Qlj/ooJUwFwK/uSCXF1ccPcvWxE8504BNt0nvnYv2MWoiX8V1fXnWzL2C26+/baPw8IMqvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nilAZyOAJcGr84DTsOo64++KertNlf4O0NKtHCoLV+Q=;
 b=AQRLgCe/QFRaTCubC7YPcZZUf/VdlLxQLd6KwjW530PVUqjV2cYMO5124QzVsiTG9ev/9FWfGuUclrAwznviWOpLbb/FE2v84qWaPMpF3z+pNeQJWmO1S5ndmzOreYTXGyxg0xaT86o7lT1DMhNqmc7ibe4wgp26PcR1naHylAMj8bU3Qp5oVWqjSzmmKZuYe8MEPVkOY00VrHnL9FT25B6YGEcvRyYhPB3I0vyyYOsgm1655Woh+rUB9vyS3Dzfoj5sijr0/bsXDfWVPxrvTYaeQJYre2/Okl2DxojnmKGDnM1z0zP2SbU2HacKL6KGNunkgi+6t16LQSfE4yhDSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nilAZyOAJcGr84DTsOo64++KertNlf4O0NKtHCoLV+Q=;
 b=mftvuLQpg86x+SGbk0Z743BKuaE8kDOMoRyaSbMj9m0zD5Ysfh8LXcizFKf4vtVjDBUNG6Socx/lioVFWWuHq4cBuX+5G9S725aw5UB5IjBwjFiaFKmACZ5JKSpJhCTwpNQrBrYWuHS+5OQ6st67lyNRm/Nh3hjAw9+vYGuig9w=
Received: from CH0PR03CA0397.namprd03.prod.outlook.com (2603:10b6:610:11b::30)
 by DM6PR12MB4386.namprd12.prod.outlook.com (2603:10b6:5:28f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 22:18:37 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::31) by CH0PR03CA0397.outlook.office365.com
 (2603:10b6:610:11b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17 via Frontend
 Transport; Tue, 11 Jun 2024 22:18:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 22:18:37 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 17:18:35 -0500
From: Babu Moger <babu.moger@amd.com>
To: <fenghua.yu@intel.com>, <reinette.chatre@intel.com>, <shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <babu.moger@amd.com>,
	<maciej.wieczor-retman@intel.com>, <peternewman@google.com>,
	<eranian@google.com>
Subject: [PATCH v3] selftests/resctrl: Fix non-contiguous CBM for AMD
Date: Tue, 11 Jun 2024 17:18:30 -0500
Message-ID: <96d276c11e69cfb1e29d50a12c8043555c06b404.1718144237.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3a6c9dd9dc6bda6e2582db049bfe853cd836139f.1717622080.git.babu.moger@amd.com>
References: <3a6c9dd9dc6bda6e2582db049bfe853cd836139f.1717622080.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|DM6PR12MB4386:EE_
X-MS-Office365-Filtering-Correlation-Id: bd7fa41d-1016-4f5e-f971-08dc8a64710b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|82310400018|36860700005|376006|1800799016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HciNAPNZaJ8cueGe9ZHoeUH/xHjA1Cc4kaTQJL9fSrROraFqLCiC0dj9jAJr?=
 =?us-ascii?Q?2WyrmDiE+m570cbEqTxrhfwYiBslRV6AZd9KzLcyfm0CC8bTi48cJuVZaI/p?=
 =?us-ascii?Q?CvgjaY/bqip3Yd4uryfce/o659M6Bf9/36mgsOA/ZQ7PDrLuDlPRw5fsiMj3?=
 =?us-ascii?Q?9Y/FUO9/QleuCoNrezs9keCuJaafOm+XnIYDeKPulVeV1nT87cI05I2Xyd6Q?=
 =?us-ascii?Q?GHU+WJ5/RTAnnWFH82fQ3ocyHJNr7vA/5YN6srJCOErL0ITkyff9L/gmWyx6?=
 =?us-ascii?Q?aWb5X97hSmsp6FWIvkMSjkwFu556cC1GO7i8UiUQrpvTsTsyo1PbmUBdU7DZ?=
 =?us-ascii?Q?ymTLGnp7LVdLFq/2cs1dQR0fzxZA0P4CpIEWQDRCoJOH6RhuY+TRi1p/7J3H?=
 =?us-ascii?Q?XuTMrfFj+xEsH88JsUPYHn7omXHI3qEkjiTtW0YJzqyIPTXUPAr68a5O2w02?=
 =?us-ascii?Q?Kkzwj30ZaYjt8F5Kea9k06U07HsrukC7nP/dyzooV8NO6tYUptRz1sd0AQjy?=
 =?us-ascii?Q?tIdBJU+Hp21+deHtMIUkWttmyv4NibAhOauXmSeVP6hSnVvPR6NH6SivZwSv?=
 =?us-ascii?Q?H0wxF90BltMa7r0TiRN7DbEoNcMM0/o/NNu/ZdKo76/ZELUHuv2U08rO976m?=
 =?us-ascii?Q?aS5OZjTOY4OuNi8Rl2Hw/Xx1sjqXbnLVGrIRu8KyLzw+1h35U2kVE+0s7CoL?=
 =?us-ascii?Q?rgoOCqx32kCkYv2+rWaS1p+nDcLVYZ3pYirDGJZ3ya/B3qJL0c++UwaOXm+d?=
 =?us-ascii?Q?5r4N7qnSjblsdMCCzPMpjD7Q19WnEpzHdZmbGpSPAb59Z/O6WIJrlf23QSau?=
 =?us-ascii?Q?9/v7JCqTWJkwUU9VU+5ZAXePiSMemtnIkKnoi2jn1J3aF3NUA8KqMIddYW0L?=
 =?us-ascii?Q?IJNNPsGzlI55BGW80D2vkMGQe2jcgziUrA8oLYkLjOSOz5On8RGC9ec5Q2zd?=
 =?us-ascii?Q?ggayKrviJby18dOOiNrq0W8pSwCZPDE2iijzI/xR8lLFxb30H2rKCngwS6SZ?=
 =?us-ascii?Q?UfMKs6c+4F9p9PgsheSEB/R/2db62xsZf48p07rAyAv+W4IMksJ2fXsqSJ1l?=
 =?us-ascii?Q?2WOMnR/WZJtv1Uvdr2/K9KDUdd+ntfSNxt6w8L9v9u3EWkqFwit+vma98ZqM?=
 =?us-ascii?Q?2RhINc8GU//DS5T70hLur5QjlVyMGr8x5bQNw6exUyFZGTXGr5AUWTTCVM9g?=
 =?us-ascii?Q?tkApqcujij/oJhK9p0rI1R2XlLDuYwPGvuNzQv8hgyov4BdAKcAY6cf4a6J3?=
 =?us-ascii?Q?bnQUjzqiEi0lkyTiT5bmc2/EXsWpT/L1VdEq173tG4IY0SCSUDnu+424Xjok?=
 =?us-ascii?Q?qgdqDa7Gn1fGSt/g+6pMAT3MwwIWjjKui4oT93PCtkWcCm3f8aAPjIxN+euA?=
 =?us-ascii?Q?i2U50Og=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 22:18:37.6646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7fa41d-1016-4f5e-f971-08dc8a64710b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4386

The non-contiguous CBM test fails on AMD with:
Starting L3_NONCONT_CAT test ...
Mounting resctrl to "/sys/fs/resctrl"
CPUID output doesn't match 'sparse_masks' file content!
not ok 5 L3_NONCONT_CAT: test

AMD always supports non-contiguous CBM but does not report it via CPUID.

Fix the non-contiguous CBM test to use CPUID to discover non-contiguous
CBM support only on Intel.

Fixes: ae638551ab64 ("selftests/resctrl: Add non-contiguous CBMs CAT test")
Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v3: Reworked changelong.

v2: Moved the non-contiguous CBM verification to a new function
    arch_supports_noncont_cat.

v1: This was part of the series
    https://lore.kernel.org/lkml/cover.1708637563.git.babu.moger@amd.com/
    Sending this as a separate fix per review comments.
---
 tools/testing/selftests/resctrl/cat_test.c | 32 +++++++++++++++-------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index d4dffc934bc3..742782438ca3 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -288,11 +288,30 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
 	return ret;
 }
 
+static bool arch_supports_noncont_cat(const struct resctrl_test *test)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	/* AMD always supports non-contiguous CBM. */
+	if (get_vendor() == ARCH_AMD)
+		return true;
+
+	/* Intel support for non-contiguous CBM needs to be discovered. */
+	if (!strcmp(test->resource, "L3"))
+		__cpuid_count(0x10, 1, eax, ebx, ecx, edx);
+	else if (!strcmp(test->resource, "L2"))
+		__cpuid_count(0x10, 2, eax, ebx, ecx, edx);
+	else
+		return false;
+
+	return ((ecx >> 3) & 1);
+}
+
 static int noncont_cat_run_test(const struct resctrl_test *test,
 				const struct user_params *uparams)
 {
 	unsigned long full_cache_mask, cont_mask, noncont_mask;
-	unsigned int eax, ebx, ecx, edx, sparse_masks;
+	unsigned int sparse_masks;
 	int bit_center, ret;
 	char schemata[64];
 
@@ -301,15 +320,8 @@ static int noncont_cat_run_test(const struct resctrl_test *test,
 	if (ret)
 		return ret;
 
-	if (!strcmp(test->resource, "L3"))
-		__cpuid_count(0x10, 1, eax, ebx, ecx, edx);
-	else if (!strcmp(test->resource, "L2"))
-		__cpuid_count(0x10, 2, eax, ebx, ecx, edx);
-	else
-		return -EINVAL;
-
-	if (sparse_masks != ((ecx >> 3) & 1)) {
-		ksft_print_msg("CPUID output doesn't match 'sparse_masks' file content!\n");
+	if (arch_supports_noncont_cat(test) != sparse_masks) {
+		ksft_print_msg("Hardware and kernel differ on non-contiguous CBM support!\n");
 		return 1;
 	}
 
-- 
2.34.1


