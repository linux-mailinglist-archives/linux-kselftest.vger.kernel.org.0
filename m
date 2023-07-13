Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CBC752DBC
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 01:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbjGMXGm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 19:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbjGMXGY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 19:06:24 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B741D3589;
        Thu, 13 Jul 2023 16:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689289559; x=1720825559;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=AnrgsT/qWO5RVhnL4jJCdPRW4ok3Ar2dFUfhHAMgkuQ=;
  b=cg93wGgXy8EA5H2M65z8ozYY578cKDbwncGYoLtzW+8Yg+i9oMA3hDSJ
   YQT4BdVmsZ43Qg0OoUKUw+l1SWJnXZFqho3uHE76BTUzSUfdLUMRmSPqp
   VFRXAgEX1sJ+K0NawgSYHkyoVsQClq1IkeZ3F9D8CZ1yx/eQp5VTkm+us
   tVGOPyMomeex3DoX2hTrKl4ZQxN08kdoiOXyMKiOCNQI12IcSxvmWKY8l
   MIQeXhK9lyz0yRRVkGyfbqmTdrf5EClg55Jay1Xy435LN1dtm3zd+SsAs
   SvubrWjbjEMAwHbhEQg9cVMWnUhLVUu4tXWkr0qZvYe/zaQdfNunU3csh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="431505422"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="431505422"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 16:05:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="672468065"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="672468065"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 13 Jul 2023 16:05:35 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 16:05:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 16:05:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 16:05:34 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 16:05:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQBbKWUi1lxlkiBD7AcJR3Z46DZ8nvXC9UVBWKjAuuled2HxH7bLVXt1/DZexhoJXHvs48g0vSNsJgsWfp14W5OJa11JIXenjxwteit4kak9UMuQCpx6zq0dlrytdHVfkeF+0EgFV9uMOXscK5TRdz5BN+hpC0ZFKf1YdZuUXiY/Q0BF0FbaKFE62GmoFx0eJviPsg2A/DNiUt1g2VJh1WlyPZ27oKxivvgIu//iHbkppwpjBnVQsajTHGqJQHmH+inC0UKCDgvGCscDDu2jF7gHXmXCT7V4riao9EgPOpjPKL/apNbTfRgEKgDDNUKAT21sb65XH1k/iAakI7IYGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0pG714kL8I4+U+g1acl7j9Fg+gWMYc2eXdNr4BZYBU=;
 b=YgXU40O11TOvxMfq45MOkbDcyLDSJKx6g3BC+BEZNWKRMZyjwses3uWbvzhu10eTcLk8ZDo5oCp89eES/tDbzVTFDRm7N/Db7VndFmjnybAH4iPMExfWnyK5XEZeBuJtJRkiSyiHR/o7YLsVU8moXARDue/8JQ8GUFqn9lQwucFpugqSltvy+3rP1aRb5gGnfDO2T7CNEOhfewv0jcgWIFq0/RPhQ8PzXZP/qgy0mV4/1D6H807mMWhT9m4A5s/u86DxKuYyhK+rf6VMbRNd+FmWX2lEIdGeVquQcBY1YmuAFw5BXPUql44PZeYM9O/gh7bLIicF9KlQimIiu9SA2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6474.namprd11.prod.outlook.com (2603:10b6:510:1f2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 23:05:33 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa%4]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 23:05:33 +0000
