Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A699773FFF
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 18:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbjHHQ6X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 12:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjHHQ5a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 12:57:30 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20630.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DC94ED0;
        Tue,  8 Aug 2023 08:42:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbbJEt/+L4jSGwNUfVuolo4WVMYEBcdwUtQDXhp9fBTegU3SW1r3Z0yDC/N5fXQYh8CmqGMyR1OPoxnjeUAvAZoti+GIhc+N2/NxOAXno51bn+AOrQCdzFKPvkE/KeELeZysMZqyMlL+9B1OHFGd/9X/8KvYcdQdh3c5Qn+8dtw0hFWrB0vhQmuB6xycJaZMBuC34udxRmtqhHNG1aV/RXta/4kxaXCZBcAHn1wG84/a7KAHu589u3e0ZiFA7g7JMjXt8n5NzyUsyZG0zWkXB1vRCfVU8Kxz5f+lPojOz6KqgF8kribKo1PVVgergqBh8RIVhjxjbDmlOR9NlbFLTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWyAxOm/KrS6Wd4W8vonpzTWBRn11M0/YWdTUnEY8kI=;
 b=gwzdymPamjb1mE6Ny+M5vhJRN0c5zJD47ydQKoScIZDYL+aUrzkPCFFm/TEq3GPVR4XXxR5FjbsDozY2eXr38e1STusPnP7/uOXrwFk3Z6cQepuEpEmEB1jvQcUg824vfKLjzszxKL5napsIZppIAZEy00fSqQmvhR2YYK67wcEfqB/bArB7RNHo4JL0SrngN73p749eAW454ZdgMdzAQTywraSZgBffVUIKjCz/qKa6F8mLBpNlO9YmmurIzSDDyXK0olOyWQcHVjklJ0vR/JLWByd5yjHERSBLWTtpkoSeZzF3neVlkfphpT6NFDxj8rz+PzxESZVWlWU43K7d6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWyAxOm/KrS6Wd4W8vonpzTWBRn11M0/YWdTUnEY8kI=;
 b=zgzwIMSrpawmAs1EaciUndV3BDHKix/DDv1/f+Mwxu2Hc1ztJF7sdD+OvKZhEQ7BEiGrVPKr8OQ2CTKVS9mP2eVBVdqniiOWPhxLYQ7RhBu7/aEK0tE53UAoWURml5afrKEezg2jY5heRKyWIFtNY9pLA0v0Mw+qR9t8XJDssJ4=
