Return-Path: <linux-kselftest+bounces-6262-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5436879889
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 17:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4688CB211D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 16:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04B37D082;
	Tue, 12 Mar 2024 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CzBQdZPe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92DA7D3EC;
	Tue, 12 Mar 2024 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710259665; cv=fail; b=bTAMEFyk8/n/4OISHk8R7eaJnDBgQ8ZO/qO4kaEJZfhdXRmfVTusTshVIVURi0Z6BUzzs5iheSg7LAvwamcN9faORNZxoMm1PbDwkTYwX13MVo5YcSoIZVxqWDq/HT5YHg353tIM5pWMyDNMorrn1u+EBpqNwNLX9q+TaozPz1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710259665; c=relaxed/simple;
	bh=YxhVRdcO8vifqdpoG4lzoZMYqINk5xDHPEbbzDksrP0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RyS2mC3Y9Wan2M3Fl9MNo0JBrqRBAA8AtbDHBjFJo/TwghdXOLh7sZBBI3fQlmsrQlChg9y5uHTHW3NF0sMBRHmzFqGxM0rfquqA7QQ3MKT3bywgIhlUxukBYyhfo6THMI0HQzIKyCGVXCOz4XqO5DxPhuz9OIEQvzwvYojqJ1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CzBQdZPe; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710259664; x=1741795664;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YxhVRdcO8vifqdpoG4lzoZMYqINk5xDHPEbbzDksrP0=;
  b=CzBQdZPeFvUKh1gPpqm0XtDK+Cbr3ecARZyNBFKhElGR3faAVmXqFw7o
   HdWSqF/Rndi+MgSM6nhwPxnxXPTUtontsXzdkazJRQvFXgbV8K8yt8Yde
   SZgJ5LbMHhRm3FMmSKAjUNY2ol+elbN/njDe7YHvPU/WaTrRocUiqEqVp
   4zGs6WcjBaN2MbB3/mKTAUv6sl0q+4gMFdFCaR7JCkg41/LgadDh61FOj
   VMcBK0TvG7DJOm38JrqsjDknbjYUwgo/g/58xhX3Pynd+qLeULRN1yAzg
   4INvO5ytDBjTg39ZikOCEu5gfEJdmZG6AGdzFMENxopAa5Qi0mHPU3qGa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="22497570"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="22497570"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 09:07:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16238181"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2024 09:07:38 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 09:07:32 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Mar 2024 09:07:32 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 09:07:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbuyFLsqkPYCk5EZBMqAHqUzndL3gaJ0aCAzpg08H4aLE9EREN+9/V7ZU6eKrR0IYnZQbz0bANv1DNLAbAyUbdEayM2Tps1IaQxkfglxcAiZtexRM5jzSZAxe0nuysJY2pWpbnGRXlmxUQuOFtOQ6rse1qUsWtszq31uR76ZWsvTTkZCQMwVHh5v4Kn7znCM0xbslxMWOEYK8RtYdKLk7kSGYSAql9CEV0KYTXIElKoVjOEKOMnr1mW5Jf2F24IcfLhK9wjoXonjdVEykolnCjNQrLjFIb99gH28zLGcbUHPlLNhyTw2bTlfgLxBvG8Xg8h9DZ1JGr9lpx1YZSaHTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJczG0sfpTHJINkvNprNBgdGeV0KNPpe1gYnALuPESc=;
 b=m2g/QoZh4xTtIumCv9atFY7HwnswmtOwTE8KfFG4/qjabKSPj1bC5se2ZbAPHzD69TZiDMlxb48eOS0SN5zRRpHDchYuF9xHWZRpRDYwQ73egcnvBUqFQU4eqKRblI8zDG6TskXoQzUshwXhdSBu2WTZHkF9dMv6+csdVmt08YwrEANsKhuzzpyKv43x8NSrGHa3nbOH+cqZKAHMhsuHYp9j8Ru+zSv1ISp0dqFNDO18OWsR2vUazF954uAlS/K706uUNslsiNH9Q3vFubVrPdA52OLN9TRmpe8yus00Rj1uj/CfsbaDUe6OL8Ike0IoBwefCgAkC79Fjt4tVIT04Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB7164.namprd11.prod.outlook.com (2603:10b6:303:212::6)
 by SJ2PR11MB8299.namprd11.prod.outlook.com (2603:10b6:a03:53f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.16; Tue, 12 Mar
 2024 16:07:20 +0000
Received: from MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::b5bc:2406:7431:8c1]) by MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::b5bc:2406:7431:8c1%7]) with mapi id 15.20.7386.015; Tue, 12 Mar 2024
 16:07:17 +0000
