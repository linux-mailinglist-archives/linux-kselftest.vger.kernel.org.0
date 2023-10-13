Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E597D7C7C20
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 05:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjJMDc0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 23:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjJMDcW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 23:32:22 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3046106;
        Thu, 12 Oct 2023 20:32:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9nQQ9C4ktFWPBY7dHE089omn1+J6bxBLyxW3uugBQyxropnC/31MdBZX4nsDwheTO/kOBA5Fj8vTopk+TDel+pTR1TZU/mtoErhBJTwqOP2p3oljVrkI8xeX70uXID9HFfQhMxphG0eSVjvYuNYzrkkxOSuWXOfIpfirgF3XvpnIkIxt08Sdesxkbv0iuX2U+Sa+e12cgNxhiibSpBUunPFh0UBXKVDNR38WIo0lB2E2i+TJ3xFBAIxF4oE4M0+DoPQvlb3C95SHTttN0Je8iZ1Vygo0BVpu0SBw4iji6fy8saTFpXW0D49JzNZ3N/ulpoIJgCbd28rM88FOFYQbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6sl1hWJ/Ba/x5EvJmAWdUD/rhbznGTYZmFl2wYOADI=;
 b=XW8htGaL5w8suUKVtpJU97XsJLrb0Np3W35vVrriMNTZMQ7Tl1i2y+D0a5+TuHfpwsmOwhujQjCNeGJRH8Y7+1c4GIlCfGBe5VmQXtZksMtocIQFbPxjnx5nrVUTaJSEsM/5nISL8MBEve0mUJpEDA8ZJw5+8Hk8XTNeIMtEa5GeRi9h+kLs8mC8QG/w0NvU4JyKo6OMedJo8lSA0TZDyXV9HxG9z/h//vgPlcSWn6EuD2XGDHIwrMKXM8QAGTiA/JVF1HNdrITN3dm9D5zIAfArOTUiCHwdwFDTH/zBPrm0v77CgwZsx4r2vKznqZSdpMK4yArWDyP+r33pMJ8haA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6sl1hWJ/Ba/x5EvJmAWdUD/rhbznGTYZmFl2wYOADI=;
 b=Tn7OM818HKjTQgtQ10SnZFHs3WqNe0Y46udEIpH/cMD43IEeefUSZC+Ak5ie4fxKTSoM3rr6V4zX+ziRohmkw9yLvk8qoj/4rO7FJBSKk44vItLqQxYBImND4Az0zwruOVZfXaDdsegy9hlnLXvDoKjdZqvLVhuBc++78QVuySI=
