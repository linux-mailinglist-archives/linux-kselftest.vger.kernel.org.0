Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3EA6ED2C4
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Apr 2023 18:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjDXQpK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Apr 2023 12:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDXQpJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Apr 2023 12:45:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5284346B3;
        Mon, 24 Apr 2023 09:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682354707; x=1713890707;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vMdYsHi2VCi1y7pYwQor8tKuYdOXgofFriswRr3UwIQ=;
  b=WdaEbeXnwRHYkG8SObpOcObkL5vLbx6dlJSgkWFgBWkauEeMH7DxDO7m
   NE57LR8+ReI7jmp0//2DZTpEc0ZVglZOot4u81figH8RXtHrDmruBxHWJ
   zy/G+3Ja7CIbN7s7i6B2Vs8cHqcU8eyfSeeMX07HyBPrxfHYK/KhDBdhc
   CT4UuoMrvEE0DTY/TMiNFBN1FEhGnwYoMvQCfozFcHCQd/4pL3CZObCda
   ePMY2JjhItorQJY+a3U1ytu3bl6VizwCDLJ7xffBujliwRdm7x7kJuzYa
   pImCPyqnc+cUt9b7xxWydIIAhR++8YqfJgXwoh/SEiNSRglwaH3liV4Hx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="409434065"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="409434065"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 09:45:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="725754854"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="725754854"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 24 Apr 2023 09:45:06 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 09:45:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 09:45:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 24 Apr 2023 09:45:05 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 24 Apr 2023 09:45:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YiK/ZI8DIofulIxhnh/m4Q+tnRuM2SXyrsN0Pn6v669AGG6o/GRF1Uycjv40wiqqq9l9u9AQoj1T2OW70b+7G2mBZ9yy/I30+3lJ2uiB4UOuVP+DzxQ5yhtjUOZBxJhVO2Dgu6HDkidCiJEsd87PmmMR8T6czf/mokb8TuGEtbYlCLPzxzTJcoPyCuRiJKlfZs94+8EcC8HEhxUhsXMxHcGwqk6NvZz9kg9jsRctTKdD5+heuD+Ew7ZngcV+OWI3w2VKvJP3REQW7x9rkgqHlVX42GdyhEr5m1pN/iF6Xbm9+wJWI5Emp49G2WL/x25gHNWnKlR3xp6UkDcLsZG9mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZgdw0JPjqEYpi58PNngqLe2CRQblXnvfsqF3mIL7l4=;
 b=Qm7EDlShlCK4pJ5LMcm5Kj6aFetoqBlh5y7Kl0Cz7ELyJ/fztG3Wr1MW9dK28+twva7qxCkKT87VTk8t7a6O4sQ08OdeqorvgG2ax5ujeI64X/Fd5h3K4Q5xnao72W1+/iCan0+pR8x0/zmyQ5J3ZtElrxyJpheo7T3wWWGOsgA/q2Rzjuk821gmPA2rY5yMsrGos8cuxoTaL5yP3VsUeaN6zlqJyATg05k75piI4sS/vLsDxjcKqp45YuSRVEfZDaZxF2ceHyhTohfHEk/Cu54fJME1P/S9a4F63+VOOkDslDlWxRfm4Jt4ScpsKj+7HHmfhmJMNkwOsnr3f2KYVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MW5PR11MB5785.namprd11.prod.outlook.com (2603:10b6:303:197::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 16:45:04 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6%4]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 16:45:04 +0000
