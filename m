Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46861792586
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 18:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239207AbjIEQH2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 12:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245141AbjIEBwT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Sep 2023 21:52:19 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B0DCC5;
        Mon,  4 Sep 2023 18:52:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzQ9pqWC/Ha+2crKL6xWxsgS8UnEJUUgQVmquSGdpiosUXUpSe9mglHT7S5hsLJlllLuJsynZS+ZUfHanRLFqCvD/rbzT3gXqiFKkgRvwVxsvJLanLidE7cbc1Y/+GzjV8iV/c9oFZ+cXhRjktJvo0+MwcYi1C9xFpjfqfVwj/dIA5qWneFQskBJtAkwqrxpHfEcSyE9W1NuCsDwaMPVMquoQRa8/dlerbNz3duxFIycfyfoyN+R1trEgzGwB+3e0ctjddmhEXyu+z9zkGrKbTgAQURQJVG0c4NRI0fHP2oyqTQ62VNzb+fjCnDKNqlz4IM0mHQlxmEI9HMLgGfRig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6THLQIllZhI0VKQqhm+jmtQdk2+/pQOXoMZ2tUvz/Po=;
 b=k60m8Bu/p8UjQRQ2uA6X0vvJg911+qv/fFcqyfgSkBL7dQFJKTrZP3yEzBJpO7+eFrTa68z2AKQE/jdZra0iZp70AIBxBp5kg5i6XtqGJ9lHfhAKGPnO2IfYhnRsrzkETubCpNz5mWPi7yQzdeIB4TUs4Kd8XMmy6kqUScNfUkMIslBOhK1RedzntZ7OBBq+mQKtn2949WwPsOWHNT7xJQNHjIZD5J77mfcXNR/bTmWtONkQ2Ismn4+UQ3Fp+SdjFuPzF+2LNih9PH9xrU23cFNmYmF1/LQwMQGSTMQdqcQSmuSL4ml7oSSrZSls9d9cxUT7fBpqwaK58aEft6kzDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6THLQIllZhI0VKQqhm+jmtQdk2+/pQOXoMZ2tUvz/Po=;
 b=oz2gzQF1B0vzXFd9QKT2OpldT1J9bYlShuLHQHWS8AOvtY4RnWK2z8EkDnptBpX9UD/nxSQFg4KIWoanaXbQ1QaEswqJ2sQQMJG+RcTUVq5Fk2GnVyLuLsguoWQGyGiNZp88q+KZq+nngJCUQBDgxbYz4rAVE/oBr7ZHigOc5hk=
Received: from CY5PR17CA0002.namprd17.prod.outlook.com (2603:10b6:930:17::22)
 by MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Tue, 5 Sep
 2023 01:52:12 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:930:17:cafe::7) by CY5PR17CA0002.outlook.office365.com
 (2603:10b6:930:17::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Tue, 5 Sep 2023 01:52:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 01:52:11 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 4 Sep
 2023 20:52:06 -0500
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
Subject: [PATCH V5 5/7] cpufreq: amd-pstate: Update amd-pstate preferred core ranking dynamically
Date:   Tue, 5 Sep 2023 09:51:14 +0800
Message-ID: <20230905015116.2268926-6-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|MN2PR12MB4422:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d026350-e1d3-466d-9cea-08dbadb2b88d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2aZ6EoHnegQSFQJxZWXMfFHaG2nOdLVwlp2NsBB+oVytVhEJPtpfVZCvP+nv3zv9DTo+aizTDElHqrEdEw68n826bxx8EnfHkmNYBOtVb8E073RiB+Wd+avSQl9kEyTY20/7CKm5Z6SZPe7xv3n3sJzStJq0dddinSipdKF2Ptv1hp3sRoLv3AgnHjXW9i62xjyOsUClvMOvGbygbxLbqqYPmTG86qpAEcVvIWqgAU7WWEG9EoTKZsC6Zzaxf6xFCO06F8AeofUIHlZfliVeiSTJJ7X5xlhdBnar2nfB5kXt1scCO6JMCyUfyyfhJiMlhL90UhsdLBnb2abLdGCNIcLexvdHXFWuu7zs9SiVofOD5DE67vo7SDdF86zY3ZZ/C/9xVkx4p7wJzylKLQc1B4+/b5wI4kF49ZhjPZhWQJA+O05Suzn5ItZrJ9jE0335I+5MryZNNBOqWvlIReJpvnIkmkVIjOnkt1B0eTIs9JnxHQkO9AZUwIiuD4FZ0fa5/0nh6jXKVIQ490tWDfLpjHBscyxG89sUKIOlfHKvjNzI21HHrpVO7+R+8rfCJzGvBADMVc0A0MZ8REH/Lh68wcQ3/CP3zbMw6zTV/Kzn8ac8ea7wMyi+WITsAHkQQOUTFwzuXFeq6iBQwCEW7tbMcDFKK2pWbgtdtEcSWYmddITH2Bccre2r2Bpjp7+eFJFEDQEY2FDW6CQWmvsPRVcseGiwNWT7BoeU9EUB+zyBATNH+HqPRyET+SqsP9MeCH3BWihZeF0F/bfgxD9ZPBlieQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(136003)(346002)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(40460700003)(41300700001)(66899024)(7696005)(6666004)(356005)(82740400003)(81166007)(478600001)(83380400001)(2616005)(26005)(336012)(16526019)(1076003)(36860700001)(47076005)(426003)(15650500001)(40480700001)(70206006)(36756003)(2906002)(110136005)(316002)(54906003)(6636002)(70586007)(86362001)(5660300002)(8936002)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 01:52:11.4192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d026350-e1d3-466d-9cea-08dbadb2b88d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4422
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
 drivers/cpufreq/amd-pstate.c | 36 ++++++++++++++++++++++++++++++++++--
 include/linux/amd-pstate.h   | 11 +++++++++++
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 454eb6e789e7..8c19e1d50d29 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -318,6 +318,7 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
 	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
 	WRITE_ONCE(cpudata->lowest_perf, AMD_CPPC_LOWEST_PERF(cap1));
+	WRITE_ONCE(cpudata->cppc_highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));
 
 	return 0;
 }
