Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694574ECEDA
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Mar 2022 23:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239954AbiC3Vb0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Mar 2022 17:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiC3VbZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Mar 2022 17:31:25 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3B1201AC;
        Wed, 30 Mar 2022 14:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648675778; x=1680211778;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9eYFznqP329R3Kgw/ih3RraO7g39ZoH9DBXq7MBwBJ8=;
  b=LXouelV1WuKLXYuLCJ3uXAs8aTpByZcB1MyFRGRK6WT2eDYWab/+eIod
   UzF3rpnv7f4RpFTHTHVnuvPYa8qBJVe1Dz/kkGiX3QvtKRZcHCdUa96Te
   pCDhpUxb610WS06zKYc/KNUThDgR5+yuEGunUgXkJgDx/9Iu/lrfi4vgH
   LKK8pCtue2sM7iv5Dy5bkcBFoU68Mnz0UbdmowCupKdMTDEyC3ajgdCCS
   kHlJPpQyvvfFLP+SO+yDamKstb7zpjAHZqf1HRrzuK6FlfMZKTBvIv0FC
   rl7L8yL0pyRoZsa9s8RogqYX8KHDMKyv0G3JV+FE4o3r8x8/SDK9QJ50b
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="239579753"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="239579753"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 14:29:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="838145278"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 30 Mar 2022 14:29:26 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 30 Mar 2022 14:29:26 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 30 Mar 2022 14:29:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 30 Mar 2022 14:29:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKL9MKpKAgy3kEKs5Ipn7QAHKR6Zk6vhvbZGF/pL7ZPRyKk3a44xTsWi9w2/gymH4IDKfQcX6pT5Ec2HNtbZjnD30Npz3cJdVXnpqIBnKB25qU6FFKEO6thYIHlaDnuF92pEpiuMfgXB991eKqtpgeF9Zrk8EY5e3sMBteqSn7cDZdQvMaVjArMDApReL6GtJ+FmhlGtySyj9LkdYR4AlIy33L36tNy94nHKgLA1PNVdJVdPaf2uQ/Uhzu+yHeUB7pQUefmY5Xu+2q8etucQqXX+pBH6dTF7ScH499FxxgW6/wIGhTqVpxbMcMr4fWJJ0EuiTRTV7MkAxZUArF4GZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjKdwJud48zYKUwTIib9stjyWhn6+yIZFkMI4dO36fs=;
 b=c2kXG1rWtl9Vq7HYwgwdpnf1cT7V20nxL49+8ykXNdsPI8nthwt53yN4rs+Hgqz3gURREFjr/jVdKYcyFtQQEOxg0ZlagkvlKQ0HO3U/lPrA8d7n4Mf2BEln6hzrYUfGBJ1qyzXKk1wYhAWI6Xc/xBK3NYyCB9v9mHrntbNyGgPwiwLH6yHbLx6amYFCgSNQHLFxBE0tU5dhHt8Iywko8QsX4CiW6FtATx7PE1BjVgaF7WCcGk5CBSx3JyLmXSsII5Q0xvS7Fm1LFDJsjTboDAvcmoTg+cEy5UbsDsFmR+N8UxxcqP0nG/BvJ5RhZJfKxuV/irYNROxZ+fFg7V9Akg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB5740.namprd11.prod.outlook.com (2603:10b6:610:101::7)
 by CY4PR11MB1335.namprd11.prod.outlook.com (2603:10b6:903:26::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.17; Wed, 30 Mar
 2022 21:29:25 +0000
Received: from CH0PR11MB5740.namprd11.prod.outlook.com
 ([fe80::5ca:aece:f36:c53f]) by CH0PR11MB5740.namprd11.prod.outlook.com
 ([fe80::5ca:aece:f36:c53f%3]) with mapi id 15.20.5123.019; Wed, 30 Mar 2022
 21:29:24 +0000
Message-ID: <595369cd-b7d4-985c-a7e0-7110ffe9a606@intel.com>
Date:   Wed, 30 Mar 2022 14:29:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] selftests/sgx: Use rip relative addressing for
 encl_stack
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     Shuah Khan <skhan@linuxfoundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        "open list:INTEL SGX" <linux-sgx@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220322074313.7444-1-jarkko@kernel.org>
 <7b7732ec-c7ff-cf92-510f-64c83ed985cd@intel.com> <YkRvFkEO8Ic1VdQ8@iki.fi>
 <0031a4f0-75f6-3104-1825-dcc2528f61b0@intel.com>
 <f68d472877b7136c32d8770603a3de38de59c322.camel@kernel.org>
 <ef991f0d-d0d2-f422-96d8-0951d593d2a5@intel.com>
 <d44b3fc7ce9f053f978645dfe19018885d372d87.camel@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <d44b3fc7ce9f053f978645dfe19018885d372d87.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:303:2b::29) To CH0PR11MB5740.namprd11.prod.outlook.com
 (2603:10b6:610:101::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d720817d-8dd6-4d4b-796f-08da12945c91
X-MS-TrafficTypeDiagnostic: CY4PR11MB1335:EE_
X-Microsoft-Antispam-PRVS: <CY4PR11MB133598665C31B9689C424885F81F9@CY4PR11MB1335.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UPmQCwsXoDwgjWt8Dkjn2swxEFNe8LZlVqTupUWL8M2de0OMoobZE1/VRTrxmqSzuq+NV7Tw9LqmwjUXDooAchJHisc4Ipher5m+UXB2AHnESmyFJ+KeHR9a7ayTGzc1odLtrOU8J9mQHzXNHNicLv/nvB5pJGHigVprapQA7DZ8fImrLhKxPg0JcyDPz2AkeLX6w9TDkkaPPD5HhvvvKUQDCQN4TkFSgmx46s7tvbLNU1LZ5U1MJSgSW1HYwkDqjNJTBE4ii9emVrt8Byd7athkc0g6MAZldVnBihtsWaiWPjiNzrvYFoOBB2pE5ZjOZr6xUQinu5OaxPMPZ1mNNPvsfeOW5tQZC6pvP2l5j0aLJMQ981sKOcqwnAghYCx3V++yeqC2L34aPOGQpuSiKyDnp++ZMHhKjkLYWYLPljcd45eVcMNiBdau1ng4NQgpSw8BLl9/1xHsrlMyJ/f54uBnNqAvZPHpb8E3/zkZzb06/CCGyOo1O/tqMZMnqEAwEsVGIuw1m7z3aCGHAGHgrZVrjJQdf2+gSPaz80luD188bNSxjdX4Mt6MFAf7DAp/XYtRP3vTx8Y2h1nHqyW/BH9INEerh//Vs3FXKc6hpI5SRBwL8zwnAIWsN3a+ted2YtDF8eTZ5Dy7Nnw9YhDLifHUXayF2TS63ZBAT7NZoiqO/i00+XMq4CVXj7g4D3VXXy+O6rV+P2AsWJBUP4D8GY0x/LJC8Ee7IZxF393U/OooIqhlFo7jYGBP7PlGJSuA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5740.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(186003)(26005)(53546011)(8676002)(6916009)(83380400001)(6506007)(6666004)(66946007)(8936002)(66556008)(66476007)(54906003)(4326008)(31696002)(86362001)(31686004)(6486002)(508600001)(82960400001)(5660300002)(38100700002)(6512007)(2906002)(44832011)(36756003)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjV5LzN3ZTZQdUtsR1JnOW5iNWRGWVJ1bUt6R2RTNDFYaHB1MktPOC90c2NL?=
 =?utf-8?B?cFBTNGsyejNuemxsVjF1Q3BkQjNvSGZCQ0dPanZCMUttYzVyYTRoUEYwT0Ew?=
 =?utf-8?B?OXpmME1YTC9pY3pFMlloTlRJaGtVb0VSOXdzTEJDTHhrUWtUS2xTb01rd3Mw?=
 =?utf-8?B?aEdOL2NiZUhaNmRqSFM2Y3Z1UHE2YVVmcm5Ud0N1UUNKRlBkOWxYZ3RtdFdx?=
 =?utf-8?B?ZEJueEdMR2orNkhBZkJIMGQzSG9aOVNGUGhoVnRBUU9xTG9MNWNyMEpVRHRo?=
 =?utf-8?B?VUR4Ri8rNDRKbUpOaGJXbm5wUFprcVRYTm9vc0c3eS9xakZDMS8zSTZ5cGov?=
 =?utf-8?B?UU5USUhDK0dzS0dsdEE3TGVYOXZtbG43WnNqRnNxRkpNSVRTcVlqbVR0NGpQ?=
 =?utf-8?B?eGlxZ2dTZjJLa1hNeDZhdjNWRTY4eG1PbU5qMXJuRkFlSjJJUWtHWTAwR25R?=
 =?utf-8?B?b0JZeUR0Z0J4N24ralJaOUxzbnIrU2w5OXkwc3JlRU84ZHF1Y3pIYkpuMUFM?=
 =?utf-8?B?eFRzdXNCU2ZiMWQvTGUweDZlaU53TzFZMHlwQUUxZ21yRGppVEFGNzVFN3Fm?=
 =?utf-8?B?NUxIYSthUU1HY1FYOTRKWjU2QmtzL0E0K0J5ejdRWjIxMzU1MlBCNzYrUU1G?=
 =?utf-8?B?bFRGZGtpRHFlcnFiSW5KTEpaV09zcVkzRWltQ2VoVVlUOGh2a21NN3dOWFZS?=
 =?utf-8?B?Z0RYYzBxMkpGVWdLdTd6WDduNS9nemdEejJpbmRPd1NvekN1K1lKS3NCU01r?=
 =?utf-8?B?R2ZKZmpaRzdOUVpmSlY5dmkrNTVJY1dSZVR6dmtYck50aEZYc2JLaDVXTGRw?=
 =?utf-8?B?UUNZZ0pKRkcxQzNJeWwrQTk3eG5JREJGR2NZTjk4eE9iWEJxZ2gxZzFYQXFW?=
 =?utf-8?B?aCs4cDEwa0EvMHNIdzRyMzlselVBYTBSVmJ1bGs2L1dWUktHYytwTDdqeXdC?=
 =?utf-8?B?ODdLZjZSR0NVZFJRbkxFSGlzOS9vK3NmSEhHM0ZqM042TVlpTzhkZm9VdWhS?=
 =?utf-8?B?NjhDclJVNGczRnYzSURtOHBibkNaMnY0WW1TU09FK1U4c2NIclhOaWxGN2tF?=
 =?utf-8?B?TVIyRlNkSkFKM0doUFQ0UG1Sa3NkTkFUb0pGY0V2ZGhRbTAyRXNQbjR2QUlq?=
 =?utf-8?B?LzE1andtSDVSclZhMy9BYmtvSnRQYUVRU2xIWjdWcTFvNTNQOXJzR0x2ZU54?=
 =?utf-8?B?WFAvQzdoaFlXUFArMHJaYmQvbHpGOTVVL3k2RlpaTERQS1ozaXpLUFpoVjN1?=
 =?utf-8?B?Wno5SlFLZ2xHQ2FzeGRxaWd2VlZpamxOajY1WXBOS1FlZ3MwQURhSGFsWFRT?=
 =?utf-8?B?NnhReVY5MHcyUVVXUXkvSWwveWhTUHlMMnA5dVdrS2Q3Nml0QXR0WDVZWEpB?=
 =?utf-8?B?U2ZxWVBaWnZVKzk2Ti9Ga1pSRkw2bCswbWxRemJuWUhhanlNU01NMUc0Q1BO?=
 =?utf-8?B?TEJVNnVBTWdYTHpDc1Z4TDc2dENBdS9DYTExZmtSeG9BZnFJeGtVdnVzOXlr?=
 =?utf-8?B?Y01UNFlUazVXdUpiYzUrK3pPL055emZQeXJ5ZTlubXp2dy9qQnJKK1FoZHNx?=
 =?utf-8?B?QU1iT3llNG41bkw5VlBUNnN0elJ4dW5JbnFUdFJKcDg4VHhhZ1hVUCtXT05Y?=
 =?utf-8?B?clFpSUp5dlQzMzEyZy9wTm04TWxCQ0EzQi9VdTJTaVQ4anptMFBvcHlyWWNp?=
 =?utf-8?B?cnJVdDBpbHRCMllzaEhNemZ1ZGN0TnlYRTVNZlBHTzdHMWU1aUtOSlY2VVM5?=
 =?utf-8?B?Z2VlSnoxSHZtdnlKbFFTTGhBa001dm43bVpwdHg2VGdWMHpFN1dteWFheUR6?=
 =?utf-8?B?L3ZaYy9ybS9lYVFVL0xnWXZMejhpWWJtR2FySVlTZ1g2ZW8wdjZrUVFablNi?=
 =?utf-8?B?d0ZNcExEdWt2NzZoM3A5VW4xOGNyVkVNWmdtbC9CVVNTbXRNbXpYVEkxdFJM?=
 =?utf-8?B?QlFrWndTSWFTV253elcyRCtSUS9sUEpLRTdhK2FTVTRxWjlGaWZyTnppNzN3?=
 =?utf-8?B?YWo5K2NrM09mYjRvOS93Ui9ONFZCckhLa0FyNDhZWVRuaElPTis2RjFjWE5z?=
 =?utf-8?B?U0JGS2RwSFdwLytEeXhmK0NXWDRMT1AyZlJ0WS84M0cwS0ZGY2kyQmhSb1pZ?=
 =?utf-8?B?NEJ6TnNJRHE5QmUyTkpWK0plWnBGSnlGRU5EL1lrL2htQ3NBM1pXQ3A3WERF?=
 =?utf-8?B?bEtmbEYyaTJqUFljUjltVUlhUzRpS1NOMkxiSUFyeWJ5SFdSaGhpZGJzVkxX?=
 =?utf-8?B?aE9ZbGR6ZXhuWiswbk95cVp6N0oreDBDRC9MdXN6dXg5blVZVms3MHNiN2xF?=
 =?utf-8?B?N0xESzRVdVRhZGp3cUtnbHc5UXB3QklmVno1YUpDMEhzNWtobTRSQlZuY2JH?=
 =?utf-8?Q?huo2CSjKZLlGQ/Yg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d720817d-8dd6-4d4b-796f-08da12945c91
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5740.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 21:29:24.6812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6bXmlJeARyEIuKFEddNecqtAbBpYVQrI+SSm6PMfRi3y94RUIOkYHHAjcEVGKTkSAWDevUDLT9ia+kcjHcdaZ/Fdo6DtZgqhRJICO7CSvl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1335
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 3/30/2022 1:40 PM, Jarkko Sakkinen wrote:
> On Wed, 2022-03-30 at 13:05 -0700, Reinette Chatre wrote:
>>
>>
>> On 3/30/2022 12:03 PM, Jarkko Sakkinen wrote:
>>> On Wed, 2022-03-30 at 10:40 -0700, Reinette Chatre wrote:
>>>> Could you please elaborate how the compiler will fix it up?
>>>
>>> Sure.
>>>
>>> Here's the disassembly of the RBX version:
>>>
>>> [0x000021a9]> pi 1
>>> lea rax, [rbx + loc.encl_stack]
>>>
>>> Here's the same with s/RBX/RIP/:
>>>
>>> [0x000021a9]> pi 5
>>> lea rax, loc.encl_stack
>>>
>>> Compiler will substitute correct offset relative to the RIP,
>>> well, because it can and it makes sense.
>>
>> It does not make sense to me because, as proven with my test,
>> the two threads end up sharing the same stack memory.
> 
> I see, I need to correct my patch, thanks!
> 
> RBX gives correct results because of the binary organization,
> i.e. TCS's are placed to zero offset and forward, and 
> unrelocated symbol is just compiled in as an untranslated
> offset.
> 
> RPI is given correct results but how the semantics work
> right now is incompatible.
> 
> Still, even for kselftest, I would consider a switch
> because that way:
> 
> 1. You can layout binary however you wan and things
>    won't break.
> 2. You can point to any symbol not just stack, if
>    ever need.
>    
> I admit it works semantically but it just super
> unrobust.

I do not think that we need an exceptionally flexible
runtime as part of the SGX selftests but instead something
that is easy(*) to understand while also sufficient to support
the tests.

Reinette

* I do not actually consider the existing enclave test binary
  easy to understand (this thread is proof) but keeping its
  complexity to be minimal would benefit folks needing to
  ramp up on SGX and/or debug kselftest failures.
