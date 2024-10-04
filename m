Return-Path: <linux-kselftest+bounces-19075-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FC1991243
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 00:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94971F23C52
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 22:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C261AE003;
	Fri,  4 Oct 2024 22:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b8Oakp+D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED11140E34;
	Fri,  4 Oct 2024 22:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728080637; cv=fail; b=qnf/Us1tltJjGDHQ5bruEsamY8iu5smg0sf5hfz9qi/d60Eow+LrTKd11DDFZ9LeZQl4vK+oRrm0CMbVshxRSVI91fhuiAy9VIejlmGdNXYqsf5/K7WqIUnpkQMfLzdN07ihYe3mh7PaIoA5/elilcIOtGicj5cFXkYftuFBvmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728080637; c=relaxed/simple;
	bh=FkaKlcliGxmW1swnaYIcWwtMX08tTJsOcZYEPEWcktc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D/OIIkbBrCWYIEseNZz4zLvYk1z9TyW1fyj/FezLw6kWBzKevNQSgCgxQmiW7K+iKhj2zVmyjZiAqnhfqsw17Z1P2IzVFlHV5xayCUb10ZxPyV1MEiaq7meWhC62ivIW6OKOkBYQEt4HJY34yOZEp88N8tjZhFxPKmZ1lQyoRrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b8Oakp+D; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728080635; x=1759616635;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FkaKlcliGxmW1swnaYIcWwtMX08tTJsOcZYEPEWcktc=;
  b=b8Oakp+DFSP1AlUpP6MeRNJDPEWpmNnjKwhG2ioRjTsGrUZB6jCZ1t7B
   6i/RcqBp44i1tbK7ne/Ja/hdLTU7w1RW34lQvMsrHGiOU1+be0eFoaR0O
   XDDyvN2X4+1WvALI+T+txo+yHgCOK30u/xt/i3eG1Q8RI+hsOE8FQWoWg
   Jyv6sW9FNyR/nnGVOGnLKWakFLK48JPLHAIwOhKISZb09FHHkoC3MTfuq
   OGqAT6UOUI1PVbeOteDFTwCVXBxDOwDddD+o8y2njdeHvgvJy5Lh+8bAh
   9bcO1LbqVerQOeWceZYaZmDKaGKnCtffRT/4PD9BQ9WmXGUdUD3Fq2Zt7
   A==;
X-CSE-ConnectionGUID: u20b/X+mRfmpsBN0kVCRuQ==
X-CSE-MsgGUID: WfQ6YAwPSiqOHhvB2KxMcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="31111243"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="31111243"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 15:23:55 -0700
X-CSE-ConnectionGUID: PPkDuTYLQxGmyTQfCxwyDA==
X-CSE-MsgGUID: noRjhSXjTsKW3NqZ/kecGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="79407371"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2024 15:23:55 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 15:23:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 15:23:53 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 4 Oct 2024 15:23:53 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Oct 2024 15:23:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FvB+CxlxHCDD06hXz3qkfrUeDmpHGXINAtjnffTQerw7LxDvB3K6MzHJBIqx0E7QFWBRbN4wjyrv+arK6C7ijvdK1vhnwz0WSnIGz9ZJy8hxtBY3GFNG/eYG+96I/D2BagRftuU6+RM83BpYuJweAMwgfNoS/2waxMEzSmOnoQHUeAnsfNWip7Wbtie1zxjJGoJMIXOuVFdkpwJ2metscPXpcChNHADuhdG+hlAqM5nVXJqZ/idcy6gUK7M/WfOVrYuuWACqxYIYDbWSly65Zkqre+XwGxHSau1lsodgXp7//IU64POuXEAZfRPMw3+Tco46m0wSKRedFKB66mmnOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ExQ9acto2875kp4uHoFkmzUOUwq8a/eICAYx8H1ZXk=;
 b=gUpK7hefsrS3JoSAiBc4TOootaGzvohoczq0Y6SYcKsQwQz5kl6anxuhtiD5mstS7iloi7Bf1uaUw2EXZw1MwqvLGfW23Jfw38HMf2vB8owXnVLEi7bf7QmWs1+Yok+svmBo+mu5khHhHXvkdkIg151pc4M/z1yZPdgDBUuNC1OgB5pKh1Z5BpGh7FEYT558Mb4JOsYDbjSvwVSnOgrbmCzastx9q3tpAj3mGZcAKUxTlIO2m6PAjn+Z37cHVXIwjodrwA3z86q+U/BQLYctsLWYLy38n79iAfiqNTAOnGLpyqHU8MU7uFmHJCjX+Ob1nuF+o3rt23hqDt6tCzl5vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB7112.namprd11.prod.outlook.com (2603:10b6:806:2b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Fri, 4 Oct
 2024 22:23:51 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%6]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 22:23:51 +0000
