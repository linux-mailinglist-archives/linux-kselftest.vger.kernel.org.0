Return-Path: <linux-kselftest+bounces-2910-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6509482BD23
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 10:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E3311C2509B
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 09:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CDA56B7C;
	Fri, 12 Jan 2024 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Iqf1X4UO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C3D5DF32;
	Fri, 12 Jan 2024 09:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exytUt1xftiXhkyHV9ftWsCUGF4k6emydwSj/jvxvJRqmLO9A0PsxUrwYL4no5SSlJTw55QT4AsmNRdqcYz/ai0xiItcRPVxqr7vqhbfhm3dPmVLsErXS0Suo3m9OOOwNkDj75ltvOIDlGMgD821KalLKyw75NqqY0yTWTQoTc7sURK1k4EsTwb2YWyysMuAwSLjdACVxSrp6Z5V5RMDVEoNkSaSRFqJIL7U+koqDpfeaXxmfXYbqVyZNxG9dXQ0RQ6slkwdAXSTR0y5RYpAyvOOfAGKN26zNA4ewMtuatvIyF3E+kUn9ctEe9grFMsa/xlTC48GyPLKlpF5RATguA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fX2Ta/Gv798M7peRlFChK9xqESpeKi5VXhhwayFgnPw=;
 b=hEjiBCuS9mBdgTGC8GTVmReKDFuNH4PfUjQOATyMYjJVeZic2Rg6ALodeYvT1CXxrACQpu3eZTaEs/AetEFJuHmO04rMJ5c1jru2vSIeQSsWJ1gNYpTua4Fe+YgA6P47We6iMW9P0sdN+FouHGmYoXLUBhJPw+Y/KoAY7Ji7O2KZmeOdJHJPWNfdlRUkoQF2tQEmjkmPAgElc+0wAfrt6Xf6cdmazE+1osZxnfHvQ5Yrqy8xF5rPL141bjk5AKh5cIlN2zxm5D5ysfo9E+ZyEv/gmmBKjGZ9l37zBc/agLGEOyQtko2joZ1SW4pRD3h7VPg60rY2150B8W98S6n5Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fX2Ta/Gv798M7peRlFChK9xqESpeKi5VXhhwayFgnPw=;
 b=Iqf1X4UOCDZagrj/7NYPxuXT6jK7M1Luu9sGDZoXYN3/sk/QJA/wfcv6S/Qd+b7DdMTQYWWq3XnXD2nxcL+bPpoKIestQ0xif4tu2TUfwS4qAq/EQniR4V2M14A9jqoj9rIDwdk/cD5Nt/0fcmIyYg3m90NPnAcESHwH1GDvMDw=
Received: from DM6PR03CA0035.namprd03.prod.outlook.com (2603:10b6:5:40::48) by
 CH3PR12MB9429.namprd12.prod.outlook.com (2603:10b6:610:1c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 09:26:17 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:40:cafe::63) by DM6PR03CA0035.outlook.office365.com
 (2603:10b6:5:40::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Fri, 12 Jan 2024 09:26:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Fri, 12 Jan 2024 09:26:17 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 12 Jan
 2024 03:26:11 -0600
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
	<wyes.karny@amd.com>, Perry Yuan <perry.yuan@amd.com>
Subject: [PATCH V13 5/7] cpufreq: amd-pstate: Update amd-pstate preferred core ranking dynamically
Date: Fri, 12 Jan 2024 17:25:29 +0800
Message-ID: <20240112092531.789841-6-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|CH3PR12MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: 5efb09fd-cc5a-4e33-4b60-08dc13508780
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xEBKJUOWoef62IBXM8x9t6OGE7ANAhkp/6Uojhf9DVsG2LYi+B9Yqe4BSY9JvSL7Lsg0xvNYfkgKYJ8ayBfHm5pS4gi3YoYXn13+vJ4cR+CZCeBmslcwJdOobeqApoU1+g8iBkrrG5n47qmpqwowHGSiCtjkCM1RpDbFidYPIn8zbmc19mfAdzvtpenBVE6ugWY3MTCAmcqHawjGwWOYiZs7/PHET5twhPYwGEtTOUT8f7v9nxTITrCquQob5h5+0SHNrIy+55t4dJCls8DaubvCA+kF/yBCg/D5BEgRdseuR8hkEhOBEaIhVtND9ukKQYa8y/Gv6OolgNRy1LnIDn2Yih2qI3uLKSJCJ6X/kwompFyIDDkYpez9seVA228ZL7qeetkUn2oPpBbBYyxSAgjm9SXhZ0LVrIsBBWdEM8GgR0aa/kV5XuO/s1OHFJtxfr2LZwCpIyORnQ/Qd1NBmaNbxJUFntVObNjRoEWmU+cBCTE2L+498T3hAKZ/7bJ6Cj3Sox7dWUBRgTjIeN2tpdK5JYPIWmWcGVWw57oA0V8K9aHvfAC1ypCNOahmcsOVVUi3v0tD3Ix4RCueqYYpynqLIP9RJNJG4DyVn3O7D5stghPFTf6sAE2GiFMUEbtFcFv2ZuHa4eeERH68ay10aswvJ/WuibdPpV/1UzR381m/8j+DLxes40BJN09JhlRNHmz4sBPHTei2cza8ZdjNOF2wvkbJ152epeCiWPUdV2vC3nyiGNluh851cuR48ItpoeggMt21Tqj4Ww870wuCWA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(36840700001)(46966006)(40470700004)(7696005)(6666004)(478600001)(426003)(336012)(26005)(1076003)(16526019)(2616005)(6636002)(316002)(36756003)(8936002)(8676002)(70586007)(70206006)(54906003)(110136005)(356005)(81166007)(82740400003)(83380400001)(47076005)(86362001)(4326008)(36860700001)(5660300002)(15650500001)(7416002)(2906002)(41300700001)(66899024)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 09:26:17.0630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5efb09fd-cc5a-4e33-4b60-08dc13508780
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9429

Preferred core rankings can be changed dynamically by the
platform based on the workload and platform conditions and
accounting for thermals and aging.
When this occurs, cpu priority need to be set.

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Meng Li <li.meng@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 52 ++++++++++++++++++++++++++++++++++++
 include/linux/amd-pstate.h   |  6 +++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9c2790753f99..3034b8ff3f8e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -315,6 +315,7 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
 	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
 	WRITE_ONCE(cpudata->lowest_perf, AMD_CPPC_LOWEST_PERF(cap1));
+	WRITE_ONCE(cpudata->prefcore_ranking, AMD_CPPC_HIGHEST_PERF(cap1));
 	WRITE_ONCE(cpudata->min_limit_perf, AMD_CPPC_LOWEST_PERF(cap1));
 	return 0;
 }
