Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF004AA4E8
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Feb 2022 01:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378684AbiBEALX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Feb 2022 19:11:23 -0500
Received: from mga06.intel.com ([134.134.136.31]:40481 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378680AbiBEALW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Feb 2022 19:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644019883; x=1675555883;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DxhF+COV+1O9YZFdWI/2GMlDggN+/tLSqf810jfz2uc=;
  b=ft3elag+Jk+/TpKeNDqBYTB/WNM14r9tjb1CqMgM5TM/Tf6BpwMEE0hr
   fIgBlMJBeok+WCr6gnbtgFpcGPcOZAEBSoV+s5P7XLaVpV6HVwVrs4J2d
   sFH9tKorVcPMb2b8w+OJiC510IdJLzwCUvu9rOglft4N3boEOqjBmalWG
   5MWPrsfg6l7Xz7AiSN7OsfCwu4TO35onB8AM61LXSDQ9mKiQBWzw46jgG
   2kQfGsmsfhe7fYOlCkhr4UI8VM0mSmLmsI4YfFKCMkhKsv93+Lijn1+bh
   CAW1x2zrkLp0ClzsQwMUVlgMAY5ftHaHkD756uRYkNoZPvBXDAl1a0v9k
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="309210886"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="309210886"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 16:11:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="535680588"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 04 Feb 2022 16:11:22 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 4 Feb 2022 16:11:21 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 4 Feb 2022 16:11:21 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 4 Feb 2022 16:11:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXDe0HahrhFYLyZYgKbp08UngjhxW+beFWGo9RAWyR0y06Xq7emlxduEHtn7dSiY5kQG6D0ixrNKzpQlAD/reZx/yNrt+QasKIb4kK0eYlRZLB3Orcz9fQWWr48XDRg2o3HepkHsR7HVOwFp5rhu0kwX1e4PIj2m6NpsUA+ZI37cagAr8JoT/uViEflNJ0Z+MZVAxpPgt95X7GfeQvHARiuV1v/godImbUBfJeUwpjI8Cbq1GkJVPxPvY7ypicf0N7j1WEW3fWPRRu19f++/obtskMtFKse7NNWEWHhd1G0bb+UQYtSqPb55dsEFxnt70MHIgr0aBmls7WxY35rb2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0w5HYLxnyDoCk+oo/Rby0+92X2hsIJ+qRIZ9Hvw49Qo=;
 b=hVV4p/VskTKrHu9ykyZwGMVTQklGnLvpj8C8LcxYl1ba71AvRcXrWD/R9tDI3PqHgpEviL94ROnPFvFbm+ZuyFkCKGm/PLhsuBHguheAzhbt1egq6iAGCfdrhh9ukn+XT8ohaFYjokqQ85jLy7PdC5MGSCj6FwI7EmzrX1taA2XqAD/J5LEeco1ET/uZ2hZ/q36fMKw1KlfzTUMceULmyEC73YVQiVQc+hBM4uVuoFDn27xRZzRihVdZPgkKCx52LJyxyIMOlPOBMDJOWN/arNqUdeBIqhmzlLdYwJhDkpNS1xnQzh4tDwux50sBYVPNosSwWAxcEsevrSyYsb8WbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BY5PR11MB4402.namprd11.prod.outlook.com (2603:10b6:a03:1c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sat, 5 Feb
 2022 00:11:20 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0%9]) with mapi id 15.20.4951.017; Sat, 5 Feb 2022
 00:11:19 +0000
Message-ID: <c61a227e-e35e-55a8-3571-6e015e222d5f@intel.com>
Date:   Fri, 4 Feb 2022 16:11:14 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.1
Subject: Re: [PATCH 0/3] selftests: Remove duplicate CPUID wrappers
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>, <shuah@kernel.org>,
        <linux-kselftest@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        "Florian Weimer" <fweimer@redhat.com>,
        "Desnes A. Nunes do Rosario" <desnesn@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Thiago Jung Bauermann" <bauerman@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Suchanek <msuchanek@suse.de>, <linux-mm@kvack.org>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>
