Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0135C7BD33F
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 08:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345173AbjJIGUX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 02:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345169AbjJIGUW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 02:20:22 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBF99E;
        Sun,  8 Oct 2023 23:20:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JK1kyFfEazSem+s0Uh37iri4v9Uin7rqzfw91p179Kj2v5RzuK6k2Yxf8Vf1OR/O9W/o3TvW6oU/I+0KuZmLL3S0vtT2yy8XRq8U5SDN3jhW9scCQVAxhIPib9K159h+IWhGA6RlOeYyOaxN4kTxRCdADylrSL/G5GCYu3JGVdVfefUzo0LJ1Q/i9nTHOitkaJ3ltuN3ETe9jcUqu4u2goZoe9JwQk5Q7wz0xGRalGbigTk35oUOtfAlPvq4l1LQRCQNdb2Qmu8W4V4gI9sXdKKZgleupM/j49uzjOWYz+sMPzo9cmq1ep74+topyfWnteaGEoj4CKfLyeNF4bsXNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+czbV60qyfk9+lStSbdAQW0uZklcKTTLsHqFwH3U7wA=;
 b=N5hpsm1rkWx3JiNM7R/EYzKx6P1EMazXBjKDHaoTyEpjoIomdzsVFepPFoWyzkhr6OKMoNFluR/bgs7qHLFc2T9Cf+nbSR5h0vDmJ+WOt5pn6Ff21pm+MJv3FGCUFdjCdMVHWJDXFGwrTcS2TbMkg3y+sPlI9W4oOGv41/LMnjbjsL3jBFZKMsM+Ru+0LW/rwJ0wMF+bS7s9g/80dgzofWog6eAvDAJoWrwLpKpdPPaOMjtid0qCC0P/XdJRtpNEsyvNNDWJ+wEJlD40XvFI9DDFUTPIR+iKrzsKfJ7Ip6srJiQo7VdtHKDnaMouB5eXFJC56ezhIzdpilRzuBVtKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+czbV60qyfk9+lStSbdAQW0uZklcKTTLsHqFwH3U7wA=;
 b=FWxH9xicjPH4u567k210o4kRYXf7Pq+C50DYeloqA9Q9zxEa1MVlYyYvqeBWtQsrx83mQ1R5Y2MAHNf9KKCnNhh5nK/0EoqdPK0cdlqreexLGiRzKy8wIvIq8XxFsLemaKfN3Rvq+1UA6xLzBbnBFGMl6fuR5oIUNoI36FS/tyo=
Received: from MW2PR16CA0008.namprd16.prod.outlook.com (2603:10b6:907::21) by
 SJ1PR12MB6316.namprd12.prod.outlook.com (2603:10b6:a03:455::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Mon, 9 Oct
 2023 06:20:16 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:907:0:cafe::ab) by MW2PR16CA0008.outlook.office365.com
 (2603:10b6:907::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Mon, 9 Oct 2023 06:20:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 06:20:16 +0000
Received: from BLR-5CG13462PL.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 01:20:08 -0500
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
Subject: Re: [PATCH V8 5/7] cpufreq: amd-pstate: Update amd-pstate preferred core ranking dynamically
Date:   Mon, 9 Oct 2023 11:49:04 +0530
Message-ID: <20231009061621.vrpzz5aaqiv56grh@BLR-5CG13462PL.amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009024932.2563622-6-li.meng@amd.com>
References: <20231009024932.2563622-1-li.meng@amd.com> <20231009024932.2563622-6-li.meng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|SJ1PR12MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: 2846d1e1-87b6-45ab-d1fe-08dbc88fcdd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iryX0i+UOM6Gtpl7pHmcnfTCP8e4XTtBi4mNvJeOSvukqGMGPRk7Y8pdJiosFyaUyM3oNwYcBBfeoXK55YCj1PW4gW/5Gn8TsLR9KUJF88Gv433gfj/hdga1PZ/7wox3fJVxYaSfsWCg6zZtRv4yHY6MOIj8Y5Et7xq/GKeYgrffJjTmpyjosLsLa5eYITA6B3+iOyeSaCazUVXF/1ec4s+qTydIuwchoXEzPc7JjQliSHRL0YtBMthalbNjeTyHZu4Y9DhPdVhnujKZFRN4D7145H8EYa+Yo+y8fASvNsvklSZOO03San5XqHi9oDpPdHufUYBorkRb5SIaqaHnCAjh2hn7C4cB4GAREaw3FpaUQH8j9L+6ZsXX3ewx4d4dRqawEXoCIqLDJEr764LzRv9n3riRon+KwvyB3WrsRhemHqHMIDUGJIi/3WLQmfHRovtjAz5ExFp9PtcmUkG5DSoBf0VzGeNhLprtIVbvjmndYU1gwQzcZfY+HKMVXnQieW0mLNJoB7REf66ZfyheJgrqpapC7EtTWk35cXewp3eV4h45e/+nWrDezHA6q8Czw2l4mmw6eg0iIf/jLI3WQghRAiBhF4Tzk9VUMq49Z5/wl2UbsUpPagE9f19K6STjm+qql6UriTvtYIRrUixg0aj5koIA2FG/uGXJlJMeD+xJnRRcZpuHPfmUz2A/80RuBqBVMQZMvdxdweTF49K4VZHHITsWzVMgrHX0mr49R4dNOsikZt51/Rt4pmdSc8IOFTjhePDYfTe9qzgAUQSO9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799009)(36840700001)(46966006)(40470700004)(1076003)(66899024)(82740400003)(55016003)(40460700003)(40480700001)(7696005)(478600001)(6666004)(356005)(47076005)(15650500001)(86362001)(36860700001)(81166007)(6862004)(2906002)(336012)(41300700001)(316002)(83380400001)(26005)(16526019)(426003)(8676002)(44832011)(5660300002)(6636002)(54906003)(70206006)(8936002)(4326008)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 06:20:16.0518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2846d1e1-87b6-45ab-d1fe-08dbc88fcdd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6316
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Meng Li,

