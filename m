Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365736EB663
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Apr 2023 02:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjDVATo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 20:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbjDVATm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 20:19:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA302716;
        Fri, 21 Apr 2023 17:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682122774; x=1713658774;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ouNDz773DeCxFA7PN9OmfbLGfIRFHNlFIbj+MFXzuV0=;
  b=RLJ8HoqgP/8CF7KVEBp5T/2CKJ/fYcbXkoa3iHuwmzlfjw9Eobv1BPz7
   sQc3OUyvZc2N3fjd9clr8nbqm4hUlvkpxO3pRMIbLIdsIzBuSm00myop8
   ASjqQNLJej17GyT7WpHwnH+o4DO2JtC8T3Lfpb3xAvFv5cd3ExJUlooa7
   XiqtiUYXn1H7U2+17vNKoGUQZqaTjClFn0u6267Ou4XtVEmztq+Y4oZg8
   BK+4VjRo/p93SSBE1mdKHT8n0JCPNxdwroV6vHqwyW7vvdiv1HdhM1iWR
   c3KC8GUdB8ZfBRQDyAdbluaN5fTVC2BVLxaKTGuo6x6wwzDe7V/OtgxkV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="346129005"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="346129005"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 17:19:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="722937684"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="722937684"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 21 Apr 2023 17:19:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 17:19:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 17:19:33 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 21 Apr 2023 17:19:33 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 21 Apr 2023 17:19:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jkz6FeGcd7SgEFrzCJGEB1btr4LoFMwCdd2A5RdtiCmNmL4vmEL4G/8uamTMDxhBQ2I1JCPxvO/VCjTMlwDn8LwqXncKMg/89sXR/G8j0t65x0X10ZO/MV+1SoBH2rKnscd9lyRBPKm252aZ3OzpfV3LKtXGgbWG11BGUu5ymcrirogY2kJGJwmffvVxPpENG+InDWGCEdagTiap77V4fJecRKii1nKAuhsnxcJ+r7CV577Dl8VxBNOO+cmzLm7KjxGEF0tJqAlGQmlfh5QIsQHdLs/NqLRqWTvsiTlWgUQNLoFM6cj0J3ZjHnqud3JDO5wBTl4wKfZqnjAgsu/Yxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCNka+nSJVt5GnWRcHSpbT4tc6PxI9Lqo33NyDu8QYI=;
 b=NhNXQfct36Bq4RPo3IhAI0jVw7Legn7yKvfD4x+aBuSBiUdaRG8nUVcBeqpESyuOFtpaOBDRBd+ZSlL0e/TjDpOTLLBGv6yZ+qMGCCNnbikZRBIqrv7HsEfGfs0lj1kOcaybgziOLiC+8hONzEHmFW66nQrE+7RruR73PLIyWmYGGhUIm6Z7t9Wan7N5QDXATM7In6ZRzoGP9+cq59heoKVdxOY0Yu+ADf8MVZH+zSI4bTEsVMoX0o3+zkuzRMknFN2uamFrtdfHCsD8zAsKqXf7f9VWXHRN1FZAKG/goUWw27Z1LyxA0uu4sg0IQ1ojaLSMFMuXAF4geZANTGuhAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SJ2PR11MB7715.namprd11.prod.outlook.com (2603:10b6:a03:4f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Sat, 22 Apr
 2023 00:19:31 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6%4]) with mapi id 15.20.6319.022; Sat, 22 Apr 2023
 00:19:30 +0000
Message-ID: <287e5f1f-87d5-473a-2bff-271adca8d458@intel.com>
Date:   Fri, 21 Apr 2023 17:19:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 16/24] selftests/resctrl: Create cache_alloc_size()
 helper
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Shuah Khan" <shuah@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
 <20230418114506.46788-17-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230418114506.46788-17-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:a03:180::28) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SJ2PR11MB7715:EE_
