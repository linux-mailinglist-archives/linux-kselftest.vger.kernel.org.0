Return-Path: <linux-kselftest+bounces-8887-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BA78B2996
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 22:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D369CB21FEC
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 20:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCB4155A24;
	Thu, 25 Apr 2024 20:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bm1/Evhp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962EB155A26;
	Thu, 25 Apr 2024 20:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076264; cv=fail; b=BpOQAlEtTRUsivht1b717H+cZCR83o/+p+PnqN21PEAuCr5dkM/tqjR5SWanlOxROT28aPAUwcMe8whfHFEC+WXZ1X04NGASIVbolxwWyMzm0Qveo7oTEgdfgjcdQiwaGKdac7IRS6l76dAyPJVH9kfVI3gJczMCD7TM5TkzMNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076264; c=relaxed/simple;
	bh=gDndadJ9tX9jAeJafyYc4K+/DBL8HbsX0RKmni3RQzw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AHwN2NOlLUN8s/WfNChHPnyrAKaVTldN/rW5j7/C1sl7dwEbIfJ2xj7nefPQrUCRHraGNu2q1pKrPfANMP74bB9uoQSrBqcsJwtxlzy1bWGGMsrokTTk6muROiFajKGuSo8CWFSnvoYx2DGzWloCgHsYadWaKYKjJYNSjI7hQfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bm1/Evhp; arc=fail smtp.client-ip=40.107.236.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhIPNJOVW3gKsUgPMIOMC7dPafEj7qM0MDRUnvQGWgVHkvT8NJNuWzsdgweszrmW58eDcUz5BGyCIHK3VqRB8KqK9ULQBMQ8RApxlq9BXRf1ODlyAt1FH8GfGI7MLRHeG08+YmjwFWllyIbq8LrnXloC2LFYNevRevryZd/wJXxMn2BFrMVaQvkpiGnYpfAHn8uPCdE0YXVWsztj4ljLweSpqW9rsumEWjXtaKxFAMxY9IT61a5ku97G1vY4ItAASdu/DLowhy2SMIBdIXWwRnitMsb1I2NTseK1qML7w+etfI2tq7KhVsyx2h0gDzzQVG84bhE5eDbGVQG5K7BvfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYl+tIV1aqowwE/mXjCzqEAf7muXGkPjAPn/EzeJli4=;
 b=Yfo0G0qHRdBh7QnENyNAK9zt9kbDh5C0H9qLVXXAzrm444IUnmHPOqcBonvbbDtL+7s+XRCaA1wxu/j4mkFhwW5AzuHHT9uxg3EB5hbCANgXA5FwGC33rZpuDz62AXfpGxrJrqQdm3vAYoFyETLDC3ZLbDJ0sCfQmzLqbgpd/BkvIgEb8vh6MsuAXAkHTXt5ANdvFRUe8z5fC4gAN4IDnnF79rhL70xvJ9F2HEu6ypVTsabeRmaLzlKF7xouimK8Bl3B42IbSHxTybl7RMFzAhsoUjYKx3o2Z2y7LEfMw9hCU9vpiE2Ym8wMZC/C/6v6gLpfgq1KWwarDk5oy/oQaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYl+tIV1aqowwE/mXjCzqEAf7muXGkPjAPn/EzeJli4=;
 b=Bm1/EvhpPJbE+NMAk0BPNKWNqJHzNxKs5Pvl1GZa+rvUUZfhfoL9V/gHqJL39oH1o0RnPbscqpaOTn4U0neQoaG8eTxZgh9jqvWl084EKqzzztSXAirm5SSOfNiGHWvHjw15ZXLx0Fi3MELJtNTiHK+L/S2OIDRu8qmJwRGFb44=
