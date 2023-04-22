Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABAF6EB658
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Apr 2023 02:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbjDVART (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 20:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbjDVARS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 20:17:18 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A834630E5;
        Fri, 21 Apr 2023 17:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682122627; x=1713658627;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QFEpkpTvzGW8gVGXv+0HLYdznJKVQ7e+N5ylV/YoTcc=;
  b=aWuAFPDwkMHKsbdlnieNT1mGc9xzpmrIDzxeIp2ImaPX/X56GZoe1e2A
   lJHzYD+/CSdKLQwQJXUfwfV0PauX8AxEPw3lxQ1YprqAmtqEpZTEl3Rl7
   LmbnCj0r1LrDLWRunzq/DClDxkpnXkFY9/egb25nMiLne98GARos4gNEm
   ANYgmyshox5iWNWT5TKZzqJmDc9wAM+bbBV7nCcOntucgo9clwVXEU02w
   5w+0ITj1yvGQJh9rXnj/4sPzxRF7590uZR7zG/XjEnYknEXxzmTHPAdkL
   Y0drb0r5yXXUCcpoM4oR6Ezs9dCDurgKXTZluDD09n8Bhal6UxEXLhQNZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="432383954"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="432383954"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 17:17:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="866854949"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="866854949"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 21 Apr 2023 17:17:06 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 17:17:06 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 17:17:06 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 21 Apr 2023 17:17:06 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 21 Apr 2023 17:17:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TswY/nmPP5v2rwX0WEm8QDUQW8IE/DyRnVFokGSXN/ZA/e+acoZH9fZ4dNun4Ou5hQexEr0eXJfRyFG/V0YC4B54+Fgsoi6uSxSag/tyi2Yt5nUWzKGOMGOVeWZ+Ism4lVgdeLxuigpSWPs6rc3lS7iQCGSpTK3DTNi50T7tnZ9evcbNr9sp5qJ51Tbv2CP35FEzrnlueoK3f4Zw7+E0Hu/xXOo3DRTCDSMDdvFPqrDx+7AB11ab0/Kzkyp9Ymc5wDvZYhWtrHYeVKGUP34ldvCLgFqSb3rwjKPdziI/2eYUMwJixwKGej+7nzFxJIHVKhYcCp4wJ43OAab9aJiOlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGPa9hCv3/TpSRJDpIZW1K6k0nEkBz1D6Gc4aZyIhYE=;
 b=Wh5d+L4rtdzsuURbrfOoOemgwtVD3HjG7MKs219Hd86iHfv3wBFtD4UHOhpE+ZiDsheQHSH/eoc858SmpDzWjKu48kcEJbJEi9LL0/0B1mb/+83v8mXVeR8o6rvTgnhmIasucR5wdbjIXLa4OZJGjUQkHjER6kcGlTiXf5fzPZu0aAw4Vu/kGcO/xnoNfb53yTT+vc3sN82GlFcmGqcBmOfP0ZmpcOMWiknSIBRYG2JQVCDYBk/2Zk+d6SGsa2wmxY3/MTwYQx8udgDlr4EGLsUOzrwM8vE6oRoS30R5cDSEzsWQfwi/Nfi2viCm2DidYRnAPVZkS5XiclEJ9+zHEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by BN9PR11MB5227.namprd11.prod.outlook.com (2603:10b6:408:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Sat, 22 Apr
 2023 00:17:04 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6%4]) with mapi id 15.20.6319.022; Sat, 22 Apr 2023
 00:17:04 +0000
