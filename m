Return-Path: <linux-kselftest+bounces-782-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF377FC96E
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 23:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0027BB21365
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 22:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD0350244;
	Tue, 28 Nov 2023 22:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LVGg5IFv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C7A170B;
	Tue, 28 Nov 2023 14:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701210187; x=1732746187;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pD/lsuizmYTB6vwBa0900F8IyVVIKRpRyQswwXt3LaE=;
  b=LVGg5IFvOsxJ3X9vjzA1EP83yMCCk3ndAMjwXYkbIe1mwUvH9m46tqWS
   9j4328+giH8X9RBTzR0Z8TmnpJIB3ju4siPyscW5EP+TQi77nULh3Bba2
   kh7y2O6EzSfohBcgPWtHvyMwy5XSU6VAN7entH73GBKK4bQTcep2hVpqN
   CaNYTpaJjGp9BHHnwqDTgH3akbhpM6RPBJrB5ViN4S68cH3Lp0Z5bGMmu
   C7EafSLbraJS2i+jQtzjDFIe/r80eeC889o41T9ETEplOhHbNVjFmfhjx
   k6sYx1QbSn99r5GC7ccojEEiYaP+m6KzqfJC2uexzKY4YEthRvum3eVwb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="459545101"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="459545101"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 14:22:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="768686016"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="768686016"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 14:22:35 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:22:35 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:22:34 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 14:22:34 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 14:22:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Okh/juCchHq77j6cVzY0p2efzx35SLRloaUIX/E2QXNhZAp+foeI9h/UeGqYTt1lkcZvQlqqGFtCoDdGlyrQejQMCUFzBmZ2pYNA3Xoh1Oy1X5ZUQu5ucLql5VkYiCl0T1/rjW1B30f86eaecKBFcByd/Y5B9uzJowpAa708F74uPJexwEBpo3IObnmV/Je01L/Z3/79L+DnDTGSwVqEgeWtvIu6HnTsWQQIRmmLsMlOeudmxFoY6+tV4AZqdBtVKwl9Pdh+7i7wT9lLcBiPlreHOhA+GQEeQfLURSakItb3gOI6VWLRDaVXKf4m/DqYyYeo+wxjoa+vFoJgSNeyvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/pSL6E2jf2mlmflBFaUwaU/rUk5zYGlk6EJws+hIMk=;
 b=UmfgPTDlt7Gxf/S1n1XyrMfZBKKf30PZR/Mgu2EbswXTV5Vhhi7q5SuO11gegVw945aJ97ZmN6uuk1E3uCqyXpFCH+G1T+DksijlvG0YnnEIiCEwf4MRXbbdUcQqDXp7Z64iPFbXWU5EqMeqlt0+y/S75ev0bIa/Tk7JkNAV5IZKTM2b2Sy7qslKEy95e6svI7kGmHsrD1bZvgxFP4TquzOBM2gV8it4MB4pI3znxujwVODKbXZOiq1H6pfp+iHl//Bts6LaiyRqwLzracvgs6b8/MaqSKtfmbUbjXuoEI5ClQyk+cmBXYcEZ6hO4Ydu9ZyLaoLSE3T9sUOJkeCs5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV3PR11MB8744.namprd11.prod.outlook.com (2603:10b6:408:215::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 22:22:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 22:22:27 +0000
