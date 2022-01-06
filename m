Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FD1486E0A
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jan 2022 00:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245659AbiAFXtY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jan 2022 18:49:24 -0500
Received: from mga02.intel.com ([134.134.136.20]:45121 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245728AbiAFXtX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jan 2022 18:49:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641512963; x=1673048963;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Qv8wMPedmc5TJ23wSKkU+MHmTm6rCRWgvKvoAA1R0UI=;
  b=cnyaf9zYs/ll6elKmMKU4AoZVOnZtk0xLPiDAok7esOiMZlJmkPaD0rR
   CSExDz/4Gi7O76fjjCzgQAcZqg+2DsP0ZHJyXubHFElUe6DrQ40y6A5d0
   RFmhkcW5X+CGQ8qq8F9wBod4P2dsIJWy6RuuK1g51sw+u5FCmXbHYF+91
   gosZeOEZ/1iCWAsMr7QPfzcUybSxg72Ca3zJD9+uX0NPvlpsWKDXrKaio
   l4doyInL2T3RaOhDG725nbndm2CQ0R6dgthLCHF1Vt0nt+y/+6MJ40Pa3
   /0p2IxB+71zGjXOCFO5TDS60vumkLPjcsMuJBkbSiDW7HrTfsnir40Ld8
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="230104380"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="230104380"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 15:49:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="621696661"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 06 Jan 2022 15:49:22 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 15:49:22 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 6 Jan 2022 15:49:22 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 6 Jan 2022 15:49:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRiqUlxYt67dc7M/b6lN2fYRWXojPgFazEFxKsQ92mHHmsa3v58FuQ6ViP+trwknyCmHahuRmeACwnHcFKgHXIYBlx/5eOgSCbZ+5tXPV7ni2WH+c3o4B4gvmX5bz/JyHTWy1ZFezZ69CgAxpuffDYl2zMQ7rgteluw7K8zj+mqt1YL0Y/WZtMGna29OVLEACYR0f9IDGFBWKwqvPYiPFXt9le+ZmE0wLnLkkUDIFiZX4+Z/RhiAa1RPwESDI4Vx1IvXCE1VfWTtt9/0LhPIYsCU8ObBBoKLDdHlMDovm2tXh71OX+nZoqeuWqg2UBiZ631XpK8HBkNUi1eU8y4OwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cxs2wSiviYOE9Hko53IkG+Qbs+Lm9VoXsBv5c7oApgA=;
 b=ZXTw0zIS3DDcIqEg/8mZOBvZxdGPLPNEgyZ2R4P29RUF1t1/33so13Eu+/hSABZk2FlSeH9YvzxnrwvTqStccfKf5kFZPIsDFhuZaXH6NgpYKOrFU++DlaPRva3qBRYx9LhZtUGP2lunbfl1mhVFrjMvjd9WJbs/z+44nlbmFlt8yvmG951uX9CM1aFBxzx0BaByBmARHufUw39mE8AIt4xP1brQIb+hcCh0SnWTROyKLT7OdrYUhptoVgVE47QJCQI6KtHFEpYNPiCr7xWP6KNnjQgaQ59sAuKuIbE4oWx4QzaidiRnnHwpBaUvXI0xOzCjXNm0ZAh+vaWf3I02AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN7PR11MB2530.namprd11.prod.outlook.com (2603:10b6:406:ac::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 23:49:20 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0%6]) with mapi id 15.20.4867.010; Thu, 6 Jan 2022
 23:49:20 +0000
Message-ID: <523b1ef2-3db3-a822-9ff8-4ee3d01ef534@intel.com>
Date:   Thu, 6 Jan 2022 15:49:16 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.0
Subject: Re: [PATCH v2 3/5] selftests/resctrl: Add license to resctrl_test
 Makefile
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20211213100154.180599-1-tan.shaopeng@jp.fujitsu.com>
 <20211213100154.180599-4-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20211213100154.180599-4-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR1201CA0007.namprd12.prod.outlook.com
 (2603:10b6:301:4a::17) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c627f8c9-d225-455f-bc19-08d9d16f287f
