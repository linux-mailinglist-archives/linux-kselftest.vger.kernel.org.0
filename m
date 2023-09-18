Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B087A4461
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Sep 2023 10:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238673AbjIRIRZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 04:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240775AbjIRIRC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 04:17:02 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A45E18E;
        Mon, 18 Sep 2023 01:15:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXCAJr1MTMWYG9xpMkvkVn+nNpkBxwfBErnUq1Fg0y+g4bhZj4m4vL0CNXrKH+aiUnS4/UNf0hR0roMuAVzh23CM5Rj5Y155se0QX4hUs5/y7nJcHpOpP4dxxyt9TPnZ8DGRi218pzl8BwYfsKPRTwcXy7Ixyrx6gYDHisTTQaZnE8i50sTQiDro+KupmPK7DIsGGD64DUFKN+Akl8HddA0pvxcvfZh4U5fk28AtiHF3kQ6c2xXgHUloICNRJ0h9C1ilCJ8kSxbQXABiBluHHXiNy5NEfswMfEIPZTufhIPSFqDDmKKEmLVZX2u30Pe+cQ865vq+erlARwU9nTwy0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIAdJ9pTVLx+1GG3IZErxB2L1anAOjNtkuO4W3BV0I8=;
 b=If/mKhn/3sENTe/wnOJKJUuSdxOtfJBS60/HdnpLTEIeF1Rw5r0Y1GWXqrsDQ9G1MDxYkIcThpfWMB6oJ9MuEW5tPKoU2eT6EXDkboTG1JrlwWYis9XhgeqcwAyw4tDxQ1muTGvrCVnYsd2wuhl2OMHacAHvfyI3Rrl+GQORPCkgyJdiOmH/Z7qdBGglhsiGNo7eRy6mnpuPTGjR/++sjTtGKY0GR0qe7XRjda1t8Ft7iGq7pSlHZuHo6hvqE5B3hkLhL25Bg3WkzDMOi2cR1JgDxpBDD6wwVJ4ziF3A5v8GORlHeeuEHWu8eD8i8qcYAR6I+It/Axp09UkByN6LcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIAdJ9pTVLx+1GG3IZErxB2L1anAOjNtkuO4W3BV0I8=;
 b=HfLxUdiez3G0vdWj3GXzo1TAK5K2enReCxv0fDQAcvQbSIwSd/AtG5gB98RUg8MKUTcbHCqe++zu60kyzX2WDgQbkrq76GgV4oB1wyeLv3MrrD1ldr9A1ewSKnwbkT0vlniixN1JdjdGQaKJHPCIcNBMHTjHJPrYE8y7Jmpk0mo=
