Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4A8773B93
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 17:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjHHPwp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 11:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjHHPvO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 11:51:14 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2062d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CF2268F;
        Tue,  8 Aug 2023 08:42:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWGseXHyGj7Q1do9vXkhUA9EcjV/PcRtfknJH/QMc0uujQ8KX8yPtmek7gJ5t9/k+xtNCRHKQAqaRAdGQRcaUc5PkyGItwMBKO8gJyocdvIbU8M1i9ea4e1Eh0GQs2sVqKwDpmAwAA5NpohQ2jTIlmIlR5554jt8rOQlBHlauVdplocPqjxre5FvH9pHJ9r48NY8/yyZAoOl2jb8Hmx7zN/XqO71V/O+jGRA/HPqL3j6WfG0JqyOOdGxWkhspnc2nkKS3GusYYu6cF/0BaBhSbzDQOTpl1tG1igdLj480kCrUBJ801eMn38vb77uvgKdsy2FZfIB22TggwljXXMz+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoK2Y9FHdz94KZ21ESSGCvgvM65NNqBw2JXeC2nxago=;
 b=cgw8eKafa1HPWu7Gl94LlLOONp0NotMML//Fp2Dv+Y3aKJbm6DAv+zIaqE2eRtCd7i49lJ/6MwGG7EylIquITdlKO5VbthueXM/7MGaH3/nxgfZR4K58s4Tq3zX3DLILvG8K8mu9yoChB7yCCS9KstuyhDZjQ++dKmj/oVBvOO/wG2YmlwkdPRepJS7LXoG/KXIsAt4sHIgooA9kW2WstNdk/FK7Fa5Jw795+BhAf/qhw/gdxh3YoqEUel70nOf7PmgI9F5nh1tgz6N9tuC6Z+dNYxjmPv4mGABYpuC+tpZtdg7nFp632sb2AAytiaDoT4CjUAfbd2dpbAPA6Jdk4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoK2Y9FHdz94KZ21ESSGCvgvM65NNqBw2JXeC2nxago=;
 b=l0Wxx6jjvsVK9cfCYRpt1GlXHg7RcJN6zHcnD7zfpjdEFkhM36puwdLYTpWXeeEmydJb8ENTt+i9WZScGUgWEhPr58TvvKQog1zYmtk8HY8zTnovjUQltn/uLvioFrguzgG0lCBgyMFrv0pDyaw2KJ1OsoKuHykW2qllxxNE+w4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB8601.namprd12.prod.outlook.com (2603:10b6:806:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 15:35:40 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 15:35:39 +0000
Message-ID: <b5a45e28-2349-49db-ac97-7f37e6189e6f@amd.com>
Date:   Tue, 8 Aug 2023 10:35:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 2/6] cpufreq: amd-pstate: Enable AMD Pstate Preferred
 Core Supporting.