Message-ID: <348c20a9-8639-411c-9576-5b0c7f08d5c5@intel.com>
Date: Fri, 4 Oct 2024 15:23:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 11/13] selftests/resctrl: Use cache size to determine
 "fill_buf" buffer size
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>, <tony.luck@intel.com>,
	<peternewman@google.com>, <babu.moger@amd.com>,
	=?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <cover.1726164080.git.reinette.chatre@intel.com>
 <ad51e32e5d4f8d99b691e7269e5179228e6a13a7.1726164080.git.reinette.chatre@intel.com>
 <ea3aca92-1571-7220-6211-6424de0b21da@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <ea3aca92-1571-7220-6211-6424de0b21da@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0010.namprd16.prod.outlook.com (2603:10b6:907::23)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e6ea6fc-8529-4882-c562-08dce4c33968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTZ6NkNKd1I4NVJ2NmJIblBsLzBCcmZyU3BSby9lZkhYZmFOSnMxL1luTHA2?=
 =?utf-8?B?cHpMQ3dRckNXV2JCOFJ4bkl0am5ROUxVa2dRSzBsS1pSUW5PL201SjdGNHJC?=
 =?utf-8?B?YW45bEtGbXJ0UkFOaWtEd2g1b1lhRCthM3BPMGEvMGpnajJReUtLMlhKajZH?=
 =?utf-8?B?bU14ZG1xWkJpd3o2Z0dGVGowWWNFOXRiTzk5Y1F3V0hKNnhhT3JsajBnOVA1?=
 =?utf-8?B?blA3YXJSeGpqcVNPN2V4eTNuL0xSemdEZmlXT0VwVHFmUmRkQTBqK2FFajBM?=
 =?utf-8?B?VnNzaXhiS0JWMWpveWdMbUxNSHdHSTVKN2NNVEp4ZG9HTE1wRVlzWnEvd0lR?=
 =?utf-8?B?WS9ibm42a2xVWGZWZHdndXltR2NaTjJVclpKZUd6aFZLMEFNM2xJN3JYdjFM?=
 =?utf-8?B?K0l0RWV2ZTJsVHBTbVNFaml0TjFxYXRxZXhNT1pmZHVJTU5hdmRVR1FoYzV1?=
 =?utf-8?B?bjVablVCaWtQNDBUa1hVM01IZUNJbzVYbVVEbzAvcGhHUmZmSTcrT253a0s0?=
 =?utf-8?B?SDVoSHJhY3NqNzBaMkxVZUVQRlQ5SitnL0pQYXhZZU40VTV6WVo2cGU4S29l?=
 =?utf-8?B?M3pjRUNEblpFcWs0MzBhcnFzRi9teHpmRzBFcGJmaEl3QlV1ekRyOXFpN2pL?=
 =?utf-8?B?OHFnOENoT0VEZ0xCV29taDVQQ1YzM1cvRHkxaHNkM0V4YnBvZ3dFalBESlBk?=
 =?utf-8?B?T3dyaGRLQ3pNNWdFbWdwellleVAxcDZsL3dEeXVVRjJFTDlqMHJXQ2d0ZzNI?=
 =?utf-8?B?dkN4d2NYOVBhMWJveG9pckZiejR1OXlhWFFWMTBTQk5SeDJjRkV5a3ZTT21O?=
 =?utf-8?B?TDEvandzbWlJTzhJUEo0N3I3R1lYaXVyZ093K042c1g0UTk5WUI2b3FyeVNw?=
 =?utf-8?B?Nmh4bnN3U2dIV21laFlZNWg4U0ptSHdJK3JmbjNkeUwyeWEydEd5T0FmbW1t?=
 =?utf-8?B?MFM5eUltczZpZHFLaDk0WTEzMmVYV1FKNTlaWDN0L0ZFZk10cHA2ZmwxMzU1?=
 =?utf-8?B?dnZNY1lGZHVlYURobzhwUW42cUdxUkxla0pJQWRTTjZXMTRrcmRrR0crNzlv?=
 =?utf-8?B?aHZWSVVMT2p1UklLaHBwR09PczRTQUFIZWlpVVdya016aGhaRWM5dGdpR1hU?=
 =?utf-8?B?K3VkK3BobWExZElJVE5qeUdSaGd2Ym1zV3FpYllSWXFGM3Q3UEFJYlZpb2ds?=
 =?utf-8?B?c21ya3RkZFd1QjJiOTVFU0Z4azFTR20vRXVYSTNsNkdEc1VrRkNNYm02Z3Fj?=
 =?utf-8?B?S2RaV3I0UVhJUXlteFBKaDBCY2UzTzVmN0VBODNWYmc4TUpSV2VsRjE5RlFw?=
 =?utf-8?B?dnNYTW9DWGtLVXE0cHpyTVptcGpsb1NaYzhZNG9RcXllN0RyakxJQjlRclVx?=
 =?utf-8?B?VHRCUVFDcUs1R2ZORmZaTjgzdTB3UUxTNmNNUTBPMEhoVjhGNWpSUFdFY29H?=
 =?utf-8?B?ditkeW9UdHBnQVhLNG8ySUE4UkJOdnp2MlMvbmwzcGNqL041UU9Sa0Y4ZjI5?=
 =?utf-8?B?bGxhd3BsWGJ1Z01XcXEyNTVJeGdnQm5zOG5GK2ROKzFZY2RXbWcrVjFaY0dF?=
 =?utf-8?B?TWlIZ3ZTdVYybXFaT0xrV0JleERqeEFGNy9DUU9kdzRmc3hMRUZBazRqV05k?=
 =?utf-8?B?aEZjWjNTSHJXN1pBamRkaTJXQ3pSZ3FzRTByZGpHbVpCVlVOQ05qejE0bVhv?=
 =?utf-8?B?cTlSdlFJVVVqRWxaR1FFcDE5emRlUVZBYU5Wa1J4dXUxcStPUXc4Yzh3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2p5NWdLQ0hqU1dXV3BUbkZ5OHFHL1RjSmZ1SVJQMVlYQjQwbHJzMnU4MHZC?=
 =?utf-8?B?YzJXUDhtcm90cWtOb0hnSTY2K0JXYWZiNWwxejl3Y3lGM205RUd1Y0pvbVpU?=
 =?utf-8?B?dzJSTmM2M1I5UCt4bFRSUUVvWFBGQzRPZDhIR25ZWGxocTRQRWxOM0M3Mldk?=
 =?utf-8?B?cS9xWlVVektIU1JJRmljeWhqMHpKOEYxRXA3WmZwOXZSMmFkaHNnNGVValBq?=
 =?utf-8?B?K1EreGMrN0pRSHVaR25FRlV0Si91cnBwQVFOODd6YktaZWtnaG81WnVxNjhI?=
 =?utf-8?B?VUxVUm9sMm91VjA1YURtOGxSaE9MNmRJbVBpYm5Vc2YyYnd5MEw1M2xtNEtL?=
 =?utf-8?B?aVEweVUyVmNyU0R2bWNxWi9FVHRMdG9tNFlxUlMxazNwZVEwY2RDZFlTMTdj?=
 =?utf-8?B?ZTltZ3p5djZ4OWZlNUJTWFh1dzhKbkg5YTRGakVuVjEydEJ3bFlIWi8vWnBF?=
 =?utf-8?B?ZDZwQWNMN21ha1IxRTJIR2ZZTDY0M0hYb2xTV3lvallscDZMTVpCTC9tWUlj?=
 =?utf-8?B?ZHZCMUxHTXg5Vnd2MkN3aDc4WG9TbTN2QzArbjBaYm83ZWhpeDllRnpBajNp?=
 =?utf-8?B?cW0ydGJIRi9TdlBkSkM1ampqTmhrS3FrcjZ2eXp1QXUrZDFMcEdNWXVEUzJD?=
 =?utf-8?B?U3FXeWJRUHgrOXVyTXlTZEN4SFF4aklzUWFlMXYyZ3hoa0lnOUg3OTNGZVlh?=
 =?utf-8?B?K3gyVTQrcmY2cmJQUllheUM4MVdTNThaRVdIMlo5cGFYMkswQ3RyYmozbkRS?=
 =?utf-8?B?cjhwMFNOQjJLUW4vTGxKZjkwK1BZVWx1bXIyejJRVE1SNkE2ZmVFVlhTVzM0?=
 =?utf-8?B?eTAyMnhsZnZlczlBMFljQ25yNHYxT2NyWi9nNkQ0MllMUXFzQkxMcUwxaE1P?=
 =?utf-8?B?T1didjVwZnEyS2ZyeCtWcXVUcFRiME5HbWpoRVU3NUVFRHYzdkkreHZYckNV?=
 =?utf-8?B?WStyTnlYQ0NteVgwSjNQTTJ6SGNLdXkxeHR3VXltQzFmcTZvdGg2WGF2NlpM?=
 =?utf-8?B?dGpsWGlIb25vQXVWcjVrcXpkcTZGV0JNSzV2TmV6WU52VHJraUx0ZWxUWGdS?=
 =?utf-8?B?dHNwYnhURlhkdWV1UnFoeXhnSFY1bUNPWktlM25UU3pVTVptNGdDQXlRdFZp?=
 =?utf-8?B?eU5tWlZBU1piTlgzMlNBVXl2Z3M1bVVTcy9aeENKWEdiZm4wcUZ1eHpFaDZP?=
 =?utf-8?B?UVhOaFRhdXcxampWeGVydGVDRGJnMURnbXJaUE5ZaDFxQ3k0T0RqTHlyS0pa?=
 =?utf-8?B?UjlOZ2QyYmZqbUhSUUp1RzZlWmJYRGFoMkV3YkJaYkRpS0ViZXFodE5DcEFH?=
 =?utf-8?B?SG9BVS9kdzduamhuTUVDOGJ0ejN1YWtGd1gwaU5IY0RmbWNNNURFc1JKZDl1?=
 =?utf-8?B?MzlBUG1LV1JIamY2a3UxcHZYVXU2a25SZnN1SGNpbytsNytRL0NtVUROa05w?=
 =?utf-8?B?OWlaT2ZSVlNsbTBxQysvZVpYeHVTSzJ3U1BZRUR6a2taMUtpSmhwMDFRNXNM?=
 =?utf-8?B?Z25oYitrTG8zdWc5UXZwVmFUaVdoR25aR0Jsdk5LNWJHUm1wTFNHWGpYU0V0?=
 =?utf-8?B?WHZnbTZaaWtTUWV4Yno5SnJJa2toa0pleHRxUEpYbXhMOHdvc2FjQ0I5d2xk?=
 =?utf-8?B?cUR6RDhGc2JJREZxWUxMd2hsOG1WNGtyVmNpYUVQb0ZLcGR0a05IT3o3UkRD?=
 =?utf-8?B?eFhreS9yaHEzeEg4RVU3bUVMcEs5MmtIT1NLcjFUUW8zYlM4Q05TVllYWVNF?=
 =?utf-8?B?bUlIU3NoQ2VMUWtYaTRpYURtRFhpeGJYZFQ0ejBIeC80NEpQRFNQeUplMU43?=
 =?utf-8?B?Qk9LRHEyTUF6RTZ0SkYyVC9kQ3doSGdHeldKcFRydXdmM2RDSVAxcVIrZXBz?=
 =?utf-8?B?eTZMSGJvUExjcHp4T0g4S2VZb2VYQWJDSXEyYWQwUlVTLzZ0ZmNVVXVNUE90?=
 =?utf-8?B?TkE0QmEyQlZVZjkrSmdUbW4wbzB4cDczT0ppaDNOek1pdHpmWldtT0dETUR3?=
 =?utf-8?B?R2xOb21DK3EzdEJiUEtOUzlwSk8rNWxLaGo2OG41aURhRU5lNG9HSGhjUlRJ?=
 =?utf-8?B?c2RRbHlpNDFpT1JUQUFQaTdENHpvRTNZWFh6cXJaT1d2Z0xhVk1HcW1vNTgz?=
 =?utf-8?B?S2Y4UG93YXZoY2daa2I4QlZPRmk0aDlMbVpDWm9rUzhjZ2dzS2ViMlNMOXdK?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6ea6fc-8529-4882-c562-08dce4c33968
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 22:23:51.3451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uxj85SwvTF2Gk2zaYzhlObVgf7B29XRnn5si89ADrV5HvQONx6OuaJfpS5IKlouSNwRTcT8aSdAi7JM+VWK3C2EK/QJeCY/sMEE/DEfVJpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7112
X-OriginatorOrg: intel.com

