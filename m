Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF8C4ED0B7
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Mar 2022 02:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351970AbiCaAMa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Mar 2022 20:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343702AbiCaAMa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Mar 2022 20:12:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8341C13B;
        Wed, 30 Mar 2022 17:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648685444; x=1680221444;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1gCspvQbklnz6NRKyvp6wQHk8AtQMSKNOYlMnemrmJc=;
  b=RQjgL+Ea/w+u8k1C8mIfqLGH86kTcQCFL70Gh9Nt5F+HJXjqsI1VjWOn
   TbchDz630jzJqehhzA7FN4hRMjqGMNO08dfTBLd7pjWBHX51gODhI1FcJ
   0/sf5mnxQxZhOGdKi6Nz8A5Fp0blIGjwAG1Az5weMLDv93i6YgREuys1M
   2W+BdpKJeGk2anjWm9kw8bVbRq/m2YhwGLJeUZryMtbwR6LffKttlbsSR
   I8u865EqMg6e6M8GFD9CqTaQY9VQJ8PyfN64KZCK/VFtieMhu2YTGJHmf
   IH0QIbPUHlKTfD9XdBFUn/gB81iHirbpnOFtmdXrFu2VJdLpSk9LJS00k
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="322857223"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="322857223"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 17:10:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="639913072"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Mar 2022 17:10:43 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 30 Mar 2022 17:10:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 30 Mar 2022 17:10:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 30 Mar 2022 17:10:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oc82McB6141MS856Q2h1Rbw52EeCEmBsBkI81O95ynN/n9l2ulF8ffwSqEZKX2ZRX8cZpNENcz9O5FgMWqrLppWa27mUibNMPgjU6plvNxkpHzJxgrYUrBGzvslfBs9Qn9+hcc7+VxA5nORHRnDyLJyghpgHnnAWIxMU3UTMxxmjJwIoyVieY4EjmOtENZEXVYZhYcHjxX0jGVb9R28+PqvnyTSqHhBeXSIsb5JpYe317qaI2KGcxImurthk0WQ7aYBnWZK/+ywV1M1OcK6XDoRAd3wMdWqdyeYqV0s1yDFtuEa9PoazuMZLwkw6dhsRAYUpf4Pe6VO5w4Bvh82yWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdmJ1FLqZEf0/nby/5T+6WKId7HIyrXfxo9PEJR8RhI=;
 b=DYNBwbWQSJQM3tcteoSb4bbZBulY8z/EycA9ks1FcUegYSEF56cXg8Tgh/yNns/LZL71rxHzya2/r86xu5yRJp3En6JCe1OJviZa9Ih4M+uornUTM2LzHB39l8SVpON/BNL4bDCrOD5YUneA/a9dTIR6eLTsICGRszGn2YHzLX3PXTqyL5UhshbWalSw2V1INrhURlddzjKVE8XnkjUYzatHKBHCVdr22h4ugcZFpIVYFHgVdHF33m01fdshgtQmYdFulvTWrw7DqGmItPOAPhdWRiEWv6EA+9gg/2uUVppsXoWoNXQqRygNh9onpdW/xi5uRbw4INZXkf9W/VjSEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by MN2PR11MB4318.namprd11.prod.outlook.com (2603:10b6:208:17a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Thu, 31 Mar
 2022 00:10:41 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36%2]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 00:10:41 +0000
Message-ID: <3aa93449-6951-8085-f6a1-6739b6d515d9@intel.com>
Date:   Wed, 30 Mar 2022 17:10:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v2] selftests/sgx: Use rip relative addressing for
 encl_stack
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, Shuah Khan <shuah@kernel.org>
CC:     <linux-sgx@vger.kernel.org>, <nathaniel@profian.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220330222834.139769-1-jarkko@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220330222834.139769-1-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0210.namprd03.prod.outlook.com
 (2603:10b6:303:b8::35) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2025274b-d56a-447c-8776-08da12aae414
