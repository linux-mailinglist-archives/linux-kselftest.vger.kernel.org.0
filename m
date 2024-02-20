Return-Path: <linux-kselftest+bounces-5033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3505885BE3B
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 15:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A141C23041
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 14:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46146745DD;
	Tue, 20 Feb 2024 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hvu3WmJM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700636F50D;
	Tue, 20 Feb 2024 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708438146; cv=fail; b=FVNQbMqrixJY8K+DHCF1CoQYfbuWa/Aw3lv4rbAaJRDXgZDTJgLee788uFA2ZnyY+VFV48wchFshgg+bQF5wGkL86OA66Etl1g7B0J7KH5FdqOgTlcyfNrVSowdG+tMVGbNlAtFPm8JzsFIBmT+Nso93VRojwYc2tUm9h3MVbIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708438146; c=relaxed/simple;
	bh=sDcbT83bZNilZQ4TkOgjWpz+QjILzkubD4+OocWHwNw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pauyBiYdztQycLx9wUHRDhVLGlODH7CveTE7aS7NkobUI+ycvxNVZUlWNZC7Jr7myn8zQxF/0JFwp/6TUAQcqgOrmyXfOtBJ/PoY9nfee3jHB2uoMoZmLH8fRLXl8dLy8CouKhlnZ7W3SeuF2mutKqKuERcgedx02svgSwSZgvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hvu3WmJM; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708438145; x=1739974145;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=sDcbT83bZNilZQ4TkOgjWpz+QjILzkubD4+OocWHwNw=;
  b=hvu3WmJMnE+M/DeoN5r846YuIzGomc6T8CuIZmEjQIGz/8sQLj1Ap0Cf
   IufKJTNi82MtyX4GmdAv9SqwS7Bd6fph3wpZ1JTYp3Hg/BdYcIfmDGOa9
   yS9ZsemCaZaBAmzs8EX7PNGoEe/JjXbCG+jI+cF9BO3v/Js4kUVE3NDMs
   b/QELa668ecclKt3MM9QL7GpXZR7VsR1Zuh1W1w43Dhuy/zhorYVMS4Rl
   fMc6mIGA4sORQ6G66/uGp329UFhNLCva+qruH1dG+fglYpZtwkXw+ye6T
   EP0w5ckpagzu3QlQzoWvMtNuVkSt3mG5tb1+0rS8yh4oCFjk8PLtxoJwB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="13953515"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="13953515"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:09:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="5085383"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 06:09:04 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 06:09:03 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 06:09:03 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 06:09:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U73t0470Sz7PYVoRxeQgnebPSaT8eRZiLkqFIi9e/L6mfZev0vJNLJxh3TitxwhICMT8GhNtW4/iXMa9CSkNLQv3UmhqqtxqK3oGHuQenJbwBX7SXHgMcYL+FhbN4eDXSftbrQZIzWdS2kKcPvylVB+LKlBLX+B+QWsDCXUzvEStsXF9S1Mo0IsOPPX4CT2JyO6ycH85R/DO8cYo64lrePAxU6DH3a0CzYZg9xt8z/jWikunclCZPaBiKtWOUOHqivHxdjlG3RTZ3hzYFbJE4v5YeVeeTWT7qAV36RYOUQUhwg8ct8v2SOuVuN0+7DX21xSW5XGZUy6L3SJNqBZP5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3AK7+IWQRwECMJv/+LQ/6winvvOm0E1+v5Sl9fb5yc=;
 b=FZxgE71sFaBPcx2iTBq/PvfmasVVx5wfJfJJfCxwEZQm2H64u588w5TgiBRx6oWVCjd7+f69WT7n1xfGL5uvaNNxf55F2UZS6XkTVMor+W24l9L/1cCDXgskIsnykOk+qkYc4qxrRrL+6of2Jr5GLf9kuhce5idjOj5GeYVM7dnHtaoR95jiKyIs/jT7L80/7XMHAHd4V+BGz7GN5Sz1DwW35F8Cltw83FBL49EbqP5LrSz8hbM6pkAkVTebhD+QZWTpmp5OKegJdgdd7bldTLaaW4dz8C+9fB42a++hs964DQqti3M2bxZiWqKp4G7eKGkuQQ5EFYZVYA9OgASPrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SN7PR11MB6800.namprd11.prod.outlook.com (2603:10b6:806:260::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 14:09:01 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::b2fa:6a11:bef7:179f]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::b2fa:6a11:bef7:179f%4]) with mapi id 15.20.7292.033; Tue, 20 Feb 2024
 14:09:01 +0000
Date: Tue, 20 Feb 2024 15:08:55 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre
	<reinette.chatre@intel.com>, Shuah Khan <shuah@kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 3/3] selftests/resctrl: Move cleanups out of individual
 tests
