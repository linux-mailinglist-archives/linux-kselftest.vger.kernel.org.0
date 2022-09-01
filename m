Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2C55AA383
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Sep 2022 01:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbiIAXLo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 19:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbiIAXLn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 19:11:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F84A77E8A;
        Thu,  1 Sep 2022 16:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662073900; x=1693609900;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nH5FidhGVG0ciFUl+T1BcbwwG55loEI/B9XfhUriu74=;
  b=LSjE8dgH7oISxiv+ncssRIrwmoNOq+YK3nCZXF4BV23bIdW/TE2Vq81D
   LwFhFq9L56RAbkfI/mS6cXMJYK5Qy2I5IYb0XcM7PTCYPccjJ0EFcIB8U
   WIlmFdY5OiPbQ+7RfVpLO1MG/oSKdguX/wkf5cQG7q42eUCim9NP9gm8B
   2jexg+x8/DrYO4FPw3fIdiOgnexORm9kik3hkb9OD8VQJHd2/vWDMj9Pq
   REXaJ5R/hAqFlOpYpbxgvzmDdAZa8y9OakepmpufDIDU5XvDswYV0ndr0
   ShzHOtiBHfixc++IiPvw3kNHqYralT7tZpfre1SDJEWc3XryO4rQrHfxX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="297132143"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="297132143"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 16:11:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="858035356"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 01 Sep 2022 16:11:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 16:11:39 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 1 Sep 2022 16:11:39 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 1 Sep 2022 16:11:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmzbuwLcabaeQxSd/pN+vsouNdudF8bInA+5RH5eALNSZjYMZxEqOJaeja0/ZzJzPpWEmxrlqJ5moG2uYzAwe1K3KKZSjDhLk5QoPNC1rrUhxkBvWYKzpe0CDZ/RSaVJfyX5bVnFf+L2K7Mzu0jKZR2ndfarSPNLt2O5RCpAIk+797M1aKPtlV71aOWAxb1uscXC5504M8nVlIrYsM3H8LLHVVDfW4sKp5NwcIHXWbJ9DWtPRbNYmE/PX/WNOFb0648tusyPI4WGedjR6tG4480LzEWfy7LYal6+C79insvw2tJABBuINMsCV/kJblDAiAH2CxuHkOFV1VAyLvSuwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbdbPvwcupQ2crEMXOjbBfwQztiE2m0c/6V1aJIH9HI=;
 b=hz+HxFIwYTBaH+V1zze8YNuLgpKRCrnAyL68YOEBP9pdiwPjY4gaGT9NyRu9mj8tf/6Ni/CdyaE0T7hEPKPxDYgMaJYk9qVxz1i9Ez6hEdxfBfmRmiVszK+IioewUeN17mit13HvbN2VKs1s7SsnLYzJeEoToFRGMfjF55MM7GtH/00YbK3tEOsQmBhAIkDX8taVoGd0kBCvTfupjcOPXho6/wT6tr2DBA3GnP6nmu7fEvaGbSxCi9qlgxN4G5kZl64/ZVsXU0Bz0G3XdeHLBqsss84/Sq71UBlbahiQBdh3jFpce8Dc+WYFiR0+1XZz+Sv8wl9O+Otqyni/s+KIyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DS7PR11MB6061.namprd11.prod.outlook.com (2603:10b6:8:74::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Thu, 1 Sep 2022 23:11:36 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%11]) with mapi id 15.20.5566.023; Thu, 1 Sep 2022
 23:11:36 +0000
Message-ID: <793bd158-1e1b-2dad-5841-081d840d45d8@intel.com>
Date:   Thu, 1 Sep 2022 16:11:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.0
Subject: Re: [PATCH 4/6] selftests/sgx: Add SGX selftest
 augment_via_eaccept_long
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <linux-sgx@vger.kernel.org>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220830031206.13449-1-jarkko@kernel.org>
 <20220830031206.13449-5-jarkko@kernel.org>
 <bd5285dd-d6dd-8a46-fca9-728db5e2f369@intel.com>
 <Yw7HOIfnaO0IcDiX@kernel.org>
 <7c85f675-db1a-eb5c-2575-759d662a0ecd@intel.com>
 <YxEvUm9jmHaAbdU2@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <YxEvUm9jmHaAbdU2@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0149.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::34) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bd5ff7b-84b4-4684-0cbc-08da8c6f5192