Message-ID: <ad272dc1-1b85-41ef-8454-4888a5ab95ee@intel.com>
Date: Tue, 12 Mar 2024 09:07:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: x86: skip the tests if prerequisites aren't
 fulfilled
Content-Language: en-US
To: Muhammad Usama Anjum <usama.anjum@collabora.com>, Shuah Khan
	<shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, "Peter Zijlstra (Intel)"
	<peterz@infradead.org>, Weihong Zhang <weihong.zhang@intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>, angquan yu <angquan21@gmail.com>
CC: <kernel@collabora.com>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240307183730.2858264-1-usama.anjum@collabora.com>
 <dc8d122a-22b7-4d17-abd9-66262af0b058@intel.com>
 <c3362840-365e-40cb-80fe-895aa2d979ec@collabora.com>
 <1cacbd08-1131-4be4-b318-58c05afda2de@intel.com>
 <21f8dbe3-9de2-41ad-a8bd-61d66cb38e90@collabora.com>
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <21f8dbe3-9de2-41ad-a8bd-61d66cb38e90@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0058.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::35) To MW4PR11MB7164.namprd11.prod.outlook.com
 (2603:10b6:303:212::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB7164:EE_|SJ2PR11MB8299:EE_
X-MS-Office365-Filtering-Correlation-Id: ebbae496-c491-4a92-580b-08dc42ae7d6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0a1J/y1j6IHHx3Qh5Az8qBQgxlrwAiZst1+TMwYpLYrin1vf6qkYvBCtMdST/DjmdWewIxhrmVvMfxmg6JszLlaT2G25WW6RYKbeqwDcsQLK+weU7rH9jQ9jh6GapRVoZ/pWZzyeolCbFNmf6B+TjpW6CS+j6Zou45UGs9qI3y7tEDk0vEHnKcvIOnbciBX7HvtU/XfRTWbvSfMoNdIytOUKW+TlMagDjswOZQXBixeCXzsWRG6I+G2e3CVknGCmM1Bz+iaB767IC1GFavThsACV9ZJfPqsdy9/Cupt/lzx89gOQVsE8i5Gs2fo3Q6OyVZ2I9AJaa2Mf7wfL3ymwVJCxJICDifTAJdKTpJq6hzdqDh7syflYNM9uhmxVhYdL/wSoyBdMB5wQrtfAXYovUiuvt5/TUyQ/sPq5W4Gwb98HKkODm2DVTnfSdR8Rjcnc6Q0R5wtuW5Xa6BUMbp9WUrtMb8Dhwa/zIc8T+2U+w+rzFDc+XUUDfTzjGYwBMG7LFNksUPW19jAlJ9cYkWMNzD6pu9xMH7weQ2AR7uTU6hkUfKBzghWU1JEBAwRHDaJ+0DdsiJJsn0jc3tZunT+67GAv61UnDFp9JJgRUx8TkJo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7164.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THYzV013ZTJwV1ZDRzNOMWptVzg0alBna2YwVzVYZ0hyY05UM1JoL3BVM2Y4?=
 =?utf-8?B?bHVJNHQ2SGM1ZGlxaTJvQ2FJTHpEZXhETjV2VDA1dCtCWmZ4bDhoZ3l0VlFL?=
 =?utf-8?B?cXdOalplWXpxTlRhck1JZnBhcGkwTUozZjU2STRQa3F4RGR6bzJjQVc1b3pU?=
 =?utf-8?B?SHAwdGV3SkdaQ0hCMGM3dExRdTlVWThhU1BKSEx3bUdUU3RBMWJ6eHJRRW4y?=
 =?utf-8?B?d2tQdm1sQmgvTndjZG1jaVErall1RURtdzBlMG53TTdJdjU1cWdOQnVKQUtB?=
 =?utf-8?B?UVJaSXI5L3hoaWNFUUozcUdPT29jbnRBT2RicnIxWFZRcENUWkZQc0xZRkVK?=
 =?utf-8?B?V1BtTjdITXMvcUY2UU51OERnVXNGanlvRGljcXEyTGtnSmV6bXM2NTdDS2dN?=
 =?utf-8?B?VW1TZ0tXNlFhWVRKN1RvQXBFUFFCVC9CU2FhSjc3cDdUSi9MNXJ4Vm9Wc0gr?=
 =?utf-8?B?bzdlaDYxMHJlK0o1clRyUEh1REZVNFJmVHVVZHU4eGVPSTFlRHB4SjY1dit4?=
 =?utf-8?B?L0w2bTlBbE4rZDdzYzJCTWZ0OHIwd3F4RG5BSnNtaFRhZkdob00rcUE0Zzho?=
 =?utf-8?B?clo1MGlNNCtMeFlQYVAwQzRueWRWeU03QVFyTnZUUFRnN0IxdEpQWFdUNEVv?=
 =?utf-8?B?UDJlNyt2cTh5ZnhRUkFEWW0wQ3h2MS94L2J1U1FDZmhENXdpc2FxWUxDcVhh?=
 =?utf-8?B?Njdhak5ZWTlsQlp5c1dFVkFiL2JNTUE1SHFIaVZvZmFHcEppZjlyR3RabFJa?=
 =?utf-8?B?NmFUOFZNcUlGZnpyQ05WMUFQQjJOT1o4WWF4dnVYWWtEUGNETFo1cXFvZWlr?=
 =?utf-8?B?SFZtTm5xVTVpazhvS0ZBaHpsRnVla0xJWithY0o5NWVyaEZzSGd4a0QzTVE2?=
 =?utf-8?B?K0FqMS9oeFVzaGxVM2lpUm9vVHpjN0hUYWp5Z1dLWGsraUp2MityczROVTRM?=
 =?utf-8?B?cldYWWpMZ2JOTnJpL3FLZlljSGZncUVoUWs3QzlMcm1PVW5kQmQxVDdFNldP?=
 =?utf-8?B?anFLTTl5NUZMVFBQYVliLzdpd3crN2VBd1IvdElKQjYzWTZQVm8wWVZBSU8v?=
 =?utf-8?B?WHp3dnh3ZWRuZXFvcnd5Njc0cUp6eUZ2eUtBWFBqVkVkbEtva0NFSXgyT0JN?=
 =?utf-8?B?N3BQeEk5WVlzb1h0SFM4ZTN1Z2VpUEszK2wxcUNKMmpRNGdFQmFpL3hFMUxN?=
 =?utf-8?B?Y1I4TWpWMnpGTitoV3k1cURyTmFZcmtjSzJqaHZXaVhwaDJhTlpTSms1ZEtk?=
 =?utf-8?B?RnphbnU3LzU1bGF0Znc4ak8ydFJneXVVeGJUS0M5Q0Q3Q0cwOHBxc2lrMFZU?=
 =?utf-8?B?M3Q3bWkyY3FycVJ2OE95Z1RHUUNEbE9rNEVPbjhyaEFMdWcwQS9SL1F6N3FF?=
 =?utf-8?B?Sk1QbUhSSmg1bS9ObkQrSG8xdWZaaFVOUFJMaGtMSUtpZnBVZk5yUzdTM0Zu?=
 =?utf-8?B?TkRUZmhjQzBIY2swRy9UbTY1NzBPOHg2bnliWEpaYTBsUmI0dEJCc0IxdHFC?=
 =?utf-8?B?MDcwUTZxQlJYaHBNd1FkQ1NtVFBvSFZMSVB4OXZ4WkxWSUplRDNkREFweG1h?=
 =?utf-8?B?ZThOelhabVh2ZDBIOUtMYnR3cHJwRFgyUDVhaW9JTU4xMi9XZGZUekZLU3VM?=
 =?utf-8?B?TGx0VHk3S1NkK3JXYUVjSzRiZ1EyZ2Y2ZWpmU2loaHJONGFMUHRIUzB3MUVS?=
 =?utf-8?B?MmxISS9OU09qMUdDTUg3S0puemorelNxLytoNnFXSy9VeEczVlh6dkl4WnhC?=
 =?utf-8?B?Sm1ZeFBwc2xjUm1JMlNvV1VUKzJRbzcyTGpiZ3dIdHBlU2ZjWXY2QWJ5TGJ4?=
 =?utf-8?B?ZmhpenRwSm1pNnh6ZFJFYVdVam1scFF2ZVkwY3lXK0VSUEhQYlJ2QzE3QzBa?=
 =?utf-8?B?U0RwVlQ1MVcvalZ0eFlXejloNXRBY013NWdLcVRBc2x0L25NT085MzhTeito?=
 =?utf-8?B?UHpjZDQyT3I3NGxTTHlWa1FkZk9xNWltelg3bmMzbFFJU2kxdnNCR1kyRmRL?=
 =?utf-8?B?T2orc1JDRVF5ZStmTmZuMVQ5WG5tOHBsUStXMHEwOXc3WmFOcE1rbmRzaEor?=
 =?utf-8?B?MitUMzdtVXZZcHRSbklaTTU1RlpZUTNUVjRDUkhtZnFOM2U0M0N1K1hIWXRw?=
 =?utf-8?B?V0h3bVpoeWRXZ2lFYy8vdFViWGNkd3BPbENqT1UwbnNqRGl2Wi9DMHhCdDdP?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ebbae496-c491-4a92-580b-08dc42ae7d6f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7164.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 16:07:17.7943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUg3Pm72+ancPfxi9qtIf9mnF6o7E4/mQFE5WvaHBkimRNWeoa+NEm6hHggdlakAtEZEqN+hLaLBwlGuzFa5WP2JQ8iNCwLEziDL0NFrgGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8299
X-OriginatorOrg: intel.com

On 3/12/2024 2:26 AM, Muhammad Usama Anjum wrote:
 >
> How can we check if AMX is available or not?

After a successful check_cpuid_xsave(), examining CPUID(eax=0xd, ecx=0) 
EDX: EAX, which reports the support bits of XCR0, can give assurance of 
AMX availability. Perhaps, this change is considerable on top of your patch:

static int check_cpuid_xtiledata(void)
{
         uint32_t eax, ebx, ecx, edx;
+       uint64_t xfeatures;

         __cpuid_count(CPUID_LEAF_XSTATE, CPUID_SUBLEAF_XSTATE_USER,
                       eax, ebx, ecx, edx);

+       xfeatures = eax + ((uint64_t)edx << 32);
+       if ((xfeatures & XFEATURE_MASK_XTILE) != XFEATURE_MASK_XTILE) {
+               ksft_print_msg("no AMX support\n");
+               return -1;
+       }

Nevertheless, I still believe that using arch_prctl(ARCH_GET_XCOMP_SUPP, 
...) remains a simple and legitimate approach for directly checking 
dynamic feature support from the kernel: 
https://docs.kernel.org/arch/x86/xstate.html

Thanks,
Chang

