Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9176C57DF
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Mar 2023 21:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjCVUme (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Mar 2023 16:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjCVUmL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Mar 2023 16:42:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D897848F8;
        Wed, 22 Mar 2023 13:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679517284; x=1711053284;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+dUJAOTEW4Pi6QjsoVksUp2U1wBF3oaCmYTxh4jKlOk=;
  b=Odf4CJAUdMbf6WQR9qYQY4ruJ1sWqHLvEPv+NhOrAqCqazA9LbIsaji2
   5oYCQ3ybkGY/IABBoZbIVFJjprVkVeAV4NOC+6ORoa47quj+Tk4JAjxc2
   KMSdq1hNjWVbB34kjT6TBO551ws8oHjQ79P6oblhvHmePxJQ2nzQQGQtX
   EdGL6Ay5ZmRRgDAzx/XhngN3K6e629UV8DMBrpF1MSVfFYlx1vC6t+WxG
   gnSIB8r6RpujwdeBOV1+Q/rXWKjvR98JnBzGso/p1SIx9t6J35xK2gNbz
   4Na7ADtaVJfWk/JkCdX9jc/1/1TibcmNkYVqtvMGNb7kPI0x+7NDcWTFA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="339362657"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="339362657"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 13:34:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="825550267"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="825550267"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 22 Mar 2023 13:34:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 22 Mar 2023 13:34:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 22 Mar 2023 13:34:36 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 22 Mar 2023 13:34:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0B39LgEp/nRKEtweLudFLXC934khbLE5cX3AX9bopsrI+bx8f2v4imx7JdmuvcTiewqYwC6ZeuFue3yR2GT/QAm+WzlQJ+8HLxDX1kE3vdtbW0RW6YQhDdhJzmgxDJJniFEnwK1EhajlEP8m9jD/tTalZ9ePsVn1T1+G4BNQ7A+ba/ad50tTKC8UnGh3yxNXU8ayG/IObXHVYvNzoCHIh9A4q2cfWyQsehzAEnUxJGfwOcF1SXrkQxPSJljC4nk0TUm5Qwo4QSku3nq9zHtoQQ/LGqqe+/WSnZJP9Lp/T/h7Q7C32i33HuAojdBrZIllwUbMiZJkB7lFKzu5ti+PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6TGyCkKn7X9IZ2KRYwIHI+lvaOxyzQsemhpvkHSvcc=;
 b=hbEWSHVUkiIrBjMQf2nKqVicbzOp9g8l/OjR5leadWdWpjuwJG32t93LJbUvAiIZ8dho+krN/lbvBmvgqmczgEARLQUvTZJJKXySJpC7PtygsVut20PrH1AcmOD9MSVuEitnZg7jaN9Likgi2NJcZ1qcN2p4fnmMK3QUTxyTaxFSLbOxJEmpq5fYDgeBLnmB3abnKydqbWsOZBm/+XMn6hYt4wo1SU7dZPhWkD0ukfxpedCcOzX4+pgxuGcG89vDE84KDnXctcXdpGU7KG+w+91KLcbYjp+XosA/S7Z70Bqtw3Em1yQXNndR+DtnvElvUH8sGAiSEiy88rYRGfjDIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SN7PR11MB7511.namprd11.prod.outlook.com (2603:10b6:806:347::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 20:34:34 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.037; Wed, 22 Mar
 2023 20:34:34 +0000
Message-ID: <71b0d889-85ef-3f20-3358-c351be97ce84@intel.com>
Date:   Wed, 22 Mar 2023 13:34:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v8 0/6] Some improvements of resctrl selftest
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20230215083230.3155897-1-tan.shaopeng@jp.fujitsu.com>
 <7dcfc21e-9a17-65b1-6206-374cadb79973@intel.com>
In-Reply-To: <7dcfc21e-9a17-65b1-6206-374cadb79973@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0057.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::34) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SN7PR11MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: 911ca887-25ba-4d3c-2075-08db2b14d8a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pwXhPfe85p+yzaKAl5II86CJd1zs6wsgbFeNUyAD+O9ahNvtE+60QaYFS0qo/6UFBQ+KLBSJicNnTqZYJKHRMqM19BR9CUxtl//Kkn2/+2sfPaWrCBN+gP2/v/eU0Oy82JGTsctuabwDNEuvICH6yeQZUC/Ef2OUnQvpLlHx6ea4ATOuNSIRcY8Fdi17evDbzzGY5gq5+VGjw+kHlZhfNZSgcN4ZjEaWd4DulAFvy3jX70NzPBZ+2mEcV6rm6GXGefmohJf+anW06YFfGC5DR7L0hFlIjgkSiE1eUylEcCHrDpGKDMdSZUdRxdIrkGO9rKVV7T3Nnzarq2H/xrMpYiVbhy+xrL2jwt1u/Cw1JO7Qt42eb/COTWHezBx1h5d/+TMRFk3OSCSdZGAGE1lkG3S8sHaEZKIrMT/ut9M+KhJQImB5sjmv7FU4ckBcdVLvpRpLdpHzFsaRr+r6DrfkMQoVYNN3K2CS1eq7bAqyvzJyUTRNuCDmJu8yLrKEyWFo+Vyldp6S8aZ6BD4mhEL0FZdREcv6F+5NZrhJne3Zc6nnB9W7jJhbVDU8CF6yQ2P0+6l09sruYHqFWb+sOmu4//t2PiWCZ8A3ZsDRKjbB7fO2ul6GP0xIn0j4khP6UWXQVYIifBKKX2ULEEW4ENm1Yoe4MtLYePubtNLRg4UddIvuLqrQAnOsGC5n1WvTw8MSFjQEDpp7Pykm882PengGSic9YN6FhrZfnquRiPTirqymvi4xvb8HvHDd2wNQVbNQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199018)(53546011)(2616005)(82960400001)(31686004)(186003)(6666004)(6486002)(966005)(6506007)(6512007)(26005)(83380400001)(38100700002)(86362001)(31696002)(478600001)(2906002)(8936002)(44832011)(4326008)(110136005)(316002)(41300700001)(66946007)(36756003)(66476007)(66556008)(8676002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFdNRExIKzZ1K2ZXeHJ0TVNIaThSRkNBN0xZRTRqR0pwSGpObVBnaWlJQWZm?=
 =?utf-8?B?ZUtLaXpXZFdVdXNRUlVlRTJSb2FFVFJoZHdkOGJvV3lycUhjWXJSbElHNGI1?=
 =?utf-8?B?VnZaR1RHVkpFcXBqLy9jWXhISWlxVmlLa2ZxUENYVkRQa0dXclZZV1RlZmxD?=
 =?utf-8?B?N0s2Rys3dk9vM2wzd3NIcUlKZ2FHMW1sZ2I5eDhJZHV2V0lrRkdxQ0d5UE1u?=
 =?utf-8?B?Ymc5cEhkd2RVUDVJOVhURzg5QThQQzBZOUVFY3BmMnNSUE5XczlES1FQS05n?=
 =?utf-8?B?VXZ2TEI5QnZPSXFaTTZpV2RqbVQwMFBFWDJNUUNoL1ArcjZpMEdlMnM4dDFJ?=
 =?utf-8?B?SWl3TkRQTTVDTldWUy9ma2szQUZYQjBKM1RCTmhlRmxFZ0tXdkgrR2tHWUI2?=
 =?utf-8?B?allpRnc1L1NDY0hjcFFtaDVWcUdvMjgvbG93eHpxMWNxUWhxbGFpek5uQk5i?=
 =?utf-8?B?bUQ3QXJITDZiZVRsQ2lvWGFaK1ZjYUdXNlBnZHV3ZDdWbHBudm9JeHY4OVRN?=
 =?utf-8?B?OG0zRHZPeGtkMFJoZlhyNFdrYzRjZHZhWU1Xa3JLOXRySCtrb2lPekVJTFZJ?=
 =?utf-8?B?UjNUbyt1Zm5xTko1SmlNakhMbTZ3NXZ5QnhmbDRzbE8wS21OUHU0Ni9KamF1?=
 =?utf-8?B?dnNGeHI5aE14WHRNUUFpNzBUU3V6cWh0SmlUaG9BZ3lBekpiZHhqUzNQNlVx?=
 =?utf-8?B?RWEvTTNmT0xLbGdOQ04vY0hraE10TDVvSFpNdlpnWnVMUExMOGt5cVJqUWdL?=
 =?utf-8?B?RUNJRG9HUkNXTmw2eDdHbVJHVkJ5NWlnMmxYTGl0WmN2MU1xM3o5enBmSFow?=
 =?utf-8?B?eVR6WmkrcEtaMTdyNnJsemZMaVNpVjM4b01BeWV6U0hCdWw5YVFmdnFnVnRM?=
 =?utf-8?B?bDFaUFdxUEJtaEVOaU9PdE55dGpxSjM2VTlSd2x5QlVmWjRVcS9TcHJMblYx?=
 =?utf-8?B?ME5oNEdsWkExdUYySjRDZTQ5UlNFSndRRFlYWFlTS1gwSVJWaXl2c2lMT2RL?=
 =?utf-8?B?aGs2bjdmNkl3QlFFZXdHOXpLMUhTV240dHJ3R0R5VzQvSE9QWTZza0l3SWZq?=
 =?utf-8?B?TkRVZ0grU1FHWjlNZ2c2bkN2aXVlSE5xY2JIQmw0VkZycGc3UmZGNnlrVUFo?=
 =?utf-8?B?VVN6eE8rMmc0bkxPTE9Hb04rUVBqcUF6cmdsbXhUQUU4b1VOTm8wTC9mWllz?=
 =?utf-8?B?OS9GenduNmFxakRzL1lqUEFnVXFzc3R4WHhYWXZnNW1WcUhwUGg2czRWR3Q0?=
 =?utf-8?B?bmpwOHp6ZTV1Y24rYmYvNTA5UGQ4bi84MStLNXFjYlpyT2lTakhCbEdRbWcy?=
 =?utf-8?B?bWZrRVJjMGN5UHhEblFTN3AreHBrb1ZkMzkyVTZXdTg3Y1ExdzdxbVJUbGpI?=
 =?utf-8?B?citZai91MEJIQlpGQ20xd2NTMzlqeG95QmY1TDlMeEdib2tFaHozdXMvTStI?=
 =?utf-8?B?RU9IS201NURhbFBGbGxoVFE3b0pEdnE3bGFMbU1Tb1hmYzhtSG5jUTZOUUts?=
 =?utf-8?B?eW9CeEM5aWgyU29wSG1yeWJIaHluOEZiV3k5ZW1PdTVVbGhaRS8rQVFwTUZW?=
 =?utf-8?B?ZkpmYWhsb2hqK2ZzWXB0c3NmeHpYdTJibnZHQVRhSlA3YXVuU0x3VDZjd3dX?=
 =?utf-8?B?K1VObFBTS1cwNmltWGltR0tWSDNvUHpGSDZlcjFYazMrREFCQ3JpdmZxQ0tz?=
 =?utf-8?B?VE4wVzFBQU5oWHFFVFNpR1c1SVRXMVM0TjlYb09zWjNkL0ZKZG9iNmpYRFZZ?=
 =?utf-8?B?M2dHSXNWU1RlQS9QYU9uYkQ0WVlSYndlYUVQczhkMUtyZUl1d0djZ0liTVVL?=
 =?utf-8?B?eTZBMks2aEpnNHJZYnZwdzJPU3c0OCswYkQyTjQrMUIwK2xNYUdBbEVFVkxS?=
 =?utf-8?B?RmgxK0lpMzQycWhUVjMrMVY5eHFpRC9hbEh6VVJ0Z0ZFNVpqVGlzVXVLSkF6?=
 =?utf-8?B?RFdaYkhCcTJOOTZBNXd6OTYzY1BhcDJiNUJiWDAxMENSeE5Bd1d4ZER1Rm1y?=
 =?utf-8?B?dGJGRlFFeXUyRGhZR3c3ZkdlUFdRak5vZUlSU0xDY0tlRFpmMEs2QUcwQ0xh?=
 =?utf-8?B?ZFdpOWtKSlJybUpvU0R4em91bzIwZk1XQlcxaGN5VkF1RG5wa0p6NGJ1c2NG?=
 =?utf-8?B?TWhoR3FGUDE1TDM5V2lQbWEwaHBnaS8rTzhyeFg4L01wdWdwR2FWZ2d6UGtF?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 911ca887-25ba-4d3c-2075-08db2b14d8a9
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 20:34:34.0016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Me6CR8JT1C1ovYWAGsQBKdW0UWRJWO+2DJnbqPtN/mboZSrS0VO2uW+1cxG8qeE/cbijhvK5t9Bli/C0AFtCUOeGqpyvnmXKEpDX0VXe6KA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7511
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

