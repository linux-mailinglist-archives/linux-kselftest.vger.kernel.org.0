Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C85C473546
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Dec 2021 20:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbhLMTx2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Dec 2021 14:53:28 -0500
Received: from mga11.intel.com ([192.55.52.93]:30251 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233215AbhLMTx1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Dec 2021 14:53:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639425207; x=1670961207;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4xqZlkN48IDc+c6A1fXoZT/KDwdRKPsbSvmjwsfOheA=;
  b=Ii/SPfzKw+vItRqgP0Y4Dr7F5qw0Ez2gBU1OMlP0LPajggmftQc4BMHa
   rLIJXjyp0FI1hvC9KnSuc7F8qBV0ly+Dkoc0+RilJcJzOpxnKUDKKeaIT
   H41esJPh4IHkxKA+TahtzXoiyRh1mSpZf0dZtcNeWOY4UgGUnKY3p4Zxo
   CX+IZIKKaEvtNpoPQ+XpnJVWUKwedp2PRwOfn/jiYYSw7cUNpFJnCuU9c
   aY/wjqhwO5jRjxWlFw5kSJuGmHHNzDvgxXGBo4ND+VxW/HOKjTd6mEZ87
   i+O2wKQlU36uflUltWnEwt85Zk4DMRVfTRmqmUEWN4Ip7ZfkqgdarXDyo
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="236345803"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="236345803"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 11:53:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="481635769"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga002.jf.intel.com with ESMTP; 13 Dec 2021 11:53:26 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 13 Dec 2021 11:53:26 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 13 Dec 2021 11:53:26 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 13 Dec 2021 11:53:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdbEUMIG0kxWWRib4thVKp0nmGH0xubMEL7v4riDzQWabBWT4iSNaA6drYUBRaerHgXyz+NNUglf/XDS6ONuM8mxmzDuujVb4q9GHbQITUTtkTxsOObXq+Q7HF8+DppQMqKyWi1cXYB8tHI12ExvAol9B6lA2FaVW2PDIgEiTpYosdhEgsegMU1rOyhoBf1bmKe0e+5HWbKaFrWRyaGktjA99HiRxByeqYGIcyl9D6nUoz6KoRdItrEFTotdeMd3kfoybenus0WkNZMJZb7mW+UGvDejANNQX/VLN0xaLo/9OzriZ5CgECgr/zPC5WMqy3C6ouR5uWWEM9Co4CvjmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mk2Us9WRmScDoVF0NVWuo8AN4HL5lW52SeJ1xoNLE4=;
 b=FqdhmCWtZJfmd/coV6NKPbOMwgTYONvqhfpmxKHPepJzcXqs00ZxxLjWj26yHSvPCovDmzW39t/hO2WNCfZ+Xk8Ocb4p0IHJRaYEzwteWOgR8dtNSDf2YC5K3/W4qiPLhNXyADf1pAoAP3+0BqnvMrpACOmfWizzpM44qWSeCPzruuDLv1GGahH3qa4KkF51IdleUXybmmEncc/PdpcDURL0lJeEjCwytxXWGmiQIXvgGAG1sjfOq+tcIfiw6ZUq7eRj+YTpMIap3zHBmkIJ8iwUJOse37ICLHSMhWnjd7rzzALSevUKhz1WNqDjEuad/A0ipEcc+M4evrX7HXhyBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mk2Us9WRmScDoVF0NVWuo8AN4HL5lW52SeJ1xoNLE4=;
 b=QlUECd0wcSQTC+Iyn2J75AtuG1/IPZbWMLolZpaktbo09rflWS7uPljvv9hzP0uAvXgf0x5wqaIXPOE8QAOZE0gavLoi0gjGWvlVNL1zUfO4WdGlLOwqrbiDAS/RNDKWvR/H70ECBJqewTFGR0s1uc56bsEp4vSxz9eHdAhRZIQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN9PR11MB5241.namprd11.prod.outlook.com (2603:10b6:408:132::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 19:53:24 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 19:53:24 +0000
Message-ID: <065787e2-68f4-78f1-6f82-1456dc88725b@intel.com>
Date:   Mon, 13 Dec 2021 11:53:20 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.0
Subject: Re: [PATCH] selftests/sgx: Fix build error caused by missing
 dependency
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, <dave.hansen@linux.intel.com>,
        <linux-sgx@vger.kernel.org>, <shuah@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>
References: <797ff1331cfe540fc378fcc4a4a7b00ff5099fbe.1638905135.git.reinette.chatre@intel.com>
 <003f62b2fbd37877f7dde9f6cdc693f8c35bf477.camel@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <003f62b2fbd37877f7dde9f6cdc693f8c35bf477.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWHPR14CA0024.namprd14.prod.outlook.com
 (2603:10b6:300:ae::34) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c789c81-3ab3-4f8d-fb06-08d9be723933
X-MS-TrafficTypeDiagnostic: BN9PR11MB5241:EE_
X-Microsoft-Antispam-PRVS: <BN9PR11MB5241E512DE84CCB0CDD72767F8749@BN9PR11MB5241.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3jzWpACMgD1PoL7KbZpkV06vK3O2+El82X19pOpNSWtFCuQQmus0W8XkdWG7WI5sAEHhve7CbjqXVEaAwe1bpnr3NwlhY96W5CmFb9KtVMk29tiT3SrT7/XZujYHiNEEoqCgR4jUI4iDPnR8pDKw4uomMGZ6NsoaMbrZ7k4jO8r52TEBSeNibOzKEMOuCXuw/sNSPO68yTQaBz+AS9kvRAiJVvcgoLKmqVXqepFKEAiwBa4YhFayDnvCSOoAG/wDswvXp3m30ociyAThqZzvhMGVYSuWt/syD1fBINH4gdtjNY59wMiGPrhDmkovHsMkinZ9kJWXDD6x9tq053f2LFEapohfHCX1JCmit5hA+0PjdsQyYpOjwR5YwQv2lHZPaPR4D8/zIOBjGjcwFmvgamAwl+Cqmd1I05Vqh7wSw2jVz3k/N6DVZw8K/zS/lC57EiDJFwfEeZwCnbcemf4wR9bjnv92s8PGnv1JIfWyCohAmDdk2VKWs/43DosGWrs2+wlJiyaIoaV33b+3ebGy9GCdicZ1KL3Ri7SSnCx9lI6jM5jDv64B58Gin2o2kzYpNUvAJZkUV4f4GECWFFNmXyP5qNVwfxT+h8ysbTLKHpdrFQnJs+uELpvf8+sH2TW0kw2qUTU1eaMjLA4dJ+63wVpZvQGF/k53f/LHO4rHoHYZ0rKyPo4bDha2k+BRXATKlKKyVz/dFsFcczHWHKcSLwJM5JqoKEz65Jn9rT1o6j9oXzHJ4MuQJMDW9+EglNH2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(2616005)(44832011)(8936002)(86362001)(2906002)(26005)(6666004)(8676002)(186003)(36756003)(82960400001)(31686004)(316002)(38100700002)(66476007)(5660300002)(6506007)(6512007)(31696002)(66946007)(508600001)(66556008)(83380400001)(53546011)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjBvWlJoMk9qcDE0L1YxZkl5NFBUVkI0NUhaVURNUk5neGNSVjNuSHc5cC81?=
 =?utf-8?B?bU42RTF2eE5UcDVkR0x6SnV3SDYvMmxHWkYxWWh4Q3R3aUJxVnhXelJIR3o5?=
 =?utf-8?B?NlU0bVFZZTdwTVJpR1FUWlJHb3ZKNVRKa3pQQUhOdmpLRDNheHYxNHpkUDd5?=
 =?utf-8?B?aDNwR0h5eTZmd0lSNngxNWxOeTJ3OWhTQmh0dXpHMzR3UGZ2ZXJsZ0VxQUNT?=
 =?utf-8?B?czIzVWdYVEZlVnQ5YW5nT3N6MmZSRm1qRnZ4SWdDbWlOaFJBNDBpbHJRVUJl?=
 =?utf-8?B?ZlVQRVY5Q3hxM1gxelVucjh3SUlKQ0d3clNrZithZi96TGNNaXFHSHl5OXFE?=
 =?utf-8?B?eHJrdU5WczV0TU84Tm04RWw5Zk9OZ0crNmFLbWQyOFZBc09iQW5QdkRONk9M?=
 =?utf-8?B?dklLems1QTAwQ1YzTTVybmVKL0dBSkJsdnYzQnBMR2JkWGFNRlA1SFk3WjM0?=
 =?utf-8?B?YW1yQ2NJV3lMV1cwc2VJM2ZnaklxVXBld1ltSXgxTjFQZi9qNkdVYndqeGdH?=
 =?utf-8?B?RTQvYk9GSE5xVjljaG84TXdvdnZkMEJydFk2UzF6VTQxOGhiZnBCeWxhOXRh?=
 =?utf-8?B?RURFalFZSEh3dnpsV0krNlp4KzlSYnlJK1oybHI3c3ZuVXFKL3VpUWViaW5Z?=
 =?utf-8?B?ZkZqVkdmeTlSYVZ2TFhsWFcrOGd2bG9VZGs1T25TNSsyUTU1Q0twNXVjMk1T?=
 =?utf-8?B?UUVCcEFycmczZjBFTHNoSlFDTHhYT2hMMWhNRmxRMDZ0dyswUzRKQXA0SVo1?=
 =?utf-8?B?LzVMZ1d2enNRcCtTYllZOURJNmY1L2FzWG80M2dXakxHcmxFV2Jqd0dzdUZI?=
 =?utf-8?B?SWg5UkUwTzNGdkowM0tuUDJLS3FXRlQrT25OODkycFNCYzNWQVFmMW1mY2JR?=
 =?utf-8?B?UWg0UVZDU2R3dnJPWjd5SjA3NnNrbkdWbWY2ckZ5UGczdkZWVUl2V0pwYUFE?=
 =?utf-8?B?TGhOTXV4OU1MSTlaL2l6T3VjRTlvcUtCRDlGWGhOVFExQlpZMkxwUmxVZndY?=
 =?utf-8?B?M0l0TjJldWZoWDVWNEFkS0szbVdqVlhkSStRSDdxV292OVVoS1NEbkNlKzRi?=
 =?utf-8?B?eVNHSldOVkdLS0taNUZtbU5oNjdHRWN3TU5pV0Nqd3VMZ1RSQ1dvT3VJbm0z?=
 =?utf-8?B?Vy9TNWRpd2wwZmhyc3FvQkY2ZlFTeEt6TjR2TkRoT0xrY2R5azdDZ1BDWHV0?=
 =?utf-8?B?U2piWUw2cGJYdGovMGdORXdhNHc4LzdleEVITnRmYjVSMXFUQU5WL3ExRnJh?=
 =?utf-8?B?Y05jNnlBSHQ3TjZpbjRWZ1JTU2RRUUROaG8wSWljM0hYZUF3M2tjaUZPd0xw?=
 =?utf-8?B?TkE0L244MkpGS1RqenpsWXJhWDJ0VTJWNmJKYU9ZeVpXamgyN3EweFh0WXdU?=
 =?utf-8?B?OWVKdHYycWFmeWlBMjNaaVdwQUlHelkzYmE2aC9yTzRHRFdYUEdMbjcxMmtZ?=
 =?utf-8?B?Qk9UcGJtRkVVLzRGVjJ5RjRVQ25QWDF5ZEtOSzFPdXlEck1ES21Lcldvbmxa?=
 =?utf-8?B?NmlsR3RyM0Ria2RRUlJRSXZWbWk2ZTJjZ3pGLzRJSWc1UHN5RnUrM3E5YThr?=
 =?utf-8?B?eWNBZVR2NFE1MjNxMGpmMlQzSTFSckVrbkphWGlSRUc1WGl2TUtyS1VXYmw4?=
 =?utf-8?B?Qlo5VmJpNU90TUM2UXZtUnY2S3FITWpIZVRwOE0xTVVpbVpTRC93b0t3ditV?=
 =?utf-8?B?OEFxSnFQeVF0ZFJXblF4cXAzaloveDNIc1QzVVZLRU9lb2VjTittZENLdVhM?=
 =?utf-8?B?SjFhSFNzN0NJLzBnckNiVjRHSEtKT1JrQlR6OVRzdDcrdzBJeVpUQWdXZEk5?=
 =?utf-8?B?eVJJWGUwbkRXRjFLZFdsWldwUUZNVHIrYTlNRkc5Wi9uM2V0WW9GblAwUDRz?=
 =?utf-8?B?Y0FLZ3FkOGg1L1lBT3Ywb1pCek8wM3Eya2dGRVZYV2NlaTNIaXRxYWREWGhY?=
 =?utf-8?B?WlJOaFQxMXhlZUtiRWJjNG5pZ0l6a1hLL1RFZU55S3ViMFBlYlMxT0NYMlBQ?=
 =?utf-8?B?Y3VqTkNGOC9RbmV2SENnTCtsYlVTeFg2Y2dkelM0NkFaNDBESlA0U3RHWjZW?=
 =?utf-8?B?M1FuZXZKbjZBV01FczJ3RGMrazVEODlnNVg3MGV0UTU3REFnQVpISmF6NGR2?=
 =?utf-8?B?Nldxb0NVR0huUjZzazJ4Q3FJSnNCYlR0ek0xU2FJaVk4eEZNSEMrYWlBQUpj?=
 =?utf-8?B?KzJDZnp4WkdzYkFmM1J5alluaUpaS0ZRWWp6TkxWU3ROQnpML0FXbFE5c2Fp?=
 =?utf-8?Q?WvhjZpIrTf7/O7WDJhxcEzeFQ7aLz1Axg7uJukMaW8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c789c81-3ab3-4f8d-fb06-08d9be723933
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 19:53:24.6754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wqsb7gF9o0yyyQCJrKIwnJlnjn90bw1xmxdnVPawWIuIHuFQPN6qHdrksyHUaJzydurIfwVyE1IWDbGIyeWCs9EO7SAHCMRVgJvevmzce28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5241
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 12/11/2021 12:15 AM, Jarkko Sakkinen wrote:
> On Tue, 2021-12-07 at 11:40 -0800, Reinette Chatre wrote:
>> Commit f0ff2447b861 ("selftests/sgx: Add a new kselftest:
>> Unclobbered_vdso_oversubscribed") depends on __cpuid() without
>> providing the dependency and thus introduces a build error:
>>
>> $ make
>> gcc -Wall -Werror -g -I../../../../tools/include -fPIC -z noexecstack -c main.c -o /path/linux/tools/testing/selftests/sgx/main.o
>> main.c: In function ‘get_total_epc_mem’:
>> main.c:296:3: error: implicit declaration of function ‘__cpuid’ [-Werror=implicit-function-declaration]
>>    296 |   __cpuid(&eax, &ebx, &ecx, &edx);
>>        |   ^~~~~~~
>> cc1: all warnings being treated as errors
>> make: *** [Makefile:33: /path/linux/tools/testing/selftests/sgx/main.o] Error 1
>> $
>>
>> Make the kernel's __cpuid() available locally in support of the
>> test's usage.
> 
> It's too abstract, rather
> 
> "Clone kernel's __cpuid() implementation to the self-test in order
>   to make it available for the EPC enumeration code."

Will do. Thank you.

> 
>> Fixes: f0ff2447b861 ("selftests/sgx: Add a new kselftest: Unclobbered_vdso_oversubscribed")
>> Reported-by: Jarkko Sakkinen <jarkko@kernel.org>
>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> 
> The code change is acceptable.

Thank you.

Reinette
