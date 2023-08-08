Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2964774011
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 18:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbjHHQ7D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 12:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbjHHQ6C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 12:58:02 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062f.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3874C24;
        Tue,  8 Aug 2023 08:42:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpkgdZ0Ql4NCJWokkjfehm/+gq6HI4xaKGD3t5A0UGF6DAnNakr/ggQcxhdb+mtYLfqH3sBuPRZdt5CMY+/m79sz0D9SGyctfGSJjOTAaUBXLXoINSFf9ZZmjl4ijaimreOHz/Jbdf3nvXeMqYtABJTvn0020TYyeBLZCOpA/ZpfBmoNlnLW5kn9lhIMu3a+D32LgbaROANNFku3Gpd8H6YtQ3Z6r856Yu5u9q/D6Ez8eAFCFgt8Iz/+Sf9MLEBfn65C+qj5Zckxs8Oc5U6uQkgBrW2hxzBCLv84Kc1d/ofQoPTzVZjqmuHgws2vrPgy3XvBaJ4bTlXVyi0nv5hawQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsyqA62MZR9bkZThhpl4P5rKC1QgivxxaMBjg0hDvzI=;
 b=PYL4Ax6ZSchoYgAjLNxOUACW2+ZVT+BLBjrmup/ni8o8tECb5fMXEhWzPPGdbCk9nsBxRal/cTjmn7VAgSsJmbAaRbJ/Sw0a1KJOUjH9Y+U+sC23aXWMzzZ4bZL/SE/2PlW4JKlyK6EceFWseADxa+xboCa0W/CSU1xCgmnMmVY819jp3ESysuN1mb+NnC3IP7xCLLN8uF3S186n9+pFI1Y79jhZd+v/Qkxq/XVaCz+Cd6qs/MomJu3o/PF2HC9vN7LcTR96jX5tbVKqQdkGpa8E9g34OKoIVZ614QM/xkJZeNGmudHq0+M+YJ6ASXULp7cUFbGV54UMH4U4hLj1NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsyqA62MZR9bkZThhpl4P5rKC1QgivxxaMBjg0hDvzI=;
 b=oIaAoBm+CzaenP7WCPq0vMCBpTZL/0fg6TbkIk4a1B1NtErd2Ixa/rJE5h5/Jw0eQ9ZUUzd1hK7cNcLjA7o9IlyZ0DUj29gO6a5ESevgDGUZ2g1LF7stDMCnohpFzaomRI2xNrB5Rt/gsE0hiwEqlrnzbFPhAqkOaxygju2g2wU=
