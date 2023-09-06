Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776B8794243
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 19:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237811AbjIFRvi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 13:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjIFRvh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 13:51:37 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D19B1BEE;
        Wed,  6 Sep 2023 10:50:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWjb14uW/zl5ZiJhpdMnMaAjHbew4N4XH+H5fI3tCxfRTpKjZ894E7Z/SVstm2lH0FnOlQXX3h4R83fbdjq/b+9vaN+7Pw5qnSSoqaf5ov4gbqLOOI3BaMKemXk0k7xhNkjXW7v5lATp0FIKkb6WUK7HnZOsRaisISBIbJvnHbVAFr+fn+V24i/HoYyuJHKxwQ7FtturfeAbharT0futjV979hKvjcAQXgScW3ILBvxywgHPR5vIf7UmfrnjPnHfAlPHHjNhzWL3pp3fpoAxKcvpkGD8zWFXUTAxLnKjcXwRUDBxuvgm4R2p9AZiJC9YmZ+c2aEUI5XMhkOD87t1Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lb2jArSeuzdmxvEH+b+WIrmOlEd0m/wFiraHHeF/a/c=;
 b=aGjxWNdFVE5YuAEvGjAEZbzlT8OwYyKmGciiVVJuuYKLppe9NX/nVjj4ji0VQEXoO6/UAcnDtaI9E6v2oUepsNmqP2cI9J9Q0D14fVIUCxqlH7QoxLOaiXMlDYrc/ynPDTRg3UQwBUCl7MKk81/cQiPtEPE+bPygD1jHOSY8f2P06ukIcJo8qDitQFJIZe17zka71H5jmDzIZ9J8DXFQwr3C2WPdQG8WxrKyo0k5vsbD4NnCTsaRL8HC8+h2JbuJZ1JTGqQhtgVRcTq1F2BRmm2TtNwZD2N5rE3abFH7UUXtGfC//li05mVCguMnqFfr/MSRkLZhZvuGh5g+HE690w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lb2jArSeuzdmxvEH+b+WIrmOlEd0m/wFiraHHeF/a/c=;
 b=tokGn4Yd2pBdn3GaKwGTVnqYqy0tTsT4n5D+u1DtOeBxtaWB6mSDMxHPnMUeOfeplRurVbSvozP/dQZSP+QNoYJcbt/xF3WwUexL6j+xL6etO0KpeHvxgNW2ddAOEY35AtqyhnqWV3BBxlNvIyzCqS0B58ji9jYzZpTTpnR8W7E=
