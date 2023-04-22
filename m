Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C316EB651
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Apr 2023 02:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbjDVAQK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 20:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbjDVAQJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 20:16:09 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDCADD;
        Fri, 21 Apr 2023 17:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682122568; x=1713658568;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6AaIbNyYDucHMWwYU5NF3UIMEu89bQ7nbFmzWgBby8w=;
  b=IgQaj+0SNqWsSQeiLPSteO7nK8+/8f2iolMUn9HJUdRkPYkC2C44E1PZ
   tSmXihMFMQDv2togDVtVDrpwr0GPZbWGpIxq1sfKFpizyNp1Rq3xJ7Pls
   ldMMlza6AhPJDO5rbY79PVvPw3Hi4Nh2b/UZTXSvBxJw0KhtTnYuDAGwQ
   hOm0np43yZ3131inYMAFm54zVyATLdilxqX5mBFhQKL4EpUt9BWlPYuG0
   OMu3jOGifX9vMkpMDU3LFEJj1j+9w5YYyL0dajuLR74TDJ0qYtAGBryQk
   fwXGWwm5w/uhkd8+KamvAJYyXHrmC5uPbD6w5bflI92YljaLSHedyLoRP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="348021313"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="348021313"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 17:16:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="642692039"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="642692039"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 21 Apr 2023 17:16:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 17:16:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 21 Apr 2023 17:16:06 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 21 Apr 2023 17:16:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MP8L/lg4Egy3db/drrrgjJZDhL+V2HjGoUfglP7dgvmXRVSLvkeySDmPhMxaqWkBls2E20UC7m5V5IsK+uicQO3v+BYwasV2kbi8uSjTgL4i8bIkWuPbCMC+rsD6z5MB+AY6xu5LT4c2irrv82Szp3GNr/6Zj9JJtTXUAFlYCkqj1v5eFj0QvFj/MyKbz+hpNXK62PtGLtMmk56FuhzFQtQZ8H5+pai55zmLJocf+qHSnrkVWJ/xEzv3uY6bcDixnjcwLm0KrI+16+YhJ7nrdeAMON2onVGSKVxktM/3nqN2kn2Lt9PyaMlOXoHsg/8RzZmIYIjDf1PkaKEf8LlAeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twgHpxsiRnSpMMka3iP+mzJ1liDROGhaDSCyIGiFp4c=;
 b=Yg6nWKPvpeHkLEc7+ATW/KeQNZGKmClv7yEL1DcMuOeOi9WJ9BAtThJgXR6g/79W3GxVu1XbozZKIUgJ0vlsxWTmZJcypbfW4Zu7ztUeH5NcdlpUJ9ysBA26aseD+BikSGgZvN5eZ5aCIBX5j1fg3ZhXtmBwmMmTQ7VK6fGIZe0RguN7eJDCRTAos4l30P7KguQmvl3Amn65LgWwYk0aHriGd06k9Sk4CF4BGcRwmZtnbZTL2zEt2pYmDOcwsmMH+pmY+D8rmWkHJ/oDFutawfqGeHe0E7fGDBxEdVPjxlnIeMGrYMQbpfD+rm1GoKkBdoDRctlKwMnvQvMkcHP6nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by BN9PR11MB5227.namprd11.prod.outlook.com (2603:10b6:408:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Sat, 22 Apr
 2023 00:16:04 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6%4]) with mapi id 15.20.6319.022; Sat, 22 Apr 2023
 00:16:04 +0000
Message-ID: <8d6f94e6-4d51-5b96-2a74-2417ffcc0b51@intel.com>
Date:   Fri, 21 Apr 2023 17:16:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 10/24] selftests/resctrl: Split run_fill_buf() to
 alloc, work, and dealloc helpers
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Shuah Khan" <shuah@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
 <20230418114506.46788-11-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230418114506.46788-11-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0002.namprd21.prod.outlook.com
 (2603:10b6:a03:114::12) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|BN9PR11MB5227:EE_