Received: from MN2PR13CA0005.namprd13.prod.outlook.com (2603:10b6:208:160::18)
 by PH8PR12MB7160.namprd12.prod.outlook.com (2603:10b6:510:228::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 20:17:38 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:160:cafe::18) by MN2PR13CA0005.outlook.office365.com
 (2603:10b6:208:160::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.13 via Frontend
 Transport; Thu, 25 Apr 2024 20:17:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 20:17:37 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 15:17:36 -0500
From: Babu Moger <babu.moger@amd.com>
To: <fenghua.yu@intel.com>, <reinette.chatre@intel.com>, <shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <babu.moger@amd.com>,
	<maciej.wieczor-retman@intel.com>, <peternewman@google.com>,
	<eranian@google.com>
Subject: [PATCH v2 3/4] selftests/resctrl: Add support for MBM and MBA tests on AMD
Date: Thu, 25 Apr 2024 15:17:01 -0500
Message-ID: <0367b45170fbc7411aad12c28802284a298c1c6f.1714073751.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|PH8PR12MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: e890d961-75b3-4ba8-5a3d-08dc6564c048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XSYL/cpjuJl4ovmVudNFWtFPZExrZ9Q1WBpI2A2cVP3jOEyVzk/XrmuKtQAe?=
 =?us-ascii?Q?m0YM+OdalGQfIa9xv+piQYYv1UaPWU8RyoGgRhbsbtfCSdOBrJWL1CKAP8o/?=
 =?us-ascii?Q?8G6dXRy1+1+sOMvXfrA9adDIH1FqYPiaFlBXHU9m/MnzFkQ1YiyfjcE4oAoU?=
 =?us-ascii?Q?3IqRvwoM3llVSSQ3T37PQXxzeKiu18D6gd9S2ESvxDCnVU8756BjjgWrnVNS?=
 =?us-ascii?Q?J0XYkp8kudUIDMJMlF2bCGNBjtU+TDyoreAmA+3VVYhhJebO+06neUjj03pF?=
 =?us-ascii?Q?GDPbSiN/qQNIzUFatI3rBE82VLtN4dTvxt0rhdPbnHyXj8pDLdRyjIwQ0UTJ?=
 =?us-ascii?Q?sf/TXZbv1Ek6IOr++uk/f5wDTOjW8+a9DNvxDPj2k6AGkzrRh4rjrehEx7V1?=
 =?us-ascii?Q?PEes/oaeBcs5PIqVgqVWCsXMDfwHTGveV6cLWDKfcLUWIAzPR5XG8ZbX+1O0?=
 =?us-ascii?Q?QVmqncIMvVnuaCjcztOndaBQc11r8iqXqNl6tDDuWqckASyC6yQh4TH9sU1N?=
 =?us-ascii?Q?HD+ACYDxovOLoT4z2qu5Hy4/n3siRA+p949T+JEsscT3xzUl82WDzKIBNfQq?=
 =?us-ascii?Q?pPTrBQAaGHNFVY/5LpOiJFPb7psVrzk7NTfSSXB9l6TvpKoUQ7t7jVOno/a/?=
 =?us-ascii?Q?Mwz+l7l1qDgQc3lYPX/jcSouwAMX1bWJwMphB+GcxtLyLcj/BDSpRc6iVLb1?=
 =?us-ascii?Q?F295AV/2v03JJ3P+3o0r6BG9NPMT068q6B2FDsS/LUUz/JiiG1txe2QobvJD?=
 =?us-ascii?Q?scZt1Fbez8m3h1qCRAWZsKMbSjo8FcZNx0oY1F/sXZIZU/qd47mueOizcIt9?=
 =?us-ascii?Q?Fi/UFIkJrxyrrnWnIjo4pXfLu3QomBbOfAdHqBlO+JReW60jw8ijysopqBWF?=
 =?us-ascii?Q?qnRe3bI1ghcKnotjIsqGWe9hvjadvLz7XJAo05+PfehJyN7hbxA40mGUFHRG?=
 =?us-ascii?Q?WkQf5dSX7SwOPQnWD+zPe45L3gMLqlmHuGLx5S5hNaZN7WddKCNttLKiKIGv?=
 =?us-ascii?Q?RjqPwcdLa+CaTUr+EtZn2wR142sYLBu2ZfjwVsvf719VBtjv0vuESmsbT/bT?=
 =?us-ascii?Q?PPvRJXqmsdu9k2Kgy47wrBXeCSurYV44lMO4/hp9uDheIMaPrEp/RMGZxtGH?=
 =?us-ascii?Q?UgvV884pVb4x4HrlbOoVmhiy5c5nfMxOB+EkFTB+ToiYOP05NQhL6gx0F5WV?=
 =?us-ascii?Q?WEDrt4g5D5lbOAr5lvr/UeaEgCEOmntEdsKEr4vZ4ZTZ1QFTyYgyMNGjSqgE?=
 =?us-ascii?Q?x5+4+tR8WFzc/QF/+d+BwE0W8HmK5EWMgLTZ0Jb4H1eub2uYX3dH9oSlUvHI?=
 =?us-ascii?Q?0Lmh5LSZPY4HA1OYTl0eKMN5upwmn/f9uGaUrEsTW7VviXyhBaXRJhD2jeRt?=
 =?us-ascii?Q?/O47LtQJZLgMeZv3QG2xndKV+YNT?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 20:17:37.6401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e890d961-75b3-4ba8-5a3d-08dc6564c048
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7160

Add support to read UMC (Unified Memory Controller) perf events to compare
the numbers with QoS monitor for AMD.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 tools/testing/selftests/resctrl/resctrl_val.c | 67 ++++++++++++++++---
 1 file changed, 59 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index e3b09128ec3d..d90d3196d7b5 100644
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
+	char umc_counter_type[PATH_MAX];
+	FILE *fp;
+
+	/* Get type of iMC counter */
+	sprintf(umc_counter_type, "%s%s", umc_dir, "type");
+	fp = fopen(umc_counter_type, "r");
+	if (!fp) {
+		ksft_perror("Failed to open imc counter type file");
+		return -1;
+	}
+
+	if (fscanf(fp, "%u", &imc_counters_config[count][READ].type) <= 0) {
+		ksft_perror("Could not get imc type");
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
@@ -233,6 +275,9 @@ static int num_of_mem_controllers(void)
 	if (vendor == ARCH_INTEL) {
 		sysfs_name = UNCORE_IMC;
 		size = sizeof(UNCORE_IMC);
+	} else if (vendor == ARCH_AMD) {
+		sysfs_name = AMD_UMC;
+		size = sizeof(AMD_UMC);
 	} else {
 		perror("Unsupported Vendor!\n");
 		return -1;
@@ -246,11 +291,12 @@ static int num_of_mem_controllers(void)
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
 
@@ -262,7 +308,11 @@ static int num_of_mem_controllers(void)
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
 
@@ -273,8 +323,9 @@ static int num_of_mem_controllers(void)
 		}
 		closedir(dp);
 		if (count == 0) {
-			ksft_print_msg("Unable to find iMC counters\n");
-
+			ksft_print_msg("Unable to find iMC/UMC counters\n");
+			if (vendor == ARCH_AMD)
+				ksft_print_msg("Try loading amd_uncore module\n");
 			return -1;
 		}
 	} else {
-- 
2.34.1


