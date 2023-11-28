Return-Path: <linux-kselftest+bounces-779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D187FC968
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 23:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C936B282F72
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 22:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A4849F8B;
	Tue, 28 Nov 2023 22:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bpKpTDe0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C551B4;
	Tue, 28 Nov 2023 14:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701210157; x=1732746157;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vsPkbUkq3h4dWFJpmagqhNi5+BvG0tFcOpM3FcQX8SA=;
  b=bpKpTDe0wW7qt8v98CXKXOJ7fme/3UdaX0Vx0U5dSL5ZifiQKhq8G07A
   boeMZeU/ToI1eUwiNpNXny5jsm5O8T92VDitwBREaeoEN+5u4nBwGZbfD
   MPaOZ4UcD9a6aZuMHI6ns79618IwCq8rVPEUcg4RO+2izRL0NyhSMTAIg
   x7pt2U9hdotyyyyzAC4kI9DjNUpbF7U+BwpBMA4WYuurKZ1rlSYXCqV6I
   Av/+8AiE+cY2mvxgowU71kDbjUN94AmvlpY60tAc1tPrAukKiP3YgVxwK
   nt96MKP5Xhw5w8l2iiqoP1pcTkMisyjw7aYzLrY7yfpty7G8YW8e6/mhx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="459545075"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="459545075"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 14:22:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="768685997"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="768685997"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 14:22:33 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:22:33 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 14:22:33 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 14:22:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjAV6e8REW1AsIP9dtDkXlEYkYNfSnktiTODL9VsNWhwIzFWRlEOlybsErEwoxUDJv3CLnOFEl9N4j30qoqjwHolOxajgqsvw3KdGj06MMKoVhfJIPKjwOPjkzWsGn3WLVE3A4rzJzJONdhxn0WWXgVrejAzxSIoUECyiaCdIERRQdB3V3pbl/7UNTwq/0TzM5Del/Ux8Th7Tg0dGdjWatIP9QbJDaWuRCwM7Q6M3CBBgj0SXrG6ePqJFmZQGx+77UuAYsYDzf3K99bmfOhdNbp0pUzhoSKIAxmICzybd105So/I4r8ld1GLtxT0VMvJbEQsECyy9QQvYcFaxv8UOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ay7d14ah4eR8dGTyIRzDXjjUauyPV760Oe8T9kUElpg=;
 b=HzBKjL7HXr4finsSDEg47rU8oiBnEmOyC38dLeL9Blbu8QJNptZnbzCoihUqxsWYhBvnpv0gURtopps2j9ZWqwGl61BE7wqMyQdDRQLaq1AEJS+CNATOLukm6P6GHLh9DZJop3oy34W4GfuFm2K3OEH9LXtn2bfpldGfHqcqL6OiSSyCwY+EnOwsLyjbmLvcRE8ObSyXu8O/qZu9YAkzd6sSkMgatPoSml/YVn+tj+Y1Qa1j64Mw5WM2imCuVxoDw5PSTP9pll3WdKxwkFrSIsHXHlXYsWIjDqs4JURU6O2wnxRrlp64Bv8kaFil5DbufS3pktvLqWZXQsoRt5/qVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV3PR11MB8744.namprd11.prod.outlook.com (2603:10b6:408:215::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 22:22:13 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 22:22:13 +0000
Message-ID: <53812f86-beb3-4f7e-ba9a-6bf0f0340426@intel.com>
Date: Tue, 28 Nov 2023 14:22:11 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/26] selftests/resctrl: Add helper to convert L2/3 to
 integer
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
 <20231120111340.7805-24-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231120111340.7805-24-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0310.namprd03.prod.outlook.com
 (2603:10b6:303:dd::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV3PR11MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: 807cff40-2022-48f7-e167-08dbf0607866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M6EcbWEXuUSHfPR3Jnd6TJVmL60goJYkoWH7FIJLNdpne8zoZrNQHIB77gtd3Kd18q0vYJ67usJ3anTAdSTUckdLpXOEA7bdA+PIVMB/5O94phSmTZ+oN4Dyzh5kgaStAOFhOivlJ0vTvTDHXvjJCBKKGGph7qSA3ItDlHpiRvQ44+gJLd4nenxB2RpA0V1ECVXl4R/tXPopEXv4b8q65w7+hS4yh+ZiqIOQLbEcu2LC+57EVtFU3iwpSQJePys1G0yjJk6dFgy0xIUnmjZaSZuKyCRvytEowXl9wFPuelpLQx6IuhRsib3IdEyeoaamJajA8sCJhIPc84TN/Xg9V6t7IVEuPt89sA89XDB9SRLB0M5sJZ7AbD9jT5zqyq7IU4C1wBjPEAM3DKCzXF3CjqGYA+yaENQ7rz2a/QY7MsC3mmE58ml9dzvv2zj+qRBmOsIkFGsXsDLudXd3FT/u7ZXxQQHUvXyOyqhzkXKmSC/nghm7WnLCKA9Q9DMN+610slO7ZdSMWWtJwz9+uwe80GgtbKrHZCO9nPjYL3j2yhqVeo2Bw84rSpDGtvylwY5kn0pu2Zj+erCPrS4qtoMfwtARLCVGnRT6DECx35WIEhYG1N2s3wEbaiB5tvx4kXDIrTG54m9h6WwXxBscptVVFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(2616005)(38100700002)(41300700001)(36756003)(31686004)(86362001)(5660300002)(83380400001)(82960400001)(26005)(2906002)(44832011)(6512007)(6506007)(53546011)(8676002)(8936002)(4326008)(31696002)(478600001)(6486002)(110136005)(66946007)(316002)(66476007)(66556008)(6636002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkN0SXI4WkNtQXVraWRNUXlBRjExMWswTmZ1K1BlSmhoUUNuUWVCTnNHZnFB?=
 =?utf-8?B?dW5JOEpqR0xhbzN0M1BBOXpObllOZ1MvaTlFS3BkTE5DM1g3aHZjdFpnNXpx?=
 =?utf-8?B?Njh3SE05aVcxVktQcTVJZG01RXlHcXlHWXliUkowdW1Eb0lvZ0pjMGVmOUxK?=
 =?utf-8?B?cVg5R05qVHN3VTVWeDFzMlRnWERwd0xpbDdYTEN4aTJqOE9QdC9nMG9wVi9Y?=
 =?utf-8?B?TUNpODBWSy9IbnZxaHVtNWdxdmt1M0FZTzVWYlBhM3hRVWlXT0Q3WjlrcmNj?=
 =?utf-8?B?YXJlMUpnWVBSekJZRFZSUkdPcHRpeEpvUzZvV1RTZTdIdk5aM0tqSmdZMjdR?=
 =?utf-8?B?bW1GeGtxMjNhNjVGUG9GblJVZmdxdU1GcWZmVXZlcWtUeHB2ZzlURGtHWjhn?=
 =?utf-8?B?ajN3ZlcxRjd6akh1TlhUTlRjakptQkNCazJXZVh0aTM5VkRlZ3FuQTkxRUpt?=
 =?utf-8?B?dEZpWkU0M0F4TTZ0VGgyUEJ1SnkvN3lxQmVTQk1qQmIrdHFCV245V2IvVUQ0?=
 =?utf-8?B?eEFOTlNPdDVFOWEyN3plOTNDazBHcEFvdW1JcDFxRUlRbGoxNzVCYTRYWVlN?=
 =?utf-8?B?N1RTdWt3cWJrdDU2VWFJbDVFakJBUzU2MzRXRS9yZjJxQi9PcFlMa2s0b0lo?=
 =?utf-8?B?aUlHSnVkTWJ1TWJCblhDWWV2aThjU1QxcVFoV1Z0Q082cFZXOWx0d2RpbWNl?=
 =?utf-8?B?eHNQanAvTnBSbmdEdHB5bXhRcG5IbnR3UHJPZTJTU0JkZjkxa0JPQ1FHVkpH?=
 =?utf-8?B?UkFoNG9Rb2FwRnRVWVAvUWd6UWZNbFNSUGQyNUdyMitHN0Zwb0M1UDh1NzNw?=
 =?utf-8?B?MC9nQURHZ0JUK2ZOS01GanVqdEVJT3kyN2prbmRsV0ljSG1DS3FWdDE0OFdy?=
 =?utf-8?B?TCs0KytkQ1h6dUZkREl2YzNMY09sVk03amhWa0I0OXRrS3MwNTMzY0RTU1dB?=
 =?utf-8?B?TDZpSGROc0Y1Y3NpWC8wNG9ldXN6d0s0RzNNalNuYUpISGtGbFhaQ2pkZGdO?=
 =?utf-8?B?Y1BMMmRVT29aRXljR0JORDZRSk1LNmJINE5DVTRPNGR4SDNOQlhJa0ZLb0NG?=
 =?utf-8?B?U0JLQ011VkFBdzQxVnRsSWR4T3F6QmdFYWdHZkhhOGlaQXlQTXN2N0xwVXNW?=
 =?utf-8?B?OU1TcGtXYUMrMTNaTFdQVXlsOEdjR3FIQTM0YkdHSlB6OU42a2NUUXdKUElD?=
 =?utf-8?B?VHlsNTcyZVR0Rzk1dG5nUmJRM3RrS1BsSDR3K3JCRitobUZMbUk4SmFvVkhY?=
 =?utf-8?B?YUZ1UlBpS0JmRHRsd29CM20vV2J5b1F6aUY4VTJPV3FDZG1JbFZsbnlvRXZT?=
 =?utf-8?B?TThqUzN5bFdOWk5QMXErTlp5cGtvTHk2MlAzR2xOVU5DUVk3TXoyOGFaM3lD?=
 =?utf-8?B?ejhjeURSclhjTUdGcmdkMm5IRUs3Q2pmd1E2V2o4dU9RN2RORHptekZsT21I?=
 =?utf-8?B?TkwveEFsZndObmkrbUFlalp0dVVuWVVSVVFxeC94ZFZYYWVDY2RGL3dHdnp5?=
 =?utf-8?B?TE0xZXBMemVGSzN4ZGUwclJJeWM4ZWJvSGRUZi9yTXVpRTZ2anJoTEwybnVN?=
 =?utf-8?B?cnFLQ3hFZWdyajFoSHFrVW8zSEttSmFmWStHaTUvKzJXYy9Tb1k2ZWhGTEh1?=
 =?utf-8?B?ZmQ5RVV5c2lma2hIMHZZMEpDcWVRd2ROSlBIQjJQeDJSZGxDdEdna3dCYUha?=
 =?utf-8?B?Qzg5K1FJUU81NU1YRGpCSmI0dTlKZmk3cWZsZXg3ZTRQN0xPTE9WVVE0RzBi?=
 =?utf-8?B?QXA2TVh1MWhnRWQwSDhTTHl3ZlByT0xXYjBscHdIb2xPTUdFUFRYaTNPRExR?=
 =?utf-8?B?dVFlQW9IQkgyNWh3VlNWdXNGSzR3U1FIVUV1TEU5YngwaC9KeE5BY0l4SmtW?=
 =?utf-8?B?Q0VFSURBb0tyU0F3OUkwLy9OVXBnb2RBL3ptbGUvSHlvNDZvTHlBNklVRmpM?=
 =?utf-8?B?T1JLemZ5eHdxN1ZqdnAvU2MrOVlPTTk5UFNjRDNKbWEyKzUyR200MzRKMEFL?=
 =?utf-8?B?eXRiZ0JzU1plckJoQ2c5NDVnYmdPa21YUWJPdGhsMXlUakw3MnhnWWs2V2hI?=
 =?utf-8?B?NUdhbE9kemJzc3ltTDBVZHVjUDhXaU1WQWMwRC9IL3pGbEtNV0ZjOE54NE10?=
 =?utf-8?B?UVZmVTJNUjZCWThjTWxVQUVVelZMK3krVTRUOGhGaDJlVE8rRnJsd3dER3Vl?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 807cff40-2022-48f7-e167-08dbf0607866
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 22:22:13.1873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +KAgLYfjXfAUMdlUTH4tA88++sIIyAQFiyGP2b4v4ZW+nLA2PD7PHhsmbCfNnKmOAP9qKAaHcQtvyCxr7taW0MceUE6oXld3dhZOpvwh3qY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8744
X-OriginatorOrg: intel.com

Hi Ilpo,

On 11/20/2023 3:13 AM, Ilpo Järvinen wrote:
> "L2"/"L3" conversion to integer is embedded into get_cache_size()
> which prevents reuse.
> 
> Create a helper for the cache string to integer conversion to make
> it reusable.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  tools/testing/selftests/resctrl/resctrlfs.c | 28 +++++++++++++++------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index fda5ad812faa..38ca3ae562e9 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -94,6 +94,23 @@ int umount_resctrlfs(void)
>  	return 0;
>  }
>  
> +/*
> + * get_cache_level - Convert cache level from string to integer
> + * @cache_type:		Cache level as string
> + *
> + * Return: cache level as integer or -1 if @cache_type is invalid.
> + */
> +static int get_cache_level(const char *cache_type)
> +{
> +	if (!strcmp(cache_type, "L3"))
> +		return 3;
> +	if (!strcmp(cache_type, "L2"))
> +		return 2;
> +
> +	perror("Invalid cache level");

I know that you are just copying code here but this usage of
perror() does not look right. strcmp() does not set errno, it
does not "fail".

Reinette

