Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697A578F488
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 23:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjHaVZs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Aug 2023 17:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjHaVZr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Aug 2023 17:25:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2F6B8;
        Thu, 31 Aug 2023 14:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693517144; x=1725053144;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R0Yba213GKHVdVcAlLQyzG88s0dEsr9T7/e9ZB/Wi/4=;
  b=QhI/DigjH/umIKzl4VUIrSYtucOQajt+VQ5WIHjgr5kfMmjUZ936qtvP
   UZ4kLakcKKFVwZpDShUdgcd2YZXg9DPnie8NnFCNdLXAVyKJu6SL7ruIy
   jX2NkMmjHwL8HUtx+AEQ15J+/s80pWcYv6KSyFZ2yxtByiRCRZmeatm7e
   G5TRp436hx48FRFMWETYV4tmDCqeC3dKOuhQeTB2YceziLjfuuMVPLWRd
   D6tfq85ITa8MZdYjLuasgDOe6LSzPq1rMIRpi8BwkPMV3EmBmbXcS4Jmv
   BiuhErW/h8Z5hC230sR2mBvKSWNHeG+dknXTcOwlrt5HHvDucDmqPSUxJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="378804118"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="378804118"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 14:25:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="768951043"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="768951043"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 14:25:14 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 14:25:14 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 14:25:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 14:25:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 14:25:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zr+jfJI9weEC8i6D5kpfCdjOQTs/VMsspbRazPXt+KaAeE2j7K9dejweq7eKwXzlc/nezvZGKH/3r2dQWG85KUpDBu6qLmYgGhLwjpCOL0shjqlDamzZf5gYZyxAWkTMIu74ZfawJ+wn14APveXOjWR2f2cjrvNFkkTEh6GiFwLugK+7RRihyfKB8H+RWNTgEVzQGApSwjyHWPBCCEjHBTnw0cxxvy3exT1B7QPkAB1T2SRf7rQOGwG3+cMa+k8wraXVwPlDQ+Vs2fMgaQC7ekT55u44j0GptP3qIGnCgFgGA4u8W+U7aYBwj53H4FumDDX8dXjSkZSESWp838M87A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biYfi8j7VrvZRM7zLTzv2iDzK5Rae6sj/SWxBAEG/3c=;
 b=USCvBiVw8xwat8jdtixxNdzR+4fiFptWIQL3JPkGPEqF0jOv6xTAypdcPYqFGbAK8WPNOA/Qu7eDRj57XZhpdLpTa5K7Ts9rViRBMkQVviSNRx33/jxHA1Uw2QH5UIq4dZSNxbdwOr1KR1HzSJg9zKmF1B4q7OpzRWz3lTR+D03FZHmX/KJ1qPi/4COU7aHPrEYvSrsglio1x79H8RfgDimrjlhqATkXh6oebKokYfq8Rrx2Loz7diia4xCJEsh/zS48dgPyCZRGQwgMhQtyK6dABrvEgm4Wmr1996StdvjxrWvmxPQayH7sGY02OKG4tOEsg9Wy2wCqjXZpaNOnoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 21:25:06 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 21:25:06 +0000
