Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A12F6F0808
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Apr 2023 17:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244064AbjD0PPm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Apr 2023 11:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244137AbjD0PPk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Apr 2023 11:15:40 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F40D4698;
        Thu, 27 Apr 2023 08:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682608535; x=1714144535;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5N13bfImo4DXn2IcI93gTSYRYhRseO/jMRb1FTv2I6o=;
  b=L5W2dXvFDbrPp6ZZmXZPWw2vL4/NcUYB0inhbwlTSP3M3kRzeAYgrpB7
   cEi2SPsWPZ9HfmhDoW/WSrE2to4qw/mM3pHn2yaH8HIxHahUbVdC7eVHa
   FWhnaK7grctho+4OjpaV5iMM+/DaOu8SYwWoFOo3fYkk8pHQTmhh/H6Yq
   /RXMeHE77mPeG482x/v3+c/UwkjJVHd2mYnOKDbaft9oG5Ki/a2Uh+fqi
   dWg2JxopPSohx/GqApKn4TBQjW6reFBRUgsbGflhocmiYyM2iJ4W3JcPZ
   rda7eFdssF+GQZ+Sm3vDe5D5Wp1d/DY8sQJAh6pMoS3ea8mMwqZS5Irkp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="331749955"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="331749955"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 08:15:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="1024157575"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="1024157575"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 27 Apr 2023 08:15:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 08:15:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 08:15:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 27 Apr 2023 08:15:34 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 27 Apr 2023 08:15:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4M1NjnoP8iQpFlFgj+VbX5NgCz7NwvvHkyqgVOkljUURfg0NM1azQpBjbSW+AHwk+z1uXhR3xtqpQkkwdEFumzModipmZLRLno2Io3Ei0Xwu+expoLwhtndJdhREMPXBxtKDDkZv2K8X7JbFEBgICIevt+m+5odQLD/CbEXjbzlYsqiLFjllXwMqd0KcTveX96qJhHKwhJ2gZoNuDJmrOdhwo3xmPdWUlCtgJst6TXyQYCvgrHSiEMQNVUR2JnDLzUGF1mRUiXIkdqbWuVZ0Wse9prne0o7rH8CfTTF05HG7R/htTm03XDgfcQRzVfgV0ODS4Lc9IkaoRA7vH+ieg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMCrp/jiiTBcKmWlvqUYOyEIuZ9KcSQgH17vWtfQv4A=;
 b=RucK+uEq1prtapJDaRI3UC3M2i2xWRs9+PP6szycDbOSPiDsL8izxaXrZSvn5DEizXtBD/h2gmSlBEL2VaE/4hXnmigb/JmrVAHZEgCUAUSAFDtNJLNkApchtZUGaP/do0R+IJyUMt2Ql4JUWY3TFPB0CrqIXmJrRRfAsGscnSRhIMpDDibP1CBWhnkfr3n46mgKqHD8HfiM2fDfdkKBuaJ26Uw/dMsLN6hQs1loDtny7i4+H7tFrbEml7xS7WfVlWZNf+NW43B1WcojgQtikSZwfzb3H0ijJp9txWuzAo6jde6k+7fPBxwjUXkjI39cqcgNamrqjHSqOEL0Eh+WDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7)
 by PH8PR11MB7967.namprd11.prod.outlook.com (2603:10b6:510:25e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 15:15:32 +0000
Received: from SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::f263:dcd8:dea2:ad14]) by SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::f263:dcd8:dea2:ad14%7]) with mapi id 15.20.6298.045; Thu, 27 Apr 2023
 15:15:32 +0000