X-MS-TrafficTypeDiagnostic: MN2PR11MB4318:EE_
X-Microsoft-Antispam-PRVS: <MN2PR11MB4318549B99E899D4983ED006F8E19@MN2PR11MB4318.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 92cBa9YWgcOxw+JIokJV8Z1JbGrI2e8MTwe1T7ymNJVd6MFzvoi7Ii5iorcqg/9ZTr77H11c2n0hYmxOU84tcc+GpTQBIs56fPJHA84smk7oR2PHwUS3sNEM/4r3BtqnNn1oyYh/zy2N5M1coIn1xa/xI1ixFwUluYfJKDFHrhwNIaed0qluV1iv96tUsbvuC+vd4rQdjsJp8sDORAvLauK9DzTPJh9I0pJF9Lug4DrZI3t+UW9kcbgENjRd7GlBZIdpNXCrpOZOyd1sC1wrcKdHu/v3U6qYwUFaO1ofxADV0fvr4i+rwytauczk+2L/wO0/F3Ojv+J+sDtBOHwYH0drIwp6s6/x2f9tTRy4XoptG+heZj38U3+6sBI/Qkx85YXP3YDyKqzT1mPdBrzqBYOPlGUojInpmTEzgyEQewJtSqcQk2wqt4PSyY/DvvYoSrn2w13UohpuxufQcwWF6oegK8XgRsH5vxaTm4Sp5NIFitRxYK+zMxjxtwJWd18vVbkZhMLxMieUmN0QWR87kr0INP2XN2Sqnk8e9pnNccJBdtXzTFtESoescxCPwg3KTAtLQNWLC4IlGNVLjCVhXrb4QFIZDYh/ydP7xGAZaMz90wC/nuu68sOVxtAiQLvjpt2s9GCDFa4W2dSOsZ4u+lgylVLEAuFydZrcO9zCeKcTqFQmcmbTAEf2Sg1D61i73jv8GlWTPX1emf7JxCovHsenIT+fd0R34dbYneHeBti6zoTNo4eYhq7EC8tGL++b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(8936002)(110136005)(44832011)(54906003)(31696002)(5660300002)(66476007)(8676002)(66946007)(4326008)(66556008)(82960400001)(316002)(86362001)(2616005)(83380400001)(26005)(186003)(6666004)(2906002)(6486002)(53546011)(6506007)(508600001)(6512007)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWpsRGQ0SVRBbldxRk1lSkNpYnZEcVNRTlQ0UlhFa3REek92ODRuOUNoN0xZ?=
 =?utf-8?B?dWJoUmUxMitURno5aFJ2YTZjNW5uelozQjd4TmE2dDByMER0ZDZFSGpuWlVm?=
 =?utf-8?B?MEdWT2UyWGZ0WFBuVE5UV1JRTmlsQUlxZmpGNTBQcHhiaUE3LzU0UEYxd0Vy?=
 =?utf-8?B?MkdSbEdGQWRubXhDYlJNbjNTanVMcFhMQ0tSUzhsMmJBejhMZkY3TlpneUJM?=
 =?utf-8?B?eU9JTFR2cDdSUlZCWkRWNjUxVTNtTnFrUzB4dm54OHZIZnY4QWsyd2pSYjhB?=
 =?utf-8?B?M0ZackNYakVjeEtod25sbDB3TGJSdEJubG5wV0NnU29XbHZ4ckJ4VjRSN0cz?=
 =?utf-8?B?YTRNUG0vMzRvT00yOElxN01tQzduM1BmWVhFRHlVbm0wQ3RkU2NyaDN1T3hG?=
 =?utf-8?B?RFczbWNlWDU0N25rbGRoaFVHTTZnNDVoT0JDWVFyaHM1OWp0STZTcUlPaGRC?=
 =?utf-8?B?bVB0NnR6Z2JlZHhhR3BKRnlkRlN2YldXeWxSMnpma3BFN2E5NU91M0Z3MHBV?=
 =?utf-8?B?R0xHbExIQ1BRMlpES3JndnRRcDFrSkllald5M3BhM2tFZzJaLzFIa2Fwcy9U?=
 =?utf-8?B?L05VMGxYZmdNVHYvcnJpL0ZnbzllYWNNejNQZ3I0VklISU8vWGpNYmkzemFI?=
 =?utf-8?B?MGh6QW9TY2ZDNHFiLzFmZEpTQXR4T01WYnQvMkNoaThIUUR1K0FseEJuaVp2?=
 =?utf-8?B?bk1PeUdPaUVaMEpvcjFvZWxoRHErYTN6VHhUT2FoajEyd1UxRGloMzRXTDFF?=
 =?utf-8?B?Vk41VGFROGhOejVDS3lkT3FBeEpGSWg0bGpHb0pnODBRVDRoMWVtNmRjdTZI?=
 =?utf-8?B?RGFSWWpSMStaVElPVkpnTFdLZmhRMU1FVEJQeCt2Z2dBeEVNTS9ZY3JxY2h2?=
 =?utf-8?B?MEdHTUR3YTFUcU8vMlFpQWRFZzk0TEl0UjJINkZjc01CSG9rUDM4c29UNlN2?=
 =?utf-8?B?OVNYcFVhZ25QU3BnUkluQXNKU2lidklDaU1MV0pEdVcrTHJqb2xST013Yjhz?=
 =?utf-8?B?RVRoMktRYjRhVDQ3L1J3dE1MY200SFB6dCtVRGZhY3l4TEtrSGVoYUgwTTVY?=
 =?utf-8?B?dkQrZWJuTUJ6YXZ0V2pNNGxjQ0w1QWNTQWw5SEVpc0dXRzQ1Z3VhbFdlbmJ5?=
 =?utf-8?B?QktvQWZZcTAxSzQ3czlBUFp4ZC9JUVFBWHBKcC9TZFphUGxGVWNnSTE0NktL?=
 =?utf-8?B?L0F0MkM5N2xqdFJlRStNY1lWeEtkWjVsYWtheURTUHdUbFNmVlJqNVdBYUV3?=
 =?utf-8?B?UHEwUkRrN3BjSjdrMVdOd1NIZVY3b212LzVhWWNxdTVzdnBPMDgzdFhOZFcr?=
 =?utf-8?B?OENQOUJOWTdKWFoxRHJxRmwxOXl0eFhJajRQQ3RmTFhKVjVTK1FZdXdGQ2px?=
 =?utf-8?B?cDhxQjZZaGJEcEEzalEyOWNjT3RISWc4ZllsZlg2bzhOVTdsNEc3dXhVT25n?=
 =?utf-8?B?Ty9DUFhGNGpENzZFN29HRDNMNGFmR1drcmZpZE5CZGV5anJFc0xKaWF5Qytv?=
 =?utf-8?B?Nk1uY21IRzhYd2FpQUpVUDlSSHhPS3MxUkg1ZzM5V1RWNjFhVE5oNllkRWlC?=
 =?utf-8?B?YWhRb25ZaWk5UmVQZUtFc3NLWnJ6eFZTV2lrOFp5ZWlVSzdpcXF4a1NSbmMr?=
 =?utf-8?B?a0RtUTBYbS8vZmVBVk9SYW1SWUxNZWp4WllLYUV6bzdvSEM4dkQvc3pzQ3h6?=
 =?utf-8?B?bHpNTjBZVm80emd4VFZXRWFYR1lqTlp2UXFhUUkwVE1BSkt1aWRiaGx2ZnZL?=
 =?utf-8?B?UVFRbzAzNXlaRWhxNnltRFNuMXFVMkxyRGpUS3g3aEo4VFlvMG5vcG5uVHlK?=
 =?utf-8?B?TjVXSWl1cElDK3hSQjRQQURHOHgzYXRVb3RERXBGWW5sbzFrRHV0b2hTQi9T?=
 =?utf-8?B?Q0pnZStLa0YzRTdRSlRMU092bWFmR25zdXJmWXIyMTk2VlZVam96V0ZleVVQ?=
 =?utf-8?B?dmsxUGNRaGJjcE95clJ2bzlvSTd2Tll0Sk9QakFpSXIrZ1hRcFFjZHFiR3VZ?=
 =?utf-8?B?QjNlbWxoeU82YmdPR1czd2oxV3VwVWtwUUJBY3I5dFFrTm1URTByS2VDbUdT?=
 =?utf-8?B?ck0weFd3bDMzRFFNeFljdVNOdkNQUUxwZG96emVhRzdHZENCVFhSOWVJVzhV?=
 =?utf-8?B?OEx5ODR6T09Qa1FPZXZJUm1RMDlWYkl6Z3crL3BLWnZyeXFUZHdLNmMvcjho?=
 =?utf-8?B?OGRSSWhGMEI0UlBuaVJRQmpJMy9ubXZ2U0R6c09FcE50Q2VsTmJMeHNrWmRl?=
 =?utf-8?B?YmhjbWwycmJwM1A5d3JBUWhWalA4TjVOajJCWkl5UjJxRDdZUk5KL0dxNFB4?=
 =?utf-8?B?MUVWbEFtem52SGpnaE5SWkFPdmlGTjF0enBGR1k3YURFTDU0TFNGNXN5dk5E?=
 =?utf-8?Q?f0ueuy0FbfLu7muM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2025274b-d56a-447c-8776-08da12aae414
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 00:10:40.9761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/WklIDdE8DPOy1LUKt/zV4GR3Px67FOXdMUzF5rYldiCVhIwPp1Yrpd9GscHiXLjtEBB9tXv7Q6B7q/OkxKlywHjovsuRHFzvwyVK/DNqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4318
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 3/30/2022 3:28 PM, Jarkko Sakkinen wrote:
> Simplify the test_encl_bootstrap.S flow by using RIP-relative addressing.

