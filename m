Return-Path: <linux-kselftest+bounces-1114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7944D804A5A
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 07:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9C1D1C20DA9
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 06:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B6211CA3;
	Tue,  5 Dec 2023 06:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X/ZJZTu0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C4DFA;
	Mon,  4 Dec 2023 22:38:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=db7fXzZmHGBj4JzHvTB2OybK9k3vpsbXFXnOrEu7VXXl8G8sNbL2WMMQ5uZc/EFG4UcJKQP5P0aujo/6CkK3Uyfih+RjJE0f51Q8zFhXMpjygkOdrUq4Hy3sT97Hp0BIM3sgsJTt08g3Oz4dHNpLo1HlwP3/JIBcZgLWE/UBSU9gqvLy2BJco7GyHMNBwTT5usreiPmTY5diaDz5KVLtD5+VOaNSZeKEceAUA0i/TmYot1sEX13EnI3ctg7ig2hwyZN524S0Zqs/HY9hc3DIysu0i25tayTYXUbSyaBMf5RxzOLkp0i+MwXC7LHFD63/Y6x5h2vYT/mZ40aMqtA2tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMYtSO2yqTYknGk2emCdrHmVUTNSN/FwK651HavA2lg=;
 b=A1iY5BvthSRishLwc5EM8ENNBHLWa4Dfmmb9K20eflvQT4zJ1DwRVmjltZbZtIHUEiN6oFOb7+VUb+QLTPz/r22VhYPbYs1qdIAwUxFnFb8Y3CIpYqV2ej1/SObhn19ZWMQwR+m4jg4ZWhwo8QKvPV50dEnG4czrblI7Z9XpYIA/XkYa3DR64O1K5LZKChrzu9gQe+h3BNm6hkQhjGjrQ0Af8/7TXKCLt4sO1MlqpjGygblmlFxs61gaq0rH3Hs25M2njwX81Pzq7mM8HjuW7fFLHba6BG8e3q9ZHjrP1MT5wdwiT0LEfvLx0gT5+thHwkdKjpR9vJWgA91DUg8VgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMYtSO2yqTYknGk2emCdrHmVUTNSN/FwK651HavA2lg=;
 b=X/ZJZTu0X4hqPoCRnr+qovatInuzNApq9LtK7P6kIw9y+S5dm5pW0Yl8dwQvGhFDdT78aAnomZpQ+OEk2D0u26Z7ruXkLwlSwdstMEC4UrX9rCTnG0g1p1s5XBByYXc5xiipgXpcP5vTzsmCgCQSpzXWEhTjbzX/IhGI6l4CQzo=
Received: from SJ0PR13CA0131.namprd13.prod.outlook.com (2603:10b6:a03:2c6::16)
 by DM6PR12MB4878.namprd12.prod.outlook.com (2603:10b6:5:1b8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 06:38:44 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::b3) by SJ0PR13CA0131.outlook.office365.com
 (2603:10b6:a03:2c6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24 via Frontend
 Transport; Tue, 5 Dec 2023 06:38:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 06:38:43 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 00:38:36 -0600
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
	<wyes.karny@amd.com>, Perry Yuan <perry.yuan@amd.com>
Subject: [PATCH V12 5/7] cpufreq: amd-pstate: Update amd-pstate preferred core ranking dynamically
Date: Tue, 5 Dec 2023 14:35:35 +0800
Message-ID: <20231205063537.872834-6-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|DM6PR12MB4878:EE_
X-MS-Office365-Filtering-Correlation-Id: c6eec0ee-db89-4d84-e7c8-08dbf55cd366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/EO0TywmF4gYbKb42J95K3WJfbzRPiMb9dWE4no8Maby6cGXqgSID4+V0oz7HGUNmw4YJVWznQjehHXy6O0P4QMN9D59j1TlbDIoZnLx3qMzw0u7ulSxcUC+sWSnUsQnLiWitWzXKZJGi/MopbnCVnEn1QhIWIwuoTfZpAKyBmSa7EeKojtEilHsb+I+blI0wusifsuaX/N3+osGGoljWu6yohZwjlJWFNkuS8fJqnXV5FkdLTyVVTV5mBCS1RUzBKXoHPI/KUEM2gHGUV+5i2IEbErPYQtHW5G7P1NR7AGoFBP06Ani7UGqHNcDhDPp5IVyzTKhlmKnHkiupxc5d9Rv5Q65+32o0E8ZdPxonI+EjW+CY4xFlxVI8DiICwPRhnHCytB93GpnHGwaVEylJdgt8Bn1Z0eQUPnAvx2lhh/f5ZNT1+gGZjoEZJ3ZYpft/6mx9ZNDMybajeldBY/xkCOMDolNcHJT8FaHGNe6SJC22wQt5FhumaFncErHtT3+MYpx4lyd83WrXsiCxZKn9LzE3WA2nrmtIDORTfkNexRX5zwwG72fVYSulq6/C5x0OKfDBQ1j02HBhU9BgP+kejazeDHTFkwUDj91dTk90sm23xmAk20q5FzOmPlmDm0n+J4M0QCSAEfoHYnotJxBz0rK+1xhYVFiY+CX7vXjX/ppg/EbJ6jMm/Y/rnat+xOMMBQRxL4yQZ56birwwuhaCiQP9lQqHRJvClrHsq//AeM/IJC1M3VJRP2yanHtJeFNeW4s3VGuxNPUW2nRQSAIJw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(1800799012)(186009)(82310400011)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(36860700001)(40480700001)(7696005)(478600001)(110136005)(54906003)(6636002)(356005)(81166007)(70586007)(70206006)(316002)(26005)(16526019)(47076005)(2616005)(1076003)(83380400001)(4326008)(8676002)(8936002)(426003)(336012)(82740400003)(40460700003)(5660300002)(7416002)(2906002)(66899024)(15650500001)(41300700001)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 06:38:43.4652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6eec0ee-db89-4d84-e7c8-08dbf55cd366
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4878

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
 drivers/cpufreq/amd-pstate.c | 44 ++++++++++++++++++++++++++++++++++++
 include/linux/amd-pstate.h   |  6 +++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9c2790753f99..25f0fb53d320 100644
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
@@ -785,6 +787,32 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
 	schedule_work(&sched_prefcore_work);
 }
 
