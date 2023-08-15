Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F5F77CF0F
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 17:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237845AbjHOPYT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 11:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237866AbjHOPYI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 11:24:08 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DCA9C;
        Tue, 15 Aug 2023 08:24:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0aquZNstOxAQuGgBZ/6QQkfKs/0G4JR4MIEgFlGftglTSANTsoI4RLeC/yrU5ZsQt+CYyE49s+HVPJQ98SI3nnA298NgM1JvekNa5+4bo6Pah4YSDNRy9ql/sWUqe3F/bWlBYjEtIpP0W90/OrZUvwKDDpnGRJWZ7eohvcetxnWaw/YOtOa4bRTmfTUJ23a5RFSb2fhLSeNlb2tqNn9RqnJ/psbm6gT5W4uBj0KlTNIKu+e12FNJvx12LzPQKnnnJ9Y0WFCX+fxpRzY1ToaZgrGjLQ80H8TjEzm0YymUb+pfHiJviaSM+X6utv0cevCt4sOFVrES6DEyyZcdVzoLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QclGgNeXyXBRxqwK8ctKAq4Tu+Wh5vKkukGDOIjUaPk=;
 b=J/y6f2mbZbrg8+iEh0e21+SXMTOiTOmYwTZuPKRdR9B4Cx9tEYDWPJv9l0vy3XwIEV6nfrKLNPZYj3X34WhPuRrnen/w/0wFJrABKDyaVIDxl38AfXChSvaan1JZsWVKVvBRV7mf7m8jc0Go+FCZkebYuJIeQyAKOqPOzDINPWp05AdHxw/U1rm6GoCCGJlTPqbMBLvj/WZTdMOhDVEbuBumkYg8f5QnFJhxn5SHnZfRvDQNvktNqcgPloIeoMo3tdhYqj9iF188FrQEOjbrF1bgxzAFXfeM+ujtylZ/aiTfXmoLIJZK4DfwFpBS2G6ItZDo0fHp1CZS8ctI3NNUiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QclGgNeXyXBRxqwK8ctKAq4Tu+Wh5vKkukGDOIjUaPk=;
 b=MfRWePDcQLY1+/t6urlOXq8dIIFnYn0/ucyNYah+5b/hVQtHdJ1ozGwcMDmWMJUYtZv8CU357zn9rGmnDeibjXFeE2oxBjXC4hzyWp9Q8RJ9qZ6QK2SzSwheLSYr7fyl4l2vcDgjFASPupSstr5LFyrq9XSqdyjhikaUA7Wn6Xg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB7656.namprd12.prod.outlook.com (2603:10b6:8:11f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 15:23:58 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 15:23:58 +0000
Message-ID: <91181568-83f7-4fd5-a3cb-869b07e55a74@amd.com>
Date:   Tue, 15 Aug 2023 10:23:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/7] cpufreq: amd-pstate: Enable AMD Pstate Preferred
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
References: <20230815061546.3556083-1-li.meng@amd.com>
 <20230815061546.3556083-4-li.meng@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230815061546.3556083-4-li.meng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0028.namprd08.prod.outlook.com
 (2603:10b6:805:66::41) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: 6022f8b1-6a7d-4e1e-cb59-08db9da3a4ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bk+h211aUNl2c+YwUcgOWhm051yfq3u1icUP03SpcWzllSkMmYVamsKpNcFyf6Ij93PGiLaIuHf1iup7jmthn65EJsB4LKiKv8U5a5pQhQ+zsGvhmPmUK+M2tWDY65sUjpWTeLJLxZoKSIdbpH2x+PQ1YPqWYa+4bJinu2z7glOLBYJa+TxhyhnagXwWnVnR9rkcpPDSxR4zggTh/Gqq33cJao481PCPcNi2RuGL0TIbjXRqjKnV2xysfPO+bP5SdGKBQBNYEi4u08T2lAetSNclLc8RHJX4CHbfGJj4JjUuuLZot+NwmxECBTjdmOfwjfsp1+/5A2dfpw2vqUzOjhyt0VEOR0Q3lmdCAnof4sCMxXd+H2XM13VpiLhJg9yYW9Y8yvWKerDQfjtpAsdQ3tL8kWPP6bq87iZDOZllK9HzomEtfL/gn1bWVPNFQFLiX73FbNJ114Q9Ojcwdjj8fIMfVA9IG9Wf4Vv2KmGsELSXBp1nr7oXrM4n0QaXs+PTxt5pUDs0vu/Wh/ZGbnw6ie/by4SedEsjjXByf9JZRZqJzMoIre0m5dKhp2N+OGFpxt2frm/riRXcunStgp3xPi27JWmlK+yaHFMECc+wDX88IvdcqtNS8XGNusrg8mutSAceWfSbR7agx08X3z93tA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(376002)(366004)(346002)(1800799009)(186009)(451199024)(2906002)(8936002)(8676002)(44832011)(4326008)(6486002)(478600001)(110136005)(54906003)(6512007)(83380400001)(6506007)(66476007)(66556008)(5660300002)(41300700001)(6636002)(66946007)(316002)(2616005)(86362001)(31686004)(36756003)(31696002)(6666004)(38100700002)(26005)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emkydnRRaEVadHlJR3hNT2IwOVNvbWxOU3c5aHVmajFqaUdWL29xQmdGR0hv?=
 =?utf-8?B?Nlg1aXg5NHBQTE5MVVVpQ1djVU5pR0I2bkxLbEdOazV2NDNyRHUyQ25jTTA1?=
 =?utf-8?B?dFB1NHUyclZvUUpSbTZHOU1MMkhFSmJIdlJjMCt1VUxSNW4xNWdlTjM2Wnc5?=
 =?utf-8?B?dEk4UVhmT25Xck9kbWdQbDJJOEtUQW5FRXFYMUMwcUF4MnpRdnRaeTQxNjhP?=
 =?utf-8?B?QXc5Ny9mYmFvZlpoQTVIcVR4Sld6QXIwdEsyQ0ZvQzkzdzhaZFYrbHgwczlT?=
 =?utf-8?B?ZWJrV3BYZ3ZUWWlRQlRyZUFCSG1lK21FbjZnSU0rNmpWOTFyRWxtdVEvNjFH?=
 =?utf-8?B?dllDODZ6eDFtTmZobEQrdXVueTRNOFl0YWR6a0M1QjJEMnZiTjJZbDhMbjEv?=
 =?utf-8?B?M0FJQllqTnhLSno3aUVHRE56K2plTktKeFNCTE5vZEJLUkVHMEpXT1RRdjlD?=
 =?utf-8?B?VlRTVGFoM09kSXVYeHpQeWRqcTRyY21uMjJ4aEZQNVdPNjBoclo2dlphM0lw?=
 =?utf-8?B?Y2x6RlYramZaUm16anNpSkdLaGRKQXBEcTZmZ1FoYkRsdEZtNFR1NXpDcGY2?=
 =?utf-8?B?RkJnSXp5MVp1enBuUk5nNkFmTlJTbnRMQnh0RVMxMUd0WWFTd3cxQmRhUlVF?=
 =?utf-8?B?bVJYUGJaWE9nSnR1dVM4eVJxNG9hSFdRdmg0enh2Q0RyaUcxdlFmNGlxcGpC?=
 =?utf-8?B?VkNDSmdwSFlUejVyQ3BhQlBFL3lPWXU4Qlh3dUc3K01oNHFtazd5OGU4SUov?=
 =?utf-8?B?WHpyWHB1ZlNJVFRDMnBiZUhCTVBiVFBQU3ZFMTFxL1pmNkFZZmNZUmxnTmpH?=
 =?utf-8?B?QWtzZUx0MHA1YjJzNnZCUFV0VXgvNEVVdVQ0UU9CM1R3bGc5ZTQyejdkaXdX?=
 =?utf-8?B?MkRoNDlQakdRZDcwK0VEc1Z4dHBXY0FocFZVb2RiODh0K2RraUJBYms0Rjdy?=
 =?utf-8?B?c3VSc05hTEhiUW5aSFpyQzdXanBXN0FRV0tvWGhERE9HaDVLMzZsK3lCTGd1?=
 =?utf-8?B?cDlTTEE4UERsWlBUcENMbnRza2J3MS9Ndk9ZYkVKbCtSUG9TcGNjU1d6MDh4?=
 =?utf-8?B?cFh5VEo3OGJUMWFsRWVtYnJ4cTBEYW1IVDJsenJ3U0pEMGRSVjJGSWZRYVU3?=
 =?utf-8?B?NjJTOVRPeWpwbFl1NFExV3d3NHhXZHNOS0Y3OVNXR0h6Q1lzWWdjVWNTSFFz?=
 =?utf-8?B?OVVYdlFEMEYrNkpqRHUwbG02cUJycmh1VkhkZTdRMkFQSERBR1VOZVN0RDhV?=
 =?utf-8?B?SlhMSncwc3pTemZPeU5yUkMxVkQ3anVLczZnbWh3VXpla2hqWGVqUDhEN0s1?=
 =?utf-8?B?TFgydG5OcGtNOGdlNzdPVWFZTHpKR2VvVnJ6R3NBbGN6bTMxbHpMbXFtUjdy?=
 =?utf-8?B?MTd1QlA0ODNzWGlCaFFlN1UvOWFPMElHR2M2YUZDajRseXhDcVBiWkJOTnZn?=
 =?utf-8?B?bE9zeUJBM2JRenYxdVdmeUwzcDQyYzBTZUh0dVEwVlRzUGp1MUpUWE0rbmVi?=
 =?utf-8?B?dy9wenVsdlQwUHBYU3NnUDVPYWpkYUp1dkhhbndGaEEvQTlNR3JyL2k0N0hr?=
 =?utf-8?B?L3Z6QXpnVGRETkVXS1VPTlhyREFvNzVpMEZhYlZia2FaenlNQjl1bUdMRi9i?=
 =?utf-8?B?NmVNckttSWwrT2ZyR3laM3RLblo2RjJFMUYwallQZm9mcGN3RnBxRjZodkNY?=
 =?utf-8?B?b2loektqOUFHSU1hUFVBWHNURkhHTWlMYUJHTkhZUXYvY3pDVFl4a3hxSGlI?=
 =?utf-8?B?eVhjanFIM09GNHp1UU9GeXEvKzUxVG1qcE4wRWpYQ1hqSFB3T3FzbCt3cndZ?=
 =?utf-8?B?YUxGU1U4V2EraUoxZUdYa2tHVFRXK3NrNlVhZFNNdDE5bnBiaGZiT3JsSmlu?=
 =?utf-8?B?T3hhY2EyTm1XVjVQWVVBWHdCcXlZQVR2TjNSd2UxSndEbDl4ZDBxOFIrOFB2?=
 =?utf-8?B?V2N6bXpyMzlGdWEyb3pYNC9BUG9TcE00UEdkT3ZpMmJXb09QVUQzS2c0NEQz?=
 =?utf-8?B?VWozc2ZTbTNNZWxMbVV5OVJiQndmUERhUWRDczU1cEhkWUl0STAwR2ZNcmZz?=
 =?utf-8?B?d0JxdHZrVndGR2dLWTNuQ2lncWFCcUVndzNxeUh6VnpDdGhsYWZRQ2dQQW5z?=
 =?utf-8?Q?7Slpp8lL3aRxBFQipF42YLffT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6022f8b1-6a7d-4e1e-cb59-08db9da3a4ce
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 15:23:57.8300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qh8hSkFBaH6ZumB4cBXxILLBb1vc5MsIvXq/si6fG+GBJe2KQkW0D/DnBhYgx35EfEh6cQKoS50VTqZSWhuOhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7656
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/15/2023 01:15, Meng Li wrote:
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

