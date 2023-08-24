Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F373F786DB9
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Aug 2023 13:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjHXLW0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Aug 2023 07:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbjHXLWB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Aug 2023 07:22:01 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1636710F3;
        Thu, 24 Aug 2023 04:21:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlbDPFruUAX2ulig8YHRPgQ4Wn/wwy7JJXq9AZ9Y/RRXWfhjxo5cQx81xhqt3XVLXNPDYodCfmzW4H2NH29sBGuDVVJoQpLfTaBlMb1rRbusz6fyGddcL6GnpHYAig18JQZjA9B7mXDcddJAA0krguB9Ky6YSIK/twO0EkEKkl5LC0gC4/CqrmQ8p2Jd7UO9TBQLDqScIn3pa3qwUiNbC5pAZ2bZ+B44V6t5mwaQoyDoc5uuY9RClfvkbjFUvOzqSBYaVhqOzEnrJJORk7njW5pVA8kNj8HVSeqQRAuJPAIB/QXbx0ifu5zD80y0k3BTYYEYJjTBQJk+AMlj0as7hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5JIVHAuRaJhgukJysK0YHOgshPhS0vlrpnqmZB2AFo=;
 b=ZBQqTQr1rF+yWAsuE/UzypDfPlRkmcVY4I/aUFxjbScxuwjrPApz+dtlLDhW2mMo600wEsIp7GiIV6mKmr2sVpxZSa+5qONixEqkZMbx35XFIGWQ4sMkBPuXwKjEZE4Bon1+eCv0sPMuhZHuwxJDe0q0tCtqtaVBXnbPoPTOTWTjL4Hxcln4GFaoS7aW51FQtmOZyEA5Tq8gzvpFWfZldF5P6fdyL9netE432M3lWTmoZebysCKLJqwxEvV5UUr38VdYzBBparddwiz0QxVZPa/ClGGlP+V13UGrwEO5lnRZks/bDX4JEDaK/Y3W3UBGTQD7lSiBMX1v6SoVEt6jhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5JIVHAuRaJhgukJysK0YHOgshPhS0vlrpnqmZB2AFo=;
 b=a2EOssTXolGUplp1t+SSGOKaGz1zKAkNeh1g84Wka8IfqVBIQ81ag+O5DysI0Ljdo6FIxJtVfPeP5iyuidmRWSZ+GEDKFDDhQ+zYhBAtWhXO2w7aktzsaCQO9jViJPWmeHhsQPmCXRYgeGn+wsyFMF0wKMGCRIx+uiVJeFuVvG4=