Message-ID: <d6614e2d-9297-9d5f-c59a-e74cfc9d0b93@intel.com>
Date:   Thu, 13 Jul 2023 16:05:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 12/19] selftests/resctrl: Remove
 "malloc_and_init_memory" param from run_fill_buf()
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
 <20230713131932.133258-13-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230713131932.133258-13-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0269.namprd04.prod.outlook.com
 (2603:10b6:303:88::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6474:EE_
X-MS-Office365-Filtering-Correlation-Id: 179fb9ed-8d9c-48b0-ba8c-08db83f5a8ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hhfHwboeeOsM1Wkc1VCh0vr8hcdJJReVyg+Jch3zmZ7wFaj+9YHUGeTAaWDFQ815qM1737zX455oDY9mwJkGOQeilVw1Qt9hNmgpcY4CQMidY8Et5rfh84feRANoMoMiwTyXxgGb4fB9M8KRA8ASVrGnaUI0/a+XTqOmAZs1p6iknwpCH196ifjzvfpUAVdvdgxWXnE/yWwPoEKg0q3ccJGHzOJ66bde1ZSRsA4udWmP6+mFOJtTqYWfm3PpGa9qZQ1ACiJ6CgAIcqdj5s/LXIHYL4a+C1cSPBZyUQ/BDF9l5s4R/6UqfiKcDER6VNW0X9u3TccRsQBrJV6quKUq8adTO8MwhNOimfyZK9YtTAFec/ghSbNo5e8uOflofQjePjt4/xs2sObvmwN7HoKGEsuFD4gG3/Px6yMkoEYh0XzBPJtZvCPERHWR29sdKjq5Lt1OmlUmF2vXv262pYnn6QiDKHSde1IIr2ljamRLLnJFk/YIk2/25T9XdOSaPJKwdwxUefLH1W/fwfxUCGV9GrWnPaku+Fl0koSWATI82W9YHnpHaBvFBz94dtkcefU5JLVVQ0r3Ay88BlClhriM4J+itd9fKQp+frEb21bSedddjymKwRmFYECQtEoZWCDjlFGjTgaUrz28wZfRPZUqOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199021)(38100700002)(478600001)(82960400001)(31696002)(86362001)(6486002)(110136005)(66556008)(66946007)(66476007)(316002)(31686004)(6512007)(41300700001)(186003)(2616005)(2906002)(4744005)(36756003)(8936002)(8676002)(44832011)(26005)(53546011)(5660300002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU5BeG5tZG5DbThxL3Rid3E3SFovK1R1SUVYbUVBUllYM1l5M1FUWGxDUHRn?=
 =?utf-8?B?ZjNHQ3pLbnhnVUd4aTBZbXJVUUJ0bnV2eHJ4ODZQZjBVWjhRYW51YmpzaEkx?=
 =?utf-8?B?T0dyOFozV3pNNW05SEVTSDgzL2F2MUwrNExpdUNSUU5yeldYRURCSUdnM2pu?=
 =?utf-8?B?VGwyQkx5b3ovTVJKOG5EM1dMYUZEcGlFdUJYMHNoemJIdGIvUE14ak5BV0Ri?=
 =?utf-8?B?djlGUXVCSFlhTnFodTNRVnNXbGJFamNTdlRwK0pFSkNsZnNMcXcyTDdub1FV?=
 =?utf-8?B?N0N5QjRWNlpPMWNVdmtNd1RBU0xZRjg0S2wyY2dpSkZ5RXBQTnlSaWhIcjlp?=
 =?utf-8?B?ZVRFM0Q3VWVaUzRsNUw4dStucExVWHhGR05HK0JtV0xvZ3B1MGRrQ0dHUVo5?=
 =?utf-8?B?VHowL3lJQ1BUcUdpbmhrdFhJYStyODM3WVlGRkJmaHl1Tkx5ZUw5RDU0dmQ1?=
 =?utf-8?B?aEVnMDJZOVhGNWpXSksvVzhNVkJINmM5ejJ1WmI1eVloNG1oWmo2Wm5ZZm5p?=
 =?utf-8?B?bnBQZVhnaUtacDNTVWVlTy91NGNReEJZNDN2QjBOcHp6OFp4UlRZakpYVlBi?=
 =?utf-8?B?Ty85WUp5anFNZUNuVFJJMU5BdmxTcGpmU2dCYTFIUEJUdTJlN25acmwvdG93?=
 =?utf-8?B?NTRrV2d5MXVLdEFQVFhvckZsMUVzdytURFlvNVJJWnU4WkpyOHYyTlFIREty?=
 =?utf-8?B?R09VTnoydGt4Szg1cDRrMWIwVDYrVGhkTk9nRTlJZE9Nc0FvVnhhNFlhY1dF?=
 =?utf-8?B?NEcyWHZrRGhBMkYxc0hjQkhHekVmclg0YmNjVllzWlN4QVVaTzl5MlltUjgv?=
 =?utf-8?B?MXNKY2VzSnJ6OTdGK1BQMTltNDBYZW5Od0U2SVNSTlFKSkN5V2puMmhTbTlw?=
 =?utf-8?B?YWdxNVA4T3lDQnErb2UxOWFIbmVhMC9RZXM1ZXl4SXFydXpKNkY1ZFFHVCsz?=
 =?utf-8?B?KzJLN08yUzE0S1Qxd0hHaDByWjdNWTltaksyc1JXSnBqWHZWYmlYM2JqT3p1?=
 =?utf-8?B?VzdSSFdTc091UlNkZXVhaktxSVcwdkRIR1EySlpKVGpNa2d3ZHNXSnVnd0dN?=
 =?utf-8?B?Tm94UUdvNDU4MXRmTjduTzFjcU0zR2ZLR3RWdThGNy9ud3dmdzd5NysrYU9J?=
 =?utf-8?B?aWFzRldGUm9NU2NVVzh6UkJDQ0hrR1RDOTZ3UklvNE40eEt3Q2Z2TUVDeUpP?=
 =?utf-8?B?R2xWdnByYkVabnduZHErandiRHAyYno1QklpeDE0ZlNvSVdYcmE0cU51VWth?=
 =?utf-8?B?NnNGZFRhblRYcFRxd1ZENEYvM1JKRkFEUStKb095azRLY0dYUTlhc1Nxa1ov?=
 =?utf-8?B?bnhvRkFIOVpkajlteEg3dG5icHdyY1diQjZ3QVZxenhsRTBHMEdLaSsxVCtV?=
 =?utf-8?B?TTZWTnhTdWVYcTF0RmVQSkpVRHdSejc4Wnc0SThFNnpKU3FrNFA5VDZSTzdk?=
 =?utf-8?B?Uy9hV04zMnFQeDBDa0d4RnhrZEdsd2QvK1lLeElGc2ZNSjhpTnJ6YUwrRzBq?=
 =?utf-8?B?UGpveFNibjU5YTBXQVJ3dVV6R2VqWmhGeFY2ek1hU1k5VDVLbFpXUmlHWjJW?=
 =?utf-8?B?c1JQNEJIYkNlN1B5aWhmYkNGdnVHMUpYbDcrWjg0M0FvM25sTklEVlBzYnRL?=
 =?utf-8?B?RmRrTEMycDBqUVA2Q0hCY2VUY2VXODhsWGdxemNnbGJSeXBySHdMaHBRYUJm?=
 =?utf-8?B?V1Z6Qno5cmY2anR3RmVla1piMjZ2OFR5Vmd5RWVDRzBnZERiekljNVE1YmEx?=
 =?utf-8?B?OUQwbnJCWUVJdDRIL0hZOTM4aTV2UEx4R0JWMDB4c203RGVzYkZCY2VVamNL?=
 =?utf-8?B?TVZaYitwbzBEbW9ad3M4RVZMQWN3cUNWUElZTC9pamdDYUI4Um9sdSs1SURj?=
 =?utf-8?B?c0g4WGVuY1NLNG1FQzcrTHNuY2MzeWwxMWZFUSs4R29PWHNwTUxyTHF2STVK?=
 =?utf-8?B?cyt5NDA5YlFITVJMelZNMTJvVU03VnM0cEZ6ZWduRXBZZGxEbzQwSnlLNGpX?=
 =?utf-8?B?YkNvZzk1N2V2Z1BVb2hTbzZTcnZ2S3BDYnNNaDlvVG52QWRuVFlkU1V4bFFF?=
 =?utf-8?B?Y1h2bGU4NXRjd0hrbVNNZldlZFBrZ29ZZjdkVUt4R3MyMSs5TlVKODZ2VFhU?=
 =?utf-8?B?aHNWQnNMckpOdUd4L1JEalZxSEk1bUo3bm9jdDJlMDh1bjhBZHY5Ynh1RWxR?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 179fb9ed-8d9c-48b0-ba8c-08db83f5a8ea
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 23:05:32.8442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDmId2fa8YFn9x6n1VuAwQOG6MkVqomyEdWQtAj82IJLYecQORSZ4Y2AexQKdTVo7A+0DVoDPZNkenyW+yedMlEQL+lZ3/HOrpz9w+wF1Mc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6474
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 7/13/2023 6:19 AM, Ilpo Järvinen wrote:
> run_fill_buf()'s malloc_and_init_memory parameter is always 1. There's
> also duplicated memory init code for malloc_and_init_memory == 0 case
> in fill_buf() which is unused.
> 
> Remove the malloc_and_init_memory parameter and the duplicated mem init
> code.
> 
> While at it, fix also a typo in run_fill_buf() prototype's argument.
> 
> Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
