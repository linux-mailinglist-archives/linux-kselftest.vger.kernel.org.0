Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03156A25F6
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Feb 2023 01:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjBYAro (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 19:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBYArn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 19:47:43 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B32F6C8F9;
        Fri, 24 Feb 2023 16:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677286062; x=1708822062;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=werNeX47U6f+Uoh2po3o5Bp9PbPoyBOmx+X1r7hHkas=;
  b=g+Qp+dwtSI6upm4AUWmHonDgLYIE/jUblYs9rdtqlUxEw9ajFqGxUji5
   bs4FTIJJ8BH2KDHjlyaujpEFdjTVdU2IKUCFcK3JlVgrvX/Je1hs5dskq
   4SDjJPgIJ0GODe94jmawgq5pohJ89lrgDbZeQvjteFUYBqwBvEXGXE1H8
   MI2lswK9KeYOLDrqsH2QbMHwQ7EqUU8z3HnFfpsBp/52kdeHuS4LYNZfc
   cH0uWTF2fqOmQE9Bg/Z2Jt2MND4EHllyTJKla/IogGXHBkKZeQjRQE95I
   bF4bpQLBm6DwmzYTKVr/YryglZr+TkSLO6058DI7rb3+nN6/009UqrECG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="314001449"
X-IronPort-AV: E=Sophos;i="5.97,326,1669104000"; 
   d="scan'208";a="314001449"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 16:47:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="703360145"
X-IronPort-AV: E=Sophos;i="5.97,326,1669104000"; 
   d="scan'208";a="703360145"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 24 Feb 2023 16:47:41 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 24 Feb 2023 16:47:41 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 24 Feb 2023 16:47:41 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 24 Feb 2023 16:47:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvuxHLzhCX3hkgKjBsTc8Wglv751QMZ40iVcShavvcgwlTsMMrxJthKSgab8gnyd/PdMEGhibcPRNjd9vL9UvbGwDg/MWBXZAX19b+KjtujaAZR3UEheijj+bRQwhyZDD9uND7Com3XTwX8Uy8AdLjUIhUPFscRSm6PKL3uwTTYLxaxTC5DnhitmxIPmQrQxDMpdHCNedMjK1mIJQg+vv86gmIBOp6tPJPpB7AvAon8bnA81oVe3ptGqK0JGmu9i2tt+v0hPw6TRZvE0QpeHncQHo3QU8KIBJPUcZAuD6I2hwdPQRnQ1eL6H8wJTMpwn85cDB+XUUtPNWxShUO955w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOZ9x4ZNWU5zMbMuqUFa7Bwf2/Bjs43b75TxsbKkfHA=;
 b=kwhRDvNQGroTr3UYqdKlFS9JUmWFTvtrr4tJfv4Zl2Blm0EAgbZ6d1d7ZeIhU63wlVgkN8f8bIvQERGp1CO5IQQ+LJ/uQGJk2soFL1gBAgp4N/qMfeOwQuCHz4ClXFEWxK0/BoudRudAjp1fnwmDQhB0QKR0fzdq+5RVv9rImT6TUuz+qWdgisb5KXIsAWf2R8E/nw1rn8We8lMhRf5ksVlloAOXwLYC2S5P0JEKiDe/Sr1MrNBH3z66Kxgv7+xyIbs7NUvDq605W8TCcoSa1oENPyX0pu1PI6S+BarkH+KbP6YUWR3GlzNaq5OKoVOeum3hMz51UdczuotnCTfu9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by DS0PR11MB7736.namprd11.prod.outlook.com (2603:10b6:8:f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Sat, 25 Feb
 2023 00:47:37 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::f8d2:a65:2549:e36e]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::f8d2:a65:2549:e36e%3]) with mapi id 15.20.6134.025; Sat, 25 Feb 2023
 00:47:36 +0000
Message-ID: <691106c3-b339-578b-6e43-77f737f127f9@intel.com>
Date:   Fri, 24 Feb 2023 16:47:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 01/13] x86/fpu/xstate: Avoid getting xstate address of
 init_fpstate if fpstate contains the component
