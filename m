Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6601750EB44
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Apr 2022 23:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245753AbiDYVW6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 17:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245757AbiDYVWy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 17:22:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EDE118EE6;
        Mon, 25 Apr 2022 14:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650921588; x=1682457588;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xSJUv3hqTHrtOh/JpUBhX37TS56LNML1DK5Odc9JmQ4=;
  b=b9wQUJHBzDMUx8fHkQK74+h+/v5DYww+SEJC7M3tInF7mQ/i+/K2IkOl
   4Hu22EOwvTt6k/R8MlVXPtSqR/86cKaknyih/Qu7FHxPsdv9Cfo/g9QYK
   1M1MgUIGL1g5Nu5XiOVyPjCojucSsoHlc/4xW/obVNkeV/B0VVZ29XWjG
   MvekvyPnfHp9uaGU3dtzBvZiodr2KQmwE8gf31i9V5tDPD/9mUtDw0rFq
   XC8IBPP/LgDNIb43t91QEn25cwCHieCnpHIDj7mRPJeejY+vMK6UlqJnr
   ysTtV93KGdwkh7G2VB/AjrDn16a4Z093bGGqgFlgsW046P59p1FX423CN
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="252737558"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="252737558"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 14:19:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="628209865"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 25 Apr 2022 14:19:48 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 25 Apr 2022 14:19:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 25 Apr 2022 14:19:47 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 25 Apr 2022 14:19:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LV1P/zjuNvaJvhcaXNxjmSk3VF2wDehTzCpniI8f2uWI1Bd/uITHGlfC7JEeLYvMxZOilfvU5PMuMHxjAie5euqIki+S+rAvCIhz6GQeovR7ibXB7hhzozw1Zm2DAlWTVSG+fi2XOy2zIkhkJ5iCMa6HayCqKWleE2+ECc7aRyA72g01xIiGK7/GsRDxeVwvtjOjEsHolzVqT6RinXdwB3Q78jRwlVXwtlxPU3gDtgRdlKKojqu3reCmbZJbbL262SurHqzOOd6D73lngnTxy8NEiyiChAnNtkwjJ9nmh11Eg/h2RJeqb6VkDB6gwl6pSqf7xUmOWTW6YXsmeYwAsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7+uqAfHL1gfxCZUEexhM6Wae0KPi5Gt2CCD5yBlKwM=;
 b=oKLGwDlwJrgVq1yu+gEFmDxxGhMFviOrrkwcvb7JyOiInthgNs5TZh/36k817lmmyzRl9kMEXWg4M3XV3QzyDJv2wmkHWTGRpRIHaQD4e4SOSmszTte8QVVDqc2IlFUmiql8gTuW5jufx+v+LL4DW9JzJCIG1AcPHt07fTa6tI8JJ8Db25bEx5JGYfgwS22LXr4oXXBCzR+Hn5P+RP61NxD8NTY1sLdWVWwyvMYdtxuRhyLGQN5zZY+OiJ4AmQ+FBF6Dlo0Hb35K1OMDKTPeE4QcrOsW8J3yaiSJxGLfLaOYF6jMPOF8MlnEXXsRVGYKL9DGBAe3Yu0OiVQjIziFhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by DM8PR11MB5640.namprd11.prod.outlook.com (2603:10b6:8:3f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 21:19:45 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525%2]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 21:19:45 +0000
Message-ID: <9a1d0420-d99a-e4a8-c6de-729b56e9c1f0@intel.com>
Date:   Mon, 25 Apr 2022 14:19:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.0
Subject: Re: [PATCH v5 0/2] selftests/resctrl: Print a message if the result
 of MBM&CMT tests is failed on Intel CPU
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20220323080928.1586408-1-tan.shaopeng@jp.fujitsu.com>
 <1920a6b6-bc1b-31db-4c1b-efccc189daa5@linuxfoundation.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <1920a6b6-bc1b-31db-4c1b-efccc189daa5@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0037.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::12) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3549fc42-1d7e-431d-8e7e-08da27015246
