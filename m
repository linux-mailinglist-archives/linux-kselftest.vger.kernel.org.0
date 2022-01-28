Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A854A00CC
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jan 2022 20:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239845AbiA1TXN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jan 2022 14:23:13 -0500
Received: from mga02.intel.com ([134.134.136.20]:56745 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229968AbiA1TXM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jan 2022 14:23:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643397792; x=1674933792;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Lkl6XCbKHvLe7EI8bAREH5AzE7oTDyF3IyjdhUxJUyE=;
  b=QM9IRnG+9vTukBf3TvAu1PjHmDZa8Dq99SDxEfdzRweD7ZWOiJTph5OP
   pLmdc31NRnpgcLk+NgqH+QoyW7ia0PGzqMKmz8UZNw/MqlQra5QP8/8fq
   Xgj3k3svE5q2O+egGTyWeDwv/5eU2V8SB2LQK+wLCHbxnjdeAEmC2Go6L
   +/W1VuDYrFOBaTpVcCDVBjCGl08K9DC6OVdtdGXD9rZrokj2tQYtt3lwY
   ESwHlS/jDuHcgwca6iVhIsmvOBdIvkdlVp69WlpcNxA+k/BuX7eZms7aw
   eUVVXtMa1Fna4D3EWGRorp+SuFRK/w4Y90pMFBNEas7IFGWeORjq/1Hz2
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="234567434"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="234567434"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 11:23:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="533600965"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jan 2022 11:23:11 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 28 Jan 2022 11:23:11 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 28 Jan 2022 11:23:10 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 28 Jan 2022 11:23:10 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 28 Jan 2022 11:23:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gh05SqCY+wZ8GwYpTCTk0f5o+lYA+tGkRRxVy6YRtdOnn26Hya5jwMQ5JrCFkEMCz0naD6AVvsp96/0PISjYU7T/QA/JE79YVBoeUVJfKohhpSBZ91hg9AYeyDke/JlQ3VS3eOhKR58ncy/3niQaQh9X0p25NG8DrOVqDdLprEAYvRidPRs4xTV+dhz9dAo0iHNWniSSOg1ZfsFKwdTRtINQbVDtWktddDqzvx8a02a0N89uua6ZptY3wpdnEwY6G9nzTxUMS/N+adE+tTKMMaG1N3MB422cuC2sJa0Nv0Kaa9xzSBauNcS2m2BFbCiHMAvBwtuXE8mz5gadiJWPuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feKabv11xDbaFAK8FcYJK/ilat2CNFYZIfh7tvjhKq4=;
 b=WaQXFpRfDWZ4XIEXwKJJ352g+cioMldBKtqk/4TzfHUC6Ud4puHrKcGA8PHMz14vD/AH0HC/UYKpEdxRsJRZAIImFwQr0Ml3c7n7VxlqJbVbO+BFteezQaJeEbfV17J/xhGyMfsXfj/NvwjzNWRvixg/GtF/LhXKuPpaCiTN1iS6VtEWcyHwiKXG9H0gxkElbktpIt3jJ049ImxmHIm4yw2vtsPJ/RwnHOUqSuCvUMUVvZK4IV+cMPqX8SBQrF9QsB/D5xXKH/Kgs6b/t+av9gBVZ2k0hDPF9w715Sp0FO04CP0DPgkApyIHkdVtP/kD3CNFLwUbE4b+x6EpXQ80eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by DM6PR11MB4044.namprd11.prod.outlook.com (2603:10b6:5:6::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.19; Fri, 28 Jan 2022 19:23:02 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0%9]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 19:23:02 +0000
Message-ID: <8993eb98-ae1a-9af8-353b-e13895f9804b@intel.com>
Date:   Fri, 28 Jan 2022 11:22:57 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH 1/4] selftests/sgx: Fix segfault upon early test failure
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, <jarkko@kernel.org>,
        <dave.hansen@linux.intel.com>, <linux-sgx@vger.kernel.org>,
        <shuah@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>
References: <cover.1643393473.git.reinette.chatre@intel.com>
 <3c1d84724ecc7c94131ba1d94dc4c5de5aafc58f.1643393473.git.reinette.chatre@intel.com>
 <df2248d2-eb61-22d6-3a51-d8091f9eaad6@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <df2248d2-eb61-22d6-3a51-d8091f9eaad6@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0191.namprd04.prod.outlook.com
 (2603:10b6:303:86::16) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 223dadf3-1708-4f42-ec46-08d9e29399ed
