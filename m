Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209B67AF93D
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 06:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjI0EXu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 00:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjI0EW7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 00:22:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9245193E6;
        Tue, 26 Sep 2023 15:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695766483; x=1727302483;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x5/+GI8a4wj8sAtrT4TCPlTngDgKEhYvI6Km/uN4oNw=;
  b=mzjG1fWCRivjvcdvv3E1BerFYXNBwNSGFIb5tHRDPPigRTifwGAWPYzM
   brJaa1jkT3sYQIja24Gxi1dyeom0D4wfEZmdD37ACFO5OXMeeNC5s/UWa
   zZlDwAVhV4SQU32mau0YBhw943p2x1Qf6J7YV7lmfL2MYcGDo/rWYJyFm
   o7A373JY/lQF62jTnmEKw4NDFwS++Xl1BDeC0no+I77eVlqcdKEMAJ7jf
   JE5zfhuwd47Ab7wq92JmmeLhaxs2bMWh7k55HJBNFb3nOWesbsrBhCiUN
   V1Euu4Rgxal09blhirppmTph8I7cathTZbuYl9vnek2SDqXdWhRYaMKnr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="385526534"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="385526534"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 14:39:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="307056"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 14:38:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 14:39:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 14:39:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 14:39:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 14:39:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hur693/KhDnKlnXZwfJHQ5l3/xzHjkMIEoP4ITt2dUZNRRdQ01JgmxXBQYnA3o37diPIX9nesphWPaRp8xpY5lJVWWUacX2R+YcQ1jtroiiMnS3+3eOhhyrsKEMHwpGWHbVVP0MNvjcZYcfukCYciWM5xaKSDu/TeAaU61GIzfq1QC6VdOW2GHfYVnqQGA5eM7vVm4P0sk1MkxS8YBr5ibnR5Q+sXB2zwuOf1nyi88l8EMgS7c9zW3eppikhKyLguPDW3l+I78+zPti6ljnKZbhMRU04KFXM8ugOWYuGhb/eX59FsoFAa+aam9l6RDxZjKeohmi0ttthAL8mjy5eXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIboWnFRSFtqF9gQL0z30LFZlHunheM48zs/vFyMPkA=;
 b=YAZJovIy57CLQ8dCkgFsbfmAuDzJLshcpgJeTkUoPv3RLvhrt9Ey3EyzXalQ7kwKMYZOwFJPT2UjrrxS9khyqbn09N0EU9cgnQwUwnWi01cIljRqWBQRhmdhKf7P5EECwa0x6U/GVEg1O5QaOictGaiAmQGTX6wz1JUgaX4SeDxJeCPP2jNl7BJOF/wxxjODa68imfWGqWBMo+0JPprWiG3uPZA9189bPVG6wJarkrgQLa2yb5+p5T9guqpVgg70XRCJZP8F2a2omZ6yLl0wZPRSmiEGBi9Q+cdISLKeEs1qqMYVwOtlTXhE67Yb4tuMIVr0abfwFHUtiXvNnsPBxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7705.namprd11.prod.outlook.com (2603:10b6:806:32f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 26 Sep
 2023 21:38:59 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 21:38:59 +0000
Message-ID: <d2d94def-742d-7661-3632-b9f7e4996415@intel.com>
Date:   Tue, 26 Sep 2023 14:38:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/6] selftests/resctrl: Extend signal handler coverage
 to unmount on receiving signal
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>,
        =?UTF-8?Q?Maciej_Wiecz=c3=b3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        <stable@vger.kernel.org>
