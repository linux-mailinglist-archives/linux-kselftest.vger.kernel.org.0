Return-Path: <linux-kselftest+bounces-20235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C40089A5A47
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 08:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C223281674
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 06:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6239B194AD9;
	Mon, 21 Oct 2024 06:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yovC6gT9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706FABA27;
	Mon, 21 Oct 2024 06:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729491919; cv=fail; b=H2j8fFN845J27FUc5n1BNIiF7UPBKyBHt0Gj5mp6jCeunU5MUBgCClwiFoVCGpI33q1cR1Is2Og8/RHHiI9xurplix1poklCkw5FhHPE31jCNKtx+AKFdDwEuTQoosXRaV1ztGZgS+0aT+MMgn3o7d+FZWnbORkmPrwTOfPye10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729491919; c=relaxed/simple;
	bh=pJD14E31clExXzdFCqoH6ZaccMHZfB8lDG+3/jKVya8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bdmqW6zah5NP8tvfqbY9ikYLIq7iDfPNqxL7Cr52XgJZsLI2FKbVYoJOrstaGxopgpXg9cmBKAH/1ZbsTC+BkeAOZZzDZojENykMNMO2vlZNQ+m9Ieltl3Jwvi9O3kjpb2GZTkyJ2soXE5xz4Won9xqSlcXMHUuHzZYRpxheVjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yovC6gT9; arc=fail smtp.client-ip=40.107.236.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gjF4PWZTuG8wkiKf+KoJBc95qF3HDKVPRFaSPV4/UDSPAlzHUPXFfQJGt6ar/+dnSCUjrAKuypvw8GFQTNHBCuEbeQR3lOKxdC0j4XzczfybGB6JN8ZXQ6iI+OEEgNBf0UB1F9KHwST7p+UYNFLfnVz+RLZTfQ5ph3LAuI1EtQLgA0iLVZmHXPd1GsQjS9LrEWi+ck6AVP3W2o/NbHcpwt92DAIroer60eynB7vtbKVdAAgAwyjj8P4eYHLA97/jq7gaiTtnfOeWGRUOsok0llDxO7uE3rnPhuDGIW/XUY6Ay0r35ptSKmhn5RJxxom3banVqiKIpvmXOoL1iaDEsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTkYWsARXFEdh/wm/cMGDCJSL8tCgVGV72PtZCshkSw=;
 b=bqAUFm4qvwWUISi8B9x4XQcbP53s9rfdyxml+hwCJGQYdwO7Ke3+yKgp7heLRY3UtjnJhsr8k1CdcR9AZJqJ/DEnl/bqnODZLgDdqDRXb+j6lyIupSXxLxYfHeW9N3SJZ9oFkcg5oExI6KEbkOAjVne2FyN5lvIH0N2fNnNfPI3SqgWPczuQNoAfwMvMkoccgtrTzamU1F5Hz9xTVApsu30UUDvzY+LAU/kh3EAvVAzqUA89LnAArzqPXz/nBWNKnPQT76OE6X9JyyvVGPzYpbAV55qmYQKL5ulsYXGplCCnntBRPcIe6lPfqOuoj+ZuKIZBuIj3GovgeEebZpzwUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTkYWsARXFEdh/wm/cMGDCJSL8tCgVGV72PtZCshkSw=;
 b=yovC6gT9rje9Cf16mbpYAqsL7ZctUH7RpXYXTnjIxxrjYXgjQcKG+grtvtvj2N1obVGL3zVmnC9lNluBOXGErlmfXsG5oRvXELO9zWL+JCcNprdKXIzIVarIirIHw2wIGa5D9VwOZkxbUZqPvyG36eK2PYau+HRqrrAIdvz4qh4=
