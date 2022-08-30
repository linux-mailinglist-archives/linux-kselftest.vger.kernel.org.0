Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818DC5A7132
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 00:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiH3W4i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 18:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiH3W4g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 18:56:36 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741B1883CD;
        Tue, 30 Aug 2022 15:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661900195; x=1693436195;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yeiL+OOcCyV5v9R4GlLxgZnKBSkD7WYE7MVf+r6Hpvg=;
  b=HPN0FiIAyaIeDfil/ic+0ynEGHy5kHPWCZUdhnwyX0WPjn/Q4yV9PV6g
   5Pct87vWllN9D3M2Pa1I5VbIWE2jjJv8ngroTH+2WODsoNXrUM6rjrF1S
   yVm4mhJC1qPUq94LZgAlIjL15vSJWFqAklQJjXeqLPcixnd8iIK1Qz+Tx
   QXx4UsjV7UBlyJfHBLnta3E9D8NMLAifFKAjI2BpH14HBvamwc92ug3hi
   h0yHDIvkhGYA6Wl1AjNx/9KmSJNHzyfDv4sW9sEyOrRWJTjJr5MM3mdYc
   Q7/OqWdP3OSdvKmdfpJyf6V7kiASHs7JoZ310UmgknkUbu/0PGFaGg6WR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="357041943"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="357041943"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 15:56:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="701174245"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Aug 2022 15:56:34 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 15:56:34 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 15:56:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 30 Aug 2022 15:56:33 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 30 Aug 2022 15:56:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlwlXSdHH/Oyfiune3Gs7XczgVnvRa2Cug/ptWDlliOTfxYym0gW3lZ4/V5i36YuUl2m+DRWWTNob3viwx1JWmesIWJ43d3BJ0sW6MbHZ7xlglYqO/EniBuE2QvDdrT3t5LT1vCFqgFkI1MEhhqv7oKMzg2bomBlVv6eylDbb2G2IbDJGcnYYp3RXskXE44XefE0zPvsbn+6lI4RJeU36Opl4Qw5O4DonoCOLGMy2LUufOhuvAhMD1oGZDXf3vFF6P3GsqfJDst2JGL4yCKSvEUcGkFYOUHyX2nG+y+CKclbLlgHNdhsT0kEVKwQQws8Ffk94x1IVet+GvzK4sjz/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEQsCAvo4sZxtmPfGhAHkHuGHAsMhITTOsvq0wuki4E=;
 b=I28GWm6TYOx+j4W+j7UlnZIyxbJ2SyxOnDGrwq41JUssXeaZ8TKwx7/kkO1JavRcO5QvxzzVULxSeROux6oiT5vDh0pSPg1yvVK4GXEETVvFwRf4C+5CBMsRVNU3naL1ikPt6rLT6MSOUVl2qE8rxEeQNKBWm8WEOML/gUojqs5GBIRAtT4okNMzptdUZtvrxzU82FbCB3dWLaSiHUqpLpPFgCdEUPp1AkLHiwbPDxSANO9Qkc+TGa6iwWNvgi+QRD1nUGrdgkHr1HJMui/0LEg5kfzWTc7FlZGn2nxI+OscfTfLP8ARz/ZBQTfSa/gp5H4f8W7C0L1IfqQw3srklA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SN6PR11MB3487.namprd11.prod.outlook.com (2603:10b6:805:c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Tue, 30 Aug
 2022 22:56:31 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%11]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 22:56:31 +0000
Message-ID: <5d19be91-3aef-5cbe-6063-3ff3dbd5572b@intel.com>
Date:   Tue, 30 Aug 2022 15:56:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.0
Subject: Re: [PATCH 5/6] selftests/sgx: retry the ioctls returned with EAGAIN
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, <linux-sgx@vger.kernel.org>
CC:     Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Shuah Khan" <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220830031206.13449-1-jarkko@kernel.org>
 <20220830031206.13449-6-jarkko@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220830031206.13449-6-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0066.namprd05.prod.outlook.com
 (2603:10b6:a03:74::43) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3a132de-25da-4944-b17a-08da8adae130
