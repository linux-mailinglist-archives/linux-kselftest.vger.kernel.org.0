Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42C56EB670
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Apr 2023 02:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbjDVAWM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 20:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbjDVAWK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 20:22:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD86426BA;
        Fri, 21 Apr 2023 17:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682122929; x=1713658929;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S4t1D/6npRvslXiTTG8ZNfabhmhEMzcHlAe1ZueNK3k=;
  b=dlTlGUgEfnZxzTK4Jb8043xzz3UrAB7on2uxeJ65LbFRstppla+O6CDY
   6Qdi2vOgJUBWgK17iNxhmcRoUxENHMBzSCKgalpI3RDYJKrPYdKcAnDZl
   g9Qc9/7j6asbPRd8a3Tmbjj62v6j4T/odZHry/UZzOtq9kKpUQl6Bj09l
   Ph5L78PZloAByXikIQ/DGJtyyFFKDGvUBEAdFSY8zetxkrqMGui91is0o
   kQxs5yqCGEKyTxmX8FQVoFn0yuCFfP/jtxnf37wgxHVTo7Zfnu5ceJTvO
   BsC5cP1djPr+DaoRLIhntb+RclXQsIURyFhgU/blD/6U2V9ti4atk90Ld
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="346129267"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="346129267"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 17:21:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="722938578"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="722938578"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 21 Apr 2023 17:21:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 17:21:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 17:21:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 21 Apr 2023 17:21:53 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 21 Apr 2023 17:21:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cT+ZlOqBlQTkkVW/YfzRbusuGJQFgsxrlQKcRUvHti07w4jycQdW+Ey7szi+JrNJkE6MFYvDGswU1LmVSR+A4QW7iI7d644oWMFH6Z5YgkWbNcW2YPkQyfS3vWXJpSfNPOVcyNz4p5WGzq9N1TTUtTflo8FzU3n310CXkl1Nh6pnUVI09Y5Dbn5JFwcfJwLCOzhDxhUkIxsqelLVkyv37alH5PibfBgTcEeIbbWsipnSxSXE04gPBybgjbpO2hbYj1huX1ucA19875YyhhaJsr21FprD05uN6dIsrqA9iMcw2VeutYqSksIGx/557zw/6iGUPOfU+tce7OjfRXOfTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NJB5s46ZMIi3/SdXrOO8Y+JNXSYkc/DFTtipzNpcVI=;
 b=FJJl3pTJcJ5zfrLzXsS06xKF8NWSRImmY7jvfoNK1MdrO5OcklAaf5GtNwi/rI3xWXMIuR+v/7HlNN7uub7FjhdCcNXMFGzW03mPv21nJ44kpe+xjgJygXfoOKvmcXc/uS2MFIfXbjgGd1NISZZU4hC2RqAkX3dXuLqzWf4sPqHbzC/3AKOpb9bsoxlGf0GKiN3fMaQahouuVxcEJk26/xmIvmXwboeqAcRAfc7Cvo1oQJkoyl6qsnKq3TyklLLcv2rve8btnkHgW7aRb454n4CfzJAeMrFT2Z63/8QgsfrsZcJVrXJIXHi5lfdJeL/9Wn7IrA8/5nKYqYHwwoGhEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Sat, 22 Apr
 2023 00:21:50 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6%4]) with mapi id 15.20.6319.022; Sat, 22 Apr 2023
 00:21:50 +0000
