Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3086EB669
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Apr 2023 02:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbjDVAVG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 20:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbjDVAVF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 20:21:05 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696452D4C;
        Fri, 21 Apr 2023 17:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682122863; x=1713658863;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4LmqEJiL0rI5FGpKEoZTGb0a8L7GaXzF5VtvFCAvA9g=;
  b=BHhmFO7zkeONS3ddBNHiRWtOEFH+xddEMNiIc9ECjrRiyRGjQKHnpHb3
   z+14Mj1hHW6dFAzIOAOqMPOwBSJmrwwE8eLsiCNhHoDWIjfzjJMJcEoX8
   /US+OFL2XS5r3r/lWhvEHXpY5mhw4sllRdWEwAIbP1Qlr4GYHwdXpyXIa
   5wvr8mOkTavwnGCPFp5E+gCRJxKjVlgI3uW5ck50hQko9YD6g+9IAfsIS
   /XMFJ/4nG0fBJ0VGPWii4k4zrMIKavjSNYOTZzuLUAZ+B16OcesFz4ZnB
   iN5HRhZo2ADWuS7byf3J1rnRkEiYmJkCSAdj9TKk748bLH4+HhneSB+4R
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="346129121"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="346129121"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 17:21:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="722938246"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="722938246"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 21 Apr 2023 17:21:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 17:21:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 21 Apr 2023 17:21:02 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 21 Apr 2023 17:21:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrqaB/QLolAdYbeqMRAtrtgFG91MCwbJj4X+E3r1xgzjF2XXY6mKvicdE1LCtxdRLmEezyAkqxSwSMJtHe2uKRjivyVCGBEH20bf+lSFx2VdkTGZbxlPKNHDYXexbSydxgOC6sOeN7ScGM8CS2G8BNPklQiaeMsIWht7pOA1unriAsrQ/ilG75svRPG+fj09HfkJUnNQ1V6UAft4lkcNaKwGpDiBBfQDOVSKe8FRRZ8Tn2zT7IoBkJtRM7rOXcU+gBnmTkfhHSlN8OhujgPJog4PuGzmV/IrFmSKGUIIbXo3QFLY6isLyGTiGxc0ffcpdfODsK1tS//d23Mr4qdS4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JGgafEw3LoWiTeEe78K5cxcfCbmipvvbBTAOMHFDvo=;
 b=XQERgxam4yT1KokcLTFS4MpbLKWbmhB/tVpdFZf9qjcO4y9XMB956SvC7iC0AMv6gYXmhhWT9M70M2oURugYUPg+gXiAc6/o6LExQnx2bzMPQpqhYEoMqfPHj/1bTp0So4Ch2WQGZtlSD9UZNelXemj4KFq34p6eENCv7UBVYGv1KNa11uRMZ6BULcSd7tSl+Tsecdi1y6JS7w8DkyNuO2x/YydoEmnNv80kkP6ro6vamYAPv731LDH/B/kxnnl8rbcwv4GyItStLkab48+XIxAc8PDadSG5d3wb/iyFtV7QUdFwmCe0mBLk9mlGxHMf+7brHeo7HZ1cr6K+1i8D6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Sat, 22 Apr
 2023 00:21:00 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6%4]) with mapi id 15.20.6319.022; Sat, 22 Apr 2023
 00:21:00 +0000
