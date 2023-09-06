Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FD0793E14
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 15:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbjIFNxa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 09:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbjIFNx0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 09:53:26 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36887CF1;
        Wed,  6 Sep 2023 06:53:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7ylXZhNkEDmWkHNovnpux6ipbSqYqsCFfg/RHswCPb4U95B9L7cOs5ojt4QFplOQQgBEKZL7gryNUBJ5igP3fOdFAarrYlqVO/aHW6o8cW9iisCtij17HZWcucVzWfa6FCSR5WumAhErVKVpFDPw4uAydRSjiLask6DrzpHN8w2NbnltchQV+Hzdt6H9jg9ssowKw9V4NtlpiHCxVLGPJdOzsB3y7PIh4XlowcM2HnezXN6ZsqHWANbfgEvhZ8RkF/Ulgg6H8WZMtyx1d0wYROVK0Vl44Ku7q+p+tRmBZ9OvTwGGcUAmyZ/x/cy7kSmpLWk54DTwMGnLuELL3dOAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vY+cqapC5puSfIS6Z1/epU6HztXckU9v/uA1d3/Do+0=;
 b=iExY+fdt6buouFxzPIc5uPt3qQFY4VcuF58MfTf3tQW71OhmtQaZOzVXap9Br3R9J5hDDwklEAdTReE6+06C/DjWEQV6eaq4pTsiX70WlL8Nu7zek033l305iz0thSBP7b/F62CW+Zg7UkjvdWyLPSXa/3c8EqzNv78Fsxo9TJurOY5GxrMYXQSTu96/2qGYP9H1Izk8GxIxk5ZQ56pG/AoPEjIpWcu1LWA1qUUCKR8UtUoDT1pYhmxxN0VIw7KHXxozaJhzulvkUtMFCmfYEtRVSTn+jDGaUu+bHRxEOwrW9mn62p5Z7i3glUfe+BXd4Sa+z0gZQmLYtxnIsWdODA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vY+cqapC5puSfIS6Z1/epU6HztXckU9v/uA1d3/Do+0=;
 b=yGYqNIcmGB4+y53uUbZUaIVaL+lrUK2+8PSLZNUnz3eSTGWEUpsA88aU6SBwbRDvCgm7BsuwyoiSMu3HcHnJGeuiEkIy3JZ4dRmyPGpF0uanpkuaWN8+nRXiiqr/A06dvghSIeO/8P+yDsoFi7jkwMWQyHy8xdiZR1XO/o9MHKg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by SA1PR12MB6894.namprd12.prod.outlook.com (2603:10b6:806:24d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 13:53:18 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::da13:5f6:45:fa40]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::da13:5f6:45:fa40%4]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 13:53:18 +0000
Date:   Wed, 6 Sep 2023 21:52:51 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Meng, Li (Jassmine)" <Li.Meng@amd.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH V5 3/7] cpufreq: amd-pstate: Enable amd-pstate preferred
 core supporting.
