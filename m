Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19596505C37
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Apr 2022 18:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345960AbiDRQHW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Apr 2022 12:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345894AbiDRQHV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Apr 2022 12:07:21 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B25213D61;
        Mon, 18 Apr 2022 09:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650297882; x=1681833882;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5TF+BaHf3TRFGk7/Z1ugmyEygI1lUVTHqvCrXMVXpIs=;
  b=a3gMHgu+3QEGAZe6RO1lucHO+s4pxsbIq52zA+2iR8x4WiOpW7SVEYk2
   G3ncZ/X5CuSEu26YONJZ5MgNaG7OJVWvy44tggSpOncLciSKq0atawyhS
   6iNb0tJz6EujBE2CIsqXfz+TlMKJ4/1Y9eMeiTEW/NQYKFpDCj7nkX8Kn
   s7yJjY77/V12/34Z6kRYJCHgZGR/v9qcQ4uSvf/upiGIFkgMhbOTjGbGk
   Qu8BbqtJs1QZc7d1V36WGL/YFw3mnvd/99U9QwSHgn/ppdcWqfbYiG3rV
   Wc8qkz8MF7XcXIbA71phwoQcNhB3WOYE352AaXqCtoF4eSiHTrt7pUJwX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="244134890"
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="244134890"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 09:04:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="529614929"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga002.jf.intel.com with ESMTP; 18 Apr 2022 09:04:41 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 18 Apr 2022 09:04:40 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 18 Apr 2022 09:04:40 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 18 Apr 2022 09:04:40 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 18 Apr 2022 09:04:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqUPJEsvRnjMoCD1PezhXbXqJCMPFaYEY3tvhfknm7RZCj8WaAg2wgmcm8LS801ApGYLI2uJOa15C3x8EzZzCIVsf+GhmxHo/MacoFIItcLbueyUX9Ns5/drEV2JOXptTex0HvtXDKb8wdmM2mW30YBv92KpxIsIEgmV4mOUPR0R1kXOtY1oBxCb28h0TSPKidB2hzBCzQGTtLCA5lI2f1fzc5riuKUd73rNRv+yOvpA3nNN0YcULpK34jL+/uHH80yYJTHMpUPDj/BKUMBwH/nMJtEERHpWDIG2hXth4A5Z6WUBR7Tz83mR5aTD5QU1Uth/w0wmS5P8U+X+aIC4ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHy5kyyD6u9KoETv/28/DWf1B81ExfMVwrWzl09uWxU=;
 b=dIhWwdFg/Eq66W7m98YSxH8UHGISAGkxSyeuGf7WWslQfBRbkZLZG4xCZVcKe1PiDd9ye+bFjMA1CUZzzYuViL0k/2Cmgr84T2HLtTIg0LQG8NApLbKZNh3aQLONIgH3pCHUjSDDFcZYi9GLU7ypGdTVnlom2qYe9p8yQoeAn1eLWkfHHqV3jjPgfolQ3PKV4bJGDQ1izzI+X2WkAc2QcvU6u4UfQUmqkBL+HJYrdgmFTv6c9fO2GGU9nhg+Ne3VXgNU8FTC94jRLqI6bMFhqBI9O8IKXl06ZZ876FYnIf9g0PK+68MNwUVenoDTPFLX+SAABMkZ49H6WVEfp5MiDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by SN6PR11MB3534.namprd11.prod.outlook.com (2603:10b6:805:d0::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 16:04:37 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36%2]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 16:04:37 +0000
Message-ID: <50067c2d-5563-7d8c-f992-5fef787d4d38@intel.com>
Date:   Mon, 18 Apr 2022 09:04:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.0
Subject: Re: [PATCH V2 1/4] selftests: Provide local define of __cpuid_count()
Content-Language: en-US
To:     Pengfei Xu <pengfei.xu@intel.com>
CC:     <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <sandipan@linux.ibm.com>, <fweimer@redhat.com>,
        <desnesn@linux.vnet.ibm.com>, <mingo@kernel.org>,
        <bauerman@linux.ibm.com>, <mpe@ellerman.id.au>,
        <msuchanek@suse.de>, <linux-mm@kvack.org>,
        <chang.seok.bae@intel.com>, <bp@suse.de>, <tglx@linutronix.de>,
        <hpa@zytor.com>, <x86@kernel.org>, <luto@kernel.org>,
        <heng.su@intel.com>
References: <cover.1647360971.git.reinette.chatre@intel.com>
 <7c49dbfe5bab04389ed84c516fcbfe31d66df880.1647360971.git.reinette.chatre@intel.com>
 <Ylp1oFenjgxWpM0D@xpf.sh.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Ylp1oFenjgxWpM0D@xpf.sh.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::21) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 759a6f79-9921-4601-4670-08da2155234d
