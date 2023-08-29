Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AAC78BEB9
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Aug 2023 08:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbjH2Gos (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Aug 2023 02:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjH2Goa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Aug 2023 02:44:30 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15B119B;
        Mon, 28 Aug 2023 23:44:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VayU2cQG8uSL2fJ9Odke+Frkofrzhl9hRu4d37r6foA4ZDdO/4FeNE2bOt83DGWG3E9hyD9f2+uDvDTwncOHllmdE4Tz7aBm1VhJazeeU4/8qnNzZBCKbaQDLpBUzAOxgM09ti2wAeuXzQSgrYwwMbA8bDIKMXtr5wy/HtI6Zhg2Tko17PcQPx4f9YoksQU1Z5G+FpfeHrFZRkbQ1RNY2ZldJnUZDVn2zkXANUCrz/q8lfpaX8ce0tN8eA6VPMmNUUo4O3MG7j6ZRJ+5cpZcdq+Gkm/1pKZ2MZFQy+vq/LJHjPcVTw8g0dlu+CfLKzBOv02LAGYAPl6v/OGIZq2WDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v09ZriuxTJzPZXCqmv5YJ34GxBxcpLyXQadhuYDbtzg=;
 b=fpcMksk1MoKa59C8gzvZ7JRCZdjSgJG52odWGeVBlxUNP2zyE9nRXKyULz8XPlZ2Psjp8cBsWjgkz5muDsLWbhNNM9A4zGcMpTYJBk149WdTN0lwXrjcchAHF5uZQVhlGQRjxHaXUsKh36zNVnHvJR11JLB36aOZgvmfPAogwXbMRevHyQP6wxXVrt0qynO1c4WAGRBcBK0Ttrds9TcWMbR/RNqZB6OansEYvmmXvpoP37qffn7ZZ72qE3x5qKPykx+dS/OzUUA0F+XEcoTJxpGaGdKO+kT6A4T4obXuGwCdP+fwIj8hJZ4+6qV0NyEJygAqIMMC4m/sxwIgzmEQGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v09ZriuxTJzPZXCqmv5YJ34GxBxcpLyXQadhuYDbtzg=;
 b=WWKbW9qAO5joxLYUDSK93v/QjuEGYQqTZtAuexbuwtJZ7Jq/EhYsXmaosq4bWCCD9ZNgXew31BfMsA9tHZ3hv9Hntw/2Vh134sum4c7s8V+Xx3emyGxNxof2lOyFDGsN8bMGbkdEJq31hsVgajYD0NHcORUiATlGuhIMe3daC+c=
Received: from SJ0PR03CA0386.namprd03.prod.outlook.com (2603:10b6:a03:3a1::31)
 by SN7PR12MB7934.namprd12.prod.outlook.com (2603:10b6:806:346::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 06:44:25 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::67) by SJ0PR03CA0386.outlook.office365.com
 (2603:10b6:a03:3a1::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34 via Frontend
 Transport; Tue, 29 Aug 2023 06:44:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 06:44:24 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 01:44:18 -0500
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
        Borislav Petkov <bp@alien8.de>, Meng Li <li.meng@amd.com>
Subject: [PATCH V4 3/7] cpufreq: amd-pstate: Enable AMD Pstate Preferred Core Supporting.
Date:   Tue, 29 Aug 2023 14:43:36 +0800
Message-ID: <20230829064340.1136448-4-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|SN7PR12MB7934:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f7ee472-09bf-48bc-2cc6-08dba85b625c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LGOTgxz8fmiMCNelQQlICo1rXMrD4kcf07/3Pxs/1cbWY+68nwD5QFGSlAWb5XACD6ff6T+b/QSplk5MUQQcthoxT3YLdimxMzN2vqu2GEtGcCEC8cRNhPBFyLpiUxQNHkmapkgrUpQqbGWmhqIdlq/6aiIsI7PTaFGHXs+OK5Bo6VYCPK8pULzpNDDS1MnuVk/8Y5F6fcJCp1XikfUpbL8hc6Ta64OgU9B8vGsoj/zmJrGi3Njdygj4gnrG1Bfab5igTqdHt6wSNyALl9oD+73SAhOiQO8Gm7s9PH3Vg4xInppI37Ul5f1LxAHiu0WcewPFGX7mTm+//iq2Zjsi/o/5SSmfIaTubMWwLq9EUIHRzc8meZf6Nm45fe8fMwqNBrQoyt//vWToL5jhCXoE837jXl8ekzOXjR4kqnmw9wtjERkl47UJdnF6kYNrexzNZphr7Ed7fYOy8uqyj+DALTE3pc8zeVCjNowLg8qmv54Bqlcg/wWrJ7jkbw+fr4JWrG3zthiOqrEu8O1Vp93ZFdwAWqdPPLl8l3RYabJw6o+B+1m8nV8P57eZPIMQnLlyFa7UmR4RLH7Pn3VhaOH1+xI6DifF1uFB5JFmB2fd2lOhvPYHDwIS7edamO9j0fvdHlgT5o1en1l5eqjOdj8QXzijAv3uUudmSARiWKlvSFSdBZ7VTqMXIQtItKef5mzPsQBYdAYp1bt26pJFUnv6QUhOyRrItKatieBYL5zDz/sBdwcRevhBktrsYiN9ZlTOm9vGaW9YqpNcC6rehyBrcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(1800799009)(82310400011)(186009)(451199024)(36840700001)(46966006)(40470700004)(478600001)(83380400001)(356005)(81166007)(82740400003)(26005)(16526019)(336012)(426003)(47076005)(36860700001)(1076003)(2616005)(40480700001)(7696005)(110136005)(6666004)(86362001)(6636002)(2906002)(316002)(8676002)(4326008)(5660300002)(70206006)(41300700001)(8936002)(36756003)(54906003)(70586007)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 06:44:24.7349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f7ee472-09bf-48bc-2cc6-08dba85b625c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7934
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

AMD Pstate driver utilizes the functions and data structures
provided by the ITMT architecture to enable the scheduler to
favor scheduling on cores which can be get a higher frequency
with lower voltage. We call it AMD Pstate Preferrred Core.

Here sched_set_itmt_core_prio() is called to set priorities and
sched_set_itmt_support() is called to enable ITMT feature.
AMD Pstate driver uses the highest performance value to indicate
the priority of CPU. The higher value has a higher priority.

The initial core rankings are set up by AMD Pstate when the
system boots.

Add device attribute for preferred core states.

Add one new early parameter `enable` to allow user to
enable the preferred core if the processor and power
firmware can support preferred core feature.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Co-developed-by: Perry Yuan <Perry.Yuan@amd.com>
Signed-off-by: Meng Li <li.meng@amd.com>
Co-developed-by: Meng Li <li.meng@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 120 ++++++++++++++++++++++++++++++-----
 1 file changed, 104 insertions(+), 16 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9a1e194d5cf8..d02305675f66 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -37,6 +37,7 @@
 #include <linux/uaccess.h>
 #include <linux/static_call.h>
 #include <linux/amd-pstate.h>
+#include <linux/topology.h>
 
 #include <acpi/processor.h>
 #include <acpi/cppc_acpi.h>
@@ -49,6 +50,8 @@
 
 #define AMD_PSTATE_TRANSITION_LATENCY	20000
 #define AMD_PSTATE_TRANSITION_DELAY	1000
+#define AMD_PSTATE_PREFCORE_THRESHOLD	166
+#define AMD_PSTATE_MAX_CPPC_PERF	255
 
 /*
  * TODO: We need more time to fine tune processors with shared memory solution
@@ -65,6 +68,9 @@ static struct cpufreq_driver amd_pstate_epp_driver;
 static int cppc_state = AMD_PSTATE_UNDEFINED;
 static bool cppc_enabled;
 
+/*Preferred Core featue is supported*/
+static bool prefcore = true;
+
 /*
  * AMD Energy Preference Performance (EPP)
  * The EPP is used in the CCLK DPM controller to drive
@@ -290,23 +296,21 @@ static inline int amd_pstate_enable(bool enable)
 static int pstate_init_perf(struct amd_cpudata *cpudata)
 {
 	u64 cap1;
-	u32 highest_perf;
 
 	int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
 				     &cap1);
 	if (ret)
 		return ret;
 
-	/*
-	 * TODO: Introduce AMD specific power feature.
-	 *
-	 * CPPC entry doesn't indicate the highest performance in some ASICs.
+	/* For platforms that do not support the preferred core feature, the
+	 * highest_pef may be configured with 166 or 255, to avoid max frequency
+	 * calculated wrongly. we take the AMD_CPPC_HIGHEST_PERF(cap1) value as
+	 * the default max perf.
 	 */
-	highest_perf = amd_get_highest_perf();
-	if (highest_perf > AMD_CPPC_HIGHEST_PERF(cap1))
-		highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
-
-	WRITE_ONCE(cpudata->highest_perf, highest_perf);
+	if (prefcore)
+		WRITE_ONCE(cpudata->highest_perf, AMD_PSTATE_PREFCORE_THRESHOLD);
+	else
+		WRITE_ONCE(cpudata->highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));
 
 	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
@@ -318,17 +322,15 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
 static int cppc_init_perf(struct amd_cpudata *cpudata)
 {
 	struct cppc_perf_caps cppc_perf;
-	u32 highest_perf;
 
 	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
 	if (ret)
 		return ret;
 
-	highest_perf = amd_get_highest_perf();
-	if (highest_perf > cppc_perf.highest_perf)
-		highest_perf = cppc_perf.highest_perf;
-
-	WRITE_ONCE(cpudata->highest_perf, highest_perf);
+	if (prefcore)
+		WRITE_ONCE(cpudata->highest_perf, AMD_PSTATE_PREFCORE_THRESHOLD);
+	else
+		WRITE_ONCE(cpudata->highest_perf, cppc_perf.highest_perf);
 
 	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
@@ -676,6 +678,72 @@ static void amd_perf_ctl_reset(unsigned int cpu)
 	wrmsrl_on_cpu(cpu, MSR_AMD_PERF_CTL, 0);
 }
 
+/*
+ * Set AMD Pstate Preferred Core enable can't be done directly from cpufreq callbacks
+ * due to locking, so queue the work for later.
+ */
+static void amd_pstste_sched_prefcore_workfn(struct work_struct *work)
+{
+	sched_set_itmt_support();
+}
+static DECLARE_WORK(sched_prefcore_work, amd_pstste_sched_prefcore_workfn);
+
+/**
+ * Get the highest performance register value.
+ * @cpu: CPU from which to get highest performance.
+ * @highest_perf: Return address.
+ *
+ * Return: 0 for success, -EIO otherwise.
+ */
+static int amd_pstate_get_highest_perf(int cpu, u64 *highest_perf)
+{
+       int ret;
+
+       if (boot_cpu_has(X86_FEATURE_CPPC)) {
+               u64 cap1;
+
+               ret = rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap1);
+               if (ret)
+                       return ret;
+               WRITE_ONCE(*highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));
+       } else {
+               ret = cppc_get_highest_perf(cpu, highest_perf);
+       }
+
+       return (ret);
+}
+
+static void amd_pstate_init_prefcore(void)
+{
+	int cpu, ret;
+	u64 highest_perf;
+
+	if (!prefcore)
+		return;
+
+	for_each_online_cpu(cpu) {
+		ret = amd_pstate_get_highest_perf(cpu, &highest_perf);
+		if (ret)
+			break;
+
+		sched_set_itmt_core_prio(highest_perf, cpu);
+
+		/* check if CPPC preferred core feature is enabled*/
+		if (highest_perf == AMD_PSTATE_MAX_CPPC_PERF) {
+			prefcore = false;
+			return;
+		}
+	}
+
+	/*
+	 * This code can be run during CPU online under the
+	 * CPU hotplug locks, so sched_set_amd_prefcore_support()
+	 * cannot be called from here.  Queue up a work item
+	 * to invoke it.
+	 */
+	schedule_work(&sched_prefcore_work);
+}
+
 static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 {
 	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
@@ -1037,6 +1105,12 @@ static ssize_t status_store(struct device *a, struct device_attribute *b,
 	return ret < 0 ? ret : count;
 }
 
+static ssize_t prefcore_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n", prefcore ? "enabled" : "disabled");
+}
+
 cpufreq_freq_attr_ro(amd_pstate_max_freq);
 cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
 
@@ -1044,6 +1118,7 @@ cpufreq_freq_attr_ro(amd_pstate_highest_perf);
 cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
 static DEVICE_ATTR_RW(status);
+static DEVICE_ATTR_RO(prefcore);
 
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
@@ -1063,6 +1138,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 
 static struct attribute *pstate_global_attributes[] = {
 	&dev_attr_status.attr,
+	&dev_attr_prefcore.attr,
 	NULL
 };
 
@@ -1506,6 +1582,8 @@ static int __init amd_pstate_init(void)
 		}
 	}
 
+	amd_pstate_init_prefcore();
+
 	return ret;
 
 global_attr_free:
@@ -1527,7 +1605,17 @@ static int __init amd_pstate_param(char *str)
 
 	return amd_pstate_set_driver(mode_idx);
 }
+
+static int __init amd_prefcore_param(char *str)
+{
+	if (!strcmp(str, "disable"))
+		prefcore = false;
+
+	return 0;
+}
+
 early_param("amd_pstate", amd_pstate_param);
+early_param("amd_prefcore", amd_prefcore_param);
 
 MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
 MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");
-- 
2.34.1

