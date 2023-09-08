Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A18479837C
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 09:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbjIHHs1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 03:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbjIHHs0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 03:48:26 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D84A1FEF;
        Fri,  8 Sep 2023 00:48:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkOpA3dEkxcI1pY1Kicb53oP37L0CatVjfsnYR6fLLy6K1b2DmvE7/dACLjuMWSouo2W5ZcDLqffWvkJ31Px+0lWS9GWYhdpseB83OPa2ZuwrMdX4jBQEF7D5mss8ujxmGtuK9Gwm03byJZowWqczqi7rBBjEGKH6vMcUXQHCjbL8Nh3dpkLT6OYOS3fjnWI/ab6xc/dmCGqRB7Z5H+OZoUwNzW2nM5FjTTAcUGEzCiYYqqKMYNDmFe6fdIpy2lyn2GHH9/NRlD+NWwGAX6TIAcFn7GPPqlPNXzoQbzyDgV/Gs1/SF2ZBlB2nlDNYchn/OkHNEGizjvOTHkC02oHgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZksqvahjHntzxuO3bOkipwjvstsYkpbVDxx74PCi8zo=;
 b=BWnkigHk+BxE+lqmslqlVWT9oxfD0uhdbb7m2zLcegDqaHDRM/5iP3Kp6qGBhqPxNm617Ls+7nEM7n21dWGSYatZB4IAYLGT5XIei2kn6mva5GsDIS9NJBldmv3F4HzXGacu/Nvkn3iZIGqmNzsHPKYLVOWFPTOlfvsjQ46zMz5VGWcK/8t579pWA2dBgzYK7Hn/MzKqOcZ5Xsdtti4o2ITiEmLhmPL4QCjBZ1eiwtvHaOohrncZw7Jf0HE/P42X+31mcE1WZ9FURKc212awn+azZ9f2rB835CoaaOImNrKnmTKwapKMvD2+TfdFYWEYsQIw5ENKSL9yGIqKXqqFvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZksqvahjHntzxuO3bOkipwjvstsYkpbVDxx74PCi8zo=;
 b=MI9JlU+nYOTlE2a5O9dFoV3QSte8SP3LUm3gNbNRGU3Fop0sAAgw0FYhJaf86JoYwCbxjJISYxpn4WJlERmPCpQUrNCjrCqUsaFaXV+rqKZFK51CrvWdojNniaMwSfIj2dQQLc4M3qD3f0G+rWPMf6MBUF+LlSdw5Qh4wJZUAnI=
Received: from MW3PR05CA0002.namprd05.prod.outlook.com (2603:10b6:303:2b::7)
 by PH0PR12MB7789.namprd12.prod.outlook.com (2603:10b6:510:283::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 07:47:59 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:2b:cafe::d0) by MW3PR05CA0002.outlook.office365.com
 (2603:10b6:303:2b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.10 via Frontend
 Transport; Fri, 8 Sep 2023 07:47:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.1 via Frontend Transport; Fri, 8 Sep 2023 07:47:59 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Sep
 2023 02:47:54 -0500
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
Subject: [PATCH V6 5/7] cpufreq: amd-pstate: Update amd-pstate preferred core ranking dynamically
Date:   Fri, 8 Sep 2023 15:46:51 +0800
Message-ID: <20230908074653.2799055-6-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908074653.2799055-1-li.meng@amd.com>
References: <20230908074653.2799055-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|PH0PR12MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: 32c97e22-0a32-4cfa-3914-08dbb03fec57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AgmLBK3HCU4F2YfeJhWaqY+3DnLmRs/zd48Dg0Z6Lb3oRkdVAwJKluFo5Ju0Mc4y9FWHM57cMGe7/4iqwTgbkY34oLrXzhO7OPJvLxDVVzJZpUOQ2Td3LievJKiQP8Lxi6NXgZ69vEBPF7d96CTABuzkUYycPWdDwZ9IG30Y9hw9QTQiU028twqra/vKF7veU3iASfBeI/x0TzdOwrkfQ5o4KjyMOkeMhJVB2DI105NwwZZiVMCkmv4onXljczL+Bn3kBpKY5RvZoj0e38FSFtNz+Vy2zjID4ifVW/QLVl05/QOX0zEB/MHO/VPS6hKgWairddHSdB3OZXwPsEMDQ2v7Kd19xdk2dbiUVdFHaZBhf/QGEvvhbdUvTkkvdpV594xEiEDx9fU3mfyYhmlQ572meZVujnCPBVLvWMQuFfkKOwCSrYSdH/NlyU3UmL1L17VwgEeq7ido2jevDDgQSblFA5jM594l0t38x/jVaSXPkjzVNQfE+/7euExHWI1ZeNn1ulzF07q7t/lo65AzMufdoZO+uvV3RaDAme51EfNAttv1zHtAYITGLP4STQJTljfUz1PzZdgyy6sQC97tjBt+aw5w1Sfxg1y0lflcXnvjbxAEWSQr0nbV6NcMYKWyag7fqKqSFzu7tkULkVogi6Pvsw29O2O2a8XaR6crmDtDX22I3SGoI74+zU6m/DIQciv1jt3gPbnxx2chy77EBuI2GnXYIOBmsmzgDRKi3r2rMAnJ5x+gsOrM7VFeqcRyw1rC0UuDv9VhuiQYpz+aLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(186009)(1800799009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(7696005)(40460700003)(41300700001)(66899024)(316002)(81166007)(82740400003)(36756003)(2906002)(478600001)(86362001)(356005)(110136005)(70206006)(54906003)(70586007)(6636002)(6666004)(15650500001)(40480700001)(83380400001)(2616005)(5660300002)(1076003)(47076005)(8936002)(4326008)(8676002)(16526019)(26005)(426003)(336012)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 07:47:59.6218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c97e22-0a32-4cfa-3914-08dbb03fec57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7789
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
 include/linux/amd-pstate.h   |  6 ++++++
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index c71a91321384..1c1a76b5ca58 100644
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
 
@@ -749,6 +751,34 @@ static void amd_pstate_init_prefcore(void)
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
@@ -913,7 +943,7 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
 	u32 perf;
 	struct amd_cpudata *cpudata = policy->driver_data;
 
-	perf = READ_ONCE(cpudata->highest_perf);
+	perf = READ_ONCE(cpudata->prefcore_ranking);
 
 	return sysfs_emit(buf, "%u\n", perf);
 }
@@ -1473,6 +1503,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.suspend	= amd_pstate_cpu_suspend,
 	.resume		= amd_pstate_cpu_resume,
 	.set_boost	= amd_pstate_set_boost,
+	.update_highest_perf	= amd_pstate_update_highest_perf,
 	.name		= "amd-pstate",
 	.attr		= amd_pstate_attr,
 };
@@ -1487,6 +1518,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
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

