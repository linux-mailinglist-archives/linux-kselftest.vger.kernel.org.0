Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0196EB655
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Apr 2023 02:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbjDVAQz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 20:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234021AbjDVAQx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 20:16:53 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833B02723;
        Fri, 21 Apr 2023 17:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682122606; x=1713658606;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CUGibNBy7/lZpVXaDdX/OG/FgsUMSusK7RsCwKcHG2o=;
  b=gBhQuatxAGgtc/SMaq9LSQtNdY4vg5pECWoRyHyYGJMJgjTJ35YHWKo0
   /r4xuuqpqq27wKuJ8LnlvVN3UPeTTnARnaGYiYlVAI39IjE7nyv8alwqK
   FmVP2VZfG/4zZNjZ9BrxsiDkZDS5d8QPaaBEuf/tDaYuXkRf1EGFxE5ol
   gGPZzSX6zzz/pkZ5hTOnRWsKsVi3TfEhBQ29FpXf8Jtct74Xa8+PsVI4x
   1YvzVLzEaiQedzZM/kyT7SFvWRfa1LEDZBAE4gCJaXLAj4+xW183uJj2m
   4AcnwPSpHO/hsQxS24thvGlrLd3UlbzkKWM1I06vRVjotoNNdzsEuWKoD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="326437738"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="326437738"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 17:16:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="757065840"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="757065840"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 21 Apr 2023 17:16:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 17:16:45 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 21 Apr 2023 17:16:45 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 21 Apr 2023 17:16:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cniUN/fFrli2kAWoy3MkxfHJS0Ioxla4cFWNjf93RDTJpQHraOJqujJJnFLBJktUZAQmsjw4gj3Tvs0iqYZEZWQlkSqqr6iX/MeJRFwkSQHFfMqWMzOzBtwwraECFuGTaz8ExnlCMW5zacuDuuF+OeCFZIKPRMpJxeGc1cksPtzpWTD9jq1XUWYcjrK+HPArfpWKdgcC2QV+j7BH5tu6kv9HISkZxHP56k5SCjImsP3Ml3a8Ybs/8WSgdMsN/OvWode2WJn9+4Jt/GLx8XraM2e3DhBpHPVhTeKNBABUbJchn+TTUIiGp14RHkP3nMj/lrgeLIWfSvvFdwJ4Y357BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xkKnFX6JkQyhtC2/ol5G5xq1UBTdOQ09ldAr+c9i0s=;
 b=PX6iMnC/YfR2gb+HElWsXAGG+JZrxZNqiVTw6eyC54R/0NNUPN6bAsoGeCUKlMK8yEPuSjbhB27vIx/WhqIWbY3mqxwwDy1tRyftNQ5avQTmBI8iAPAys4drRPjYC6By3zZUqGfjLp3gnrawWKcDZELJ7MWxPrY0fTXjdaayeYFXATqW6s6441rceH6Y2vpzCppeyU6OV+fWIkXbQ204TWqGIc+4Kk9CuDDqOLTYXmMJVYYiwLR5iYzLKDwCpT93vM7Q6CONHJUXxM/ra0ugCTJozXbDOV3M5eikuZqUjMTkfgn0FyWt5ieJGcEIcIUdsBohUISueQN9iQWvw67cQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by BN9PR11MB5227.namprd11.prod.outlook.com (2603:10b6:408:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Sat, 22 Apr
 2023 00:16:43 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6%4]) with mapi id 15.20.6319.022; Sat, 22 Apr 2023
 00:16:43 +0000