Message-ID: <i7ixj5wy72mgcczmqc3j2in7uazplg6aqoei32iu444egxmbjh@a7xd6iv5a7zu>
References: <cover.1708434017.git.maciej.wieczor-retman@intel.com>
 <63b9763211c2954f0ef517a817b3bf0c482df8cd.1708434017.git.maciej.wieczor-retman@intel.com>
 <f08dafda-c8a5-324a-464c-5b84d779c4ad@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f08dafda-c8a5-324a-464c-5b84d779c4ad@linux.intel.com>
X-ClientProxiedBy: FR4P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::12) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|SN7PR11MB6800:EE_
X-MS-Office365-Filtering-Correlation-Id: 60b6fcb4-1bcc-4fb0-ece3-08dc321d7cdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bI6DJY27Jw8nGARLTsPQhqjk+VGeyaDSrAbWAyUbwTGhjLQcyHBVhMOxlb8FtCVFXCvFz2FhgqOZRek6gWgBM1tN8JxBiVqEfOTuKk8Kb3+fr/9krCnp1kaEyWGV0TvVA2JsVrfvyF1sRb+P5iJ6mFxl9gBc8z0Vh9+Yr6359aXWDwEcSy/c7eS4zEOtcbTHt4DnNiiuOQa7w/OfpFNDqcxgCYSYqncFwHawRtut804pGl+BGEeDCeGbWz3gkA74fhxbwTDN2qRgIYklw45dm2LKLn4dl3sH9Mql4O5p/YCQ1WVsCF3NwHH7XYB0oKjkkXQoJ7Ey23ZbDzTg9ifrbOz7dCh97SaH7eDb53VZztcmBlDixyoRrwyRQeCLTJ4SU69bcffc41gr26F0+9U2eyZcLi8QDpeZppn+O9TO16a9PPXGwpxeAagu7HMgtY6fCKlIN6VHYsg+uQ0QKP913jwU0i3Vsub7tyDRm7ppK+zex/b1gPEqXuorQ50rS9ILI7sIV7mI8GXqKSjs7PrJf/8Qk9WYI5um5n/YrNOpq7g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?UY5CiQaw/BsYxXZaLEkxI9LnBbJRL3qqZ0cPfPLl9fXba/OOLpPHfunZ3m?=
 =?iso-8859-1?Q?kHLH0ap7DqTYm3P81UUGYWz2xHqIXTsCUTXp9QLvQ+huYLRig8i6a0V4ko?=
 =?iso-8859-1?Q?vBgrKrRDGxsmF7Y9sjYdZuMKGfaE9XBUmGaaspaK97w28PT15+r7mmGqmN?=
 =?iso-8859-1?Q?/lxmURy2XgoUtpXxRElb+Dsp5kYSV8BoNqd+ArT27V/LfqCjqIcFJBG9ei?=
 =?iso-8859-1?Q?n2UTAmP8swU7z/un2OWd+dP/6CZoI+mI4+4wMFR0UC0Jai57IgCUM43XUb?=
 =?iso-8859-1?Q?4jspu6X08WwJSoRUBKmhvl3Dc0643gcO+cdGP7xeyKIlfhKai6dkrIchlv?=
 =?iso-8859-1?Q?//1AE6YHW8grYgTW3/wk4IzCX3Gy0LA8FuksBVtEL+qVbPGW1ll2uA5Klm?=
 =?iso-8859-1?Q?gCDcD7kDP2y67bj1ajFBEgR/ETBRIMY1WbFZLmxM2k0WhZlfO/YH7E3tAO?=
 =?iso-8859-1?Q?byVT4I5iIrd4ozCiSng0bkFfYMvYCvdwf+eQcSZHITak/UDhpDzpWddqHK?=
 =?iso-8859-1?Q?+Hepoyco0PZ2V+LirqWUWOUu0k+ULgTHTofNPYFDFLtJ78ahuPJvkX97ni?=
 =?iso-8859-1?Q?2gm5vel9UszCNyB/ASLlumshP7SS3PjRQxVnbD/sHbhw6Bt1IK4DJEaaxz?=
 =?iso-8859-1?Q?Sus2bGbtX8jCG62qwAKlCCP+BMMQy2ZuBGy16Q5JaRqXApD7ZMWYjfCuAb?=
 =?iso-8859-1?Q?ngPkBpll467LfXO5VjiwkKZRGmpfPzZh++CqMHiBNpWlQXKw9CNJBVNPri?=
 =?iso-8859-1?Q?LW5ryWpnRFDSbOqy7f001EdtSurtR/fofHXeJwhVKKTJ6+6mBtteDhATGt?=
 =?iso-8859-1?Q?CBrAy7bQvscHuQOZuU4y+V6IBm2MHxz0d6llV0WQUuTWoX5LnzzAftMFg7?=
 =?iso-8859-1?Q?VYWm4NlFxosKuSPFCKPET4YM2YoJ7SlYeBYjfnG9uvBArpMeYo47EfwVoE?=
 =?iso-8859-1?Q?r0FpLspEzPc6Q8D3euwOsggcbN7K7VNH8XKbhcwdxgiy/uHMjH8esjRx3u?=
 =?iso-8859-1?Q?kBbRR4sP0H+SIAdRfWrv+YKRVv2Z47z921i4eo9SqSy29dJwBHKM0qQLxg?=
 =?iso-8859-1?Q?RxCjfkwd9vMOJbBywqk7depdSCqNEmG2teASan7XSD3VLpHC/a7c9z0pjt?=
 =?iso-8859-1?Q?tMCyBZDk9y5Jqq+2iDhcAdpVNyVICSZEY9z7B5rKLn9n44NuFvKZj8ptHz?=
 =?iso-8859-1?Q?mrIo7cfp+ULYzOVe87SqYcYXid0dKxnY1y2bqBoZztnKWFkoSQqgMqrxmn?=
 =?iso-8859-1?Q?h5jULueZoE0j9yyvx09bjQwkhR2+ViUoLKz5YfIFPDS8BEbUZZNiTeQaAb?=
 =?iso-8859-1?Q?ZJqoHsr8Q14JRwPjyq+GnJCKSncREJ2GY8kosXVK5yyILS0sFWWvjQ4sw+?=
 =?iso-8859-1?Q?1LJ302VbMDHL5F8ZWcBq4lAOrPsPfC6Qb6yAG5C67fkgvOmLiN+X3+egmZ?=
 =?iso-8859-1?Q?CryErvQYoYzxAlIiusDGoTzSYFMGa9sDstuuczJZYdIW+ovf5IKN0muScK?=
 =?iso-8859-1?Q?KfYilbiCkdIDCgCsFu/15vMplawYasr0M95xEbvQ82vyaBEZDqZEebStsS?=
 =?iso-8859-1?Q?qyLoL7WiCV/Z6rQIr3jd8+nEshSKCcwkr+tGXjdfour04Ax10ZxiY/Gfpu?=
 =?iso-8859-1?Q?jFb4ZNjDHG6pdh+nANfBb103yWoFyGzoEXI3FDR0ICdvRzTiVazs9l4k3K?=
 =?iso-8859-1?Q?uagGjFs/mDBB4GVhKAA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b6fcb4-1bcc-4fb0-ece3-08dc321d7cdb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 14:09:01.2459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fh71TV48cOI6XMXrgfJoz+gp2tCCVBLJGIblCdH6gfmC0L1KjMTrNCj8rxBytJZ45bRvIVBIDiYknUJJpvHMRHAB3h/rnKDRHlYOa9MNqL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6800
