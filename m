Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1ED5A9CF2
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Sep 2022 18:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbiIAQUV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 12:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiIAQUT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 12:20:19 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3A425C7F;
        Thu,  1 Sep 2022 09:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662049217; x=1693585217;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DB2G8uptm9u9ZbDHWOwCJeIue1Ikc2F6/LNKl7vIxdE=;
  b=TohDBucYfE4ikJFfnOVBrmUJUf1oj0c/NFZMkg+/E+zLYUXjlNcwsbzQ
   Srz1ZEugTaH4jzv2GLv0Wj16/r4wg/sbwUR7Ymp6QiNeczrCMUrbvw0K0
   cE+NAJlupH8ei5ne5EJOFddnrWtWZ8weyi8h7aP8+cuaOArU+5xi3QVAz
   z4pjDinCVPmxvsAD6yOIKlV6rbJgWBW9h5YsqYUnqnl/bOF2qqA3KpQE1
   vb8FzPimNYmruq+7y7DMJgHgfw+dswAQlJGB6883Gg4AHo66bIwYzOpen
   LpCcDXb7AZ6hVLWP6pDUW0pGIvjdgT0ZGZPIa6ztriXWePXjHutjsfNcJ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="275509751"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="275509751"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 09:20:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="589562498"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 01 Sep 2022 09:20:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 09:20:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 09:20:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 1 Sep 2022 09:20:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 1 Sep 2022 09:20:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKJsCbP80aGaEAPk0/IbMjq3NWVqRomi2noXpiXrLs20oGqQu0ZaT10jjLkQpjmnRaHGTCG/JiYJPQSJv799/x3PrBwP0xe9oyNi56Zs9ieARbUAf2XzPEiZIo5yVTXcgnh+vwgC8oRDsqdV6wyAQLioxE3fW0EgSNOBsEpxfx86oyJqLpzSgDNcOiq35NuKWe8EJg4eHlp3pwB7+LiyX+iHdSS7w9N42n6/Y5gge9X+DX9Je75PP/oBCpVf37Cptnfa3ZdXxLBNsVD4mjMwUOVJWTLM9pgX7ycOvXo1M5x9PwuS9c2F8I0oLJw1SOBJL7xkDVDYJMSgfe67ni0OCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ozn2gLIXVbNS/PJEIDg3qkz+ZlyHgVpolPG9wrv0ifw=;
 b=nFfIOWOeQs4Kt6WizM5o0PErkVFf8y6hjFfPR8jL+5RN2aoBUMe4Uo/KyPBZu2l94z7rmedy1OVZsoPNYPPAd2hXSyBk5L4CbyVdcb2fkQgkcIw8cGp6QQ3vRydCuLWVgtCVDT4i2a2Z8dYzT1XeWkS55KnAjO1jZGtE9kJRa4o/fbWL9ANlg2unR7lQ0sDMZJdClITZgwRWjV6nJt5UfcEamu0A50XEsPQb7aRl8OdCFlCfYoFp+1Q1Xc8dr43eoLPvmbEIL1ms2rlkVZ+q5uMc3ytyf6NDGkx9sPHcCufImFG37guo/Jk1+0K00ftLjjRbSdDEbVyCNcyzZT+KBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by BN6PR11MB0065.namprd11.prod.outlook.com (2603:10b6:405:65::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 16:20:12 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::e5bc:d418:aa62:955c]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::e5bc:d418:aa62:955c%10]) with mapi id 15.20.5566.021; Thu, 1 Sep 2022
 16:20:12 +0000
Message-ID: <be12970a-4288-d093-adf2-f2cf14be1a17@intel.com>
Date:   Thu, 1 Sep 2022 09:20:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [selftests] a37ddddd86:
 BUG:KASAN:use-after-free_in_firmware_upload_unregister
Content-Language: en-US
To:     Yujie Liu <yujie.liu@intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <lkp@lists.01.org>,
        <lkp@intel.com>, kernel test robot <oliver.sang@intel.com>
