Return-Path: <linux-kselftest+bounces-763-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EA67FC92D
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 23:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F655B2125B
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 22:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0EB481C0;
	Tue, 28 Nov 2023 22:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IFa69wVu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4498CD63;
	Tue, 28 Nov 2023 14:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701209537; x=1732745537;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J/Oo9thLU5jNRCxG0HRZ/6yWZ3FLEXsKNQ8siKlEq5U=;
  b=IFa69wVuN2uKCIec6/oqZdypAgK/X8YhvQ21jKX/IhRXQ9mX0IxNmWih
   cCec1HPa17OQBh6setYlduGoCSlLtrdjX8Zyyx0WfYYzeM/8nk/8NNmxU
   XJaCJkOdIXH/UPnaMlOMt+wVHI0luObjNQtinCnfBVuVi6mhJak2xYk13
   JTk8QtyoywxxmLNOxe/wl/F3sE1tOBAmqqUMkojZrGujwj16e5CVKLXtt
   7bz1GhizblUeV8/2qGh17zTSW2nWtfSe5jYoCSc5QNL4D/0dMxgjPhmxM
   lkcqF9x2T2ePYtmH7vQJVtREbn0p5+8FMTv5PHFhGoCvoiV5lTjLumXQw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="479234191"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="479234191"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 14:12:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="16769380"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 14:12:10 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:12:09 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:12:08 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 14:12:08 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 14:12:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYq5vDQSS/41OccpSoDm5SWLNbxU3F3GXIv8LKNHrh4KCWh/j58qK2GsovZB7iN9sWb60SsLWdUwaWTMBr0euEu5IGU1tU0JONEOZpO9Vjih4Zl8Kpqi0ZhcQF7byJqeASMe3s4X6IJ8gEOFvDb59b/rkib+PiRMM1fSwu58UakpPhbxA3waBRrd+08d3NyHXM0dgnOR28irA0jsIAhNZ8Pttr4VZsjxXbe5xQRbVTtVAPOhn8MLnJJ937V701LjfLwlp910Si5iaSNXEEbl8F3rTxRYfxbQuAnrUElR00l8F6TUe1cp4PDhdV9HXE+4jCQDVbP6nSAkGYQGxukj0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhZlEEt2Li7BZVI89LC4VYfwkiw6AP58bqKyYFdMzkM=;
 b=Z+m8SfL+ZQ2vQJBPhH4DhJirot0RH+YUXK0/GEBTGxe+Bh8sVb/qxkszn6mqT2CL9LG6vWpAqZpn5Tkz9ZyNFxBOrW8GY7tbVJWit3s8pe1SNhAXQYuEGjD18GLMxuRANQ2UqSl1fZspgxyrvjZ+jwqF3AzYRiaG0pNz9pvn30c14XCxYFEOtTV+/YJrJhEs1p/xkUXp6BN07w6p/2Q8NjSl13504Ktu1IzreE4kFJ9yBInKf5318y/IYrrp00pTcThzKNAN9MnEzMHh+coP4J7r9/V8oyebb/RY7S9ebRxmo39MgJrwrBHPM/k6l3UOrZeaiffvCxctu4ZUGkWrDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB8284.namprd11.prod.outlook.com (2603:10b6:806:268::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 22:12:06 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 22:12:05 +0000
Message-ID: <4a8bf2e1-02e6-408a-85ff-aeaf66e1d700@intel.com>
Date: Tue, 28 Nov 2023 14:12:05 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/26] selftests/resctrl: Exclude shareable bits from
 schemata in CAT test
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
 <20231120111340.7805-8-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231120111340.7805-8-ilpo.jarvinen@linux.intel.com>
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB8284:EE_
X-MS-Office365-Filtering-Correlation-Id: 1919510b-66af-42c6-e1f4-08dbf05f0e6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nQOp6LEGrTAJFIlr1Md8Rhj/ATeGiAtKm2fLRjaT6KFA0VeRaeOIwr8gmgSDVGyMQnVb2THqd5KGDnc1UYTRG7T6nNIz1xNXhAPugqhfXAU4A9GrloQC3nMgaFzAF0cLuJ+0vTjMZhzJs6QekpgGhpzYGN7owkfA14PPd+uztJVdUUbtq6kVjMrwD0JCt172X53tbkPXCDJ2P3sjPH3MEF5npFrMr9WtmZ1984Wzh8+eMqoOXg1/b2f3NoU4NkyGQEUtKSQfz5iKboWgvY/UmsoJoyW3ZVbwj3A01h4UjfbgDc0C3agdE48us23S/YKt+thGmeDxFvWI/iOMNtTlnwhGa3qxtlb5hHoEEfze56EALNEdKBqoQtG5j7K3dH5VHoM1tm/nng26byXVbwaG7LGWarSXQtinoTa7Mz8I7knW6DBaDkrwt9VAJHyg2bSwW65V69t41FLy0sJI8Epx7qwSz1JagLXPBepieNoyw9l9KEUDvqvBHUqGeN/OiQxoTTgBD1GdAl/GbUUNb+K+kA3Rn05iwQgPcS/GH+SbjCfqVTPf3yiJoIV7za6qS4hp4UncuqP8PnU/dWbmId2hW4+x81JuP1wXITyYXMGuQsORHPUBRkUERZK2I83qF5zY9YzBUQscLzVqI8meSSumzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(5660300002)(83380400001)(38100700002)(31686004)(31696002)(82960400001)(8936002)(8676002)(66574015)(110136005)(66556008)(316002)(6636002)(66476007)(66946007)(53546011)(44832011)(6486002)(86362001)(4326008)(478600001)(41300700001)(36756003)(2906002)(6512007)(6506007)(2616005)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHRLckVCU2t1N1VDTEFTTzFoaHZ3ZUg3RmJ0TjR1TWpzSWM4N25IWFliajkr?=
 =?utf-8?B?OWRwbmhKSlFPSFJ5d09kN2dTTEJiSnNzYnRuY3lwNXRPVkJMNjNXVForMDla?=
 =?utf-8?B?SVZONWtqQnJ2M3hTd2hDdXpzNnRvWHI3bktXSTlVWFJlekxFSmxaY291eUpn?=
 =?utf-8?B?NVMzTHdFdzIrQmx0bEozRHAvRUpIcTdQOVl5UlgxNnBzSDdockV3a1cxSDJl?=
 =?utf-8?B?TjBzU2JUOWJkMFhuTTJIbEtDZXkva2lveGZiTTJyNFlBWkU5eTVsZDNjdlhQ?=
 =?utf-8?B?a2NXZlNBUDRnN0gyVS80Zm1Vd1FOa3lUQzNrcGdzU2NZQ2hoWnZrVWwySGdH?=
 =?utf-8?B?RTl3eFQraXIrNlIwNGdoUitIOEVqUStHUCs2SVd6djdEVmtMa2p2MmgwS1Fs?=
 =?utf-8?B?Qm1RaWRmakVCa0N5bjJ0L2hzaDJpT05WSWY1Tk56YmI5MkRCQnBtTmJESklC?=
 =?utf-8?B?YlRwbEU3N1NBYlBvNUlMbk5sQ0xaT0gvak9xeG0zVWt2UmFadnVMYjRUNXRo?=
 =?utf-8?B?dzFiakZsaWJLL1JGUkFFenhlZElHWHlPNE56ZXJFUXZrckFhL3NvdjlhckRN?=
 =?utf-8?B?Y1Y1dFV5aHE2Y1JiKzdjbFhvdGwyZEZId0NQUXN0M1hGL08ya29mMUpNejY2?=
 =?utf-8?B?US90aGhOcWpDUlhqRzdWT0VsY0tmVzJmSEdaOU1xYVhRak5LZEQxNVdIMFRh?=
 =?utf-8?B?bmtKRjE4QWhBVVVOR0RIcmp3VXNVVWJpWkpxQ2I5eTVlSk5kMFZSSkl1djN0?=
 =?utf-8?B?MVo0QmMwbUNINTFFa0dPOFVTSk1GRGd3M29aQzk2a3Z3cjF0azQxL29GWFZp?=
 =?utf-8?B?b3o1OERHSEdoUzE4SHQrYXJZdWcvQi9DellDWkdabGdkd2NCWUR2UGtIRkdt?=
 =?utf-8?B?UkdTUWMxTVpqSUJHSCtwY1ZmQVNWS0tRWnRBM1p0ZXE3Z0tOQlJjWjNaSXRj?=
 =?utf-8?B?b1dnQWpGc2pXUklTR2xxSE4yeEVnRTcrUVVDUXVtckZoaVJIdGJFSXk0TFd1?=
 =?utf-8?B?RklrOHpzZ1hjVGcrYlAxN0hES21nR0tCWHBTbkZkaXVRejQ1K2h0blhwTDQ2?=
 =?utf-8?B?TDh5MFBBYjV5MkVIcnVvdHFaYkxXUU40dzB6MCtOVzNVcDFBWUhuYnhTaEdu?=
 =?utf-8?B?Wi85R3FDMTdIL3RmTno2OHdOYUEvVkxRaURZTXBRcVNzU0Rhb25vWWtkci91?=
 =?utf-8?B?bzFteDM3SEM5RWRDK0VZYjZJWEdIMHIzWGZKKzVaQm1iUFlGUTdwektHQTBv?=
 =?utf-8?B?UFVISzdZNWdIMTBVcEZaMXc1L1M5Tm1TUjEyRDNRZ3MxRS9xbWcvQmtHWVJR?=
 =?utf-8?B?VFlaR2hvSjB6bXhveEtaMnVzYVBIV2xnTnNwTHNrTEQvckxCYVVkUXJFSnNK?=
 =?utf-8?B?Z1dvMER3VUlBaEVsODd0Ym5PanhnbFRQcm0xMllOS3hBWGhTUzZtdnFrSENn?=
 =?utf-8?B?OFA2VkMvaVRlWTcrWVZpOCtkODlXZS80NEJLeC9kTnhIaytQSHB6eFFlUHg4?=
 =?utf-8?B?NW8xUkxSZHVGbTZRVTY3WTl1S0ZLTEd0aDZGditnd0VGTTFFTENNUnJuUG54?=
 =?utf-8?B?dWY2RFNqZmh2bk9pck1MemlBVDVkaVRSaXIrc1VtVFZ0L2trUENDNmx6b3Uz?=
 =?utf-8?B?blJleXZES3B2bzhvT3R1SGViTkFWTHVrNjNCdnpWK01hdkNYeVZkMXd1b3Bu?=
 =?utf-8?B?emh6RHJhRldLQzAreHpDd2dFRFQzVXBMK08zRXM3bVBwZUMwd2daTHphekUv?=
 =?utf-8?B?ampzWnRoVkNjWjVsd2NIaUZvMndtN3Azdm9rdWNaZzlZNFhDeDNnMVorWU5l?=
 =?utf-8?B?VjYvYmhqamxWRklBUWR0YlN0RWRSdDdZbzA4MmQwVlQraHVMZGk0dzBNeGF0?=
 =?utf-8?B?S25DaWVNK0l6ZVBYMW9QTmltejUyY3FUSk1tdGNELzcraDg4SzlvR014Kzh3?=
 =?utf-8?B?cnhXalhTcHYyWnJKSHNmN0RxMVQ5K2hHVjFJaCsvaXovVGZYQ2hmNndqTVpX?=
 =?utf-8?B?eXlIR3pvckduMDNwZ0p6ZitkNnM1QWhQRTlOclFWVXlrRXJETXVPY0JPYUQ1?=
 =?utf-8?B?TGZGZTd3S29kWTRLeU5qZ1dETVliVmw5YWp1ZjFOQ0ZkcXJjY2pFNWhiWGlJ?=
 =?utf-8?B?VGlibnRHcFJ6ZVZHRE5ra09kZFNCV2hWUnpYNDAyUFArUUw3VVR5NXVjdlUw?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1919510b-66af-42c6-e1f4-08dbf05f0e6b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 22:12:05.8858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +M0pFR9/sWnwRn1dsvN0OKDc56Tkl+v2tYREB229xRQldMp+zOrDYdVUz9TtSkS5tMd/Ep3I/Sm6U8gQKFJ6ykvg7MDWIb1qC90Ed6ZAfXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8284
