Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F3977BF43
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 19:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjHNRt4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 13:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjHNRtf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 13:49:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8434F10E5;
        Mon, 14 Aug 2023 10:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692035372; x=1723571372;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fukoYRvajorHKUnUZ/h7KbKEBxey2I6nkH5Yv8snkEs=;
  b=DaSuQtZYZpXFHrDaO6LnUBO/c+GzBlk7dtaSIKfoiNbvCrS81XU14+7W
   qPAd/5s6L2mQ7YuVvD0wtoBAILwViu2ty+xDBRHlHKg2jMZSlc/wATd3y
   DtiBy0Ql3F/TIKNge3GvzVzE3qAcKbJNi7pIKqfN1NTs+f0S4HZcBF9Ue
   0baJUtT0pA9NZLH8/nK6NyKuXQZHNCudZYILXUqPMsMwgzMv2+tqkoa97
   WocQzcvG72HeRM9VI3e/XJBXgwWYrZHhA2/OTCFsEiOE7+UgybD3jKanU
   +PvIe5X4vgZ+BibTA7epChmrmRf1zUZqT9c4mukrJ1WBK5/ef5tsMbMeY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="357066517"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="357066517"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 10:49:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="736603603"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="736603603"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 14 Aug 2023 10:49:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 10:49:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 10:49:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 10:49:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErooYaIftFlJZ4d99eQtteKA1aEekm9QlTEJcrB+zp6HjzYP75f4A2UVhGAYyU2M5R1ORmLb8soPXQ8oh79kKaQ+zy4XzAf9E0k6nlqAVFCn8DMcT8QtPLyOvq8XjkDw60xvbLNf43lHVggvMOc+4MyKw/nSQXNpCRKdyXy2yJM9wpVvCknPKu8PrFeER1Hz99NThYolHLR6WIfRKYueQ20OIaj5xgwsTdFMvdPqDJeFtfxkcmNfP0q/Rv5VkBkKRRyPS/BZs4L1jQtwOZSsA7fwep0xFV59tSBA3ReP011HBgnZu+FK0/kRsQJHYSGB9ycfQvhNKk+Qxu00qXqEIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTVlngkonM128SjG0KtKbtZ/yx/yxgRyTrrQ3Vd6LcM=;
 b=fM8ZzyFNiCjvEJ0YHtfaTXONz8CSjY6OrsHMKYJAHhVOfE3yIzRbO/mT6ZOOG4xVVbcYd/zKMnN2I5JY0FVH1k37oSzvKQ2SgBXshodEa0ZbWzSR3n2P3K8ttiTnl/WQSu6tfZ/8KMiGpUof7T6Tp+Ke4ce7JsrV1MZnWxpIp7TzvlQd7WxqXhcYETA3CaCvJsSmLXFEP0SrJb192q9WYVTh58x8ZydKrDpWoDSCJ7gQFXFoC7KHLyGNC6hYL+SIVrnY/H/dyi73t+Xl2t72bYOW0xj140NrNDhYlRkXqjsq+9Lrb8bteHG0FuMWmJFoVrydHPvkceOnwxey0539oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL1PR11MB5317.namprd11.prod.outlook.com (2603:10b6:208:309::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 17:49:04 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 17:49:04 +0000
Message-ID: <98f8dbed-5eb9-8b09-1868-5dda4162b9e3@intel.com>
Date:   Mon, 14 Aug 2023 10:49:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH 2/7] selftests/resctrl: Correct benchmark command help
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20230808091625.12760-1-ilpo.jarvinen@linux.intel.com>
 <20230808091625.12760-3-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230808091625.12760-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0178.namprd04.prod.outlook.com
 (2603:10b6:303:85::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL1PR11MB5317:EE_
X-MS-Office365-Filtering-Correlation-Id: eb795d03-611f-42a6-f619-08db9ceec03e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qWHh7LiNFF8NCTcrf9BvWXOW92wbbRc3R9/w1uG5RMXREgWBPDINTPfkLVoaHI0L+Px/fRYFArQgtce77YMCPIKWpEJfVlGrqOlQdODIAfBWc7j+KS8Hy2xdRPNtWOLugGsvcDssmrhdV31mIPUrFRsJ77TG3540x9t5VoNDx88A/l6SniO5PPAtiIF8JD5BaAxOCEq73MDx4FvKypLxf7G6PDZrwWbc2VddGisQaOZXNVont8nqYXTHqJwYyjG4AnFqtEGHHLbYAaCJnnr/0osPiHTG7xuEaZ/Q1uTE51s/5qZ4Oz4bjnCuMzmHLIlPlTl76zG10gHzgNXedIew5QHKYs8N6BhB+lO4YsLVrcpueFnazFmQ2mNC0S0bmKCY/avCdIjod+Yr9FggknJhBezLO34ZfcRFt8GhAuShnCrs/nVsyMzrc/2bIbhaStG59PPBQlDYnGQ0M1qKZRcNWvMgs1BNRiOci8PkVyHJY88UAAzIEPolExIWgTo/Izkp8kaGVwm9Bm+0gu8tMf/GwrrxfECwQDjBhgZ3VnFozqkJWOFe1wZE9OxeLplH1DnWmrPAdEImBdDLi6sgTku/vce3+0e4ooQn7IlJQlG7wRm46EBIDHsrMBmT7ie60TomhShV5kakt3g9B+8xdPjkyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(366004)(376002)(39860400002)(1800799006)(186006)(451199021)(6506007)(53546011)(26005)(8936002)(41300700001)(66476007)(66556008)(66946007)(8676002)(316002)(6512007)(31686004)(83380400001)(66574015)(2616005)(6486002)(478600001)(38100700002)(110136005)(44832011)(31696002)(36756003)(86362001)(4326008)(82960400001)(2906002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RG5VTHVlRm1wWXBMdnd5VytZRzNWN2ZSdWFsSjNFR3MwSk13a2s2aXVVamRM?=
 =?utf-8?B?N1FRK3ZHcldnYzBJc0tUVG9rV2UrcHA4SjgzWGQ2N0FkTGg0b3ZqUWtwUTR4?=
 =?utf-8?B?R01jYnEza09wOHM3UlNIU3kyU01PTXJpVVA2Y3R6T3JLOURhNnlZRWpTZXZW?=
 =?utf-8?B?d1NhOFFQUUNMMTNKaUVRSE5XaFZ4YWJXUnI1aDJmQ0RiN3AyZEd1b0tlcTRQ?=
 =?utf-8?B?RmZ6Qi9TT0RKL1lHSlB3LzkrUVNVNm1hRnVwc0IvbmwvMVYyNllxZFdzc2tL?=
 =?utf-8?B?UzArckZEWjZ0bjlaejRSMnJYbmlZK2dtRWk1ZldNZS81WXZndnBFWkFpZHRK?=
 =?utf-8?B?azBPRkdlQm9VaXZlVzJtaWhMSi9CYTZGd3UrdTBKRnlReTY5d3FKTUVYS05w?=
 =?utf-8?B?cngwRVpqTmYxL2pBMlM5Qmw1NGYwanJOU1FHZXhCOGRwSC8wQkVRUUh4NElY?=
 =?utf-8?B?TVBVN2ZiM2FYSk1vNFFlTFdvK1p5Y2pCNGxibCtoak93cGI3Mk5wNUNjMUxa?=
 =?utf-8?B?aEN0RkZ3bEdoaGRhUXZMenlTamY4SEJsL2JEZFlqQUhDdEowRXJjeko0cndm?=
 =?utf-8?B?UmVHQ0c4bWdFL2lUWDQ0QzRJSmtVaHJyYXZFNnJLSHZTYnh6emc4bXFUMGhV?=
 =?utf-8?B?bERSUG5BbEFkZXNGOEVvdDkrY0dBTUFVOG5GSFlyaHZQbFBXUXJmOGFublVD?=
 =?utf-8?B?ZDR5cEM5TEFNM3pKSjh0ZVdLdnVwcElRd3NhTXdWYlFia3Q2NE9ZY1BFaFB0?=
 =?utf-8?B?eERxcFAvSERKU2RBNCtkaVRDYjhNeVcwWXl2bVR2WXhpYkQyQytWVDJVdEVa?=
 =?utf-8?B?YUZDSzQveUlFMHZWTWMxZU1QZU9BbGczalFHNHVXV3M5aVM0UVZ5cHZHQWVu?=
 =?utf-8?B?dEowK2w2S09NU25nY2drNmZiV3FtdU1FKzhKZE5qS2dHR3ZkREEvSGVqcFJQ?=
 =?utf-8?B?azQrcUVrZkdWbWExT0ZuN1ZTSmd1eXNyTUFrWUszVW5ZZndrcTJYaXI5Vndk?=
 =?utf-8?B?YURha2NuVjM5S05rZDVmczZabHVoaEVEVXlHZTJwMXI3RXZFTmpGcG5ibld5?=
 =?utf-8?B?TEhLempVMFVZUHR0aW1hdW9zZm9RazhGTUJSdStkaG90Mnd6RXN2dlpGb202?=
 =?utf-8?B?R0s4dHVQQVhhTzZENkk5WkQxbFdPNTVrWDducThuMVhvdVJDaXIvdi80RXdr?=
 =?utf-8?B?NWNsS0dSQVhpczhBU1lzV3BwU1dxVWIwY29yMGJwVW4xbXM5QmdUdi9jRDZz?=
 =?utf-8?B?NExjc3dyUTRVUG9FU3FvaE1KWXoxWHhlT21GV2xjN0YxTHc2ZU5ZWUxFcUlM?=
 =?utf-8?B?Y1BSdS9xOEV3ampSSWNnZVU4NjlVUEk3UUFrcGFYaTNjSVdtUHBqdU1zbnY0?=
 =?utf-8?B?aThGSUtMUCtVekYvMkxENlhVTDRoVi9FV0dhVnhtMnp5d0lhNkRvcGM5bmRU?=
 =?utf-8?B?L3YzNGw2Mnh6VHoxejNIZk1hTjE5UFc5RSt3L3g1TWluemFkSjhvSWdHeG14?=
 =?utf-8?B?bGpyakxrZnMrNEpnOXhFT3h6NHBnQ3kxazF0Z3pDOEtTZVRuMVUveXdoN00r?=
 =?utf-8?B?bUxXQzRWQW96ZW0wSkk3RDUzU0ZFUjByWVJjYzRETDJZL0o2QWlXSk5yeWFE?=
 =?utf-8?B?RTd4RTg1TVZyaUNNMUZQclR1dDYrSUIwbzJySU5lQUxiUjQ3aGdXRWdveXBR?=
 =?utf-8?B?STBWSWFZWVBzQlc0bjhpSFJDUUVMOTA3U29uc3hMaUpwZ09RVjlsdnN6SGZY?=
 =?utf-8?B?ejZRbjl0aFFuMmdYeXR1T3E1Y1A1c0I3cTRTOUlXVml3WTFBY0lSbllkbnpX?=
 =?utf-8?B?ZlM4MytDcFNLTm0yL3YzU1lkN28xZCtXYmJYYmp3ZnhVZXNPUVh1WjNHOEVX?=
 =?utf-8?B?SjkrVUNNd1grZ1RYS3pRbVpyVUlwMzBIdGxiaVRlRWx0K2lVd0xHM2tBV0xv?=
 =?utf-8?B?RFFXN3pWQ3RlTGY2U2R3eVNQam5Zazg2NlJ3NExkSU9scHVwUG92OTk1Wkkz?=
 =?utf-8?B?aUNxbCtrR1Y0MzY1aHptVnN4aTg3aTRIeit6U0huRGx4YlFXV2dudWhoR0RC?=
 =?utf-8?B?MkYwcWFOUmhoaXErYmF0QzA3d2JNM094NlpxWTluMVNrUnlYNzVOOFF5RGQr?=
 =?utf-8?B?U25GZGlndzJreFVVUFRFMnRValBhTWtxUmdBN3hKMUNaSVY5Tnk0VXY0TnNU?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb795d03-611f-42a6-f619-08db9ceec03e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 17:49:04.5857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VnIvwWJ7VDhNcCmEo6Ok6b5Lli8DXoPKH7qMKUX9VESyiPIFFekL8wP4Kk/vGRiqypA+2/fwGg3ZjTyJrIK3A52tjYP/QgmJAf27hbP9rmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5317
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 8/8/2023 2:16 AM, Ilpo Järvinen wrote:
> Benchmark command must be the last argument because it consumes all the
> remaining arguments but help misleadingly shows it as the first
> argument. The benchmark command is also shown in quotes but it does not
> match with the code.
> 
> Correct -b argument place in the help message and remove the quotes.
> Tweak also how the options are presented by using ... notation.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  tools/testing/selftests/resctrl/resctrl_tests.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index eef9e02516ad..559868b16079 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -52,7 +52,7 @@ int get_vendor(void)
>  
>  static void cmd_help(void)
>  {
> -	printf("usage: resctrl_tests [-h] [-b \"benchmark_cmd [options]\"] [-t test list] [-n no_of_bits]\n");
> +	printf("usage: resctrl_tests [-h] [-t test list] [-n no_of_bits] [-b benchmark_cmd [option]...]\n");
>  	printf("\t-b benchmark_cmd [options]: run specified benchmark for MBM, MBA and CMT\n");

Considering it was documented goal of patch to use "..." notation, should
it be done consistently by changing above line also?

>  	printf("\t   default benchmark is builtin fill_buf\n");
>  	printf("\t-t test list: run tests specified in the test list, ");

Reinette
