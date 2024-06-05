Return-Path: <linux-kselftest+bounces-11263-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C52598FD92B
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 23:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38B691F22A0D
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 21:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC73155356;
	Wed,  5 Jun 2024 21:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DFnI2L4E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D004962E;
	Wed,  5 Jun 2024 21:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717623400; cv=fail; b=OrclTIssVKOIo/tlfcPt5WDPlJeWg1A5PbEfNhlsdoeU+vKQfJ3JqsFfLruU+0SyW7AbWpZs11Om65s3lcEowTm62Vix0U7nKYB6pFLV/8C54WnFNEd6VIbByUIHCS6eZmHM3FuiODNQxs9U8oySh26kp2kG0UUfZmFl7/r5IhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717623400; c=relaxed/simple;
	bh=QuYqy1L/vMS3DbhHySwXxRwLOKJ/PkBts0+TjOkozcs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Op97MBKWOMNclCURiczyz4iS+zjjaBfZaEBojVm29ngTRD9ai8hKC8Stt9owt5e1kSGei6R0Mbs1BHiUWbPH3b+qlNBmuprv6qAPNs6MFXS9iE+SqO8BOA/KLyg1W8ARGwU8CelSc3VFNvC7F29lmbm5TQZgtovPTGRruYQrdZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DFnI2L4E; arc=fail smtp.client-ip=40.107.96.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfDtK/tMP3LtAcuOSH6554PoxIKrT0MNYVS9suEhvdXf82D2UaM29sqlKLVenJHrsvPSucUmzSjCFI+o1cggy0iwsh8LX2hkY+dNePPsdidiN3+/+C1m9NyVho6hnRC4ZBqsvOlPmHkbCe0jinreMxZTEQzJwb9sRHSE96LTdyfYGkcbXN2LnJ6VeAEHaBv570p4pEV3M6XTTIzpj3kivBDopGSbofL9/cbOE9MJrCaCrbYaWRzrmVg+JDYviDgEawoUVYCk819E67R6P1pogCYDjCB1ysdFv8V2CJ+iYwGrtoaSyGfS7XhNUtn9w+VqhDP1u2PKA5WyCu8QiwrRgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14MO7t4HqYubLX+K9vdL/Eq7agmo/GNjVa0A0dYzzrE=;
 b=jeB0zgs+7SCsvvjEBtzAdRgTLb4aYfqpSMWNSgYAhDfYw4jkG5GDMq15x6UDgLCWXOe+SuW6VPU1hQhMk+l8gtvF8YLiL24st/bYC/gtRvbOsO3JZkLKFPLBssZ6DsxjOA9ymG55iJ4A++GQE3aX41k1P8ULUtQBw5mcv5h5Cud6MSQ6mhAW1HDpubY2JR3wn9HRNAbf+287UWX4re4n0mLey6LQpIykH5go2RS4HSL6C4ubgZEQ8CdZp9Meka0Zb2SJunUYDQUXG+OL8+4JMjZnjXDEJ2dXCDgC0ukIHM2oRwLvqxUkTlf8oYXQMVrvafNSoDebblvtWmlS7eXojg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14MO7t4HqYubLX+K9vdL/Eq7agmo/GNjVa0A0dYzzrE=;
 b=DFnI2L4EmdKRrmg7uHv3KsLBDC+LGqD/XQJJVWTxZSrTVzcCPBfghjZugrvoyO0cQv5a0dNmTg9px+ubkL595VLu5ZveZ7q9AY8586cZiSgVfLphYE6OWhBsyoPrPtQo19N5RbfBVsXaxcRjZ2tgRgMM7cZfHmPKD2zoTqKJiZo=
