Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8709B700B74
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 May 2023 17:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241628AbjELPYO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 May 2023 11:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241849AbjELPYM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 May 2023 11:24:12 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE8DD871;
        Fri, 12 May 2023 08:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683905027; x=1715441027;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BsWKGeHKOLgcpLkjdh/oP90NSQ9JN1L9wYPWWn+neVQ=;
  b=PByVb9Pcrf5bbq4FM+j6iCaCzoys3qJrCgRt+GQm6XaWoRKEQpLfciHf
   TgFsUlHVv/DdzYlM/PZN3oT8rYPkycU2a5GTLdEUSFSoM/ZTSG0oipcgM
   4u8JgljGjxKTjocgoPO8Ppe2biLRZNUEtaikRDu6cq5l8gP678/xrh6se
   EzWokkZqY9GIG9/I9pDWi5foxZrxqJa9SgtWcWWaQF9ykP5yhav3A5K06
   jS8hsmWIhxQ6IX096+zL8NLvlz1sUXAA67eNCyECRf98IBJcf9UfqKCzB
   BXS+r4HguwaOE8iWC96z6o7NQwxJLXBzrAdJhut7R7Z7RYxO0wEsGapQO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="414184621"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="414184621"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 08:23:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="824395041"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="824395041"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 12 May 2023 08:23:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 12 May 2023 08:23:38 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 12 May 2023 08:23:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 12 May 2023 08:23:38 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 12 May 2023 08:23:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/jYrC7Z6Su3VVYkCrI3zZUBp9mC++5aAbooAi9cDFcXG6UrJ0fzjKxMpsw5pX5nM81WY9pJJgPqs5g934HTrW3cF+eqOR/01dlyDSx2N4B9imVyEktDlIisMMJINXlgPrsbMMUh/jL91xqaHZkZHQ9kJIjbrGZhIqHxOlo+WnnRTbsta+czzNTMJZaQR646mQmtJM2MTTOCw6b/8e4uWwphrawKD4PXI4mB6auC0BToFDjBboHO3BqRBXSObtLVOb9ua2nEpGkVAXWWoDkJ79ExlknMieUqO16NwsrOTOxTSudkxB1lo3x7LJiY0c++tt4N+YfFYXsyH6NU1BBAGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5wv5gTtYngq8r+lkdq8I7xNA3WLtimDEkxlXfbMVFI=;
 b=L10cDYHqzQToP088ByVU+nE/jBEN0Plt6LAK/UuTi/LAPaNxh0K9uXQUpBFRfOQal6Xr0BaEmRW3KsStpZNnx+Cuz8OFtB/r37awkFQogvt/fhzZ7FZdul5EJAb/tmzcubv5VY9gGqbTsNojwxPRTVTlEyLpZewFtsTkRiqTUQ4kjdI+dnUjrMqBrK9YHqrQwOQc9V/b+mm7FUUbq3m0A/Q9q/pMgWPyEAIFjlFLa1wpbIboRf7T+oprA9KzaAAMqdWRHGvKGu9ryzoK+YtMNJq/g71NVm7Omjqbs8z4XEqh8Er3akLbWMloKDwsDQUiF/UQbGaxG+15ZdGIRKIIwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB6750.namprd11.prod.outlook.com (2603:10b6:806:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Fri, 12 May
 2023 15:23:29 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 15:23:29 +0000
Message-ID: <eb50d813-ea48-80f8-53aa-846aae33cf13@intel.com>
Date:   Fri, 12 May 2023 08:23:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [PATCH v1 2/9] x86/resctrl: Hold a spinlock in __rmid_read() on
 AMD
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stephane Eranian <eranian@google.com>,
        James Morse <james.morse@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20230421141723.2405942-1-peternewman@google.com>
 <20230421141723.2405942-3-peternewman@google.com>
 <242db225-8ddc-968e-a754-6aaefd1b7da9@intel.com>
 <CALPaoCg1Z4ucYibv4STe+DjB32o-ckuWm5PL4CmWwCgNWchoUg@mail.gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCg1Z4ucYibv4STe+DjB32o-ckuWm5PL4CmWwCgNWchoUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: d8e59b6a-2728-4425-f209-08db52fcd68e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JEOCA7jGGTwU18ZFgt8+lSF4NDvnRPl7V8UZoRx2ZMuK7H4g1EGF2MIn+Rb/tGGoY1D88jRiz26eZT0ugl5/kHp5O9jtFtnJEMXRv8Nz/Kgb4896uy3XQ+udH91V1et8XATeZcQVqdjdznYGyUW2x6t7o0CQIVUEWExo7sRPHXL1ORZwucPJ+v4vIrvDWhHxQq3Rmr9NO1LvjIZQ+XvZxB+tvuVazjJxk/fQCgsl+2/i4Im48rtzh1CaEE+GLxnetfmppPIEDUElUoPs6YM96dOiiXaqmXi7HDB8aLK3I9UmBC/1y6gqHbFmLJ6+FYyy3RmfMmVGFegbSVc/2xlWUU63tc3XKY8r3e+K9b9MRrPWcxHE1llC2YBpQ8BKHTTzc/WjRZigWcgI0QVMrM0HEp2RlzNDZFtdsK1JVHNIBIEFKkziER675wEGIkRBLqNTfwuGhHmCHwQk3BFC793WyeO+Hfae2gw6+UEt6uUXHk5Up+6ggULLl+nW4VyPNzFZoxwccl6895Wql7ESAOLRidzPfkQUaVcfm+JU+aR2xgJnRCcl30eaEWPCPS4eazD+OAIcbZ8gWusjP7sHw1M7zweNoxpFlW6AF8fK0y1zbdhhXodU9GcAiOs0QZoyk4dsz7EPL83WrLwBTA27Xp4DBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199021)(54906003)(478600001)(6916009)(2906002)(66946007)(66476007)(66556008)(186003)(316002)(41300700001)(31686004)(6666004)(4326008)(8936002)(8676002)(5660300002)(44832011)(7416002)(6506007)(6512007)(26005)(53546011)(2616005)(6486002)(83380400001)(82960400001)(38100700002)(86362001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1lJZTJ1eDFGODNkRjRldGlMSmhFMnhBUEMyMjBpK1dMYU1oYU40bXJIN1M5?=
 =?utf-8?B?bFZNVUQ3WGxWTko3SlF3cGYwRzZUT1FPajFiSFVLNDJkNW4zbWIzbnIvdDFl?=
 =?utf-8?B?NVZZeTRTM1B2VUt1ajhUYmUxSGpidGVsQ3h0N3hvMnRuUm5SdUt4YzBML3lx?=
 =?utf-8?B?N2pXaGt0L3ZIV2FDZHgrcEN4YU9ZNWZhYyttQUkyakdYVzN0MWRQazBjQnJl?=
 =?utf-8?B?ZG9lRWNSL0ZHbDY3UG02SjZvVTBhR0Rzd3NzeThDcXJvSjN1UUY0ZHdGQzk2?=
 =?utf-8?B?SVF3TU1YRXhUN0VMdTVIRklIS2lNM3g4N3loNllQV3BNSmZVWFJlVzBlM1c5?=
 =?utf-8?B?SFZSWWl1cnRNU1hHNy96UVNzakNSNUFlU2k2aVl5MTFhaGp6YWJrVHUzem4y?=
 =?utf-8?B?ZThPMzUxS1dGNVpSK1ZuVGt1M0J5YzI5enNRY1EvdEFxUER6U3hkQ2pDaEhn?=
 =?utf-8?B?WmMrUHE0WUp6d1Zpd3RlY0laVGpBT3MwV042R3BNWWxFYUlKb1ZHamZtdmhN?=
 =?utf-8?B?TUhzYWtxbVRvdm1TUzZZY3lyTDlmQ3FmVWR5YmMzZGJ0NWI2Q0tWenRJWHRI?=
 =?utf-8?B?Qk1jUVRyRG8vTkxaWXBwUk5PcXJyN0xyR2hsUVBKZ0ZhTzBvOElkTlpJSG05?=
 =?utf-8?B?NEJoejY3L05zcmVaYWdueDBJOTFLSHAwc3A1dEExbEVzNnpBcDFtSThzWVgz?=
 =?utf-8?B?MUdhb09qQUpmdWN6ZmJkYU40V1lDTlJ3NTJzZVFMTGc0ZHV5VEMwRHNGdHFN?=
 =?utf-8?B?bHNrb013WjlKckRRN25UT091MzFsRWRIcG9YdkpUWENZdVpvcVcrRU1UNzFK?=
 =?utf-8?B?ODZRelpIZGY5OTc3bEVaSWlYMisxUGlZblpGYzFlcDM5ZmhudjJLTE1jZWV2?=
 =?utf-8?B?VXpuaXpXV0pHbTFPeC9VdWdUc1FEUDhwTjlUZmNZRnE0dEZhNklPRUM3NmZI?=
 =?utf-8?B?T2NqRGZLTUFUekY2dndtRllIZlFRc3ArV091ODZtMDVkcFZqZll2c3lFUmhG?=
 =?utf-8?B?T2l5TnFIckVDUGIxOGpZL2R1Qk5JQ3FZaXFWZmIyMEJ0UXVzZkd3WVRCU0g0?=
 =?utf-8?B?VG15eklyV2xHWXl4ejJPNXAwa1dVMWxGMUdTbms0VU81S2JCR3hMYVJaZW50?=
 =?utf-8?B?OFVRNExsVnZiTzN4OU5JUkdtMnVNaUgrRUczTDNKbEEvTUh3VWkvL3dYSkdX?=
 =?utf-8?B?S3EzaHpGZGRMM3h4Y1k2RmRORjEvaDVoRlZnd0k1eEJkY0NEcDVOMDJ1MzYv?=
 =?utf-8?B?VnRxOVNaTmFNTmZhSkgxc2RjNkl2MUx4RzRHTVViTFFpQzg2UkVtcFl5RTZD?=
 =?utf-8?B?eGw5b3RIcFhWeUxxNEhkdHF4NVhKRElnbS9JTVFiYVIyVHBORFA5aFJ3b0tX?=
 =?utf-8?B?bDVvQlh2cFlVd0ErTzlnL3d2U0w0RFRMNU1XSFhEaEtHamZRM2hhM0x4VFFk?=
 =?utf-8?B?SVZDTXYzM2lCWUJvS3hBeS9FMGNydURvKzl3eDgyUGUzOGxLdFZ0TitTajNs?=
 =?utf-8?B?ZVg4aExGdW1hcUl1ejRTMDIvNFVYSEpIaUxiU1BudHNhbXBGK0ZXZXlGbW9O?=
 =?utf-8?B?QjkvcVlxdVVtbzY4SmM3eDUzR1FmSElIenpHOG1RV2haY1dnOWtET0Y3VVl4?=
 =?utf-8?B?MzU5YXd6TVdMQU82clBvcCtrdDJncHpURk1Ja0NuNFNjWUVGQUhGTWg4WVFy?=
 =?utf-8?B?M205bERqbG9IdHBVcTBmZXgwK3RxOHp5UWhHdFBldXd3RUl0NEpBNjlxVFgx?=
 =?utf-8?B?dHp4ZS93RnB1aWN6WGVqeFZkZTc1Y2hTS3dHOUtCRUNGY0FoMnNaSER4UUZI?=
 =?utf-8?B?UExmdzVWUVpDc0hjV3NPeG1KaVdTZGcwM01WY1dOQit3eldQcUtVeVdsNHhk?=
 =?utf-8?B?dFBzRzBYMGRWcW1VT0RGZ3VoMDl4eXFDYjdWVVNYa1J0S09aOG1qZ1N5Zm0v?=
 =?utf-8?B?cGpETzhiTjEvYnNpY2JjRThDRCtsTVdGTVJyck40VWJoK25QdmJZelE0dGEv?=
 =?utf-8?B?RmdKNEpGbGdSTE5QVGUxdTZkV2NIbUwyWHExREJzc3lSSHByRVdBc3FwbXZR?=
 =?utf-8?B?SVJINXFlMzl6Q01qUCt4Q1hzT3RtMXdCV2JvNGZqZVZJOGFEUmQ3eUNndjly?=
 =?utf-8?B?aU5DR3pGQTlXcjVoNjFYUzg5cmdSR0EzVmhwdGlOb2RSVzRLSzEzdldEZzhW?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e59b6a-2728-4425-f209-08db52fcd68e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 15:23:28.9590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: unSHp3c38XbYYOh+wzMwxyLqLC6T/i/V093atJkQV9gfl6S1sfCPqCgAWeNac3VPeAaL5ZLfvUu6ipt+JD2/fJjurFx/YxFMa9FIxHk1C+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6750
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Peter,

On 5/12/2023 6:23 AM, Peter Newman wrote:
> Hi Reinette,
> 
> On Thu, May 11, 2023 at 11:36 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>> On 4/21/2023 7:17 AM, Peter Newman wrote:

>>> +             raw_spin_lock_irqsave(&hw_dom->evtsel_lock, flags);
>>> +
>>>       /*
>>>        * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is configured
>>>        * with a valid event code for supported resource type and the bits
>>> @@ -161,6 +166,9 @@ static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
>>>       wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
>>>       rdmsrl(MSR_IA32_QM_CTR, msr_val);
>>>
>>> +     if (static_branch_likely(&rmid_read_locked))
>>> +             raw_spin_unlock_irqrestore(&hw_dom->evtsel_lock, flags);
>>> +
>>
>> If the first "if (static_branch_likely(&rmid_read_locked))" was taken then the second
>> if branch _has_ to be taken. It should not be optional to release a lock if it was taken. I
>> think it would be more robust if a single test of the static key decides whether the
>> spinlock should be used.
> 
> Is the concern that the branch value could change concurrently and
> result in a deadlock?

Possibly ... it may be that the static key cannot change value during
this call but that thus requires deeper understanding of various flows
for this logic to be trusted. I think this should be explicit: if a lock
is taken then releasing it should not be optional at all.

> I'm curious as to whether this case is performance critical enough to
> justify using a static branch. It's clear that we should be using them
> in the context switch path, but I'm confused about other places
> they're used when there are also memory flags.

Alternatively, there could be a, (for example) __rmid_read_lock() that
is called from context switch and it always takes a spin lock.

Reinette