X-MS-TrafficTypeDiagnostic: DS7PR11MB6061:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SoWH7ZRXtnmBk7id811dGKhRYCzQx/YbJXXGQrOj48FRTA2hD5CUGQxXnEnKf/wq9Zoj4I8dxE9sRXjnJ4YMzeu4I+dLKlyFRA/a602odGaFgDc3saHDm0ZrBKtknv9CPc+d037yj8LCkj6s0LGRcTHqe0FifAL365beKaeyxJ+AAR5nXUXBfkLgpOr5gy8pzuAukI39IcdX2FMYTdeRFQA+1JSRAlbvtGCW3QI1RKdJkS8EwX2m0B+YRwVhK1jMPenRV2H6Iq69fMjwlaAhxStY4lT9PhnDF4QkXRyV8cp0d1aJ76uTjTRokazknFNd57h1VX0DxyO5+v57NfnXoVWfoGBqPMwlnNnZoUsYWZOqzKRwGJNKoT9zwcO2Z7cy7+/dRU87pWOvOI8aFz7qJJkrKNrwcdympOsteYM/ylAg3tyKnQCp9BmHmz162kzayeKS8mgbQfIfDT0Jh/w10ONtNU1fY57lW0YdMoRqLpj4UoC1KK9qWikb1JCJRLreUb7G2VWxsMyu78qqTbVF2XIL5TsKglh9xPYCMDetoCrmL1iYmENzFVAk4DmHZObMo8unD47+O92e4rVK5gNz2aWzmh6OFw0r7tWOeTp8E9ZCHh+poPVnB7OeoXLUt++9Qrkxrn3PlEvPQVZCzgxILqw4IpQO+sd4t5b3ol+pRSCZPVsQy5co1j5a8lOrBnw7i7KKOM9AYiQQGenDej/q90c43dPmpgTHsODDmyDdTfJijgmh3uyNAYLYyISK2N/0Uwou96VjlpA2ZSofyoqgL41bywVF0C9RjhonBum2zzA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(396003)(346002)(376002)(136003)(4326008)(8676002)(66556008)(2616005)(38100700002)(31696002)(66946007)(66476007)(36756003)(86362001)(2906002)(5660300002)(186003)(8936002)(44832011)(53546011)(26005)(6506007)(6512007)(54906003)(41300700001)(316002)(83380400001)(6486002)(82960400001)(31686004)(6916009)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlROVU9UNDAyYjlZcnlDd1haMExKM3lrdzEwWG9qcDRNQjhsQjNzdHprYTM4?=
 =?utf-8?B?emV1SG5SdW5iSlFmU0VDa0FRdXlUOEZIWDVCYXJobmFoQkpHa25SbWtNZVFv?=
 =?utf-8?B?QnpmVzd3UTN1U2pYSjJRcW4vNGZyWE9uZDJFS21IVXJSR0hyNW0yYnNrdnJX?=
 =?utf-8?B?MExiSGxGM0xnSlBOQ1MrRlJxbytVOUJIT1I3TjBqUGUwWHgybjJNR0VsV0NO?=
 =?utf-8?B?ZXgyVDhic2FucTE3U1V5U3RheHZXS3luakRjNkhoOW9TR0hwTEs2OFdSUXJJ?=
 =?utf-8?B?THVMN1NKYkVnNEtOSmcxSDZWMTNaN1g1akw5aDVIRU5qS3JMMGRXSE9BN1JB?=
 =?utf-8?B?WTlGKzBMeVZMY1RRcWl6R3hBWkZqYnNKbzI3RFIxZ01xa3ltUFQ2Wi95bEZH?=
 =?utf-8?B?Z25IUDJmMjBlWlkzV3pSRTEvdXpwNUdrdm1FSld0ZW5IekEvc3VCRnd0TFhH?=
 =?utf-8?B?M0FCWStxd09UdlNoTGNvbFZNbjV3R3g4RXFJY0FpK3Z0bU9vYnZGU3ZTdlh6?=
 =?utf-8?B?Nm5IZGxFWENBaUV2Y1cwSUdDRUNmR3pGQkVTcnJQM0VSR3dpTEFjOVFhdUoz?=
 =?utf-8?B?K3NLZnhBdVFTVXhuMnJWeVZVRnlEdWRNRjhnQjNod0VxKzBRNEpCV3JzU2tJ?=
 =?utf-8?B?cml4eVJnWkM3aUdLTUxzd0MwZXdheGFOZUJYWDVDbWdZbExjeGl0REdzYXN2?=
 =?utf-8?B?TW1oSHRYaUs4SXBjUGhBeWNObEJ3eG10M2F4Zjc2T0FDa3Z1TnVraS8yRFJp?=
 =?utf-8?B?NVU1SFZES3lqYS82WGVlQkRVbnFuNjJ2amJqU3FxbXdESDF3bnFSbkx5WlY2?=
 =?utf-8?B?UEgrMjlnclMvbXZNUVlLTVlTcmh6WkZ5cThVZDhxUVJsb3RWMFRNSTZLRERZ?=
 =?utf-8?B?eGFSc0dpTkhVQzlRa3hrSmhWdUpvTkIvNExnc0lxZnFJQzdpYTFkRFE4blM2?=
 =?utf-8?B?eDVjamZUV0IzcGd2UytnSGV2K2NsemxWYWpHdG1hRXJRTUMrK0tKN3pLMWRy?=
 =?utf-8?B?YStSa080bWFjeHBGcGhFS3hoYUJleDUxZmY4NEJjcTZkQWd4OWthYnQ1U0ZZ?=
 =?utf-8?B?NEh4VDZJQXFWSjE4N3N2MjV2ZDB2aEF2dGFuRHRZR0RIVjkwRm9mempyeThM?=
 =?utf-8?B?WmlXOEVtcnFaTzBvdFA0ekEwcGk5a2VYWk5qRkc0akhRblpqazFFaXYwblV1?=
 =?utf-8?B?RVdqOFlNSHZVT242WXhaempYQTBHODJQZUlMMXBWVGhJMlNXendWRFlka0Z1?=
 =?utf-8?B?dlN0ZThXeG05a1ZBclUyOEw2R1EwQWRsM0pQUnErVGhqaEt2NFk4RU9SV01x?=
 =?utf-8?B?RFFVQitXYWcyaE5lSlBvK2FNS014dkZXdUttQkVnTUlDY0Y0cXU4N3JEWG1i?=
 =?utf-8?B?aFRrTkxlcncxaUtJTEI1UUdBRjl3WEtYL3ovdGVSbHRLSEZBbWVacUl2TG9i?=
 =?utf-8?B?UndyZnpHdjJGQ0xoaE11czA4ZXova3JPSFV3RE16U3lneExONytWVS8wNFVW?=
 =?utf-8?B?ZXR3WU9rWjlWVXdDaGwwQzVTbWpCSzFZZEx4VmlhdWovSDVwVHM3ODh1ZXRo?=
 =?utf-8?B?NXFWK3RwZXpnZUk3SHFkbXpJSktYTTVDNDhHUXpvZ1FOaThaaU94TEtkVW1o?=
 =?utf-8?B?VVJHNlpRNGIzT3ZSbjJSVGc1cURBS2Vyd3Nnb0lKQm5QT2x3R1FseE1ySkwr?=
 =?utf-8?B?WHNZWVhPdmlUeHdLbUlKZEtuSVMyQ1BZZUFtcVhRZXA4WWNkalNVeVkxYzV6?=
 =?utf-8?B?NUh4TEVkVEFRelFWN3hkdE5sZWtabEkyUGU3WS9QdDhoVEt0aUZid1pNdzAr?=
 =?utf-8?B?Z21PeWtXQ011TDdkOGVoZXBENFFHelhoRDNXQjZGdURLNzZiTWQ0MXlLZms2?=
 =?utf-8?B?dzJWWVJoa29jVUJlMSt4bUJxc1FCVEh6dXNNYVppbzJCSGxYdWdVNE9Xa0dY?=
 =?utf-8?B?dDViaGVwWWc2aGU1UzFPWHU5TldpNzVLTmhnYXFuNlRSSFU4c1BlTUJDNFBN?=
 =?utf-8?B?blNsdEswblpwWXlLL05nUW9JRjhVQXdMSmZZSkViaFdOR3I3NEV5NU9nWXp3?=
 =?utf-8?B?UDd4d29GeTdKUlFwbGNmeFhtUzBGaWdEam8vdzF3aTBMVGUwTUk0SU1XRGhv?=
 =?utf-8?B?NmNHWDAzMFRVZ0Y5azZTaFVSd1BHNXd6K1cwZ2xFYUlXRnRkbXVncjFWb1B5?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd5ff7b-84b4-4684-0cbc-08da8c6f5192
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 23:11:36.5693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gr3SmwwAM3kehZUNbGkM987XPFwaGpHDgXKP6civTyU3mNktK1zpqAuQ8xn+QMY5IAJacmrPgPcar9oeOxTA2Ak3Boeir8R+1PQOUZ7WyTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6061
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 9/1/2022 3:16 PM, Jarkko Sakkinen wrote:
> On Wed, Aug 31, 2022 at 11:09:02AM -0700, Reinette Chatre wrote:
>> On 8/30/2022 7:28 PM, Jarkko Sakkinen wrote:
>>> On Tue, Aug 30, 2022 at 03:55:47PM -0700, Reinette Chatre wrote:
>>>> On 8/29/2022 8:12 PM, Jarkko Sakkinen wrote:

>>>> There seems to be at least three patches merged into one here:
>>>> 1) Update SGX selftests to create enclaves with provided size dedicated
>>>>    to EDMM (this change causes a lot of noise and distracts from the test
>>>>    addition).
>>>> 2) The mrenclave_ecreate() fix (which is still incomplete).
>>>> 3) The actual test addition.
>>>
>>> I would agree on this on a kernel patch but not for kselftest patch. It
>>> does not really give useful value here. This adds a test and that is a
>>> good enough granularity in my opinion, unless some major architecture
>>> work is required as precursory. It is not the case here.
>>
>> I must say that for many good reasons this goes against one of the
>> fundamental rules of kernel patches: separate logical changes into
>> separate patches. This is your domain though so of course the work
>> within it follows your guidance and I will not pursue it further.
> 
> I don't consider kselftest patch exactly same as kernel patch

You are not alone.

> but I can split this. What would be good enough?

I identified three candidate patches in my original response that
is quoted above, but as I mentioned I understand the sentiment
and this is your domain so I will not insist on it.

Reinette
