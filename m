Return-Path: <linux-kselftest+bounces-1875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2AC81211E
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 23:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15FD828271F
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 22:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134787FBC6;
	Wed, 13 Dec 2023 22:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eNNzfYyt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15566DB;
	Wed, 13 Dec 2023 14:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702504835; x=1734040835;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pWkvIkEdJsnC49Vh2+bf3JgVJO3YbVkSiiicGz2HqxM=;
  b=eNNzfYytzddHOhIeAvIFap4XKz2c5VNBP5UPDj59QGSPcDjFKgPRlpsI
   ov8GF9cELjcMTz8BfF0IL3cAIdZlyWLuHWFZH0zyXUNpP84Lj7od7jyoA
   9nE58vtihAQf3VRB99R1PomeKO7TPJq94yJePerKK/g02QhXVjWg87icB
   h5V2QJlo7XQYoDPdhWR1B3v11qSdBnVSahrxRhu4XWz7xTzmehEkI1SB8
   A2xZSSwf3E2DHcs4WJ5ub1qTUD6zXM0w3wBguYX9H7M8x7kyxzJDhuQ/2
   3P52rQUkOuVElwf0i9nYCH13RHNRAXc4qiopxQAOIP4aPwCHdSlDzz0Xt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="2204532"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="2204532"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 14:00:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="947331737"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="947331737"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 14:00:34 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 14:00:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 14:00:33 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 14:00:33 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 14:00:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIHWW8MbCDH/eL3m4s9upttPCO9zlQ+aLdQvGtS0R/4GnvNyBdphOmnnw9Etu1/JOG3y6e6pg449CQPPhDSXvdg9b7koq+kQWExO7q9ciabwJ0LM/J/dCsDUKZyHRATJEmoVaAveEgd6/geMSyIPC1XcIDA6HB0biJoU2Amkr3uBX/7QE/XMrKYGebxXD1E1VJILtfh3LyCn8/omQW034GkK9ZPaUYdydP9vhN6LqjPDqumPMdzjS5vIaSuaSnrjXwmCpxgoNKgSFl4XmmKWd8yBpc7wUV0CfITxAxaQ0F4xNlYIjKL7nF6it0Gm7rwInP/s+teN1KMtaNQpQ59Ryw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pehkeXVf0LbMFXQoN16UsR+/jvPb6U/Ji5XRmEBGNI=;
 b=ldxfjEVlnDtyLPkaf8Wnjp52TRG5UZH3I9yA3wMrfaPCL7URkD81qqtE5oqLiQzGza3J32/g7n6labwQ82LqocS2Gq7aDG/AUkOfQKiHrL2pJJ0JrrgtyB9t5f5O9So1GqFJCYv4SUfSSxGAnD3y2fvQKfKiRo0KLUzO08XUxwJH1uKTTYKt4iiHAgh22j/fKhlMI+hynln/6xaF8EOzazHxIBexj0mksfQenLQvM4tOhhtOEgVfh1fm59DOnVMay0NjP55hfqn5vbBzsEF759MLCalaaZHx2HSgbk0v0Q6lqX5tWSf/9r+I7aF2rOqGJDZ4Dne+vZ1Sw4lylms/JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ1PR11MB6131.namprd11.prod.outlook.com (2603:10b6:a03:45e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 22:00:30 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7068.025; Wed, 13 Dec 2023
 22:00:30 +0000
Message-ID: <19d47295-35af-4046-963f-efb7838c3eaf@intel.com>
Date: Wed, 13 Dec 2023 14:00:29 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 25/29] selftests/resctrl: Introduce generalized test
 framework
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
 <20231211121826.14392-26-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231211121826.14392-26-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0259.namprd04.prod.outlook.com
 (2603:10b6:303:88::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ1PR11MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b5d102-13d6-42b1-1294-08dbfc26ebf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HIAiz2Qv50OpfdlOWpnMLJ2Hky1tvtTxH99cXavQohZUkQshXshWyYnfOzhSLqjW77dEGYkNsT1+p5x1APe6qmOf5FDkXlxWO0x9Z5sXAof+vo0kLX0UP2R1AzxVNb/9ttL3+ME2kP2wd/hAZrFCoJ5ADNFwpfiHu/Eo7Any46fFjT1p95hoW0Snl2my53w2ywxeb7YRKuBBnOyhECUV63wHPrDB8c70ak98esndAMYgcGvh+cVmqjCwANJnszkKtMnV6fMFYb0kHxqzTifjX9H28ltikfIoT+zCGGv8v00NnIvo2LsPg4vD4yKGWXUWY9sV85PE4gNc6L3EKRegEHDNNh/Fn67HD8rx/zAxqw8YgGF74znEhnc+j9sMJteU3E8wXvELtHBf+QwfBAX0IyNIdes5haEBH6kFtN+JqhAtKPk0aZccwgugfnv9hvQ8RBmXxX49h0h4wtUPycXOwxvXMkTNfCo2zJbU7Dec6ob7EhKv1BhSccZiFt5eSru85PLld4+ExIhfXGSHIb+e+5qQ7DmLbIjErrFf2/ojxK5LLGghmiOeZcGoQMISM/flANdzf7aP/icIenNMVQOojI7hrqLFSJ7Ix6/1IS4m0KpbMMratjlij8BJCaL9xGBZ2c7B0otosFzaiyjFSwBLqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(26005)(2616005)(82960400001)(38100700002)(36756003)(31696002)(86362001)(44832011)(4326008)(5660300002)(6512007)(53546011)(110136005)(6486002)(8936002)(66476007)(316002)(66556008)(66946007)(6636002)(41300700001)(2906002)(4744005)(478600001)(8676002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWVVQ0pkSWtXR3hOMWdLNW9XdWpHVzVVQ1BNcHl2V2NQMit6VEpnbjQyeHhC?=
 =?utf-8?B?VkVJOWliL2JtMDVhY3gwa1pBVzN2dGN4cytiakxXRHljMWY0ZUFtdnNmSk5U?=
 =?utf-8?B?QmJjcHEvYk0yNFVMcEs2UVdldDdWak0ramtiZmZqQm8vVlNjZEQyS051YjNi?=
 =?utf-8?B?WUcvK1BpV3RUdThTNEhRdm1LWjBIZWZ5c1JPdjhLL0lwWEtwMXJEN0J2dWMv?=
 =?utf-8?B?MEFwQnhUU1lwMGh6UzNUSVh2eVNjaWpVSElFaGxkai9hVHBjY2pEaTV4QWVl?=
 =?utf-8?B?ZktHQm44eEx3ODZPYnlQYW5KY3FJN0IxSjRMMmtja3dJd3F2SEk0eXpDRGhs?=
 =?utf-8?B?WmFNUm9KMU1tRDFPZiszQmU3c0VjTDJLRys4VWhlcEVsNDhSaCtkYTlZVGM1?=
 =?utf-8?B?U3N1K2k0bFZsdkxHM1BoZ3B4MnI0dnNDakhUZktlczlCVTZBN1ZyaWVFc3Y2?=
 =?utf-8?B?aG5rYTdjZVcrUWZCaDhyazRKbTRLeHBYRmFMQnNmcjZKMitTVUl4MkZ0cEVp?=
 =?utf-8?B?RGgzVkcyRlkyVVordERkalNTUnRTQ09tOUwzK09aSVIvUjAwREh1VjRTQ2RF?=
 =?utf-8?B?MGhFK2xWSXV5M01GY29mSUJJSVltU1N1dURYRXN0UURPcS9TY3A0cG1LS2Ux?=
 =?utf-8?B?NFFteDNUNUx6R0xJY0g5Q09HMmw3bWt0R3QvdURrN285WnZpTmVmNys5MFpO?=
 =?utf-8?B?UHFLRVFrdzhJcEc0cHFPY2w1Rlgwc2U5cWJpUE44YUZudFk3VHF5UHhtNUVq?=
 =?utf-8?B?NHlCcWFBdTFjVC9oZjdtdkg4SHdsdVpaQXVjSTUvR0lBNVN0Z2tZOWJkdTFV?=
 =?utf-8?B?N1NScXFhVWZiYnk4U3pubHBCcjV2aFhFZnNZTllxejd2VjJaMENCTG45b3Iz?=
 =?utf-8?B?YzBxSzNiYnlML1FOOW1NUnBTUEZTd1pNQ2oreUY3M1cwQ202U25KdFAxWGND?=
 =?utf-8?B?UTlTOHI5K0JPUXkxSEtvaEU2clpaY2l3V1ZVdVpjeVVkaktGU0pCbWE2T2tl?=
 =?utf-8?B?YmNibFVGaklwYlI2WkNobmlwTzNGcWY4RW1QTGlpeElyNHZLYVlVeVhLclN6?=
 =?utf-8?B?WUI2VUYvUThYdWgxYjgwak1EbDIyZjFiSk12WENxVmZXSis4WFgvMm85VU1Y?=
 =?utf-8?B?U0NMU1ZUdGhiVXNWR2ZjNGNnUzZBRmNHcTVSSmE3TVlxdjZrd3NFWXU4eVhz?=
 =?utf-8?B?YURKYUZoTy9oSExDK0JmVTcza3E2bG1YbjdLOFUvTFFpRkZoNlhpemJ4T2pB?=
 =?utf-8?B?SitJc2NnSnJESXNqenZCcHRmS0NaSHlodlJrSWVmUUlEK0NWOG5tUHF2Wi9B?=
 =?utf-8?B?eUdhbDVsY3NxQkhaYmxDVCszTHJsQ1FMbHdISHhnaFJzMy84OHBoZ0k1azJB?=
 =?utf-8?B?bUFpcms0cFQ3a0sySktIdWVncDRKS1hDRGdVbHlrZWtORXBNalNqMytTbHZG?=
 =?utf-8?B?YVdZVkZleElJcGN5TFVUeUI1OTEvK01NU0VCaTF3TWhGcEFZbjB5YVpNMmt2?=
 =?utf-8?B?TXZramI5cWRQbEQyREhaazRVMk9VdnAzV3RweUlGT1I0bHRJWUxXSlhFTHZi?=
 =?utf-8?B?K1hiUkdXV3NKcE5XSDlTRzRnVWwwckl4c1BzemFpamZGaHBJNGtpYzFXeUov?=
 =?utf-8?B?S1UxOHp5bmpreld1ZExuSWFHTmZGcE1YdUlmdW1rWmlnV3lsaUdUb2EyNlJj?=
 =?utf-8?B?R0tLcVBNMzBiS2kwYmVGZjcwZEZBUklZdDF4L2ZBN0FLZEFEMUtZK1plbTdk?=
 =?utf-8?B?Ykh5VjJ5VWlOeWhMZ25mQmZNU2lxLzc2Z0lhaGVzQSttSnVSY0xwVXZ5U09s?=
 =?utf-8?B?c2hIQ3FkaGtseWd3QURKUW9OMnRvNVFrOVRiSUZPYUJYbm00Q1pHbjRzOHRI?=
 =?utf-8?B?dE53UVduMFY1SmZWRnpSNTV1eXYyd1VVd2lPMGx1Zy9qTU5CemdGUE9ML1R0?=
 =?utf-8?B?eXA5ZnZsb01Id3NkUXFuVGM3UDltR0NWSEpydFhqK0x5Y2NMbllYVWdCVUhn?=
 =?utf-8?B?ZmphdU1ucnpxbSs3OWw4ZklRNUwxMm9oK2E2cERWVkpuTXY2ZklYZ3BpZkk0?=
 =?utf-8?B?SjJKblBwYjBLcUQ1czkyZFIxdWdsd0txTmtsWTU4cHg2cDQ2MGoxSURkOTNa?=
 =?utf-8?B?NWhjbnpYN25OTDhTRGUzNVVxOENMZUFuemdVcUQ0UEZZVnk5emwyWjc5L2lp?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b5d102-13d6-42b1-1294-08dbfc26ebf8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 22:00:30.3618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4zJHoB2dQIDVDG5D4IL54K/QG9422C2cJEyyrvJkf9ANsEkAKsiqSZPcBFMOcpRuiSBIBA5tk6TuFUVTHCeyPyzk/u93Joapw8GvBqC3vQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6131
X-OriginatorOrg: intel.com

Hi Ilpo,

On 12/11/2023 4:18 AM, Ilpo Järvinen wrote:
> Each test currently has a "run test" function in per test file and
> another resctrl_tests.c. The functions in resctrl_tests.c are almost
> identical.
> 
> Generalize the one in resctrl_tests.c such that it can be shared
> between all of the tests. It makes adding new tests easier and removes
> the per test if () forests.
> 
> Also add comment to CPU vendor IDs that they must be defined as bits
> for a bitmask.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