Message-ID: <ZPiEM+gusure7vKy@amd.com>
References: <20230905015116.2268926-1-li.meng@amd.com>
 <20230905015116.2268926-4-li.meng@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905015116.2268926-4-li.meng@amd.com>
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|SA1PR12MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e168289-3d91-404c-b053-08dbaee09fb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zlhjt9baw/7YNEeHvLPdntG/XP+mSgjbck8H6Ta1Vps1HsmcLqDhqdtBxID2btCekyIiGGWquQck+DUNrMRKCXYRGoEGHsyzu8oi38Y7at3KVFKPqHMB1fnpgLSXkkY11noYeM/W4uA7t3ZkBKbsxvkG4lbRWa4WriegyfWeuljsO9sUJPBjmYu0hF9OIakqBJ4ftgrgm7zSmRzPN0SkEicr43M11Gj6WBvn6rrKhxRiuV5OiJ1LEKB1TaAhT9YAXc+j1XIPHVWYKd32pMI+aCBOdq8BP8Qo1ZaXKb+yxCls/JHptMMZikfXD4z8n52XOuUz9pJ8fRp9+6deqwMRsMMPjrSesUnMs76nACklfHATILECwWjSbqxqEx+OyW4EJ+IRaHVnLaP1dcSpS770LAzSomny8kB7sAQhozeWSIK+8a+BSOXs5bUB4Nrz7WK9xwPjA9GyN2khS6fHCg06pRqLikNLtAfGDPPNKGn4ylK7DsLrYbtwm+rpMO9IYfwTaxJCfmYTe0ZRMAz1ImXrYNGkmzM2bGpjyc1Vr54pwj5UABPv1ZddNEYbaicBmzxg20KqKlzozSjbGPVMgzvPJydY3rrucOdUvnx/xzl4uoI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(136003)(376002)(396003)(1800799009)(186009)(451199024)(6862004)(8676002)(8936002)(2616005)(4326008)(41300700001)(26005)(5660300002)(54906003)(83380400001)(2906002)(6666004)(478600001)(316002)(6636002)(6512007)(6506007)(6486002)(37006003)(66476007)(66556008)(36756003)(86362001)(38100700002)(66946007)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mdxo8f5UccGXk4zI6MYL2FHt3VNoySU+auBEshomS/LZEReT3oH90u6ZBCAH?=
 =?us-ascii?Q?l41Ae2YGv5a6XO3jrXSM7UoueGioCbQQbXf6dGUZjZj1mElFVaHQDPmhWUbt?=
 =?us-ascii?Q?tzD06xjxHwFDplvtj/g9r8zX7XhLwPiUlQ0tkGjS4xbuAVA5ZBCITIEX3UIv?=
 =?us-ascii?Q?InWIxFhAQ7m6HNlPdeQLcmJxzW8WvMTM46OdBhoz7ypj25/3tEhYuRi+ndfE?=
 =?us-ascii?Q?9xDGBqD2A4LAtnyXXzmLMg8IX6h0ijVOQSDFzkGz36sPHyY3T29mBhcgIrGq?=
 =?us-ascii?Q?5XKmkyLIAHMh4HGFcrP0hokEb3Hs+VsPR1Gt19I/wXMAYw2662mMXhmb57K/?=
 =?us-ascii?Q?ICA6qXhcNhfmhmFr73mTmc+1bM6T2xh5qnoT9b/VfvlA+L2QL2+SOqghNcd9?=
 =?us-ascii?Q?VxGoMC3zZtiKr0AIxUB4Xt7L1MR4/Ev0dqp1UPdIJxX8PEhNboRmCxlEfPXO?=
 =?us-ascii?Q?k5MwxySmxty5fWRST/ZkzOFfPWnbiYRqsRvYGrqxAnWGUAM+5Lk7Wcc/gh2d?=
 =?us-ascii?Q?LSDoQusEhVz+SjfcOJMBtbvVD/mjChxYhzJVIVxseJ0jkmkhz+7ztHU4XinV?=
 =?us-ascii?Q?asyWHTfhl6ApPJn6m9N/kazKkBpdIBpjK2vjcsVYMEyY0mR6hY66fz6maPG3?=
 =?us-ascii?Q?q/xeLhvDEuk6mTmfcXBYqmzqpzI5mpIXnFkA20NCZTSmg1EJW49oGwlBab+g?=
 =?us-ascii?Q?XE3+h0FbCErnmISClEVDSnJDoQFGQDLS8X9u7R7UeJpfRfx/EFpRjOkVBQ33?=
 =?us-ascii?Q?MKL6BXnZZdNZdNEGAI/azOEkoDW/1KFTnQ+2VtO0xn+CJAwoEwO+pcGhHp/L?=
 =?us-ascii?Q?ySLU3QgU+YFz+MJnaCAmaC8RLPNGU6lPSO9bpiBfM2KYX14xyfpqHOkO9Hcd?=
 =?us-ascii?Q?Q/8awxrK+jptrrrJDYzwHSvkjp3vwgdWbbcibYEpR+RTKimHVzVSC62rtyI8?=
 =?us-ascii?Q?dL0OG6TYv8x+0du7luzkd9ij2fAKG99hVjNEY+/tG3adv0AksbfgI2w3NV3J?=
 =?us-ascii?Q?wvYCn0Qr0DkukDrHdDgFZyQXNiv/z/Lp5pADxOsIW/taCcO8pOynkxL5njC5?=
 =?us-ascii?Q?G+gG3mEg4Vc61ptLPngrvOhiT+ph0HP1vP0U+6H0BvW3G42RS0AjnoIvrgNY?=
 =?us-ascii?Q?K1GoiulSyWHKRDDoE9YnSnX4UyklKtLsHHpeBX0roB+yEfDIQdLaMJKPifSi?=
 =?us-ascii?Q?81J4toTTIBa3sP3jAqEFpl7xGcRB6HLaKuPL9aTZdgQwCriOXaon9BMeTcoQ?=
 =?us-ascii?Q?z3/Tk0DW8LTqsL5OE6fYRkkUE4V+J2aoXFM51EoMH0HfGHMeJzncpjPO8APS?=
 =?us-ascii?Q?EEVjh4PLLZ7qaX4OTZWlawkuiHTxykP2XXvVc3dfH3PezwDxFv0sbQRfBwzO?=
 =?us-ascii?Q?6GcFof23q7NMNy8EK1KN9KO561MoUlJvQQhmn0VzejgjoHruArfA5f6P7Jtu?=
 =?us-ascii?Q?cLzOtwqEHtrIxaYx3YlbQb8ZIuMdmUy0TKlu1UHYvkN0prSedfA6ADHQ9ntY?=
 =?us-ascii?Q?cSo11vqSSwN6RFEkIaIKkYh5XR1fbPU/q9GCzvLDEJP25Mv2ibOpNwBisWCe?=
 =?us-ascii?Q?QHUu0+2OM1D4QYmolWutGr8WGDi/BOM3SfCeZo1l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e168289-3d91-404c-b053-08dbaee09fb3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 13:53:18.0081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IP9nzkZyyOLBQdrhgjf6OLtm3j9jH3NPled2M176cgRSMnbUt8ESF3Zktll86/eyv1S1V85/MhN3ey+vn3FHBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6894
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 05, 2023 at 09:51:12AM +0800, Meng, Li (Jassmine) wrote:
> amd-pstate driver utilizes the functions and data structures
> provided by the ITMT architecture to enable the scheduler to
> favor scheduling on cores which can be get a higher frequency
> with lower voltage. We call it amd-pstate preferrred core.
> 
> Here sched_set_itmt_core_prio() is called to set priorities and
> sched_set_itmt_support() is called to enable ITMT feature.
> amd-pstate driver uses the highest performance value to indicate
> the priority of CPU. The higher value has a higher priority.
> 
> The initial core rankings are set up by amd-pstate when the
> system boots.
> 
> Add device attribute for hardware preferred core. It will check
> if the processor and power firmware support preferred core
> feature.
> 
> Add device attribute for preferred core. Only when hardware
> supports preferred core and user set `enabled` in early parameter,
> it can be set to enabled.
> 
> Add one new early parameter `disable` to allow user to disable
> the preferred core.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> Co-developed-by: Perry Yuan <Perry.Yuan@amd.com>
> Signed-off-by: Meng Li <li.meng@amd.com>
> Co-developed-by: Meng Li <li.meng@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 131 ++++++++++++++++++++++++++++++-----
>  1 file changed, 115 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9a1e194d5cf8..454eb6e789e7 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -37,6 +37,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/static_call.h>
>  #include <linux/amd-pstate.h>
> +#include <linux/topology.h>
>  
>  #include <acpi/processor.h>
>  #include <acpi/cppc_acpi.h>
> @@ -49,6 +50,8 @@
>  
>  #define AMD_PSTATE_TRANSITION_LATENCY	20000
>  #define AMD_PSTATE_TRANSITION_DELAY	1000
> +#define AMD_PSTATE_PREFCORE_THRESHOLD	166
> +#define AMD_PSTATE_MAX_CPPC_PERF	255
>  
>  /*
>   * TODO: We need more time to fine tune processors with shared memory solution
> @@ -65,6 +68,12 @@ static struct cpufreq_driver amd_pstate_epp_driver;
>  static int cppc_state = AMD_PSTATE_UNDEFINED;
>  static bool cppc_enabled;
>  
> +/*HW preferred Core featue is supported*/
> +static bool hw_prefcore = true;
> +
> +/*Preferred Core featue is supported*/
> +static bool prefcore = true;
> +
>  /*
>   * AMD Energy Preference Performance (EPP)
>   * The EPP is used in the CCLK DPM controller to drive
> @@ -290,23 +299,21 @@ static inline int amd_pstate_enable(bool enable)
>  static int pstate_init_perf(struct amd_cpudata *cpudata)
>  {
>  	u64 cap1;
> -	u32 highest_perf;
>  
>  	int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
>  				     &cap1);
>  	if (ret)
>  		return ret;
>  
> -	/*
> -	 * TODO: Introduce AMD specific power feature.
> -	 *
> -	 * CPPC entry doesn't indicate the highest performance in some ASICs.
> +	/* For platforms that do not support the preferred core feature, the
> +	 * highest_pef may be configured with 166 or 255, to avoid max frequency
> +	 * calculated wrongly. we take the AMD_CPPC_HIGHEST_PERF(cap1) value as
> +	 * the default max perf.
>  	 */
> -	highest_perf = amd_get_highest_perf();
> -	if (highest_perf > AMD_CPPC_HIGHEST_PERF(cap1))
> -		highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
> -
> -	WRITE_ONCE(cpudata->highest_perf, highest_perf);
> +	if (prefcore)
> +		WRITE_ONCE(cpudata->highest_perf, AMD_PSTATE_PREFCORE_THRESHOLD);
> +	else
> +		WRITE_ONCE(cpudata->highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));
>  
>  	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
>  	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
> @@ -318,17 +325,15 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
>  static int cppc_init_perf(struct amd_cpudata *cpudata)
>  {
>  	struct cppc_perf_caps cppc_perf;
> -	u32 highest_perf;
>  
>  	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>  	if (ret)
>  		return ret;
>  
> -	highest_perf = amd_get_highest_perf();
> -	if (highest_perf > cppc_perf.highest_perf)
> -		highest_perf = cppc_perf.highest_perf;
> -
> -	WRITE_ONCE(cpudata->highest_perf, highest_perf);
> +	if (prefcore)
> +		WRITE_ONCE(cpudata->highest_perf, AMD_PSTATE_PREFCORE_THRESHOLD);
> +	else
> +		WRITE_ONCE(cpudata->highest_perf, cppc_perf.highest_perf);
>  
>  	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
>  	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
> @@ -676,6 +681,73 @@ static void amd_perf_ctl_reset(unsigned int cpu)
>  	wrmsrl_on_cpu(cpu, MSR_AMD_PERF_CTL, 0);
>  }
>  
> +/*
> + * Set amd-pstate preferred core enable can't be done directly from cpufreq callbacks
> + * due to locking, so queue the work for later.
> + */
> +static void amd_pstste_sched_prefcore_workfn(struct work_struct *work)
> +{
> +	sched_set_itmt_support();
> +}
> +static DECLARE_WORK(sched_prefcore_work, amd_pstste_sched_prefcore_workfn);
> +
> +/*
> + * Get the highest performance register value.
> + * @cpu: CPU from which to get highest performance.
> + * @highest_perf: Return address.
> + *
> + * Return: 0 for success, -EIO otherwise.
> + */
> +static int amd_pstate_get_highest_perf(int cpu, u64 *highest_perf)
> +{
> +	int ret;
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		u64 cap1;
> +
> +		ret = rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap1);
> +		if (ret)
> +			return ret;
> +		WRITE_ONCE(*highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));
> +	} else {
> +		ret = cppc_get_highest_perf(cpu, highest_perf);
> +	}
> +
> +	return (ret);
> +}
> +
> +static void amd_pstate_init_prefcore(void)
> +{
> +	int cpu, ret;
> +	u64 highest_perf;
> +
> +	if (!prefcore)
> +		return;
> +
> +	for_each_online_cpu(cpu) {
> +		ret = amd_pstate_get_highest_perf(cpu, &highest_perf);
> +		if (ret)
> +			break;
> +
> +		sched_set_itmt_core_prio(highest_perf, cpu);
> +
> +		/* check if CPPC preferred core feature is enabled*/
> +		if (highest_perf == AMD_PSTATE_MAX_CPPC_PERF) {
> +			hw_prefcore = false;
> +			prefcore = false;

I think you should use prefcore which embeds into cpudata structure instead
of global variable. Here, actually, you walked through all online cpus, the
last cpu's status will overwrite the previous one.

> +			return;
> +		}
> +	}
> +
> +	/*
> +	 * This code can be run during CPU online under the
> +	 * CPU hotplug locks, so sched_set_amd_prefcore_support()
> +	 * cannot be called from here.  Queue up a work item
> +	 * to invoke it.
> +	 */
> +	schedule_work(&sched_prefcore_work);
> +}
> +
>  static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  {
>  	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> @@ -1037,6 +1109,18 @@ static ssize_t status_store(struct device *a, struct device_attribute *b,
>  	return ret < 0 ? ret : count;
>  }
>  
> +static ssize_t hw_prefcore_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", hw_prefcore ? "supported" : "unsupported");
> +}

