Return-Path: <linux-kselftest+bounces-11271-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEFF8FDA03
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 00:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B87A285C44
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 22:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69014161318;
	Wed,  5 Jun 2024 22:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="chOTTZXC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1166B1649D1;
	Wed,  5 Jun 2024 22:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717627555; cv=fail; b=VTPwrPav/xpfs2PDdTT8miGU4z+5gxqkj1oJyA1BPddwpRzhXZWvVc0TYtzXvnLUt/vehXB5+7nrWW0E5YYN/XbnJ0zsMcvPAnvm1sUQfsgDlphDsLuPH/Dopp2XoKBtC0Ghy13eJweITwhm+ojYp6/XWYDy65jnVJvPtl6rYCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717627555; c=relaxed/simple;
	bh=2/gBgUXQHMkl85JHUeQKee2dQH3/OKoueMiq6XI4WkU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o4wnvRrOASHPgY8R96BdBbFHjAWGEj0qypCdj0rA1uNzTImgSkg2+T3pVyCtn3HiFjTlPteC25BA2/BJ+FSqxLQfnKb5fgFyNbprY7cAY38hF5+QPj+73njZCWjn/KWaNRyCnwBSf4DUtWmgwjPtaxDMkdTS7T+GnzeLwEMklY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=chOTTZXC; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfIWDt1sGdh95vAJMJZBXa6FiqPpLGxlOL2mlV0UQXtmWNIiNCHbIur3nsizw66dyct9YBK8eBdiSR1BJIkSkmKj2kdWcLCoXT0dM+j2iWDH1GCjb3hBgyryrR+XBOg43zYcdyCX0z/GykYkhxdXPT1XNLBwYxNfrXMgN0yIzsj+vHwkJ8iMRnebSulAjqbyEwcZpc4jypgIpe7KmbbSZgMPbLQHYjms//KosHFXzT5RMjDmj723TJ0tdQHPR1Y1SAQbO6Kj5cJI6Akb2ZiAkL994w14JtFhiOn67kVRuk0qCGpSGQNFzbKJKr2BGkGp7CgoHB2rKtondDSoDSkuPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QND9n7hMnxyPX0Uqk6CJWYjLcSvRsypguqPbdpmRIJY=;
 b=D9G04R+2REmQDFUFAnPj0/9MDAYDJZ43JbnK0+8/f01JSz/KKUfd6ZdNzVbl4NnZKAQKjrXcSAfYF619gGU9lDU1HSc1YsKHVFfXfgEotTPX2uv+vjPcSmdMv3d5acgXymy4lCu5WOyZ60Yta1yluyL2HkWarQB+McWOUXKOivvfifY8zdcbC1YAMxYQknu6j5aDZAFA4scLkNs9Bg8WvWPblQGwKQYe9oStqQFRdifHvWCvXAkssPTcZxRbAOHPhFErJ061FRfiom74njqHPJdvie4wGCrEBk+bVUUVFcMpOZJ45hQuw+2tQ1zSxIaaXzhq4zqDtDteSi+fJk5IgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QND9n7hMnxyPX0Uqk6CJWYjLcSvRsypguqPbdpmRIJY=;
 b=chOTTZXCoabBc2Qup2EGKpJxnBCrgtjOM4IReRDkGuUXzFp0Mjz+iruBRuKMdZCj8NIjURlOYWk5TcLvdBSs7PB49V1xRIacQGKlcgpbGGEtmBOkjqkmmEr3i7oWDwcN0H9l1tAseRRalXID1Q5ntarx0UCGWnRN5btlYorwC7k=