It is not clear to me how this is simpler. At this point there is no
functional change (except for what appears to be an unintended bug - more below).
At this time the change seems more code utilizing subtle compiler features
to accomplish the same.

Could you please share more about your plans following this change? I need
to understand this better since it is also an area changed by the SGX2 testing
code.

> The compiler automatically puts relative addresses for RIP index addresses.

I was not aware of this. A comment would be helpful to understand the implementation.

> 
> In order to get a clean and tweakless solution, define separate entry point
> for each TCS.
> 
> Cc: Reinette Chatre <reinette.chatre@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v2:
> * Based on Reinette's example, make proper structuring with separate
>   entry points for each TCS.
> ---
>  .../selftests/sgx/test_encl_bootstrap.S       | 30 +++++++++++--------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/sgx/test_encl_bootstrap.S b/tools/testing/selftests/sgx/test_encl_bootstrap.S
> index 82fb0dfcbd23..cc2353f38bcc 100644
> --- a/tools/testing/selftests/sgx/test_encl_bootstrap.S
> +++ b/tools/testing/selftests/sgx/test_encl_bootstrap.S
> @@ -10,12 +10,13 @@
>  	.section ".tcs", "aw"
>  	.balign	4096
>  
> +encl_tcs1:
>  	.fill	1, 8, 0			# STATE (set by CPU)
>  	.fill	1, 8, 0			# FLAGS
>  	.quad	encl_ssa_tcs1		# OSSA
>  	.fill	1, 4, 0			# CSSA (set by CPU)
>  	.fill	1, 4, 1			# NSSA
> -	.quad	encl_entry		# OENTRY
> +	.quad	encl_entry1		# OENTRY
>  	.fill	1, 8, 0			# AEP (set by EENTER and ERESUME)
>  	.fill	1, 8, 0			# OFSBASE
>  	.fill	1, 8, 0			# OGSBASE
> @@ -23,13 +24,13 @@
>  	.fill	1, 4, 0xFFFFFFFF	# GSLIMIT
>  	.fill	4024, 1, 0		# Reserved
>  
> -	# TCS2
> +encl_tcs2:
>  	.fill	1, 8, 0			# STATE (set by CPU)
>  	.fill	1, 8, 0			# FLAGS
>  	.quad	encl_ssa_tcs2		# OSSA
>  	.fill	1, 4, 0			# CSSA (set by CPU)
>  	.fill	1, 4, 1			# NSSA
> -	.quad	encl_entry		# OENTRY
> +	.quad	encl_entry2		# OENTRY
>  	.fill	1, 8, 0			# AEP (set by EENTER and ERESUME)
>  	.fill	1, 8, 0			# OFSBASE
>  	.fill	1, 8, 0			# OGSBASE
> @@ -39,15 +40,19 @@
>  
>  	.text
>  
> -encl_entry:
> -	# RBX contains the base address for TCS, which is the first address
> -	# inside the enclave for TCS #1 and one page into the enclave for
> -	# TCS #2. By adding the value of encl_stack to it, we get
> -	# the absolute address for the stack.
> -	lea	(encl_stack)(%rbx), %rax
> +encl_entry1:
> +	lea	(encl_stack1)(%rip), %rax
>  	xchg	%rsp, %rax
>  	push	%rax
> +	jmp	encl_continue
>  
> +encl_entry2:
> +	lea	(encl_stack2)(%rip), %rax
> +	xchg	%rsp, %rax
> +	push	%rax
> +	jmp	encl_continue
> +

The code duplication (xchg and push) is not needed.

> +encl_continue:
>  	push	%rcx # push the address after EENTER
>  	push	%rbx # push the enclave base address
>  
> @@ -84,13 +89,14 @@ encl_entry:
>  
>  encl_ssa_tcs1:
>  	.space 4096
> +
>  encl_ssa_tcs2:
>  	.space 4096
>  
> +encl_stack1:

Stack grows the other way so by placing the entry here the stack of
TCS #1 will clobber the SSA of TCS #2.

>  	.balign 4096
> -	# Stack of TCS #1
>  	.space 4096
> -encl_stack:
> +
> +encl_stack2:

Here the stack of TCS #2 will actually use the stack of TCS #1.

>  	.balign 4096
> -	# Stack of TCS #2
>  	.space 4096

Last page will be unused.

Reinette