Message-ID: <eed9454b-a276-e545-64a7-5d236dd38d82@intel.com>
Date:   Thu, 27 Apr 2023 08:15:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 24/24] selftests/resctrl: Rewrite Cache Allocation
 Technology (CAT) test
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-kselftest@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
 <20230418114506.46788-25-ilpo.jarvinen@linux.intel.com>
 <eac72c7b-bd01-084e-cf23-ec5e8e0e3cf3@intel.com>
 <b2f72637-5c16-d25b-8a0-3fee4ca9ec7e@linux.intel.com>
 <ff2b3b61-57d2-04da-a719-c72d8bfd49eb@intel.com>
 <dfe24719-cd5e-9ff-9278-a92356dc1490@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <dfe24719-cd5e-9ff-9278-a92356dc1490@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR17CA0052.namprd17.prod.outlook.com
 (2603:10b6:a03:167::29) To SN7PR11MB7566.namprd11.prod.outlook.com
 (2603:10b6:806:34d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7566:EE_|PH8PR11MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: 74860142-1a5f-4978-1ef4-08db47323dfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7oU+IvME4yCSDRahlOqp6QdV3pH9cjfbUlq9nD3iDKU1GHcaIN8YXOMyv5Lzi9ANl8cmDEj3pQ5vHcz6XQGLZ8Tt1SOWMuDNZCOR21dDDqZrOYR6VU9j94Zgizyj5K0wM4Spq1krAGE/tS06lMjgRDudz88HNUrH6tQOPvNe0eN1VP6n7NmEd1dkSSuZEBpXttXI/FTyaCThXjU8oVuYclqrqDwfpR4dwUKsPU2g34t/vWd04mnQZ4Xj8M1BVNTIqV6ryViBiOkrKjcEhvbU3//byrScCZKNyzVn6hews6cMdB20OMfWSO4FOPIw/UXmaieckRfEpEbO+vDnsw+IwTLkKYVosBsUOH7mpsJv57avmrNmeUHX2VLc7xoG12grdJGue4S2Vgcau6zinlhuK9i1Ruh3hTl2l5WZFphi0JOby1EnA/GhNqR5r7NNMlc0YhHZIo7dsYHQJvLmCXrGkr78nZu4ta9BQcv84m4A4qX5k1h/WCioM/yN3W27G1g3SK3dcPwSfj61TM4dOQw+vkpM2EVz1F3ZLEZqDnlXPwzpVQhJtK+kmmXeAmK3c+yLEBj5PrweVRHMQIuNhmVi/QbbMzuxktouz/wC0hKEo2gIEhpAdDSPsVexS6Pyitu07jWvjNGrmAyVSIL6SnbzFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7566.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(366004)(39860400002)(376002)(451199021)(66899021)(4326008)(66476007)(66556008)(316002)(6916009)(66946007)(54906003)(6486002)(6666004)(86362001)(478600001)(31696002)(36756003)(186003)(6512007)(53546011)(6506007)(41300700001)(66574015)(38100700002)(2616005)(82960400001)(2906002)(31686004)(26005)(5660300002)(44832011)(8936002)(8676002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmJ4cy9xM25SYVNSRUNrYTFJd0wvSU1uS05jazVPbTk5ZnJ3Yk1sTlZQdnFQ?=
 =?utf-8?B?SGkzRmhIdzZuMWNMK2tGcTFobmJPdlJtUDNIRFBXTUs2MFlsTGtHUWllcUNM?=
 =?utf-8?B?N2t2b0ZBL0k3N1R6cm1scWI5dEowUjFwZGxPSzFEQTBHM3J4dzhxS2VzWHdO?=
 =?utf-8?B?bkYyNitFVngwZURHelNPcWE3anhZK2tHcVN6V0hhYnZMeG1xRkR2aURJdVpL?=
 =?utf-8?B?SHZuUkYvSHRUeEdGeUhCY04zY3lUUERYb21DYlkrR0xxVWI5Wm5Lb1dLVmxy?=
 =?utf-8?B?R3hMclJ1TGZhU2FPL3J1dmRhbDdabW1VZFVTUmYwSWpGUWFTQU9XTFF1MjJZ?=
 =?utf-8?B?djE2dWpoN0QwYS9YQmFwL015bTNVVVhBZUdRdlFCVjZURG9lVHdQeFJ4dmp6?=
 =?utf-8?B?OTFoVUFGUFV4TVZlRzFCaUwremlhRHdIdmd3SWtNWEVaOEsxUTB6a3BiVmdC?=
 =?utf-8?B?L3FWQlAvZk55d3kwMHVwZ1lwRUpYWm1NVlN1Q2pnODZrMitmL2pNbi8vVktD?=
 =?utf-8?B?Zks4V2xPenRDbUVxRjYxbllVTURBYmp3bUJ1L3pKQWhVSjdlZ2dQRXNrU1Nx?=
 =?utf-8?B?RVVUSG0wbGZCQU1KZ24rVG5YOXJnZWovWHphU1M1Rnh3bFlLdXg4ejBCZWNN?=
 =?utf-8?B?dGxnV0hNNXJucVcvUUtEdFlVYnNnbjZKMEMxYzM0R1BlNmo2Q0k4KzhjaG5F?=
 =?utf-8?B?R0tEdXgvekdERHNRb2I2Y21iZzdRMHJia0N0T3MvUXNydGw2L3BXQStyTjV6?=
 =?utf-8?B?MkZra0JSMVQvUElXWnJQWVBZQ1NpSkxVTHl4WWhEYmNzS21xc2xSZm9lQmh3?=
 =?utf-8?B?WVBNSlVvSWRsRVRJd3hYVFJNRk9mNXdnTUV6VndzVTNscVVjUXZYNEVGaTUw?=
 =?utf-8?B?MnVBOSt1ZzBCN2ZQbmMrbllRNEVSMVJaZW93eHVLdDFPL1lLSDBuVUdxZm1m?=
 =?utf-8?B?WVRFVTFZTmhlRDFYcTFYdTA1L2Fsci93R0tlMExkQnhKY1prdzNtOWdielB2?=
 =?utf-8?B?NVBudC9BaFNkY20wRjFxV1h3Z2xhdUQvN2l4d2NjVFNQRGJXVFcyOHRDZXA0?=
 =?utf-8?B?WGs1QUFSSDZSMWU1NEY2UUZHSFpoRW9QRmZCK3hhZXkvdHRKRGozcWVjT2Zn?=
 =?utf-8?B?d2w5QVZoVnRzMmRqdy9xVlQxbXhoUXcvRlpLZVJRWkxwZkJETUhXK2ZneFZp?=
 =?utf-8?B?UXdOdWJ4TDdiYk12SjN5bjJ4Nit4YnlBWVlZcHpOcE9kY1JZaTY2R2pwclJB?=
 =?utf-8?B?Vk8zeHFYMVpWM1VRbndMZWhLL2diUXd3WTRlRzMvT3dRWFdmK3ZTd3gxSUcz?=
 =?utf-8?B?b2h1M1NieXpoWTJCcFhFb1h2RVRJRmRUOXZ0czhzRG5PQUNDRG83cFNnNU9G?=
 =?utf-8?B?UnVISnYzU2hjV0Q3VysrYUhpSHpmTWZYWSt5eDBOMy8wbkxKOW9YQWxoL21J?=
 =?utf-8?B?a1ZhRVlVcjN6VEdBeE9YUERJOXFRRjJJT3RqQnNBbjNGRkFIamsrdFY2MC9s?=
 =?utf-8?B?djkyd0tSQitHMWR4SmMwWkEwekVzOVFVMFJKKzVTWXVFaUd2aWZ3Z2dMU0R4?=
 =?utf-8?B?UlQ4aGdrak55STEvck1rTFB6c3ROS1hKbHJJcU9xTzltMWFJL284ZlNGa3pp?=
 =?utf-8?B?dzVRVWY5endseEYrWVhEK1BFbW1IZWtZSjc5M2ZHL2l0MDBJMTBzTGRiNk5W?=
 =?utf-8?B?TXpObG14WHlYZnZqc2ZaMEhsMXRFTlQ0cHRjNjFtay9iT3ZMMjNOU00zM1VF?=
 =?utf-8?B?eXpBY3kwZm9pVEN2ZE0wVU4zK3BLT3NsalppOUFGS3JCdXVTOTdlb253SjVG?=
 =?utf-8?B?QW8rUjNXUjZqU2ZIVzBxWmkweTFmNHpJUVhIQnlTMjVMK0w4MTFqaEh0V1dZ?=
 =?utf-8?B?TWxVRWRjUHRSVHRETkRNZEV0L1ROcUpxOWtCd1lBU25oN2VmSmxQWXZoUVBy?=
 =?utf-8?B?aW5wcTlJaXNxU0w3ZlprZkFZZmV0RkpkaVJNdjlzNUtBNXlBT3FIVW9CeDRN?=
 =?utf-8?B?YWN6dUhsTTJIV0I5ajI4bW1QcFBPTWptMzhMbURTQzAxN0k3RHE0WWV4c2xO?=
 =?utf-8?B?UDQrSWFodGZxc0Yzc3hDTU1YaW0xdHN2NThFeDE1cDZrd3I1ditkQm4reU53?=
 =?utf-8?B?bFRET21HNmQxNlJuK2pBTThJN3kzckVXa0lhdlZzZGE2OCtHRGhhYzhBTDdk?=
 =?utf-8?B?N2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74860142-1a5f-4978-1ef4-08db47323dfb
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7566.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 15:15:31.8825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: clibbTWkL0UTmGejYF9p6Jp1C61kVF2NMuo8ZCLf2d+X1j6LbJeTHBcW1w2SYhE8tEt4PoIDx9Xytt5UqVAagKiXJx2YZ3HmIge8oJ6mTlA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7967
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 4/27/2023 1:04 AM, Ilpo Järvinen wrote:
> On Wed, 26 Apr 2023, Reinette Chatre wrote:
>> On 4/26/2023 6:58 AM, Ilpo Järvinen wrote:
>>> On Fri, 21 Apr 2023, Reinette Chatre wrote:
>>>> On 4/18/2023 4:45 AM, Ilpo Järvinen wrote:
>>
>> ...
>>
>>>>> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
>>>>> index 4b505fdb35d7..85053829b9c5 100644
>>>>> --- a/tools/testing/selftests/resctrl/cat_test.c
>>>>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>>>>> @@ -11,11 +11,12 @@
>>>>>  #include "resctrl.h"
>>>>>  #include <unistd.h>
>>>>>  
>>>>> -#define RESULT_FILE_NAME1	"result_cat1"
>>>>> -#define RESULT_FILE_NAME2	"result_cat2"
>>>>> -#define NUM_OF_RUNS		5
>>>>> -#define MAX_DIFF_PERCENT	4
>>>>> -#define MAX_DIFF		1000000
>>>>> +#define RESULT_FILE_NAME		"result_cat"
>>>>> +#define NUM_OF_RUNS			5
>>>>> +#define MIN_DIFF_PERCENT_PER_BIT	2
>>>>
>>>> Could you please start a new trend that adds documentation
>>>> that explains what this constant means and how it was chosen?
>>>
>>> I can try although that particular 2 was a bit handwavy that just seems to 
>>> work with the tests I performed.
>>
>> The changelog claims that the existing CAT test does not work with
>> this new test offered as replacement. Considering that I do think it
>> is important to have confidence that this test is able to test CAT.
>> The words "handwave" and "seems to work" are red flags to me.
>> When merged, these tests will be run on a variety of platforms with
>> various configurations. Using test criteria based on measurements
>> from one particular system may work but there needs to be confidence
>> that the criteria maps to all systems these tests will be run on.
> 
> My "tests" (in plural) were not limited to one particular system but 
> included systems from different generations.
> 

Thank you very much for your thorough testing. Having this information
accompany this change will surely help to increase confidence in the
value chosen. 

Thank you very much

Reinette