Message-ID: <695f71ed-46f6-e287-371d-bb11f014148d@intel.com>
Date:   Fri, 21 Apr 2023 17:21:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 22/24] selftests/resctrl: Split measure_cache_vals()
 function
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Shuah Khan" <shuah@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
 <20230418114506.46788-23-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230418114506.46788-23-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::17) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MN0PR11MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: 70bec18a-7022-43d2-ce80-08db42c79142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wzMz2GRcghvNEE9Cl79t31xXAgjV6pWyvqKuGp+HK/HJRn9V8QvNH4BVno+r+niz7Z5EwHRxoXuK+JxEdHF4bB/rlyGrFgRu0cR5tbtXm5CEAcETBovfpi57D8iIGeeO0XdHA5Msqcrsskmc/i92YRsqigEde2zfxWFSkydM620JWqf1mbZrUOrI9Azind6Sph4d8d2M7v7UFscOv9BgeTcCoA3mPXms4fP9puIo0tGdc4J8vYl2siZ6vM9q4Viu9/Wa9X3+8SQk0Z5mW6dRkhdMSg9cp5FKCBsvAFGdkb7PqQfMSN9z272rMakeJaaYuKkw18zZzOUNWlhfTSLTfFmquDgWOTI5vYULSj1zVkq2Fj6dEYbxCZgGZ7M5GAwas5LNlO6yDSOXmxzMCB5RFLSqLporcHzlaikNkcAs/wOOdh03r9m0ONMG0nKV3L86o5TlFoj7ZBL00PRAAu3MzYlXDtlvXO1YHWujuXp5Kuz1z5zQhI8ZMo2iiR5mBDuquluuHla2ufFs5VeKGFQNK7KbLZHZ8Np72akKhrbyL+kJLvqDfASLkVXMsemdM23ULfCyxwXX3zEyxYTE5IFMUgvYmwB9BdtKPB5OsGBS0mkTe6+luP9OM5ce6TJ8J/OEG029tOb62NF/DtCxI3ySZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199021)(36756003)(44832011)(5660300002)(2906002)(4744005)(41300700001)(82960400001)(8936002)(8676002)(38100700002)(86362001)(31696002)(6486002)(53546011)(6506007)(26005)(6512007)(2616005)(478600001)(31686004)(186003)(66946007)(66556008)(66476007)(4326008)(110136005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHVqUkMwZmUyekNyN0Y3TXM5OUhNbjlTcy9YbkR3Zm5CTlpGR0lVZ0ZrNHJS?=
 =?utf-8?B?ZHh2MDJnRFhhZmJxZkZ6TVNrWnZDQ0t2d05XK2RhYlMzRGpJeXF6QTVwQmM3?=
 =?utf-8?B?RncxbDVqMUZIQUU4V3NuY09mbHNYQ3JGNUFsdzB5YjlPdGx0QTFXOHdjbHdw?=
 =?utf-8?B?RXpnMmduRW1zVUR0Wk1pZmpMVnJUV3ZrbGoxVEFmTS9zQWVIb1RSSEh0RnBi?=
 =?utf-8?B?dFN3V3pqWGJPdnJNekZMT1RRNzlqOVB4OS9SUW9VWERETUFZR29JVUFpWFNq?=
 =?utf-8?B?SndrODkxWmFMcjlxUUw4SHYyYmE5b0pSWmhmZG55M011UU1QVHN2TGdzMEs5?=
 =?utf-8?B?alJuM0U4bnBHMmtvWjFTQ2RIaFFPRzh0Sm5qRFhiRCtzRG1ZYUlkUFV0VWpl?=
 =?utf-8?B?V0JpdjJiUlRrNXFyR0NidkJ2bXYwNVhHTGg3WmQyL25WR0ZYWGEwSVllY1VG?=
 =?utf-8?B?MzllVnY5K2YyKzQwTG9aRFJINHhFVXp0clRrQUVEM2t1cUFzcGJXdklJN05y?=
 =?utf-8?B?aXV6Y2FwOWtlNWJZeXF3Mnk5cTN2WFVKcEQxSER0ZWRwRFJnNGhMN2p2SDZW?=
 =?utf-8?B?SFRHWGhjUnhOUnN6anpLb0gwWERUMFhuL3B1aTlsYTRlQ0prY0RUbTVUWSs1?=
 =?utf-8?B?VjRDMko1TnhBUk44S05TdUhIYTRFSldYSU41S2RMWUt6eTlVeVZBdTJEY2VU?=
 =?utf-8?B?MjlrbHlydFcrY3NHbmtvY0IxdmYrTkJoS0hUV1JDVmNoVldpVHdtdXZXRkg3?=
 =?utf-8?B?N0wzVTVUeVZwRVJQVUhlWjNCaXVDOG8vTzZXMGNQRW1pVC9qaVhBWHI2Zzla?=
 =?utf-8?B?eGFBUHFpYTM2VGUvNi9IOGp4S3RRYnFOeVl3Mzk3R2IydVpqUVBIckpycUs5?=
 =?utf-8?B?RkE4MkordVRodHdBbXNrNS93ZXdUTE1ZSzI5Y1A5VStSUzNWOVBUU1VYcTIr?=
 =?utf-8?B?bU9uQ1RJaWwzZ1NRVVBKb3ptSXNGeHBVL1pWYy9ZMGVPM3A5NDlrbXNzbGtE?=
 =?utf-8?B?ODloVWltQ1FwckFyWCtpMitlM0NoUUJSSEM4T3pyb1lhY0hXZ0VwbEhJZWJv?=
 =?utf-8?B?SnFXZE5sYWR4MkE4ZlMrSEd2UzhKdDdvVEpqSGJHYzdmVGRXejgzdlBLa1RJ?=
 =?utf-8?B?TTE1dVo1RlVtSDl2SnlROHpXTWxPSkVGVW1hT2x4OFhSUDlwR0IrWU9uM2NI?=
 =?utf-8?B?em9wK3ZwazhvL05WU2hYVnhyNmRlOTM2R2FpU0hKWHRpVHZ1UDkvRlVZQjk2?=
 =?utf-8?B?UklUL3JFcnBPaGd0b1NtOUllYXVRcCtqZFUzOUFZWWFYYjdQdU80WC9LUDFI?=
 =?utf-8?B?cElLdHo4SU01bGZscStISllNQnRNMVBjU1l5a0tXY0tYTkNkY2l1UW9LaWZw?=
 =?utf-8?B?a2ljRGEzb0VDQzNvWTMrdE1sdWR2cUZ6R1pQY0FaSWJHZFpLMDdwWTRIWUVs?=
 =?utf-8?B?Z1NBMWE1VU1GdUkvcXBXVjFoTEVZZkc3M0g5RUJhemhYcWJtR2xXU2VYbEhS?=
 =?utf-8?B?V00yTnFVdXA2UjFXVkhjdk1EV0ZUcnhBeGQxdG51cE5xOEswOGs5QUZETFIw?=
 =?utf-8?B?VnRValBYT3ZCUmtCcjlFcSs4ZHF5VTNSS2YvUXlKQmhOcS8rSXFubCsvTHp6?=
 =?utf-8?B?a1JneVErZ2s2ZjBnOE9FOGdJeFE4OWROMHRucHdYUFg2V2FpbWJ1cXF0MU5T?=
 =?utf-8?B?K0ljQmtzUWI1Z3I4ZW5hVWRCOGdMTDFqL0pTQ1hYSjNEaDJiVEI2elZtc0kw?=
 =?utf-8?B?TUl2QWFoMEdYNmUxU0ZHdk1ZQ1V3Vk92TUdGRUx3M3M3VS9nb29NelZpK2tk?=
 =?utf-8?B?eEF2MllwVUN1N1JSNklLR2RnR2dFcFpYKzdUck5YZkRuUlVMUHQ4eWp2R3M0?=
 =?utf-8?B?MVZqanFVeFNpaVB0Z2R6RytrMFpkY3RxN0FHRlRVdXF6R0t3SzNpMkxkcFFt?=
 =?utf-8?B?MHFRZW1Dell1MTEvSDZZK0VqOGpQWG5ZNlA3cjVLVTJ4QWFyM1VXc0VxQ1M4?=
 =?utf-8?B?WFVlVjZKTmVtQjFuNmUwU3V0b0FCRm9lNGYyUFVnblRvNFRFa2dGNEowT3Z4?=
 =?utf-8?B?eDlpODcwdTZ1c0w0VVQyYzlwZVlNSTNMdHJNTUxRSEFlMWJWTDQrT0g5Mmt5?=
 =?utf-8?B?bCtmL3lvRHhueGY5K1FFelEzazcrbjA1amRGckhPa3NuY1ZWdUllQkhYVG44?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70bec18a-7022-43d2-ce80-08db42c79142
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 00:21:50.7744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ytz8sYp9WiM1L0GczdmajfEIrrAvF4MXj7kF9SfLqTyLyv3MhLinX3cbAmGhjd3c73d5kvvNai78xMT/CZ5BfWGI+Vyp6gNkXf/GpZntvIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6304
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 4/18/2023 4:45 AM, Ilpo Järvinen wrote:
> The measure_cache_vals() function does a different thing depending on
> the test case that called it:
>   - For CAT, it measures LLC perf misses 2.

What does the "2" represent?

>   - For CMT, it measures LLC occupancy through resctrl.
> 
> Split these two functionalities such that CMT test calls a new function
> called measure_llc_resctrl() to get LLC occupancy through resctrl and
> CAT test directly calls get_llc_perf().
> 

The changelog mentions 'split' but the split does not end up the same for
the two usages. Why does this split end up with one usage moving to a direct
call (get_llc_perf()) while the other usage remains with a wrapper?
Why not open code both?


Reinette
