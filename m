Return-Path: <linux-kselftest+bounces-3230-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA36832635
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 10:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7614B23AC2
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 09:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072FB23748;
	Fri, 19 Jan 2024 09:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4Ww7cG/D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCBE2940E;
	Fri, 19 Jan 2024 09:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705655145; cv=fail; b=dqgG3784wqgYfbecZiXcBNmMCM+n5sBjEXZPy0gidXWWqxWyWY7Ar3q8sNxSu7AUmZJnxvikdKjKkMcb75eLVSNbJO3OH/BPAO+cLlVLuuFe7gNXw2KleynHTfS21IkcLrJQ4ywswGjXCUaMYh2WoUU0/27BzC52vDvR7FmCSDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705655145; c=relaxed/simple;
	bh=UlvQUBZ8ut+oCayk0dwAIKiBB9dYfcTQnlOQQx2F5C8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QhQ5rMC5VHYvh2+i5aG7Jhl0Lgxb4AiKs3mE6IH7kl/4Aj1oetUvcivnaqvB/w3SHv7JAn5NAsBLn8LYwIDzwF/QlS7IJl2YRys6wE3Z3zUWmtHE7+h4B34yAFdnWI+FTi1xUN3SUBNvx/LRfWmHUexSRdQyy7WQQ08Jw4/n0rI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4Ww7cG/D; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLe+TTradCGTuaUVvPyw1pnyawsiC/GhoL4oasZ1rK1jTsQOInBdXZ/ejoHI8GUht391Iw68TIYrgPugJT3+f4AYHrE3TKP+5VXTPdfpjgBnQODWwsWI0NgMj7PGUIW35Rqnn4YJHkKKf4SWYyruNqkPKMX3NVa0BEpwF+mcTvQ4uTBKUqwHiMT6hWhrYwDi8WfM7sc+xlUQKWoeE+Nzghv+5oXEpi+gyIoscJFBeaLsDfn72hgDJyLEUzO456nYQQcIxQTuBuqQG8sKoT/zICsqV68v6gmTvIuierNB//CrIC3VsqF5t5AMe0r4GqRqmqLgX/mRlUmdpjUSIj1jNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmBnlY6CcyhnNSPEQizfeQBw6AAo8AGdk2azpcvOOtI=;
 b=mxHMo5XSrdskK8B0C5a/GwlEi1s8bm9WiT/EDFzaXBe65g/g+njSuwHghqDyTcbRLoHUR7EuE3V1dG/eJGZbkIw/0PwL+HeYUxxRrPCCoWQOAfxE5qtvko1tQ2HmoKEr3qQKTT1AxbTwEZaCvakidDoQwVelRM+9zDV458bzBQscm1aPdzFIfpknZTXhGv9nFNQX1ELfylVQq0bcyQexJv+cr7YqOFOpYlEtfwis9z8Knz6zMLT7Qk5ss+yksUTTaIn4bQtbKGhNdTkgKH6+ohOU3meAZPUAoEa5giuZ6GjbfFrbSYBgBCuCdJO/tUYZnWuKf2qQcszCe/z5rThdRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmBnlY6CcyhnNSPEQizfeQBw6AAo8AGdk2azpcvOOtI=;
 b=4Ww7cG/DUJAFhZ4ONMzm+4XOnc2wISS9oOClt7zl1Qt3AS1VIWamcs0+e9cFExyRpZgvSCQeqxj4Mgy4RN0oyjZPeLNTIwMMewC+Q+nyylyP+MqzK578JpnkWmrzbGXmqeL8Zn3FXCZG6hdSh2JBkawEqSBd2TaNW+nYZKgFCFY=
