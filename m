Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DB178BEC0
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Aug 2023 08:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjH2GpT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Aug 2023 02:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjH2Goy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Aug 2023 02:44:54 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on20620.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::620])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB54D19F;
        Mon, 28 Aug 2023 23:44:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ow2MoeXE/35QXPBgKdJ7KxfmkNhSYGhK+n4/0khmPi/nQqFGcDyKgbChuEVi+wsQYtGvsQYJ6gY1Bv1DWkyN8N8lDh0dX4KOXSageUO/8y+EduPDljUKMYlCu+Cl9kbcUjpLiIMya462taTu3RXi7cy0jaIhUzYxIM+Zrx9MViQwyIhx6mGjsCOW7DrzYalvAkEYjBbqsTadLvGp3kmP/S75HALuUopvS0ihM0vx7S3Ct7BGaO9YTm3wZLYnOCqDpA+/1faTI7CNY0d3lJb0LXU3c4ja4M2tdBwhWzA2F1Q+E+7dTst23UgJKLgATNjBfCvicH9VQASDinYKo5xlLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGE9Z3CKCeZhkNgYQhNbiYbp2LxV1MS47J2+x30zZV0=;
 b=H0gc3tL6gucvOdkI+SyoRrDcRG4nBVoxfnZWb6EYPeBUXLMaFv1rYQP/YxqkouOCzEvnovwoIclVTzAVaIRg9CXtXHT4m+IjJ07hw1GNZsFcRcENRPfOqF3A6u/OvbX2euWJR76kD9MaC/QTfFInc9fg8Qy0VLclG90mBsBnKhVFgjrZSzCYbOmy3c+IuXoO4QTRYkqOTb5jQ2reNzGCwavXYCBrxkjjl2P9v4br7rWM9k7T9+eb+Gl+/vypmEPg5SL1S0zoNkgpr1arISwVs0HtvPShC8Y+e08NMGDA8kwcU7o8T+WHRe/BVTjmgkOyISlhzl2iYVvXGgkOEivaMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGE9Z3CKCeZhkNgYQhNbiYbp2LxV1MS47J2+x30zZV0=;
 b=oRDaLqeWQD3w406LAS8vsFWyG0jCz8lDcU+FNRfTed2YsU+PKHC/5N7mmYSet7Ir28OMB/9rNmSLTEBqRXtUEVUkS480/+VXgpXCeRmS9N3ukv0dTCauhU1gEScxvNDPRH5yj2WxhJqkZtV0owZmHk3RqIjM2ntNXwaWPkC6Y2Y=
