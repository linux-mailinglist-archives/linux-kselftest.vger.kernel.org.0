Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095A479274C
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 18:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239138AbjIEQHY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 12:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245114AbjIEBwJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Sep 2023 21:52:09 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C7BCC5;
        Mon,  4 Sep 2023 18:52:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQ8i0uYqRpXnnSXLfwpbtGFKAaz2RnQ0QBQqk2BBPzdxkx71igLIJ3mtyfvildwCoTtLzF1qNwXyx8LHDubB0Hk9kC2eE0lU5dQSLG52q7VbZLZM258BDoLpPULiZokHQuw9IEwZ7LzoKgF8dEzQ/QQ/yT7xJREySGgQmHx3t3v41KqTd5yqWwPlX7fEb3SELddiFnbD0kdavZb3g1S6jaxn9zS1CCIbdpL1TmjYrR0Ubx0+Tg1CgcrN/3z6tRfFl/x1Q7me7hEGdvLA+JDMDzRqgML/53rZQYwgcH83c75+uZQLfKFTC3QqmPA4ZJVwWZ2PGxqzHagBIcBoDznjmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZojjejNblWxrqDVndVRwNnvgOFQu0K0POyqKUNezu8=;
 b=cj8ENw2Tvww3vv873N4h8PnCM7PUv3B0mOwRPUH0ovyPsNNgobGzmZ6DUlWcR8UCMLN+jEOASWTlG6zTCw7H29BsEJyli/Ur+4SSATt1+A6M17D80UajOlu+5sRgS0F3uLcJiLdDttkJEiGe2Li7MiRhQT/y3TBzJ3agzSdKRPjLw/ovCRsLW7diO5OyhWtjl+2kMUdepqHZPaZ6ddjd7wB9CpbixtFz+fUUSh6Pyloq/+xggjJ4v7Rynoblk0xgM9VTHcqzar/iAqbiHetUsRDPC1l2y7N2JQZRjftscWN9fJOy+29i9ON6WQbOZY12FBZf+X/nVLugr0ebG22epw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZojjejNblWxrqDVndVRwNnvgOFQu0K0POyqKUNezu8=;
 b=JoVl0IcLWejJjoJayDo4tIVoUYxZQT+UYfXo0YKMM2m4jcEGfsDSSaRQDoG4P7VpwHZ16AHa1V3d/13HM/FwLrvHYt8kjvI9vIWFCATCLpOUWGnKmmk0o6JqvfSA4G7q52Fy82QM4IUkh5xMiASaTrNVN6VNzyqLTiOkvTt5410=
