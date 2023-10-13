Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B817C7BD0
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 04:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjJMC6n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 22:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjJMC6f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 22:58:35 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7066E113;
        Thu, 12 Oct 2023 19:58:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivDGmkUOy0g+BhFXmM7yJeaySjOCAjqbaRQqS/XoSvN7T6XCwe7UzZhgkqN0md9V1maRUPfoY21cLI9XiVlFHSIjeryjjbBSLBPhU3wxV6yQJpyux/whwTnovMcqLMoz3cEp3RIE0l11cbvNSTyxQu1JIY+gmV7NZaePKg2YRUPzC2L1CN2iRKjWAtF4VBdl40NoZnzo6h2M9NSAWxM+17MFpKxMofXRLjn1FyjKb6VMqH1F9blzAGg9rPOlnSNMwLDH8GfJT8B75vJFIbNWYs/tTSO1ljyetFRXCozSJtRZGlD0pGy6P9d2wDVtZehwcba6fy07/q555I9XjUN7cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpXE1rUl8nyODQwSd71k/trHjXcB687DjkPor+RwsC4=;
 b=cx7NzD0S98OeeIe3EJ9oujBWf+nH50onbWFjDL4bUcmfXLfZkt4+Gy9xmmWn1tcfUO0JSvaqFF4Tv+CS2XF2tRCEn+E6/+UXpLxdX7cttm4Dahnuiv0ITKh+y6ufeQfcP3d8KiUgK7mppkD4CQNmbg/ok6SgmMv3/oMhM9zlhW2TTvYDElTJFbr90nAuAclyzAFx8ETx4SVm2/+x4sHYCrPGUCFBO7i5KNqjkghUZa4lauK1g6dmctxRwPi/0rC8peq5J2kwDzBnsg+5ZxUL7+Ta9jz/mKlnWbrx6mljz2AdgywjNDWifT7FDA/mOxhEs6i/aDVGh57IQDNm5KOkXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpXE1rUl8nyODQwSd71k/trHjXcB687DjkPor+RwsC4=;
 b=mQx5WgaVSmE7chigFRgak542FG5c6VpU0XCxG7UeVACwi+ElrLgEjj39kf9n/WbVyMdsCP1HRDodUFXiV8fCICdXnVesJkpzpE0o7qgc2Wm0yhaEWJbY5QwyS1tf8DCHICLjAMw31niLYj0alfWABsiW8rKxU+zjtzvvvnFIw14=
Received: from MW4P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::23)
 by IA1PR12MB7518.namprd12.prod.outlook.com (2603:10b6:208:419::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 02:58:26 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::8b) by MW4P221CA0018.outlook.office365.com
 (2603:10b6:303:8b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29 via Frontend
 Transport; Fri, 13 Oct 2023 02:58:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 02:58:26 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 21:58:21 -0500
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
Subject: [PATCH V9 5/7] cpufreq: amd-pstate: Update amd-pstate preferred core ranking dynamically
Date:   Fri, 13 Oct 2023 10:57:39 +0800
Message-ID: <20231013025741.3332520-6-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013025741.3332520-1-li.meng@amd.com>
References: <20231013025741.3332520-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|IA1PR12MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: d64c1185-3dd1-4236-b8a4-08dbcb9845af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9f4OQuNbEjNx40mGK9l2g4tT+82i7JFIng5+WuwiWSmAb/chYj/6Jkj+54Fz6pmkWzZUzdl1IcLt4/Tw86IDzqJa8l7igV5SzMs3f9rsCTj6JBq4JCTg3czG+gFhN6YA9XJFdvpx8fwkNmRdx+TiwdlZASSxJ7KQi8+BlLqrd0A1K1mPayoNqhyi2sFVpiyTkyRuXUs3sXZ4rboSF4cAn813VyZewQwm/Dw4LfglU9uCHhVyHBuH+gFJb9U5l1XsFlhpf98CKXgNl47pqzJrW6TgMf93G9ifXMy37JsJmx1he3vkJpcBWTYkd9kmrvzzyAaxZk2pYFQXBQ9Txl0/lrN4HlA8EV1z58bsV+nOGKm5oPll8NQUpv33DWrIqMp2yAj0BLVBrX7IfzYZlLG9P6IHJtTpdCyZpVZGNcBJwx89m+LIdKms+njX00hPe1JOsKQMd/PWvE6OMAbyhMTBvLIRtTXY1N6xZC9FsjAhqFlzQFBNC2jnR2Qstuv3P6YIX124Qd1xCiWznRIAoxraHGOOijNaAjouaIwSdHwqZnWuPXchlmBoSnIYVeCVUPOswoKBuYJ+fPB8Ot85P3QByOJ6KfDKFoZ9bqVlECt0otTMcCimiSkNM15FWUgmFMHX+KMtZeplylCfuVvOLs3OuGz1ugP5vDB/l4yS5LJ1PItHDy6G9jJDuc6PAiqg9kF8VDFwYYKvLM58Yq7zIuXuLBxEKGvjDk69+ZmAycWx58+GegPfBnrw5cxnCrtF2kMpqZ8ZT6SurcgUjjQ7uo5e2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(82740400003)(36860700001)(356005)(16526019)(26005)(2616005)(81166007)(1076003)(5660300002)(8936002)(8676002)(4326008)(36756003)(7696005)(47076005)(426003)(336012)(83380400001)(478600001)(40460700003)(6666004)(40480700001)(316002)(54906003)(70206006)(6636002)(66899024)(70586007)(110136005)(7416002)(86362001)(2906002)(41300700001)(15650500001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 02:58:26.5949
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d64c1185-3dd1-4236-b8a4-08dbcb9845af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7518
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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
index 58aa9ddff29e..7e37d0d40ebd 100644
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
+		prio = (int)(highest_perf & 0xff);
+		sched_set_itmt_core_prio(cur_high, cpu);
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

