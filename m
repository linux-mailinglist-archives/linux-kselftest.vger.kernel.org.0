Return-Path: <linux-kselftest+bounces-11273-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312878FDA08
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 00:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D78782885DF
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 22:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB61A15FD15;
	Wed,  5 Jun 2024 22:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NXkGi6Hw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2DE15EFDF;
	Wed,  5 Jun 2024 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717627577; cv=fail; b=BApzGeok1pNvfrYBQoQk3y2Ea/oI60clRmQzJbFGdZZO2kpySxy6Pj47w5DoKZFIAzQnNYtN4uWDcRnbbmWKKZKpZ+eHUclr0Q0J0wwsdVa5R8z2U6LKRZxcM0jYIF9MGb6ZiCKWTTbuCBURjrl54G4bRF/QB+tCQFNZkD2g4CI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717627577; c=relaxed/simple;
	bh=NX5xMZ/m1J3UhQ9h472wLaNA4CsxcCH2WG9UWIqj8rc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kCeqBKC90YuoPIg/0d1IR2ycFr0IhdXJvjzIYWLoEYt7/sb5FU2XWoIJj35Xi6KI0Z8WZtchJWdcKTfNMw9fxrSsLvqlfDcpv9BpaktfRm9hDbYiZD3PpCauZQjBGTn6wAXVsap5ubRUQOk0r7KY2IDW0pck4GvF/5X0mSrJeIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NXkGi6Hw; arc=fail smtp.client-ip=40.107.92.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYnkpqRPMrYQFoLFpBOnLa/ptRrzly+MVfIq/isKMr6AHo2mJsY28kFgr19Q3CLLgroZuHz2XT+COMQ0lBAU79Qqsr57yo5HgHIvQqPyvEWJNkLJATtY4Kjqi9YENGq3H5pc4G3lHqgW/F8z80PbyeOib5PFdPkkxIGmNhFq54n+EjxhCkEcNWAUSP6rmJ7zg+0e+INWpNjqXps4OzaJt4+JP1Rs2guVARXiskZL85ZGIw/HWoFN2ViC+QIddhQIK0dFRXElnwIG/Yvs8F9Rd79liNJDtOh8xElditac9FE454L5/FfP5pugbKaq/3Hr7tEVY8ceOyu2eZISnVPxEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8s6XPvHsyELn5qRaNsU9DS2eQEq66dUVAilP62MsYc=;
 b=HD6laKj405C1uNO2wYd9FcT7NDt9FmPqE5jVKxiWaYHMZem6sx/mwGb+34uwOFoQ7nHAcuueKkptQN0fca6Rf+S+PjUUixHOslg856U6+VxSoeNleHda22gB5/hduW01EWRBu+8FsCo1i3KF8qodyNk4LSU2Ei0zP37eZiFAlMp68fss2G9QQpVzeh5dqwHQlyXySRqvZhArBpgP2ywVXlGMmV0KB+faLlDjerk0R5ZIvOjDjyokyyV075L3ZFbLqtkZs2DLbwRfFzxS2Yf7Wi2XltC8nlVtbsfvdxGIuGUlnr6UwH9vxPhndqXmOezpD9J98KdBSDE86kaMqXPVQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8s6XPvHsyELn5qRaNsU9DS2eQEq66dUVAilP62MsYc=;
 b=NXkGi6HwEqctFYPPwrsMiOfJWvIYh9nirI2zXzvA1ceWw+939Jv1WzVt7Af+WTHcfZM3iN4eoLBm+3I8EmvqGyKWag8b/+QyRk7qxqK5bLPoayPbXc/VlWKxGmv2mgzWsA23ZhWkMh7lhGXrKn02GOHM5jQmSG17lSOeltpB97I=
