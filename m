Return-Path: <linux-kselftest+bounces-2739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37104827AA7
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 23:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5122846B9
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 22:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5847BA53;
	Mon,  8 Jan 2024 22:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TVGG+x/c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113B02904;
	Mon,  8 Jan 2024 22:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704753124; x=1736289124;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pDNa4O9u0BXkyUKOb7VBPUpA5zOqXferzCze40B7o2A=;
  b=TVGG+x/cuqcHU+3Ix2eO191nWlGtC41cLKPDfPDzEOqI4lmI/6lHmYgQ
   CDL/uIp15YqffKnc6Um64yoydzXp4MWbS4jIJpYY9gQF6iLdz8F+rHfXC
   oDQG/fdcIkDT2sekzCGzsahkSQ9nzhm46L7kkQyE5sQEAD3RdOmEo4Vq8
   kIAzVRaJQUZ9LzQ/kXKrtX1wk64w2Y0hk2Xpc5cbBGMR0FI1k281vHrM9
   CRjC11J2RCoQ9bNRK2WroHLc8kq32gmj2zW+wpkJQnNJE608W5S7fko0Y
   CeXLsK+XsoKuu2Imt3kgALs3UEki067MdLXPglzi9vwT6teQjTmuUFKyC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="16616984"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="16616984"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 14:32:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="815750884"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="815750884"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 14:32:03 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 14:32:03 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 14:32:02 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 14:32:02 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 14:32:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYe57hp7Gp9t/qH/xlIYGhl8+f8oBBtcwNcsMg4gr45HQe0rGCRFOUBCA6+wQcF+Dx+BB8KEGEVP+psTwmRkLfb2s8glEb/4gL+h/NQEVlIr4H/o5yOsfnMN/zjO+Y1HFRSDKGb/sZbs3UMQ6DYNMYnRTOGrLfeJwScP3wulC7vSVuNMFtgzuhKmJ84wngNjBIEb7KLRVcQrF4K/4xlo2hAv6bZ7wj0t9/R3yyCq/yZvQB9/nqJFQmqsMIun3ADvDK8Se1q3LyjQ71zVk3BfNB7f9whentRGb3A+Sge6a1UmFi61RegZzXQYwZ73nOdmoT73qxiKkwFpo4pQ4k1MZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViNkcQrUvs430PILMRQjTeJAKiPAwXSHLLRtMRzXW8s=;
 b=C7a/Cg5NTnuiuonzu82y6YQNyS3LAQR+MzhIsWpohIxes6tsfMuYO/EVIQNqDrsMxNpl0GcFeEnoob7pbbLIyWK23dPIWcEEWMsmaQlVRJMWT8CDThHdx6/zBu0tFIhSyftYbRpcWwUDEQLrYhOo/RU0LPRSocfpl31l0lJNTxZ6qMo3kt6br+fEvNWZUyiGWSuK7c3MPp+asljE5SawSXxP2G77sbv6pMvyyzpk89o+qSyOEN82IIQ0s31m/vRALT8gUN711g507a3TGyKgg3NhpkCB70UpEoM327R9UTPXFcxiEMjXfoErKDAnTnELrS9OUTc+t9FyqqWReLtEkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7707.namprd11.prod.outlook.com (2603:10b6:806:322::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 22:31:53 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 22:31:52 +0000
Message-ID: <65e7aab3-ac50-442e-b559-00f2345c8a29@intel.com>
Date: Mon, 8 Jan 2024 14:31:50 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] selftests/resctrl: Add test groups and name L3 CAT
 test L3_CAT
Content-Language: en-US
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Fenghua Yu
	<fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>