X-MS-TrafficTypeDiagnostic: SN6PR11MB3534:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR11MB3534F1C533B17494812D0472F8F39@SN6PR11MB3534.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h6i3z7msznTtjqyDpgXw9HClxJQO4vk+XSKMSMxoTIWLpBSiWs2LCg5oPxfkSWXjPAUZQZ2sSS1KpIyWoeitH9a3LxL+uZ1KPRBOWAISK+mqLAZuAMBjgBWBNIzKu6Qy4nCbjMFufLO3xX/voURQMO1luMEGemEl2Zk5NIy869Q4IxbiUWTrcmSZ/YyzEUBQWPOG1Cbt+jx05S0w7IHtYK2I2tvDR2us9ZKF1Yrj4e6OT7rRtPdSKU7gMvgXIINI5vJPCN09fsQnmpg29DvbUmJwyjf3CyoT6SK307saj+GS2NmXdIyBO3GzSZYFYIt60TdDZ1qOc//czI4RqxXefD2BCJg8nP+mdD6qGBb1OCP3SlPaIEcBC/17x1qWsorw2RdR+VnHwWHaNVyWUUbnPSKluDWQirVE3MuEXfNgacP1NgbZC1R6fJgJVzJ5hEnFWqhIjjNhtYn+eVsR8MlS+DPxQHKtE/URS3RK8XaX2gP9bVUYe+7rz3Mpv0Y9E8I1j+wrlRucqNOKaH1mbTMoUalCfIFtpSkJR0mbaCvYNpuwnCMcnBLtfifolHhtyLNgkvk4QhLsAZAMBYlvc42hZz1SEU6tbcPUnlk5r2lkHmNN8W8gKXpS8JkJ89B0fdbhU+hhuYttHMFTTuWVYz+k1uPzx5gx6mU0mGdthsR0fHubwKG7cXRvZxF0D+2fDAfxxbX81SHTmjSEwQSIeun0MJwICc8yCk44FLbEdaEGbFmQLXLaOQhqgvBcOYe4TU2IKXULH+59HpQMenjhYRkkxdla7uhou7kR8xd3Jjz88ewOvb9jK10GkBe7m9cIMDVDgti1MohNiR2vBAVIhStOrZ1gnjpUjLZtXNa8VdVGNy0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(2616005)(53546011)(6862004)(8676002)(966005)(6486002)(5660300002)(316002)(8936002)(6512007)(66946007)(66556008)(66476007)(6506007)(4326008)(31686004)(44832011)(82960400001)(508600001)(36756003)(31696002)(86362001)(38100700002)(26005)(186003)(37006003)(7416002)(6636002)(83380400001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dThvVTlKQzRBSDNKNVV4bDVML0ZoaU1TYklsc0FZN29oQ0lKQWtGRW5rbGZl?=
 =?utf-8?B?TTRNSzY1ejRSUXBuR3VaUUNrSG9OcTl4Y1F4aW5ITmdXS2s1d2M1UGxDSU5j?=
 =?utf-8?B?VDlmQjdhTHBJNDNwUU40cVVyRTVPQkxqSlY3elpXOFdTTXlwYnVCeTA0aEM4?=
 =?utf-8?B?Z2N6Q05DeUt4UnZCK3dTTjYwc2g0a0lKSzRtWjRabGMvNDh3Nzh0c2R5T0xO?=
 =?utf-8?B?UUM2RU5FblloUXN5UTNSSFkyd0pxY2dDMmFSTXJZQTJoQVM5M1hlaUpTT08w?=
 =?utf-8?B?ek1SYkdoZ2o5N2tZV2ptYXlzRW1RZldSdUJNL1k2UGJ0MGx5dTRmYWdiR3FK?=
 =?utf-8?B?ZEg3dVV6QTh0cm4rZG5YeGFuTXo5SVRkd0d2Z2s0d296WFdUUHNveWphS01r?=
 =?utf-8?B?akIwMkcrcFRHaGN2d2x3djFlc1pPbllTK3crV3NRZlh0TUtIZlBmRTNCVkdt?=
 =?utf-8?B?OXFJVVdxYngxekZaSWdFOXZycFgwYXFhbHJKYXQyV0ZlMlFOd0J2aUpXL1h0?=
 =?utf-8?B?aFUxK20xY0ZjTmJ3QXFBL0QyMVpncWlOMFcveWNmcnZEdTY5TUZlUXJTeDRU?=
 =?utf-8?B?SE85WVkrdm9tdHpkRHQ0ZnZwNE9oSjdseDlSZ0JseGFwRE9IWVlVMFQyUkIw?=
 =?utf-8?B?UnEra3JPLzNmV3BHUVRuNDhrZGk1ODFQRkUwdkc3bUVrV09SUmg2dW4xTEo3?=
 =?utf-8?B?cmMyMkttT2NybklnbXJRUGwwd3pBNW1GenVBSk15UlExQ1d4eHRxSEtxTmY1?=
 =?utf-8?B?b09FTlprUENVRnJSdkNwRGpxajJIOGVlQzNBNXVYWnk4dy9hNk8zb2hMRUxm?=
 =?utf-8?B?akZNekhRYWFRekdpOCtHTnpjVkk1WnEzZW5IU1gvSWY1MU1hNlo3Vlg0UVhM?=
 =?utf-8?B?eUt0R0ZWWnBCcjV1VlFxM3lSUExsZk1DYlU2dVRLb2I5bjA5WjJIRUhIUUZP?=
 =?utf-8?B?bUhGOHhkV1hxOXhPOVhxVSt1Ulg2UmxXVHlhOWFJU0NKK1g5TUg5Q1Rlb0h3?=
 =?utf-8?B?SDFUZHJDRHgvdmJvUmFDQmx1MUszdEpvQkdacU95RFd2SlRSUzVnaVF2cnJh?=
 =?utf-8?B?SDZ5RXpjWTVzS29SRFpRM0lJRmc0bE9GdDlGdjRqYStoclUvZ1pzbkkyRHp3?=
 =?utf-8?B?dmVxR0p6T3VkeUpOYXBDK2kwRDFUdmJreStDL1JWQVczTkpGSHZwS1E0S29R?=
 =?utf-8?B?ZFROWjAzVlNnYm4rSEt5UnpzUTFFQVcrSTRJZEJPVjV4bmFucU1pSWNVakVK?=
 =?utf-8?B?angrZ1N3aThBWjE4KzFKMHRZOHNXNFRlSTJqMU1WQWxzWDBPVE42Zms2TXN5?=
 =?utf-8?B?L2E0dm1leEVkNXU5Q0ZVdGxESDNKcEpiNEs2RUVETTZnbXNCM1hqdWthbXlj?=
 =?utf-8?B?aGJVTjlUazNnVkV4UmNuRmFlN0ZGVlJMOVFtTTdNYldqNUZZL3JXRW1LTVli?=
 =?utf-8?B?Tzk0TFVISnFBN3NZRmJISXMrQVAzVkIwUFRlRFdtbWJ1LzlFZ3dSYWd5Z2lt?=
 =?utf-8?B?QTE3U241UkxYQ3poSEVoWVI2M0Z2OEJLcUtmM1NhWFNNR3NKSzYraEsyazVZ?=
 =?utf-8?B?cE1TVHZzeVBDOXZnVGk1OVVOT0NNalM0ZGkzZkVORVNzVTZJdmRyZ0ltVEl3?=
 =?utf-8?B?SWUvSGZnYnVlai9iRzgxQy9xbXV0M09kdHJ4cTVNdDBRUUJMbExmaTFzNkZE?=
 =?utf-8?B?cFJrUzUvNVNWaFBOZktseCtTTXROY0RwOGxBRXJNdk9aSHo3eHBUMHlkR3FM?=
 =?utf-8?B?RnZjM3FLRWhrMHh4UzgweHRnTE5KQjlUMXRvNnpxaDd4eW04dkhTSnNiN2U4?=
 =?utf-8?B?NUJ6V0E0QXdYQ2lHcEFOY1dVZmhpbjIzYUNvYzBSQThpT0hrVDQ4T0RDazhH?=
 =?utf-8?B?VW1qTVJmaEg4RmlUMGFSOFBIUWIrV3VmNFRXdmJsc2l4Ri95Wk4rNUJXSnUw?=
 =?utf-8?B?MEczVzRjTjNNU2Q5WDczU2tqNFNxVGE2MEdRUm5QODkyZFJNYjNVdFREK2Mr?=
 =?utf-8?B?anBJR3VNc2IzU3czaGhSTUpsWHZldU5XK2d6azQwUFBHSjZGdmhjNS9Ga0tX?=
 =?utf-8?B?OWlqN1k3ZDVnemo5WXVrQVh5MlhyN0EvcWNPdE14ZTBWSU5jTkREckJOc0lG?=
 =?utf-8?B?YjlqNC9ZcC9mcHhod3BaajdTV1U4ZCtoRG1lS2hMbEY2M1VxTXprSVZGOVA1?=
 =?utf-8?B?QlJNN2NUb0xLSzNrcHQvNFp5a1hnV25YTkdZcVdUSXZpSFEvZUdHd21JMCtl?=
 =?utf-8?B?UTVBTHRlM1hERlprM3hheUgyZkJETVM3WkVmUm9oZFVXQVVvL2VkWEgrNitF?=
 =?utf-8?B?RG9hQzBzOVFVMmNGVlBUSmhRaS9VOGRLbVJ6eTQ3Q3Jod1VmN21oM0RVQWZw?=
 =?utf-8?Q?hR8DSgcX8ojaNw0I=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 759a6f79-9921-4601-4670-08da2155234d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 16:04:37.7205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YcozN6qO6Pm+/LWK6iHPqoef44pZ/3Kg5Q2cD4iJccuxnzNGqugT85inkXeCzML1NpxgYh7TXENId0r1gHTCrOX9dCLB5blzInwuI+atnIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3534
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Pengfei,

