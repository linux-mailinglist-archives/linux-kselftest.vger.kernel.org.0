Return-Path: <linux-kselftest+bounces-757-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8907FC91A
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 23:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26A17B21184
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 22:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCB6481B3;
	Tue, 28 Nov 2023 22:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Muo3Rg3f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147D21B4;
	Tue, 28 Nov 2023 14:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701209430; x=1732745430;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uMAXmJ0o8oKHLdHnNCyvH2zcv+9b57aIs220819WuWc=;
  b=Muo3Rg3fqlT14ihWu624maw+/RRojyxYFb7S5ZkZkGB5vUM05Wjl3nla
   76mLSC4aaCN58fdohCNGlVMxWKkeflTd67o1zYAFU+kifsKGk0/33A7JW
   4g7ZHTVAQc8oOo6CEwL3r8K3lnYoyiE9r3akyJ9+47Z0wXvN/QC+Uvf4a
   GBRUkIdKJHJieAXPupjJagmKTfchhewOQt9Z70aXtD5nLLKd11/7k0+xW
   +WtfSTxc5bsIk3ZZ9WeujFtlxOUSO9mbh/CT3StSz9qPO6az0daq9ruWT
   7R1V5iZfVjmDo1Wv9dUbhfaUnXwIG3T4PZRfw9PiTwlZg989pO1TdeBqt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="459542708"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="459542708"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 14:10:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="768680126"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="768680126"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 14:10:29 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:10:28 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:10:28 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 14:10:28 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 14:10:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdtexGDlBQjMTn8bfYvwIIK83c2OJtTOrs8bbfQBJ4RNYajvwTXGGg6eAW12IHKTpIN5QMxryCdbyxvGR2owfZ/SPDLafV7ahv2gJ1zRtJcuus3Yl3npXeRIYIBateyXE/YrG8Ap2J0BHurRaj/dLXV1LZ37K7YkSx/vne5tS+D9LJwPQMniocxRUYxXzHOv/LyMEzxcOqVd3R8LvzUcTnPjIKGCTbdz71I193MN/pGzfj7E3nmW/2ePsJHOtM3KNdWPZpB72bVu2X33F4OnbO5Tc7wIQJjcQnTeZR1AdiCqWX/tXyI4eVCh/reiNaNU37aipLjH0ukGVzwJtplJpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkLyrDFXPlNd0l8Ej3D26wpoopNsXnfDLqhsPL8q3Ow=;
 b=RmDWK381QiO+mcYs9jKtOEgAuQP3uOfCM6jqWF0m5ajUn1wR3wuDLSeIATBdhjsHqTmbOPGMZKV9KsCToq5UhcrIR5T1ZRVfrdFCC2n5/j30uWB2aCplCV4eIezHSQlKsivE5+cUzVX1+nJP5rYxr8US+NLzWyWjnBFsREv9Og86nU2hkAanPKWvyDrLW834vT6KoSwOLDOibL7lS4Ivxf+cz8NWMYxiur9+LJd5PARn3XcsqSZBHwQEpLlGpTvTUOhEvb9Jo6oaxaupFnPM0ovzhb2BsdylukQ9GXZ5UzigWBJgaPTGVpRPXPdMNOgnQxwZPSJUHQ0gV8IE5s3u2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB6328.namprd11.prod.outlook.com (2603:10b6:8:cc::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.29; Tue, 28 Nov 2023 22:10:21 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 22:10:21 +0000
Message-ID: <356eb613-a380-4389-96d3-f2667b7d18d3@intel.com>
Date: Tue, 28 Nov 2023 14:10:20 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/26] selftests/resctrl: Split fill_buf to allow tests
 finer-grained control
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
 <20231120111340.7805-3-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231120111340.7805-3-ilpo.jarvinen@linux.intel.com>
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a7d8ea-c430-40c0-2995-08dbf05ed01d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q9mU2ZHvuAocenzGaX7HQmrmbsEoeEFQl8xvCqhVseHoHjusnCr5GgCGEl9FNAyYXV7/3XIIFnvxSgMQJEtNKOp1LB0fzeOkBhtB5JcYcWa+aJXhGg3cd4MPvGCo4QHE4q+5va4arUadFcezzR490oGNGD+dDdNGewod3WYsbfygLJK90hPjvFdCjn2IIocqxjSrL2cYBOB6YduBROGTpPaYemcyD10BEpjAYiOgWTuPDEt6KE6yx+TdhRyKCKMeZzaMayjan2gN7+jFsr2oAcaq7X0YmT9WnW49QFvOXvjOuCwXkN5meVphu5haDWM9wrKIoG/tG6ey/V0Gx8kLB9+TReOb/KSEHS/Hp1YvMuUKK5CV9nGkxIjeLUiKvzBYjXx9FSAMuRume/7lolRTL8qqVGslc+dz0d2XFlMDa0hZwIfPoP9n758bCjWe8q7CnCS0qdYYJiXTCgpJOjHGQsrMT9Te2Vy+zR66yhvrK4mhWfNQiI/bY+l2nb0bWq5lA4jZyGwrHedPnBFTGaBkfCEaFEkFhQj05a4IZL063y9k1tPjvfJa6IirOO3ywezUzQ1rOdkmAAlJ0ql1Rbd6V3S5QHqgpDZJNKzxxL3vfaUPPxOWSm0BCnD7v5dOnfUuH2SqrfkI4QXRQurim1wQhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(366004)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(5660300002)(44832011)(41300700001)(8936002)(4326008)(8676002)(31686004)(2906002)(110136005)(6636002)(316002)(66556008)(66946007)(66476007)(2616005)(6486002)(478600001)(36756003)(53546011)(6512007)(26005)(6506007)(86362001)(83380400001)(38100700002)(82960400001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2R3Vm91RVBtTjRCQ2tPL2JuUVlZdGxaajVvV1BxcWtZRHpwWDRjT0dYOXJa?=
 =?utf-8?B?YjNDK2tqdGdnazhFSW1sYVl0NWhjQ1JzRUNyV2FQVzFzejNGdGFMeUdmTVd1?=
 =?utf-8?B?OGE4Q0hyNW9hQzlMY1ZZYmUxUy85S0hTSEsyNEtLUmdrRFRXV2ZLN2RIdnhF?=
 =?utf-8?B?eWtDcUV5ZUdEcmk0VndJNEJXRWx2UWw5ajZRTHVRSDZHWDIxY29zY1ZNTUd3?=
 =?utf-8?B?WW1HR1h1UkU2L2N5dm44WDVkZGczeTJaSGtDdVRBdEJES0Q4bVZLcCtWeEps?=
 =?utf-8?B?SUVHWXBhRkpsdWRnWW1xa1lIVk43MFgvN0JCc3lPRWxwSjM5Yi9RMURmd05v?=
 =?utf-8?B?V2Mzay93R1d3clZGd2QxbUV4WGIxa0t4NEVVUUR3SXNUWktra2k4Sk5hZndn?=
 =?utf-8?B?bjc3YW0yOHFDNk15aXJLazVLaStVelA3SitrVklmMi9tL0VpZ3UrakFwNUNF?=
 =?utf-8?B?dlcySkpsYmlaY2xtNWFNNEZDWVZEYS9pM1AxQUJNRGtjVHU3czdMZkVrRlNj?=
 =?utf-8?B?UlJVeHBoSlFIa3dKTVVxL2ZDNS91ckhycURuc3RkTUV2ZWtmNlJPK1RrRjVU?=
 =?utf-8?B?ZWt4R0RoVkFRVFlIbzhEV1laY0VQOUkwTExYb2NIa2NtajAzVEdYL1pDb2Y0?=
 =?utf-8?B?REFEMTVvL1F1MFZpZUNHb24zNVVraXVIN1YzakI0TnhBTmo2Uk5oSHEwWGpU?=
 =?utf-8?B?d0Mvd3U1aURZaUJEUkc2dVdBZ1J1TXNRWW9zMnhBTmozcUVuUHJlcUxsTEc5?=
 =?utf-8?B?RE1GbTg5KzVpWlpINmhObUZhd05YZjROSXRMaFFWeUVjL0p3V1lJbGtEeEtF?=
 =?utf-8?B?Rk5LYmtuVDdjMVJiNUxoLzJadDdCb0lCazltbC92dmNSTkZMbUdtdVFLOFg4?=
 =?utf-8?B?MnduQksySCtVbTMwTmg5Q3FYZVBDVFhvcWlmZWdUVmNKV2JlVkxFRmRmMUx2?=
 =?utf-8?B?RjhHSTZ4bmorZnlVdFJVellGSzVSUm9BUHJsTWN1Wm01cEVsQmF1bE9yN1k0?=
 =?utf-8?B?K3JsR3JkaVZlaWM2Zzk0UHZmdnJiMFNDb1lYZi9PWW5VT2diZ3V4YmRBMEQ4?=
 =?utf-8?B?T05NbytMNjNiN3Joays5MzdqV2tUODdIeFhXTTVBUXh0b2ozcy9PcEM5Rzli?=
 =?utf-8?B?N3dtWUpxbFAvRDlIM0RtNGFRWXB2Z2VOQm4rTDQzbUpicFJubks0VDU1L01h?=
 =?utf-8?B?SHJPckN1QVAvelllSDQvellxQXJLRi95QytKLzByU2lDRzhhbEZ2b2xEWHlk?=
 =?utf-8?B?eXR2N0hGZDYxa2NpSEpIS2dRV3dsSC9QNmNKOG91bVlHQlVpenFmeVVXQUp1?=
 =?utf-8?B?OTVaMElhUk11ZjlzQjRoOElvZmozS3ZrUWZ6Wk5OVW5zQVh4QlVjZlB2d2dy?=
 =?utf-8?B?dWdYY1dnbEc1NWxVMnlzV3lqUmZyQWZzWUlFTVNIVjRIV0gxVTM5SDIvMFI5?=
 =?utf-8?B?UGl6UTR1eExOclg0ZTc4QkJnbzVmV2E5d3hhN0RpQjhQcXM0OW0wR2dvSklG?=
 =?utf-8?B?UlZDbWo4aEJkQWFyNGZuaHptcW42Y1E4QTN0TW5xNnNsODAxRS9haS9KVjlC?=
 =?utf-8?B?ZnF5d2pmL1RwdHQwZzVhODE0WWhZVFRQc0pCT1d2aGQ2RVZlQ09peU10QVlS?=
 =?utf-8?B?WmFOTkZsdmlQVzl5c2pmQjQ2WlMvdVI5WTJxYUdiWVJkTzBXekxQYkwvUW11?=
 =?utf-8?B?cDA4cDZYVGJtYjJzakd1cC8zQTE0SnJhbEU0bGtNeFZudGJ5YWxuNk9Yajdp?=
 =?utf-8?B?a2wyYTZCTUROcWx0QVZnUjJqaWErTnlQYzNFVFNaRDJDVDF0S0M0RWtpSUFX?=
 =?utf-8?B?aGhmUmNJNEJoWjRSQmx2bExaSFc5UVFtelRnRHpQMnRxYkNtZUtLV3Nlai81?=
 =?utf-8?B?QTBNUm5FRlhUMjRDMU12UVladWVqZXVUQmtoaUcrSW5DMjRIdkh1eXlDb1pR?=
 =?utf-8?B?NEhOcDlvWEkyTXVYUnRLR09Sd0xYVkVoU2tSQTR0OFFnU2FEejF4ekJYSkor?=
 =?utf-8?B?bU1DN2VzVFp4VjZTNXFDSHR6QWNUV3h1b2t3R0kxdUR4MkZ1MmVqWHB1dm91?=
 =?utf-8?B?OGZRTW91ODVSRXRZUjAvNjFwcHBpaFcvS0Y2VXB6U3RiQ2cvQ3RaRndpVU5B?=
 =?utf-8?B?UXRLT0RtTlV6MWliOGRHbEMyQ0FlQVBPcVNHbXVhMjdXbVB1TUt2L2ZXS3N6?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a7d8ea-c430-40c0-2995-08dbf05ed01d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 22:10:21.3316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a9/NSMNukg9oV/8kQ5DujvawZggAsCS5O62CwvFccSDcFxvfNpwtE8a2ctzEFiqFzh7uVeVo4mLIuhDhn8Zn09i+bUmFmQI8yNH2boYnybM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6328
X-OriginatorOrg: intel.com

Hi Ilpo,

On 11/20/2023 3:13 AM, Ilpo Järvinen wrote:
> MBM, MBA and CMT test cases call run_fill_buf() that in turn calls
> fill_cache() to alloc and loop indefinitely around the buffer. This
> binds buffer allocation and running the benchmark into a single bundle
> so that a selftest cannot allocate a buffer once and reuse it. CAT test
> doesn't want to loop around the buffer continuously and after rewrite
> it needs the ability to allocate the buffer separately.
> 
> Split buffer allocation out of fill_cache() into alloc_buffer(). This
> change is part of preparation for the new CAT test that allocates a
> buffer and does multiple passes over the same buffer (but not in an
> infinite loop).
> 
> Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Could you please list the changes to a patch in this area instead of
lumping all in the cover letter? Without this it is not clear what,
if anything, changed in the new version.

>  tools/testing/selftests/resctrl/fill_buf.c | 26 +++++++++++++---------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
> index 0d425f26583a..6f32f44128e1 100644
> --- a/tools/testing/selftests/resctrl/fill_buf.c
> +++ b/tools/testing/selftests/resctrl/fill_buf.c
> @@ -135,33 +135,37 @@ static int fill_cache_write(unsigned char *buf, size_t buf_size, bool once)
>  	return 0;
>  }
>  
> -static int fill_cache(size_t buf_size, int memflush, int op, bool once)
> +static unsigned char *alloc_buffer(size_t buf_size, int memflush)
>  {
>  	unsigned char *buf;
> -	int ret;
>  
>  	buf = malloc_and_init_memory(buf_size);
>  	if (!buf)
> -		return -1;
> +		return NULL;
>  
>  	/* Flush the memory before using to avoid "cache hot pages" effect */
>  	if (memflush)
>  		mem_flush(buf, buf_size);
>  
> +	return buf;
> +}
> +
> +static int fill_cache(size_t buf_size, int memflush, int op, bool once)
> +{
> +	unsigned char *buf;
> +	int ret;
> +
> +	buf = alloc_buffer(buf_size, memflush);
> +	if (!buf)
> +		return -1;
> +
>  	if (op == 0)
>  		ret = fill_cache_read(buf, buf_size, once);
>  	else
>  		ret = fill_cache_write(buf, buf_size, once);
> -
>  	free(buf);
>  
> -	if (ret) {
> -		printf("\n Error in fill cache read/write...\n");
> -		return -1;
> -	}
> -

The changelog does not motivate the removal of this error message.
It seems ok at this point since the only failing functions already
print their own error message. Without a motivation of this change
it is not clear if it is actually intended.

In any case, this looks good.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