s/enable/amd_prefcore/

> enable the preferred core if the processor and power
> firmware can support preferred core feature.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

You and Perry worked on this together, right?
If so I believe you're missing a 'Co-Developed-By' tag here.
Also the order should have you at the end as you're submitting the series.

With those two nits fixed:

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/cpufreq/amd-pstate.c | 120 ++++++++++++++++++++++++++++++-----
>   1 file changed, 104 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9a1e194d5cf8..d02305675f66 100644
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
> @@ -65,6 +68,9 @@ static struct cpufreq_driver amd_pstate_epp_driver;
>   static int cppc_state = AMD_PSTATE_UNDEFINED;
>   static bool cppc_enabled;
>   
> +/*Preferred Core featue is supported*/
> +static bool prefcore = true;
> +
>   /*
>    * AMD Energy Preference Performance (EPP)
>    * The EPP is used in the CCLK DPM controller to drive
> @@ -290,23 +296,21 @@ static inline int amd_pstate_enable(bool enable)
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
> @@ -318,17 +322,15 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
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
> @@ -676,6 +678,72 @@ static void amd_perf_ctl_reset(unsigned int cpu)
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
>   static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   {
>   	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> @@ -1037,6 +1105,12 @@ static ssize_t status_store(struct device *a, struct device_attribute *b,
>   	return ret < 0 ? ret : count;
>   }
>   
> +static ssize_t prefcore_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", prefcore ? "enabled" : "disabled");
> +}
> +
>   cpufreq_freq_attr_ro(amd_pstate_max_freq);
>   cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>   
> @@ -1044,6 +1118,7 @@ cpufreq_freq_attr_ro(amd_pstate_highest_perf);
>   cpufreq_freq_attr_rw(energy_performance_preference);
>   cpufreq_freq_attr_ro(energy_performance_available_preferences);
>   static DEVICE_ATTR_RW(status);
> +static DEVICE_ATTR_RO(prefcore);
>   
>   static struct freq_attr *amd_pstate_attr[] = {
>   	&amd_pstate_max_freq,
> @@ -1063,6 +1138,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>   
>   static struct attribute *pstate_global_attributes[] = {
>   	&dev_attr_status.attr,
> +	&dev_attr_prefcore.attr,
>   	NULL
>   };
>   
> @@ -1506,6 +1582,8 @@ static int __init amd_pstate_init(void)
>   		}
>   	}
>   
> +	amd_pstate_init_prefcore();
> +
>   	return ret;
>   
>   global_attr_free:
> @@ -1527,7 +1605,17 @@ static int __init amd_pstate_param(char *str)
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

