Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBB67A4097
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Sep 2023 07:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239654AbjIRFta (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 01:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239714AbjIRFtC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 01:49:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E06123;
        Sun, 17 Sep 2023 22:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695016137; x=1726552137;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0uxn2r7+ZkAz+do7+nd8T3yUSdhehqgmeqsYfRcwVOQ=;
  b=KGj1CRI4jbw378cH3/jCMh9Agh+xIXkPMDZ1b6aKJPXdb8816U+9nsTb
   qEaWkIrtEphGwtOIpwuTYyE6KCtFy/DLh1LqPxPFSTco2U//sndAsNB0y
   /yZxGN/kS/TAxBC5Aqqa9GuqtTnVY5dpfiA1QWDb22ex7fXs1s3ZsUGI2
   0kCFmkB/LJidxFxCb7IBAWffgyVZuodAEwU+Rql4rLM5bSWlYFCXYoBEx
   VFn2JXLtBZIruHgfc2uJl4LDNNmpB0PBdPsYlVB7oPMtBXQllJPZa2HMr
   cLML/o/B5dxhRJNKUEQcIwPfIV5dBWCGyDJ443hqKksMQxQe5DTPqOn0A
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="382313376"
X-IronPort-AV: E=Sophos;i="6.02,155,1688454000"; 
   d="scan'208";a="382313376"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2023 22:47:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="748886108"
X-IronPort-AV: E=Sophos;i="6.02,155,1688454000"; 
   d="scan'208";a="748886108"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Sep 2023 22:47:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 17 Sep 2023 22:47:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 17 Sep 2023 22:47:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 17 Sep 2023 22:47:47 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 17 Sep 2023 22:47:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9q5pqQDuoJ3T8K1F3ivBXlIQHTfF0hDf1IrT99k7sKpPpGN5FUckOexEqgovUTmjXZMietlsn70HlPm4JZhBMMOQljYRCs4n9ak5hXuU/RDSwR85WCMFvXQClWRziMNahErjr3sTJfqR2Kaz+UIdNz+9wGfveqMpT5aqTuKsgkarj31tA+6WFqykqyXGz6dE/zp/5aklv+c9fTdpSrW0izKgHOsGptIRGXYhPwe6OG5bn+QmHukf6mhlyOG0BdRdwgxkQRPOqNKRzZ32oPNuo67uL34AyAOptezeqT/p//zgmrOh0CuBj5NoB0p4aNEspzaJX/xifGiYhvW9G5jCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utF1qX0wBg6UnVhdRzXgKFLdCjHg2+4FDFMiLvqF61Y=;
 b=Rjjh93Kt3VUVK3wO/I2yw1ajRINKT6eB1TJ9n93KO8RfwsCNp8OkS6Eh1ujOPVk/VMrpFLpA7KrFRTGTsc8+8Aw8ZVgv/Y5AUZAPLdJyEiVv+h8PuC5Vjbs6p5+ABHYpyRJRYGEwnZnw3bJPu+BL8JUlXIbc36F4PGo/B9KfINgF5RK68cSFzBhNVUNj2cF0IP9ao8zjWPhaDgAH8xEIDUZOz9Aa3ixCi7ep/xGf80Y/jTrgfn0WwaYFdejmqJ2/q+1I9dT8H63+5pxc8ZarSWr/blltj0V887SknJkdOyveKSTAHRqDkS7a4Dr1tzuatiKuXD/3ebEyM5VNYFP9CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by PH8PR11MB6999.namprd11.prod.outlook.com (2603:10b6:510:221::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 05:47:40 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7edc:de45:7f2d:9ade]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7edc:de45:7f2d:9ade%4]) with mapi id 15.20.6792.023; Mon, 18 Sep 2023
 05:47:40 +0000
Date:   Mon, 18 Sep 2023 13:38:11 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Jinjie Ruan <ruanjinjie@huawei.com>
CC:     <sj@kernel.org>, <akpm@linux-foundation.org>,
        <brendan.higgins@linux.dev>, <damon@lists.linux.dev>,
        <linux-mm@kvack.org>, <kunit-dev@googlegroups.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND 2/2] mm/damon/core-test: Fix memory leak in
 damon_new_ctx()
Message-ID: <ZQfiQ/xGy4396N9A@feng-clx>
References: <20230918051044.3814018-1-ruanjinjie@huawei.com>
 <20230918051044.3814018-3-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230918051044.3814018-3-ruanjinjie@huawei.com>
