Return-Path: <linux-kselftest+bounces-1873-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30959812112
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 22:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8730428270E
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 21:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CF77FBC2;
	Wed, 13 Dec 2023 21:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bdn4qks8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E42E0;
	Wed, 13 Dec 2023 13:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702504773; x=1734040773;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=99csRUN/INXJSUkMiziUJt3IOhapRZKiDQW37ke+isY=;
  b=bdn4qks8puE5XbZSlsPjlLGTmpWSK50DNnLmzJVj1FMudLRyPF71dYwm
   anoo1MVL2kOvl2aY8mJjdYQ7DxzToZsE3p+Y8qD0NPh9eAA+3GrNhpfYg
   PptH2tbQb9sOg6y3t6T5/XCmoH7OJxo0cA1WnAbnB69SaTu3FKtTJY6qi
   JXXWc2gv0A4bbzoDEY/HtvFKGdQorbjnC18jnTlgQZgAx8l5Y10ioB8jg
   42YjOT8zz34RwWaha4OFrQdiGahMBzP6og4FLg2iWxKUtKjAJNr40k7I0
   ricW1zN0IhBiN26GyoZDO2zrgRS3Lzk/vr6ma1Zr3879O/vWiPzXGN5VF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="2204272"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="2204272"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 13:59:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="947331564"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="947331564"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 13:59:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 13:59:31 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 13:59:31 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 13:59:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwdsmMmNxQuf+agTCc47spNFZoP43T7xoTMfCNk060qQBAwd+mZ2W3VniIDM8u5+9DFYiGtxkyV+BIDGM+QZz4AjqOg15GY8J74oHrU+tgmzpl1KJ8pwM1serVwvrVgd0T8nJKQ2BLvqMvC2ao0XdUXQh6dfKbMW7d7bhZ+/sEjj3/taIhfa1RES46rJqeKIEX250PEexZSEj84xDHIdXZEbHY14oBPc7XfXs2/jdRKc18M+RHTx7LOekKUzlen2S7sxqw7F1luRn/OiRHfkAYjru42mPUZ+Lo+t9BCdJjuCgexQChJawSymDYClNxn7pzZwcs1RmU6QqggM5jMTUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdX1hOXNO4A1snTS2YWnG/uXHbvY0UYH6enY01KQcwk=;
 b=M3izsv9TrxWQlZhr3KXoHY36hTrOQZpax9/ee9rDssbPvhgKs2ykEdMbWHPdTSKcGLJzsl1ct/nDP6Y9KIwnARJz3kkSIOJvxyj0cmIXFraQ62dad450dlaGVreSMNb/F0/R1mNabmbJzIZ6nKsDnWS73IpfPdf3QHkaHAWWQS8viC1h082La1eVSbTaQuXk/7FjkkBmDmRLGz8q204kMxynsE2ueN5vU6wATe9Dl+SWBThJmG14zOCKLpgRq0dlPL/ZSEZapipCkIJzln2TuscHOSdkdFeyAaVmYvX23I4ftxst1fbuJWjnvg06g7cPr2+RVMAey/tY0StLhrPRbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5925.namprd11.prod.outlook.com (2603:10b6:510:143::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 21:59:29 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7068.025; Wed, 13 Dec 2023
 21:59:29 +0000
Message-ID: <04650d92-fb80-49e2-87b7-4f9dbec922b8@intel.com>
Date: Wed, 13 Dec 2023 13:59:19 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 23/29] selftests/resctrl: Restore the CPU affinity
 after CAT test
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
 <20231211121826.14392-24-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231211121826.14392-24-ilpo.jarvinen@linux.intel.com>
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c513e1-3996-41fd-0a79-08dbfc26c7c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MEzoi8D6sw4JJCCdcAufwzqI13rS5cummeKB8KCEr1EYCcuwPe1k1v0YoLK0tWNQajd16tS1rA/3XYTDUNOuwUGrFYKMKvXmLUrNa78kZ0CDeUMPrmjvVn6Fhi0kpUnb4wjgoLah9BMEVpucAyoI32qSvgumA9V+BP0n9fhv3IaGsp1BsXGsLsIsHDoJIR2a8t+AVZAtd97CqmtJwjCNI6Tj8CkVOcNYWUD+1MJ6G6noq+KmRVOl44JHopToGuMdXUIL2mSVm+sE5CFBpYdCyu175gD+jm04mpEk5ZakMovoQJvi4jvhgk9ng41CmJxVzyzHu1f7gEgp/lLJD0WMlpVi7pgyhBsIjamy8cJOyc1cVOk/JikKdoF35wC4yH+jKfp1OoFIbA9R1XiN8Y/6wpgYJVl1dvxcvGXlDKcTkk/+PKQlZBdNhcTgFsMxJnDO0nA9hSsjvJAg0YdPuPK3RUzWVj+un6fzhKLYyaBF1eiRkvHOUGKxprXnnQTForLKqgtLL7Ci1iPP9++oY/X/VQNCOl/gg9csIz/mKCw/bujiScF/qkC3w/lwJKc1CjzHeH3c+b56839omBl21AIkN6B/rWYHHZ676a5vLJkNnaHGioOC+yZALWF+ShD9WxC5oumiXoDJjlGFF3UicpPbfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(376002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(66574015)(2616005)(26005)(6506007)(6512007)(6666004)(83380400001)(5660300002)(4326008)(44832011)(8936002)(8676002)(41300700001)(2906002)(6486002)(53546011)(478600001)(316002)(6636002)(66556008)(66946007)(110136005)(66476007)(86362001)(31696002)(82960400001)(38100700002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0N4M1pTZTVrS0tkRUcwQjFSdjRXYzBYQ2k0ZmNVUUNFRHIzNVdyZkducHh6?=
 =?utf-8?B?QSs3N2JCZUNPOGhHS2tuUkRsWkthek81ckYvSHcvaTI4MThzYlFpMnR5TTVa?=
 =?utf-8?B?L2gwb0VwZ2UvMFVzMlpnRlVGUjNrR2RCY1VvaTh2TzNBNUpCV0RZaHpQYlF6?=
 =?utf-8?B?M0V4c3prd0RYVHdJYkxqOVdpRUR0NTZvZXBqSFZVSnQzMWx5bnE1UXR3NWE3?=
 =?utf-8?B?RXMveVYvejFZTThwL2VZOVBZaFdpcEIrS3p5eUxXcE9keHNnZ1hhNThVdzlN?=
 =?utf-8?B?K1ZsSXlMNzFnYk9XN05Ua3N0V1RZc1hqT2toc2QzTG9peTVtdlF1bGNkK1JJ?=
 =?utf-8?B?a1c5bDdua2h2alFoN2lhdkl6ei8zUndmVWFGdkpJNjh0T29TTndzcC9qYmRH?=
 =?utf-8?B?eUE5ZkZrV001aHRtckh4RUJaK0JTK0dVb01mcGpvOGxOSlVlbU9RNTFWcXc2?=
 =?utf-8?B?cVdrQVo1SFVXVzU4TnlNTWw2aWJHanlpVEwzOUlUU1E2dExwRFBuSHZ3SXg2?=
 =?utf-8?B?Z2w4clU4MlJlMWt1ZkI3T3hlQ1BzaFJnaWtCOTJ1ek8wQ2FsYUp2UWNuQVZW?=
 =?utf-8?B?akIxbUpXUlNHL0t3Z05LUjlla3VPbzk1cExheXRhZ1V4ODRBTXMzTjRhQkFV?=
 =?utf-8?B?TmUvUmd0L3NlTDQweTVHR3FnOW1BQWYvYnhic2tRd09QOTRRYXFtZDdEYWRt?=
 =?utf-8?B?clQwWGtySkRnUVNoQ0xlY2dmd21RbVgvZ1VSZWJFRlk0aDJqTmg1Z3NaYXRP?=
 =?utf-8?B?b0VNU3FJQ3NmV2s5Z25oR1F3ckkyTmJ0Q3FxNUlkVXRlMVB1YnU0WWcrWnk4?=
 =?utf-8?B?bUpjWVpWU2ZpL25yaXhwbnFDUHdUV2x2d3ZSRWRRaEJjVDVUY2dwdldiUk9H?=
 =?utf-8?B?TEEzUERzK2ROcHVWRWlXSWUvNjhCOXZxNk9HUEFka0ZQM2s1bUhmU0I5eGdh?=
 =?utf-8?B?L2MzV2Z5dEg3YzZ4Q3E0eWdKUFU4RTljd1BrejVRMEphQlFVQ2ZPU1hmWmQz?=
 =?utf-8?B?RjJLa0NRR0txOGxHc0hmeHVwRXY2SGVTcDBpb01Ucjh0RDJRWGZMT3RwUTcy?=
 =?utf-8?B?MGp3eng3QVVSeFkrN04zNTVpc25tRlQvdnBMVDIxSXBPdExXUUVJdm1XNnZ6?=
 =?utf-8?B?WStnRjBJTEZ6QnFlczYwM0ZUTURhL0s4THN2L3FWNEx5TTh3bVRlMHFJMTlO?=
 =?utf-8?B?SEgwRFYxTi91SE9qSkYxYmt1NXp6TWRjbkM5Uy91RFhSQk1NMGluV3I1cGc5?=
 =?utf-8?B?bDJ3d2U2Z1R0QldOWmFwUHRjcmh0bWc4SVlMN1ZZRWRIZCtKVFdhdlVnWGh6?=
 =?utf-8?B?WE5SWXFySENXNUZmeE5jQmNtemVXSVFNbW5zYnl2Z1RoZUFCYUVZbnB4Y1Vv?=
 =?utf-8?B?eGVMeXhNSWZ2RC9DcElpVURYTllrZjgycTU4OWhqT1o2WktjcGRyWGlQbW95?=
 =?utf-8?B?MGk3Uy9Dd1U0N2lwQzRSUGVnQWRaSUpIUjhkbXc0YjhScjM1VkNsS3IvenlZ?=
 =?utf-8?B?T3duTG9rc3pOdUw4eXh0YzBpRC9aKzBhSk9JdEVwZWZGMXZSMm1zKzgrbjdD?=
 =?utf-8?B?akdVclBrZVVTcmhnR2ZGVE80ai81bWQ1U2g1Z1p6ZzMwVVVmSStqZVpKNzZI?=
 =?utf-8?B?V2tZMFZMMWI0c2swUXh0T0hiWmRQM0FyczJqL2NrdkU5UkNCOVM2SWlaKzY2?=
 =?utf-8?B?Qm1PcTRqTEQwZ2hqUVgrUmZNR0dJdjd4bmZDSnpZVE5XdDFQb29wK0cxYW5i?=
 =?utf-8?B?Y0NlTnJkcW9MNzViSHBRUHZZVVM2R1JHc2o0eTNwU1RmYUx4YlFRdmVGV0V2?=
 =?utf-8?B?TWgvei8vSTIwalZtWkxOdzhIZFRvUzIxRi9SUmRpeUlIbVkvSTV5VTJRVE1Z?=
 =?utf-8?B?VGFyOFZQMU1HUXZzbG54TW5ZSE4xbTJOeXN1anVFR0NvbnpESWFCWERlajdB?=
 =?utf-8?B?WGIyRTBuRU5MZUV5amw1eGRmeGEzR3pucGRLbDREdUlnUXRwKy9ydDFpMlJy?=
 =?utf-8?B?MURGQm1DTVJVM3U1UkpoVUJ1R2V2NWNialplWGozRWFXeWxoL3BYaXh4TDlu?=
 =?utf-8?B?OVBlYlJDeXJjSnp6YW4xOVhMMVVrSjJvdlNrMXMxeEo0UVpZR29LRWlRZ2RS?=
 =?utf-8?B?VEtuZlZ4MGczNUx2MG5KWnpvQU5nY1hXTHY2YlRhSERNTWc3UXpKbkd4V1do?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c513e1-3996-41fd-0a79-08dbfc26c7c7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 21:59:29.5394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WA0EwAJzknR3cKdRD3vq44C+v6Pao5/zPJCHRW6cJo6UKswPHKyZyCuKRRR4TBMtaYlBWwZla2RzgAteMKAKWYl5Bik9Hvi9BDLU4jHZoE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5925
X-OriginatorOrg: intel.com

Hi Ilpo,

On 12/11/2023 4:18 AM, Ilpo Järvinen wrote:
> CAT test does not reset the CPU affinity after the benchmark.
> This is relatively harmless as is because CAT test is the last
> benchmark to run, however, more tests may be added later.
> 
> Store the CPU affinity the first time taskset_benchmark() is run and
> add taskset_restore() which the test can call to reset the CPU mask to
> its original value.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> 
> v3:
> - New patch
> ---
>  tools/testing/selftests/resctrl/cat_test.c    | 13 +++++---
>  tools/testing/selftests/resctrl/resctrl.h     |  3 +-
>  tools/testing/selftests/resctrl/resctrl_val.c |  2 +-
>  tools/testing/selftests/resctrl/resctrlfs.c   | 33 +++++++++++++++++--
>  4 files changed, 42 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index b79916069788..fa95433297c9 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -156,6 +156,7 @@ static int cat_test(struct resctrl_val_param *param, size_t span, unsigned long
>  	char *resctrl_val = param->resctrl_val;
>  	struct perf_event_read pe_read;
>  	struct perf_event_attr pea;
> +	cpu_set_t old_affinity;
>  	unsigned char *buf;
>  	char schemata[64];
>  	int ret, i, pe_fd;
> @@ -167,7 +168,7 @@ static int cat_test(struct resctrl_val_param *param, size_t span, unsigned long
>  	bm_pid = getpid();
>  
>  	/* Taskset benchmark to specified cpu */
> -	ret = taskset_benchmark(bm_pid, param->cpu_no);
> +	ret = taskset_benchmark(bm_pid, param->cpu_no, &old_affinity);
>  	if (ret)
>  		return ret;
>  
> @@ -175,13 +176,15 @@ static int cat_test(struct resctrl_val_param *param, size_t span, unsigned long
>  	ret = write_bm_pid_to_resctrl(bm_pid, param->ctrlgrp, param->mongrp,
>  				      resctrl_val);
>  	if (ret)
> -		return ret;
> +		goto reset_affinity;
>  
>  	perf_event_attr_initialize(&pea, PERF_COUNT_HW_CACHE_MISSES);
>  	perf_event_initialize_read_format(&pe_read);
>  	pe_fd = perf_open(&pea, bm_pid, param->cpu_no);
> -	if (pe_fd < 0)
> -		return pe_fd;
> +	if (pe_fd < 0) {
> +		ret = -1;
> +		goto reset_affinity;
> +	}
>  
>  	buf = alloc_buffer(span, 1);
>  	if (!buf) {
> @@ -220,6 +223,8 @@ static int cat_test(struct resctrl_val_param *param, size_t span, unsigned long
>  	free(buf);
>  pe_close:
>  	close(pe_fd);
> +reset_affinity:
> +	taskset_restore(bm_pid, &old_affinity);
>  
>  	return ret;
>  }
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index da1f1b508aee..da62f4cd5add 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -98,7 +98,8 @@ int umount_resctrlfs(void);
>  int validate_bw_report_request(char *bw_report);
>  bool validate_resctrl_feature_request(const char *resource, const char *feature);
>  char *fgrep(FILE *inf, const char *str);
> -int taskset_benchmark(pid_t bm_pid, int cpu_no);
> +int taskset_benchmark(pid_t bm_pid, int cpu_no, cpu_set_t *old_affinity);
> +int taskset_restore(pid_t bm_pid, cpu_set_t *old_affinity);
>  int write_schemata(char *ctrlgrp, char *schemata, int cpu_no,
>  		   char *resctrl_val);
>  int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index d515850cc174..4aed974efa0f 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -777,7 +777,7 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
>  	value.sival_ptr = (void *)benchmark_cmd;
>  
>  	/* Taskset benchmark to specified cpu */
> -	ret = taskset_benchmark(bm_pid, param->cpu_no);
> +	ret = taskset_benchmark(bm_pid, param->cpu_no, NULL);
>  	if (ret)
>  		goto out;
>  
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index dffe42e11c6c..97760fadcddf 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -345,15 +345,25 @@ int get_mask_no_shareable(const char *cache_type, unsigned long *mask)
>  
>  /*
>   * taskset_benchmark - Taskset PID (i.e. benchmark) to a specified cpu
> - * @bm_pid:	PID that should be binded
> - * @cpu_no:	CPU number at which the PID would be binded
> + * @bm_pid:		PID that should be binded
> + * @cpu_no:		CPU number at which the PID would be binded
> + * @old_affinity:	When not NULL, set to old CPU affinity
>   *
>   * Return: 0 on success, < 0 on error.
>   */
> -int taskset_benchmark(pid_t bm_pid, int cpu_no)
> +int taskset_benchmark(pid_t bm_pid, int cpu_no, cpu_set_t *old_affinity)
>  {
>  	cpu_set_t my_set;
>  
> +	if (old_affinity) {
> +		CPU_ZERO(old_affinity);
> +		if (sched_getaffinity(bm_pid, sizeof(*old_affinity),
> +				      old_affinity)) {
> +			ksft_perror("Unable to read previous CPU affinity");

"previous" can be confusing here (it is not trying to determine something
from the past but instead the current state). It can just be "Unable to read
CPU affinity"

> +			return -1;
> +		}
> +	}
> +
>  	CPU_ZERO(&my_set);
>  	CPU_SET(cpu_no, &my_set);
>  
> @@ -366,6 +376,23 @@ int taskset_benchmark(pid_t bm_pid, int cpu_no)
>  	return 0;
>  }
>  
> +/*
> + * taskset_restore - Taskset PID to the earlier CPU affinity
> + * @bm_pid:		PID that should be reset
> + * @old_affinity:	The old CPU affinity to restore
> + *
> + * Return: 0 on success, < 0 on error.
> + */
> +int taskset_restore(pid_t bm_pid, cpu_set_t *old_affinity)
> +{
> +	if (sched_setaffinity(bm_pid, sizeof(*old_affinity), old_affinity)) {
> +		ksft_perror("Unable to restore taskset");

This message is not clear to me. How about "Unable to restore CPU affinity"?

> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * create_grp - Create a group only if one doesn't exist
>   * @grp_name:	Name of the group

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

