Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F207E0B5B
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Nov 2023 23:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377252AbjKCWxe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Nov 2023 18:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjKCWxd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Nov 2023 18:53:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE0818B;
        Fri,  3 Nov 2023 15:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699052011; x=1730588011;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AF06BjmO1AFpyMsQGfaqinxs0LNvmUJHuWK9ucwjtvo=;
  b=fDav7fzTBTCCU2DHa2t9XLvomsQ/a9HJ4myNjyFisSZK9UFP1mSjX55+
   Mh5OHKdDbHuwitVoq3OIggV3DngCphHZaa4NY0zAbyR/QWGXKtDZOAcD6
   Cx8je3bIdafloFsg932d9XmgfgzJc4oHVsBt/mheDEQgd7/rgMKXLsnlo
   hLFn7I9KrB0XFwFxDw7kOl8DWtSj7AEjIcqyHR2yUiI0EJYYV0eMjydMi
   W70CbC3dtRWq2+Pi1mpjLYXMRTfYgRStNM38qQ1ReXSyDoTSXPD/ZgRPg
   tPeAO9XT+bM10Z//NTqsVNhrmsqw0owihnO7+c8DksQJ/BrB3ysSmdx7W
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="10572617"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="10572617"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 15:53:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="765399306"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="765399306"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Nov 2023 15:53:30 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 15:53:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 3 Nov 2023 15:53:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 3 Nov 2023 15:53:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ll4+CGxgTCZzrP47YwL5E3INLPilr61edORwAPd1pau3yVl4vx2lTHJFpdFXhxbv8CpdnUdxuN+HOVZujB0jGIqc7ydiLy1G54t9zE0tVEuchPkBPq32MTimA7vJdCBYG40jhR8Yd5NQLgW7IG23YMsT5ariPs+UMDNlHvVHP9vRirw1BsIPXhwqVsRtnlMPsMZAr8r8NlRLYwdqm2m2R/I17lIBeyxymNvZ+KfemRBnZf28NyurvNlEJ8GLnri3vQS9Ym0YdUvwjHacv8jND2IhJPZvn0LU/p7X5IEL24XrpBs/kUQkoN+hw+l8ehF5BUUM9q4RKJ1fwmASuyjqGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wg85Sc5N/7yEuJyuKl9QiX4ZpiBWNmU0PmyXk5fk/RE=;
 b=jsLOYGe0iASCP/xv1UYETJjUK4sThHPuwGJI1VHk87su1JPJpWQSHF3KWRChm7sb5kIz+bHvaglLAEYEIgTWZeKqSzfgf7V/juTmUn72ygreti2nW1ldasfzrQfhPBBTYC4NbjiCZ8lsKVkjuqCo+GbcGfTxxbjL9ZEaJY2vnxqvJir4Kp2fjsX1/9QfEIxZ6OPaTZBifEVqyWBBRftsnS9PBIMMLK2lSRf1DF0V36Zjb6/TT6mfwrjb11ZxZB0yab29J42qTr38MGzOiBCNQUPEkr7UyBUrNQQuyWXNUAsPIaP4wSNS+tntMTC5BO+IwzHvLFaIdmL3JH17gLakaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV8PR11MB8723.namprd11.prod.outlook.com (2603:10b6:408:1f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.24; Fri, 3 Nov
 2023 22:53:25 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.024; Fri, 3 Nov 2023
 22:53:25 +0000
Message-ID: <48c6795b-554a-4019-bb8d-a2ca0f6fbb2b@intel.com>
Date:   Fri, 3 Nov 2023 15:53:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/24] selftests/resctrl: Add L2 CAT test
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-24-ilpo.jarvinen@linux.intel.com>
 <8051f3ef-1126-41fb-b6cc-f48441936dd7@intel.com>
 <2514e73e-2419-7c88-3f22-469db4b2fa25@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <2514e73e-2419-7c88-3f22-469db4b2fa25@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0208.namprd03.prod.outlook.com
 (2603:10b6:303:b8::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV8PR11MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: 2106a968-572d-4f03-ef48-08dbdcbfafdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 83Ul6Q40omOR8rRv5I5RmuUT8aCoyQknu+pdexiV4N3h+NnLF6427srb1QCWmDECoBThcDIjIJsz4QGTHbtFpMIJi7H/dqPh7cDUszW0uZrQhcL4qxcEBzqghAKnRcAztIoq9yUk3uXlt5+E57vlGLMs1876jOj45xjI3DGCuvJgWKMY0OW1GRGxWRL12po27hC8H+cE0/hlbNdSRbDos6ASWQgGdfLcEakMPyo2JID/ksh3fP15HwtfA5azPdz5GyrLBwbuQN8EJ9JrudjJKJ8GNkFALw2+NIcOaKXPDHf1Q38oTMcDWWqEiYVr+QSJs+LFbAZmLQjNvfs4tqXC+K+0TAmkOqkH/ckYSjbVZAEd+7Rj5tWt4pdQ/PO4Is1j78Z+e6NiqJ0iUc2PGeclsqaxYw+wg9fboDH7r37CImwognnyLtSXlrl0Bv5s/ZHg6WyNXSAeJIfJeB+KaFbQhnYbRjshFf1+rUxt/Emmq6Mk4+zJ3H+q/2b76PexHI6Tluxw0xnhj9eMwbtP2jr6mP0tkTr7DCgF9yWgzNnHJXGPrkPiImG4ITMeG5cCgx7iygj9rJQ+1C+2KVcNpuFwUFgWCYZ5oNeaPhiqxzgkbMJ48fj7BVpDScVEaclTKBhH//xIY5dHoCz7B4oUYymo2j0HAu8klFn9qLnqPKNJAx/7Eqc0AC86ahzKEPpGkoSC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(39860400002)(346002)(230273577357003)(230922051799003)(230173577357003)(186009)(451199024)(64100799003)(1800799009)(53546011)(6506007)(478600001)(54906003)(26005)(6486002)(31696002)(2906002)(66556008)(66946007)(66476007)(2616005)(31686004)(82960400001)(36756003)(6512007)(38100700002)(66574015)(41300700001)(316002)(44832011)(5660300002)(6916009)(66899024)(83380400001)(86362001)(4326008)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnI5OWNZdElTck02VlNUdGpxaHRneFJVajFIZnZwSktQeTNxNXZ5VnBrRHJJ?=
 =?utf-8?B?R0ZyZ1RLY1dxVFA3VzJWdWhvRXBEajdFYVFZeVFvV2JKbkFEN0pBdzFvZnFv?=
 =?utf-8?B?TjRmK0JEN3lhMko1VEpMQWZyWmNQc0E1Q3JEN0NaQWlzbWZZQVlrOEx5YUdY?=
 =?utf-8?B?UjF0LzVJMWdUOWh3YzQ5Q1ZrU0NIcCtuK0lzai8wYXpGWWUzRjBzQzdtandS?=
 =?utf-8?B?MDEyM243alEramxDaEczSmRvTjhkRmRrUWgycHpvM3AxMlB1RXFWSlBMRU5P?=
 =?utf-8?B?bDZuc3p0OVJKOWE5RHMyM3M5WHZLNEpMUnJpV3NiQ0Q2bTVRakdIcmU4UGN3?=
 =?utf-8?B?ZS8wU0dVRXZ5OUlRZ0E3dEk0TW1EdXdJc3p6bEFNZDM1QTVueFdZaXRQTHll?=
 =?utf-8?B?QUIvcXJva09lM3NZU0RHbnJhMkhiNkozditwNTZSeG9UKy91cmMyOHF5MHhC?=
 =?utf-8?B?RlZhNGcwU0RoU3BzNDBkQVB1TTlURFUwTnpWMlU2V041K3NGQlRkdGFUV1Fl?=
 =?utf-8?B?M3lyQmUxUEdETHozN2xZQkI1ek16bUtJekRVdDJmbGM3K0tYVmcxWEpiWWJj?=
 =?utf-8?B?YlY1SFVHcVEwU1kxUGIycDVqTmMvUlpBMWdHRGZmUjBWU1REZWRhR29pMUln?=
 =?utf-8?B?RS9XNEpRdGdUekhpcGNPVGRsYUJNUnVJWWNWNjAzTzZFRzRYNG01akNseXhI?=
 =?utf-8?B?ejhtQXpiVjZyNG9hUkdvdTJpY2kva2Z6MkltditycUo0c2tsMWZVazVCd095?=
 =?utf-8?B?dGVaMUdOWlFjZi9uN1BTUEE2VGJLZmgzdWVJcDR3ZGVrUFArbmFNK25LZXM4?=
 =?utf-8?B?N2hIUkFpRkk5NjBHdGlHN0toUXpxekxSWTg1aVBoK1g4TmtHblZ5Vm1OTWgv?=
 =?utf-8?B?eGpnUDVvNnBzL1ZHQ0grOGRrQTZqRE1MQWV4Yjg5TWZ1b3lvU2NsWHhLSUE0?=
 =?utf-8?B?SXlpR3BpTVEvMk1OZEJxSjdQTC84UjU0MFpFZW1PNHVSQ2VoZFFnZzNrUmpS?=
 =?utf-8?B?ZHlFY205bHRlb295UTM1RVVVRlEyVkFla0hNWWhDR09DSm5zbVhLc1dFeERF?=
 =?utf-8?B?WWRLc0lJZlI0UDhtMmZjeHFWUlcyNnRVeFFlYnJwVzRmbUhHQ3RnT2xEREZD?=
 =?utf-8?B?S3lvWkZRaU9OM0E2dSsxRUVHSS9qU1Q4d3pHUkZMV3pRMmxuNndjUG9ZVnpy?=
 =?utf-8?B?bE9OWW53OG0wMlNTbmRnOE1LMTRvTzNVOTVDNlhBKzhiYkRwYjNTN28waERy?=
 =?utf-8?B?WkpsRXkyZVVPRVM4REJEQ21KUS9RWXJVRlcxV2R4NVFrODIyYXFZSzllTjR6?=
 =?utf-8?B?bEFxdTN2WlpNZTEvZHpST3V2Vm1SYlFTcVRydkNKYUNpV2hSWWZTRlBjM0dJ?=
 =?utf-8?B?YjVUWHY3R2pFb0xSTjlhdzBLTGxLSzFVczhxSkRkNjR1K0VzSjZ6ZWc3d2hZ?=
 =?utf-8?B?bGpmUXR3Mlp4bGU2aExXaGRaN1I2MXZ6TlhoczhRQVJnM0NvbUl0T1hGeWVH?=
 =?utf-8?B?STFLRS9RNWZtVzFnYnRmNndHTlRzRHJvTFJVTXpFR3pJS2FHOE01UkNoMFRu?=
 =?utf-8?B?bDlrQk9LK21UNi9NQTNaZXJVcTBHallJbVB1ZnI1cWxWdTV6dkdBRlQwVEdt?=
 =?utf-8?B?RnZkcnNiV1djazE1OURka1hCWkVXVXBWazJqSnZVdzlJNlMwWUxnZUVUZmQy?=
 =?utf-8?B?NjdsSE1vTmhaVGxtR2QxcysrRGU4RmNnY2ZlUGZPM3RZbFFyWFpFM0cwaDNm?=
 =?utf-8?B?Q1JlT25YNjdUVTNDN0RIbFo2WGlIWlNES25pbGJGSzJDamo0SjU0TEIwUmJJ?=
 =?utf-8?B?NStlV0plZk8zWVdLWUl2Y2phcDBCNU1YbEI2bEhTWEhRY0ZSNDFaK2QycXdP?=
 =?utf-8?B?SXpRUC9rWWh2RDc0NDhsUzRCZnhsUFJPRHhLbzN0SjFrV1hZcHVtOWhQVnFS?=
 =?utf-8?B?bFVERnNZamI2ZlZ4cEY4RFE2SVZycHZBSFoyRDlaVFVlZnBHdEhFbitEN2Q4?=
 =?utf-8?B?d3VMTEgvTnVRaDJtb3hSM3dCdXFiSmNqQ1c1VXBKMFNnNE41cU1Ec2pnbzdY?=
 =?utf-8?B?VlNNZVovaC9pcEpPQzhhVXVzZlNnelZabzQ3a2pjSlFMa2ltODVhSkNoaTJh?=
 =?utf-8?B?RnFJcmt1YzRlRC94K2xLZi9iS1lkdmN1QzM5MDYrTWVJeUpFUStIdDY0bG5C?=
 =?utf-8?B?TVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2106a968-572d-4f03-ef48-08dbdcbfafdf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 22:53:25.1608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSVGVSemYu7jMXAKAQu4WBvVsxv/Gk53dDBLlmZb62Pbs8njKhEAQvU6mXgzjs6ClEJywww74rdaKxLFfdgr4qeqyYmToRtlGwKU5olD4b4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8723
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 11/3/2023 3:39 AM, Ilpo Järvinen wrote:
> On Thu, 2 Nov 2023, Reinette Chatre wrote:
>> On 10/24/2023 2:26 AM, Ilpo Järvinen wrote:
> 
>>> Add L2 CAT selftest. As measuring L2 misses is not easily available
>>> with perf, use L3 accesses as a proxy for L2 CAT working or not.
>>
>> I understand the exact measurement is not available but I do notice some
>> L2 related symbolic counters when I run "perf list". l2_rqsts.all_demand_miss
>> looks promising.
> 
> Okay, I was under impression that L2 misses are not available. Both based 
> on what you mentioned to me half an year ago and because of what flags I 
> found from the header. But I'll take another look into it.

You are correct that when I did L2 testing a long time ago I used
the model specific L2 miss counts. I was hoping that things have improved
so that model specific counters are not needed, as you have tried here.
I found the l2_rqsts symbol while looking for alternatives but I am not
familiar enough with perf to know how these symbolic names are mapped.
I was hoping that they could be a simple drop-in replacement to
experiment with.

> 
>> L3 cannot be relied on for those systems, like Apollo lake, that do
>> not have an L3.
> 
> Do you happen know what perf will report for such CPUs, will it return 
> L2 as LLC?

I don't know.

> 
>>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>> ---
>>>  tools/testing/selftests/resctrl/cat_test.c    | 68 +++++++++++++++++--
>>>  tools/testing/selftests/resctrl/resctrl.h     |  1 +
>>>  .../testing/selftests/resctrl/resctrl_tests.c |  1 +
>>>  3 files changed, 63 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
>>> index 48a96acd9e31..a9c72022bb5a 100644
>>> --- a/tools/testing/selftests/resctrl/cat_test.c
>>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>>> @@ -131,8 +131,47 @@ void cat_test_cleanup(void)
>>>  	remove(RESULT_FILE_NAME);
>>>  }
>>>  
>>> +/*
>>> + * L2 CAT test measures L2 misses indirectly using L3 accesses as a proxy
>>> + * because perf cannot directly provide the number of L2 misses (there are
>>> + * only platform specific ways to get the number of L2 misses).
>>> + *
>>> + * This function sets up L3 CAT to reduce noise from other processes during
>>> + * L2 CAT test.
>>
>> This motivation is not clear to me. Does the same isolation used during 
>> L3 CAT testing not work? I expected it to follow the same idea with the 
>> L2 cache split in two, the test using one part and the rest of the 
>> system using the other. Is that not enough isolation?
> 
> Isolation for L2 is done very same way as with L3 and I think it itself 
> works just fine.
> 
> However, because L2 CAT selftest as is measures L3 accesses that in ideal 
> world equals to L2 misses, isolating selftest related L3 accesses from the 
> rest of the system should reduce noise in the # of L3 accesses. It's not 
> mandatory though so if L3 CAT is not available the function just prints a 
> warning about the potential noise and does setup nothing for L3.

This is not clear to me. If the read misses L2 and then accesses L3 then
it should not matter which part of L3 cache the work is isolated to. What noise
do you have in mind?

Reinette