Received: from SJ0PR05CA0024.namprd05.prod.outlook.com (2603:10b6:a03:33b::29)
 by DS7PR12MB6167.namprd12.prod.outlook.com (2603:10b6:8:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Fri, 13 Oct
 2023 03:32:12 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::d0) by SJ0PR05CA0024.outlook.office365.com
 (2603:10b6:a03:33b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.21 via Frontend
 Transport; Fri, 13 Oct 2023 03:32:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 03:32:11 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 22:31:56 -0500
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
Subject: [RESEND PATCH V9 3/7] cpufreq: amd-pstate: Enable amd-pstate preferred core supporting.
Date:   Fri, 13 Oct 2023 11:31:14 +0800
Message-ID: <20231013033118.3759311-4-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|DS7PR12MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b3cb6fd-f791-443d-c357-08dbcb9cfccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 35UO6xD5IuK4Rfoa9MVRYCpVYWoj8BaHDBcTntDU1o3Lqqlit8HtAABQRIf68k1R5Ukq0YVlpmBNCpH8z/n/cG8JM+w8bo6x96ud45QI1b5urVVxtTdJdZ1cUdNe9yZ08XLQlLe/spGcE0326MKgYk685e9QhKw1PQx+ehlZvfTqA7+cUuNWpIAH7+XOhlgcf7FIUHLBhdfUUIDhvsD1nGb3kIb4XCldNTUeMdZtH4XQxhp/u1M6aMGajpJVMkCRwtYtnxlo7EhDVn+hDUz1iJlLLJTUWZT97NBFw2/gBHVtu2Dz0ch2xHaV1ntNvf6pAMVYV+VYcgG0GEupzbLSlfuSy0L//YX8q8u55yqjl2H/xSyFJfCkhiQZMQhYpKX/e4a7hGV32bNrb3CWj94T9IdJd0yuBPXjYVe/bRxtcSMlCuZiJvnUtXxLjs+2QYd7oMftXtjo1l5oK2h9xTI542jj9h+StzaHKQuIkViYXKsn4/6jQTCdP7bIT+FV0iZhClWVBx9DPonjikCUM4bIXpjBU8yS4DIxQCq7Xcgjz/3DTrQjLAhhJI1davotk65GPQrLtegfiOoB2BHsiYV3MZyl1uBxTzZLCIsMceIHqKBLiK4VaLuirINNaRqfWLEdiQECb3vL/0rvV84pkoK4OL+CV5EgfzPc3TL/qJv2bGVW5Q0vSmtnn0OY4CSRr3MqIaiqQaQuaTk2bwjHs2Xb4+NlXsc5b1CBCQPorxrMbNTb0Xt0U2MLaeaGf1COMLLb0FATwr8kteCQ2eZc3lTN7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(2906002)(8676002)(8936002)(30864003)(5660300002)(7416002)(83380400001)(41300700001)(70586007)(316002)(6636002)(54906003)(70206006)(110136005)(478600001)(4326008)(6666004)(7696005)(40460700003)(2616005)(426003)(336012)(16526019)(26005)(36860700001)(47076005)(40480700001)(1076003)(356005)(36756003)(82740400003)(81166007)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 03:32:11.8330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3cb6fd-f791-443d-c357-08dbcb9cfccd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6167
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

amd-pstate driver utilizes the functions and data structures
provided by the ITMT architecture to enable the scheduler to
favor scheduling on cores which can be get a higher frequency
with lower voltage. We call it amd-pstate preferrred core.

Here sched_set_itmt_core_prio() is called to set priorities and
sched_set_itmt_support() is called to enable ITMT feature.
amd-pstate driver uses the highest performance value to indicate
the priority of CPU. The higher value has a higher priority.

The initial core rankings are set up by amd-pstate when the
system boots.

Add a variable hw_prefcore in cpudata structure. It will check
if the processor and power firmware support preferred core
feature.

Add one new early parameter `disable` to allow user to disable
the preferred core.

Only when hardware supports preferred core and user set `enabled`
in early parameter, amd pstate driver supports preferred core featue.

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Co-developed-by: Perry Yuan <Perry.Yuan@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Signed-off-by: Meng Li <li.meng@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 155 +++++++++++++++++++++++++++++++----
 include/linux/amd-pstate.h   |   4 +
 2 files changed, 143 insertions(+), 16 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9a1e194d5cf8..6aae383990f1 100644
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
@@ -64,6 +67,7 @@ static struct cpufreq_driver amd_pstate_driver;
 static struct cpufreq_driver amd_pstate_epp_driver;
 static int cppc_state = AMD_PSTATE_UNDEFINED;
 static bool cppc_enabled;
+static bool amd_pstate_prefcore = true;
 
 /*
  * AMD Energy Preference Performance (EPP)
@@ -290,23 +294,21 @@ static inline int amd_pstate_enable(bool enable)
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
+	if (cpudata->hw_prefcore)
+		WRITE_ONCE(cpudata->highest_perf, AMD_PSTATE_PREFCORE_THRESHOLD);
+	else
+		WRITE_ONCE(cpudata->highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));
 
 	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
@@ -318,17 +320,15 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
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
+	if (cpudata->hw_prefcore)
+		WRITE_ONCE(cpudata->highest_perf, AMD_PSTATE_PREFCORE_THRESHOLD);
+	else
+		WRITE_ONCE(cpudata->highest_perf, cppc_perf.highest_perf);
 
 	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
@@ -676,6 +676,93 @@ static void amd_perf_ctl_reset(unsigned int cpu)
 	wrmsrl_on_cpu(cpu, MSR_AMD_PERF_CTL, 0);
 }
 
+/*
+ * Set amd-pstate preferred core enable can't be done directly from cpufreq callbacks
+ * due to locking, so queue the work for later.
+ */
+static void amd_pstste_sched_prefcore_workfn(struct work_struct *work)
+{
+	sched_set_itmt_support();
+}
+static DECLARE_WORK(sched_prefcore_work, amd_pstste_sched_prefcore_workfn);
+
+/*
+ * Get the highest performance register value.
+ * @cpu: CPU from which to get highest performance.
+ * @highest_perf: Return address.
+ *
+ * Return: 0 for success, -EIO otherwise.
+ */
+static int amd_pstate_get_highest_perf(int cpu, u32 *highest_perf)
+{
+	int ret;
+
+	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+		u64 cap1;
+
+		ret = rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap1);
+		if (ret)
+			return ret;
+		WRITE_ONCE(*highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));
+	} else {
+		u64 cppc_highest_perf;
+
+		ret = cppc_get_highest_perf(cpu, &cppc_highest_perf);
+		WRITE_ONCE(*highest_perf, cppc_highest_perf);
+	}
+
+	return (ret);
+}
+
+static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
+{
+	int ret, prio;
+	u32 highest_perf;
+	static u32 max_highest_perf = 0, min_highest_perf = U32_MAX;
+
+	ret = amd_pstate_get_highest_perf(cpudata->cpu, &highest_perf);
+	if (ret)
+		return;
+
+	cpudata->hw_prefcore = true;
+	/* check if CPPC preferred core feature is enabled*/
+	if (highest_perf == AMD_PSTATE_MAX_CPPC_PERF) {
+		pr_debug("AMD CPPC preferred core is unsupported!\n");
+		cpudata->hw_prefcore = false;
+		return;
+	}
+
+	if (!amd_pstate_prefcore)
+		return;
+
+	/* The maximum value of highest perf is 255 */
+	prio = (int)(highest_perf & 0xff);
+	/*
+	 * The priorities can be set regardless of whether or not
+	 * sched_set_itmt_support(true) has been called and it is valid to
+	 * update them at any time after it has been called.
+	 */
+	sched_set_itmt_core_prio(prio, cpudata->cpu);
+
+	if (max_highest_perf <= min_highest_perf) {
+		if (highest_perf > max_highest_perf)
+			max_highest_perf = highest_perf;
+
+		if (highest_perf < min_highest_perf)
+			min_highest_perf = highest_perf;
+
+		if (max_highest_perf > min_highest_perf) {
+			/*
+			 * This code can be run during CPU online under the
+			 * CPU hotplug locks, so sched_set_itmt_support()
+			 * cannot be called from here.  Queue up a work item
+			 * to invoke it.
+			 */
+			schedule_work(&sched_prefcore_work);
+		}
+	}
+}
+
 static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 {
 	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
@@ -697,6 +784,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	cpudata->cpu = policy->cpu;
 
+	amd_pstate_init_prefcore(cpudata);
+
 	ret = amd_pstate_init_perf(cpudata);
 	if (ret)
 		goto free_cpudata1;
@@ -845,6 +934,17 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
 	return sysfs_emit(buf, "%u\n", perf);
 }
 
