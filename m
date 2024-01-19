Return-Path: <linux-kselftest+bounces-3251-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D27832D59
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 17:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244431F24A1F
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 16:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C02754F83;
	Fri, 19 Jan 2024 16:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bVE98ZMy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2E64F1FA;
	Fri, 19 Jan 2024 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705682380; cv=fail; b=HqW5U61YHc3Circ9DhRirrLvMnrXkLxCX6KwBcIAZyNVtISV0CfnWzsWvOCFxrsPxpiZuKzOkjQpAaLut4TRQx+v4b8Vm55Q7Cdb6BFvE6VQtvpb/kr2J0v1un2r1pc6KWHmBjsHS0tUw+GrxUFi84AHYIG7pztLsgPZtq9hvxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705682380; c=relaxed/simple;
	bh=RhbGab7oHvcbXMMgFGfhf7E/6TyZW9QAU0S4ehVJgyo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AfUGgeWKeAQLGKpubackPY8gFas8/Lpv8w19Y+Zd7GthJr21B12UikeFBtZM3JCpeWDDEc7KcDnl9qjiK+R40kI9lwt012Dy086gist1386L+pMhkGU3qKbVOAiFL9IhgWEFoWzHD2tScCLj6lGiV+7+NHe7QdhAL6cIY1Owce0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bVE98ZMy; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705682378; x=1737218378;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RhbGab7oHvcbXMMgFGfhf7E/6TyZW9QAU0S4ehVJgyo=;
  b=bVE98ZMyhrJo4caw1ZIZRb5qBI6GajeoTmT2xSrZG4WBYdgB1j/gnCq/
   Ct6rD5WVp86ft0stRakglO5zAgzWIZVv4BOdjeYDsbgKAjzfXuRuF2TEX
   ezy6CBmcVoe6MDnL9Pi2Ous8qP/7KPr9e5jH6NQ7mYHZKN3/m4Ywh2Ztr
   wfrcugSniK7C10C5bzH3WGXc9FMGXVfV+JYdJ7lnXo5lsPrwKclepHhh8
   AVc3eEBxcx/lvU5EkKt1QdRqzqbOrdNrYGSxeeTOuw6DOFK8FX4KMo6/E
   CsS4HETE/COTInS9USzfpajBM2GKumx+AzOzY0PIZQZzWVSVB/R2OlJ1h
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="678453"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="678453"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 08:39:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="1031995079"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="1031995079"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jan 2024 08:39:36 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 08:39:36 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Jan 2024 08:39:36 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Jan 2024 08:39:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/zKH7nj3Te9RcQPOr3M17F7PusKQgyzUFUKYzSEIlOps+qMXryDY5xuUyQ9zWYWPz0kWNFS7dsn8gdAO1FjBDsA0hXEJkCu1/yX+MVMwBX+xNKpif3SS+WtrdSYLK/fV2wC2TB3LnMZ4IUy2dxb7lvsU/mfEhIKUVbKECuAhUP5TXelKFNqh4HP3xeWgplqVA+tBvz57wisl4R2Y7wcqWRbBdNcdQOD/vr2jhTUqSPap9kccmHjHFI61sQgnda3mt9O3cHxzbBj/wNkJg3Al/XUrszASanElajOmLJmuHTYLMbGs6Xu6F74KZaQjWGE+hKP0ssHDH6sS18kuhrO+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eL6wsXMfvgdpr4p3e9eMC73x2YGXsZMXhIJTy3xZR6s=;
 b=QBmuKQU1cRgXEDwCCRKT9lbMwf5YpM9jmp9cs/JyHF1c4z4KdHl+lrYnXC7RoXlBRbZQOd22A2PE6Ws/yrHuUTnleKm/4sX71q0KWgoaE1Faqq3z8FuVudNwbmMzRXN2ZGj7/moTlDqjlZtV2VK/brL2UWe3nj0poCPlT1yk/9sqQqdrzatNA/JHW7Hp3KgTUIaBBPS5s75WnWYR1YxwQSDQlgnD8ufhJtg6zbRc1bXtLgs9G6U95oymeL/mJbwIZS3LIGfobZ+wDyUnjlXMhJRqduWs3S0A8nz9y/n5hfkCj3eEK3DnUfVAhM/GilPUQmFLuf9kLMxN9VxLgFqb5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6429.namprd11.prod.outlook.com (2603:10b6:8:b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26; Fri, 19 Jan
 2024 16:39:34 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7181.018; Fri, 19 Jan 2024
 16:39:33 +0000
Message-ID: <92bccaea-b73f-42e0-a386-1a73eb6f88de@intel.com>
Date: Fri, 19 Jan 2024 08:39:31 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] selftests/resctrl: Add non-contiguous CBMs CAT
 test