Received: from SJ0PR05CA0092.namprd05.prod.outlook.com (2603:10b6:a03:334::7)
 by MN0PR12MB6175.namprd12.prod.outlook.com (2603:10b6:208:3c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Tue, 8 Aug
 2023 08:11:02 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:334:cafe::d3) by SJ0PR05CA0092.outlook.office365.com
 (2603:10b6:a03:334::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.16 via Frontend
 Transport; Tue, 8 Aug 2023 08:11:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 08:11:05 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 03:10:58 -0500
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
Subject: [PATCH V1 2/6] cpufreq: amd-pstate: Enable AMD Pstate Preferred Core Supporting.
Date:   Tue, 8 Aug 2023 16:09:57 +0800
Message-ID: <20230808081001.2215240-3-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808081001.2215240-1-li.meng@amd.com>
References: <20230808081001.2215240-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|MN0PR12MB6175:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c82bbb8-3651-415e-3dc8-08db97e703bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O5XrBHQL/jjjGFLx5WkD7gL4gfjrOMx5CLxOMm5xWKNfnYu5ZPWKo/hXLt8WSVGfLOFRlWEP/IqyW6XHhRWwPZULgIcB32tecW9e9oqcl0etNeoSB+J1rzj0RyFAZT1XC5sbr37hG7SyuzuW3qLr3mL9LhciEmic0Q6CV4x+4hClIUfUbJLhFeRlRE9/Lq5Y57Aij3a+N/CZkI820u9mJGDLLrKnQ2fg7h5vDOP4V2urcFxEpRwMpY65BNAHgHZhWaTm0yGqArh6mLv8NYUXOnwvOpXAOYBXYuJ/mdM3MWpB8F5bJi+/bCQWCMn1TZ4pPaOYyjpmoHm1JzvQA2sPfIlA88clbwZkq5FxYZZuyiqDmvS6ngRKHhCSCqhtmiELhRCtzK9SJjtdHH3hINzwq7mAFXT+wcDTMcFhdZk+v3S0GSAEbVKkCkr+eV144yMI2PdgT8bH2Ks0EE6wD/8K3ZGiYsojmP2I3f2QuNRsWVILXaps/0G2wi0KkI3r58OnMGjTcqR7VbSzYCKC7PcmcNmFIgrBAzGoEfoFtar4IEB5ONXpDCebxG+B0rROlw3dZRVjvI2VUSiuFVxSB1z+PYm565+PjUBA8MjOE/4EH3uPcyapSpuY3KZwIRNguCdWqU3bVgwhSkojBWNHgjTL2InE6MzfLKyJMUpFJ/ox+bSoXsUKW+0z2kEFus85Mv7Lg8yRhozVVxskbp+bNSS13zbNzPEmzp6SRphzxOQycVI8ckv8v1UGW6uqyOXOasF/BfpIAs4/nutIZ/1hAEr2e0rcb4fkY/B4hyxQdAMt/qdgUkaUvm9WAJowaMCDdhgziKfFDR4WfE0b4+ijGrdx+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(1800799003)(90021799007)(82310400008)(186006)(451199021)(90011799007)(36840700001)(46966006)(40470700004)(40460700003)(4326008)(70586007)(70206006)(316002)(81166007)(356005)(82740400003)(7696005)(36860700001)(2616005)(426003)(47076005)(36756003)(83380400001)(1076003)(26005)(336012)(16526019)(40480700001)(86362001)(6636002)(2906002)(54906003)(478600001)(110136005)(8676002)(8936002)(41300700001)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 08:11:05.7624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c82bbb8-3651-415e-3dc8-08db97e703bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6175
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
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

Signed-off-by: Meng Li <li.meng@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 149 +++++++++++++++++++++++++++++++----
 1 file changed, 133 insertions(+), 16 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9a1e194d5cf8..e919b3f4ab18 100644
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
@@ -65,6 +68,14 @@ static struct cpufreq_driver amd_pstate_epp_driver;
 static int cppc_state = AMD_PSTATE_UNDEFINED;
 static bool cppc_enabled;
 
+/*
+ * CPPC Preferred Core feature is supported by power firmware
+ */
+static bool prefcore_enabled = false;
+
+/* Disable AMD Pstate Preferred Core loading */
+static bool no_prefcore __read_mostly = true;
+
 /*
  * AMD Energy Preference Performance (EPP)
  * The EPP is used in the CCLK DPM controller to drive
@@ -290,23 +301,21 @@ static inline int amd_pstate_enable(bool enable)
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
+	if (!prefcore_enabled)
+		WRITE_ONCE(cpudata->highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));
+	else
+		WRITE_ONCE(cpudata->highest_perf, AMD_PSTATE_PREFCORE_THRESHOLD);
 
 	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
@@ -318,17 +327,15 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
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
+	if (!prefcore_enabled)
+		WRITE_ONCE(cpudata->highest_perf, cppc_perf.highest_perf);
+	else
+		WRITE_ONCE(cpudata->highest_perf, AMD_PSTATE_PREFCORE_THRESHOLD);
 
 	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
@@ -676,6 +683,90 @@ static void amd_perf_ctl_reset(unsigned int cpu)
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
+	if (no_prefcore)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		ret = amd_pstate_get_highest_perf(cpu, &highest_perf);
+		if (ret)
+			break;
+
+		sched_set_itmt_core_prio(highest_perf, cpu);
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
+/*
+ * Check if AMD Pstate Preferred core feature is supported and enabled
+ * 1) no_prefcore is used to enable or disable AMD Pstate Preferred Core
+ * loading when user would like to enable or disable it. Without that,
+ * AMD Pstate Preferred Core will be disabled by default if the processor
+ * and power firmware can support preferred core feature.
+ * 2) prefcore_enabled is used to indicate whether CPPC preferred core is enabled.
+ */
+static void check_prefcore_supported(int cpu)
+{
+	u64 highest_perf;
+	int ret;
+
+	if (no_prefcore)
+		return;
+
+	ret = amd_pstate_get_highest_perf(cpu, &highest_perf);
+	if (ret)
+		return;
+
+	if(highest_perf < AMD_PSTATE_MAX_CPPC_PERF)
+		prefcore_enabled = true;
+}
+
 static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 {
 	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
@@ -697,6 +788,9 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	cpudata->cpu = policy->cpu;
 
+	/* check if CPPC preferred core feature is enabled*/
+	check_prefcore_supported(policy->cpu);
+
 	ret = amd_pstate_init_perf(cpudata);
 	if (ret)
 		goto free_cpudata1;
@@ -1037,6 +1131,12 @@ static ssize_t status_store(struct device *a, struct device_attribute *b,
 	return ret < 0 ? ret : count;
 }
 
+static ssize_t prefcore_state_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n", prefcore_enabled ? "enabled" : "disabled");
+}
+
 cpufreq_freq_attr_ro(amd_pstate_max_freq);
 cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
 
@@ -1044,6 +1144,7 @@ cpufreq_freq_attr_ro(amd_pstate_highest_perf);
 cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
 static DEVICE_ATTR_RW(status);
+static DEVICE_ATTR_RO(prefcore_state);
 
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
@@ -1063,6 +1164,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 
 static struct attribute *pstate_global_attributes[] = {
 	&dev_attr_status.attr,
+	&dev_attr_prefcore_state.attr,
 	NULL
 };
 
@@ -1114,6 +1216,9 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	cpudata->cpu = policy->cpu;
 	cpudata->epp_policy = 0;
 
+	/* check if CPPC preferred core feature is supported*/
+	check_prefcore_supported(policy->cpu);
+
 	ret = amd_pstate_init_perf(cpudata);
 	if (ret)
 		goto free_cpudata1;
@@ -1506,6 +1611,8 @@ static int __init amd_pstate_init(void)
 		}
 	}
 
+	amd_pstate_init_prefcore();
+
 	return ret;
 
 global_attr_free:
@@ -1527,7 +1634,17 @@ static int __init amd_pstate_param(char *str)
 
 	return amd_pstate_set_driver(mode_idx);
 }
+
+static int __init amd_prefcore_param(char *str)
+{
+	if (!strcmp(str, "enable"))
+		no_prefcore = false;
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