X-MS-TrafficTypeDiagnostic: DM6PR11MB4044:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB4044DF847FF77F03D2F37ECFF8229@DM6PR11MB4044.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QmxyEcm65tWkbIq5VV5wKD0fPSHvMJmDX4lY/a2PDXqXfCsypo+MuwABIuXKfjbWGVyqxwXOT47PQ91SIqm+rLlVslAjKag1JCqdIV2Uk+PrQBsuRNjrEYvjV4/SFmMphVixcdZLP/EEiqWGjuMVboOJKXjkR0hkJZAzNxladH9iIVibgA13ABDpfNmGHWr/15xdsHocR8T/i5cA7rClxCI/fMiu5HM/yYhFYQLvJx0s68FkQwhC/cMSMmsYKf7Cfn3lIHgJRIBEFPwAI4yAgEa8RE4Ro37K84nZAWeJublbI6bcdLbNQ1PAIdgPI3liU4DtF/W6uYKOTLWdsPVXgbzDGDtK+ORGy2cgNDXPwGTzUot74ROc9X9c008RqBXmsIezD8uzBx7LPjQpJ4dFFMbUKyWI2hk3SEAYowdu/pP3j1DVck+7zTc2XxDtPlBkWVu5t/M+2LgifhkT5t8JenD8xNHBraU4a+QArAlvP+nD8pmVVpAOo3zIrEik7d9WKGXk7BqD9kqk+ykhqsxAbaOzobhL2+9sEAyuUCVqjxCCvVkbwmJm3YzsPy0UW39IEdmJbd3arTLMTnKbXJVM/nYzxs8LfLMSw4iB/4neg1OfVmHTBzv6/Q+t6WzFSEdy1ghNiYmUamxBLd7Xo4fwOCXT7uz3IWULq4lN0zf7szgY5bNf57hUUx2e7HnoLBH7svViV+JcwfHR2sNHogZ9+qpjKbpPNfCAu9cal4GPncA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(82960400001)(53546011)(66946007)(31696002)(66476007)(66556008)(6512007)(6506007)(6666004)(83380400001)(5660300002)(8676002)(4326008)(31686004)(8936002)(6486002)(36756003)(38100700002)(508600001)(26005)(2616005)(186003)(316002)(2906002)(86362001)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnR3SFVZRWkvanNUaldLSFcvQkJqU2cvOTIvY2ZsWldtUS9wazJCOE5LMWhT?=
 =?utf-8?B?Q2xYdThPU1dsaDFDdklvdmQ3V25pOUdlSVRmQVo3UUVVVXZ4clI1UVo1SUFt?=
 =?utf-8?B?cXRkNVVRaXVVSERPOFY2K0RscjVubGdacUhxSUFNLzhHczBZQkNOMENXT3c2?=
 =?utf-8?B?SXBPcklwblV6U0VVMnNmZXBTTDlYTTMzaVBBMVgwbVB1SWxKVm8zL3pvN205?=
 =?utf-8?B?cjBxLzZYYmtzT0hFTzZvN3pKTWZTRnoxOWlRV2NMT1hYUXRyQTdIallUOHQ1?=
 =?utf-8?B?V1F2ZXJjdTVmOUVpYUV5TUNHUW81SVFDRi9sUUpMRjAzaGlId0dFRUdYeGxa?=
 =?utf-8?B?VVhQTDhnTTZMZk9tQmQrb0RtRFdyQUZIYjNZdDZidGRqTWFSTWpKNnMwbUwv?=
 =?utf-8?B?Q2VYSmoxSTR3ZW5ORFE4dDVGaWxvT2I0QXA2aHNNYzlnWGU2TTdwa0p3WEZz?=
 =?utf-8?B?WGgvM2xNWC8zWmZmK21VUE9pNUFhRUZCam12dmpDS1FaNkxwODNGTGQ3QTRU?=
 =?utf-8?B?aFoyZFpITXcwcWNVbStlRnltWlBGY3RRQUlsdEFrYk9hbjMvTDRQZzVRM1JF?=
 =?utf-8?B?SmdmSElhZ1dybVhva0s5a0pHTGd1cktHdHhNdmYzSVpjaUtxUmFXb3Boczcy?=
 =?utf-8?B?ZmxyblpNeTVsdG5XaUUvNFA2c0Q1bGpFNlJrM1FTTjNPTzgwNlN1VVQwd0pB?=
 =?utf-8?B?N0Jnb2dvdWttNXhxNkRwdVgzTWkzOEo3U3FRb3k1TlJUUjdNUm04VE1uS1Qz?=
 =?utf-8?B?RiswQ0lwWGY5OWp1TlBWeUN1ZjRIV1QwdTM4M1N1akRRZVlkdkYwbWRSMTRm?=
 =?utf-8?B?amQ3VmRBdW5rRkJIR2NsRE1NZ1h2TG1qb2dQTjN0MVVEUk5OOUg4YjRKQVR3?=
 =?utf-8?B?OW5wNW5mVmNFbTB5U01ZWkdTVXdlS3k2ZGFDaEszOTA5VkllbWdCL2pBMy9t?=
 =?utf-8?B?K1ZzV0xXK3pBSW5rUGNmTGFmdzFLSGJpdElTQjJxSllUckx2UGd4Sk94L0lV?=
 =?utf-8?B?UVRqKy9zR1YyWnRBSmJXSk1LOUhlZEg4VDZ1Wm5jY0pkMXY3dFZJY1lUYmds?=
 =?utf-8?B?aVI0R2V3QU9nZkQ4TzZ5Y3hEN2k1Tms5eDdzczNxd2lPeEVFV2ZlWWJoZjZ6?=
 =?utf-8?B?dnR4Rm5iNnpqdEdkb1JoR1g2aUxKVFlWK3ZhTXZQbDdCbkM0eXJBVFdvYlFa?=
 =?utf-8?B?Z0JlOGQ5TXV1OGNpcmxoMWwxdlhVYzk4Y2xJL0xZY3BVOHVFSktmMEZic1g5?=
 =?utf-8?B?UzlpK1FCcGhaZTdSVTREMXFYRmw5UXpiL2RBWW9GRVRWRmlveWMzaWVua2gy?=
 =?utf-8?B?VFVLNnphaU9YcnVOQVp4dVduekVXNlBWQ3hwdmtDbCtGSm12LzEwd2hqektn?=
 =?utf-8?B?Z21SZ2VkVkhGRHFxL0YvU1lVMFRLUTRPSHNZTWNRSDR2bHIwT0ErK01JTTdR?=
 =?utf-8?B?RndyaHVOK3F5cjRYcmJqcmlBZkJyK1ZnczRYNVJYbzdVN3FMcU04Y1VxazhP?=
 =?utf-8?B?RGJPaGRSaVFsUDlMR2FNcjZLRjBnUlhlWWc0WFpKZGNNeWNOMUY4VCs0UjVO?=
 =?utf-8?B?SVVzYlJIMldPNnUxdis0cm1CeWFKeGJoVDdoYXB0a1AwMk5rSVVWZUNJN091?=
 =?utf-8?B?YUdHSG8rTzVoWE5IQjc2bGxJUjB6emJrRU9Ra1dGeC9YY1prQ1U0WE51YUhi?=
 =?utf-8?B?Um9vbmx5VHdvQkxDVURjMkwzenl5VXpid3J0L3ZXSDRDZHlvMXNIeEFzTTh6?=
 =?utf-8?B?dU9SeTFpaVJSL1FvYXYreCs4ZHlhQVJQMnMzUGZGN252VFRiQm8xcTdMKzF5?=
 =?utf-8?B?YzZtRFJQVW9MVVU2dXFmbGtMQk5nT1RhUG5PM0QrRyt4L0RyanBEU2pUazht?=
 =?utf-8?B?ZVRLR2VFOGhhT2M2NkppTW5sdTRsK2lrOVQ0bG1hbFRGL1pYL1dYZjdpS0V3?=
 =?utf-8?B?aVhpUEJwYXF5cVVKd1ptN1kvOTZoLzM0Z2NoeGtnWEw2ZEhmbU9Ud2YwVUQz?=
 =?utf-8?B?UTc4L0JodDA5TllhWE0vZ0VJK3cvemhteTdMbGkxQzIwc2ZoR2JkVkNweUZO?=
 =?utf-8?B?UmlMOGNZbzlNTTMwYmUybytlSitIRDBrTEpjSElIRFZSWW9aNTRWdkpUbGZv?=
 =?utf-8?B?VllHTXB1a1MzaWQwdVdWTm8vRnlhNncxMVdtM2RJMkxWSERwYzhwcUdNVUNx?=
 =?utf-8?B?Wm9qZi9TMGdxMTlHMy91bVFPZmZBYWJtSnFIM05zWXJNZEVWYzZjT2tra2Er?=
 =?utf-8?B?d21Mem5kQW1UY2sxQWM0cVJJb0FBPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 223dadf3-1708-4f42-ec46-08d9e29399ed
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 19:23:02.2711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: js4Brs8Vc+sBelM2iqPT7V2ZRNQLmmZ3/v8ODQPvAJZTp5gtiG3nRTl37RXjpN0RrbDZv/+FMCIPuibMbwQOd7cZwc8HwQ/tYyV/o/hUE44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4044
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Dave,

