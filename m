Return-Path: <linux-kselftest+bounces-17326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB60896E44B
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 22:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58AC91F2762C
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 20:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BEF1A42A5;
	Thu,  5 Sep 2024 20:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ba/2vJiQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D0419FA81;
	Thu,  5 Sep 2024 20:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725569012; cv=fail; b=QLZCALmA8RltqRXEUwXhCcfoFWekyoBCdFteiV045qRq0lzcw0TIaGUm7noHZ/jJe2yMbW6ffARnZs0DChc1aYJbHNQi7L9XEIXOhE7vCAs3S6n6fbXlPfHo0rFi6dWljxvwI6Jn93YSPrSwFk/lzY0OMWaOaf3AEmElmMukjR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725569012; c=relaxed/simple;
	bh=HV9KOJMYBAvMQi0/7UsqjxYELDJx2tDIf/eCS3cwoEU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IvFmIepfSdMkPB7pLae7bhVeadKFGiIcYOSlImc7JndTh2AxRA+PnlKVJZCNQ1Y2hAdZ1upVt13bcRkjHwqeMJpZX3bgrH49W7cbWr0FNpH6x+lPzrgJS37ubFhsa4SfQgtmy6CuWlcIkudAamuN6x7pJjJeag0yt1bGR5dgumA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ba/2vJiQ; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725569011; x=1757105011;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HV9KOJMYBAvMQi0/7UsqjxYELDJx2tDIf/eCS3cwoEU=;
  b=ba/2vJiQ5rlK5fNQfkXeC28yGQtt7QdP2VD8usVMLikM0Cq8+Mzfw448
   uW+SWwzRxdux/4UXF6UxUzGAA9NM7rANM5tfwSBXICJMpvwvxtlKQT8c0
   CSeByxXFLjO9QssvG4Z/Nrmk+SlyJRCWye6LFnJkz9OefpsHfbatQm0Mb
   jDtorPH5fYD6dFWIfKxpanVjtmAf3zFuT01FVJ6B7sgQE0beEoOaxl/x5
   CFg5BIMZsBFpg/MfCGPvAvdkVSwR/9vKIoQcfONjAdBXK9Eve8iVe3J3p
   y4Tx92GYxHewtPg1peXo/+QrJFQmqI0hyLG+yKkwbqr9v7eVAOScp3/Z7
   Q==;
X-CSE-ConnectionGUID: trJPK0kmTtuSzUY5gZavzQ==
X-CSE-MsgGUID: ha/ogA8YTTat64cBjdF14g==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="46842711"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="46842711"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 13:43:30 -0700
X-CSE-ConnectionGUID: 2wQas0AITZWmxzzvTvVEPw==
X-CSE-MsgGUID: 2X+Gjho8SM2DyEv/3WeFVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="70312269"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2024 13:43:30 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Sep 2024 13:43:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Sep 2024 13:43:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Sep 2024 13:43:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Sep 2024 13:43:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GrD7KD88YyLDwgYdbnTOuMywvUO1y62VZ29drxhaWUFq/9YQUPOcpRiSamB7K6CNmBcWkRaBsmJQ3wX9hrJCYfbckwr5wUqmnBz2g0v+5qhzoqBr2nw7e6x8eRk0crsuOOKNylxOfNbhzTbH3GSljuKDdqYD5rkhoWfLAALBdVL6EDrCJEoz0xVqSpr38pkqe4nX0TUdS6W2EbqeB09rDxJR6+LVi4vL+MTlgSZdOX7qMJPLiY3UP2dfr3hCVXUjCtEpTO1AA8GXU8KrHhJIz3yooLKNw1oG8hCJZevGsbUpn9U/1Nrf2Rbs39rXSgooBfbAab9e4BLUNQ+eNgHIiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVO1jS4VGqZnjZjYovU8UljG+gmuRy1H7DhMBpcDRFY=;
 b=q8fkb+qRDamTNhFAJImSPMKeUHqof3Gfp68v2VVKbnakmimNDLmSSzahr5hheUzSYbWWQaXAw8aG8o0uxx4RwyvsDvHzP/G2g/YKmg+sbZMsukhBAvKlAmjxN/jB2qLnVNqIJJ9+SiktJFq4ztAY+0B/L/dSorsBmMQNlXwjqusNot9K4GonxTwEWZshK+35cL2t/XVDqOHq91cCaXhnHzQAZvy8Aq8nC5UI5YFJG8OktK0go9XkUIu3vjXifXBHP03PMBRvnICD7+XORNcmpWTT4j6lb3aG8XMHlA48Z3QhUNTtktgpaDYXLzW5DaCudBopozuiXGmsTnNa40SQzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY8PR11MB6963.namprd11.prod.outlook.com (2603:10b6:930:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 20:43:26 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 20:43:26 +0000
Message-ID: <1e7c1609-342f-404e-b5eb-87528ee1b4f0@intel.com>
Date: Thu, 5 Sep 2024 13:43:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] selftests: Fix cpuid / vendor checking build
 issues
