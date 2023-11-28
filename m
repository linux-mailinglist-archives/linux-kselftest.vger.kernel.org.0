Return-Path: <linux-kselftest+bounces-770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4847FC943
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 23:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E49C61C20CF1
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 22:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC54481CF;
	Tue, 28 Nov 2023 22:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EoMSYCUO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A3C1BCF;
	Tue, 28 Nov 2023 14:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701209747; x=1732745747;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EHsxYboCwMlFEU0c3Le5aTp2ZO8zxP/2yPqhjfLvsCI=;
  b=EoMSYCUOOY8rhCed1ZOCQfQbaUilIqYv+bPt/sJjQRS4+dAETYoI+Sex
   I/FEKTqAFsMWDpgx+FkPEOuzGaHU4mWeqXyquV61qGvKAiYHKr3y7T2bN
   BXFnIOIdARFf1T2o//EVGd77E2zwLd/2hZ7Awy/4mLIJfenHgl19FRy5g
   pWxIBiWbBGsQRRmM32pbKAQBQU8wHur/TkploPKPhs8+XoxMpDAqKoPWn
   8Z9Bx7jLlAviltuP5fi5r8OxpKxO16BRductJp5EchJhuu1A3MqjNKEpg
   9cVvMlMTLj04vp1mPmfyudt0R4CsUHKWA2bXNYgGmoGO3XWsVLeDC7Ew9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="6248600"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="6248600"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 14:15:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="1016056375"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="1016056375"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 14:15:46 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:15:46 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:15:45 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 14:15:45 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 14:15:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNFd3QkdMWIpIaynNHfLP18CQVcj8FzPleq7LzWX2s2F5cKYZpowPT08XUEKeojOJo2/vVzJqy62ucFeSEmNDoaEwQQzS1MZyl6YkZCi1Xb76Feg5Mv/4gWPf8U+3Y8wHhi1poDUbRWYqhH/LNIom5HwL9mEvESbmC0eaRVCOSIBOeSFu9NOSHG+Ylk/C3M5f2Tgb/WHf4lMAixX4KKdTJcSoTicwkzasQk6/4zV1KNscWQhjeTJTbz7nbBbFMqbjJ6nQO1WdQERr574SNhaHLsNjPcjO7Z+3B94Ci8dwLmCGuo8B/Ii5WQSDL5Ffmms4BoU2H+/w5NWJzxtW5B1fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9NFDvgeo6i2LaXZNLQngbw8J52Vbo9LISrf9bW+qvQ=;
 b=Vndo6/xo63wpoqvCKNb7K8ojUbTPjeMT/a0zSUZjqdpAEIdwj6OUHE5kIFJ1poA3qTbPn9i8rFW0xAZjbP2T/0AIssZApMginhV3TcKOKOnOdF3oWvhdIAEYTaWZEFSY2sECYj8ggEniELMvxwhTVp24MNaxmLiemAYyQZ3mmC8q+FcM5tu9ZXhtdkMxyorOf5OZSgucVD7/bEOsmamNbjhyEfk7B7phyBO8EvLA/G0MZ7t14xqnc8Im2kUyZbsD3JRa35ZGlRDGI98JvCWy7sEXhEcrCQNZ+dCgErufgk8V6kj/1e0EIN8RiD+d8uNvs0CRPistuxK92kEzB/EHmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7419.namprd11.prod.outlook.com (2603:10b6:806:34d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 22:15:43 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 22:15:43 +0000
Message-ID: <012b2f99-40bc-4859-b419-72530b29b7a4@intel.com>
Date: Tue, 28 Nov 2023 14:15:42 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/26] selftests/resctrl: Convert perf related globals
 to locals
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
 <20231120111340.7805-15-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231120111340.7805-15-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0192.namprd04.prod.outlook.com
 (2603:10b6:303:86::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d84f226-1092-469f-1155-08dbf05f9023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7PcGi6ZyrhalQk/FjZ3lw1K3r3aIHB0HLwuY99fuhgll3m+sZpJCFRfc9YiwtfWW8/62im/etvOORbgCIjIE4mKQHkeyhFyNgbxvb8xN7F8SVY8YSVNnWlxkAgm7BQHvZlS5BsTxNNKL054Db/QATy6wfVTy1ahYLUppb/OAURNsndfpnuEGH6aqS1NzSrWxRxi7yZNfvem/KiXOR/9TBsuZZC6fuGgE4pTFCXQtzIs5OIzIdl+FK3KLbMFZwWVibn1ipQpjIawtrHm4H5raxvcwjByHaJlQkbVqiIB5RBlQlHAHOHdyka11aTN1pigicgkbR6TR8jVIefppuY11iDkM0JsSi8f48vGMjFd2h5oDla+gOBNzrCfLsn1/IOUO69bDcCkfdBVYYIaxax8gA6KWjoxQKR7JStNgi09doXB2erSHqNDCRtELYiuThh5PN0GVjOYmMTrv464X5CeROed8Bl51T2HXwAcP+0xYnS2FeulbdP6kXSbhgf0RIAREzD7erNa03u5ygVqZeJ++4SvFoBxpGYtNCfl/ZxFX7gIjV/rpLwWQJ8tPE8Uba+NL2oW90FDuPeEhAyv/FcLW2jQEVhEhBc1EUG4S6qi9FMM5sDGwNh9yrwduA6JNL9dJTsoIQrKQUYeZfODbxLps0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(5660300002)(2906002)(31696002)(86362001)(4744005)(26005)(316002)(6636002)(66946007)(8936002)(66556008)(4326008)(8676002)(2616005)(6512007)(6486002)(66476007)(110136005)(478600001)(6506007)(66574015)(38100700002)(82960400001)(36756003)(83380400001)(53546011)(44832011)(31686004)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHpxU2ZLVzlLdHVOV1l3Sjh0UEpRY3FiSHZSTFpzdmk1UTJ5bDZqY2R5TTNU?=
 =?utf-8?B?dWRaN2ZIcEN5MTFKM1VNbWhjRWRaUjNoeGhZNnEwNS9xcDM3c0NiTzZReUxR?=
 =?utf-8?B?bDRBSSsyOHRFRFpKU1puLzdFUmJBaU5jNnJkZ1lRbU9CVXdSYTd4V01ZendX?=
 =?utf-8?B?WWF0Y0xSUzBqbkpGenB0NnlWSER1UlJ0RkNhUTAwcU9vd05FeEU4ekh2UkJG?=
 =?utf-8?B?bVpwQ3lyUmRaajFHbkRkTUZIK0JZMzVXeGhpcGZzZEkyaVZXUktXSDNqT2FC?=
 =?utf-8?B?dVpOSWYwWlAyNzBZYUl2Y1ZXb0NxVlZBY1h0bXg5UWhEMjB4Tm9MNGRhZGh0?=
 =?utf-8?B?alJoZlllV1VnVjhiRHVDalM0L09KV2dueVZRMy9ZeU1CODNqVWVWN2JsQXY3?=
 =?utf-8?B?ZFUrNHpMa3pBcm1ZRlFURTdnTHNReDhpVWdRWlpmaWs5ZHJBblptOHNBb2RS?=
 =?utf-8?B?Qjg3N0RicFdtM0xMcWlHbE0xR2pZNzhydmFJaVdvYkhyVE03eU1JdFloSVRk?=
 =?utf-8?B?anhld1VOcGRRMlBRR2czOEFqZW12OStDU3pRUmF1ZS9sRzFXZDRwc21DK1ly?=
 =?utf-8?B?dG1qalVyKzAwWExvRTJ1S21rcE41RUR1K3pYTWdkM3FxSFFqT0wyV1gwNU8v?=
 =?utf-8?B?a21zbTRCd3dTei9Vc1ZqMVhuQlVpRlRPN0hZWkhTUXliRi9oNWsyZ1hpMUgy?=
 =?utf-8?B?RVpDKy9aOXVCYys0eWpmWFZhRUtWbSt5dHFxRENMRzI3cGF6bm1TcUwvY05k?=
 =?utf-8?B?VU9ZK1gxa0ZvQ0ZneEFIU1ZNUHZpejgxb3NzSldlaEd6UW1WWWw0UVZSSlNj?=
 =?utf-8?B?a2NZczdRc2VtOFBuWDQwYlFvZkNYMnVReTBKTkk1R2hSZXBMMFY1elRPZFFl?=
 =?utf-8?B?YUZZNWpvd0s4OGlod3JpaFlTTVpGeEhhb085SmY3aUhLQzhLa0p3bFhibmgr?=
 =?utf-8?B?N2V3UmpRbG04QnVyb1BnVnR1ZDVsVEZtNnp6RE9tdktybUNnNWlKdXh4UmVB?=
 =?utf-8?B?ck5Wb2dIRkFkVzV6SXFoM0E5ZXJjdHZRNkJydEYxUjh0ZGZFOXR2bU1IUnpk?=
 =?utf-8?B?cFFhM3MxQUV2U1ZBczVQRmo2RUxNWm9WbTlPZDkzVnFRNTBETjZQSlhsY3ho?=
 =?utf-8?B?N1prT1NqenEvWGVGVHN4Rlk4QTVLUXBRRUUyVWpFVTBqdnUvUUhoRlV0c2ll?=
 =?utf-8?B?Mjh0VEg0Z2swZjdZbWx6ZDVwelN3MHIvQnlVNW9MK3hPVjFnLzB6SzVpa3VK?=
 =?utf-8?B?R2Z3WUZhemRsQ3Mwc09LQWhZN293K3AyYmNWVlluRll3UUNiY1Bac2lWdndr?=
 =?utf-8?B?WC9nR01KSEIxUXdpeTVIT2RtMXlGM1FWQmcrdDRNaDNxNjNuSHA0YUN6OVVq?=
 =?utf-8?B?MEhPZmVzYjRIaXZCSWtQb05zYjU2KzYwK2JPNWFSSXU0VlB2MEhpZWhyckNT?=
 =?utf-8?B?a25BYVlVdzZGR0VrZkJQTVM2cTgzaDRKNXlHbS8xTHFyUEhta2Rsb2VHQVZZ?=
 =?utf-8?B?c1RSY2VhTTNCWU8xYmNrcWNYdnZYSDViMDEwbGpzNWlZbWZVSVdlLzdCZFZ1?=
 =?utf-8?B?VDVhMHRyeFFzZlBRQWhsTXdCZ2NGd09hSmptWktXNC8rMTNBczQwb29vSWJK?=
 =?utf-8?B?RlMrN0RPSkxpc2V3RE41T3FjZ1ZGTXpOT0VOSGRYdnJ4VEh3TjVlbUdkMEdP?=
 =?utf-8?B?L1Q2Ni82V3pEMThGTThrVWRZdnUzQ01GME45c3NWZFltL3o5YWJuOFBGYjcv?=
 =?utf-8?B?ZDl0VlJKNXp0eXdPTmlCeVRtbllua2RXNGtpd1VyMG5sK2pncGUyeWw1UTlE?=
 =?utf-8?B?OVM0bUVEaVMvQTFrdGlCTWVtSFNjS0lEQWRDWnlsc1lXZ0lWcGRxMEordjZ0?=
 =?utf-8?B?OGJiWjFneHRMRWs1STEzZmJUSnNXWktwU1djci9wTy96U084VVhSbGtWQVJr?=
 =?utf-8?B?TUdHcmhYVS9PMXM2dDBzQ0pkZitwSjEzQWthaEV2M3k5cWtGRmQ4eWtkTjFW?=
 =?utf-8?B?YU1DKytnLy9md2cwTmo4c1dRUXdZZzB5cVpBdWU1VUFReVdjM28vaGcyVHB0?=
 =?utf-8?B?OHljOHJQL3BZZGpjWEE2V2pQUlFVS3F4ejAzeC82a3h6NWtQdFBTblpKQmNs?=
 =?utf-8?B?Zm5BR0VjQVVpS3dBYmY1TmI5Ni90WlovdXh6azhJUTExanF0dU5FSy9YcjMw?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d84f226-1092-469f-1155-08dbf05f9023
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 22:15:43.4912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NlI+kN4EcctGIpsRT9vkSNT77EyCGFHMM7dQRrE8CX085lzsf6gXBqXMiSrLTHFW/c3Drd0mc7s0ve1yp7yjpfVc5G3WUj/R0TWl2QJVxnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7419
X-OriginatorOrg: intel.com

Hi Ilpo,

On 11/20/2023 3:13 AM, Ilpo Järvinen wrote:
> Perf related variables pea_llc_miss, pe_read, and pe_fd are globals in
> cache.c.
> 
> Convert them to locals for better scoping and make pea_llc_miss simpler
> by renaming it to pea. Make close(pe_fd) handling easier to understand
> by doing it inside cat_val().
> 
> Make also sizeof()s use safer way to determine the right struct.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

