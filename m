Return-Path: <linux-kselftest+bounces-5315-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BB98604E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 22:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479DF2869FF
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 21:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757B912D1FC;
	Thu, 22 Feb 2024 21:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lhh+RvjC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C170112D1F8;
	Thu, 22 Feb 2024 21:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708637766; cv=fail; b=kDzpIPeHDAebofEBmhKEKIMomS5gOcVPlOTYtisdAXiSfXOj+wWqXar0Z2RsACU0MS70M3Lc1ZW1D+Mp8jwiAy92DpMzexajCc1wm7kpSKGpgypd8Dlj4DjUrLOaISKH/KRcw9nax8UhD6CVjySKhTQ+PQNM0+nPPnc4F9zPlzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708637766; c=relaxed/simple;
	bh=XmFx/Vm+R1wlwYghrHII4BkxGnxfNXyryQDmmATu1AM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d0wlRcw3DLRhqaJ1YoG40162N+Uecw5+3nK/t/pnw31WUFGSQz2qLYo/dZS9UBsbWtbDz9W8++vaVBvxJZhQuaaJX9Hg3iubuG4iqIP0rcq4gBt4++IvPIzGr4huO1yVSkE+7BBosB85Ls6VmPWdVlFljOhL/xwP9h7QlPT+F6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lhh+RvjC; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmXLXdhGNl0m97QdLmEBBKPXmm3PoRcf4qGLeAN53Bn9xWHLPARS8R+JK3/MwQREpbuAm1WN2bR3VK57dc88/EP1F/5TJ21F1ts4iJupcqXoSJDH5Oon7CthhaLLFv/ED5yiZVIdYsh7kKEzThZ2hYSdSKFbZ8eijnm2D29/g6l+a7L7egrsLedmKb2M6AygoG0HQbkN+PqnzgsSzvLsIEUZPJGFsN9iN80tVdjDuiZCqleK/dw5O7Wa1VkfMkDKuM4FmURRMF3gwM/wVQHdv+r9jVGONumGaCtRFiX2V9RPKC0O3EHG5Jh3pUyyR7Tuk8/+Jle3O65Q+XHx6FV3Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sokW/1SVjBLwv7iWek3JwDcw56P5NX04QetPcphla7w=;
 b=boxtlXSu2sPmLCycX2QoX14yt4s5NJ0FqtGt7XbVKAVYvbJ6tK5nF1NlhBf6Zew71frru6mztH6FPMYl+v/XmniV7P+7NQOQrp6liW8PNeIoEUkCW5jiU0r+dchx5hM+9Zp6RVUl3a7N+b1/hLf3S8jax+MxsmR6BddzAc5X68g1NSNa9pqEBqpipULjFYxPltzi7M82SifKSE4xc71xzfDPSR0oajxyU+pa4f8/UEgLm4OA/oNGfpJ2hNdnZHbC4TVJp+iVWTyBYfcxM4q7/3IR2iR3n1QX5VfGCMHRosezlESGMoKROsr/NjF/STuqJ9e1MOPXpVTW58sWqJWgpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sokW/1SVjBLwv7iWek3JwDcw56P5NX04QetPcphla7w=;
 b=lhh+RvjCcthGQA7jXum5AoLmZHeOOIH80WeQmUTp7YWkd5nT6wydJqVOworpoPVJmJtJwsTRgDju2sCJma+h/8tqBQUGTP3PvVVCbtE6K0JCe87db8FZPQQ6AoQsUQeOnbTo85UTyGeZf/nnqC3fSYmh4VPIBbShXE+1ROgjXpk=