X-ClientProxiedBy: SG2P153CA0042.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::11)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|PH8PR11MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: 11c32f8f-3113-4b16-ee74-08dbb80ac448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AY5DF2mZQ/YyPY19xA2VnRV34rcgLWnzhxuYJj6n4d7VI+9JOzdPdRHvupj65b6s0VKQDN5skb8RkHm1wKfJpOHHo7pAnGPFtBNOaZnxyy04XlUVEdQ3tHMbLpponBipztQ7rZT/BfMchci+Mn+C3PAys8YLDX+oqKDMzcbxqjuape6KZaOObiiVILsQ6iYKuIt1BOWVFoLrK0gr2VnO4Ub1RMmKhShJIhPslOG7oQ+OlX8DYC4thSgUvS5u82cXlqE/tNLP332iQ26mEddZRD3GiE1PUER7+sGVznowSRRFoK53m/9CKvXeaI2qKEaMtOc2WDwbDfSHKP66G/6mQXOs/oVHyuZhwGG13gNDrHQ5BX+3Y6M4aHGVjRPHqwTc6kWwgjbZMbYYPJi20RhFfq7QAe75qmzGsw+8r0LrF5O1O4SobVPjjEnwAmuUgRABiPyF/dd3FHYuMPoRhnc1B1yhhjKsYVbU28iI0JsQO53/GH6AtOWZw6yo+Tpf5AOp9LRunOMm+P6+ocXZwTrIvu9O0HP/sKJeiAmvrNAocW/SHN6kub2bBS5BQSw5mGrS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(366004)(39860400002)(136003)(376002)(451199024)(186009)(1800799009)(6506007)(6666004)(6486002)(6512007)(9686003)(478600001)(83380400001)(26005)(2906002)(44832011)(33716001)(66946007)(66556008)(6916009)(316002)(66476007)(4326008)(8676002)(5660300002)(8936002)(41300700001)(86362001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gd4Il06anZ/g1SSXtqgIFVGTh/q7YRygGZo41kijfAWzX8RxdrDMNLTquu7e?=
 =?us-ascii?Q?4y4Og9Vn+1kKyaXPPZYuozJbA3lwhWRowWxnuxqhXzSDX5pAwTvUnyH7tpf1?=
 =?us-ascii?Q?WSarj/MFOnVNbpvXVq+2KN85bJg8uulm6PI9YBpzpkt0paArCv/gu6VY/TJT?=
 =?us-ascii?Q?PNaU3X6dALiwGzRzg2h7UmjLjiuaox8mbT+FHdLkchpFnMOUI1F8f26LP98V?=
 =?us-ascii?Q?YMVabAlgLjHwG65zrnVy5VlisRhL7Ue5Wa2SWu0xA7aZafjaboofYCSfRGNa?=
 =?us-ascii?Q?cJj8jkT1qeeiZ3EyHCDOR0xYYOz+JIHQZLkNHY/72GfZAYMKryrc/R7tVgwE?=
 =?us-ascii?Q?sTNiqSl+Nkdx1H/Dc9VUNaitbSP7Ns6rgX2Y8i0LgKCWXb4QDZ/LpUF3/2Zj?=
 =?us-ascii?Q?/+DlB9O6rrLn6E4Q+KIBLc6UfT0ZQ4HIT6wXGteVtpsUtB+vbzh3F+KKnciz?=
 =?us-ascii?Q?88tsxLGJl6Fy9b8D/tMIrI6cmCssOHCVAZRzIR9PjzR9zRZrdvZ0BXXbEaSM?=
 =?us-ascii?Q?YLB7WOZ2Tb9Ohmyh7jc7CVhViIQo02vI6xcFWT1S87uHFcCKhVOC4fI2JcZh?=
 =?us-ascii?Q?ynQKBLMhONlok0x1r3m6SMg29Uz0FCbaRj0MIItjxAisUqT2LPdKtB62r7iq?=
 =?us-ascii?Q?fQliVfBoXHlPRP8SP2fFlYNABDL/4BQ3OtAD2yy8uBOwRL2MQfPWSuKUA2Rz?=
 =?us-ascii?Q?MJj5qZqEHLQrnsFOIUf+niyMFHpYbysOTpLy61PBtnfLVLW2bS0VpextfV1X?=
 =?us-ascii?Q?QMn6WeRTpjnnsmrgpszmHKqBNOhysBvMXigv7nUvzL1TN0qcKMjHJL1INAgc?=
 =?us-ascii?Q?eXl+KyAQ6rzlQr5vJ7ycFg0rdvUiM7C9CghqCPfI/bkDs/DEpyStlfi4/78j?=
 =?us-ascii?Q?ja3Pds6FDM44IGHA3ZA2ztorcDc4PnAOYmcAQfc8JjVx07Hxtv/ClFqiHV4Z?=
 =?us-ascii?Q?ymcIjzqJk66IROsy8ErtgTjnHxGutOxRInsb6cpagRlUT3VIOfpLnrfsMWo+?=
 =?us-ascii?Q?jESmzgsNzp1zGnuH3E1VnZ1J6uoiO77FSculUX6fBb9JuXcqqGvQpQpEkra5?=
 =?us-ascii?Q?parGE5uoDSS4GDNQwsu2LNZGnLew4E1oLx8BzpPaqRr42in7rE/tr+X4RCRl?=
 =?us-ascii?Q?pNG4/YYi2ugXCigWTus2TKDVbIv7Pq9nefvHcdrG+egpKRJrBfyuvhPkjm/0?=
 =?us-ascii?Q?r21++JKN6WXny3bDv/GBheComLHY3AhREio4pHBCuE2YJrRsF+WYEr+wIPo3?=
 =?us-ascii?Q?rt0/egOS7gP7EajvTFjzUxiAKsMa2tM5rUueLWSxU0wt1bnkn+iTWt0nq4nh?=
 =?us-ascii?Q?nVBjZ84EYyheXjG3tEBLBaB7U1yhKfXPxYNtuwwa+BG0hkmsrUS4rYdpF2iD?=
 =?us-ascii?Q?9wSRW5RutuJ24rhRJ/eKtWMJdMm+htqXU7JwXFst5/XHTeqXhVIwYbaPJ1GL?=
 =?us-ascii?Q?v1y9VmncXhvNxpKv9MtOrJ1hm40Me/EC6CCnklQ5WOfbyBj7G6zPJVgRHSzx?=
 =?us-ascii?Q?FgiKpC5qfeiL1kAIH4uTuSTvte4xYISbKgWtusbZR0Hx9+lYIse4naE3cq5e?=
 =?us-ascii?Q?X3XsdkrUZDUsf+VYnJ0yltBbIH+bIK+dHaLai1vh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c32f8f-3113-4b16-ee74-08dbb80ac448
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 05:47:39.4220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+Ejd9vyctEiKCy7DI0VySZ2qUXLubpnGFFP1uYcJNUh2x7Sj6+Swjh7tCBslSqRvgnunaBXRtrJ5gDfiGTyWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6999
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 18, 2023 at 01:10:44PM +0800, Jinjie Ruan wrote:
> The damon_ctx which is allocated by kzalloc() in damon_new_ctx() in
> damon_test_ops_registration() and damon_test_set_attrs() are not freed and
> it causes below memory leak. So use damon_destroy_ctx() to free it.
> 
> unreferenced object 0xffff2b49c6968800 (size 512):
>   comm "kunit_try_catch", pid 350, jiffies 4294895294 (age 557.028s)
>   hex dump (first 32 bytes):
>     88 13 00 00 00 00 00 00 a0 86 01 00 00 00 00 00  ................
>     00 87 93 03 00 00 00 00 0a 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<0000000088e71769>] slab_post_alloc_hook+0xb8/0x368
>     [<0000000073acab3b>] __kmem_cache_alloc_node+0x174/0x290
>     [<00000000b5f89cef>] kmalloc_trace+0x40/0x164
>     [<00000000eb19e83f>] damon_new_ctx+0x28/0xb4
>     [<00000000daf6227b>] damon_test_ops_registration+0x34/0x328
>     [<00000000559c4801>] kunit_try_run_case+0x50/0xac
>     [<000000003932ed49>] kunit_generic_run_threadfn_adapter+0x20/0x2c
>     [<000000003c3e9211>] kthread+0x124/0x130
>     [<0000000028f85bdd>] ret_from_fork+0x10/0x20
> unreferenced object 0xffff2b49c1a9cc00 (size 512):
>   comm "kunit_try_catch", pid 356, jiffies 4294895306 (age 557.000s)
>   hex dump (first 32 bytes):
>     88 13 00 00 00 00 00 00 a0 86 01 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 0a 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<0000000088e71769>] slab_post_alloc_hook+0xb8/0x368
>     [<0000000073acab3b>] __kmem_cache_alloc_node+0x174/0x290
>     [<00000000b5f89cef>] kmalloc_trace+0x40/0x164
>     [<00000000eb19e83f>] damon_new_ctx+0x28/0xb4
>     [<00000000058495c4>] damon_test_set_attrs+0x30/0x1a8
>     [<00000000559c4801>] kunit_try_run_case+0x50/0xac
>     [<000000003932ed49>] kunit_generic_run_threadfn_adapter+0x20/0x2c
>     [<000000003c3e9211>] kthread+0x124/0x130
>     [<0000000028f85bdd>] ret_from_fork+0x10/0x20
> 
> Fixes: d1836a3b2a9a ("mm/damon/core-test: initialise context before test in damon_test_set_attrs()")

Thanks for the fix!

Reviewed-by: Feng Tang <feng.tang@intel.com>

> Fixes: 4f540f5ab4f2 ("mm/damon/core-test: add a kunit test case for ops registration")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  mm/damon/core-test.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
> index 255f8c925c00..ce86ed30fb47 100644
> --- a/mm/damon/core-test.h
> +++ b/mm/damon/core-test.h
> @@ -266,6 +266,8 @@ static void damon_test_ops_registration(struct kunit *test)
>  
>  	/* Check double-registration failure again */
>  	KUNIT_EXPECT_EQ(test, damon_register_ops(&ops), -EINVAL);
> +
> +	damon_destroy_ctx(c);
>  }
>  
>  static void damon_test_set_regions(struct kunit *test)
> @@ -342,6 +344,8 @@ static void damon_test_set_attrs(struct kunit *test)
>  	invalid_attrs = valid_attrs;
>  	invalid_attrs.aggr_interval = 4999;
>  	KUNIT_EXPECT_EQ(test, damon_set_attrs(c, &invalid_attrs), -EINVAL);
> +
> +	damon_destroy_ctx(c);
>  }
>  
>  static void damos_test_new_filter(struct kunit *test)
> -- 
> 2.34.1
> 