X-OriginatorOrg: intel.com

On 2024-02-20 at 15:49:16 +0200, Ilpo Järvinen wrote:
>On Tue, 20 Feb 2024, Maciej Wieczor-Retman wrote:
>
>> Every test calls its cleanup function at the end of it's test function.
>> After the cleanup function pointer is added to the test framework this
>> can be simplified to executing the callback function at the end of the
>> generic test running function.
>> 
>> Make test cleanup functions static and call them from the end of
>> run_single_test() from the resctrl_test's cleanup function pointer.
>> 
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> ---
>>  tools/testing/selftests/resctrl/cat_test.c      | 4 +---
>>  tools/testing/selftests/resctrl/cmt_test.c      | 3 +--
>>  tools/testing/selftests/resctrl/mba_test.c      | 4 +---
>>  tools/testing/selftests/resctrl/mbm_test.c      | 4 +---
>>  tools/testing/selftests/resctrl/resctrl.h       | 4 ----
>>  tools/testing/selftests/resctrl/resctrl_tests.c | 2 ++
>>  6 files changed, 6 insertions(+), 15 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
>> index 2d2f69d3e5b7..ad5ebce65c07 100644
>> --- a/tools/testing/selftests/resctrl/cat_test.c
>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>> @@ -128,7 +128,7 @@ static int check_results(struct resctrl_val_param *param, const char *cache_type
>>  	return fail;
>>  }
>>  
>> -void cat_test_cleanup(void)
>> +static void cat_test_cleanup(void)
>>  {
>>  	remove(RESULT_FILE_NAME);
>>  }
>> @@ -289,8 +289,6 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
>>  	ret = check_results(&param, test->resource,
>>  			    cache_total_size, full_cache_mask, start_mask);
>>  out:
>> -	cat_test_cleanup();
>> -
>
>Any goto out can now become return ret; and the out label be then removed.

Right, thanks, I'll clean these up.

>
>
>-- 
> i.
>

-- 
Kind regards
Maciej Wieczór-Retman

