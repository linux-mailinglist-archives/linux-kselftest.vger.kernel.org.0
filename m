Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAAF78BFD0
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Aug 2023 10:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjH2IC0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Aug 2023 04:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbjH2ICB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Aug 2023 04:02:01 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF0911B;
        Tue, 29 Aug 2023 01:01:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRNVSMEI4KlzfbIWTH9J8cXS0fdw/LJx9sQqLpvTPC14hoeIAIIYuXmhScB2MrfMVLAZ6tiwxC47Kos3uL1lUOJjvoiiOy1/9T3ut1FQG1YACNmYzsSiPUv6uRwOLHeNtZk3RsJXynAYomlUbknyyVcbFsOLIBuaZTedgRduPKnUw56vGQTOoH6M58EOSiYdLOVIuN/DrKthGh2Gisa/dJWr/NCeTd/kwcmZwQcB2cQU3AI01e8sjrJyyM/sCRNpw1gRWf0pYEFgo3zFK9hDsl5CI1UL31OXs1h0EMTZhm3EO6CyyOoT2rC7BKawTOzICqHT2YYjGXUP3bvGY5h7FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRG9Sofz80As33+emc80SRrModSre9xpVz4Eovrjh8s=;
 b=WlRhwn2UWkT/NR2WmFAyo5BIIpUXGVrw1RRZSvZTaRHkPXEHxVNn8xU3pNEnSVjBV/erWe31maHu9hR0xnyMGzyTe9ukBnJGp/4W75/rxi5b54KD0kKSbVJR+9DOzUESlhpD7hykT/PU3uhZ4n182fZBZHjwCu5nqhnUIr1lMMFTS66zLHf6luxVD2xU2KX6UUXFF9eQx+5ao8f3JqHt/swiNhBQuBnZJqFroWVPDmVE5E5FAq6O0/X66Tixxj101WBAxCrYQKs/Q0BCglBnJWuCJ8bYltCMHqtKiHfM+dyH+igxcMohGoPv8g6vCcGEzTqsusOdiUWPM14BGq/16A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRG9Sofz80As33+emc80SRrModSre9xpVz4Eovrjh8s=;
 b=EYW81FyoSvjEeRGRW3muFBmelVqWEy5cfmM0cgWd3p1ZFdyKAqz2LEOkp3RBcfMWo3wlVtwRpUPI6KBeDOSP46/YJD4BAhnJ3EKYH0TjN5T6K4TAExC+A3jxqsDRauR51/qL5cNxqh64oIQmmLlHHy9SdRr7XggLaJFwX/aJTh8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by BY5PR12MB4920.namprd12.prod.outlook.com (2603:10b6:a03:1d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 08:01:53 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::da13:5f6:45:fa40]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::da13:5f6:45:fa40%4]) with mapi id 15.20.6699.027; Tue, 29 Aug 2023
 08:01:53 +0000
Date:   Tue, 29 Aug 2023 16:01:26 +0800
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
Subject: Re: [PATCH V4 3/7] cpufreq: amd-pstate: Enable AMD Pstate Preferred
 Core Supporting.
Message-ID: <ZO2l1oaqNlV2sCQY@amd.com>
References: <20230829064340.1136448-1-li.meng@amd.com>
 <20230829064340.1136448-4-li.meng@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829064340.1136448-4-li.meng@amd.com>
X-ClientProxiedBy: TY2PR06CA0038.apcprd06.prod.outlook.com
 (2603:1096:404:2e::26) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|BY5PR12MB4920:EE_
