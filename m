Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70867A70A8
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 04:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjITCoi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Sep 2023 22:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjITCoh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Sep 2023 22:44:37 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB80FC6;
        Tue, 19 Sep 2023 19:44:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMcBJFjLKgP9jLoasmHjSB+TqSXwnlzA38CSuTHcgSO84aaKbcsPlPbmgwlGyxAFMou72SI0wVViBnEojzDo69flMoB9KTvVxeiXmPJoJ8p67PmtGgDdmlsi06/Wa1I7AvE+i3hYvT/dBm6+hQ+UIHqZjRARvJVVkrJPBBWD7Lz541ijEWvTgXalI6k/e2iVWORn41Hcn4R+KI9rx1pbdhZUJ7R/L+mVob0SypDHc37DTbl5uoiMiP3yeTh4ANYg01op/cxmxCc+nbHenMfN8o0ZMlwcbd7A3fXQ+3hxfiZlZyIb6YY1uBj+ZhQEzaQ9FaIcHdm1r2S+tS7yxlFQvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nJ1NqWdJf//lp+/35tUByYpmH4pIb/06q01BE4U+zM=;
 b=FpDIzGe9DyeENJkaaxI0qvq9AnSvSQt9+HVwRmllhkfzIm2qqGuhm1c9uOKTOhKRoz0MRlBwBB2PSG82LCgiXBk6Pe9VMEDQFBZd4PmJ/BDVHZoICVfzRw/gsXHcMHO7wVj65KP0vV9n6xAc9a/hWpt2X4PH5n8eBW4gRR6LUtCDgdcHULRU1DzDN9/dIz12Fgp4DUlNpymf7GWGAObFFBlc4Zv1i6A0Tylzq8XBXEJEmf9zgZptmPGkYwB7rIG17OIKdjs8f/thj7ICE2Izw3aVXWBHWqyxylrluZ5Vlfg49KiT9pR+av8YL07HkSCiV9J9yL5E7VgumvMD2mPo3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nJ1NqWdJf//lp+/35tUByYpmH4pIb/06q01BE4U+zM=;
 b=Gc7ShDpYrK0W0Orzg9lv40gJY4L67Y/3wRwuoNCi7YIJ5F5MnyADrS+9kaCSwcpfWA5byK5tG6xH0ZLK+HTXBNt9J5n9T1UCTzpZuXKQ393GeAS5sHpWPnzrzO7VfKH4VVUppzFH4RuMr50rvZAXDE8lwYCC219DgCpl6qIZT1o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 02:44:16 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::c3b:811:fd1d:c33e]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::c3b:811:fd1d:c33e%6]) with mapi id 15.20.6792.021; Wed, 20 Sep 2023
 02:44:15 +0000
Date:   Wed, 20 Sep 2023 10:43:48 +0800
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
Subject: Re: [PATCH V7 3/7] cpufreq: amd-pstate: Enable amd-pstate preferred
 core supporting.
Message-ID: <ZQpcZDrYZYXzRRkZ@amd.com>
References: <20230918081407.756858-1-li.meng@amd.com>
 <20230918081407.756858-4-li.meng@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918081407.756858-4-li.meng@amd.com>
X-ClientProxiedBy: SG2PR02CA0121.apcprd02.prod.outlook.com
 (2603:1096:4:188::21) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|SA1PR12MB8599:EE_