References: <YuOHivPKKyhPBXv2@xsang-OptiPlex-9020>
 <aa03b329-ba27-d0bd-932b-7b1e884cca9d@intel.com>
 <95b1f303-421c-420a-0d34-6f00ffaae723@intel.com>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <95b1f303-421c-420a-0d34-6f00ffaae723@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0040.namprd03.prod.outlook.com
 (2603:10b6:303:8e::15) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3113ced2-c763-4daf-7cd9-08da8c35d87d
X-MS-TrafficTypeDiagnostic: BN6PR11MB0065:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w9H4Rqmngle0cT7rivMhg2DgmwtYEC9PAt3GAWQAyoWphTAwJJ0XTqYI4Azutwrwhwm4ptstbTyywOiB5wTwhhyUJdV1XA/iIKbMN4sTNCrz4l8hlJioHCfz7wqjHfUdTLIAHGr4a5dk7DZp83Dj6otvUEWfUgdjQJLyQAz8tO1sSIp3NIlPTGn12IIRscHMx/YgCvvlCAdcRpC1Oxt7A12zryvob3/QcBATqlZ6VsIFSOkRGIK7N7i/iPxAF25XQ8KsS1SC4QoSmHdpsQbpww2NEN0W8d7oRs/NX6L5TFf9FXHp3Oyo7xkMEdYz2tgrDRIFFh+msxJY3uhclllc8lG7sQn9TKUUFPuEWjob5NpQtEjGGlb8G+FJCuSwsORTowuCr5p4pK1GXd+J4zDa3R6dd9xoLM75okP4RhopuYZ0/YNx8X9SfDZ2+RgvCERhurbWQkouHNs9KFa4RPT5KGgvdCRXQSMAEhdjQkKcErWTqdjgPP9EuHFSutTw8+rZoY3s5b2MzXlWtmDoAEgw4tk+OWjV1M4UZnT2QJY4FONE/LmeS8z2PRzkwz3U0i/mE+2Q3+mJcZFjGeejZyuT5mdBlvJWHgWh7ChJblqPROWAhXhQuiLB2DLBjTLiC1HmdaggOgxeklfK2xSt2bnG6MoBtfLZeQI1X5B80KcPaLCtLmiyupePIK6yWeA+CUYJgcMHO+Aet2E5xwaTGutgYI3yLIq+Cc4HuJt3ldwtypu6yT+31UC26OlDwqWxcQFr52Exkn2KB5kQEpwPMgqXLKy/HCyKybvdJstyo0pRovt6ohxxDbA2ZYlpiT5IchEnuozFKTUrv0Q2aZvOaTgcCUl0bh22c7NaFOzJzzdNYEQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(396003)(39860400002)(346002)(136003)(316002)(37006003)(54906003)(53546011)(41300700001)(478600001)(6512007)(6506007)(966005)(6636002)(6666004)(6486002)(26005)(2906002)(66946007)(4326008)(66556008)(66476007)(5660300002)(30864003)(8676002)(8936002)(6862004)(38100700002)(82960400001)(36756003)(31686004)(31696002)(83380400001)(86362001)(2616005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWlpZWt0ZXhQV2dSeFFTQjBZdkpYTjdaQ2M1bkJyd3FxWVRMaWd6K0ZLM0lC?=
 =?utf-8?B?cXZIYjB5djUzaFhqTnJXczJWN1lGbERiaG8wM25Kd084R3JEWCtlOGdSVWVE?=
 =?utf-8?B?aTdFMDJBN0lEWFNYclAxS0pPclJIUEgzbzhCQ0twZ01PQmJNMUl6am9wcE1s?=
 =?utf-8?B?TGdkelJ0UW8xWloxK0gzamt3ZjJ3OHdVUWxodVYvS2JVMGtFdWVJay9MTm9S?=
 =?utf-8?B?Wnp3dHZyZVg1MStzZGFsK25VSFMzTm1ONVdFSVBYL3BtZFc5dEQxOTlqOHZT?=
 =?utf-8?B?QkdWRU8za0ZZNm5NMmlCcFRiTEMwZnAxbS95dEEwSzVsemZhU1NrbVpNcEt0?=
 =?utf-8?B?UEl3NkExQWwvTVZUOG1SQjBpQUI1TGM0TE1iWjVwQXlXb1ljRDdOcFN5bUI0?=
 =?utf-8?B?VHVxaVdmSjFsa0gvc0RoL1N2Vkh6Q3VYUGlKU0U2WFhjdE10bUh1d1A5VHJD?=
 =?utf-8?B?ckJrUVBWcEJrZC82MGRPUng3NHMydnVFS0J3RWRNTExIWnhZQmlFOUc2RHNa?=
 =?utf-8?B?ZnBlK3pMQVRKUFhENTlQZ0FaenhXTlRYZ3UxL2VaZlJ0QlJmZmJERzB0bUJo?=
 =?utf-8?B?cU54WkZoeTdBTWhacXYwWGhDQkc1c2FZS3BmVlVtbDd6dzZIQkpFWXQySERH?=
 =?utf-8?B?TkczRVBXdnFOdkFjSmVDaW5YUGVVMkpRQVhWS2REVGhoVXlENGwzVVZpbUs3?=
 =?utf-8?B?bGdHNnoyM1lrQUx2NWg1OGNzby85dUFNcHM1V2hrQ0FPNmZOM2ZtQS8yanFZ?=
 =?utf-8?B?QWxkTDNHVlNBSkRwVlBPZFBJVFNEaTFYMUg4d0xnUEhPd09adU1qMXUvUEx5?=
 =?utf-8?B?bVg1N1BPaUVwd2NiQnh3R2M4RGVJb1QyMy84Nk9FUHVRSHpOYzdPS1NFN2tN?=
 =?utf-8?B?Z0Q1Vnh3WllmRCszRVVTaDlEWTZETndmVUhaVDA4WXhXWXdZZFpiei9pY0ZR?=
 =?utf-8?B?bStzaWNQMURMNU5INEZ0NUNUQi9JR3VaeEhSc2FDKzV6QjE3eGZUWGxqRVEx?=
 =?utf-8?B?cW0xNjNxSlYzV0tYNzMrT2crVmRvRXFzZGtFemYvWTRzTUpvUjdnTG4wR3hn?=
 =?utf-8?B?ZHhacjFDeldQZzlVRVdEVDNkK0VNVnlGTllQdzJ3S2N3RFRnbEoxNE5JWCta?=
 =?utf-8?B?VkdYYzRHWm5rbnVtTEJ4RUlOdmltMFJjYWFqK2tmRWJtRGg4V1JKT0s1MjVU?=
 =?utf-8?B?WTBvQWJaL2NJT3N5ZWlXZUc5a3ZRS1U0Vkc0elNyRnpPdFBQZ1hOcTB1MUFq?=
 =?utf-8?B?T3Y0bTk2RmdYejRIL0N6ZzZrUFJQQmhSRDhPdWdwTGFadUdRRkt4YlBlUUFJ?=
 =?utf-8?B?ZDZGRFNLc3hQYVZTcmFVcDV2VFhZZjM1NlYvSkxOeGRvVVNLWUdRWTducFZw?=
 =?utf-8?B?eTRyNTExamh6SU1leEw0cEZTMnRkbTRqZVpXWlg1MUFSWWNXOTlsSUhIeXlr?=
 =?utf-8?B?UEkxdHZXcEtWYXVOU2sxRjJhUEsrSVZiczJxaGdBSXIxM0RUdDdwa25YNmUz?=
 =?utf-8?B?bDhDRkdXQ3hneTg2bkdoa01DcC9DalZVVnpNNzhDUFhZdzBHTDNjL2NDUFRi?=
 =?utf-8?B?TUhVKzdZYUVpZ1k5UWtWZ2dNSnppQ1hIMjM5UXI1N085cFB6ZnlKbEhpNjBN?=
 =?utf-8?B?bUtBWWRJUEkybCs1QnExemxwWVNieGUxczZvWTM0ajY3cWdnMW5Dd045Y2VX?=
 =?utf-8?B?QlZMR0o4M0RUL1pMS1NBRll1emZjM2ExWXk5U1RLYjl1NEFBL2tYbHhZTDJJ?=
 =?utf-8?B?c1pTeWtaTVB3NU83K0hRQlNTWVRJUkdTNFNraVlpSVN6QnZFbFdtRTdpaUF2?=
 =?utf-8?B?RlZ3Y1AxQ2NRVER4SWNmaWJRLzVtNE9PSm5OOGJwQlcrR0VVcGN1TjBsUS9K?=
 =?utf-8?B?eVFSeldETDJRdDFTalZBTUFaMlcrMk1GQ3ZHSzNSbE45ZjZnVEpKM0srek9P?=
 =?utf-8?B?M2NBZkJGSVQ3THdTNHplSFg3V2lJb2hhakpzMFNyZEVlU3JJMFRENUhZNC9T?=
 =?utf-8?B?Z2N2S28wVmI0bU41dGNQbFFacGIvQ2xWRUF1dTJwL3BDNnVDekNSYjZnaE9X?=
 =?utf-8?B?ZUs5VXFwV1pFRlVCclduTGZDT2d4YUxpQ1BLd2RxcGczYVdZNzVSVWRqREZJ?=
 =?utf-8?B?KzlXVi9IQTN3dTA4UUNqYnlQa3p6VXJNWXV1M2U1a0VKcUI0V0U1S2N3MFRD?=
 =?utf-8?B?eVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3113ced2-c763-4daf-7cd9-08da8c35d87d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 16:20:12.2416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XBvHd54fN75aWeImbCfunPTWCb6IdYDfnA9zToEPYR2l7ji9omfPb67EZ+lVuQmH20JC3VlGxhCi8zuwvQ9PAV0AwiPYqZFpSOPYO3fEsJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0065
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Thanks for the reply. I was able to reproduce it a couple of weeks ago and
I have already submitted a fix.

- Russ

On 8/31/22 22:43, Yujie Liu wrote:
> Hi Russ,
>
> On 8/2/2022 04:42, Russ Weight wrote:
>> Oliver,
>>
>> On 7/29/22 00:08, kernel test robot wrote:
>>>
>>> Greeting,
>>>
>>> FYI, we noticed the following commit (built with gcc-11):
>>>
>>> commit: a37ddddd86037c896c702b4df416bc4e51b2a5a0 ("selftests: firmware: Add firmware upload selftests")
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>>
>>> in testcase: kernel-selftests
>>> version: kernel-selftests-x86_64-4cb0bec3-1_20220724
>>> with following parameters:
>>>
>>>     group: firmware
>>>     ucode: 0xec
>>>
>>> test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
>>> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
>>>
>>>
>>> on test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz with 28G memory
>>>
>>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>>>
>>>
>>>
>>> If you fix the issue, kindly add following tag
>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>>
>>>
>>> [ 103.520572][ T2443] BUG: KASAN: use-after-free in firmware_upload_unregister (drivers/base/firmware_loader/sysfs_upload.c:395)
>>> [  103.520579][ T2443] Read of size 8 at addr ffff8881e186c808 by task fw_upload.sh/2443
>>> [  103.528481][  T395]
>>> [  103.534696][ T2443]
>>> [  103.534698][ T2443] CPU: 7 PID: 2443 Comm: fw_upload.sh Not tainted 5.18.0-rc2-00036-ga37ddddd8603 #1
>>> [  103.534701][ T2443] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.2.8 01/26/2016
>>> [  103.534703][ T2443] Call Trace:
>>> [  103.534705][ T2443]  <TASK>
>>> [ 103.534707][ T2443] ? firmware_upload_unregister (drivers/base/firmware_loader/sysfs_upload.c:395)
>> I believe I understand the problem, but I have been unable to reproduce the error to verify the fix:
>>
>> 394         device_unregister(&fw_sysfs->dev);
>> 395         module_put(fw_upload_priv->module);
>>
>> The device_unregister() call could result in the dev_release
>> function freeing the fw_upload_priv structure before it is
>> dereferenced on line 395. Copying fw_upload_priv->module to a
>> local variable for use when calling device_unregister()
>> should fix the problem.
>>
>>> [ 103.534713][ T2443] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4))
>>> [ 103.588011][ T2443] print_address_description+0x1f/0x200
>>> [ 103.594406][ T2443] ? firmware_upload_unregister (drivers/base/firmware_loader/sysfs_upload.c:395)
>>> [ 103.600112][ T2443] print_report.cold (mm/kasan/report.c:430)
>>> [ 103.604782][ T2443] ? do_raw_spin_lock (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:82 kernel/locking/spinlock_debug.c:115)
>>> [ 103.609624][ T2443] kasan_report (mm/kasan/report.c:162 mm/kasan/report.c:493)
>>> [ 103.613861][ T2443] ? firmware_upload_unregister (drivers/base/firmware_loader/sysfs_upload.c:395)
>>> [ 103.619561][ T2443] firmware_upload_unregister (drivers/base/firmware_loader/sysfs_upload.c:395)
>>> [ 103.625091][ T2443] upload_unregister_store (lib/test_firmware.c:1060 lib/test_firmware.c:1321)
>>> [ 103.630377][ T2443] ? sysfs_file_ops (fs/sysfs/file.c:129)
>>> [ 103.635046][ T2443] kernfs_fop_write_iter (fs/kernfs/file.c:294)
>>> [ 103.640145][ T2443] new_sync_write (fs/read_write.c:505 (discriminator 1))
>>> [ 103.644642][ T2443] ? new_sync_read (fs/read_write.c:494)
>>> [ 103.649225][ T2443] ? ksys_write (fs/read_write.c:644)
>>> [ 103.653463][ T2443] ? rcu_read_unlock (include/linux/rcupdate.h:723 (discriminator 5))
>>> [ 103.658057][ T2443] ? lock_is_held_type (kernel/locking/lockdep.c:5382 kernel/locking/lockdep.c:5684)
>>> [ 103.662909][ T2443] vfs_write (fs/read_write.c:591)
>>> [ 103.666984][ T2443] ksys_write (fs/read_write.c:644)
>>> [ 103.671057][ T2443] ? __ia32_sys_read (fs/read_write.c:634)
>>> [ 103.675645][ T2443] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4501)
>>> [ 103.682051][ T2443] ? syscall_enter_from_user_mode (arch/x86/include/asm/irqflags.h:45 arch/x86/include/asm/irqflags.h:80 kernel/entry/common.c:109)
>>> [ 103.687756][ T2443] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
>>> [ 103.692010][ T2443] ? pick_file (fs/file.c:660)
>>> [ 103.696165][ T2443] ? do_raw_spin_unlock (arch/x86/include/asm/atomic.h:29 include/linux/atomic/atomic-instrumented.h:28 include/asm-generic/qspinlock.h:28 kernel/locking/spinlock_debug.c:100 kernel/locking/spinlock_debug.c:140)
>>> [ 103.701094][ T2443] ? syscall_exit_to_user_mode (kernel/entry/common.c:129 kernel/entry/common.c:296)
>>> [ 103.706539][ T2443] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4501)
>>> [ 103.712929][ T2443] ? do_syscall_64 (arch/x86/entry/common.c:87)
>>> [ 103.717343][ T2443] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4501)
>>> [ 103.723747][ T2443] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:115)
>>> [  103.729451][ T2443] RIP: 0033:0x7f1020308f33
>>> [ 103.733709][ T2443] Code: 8b 15 61 ef 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
>>> All code
>>> ========
>>>     0:    8b 15 61 ef 0c 00        mov    0xcef61(%rip),%edx        # 0xcef67
>>>     6:    f7 d8                    neg    %eax
>>>     8:    64 89 02                 mov    %eax,%fs:(%rdx)
>>>     b:    48 c7 c0 ff ff ff ff     mov    $0xffffffffffffffff,%rax
>>>    12:    eb b7                    jmp    0xffffffffffffffcb
>>>    14:    0f 1f 00                 nopl   (%rax)
>>>    17:    64 8b 04 25 18 00 00     mov    %fs:0x18,%eax
>>>    1e:    00
>>>    1f:    85 c0                    test   %eax,%eax
>>>    21:    75 14                    jne    0x37
>>>    23:    b8 01 00 00 00           mov    $0x1,%eax
>>>    28:    0f 05                    syscall
>>>    2a:*    48 3d 00 f0 ff ff        cmp    $0xfffffffffffff000,%rax        <-- trapping instruction
>>>    30:    77 55                    ja     0x87
>>>    32:    c3                       retq
>>>    33:    0f 1f 40 00              nopl   0x0(%rax)
>>>    37:    48 83 ec 28              sub    $0x28,%rsp
>>>    3b:    48 89 54 24 18           mov    %rdx,0x18(%rsp)
>>>
>>> Code starting with the faulting instruction
>>> ===========================================
>>>     0:    48 3d 00 f0 ff ff        cmp    $0xfffffffffffff000,%rax
>>>     6:    77 55                    ja     0x5d
>>>     8:    c3                       retq
>>>     9:    0f 1f 40 00              nopl   0x0(%rax)
>>>     d:    48 83 ec 28              sub    $0x28,%rsp
>>>    11:    48 89 54 24 18           mov    %rdx,0x18(%rsp)
>>> [  103.753040][ T2443] RSP: 002b:00007fffe4075988 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>>> [  103.761244][ T2443] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f1020308f33
>>> [  103.769013][ T2443] RDX: 0000000000000003 RSI: 00005582df845b80 RDI: 0000000000000001
>>> [  103.776791][ T2443] RBP: 00005582df845b80 R08: 00000000ffffffff R09: 0000000000000003
>>> [  103.784561][ T2443] R10: 00005582df833c80 R11: 0000000000000246 R12: 0000000000000003
>>> [  103.792328][ T2443] R13: 00007f10203d96a0 R14: 0000000000000003 R15: 00007f10203d98a0
>>> [  103.800100][ T2443]  </TASK>
>>> [  103.802957][ T2443]
>>> [  103.805125][ T2443] Allocated by task 2443:
>>> [ 103.809276][ T2443] kasan_save_stack (mm/kasan/common.c:39)
>>> [ 103.813781][ T2443] __kasan_kmalloc (mm/kasan/common.c:45 mm/kasan/common.c:436 mm/kasan/common.c:515 mm/kasan/common.c:524)
>>> [ 103.818190][ T2443] firmware_upload_register (drivers/base/firmware_loader/sysfs_upload.c:160)
>>> [ 103.824150][ T2443] upload_register_store (lib/test_firmware.c:1279)
>>> [ 103.829250][ T2443] kernfs_fop_write_iter (fs/kernfs/file.c:294)
>>> [ 103.834350][ T2443] new_sync_write (fs/read_write.c:505 (discriminator 1))
>>> [ 103.838846][ T2443] vfs_write (fs/read_write.c:591)
>>> [ 103.842910][ T2443] ksys_write (fs/read_write.c:644)
>>> [ 103.846975][ T2443] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
>>> [ 103.851217][ T2443] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:115)
>>> [  103.856932][ T2443]
>>> [  103.859100][ T2443] Freed by task 2443:
>>> [ 103.862907][ T2443] kasan_save_stack (mm/kasan/common.c:39)
>>> [ 103.867415][ T2443] kasan_set_track (mm/kasan/common.c:45)
>>> [ 103.871822][ T2443] kasan_set_free_info (mm/kasan/generic.c:372)
>>> [ 103.876579][ T2443] __kasan_slab_free (mm/kasan/common.c:368 mm/kasan/common.c:328 mm/kasan/common.c:374)
>>> [ 103.881331][ T2443] slab_free_freelist_hook (mm/slub.c:1754)
>>> [ 103.886517][ T2443] kfree (mm/slub.c:3510 mm/slub.c:4552)
>>> [ 103.890156][ T2443] fw_dev_release (drivers/base/firmware_loader/sysfs.c:102)
>>> [ 103.894483][ T2443] device_release (drivers/base/core.c:2235)
>>> [ 103.898902][ T2443] kobject_cleanup (lib/kobject.c:677)
>>> [ 103.903492][ T2443] firmware_upload_unregister (drivers/base/firmware_loader/sysfs_upload.c:395)
>>> [ 103.909034][ T2443] upload_unregister_store (lib/test_firmware.c:1060 lib/test_firmware.c:1321)
>>> [ 103.914311][ T2443] kernfs_fop_write_iter (fs/kernfs/file.c:294)
>>> [ 103.919429][ T2443] new_sync_write (fs/read_write.c:505 (discriminator 1))
>>> [ 103.923927][ T2443] vfs_write (fs/read_write.c:591)
>>> [ 103.927990][ T2443] ksys_write (fs/read_write.c:644)
>>> [ 103.932054][ T2443] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
>>> [ 103.936290][ T2443] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:115)
>>> [  103.941992][ T2443]
>>> [  103.944159][ T2443] Last potentially related work creation:
>>> [ 103.949704][ T2443] kasan_save_stack (mm/kasan/common.c:39)
>>> [ 103.954216][ T2443] __kasan_record_aux_stack (mm/kasan/generic.c:348)
>>> [ 103.959400][ T2443] insert_work (include/linux/instrumented.h:71 include/asm-generic/bitops/instrumented-non-atomic.h:134 kernel/workqueue.c:635 kernel/workqueue.c:642 kernel/workqueue.c:1361)
>>> [ 103.963552][ T2443] __queue_work (kernel/workqueue.c:1520)
>>> [ 103.967888][ T2443] queue_work_on (kernel/workqueue.c:1546)
>>> [ 103.972141][ T2443] fw_upload_start (drivers/base/firmware_loader/sysfs_upload.c:263)
>>> [ 103.976723][ T2443] firmware_loading_store (drivers/base/firmware_loader/sysfs.c:213)
>>> [ 103.981910][ T2443] kernfs_fop_write_iter (fs/kernfs/file.c:294)
>>> [ 103.987022][ T2443] new_sync_write (fs/read_write.c:505 (discriminator 1))
>>> [ 103.991537][ T2443] vfs_write (fs/read_write.c:591)
>>> [ 103.995604][ T2443] ksys_write (fs/read_write.c:644)
>>> [ 103.999673][ T2443] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
>>> [ 104.003930][ T2443] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:115)
>>> [  104.009631][ T2443]
>>> [  104.011800][ T2443] Second to last potentially related work creation:
>>> [ 104.018219][ T2443] kasan_save_stack (mm/kasan/common.c:39)
>>> [ 104.022727][ T2443] __kasan_record_aux_stack (mm/kasan/generic.c:348)
>>> [ 104.027938][ T2443] insert_work (include/linux/instrumented.h:71 include/asm-generic/bitops/instrumented-non-atomic.h:134 kernel/workqueue.c:635 kernel/workqueue.c:642 kernel/workqueue.c:1361)
>>> [ 104.032101][ T2443] __queue_work (kernel/workqueue.c:1520)
>>> [ 104.036423][ T2443] queue_work_on (kernel/workqueue.c:1546)
>>> [ 104.040658][ T2443] fw_upload_start (drivers/base/firmware_loader/sysfs_upload.c:263)
>>> [ 104.045240][ T2443] firmware_loading_store (drivers/base/firmware_loader/sysfs.c:213)
>>> [ 104.050423][ T2443] kernfs_fop_write_iter (fs/kernfs/file.c:294)
>>> [ 104.055522][ T2443] new_sync_write (fs/read_write.c:505 (discriminator 1))
>>> [ 104.060016][ T2443] vfs_write (fs/read_write.c:591)
>>> [ 104.064081][ T2443] ksys_write (fs/read_write.c:644)
>>> [ 104.068144][ T2443] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
>>> [ 104.072381][ T2443] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:115)
>>> [  104.078083][ T2443]
>>> [  104.080249][ T2443] The buggy address belongs to the object at ffff8881e186c800
>>> [  104.080249][ T2443]  which belongs to the cache kmalloc-512 of size 512
>>> [  104.094049][ T2443] The buggy address is located 8 bytes inside of
>>> [  104.094049][ T2443]  512-byte region [ffff8881e186c800, ffff8881e186ca00)
>>> [  104.106914][ T2443]
>>> [  104.109084][ T2443] The buggy address belongs to the physical page:
>>> [  104.115315][ T2443] page:0000000037a5888d refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1e1868
>>> [  104.125336][ T2443] head:0000000037a5888d order:3 compound_mapcount:0 compound_pincount:0
>>> [  104.133454][ T2443] flags: 0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
>>> [  104.141498][ T2443] raw: 0017ffffc0010200 ffffea0005491e00 dead000000000002 ffff888100042c80
>>> [  104.149885][ T2443] raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
>>> [  104.158274][ T2443] page dumped because: kasan: bad access detected
>>> [  104.164492][ T2443]
>>>
>>>
>>> To reproduce:
>>>
>>>          git clone https://github.com/intel/lkp-tests.git
>>>          cd lkp-tests
>>>          sudo bin/lkp install job.yaml           # job file is attached in this email
>> I have tried these steps on Fedora35 and on CentOS Stream. In both
>> cases I have missing packages that I have not yet resolved:
>>
>> Error: Unable to find a match: arping lib32gcc-dev libc6-dev-i386 libc6-i386 libc6-x32 libhugetlbfs-dev libmnl-dev libmount-dev libpci3 libreadline-dev libx32asan5 libx32atomic1 libx32gcc1 libx32gcc-dev libx32gomp1 libx32itm1 libx32quadmath0 libx32ubsan1 linux-libc-dev-amd64-cross netcat-openbsd openvswitch-common openvswitch-switch sendip libpci-dev
>>
>> Simply running the fw_upload selftests in a loop is not sufficient to
>> trigger the error. Can you provide additional instructions for
>> running the lkp tests manually? Do I need a specific OS? How can I
>> access the missing packages?
>
> We can reproduce this error on bare metal by simply running fw_upload.sh.
>
> ~/linux/tools/testing/selftests/firmware# ./fw_upload.sh
> ./fw_upload.sh: firmware upload cancellation works
> ./fw_upload.sh: firmware upload error handling works
> ./fw_upload.sh: oversized firmware error handling works
> ./fw_upload.sh: firmware upload for fw1 works
> ./fw_upload.sh: firmware upload for fw2 works
> ./fw_upload.sh: firmware upload for fw3 works
>
> Message from syslogd@debian-x8664 at Sep  1 05:06:54 ...
>  kernel:[ 1090.872590][ T1293] Kernel panic - not syncing: Fatal exception
>
> dmesg read from serial:
>
> [ 1089.654274][ T1293] ==================================================================
> [ 1089.662192][ T1293] BUG: KASAN: use-after-free in firmware_upload_unregister+0x16e/0x1c0
> [ 1089.670282][ T1293] Read of size 8 at addr ffff88873a872008 by task fw_upload.sh/1293
> [ 1089.678107][ T1293]
> [ 1089.680291][ T1293] CPU: 4 PID: 1293 Comm: fw_upload.sh Not tainted 5.18.0-rc2-00036-ga37ddddd8603 #1
> [ 1089.689527][ T1293] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.2.8 01/26/2016
> [ 1089.697612][ T1293] Call Trace:
> [ 1089.700751][ T1293]  <TASK>
> [ 1089.703557][ T1293]  ? firmware_upload_unregister+0x16e/0x1c0
> [ 1089.709313][ T1293]  dump_stack_lvl+0x45/0x59
> [ 1089.713669][ T1293]  print_address_description.constprop.0+0x1f/0x200
> [ 1089.720107][ T1293]  ? firmware_upload_unregister+0x16e/0x1c0
> [ 1089.725851][ T1293]  print_report.cold+0x55/0x22c
> [ 1089.730556][ T1293]  ? do_raw_spin_lock+0x12e/0x280
> [ 1089.735432][ T1293]  kasan_report+0xbe/0x1c0
>
>
> Could you please help check if the .config file used to compile the kernel
> matches the one we attached in the original report? Here we attach it again
> for your reference.
>
>
> About the issue of missing packages during setting up lkp test environment,
> we wish to support various OS and distributions, but sometimes our package
> dependencies are not updated in time, sorry for the inconvenience. We use
> debian OS in our test environment, and it can install the required packages
> successfully. We will fix the package issue on other OS soon. For this case,
> we still recommend to run fw_upload.sh to trigger the error, because it's
> much easier than setting up lkp tests environment.
>
> -- 
> Thanks,
> Yujie
>
>>
>> Thanks,
>> - Russ
>>>          bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>>>          sudo bin/lkp run generated-yaml-file
>>>
>>>          # if come across any failure that blocks the test,
>>>          # please remove ~/.lkp and /lkp dir to run from a clean state.
>>>
>>>
>>>
>>