+static void amd_pstate_update_highest_perf(unsigned int cpu)
+{
+	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	struct amd_cpudata *cpudata = policy->driver_data;
+	u32 prev_high = 0, cur_high = 0;
+	int ret;
+
+	if ((!amd_pstate_prefcore) || (!cpudata->hw_prefcore))
+		goto free_cpufreq_put;
+
+	ret = amd_pstate_get_highest_perf(cpu, &cur_high);
+	if (ret)
+		goto free_cpufreq_put;
+
+	prev_high = READ_ONCE(cpudata->prefcore_ranking);
+	if (prev_high != cur_high) {
+		WRITE_ONCE(cpudata->prefcore_ranking, cur_high);
+
+		if (cur_high < CPPC_MAX_PERF)
+			sched_set_itmt_core_prio((int)cur_high, cpu);
+	}
+
+free_cpufreq_put:
+	cpufreq_cpu_put(policy);
+}
+
 static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 {
 	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
@@ -958,6 +986,17 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
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
@@ -1176,6 +1215,7 @@ cpufreq_freq_attr_ro(amd_pstate_max_freq);
 cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
 
 cpufreq_freq_attr_ro(amd_pstate_highest_perf);
+cpufreq_freq_attr_ro(amd_pstate_prefcore_ranking);
 cpufreq_freq_attr_ro(amd_pstate_hw_prefcore);
 cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
@@ -1186,6 +1226,7 @@ static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
 	&amd_pstate_lowest_nonlinear_freq,
 	&amd_pstate_highest_perf,
+	&amd_pstate_prefcore_ranking,
 	&amd_pstate_hw_prefcore,
 	NULL,
 };
@@ -1194,6 +1235,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 	&amd_pstate_max_freq,
 	&amd_pstate_lowest_nonlinear_freq,
 	&amd_pstate_highest_perf,
+	&amd_pstate_prefcore_ranking,
 	&amd_pstate_hw_prefcore,
 	&energy_performance_preference,
 	&energy_performance_available_preferences,
@@ -1538,6 +1580,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.suspend	= amd_pstate_cpu_suspend,
 	.resume		= amd_pstate_cpu_resume,
 	.set_boost	= amd_pstate_set_boost,
+	.update_highest_perf	= amd_pstate_update_highest_perf,
 	.name		= "amd-pstate",
 	.attr		= amd_pstate_attr,
 };
@@ -1552,6 +1595,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.online		= amd_pstate_epp_cpu_online,
 	.suspend	= amd_pstate_epp_suspend,
 	.resume		= amd_pstate_epp_resume,
+	.update_highest_perf	= amd_pstate_update_highest_perf,
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


