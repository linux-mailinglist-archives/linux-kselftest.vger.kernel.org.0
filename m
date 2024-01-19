Return-Path: <linux-kselftest+bounces-3232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC8A83263C
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 10:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE2121F21F33
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 09:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7EC28DD4;
	Fri, 19 Jan 2024 09:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0fkJXq/c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB2A2C864;
	Fri, 19 Jan 2024 09:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705655166; cv=fail; b=l08jJWb9PSe9SbS1NaPkhsmoOn1ICarEluxyv4JjGkk8C8Q6PXgh1/h4TKAM+cOiZ+PPZiKrquhqz0ss21ltYBfZkKyT2tl9o4aPdSITLOddhWgwUr2Udn4XM0PSdw7yEzBeRlYtmjCUKcgVbKKRLUghCDM6YCqGp88tu4bTAak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705655166; c=relaxed/simple;
	bh=gm2sMvszd/UMPdqzcy9QcGrVlbmcT7JdgSVZE5/Q2jc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RLsjUPn2F4suNGjUqFyoqckrnjZcRxQhSvEG10QV4plyoBoO+ydldbE7Utu1ERBR6PdnnlxsNgsgsnNUcMgESgEjr8B2A58peyjXUEb6dGPFonAq1jm+7BHvHWNuZtJ2P4wHOUqc5yiQpXpoJskCDCmWar8uUCT09juiun1j2cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0fkJXq/c; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yn8hAc8GKHpGd/LzPJAfEcP8o2QlMcpzlFrbbjPY/Hznu4gaxOvxithPEzaX1hLDsf5eUIlqt1ohqMLygeCOrTGyEz0OaWmb42g9gwS3mxJUpDm8Fe+7fWadb/Op7uewHg3ofQ+AfH9aersUhri8ae5X7iNZi2puiOq1FrQVxeVVR3j9OrVKxzhgjah/+I4uz1loRcmc0zXsUXCpjLe89pm18dS7YlsTDTP1nyBvHhgj4ptsoDiD+FX8fNnVePElkkv50W38oSGKPx2iYJgx9LbsSZTjzFQx6O1F5X1Fk/1Oug5lSsHTP6ewT3dY6mmVYcGyQX4gv3gLTp+BO8H4TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fX2Ta/Gv798M7peRlFChK9xqESpeKi5VXhhwayFgnPw=;
 b=JnurhhSF1Yjo68oahBvhgfxc2OPiYAxUY+0R3/8DT5UaYveDb21Q/OjW8RZks9WwDQ9BVVv3lhrR2jQKETydmXHkp9VyjQF5LS8b5CJevMkHEVNHp/zEj20or7V+QK7ZBiEvofeULArMWoacR7ytMtKy2xVzJm75IMRYaNd2ccnpgKoQixUbpcXwaOG4ZQNr60ZsZX3Vu5/n6c99cwhg2uCzATLnfOzDNeflG/TrBZiYqnMPzuI+6vNUnIGTFOdSRnuuqME32z3AYUOJWxH9OEypqeiUEDRH7xGxN4225y7MUauGHPvFyqAYdwdMmXC4hGoKThrgYpgxSv6YknFe7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fX2Ta/Gv798M7peRlFChK9xqESpeKi5VXhhwayFgnPw=;
 b=0fkJXq/cBteMCQ9IySy7x8nzUK9nIbm64JLO1uCMGP6UqZU7s1gPbYCpoDGRmpLkTITHph2eYRPcyYOtfkZR5jUNFW3eo48ZnWPVqXjcC6Sch7CIgkLhGe0FGeMpgUrrPIWeHx8SYbUfK0ey/fy7b+y4IVh/8BtO0RCR36BzrFw=
Received: from MW4PR04CA0112.namprd04.prod.outlook.com (2603:10b6:303:83::27)
 by BN9PR12MB5066.namprd12.prod.outlook.com (2603:10b6:408:133::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26; Fri, 19 Jan
 2024 09:06:01 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:83:cafe::b7) by MW4PR04CA0112.outlook.office365.com
 (2603:10b6:303:83::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Fri, 19 Jan 2024 09:06:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.0 via Frontend Transport; Fri, 19 Jan 2024 09:06:00 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 03:05:55 -0600
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
Subject: [PATCH V14 5/7] cpufreq: amd-pstate: Update amd-pstate preferred core ranking dynamically
Date: Fri, 19 Jan 2024 17:05:00 +0800
Message-ID: <20240119090502.3869695-6-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|BN9PR12MB5066:EE_
X-MS-Office365-Filtering-Correlation-Id: 670f7a62-ef9c-40c5-ff71-08dc18cddb88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8rHcaqIOL1EILaMhAiADoivSumLUogyD1uNvWY9FzwBZ4fFg95WO34fJe+CWZOdh3OlQIStYeTPHjD62LLmdFMP+yZwfdNBRqcR9bRUIwfRI2zaFBsCxbsYQAnKiyj7phcr4njTTgppKgFgTWy1izD9GXCQkkgLgxKd152na9A2/AMs1dY6ktMRYFKqpHbRn0oZwdVUNQCZoxnJTIqrPyS6Ef6mF205SblLGm9xvlwhlOihlL9H+rSjl5HefGqrvw5/gLbP772l9DQ1CtPnd50BRnzbsOiaFswRLF8MZFHX2rnXjA1dKJIczUyxrtm2oCd1lT+R4w5th6iYvmmkanJ8Fj6C/69oOmeqXh1OoinEK9Iz1yp0CpB/UIUEtAoaTyE8Z/fxAxGQ1yL8/NwI/gRV5YQwynH8ZDt5G0XGFZU5OhkLK33/1bdomPnbqMW6JgTKLq5SHMdECQbbdDpXw0j0OrwBnoMifsMQLhOlEYXsivI28izONkBy2FTpv/WARvJOwUIeWyjdtLC6iH2uqwkg01pCWDe7kujPZm1N9ixK9aoJjitDqTJlBgAiwjubn+eFRMqYmzCeKDfl6KRPVz/yJvPnszpn96qim/MBqJbodTrO420YCTVCVNu0GWuM7nPz5uQQU/Fe3jmSIaaRi6O+B7JKVBUSOY+MS8+nLpT7BlmMsPFbhachzJ/OpVa5vf381MtRavgCK+zPoZrBU18WwL0v3qDNYWBZWQDi+1pwBcy1C9ONJPKLqeWde0NiujrsU3h34JI1sLEsxdLScjQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799012)(36840700001)(40470700004)(46966006)(6636002)(54906003)(40480700001)(316002)(7696005)(40460700003)(110136005)(2616005)(70586007)(70206006)(5660300002)(26005)(1076003)(16526019)(478600001)(6666004)(66899024)(336012)(426003)(36860700001)(2906002)(36756003)(41300700001)(86362001)(81166007)(356005)(47076005)(15650500001)(4326008)(8676002)(8936002)(83380400001)(82740400003)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 09:06:00.8912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 670f7a62-ef9c-40c5-ff71-08dc18cddb88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5066

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


