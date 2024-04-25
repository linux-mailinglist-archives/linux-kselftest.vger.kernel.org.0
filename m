Return-Path: <linux-kselftest+bounces-8885-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCAF8B2992
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 22:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41E6286BCB
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 20:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D42F15573D;
	Thu, 25 Apr 2024 20:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UHyibeDW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CD715572B;
	Thu, 25 Apr 2024 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076252; cv=fail; b=HvATYPzrQc2hg8CJE5bD03MghNcR15EH+mlGXmUQcOOe62nCcpoHnyPpEA0O1WG5G6NRXgLfN4iXoCGZ1wpQH/u8uQs8IcdEUfrIjukHQNZNL/NWsLb1liz+uULF5tBc9hFY4V8t4c/eGPNdGaZeyhURRZv6Qxmlzo3C79iSYWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076252; c=relaxed/simple;
	bh=P/M4Be/7zXJgNPon8fV1DzIf+9LcDX4azZuZwtdHoiM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fnTc8fPQvWkwcPRcwDrTLGJW/rmF8Qyad5o94Zc4PUu0dJJvtz7o3wMtzlztlIC2Uc5wXSoBZQIEMcx/jv4SEWY7jOzMtRUaxltc61dvAzbzWDbbJL8y0OFAu6uGV78tGDfp6RpXLPID0Gux5Wmun3OI6k4/FvPm2izlUT/jIhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UHyibeDW; arc=fail smtp.client-ip=40.107.102.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDVmQtR4I39X3h3gu/qlLd40zX+NW9D5DEg7/ioOUI6YGSnA9d1JPw4AnEgmUk9q6gna6/so+9roWp+pKV2wavgOr7AQ7yk9abbLGH3YN5AMn1FjvZLKL7H3qlMi/pkCGYRMCdHo4GGaaOnJ4swJ2uoiZPl5+bkEI1Z7886E7ErXrpwk8hpBhde3k1nXGSG/DjfpWxAsOvo5W191VMaQ02G9yXvqpkTI57MwdaYIbudnzSn7XBk77oxUZWX0Iyy6gTzUymLITpzyiuKVfE+94nQNNKyZgnSMXOIrUD97+hq4ebHboorP0dCa1ATvtioBbLMNzpZPU98NvSsqSNbMTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2m/0lNNO4N16u5VLBs44JPJyPAqhumgneC0JmdnkVHE=;
 b=lpfc6SwXHSFej8BE4zl1JEAt1+wKQpD/xuY8NTWqGG9i6JK5pNo1I8COr+OmVPP3BFH3XXV7d6TlLtO5XtosWqzzwe4VnFhW3r5BWYJj0hzj8ZkkVc4JgjXQ0Gp9j3OsqpC8gRi/ZzeIkN8K0Vwr6Nac61gZMyNrotEBlRd5XEf73+e1YNqaIPrE34kbtKCUR2GuHgIVi2D70EVpSE/GLnPcabQaY8mckWcWCSS2siSNvE/LPQu1yArmEVxywVRDhDVBi5XxR0m5J1kpUpgo4H7zRl+N7ngWWwHnct+kE7DzpqRYV3/uhXKifM0ehF57C9RQ30NS9T0r8+HkjDLlJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2m/0lNNO4N16u5VLBs44JPJyPAqhumgneC0JmdnkVHE=;
 b=UHyibeDWN1x11bc8CH6jOLaOn6uMs6oxqcS3D/M+MESb41KeB7EBpMUQblsy8SRBv6+XHq1cUWkHiTmh3w/TKe+6G4/JxYS5cSyVyRS/Rktw0OB+PMRAsevIlreeC/NAyKNiqE9LT2odPE6ibDolLx8JObOL2bDRainWQYvrq8s=
