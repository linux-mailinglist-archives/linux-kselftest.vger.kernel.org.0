Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7937E7BD21C
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 04:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345057AbjJICu5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Oct 2023 22:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345052AbjJICuz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Oct 2023 22:50:55 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345E1C5;
        Sun,  8 Oct 2023 19:50:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZZoQ8ovO6XNnTvPSCImnd7vIUbPQx8TV79HjD27EqjeEvsOC+cj6lBfU+LVm3XWOcua3myAivqPysTJbkJnfKdusaVzAr2hCdDDSWPyhuDUnT5JaJyGzZAu0g4WdLkzjx88cNkaimR7UhaW82eAD68HvfmkBWpkYnJzyJDRBm4Lme2+zpTwwidL4GcNY+gBtdOt0GwwRRQ58KTFd11Dj8kKHJ8yOUqkgal2B0z+ZDdRofYvxnlp/ag4PMkL0ZRVeiWCQuVDPPqB38qKGVQftrNobDyRIeffiiV/qyXh4ZQIZdpMvL2SGi6cFn6dbRq61MDPY+iSvPCK8wbttW5lRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suDPF+jeyHyeW96r+6eTe34BdnM0xUMLOfDEhPfEl3U=;
 b=e1/othshb3eCysD6tu5Azp5586IT1UfdClErVNSakJIseq7Exu0pRz6UKLDPxN40IVB8xzRpldkCII0YNO/I0eBNxs3Ctqi9TFPx3zXvgCAsesBcSiHqjARtDRJcOpbsWltnSml+Jr4P26BpcuI+BGDvSWeYQFBmD2QQsX9J8mVMJwo/VnkpX3SCGMmQNjqqLo8I4K6THqj9HfzsyL59kaXXNqa12lWsSP7YV21GP/sxV42t3EM2sgu7v/3Bk67Cpam4imfw+FBnRD2zOTp4yZwPCtKpPVIxLub1qE8ni92gjEQKr0a3IgUeC6g66RHbGuobVm3tPUHOJwoYO6s/4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suDPF+jeyHyeW96r+6eTe34BdnM0xUMLOfDEhPfEl3U=;
 b=kwcGlRW/d1WO6yb61gJ+s7VLP+sPZxj4UpAvTq0qVNXUPbSRlR4HMXOIe8D/FoUk64ydjRS1JRegb989DoQjuZI+d78aRJYVHjHEYBCZOECyiQEWs1W5RWoerQBkl6UI9IxnVS/njS47JooBj4jA35wyKwJOgo2X/zUXQHOHDl8=
Received: from MN2PR22CA0020.namprd22.prod.outlook.com (2603:10b6:208:238::25)
 by MW4PR12MB5666.namprd12.prod.outlook.com (2603:10b6:303:188::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 02:50:50 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::23) by MN2PR22CA0020.outlook.office365.com
 (2603:10b6:208:238::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Mon, 9 Oct 2023 02:50:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 02:50:50 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 8 Oct
 2023 21:50:44 -0500
From:   Meng Li <li.meng@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, <linux-acpi@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>,
        "Nathan Fontenot" <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        "Perry Yuan" <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, Meng Li <li.meng@amd.com>,
        Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH V8 5/7] cpufreq: amd-pstate: Update amd-pstate preferred core ranking dynamically
Date:   Mon, 9 Oct 2023 10:49:30 +0800
Message-ID: <20231009024932.2563622-6-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009024932.2563622-1-li.meng@amd.com>
References: <20231009024932.2563622-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|MW4PR12MB5666:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aabc7bd-f99d-4aef-96a6-08dbc8728bde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A52HU1fduQjBgxTPKCVRceY9qMxYINvoe6OAlYcieKo9GGFm/jUPez16mrA2kXO/2c+UbRzgeWURVCQsHXsprGdjHm1CzVdrz9eBCYctKs1K0WNELMKO08a09KWQLj6QviDrG9GEqhU1jPbNd5MVP1II/kBXeS6aCL7UPRhRnxajvp4aB3zmiBRPhmgUF9odmBrz3qp3tO3/fjg6S9zwMV68MfFlKUwH4RnGkKdOu4zCgXpV3CplUtFXS+v2rhTMdT0uNKKtVt14AI/ZmvtdclG3SV6VE8V2bWAwQYrWKAiztPrb6mF8weCi1Ab7Aw40JAUa2ghCieOsr48QiaH0g5Ig5vF5rAONQhljDXP7MkA83jeGbVlzswTeEeKrMcpmVib4IkqZr1JhIW2njr3KPdHoxQpC8RL4rB0V1ID8FYh2TQ/lOkuVrD9CkAxBtVn9CtLhKVIVco7cSBQ9HWGNHyqZOo1qVHCPaBwyEiz61AE+d16ZzfEw+rvoNqI37kLjvksSxYC/MKk2u6dbbqdnKrFYm14+7Z9/hJnatsRyYhrOvrYwZZwpL2L5dj4H3iW2sEcOuSLhNIIG3i699Cne+SjCLvo41A8dBAtw3IqOMBmzMioseG+bYY04kCuQmrY3wVqEGUcvYv94DQGXnw7FCM6GkeaDHrbnB0AIjSjzBdLh7GsY2US9cmylY7hMide+WScPeBxsJhBI31Z2pMM/VcY21qRiwjV0I/GgejOoZYl2MhtpDdcPuM7+tXR0wwxDHtMDelfeJROjn8nJ2pxzvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799009)(46966006)(40470700004)(36840700001)(40480700001)(66899024)(40460700003)(83380400001)(1076003)(2616005)(336012)(426003)(26005)(16526019)(47076005)(36860700001)(54906003)(70206006)(70586007)(110136005)(316002)(6636002)(8936002)(8676002)(4326008)(5660300002)(41300700001)(7696005)(6666004)(2906002)(15650500001)(82740400003)(478600001)(36756003)(356005)(81166007)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 02:50:50.1035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aabc7bd-f99d-4aef-96a6-08dbc8728bde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5666
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Preferred core rankings can be changed dynamically by the
platform based on the workload and platform conditions and
accounting for thermals and aging.
When this occurs, cpu priority need to be set.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Meng Li <li.meng@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 34 ++++++++++++++++++++++++++++++++--
 include/linux/amd-pstate.h   |  6 ++++++
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 6ac8939fce5a..d3369247c6c9 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -313,6 +313,7 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
 	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
 	WRITE_ONCE(cpudata->lowest_perf, AMD_CPPC_LOWEST_PERF(cap1));