Received: from SA9PR03CA0003.namprd03.prod.outlook.com (2603:10b6:806:20::8)
 by SA3PR12MB7858.namprd12.prod.outlook.com (2603:10b6:806:306::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 08:15:19 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:20:cafe::6a) by SA9PR03CA0003.outlook.office365.com
 (2603:10b6:806:20::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 08:15:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 08:15:19 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Sep
 2023 03:15:02 -0500
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
Subject: [PATCH V7 3/7] cpufreq: amd-pstate: Enable amd-pstate preferred core supporting.
Date:   Mon, 18 Sep 2023 16:14:03 +0800
Message-ID: <20230918081407.756858-4-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918081407.756858-1-li.meng@amd.com>
References: <20230918081407.756858-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|SA3PR12MB7858:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d24dfe1-5c7e-420c-c1f8-08dbb81f65fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a0lbouWNSUMRDH7AbQ08uhokUUqGxzje4TaIvqwnbAD2iVJOtl477rx7xAzDGoByDSf6hI1nCgSxkN42nO3N7oxKH+FHM4cJ52Y8fUEe7cwE+qUsRN4GRo+D0FLypIomUu8oqb7mG9l1qq1pLevJnbC/PVdReZqi3za44hNAHM8Thg8FhRejH6Q3Q4BVW06QO8SQp5VBiskBfl1I7pGcB6m+A8tl3hzYV3Njjwv3iJmYIDyRqDnzLZhyp8B6YJN/1MK5Pj7D+9uHUVk+DH4+OmCO+GXVg6GK7esV/KAJwbNSicKQECm/gF5FbBYQe95ZHGrULbjLdgGqrOIvemFtnYZgbQXEUkE8UJe7+OwNSpodgDWDGfc6azwj3wUUWb9irmIBZltR4PjW728e4dwp31tPcryy3e2WtdRnBcgjKGpu+qQ8+lA+BruiGbio6Xu9xWfdeqthjl8NWBD1kcgVO40jlCtJv7GmJuZIWzKbGMA8485c1s8a6YMFUO4GrwFYCaWpDw6LWr1mLOfqZR82ly1xR+RIb9p2D8h0XtGtBhso1KG4COnRzm/hCyJss4deDcDor/xbn8blcUdxaMlg9HwhUzT8HSWaQwvnRY7TL/cwxlSN0zTSTD4PkBlUw5cwYebeMoe3kcREK8Wcz3GKS85hKmg6SRVTJ9rX3aQ3pU12akfmONQvvHftsy4ptlZ6QNYE2VQ/NwCR+yWy4P6oTyfOQmhVtLBT4chrLsJJUUHtinvpBeUESWypbAst4V8I7LBm8jUAK4fvdJ59G/wMaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(82310400011)(1800799009)(186009)(451199024)(40470700004)(36840700001)(46966006)(7696005)(83380400001)(478600001)(26005)(2616005)(1076003)(16526019)(336012)(426003)(47076005)(2906002)(70206006)(54906003)(6636002)(70586007)(316002)(110136005)(8676002)(5660300002)(4326008)(8936002)(41300700001)(40460700003)(40480700001)(36860700001)(36756003)(82740400003)(356005)(86362001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 08:15:19.7123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d24dfe1-5c7e-420c-c1f8-08dbb81f65fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7858
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

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Co-developed-by: Perry Yuan <Perry.Yuan@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Signed-off-by: Meng Li <li.meng@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 163 +++++++++++++++++++++++++++++++----
 1 file changed, 147 insertions(+), 16 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9a1e194d5cf8..050e23594057 100644
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
+	if (hw_prefcore)
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
+	if (hw_prefcore)
+		WRITE_ONCE(cpudata->highest_perf, AMD_PSTATE_PREFCORE_THRESHOLD);
+	else
+		WRITE_ONCE(cpudata->highest_perf, cppc_perf.highest_perf);
 
 	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
@@ -676,6 +681,90 @@ static void amd_perf_ctl_reset(unsigned int cpu)
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
+	u64 cppc_highest_perf;
+
+	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+		u64 cap1;
+
+		ret = rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap1);
+		if (ret)
+			return ret;
+		WRITE_ONCE(*highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));
+	} else {
+		ret = cppc_get_highest_perf(cpu, &cppc_highest_perf);
+		*highest_perf = (u32)(cppc_highest_perf & 0xFFFF);
+	}
+
+	return (ret);
+}
+
+static void amd_pstate_init_prefcore(unsigned int cpu)
+{
+	int ret;
+	u32 highest_perf;
+	static u32 max_highest_perf = 0, min_highest_perf = U32_MAX;
+
+	if (!prefcore)
+		return;
+
+	ret = amd_pstate_get_highest_perf(cpu, &highest_perf);
+	if (ret)
+		return;
+
+	/*
+	 * The priorities can be set regardless of whether or not
+	 * sched_set_itmt_support(true) has been called and it is valid to
+	 * update them at any time after it has been called.
+	 */
+	sched_set_itmt_core_prio(highest_perf, cpu);
+
+	/* check if CPPC preferred core feature is enabled*/
+	if (highest_perf == AMD_PSTATE_MAX_CPPC_PERF) {
+		pr_debug("AMD CPPC preferred core is unsupported!\n");
+		hw_prefcore = false;
+		prefcore = false;
+		return;
+	}
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
@@ -697,6 +786,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	cpudata->cpu = policy->cpu;
 
+	amd_pstate_init_prefcore(policy->cpu);
+
 	ret = amd_pstate_init_perf(cpudata);
 	if (ret)
 		goto free_cpudata1;
@@ -763,6 +854,22 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	return ret;
 }
 
+static int amd_pstate_cpu_online(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	pr_debug("CPU %d going online\n", cpudata->cpu);
+
+	amd_pstate_init_prefcore(cpudata->cpu);
+
+	return 0;
+}
+
+static int amd_pstate_cpu_offline(struct cpufreq_policy *policy)
+{
+	return 0;
+}
+
 static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
@@ -1037,6 +1144,12 @@ static ssize_t status_store(struct device *a, struct device_attribute *b,
 	return ret < 0 ? ret : count;
 }
 
+static ssize_t prefcore_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n", prefcore ? "enabled" : "disabled");
+}
+
 cpufreq_freq_attr_ro(amd_pstate_max_freq);
 cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
 
@@ -1044,6 +1157,7 @@ cpufreq_freq_attr_ro(amd_pstate_highest_perf);
 cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
 static DEVICE_ATTR_RW(status);
+static DEVICE_ATTR_RO(prefcore);
 
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
@@ -1063,6 +1177,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 
 static struct attribute *pstate_global_attributes[] = {
 	&dev_attr_status.attr,
+	&dev_attr_prefcore.attr,
 	NULL
 };
 
@@ -1114,6 +1229,8 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	cpudata->cpu = policy->cpu;
 	cpudata->epp_policy = 0;
 
+	amd_pstate_init_prefcore(policy->cpu);
+
 	ret = amd_pstate_init_perf(cpudata);
 	if (ret)
 		goto free_cpudata1;
@@ -1285,6 +1402,8 @@ static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
 
 	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
 
+	amd_pstate_init_prefcore(cpudata->cpu);
+
 	if (cppc_state == AMD_PSTATE_ACTIVE) {
 		amd_pstate_epp_reenable(cpudata);
 		cpudata->suspended = false;
@@ -1389,6 +1508,8 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.fast_switch    = amd_pstate_fast_switch,
 	.init		= amd_pstate_cpu_init,
 	.exit		= amd_pstate_cpu_exit,
+	.offline	= amd_pstate_cpu_offline,
+	.online		= amd_pstate_cpu_online,
 	.suspend	= amd_pstate_cpu_suspend,
 	.resume		= amd_pstate_cpu_resume,
 	.set_boost	= amd_pstate_set_boost,
@@ -1527,7 +1648,17 @@ static int __init amd_pstate_param(char *str)
 
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

