Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B3E5A7134
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 00:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiH3W5n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 18:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiH3W5l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 18:57:41 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B36F7D7A0;
        Tue, 30 Aug 2022 15:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661900260; x=1693436260;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OAXq88zplJgIg7r/tckAk1F6XjVbhJwpBam3+ltHKE0=;
  b=TqQr+b3wt8K6GgKlwUe9UemQj4n8W7cETfLcTmD+GFZMCGQ2mkwBHK5H
   WeclO2R/2biPQx55nrpoU105t0SGY9iI0rgI5TWwFlKovqd94bViM9cQS
   EpcuMEdMr3xC7ogKCN5ooZn1+1ztxI/xEI6D05aT51jH0PB3aObZ0lH2Q
   H4NJ5Hju/6du/b5ODlfJ3MUMyMho4E/dc6swFBmDQ8mH6SepSIQ7Aaipy
   sDb7ttqRwa8oIcth9SIx0aJChqT6m9Aq9l8+jTE01A3L1G63u2MjIcEo5
   eyssRpVUtUz8eal831FS18tbT8A4BqoTHiXxK73dtYhM8PER6kZYj2JzD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="278341920"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="278341920"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 15:57:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="645025640"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 30 Aug 2022 15:57:39 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 15:57:39 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 15:57:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 30 Aug 2022 15:57:38 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 30 Aug 2022 15:57:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjyoiXOJKUmEAb5VGEsvmemRh0V3Kb3i6g3XnU83LZm4x3vuRc5/yBYQ/PjWjdukVjrGiSwvLKH8TLo8DSujmQlYV1bRc8vEDmAjfpPezLrbRWFeZ5JxwR5XaujfubmVwuW6yCbiM5HFVKUjsQdHBsnw5gXzOlHKPzCJB1C+IZicdg24kT5yZD5LDl1IvtQ2vTBHfEcfK9XNaprATXXywuFVcBA2LGtGFTpPr373sJPUmceRFuRExU2Yc4ZUG9xAQEqeIxN97PqbJOsvHty9+44X1FhCw3szstwlLpRbx5bH0WIwajyM8wozug7Oo6Xr3w3Onc7fd/jY5VSc/exMjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbHqP365cXquLETt8PEoAY0w+5zUjoxiLeq84CJO4ZI=;
 b=DLwag5t21/3dLrQK2LY8a3fa6XG8lgLygE+5ntEZYMY8+RXUbBAWJAeA5sql3Gsuyw/1QSovq6/VCuAxtZVaFa+efrVyZ+soxqOXBzJjfQ5L4nlABA7vsGNPpxHwU8X6ifvMDwgSVq0sd2IOMAl/cYAvF3gTrHp8TRFBJiEEMhjybyObGxTvME0nATlOz4dqSxWTa1N+WMPv/D70asIuqvs+h97DrduwOc113apk5PXci7l35Zk/HQVCBWGgIr4b2nNZIwNgNsYkB9FmUPs74BPKN+5LgmSUG/aqFuN8WF7ofRUUCHcINheHv6aBOcknFD4uJtKSooJFLhVCZRgG7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SN6PR11MB3487.namprd11.prod.outlook.com (2603:10b6:805:c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Tue, 30 Aug
 2022 22:57:27 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%11]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 22:57:27 +0000
Message-ID: <64498c9f-a6e1-6379-ca8e-d751fb239bec@intel.com>
Date:   Tue, 30 Aug 2022 15:57:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.0
Subject: Re: [PATCH 6/6] selftests/sgx: Add a bpftrace script for tracking
 allocation errors
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, <linux-sgx@vger.kernel.org>
CC:     Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Shuah Khan" <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
References: <20220830031206.13449-1-jarkko@kernel.org>
 <20220830031206.13449-7-jarkko@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220830031206.13449-7-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0069.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::46) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5938e17b-92f1-4e6c-41da-08da8adb026d
