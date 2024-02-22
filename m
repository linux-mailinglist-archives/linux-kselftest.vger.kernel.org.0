Return-Path: <linux-kselftest+bounces-5318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1E08604E9
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 22:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8553D1F24248
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 21:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12CD13BAC0;
	Thu, 22 Feb 2024 21:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yVQNj7xe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3E612D208;
	Thu, 22 Feb 2024 21:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708637787; cv=fail; b=o6Dwkejg6p3bNq3cf5nM78E9OO2o8VjKjaTJJKhejPZLEcgflVMIQr2Cw94sM/u2k908WyCn8LP6Y+7SLgHTKyYE2aJZ7f+sd8ZUdnX+JAIGeWgADJpQiWGCmum+13MRKEb2mchjI/ZW9FgzOpiLLiMEySPA+H/ncy3KzHT/KAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708637787; c=relaxed/simple;
	bh=NYPuXq0zy982kv5gXa5Go0nibOf5rQKQa5xeUr57kE0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NhNSiiphKkn5q0y2N7BJJ6/zbVTH6ikODFqxDS97ugH66SRuGFV+Q6SoF9GBzcjDcE9vzRKhQ8TnB1NrqCC9ykkggVxHwlc+lT99wS40W/8/1E+fa5vjNjuZVHC4uDfRIb+8nWfw6zfnuDJzPAHqJzJUTcdJAvOHiBYGCobHU1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yVQNj7xe; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzbDvaZqrobSXDh8EBb24KQfJZXKuDZANISCoTLsdKSOgRtoc5arGQBNTep/0eRnPCU1JXAIPbRMZIfMt+ml7AGahLxk87w/EHAjQGjQtAYa4fLcNg+pkRA5+44jleZPH7gdx+K7q5zBaBoYasqJrDewfkLdsNKE73bh6/R139jIGOQ0+lAk+hW/x3FRYeDyog3IaCo/tjwWDk7rfQ8M+T0doitFnNcu2e3K/BISr5Ddng7JTKT9Gz+O0PvBfrl0ocED52O9QBmFNhQombX5R2Vmopkdn+jHuoin5uyQ5SSlPMl4g4sB1iJKhGT0sOtSnbwnZ50uByrd0cRANPMA9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wa+bfg0NmdxJH6C7Mcw8HPO3Mo28uhUUfKVVJLzxN0g=;
 b=ogTnahOl0Lq8VTwWvqx6wJ1yErJ7QCSsCsgJu8hGbzJ9tWbHe7xMDIaHJlDmQsqEtEQ4l2JJ3Ze8FpaDIEg+iz77gP0agvR1V5r6jsBbaGWEF/Y62vEjZUqJeNt5+qJRqb5fOF66hieHeRoqEbeFN2HvkLrc7nA7edugUF1LHTB0llr4Id/c7WGF7Tqli/7YcVhdM4BtvKMgsKBRwdWVdPYvsl9oB/5l5xF13E6fIZfuyyWl9CivBDl4eUY75kQmG9Zr3GXH0+h1JBVtopl+IO9lnQd9+P4KmGtoLTd55aiAcykAIJ+B21xgx1ArsQvmJA3CqoDSshamowqw8yIkiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wa+bfg0NmdxJH6C7Mcw8HPO3Mo28uhUUfKVVJLzxN0g=;
 b=yVQNj7xeMmyLthRqx1nG/Iv77bzP5ctb8aVaGz3Tx0p0z94GYKTKqQ3M3S8NxqnaT7RlFCsveiKf+0zJmYoWjgcrI3KqEdfZxd8TGMv6PsDIkBcMrcpUBHzocgAJAaZDi9UKK4jHwHM0ZVH9uHxwepg2ofV2U3Vesmwki47m8Vc=
