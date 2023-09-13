Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD0779F366
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Sep 2023 23:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbjIMVBl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Sep 2023 17:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjIMVBj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Sep 2023 17:01:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950811BD2;
        Wed, 13 Sep 2023 14:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694638893; x=1726174893;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nON+/n7BsEoIeZVfkYOuqgt0FBKkcC8UuoTiN50FAgk=;
  b=B/TypQugVb+SlZkp4BqMLwjwqSt7eFQP9cH1J+X0rMN15tmwRmOkC9Xt
   F022QDgIf+/GZT/O5IFc3TltBJArFGXbGDVHTShmnt6go5yxucTQaFYBP
   uwmme95PsE662eoLYxBXpQIRXva5yGLIi8G6F00fgNRvODG0IJGHqSMQb
   gYBY9+AVzN7DpjD3kLkGEpXXF6MFmviJjxYoBgWMPaxrHlqyXzockCDR5
   CbhxcI7i6xGG3cve56vMRwe4OILIKFm+SvRlFUBm1v+nkPgKe40YRFtV3
   K4MrMRw9yHZGbTthxrkN14VIUp1UzdHbrDJ/A6I4+AXMKGmm5a7DJWe3Y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="363819703"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="363819703"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 14:01:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="867963747"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="867963747"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2023 14:01:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 14:01:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 13 Sep 2023 14:01:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 13 Sep 2023 14:01:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOYZDjCfnfWcKKESd+XPto4lP/lOExJttb+XWVO10iUxp/hcv8aEcV+0KKF+x4G9yMsoCdWC/gsbPO7u8jA4zSq+o9WTAkKfdElc39Obm+0b2rNymGLBoCZZpHZasFdjYVFJU1J1mkgeuwYDWQJp9Rh6ILGfJ0Dnh6WvWcz2zwa1oKLs7TGoAv3ZvsjvgiR1b4jIuvtwdbzDT0lkbIFYjvFeERndODuVVzpxJMg8IaCU2C00lFhKS3YoM153mWvEsYhcCZuAY+xYBzBcMrYVqVIsNKiPD+mOhQ7Wu/u8hahGLeQ3qO72P3F87iybdpcooUU6/SeyuNPCc4ymhrFuMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfmRfBGHERSV2Baobnm+3YCsl7gB0/GxsP5DF1To2P8=;
 b=b0hGcCtbRJPL/pO7O/ZvNDy7kwKxHwi2TCSFuFyP7KgwxcKSK8PIZWGWbQx5Ef3UjigXcUorMToJz8eA2XODadHPE7MU7mEaH+51I2Aw9oJNNXd9Qm3VEGGnJDYCgwQxRAXmrjZT+e2LCI9R0twDqSSDg8TIbLN25c7LPb6OqHh7WY8xwcyLpymtBRQnb2SY8pxz/l4rhQre1FminiAHD+0mYfmN9xEm9wCHBMYUeVfMnBXydWK3d8ZccN2JbD1G4UQsZEHurDXrClWDTTATFOsCoPeZuEpUep1UVMKliXhM0TwaTCldm0m6t/B9ka6az36hmfoaLKGw9FLSLUGdtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7811.namprd11.prod.outlook.com (2603:10b6:208:3f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Wed, 13 Sep
 2023 21:00:21 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203%5]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 21:00:21 +0000
Message-ID: <ae5ab387-0a1c-3613-5c04-db879aebc856@intel.com>
Date:   Wed, 13 Sep 2023 14:00:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH 5/5] selftests/resctrl: Reduce failures due to outliers in
 MBA/MBM tests
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>,
        =?UTF-8?Q?Maciej_Wiecz=c3=b3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        <stable@vger.kernel.org>
