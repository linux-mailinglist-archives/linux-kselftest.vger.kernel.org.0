Return-Path: <linux-kselftest+bounces-16163-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C1295D303
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 18:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F4A1C2373F
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 16:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E62518A6C7;
	Fri, 23 Aug 2024 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FQy/P+xR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D046D188A1A;
	Fri, 23 Aug 2024 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429870; cv=fail; b=lFOfNX/3tBWzWHrhl6eTXQxGLNN5cQDpnrZAPKfrUNUv0fVsRtcmXVFYlTEKAKtGKz/2ycXh1eMFQlCsy0LA2jLQh1q+4NcBcUAl0kCk48SkR7J5ifd6+YpeHefyXep0hqUFvqRoxnL8zsR4gTT9JBDjHqB4pVa7nJ1BlafYXeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429870; c=relaxed/simple;
	bh=fwmq/ahLUT2rJO2qOkc4PebQ287okSMZzUIKxYMP1OU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=figWdHFBJ1gGZ3+kQxd0pXSLmSeenI3ZfxRcITD+TD7GQ64fZgTHghpTRq2xTSBoGv8TU5zr/kytFU6yQRD3dE88KJATAktidIERd4lcmGXjxr46/CBKGYhbvoZtqyixsZWVbwiF5VAaY4vMPROYHv68iplv0IPpF+af01c13j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FQy/P+xR; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724429868; x=1755965868;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fwmq/ahLUT2rJO2qOkc4PebQ287okSMZzUIKxYMP1OU=;
  b=FQy/P+xR9W0OZEao4pnJVmRrN4w4GGhayTU0iaEl98YpSeYPSEfBXfaA
   rvzaWbjtUNIhNxp3UPgvw5mgK5p6hZFZmoigUkSXiAOXKMcEmArr7S7Lc
   GaIaLXO/6xpkQcuuaTMHATav9odiYgE3UM4PFNtjDadUKpj0s+qa1DjYU
   UkTliC6h6xK1JPwmGdCcAINwt1eYfOFRe9LROUIpdYMvSw53wR8VYt57q
   Qt6/W1s8AEQe/aceDmiUnDpStRq6B8xYh9zV2pj+Zqzmj7cVOdzo32lsy
   OaKDU/K5+8Xib37gRJPjcGoqUZ8Axgpkcy/0uX/cl+M4UGkTsboIx59P7
   Q==;