To: Shuah Khan <skhan@linuxfoundation.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
CC: Muhammad Usama Anjum <usama.anjum@collabora.com>, Shuah Khan
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Fenghua Yu <fenghua.yu@intel.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>
References: <20240903144528.46811-1-ilpo.jarvinen@linux.intel.com>
 <eadb7bc7-a093-4229-90f0-88b730087666@linuxfoundation.org>
 <d2a4ca5c-3352-e570-687c-9d7ec90dbe33@linux.intel.com>
 <b4b7147f-64cf-4244-a896-07a88f08d0f1@linuxfoundation.org>
 <d8ffc136-876b-db3f-fc87-a1442e53a451@linux.intel.com>
 <f65237fe-a1b9-4d63-9a06-dd7a49765c9f@linuxfoundation.org>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <f65237fe-a1b9-4d63-9a06-dd7a49765c9f@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:303:16d::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY8PR11MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: ababd2cf-6e80-4aff-4119-08dccdeb646a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXFMYkNXL0NES0pyc2g0ZTg0ZW1YOUQ5OHFTUGNxem1NMmlydkZWSTJlcUpt?=
 =?utf-8?B?MFMrZ2pXSVdkL3pRbUZPV2JLNjlGNGxuL0laMUMvTFEwVkZHYXBvQTEzOHZC?=
 =?utf-8?B?bTNESUtyOHl6cVloZUlsK2dRV0hkS2gxSmpyR2ZFMk1HSUh6VzNGaERxeVRx?=
 =?utf-8?B?QlBUazRzRFE3Q2xtNW5GOUlFOFFoTUdXSUQzSHI1UEJwR1AweEtMOHNsTjhM?=
 =?utf-8?B?VHA2SzRQVWgxUU5zNnRuSFpDNW51bnhGTStnZ2wzQW9PVTFHcU8wUFNjYjZn?=
 =?utf-8?B?OUFUVGpQNC90UGxiMi9aNDJ0N1g4TENvc3QvVEZsNWFGQW1VUWw1bWphYVpB?=
 =?utf-8?B?NWlhNTlwRjlmQ2s2UUFiQXk5SDl4MEN3akJiZ3hPODJsd3BvZHJaUFZDL0FI?=
 =?utf-8?B?T3lha0ljZThsay9DVytIQVAwMmZmeXhMbWM5dnlYckRIUXlIM2dNaDhsUTRa?=
 =?utf-8?B?TDV4cUFMR3BlQTRVVmZnSzlQVURDYjFoWW5VRFFpdVNINjQxM0NhUTF6anNI?=
 =?utf-8?B?elFDdXpLWGZIbEJ2SFB6R0ZkOERKbGRjMFMzS2ZrbTNBUlVxTHJkVHVNa2lw?=
 =?utf-8?B?cG84a08vT1hIdjRxajFTaWtNNWxtYmMwZDlSRnVmcnhBU0VUM3hDV2w2NDI3?=
 =?utf-8?B?dVJTYUY1QkdDcjNWQ1o1RXN4L2pON1FPcExvVjJHM0FYTGxVbFZBNGVuckNI?=
 =?utf-8?B?U2k5K3lURUt0bmwxeE5ZcGFveEkzNlZTR2R3TG93TlZBUnpNUzR5QlA3U0VH?=
 =?utf-8?B?N3VUV05rNHBjOHFvVDJaMSszMkY0ZUp6YUhtTHowYk1pNnZkZ283aHFmQ2E1?=
 =?utf-8?B?ZXBPMHpDSENlZVAwMkRHSGZIR25xMG92T3dKVGFycWprTHJTdkxYNUdUZzl0?=
 =?utf-8?B?L2F1WjZIN2FLMlgwd1A2Z0FuaGh2TlppUlpWcmVETUcvcTRzelpUVXRwcFR4?=
 =?utf-8?B?MjZzSTNubEFsLzBoS0R4a0Y1anhCV2tldTg5R2k4cGVySkFGeTVwSUQ5UGVt?=
 =?utf-8?B?b2MvbkJtMCtFS0tMelVJVjFCaWl4WFMyZTZVNDkrT1I4V1JZUWxVTjNFWm9O?=
 =?utf-8?B?WnBXbUlPLzVRREQrc2RYUXE1VEhKZW9yZGxvOHVrL1BGTlJKRzRrUENnVmxJ?=
 =?utf-8?B?Q3F6NjZuZUxaaFo1T0pzYmRZVWZjZFA5UkVhSyt1VmZ6cGJoalZDUi9PK0pz?=
 =?utf-8?B?L2ZLNm8wd3VEK2M3djk0WjNMUElHNHN0MDVQQnpLR1FCMFkvbi9XVnoyOGF0?=
 =?utf-8?B?eTZvdVpJS3lxUWg3VFpQUUtBVGN3RDdUb0JzVVkyc0FHTm1DMk90bFppdk1V?=
 =?utf-8?B?QTQvTWlicFhDektxZUQ3cmFJSDNtU2RqZWZNNUZZdDB1ckhCZnVMa2dxQzBO?=
 =?utf-8?B?a3hDNzl3c1lBUjM2S2Q1bHc3M2F0UHdyYXZtdTVIbGlGc0IyU2JoWmliWVhG?=
 =?utf-8?B?R0l1NE1FTUxmakZQYUp1UmxYMjFqTGsxdW02SXN2YU93amVSQVUrenJVVUwv?=
 =?utf-8?B?THllYmQ2eVFhYmdNZThLM21mS2tycFpYaWdWTHp0YzRKdk5aeC96NEFFRVRl?=
 =?utf-8?B?c2diaWM2VG56a2grYXdVUWdsZW05WWh6ZkxCYVByU0w4bEM5UVlXWm92ekM0?=
 =?utf-8?B?eFJBeW1WbmdGeGxibExxejgva204SEVWWU4wYy9qeE0vamQzMlp5S2RiZnhs?=
 =?utf-8?B?cEYzbzNFcFdGY3dLWktWbktlN3U4NTdkM1RaMDFBdTVuYng0TmdVbnh6V1NV?=
 =?utf-8?B?blBlb3F1OENLUlFqNGtsZ2lsQjdac2lGWFdXQk5uSFhYTUJ2L0Fzcm5ZSjk2?=
 =?utf-8?B?U3ozY0JSbU9sMXFxbkd5QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEx2WU9ORlJaQ01zRTljdzhneU5BSE9GNzFoUjkvUzViNXR6VkRKTEZ3VTRM?=
 =?utf-8?B?QXpxRm1Cd1M4KzA2STUwOEMvb3EzZHNicTZzMnE0Z2VtdDFnZzhSYlRZOVBv?=
 =?utf-8?B?NW43emRNNElXQlF2VUhTRVJrZ3JtVE9FWDdhTXZVV2k0WlU4ZytHLzdVU01S?=
 =?utf-8?B?ZGZtWHJ6b2NxQWJvQytjNEtPYnlYZFBDZ2Rnb25EYmlRbnFZamFOSExKd2xu?=
 =?utf-8?B?MCthSUZ1RFRtVEp5L3FNUkdIL3NGb09nemtFc2lmZ2hYSU9obUpaZDlydEdh?=
 =?utf-8?B?clZrdjdDUUJZS3p0SlBoTUVvWnRKU25QWHZ0SDhVWXFzYWlLNzkrZ0NmQlhx?=
 =?utf-8?B?RkU4Q1NjTFI4Q3Q4R3YwNmloS3BiMUNBQ3FyMWF4TG0xcEE2SjBGU3B3MDhS?=
 =?utf-8?B?ZW1Mc1pUeHpYM3FSbkovN0piTXdUcW5MYmhHbGZhVmtpUnVISm1nYUptWUpT?=
 =?utf-8?B?dnZNaytYR3FZY3M2d3B2Tm9WblExTW01VXBUTDh3MjdtZzhWaUt6TWRzZ2t1?=
 =?utf-8?B?VG5hdUYxUTFFNFRXKzY0NjdEZG1LVGNVN3hUeHc3WHZtVUhKUmd5WE85bDBS?=
 =?utf-8?B?NVVoSW9uSWl0YzliS3RQdnFTMjV4Q3I2UTkrb3RwZGxONlk4Y0FkdTNtalhD?=
 =?utf-8?B?SkVsNDI3eCtxOWpKaGNJeW5BZXlaRHA1WHg0Qk15cVJNcTRyUGlrN1VlTFox?=
 =?utf-8?B?MnRERlpIaFZjeG5KNldGVGtIUkEyNE1waUhXYVN0eUZ5UllIbm1XbEJObEJ5?=
 =?utf-8?B?aWxqVGJSRGhjaUN4UFg2czRqNmFucFNtMjZWUHhlZ0U1QUZwTE5Nd2pHNzRF?=
 =?utf-8?B?RUtlaDlmd2lVeDFhL0ZSdm84bldJYm1pZVdXWEE4bS9QZlY0SkFNa203OGlv?=
 =?utf-8?B?UUJBczJHd2t1Mnd3bkdzeVBKMGgwOGZMdFgxMXBvQkZiUFYwbmFWRit2Mldy?=
 =?utf-8?B?emtFakp5d3BlcitpRlhvWU9yRzhkbkV0dlJ4QU9uOG93bVdkamZObURPNzFT?=
 =?utf-8?B?M0pHOTlvK1k3VXZqTTN4NDViMEFUUVRIbEpmbnByNHlxTm5zc3phQlBzeEdw?=
 =?utf-8?B?YmJVQ1ljcWV2QWp6ZHBhR25RdExISFViODAwcHBEeGUzcmFGSEJjUnc4eEFm?=
 =?utf-8?B?ZVZPRTRBSDZmMG1aOWFQdTVWWGE3bzR3aVZ2Z2VpY2t5V1ZQaWIwR1JQd2RB?=
 =?utf-8?B?WVQzVjF2WDU5T1o4MHZXU3U5cXU0RUFVNU9VSXRtNExBbER6TEVMTWF5VzRV?=
 =?utf-8?B?OXA3ei9QelAyUEVKczR5LzVCTVEwbXREcVZxZktCTEJUekVUamJUNUpVeDBj?=
 =?utf-8?B?NGtMdXJYUHNjSVNqTkh4Ti93em5DMnJkbndIV1NtN1R3QXRjYjRJb1k4Z2Zy?=
 =?utf-8?B?VUgwSm81ak13NXAxL0NlNnhONHhMbmIrNHQ2VlJjeFhwS2IxeHEwbHRvMzJB?=
 =?utf-8?B?MUZORnhMNll0S1lZdStUeW5QZHNhNGZTN3llMW9KVHpsamNOM3pESFUycHh0?=
 =?utf-8?B?WHIvejVaUmYyandXTS9RMWlmWmJuQUNRbDF1ZWowRnNUZ0JpNjBqejh2czJu?=
 =?utf-8?B?ekJCeEU4eEJBbFRCdFhkcGtmVjZxY2FVU2tLWTI1TjN6MzExQUtXdnlxTXVn?=
 =?utf-8?B?Yi93cFVwdFIxT1AwWTl3MmFtUmYyNFd3RWFnYlpKaVpkbjVYVW5jbFU0UElD?=
 =?utf-8?B?aFZHTUduVHg2M013TVhxd2NFR2JCWmgrYmVBTHlvVWdEV0IrZ000NnU4S3No?=
 =?utf-8?B?M3hLYUR2c1JYRlBsR0g5aVhFOHpaakJDRm9tUXpsb3gvSnNhMVVQaVBUTzhj?=
 =?utf-8?B?OUJSaVZFQlk5aTJTOHdUTzZaN2VsbjJSSHRCQnYxUzd5TTF2dm9TUFdhQjFI?=
 =?utf-8?B?Nm44VkxvalR1YWZWV2pGZ0hjVlFVdE5PL05iQUI1bmt4WlI2OGErRWRxcTRi?=
 =?utf-8?B?OUQ4L1QwSGdFM1BOTTlycllEbTZ6NzlId0hQbUdKc0NiNE1weUxqT0txNnlK?=
 =?utf-8?B?c2RUTGJWTGJ3c09Wd1Yxbkg0MHJmWkFNSDRSTUQrWDJKUjZkdlhMV0g0UktL?=
 =?utf-8?B?S3hMd0FTVnRWWFR3cTdQajFWZzFQUm5SM3lON2NGR2g2d2Z3MjROVG12M0l5?=
 =?utf-8?B?d2p4eVRPNHVHQVhDSTJTQTRYZ0owOXB2VjF3K25LMm9CY2JSQ1JKdzF3djVT?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ababd2cf-6e80-4aff-4119-08dccdeb646a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 20:43:26.6641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VjS+Ym/zHMn8tiAl01ogYMf4VuznMNVcLcNN/AzRWUM+a5BldOBPRjXYpx6jYy7t3XuvoWpUk9c5Zq9pLSDrCGm3AhrjHbGfotxBtqAGNNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6963