X-MS-Office365-Filtering-Correlation-Id: 273d1d72-3c76-45a6-72bd-08dbb9837ad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XpPhhV0B+a13y3bWaQQ6G+9ZD5oFH8pm2GGpqUUGXMhwcP7XqhfZdJncQ7VVhRhrAQ8Zifbwgi6ATJaQ0wEV3KLpK+/tabfbxIY31XaEAFa0RT+4TRvJT0i714LnOjR92zahzH16daTrKtPcWvDOdMBrxJJcquFvajOBBwYhwsoEAr/Bqb6T5HX7Ffpz+wRuQLuhhGKkQynrkeyjFGYysgxCJ7h1eq4KYSJr+H1rmQxWWPIpLOUu3HV7eHRZ4mGbWybIYACkA1g1BovawgJb2tgwrIgacJ//QZlovO8wAfQKDQDWEGAJT4sC5JTlFYia95HpfOeROlP4zPuE/1q2R0MF44V06jmQmys0REgzJ37V9kj3t1QfcE+hZ2bhum1h5BHQFohJp3Eh8C++awM4HUsTNzeljPd3DH0AgvWb3IP5OTwBlbZzGNd4KJPFYEoDnR1UHQoi+km/jOli7/LLBOcm+eJQowiO3S06BqeOs9ZHH4WIGDgfPukLtR2epnFwH8dEC5UAl9TT4n0SKzemthTk1b2pHo5GwC1FbxVV2q8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(366004)(136003)(346002)(186009)(1800799009)(451199024)(478600001)(6506007)(6486002)(6666004)(86362001)(36756003)(38100700002)(26005)(2906002)(8676002)(30864003)(6512007)(83380400001)(5660300002)(8936002)(4326008)(2616005)(6862004)(41300700001)(966005)(54906003)(66946007)(37006003)(6636002)(316002)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EKYjGGZUjgc9UU+NT5Q7X9Pp+d1kBybAWYK2pprx60OZS44gy6SC9uMOpC6K?=
 =?us-ascii?Q?uqQ2X8Adolsibr3Mk5t7k8ILCl47RzBI/sn0Lm54Ye9QoPbQG657fXfCgaSW?=
 =?us-ascii?Q?qXmYB4x6Y5PFeKXqkAASYgNhPd9FIAaKINub5+z4Nm+M6K0Ggk+5OiG+xgCP?=
 =?us-ascii?Q?EJkd/Ues70Eq57BWyYnze1yn4dzdskQnFBMxzBBIpbv2TCn0+tHoBOEWHFqC?=
 =?us-ascii?Q?i2nCaDTKDuSmsHyv+en6ZN/3U5OyW2qcZm22SLOgAVt3pUcLRozwNkA6fIid?=
 =?us-ascii?Q?dTR63KaHMG/mqwtSaZZGKiJ+g+/Z63FVbYzRpqAKTeDusIYKDoEPfruw9oNm?=
 =?us-ascii?Q?b4pa+ronTCX7dcJd+PiPPBBGjwm4/a8eZjWXm69ZFaYfRGQcNbi3BIi31ruk?=
 =?us-ascii?Q?Lol6nU6QaL+H8ahG7R0FQM8u4IriuMBemGy1NFCRUCh6HtxW4PXCUsYcW2dd?=
 =?us-ascii?Q?bs6wy0uzayTRmuG1bAH+n5Hk1P7nrsH8Su0JO6uPL6/1/lZrYFqaKjxqaonu?=
 =?us-ascii?Q?E/dtqPLojp+A+09Ptwnk6biu8BzWlRxm0EfA6jva/SZFXwI/isfDDCaS+axo?=
 =?us-ascii?Q?0LDVHBGZqittzfjnkimxL6WH0ewSnSzH84HrwaB3W8N+bKz4b1Rfn2SWwVMd?=
 =?us-ascii?Q?Z8pCQC5FAUULWLhRWqwuaPAIgBm/wGdQXIyxEt9tL6kmP9YS0VJjf+fMQGnA?=
 =?us-ascii?Q?8H3HakwB8ghr6J+Snlboa9IJxeMBsK7krNTiluBjPrhvgTZerUasoFOnKq4o?=
 =?us-ascii?Q?hI3hexzPeOYb3AYCp41UvW80Ji2OzCxho/ZMNevBCfHau8a/r+FimHNEmJbS?=
 =?us-ascii?Q?idIlG8PrQKV/o5A68kdlyCqFGmrNQM1aOD3AblgL5VbOHTzg0UsNxmblLePU?=
 =?us-ascii?Q?kELuD7Hb0yhJr6xryR/9+WNXIeKrWAugh0cDb0fLIOC8Vn+NSbeeuAoiKpLk?=
 =?us-ascii?Q?Zp/G/EzHwFj7nwxm5pIc6DXCxqjT6Vr6hvXYhvwPEUNhJkYX2CI3M+k32/Oa?=
 =?us-ascii?Q?WBZPbcixRZ7XWXv+83O07z+ExchwbP93IoQK0zIlJgn7YsaicdYu5UAyDh5y?=
 =?us-ascii?Q?ik3UqoGRpJEHhDa/V6ogMuYaUkJjehsOBPTfEdDT+0C/9KYqsY840TSQNRbB?=
 =?us-ascii?Q?6W6R1pVqZ/mmNVmM9mZqqb7HVRc/loqwpJ9FaKwWQBdwOLnH9TP6RwRG1hJl?=
 =?us-ascii?Q?oMB6MWDgbkHT379CQfiaiZS/GNuQHw7FH4HR17uz/sQO3ft5+weMllQ4OU4B?=
 =?us-ascii?Q?Jzz+h53aqpZZ78kOj/vlD9E56TGnPWRdgRlVvC1YVRjuIG7X/vEE4X0P4Kvi?=
 =?us-ascii?Q?h64ltCDOnrr4pKsfj8hCsakLNF+zCvQU8U6UTq1oKPQ7jeihG7Ujj9OGVR8F?=
 =?us-ascii?Q?mfFvTVSZA6u/PIEsDpdd8gO1grXsEMhAydy2NXSRJfJUo8rEQ/HxpEEd6ej+?=
 =?us-ascii?Q?/Xa93Q7TMPChW+zRKb+k4Ud03xM5Rft0ZGyIKVmC0fuiJrgCJdrhNJllvS7o?=
 =?us-ascii?Q?lAco3mdsVGR4Zx/09/WG4Ods9mEnufZ+k6DROSdBdRAWVYqEcvFznRb3aP9M?=
 =?us-ascii?Q?HUclIJnvjHjhNJTUhsyHgXbxz9m+CAF00FPLyn33?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 273d1d72-3c76-45a6-72bd-08dbb9837ad8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 02:44:15.7591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NhY2Dt2QwRkQ2Y2WQNJUg5luJqnzMd3REaFJLRnnSMauA8J6s1oLkQmYD9UtMBNBLzR3PTbbrQItYIdn+lJwzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8599
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 18, 2023 at 04:14:03PM +0800, Meng, Li (Jassmine) wrote:
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
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Co-developed-by: Perry Yuan <Perry.Yuan@amd.com>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 163 +++++++++++++++++++++++++++++++----
>  1 file changed, 147 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9a1e194d5cf8..050e23594057 100644
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
> +	if (hw_prefcore)
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
> +	if (hw_prefcore)
> +		WRITE_ONCE(cpudata->highest_perf, AMD_PSTATE_PREFCORE_THRESHOLD);
> +	else
> +		WRITE_ONCE(cpudata->highest_perf, cppc_perf.highest_perf);
>  
>  	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
>  	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
> @@ -676,6 +681,90 @@ static void amd_perf_ctl_reset(unsigned int cpu)
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
> +static int amd_pstate_get_highest_perf(int cpu, u32 *highest_perf)
> +{
> +	int ret;
> +	u64 cppc_highest_perf;
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		u64 cap1;
> +
> +		ret = rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap1);
> +		if (ret)
> +			return ret;
> +		WRITE_ONCE(*highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));
> +	} else {
> +		ret = cppc_get_highest_perf(cpu, &cppc_highest_perf);
> +		*highest_perf = (u32)(cppc_highest_perf & 0xFFFF);
> +	}
> +
> +	return (ret);
> +}
> +
> +static void amd_pstate_init_prefcore(unsigned int cpu)
> +{
> +	int ret;
> +	u32 highest_perf;
> +	static u32 max_highest_perf = 0, min_highest_perf = U32_MAX;
> +
> +	if (!prefcore)
> +		return;
> +
> +	ret = amd_pstate_get_highest_perf(cpu, &highest_perf);
> +	if (ret)
> +		return;
> +
> +	/*
> +	 * The priorities can be set regardless of whether or not
> +	 * sched_set_itmt_support(true) has been called and it is valid to
> +	 * update them at any time after it has been called.
> +	 */
> +	sched_set_itmt_core_prio(highest_perf, cpu);
> +
> +	/* check if CPPC preferred core feature is enabled*/
> +	if (highest_perf == AMD_PSTATE_MAX_CPPC_PERF) {
> +		pr_debug("AMD CPPC preferred core is unsupported!\n");
> +		hw_prefcore = false;
> +		prefcore = false;

The problem that I commented in below version is still there. The
amd_pstate_init_prefcore() will be called in amd_pstate_cpu_init() which
will be initialized on each cpu. So the hw_perfcore/prefcore will be
overwrited at last cpu initialization.

https://lore.kernel.org/linux-pm/ZPiEM+gusure7vKy@amd.com/

Thanks,
Ray

> +		return;
> +	}
> +
> +	if (max_highest_perf <= min_highest_perf) {
> +		if (highest_perf > max_highest_perf)
> +			max_highest_perf = highest_perf;
> +
> +		if (highest_perf < min_highest_perf)
> +			min_highest_perf = highest_perf;
> +
> +		if (max_highest_perf > min_highest_perf) {
> +			/*
> +			 * This code can be run during CPU online under the
> +			 * CPU hotplug locks, so sched_set_itmt_support()
> +			 * cannot be called from here.  Queue up a work item
> +			 * to invoke it.
> +			 */
> +			schedule_work(&sched_prefcore_work);
> +		}
> +	}
> +}
> +
>  static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  {
>  	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> @@ -697,6 +786,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  
>  	cpudata->cpu = policy->cpu;
>  
> +	amd_pstate_init_prefcore(policy->cpu);
> +
>  	ret = amd_pstate_init_perf(cpudata);
>  	if (ret)
>  		goto free_cpudata1;
> @@ -763,6 +854,22 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  	return ret;
>  }
>  
> +static int amd_pstate_cpu_online(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +
> +	pr_debug("CPU %d going online\n", cpudata->cpu);
> +
> +	amd_pstate_init_prefcore(cpudata->cpu);
> +
> +	return 0;
> +}
> +
> +static int amd_pstate_cpu_offline(struct cpufreq_policy *policy)
> +{
> +	return 0;
> +}
> +
>  static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
> @@ -1037,6 +1144,12 @@ static ssize_t status_store(struct device *a, struct device_attribute *b,
>  	return ret < 0 ? ret : count;
>  }
>  
> +static ssize_t prefcore_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", prefcore ? "enabled" : "disabled");
> +}
> +
>  cpufreq_freq_attr_ro(amd_pstate_max_freq);
>  cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>  
> @@ -1044,6 +1157,7 @@ cpufreq_freq_attr_ro(amd_pstate_highest_perf);
>  cpufreq_freq_attr_rw(energy_performance_preference);
>  cpufreq_freq_attr_ro(energy_performance_available_preferences);
>  static DEVICE_ATTR_RW(status);
> +static DEVICE_ATTR_RO(prefcore);
>  
>  static struct freq_attr *amd_pstate_attr[] = {
>  	&amd_pstate_max_freq,
> @@ -1063,6 +1177,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>  
>  static struct attribute *pstate_global_attributes[] = {
>  	&dev_attr_status.attr,
> +	&dev_attr_prefcore.attr,
>  	NULL
>  };
>  
> @@ -1114,6 +1229,8 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	cpudata->cpu = policy->cpu;
>  	cpudata->epp_policy = 0;
>  
> +	amd_pstate_init_prefcore(policy->cpu);
> +
>  	ret = amd_pstate_init_perf(cpudata);
>  	if (ret)
>  		goto free_cpudata1;
> @@ -1285,6 +1402,8 @@ static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
>  
>  	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
>  
> +	amd_pstate_init_prefcore(cpudata->cpu);
> +
>  	if (cppc_state == AMD_PSTATE_ACTIVE) {
>  		amd_pstate_epp_reenable(cpudata);
>  		cpudata->suspended = false;
> @@ -1389,6 +1508,8 @@ static struct cpufreq_driver amd_pstate_driver = {
>  	.fast_switch    = amd_pstate_fast_switch,
>  	.init		= amd_pstate_cpu_init,
>  	.exit		= amd_pstate_cpu_exit,
> +	.offline	= amd_pstate_cpu_offline,
> +	.online		= amd_pstate_cpu_online,
>  	.suspend	= amd_pstate_cpu_suspend,
>  	.resume		= amd_pstate_cpu_resume,
>  	.set_boost	= amd_pstate_set_boost,
> @@ -1527,7 +1648,17 @@ static int __init amd_pstate_param(char *str)
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
