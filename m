Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECA64C02CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Feb 2022 21:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbiBVUGM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Feb 2022 15:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbiBVUGL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Feb 2022 15:06:11 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C70F210F;
        Tue, 22 Feb 2022 12:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645560345; x=1677096345;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vCsm5bleSPaBJf03+hbtcQWg6zMrhfHguWyCt5Lyl5E=;
  b=c+UKFcN26rN8Wob4JkR2vOW0UOpjFGFd95Hf6qOcJ7Ou0OsbVP2Qj4ZD
   +gs4kmcmSfL05PfWs0dk6/gCEOq2m+w8p+AJydVRrNBvvS0F6tPGV+JOE
   JG86s83sUxPydKge/Epws+JUv4K7LXHQcl6hHwZmvkrULjgRROuvVvZGc
   fkqlE6RJ96ED9BZxKp0au5sShfPg7STvTjTyyWhtcSlx0GppOFfaQAO0U
   klLVJreLfu70N9SVv6KZLCCcdsmIbiadIKMP+czi1eH6uJHdUkIDIodD1
   4NFYcv6IiZ3kTACvSHHemJreekhxA5lo08QmPLLJyShFKrAHn9IkYrG4L
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="251538240"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="251538240"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 12:05:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="505657666"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 22 Feb 2022 12:05:43 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Feb 2022 12:05:42 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 22 Feb 2022 12:05:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 22 Feb 2022 12:05:42 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 22 Feb 2022 12:05:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dStOWYNkBy1OsI00AXSuYaFMdkkS4vYN2T6aaFBMYIl5PhAvseeCTH81N2GAmIF9a8DmVXjHHdwXQouP4KCLrelWz72TNUhqzXDE/iZcFXFtKuhIbw/bs6hBUqfg0I0OFFodC/YLMylFgtm3Cnd2OPIkVU+78qLJ22mKxTrJWMvKy4ezli8d76oWydoYDc2yiVMwmYBSh2DXR9zC8IxjR6jVNDMoy6xRrvFDYBdOcNtWDMaY8e8NDQIGK13pFItSgTZtXX1JKl5ogep8DTomgTHJv6vcxHC6EJfpQJH8XfETQhYToDpHhFoNGKyoMGyMkyeZjnX84CxZOO9ljY7VaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0LOWeZ/AQRVC5abVwYb1txKeO/Nwk4kqRXc1SAGsb4=;
 b=lKI5J7FLIQ5CYL55i08qFyD2dRpsra9bAevdvBUwSkRk9UnRmkt8uGBvqk+SbuDn9h7kAZFaPNzHQzFpD/pSqRjVlwHWJeZeEGeLT0fVI42PGNLflTgHEHLVwW6KFGPbDsxufIdUAFL7swjhwTgjdC5QEqVJyHqDcPds6A1Jj+ejCfRoGYeo5YPZieWDDywXKZV4VaAf/miLlxDrT7MpS+IU196oFeqdBm2M3oY6ZYHRQZKHr0KUTHV+T8RB30InxI8H358oQxvl4UXPa34uj/xsCyrTedUKKzcxFOZHBtvzBiZqLfWuYuISZ+hIOf2SXUFtMz8IJQSV+22bdOn7HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by SJ0PR11MB5772.namprd11.prod.outlook.com (2603:10b6:a03:422::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Tue, 22 Feb
 2022 20:05:38 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774%4]) with mapi id 15.20.4995.026; Tue, 22 Feb 2022
 20:05:38 +0000
Message-ID: <8defd54d-1263-07b8-a117-c298903cbe27@intel.com>
Date:   Tue, 22 Feb 2022 12:05:34 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.0
Subject: Re: [PATCH V2 1/4] selftests/sgx: Fix NULL-pointer-dereference upon
 early test failure
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <dave.hansen@linux.intel.com>, <linux-sgx@vger.kernel.org>,
        <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