Message-ID: <1297008e-b31c-4833-b446-fcd4036d1e64@intel.com>
Date: Tue, 28 Nov 2023 14:22:26 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/26] selftests/resctrl: Rename resource ID to domain
 ID
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
 <20231120111340.7805-25-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231120111340.7805-25-ilpo.jarvinen@linux.intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2318fedb-7294-41f6-d485-08dbf06080f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7U+2jPJO45HLMsG6bvZGAyokoycHkj4IzPb4R32Jskg6hJGx/NKDNovdU09/PFwsj/S3EtTWs46fe55IaMYxV317YFj0UCcN+IGrxC65OQapKrNbyGjyNkzGpjADSqvxf/mAEbO88DpPZrK0mamEVBpQXCLC299+Rbwo98uq97Lcm3d/mQLRGg+clRQSRo9DWaKznTNYvnZTwKgiO97efpAR3bQhs3OzzOTv0u2ZHYgqP3v+16mIr2jaX1q2sH+WtKkoE1q7zJ/kC5PlkWvj8aNpZM+xYgj7gzzTMwuYyW4GWBsBOFh3uPhogqyMtwOWXsivijYGWwvjGm6mJg+QyV7CJcPI9qKSDC2JrwYH3tCo2PH35U8+xQl/DBciCdriz2Sk9WIdXdU1gxT5fnlwx8q3QkUfHKJJtesh4Wns6shDMG3H98cX+ZWkFmanlzt4Fj3DLb2AiCePvSomqNgMVWXGry6buaBCpmiiaxwezpaLhqb7BsLhS1x4dLfdNUVvYxGDsr3uzSl+ERxDF1k3YIo3b4YLjpS6/db6bUaNPmTClvgWWVHz2VwbVH/Vs5HlgiPBl0R/haDFGa9pXBxmSToesDpsWPhceIaoo98EYcUE5sKr3m9mzuFoWtre+6yBdVIFoHklSHFB2sEjm0oASA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(2616005)(38100700002)(41300700001)(36756003)(31686004)(86362001)(5660300002)(83380400001)(82960400001)(66574015)(26005)(2906002)(44832011)(6512007)(6506007)(53546011)(8676002)(8936002)(4326008)(31696002)(478600001)(6486002)(110136005)(66946007)(316002)(66476007)(66556008)(6636002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REdkdThkTFNkMDRWamY1MnFhUmlqd0VnUkxBcFNFSnNmYUpNUXJHL2twKzJE?=
 =?utf-8?B?dDBac0QrbTRRUWl4VktSNGRML0szUXVrQlMxczd5dWFXZlFoNzE4Qmc1ZzdF?=
 =?utf-8?B?R2U5dHY3NDBrbU13NGZNbDJHNm14WUthQk9UeWRRelpadTA2a2IxSm9yOEN6?=
 =?utf-8?B?VUtwNWJZdkszNkFOcFhSc3VPZUZ4cmNwaUN0V3NjdDhFV1E2SjYxRmwyeVlr?=
 =?utf-8?B?MktmUGJyak9SenhZL1RiUmFrOXZRczR0YXB1Z2swZ01VMWQ1d0M4MXVMSUk4?=
 =?utf-8?B?YURlZnlGYk4ydVJRcjh1N0x6UTJPcVMwL1JXazV1VzBUUU5VRGMrNWM3Vmd6?=
 =?utf-8?B?UUN5eTNVMXhiMDUxUWFOSHlUMXNjTlg3c2FjRVFiWGxJNHdVZ1hxMzYwOTJk?=
 =?utf-8?B?aWVLYVd6VHpqRi9BNENOc0wwcyt1L01LOWdUQm1vWjBwT3lJRm02L2ZJODBU?=
 =?utf-8?B?TG9TajBTSGZncFJwcnAwTnBqLy8xSjQrNDVDMk5BOVFGaVFqWEdQTDg2VDRX?=
 =?utf-8?B?ZEJDT2FXbEp0NXptUGVVN3RRdGdETVRNWFM5RXAwYXlreHduM0tmblJ3blpU?=
 =?utf-8?B?TzAyYWVLLzFDSm0wRjllNFlmOUJUVm9MM3JIdEZKbEtmRXNrWlB0OG9TU05E?=
 =?utf-8?B?NFh5ZWoxSjYxVnNidGlxaW4rOVZQbmd0amNXNEw3RWFMUmIyUHhIS0E2SjAr?=
 =?utf-8?B?VDhUdVNUMzA3Qmd3YnRXRTFORnFyTWJSMkMxU2xUamIvTXFiTXV6SktpMUhx?=
 =?utf-8?B?ZHZrbUFab2lpOW9UcmF3cit5c2pOM2Jpcm1qdzRKSUdTb1krRE5DUExSbU9m?=
 =?utf-8?B?QzVHSVUvSWtmVnNTWVI1WDQrN0NQdk5Yc21RL1hoYm14VHVaNFV6Vk9kajR3?=
 =?utf-8?B?NFBMbnd0WkVEY05ydGp3NmMyQU00VURRSjE0RWJtcWdSZWZjcGVraWZPS0ZD?=
 =?utf-8?B?Q3Fkc0ZCbkZMellnS3M1bWFHaTBGcHUxUGhXUmVTRWlXbDBEYlZqbFh5ekNQ?=
 =?utf-8?B?T2pVNUhEZkdtdWh6WXpFdnFwS2FXOUFpS3hCODBhMlBBRFdTSEVuQVV6THA2?=
 =?utf-8?B?SnVQNnNXbVVmQ1lGN1VMN2VnWFAvTDhWTTJBSG54VzJ0OThXUUE2bll5TzNN?=
 =?utf-8?B?U2lHZW8vaTRSNlg5Q0ZNZmt5WFk3M0tBT0c3SS95RVJsNS9ZU29ueEdOVm9h?=
 =?utf-8?B?ZExNcTVjK0tFOVh1TWNLT0VpZDdmdlJ2dmVBSjdDMzQveEdscUk2eE5iR0tG?=
 =?utf-8?B?em5uTE95c3pFZVJBTDJpaEVXNTBsZ2xNZjZYUmZ6RExLWEFXTEwxeW45bEtI?=
 =?utf-8?B?Q0p6eDc5dC9ScUlteHZhRVZPcm5xRUJqb2NEL0pLT1FvMC90ajd1THIvQUg4?=
 =?utf-8?B?TXFYTkNDb2VaMDZBeHNoUWFBUEM1ZnpZdDNUUU01UmxXSkNSUUpUTGQrTURs?=
 =?utf-8?B?RjZiVnA0VStvaDY4SG04TEVXVmNpeFZNeTVDVlQxL21sWngra25jMU5uS055?=
 =?utf-8?B?Y3J6UXg3NVVBcnp4ajdXNTBXL0V4b1dHeEJKeVBhMEVHb3ZHR25DcE1qZHZr?=
 =?utf-8?B?QStUWUZYTUZsQTVBSzBUVDdQNXQrazl2a293SkpxQmVqcUlyNmdZTmkrRTh4?=
 =?utf-8?B?NzFpQ1B3UzJVWXN4YjJwQ1FuSTEyMXBzeTlUekJpMjgxU2JPZVZ1TThLV002?=
 =?utf-8?B?S0lqQW5UZVp5dDFNeXdCdlpIVHJCY1VIc0JXMGZmMWd1ckM5ZzRGSmd6OVdu?=
 =?utf-8?B?eEhuMFFlQ21Gdi9NWjY4QlFlMVF2K2hxbWRuckxSbzc4UW9FeXF6eEl5aW9E?=
 =?utf-8?B?QWxXZUhKcUk2TkMyaGRDOHc5cThMa1NJQVVLVDdHVkJ2ME5TYktSWXMrZ1kr?=
 =?utf-8?B?SWhmTlVEVFBqYkJEcnJkWTlyM21qejRZd0JpR0N2Mk9DTWdFckRWbUE0YW1X?=
 =?utf-8?B?ME1KR2NCK1U4TTF4czUybXZWTnpkY003SzBhaGhsSVBQeHYrMUdMcUhwb0d0?=
 =?utf-8?B?ZzdZOGpNSHhleTlaMmwxK2dZbVMxV3hjZUhTNzdUWXg0TXh4OVN0TEx6ZFBT?=
 =?utf-8?B?bVhvSlJlcUNIU3hJUHU0dnE3U0lLTzVWK0EwUEU0dmtVaVk0Y0Qzak9JTW5v?=
 =?utf-8?B?WU1Wd3hYRzh0NVhxQWlGMmxKdGVwOW0rSi9uaXkyZFd0TkRrVStTL1dzMHM3?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2318fedb-7294-41f6-d485-08dbf06080f8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 22:22:27.5381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o33V7XCcTSKpByb1NzVNz6M8KTdrGzLrQH8O585EeVUIvw6bx6uPSnHP60hVAPUaLv6dw1pDmxNGcS/sFm8fdF7A5BdAG1FN0++ATDKzLCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8744
X-OriginatorOrg: intel.com

Hi Ilpo,

On 11/20/2023 3:13 AM, Ilpo Järvinen wrote:
> Kernel-side calls the instances of a resource domains.
> 
> Change the resource_id naming in the selftest code to domain_id to
> match the kernel side better.
> 
> Suggested-by: Maciej Wieczór-Retman <maciej.wieczor-retman@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  tools/testing/selftests/resctrl/resctrl.h     |  2 +-
>  tools/testing/selftests/resctrl/resctrl_val.c | 30 +++++++++----------
>  tools/testing/selftests/resctrl/resctrlfs.c   | 18 +++++------
>  3 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index ed7a69578daf..280ab6b6bd07 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -124,7 +124,7 @@ extern char llc_occup_path[1024];
>  int get_vendor(void);
>  bool check_resctrlfs_support(void);
>  int filter_dmesg(void);
> -int get_resource_id(int cpu_no, int *resource_id);
> +int get_domain_id(int cpu_no, int *domain_id);
>  int mount_resctrlfs(void);
>  int umount_resctrlfs(void);
>  int validate_bw_report_request(char *bw_report);
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index 4e0c356b7f18..f278f5c9195c 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -387,20 +387,20 @@ static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
>  	return 0;
>  }
>  
> -void set_mbm_path(const char *ctrlgrp, const char *mongrp, int resource_id)
> +void set_mbm_path(const char *ctrlgrp, const char *mongrp, int domain_id)
>  {
>  	if (ctrlgrp && mongrp)
>  		sprintf(mbm_total_path, CON_MON_MBM_LOCAL_BYTES_PATH,
> -			RESCTRL_PATH, ctrlgrp, mongrp, resource_id);
> +			RESCTRL_PATH, ctrlgrp, mongrp, domain_id);
>  	else if (!ctrlgrp && mongrp)
>  		sprintf(mbm_total_path, MON_MBM_LOCAL_BYTES_PATH, RESCTRL_PATH,
> -			mongrp, resource_id);
> +			mongrp, domain_id);
>  	else if (ctrlgrp && !mongrp)
>  		sprintf(mbm_total_path, CON_MBM_LOCAL_BYTES_PATH, RESCTRL_PATH,
> -			ctrlgrp, resource_id);
> +			ctrlgrp, domain_id);
>  	else if (!ctrlgrp && !mongrp)
>  		sprintf(mbm_total_path, MBM_LOCAL_BYTES_PATH, RESCTRL_PATH,
> -			resource_id);
> +			domain_id);
>  }
>  
>  /*
> @@ -413,23 +413,23 @@ void set_mbm_path(const char *ctrlgrp, const char *mongrp, int resource_id)
>  static void initialize_mem_bw_resctrl(const char *ctrlgrp, const char *mongrp,
>  				      int cpu_no, char *resctrl_val)
>  {
> -	int resource_id;
> +	int domain_id;
>  
> -	if (get_resource_id(cpu_no, &resource_id) < 0) {
> -		perror("Could not get resource_id");
> +	if (get_domain_id(cpu_no, &domain_id) < 0) {
> +		perror("Could not get domain ID");

I do not think perror() is appropriate here. It is too far away
from failing system call (for which perror() was already called
anyway).

>  		return;
>  	}
>  
>  	if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)))
> -		set_mbm_path(ctrlgrp, mongrp, resource_id);
> +		set_mbm_path(ctrlgrp, mongrp, domain_id);
>  
>  	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
>  		if (ctrlgrp)
>  			sprintf(mbm_total_path, CON_MBM_LOCAL_BYTES_PATH,
> -				RESCTRL_PATH, ctrlgrp, resource_id);
> +				RESCTRL_PATH, ctrlgrp, domain_id);
>  		else
>  			sprintf(mbm_total_path, MBM_LOCAL_BYTES_PATH,
> -				RESCTRL_PATH, resource_id);
> +				RESCTRL_PATH, domain_id);
>  	}
>  }
>  
> @@ -582,15 +582,15 @@ static void set_cmt_path(const char *ctrlgrp, const char *mongrp, char sock_num)
>  static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
>  					int cpu_no, char *resctrl_val)
>  {
> -	int resource_id;
> +	int domain_id;
>  
> -	if (get_resource_id(cpu_no, &resource_id) < 0) {
> -		perror("# Unable to resource_id");
> +	if (get_domain_id(cpu_no, &domain_id) < 0) {
> +		perror("# Could not get domain ID");

here also

>  		return;
>  	}
>  
>  	if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
> -		set_cmt_path(ctrlgrp, mongrp, resource_id);
> +		set_cmt_path(ctrlgrp, mongrp, domain_id);
>  }
>  
>  static int measure_vals(const struct user_params *uparams,

Reinette

