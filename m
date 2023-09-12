Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F1079DB99
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Sep 2023 00:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbjILWG6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Sep 2023 18:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbjILWG5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Sep 2023 18:06:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE81510D9;
        Tue, 12 Sep 2023 15:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694556413; x=1726092413;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iPqzhc2Pr/lEILKnAtB9198deRbz6My2CTp5I5qMpWY=;
  b=i0Nm8zHdTAEAE+32BkB0SKK2dMSEDLFzJRHo2Wr63Wl80spR8X6Pcg12
   ws2BXh8mQ9zw0RXBNbyzlVSiq33yvyOBviMbfxT+Pw+ap64XWb4WFxpQq
   xwRQPi+l+wj9qhEwynhL2X8sDLR5ZfuoBacLWlLogFdaeTsZ9S7emNBGu
   9PDgu1JO6De+BPx+icfUtxrknPDU251I8h/bANI3k1ME5l0QHA3zrBqZH
   nL+2amqbEkfxIUAODJ9G355Jy3ASubPXKyDA7duzTmx7fAA9HPdTScoeg
   AxYgx3GpmCxFSfs3m7uXtT+rONAA/xSh9J8gdm1WZomnW2s58TYUbps6K
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="381203100"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="381203100"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 15:06:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="867525537"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="867525537"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 15:06:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 15:06:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 15:06:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 15:06:41 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 15:06:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mf5Lf8MtearKojicnnwTJ7x0r1NoRpIh+go19n4yb7JgTWRijN7jUgt9Pqk0ZUhf72eDU2YPbBB7AecFRd65wOXjw9g2pDpLaZ2BMqA6KDod0XWe4+kSbTJCzkaB1ytli8P4ysA8McfrL6cVyM5dHBp84D6jN8o8f/lo1mRkke1vM31RGVW73ibI54SpWOAhF3XFcD+JGd1RGxjwYONXee+lVA49j0XucOz7KjnmYpu7rt1/YrtDfWmz6DAXYAHmV1oRw137Y/jT+Lnxp5gZizbc/7cBdBwUwtv8iPS1PGy4LKS2qC+AUjsfkPcbmYO5pp/UYyaRIcpxHxvJXbsUyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPhS1UMcdpcJKt3DBxPqWYWuSs3r012fssNZJf6Oewo=;
 b=WglEa6oO5SdjcRtOLS2kgUrCOndAD0AmWrL9rJ7UOiyJRjDJdme/ZE6pB1XawRU0bGzr/kbgknbkgAXdw/sUuUxh6D5Dz3Bp1MWRscvI/ZB8zXTXXMQ+gV3jspvb/0a5qMJ+ZxaBPCN2Ygh1VaqBjJKDGx/HPibmKN/EW3qgj4RPL/UYTAnzoN9hZgv3Tn4F4XHngfC65262n4t7RZXbkIghnFbwD2c58oE/+VhJuWgSKLNmRrKeNy6fjd/ZBQQXQgg/4Cgs3lD7IitRdHKy7EEse2Dhn3vLwITWDv/ty1xcusBMBt8Dv+S4kt32sxxm6LIOSlKvlLsvZ5e0vmgqRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6516.namprd11.prod.outlook.com (2603:10b6:208:3a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Tue, 12 Sep
 2023 22:06:39 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 22:06:39 +0000
Message-ID: <40ba8890-32d1-e440-29fd-b8f8db69acc5@intel.com>
Date:   Tue, 12 Sep 2023 15:06:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH 2/5] selftests/resctrl: Remove duplicate feature check
 from CMT test
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>,
        =?UTF-8?Q?Maciej_Wiecz=c3=b3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
CC:     <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        <stable@vger.kernel.org>
References: <20230911111930.16088-1-ilpo.jarvinen@linux.intel.com>
 <20230911111930.16088-3-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230911111930.16088-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6516:EE_
