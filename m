Return-Path: <linux-kselftest+bounces-11576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB1890263B
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 18:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEA281C220C3
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 16:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3418A14B952;
	Mon, 10 Jun 2024 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oGEgdkqd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3A8148841;
	Mon, 10 Jun 2024 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718035244; cv=fail; b=QzZJVtR6FbPCMmg41GLsNpkZl/7g4j/7123nebjl2nG5uOjAx8q+lrOkBi4uO2us4xrwM46ZP6pFVnVm0vKZA9smeIXuGnHCtbdhOIXJ18hHZyU4tmuZcdN3GcOweJ2j1ub4j5qKPnOx15nIhJXBy2UYn8XKdPwTP32lQk0wGhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718035244; c=relaxed/simple;
	bh=JSCoRXCk0BDtEzYoYNAYIGS6i581no0AfB7/4XV6tMU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jg7C11nOx82WsNluNezObERahOa2BMJeOsyPQ4sCLgWIg46WxTdCPY7Rybw0PThE7pt4nxdeRXaihBMQwfPft8BSvAQfUIbjgVxje6pd5kOg7VYfj6AWpohj6MvJdAg8k5+wV9EWc3MkccER+MY8xG6geLV8Xk5kxTUUCkVaXKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oGEgdkqd; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUbAX8CYa+DthNjDc3KnJI9fcn3aQ6c1RqZwRuy0xiJ/+rf5bSp9WecHkmTeRYIbnw82PfciPUHIhlspic3HE91kk/H7mM9b1y8ah3M//dKF+BxT37xYMWYqoPo9nxdQlaSqnZFXhzp68ZssdPRMwlVcoQPnmrHZeKTAokWEgZtew3tYTulULcZMQ0VWKz9QH65vMjKwrxeK1g1dL6QcEueZSA70wB65sNeOpL5sFPu549NsrFy0CFL40zQ+y6ZJstDoI2Tx+SqtQ0H7ttgfEmz9ln7Lat/A9fgdSZCsS5yoLjopdIP/OBH5W2IuJxuCrh2TnBEwMOByX7kfOpIltw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbal+O04jUTyZ/CT6Z/M7q7oMnm43JswcqnO5Xq/0cg=;
 b=LzUIcpl4h/t+R4fqs4ZpEcQlfx4Y0sjqWvbc+Jhioiwan8ti6YuJ5qyE/xN9y27IW9OI32qX6+BSJXVLbBk32Z8lbAzVbNdacVOuC54dlQlryMIUPsoJ6uip1f8fE4ibROrrsDlHWSnr9bVlKv2JGdpTDLT24AvlxiODvSIlvCeDYDhymF+ngB/FUngkyQJPcEMB/KOYkDUry7++Z0ocXYpC4j8PDznZ+W4G9fzb3o7AMrGnNzUHMEI/ir40YFNOQL4ld/Cb2ucvqbXmkWt9d0pEpugfppjIGLdld0oq2wrG/Mw1gAvP6eqCH6sGP8EcTwC7B0QMfHbA1aOSVmLK9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbal+O04jUTyZ/CT6Z/M7q7oMnm43JswcqnO5Xq/0cg=;
 b=oGEgdkqdUMBtpI7Eb8j/wmtYEk5tBhyJi/2kTaCTY2WlTY7H313dWRWCw8wAAma3kbl8agPz47gisid2Z51IbyiljE85uCoEy6FqD7pq+3I5f/vur/Y62EQz6/MRn6bhJL3FTQy1PIDrookQoa3WW/umr/qFinOsx3hfn87m85c=
