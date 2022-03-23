Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EE34E5AA7
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Mar 2022 22:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344905AbiCWV3t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Mar 2022 17:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344908AbiCWV3s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Mar 2022 17:29:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6171151;
        Wed, 23 Mar 2022 14:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648070897; x=1679606897;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=264X2WJ1IGCSXehRcK0L8o4p4u7hhATFqTf0tDnnDJY=;
  b=hPHeFkJLFTxfm4APFSMD/Ic6saQ7nk9Va25e1Zt4iNQa8anV76NmStXe
   FdipA7H3qbjf2OJGG0eCd/+kJYeIMVpGpTNRzt8NV+pheXneyC/2kDO4T
   CkeFzSxNPUBKXdIzf8Vs3KiLXcOj0xfUbbQ1hxbuye3PWXayXOuwYgmNC
   s+l84+5+NNl8LpN2cZUG9vSbp/41tlT/5vAZM6ZunHh+Oas7a5Nypb4v8
   7vIH2B8+qgN1Uu8aO2KvVpCCvq73yb02mICH0PXVgc+5brLtX6CIBnjAh
   cQOnLYEoptNURgUhsYaLGppTLkjSIlqW2rL5JT6Ajlb39baTI23c4PPyx
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="258181172"
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="258181172"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 14:28:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="637623785"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Mar 2022 14:28:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 23 Mar 2022 14:28:15 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 23 Mar 2022 14:28:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 23 Mar 2022 14:28:15 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 23 Mar 2022 14:28:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3IH86TeWQIRX8Sdn7eOupEbcX1dqJLGQDnV2iQAICtxnstu8+SZ8PNuHo/+Jdq+m/LOgbIFe8IMmkZkVHKksCGxDUfj67R6qrlID4/IIbdzWLSH6v97x1WXJS1Q7MtRrCyjgxDUeyjT7+3hkD2BO9c1AMIz/KHJSsxt75TjSmTtEYsZA2rex3QlzZjUFS1+8ALfvl/8iCRsPtjhYj8R1s0I8PatnmGMtkCiWP6hsKcGNmrY7Axj+/XwNRAs+jna2r2B3Evjxd68ULbXH55wO8443bFXFqcZvpm3oDUDDgNF0gZFFxQiTwadixAUHbwRrUpfMk/HduKA55d3GlPMCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7g5hv1jdhIiD6d7taP0A4jlj1euqf3SXvW8BCqnZ6w=;
 b=Ic3wOdf6JgYavr1f3DiVNa0vm4YTVK9YXWyJFo+TNpZYQ46HANp5X1SwhAAGBI9XcawOqg5Cm++DpO7QRpli35UgrMp2Nq04cjvW/eRjBf9eHQ88hO1MsEdxveAAhlNzN+quje3ur6TN2iAmalhfezFaEvmuLh1nU+bzHa/5IcFNydgazbe53I/7rNPZPlV+jVPbgdzaINK/gWd+q89WOzkv/yNEyTqIaSgILP99Fya+1iHGx77ivcoWLTeolsuVoTKy38PF4rxU2/toiGmoqqCTFz2zsGqZF9QPjBFCeZh9DVCUMBT0bXzCzEVlri4LLDj1DJa7zThWs/HSarMauw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by SN6PR11MB3135.namprd11.prod.outlook.com (2603:10b6:805:d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Wed, 23 Mar
 2022 21:28:10 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::8516:e462:e23c:85fb]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::8516:e462:e23c:85fb%6]) with mapi id 15.20.5081.023; Wed, 23 Mar 2022
 21:28:10 +0000
Message-ID: <05bbea3e-93d7-2e74-61ea-7756eeead09d@intel.com>
Date:   Wed, 23 Mar 2022 14:27:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 2/2] selftests/x86/amx: Update the ARCH_REQ_XCOMP_PERM
 test
Content-Language: en-CA
To:     Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <mingo@redhat.com>
CC:     <yang.zhong@intel.com>, <ravi.v.shankar@intel.com>,
        <linux-kselftest@vger.kernel.org>
References: <20220129173647.27981-1-chang.seok.bae@intel.com>
 <20220129173647.27981-3-chang.seok.bae@intel.com> <8735j8aa9g.ffs@tglx>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <8735j8aa9g.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0036.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::11) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 036853a5-4b98-4e08-ff61-08da0d140728
