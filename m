Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A5278E104
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 22:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240495AbjH3Uxh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Aug 2023 16:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240526AbjH3Uxg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Aug 2023 16:53:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644821BF;
        Wed, 30 Aug 2023 13:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693428781; x=1724964781;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7PEw+jeS+IwAipn8sPo6BInYr+xG02cX6jiXVNXm9nQ=;
  b=imPeLK5xymlKQUBznKRKzO60bGxtMyWazaao3MAXWmflIPSsX3S11fKQ
   97+7+d0Sy9R0IjRzRtQtxidEdjdNHzM9pPayhwRGVisRhtEnrtJ9beTuq
   5Kg5rUEuoAZgasxVwMep24FVyhPqUTzbLws1XQm4O5sjkvfbzPuERmAdV
   JOu5hgtBjs9/OcaN0qvkirPN47Xo9eV8b8RWdC0uVDT2ZBRvcANq9fdRM
   5z+uY5crKnyPxb+yCWEGnrLo7w02h8UHf4kl9E5G0K45pZJO/UkKW5/be
   NalCT5nt60VtogyCAeOSmjbJbK1i0ix0m1Wz9bXw+RBdEnu56QpjAZ6gj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="360736630"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="360736630"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 13:51:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="985909959"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="985909959"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 30 Aug 2023 13:51:36 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 13:51:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 13:51:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 13:51:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 13:51:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGfcGd3+cvk+i55O2SgkzTxGgyYu1Rfm7TUiGiMknSOpIpvZpGJdlqEktkLfAkMmLO9mvJQFHt8Kd/Mgn0T8PICPq+uW6YBpELmuLa3vxxwxaoGwTlTwj9h5+0Cqt5DEPnwYHmKhL8U+/3z7cNMYcwY/IrDGzFc8U3QkPEzrkxjuRSjXLRFKpFjWBRcQGEX7nqgKKHlPYF2kpusVHSWWS26ZQ0PznQx1ldu9m31aQ5deei/nDVFn4jk0HA8HmnVc9fTW36iKJ1IeBqbIxLaFW5wqDSVaEB4jxxbBPTmsF4HWYJxFHAAYf3qw02qDPq344Mg85hxBbO6mciGsWfsSIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEaMcw+XCFZufRb7cN0KfxnNeZei4w9TJev7cG9NGSU=;
 b=HBZ7EFow/miSUWjG8XY30cDPROWYxWe6Ff28TbvsrBWaobdpsRAR18bxt9XW4BOrZc330krj2lVfCrirYWT0dWh671y5ZggqUeVB+4Mq5J7H1M9hidtGHRpC6drSpmBrMWPVV6jZ4LQzbiOinuPHT0rznfDczDtXmwDWw2aSBzhs1xgwn4XULsvwkdcSn+lUrYTefbgIovm2CPHQ/JSDbhl/Vv8K4+c7I42Vs4KfsYEcPxmDNa6saYxDm0KE9vQoSMZbVK17rmR8OYg8TbNvuDLIoQdte/B8+9EdA8VEBI4qH6YT1GwSuhep1tzxc55cZtB8DlzqmvHuKjHM3MSdnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7049.namprd11.prod.outlook.com (2603:10b6:510:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Wed, 30 Aug
 2023 20:51:32 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 20:51:32 +0000
Message-ID: <16eccb6b-a968-c6ee-dfb3-221ed8ec023c@intel.com>
Date:   Wed, 30 Aug 2023 13:51:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v2 2/2] selftests/resctrl: Move run_benchmark() to a more
 fitting file