Received: from CY8PR02CA0003.namprd02.prod.outlook.com (2603:10b6:930:4d::10)
 by SA1PR12MB6920.namprd12.prod.outlook.com (2603:10b6:806:258::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 01:52:02 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:930:4d:cafe::eb) by CY8PR02CA0003.outlook.office365.com
 (2603:10b6:930:4d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Tue, 5 Sep 2023 01:52:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 01:52:02 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 4 Sep
 2023 20:51:57 -0500
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
Subject: [PATCH V5 3/7] cpufreq: amd-pstate: Enable amd-pstate preferred core supporting.
Date:   Tue, 5 Sep 2023 09:51:12 +0800
Message-ID: <20230905015116.2268926-4-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905015116.2268926-1-li.meng@amd.com>
References: <20230905015116.2268926-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|SA1PR12MB6920:EE_
X-MS-Office365-Filtering-Correlation-Id: 6858568d-bd99-4f85-1966-08dbadb2b332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1FV8OmDTOy0OxgSC/M4fSv7rT7J3gBeGwfmp31Yah4CwfHXZ0ZmrKdNLvGEkDmjanZNkp81JIOoW1uRixF1rnEYvnp7aZjZA203CM38w8PUMrg3yDJNObF2h74ClyHDUFs8xifKWBHgHAivKZJs/j5d9CK8SMv2+Z00+VJprFa1kmW2PReccF6rR9EoA/ueEVyQJhj7c2XqQMTZR9PsVEpuptWxNIgwkKFuWtuUVn1b1bUboX85M+nuTbDnEC04JLcEM4f/4LOEc6Zahlg2BqE5H2/gUCXZBogTDKQTBIcixWrl/Hyn/5q8Oz8pfCwR+a266yI5n2d1UfZFRmvy+FjrB/0Z3lTe2TI5F4xlfHEZEEj/V2o2a2Ai8gnAAH2lgcuwIi5zyNIaTNdUP0hdS0F4zEGWO3QRZJnMU5P6ZrYk8KWBRXHOyOIr9/oR7YXS4mJM2CYU4Hjrxi7YZOigPCXgQAFleuK22Yamrd/ZE+z3TQBhw8PWPXUHnd10CRLS1mRyopzKLl/AKBxmDsMOkkyOBk+AFWI+1pHo4kKlpl6qTTyRUg6iBtPdi8OeMmCZ8DbVQolVjMlOjt6Q74/0iStveoBlVfnv70vDLnZkopr93hhfV9Tea1faJCgdnWBxCMxR1gpUXDtkuHy5il16D4tZ2jF3Fud4HNo08gQoBrAPyw76uHszR/k6bN1dodKXg3f3I1ssOpHZKy2UVpx0cO3yunWOYz0ysr+/NxFnCC8IUIh9n0n3iqnXqDMKePwW8NkjFzEOJaF9V3+paPQOfFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(1800799009)(82310400011)(186009)(451199024)(36840700001)(46966006)(40470700004)(36860700001)(40460700003)(47076005)(2906002)(36756003)(86362001)(81166007)(356005)(82740400003)(40480700001)(1076003)(4326008)(6666004)(8936002)(8676002)(2616005)(26005)(5660300002)(16526019)(110136005)(7696005)(70206006)(41300700001)(316002)(70586007)(54906003)(6636002)(426003)(336012)(83380400001)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 01:52:02.4152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6858568d-bd99-4f85-1966-08dbadb2b332
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6920
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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

Add device attribute for hardware preferred core. It will check
if the processor and power firmware support preferred core
feature.

Add device attribute for preferred core. Only when hardware
supports preferred core and user set `enabled` in early parameter,
it can be set to enabled.

Add one new early parameter `disable` to allow user to disable
the preferred core.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Co-developed-by: Perry Yuan <Perry.Yuan@amd.com>
Signed-off-by: Meng Li <li.meng@amd.com>
Co-developed-by: Meng Li <li.meng@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 131 ++++++++++++++++++++++++++++++-----
 1 file changed, 115 insertions(+), 16 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9a1e194d5cf8..454eb6e789e7 100644
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
@@ -65,6 +68,12 @@ static struct cpufreq_driver amd_pstate_epp_driver;
 static int cppc_state = AMD_PSTATE_UNDEFINED;
 static bool cppc_enabled;
 
+/*HW preferred Core featue is supported*/
+static bool hw_prefcore = true;
+
+/*Preferred Core featue is supported*/
+static bool prefcore = true;
+
 /*
  * AMD Energy Preference Performance (EPP)
  * The EPP is used in the CCLK DPM controller to drive
@@ -290,23 +299,21 @@ static inline int amd_pstate_enable(bool enable)
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
@@ -318,17 +325,15 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
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
@@ -676,6 +681,73 @@ static void amd_perf_ctl_reset(unsigned int cpu)
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
+static int amd_pstate_get_highest_perf(int cpu, u64 *highest_perf)
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
+		ret = cppc_get_highest_perf(cpu, highest_perf);
+	}
+
+	return (ret);
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
+			hw_prefcore = false;
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
@@ -1037,6 +1109,18 @@ static ssize_t status_store(struct device *a, struct device_attribute *b,
 	return ret < 0 ? ret : count;
 }
 
+static ssize_t hw_prefcore_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n", hw_prefcore ? "supported" : "unsupported");
+}
+
+static ssize_t prefcore_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n", prefcore ? "enabled" : "disabled");
+}
+
 cpufreq_freq_attr_ro(amd_pstate_max_freq);
 cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
 
@@ -1044,6 +1128,8 @@ cpufreq_freq_attr_ro(amd_pstate_highest_perf);
 cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
 static DEVICE_ATTR_RW(status);
+static DEVICE_ATTR_RO(hw_prefcore);
+static DEVICE_ATTR_RO(prefcore);
 
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
@@ -1063,6 +1149,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 
 static struct attribute *pstate_global_attributes[] = {
 	&dev_attr_status.attr,
+	&dev_attr_prefcore.attr,
 	NULL
 };
 
@@ -1506,6 +1593,8 @@ static int __init amd_pstate_init(void)
 		}
 	}
 
+	amd_pstate_init_prefcore();
+
 	return ret;
 
 global_attr_free:
@@ -1527,7 +1616,17 @@ static int __init amd_pstate_param(char *str)
 
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