X-CSE-ConnectionGUID: IVYoOSO9R9ij8ujLfOskGQ==
X-CSE-MsgGUID: bgKL+nXxTV2Od75XEo7s7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="23074538"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="23074538"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 09:17:46 -0700
X-CSE-ConnectionGUID: haQ7KFwPQJOEJNr9HzeX2Q==
X-CSE-MsgGUID: 8/G4I2roSPW0nZ947dRgMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="62000955"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Aug 2024 09:17:44 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 09:17:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 23 Aug 2024 09:17:42 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 Aug 2024 09:17:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXeWVt3q7JGiiD/09GwNN61xxBERinbS9jh60KR2/M9sPhxD/HjSNE6lW5OszUNDtKQ98arIsdQhA5R5WXI4lyzz+auaagtRB+LUD6pvDmhDVaoxZ/NidiJEKdNbrTH2hZ7RJQwUS1sMAe9ikY1A5KUuDRSk+eqsozVYgrbZO00TXLSypzBwmNAqd6BqdaKnQsKPLgWn0FflGv9nKRqsnKpfON163cNlBl6+LLByjmiXAhmYnCoHNVEMMGKbFKIGBseAxXvqIH1PElYu6xpvLw7vU/MWhwi3GsulaEMQ18w8vceELMHvCVjKa0ad+DNAS09INWwuRR4Ba/7CeLsnMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAe46ox/BjptXruxnn6YwAIZ7JYq1whWgCZgxRltxfs=;
 b=PTBYDpfGPzahT8xN3J6tI4JPjUeu7qPsX7Maw7BxBwKHj4kmj0ZJkWPpJilQ6lKEWHoiKpT2u3n7iEVNirCuhQUf0zDVOA5SlQ4g8SYtEjMe7ER0p8K7OJR+1qAvGiFO9rCXVMn8jO65lCxL6le66sYwRcxRfCkQ19Srhs7btcsTrTfkh7fhX4EY3EW0dugcyo68IM3vWhaAJY8fbkozFaPayhcZVh6D4F2JRJDjNingyaoXD3kGGL7pMEN6jRTKiB0DN4YyHHXz0hO2PiBU08xzXQA4wqZGIBc3116xmdHHteZ0nOIfrFfFEt5rz5P+1IX9LiPenGnoW6zRSHeQZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB6816.namprd11.prod.outlook.com (2603:10b6:a03:485::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 16:17:40 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.019; Fri, 23 Aug 2024
 16:17:40 +0000
Message-ID: <d25ef936-4cf4-42f7-bccc-54b8e7e590d1@intel.com>
Date: Fri, 23 Aug 2024 09:17:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] kselftest: Provide __cpuid_count() stub on non-x86
 archs
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Muhammad Usama Anjum <usama.anjum@collabora.com>, Shuah Khan
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Fenghua Yu <fenghua.yu@intel.com>
References: <20240822081114.4695-1-ilpo.jarvinen@linux.intel.com>
 <20240822081114.4695-4-ilpo.jarvinen@linux.intel.com>
 <cd09f5e0-2353-4223-b02c-aa8461c1dbe5@intel.com>
 <3f75d979-44f9-6386-85df-e45214f7da7e@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <3f75d979-44f9-6386-85df-e45214f7da7e@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR19CA0044.namprd19.prod.outlook.com
 (2603:10b6:930:1a::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d4af681-5233-4797-e1eb-08dcc38f1c0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dS9sVC82MW1GRndCYUFkSDduU1A5K21XTS9RUWowSXhSdC91alF1ZkUxNXNp?=
 =?utf-8?B?a2dMNEs3Z3JVaHVpY2RtWncyMFpOTzl6aCt6eWk5c2RYRkw5MkpOaXZ6N0NX?=
 =?utf-8?B?dGtVdkxWNGE0VUs4OEdWUlJsNXZ2ZFJXak1SZkRYRk1tSzRXQkovYkVNVllU?=
 =?utf-8?B?cGpUdnlEdG9kY2xUUlNHWkFibVY0UnF1aHBEUVBVMG0zN0FmNEZldWM4eVdN?=
 =?utf-8?B?cDZXOU8rbzV0b1hmSEJUUng0Q1J3TlVhNTl2S1o3YVI5U1FJTW1YY0d0NG83?=
 =?utf-8?B?c01nSkNzbC9RSWZOY3NFWDVQZFpXZlNyTWI0d1JoWk5jRktsU1hYWVpLTTlM?=
 =?utf-8?B?ZldweXNRUXNwY3lmaVRaNHREMjdxTFE2WUQ2NHpFTHhqWENMS0psT0VIRVFz?=
 =?utf-8?B?cVkzd1N4TVdEQ0VLUWRMTGdlNkFnRzdITnlHSUZJRjY4bDE1dVE4bXphMVVp?=
 =?utf-8?B?VysyNGZMZjFXaTdNblBUaFYvZlJydklOWW1xWDZNUitzKzAxUHJ3Z3VyblB5?=
 =?utf-8?B?NXdjU2Q1VkhoY2N6WHJYcko3MXRFaVhwMlNhQW5yTmtaem44VllvTGJ4UjRs?=
 =?utf-8?B?Um9DaFlyRnZLMHAxYld2QmZRUmJGRVJTTU9wQlVYWUNXWURwRGVnNlhFcnhH?=
 =?utf-8?B?SXJCbTZJMVBiQXprRWsxTXBVS0R0bmZFcU01clAwa2hETk1jNTJUcGFiWW5p?=
 =?utf-8?B?RjBYOUV6Z2dKMTlVQ3EwZXJHOElPSGQ4b1BuRGc1VnpUNEZRQVZ6UVdFaGNK?=
 =?utf-8?B?TDNKcXpEYXl0ZlZXcjQ0SEtRc2paa0tTdmdCZitDV2o0dXVxZklZRFZQbkZT?=
 =?utf-8?B?MzkrSWZnSzFmZi9KVFVCNUFGaWhqT0ZFQ0NJdk5qb3BWU2xrWFZwMHpXdWU4?=
 =?utf-8?B?Zi95aDJ6VnB2U0wzdjQzMVZmcThsaUxTRENFYWZldjVHUklBTXFWM2E2eGhY?=
 =?utf-8?B?UEFnUGgxYTdjS3lsa2pCdEhxSGlSS05LODE4VENTMTNIcDRZblBSQ1RTeCts?=
 =?utf-8?B?dXhOVWwzYndBTFduOW5PUVdCaWIrYUkxUXhCVXRTTXAvS3U5VzV6eU8ybUlJ?=
 =?utf-8?B?cmIvbkdDYVIxMEVBeERyRHgyUHpEUkYwM1hpZmZtUkdFQUF6aVZnMzFBenJF?=
 =?utf-8?B?c2JqTFVIRHU0ZnIrUndJUXpCZkx6RmZTalh1eS81ZmladVRLV01NYlRaekRl?=
 =?utf-8?B?TjRya0Z6U2R2SVlpaHpSMnlmZi81RGJuSS82YmJYaVdwN0NYNEJLamVSZEg4?=
 =?utf-8?B?S0c5bzE4S0RmQmhMZ3dqVXcwRGF5eHV4YTFhakZ6N1czakhDblJhRTJ0N1FC?=
 =?utf-8?B?U29kbUg2cThjVk5hRGR0TnVpUzdRaDFNRnpMaFFWVlJtajU0YnZSY3o1cDZq?=
 =?utf-8?B?U2srV0ZoMU0yL2dGNDVoamwvejZORTRWcVJ2Q3BneDVnU2s2QXJRZ2JGNHBB?=
 =?utf-8?B?TlQvU1ArMklaaVlsSEFMbU1FYmd4b3lHZ0lrZXkvbkZTNEE4UWJzRlJVaGpH?=
 =?utf-8?B?YzJSOVZaZGJSL0dEYmVYb29pWmJhRGQrZUVqNTluUmFjb2hnbVJZeTJxV3c1?=
 =?utf-8?B?Rlhqa2tCZEZzNVRBai9tWVhDeEdXMU0zc1Z4Wjh5eTBrV1hZUi9NZ05wT3ZV?=
 =?utf-8?B?ZnppZS9peFdKd3FROFFCR3BJNWQ5U1Jnbk1Sd0YwQnh3UmlncVJYRWxzdlJt?=
 =?utf-8?B?NGxaWGFyNnlycUdnS3pOenNmSDF3TmY1MENQNWRndmVUQjU1UnNVZFZGSzhW?=
 =?utf-8?Q?CB6JKcB3Ty2ky+bBoU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elEzNk4wV2QwYkJLWm9uM3VLRlhkQmd5Zm12SlI1WHJDODlNMFV6NzFnNkpr?=
 =?utf-8?B?N2VSWXhvMU94Lzk3RzE1bnN5Mkp5RTFpdkpYbFZvMllHUkgweS9MdUlnWEhT?=
 =?utf-8?B?alFCYXUvTVA4ZEFBVlZCa2t5WFVkMm8xemNORUxISXZJaEFPd2NRQ05tUUpx?=
 =?utf-8?B?ZVVFWUhVdGx4Rk5rWmlTN0xoZHJKMjBNUTgvRHZ5TVdBaUUxTmt5bGdLL3FF?=
 =?utf-8?B?b2FRaUlXVUhsOXozZHMrUzVjOVF2U3JqcVBUa2wzUVFNb2FjZXB1NldJbits?=
 =?utf-8?B?MmdWQ1pSV0NHVVd6RC9YZStYVEc5Y2UvUWQyNE1mK1FRYlpzUWhJeGRnMVMx?=
 =?utf-8?B?STZmS0tSRTA1b29hUFhXL2I1enBXeVdQUHhsVWY2eVJSOE9LL0phZUIxei81?=
 =?utf-8?B?ajZ2ay84alNZMVpJRHQ3VU9LQkFDa0ZDUW82eHh4SXRmb0lkY1cvd3U0TnNt?=
 =?utf-8?B?citTRkEzeW4veUlDYkJaaElTM3ROQzliWnQvM0MzWG5OaUpyQzEvSFFnOXJx?=
 =?utf-8?B?L1VpbUVYalhoM1BuZlphZkZrNDVBTFBSMXNJYVQ5YTJObldlNkwyT1BpUHNY?=
 =?utf-8?B?WFdqQ2hrSUlGcmpRblByVGU5VXRmL2xJd21VQXdvM09xUTVrZElxTU9VNWRV?=
 =?utf-8?B?cEI1UUpmaDJicnc1VkJLRmlBZ3Y3dU14U2pRVHJFTWR0MnlmODFkdU9GV3dY?=
 =?utf-8?B?amJHM2VMVTFRUGVGYUpyeFA4M0dwVFhzc25EQ0pTWXJUMXN4elNvNUJkWVNa?=
 =?utf-8?B?cUdVOXVLTTRsalhhZlhLdnU5dnFlTDVBZXFNYmtMQXIxRG9GWVd5YnZHamwz?=
 =?utf-8?B?VWRXd1pZMHBpamE2RjVqU3ZiNkRQV1VSdFJoR1RuYUk5aG9TZ0dkR1hNc2V4?=
 =?utf-8?B?bS9TMVdMQ2FjNVA1YmFDWExLOXNSUTVtNlJobHNzRUpFREduYjlLaDVWV2hR?=
 =?utf-8?B?bVZRcm5BVUtTNjdUM1hBM3krZEtQUE0zcEJqaXpIMy80cFErZ2NkVXQ1eTBk?=
 =?utf-8?B?M1lldmErVHRjcHZTejVwM1M3dlZWa1JYdHk4ZDNMTTlUM1NwSDNGUldRa1ht?=
 =?utf-8?B?Sy9sbUhFRGM0djhvcVN4aUJTY0hrZFpBNHYyNWNHc01NL1kvQ1Vma2hHRXJE?=
 =?utf-8?B?WWtWcGNYeFRxaDZxMUM3YW9JS29WQWxNOUc1ZElaeFlUL013VmlldlFGMWhM?=
 =?utf-8?B?bndjRVZwaEw1N3AwcDgvNW5Tc2NkYmhWWksxc3k4WjdxRlR6bmxFaWpWbXFI?=
 =?utf-8?B?T2Fid3NPZVlxeUMxekRCRlYra3VRbWIrYlA2V2VSVTRuaGFQS0plaTBSc3V2?=
 =?utf-8?B?ZTJ1NDA5eGZNOHdyQjgzSk00T1lWQzhoZi9QZ0ZIUmtleFRDSjRqeVdMVlZL?=
 =?utf-8?B?dXFSazJnMEQ5clVTa2FRYTA1NmxibWJHblpJdWJSZFV1LzBJRGR3TFl2ZWg1?=
 =?utf-8?B?N3pVWnhicWtNeS9CQ1VDSFJZc2E0TTBITG1uMGFNUi8zaThBemFrTkk2UEc2?=
 =?utf-8?B?amszMGVRV2M5dW5MZFpRQWs0T2RGN29MOFNoUldGZjF5aHBlcDFJNC92RmdT?=
 =?utf-8?B?U3c4SEtHblFrYzNkaUhoalpVQWtRN0RoL1BYYnpDbFluR0szSElDWWI1Mm1G?=
 =?utf-8?B?QmsvSUJjSjN0NmpSNmk3M0U0RWNlMUJvdDZydzhDMmhNZEpjdEJRb1g5TXB0?=
 =?utf-8?B?VEtualBNdDgrcERiUnREWmVJU016ZHBLQlhDMEFxeEJBL1lOUEhzK2l2a3JW?=
 =?utf-8?B?RUlJZFpTN1hFcnZQM3BaWXBuTkpIV2VObmpBdE9uclEyZ05GQ0ptNTliR0pr?=
 =?utf-8?B?YndhM1F2Qys2SFZKckNVa1RjUFhBUHJERGlHdGhqdFEzTmpseGkrdGYrbmhk?=
 =?utf-8?B?ZFBudFI0QXhDNTBBSzltb0FGUmpLTXFPTDBGN2dBWmw0djdkalBWRk1JYkRp?=
 =?utf-8?B?VGptWGxlMzYwdDdudmJmK1RyTFpyRHA1eGVRbWZKYXBFUkRZMG5XRy9uOEdJ?=
 =?utf-8?B?RGM0QkNQV3lsdzk0SVFHbThrZTZMVHJvL283T0gzem9QYmk4VjVrSFZHNGNQ?=
 =?utf-8?B?eVQ5U3R3R2ZOVVdTazI4Mkx5L2RVdDJNVllINnFKVHNBSWVHU1kwbUZoMmdU?=
 =?utf-8?B?azRsMmdUNTlaS25WRStiWEthVnJmTHIybnRNT005R1o1Z01sL1pJNlQ2K3RD?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4af681-5233-4797-e1eb-08dcc38f1c0c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 16:17:39.9216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFBE/g1/e5zt6JweE1iXAPYWkO+a9R4q9GXs7FuVT/tuSpR/N6ISs0sGTksmUn+qYy0OTsErAHsq3TxZFEXLrXLdCfyNiJOQ3ulQ3y1QzXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6816
X-OriginatorOrg: intel.com

Hi Ilpo,

On 8/23/24 3:47 AM, Ilpo Järvinen wrote:
> On Thu, 22 Aug 2024, Reinette Chatre wrote:
>> On 8/22/24 1:11 AM, Ilpo Järvinen wrote:
>>> Building resctrl selftest fails on ARM because it uses __cpuid_count()
>>> that fails the build with error:
>>>
>>>     CC       resctrl_tests
>>> In file included from resctrl.h:24,
>>>                    from cat_test.c:11:
>>> In function 'arch_supports_noncont_cat',
>>>       inlined from 'noncont_cat_run_test' at cat_test.c:323:6:
>>> ../kselftest.h:74:9: error: impossible constraint in 'asm'
>>>      74 |         __asm__ __volatile__ ("cpuid\n\t"       \
>>>         |         ^~~~~~~
>>> cat_test.c:301:17: note: in expansion of macro '__cpuid_count'
>>>     301 |                 __cpuid_count(0x10, 1, eax, ebx, ecx, edx);
>>>         |                 ^~~~~~~~~~~~~
>>> ../kselftest.h:74:9: error: impossible constraint in 'asm'
>>>      74 |         __asm__ __volatile__ ("cpuid\n\t"       \
>>>         |         ^~~~~~~
>>> cat_test.c:303:17: note: in expansion of macro '__cpuid_count'
>>>     303 |                 __cpuid_count(0x10, 2, eax, ebx, ecx, edx);
>>>         |                 ^~~~~~~~~~~~~
>>>
>>> The resctrl selftest would run that code only on Intel CPUs but
>>> as is, the code cannot be build at all.
>>>
>>> Provide an empty stub for __cpuid_count() if it is not supported to
>>> allow build to succeed. The stub casts its arguments to void to avoid
>>> causing variable unused warnings.
>>>
>>> Fixes: ae638551ab64 ("selftests/resctrl: Add non-contiguous CBMs CAT test")
>>> Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>> Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>>
>>> v2:
>>> - Removed RFC & added Fixes and Tested-by
>>> - Fixed the error message's line splits
>>> - Noted down the reason for void casts in the stub
>>> ---
>>>    tools/testing/selftests/kselftest.h | 6 ++++++
>>>    tools/testing/selftests/lib.mk      | 4 ++++
>>>    2 files changed, 10 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/kselftest.h
>>> b/tools/testing/selftests/kselftest.h
>>> index b8967b6e29d5..71593add1b39 100644
>>> --- a/tools/testing/selftests/kselftest.h
>>> +++ b/tools/testing/selftests/kselftest.h
>>> @@ -70,10 +70,16 @@
>>>     * have __cpuid_count().
>>>     */
>>>    #ifndef __cpuid_count
>>> +#ifdef HAVE_CPUID
>>>    #define __cpuid_count(level, count, a, b, c, d)
>>> \
>>>    	__asm__ __volatile__ ("cpuid\n\t"				\
>>>    			      : "=a" (a), "=b" (b), "=c" (c), "=d" (d)	\
>>>    			      : "0" (level), "2" (count))
>>> +#else
>>> +#define __cpuid_count(level, count, a, b, c, d)	do {
>>> \
>>> +	(void)a; (void)b; (void)c; (void)d;				\
>>
>> The changelog states that this casting to void is done to avoid unused
>> variable warnings.
>> It is thus unexpected that not all parameters obtain the same casting
>> treatment. It looks
>> to me as though this only targets the resctrl selftest usage where the "level"
>> and "count"
>> parameters are constants.
> 
> The reason is entirely separate from what resctrl selftest expects.
> a-d are output parameters for __cpuid_count(), they need this treatment
> because they are typically not initialized but set by __cpuid_count() so
> if __cpuid_count() is doing literally nothing, nothing touches those
> four variables leading to unused variable warning.
> 
>> This is intended as a general kselftest solution so
>> I believe
>> that all parameters would need this casting to handle the cases where "level"
>> and/or
>> "count" are variables.
> 
> No, the same issue does not exist for input parameters because it would be
> a valid warning. Passing uninitialized (and thus unused) input variable
> is wrong so the calling logic is wrong. Thus, I don't see how the same
> error could ever occur in a legitimate case for those two parameters.

If I understand correctly, the scenarios below are legitimate cases and
will produce compile warnings with this patch applied. It is not obvious
to me that the calling logic is wrong in these cases. If the output
parameters get special treatment to avoid compile warnings, should input
parameters not also?

scenario 1:
	unsigned int level = 0x10, count = 1;
	unsigned int a, b, c, d;

	__cpuid_count(level, count, a, b, c ,d);

Above produces "unused variable" warnings for level and count.

scenario 2:
	unsigned int level, count, a, b, c, d;

	level = 0x10;
	count = 1;
	__cpuid_count(level, count, a, b, c ,d);

Above produces "set but not used" warnings for level and count.

The changelog states that the goal of this change is to produce an
empty stub. To me this creates expectation of what we are used to
and expect from if it would be an actual empty stub. For example,
static inline void __cpuid_count(unsigned level, unsigned count,
				 unsigned int a, unsigned b,
				 unsigned int c, unsigned d) { }

>>> +} while (0)
>>> +#endif
>>>    #endif
>>>      /* define kselftest exit codes */
>>> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
>>> index d6edcfcb5be8..236db9b24037 100644
>>> --- a/tools/testing/selftests/lib.mk
>>> +++ b/tools/testing/selftests/lib.mk
>>> @@ -199,6 +199,10 @@ clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
>>>    # Build with _GNU_SOURCE by default
>>>    CFLAGS += -D_GNU_SOURCE=
>>>    +ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
>>> +CFLAGS += -DHAVE_CPUID=
>>> +endif
>>
>> My earlier comment [1] when this work started remains. This technique depends
>> on environment passing ARCH, which cannot be guaranteed. Looking at other
>> usages of ARCH in the kselftest Makefiles it seems that the pattern is to
>> initialize ARCH with "uname -m" if unset.
>>
>>> +
>>>    # Enables to extend CFLAGS and LDFLAGS from command line, e.g.
>>>    # make USERCFLAGS=-Werror USERLDFLAGS=-static
>>>    CFLAGS += $(USERCFLAGS)
>>
>> Reinette
>>
>> [1]
>> https://lore.kernel.org/lkml/db16db55-5f68-484f-ba9f-3312b41bf426@intel.com/
> 
> Ah, sorry. I'd missed that comment because it started mid-paragraph.

Where are comments required to start?

Reinette