+x86 maintainers

Dear kselftest and x86 maintainers,

I am wondering about the appropriate path for this series and
also other pending resctrl selftest patches. Would you prefer it
routed via x86 or kselftest? If x86 I expect that we have to do
a better job of including x86 maintainers in all resctrl
selftest patch reviews.

Reinette

On 3/10/2023 2:25 PM, Reinette Chatre wrote:
> Hi Shuah,
> 
> Could you please consider taking this series in via the 
> linux-kselftest tree?
> 
> Thank you very much
> 
> Reinette
> 
> On 2/15/2023 12:32 AM, Shaopeng Tan wrote:
>> Hello,
>>
>> The aim of this patch series is to improve the resctrl selftest.
>> Without these fixes, some unnecessary processing will be executed
>> and test results will be confusing. 
>> There is no behavior change in test themselves.
>>
>> [patch 1] Make write_schemata() run to set up shemata with 100% allocation
>> 	  on first run in MBM test.
>> [patch 2] The MBA test result message is always output as "ok",
>> 	  make output message to be "not ok" if MBA check result is failed.
>> [patch 3] When a child process is created by fork(), the buffer of the 
>> 	  parent process is also copied. Flush the buffer before
>> 	  executing fork().
>> [patch 4] An error occurs whether in parents process or child process,
>> 	  the parents process always kills child process and runs
>> 	  umount_resctrlfs(), and the child process always waits to be
>> 	  killed by the parent process.
>> [patch 5] If a signal received, to cleanup properly before exiting the
>> 	  parent process, commonize the signal handler registered for 
>> 	  CMT/MBM/MBA tests and reuse it in CAT, also unregister the 
>> 	  signal handler at the end of each test.
>> [patch 6] Before exiting each test CMT/CAT/MBM/MBA, clear test result 
>> 	  files function cat/cmt/mbm/mba_test_cleanup() are called
>> 	  twice. Delete once.
>>
>> This patch series is based on Linux v6.2-rc7.
>>
>> Difference from v7:
>> [patch 4] 
>>   - Fix commitlog.
>> [patch 5]
>>   - Fix commitlog.
>>
>> Pervious versions of this series:
>> [v1] https://lore.kernel.org/lkml/20220914015147.3071025-1-tan.shaopeng@jp.fujitsu.com/
>> [v2] https://lore.kernel.org/lkml/20221005013933.1486054-1-tan.shaopeng@jp.fujitsu.com/
>> [v3] https://lore.kernel.org/lkml/20221101094341.3383073-1-tan.shaopeng@jp.fujitsu.com/
>> [v4] https://lore.kernel.org/lkml/20221117010541.1014481-1-tan.shaopeng@jp.fujitsu.com/
>> [v5] https://lore.kernel.org/lkml/20230111075802.3556803-1-tan.shaopeng@jp.fujitsu.com/
>> [v6] https://lore.kernel.org/lkml/20230131054655.396270-1-tan.shaopeng@jp.fujitsu.com/
>> [v7] https://lore.kernel.org/lkml/20230213062428.1721572-1-tan.shaopeng@jp.fujitsu.com/
>>
>> Shaopeng Tan (6):
>>   selftests/resctrl: Fix set up schemata with 100% allocation on first
>>     run in MBM test
>>   selftests/resctrl: Return MBA check result and make it to output
>>     message
>>   selftests/resctrl: Flush stdout file buffer before executing fork()
>>   selftests/resctrl: Cleanup properly when an error occurs in CAT test
>>   selftests/resctrl: Commonize the signal handler register/unregister
>>     for all tests
>>   selftests/resctrl: Remove duplicate codes that clear each test result
>>     file
>>
>>  tools/testing/selftests/resctrl/cat_test.c    | 29 ++++----
>>  tools/testing/selftests/resctrl/cmt_test.c    |  7 +-
>>  tools/testing/selftests/resctrl/fill_buf.c    | 14 ----
>>  tools/testing/selftests/resctrl/mba_test.c    | 23 +++----
>>  tools/testing/selftests/resctrl/mbm_test.c    | 20 +++---
>>  tools/testing/selftests/resctrl/resctrl.h     |  2 +
>>  .../testing/selftests/resctrl/resctrl_tests.c |  4 --
>>  tools/testing/selftests/resctrl/resctrl_val.c | 67 ++++++++++++++-----
>>  tools/testing/selftests/resctrl/resctrlfs.c   |  5 +-
>>  9 files changed, 96 insertions(+), 75 deletions(-)
>>