X-OriginatorOrg: intel.com

Hi Ilpo,

On 11/20/2023 3:13 AM, Ilpo Järvinen wrote:
> CAT test doesn't take shareable bits into account, i.e., the test might
> be sharing cache with some devices (e.g., graphics).
> 
> Introduce get_mask_no_shareable() and use it to provision an
> environment for CAT test where the allocated LLC is isolated better.
> Excluding shareable_bits may create hole(s) into the cbm_mask, thus add
> a new helper count_contiguous_bits() to find the longest contiguous set
> of CBM bits.
> 
> create_bit_mask() is needed by an upcoming CAT test rewrite so make it
> available in resctrl.h right away.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  tools/testing/selftests/resctrl/cat_test.c  | 12 ++-
>  tools/testing/selftests/resctrl/resctrl.h   |  3 +
>  tools/testing/selftests/resctrl/resctrlfs.c | 89 +++++++++++++++++++++
>  3 files changed, 100 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index cfcdb7bd600f..2c8b37c0a179 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -89,15 +89,19 @@ void cat_test_cleanup(void)
>  
>  int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  {
> +	unsigned long full_cache_mask, long_mask;
>  	unsigned long l_mask, l_mask_1;
>  	int ret, pipefd[2], sibling_cpu_no;
>  	unsigned long cache_total_size = 0;
> -	unsigned long long_mask;
>  	int count_of_bits;
>  	char pipe_message;
>  	size_t span;
>  
> -	ret = get_full_cbm(cache_type, &long_mask);
> +	ret = get_full_cbm(cache_type, &full_cache_mask);
> +	if (ret)
> +		return ret;
> +	/* Get the exclusive portion of the cache */

How about:
	"Get largest contiguous exclusive portion of the cache" ?

> +	ret = get_mask_no_shareable(cache_type, &long_mask);
>  	if (ret)
>  		return ret;
>  
> @@ -136,7 +140,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  	/* Set param values for parent thread which will be allocated bitmask
>  	 * with (max_bits - n) bits
>  	 */
> -	span = cache_portion_size(cache_total_size, l_mask, long_mask);
> +	span = cache_portion_size(cache_total_size, l_mask, full_cache_mask);
>  	strcpy(param.ctrlgrp, "c2");
>  	strcpy(param.mongrp, "m2");
>  	strcpy(param.filename, RESULT_FILE_NAME2);
> @@ -158,7 +162,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  		param.mask = l_mask_1;
>  		strcpy(param.ctrlgrp, "c1");
>  		strcpy(param.mongrp, "m1");
> -		span = cache_portion_size(cache_total_size, l_mask_1, long_mask);
> +		span = cache_portion_size(cache_total_size, l_mask_1, full_cache_mask);
>  		strcpy(param.filename, RESULT_FILE_NAME1);
>  		param.num_of_runs = 0;
>  		param.cpu_no = sibling_cpu_no;
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 57fe42f4eda2..a911b08fa595 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -99,7 +99,10 @@ void tests_cleanup(void);
>  void mbm_test_cleanup(void);
>  int mba_schemata_change(int cpu_no, const char * const *benchmark_cmd);
>  void mba_test_cleanup(void);
> +unsigned long create_bit_mask(unsigned int start, unsigned int len);
>  int get_full_cbm(const char *cache_type, unsigned long *mask);
> +int get_shareable_mask(const char *cache_type, unsigned long *shareable_mask);

Does this need to be exported?

> +int get_mask_no_shareable(const char *cache_type, unsigned long *mask);
>  int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size);
>  void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
>  int signal_handler_register(void);
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index 1ea610fa65b1..3a9ed918d657 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -228,6 +228,44 @@ static int get_bit_mask(const char *filename, unsigned long *mask)
>  	return 0;
>  }
>  
> +/*
> + * create_bit_mask- Create bit mask from start,len pair

Please add a space after the comma.

> + * @start:	LSB of the mask
> + * @len		Number of bits in the mask
> + */
> +unsigned long create_bit_mask(unsigned int start, unsigned int len)
> +{
> +	return ((1UL << len) - 1UL) << start;
> +}
> +
> +/*
> + * count_contiguous_bits - Returns the longest train of bits in a bit mask
> + * @val		A bit mask
> + * @start	The location of the least-significant bit of the longest train
> + *
> + * Return:	The length of the contiguous bits in the longest train of bits
> + */
> +static unsigned int count_contiguous_bits(unsigned long val, unsigned int *start)
> +{
> +	unsigned long last_val;
> +	unsigned int count = 0;
> +
> +	while (val) {
> +		last_val = val;
> +		val &= (val >> 1);
> +		count++;
> +	}
> +
> +	if (start) {
> +		if (count)
> +			*start = ffsl(last_val) - 1;
> +		else
> +			*start = 0;
> +	}
> +
> +	return count;
> +}
> +
>  /*
>   * get_full_cbm - Get full Cache Bit Mask (CBM)
>   * @cache_type:	Cache type as "L2" or "L3"
> @@ -254,6 +292,57 @@ int get_full_cbm(const char *cache_type, unsigned long *mask)
>  	return 0;
>  }
>  
> +/*
> + * get_shareable_mask - Get shareable mask from shareable_bits
> + * @cache_type:		Cache type as "L2" or "L3"
> + * @shareable_mask:	Shareable mask returned as unsigned long
> + *
> + * Return: = 0 on success, < 0 on failure.
> + */
> +int get_shareable_mask(const char *cache_type, unsigned long *shareable_mask)