X-OriginatorOrg: intel.com

Hi Shuah,

On 9/5/24 11:06 AM, Shuah Khan wrote:
> On 9/4/24 06:54, Ilpo Järvinen wrote:
>> On Wed, 4 Sep 2024, Shuah Khan wrote:
>>
>>> On 9/4/24 06:18, Ilpo Järvinen wrote:
>>>> On Tue, 3 Sep 2024, Shuah Khan wrote:
>>>>
>>>>> On 9/3/24 08:45, Ilpo Järvinen wrote:
>>>>>> This series first generalizes resctrl selftest non-contiguous CAT check
>>>>>> to not assume non-AMD vendor implies Intel. Second, it improves
>>>>>> selftests such that the use of __cpuid_count() does not lead into a
>>>>>> build failure (happens at least on ARM).
>>>>>>
>>>>>> While ARM does not currently support resctrl features, there's an
>>>>>> ongoing work to enable resctrl support also for it on the kernel side.
>>>>>> In any case, a common header such as kselftest.h should have a proper
>>>>>> fallback in place for what it provides, thus it seems justified to fix
>>>>>> this common level problem on the common level rather than e.g.
>>>>>> disabling build for resctrl selftest for archs lacking resctrl support.
>>>>>>
>>>>>> I've dropped reviewed and tested by tags from the last patch in v3 due
>>>>>> to major changes into the makefile logic. So it would be helpful if
>>>>>> Muhammad could retest with this version.
>>>>>>
>>>>>> Acquiring ARCH in lib.mk will likely allow some cleanup into some
>>>>>> subdirectory makefiles but that is left as future work because this
>>>>>> series focuses in fixing cpuid/build.
>>>>>
>>>>>>
>>>>>> v4:
>>>>>> - New patch to reorder x86 selftest makefile to avoid clobbering CFLAGS
>>>>>>      (would cause __cpuid_count() related build fail otherwise)
>>>>>>
>>>>> I don't like the way this patch series is mushrooming. I am not
>>>>> convinced that changes to lib.mk and x86 Makefile are necessary.
>>>>
>>>> I didn't like it either what I found from the various makefiles. I think
>>>> there are many things done which conflict with what lib.mk seems to try to
>>>> do.
>>>>
>>>
>>> Some of it by desig. lib.mk offers framework for common things. There
>>> are provisions to override like in the case of x86, powerpc. lib.mk
>>> tries to be flexible as well.
>>>
>>>> I tried to ask in the first submission what test I should use in the
>>>> header file as I'm not very familiar with how arch specific is done in
>>>> userspace in the first place nor how it should be done within kselftest
>>>> framework.
>>>>
>>>
>>> Thoughts on cpuid:
>>>
>>> - It is x86 specific. Moving this to kselftest.h was done to avoid
>>>    duplicate. However now we are running into arm64/arm compile
>>>    errors due to this which need addressing one way or the other.
>>>
>>> I have some ideas on how to solve this - but I need answers to
>>> the following questions.
>>>
>>> This is a question for you and Usama.
>>>
>>> - Does resctrl run on arm64/arm and what's the output?
>>> - Can all other tests in resctrl other tests except
>>>    noncont_cat_run_test?
>>> - If so send me the output.
>>
>> Hi Shuah,
>>
>> As mentioned in my coverletter above, resctrl does not currently support
>> arm but there's an ongoing work to add arm support. On kernel side it
>> requires major refactoring to move non-arch specific stuff out from
>> arch/x86 so has (predictably) taken long time.
>>
>> The resctrl selftests are mostly written in arch independent way (*) but
>> there's also a way to limit a test only to CPUs from a particular vendor.
>> And now this noncont_cat_run_test needs to use cpuid only on Intel CPUs
>> (to read the supported flag), it's not needed even on AMD CPUs as they
>> always support non-contiguous CAT bitmask.
>>
>> So to summarize, it would be possible to disable resctrl test for non-x86
>> but it does not address the underlying problem with cpuid which will just
>> come back later I think.
>>
>> Alternatively, if there's some a good way in C code to do ifdeffery around
>> that cpuid call, I could make that too, but I need to know which symbol to
>> use for that ifdef.
>>
>> (*) The cache topology may make some selftest unusable on new archs but
>> not the selftest code itself.
>>
>>
> 
> I agree that suppressing resctrl build is not a solution. The real problem
> is is in defining __cpuid_count() in common code path.
> 
> I fixed it and send patch in. As I was testing I noticed the following on
> AMD platform:
> 
> - it ran the L3_NONCONT_CAT test which is expected.
> 
> # # Starting L3_NONCONT_CAT test ...
> # # Mounting resctrl to "/sys/fs/resctrl"
> # ARCH_AMD - supports non-contiguous CBM
> # # Write schema "L3:0=ff" to resctrl FS
> # # Write schema "L3:0=fc3f" to resctrl FS
> # ok 5 L3_NONCONT_CAT: test
> 
> - It went on to run L2_NONCONT_CAT - failed

It is not intended to appear as a failure but instead just skipping of
a test since the platform does not support the feature being tested.

> 
> # ok 6 # SKIP Hardware does not support L2_NONCONT_CAT or L2_NONCONT_CAT is disabled

The output looks as intended. When I run the test on an Intel system without
L2 CAT the output looks the same.

> 
> Does it make sense to run both L3_NONCONT_CAT and L2_NONCONT_CAT
> on AMD? Maybe it is? resctrl checks L3 or L2 support on Intel.

The selftests test the features as exposed by the generic resctrl kernel
subsystem instead of relying on its own inventory of what features
need to be checked for which vendor. selftests will thus only
test L3 or L2 if resctrl kernel subsystem indicates it is supported on
underlying platform. Only afterwards may it use platform specific
knowledge to help validate the feature.
In this scenario resctrl indicated that L2 CAT is not supported
by underlying platform and the test was skipped. It looks good
to me.

> 
> Anyway - the problem is fixed now. Please review and test.
> 

Thank you very much. Will do.

Reinette