@@ -339,6 +340,7 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
 		   cppc_perf.lowest_nonlinear_perf);
 	WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
+	WRITE_ONCE(cpudata->cppc_highest_perf, cppc_perf.highest_perf);
 
 	if (cppc_state == AMD_PSTATE_ACTIVE)
 		return 0;
@@ -545,7 +547,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	if (target_perf < capacity)
 		des_perf = DIV_ROUND_UP(cap_perf * target_perf, capacity);
 
-	min_perf = READ_ONCE(cpudata->highest_perf);
+	min_perf = READ_ONCE(cpudata->lowest_perf);
 	if (_min_perf < capacity)
 		min_perf = DIV_ROUND_UP(cap_perf * _min_perf, capacity);
 
@@ -748,6 +750,34 @@ static void amd_pstate_init_prefcore(void)
 	schedule_work(&sched_prefcore_work);
 }
 
+static void amd_pstate_update_highest_perf(unsigned int cpu)
+{
+	struct cpufreq_policy *policy;
+	struct amd_cpudata *cpudata;
+	u32 prev_high = 0, cur_high = 0;
+	u64 highest_perf;
+	int ret;
+
+	if (!prefcore)
+		return;
+
+	ret = amd_pstate_get_highest_perf(cpu, &highest_perf);
+	if (ret)
+		return;
+
+	policy = cpufreq_cpu_get(cpu);
+	cpudata = policy->driver_data;
+	cur_high = highest_perf;
+	prev_high = READ_ONCE(cpudata->cppc_highest_perf);
+
+	if (prev_high != cur_high) {
+		WRITE_ONCE(cpudata->cppc_highest_perf, cur_high);
+		sched_set_itmt_core_prio(cur_high, cpu);
+	}
+
+	cpufreq_cpu_put(policy);
+}
+
 static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 {
 	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
@@ -912,7 +942,7 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
 	u32 perf;
 	struct amd_cpudata *cpudata = policy->driver_data;
 
-	perf = READ_ONCE(cpudata->highest_perf);
+	perf = READ_ONCE(cpudata->cppc_highest_perf);
 
 	return sysfs_emit(buf, "%u\n", perf);
 }
@@ -1479,6 +1509,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.suspend	= amd_pstate_cpu_suspend,
 	.resume		= amd_pstate_cpu_resume,
 	.set_boost	= amd_pstate_set_boost,
+	.update_highest_perf	= amd_pstate_update_highest_perf,
 	.name		= "amd-pstate",
 	.attr		= amd_pstate_attr,
 };
@@ -1493,6 +1524,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.online		= amd_pstate_epp_cpu_online,
 	.suspend	= amd_pstate_epp_suspend,
 	.resume		= amd_pstate_epp_resume,
+	.update_highest_perf	= amd_pstate_update_highest_perf,
 	.name		= "amd-pstate-epp",
 	.attr		= amd_pstate_epp_attr,
 };
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 446394f84606..2159fd5693fe 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -31,6 +31,11 @@ struct amd_aperf_mperf {
 	u64 mperf;
 	u64 tsc;
 };
+	/* For platforms that do not support the preferred core feature, the
+	 * highest_pef may be configured with 166 or 255, to avoid max frequency
+	 * calculated wrongly. we take the AMD_CPPC_HIGHEST_PERF(cap1) value as
+	 * the default max perf.
+	 */
 
 /**
  * struct amd_cpudata - private CPU data for AMD P-State
@@ -39,11 +44,16 @@ struct amd_aperf_mperf {
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
+ * @cppc_highest_perf: the maximum performance an individual processor may reach,
+ *		  assuming ideal conditions
  * @max_freq: the frequency that mapped to highest_perf
  * @min_freq: the frequency that mapped to lowest_perf
  * @nominal_freq: the frequency that mapped to nominal_perf
@@ -70,6 +80,7 @@ struct amd_cpudata {
 	u32	nominal_perf;
 	u32	lowest_nonlinear_perf;
 	u32	lowest_perf;
+	u32     cppc_highest_perf;
 
 	u32	max_freq;
 	u32	min_freq;
-- 
2.34.1