On 4/16/2022 12:52 AM, Pengfei Xu wrote:
> On 2022-03-15 at 09:44:25 -0700, Reinette Chatre wrote:
>> Some selftests depend on information provided by the CPUID instruction.
>> To support this dependency the selftests implement private wrappers for
>> CPUID.
>>
>> Duplication of the CPUID wrappers should be avoided.
>>
>> Both gcc and clang/LLVM provide __cpuid_count() macros but neither
>> the macro nor its header file are available in all the compiler
>> versions that need to be supported by the selftests. __cpuid_count()
>> as provided by gcc is available starting with gcc v4.4, so it is
>> not available if the latest tests need to be run in all the
>> environments required to support kernels v4.9 and v4.14 that
>> have the minimal required gcc v3.2.
>>
>> Provide a centrally defined macro for __cpuid_count() to help
>> eliminate the duplicate CPUID wrappers while continuing to
>> compile in older environments.
>>
>> Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>> ---
>> Note to maintainers:
>> - Macro is identical to the one provided by gcc, but not liked by
>>   checkpatch.pl with message "Macros with complex values should
>>   be enclosed in parentheses". Similar style is used in kernel,
>>   for example in arch/x86/kernel/fpu/xstate.h.
>>
>>  tools/testing/selftests/kselftest.h | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
>> index f1180987492c..898d7b2fac6c 100644
>> --- a/tools/testing/selftests/kselftest.h
>> +++ b/tools/testing/selftests/kselftest.h
>> @@ -52,6 +52,21 @@
>> + * have __cpuid_count().
>> + */
>> +#ifndef __cpuid_count
>> +#define __cpuid_count(level, count, a, b, c, d)				\
>> +	__asm__ __volatile__ ("cpuid\n\t"				\
>> +			      : "=a" (a), "=b" (b), "=c" (c), "=d" (d)	\
>> +			      : "0" (level), "2" (count))
>> +#endif
>    Linux C check tool "scripts/checkpatch.pl" shows an error:
> "
> ERROR: Macros with complex values should be enclosed in parentheses

