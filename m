Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD326EB67C
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Apr 2023 02:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbjDVAc3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 20:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDVAc2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 20:32:28 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034B8E5A;
        Fri, 21 Apr 2023 17:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682123547; x=1713659547;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iVDlkUnYMm9OgcMRtrfjP1mFqBDdiCuu1sncp2hLNZA=;
  b=bJDUXi4pcFY/1SnFwj765xOSrYQNfU6Mm0EeKtDMUeNrTrHZbeHKpBqI
   9q/Yg3AN5eQ38pNpIpz+b0SVyLhsQ3jkg36OpqkZ4bMsLIDpQ/zUM0kbR
   BoKSX9BzHDUHfuriSn7d+AyDzebp5gkp4PBTgFhjGrdfrX/tTe7VLjvNW
   +JAkSbOC5xm9ldSxmynlx5bEKPlST9gWtGXDEV5+aM2Zqcp25y2ZBUMTZ
   XKT5pAeojKD3UZwz83JEhgqJrOAF/TzRPXwau9Y1zljje1cEK8rzNLsU1
   gbuiTYHiAdxqnuNKiy30HWW+ZLWu9C590urd6BvmVZI1E901xoKcgljNT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="411382542"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="411382542"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 17:32:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="938674332"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="938674332"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 21 Apr 2023 17:32:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 17:32:26 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 21 Apr 2023 17:32:26 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 21 Apr 2023 17:32:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=keRtrwTZ7jaEDv1+01i6bW8YmyGPodYFvjWzhrj9NsvesYblXaDQzS2QL1dlEyhlNW7MjAP6w5O+pDrfsDmWrYVvkfJt/dPrLk54134dZtkFalczptLS1BvpTa+ZaAhIFh4F8R6A4ewNO2xQIvAU8yP7o5XBvq9py+0I/jjSBouDrNhsHRXeqi7j9rgJCQT6B92gz7smDB7hft867xnwP4QojZnRyjm+VkGdw2TyfBs26lFyszrDPsLUJjh3Ud+ht2JFZVIIgrE75LBerZYzdGlbTqTzS9U5YusKSbNxdJJQE0NUgOgMW++DTM/7dUdqgkgdkhZ2lvpqU5F5zwbbPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2HzrtRX3OAGr3Dn3PWYRLq9CMw8cGMceJugMZED1to=;
 b=K2t/JbmUs2hXC0JGnbuDIZTvZE4jj8UbdHCESkouxKo6cAXnmI33038ymP5ozytBKMU5YukKSB/q0ClKqPwyz0KjPovXyiEgRaIsWNMbWpeUVzfD5DJRjbCx/9a1JM9t+xWBjmbKltO7Cqk8dgiXXq/tsiwIvwanmvBvd1TkCarNXbPK1yuKQ8iaCcVQ+PLyR31Xf2bSSxiOztRXKFK5YflWmYhrOINoLiqR3xsiQx9xyQlJIwwv4dy7hUH0zHHknMJdIieCzJL9q3XGUsiVqI7pCKryzPufEUOWcU0ATe1usP2/mHul7Mwno715j0YWH3uRv0gcpySBBMdaZKuZSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1867.namprd11.prod.outlook.com (2603:10b6:3:10c::13)
 by DS0PR11MB7558.namprd11.prod.outlook.com (2603:10b6:8:148::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Sat, 22 Apr
 2023 00:32:24 +0000
Received: from DM5PR11MB1867.namprd11.prod.outlook.com
 ([fe80::d3e8:6b88:a115:4fc3]) by DM5PR11MB1867.namprd11.prod.outlook.com
 ([fe80::d3e8:6b88:a115:4fc3%12]) with mapi id 15.20.6319.022; Sat, 22 Apr
 2023 00:32:24 +0000
Message-ID: <eac72c7b-bd01-084e-cf23-ec5e8e0e3cf3@intel.com>
Date:   Fri, 21 Apr 2023 17:32:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 24/24] selftests/resctrl: Rewrite Cache Allocation
 Technology (CAT) test
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Shuah Khan" <shuah@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
 <20230418114506.46788-25-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230418114506.46788-25-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0148.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::33) To DM5PR11MB1867.namprd11.prod.outlook.com
 (2603:10b6:3:10c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR11MB1867:EE_|DS0PR11MB7558:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a7f7681-8e92-4e9c-d0ba-08db42c90a52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AnCnXYQaBAe6y4GbQjXi/Y5W/U6VnhlG+W1BgJCUNjGJN0Vfc56jdRcxB8XsApsOj3Hl6KX33lccobarGJWbTwUBmsodGRaOJDvI/YATn8CGCJEFQAKmCxUPVBu8A2+a2kC8NS/wKwZUz7CzV37WyOJbhxhGw2TcIPnArJBjA+7By0DMqUQ2mt3MYu8gAAC+mq2G8Wd7uyBrojTwO0Obt10zccbB3PpS7BCoUx5D3ujoW4QrQqTzigF5QjKWC9RuTeZiffW5o8+sUSE78e38txrLVcbxZzzCav1BDA8+WDkCe/gEXy1Ow09jPhZUgSvS6ufM8OuBpSwRsIEQ/MPM/eCqA2Vk6ySAdehGbODPdtBKOiQYxz94ynKejBXyB2+2Br99y/hAWqD1XriQ2mDHLbCXMPxx2ZE50I/vR4jrBNFl74MAn57H0utEdgG4Wk3ekDSs8YU7lZ8vOyNilJVJ1m8g+9MQyFKTMtV/Hpon5DjmLNjn4DhLcvq56j67HjarHGZ9r2yKNpjGxOT+z5N+vAbHDPNhKOasMHBo6jwYyR+HSv5dcwoWKTkjUkC35HDhcsY1V0zZCxc2tjbYrzORWwoEHeNjzC2HunYGoC2DYQbR/ud/uaA4BEFWkOZuq7r1WcQv8qxH8VAdn0+wS+QZow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1867.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(136003)(39860400002)(366004)(451199021)(44832011)(2906002)(2616005)(6666004)(478600001)(26005)(86362001)(31696002)(6506007)(6512007)(53546011)(6486002)(36756003)(186003)(41300700001)(82960400001)(8936002)(38100700002)(8676002)(31686004)(4326008)(66946007)(66476007)(83380400001)(110136005)(316002)(66556008)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXNhNkdmVWc1dDBDN3BmUWl5T0plNDFrRzVySk9TL3RyQlJ3UERackpwR2FI?=
 =?utf-8?B?cytvbFZrZjdjWTJscVBlelRMeTVZYjlCNFlIdlM5RFhNVy8vNTA1aWFSYzZX?=
 =?utf-8?B?QWlnQ3VMdnZBaEdZZDhyZmVlT05DTDdKamlUcFBvdy9IM1lkSnNBcnFsNzB4?=
 =?utf-8?B?dWl5MG1aUW4wY0g0QlB2NVRpamdZSlhyRWRMQ0h6NWkxQVhrdWdlaDllMHIr?=
 =?utf-8?B?ZDdVU1VxeTVkUWpDZW8wNWd4ME00M2hLN1NyUS9ZWmYzVlJkc3EzeDJjODZE?=
 =?utf-8?B?d3dPYzlWVlBnVGhTY2JNMmVTOUkrZllENWo0TGp1a0l2dy9ObE9ZWDVMbnJk?=
 =?utf-8?B?dDVqaEVUTm8yWTJMd05qd3B2U0d0VWpwNEh6M0lDODFXby8zYklYaXdseWZZ?=
 =?utf-8?B?YzhxeW5qNDhvaXdVSEo4TzNkcjFHUDNPaTVyWE1FQkxiVXl3QkhBaHRDMCtM?=
 =?utf-8?B?UytUNkw1K0dvRjJJUmtpVzZWWG93L09LbVFxQ3lvNWdaVnJmaWlpOWltU0Yr?=
 =?utf-8?B?T2FjZTZPU2Y5eXdCVXBIZEplVUNTdUh6RlFJSmQ3SzMzbFVzOTZwZm5HVUp3?=
 =?utf-8?B?NzNubGdHejVuVHliYW1sNTlTdVE3dldsQmJOeXJOMm9qVmk0Q0xWUTFaODJ4?=
 =?utf-8?B?UVpmNWk4MzJSaVNDcmE4ZmVHVDBpMUhpR2N1cUh4MXZpTXIwdTZ5c2V6Sjh5?=
 =?utf-8?B?d3lNQXFGT2JsZjVnVVZ6NGYrdG9GZmZnM3FNanJ0R21qSGlIN2NDME1neVNG?=
 =?utf-8?B?bkxWUXN5YTVLYTBNc0hQQzhJL2hPQWJBdW5Qck1ndVNSc3JaTEhlN0ZSY3hy?=
 =?utf-8?B?QzhrdVlhU05nSThBM1pZaytQcmhZMklaalRRRmp3THMxUVhCY1lUMFlaZDU2?=
 =?utf-8?B?SG1JYUdNZVhaVWlyeEZqWVpOQWNWR3RrTmdjc2xvZ2w1Zm1hSnZnZWRHVU12?=
 =?utf-8?B?L0JNWXJkNkRFaXovTHAwalNBNXg1U0ExWWM3ck1wenBTU3BxSUdJYktEelBF?=
 =?utf-8?B?Z0lMNkMrS1hPbGFyRVBoaWx4eVpsRzhDekpoWWNpNnJHRXhZeE0vc2Z2d3RG?=
 =?utf-8?B?V01aQXE0dmgzdGFCVmRnZmNPSFQ4MklUeFBKWUh6Wk1pN1dSQUdzcjlnVXBM?=
 =?utf-8?B?ZXYxeHQyZGRTMys4Yi9ySDIwaDlHWnVrSkpXTnVyT1ZNTVRnT2o1VkFJbjZz?=
 =?utf-8?B?dnBuVWVIVU9lM1cwSFlnS1FHc0p4RjJFMGxDZ1JKRXRaMzdDdXVuN2V1R3BD?=
 =?utf-8?B?Y1d0UFMyYVRIcGZxVjRWYVBPTy9PWGZFS0JrTEFMR045c3U3TGUwYk40WktQ?=
 =?utf-8?B?TExpVEZ5ckx3UjJYekNudnhyZkJqMEpKQS9wR3pXRHhTUm5IYWt2aUMxcHFD?=
 =?utf-8?B?K0xMcFhKc0ZCWjEzckxrY0RqdXFPT2N0Zm5RQXFQcGhHMmVpaDd6clR2aHRp?=
 =?utf-8?B?eEZ5WG1SVzhSb0tpTnREdXE5QWNXL0F3azBsZnFYY2hZRXJieHZLOVRlZGd4?=
 =?utf-8?B?R1F4OXliSTk4cXlZUFdmc1lkRlFGdG00dDM2a3hBOHI2Y0g2aHJMUG5lL093?=
 =?utf-8?B?OEVnUzVxckRuR1hMZlA5M1J0V1kzOU02WDJrSlA3ZHdCaVFRZTdlM29WTFNa?=
 =?utf-8?B?NUh5VDdWVHA3aG96QU5JajB5azdHSzlaYTlNeFJOWDFEWEtyTW9vZEQreTN6?=
 =?utf-8?B?T0dLMWVERHAzdTRQWU1BUjFkQnJoM3JwWEpaOGxxamdZRHpjVXRISUlmMVhy?=
 =?utf-8?B?ODl6VlZ3cmRQajVMM2NFR0E3RjUxWkxCVTBQMWl2cVVFL3JKY0ZOVC9pQisv?=
 =?utf-8?B?RStJM25DR29aOGR2M043ci9mL2d6OThGdTdHWkJqdGdMdE9DS3U3dUZQWm5M?=
 =?utf-8?B?RVBNV0V3SWZnZmM0R2o3R2Z3UGtjY1N3TWpaSTZqdTl4Z0p3bkphaXpsTXBR?=
 =?utf-8?B?NXVPWE5XeUtvRVp4dTRmWEExMHFTUkNNRGdiQi96QWFZcEZpUGkvSWxtRDZo?=
 =?utf-8?B?aVNjZHd5T21RbVFJUWdnSHFJMnRIV3NsYkpOWmpRK1liK2xkcjlnU21wQUxC?=
 =?utf-8?B?TGZubmVXaFg2V0hPeko2WWo3Qm92enlDK24zUWo5SFFqYzhPUG96RmtUeUhs?=
 =?utf-8?B?UDlGU2w3Q2pqNS9Da0dvUGxoUzVlZzZScFl6RDJWaUExd3JnNUtueThZeGlv?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7f7681-8e92-4e9c-d0ba-08db42c90a52
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1867.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 00:32:23.6605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPiBdE2S7DpWamXAUAstIra9dYcshZgviZmAMAcgm8PCwhVwEtfNGnHZswp/ZvSktzcsJOlMmIrWr8ZZyuX7NTUOfae+mBk6Cqxv4Moxq9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7558
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 4/18/2023 4:45 AM, Ilpo Järvinen wrote:
> CAT test spawns two processes into two different control groups with
> exclusive schemata. Both the processes alloc a buffer from memory
> matching their allocated LLC block size and flush the entire buffer out
> of caches. Since the processes are reading through the buffer only once
> during the measurement and initially all the buffer was flushed, the
> test isn't testing CAT.
> 
> Rewrite the CAT test to allocated a buffer sized to half of LLC. Then

"allocated a buffer" -> "allocate a buffer" ?

> perform a sequence of tests with different LLC alloc sizes starting
> from half of the CBM bits down to 1-bit CBM. Flush the buffer before
> each test and read the buffer twice. Observe the LLC misses on the
> second read through the buffer. As the allocated LLC block gets smaller
> and smaller, the LLC misses will become larger and larger giving a
> strong signal on CAT working properly.

Since the changelog starts by describing the CAT test needing two
processes I think it would help to highlight that this test uses a
single process. I think it would also help to describing how the cache
is used by the rest while this test is running.

> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  tools/testing/selftests/resctrl/cache.c    |  20 +-
>  tools/testing/selftests/resctrl/cat_test.c | 204 +++++++++------------
>  2 files changed, 97 insertions(+), 127 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
> index 7970239413da..64f08ba5edc2 100644
> --- a/tools/testing/selftests/resctrl/cache.c
> +++ b/tools/testing/selftests/resctrl/cache.c
> @@ -224,10 +224,10 @@ int measure_llc_resctrl(struct resctrl_val_param *param, int bm_pid)
>   */
>  int cat_val(struct resctrl_val_param *param)
>  {
> -	int memflush = 1, operation = 0, ret = 0;
>  	char *resctrl_val = param->resctrl_val;
>  	unsigned long llc_perf_miss = 0;
>  	pid_t bm_pid;
> +	int ret;
>  
>  	if (strcmp(param->filename, "") == 0)
>  		sprintf(param->filename, "stdio");
> @@ -245,6 +245,10 @@ int cat_val(struct resctrl_val_param *param)
>  	if (ret)
>  		return ret;
>  
> +	ret = alloc_buffer(param->span, 1);
> +	if (ret)
> +		return ret;
> +
>  	initialize_llc_perf();
>  
>  	/* Test runs until the callback setup() tells the test to stop. */
> @@ -256,17 +260,15 @@ int cat_val(struct resctrl_val_param *param)
>  		}
>  		if (ret < 0)
>  			break;
> +
> +		flush_buffer(param->span);
> +		use_buffer(param->span, 0, true);
> +
>  		ret = reset_enable_llc_perf(bm_pid, param->cpu_no);
>  		if (ret)
>  			break;
>  
> -		if (run_fill_buf(param->span, memflush, operation, true)) {
> -			fprintf(stderr, "Error-running fill buffer\n");
> -			ret = -1;
> -			break;
> -		}
> -
> -		sleep(1);
> +		use_buffer(param->span, 0, true);
>  
>  		/* Measure cache miss from perf */
>  		ret = get_llc_perf(&llc_perf_miss);
> @@ -279,6 +281,8 @@ int cat_val(struct resctrl_val_param *param)
>  			break;
>  	}
>  
> +	free_buffer();
> +
>  	return ret;
>  }
>  
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index 4b505fdb35d7..85053829b9c5 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -11,11 +11,12 @@
>  #include "resctrl.h"
>  #include <unistd.h>
>  
> -#define RESULT_FILE_NAME1	"result_cat1"
> -#define RESULT_FILE_NAME2	"result_cat2"
> -#define NUM_OF_RUNS		5
> -#define MAX_DIFF_PERCENT	4
> -#define MAX_DIFF		1000000
> +#define RESULT_FILE_NAME		"result_cat"
> +#define NUM_OF_RUNS			5
> +#define MIN_DIFF_PERCENT_PER_BIT	2