X-MS-Office365-Filtering-Correlation-Id: 026fc831-f9af-414a-23e0-08db42c6c284
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VLuUrb2nLv86FlIoRE5oexh6jEW8UwEykD5eQvOtWfa/g8Aw6RA9/E1KWNKJPPkUO6JgBVrxHLDH1tZpE7WNcDnV3rMmi1tmLfLOCy6SUJtvpVKg6aMqgkl+8iWby64VLLMlbmBfRAbyoRhd1aTMpXZm9CCIh2rlnga1k5z/6Fe2rtWsyx/uRHFm5HWO2G/JzHSMNVlVXBSCiUsEW348s3Uz/GCrV2PsJiluBA3JKcFkBs9bVlBiIXhG9JYnsgdtvt9fq313szdUCOWnBJeUfMDfMgQUi9Rgte3CEftJGpvsVy1mbPJTEc7uwvtEiXbyJaVOkuAULSu7VH8oIapp5voFylBNzCnhowEtSM9AnX8B8g6HMaGHXTV7Ckmmm7SR+waHY/2EW4MIg16tjWGmaxebveXq8EbeJD+vxUhpst7wXfCiMHQAnAIkfl9e3VnV/bKrVNE3m0IrvA9cTyqU0nwZ8ibgXEVjq8jp0swqEGb2hQNYXS1/fSbGmYOJl+0QDxGALKEQTHB3lteLpnQwaiBEOpDv3Ue+ES7Yp9b3WQuzmUxRUc9oZ7U4Umj9AVvh67BN/OvsTaS8s5wa0jqs3yylw/CAj4b0ikagTtFs61hRMmG4jJN9jqRt1YVRLwtFd2yEFLW8qObYxJ9oWuuNQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199021)(2906002)(8936002)(66899021)(8676002)(38100700002)(44832011)(5660300002)(36756003)(86362001)(31696002)(6506007)(6486002)(6666004)(6512007)(26005)(110136005)(2616005)(31686004)(83380400001)(478600001)(4326008)(186003)(316002)(53546011)(82960400001)(66556008)(66476007)(66946007)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2RDRHYzRnVXamk2Q25nd3hJOWc0UDl0amMvUEE0NVFCaEgvUGQ2K0J5MTdW?=
 =?utf-8?B?QTJ1UkVaa0VTZnBXK2NMcVFnUE5kS3hGUzlqTUN0THBlR3kvSlduSTFwNDBR?=
 =?utf-8?B?dUFVbkhpNFNzRCtuUjBLdEVZRU1UN2w1a050aGNCYy9rV1FRYnJWaDVzTGtV?=
 =?utf-8?B?T2lWZnpNbGxDekxaR3RGNFY0amJvYVBMc0RoYW9SWjV2WXlWd25WN3lCSmR0?=
 =?utf-8?B?VHVWdEw3d3drZFlzenJid0NWdExxc1dhV3JETDN0Umc2Y1N1UE9aNTZVMlcw?=
 =?utf-8?B?VS82bnZOd3Zodm1SVHVxQmRaRHg2TFhGbXJsQTZlaVQydWdrdk9kYWJJYmkv?=
 =?utf-8?B?MUlyek1tT2w0R2c0UDAwdk4yc0NQcENGM0lvQmlBTmljRkNPNHVPbmR3Ry9a?=
 =?utf-8?B?NGlEc2hWSm1mVHVsc21oUXorbHZiY1AvaDk2SkVPc1hGYmNDYy9rdll6NGN1?=
 =?utf-8?B?c1ZKVVdTbTZCbTBWM2RybGg4UW5oNFJZTE5hK2dkOXlkK3pteUphcEF5V0V3?=
 =?utf-8?B?RlRwZExZQUc3UTBYbHBlakZ2TlJSTkJPdXBSVXVpUDNVL2MxZEt2R3lXNWFl?=
 =?utf-8?B?TFV0bVZJY0RLSmIrSzBLQjR5aE5ZOVhYeFUxc1crQ29tUzZrK3Y3WUREVXdN?=
 =?utf-8?B?K05ESm5DZmhxN29Uc0RicWo1S2tKK0JCL3FoQ013SGZFZXZmREhGalBYalpk?=
 =?utf-8?B?S0NRR1ZXU3l0b2lsRTVaUzR2cC9abkt2OFQvUmNjQTJzNnVCekliTWU0WUkr?=
 =?utf-8?B?cnFiaGwycWs4eVlIcHJtaVNPR2hvSHZwOUhIR1BBSEFaSVFvdVdkSUFaMTRZ?=
 =?utf-8?B?MGNUYXhkNU4vTkt3Um5wOTl6b2RHSkZPQWZOaVFMN09HWmQxUXNBdDJWZVBE?=
 =?utf-8?B?UUYydkQ0NnAwMDlXUFNDWGJBVlJkTFBEM2xxUXI0bEJGeFgwQlJ4RkxoSTE1?=
 =?utf-8?B?YkJ2bnVTR1IrVGk1dG90cE4xb1kxdWRqQStFamJoZnJ2S2VsVlRkM1lFN0dY?=
 =?utf-8?B?Wlpod0RXbWRnL2Z0Rkh0TWI1VGE0ZVh1YzhoakJ1dithRTREdHZQc3pKckZl?=
 =?utf-8?B?c2hYQTFZVTBsMXZQcTc1T08rWHFrZG9BK0xEci85MGpSejBYYjRLZjJ6cElF?=
 =?utf-8?B?Mnd3dDdXSjNQS2ZlWS8ya1FPQU8xU0hnN1V4ZVhCZGV3R0RUd0xocVRZb2dw?=
 =?utf-8?B?RlRPbXhOcmg0SGg5d3ZqTVFMdlc0YTlScmQ0VHhvdnplK3RsL2VqU0x5anVG?=
 =?utf-8?B?dzdrb09yaEVJR1g3UFlKTGRHdmpmY1Z5eTl5aTR1NTlISyt3clNqZGdncXhZ?=
 =?utf-8?B?d0VKYzgwZHd1STJoR2V0d2dtd09NR1huTklPRmowM0FIaUpnbzJDZmVFTWp6?=
 =?utf-8?B?YUd2S3FXR3BkRHVUM0NkNWFZTEc5cEFBTXhNeitvVGNOenFhV3dPeHFnTFBr?=
 =?utf-8?B?ekt5VTZDbXlMUUpnNmRMTlNNWHhzYVV5UWJrclFldmJNMzNyNk9TWk5tbS9F?=
 =?utf-8?B?Vi9rN2UvUHRHVHBFc2Z6ZG9sSVQ0WG1VOUc4b1hrYUM3UEQyNXBycVQzb0xw?=
 =?utf-8?B?UUZGTTI1Z0Fwd3pOazNvSFc1Y250MVl5UmdsR3hYSno0d1lyK1d0aC9YeEhr?=
 =?utf-8?B?VDlHVWNaOGh2ZzJZUGtxZmtJbmxOcWlCWWk1c00rbCtsZkFWdjlrdGw5YUlu?=
 =?utf-8?B?K0QwRy9YaVgrVmxvZ1Y1UXdCRGVPLzBNTy9kSk9KUndmcDM1NXJwaG5OMXNF?=
 =?utf-8?B?NmxMdjViUE80Q2tETnRELzAyRSs5eUFrVTYzRkRFMTNGN09CQnkwRVJHNWFE?=
 =?utf-8?B?WG9ZUTJlZTBOQSthV0JnSWVrZ1g1WTVlRFVCL2UyR051cWxuaUNPaXFzUHZ4?=
 =?utf-8?B?MWNqLzVnY214MHphVThDcStkWkd1T2pVazlYNjZQaHRsR2wxTGFHUGhYNW9B?=
 =?utf-8?B?U2hRQ1VDRlNYVGVtMmN6b1lNYVZzeitSWlQ3M3U5N2p3K3dqR2tnMU94TEJS?=
 =?utf-8?B?clduOUliQTRwNUlaMWU2YWlVb21qVHRwaHptVmNpNjlWalpveVdzWHpIZzNU?=
 =?utf-8?B?UC9FQUZMak5EeG8xQWVVb1VLWjdZSkhlWkN0Mmtmd2RDcVpONUZISlNxRmha?=
 =?utf-8?B?OFRHWitzOCtNT05Hd0ZiMXlyR1ZrbWh6Z0pOMUhxVXFXQ1ZzR1Q2am52QjND?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 026fc831-f9af-414a-23e0-08db42c6c284
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 00:16:04.0290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7blZTuzYuS6/hFBqHtXx0bij9AophP8+gbdRaRFGcmxZMYZZUUzXcsBaxBiTtSHd13CTsvJtCV1dRY7G9NoojTlWIj8VeLETCFRIrdJcaC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5227
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 4/18/2023 4:44 AM, Ilpo Järvinen wrote:
> MBM, MBA and CMT test cases use run_fill_buf() to loop indefinitely
> loop around the buffer. CAT test case is different and doesn't want to