+	WRITE_ONCE(cpudata->prefcore_ranking, AMD_CPPC_HIGHEST_PERF(cap1));
 
 	return 0;
 }
@@ -334,6 +335,7 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
 		   cppc_perf.lowest_nonlinear_perf);
 	WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
+	WRITE_ONCE(cpudata->prefcore_ranking, cppc_perf.highest_perf);
 
 	if (cppc_state == AMD_PSTATE_ACTIVE)
 		return 0;
@@ -540,7 +542,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	if (target_perf < capacity)
 		des_perf = DIV_ROUND_UP(cap_perf * target_perf, capacity);
 
-	min_perf = READ_ONCE(cpudata->highest_perf);
+	min_perf = READ_ONCE(cpudata->lowest_perf);
 	if (_min_perf < capacity)
 		min_perf = DIV_ROUND_UP(cap_perf * _min_perf, capacity);
 
@@ -760,6 +762,32 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
 	}
 }
 
+static void amd_pstate_update_highest_perf(unsigned int cpu)
+{
+	struct cpufreq_policy *policy;
+	struct amd_cpudata *cpudata;
+	u32 prev_high = 0, cur_high = 0;
+	int ret;
+
+	if ((!amd_pstate_prefcore) || (!cpudata->hw_prefcore))
+		return;
+
+	ret = amd_pstate_get_highest_perf(cpu, &cur_high);
+	if (ret)
+		return;
+
+	policy = cpufreq_cpu_get(cpu);
+	cpudata = policy->driver_data;
+	prev_high = READ_ONCE(cpudata->prefcore_ranking);
+
+	if (prev_high != cur_high) {
+		WRITE_ONCE(cpudata->prefcore_ranking, cur_high);
+		sched_set_itmt_core_prio(cur_high, cpu);
+	}
+
+	cpufreq_cpu_put(policy);
+}
+
 static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 {
 	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
@@ -926,7 +954,7 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
 	u32 perf;
 	struct amd_cpudata *cpudata = policy->driver_data;
 
-	perf = READ_ONCE(cpudata->highest_perf);
+	perf = READ_ONCE(cpudata->prefcore_ranking);
 
 	return sysfs_emit(buf, "%u\n", perf);
 }
@@ -1502,6 +1530,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.suspend	= amd_pstate_cpu_suspend,
 	.resume		= amd_pstate_cpu_resume,
 	.set_boost	= amd_pstate_set_boost,
+	.update_highest_perf	= amd_pstate_update_highest_perf,
 	.name		= "amd-pstate",
 	.attr		= amd_pstate_attr,
 };
@@ -1516,6 +1545,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.online		= amd_pstate_epp_cpu_online,
 	.suspend	= amd_pstate_epp_suspend,
 	.resume		= amd_pstate_epp_resume,
+	.update_highest_perf	= amd_pstate_update_highest_perf,
 	.name		= "amd-pstate-epp",
 	.attr		= amd_pstate_epp_attr,
 };
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 87e140e9e6db..426822612373 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -39,11 +39,16 @@ struct amd_aperf_mperf {
  * @cppc_req_cached: cached performance request hints
  * @highest_perf: the maximum performance an individual processor may reach,
  *		  assuming ideal conditions
+ *		  For platforms that do not support the preferred core feature, the
+ *		  highest_pef may be configured with 166 or 255, to avoid max frequency
+ *		  calculated wrongly. we take the fixed value as the highest_perf.
  * @nominal_perf: the maximum sustained performance level of the processor,
  *		  assuming ideal operating conditions
  * @lowest_nonlinear_perf: the lowest performance level at which nonlinear power
  *			   savings are achieved
  * @lowest_perf: the absolute lowest performance level of the processor
+ * @prefcore_ranking: the preferred core ranking, the higher value indicates a higher
+ * 		  priority.
  * @max_freq: the frequency that mapped to highest_perf
  * @min_freq: the frequency that mapped to lowest_perf
  * @nominal_freq: the frequency that mapped to nominal_perf
@@ -73,6 +78,7 @@ struct amd_cpudata {
 	u32	nominal_perf;
 	u32	lowest_nonlinear_perf;
 	u32	lowest_perf;
+	u32     prefcore_ranking;
 
 	u32	max_freq;
 	u32	min_freq;
-- 
2.34.1

