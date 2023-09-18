Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F51F7A4469
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Sep 2023 10:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240445AbjIRIR4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 04:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240833AbjIRIRM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 04:17:12 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5399910D4;
        Mon, 18 Sep 2023 01:15:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLwEWAJ1RePr8Rvv/g2SF4KNKnVcKwB/jBgGVV3+wB6F3lncnUBTnivaPwH6wyZY7+OIuyqJbV0LDD39t3chhIiCUq7P5NeE5dkilOoT1E9eOTIqpb2YSUxe5kjvZwJjys5CNJGn0Hy8ZzCpTaMdXwAQ0qLfXAW6aUcLHBjnVHqxNL79fHHSt6ZauQn7Qj40IBpHz5CF2YK3EfLh0hDwHthCHrWmpZevB2EguKMxTM7uV6h9WN0JX6Ka1iwm4CkSfdEzeaMtWXjgQ5TdO75ww2mMtujPmWdeRAhYvCacdeJmnZ1e1x1K6A3Ur54qPZSqMo418o4CtJbYgvujrjywvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42O1wCLDLCwndShou3SDr1XKXYXeg/IdCWJQrIHQRxU=;
 b=Bt4Jalrgbq2HutGJccGdHSU5wfNUBgRofCu0hxfepXCqXAOYak68jFOtNoTaGngWHBilUGyvu4TLWvLCy/zXtZeseeuSn2LQ4fQ3wnWAggspT4QhlnqfWO8V25YkheMRXjGvD9Hvk86WN4Oa5uSFNWmuy74AcmKhe77MlbvDg20gJonSfmOblqDosjyxcziPoI2ABlHq0YrauFai4O5iy+TFsJF4ohqxQDS9OzWxf2rfjehrSdgYXWU8KyY1RIZxPqH8SMBbZ0xKk42rqCBq4oPt90oaM+gflFZWP6YL/jFDz8HX0sZQnP261TAvFxKioc09xxpeyequl+N+LsyvXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42O1wCLDLCwndShou3SDr1XKXYXeg/IdCWJQrIHQRxU=;
 b=pZdI8ibomt9s2xPqbi/RQYQkXwic5z4M7Ic6vFTKGnXk4bw79J5R1XP48a9uJ7qSDIToQ0Fdfgz0uXb8JEUDhoNuYiBW5j2/Gq0co9Gi1jj2xd4krNmXSCUzlpiMutLjo4Oa5zpmHrqZdazdyH+it7ycCEVLj7kaewoU7VBnE3A=
Received: from SA9PR03CA0030.namprd03.prod.outlook.com (2603:10b6:806:20::35)
 by BY5PR12MB4291.namprd12.prod.outlook.com (2603:10b6:a03:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 08:15:28 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:20:cafe::e3) by SA9PR03CA0030.outlook.office365.com
 (2603:10b6:806:20::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 08:15:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 08:15:27 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Sep
 2023 03:15:22 -0500
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
        Borislav Petkov <bp@alien8.de>, Meng Li <li.meng@amd.com>,
        Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH V7 5/7] cpufreq: amd-pstate: Update amd-pstate preferred core ranking dynamically
Date:   Mon, 18 Sep 2023 16:14:05 +0800
Message-ID: <20230918081407.756858-6-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|BY5PR12MB4291:EE_
X-MS-Office365-Filtering-Correlation-Id: 232290c9-c10a-410c-af0b-08dbb81f6add
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xxvgLZ2+tNaUYIeGpsm2zsF7HXE9RDzZmQ4Vj34F8ERuUpRvrOQfEMNOz08Xi2HWaGPF62IUUMf8hdjQNviQNaN/3qwMSNjItnwI0o/YBTCWOenH0NWavuBb2QCBkDhkC3kKuBWlXPOh7nzStri9x9es+2Wimlmjd3UAREZxvsM1WBgETaxnuaHV6prb06/x0POI4vD6BRbLsn/KNPn35GW95fQdtFAdajUXJicSroHyH8H2O6NHj83k28OrjzoCpD0DVmCA0WlsoiucokatYm/7rDiqTULugcR84y/4tlCOAXc11SYMXtfZYPfAcJHXV8/gUqUVTgbMowO+D7zhkX5zays2oN1yojJi4+3iVNj9H7E60DAahCXULRYeFLz4Ee4BHJSbLY33Em7UZLtXDXDfORs6GQH0+UrYyLuymHTObmT1YvYuHcm0ZyKaIhBF6UcisHQNm+Gbg9jBap31Fues9bHIEl7IQhLRv++U48AlU5X4ca/G7xfd2gxkoSHl6LbsOlZfGEbREFbGsgCDPdGimK6s8zYBrKq/DmoeaWw0A2OkIrPX00mRdUiugBfZ81DXwMAwYU89o9B3++X8tiRkJUq5nE5GVAJfqwf8jtaZVcWTLH49eIS2WhAFr/mV7jbNzEekXHTaHyVYPvxsuZlSXgWoPsm82wO/t+JrrGN2G5L3hLLcu3h85NvKt9zRk6BVnYshYzkcV893lEn++EnsO1kpu+6vOmmMAn5RTGPjzeGc01v/a0QwyxVE4Kanig0m++efap8F8HC8PdGoPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39850400004)(346002)(136003)(376002)(82310400011)(186009)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(7696005)(40460700003)(6666004)(66899024)(83380400001)(82740400003)(356005)(81166007)(86362001)(36860700001)(47076005)(36756003)(2616005)(426003)(336012)(40480700001)(1076003)(26005)(16526019)(15650500001)(316002)(6636002)(41300700001)(8936002)(8676002)(4326008)(2906002)(70206006)(70586007)(54906003)(110136005)(478600001)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 08:15:27.8842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 232290c9-c10a-410c-af0b-08dbb81f6add
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4291
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Preferred core rankings can be changed dynamically by the
platform based on the workload and platform conditions and
accounting for thermals and aging.
When this occurs, cpu priority need to be set.

