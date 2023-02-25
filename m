Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B14E6A2699
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Feb 2023 02:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjBYBju (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 20:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjBYBjt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 20:39:49 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22912E0E4;
        Fri, 24 Feb 2023 17:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677289161; x=1708825161;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r2l7qtoalCHhy58phj2c8uZKWVpGdo+1MSNBP2a+Uf4=;
  b=g1ARXoMiqeWxqjVy2Clwk6PquOZykTYed/9G+iDWDy9akpM5xHdBmlrp
   jruZeO2Yfhlm2Vgn6bHNRGFY61iPB0YS0OyoLX6WuQX0AMlOXsgc6OQDI
   MnL948LAfgKwX8X2HrZwYaIYQmI1cjqlC/0JCLk/M+16VsPky4f9fX+Tn
   ypQH725uV1fgvWIoI29yjC2vhumHwB/lPeAhRPyPShoW4dkJvRPFGuv2X
   TW/08ejMtJOf/FJ2i1WuWpLsQRFK/XlTtT/MmpxYxP31EwYid1irGdogX
   W2hjUK43inPOzjGCwSCYiRK2xdCMIi8/1Ff29sF3cmuYwBP/hiRboz0ES
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="396130331"
X-IronPort-AV: E=Sophos;i="5.97,326,1669104000"; 
   d="scan'208";a="396130331"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 17:39:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="650537430"
X-IronPort-AV: E=Sophos;i="5.97,326,1669104000"; 
   d="scan'208";a="650537430"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 24 Feb 2023 17:39:21 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 24 Feb 2023 17:39:20 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 24 Feb 2023 17:39:20 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 24 Feb 2023 17:39:20 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 24 Feb 2023 17:39:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVdk8aDDbaCYcYtn71pypvnNEPyDzjjL9XEGqjAM2INs0SbfkjAzfpc1VVrrCe/9CnD0QQ3nkCB3WP7im7mgxE2A2LUZoYHepQAiZRjgAh+zPQv1V0Q+fLNpaYA0ta+837ywgSp8hV+pniE2/exIW2epvo9qONvioDyXEPUFtdk2r1vme4YmAsPsFSQl8d6XNo5BxjfhGRr280fpEbgYLud/MHhuU1gYp2uu51Dqy8S1O867L2ZDIT4//OWRpGCh0YD+j5HTdHsnKsSIrmafXhB8JZ15FzAGFFC8uK2BHsuCficSyz5lpH/sryTJxNlokpFcO7BKu+7QovQ36NKWMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=259YRmvrEgOo/h2IjjMZB3ADAsrDhCtP+s+5Rtcpy/0=;
 b=TCZWRx4BZi7e1HHCOdnKBHsxsIBoDicurCznhY7clNfY5y9e/u/GcCWRrXNUyKcaVpwL7QdKekCv4EzOL2q2vx+LQ6uPs2QM6hu7XqFgzErRWu/poI5nW0/bnrpGLX8uI6wDA60BdQLlVtpYM4n6pvh+rOeHUYJEQ0UITOtYAolJGuepNurkd8788OU60vqNtsXKDnMDw5N36erZRTB+X7aX6X0895Qt/Z8vhndZFLsz5YcE7t0ek/oEpH7LSsnmQUZseuHR+BjTKJyAJj+ADSvo2Xu+Hd8D1rBkYVdV+js+y8amgMRgzGyHvy1H89ZKkqfRPksWirgIMrkBqeH56w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by CY8PR11MB7171.namprd11.prod.outlook.com (2603:10b6:930:92::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Sat, 25 Feb
 2023 01:39:17 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::f8d2:a65:2549:e36e]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::f8d2:a65:2549:e36e%3]) with mapi id 15.20.6134.025; Sat, 25 Feb 2023
 01:39:17 +0000
Message-ID: <701ef9e9-4f0d-d19f-eb08-b1b7cca520e6@intel.com>
Date:   Fri, 24 Feb 2023 17:39:08 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 01/13] x86/fpu/xstate: Avoid getting xstate address of
 init_fpstate if fpstate contains the component
Content-Language: en-US
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
 <691106c3-b339-578b-6e43-77f737f127f9@intel.com>
 <Y/lfxHXVdqeFadGD@google.com>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <Y/lfxHXVdqeFadGD@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::45) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|CY8PR11MB7171:EE_
