Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808A64D6ADD
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Mar 2022 00:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiCKXPP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Mar 2022 18:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiCKXPN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Mar 2022 18:15:13 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECDA64C2;
        Fri, 11 Mar 2022 15:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647040447; x=1678576447;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FsR6DWR55yDY5Me/ezz8WgAFdGgFtb9KVgTNL+5Q36k=;
  b=QNeR9ATlmwlhHpmy8a2gfElc9V4b8zHkD8SCGoApJm0U2Oudtq6DZxD9
   g6MOWqpQSaZXgwdc2CDaP2ya6+26XGFU82Bbwx6YtCX4+WcI+ZmXWFoB+
   zJhNS0jXXlKZZtJAafOBfH0NFAX3K88u9PB+koka7ukfrC4/oA5Mcx7hb
   U0kpFb0x+1HbyOIDcEVpRbB+MzzOLhGRTxnpGT6ZECt4zC61dX7/bgzz8
   w5JjORO42Hzp+xZYydgyP+HbIkGWBqeBxgb1UYBQRaJOWbMbgUncNmP7z
   zKwaYvK4sPrA16Y7grZIn7tAAhXJ/1EBmVYWMQ9C+CO9h1C4W4HIbBVTC
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="236272313"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="236272313"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 15:14:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="514667621"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga006.jf.intel.com with ESMTP; 11 Mar 2022 15:14:06 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 15:14:06 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 11 Mar 2022 15:14:06 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 11 Mar 2022 15:14:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhtfHcv7hC/clp3C/g97oGN9QQhdOtaWHrLMCx3yxgZjN17DoZUQE5J265/HNbJ3EmVNksUbVoawaeyEVDgQA6qaGxPQttag4mT9oUr/5gONH1OupLPyl2T4Q37VyPJX37j6HnnHeIKfSjZlbopu1A8JyYa7/3/a9hoYUBEiheMrAALHfv36uZXgtFCXsqXitBJ9JZmJIfEz4DVBBGWmhsFQksVdqw257pQDwAeTxwl0VYg719hTVQqus0GCiJGPDnUwpn6LfkxNJ+X2uyrrNw4xqK6sDncMtUIgRsniZCSYcl0ovmDiyxXD0vIUiUrEB8czjGngOTbofbGyyIzGZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQJEByoghuhcaAjjiZAHuUr487Glo4maQZAcg9q/2yE=;
 b=SRX3gm6Sc0st70V+Yz2EGWmsesNewiLtYEo5/j7ogSUUYGYC+Heyd4MoTe8f5OedApVBQIGuupBJzn6jgbQmEzSUe6czlkJm1vjzxjn/dVfvNfSKgnB4LQi10AG+TUCzjGCMzA7sr/pfbvdtgUlClG1MemyRxAJ3sZ9bXJeYtYbHsHOThVliVXu0UIVwNyMDz8M9I1k5mib1bU4Tv10eS8txEvFwrmTIWq600vy4sbknjYmt7q+6KDNVNN6sL9MjXX+5mVGYnnIEdN177vsC/yvaGvV8zh/w65XePRZshUy1NECdiC96mVeRiA6mt/rYqWunCiWLw8ekWLIc/7Q1dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB5740.namprd11.prod.outlook.com (2603:10b6:610:101::7)
 by CY4PR11MB1512.namprd11.prod.outlook.com (2603:10b6:910:a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Fri, 11 Mar
 2022 23:14:03 +0000
Received: from CH0PR11MB5740.namprd11.prod.outlook.com
 ([fe80::b432:16ba:2819:d702]) by CH0PR11MB5740.namprd11.prod.outlook.com
 ([fe80::b432:16ba:2819:d702%5]) with mapi id 15.20.5061.025; Fri, 11 Mar 2022
 23:14:03 +0000
Message-ID: <54c1f2f7-5475-6c23-7dbf-3a72c7405c53@intel.com>
Date:   Fri, 11 Mar 2022 15:14:00 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCH v5 4/6] selftests/resctrl: Make resctrl_tests run using
 kselftest framework
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20220311072147.3301525-1-tan.shaopeng@jp.fujitsu.com>
 <20220311072147.3301525-5-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220311072147.3301525-5-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:300:117::25) To CH0PR11MB5740.namprd11.prod.outlook.com
 (2603:10b6:610:101::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a1552b1-9a46-498b-2b0a-08da03b4d52e
X-MS-TrafficTypeDiagnostic: CY4PR11MB1512:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CY4PR11MB15128059ECAB1AA3B8E3EA5DF80C9@CY4PR11MB1512.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BYk3Cy6zAJv7+/viHQ60r0jPTZdyGr6GPwTNB/KF5NKOejRZh1gVI3PZAh+Fx328sG8O5MvaXt/vRkvQMbpWqgg+xOMNiIAOt3hJOShxKRX3M2B3YWrNSCx2HWfuAhd0+jvS3xmhwlk/leHYVMvd6O9TDPWqCEdDdduZJmiSN2dswCmMwis4FHS4E0Gq16IzmzG83QiHZbs1AOBc5Fujs16ukhk0Ng1TCFhtDmdSbkmykkHNnoitZ+WgrxDPeC18Z+j+LLovVZp8F49nhJCnXwf2i9KTEK//3gl8TqYHA5DS1tnTjwywrIt5ysOxehDRrzd+gHtVWeAN3lAscELY3GC/LXBPH3Qcw/6IQbagyUfV2h00AiQgJEkWuNeunHG5EQ6FQlxFo+/1AeXTIZ405W0MwYCkZAHua3kIKtB3xtw0L3BxCNDgarL8bjsBctWp3t+FitXHZLUd/1qOLIJahf2MA93Nax3m0iuNFPbAeuwD28RmiBU4M26TOhatRx+ej2fYHnqnU8mR1x1tH7UPvbI4XfA+fW+jbt0iDs6MpPjVOjM5eW99R8gn8rQB+PLgoaXUe3+oLwgPjxX2GJ5IKzlhMxSa9CQ/29VFYZ0u/26ZILJcFAUoaXgYQw6guxZWq4EL4eOS3uHsQnZLXoB8O1Wdtzo+gvGvro1tf6gBLacF0qjZh4Zbhk6ICw03WRT8wDc6QGyfCVtgmDRfTrpznPoUiOIYzAnWfNc08sYxCJeN7mRI12c7R+GFRlffYMW5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5740.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(2906002)(5660300002)(26005)(66946007)(6486002)(66556008)(66476007)(2616005)(4326008)(8676002)(86362001)(53546011)(38100700002)(44832011)(82960400001)(83380400001)(36756003)(6512007)(31696002)(316002)(8936002)(110136005)(508600001)(6506007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVVQRm5oNzNqeEdzN3ErSDVtRmVOalZLL3hjSElUd3VBVkgvcHZpRjBhT2V5?=
 =?utf-8?B?MENCZjhkSTNDdW9OYVU3WGNWaHo0TW5MUGNqTy9VeXEzOE1KMUdMZElUQlFO?=
 =?utf-8?B?RXR2MlBrQXVPTHhWTjdMRVJidXp1akFwNEpSUzJtTkJXeElQUHZ4cVhZaGJa?=
 =?utf-8?B?QWtUT29ON1RNNXk0R0hxNi9SK01nL0dsT2o2Z2pxZXZNamhsUmJ0NlQrU0s4?=
 =?utf-8?B?dHE5UjkxQzVzQk0wNmRtOXFZWk90eWxjVHQ2YjUxaUFVamlSVHAzUTFZc0V4?=
 =?utf-8?B?bWlXSVVNcHo0cUVlV1VPVjVxQmVaRHhlK3o4K0FpZGJYUXpFZVRVaDJnRmh4?=
 =?utf-8?B?dmQ1bkQ0SWphYzk2NFRIZ2NtWVdXQUVXc3NCRStQY3VBZnFJYnJLUG5rSmZx?=
 =?utf-8?B?MjZvamhkVEtmZHdpUEdlbnFGQTVLTUhLZnBveW5LRGF4ZXNiSGVLb1RrMnVZ?=
 =?utf-8?B?dFpWRm51MnJOaE0yZDBiNHExUmFWcHc1V2lONThmNmJpWkRlRzVkNDFGU3JQ?=
 =?utf-8?B?S0tSdVVsYVRQVFBqRlBDZ1M3ZkdrdFpkWitaM0VJcWJQbndyVzRNTmtjZnRY?=
 =?utf-8?B?Q3ZqQnVNNG9BMzk1cXd1VHc4cTBSdmNTNXl6SXN2NXdVaERxdzN5ZVF1ODV4?=
 =?utf-8?B?MUxRRnhyRnlVMDhUbVBOQTlsUHVpbUFvNU8wWE5xeklPWVpnYWVMcFkvN1Nm?=
 =?utf-8?B?YXUraXdjd3ZQMUNkQnFFWEsyVXFqTUJBMjYvWGFxYVJnZ09PcWJQQmxtcTkr?=
 =?utf-8?B?UWtPdC9ScW4ySGZUeHRRWXkyOVkzdnl3WGgvZlA4YmpGOXA3RjhhZlhTRmQw?=
 =?utf-8?B?MXozRW9hOUczSDJJVDBENllwWEpmNE9UTm5xWFIxOHoxMnJZQWtscE15T0dk?=
 =?utf-8?B?SHZudW9CcFZ3aDhLczd1c1VHUVBSb2x3VlljQ3ZVZEJQRmFtYm0yUnA0K2lJ?=
 =?utf-8?B?R0M4Um5iYW1DSXhzVjR0OTN6NE1NVnQ2MjNpSm5MSGNXbTdUZ3hqaU1zdTBZ?=
 =?utf-8?B?NjJkdzhpTGtDNDU0TUVyVDdzZExzMDk2a2E3RXBZYVRaUURQaUVpU2FOeUhC?=
 =?utf-8?B?ZnBzNFZyRS9FMjlYbWpQQ1RLNDIrOHZXSFBYODEyRnljQ0VNbjYvZlUrRUY5?=
 =?utf-8?B?MW0wTzMzZU9tVmlSZjdKVDJaRGRmbU52TFZVZ2U2YkttKy8yQVVuc0ppdVEx?=
 =?utf-8?B?bzZ3STBNZlVFSnYxNTVsa3llTUFGZzJiV2ErejA2dnFyUGtvRENCVDhpV1pJ?=
 =?utf-8?B?ZkVjMXF1WHpPajc2ZVNzV0g3N3pnOU1BSmZRZXluSU11dGtaMWhhZE1FQ3Bl?=
 =?utf-8?B?VU1hTCsreis4K1dXRGk1N2V0RHFpaVFVenNLZFpGd3cxbldNRkdpcTFBOHph?=
 =?utf-8?B?WU8yUkV3NWRtT210aE5rS29TdEtOZlJYNitnbWxKd0U2UDh4aTJFU2t4YXhS?=
 =?utf-8?B?TjIzV0toVS90SFcvVUVjcXJhcG5lZGkzNG9FNExxT1czNmJYZmRYNGRkY3VO?=
 =?utf-8?B?dG4rL3BON2lHcXdBdzg2UG9KaEM5a1NVd0VndXlzUmdiWGo1aVJkWElzeC9m?=
 =?utf-8?B?UmFGVEtZNjNNeHkzSldVcEppY0lKMWg3KzhhZFRMVWFMUDFIRmQvaFN4Slpr?=
 =?utf-8?B?K1ZhRGNrRWhLdHVWVUFhZkpCOUdKMlVMdGhQVEdVV3VGYi8yWHpJd3EvcHVw?=
 =?utf-8?B?SFM1dkRJTElrZ2xmS0dMb2c1VFpsMW1KUE81U3krRlhwWHYvMjEvNUR1MzR4?=
 =?utf-8?B?Y1hhNUlFVFhxekgxK3dBd3NMWHFJTTU0RWxJSTQwdHhlc2dXWDZqNkdRMEt0?=
 =?utf-8?B?UE5pQ1pGODhMQndWMWVvMkZSdEtMVmFsQ1l4akkxck9nUlhVNVZEelpBNk51?=
 =?utf-8?B?ekdRY2MzNHpCeWQvbUIzK3RKc0gxU2I1VDQ3NUcrMmNRWmo2U1RMbmhlVlVn?=
 =?utf-8?B?L2loY1RSUE1ERk9oZzlIOFNWZm5BcVBzNE5tVkxaRmw1MG5YUzZvTDI3WXJE?=
 =?utf-8?B?eGc5MkxJTUxncGlOcE9LSXIxdzl0WkE0SHl0L1lCbzNkazFIbDAvNkIvRVBl?=
 =?utf-8?B?cElyVEh0STA3cTNuZXJ0cG9tTlNHWjZKOTdoOWtEMHc4YWhZKzI4MFk4S1ha?=
 =?utf-8?B?UG0yNDhCbVQyQVlnZ2VmcWl1angreTFDcTRETkVKSFR6MkFiUjF0dlNFdEE4?=
 =?utf-8?B?KzdyQkM1V0drRnV3V3BJdDVtZXlQeVloOEF0VkQxSmpyS0hUWEQwU1FmbGxo?=
 =?utf-8?Q?LLIEL8QfJKAzNkNlgm4ie8w3KGyPcdrbPZGH1nXxy4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1552b1-9a46-498b-2b0a-08da03b4d52e
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5740.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 23:14:03.4727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UcLi91JLq1Rd12plOCI+Fi17xhZjlyNkGWCq2WoDL2O9MGiGcmIm5oqKTuvZNFnb1lPG+OWmvcBmYzPnjFgkLufanLEMFLAE6pTF7fddSpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1512
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng Tan,

On 3/10/2022 11:21 PM, Shaopeng Tan wrote:
> In kselftest framework, all tests can be build/run at a time,
> and a sub test also can be build/run individually. As follows:
> $ make kselftest-all TARGETS=resctrl
> $ make -C tools/testing/selftests run_tests
> $ make -C tools/testing/selftests TARGETS=resctrl run_tests
> 
> However, resctrl_tests cannot be run using kselftest framework,
> users have to change directory to tools/testing/selftests/resctrl/,
> run "make" to build executable file "resctrl_tests",
> and run "sudo ./resctrl_tests" to execute the test.
> 
> To build/run resctrl_tests using kselftest framework.
> Modify tools/testing/selftests/Makefile
> and tools/testing/selftests/resctrl/Makefile.
> 
> Even after this change, users can still build/run resctrl_tests
> without using framework as before.
> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  tools/testing/selftests/Makefile         |  1 +
>  tools/testing/selftests/resctrl/Makefile | 18 +++---------------
>  2 files changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index d08fe4cfe811..6138354b3760 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -52,6 +52,7 @@ TARGETS += proc
>  TARGETS += pstore
>  TARGETS += ptrace
>  TARGETS += openat2
> +TARGETS += resctrl
>  TARGETS += rlimits
>  TARGETS += rseq
>  TARGETS += rtc
> diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
> index 6bcee2ec91a9..30af27b07d21 100644
> --- a/tools/testing/selftests/resctrl/Makefile
> +++ b/tools/testing/selftests/resctrl/Makefile
> @@ -1,17 +1,5 @@
> -CC = $(CROSS_COMPILE)gcc
> -CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2

Please do keep these CFLAGS. You can find motivation in
a9d26a302dea ("selftests/resctrl: Enable gcc checks to detect buffer overflows")

> -SRCS=$(wildcard *.c)
> -OBJS=$(SRCS:.c=.o)
> +TEST_GEN_PROGS := resctrl_tests
>  
> -all: resctrl_tests
> +include ../lib.mk
>  
> -$(OBJS): $(SRCS)
> -	$(CC) $(CFLAGS) -c $(SRCS)
> -
> -resctrl_tests: $(OBJS)
> -	$(CC) $(CFLAGS) -o $@ $^
> -
> -.PHONY: clean
> -
> -clean:
> -	$(RM) $(OBJS) resctrl_tests
> +$(OUTPUT)/resctrl_tests: $(wildcard *.c)

Reinette
