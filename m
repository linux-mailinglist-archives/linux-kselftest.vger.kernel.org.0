Return-Path: <linux-kselftest+bounces-18658-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7845C98A94F
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 18:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65051B21900
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 16:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B243A18CBEE;
	Mon, 30 Sep 2024 16:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PiDDW1On"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070EC188714;
	Mon, 30 Sep 2024 16:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727712320; cv=fail; b=C9Lb2/QrIbZzbRwTeKTomoSWwu8z/asEWjk422O4G3tnj6zIBpatkwnNFoG3tIC6jsAQ8d67tdaX7ktTi7UN/dACYJ2Gckkr6vbYgIRv67ftUtv0xNfadkggXifk/VdndJKy2wPZNMcl+RFwxyIK+tSXgGCT13oYJHSYR3KQQpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727712320; c=relaxed/simple;
	bh=xQSN2z7Czmqx25GjCSA2YJAimLZLmbrFYSdUpihfprM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LpZTjgumP7JeGpr8FirJWtFUKxyHiTz4rSaR4CYPWmGciu0PthW4cPAzV0Tu5xE6KAHZyVhJEhohUxGECk0nWAw+gUsgUJsJBa5DtpQkR52hAYRX4UOtkLPL/9sb1RX2hu70f/asE7Du8w/s3EYJPPyANxEQ7yxjznRSYER+WcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PiDDW1On; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727712320; x=1759248320;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xQSN2z7Czmqx25GjCSA2YJAimLZLmbrFYSdUpihfprM=;
  b=PiDDW1OnQW9KHU0VHla56r5bh4Fy6NCqvwrs0NMa17SGaYKjvXAFTqdL
   z3xQKx1J5d+ur9sLvAlWzbRiTNUa8i+8XugIjOYJkmjplFNjR6+fM5qnp
   /HK4b9TAIpgCZg8BsfcQ/Ht/mq496vZiHXz5fE1ji7QAL89tSouLAXWse
   MRfTvc0KEASVU82ctfRFoL+dOFeTHTwdj0FEjucEMCmljNQ6F6OYy6uNA
   govQWgVjYesruDjJSnPPRLEzHu3zm2+GcX8rWNGBJRKVQ+Uxh2+G0GvCJ
   TMOnm8LUSWzVpkFNh0jo4PVYfL3Lkrl7PvLL7ETH2srKLhbW/G5RAaXsC
   Q==;
X-CSE-ConnectionGUID: F0WbYQ7XRxqxFK/lup+W/g==
X-CSE-MsgGUID: lRXTqkTHTLW00j2xcwxfhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26942617"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="26942617"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 09:05:19 -0700
X-CSE-ConnectionGUID: G8hSOe+ETxq+vPZB5LUJJg==
X-CSE-MsgGUID: TV9Q8V1oRKOiekmi0yczyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="73020867"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 09:05:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 09:05:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 09:05:17 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 09:05:17 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 09:05:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7EIe51wlmvI2la3kUXTRjHJCsfyQUgcugTcYtL1Ols1cuecA/g/zS/F7vP2Au44RVIOCXBmg6daZxvPCRFVHGMUDclCQbAMPz5vuVBFWoI63Su5oEcW1bU/T5iLVGBg3kOYIf6EQCZZQSdNNUdxIXMN3dHAvqEnQG/YRc9fKbRDDxGJss4J3jK+fxGAPUIrAykuQRFiGR1cs9KmuGu4WV99Tb0pbxX0ZrFghOoq+9rbyJF91Sz5eJQI9CFguGpeqmPS5TbiWOl0CuUT5gupnmB8cG/TrCLzggAa0/2TKDxcRt+aAEt0O75DCgCq3vnJjmMJ0O6/xYZ0e41vvsK5Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=teU033cqISP041VeiAcw9Lv0HJZ2DIhNwaaZcD46coE=;
 b=lLbLkr1Z8qbN9f+codqQMXQFIBEWvplUqGG8HPwtCGyjhjAt2DsRyFFcKKN2OzgX0Grt9U3gxoOuzpa4X0+Has3Vvnhw4rfA1ML4l1m4HDjixxayQlS9/qzdV3uSXYAdPmLacnFSaNoOP2cKUh4Io122p9LXWqkYoTr2COsp0LgiASbWqkspBmH51mR+ztStPhIcJTPjWVG0ExMpMimvVe6nJnEumG7iyRBoZrNbmQPBk18IYIe1VEIyck97au5SzAM3vVXnm8b/d5fOPZhvzBpccLE0jAJOr1KEDJxCLDCqGh31swAQA5ViJd8kig6tv9kCY1mZ4/6CwWo+UFAqVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6192.namprd11.prod.outlook.com (2603:10b6:8:a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 16:05:09 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%6]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 16:05:09 +0000