Received: from BN9PR03CA0518.namprd03.prod.outlook.com (2603:10b6:408:131::13)
 by CH2PR12MB4151.namprd12.prod.outlook.com (2603:10b6:610:78::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 22:46:12 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:408:131:cafe::ca) by BN9PR03CA0518.outlook.office365.com
 (2603:10b6:408:131::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.17 via Frontend
 Transport; Wed, 5 Jun 2024 22:46:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 22:46:07 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 17:46:06 -0500
From: Babu Moger <babu.moger@amd.com>
To: <fenghua.yu@intel.com>, <reinette.chatre@intel.com>, <shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <babu.moger@amd.com>,
	<maciej.wieczor-retman@intel.com>, <peternewman@google.com>,
	<eranian@google.com>
Subject: [PATCH v3 3/4] selftests/resctrl: Add support for MBM and MBA tests on AMD
Date: Wed, 5 Jun 2024 17:45:33 -0500
Message-ID: <3c2034e3391634b35192819b69eabd7db8cffa8f.1717626661.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1717626661.git.babu.moger@amd.com>
References: <cover.1717626661.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|CH2PR12MB4151:EE_
X-MS-Office365-Filtering-Correlation-Id: e6182785-0cd6-47f2-3ef4-08dc85b149c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CwpKTyNuFTb90VY4xvQktpIzzNa/kl5s+3AvY8GWNIpAVrRz430mfmBIRp08?=
 =?us-ascii?Q?GNWu2JGGycnPbw2TvnOp8rKdc510vPy9LplGOO9oEz8sq1G7/W4YkDysjv5R?=
 =?us-ascii?Q?YsbWCc+Ph9jswUqEjQTtz8RrZrPTXxhSoE63kutDUN6xcgs0tNQKpFsCg/Tj?=
 =?us-ascii?Q?wB5o3O4wuy8QI6CGqrkU4+m8F40wtsliZxxOE8rqp8nqDFJrN47BQdPd6mRH?=
 =?us-ascii?Q?gMJJ9SBvVeS+988+f7a2eK11ar1UOyQtrphxhkXCRdd+EsSm3xS7vhlUoAoT?=
 =?us-ascii?Q?RbCRLr50KmD8zr7xQHbKdCN3PctsQ2zOynrN3CGTK527U9CNijbhy5/JX2Ae?=
 =?us-ascii?Q?vVZUFDer+bnF+rw5hM33xW+KwUBw9p2nHg06SbXejpZxDLXwPaCXPX10N/od?=
 =?us-ascii?Q?v9WNV9erefgGn8ltAf6bqSSFPEkx5A7ssFABhSMWx2ckObPn0XNS+HoKNqA2?=
 =?us-ascii?Q?hbS6F74BmVcas3Y0Ar8H8/fd9PXMYJKqizuTkrxg3PCAiaFWLPfGeu9rSoKe?=
 =?us-ascii?Q?WN/DOH2y3vZPSToEASB0nPl/fLzTV2PgPBV6WqyZsfT6bRUc3ybu8wWP8QfN?=
 =?us-ascii?Q?iOZW0/j84914huF+cPsXWVm4nD46qasfvB3aTyBFdwnm1X0qBek2OxZdh2mv?=
 =?us-ascii?Q?NhKArvj1ZGuVsL47QUmCNqo9XuY2re6zcURSEb/Arf4WYoIe1f+b+YpQq/VL?=
 =?us-ascii?Q?UbwtV8p6Uu5r1uGTGCqWHgN8dlcCzvFSeWkfSIpJ1xPFRaVfHNZAZEpI7I2w?=
 =?us-ascii?Q?ddN0N/Fp50XwHtgHpgV5Wn60wsx3jUxYTNmt70kXl3pfmsYP3p+vv1ym8DFl?=
 =?us-ascii?Q?5YW+PRVVML+jHHIgtPF0yWWFJBXMaZEz8m59jcjqjEhfpc15Xd4lo9Dw0ffe?=
 =?us-ascii?Q?oqeVJbn0bhGRDxx2Tv0VX4vdjRvCuftcDEIe3jS8ZhCesPSxnWkpXXsmTCHi?=
 =?us-ascii?Q?hxg658aKdIjN0RWFhi8Ya++K9rnmcDJvYgQiaZz2GpQlPNf3tDGhqnC4QYg1?=
 =?us-ascii?Q?URqO9dSOCyCByU2xXW3VeGVxn6IMgaO2vg1IRilUtIPshCV/VIszvcowGUam?=
 =?us-ascii?Q?QnBR2LMSt1ekvtO5ySdGghJydE4zQksy14gZiLE9Jqnk1fOvJm7E7RoBfv/X?=
 =?us-ascii?Q?kFxrGE9RKT46SU6jfAmW13dPGE0qiZVCQZz34CDZNZ2tn/PI6xTG2d20lYmb?=
 =?us-ascii?Q?FNDKEf76Jrndm64/1khddfSYPe6efR4LjBKyt4a58tZkMCyCsUcJVGTxtLvE?=
 =?us-ascii?Q?x/3DD/OaEJGDzEmkypStWgReCQHWm8165+uUc1G9nVPrPJo0NQnRs7UMlTIC?=
 =?us-ascii?Q?b23uZSDcWanRvLOFQJP1v/NZe78mEb+5jbXQLX5PZNFJEfG4VZLlOD44cV4X?=
 =?us-ascii?Q?VWovgvKU8VluXFc4xPeK2hKjGy+J?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 22:46:07.2421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6182785-0cd6-47f2-3ef4-08dc85b149c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4151

Add support to read UMC (Unified Memory Controller) perf events to compare
the numbers with QoS monitor for AMD.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v3: Made read_from_mc_dir function generic to both AMD and Intel.
    Rest are mostly related to rebase.

v2: Replace perror with ksft_perror.
---
 tools/testing/selftests/resctrl/resctrl_val.c | 80 ++++++++++++-------
 1 file changed, 50 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 23c0e0a1d845..ffacafb535cd 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -11,6 +11,7 @@
 #include "resctrl.h"
 
 #define UNCORE_IMC		"uncore_imc_"
+#define AMD_UMC			"amd_umc_"
 #define READ_FILE_NAME		"events/cas_count_read"
 #define WRITE_FILE_NAME		"events/cas_count_write"
 #define DYN_PMU_PATH		"/sys/bus/event_source/devices"
@@ -128,7 +129,7 @@ static int open_perf_event(int i, int cpu_no, int j)
 }
 
 /* Get type and config (read and write) of an MC counter */