Received: from PH8PR22CA0017.namprd22.prod.outlook.com (2603:10b6:510:2d1::13)
 by IA1PR12MB6139.namprd12.prod.outlook.com (2603:10b6:208:3e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 16:00:34 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::ab) by PH8PR22CA0017.outlook.office365.com
 (2603:10b6:510:2d1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Mon, 10 Jun 2024 16:00:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 10 Jun 2024 16:00:34 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Jun
 2024 11:00:28 -0500
From: Babu Moger <babu.moger@amd.com>
To: <fenghua.yu@intel.com>, <reinette.chatre@intel.com>, <shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <babu.moger@amd.com>,
	<maciej.wieczor-retman@intel.com>, <peternewman@google.com>,
	<eranian@google.com>
Subject: [PATCH v2] selftests/resctrl: Fix noncont_cat_run_test for AMD
Date: Mon, 10 Jun 2024 11:00:22 -0500
Message-ID: <7679d70a0ea939db13ae9dac20de56644460d6df.1718035091.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|IA1PR12MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: fbb2086b-7471-4481-5230-08dc8966762d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hueoyezoWxLze2auaQRTuA1FyBtn5MEtVaCIS+byyghb8BCDFL3qpF+wOOle?=
 =?us-ascii?Q?1e0b+f2w1+eNNTJQNM+lL6bLLyM2rR6oIhcRmTyp6xXpNuyjg+Q79iUI1gAm?=
 =?us-ascii?Q?alpWyk3jlrCLUKGQ9P0q3ls4avc8rP9q6MNLYKyMHJS94Xg8sg3czqtHrF50?=
 =?us-ascii?Q?5Fi9Kuchr0InQZ0T48jue6yiMivMDd1mjc3tsD5mdevtR0caYsG4XhWSPEiA?=
 =?us-ascii?Q?aRtJmcfpIwyaUbZ4cB9aF6uQWJoV/S8sfUESk+zBDx6RES9+0jAsLv3j4Mia?=
 =?us-ascii?Q?SJEmDWqyKGsBTnb/IBo+7wPrm3C/8Penn7fUZswXVQfwtDwQqXVt+fzZUHsq?=
 =?us-ascii?Q?jyauTg4/hGfzYHdo+pw+ELcxsMWJJWm1qOXHx1d7ZAPi4F8iXAnOh4gHZPbG?=
 =?us-ascii?Q?AE52YKDot984PQ0pAN2o5D4aO6rZLSo6W9g9895Fglk1idHvB8h4FwbRUyS+?=
 =?us-ascii?Q?CW2QniDUraNTBWZz66nbiU3uX9WAuJErhda7NN7bR4iK9xz2DRD/Wf0ds3B6?=
 =?us-ascii?Q?HhtjcbZdlYmCsq6anmyRhOCC4VgGuWxyFoUT+7VEQOOrnqpeDsTwZdyGnKHd?=
 =?us-ascii?Q?eymP0sBHbmxrvmLVTfW6fhEjXtQ4aCEHGJDSDcXPSk9bTFG/hKsqaKLXuifU?=
 =?us-ascii?Q?tD5PAtq07gw3KdzbN+pGAK+LhYwH4G7z/sI6aogmI0wv4MY0xOc8XCoKc5nH?=
 =?us-ascii?Q?3SDqUWZHiar9raKbw4Mu4H2duFYkDRNlo5z/JB1E/RWbdrQSgga4PWHmG8Kq?=
 =?us-ascii?Q?MPxL1txYo/uyH/Jn0yHGucAIhyuTiUQ1XdQRIsXYDrSbhJnyXymcLun6djDj?=
 =?us-ascii?Q?0KjNfV3RhlvExlS818dmHOnUrs28chcIk9JFrrQdFdDqAmImbYi3xzBkrqsJ?=
 =?us-ascii?Q?djcyvTMdArovVoJRZMXTTIEli9+/KbFAffaM3NphlUvuY5GQPITX80tM5dP9?=
 =?us-ascii?Q?JiQSjPHM1PddL4M4QntuxVZ/knpQYn+w/wpR+8vZ+M+BqoI0iyt7TwZ9i5wd?=
 =?us-ascii?Q?EpUqeBSfBmQQU7XQlQ72lXXgRMp7nRqwbkx2NwasBE3stbH//GJa/zktbZ1j?=
 =?us-ascii?Q?Sag5ud2RdWLZUy9qjkeKMZSuUNLJYO06Xamy8xAjsscTKltSU62C9Zbw5nwe?=
 =?us-ascii?Q?gxGSoakaBdk/WhWtONPYJ+52AyiQlOBSyPanrSvqt4KA+vr9dKlpjMjcPtoA?=
 =?us-ascii?Q?UqkrB/zrJLnCn7C76/wFZoa/J8MGH0edwkTZ4QgHRE43XXUoyP4m2qAP85DG?=
 =?us-ascii?Q?pmqQHuM97h+2DrE/sm2lQ8KjiTtrJnWtO91FrOzFJxge/NX/Yx0mhMtCrqOa?=
 =?us-ascii?Q?VMyhPaQhwwSKx0RHj2OvxMLtxNHpiFA9VmWQRkADq9VhuO7Dan2bU/W3/AFm?=
 =?us-ascii?Q?9mOlDzA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 16:00:34.1181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb2086b-7471-4481-5230-08dc8966762d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6139

The selftest noncont_cat_run_test fails on AMD with the warnings. Reason
is, AMD supports non contiguous CBM masks but does not report it via CPUID.

Update noncont_cat_run_test to check for the vendor when verifying CPUID.

Fixes: ae638551ab64 ("selftests/resctrl: Add non-contiguous CBMs CAT test")
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v2: Moved the non contiguous verification to a new function
    arch_supports_noncont_cat.

v1:
This was part of the series
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