I encountered this also and that is why this patch contains the "Note to
maintainers" above. It is not clear to me whether you considered the note
since your response does not acknowledge it.

> ...
> +#define __cpuid_count(level, count, a, b, c, d)                        \
> +       __asm__ __volatile__ ("cpuid\n\t"                               \
> +                             : "=a" (a), "=b" (b), "=c" (c), "=d" (d)  \
> +                             : "0" (level), "2" (count))
> "
> Googling:
> https://www.google.com/search?q=Macros+with+complex+values+should+be+enclosed+in+parentheses&rlz=1C1GCEB_enUS884US884&oq=Macros+with+complex+values+should+be+enclosed+in+parentheses&aqs=chrome.0.69i59j0i5i30l2.313j0j7&sourceid=chrome&ie=UTF-8
> -> https://stackoverflow.com/questions/8142280/why-do-we-need-parentheses-around-block-macro

More information available in
https://gcc.gnu.org/onlinedocs/gcc/Statement-Exprs.html#Statement-Exprs
but from what I understand it does not apply to this macro. Even so, I do
not know what checkpatch.pl uses to determine that this is a "Macro with
complex values".

> 
> Could we fix it as follow, shall we?
> "
> #ifndef __cpuid_count
> #define __cpuid_count(level, count, a, b, c, d) ({			\
> 	__asm__ __volatile__ ("cpuid\n\t"				\
> 			      : "=a" (a), "=b" (b), "=c" (c), "=d" (d)	\
> 			      : "0" (level), "2" (count))		\
> })
> #endif
> "

Sure, I can do so.

Reinette