Received: from DS7PR03CA0304.namprd03.prod.outlook.com (2603:10b6:8:2b::16) by
 CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.21; Thu, 22 Feb 2024 21:36:02 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:8:2b:cafe::b9) by DS7PR03CA0304.outlook.office365.com
 (2603:10b6:8:2b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Thu, 22 Feb 2024 21:36:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 22 Feb 2024 21:36:02 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 22 Feb
 2024 15:36:01 -0600
From: Babu Moger <babu.moger@amd.com>
To: <fenghua.yu@intel.com>, <reinette.chatre@intel.com>, <shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <babu.moger@amd.com>,
	<maciej.wieczor-retman@intel.com>, <peternewman@google.com>,
	<eranian@google.com>
Subject: [PATCH 1/4] selftests/resctrl: Rename variable imcs and num_of_imcs() to generic names
Date: Thu, 22 Feb 2024 15:35:45 -0600
Message-ID: <458712890b9ac90b9e027ac1500881aedd58068c.1708637563.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|CH3PR12MB9079:EE_
X-MS-Office365-Filtering-Correlation-Id: 828efee6-1322-43ff-97dc-08dc33ee4476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CkePfRjl4kw2O5wbAD4dzMAZ8G7/5nJWw/YCL796cXyJQBNrH591VPSuDBtdLSGARDYOeLvP4KT/9O/23KX5q3GQEUzKBEPQDytoImOd1Jp6hkYRUWLHMFqNvFiG/8OEqwMef+5dvvvORwlbM6GpT6OQZspqn/r0kGdSFgo6XZ7ElJrqqLkdzmXMaI80uJmR2SIkjA2f8OHOZjghwFWI1XT46LF+u80hp0uS/2QxbfJaD7zvVW2DtdoPP36ORxTLKFeF8s3WLyAieWisuXgTRVIBDTuJwGe3hXf9EiVpGpUHCSsvxwtvqNRwpy7jn+xTNsZ9btZ3SNkToBVXlLNxjRjOgnasTJJeMjvc8UAsRhuFszgTrRads4RFY43CpIRb98rjciPxnb2tYQAUvekDFA0lo70XO5Q62gkq06u7T6eq50cFMZL7KUD5N3uwUWOdF6QbbAfh3Ew2/qOz7wHAqEFP/UVOaX3yyDf8x/FatHepkIBf+hChkI9IKBkp288ZdPW9HpI7bPGj0p+kQfnm+pGugXPQfzMAA/SmmDhVQhQUQgWvzfCBN5KBVVOhO+KRJcd/j7ltwIWYDnBr5Vf7SRuLwfVEbae5ykASEU/th5WTwSbo9PAESV1lMLqQQ48e9iOdAlo4enH/q1PHzWRcFw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 21:36:02.2686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 828efee6-1322-43ff-97dc-08dc33ee4476
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9079

In an effort to support MBM and MBA tests for AMD, renaming for variable
and functions to generic names. For Intel, the memory controller is called
Integrated Memory Controllers (IMC). For AMD, it is called Unified
Memory Controller (UMC). No functional change.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 tools/testing/selftests/resctrl/resctrl_val.c | 25 ++++++++++---------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 88789678917b..52e23a8076d3 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -60,7 +60,7 @@ struct imc_counter_config {
 };
 
 static char mbm_total_path[1024];
-static int imcs;
+static int number_of_mem_ctrls;
 static struct imc_counter_config imc_counters_config[MAX_IMCS][2];
 
 void membw_initialize_perf_event_attr(int i, int j)
@@ -211,15 +211,16 @@ static int read_from_imc_dir(char *imc_dir, int count)
 }
 
 /*
- * A system can have 'n' number of iMC (Integrated Memory Controller)
- * counters, get that 'n'. For each iMC counter get it's type and config.
+ * A system can have 'n' number of iMC (Integrated Memory Controller for
+ * Intel) counters, get that 'n'. In case of AMD it is called UMC (Unified
+ * Memory Controller). For each iMC/UMC counter get it's type and config.
  * Also, each counter has two configs, one for read and the other for write.
  * A config again has two parts, event and umask.
  * Enumerate all these details into an array of structures.
  *
  * Return: >= 0 on success. < 0 on failure.
  */
-static int num_of_imcs(void)
+static int get_number_of_mem_ctrls(void)
 {
 	char imc_dir[512], *temp;
 	unsigned int count = 0;
@@ -279,12 +280,12 @@ static int initialize_mem_bw_imc(void)
 {
 	int imc, j;
 
-	imcs = num_of_imcs();
-	if (imcs <= 0)
-		return imcs;
+	number_of_mem_ctrls = get_number_of_mem_ctrls();
+	if (number_of_mem_ctrls <= 0)
+		return number_of_mem_ctrls;
 
 	/* Initialize perf_event_attr structures for all iMC's */
-	for (imc = 0; imc < imcs; imc++) {
+	for (imc = 0; imc < number_of_mem_ctrls; imc++) {
 		for (j = 0; j < 2; j++)
 			membw_initialize_perf_event_attr(imc, j);
 	}
@@ -309,7 +310,7 @@ static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
 
 	/* Start all iMC counters to log values (both read and write) */
 	reads = 0, writes = 0, of_mul_read = 1, of_mul_write = 1;
-	for (imc = 0; imc < imcs; imc++) {
+	for (imc = 0; imc < number_of_mem_ctrls; imc++) {
 		for (j = 0; j < 2; j++) {
 			ret = open_perf_event(imc, cpu_no, j);
 			if (ret)
@@ -322,7 +323,7 @@ static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
 	sleep(1);
 
 	/* Stop counters after a second to get results (both read and write) */
-	for (imc = 0; imc < imcs; imc++) {
+	for (imc = 0; imc < number_of_mem_ctrls; imc++) {
 		for (j = 0; j < 2; j++)
 			membw_ioctl_perf_event_ioc_disable(imc, j);
 	}
@@ -331,7 +332,7 @@ static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
 	 * Get results which are stored in struct type imc_counter_config
 	 * Take over flow into consideration before calculating total b/w
 	 */
-	for (imc = 0; imc < imcs; imc++) {
+	for (imc = 0; imc < number_of_mem_ctrls; imc++) {
 		struct imc_counter_config *r =
 			&imc_counters_config[imc][READ];
 		struct imc_counter_config *w =
@@ -368,7 +369,7 @@ static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
 		writes += w->return_value.value * of_mul_write * SCALE;
 	}
 
-	for (imc = 0; imc < imcs; imc++) {
+	for (imc = 0; imc < number_of_mem_ctrls; imc++) {
 		close(imc_counters_config[imc][READ].fd);
 		close(imc_counters_config[imc][WRITE].fd);
 	}
-- 
2.34.1


