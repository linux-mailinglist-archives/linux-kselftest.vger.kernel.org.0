Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569947568BB
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 18:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjGQQLT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 12:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjGQQLS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 12:11:18 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB38130;
        Mon, 17 Jul 2023 09:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689610277; x=1721146277;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kC6nHMHm36Jfsn6ndRWdDNH5UviC5GWQU8//9aCR6rs=;
  b=honXALsovEthHUavfLh5LaTv4DjywvS3X/D9Lu2zRNHzJEvmiji7Y7VY
   veluCKQaNww0fQ0qgiPEFy344jyFOn3u75SpiaJLpO197DIo1wZmxuzfy
   OpHKlYKX2jpCNp9V5PuVf1uAJ4U4leefxEkfrtp+zjEATztAvR8rXNtU9
   KJWCA8+AN/D0otPAiFdcLQaojNrDe5zRTUya8wbHKOkgAgLCKXEaQV4Nx
   ZKRFzNwZ5ehuPBem3EreKs9TuHMCpkuewNQLnwrPybVz616XD7oYOLpoV
   currGXrDm9oHhgaEBJOD2TVbHrzdbtAYRUsetPMdqSXex95QaEdvIFWk2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="345562620"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="345562620"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 09:10:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="793299737"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="793299737"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jul 2023 09:10:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 09:10:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 17 Jul 2023 09:10:11 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 17 Jul 2023 09:10:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjLtJpLblT7LTezTlzSJstgIIIT+X+Wf5FWn1NFAdju9BIv5z5zQ54FVXTrFoi9tImAZA/drr2SduMmTT4YQjLEWVKJzMi42BpAtMhQHs9AqLsO7LkL24TXCgLLWfgSs94Fj1HX0B0oMb3FD/x/Veh2FopI9jYc9yhJtOYIuJYopoF3J4rcDH7QU59E6/Aqi7aMw1GxQzz5rC4O7O41Jk2urNvme+aCue16qSS8eMZks8wraV67pz8p9DJlGJzPkNNH8sNILz5OLZimPE6sD9y4rtveLMxxvhA8EmjSKfbx/ucy9bR2LhiiHtUTxBCDfgyO38Xuj8L2kJAqsvvoGBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYm7oX1VfjR74ZE/gXe+DhQUnD7d4YhYcNIJ6v7x6Z4=;
 b=KNtxlJNm7B8+pN7KUhZ4r1aWc8hF+vKocE+x656vyqBpaL2CMVsImu1o1tjSGgwfkYeAXUEmZmaRtAjlEHDCixXSxvwkGc4FT/XLuuvVH+JJmSe8I8vcPYx4uVLbM4rM8EPy6NcoYejuIEXoc9ApftfHYoGJtAnbIHuthfAqj/by1d2jpI9l7Zj1HKGHk3r6RpRI1P1kwXZMceMVXPsIGMmdtT90hVe9iMKfaPsEoVUf99lb7Qszsvo46trINLpBrSVJSmfpobq9QvAOA1+NVEbqhxwdO09M2DPdh3HkCp6MxJL78gfCajlFBgqs8L2y+2lD7Fm5GL+3kqWhgC5/Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ1PR11MB6298.namprd11.prod.outlook.com (2603:10b6:a03:457::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 16:10:10 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::116c:1030:6e1a:be28]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::116c:1030:6e1a:be28%5]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 16:10:10 +0000