Content-Language: en-US
To:     Meng Li <li.meng@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-acpi@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>
References: <20230808081001.2215240-1-li.meng@amd.com>
 <20230808081001.2215240-3-li.meng@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230808081001.2215240-3-li.meng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR14CA0051.namprd14.prod.outlook.com
 (2603:10b6:5:18f::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: d5f28c6f-0d17-421b-3018-08db98251e3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fEPeb5ZUjAgTYDwqU+krwIk6oKJoqog6V9AqGOLdeWom1xaHKGYBqsovYGzJQzxMWEqwWggHDpyLpRRbwhkQva7/0cAlUPFbWhLN9e0w8aYekobdNwDtev4YdAprW/+T8v4FLriNOmGJYk2jbWXAbr98v2ivVgkT0YuhxXwAqG1FW2YR+yA6/IZhnZgAP+O0B/D2t2EYv+C/iZqhAJjLVlQzRzQNUQoO5SRV5JyhtFiF2nyGC9BPiGynih246+DpJSH3yAHzChexO5zZrifbcVS4yPe0BWX3dPjYdMOnYjOWuGx5TWbgFVZMOt1yxslVvCUHWBq6nlDPxjyPEmqgo1BePTkCzTF1ll70Ukz4bMO3UoIOoi8DlvmzXBe8oTHDOz31twrkqyncmQmXWqvOlVBCqZYQDXv84q3CFSRDNz7piTXBcZkyCEgCZrBOznJve+H2tjSDLEJmNYM2KiFA+gg+ZrjO6cZ4toptWgeTOxYFHeXBzrYenpQOK6uEowu3JxmNaCMK2yEy2eK7Nuzyk27rqee2o243OJrqoXQu6n01Qr1ewgdIZamh+EIz/pVwTknNgLWyq2zR9zNK4CpViRlVHrcHPqllvCIVZF7T4O9/wcYihZ2UQKbkXRdY9Jco6uZHcDPLxAzAtu+CrI622w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199021)(1800799003)(186006)(6486002)(53546011)(86362001)(31696002)(26005)(83380400001)(6506007)(2616005)(38100700002)(2906002)(478600001)(6666004)(6512007)(54906003)(36756003)(6636002)(44832011)(5660300002)(66476007)(66556008)(66946007)(8676002)(110136005)(8936002)(41300700001)(4326008)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkhjdXc3SGNiTFI3SFZESHptdGZmRXA4Vi9Ea01OK0VuNlEveTFoMFNVc1U5?=
 =?utf-8?B?c3hhZmRhQjNmeXJ3QWFwZVZRZ3ZNeHZQUWdmdGZFNDNGcjJ1a2JNMmNBb2dT?=
 =?utf-8?B?MnF4azQzeTBJN21tbzJVd1hlaWlUTUszWlJ4cWhnMWtpTnlUeDA5UW05Zi9T?=
 =?utf-8?B?OXBXUWlvNUlhb2xyTk1wdkxHV3lacTA4VXRpWUJxdFNWbWVrS1NzNnJ4WWlB?=
 =?utf-8?B?K2JTNDJoUEFjaHdlMzZ3VmpoV1hSekxFSFRPVEF4M09OVDZaUzBnV1luTjhw?=
 =?utf-8?B?TldCV3JrV2EycnRxSU9BVDZMbGxIWFpRa1lRMzN0NU1mU3RnTFg3Ukw1YURS?=
 =?utf-8?B?S1JlRWQzcm92QmxSMUEvamJ4azBjQjlab2tJS3NmNEh1Wm9GQUhaNTNqY0pk?=
 =?utf-8?B?NFFFSW1acTRBVEx1enQyeWJCWS9jVnFJZ1hJVWFleHJvamNWNDliWWhTbEpK?=
 =?utf-8?B?R0t1ZTA3c1Z4VEM1S1VYV0cxRWhSZGswMXVJYVE1TkdJejl4RmRZaVdSTENz?=
 =?utf-8?B?emFFS2RDTXZlYTlOVVhadXlrc0pZSXhDUTRUNkFyMWJtUy9WUEtJNE9mc2Jl?=
 =?utf-8?B?N09VRVpoQ0JUeXVNTGlBRkVXd2FYSTU2MG4zWWJmSnczYUo0bzlMZXorMnZ4?=
 =?utf-8?B?ZmpvRUNBWnZqZThFN0RLeSt2dDF0QisyRWlBejB1L1lKMjJ2c1JaY1U3SExI?=
 =?utf-8?B?UndPTXZ1OUZ0KzRtWEhuTEpVQm9hQS9XbDF3QVFwU3NwYmRuVnJtc1hqYWpD?=
 =?utf-8?B?VzZJcWw3N3YxK3l0eHVibzhybGgraWFrSlh4c1JPaHNKSTEybk9wTkttZ3JW?=
 =?utf-8?B?YUwxRnNvaE10cGw4OVZGcGhqYTFnOHh1NFZjVnVXUzFuUithaWhUZkZzcWIv?=
 =?utf-8?B?S2JWUk1zeE9RM1VpNjdiT2ZGZWY5RHNxaVRBMGE5eUU5amExd1k4cDhDVTNN?=
 =?utf-8?B?SkZCeWJUZzlNdGhheWZxMGRqTXRMcThPaGE1NVRLVUgxSFN5M05vM2Mxa29v?=
 =?utf-8?B?dnRXQ1M0Z01nYTh2U3M0VWR2VnpUL2VDVGxhUWRoZzU0TVFycHdwc0s1R1M4?=
 =?utf-8?B?U0RIZ0N4OWpVazVyOEhqM054UEVMRTc5TlJEYVVxQ3NTNk1janNCdnJxMDk4?=
 =?utf-8?B?bmRIT2hhbVdOVjZLV1lybXNJTzJYc1JDUm5WQVdnWm4rM3FON1dna1p2b1ZP?=
 =?utf-8?B?WUJ3TTBaWmMxOU43V2FSVkd6RG9HNzFFOWRrRWF2WXBDb3ZLMjFJWjNmM2do?=
 =?utf-8?B?SkU1aXZHZ0FNSHZWNXFpbnRTbnlDSGltTnV0OU9pSUQrSllOTy9iWkl3MXd0?=
 =?utf-8?B?OGNXRHdXdWlaQTBQYkt6SzBtK3pPaUtQSHhvWXhEQzhIMU84WDJLQmhKZGtr?=
 =?utf-8?B?NzRJV3UyU2lMMU9nZWFoVE44c3VvcVdVRk1Cd3RkSnUxdWJ3b0tNanlZa09w?=
 =?utf-8?B?RkJZbXQxZVltZnhjQkZzWndEVzJ3Wk0wVVYyN0lTczJZSlJIZXl3bE1DTURw?=
 =?utf-8?B?S1RVSkRHL2lEOHhYMkEyMnptcStSNWNIOTVnUnE3VGVuSmJaeGswRHVESFBN?=
 =?utf-8?B?alBFYmlXTXlwdWFEZzF0aUV3VTNvWTdocVFYZ0daaWQ2eFZOTnhGZVFzakdy?=
 =?utf-8?B?cktabVNma0hTbGp0Q0QyWnhEV0hZalNXdWhpNk9nT3ZlL3R2OElXU0tFLzI4?=
 =?utf-8?B?eFN0dmxKS3JBUDJtYmdhREsrZEdRT0UxM1dqZVo4dUVkUDdLSzFOSnV4QkZN?=
 =?utf-8?B?cXUyUjdTODZxb2N3djJkUXNnSWdHUTdsR0JkaWRPQTRUUFRicmpDVVBXUDhX?=
 =?utf-8?B?NDVsUC94amdScUxXeitldXVzN1YxeEljYTEzR2J1VzdNa1Y2YU5scVJSaWhD?=
 =?utf-8?B?RlN1eFBkQjFReE1DdUltOXBCaEwzZGpZMlE4SXNJWG9ScEdrdWVqenAxaVpG?=
 =?utf-8?B?TTg3aHRHODBoaXRvcXVyYTgwenZURFNUSHUvMVFjYUlEb0d1SktGVGNITTNU?=
 =?utf-8?B?c1Z5MC95c3JOVnE5Y2JMdERZdUFabHAxRmZ0VCtQTmJRbE0xZGZ3d3AwOXdQ?=
 =?utf-8?B?NFhtaGhKSnp6anN0dE1kcU1WOEMvVUlBTEo3eWczS2c4em1YUzNndlM0SW9y?=
 =?utf-8?Q?kkWUsaCsXWxyMvZqdkeoUnFOD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f28c6f-0d17-421b-3018-08db98251e3e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 15:35:39.3702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Puad1IfPdm/5219ezVjhCS0BjdcyMaXdP1+sAQaurHAkJck3OzaEJHo3IKfokh7CVqhpASwnu0XL3+t71VyUdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8601
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/8/2023 03:09, Meng Li wrote:
> AMD Pstate driver utilizes the functions and data structures
> provided by the ITMT architecture to enable the scheduler to
> favor scheduling on cores which can be get a higher frequency
> with lower voltage. We call it AMD Pstate Preferrred Core.
> 
> Here sched_set_itmt_core_prio() is called to set priorities and
> sched_set_itmt_support() is called to enable ITMT feature.