References: <cover.1643754040.git.reinette.chatre@intel.com>
 <89824888783fd8e770bfc64530c7549650a41851.1643754040.git.reinette.chatre@intel.com>
 <YhKePZv8tsgKYGfK@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <YhKePZv8tsgKYGfK@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR15CA0067.namprd15.prod.outlook.com
 (2603:10b6:301:4c::29) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa852c21-7779-4c49-861a-08d9f63eb18a
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5772:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR11MB577267B9926B03BE23CE5C75F83B9@SJ0PR11MB5772.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NRmq/KvxY58oGiE/r9zaUXQFlrEjmz9HDXMWjgMnD6Qt9ziGg+/Fy9F7U+xalNx+Lf+iOve6gGqvFRU3xO49iRiAQxW7+L1QLpGmloRxwdPTt0xG5Gs259lJtdLNM0cWig5lJ28U8ULMljVwkTSZVfBhNAP1lbuWcMajF7bWtNgG/0JrjUNhu5bH0qFD00Hlp9dz7zZ6XM6/pbprvl+BUiso7r5u+locBcNYSJ9CNuz9R92PnNxA4PkFM9kUhjdG9YNaSAeU3Ydu1S4rbpLlZTG4C3I7A969sLT+UX/9zw9Sp/JgA3tYXX7DqTUnuCgYuLyxaA/+2QA/lLDn9+KPCDGsoRi4G9/95D37GAEXEwhXUkilTqG70YmOjJxTW+4UIP4JfRCVWSrbY2x+bXKTqAKtP8oNWxrnJ2o4gDfpC6l2m6pG1BnZQuadRt8G5n6seobKady4o3Ada+ggGzx/jDpkF8HS4NEYELn5wFO6Esplcv9ZXF8xtmpPIxfj4aIUvIqK/2dBmIf1zw6UtGOGgfu6kub04U+uqtTc6O05EFj3GUyT1Eetb7odYbMq8cD3UETBIavibarlqNNKdqBrUI7JRPNr/l54hbOt7Yd2JXBIDBYTy056nCA26B5ESjdvqasSTZyJhIsBlhCJ6rBtKXxctpMjEN6qxVvUZFbMEDp35edKwR9NnPpOyhI+dBH0qEHKs/iq0vMp0s3aj66sBHJ06bj79/GbcC+rBj15hlp0d+WeDruCOcHjOLUMHk3Ld71B1nvphbqjMzUQvQkHslNaqW9/pNCwMZ/8tqpxlveGW9Mg+ZsteREnk1HRAn1O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(2906002)(8936002)(966005)(66946007)(66556008)(8676002)(38100700002)(6486002)(53546011)(6506007)(6666004)(508600001)(4326008)(44832011)(6512007)(316002)(5660300002)(86362001)(6916009)(2616005)(36756003)(31696002)(186003)(26005)(83380400001)(31686004)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnozazZwL1czeDViZXFqRDZxQzVjcnZHdVMvcU8zVWtWWnFpVlBaN2NSUW05?=
 =?utf-8?B?NU1Mam4yb0M2SFNDWUY2dG9Ib2MyVjhBQkhNUFE1ci9CbDR2cTZvWjl2UkUz?=
 =?utf-8?B?SzlPcmpnV1FPREx3N1JhczQ3dlhiQlFFQ1RZRG0rbWdWUk1UUVBJaE55SllR?=
 =?utf-8?B?Q29PQnRHWHlqSXI3b25tZ2hyb2t2Qzd0UUlUa2NlYWdzeGFuNnZSeU11OGdo?=
 =?utf-8?B?cEJpamZMYlJDVDRCeS9MY09La2YyYmloK3d5Tm9uQnN6RHZ2ejkvaWlReTRH?=
 =?utf-8?B?MTdPMWo3NU9iUG1yMitDaVRtM2pDQVlJTldhVkFoOHk3MjMwTUxXMzF1VHpW?=
 =?utf-8?B?RDJZRWdSY0lpdFl4VTVRRHBIb2JjY0Q2bEtwd1NGZFBWWS9NQlovcXBxenYv?=
 =?utf-8?B?MUFMeWIvcEhzajdRNVBPOGxsTS9CSDFmQ3RweFlPN2JreVo4OXpYSHJOUytM?=
 =?utf-8?B?enIrOEJ6SW9tcUFySlJiWDZpS0V0OEVTSldJZ0YwM0VaMnJFVE5sNHZaQTBz?=
 =?utf-8?B?Y2VNckFJaEtTdTFEemRDUTZLRHpLU0FJdlZKS2krZ1g3d0lwbkh5MnFnL3Rx?=
 =?utf-8?B?Q1gxdU52TnpHRnNhZ2cwWk1YUzY4SkZkMGlaSkZrUUdFcmVtanR0QU45ZFJC?=
 =?utf-8?B?WjNxM1B0ZFQ1MWZYV2NPMGI2bnBJUllvT1dmUWhoaFNsaGVEcWFDUUN4cTUx?=
 =?utf-8?B?LzlKOWF6dmZCT3BmKzYwNFBkQk1rdjl1Si9aeldwY09FT3hHVkRTSll1MW0v?=
 =?utf-8?B?Ung2YnYrT1NvREtHR0ZLMitvbEJINXVHa1NkbjdkWVU1MzhJRytEM3NyNGRk?=
 =?utf-8?B?bThES1ovTmdqT1I1UDQySzdueFFWaGk1VW1hUjg1bDN1WmliTFNkektsNDZV?=
 =?utf-8?B?alI1WnZnUXVVYVNpUHdrQkZiQWc2VmR5S0p0bU5qYXlxMC9rZ1VtbXhoUzhL?=
 =?utf-8?B?NDNUcFllNUh2clRaSUwvN1UxdW56WHBTRFNVUU11MmY3cE1iYm9jN09aSDhw?=
 =?utf-8?B?NFhKZWk5Z1dTMTcyQlFTTXlFMVVnTzVyYkJTV2F4YjVDMXNmU1JRd0N2ajFr?=
 =?utf-8?B?QWMycFhwU1dIZmo5L0JZTXRQcnhRUVZPWFgwWWlkQVNPWnBQM2FIRWtvdzZx?=
 =?utf-8?B?VHZxUTd6N04wMzJUODZGYW9HUGdQYzU3V1dKNVA5ZDA1ZGZQNGNSOHRPNHE1?=
 =?utf-8?B?cVVpSEJYRmF3dGppUGQxS3J1WnZYWS9keE80UlRzZ1dEVnFuYWN4OVhyODhR?=
 =?utf-8?B?enRQdXh6YU82MTBiaC9JUisxTkl4RUJuMFM5eU1VeDdMVkNYSmhKWWEwV2FX?=
 =?utf-8?B?YnVhNHNWbElyalNrelhIeW1CUnZZNTFPa1hwQ1RiZEtiUXROSkkrZExhczEx?=
 =?utf-8?B?eEF6cS9Ia1BVOUErZjJmcXlGWXVVRlhhUnpyNy9RdlpXTEE2cVcyYXJOQUto?=
 =?utf-8?B?RDVSdUE5Z21YR0NWdGpON3ozUWR4TDdCUkVHcEhVcENGRWxyTkE1QytTbU96?=
 =?utf-8?B?bTMzaEN1NUpadXZpWW9NeWlIdTVBZXMrMnBjbVJQQlkvSE1wbXlydDVyVzl1?=
 =?utf-8?B?cGIvMzduczhzamlnWFNmZGJPclRsS2grd1VodTJrc0dmWGtXYW9mUGx4YXZs?=
 =?utf-8?B?M09iVUh6T1ZCZE5nVSt2blpTOXBidk41VHhyVHR0QnhlL2hiUEdUQ0JQeTJR?=
 =?utf-8?B?bDM3VWN1MXRVZ0dwaEMwUy9rc3dJdCt6dFRjSjM4V0pDY1BMZnVaNUUrMS9Y?=
 =?utf-8?B?eHJnamNFaWRsSHJJbVlIOXIyMDFHcUdobGRSLzBUQlhUU1luSlNoUTlGT3Aw?=
 =?utf-8?B?czNYcTl0MUFnRHZBMnlmLzRVQlU1SzRiTk9manRNaWMwQnd5UUtCSGRtUmN0?=
 =?utf-8?B?dU1YUHpraGRKMWlqRVJvN0YzU1FoT01SNUlFWTdrWFR4cUNJRmZ6SGlxdjZJ?=
 =?utf-8?B?V1V1Tk9vdzNFVUF4WWY4TW9kOVFGU28xUXBBdDRIY1pJWi9UWGJFYjJqUXg1?=
 =?utf-8?B?bkFZdi9XWGhPbkMrckp6eHpjQ09NeFhyZzBBb085S09sc25tZ2V5dVFKMlE2?=
 =?utf-8?B?OFpKdVFObWdEVDdzd3BVUGlUaHhEMjAzby92NXJHMVdsN0hLQ2E0QnVLTWdU?=
 =?utf-8?B?VEtvbHVvd3F2SlNoUHBsdGhZa1NGYi9OV1o1SEF3Vnl1c0htTnRlV0FGZXNk?=
 =?utf-8?B?T0FzTUxRT2dwdGliekgveE94QmdKSExPVG51WWNHWXc2WDlwb0M3aVZ2Q0dG?=
 =?utf-8?Q?TwhiXrJY6RvWs9bDFezI3SAf966cpCw/EjD6CZlTzE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa852c21-7779-4c49-861a-08d9f63eb18a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 20:05:37.9342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Axox1QFjgdul8+kzE53ruFjme7JehR3pO3MopZWZzwIXLpKX+dtbS+bPbpVyfAPKTNIeTmv78QYv9vdMpW6jCYZVnPKYzDdEv/g79TyjL/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5772
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 2/20/2022 12:02 PM, Jarkko Sakkinen wrote:
> On Tue, Feb 01, 2022 at 02:47:03PM -0800, Reinette Chatre wrote:
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
>>  		free(encl->segment_tbl);
>> +	}
>>  
>>  	memset(encl, 0, sizeof(*encl));
>>  }
>> -- 
>> 2.25.1
>>
> 
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 

Thank you very much for taking a look at these patches. 

V3[1] was submitted (8 February) and merged (11 February) onto x86/sgx
before I received your reviewed-by tags for V1 (15 February) or
V2 (20 February). The merged version thus does not contain your tags.

Reinette

[1] https://lore.kernel.org/linux-sgx/cover.1644355600.git.reinette.chatre@intel.com/
