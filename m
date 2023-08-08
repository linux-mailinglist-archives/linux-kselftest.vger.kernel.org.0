Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E901773BF1
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 17:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjHHP6o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 11:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjHHP5O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 11:57:14 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC3B1BCA;
        Tue,  8 Aug 2023 08:43:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3HrmxFmViPcdNCJxW6Cnz5FU7gmAp9ourx7dHTkj5qrVOV+s8Aa97Jbn4NKKQHAufPR4NjYtp07dU9xIc9MemqGZ+lFm8i3CHma3J/66rqYFXoVijPVlZfvV/L9dkroLmc/dI5zLkXHdwyJ0wXmKO5kj7saiu2Dge1EIGWqdIyoOL9lmqVdsorpMZr7671wUpf2BxKgNSNTB5E4e0R0DdzUbb+nhtEk9WAuOS68f7T8OFpmknI8S91hh5L/wShaG/6nQ04SwJFkWV4Bkq7706zKvOrYkcIIyABWxKWz2i3A1mhl4rPJv5ab2ipqpteFPhZ/PFAdicZnoDsCsW2IWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EA0a5l7/B1TbC4Kfrp2BiKerjI32F6sruvnOj7BuBo=;
 b=HUoelnPbg6sJl9ftq4skdvD1hYP75uvGCiQQyL/EQ1WKuEzZMkHPZewfoIh0oAc4jQZzsJFrGB/y/4AXWyh32GAUdxa48c+SMVZ7hLrfWFSO4heRmDDwOh4pprDMY8naIjv65WtdkfBwwnlZRXEkaY/HmQyr944ahwudlgs4z5x9wub/YdZH9tkB1W6H5lPBCTPTJJ1GPvmpPnLE/146tW6byXx3BZFyCY8qAOgZQ7z1BiEb/A1riKMVmsUiKBePMnc+7VzWFWXHKLWGCkaiyGC2BVZ6uwioj/U8Wdd0O2tcqojO+Pa5sNSHextesZg9/5nfOQxbpNlutu41La4ZJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EA0a5l7/B1TbC4Kfrp2BiKerjI32F6sruvnOj7BuBo=;
 b=YTa2E/fI3LgJKx/yg+gzSjvLunNucPB2insDQeRGK0jNZQ0HrB+JKXodgTbJSRN3MoseNsOlHeSR0UAbrsQIzmcn00+xfSa109flRpqqiCH5b4RrFBL4Iimcq8Jf9sof8AFgJimXcaVTqnqz9HFeSg/20b/GYgiF/ix6wh6IdUY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW6PR12MB7088.namprd12.prod.outlook.com (2603:10b6:303:238::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 15:43:12 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 15:43:12 +0000
Message-ID: <91e640d6-6d1b-48bc-87b9-755869af87dc@amd.com>
Date:   Tue, 8 Aug 2023 10:43:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 1/6] ACPI: CPPC: Add get the highest performance cppc
 control
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
 <20230808081001.2215240-2-li.meng@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230808081001.2215240-2-li.meng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0048.namprd02.prod.outlook.com
 (2603:10b6:5:177::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW6PR12MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ff48565-3392-42e1-fb6e-08db98262c36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y/pHRyMwv7VcP80f0XVhJjwtXrC9LKkpNWIbu8hcWelMCn/tnTWDbzu1GlN1rpRQmuZBBm2SP7taVrVWLwwdRMeeBxE3jfiuLgE+fZ4vK4gpzD0hraAdZwSYtdEG8C7qvr6AvB3pdjAuIkAi4eLU1pHA+B5z51RkSWFZdOYj1mKEzKTPXT7IM0RTelqi/EkcwJDL7E8ujY2brUz62AkuqRQSOUx4PFDeGhSjcHBch61dbV2T/EZ0o5a8kCz9yyXpX0FvUZS9ErmZ697x4WuJnvGo3owU/FG+JrMRoaVuR977VqUwnYx7795d9IbDWmPc03Brnzsw+NAkw+Hzmn7LSOUEe0YKyXckEXK7Er/N213SQL0ewDF/uy3GJMAbWLxsNJfDPcS+JALpKL+AZCN54UERJXUFPrAe7jbNcuN7JRz7CpNLdLocOTSLfvFdA0LVPGM8z9DtVJU8pDGgENmPc8WNnN+4r9ZBMd3DQUwQYHrDlmUNjgSM7hpHutCsIs1DQTGsS1Dw3U0gI/mZel34Rl6r2ONdlX/mog8b4oW9ExnR/zmRkhIncEiAIaqYXhqWTP0MigfCABM6Ww0YOakVPxDzX5/ihhfeGN8a9KcD0szDTJhrkR/ccBgrcRiIyh9ti5TCGN6UYCh7f+uV8x9wK97pH84yjipSGKyn3QHer2M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199021)(186006)(1800799003)(38100700002)(53546011)(6506007)(26005)(2616005)(83380400001)(36756003)(2906002)(5660300002)(8936002)(8676002)(44832011)(66476007)(110136005)(478600001)(31696002)(966005)(86362001)(6512007)(6666004)(6486002)(54906003)(316002)(41300700001)(4326008)(6636002)(66946007)(66556008)(31686004)(15583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qk1wMmhaSS85UmE3WDFnY1R1VzlYdnlOQUxzS21IN1VrWE1BY2FlRHdwSG9Z?=
 =?utf-8?B?N25EQjNtNTB5akVJS0VQZ2FoR0FPTzhuWkRBSUwxTVhROExVbmhocjZReWRH?=
 =?utf-8?B?dDd6YkZJWjJROXVDL1dYUnVqdnk3a1dpbkpST2NQVDlGb0loWmpkdzJscUdr?=
 =?utf-8?B?dStBSUdadGJZVkV0ZnBHdmRrV3VCcTh4V1grTmFiZGk5OUFvQURlY3MyT0Rw?=
 =?utf-8?B?aW5oajZiVHNFQ1MxdmhsZG1hUW9tWFVFVlJLS3RhNmRaS3hEVzI1TXdHZ0lj?=
 =?utf-8?B?VFVFbGdqV0dOQ2tFdjBNcnFwNWhmMjZMSTNFK3pvUHZwRTRRbnpCaEZCNjUz?=
 =?utf-8?B?SkUvaVJBMkdLSVBNaG5oVVM5S2lvdFl4U1liYmsxbXBBd2pNUGsrY3ZmTWhl?=
 =?utf-8?B?Y0ZDOFpsS3lqakV2N1BWSGxTZGFiWVF1UXA0RklrbXcvWUFKUWNiaEJFT2tF?=
 =?utf-8?B?aWdOcXFMNm5oTDJaM3k2bDNLN0JFSUFHMVZiSE54RHNjQTNZUUxielFudGNO?=
 =?utf-8?B?b3FEUXhIRGdETmlMMUNTR2FYakZPV1htNGZ0RUVVa2xhbzJEbEtsSGN1ZDBY?=
 =?utf-8?B?NnptNGpKVFlmTVIrZ0srTy9FYXBuS1A3dEE1blIzT3d2MFA1SnJpRDNCWERC?=
 =?utf-8?B?N1BKY2wrSzR6dzJKUWNORnVQZFZXalEvY1ZXejgxM1FJY2M5QzVLQlBLVU5u?=
 =?utf-8?B?M0hQNFZpNmVlb0Q3Qkg5YThtYmNROVVPUzFaUDF6cXE0eDNMTUhuTFdZTm83?=
 =?utf-8?B?bUpCakRrWSs5cXFXVmIwM0swMzh3RTlmK0NyVnBhTG9XWGg5L0ZZTHVNSXpY?=
 =?utf-8?B?SXNKcGlHeXlWenh2YTFsOGVsUGpRSkFzbGY5bUlYQmhONElkb1U5TnhjYndS?=
 =?utf-8?B?UCtuLzZwNXJTeWpDRXBCcnp3SXExRkVXQjhVOUtFMVZIdG9RNzEwTW52NUcz?=
 =?utf-8?B?SWZqZnA0YVRKQ3FEL3AxYmRKendZZ1VNbWdvKzhPTDlWbjhTbDZqM1hzWXBW?=
 =?utf-8?B?L0xpUStjdnJVSjEwcm5lQVJKYjNCZTdKZ3QxRWtaVDZtSjBVK2E2b2NNN3FU?=
 =?utf-8?B?bS9hR1VseWtjRWVZTXRtcnpDVVpnVDRxS2U4b3BhSnl5RzN1Mm0vM3h4Z0Fs?=
 =?utf-8?B?UkVvT1BvUVp4d3dJdXVJaGlndERUUEVlWG9HY1hTQjZmY2xEV1MwaXVGV3pB?=
 =?utf-8?B?TjY1UFJiVzk0N3l5OXFGK25qSkxpZ0xWUTFnZ3AxWHFHTlpXU0pIREluQThu?=
 =?utf-8?B?M1FUb0ZFOUNkS2JuQUYvUk5rbmtER2tydmRSc3hyN0g4TThSeGVsajFsd3Jr?=
 =?utf-8?B?bXhnWU5LU0JKZGhHck53Sk52L0hPNWpTT2JUdk9jOU1QYWx4bExsalBMNUsw?=
 =?utf-8?B?ZDhEMTRJbktZRHhVeEZtMmVlUE8wRFJUOFdrdXRlWDh1VzY2MjVvKzhGSDIx?=
 =?utf-8?B?NFBYbG44L21EOHBJZWFVOWR0RkRoY09zMXRqOWowckRmbHpSaEpiTTJOZ2JS?=
 =?utf-8?B?UTBDYnpIZ2sxN2RRZTNka1FjaldsRXZtN1JMRGxDOWFCQWhSSDVNL1RqdVZ0?=
 =?utf-8?B?Yi85VDFpZGY3NkxxbGZTVDZvcFpsMkpMU2dUeXR0YWs1MW56aTlranVkNjU3?=
 =?utf-8?B?dUVMbzczZmprOEF1S29LTkVKM21CWGxaZUJaR1NEL25WRFdXSnhtQmU3SG5a?=
 =?utf-8?B?ZmlVRkU1Qm5ST1ZNcXBVTk1lYWJSZS9lSjVTd1JIOGRlZTdNUGVCZ21HTlA3?=
 =?utf-8?B?N1ViaHIzWWF6Q00rSWNZQnpOb09iZ1NHWTY1QXVLM0VyNEJPdndFT2dxUGtL?=
 =?utf-8?B?cjk4akNkbUVTRVdlbzJzOWxya2lsU2ZVL2I2WXNSZlFlYW1WNlRSYXdqb1Vk?=
 =?utf-8?B?RURZZHlsVjBnMVZJbTRmUmgxOWh2UXZSQzJ3bFVRdjB4djZzT3RBM0gwbjZ1?=
 =?utf-8?B?OFFQZTh0dmx5V0IzV0FiMVlNKzMxMnJiei81NUhMTllYNW4wTTFLb1pYQmds?=
 =?utf-8?B?YWwrTFo0MkpIQ1U1V1FzRVorSVExNk1JSWNzRVZKQm1sNFd0OGtUVXprYXVJ?=
 =?utf-8?B?WWZNYmVOeGVlYjdmcU5QaEdUYjVVOVRRRlo3RlN5MWJsaHpkRFNqbUUrbURJ?=
 =?utf-8?Q?VRIjcAFAWmx/DutnX13/Yf4A2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff48565-3392-42e1-fb6e-08db98262c36
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 15:43:12.3416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1DlWGqsoUjVsDba3WeXvVJFexL0uMON5gxi/zHv54IT9XDvIdlzRV8vNOZ3R0uZn+lgl2tHj35WR0083rNS/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7088
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/8/2023 03:09, Meng Li wrote:
> Add support for getting the highest performance to the
> generic CPPC driver. This enables downstream drivers
> such as amd-pstate to discover and use these values.
> 

I suggest adding this to commit message:

Link: 
https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html?highlight=cppc#cpc-continuous-performance-control

> Signed-off-by: Meng Li <li.meng@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/acpi/cppc_acpi.c | 13 +++++++++++++
>   include/acpi/cppc_acpi.h |  5 +++++
>   2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 7ff269a78c20..ad388a0e8484 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1154,6 +1154,19 @@ int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
>   	return cppc_get_perf(cpunum, NOMINAL_PERF, nominal_perf);
>   }
>   
> +/**
> + * cppc_get_highest_perf - Get the highest performance register value.
> + * @cpunum: CPU from which to get highest performance.
> + * @highest_perf: Return address.
> + *
> + * Return: 0 for success, -EIO otherwise.
> + */
> +int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
> +{
> +	return cppc_get_perf(cpunum, HIGHEST_PERF, highest_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
> +
>   /**
>    * cppc_get_epp_perf - Get the epp register value.
>    * @cpunum: CPU from which to get epp preference value.
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 6126c977ece0..c0b69ffe7bdb 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -139,6 +139,7 @@ struct cppc_cpudata {
>   #ifdef CONFIG_ACPI_CPPC_LIB
>   extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
>   extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
> +extern int cppc_get_highest_perf(int cpunum, u64 *highest_perf);
>   extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
>   extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
>   extern int cppc_set_enable(int cpu, bool enable);
> @@ -165,6 +166,10 @@ static inline int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
>   {
>   	return -ENOTSUPP;
>   }
> +static inline int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
> +{
> +	return -ENOTSUPP;
> +}
>   static inline int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
>   {
>   	return -ENOTSUPP;