Hi Ilpo,

On 10/4/24 7:20 AM, Ilpo Järvinen wrote:
> On Thu, 12 Sep 2024, Reinette Chatre wrote:
> 
>> By default the MBM and MBA tests use the "fill_buf" benchmark to
>> read from a buffer with the goal to measure the memory bandwidth
>> generated by this buffer access.
>>
>> Care should be taken when sizing the buffer used by the "fill_buf"
>> benchmark. If the buffer is small enough to fit in the cache then
>> it cannot be expected that the benchmark will generate much memory
>> bandwidth. For example, on a system with 320MB L3 cache the existing
>> hardcoded default of 250MB is insufficient.
>>
>> Use the measured cache size to determine a buffer size that can be
>> expected to trigger memory access while keeping the existing default
>> as minimum that has been appropriate for testing so far.
>>
>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>> ---
>> Changes since V1:
>> - Ensure buffer is at least double L3 cache size. (Ilpo)
>> - Support user override of default buffer size. (Ilpo)
>> ---
>>  tools/testing/selftests/resctrl/mba_test.c | 8 +++++++-
>>  tools/testing/selftests/resctrl/mbm_test.c | 8 +++++++-
>>  2 files changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
>> index 7e43056c8737..d8d9637c1951 100644
>> --- a/tools/testing/selftests/resctrl/mba_test.c
>> +++ b/tools/testing/selftests/resctrl/mba_test.c
>> @@ -182,7 +182,13 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
>>  		fill_buf.memflush = uparams->fill_buf->memflush;
>>  		param.fill_buf = &fill_buf;
>>  	} else if (!uparams->benchmark_cmd[0]) {
>> -		fill_buf.buf_size = DEFAULT_SPAN;
>> +		unsigned long cache_total_size = 0;
>> +
>> +		ret = get_cache_size(uparams->cpu, "L3", &cache_total_size);
>> +		if (ret)
>> +			return ret;
>> +		fill_buf.buf_size = cache_total_size * 2 > DEFAULT_SPAN ?
>> +				    cache_total_size * 2 : DEFAULT_SPAN;
>>  		fill_buf.memflush = 1;
>>  		param.fill_buf = &fill_buf;
>>  	}
>> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
>> index b1f03a73333f..7635ee6b9339 100644
>> --- a/tools/testing/selftests/resctrl/mbm_test.c
>> +++ b/tools/testing/selftests/resctrl/mbm_test.c
>> @@ -149,7 +149,13 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
>>  		fill_buf.memflush = uparams->fill_buf->memflush;
>>  		param.fill_buf = &fill_buf;
>>  	} else if (!uparams->benchmark_cmd[0]) {
>> -		fill_buf.buf_size = DEFAULT_SPAN;
>> +		unsigned long cache_total_size = 0;
>> +
>> +		ret = get_cache_size(uparams->cpu, "L3", &cache_total_size);
>> +		if (ret)
>> +			return ret;
>> +		fill_buf.buf_size = cache_total_size * 2 > DEFAULT_SPAN ?
>> +				    cache_total_size * 2 : DEFAULT_SPAN;
>>  		fill_buf.memflush = 1;
>>  		param.fill_buf = &fill_buf;
>>  	}
>>
> 
> It has a bit of code duplication feel in it so I'd consider adding 
> something like ssize_t get_default_span() (perhaps there exists a better 
> name for it that is not "span" based). Also DEFAULT_SPAN is no longer
> truly the default span.

Good suggestion.  How about get_fill_buf_size()?

Regarding the "DEFAULT_SPAN" it seems to have some 'magic number smell' to
it. When I tried to eliminate it and only rely on cache size the tests
were failing on some earlier platforms with smaller L3. I then started
treating it as a minimum in order to keep original behavior on these earlier
systems. Perhaps renaming it to "MINIMUM_SPAN" would make this change
clear?

> 
> But neither is the end of the world as is...
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> 

Thank you very much.

Reinette


