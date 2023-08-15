Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9113577CF8C
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 17:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238272AbjHOPtF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 11:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238294AbjHOPsx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 11:48:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB9B10C;
        Tue, 15 Aug 2023 08:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692114532; x=1723650532;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ROw7O3QN2I5gyn4nWP2/ldg2o5sGzMN6X05pUH8sPL0=;
  b=nGrZ2/s/PFJiJozimtFe9h54KrCikBsXsmAeDjvQSxTN8/Cxxir9j8uk
   7hEoLTmOzjEoz0FZjwoo3u9yltmdfa3PNGxOz9WC0ed0b/s7LX/fGiWyX
   57L/KilJKL/JXbc6VYGNDKTDIphRWULi0W4JfD5Dn5LUZN5taMS1XMsOM
   X319ZjjrBE63FCjnXoSbI8S+Chl/l9+tMC2LBH/o5x+5GFWCFqV1eRYb/
   dVAD4gtJq3bwVzZ51N1xFGnynSfGqZVYjh0J4EfYuICQUR8DPUnPJt0eh
   4+0iEs/idixESFIBlEvwZ1Ad7f8T78xkBWgaj1oX1nk61BD0fP69QeP0X
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="362460191"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="362460191"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 08:48:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="733884425"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="733884425"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 15 Aug 2023 08:48:49 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 08:48:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 08:48:48 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 15 Aug 2023 08:48:48 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 15 Aug 2023 08:48:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFZc6hUUx2CV3bnoZOt7VVzvrqVDYxbczQWR2lpoi19jDpcnUi6zrczFnm7bgVQPCG/r6QgPsOxfYkty9GpZmrT7t93WGke0xUUK/XkkdncaGXLUYkbkSO+ZMIpyk9qa3LUsTymm+2f5J7ZXNyg0qg+9AvoFgxTRSaCwCRCoWq9JSc0MBFvlnQYlIzBn2RIXOSkFRbj1M8IEg/8QcZGqmrtj9x48fgvnMix2zDra4QuJQkrhwpY75XnBSJCiyUpTc3xBIDMQL5NirfwUs+cnIZz+KNXC6M6BS2xPCsGhMFJrqctOh3TedcmV4Hpl8EUzzUFSpDrOTjXP6mDqSiTRQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUbTcMAa4rB4W+HF8XUnfdXptN5EEXFQrwtBKumCQ6c=;
 b=a6Fjqg5O4b6dR2Gfd+uxP+g7Ruej3RkmtBxiLX+Di+F/pMNdTXwQPrhgE2Qap8np1//cKdGScwBmqpCssv16poNz5ZTpEFA15A2cyFBafriKg+UP/WVqak29JhPYS9s6rT7MTIVmr/7ErHGohk1mXYJDIL9DgxxH5o7OgKiYeOc7N7bal8nX6+9PGKf2vw4xRj8tdfsA0dFMXRjYz4UyI1p0ilGx+hJ7qZM49dqvXP692vvtme20+z4HhtJvgNXr14WLV87inQzhO302R8TPVh4wOiypA+rJjNvwhg0aXDkyCkNUM/djYaBPOsBjgYdwbNw50Jx5baebTlhgmh9ukw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7508.namprd11.prod.outlook.com (2603:10b6:8:152::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 15:48:45 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 15:48:45 +0000