X-MS-TrafficTypeDiagnostic: DM8PR11MB5640:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM8PR11MB5640689C1D1964682C3BDA3DF8F89@DM8PR11MB5640.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BPVGcRrQvctSA6e6mlrHVTMCFKrzkwnXU31vlLdt2yQ7/jwrJ2PKeM2X1EPBSuf/Y29lA7SxnZXcLbxzxm6Z3NMceIrpnF78QcM74fhi8GGPuYTCWtKBWFG3vmWc2I2URIOdkPJ65df5nNxEz2n8cpxRq4mniA+lPa95tgUHv8EcQqfQ/oL+A+r+KkAMjlV07v8fwD+KWRXYdCeKrGs81wT6eaixzHyBnOJq3lZd+mOqwUrnkbnbZ2L2UXeHIRq+fKKPxwLUwLymIvtOvKlVLy7xDNL5njTb73ZGX3QrLH/cLht1Lzg03tB1JILz9fnWMADkpihsKOnGq/rpIfE2ivRqOMKl2WpM10us/mYiE9WjAflisEAZWH1u2bx22LzLw5QF9ERZ7UeULZ3R+ZYi931dV0w6bfMC8/VAajaoJLJ12XX0c5IYyK+m1jUEBPmfnZxKlDEYZWUcdRTp/mEUP/5spS5qy1fJxBsgUZCrNinGPLVrv96Mv8oNfmJjGSwkFeuhBHcdC51LNsQqEDZ25nzderzDkmYHRx9Z11s/WZmdmi7+891g064fSjTCc3CBmol9lUyaX6XPyCqa0cE8Crlah2R8UT51BcqHsIHbtd45ESHK7UwcgQSEPy95ePItwaMipOmoovo7Y2JCkybz5vQfsgDrH6NBxHKX8fR7bwsElBfOGi58YE0duogUYbUt+xd0MKjdNH+yZpt64bh7s0FT7lx3dvfiBD9CvVhmt00tadW3stMPDh/mXlkPPRguo15obmqHBX9za2tjx5kzWqcu58pXDEz4I2y0cAXNT2FzeInSIR1r+A1/UfHvn9tI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(8936002)(36756003)(83380400001)(31696002)(53546011)(6506007)(4326008)(2906002)(44832011)(186003)(31686004)(15650500001)(26005)(2616005)(8676002)(86362001)(38100700002)(508600001)(966005)(316002)(6486002)(66556008)(66946007)(82960400001)(6666004)(110136005)(6512007)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWJnQmtMaFRGZkNPaWFIbXdhbGxsWDFCS0EvdlFJTVhIR0E5Zm45N2RmU09m?=
 =?utf-8?B?RnFGcVllbG5FdG5PcDZwcDJIbWFkOStYcEdtSzBGWWFUZ2VCQ2pJR3d5ZWI1?=
 =?utf-8?B?VzVGblFmb21NdXBkRFU1S0RKYVhWMCtDOVZ2eTZzVWhYS0JBeFhBY2RjaXRi?=
 =?utf-8?B?ZGYyczlHQmpBUzFGMWQyZ2o2YUc2U3J0MVozZHpGQjYwVnVVbGJNMlJpMnZm?=
 =?utf-8?B?R3czb3I2QnFoN1QzTUVLYS9qWTVQV2d0dTFCSDFEVW8xVTI0MG1vYzk2TFFu?=
 =?utf-8?B?RTJUUzlPOThBSmI2TlVjT0RuMGFINVRhVHFDVmx0SXh6ZnFYMmVWbXlqVXJP?=
 =?utf-8?B?azk5cER6QVdTOWxJY3ZNc3dZK1lJQ3RDTGo5Vlg4MVYyTjNleDZFcUp3Qjc1?=
 =?utf-8?B?dU51QzdSSXFyY1lMeWxFR1hmaHpWZ3A1MjdiZW5VMW1JNWp6NE9zdERreVpZ?=
 =?utf-8?B?T1MzWm5OQnBoZTlyOGpmb3pHNi9mQnlKSS9mSDY5SUQzTGZodEpaeDNObVFG?=
 =?utf-8?B?SndwTStKVmV4S0orbHRVRkdkSXkyOXNtQW9sM1hyVDFnSXlhSVZRcjFLbmlF?=
 =?utf-8?B?UERlcVZIQWtETHFzSG4zazRyNFRrV0pDMHJQYlZGeXg2SDVBQnVTd3RrUEho?=
 =?utf-8?B?VVp5VDVmWTBLdkFibXRtQVVuVFFyOVJYOHhhZlNNWkhvNjRVTExFRDhSMkpV?=
 =?utf-8?B?UkF1NTRrUFRtSmVVN0JmNXlqYkV1N0dvdEFLcHM2YytXM25DdnVDc09pT2dI?=
 =?utf-8?B?T3l5NWE4cXFjNGRIeSs1RDFxSnpWVjZETWQycUJDY1kyVVIwWVpMaVg4dm9G?=
 =?utf-8?B?akQza3hJOStwemZtVDBwRHgrVVVHZ1EvQW9ZQy9yelhWRmhZbncrZ00rTzRi?=
 =?utf-8?B?Z0tLR3RhSTdMVUFqTC81b3F4SXNhbjNzVis0VUo4V1o0TzJEelFicDd4ek11?=
 =?utf-8?B?akU5anJybVd2aXdNWkpqQVpNOWJZYUN3ZXZQcTF3dFVaS1JmaHI0VG0ydWJh?=
 =?utf-8?B?VW1SSm5GblFpd2pQaitOTjgwN0NUR2RTNkxTTURmT1h2MkhKYkJodU5oelVn?=
 =?utf-8?B?QTU3UXlNcUQ2ZjlPTGJOOVB2dmhtckdHTTVObEkzZitlaUd5emZZN2ZFakkv?=
 =?utf-8?B?aHdwVTRTdDg0L091UDdZZ2wzb1VFM0NzVnkxa3dLWGI5eE9YdEx3dUJzb29F?=
 =?utf-8?B?aDZFT1dHbkZNdVlFa2l3K2h5VjBTY0YyWmhpQ0VCLzBxV3NFTWF2ZUo1OXJE?=
 =?utf-8?B?by9mZE1YVVNMRnhoWnJ2N3JqNzdXVGpEWkM2eENkcUd4UTMvM3lXRmM2UVdw?=
 =?utf-8?B?SmpNTGw0OVF4WFBXMGlRUlJWSENBcVVHblFlMWFjNTVKZTVvR2lQT2NhZlcy?=
 =?utf-8?B?NEZMclBjYkxhSTRCTGVhSTBlTnZtN0pnTVZFMGt6bzcrbFNTMExMeWtqN0h5?=
 =?utf-8?B?OGlYczRmd3FjeExkT2J1N09HaFNwWWpjSC91dC81dXA0YzN1V0t1VVJOQnZV?=
 =?utf-8?B?VjVjSEREMEF2ckFTeEhxa2JKS3BHMjgrMkJIeFMyYUMxY3BTaytMdnFiaHZl?=
 =?utf-8?B?NkJPTEhtOWJveURJSUF0V1dCMUZmRS8vQVFDdmg2ZWxwY3daU2ZNOENkd05r?=
 =?utf-8?B?UmIwTXpvK3hPWlhldjMvdlBnM2RZZXE4YjQ1NG4vcjRjcDR1NkZUUUJIaWVx?=
 =?utf-8?B?TGlhL01nNU5DMmxBY0hkeG5oK0czczZxMXR6UUVHMFJDNlZyYk9qWUc2cVVD?=
 =?utf-8?B?STJXM0RrWjk0VzFOek56QTNjc1drdGtNSnZiQ0hQWTVEYVNyVUQ0ajh6NW03?=
 =?utf-8?B?VHJlWGx3RG9iZEY1ei9pZGJJK3Nwd2JteHlxRkRsNUxiYXhtWlk2b0dxZGxo?=
 =?utf-8?B?ZVBzaUZlSnFacndsTkZoZUVnanRtTzlCdW9xeE9GeklVVE5NbzVSd3BoRlJQ?=
 =?utf-8?B?djhvNUUzVkhxUEZ3aEJoY1FwWDRpTkxrclFsbm1UdUs3T3B5dWdlbWJMWFo1?=
 =?utf-8?B?NWh6TVNmM0hUK1hXUUlPQ20zTWh1b2JXYzI3UEM0bzJPNm01Q1NsVmNSbDIx?=
 =?utf-8?B?Qktlam5yQWhic0ZpWjNKRFNzbno1cnByM1czWDF3bmpHYjJ6V3paTzdkanlV?=
 =?utf-8?B?bTg5V0M2ck1ERy9VZXpwa3VPZVQwNVdNWURNRkNiTEdKanFuSW10NVlpWlcv?=
 =?utf-8?B?STlYMXd2QUpSL3owRE1TM0JQakI1blFTcFhlQXh4ajhvQmVTcVl1ejFML0dN?=
 =?utf-8?B?d0ovWGtJVUJyTm5CSnJoSldhUTdoM0tCckJEdkxUVDVLZVErdThzU2h6eDJ6?=
 =?utf-8?B?dEpNQkh5Tjc5RGlKNU0zbm9CZkMzdCs3UWdQZThWQXZQOEcxMDUrMmhRanNt?=
 =?utf-8?Q?OkSX02uQmZBZ16TM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3549fc42-1d7e-431d-8e7e-08da27015246
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 21:19:45.7183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BfQ9B9/aPlF5BoCRsnF83VA8HkfxV4k3PlmRlSi+aSdM4rY+EgtEld4qsW+/5XgV/rcVgL5do97OIZU0q52SLmevasRHEQ8yBg5sXs0SUYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5640
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

