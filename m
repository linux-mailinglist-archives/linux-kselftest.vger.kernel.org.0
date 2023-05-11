Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C805F6FFBF9
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 May 2023 23:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239385AbjEKVkJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 May 2023 17:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239382AbjEKVkG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 May 2023 17:40:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D4C7ED8;
        Thu, 11 May 2023 14:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683841203; x=1715377203;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RQWtXeCPxczWoRu2j53YDQ4Ctm0UJ+gU6bYdvqDHOr4=;
  b=CxhZbIAfTR3X2sTgEp7Gylx1xbEKRcEfiIgGTiCw1b8+FYRWN1g5LYRP
   gzNYmJO5HR+Mj+alubXvDrqdHdNQ5fOh/UvWjyh7p0aDYYIBYfeVyUAF3
   uK8P28y8M69ImZjcgK2AlniMHOybrwpN2dOg82kUP+MKMI0uApO/cKnxW
   Oa9b+2YmpQ6YVc81Kz041YsRJUo/mWaXG7Y6ozxEYe/HqCF/1EUu2nDnu
   E3zvcnR7UlbWFPIY2bmNEmBbEt0DiwfAlTu3ZDZRNg9QmXHAEXnmaUyoU
   DPPHtGXoUFZiFCLMjPyy6nyAeRFkx+ASTZ758/rRqRlHXJoXnPo2F7Dlp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="436973933"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="436973933"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 14:40:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="732771168"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="732771168"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 11 May 2023 14:40:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 11 May 2023 14:40:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 11 May 2023 14:40:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 11 May 2023 14:40:02 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 11 May 2023 14:40:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dICw7MDaUku/xOeub9ILxlNVBaFXwMx14aO5bGWWuPa5UuI4sTG/sMKon7t22HisU0IQuaJj6W9uWIiRIJ7H0kMoUAW1neooLyl2a5z8WABxQzcb1WbrcNST1b5EsDFv5oevZ+swK4XlJWRO7pUaAbXDEbOujZZcwgwHuV+g0zMHeY6E2Gc9N4AsoazOFBMcYXZaz0xUtsYBFWtbLQfVt9wtpXdlnZMwrqCYllE8POF++nJR3PaTwiRFZe+KSfec2tv8tuh7a1ixo2rADTb6LE5ApcOMToNf8+sh0EBbXGJjUkdawigo9RTiXCkgijuN1f42McRDt/+vxV0fJ839Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xnyyDuEcMfrwYMX2lYEynFX8m4K/JsRu1tFnvCtB3Q=;
 b=bJNZzr4f+wm9zy744giqonk5GbYeyUhtNbxV9S/aVac0cyXQoioZ1hmuxJwQnG9NrZazt/Nt0vPVIggLjlJtrgBFS77CcZ5+elrUYXXgtvvMSz/eTxWdLTjqM0RPNhPeTbkHLirZQdM8LGR1aqN1+nieL2YniL2DRu7zaQzG3xl5mBkC/Pu6g8LT+63h26EmzQtUapMeC5SLFTTE64TFQuAeeBWtSK43WasGl5GSerFKKOVkw5EMKL/OYk6HNwLBnAXQqI38/y3A7Y20+mRHRwJJnPr+AgU+yKqRLRc94dAtqmnr1McCKxShTioyC8INkUOv7XNe+mQcO4ijJauI0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN0PR11MB6109.namprd11.prod.outlook.com (2603:10b6:208:3cf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22; Thu, 11 May
 2023 21:39:58 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6363.032; Thu, 11 May 2023
 21:39:58 +0000
Message-ID: <3816ccf6-4f74-6406-5ca0-580743efa2a1@intel.com>
Date:   Thu, 11 May 2023 14:39:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [PATCH v1 7/9] x86/resctrl: Assign HW RMIDs to CPUs for soft RMID
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>,
        Fenghua Yu <fenghua.yu@intel.com>
CC:     Babu Moger <babu.moger@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stephane Eranian <eranian@google.com>,
        James Morse <james.morse@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20230421141723.2405942-1-peternewman@google.com>
 <20230421141723.2405942-8-peternewman@google.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230421141723.2405942-8-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0024.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::37) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN0PR11MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: e7eb4087-b07f-431c-109d-08db526844a2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DPjHA90QAGDyx0wpkW1Zmrcu8tsnVDXlCaqdwVgxYQkBXqVOUj9cQmb0KYjLqc4c0OscnWPqlsgq6ynNfSN8Z6mIsOPtr7w7mBksPJ2+QMpNA+07HCRhcWzVXWVYo5Um1uWWuS5jIrGnwmvFyEQd4b/Q7xq5npbzJAUB6TqSnyFAuYpYOf5/xboEvNxcLgw9gWR9Kv7tTbi8Q3lY+L+1TaJC+2t+EjKJRbZb6FQkMH6EXT9bn6ZwhOTLLoXSgqWJIalVkScSrCyPRZydjbpOi2jec/EMd+oJOQTDQR7ky+BHebqAri9LePMmSFb9I2STYn/YeuTZtjwao7aiw5r2vbGxl1p9MLShYBARkuK3ECF0cEPLQRxUdzxSrOseocn8WAEACF24JWUB7AQrvjjEM3HscSt97+xr2u+FX3dh1vlQsEtENpx4L34N7PaYG3WERVcZF1N55Xh0Xu7MBzhXPdMZto3Dm3H7q4/OpKyHVMlAMFslG0rfkdeRooEpHVdyM7FYX7iCb3qwodrj6BcdUN+KfRJfORciAKp4ZaLhymiHqF6OfCLvOVlC4GG0Bdg0TTH45yeIbuT4evRkoK3h67IQrGKuyxHz3gYWAln+yV2CTnZEoh4SwC3JM+3kLhTXHb+QA2lS/kPEUKsOKIOZrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199021)(478600001)(110136005)(54906003)(7416002)(44832011)(5660300002)(8676002)(8936002)(2906002)(86362001)(36756003)(31696002)(66476007)(6636002)(82960400001)(4326008)(66556008)(66946007)(316002)(38100700002)(41300700001)(31686004)(186003)(6486002)(53546011)(2616005)(6512007)(83380400001)(26005)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djRSTEZQT2dqem1odWtIRWFzQXVWdUNVSFpYcUpGcjBLaG9pNGpFQ1BjQTlw?=
 =?utf-8?B?NUlIVE01SjZGanNLWHkvcjhmS1J5dWdRN21JMldVenp3aEt5dzNJS3dldG8x?=
 =?utf-8?B?MG82L1VNbEc1bWJSb1VZTklteUMyU1hYK0FuUzR1YnZTS2FGRVEwS0ZTOUEw?=
 =?utf-8?B?VkVZTWRyQUdqQlFIRFhqaHU2WktBQUhWYzBGQ0FKM3k3NE5ZNDlGYk5SRDBP?=
 =?utf-8?B?bkU2WkRwTWZWVGNRTXpmdGZkT1I4a0FHLzRYU2g3K1dDMFkwOUNNYUdBRHVW?=
 =?utf-8?B?eFRmTi9NR0pSbkpUa29vYzFhMnpUQmJzRDc1WXR1Lzc2QzhHSk9pdDhkeXJq?=
 =?utf-8?B?bzFjc010cFVYY01nOTFpTjh0TU5yRzRSYW5xL1BLbmRTTmY3eEk1WCs5cEJp?=
 =?utf-8?B?MlcrWVFHYlArdTVrN1VPSHBTTWN2MHhEL2FYTkwzOXlvcUZDUUQzZHpDWFR5?=
 =?utf-8?B?TDJZRndDc1RKVjJmV1FzZnlHL3hFZzhIbklWRVRET08ybkE4TW9GbTVPaUFu?=
 =?utf-8?B?Tzh2Y1lwQ2pha29rYURyeUJISjRpNktpQXBMbThpNWh0YTREREx5SHBLWmZQ?=
 =?utf-8?B?dDQ0Q3I4bXdFR0RiZ1k1SVgzU1p6VjRTZTdBSkkxdGFmaXN0MmlRUHRKQkR4?=
 =?utf-8?B?bmY3aFM3Q2NFOFpjN2VlOEx1WllmZW5WRnZjQUdTVW1YYjBLT2xtVUdJTk5N?=
 =?utf-8?B?SVJUSlZXWEhHYVhYdExQenFhTGEzMFZPTWxraURsWkU4RUZ2VU9LT1MyOXBI?=
 =?utf-8?B?VHZSUDY0MVllQnlpNDVMc1RHMkdCeVpXU2YzNVNQdGJ6cmN6NkVvK1l3TWd2?=
 =?utf-8?B?aEd1b3IvRS91ME9RRzNSYVBrSnhZVHVEOXBBaE5oVzY4eE1ESEF4aG9aalRu?=
 =?utf-8?B?WTc5RHVscXpWcmgyL2V3MWdtUmw5Wk9TM2dZK1pveFk0cm5RM1lBc3JlYzNH?=
 =?utf-8?B?c3MyV1ZMSlk1aWNFSVR6MW8vNXhIYUNodVBxRUZOODBRUndUWVNGSUtDNTBn?=
 =?utf-8?B?SUd0U2lZNXNLTjM0bjFNUnRRNUZDdTE5anZHUmxSOExhL2xBdkJVZWNzL215?=
 =?utf-8?B?NXpTMmNzWGZJVjEwa0ZnSTNkd1hZRExUZ1Q1NmtDL0hZNE10aUkySFhlbkxF?=
 =?utf-8?B?ZHJ4VEZjWkFWU0hwZ0RwMUtqRzhiVElwMmNCS3FncjhwL1YyUGNXR3h1ck1T?=
 =?utf-8?B?c3lRZFBEcjFpMCtlM3RrVkdYZDg2UEdrZjdZc2JudTV2dnNac1h5UFRhUkNK?=
 =?utf-8?B?WUhJbDRzSHJtdEtQNncrcDV1SHdoQWRvMGhpZGZrb0c0RTZQNGJBNnVTQWRI?=
 =?utf-8?B?c200VFZTZW5OeGVVVW5iY3NVN3Nlb0FURnExNE9mQ0QvNnZsUStVWHdjeE4y?=
 =?utf-8?B?S29ZUWJId3hJWEh0ZlBLb0NLMzJOZ1E3RkppdWljTlZiTlRUSFZxcWtoQ296?=
 =?utf-8?B?R2ViVWtUbjI2SHhDUXQxelJzcXZNaE5CaThwVEhMZjhKYjVqb2M2MFFIbWxq?=
 =?utf-8?B?VzVsbkUwbXZodkRtemRsa3RZWE91K05UUG1VVDVaSXd3T2NabXZ3UTlrSnl4?=
 =?utf-8?B?TWdPQTFzT2lQWHN4SVAvTDBzWmFYT3k0bjQ0bTdENkdlQzJjcEs2d0Fjc3Y3?=
 =?utf-8?B?bUMvNjRVeG9CRnJURmpEcU9ZVlQxK2V4KzVlMzYwSi83bEY3NEF6ZXIySnNQ?=
 =?utf-8?B?d3VGckloUnRQdlA1UnFFQ1FtTG5nYXZOSFAvOUZtcmdqTEdsY1g4S1QwWlQ5?=
 =?utf-8?B?YVJCZmw1ZlY1TjFlelpOUlJTUUN4alB0Wi9FUS81QUtibTRaZmxYb3hDQXZx?=
 =?utf-8?B?SG43dWZPMmtKcURCK3EvM1hEYTJhL29pNXlsVnNqcVVQYkZkME1xR2NENk9w?=
 =?utf-8?B?NldpaSt5QVZYU1o1UTVaNUlMRHNodnFzT2MvSVpjV0tkTVNUaG1tbjJhM1M4?=
 =?utf-8?B?d01KSldtVDFjdHlsYkc1NlA4UGFrVEhDZWxHOWMxR3ZZYXlzVUdzbjY4TGVF?=
 =?utf-8?B?UFpFQkVNS3EwNEw0Z3RzNnZRTmdiV3ZKQmRIekNRNklaNVdSWE1NeFBUVGtB?=
 =?utf-8?B?MDRLOUtlbm55ejNXOEJiZUNSZnRndWwyRUhUS0xjKzFrZHFidnNpQ0RpQmxO?=
 =?utf-8?B?bkdSWFg0dGlWdEVNbmNyd0VTdlRtYlNRcm43T2lEeFNibDFpM2lUOUxzZ1Ja?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7eb4087-b07f-431c-109d-08db526844a2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 21:39:58.6155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3H3SvOUBmHzBwTtZwyOK512yls752fv5CgajUZlADukkL/NoqMbfAtxt9aGGzeWrRDc0mBUAmLOgNjR9LfpcOA1SdAj7bs8Fab7p3G8nv/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6109
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Peter,