Message-ID: <7aad2648-6adb-ebfc-a7b7-db959c2e85c4@intel.com>
Date:   Fri, 21 Apr 2023 17:20:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 20/24] selftests/resctrl: Move CAT/CMT test global vars
 to func they are used
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Shuah Khan" <shuah@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
 <20230418114506.46788-21-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230418114506.46788-21-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ2PR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:a03:505::20) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MN0PR11MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: 099ebca4-571e-494c-ce30-08db42c77348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7qPQowsMcMcTJ/dt6RU/jY9y3zWCGkCLFu8ZQGv4Niowkn/YX24B2bX56Ktet6ZNX4UuXXp2q52Lbx3V8S+SMC/+OymxR4pzvCjQ1MCHT09eWKEaGeRaKieu7Z5IrswdMrwfI/oV7/fc0IDDecrbwRIyPfpl5sTIIpehaLaWri582e7xxiv467MB/xWMhvvNHlcr7LWa1hwbKwzCpSkK0TnV/kYQQqJhWcYA8ekluwPYM12faipLdwqIat+lB0R+Hze+QIo1FzI1hM57X8o/4SzWooM+7GwnushUEmCD6fh1olWqYkYSclxFgjj+LkQ17II2F0e+I7B6x7xcssC5WhV1hH8pl4YTfYpdO/SY8AG8S47X2PXc5DIyYGHP/2+74Yee/o3qzvwH+sU0cC6izVWY/4gbNw3UYqmELKwndllAgm5giVcUVHqOyFzcncsz20S/5AmzW3WJth9eecgFheTB0FMjPq410th8nwjQXuFCYWR6Telk8iUnELvOM0I5ykXCAt2tbv/5gqXz2T4+TNP6Ta5E97kXek7x4Nwhow9VHGtN46KnTPgwZkEdvgefv87X0RO4Y4sGOGhGPowTitOzNenBwwDwvYyq9+rvSgcuSwXGrYnF9iB/4W9v3UB/vyzN8oJmAbr9r1OpSFvICQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199021)(36756003)(44832011)(5660300002)(2906002)(41300700001)(82960400001)(8936002)(8676002)(38100700002)(86362001)(31696002)(6486002)(6666004)(53546011)(6506007)(26005)(6512007)(2616005)(478600001)(83380400001)(31686004)(186003)(66946007)(66556008)(66476007)(4326008)(110136005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHBnd2F5U20vUXZxdGdGbnVoY3dDSUxWQUl3NjRFMUc4a1JQRUlOejV2S0Fh?=
 =?utf-8?B?bTJWMzhlMldqOW9lVmtxNWdMTkFValY5UFMzQWh4dkIyYTEvUG1yUUROcFlp?=
 =?utf-8?B?WVo1Y2l3REozcHRuV3M1aVU3T2dYUUVXL283U05ucXV4MlI1WjNHQzdKMk5X?=
 =?utf-8?B?Q0FiVDlEaXJZMGd2cEUybHA5TUFSWVJSRWpoc0NVQzJCZTJ0R0dZVmRGMXdD?=
 =?utf-8?B?NzRnaVNSTTBROGlQOWlyQTI1U0dTRDNVNUN3aTJTYWliRC9jQXRjNW01TzJo?=
 =?utf-8?B?OUR4UU5QemVEdmhyRURUREZaVFVmeHd4SzJyUnAxTjlaczV6VFJ6aVFURzVZ?=
 =?utf-8?B?ajdDMVRnd08zamZHb3dYRm9wWUUzU3RsNktKTXB6UGlZY0tzQVNCeUlpUDhm?=
 =?utf-8?B?amZnWUxvYTZ1L1ZtZEpiTXh6S3VGTlRPTWpuMnFDeC83RHV4dWM2bUU3cnRw?=
 =?utf-8?B?aHI4cjZWdjNFZkdESExYSWJDT2JGU1h2L2J6VDNqQ1ZacUl0MEF5NDcrU3JI?=
 =?utf-8?B?L0gwdnl1cG12Y0pBdmxNOXFLMUIySmxUeC9MT2ZKYnVnbStrRTdDeUhSZ0xC?=
 =?utf-8?B?RjVVNk9qVnBwREdnbUVzUXFybkRJOEpaMTh0MVRlL2NpQWtSeHhOZmVIOFhs?=
 =?utf-8?B?VmFNeG04TVlacW56N3RKenpaYmFpWXdjOFpDaVRuWS9FWUxvQU1zbEd3WlRG?=
 =?utf-8?B?cjVHcnkxSjBsZWo1aU5jS0tvSUxsdUtVRjBQMGxlTHFTbDhxVFU5akwwaHNO?=
 =?utf-8?B?dytWYkxGV1BaTTdtYUNQdTg5Um1YUFZaUnRzRGR3ZnVIVkVQbUp0dHhmeTNP?=
 =?utf-8?B?MzlJWmhjeENJS0o2YldHTVFySlJOUXVUb3I1cFA0eC91Wk40VHFaT1k1N2JR?=
 =?utf-8?B?ZmJvYjVwdnpDd0JtSUlia1czSkwxaDRTNHgrWDVVWGFVNk1DS1FDVHV1ZGZ1?=
 =?utf-8?B?OTRsRFhxS3V4bDUwZStWUW9MQkJxdHBQMmU0azVmYmNNdTFTUDUyL0F1eWdT?=
 =?utf-8?B?SXIyYVdnakFFYWJjUVBDZWtLRnRpcmt1UGhLMWZJa3BtdE4zUFgydG1XRUpn?=
 =?utf-8?B?NTVOY0kzR3RPSUVBUlJuZHR3eXBTQXd6YVNPQkMzZ1lzSytxYUZ6Qlp1V0Fy?=
 =?utf-8?B?UGxjRmNhMVFreEdkS3lRQSs5bDdqYWpMbkpzRUZYclZCaG1UNG0wL3ZFTXUv?=
 =?utf-8?B?MytkUkJRbVo3QkswQlVYb3RqV2dyRktSQi9rNnRXOUtML1A5bis5eWNBdm15?=
 =?utf-8?B?c1hrNTAwWFBUK0VPdGRkakhQM0dNbFF6UExkNjNWSEhLRnAybVBnVnhZZm5r?=
 =?utf-8?B?UEkrdkE2TEtkUWt3TDcyYXZJcVFFT0JNR2lldzZUVWpqb3ZzejFVWlFQUnRI?=
 =?utf-8?B?eUFINmFQVEZKYmNRTlRYYTJJd2M0YTNOQzhpS282NkJWL3FBallpWndKbkNz?=
 =?utf-8?B?RldySmlxODdPU09vOUFsSFhockNnTGlSajZNSmJvMDJXYWFxbEZZQnQ2VUlZ?=
 =?utf-8?B?RGNlbHBvb2N5aTBXSlBiQUhXb1pjQmZ4ZTV2QnBWWHdHMTIzbk0yU3lyeEZS?=
 =?utf-8?B?VjMxYWNYbDBURkJOOFBSdFV6VEdVZHppakpzaWJ2QjFLSVhLS2o2WEVFVnlY?=
 =?utf-8?B?NTBGNVVzSnA4UXVUYkQxeVdSd0d2amxkWGdWa2g1OE1tNi9haVNwSGVnWmo4?=
 =?utf-8?B?OEpGbFRyejVIU3oxb0psblhQRzZqQWFxRUt3Q0hlY0FMRlVaTTJRSWhhVnQv?=
 =?utf-8?B?cmRIc0phbG9NVWlJUzl6bzM0cWxzaHFxRDRKNkg1UXZSRzRPTllRdFdHRS9y?=
 =?utf-8?B?YVNlRnhYQWlLVjBRaWlZZTRMNW4vY3ErQm9GWk5FejRrRHBSNjFBWFh3TG9M?=
 =?utf-8?B?dzVTN2UveXIyZnc3aFBJNklreVZJVGdkQ2UzNm1lVjR0QjBYV2E0a3VlSlVT?=
 =?utf-8?B?K0c5T05vMUJ0RTkrc1JybjI0RHAxTW1NdDBaRll3YVJ6QzE1Y3dnUW9PemEx?=
 =?utf-8?B?anhnUEhYb3hJUG9VU3lxR3NvdUVWUEErNVpMUVRJR1V1WHRTNGFRUkd3RmlS?=
 =?utf-8?B?a3JGU0xzN0FXczZCV3I0b29Ha25acWxqR00rMmd3MDJ6WkQ0a004NWNrcnpW?=
 =?utf-8?B?VE5OWWlpTUdOMVpzRGNVNEh4bjA4a2NKeFlZbUR5VWNQVWQ1ZU5Bb1hjbEE5?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 099ebca4-571e-494c-ce30-08db42c77348
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 00:21:00.5336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sn0BJB1mJPxT6/QZZv0kFifG55ZSZi+Hvj5K+hNbA05aw41ki8XTt6j6yy9d9LzTydz3hOx0SErgcm1l5l2kxbeINYqvSDcBwEFOLke8G6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6304
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 4/18/2023 4:45 AM, Ilpo Järvinen wrote:
> CAT and CMT tests have count_of_bits, long_mask, and cache_size global
> variables that can be moved into the sole using function.
> 
> Make the global variables local variables of the relevant function to
> scope them better.
> 

Could you please move this patch earlier, before usage of long_mask in
earlier patch.

> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  tools/testing/selftests/resctrl/cat_test.c | 7 +++----
>  tools/testing/selftests/resctrl/cmt_test.c | 7 +++----
>  2 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index ae21e656cf6e..ef3ba22bdde5 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -17,10 +17,6 @@
>  #define MAX_DIFF_PERCENT	4
>  #define MAX_DIFF		1000000
>  
> -static int count_of_bits;
> -static unsigned long long_mask;
> -static unsigned long cache_size;
> -
>  /*
>   * Change schemata. Write schemata to specified
>   * con_mon grp, mon_grp in resctrl FS.
> @@ -95,6 +91,9 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  {
>  	unsigned long l_mask, l_mask_1;
>  	int ret, pipefd[2], sibling_cpu_no;
> +	unsigned long cache_size;
> +	unsigned long long_mask;
> +	int count_of_bits;
>  	char pipe_message;
>  
>  	cache_size = 0;

Seems like this initialization can be moved to the definition?

> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
> index 087378a775ee..6adee08661e7 100644
> --- a/tools/testing/selftests/resctrl/cmt_test.c
> +++ b/tools/testing/selftests/resctrl/cmt_test.c
> @@ -16,10 +16,6 @@
>  #define MAX_DIFF		2000000
>  #define MAX_DIFF_PERCENT	15
>  
> -static int count_of_bits;
> -static unsigned long long_mask;
> -static unsigned long cache_size;
> -
>  static int cmt_setup(struct resctrl_val_param *p)
>  {
>  	/* Run NUM_OF_RUNS times */
> @@ -74,6 +70,9 @@ void cmt_test_cleanup(void)
>  
>  int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
>  {
> +	unsigned long cache_size;
> +	unsigned long long_mask;
> +	int count_of_bits;
>  	int ret;
>  
>  	cache_size = 0;

Same here.

Reinette