Message-ID: <c54c301e-ff18-90a6-3e68-d77d0df23b77@intel.com>
Date:   Fri, 21 Apr 2023 17:17:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 15/24] selftests/resctrl: Refactor get_cbm_mask()
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Shuah Khan" <shuah@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
 <20230418114506.46788-16-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230418114506.46788-16-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:a03:255::26) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|BN9PR11MB5227:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7e7db1-dd08-4da9-6d8e-08db42c6e64b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kuLiHlgPe0rpFN38xDVjiUxew2Vez/YRqvpoPMK7z2+LwmWuJl4JIHMqyYhKPGpuEpukzjM5lZLdhGaug1PpqnvrL19UWcCvRT3qjFt5Zc2a6+PT1uGWDaXruqcW2d7/4rjwnUth8UBVTxoXkTDeCbVjf4qy1LBPsIx8x29rgHNJHor8WA+4oS96nBQwKzUoBvfNjxBQe2LwmfEF97jXr4RB0r3GbCyZ4rZROk6WdzuafRC5ibGrjFEeUWW0UU+hiuU/yT/qXs1iEgEbw8mi0ONXcZ1gZGwMXDu1NuGzapXIWJ8ZwZrIfCEo1/8tIN7RFzJYnRGRzhopYfbYIVNARb+2rT49EBMTKZM68AXMwnc8Y1PdyoEM46SpT2933cb0l0v0xp8n1axImkRhscNK9I2j75rgQmFvHDlSo5sUD1/DieUddeQrXb8o+JKr3kwFBtFp0b4o+FJtEIAmg2+s1XpxhpngzewEm9OY7f5RlSzLsybKMWzIs+IjeyoE4PQZ7cVyfhEQLZeZQMoMpcwQgrBjNDglLatWEk96It4Be2T0U7Rd5eMWXfbkfK+/RdgTY/jDd8xqNcD4M2pZwf/zvgoko8wusX7r3lUMqGSJLEMrRJ2AKTosGBPITJ4meG/Vp0KHnloQSXAY1He1pWbQOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199021)(2906002)(8936002)(8676002)(38100700002)(44832011)(5660300002)(36756003)(86362001)(66574015)(31696002)(6506007)(6486002)(6666004)(6512007)(26005)(110136005)(2616005)(31686004)(83380400001)(478600001)(4326008)(186003)(316002)(53546011)(82960400001)(66556008)(66476007)(66946007)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlpGY1lXTExzaGNmK0JkU2hPaWZEd1FqRHVJQWo0RE5IUzN2cVZNenFYSk0r?=
 =?utf-8?B?aHl3ZTdkK2tlalB2djI0RGJjcGdNVzByTWp4VC9CTjVzTm1kUzlzeGxRRnZK?=
 =?utf-8?B?U0pXcXRMVXZNSkRic1FIZDB2d3RnSHUzZEJZNHFlM1pjaU1CN2NuM0ZtbnIx?=
 =?utf-8?B?MmlPVVJvVzNIaFViWUx2QWtzaytJZGN3UTJUY3FsQSs2WmJRU1NqbFJuOVZB?=
 =?utf-8?B?RkJkS2N4eUp4VmgrTkhaNmt2UXB5YTNMdE5HdC9mZXhLRm1weCtKWjZ3VTEv?=
 =?utf-8?B?SU5ranR3R09odW95OGZtTDVRQmZxUEJwelhSci9HMGVDcVlBUC82eGZRZlBK?=
 =?utf-8?B?WGs3Nm9WTXI2Z0tDckZMVzhtT2VvTm43TXBxZTBobzF4YmhETkFxWDhySXRk?=
 =?utf-8?B?b2N3V0lITW50U005QzZESTIyanF0MEZlZDUzdG5lVTl5bDBVc0xHUCt0NVp4?=
 =?utf-8?B?OGw2NzFncVduQ20zVFNMTjRsUk1qSXpSU3dqYmlxV250NUw1NE84SVJEYTNN?=
 =?utf-8?B?ZzFiZ2tmcTAzSk1YSk1oWDRyU0NEL2sxY2NCbkZ0U1JpVEUwSXJGRXJWblB4?=
 =?utf-8?B?NUV0RnBvdHQ1WXQyTFR6OXVxUjNuY1ZXbjZTaW4zSS8zUEc3aHZ6cFdNK1V6?=
 =?utf-8?B?TmdNbTZaR00wTHFqUENldVZIc2NHZFJuN3ZYc29JSFdEV1N6V3JWc3IzaGdL?=
 =?utf-8?B?R2VWSHI2YXlrMWh4RSsvM0dteVF6UnFMbm9ScDNoNktBTDBXczIxTFFKekZT?=
 =?utf-8?B?MnlzMGI2cGFjaFlYdDlFa2phanlyV1pHRVlESjd0OGZwcHZZbVNOdEhFR3h0?=
 =?utf-8?B?bXBlUjFPdUU0d0lLMXFsR3BSMGNtSWVIT3lNeEFFZlZvM1lRMzdKbzc3RlEw?=
 =?utf-8?B?dXZJQVA0cUJSWWRXZ0hidGtqVG9GcmF2OEpYNlBGUDlQTFVCSUFkV3JaZ0dv?=
 =?utf-8?B?SXVTR20zWXY0VXRLVU9KOG5VRVFFeVFsd1JGNUdFRUJFNVQ5TFd0c0VLSysw?=
 =?utf-8?B?djJsU3o5RVh2ZnlTdlgzYktLRVhpemV2RnRDajgxcHM2U0JneXN1cU0rajdm?=
 =?utf-8?B?K2FMNFlMQmZBNDB4cmxsNTNzSEw2SFlBSFVnQm1YZGk0cDhxclNSaXhtRThE?=
 =?utf-8?B?N1NWelU3VGpLYlpPeVc5UnVyQnRJSWFuVlNiZHJpdWhYNFhLU3VJbC9VT0Vz?=
 =?utf-8?B?WDEvRWRXRlZqNk5rcG45WFhNbGNtdmxXUjhma0kwcWVJdU1QSHFYRFhLZnds?=
 =?utf-8?B?VEZkenN2dlhDQTJBVkkyOG1OQ1Q2QVdKaUFXYkNrekFDK3BIMXk4QWU4NWow?=
 =?utf-8?B?OWNNKzAzbUJNOTFzTEpPbjN2RHJHSktSQ0U5M0FPSm9UUWxPR1dwYkpTVU5t?=
 =?utf-8?B?Y0p0UElmQXRrQnFGT25Cc1BIa2FlaVpYTEVWbHBUQkJqMzVPbHJoWHc2dlB3?=
 =?utf-8?B?ZEVHcU93TVJURVhpcUNhYm54N1RPUU51d2x3VDVlL3FNd05tRE8rVHhweGtm?=
 =?utf-8?B?WEpobFdkck5jUm9yL0R3VVB0d1NWKzFYSjhvcEV0TExRMitpeFZUYjc2alpM?=
 =?utf-8?B?T2NzcGlyVTNWd1dNdWkzblJjSHphT2FUTjcvcFlWd1ltRisrVVUrZDRiWDZS?=
 =?utf-8?B?cExNTy82YzdXck9JRUhyZDFQVCtWSm96LzdhTkYycVN1QnhIWHBWT3dXU0xu?=
 =?utf-8?B?MThnWkQrVExRVTRmTUJKalFYOUVjMktVOVc1MThuRnk4QXVCZXY2MDNRbVhO?=
 =?utf-8?B?MFNWM3o1Tks1NXlrazFHcENmc2ZHaml0SEo2UzBlQ3lKWityUk9IMVFhcHRw?=
 =?utf-8?B?S1c3MWJvRHk1eDkweGl2dis0aVhTVllxRmdybVBGQTdhekNkbXErYVFDM3ht?=
 =?utf-8?B?bjliSXo5ZG44OXcvazE0akEyL0lSTmxvSkFRd1gxSkFGcVozRU93RklBbktO?=
 =?utf-8?B?M3RnQ1Y5R0dCV1BwR0drQW5qYWRpbUN0dks0WXlsZlcwd2psdEtpRFNaQk1S?=
 =?utf-8?B?WC9abTdscXJYemJyZzVta0RTYW5wN09JYU9PZmdMdmpFdmFTcTNhc2Z2QWdT?=
 =?utf-8?B?dUxiUDMxbFI5TzFLYkxJdTcyaWhxMnh5QlVkWGIyRlpUZWt3bUpORndyRVUz?=
 =?utf-8?B?K0dydm85WnpCNDVFQTNtdmdXWXFyanV5TlJtMVdjZUlUZ2Q4aFF5dVNmN0th?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7e7db1-dd08-4da9-6d8e-08db42c6e64b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 00:17:03.9552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e9z5I+3ysstZxLwDOzF2kXwnRNPJ012ou7JSt3lPbDBuT9ipMoXDzVUU15PE57wofGxUlH56rOCwqx6RhVjzJg+mgLA+vfh97ZdncCSIDqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5227
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

