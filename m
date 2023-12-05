Return-Path: <linux-kselftest+bounces-1112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D60804A53
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 07:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A15E6B20C0B
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 06:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1122210958;
	Tue,  5 Dec 2023 06:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HpcSQGQt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8CF11F;
	Mon,  4 Dec 2023 22:38:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7zOfO4nQhxUtk6XkeotEUT9s15Sn1og0bPszRz5uEbiuNa5Mv10Q44VrtgTrcy6x1gtIoUA5obrpJ/l5skQ24pTBvpIFdfcAcCuopiUS+06lsprlzWzU+ye1gEFNTzaFNjKALV90IckfSgvPLCdEWCViJ3DdP1wJRZoRg3qrai2A0EUdZCpnumHT+MiHYLpJ4sbbhcoMvpm2L/B3guPgVPsXNq5k9IadRdis0PqQRfNcIC90FEkFls0MNTuGc8qzQEDaVsLVJHlTDNlb5gMu78Fl7aiMFpq1jNaqtdhXC6RntYAYsGZZqs3ef+4ARUSekkSvyqY6wwXjFFb7187lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmBnlY6CcyhnNSPEQizfeQBw6AAo8AGdk2azpcvOOtI=;
 b=cwy950MQvrdHrw54aP4sccJnWHItwY+spWm9OxLC9tekGll83SMzhcPwCwL+MioNbKgXBtQh97gOtRgeU+r9LcUrCl3v4b//Z6FZrSIxSG3bFdIcshYHWWsgEK3pLT++iMqPQCJdHC4F9r3WuEhV6GZLlDI9t8lzFxu31QOXZ1qyfiAphq7SGejb7IVDDoHXk4VlnOOCnFPpGifcuxyfHdxbJ5AtuqgSqVQOE4iv1YKiZR/ZNiM2IarzLd+zsNWYoMdViLGWOxJIWSI1lx+15viZkUhzRIMa37rGcZmeTX0wDoUGlL0xuTWrOR9BOGKsGKACuwRSkqQgi0uiwpPtPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmBnlY6CcyhnNSPEQizfeQBw6AAo8AGdk2azpcvOOtI=;
 b=HpcSQGQtPE49C0hKx5WqrReny63oxu626y7NCmqORsVzAwa/tEYhKyYDdQnur4pwDZmK6/cSqRxiDTQIl+9H4Y6JzCefFQ+e34ezZZ/eDnvWb+i/j1wTYH7SF8K06gqBSR2qGK8s5TCNcWd2CzUqUTW9OONS/jtcRvBgq9xvyBA=
Received: from DM6PR14CA0039.namprd14.prod.outlook.com (2603:10b6:5:18f::16)
 by LV8PR12MB9110.namprd12.prod.outlook.com (2603:10b6:408:18b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 06:38:08 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:18f:cafe::54) by DM6PR14CA0039.outlook.office365.com
 (2603:10b6:5:18f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Tue, 5 Dec 2023 06:38:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 06:38:08 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 00:38:02 -0600
From: Meng Li <li.meng@amd.com>
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Huang Rui
	<ray.huang@amd.com>
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
Subject: [PATCH V12 3/7] cpufreq: amd-pstate: Enable amd-pstate preferred core supporting.
Date: Tue, 5 Dec 2023 14:35:33 +0800
Message-ID: <20231205063537.872834-4-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205063537.872834-1-li.meng@amd.com>
References: <20231205063537.872834-1-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|LV8PR12MB9110:EE_
X-MS-Office365-Filtering-Correlation-Id: 25a1e611-1d87-4f8a-ffd6-08dbf55cbe80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U1qel9esVviiLMdEAPp63phYwKg9aZsB+LpCG0UVVPWM+VrJNdY5z3E5Ux6ubZRMYQLjoLAZB4E06BLej93qujWwr24dZUzY3OF0EdDIq58PCxZby1evURSODWGU/LUL8cq2d2OKdTgWnALQsKDrYc6WWSPRhS8EP2lYhGLAxULS5reZlxd7NQLJSshWbpwk57c0ESJTWaqgTqxR3QsRE/O2XoQkz16yE4fb+0xA+vxgbpSZiik1S9SjIp3w7cET1nwkjU7lhXadbBKqgzgyPfgiP7wNcrnzuAH415Jdw8sBG7OhLxOCubnZWdSyYMDAcKPkDQTy4smwRpLB0lXBUkdn/zZhAh4khM72E03xZJGE5kp+MdgMpDmcY+LDjowOaBiJok8oPvo/jhgtlG/5SH5/wGaWsD14NuV+8ji+Um+0HPMcOi7Cm/ybm8dFOvSmtq+eFLwkCLBwJJSUGVysPcJ6JAx14ejIe9LCa/DMsXO1Jpk9w8hQaGU11LUwsHEsxa3CI8zFrxaHRvXRuFc2jQhkrI+pVhrr9vd9t5A/06nS5mofDSEMk7FwiB4IzEdeM0zSnHdEZEyn8H1lT8pJUe+A9zXGupYHeZmBCBPrBCa+RXx1dpVYDQkrTlpX5ilX1rJDCveLhJlN04GWXjMEAqZ0KTRLngrKe0m2NUaeHZkA7FJAzU1lIfT8X/3zGKicXj3Q+0cjcX+UvwBlL6dY8FqpMXw6rnm+UP1CxfBX+fQf6iQwpclhmcnkYluaVUkA/QgiV4olcAxqrfVxod9/Gw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(478600001)(7696005)(1076003)(2616005)(81166007)(47076005)(6666004)(16526019)(26005)(8936002)(8676002)(426003)(336012)(6636002)(110136005)(54906003)(4326008)(70206006)(70586007)(83380400001)(316002)(7416002)(5660300002)(36756003)(356005)(82740400003)(41300700001)(2906002)(36860700001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 06:38:08.4041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a1e611-1d87-4f8a-ffd6-08dbf55cbe80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9110

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


