Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25A04A4F8A
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jan 2022 20:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377091AbiAaThM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jan 2022 14:37:12 -0500
Received: from mga06.intel.com ([134.134.136.31]:5486 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377035AbiAaThK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jan 2022 14:37:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643657830; x=1675193830;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bWJgS1PY1Z8m4rdALJP0z3w3a5qdSQk44rOWiXNknTs=;
  b=ejavWDuwcMqdjlFU1IJ4XkLW1OSEpedPNUvOwswoWSJFM7KNghSn3qL3
   nQh/w7twBe1Omd0obC+nXI1dbvwQ3yRNyFeHrUi8SxjQ3Va3L0Udn9VHi
   47Ys3vyVtZZOUzQgSJwKrJwczzpDCD70mUUf+9lgvdEka4k8v+NH8Cu6O
   WQMPRSEASnufIhWUbz9P4p179gRhlhGZ2NwIU9fS2K6Z67LoJ4MNTvDBl
   QuPrqYp6GI6Qh0sXvjoqOVXhgr3UEdV/WEc0X261Jw9SyjeB1AW4JYBHr
   T6NwQ3OpWtH5kPYDSqw/TrzqbVReSWgOGlvQ0L08i+e6d7a+od6hoPvxe
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="308268175"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="308268175"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 11:37:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="537442493"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga008.jf.intel.com with ESMTP; 31 Jan 2022 11:37:09 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 31 Jan 2022 11:37:08 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 31 Jan 2022 11:37:08 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 31 Jan 2022 11:37:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcCK9Wv/a+JV8ZJS2Eryk5Q48ATC/NYYIsguAcRAD46q+ZKKm/eMdmzqM+0MceuExFn0uQj8O3mEcgG6s7cZd7BGhcgKuigBKhSHY9BUrXh7y5nlNtijYM7GaWRfwVFiGNGb/1GI1YDWehyFquH39f8KOVt/9rWQeMbOyEtEhTDMpTmvM2XVYAuc+iSFOugdrT8ENqJ3Cp/dfF6CfPrmrPP8ETeATbga6wf04IUX6C7jVxebk3D5eBRgAg5WvyFPO66JkchUY91i45ozyQ+raJcZmouJ0GuHw/k2Gn4huNcR7hdQ1iCdx230tk3JgtVwpOS9ABAeiO5YGKRoRAUIsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1+k1IdfMz5VvX5gaMRI7oargi1SSzvMv1uzFqZrMoA=;
 b=SzuLTV/GNIHQXFE+C/Nu+tWirb0iuIm28VfhiLH+upNL+EpsT/qNfDw5aIXm967+da25Cfoii2DO98uHI0P08pp8vvFKAkYswrEWhZHTLei5qnpVcJ2vqzl8IRP03lJaQxvn375IdKAfA0cmvPq8XqDROpuAmRrySZwae/SfZpuL3ElPw5B8RhbEGOAYRC9tG5m3Bbu3+JjMRPMoZ/YZluZAC3sbBzwsxMOD9ESN7wU9WSzO+pYtiIqsxs5phKQNWYHargljPXlt3DKXRTm2EyDjAysaAbpYbC7ljOh1SGT2If9ewPmVz1xzCFHa01brJilwfnsQue9phUQGhKv7NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by MN2PR11MB4094.namprd11.prod.outlook.com (2603:10b6:208:152::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Mon, 31 Jan
 2022 19:37:07 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0%9]) with mapi id 15.20.4930.022; Mon, 31 Jan 2022
 19:37:07 +0000
Message-ID: <7ba5e99a-9169-75c4-2324-f9a3ce9a506e@intel.com>
Date:   Mon, 31 Jan 2022 11:37:02 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.1
Subject: Re: [PATCH] docs/kselftest: clarify running mainline tests on stables
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>, <shuah@kernel.org>,
        <corbet@lwn.net>
CC:     <linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220126201341.55771-1-skhan@linuxfoundation.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220126201341.55771-1-skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0148.namprd04.prod.outlook.com
 (2603:10b6:303:84::33) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 140fe86a-3378-419f-b87c-08d9e4f110c8