Content-Language: en-US
To: =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <cover.1702392177.git.maciej.wieczor-retman@intel.com>
 <10c3afd7f62c63db31a3d4af86529144a5d7bbf9.1702392177.git.maciej.wieczor-retman@intel.com>
 <fd6acf6a-2610-406b-b363-220121a45aee@intel.com>
 <6v4hgra7bd5nwubcgtbsidmoohrgxdw7no4faa4a54g4vrxo63@c6qnujvwn5ej>
 <73cea732-3757-4aec-a39c-4f0e50f6fb70@intel.com>
 <su2d6i22icynusoykmowfnzery6hlqugovaw4xcrhb7r3ymbx2@aeimvrxsc5xw>
 <05db3bdc-9d54-44d2-8aae-07d66053892e@intel.com>
 <wvehk3j2dcf3lkuantb7shefymxj2mnzv4pgbiqbk4jkmmzeid@lurk3dam5tb6>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <wvehk3j2dcf3lkuantb7shefymxj2mnzv4pgbiqbk4jkmmzeid@lurk3dam5tb6>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0358.namprd03.prod.outlook.com
 (2603:10b6:303:dc::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: 179fa2ef-7914-49c2-ec87-08dc190d378d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TtilpS6Z/5HLrKSqFVljKadsilX1XNR1FxHiRJQiFlCYqadXgeuqQYyXpN/MDTW5+bo9LWDDyFyRi7kfjppY5x5K5KpiDAeNo6FhHxvQR30hBJCWNsdBaQtlHbKqzwNAnKHkX9kszm4aNPyod2HBltFZOUjUVzbnnKblbHLavWh2Im+WM7NmbKJQ2JlvnAf64NHEj500wrCfq+7m7cm9J42CL9Daqm4MH1psTopi1aCN/xwGHvKxrMwlSWxkPzw9Jt8nqPnMTFmGcKLXXzaYQal9E40+GgJUS7hPdH+qWBtCq+9/4lgFy4GIfnBEwjaZmdWUjA/0+1kHYyAutl4XaHbCgju5o/drYHfrynWvpcI5R4yedabVB1VP0Bi9ItbgNLJc2Fu4gv1t4GtNYmU7GMqnBqlIhj37ZEYv0sqwCmUa2LNepC2HXl9Uikz2QWVoWYvhB2+TzUCQnnzfUK1sWN8tHSWoPjwXjWw7S63g/X0N+jeESaWIMDoJdkEXc61xqCiHVpgYy5cenvtEN0K41aD/YfHQrhcZN+8zV8kzR0UdOKkwQBoit8ZhqUQ/GEqa2bTIgbn3BHDl1UY5nZemTgdlVlCiKzSi7KA2LRr5oVHuvoV08OZVfaszpF94ekeTQ04yFnSpOIwwJczx8oyJhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(53546011)(478600001)(2616005)(26005)(6486002)(6506007)(6512007)(66574015)(2906002)(83380400001)(5660300002)(41300700001)(66476007)(66556008)(66946007)(6636002)(37006003)(54906003)(316002)(44832011)(4326008)(6862004)(8676002)(8936002)(38100700002)(36756003)(86362001)(82960400001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzhodFZQREV6bCtpNndVWmF0MEN3Vm93SHc1b09VL0pjcmxkYkJjVnNtR1hG?=
 =?utf-8?B?UVdXdWEyV0FqNmZzZE4xYnRNTldpUGNBV3dUck91dTFhVVN3S2dwblQ1YkJI?=
 =?utf-8?B?VndybXhsbTVweVNGYS9IbjNlRWlyQmY1Yml3TUFnOVEvam9zRklNTlFJQklj?=
 =?utf-8?B?UGNmU1hwbGdrV2JHb2lwSGFMMjFvV1F4UjM0OGNWUnh2UUhNY0N5UWhlcWhI?=
 =?utf-8?B?TlBOUE9QcWMzZjBvcWpaTmxEOFB3UmRuaXZwbkJndzJRZlJMWTZIaTlCNUtW?=
 =?utf-8?B?bktjS25UUC9leEUxRzhNNTFsR3dRcGJkbG1jWEVvQy9MdlRWT3o1TDZNc0I0?=
 =?utf-8?B?bVNaczhyZDlvWjk0V0Nvc0ZLejBjcEx6SVhCS1NQMDI1ZVk3L21pYndTVDJq?=
 =?utf-8?B?OXlMSTVhdWU3Sk9mS0ZacVdrNjFhOUJ6VzVKZDhNSy9OVWdCb2luSmEvR29k?=
 =?utf-8?B?YTFTaktyR1hFZXdvUTlQN2FidVFoSVVRcVF6blBMcXp5Z1RmblNBZGZXNEFm?=
 =?utf-8?B?bDVKQnFUclYveHlxSFZ3U3poWkE5QXVVL2ltRlp2ZDJwSWdleEIxL1lFZERN?=
 =?utf-8?B?ZC8zY0RDQnVJV25ZbExxOHdUbnRmUzI0MU5meHprWWc5c09kblhrWTZubzNs?=
 =?utf-8?B?MUxLTWtyNGN3ODJYQ3dlTjQvc2VPcnZnMVoyY2pxbHc2bWFJV2NmVG5zVUlx?=
 =?utf-8?B?Nm9Ra1ZMQ29EUUw1NGcxQmx3VllsdTlybFN5alB5eEVlUHIvU2tacTlTZUZ1?=
 =?utf-8?B?RDU3d0FxRkJRaGVBQVRMUnlUckhCcis2UXFRWWkrRXRBZHdFcHZMNmdrL3Iw?=
 =?utf-8?B?Z081clhoUkxVL3A4SDlUT2xsZ1F1b1NaRUk2RUFxa2xDVFJVRWJVUjFnRXhj?=
 =?utf-8?B?ekc1R2h2V1FkSWxCcHFoRmpaaHpyVVFLV2hBV0V4NDlMYjhtVE5HUnh4L0hk?=
 =?utf-8?B?Rm9vWlRjR2ZuR3Z0dUp4cTl5NXViMkt2eXBJa05WaGNYbVNUTVZlYkFYL2tN?=
 =?utf-8?B?eENucVVOUjZWck4wa3dLV3B4Y1p2UjE5QWpzOTNTNTZiNWVyQlp5UnJiV09l?=
 =?utf-8?B?NUJmelV0QmZ6bXgwMkxLckVkL3BnVTlabDYxL20zelRGYnBNbXE1dE5IZ05i?=
 =?utf-8?B?b2tjbDlqeW1xTDIyZVdlWWc0MXVRSFo5QmtxTlROdXQyWXNyTnhLNVUyRTgx?=
 =?utf-8?B?SFVodTNRaU9EZFNSa3hxWXRRM2dPN0JvekVIUTMwTllQU3hJTDZoYVZHVkVD?=
 =?utf-8?B?dFN4SkVTR3kzdjdPbktSRVcwdGVJeEtYck5XM3BleWhHekNPdXB5YXhqZ2JW?=
 =?utf-8?B?NU45d2gyVzdURlJGY1hLenYyUHYyQUJkQi9ZckRQbHdjdUpXOXZTdSsvUnhz?=
 =?utf-8?B?bFZDbmxrbFMwaGZ5akNiZ0ZRZG9vZ0hIalZKZ0NTK1BtTU1ISW9CUlBzT2pF?=
 =?utf-8?B?eWJRODMvNWNQSzVXTFlweTVnQi94dzI2Q0JiMFBXa2RvZUVzL2JVVEZERDdj?=
 =?utf-8?B?VElXaVpuMXY1a052S2l0MlF0WFV4U2ZQSDRaZnlUVGFLcUpkUjJyajlrQ2xN?=
 =?utf-8?B?K3VxRW16NVVEVHNKc3hNNjZnT2M4c1d4WDdsVXhvOTY4Q09SK3k4cjlpbXNn?=
 =?utf-8?B?ZE9EMTZBTjJEaDB0a2xjdXhwd1YwUDZMSFRneWIweEdlNy9NcUFpU3k0NndJ?=
 =?utf-8?B?M3ZFdm5mUDBnMHphbVY5QmJNSWR2dE8yN3ZITVBUKzI3NzdHTkQ2UVJuTUlI?=
 =?utf-8?B?THJTTW9rbUY2SjZPZ2t0aEVCYk9qT2JEQmJ0WmlheTBRYy83WUtaempadDBT?=
 =?utf-8?B?NE1SdWxTWm9lRldySXE0WGtnRVVodHB1aVZOeHlDZlJybFdqVnh6MEhQYUVn?=
 =?utf-8?B?ZFNhNENwUVRycjF2bmVQZFFzbHpaeHh1bTN1UndHbzVEcjFxZEROdWNrb0JN?=
 =?utf-8?B?eXhsSG53RzBCM0F6MWdKZmg0TW5rVE12QlFWWWxPdTJ6R0hNUEpJVnhOQjJB?=
 =?utf-8?B?U1BFaVB5aFdJaCtvZldoNDVsTHhKSHh5SmdIL2hhNEhRL0FselZ6b1dMSzRG?=
 =?utf-8?B?U2VHZWdteDhLT2dkSzZpN3FvdTBvOUpyc1dMMzV5K2FMbEczOXhlRkgwajBO?=
 =?utf-8?B?VDdOY0dUZHZJalIvMkVkQ1dHajlXejZiTDh0cnhyS0NGcXRIS3RWdVlyN0I1?=
 =?utf-8?B?V0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 179fa2ef-7914-49c2-ec87-08dc190d378d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 16:39:33.8920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ra+jzIy0BkI+RGH84g8B2eGSPpP5cGptFWlcVniPs1e9FtR2tzyAlDtXnUfpnfYKt9+j05efq8fmjH6TyGgt87/Y4iLJ4OG3da9/akEJS8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6429
X-OriginatorOrg: intel.com

Hi Maciej,

On 1/18/2024 11:37 PM, Maciej Wieczór-Retman wrote:
> On 2024-01-18 at 09:15:46 -0800, Reinette Chatre wrote:
>> On 1/18/2024 4:02 AM, Maciej Wieczór-Retman wrote:
>>> On 2024-01-17 at 10:49:06 -0800, Reinette Chatre wrote:
>>>> On 1/17/2024 12:26 AM, Maciej Wieczór-Retman wrote:
>>>>> On 2024-01-08 at 14:42:11 -0800, Reinette Chatre wrote:
>>>>>> On 12/12/2023 6:52 AM, Maciej Wieczor-Retman wrote:
>>
>>>>>>> +	bit_center = count_bits(full_cache_mask) / 2;
>>>>>>> +	cont_mask = full_cache_mask >> bit_center;
>>>>>>> +
>>>>>>> +	/* Contiguous mask write check. */
>>>>>>> +	snprintf(schemata, sizeof(schemata), "%lx", cont_mask);
>>>>>>> +	ret = write_schemata("", schemata, uparams->cpu, test->resource);
>>>>>>> +	if (ret)
>>>>>>> +		return ret;
>>>>>>
>>>>>> How will user know what failed? I am seeing this single test exercise a few scenarios
>>>>>> and it is not obvious to me if the issue will be clear if this test,
>>>>>> noncont_cat_run_test(), fails.
>>>>>
>>>>> write_schemata() either succeeds with '0' or errors out with a negative value. If
>>>>> the contiguous mask write fails, write_schemata should print out what was wrong
>>>>> and I believe that the test will report an error rather than failure.
>>>>
>>>> Right. I am trying to understand whether the user will be able to decipher what failed
>>>> in case there is an error. Seems like in this case the user is expected to look at the
>>>> source code of the test to understand what the test was trying to do at the time it
>>>> encountered the failure. In this case user may be "lucky" that this test only has
>>>> one write_schemata() call _not_ followed by a ksft_print_msg() so user can use that
>>>> reasoning to figure out which write_schemata() failed to further dig what test was
>>>> trying to do. 
>>>
>>> When a write_schemata() is executed the string that is being written gets
>>> printed. If there are multiple calls in a single tests and one fails I'd imagine
>>> it would be easy for the user to figure out which one failed.
>>
>> It would be easy for the user the figure out if (a) it is obvious to the user
>> what schema a particular write_schema() call attempted to write and (b) all the
>> write_schema() calls attempt to write different schema.
> 
> Okay, your comment made me wonder if on error the schemata still is printed. I
> double checked in the code and whether write_schemata() fails or not it has a
> goto path where before returning it will print out the schema. So I believe that
> satisfies your (a) condition.

Let me try with an example.
Scenario 1:
The test has the following code:
	...
	write_schemata(..., "0xfff", ...);
	...
	write_schemata(..., "0xf0f", ...);
	...

Scenario 2:
The test has the following code:
	...
	write_schemata(..., schemata, ...);
	...
	write_schemata(..., schemata, ...);
	...

Any failure of write_schemata() in scenario 1 will be easy to trace. As you
state, write_schemata() prints the schemata attempted and it will thus be
easy to look at the code to see which write_schemata() call failed since it
is obvious from the code which schemata was attempted.
A failure of one of the write_schemata() in scenario 2 will not be as easy
to trace since the user first needs to determine what the value of "schemata"
is at each call and that may depend on the platform, bit shifting done in test,
and state of system state at time of test.

> As for (b) depends on what you meant. Other tests that run more than one
> write_schemata() use different ones every time (CAT, MBM, MBA). Do you suggest
> that the non-contiguous test should attempt more schematas? For example shift
> the bit hole from one side to the other? I assumed one CBM with a centered bit
> hole would be enough to check if non-contiguous CBM feature works properly and
> more CBMs would be redundant.

Let me try with an example.
Scenario 1:
The test has the following code:
	...
	write_schemata(..., "0xfff", ...);
	...
	write_schemata(..., "0xf0f", ...);
	...

Scenario 2:
The test has the following code:
	...
	write_schemata(..., "0xfff", ...);
	...
	write_schemata(..., "0xfff", ...);
	...

A failure of either write_schemata() in scenario 1 will be easy to trace since 
the schemata attempted is different in each case. The schemata printed by the
write_schemata() error message can thus easily be connected to the specific
write_schemata() call.
A failure of either write_schemata() in scenario 2 is not so obvious since they
both attempted the same schemata so the error message printed by write_schemata()
could belong to either. 

Reinette