Message-ID: <2b6100e4-5d77-419b-abe2-51c4af38481b@intel.com>
Date: Mon, 30 Sep 2024 09:05:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 07/13] selftests/resctrl: Only support measured read
 operation
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>, <tony.luck@intel.com>,
	<peternewman@google.com>, <babu.moger@amd.com>,
	=?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <cover.1726164080.git.reinette.chatre@intel.com>
 <491d5a951751dd74ccb84e175f6dd457dbed5c31.1726164080.git.reinette.chatre@intel.com>
 <f18e1956-0eda-2674-2948-72059489c21b@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <f18e1956-0eda-2674-2948-72059489c21b@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0178.namprd03.prod.outlook.com
 (2603:10b6:303:8d::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eeb74d5-9433-4929-3242-08dce169a8a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWNPZDVBRks3UTROa3R3VkZjd2hBb3hpZEg4MzNERXdkMldrMkNsQ3VXOWVq?=
 =?utf-8?B?SldOUTI3bHZnMlVJZkozd3lkZ0NBNVNnYnRvN0VIVFpSaHpzT0F2aERQNWMz?=
 =?utf-8?B?a1p0SHlDUy9kNHpsbWE1czBkSlFJMXhkRmh1alNBVnNxK0U5Q0hFR3FyeElK?=
 =?utf-8?B?eXNLcEUvQUduNkFYM3oyQ0ZCaytITlJoZUxZVE5tS2FkRDNidmJ6blNKakRG?=
 =?utf-8?B?cERwM2FUVXBXT1lpUFRTbnBQZHlybTdjR281WEwvRzhGZFkwTXJyLzNNSlFp?=
 =?utf-8?B?d2Jsa1BJM0ZyWkQ5a2w2djNjRGF5NXBpcXBGRkxmMUZvNlcya3hybk42VnBa?=
 =?utf-8?B?cDF0RUZodjhUYmxOUkV5RzRGQXZua1k1T0RPWm44eG4vSW16a3VYMDNLKzNv?=
 =?utf-8?B?b1lWZCt1QVRWVURzMnJ3MDBzWHdodENkOHowUWtXYlErSEJGblE0aFZvR1Fw?=
 =?utf-8?B?WVN2MElCY0J5WmhwMVZtRjJFUzlOdWZVTDN2MTVlU2JhVU9xeWFVN1RFY0ZS?=
 =?utf-8?B?eXZPWHZIZ1h3N0Z4TlZlU1cvcFJOWk4zaVBsY3NvMWlBWStKL3YrSjdzWGEz?=
 =?utf-8?B?NmZnaEZNZSsvdURnck9WVWU2dFl5bWxSNTM2dVF6ei9BZjFtdkhsazROQ3lL?=
 =?utf-8?B?bHZ0MDJKRXVKQTJJcTBZbzR6RWVTMFdMTG1zejZYdUJDQlhBU24yeStIdExP?=
 =?utf-8?B?RmgvRHZKdGpTdFExR0JCenVJaHp4TzBzRzZsSzR1eTNlVkFldHdVSmdQb0hE?=
 =?utf-8?B?VmdCOGlvM3RIRE9DSFQzSmdNN2pLWDN0amtyYUs4d1MrWDRsTWtTb2k4aEcv?=
 =?utf-8?B?NUdyZHVRQlJIQ29BSXU3NEVXUDYybzNITlRvT1NrNXRjcVdFbkRqZFNST3lY?=
 =?utf-8?B?eDhZaEFGSXBFNTdmeHRiM1NZUGROZlFhZHQzUU9iWE1nMjlQenF1VFRRa000?=
 =?utf-8?B?dTRhd3VNMG9kMkFOT0xvT0hMb0FrNk55VU1vRHNJMy9GSFFWK1g0OW95WlVs?=
 =?utf-8?B?WHBSMUtIZldKanRnRVdmSmpUbExZSTVlMk1oYnFzdG1UOUFSQmFlVFpvQVY0?=
 =?utf-8?B?RVdOd0JzZzlZUW9RZTRCNVpodWwxY0Nia2lySEpQWm9kV2J3YTh5RWdIRlp0?=
 =?utf-8?B?cFRrcTFtREs4M1VCU1JWbTQ4cjExN0VQaGFneENYNmMvM3B3MmRoTGxRSllk?=
 =?utf-8?B?b1VKRVp5QVBiVW02SXZ6RWMrMHQzOGVnd1FxM3hJSDFDQ0I1STQ5UDc4UktD?=
 =?utf-8?B?dU1VRmIyUVFhb0pLN01DemtsckFqUERHalBpWHFSbXlPS3BObG5zMk9RdjJ6?=
 =?utf-8?B?YUg5eEFhMVVKQVhyaW5HU00vSzhWWjIzRElFZXlLZ2c0bGtWWCtaZk43UUt3?=
 =?utf-8?B?ck4rcHpCR1J6bTdOUllvc0hDQ2MwWGEvK2VKc0xRTXZ1bzJZZUE2UVhnUG9w?=
 =?utf-8?B?ZkYzL3dwaGtSYjFHTGFEb3hjT2lSVk9RSThrajNxOTVYTE1SSkUydEJoSTdk?=
 =?utf-8?B?SlYzOHllKzBLZWRqajNNMVVnb1I2cUt5RWxwVXd1MUQvbU84eGdtcGdSMkdD?=
 =?utf-8?B?Qk1xWnlwVEV0aVFVQ1ZmWThpSjFIWjBBcGNQdjA4dC9sQ2twK3RNUjdUWjJy?=
 =?utf-8?B?UGorOEtQRlNMUzZVNVZtUXlIVUlMVlhGSzNCWTRSUzc0SStkRC9vaHNhWTJu?=
 =?utf-8?B?TG5pSUltZmhFYTNvZ1FPRDk3d2J0Mnk3ZVk4RWkzd0Z5MHNUTm1RY2hwMDBF?=
 =?utf-8?B?Z2EwblRVUGtjOUFmRkJXcGRvUFNHMWRjVkhuWHpwUHRIWktkc3ZBdUtGQWNy?=
 =?utf-8?B?c0JIMjIvckVEeVBjSkg3QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3FIeXV1enpCY3VhMnFIMjJRTlpVWGVUVzlHZm1rNXRKYTFxVER3VFlYVm1l?=
 =?utf-8?B?SjhqYmF3aTBqRmxZRFZscExSUFQ0ak5ZWmZOaDJYN25CakZPN1IxejhDMG1y?=
 =?utf-8?B?bmVraHNNODliWnVaMUZkTmgyYllZOGt1R1AwcEhMd3pCUGlMMWIwVVJwRmdp?=
 =?utf-8?B?MnROTTYrUU50NTJiVE9sdnVLWkkzU0J0YkhaSUNxbVVBcnBGMDJLamptaEE1?=
 =?utf-8?B?Q3kzVU1XNW1LZDBPWjBmanpsazdKRXpma3c0cUttcm0rL3orRHNaeTRhallk?=
 =?utf-8?B?NHppRzJGZGo1Smd4Z1p3dE9UbkprMmMyZDBQOHUvMysrblRNZEphNDVBd2I1?=
 =?utf-8?B?SHdrdG9HaFFnRjl1N3Fqb2dRcnJLUzNCdkIrMXc4V0tGd3dacy9tQ1AwNFBz?=
 =?utf-8?B?bGhGa1RhbSs5YTN2T2Fua2Ewdm85UHhDc0c2OVU5VnFBQU15ZXErRUhyc1VV?=
 =?utf-8?B?c2pSRWYvcHdJQmpJMnN0ckxYWkUzNEwxS1hXdXdody94NFZpSWNMTitsRmYz?=
 =?utf-8?B?Q1hsczBQSFRGVnhIbENtL1RDUVRrZElKK3VzenowS3pKUjlTL0tWb3dwNzRU?=
 =?utf-8?B?UFBZQnN2Sm9qZEUrYXEwcjBoYTZ0WVdpYnlBVW5QdVdycG0wN0lPcWRJTDVQ?=
 =?utf-8?B?UmphdmN6a1VqbCt5YmFTN2lpQ29CbWZ6dm8rK05hcXJtSTRCZkJUQXFoT1ZQ?=
 =?utf-8?B?ZjU1bGIvWDFWdUU3R3JNNUoyV01MTGFpbXNyUUMyL0E4cEM5REFxbEtXN3I5?=
 =?utf-8?B?OUVkN2FiNU02eHpxNWJTMXZrY0xrOHE5U3ZDTWlYQUl2Q1gzU1ptWVA3M2VE?=
 =?utf-8?B?SGhJMVJUSGtKL3BwM3llQTBQZU9FdEY5bHpFU1BMbG5rL3NuYVZmTEREOHV6?=
 =?utf-8?B?b0hYMnc2TkRxQkhrQXBYb1NBWm1hRERuU3NJMnJxZjR1MENlNmw3L2Z4OWt1?=
 =?utf-8?B?d25iK0RiNkJ0bUtpcTZiMFZXNDdqditZSHRLWFdpQ05QU3RkMXk0dWZDS25l?=
 =?utf-8?B?RFpjd3ZyaHEwSkhNbFZvZ1lZZ01DTGxmaVgxL3NHd3ZhVk1yWVVyTVFkaFpU?=
 =?utf-8?B?TlI0a2UzNktURnd3c3FlZWdnK0JnSlJneGpNeXNqeDAwUGFKOFZudVhQWUFC?=
 =?utf-8?B?ZlcrWTBNM0dOQlo2RFYwbU0zTmM2KzZuNXZNUzF4bE9CWjZnUjk3TzY3Tm1C?=
 =?utf-8?B?WjRpY2lVaitFS3JDallCVXg3ZzVPbmwvUjNEZDRWYW04TExFSTFTRURRaUth?=
 =?utf-8?B?bmcyV1VaYkM1SFFGckxiNFdvaTJzSU50UzhPYUtURXpsam9UWDFtNmE5RHAz?=
 =?utf-8?B?WkNza1hzNE92Q2NQL3dGMElOM2tnVG1ySDM2NU1YZTNobFpJQ1h3anJBOUho?=
 =?utf-8?B?cWY2SWd3M0N5NkxFVWJiZzc2amQ0YTNqT3VVaHRDMnFvTkxTbjNrSWtHS20x?=
 =?utf-8?B?S3FUTEIydERWZ2t0elQrY3BsQWNxeFdRVkhkZi9kNW1Sd09aNFROekdiK09N?=
 =?utf-8?B?UHdwTmNVV0JTT0dmRmhNT2Jna2xyM1dUL0xrSmdxRFdJeG91bVJhRmNNUlE2?=
 =?utf-8?B?bExMcWZxRy83b2lKdU5uU0RzWCtzeGx0K1Y2UFRlbHdRNklKYXlxVEozU1Ex?=
 =?utf-8?B?QmlHaVVyeE9hc2RxUVhQOXVuS0V1UHR4VUwwSEE2RUNRQk9JanJOa1I5YWR6?=
 =?utf-8?B?SVNBWjdrYThKcVpHeUNtanJsTXNzVEI4bFNZNjgxRzluT2ZzajFQT1Jla2d1?=
 =?utf-8?B?VDluQk9GN2xGdjdJLzM4RGdDbHdVYTQ3M0M2Q09pWVRXbVROczJJTnM0ZHk0?=
 =?utf-8?B?eGN1dzJtVFBJN1VteEg3bGU5c1NHOFNNd202REZrc0tjQ3RPWmV3aWNGMnll?=
 =?utf-8?B?RzhuYnR5UTlyV1BMTkVuZm1LTm1PUVNvZGFWYVlGajg0WDR5dHRKZkRuZzlO?=
 =?utf-8?B?WWxQRUFFcnhLc0c2ZmljSHNyS25mTFBCOS92aGp4QlAyYTJnbHFIZXpudnFv?=
 =?utf-8?B?VnlZNjg2RWd6MlFGMkVGcURpS2Z5MkhCZ1UzV1YyY2k2c1FKUTZub3VSYzAw?=
 =?utf-8?B?OVBxZEtpY09xTE5TREtlTXdBSXl6RlZTN2ZNOHV3OU9xN1EzMlhqUW5oOHdE?=
 =?utf-8?B?bkplemU2QnhpeU9LZ01rcFJsQ3RQeGZjTjJXclRScnhRZVNObDhDdFJERmhv?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eeb74d5-9433-4929-3242-08dce169a8a7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 16:05:09.8201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WqxUHxgdaJKgMoHVnPPUdvTcAf4hav8Wx+CvziaU451+47yeW7fCSEGojpB8o6JqCmb2+qV8dBjIaTzwGs1xP/bzBkTVhWeFXiGB6dsoyb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6192
X-OriginatorOrg: intel.com

Hi Ilpo,

On 9/30/24 6:52 AM, Ilpo Järvinen wrote:
> On Thu, 12 Sep 2024, Reinette Chatre wrote:

>> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
>> index 51f5f4b25e06..ba1ce1b35699 100644
>> --- a/tools/testing/selftests/resctrl/resctrl.h
>> +++ b/tools/testing/selftests/resctrl/resctrl.h
>> @@ -142,7 +142,7 @@ int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
>>  unsigned char *alloc_buffer(size_t buf_size, int memflush);
>>  void mem_flush(unsigned char *buf, size_t buf_size);
>>  void fill_cache_read(unsigned char *buf, size_t buf_size, bool once);
>> -int run_fill_buf(size_t buf_size, int memflush, int op);
>> +int run_fill_buf(size_t buf_size, int memflush);
>>  int initialize_mem_bw_imc(void);
>>  int measure_mem_bw(const struct user_params *uparams,
>>  		   struct resctrl_val_param *param, pid_t bm_pid,
>> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
>> index bee4123a5a9b..60627dbae20a 100644
>> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
>> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
>> @@ -265,13 +265,16 @@ int main(int argc, char **argv)
>>  			ksft_exit_fail_msg("Out of memory!\n");
>>  		uparams.benchmark_cmd[1] = span_str;
>>  		uparams.benchmark_cmd[2] = "1";
>> -		uparams.benchmark_cmd[3] = "0";
>>  		/*
>> +		 * Third parameter was previously used for "operation"
>> +		 * (read/write) of which only (now default) "read"/"0"
>> +		 * works.
>>  		 * Fourth parameter was previously used to indicate
>>  		 * how long "fill_buf" should run for, with "false"
>>  		 * ("fill_buf" will keep running until terminated)
>>  		 * the only option that works.
>>  		 */
>> +		uparams.benchmark_cmd[3] = NULL;
>>  		uparams.benchmark_cmd[4] = NULL;
>>  		uparams.benchmark_cmd[5] = NULL;
> 
> The same question as with the previous patch, why is [4] = NULL kept 
> around?
> 

You are correct that functionally this is not required. If this parameter
disappears at this point then there is no record of parameter 4 ever
being used. Even though this is user space I do still have my kernel view
that we should aim to maintain ABI. This means that parameter 4 will always
be "used" to indicate how long fill_buf should run for and if "fill_buf" ever
needs a new parameter, it cannot use parameter 4 since that already has
a meaning.
While the above may seem unnecessary, I think it makes the more robust
parameter processing found in patch #9 that replaces it easier to understand.
In that patch the comments above are coded to ensure parameter values are as
expected and parameter 4 continue to be dedicated to how long "fill_buf"
should run for.

As you mention in similar feedback to patch #6, the [5] assignment is
also unnecessary. Since it is just used as termination I can remove it.

Reinette