On 4/18/2023 4:44 AM, Ilpo Järvinen wrote:
> Callers of get_cbm_mask() are required to pass a string into which
> the CBM bit mask is read into. Neither CAT nor CMT tests need the

There is a double "into" above. Perhaps the second can be dropped?

> mask as string but just convert it into an unsigned long value.
> 
> The bit mask reader can only read .../cbm_mask files.
> 
> Generalize the bit mask reading function into get_bit_mask() such that
> it can be used to handle other files besides the .../cbm_mask and
> handle the unsigned long conversion within within get_bit_mask() using
> fscanf(). Alter get_cbm_mask() to construct the filename for
> get_bit_mask().
> 
> Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  tools/testing/selftests/resctrl/cat_test.c  |  5 +--
>  tools/testing/selftests/resctrl/cmt_test.c  |  5 +--
>  tools/testing/selftests/resctrl/resctrl.h   |  2 +-
>  tools/testing/selftests/resctrl/resctrlfs.c | 50 +++++++++++++++------
>  4 files changed, 40 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index a998e6397518..9bf5d05d9e74 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -18,7 +18,6 @@
>  #define MAX_DIFF		1000000
>  
>  static int count_of_bits;
> -static char cbm_mask[256];
>  static unsigned long long_mask;
>  static unsigned long cache_size;
>  
> @@ -101,12 +100,10 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  	cache_size = 0;
>  
>  	/* Get default cbm mask for L3/L2 cache */
> -	ret = get_cbm_mask(cache_type, cbm_mask);
> +	ret = get_cbm_mask(cache_type, &long_mask);
>  	if (ret)
>  		return ret;
>  
> -	long_mask = strtoul(cbm_mask, NULL, 16);
> -
>  	/* Get L3/L2 cache size */
>  	ret = get_cache_size(cpu_no, cache_type, &cache_size);
>  	if (ret)
> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
> index 2d434c03cbba..ae54bbabbd91 100644
> --- a/tools/testing/selftests/resctrl/cmt_test.c
> +++ b/tools/testing/selftests/resctrl/cmt_test.c
> @@ -17,7 +17,6 @@
>  #define MAX_DIFF_PERCENT	15
>  
>  static int count_of_bits;
> -static char cbm_mask[256];
>  static unsigned long long_mask;
>  static unsigned long cache_size;
>  
> @@ -82,12 +81,10 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
>  	if (!validate_resctrl_feature_request(CMT_STR))
>  		return -1;
>  
> -	ret = get_cbm_mask("L3", cbm_mask);
> +	ret = get_cbm_mask("L3", &long_mask);
>  	if (ret)
>  		return ret;

I think this is a good change. It does raise the question why long_mask
is a global variable so I think it may make things go smoother if
the patch making long_mask local is moved to be before this patch.

Reinette