X-MS-TrafficTypeDiagnostic: BN7PR11MB2530:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN7PR11MB2530E2EA6F61321636F659D2F84C9@BN7PR11MB2530.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OwErX+HBet5cp4hUKKj7TZxtjD2y+mF2b82zSj1F/PAknYCHeyYbZVwFYgU09kmP/KlXE2SjuOil08gArtsB4Ppm18KvxayVFc6W5Zw+dxlSiaUewTwJ8xaOtVzA2hch59i+7K1Sb9WaTlKSNcWvqS2f4v2xM0GMwmIDfnNb6WYXAacwOD4V6w/KaWaK3RNKLdw+murnnXoTAomFC2IPwpoDj9iZovCNhCqhqCK8dYNEGA0ZQ8608wDGCzm3M59jgWvG3Mn33ytaxzesbERQW2B+0/omZI1DkT0xhAJRLKmM/q8y9lAzkLPrgfa3jvcKjCxzeVTTvKaIXoYmv0wq9+z8lvjSVMllnqSRDMedfssLI/RiYGBpilH8t3Oxg25WCFCN6VBdfeF5Zm6pFQx480WdnnEBFTrIi+m9peQ+6DoLyqasIrgDWTUj7Cgq/lGenvlW627sLdnbPBUr2gtWmpDswFl303+seKAZ7lFoaSAT5NTG4n51zry6F4Gjgh1T7pBWdHRSSCosjBTTX0/q/TYykgj46bPfv6xBFFAzaKLQTCoe9AtzY+XXXg6NLD+nKZRjM6aUBLCKRWB+n65BuP7xUmdORywP92ZUF7mXz46OVNV/psxE29pxyZwvHAePq+7tCJ/k80i9bN+xeCtM1wuO0zGtvet5j4gaXvXOjbMYX93HPEf8y7o65LaiWM2nnU5W4ondpHxFb/3PRKfzY7Z/Mi9VcqZbCx4UpQoc884=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(66946007)(66476007)(6506007)(66556008)(508600001)(53546011)(8936002)(2616005)(4326008)(316002)(26005)(44832011)(6666004)(186003)(2906002)(8676002)(6486002)(82960400001)(110136005)(31696002)(86362001)(4744005)(5660300002)(36756003)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG82eVZHd05NcXh1N01JYXNWeTV6MmhjV2cyVXhSS2lmMXNiOWNrQkwyRzh4?=
 =?utf-8?B?eHZRelRrdkhIZ2p0YUxLT1U4QnpVUnFFR25vT0JPNm90TmVSYlEwQWN0ZEw2?=
 =?utf-8?B?R2kwdy9yajcyV2MyY3VsdEt1S0hYUW9CZ2tWZmtwL29wQVRBY0VQSm1xRWRq?=
 =?utf-8?B?N0dMRHM5ZjZ4QU5PU1MwbzlLellOMTVDeFR5N0MyelNKQ2Q1MmZqcy9CallB?=
 =?utf-8?B?S242RkFSV1ovNHY4eEsyNGJVRy9rRVVoN2drUEI3bWU2dmZmc0xZL25PbGhB?=
 =?utf-8?B?eG4zN0o2VmhhNGxpaXZ0MzFneVZNZ2ZpSDRGbnljK3BPaitGaUtiLzNsWXpQ?=
 =?utf-8?B?UFhlRTdPdTFZbXAwY21CVDI4QWZaY1ZKUm05M0hNUStRVDlCdFlWWGJySktz?=
 =?utf-8?B?QWordmdRMVBxNlcrSVNUV3l0Z2FDQnNhUFNpQmdOaktlNEhZMlN6c1l1ZUZ1?=
 =?utf-8?B?eWdHbXU3cWtvcXVEUXdFK3IvaXVWeDFNWXRhVEZuNForWVRIY2tVM0ZPSnZC?=
 =?utf-8?B?SmtWV2V2VVRyWGFWQmlUdy8ydEdBdUNYa0pMZjR0cGlObmdnR0JCV1hmMGZB?=
 =?utf-8?B?bk5kd0dlKzdwS1l4OUxTdzVTV2IvNVRTdTI0OXk0dUlHclppbzlHeEhXV0tW?=
 =?utf-8?B?MU12WXRCNVpKWWY5UkpYZVVWQzhCT0NnRjVsYlU0U3p3L2RCT3lLWTBOV29P?=
 =?utf-8?B?M05iWmxlVlhVRGpWUkVOaTk2MXVKWEtJYzBFbHZzbmJ1aC9UVk8wRWdzN1lo?=
 =?utf-8?B?OHh1dTh6WkExaWhvdTZWTkZSMFg5dVBNelIrb2hYd2pURkpxMzFuRmhLNUs1?=
 =?utf-8?B?emdtVEE4YjZpdTVMd28xdDBlQ0lwbGdUdHowNS9lM29aVjAvd2VkYkxBY1FP?=
 =?utf-8?B?RExhS2FGMVgzM2ZoWTFSQWQrYStha21KUUVENTVSSGxwUjVoc2VkcUNlOVBW?=
 =?utf-8?B?UWlnODU2dVVOZmJJSFZLWGFzR01BNnp4M2lpaG95YkxoY0svQ1hSUGo4Zk5C?=
 =?utf-8?B?elVFYWU3VjhBeDdQWjlKL3hVUW1IQlFBWFlsL3dkUnF0MGxOTll5ZzlHd1o4?=
 =?utf-8?B?aFJoTXBCUVBnYm1vVVdxZWMxK1dXRWlsVG1aZkFnZEs3YW9rM0ZXeUZMUXVx?=
 =?utf-8?B?TlRoZGJMMHlBMVVseEtYY2UraU5CVndRV0ZZd0V0cXVZcHFoN2FHQ29PWTc4?=
 =?utf-8?B?ZFE3UjdHY3Z1V3RqWnc3dytyZWlBbXNCNnZEK2VmaDJDQTNQeUVRYU84dU03?=
 =?utf-8?B?VitGdW1tQllhVUovRFk3QkR5NFd4eGhGYjl5ZitWcHF5azBmeHBnRHErWTUw?=
 =?utf-8?B?bVVkZG92Z1lUSEJ3bGhrb25KUXdaTDk5ODRaQXlLVWRhb0dmdU13alNFT1Jr?=
 =?utf-8?B?R1JNMXRqSUxzM0lLOVc1TDZrZnU4U0FhbVBRUzBqcW5QZWNWbDF2Vk5yUHlj?=
 =?utf-8?B?dHk3MWhmTEE5OG5xQSsza2pyNGxhcTRsQkxPR3hGYzl5YVg5MkxSeTZCWDQx?=
 =?utf-8?B?cUQwbEZSUCtSUktBZzN5elh0dVgweG4vRnpKb0FaZTdwbmJ5aGNQQ0d1OFNt?=
 =?utf-8?B?RzY5S2xVQnJvRHJxZjVaaGYvb0VjcWVLM28xQ3VkY2gyZ24vRnhER2Jydjlx?=
 =?utf-8?B?ZFNyMnNPdEFNdjZpeFUvdFJBdjVrTzBXTXJHSVd0cVcxTmYvNmVmenFxZVFG?=
 =?utf-8?B?Sjk0ZnVGOWc1aGdINzRyeFZsa3VKUFcyaVR6bHd4N3VVamtHdWlhSG95b0J3?=
 =?utf-8?B?ejN0WWV5bldVN1dPZm52cUJQY3gxdk1RM3dhcS9aTkpUcXZocDhxa01nbkl2?=
 =?utf-8?B?b1ZKbUVVMzN1M3lVaFNUL0J6RGprU2l4OG9jQno3RWxndlAzc3hUaGhSMVpu?=
 =?utf-8?B?QXVlMXNGODUySlM1RGpmTTJxRXBPUXQxa0xaWmhsaFV3U0F1NDd4Y1Q5VFpW?=
 =?utf-8?B?U0x4ZzJkTmVuUDQ1Wi9mUk45NnVIMW9kdzFkYmcrN2J6cVhmb3JWZGVDYTZC?=
 =?utf-8?B?Wk12U2VGdHZ2dWZDVExjVmY1RTZUNTR0bG81d0I4WlJiRUVOUUtTQTdFLzFz?=
 =?utf-8?B?eEMwbGFta1BNNkhaa3BRNGtEcG94bEQ2TDdyT1hUbUYzRzkrZUF2cmtVL1Zh?=
 =?utf-8?B?bDYwUVI2NUVBSjBZM0ZpWHFQUTJsYyt0cjBXcXR3WGk2RnpaUWpReGpMdTU5?=
 =?utf-8?B?VFF2WUJ4bkJDOGprbGtBNUZTd2pMQUVGZk9xMVpGMHZMSlNvOGJtSlovL1Nm?=
 =?utf-8?Q?BJhjDN06f3biNUAgaztEPVLS2LanOVQSeZEChoHyc8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c627f8c9-d225-455f-bc19-08d9d16f287f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 23:49:20.3653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G3O7J1zcXTE2YTRaz80y3/DTss3ngueMbVIoNVkxI+F9JV3h/pH+qrkFuZGhtGauguCWJy/3fkbRInmJ56w/dO8vLo0ZSKwT+nNPO8HtVYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2530
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng Tan,

On 12/13/2021 2:01 AM, Shaopeng Tan wrote:
> Add Software Package Data Exchange license information to resctrl_test Makefile.
> 

Considering the patch series, why is this change needed to be able to run resctrl
tests from within the kselftest framework?

> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  tools/testing/selftests/resctrl/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
> index c9e8540fc594..adfd92145e12 100644
> --- a/tools/testing/selftests/resctrl/Makefile
> +++ b/tools/testing/selftests/resctrl/Makefile
> @@ -1,3 +1,5 @@
> +#SPDX-License-Identifier: GPL-2.0
> +

Please see Documentation/process/license-rules.rst and examples from
other Makefiles in this area.

>  CFLAGS += -g -Wall -O2 -D_FORTIFY_SOURCE=2
>  
>  TEST_GEN_PROGS := resctrl_tests

Reinette
