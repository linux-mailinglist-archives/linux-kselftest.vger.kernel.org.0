Return-Path: <linux-kselftest+bounces-2095-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A0281549F
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Dec 2023 00:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F3F71C24182
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 23:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56F21DA27;
	Fri, 15 Dec 2023 23:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SzavYgty"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324B018ED5;
	Fri, 15 Dec 2023 23:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702683920; x=1734219920;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4IGGzIKWuy2ugqYbVh9MWdydr+oF6tl3Z/XWFAVLxiY=;
  b=SzavYgtyRZCR2zimMB5zQLmFJ9aY4/UEydzqvh0TrUmhPHPymmCYpiLA
   F3TgbORIGiaVJvfrq1IMz5GuGhXomMQMmCgGo7alay/LusLK4S383kKvx
   PUZROndstubKr1OXNmGXok5qBLbJXG5t3FbaENbevM0HnuE8OXPMEskKz
   zG9zSkdULW4KwtxBWqw61Oim14r8XBQFZ0H6K+4t5UGBqf549Ome2rSVv
   /Xl+fzZ5ZIWS8CY6vb5GHH3gvsiK7UMM7fU8K63CBMJO0nyuwkea0t3i8
   bnS8zEGaVKoPiGCvDVyzfR0qAHHxtO8utz7vXKSUAu0et/uakFfC1ZTpe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="392514433"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="392514433"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 15:45:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="809145202"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="809145202"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Dec 2023 15:45:19 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 15:45:18 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Dec 2023 15:45:18 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Dec 2023 15:45:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6che4SUx/FZKSeYyeDpLuBNr2t0j5sJjrK4OZnEmNtJ1MAVvGz1o4t60uj7RzcljUbOqeOsAwPx9aUb7MHs3YYUZpo4WLB2dL0oRPv9XAi5l9KK4hE3St0LHX4pO6/48LyEqk6srVQCgmgK/ZYTVcLFMh2itS6wz2CSH1ox+WgA9YEWT+CJbr0QBeQORfWy564tBvlnThWS+pNPKm0KnsNQwFYwV+q1Cb0xYRQdWHwNFKXuTP+7R2CSARsgt9KAlITa/mWNNH5vgW8esz7X/m6A32H3V1+HHk5yU3c2sxmTh0GPHI+Og2OUdpBDIl30fx2QCCZRSsAM5kEftnrW5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9a4ZFClFgVVAVnIQrfKC6qWE60aMjjeqil2XpoL6Uhc=;
 b=QXxiUsM5g9+VZ0F+L1yGHo8Sw0SchJQcAK0HlJcni6PbY5WOXcknaUo011n4hBNZbvwX3O7dgqNMM2SibPYcT004ajPAKp5X3jETxfSn3xnRoRVgZIOCJbO+TIyiObqBViAfWN1wbnpvO7XeCMjDqvDyuOU88fNGz9Wr0pkrswb1Wipb+JdEdg4pibSapWfMewCAWU4+0Y7CReuXCk2rCtcaMxPud9Lnsg2ODdS3X2NRZc3IAmP+wf8lMB/NIJMhY1YXpW3uCOZfBk3jYnPX2z420LizDFaFwWQWlEC3DxoYQWXeNs1bJI9owaGYST+rlJRAz0zKhoNuUZ+jCHjEbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY8PR11MB7393.namprd11.prod.outlook.com (2603:10b6:930:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 23:45:16 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 23:45:16 +0000
Message-ID: <a110877e-2b5c-40c6-9128-2f4d6e205f39@intel.com>
Date: Fri, 15 Dec 2023 15:45:14 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/29] selftests/resctrl: CAT test improvements &
 generalized test framework
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231215150515.36983-1-ilpo.jarvinen@linux.intel.com>
 <056a2d2b-3b09-4a70-92b0-8634a24464b9@intel.com>