@@ -339,6 +340,7 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
 		   cppc_perf.lowest_nonlinear_perf);
 	WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
+	WRITE_ONCE(cpudata->prefcore_ranking, cppc_perf.highest_perf);
 	WRITE_ONCE(cpudata->min_limit_perf, cppc_perf.lowest_perf);
 
 	if (cppc_state == AMD_PSTATE_ACTIVE)
@@ -785,6 +787,40 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
 	schedule_work(&sched_prefcore_work);
 }
 
+static void amd_pstate_update_limits(unsigned int cpu)
+{
+	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	struct amd_cpudata *cpudata = policy->driver_data;
+	u32 prev_high = 0, cur_high = 0;
+	int ret;
+	bool highest_perf_changed = false;
+
+	mutex_lock(&amd_pstate_driver_lock);
+	if ((!amd_pstate_prefcore) || (!cpudata->hw_prefcore))
+		goto free_cpufreq_put;
+
+	ret = amd_pstate_get_highest_perf(cpu, &cur_high);
+	if (ret)
+		goto free_cpufreq_put;
+
+	prev_high = READ_ONCE(cpudata->prefcore_ranking);
+	if (prev_high != cur_high) {
+		highest_perf_changed = true;
+		WRITE_ONCE(cpudata->prefcore_ranking, cur_high);
+
+		if (cur_high < CPPC_MAX_PERF)
+			sched_set_itmt_core_prio((int)cur_high, cpu);
+	}
+
+free_cpufreq_put:
+	cpufreq_cpu_put(policy);
+
+	if (!highest_perf_changed)
+		cpufreq_update_policy(cpu);
+
+	mutex_unlock(&amd_pstate_driver_lock);
+}
+
 static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 {
 	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
@@ -958,6 +994,17 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
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
@@ -1176,6 +1223,7 @@ cpufreq_freq_attr_ro(amd_pstate_max_freq);
 cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
 
 cpufreq_freq_attr_ro(amd_pstate_highest_perf);
+cpufreq_freq_attr_ro(amd_pstate_prefcore_ranking);
 cpufreq_freq_attr_ro(amd_pstate_hw_prefcore);
 cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
@@ -1186,6 +1234,7 @@ static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
 	&amd_pstate_lowest_nonlinear_freq,
 	&amd_pstate_highest_perf,
+	&amd_pstate_prefcore_ranking,
 	&amd_pstate_hw_prefcore,
 	NULL,
 };
@@ -1194,6 +1243,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 	&amd_pstate_max_freq,
 	&amd_pstate_lowest_nonlinear_freq,
 	&amd_pstate_highest_perf,
+	&amd_pstate_prefcore_ranking,
 	&amd_pstate_hw_prefcore,
 	&energy_performance_preference,
 	&energy_performance_available_preferences,
@@ -1538,6 +1588,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.suspend	= amd_pstate_cpu_suspend,
 	.resume		= amd_pstate_cpu_resume,
 	.set_boost	= amd_pstate_set_boost,
+	.update_limits	= amd_pstate_update_limits,
 	.name		= "amd-pstate",
 	.attr		= amd_pstate_attr,
 };
@@ -1552,6 +1603,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.online		= amd_pstate_epp_cpu_online,
 	.suspend	= amd_pstate_epp_suspend,
 	.resume		= amd_pstate_epp_resume,
+	.update_limits	= amd_pstate_update_limits,
 	.name		= "amd-pstate-epp",
 	.attr		= amd_pstate_epp_attr,
 };
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 68fc1bd8d851..d21838835abd 100644
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
 	u32     min_limit_perf;
 	u32     max_limit_perf;
 	u32     min_limit_freq;
-- 
2.34.1