By using this function you need to also ensure that CONFIG_SCHED_MC_PRIO 
has been set up in drivers/cpufreq/Kconfig.x86 when amd-pstate is used.

Also I think it's worth changing arch/x86/Kconfig to:
1) Drop the requirement for CPU_SUP_INTEL
2) select X86_AMD_PSTATE

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
> Signed-off-by: Meng Li <li.meng@amd.com>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 149 +++++++++++++++++++++++++++++++----
>   1 file changed, 133 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9a1e194d5cf8..e919b3f4ab18 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -37,6 +37,7 @@
>   #include <linux/uaccess.h>
>   #include <linux/static_call.h>
>   #include <linux/amd-pstate.h>
> +#include <linux/topology.h>
>   
>   #include <acpi/processor.h>
>   #include <acpi/cppc_acpi.h>
> @@ -49,6 +50,8 @@
>   
>   #define AMD_PSTATE_TRANSITION_LATENCY	20000
>   #define AMD_PSTATE_TRANSITION_DELAY	1000
> +#define AMD_PSTATE_PREFCORE_THRESHOLD	166
> +#define AMD_PSTATE_MAX_CPPC_PERF	255
>   
>   /*
>    * TODO: We need more time to fine tune processors with shared memory solution
> @@ -65,6 +68,14 @@ static struct cpufreq_driver amd_pstate_epp_driver;
>   static int cppc_state = AMD_PSTATE_UNDEFINED;
>   static bool cppc_enabled;
>   
> +/*
> + * CPPC Preferred Core feature is supported by power firmware
> + */
> +static bool prefcore_enabled = false;
> +
> +/* Disable AMD Pstate Preferred Core loading */
> +static bool no_prefcore __read_mostly = true;
> +
>   /*
>    * AMD Energy Preference Performance (EPP)
>    * The EPP is used in the CCLK DPM controller to drive
> @@ -290,23 +301,21 @@ static inline int amd_pstate_enable(bool enable)
>   static int pstate_init_perf(struct amd_cpudata *cpudata)
>   {
>   	u64 cap1;
> -	u32 highest_perf;
>   
>   	int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
>   				     &cap1);
>   	if (ret)
>   		return ret;
>   
> -	/*
> -	 * TODO: Introduce AMD specific power feature.
> -	 *
> -	 * CPPC entry doesn't indicate the highest performance in some ASICs.
> +	/* For platforms that do not support the preferred core feature, the
> +	 * highest_pef may be configured with 166 or 255, to avoid max frequency
> +	 * calculated wrongly. we take the AMD_CPPC_HIGHEST_PERF(cap1) value as
> +	 * the default max perf.
>   	 */
> -	highest_perf = amd_get_highest_perf();
> -	if (highest_perf > AMD_CPPC_HIGHEST_PERF(cap1))
> -		highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
> -
> -	WRITE_ONCE(cpudata->highest_perf, highest_perf);
> +	if (!prefcore_enabled)
> +		WRITE_ONCE(cpudata->highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));
> +	else
> +		WRITE_ONCE(cpudata->highest_perf, AMD_PSTATE_PREFCORE_THRESHOLD);
>   
>   	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
>   	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
> @@ -318,17 +327,15 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
>   static int cppc_init_perf(struct amd_cpudata *cpudata)
>   {
>   	struct cppc_perf_caps cppc_perf;
> -	u32 highest_perf;
>   
>   	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>   	if (ret)
>   		return ret;
>   
> -	highest_perf = amd_get_highest_perf();
> -	if (highest_perf > cppc_perf.highest_perf)
> -		highest_perf = cppc_perf.highest_perf;
> -
> -	WRITE_ONCE(cpudata->highest_perf, highest_perf);
> +	if (!prefcore_enabled)
> +		WRITE_ONCE(cpudata->highest_perf, cppc_perf.highest_perf);
> +	else
> +		WRITE_ONCE(cpudata->highest_perf, AMD_PSTATE_PREFCORE_THRESHOLD);
>   
>   	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
>   	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
> @@ -676,6 +683,90 @@ static void amd_perf_ctl_reset(unsigned int cpu)
>   	wrmsrl_on_cpu(cpu, MSR_AMD_PERF_CTL, 0);
>   }
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
> +	if (no_prefcore)
> +		return;
> +
> +	for_each_possible_cpu(cpu) {
> +		ret = amd_pstate_get_highest_perf(cpu, &highest_perf);
> +		if (ret)
> +			break;
> +
> +		sched_set_itmt_core_prio(highest_perf, cpu);
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
> +/*
> + * Check if AMD Pstate Preferred core feature is supported and enabled
> + * 1) no_prefcore is used to enable or disable AMD Pstate Preferred Core
> + * loading when user would like to enable or disable it. Without that,
> + * AMD Pstate Preferred Core will be disabled by default if the processor
> + * and power firmware can support preferred core feature.
> + * 2) prefcore_enabled is used to indicate whether CPPC preferred core is enabled.
> + */
> +static void check_prefcore_supported(int cpu)
> +{
> +	u64 highest_perf;
> +	int ret;
> +
> +	if (no_prefcore)
> +		return;
> +
> +	ret = amd_pstate_get_highest_perf(cpu, &highest_perf);
> +	if (ret)
> +		return;
> +
> +	if(highest_perf < AMD_PSTATE_MAX_CPPC_PERF)
> +		prefcore_enabled = true;
> +}
> +
>   static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   {
>   	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> @@ -697,6 +788,9 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   
>   	cpudata->cpu = policy->cpu;
>   
> +	/* check if CPPC preferred core feature is enabled*/
> +	check_prefcore_supported(policy->cpu);
> +
>   	ret = amd_pstate_init_perf(cpudata);
>   	if (ret)
>   		goto free_cpudata1;
> @@ -1037,6 +1131,12 @@ static ssize_t status_store(struct device *a, struct device_attribute *b,
>   	return ret < 0 ? ret : count;
>   }
>   
> +static ssize_t prefcore_state_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", prefcore_enabled ? "enabled" : "disabled");
> +}
> +
>   cpufreq_freq_attr_ro(amd_pstate_max_freq);
>   cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>   
> @@ -1044,6 +1144,7 @@ cpufreq_freq_attr_ro(amd_pstate_highest_perf);
>   cpufreq_freq_attr_rw(energy_performance_preference);
>   cpufreq_freq_attr_ro(energy_performance_available_preferences);
>   static DEVICE_ATTR_RW(status);
> +static DEVICE_ATTR_RO(prefcore_state);
>   
>   static struct freq_attr *amd_pstate_attr[] = {
>   	&amd_pstate_max_freq,
> @@ -1063,6 +1164,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>   
>   static struct attribute *pstate_global_attributes[] = {
>   	&dev_attr_status.attr,
> +	&dev_attr_prefcore_state.attr,
>   	NULL
>   };
>   
> @@ -1114,6 +1216,9 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   	cpudata->cpu = policy->cpu;
>   	cpudata->epp_policy = 0;
>   
> +	/* check if CPPC preferred core feature is supported*/
> +	check_prefcore_supported(policy->cpu);
> +
>   	ret = amd_pstate_init_perf(cpudata);
>   	if (ret)
>   		goto free_cpudata1;
> @@ -1506,6 +1611,8 @@ static int __init amd_pstate_init(void)
>   		}
>   	}
>   
> +	amd_pstate_init_prefcore();
> +
>   	return ret;
>   
>   global_attr_free:
> @@ -1527,7 +1634,17 @@ static int __init amd_pstate_param(char *str)
>   
>   	return amd_pstate_set_driver(mode_idx);
>   }
> +
> +static int __init amd_prefcore_param(char *str)
> +{
> +	if (!strcmp(str, "enable"))
> +		no_prefcore = false;
> +
> +	return 0;
> +}
> +
>   early_param("amd_pstate", amd_pstate_param);
> +early_param("amd_prefcore", amd_prefcore_param);
>   
>   MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
>   MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");

