Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672857C7C23
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 05:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjJMDcg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 23:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjJMDca (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 23:32:30 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EEEDE;
        Thu, 12 Oct 2023 20:32:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBiUYFincQ3FU4Q+nEg+M3x/pxvyQBK3dSVXvNe1YZsUB1vSqNAceZYCs4Ag7m9mWcPqteMPmo0r1K9nWVqklFemWpshtMA5VosT8QziB0pJpFRi7Ktl7zgXLaHA7j5sLtyySbyR+p2PM4LQ1O+ScpJmPKHVRJyQmRUlE9ZQ4zc/S91jHRoGTAqNlyECjFC/6EZMDEsxn9yoojdsuQMFrE257RdGRb6/bGuZcqazj7WN1kRQHz53U4oA43J/BxoHnoufJfYKjokm1y7uSn+d4ZD2fS5qpVSyuT1Sjoh8jLj+SPtiC7avom7cPs7o137cexjMVUtF+94mbypHGWR9Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SuMbf6ACdgD/VgAeB+bPtBTmro+WBzockk3k/tU4rM=;
 b=Pglis2W3HXX+4gM/gXSebLMEJ5o0MHqyt8UkAiPru2+dpTmi6PiywOlGDhLqTOq3p/RqwJI3+7/cmpZSxQeFNxosBUsmnhgBnbimGM34594nju/Ojb4yO78hyYxc/t3foBsHnHyvjrPc7fpLOOmP0dX8dLg4wRpDHWUk4TCYmB/I2w5gE4T4mQHySLy6m/lUZuWfNxmAeP/Zli3keNNsjj6hCgEWvXoFcPh324wjwbExb2LfkDv/IG2HbbiMZAemZ/bHqrGcbUUbggE7ki9Nleqc57hVwlKvzFXDgsGuAWe4Qy1Gtek8EnYJd9PWEljgdtYdX2cR2Q44zDhZQs4hOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SuMbf6ACdgD/VgAeB+bPtBTmro+WBzockk3k/tU4rM=;
 b=pWDdORRb9deFPiU/tSc0Oi/G6ta2xUQZpSyluyMdSvKPPncekofkzbuLIlVkTTJeICG9crngprjUzoamHv+zrQT55hfAane/L8ospoTwdd4b7XCOJ/4iPBi6AEz7vMYjyhU50YRFXGRnjy4pCveLep8HMA7HE9z7ImiMiPRkXVM=
Received: from SJ0PR05CA0027.namprd05.prod.outlook.com (2603:10b6:a03:33b::32)
 by SJ2PR12MB8876.namprd12.prod.outlook.com (2603:10b6:a03:539::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 03:32:21 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::58) by SJ0PR05CA0027.outlook.office365.com
 (2603:10b6:a03:33b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.21 via Frontend
 Transport; Fri, 13 Oct 2023 03:32:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 03:32:21 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 22:32:14 -0500
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
        Borislav Petkov <bp@alien8.de>,
        "Oleksandr Natalenko" <oleksandr@natalenko.name>,
        Meng Li <li.meng@amd.com>, Wyes Karny <wyes.karny@amd.com>
Subject: [RESEND PATCH V9 5/7] cpufreq: amd-pstate: Update amd-pstate preferred core ranking dynamically
Date:   Fri, 13 Oct 2023 11:31:16 +0800
Message-ID: <20231013033118.3759311-6-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013033118.3759311-1-li.meng@amd.com>
References: <20231013033118.3759311-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|SJ2PR12MB8876:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b60f3d3-bcbd-4af5-bf3f-08dbcb9d0279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6fER7IEqWc56zu08Odc3TN/KEC1XTMvLQ6FTBOUEEtTGSszW+r7x00tbEaaOxzwt6ZGAd67G43RFM2lIwmw+dKY/BoNJ6ss3Dvsvcc1NbAM6eRpokOlDah+D97Rm1Nz357Bvf1uHbhr1mea9x/2xsLmtpfIVKOZMexBS/9t7CZxF7q5uRpOiyY/gsf5aD4+uMVA3pl0WHqSw4UqtlvrDEei0lNDc5wkX8rOBRZ03I9AzBdOZQxI/2GqdJTqZEzBSJ1s7YJaSjIgDQUnvjg0OcLS19HaodKcKXKIiss9gyegY/oVmzFz8Wdhyym6rw/PQfEFLNaoL5iiI/KIvcP8Eu48gFSRArgbWg/C2noys4SFr229d14eIcm6e8+ZDqP3wBBLh67nOSQVEg8BGB7wK5Bt1Mj3YtQP4jbKuICFCpMyVx7zLSxcAeF1YHv+IvnhC9KTr48bwBoO19GRKU/f0fGdhqkPVnqmKEHaKVJtGAx4cKl0kM6pfsUySfG93xB3yQctaVwe5UFdckKH5/7ZRETErNaFQ75Grg9X7mGlAD6CkrUgEFN30nuTB+psy9nAsA58zQVHkNDR4AcA3oWfyY3Tx1nyZSL8yJX9y27AA7FwPX/6iF14MU3Yl1gZvtFb89wFEZbdI2vkl+8D57YFaEcd7Z+NCIAqxXZ0GeU4Z8lOb+HmHYCbzr1Lx+4Z36Ivbo116w2sgz9M4naJF+pNFNB6LvoDv/uTgDTPGJkXEaDNVM2aNwEOuHQqVCj0jBpiWlPVMikU9Dm5cnO71HfgO/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(7696005)(8936002)(8676002)(478600001)(5660300002)(41300700001)(26005)(336012)(1076003)(426003)(16526019)(2616005)(4326008)(70586007)(6636002)(316002)(54906003)(70206006)(110136005)(15650500001)(40460700003)(47076005)(36860700001)(66899024)(83380400001)(82740400003)(2906002)(40480700001)(81166007)(356005)(7416002)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 03:32:21.3331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b60f3d3-bcbd-4af5-bf3f-08dbcb9d0279
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8876
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Meng Li <li.meng@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 49 ++++++++++++++++++++++++++++++++++++
 include/linux/amd-pstate.h   |  6 +++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 6aae383990f1..3b054e3acba1 100644
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
@@ -763,6 +765,37 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
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
+		int prio;
+
+		WRITE_ONCE(cpudata->prefcore_ranking, cur_high);
+
+		/* The maximum value of highest perf is 255 */
+		prio = (int)(cur_high & 0xff);
+		sched_set_itmt_core_prio(prio, cpu);
+	}
+
+	cpufreq_cpu_put(policy);
+}
+
 static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 {
 	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
@@ -934,6 +967,17 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
 	return sysfs_emit(buf, "%u\n", perf);
 }
 