X-MS-Office365-Filtering-Correlation-Id: 97cc1868-6611-4dec-7dec-08db42c73d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +dBRv0kJdBVSwVpToYhGNQNPW9Lfc7LVrGVyA/TcMbG3yXyXC8kbg52OtFW3nJuKXt4Sqo0JZCI5/1i1vUdODo2w5377JrA76fxxG11W9MU/CwLzyQ10Qr74UZMhxsN6THQPq1m37kxRpQwxOMRqZtrAC9VRGjZrtvTT5gx9C6P/s1s3SB4ODhY+P0qn+s9fZLkKw0BA8CHqAKnVnlWs0oAIlLJKzM4QxyzbA7rIL8XMdJQG1Ma5ljFNvmf1IOKATYJ9AFxvIO1IQeuhWGsS/twWiB5Ov1d9EGjZNRUqzSK+BFOPhIaXBlKgTksp0/YuQcHtpvxwwJUHzXIdQcxPkDa5DtnttFjlrqjdDs2OTzH/dsLIv3HHcUgu2zp4MXzGomD1XgjYpLeOyxead07Qdl84JdX0bhzLwjBDxJE2OXn0noCap7CHsNj2LCJ6ejrBdpdDguQZqzmf10HdVk+6ZLT3CpALyrv6DpUKkXK1avKgS19BmVYh1/FVlSBIVW6apmSNt4ySvb4reEnN2IbTd2UY0dAUmuNBx6Fp1egFUafi3fk4MLsXL1LaqrlaV3fIpPn5nSfyXHhvmD7ZcEdWm0Nw38fOZ4u+jNxBHYqsLCsKC1yiZH0Pxw8/Ap/Lqb5rOnltXQPBqCJchUf47wok+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199021)(53546011)(6512007)(6506007)(26005)(186003)(2616005)(8936002)(8676002)(44832011)(5660300002)(36756003)(41300700001)(31696002)(110136005)(86362001)(316002)(82960400001)(38100700002)(66476007)(66946007)(66556008)(4326008)(6666004)(6486002)(31686004)(83380400001)(478600001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVd3bzZXNHN6ams3YXpGamV3Z2M5QnI0NGdZWE5ROER3bnpUQjVrT1lqbG5a?=
 =?utf-8?B?aWJJMmRTaUh5UkJmdUlCcnFYTnY5enYyNnJKZExHYmhCOHRsOUNnaFhETzR3?=
 =?utf-8?B?ZkJaYXczWUhxMmZQZ3pGUXpaZjZ6RFlMOVMwWU9TZStpZG11amdwbGU2cXFJ?=
 =?utf-8?B?blljVFZIWEZDRkZtT254cXdXVUlIYUdSUjhKMkE5MllPbnpOS2ZZanpCcVRw?=
 =?utf-8?B?bENsMWxPSm16eWxkYnNKaTNydnZOWEFVRGhvSzNGUTdrRnUvcng1QXM0MW9F?=
 =?utf-8?B?Zmk2NFQrK3NWK285TFF0VFlGU2ZTWlNXTWc1YzFOMHFHb2hWMURLaG43NDE3?=
 =?utf-8?B?Q2FHbkJXUkM0bFgxK1FiRm0zbGlVWGg5K0FjWHdqMWcxZmFadm1iK0V3MUZN?=
 =?utf-8?B?Ti92bkM4ZkxSNWZyUysrczEwaXNIcisvbzJXOU9WS3VmMDAxbDEyZDVkU0Q3?=
 =?utf-8?B?bzFleUJjYmZLRTVUOVJURFJvZUE0T1A3QzNGUzc5M3FxS2lTUk0xd0hLSmxL?=
 =?utf-8?B?WldpTExiWFhiSEhpQVM1NWJsZnN1Z2h4MlowcUZJSVBUY1ZhQWdVcGhXSzRR?=
 =?utf-8?B?MG1TSmVaRnREbE9HRmQ5NFR0dVFMbTFleXdaNGxlcjNBZUxvUHFZQ1JiQUpx?=
 =?utf-8?B?ZWZ0U2FDWmE0RkVHaVN1akFUODhlTVVDb1ZGWStZdGRPam5scHBpeTI1SXVw?=
 =?utf-8?B?YmpxOXQ5azFWWmJDWXFGTlBhVzNHek5UK3BCdHpFNnlIVll5ekNYcmI0NWlL?=
 =?utf-8?B?SVl3YjIrZXJnVFFyaUF5ZnpZNU14Yk15eDlHaERxZWZqYVJUVnlqaS9NZ1dk?=
 =?utf-8?B?Y1NsR3E0ZkFPd0FaUjE2clhMY1ZlZnp2djErck9UeHppQW1oeGZtbksvYUtG?=
 =?utf-8?B?d2ZVTUJQcTA5STI0V3RIa0hDd0xyaUlibStMSGd1R1I0S1AzZzhUbS9ra3hJ?=
 =?utf-8?B?U0V6Smc3ZkFmeUNvTlJOM1NISVc1ZjZrQjNhMzJoL2RIS3M3YUFSR25kZGVu?=
 =?utf-8?B?QlFMYm5TNmZudFkyVDRXT0xiTHl6aHpxbUV1N1ZzL0Q3TVhROG53MlZ2SG1X?=
 =?utf-8?B?RXBrYzRhS25OTXFVdEo5RW45SExvcjNUN1YxbXhYcTdLZ1Z4UWtXMGUxZTJT?=
 =?utf-8?B?elpxempIN3lWV3pDRVlQMGRlcGRWZDVLcytvQ1RDQlJBME00TFNWYmV0bm9H?=
 =?utf-8?B?T2NUb3RTZ0xOSzNEVWVQS3U0Y2srb3NKMUZSVzJwQ2hmaVRVVGF5cWFaQytN?=
 =?utf-8?B?ell5NVFxWENmZGJuOTRxOFFTY1JENGZUZ1BLNER1NFYzdFF2aVJkK1lXTnVk?=
 =?utf-8?B?NFN0d2hMRTlvdU5raDdsaU9LMDVXNFVZRzE3cThEalRuZzIzN2VSWGh1MHla?=
 =?utf-8?B?ZVJ1RFN2YlBScTJWYkF4MWkrWVM5WllYY1ZIRXlqVXBtSHlhTVdaNE9UWm9W?=
 =?utf-8?B?M0IyVjBhZ0RpMmVud3B4WUxOZVMyTEFGR2pLQ0J4Mmx1MjIyK0ZYQVlhTmNQ?=
 =?utf-8?B?ZVFaQStBK2RRUXV3UXpLbG5hejNnaXFVdmdmbTJuN0x3blh3c1ZQK0xMcExm?=
 =?utf-8?B?a2tVWHlSVFh3TmpKVU5YT1FpeWdpcmpuRVBFbWJ0OEQ2NnRCeSt0TjBtZFRH?=
 =?utf-8?B?NmhtSmI5Q0d2ZWlndno1UXUyTXF2Z0lQVHBqd3BKdWtZMnVXcnB2TEh4eWxB?=
 =?utf-8?B?U3JEa2Q3aUIvVEx2NGIxYVhjOXpCVTg3ZWJzcE1wQ2V4dDFKKzRGRHYxaUlD?=
 =?utf-8?B?Rm84WGhHNFdGekZSc0lVZ3E1UFM1WnY4cVJVLzA1NmdNcUY1cndCeWc4dnp2?=
 =?utf-8?B?bUhxT0tGNTZXZ3R2ZTFrK1ZYcEVOdWpsOFZhK3Q5RExDYjlYL2NKZkkvdU1P?=
 =?utf-8?B?RWMyZEIzNDZQNkMydDJRUXRDMFkreGhZeWdaa1psZnZhZFFQa0o0WkJBQzFy?=
 =?utf-8?B?Rjc3VDlDQXVVanRpendVV0hLeTU0TEZLVkkvS3U3Rmp1QnRINUVXRVd3R3ha?=
 =?utf-8?B?bjE0R2FnSE1MQ3JxazZMRlNOZWpJaHM3SWh3emo2eXhZVGExaFpmS2dmR0Nn?=
 =?utf-8?B?eTJha0Z3and1U2FPV3lwd2tNa2VjMXorbGtwMU9ITzJIU3M2UjlsNGJFMDJ6?=
 =?utf-8?B?ZjV3aVE4NVd3akpGZFJiTlpZcnRGY2g0VFczdXFESktrQ2RveW9SbDZLdmx4?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97cc1868-6611-4dec-7dec-08db42c73d75
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 00:19:30.2693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgOoSyuZ6WDQsOvTAvw1ekRn47Veuycq+TaB9H3B9AftV7VqS8NXge6mZ9lrz3wCS9gfpuic7HTIKUUpFwOTyCBwB8ZO8Vm4oljxBADlCYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7715
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

On 4/18/2023 4:44 AM, Ilpo Järvinen wrote:
> CAT and CMT tests calculate the span size from the n-bits cache
> allocation on their own.
> 
> Add cache_alloc_size() helper which calculates size of the cache
> allocation for the given number of bits to avoid duplicating code.

This patch is very heavy on the usage of allocation when I think it
only refers to the cache size ... how that size is used by the caller
is independent from this. 

Compare to how it sounds with some small changes to changelog:

	CAT and CMT tests calculate the span size from the capacity
	bitmask independently.
	
	Add cache_size() helper which calculates the size of the
	cache for the given number of bits to avoid duplicating code.

I think removing "alloc" helps to convey what this code actually does.

> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  tools/testing/selftests/resctrl/cache.c    | 27 ++++++++++++++++++++++
>  tools/testing/selftests/resctrl/cat_test.c |  8 +++++--
>  tools/testing/selftests/resctrl/cmt_test.c |  4 +++-
>  tools/testing/selftests/resctrl/resctrl.h  |  2 ++
>  4 files changed, 38 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
> index 6bc912de38be..b983af394e33 100644
> --- a/tools/testing/selftests/resctrl/cache.c
> +++ b/tools/testing/selftests/resctrl/cache.c
> @@ -15,6 +15,33 @@ static struct read_format rf_cqm;
>  static int fd_lm;
>  char llc_occup_path[1024];
>  
> +/*
> + * cache_alloc_size - Calculate alloc size for given cache alloc mask

"cache_size - Calculate number of bytes represented by bitmask" ?
Please feel free to improve.


> + * @cpu_no:		CPU number
> + * @cache_type:		Cache level L2/L3
> + * @alloc_mask:		Cache alloc mask

The description is mostly a rewrite of the variable name. Can it be
more descriptive?

> + * @alloc_size:		Alloc size returned on success

I do not think the utility should assume anything about how
the value it provides should be used. Instead it should just reflect
what the value is.

> + *
> + * Returns: 0 on success with @alloc_size filled, non-zero on error.
> + */
> +int cache_alloc_size(int cpu_no, char *cache_type, unsigned long alloc_mask,
> +		     unsigned long *alloc_size)
> +{
> +	unsigned long cache_size, full_mask;
> +	int ret;
> +
> +	ret = get_cbm_mask(cache_type, &full_mask);
> +	if (ret)
> +		return ret;
> +
> +	ret = get_cache_size(cpu_no, cache_type, &cache_size);
> +	if (ret)
> +		return ret;
> +
> +	*alloc_size = cache_size * count_bits(alloc_mask) / count_bits(full_mask);
> +	return 0;
> +}
> +
>  static void initialize_perf_event_attr(void)
>  {
>  	pea_llc_miss.type = PERF_TYPE_HARDWARE;
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index 9bf5d05d9e74..d3fbd4de9f8a 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -140,7 +140,9 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  	/* Set param values for parent thread which will be allocated bitmask
>  	 * with (max_bits - n) bits
>  	 */
> -	param.span = cache_size * (count_of_bits - n) / count_of_bits;
> +	ret = cache_alloc_size(cpu_no, cache_type, l_mask, &param.span);
> +	if (ret)
> +		return ret;
>  	strcpy(param.ctrlgrp, "c2");
>  	strcpy(param.mongrp, "m2");
>  	strcpy(param.filename, RESULT_FILE_NAME2);
> @@ -162,7 +164,9 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  		param.mask = l_mask_1;
>  		strcpy(param.ctrlgrp, "c1");
>  		strcpy(param.mongrp, "m1");
> -		param.span = cache_size * n / count_of_bits;
> +		ret = cache_alloc_size(cpu_no, cache_type, l_mask_1, &param.span);
> +		if (ret)
> +			exit(-1);
>  		strcpy(param.filename, RESULT_FILE_NAME1);
>  		param.num_of_runs = 0;
>  		param.cpu_no = sibling_cpu_no;

Did this change intend to remove the duplicate code mentioned
in the changelog? I was expecting the calls to get_cbm_mask() and
get_cache_size() within cat_perf_miss_val() to be removed.

> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
> index ae54bbabbd91..efe77e0f1d4c 100644
> --- a/tools/testing/selftests/resctrl/cmt_test.c
> +++ b/tools/testing/selftests/resctrl/cmt_test.c
> @@ -105,10 +105,12 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
>  		.cpu_no		= cpu_no,
>  		.filename	= RESULT_FILE_NAME,
>  		.mask		= ~(long_mask << n) & long_mask,
> -		.span		= cache_size * n / count_of_bits,
>  		.num_of_runs	= 0,
>  		.setup		= cmt_setup,
>  	};
> +	ret = cache_alloc_size(cpu_no, "L3", param.mask, &param.span);
> +	if (ret)
> +		return ret;
>  
>  	if (strcmp(benchmark_cmd[0], "fill_buf") == 0)
>  		sprintf(benchmark_cmd[1], "%lu", param.span);

Same here regarding removal of code.

> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index bcc95faa5b4e..65425d92684e 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -108,6 +108,8 @@ int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd);
>  void mba_test_cleanup(void);
>  int get_cbm_mask(char *cache_type, unsigned long *mask);
>  int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size);
> +int cache_alloc_size(int cpu_no, char *cache_type, unsigned long alloc_mask,
> +		     unsigned long *alloc_size);
>  void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
>  int signal_handler_register(void);
>  void signal_handler_unregister(void);


Reinette