On 09 Oct 10:49, Meng Li wrote:
> Preferred core rankings can be changed dynamically by the
> platform based on the workload and platform conditions and
> accounting for thermals and aging.
> When this occurs, cpu priority need to be set.
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Wyes Karny <wyes.karny@amd.com>
> Reviewed-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 34 ++++++++++++++++++++++++++++++++--
>  include/linux/amd-pstate.h   |  6 ++++++
>  2 files changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 6ac8939fce5a..d3369247c6c9 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -313,6 +313,7 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
>  	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
>  	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
>  	WRITE_ONCE(cpudata->lowest_perf, AMD_CPPC_LOWEST_PERF(cap1));
> +	WRITE_ONCE(cpudata->prefcore_ranking, AMD_CPPC_HIGHEST_PERF(cap1));
>  
>  	return 0;
>  }
> @@ -334,6 +335,7 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
>  	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
>  		   cppc_perf.lowest_nonlinear_perf);
>  	WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
> +	WRITE_ONCE(cpudata->prefcore_ranking, cppc_perf.highest_perf);
>  
>  	if (cppc_state == AMD_PSTATE_ACTIVE)
>  		return 0;
> @@ -540,7 +542,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>  	if (target_perf < capacity)
>  		des_perf = DIV_ROUND_UP(cap_perf * target_perf, capacity);
>  
> -	min_perf = READ_ONCE(cpudata->highest_perf);
> +	min_perf = READ_ONCE(cpudata->lowest_perf);

This seems to be a fix. So, this could be a separate patch.

>  	if (_min_perf < capacity)
>  		min_perf = DIV_ROUND_UP(cap_perf * _min_perf, capacity);
>  
> @@ -760,6 +762,32 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
>  	}
>  }
>  
> +static void amd_pstate_update_highest_perf(unsigned int cpu)
> +{
> +	struct cpufreq_policy *policy;
> +	struct amd_cpudata *cpudata;
> +	u32 prev_high = 0, cur_high = 0;
> +	int ret;
> +
> +	if ((!amd_pstate_prefcore) || (!cpudata->hw_prefcore))
> +		return;
> +
> +	ret = amd_pstate_get_highest_perf(cpu, &cur_high);
> +	if (ret)
> +		return;
> +
> +	policy = cpufreq_cpu_get(cpu);
> +	cpudata = policy->driver_data;
> +	prev_high = READ_ONCE(cpudata->prefcore_ranking);
> +
> +	if (prev_high != cur_high) {
> +		WRITE_ONCE(cpudata->prefcore_ranking, cur_high);
> +		sched_set_itmt_core_prio(cur_high, cpu);
> +	}
> +
> +	cpufreq_cpu_put(policy);
> +}
> +
>  static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  {
>  	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> @@ -926,7 +954,7 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
>  	u32 perf;
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  
> -	perf = READ_ONCE(cpudata->highest_perf);
> +	perf = READ_ONCE(cpudata->prefcore_ranking);

I think this should show cpudata->highest_perf.

Thanks,
Wyes
>  
>  	return sysfs_emit(buf, "%u\n", perf);
>  }
> @@ -1502,6 +1530,7 @@ static struct cpufreq_driver amd_pstate_driver = {
>  	.suspend	= amd_pstate_cpu_suspend,
>  	.resume		= amd_pstate_cpu_resume,
>  	.set_boost	= amd_pstate_set_boost,
> +	.update_highest_perf	= amd_pstate_update_highest_perf,
>  	.name		= "amd-pstate",
>  	.attr		= amd_pstate_attr,
>  };
> @@ -1516,6 +1545,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>  	.online		= amd_pstate_epp_cpu_online,
>  	.suspend	= amd_pstate_epp_suspend,
>  	.resume		= amd_pstate_epp_resume,
> +	.update_highest_perf	= amd_pstate_update_highest_perf,
>  	.name		= "amd-pstate-epp",
>  	.attr		= amd_pstate_epp_attr,
>  };
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index 87e140e9e6db..426822612373 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -39,11 +39,16 @@ struct amd_aperf_mperf {
>   * @cppc_req_cached: cached performance request hints
>   * @highest_perf: the maximum performance an individual processor may reach,
>   *		  assuming ideal conditions
> + *		  For platforms that do not support the preferred core feature, the
> + *		  highest_pef may be configured with 166 or 255, to avoid max frequency
> + *		  calculated wrongly. we take the fixed value as the highest_perf.
>   * @nominal_perf: the maximum sustained performance level of the processor,
>   *		  assuming ideal operating conditions
>   * @lowest_nonlinear_perf: the lowest performance level at which nonlinear power
>   *			   savings are achieved
>   * @lowest_perf: the absolute lowest performance level of the processor
> + * @prefcore_ranking: the preferred core ranking, the higher value indicates a higher
> + * 		  priority.
>   * @max_freq: the frequency that mapped to highest_perf
>   * @min_freq: the frequency that mapped to lowest_perf
>   * @nominal_freq: the frequency that mapped to nominal_perf
> @@ -73,6 +78,7 @@ struct amd_cpudata {
>  	u32	nominal_perf;
>  	u32	lowest_nonlinear_perf;
>  	u32	lowest_perf;
> +	u32     prefcore_ranking;
>  
>  	u32	max_freq;
>  	u32	min_freq;
> -- 
> 2.34.1
> 