References: <cover.1644000145.git.reinette.chatre@intel.com>
 <81df8c0e-fde6-f3b8-f988-b539f193635b@linuxfoundation.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <81df8c0e-fde6-f3b8-f988-b539f193635b@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWHPR10CA0058.namprd10.prod.outlook.com
 (2603:10b6:300:2c::20) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06437a82-2e22-4dce-7353-08d9e83c08dc
X-MS-TrafficTypeDiagnostic: BY5PR11MB4402:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BY5PR11MB440258394264ACAE613AA2FCF82A9@BY5PR11MB4402.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rZ28bVmzE9zAXgFJ7QtKT8hSR2QxFG0AQE8hphGUCyo0mfEwKcbHUHgwjXAPXYV6b3zTDavpnWFchHawOd0awqqMIVGflv7tHh41WiwmFSz1WAreoSxVQWSay7Rj3JYBpP/5pRTMurjFiO0PtMZTP7kTWe9uQp5/M41URShpzOQSFMJFsuPbctXU3qcWWIYRRM5Oglz/HQ0aO819luBpLN3BbukmtG75AAGtfXijbyPTMP1L5Tzz3qvRJOB/1cpM3lJg5vwnQ6MBNxVaaXhJaqN3x6jMWSxbUpkQvQdfGp+4O/kQ3bUpJzJy5B9br/0ZQF/Xx8wYLZCfvJRehVV+Mk31wz4arvxdSG9A/Uh8XzZ7w6xfNKvwO4LkeAxtHT0b44n2gCRAyEte5ynIYRJ9BVRM18oMnQOX7PXC8pDkQ+YI3XtA1/xldKj5D5C1PrE07F33bsw9CsAVW8z61Dxwd6s6Vk+SHYjNqA0oqBTvWgDcbA44R4pRpSow74h4NnMHoUrGD4W8AxzkVLdnXV7ptVJdf7EzonpEaVDx+8tCXpl4vhJ/aWT1ZxE0FaTW99UbnNJTtjKtKZ9ttLlPokM43D3UlUFELGg+2RXevabYlLEre02ajYs2HQwpm/QmDx3nPc5jHh6vffcVzUSRc8U1NmiwWIN97AObmBVK9Z94mTKRLcQZMyk55USpDjLQlFxFbTPjdcTWSiyETeDZkeU4VH5VzpjDE1LVDAp8G7fhdqJ4VY6pNGgr6fNjBgk0lEyyq3BahGzwsJ6R/TF2AksZlWqXcWOpg8YBvGewqAuOUEt/1y+9vk2PonHndGQuAw+E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(31686004)(44832011)(7416002)(2906002)(6506007)(6666004)(5660300002)(66556008)(66476007)(8676002)(83380400001)(8936002)(4326008)(36756003)(26005)(6486002)(966005)(2616005)(66946007)(316002)(86362001)(82960400001)(508600001)(186003)(6512007)(31696002)(54906003)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U084SFhyRitXdVlvRTkwaTd4ZVh4V3ZQMDU4NDV4aEE2S3N4UXBFdU1Ub1ha?=
 =?utf-8?B?OEVGS2NPOUcwTC84Qm04RE95R2NvSk9pUmhndS9Nczd3b3dMdDdqN21xZWla?=
 =?utf-8?B?Y3R5TThZVE80c084clcrWWRXZzZDYmxWcUlsMExVZlVieTdjYXgvSHNiVlhW?=
 =?utf-8?B?SjI1YnJmckJBL2JGaUFEUW5nNzhNN1Z5VndRNXFPamp6dTQ3TEFqYkw1dVJM?=
 =?utf-8?B?aUVQWUdZUTF2b3Z1eDdsTXBabTlVVEozeGg0Ri9lUkQ1MTVyZUpTTjNaMjEz?=
 =?utf-8?B?aU9ONS8xM1NxYjBVdDE5djYwTWZqQVF6RTlNZWtyREptNlZsQ3BxM3BhWkZh?=
 =?utf-8?B?MGt5UC9lbCtSWVRkSTdhNldURXpGbGYvczlYWUx3SGhtdmlucVBFNnRIbkxm?=
 =?utf-8?B?R0w1YXBrNlpLS09PZ1ZEMStlZnZHSktyME96U2VFbWorK2VRRjJZemRhcHVI?=
 =?utf-8?B?Yk5BQWx3aDE4Sk5RcGU1K01rYzRBMEV4amRTRkQ3VHFBV3IzOWtnZkh5TzY3?=
 =?utf-8?B?VEo4MG9rK2xwZ0ZGTDhnMlBhSG5zeWtYbEw3Y1FhcGl5eUZWZDBxZTFqQzlD?=
 =?utf-8?B?ajU2VnNxQVkyVkRrTm5HYVczSnBjaUZDNFFRa3NCbEQwbTQ5a08rczdyK1JQ?=
 =?utf-8?B?bUVDNldkaFFkMjI4Zmc4ZE1MZFJML3dKWDYvY3ZleTNOeW1raHJScm1OUzR1?=
 =?utf-8?B?cjRpUGQzb3hvanhIWUhNV1B5QWhPWTVVcGJObWlid3Q3WDZraCtaSE1MZnVo?=
 =?utf-8?B?NEFWOHFLMFdHK3U5azJsR3lvUHV2ZTlQTFVEQ0lGM0NRVjU3NW13dFNsbHVh?=
 =?utf-8?B?bUhjdG14U3ZZT0hWQnhBVlBjbHRoMmpWS2hlWm9DdnB2aFZ0ZmZDVXEyV3hY?=
 =?utf-8?B?OTMzdWFsWVI5U3hPbW5ibU9ML3hFNE5Ya3RQR1ZocXlPdWZVQ3hsNktkbk1H?=
 =?utf-8?B?K0paTXQ3YjNTcmtBYWZDZzJPNXlaRnh3WG9vRHQwZ2p2bG81enNXckllb2Nz?=
 =?utf-8?B?K1BIODd6T0QxM3V3b0dZUXpyelVaQWNrTmRaazFrMGl6dmZzclg2QUgrcE1i?=
 =?utf-8?B?RnJHWUVSQjdvL0ZTRW1CSlpJa0hRSmJCMWtGNEN4MWo0czQ0dSt4YlYrMU1E?=
 =?utf-8?B?N3l0RDg5YzlHT2pwSEdHeUlMK3BYcCsySVJLczFyS2tkdHBMaE0xZngrUkQ1?=
 =?utf-8?B?cFlmbjJwOVZwVkJLTnlFSmtLcUFHZnB5dVRGZ0xGOXNkUVNENDJLNWlIRjV6?=
 =?utf-8?B?eU1nVEV3aGdOL01nMVBJTjFIZW5nQ0dFMXhGZkxsUzJGWlEyWHY4ZC9BVXRk?=
 =?utf-8?B?TUZYaXNpYjhyL2FxU28wY2dpY2JHbE9zMC92KytEUXI0aEl5RTFQWjdtZkVp?=
 =?utf-8?B?RlJycHV2eXdaS1J3VlQ4dWpEOGRwSmhyUFcwSlpiTi9hU1RKcHZ6OXBYVC9q?=
 =?utf-8?B?ZU52cmk5aDI2WjJPcXIzZ2oxeEt2MkR4MHFCMFlMTi9NQnljMStGY2hzNm9N?=
 =?utf-8?B?dDlFQjEyUmxBVWcxREllZk5XMzlQcmFwVjBEUW1NWXF3OVBwQ0hrS3pWNmtG?=
 =?utf-8?B?b0N3UFFIMmMvNk5zNFduZndOUHBxQU91UXJCd0dEZnlha3dJSXRvNzdQYlE0?=
 =?utf-8?B?cjNaLzk1OG9YZnhLWlRQZ05GN2dBUFlZTU1LbjJVeDBwSlQxT3psbHhjU3Fo?=
 =?utf-8?B?dWJFUE91NHVDdFQxaURaMDJaa3BIN25UU1MvRmpoTE4rcWtJSG9XdVJkM0I5?=
 =?utf-8?B?TTBGNUl1a1NxMENXWEpFZTBib1Z2dVlkMkRUYk5pQk40SXdpS1ZTcGhMT2Y3?=
 =?utf-8?B?N09neUJaS0NrQ3dmR3JGQ2ZuSWcyMWFGRTZuY1ppWXkxZGJxWC93bjZCLzAv?=
 =?utf-8?B?TnRPN05JV2w3SEp3Z0oxZi9rTHIvVEk3OTU5eCtXUkpnNnpyR1hpRWVaWlRk?=
 =?utf-8?B?Q09NS280djZVSktjb3JNWXgvSyswRVJobFRCTUYyZzVRbUh4aVVWS1QvSVpi?=
 =?utf-8?B?Sk5wb05XSjRlWS90MnUwTGhTTHZwWEJpd1o4U0EvK3c3VC9jaGV0NzNaOXZv?=
 =?utf-8?B?RFhweHhqVFMrL2JkWGFtVEFoK2NiT0tHckVhNjNrSXZzcXJ5NUZmckZuWTht?=
 =?utf-8?B?aVhkd2ljVDBwOXhsNzUvNzBuQUhNZVI3YWp4VkFGTnR4R2FYcXoyNzg2QWRL?=
 =?utf-8?B?SVU3c0JCN244emlaK1F6aEZkbXVEa1QzL1ljdEU3SXF6RnFmOUt4eVNaYUpu?=
 =?utf-8?B?QktJQXYwZjJBZERMNkphU0tDMFlnPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06437a82-2e22-4dce-7353-08d9e83c08dc
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 00:11:19.7107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IpY49Dre99jmE0gvFwViOP8zX6YkVNeXyWCxSq3cAAgVz2lbZEHtqSSnItTJpUAkyZO7eQN/3D2hLpPWr6g4iNpESPi81LXkkfR4hKr2P9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4402
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