On 1/28/2022 10:43 AM, Dave Hansen wrote:
> On 1/28/22 10:23, Reinette Chatre wrote:
>> A segfault is encountered if there happens to be an
>> early failure of any of the SGX tests. One way to
>> reproduce this is to remove the enclave binary
>> "test_encl.elf" that will trigger early enclave loading
>> failure followed by a segfault.
>>
>> The segfault occurs within encl_delete() that cleans up
>> after an enclave by umapping its mapped regions and closing
>> the file descriptor to the SGX driver. As integrated with
>> the kselftest harness encl_delete() is called upon exit
>> from every test, irrespective of test success. encl_delete()
>> is also called to clean up if an error is encountered during
>> enclave loading.
>>
>> encl_delete() is thus responsible for cleaning any amount of
>> enclave state - including state that has already been cleaned.
>>
>> encl_delete() starts by accessing encl->segment_tbl that may
>> not have been created yet due to a very early failure or may
>> already be cleaned up because of a failure encountered after
>> encl->segment_tbl was created.
>>
>> Ensure encl->segment_tbl is valid before attempting to access
>> memory offset from it. The offset with which it is accessed,
>> encl->nr_segments, is initialized after encl->segment_tbl and
>> thus considered valid to use after the encl->segment_tbl check
>> succeeds.
> 
> I'm thinking we can be a bit more concise about the problem:
> 
> == Background ==
> 
> The SGX selftests track parts of the enclave binaries in an array:
> encl->segment_tbl[].  That array is dynamically allocated early (but not
> first) in the test's lifetime.  The array is referenced at the end of
> the test in encl_delete().
> 
> == Problem ==
> 
> encl->segment_tbl[] can be NULL if the test fails before its allocation.
>  That leads to a NULL-pointer-dereference in encl_delete().  This is
> triggered during early failures of the selftest like if the enclave
> binary ("test_encl.elf") is deleted.
> 
> --
> 
> I think it's also best to refer to this as a NULL-pointer problem rather
> than a segfault.   The segfault is really just the fallout from the NULL
> pointer, *not* the primary problem.