Received: from CY5PR15CA0188.namprd15.prod.outlook.com (2603:10b6:930:82::9)
 by MN2PR12MB4486.namprd12.prod.outlook.com (2603:10b6:208:263::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 17:50:22 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:82:cafe::8) by CY5PR15CA0188.outlook.office365.com
 (2603:10b6:930:82::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Wed, 6 Sep 2023 17:50:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 17:50:22 +0000
Received: from BLR-5CG13462PL.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 12:50:16 -0500
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
Subject: Re: [PATCH V5 5/7] cpufreq: amd-pstate: Update amd-pstate preferred core ranking dynamically
Date:   Wed, 6 Sep 2023 23:19:37 +0530
Message-ID: <20230906174756.n7itmfrc37crp2uz@BLR-5CG13462PL.amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905015116.2268926-6-li.meng@amd.com>
References: <20230905015116.2268926-1-li.meng@amd.com> <20230905015116.2268926-6-li.meng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|MN2PR12MB4486:EE_
X-MS-Office365-Filtering-Correlation-Id: b2dc9e82-1f1c-49e5-09d7-08dbaf01be28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O9wxqCUs6SkZG+Z3yfR0cRDKhB7BEgOnnTdcCjDuFH0e6oaZ88/gkopfhuNKyg0Deei5s6R+f7s/NHMtGK347QhQeXdjhtiYzKrNbaBTRfbStfBNYGPTafEsRwLvAsmYHmhqhFiMIL1QAbpAMK4BJBqaS36ZUrv57I/q6qJdlvP2zNMknms9WeA/3le58awwUW5Vu3OUOkWsOQsHnTDRSbVv6LWtkl/QcV1HgwWBFh3m//Fg/DH9cjUrqvBLuG8vRsI7CEB7sEXI0k1WrYeJxooEIyY7hbFPyTAgmy4RM0pY63yq0aKH8z+dQwlAvUPHNgIx9TGjog2lsHVQF9YKVIDfXwlxarkxV+FAPM9CJt/vbrhRs+TfnYs9wzFvbM2gh6dgQ313kM4JnHRSobd0Tg7X05kSCkwRUnsIw0yJI5VucigRGCUsieXDT4TGpU0VwBnbHGTCByULi4eVysNBaMXqT+nST0XDsrR3X/hoxZ7PnJCnJY9wsEh76AE2tqB04TR/Y6wLCEnpfoKs4MsjWRXlaGqUFLrJkciivrp+NW+2F+b2HiFzc6h6/BapDogjH0tZuuw2Dt7FY3whez1H8PVgHLjGfMU+bvkLfCpNaMj908fiwUftXtvHGBnup90RGuy2hvyFaD1oilM44lws4RGELFUdDLvy84lflqv5nOnftCu9VnYX4nB+NFw5SEFB3lzSRk3jD0PVs7Suj7gzHVbqMW5owgfaY53GQa/TdVv/InKHQ8KEWJJMZz6AldQK
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(82310400011)(186009)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(55016003)(66899024)(70206006)(54906003)(6636002)(70586007)(316002)(508600001)(81166007)(2906002)(356005)(86362001)(4326008)(8936002)(6862004)(44832011)(8676002)(36860700001)(83380400001)(5660300002)(15650500001)(7696005)(26005)(47076005)(16526019)(6666004)(336012)(426003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 17:50:22.2242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2dc9e82-1f1c-49e5-09d7-08dbaf01be28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4486
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Meng Li,

On 05 Sep 09:51, Meng Li wrote:
> Preferred core rankings can be changed dynamically by the
> platform based on the workload and platform conditions and
> accounting for thermals and aging.
> When this occurs, cpu priority need to be set.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> Reviewed-by: Wyes Karny <wyes.karny@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 36 ++++++++++++++++++++++++++++++++++--
>  include/linux/amd-pstate.h   | 11 +++++++++++
>  2 files changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 454eb6e789e7..8c19e1d50d29 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -318,6 +318,7 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
>  	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
>  	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
>  	WRITE_ONCE(cpudata->lowest_perf, AMD_CPPC_LOWEST_PERF(cap1));
> +	WRITE_ONCE(cpudata->cppc_highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));

Is there any reason to change this variable name form
`prefcore_highest_perf`(in v3)  to `cppc_highest_perf`?  I feel
`cppc_highest_perf` is bit confusing as there is already `highest_perf`
variable present. How about something like `prefcore_ranking` variable
name?

Thanks,
Wyes

>  
>  	return 0;
>  }
> @@ -339,6 +340,7 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
>  	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
>  		   cppc_perf.lowest_nonlinear_perf);
>  	WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
> +	WRITE_ONCE(cpudata->cppc_highest_perf, cppc_perf.highest_perf);
>  
>  	if (cppc_state == AMD_PSTATE_ACTIVE)
>  		return 0;
> @@ -545,7 +547,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>  	if (target_perf < capacity)
>  		des_perf = DIV_ROUND_UP(cap_perf * target_perf, capacity);
>  
> -	min_perf = READ_ONCE(cpudata->highest_perf);
> +	min_perf = READ_ONCE(cpudata->lowest_perf);
>  	if (_min_perf < capacity)
>  		min_perf = DIV_ROUND_UP(cap_perf * _min_perf, capacity);
>  
> @@ -748,6 +750,34 @@ static void amd_pstate_init_prefcore(void)
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
> +	prev_high = READ_ONCE(cpudata->cppc_highest_perf);
> +
> +	if (prev_high != cur_high) {
> +		WRITE_ONCE(cpudata->cppc_highest_perf, cur_high);
> +		sched_set_itmt_core_prio(cur_high, cpu);
> +	}
> +
> +	cpufreq_cpu_put(policy);
> +}
> +
>  static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  {
>  	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> @@ -912,7 +942,7 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
>  	u32 perf;
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  
> -	perf = READ_ONCE(cpudata->highest_perf);
> +	perf = READ_ONCE(cpudata->cppc_highest_perf);
>  
>  	return sysfs_emit(buf, "%u\n", perf);
>  }
> @@ -1479,6 +1509,7 @@ static struct cpufreq_driver amd_pstate_driver = {
>  	.suspend	= amd_pstate_cpu_suspend,
>  	.resume		= amd_pstate_cpu_resume,
>  	.set_boost	= amd_pstate_set_boost,
> +	.update_highest_perf	= amd_pstate_update_highest_perf,
>  	.name		= "amd-pstate",
>  	.attr		= amd_pstate_attr,
>  };
> @@ -1493,6 +1524,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>  	.online		= amd_pstate_epp_cpu_online,
>  	.suspend	= amd_pstate_epp_suspend,
>  	.resume		= amd_pstate_epp_resume,
> +	.update_highest_perf	= amd_pstate_update_highest_perf,
>  	.name		= "amd-pstate-epp",
>  	.attr		= amd_pstate_epp_attr,
>  };
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index 446394f84606..2159fd5693fe 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -31,6 +31,11 @@ struct amd_aperf_mperf {
>  	u64 mperf;
>  	u64 tsc;
>  };
> +	/* For platforms that do not support the preferred core feature, the
> +	 * highest_pef may be configured with 166 or 255, to avoid max frequency
> +	 * calculated wrongly. we take the AMD_CPPC_HIGHEST_PERF(cap1) value as
> +	 * the default max perf.
> +	 */
>  
>  /**
>   * struct amd_cpudata - private CPU data for AMD P-State
> @@ -39,11 +44,16 @@ struct amd_aperf_mperf {
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
> + * @cppc_highest_perf: the maximum performance an individual processor may reach,
> + *		  assuming ideal conditions
>   * @max_freq: the frequency that mapped to highest_perf
>   * @min_freq: the frequency that mapped to lowest_perf
>   * @nominal_freq: the frequency that mapped to nominal_perf
> @@ -70,6 +80,7 @@ struct amd_cpudata {
>  	u32	nominal_perf;
>  	u32	lowest_nonlinear_perf;
>  	u32	lowest_perf;
> +	u32     cppc_highest_perf;
>  
>  	u32	max_freq;
>  	u32	min_freq;
> -- 
> 2.34.1
> 
