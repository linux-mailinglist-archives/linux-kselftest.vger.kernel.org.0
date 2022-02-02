Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EDE4A7842
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Feb 2022 19:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbiBBSwg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Feb 2022 13:52:36 -0500
Received: from mga05.intel.com ([192.55.52.43]:26927 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231549AbiBBSwf (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Feb 2022 13:52:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643827955; x=1675363955;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CgOK6mXD/lqEsT6XgYHHU5ALqT/DR0dld2U6mUCE/K8=;
  b=Zpu756+PiLRqcJhwn/bDYSbp0z9/GX0TgnXY1E2lhtzcMy61NEblUXif
   xsY9F/dAw1SRRDPcZDZtDrN0WvSkUy9HmWrK9PHeJz2a7o3PjDpJeOoTu
   j6MTcbea9jDvgPY7ZGREcaLfvOl3nkhzUmKsdmsYjCmIAncjOlhGu+Wa0
   neX3IfUKivW2Xsgb/wjOepK4k1+XZujGfMlRFbUngkaCAbUbiMyQaPoL6
   3mFZjpsILV9g3aU/TXJYLdwFPk9VGYroez0KeTcqk3b77GqK2ca9DksKC
   eLJDuPpfj0GfSszVCTj0ChpdVSsNlA2NH4rykmSC7NoEqrov72/2GLH5I
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="334354568"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="334354568"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 10:52:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="583539631"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga008.fm.intel.com with ESMTP; 02 Feb 2022 10:52:35 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 2 Feb 2022 10:52:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 2 Feb 2022 10:52:35 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 2 Feb 2022 10:52:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4jDJhB7D9F9QD5PwWNgG41LIgzt61q6UdWv2CZ57fV1jk4F/umbiierH16Pr1oHZs7B0CEhAyYuSiO7rulMMpiP3/uvxE0y6CE0Ok9cO0wUi0fGgW28vBLHjV4sZr0FfzEhK4D01EC+SbL0uuqaLah7RcsgsORSK7obs6yBH77aHLbCdoqSKpfjko0eUrzciXlV6WirFW5/TgQxxroL0DEHWv9j7pwfCKiSsUxouhVksZbeAoBBsORHqsStbzRY9Iq00VZoaExJlEX78bZN6B+uvOJnnYR/EIq1UYIxQ0RVT6bc/aaFLmqjSQ8J8x2x9GY5SAjXSAMfG7hlGKgurQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iSVnrLJWol6lPPkHAHPzEOCkCpBdQvEVK98Ci6W+VY=;
 b=Hfu6YS2C9HRDbkhhIv5vCQYC/u2MHyMBd0ktfRM1dX/etaW0Dr1dCtqLN5VMAwUvMq0V6naD5bTG+tKzKTkFVFvRqmPCwvfa8rNC8WYjhqTPJ+YGkbACVLOY/aBjHlxp5ulaRRqU1BwFl3QeFVppPvEEe/Od8zRLI9iXjGM5JIvbyUtQLBbwT3AYhyrACxX397KuYlpfpGuQxBUmlFnA5N7XfBDwssNKMoBSTLNvQq1PSC4SeKEzkCs2o0HzPoMAb8WBoiLffTblSznnUQ22T2XDDPDn/BBVb10lawwK+7Ohmo7FDEc7KSA7DnC0/Dn0C8e/Xw6m1zBCnKyyetEbjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by SN6PR11MB3341.namprd11.prod.outlook.com (2603:10b6:805:bc::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Wed, 2 Feb
 2022 18:52:33 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0%9]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 18:52:33 +0000
Message-ID: <e6d3c912-5382-bab5-3eb8-40a9d6b8a293@intel.com>
Date:   Wed, 2 Feb 2022 10:52:28 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.1
Subject: Re: [PATCH V2 1/4] selftests/sgx: Fix NULL-pointer-dereference upon
 early test failure
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>, <jarkko@kernel.org>,
        <dave.hansen@linux.intel.com>, <linux-sgx@vger.kernel.org>,
        <shuah@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>
References: <cover.1643754040.git.reinette.chatre@intel.com>
 <89824888783fd8e770bfc64530c7549650a41851.1643754040.git.reinette.chatre@intel.com>
 <b8ee2381-d1a2-89c6-d199-15b0fdba0553@linuxfoundation.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <b8ee2381-d1a2-89c6-d199-15b0fdba0553@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CO1PR15CA0079.namprd15.prod.outlook.com
 (2603:10b6:101:20::23) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4785a4f-0e1a-410f-62c3-08d9e67d2ba2
X-MS-TrafficTypeDiagnostic: SN6PR11MB3341:EE_
X-Microsoft-Antispam-PRVS: <SN6PR11MB3341EB1242694D9EB5007E16F8279@SN6PR11MB3341.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oayXZjXSjq9o9QfbGtk6DPZDbr+GWBeoprmUZ7Bzo088ue+mksKxi0ovYIbF7OHQ9quDqBedlgEQ+qqUPr7rq18hiYPt+nsdDYteuMpvv4ERTd48iBrYmiLMVHZcpfqjNIZ5+iV+FWmkjXW8JVO59Zr3tUCWdv8ki96Cr9DwXPP73iL/bOGkP3NUish/ZuXokyXP8x0KUKLnreIYL/lELCtw7qCapNkrE0g2iWlWjo0yx2bSwv24f4tbBcTzSyp2O8uF/7110brUMDz3RrN8ZvjDH6Tx7zJta8CuAz/ZvR4hZSJJrQpmnpoZJ0jdkibvjw9hPJ2AJ6frlQh6pJD0+Xw0m5Nk4NxmU0ttEiWUHI4TmW9PubQAioU7Ivylq6Z7z7jjmbbzK4JUJp7NNrUK3BCqrNxlbtSX4/GG5gvrCPSvgKWix+AsRY85HZwzhng1J0ipT8A5G8eOhAZ5nXJpPx8YfOhx/UwbpZAOQMb+UCfPyqxtTmfJBPuBQlDKzCDrKbYYg0rQ4mRwpKtGcMo72u0zuMYx6pmz9uldGYnMpMNhCeLjfonDhtd7hzcABjdmcltoM2eD/FCyefF4t9Ic5JWKqYR6uvlq66QMqlqZx1lZGJZ1cgCf5B4wwV57QCs/QpT12wDWPdHA+Fg6eATFCGtx6yEb/4zFTOZA8pE2m3SHUfAkpNyh4MHzpr9NwFZl/6/TjNzH7cKFUOGCbqz46jB7N6xgyiAWpXopYwkztnqmM0AgpLevqJ5OFEkwS7WWqmsHCtCzcKiTApvXMNEInQKE6CJ+baOhJyMXNkvzU4ODF2kWmr9ad9W2bvRYWKZjEjKsCQO6j0aIITXzNhVKDxray8OCwbjV2Uf8LVMPLNU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(66946007)(66556008)(508600001)(8936002)(66476007)(6666004)(5660300002)(38100700002)(966005)(6486002)(53546011)(83380400001)(6512007)(6506007)(44832011)(31686004)(36756003)(31696002)(86362001)(2906002)(186003)(26005)(316002)(2616005)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3h5bGRRdkZLRkVEUklqV2pma0UwVlhkS09ub2VTdnppWlU5REdKeThMazRk?=
 =?utf-8?B?eUV4Z002VHJ1dHhjVUszcU5LUEVJTy9UMk45Yi80RGVIdXgzWlY0YmNZQm1U?=
 =?utf-8?B?Z0NOMldvbGJJMlRkZUpETVM3WmFBYXRqbFgyQUZjQm5PQ3FtaW1DYnJjN251?=
 =?utf-8?B?ejd4Vm5oUEx4R25OOFhGSXR4WTJRRklwMUdWYm1JOW9GYVpyTEtBZVROYW5N?=
 =?utf-8?B?UkcydmRhRlZBMTlNVm51SHRxSlVjK21KY1laeDFWcG1ZSlYzejkxK2FDdVdt?=
 =?utf-8?B?TnhBVUovRjJJOWVZM1hhK0RTbm1oQlhCUVluZXhmcEk0cWo5YjJicm9JYmRm?=
 =?utf-8?B?Wmdja2RocUduLyttandOVzRXTitTaWNVUWtLazJ5YTVSUGdtcTFXd3FlQTIv?=
 =?utf-8?B?eEtCblkzT1dFRzZBbmpKRjRCa0ZEczNIOWRWQXNIYUY2MHBRUUJ0cTQ5bmZH?=
 =?utf-8?B?ZkpBSWhsUFM3MWk4Q0t3a1hNYVgvdWo2dlozU2VMY2Fnd2orYkVobDhpSWNr?=
 =?utf-8?B?Z3pGcXNESEc5VUw1K1lULzBrcDIzZmltVnFkUVR2S3VKK2RMVXFod0tpaXpE?=
 =?utf-8?B?dzRsSStxSWk4amRvNCtUY1lOM2Vva25XbkhLZ3Z3cW9iWU1ndUFuTUZBMVVG?=
 =?utf-8?B?bVFJL0ZoeWVpZm1oVlBxdEhLNkRENlNvRU50R0k0engyK2hLcFRSUUdGUmhi?=
 =?utf-8?B?UVY1dzd6d2x3L1lFZmFBY01lZFRORm04V2tNQzhyK3JJT0hDZjNBOFhWeEJH?=
 =?utf-8?B?djFiV1g3WXJmZUM2NGZNeEZyVnA0SDR4UmZ2NTVRSmpRblNOcXkvRVlnbC9B?=
 =?utf-8?B?aFBoRys4QkU3dnh3QjZrZTlCSmQxTzJ0WmZVNGl1Yk5aN0cxYVNOemd2SElp?=
 =?utf-8?B?dHI5ejkzREc5L09uZDgzenVIdlZiSDRhUUNTTml4UEdDMmlKdFdjQm5ZdkNp?=
 =?utf-8?B?MjZyb09DdUJnU0QwdXJGR0xoUEFkWXdIVVNBVENOU2VobXliV2tuek53Ykcw?=
 =?utf-8?B?ZmF1WWJKQnl6c1BIZVZIRG03WnhhS3V0bVdMRFdha09yZy9ldDd6TXRtU3Y2?=
 =?utf-8?B?bkN4WHVRcEE3UGJSc044RS82YzR2V0VJZ1J1TnBEVVBqTVZqYTkva3hTR3FJ?=
 =?utf-8?B?SU1mSmdrUFI2VHNvbW5xeTNHcDhRNlBUQnNjWWt0RnNJUEsxNGVsV3FKQ1ZO?=
 =?utf-8?B?WXN0aTNmRnFwZ3lkckVPb3dyZTVENlpGNWZMV3RMRDE5ei82ZVMrek5Dc21P?=
 =?utf-8?B?eXdQUU53RzhyQmhGaXpnUnlybXNNZzdYMnFXUkxmRGZkdnY3Unl3KzhMaXA1?=
 =?utf-8?B?NUlaaThlcThubWxac0tRZU1uQTZFc0F3VzRIZXM2NUJkVzNuUjErRHBsRU9S?=
 =?utf-8?B?MERzRngxazRHR3NDRXd6c3ZJeFM3SEc1U0dyMWRINktRbVF4eWlvWHBzUW55?=
 =?utf-8?B?T1Q2WVdSSDdSMjJsNkE3S09rTGdxZWh6Y2JEUVFVQ0gwYnhHdVE4QlJFeDZt?=
 =?utf-8?B?eHcrQkViNDA1enBCY1Z5RWJ3SFpyNk5scVlkcFB6Z1cvSDdoM0pqN3hBbUN1?=
 =?utf-8?B?V3Z4ZzdNWkpjTHdXcThZZ1RMRy9uaHhWL2orM0tPWTZDNW42OUVlMm5yYitZ?=
 =?utf-8?B?MlgyUG8xTzFUaCtsZE9lSTJITUhYU0ZEV1BkOTEydEc3R1h2MjZVYmI4Y045?=
 =?utf-8?B?VDZycUUyWElGaTc4VjAxNk9tYmR0WVR2U0EyeVRkY25ZQUZZZm4zYkNXYWRV?=
 =?utf-8?B?M3hTYTcrOUY1VEVSMC9RTUVqd3BPV3V1N0NzS3pRK1FDTlpHNzB0eXU4azg4?=
 =?utf-8?B?UFlRL2x1eXIySHlmQ25TZkxMVFdPQ1VUdzJRVjcwUSs5SlZyMmN4enNBT1Zt?=
 =?utf-8?B?UTArVGQ4eGhVZ0M0R3diWTF6b3RrVCsrOUtKTGNpSzVKSHVSdkNzT051SFhJ?=
 =?utf-8?B?d0paZmw5VlpuSnl6eDZzL0hYak51Z1paUHhvLzFZYlc2RVBUUTZpZzJUTFdF?=
 =?utf-8?B?ODdQK2JXanFpQlU1Rjl0WUc4ZWx5NzhkbkpvRUZGNk1rbW9ZeWxyMlU1aHp3?=
 =?utf-8?B?K2ZuUjk2UTkvZUZYTk1IRXZGemNYZmJnZTVMWkk1eU16ek8rcCt1dnpvQkpR?=
 =?utf-8?B?VnhZWXlzN2EvcTBHRVB1OWcwcUl1U3FQS3RwNyt2Rm1RdmdPamUxdWtuTkhz?=
 =?utf-8?B?NG0zdWxuVjByajJyWHZPSzBURnRqZzM1aGJkdG5yNEVqRkJaSG1zWE9IZkRN?=
 =?utf-8?B?L1V4MnZZTVBkbDJsQmU1TmlVUkZ3PT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4785a4f-0e1a-410f-62c3-08d9e67d2ba2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 18:52:32.9342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: osqsXMATDhjhHeK4NGwES3c1K9MscE7v9m19w/MGJngghgpQjE27j+VGSrB/sSELSycaPfRDcUb7BKHDJVPpvkDBHu87onGdjuFy5K8zoiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3341
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah and Dave,

On 2/2/2022 10:01 AM, Shuah Khan wrote:
> On 2/1/22 3:47 PM, Reinette Chatre wrote:
>> == Background ==
>>
>> The SGX selftests track parts of the enclave binaries in an array:
>> encl->segment_tbl[]. That array is dynamically allocated early
>> (but not first) in the test's lifetime. The array is referenced
>> at the end of the test in encl_delete().
>>
>> == Problem ==
>>
>> encl->segment_tbl[] can be NULL if the test fails before its
>> allocation. That leads to a NULL-pointer-dereference in encl_delete().
>> This is triggered during early failures of the selftest like if the
>> enclave binary ("test_encl.elf") is deleted.
>>
>> == Solution ==
>>
> 
> "==" usage looks a bit odd in the change log.

This is a new trend in the x86/ area and I was asked to modify the commit
message to follow suit in:
https://lore.kernel.org/linux-sgx/df2248d2-eb61-22d6-3a51-d8091f9eaad6@intel.com/


>> Ensure encl->segment_tbl[] is valid before attempting to access
>> its members. The offset with which it is accessed, encl->nr_segments,
>> is initialized before encl->segment_tbl[] and thus considered valid
>> to use after the encl->segment_tbl[] check succeeds.
>>
>> Fixes: 3200505d4de6 ("selftests/sgx: Create a heap for the test enclave")
>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>> ---
>> Changes since V1:
>> - Rewrite commit message (Dave).
>>
>>   tools/testing/selftests/sgx/load.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
>> index 9d4322c946e2..006b464c8fc9 100644
>> --- a/tools/testing/selftests/sgx/load.c
>> +++ b/tools/testing/selftests/sgx/load.c
>> @@ -21,7 +21,7 @@
>>     void encl_delete(struct encl *encl)
>>   {
>> -    struct encl_segment *heap_seg = &encl->segment_tbl[encl->nr_segments - 1];
>> +    struct encl_segment *heap_seg;
>>         if (encl->encl_base)
>>           munmap((void *)encl->encl_base, encl->encl_size);
>> @@ -32,10 +32,11 @@ void encl_delete(struct encl *encl)
>>       if (encl->fd)
>>           close(encl->fd);
>>   -    munmap(heap_seg->src, heap_seg->size);
>> -
>> -    if (encl->segment_tbl)
>> +    if (encl->segment_tbl) {
>> +        heap_seg = &encl->segment_tbl[encl->nr_segments - 1];
>> +        munmap(heap_seg->src, heap_seg->size);
>>           free(encl->segment_tbl);
>> +    }
>>         memset(encl, 0, sizeof(*encl));
>>   }
>>
> 
> The rest looks good to me. I can take this through kselftest tree, if not,
> 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
> 

Thank you very much for reviewing the changes.

None of the patches in this series have external dependencies (all patches
in the "Fixes:" can be found in v5.17-rc1) but my understanding is that Dave
(for now) prefers to take them via the tip.git tree. This is because there
are more SGX features and tests for those features [1] in flight to the
SGX area and at least for now it would make things easier if the changes to
the SGX selftests are contained in the same tree.

Dave: please do correct me if I am wrong.

Reinette

[1] https://lore.kernel.org/linux-sgx/cover.1638381245.git.reinette.chatre@intel.com/



