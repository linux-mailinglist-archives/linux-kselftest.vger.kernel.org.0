Return-Path: <linux-kselftest+bounces-2908-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D549E82BD19
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 10:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6541F24C1D
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 09:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7C85733A;
	Fri, 12 Jan 2024 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3uas+V3m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D003A5D916;
	Fri, 12 Jan 2024 09:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nk01hgNrSUr41e46Lerpb2JB0Rv8Fi8zQgjVha82mnRwfa+DXslZEpBuCBScfO7eMfBXcRTVmaa4CXG9lU/GYAsi2fevVMLNMcEhnGy6/3DDf/C15ZppszWIVfxlAoynnjqCKsmf396aMh18MjPXIdaKyhV4Q6g56MXnH0KWmVfGMcYKjIquVfE65fLhSk8Bjs+9oQStpiD1UB1WOY5EedRNQCTFaK2L0nlfVWorbwxHZP0E7Fpt44nq4kxkcx+OtvAsK5v/DUCUm8w9cEtt2fPIQCnbQT3PxQBXmwHIfiP9fiIkiB0iAguGNgZpr1v19ugQfKpJO6PaRW9reXheQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmBnlY6CcyhnNSPEQizfeQBw6AAo8AGdk2azpcvOOtI=;
 b=eA9pqmwfAIOGmCDF+Y42qCTSyH6kDURTaRE4Mw6VO1LDlI6+UAvMc3E7Hf7/XuIp4sC4hrYifg/xTrNGNAstbmAvZB5i7OBZ5P9r2GXg6ggNKyFsA3iV2Nu1iVXsqRT3p6NRBmOV094p2WK3ES3LYR5I7cgmi2kKgpcS3kch3WX3jHOCDhJ9ao7DtCccs56cPiF5c6i8uObAZ5Cg5PZbp2DEAfGrYVTKZe7+D+wpPCgqYHrujIuu7oQhqOquqOSAYRhvVrDVqdsFuGa0XPZF86kD7gQSIWhW3a30t9SiSyIOoClBM//sVeVllcyRV9+ccOgNiFa+k+eJST3g6GihSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmBnlY6CcyhnNSPEQizfeQBw6AAo8AGdk2azpcvOOtI=;
 b=3uas+V3m/Cz1pdguYX4tZ0XABGQs4Z+mDQqtOyiQdgWGPrMzOWc58fxUTxJr6cvmM2ZiosTbbbO51WjeFHYwl+cXCxxDpdABHcmdIKmBw8CN7lfB2BYH5DRFX4Nm0uj2xKdSSgES2Yws8ScUanq764u9KxXQ/bKV9axfeC+c34Q=
Received: from DS7PR03CA0266.namprd03.prod.outlook.com (2603:10b6:5:3b3::31)
 by DM6PR12MB4942.namprd12.prod.outlook.com (2603:10b6:5:1be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 09:26:06 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:3b3:cafe::21) by DS7PR03CA0266.outlook.office365.com
 (2603:10b6:5:3b3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21 via Frontend
 Transport; Fri, 12 Jan 2024 09:26:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Fri, 12 Jan 2024 09:26:06 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 12 Jan
 2024 03:26:01 -0600
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
Subject: [PATCH V13 3/7] cpufreq: amd-pstate: Enable amd-pstate preferred core supporting.
Date: Fri, 12 Jan 2024 17:25:27 +0800
Message-ID: <20240112092531.789841-4-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240112092531.789841-1-li.meng@amd.com>
References: <20240112092531.789841-1-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|DM6PR12MB4942:EE_
X-MS-Office365-Filtering-Correlation-Id: da08a108-9595-4cd3-2a06-08dc1350815a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tQ8m7Sz0iYtMK8IpdAgLoJaRRIYFWA2HxhZAFVJVzoVL2iACd/3Ti3Qur3TVAqPWYXG1f3L5g5maiGbDXmZv3PMMBGUZM10FxzVQw9DPEwQdc8ZgNzkUAZ11Zipdr4YwjZdP9bf5DymiMKo3jDMjVltbUJMVoGTRi270p6A5v2q1EvhA+VgJBLihqYxaANh1AN41xh2F4qwDKsM/mmpg1OPDy4JGTpb0ZrRyCMoGm+qBi6FCWk2Ya5gfK3zNrOnyMlMYeSUTGFL05ccq8NwJP4UWlSm5kix/Z1XWbYrVMFe4mzhXeyhOrz3AJeR9lLUneZyjy8ccV7bGG1uEmtvciFwIH8alAmS++m9HcUxbHtTAyp9qgCp3lV7VfxY/LrUTvFjK+P7NjHi/YdI2fMt4uTuDE+PENi6YxV7ed4p3KVudA0XMVxVkar7PKZly2IZ2ShLxEphbjAUZ0F4nj0XD/IM2CDf0XJ6oqdlTu6rvmqwbx2V4dvnuCGS4gOMGzC/XMJ1bliFB7pbEkorMorzURQXdxZyXegtF7LMjkBR+l3P7MDJYfQ23rFBWUYGKhE5OaqXJ8xSXkn8U/JjfxKb/ss84ies5p6U4Ep8PWJm+NOPTlOk+1ADFoRuE80C+kgdSSaDWXBcywZW+mbJFPSu48DUYFBQxsMOUtdjv3vNYjyt45fjR+3eWTJZqN79NGtRh0xnCDdTdUo6wUjCOKbgsYxqs4f4NobOcks63vq3bYibOqN4McywWcz2EtNeQgTzDQQkrwi5p74FgobhF+VNhZQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(82310400011)(186009)(40470700004)(46966006)(36840700001)(336012)(83380400001)(1076003)(16526019)(426003)(47076005)(26005)(2616005)(36860700001)(316002)(7416002)(6636002)(110136005)(54906003)(70206006)(5660300002)(4326008)(70586007)(8936002)(8676002)(6666004)(7696005)(86362001)(478600001)(41300700001)(2906002)(36756003)(356005)(82740400003)(81166007)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 09:26:06.7311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da08a108-9595-4cd3-2a06-08dc1350815a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4942

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