-static int read_from_mc_dir(char *mc_dir, int count)
+static int read_from_mc_dir(char *mc_dir, int count, int vendor)
 {
 	char cas_count_cfg[1024], mc_counter_cfg[1024], mc_counter_type[1024];
 	FILE *fp;
@@ -152,41 +153,56 @@ static int read_from_mc_dir(char *mc_dir, int count)
 	mc_counters_config[count][WRITE].type =
 				mc_counters_config[count][READ].type;
 
-	/* Get read config */
-	sprintf(mc_counter_cfg, "%s%s", mc_dir, READ_FILE_NAME);
-	fp = fopen(mc_counter_cfg, "r");
-	if (!fp) {
-		ksft_perror("Failed to open MC config file");
+	if (vendor == ARCH_AMD) {
+		/*
+		 * Setup the event and umasks for UMC events
+		 * Number of CAS commands sent for reads:
+		 * EventCode = 0x0a, umask = 0x1
+		 * Number of CAS commands sent for writes:
+		 * EventCode = 0x0a, umask = 0x2
+		 */
+		mc_counters_config[count][READ].event = 0xa;
+		mc_counters_config[count][READ].umask = 0x1;
 
-		return -1;
-	}
-	if (fscanf(fp, "%s", cas_count_cfg) <= 0) {
-		ksft_perror("Could not get MC cas count read");
+		mc_counters_config[count][WRITE].event = 0xa;
+		mc_counters_config[count][WRITE].umask = 0x2;
+	} else {
+		/* Get read config */
+		sprintf(mc_counter_cfg, "%s%s", mc_dir, READ_FILE_NAME);
+		fp = fopen(mc_counter_cfg, "r");
+		if (!fp) {
+			ksft_perror("Failed to open MC config file");
+
+			return -1;
+		}
+		if (fscanf(fp, "%s", cas_count_cfg) <= 0) {
+			ksft_perror("Could not get MC cas count read");
+			fclose(fp);
+
+			return -1;
+		}
 		fclose(fp);
 
-		return -1;
-	}
-	fclose(fp);
+		get_event_and_umask(cas_count_cfg, count, READ);
 
-	get_event_and_umask(cas_count_cfg, count, READ);
+		/* Get write config */
+		sprintf(mc_counter_cfg, "%s%s", mc_dir, WRITE_FILE_NAME);
+		fp = fopen(mc_counter_cfg, "r");
+		if (!fp) {
+			ksft_perror("Failed to open MC config file");
 
-	/* Get write config */
-	sprintf(mc_counter_cfg, "%s%s", mc_dir, WRITE_FILE_NAME);
-	fp = fopen(mc_counter_cfg, "r");
-	if (!fp) {
-		ksft_perror("Failed to open MC config file");
+			return -1;
+		}
+		if  (fscanf(fp, "%s", cas_count_cfg) <= 0) {
+			ksft_perror("Could not get MC cas count write");
+			fclose(fp);
 
-		return -1;
-	}
-	if  (fscanf(fp, "%s", cas_count_cfg) <= 0) {
-		ksft_perror("Could not get MC cas count write");
+			return -1;
+		}
 		fclose(fp);
 
-		return -1;
+		get_event_and_umask(cas_count_cfg, count, WRITE);
 	}
-	fclose(fp);
-
-	get_event_and_umask(cas_count_cfg, count, WRITE);
 
 	return 0;
 }
@@ -213,6 +229,8 @@ static int num_of_mem_controllers(void)
 	vendor = get_vendor();
 	if (vendor == ARCH_INTEL) {
 		sysfs_name = UNCORE_IMC;
+	} else if (vendor == ARCH_AMD) {
+		sysfs_name = AMD_UMC;
 	} else {
 		ksft_perror("Unsupported vendor!\n");
 		return -1;
@@ -228,6 +246,7 @@ static int num_of_mem_controllers(void)
 			/*
 			 * imc counters are named as "uncore_imc_<n>", hence
 			 * increment the pointer to point to <n>.
+			 * For AMD, it will be amd_umc_<n>.
 			 */
 			temp = temp + strlen(sysfs_name);
 
@@ -239,7 +258,7 @@ static int num_of_mem_controllers(void)
 			if (temp[0] >= '0' && temp[0] <= '9') {
 				sprintf(mc_dir, "%s/%s/", DYN_PMU_PATH,
 					ep->d_name);
-				ret = read_from_mc_dir(mc_dir, count);
+				ret = read_from_mc_dir(mc_dir, count, vendor);
 				if (ret) {
 					closedir(dp);
 
@@ -250,8 +269,9 @@ static int num_of_mem_controllers(void)
 		}
 		closedir(dp);
 		if (count == 0) {
-			ksft_print_msg("Unable to find MC counters\n");
-
+			ksft_print_msg("Unable to find iMC/UMC counters\n");
+			if (vendor == ARCH_AMD)
+				ksft_print_msg("Try loading amd_uncore module\n");
 			return -1;
 		}
 	} else {
-- 
2.34.1