Received: from SA1P222CA0186.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::18)
 by DM4PR12MB9069.namprd12.prod.outlook.com (2603:10b6:8:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 11:21:54 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:3c4:cafe::7f) by SA1P222CA0186.outlook.office365.com
 (2603:10b6:806:3c4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 11:21:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 24 Aug 2023 11:21:53 +0000
Received: from BLR-5CG13462PL.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 06:21:11 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     Meng Li <li.meng@amd.com>
CC:     Wyes Karny <wyes.karny@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-acpi@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH V3 5/7] cpufreq: amd-pstate: Update AMD Pstate Preferred Core ranking dynamically
Date:   Thu, 24 Aug 2023 16:48:44 +0530
Message-ID: <20230824110949.362p6kpcgqlfa5cj@BLR-5CG13462PL.amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824021249.271946-6-li.meng@amd.com>
References: <20230824021249.271946-1-li.meng@amd.com> <20230824021249.271946-6-li.meng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|DM4PR12MB9069:EE_
X-MS-Office365-Filtering-Correlation-Id: 98cd2735-6af7-4eac-95dc-08dba49451f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: saYUkEtias0cNMY2s5CAuan6QjYfUnQ9mE7H7ZSxjcWEE/5lFb8XoDdv5xa67FR+5ZEONRjRT7+WXY/59/p9ANXEnXJ1G4lnGTVMrcKyEjYUIOFqVU9yC94YNwLeveHLRwKX3l5T7yslc9d5HyxR0XPOK1LynIVJB0hlkY5ZtIAR9glNCF7eYyGkmAhLbGd7vWmeWgSDMuRkg6qz1ugjQaJe3bxggFbId3/kRDy5yLItDJW53o2a/t4fEMOe6MnAStET9w7PFRbiAZllTiwoiDfB05a7tDeezgxREv2A33gBWJOsSAK/9PdAtK2rxHRT7PJGZf2zImOEq3xa4GJxFRszttHyGavqCiZ6AWbC5WTm2YgbsKJ2o9LmDSpF6Z7xCL9lyKet3MfkgFBLoty5s0jez26X0sfphKJTUEALbBiyynfDLi79//4KW9hVxzaJ7sEFopY/sIJl6LLYrKdkyCmjaBnfba4GELacVWZezYPxpoFyxLMsNbqapfDqorQLzIQ0iQ/wtzb7A8jCWSjnpbLQlFzn8egck4+IhLgLWIWkQ/auYYlpTeMAs/pL+U5iEmhor4jUPbARxVABL0ow4q96k2ihHxBvREr9ecMg+9vEHpRv8Xn4vMTqhl/843zKrIHEuitHJMn8J52sKBkWV6RrN3XOB9DV07tIXk0Dgy9+MYGmryr9zUyAZgF0/9V6J4MTb7a/ZVIA0UqUls144bZMbAWKK9YdoqJUymvrq/bGc+wNgx7iucHMiaWmnbegHY6iyBDRcDbqCOtEjEvHXg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199024)(82310400011)(186009)(1800799009)(46966006)(36840700001)(40470700004)(54906003)(6636002)(70586007)(70206006)(316002)(81166007)(478600001)(55016003)(26005)(36860700001)(44832011)(356005)(6666004)(16526019)(40480700001)(82740400003)(41300700001)(86362001)(2906002)(7696005)(8676002)(8936002)(4326008)(6862004)(1076003)(40460700003)(5660300002)(83380400001)(15650500001)(336012)(47076005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 11:21:53.9858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98cd2735-6af7-4eac-95dc-08dba49451f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9069
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 24 Aug 10:12, Meng Li wrote:
> Preferred core rankings can be changed dynamically by the
> platform based on the workload and platform conditions and
> accounting for thermals and aging.
> When this occurs, cpu priority need to be set.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 32 ++++++++++++++++++++++++++++++++
>  include/linux/amd-pstate.h   |  1 +
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index d02305675f66..8a8e4ecb1b5c 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -315,6 +315,7 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
>  	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
>  	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
>  	WRITE_ONCE(cpudata->lowest_perf, AMD_CPPC_LOWEST_PERF(cap1));
> +	WRITE_ONCE(cpudata->prefcore_highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));
>  
>  	return 0;
>  }
> @@ -336,6 +337,7 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
>  	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
>  		   cppc_perf.lowest_nonlinear_perf);
>  	WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
> +	WRITE_ONCE(cpudata->prefcore_highest_perf, cppc_perf.highest_perf);
>  
>  	if (cppc_state == AMD_PSTATE_ACTIVE)
>  		return 0;
> @@ -744,6 +746,34 @@ static void amd_pstate_init_prefcore(void)
>  	schedule_work(&sched_prefcore_work);
>  }
>  
> +static void amd_pstate_update_highest_perf(unsigned int cpu)
> +{
> +	struct cpufreq_policy *policy;
> +	struct amd_cpudata *cpudata;
> +	u32 prev_high = 0, cur_high = 0;
> +	u64 highest_perf;
> +	int ret;
> +
> +	if (!prefcore)
> +		return;
> +
> +	ret = amd_pstate_get_highest_perf(cpu, &highest_perf);
> +	if (ret)
> +		return;
> +
> +	policy = cpufreq_cpu_get(cpu);
> +	cpudata = policy->driver_data;
> +	cur_high = highest_perf;
> +	prev_high = READ_ONCE(cpudata->prefcore_highest_perf);
> +
> +	if (prev_high != cur_high) {
> +		WRITE_ONCE(cpudata->prefcore_highest_perf, cur_high);
> +		sched_set_itmt_core_prio(cur_high, cpu);
> +	}
> +
> +	cpufreq_cpu_put(policy);
> +}
> +
>  static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  {
>  	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> @@ -1468,6 +1498,7 @@ static struct cpufreq_driver amd_pstate_driver = {
>  	.suspend	= amd_pstate_cpu_suspend,
>  	.resume		= amd_pstate_cpu_resume,
>  	.set_boost	= amd_pstate_set_boost,
> +	.update_highest_perf	= amd_pstate_update_highest_perf,
>  	.name		= "amd-pstate",
>  	.attr		= amd_pstate_attr,
>  };
> @@ -1482,6 +1513,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>  	.online		= amd_pstate_epp_cpu_online,
>  	.suspend	= amd_pstate_epp_suspend,
>  	.resume		= amd_pstate_epp_resume,
> +	.update_highest_perf	= amd_pstate_update_highest_perf,
>  	.name		= "amd-pstate-epp",
>  	.attr		= amd_pstate_epp_attr,

If we intend to use the existing `update_limits` callback then this
patch needed to update. Otherwise looks good to me.

Reviewed-by: Wyes Karny <wyes.karny@amd.com>

>  };
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index 446394f84606..fa86bc953d3e 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -70,6 +70,7 @@ struct amd_cpudata {
>  	u32	nominal_perf;
>  	u32	lowest_nonlinear_perf;
>  	u32	lowest_perf;
> +	u32     prefcore_highest_perf;
>  
>  	u32	max_freq;
>  	u32	min_freq;
> -- 
> 2.34.1
> 