References: <20230915154438.82931-1-ilpo.jarvinen@linux.intel.com>
 <20230915154438.82931-2-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230915154438.82931-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:303:b6::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: bed16710-83a3-4629-5e4e-08dbbed8f30d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WEBlcr5KHHU74i88AprTdb5ox0KNGKoddIrcVqBpVronrUl0qGnftjauFNhHuQClrYiCMYDh04tnN/RJTmAjlRTWhwIRLGtgHUbm9q2hOO26ZDcCoBcaIaAmJLQWl3qyQRylafrgjqrg9/iujob5oTwJ/PWGF3oKesics946b51RQfIIum5lx4EwapBQG+irQgC/od+zD5RiZBUIoW55EKKfVtSo1dNXGDO1Iuy+s8RUYkQh68CDnRMwlivsDYcNagWWq8dIRKc7juS4ODCZXl3cFsaPVrWFHoFQWbyC89qfDF4mgG/yLYwLOqcUk1IG7dE50hq/rHjI62q171glGNZ8b7DlQkyP7WKNdtkcv3beqgPbcQZsdhg7r+ZEkECore7cHCZ0T16gnl11pwldikG2v81s31xzFLksAO11bWS/S5lNL2CEy+2rL3LZL8zEyTMSO/NrXk/Y9xB8pWKiwcKVE2YKbqfgvChQwXh1oKuxqkAwffrlXMzCXdlOzV0VnoLCm0+hPv3kFsRr0oTFF8bEz9mTh6AuYIC7Cz49fYwH6B8CQSu3V5jvvSv9NtpeiqnFelkTewSQKvENkrsdcY1/tQfx2GU33UvhpXdL+kvrORsI+c5So/Yj3CX9TSO7nmnd5YZP2c5AiU0u9DZmJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(136003)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(8676002)(8936002)(4326008)(31686004)(110136005)(44832011)(5660300002)(53546011)(6512007)(66946007)(66476007)(6636002)(54906003)(66556008)(26005)(316002)(83380400001)(6666004)(66574015)(38100700002)(82960400001)(41300700001)(31696002)(2616005)(86362001)(6506007)(6486002)(2906002)(478600001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0hudE1Ec1dXQnUvb0I5Tk5iMSt5bEZTWUlrMjdTZUNYSC82a2pDanlVaEdn?=
 =?utf-8?B?MEp4VERVWFA1LzAvWE1BWEpxamtSWjl0SXU1WE9lSlo2NUxvYTBBU3lDdjN5?=
 =?utf-8?B?SEVyTE1JYTBIalhxZmVmUFlVWmg1SFVwSDVKVE9SdE5QVjRjak1DU0tIUlY2?=
 =?utf-8?B?ZEVEU1RhaHlncEpZblp3TWNLRHVJWHpZL01nWmlJc09GUXdvZ3pNWlRMTzhp?=
 =?utf-8?B?OTFESTdaWklkWkFIdFJQdk52OTBQSFhPSG5OdmNPVEpUWGRmbjJ6ejlLZWFh?=
 =?utf-8?B?MGxXMVUrcWY3TkNCdmxUS2trT0RoTFNFVFhud1VKNlVVR0pNMkdVMWR1N0tQ?=
 =?utf-8?B?V1g4K2pyTHhvQXZZb2lsSkFlVjlEVmREWS84bjJudUE3RmdsTG51d2JBOHFZ?=
 =?utf-8?B?OU5CUE8xSUR6QTQ4bDNLR0dUbnZ3MVp5NlQ0eUdjd0tKdzNMYmhzOHhwLzA2?=
 =?utf-8?B?NG41bVB0bGlNY2ZjWWVxTTRBaXkwMXZ2NS9lcG5nelBGS29LSjNjNDA4amJ2?=
 =?utf-8?B?K2g0NEFsY0QySlo1ZWNjSjZCQVk0UUV0MVZpWkZVcnIzU1RpY3BibGMzZmNs?=
 =?utf-8?B?ODljdDRMWDZkc3BBRjQ3OUJLR3RsYnhaMGRPNHMzZGRLVDZSb3J3aWZVNU5m?=
 =?utf-8?B?OWc5TjJqWWJUUnUvUUhhdnFHblVXL2xXL05ZaG8yamd4clFmeXEvMythWlpL?=
 =?utf-8?B?dHk4emhhWGorUGFiOHBzVVZCUkNXYnhyYW1YaXBFMTkxOHcrT0Z5ZWNPTDVJ?=
 =?utf-8?B?SWo2bWFaVW5NS1hBRkREUEFMeUNOM2VEV2dSREdUS0JRRmdoU3pydmtYSzI2?=
 =?utf-8?B?QWIrdXZPSHNaT3lQbTIvVThpUVVQYjdmT0plSDFFSTg5d3pQTnd4ZDV0QTY0?=
 =?utf-8?B?OVQwYytpMWtwZ3VsT3RLRkVEdm5jUUpjVnNPem1neGNua1JDYzQxd3dzNkdB?=
 =?utf-8?B?c2hxUFU3ckFjVkdUVThjZm9zMGZPbWVuTVV6RmpIVkhPZkg5dERVMFExZGpE?=
 =?utf-8?B?ZFRPREZhd3dERnpyNWVKWXF2NXhyMTY4VzljaEpSWjE5eTVYbmNNeFp0VVJE?=
 =?utf-8?B?aHJ3VnY2bTFLeEU2V2N5RG9VdHlCQ3VSQkthd2dvRXdJVEtXTXNBdjBUMUNU?=
 =?utf-8?B?R1l1bXNEd2MxSGVTMlRJYXlLSTNZbkNBT2hhazFzNkdXU0xVaFpRNHdyekNI?=
 =?utf-8?B?UWFOR2t4M2V3MzR0SWtiMTFFY3RSYXFLUUhPSFRLZ1hQclB2VU9LRUtpbVAr?=
 =?utf-8?B?VEgremVuMW12VytxN1gvZzlDdWVDTWFBYkxBM3pMYWUyZ1FPN0VtaGswWDlQ?=
 =?utf-8?B?b2VVV2FudFJuS1NJZjdZOEJzTVhWQmhIcnhVWG1qRWZLT3Z2aUMrTGh1Y2ZE?=
 =?utf-8?B?Qy92dldEeUxQYjArVFYxVy9hMmNEZjV4cnpCTG10RlNkbDF6dnBmWGdSZWVQ?=
 =?utf-8?B?bXJzUVRUMk5xMGhtMHNKQWVBK1VSb1BJWHJyL0xVTmV6ZDM3RjRXaWFuaVM3?=
 =?utf-8?B?dGxxaVgzM0YwQ1U0b0twUHBUdzRQVmRUMHFBYngxeWRscXhCZVgzNkNtMTZ4?=
 =?utf-8?B?UUYwYTkvTU1xYUI4ei8vSFJIVm0zOU9hTjRUM1R4b2ZWanF2WEtXc0RGaDNE?=
 =?utf-8?B?NHYrRGZOWXZvWFZJNlg1dFBkT1RIUm5GMDZHTjRMV3B1ckEvd2ZrOXFBY0s5?=
 =?utf-8?B?eDFHOFZhMjhyZi90NUh5Ylhud1lqZEVWMm1GZThiQXNYVFBQMVRkTWQ2UUxC?=
 =?utf-8?B?Rk9sNjJpZjlnYzFxNlVyWkplLzUxendiS2RySTB4NCtIY09SZWFrZkNsc2t1?=
 =?utf-8?B?RFhhV25EZEw5T2xpTUtrVDlINUJKcStBelpWT0xHRjJrMDV0TXZXNDE5eWRi?=
 =?utf-8?B?MHZTVTdML2ZrS3lZeVR6MS81T0FvZGdaeHZpTjcrVkpQNWpmOWo5VC9vM3Bs?=
 =?utf-8?B?TDVwbjdMOCtsek1ERlZJaG45bXlOZXJGZGFIMTg3SktEZng3SElsUXp1MmlN?=
 =?utf-8?B?QXVFMDFmNlZBZkhRcnZUSmZrRE1memlMeituV3VGZGJRSFUvUTJmTzZCWWNE?=
 =?utf-8?B?ZDhIdCtWbVFoLzZxYlNpZ281bHFoL0ZadEF3TDNLeWsxMUo0RWNob0l5S2Vt?=
 =?utf-8?B?YWU4cHhPQS9xTTVYS0VkL0s0bFp1ZGxGcFk0SG5YYU9OcklWQUdsMzJOVDdW?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bed16710-83a3-4629-5e4e-08dbbed8f30d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 21:38:59.3783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8HYhpmxtnm/cCWM0xVRtvszo2Lqd2TLoPl+eWH4Ja+wNCDtv0JCMeKpUoSUkfQAS+a00xqqZwqHxlfGLW2yTW+khKAheIMx3xkIfRWO6onU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7705
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 9/15/2023 8:44 AM, Ilpo Järvinen wrote:
> Unmounting resctrl FS has been moved into the per test functions in
> resctrl_tests.c by commit caddc0fbe495 ("selftests/resctrl: Move
> resctrl FS mount/umount to higher level"). In case a signal (SIGINT,
> SIGTERM, or SIGHUP) is received, the running selftest is aborted by
> ctrlc_handler() which then unmounts resctrl fs before exiting. The
> current section between signal_handler_register() and
> signal_handler_unregister(), however, does not cover the entire
> duration when resctrl FS is mounted.
> 
> Move signal_handler_register() and signal_handler_unregister() calls
> from per test files into resctrl_tests.c to properly unmount resctrl
> fs. In order to not add signal_handler_register()/unregister() n times,
> create helpers test_prepare() and test_cleanup().
> 
> Adjust child process kill() call in ctrlc_handler() to only be invoked
> if the child was already forked.
> 
> Fixes: caddc0fbe495 ("selftests/resctrl: Move resctrl FS mount/umount to higher level")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Cc: <stable@vger.kernel.org>
> ---
>  tools/testing/selftests/resctrl/cat_test.c    |  8 ---
>  .../testing/selftests/resctrl/resctrl_tests.c | 65 +++++++++++--------
>  tools/testing/selftests/resctrl/resctrl_val.c | 22 +++----
>  3 files changed, 48 insertions(+), 47 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index 97b87285ab2a..224ba8544d8a 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -167,12 +167,6 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  		strcpy(param.filename, RESULT_FILE_NAME1);
>  		param.num_of_runs = 0;
>  		param.cpu_no = sibling_cpu_no;
> -	} else {
> -		ret = signal_handler_register();
> -		if (ret) {
> -			kill(bm_pid, SIGKILL);
> -			goto out;
> -		}
>  	}
>  
>  	remove(param.filename);
> @@ -209,10 +203,8 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  		}
>  		close(pipefd[0]);
>  		kill(bm_pid, SIGKILL);
> -		signal_handler_unregister();
>  	}
>  
> -out:
>  	cat_test_cleanup();
>  
>  	return ret;
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 823672a20a43..524ba83d7568 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -67,21 +67,41 @@ void tests_cleanup(void)
>  	cat_test_cleanup();
>  }
>  
> -static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
> +static int test_prepare()
>  {
>  	int res;
>  
> -	ksft_print_msg("Starting MBM BW change ...\n");
> +	res = signal_handler_register();
> +	if (res)
> +		return res;
>  
>  	res = mount_resctrlfs();
>  	if (res) {
> +		signal_handler_unregister();
>  		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
> -		return;
> +		return res;
>  	}
> +	return 0;
> +}
> +
> +static void test_cleanup()
> +{
> +	umount_resctrlfs();
> +	signal_handler_unregister();
> +}

