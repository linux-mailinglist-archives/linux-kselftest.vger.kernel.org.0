Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475FC77EC42
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 23:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346666AbjHPVw4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 17:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236987AbjHPVwb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 17:52:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90511FD0;
        Wed, 16 Aug 2023 14:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692222750; x=1723758750;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rVl1VQ0/Pu6clkHkTiiKPvTNmDFEMjrN3oynjf9M8pg=;
  b=f5zddQci9BgNwEPZ6eZOR8oZUCh0dycUx7N1hwnGpHGUWUwab+XR+RgO
   wYju3OxIlfCZbwHUzKu4orK/UrlHczx06L2Lq/IprIQ/Qmu8BXCmIuQna
   fQ5VIPXQ/jjbZ2/eHYjscn/Yx25Zbfr++3aNDL2pnQ/Lb4nDtaP36EN04
   TYtjq4QJbuO9uyllrBbX/HbQ7x6ecsDGIVa11hOcgLdYNKu8/9K+wHuHO
   SB9VndbC1aijXcuFKoEq4P1R32/2Z642uHhKxlfVnSxZwpyDDcj4mfGV+
   XxD1RWbouTNRqo3OQxfxSEKQdco2MNb0mptewAtSWGwhLG/uKTjXh4rdR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="439002330"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="439002330"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 14:52:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="737451506"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="737451506"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 16 Aug 2023 14:52:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 14:52:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 14:52:29 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 16 Aug 2023 14:52:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 16 Aug 2023 14:52:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChQNu4Y5IGFn3QDpdipDfP7XJF5dDfCafHaLJQuRe6xaAvl9gp57bBg6gJU1V9+SWEX1Fa10w1FHuFRB0und/jgvbJ5Xg0vt0+/TruOk63RFtPrR19zsKtWfy14jHvRguS8B7DRsiCw9Su67fQSYdzGySqtVO+ARAfPh3mjjry9ccLod+AHHbG9uniMM8pxymlh6qfMpX4MqKEKD2oeYZ1I32T1bPIEwj1wOTCvzGs6+Hflj29iGPCv+njsJ5hUpkYrZM8P9mSk3fd0LiagBJrASwC2LBcrwPTPmuuzv47xOTXMIzWZobhbmy+XEcRxeGCwUwzvRXlDjBUoAitoDAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtEKJBD9nHucPOgMtgv0e0EkL40tO+dCgw+2/8RVjlc=;
 b=BBHDchFAqIXQV4ZykdpxiHT9jSMEaLqvcqfYmmY4/L+YE3L1pFsHvqu8UPpImbW1YH3WT1UsBAfwtYVgpElPcUqXRN8S5Cf2FtFWMDFYACK20NQrFuNuFwEpf1KTOdofGNx6on+aE6GtoOyTRXUCcrjr19C8ulJNTaMpGxBbWAOIiPifPxfeTbMZsHs4yM5cHISRiW0gWBbsjXu+OlJYcoJqE5Sym6iNnPRQqE+11HD1e+mkGGF6PRVI+q9TgPFtBU6LX+ZgWJdPDBHHB92glkj8zumVf1cbdbK4W6EXXyknTBj09j6l/VVA/vNRR2vYPgGzgekBEKabMkrs5isx5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB7250.namprd11.prod.outlook.com (2603:10b6:610:149::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 21:52:26 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 21:52:25 +0000
Message-ID: <bacc2e6f-f747-ec65-b23b-4275d1cac018@intel.com>
Date:   Wed, 16 Aug 2023 14:52:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH 5/7] selftests/resctrl: Use pointers to build benchmark
 cmd and make it const
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20230808091625.12760-1-ilpo.jarvinen@linux.intel.com>
 <20230808091625.12760-6-ilpo.jarvinen@linux.intel.com>
 <f300a52c-d65f-fd74-18ce-7d37e76d144f@intel.com>
 <dd83f672-b9fc-cd79-10ff-70651d4822af@linux.intel.com>
 <87183b24-f343-2420-9bda-f1012e7195a1@intel.com>
 <f22efaf4-d87f-d3c4-b986-7d326c912a18@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <f22efaf4-d87f-d3c4-b986-7d326c912a18@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0077.namprd04.prod.outlook.com
 (2603:10b6:303:6b::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: 819cf327-8151-4715-3d85-08db9ea313f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j984ab/JZCqr1D2sB8TyrsoS+iaDhBatshFIhz2iVzgPG1DTPYJV1wGhkMwR5gF9Z5F5X7d3CUFvwN41OgapcO9qd05bKDUjTuUf+z38fsRwCMi4r2U2Ky6CGlOT0hU3AFzGjuK6QDtTNO5CPi9LkV8py9Fe4g+0P+aZ/aXYlmbAsbOgU4JpAIaoeM32qeg5dyz6ZBTQOHZG2Wm31l7lrSBR+RPh7JDNqykEF7NSxKI2X2B4eLMP7vyBRN3J3lnVwPB2KTjZOHRN+cacHAHK3e2/1dkiK06jwB+tuhwQdP5YaRx4ahw41Q9y8TQNnmFiu0kJjBmKuw5YEBvOfcTi7VDiFSpLN8I+Ei1dRMp+RpKekuZoK5nf6XfMTFIMtWLPwHNMHQWMLrelkRbLEeySklv1pknYiUHgyR8ocgjmbtHuiEuEqQ8eoOmqpgVzx3aW64Un711Px6dDjjBRuLgyAly5SXNxhBJ0ZGUMz+4036VAv1Xkuu16/UStwcTQFHGERKDPsKqSVNhbkjzf8CnsW3CO+40GSyTrXlWqJG3OK1huUMjgc/QHeofebJ9OiEKqo6rbADnP6Bsx1SApq5wyVqbwYlJCxM3S6670hESK7Oq8F+0h68lEf47og4ZziMTe0oKjlUy9/B+/+H+VKCVjhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199024)(1800799009)(186009)(316002)(54906003)(6916009)(66946007)(66556008)(66476007)(5660300002)(41300700001)(44832011)(31686004)(38100700002)(8676002)(4326008)(8936002)(82960400001)(2906002)(26005)(478600001)(86362001)(53546011)(6512007)(31696002)(36756003)(6506007)(6666004)(6486002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmdzMFhrT2l3VW1HSjQ1QUhEeHdWd2tNVUlMM1lIYWxKcEpJcXNtSURzQXUv?=
 =?utf-8?B?RFQwWVB6S2lPeUpZZnFDZHVkY2RkMEJvZEVRWGJFYU9HVVh6ZVplMkZRUUhz?=
 =?utf-8?B?Q29ZUERDc3RpcVJNZ2c5bWtpckNNZUJoZ3BLOVY2NU1sYnEvcG9yeFdkckZV?=
 =?utf-8?B?YWRZd3V2OXFtcUFXa2EwZ1RBZXVlSnliVGFML2xRWjU5bjlidjVBbmYrMnFF?=
 =?utf-8?B?eCthcVFqbnBxZlZFcUY0UWQ1R3RKM2FMK3NTTVFockRoTWJaUks2bytPNzlU?=
 =?utf-8?B?QnBhUk8yK1FYemh5SmJUN3MxR2xOK2o4UjNmaXJzanRORklNUjA0STdla1R6?=
 =?utf-8?B?V2RZeHNXcVRla2hiTjg0cUtLSWtoT0hETXp5cHNjd25QRERPZXFYRnhGK1ZY?=
 =?utf-8?B?cHRMenpMd05ndWF4bS9rUzlzc3ZxZ0dLbE9zUExHYmR2SncvNnI0MXBJNzhM?=
 =?utf-8?B?ZGVsU1U0QmM3cnhLL2hWREFCZTh1NlJNM3Bqa3VvOGZkM1RGVnJjMW9JNlpi?=
 =?utf-8?B?c0FQQWl5Z3plR1gra1N1aDNad2p4eVNEWk1UVkxuTFBQWElpaVNZZTYxelJP?=
 =?utf-8?B?SkNVcVFYc3VlR0dQTDhGWU43TThLbDNRSkc3WjVweFZ3WUMzS2FKWlJpMVMr?=
 =?utf-8?B?VXNnZVh4aWZSb2x6dXNwOEZsOEEzRWc4b3FtYnNJaElycFFLUS85YUdtek1Q?=
 =?utf-8?B?bmxDcS9MbXN5RUROZXp1ZGZwdk5ackVMTDAxbllicVVlbzRzVlFvUFR1eTlC?=
 =?utf-8?B?V2s3aHphUFo3cktFeHQ1eTFvcUoxTU1TOHdKZWlpbFNZWnBqTlRoRGUvT0hu?=
 =?utf-8?B?c0xJWEZOU1RjQWR3VDBNSGV0TUtrT1BVRXhub2c1dVhZOEFLZkpTUVZxaW13?=
 =?utf-8?B?UmFoSTArMzZHb1F5OUhjZUErcjk2c2xiQUpqUWFpU1NWVkYyRmlieTRoZWtz?=
 =?utf-8?B?d1J0LzQ1clRyellNNTNocFlTVnRSOVZGc0FydVlUQlFCU0tnS1ZjVW1LcCsx?=
 =?utf-8?B?Ky9oUllQQVZvcUpFZHMvN0FPRG1xN1pPYWZ4Z21KRFBOTVFvZkx0bTlwaUpX?=
 =?utf-8?B?SDcvYzgwQUtsSmpjeVMva3kvaUZMejFKZ2VOLzhpYTJMWmV6eWtJcnhBRTl3?=
 =?utf-8?B?WXVRRXkzczlEcEpETnA3YWF2UklMQW1WdytJZUpXWExYL2pMZkhJZWlJdmQw?=
 =?utf-8?B?UEh1bCsrRDR1ZEUvdXBpTXA3RUhRbjBsMUh6bmJPY0pRZDZhVlpTQjNHT1BH?=
 =?utf-8?B?dDR0S1VQVGdYeHRLR2ppRE0xc3RSU0xCN3pxSThPRWE0S2lQZG5COHlBbmxn?=
 =?utf-8?B?cnFVbUhZb0ZFbU1ZOGNQRGJVQVl0UVhMWnRCa1pKVXdnSzBJdnRidkEwUllh?=
 =?utf-8?B?M3BaWVd2N2dranJtRjZmaVh0cVp4akVyV09hZFpWSCtEWWdFbTRoZDVvSGZu?=
 =?utf-8?B?QkgyQjdNcU9RczU4N09rb0w4TXFWVGROUGNNQ1RYeU55WXNZM3MvcTRQVGts?=
 =?utf-8?B?S1A0K0RHMThWSzV2U1RTQlBIcEtlMVg4cjFoNXJpL1hGNngvczZia2JvMFlK?=
 =?utf-8?B?bStLaVFZVnh2ODUwSm9DMDVWUTNlRmxPUGx3VWdSUlRZOEp2MXdaSW0wWitz?=
 =?utf-8?B?M09sZER4cjBUMkVNR2l5WXJ5ZkNMRUJUeEx5bjZidlZWQzZSbFZrZ3VUWkZy?=
 =?utf-8?B?Qng0QW5GSkFBVGJWQkZYTnVNYnY3MjR1QmFSY3BFRHRiWEZ2SGl1eVBZd2dH?=
 =?utf-8?B?Rm9SWWVEK2xqOUYvcE1UVzg4OVpRenNYMzh2amZTRkQ2UXBHaUtUaWE1dGRi?=
 =?utf-8?B?bHZNQUpiaWM1TnZUSDNkaEphNkdxYUZweDhiaHpOS2hKTVpCbmdWczV6SFZW?=
 =?utf-8?B?MVNMbURaMUpmSWF0NDZraWxaRjliS0Y0dWg0bG1SM3BpM1JhVXRvMkpROWlW?=
 =?utf-8?B?ZzZDOG5LR2U2MGlzcDZkR3BjSlhsY2d1RCs1cWVrZnFjcm9WSHJMOFgyaE9u?=
 =?utf-8?B?WHdSRkE2WTNNZW9EaVJ4YVE2dEFtcTRUc1dmcFBZZ2VoVW4vUWZkcjE0aVRk?=
 =?utf-8?B?UkNNM05mSTFSNFArSGp2WGhSbWdYZ3hGc0tHTlVPSU9FYmgyZHJqOVV5NlJO?=
 =?utf-8?B?bXAxRjlabUgxbmxRaDExN3VRWlFsbUM1TkVQdExqOXBhTEZvT3pCK2N6Y0tD?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 819cf327-8151-4715-3d85-08db9ea313f7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 21:52:25.6372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cygU160FmBSgVZpv42YkBT6kPqzxGK66u3RR8EueZ8VolTJHHL4sIJq++gZQvjxIX+dtS647rkRXpoWoS0CGPiePFUqEVqWKpGKhxAaYw1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7250
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 8/16/2023 12:13 AM, Ilpo Järvinen wrote:
> On Tue, 15 Aug 2023, Reinette Chatre wrote:
>> On 8/15/2023 2:42 AM, Ilpo Järvinen wrote:
>>> On Mon, 14 Aug 2023, Reinette Chatre wrote:
>>>>
>>>> On 8/8/2023 2:16 AM, Ilpo Järvinen wrote:

...
>>>>> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
>>>>> index bcd0d2060f81..ddb1e83a3a64 100644
>>>>> --- a/tools/testing/selftests/resctrl/resctrl.h
>>>>> +++ b/tools/testing/selftests/resctrl/resctrl.h
>>>>> @@ -6,6 +6,7 @@
>>>>>  #include <math.h>
>>>>>  #include <errno.h>
>>>>>  #include <sched.h>
>>>>> +#include <stdint.h>
>>>>>  #include <stdlib.h>
>>>>>  #include <unistd.h>
>>>>>  #include <string.h>
>>>>> @@ -38,7 +39,14 @@
>>>>>  
>>>>>  #define END_OF_TESTS	1
>>>>>  
>>>>> +#define BENCHMARK_ARGS		64
>>>>> +
>>>>> +/* Approximate %zu max length */
>>>>> +#define SIZE_MAX_DECIMAL_SIZE	(sizeof(SIZE_MAX) * 8 / 3 + 2)
>>>>> +
>>>>> +/* Define default span both as integer and string, these should match */
>>>>>  #define DEFAULT_SPAN		(250 * MB)
>>>>> +#define DEFAULT_SPAN_STR	"262144000"
>>>>
>>>> I think above hardcoding can be eliminated by using asprintf()? This
>>>> does allocate memory though so I would like to understand why one
>>>> goal is to not dynamically allocate memory.
>>>
>>> Because it's simpler on the _free() side_. If there's no allocation, no 
>>> free() is needed.
>>>
>>> Only challenge that remains is the int -> string conversion for the 
>>> default span which can be either done like in the patch or using some 
>>> preprocessor trickery to convert the number to string. If you prefer the 
>>> latter, I can change to that so it's not hardcoded both as int and string.
>>>
>>
>> This manual int->string sounds like the trickery to me and can be avoided
>> by just using asprintf(). I understand that no free() is needed when no
>> memory is allocated but it looks to me as though these allocations can
>> be symmetrical - allocate the memory before the tests are run and free it
>> after?
> 
> It could be symmetrical but that means I'll be doing unnecessary alloc if 
> -b is provided which I assume you're against given your comment on always 
> creating copy of cmd in CMT test's case.

I seemed to have lost track here ... could you please elaborate where the
unnecessary alloc will be?

> 
> I think I'll use similar resolution to this as CMT test does, it has an 
> extra variable which is NULL in when -b is provided so free() is no-op
> on that path. Then I can use asprintf().
> 

Reinette