Is there any requirement from user space (cpupower or other tool) to query
the capacity at runtime?  In fact, we can simplify the codes that use a
print in the kernel to let user know whether current cpu supports prefcore
in hardware side.

Thanks,
Ray

> +
> +static ssize_t prefcore_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", prefcore ? "enabled" : "disabled");
> +}
> +
>  cpufreq_freq_attr_ro(amd_pstate_max_freq);
>  cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>  
> @@ -1044,6 +1128,8 @@ cpufreq_freq_attr_ro(amd_pstate_highest_perf);
>  cpufreq_freq_attr_rw(energy_performance_preference);
>  cpufreq_freq_attr_ro(energy_performance_available_preferences);
>  static DEVICE_ATTR_RW(status);
> +static DEVICE_ATTR_RO(hw_prefcore);
> +static DEVICE_ATTR_RO(prefcore);
>  
>  static struct freq_attr *amd_pstate_attr[] = {
>  	&amd_pstate_max_freq,
> @@ -1063,6 +1149,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>  
>  static struct attribute *pstate_global_attributes[] = {
>  	&dev_attr_status.attr,
> +	&dev_attr_prefcore.attr,
>  	NULL
>  };
>  
> @@ -1506,6 +1593,8 @@ static int __init amd_pstate_init(void)
>  		}
>  	}
>  
> +	amd_pstate_init_prefcore();
> +
>  	return ret;
>  
>  global_attr_free:
> @@ -1527,7 +1616,17 @@ static int __init amd_pstate_param(char *str)
>  
>  	return amd_pstate_set_driver(mode_idx);
>  }
> +
> +static int __init amd_prefcore_param(char *str)
> +{
> +	if (!strcmp(str, "disable"))
> +		prefcore = false;
> +
> +	return 0;
> +}
> +
>  early_param("amd_pstate", amd_pstate_param);
> +early_param("amd_prefcore", amd_prefcore_param);
>  
>  MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
>  MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");
> -- 
> 2.34.1
> 