Thank you for adding these.

> +
> +static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
> +{
> +	int res;
> +
> +	ksft_print_msg("Starting MBM BW change ...\n");
> +
> +	if (test_prepare())
> +		return;
>  

I am not sure about this. With this exit the kselftest machinery is not
aware of the test passing or failing. I wonder if there should not rather
be a "goto" here that triggers ksft_test_result()? This needs some more
thought though. First, with this change test_prepare() officially gains
responsibility to determine if a failure is transient (just a single test
fails) or permanent (no use trying any other tests if this fails). For
the former it would then be up to the caller to call ksft_test_result()
and for the latter test_prepare() will call ksft_exit_fail_msg().
Second, that SNC warning may be an inconvenience with a new goto. Here
it may be ok to print that message before the test failure?

>  	if (!validate_resctrl_feature_request(MBM_STR) || (get_vendor() != ARCH_INTEL)) {
>  		ksft_test_result_skip("Hardware does not support MBM or MBM is disabled\n");
> -		goto umount;
> +		goto cleanup;
>  	}
>  
>  	res = mbm_bw_change(cpu_no, benchmark_cmd);
> @@ -89,8 +109,8 @@ static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
>  	if ((get_vendor() == ARCH_INTEL) && res)
>  		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
>  
> -umount:
> -	umount_resctrlfs();
> +cleanup:
> +	test_cleanup();
>  }
>  
>  static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
> @@ -99,22 +119,19 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
>  
>  	ksft_print_msg("Starting MBA Schemata change ...\n");
>  
> -	res = mount_resctrlfs();
> -	if (res) {
> -		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
> +	if (test_prepare())
>  		return;
> -	}
>  
>  	if (!validate_resctrl_feature_request(MBA_STR) || (get_vendor() != ARCH_INTEL)) {
>  		ksft_test_result_skip("Hardware does not support MBA or MBA is disabled\n");
> -		goto umount;
> +		goto cleanup;
>  	}
>  
>  	res = mba_schemata_change(cpu_no, benchmark_cmd);
>  	ksft_test_result(!res, "MBA: schemata change\n");
>  
> -umount:
> -	umount_resctrlfs();
> +cleanup:
> +	test_cleanup();
>  }
>  
>  static void run_cmt_test(const char * const *benchmark_cmd, int cpu_no)
> @@ -123,15 +140,12 @@ static void run_cmt_test(const char * const *benchmark_cmd, int cpu_no)
>  
>  	ksft_print_msg("Starting CMT test ...\n");
>  
> -	res = mount_resctrlfs();
> -	if (res) {
> -		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
> +	if (test_prepare())
>  		return;
> -	}
>  
>  	if (!validate_resctrl_feature_request(CMT_STR)) {
>  		ksft_test_result_skip("Hardware does not support CMT or CMT is disabled\n");
> -		goto umount;
> +		goto cleanup;
>  	}
>  
>  	res = cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
> @@ -139,8 +153,8 @@ static void run_cmt_test(const char * const *benchmark_cmd, int cpu_no)
>  	if ((get_vendor() == ARCH_INTEL) && res)
>  		ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
>  
> -umount:
> -	umount_resctrlfs();
> +cleanup:
> +	test_cleanup();
>  }
>  
>  static void run_cat_test(int cpu_no, int no_of_bits)
> @@ -149,22 +163,19 @@ static void run_cat_test(int cpu_no, int no_of_bits)
>  
>  	ksft_print_msg("Starting CAT test ...\n");
>  
> -	res = mount_resctrlfs();
> -	if (res) {
> -		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
> +	if (test_prepare())
>  		return;
> -	}
>  
>  	if (!validate_resctrl_feature_request(CAT_STR)) {
>  		ksft_test_result_skip("Hardware does not support CAT or CAT is disabled\n");
> -		goto umount;
> +		goto cleanup;
>  	}
>  
>  	res = cat_perf_miss_val(cpu_no, no_of_bits, "L3");
>  	ksft_test_result(!res, "CAT: test\n");
>  
> -umount:
> -	umount_resctrlfs();
> +cleanup:
> +	test_cleanup();
>  }
>  
>  int main(int argc, char **argv)
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index 51963a6f2186..a9fe61133119 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -468,7 +468,9 @@ pid_t bm_pid, ppid;
>  
>  void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
>  {
> -	kill(bm_pid, SIGKILL);
> +	/* Only kill child after bm_pid is set after fork() */
> +	if (bm_pid)
> +		kill(bm_pid, SIGKILL);
>  	umount_resctrlfs();
>  	tests_cleanup();
>  	ksft_print_msg("Ending\n\n");
> @@ -485,6 +487,8 @@ int signal_handler_register(void)
>  	struct sigaction sigact;
>  	int ret = 0;
>  
> +	bm_pid = 0;
> +

Since this is an initialization fix in this area ... what
do you think of also initializing sigact? It could just be
a change to
	struct sigaction sigact = {};

This will prevent registering a signal handler with 
uninitialized sa_flags.

Reinette