It looks like this can be static.

> +{
> +	char mask_path[PATH_MAX];
> +
> +	if (!cache_type)
> +		return -1;
> +
> +	snprintf(mask_path, sizeof(mask_path), "%s/%s/shareable_bits",
> +		 INFO_PATH, cache_type);
> +
> +	return get_bit_mask(mask_path, shareable_mask);
> +}
> +
> +/*
> + * get_mask_no_shareable - Get Cache Bit Mask (CBM) without shareable bits
> + * @cache_type:		Cache type as "L2" or "L3"
> + * @mask:		The largest exclusive portion of the cache out of the
> + *			full CBM, returned as unsigned long
> + *
> + * Parts of a cache may be shared with other devices such as GPU. This function
> + * calculates the largest exclusive portion of the cache where no other devices
> + * besides CPU have access to the cache portion.
> + *
> + * Return: = 0 on success, < 0 on failure.
> + */
> +int get_mask_no_shareable(const char *cache_type, unsigned long *mask)
> +{
> +	unsigned long full_mask, shareable_mask;
> +	unsigned int start, len;
> +
> +	if (get_full_cbm(cache_type, &full_mask) < 0)
> +		return -1;
> +	if (get_shareable_mask(cache_type, &shareable_mask) < 0)
> +		return -1;
> +
> +	len = count_contiguous_bits(full_mask & ~shareable_mask, &start);
> +	if (!len)
> +		return -1;
> +
> +	*mask = create_bit_mask(start, len);
> +
> +	return 0;
> +}
> +
>  /*
>   * get_core_sibling - Get sibling core id from the same socket for given CPU
>   * @cpu_no:	CPU number


Reinette