To:     Mingwei Zhang <mizhang@google.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Chao Gao <chao.gao@intel.com>
References: <20230221163655.920289-1-mizhang@google.com>
 <20230221163655.920289-2-mizhang@google.com>
 <e91b9172-8a2e-e299-a84f-1e9331c51cb7@intel.com> <87ilfum6xh.ffs@tglx>
 <CAL715WKLQxxeyFqiKbKsUmQ8bZf2f=rwADyKj1ftgROA+dhpXg@mail.gmail.com>
 <ea9d7394-73dd-23c0-ea05-d0ec4fcebb55@intel.com>
 <Y/lOlBWTNgROPl0P@google.com>
Content-Language: en-US
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <Y/lOlBWTNgROPl0P@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::32) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|DS0PR11MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: 55c6b0ba-b726-454a-3d98-08db16c9e390
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cT/PJOSsuO4bendiTQrMDESdkNuxorJhz1t8pECc0a/AugTEm11qXdeFFBWA5yEZAZBcr/vb92SIZof1SfIEUK6dKOU2st79t552+regHma68MU/hxljtIVwACRShuSSV8r9cUrO5NiiSHZtCyiGDZFD8ep7Zzl4kMxkXk6nod7V65kQMBwY5qQN1QQLeUZRgZb0g0P6tt0BhkSUGIRLwpf59iYwTncMsr4a/OVHWDGdEhDo3YIYdv99d/WjjRsrRgoq+vOlv/uPhgdUQKYAM9sgfBaWEdFXB3/neKup/u78gmSaYmrT2lPriYj8Z5kbBKg9C8+GocuhWwvce/DKRQHoox6YNHeD1dcczzQXvA+UD1DUxDKBkoioiXilcdmQaY0WbZBK+NKilCZ++vwO0zyAKnuLwxY4v+6UzixQMusJymx88mogkbuvfkAsZP3dHYwN6IvE9gXfP4iHF7OmKge7UBQrwkAf19LSZx+vf+zaGjtwDmjMTxuNWkbHxAgbPAPuoQhnaKLKVQESeU2Lep/CB8BCwzx9yqfbzvvWna+JORF7vxi6S/+QpXBzrRw7ft9jOLV3+Rhu6/4prmBVU6E8Xo2zPM1aYEvr2941iEL+JAc7chdDsRTBbnXPdFuotYqCZh9kadD1819Bx+QuPK8Z10yqlbQxLESYRDkjY7pkV1J5XDhRXfIuw1SAPxYXfCxSFN55llnxN39T+rnYsTxjM/6BJx//K8Bk5J0mTTY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199018)(8936002)(316002)(53546011)(107886003)(6666004)(31696002)(41300700001)(8676002)(186003)(6916009)(4326008)(54906003)(66476007)(26005)(66946007)(66556008)(7416002)(2616005)(5660300002)(86362001)(31686004)(966005)(6486002)(478600001)(6506007)(6512007)(2906002)(36756003)(38100700002)(83380400001)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU9VUzB6UkRYcmxNbVBsbkNDWk1EZkIrQjFUSFBtaGZZZnd4WmlBeWtGM2FS?=
 =?utf-8?B?eHUvN3lpZjZTckJuUFVocHRlWk05NnVmcHdXNlN1WHZadjV4R3dXanU5RU95?=
 =?utf-8?B?eitQcTE1b2UxcXQ2b3lwT2FVdmN0TjZFODJhY2xsdHhXYmFyaHNXN0YrRTU0?=
 =?utf-8?B?RSttZDRNYzMzbXgxcmFSZXN3aFBPYzRCS2hVVERvSkZsUlkxSEpzb2x1TXZV?=
 =?utf-8?B?cEhmUDhMdEg1ZGZtQ0xRbGJOZUZzeUR5SU16OHpaOHdSdlprV2ZKUUVYZVRp?=
 =?utf-8?B?Z21yZXBSSVByM2dzRjQrd2ZZOHVIMjNuTktqbFJNejZPbHdMbFFNMWpTdEFm?=
 =?utf-8?B?TVQwa3FkTWhrOXhVaGxpY2czcDJjaUl3eDhqaGo3U3VINnpmU0RKbHAwYzdG?=
 =?utf-8?B?SEhPK0dkZHlzdEFadjNyL3p6ck4zVzFBdnRMUjhYc0FSTHNScjF2OU9HbFAz?=
 =?utf-8?B?QXFpaU9NRmViamxvd2ZmVFBxRkNjQmVnR0hKazJCR3MzUlZVN2JTelEvRHBo?=
 =?utf-8?B?UW92ZEtGbkdaSlBIOTdFdmZEZzdaQkdkYmRzd3pCRDFUSUZML0JkOWJZRGk5?=
 =?utf-8?B?MVR6M1VIUGdlQW1TaE4vMHgyVUhFRW9pY0FoVmJhcU5Fdjh1aVJLN2UwMzdi?=
 =?utf-8?B?ZHlHWllTcXpOY2Q3ZWNZVDZvaDRuT0RTbGt2QXZxNXUzVyttUTJ2TGFUdjFm?=
 =?utf-8?B?YVloYlpUUDBER2FVdm9Md3FvSFZkNU9kQ1FRK0wrcGxoSHp6dHJaZExYTkM1?=
 =?utf-8?B?bTBWQ2srQ2p0Umk3eWFsVlFlTWV1MXhNSmQrVEVqMlowNU85RGVjZGdxVVFK?=
 =?utf-8?B?enRsM3JhQVlnaEUvWUhqYzFDMXV4TWhrZjltU2hTbzNTek9hRkZIL01xWkdj?=
 =?utf-8?B?c2ZPQno2UElYa2FiWHNPMGloR0NOSHNLRjlZWDRPc2QwWVBSZjJNcUorc2Vy?=
 =?utf-8?B?cFNreVZ1NVJpaFEyTzEwWEQ0ME1DdTdSeFM0TjNIanFuNnBQTWFTRUdBcFli?=
 =?utf-8?B?b3ZYSjI1WkN6UWRmT3NvSnBlMzRWWGdITXB1cG9EeVl4dUJrK0QrdndkaFRD?=
 =?utf-8?B?ZWxnMlJRdkJEUXd1bEtYVXJKMHAvZ3pPQ0RLbWNUTmRCdlVjMmlhWWNTOFV1?=
 =?utf-8?B?aUNnRU14aDcyZG9UeC9YVnlrb0c2S2xJSHNtY0I0YVQ5UTVxTVZhbXI4VElJ?=
 =?utf-8?B?VGZyTVlzWmsray9IMi9FaWNiTllSNkFjZGVrQ0FoWHR4TytOOFIyeUduc01R?=
 =?utf-8?B?cmpSSFRKY1RKcm5QZU1YNDN6eWZkalNQOUlNVTlTRHpCNlI0a2ZzNUVyR0NK?=
 =?utf-8?B?UUZJNGxmWnF2L0NSZTJWY0ptT2VkbzBOSG9KTVFKRThjUDdSY3NRSjRXRUJI?=
 =?utf-8?B?S1YzUitGY0tkQzBGc2JBS0RldmJnWlBmVmxrZkovbXFqYnUwVTVqQ2laTUNj?=
 =?utf-8?B?QXZtRG90K1JtV1huNUJoQjdDeHVJWGM1TVJPZGdWblllK09LQ0paSEVIbzFx?=
 =?utf-8?B?UEJKV3dkSXhHYzE1eldlWmQrRlBES3U3V1NLdktZY3dYN3BkUGRyb0tKeE10?=
 =?utf-8?B?eFNueDRzQi80TTg4TVZJanJCVDNyRVRNQm9SdTg1ZmNUbVAzczdsZkx2MzlW?=
 =?utf-8?B?czhmTkhmbzZ3ZitsVDllUzMzZGp6ckNDQjJHcC9kV09MeFNGaHNPOHcxT1J1?=
 =?utf-8?B?QUxyS1h3UURua001TDl5aWJmeU94RktGU1JrQmNxU09jZVZDek5sNWdtVU4r?=
 =?utf-8?B?WnFBeW8rMFlwR2VwVnVNTVJncDVSbEc5RFFEVnBqbU9QQk1tL2xMcUZyWDhx?=
 =?utf-8?B?SVlaMGt2WDJjbVl2Y3c5OCtYa1dsaXRINEJBNW5HZUx3NnQ0Tk5GcFZJZFdV?=
 =?utf-8?B?SUFXU1FGMk43Q3kvVVN0T2h4ckdmSXJLY3drdUtCUk5zVGFBVWpPNzRnRVgy?=
 =?utf-8?B?SVZiT1VvQnJyUGVzVGRsSEdUOVQwUkh0SDRiVEY1dWd6L21IRzBtempJTlQv?=
 =?utf-8?B?WSs4U3IzcXBTZUtZWUxRTlhsWE1UcHFTZUZnTklNbldKeDk1VEVjQ01tZExv?=
 =?utf-8?B?R2hINGR2cTVOOEdocHMrb3ZsSlVGQTh1TlVvUkxHVDdMWjE0bFRBanRIVUJp?=
 =?utf-8?B?YzFuU0pXZG1ybjR2VGVYWTAramh6Si8vbjNTR1l6STJkd2tSS3pwQm1DYWVB?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c6b0ba-b726-454a-3d98-08db16c9e390
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 00:47:36.7206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4SQlvG23WOYEtzkkTvmHp+svqQpCX9MRMTNrt+sYzYaMMF9EUJp/XB3uHSE35Dd+Gac/DXFjsavAwi5mN+WXVzvH+lX9rLeei8feQubjGy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7736
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/24/2023 3:56 PM, Mingwei Zhang wrote:
> On Wed, Feb 22, 2023, Chang S. Bae wrote:
>>
>>          /*
>> -        * The ptrace buffer is in non-compacted XSAVE format.  In
>> -        * non-compacted format disabled features still occupy state space,
>> -        * but there is no state to copy from in the compacted
>> -        * init_fpstate. The gap tracking will zero these states.
>> +        * Indicate which states to copy from fpstate. When not present in
>> +        * fpstate, those extended states are either initialized or
>> +        * disabled. They are also known to have an all zeros init state.
>> +        * Thus, remove them from 'mask' to zero those features in the user
>> +        * buffer instead of retrieving them from init_fpstate.
>>           */
>> -       mask = fpstate->user_xfeatures;
> 
> Do we need to change this line and the comments? I don't see any of
> these was relevant to this issue. The original code semantic is to
> traverse all user_xfeatures, if it is available in fpstate, copy it from
> there; otherwise, copy it from init_fpstate. We do not assume the
> component in init_fpstate (but not in fpstate) are all zeros, do we? If
> it is safe to assume that, then it might be ok. But at least in this
> patch, I want to keep the original semantics as is without the
> assumption.

Here it has [1]:

	 *
	 * XSAVE could be used, but that would require to reshuffle the
	 * data when XSAVEC/S is available because XSAVEC/S uses xstate
	 * compaction. But doing so is a pointless exercise because most
	 * components have an all zeros init state except for the legacy
	 * ones (FP and SSE). Those can be saved with FXSAVE into the
	 * legacy area. Adding new features requires to ensure that init
	 * state is all zeroes or if not to add the necessary handling
	 * here.
	 */
	fxsave(&init_fpstate.regs.fxsave);

Thus, init_fpstate has zeros for those extended states. Then, copying 
from init_fpstate is the same as membuf_zero() by the gap tracking. But, 
we have two ways to do the same thing here.

So I think it works that simply copying the state from fpstate only for 
those present there, then letting the gap tracking zero out for the rest 
of the userspace buffer for features that are either disabled or 
initialized.

Then, we can remove accessing init_fpstate in the copy loop and which is 
the source of the problem. So I think this line change is relevant and 
also makes the code simple.

I guess I'm fine if you don't want to do this. Then, let me follow up 
with something like this at first. Something like yours could be a 
fallback option for other good reasons, otherwise.

Thanks,
Chang

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/fpu/xstate.c#n386


