Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFC94A0168
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jan 2022 21:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344420AbiA1UIO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jan 2022 15:08:14 -0500
Received: from mga07.intel.com ([134.134.136.100]:52850 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236700AbiA1UIN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jan 2022 15:08:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643400493; x=1674936493;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uCGpYgyHUsAfWJMz1GZoMd9MTaebvCqDp65g+jN23xs=;
  b=KP5xF3Xb71F1GxSSb6MN/HsW8yn8/mbMavRoWNeVdGQcmMjEPUzvGsCa
   NeBgjGzcLUSP7NOpJa7nsqqqLUYXF+klVSJATbf1SZWN8OGTZ0xQkLIN7
   PjhmFpMjt9X8Yu+kV02ffMTlm2FPIqd+w1ITIBcq7K+1NcSbNFwfcWJuG
   n4tc60PJmQRR4t2hyMwkXh+YwFTP5Gdg30FBOdTjffqspZBq5eqPGfymh
   E5ou2dltOYnforDLbHtcZBiS7Lo3KiMkoEKu36yzdxJhnpuDDU/D3HnRR
   LW5jt8KgxAKeiXuVh6OeOSfN+MQ7hYzl4lnfqVDjyVvOBkk69BMQa2Qzt
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="310503413"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="310503413"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 12:08:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="564302821"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 28 Jan 2022 12:08:13 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 28 Jan 2022 12:08:12 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 28 Jan 2022 12:08:12 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 28 Jan 2022 12:08:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9oj0Ov1ujIT5sDuswJ/q/dzh2drenk9++r7WjKARnB950M7XwbB1qdvX+q8o4H46ONSumJvIdVN9dNsklMuYRtPLQhn3K7Lyc+JmlTrK9vF0Mtb6BOWKDxa9+KHsgxOggU2V7kpf5XyUoi/4C1wBUuCEhXIL6fvohZJYXyrkml2wgsauJB7QXCEqtT8vxX3/1WT3UpzVViB7555ncP/0X6KHYSr5/1+H771gk6Oyxq0zr3p9kdATDfdE1tqOjDvoHptqm8D9lOd6Iy3pDUQRKIgMTsVJ50MAg2YaD7uLSNEnYeP2oeKZw4dq6N3AZs6g6AapfqVQVsBTQeqcch7Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGcQwOw2v+1LjSraHWYYjUhjVGqXgJubhdh7+BTkuK0=;
 b=jMCKR07IZjDaSepCUg3haxWNJ1BcPQ7181/jUM4FrIbwtsS96rVV9z+DUN0kMz7EOj3zYRodCyIcSWcKiSqyh379s4et3JmMK6GydCeQVArhO6HNrvGYmXVLdcnGhaTp4Osnue2RVSoxrKOG3k7/CWom/EfFSsAJTx/jUpV0rX7DMRz3/04FMhBRoj6/GbzBD/vuy9vIG/l6MkRAWKixs03MBW+MSxrLhesPyGsN3heZh1y+keCNDjk/+znFQzSdhKb0Ixg6GnEFF+Zm+Ti3UI+WDd6x33bIhEZ4x6D8cK73JHNXF0tlCIu+Sm05xZWQHKroylPTVI7wRAUZC4cyGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by MWHPR11MB1504.namprd11.prod.outlook.com (2603:10b6:301:c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 20:08:09 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0%9]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 20:08:09 +0000
Message-ID: <d2a34b98-3a81-fa59-1fed-cf7d0069d220@intel.com>
Date:   Fri, 28 Jan 2022 12:08:05 -0800
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
 <8993eb98-ae1a-9af8-353b-e13895f9804b@intel.com>
 <35d888c6-ffed-fb89-d02d-8c7ef15cd902@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <35d888c6-ffed-fb89-d02d-8c7ef15cd902@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0347.namprd03.prod.outlook.com
 (2603:10b6:303:dc::22) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5ef7fa5-17c6-4414-b8e8-08d9e299e76d
X-MS-TrafficTypeDiagnostic: MWHPR11MB1504:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MWHPR11MB1504124F347AD4D8688E174FF8229@MWHPR11MB1504.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q3qVu7J0seXjseeK/LfhcJsbrlUt/aaa+CiSr56FvmDrfNLsxv9yPIfshuTb6qFu9j6vwZdO7UhOI+//0uCuTfO4nHL3prQiAOIZa1yizzAEXEv5wcgfGO/Idm8vhvzl8vO0bpcXDNqJWUzwLxnUG+nMZaB0lgxoZahAEAFhH0HUqn1JV5Mucb+CJjT0hJAAgSIm3iy+0Z+qwoUOT4Sqg5S3iXM9j0XLGwPYsqPzferk6zZB2tviOcZ/bW+n5GDHJ8/Ij2nVGYSCWRsGzhozI0o7v32j3dFM1jkEcofpYd3pgMS0hAPh0mfKRaRBzGMhEZOGU9b3pfR3WJtg4KNv/KCkb/Zaykg5b8GjvIExw9IT0sQVX1BVgNOcXZ4AZN59xAezZ4tZVZNX5ghcjko+voSOprhbub0lQducbTNHBkCttXyuwKLCgM+U+Ocb8a5RyAR+7gA2lCQdkr8wxkZPRINgq9wksFdx04ZUuYpwvTZ6ccEu52fg4+jddVkobXCCH0JA6kR8Ne2FCzGPyZCA9AOP2xLvy7oYCO8r+BIPmJZRbncQvK3+WLYU4QIueS3OPIWOCbxNfpwu7vVZ1s6DZAAhXg0RvuxReXDh7rggNsVV701Grti5LRFXDwYzsgVTSitieQTL2SShhndWJDpUizwZXKAwP+5mKNhDcU+i+sNRvoeJSUzF8Qinze1FTQZlcYrDhgw2gqGKtGrQJdl5cIYEeJWfPHimBkHBhoLLg4KqdqElUUkO/zCN4paB4ASe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(38100700002)(44832011)(86362001)(2616005)(66946007)(26005)(508600001)(8936002)(66556008)(4326008)(6486002)(82960400001)(5660300002)(8676002)(66476007)(36756003)(316002)(83380400001)(31696002)(6666004)(6506007)(6512007)(53546011)(186003)(31686004)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1dFL2hwdnJIVzN6QnBlcDc1Ty9zVDI1WFNUSk9vVGZwL04ybnphbDN3T0VF?=
 =?utf-8?B?OUFrZ2hwT2lhdEhEeDBxRlI3d2p1S0YyNEliejdQNlV0bDJ2NHBtSDRSbTlF?=
 =?utf-8?B?Yk8wSEJzZ0xlTzQySlhqRVNUbXJCWHRvL2dRVSszZTltMHFYa2pJOHphUzMw?=
 =?utf-8?B?Sm5LK2lRUVBjYjB1MWVvdXFBL1lZSW9oY3dGUzJsM0lzOXdSWUNkRDJQK0VT?=
 =?utf-8?B?TzN1bXU3dFEzTTRWZzFEQ2xyUUQ0WW80WGo0eXVNRnR4UmlSRExoZHRNMkdy?=
 =?utf-8?B?cC90Y1RxaHRkV3VaNHlhandwUXh1S3VJelBLWkEvVHRUQ0gzaWZRUmcxYStY?=
 =?utf-8?B?OVk4MExJdEYrOTVVNmVFQlpOeGppYmN1T1RyZHdlbzBnUXd6ZHNtY1BDUC9W?=
 =?utf-8?B?VHAyM1czZEZTaVl2eHlsdXhqdDB2U21ocTdZR2J5bDhVUFJmWGVRVmVFWTZw?=
 =?utf-8?B?OWt1TjIxemhEVGRHU2F0NFZvMHo5MzU0citGbUlBQ2grZXVsSjdtKzFyMjNU?=
 =?utf-8?B?STk0TlZFRmdJNXdpd2lCdzAxL3Nldzg2RTdONTFpMWtwcnp4RjFNV1dmZEJR?=
 =?utf-8?B?THNaVlExS2hIOGg4UDFOSFV3UVhNMU5Pa1pMRnFReDNSN3RQSXBSdjUyZTcy?=
 =?utf-8?B?Ni84RzIyQm1ndkprNnNPT2F0VkpRd0RXczVod2hpd05jT1dReFNiTTM1VjVM?=
 =?utf-8?B?eDIzc05SYUYvZGNncjdPM2JRQVExOXZWaXVwMGRXa29QM0VKNmJxTWZlazNN?=
 =?utf-8?B?ZjMyYkxIU1Z4cDZ0WE5Db3VHajBXNm5yNFB2QndaOGF3RXNsZWpUSXRla1pn?=
 =?utf-8?B?MllzTXUyY091M0tacDBTczFhZWgxT0thOGdPQkE5ME9nS1h3UlJEcDR3U25F?=
 =?utf-8?B?ZjRXOXFGU3Nod1I0S3E5ZDFwTVBYMDlzMnNyaUUyU1JlcG8xcTVRV1NiSmtm?=
 =?utf-8?B?QXRBMHVWRzhFcys2QVhSc0RVRnl5Y29TRFBpWWZ6QkVjcEdSQ1Vka21vc1U1?=
 =?utf-8?B?NWdUNllmaHFydHl6U05yaDlZL1prdmVhOUNVN3JFbk5FYyttVW9rejU2TXV1?=
 =?utf-8?B?bjlkdDMyOG90TDBjZ3EyaW5pNG5rRVJIMWIxdG5uZkpKWWdlVmxkU3lieURS?=
 =?utf-8?B?MnAzb0xnSVVqa0g1THR0ajQxUk94YkkvbmJnN3ZwWEIzV2lBTWE5QU51Q0Vn?=
 =?utf-8?B?UWlIVzFPVnBNMGdheUJiaE5FMm85VHVWUGVQOXNzZGVlUjJXcGhJTUhyajc4?=
 =?utf-8?B?WG41Nkd0TVhOcHJ4ZVZKL0RQMmIxTExydFBUaTh5K2pvanQ1U2U1UjhmdkMr?=
 =?utf-8?B?MWw4dVlFczdCRzViU25sYkZYa1dDNFh0RTBZTFRCWk50eENWZzhkb1Q1MXNi?=
 =?utf-8?B?cFIwVEliYVhVMzFKLzJZcmpNeE1xSTdxM3AwZmN2eFRiU0FXVEYrT1Q5Wi92?=
 =?utf-8?B?T1dOci9EZENHck03UWVDUTRHQ1FXK1FocDNBZGYzMUJTMWRaMUpZTndhY1Vy?=
 =?utf-8?B?WHpJNlo1VWpMR3l4MFJucHVLT1RlMGZROHh4WDJ5dVdTUjNPKzdqeGZjOFl4?=
 =?utf-8?B?VFEvVHJDZ0N6ZU9QSzBKeTRkSEIvN0VLSXZxQzkrbFJadnM1SzlmdTV0M0x5?=
 =?utf-8?B?MUZId21UREV6YUxlaXJLWmNVM3RvdHhOQTlGS2NLT3RGbWFqOS9XellNNTdr?=
 =?utf-8?B?ZU9xM3ZjNXlXOVJJbms0NlN1UTkzRFd5SG5SbGsyYTc4eXA2Y214ek0rOTkz?=
 =?utf-8?B?RjZEc25qSGFLM3J5L2FQU05yRjNibkZJbU5CNmROOVp1NHlaaXFaMDZSNXhP?=
 =?utf-8?B?Y3JRdzBnZHI4M0J2VThUeTg2NkZCU0Q5S3FlMm12a3RnWVJnQWRzRm5GRW9j?=
 =?utf-8?B?MmxsSWUvTlNTU29lVTVmb0ZVU0grRTkwb2FDcDBSTnViU3VBMzZEYUJHaFk3?=
 =?utf-8?B?ZUJodTd0Ry83SDRMd3Z5Wk1qSDhNZ1B4dUQwRUUzUHplRzBQUnlKSWtqTmhR?=
 =?utf-8?B?YWJXOFhkK2VzU0VGOTF0SDBsYjREQU5nL2drRkw5Q2VJSmU0ME9VaTlJSkg2?=
 =?utf-8?B?SEpxYmFyZ3FrV1NZbTlKem9FRXdhN29mMmxQVEZlZldBWGdyZHdqVWhGbi9H?=
 =?utf-8?B?WVZNKzRSNkhjazlEMjIwVUphSXFqVlcvT2lYNE1zT09VRHI0NnVlRlNPYmdN?=
 =?utf-8?B?dGRISjZSTEY0MUdPM1RGL2UxYjk5MHYrdWNDKzFXYm9JYittSDdSR0Y0ZFdz?=
 =?utf-8?Q?wkRddwUsgyFTFu7CHBQWGaiV4jTNux2RyK6yqYRL7E=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ef7fa5-17c6-4414-b8e8-08d9e299e76d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 20:08:09.2580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+bU9WvsiZtHnKSqkAiIY0JV/svHfj8uqlKda02+s7ZY8sOYAwdLzb1okcsbJwqXhcAViTHGyK48wBp+oOXqxXIWSifdW+WD259Yl3WECo4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1504
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Dave,

On 1/28/2022 11:26 AM, Dave Hansen wrote:
> On 1/28/22 11:22, Reinette Chatre wrote:
>>  	if (encl->segment_tbl) {
>> +		/*
>> +		 * Most segments form part of the enclave binary
>> +		 * and have their mappings deleted with earlier
>> +		 * munmap() of encl->bin.
>> +		 * As a mapping of anonymous memory the heap
>> +		 * segment is separate from the enclave
>> +		 * binary and needs its mapping deleted separately.
>> +		 */
>>  		heap_seg = &encl->segment_tbl[encl->nr_segments - 1];
>>  		munmap(heap_seg->src, heap_seg->size);
> 
> I was more wondering why the status of heap_seg->src is tied to
> encl->segment_tbl.

Apologies but it is not clear to me what the concern is. Please bear
with me as I first try to create some context and then I hope to
navigate to the issue.

The test creates an SGX enclave from a binary, in the test it is
named test_encl.elf. To create the enclave the test loads the data
from the binary and populates the enclave with it. In order to create
the enclave correctly the binary needs to be loaded via its distinct
segments, initially this is: TCS, TEXT, DATA. This is done to ensure
when the enclave is created it is done with the correct page types
and permissions. For example, the pages from the TCS segment needs
to be loaded in to enclave pages of type TCS with RW permission, the
pages from the TEXT segment needs to be loaded into regular enclave
pages with RX permission, etc.

To ensure the enclave is created correctly the test thus initializes
the data for each segment that will be loaded into the enclave into
that enclave's "segment_tbl".

struct encl {
        ...
        struct encl_segment *segment_tbl;
        ...
};

/*
 * struct encl_segment - parameters that needed for
 * SGX_IOC_ENCLAVE_ADD_PAGES ioctl()
 */
struct encl_segment {
        void *src;
        off_t offset;
        size_t size;
        unsigned int prot;
        unsigned int flags;
        bool measure;
};

Commit 3200505d4de6 ("selftests/sgx: Create a heap for the test
enclave") introduced a new segment, the heap, in support of more
testing. While not loaded from the original binary it is
considered a segment of the enclave and needs all fields in 
struct encl_segment in order to add its pages to the enclave
with appropriate page permissions and flags.

This is thus how heap_seg->src ended up connected to
encl->segment_tbl.

Apologies for being long winded here but I hope with this we could
narrow down where your concerns are.

Reinette