Will do. I plan to resubmit with your changes and just also append the
paragraph that documents the fix.

> 
>> Fixes: 3200505d4de6 ("selftests/sgx: Create a heap for the test enclave")
>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>> ---
>>  tools/testing/selftests/sgx/load.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
>> index 9d4322c946e2..006b464c8fc9 100644
>> --- a/tools/testing/selftests/sgx/load.c
>> +++ b/tools/testing/selftests/sgx/load.c
>> @@ -21,7 +21,7 @@
>>  
>>  void encl_delete(struct encl *encl)
>>  {
>> -	struct encl_segment *heap_seg = &encl->segment_tbl[encl->nr_segments - 1];
>> +	struct encl_segment *heap_seg;
>>  
>>  	if (encl->encl_base)
>>  		munmap((void *)encl->encl_base, encl->encl_size);
>> @@ -32,10 +32,11 @@ void encl_delete(struct encl *encl)
>>  	if (encl->fd)
>>  		close(encl->fd);
>>  
>> -	munmap(heap_seg->src, heap_seg->size);
>> -
>> -	if (encl->segment_tbl)
>> +	if (encl->segment_tbl) {
>> +		heap_seg = &encl->segment_tbl[encl->nr_segments - 1];
>> +		munmap(heap_seg->src, heap_seg->size);
> 
> This probably deserves a comment linking heap_seg->src and
> encl->segment_tbl together. They _look_ independent here.

How about:

diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
index 006b464c8fc9..946eb7c2a253 100644
--- a/tools/testing/selftests/sgx/load.c
+++ b/tools/testing/selftests/sgx/load.c
@@ -33,6 +33,14 @@ void encl_delete(struct encl *encl)
 		close(encl->fd);
 
 	if (encl->segment_tbl) {
+		/*
+		 * Most segments form part of the enclave binary
+		 * and have their mappings deleted with earlier
+		 * munmap() of encl->bin.
+		 * As a mapping of anonymous memory the heap
+		 * segment is separate from the enclave
+		 * binary and needs its mapping deleted separately.
+		 */
 		heap_seg = &encl->segment_tbl[encl->nr_segments - 1];
 		munmap(heap_seg->src, heap_seg->size);
 		free(encl->segment_tbl);

Reinette