Could you please start a new trend that adds documentation
that explains what this constant means and how it was chosen?

> +
> +static unsigned long current_mask;
> +static long prev_avg_llc_val;
>  
>  /*
>   * Change schemata. Write schemata to specified
> @@ -28,13 +29,24 @@ static int cat_setup(struct resctrl_val_param *p)
>  	int ret = 0;
>  
>  	/* Run NUM_OF_RUNS times */
> -	if (p->num_of_runs >= NUM_OF_RUNS)
> -		return END_OF_TESTS;
> +	if (p->num_of_runs >= NUM_OF_RUNS) {
> +		/* Remove one bit from the consecutive block */
> +		current_mask &= current_mask >> 1;
> +		if (!current_mask)
> +			return END_OF_TESTS;
> +
> +		p->num_of_runs = 0;

This seems like a workaround to get the schemata to be written. It is
problematic since now p->num_of_runs no longer accurately reflects the
number of test runs. I was expecting this mask manipulation to be
in cat_val() so that it is clear how test works instead of part
of the logic handled here.

> +	}
>  
>  	if (p->num_of_runs == 0) {
> -		sprintf(schemata, "%lx", p->mask);
> -		ret = write_schemata(p->ctrlgrp, schemata, p->cpu_no,
> -				     p->resctrl_val);
> +		snprintf(schemata, sizeof(schemata), "%lx", p->mask & ~current_mask);
> +		ret = write_schemata("", schemata, p->cpu_no, p->resctrl_val);
> +		if (ret)
> +			return ret;
> +		snprintf(schemata, sizeof(schemata), "%lx", current_mask);
> +		ret = write_schemata(p->ctrlgrp, schemata, p->cpu_no, p->resctrl_val);
> +		if (ret)
> +			return ret;
>  	}
>  	p->num_of_runs++;
>  

...

> @@ -126,7 +162,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  	ret = get_mask_no_shareable(cache_type, &long_mask);
>  	if (ret)
>  		return ret;
> -	count_of_bits = count_consecutive_bits(long_mask, NULL);
> +	count_of_bits = count_consecutive_bits(long_mask, &start);
>  
>  	/* Get L3/L2 cache size */
>  	ret = get_cache_size(cpu_no, cache_type, &cache_size);
> @@ -143,99 +179,29 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  			       count_of_bits - 1);
>  		return -1;
>  	}
> -
> -	/* Get core id from same socket for running another thread */
> -	sibling_cpu_no = get_core_sibling(cpu_no);

Do any users of get_core_sibling() remain after this?


Reinette