X-MS-TrafficTypeDiagnostic: SN6PR11MB3487:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SLrFzhUsAyecZRpzo42NKgHcquHSFaRYw6IGbQWnbZsB6S03x6lVw17BQv5ZT2iWJxaqVchxu53fyZJhHrv2ZFF6YzNvYiWlgs7bUKNfdlLUmCfsN2eH/9a5PBk5hTGrZTLKhiO1A99YSTzXhbqg6v5MQgUhWqwcd89Ju8nKrDGW7x14jhZagu6SvO0qZIus3jy8rGhIMfAWyzjioXetQkqcFwp0FtvQAYPutN3jm1Wwkpopjt7nhoYlyejr/kKfRorvNNhVl51MsQcRVeseWqGYr9Lrss6eoGRS8D67ypkzXij3ImqWirfr1xh6J82WKu7Y/ElS8aVHIMaHly3o0nCMicZsXUFm2xyNaTgJo7SZNeMsRvH+9+7gEXkBJsbjoT7CAYVeMbAr41BPsVssV9HBvebhiAZaTDB3hp3SwEzUcTMXutrUNXageigLDfeUAvQd1rMKCaJMPz4+N+4/16X9ImL29tCQ9FqcnGiI5EuuGKNeCRSNYH6nR5aKDnfRVEpton0DiJfBBDS7KjGXPgKZOq1Y/8IDynbDalwHoe7HanmSh1lz26yAHxVuZL+gSBiX5DAkOJJDlkSlgk0+Erf58vgwhx3T2vSgA9v/xh6Z+z67CDeeutHxq3t1QFd1alH9E2OZNfErGGFUuiXEywZzhtA3B+umGWmqOYnO4nEq/vJMEz6CWXk1CuFKF01hFciX+IzgkJHEHn4hzZu94tkSFEHGch2wnV3EV/0ZCUPs7687rjc8knPFfxY26hrCK6CXI/DsEwi8Hj3JdC1FuXPE8HcX2D6VLD1dP+4ZFmA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(136003)(396003)(346002)(366004)(4326008)(2906002)(66556008)(8676002)(31686004)(66946007)(66476007)(53546011)(4744005)(6506007)(26005)(316002)(54906003)(6512007)(6486002)(41300700001)(478600001)(6666004)(8936002)(86362001)(2616005)(186003)(36756003)(44832011)(31696002)(5660300002)(38100700002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1FUeTFnaFl1MlFPelBaYzJWOW1Kd2tKaTBLZExGSUovUDJTR25ZcFlPUCtV?=
 =?utf-8?B?dm92V0w1T0M5OVNpZjNNblNpM0F0QlJWbUJxVVY1SEZvWlBXRWdMdkZSYkMx?=
 =?utf-8?B?QmJPcENqSE9yMzBtZll0L09NMnhia2RkZGJTRDdhRHBqTVFlMFRsektLMnRa?=
 =?utf-8?B?alNOdUdaTXgvVE9ONHZFTy9DamVhbmpqY3EwWVFiUUpYTEpDNlhtRGZvUm82?=
 =?utf-8?B?ZncyeWkwbkRmRWx0UUQzNkx3bHdrTUhoUXozZkErTmlsaHFsRlZMR1lYUTVF?=
 =?utf-8?B?akFPeWI1ZXdzNko1cUFyeU1JalZyUEN4Wm1ENm9hMzhCcTZreWJRWDRmeHFX?=
 =?utf-8?B?d2x0dURzbG1UM2xZM2t3MGNFWTZuV2g2TDRHSjlGSkZtVFIrNnh2ejdkbmFQ?=
 =?utf-8?B?cjhTb0s5WlE0dm5EUEF0Q0JSK0pMQ05JemdENXhoUklQeC9yWWltVTZlZG9O?=
 =?utf-8?B?RVNGRkV1TXdxZEpxdmtMaUVDbnB0MDUxcGltVkxKZ0QwOXcvbTQyV3pGZzRZ?=
 =?utf-8?B?eWk0V000NGIxcDdJSmlMb25VV3NyTHdBUTRIVkZaTCtXNW5xYndpaVl1M1dU?=
 =?utf-8?B?QklrYkswTTliTnUyUnRIcHllMFVMdEg1S0p2WXNXYm5ITFhRUkxQZG5WZEFy?=
 =?utf-8?B?dkNvZzdPY2lLbEplOWpSekJ3a2tyNVh6WXZFTytydU1WYW9MVG43eXg4aEF2?=
 =?utf-8?B?dVRtczk1RDRMZ0FiZEU5V2VDZkN2RWh6R21pWFQrUk02VFg3STZtOTNUWWZF?=
 =?utf-8?B?OTA2K0QvWDdUb1BJODZBY2xYajQyendBYngzMk1QUG94dHgxWUZJbDlyeUlT?=
 =?utf-8?B?ekVsVEI4UDFqQm9YR0svVE1EbkwrUkxIY1pnODFEdG9LUWpOSmtMcTBkajc2?=
 =?utf-8?B?TFF4d2NoZXRmWnJSWU1JZUlTUVo0WnBDMmdTRnM2dW1yYVRzUEVLamJHNkVR?=
 =?utf-8?B?SFZlWmp4YWZQc3RwWUlNaGNYVUFZbExVaTVJRUZXazFETUlkRHBwYVJGU3NG?=
 =?utf-8?B?dlRpZlh2d0Ntamd0S3JSUXFFem9wdlpKZHcxUGcrV3pkWVhOQTVST1MveVQ0?=
 =?utf-8?B?MjdGS1pPZFR3RUpEOGVOOE42TURvM2tNaGdUb3pEU1dEV0Y0OXFXVGtMeTVp?=
 =?utf-8?B?VEtxcDZCSHk4ZmdtditWSzUzbWl4QSs3VTFrUnZKKzlFRElpeE4vS2lMdlZw?=
 =?utf-8?B?cVpFVkZkTTYrTmo3TjBMM2FMWGZicXkvakpMQ1FybVlvYkZhdE4vVVZXK2VI?=
 =?utf-8?B?NmVxMDY5QjJ0YmRqS2FKUmZieW1uMDBEeGZhWXdPcW5Nek9aNlVla1dBd0JW?=
 =?utf-8?B?RWROYmhqNzdieEgyUXlFcU1SSVdIeFdtRW9DdkgzU2pJTXl5NEhVUFJEb0FQ?=
 =?utf-8?B?S055STlvdVpIeUdaUVNlK0YrbEZZSW1KdDl2UEV4VjJNNkpwZGlZQ1dtazhZ?=
 =?utf-8?B?SXdMdE42TXMyMnVkN3RJTHdTTmJPekVGSE1OckV6S0VwdHJUQXpsdWdGS21O?=
 =?utf-8?B?ZGJ3U1laV3dHT3FGUlpvY3pxRlY4NnYySGVwSCtiUUxyM3BRTW8yVkhlQUlP?=
 =?utf-8?B?d0ozQm5sQkdLR3Ava2JLUmUwRTRKaFU1UldTR2xXaCtRS0FhSGhxWkdSbFh6?=
 =?utf-8?B?RHYwZnJqWFRlOU9LZkFaSjhSSXFwMGJ6a21ZYzRwSGNtdjZTMnE0OVNXdG13?=
 =?utf-8?B?ZFc4R1hJajRvSW5FaWNhU3ZNRzk5ZTE4Y205SkFzNTVkdlJKZkhmQVVHT2ZJ?=
 =?utf-8?B?N0g2Qm9ndS9zVTl3TTlkclAyUTV6bGlqMGUwZ3FQanFzSktqSnNLU2E3czFy?=
 =?utf-8?B?bGp6WjhoTlk5eUgyUTZsN0J0eXA2R1dhL3NTQ3U4NGRMMGVyQTEzRktQZ2th?=
 =?utf-8?B?djgzcHVvellaL3ZqRWlFTlEvb2kydk5WNitYOU1rWFoycm5CMDJmTTV3eGNh?=
 =?utf-8?B?d1MrRHVPNXpkVGJTZmkyb083YkM3bjJxYWpMZldDQVFhM2RuaWhIVVlpOWVZ?=
 =?utf-8?B?THgwa00wN3grRlU5eEhySVhpSW5jU2FFMUljUVMvY1IyRnFhenFqd1RvWlRi?=
 =?utf-8?B?c2hsU2F3R1krd3dneGhjUFhkWVZsVDBFQjloT3Awem9CV1dhZUd0eWpFQjcv?=
 =?utf-8?B?czFrYTByYks0S3JYL1B4MW5mUjMrWEV0aGpHK3BkQmlpUzJVMFFIQU1aK3hQ?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5938e17b-92f1-4e6c-41da-08da8adb026d
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 22:57:27.0625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: znA3njhY0ecmgw5imU9NLAv1Rpw2Siem1GyI/v0Rn19hUD6S0pg6ixrK5zwPxzQxbxcJZG4BXAkq9LriAdwPO4sOnxZWhb+Kw6szHUKD/KI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3487
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 8/29/2022 8:12 PM, Jarkko Sakkinen wrote:
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  tools/testing/selftests/sgx/alloc-error.bt | 7 +++++++
>  1 file changed, 7 insertions(+)
>  create mode 100644 tools/testing/selftests/sgx/alloc-error.bt
> 
> diff --git a/tools/testing/selftests/sgx/alloc-error.bt b/tools/testing/selftests/sgx/alloc-error.bt
> new file mode 100644
> index 000000000000..9268d50dea29
> --- /dev/null
> +++ b/tools/testing/selftests/sgx/alloc-error.bt
> @@ -0,0 +1,7 @@
> +kr:sgx_alloc_epc_page /(uint64)retval >= (uint64)(-4095)/ {
> +		 printf("sgx_alloc_epc_page: retval=%d\n", (int64)retval);
> +}
> +
> +kr:sgx_encl_page_alloc /(uint64)retval >= (uint64)(-4095)/ {
> +		 printf("sgx_encl_page_alloc: retval=%d\n", (int64)retval);
> +}


Could there be a snippet of comments in this new file to guide users
on how to use this script?

Reinette