Message-ID: <1778225d-87b3-fb97-5512-e78ff46d169f@intel.com>
Date:   Fri, 21 Apr 2023 17:16:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 13/24] selftests/resctrl: Add flush_buffer() to
 fill_buf
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Shuah Khan" <shuah@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
 <20230418114506.46788-14-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230418114506.46788-14-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:a03:40::31) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|BN9PR11MB5227:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a3df06b-45e0-4706-c91a-08db42c6da1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9UZJUjLUyRHW7LNCyibpjxN42+BtQDAivN64F+LZGgq3uipTcl9f/Er4tkKzsGItyXW/cTaGZ+KR/haIjOap3RSY+jXiGNIQEH9tFgTSB3ozzxf7uqadN3jozwexd1zb60/yCc/dAg1yK+OhfEC4/MI304pcxOL6Hq3Fw33qRFp70KA9OxKPCgUiSvd7vIoORC28RCRFN9OIgKh6SS1Ush7KQBp+S+RYRpr07W1+Lw8MzwC92nmTzj4IsIBzR4bReY6jjLDGjliscBSzfVrg9w42wvGKQaVa2ofJ7JgzMUIWzOmMKQbRhn9yKh5J67yzRUjg6gfm0FdFaY64i1oMv2Bft70+w8p5eJFUdBHaqUjroGiWtCiTF+2SF72ch0lxE3Vt9xK+rWkbZeKXzSIS+a9Kcw2z3Ju5gzEpDqDTW+Z1CqcL5PLH5n+h5PbkNGpGFMkz4S8F0nH9m4riXwWLAbYrffsVVSNK8jwUigtymDd6139B/Cm+I3b5EuIIr6ufFe1MJKmgG2ueSkjh3dOQtKVCLY7XjIVrdtYG53mrDJ1q+/8B4GKpH7d4euH9Rtq5pFJ9stBu0SB0nOcnydXgpd27qZ1++hl6uCGt8+lUgRPahm+fL/NP3UG0Xi/Q1Ov3gMUVMW+x3IelOtHuw/d7/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199021)(2906002)(8936002)(8676002)(38100700002)(44832011)(5660300002)(36756003)(86362001)(31696002)(6506007)(6486002)(6512007)(26005)(110136005)(2616005)(31686004)(478600001)(4326008)(186003)(316002)(53546011)(82960400001)(66556008)(66476007)(66946007)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0E3Ui9veUJjdDBzdUJnS3lRUEVCSmxJL21JSVh2am9GSmNNNm43OVNkUG1P?=
 =?utf-8?B?MkFhUHM2NStIaW9NdjMrb1Rsb1pPZkQ3YmM3RUFTbFIvT2JqZTFGYnlwOFZm?=
 =?utf-8?B?M3Bwb3JXbmhBUmg1Sm9HSVJGYXowRVIwUUxXS010K0xrTG5tUjFleHIvVFdB?=
 =?utf-8?B?UW5QOFhHcGZZenFTQlcybWRnQWhKR2FxdUF1SXVDT3ZMd3hDRGhWUjRJQ3ll?=
 =?utf-8?B?UFZRVWkwY1JrMGdNUEo5b3l3aVRUeWFIRFFQVGxHQlZGZm1FUkdNRVF1eEti?=
 =?utf-8?B?d0taRGp0UzRRT05RUnFhdEE0RFdMOTlWVGNJSzFYWkVGL3JwQ3p3VEVFVGlY?=
 =?utf-8?B?UllMU05nK002L3RLZ1BKNk9EeURibW53T0F1ck1QbjJWdW9OeXlRdUwvaFdk?=
 =?utf-8?B?eEhjc0sxb0RaNWJicnJGdUFobjBZOWxsMXhUMlJTV1pJTGlqY2QySlNNY1hG?=
 =?utf-8?B?T2toWmJpbW9SK3VUUmpvTE5uaFNibkhGbVF1V1NoSnpHc2d6Q0tyZVhqVzhu?=
 =?utf-8?B?ZHF6Ni9ibzVxZGc1VEN0dEJFSDIvWUJhSEtBT0FPdUVOdVJtZUllYzdmcmZW?=
 =?utf-8?B?Y0tKS2t3VkYweHgrSTVNYzVwTUNlRFJjUnJrOENYV2phTzZVeVlJdXBYbkZQ?=
 =?utf-8?B?MzRRTVBHSXc4ZTIyc2J0alNPWDUyUkFmbmRVbzIwOVNCSnpuTjJhK2tRMlVl?=
 =?utf-8?B?UGVFcXRtaUZtWDltbmJVZWdiUnN2dDM5VzNwVW11eS9iMFhCRFFYdkIwRVRX?=
 =?utf-8?B?ZzIwbTFjcUdLUFFMK2h3Tk53Qm4zNHJHNG95RXJKd25Vek0yZVlHTUluQWs0?=
 =?utf-8?B?Z2xGVGJpSjlDay9YS1JEZ2l0eDdESTY5dUNxTEJaZC8rK1E2Z2VOTk5PelJo?=
 =?utf-8?B?QmlhYUNZaW53N2M2cG5EcXhuSDVUbnZ2cFdGSUlsTEIzWjJGS2JsVVM2VElU?=
 =?utf-8?B?NkpCdGJROHRuN1ZHb0hTN0c5SVlQaWo3RmhoUmRrVGhjN3ViR29wN1BZcm91?=
 =?utf-8?B?M1FoQnZ1SElNbjhRcnV2UEZwS0ZPcFNFdHBKUlFjS01yN0J3S2NKUVBsRHE0?=
 =?utf-8?B?RDlVNlJuT1ByejIrbjBmdGNSTk5FamhkNHZXaVl4ZlpqVFlBMlBBTzZLT2VG?=
 =?utf-8?B?NE5FQzJxU1FvdW9OcSt6UUFPdnN1RjZHaUtCUTVLTXo0UnkzSVYzdU5pSWlS?=
 =?utf-8?B?Ry9lM1NDNE9YdDhFY1JTdjQzekw3bitvT3JYNThjYlZONlF6UTd6WUI0a0JE?=
 =?utf-8?B?K09nWWZ3WlpibzBPbzdyNGVoQVZubVNqLzBpaXZpMVVrTzNLUXJHZ3liK2ZY?=
 =?utf-8?B?QnpFNExBd2pqdmY3OGxsQndaSmxUVkVTOERzZVFkdHZ0RFBaNERRQk8rdjkx?=
 =?utf-8?B?YzA0SllRMUY1WHFiSlNDekZJb3B1Rnd5Y3lYalhUbVY3WXo4K3B6WXpsbW04?=
 =?utf-8?B?RVU4YjJZTVVlMU8wMUVBZmZUNHJja2VZVWVGSCtJMERQeE1OYml5Rm05VGgw?=
 =?utf-8?B?SGxwTlJqcjNUUjJhQWNzNk5uMGdxYko5MlYySFlURmswRktuUTExVjNFQTZo?=
 =?utf-8?B?eU1NNlNFZTkwcldaNFoyR00xOHZtbDdHS1Bmd0YvQS9WbGZXRmh2bHZnVnp0?=
 =?utf-8?B?eWVscXNWeTYrL083VkFJYmpjZUJHTFJhKytQazdDZitPNFV4ZG0rSU1sSnN3?=
 =?utf-8?B?THZEcUhsSjZEZDRaaDM3KzBoTkpjSGdYMnc0UDlTODdSUUhFNDRzbnNLcGR0?=
 =?utf-8?B?akNDM0hQRTVpdFlNOU1qUGdJaTZsREhiN3lBZC9UY2NDZ29BZENhOXI1ZU5k?=
 =?utf-8?B?ZkhQWlVVNThDdVgvdWNoTVJncktnT0h1M2JucGI1eHhhUE9xZGVZaFZ2ZG9R?=
 =?utf-8?B?QS8yU05RNGU1WkZJM2o2WXM4OXpodWJhakJlQnRpd042Zmh5TkdmT3FyejhY?=
 =?utf-8?B?OEtnYSt4RWYvTytqQnFBR0xoOWlnSHkrQkNWZ3I3UFEydUd4WkhucUhid21I?=
 =?utf-8?B?MGRSN21ZOEZOMHRSdmJ6L0NwdUJOY3QvZ1JFaDBuenovRlRPcGtGYVZpUXRt?=
 =?utf-8?B?eUh3SVBpTys2S1NVUFlTaFFGcDB0cG8vSEJCOUR5MU52SGY0V3FYeDVYUCtE?=
 =?utf-8?B?eW1QKzlTeW1rdzZrMFNKeVRlV0JsMDRnQ1pEcDd3Skh0TVdaNEtWOXFLVTRU?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3df06b-45e0-4706-c91a-08db42c6da1a
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 00:16:43.4983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zf4znB/OinldvuFvEd+O6h5lmVYGp9iFbR2ZWxnTawtfBSjaj/JpNfOoWoLVDw9e7v/EY+fOK9aZp6pTSsVDY5KtoOgpOpvdkRq+bZvLq9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5227
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
> Currently, flushing is only done after allocating and filling the
> buffer and cannot be controlled by the test cases.
> 
> The new CAT test will want to control flushing within a test so
> introduce flush_buffer() for that purpose.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  tools/testing/selftests/resctrl/fill_buf.c | 5 +++++
>  tools/testing/selftests/resctrl/resctrl.h  | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
> index 677e1a113629..7e0d3a1ea555 100644
> --- a/tools/testing/selftests/resctrl/fill_buf.c
> +++ b/tools/testing/selftests/resctrl/fill_buf.c
> @@ -58,6 +58,11 @@ static void mem_flush(void *p, size_t s)
>  	sb();
>  }
>  
> +void flush_buffer(unsigned long long span)
> +{
> +	mem_flush(startptr, span);
> +}
> +

I do not think this indirection is needed. In the same spirit of feedback
to previous patches a test can manage its own buffer pointer
and flush it by calling mem_flush() directly.

Reinette