X-MS-Office365-Filtering-Correlation-Id: bb4932f1-9c60-4c0b-b902-08dba86634c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9MkXlcxXefqofeQHuaMj49/wZea5zyoCdHYQci1BdVzJskAvUjYISgh2d5XfEDtM60fT3mJGA3adC5i5XNevTGGybPZRW1EEXVeLYEyyF8/JoN9pGBJ2P/3saNUHJFKj1oQYWdAg38nD/Kat/hyxQWonTNoXAOyl6Y2P2J8KKFVskCQQjdndR2rfIkkhk35fOj9vrEaHWClQyDTAQJ0locLOxXB9FcWHSStm7j8CmgLP/MQDaOrMyJHR602pO/lheodXXpemZy7nr7IUii5BlVI63GhoLiIdyZC3UOEEXXFXkpM3ygS5mX1LtcXVnQ8MfNYaXdiUKuej+Y/JK5VOFZ6vwlFdTJARXcpSEvhJ+AImIVEb0A9rZMU7qYlSPCCkaptggvYDaM3lfrebSldUQDrKG4YPVIEj7f7dRsnGX1bpWJyWkqYQWKrucwh5PV8dNszk1S0u1OYyU9yH145g6FNIDjp9i9W+wGTxoD7h+kAQupWILSPKEkc0f6iVH91HN3DzWwBRyh+4wa9AlbRsPBf7dEA1Qvwea5gOP0T9Yxx5i4amAuV+YbR/NWUSfvHF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(376002)(136003)(1800799009)(451199024)(186009)(6512007)(38100700002)(316002)(37006003)(6636002)(41300700001)(4326008)(6862004)(2906002)(83380400001)(86362001)(2616005)(36756003)(26005)(5660300002)(8676002)(8936002)(6666004)(6506007)(6486002)(66556008)(66476007)(54906003)(66946007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m5w+K9YL23Nth0/ya+MKuR2aXOhrnA/husqkEnZSEevepkY06/Yx6v3luBxX?=
 =?us-ascii?Q?Y58Z/AXwJ4lTnZwOHwtWbh88jdsUXbQZQbAYjkRgrSzl39H2GrxZWtN6mz8o?=
 =?us-ascii?Q?4RwJNRjkRwLGPw7VFDrBqaGBxFJPOdKlcwWE7itc2mExyLvRH5GAR3sGXqKe?=
 =?us-ascii?Q?7OmHQcXfd5BJJBrl/lgjgmRUhKjbCUiAuBl5RBXZC/08e8b8pMVaKvctcJIe?=
 =?us-ascii?Q?ykPsgUFERjuYoA0nxcrN/5xPoxIEQdTN766fQKqvOEdTHmo9diVNpBXGzPs2?=
 =?us-ascii?Q?hhC9HNB0/QvHJ9BZiQzKnODNHsfEmq1G6zdKbD299bzvvlX8dstk9kw69/5z?=
 =?us-ascii?Q?nk17XFhx9lPL9udc4gGb+hADWHwTAuQg7R4m1ibDsjUj0OUw16pMDsDv36Cn?=
 =?us-ascii?Q?DhmOsD+59YdX//r7sGqZa6QZ9sRDQJ024dh5338ufVcBjq56LX+hR9nQKuuo?=
 =?us-ascii?Q?7b0QKEbhTWOitHebEAZbNSDtp5bFCmpwHzdRiBNDjJxwC+LXd2wcb4EH+TqG?=
 =?us-ascii?Q?wigr+3knAMjXB/GMqI8v5lAiUiyvH8AyenfSfZ+55yb/6d5tL4yFwupcaofb?=
 =?us-ascii?Q?HD7F1bKQ7CRy7dF6HN+dS+/Dm5yA20TRWrzdyzHK6dt/jHQltpp8GvuUUUBp?=
 =?us-ascii?Q?AtaAT4okZBjkCXXEDEJj8Ur4n2IHa13/D4TdZncX6+ZI8dEBUchIzYymhTbk?=
 =?us-ascii?Q?49LR0VCYIpPLhpx4MfVt/8kQMSJ4xqRrQn9wAmqCxM+ZyxxHpNt14bCFTnvT?=
 =?us-ascii?Q?GeXYQEei/hpuuTrm9XM3nSh2AS3udgwYmpwZppfyvcgk5a8rwBjzBW6knPtK?=
 =?us-ascii?Q?8FomTa83+YUzrmT4YBB8puUErN+jqgjyoxBEEyjXKELI6wMFXm+7M63iRVOq?=
 =?us-ascii?Q?Cua/8D00NQBl4NqGSzEJYUutO9FsN88IuaFxMqtEJR5dn87x3W5s4LPnXE9R?=
 =?us-ascii?Q?kq7UN/g4RnVI9som4W11vIbeX8cvrtkW06mHvAqu/7vp/iCT1A+Omxl00VFC?=
 =?us-ascii?Q?jSp5zevKJ2Yc1WLQjRy5o+YB5OF76YAWrYDz++SBAsffgIwhuGGtEwkZQOsq?=
 =?us-ascii?Q?YM2vxqqC1622NYddLbjXviKwEBtOk80rfbHCG96hJsJti0mFOqSSCwLdXW/F?=
 =?us-ascii?Q?g4DOV4mEJzHsslMa1YCCq8nV3PYeTRUSKEUwI1eqd6hUoDmhybYxWJWaQ4jv?=
 =?us-ascii?Q?ZWJSnGN6AvB2J3W2yfM9TYSLvq5xnju2G0yi1ItnvEXM3oQwXon8tuLxN56M?=
 =?us-ascii?Q?/fR1RrhymG9XC9hgvwRNduvgtW4dKvVO0uxHCUca4kyRXD6xRqb8io0fnX2X?=
 =?us-ascii?Q?4mBFPi+h/vLkE5DJ9Lnq46ToKjYE/rIhbHbH0vu0ABUdEd1120k54rtvK9lm?=
 =?us-ascii?Q?qSBn2FkthMSCzKIx4NzN7yhXutcHPKh4TaTb3GF4x/lpeYiPXLJMv7OULhmh?=
 =?us-ascii?Q?doI3McCxGOlcLA9n/TXdViGpSJrxShLXkofvHurGxyv8mZNhFeqjPgu/0fQE?=
 =?us-ascii?Q?WGA5Jl+IDAw1L7dnnPPOCMpGX/3iP0QuN+TgQyoOaUbiGqluCdZh0UVNlhXT?=
 =?us-ascii?Q?+FUn/xttMSlpc5hoPGqNk7Du0YuZdxcWbwjXmTNz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4932f1-9c60-4c0b-b902-08dba86634c4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 08:01:53.1341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aAra7eSmtWt89yWeRTgTjzHuB9hrXBQRfIOoKgiPgwii3Kh/5w6UYRG5zKumgl7dkTn1ma9o/2pJZL7wk/XtwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4920
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 29, 2023 at 02:43:36PM +0800, Meng, Li (Jassmine) wrote:
> AMD Pstate driver utilizes the functions and data structures
> provided by the ITMT architecture to enable the scheduler to
> favor scheduling on cores which can be get a higher frequency
> with lower voltage. We call it AMD Pstate Preferrred Core.
> 
> Here sched_set_itmt_core_prio() is called to set priorities and
> sched_set_itmt_support() is called to enable ITMT feature.
> AMD Pstate driver uses the highest performance value to indicate
> the priority of CPU. The higher value has a higher priority.
> 
> The initial core rankings are set up by AMD Pstate when the
> system boots.
> 
> Add device attribute for preferred core states.
> 
> Add one new early parameter `enable` to allow user to
> enable the preferred core if the processor and power
> firmware can support preferred core feature.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> Co-developed-by: Perry Yuan <Perry.Yuan@amd.com>
> Signed-off-by: Meng Li <li.meng@amd.com>
> Co-developed-by: Meng Li <li.meng@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 120 ++++++++++++++++++++++++++++++-----
>  1 file changed, 104 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9a1e194d5cf8..d02305675f66 100644
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
> @@ -65,6 +68,9 @@ static struct cpufreq_driver amd_pstate_epp_driver;
>  static int cppc_state = AMD_PSTATE_UNDEFINED;
>  static bool cppc_enabled;
>  
> +/*Preferred Core featue is supported*/
> +static bool prefcore = true;
> +
>  /*
>   * AMD Energy Preference Performance (EPP)
>   * The EPP is used in the CCLK DPM controller to drive
> @@ -290,23 +296,21 @@ static inline int amd_pstate_enable(bool enable)
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
> @@ -318,17 +322,15 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
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
> @@ -676,6 +678,72 @@ static void amd_perf_ctl_reset(unsigned int cpu)
>  	wrmsrl_on_cpu(cpu, MSR_AMD_PERF_CTL, 0);
>  }
>  
> +/*
> + * Set AMD Pstate Preferred Core enable can't be done directly from cpufreq callbacks
> + * due to locking, so queue the work for later.
> + */
> +static void amd_pstste_sched_prefcore_workfn(struct work_struct *work)
> +{
> +	sched_set_itmt_support();
> +}
> +static DECLARE_WORK(sched_prefcore_work, amd_pstste_sched_prefcore_workfn);
> +
> +/**
> + * Get the highest performance register value.
> + * @cpu: CPU from which to get highest performance.
> + * @highest_perf: Return address.
> + *
> + * Return: 0 for success, -EIO otherwise.
> + */
> +static int amd_pstate_get_highest_perf(int cpu, u64 *highest_perf)
> +{
> +       int ret;
> +
> +       if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +               u64 cap1;
> +
> +               ret = rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap1);
> +               if (ret)
> +                       return ret;
> +               WRITE_ONCE(*highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));
> +       } else {
> +               ret = cppc_get_highest_perf(cpu, highest_perf);
> +       }
> +
> +       return (ret);
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
> +			prefcore = false;
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
> @@ -1037,6 +1105,12 @@ static ssize_t status_store(struct device *a, struct device_attribute *b,
>  	return ret < 0 ? ret : count;
>  }
>  
> +static ssize_t prefcore_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", prefcore ? "enabled" : "disabled");
> +}
> +
>  cpufreq_freq_attr_ro(amd_pstate_max_freq);
>  cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>  
> @@ -1044,6 +1118,7 @@ cpufreq_freq_attr_ro(amd_pstate_highest_perf);
>  cpufreq_freq_attr_rw(energy_performance_preference);
>  cpufreq_freq_attr_ro(energy_performance_available_preferences);
>  static DEVICE_ATTR_RW(status);
> +static DEVICE_ATTR_RO(prefcore);
>  
>  static struct freq_attr *amd_pstate_attr[] = {
>  	&amd_pstate_max_freq,
> @@ -1063,6 +1138,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>  
>  static struct attribute *pstate_global_attributes[] = {
>  	&dev_attr_status.attr,
> +	&dev_attr_prefcore.attr,
>  	NULL
>  };
>  
> @@ -1506,6 +1582,8 @@ static int __init amd_pstate_init(void)
>  		}
>  	}
>  
> +	amd_pstate_init_prefcore();
> +
>  	return ret;
>  
>  global_attr_free:
> @@ -1527,7 +1605,17 @@ static int __init amd_pstate_param(char *str)
>  
>  	return amd_pstate_set_driver(mode_idx);
>  }
> +
> +static int __init amd_prefcore_param(char *str)
> +{
> +	if (!strcmp(str, "disable"))
> +		prefcore = false;

You know, the prefercore is a hardware capacity, so we should have a way to
detect current processor whether it's supported. E.X. whether we can read
highest_perf value is AMD_PSTATE_PREFCORE_THRESHOLD or less than
AMD_PSTATE_MAX_CPPC_PERF, then set the prefcore enabled.

Thanks,
Ray

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