+static ssize_t show_amd_pstate_hw_prefcore(struct cpufreq_policy *policy,
+					   char *buf)
+{
+	bool hw_prefcore;
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	hw_prefcore = READ_ONCE(cpudata->hw_prefcore);
+
+	return sysfs_emit(buf, "%s\n", hw_prefcore ? "supported" : "unsupported");
+}
+
 static ssize_t show_energy_performance_available_preferences(
 				struct cpufreq_policy *policy, char *buf)
 {
@@ -1037,18 +1137,27 @@ static ssize_t status_store(struct device *a, struct device_attribute *b,
 	return ret < 0 ? ret : count;
 }
 
+static ssize_t prefcore_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n", amd_pstate_prefcore ? "enabled" : "disabled");
+}
+
 cpufreq_freq_attr_ro(amd_pstate_max_freq);
 cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
 
 cpufreq_freq_attr_ro(amd_pstate_highest_perf);
+cpufreq_freq_attr_ro(amd_pstate_hw_prefcore);
 cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
 static DEVICE_ATTR_RW(status);
+static DEVICE_ATTR_RO(prefcore);
 
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
 	&amd_pstate_lowest_nonlinear_freq,
 	&amd_pstate_highest_perf,
+	&amd_pstate_hw_prefcore,
 	NULL,
 };
 
@@ -1056,6 +1165,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 	&amd_pstate_max_freq,
 	&amd_pstate_lowest_nonlinear_freq,
 	&amd_pstate_highest_perf,
+	&amd_pstate_hw_prefcore,
 	&energy_performance_preference,
 	&energy_performance_available_preferences,
 	NULL,
@@ -1063,6 +1173,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 
 static struct attribute *pstate_global_attributes[] = {
 	&dev_attr_status.attr,
+	&dev_attr_prefcore.attr,
 	NULL
 };
 
@@ -1114,6 +1225,8 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	cpudata->cpu = policy->cpu;
 	cpudata->epp_policy = 0;
 
+	amd_pstate_init_prefcore(cpudata);
+
 	ret = amd_pstate_init_perf(cpudata);
 	if (ret)
 		goto free_cpudata1;
@@ -1527,7 +1640,17 @@ static int __init amd_pstate_param(char *str)
 
 	return amd_pstate_set_driver(mode_idx);
 }
+
+static int __init amd_prefcore_param(char *str)
+{
+	if (!strcmp(str, "disable"))
+		amd_pstate_prefcore = false;
+
+	return 0;
+}
+
 early_param("amd_pstate", amd_pstate_param);
+early_param("amd_prefcore", amd_prefcore_param);
 
 MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
 MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 446394f84606..87e140e9e6db 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -52,6 +52,9 @@ struct amd_aperf_mperf {
  * @prev: Last Aperf/Mperf/tsc count value read from register
  * @freq: current cpu frequency value
  * @boost_supported: check whether the Processor or SBIOS supports boost mode
+ * @hw_prefcore: check whether HW supports preferred core featue.
+ * 		  Only when hw_prefcore and early prefcore param are true,
+ * 		  AMD P-State driver supports preferred core featue.
  * @epp_policy: Last saved policy used to set energy-performance preference
  * @epp_cached: Cached CPPC energy-performance preference value
  * @policy: Cpufreq policy value
@@ -81,6 +84,7 @@ struct amd_cpudata {
 
 	u64	freq;
 	bool	boost_supported;
+	bool	hw_prefcore;
 
 	/* EPP feature related attributes*/
 	s16	epp_policy;
-- 
2.34.1