X-MS-TrafficTypeDiagnostic: MN2PR11MB4094:EE_
X-Microsoft-Antispam-PRVS: <MN2PR11MB409407B0F22E6DC0F5E7A0F6F8259@MN2PR11MB4094.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HqYI5gqxbU8E4sRtWoisVnSvESKpcsxmyH+Y/wabObSnRF7p0TwYDQLe//6mtUiYWV/cI1o+smNyUyCk1iPB90aOQTLBYKyCqqJuQ51s/mFAjJByMRCqbstG0nzhnIRt1/uAYggMLHYDi1V7+f4Cv0m/+HhphiX8O5Yj76q9070rrQkLtZvK9HzkV1SLg42ZkC2zFWdpERbnZk2LojTJbmekkVMjJqU3GO2awD8XXgV5CJRqjPn0K1uZ04gUMqfvc/Uhq1rnjCtGCmCYJHEw3qirYDl83lWElGY2PeVoBDHe90DcO5yMPAHlWIdDYOx2ZXCBI5E9AadLbsscYgVfMc8NYwBDAOm4cC5sADGJUDpUr10mxhv7jbZs1fUyyOG/voliw76ficYnrdQbNH9SsBTxdhpLAniH0EGKVsNvr9czWnGPTlwRONpEdbFI67yhLP/06tTRrADZ1dAbAUMAjZMWiZ80KwghvzwxFX8wj/ScUlxe7IlvyascMuWEeXLE9sUfPAd5U1RXCh7gZFIK3pgfohf2h5CARNSlg6PMty7WRV+dZ06jOn82BnkvozE643+yf0fxUiKGzQHnBMUmsBTFaUdymPh/R10crxT4cjB/bRFfhG2vPBeH6OrxZxTfHGbjGNHkbvQY8942XAqGxfs7GAvnGUydtWWNd5HGWcXqSz+l4YDV21An1KDesrJnxMZ5aaW7j56hCVz1xmWzxo8ahoz9oN4ViFE35DzNLmU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66946007)(66556008)(2906002)(8936002)(8676002)(4326008)(36756003)(31686004)(82960400001)(5660300002)(6666004)(2616005)(26005)(31696002)(186003)(6486002)(966005)(38100700002)(83380400001)(316002)(44832011)(53546011)(6506007)(86362001)(6512007)(508600001)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGNWSGhkT215bVgyN3dCdEZjWUVRaCtEUkdqQUVpUmFzcXdYRzRLYmljVndE?=
 =?utf-8?B?aVVzUVprdXpLV1RtZUpKazhxU0dzbzJLUnVzek1NelkvRHFDdDhCQW0wQ3JJ?=
 =?utf-8?B?MDE4elZsWnh6OG9QNmI0d1lZajBGMy8rRFJEM0lzVTZqNDFlNU4razF4YWxS?=
 =?utf-8?B?NmMzS1ZFeUFRTFdYVGFlTkdmQkExNUZIdmYwTkRtQTkrNkJ4clVlNDhZcVhP?=
 =?utf-8?B?YVFIZGZ6UmlIVEJDMk1yMDBNNEdmbUgzcVdQb2paNXg5djNxMFhnNXlnY1Av?=
 =?utf-8?B?N2dicEtZanRUYzZZM2NpU095OS9JV3JyQjh1ZmFQdkRhWkhVc2FiczkvWTlY?=
 =?utf-8?B?dmxKTFRHaHYxYVBIZXFWTXZKQ1NOQ1JXZU8yS0lzNmlqNVNBN09Meit4bFJT?=
 =?utf-8?B?TjhhRWpEbkNOQU9zcUxTRHBOdzRMdE95TzVsbXk1V0FlSXRmOVpOOHZwL0ta?=
 =?utf-8?B?djZyejFQcEZBZHdQNWQ3NXB3NWFEYzFYZ2p2UGNHa0RPME5qcWw5UFREVkhJ?=
 =?utf-8?B?cDZEUnBuUTdiQ1VMUUhOUW5pY1VMa3lGUm5Gc0N2SnBIUldpMmhNckppTU1m?=
 =?utf-8?B?eVRKMEtwN1hSVnVOc0FSanY0VnVoMG5pUlR0U1lDdnlEOTA3TW5xT1lVZmVk?=
 =?utf-8?B?QzZzcmFRREZQRU5welBPd2oyVy80VkN2SW5GU1RqT0k3Z3dkdlpCUUFjZVNK?=
 =?utf-8?B?UHhjaFE1ZVFjdWltZ1haS0Y3QTgya2xJKy94YnpCWk9lL3puQ2hzRURuTUpw?=
 =?utf-8?B?YXdjS0NVUzJxdmlrZ05LaDllQkJxQ2dCQnhJanJnQ21uU1dxanYxcE53NGVU?=
 =?utf-8?B?c2thZkpxTVVhZlkyZEVzbGJReFpSbXRzejRzMUdGTnZPSUJyNUIxYmdNQjhH?=
 =?utf-8?B?dVlWOGdVM2xqNXhsaEdhd2Y0L2dUcTU1bTl3WUs5MFpEbmhvRnpZWjQ0Wkwr?=
 =?utf-8?B?YjllaGx5MVhrMmVENWN1eFJIWGg4MEVGcnZWNjM4OFFtYnBMNkFnTUF4MXdH?=
 =?utf-8?B?aU1RZlRIUVI1b2Qwakk2TXYvNElwazYvQWk2NU5LQVNZTUNaem04MGJvS2lZ?=
 =?utf-8?B?by9NZ2gveThmRXNTQk1BZFJCNW1YYjZ2RTZiRlA0QXBPZ29QTFF2UmYzRVFi?=
 =?utf-8?B?N05YRnVJT3ROL1NxVW0waGY2NHVsWlJpbjVjbFV1R2JmTFNSMkNIcE9LdlRO?=
 =?utf-8?B?bkVaQldVVlpTaHhRQVBCbjdBalEwaG5WNUJVUEtDbXU2Rm55S1dZRllkNXow?=
 =?utf-8?B?Rm5jU1E1U2dONzNlKzNZUzNEeUtwZWxJWW1UVjFQQ24zbTEvNnUveHJCK0Z1?=
 =?utf-8?B?QnVWNDJ5NkJwc2tmTHMzOUpQM0pvK0hFclRnL0dPVHJsYlUrbHBzeDV6WUJI?=
 =?utf-8?B?MHh3RDI3Q2pHMGJDcDhlbDRxZFJyVUNqeVQ2Rk5WM1NxMG5UYU83a011RUFo?=
 =?utf-8?B?Y3M0SW92akNDWjRQZGgrUHFhRmRKZnRaY3JzUkhxZlNaOVpCUXFiS0R3S0d6?=
 =?utf-8?B?L1Y3UFJsOEgyVEhwUzdqKzNBQkhoQWtiUHBuS2NPRjNjRkdJMTRSUzBxZmRv?=
 =?utf-8?B?akxNcWVNTmVOVndJa3ZNbSt5cXdLdS9HSlg2VUNhY2YwMHZQU1piQXlXcUxF?=
 =?utf-8?B?aVhrSTZqb3hsTkh3cEo0WlpFTStaNldpSkJUTm94OXlYdmxVOHc2QmlobzJ3?=
 =?utf-8?B?Wnd0V1poTFI5VWZBa2ZrS1FRMFJ4bVI5TXo5bUFoZkp5S1FvRnUwUjA1UEdD?=
 =?utf-8?B?alE4VUNRSzkrSVJZVTFESW40SVJBR3lrOUFYc0JISzQ0MndHNzRaVVBGQ1RH?=
 =?utf-8?B?aFAxekhqemx1YmIwNGEvSDlSYWoxbW9yK0ZPNjR2RGJvZWtXb0xHKzV4L1pC?=
 =?utf-8?B?RUdQeE9Pb1pwYTZpVnFWeUlvUURMN0F1dUNqVXNQUlpSaFdXRnVaSmhIZ1Nt?=
 =?utf-8?B?ZHV1OUFvVTJpM0pzaEprQXpTK1QwOTJXMHptSjNTRmxzNkxDRmFXeHFhZVla?=
 =?utf-8?B?N1FUVllTMnJhMUhwb1ZYWEt5QVJ0SFduU3ZYenJpbkM2ZUpTUmhQWW5CTStk?=
 =?utf-8?B?V2ZMenFrUjV0cmRQV3dLZWdFcGl4OWhDcUhQb24wSXQ2dFlYTWpsUUFaa0x4?=
 =?utf-8?B?ZWhYeHdYbVVqSHBvWUtJSzRwdHd2YTMzYUxrMXdGMHgwNUloS0lmZnlqVzVV?=
 =?utf-8?B?WjhSd0VVUjUyYUtpQUg2M1ZiNWgrc3JCOUdOVm9DdVBjbkYxaXd2bnhha1l6?=
 =?utf-8?B?Wlg3MC9rQ3VzZ0ZlSXd5Q0hjckJnPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 140fe86a-3378-419f-b87c-08d9e4f110c8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 19:37:07.2445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Drk2pXqlqFoLa1fQXXFX7T13VIt3H1H8CkBO0tXxFPRmYzKQ1+IPyEcYv/zTakwisXytL24e6Fn5aTWvDq2jo1AmzCmP7Qu1yaRqsWpYaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4094
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