CC: <ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <cover.1702392177.git.maciej.wieczor-retman@intel.com>
 <de2ea86256f0026989e6836f9e731be3667c7afe.1702392177.git.maciej.wieczor-retman@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <de2ea86256f0026989e6836f9e731be3667c7afe.1702392177.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0347.namprd03.prod.outlook.com
 (2603:10b6:303:dc::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7707:EE_
X-MS-Office365-Filtering-Correlation-Id: 4362ca3d-d730-4363-a086-08dc10999cc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nR3mgJLvmX+Sty70FhHmkC1/CHPI3atn6CIqDYwK0/Ywg1OWGa3pzjAr9o+7waPgLwXTt48U9rruCEmfcdtO7PqLVMKHxctLCUtP1Z6iw5CJh1JzwYnU8khqnX2F4xJv3pMC1WsxjCwbH4+YriXcfMtEDznIvQMAHmyvEq7ZW/aw/27pRPB5JDLknGUkSmRVlq9lZxUdiPxPP5RNkvfK8qWsdpRIRjcxnFdDuSZeGSzEdfYkZFba/JFhCQnEgJGEPDi5vGcZooOTkv4N8xY/5cH19SB6tfWIZUgT7Gf5/ueJBrU3pqi60WYLhu8ERVAt7IdWLpcyJSwDodJ5+ojOE961XMq2YLpv9UmyDBo/c/1uS6qIVb1JvHjn8fN6IxZU3Q6PCwjHVe1Ns4QH7FB+yT/AOIfY9q/iekycKgJ/JwJBZG0RZXNvpipBzvEUFUQIe2tcl1KhFATwSi40/ScGZk+LYwNOrsIuWx0wcvujnfzXl+vSv5wwUqY9w9pXia6Q775YuuHe3BdsKDMnB5VE1M4Xgo6q4LIOY1csLEHUt5mTyWiiUu8E8OEUKEYOfcGBfe9pr68YaIBDxK3KD4lQ4k2AuyFy3fvnLLTByD42KTzU8YTZBLelD4JY0ju0qy/NDLTeKo8SJDo/YoDVsioLRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(38100700002)(2906002)(5660300002)(82960400001)(86362001)(41300700001)(31696002)(31686004)(316002)(110136005)(36756003)(8676002)(8936002)(2616005)(6486002)(66946007)(66556008)(26005)(66476007)(478600001)(6512007)(6506007)(83380400001)(53546011)(4326008)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2dJWGdNTXl4WWVwODlyVWEzT0NBWVNRRklxRkN5cUFhZWJRT0VXTkp2QnFj?=
 =?utf-8?B?LytwcXgvUXJzRFk5QWhJRVJhbXMyMGpzZnMyZmFYYjRrMFJPMjlxaXFTVmkx?=
 =?utf-8?B?WDRBWHdHMVdpZjZPWTFlVnlqYUJCcFNsYjhlUFJHV1lvSVFsN3pkR1dXR3B3?=
 =?utf-8?B?WGlpSzY2bmRSK2pSL3FNSzV6S3FSb1A5MlpoTmVlSlF6Y1BESzBHZUg5eGZn?=
 =?utf-8?B?ZjluNVRlMkZoTzdPOEtiVHIveDF3eU5YTGFpcnVpQUNRa0Fua3Ard2VPNHNU?=
 =?utf-8?B?bGtTaDYwbG1FSDQ2WENIelZOTnBxTmFpT0o2aVVhMGp5Z1dld25qbFZSVXB1?=
 =?utf-8?B?U1lFOFVYeGVRL3N6djFxWUlSSmRmdW0rZzRXSDVhdHE2OG15d1FJQzE2bWRH?=
 =?utf-8?B?Y1l3eDc5Z2xUZmVhS0hMR3FBc3dvUjl4enV2all4ZW1Ma2ZpcUwyY1VadW8x?=
 =?utf-8?B?Y1hyaWpSL0ZTRVczVGsvbGFwcWJLZWp5anlqZ3oxVDJWaTJqaUh2ZFptM3FH?=
 =?utf-8?B?dGZIUWM1ZXk2bUhMVVQraWhGbWZBTWplbUFYSEluUkloclEveGpOZ1NsVlNo?=
 =?utf-8?B?VW9UMWhjZnBlZEp1Z0g3eHZ6QUlEYWVkdk9uQTJMcHJYUkZvSG1KT1NGMkN3?=
 =?utf-8?B?ditXT1BINDMraW5QcE9nSVhIY2xqT1NrZUZFcGFsek9mUm5qdXlyTTVZN0Yv?=
 =?utf-8?B?RW1ERTljVC9MV1JwWVdPUlloMktmUHlpd2ZXUGZoWTRUa2xyajNBdUF0Mm5H?=
 =?utf-8?B?dDFFS00xM0lCcFAvQVdIeEs2SjFzQW4ycGpXNzk4SDc2MmsxZlZpclZaNTcx?=
 =?utf-8?B?UUpVaWlHblg5RDkyZTc3WEpCcDR4cU5TNEEzVnF2Q0lhTTNrQzBKL0dGZ3pS?=
 =?utf-8?B?eXBDelZNT2RUdjlBRVpaQkdvTDRweW5NeC81WEs5Yms4TllGUm5SSDNsZExZ?=
 =?utf-8?B?QVJFMXhzdENEZXlaN2ppY0UrMHhPOW9wSmlYbjZrallYSmNMT0Rlb1RrK01R?=
 =?utf-8?B?UnlLeDRSTEs1dkJZZHVxblBuWDFZanRBZUhvMytEamljRlhwK24wdlU3MUUz?=
 =?utf-8?B?K00vVjdWTU1xSVBoenhRMkZxWlFITEsrWjY1bTZ4VDljMDZ2Rjd5UFd0MU8x?=
 =?utf-8?B?MTNMTmVBM0UrVldCckE0SU55MzBHVUpjMTBlUW0vcUJKcGIvWExYbzc2c2xU?=
 =?utf-8?B?VS93Vzdma0R6Q3BTS1BKbkRUZGNqSVdCVDIwQ0JUOVB5TFVCVzVzYzVYOFJa?=
 =?utf-8?B?ZzNNL014TjZnaGlLVWVZaUJFczkxQ0dzYXl4NXdTZmlHekFVNUNrRkE4VGww?=
 =?utf-8?B?QjYxMXdqV3BueHhKVG91bllSTVcvdFlxbDBXRlRsc2t3eURpMVpUcFdmeWFH?=
 =?utf-8?B?Qjh5QjcvdmV0YTVXUUhpK25xUUl5RmtQN0xWMDdpQldSS0pFNGlsV1VkK3E3?=
 =?utf-8?B?NWVOSXhVZVRKR09JdHJBYTVZU1ZCOVBSTnl0S1RYZkU0bTdCUnlUZDA2RndE?=
 =?utf-8?B?V0d3elZ1NTg2T3FMWm9qYU9MeUJPNjErcGhCc2Z5UHp3djV3dkUrUnh6eUNa?=
 =?utf-8?B?a3hqTEkvMUJac0VDd3BMK2dYWjZyR25iN0tqeGlhbG5uVGIvalhMM1o4ZEFv?=
 =?utf-8?B?bjBIMGJDbktWdmFxb011WHg5Y0NmSEljYUZ2OEVQd3BlMkF3MjJHN1hSZVRD?=
 =?utf-8?B?UUZCY0JpSnQzSy9zN1FxSE9kNlo2S0IwNDN0VVQzUS9PTEZqd1NrbHVGUXZl?=
 =?utf-8?B?UXBnSkpsd2x3bHMvTjJTYlRBYlZVdzZqb0hXSGRpbHA4aUpZUTdGRlM4NHJ4?=
 =?utf-8?B?V2FJbGJoZnpwSTZmZjVKSmVOeTEvc0dkRVhIck13TGJkWk5lbndYYzBmRWlK?=
 =?utf-8?B?QitHekhzc1ExaVBFM3FDRWRSYUx6aU1vMFNKK2Q1dVkzaTE5ZlY3UWE5ZnQ3?=
 =?utf-8?B?QTI2NjBWOWlTR2RtUHJFQmlQdkxXaFp2N2laSHVOWVdIVGlNcVpTTWJ5YXBL?=
 =?utf-8?B?RDhVeWpaT2k1dGI2RkNtVDQ5bTA0WEwxSmE5MzlYb3hjaFJaNUJxYjcwVHRN?=
 =?utf-8?B?TUxVWlpLUVFMbVc4Zi9vdkFrNUdnVm9aWUpDY1R6RWVMc0JsZE5RSFI4Z1k0?=
 =?utf-8?B?dFRGZFd2aFVvdTZwY0VLRmx0OFpORVd6SDVOWGhpNEVYdjZwcU9JczJuOGpO?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4362ca3d-d730-4363-a086-08dc10999cc7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 22:31:52.8084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nmmNe/aziEB95rtpe1aankZVssmv7ZplM2fF50u9GwfvECRUvMZIGYGIEoa0Zv6cxe1H/M+vaCWECgQ397NsuHmpBrBhT7CcNBE22pNcn1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7707
X-OriginatorOrg: intel.com

Hi Maciej,

On 12/12/2023 6:52 AM, Maciej Wieczor-Retman wrote:
> From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> To select test to run -t parameter can be used. However, -t cat
> currently maps to L3 CAT test which is confusing after more CAT related
> tests are added.
> 
> Allow selecting tests as groups and call L3 CAT test "L3_CAT", "CAT"
> group will enable all CAT related tests.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
> Changelog v2:
> - Move this patch from Ilpo's series here (Ilpo).
> 
>  tools/testing/selftests/resctrl/cat_test.c      |  3 ++-
>  tools/testing/selftests/resctrl/resctrl.h       |  2 ++
>  tools/testing/selftests/resctrl/resctrl_tests.c | 16 +++++++++++-----
>  3 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index 24af8310288a..39fc9303b8e8 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -295,7 +295,8 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
>  }
>  
>  struct resctrl_test l3_cat_test = {
> -	.name = "CAT",
> +	.name = "L3_CAT",
> +	.group = "CAT",
>  	.resource = "L3",
>  	.feature_check = test_resource_feature_check,
>  	.run_test = cat_run_test,
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index c54efcf1412a..739e16d08a7b 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -65,6 +65,7 @@ struct user_params {
>  /*
>   * resctrl_test:	resctrl test definition
>   * @name:		Test name
> + * @group:		Test group (e.g., L2 and L3 CAT test belong to CAT group), can be NULL

Could you please remove references to L2 CAT test that is not available yet? A
detailed description of what a test group is will be helpful.

Reinette