Received: from SJ0PR05CA0107.namprd05.prod.outlook.com (2603:10b6:a03:334::22)
 by LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 08:11:15 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:334:cafe::3c) by SJ0PR05CA0107.outlook.office365.com
 (2603:10b6:a03:334::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.17 via Frontend
 Transport; Tue, 8 Aug 2023 08:11:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 08:11:15 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 03:11:08 -0500
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
Subject: [PATCH V1 4/6] cpufreq: amd-pstate: Update AMD Pstate Preferred Core ranking dynamically
Date:   Tue, 8 Aug 2023 16:09:59 +0800
Message-ID: <20230808081001.2215240-5-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: c50d111a-7258-48bf-ac87-08db97e70940
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yhFQrvrMw8IJY33pm1gcio0kEVhLSu44pHdVsTY3cq2cz8D6HO2YxCFITlcI7f1+LgjpQX49ylod6paUqqrtw0091EDDJ+rYqx3Wu3ijBYo+fkMXHm1ImhJR1bCJDZyCRFAXoATB9vJT1ryU0ZZQgtcwj7huiR7wi7t3rn42ufuRts9IvUxBuTmhWL+M4KGLdagY0qwhJzMouEZqTPIW3+y9uYMbxmgVVE+sCobrWf7KFnQuR9KQyl8SHNDHCk7nLYFK7QLg39AIj7SH+aMFfRguWWkIxAp7Q1Iu+NlXr5QfHezEwIn1Z9z9v/pLiEetB2B/0ToaRfNMaEykTdWIKpy4yeJg8iBxh/G4kfnFGO+ETPOT+/SMl0H71oTEU0RJVCZ12zbVW6f+ldZ9flQG0qC4VEqOKNgh9rzqqtsF5ZqdZAc/h1fCKE6ErPPKDgtANroeyiUUScDmclYjddUeKFfdT2nBjoruVN03ACPZOEKF8O39l7uUASozv0idr6Oj04DvLXV1fdvucigdBp9hQUaGMc5VKELuBlTMdqcnyk9zW5nHvtmqBOTZOxKuEp38hVi9L5MMaVtTh7as7oG372xaTBZhdfJYxYH8r2TBHBqRDzlzANmuJKlHEpco26O5Ry3SG8gA9ZUr0lVPOL6wmIplO0GTD90xLcX807/GTO6KlBX8SYhdBl9ao4BHfNcLmu4ibK6ZnwfTtTm3stUtbBEOiYd0MEGliA+TyxqwUiGrbr7SphWcYftTeaIYqpTSDtcd7sfXxO/273lvDS/Wfs7CSdgxIEZiOIgHv9DS0OfmPijBR7mFoj0JM7tFNu9+h9BtdBNAnwbYE5RUoB6iFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(90021799007)(82310400008)(1800799003)(186006)(451199021)(90011799007)(46966006)(36840700001)(40470700004)(426003)(15650500001)(1076003)(41300700001)(26005)(2906002)(5660300002)(83380400001)(8676002)(36860700001)(47076005)(8936002)(16526019)(40460700003)(2616005)(40480700001)(336012)(81166007)(6636002)(316002)(82740400003)(7696005)(70206006)(110136005)(356005)(54906003)(478600001)(70586007)(6666004)(86362001)(4326008)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 08:11:15.0123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c50d111a-7258-48bf-ac87-08db97e70940
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
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
---
 drivers/cpufreq/amd-pstate.c | 32 ++++++++++++++++++++++++++++++++
 include/linux/amd-pstate.h   |  1 +
 2 files changed, 33 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index e919b3f4ab18..ba10aa971dcb 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -320,6 +320,7 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
 	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
 	WRITE_ONCE(cpudata->lowest_perf, AMD_CPPC_LOWEST_PERF(cap1));
+	WRITE_ONCE(cpudata->prefcore_highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));
 
 	return 0;
 }
@@ -341,6 +342,7 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
 		   cppc_perf.lowest_nonlinear_perf);
 	WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
+	WRITE_ONCE(cpudata->prefcore_highest_perf, cppc_perf.highest_perf);
 
 	if (cppc_state == AMD_PSTATE_ACTIVE)
 		return 0;
@@ -743,6 +745,34 @@ static void amd_pstate_init_prefcore(void)
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
+	if (!prefcore_enabled)
+		return;
+
+	ret = amd_pstate_get_highest_perf(cpu, &highest_perf);
+	if (ret)
+		return;
+
+	policy = cpufreq_cpu_get(cpu);
+	cpudata = policy->driver_data;
+	cur_high = highest_perf;
+	prev_high = READ_ONCE(cpudata->prefcore_highest_perf);
+
+	if (prev_high != cur_high) {
+		WRITE_ONCE(cpudata->prefcore_highest_perf, cur_high);
+		sched_set_itmt_core_prio(cur_high, cpu);
+	}
+
+	cpufreq_cpu_put(policy);
+}
+
 /*
  * Check if AMD Pstate Preferred core feature is supported and enabled
  * 1) no_prefcore is used to enable or disable AMD Pstate Preferred Core
@@ -1497,6 +1527,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.suspend	= amd_pstate_cpu_suspend,
 	.resume		= amd_pstate_cpu_resume,
 	.set_boost	= amd_pstate_set_boost,
+	.update_highest_perf	= amd_pstate_update_highest_perf,
 	.name		= "amd-pstate",
 	.attr		= amd_pstate_attr,
 };
@@ -1511,6 +1542,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.online		= amd_pstate_epp_cpu_online,
 	.suspend	= amd_pstate_epp_suspend,
 	.resume		= amd_pstate_epp_resume,
+	.update_highest_perf	= amd_pstate_update_highest_perf,
 	.name		= "amd-pstate-epp",
 	.attr		= amd_pstate_epp_attr,
 };
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 446394f84606..fa86bc953d3e 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -70,6 +70,7 @@ struct amd_cpudata {
 	u32	nominal_perf;
 	u32	lowest_nonlinear_perf;
 	u32	lowest_perf;
+	u32     prefcore_highest_perf;
 
 	u32	max_freq;
 	u32	min_freq;
-- 
2.34.1

