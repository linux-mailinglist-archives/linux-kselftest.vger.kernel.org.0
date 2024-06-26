Return-Path: <linux-kselftest+bounces-12827-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6F191995F
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 22:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9B51C20D77
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 20:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE090193064;
	Wed, 26 Jun 2024 20:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DS/NnODN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81F015B10D;
	Wed, 26 Jun 2024 20:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434696; cv=fail; b=een4o8cOPWcwOJ9jiUKBaD1CbBG/AMc7+A7yXYumy4F/wuShqD+5Gw2x/nktRt5fH73f+VBqxwJ/HiTApELDBD4K50oJrFBwdNhGT9oquT/JLC7HZ8mHdtvKGrJj+6CUavyTmQuwh4ytCjqVy9LZTyQ+oG70Eqj02CTdTUWJ8tM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434696; c=relaxed/simple;
	bh=umwdjMlhGoNoZWRyQ0lhCvI10xvPSX80xG866Tek0FI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dxa1w7jmM/E1rAbK2d/KAm2JmMF3V+wzDllZEO3W0BBsu/gW6fOGrdRxl32V42Oflcy/ZXLgxbcU47iWvD/+ZkTlh0Mj2IYmAKqFfT72fX+VwNrPWWPgiXYfUUPrxoZ/2Bjiv5SsD76SfKsi6eqC3Cu9Jjs/BgjE2Xe1HmyTlE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DS/NnODN; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719434695; x=1750970695;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=umwdjMlhGoNoZWRyQ0lhCvI10xvPSX80xG866Tek0FI=;
  b=DS/NnODNSEy4+yCvoFSME8/P5DLDglAZ7Tk16AYu8OYWvOECPKsY16ob
   KauAo1vF3zku6hK57ogz6CB8JPYqKYwD5awYTnC2SIFNgp9yzOEikymNw
   jJk9sE93xrFxweyO9OSsMMNZjJsQwYc0FRR7KBzhvM2T1GjTKWAP0VnLD
   dezQ8vKf5YXT5NAw3WTyP/yugQGpiXMJOYAjtaPbt3oAJoE2LIE97CtjP
   rz7encMrY+Vb/zwZXcnSFS08qwyhejbatvfGbrJIyj78fcqRFiMMRuGvU
   2gHgum6DvXm3NIvsEDQSHHrlPE7DiHnsMfudLXMw+ln6MvCv9VGDlCT5s
   w==;