Received: from SJ0PR03CA0362.namprd03.prod.outlook.com (2603:10b6:a03:3a1::7)
 by SJ2PR12MB9116.namprd12.prod.outlook.com (2603:10b6:a03:557::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 22:45:50 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::d5) by SJ0PR03CA0362.outlook.office365.com
 (2603:10b6:a03:3a1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Wed, 5 Jun 2024 22:45:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 22:45:50 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 17:45:49 -0500
From: Babu Moger <babu.moger@amd.com>
To: <fenghua.yu@intel.com>, <reinette.chatre@intel.com>, <shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <babu.moger@amd.com>,
	<maciej.wieczor-retman@intel.com>, <peternewman@google.com>,
	<eranian@google.com>
Subject: [PATCH v3 1/4] selftests/resctrl: Rename variables and functions to generic names
Date: Wed, 5 Jun 2024 17:45:31 -0500
Message-ID: <c1b9905b5fd6b80933fddd6c576e5d34a78b2b90.1717626661.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|SJ2PR12MB9116:EE_
X-MS-Office365-Filtering-Correlation-Id: a7537146-15bd-42b7-a7c2-08dc85b13fb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KqIffVNUO8jHPbev1kJ4hqH2l3ZPczSq37A3kCRTowoQuL+C8r0Jje/1iUqh?=
 =?us-ascii?Q?Y8w0AX2dEp+x9x7aCCvk3EDPcEVIlvA0cfM6hNBzBQau9Lwu7FyL8pDJkQcj?=
 =?us-ascii?Q?h6O54tNClP3NBXEFh8z8upgAw1ZmVXJtPgTPHqUcv/YhknGXkrbU3NSzW+QD?=
 =?us-ascii?Q?RVAmO8xGKGaYW5OV7cf0zNGhE4UuwPMPnFSKTPGctOXMobep1PlbjRivgueu?=
 =?us-ascii?Q?G4jyzMFqElWk52l/EoMpgk7EHLu4DxI/ixHYyxY2+GEh16UyhKlIOLe/tho+?=
 =?us-ascii?Q?qA9CDfDoGt7S6etQRlJP8unkmG+7NCnxL7lx8CKsd3d00R8XI61MrYeMjzAV?=
 =?us-ascii?Q?8DKysMw3blZtfOs/X8XWGOxL1UFcaKpASqHWvo84dizu1+KLmtOZBhy7uTak?=
 =?us-ascii?Q?qJ8Iwcqg3iX14EqDf2r3JNqglC+TPxkLWhvWML8nPJW4HcobUPpyEFk9Y5sJ?=
 =?us-ascii?Q?5Wol1y9D/lxaqWdbwVScWft2RxbT2faH7Rsm21SfKgwKFXAIuZB+yaCNK6oG?=
 =?us-ascii?Q?Jt5gt8DQRKDtqDliHiumuQadC3NUhEzNyNZoDE9RjRXHtnwApm/txwuMGyPP?=
 =?us-ascii?Q?alUnbATm/B349qXSGm5Z8HG7iHep82HBpIL5Okd6wAj32rAWlvlUK4blyfWk?=
 =?us-ascii?Q?v74zSijec5AAvuvfyZoVlKZK4nuiXAP9mcx6DUDuzB/A2E9RErH+FtZ7fFx0?=
 =?us-ascii?Q?5F5w5xmm+SognUA+3G5owpxGsoFWCTH3voPaEudpNV1EEgLFt0NkXTe71S1n?=
 =?us-ascii?Q?611vg+AbEhgdvicEzC/DYkKwlfovMmFYa39THqOdS1wiQISd6a3QVHBCjhsa?=
 =?us-ascii?Q?ncl/2N1NNv3AMWOa86URHUgVr+I8mkosPbycabpEKGDT1qojtcy7RSwcjv/2?=
 =?us-ascii?Q?jhEe2PHW503XK1PunIsNsb/zdK1Vgd20iKPeL/px3/IuCxGiHjsY54y70ifU?=
 =?us-ascii?Q?+QP4cw3ZetmWbjtkH4qc6Wbfo3ar49JuRxVJrtQ07II6x6fF1EmM8iteFz3F?=
 =?us-ascii?Q?SnaAQ90TcXtiaQPXwtKTpRCtiWmlkuiRdLcuUO1FYFpvl2lJeC/V27eTCyEu?=
 =?us-ascii?Q?hNV6p04kq46B2nDqUXpS1EM8vtPC0wLhQsQPOFe2DSDTm2+N126N75kJOU6s?=
 =?us-ascii?Q?tAFLXpHjIFAWyLDF2vXA2SCXW8gmjmL6nBABM8V9tL/3DK9krtGWrP3uERua?=
 =?us-ascii?Q?DNlmI3QhFWQGkBbF5ct2GQZoeu2EGsBCdxrWKBnIXg+/+9rgB7955cHmxCpS?=
 =?us-ascii?Q?Ba3V1acc6BZFnSwtVI6FU2ezptlie61rqROEIcBnl8yF/IpV44648t1MOhU9?=
 =?us-ascii?Q?SbdFTL84pRop/2U/Ac+BphEeBd5BPmY7Eev27cXW/Da2XR0z043zfqfh+8IC?=
 =?us-ascii?Q?Ww4C2IEQiAo5YrmVlXeGQG6tH54FomrBXdWam26TSTfPk6IJ5Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 22:45:50.2977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7537146-15bd-42b7-a7c2-08dc85b13fb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9116

In an effort to support MBM and MBA tests for AMD, renaming for variable
and functions to generic names. For Intel, the memory controller is called
Integrated Memory Controllers (IMC). For AMD, it is called Unified
Memory Controller (UMC).

Change the names of variables and functions from imc (Integrated memory
controller) to mc(Memory Controller). No functional change.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v3: More name changes. Mostly replacing imc with mc.

v2: Few more name changes.
---
 tools/testing/selftests/resctrl/mba_test.c    |  24 +-
 tools/testing/selftests/resctrl/mbm_test.c    |  22 +-
 tools/testing/selftests/resctrl/resctrl.h     |   2 +-
 tools/testing/selftests/resctrl/resctrl_val.c | 225 +++++++++---------
 tools/testing/selftests/resctrl/resctrlfs.c   |   2 +-
 5 files changed, 138 insertions(+), 137 deletions(-)

diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index ab8496a4925b..394bbfd8a93e 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -21,7 +21,7 @@ static int mba_init(const struct resctrl_val_param *param, int domain_id)
 {
 	int ret;
 
-	ret = initialize_mem_bw_imc();
+	ret = initialize_mem_bw_mc();
 	if (ret)
 		return ret;
 
@@ -70,7 +70,7 @@ static int mba_measure(const struct user_params *uparams,
 	return measure_mem_bw(uparams, param, bm_pid, "reads");
 }
 
-static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
+static bool show_mba_info(unsigned long *bw_mc, unsigned long *bw_resc)
 {
 	int allocation, runs;
 	bool ret = false;
@@ -79,8 +79,8 @@ static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 	/* Memory bandwidth from 100% down to 10% */
 	for (allocation = 0; allocation < ALLOCATION_MAX / ALLOCATION_STEP;
 	     allocation++) {
-		unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
-		long avg_bw_imc, avg_bw_resc;
+		unsigned long sum_bw_mc = 0, sum_bw_resc = 0;
+		long avg_bw_mc, avg_bw_resc;
 		int avg_diff_per;
 		float avg_diff;
 
@@ -90,13 +90,13 @@ static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 		 */
 		for (runs = NUM_OF_RUNS * allocation + 1;
 		     runs < NUM_OF_RUNS * allocation + NUM_OF_RUNS ; runs++) {
-			sum_bw_imc += bw_imc[runs];
+			sum_bw_mc += bw_mc[runs];
 			sum_bw_resc += bw_resc[runs];
 		}
 
-		avg_bw_imc = sum_bw_imc / (NUM_OF_RUNS - 1);
+		avg_bw_mc = sum_bw_mc / (NUM_OF_RUNS - 1);
 		avg_bw_resc = sum_bw_resc / (NUM_OF_RUNS - 1);
-		avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
+		avg_diff = (float)labs(avg_bw_resc - avg_bw_mc) / avg_bw_mc;
 		avg_diff_per = (int)(avg_diff * 100);
 
 		ksft_print_msg("%s Check MBA diff within %d%% for schemata %u\n",
@@ -106,7 +106,7 @@ static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 			       ALLOCATION_MAX - ALLOCATION_STEP * allocation);
 
 		ksft_print_msg("avg_diff_per: %d%%\n", avg_diff_per);
-		ksft_print_msg("avg_bw_imc: %lu\n", avg_bw_imc);
+		ksft_print_msg("avg_bw_mc: %lu\n", avg_bw_mc);
 		ksft_print_msg("avg_bw_resc: %lu\n", avg_bw_resc);
 		if (avg_diff_per > MAX_DIFF_PERCENT)
 			ret = true;
@@ -123,7 +123,7 @@ static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 static int check_results(void)
 {
 	char *token_array[8], output[] = RESULT_FILE_NAME, temp[512];
-	unsigned long bw_imc[1024], bw_resc[1024];
+	unsigned long bw_mc[1024], bw_resc[1024];
 	int runs;
 	FILE *fp;
 
@@ -144,8 +144,8 @@ static int check_results(void)
 			token = strtok(NULL, ":\t");
 		}
 
-		/* Field 3 is perf imc value */
-		bw_imc[runs] = strtoul(token_array[3], NULL, 0);
+		/* Field 3 is perf mc value */
+		bw_mc[runs] = strtoul(token_array[3], NULL, 0);
 		/* Field 5 is resctrl value */
 		bw_resc[runs] = strtoul(token_array[5], NULL, 0);
 		runs++;
@@ -153,7 +153,7 @@ static int check_results(void)
 
 	fclose(fp);
 
-	return show_mba_info(bw_imc, bw_resc);
+	return show_mba_info(bw_mc, bw_resc);
 }
 
 static void mba_test_cleanup(void)
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 6b5a3b52d861..9b6f7f162282 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -15,10 +15,10 @@
 #define NUM_OF_RUNS		5
 
 static int
-show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span)
+show_bw_info(unsigned long *bw_mc, unsigned long *bw_resc, size_t span)
 {
-	unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
-	long avg_bw_imc = 0, avg_bw_resc = 0;
+	unsigned long sum_bw_mc = 0, sum_bw_resc = 0;
+	long avg_bw_mc = 0, avg_bw_resc = 0;
 	int runs, ret, avg_diff_per;
 	float avg_diff = 0;
 
@@ -27,13 +27,13 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span)
 	 * transition phase.
 	 */
 	for (runs = 1; runs < NUM_OF_RUNS ; runs++) {
-		sum_bw_imc += bw_imc[runs];
+		sum_bw_mc += bw_mc[runs];
 		sum_bw_resc += bw_resc[runs];
 	}
 
-	avg_bw_imc = sum_bw_imc / 4;
+	avg_bw_mc = sum_bw_mc / 4;
 	avg_bw_resc = sum_bw_resc / 4;
-	avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
+	avg_diff = (float)labs(avg_bw_resc - avg_bw_mc) / avg_bw_mc;
 	avg_diff_per = (int)(avg_diff * 100);
 
 	ret = avg_diff_per > MAX_DIFF_PERCENT;
@@ -41,7 +41,7 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span)
 		       ret ? "Fail:" : "Pass:", MAX_DIFF_PERCENT);
 	ksft_print_msg("avg_diff_per: %d%%\n", avg_diff_per);
 	ksft_print_msg("Span (MB): %zu\n", span / MB);