Message-ID: <da9c1d88-73ea-b169-909c-e6e59e87c474@intel.com>
Date:   Thu, 31 Aug 2023 14:25:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v4 1/8] selftests/resctrl: Ensure the benchmark commands
 fits to its array
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230831110843.26719-1-ilpo.jarvinen@linux.intel.com>
 <20230831110843.26719-2-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230831110843.26719-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0150.namprd04.prod.outlook.com
 (2603:10b6:303:84::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB6744:EE_
X-MS-Office365-Filtering-Correlation-Id: 609e8e30-08af-41ba-80eb-08dbaa68bed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8evLRfeE9UpjZcxUybWhCztbsK4RmixQHUaFPbTQvE+Z8Lh9+kZDq7dDWPLTcX28P7cU9E0RWsYRYNd+oF5na4R6mAwisinezeZuCOHQZEaBicbOkVoIj2Z7uefcV+ifk+Z7ny1FV8gH7pWTDVVQ2ajvphbb/aTnQOHb237wuzLXnDOwnDBA2WHJoTLh3rSp0B0vmoCbnbNmaSdkDbVX7kWBU5/CXaeOtpKd3Z0Gu3Fc8IY3K6LGE/MiqWCe6tM+MgwbyUdNP3wnXVRIubCVdthUvjdKZ0HhBMKL5k5TYYpXmor3eR2ynO/bGs9bx8TASXRsr5V9qtcRvvszPmlg+58f6bV9kYIDuI7OyFdXWhK9uMm1Cead0Hf4L/b1Y86x9NJeOsbqndYtDdJmoD41lzYo4hnvSyCm6Hs8rfRyP3MaA4gSKgumqVdxTirrMYrTnMHyID7Qg5fD1lqGbzhWPEN+VW1dmFDT4ryPoZ9vO8bWVH00pX4lm3fLcUZXiCFCRzRoQtndva8swOxzFM0d9XLo5a3ro1uOeE44e8t4uVcDRy+ewRb9jMqEWd8lZo4GzEAhYZEPCjbn1HovmARgLfCj52QPizH3sWY0uAfVhpI4GKW6nerKSBXf+z9EnVebHfFxMerT+xnVRziDmA3VXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199024)(1800799009)(186009)(6666004)(2906002)(5660300002)(86362001)(53546011)(316002)(82960400001)(478600001)(31696002)(2616005)(4326008)(8676002)(31686004)(6506007)(6486002)(44832011)(6512007)(8936002)(26005)(38100700002)(66574015)(41300700001)(36756003)(66946007)(66556008)(66476007)(110136005)(83380400001)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZitCUm5DY2lqVFArMjFmT2FLaEpuWG10cnoyTE00WEhYK3NnL01lWXY3b1FJ?=
 =?utf-8?B?WnJCQzdnMTZnNkVHb1RKNEJiUWh4R3cxMVAzWlNRU0YwOGtFQ29Gb1JCTkd5?=
 =?utf-8?B?cGd2NVRUdXVSYkNyNFg5R2hiUzlaSXJqTEptalQ2UGVXZWxBbFJkTkNrci94?=
 =?utf-8?B?NkljT0lhNDhzTnNCK21wbi9TQXRnWDkxaHRGMnJpVUtFSHF2VFZHZmVDOCtx?=
 =?utf-8?B?aXpoRU1oUldMYlFPbExXcWhOa2tSVFB5Uzc0Z3hEVW41Q3dLVEhpNlNWcS93?=
 =?utf-8?B?NHJrZWZjdFVTR0RnU2FhaW1IeTZoMy8rZG4wbmlFa1RONXBEN05KUENyQktG?=
 =?utf-8?B?OFhCSkkyU2NyeWtuWmRqRjcyWGJxK2RjUzVqRXFGSGRzWkZDTERZRWVRSUkw?=
 =?utf-8?B?RW52L3VFRk0vYjlUemFQb3VYeU05c1FxMnNCSVdmLzRkS0VZNFM0K0Z6N0tR?=
 =?utf-8?B?MnF4bStUYVFOTXRQNE5TVjFGemFaM0Rmd2lqVGxSODFvMnJqbUNCNjNyQXg2?=
 =?utf-8?B?SWpjRnYyeHJWaC9TdkJIWlQ4ckNHY2FVU0ZZVmlHN1ZGblBTTnZUaTB3bHhL?=
 =?utf-8?B?S3dMb1BiQzRNS1BacWExcWVycnRJdnZxY2tJc1hpeWpSN0lxcytFdTAwSXdn?=
 =?utf-8?B?TnAvc212cW0vUzc5VU52SFVmNE84YzQxRjRra1pXQ3VVR1BGdHI0Rzg2UG1D?=
 =?utf-8?B?bW81TndNQXNXd3ZMWW5ESmFOT2kwR2Q4elhZbTJWV1VPTG1PdnQzelp5QkZt?=
 =?utf-8?B?SEdHclU3dGhvMkZHYTNwcjdWTG9mTVk1aFdxREl2Uzk2bGpJc1VwYlFxL2hS?=
 =?utf-8?B?WWtTdlFiOEJaQW5JOWQ0MVJ1TnVEbWMyVC9IWmpmQUtwelY4bUJwQlRMeGVG?=
 =?utf-8?B?d1lWME5Xb3g5T0c1UWF1TlhNTUR2ZjFPUzJxeDE4dEJ6SURwOHhIaDIxWjk2?=
 =?utf-8?B?VG5ZL3NOMHJ6L1lra0M2YWtJL2Y1WlpEdjJWcitpUUpWOUsycmZKTXdrRHN6?=
 =?utf-8?B?aXFTUC8yVDNKc0h2QjgvM2RUNllsbGxocytRS05ySjlUei84WU5MWXNqUkNJ?=
 =?utf-8?B?V1RQdWlMOUpZN0x1cEUyQ0ZHYlFQRU9wVmk5UFlSVU5yekplOVFWekdmTVdh?=
 =?utf-8?B?dEloUFk4Q3Bhemhnb1BhUnk5c3BYWnF1UXpmdks2dnI2d0RhK1hjdFVzUlls?=
 =?utf-8?B?Nyt4Nk95VGpxcmg1Q3IraXdjd3Z5QmtlR1F1eEk4alJXbHhNcWt0d2dXS28v?=
 =?utf-8?B?L0M3ckJObVh6WjBvTkRVa3VQQ0xDV2hPbjdCR1RrNzB4NGZrVHRLKy96R1pa?=
 =?utf-8?B?a0ZkMGhmNFozRit3OUtrekNiSUZ3eStvRnUybU10YTgzTFVoZ3prMHJSbWZw?=
 =?utf-8?B?M3VlcTVMS1NpelU3aGJUaHU2QWFJQ3JhR3I1M3pqRHBMOWI2dmpydXNxMXdH?=
 =?utf-8?B?aHBKTEw3c1lIKzcvM3dvUXJqK0ZuWXJUNTkxTlJpQlpGSXk0a29qcHJ1RmNo?=
 =?utf-8?B?eW50dzNJU0lybGx5ekdsOWF2WERMQzh5ZUNJekNZRDA0b3JjTXBSZE1tdmJw?=
 =?utf-8?B?eEVkMnlKSWd6RmlEbzlLUGVmYUNpeGdtdmpqM0lUUmFoeElDc05aWEVvOHlL?=
 =?utf-8?B?NUdYN0xRSjZwN0JHeWJkTFMzSVIrS09WTjBkZkt5VDFrSjhaV3BlK090ejlE?=
 =?utf-8?B?NFlVTmNEaUZuOEUxdEsrNVpyS2laY3pMWW1RcFlEQmcxdjRDZEZKSWhPVXFJ?=
 =?utf-8?B?Zk14eC81S3pKRUU3UTJLeXl3dXI3Q01xWDV6bmRxZzdhME1GSEtHd29UVFor?=
 =?utf-8?B?QWhmcW5EZzc4dlZDeG9qbUhJRDJ4ajIyNW54WHRGZDJraFhaUUpCUzBmeDZR?=
 =?utf-8?B?cFQ2ZEVoOStUYUpIY3BhWUlnQWpCTVFmcklZWURZRDdoMzJ0SDdVV1RvdUhm?=
 =?utf-8?B?RGdmWjJTeGNnZFVHb0NmOTNiLzR1NmltQkRZa1NnbXdjUThlbld0SHFMVlp2?=
 =?utf-8?B?ZGpMcFZWTkVwN0J1SE8vb2M2blZVSkYyQUtrcENUQ0toQmJiOWx3R2tLdWZZ?=
 =?utf-8?B?SmpXTkgrbGxmQXpJazFobU9xQTdNenlZQno1Q3dEQmxaQytEOWpIS0RmeVJP?=
 =?utf-8?B?R2pwNUo0eXRtaWpzdndpZlZnUEtrYzFRZWgvKzB1Q0xyaUl1UU4rbURYWW8w?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 609e8e30-08af-41ba-80eb-08dbaa68bed5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 21:25:05.9525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oTO4sqSHb/CsEe6l4CmpH0IQkvupgIhmd6XiR5pkBA+Un6353vmDvXhq3Msz/bQzeDhq1L4VLEWr+arzsVmQKRBusFT+7ZYo5jTBLG6GkA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6744
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 8/31/2023 4:08 AM, Ilpo Järvinen wrote:
> Benchmark command is copied into an array in the stack. The array is
> BENCHMARK_ARGS items long but the command line could try to provide a
> longer command. Argument size is also fixed by BENCHMARK_ARG_SIZE (63
> bytes of space after fitting the terminating \0 character) and user
> could have inputted argument longer than that.
> 
> Return error in case the benchmark command does not fit to the space
> allocated for it.
> 
> Fixes: ecdbb911f22d ("selftests/resctrl: Add MBM test")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  tools/testing/selftests/resctrl/resctrl_tests.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index d511daeb6851..a9331b31c32d 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -255,9 +255,14 @@ int main(int argc, char **argv)
>  		return ksft_exit_skip("Not running as root. Skipping...\n");
>  
>  	if (has_ben) {
> +		if (argc - ben_ind >= BENCHMARK_ARGS)
> +			ksft_exit_fail_msg("Too long benchmark command.\n");
> +
>  		/* Extract benchmark command from command line. */
>  		for (i = ben_ind; i < argc; i++) {
>  			benchmark_cmd[i - ben_ind] = benchmark_cmd_area[i];
> +			if (strlen(argv[i]) >= BENCHMARK_ARG_SIZE - 1)

Should this perhaps be:
	if (strlen(argv[i]) >= BENCHMARK_ARG_SIZE)

As you note in the longest string that can be fitted should be 63 to account for
the \0. If I understand correctly comparing with "BENCHMARK_ARG_SIZE - 1" would
would consider a 63 byte string as invalid.
	

> +				ksft_exit_fail_msg("Too long benchmark command argument.\n");
>  			sprintf(benchmark_cmd[i - ben_ind], "%s", argv[i]);
>  		}
>  		benchmark_cmd[ben_count] = NULL;

Reinette