"loop indefinitely loop" -> "loop indefinitely" ?

> loop around the buffer continuously.
> 
> Split run_fill_buf() into helpers so that both the use cases are easier
> to control by creating separate functions for buffer allocation,
> looping around the buffer and the deallocation. Make those functions
> available for tests.
> 
> Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  tools/testing/selftests/resctrl/fill_buf.c | 46 ++++++++++++++++------
>  tools/testing/selftests/resctrl/resctrl.h  |  3 ++
>  2 files changed, 37 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
> index 5cdb421a2f6c..6f0438aa71a6 100644
> --- a/tools/testing/selftests/resctrl/fill_buf.c
> +++ b/tools/testing/selftests/resctrl/fill_buf.c
> @@ -24,6 +24,11 @@
>  
>  static unsigned char *startptr;
>  
> +void free_buffer(void)
> +{
> +	free(startptr);
> +}
> +

From what I understand startptr is a global variable because there used
to be a signal handler that attempted to free the buffer as part of
its cleanup. This was not necessary and this behavior no longer exists,
yet the global buffer pointer remains.
See commit 73c55fa5ab55 ("selftests/resctrl: Commonize the signal handler
register/unregister for all tests")

I do not see why a global buffer pointer with all these indirections
are needed. Why not just use a local pointer and pass it to functions
as needed? In the above case, just call free(pointer) directly from the
test.

>  static void sb(void)
>  {
>  #if defined(__i386) || defined(__x86_64)
> @@ -138,36 +143,53 @@ static int fill_cache_write(unsigned char *start_ptr, unsigned char *end_ptr,
>  	return 0;
>  }
>  
> -static int
> -fill_cache(unsigned long long buf_size, int memflush, int op, char *resctrl_val)
> +int alloc_buffer(unsigned long long buf_size, int memflush)
>  {

This can be an allocation function that returns a pointer to
allocated buffer, NULL if error.

> -	unsigned char *start_ptr, *end_ptr;
> -	int ret;
> +	unsigned char *start_ptr;
>  
>  	start_ptr = malloc_and_init_memory(buf_size);
>  	if (!start_ptr)
>  		return -1;
>  
>  	startptr = start_ptr;
> -	end_ptr = start_ptr + buf_size;
>  
>  	/* Flush the memory before using to avoid "cache hot pages" effect */
>  	if (memflush)
>  		mem_flush(start_ptr, buf_size);
>  
> +	return 0;
> +}
> +
> +int use_buffer(unsigned long long buf_size, int op, char *resctrl_val)
> +{
> +	unsigned char *end_ptr;
> +	int ret;
> +
> +	end_ptr = startptr + buf_size;
>  	if (op == 0)
> -		ret = fill_cache_read(start_ptr, end_ptr, resctrl_val);
> +		ret = fill_cache_read(startptr, end_ptr, resctrl_val);
>  	else
> -		ret = fill_cache_write(start_ptr, end_ptr, resctrl_val);
> +		ret = fill_cache_write(startptr, end_ptr, resctrl_val);
>  
> -	if (ret) {
> +	if (ret)
>  		printf("\n Error in fill cache read/write...\n");
> -		return -1;
> -	}
>  
> -	free(startptr);
> +	return ret;
> +}
>  

This seems like an unnecessary level of abstraction to me. Could
callers not just call fill_cache_read()/fill_cache_write() directly?
I think doing so will make tests easier to understand. Looking ahead
at how cat_val() turns out in the final patch I do think a call
to fill_cache_read() is easier to follow than this abstraction.


> -	return 0;
> +static int
> +fill_cache(unsigned long long buf_size, int memflush, int op, char *resctrl_val)
> +{
> +	int ret;
> +
> +	ret = alloc_buffer(buf_size, memflush);
> +	if (ret)
> +		return ret;
> +
> +	ret = use_buffer(buf_size, op, resctrl_val);
> +	free_buffer();
> +
> +	return ret;
>  }
>  
>  int run_fill_buf(unsigned long span, int memflush, int op, char *resctrl_val)
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 574adac8932d..75bfa2b2746d 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -95,6 +95,9 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
>  			    char *resctrl_val);
>  int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
>  		    int group_fd, unsigned long flags);
> +void free_buffer(void);
> +int alloc_buffer(unsigned long long buf_size, int memflush);
> +int use_buffer(unsigned long long buf_size, int op, char *resctrl_val);
>  int run_fill_buf(unsigned long span, int memflush, int op, char *resctrl_val);
>  int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param);
>  int mbm_bw_change(unsigned long span, int cpu_no, char *bw_report, char **benchmark_cmd);

Reinette