-	ksft_print_msg("avg_bw_imc: %lu\n", avg_bw_imc);
+	ksft_print_msg("avg_bw_mc: %lu\n", avg_bw_mc);
 	ksft_print_msg("avg_bw_resc: %lu\n", avg_bw_resc);
 
 	return ret;
@@ -49,7 +49,7 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span)
 
 static int check_results(size_t span)
 {
-	unsigned long bw_imc[NUM_OF_RUNS], bw_resc[NUM_OF_RUNS];
+	unsigned long bw_mc[NUM_OF_RUNS], bw_resc[NUM_OF_RUNS];
 	char temp[1024], *token_array[8];
 	char output[] = RESULT_FILE_NAME;
 	int runs, ret;
@@ -75,11 +75,11 @@ static int check_results(size_t span)
 		}
 
 		bw_resc[runs] = strtoul(token_array[5], NULL, 0);
-		bw_imc[runs] = strtoul(token_array[3], NULL, 0);
+		bw_mc[runs] = strtoul(token_array[3], NULL, 0);
 		runs++;
 	}
 
-	ret = show_bw_info(bw_imc, bw_resc, span);
+	ret = show_bw_info(bw_mc, bw_resc, span);
 
 	fclose(fp);
 
@@ -90,7 +90,7 @@ static int mbm_init(const struct resctrl_val_param *param, int domain_id)
 {
 	int ret;
 
-	ret = initialize_mem_bw_imc();
+	ret = initialize_mem_bw_mc();
 	if (ret)
 		return ret;
 
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 2dda56084588..5f1854986c7b 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -143,7 +143,7 @@ unsigned char *alloc_buffer(size_t buf_size, int memflush);
 void mem_flush(unsigned char *buf, size_t buf_size);
 void fill_cache_read(unsigned char *buf, size_t buf_size, bool once);
 int run_fill_buf(size_t buf_size, int memflush, int op, bool once);
-int initialize_mem_bw_imc(void);
+int initialize_mem_bw_mc(void);
 int measure_mem_bw(const struct user_params *uparams,
 		   struct resctrl_val_param *param, pid_t bm_pid,
 		   const char *bw_report);
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 35eba2d99d32..2d5e961b3a68 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -15,7 +15,7 @@
 #define WRITE_FILE_NAME		"events/cas_count_write"
 #define DYN_PMU_PATH		"/sys/bus/event_source/devices"
 #define SCALE			0.00006103515625
-#define MAX_IMCS		20
+#define MAX_MCS			20
 #define MAX_TOKENS		5
 #define READ			0
 #define WRITE			1
@@ -30,7 +30,7 @@ struct membw_read_format {
 	__u64 id;            /* if PERF_FORMAT_ID */
 };
 
-struct imc_counter_config {
+struct mc_counter_config {
 	__u32 type;
 	__u64 event;
 	__u64 umask;
@@ -40,42 +40,42 @@ struct imc_counter_config {
 };
 
 static char mbm_total_path[1024];
-static int imcs;
-static struct imc_counter_config imc_counters_config[MAX_IMCS][2];
+static int mcs;
+static struct mc_counter_config mc_counters_config[MAX_MCS][2];
 static const struct resctrl_test *current_test;
 
 void membw_initialize_perf_event_attr(int i, int j)
 {
-	memset(&imc_counters_config[i][j].pe, 0,
+	memset(&mc_counters_config[i][j].pe, 0,
 	       sizeof(struct perf_event_attr));
-	imc_counters_config[i][j].pe.type = imc_counters_config[i][j].type;
-	imc_counters_config[i][j].pe.size = sizeof(struct perf_event_attr);
-	imc_counters_config[i][j].pe.disabled = 1;
-	imc_counters_config[i][j].pe.inherit = 1;
-	imc_counters_config[i][j].pe.exclude_guest = 0;
-	imc_counters_config[i][j].pe.config =
-		imc_counters_config[i][j].umask << 8 |
-		imc_counters_config[i][j].event;
-	imc_counters_config[i][j].pe.sample_type = PERF_SAMPLE_IDENTIFIER;
-	imc_counters_config[i][j].pe.read_format =
+	mc_counters_config[i][j].pe.type = mc_counters_config[i][j].type;
+	mc_counters_config[i][j].pe.size = sizeof(struct perf_event_attr);
+	mc_counters_config[i][j].pe.disabled = 1;
+	mc_counters_config[i][j].pe.inherit = 1;
+	mc_counters_config[i][j].pe.exclude_guest = 0;
+	mc_counters_config[i][j].pe.config =
+		mc_counters_config[i][j].umask << 8 |
+		mc_counters_config[i][j].event;
+	mc_counters_config[i][j].pe.sample_type = PERF_SAMPLE_IDENTIFIER;
+	mc_counters_config[i][j].pe.read_format =
 		PERF_FORMAT_TOTAL_TIME_ENABLED | PERF_FORMAT_TOTAL_TIME_RUNNING;
 }
 
 void membw_ioctl_perf_event_ioc_reset_enable(int i, int j)
 {
-	ioctl(imc_counters_config[i][j].fd, PERF_EVENT_IOC_RESET, 0);
-	ioctl(imc_counters_config[i][j].fd, PERF_EVENT_IOC_ENABLE, 0);
+	ioctl(mc_counters_config[i][j].fd, PERF_EVENT_IOC_RESET, 0);
+	ioctl(mc_counters_config[i][j].fd, PERF_EVENT_IOC_ENABLE, 0);
 }
 
 void membw_ioctl_perf_event_ioc_disable(int i, int j)
 {
-	ioctl(imc_counters_config[i][j].fd, PERF_EVENT_IOC_DISABLE, 0);
+	ioctl(mc_counters_config[i][j].fd, PERF_EVENT_IOC_DISABLE, 0);
 }
 
 /*
  * get_event_and_umask:	Parse config into event and umask
  * @cas_count_cfg:	Config
- * @count:		iMC number
+ * @count:		MC number
  * @op:			Operation (read/write)
  */
 void get_event_and_umask(char *cas_count_cfg, int count, bool op)
@@ -94,18 +94,18 @@ void get_event_and_umask(char *cas_count_cfg, int count, bool op)
 			break;
 		if (strcmp(token[i], "event") == 0) {
 			if (op == READ)
-				imc_counters_config[count][READ].event =
+				mc_counters_config[count][READ].event =
 				strtol(token[i + 1], NULL, 16);
 			else
-				imc_counters_config[count][WRITE].event =
+				mc_counters_config[count][WRITE].event =
 				strtol(token[i + 1], NULL, 16);
 		}
 		if (strcmp(token[i], "umask") == 0) {
 			if (op == READ)
-				imc_counters_config[count][READ].umask =
+				mc_counters_config[count][READ].umask =
 				strtol(token[i + 1], NULL, 16);
 			else
-				imc_counters_config[count][WRITE].umask =
+				mc_counters_config[count][WRITE].umask =
 				strtol(token[i + 1], NULL, 16);
 		}
 	}
@@ -113,13 +113,13 @@ void get_event_and_umask(char *cas_count_cfg, int count, bool op)
 
 static int open_perf_event(int i, int cpu_no, int j)
 {
-	imc_counters_config[i][j].fd =
-		perf_event_open(&imc_counters_config[i][j].pe, -1, cpu_no, -1,
+	mc_counters_config[i][j].fd =
+		perf_event_open(&mc_counters_config[i][j].pe, -1, cpu_no, -1,
 				PERF_FLAG_FD_CLOEXEC);
 
-	if (imc_counters_config[i][j].fd == -1) {
+	if (mc_counters_config[i][j].fd == -1) {
 		fprintf(stderr, "Error opening leader %llx\n",
-			imc_counters_config[i][j].pe.config);
+			mc_counters_config[i][j].pe.config);
 
 		return -1;
 	}
@@ -127,41 +127,41 @@ static int open_perf_event(int i, int cpu_no, int j)
 	return 0;
 }
 
-/* Get type and config (read and write) of an iMC counter */
-static int read_from_imc_dir(char *imc_dir, int count)
+/* Get type and config (read and write) of an MC counter */
+static int read_from_mc_dir(char *mc_dir, int count)
 {
-	char cas_count_cfg[1024], imc_counter_cfg[1024], imc_counter_type[1024];
+	char cas_count_cfg[1024], mc_counter_cfg[1024], mc_counter_type[1024];
 	FILE *fp;
 
-	/* Get type of iMC counter */
-	sprintf(imc_counter_type, "%s%s", imc_dir, "type");
-	fp = fopen(imc_counter_type, "r");
+	/* Get type of MC counter */
+	sprintf(mc_counter_type, "%s%s", mc_dir, "type");
+	fp = fopen(mc_counter_type, "r");
 	if (!fp) {
-		ksft_perror("Failed to open iMC counter type file");
+		ksft_perror("Failed to open MC counter type file");
 
 		return -1;
 	}
-	if (fscanf(fp, "%u", &imc_counters_config[count][READ].type) <= 0) {
-		ksft_perror("Could not get iMC type");
+	if (fscanf(fp, "%u", &mc_counters_config[count][READ].type) <= 0) {
+		ksft_perror("Could not get MC type");
 		fclose(fp);
 
 		return -1;
 	}
 	fclose(fp);
 
-	imc_counters_config[count][WRITE].type =
-				imc_counters_config[count][READ].type;
+	mc_counters_config[count][WRITE].type =
+				mc_counters_config[count][READ].type;
 
 	/* Get read config */
-	sprintf(imc_counter_cfg, "%s%s", imc_dir, READ_FILE_NAME);
-	fp = fopen(imc_counter_cfg, "r");
+	sprintf(mc_counter_cfg, "%s%s", mc_dir, READ_FILE_NAME);
+	fp = fopen(mc_counter_cfg, "r");
 	if (!fp) {
-		ksft_perror("Failed to open iMC config file");
+		ksft_perror("Failed to open MC config file");
 
 		return -1;
 	}
 	if (fscanf(fp, "%s", cas_count_cfg) <= 0) {
-		ksft_perror("Could not get iMC cas count read");
+		ksft_perror("Could not get MC cas count read");
 		fclose(fp);
 
 		return -1;
@@ -171,15 +171,15 @@ static int read_from_imc_dir(char *imc_dir, int count)
 	get_event_and_umask(cas_count_cfg, count, READ);
 
 	/* Get write config */
-	sprintf(imc_counter_cfg, "%s%s", imc_dir, WRITE_FILE_NAME);
-	fp = fopen(imc_counter_cfg, "r");
+	sprintf(mc_counter_cfg, "%s%s", mc_dir, WRITE_FILE_NAME);
+	fp = fopen(mc_counter_cfg, "r");
 	if (!fp) {
-		ksft_perror("Failed to open iMC config file");
+		ksft_perror("Failed to open MC config file");
 
 		return -1;
 	}
 	if  (fscanf(fp, "%s", cas_count_cfg) <= 0) {
-		ksft_perror("Could not get iMC cas count write");
+		ksft_perror("Could not get MC cas count write");
 		fclose(fp);
 
 		return -1;
@@ -192,17 +192,18 @@ static int read_from_imc_dir(char *imc_dir, int count)
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
-	char imc_dir[512], *temp;
+	char mc_dir[512], *temp;
 	unsigned int count = 0;
 	struct dirent *ep;
 	int ret;
@@ -230,9 +231,9 @@ static int num_of_imcs(void)
 			 * first character is a numerical digit or not.
 			 */
 			if (temp[0] >= '0' && temp[0] <= '9') {
-				sprintf(imc_dir, "%s/%s/", DYN_PMU_PATH,
+				sprintf(mc_dir, "%s/%s/", DYN_PMU_PATH,
 					ep->d_name);
-				ret = read_from_imc_dir(imc_dir, count);
+				ret = read_from_mc_dir(mc_dir, count);
 				if (ret) {
 					closedir(dp);
 
@@ -243,7 +244,7 @@ static int num_of_imcs(void)
 		}
 		closedir(dp);
 		if (count == 0) {
-			ksft_print_msg("Unable to find iMC counters\n");
+			ksft_print_msg("Unable to find MC counters\n");
 
 			return -1;
 		}
@@ -256,55 +257,55 @@ static int num_of_imcs(void)
 	return count;
 }
 
-int initialize_mem_bw_imc(void)
+int initialize_mem_bw_mc(void)
 {
-	int imc, j;
+	int mc, j;
 
-	imcs = num_of_imcs();
-	if (imcs <= 0)
-		return imcs;
+	mcs = num_of_mem_controllers();
+	if (mcs <= 0)
+		return mcs;
 
-	/* Initialize perf_event_attr structures for all iMC's */
-	for (imc = 0; imc < imcs; imc++) {
+	/* Initialize perf_event_attr structures for all MC's */
+	for (mc = 0; mc < mcs; mc++) {
 		for (j = 0; j < 2; j++)
-			membw_initialize_perf_event_attr(imc, j);
+			membw_initialize_perf_event_attr(mc, j);
 	}
 
 	return 0;
 }
 
-static void perf_close_imc_mem_bw(void)
+static void perf_close_mc_mem_bw(void)
 {
 	int mc;
 
-	for (mc = 0; mc < imcs; mc++) {
-		if (imc_counters_config[mc][READ].fd != -1)
-			close(imc_counters_config[mc][READ].fd);
-		if (imc_counters_config[mc][WRITE].fd != -1)
-			close(imc_counters_config[mc][WRITE].fd);
+	for (mc = 0; mc < mcs; mc++) {
+		if (mc_counters_config[mc][READ].fd != -1)
+			close(mc_counters_config[mc][READ].fd);
+		if (mc_counters_config[mc][WRITE].fd != -1)
+			close(mc_counters_config[mc][WRITE].fd);
 	}
 }
 
 /*
- * perf_open_imc_mem_bw - Open perf fds for IMCs
+ * perf_open_mc_mem_bw - Open perf fds for MCs
  * @cpu_no: CPU number that the benchmark PID is binded to
  *
  * Return: = 0 on success. < 0 on failure.
  */
-static int perf_open_imc_mem_bw(int cpu_no)
+static int perf_open_mc_mem_bw(int cpu_no)
 {
-	int imc, ret;
+	int mc, ret;
 
-	for (imc = 0; imc < imcs; imc++) {
-		imc_counters_config[imc][READ].fd = -1;
-		imc_counters_config[imc][WRITE].fd = -1;
+	for (mc = 0; mc < mcs; mc++) {
+		mc_counters_config[mc][READ].fd = -1;
+		mc_counters_config[mc][WRITE].fd = -1;
 	}
 
-	for (imc = 0; imc < imcs; imc++) {
-		ret = open_perf_event(imc, cpu_no, READ);
+	for (mc = 0; mc < mcs; mc++) {
+		ret = open_perf_event(mc, cpu_no, READ);
 		if (ret)
 			goto close_fds;
-		ret = open_perf_event(imc, cpu_no, WRITE);
+		ret = open_perf_event(mc, cpu_no, WRITE);
 		if (ret)
 			goto close_fds;
 	}
@@ -312,7 +313,7 @@ static int perf_open_imc_mem_bw(int cpu_no)
 	return 0;
 
 close_fds:
-	perf_close_imc_mem_bw();
+	perf_close_mc_mem_bw();
 	return -1;
 }
 
@@ -322,21 +323,21 @@ static int perf_open_imc_mem_bw(int cpu_no)
  * Runs memory bandwidth test over one second period. Also, handles starting
  * and stopping of the IMC perf counters around the test.
  */
-static void do_imc_mem_bw_test(void)
+static void do_mc_mem_bw_test(void)
 {
-	int imc;
+	int mc;
 
-	for (imc = 0; imc < imcs; imc++) {
-		membw_ioctl_perf_event_ioc_reset_enable(imc, READ);
-		membw_ioctl_perf_event_ioc_reset_enable(imc, WRITE);
+	for (mc = 0; mc < mcs; mc++) {
+		membw_ioctl_perf_event_ioc_reset_enable(mc, READ);
+		membw_ioctl_perf_event_ioc_reset_enable(mc, WRITE);
 	}
 
 	sleep(1);
 
 	/* Stop counters after a second to get results (both read and write) */
-	for (imc = 0; imc < imcs; imc++) {
-		membw_ioctl_perf_event_ioc_disable(imc, READ);
-		membw_ioctl_perf_event_ioc_disable(imc, WRITE);
+	for (mc = 0; mc < mcs; mc++) {
+		membw_ioctl_perf_event_ioc_disable(mc, READ);
+		membw_ioctl_perf_event_ioc_disable(mc, WRITE);
 	}
 }
 
@@ -349,10 +350,10 @@ static void do_imc_mem_bw_test(void)
  *
  * Return: = 0 on success. < 0 on failure.
  */
-static int get_mem_bw_imc(const char *bw_report, float *bw_imc)
+static int get_mem_bw_mc(const char *bw_report, float *bw_mc)
 {
 	float reads, writes, of_mul_read, of_mul_write;
-	int imc;
+	int mc;
 
 	/* Start all iMC counters to log values (both read and write) */
 	reads = 0, writes = 0, of_mul_read = 1, of_mul_write = 1;
@@ -361,21 +362,21 @@ static int get_mem_bw_imc(const char *bw_report, float *bw_imc)
 	 * Get results which are stored in struct type imc_counter_config
 	 * Take overflow into consideration before calculating total bandwidth.
 	 */
-	for (imc = 0; imc < imcs; imc++) {
-		struct imc_counter_config *r =
-			&imc_counters_config[imc][READ];
-		struct imc_counter_config *w =
-			&imc_counters_config[imc][WRITE];
+	for (mc = 0; mc < mcs; mc++) {
+		struct mc_counter_config *r =
+			&mc_counters_config[mc][READ];
+		struct mc_counter_config *w =
+			&mc_counters_config[mc][WRITE];
 
 		if (read(r->fd, &r->return_value,
 			 sizeof(struct membw_read_format)) == -1) {
-			ksft_perror("Couldn't get read bandwidth through iMC");
+			ksft_perror("Couldn't get read bandwidth through MC");
 			goto close_fds;
 		}
 
 		if (read(w->fd, &w->return_value,
 			 sizeof(struct membw_read_format)) == -1) {
-			ksft_perror("Couldn't get write bandwidth through iMC");
+			ksft_perror("Couldn't get write bandwidth through MC");
 			goto close_fds;
 		}
 
@@ -396,23 +397,23 @@ static int get_mem_bw_imc(const char *bw_report, float *bw_imc)
 		writes += w->return_value.value * of_mul_write * SCALE;
 	}
 
-	perf_close_imc_mem_bw();
+	perf_close_mc_mem_bw();
 
 	if (strcmp(bw_report, "reads") == 0) {
-		*bw_imc = reads;
+		*bw_mc = reads;
 		return 0;
 	}
 
 	if (strcmp(bw_report, "writes") == 0) {
-		*bw_imc = writes;
+		*bw_mc = writes;
 		return 0;
 	}
 
-	*bw_imc = reads + writes;
+	*bw_mc = reads + writes;
 	return 0;
 
 close_fds:
-	perf_close_imc_mem_bw();
+	perf_close_mc_mem_bw();
 	return -1;
 }
 
@@ -523,19 +524,19 @@ static void parent_exit(pid_t ppid)
  * print_results_bw:	the memory bandwidth results are stored in a file
  * @filename:		file that stores the results
  * @bm_pid:		child pid that runs benchmark
- * @bw_imc:		perf imc counter value
+ * @bw_mc:		perf mc counter value
  * @bw_resc:		memory bandwidth value
  *
  * Return:		0 on success, < 0 on error.
  */
-static int print_results_bw(char *filename, pid_t bm_pid, float bw_imc,
+static int print_results_bw(char *filename, pid_t bm_pid, float bw_mc,
 			    unsigned long bw_resc)
 {
-	unsigned long diff = fabs(bw_imc - bw_resc);
+	unsigned long diff = fabs(bw_mc - bw_resc);
 	FILE *fp;
 
 	if (strcmp(filename, "stdio") == 0 || strcmp(filename, "stderr") == 0) {
-		printf("Pid: %d \t Mem_BW_iMC: %f \t ", (int)bm_pid, bw_imc);
+		printf("Pid: %d \t Mem_BW_MC: %f \t ", (int)bm_pid, bw_mc);
 		printf("Mem_BW_resc: %lu \t Difference: %lu\n", bw_resc, diff);
 	} else {
 		fp = fopen(filename, "a");
@@ -544,8 +545,8 @@ static int print_results_bw(char *filename, pid_t bm_pid, float bw_imc,
 
 			return -1;
 		}
-		if (fprintf(fp, "Pid: %d \t Mem_BW_iMC: %f \t Mem_BW_resc: %lu \t Difference: %lu\n",
-			    (int)bm_pid, bw_imc, bw_resc, diff) <= 0) {
+		if (fprintf(fp, "Pid: %d \t Mem_BW_MC: %f \t Mem_BW_resc: %lu \t Difference: %lu\n",
+			    (int)bm_pid, bw_mc, bw_resc, diff) <= 0) {
 			ksft_print_msg("Could not log results\n");
 			fclose(fp);
 
@@ -570,7 +571,7 @@ int measure_mem_bw(const struct user_params *uparams,
 {
 	unsigned long bw_resc, bw_resc_start, bw_resc_end;
 	FILE *mem_bw_fp;
-	float bw_imc;
+	float bw_mc;
 	int ret;
 
 	bw_report = get_bw_report_type(bw_report);
@@ -583,12 +584,12 @@ int measure_mem_bw(const struct user_params *uparams,
 
 	/*
 	 * Measure memory bandwidth from resctrl and from
-	 * another source which is perf imc value or could
-	 * be something else if perf imc event is not available.
+	 * another source which is perf mc value or could
+	 * be something else if perf mc event is not available.
 	 * Compare the two values to validate resctrl value.
 	 * It takes 1sec to measure the data.
 	 */
-	ret = perf_open_imc_mem_bw(uparams->cpu);
+	ret = perf_open_mc_mem_bw(uparams->cpu);
 	if (ret < 0)
 		goto close_fp;
 
@@ -598,13 +599,13 @@ int measure_mem_bw(const struct user_params *uparams,
 
 	rewind(mem_bw_fp);
 
-	do_imc_mem_bw_test();
+	do_mc_mem_bw_test();
 
 	ret = get_mem_bw_resctrl(mem_bw_fp, &bw_resc_end);
 	if (ret < 0)
 		goto close_fp;
 
-	ret = get_mem_bw_imc(bw_report, &bw_imc);
+	ret = get_mem_bw_mc(bw_report, &bw_mc);
 	if (ret < 0)
 		goto close_fp;
 
@@ -612,7 +613,7 @@ int measure_mem_bw(const struct user_params *uparams,
 
 	bw_resc = (bw_resc_end - bw_resc_start) / MB;
 
-	return print_results_bw(param->filename, bm_pid, bw_imc, bw_resc);
+	return print_results_bw(param->filename, bm_pid, bw_mc, bw_resc);
 
 close_fp:
 	fclose(mem_bw_fp);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 891ebfbfbd85..4f37278bc8e5 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -843,7 +843,7 @@ const char *get_bw_report_type(const char *bw_report)
 	if (strcmp(bw_report, "total") == 0)
 		return bw_report;
 
-	fprintf(stderr, "Requested iMC bandwidth report type unavailable\n");
+	fprintf(stderr, "Requested MC bandwidth report type unavailable\n");
 
 	return NULL;
 }
-- 
2.34.1