On 4/21/2023 7:17 AM, Peter Newman wrote:
> To implement soft RMIDs, each CPU needs a HW RMID that is unique within
> its L3 cache domain. This is the minimum number of RMIDs needed to
> monitor all CPUs.
> 
> This is accomplished by determining the rank of each CPU's mask bit
> within its L3 shared_cpu_mask in resctrl_online_cpu().
> 
> Signed-off-by: Peter Newman <peternewman@google.com>
> ---
>  arch/x86/kernel/cpu/resctrl/core.c | 39 +++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 47b1c37a81f8..b0d873231b1e 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -596,6 +596,38 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>  	}
>  }
>  
> +/* Assign each CPU an RMID that is unique within its cache domain. */
> +static u32 determine_hw_rmid_for_cpu(int cpu)

This code tends to use the verb "get", something like "get_hw_rmid()"
could work.

> +{
> +	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(cpu);
> +	struct cacheinfo *l3ci = NULL;
> +	u32 rmid;
> +	int i;
> +
> +	/* Locate the cacheinfo for this CPU's L3 cache. */
> +	for (i = 0; i < ci->num_leaves; i++) {
> +		if (ci->info_list[i].level == 3 &&
> +		    (ci->info_list[i].attributes & CACHE_ID)) {
> +			l3ci = &ci->info_list[i];
> +			break;
> +		}
> +	}
> +	WARN_ON(!l3ci);
> +
> +	if (!l3ci)
> +		return 0;

You can use "if (WARN_ON(..))"

> +
> +	/* Use the position of cpu in its shared_cpu_mask as its RMID. */

(please use "CPU" instead of "cpu" in comments and changelogs)

> +	rmid = 0;
> +	for_each_cpu(i, &l3ci->shared_cpu_map) {
> +		if (i == cpu)
> +			break;
> +		rmid++;
> +	}
> +
> +	return rmid;
> +}

I do not see any impact to the (soft) RMIDs that can be assigned to monitor
groups, yet from what I understand a generic "RMID" is used as index to MBM state.
Is this correct? A hardware RMID and software RMID would thus share the
same MBM state. If this is correct I think we need to work on making
the boundaries between hard and soft RMID more clear.

> +
>  static void clear_closid_rmid(int cpu)
>  {
>  	struct resctrl_pqr_state *state = this_cpu_ptr(&pqr_state);
> @@ -604,7 +636,12 @@ static void clear_closid_rmid(int cpu)
>  	state->default_rmid = 0;
>  	state->cur_closid = 0;
>  	state->cur_rmid = 0;
> -	wrmsr(MSR_IA32_PQR_ASSOC, 0, 0);
> +	state->hw_rmid = 0;
> +
> +	if (static_branch_likely(&rdt_soft_rmid_enable_key))
> +		state->hw_rmid = determine_hw_rmid_for_cpu(cpu);
> +
> +	wrmsr(MSR_IA32_PQR_ASSOC, state->hw_rmid, 0);
>  }
>  
>  static int resctrl_online_cpu(unsigned int cpu)

Reinette
