Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5527E0B4B
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Nov 2023 23:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjKCWtd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Nov 2023 18:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjKCWtc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Nov 2023 18:49:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51903D61;
        Fri,  3 Nov 2023 15:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699051770; x=1730587770;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3sUbr2rA7yEhwxeNE6WxbYRowmBMCzNwC0PHyy8JMBQ=;
  b=GXDyI+SvV/IEVecFdtz+nzZVg5rgkuZlL1pbqs3E8LRjwNNAsZ+iI1K2
   hpTMyhCpLlaDYWol8yXdt+bG8F7mYATYIxXglep8jL0ZoEjy0Bo9w0cZ7
   RF2I20TiQDZn9DjqOn7Eu3M10xTkcNmhnxcWuswRn4OCNIrBJ2xiEBqIh
   0NZUvAas1/dOevptlSNuXQdw915yNVSN+j77icVmj4VhLoCvFQQNHlIZi
   V7c3jvuK5XoW6THYGB8k2n9tRwp2aK0n0NiR7LSlMhqS9Cn/hzpMZvyoX
   8QECJpbZveDhSORxJXTsS2xwN3MtqZMRqH5aBxBTYcuvunhdwzHPvTAMJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="379430788"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="379430788"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 15:49:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="1008957284"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="1008957284"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Nov 2023 15:49:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 15:49:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 3 Nov 2023 15:49:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 3 Nov 2023 15:49:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mT8+xZWN6EP2drUqtxplBccu35CDS9rwGPXWxbvQzDrgUtgHPDUspZAFRcWdgZJkZgyQYA9xo5dvVSzVfu13NaeWXGlp5zxOArpJxSQctoegNQRAXYuftQpzqxzejgpvIjvBEMfkm5UDakO03P2Hfwmax/mU3ElE9xJ88r1DNK+aFIEShKI6ZJysNS8M6aNjg9L293wTSAE6U7ZVa1foy+MnPRGEERusN4VEO33HHUmBIKzbQ/dqNuKccIMRiB9F/boskKfkmWmqReX2Y39rFR78KKJBtXfyVE9JB3mClqQnB0Rh2oZnCNrxW1/Y8y7nzTXopz8LWmUObmI3PX5D1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3Nr/2QC5rQ0Pvdt1gVRwDfb79w+BRrnyIW4BLFlF4I=;
 b=Mq7a+jfeHeaJs9WMgteVSEbxH5fLhibwwhMuVchG1Y3zgZ9Qjp3w8A7Tbi8wuVYdMwt0DEztwzelhTXmRHNn2g/gcU3GcUL8ZmjDOBh/Z/5Ne1Vh+81IIZLft8fjCHeKnVTP1wyjD7bi2kY4Wggcq9vYaghv9pJRNEsMvnGVCLQoJeQcMWSO3TwcXKSEGvNlo41uDhp9REu8BU+lZluKe+c/4rYhjGVwLDREaeklV3NNkMsIQNcvByz538os1frVATWBKskSvjbqzU/LCR7BQuagQtFnwawK+Fj1JEdCAD7cWnDh7GNeYIdKL6dcTL4MpMNxUR0Hm3E15CLarpNdCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV8PR11MB8723.namprd11.prod.outlook.com (2603:10b6:408:1f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.24; Fri, 3 Nov
 2023 22:49:26 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.024; Fri, 3 Nov 2023
 22:49:26 +0000
Message-ID: <a07b735c-fffe-4846-a4a2-ac1be397497a@intel.com>
Date:   Fri, 3 Nov 2023 15:49:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/24] selftests/resctrl: Create cache_size() helper
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-6-ilpo.jarvinen@linux.intel.com>
 <3849d986-caf4-41ad-85c7-11f11f986e1c@intel.com>
 <12d53aae-177f-ff1f-306a-607eeae17ce3@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <12d53aae-177f-ff1f-306a-607eeae17ce3@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0191.namprd03.prod.outlook.com
 (2603:10b6:303:b8::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV8PR11MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: dcea1a1e-8cbf-451d-1452-08dbdcbf2121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PoGA1RxeU/cWEAI6rdFonqaa3IxAHhkeFeSdveM4qdaaTVGANGyPis0PhJq2gPor41VGA/QZWKVy3ZfPn5NBvPmOnQ3B7rk3YrpCp9tIbkvTi/NjezGkPRgldhB4OiEtL8rHHRZY5/T10cPRjpKP/vMokc7dge+685reCWSqWcSy7KS4M1xHvKwR1gF+tfngmYE9XOMpxGtvIhnRXZl6qJlR9dzmfsZrLQaJ45q01dPgMpvQ+enSd+VbzFjuPXbG5vh8u977FxEM+PUXEgBMT9hZMaMXFhoNP61R4cx2zw2/0QA3sdR9tSQtOY52FwXhJZqBjXDeXDQLYySgeLaR8L/ldRZqV82tZNL5hCuM1I9yFmPUQw9OD+2I0SjUehW+TL16O1iQKSPi6TeJ9hvgyi16Rv+K9+d7tzMnVC7YIQKt4JOdkh69VcKP/2FxRKbWj5kVv7avmIh77vEhgmHag3sRYVvMrcIyBuep2EjYGg+jJPkXq6dhtK41aCt98yqzn2OITU4Ap7nSLo7KaabXv3ajEyvwvv8DfV/6Xy/KRDUQm61TsG+OiAY6N7h2o8HyVpm56s7Pf0BtRdVZAaa1Ql6k53pcUn3XqqH4HUmDZC4FrJrm/eZYLtAFd6QBc6D+Kp2MVZSNPN7WPnaemjs2Bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(39860400002)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(53546011)(6506007)(478600001)(54906003)(26005)(6486002)(6666004)(31696002)(2906002)(4744005)(66556008)(66946007)(66476007)(2616005)(31686004)(82960400001)(36756003)(6512007)(38100700002)(66574015)(41300700001)(316002)(44832011)(5660300002)(6916009)(83380400001)(86362001)(4326008)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHpoekZxZzJkeUZmS3luZkxOVTlONDI3a0VwM0VmUzd2TUVUK2hCWUZTbjFT?=
 =?utf-8?B?OGpyZU5LcWRFUlZXS0lLbCtUTGZkMmRnQlZNcjBSSG9lTC9RcTY3amphNGln?=
 =?utf-8?B?cFZGemVJcjFUWmxqQkd5ckU5N3laY092SnNqOTZ2WERiZ1ROWXl2MG5jVlBI?=
 =?utf-8?B?N2FBcnFkY0lyRHZJekc1T0NneXRHVldIQy9oWEUzajNPQ0ZOOXdRU1gvVWxP?=
 =?utf-8?B?NmlDSkRCeE1sNStjd1N5RDExbElYNy96U2VQallseDdFMk84aGRDWWF3YjBS?=
 =?utf-8?B?V1RxUlhXU295VjhCL2M1ODd3bzNJVnhJZHBxZkw5Q2hKU0IzR3BURGN3MzFR?=
 =?utf-8?B?M2lKY2lyb05raXg0NzhkNmJkYkZtYzNKZFFwa05acjVHWW9NaHBNRTNGZ21u?=
 =?utf-8?B?Wm40WXVJK1laYlEyQkdCM0VOYnIwMmgyWGlIdUdpUVNSeFdaUHEzZWYxbnN0?=
 =?utf-8?B?N0dlT2ZCdFRpUWRLdW1xVEpNbm9oOTVZWXlKVUJkdkNxWlBLdzRnQ0U2VEZz?=
 =?utf-8?B?WTBBaVdQdlhXMXZxMkMydXJrdHFrZHE5bXhwc3V6bURLcWxrb0tZMTBRWlNl?=
 =?utf-8?B?WkM5cnpqWk9YK1c1cXN6YTkrNDNvNXZRckR6T1A3ZHRBS3g1R09NSkpITGds?=
 =?utf-8?B?K0NJSzhBdVJSOXNzR2l5bHA5ZW9GSUl6VjdXM2swWTlZOUR2OWpSendhVkRs?=
 =?utf-8?B?V3MwVXAvaG9XbTdYU0kycXJkMTF2aUQxQy9xckd1VEUyMytkdkI1aStybndY?=
 =?utf-8?B?TG9XekRoVjJpc3BVRFgyZUsraSt4eVhYOFhRckNsKzJpUGtuM081K1pUNkxM?=
 =?utf-8?B?UE9KcHprNCtnam1NNTY5eW1DRjVnWGhNZS9JTlhmRTUvWlVRbFVXamJPM1dH?=
 =?utf-8?B?TmxlQ1lhd1NDY0kvR2xMZ1FYd0dnMzY0cjNFQzN5YkJIMXpzcHNiY25TaXJ5?=
 =?utf-8?B?NHRQUEh5Qk5XZUtzNEJ6OWxLdE5YY2Q3NjI0NWFNSEdKcWFxNkhYdU15d1pl?=
 =?utf-8?B?b21iWS9CYkh3OGdQa1Bsc0Q0QkpQaDZrV2xwUUNReS92RG1oTHlzWm04OEpx?=
 =?utf-8?B?VXk4R2V6VFBZK3J5UDB5MlU4bmZLeVpXK09uaERrR3k1YXliYzliMHRNQXB3?=
 =?utf-8?B?SzJxdGk2MGloUnI2WUN6Y1pWS3hLRXRSMTFsbVN2YS9HWTVkSktXazUzM2ZE?=
 =?utf-8?B?bWczZjVablkrWGtLWGkvMFlQYmJNY0pZOUhKWTlTTVRMVmVleS9OczQ4OEFr?=
 =?utf-8?B?bGE3RWFKNUQ2bVE3aW5GUlBMbEp0dWozKzFwUXV0SnlibUR6STQ3RFVURDlS?=
 =?utf-8?B?dnBqc1hxeFArK2owS0lEOFFsUzRJVTliOWV0V0RZU1BVZHZ6UGRVM3lsOGJV?=
 =?utf-8?B?ZS92UkZiV3Q4Rit6RWsyMXVPK0tnUFpYWFk5Z0c2V3JxOU14WHErLzByVkZP?=
 =?utf-8?B?aDZ5Uno2eUlEWlpJb1NYY0xMeE5vY0JldjREUVQxdFBZdVZCWGpDekRTeEI0?=
 =?utf-8?B?T1R3QXkzRWYyclpFMytQTDhVTlhqNUZHd24wbVZoNXBGL0xOMFdXbnMvcnpP?=
 =?utf-8?B?Mk1Fd05RQktheXlDQmE4MDVkQ0xRaENpZU53ZFprWUoyS3V4Tk1ZVnp4TGYv?=
 =?utf-8?B?ZnBXRHlxMUFCc09yS1QrcmtaVGRxai9rYWZRdFQxSHZWSmxneEh3ZEZpOEJH?=
 =?utf-8?B?Y2RvWERucERIZXR2bi9oWnVRdmVKNGR0MmVvS0FFeGJUVENTZXhDQmNhdTVl?=
 =?utf-8?B?ZHk5N0NPT2w5NkFmdkdzNTJzMm8vQjJ2eWVEZ3ZxQjRBekFQeWFOZWNlVVd2?=
 =?utf-8?B?bVBxUlQ3cVE2cS8xM0ZybVdVYzJ0MUNQTG5LdUtpWkpwWWR0bDB5bk44RGhr?=
 =?utf-8?B?SSthM2phS2ZIVlJUbXFxYWVKS3p3Q0JlaHhwQm5NQTc3eUZtRDc2cWFuU0F3?=
 =?utf-8?B?TWtEWXRMQ2l2Ynp2eDNHRXovTUNhOUNid3RNaG81UXRydklJbW1ZZzhOTk9n?=
 =?utf-8?B?TktnTENyOWJMRVFkOUZzOEJxSGVHa0NMbHRMMHhpLzhJdVU1VFQrbm8xbU9G?=
 =?utf-8?B?QXYzOUp2NlN1OC9sWmlTeHpBNTAyQzBhZmltQkFzUm42dEV1QnMxSS9xdHdE?=
 =?utf-8?B?UEFoem1OWnlnY005bnV2SERPQ0ZGUUxNbzk3Uzl6V3AwMW9zcDFuaHJmT1V0?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dcea1a1e-8cbf-451d-1452-08dbdcbf2121
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 22:49:25.9747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kR8QXIPUcKJW5q4VJK3n9IU3A50guRzzHiIrXuIzWaOSW/+s3yLrHZDnnos57ZIxurnbNsfJ0izshoFfnAF8p272A5jHLMxTNOXgNt+4yPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8723
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Hi Ilpo,

On 11/3/2023 1:53 AM, Ilpo Järvinen wrote:
> 
> Yes, I'm more than happy to rename them. This naming was what you 
> suggested earlier. (I used cache_alloc_size() or something like that
> initially and you were against using "alloc" in the name.)

My apologies for giving poor guidance. I cannot recall the thread behind
that guidance but looking at these changes together the cache_size() and
get_cache_size() naming does seem close enough to cause confusion.

Reinette

 