X-MS-TrafficTypeDiagnostic: SN6PR11MB3135:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR11MB313514003ADDD81330293648D8189@SN6PR11MB3135.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gKhBSUHYGhNYFg3LRI7oyIF6rJ4gASziOahbKYMwNoURFF6fbck0CwZatUy8m1YZdaY3dc5lciQUXohltG7C3Xs7iQxDMC3w+/vYDZ2Z42pN7WN4n019JXM92jE0CejBjPswFj5JfIcXXCxssrd7JZrBWNADwJxHtFVHvC28EYSev90/SN+1QJ2NHdPAYjyialHWi5xsjrIutHyra4QPvh/TIp+LM+FN7+24NQeqXTsk1hW7Wuf7qe+WVSc8mWjBSpM7qj19P4JD5sDUutOkCjRivymmAsUKoTbkxS+Q8ylTHRKf7hK7dUnfkUoCQk46aAGb8sFCm6bePYillq//y5sA77b9t55SZamltZTovyVP8iYRu55Bpa5YlcDIXKIEJ2n8YR/qeSfCNlmOQHWYcly7ex2nNlImYv28Vf5BfBPohaudoMRxtgngBpos7zMOw+ziYoOwpXbWn26Feso3nWQtO9NptA+sH8g51fxAVW/kIWtkz8k3X5nrVxkWiNxCGE53/9Hhp5M36DflpagCxqg5Ui7FReSHfb86u9r095FmbblvaaSUP4vtstqYv/0+DOKHWAUGn2TX2C5p902vcJ9eS5kk3aqxMeRDRL09R5KlmVnj3tcX/YqFiFha00ypHC7LH4P2bMFAregOfuXLA3PM9OKSyXGfHcHAzn7GaE6Mb1gwuxETOc+XiWP5AvAZXxGD9nq66xqdNO8i06lp+uuWVjCSuQgPIAwW9FwA5ow=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(2616005)(5660300002)(186003)(26005)(4744005)(8936002)(6506007)(53546011)(2906002)(6512007)(6666004)(82960400001)(83380400001)(86362001)(31696002)(66946007)(66556008)(31686004)(66476007)(36756003)(6486002)(316002)(4326008)(8676002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjJ6RFRlV3M4bXU5QlN6ZU5OMmNiRVNoUmVWYUcwSFExUkdBQzVXQnpCZ0Vn?=
 =?utf-8?B?VklQTTVkNS9ObVhQOU9QckFWTHhCWVVUbm1VUG1YUGlDbFlMNUpZcVJEWG9Q?=
 =?utf-8?B?ZXdiSDlLbXBqOGNQQnA4MGlyUUJ6ZWVnbUZZeUV3b1B3SXNVNlBBS0JXcjA2?=
 =?utf-8?B?a1lmcUQ1dXZDWms5SXZsc2NKcy81SG5mT1E2c05oZ2JYbFVvV2RPcDR2VE8x?=
 =?utf-8?B?d3pTQXVrdFU4Y09SbFVFblNCZnRlbXJZZTM2SDdvMFVuSWlHSzBaTEh6MEgr?=
 =?utf-8?B?VmNrOWVaOEZSNWphRC9nbnZBT3pVMjBFTWNCUURXRUFqYnQzM0tDaTVMVS9V?=
 =?utf-8?B?OGE4Mm9yWCtuOUFsakd3aUlsL1V1OEdSV08xSzNpMDRaNWxvMCtNSGJsbWhV?=
 =?utf-8?B?RmZPdG4vQmgzTmlrQnBncFhEZFo1NGUrL0FDZTk3UStJMjlpdGp0RUdob3Nn?=
 =?utf-8?B?TEFnZGFkdExzOW52K0ZhM1pta0RTWUpsblRPVVpCNUhTMzBEYzgvT0hBNE9X?=
 =?utf-8?B?VXVzK3BNblJ4ajVzc0NpVXFhcmNGMDVtM2lTMzNXb2t5bS9La2h5UHBJUUxH?=
 =?utf-8?B?RytDTGNyWmttTnA0ekl6RzNjY1hrdXkrdmJzN3pkN210U3Vzb2F0MlpBeXla?=
 =?utf-8?B?cG95dmt5TTVSNWpUVEVmNG9KM1czeExUaldkYVkydGpPaW5qR0dlcWxEMWFK?=
 =?utf-8?B?L1g4dFBoOGFGdHh5Q2JmcEVZUEZ3amhwOVdrM3dqa1dZK2Rhc3pjZ3QxTW91?=
 =?utf-8?B?TzQxVWg4SHNYVk45MEJ3bkJPWXlNOXVoYUhxQ2hUejhNMjh3Y3AyMFVmTURO?=
 =?utf-8?B?NnZPVnFTN1NRbjJ4aTdVNndaQzFHdHFzNFNqUU5oWmNRc0pkbjIyM21wdDhn?=
 =?utf-8?B?dHZrdmNXTHNSQnB0VVBSZXd1ejVXNUh5RndiVmNNaFB1emFwbjRYanFuMHhs?=
 =?utf-8?B?TW0zVm5ZNTRMRjhpN3FIQjVvQ3ZRQmUwU3p5OWFjcVY4TVlaWndWNm9ybGMz?=
 =?utf-8?B?OWc0SCtVa0NEVkRkM1lLSkhPdXVOZmkwVjdvMzVyU0RaRVJyUzVjdXFHUXlG?=
 =?utf-8?B?Wit1UTNvSzlWYTM4eDBkaHNmUC9heW15VW1jZGxZZldESUExQk9zU3hpVjBZ?=
 =?utf-8?B?YThkL0RqMWFPRHUzeUY1M1N1VmMwamxPMHo0VTFBTXhHdEFCNHpPM1U4U2p4?=
 =?utf-8?B?UU5UbmVERlV1cVdJWU14Y3kzYTJwNDZ0VGZETENOVk9Na3h6bDg0ZlV5QnE4?=
 =?utf-8?B?T0JDMDExdEJrU3MxK3owLzFkZ2FuRXpqMGJYd25GYXk5cmxoSnZUazlqbzA1?=
 =?utf-8?B?YnoyaG43UkJrZnppdENMcGM1dWtNRjVYM244MzFVTUJqc1M1NFpmNzEvZUIy?=
 =?utf-8?B?OExoOXJjb21FSExsQWYrMUI4TUJ4WkU3RHltc05LTFNVQjJkTFROM2pWSTZ0?=
 =?utf-8?B?TjhGam90K0tWUHVVenRFUUdWNHlSdFhEVW5DWHJIc1BDYk9vcXA4UkRKMGZQ?=
 =?utf-8?B?MkFOM3pIdEIvN3NqbVhYbEMwdENjVWdDVk1mSk5nTUtVZjhXNEVGd1VMTlhP?=
 =?utf-8?B?d29xZDRaanUyYzVvSjNCOWhsQUEzNnY4S1AxUHVHTTJQQmJFK2Y0WHpGczQ3?=
 =?utf-8?B?QmdRT0ZiYVg2eHhzMHZvNFFudmNsN1ozZUpNTWV6eG1GK28reHdqQnNHcTRz?=
 =?utf-8?B?c3Npc0RzOWxlNzJnaTlDOTU3QnQxTzV4dExGZ2lWbSs1TW1UMkFmcXBPbWd2?=
 =?utf-8?B?OVBCM1pjMkVmUmgyOEpMOUJGczZCcnJOelU1YVFMMTJTT1A3ejFIeTVuai9O?=
 =?utf-8?B?czV1dm5zc1Fmcy8rcFFjMXh5dWluNTB5ZzYwN016TXZWRDFXUS90MWpJN0JY?=
 =?utf-8?B?Qm9kT3ZKMVJNYm9UbHUrVzR2L2JFRElyK0ZiejhyMEgwSkswL2RnVU9EYWxt?=
 =?utf-8?B?UVR4djBWbXJQNW0vWDJRODMySFgyTjErKzU1ZUgwQVl0WDh2d0pyUGdYanli?=
 =?utf-8?B?dmVaL1pSaVdBPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 036853a5-4b98-4e08-ff61-08da0d140728
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 21:28:10.0417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zr3hnTw72ksOGX3pZ/G4k9j5MZ3Lbq1pu2IrOjWRe9zTnpnFmsQa7Dy0+NvUgmZ1HmELhZgA2E5GXsO5qMWF0ZrwT1QpH4K8HVJpu4d4dlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3135
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/23/2022 9:44 AM, Thomas Gleixner wrote:
> 
> Running it on a machine which does not have AMX results in:
> 
>   amx_64: [FAIL]	xstate cpuid: invalid tile data size/offset: 0/0: Success
> 
> It's not a failure, really. Selftests are supposed to run on all
> machines and the proper thing to do if a hardware feature is not
> available is to SKIP the test and return 0.

Ah, right. The test should be just *skipped* on non-AMX or even 
non-XSAVE systems.

Will follow up with a separate patch.

Thanks,
Chang