Received: from SJ0PR03CA0231.namprd03.prod.outlook.com (2603:10b6:a03:39f::26)
 by DS7PR12MB8417.namprd12.prod.outlook.com (2603:10b6:8:eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 06:44:43 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::9f) by SJ0PR03CA0231.outlook.office365.com
 (2603:10b6:a03:39f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34 via Frontend
 Transport; Tue, 29 Aug 2023 06:44:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Tue, 29 Aug 2023 06:44:42 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 01:44:28 -0500
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
Subject: [PATCH V4 5/7] cpufreq: amd-pstate: Update AMD Pstate Preferred Core ranking dynamically
Date:   Tue, 29 Aug 2023 14:43:38 +0800
Message-ID: <20230829064340.1136448-6-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829064340.1136448-1-li.meng@amd.com>
References: <20230829064340.1136448-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|DS7PR12MB8417:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ce05ff-722d-4604-1263-08dba85b6d0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3RlbJqRh/RQIZ/DzgwTfVNXaDerZrxtljRf+9LL0MXV66wia8PM7h6cOqbJSc2nnAy+sTeUzfgU/+j1P/WS+9UBB67ovdVeObKU6jmSiXbhCvqe122MeT2pkDYg2vXq2ceaagS4/fiWvuDDQsn7faiUnxY/nJH67TYQqRfVfLwf/GTnZvz93sKD7h8NWWhXMlW1Wzl8kW+QKJcqxsWmavQmMxPQiMZoIRGJ4DS+sVnYLxk6xvEXMx1n24wLaqykCrU3VE0HCUkub3RYWis0XBcvr2JFrLXopujgQKziK64fboen9EfFeudbX277k1RgAV//m2yVue9vcSC1BqYWkl9agf5d4pIe7By4OCzpcS5QtphGTys/PUY3pXc5XqqNtVTesgAzqSQxQ7Q6GC+6x/WlHj3kQD2rUWl4kRNwSYUkDc+ivMlJEk1/KJU6cXTMdmmTuwp/5Rtek8VGIFOAFZXGFzyOuSed30UclV/Cc6HsjI/QrJnRrHVQ6f/BICHvQJ2Z2Ou/pMGA4PtRyAqrCek0PzOJ5lsZ6DKPDJd0Hgwpnz23LaK+xL//J8IS8FYBCOJC/vvhoki9x1OjhrgBkNsjQ6lBqvK0bLcxTiHYVbiMG1GwSy7ms7lErHVqaVXOWqtzFxUhvEGEzcVAcxcQeDnVsW7KxdkG7x2Z6lrOostAvZv3c//rIlr9xmf83TdT1KCiv87QdSNNTOU2o2IwMNhX98LSZdgfu3xCaLqnaNd2/hT8BlvvtlKG+05nnaXjBA3UG6NtJftDcwLzZpdhkOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(186009)(451199024)(82310400011)(1800799009)(40470700004)(36840700001)(46966006)(40460700003)(15650500001)(41300700001)(336012)(26005)(81166007)(356005)(82740400003)(6666004)(86362001)(47076005)(478600001)(83380400001)(16526019)(1076003)(36860700001)(7696005)(40480700001)(426003)(2616005)(70206006)(70586007)(54906003)(110136005)(2906002)(316002)(6636002)(36756003)(8936002)(5660300002)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 06:44:42.6558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ce05ff-722d-4604-1263-08dba85b6d0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8417
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Preferred core rankings can be changed dynamically by the
platform based on the workload and platform conditions and
accounting for thermals and aging.
When this occurs, cpu priority need to be set.

Signed-off-by: Meng Li <li.meng@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 32 ++++++++++++++++++++++++++++++++
 include/linux/amd-pstate.h   |  1 +
 2 files changed, 33 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index d02305675f66..8a8e4ecb1b5c 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -315,6 +315,7 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
 	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
 	WRITE_ONCE(cpudata->lowest_perf, AMD_CPPC_LOWEST_PERF(cap1));
+	WRITE_ONCE(cpudata->prefcore_highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));
 
 	return 0;
 }
@@ -336,6 +337,7 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
 		   cppc_perf.lowest_nonlinear_perf);
 	WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
+	WRITE_ONCE(cpudata->prefcore_highest_perf, cppc_perf.highest_perf);
 
 	if (cppc_state == AMD_PSTATE_ACTIVE)
 		return 0;
@@ -744,6 +746,34 @@ static void amd_pstate_init_prefcore(void)
 	schedule_work(&sched_prefcore_work);
 }
 
+static void amd_pstate_update_highest_perf(unsigned int cpu)
+{
+	struct cpufreq_policy *policy;
+	struct amd_cpudata *cpudata;
+	u32 prev_high = 0, cur_high = 0;
+	u64 highest_perf;
+	int ret;
+
+	if (!prefcore)
+		return;
+
+	ret = amd_pstate_get_highest_perf(cpu, &highest_perf);
+	if (ret)
+		return;
+
+	policy = cpufreq_cpu_get(cpu);
+	cpudata = policy->driver_data;
+	cur_high = highest_perf;
+	prev_high = READ_ONCE(cpudata->prefcore_highest_perf);
+
+	if (prev_high != cur_high) {
+		WRITE_ONCE(cpudata->prefcore_highest_perf, cur_high);
+		sched_set_itmt_core_prio(cur_high, cpu);
+	}
+
+	cpufreq_cpu_put(policy);
+}
+
 static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 {
 	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
@@ -1468,6 +1498,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.suspend	= amd_pstate_cpu_suspend,
 	.resume		= amd_pstate_cpu_resume,
 	.set_boost	= amd_pstate_set_boost,
+	.update_highest_perf	= amd_pstate_update_highest_perf,
 	.name		= "amd-pstate",
 	.attr		= amd_pstate_attr,
 };
@@ -1482,6 +1513,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.online		= amd_pstate_epp_cpu_online,
 	.suspend	= amd_pstate_epp_suspend,
 	.resume		= amd_pstate_epp_resume,
+	.update_highest_perf	= amd_pstate_update_highest_perf,
 	.name		= "amd-pstate-epp",
 	.attr		= amd_pstate_epp_attr,
 };
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 446394f84606..fa86bc953d3e 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -70,6 +70,7 @@ struct amd_cpudata {
 	u32	nominal_perf;
 	u32	lowest_nonlinear_perf;
 	u32	lowest_perf;
+	u32     prefcore_highest_perf;
 
 	u32	max_freq;
 	u32	min_freq;
-- 
2.34.1