Message-ID: <b6bb651a-aa2a-0179-4976-5656fa446a8e@intel.com>
Date:   Mon, 17 Jul 2023 09:10:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 10/19] selftests/resctrl: Express span internally in
 bytes
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
 <20230713131932.133258-11-ilpo.jarvinen@linux.intel.com>
 <1dd10447-b03d-937a-fe55-ff324864c358@intel.com>
 <0c94daef-3642-9e8e-0e8a-3f8eaa2953e3@intel.com>
 <fce81fed-592e-16ad-b833-735a7b3a186@linux.intel.com>
 <f1233835-8c94-e110-531f-13712569b7c0@intel.com>
 <7eef29f6-297b-bb2b-e0d-ccef1aa2f14@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <7eef29f6-297b-bb2b-e0d-ccef1aa2f14@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0157.namprd04.prod.outlook.com
 (2603:10b6:303:85::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ1PR11MB6298:EE_
X-MS-Office365-Filtering-Correlation-Id: fc55f791-48c3-45e7-7256-08db86e04b7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NTs8zKPuGYUXCnuKjL+JHA1fY3iaZSgzgeyf+nDLAdtkIeraqgDW0l0q3TK4C8T08C/EXOXt03OqBq4NBOIqnd98KrWV6297LNwRBrARvr6nBLJm8Gf0ek9m0FU8gjQLYnl/zDVR1m3Z95LXcDDvgqtSyuar3GZ8r1ECgduMWI2wosqS++w9jL7RCuCx8M4syMuxpdc0H7VbWmj2uwv9krcFKLgHTKaKT90aSjejjTN5QHyezKHV0otBxNDf9V9kfdfo3eXd/x5dqhZhqzp/e0bWql4wFJuqNwKum1a3h4pAjJd2DH7fNNPwyJ7HaIaCZz1coVdV849I/d41946dm+VY7Rs1fTfb2ongnJ21PMYrHwP34aso90ASyuubE9SBjpXv/n1wLHEfG7DH3b7c6KWGjuX7Vuov2S6AlDYBxJ8x/niTRtpshdNoseldlbruslBQl6Bfnt1zqFMs77tDs2Z2uPkSJUgPmIcOwmMSUenwe+zjhGBa8YS4MhRYwNc0izey0nBHKmDJLRzw6HhLMVdxhl2IDFUTjM9UMWxt6Nb5x9l+XJ7FoxXH0VKbpcBPgxMMM/YO8jlFFmREQewImjmGfMxzk91nSDMbRITt+JtScEanryGRkDLiY5w9Hi+W1bYBtoBzzT8co89Zsz1qTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199021)(31686004)(31696002)(86362001)(2906002)(36756003)(44832011)(66899021)(6512007)(186003)(6506007)(53546011)(26005)(38100700002)(82960400001)(6486002)(6666004)(54906003)(316002)(5660300002)(66476007)(6916009)(66946007)(66556008)(2616005)(4326008)(478600001)(41300700001)(8936002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aENxdnhIb09GeXZMc1p5bG1uUTJySG1vUUg1clRuREpxWGtycnRVMVFiR2tU?=
 =?utf-8?B?azBtTzR0L3Rtb2NnUnZlR3BTeElmYlphOE5LN0lITXUwNmdmRlQycFdLKzVS?=
 =?utf-8?B?MVFzK2g5b0lJenBKenB1amJJeWprN0ZSWFpWWlQzZC90YnRhWWFDTko4L01r?=
 =?utf-8?B?RllJcjZkckZhU05NMEJPQ3FMaUNER2hKVnhIOEZHTS9VZ1VSTUhNY3Fjc0Uy?=
 =?utf-8?B?dlovR05QN2JEZitFOE1TY1BkRnZhVFl5YzdHWlh0bjZhVE84VHVWVjhuNGJI?=
 =?utf-8?B?M0wvTHRaajVENjZ1UngweHB6bCsrTWlmZkJ4Nm8yZnRhRXh6VGhDc1Y0NG93?=
 =?utf-8?B?MWlkQUU0VUtTbk9yK0cwdzhFT04vZW5FckJBUkkyS3c4ZGhDVThBZjNOUmhs?=
 =?utf-8?B?WkNaYVFaclI2eElHZHIzVmNuTStNTU5xNUpSaFlIWXpRbXptSFA4VXBCQVcr?=
 =?utf-8?B?UFNEcG9Ta0hvdDk0cFBhK1dKOU1UL0VLaWQ1ZWJhS0doaXkzbEFMTHZadzZM?=
 =?utf-8?B?MDJxOG1WbFJhV3pGME5pZkE0MU50aTZBWDZEL2RKZkNLSjhZVXV6a1FVVDJu?=
 =?utf-8?B?QzZwTDY2NHNzUFhIeStTMDJ2RW4wS2JKZm1ISlE0czFpZ1JnTU12ZjNpZXVW?=
 =?utf-8?B?T3hJVnJyL21uWHBhcVFzdGUzZG1MMytwWUs2VkZwWGtzNDFZM21pMkQwNGRE?=
 =?utf-8?B?QkJSVHFwZGx6OWpDN2RnQXU2eU1EZ2lrUFlDMGhCNmFDcVN5SmxZWUZNWFM0?=
 =?utf-8?B?Y3kxeXJxN2lFSzBaVjhBU3JZOGRZM3lBWXBtbUtJVERvemZPYWpFR0laM05n?=
 =?utf-8?B?SFpCcEd0RjlCZjFWTytoSW5IdGZvM2QveitNNjk1UHFONXl2TlNVak80VnIv?=
 =?utf-8?B?NVhtTmJBUnZ1cWM4VjBjbjBXZnBibzIyMThCSWlQaTJ1enNJd3FVQjBoUUli?=
 =?utf-8?B?bkJEK1NqZEJVak9NNzJPODFQcWp1OTh4UjZMTEY4Zzc5TTNJazFiRWVpQ2F4?=
 =?utf-8?B?VTZyNHhxWWhUaGpOcHBlNlgwd0o5ek5yNTVReEN2ZjFnZW8rc21UK2xRajJ2?=
 =?utf-8?B?dHFjVHVCY2pFYzl1NTRQUU5MQ0hCcVZXMXFiU2dGTjduQ2tuQjdGVnhLTGpm?=
 =?utf-8?B?alFRY3JoamVZUXEyM3ExVmFkTk52REMzbDVJVDV3UEVzMWFBTjhMOFB5WDFZ?=
 =?utf-8?B?TVlFRlZadnJZWnZuSG9lOThIdjVhaEFQT0NETkRyTlhZZU5JeTFJekNYajVG?=
 =?utf-8?B?NGY1RUhJM1RBeHZ4UnBEOTY5U2pXU1N3bUlJUHg1QUVveXhEbFJoUjFTTklm?=
 =?utf-8?B?SjJCTzl1bnNGNklyd1lsTXNsQWdUczhPb1JvR3l3K0dWRUJjQkZicE9FRFox?=
 =?utf-8?B?YVI2bVNPKzhqcEFrR3lVUkN6ZzJiaXpCY0pkOTczWXZaR3dManRLaW9Edisy?=
 =?utf-8?B?Qk85ZW1RYlp0MzhUUEJUdlIyemhyT1JtMmZveXRsVDZFSytEdWtuL1JqRGFs?=
 =?utf-8?B?YVhQS1JFS2lzQ2xpMEk3cVNkQWVwQ2pnSTR6OGNnVWVkRExCYVlDdDEyQnVQ?=
 =?utf-8?B?MUw5OW03WEFDRExyTnR2dEcvVWhHN0R5bmluQlVYZk5OT3o2QllZcXNSSW00?=
 =?utf-8?B?NmFMVk1mZjJTcGpvMGlob0tubGZ5NjhMZ0h4RCs4VjFaUGtHOWZVUlU0ck8z?=
 =?utf-8?B?ZFY5Z2JLYjhPU3NpVDlQNVlyemRYanE4bCtyZjFnL2R4dXMybmtwZzl5WVlY?=
 =?utf-8?B?eWRscVo3OWR2TlA1eG51dDNlOFF6NEhrYlczVTFNS0RlejROSUhKR3FxY3F4?=
 =?utf-8?B?aFhRdk9FMDU4clAyd2x1NWYyakp1MEptbW9SL1dUZGhpdnZraWNMc0tHaW5H?=
 =?utf-8?B?eFk2VWVyS2dtZElKV25zMHNlZ3JyU3p3VTl6ZkwrdDhLZStyOUpGUTN5eDla?=
 =?utf-8?B?aWc3OU5ja0JKMXpBT0hFTTRMbFkvN2tKOGxiL2VNdloxbmRVeE9tV1oxMnIv?=
 =?utf-8?B?RkY5ME5WMXoyNzFScHBUM1VPK2lDZ0tNNGpHb2U5OGJNRTJHUEdiNWR1RDRK?=
 =?utf-8?B?NXBJelFrY1AveEkrMU95WlZRdXlPSjlXUnloWUhYUHN4QTdPYzE3NlcrSXpx?=
 =?utf-8?B?OEtZL1NndUtWL29PeHkrTTRjMzhBbXlJRk1wVElSM2F4MHFJZ09HaTgvL2dF?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc55f791-48c3-45e7-7256-08db86e04b7d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 16:10:10.1688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFWYr+hM3m4ZndqwiIj+QlX/MX/GIqn6iZzrSFpuI5OlFKrA78MIK23fD51PbvrQXiZ8wfsI1sRfZBx1Ys9TFH8Ck2JnBGoEFZt0/l0zzLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6298
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 7/17/2023 5:30 AM, Ilpo Järvinen wrote:
> On Fri, 14 Jul 2023, Reinette Chatre wrote:
>> On 7/14/2023 3:22 AM, Ilpo Järvinen wrote:
>>> On Fri, 14 Jul 2023, Wieczor-Retman, Maciej wrote:
>>>> On 14.07.2023 01:00, Reinette Chatre wrote:
>>>>> Hi Ilpo,
>>>>>
>>>>> On 7/13/2023 6:19 AM, Ilpo Järvinen wrote:
>>>>>> MBA and MBM tests to use megabytes to represent span. CMT test uses
>>>>>> bytes. The difference requires run_benchmark() to size the buffer
>>>>>> differently based on the test name, which in turn requires passing the
>>>>>> test name into run_benchmark().
>>>>>>
>>>>>> Convert MBA and MBM tests to use internally bytes like CMT test to
>>>>>> remove the internal inconsistency between the tests. Remove the test
>>>>>> dependent buffer sizing from run_benchmark().
>>>>>
>>>>> If I understand correctly the intention is to always use bytes internally
>>>>> and only convert to megabytes when displayed to user space. The above
>>>>> implies that this takes care of the conversion but there still seems
>>>>> to be places that that do not follow my understanding. For example,
>>>>> resctrl_val.c:measure_vals() converts to megabytes before proceeding.
>>>>
>>>> Doesn't the use case inside resctrl_val.c:measure_vals() satisfy
>>>> the idea of only displaying data to the user space? From my
>>>> understanding it reads the number of bytes and only converts to
>>>> MB when printing the value. Or did I miss some detail there?
>>>
>>> It's for printing there yes.
>>>
>>> But it's not about span in the first place so I'm not sure why it is 
>>> related.
>>>
>>
>> If this change is just about how "span" is interpreted by the different
>> tests then the changelog could be more specific to not create expectation
>> that with this change there are no longer "bytes vs megabytes" internal
>> inconsistency between MBA, MBM, and CMT tests.
> 
> The shortlog and changelog are already pretty specific in mentioning 
> "span" a few times :-). I added yet another "span" into the changelog's 
> 2nd paragraph.

There are many things to consider when reviewing a patch. There is the code
changes in the patch itself that can be reviewed for correctness but there is
also the review of the changelog's solution statement to review if the code
changes in the patch accomplishes the stated solution. In one sense the review
considers the code in the patch and in another the review considers what
code may be missing from the patch.

I looked at the v5 changelog and I am still left with the same impression:
The changelog claims that this change removes internal consistency between
the tests, which it does not. Since you posted the next version before this
discussion completed (which is not ideal) I'll respond further to that patch.
In the end it may just be better to drop the "remove the internal inconsistency
between the tests" claim.

> Your general observation about the other MB/bytes inconsistency is still
> a good one so I added it also to my todo list, it just doesn't belong to 
> this patch (IMHO).

ok

Reinette
 