X-MS-TrafficTypeDiagnostic: SN6PR11MB3487:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0mBQJnfBilFnErkPjgSMHqCPAAlNp/8xcKM8hNdEHn7VpMLC9pwoY2Iz46tQw/dT2I6VR1oD0aMyLjPJjzqO8DbC3g6TcwQPutJShR8N4SGEZCqsQT9RwQ7g0XjfzRR1zCQYhr9CetDt0O2f/pVR/fdfLLsU7kys4wb2cIhyNKKJa4dXh6j95IuVCps1euzfjDhmcBAGyGRA3R9BBzel5tWqNU6FTSB0sPBTEoH1j374kTA9aJxJMcxgs/pmuJgJkQ7poTs5ojcN+XJxBkdt8ithAQvUc9MyR5nxc350dUemd9IMqPp5n2rNZPhCmI6moDo7cZAxIjNcAPcik23cpCaWRbWEQorbCWS6286xUj5TYJxnGu2XE/v+jvTQcuLnwCD5/SrBXLBvokPega1rFp5eATehEXV0jqxU8hDYVXtfEmvdnujngirPzD5lAVsTLZe2hynYipyVp7CgXRf2x+xXf9PCcr/pDJMNuLuSMMJplHAhCJlaWCQloeWX9A187GYNONyNzDBfu9bI4f4XODSZgRE7MNvQSMYhHmVRaszkDd026qmVyRgb6wjXrZg2IKhIGDc4P+NkLSb9g2X0cNTMepO1sugRLJjUapWmkNuzM3VvAmBqxjEWE3h7zsVxYRuifkMGcWkLeu++wIJBVO3qvKUSAiV8DQOEdB2E8+kCfN9wc2DLj8kPyhlICqX6dmP5ySPcIKDPjT2c2XVnNDUO1uFqs6vSCNCHjl4ZdR1muinIW/RJOo/j7ukfzNGXWjqGuwba9U0byyHWU5VUDMMYUUMwqvEaV6nCGQ5lZPU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(136003)(396003)(346002)(366004)(4326008)(2906002)(66556008)(8676002)(31686004)(66946007)(66476007)(53546011)(6506007)(26005)(316002)(54906003)(6512007)(6486002)(41300700001)(478600001)(8936002)(86362001)(2616005)(186003)(36756003)(83380400001)(44832011)(31696002)(5660300002)(38100700002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TG10WDlXTkdUTGhxN2N6aWM5OUpESm5BN1RsakdoeG5vNDJJSTFZcGpZaHBx?=
 =?utf-8?B?Um5GMno0cE9KYjY0UVpKS0gzY0NWRmpRU0tyREQ2M0pEeVk1cWtHd2Vjcy9h?=
 =?utf-8?B?b0RoV0V3NDltYjBtczJ3UUZsQUg3N1NsOW5FTFdyYnYvOWVoTkdzQ0E2YUQ0?=
 =?utf-8?B?NHZ0QklQMmJQRzc5Y3F1ZExiZG00VHpxa1M1SnVOc1RTN29Qd3d1cU12aWVC?=
 =?utf-8?B?ZTZVMUFwZURVUHVpZ29KMWFIZ2Vld3R0MmJ5ck8rbHNpRHNrMDdIQnoySFFI?=
 =?utf-8?B?UG5EN2FRbm5FYkV3WEV1OENUNGFJT2hRaUFneUk5Q1Y3Z2FHUTFTMjlNbFRU?=
 =?utf-8?B?ZXcxalJYZlpyWlN3S3hxRTAybkZ5S0FNNFJTYUhEVUNERnBRbStPN2dkdWx1?=
 =?utf-8?B?d3VSUXN5bmQ1QjVjMCs3NDNQYndaNjQvTUNOT0NlRHpxKysxNUlrdzBOaTlS?=
 =?utf-8?B?WlFvbkNJdG00ak9iQjRFZ2xmVW15Y0dqVWwzeHhpWk9IU2E1dUFJZ09FSU9j?=
 =?utf-8?B?OTlmbDBWMy9qV25rRE5oSjNDczZrY3A3UG1NeExDMGFUNWI0TW5LaitVTkNU?=
 =?utf-8?B?SGU1UDJ3ZmVFMzZ6czNNclV2YW1vRVdQZ3VzbS9uWlFIR082QmdZeVAxZXJX?=
 =?utf-8?B?aUdzdGxsZXhOb0ZHSnpHak85S0l4VS9NVFRDOWtiVkw1Q3Rjd3JUVHhTYTl3?=
 =?utf-8?B?ZTI2T2orTCs5SXZHNTd3Y2UwOVZpbmIzd2VQNFZyQndtWDBmSFpLZUltSFNn?=
 =?utf-8?B?ZDNRZm00b3RwaEhCREx4d1NiWUkxeDVuSyttOVMrSitKZm9OWmJEUjM5ak0x?=
 =?utf-8?B?VXRRQTdNVDdoWE5oZnJLUmY3STZnUWpXN2xLd2Mrb2N1OHg3SU5WVzVYZUhr?=
 =?utf-8?B?SXI0ZVRJODRzWjE5VEtSbnlsMVRTbG1abzRueE8wamlCYlh2R2QvZW1PNzYv?=
 =?utf-8?B?blZNb2dYclF0SE9od3JZQ1FnRVRuUUZpY1ZycU9oQW81QXNsakFGd0ZqeXI2?=
 =?utf-8?B?R2xmSldWbzVoeUdpMDJOZWhGWnR3K1h1NEllREwxd2NKaGo0NWFVa0NMNFFH?=
 =?utf-8?B?ZE1PNE9LN0VZekZrNFZ5UHQ5bUVJMGZ4emNtM29FbEFWbkFUanQ2cDZkT0dK?=
 =?utf-8?B?VXlsaU52NnBndUlmdVAvSytpbGpmK3Y2aFZ0MVNTNEdCQXVVZ2U5TkpqT1NY?=
 =?utf-8?B?Q0VWZVN4ZUl1dnZvMGROdmlDcit5YlZqQVpuZ0FkME9HRWEvaUFVT1UzRXRD?=
 =?utf-8?B?YkQzK0V6anUvTkZCbWpQT2NwMEdBL2liaEZVRXlNTm00TGZGWVJpZVpVNnkr?=
 =?utf-8?B?TkNNbEs2YVlIQkFxRzBXbWc3V1BHK2NTaXlML0Yra2hvcEJHczIyNml5L3Ir?=
 =?utf-8?B?b3VWNGNJenRqTk5TdzRETk1kMTNXUWZtSzBrV2o4UDVnNDlRMDdJd29IbVVi?=
 =?utf-8?B?OElhRHNuU1lvOWZ2aG9wNTd4Nm53UU9SNjlMN21jVVU0QmVuK3JJRWFZQ1RO?=
 =?utf-8?B?cVZCTktGd2x6dzM5cUd2WmtvenlDSU9IT1dRZFUzSXFPays2bk84OFVpdXRM?=
 =?utf-8?B?U1ZmQ0t3VUJVKzBkQ1hqeUZaVmFYQVUrTW5TeEZXNlhORlhwTzd1ZFQwRmVI?=
 =?utf-8?B?emRrNllYNmp0azVUWXNPMm81aHcvZGRNVFdWU00wZzJxRjF1SkhlZDd3YVd2?=
 =?utf-8?B?OGVTUmwzRURQZFVSRW14bkRoVGM2UzdDM0JBaDV0a0dIN0pMOTdOZE4vWEFY?=
 =?utf-8?B?a3hIVXZFL0hPWTZ1bUpmYzlEdVVGSWFwTnNURWloZnd0cUNJNnJPYVRTR2sw?=
 =?utf-8?B?REp2YWt4N0Rnems2NjZOR2h0QXlFcDJqMFhMVlFuOG9yWVhDS0VhbGFXSk1I?=
 =?utf-8?B?VHBZbmFvdVNxZDJwMHVCNnNQSzhIeE5CRytmZ0RQS0pKYVdnVjdJRm4vd1ZM?=
 =?utf-8?B?bndoM3NxbU53d0hRZUZLSTdjbXZIeUM4eHFZTURJV1hLQ0xzcm5GMjlPS2NU?=
 =?utf-8?B?TWJYa1VBcTZxNUMwMHN1T1R6MmZ2WEd4VzdGcVRSL21sWW9iQWc3VUlpVW1D?=
 =?utf-8?B?MWFlZjMwT1JDNEZ3ZFVVanJDVXJDUEl2WUdxQm9WcEpwTlpUZDZPOW11ZzhB?=
 =?utf-8?B?UHFzaXlFY3VJYTE1c3FKVkREalRqYnZBY1JZRjdwaUdHV2NwQVJlVUZNdDR1?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a132de-25da-4944-b17a-08da8adae130
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 22:56:31.3008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UTxPRluEwvs7dbdk99rEo9WFvCF5n79jFa4OM2LbLM0QTPWOfJqxXMiCkmnxQTxAzvt47hx42u/2Rnz4+ADLDlzS6i+PqIVH6ZOBceFnAzk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3487
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Haitao and Jarkko,


selftests/sgx: Retry the ioctl()s returned with EAGAIN


On 8/29/2022 8:12 PM, Jarkko Sakkinen wrote:
> From: Haitao Huang <haitao.huang@linux.intel.com>
> 
> For EMODT and EREMOVE ioctls with a large range, kernel

ioctl()s?

> may not finish in one shot and return EAGAIN error code
> and count of bytes of EPC pages on that operations are
> finished successfully.
> 
> Change the unclobbered_vdso_oversubscribed_remove test
> to rerun the ioctls in a loop, updating offset and length

ioctl()s?

> using the byte count returned in each iteration.
> 

This is a valuable addition, thank you very much.

> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  tools/testing/selftests/sgx/main.c | 39 +++++++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
> index 867e98502120..3268d8b01b0b 100644
> --- a/tools/testing/selftests/sgx/main.c
> +++ b/tools/testing/selftests/sgx/main.c
> @@ -399,7 +399,7 @@ TEST_F_TIMEOUT(enclave, unclobbered_vdso_oversubscribed_remove, 900)
>  	unsigned long total_mem;
>  	int ret, errno_save;
>  	unsigned long addr;
> -	unsigned long i;
> +	unsigned long i, count;

Reverse fir tree?

>  
>  	/*
>  	 * Create enclave with additional heap that is as big as all
> @@ -461,16 +461,27 @@ TEST_F_TIMEOUT(enclave, unclobbered_vdso_oversubscribed_remove, 900)
>  	modt_ioc.offset = heap->offset;
>  	modt_ioc.length = heap->size;
>  	modt_ioc.page_type = SGX_PAGE_TYPE_TRIM;
> -
> +	count = 0;
>  	TH_LOG("Changing type of %zd bytes to trimmed may take a while ...",
>  	       heap->size);
> -	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPES, &modt_ioc);
> -	errno_save = ret == -1 ? errno : 0;
> +	do {
> +		ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPES, &modt_ioc);
> +		errno_save = ret == -1 ? errno : 0;
> +		if (errno_save == EAGAIN) {
> +			count += modt_ioc.count;
> +			modt_ioc.offset += modt_ioc.count;
> +			modt_ioc.length -= modt_ioc.count;
> +			modt_ioc.result = 0;

As part of the test I think it would be helpful to know if there was a result code
in here. What do you think of failing the test if it is not zero?

> +			modt_ioc.count = 0;
> +		} else
> +			break;

Watch out for unbalanced braces (also later in patch). This causes
checkpatch.pl noise.

> +	} while (modt_ioc.length != 0);
>  
>  	EXPECT_EQ(ret, 0);
>  	EXPECT_EQ(errno_save, 0);
>  	EXPECT_EQ(modt_ioc.result, 0);
> -	EXPECT_EQ(modt_ioc.count, heap->size);
> +	count += modt_ioc.count;
> +	EXPECT_EQ(count, heap->size);
>  
>  	/* EACCEPT all removed pages. */
>  	addr = self->encl.encl_base + heap->offset;
> @@ -498,15 +509,25 @@ TEST_F_TIMEOUT(enclave, unclobbered_vdso_oversubscribed_remove, 900)
>  
>  	remove_ioc.offset = heap->offset;
>  	remove_ioc.length = heap->size;
> -
> +	count = 0;
>  	TH_LOG("Removing %zd bytes from enclave may take a while ...",
>  	       heap->size);
> -	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_REMOVE_PAGES, &remove_ioc);
> -	errno_save = ret == -1 ? errno : 0;
> +	do {
> +		ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_REMOVE_PAGES, &remove_ioc);
> +		errno_save = ret == -1 ? errno : 0;
> +		if (errno_save == EAGAIN) {
> +			count += remove_ioc.count;
> +			remove_ioc.offset += remove_ioc.count;
> +			remove_ioc.length -= remove_ioc.count;
> +			remove_ioc.count = 0;
> +		} else
> +			break;
> +	} while (remove_ioc.length != 0);
>  
>  	EXPECT_EQ(ret, 0);
>  	EXPECT_EQ(errno_save, 0);
> -	EXPECT_EQ(remove_ioc.count, heap->size);
> +	count += remove_ioc.count;
> +	EXPECT_EQ(count, heap->size);
>  }
>  
>  TEST_F(enclave, clobbered_vdso)

Reinette