X-MS-Office365-Filtering-Correlation-Id: 20718062-304c-48ae-622c-08dbb3dc89c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KrJyYSKbfPVF8j+QVDbNap8LxpXshHKYZfODIDpB+Txhq2LfaqImGvoeEljxQ10v5NTEzxrbeHKZ0V3Y9GA+m732mKD5Q3ItaVM2GeNqipEZb/8ZUJAIfUKjWBfDoy3rMN7/aLykGRmxk1S4/jSB6N0bWZo/Ls/e/Q+ip5PUU2OkBQUw16qUHTN+TIxsyiiH87J2a3leQenM/xFveR9QGYtIFvfjIV8sXlGuJ9QT87NpYh3spVHwFd07S5MUSCHdGm9Dkz+SeEvviDOUstFwz6lxcfKAqMbzXM28Fo3DTboL1+zC0oV/DYJbbembjkYoh0FiTZXxlhl8Dopr9Saj2GFJafuunjHkyxz0vLm2JwTBEQylUY0DhwIktTk8UQEDa54Hdsfoa1CpL6qnxW7AKQUU6Zc3ndgc/b9lqe4nLIMjtpNgAsYnfzkd3BiDe8//Vqjs6B2bwhAtdypG7s4UgkYrqpn3LrNiLlWuQK4RhFYKR2gzxI+CmgA1wHDxqpWxpNLyyT2yW0OYTXlNHFwxV5PxPBY6twVc9bs46AkKEGCgezoOCYsWhbEtnmOktrKuGu5yMjlU+TYYG+Hdu+Mo/SxYtX3vo2WSpw+SqqesvDSweBapIApBPcDJ9Aaloimh2W5pETslz1ovORq7Xru5ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199024)(186009)(1800799009)(110136005)(31686004)(53546011)(6506007)(6486002)(31696002)(82960400001)(38100700002)(86362001)(36756003)(26005)(4744005)(2906002)(6512007)(478600001)(2616005)(8676002)(4326008)(8936002)(41300700001)(5660300002)(66476007)(66946007)(44832011)(316002)(6636002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUhaZEdaUi94dnNOWWlCUkF6UTBqbnJsMmFPUWRlNnJPT3FRYkg3eHZpZWow?=
 =?utf-8?B?TkF3TEhwZDhRYi9CVXRaWGF5Q2hUeWZGZkJnQTlSSFJSMjVNMnNIbjFwanhP?=
 =?utf-8?B?VERqM3V6akJiZllGc1RsVjBRNXdZcjZWd2pxR0FjejEvamtYam1mWTUrSkZm?=
 =?utf-8?B?dUZvS2YyZ0dwcy9rcUZLTU52QUNxT0pibGJQUzNvWm9lUHhBOFNubldWNTlQ?=
 =?utf-8?B?V3VWMjdpWUc4NG0zS2Z5Sjg2Y0JkWEx5cmN1SkNyQjc0blhyNXNYRHNORnQw?=
 =?utf-8?B?Mk5RbTczeXF2RU9zS2VlbXRJeVhVZWQ3SXpDYjhmY3l0L1JHNzBRYWg2Wklx?=
 =?utf-8?B?ZEUvaVlKbStvdWRwY0QvQmdUMzVsRXZmVE5zVGRVeGZjREdtYVIvN0V2RkZ3?=
 =?utf-8?B?cjd2SnpKNExnUytYNnM4YWJPVFVzOG1RYXdVUTVKYkc5S3RJcUh6Zjh6ZTZu?=
 =?utf-8?B?TzV5REljU0t4cGh3L29rMldLZ2IvVkZvbGR6NGJRTGJiMFNtb0pwVHgvUm5X?=
 =?utf-8?B?OE5DbGwvM2FodWdKcS93NnB5VEZ3a0w2b3pXRmkvZGl1Sk53bUhlRkFvM0NC?=
 =?utf-8?B?SG4xS0k1QktpTGIrK3JWVTNGc2JNNG9iWTlUdWVNNUd1emV1cGhwd0VxcldQ?=
 =?utf-8?B?MUtoYVk2eFBFS3lUc01oZm1Ya3ZFaGlGZlRKT2ZiN2xFUGpmWEpXVFVrdVFS?=
 =?utf-8?B?VXJ0aEhkZ0JVN1RybjNNZTRxSDBjdDg0NDZEL3BuNzhVMVlJc21iU0JadnNI?=
 =?utf-8?B?d2taQjY5QnNqeDd1RHlsMzBvQ2VzZnhMY1JIU2R6bjZJMzU3Tnlicm5pZmYr?=
 =?utf-8?B?bXBHY0Z5RTZEbC9pdEJvMHBKdy9QOGZCYUtkU0QxQkRJUSt5MXF5Z2tydlpv?=
 =?utf-8?B?ajNrdUluZWtBcmRKNG4wZWIwKzkwNUEwZWVmMUdnTkN2OEFKdXpqOTUwcW5J?=
 =?utf-8?B?Vm1wS3hjWFZmYk9Oei9CKzNraUlocG00WklCRUJneW9QZk5FTE5hR1UrcUN5?=
 =?utf-8?B?RjA3OXhiSmsveTlDOHRhWnRUaDcydWpzVGt2dm83U0ZoMExtSi9ieEpOTXlz?=
 =?utf-8?B?Mndjb2NmVk9UMzRSNFFNb3ZFbHZZOHYzK3ZzS1A1Z0VvcHd4WGRvTDVvUUow?=
 =?utf-8?B?eEYzT1p3ZXZOYXRjQzk1c25EZHU4dkFhbHNPNTNBZVZYamNTTGd5dyt2UmU4?=
 =?utf-8?B?OUZZYU1XcFF1ekQ3OVhvSUEra1huUm1EWnRQWC9OU1UzeFFNREllbFBYNjhM?=
 =?utf-8?B?UkxGeG1RWmYxci92MGhLc2RFbm5GQkhha1RiaklqSllsSzAzbTdKZ0tqcW1H?=
 =?utf-8?B?Ykp3Y2Y2TjArYmFuMHh2clcwTjNoN3d0NWlRUzFlWVdNc2t3VWN5dStXaklJ?=
 =?utf-8?B?clkzZnpUR3JsVE9ST3NqdWQzMXBpRStFcXlTYlVLYlVlM3M2TGd2Vm5qanRL?=
 =?utf-8?B?SVFaV2pTWVQvUEM3b1Y4dDlVcEJ6ZVdGVm1QazhtWmtPZzFDQllvYzBSNENP?=
 =?utf-8?B?Yi9rOUt6bVMwR0JnT3ppSFB5RVg1bXNRUFhSMkhndDNiN2k5OVI2UjF5V2dh?=
 =?utf-8?B?Z0t5YnE3NzFxSmN0Vms2ZzZBWGE2c1ptZDRIMWtQWU9udzErMEtaTVJxUG9u?=
 =?utf-8?B?aGtVTUJZUWFtbTdpVEgzdHpkRmtOa3V5Q0tGWXFpZmtTU3c0ZGhlWE9MckVt?=
 =?utf-8?B?OTQ4ZXdCdlM0ZGtSRmlSR1U2eXg4UUFVWjFhTFY4MWZObDRhWjROeXJxVkRH?=
 =?utf-8?B?NmJXWlM4My9uUjF4dVkzOWU2SnA4bU1PM3RuMjFDdjZoMWNwZmJlREF5aXFX?=
 =?utf-8?B?WEw5c2Z0anZNZjZoTUFRcWV5em1tMWoyTnRGTmJtSXh2bWJoV1JSOG5jVG9T?=
 =?utf-8?B?MTlSWXJmb1Vha29HOEJlc3RLeERnOGtTOWJRM2ltM1V5RktZa0d1ZW9lb0Qy?=
 =?utf-8?B?a29rejhoOU9IM0Frc0lqOEltcnZ4NkVYbnZqTCthcDdWVGZEMVduTXZIWG9r?=
 =?utf-8?B?MDMrUkVvYUdsTEEwcFJUMi9PZkpGWDJCNkk3YS8wN1U5TTFuRGFhMGExc2Zl?=
 =?utf-8?B?Zkt0WTJ5MVlrOHRSVFYvbzVjdWFnZFpxNzBvekVUcFQ1YytDUElBc0hybld5?=
 =?utf-8?B?Y1lQb3F6MXBFSWRUS2Y3WWZUVDVPcVJKQ2JDeEJ4K2M1Z2Q5TlJUOTZ3eHpp?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20718062-304c-48ae-622c-08dbb3dc89c5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 22:06:38.9664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3ISm2AwWVPewRYqXQ9RpDy8b5kpTUJ5ZTm8zJkzN4DrV0AvJcRMMkqlPkuPwn5iOwzpPkBtPcym/eA20eC9pAHiGL4dQLWY4+2axWZxWPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6516
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 9/11/2023 4:19 AM, Ilpo Järvinen wrote:
> The test runner run_cmt_test() in resctrl_tests.c checks for CMT
> feature and does not run cmt_resctrl_val() if CMT is not supported.
> Then cmt_resctrl_val() also check is CMT is supported.
> 
> Remove the duplicated feature check for CMT from cmt_resctrl_val().
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Cc: <stable@vger.kernel.org>

This does not look like stable material to me. 

Reinette