Content-Language: en-US
To:     "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <shuah@kernel.org>, <fenghua.yu@intel.com>
CC:     <ilpo.jarvinen@linux.intel.com>
References: <cover.1693213468.git.maciej.wieczor-retman@intel.com>
 <e527be8b871212823ff83f3800b6eecc2a75e455.1693213468.git.maciej.wieczor-retman@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <e527be8b871212823ff83f3800b6eecc2a75e455.1693213468.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0223.namprd03.prod.outlook.com
 (2603:10b6:303:b9::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: 18ad7c94-3176-4d15-20cb-08dba99ae427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4C9aPO4972RE/NCzT8gB2g1R8WAmFNQ19z22k8vDTK97WgqQ1BCaRvrAIX2q/buqSKtgUcfan/BdEqgckGQCYLrdavwietod+7g3WrlE8R8WaRf/kd6Yd3RkmgEzNbW8DTN/D4O7X3ITYypFyqlkav/D9j6kr1BoWvPiMiArknTNiqaWpnaLjUYk9rK9aIwERAjsasDIU+sIVcSRfWN4Vajw2Gmbx62JVLMgxBof/yT/U9rfWciofFCc4W46jOBx/8/YHWgbFh9pvXaRNnGvXbTL2YElKZj0ARG5ufD59QAJ/b0DT4UyWBqytxWIeRZ3t3Oy6qTrwOghqamnwDijUS6cPVPyXvytXFG8tpEsSGksLs+A2FwAk2fysVuKlolW/irFAc6oBoSLLUvU/VYPlkoIVoqI3RyrgrKKcDAKDeweQnVUqf0G4mvabqoTpgPZOKeZyxd01pLHGLm2yFNFH8fxObNH/v2FhWNZbYmczktRLAglORu78fcwoyQUu66xAFd/Pz86iexgi2snO+1m1OhstplsBH3nRTfJf76cYEd7dqTVxBLxiPgtF+jBb2GOHEX3qs/VQoievpI0jAsumBisXAAho3ruzuGXFEvP88xv20zdXD6N6lfvqlyvzGNW0oeEGQirZ2U9LprmH+nn2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199024)(1800799009)(186009)(6512007)(38100700002)(316002)(66899024)(41300700001)(6636002)(82960400001)(4326008)(2906002)(2616005)(31696002)(86362001)(36756003)(44832011)(8676002)(5660300002)(83380400001)(26005)(8936002)(6666004)(66476007)(6486002)(66946007)(66556008)(6506007)(53546011)(478600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z09aaHlObm5rWkRrSEhaTEpwVVN2aWVlWndUR3ZMcWM4SmRmM3FnRlkxVWlE?=
 =?utf-8?B?MVpocFFySm1XUDFUdjQ0bjV0ZXEwdkZrODhEbUliMVFLV3lqYVVjeW1FRVJF?=
 =?utf-8?B?WjVDYXpSRWYyVkVQYy9UOW9rMkY2UGRrTEl5YmxXbGFkQzNoZzJiRTJMVFJ1?=
 =?utf-8?B?U3JtekVzcHhnWVp1NFhmc2FrU09ML2JLL3R5Nmpja01rcWZTK3ZXa0p1NTFv?=
 =?utf-8?B?ZXNobTNhNVZaK0VtaHNYV0lSRzJpN21YbEtEUE5OVXJCY05lNDl1SWcrMjRE?=
 =?utf-8?B?dStSQ2EyS0Z1QmRpTjVWcmcwcURNUE10d05VckhoOFJSTGJkRXV1cExFZGFV?=
 =?utf-8?B?bzhZL1EweWNjN29zUUxVejMvekdCaGI5RE5Fc1J1SXdVVXpjaVJqRzRLYmZ1?=
 =?utf-8?B?dHV1YnJqTU9SUUlFZkR3YlVaRFF6SCtEL2lvcUtjTVBMeks5aHR5WU1vVlZM?=
 =?utf-8?B?QWJYVmMwZTRGT3VqajRWR2R1aWl4cmgyRERqamZQK3JQUlZGK3RBVE9pNWJt?=
 =?utf-8?B?WTlzMzU0cGZGQlRWbzFjQ1V2RHc4TEVZN1NOUis3T1JweTVCYnh6b2FsVWxL?=
 =?utf-8?B?Ty93Tm9TLy9UMHB4WGVNYUg1ZlY5bzJXT2V1OTk3ak5lK2w3WGFRT0dXVkNT?=
 =?utf-8?B?N2FvamNJcC9zRzhyWW1MTDR1MStDd2tsQmp1cnlGU1pRTzZseS9BeDRiaHRz?=
 =?utf-8?B?a1pXcXIzWXR2VGNna0N6UGVTRmg0ME56RkxNNUNhTHZrdGxIOEw4Q3NVNTlo?=
 =?utf-8?B?UFZid1pzMVBhRmhPa2dVdENDSUhKSk5lanJHZ1M5Znh4bmZsUld4cVFvQ2xu?=
 =?utf-8?B?U2d3TlZEV3YzbDNzQnJsRUV6b1F6RzdlTkg5bFZYM0d2TnBqV0FvTUQ2MnZO?=
 =?utf-8?B?ak9NYXhBYVlpbnQxTjZPaWV1UmxiQUpUTFVCUDFiZG1oeVBVWHhUdGNYOEJ0?=
 =?utf-8?B?V2hBTTZ5SXI3WUxUTCtYc3FkSXBRN2ZTOUFUOXFhNWc0eGFBNlkwd3ZKdlJs?=
 =?utf-8?B?WUxUM0JhczE5YkxFbDdlZ2NndktmRGswWHFCS1MvN2xQQnExNnlrRTk2NzJW?=
 =?utf-8?B?K3Z6RGMraGwwTXEvakdLMTV6Q1dWVUU0dUN0TStyZnpOSEVpSUZwMTR1UzhI?=
 =?utf-8?B?Z1dLUUFyVGY3MUxDUUZkR3MzSVNKYVdWZXNuanBiVXlMc2M2ZTJsQ1NJQ0RM?=
 =?utf-8?B?TjVuTmoxeGVsMVh4QkZTa1FOYmpvREIrNkVTZ1ppc2tLQjczWU94dFdESEVI?=
 =?utf-8?B?aDNQQ0I4RzBWeStuZlFjcGJsV3NheUs1TkhmdFdNQzRWM3RnMW53SkpFaFlj?=
 =?utf-8?B?RTgwemJ6eEtmUGtCQmNTUGJWcDZlQ3dHT2cxVVZOa3dPUlE5N0kwMEhsWjF6?=
 =?utf-8?B?dmw1K1U1dStHV0NIaTAxamxuV0psUE9jcjd3SWkrQUM5OFBhT1I4NHJURkpC?=
 =?utf-8?B?ek1RbEloRitNQWF6QXZKbjRTSndxRzd1VVdkOEpBTkRxZ0h4RUxHcmYrNDdV?=
 =?utf-8?B?RXhxNGJoYmZ2NExxb0NjOFdUaUpTMVJxdFBhWVdmTVlxRUZRdS9xdVcwaUtM?=
 =?utf-8?B?dkppcVpaUVBoVGEzeE1ld3orTTB4VGhvcGhyMy9XZTA0d01kWlVJT1BrVGtP?=
 =?utf-8?B?NWpGMlZBUmV4MDFZSmFCVjk0ck5POExFTHkwUXo3NFlRVE9CRVRzWnR5anYv?=
 =?utf-8?B?VUNVSG90bjNzOGV5NytyM0RDY2NQWTVVZmd1d2Fsb1NERHZIK0NTSGpMS3Bm?=
 =?utf-8?B?emxUYUdyZjhvNmsyREt0WVZFME45NkJBeS9hY2paWFVlQzJHa2Q3a2JHOW9x?=
 =?utf-8?B?cXFFRWxPaHArdHBnZnc2cm5GU1Z5bTFvRW5NU0FPV1FwMGNzMDJLcm50WnJx?=
 =?utf-8?B?NEpBV0VMYVByWURDVEFJbUg0enp3eFJ0REN1U2g1Q2MzbERDUGsvZkhwZW5l?=
 =?utf-8?B?SnVUNkNVOUpRaDkrZVFvcGlKd1hRVlBpOCswcVB0bVdHK3BPQXQxdEhoU1NP?=
 =?utf-8?B?Zk5hVzY5bTdFOHRVUDAzeTQwU3VaOTZIeHNDWE1FeXNlZnZJR0c3WVZ3VlBr?=
 =?utf-8?B?U25Xa0lkTm8zeTNtODFHUnlIUDN5RjNmU0l2N29EOU1XOHNZQjUrK0dDYVVU?=
 =?utf-8?B?SFlXbWZKblozN0dYdmt5eWo2YkVGcXJFUjdad3cxcG5mN09YWU1NN2hKS1pV?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ad7c94-3176-4d15-20cb-08dba99ae427
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 20:51:32.2411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 102xdc5Wz8AAdM4t4EFCqyJc7KYrqLtpD1jKRlDYC+A2Vd9nhEYW9MLp/5hRQ2on0hlMUoh9fVoIpyfbXoTWCx0LzconKHJJJyiAZzE9+HQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7049
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Maciej,

On 8/28/2023 2:56 AM, Wieczor-Retman, Maciej wrote:
> Resctrlfs.c file contains mostly functions that interact in some way
> with resctrl FS entries while functions inside resctrl_val.c deal with
> measurements and benchmarking.
> 
> Run_benchmark() function is located in resctrlfs.c file even though it's
> purpose is not interacting with the resctrl FS but to execute cache
> checking logic.

It looks like your editor may be automatically capitalize first words
of sentences like Resctrlfs.c and Run_benchmark() above.
Also please note that when using () to indicate a function it is not
necessary to say it is a function. For example above can just be:
"run_benchmark() is located ..." ... similarly you can just say
"resctrlfs.c contains ...".

> 
> Move run_benchmark() to resctrl_val.c just before resctrl_val() function
> that makes use of run_benchmark().
> 
> Remove return comment from kernel-doc since the function is type void.
> 
> Changelog v2:
> - Add dots at the end of patch msg sentences.
> - Remove "Return: void" from run_benchmark() kernel-doc comment.
> 

same comment about changelog.

> Signed-off-by: Wieczor-Retman, Maciej <maciej.wieczor-retman@intel.com>
> ---
>  tools/testing/selftests/resctrl/resctrl_val.c | 50 ++++++++++++++++++
>  tools/testing/selftests/resctrl/resctrlfs.c   | 52 -------------------
>  2 files changed, 50 insertions(+), 52 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index f0f6c5f6e98b..5c8dc0a7bab9 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -621,6 +621,56 @@ measure_vals(struct resctrl_val_param *param, unsigned long *bw_resc_start)
>  	return 0;
>  }
>  
> +/*
> + * run_benchmark - Run a specified benchmark or fill_buf (default benchmark)
> + *		   in specified signal. Direct benchmark stdio to /dev/null.
> + * @signum:	signal number
> + * @info:	signal info
> + * @ucontext:	user context in signal handling
> + */
> +void run_benchmark(int signum, siginfo_t *info, void *ucontext)

Can run_benchmark() now be made static and its declaration removed from
the header file?

Reinette
