Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59D44ECDAE
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Mar 2022 22:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350876AbiC3UG5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Mar 2022 16:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350870AbiC3UG4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Mar 2022 16:06:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2979E5A584;
        Wed, 30 Mar 2022 13:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648670711; x=1680206711;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=009Ov0XChYA2eTetgAobRKfrgtupaGKuyHj/IEPDAao=;
  b=O1JRzeoZtXiydMhOWgu135lMWPo3HfMj2NLUSDuYtJCENHRtSY28vBGC
   vROuZCEMZdD2kMpxBknwiNpsZn+9RUQYsNdbyE6OzdIZCxssYfxRtEDTh
   ZfdIwmn3JXLzoaQBoH5sOTCWScedHwv/IGXGCmkybMjxy8Bj5NgugTqdF
   8KO+rRAy5uILubU1z0TV9ur3TVwHY8BKbMpTOIcG2pp8xcvyLWdyuRnkS
   qfivyC4g8ewjxvYji5EqSUf3mZ5I0olpIY10H9mmqwqkA0M+6sx1ESleY
   rdj5Rzv1tDWF19pFlrI+jq2dlDJemBsv4mo70reHLSpj1eImS3fBWQa8m
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="259819495"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="259819495"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 13:05:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="565775790"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga008.jf.intel.com with ESMTP; 30 Mar 2022 13:05:10 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 30 Mar 2022 13:05:10 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 30 Mar 2022 13:05:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 30 Mar 2022 13:05:09 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 30 Mar 2022 13:05:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/k+fFIUP2yKB5oybTm8pRn99QsXLed7jBWIcJMmi4WS8Qk0RXpd0lm06QnegGvt1NSDhJLc6bXkl0Pj1bmaRlWrkFcalZ0NqzutnMr2UVGJs0W7PUVQIY7QgjCszJ/MIV91Y7aCSTq+cQAmfZ/2yV4l2ZwlsvwZCXc2DE45SlfWpElCm1nA1htsukhbKYUS72CtgriwFg1jmxJMEqVGWR+VxpZKrCEIZLY0RB7lQDyC0WFAL+s1NqZ4eMkW0HpIEFeeDa6QK/Az5ZUXFthLGYRtS53MkeYrLIlgbCzNjh+1tYqi0XEM0HDLRU3PukcVJ9OrRk0TOQH3xxVv8/1jRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Pz7uQxq9182+GjleyRRXhL9WagzxDAGl7PCv9oetnc=;
 b=XZYvyj4ZMwR6PW2tDKg0sRhEjGRH5TF9j6zUzCdLt3c4/wL5VYeln4UOfVnGFDDRND0qobrphMqCc5yxJxuFzrwWdb8F94ZrVmS3lmg9J8BGAlKLNgMBAIOCq9pR/bgRgXmUbE+PqCi6rb2+wpbMEPKilFeCm808bJwxm3/f2KFegzcu4erH37IPg8mik69pzA6WVjrRbGBb5dN1qwum65jlc+daqj1fS00qYSFFGhHajueSZF2x5RBpPCzwAOKX0cJR+/Lv3wL0ukawmsHgEw/scpnIZKzMx+LZLae+RqvvPBj+A6MV1eT676NSv4dRysRqojoOCqFrHuHsJl8PWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB5740.namprd11.prod.outlook.com (2603:10b6:610:101::7)
 by MN2PR11MB4549.namprd11.prod.outlook.com (2603:10b6:208:26d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 30 Mar
 2022 20:05:07 +0000
Received: from CH0PR11MB5740.namprd11.prod.outlook.com
 ([fe80::5ca:aece:f36:c53f]) by CH0PR11MB5740.namprd11.prod.outlook.com
 ([fe80::5ca:aece:f36:c53f%3]) with mapi id 15.20.5123.019; Wed, 30 Mar 2022
 20:05:07 +0000
Message-ID: <ef991f0d-d0d2-f422-96d8-0951d593d2a5@intel.com>
Date:   Wed, 30 Mar 2022 13:05:03 -0700
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
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <f68d472877b7136c32d8770603a3de38de59c322.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0031.namprd04.prod.outlook.com
 (2603:10b6:303:6a::6) To CH0PR11MB5740.namprd11.prod.outlook.com
 (2603:10b6:610:101::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac768b08-d53d-4801-23e4-08da12889630
X-MS-TrafficTypeDiagnostic: MN2PR11MB4549:EE_
X-Microsoft-Antispam-PRVS: <MN2PR11MB454997EB7CB4B05BD424FEBDF81F9@MN2PR11MB4549.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Go7067UwB3uKcpWx76TgK9VfF85T7DWh7sSJs5cku6v2znLrPnzP7BKK6joOeiqR/zcUR+SbtGTYeCXKkUN1MIaIb52Uyj8u+J4bRB14uojrQSMdTRwhjIFxRMku6jBZe6bcSxFzE6KpraO63X8/qTnNwTiZlItesoweusQ4Pw2bPxB2dfzHnv45ClTuvSETLasNqAIMb1IjgYlM1W4rZqU1p9e0kRfLWhZEdRUmVN+dmeuY34nk7C8vDm+3tC5OTn1RK7VducqTE63TRHvG9XTTq1lnORU3XpNKpxo0q75nCj7D5L/LjxuBXMVkzhPowazBJkSqL8cMtXd3ASG/AZmvpI5yIy5OTq1phsn7NIdmZa7Kl3nxFj17hFgKp8BA5WIipMBKXCZqZqqPpGhVVMtJ7bD6C2Sb3Gbno2BY78cTUHfc7WDermdGpj7Uc30kExsU1pEAM0WJ669SgLNSz86W+fRai/nVO44PmOSuOFsCJNfNRUFN27RG3FlJvg3nOCXUtQ54BhrV/JmolX+oE8KlJv/qi5a2kxwWaVxAi/eXVYaZR8/iDoibtNeAeI3CJQP2CoX27o7X2bBh+rrgl16DlYi9o5FWMHLTU9pazNtGnAY8geFNxsP9QHfzvWCuz0gabEv7R2JSeDzPPRWCUsZ/yG1dTEDZEPih+yYJY5ofazR5LnEvKlWmutL9HUl7BBk3eODQXEfHzTqanQ9CyMCRGXveEgp/bAnZIbp4QJY4CLlG2zddUtr3AwzVMpmX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5740.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(31686004)(4744005)(2906002)(4326008)(66556008)(6666004)(66946007)(66476007)(8936002)(82960400001)(8676002)(38100700002)(44832011)(26005)(6506007)(6916009)(316002)(86362001)(508600001)(54906003)(6486002)(31696002)(36756003)(6512007)(186003)(53546011)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aERUS2JNUUZURWNwQXdnMXR4SEFzdU9HczlSREVCTmNBOW9GbnBtRzlrdk5G?=
 =?utf-8?B?Y3BJUktvVnA3QTNYVFdLeklvZFpDb3krMWo3WmJBZ1l4dWJHSjI4WGtqaTVs?=
 =?utf-8?B?c1lqYzZnSnJhQUJWOUF2UXkwelMyaEJOUXNJU2Y0WWpRdldnWHpFUGJRZ3VW?=
 =?utf-8?B?a3RMVlZuZVZKbU1sZUZTZC9iZ1JDcGtFWTd6NXkvWG14RXVqYVg0eWZDQkFH?=
 =?utf-8?B?R1FVaGhlTmhIREdibXlCSUVNamVuZHE4ck1FdjNsYUwwL1ZLTnhxd3RMQTRo?=
 =?utf-8?B?d0JKUkxhd0p6cVhIdEQ5RzBMVEpLQllydENhb0pVOVNrQm9paWFHT0FKV0tE?=
 =?utf-8?B?UDh1MDhiOWc5ZzRiYUY3emFXL3hhN0ltbDBxQmF0eXRwY1VzNThBZFZvYmZH?=
 =?utf-8?B?U20xMU15QVNhcGlxYkxCN2lJNTJFaG04TkEwVkN2T1dKemhZWWtadmxHK2lz?=
 =?utf-8?B?WlZXVTRXallHaVlaMllsOEQ0YUtnNHYxUU5adUJzcTYyYW1FRXhpK3E0ajcz?=
 =?utf-8?B?b20yZWRMVEM4RDZBT0FsV0cybVMxOUgyRjZXLzV3c3dWRzdWRVhNd0tYVlF2?=
 =?utf-8?B?UUdJeDZPWHZIT0FtVU1HRlA3bnRUbCs4WmRpRkx4ellzeWpPOXlNNjBpRS81?=
 =?utf-8?B?V2I4UTY0Z0RoWmFvNVl6OS9IUnNkcHBQTmlLRHlEUmw4cUs1aDI2SUM1YVlK?=
 =?utf-8?B?TDRiUXphZ2REMHMzT3BhbkNEcHAzZmFkRE5WNTVPc09GdCs2eWd5QkxzVFNC?=
 =?utf-8?B?ZnZZYzRBSVFQUVU4Vkdvc3E4Ymd2NXczZTJIZG1aMDc4ZERCSk5tVGhScTFV?=
 =?utf-8?B?bnYvR3NQd2IvZ21LbVUvaFphUTNLL1JoaHJDNEsrcU5JRUtRUUFDWld3UGhr?=
 =?utf-8?B?aWhxSWVBT1ozTWRSMmtWTnRqdWl4NkJXcW1wQisxZExpQUVOWE1hcStPeERw?=
 =?utf-8?B?b1pSdkRjMWI1c0YvV0NLNXhieHBMcE9YL09rbFJsRlRVcWVWZm9jSDlabGd6?=
 =?utf-8?B?WGR0MldhZFNRY1QwNTRmTkVCQVdISCtiTGlMUGRnQUFvRHlFYVZWTGZpYjdR?=
 =?utf-8?B?ellOYUxkOVlYY1F2S1NIVVViRjVOMC9mSks5Q0hzTSttMDIzMmlUZC8yVmZ2?=
 =?utf-8?B?TVlEWFFxYjlrbTk3Zjd1MWIzdzVvdW1neGg3bFhMWGF5NmVpV2xYaE84K1BR?=
 =?utf-8?B?UDhSV1BlNnlaL1ZNWlFEK0pDVVFGMWZuRVdsMGNBQ2lST3MyQ2RyYk9oLzFk?=
 =?utf-8?B?Y0I2YkZwUEZIenRUczdqNThKWmt5UXhPOXJOZzh6dlVtMDN4SUlkbnhGUEV4?=
 =?utf-8?B?YlZIOUVOK1dBaHQ5WUxIZzcrcDRhWDFWdFhqYVd6TFpGM3MwMUNOVzd2d25h?=
 =?utf-8?B?dW1TUUNSS2VscWd0dW9ZUGdUejBrYWlsVExLYklpT1owMSt2ZUcwaWVMcmRR?=
 =?utf-8?B?L003bUQraHdjWmh6UzBvREtjWkorb0h0QWNoMit1OXd4eHBaR2ZXWmViUzZm?=
 =?utf-8?B?UEZicWlEcGN4QTArTDNoRmViVktwYnFReDlVdHI0cUFLdEoxbDExQ0dVOTBq?=
 =?utf-8?B?amNHb2tFUTI2OUdtNkhIbzhUMW90Y3NENCtBck5MQXZERVF3a2NrOFplRm1K?=
 =?utf-8?B?cmFoZ0lSYTBkOGNoVitGUkJTRnVQWFRhbWwzYU1HMUNNQXpXWXhjeDM0cVJ3?=
 =?utf-8?B?ZXpVMDVlTGlQUXZzKzVRYmJ3NCtPUlYyQWRZUXRWSURPNGtyMjl4Mkw3NUhW?=
 =?utf-8?B?Ry9GYWtsYVIzcEZRUW5UWHk1Z25VWURya0JVWk92bWJSK21PUXk1YWJTN0t5?=
 =?utf-8?B?UVV0Y3p2YVJYd0UxenJGQnBuQ2dWck92YXBFZlh5R3FHZ2tqcTJWMEdOQmhJ?=
 =?utf-8?B?eFU2TW9jSkpWZGZnK3R2cEdsU1hoMHpaMlNIWEF6Vm91Mllpc1BoLy9URWJ0?=
 =?utf-8?B?MHB5akJYU1AwWVlzLzBGemhENHZLUkt4empWTTRqSThvbEJrcVJJeFpibXZJ?=
 =?utf-8?B?VWZ4RldrR29Mamc5WlJUWThZaHZIblgva2pGRzFSWGFRSHhIblpGbkJoVmh3?=
 =?utf-8?B?UnM2OFRBL3JSZVdqSWtJWWJ6QTdYbGVhTlRkWGdzTW9hbzZBK2d6NXd4VEJJ?=
 =?utf-8?B?QlNGYnRtSnRUTW13a05qazF1azF6REJsWDBMUzFzRm10UWVad2lJSmFBRFVD?=
 =?utf-8?B?WGFXM1pMak1SZ2V6RDZ6YlJYM1RnMEg1ZHFRa1NFeWRZWGJITWRsaXRidnNU?=
 =?utf-8?B?T0s4eHNTWEdQeloyN3d5b3l4Y2V6K21PVFl6UVovUzRudU5rM0VHVGdMZWl4?=
 =?utf-8?B?N0czRW1waVdaR1Q3cTZObDhrWk1uZW1FT2wrZzBGRzJzbUhvcGtUTFFxMTEv?=
 =?utf-8?Q?JCfzV15NdoTMAxbY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac768b08-d53d-4801-23e4-08da12889630
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5740.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 20:05:07.3135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWkuZp9Bo2gSbSjq+7eV8jJMzSmh1WBzRUm3TMFlcdeiVLFUCkRT2H8Hvaxa4fWkPRhXnAIDlLS9d5eG8ivEZ+02+unJO+zJFOt+zqIXaxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4549
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 3/30/2022 12:03 PM, Jarkko Sakkinen wrote:
> On Wed, 2022-03-30 at 10:40 -0700, Reinette Chatre wrote:
>> Could you please elaborate how the compiler will fix it up?
> 
> Sure.
> 
> Here's the disassembly of the RBX version:
> 
> [0x000021a9]> pi 1
> lea rax, [rbx + loc.encl_stack]
> 
> Here's the same with s/RBX/RIP/:
> 
> [0x000021a9]> pi 5
> lea rax, loc.encl_stack
> 
> Compiler will substitute correct offset relative to the RIP,
> well, because it can and it makes sense.

It does not make sense to me because, as proven with my test,
the two threads end up sharing the same stack memory.

Reinette

