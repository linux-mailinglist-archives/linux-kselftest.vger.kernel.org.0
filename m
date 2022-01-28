Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7656A4A0109
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jan 2022 20:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350976AbiA1TlB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jan 2022 14:41:01 -0500
Received: from mga17.intel.com ([192.55.52.151]:31187 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343920AbiA1TlA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jan 2022 14:41:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643398860; x=1674934860;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xakROuQoXfyQVAjw7fDhEJkaD8EIKNYBv5RONIMskPE=;
  b=nu7ylVE5FCLvap33USLx1WglA99cFUKwjC6MoWGioCvLcOCXeVPxaQ22
   j5ONugBitJNHsmuZXWsmx/eG9cbD/divy3mzJteWB5/ieo1H/iAuz4wow
   83/EUiEkLWeOXGofDfB+p+7kGqgPvBaWq/IfvrC1Sx+NsbUnqQDsGIcpq
   d/YBYAxMxbYi0mv14Tu++u0OH6dURWhUwE2qgnqV4i6rtUdDQS6XCz2XV
   oAhEORU5opJ7GlYEwBwTdUiriX6T3mwZm7BHUS6gBgzcLo5tZKEjo0t3k
   NztgrRW3wx6lMo6K7B35hMVNQjRA/flfhTGspQEvxDU+SRbeAQycK5QIm
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="227854765"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="227854765"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 11:40:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="478391464"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 28 Jan 2022 11:40:48 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 28 Jan 2022 11:40:48 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 28 Jan 2022 11:40:48 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 28 Jan 2022 11:40:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gP2c1slT/JzyyUysdyTrUx1QpP2FM2GEkhy+1MaSN7VWXMceejXV0i/jYea9MkFiwVUXUHsYt98uxWEgQkEaXIWki31vB70Si2nfvbl7k9CK3LaAnKFZ+YVJA0Es8qY92I3SmH94wfswptUIc494WefEo30/g+TmgDrXU0YtCQ4UPhWbZtXGht2tFrKb3bdpPPoYZKzUKInjCb6qO95VKHbD1BhMjDY2mBn3wTT/XbMdq0M2bZcYAlPyalgbI0GkOP2b4GuGJ+Yz863U1NNMajtsg0YftCRI3wjHpjSplvoygL77UC12d7cNd72MCX1sXX4Uteq0cEg6ClBzdkmPfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rf5gZ+1f3UgtyjatKMsCxa6OibCk9F/9kRhn18Rd+pA=;
 b=mGqTPduI8+p8qftmnnBCU+Eh8bmK9T/O0C/V/voh07Ik3azf6/g71igkW2GhtVLe74t/UcdTm/xwaXUhqkUf7ukP7tNE9h/JUpCitWcePKQCnmhBmMHp2InxGQmY1deIqts7UM2OOH+g0HLZqFh5BZffDvcuPFcOoCGQhCiht24ns5la9hlNkd3RE2htjiZMqltG5tn3foexF9+Thu977DJ9WdDzoCRPUUPAWbcatsGKYBWVjxzBSQXhrtZwirxTeIMm3eRbyYvwQb9jyScRIKvPWU+TzahG1GLLjl8K3CKfZ6vtZiocgPzKVnd+Vgvq3wu8JxEiLmuI8kzScUMn5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1524.namprd11.prod.outlook.com (2603:10b6:405:d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 19:40:46 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0%9]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 19:40:46 +0000
Message-ID: <a9564d39-b3a9-7208-f28e-1b60544fa6b3@intel.com>
Date:   Fri, 28 Jan 2022 11:40:42 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH 3/4] selftests/sgx: Ensure enclave data available during
 debug print
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, <jarkko@kernel.org>,
        <dave.hansen@linux.intel.com>, <linux-sgx@vger.kernel.org>,
        <shuah@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>
References: <cover.1643393473.git.reinette.chatre@intel.com>
 <ddb6554a95b0978aa018740fbfb32f786bcbd284.1643393473.git.reinette.chatre@intel.com>
 <ab92b3be-24bf-6fc9-aefe-266aaa16846a@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ab92b3be-24bf-6fc9-aefe-266aaa16846a@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR17CA0066.namprd17.prod.outlook.com
 (2603:10b6:300:93::28) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e24cfe90-7fe3-4afa-9f9b-08d9e2961409