Received: from DM6PR13CA0034.namprd13.prod.outlook.com (2603:10b6:5:bc::47) by
 PH8PR12MB7157.namprd12.prod.outlook.com (2603:10b6:510:22b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.27; Thu, 22 Feb 2024 21:36:23 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:bc:cafe::72) by DM6PR13CA0034.outlook.office365.com
 (2603:10b6:5:bc::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24 via Frontend
 Transport; Thu, 22 Feb 2024 21:36:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 22 Feb 2024 21:36:23 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 22 Feb
 2024 15:36:22 -0600
From: Babu Moger <babu.moger@amd.com>
To: <fenghua.yu@intel.com>, <reinette.chatre@intel.com>, <shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <babu.moger@amd.com>,
	<maciej.wieczor-retman@intel.com>, <peternewman@google.com>,
	<eranian@google.com>
Subject: [PATCH 4/4] selftests/resctrl: Skip the tests if iMC/UMC counters are unavailable
Date: Thu, 22 Feb 2024 15:35:48 -0600
Message-ID: <f5c74072d96b57b10a66c01381139de453187327.1708637563.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1708637563.git.babu.moger@amd.com>
References: <cover.1708637563.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|PH8PR12MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 690dfc4f-316a-4b41-e782-08dc33ee50f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZGKZTiJrKNB0p7r7NiUqVFGFM6X1NWPn8yuWXA9er3gjSdkyhFe0OUO8GNVVcV9P/6H/4zHP3yMyY7Ax9L3yfKQpEagPGxxXAnFPH4Kew32SxHEPXrifq847hSBYQGn4ckDFUbEgbXs3XvciYkxdRK2iADUSIfkEycAhQ/KYhweDtMGqY9iGISWwSXZTKDuLSelkCZCAKyQzOaTSQyLBV3l8MCrm+R6v1IBv1+dtHb9duh8SP30zLFx4OwCncJ/3ljWSGqZdEbIUTBPsjW1GJ7AnOg3lhWKNOakqdLrglRy/PdCR+9JfsIJdERZ+bXUb1dAXKG2CeLCQ7KxHRhsRlcw8iqJpkQBTj7fqU5LB/Y9VsKPkPZLKkuP/UafZdFShnvkxHtg+XKbC9tF7xXLOk3JntYozPJDPLksD6GBLltpe1L1rk9bzlSj1j0qnFKXzSovgkLEOIXRqGyqyOatumVjAknHfd1LRD+mG9KkSHScH4Xbm1vSnr+2G3tKXDShIbn0SUzykvkEM+bT+fVZLqVPf/3ptGcQQ1/rwtLas2WLKw8aBgXTjVX5G1fT9dHd6b+BIzibfU3R05SunV5OIJ2aCClxw2r7Tr95ip6inAGviEv+4Z/qW4El/Z0vPYBSlzGi47jKtrE4jdXwC1HFcQEwmtAEgBtkaEd4FQZ+0NrM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 21:36:23.1716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 690dfc4f-316a-4b41-e782-08dc33ee50f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7157

Older systems do not support UMC (Unified Memory Controller) perf counters.
Skip the tests if the system does not support UMC counters.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 tools/testing/selftests/resctrl/resctrl.h       |  1 +
 tools/testing/selftests/resctrl/resctrl_tests.c | 10 ++++++++++
 tools/testing/selftests/resctrl/resctrl_val.c   |  4 ++--
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index a33f414f6019..5c2556af0649 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -116,5 +116,6 @@ int show_cache_info(unsigned long sum_llc_val, int no_of_bits,
 		    size_t cache_span, unsigned long max_diff,
 		    unsigned long max_diff_percent, unsigned long num_of_runs,
 		    bool platform, bool cmt);
+int get_number_of_mem_ctrls(void);
 
 #endif /* RESCTRL_H */
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 231233b8d354..5423882529ec 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -98,6 +98,11 @@ static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
 
 	ksft_print_msg("Starting MBM BW change ...\n");
 
+	if (get_number_of_mem_ctrls() < 0) {
+		ksft_test_result_skip("Unable find iMC/UMC counters!\n");
+		return;
+	}
+
 	if (test_prepare()) {
 		ksft_exit_fail_msg("Abnormal failure when preparing for the test\n");
 		return;
@@ -124,6 +129,11 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
 
 	ksft_print_msg("Starting MBA Schemata change ...\n");
 
+	if (get_number_of_mem_ctrls() < 0) {
+		ksft_test_result_skip("Unable find iMC/UMC counters!\n");
+		return;
+	}
+
 	if (test_prepare()) {
 		ksft_exit_fail_msg("Abnormal failure when preparing for the test\n");
 		return;
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index c5a4607aa9d9..68cee87c26ef 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -262,7 +262,7 @@ static int read_from_imc_dir(char *imc_dir, int count)
  *
  * Return: >= 0 on success. < 0 on failure.
  */
-static int get_number_of_mem_ctrls(void)
+int get_number_of_mem_ctrls(void)
 {
 	char imc_dir[512], *temp;
 	unsigned int count = 0;
@@ -323,7 +323,7 @@ static int get_number_of_mem_ctrls(void)
 		}
 		closedir(dp);
 		if (count == 0) {
-			perror("Unable find iMC counters!\n");
+			perror("Unable find iMC/UMC counters!\n");
 
 			return -1;
 		}
-- 
2.34.1