Received: from DS7PR03CA0034.namprd03.prod.outlook.com (2603:10b6:5:3b5::9) by
 CY5PR12MB6299.namprd12.prod.outlook.com (2603:10b6:930:20::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.28; Mon, 21 Oct 2024 06:25:15 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:3b5:cafe::bf) by DS7PR03CA0034.outlook.office365.com
 (2603:10b6:5:3b5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Mon, 21 Oct 2024 06:25:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 06:25:14 +0000
Received: from chalupa-d178host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 01:23:45 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <manali.shukla@amd.com>
Subject: [PATCH v1 4/4] KVM: selftests: Replace previously used vm_get_stat() to macro
Date: Mon, 21 Oct 2024 06:22:26 +0000
Message-ID: <20241021062226.108657-5-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021062226.108657-1-manali.shukla@amd.com>
References: <20241021062226.108657-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|CY5PR12MB6299:EE_
X-MS-Office365-Filtering-Correlation-Id: ccfef50d-0d06-47da-39ca-08dcf1991ffa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C5e+8teejLswvITN03e+MOar2EgUo+UcLa7fguS+zNSclYjorGp3xlZ9xrfS?=
 =?us-ascii?Q?9Anhqnl8CPElzNZmUEjZtRFhslWl1aHNoXk1RyRuCQ88o2iAQtc6tiq2guZB?=
 =?us-ascii?Q?t7H1xOjmoFX2xEMiCM1mpo+jn5Pbgp/GfQ+u9ZJsHY6A4EE6AKCQwrxyrubu?=
 =?us-ascii?Q?md226BjgGyUza95PIHxmRTMIV0U8bTu4vXUt6mkipM7VgeSLRRspNvMABUd1?=
 =?us-ascii?Q?qz3mXfYthp92h5ygo/V0g6GC/t46MvzHZwXFxXj5fnNcn4LE6LhcQ9RKzCAS?=
 =?us-ascii?Q?FcVZJcbTcAYABP9zFrsIdrmp6Ertp44aZ2TPIordu63ol0oA9fId0rfRvnf9?=
 =?us-ascii?Q?fksKdd3PoLxNQlRccmCilmvAJyn3SzF3MYLMrcFpydI3lHNqp8au5T9/4yi2?=
 =?us-ascii?Q?DfbTyTUdFAiPirhWG4AwXNODQcCFFR3EYj2rPXTtU6YY2ye1UN7cAZmcLIUC?=
 =?us-ascii?Q?j4JxV3mKYcxknDXPzar3gAXmPz+6eZA2CzTSvCqSdco2zfx8snL7dA/rr2TT?=
 =?us-ascii?Q?0BLxsFuU7CsyQhOJJLTikFCuGJOtE5CVOUI2T9/lkjDNBCFLy2ARlgDMktmD?=
 =?us-ascii?Q?+GL2FNw0BGVF00WK+F9LHs3TBLBtxu2EEPTcrEYgIwApssFI7tBx0j3qoLLp?=
 =?us-ascii?Q?HF0zztxgipZ8AxOEuJmcw6IFiA717zf5yjCvIXp1iRaRIf/UAS1URkdJsGN7?=
 =?us-ascii?Q?RcuUor3V1cIbVcEnPnvEJSlwde0usxRNZ5pAlWxGSnVGqsKIYHn2//e9o4t1?=
 =?us-ascii?Q?XziiSE+mjhb3LbloC3+F3u/36yB8mtQs4ExRQwSy2cG0g1900G90MvqQrqD1?=
 =?us-ascii?Q?Es1PzTgnhygZqs/R1rUYG4ed6/vu9jGnR2eFN6z3YNaFL6FpYa4R6RlPvLqF?=
 =?us-ascii?Q?fNgSz4doEF5H5PrW2EMRVSDsUUTOpMXP29GxX9P8mHWxxM3tPJ+kvBC++iTt?=
 =?us-ascii?Q?4K9nX0U6iSuoCXr5oqABpf93Mn9E+qlf2pDt/6zvrPbga529OgkxsiCuAJW+?=
 =?us-ascii?Q?w/lRgsM/dGIfpMknk/5zfEojTwtNIg85C1KM1WKX8ieCM+ODFT/E5jazgCqT?=
 =?us-ascii?Q?sOUC6V7si1Yc4AicaFsS9Cya6W87kvwWXUQw5GkNTiPwNvIlRPl/jbn12LaP?=
 =?us-ascii?Q?wuiXAdSWo5MvigItUkVP6ZzbUgTL2oGx3xH0BOdZPvCEDLZGJ4T1egS8OnYk?=
 =?us-ascii?Q?4K11M/uUohc92eRNUUUaUf1SuUm70K0zH5/OiNLB1UrJbLS1EFzjANPYB1+s?=
 =?us-ascii?Q?etdlXBq1W0pxm1sClfG1rCOq/fQQ9/IJDft3f5+oHif8/ezm0YZavO9nDdtl?=
 =?us-ascii?Q?X79cgUdlsirKQCBkYDHgiua3Wd3vxUBPWZSC2WU0DvjQY472suqKPVWGLA9b?=
 =?us-ascii?Q?NRpo7VvvZuZNUcavvbU2+xNvChpWUoewiKQMKuMnGybnWI0qgg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 06:25:14.7456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccfef50d-0d06-47da-39ca-08dcf1991ffa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6299

Previous patch converts vm_get_stat() to macro and adds a concatenation
trickery to generate compilation error if the stat doesn't exist.

Improve nx_huge_pages_test.c and dirty_log_page_splitting_test.c based
on the macro.

Compile tested both the selftests.

Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 .../selftests/kvm/x86_64/dirty_log_page_splitting_test.c    | 6 +++---
 tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c     | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/dirty_log_page_splitting_test.c b/tools/testing/selftests/kvm/x86_64/dirty_log_page_splitting_test.c
index 2929c067c207..b0d2b04a7ff2 100644
--- a/tools/testing/selftests/kvm/x86_64/dirty_log_page_splitting_test.c
+++ b/tools/testing/selftests/kvm/x86_64/dirty_log_page_splitting_test.c
@@ -41,9 +41,9 @@ struct kvm_page_stats {
 
 static void get_page_stats(struct kvm_vm *vm, struct kvm_page_stats *stats, const char *stage)
 {
-	stats->pages_4k = vm_get_stat(vm, "pages_4k");
-	stats->pages_2m = vm_get_stat(vm, "pages_2m");
-	stats->pages_1g = vm_get_stat(vm, "pages_1g");
+	stats->pages_4k = vm_get_stat(vm, pages_4k);
+	stats->pages_2m = vm_get_stat(vm, pages_2m);
+	stats->pages_1g = vm_get_stat(vm, pages_1g);
 	stats->hugepages = stats->pages_2m + stats->pages_1g;
 
 	pr_debug("\nPage stats after %s: 4K: %ld 2M: %ld 1G: %ld huge: %ld\n",
diff --git a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
index e7efb2b35f8b..c0d84827f736 100644
--- a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
+++ b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
@@ -73,7 +73,7 @@ static void check_2m_page_count(struct kvm_vm *vm, int expected_pages_2m)
 {
 	int actual_pages_2m;
 
-	actual_pages_2m = vm_get_stat(vm, "pages_2m");
+	actual_pages_2m = vm_get_stat(vm, pages_2m);
 
 	TEST_ASSERT(actual_pages_2m == expected_pages_2m,
 		    "Unexpected 2m page count. Expected %d, got %d",
@@ -84,7 +84,7 @@ static void check_split_count(struct kvm_vm *vm, int expected_splits)
 {
 	int actual_splits;
 
-	actual_splits = vm_get_stat(vm, "nx_lpage_splits");
+	actual_splits = vm_get_stat(vm, nx_lpage_splits);
 
 	TEST_ASSERT(actual_splits == expected_splits,
 		    "Unexpected NX huge page split count. Expected %d, got %d",
-- 
2.34.1