Received: from MN2PR05CA0028.namprd05.prod.outlook.com (2603:10b6:208:c0::41)
 by IA0PR12MB7750.namprd12.prod.outlook.com (2603:10b6:208:431::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 21:36:36 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::50) by MN2PR05CA0028.outlook.office365.com
 (2603:10b6:208:c0::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.16 via Frontend
 Transport; Wed, 5 Jun 2024 21:36:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 21:36:36 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 16:36:35 -0500
From: Babu Moger <babu.moger@amd.com>
To: <fenghua.yu@intel.com>, <reinette.chatre@intel.com>, <shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <babu.moger@amd.com>,
	<maciej.wieczor-retman@intel.com>, <peternewman@google.com>,
	<eranian@google.com>
Subject: [PATCH] selftests/resctrl: Fix noncont_cat_run_test for AMD
Date: Wed, 5 Jun 2024 16:36:29 -0500
Message-ID: <3a6c9dd9dc6bda6e2582db049bfe853cd836139f.1717622080.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|IA0PR12MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 45a5f92d-b89a-4583-a748-08dc85a793ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HbM0fTrK3Z2EDmMdOg9r2F+yq/MPPrm0ugiyc2VR10ZfLNXH3Z9MvPS4BvFv?=
 =?us-ascii?Q?Trgrr+LyG4yK5+eWAc2eqlHSI6NzjW8dY5q/5xuUhCi8ThIGfS1/j/4HSzSi?=
 =?us-ascii?Q?g9gJs40l9htte50yRfRDt2BA9z0xoHiPH6MQa9QJEviBaXrlAz24loxTdQC1?=
 =?us-ascii?Q?B5GkT5fNek7qVR05gDSNpN/ECcf+ygvI8fGxTCnlf7bzBhKRnAxESXiTaMl9?=
 =?us-ascii?Q?jakdx687KoWXdeJp6Y38rZqG9JTN7ycgBhwuFR8c4+2T6AhEN2ZO1sxYU0Oe?=
 =?us-ascii?Q?hUFCUD/wkOwxe60R5R7xgHtBQtl9qPrb5mPoiy+vd5dK9NoYPfhQTWRncmFq?=
 =?us-ascii?Q?oChwiWFxRmXSnBibzeObA98Q+Tnl6/2F39eYeYzBnVWecG+jvrXyzDows+1p?=
 =?us-ascii?Q?nF7azyFXSALvQ2bmLPActIz6JScajbZm2Gay3XIAeEkjMQLPhNONQw1b10DG?=
 =?us-ascii?Q?dVpR/pK0sGUeNjzKIuogcHyQjrodPI0EqI01KUMs78Xu0WT92MBtGXv/IA5h?=
 =?us-ascii?Q?UOTsoKahCXCNyJWJx5rTjvIEf4ONLqq/m6nGByS26cNSzd3mnjn4hfvS+3KA?=
 =?us-ascii?Q?J2nvi4mjeXKDRutCzW3+GnBXy5bsL5DpEZyWQKCq6kWJVOm4P4U+IXjICfBR?=
 =?us-ascii?Q?FV3LP+k8U+dWTOydWu5HN0Ueb9vZei46JRw4lVqhoDqNJZLVWxg2/SQWQN0v?=
 =?us-ascii?Q?lYUluq3Ui6G9hNwZY5prYm7n57a5UHNM4QjbgkZdCKbTSuGKu37t8tKVivYw?=
 =?us-ascii?Q?fjmxDeZsh0Dt053I29yuUSkUBfl2LuieWCgvgPz8/H5fOIhzEZtLdAoeP5uz?=
 =?us-ascii?Q?r2Vw33kU55SxpAtlTr4seet4Q0ezISmB1bijPCypRw7di9RTcYxZxlXgtMSn?=
 =?us-ascii?Q?fLRHVG9KJbwXFgret8kNZNrVn80wgzD/EJXk7kHu2NeS++FRtMGzYPQYwCj6?=
 =?us-ascii?Q?vJQAX5/8gA2Z2r0EhaJPN/a9J5O9MzvUeQQ16d/YNcpPSNPteZb9Vu0FonPk?=
 =?us-ascii?Q?dDCw+lJ0GjwiCpGOH7hozAWqyP3YKSoy0ZyCpP3lojXH1aVEAII3W65Zc9iA?=
 =?us-ascii?Q?DlFkP2BIbNX9IrFh6UtbTrIrbV781bXJeoYbdvMyJAZs0+AL1JmbbY4lM8qW?=
 =?us-ascii?Q?eWDEfKcITSSe8zEyq5LB4/2FyOSsAsW02h0t9ytZ02J3AZwXmf3Ccs9TRxUg?=
 =?us-ascii?Q?/hc9j9dQLzwMkZ8mUczCTCbodNqfpcCGGq49O/l0PIde3k5NeSA9FcpTImb3?=
 =?us-ascii?Q?C1ghYsF8E8zKFCYCUdxqyjk/ViRsM4j+mg8KyUbdfSBpgiODroUNSgMDaJ1+?=
 =?us-ascii?Q?p9tk+yH7HyNY5ecdojPA1zYE76JZuOqjNTq91aX0NFpOc0/q/JcnHahiUf/g?=
 =?us-ascii?Q?CAssp1K78RAw4XDIrcX815aItiDW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 21:36:36.2716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a5f92d-b89a-4583-a748-08dc85a793ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7750

The selftest noncont_cat_run_test fails on AMD with the warnings. Reason
is, AMD supports non contiguous CBM masks but does not report it via CPUID.

Update noncont_cat_run_test to check for the vendor when verifying CPUID.

Fixes: ae638551ab64 ("selftests/resctrl: Add non-contiguous CBMs CAT test")
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
This was part of the series
https://lore.kernel.org/lkml/cover.1708637563.git.babu.moger@amd.com/
Sending this as a separate fix per review comments.
---
 tools/testing/selftests/resctrl/cat_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index d4dffc934bc3..b2988888786e 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -308,7 +308,7 @@ static int noncont_cat_run_test(const struct resctrl_test *test,
 	else
 		return -EINVAL;
 
-	if (sparse_masks != ((ecx >> 3) & 1)) {
+	if ((get_vendor() == ARCH_INTEL) && sparse_masks != ((ecx >> 3) & 1)) {
 		ksft_print_msg("CPUID output doesn't match 'sparse_masks' file content!\n");
 		return 1;
 	}
-- 
2.34.1


