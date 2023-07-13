Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE73752D27
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 00:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjGMWnj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 18:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjGMWni (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 18:43:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF2D270B;
        Thu, 13 Jul 2023 15:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689288217; x=1720824217;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=5GfIQ13mcTnxShvKNuxj8jNjNwI2S6PVloQTnh9GBMk=;
  b=Pj5E7Uy4UQDVo8uHyv3t9DxZZL0lae3Jcf4LojMKBnnPDg325whpMZm/
   G5qLwUc1f0MjbxWK3UseqmM4V8yaWXF+Mf+9NpBPT7pW/4htY4IoAcq3B
   jHgPIyeTDJbvMSI+uSXwPMdrKEuu+lARzT2R3og0Cmte7KGEPcGtGJdAN
   j8ir252aCrom7FxlEszaHk7LWMX3htG/4X5sHKqQbyH7Aa+VZSb4HGXcR
   AFMNQEFF1VFK9T0CobzKQsPV4CG4lP9T/6bEI7KWuwlmrtQYKKI4eVj2H
   XsM+EU/gjL9xlteY9c2gNUyEQ2FrSgx5F0HddPT1A1KCTtNYWTA6xWNd+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="364206590"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="364206590"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 15:43:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="792230262"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="792230262"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 13 Jul 2023 15:43:37 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 15:43:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 15:43:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 15:43:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSU9u1Tc1YfZrh/eNyEDsCzT4jKJGiJBzCMptY4h7uXtCROdVApdTZ1Wf+vNMd3iMstDkdCIzO62/J8sYledQQvuSjbZLqYP5TXa5XD/nIDnlE50MIgwhI+DvHR3YukBw0srVO90hcjtoRjeW/Z8wJwnLdswPxgVyLrAr1UpU/6Pnw/YYimmaGc47fOeKAvZehn4NoXJR/scrwJYOaUuVcQzHDfLuJ6cmIWOyxDlUWgiOmsDBrRKRM5OPLy4hc4CkV2bLMM6cSbHHeNVb4/UimR+dF+OB7x7b0FoNvRmb1v+x4v2V7OCFvfEqLw6CDWFQa1fnYBGrGFMTZbe1G5yPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rucIouepwVGSdfYLx+p5KEvDNGX16YRjl74ukzmdeCA=;
 b=MWhIJRvf9a/d7RzPhtWBmYmy6+SuS50oJ7PxSADPl3olYh4HlVgMGerDv9+17PMVHw/IBJkGRAfw/tLQjh3PWvpNfDd5fJ2AkMoNE6ECFIoAhkfsbI62aoPL5eubczdS/VZnxBEIjT7CtvrKEU17W0KDHzPTv3jZqHxJ2/NwJZ8CFwTKo1Vc9eoBXU0e4MOC/eW1AOYJDz/5hNOud/BEh5k6nF5Duxkajp+JTojtdo44HFsUtQ9vAlidvIPNKS3Ys80LgSLFCVAWV9mG1+Ca38zfU7sC8iIW2+32YryKxdZmaQxqxOQchZZVPAHYqBhNxlHUmyETYkljnywg01id7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB5439.namprd11.prod.outlook.com (2603:10b6:5:39b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Thu, 13 Jul
 2023 22:43:33 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa%4]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 22:43:32 +0000
Message-ID: <52f4c916-6500-9f9e-4459-f1b64dd3e3c8@intel.com>
Date:   Thu, 13 Jul 2023 15:43:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 01/19] selftests/resctrl: Add resctrl.h into build deps
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
 <20230713131932.133258-2-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230713131932.133258-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0062.namprd04.prod.outlook.com
 (2603:10b6:303:6b::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB5439:EE_
X-MS-Office365-Filtering-Correlation-Id: b12f0064-4c63-4d61-0471-08db83f295fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ivqpajcw1bB9jwCL0GTXAVIqdhHHP3R9TPq+WREzfJG+j+50echE81pRIb0j6gZTF4PecWtZGLDnD+jaHjMNZO4FUeiIEhl+C4T3Tb1zsqIYz5qe+LVNBZBggnCE4rOGZEP/kDBT7m5fk2m39PjzlH0Q4eQfgUKTUnzmyRIph/EcGvnboeWcH+aE/eOMT+NMQU23StnvEVaIvNgHaCpYa9uHRHfxh+vGnvs95EWxiywJqyBAEcPyXv3DZL6iOWouKyC3nvWlSDPLJgqlGCPrF0KJVkb5ShqfIR/n0XqOdxGL+JXj6gRl6KfYVOkl6hFXXFsRcTSlYxm7lBJYMoDgIjAOqprY1A8qx8PBcK6XTl1kVUrYK+bRbjvceHkSZcow+db+F0A32C4XWBTH0PbyUHRmQegkDjgCt+EP3zN0n7A8CmuaRvRp83mVHGyf+lGZZWngjlD5jlbABVkDf3tGEcqyqMP/JYID24tzZQ00RrrsyV8R3CNQ6tw4HgdGWiFSWVo+rae6EzyoVTAn7fnyF6M4x6uNC4s2BhaHGxXm44OannJCwNDeya/fZD9qitdjTtOK0L6JlVoZ5HeLpc2fYpwZXyL2tKIlbRjXlF7eOsH9vz/ThDeekZv3rC8kDk/fO/Q3caH4GBTUu0cj0yS9BA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199021)(2906002)(38100700002)(6512007)(82960400001)(186003)(2616005)(26005)(53546011)(86362001)(6506007)(5660300002)(31696002)(8676002)(8936002)(4744005)(44832011)(36756003)(110136005)(478600001)(6486002)(6666004)(41300700001)(66946007)(66556008)(66476007)(316002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b01kMzFKN2xCcVM1TFlwZGFZdC9FQkFQRW8va0xyQ1hmRHZTNWtiQjV3d1gx?=
 =?utf-8?B?aFQ4SnVIZmJ0cGVDZ2FqTFNhTDBQQzdFcUVIMnJCNWxaVDM1Z1FHMmxPNVlh?=
 =?utf-8?B?WjdVL2trb3VORy9TNFdMaVhqN0Jscmk5dlA3SjY0UDV0cWpCMUppeWdJUklT?=
 =?utf-8?B?UjR3bEZXTkJuSDBjajNJWlJUdE1INGIyNjlzNTE2V0VMdTNCdkp5Zk1KNTJF?=
 =?utf-8?B?TEJud3ozMEVsWHF2eTliaVdUbjZQOFAxTmRJb1FFZjZsUFFVdHNwUXh6cHFh?=
 =?utf-8?B?a0lhclpwa2xwSTZEdWFPTzdFU3pJYk5qNWRkY3hTSmtBR3A5OG5DbFBBdG01?=
 =?utf-8?B?QkZPem9URVU4VkZnTDJ5Tkxqa0sveWVRTDl0T2dWdzI5RVNjbWdZdEJwaVhv?=
 =?utf-8?B?cGJsdlZLd0o5SXM5WXlnc0ErbFhUSXhNWnNveDIybkVEeHNnaE5ENzJWNUZ1?=
 =?utf-8?B?cnlCRTFpRWpscjJqR3UzV3hJOHlWUzR4dHBZY2J6Z29WaEhPanNsU0hrZVV0?=
 =?utf-8?B?V0lQeGxRT2ovQll0VlVMNzZKbDlxVlpGOExKZ2l0MzgwcXRJbTdrOUphRUYy?=
 =?utf-8?B?QWQvU3VmQzI1aFJSTjdtSkdPbk1vZGZZTktVWjE3a3VXcmpmUDQ3UTlacDh3?=
 =?utf-8?B?cDg5WVNVaUl5aVd3and4ajJma1cwbW56NGhpd1BmKzZlQ1ZaSjZnT3Bta3VP?=
 =?utf-8?B?ZGVWaFlOdHRTVjZhZXpNdjFQdk9HdlFJZHF4M2ZyRFVnVWdFUE9LSElGbFNj?=
 =?utf-8?B?R0t2Q2s5ckdkQnA0NDB1MmtZdHprWUtMQTR0QVFxVDFLU1lEZkJFalc4dGVD?=
 =?utf-8?B?WWhJVExCbFNZUFZwKzBaKzJhY0lIbGF0TXpnUE9xY0cxOS9JOHViNGpBbTF0?=
 =?utf-8?B?QUxJTU9MMW9ySFF2R3UwQXUxWS9OdnVCTWRsVkZHUnFzcGlMQjBsdWpNR0d3?=
 =?utf-8?B?NmN4ZFMwWDVSdVUyR21MSUtudFNmQkhwZ2RqK0IwOHZFeFhFNGVtNTFRbHRY?=
 =?utf-8?B?dnExcjBHMnhJR1NOd1pNd2YyMkQ0TGUxckNlVUZ0ZDlYRUF3M3B3RmxBeW1R?=
 =?utf-8?B?OXUxbmlUWXZDQ0pOeWhXRTZJWDRuL2xTcnUwN1NuLzdCajhlZ0Z3UEptaWNX?=
 =?utf-8?B?aXRoWmkxZ3JlUVNvc3FuQkhMVEo3WU9hQ3hwT3ovSHA2Q1RCUE9ZS2lFSXUx?=
 =?utf-8?B?ZnQ3T2hvOVJXTDF3UWIrdFhyOElNb1hnaHIxZ1hLZUd2Qnd3S0dobmNxMGFh?=
 =?utf-8?B?aE5POUN1NGJQMW1IS2lSZG8zTlZPOEhkdDI2UFcwVVlWOG15NTFkemR3c3F2?=
 =?utf-8?B?cXc3a1ZvWDBYMHg4NkcyNjAybjR6ZzZYZ0s0L2tSTzk4MHpaeFpDQ050K3Bz?=
 =?utf-8?B?NnMzY0xIN2IyWDlDZHVaYzVjRnJGczNUV3RHK2RaWTJ3VEtKYzg0WjF2S2FM?=
 =?utf-8?B?bUhZdVlaN2NXN2xGYUxPbHZhZjNidzBTN1ZHZXdhQ2tXREE5aXQ4b0ZFMVVz?=
 =?utf-8?B?c3JOblVHU01TamNmOFh3V3J0QTV0cU5YOVVlNE1NVXNKN0M3dEVubDZtSVYz?=
 =?utf-8?B?UHF5VXdOWEFqajBlME5ya1Bpd2oxWnIzcGNBQS9PTWl0NUY2TG9TMCtpYmZ1?=
 =?utf-8?B?STVpL1lEMEdQSjV5VE94RUZkY2djVXlwVEpkREsxVVFiMFBSK3c1eGhoeklR?=
 =?utf-8?B?Q2txVE9sY3BlZEJaYVAvYmNtWVFzUGQ5YnJaWllaYXl4ckpqZUt1a20wWkhj?=
 =?utf-8?B?NFNlS0JzcDJoNzFQWlZXcm41ZXQ0L0tsQUg1bWU0R3g5ZHNnbENHTURYOVd4?=
 =?utf-8?B?TFMzTTY3YTRqOHJzeWR3MmdpRmRwYzRLbVJGaGt5TlNzejRMNHdzL1QwMTl6?=
 =?utf-8?B?cW9xZ3lFVWVNSy9FTU5JUnY5K0ZPeSsxQ2NNSkFSNFd1bFRORnFDb3lnamR6?=
 =?utf-8?B?eEJDK3dDOU45ditlWkNCUUJjdExuUDJvRTNjbWZ2SWJXazd3bHVaMTlJdFE5?=
 =?utf-8?B?VjJPY084MC9pY0tTUUJhL2hzejdlN1pEbG9jN2FRTU5Vb2NkZG5ycGMreitu?=
 =?utf-8?B?WnJTS1BORUNFeU0vUG1QdEpVRG1GcEFNU1plRVVOVUhDQWVkQWt1MDhsZ2Jv?=
 =?utf-8?B?VmFBZDMyQkxWa3lFVjhQanZlMGlKNFdnQXQ0SkgvUW1TTG9NT0tPcHFDdE8w?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b12f0064-4c63-4d61-0471-08db83f295fa
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 22:43:32.6444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4p+8Iw1ISjfDYeOjZJBqGh5uK3VMq9JJ+FDu3CDXq2WNS/oXXiEp6cGjpedrCP/cWvgXMdG5W3DtIVheUn5XH7pKf97B90I9dXISnCxj7PQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5439
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
> Makefile only lists *.c as build dependencies for the resctrl_tests
> executable which excludes resctrl.h.
> 
> Add *.h to wildcard() to include resctrl.h.
> 
> Fixes: 591a6e8588fc ("selftests/resctrl: Add basic resctrl file system operations and data")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