On 2/4/2022 3:39 PM, Shuah Khan wrote:
> On 2/4/22 12:17 PM, Reinette Chatre wrote:
>> A few tests that require running CPUID do so with a private
>> implementation of a wrapper for CPUID. This duplication of
>> the CPUID wrapper should be avoided but having one is also
>> unnecessary because of the existence of a macro that can
>> be used instead.
>>
>> This series replaces private CPUID wrappers with calls
>> to the __cpuid_count() macro from cpuid.h as made available
>> by gcc and clang/llvm.
>>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Ram Pai <linuxram@us.ibm.com>
>> Cc: Sandipan Das <sandipan@linux.ibm.com>
>> Cc: Florian Weimer <fweimer@redhat.com>
>> Cc: "Desnes A. Nunes do Rosario" <desnesn@linux.vnet.ibm.com>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Michal Suchanek <msuchanek@suse.de>
>> Cc: linux-mm@kvack.org
>> Cc: Chang S. Bae <chang.seok.bae@intel.com>
>> Cc: Borislav Petkov <bp@suse.de>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: x86@kernel.org
>> Cc: Andy Lutomirski <luto@kernel.org>
>>
>> Reinette Chatre (3):
>>    selftests/vm/pkeys: Use existing __cpuid_count() macro
>>    selftests/x86/amx: Use existing __cpuid_count() macro
>>    selftests/x86/corrupt_xstate_header: Use existing __cpuid_count()
>>      macro
>>
>>   tools/testing/selftests/vm/pkey-x86.h         | 22 +++---------------
>>   tools/testing/selftests/x86/amx.c             | 23 +++++--------------
>>   .../selftests/x86/corrupt_xstate_header.c     | 17 ++------------
>>   3 files changed, 11 insertions(+), 51 deletions(-)
>>
> 
> I am all for this cleanup. However, I am not finding __cpuid_count()
> marco on my system with gcc:
> 
> gcc --version
> gcc (Ubuntu 11.2.0-7ubuntu2) 11.2.0
> 
> My concern is regression on older gcc versions.

Please see this message from our earlier thread where you were able
to find it on your system:
https://lore.kernel.org/linux-kselftest/63293c72-55ca-9446-35eb-74aff4c8ba5d@linuxfoundation.org/

As mentioned in that thread, on my system it arrived via user space's
libgcc-dev package. This does not seem to be the first time including
files from this source - I did a quick check and from what I can tell
existing kselftest includes like stdarg.h, stdbool.h, stdatomic.h,
unwind.h, x86intrin.h ... arrive via libgcc-dev.

Reinette
