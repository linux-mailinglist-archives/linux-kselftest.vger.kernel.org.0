Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30A74A00CF
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jan 2022 20:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350892AbiA1TYw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jan 2022 14:24:52 -0500
Received: from mga12.intel.com ([192.55.52.136]:34779 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229968AbiA1TYw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jan 2022 14:24:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643397892; x=1674933892;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZEwwrJUix8fPI0rd5eIOnVgBdj06N5ycBLoe86Sxmjw=;
  b=clSnvBoavC3PkwS+2YSWkOPzm3obUfDIjhPKyN3rjiZCLf60ZsPMWVjT
   he5agIRUP49zywhJxvId+YEzoMy1EWScaXocxHyknp9ffGWkjPAAeXugC
   Qr5XZtz+ua2DMhFnDz+YUf/XJdAhcE+l3W9K2jth5LQwelH1r79NfEJ4H
   36bczEi3qhReW96DVAlgU831tt4/Mh9w0E1/RQ69t6OQQenPT6BY9zPxk
   GGBFa3XUUdZNAox0PLZTBFMn1x0CnWuhT5ktqHG0SLyiwNQqJuylqKQAs
   gTb1eENcPNqPHrFuuB+VaiKEG9blw+0P9Tesdk740ES8mpjtw7JPt1MH+
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="227160428"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="227160428"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 11:24:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="770200868"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jan 2022 11:24:51 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 28 Jan 2022 11:24:50 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 28 Jan 2022 11:24:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 28 Jan 2022 11:24:49 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 28 Jan 2022 11:24:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYunGBvFTajQDaUVe6vEBVA9QE+9hi3j517CP6ioI29wtXmgEj/WmJfJTBoWU6KhVOFS4QH4xHNPcc36LsZ3Qtj6IkX/clFckHVcDfEla6xPNGIxb84+5u4Y1LVOX34w+omc5FDlmy6kgJ8T1BNOze0a8E09KiLjlcXTI4SU7x5+vAujDFUTOK0w7tS1Eif8P4dxpDDxuU4kMGOhjB5YEa2UW0JGgtCUdlJ+S2zJco5uGF/7zZmpn3k0CwDGJKR/vRGC4kDRte1DzetQZn0FU9/5fZdRMH+z4Kd0Sb1WrWPyocE9gRY2q7L1UQVhMQ9GGOHmfZO5OGvpvrvg1J+62A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7y5FF5Ad1QRgzbbRvYM0H/FgSvQDHkhbYHcXRRBF3tU=;
 b=W077GYtxGiSZhYCjgolBV9K7Pn3udCxk2NCs4XMaCsMC3UgiAT4ZRBOQbv6eO07ltnloGgDsdVvRgoMJ2SqgnLiGTJS6DKrQY+hnpbUpqiGp54MW83XJglvcLbCKiISudmcwAaYB2WeTeenyRnz8ATdb+qqjAiv73di5VrBJ2S2Xd+/YX8f8+9sFOgZXSM/JKET1UqEIledBRJpbG58C9Uzwu9MwCaAnK5nvliBrQOcDTz34ssFtxpwBxuXpMg7e+O1LHKWm+bORoaWA/HNpw87lW0tYFzJDHUQrZMd+kTf2/F6ZSIuxx9qZCvguVv2B9qUQ7rOdWXKJE/33E+DLLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by DM6PR11MB4044.namprd11.prod.outlook.com (2603:10b6:5:6::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.19; Fri, 28 Jan 2022 19:23:54 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0%9]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 19:23:54 +0000
Message-ID: <54845668-53b5-01f3-b38b-8cd6015d061e@intel.com>
Date:   Fri, 28 Jan 2022 11:23:50 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH 2/4] selftests/sgx: Do not attempt enclave build without
 valid enclave
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, <jarkko@kernel.org>,
        <dave.hansen@linux.intel.com>, <linux-sgx@vger.kernel.org>,
        <shuah@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>
References: <cover.1643393473.git.reinette.chatre@intel.com>
 <f2b46fd652450d9361577e63a8d4b0b85190c4a2.1643393473.git.reinette.chatre@intel.com>
 <920a4095-f405-fb39-78d5-cd0ec2ae6484@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <920a4095-f405-fb39-78d5-cd0ec2ae6484@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0208.namprd04.prod.outlook.com
 (2603:10b6:303:86::33) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9078d66-cc72-467b-5b2d-08d9e293b8ef
