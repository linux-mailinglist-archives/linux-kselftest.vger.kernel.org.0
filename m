Return-Path: <linux-kselftest+bounces-5317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F568604E7
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 22:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97AC628628A
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 21:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DAF12D1F7;
	Thu, 22 Feb 2024 21:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Sq9dESBs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F1E13792B;
	Thu, 22 Feb 2024 21:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708637780; cv=fail; b=d7lEwLCxG2KNAu6enNRKoyZ01agZvVWzR192v6WYy3GrE5+rP9pYb2UYB5m2NOJY+kz86M4iHKuF7a2l3VocVQ7cyK9AWlNTp8xNayBCu+dSA/IIG3EosPlUwgTsy6sCwUMkD/FyYnKDSIIyRAje5BA0hm6NdhyPL8RQWkE6r64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708637780; c=relaxed/simple;
	bh=XaP5u+BFFWYNcOyH73ZHdsL/DZ3iJkMNMTJJECjrXBo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GBHESUnwc98toeNnVl5Em7FO7Nqc/780t4vbb2uzDlMyQ9tg8332kq0gmj1HWSW+9q7+SHP8FUD1RspiityGT+DkT+Woain6OOfbMeFJ58ermkCulZ0dhQkjkbtsXVSh7kXmY9O8E8hPbg0rQVGmU5BNBkFgsarFGO4lpax4iEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Sq9dESBs; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOi4xsJbiiByKTOi56SimQxtUCYfGGPNZ+Mv9ELzak2YhMWcwM2042/XcYWonqIHSQuTDGaS8eA0EmE27tToyrCRb9kYHO6WNH0BDDya3aaAhceBrl3RGHgz1C8zg/1SDYkwbCnfi1MCYgltRlqYwtUfPlop0XH50xzmk2Fci2wkEXVrrfDMSUYHvezDHDbA1GaooLL/EEvL1uDBId03wMRa4RWCGRTdznl5fgijA7LpBZEVFpRi5+sSqUlhT+ZDaKRB+jrOBF0VNKMFuUomwV4AJ9+LKy1qCzDfMA9jdoA7shoF6AoZXZrxwHvvhtpOIbUApyIRh63cOsiM9Z07gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6X4zumhHg5MSgiirIr2vbS7jyrCcXhRrPsiSo3iH6I=;
 b=eF7nxnRU+tqO7Ko/LQFrARJKWkCoXdyt/A1TNmyIv4+vX7T8kbHOXDTL+bAZ9YetpTbQRoofbmrZM9gu1iyjRdwKJbUjkeC167u+sTY9utid1M+nmHiaYAIkq3Cgs8ioRqvydjsnU6VxPNQmYTsPJ7o9Wt5dxbW/R05Kd1kR6udn7tsxU053f87MrvSv43ktfiHRQ4OKYSlNquy9T3DEsuOr+dG7IXGx0wha7SlnBQgcVwoWCkLyXMVDtwrYMdRhATKnNkHOMeseOrmrE3Zo0OxnEYKtu5tJqC/20tLw7Vyhz/mXLUV4HdA31/WdfKiGzPcPcnhXBSg9oTiCOh4CJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6X4zumhHg5MSgiirIr2vbS7jyrCcXhRrPsiSo3iH6I=;
 b=Sq9dESBsBlVVQE+PLFy5cy6pkKZ4ZTGqspWHAb1e2ZNnnTTBgj0wLVgGm1iOGRDnLdn/gwlKlCYbgAASzvnSifzGaBxoXZCkVm3e75kGKf6Rpmh1o91zrLrUQj3OZdWnstmgs1+mwuv1XEWyO/RJ+X6ndENjrEmnytpJ3u5W0R4=