+static ssize_t show_amd_pstate_prefcore_ranking(struct cpufreq_policy *policy,
+						char *buf)
+{
+	u32 perf;
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	perf = READ_ONCE(cpudata->prefcore_ranking);
+
+	return sysfs_emit(buf, "%u\n", perf);
+}
+
 static ssize_t show_amd_pstate_hw_prefcore(struct cpufreq_policy *policy,
 					   char *buf)
 {
@@ -1147,6 +1191,7 @@ cpufreq_freq_attr_ro(amd_pstate_max_freq);
 cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
 
 cpufreq_freq_attr_ro(amd_pstate_highest_perf);
+cpufreq_freq_attr_ro(amd_pstate_prefcore_ranking);
 cpufreq_freq_attr_ro(amd_pstate_hw_prefcore);
 cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
@@ -1157,6 +1202,7 @@ static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
 	&amd_pstate_lowest_nonlinear_freq,
 	&amd_pstate_highest_perf,
+	&amd_pstate_prefcore_ranking,
 	&amd_pstate_hw_prefcore,
 	NULL,
 };
@@ -1165,6 +1211,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 	&amd_pstate_max_freq,
 	&amd_pstate_lowest_nonlinear_freq,
 	&amd_pstate_highest_perf,
+	&amd_pstate_prefcore_ranking,
 	&amd_pstate_hw_prefcore,
 	&energy_performance_preference,
 	&energy_performance_available_preferences,
@@ -1505,6 +1552,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.suspend	= amd_pstate_cpu_suspend,
 	.resume		= amd_pstate_cpu_resume,
 	.set_boost	= amd_pstate_set_boost,
+	.update_highest_perf	= amd_pstate_update_highest_perf,
 	.name		= "amd-pstate",
 	.attr		= amd_pstate_attr,
 };
@@ -1519,6 +1567,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
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