Message-ID: <87183b24-f343-2420-9bda-f1012e7195a1@intel.com>
Date:   Tue, 15 Aug 2023 08:48:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH 5/7] selftests/resctrl: Use pointers to build benchmark
 cmd and make it const
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20230808091625.12760-1-ilpo.jarvinen@linux.intel.com>
 <20230808091625.12760-6-ilpo.jarvinen@linux.intel.com>
 <f300a52c-d65f-fd74-18ce-7d37e76d144f@intel.com>
 <dd83f672-b9fc-cd79-10ff-70651d4822af@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <dd83f672-b9fc-cd79-10ff-70651d4822af@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0147.namprd04.prod.outlook.com
 (2603:10b6:303:84::32) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d923673-292e-4f9e-2dde-08db9da71bd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RtRGjxQ4dFuaRC/urYb1zaYP/wo1rE4Z/ZpXNYWQXd3np+7LECp3GI0JY/1CGAabVp4S6NxGPTFP+OycqKF2UqUlSjdAGa1oEGRaZr57E2kExrgqpTAafL7XOmmBwlrs+3DgkQ/EoyvvR6EvBKj4Wd6hlZpQ6URqtPE7JYCNqk1nYU/IEATCq3HbsTmCqCITTWUraIv2IhArmQPojP1z7iK7pMzJrWftWqIQGP5p0CXKHHG6BaGaijTrzvxiblG28FXRUzofn68BAC5BVd8rY8vCGWy2ALY0sYP0M/tdXsYUvWrYTrPM3pgJrGWZtB25xuFScmbLyqJe3XqVHHcb79LBPKxE1pHGhYdKfDjyscWNAg7qLc3uZ5+YC2R606UNN0WExYEyj06esz30ABBYTDAoW1+ow9qJ9i7aG2mGqAnkGQu5F5VBvijiZJuCFNKBsVBm7W7Bwx6Gn4QijznC7CP6FyRdAVAiFBG9oMQ0ZKyZwAhptEssG2Ah27slkuJv5/TRRLiRkPSiDL2VAiTJ5IRgmt3+JldzjeJI6RnaI8TjVz6p8kyw4Gv8ZV2NPaXc78n/pAD3XfFumF4C9jcYLaCHdwr1W2t1omiaXTeMMhgS9WoxVyNPuSdXr+HvH4D1W+O7mcLIsnzElJsggzVqGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(136003)(366004)(451199024)(1800799009)(186009)(6666004)(4326008)(6512007)(66574015)(86362001)(31696002)(44832011)(2906002)(36756003)(6916009)(66476007)(66556008)(66946007)(316002)(6486002)(53546011)(26005)(6506007)(8676002)(2616005)(478600001)(83380400001)(82960400001)(5660300002)(54906003)(38100700002)(31686004)(41300700001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0hNMkNPQWNZU09EODRlZWN2YVk3R1MvcFZ5aUZ5UE53bUhUOThDVHpjeUt6?=
 =?utf-8?B?Tm0vcWhzeFhwa2svd2NMS0tQZEZsLzE4R0dTbHVBUG9DelZSL3FqclJDMWJW?=
 =?utf-8?B?TTBydUlybmlhUGJSYys4c0V0VHdYa1pXZ1ZCeW5SdFMzc2dWSC83WVNJSGdi?=
 =?utf-8?B?amR1OEF2dFpmbVpCSklLd2hHMDVoZlRzWFNGWi9ldy82MFQ4dzhQSitEMC8x?=
 =?utf-8?B?bjd1d3ZvbEtIbWErYXQ2Tmh1bTlNdTI1dmZBUHVhc2RIWUprM09XbjdIa0Nu?=
 =?utf-8?B?eXpVRzEyVERUZVhUUndwL2lzYlFtTnZSL3d2VFU5anNHT0NwUHVUVlBNZjVU?=
 =?utf-8?B?K1o0L0NiQlBWeFduNzZmWG1iL3ZmTjhaelhHTGRYRVZqc1dDY3FXdVpDb0xM?=
 =?utf-8?B?OEZuUVdTdW5NdytPT2JCWFMxYlNzL2h5bFJzRSswOVVqMlV1M0NGVzF6Z0xF?=
 =?utf-8?B?TXBtT1RKQkVBZnFnSzBMUmwwSXNFRHpCWURrWVp3RGQ1S0NpUnhlQ0w5TFFR?=
 =?utf-8?B?OER5Q1l3TnN1ZHpqVUkzQzlkWDVQV0lWdEdlbE1uUkdUUEhVNjB2TzRla09M?=
 =?utf-8?B?WUZPclFzTW1meE1hbkVYQnVrVjJ1YzdZV21zSDhmOWxnTlExTHpKcmg0KzJ5?=
 =?utf-8?B?aTNDSDBhK0dqaDZOeFBkYzdEZ1YveE9GS0VISXMvNnR1UzNCWWFTdWxHZFYr?=
 =?utf-8?B?MEVRd0JkRnhjZUtuRDZ1WFBUWndmc2c2aG9FNEZxSnlNR0xwdWJsZ0tlbmZk?=
 =?utf-8?B?NzJKUE12MGNra0Uwdkdhek14NWJ0TldJV09vL3prTXNaMWxVTW9QWEVrSEpF?=
 =?utf-8?B?cnBBdXdtUk85OVg2R09mOGxxTEp6SFg1UmZybkxaM3RRYXhQRkhCTlcvcURE?=
 =?utf-8?B?eDA4ekpsWEU2NEEwSFliaVVHSll0a2JKaHNWeUdxa0c4YjFIOUhHN3B2WlUy?=
 =?utf-8?B?MkpZZmpiY2huYzhmekZZSEpITWFPM29USmh5bDlKTTlsdkpveWNVS3h2VVlw?=
 =?utf-8?B?ZkYxVFVLYkVQaGlHNnk3TkxvUEU1VzR3TjlOZEtkdlZLVzE2WXhObkJ3UzhQ?=
 =?utf-8?B?WmJDRElpNmo2bWlud092ams1c2tWbHIzbnFVWFdtZ0hrZW5XYTRieGhzTlNY?=
 =?utf-8?B?NXF4SXg3aHZJd1JQZ3ZHelhqamNlQmJWR2JmQjRXNkNwT1FmUlcvdzZEbUNZ?=
 =?utf-8?B?aHZCbFVGMGZWbjBTS1FJaituRENUUWJtekM2c3Z6TFdycjdnY2RSWjVnZy9u?=
 =?utf-8?B?SHoyTmxNd3VBZTJNc1RIUjhuNnkvOFRRZUF5Y0dnUjRKMDEvVCsyMEMvRGl6?=
 =?utf-8?B?cEs2alV1MVBOQ3U2OHFjK2xOR3ZoZDBPcnR2RUk5M1JuZ3Z2Vnh1L1dlWDdD?=
 =?utf-8?B?Y0pYWmNIbFN0cXpoMXJISWxid3J4Qk1xMEdVWjdhVUlLRHBnb1JIV0MxTHZ1?=
 =?utf-8?B?YkFucEp2QkF0UXFoN1BZUGpEc0QycUZKdzlaUmhDNjN0Wndkd2dFRUhDbHZM?=
 =?utf-8?B?dTdqaEN0SUxOclF1MDE3aXRFSEFHNmdMUmhHc2l4YWNMS1VNSWtiN09MR3BQ?=
 =?utf-8?B?YktoL1Y5QzBWVFJ0Q05GbHp6TDV4Qkw0NE5ZM3JLc2pnUDJGUGw5YUVJOHcx?=
 =?utf-8?B?RW5Icko2cmM3QmE5eHV1ZUZRcmlyNGZxVWNwaVdueUpVS0cwRTFuNjhpaFov?=
 =?utf-8?B?K1dZMXRCcmswWGxVb1JGcUZwZTNSSmI2UDNweTlZcWR2TlRUTG5laW1pMHlZ?=
 =?utf-8?B?ejVrUk9KS1crTlcvSnJkZFpqUmhRTEJTeHFzQVBMdnpJWCt0NGlaazNCaWN4?=
 =?utf-8?B?Y0lmVGFtY3dlV0pDSFpXUm4xZTdENEFYdGZIbFJzdGVpUG0zR3RZbnpkdnhH?=
 =?utf-8?B?a0lHeEpTR3FIcS90TnRzWFc1OVdFRllxUkxDVlV6TEdmaTdTa24wNTBhNU5T?=
 =?utf-8?B?b2QzODFVdXRDVVRvKzhsL0tVMnVkTnJPdk1oV052SHd6bldjZUdZZDl5dCta?=
 =?utf-8?B?ak95R2xWa3RnNnRrVk1pekNZWTE1NDFXQ2o0TE02dkZkOHBKUWQ3bERGcVJ4?=
 =?utf-8?B?Qm1CYk51RVBQdFA4Ny9qZWpHQndocms1djVmV2pXcU1rUUVGN2p3S3hERElC?=
 =?utf-8?B?OUNGVjNSbldOVWJBVG1QbnNPeXlMQXRjcWgxUnZubnh3YUk4SGFmU3ZiREZL?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d923673-292e-4f9e-2dde-08db9da71bd4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 15:48:45.6209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TvLZnt+WyazH1GuJPmi69k01PxW4ta4W+csSzEEP7BZUETtpr43+WNDxGO7490HXKU3efXTzNT1B3TWWTWzucIQko9M8UkhCY6inYq5yQn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7508
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 8/15/2023 2:42 AM, Ilpo Järvinen wrote:
> On Mon, 14 Aug 2023, Reinette Chatre wrote:
> 
>> Hi Ilpo,
>>
>> On 8/8/2023 2:16 AM, Ilpo Järvinen wrote:
>>> Benchmark parameter uses fixed-size buffers in stack which is slightly
>>> dangerous. As benchmark command is used in multiple tests, it should
>>
>> Could you please be specific with issues with current implementation?
>> The term "slightly dangerous" is vague.
> 
> I've reworded this so this fragment no longer remains here because the 
> earlier patch got changes so the dangerous part is no longer there.
> 
>>> not be mutated by the tests. Due to the order of tests, mutating the
>>> span argument in CMT test does not trigger any real problems currently.
>>>
>>> Mark benchmark_cmd strings as const and setup the benchmark command
>>> using pointers. As span is constant in main(), just provide the default
>>> span also as string to be used in setting up the default fill_buf
>>> argument so no malloc() is required for it.
>>
>> What is wrong with using malloc()?
> 
> Nothing. I think you slightly misunderstood what I meant here.
> 
> The main challenge is not malloc() itself but keeping track of what memory 
> has been dynamically allocated, which is simple if nothing has been 
> malloc()ed. With the const benchmark command and default span, there's no 
> need to malloc(), thus I avoid it to keep things simpler on the free() 
> side.

Keeping things symmetrical helps.

> 
> I've tried to reword the entire changelog, please check the v2 changelog 
> once I post it.
> 
>>> CMT test has to create a copy of the benchmark command before altering
>>> the benchmark command.
>>>
>>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>> ---
>>>  tools/testing/selftests/resctrl/cmt_test.c    | 23 ++++++++++---
>>>  tools/testing/selftests/resctrl/mba_test.c    |  2 +-
>>>  tools/testing/selftests/resctrl/mbm_test.c    |  2 +-
>>>  tools/testing/selftests/resctrl/resctrl.h     | 16 ++++++---
>>>  .../testing/selftests/resctrl/resctrl_tests.c | 33 ++++++++-----------
>>>  tools/testing/selftests/resctrl/resctrl_val.c | 10 ++++--
>>>  6 files changed, 54 insertions(+), 32 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
>>> index 9d8e38e995ef..a40e12c3b1a7 100644
>>> --- a/tools/testing/selftests/resctrl/cmt_test.c
>>> +++ b/tools/testing/selftests/resctrl/cmt_test.c
>>> @@ -68,14 +68,16 @@ void cmt_test_cleanup(void)
>>>  	remove(RESULT_FILE_NAME);
>>>  }
>>>  
>>> -int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
>>> +int cmt_resctrl_val(int cpu_no, int n, const char * const *benchmark_cmd)
>>>  {
>>> +	const char *cmd[BENCHMARK_ARGS];
>>>  	unsigned long cache_size = 0;
>>>  	unsigned long long_mask;
>>> +	char *span_str = NULL;
>>>  	char cbm_mask[256];
>>>  	int count_of_bits;
>>>  	size_t span;
>>> -	int ret;
>>> +	int ret, i;
>>>  
>>>  	if (!validate_resctrl_feature_request(CMT_STR))
>>>  		return -1;
>>> @@ -111,12 +113,22 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
>>>  	};
>>>  
>>>  	span = cache_size * n / count_of_bits;
>>> -	if (strcmp(benchmark_cmd[0], "fill_buf") == 0)
>>> -		sprintf(benchmark_cmd[1], "%zu", span);
>>> +	/* Duplicate the command to be able to replace span in it */
>>> +	for (i = 0; benchmark_cmd[i]; i++)
>>> +		cmd[i] = benchmark_cmd[i];
>>> +	cmd[i] = NULL;
>>> +
>>> +	if (strcmp(cmd[0], "fill_buf") == 0) {
>>> +		span_str = malloc(SIZE_MAX_DECIMAL_SIZE);
>>> +		if (!span_str)
>>> +			return -1;
>>> +		snprintf(span_str, SIZE_MAX_DECIMAL_SIZE, "%zu", span);
>>
>> Have you considered asprintf()?
> 
> Changed to asprintf() now.
>  
>>> +		cmd[1] = span_str;
>>> +	}
>>
>> It looks to me that array only needs to be duplicated if the
>> default benchmark is used?
> 
> While it's true, another aspect is how that affects the code flow. If I 
> make that change, the benchmark command could come from two different 
> places which is now avoided. IMHO, the current approach is simpler to 
> understand even if it does the unnecessary copy of a few pointers.