On 3/29/2022 8:37 AM, Shuah Khan wrote:
> On 3/23/22 2:09 AM, Shaopeng Tan wrote:
>> Hello,
>>
>> The aim of this series is to print a message to let users know a possible
>> cause of failure, if the result of MBM&CMT tests is failed on Intel CPU.
>> In order to detect Intel vendor, I extended AMD vendor detect function.
>>
>> Difference from v4:
>> - Fixed the typos.
>> - Changed "get_vendor() != ARCH_AMD" to "get_vendor() == ARCH_INTEL".
>> - Reorder the declarations based on line length from longest to shortest.
>> https://lore.kernel.org/lkml/20220316055940.292550-1-tan.shaopeng@jp.fujitsu.com/ [PATCH v4]
>>
>> This patch series is based on v5.17.
>>
>> Shaopeng Tan (2):
>>    selftests/resctrl: Extend CPU vendor detection
>>    selftests/resctrl: Print a message if the result of MBM&CMT tests is
>>      failed on Intel CPU
>>
>>   tools/testing/selftests/resctrl/cat_test.c    |  2 +-
>>   tools/testing/selftests/resctrl/resctrl.h     |  5 ++-
>>   .../testing/selftests/resctrl/resctrl_tests.c | 45 +++++++++++++------
>>   tools/testing/selftests/resctrl/resctrlfs.c   |  2 +-
>>   4 files changed, 37 insertions(+), 17 deletions(-)
>>
> 
> I can queue this up for Linux 5.18-rc2. Thanks for fixing the error
> path with clear messages for failures.

Is this perhaps still in your queue for consideration? I peeked at the
branches within the kselftest repo but could not find it merged yet.
If things are tightened for fixes it would be welcome as v5.19 material
also.

Thank you very much

Reinette

[1] git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