X-MS-TrafficTypeDiagnostic: BN6PR11MB1524:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB1524BF45D697D5397E8E1FC1F8229@BN6PR11MB1524.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eIWVTi8nst+hZQKrsMGPptQ40eiKbPzg+CW4E+uhnb8QHXvI1H2UJd0pn+I+4kMN6idDmG3HNjOFgcV2srynHKAMNLwGRcADRZcK0Ii2ptr158PIN5T0vDnB9bgVbzt7rvSl2K5sRgh/i2fM+UYOXF00fqqdRyyrq0Ko0GFKo6ekZFbCKL3iEw7dG7L52vx2PQBbSQJefbzv9HCQ8TvWPb2fUpRpJOAsYPRCqtW2rXa+2TtGtOarWEHa0fn/LQnuWVKaZJty9WK2+X9QVjLqtibWge6/6Zyhz4uSkUmDnO5niwQ0qi2PK2cVVlq8E0ysNIaftpyMSyzjKbUWi67pCKH7OJiORFS09s0ZwAJGG1ZSWI3xftCpJ2pXbqKPLdWViaNVk+IuFo6nMUZSmp7rmsWGkY1NS5YvKrXZK1C8a9Egju/G0ShktglKwg1borald6aUAmJnXiaqdcz1YagdCNb8hcLR0MErywhw2vjktiJZT15fgY2MFOO1ewJG32okyHsS0CSYUuPwfKi7m9h0yIxx4n2lLzoB3Xu3GwGf1UGtZf1DYl2qhdQmoPmZVQVNDijaLSnlVuI3IhYtSez33xQQ+mFaMfLeAKi9GWWgmWCVWuDnnyj3AJX9hHxhHfKswCOtMdRIbBgQyFvjXW6Z3g449iLJWLuXpzZskNDw+kLp8/CTHGf6gnUjqm911NiN8t7xuwkcfYfA1I5JAY/8jTBH6HzUaMckpGxrS4T+ABeVGWH19Pf30llTZTD5DEXe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(44832011)(316002)(6506007)(6512007)(6666004)(66556008)(53546011)(6486002)(4326008)(8676002)(8936002)(82960400001)(66476007)(508600001)(86362001)(31696002)(66946007)(38100700002)(26005)(186003)(2906002)(36756003)(83380400001)(31686004)(2616005)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDBvTWowYzVNZ29jdW1tRE9hSmZWZ3pDQnpIeXB4VXF5bDNTbjR2ZnArdXRV?=
 =?utf-8?B?Q3BCMmZuZWFRL3NUMm5FWHJyTnhMcE1VSitLRkk5NXRCNGV5dWFVcXZFYlll?=
 =?utf-8?B?UmR6Tm5vOEpSVitaWE9YTGRqWTU1azF5WUExWm9NVUlKWXR3TlV5ZnQ0SUFi?=
 =?utf-8?B?dnpUMllpYVFWejhuMGpNN09QQ2VRdUlUcFdFc1NVS0pnY0ZlKzFIc2VBUlhz?=
 =?utf-8?B?bmc3K1NnbEU2czJKVVJiciszS3ZJaEZ6MldoZTFzMWM0d3VjNUVYbUZRZVIz?=
 =?utf-8?B?cnNVZE9iMXdZT2RzSnpsYkxRTHlUdUEyd1dLcnpuWTh4eHE5d3h0MEl3M3RE?=
 =?utf-8?B?WUd1bVNlUmFzRWlkN1BqMDBvbDRmazEvWDNtdXJFalYvdThOY3IyR3dzS3FE?=
 =?utf-8?B?TGI1M296VE05SHFicnJhQVl5V25kQUFXaERLaU9PeTUyeWhHVExzK1JzOWJs?=
 =?utf-8?B?SkNYY0ZYcTU4ZjlRUThsbnAweno2QSs5N0sxQXZYODNGUnFFemx0REdLc3pF?=
 =?utf-8?B?QzRiWSs0WTNrbUpVaVVJK2ZmaDFkVVFobHlUMngyeHVsS2JHdHJ4OHNrZG1H?=
 =?utf-8?B?TE1nS1VqaGU0dFM1S095NitLRndhR0F6K01qclJIWnlpSzRJWlRYRGJmbkZN?=
 =?utf-8?B?OGJTK1pwazNoSmFEZ3gxdGdZa3RsY2lMZmtjOVZ4cGg5VytIV2NHM2g5MW9w?=
 =?utf-8?B?Z1ZiVzZhNDZCaEhoRmszbHdTVDVEODVaL3dUMVhjcEZNYmx1MzFORnBXSXAx?=
 =?utf-8?B?Z0xUK3NIMXVJbkNYTHY3aC9yNVJPSTFralY1SHFPRDltUldYTHRRd1NHUTNm?=
 =?utf-8?B?cStKZ3VDRmFXb0lPamdScVczZThLZlpMNzN1OHozMHlCQjAvUHhPRWo2K0ZL?=
 =?utf-8?B?U1hLU0RuQVcwS2VkUWFFUHVuYjV2S2VPa25CMy9aR3c2TkF6ZkNJdnIwVkcx?=
 =?utf-8?B?SGFJN21sSFZzL1hKb0tSOENvSzVtaFlSU2c1bUtwM2lEdm4zeWg1b3VnQVR6?=
 =?utf-8?B?eXFMTXRicFhpVklBUTh0a25pT1JVZEx6REcybDc0UHAvUndCNUliYVNIK0p0?=
 =?utf-8?B?VnNES0dyWFBtZksvZURabzBwU1VvNkRZbWxwbDQ5L0oxb0tTVnZMZ1RaYlFX?=
 =?utf-8?B?OXo5UE9SWUtDWjVCZjl1VXJFaHhqQkFxWTdNOW9hQkM1K0ZyZ0lYWHBVanVu?=
 =?utf-8?B?US9LWXdzallHdTVDVEVZbE92WWRzVlF5VkhlelAyMGphMzNRU1VTYkZodUJ6?=
 =?utf-8?B?WnJHa0hjQ2F3Z0dCQzhiWDhqZmI1bUNGUzBLN3NpL1B2S1A1eXRES081OVdk?=
 =?utf-8?B?V1ZnMlVDYWYvTW5kZk5tSEdFTnFQMlhETTJYaDlGTGxCMDBHd28wZ2hBUzZy?=
 =?utf-8?B?K3BUN1JXOFV5NTNuUStISGUwNFRWK3FaVU5BeWw5d2FKMjk4elRGR1NKZkcw?=
 =?utf-8?B?YVRGTE4rTkVsek8yUlFKRmMwdGo0MVhwNGprc21CM2Z6NVBmS0pxY0NQSm4y?=
 =?utf-8?B?RlpBMy9oZS8rRmFzNDRpeG4vdCsrdlh3MGFzem1Zcy9KSzF3Z25Hb0d5ZE5h?=
 =?utf-8?B?QzA1SVptZ2hvbjRWRDRadWtwSnA1OU5yNmJIYzFNRUl6dXhKRjVGOFFPYnlo?=
 =?utf-8?B?N1BZbjF5VkhRRUtHU0l6MnJrTkROWUZ2a1hHeFV0R1ZaMjM5YVJHcU8rYldJ?=
 =?utf-8?B?RkNkY2lmNlFIVDRxTFpXaGFaa1VoajR3YjVyQXZtby93MFY0ZGxONTdMNmRY?=
 =?utf-8?B?Wm0wSWNFRG83TTF5a3BuREp2MkRsZWVXNWZ4TUVkdGd0dXlaT3B4b2VId0RD?=
 =?utf-8?B?cDVUOVFsalVzVDZTS1hFVmZESGE5aUNWZ04xYTllV05lUGc5cFBUa2t3ZTg2?=
 =?utf-8?B?cEYxVm1wL0FvUGg1RHZlUUU2VEE4ekxObzZDZzBrTUJIRVlWR0FDeW1GZWpk?=
 =?utf-8?B?NHMvQWtJTE1vQmtaaWNYT1lqa0lDYUFSOEVqamVGeGRpanZKSE1zUzlGRkVp?=
 =?utf-8?B?YzhDVFJySThjWFdqZ2ozNVNSdjR4clZKbUVzb1Vsb0d4VjhLUXkyL2RnMTFT?=
 =?utf-8?B?bHBkZWRITmpBL0thYVRaTCt0SVo5eVByc2VQVHJubnE4WitSUzFEU1Q0Y05s?=
 =?utf-8?B?MENyUjI4azBQWGFqWDhOOU9URGF4OEFUNEg2UmtqL0hmRUtOQTRJMDVOU2Zq?=
 =?utf-8?B?T0pWY0s0RXBjZTNoeUs1WjdXUjJ0eURxM3c5cVZGMEU1UmhQc1pGbXd0MGxq?=
 =?utf-8?Q?jAuypLGtKIiAkcbhSU5LbjhZeF9LrKfy4ctqBZz3Fg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e24cfe90-7fe3-4afa-9f9b-08d9e2961409
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 19:40:46.0501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WCG8PpNpqGSXPnp2uAV+ADYi+9/5jJM152PVR3vPFafu56GPnzl5hFcJdx1e8WsbnpgHlNHzB1Y2IlRLihwXiN3JeT+Y3c4nYejL+f1tiPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1524
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Dave,