X-CSE-ConnectionGUID: 4QMpAQTfSyiMvJ1wlzfleA==
X-CSE-MsgGUID: AaX/NjT8RBWStDRulhnmag==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16668659"
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="16668659"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 13:44:55 -0700
X-CSE-ConnectionGUID: qViBym0oQxOlC/7j1inktQ==
X-CSE-MsgGUID: rR58l2ruSfaQ5bl9H8xdfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="49091325"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jun 2024 13:44:55 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 13:44:53 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 13:44:53 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 13:44:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 13:44:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dp3jJExdakpk7ZmmMorlsc93NpLB27aOM5QBTYsI6BUgfpfc1rRHXkU0LS/c2J8zG5F3l1IcraB5APg1kzYVf5ULbSso+IB8Ik63wTNuq8ZL3pv+iIAdA2F/j03t0uCrWGx/bkkFNn+066eiRuijZfBha6vVYomXkRszZc2aHJuMMd/8WM9lqafaXMabctAX9a6dshKroYYvNZIsWE70eIRDhGS0MmyJsYRsYuzM+u0QDa2oKCBe78Jh+aLRmItd/ZaBzFeb7QmkiTypaUMPoqpWJAsaJHdYp8vwmFVF8JieMABK2vKkr/5rG5yLFx6d1vnUrc+760fbIP81T6NLvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opWRh3EZbW0JshizpngIDXAab/ns2L49PnuF0tDTgVc=;
 b=LwwQnYyY3amlEQxqLFxMU0STtV9HXc8fCfe3sjaDTj0LYbP3SEqBbtOvAcqM8sU12blqd6SHV1wM6FoA2hz+Rfnx41mEqc2oubMceOgcGJJNO33iThj0EyOk9+JIUSyARLLhdIuuMX1GHfun454OtxHmy+keQFbMtI/gFg8lL6O/8/qS/MPbg/QbBMbELGz4JCIvpXzXp3ABuYJdotR76AQ+VTVh8Zi434IG0FkD4GqnpGbZkJz3Q4VOltdhuENonqh30qX0a8A0WveR7yvzrOJ4TKGbFKrKkS6gzSwtONvNlvkcs9RnFKX5N+svylTncJiHgxZD2/sQ4MNmd6Sf8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY8PR11MB6890.namprd11.prod.outlook.com (2603:10b6:930:5d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.31; Wed, 26 Jun
 2024 20:44:50 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 20:44:48 +0000
Message-ID: <14fc4648-2ced-46a6-9838-5cea61f1a3c7@intel.com>
Date: Wed, 26 Jun 2024 13:44:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests/resctrl: Fix non-contiguous CBM for AMD
To: Shuah Khan <skhan@linuxfoundation.org>, <shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <maciej.wieczor-retman@intel.com>,
	<peternewman@google.com>, <eranian@google.com>, <fenghua.yu@intel.com>, "Babu
 Moger" <babu.moger@amd.com>
References: <3a6c9dd9dc6bda6e2582db049bfe853cd836139f.1717622080.git.babu.moger@amd.com>
 <96d276c11e69cfb1e29d50a12c8043555c06b404.1718144237.git.babu.moger@amd.com>
 <4be0449a-1337-4fc6-8ed6-fec10cc74bd6@intel.com>
 <7275eb85-67ae-4d70-84ae-702a478eb98a@linuxfoundation.org>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <7275eb85-67ae-4d70-84ae-702a478eb98a@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0017.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY8PR11MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: ef3ece56-bd00-4d12-97b4-08dc9620d1e3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|366014|376012;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFpNWE93T1Y4cEZOc08rYlVGMlZhWGIxdFl5K3J3dXBNOVlvRzFYdHFYV0Iy?=
 =?utf-8?B?aWp1eDJRSElNdnYzVUFrWHlsK3c5R1hPNHNtMmU2ZTZzRzlSMGJ0Z0FmclVF?=
 =?utf-8?B?Rit0dnh6YTh1WWtGRmp4RW1jaFlRcVgyQ1dhMmQxeXhKblY5eUJuRCtiaklC?=
 =?utf-8?B?T3c2T3hHQkIzYkRCSzJxam0xUVozbG9hQktmY2JsQ1VHZUJSbGVDYVBKMzJa?=
 =?utf-8?B?N3RjdmQwbDJtRmZmaGwvQ1pVMC9PYXlGeXpwdFBJZFBQbmdlc2RiMkpWOTg0?=
 =?utf-8?B?UTFKYzlOKzc4eUs5WWwvSk9nVUp6OU9MRkVDTlZrTW96andHemJCS1phckNU?=
 =?utf-8?B?OTJXclJYN1g5R2l0UzBNQ0lmM2YreW1PQ09Sckp1ZldZMDZRVkJPc3gxU3A4?=
 =?utf-8?B?QmxYeWZMSk4zV1dhY0E3U29NVWhCS25LeThnOUJ1RklabUFYNzRkdEd4WmVs?=
 =?utf-8?B?L0xHZ3dUUUpWVTBxZVRSaHdWeENpa0RzVFh6RURiYW9ldUQxTExDVmg5b0Nn?=
 =?utf-8?B?REQ3cm40S2hZdzlXYTlnK1pkT1pkNG1tT2hxUkFPekMxZG93U3Z0cnQzSEQx?=
 =?utf-8?B?eVZXY1IxWXRqS2xNS1VKR3RKNUVxN1dhL0x1M0RiRWJ0QzA0VU5lU3ZQY0ZH?=
 =?utf-8?B?ZmNrbTQ2TUYvV3lXRkI4U3dMVVV0eWV2VnZ2QXpIZDZBOXRoVnZJQWFPalRr?=
 =?utf-8?B?M3U4alFwZitlVEZINldWdVZQMkljRzFBRDljVWt5eDBHV2dCZVhvVXRwVEFN?=
 =?utf-8?B?d2QxTkxtbWRyRVdqR0FmU0xNZmxseEhQQWVsR21rZ3FMUCt3NldpaHhrY3hs?=
 =?utf-8?B?UlhSd21HcWpvTXFRTUUvVEtCaWlGTUgyaW4xamtJQXZuZmdBSTJ1UVY0ZUNF?=
 =?utf-8?B?VFgzVldub2J2NzF1dW5hbnhvUENobE5lZm1PbHhvNWkyZVV1L1U4aHRlUm1m?=
 =?utf-8?B?TTlIV2RvQlZPNVJHWlM3eXB4MUhwZC8xWVY4Y1RWcEhLQmdSdEtVZ0RRWkVr?=
 =?utf-8?B?dXRXZDZIbDVOMWY2V0ZjZTR6bm5qeXNobnYxbGpzOUlEZUw0THVRT2s1SzUx?=
 =?utf-8?B?cmZHMU4yZ25Ub09KeThWcXZ3ME9oemU1YnhnK2RUVERISXptTHcxNDd3V1RE?=
 =?utf-8?B?aTdLS2xFQVRUL2pGL0JibjFpZk9XUlFnUUE1ZnNReG1UaDRXeFpJRE96dEpt?=
 =?utf-8?B?S1RzeENRbGJOS0wyUUZZaW4zQjlHeUhoeFlzMjVCa3JDQ0lmVEdKN09OekY0?=
 =?utf-8?B?MVgyT1dhQm9mZkNEZVJxYVd6RnkybWVGOVppR29YT0RpVE1qUE1lSHlhQWZO?=
 =?utf-8?B?dTcvQlVOSk4rVlJyU0JiUUs5elVtaFR1VkV1NjY1S1d4b2pMckxjcXlSbVhy?=
 =?utf-8?B?aldCV2p3NDh0a0NBOStGUjgzeEs0V0h6Yk1Ba2EwTzVxcXMwZXdjS2RqaVZN?=
 =?utf-8?B?UmZnTzhoc1BMWXpybHVNbjFYMFUyZmhRWWlZMkkrZk1sVFlxN3NaemdiSFl5?=
 =?utf-8?B?OTVtc045djFWbW1lTVB3NkdPN1VTdXJ1ZTRJakRNeEZrV1VoWSsxdlhlcmYr?=
 =?utf-8?B?aUppZ3hGa2Y0b0VRUWk4TUt0RkgwMWVXUkdycnlsS2tNRTF5T3kybEpjYWp2?=
 =?utf-8?B?Qkp4ZkNibndLSS9Md3pabXdzVHVrUDhtbkwxbldxbUJrb0JPaHRUbTNmRlc4?=
 =?utf-8?B?ZmJjSDJPOGxIRkhFQVNXYm9aTnJnai94VXQramN2WlZNbTRpZGpYTGFnRUVL?=
 =?utf-8?Q?hLW+vRCqgWKyTvq0aqXg5ZWbK2ZPAYAd9mqYFtw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGYxUm90Rm1sMysyMXFNOVV1K1lsb0hEL3hSTjZYL1BYd0xRSm1YMTZoVWE3?=
 =?utf-8?B?ZXpCbDIxRjlxeENGUmRNNlQ5TlE5V2wrZlFUcFJWeWJ2NVZiY2Y4L01qMWE0?=
 =?utf-8?B?aTlZcSs2M0JVQWhaSTl4TENMMzYzdjlMMGhDdjlNdGtlREdBcUFCWmZheGNL?=
 =?utf-8?B?UlhYMlhYY29uRjlmRjgvaUZBSysyVk43a1JLWjhOaHVxSDZGUWtVNTUwVzJW?=
 =?utf-8?B?RVhsV0NEVkRCcVN1VUJ4N2txclgwTjlndU1NaHQvWVRCRVQ4dzBYc0Zwam1Y?=
 =?utf-8?B?UmJ1NkdXOFV2b3V3QkQrSVRrRGsrSHZxeG52S1Jwa1dYc3dtTnEvRXdMWGhV?=
 =?utf-8?B?b2M0bHMzdDMwMXFYclJHSWFYQ3d0NWUybm51LzIxdHBERFdrTzdNNTNxKzBC?=
 =?utf-8?B?TTZiUzFxTGp2Y0grRHFrVDcvd1p5b0ZXTlJla0RIbm82SWFvaDlablM2QVhT?=
 =?utf-8?B?bGZQV2NjZitZQTlHaEdYbDdXUFE1WTRpL2NDU3pQNnJkaVc5SktTbmQ4K1Jv?=
 =?utf-8?B?VVU2a3hIcXFnTGc2Q1Y4THhicjl1YU1Hd0hhUWtzbmlDaVBIZ293VDBTWlhu?=
 =?utf-8?B?V1ZSdkYwRmNzM2NEMjNGcndhQi9lOUJ5a0tuM3JOd201cUJZY0w0VDQzTXFt?=
 =?utf-8?B?cUZ5SjNJTUE5dlBXTXVkc1EyZnQ2dlU2dnNTWmVjMzJFUUNKYXhJT3dRTzNG?=
 =?utf-8?B?QVZ5emhuNElxRU14VkxuVWJodXRxWDg1dGNKQXdFbWh6ZGdiZURpL1hFemp4?=
 =?utf-8?B?RXhlb3dZRHNOQWJVZTRJS3lhTHNyZSsvRHN6RGl6M0QvNWF6UThrUWNHSnEw?=
 =?utf-8?B?cFJjbkZmZHpSOEVaalBhaE81ZVVjSURWUGxYNGJoWnhjc2FBYStVamsvOWxR?=
 =?utf-8?B?aUNmbU9ibUtETzZ5OHhoUXhSQUh0VXh3N2hMdHhSMHZ6ZzhtQWxUVjlQNGNK?=
 =?utf-8?B?cXRZSEJUeVdIeC9jdXJFanZxTlRYS3d6c2dKT1g1UHZNUVdDdVBSZ1gySXUv?=
 =?utf-8?B?ekE0NkszSVpxVkFkZ1ptTXBJMWIrK2JGWVMrckhLKzNrSVlRcjU4S0dQaEQ0?=
 =?utf-8?B?QkV5NDExeHNwbE5yRGJOTzZSTHNxb2Y5OGdmN2w3dmp0aEswMHJMdld5aURm?=
 =?utf-8?B?SXh4SnJZL25XMnNMaVZ5Q0xuTzFwOHBLMVhQcEErTlo2bFkrY0l1YlRoeGh6?=
 =?utf-8?B?UU93aTA3UUxaS1NJNkNrOGlvWmRsVXYxTkpkUnVxcFc4VVNYL3l5MjFMUnZO?=
 =?utf-8?B?N0NNT3lzT0RjcjlGbCt0bnBKVWVDK0Y4aGwwMVMyMXV1dVhhVHZTVERHb1d6?=
 =?utf-8?B?QmdDV01MSGYvellPd3RhZVRubEQvTm5jL3pteGRUUEJzV1RYNFUvTW84WHBm?=
 =?utf-8?B?aHg0UVhNMHQ3SkxpdVZvMGVudXBEd2xWbFBhMTdyWW05ekNHenR4cDZHdS9q?=
 =?utf-8?B?am8xMkVRWGM1aUdudGZOSkNpL2ZoMWR4d05nSHBmNjZLeDN5MG5VTmhFL0Rl?=
 =?utf-8?B?MmZRV1dLM05VanBOR0RxZy82bFYxR1h4MXVtWGF1QnZ5KytESHVDZUU0UHJp?=
 =?utf-8?B?VXRmeGFCblpaMWs2MDlwc3pXQlN1RjV1ZkRycVJTa3FyN2RxakUwQmFZN1Ju?=
 =?utf-8?B?VzNVRkkycWFOdHdsci9GQ29rWDJ5WnRFOGlNc3RpMVl4Z3lSQnYvZGcwd3F5?=
 =?utf-8?B?MXExeEFhUno1ME96WWxjUk1rTytpUytMM1diaS9OWjN2L1NGUVQ2ZElhc0JB?=
 =?utf-8?B?RmdXVUxtc0JUN2RzMDJpa2dPUC94Q2hiYm9vOW1lT1JuQXVHd2ZHV0pnT0Q3?=
 =?utf-8?B?cGVVTHF1Qmlud1BpcWpNRzZKVFMwdDN1Q2hGdkFtOGtVWGJxUDV4a3RVV1Zj?=
 =?utf-8?B?VzZIdTZNMlpYQkVXNHAzazBKOUw3UERBN09zckhjaGZ6RjFrMlVGdmZraUNa?=
 =?utf-8?B?ZVpmVExpVHRSc3FGbmdETCtYaHNTQnp5QklEbWx6SzhyOGtCMzQ5WHloNDdx?=
 =?utf-8?B?d1R1bTN5b2RTUEdDYytKcXpLazUyMUNGMyswQUpsa0ExUEFFTGlPKzRtN0Nj?=
 =?utf-8?B?M0RHSFR3dEd5ZEQwSG1mTEhkZEgwWnFCN0V5TFNaVmp5K1U4bUo0Nm9tMWVJ?=
 =?utf-8?B?aDJ2SFlsdUNJd3hOTUxZV3o4OVhtN3NIL3BUYW1kTFJhMGowNEI0Rktzc1ZS?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3ece56-bd00-4d12-97b4-08dc9620d1e3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 20:44:48.6036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0eoCYZ8GusJF6c1+FSowp+OnbcWO6OYzUTaM99c7gYaQ1VRXBn18/G9D12NCXIhmIRWxaqoCltIa0KOZlzHuD0wociv8hKb675fbhk3pV4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6890
X-OriginatorOrg: intel.com



On 6/26/24 12:25 PM, Shuah Khan wrote:
> 
> Applied to linux-kselftest fixes branch for 6.10-rc6
> 

Thank you very much Shuah.

Reinette