cmd provided to resctrl_val() can point to original buffer or modified
buffer. What is wrong with a pointer possibly pointing to two different
locations? 

> 
> But please let me know if you still prefer the other way around so I can 
> change to that.

Your motivation for this approach is not clear to me.

> 
>>>  	remove(RESULT_FILE_NAME);
>>>  
>>> -	ret = resctrl_val(benchmark_cmd, &param);
>>> +	ret = resctrl_val(cmd, &param);
>>>  	if (ret)
>>>  		goto out;
>>>  
>>
>> ...
>>
>>> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
>>> index bcd0d2060f81..ddb1e83a3a64 100644
>>> --- a/tools/testing/selftests/resctrl/resctrl.h
>>> +++ b/tools/testing/selftests/resctrl/resctrl.h
>>> @@ -6,6 +6,7 @@
>>>  #include <math.h>
>>>  #include <errno.h>
>>>  #include <sched.h>
>>> +#include <stdint.h>
>>>  #include <stdlib.h>
>>>  #include <unistd.h>
>>>  #include <string.h>
>>> @@ -38,7 +39,14 @@
>>>  
>>>  #define END_OF_TESTS	1
>>>  
>>> +#define BENCHMARK_ARGS		64
>>> +
>>> +/* Approximate %zu max length */
>>> +#define SIZE_MAX_DECIMAL_SIZE	(sizeof(SIZE_MAX) * 8 / 3 + 2)
>>> +
>>> +/* Define default span both as integer and string, these should match */
>>>  #define DEFAULT_SPAN		(250 * MB)
>>> +#define DEFAULT_SPAN_STR	"262144000"
>>
>> I think above hardcoding can be eliminated by using asprintf()? This
>> does allocate memory though so I would like to understand why one
>> goal is to not dynamically allocate memory.
> 
> Because it's simpler on the _free() side_. If there's no allocation, no 
> free() is needed.
> 
> Only challenge that remains is the int -> string conversion for the 
> default span which can be either done like in the patch or using some 
> preprocessor trickery to convert the number to string. If you prefer the 
> latter, I can change to that so it's not hardcoded both as int and string.
> 

This manual int->string sounds like the trickery to me and can be avoided
by just using asprintf(). I understand that no free() is needed when no
memory is allocated but it looks to me as though these allocations can
be symmetrical - allocate the memory before the tests are run and free it
after?

Reinette

