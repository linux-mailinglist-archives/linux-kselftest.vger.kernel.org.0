Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4871793203
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 00:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbjIEWdv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 18:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233937AbjIEWdu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 18:33:50 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61648C3;
        Tue,  5 Sep 2023 15:33:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JT6ZBmNscCp+/4Q6i7DYqrW3X9jgPDWud/jngFB8pa0sg7co5Lm8k/A7U7YL7oIwYGrW1RvnRLh9COLKR3OTdlbFsjfeBR/ieX3r93jRD9jO2ro+RVGIpDD9UXNhITVOF5VpSmx5IZTLXwkhZ6tUbrPBF1ARxnb+jnYym6nYsmPgxIW9y35oHySzbEmZ2TDfVyegrNd7vLXV47hgg3Thrmw7YFBH/hza5sNxSja1otRCKC0VN2FJTosYvRGv3vlbrr6j4KPJfDRanMRY0ihDKjkVK514Sl3sqGMi76/WfRBw0utdayVgE/QDElTqnEObaXH0vmGLHSewBVxtubtlmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkItypZgNq5iy+vNyg5XlKmANwddQKhA6J9TwU6UPLE=;
 b=Ho8+EM0U0gQghr4sikz/zmVOTJgehA706GPibenoXXLrxHLAj0Q6V2HFiiOugZhg+QJXiWalzwravwhTi4wELSQrUVS0qkb4xFMiBTz1R4of7mD08C6LnBGrq16JDB4QRYOf3MoxXsDsFiJy3CqSFPhGUHedUafQ4AuOGRjyVVZMqDF8XFUDeurwDav+vniNnaXStlMsBK+sYb4bBlvxb4dSQ5+qj3RwZqRtiL9Bz5qgV/OUFtT7tVcyhdKSdQCSGGFFmWb0aGcsiXPm6MY5Jy/vrzpvPWFk4CszcU1IbzlX7JevwKm6tyjTjIVQmDE3+mmxcFir7V1OhKX5r79flQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkItypZgNq5iy+vNyg5XlKmANwddQKhA6J9TwU6UPLE=;
 b=j+qQjd8c448e/aPl+jR6M2U2RgsWde3P2dmon3hioa65pYSqFP4PsogwVRJDB2MbwzWdWPlsHg26rdxd9hFm7YZX1YoNR/jl1nPEzRIQTdaPQnG80GbG05t7BFQgQxPZS+YhXwqz18UB4l27NFkmqCt8mqNH/gaR4rHydTWkKGg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB7212.namprd12.prod.outlook.com (2603:10b6:510:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Tue, 5 Sep
 2023 22:33:44 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 22:33:44 +0000
Message-ID: <0932c946-c53c-4e4f-9b19-514c84d3f8b2@amd.com>
Date:   Tue, 5 Sep 2023 17:33:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 3/7] cpufreq: amd-pstate: Enable amd-pstate preferred
 core supporting.
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
References: <20230905015116.2268926-1-li.meng@amd.com>
 <20230905015116.2268926-4-li.meng@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230905015116.2268926-4-li.meng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0194.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: 169e35ac-143d-4c7f-6c5b-08dbae602964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kUKnbVEHdoAHW6048G1cfjbFlEcW+gppPaBZQEJb3mrHIVLH73D3nHN1Gw1pbtKGSzrCasrwDJBwcWlR5r/uAHesf3FIhCH1K6dK1eOewShXRzNAZsgfyPq6PyIOL9WpaOu+oNlFisB84MaiBK119uFQyKpRnVf5taR6j4qCgYw5WYqmdZ67nCvsUDobjyoNEsdyd/PCoNTbVXXMpVHBHyVJEf8jIRkciKVFL+CY0LLbqQxL1GkNH/gButaeKE28fPFyNgfebySB9MDCZxEll/5nusQ0NDyOl+BQtN4HhQ3z5SZkwZkqSADxnYWIVWXZ9mJUz7CXNWiJbQB+vGuM6tCzOSnXJEIiW4JFC1YjghkDYECtGuR+E+W3AgTeXKJvvV2/vfrw+zTgNIkTAcsKL1RIiQkEBd4gpzBCxfGRCQmW187ArKfKZMH5Zx3gLZXXOGtbuzFbGxLxCughJyUl72r+4AMBT3fhuf2x4QewDIrcm2uw+fuHURiuKQ/TkULr4cuoUNNOx69X0qZmKjp1Z2oFrfK4+9d66CQawxIMTShvz4O0gXLBBVSA1IYtscC1lsIpdrdHDJkqR9wRsFuqIMqDcdujva1EIquL+PrOmJSYseHEfkjk1UAoy+34ReD5oc55qM5YnB4PUrEGselwOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199024)(186009)(1800799009)(31686004)(53546011)(6486002)(6512007)(6506007)(36756003)(38100700002)(86362001)(31696002)(2906002)(2616005)(478600001)(26005)(83380400001)(66946007)(110136005)(4326008)(8936002)(8676002)(5660300002)(44832011)(316002)(54906003)(41300700001)(66476007)(6636002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UC9IaVdKWXJjdjgxdC9JelFScWxIcmNIQlhCOVMySFlVT1ZEN0Y1Q2JBT0lV?=
 =?utf-8?B?T1FEemtUNGZhZkdsVENUMzR0Q1hXYkNncEtQbmIwY3ZzeUFNNVhDY3c1TzhS?=
 =?utf-8?B?UDcyeW5XNUpYRThZOVVJR2xEbWtzZURNdlZ1SkhTMU9WT0NpekkraHBLYThT?=
 =?utf-8?B?WVBiZ3pXakpPLzlIVEFoRjVsY0ZCckVrUjJpNE04M1krUWVIM3BBQjVIR2VR?=
 =?utf-8?B?VnFqcGIxOEplMzdXeTRHL05YUWdJVzdUYmh4b2tua2IzL2tDdHYzZENlZW83?=
 =?utf-8?B?MW5GcFpOTThHclp5dnVSNEF1QzBTOWJEQnRnZGJSZ21Ka0FaSk9MNWRzUnRv?=
 =?utf-8?B?RE9vM1VOR01BbkUzVGpZYzhkTFgxR28vK2hieUFDcEQyei9oMFAvTTY2UmEx?=
 =?utf-8?B?bFcyN25yNVdWc0RyU0NtM3ZCM243RGxONDEwaTZRTWt6QThCNm9PK2dMMFFC?=
 =?utf-8?B?cHFLczhhVzRMR1NBWEdvWnRSbkU4NEVFYkZRcGlyUFNQMXk4TUpxd245S0lH?=
 =?utf-8?B?eUQyNzJjU2RYQStOUEpQK2xFNTZ0aEZqdE5RWFZmMVROTSs4UDBIS1ZXZjVr?=
 =?utf-8?B?UTQ0M0tGMEg0WGVnZ1dCM0crM3F4VDRqK05EN1JBbU1ReFFMc0VEUWpSYXJX?=
 =?utf-8?B?VThKUWRoV09jNTlSTXFPbVY1b05NTGxTeStNeXNyU1VSNXA3eWpsMGM5Nm5E?=
 =?utf-8?B?UGxWbVFnU3ZOdTlzWXFTRnY3MXlWVzJEaVFvd1ByK0hQWlljdHl2SVVEZFdK?=
 =?utf-8?B?bExzQzdvTGFiejdiQzR0MjRRZEpWcjdpd0dFOGRQc1NkcDZRZW5ZUnhjK0l0?=
 =?utf-8?B?amd1anBHL1hxSTF0a2lTU1U4RlluNWZsdGJteUlRT1NqYUNUbHRGNWt5cXZW?=
 =?utf-8?B?eU9tNUxHU3IyTWZndGJDb25aUUVySCsrcGZ5QzdQTWJSamo2SE1KOXpTRjNZ?=
 =?utf-8?B?dURaR0VYdDhtRDg1eG1aMG52Uy9RaVZiU01Qd1kyb3B3d1oxSUJvNDdHbjBN?=
 =?utf-8?B?SC95QmhDa21UU3hYOW5wRzF0bndUYWlsUU5ROHJOeXFlUnE2RlJSSFFXUndY?=
 =?utf-8?B?b09KVHhESVpQM0l2blNSbXYwYWpKQzJrQjB6bWU0YUpzbEpmd2Z1RVpYN2wr?=
 =?utf-8?B?UUVRQS9keU5EVWZSTkRubFJhNGhGbStvK0ZoVjF4VkFtUmpycHNjR3R2YzBD?=
 =?utf-8?B?L0lpOVdMQXYzSjF5amhmK1NtdStVZGR2R1E4d3JrVzY3Zzg1SW5wbTRwQUFU?=
 =?utf-8?B?TGkvRnBDSFZKYlpBZm45RzJ6eXFkTjlyaGs0UkFzY3huSGc4SHM1MTFLdzc0?=
 =?utf-8?B?MTdqKzhtQUxVODRnKzVkV21MR1JWcHJ0c01TSktORTBDQi8ySkQrdWRTTURY?=
 =?utf-8?B?YXdMWUphb2wrcjFIMGR6N0pmcUVodkRFa3gzU2ZZcEt0bGNySFk2WGhsU3p0?=
 =?utf-8?B?VUNPaTRsOGo4MkRDMzlFM1hWK09halpwQ09BbnlHZjFiY0V6ZTd4bjR1em41?=
 =?utf-8?B?Qy80aGlpeFFrbmpyVDBrbjZkVFdpdUUyN29NeVpZQ1QyU2thOVZrOUVEcDB2?=
 =?utf-8?B?UkNTTU1CSXF2N0gyaFZOTGJlVWcvME1tWnBrdS9oVVBWcFFrcXdyKzVOejFy?=
 =?utf-8?B?dmVaUjBhSkVkZkxFYlNQTVlSWi9naXR5R0F6V2xpVXVKZTV4NnQydHNiTkRJ?=
 =?utf-8?B?dGhkbkNLTmd5V2tybHdBSG5vcDdNaEtsck5Ka3NmdEJzOCtLTnRrWjFOQXU3?=
 =?utf-8?B?SHp2Q214TXJ2WmFKNWViME9kajNRQTRiUnNneEFuazRmZ0RMUkl4NjdmMXBn?=
 =?utf-8?B?VGo0ZEdOTXlvU0poWm9hZWJmc042TXRXY2N3K3VIaVZDbFNLdEZFNlZhWGox?=
 =?utf-8?B?SGVVMnlVK0pYalFtRDBDRHltdjREeGpvYnlFNWlWTEpWSHkwOWFLQm1sODk0?=
 =?utf-8?B?YitYTUcrN2tkQ293Q3JnK1FMTlZLaEFRNVVGbWhlbzVBWlYzeFRrOGRrcE5r?=
 =?utf-8?B?eUorTkVtWTFseFlsUEhXdHFQL2NDZDJvdDNvbWx1SndwUm5SVmF4Q1I5UG81?=
 =?utf-8?B?d28vWEJuTWtUMGt6N3BZYkpxVkdLRk9DdUJFTjJ0ajAvdE01SjVDbDY0bTNY?=
 =?utf-8?Q?7Mbh+a7Io7rxBDSBDu8zDLOXO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 169e35ac-143d-4c7f-6c5b-08dbae602964
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 22:33:43.9709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lavhxzlQuFu2fYS/wj5HW2UhTBe4cb8dCvr8m1psw+FpBZ8cvH9q8z45XHPshbg/Xa4VNUglmBJtdnrLwsGULg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7212
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/4/2023 20:51, Meng Li wrote:
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

You've got the tag order wrong I believe for this.  Did checkpatch not 
make noise?

I think it's supposed to be:

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Co-developed-by: Perry Yuan <Perry.Yuan@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Signed-off-by: Meng Li <li.meng@amd.com>

> ---
>   drivers/cpufreq/amd-pstate.c | 131 ++++++++++++++++++++++++++++++-----
>   1 file changed, 115 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9a1e194d5cf8..454eb6e789e7 100644
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
> @@ -65,6 +68,12 @@ static struct cpufreq_driver amd_pstate_epp_driver;
>   static int cppc_state = AMD_PSTATE_UNDEFINED;
>   static bool cppc_enabled;
>   
> +/*HW preferred Core featue is supported*/
> +static bool hw_prefcore = true;
> +
> +/*Preferred Core featue is supported*/
> +static bool prefcore = true;
> +
>   /*
>    * AMD Energy Preference Performance (EPP)
>    * The EPP is used in the CCLK DPM controller to drive
> @@ -290,23 +299,21 @@ static inline int amd_pstate_enable(bool enable)
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
> +	if (prefcore)
> +		WRITE_ONCE(cpudata->highest_perf, AMD_PSTATE_PREFCORE_THRESHOLD);
> +	else
> +		WRITE_ONCE(cpudata->highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));
>   
>   	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
>   	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
> @@ -318,17 +325,15 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
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
> +	if (prefcore)
> +		WRITE_ONCE(cpudata->highest_perf, AMD_PSTATE_PREFCORE_THRESHOLD);
> +	else
> +		WRITE_ONCE(cpudata->highest_perf, cppc_perf.highest_perf);
>   
>   	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
>   	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
> @@ -676,6 +681,73 @@ static void amd_perf_ctl_reset(unsigned int cpu)
>   	wrmsrl_on_cpu(cpu, MSR_AMD_PERF_CTL, 0);
>   }
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
>   static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   {
>   	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> @@ -1037,6 +1109,18 @@ static ssize_t status_store(struct device *a, struct device_attribute *b,
>   	return ret < 0 ? ret : count;
>   }
>   
> +static ssize_t hw_prefcore_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", hw_prefcore ? "supported" : "unsupported");
> +}
> +
> +static ssize_t prefcore_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", prefcore ? "enabled" : "disabled");
> +}
> +
>   cpufreq_freq_attr_ro(amd_pstate_max_freq);
>   cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>   
> @@ -1044,6 +1128,8 @@ cpufreq_freq_attr_ro(amd_pstate_highest_perf);
>   cpufreq_freq_attr_rw(energy_performance_preference);
>   cpufreq_freq_attr_ro(energy_performance_available_preferences);
>   static DEVICE_ATTR_RW(status);
> +static DEVICE_ATTR_RO(hw_prefcore);
> +static DEVICE_ATTR_RO(prefcore);
>   
>   static struct freq_attr *amd_pstate_attr[] = {
>   	&amd_pstate_max_freq,
> @@ -1063,6 +1149,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>   
>   static struct attribute *pstate_global_attributes[] = {
>   	&dev_attr_status.attr,
> +	&dev_attr_prefcore.attr,
>   	NULL
>   };
>   
> @@ -1506,6 +1593,8 @@ static int __init amd_pstate_init(void)
>   		}
>   	}
>   
> +	amd_pstate_init_prefcore();
> +
>   	return ret;
>   
>   global_attr_free:
> @@ -1527,7 +1616,17 @@ static int __init amd_pstate_param(char *str)
>   
>   	return amd_pstate_set_driver(mode_idx);
>   }
> +
> +static int __init amd_prefcore_param(char *str)
> +{
> +	if (!strcmp(str, "disable"))
> +		prefcore = false;
> +
> +	return 0;
> +}
> +
>   early_param("amd_pstate", amd_pstate_param);
> +early_param("amd_prefcore", amd_prefcore_param);
>   
>   MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
>   MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");