Received: from DM6PR05CA0057.namprd05.prod.outlook.com (2603:10b6:5:335::26)
 by SA1PR12MB7367.namprd12.prod.outlook.com (2603:10b6:806:2b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.15; Thu, 22 Feb
 2024 21:36:16 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:335:cafe::22) by DM6PR05CA0057.outlook.office365.com
 (2603:10b6:5:335::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31 via Frontend
 Transport; Thu, 22 Feb 2024 21:36:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 22 Feb 2024 21:36:16 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 22 Feb
 2024 15:36:15 -0600
From: Babu Moger <babu.moger@amd.com>
To: <fenghua.yu@intel.com>, <reinette.chatre@intel.com>, <shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <babu.moger@amd.com>,
	<maciej.wieczor-retman@intel.com>, <peternewman@google.com>,
	<eranian@google.com>
Subject: [PATCH 3/4] selftests/resctrl: Add support for MBM and MBA tests on AMD
Date: Thu, 22 Feb 2024 15:35:47 -0600
Message-ID: <cc22790173de9978a6485baca5bc96a8ad8e05a4.1708637563.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|SA1PR12MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: eb9396d8-2fca-43c6-33fe-08dc33ee4cbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TCPZoPlzk4yaAtSvuyutuXK2UzzWidky/DlJEOav5XjNWSdogZ1r/eCpVmqil2G5UdPbrtjq5cqWGkHcv1qy7FBHZKRAlpbleiJUvKhtnwSwFn2z77sU1/6UULSKVahlH4vecb9ID3Tebx9OatqojnryrflZictT33KTGwg3ePxDSaYFSU10t5tE3nhkzfyscicaBDj/VyrXw8lkm9aHRinTXNiiRyCLWU5mB8tZYQ9NUsgUbVGilTm7XPC5nO7LLVujjnSdVwt8FaeIQ4SY6jcD08yg8FaenK/f6wucpBATJP4Hg3QNqVeFsIpvH7NSruyROQq06MubbeupPcvOjXKATzgbnY7e23oS8TE0mTemDrj/sRQEQbtMuaNqFqBvv1+6Qs0mv3HK59qmAo40y2gJ8l/tcsPPeCH9Wr5od56SkPAYDwLZ7hopKLv2rDMPqmS6N/GSlMsHe7f6aFIzuGtrVFFlH82uSBO32+08tEhtjod3Riyn/EC4kFDvchWmYN1foUqpVbFUWMw3SKlzS/trFkP/u0qimWAoL4EX2DSe6ZEmYOvJvvbwwB4YXXohXOUs6EqOla3q3L6+cBy+eB0RzpDtMAAdAKNT5wDlZ89cApjjYm5sarXQL/Svuf+Z5oYWC6bYEKQnELbz9vOUaz72MUCTU55VOekGhZu3bX4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 21:36:16.1596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9396d8-2fca-43c6-33fe-08dc33ee4cbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7367

Add support to read UMC (Unified Memory Controller) perf events to compare
the numbers with QoS monitor for AMD.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 .../testing/selftests/resctrl/resctrl_tests.c |  6 +-
 tools/testing/selftests/resctrl/resctrl_val.c | 62 +++++++++++++++++--
 2 files changed, 58 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 2bbe3045a018..231233b8d354 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -104,8 +104,7 @@ static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
 	}
 
 	if (!validate_resctrl_feature_request("L3_MON", "mbm_total_bytes") ||
-	    !validate_resctrl_feature_request("L3_MON", "mbm_local_bytes") ||
-	    (get_vendor() != ARCH_INTEL)) {
+	    !validate_resctrl_feature_request("L3_MON", "mbm_local_bytes")) {
 		ksft_test_result_skip("Hardware does not support MBM or MBM is disabled\n");
 		goto cleanup;
 	}
@@ -131,8 +130,7 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
 	}
 
 	if (!validate_resctrl_feature_request("MB", NULL) ||
-	    !validate_resctrl_feature_request("L3_MON", "mbm_local_bytes") ||
-	    (get_vendor() != ARCH_INTEL)) {
+	    !validate_resctrl_feature_request("L3_MON", "mbm_local_bytes")) {
 		ksft_test_result_skip("Hardware does not support MBA or MBA is disabled\n");
 		goto cleanup;
 	}
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 792116d3565f..c5a4607aa9d9 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -11,6 +11,7 @@
 #include "resctrl.h"
 
 #define UNCORE_IMC		"uncore_imc"