On 1/28/2022 11:06 AM, Dave Hansen wrote:
> On 1/28/22 10:23, Reinette Chatre wrote:
>> In support of debugging the SGX tests print details from
>> the enclave and its memory mappings if any failure is encountered
>> during enclave loading.
>>
>> When a failure is encountered no data is printed because the
>> printing of the data is preceded by cleanup of the data.
>>
>> Move the data cleanup after the data print.
> 
> Isn't it worse than that?
> 
>>  err:
>> -	encl_delete(encl);
>> -
>>  	for (i = 0; i < encl->nr_segments; i++) {
>>  		seg = &encl->segment_tbl[i];
> 
> encl_delete() does:
> 
> 	free(encl->segment_tbl);
> 
> but doesn't zero encl->nr_segments from what I can see.  That seems like
> a use-after-free.

encl_delete() ends with:

        memset(encl, 0, sizeof(*encl));

that will zero encl->nr_segments.

Even so, (after this change) the function to which this change belongs
flows as follows:

setup_test_encl()
{
         ...
         if (!encl_load("test_encl.elf", encl, heap_size)) {
                 encl_delete(encl);
                 ...
                 return false;
         }

         <=== /* 
               *  At this point, because encl_load() succeeded, 
               *  encl->segment_tbl and encl->nr_segments will
               *  be valid.
               */
        

         /*
          * Further initialization code, any of which can
          * "goto err" on failure.
          */
         
err:
         /* encl->segment_tbl and encl->nr_segments are valid for use */

         ...
         encl_delete();
         /* encl->segment_tbl and encl->nr_segments are NOT valid for use */
         return false;
}

> 
> Seems like we need to really run the selftest under valgrind.

Reinette