Received: from MW4PR03CA0033.namprd03.prod.outlook.com (2603:10b6:303:8e::8)
 by DS7PR12MB5816.namprd12.prod.outlook.com (2603:10b6:8:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26; Fri, 19 Jan
 2024 09:05:40 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:8e:cafe::48) by MW4PR03CA0033.outlook.office365.com
 (2603:10b6:303:8e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Fri, 19 Jan 2024 09:05:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.0 via Frontend Transport; Fri, 19 Jan 2024 09:05:40 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 03:05:34 -0600
From: Meng Li <li.meng@amd.com>
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Borislav Petkov
	<bpetkov@amd.com>, Huang Rui <ray.huang@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <linux-acpi@vger.kernel.org>, Shuah Khan
	<skhan@linuxfoundation.org>, <linux-kselftest@vger.kernel.org>, "Nathan
 Fontenot" <nathan.fontenot@amd.com>, Deepak Sharma <deepak.sharma@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Shimmer Huang <shimmer.huang@amd.com>, "Perry
 Yuan" <Perry.Yuan@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>, Viresh Kumar
	<viresh.kumar@linaro.org>, Borislav Petkov <bp@alien8.de>, "Oleksandr
 Natalenko" <oleksandr@natalenko.name>, Meng Li <li.meng@amd.com>, Wyes Karny
	<wyes.karny@amd.com>
Subject: [PATCH V14 3/7] cpufreq: amd-pstate: Enable amd-pstate preferred core supporting.
Date: Fri, 19 Jan 2024 17:04:58 +0800
Message-ID: <20240119090502.3869695-4-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119090502.3869695-1-li.meng@amd.com>
References: <20240119090502.3869695-1-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|DS7PR12MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d299b87-ccd3-480d-46e9-08dc18cdcf45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Na/CwTW1muwAqUryUiQlNA3ruWzLYL7qWGZsnU1ujc411yr0dM+lbsA5DwqKTJphV1C46RPKgO1kYzYd3I2u0zL4jW05szhztxdTZUaH9X/Iqu1B0vJyBrF1kRlpY5rDBWBDCPVny6KkJktQpRokd45jrsfK5ko6B73BfEQQ/jKu07R1uOzE/1Hqi9APQSupDSb/yWUsOlMUqk6pcHoZtxkJRjJd55OJtLbuvZeiZxdZn1XFxdf+qy3AUmt9R1Jni3DrPB2a/0pIqUtQubYLbjJJ2DekfClW457qeG2tY5fmg7YDMpTHn3+KIN759xXwxfLrxkD8oe4CqNMHdSQrg6nFeHkl3dzAcPvv8SLuA+/TW3ms9mUnrsc17EtJLQCewI5Z73XgSLFPjV2zlhh6CMuq9Rtmk4LT4ukbndEupM0syaC20NUtn2Jsu6MhKnh7No/XcQ8DEHr/g/lEBDiybqYsB4atfVrPo96I+XXBui1prCj4KFyQE1PawHEF3ISBUXxeEpixkBJTpjFqVWqhXp5bWgvGzJEpVEUXbbZcxXkMo+IDIDnRWDBPdUNWYdlrNDRGfr5KIJkXjVjQXZxMMMNJ7j/8ypePQanHz+77uyF05iCPyNRsmWTN2NFc/YSQpJ44d0fe369z5yNcSPACxIoqtm9HZgCY2rKBS7mc64B90tH8Ds/ESBiAo29SRPJscQP25aBzj5h7i5fRj0DtpaKHJjuQ9hazzqvZb5heglFxOfpoOuvIOWSgGxm6Mqz1qFubarqHM/K0N9u2craGSQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(336012)(426003)(81166007)(82740400003)(86362001)(36756003)(356005)(36860700001)(2906002)(5660300002)(83380400001)(26005)(2616005)(1076003)(16526019)(478600001)(47076005)(7696005)(6666004)(4326008)(8676002)(8936002)(41300700001)(7416002)(110136005)(316002)(54906003)(6636002)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 09:05:40.3147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d299b87-ccd3-480d-46e9-08dc18cdcf45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5816

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
 drivers/cpufreq/amd-pstate.c | 131 ++++++++++++++++++++++++++++++++---
 include/linux/amd-pstate.h   |   4 ++
 2 files changed, 127 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 1f6186475715..9c2790753f99 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -37,6 +37,7 @@
 #include <linux/uaccess.h>
 #include <linux/static_call.h>
 #include <linux/amd-pstate.h>
+#include <linux/topology.h>
 
 #include <acpi/processor.h>
 #include <acpi/cppc_acpi.h>
@@ -49,6 +50,7 @@
 
 #define AMD_PSTATE_TRANSITION_LATENCY	20000
 #define AMD_PSTATE_TRANSITION_DELAY	1000
+#define AMD_PSTATE_PREFCORE_THRESHOLD	166
 
 /*
  * TODO: We need more time to fine tune processors with shared memory solution
@@ -64,6 +66,7 @@ static struct cpufreq_driver amd_pstate_driver;
 static struct cpufreq_driver amd_pstate_epp_driver;
 static int cppc_state = AMD_PSTATE_UNDEFINED;
 static bool cppc_enabled;
+static bool amd_pstate_prefcore = true;
 
 /*
  * AMD Energy Preference Performance (EPP)
@@ -297,13 +300,14 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
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
+	if (cpudata->hw_prefcore)
+		highest_perf = AMD_PSTATE_PREFCORE_THRESHOLD;
+	else
 		highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
 
 	WRITE_ONCE(cpudata->highest_perf, highest_perf);
@@ -324,8 +328,9 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
 	if (ret)
 		return ret;
 
-	highest_perf = amd_get_highest_perf();
-	if (highest_perf > cppc_perf.highest_perf)
+	if (cpudata->hw_prefcore)
+		highest_perf = AMD_PSTATE_PREFCORE_THRESHOLD;
+	else
 		highest_perf = cppc_perf.highest_perf;
 
 	WRITE_ONCE(cpudata->highest_perf, highest_perf);
@@ -706,6 +711,80 @@ static void amd_perf_ctl_reset(unsigned int cpu)
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
+		if (ret)
+			return ret;
+		WRITE_ONCE(*highest_perf, cppc_highest_perf);
+	}
+
+	return (ret);
+}
+
+#define CPPC_MAX_PERF	U8_MAX
+
+static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
+{
+	int ret, prio;
+	u32 highest_perf;
+
+	ret = amd_pstate_get_highest_perf(cpudata->cpu, &highest_perf);
+	if (ret)
+		return;
+
+	cpudata->hw_prefcore = true;
+	/* check if CPPC preferred core feature is enabled*/
+	if (highest_perf < CPPC_MAX_PERF)
+		prio = (int)highest_perf;
+	else {
+		pr_debug("AMD CPPC preferred core is unsupported!\n");
+		cpudata->hw_prefcore = false;
+		return;
+	}
+
+	if (!amd_pstate_prefcore)
+		return;
+
+	/*
+	 * The priorities can be set regardless of whether or not
+	 * sched_set_itmt_support(true) has been called and it is valid to
+	 * update them at any time after it has been called.
+	 */
+	sched_set_itmt_core_prio(prio, cpudata->cpu);
+
+	schedule_work(&sched_prefcore_work);
+}
+
 static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 {
 	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
@@ -727,6 +806,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	cpudata->cpu = policy->cpu;
 
+	amd_pstate_init_prefcore(cpudata);
+
 	ret = amd_pstate_init_perf(cpudata);
 	if (ret)
 		goto free_cpudata1;
@@ -877,6 +958,17 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
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
+	return sysfs_emit(buf, "%s\n", str_enabled_disabled(hw_prefcore));
+}
+
 static ssize_t show_energy_performance_available_preferences(
 				struct cpufreq_policy *policy, char *buf)
 {
@@ -1074,18 +1166,27 @@ static ssize_t status_store(struct device *a, struct device_attribute *b,
 	return ret < 0 ? ret : count;
 }
 
+static ssize_t prefcore_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n", str_enabled_disabled(amd_pstate_prefcore));
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
 
@@ -1093,6 +1194,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 	&amd_pstate_max_freq,
 	&amd_pstate_lowest_nonlinear_freq,
 	&amd_pstate_highest_perf,
+	&amd_pstate_hw_prefcore,
 	&energy_performance_preference,
 	&energy_performance_available_preferences,
 	NULL,
@@ -1100,6 +1202,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 
 static struct attribute *pstate_global_attributes[] = {
 	&dev_attr_status.attr,
+	&dev_attr_prefcore.attr,
 	NULL
 };
 
@@ -1151,6 +1254,8 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	cpudata->cpu = policy->cpu;
 	cpudata->epp_policy = 0;
 
+	amd_pstate_init_prefcore(cpudata);
+
 	ret = amd_pstate_init_perf(cpudata);
 	if (ret)
 		goto free_cpudata1;
@@ -1568,7 +1673,17 @@ static int __init amd_pstate_param(char *str)
 
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
index 6ad02ad9c7b4..68fc1bd8d851 100644
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
@@ -85,6 +88,7 @@ struct amd_cpudata {
 
 	u64	freq;
 	bool	boost_supported;
+	bool	hw_prefcore;
 
 	/* EPP feature related attributes*/
 	s16	epp_policy;
-- 
2.34.1