X-MS-Office365-Filtering-Correlation-Id: 627e1a37-4cb5-4388-45ab-08db16d11b5d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3EVtoxUwHS+70CqQCAscyZZpGXGkZRLXUDtdzRh0qsuB1SnMd0N/TMaFg5iWzUejVW9gQyo9zqsz4MUqMUoZF642D79Iu5jlYlu3+caEojGvMSc7DxfZwS4if2uzzpoO/8zVw9WyKKI9jpUqCBJ7Vg7hMO/6XN96NV994aWoAf7PICNeksfME99BEZGGAOrjx3oelnTm0shet0o8wDENq+wgGr2dzNDPUD0nvD3AGblf7VAFdqDJdSDq/YbUu/6O7AziZfJQ7jE5wgfWzk0VES020FlEitQV7c/VrRfu31akhPKKX6hFxVcha/v/5JTTN7Vsxjwl2OVQKmWzerNVkvwkFFomY/6nkuX7U0spIZW13FIYzZEBFK+EDltEVIlb3FplMBM3OWg6hy3jY4h0zX7QmEWQtQ/lTU7EpWG3NwHM4qlB6sk24TAgSv+k8xhwdX1XrpGa9WqQu9WL3D9qpPQT/oWOGaWjJNg5/rP6f/MaziJ5uw+3g8E3W8GA8tc9Ofki+OQ8fE/Vpw2QZ3zFGz87lKE8rK200xaA38l+LltHwuVw/Jt1g0vqWYOk/93yn/BuJM0G8w+3/YjmsmWzC63PR6cblfM1ErLE6V1XW5hoN2Mae11TGTHcZVsF7uuvQoswNPzTXuJGAbO0qbc0WBNvygVh+GqJMG9taoz0FhH1J72uUKNbUXzjMNMiOqg7Gi7QjmZ+/MaU79on0ahZKzMbZiifh1Al8kkjUYuklAM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(396003)(366004)(39860400002)(136003)(451199018)(86362001)(31696002)(82960400001)(2906002)(7416002)(38100700002)(31686004)(6486002)(478600001)(53546011)(6512007)(186003)(36756003)(6506007)(66556008)(66476007)(54906003)(83380400001)(41300700001)(26005)(107886003)(4326008)(66946007)(2616005)(6666004)(8936002)(6916009)(8676002)(316002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkZ4d2E0K00xTGdPT25KdmsrbzFzaGlLQUh2ZUVDS1N2R1o3SFdISXcrU1Ro?=
 =?utf-8?B?VDQxRCtZODRyVVp1djM4UnZybjYzWHlWNzV6UHZaby85clRaTk04b3Q0aU5P?=
 =?utf-8?B?MkhKTnR1NU9TOHlvZHpjaHh6citPSDFCQmNVcm1KaWhoZW9ldXBwL3BGdGh3?=
 =?utf-8?B?MmtxM2QzalFjSC9XU1Q5YkVMUjE0REt4ZjJWYTZrRC82cWZPeDlGSEZnSEgv?=
 =?utf-8?B?VXBPRm9xaG5BdituNTk0ZGJLWE9UQ1N0c0YyWmVHcUVjZTJ3WHJRZVh5QXRl?=
 =?utf-8?B?WFB6QkZqYVBPSXJkTk1wSFBJMUQ5NWJEVGg5QlY1MUhrQWoza040aVRNaXZt?=
 =?utf-8?B?ZnZ3ck4yUlZta0puNkhBdTIreExSZzNUU3AvYUp4cTZNY1BXeFJObjByQktE?=
 =?utf-8?B?WkYrTVFtekZNbjZ2alZ5SVlYYlA0RVJIVkxmdnBadEd6aDArMEFqb1p6SDBt?=
 =?utf-8?B?cU9GajlMbkVmT1NvcitpUXI5TlBoNmFraGRSbk9HeFJHVEVNSFpTTGg2dnYv?=
 =?utf-8?B?WmtaWXdXQXlnMFVOU25yM2RQTWt4NkYzc1hWY0grRUVzTTFEVUIzc3FlQ1U3?=
 =?utf-8?B?OHMwV3pxYzZveGhDbzZtM01HTExuWWdBL0JZNFcxSkdub21zRUN4MVBncGRH?=
 =?utf-8?B?cXRXMDRMWjBaRXlGaXI0ZWFMVU5uRlVjQ3JyYWJSQ0F0VVhJU3oxSmhVeWhm?=
 =?utf-8?B?VDEwN3NzT1FWVWhxRndTakR5ampWVXFlQ1VraDB1VnZYYlVpaDBqRUxScFpr?=
 =?utf-8?B?WEo3M3hmSUhCekFPY2JRZldvQThTWTVVWlRWdnkxL0srZzhJREtzT3dVbDFN?=
 =?utf-8?B?bzNkZW4wVmpYaHJSdVo2VUNKSFRnYmVSYjlJdzVNOVpSNkxaL2dSUWkwRjFF?=
 =?utf-8?B?cCt0M2xhZnZPSWp3MXQwK0duaEhVM2crRFpEbWpUcjgxaFQrK09SbzFUbS9O?=
 =?utf-8?B?QWJtNkFPWXFUTTZPNlpEZDFiUEhzcmxueHlBN1REazBJTVJwV1VYQ0c1dHp2?=
 =?utf-8?B?aFBqdFB0ZThLRW5XSHVPREorVFR1VDRnWC8vcldUWkdtRVpTTEhnbys4NGVr?=
 =?utf-8?B?Z2hWdFp6NVFwSHZ1dHVFbnFaTDVIRDN4eWFZekZDUUZrRHB4azNoRHNtQWNk?=
 =?utf-8?B?M3VGSWY4QXc1Z3pCK05RaEs2NjFHU2V5VUVIWVdYRWYwZFpHQXBFSjNCN3hh?=
 =?utf-8?B?bkhrRGVTUndmdXlxSFJZNFhqVVlUdytpQk1DYWVvY1pnL0xjNXFEbXV1QlhH?=
 =?utf-8?B?SjRNSHhzS0hhem1hMUZFbU1EUytIcVN0WEdGOGdwNkk2K0Z4NUE2Z2VDVW41?=
 =?utf-8?B?Q0JQOVpNWHpGeS9jbmwxT2ZFUm1TNVNFODl3eTNJOC95dWsrS2FraGJFTjk2?=
 =?utf-8?B?ZWpsdW0vaFJ2K2Flem9Bek41d2ZSeFFSOHhJeVJqV3VrTk1pT291VHFUd2xL?=
 =?utf-8?B?QzBQeDhKM0ttdEUwbkIzdnRkTjNoYXRGMWFjVUJkdFNlaUdxRGtBY1BiZ1ZZ?=
 =?utf-8?B?WmlmbkFlWkhJK0tnQmV4U3RIdEpPNFFnSzViTzVKS0E3azA2Ym5iVWtiUkYx?=
 =?utf-8?B?bEordDI2RVMydlZqU1dibWZKTHIyZDhYNkZOSEtaSDZtOXU4RUt0VzRLREFx?=
 =?utf-8?B?MFBDWXYzRW9TNzJwNHBOZ2crZG42by9vaWFackhvcGV6aTFLRXdYSU9CN3lN?=
 =?utf-8?B?dEtSbk9yK25ZNFdRRkx4NFJHdzJQMHlPMkU0YWh6ZmVoTDBDY1ZZZGFvakFM?=
 =?utf-8?B?dDg3SlU5a3lzZ1BGWmJCNS94cy9ZbWYwNXJKMEppeGY3SXRtMExGR2JvWndC?=
 =?utf-8?B?UERjOXUzVmlDWVpXNUQvRkY5dnJ3cHRtM0V5dVNQUlZHT1pXR3BNWTI5Mng3?=
 =?utf-8?B?d2hHSmtZRXNnMHJzNVUzenh3K1prSTM1MW5hbmkrUW12VS9McWhzbkpZcHh4?=
 =?utf-8?B?b1dYRGw5SU9FN29JTkQ1ZUhRbUtHc3dNY2d1am85NDQzUzVWL1p6Rnp5ZUdO?=
 =?utf-8?B?aDFvYjA3eXpUMDJ6ZGlaV1RhVDgzMXNaSnJJYnU5d09CUll6Z2dwK0FUQVZE?=
 =?utf-8?B?eVpuYy9Dc1MreC80MTAwZ3J5ai9ZV0s3WGVlenZkOW5Dd25wS0ZqMXB0VHhF?=
 =?utf-8?B?V3JUWGtFY0FnSzRKVFMwenVYR3dSUlRmOVVEOG13TDgzUHRCYXRwU2FNaVlr?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 627e1a37-4cb5-4388-45ab-08db16d11b5d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 01:39:16.8161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tKtNFeUh8GDZj9uHzxJlOlZJx6YgJ1AD+jeuh+in8oEgiOaOIi5m7aez721+GDqPETZxjPM4JMi+/hI+vUMKRKjmIU+d4jMDijuF73suiu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7171
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

On 2/24/2023 5:09 PM, Mingwei Zhang wrote:
> On Fri, Feb 24, 2023, Chang S. Bae wrote:
>> On 2/24/2023 3:56 PM, Mingwei Zhang wrote:
>>> On Wed, Feb 22, 2023, Chang S. Bae wrote:
>>>>
>>>>           /*
>>>> -        * The ptrace buffer is in non-compacted XSAVE format.  In
>>>> -        * non-compacted format disabled features still occupy state space,
>>>> -        * but there is no state to copy from in the compacted
>>>> -        * init_fpstate. The gap tracking will zero these states.
>>>> +        * Indicate which states to copy from fpstate. When not present in
>>>> +        * fpstate, those extended states are either initialized or
>>>> +        * disabled. They are also known to have an all zeros init state.
>>>> +        * Thus, remove them from 'mask' to zero those features in the user
>>>> +        * buffer instead of retrieving them from init_fpstate.
>>>>            */
>>>> -       mask = fpstate->user_xfeatures;
>>>
>>> Do we need to change this line and the comments? I don't see any of
>>> these was relevant to this issue. The original code semantic is to
>>> traverse all user_xfeatures, if it is available in fpstate, copy it from
>>> there; otherwise, copy it from init_fpstate. We do not assume the
>>> component in init_fpstate (but not in fpstate) are all zeros, do we? If
>>> it is safe to assume that, then it might be ok. But at least in this
>>> patch, I want to keep the original semantics as is without the
>>> assumption.
>>
>> Here it has [1]:
>>
>> 	 *
>> 	 * XSAVE could be used, but that would require to reshuffle the
>> 	 * data when XSAVEC/S is available because XSAVEC/S uses xstate
>> 	 * compaction. But doing so is a pointless exercise because most
>> 	 * components have an all zeros init state except for the legacy
>> 	 * ones (FP and SSE). Those can be saved with FXSAVE into the
>> 	 * legacy area. Adding new features requires to ensure that init
>> 	 * state is all zeroes or if not to add the necessary handling
>> 	 * here.
>> 	 */
>> 	fxsave(&init_fpstate.regs.fxsave);
> 
> ah, I see.
>>
>> Thus, init_fpstate has zeros for those extended states. Then, copying from
>> init_fpstate is the same as membuf_zero() by the gap tracking. But, we have
>> two ways to do the same thing here.
>>
>> So I think it works that simply copying the state from fpstate only for
>> those present there, then letting the gap tracking zero out for the rest of
>> the userspace buffer for features that are either disabled or initialized.
>>
>> Then, we can remove accessing init_fpstate in the copy loop and which is the
>> source of the problem. So I think this line change is relevant and also
>> makes the code simple.
>>
>> I guess I'm fine if you don't want to do this. Then, let me follow up with
>> something like this at first. Something like yours could be a fallback
>> option for other good reasons, otherwise.
> 
> hmm. I see. But this is still because of the software implementation.
> What if there is a new hardware component that requires a non-zero init
> state.
> 
> For instance, in the past, we had PKRU component, whose init value is
> 0x555...54. Of course, that is a bad example because now we kick it out
> of the XSAVE/XRSTOR and special handling that, but there is no guarantee
> that in the future we will never need a non-zero init state.

Yeah, then that feature enabling has to update [1] to record the special 
init value there. So one who writes that code has to responsibly check 
what has to be adjusted like for other feature enabling in general.

Now we have established the dynamic states which are also assumed to 
have an all-zeros init state. Anything new state located after that 
should be a dynamic state because of the sigaltstack.

Of course, with that though, I don't know whether we will see anything 
with a non-zero init state in the future or not.

> So, I will send out my fix and let you, Thomas and potentially other
> folks to decide what is the best option. Overall, I get your point.

Let's coordinate this. We shouldn't throw multiple versions at the same 
time. (Let me follow up with you.)

Thanks,
Chang