+#define AMD_UMC			"amd_umc"
 #define READ_FILE_NAME		"events/cas_count_read"
 #define WRITE_FILE_NAME		"events/cas_count_write"
 #define DYN_PMU_PATH		"/sys/bus/event_source/devices"
@@ -146,6 +147,47 @@ static int open_perf_event(int i, int cpu_no, int j)
 	return 0;
 }
 
+/* Get type and config (read and write) of an UMC counter */
+static int read_from_umc_dir(char *umc_dir, int count)
+{
+	char umc_counter_type[1024];
+	FILE *fp;
+
+	/* Get type of iMC counter */
+	sprintf(umc_counter_type, "%s%s", umc_dir, "type");
+	fp = fopen(umc_counter_type, "r");
+	if (!fp) {
+		perror("Failed to open imc counter type file");
+
+		return -1;
+	}
+	if (fscanf(fp, "%u", &imc_counters_config[count][READ].type) <= 0) {
+		perror("Could not get imc type");
+		fclose(fp);
+		return -1;
+	}
+
+	fclose(fp);
+
+	imc_counters_config[count][WRITE].type =
+		imc_counters_config[count][READ].type;
+
+	/*
+	 * Setup the event and umasks for UMC events
+	 * Number of CAS commands sent for reads:
+	 * EventCode = 0x0a, umask = 0x1
+	 * Number of CAS commands sent for writes:
+	 * EventCode = 0x0a, umask = 0x2
+	 */
+	imc_counters_config[count][READ].event = 0xa;
+	imc_counters_config[count][READ].umask = 0x1;
+
+	imc_counters_config[count][WRITE].event = 0xa;
+	imc_counters_config[count][WRITE].umask = 0x2;
+
+	return 0;
+}
+
 /* Get type and config (read and write) of an iMC counter */
 static int read_from_imc_dir(char *imc_dir, int count)
 {
@@ -233,6 +275,9 @@ static int get_number_of_mem_ctrls(void)
 	if (vendor == ARCH_INTEL) {
 		sysfs_name = UNCORE_IMC;
 		size = sizeof(UNCORE_IMC);
+	} else if (vendor == ARCH_AMD) {
+		sysfs_name = AMD_UMC;
+		size = sizeof(AMD_UMC);
 	} else {
 		perror("Unsupported Vendor!\n");
 		return -1;
@@ -246,11 +291,12 @@ static int get_number_of_mem_ctrls(void)
 				continue;
 
 			/*
-			 * imc counters are named as "uncore_imc_<n>", hence
-			 * increment the pointer to point to <n>. Note that
-			 * sizeof(UNCORE_IMC) would count for null character as
-			 * well and hence the last underscore character in
-			 * uncore_imc'_' need not be counted.
+			 * Intel imc counters are named as "uncore_imc_<n>",
+			 * hence increment the pointer to point to <n>.
+			 * Note that sizeof(UNCORE_IMC) would count for null
+			 * character as well and hence the last underscore
+			 * character in uncore_imc'_' need not be counted.
+			 * For AMD, it will be amd_umc_<n>.
 			 */
 			temp = temp + size;
 
@@ -262,7 +308,11 @@ static int get_number_of_mem_ctrls(void)
 			if (temp[0] >= '0' && temp[0] <= '9') {
 				sprintf(imc_dir, "%s/%s/", DYN_PMU_PATH,
 					ep->d_name);
-				ret = read_from_imc_dir(imc_dir, count);
+				if (vendor == ARCH_INTEL)
+					ret = read_from_imc_dir(imc_dir, count);
+				else
+					ret = read_from_umc_dir(imc_dir, count);
+
 				if (ret) {
 					closedir(dp);
 
-- 
2.34.1