Signed-off-by: Meng Li <li.meng@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 34 ++++++++++++++++++++++++++++++++--
 include/linux/amd-pstate.h   |  6 ++++++
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 050e23594057..97b1d4674b4f 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -318,6 +318,7 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
 	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
 	WRITE_ONCE(cpudata->lowest_perf, AMD_CPPC_LOWEST_PERF(cap1));
+	WRITE_ONCE(cpudata->prefcore_ranking, AMD_CPPC_HIGHEST_PERF(cap1));
 
 	return 0;
 }
@@ -339,6 +340,7 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
 		   cppc_perf.lowest_nonlinear_perf);
 	WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
+	WRITE_ONCE(cpudata->prefcore_ranking, cppc_perf.highest_perf);
 
 	if (cppc_state == AMD_PSTATE_ACTIVE)
 		return 0;
@@ -545,7 +547,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	if (target_perf < capacity)
 		des_perf = DIV_ROUND_UP(cap_perf * target_perf, capacity);
 
-	min_perf = READ_ONCE(cpudata->highest_perf);
+	min_perf = READ_ONCE(cpudata->lowest_perf);
 	if (_min_perf < capacity)
 		min_perf = DIV_ROUND_UP(cap_perf * _min_perf, capacity);
 
@@ -765,6 +767,32 @@ static void amd_pstate_init_prefcore(unsigned int cpu)
 	}
 }
 
+static void amd_pstate_update_highest_perf(unsigned int cpu)
+{
+	struct cpufreq_policy *policy;
+	struct amd_cpudata *cpudata;
+	u32 prev_high = 0, cur_high = 0;
+	int ret;
+
+	if (!prefcore)
+		return;
+
+	ret = amd_pstate_get_highest_perf(cpu, &cur_high);
+	if (ret)
+		return;
+
+	policy = cpufreq_cpu_get(cpu);
+	cpudata = policy->driver_data;
+	prev_high = READ_ONCE(cpudata->prefcore_ranking);
+
+	if (prev_high != cur_high) {
+		WRITE_ONCE(cpudata->prefcore_ranking, cur_high);
+		sched_set_itmt_core_prio(cur_high, cpu);
+	}
+
+	cpufreq_cpu_put(policy);
+}
+
 static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 {
 	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
@@ -947,7 +975,7 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
 	u32 perf;
 	struct amd_cpudata *cpudata = policy->driver_data;
 
-	perf = READ_ONCE(cpudata->highest_perf);
+	perf = READ_ONCE(cpudata->prefcore_ranking);
 
 	return sysfs_emit(buf, "%u\n", perf);
 }
@@ -1513,6 +1541,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.suspend	= amd_pstate_cpu_suspend,
 	.resume		= amd_pstate_cpu_resume,
 	.set_boost	= amd_pstate_set_boost,
+	.update_highest_perf	= amd_pstate_update_highest_perf,
 	.name		= "amd-pstate",
 	.attr		= amd_pstate_attr,
 };
@@ -1527,6 +1556,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.online		= amd_pstate_epp_cpu_online,
 	.suspend	= amd_pstate_epp_suspend,
 	.resume		= amd_pstate_epp_resume,
+	.update_highest_perf	= amd_pstate_update_highest_perf,
 	.name		= "amd-pstate-epp",
 	.attr		= amd_pstate_epp_attr,
 };
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 446394f84606..030a6a97c2b9 100644
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
@@ -70,6 +75,7 @@ struct amd_cpudata {
 	u32	nominal_perf;
 	u32	lowest_nonlinear_perf;
 	u32	lowest_perf;
+	u32     prefcore_ranking;
 
 	u32	max_freq;
 	u32	min_freq;
-- 
2.34.1