Message-ID: <9a9b0de5-0e19-d68f-606f-c10817b873bc@intel.com>
Date:   Mon, 24 Apr 2023 09:45:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 16/24] selftests/resctrl: Create cache_alloc_size()
 helper
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-kselftest@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
 <20230418114506.46788-17-ilpo.jarvinen@linux.intel.com>
 <287e5f1f-87d5-473a-2bff-271adca8d458@intel.com>
 <5db5680-4123-17b8-e657-39ba20356259@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <5db5680-4123-17b8-e657-39ba20356259@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::6) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MW5PR11MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: 38b67823-6dc9-40a9-2afd-08db44e340ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wRoPjlXTyMgyTVCDEnZc6c1sW7mq3fnUwawLGBQpm1kLZROWtV27wqLm4yYdC2j2TqLySxoliDHYuLL6jy46mdfkt4V7kNBmlt0nCx3wLHbWOT2V4i1UZFNB4Zm+fNpTtI4hI56X5jhzFRcmUssdegHQsVULtfPYqywC/iC0N4NtO4G1nJsxl0qwQhANBCC8A5H6q0/0Z+zoqQrqgrqNAjxE5fAAl6ggNsKOweG2mIaoOdKPVi+Vtc9r1UGtIROhD/sHM8eYSU3bl8+UpVjQGBjgXAEuUymhprP7V3CjkByH3QBGSTg8LDWmnTbV76dv9URE02fKmv9J4+6zvTa9gSg4RBSlv8jxYfbtqJ38LctkZly3UaAm8i5h/92ZB/UucJNy2BjGtGiRkImeEfBdfAjfNmbM7EVaiaqdn1nAx0WbsW2pN9TY8e5hQdhh67oIyMej790BfYdVZZBl2ZvG67ep1WRVgTIGdFqgsuwf9u8Zm2NyA+5j0knt+Gox7HX9/MTmGcSFi8jl37c/nc6l/iBY7O54PacGf3SpmudBbUE3BWCxBbjlbXUhw8Q7KwcE/hPWkN6Iibnet7e6FYmkhXgFoSrdsjebOI4pWtLCL3fIBncGffOqbmu8l008A/V9qfTQfI5vjd1CN7V07q2jBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199021)(54906003)(36756003)(478600001)(82960400001)(316002)(4326008)(6916009)(66476007)(66556008)(66946007)(41300700001)(44832011)(2906002)(8936002)(8676002)(5660300002)(38100700002)(2616005)(31686004)(6512007)(6506007)(26005)(53546011)(86362001)(186003)(31696002)(6666004)(83380400001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVc2NzNIS3JJaGtURTh3Q09NQ2oreXV2N2JpeFJ5d1dBZE5oSGJpcVVDUWN1?=
 =?utf-8?B?a3BaM0JZNVlMV2t2ZGhNU0EwUUE0NEtoWWVIL2RQZFh6bFR0NzE0NVhvYk0w?=
 =?utf-8?B?YVlNR2tNL3pldG8wWkhCS2JNa3NRRmNtcnlvZzZQeXgrNDJkRFNxZ1FmTmtV?=
 =?utf-8?B?dklIelNPMHhLSDBoY0h2TDcxZEgwbGRIVVVSQStSSkg1U296b3EwYWtpS3Fq?=
 =?utf-8?B?bEFWYTJxcGh5MXJaa2hsQ0NVaHJzclNvVUcyZEMrYm5uM0JDeWFHenJmbEdP?=
 =?utf-8?B?TC9MdjJUVjh1OFpxdFBnTDIrMEtqU2lPUkFRQkRhYkM2QWR0a1dQanZkdEM0?=
 =?utf-8?B?ampIcy9iNGlRTmhUL0pEenZDT25KT1RhQXp0UmlwSGFEeURTVmxrTTdLYVlR?=
 =?utf-8?B?dDd2N2NNZVRPQ3YxVXBnOVVUclJGempJTDFEUVloUXhnUEc4eEVOSXMxR1Zj?=
 =?utf-8?B?ZlR0WVBRVGs4WHRQS0RnUTkyVE1mbzVETWV1VXpmU0ZJN3ZFSkZNeXNQd09s?=
 =?utf-8?B?SXBJcGo0VXl5OWlmM3VDTVlyMEtxYncxVzBNRytjSHZZQnJnSUVwNHVaVUhI?=
 =?utf-8?B?bVR6cWpqK1I0RGFzdjY0U1RNOENCaFFlY21Ta0J2SEh1c2I5OHp1R01FbE9n?=
 =?utf-8?B?N3BNbTFhMEE0cUIxSXJSTmlOM3JPZjZCYUFpNXpTQm5oWDhXYWZpYU5SSS9u?=
 =?utf-8?B?V3p5MVJXTFhPUnVmQkp5Uy90d1JkL3k3RWFFVStsRWxMcW4zV2RnTWJYcFR3?=
 =?utf-8?B?Yms1aGc3NHZlWUlOUFZYSmxLcFVWSjNncVdaVUVCeEtRbUozN1BXVFJGendw?=
 =?utf-8?B?SExEQmxFS1pCQklTbUV5OWd3VFBOalI1dlNKcGxSWlJzUjZpczEwRGVVYXE1?=
 =?utf-8?B?UU8ranFwRGxXVzVsamc5Ykkrb2hGeDFOOGNNR0libGxvVmliSTV3Y01DaHUz?=
 =?utf-8?B?cm9CLy9TdUprQVBaeGoyL2U5aGR0UnNVU0pFTk1oZlplMkU4aEp4a2M0ajZH?=
 =?utf-8?B?dnlnayt0by9UaTUrTnBVdGF4RUFsamJZclU1c1ZVY2RyRDR2dkdkejAvSkxX?=
 =?utf-8?B?NStqKzkzUmwvcmwrWDl4aHRFWDNEd0NiamNmdU1aM3lScnpCMjZwZjJwUmxK?=
 =?utf-8?B?RWpjSkRpWUxsS0hrV0Q4RDM0MHQ5cnNzT3llSVJOZ0duMU41ZXB0dG9kRGhi?=
 =?utf-8?B?T1d6R0E0TlEyUS93SEx4MWU4eWlxdWxxUldwYzBuY0VUS0c2TFRpREpsWmtR?=
 =?utf-8?B?cEhOenlqS0dZMWsxVW1qMXZjTGw4bkQwdEl2cmpRaTJndVdqaEZ0R3UzUXFB?=
 =?utf-8?B?Vmk2YTY5Qyszd3lvb0hvNTcwcDdsMEpCOGI1WVJtdGtFWkplZUt6LzRrU1Zn?=
 =?utf-8?B?ZDNucmtWRHJhN25NNll2MEt2bHRrUC9aWlpUcUd4MzFpWUc3VVhVak5NWlhs?=
 =?utf-8?B?V3pNTHZzRm53YU1kZkZYU2M3Y3JZdVAzbzhhaHpOS0tad1E4Qzgzb1g1ejMr?=
 =?utf-8?B?TSs0ZWo2YWFPaEs5RStsVkdydFl3Q1lWdXI1ak5rS2wvWWhGYkxyWWRBTy9s?=
 =?utf-8?B?dUpaTzZ1QXAxUWhHcW5DRE5Qc1AwMXpTME0zanMxRlhRVXFNODljV2NtNFVX?=
 =?utf-8?B?TGVYa29lQ1NkZlNRUWNSMkFSWU0vZ3QwOHJWeGt3Ums4MlFiMy9zRlFRNmhJ?=
 =?utf-8?B?V3d6bmhmaWpTVEhKMXBkQ3dOdEJEb3ZwUjNnaUFIVXN6ckdaZ0NsamtsRmw4?=
 =?utf-8?B?bklqQnZTQ0ZseVpEZDJnQ3ZOTldmYWY0aWRJRW15Vm9KOHpBMVdOeWNKSnhV?=
 =?utf-8?B?MHlhczlTVFZzNEp0VXFDaFhEdGIvVDN1TlhSK25ndWhwVmNWTld6WndIRzQw?=
 =?utf-8?B?eFhFTWVacDRjMm5va3FNTkIvVjVBRGM5UmxQS3AvV3FMUGdienFFdnZ0bWlw?=
 =?utf-8?B?RFFGM0hGWWx5d3AzMW5RYW9GWWpXcXl2bjhmL2tMcTlTRmZSZGhpYlA4NzZm?=
 =?utf-8?B?M2RjVGkxZk5tbUI0WmM5d2hzZXlIaHIzVjlhMDY4NTJkWWRZRzd5OGlwdUpi?=
 =?utf-8?B?ZWNoN2NxYnpYWWFxYUlTTXZBSzczN1RpVnFOaDNZY1RGeE5CWkJXY1BFWmZs?=
 =?utf-8?B?T2NhQjJRTnJLdmlvbmhEWXdwSVJ2emJKVzR1ak96UzBJaXFjNUp6NlI3dlha?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b67823-6dc9-40a9-2afd-08db44e340ca
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 16:45:04.0176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pq4WtTQysKdkw7CHvv2PP91uqxEUaWHknZ5BiVkANCiWGfq8ju0idNXM7cB+y15dsUfDeYi6n7t8Roepq5DhpJxbjcSAsaruJ5oq8b+Ucps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5785
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 4/24/2023 9:28 AM, Ilpo Järvinen wrote:
> On Fri, 21 Apr 2023, Reinette Chatre wrote:
> 
>> On 4/18/2023 4:44 AM, Ilpo Järvinen wrote:
>>> CAT and CMT tests calculate the span size from the n-bits cache
>>> allocation on their own.
>>>
>>> Add cache_alloc_size() helper which calculates size of the cache
>>> allocation for the given number of bits to avoid duplicating code.
>>
>> This patch is very heavy on the usage of allocation when I think it
>> only refers to the cache size ... how that size is used by the caller
>> is independent from this. 
>>
>> Compare to how it sounds with some small changes to changelog:
>>
>> 	CAT and CMT tests calculate the span size from the capacity
>> 	bitmask independently.
>> 	
>> 	Add cache_size() helper which calculates the size of the
>> 	cache for the given number of bits to avoid duplicating code.
>>
>> I think removing "alloc" helps to convey what this code actually does.
> 
> Does it? Without something to indicate its not the full cache size, 
> there's possiblity for confusion. While the tests are mostly interested 
> in the allocated size, the full cache size is also collected (solely for 
> printing it out, IIRC). Maybe I should rename those variable to 
> total_cache_size or something like that to mitigate the confusion?

This patch adds and use a utility that converts a bitmask into bytes.
I do not think it should dictate what the meaning or usage of the bitmask
is.

>>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>> ---
>>>  tools/testing/selftests/resctrl/cache.c    | 27 ++++++++++++++++++++++
>>>  tools/testing/selftests/resctrl/cat_test.c |  8 +++++--
>>>  tools/testing/selftests/resctrl/cmt_test.c |  4 +++-
>>>  tools/testing/selftests/resctrl/resctrl.h  |  2 ++
>>>  4 files changed, 38 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
>>> index 6bc912de38be..b983af394e33 100644
>>> --- a/tools/testing/selftests/resctrl/cache.c
>>> +++ b/tools/testing/selftests/resctrl/cache.c
>>> @@ -15,6 +15,33 @@ static struct read_format rf_cqm;
>>>  static int fd_lm;
>>>  char llc_occup_path[1024];
>>>  
>>> +/*
>>> + * cache_alloc_size - Calculate alloc size for given cache alloc mask
>>
>> "cache_size - Calculate number of bytes represented by bitmask" ?
>> Please feel free to improve.
>>
>>
>>> + * @cpu_no:		CPU number
>>> + * @cache_type:		Cache level L2/L3
>>> + * @alloc_mask:		Cache alloc mask
>>
>> The description is mostly a rewrite of the variable name. Can it be
>> more descriptive?
>>
>>> + * @alloc_size:		Alloc size returned on success
>>
>> I do not think the utility should assume anything about how
>> the value it provides should be used. Instead it should just reflect
>> what the value is.
> 
> I was just referring to that the value is filled only on success.

I understand. My comment was about the naming of the parameter, which can,
for example, just be "size".

>>> + * Returns: 0 on success with @alloc_size filled, non-zero on error.
>>> + */
>>> +int cache_alloc_size(int cpu_no, char *cache_type, unsigned long alloc_mask,
>>> +		     unsigned long *alloc_size)
>>> +{
>>> +	unsigned long cache_size, full_mask;
>>> +	int ret;
>>> +
>>> +	ret = get_cbm_mask(cache_type, &full_mask);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = get_cache_size(cpu_no, cache_type, &cache_size);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	*alloc_size = cache_size * count_bits(alloc_mask) / count_bits(full_mask);
>>> +	return 0;
>>> +}
>>> +
>>>  static void initialize_perf_event_attr(void)
>>>  {
>>>  	pea_llc_miss.type = PERF_TYPE_HARDWARE;
>>> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
>>> index 9bf5d05d9e74..d3fbd4de9f8a 100644
>>> --- a/tools/testing/selftests/resctrl/cat_test.c
>>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>>> @@ -140,7 +140,9 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>>>  	/* Set param values for parent thread which will be allocated bitmask
>>>  	 * with (max_bits - n) bits
>>>  	 */
>>> -	param.span = cache_size * (count_of_bits - n) / count_of_bits;
>>> +	ret = cache_alloc_size(cpu_no, cache_type, l_mask, &param.span);
>>> +	if (ret)
>>> +		return ret;
>>>  	strcpy(param.ctrlgrp, "c2");
>>>  	strcpy(param.mongrp, "m2");
>>>  	strcpy(param.filename, RESULT_FILE_NAME2);
>>> @@ -162,7 +164,9 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>>>  		param.mask = l_mask_1;
>>>  		strcpy(param.ctrlgrp, "c1");
>>>  		strcpy(param.mongrp, "m1");
>>> -		param.span = cache_size * n / count_of_bits;
>>> +		ret = cache_alloc_size(cpu_no, cache_type, l_mask_1, &param.span);
>>> +		if (ret)
>>> +			exit(-1);
>>>  		strcpy(param.filename, RESULT_FILE_NAME1);
>>>  		param.num_of_runs = 0;
>>>  		param.cpu_no = sibling_cpu_no;
>>
>> Did this change intend to remove the duplicate code mentioned
>> in the changelog?
> 
> It removes n CBM bits -> cache size calculations by collecting the 
> calculation into one place.
> 
> cache_alloc_size() takes mask instead of n (CBM bits) as input which makes 
> things easier down the line when the new CAT test starts to tweak the 
> alloc size. The new CAT test would otherwise need to track both the mask 
> and n.
> 
> cache_alloc_size() is independent of what caller requires so the full mask 
> is not passed from the caller.
> 
>> I was expecting the calls to get_cbm_mask() and get_cache_size() within 
>> cat_perf_miss_val() to be removed.
> 
> I would have wanted to remove get_cache_size() but it would mean removing 
> cache size print or moving it to elsewhere.
> 
> get_cbm_mask() cannot be removed as it's used by the test to calculate the 
> mask the test wants (but it no longer has to determine the size itself but 
> uses this new helper instead).
> 
> I can try to amend the changelog to explain things better.

The current motivation for this patch is to avoid duplicating code but as I
see it it introduces more duplicated code.

Reinette