On 1/26/2022 12:13 PM, Shuah Khan wrote:
> Update the document to clarifiy support for running mainline
> kselftest on stable releases and the reasons for not removing
> test code that can test older kernels.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  Documentation/dev-tools/kselftest.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
> index dcefee707ccd..a833ecf12fbc 100644
> --- a/Documentation/dev-tools/kselftest.rst
> +++ b/Documentation/dev-tools/kselftest.rst
> @@ -7,6 +7,14 @@ directory. These are intended to be small tests to exercise individual code
>  paths in the kernel. Tests are intended to be run after building, installing
>  and booting a kernel.
>  
> +Kselftest from mainline can be run on older stable kernels. Running tests
> +from mainline offers the best coverage. Several test rings run mainline
> +kselftest suite on stable releases. The reason is that when a new test
> +gets added to test existing code to regression test a bug, we should be
> +able to run that test on an older kernel. Hence, it is important to keep
> +code that can still test an older kernel and make sure it skips the test
> +gracefully on newer releases.
> +
>  You can find additional information on Kselftest framework, how to
>  write new tests using the framework on Kselftest wiki:
>  

(My apologies if this is already documented, I was not able to find this guidance
in Documentation/dev-tools/kselftest.rst nor when looking at the
"Kselftest use-cases..." slides linked from https://kselftest.wiki.kernel.org/)

Could you please clarify what the requirement/expectation is regarding fixes
to tests? Since the recommendation in the above change is that Kselftest from
mainline should be run on older stable kernels, is it required to backport
fixes to the tests themselves to stable kernels?

Thank you very much

Reinette