X-MS-TrafficTypeDiagnostic: DM6PR11MB4044:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB40446E0FD3CAB7468540CFFFF8229@DM6PR11MB4044.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ApoV0ACH1IsWh3WqQqPDoI9c+1M34A41ac8dxTFGHuoVUtB/ZHjZ4YkKiqmAl3uel59fbNOPngy7CHjwabtKpiYdOfr0cx6il/RpzClc5w3EJprMu8V0MkoJHHqv4DZvWJ6HxPQG18PztykUMuHCzZJNHxPhBq9Ee9oPIKt7wPDKV2fn7+mVzYmmpT5KhAaG0JjEXEn9U30iFoHEJBooMISW2ImxB95y5U2aznwyCBAqpHrzabidAgy5xy4UP8wk2P6JWa9cE11aL5xmcLOCJaXF/urdS3ZnBhgn6lOUogtZQYkT9PKtr6BqUj3kraWvKepAZ/Qz4VvA441dl7vHeCUluTlKM+Z+tTrna9ej3aiA9r7psK0A3kmY1ls0+i7wLbA+SUXcfMuJYc9tJ6JLWi6FwYpd11JEXdcB9SxxjbVgwmTlyUC96YktdPrfcajPUqNjtMwuAJWWZt5H14fC0xhwvy4JLy+MflCsjaqPsoMkoqYtJtsc8bkrL0HWeq7lxLAbl410i+8hcS1BL+ASac1NDGuqPUquCzJdHrKI9+Flhfv2zD+7KvNtyzH5jJE+VlINDEkvTdQqf+IwqNPlBVhTIa4A25VTnmF0rMrJrUQf2JSCXf3AU7z82/p9UEcpXaYQc1w+BN8dD10DoP0F1PXGwxUqgojoJhHEEDs2WHI+XvVtjEMlKL2OwGoKarXGkWOrj0UJgUDEuirmIXTvNvOwskAyGyrbm/krEdpEs2mVjCEOxU8kOvZfgg9gnAPV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(82960400001)(53546011)(66946007)(31696002)(66476007)(66556008)(6512007)(6506007)(6666004)(83380400001)(5660300002)(8676002)(4326008)(31686004)(8936002)(6486002)(36756003)(38100700002)(508600001)(26005)(2616005)(186003)(316002)(2906002)(86362001)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDdPODFIaE5wVU5heHRUNTJ4aU5VNWRlV1QwTE9idCsyVnFhd0UzT0M5cWl3?=
 =?utf-8?B?UUx6WEdvSGJFbWNxWTRJRERyK1JTbW1yWWE4clRpT0YyN20yM09oS1lyeG9w?=
 =?utf-8?B?cm1OdjNDY3p4b1ZUc01rRWZ4aDYyU0NtUkUvM1hWNnloRFJGcEpnbjZwRlFk?=
 =?utf-8?B?WUtUZFJYWFdRak1NZFFxejdOcnZvYWtpcElCUnZHS3JwYVJja1VVNXNJT1hz?=
 =?utf-8?B?THpuQjQ1UWRHQnAveUdSZ3M1cE05cVo5RGtYbXc4aWhEUjVhbGd4VzEzOUJR?=
 =?utf-8?B?dGsxaGN5WUZ4Q1RHeU43NWFvVlJEZWhLaXRQMGg5WVhuNkFHQ1VJRkF5S21I?=
 =?utf-8?B?QVdHWEYrKzNyY1RadElyMW1Mb3gvK1hHMURwQlNCZmxocS9iWVdPU0ZjenZq?=
 =?utf-8?B?TUhIOExUQlFyTXFUeWNLbkhDK1JpRmdiWVE2OHorKzlnTjVHSjF6RUdpNEZl?=
 =?utf-8?B?NjJVbjJ4NDlMbWJFbzdNZDVvQTllN3J3T0tBQUpDT2Y1Q3YvWnlmcjFWZ21P?=
 =?utf-8?B?djEwbWdlc3NWRTMrWm5iU3hFNFMzeVJYb1dKazU2WGFFaEhxeFA0c0NuS0Nk?=
 =?utf-8?B?V0c0RDg0MHNqek0rUDFhbThnam1hSUJId3ZWd3JaV25WeG5QTWlxQlNzMGR1?=
 =?utf-8?B?SDRFRkozYkRNTTI3VU5LdWNoRVExeUNhSDZvSXNtQ3dtcUdZbnVLelR6aC8z?=
 =?utf-8?B?ZVRMUzFpMlo4K3EySUp5NlU2bWNKK2ZFZ1ViN3oyM01OaGE2WTdiU0UxdlpT?=
 =?utf-8?B?d09qWmdLQXozRFpDNm0vdE5HWXBKK3lreHhEYVE1VWRzRVJrZTJEanowM1hZ?=
 =?utf-8?B?b1poMUZMc1orc3lIYktUdXErd1QzM2ZxSkJMRU1wR1JHQ1RrZGVtVXBKQm9s?=
 =?utf-8?B?cXhKWGpPamZvcXd1ZEVIanZnQ241bkF0TnNSTkpHMC9ScXNEOGEwNy9xUUI5?=
 =?utf-8?B?ZGJaTk4wekJyWFlDYWtUUDIvZ1ZBZEFGK2h5cUhGOWlQYktoancvZTNsemY0?=
 =?utf-8?B?MmJDZ3pqTk14TThab0xudytpc2NqYng2SU5rK2FFVEhiUEZCSjNpSExjYnZS?=
 =?utf-8?B?Z0hVdnVRdlZkR09YQ1VJMUhuOUlxZmE0VmI3SFh2U1RXcm1EaEMzc3ZHdjFF?=
 =?utf-8?B?YU5YalMwdVNHWEZjQnl5L3dXdjY2aVQwWUQvRU5FbkdJak85WFlHWjZsNWpW?=
 =?utf-8?B?dHVUaUU0QllwWFJVSldXenBLa2JnY2J0Y3cvQXNSUXlMTjVVUUNtZUtHb2hQ?=
 =?utf-8?B?S29EaGh0L1pOT3Z2c05nVnk3S3dkOStEbml2SnJBa2tKVEFMMWNKQW9RYlUx?=
 =?utf-8?B?RjlZRXgvOFViZVptc3E0VXplOW84V3NGbjB4N3lZN1U0QkNtejY5anRVbEpU?=
 =?utf-8?B?YVRWa3k2VWs5QjlSVTREOTRyenl4MktBWG1MSXZJWmpadXIxb3lPbVc0cmc1?=
 =?utf-8?B?d3pxUkdtTjB6d3doSVNPbTlRYUtWNGJlSmpkMFFEaEJKdUo1Zzd0MStHNzhP?=
 =?utf-8?B?SmZxSDFENHE2OC85aElWRVZvazlQajdkK2ZQN1lMMEtkQU05azFTVmh1dllI?=
 =?utf-8?B?YnE0cWl5bllXdXlSQzFLODczTlRteGtmTjQ0V25Cb2ErUnFSTUJ4YU1tb29a?=
 =?utf-8?B?TmdBS05tMnJ6NnpkT3hYdW14NE9yc09YVlZzN2tMdjlNd0FESVltSVJmNElh?=
 =?utf-8?B?NlhXUDVOenQ3V1NTZkYvK3MxNk5WVHFoUTIyNEJqUTJseWNJNWtTem5DOThQ?=
 =?utf-8?B?clZOL3E1WkQ3MUJ2RXVzb2xycnYrUGkwTmRwUXVnZGhIQ0dxQ013N1BQN3lH?=
 =?utf-8?B?K1ZaTmhTVEVxekRxMGxBSmFzUkk1bk1Sa3g2aWE3V1lZK2tja3hEbnI0ckc3?=
 =?utf-8?B?Qmo5aDdZQzBwc09jNkIyS3JWY3J4VzU1N205QmJ4cXNRSk45UCtTajcrMnFS?=
 =?utf-8?B?Q1ViK0RuWFRnOTMzeXltZ1ZleVdKYVZpM0pBeEhsRlQwcWxBKzhjcVIwNCtT?=
 =?utf-8?B?Wlk1NGpGWG9jRVpkenMyTXVhTEsxNTc2a1lrR0s0VU0ydXFBbms2NG9GeWcz?=
 =?utf-8?B?NGdDTjNETEdmSjJ5bXJTdUl3VlRudGF6MkdjUlhHdGFNMCt1Rm4zWlkxMExZ?=
 =?utf-8?B?SSsrTFViZkl0dWxzOTlkMGswQkQ3aXN0Qks2MzZ4OHhqNDQvYnVvYjUxSUor?=
 =?utf-8?B?SHFHckIyNFpFWWp4ZEJtZGVYT2pYWUZ2aGJuR0pYdS8xTG12MjhPb1B5Ti9u?=
 =?utf-8?Q?EKvzhhwGzFvz2I8+dRvzBOlXUxdv2AtGD6OqWu1NDU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9078d66-cc72-467b-5b2d-08d9e293b8ef
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 19:23:54.1962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zgFoq856olX63H36nHCZfksgm2xtn17LL9JZZnRotnPgyXVVq0/e1deN6kXynXg7htu18nOQ9MXTy0umTEDGiK5BPqF8J3MNVoJbEAkiKT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4044
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Dave,

On 1/28/2022 11:03 AM, Dave Hansen wrote:
> On 1/28/22 10:23, Reinette Chatre wrote:
>> It is not possible to build an enclave if it was not possible to load
>> the binary from which it should be constructed. Do not attempt
>> to make further progress but instead return with failure.
>>
>> Fixes: 1b35eb719549 ("selftests/sgx: Encpsulate the test enclave creation")
>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> 
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> 

Thank you very much.

>>  tools/testing/selftests/sgx/main.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
>> index 370c4995f7c4..a7cd2c3e6f7e 100644
>> --- a/tools/testing/selftests/sgx/main.c
>> +++ b/tools/testing/selftests/sgx/main.c
>> @@ -147,6 +147,7 @@ static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
>>  	if (!encl_load("test_encl.elf", encl, heap_size)) {
>>  		encl_delete(encl);
>>  		TH_LOG("Failed to load the test enclave.\n");
>> +		return false;
>>  	}
>>  
>>  	if (!encl_measure(encl))
> 
> One more sentence to add to the changelog:
> 
> 	A "return false" from setup_test_encl() is expected to trip an
> 	ASSERT_TRUE() and abort the rest of the test.
> 
> That at least saves a reviewer from needing to check what the callers see.

Will do.

Reinette