Received: from MN2PR02CA0007.namprd02.prod.outlook.com (2603:10b6:208:fc::20)
 by CH2PR12MB4117.namprd12.prod.outlook.com (2603:10b6:610:ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 20:17:23 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:fc:cafe::50) by MN2PR02CA0007.outlook.office365.com
 (2603:10b6:208:fc::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.26 via Frontend
 Transport; Thu, 25 Apr 2024 20:17:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 20:17:23 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 15:17:22 -0500
From: Babu Moger <babu.moger@amd.com>
To: <fenghua.yu@intel.com>, <reinette.chatre@intel.com>, <shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <babu.moger@amd.com>,
	<maciej.wieczor-retman@intel.com>, <peternewman@google.com>,
	<eranian@google.com>
Subject: [PATCH v2 1/4] selftests/resctrl: Rename variable imcs and num_of_imcs() to generic names
Date: Thu, 25 Apr 2024 15:16:59 -0500
Message-ID: <c81a31bbc9385091a2e6b9da0c935ff46687179e.1714073751.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1714073751.git.babu.moger@amd.com>
References: <cover.1708637563.git.babu.moger@amd.com> <cover.1714073751.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|CH2PR12MB4117:EE_
X-MS-Office365-Filtering-Correlation-Id: 8056d35b-8511-4eca-e254-08dc6564b7ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rYCiw2gWN+kqkQTgcYa2js6XCh15j4ZLyB4LPdNbACz3aH4M2wkVp1OPe/oM?=
 =?us-ascii?Q?URxFmVZD5q7ZYfMQqCksgtDZpm2ohBoKshgoOITk2Y4NYkCrEs8YpGVThz2G?=
 =?us-ascii?Q?4w+Ik5bBkL6bqstQO89kiTCwQdSeRmfD6kTQVGKgRZAOjFIB8IXnX4WqD0uf?=
 =?us-ascii?Q?TEt3wjZ6bWPssis+RErHRqVBU5Mi3oGkL8DnQ4LyA07W1Rvam2Gs0/D8wlx3?=
 =?us-ascii?Q?cCE4ml7JxOqOBVjzQy6SSa0bRFR3nhpUtNrXlWPef4hAG/AGPPkpxlKoDQfh?=
 =?us-ascii?Q?mVS/EKbUciVNAn2a0xq0bYUxiIsd3dJuJ10aMWC9L0zKtLl+pM9gGhWnpEjA?=
 =?us-ascii?Q?MAyoIAVEkEsayqLZ8ulxZH/IUURa55WeZm/RQEmHf/6X62m5+ZbEg9r1+BrD?=
 =?us-ascii?Q?DHwXFISE4QtYuOb2jG8RjFmyjeTTuortaRZg7iKArIQ7qgc6SyXvIDeD2nr1?=
 =?us-ascii?Q?8Ngx2MwQwZmj3N1e3uR1L9AnTVFjzH5xclARHdoyUdEQqk2jEd12L5O81Icn?=
 =?us-ascii?Q?+8Z+NnG3jEs+49mWFcRkgOlPGp7ov6CEjW/vJEt7KYHsLhNBDk43GbZ909cl?=
 =?us-ascii?Q?eSbqrACJBnKHQoHldTLibqBv3nM2bhnoRAvBdxvX1zyBTeTGk6noWzCNdWCG?=
 =?us-ascii?Q?2yQmUZCfrpL0ZqtvLHePEk8rI1R/E+GUgZlSnHKKp6PCiIOmm8XObVJHJVh3?=
 =?us-ascii?Q?oVn2VY2Q6OZOBaetJhD1+XSuwxteG1Zyq/yAM7TtvTo77yP09xCRvcge0uqR?=
 =?us-ascii?Q?vsIlgIo5cTpxquoUViTRw+hqMxOJXhoMAZvjh+RzbdfT6gtp6Yk0jfPXVGLd?=
 =?us-ascii?Q?AcI6zEOb9P0Ncc0AKOp02t9QTrFoCVlVHlSmxJA8XrcGiqxICrnu3WEDPgXc?=
 =?us-ascii?Q?w2/cFcuOlAJ+S9VoMh/cIkf2/+DW8o0E4tEYeLubnAsbNytoRhI4Kch09Ibj?=
 =?us-ascii?Q?wVJistUPScFiuvkvCBHjJ4tCsO94RfwOCH/lWx+ajNF2HG7iDm//EkFSbGcM?=
 =?us-ascii?Q?A8x+O7N2EwEeT7byGaixvJuIieh1QqRB5UVVfsD7RBtRtqagRu2tv1a6ZsZY?=
 =?us-ascii?Q?Iyysw67twVpx0nA3B1i+LNLkomiz0F7L/aj7IjRgdrqNnwYjMprVOKXWm996?=
 =?us-ascii?Q?cbcuxI6QzNbCMbr6oYvozu1G1o9dYLmnTk9meRCZ7+/DIsH0SZ0mci1xD/1i?=
 =?us-ascii?Q?ODEiMuVgByyd0u9LSFxNyaEqIR83bBlwl3QJBTV+z4gDJXiwJGJ5XhQcE/vD?=
 =?us-ascii?Q?qdoKLxybcaapKqajP45Pw0Ay5nP7yobTbD+AXSaS88Z3z8Undgd3/DYhAqMB?=
 =?us-ascii?Q?gxBYNIx//N4OJVZjwk8OSuSdl+i6bVa9yeJ6D4U8aDdSpXJnioF96VcwCu//?=
 =?us-ascii?Q?EQx8VOg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 20:17:23.6320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8056d35b-8511-4eca-e254-08dc6564b7ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4117

In an effort to support MBM and MBA tests for AMD, renaming for variable
and functions to generic names. For Intel, the memory controller is called
Integrated Memory Controllers (IMC). For AMD, it is called Unified
Memory Controller (UMC). No functional change.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 tools/testing/selftests/resctrl/resctrl_val.c | 59 ++++++++++---------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 5a49f07a6c85..a30cfcff605f 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -60,7 +60,7 @@ struct imc_counter_config {
 };
 
 static char mbm_total_path[1024];
-static int imcs;
+static int mcs;
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
+static int num_of_mem_controllers(void)
 {
 	char imc_dir[512], *temp;
 	unsigned int count = 0;
@@ -275,25 +276,25 @@ static int num_of_imcs(void)
 	return count;
 }
 
-static int initialize_mem_bw_imc(void)
+static int initialize_mem_bw_mc(void)
 {
-	int imc, j;
+	int mc, j;
 
-	imcs = num_of_imcs();
-	if (imcs <= 0)
-		return imcs;
+	mcs = num_of_mem_controllers();
+	if (mcs <= 0)
+		return mcs;
 
 	/* Initialize perf_event_attr structures for all iMC's */
-	for (imc = 0; imc < imcs; imc++) {
+	for (mc = 0; mc < mcs; mc++) {
 		for (j = 0; j < 2; j++)
-			membw_initialize_perf_event_attr(imc, j);
+			membw_initialize_perf_event_attr(mc, j);
 	}
 
 	return 0;
 }
 
 /*
- * get_mem_bw_imc:	Memory band width as reported by iMC counters
+ * get_mem_bw_mc:	Memory band width as reported by iMC counters
  * @cpu_no:		CPU number that the benchmark PID is binded to
  * @bw_report:		Bandwidth report type (reads, writes)
  *
@@ -302,40 +303,40 @@ static int initialize_mem_bw_imc(void)
  *
  * Return: = 0 on success. < 0 on failure.
  */
-static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
+static int get_mem_bw_mc(int cpu_no, char *bw_report, float *bw_imc)
 {
 	float reads, writes, of_mul_read, of_mul_write;
-	int imc, j, ret;
+	int mc, j, ret;
 
 	/* Start all iMC counters to log values (both read and write) */
 	reads = 0, writes = 0, of_mul_read = 1, of_mul_write = 1;
-	for (imc = 0; imc < imcs; imc++) {
+	for (mc = 0; mc < mcs; mc++) {
 		for (j = 0; j < 2; j++) {
-			ret = open_perf_event(imc, cpu_no, j);
+			ret = open_perf_event(mc, cpu_no, j);
 			if (ret)
 				return -1;
 		}
 		for (j = 0; j < 2; j++)
-			membw_ioctl_perf_event_ioc_reset_enable(imc, j);
+			membw_ioctl_perf_event_ioc_reset_enable(mc, j);
 	}
 
 	sleep(1);
 
 	/* Stop counters after a second to get results (both read and write) */
-	for (imc = 0; imc < imcs; imc++) {
+	for (mc = 0; mc < mcs; mc++) {
 		for (j = 0; j < 2; j++)
-			membw_ioctl_perf_event_ioc_disable(imc, j);
+			membw_ioctl_perf_event_ioc_disable(mc, j);
 	}
 
 	/*
 	 * Get results which are stored in struct type imc_counter_config
 	 * Take over flow into consideration before calculating total b/w
 	 */
-	for (imc = 0; imc < imcs; imc++) {
+	for (mc = 0; mc < mcs; mc++) {
 		struct imc_counter_config *r =
-			&imc_counters_config[imc][READ];
+			&imc_counters_config[mc][READ];
 		struct imc_counter_config *w =
-			&imc_counters_config[imc][WRITE];
+			&imc_counters_config[mc][WRITE];
 
 		if (read(r->fd, &r->return_value,
 			 sizeof(struct membw_read_format)) == -1) {
@@ -368,9 +369,9 @@ static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
 		writes += w->return_value.value * of_mul_write * SCALE;
 	}
 
-	for (imc = 0; imc < imcs; imc++) {
-		close(imc_counters_config[imc][READ].fd);
-		close(imc_counters_config[imc][WRITE].fd);
+	for (mc = 0; mc < mcs; mc++) {
+		close(imc_counters_config[mc][READ].fd);
+		close(imc_counters_config[mc][WRITE].fd);
 	}
 
 	if (strcmp(bw_report, "reads") == 0) {
@@ -598,7 +599,7 @@ static int measure_vals(const struct user_params *uparams,
 			unsigned long *bw_resc_start)
 {
 	unsigned long bw_resc, bw_resc_end;
-	float bw_imc;
+	float bw_mc;
 	int ret;
 
 	/*
@@ -608,7 +609,7 @@ static int measure_vals(const struct user_params *uparams,
 	 * Compare the two values to validate resctrl value.
 	 * It takes 1sec to measure the data.
 	 */
-	ret = get_mem_bw_imc(uparams->cpu, param->bw_report, &bw_imc);
+	ret = get_mem_bw_mc(uparams->cpu, param->bw_report, &bw_mc);
 	if (ret < 0)
 		return ret;
 
@@ -617,7 +618,7 @@ static int measure_vals(const struct user_params *uparams,
 		return ret;
 
 	bw_resc = (bw_resc_end - *bw_resc_start) / MB;
-	ret = print_results_bw(param->filename, bm_pid, bw_imc, bw_resc);
+	ret = print_results_bw(param->filename, bm_pid, bw_mc, bw_resc);
 	if (ret)
 		return ret;
 
@@ -795,7 +796,7 @@ int resctrl_val(const struct resctrl_test *test,
 
 	if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
 	    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
-		ret = initialize_mem_bw_imc();
+		ret = initialize_mem_bw_mc();
 		if (ret)
 			goto out;
 
-- 
2.34.1