In-Reply-To: <056a2d2b-3b09-4a70-92b0-8634a24464b9@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0380.namprd04.prod.outlook.com
 (2603:10b6:303:81::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY8PR11MB7393:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a6d2b22-a6b6-4011-4d73-08dbfdc7e3ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dYR64Z2fKuZjmK5WE7lJPU6OaTFDQmUAihHbrK+iV5hudiWrB3n/747k+I+w2gEF001EYduk17qKXRDw88tuu7NVut5MsrUN+fIGr7YHpmMHcA3yXbNoyuB6EM9Y+JfJUzfDRIqm0w4+LNjWPE5dhE78FNEteoQNDfAKvks8FyToKbk71kqyvln0CqY2GJw+8zmyHn+dgF4YS+bYU5fOUYBaF7PuZ+TxElrQ3ZyIXpLOY9lKJ5V4nNi8hgUKaEjM7gdxPHWY9TmFoTfPHvp0QVRGAHm2Jzk1yBB0xzAQen8ev3IaxksjSlia7H2k8qvzgM0P/oGIQqlTV9knC4JerJbbyH7FwDld2al6T3dcmauJNPySYiB9nBU+IahbgBkKruVT/zX1sEbySUe7SoRzh7RLghGu0oyAhQaj4Yq/pQrkwFLn+nx5Ej6VSeH0Xb1on4ybvDBaLZjQWQXohDGMt6rHVmE5PYTwUbuMdhlwp6MRUM0pEFkvtr0OEYiMedOUU6fL17ljRIkB0U4nfztZz04Yv+45e0D88mT4DvsHtK7LdAsj3BowibDxCL8afssG0ddWsb7hYZHDvVTGVGA7TB+IwTKGCbpbIYVCONa1WOWfk+p4EUCW+Bdq/o2Hq8+jHmTgRsGezUor3tKFCEurWD4NmHxCdDA2vYQOTZ2HeiH7imcgwdwk/bax9f1lEgeD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(82960400001)(2906002)(36756003)(5660300002)(83380400001)(53546011)(6506007)(66574015)(38100700002)(26005)(2616005)(6512007)(478600001)(66476007)(66556008)(66946007)(6486002)(966005)(41300700001)(86362001)(110136005)(4326008)(8676002)(8936002)(31696002)(6636002)(316002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?biszSXY3L0dKZzRzdVJ0VXBJT0VBeWZrcUREandKeWYwRjNKUHRTa3VLeDRG?=
 =?utf-8?B?R3FVbVFWVldvakVHaSt4Qm1yRzVuRnFCbTkzeEZKTnY0aEdSTEFuTElOTEhJ?=
 =?utf-8?B?WVRYTzVlQVQrR1F6U0k0MHhjTDRWN2VBUitHOXJ4VDArbllPV0ZnWnY2a1JX?=
 =?utf-8?B?cURUZkRFOUgrSXYyWVFJWUNEMGRKSjNkVG5kVWpsRkt4ZDE5RWprYllqc0Jn?=
 =?utf-8?B?VmNCMWI0cVdwT0dPTitvTmRoNTJ4WW5LakVtRnRRdC9ncWU4MUp6SVVpWGU3?=
 =?utf-8?B?OUg0ZmZodnN4akhweVRQTHVURlNnQ1Yzd2NpUEZwd0k0Z1hJdldQVjZVYi81?=
 =?utf-8?B?cmRuR2tpYWkxaGtHYzFRcmRzZ0huZ0Y0MUV0V1cwbVVwUk9FRm56b1N3aHhN?=
 =?utf-8?B?ZzJqbXBvWnBrUTdaaGdnNzFvakdGamNjbHdmSW0rNTdWUVcrMkJ2WEphLzhK?=
 =?utf-8?B?Zyt3S1BycVhsT2pjUmZEaE5HYVZPb1lBdGZsT2FVQXFNSXB4VWlMMVlWa1Mx?=
 =?utf-8?B?bUpiblpRZmJic1FTdjVxMEI5cmtMeHhYUlFTNDRmSFB1c1VXU3RMSlhHNGxH?=
 =?utf-8?B?dndxT2srRDdXaUx0SytibmVLcE9UTjBjNzBqYllnb1JMNnJab0prZGhMMU1P?=
 =?utf-8?B?R2R2a1JvamkzVHVyMTJRV1ViN1pnSndWL3hlNVh1ckNBYnJvRnpUY2FYa2dO?=
 =?utf-8?B?K0pOMCtWbEcrMzJTSFpFaWhIUTBINWQzMkRKbHh0Q3RaOGMxV00zZzkxMldo?=
 =?utf-8?B?ZHJXWXlRQ2V0cWM5cXB6SVo1dTJWa0Y5czNuTEtaOU84eGs3THVMM1BIM3V3?=
 =?utf-8?B?WWNJUm1GVkZMNTErbTR6Ri8yZ0kyMXRRSTVvUHl5T3BvQVkybWNuV1hzVTdR?=
 =?utf-8?B?eUNqM0ZBS0FNRDNDallwQXpub3U2T1pweXkwSmg0bDdCQnA5ZVp3bUsxWHlP?=
 =?utf-8?B?YVVVY0NvUFcxSkVqSnBFTG84K0FVNUZkeW1zMlczYW45TDV6UlFTRHh5dVk1?=
 =?utf-8?B?SEdUQ3kwVFA1NlVza0NoZUp5MThhZ2pjUkVMQThVSTF3UnRMeFp1QVIxUFFL?=
 =?utf-8?B?WGlwaGQ0cm9jWERmV0dzMjJhN0N6eFhTb3JTTjVad3F2TWVZK0dQOUFHYU5P?=
 =?utf-8?B?d0J5NXo2SmVtMjJHR3RXM0g3TVNTb3huLzZqUE0rZUNWYTJoaTJONi9nUEJD?=
 =?utf-8?B?VnpLU1k5d0g1MFpNSFY2ZFZJdkFBR2FUN1NxOXlXdG5oYnlxRXBFcEJRczZ2?=
 =?utf-8?B?RUo1Rll5S1llcDNKVVJwUG5RTlJtWGxLZWZQa0ZnNUxLZktxN2ZDOVgrTnZi?=
 =?utf-8?B?T3hOYWVweDM0amlSbStFZ0FsT0RiaFFzUnVZdmZsc3E5Zmd6aC9uRVFhb1ZO?=
 =?utf-8?B?VFM5UEJBUEFMSkdNQmFjMEpCdG1BbWZaOW9hcG9wSHFHalZleVBPNVMvT2c5?=
 =?utf-8?B?RkIyQzR1dE1DL2NsUDBlZ0dCdWdZek1VMDlVTGh3RTl3ZjJlWUJLQUx1WE1h?=
 =?utf-8?B?Q2VrUzlLc1l4K29OVm5ZQW1uTmdCSFJrK3R6aitqNm9tVThoWlhKZEI3UzRa?=
 =?utf-8?B?YjJ5eGJrSmx3Ryt1dTl0UVVSNHZjdFo2cGwwU0E0dXFrM2tKRm9EeExQY3h2?=
 =?utf-8?B?Z2VrSFp3bmFlUk9ZL2pIVDJodjFlbEROMUp1a2NJaVpMZnVmK3pTN0dCV0Fo?=
 =?utf-8?B?THhBRGNpaVh1WlRSSGxhanExYUEzUUtCRndkMkV0T3J6UHVhVU9nWlc0VkdE?=
 =?utf-8?B?MjhINDBacFk3akxKL2lzTldOZWJVakJiTStOQm1qUzFxd0dBbzVsWHNGbFUy?=
 =?utf-8?B?K0xodmJ5ZjR0L2J6UTVLWXZhc0w3ejM5bDROUUFQdEdBVE1yV1ZUeVpsZGh2?=
 =?utf-8?B?RnJwdFRBdEh6QS9ndHE5ZytaK0NJRFpqOGtFWFNCbG1oRmVRUFJXak5JUnNi?=
 =?utf-8?B?QXRyQkxTdXpuaWJtdWFGNkZVQlZYdVVFL1l5bUdNN1RIRjI3ZElSTGVRZGYw?=
 =?utf-8?B?V3BQM3RFVm5FNW9aNEZQb1lqMDV1cjZWaVZLK3pzdGFQL2JGS2t3bE5SYjB4?=
 =?utf-8?B?MHlQMDZjbjNvakNaSFRxb0Z2TklYWGtiV1ZSb1RNMDJvTGEvS0ZXT3BwNXBj?=
 =?utf-8?B?Tmh3RHlMZnVkVkdpVkVuYVByNjE2dUd3SGkvR3oxZEVsc1FZYjZoU3VjbWU3?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6d2b22-a6b6-4011-4d73-08dbfdc7e3ac
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 23:45:16.6426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lsnCT7hAWP2qsiwYfYKLpcQ5+pM8coPwaJg8cTl9L1PkAHuM9D33nJFDlWm4jOUCX4VvzNgLPGEN908BLtu6qS1trHv1alh1mOOP1FJCTBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7393
X-OriginatorOrg: intel.com



On 12/15/2023 9:45 AM, Reinette Chatre wrote:
> Hi Ilpo and Shuah,
> 
> On 12/15/2023 7:04 AM, Ilpo Järvinen wrote:
>> Here's v4 series to improve resctrl selftests with generalized test
>> framework and rewritten CAT test.
>>
>> The series contains following improvements:
>>
>> - Excludes shareable bits from CAT test allocation to avoid interference
>> - Replaces file "sink" with a volatile variable
>> - Alters read pattern to defeat HW prefetcher optimizations
>> - Rewrites CAT test to make the CAT test reliable and truly measure
>>   if CAT is working or not
>> - Introduces generalized test framework making easier to add new tests
>> - Lots of other cleanups & refactoring
>>
>> This series has been tested across a large number of systems from
>> different generations.
> 
> Ilpo, thank you very much for this great cleanup and a creating a
> reliable CAT test. This work is focused on kernel health and greatly
> appreciated.
> 
> All patches in this series should have my reviewed-by tag. For
> confirmation, for this whole series:
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> 
> Shuah, could you please consider this series for inclusion at
> your convenience?

Just in case somebody tries this series out against kernel v6.7-rc5 ...

A problematic perf patch made it into v6.7-rc5 (v6.7-rc4 and before are fine).
When testing this series against kernel v6.7-rc5 the splat reported at [1]
is triggered. A perf fix [2] is already queued up so all will be fine when testing
this series against a kernel with [2] merged.

Reinette


[1] https://lore.kernel.org/lkml/20231214000620.3081018-1-lucas.demarchi@intel.com/
[2] https://lore.kernel.org/lkml/20231215112450.3972309-1-mark.rutland@arm.com/