References: <20230911111930.16088-1-ilpo.jarvinen@linux.intel.com>
 <20230911111930.16088-6-ilpo.jarvinen@linux.intel.com>
 <cf7439c4-f72c-a145-5a65-84ae15c5d96f@intel.com>
 <c1518af-cc3c-3aa7-a3c-4bbfe8cc6cd@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <c1518af-cc3c-3aa7-a3c-4bbfe8cc6cd@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWH0EPF00056D0B.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:b) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: 2569358b-6f7e-495b-3dbb-08dbb49c7192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wLHd4CKcR1n3f4n31YxIfufbsjwOI3rp/hD1GPZSlmU69ACQhKZnViLHBqm+W7k8RBUopzs18Pe1o6uPGFQ2OO2sYpxi+NjrnXaQZEt17LDeSYvEx6x2iqC3I0l3oTgXaf+ldaX5VIY6aKe82vS/QMJ9Ut+qjhglZgAsvtXhPnFHutEe2uSzrfVlHCxEJSUZnav5T27uSYtBmMPGBm4xz2A8TyKGT/Nn09P2DIE8Iqd6fby+hDhCsI1YGu6trWAbpkAH43a5WV0kXz4YZP1M+Liny7RRSOEkBAGj7ny0UU1iFP8/lb+q71zZwNbOTyR5KhtLzDMPm0MuQiixKmJ9PvjoiCiOxjqDN0ZW0HGeVzlkLCl/zKd/A+c/cjW/SDjEJLdMmcINOsE3BkbRruGMYrMnEHZifsTYAb57aRwX/2Rs9inY8SpP6mZJg0c3K8XXzFfg2s917EV1Qvo3er1N9iNd2GZdL5mOBNupC0egVoEQcklV1SGzUEaNwZ+YKJvT4rTQQR6mxy0+tpNogYtc3DTqakwqZYRsWfChQAgWirYMUIYOG0iR1u3ufK3zsQ+YzQdeRpAH+77HQQ+2B9uSBuU+ompPv1whjubDqBhQi1fiUsm4zfnA8RC2NoT8fQXBrPTYmfJ7j6O/Yw0ZJXWsjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199024)(186009)(1800799009)(4326008)(66946007)(66556008)(66476007)(8936002)(8676002)(478600001)(2616005)(82960400001)(41300700001)(316002)(6916009)(6506007)(53546011)(6486002)(6512007)(54906003)(83380400001)(5660300002)(26005)(44832011)(31686004)(66574015)(2906002)(86362001)(31696002)(36756003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHlMc3JkcWx6T2ZQN3JsY1IxNzhURTZxaHpFeVh3R3JWZXlSaUw0bkloRklU?=
 =?utf-8?B?OGtteEhPVG9UYzNSd3ZVVTA3d3NObDNMWmxJVjlUdHFSL2JOU09pa3pQcXli?=
 =?utf-8?B?akk2V2ZybGZRei90TXAvQ0hNYTRsdnExT3RDNnlCNlNWYkU5R1U5WU85b1Nu?=
 =?utf-8?B?UVJlMG5oUm5EakpBdmREREN6dzUxWENJbHh5V0RXZU1Yd3lxRTZOSENYZ0FP?=
 =?utf-8?B?ZkdSN2tRWVRKRVByM1JoZzVOY1dqc1hDSHNQdGhnc2JsbFgweER1elNOUkVj?=
 =?utf-8?B?UktjLzhTazRyUXZXaU1vNytiVnJLTldPMDlQUFJIbGx3VGxIdVdMR2xVOUpR?=
 =?utf-8?B?SjRWM2ZGcHdGK1JWbGdJdU5PMFBSOWd0OUsvcnZWSjFYSTNMUG1SUFF1MDdm?=
 =?utf-8?B?dERJdEJ4bGVoZ3NURmlHS2pDMGRVdlh6S1o2LzVRY3hHczVnaC9zZkhLYnUw?=
 =?utf-8?B?WEF6amgrMVNYeEROYzI2cG5xZzBSaVhYTlo5dFI5Q3dwSzRWN1FySnJmbUJt?=
 =?utf-8?B?em9HNTczZ2VPVFFvZjNLWklEOWRzKzZHWDNoM1hnaEI2a2U4V3pCS3lOKzYy?=
 =?utf-8?B?NnBkVXRVM0VmcWpZd2V6Q2duUHkrQXZZYk00dmd1TXVhOE9IRm11NzlWME5r?=
 =?utf-8?B?ajRadHBSTGxLNko5RTVXcWR5RzBscGsxRHBmSVIzQno1Y2NaUU00WU5tb0ls?=
 =?utf-8?B?TFkrYXBwM0FPZmlJdDB3RTF6TzFQUmR6L0syZXExR2YySzNCNGFOa1JPaEFs?=
 =?utf-8?B?R2xPdFUreWdDd0QzRmFCdW1xdmNId2tUSDFVN0ZYZndSVXBKTWp6SjRGRXph?=
 =?utf-8?B?VmRHVnRSczRBZElEQThhM0QvWHZ2QmorMkgybTFqVFZhdTk5RWlaZ1l0Y3pG?=
 =?utf-8?B?cC9IWVdjS2EvMmlUZmlVdm5xNzlIWWp6NmFmeXJueG94SVY1MlhJZk5wRmp2?=
 =?utf-8?B?NFNXQU9BYmdYQ2hSdFVCSmxtNDZGaVZwYllPaE1iOEJIQ25ibXpHbG9sN1pq?=
 =?utf-8?B?eS9JWldXMHBFZXFHWWdiQnFUTU1nMEdVVTVIci81Y1lkRzhGYzY4S0Q3RFBk?=
 =?utf-8?B?dEVSazhWWEg3NXgzOUhzY1gwOVk3cVFsMldIQ2dSZkE5b2hXM1pFdHk2L3Fo?=
 =?utf-8?B?UkZ6OU12Mkp3dzRKOGRNa2NPQ0licUNSd1ozc2orSVZTbWJwVXVnUFQxcDdk?=
 =?utf-8?B?cnlhb1JFbVNTaUdLTDA5ejF2YmEzcnJBb1FqWlBqNlU2TUM4VXA4bGNlMzAv?=
 =?utf-8?B?a1hTclBuWXN3R0plTkEwbW8xVkhpakdMRzU5RVRWdXNwSDRKamo2Y2I3OXlC?=
 =?utf-8?B?V0orWmJMYmVQb3BQOURDRnJYZE5HR1c0SDVUWVVsUklCL2x1N05ocUxaMnJv?=
 =?utf-8?B?a2dQZGwyZE9rL2I5Z0g3ZGF3NnZGNElwNVlOWUQydENsMTE2Rm1FNHJpQzdp?=
 =?utf-8?B?czJqeVVvNjNlYnNiUUdpRjc2Y1hBTzI1SVpBMk5VM2hQV2V5dmtpTlZ6cy9B?=
 =?utf-8?B?RTFNNW9zaGRMcXFYeDFqNDB1VU1OWXAxOGdjMTl0R0JLcys3c09hWm5qc21p?=
 =?utf-8?B?UkZ4bGlBempPalUrb3cySVJPc3FaMytBczZDeE9HaWxUTWV5aFNPS2lGUVI3?=
 =?utf-8?B?UG1Yd1ZucHhQS0d6UEZBQWJ0Wks2blZUcW55RXBNZUFjMVM0YUwycVA2bXd1?=
 =?utf-8?B?a1J1Zm9pVEFCQUJxdmRpZHhaczNBdUR2NjZsVnZScXpCQW5Ua2swdU52M2tn?=
 =?utf-8?B?cnFOT2xZZDZIc2oyOFpTMUdvQVdEOEFZNFpZRUxZWmY4TDRtSWdaY2s2YVQ0?=
 =?utf-8?B?c0djWWpSMHdydDNqbE5NVDU4TmZyN2MwdndNREtKSks5dEpqemN0WjRYdUhL?=
 =?utf-8?B?bVVJS29qUnV2SU44ekNvY0FSMkdWZU9DKzhBU3Y4d3NMbDVRS0dDRXZOUFFO?=
 =?utf-8?B?V0JxMkpreVNadE9iYVdxVk5zc3BJU0dLSk12UFZKekdKN2NLek9MRERqTXhV?=
 =?utf-8?B?OFp4dWZuTDYyTk94Mnk0eC9hS1o1cmNuRG51dE1oclRXMVZmL012cGl4eDNs?=
 =?utf-8?B?WUoxVS9TTGNkVWN0YTB6VEFkZzVDQmUvYy84SktZeXJJRjByT2VBUUpIY0Yv?=
 =?utf-8?B?eXcvMElKZXQwM3VNUW82aGtGeDh4R2Mvbk5STnBsMnVSOFpLZitYZDREYnhp?=
 =?utf-8?B?L0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2569358b-6f7e-495b-3dbb-08dbb49c7192
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 21:00:21.7863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MeyWBlog1g6F7XKlpBqjIhHvgfykWegF2SF/3aNXTBa/sU0ZljxcOSWBeepRCl+GJABLR37pNtPMfOc7dl34AOnKsJXkh5nfEzGBWN73l48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7811
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 9/13/2023 4:43 AM, Ilpo Järvinen wrote:
> On Tue, 12 Sep 2023, Reinette Chatre wrote:
>> On 9/11/2023 4:19 AM, Ilpo Järvinen wrote:
>>> 5% difference upper bound for success is a bit on the low side for the
>>
>> "a bit on the low side" is very vague.
> 
> The commit that introduced that 5% bound plainly admitted it's "randomly 
> chosen value". At least that wasn't vague, I guess. :-)
> 
> So what I'm trying to do here is to have "randomly chosen value" replaced 
> with a value that seems to work well enough based on measurements on 
> a large set of platforms.

Already a better motivation for this change. Your cover letter also hints
at this but this description does not mention that this is not just
another number pulled from the air but indeed one that is based on
significant testing on a large variety of systems. This description can
surely mention all the work you did that ended with proposing this new
number, no?

> 
> Personally, I don't care much about this, I can just ignore the failures 
> due to outliers (and also reports about failing MBA/MBM test if somebody 
> ever sends one to me), but if I'd be one running automated tests it would 
> be annoying to have a problem like this unaddressed.

In no way was I suggesting that this should not be addressed.

> 
>>> MBA and MBM tests. Some platforms produce outliers that are slightly
>>> above that, typically 6-7%.
>>>
>>> Relaxing the MBA/MBM success bound to 8% removes most of the failures
>>> due those frequent outliers.
>>
>> This description needs more context on what issue is being solved here.
>> What does the % difference represent? How was new percentage determined?
>>
>> Did you investigate why there are differences between platforms? From
>> what I understand these tests measure memory bandwidth using perf and
>> resctrl and then compare the difference. Are there interesting things 
>> about the platforms on which the difference is higher than 5%?
> 
> Not really I think. The number just isn't that stable to always remain 
> below 5% (even if it usually does).
> 
> Only systematic thing I've come across is that if I play with the read 
> pattern for defeating the hw prefetcher (you've seen a patch earlier and 
> it will be among the series I'll send after this one), it has an impact 
> which looks more systematic across all MBM/MBA tests. But it's not what 
> I'm trying now address with this patch.
> 
>> Could
>> those be systems with multiple sockets (and thus multiple PMUs that need
>> to be setup, reset, and read)? Can the reading of the counters be improved
>> instead of relaxing the success criteria? A quick comparison between
>> get_mem_bw_imc() and get_mem_bw_resctrl() makes me think that a difference
>> is not surprising ... note how the PMU counters are started and reset
>> (potentially on multiple sockets) at every iteration while the resctrl
>> counters keep rolling and new values are just subtracted from previous.
> 
> Perhaps, I can try to look into it (add to my todo list so I won't 
> forget). But in the meantime, this new value is picked using a criteria 
> that looks better than "randomly chosen value". If I ever manage to 
> address the outliers, the bound could be lowered again.
> 
> I'll update the changelog to explain things better.
> 
> 
ok, thank you.

Reinette
