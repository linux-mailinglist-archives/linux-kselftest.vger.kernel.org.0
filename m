Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F957E2EE6
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Nov 2023 22:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjKFVXD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Nov 2023 16:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjKFVXC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Nov 2023 16:23:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CE7AF;
        Mon,  6 Nov 2023 13:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699305779; x=1730841779;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i1Y5FK2NRqHj7Cks1JB4vR3yxabLlqU6eKzHZZMqnDc=;
  b=OUXQfBv4HQ+VpH8i6/ErwBhLPyMTuNnPKLcBK7q70UXNwa6esQBMWkrr
   yRGsVWez1fhF6V16kIbdNkcLXJmgIUAFkpZ7at4FJUBDwo6g5Iv1MuFKX
   ER81qvZ6l3Tv1kIf/NgWxN1Bc3EJyzeIllCYhoFZq+a/S1mqAGLbQoay1
   EH0abZsOITtzH5CsOmBatfNsq1f77WRyTuDxpGCpqbUEAD3KedgQOuAc5
   FiRBBb8gQDE1KYdF6s2aWfUgKZGCHav5iS4SGg6fGVC/o7elCyfHrJ9jr
   95+8x35a9aD7pUArKSXPtQZQrlZPxjgDJCu1yFKf0ZjEtfzlhWbsNjLmw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="393264779"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="393264779"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 13:22:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="762441584"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="762441584"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 13:22:54 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 13:22:54 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 13:22:54 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 13:22:53 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 13:22:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HoT65IhbHBU8caIp+cv/leriOdua3WvSGic4wjQi/MF/a7f8ZLYPmCLgDuptlkhhIvC1gKTEr2H4fLTxxY1sCWrsoXD2PZ4OPxevr27ll4kSONkJj0gNpR/kMGE0eKQSGBO9tIf2/AxytX3EMgfhPwF8kWppCdd4llMc4Cu1pTuxQl78+nY+erZrlKv2uDGGHGJQfptVcWi1N9ulDhZnTJmTUwg1CjptL/YU907qlbL/Ly2FDXw/11z0iQBAptELZtWRp3nyJio9IBHsrMYE8bErq3AhRWL8LcgTZhmVYWpKF/H3arjAAhA0OPEanzahpPvs17NnRSetWuHQKkDn7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaUJeVtg7Y/41H0zV/1shP14IMxcFWQ3DGJpJULpxOw=;
 b=ZviP59gpDmI1yG3zft2kx2eUHk1zQcHvB5zJj0pxUO4EzkbkSgVpgBMKNBF0DoNmZK3Zl4Lserok4xJ+vi/SaZBqq8wFDzEq0DLfXmV4j/XIEVNPpObznxYdf6YAWZ+/4F4eZgA0zu2TUC/KA4VQ2ziOCZYJKhrHgKVLIPI0IET/jB9CYaa7sEI/XE8p17dyD6Wse6NV4CFZ8/LUVU9GffAM0oUsUBa+z1c2LMxwZ0jn1Y+yglDiMyfJxFjCNy2hOoI0lt6AjiuEaXmhpwF91xdYh+pN6XrIqIGuOgYo8the1VHoN3K4zziFSC7N8d8hm9NuxkVyn9IE+kOajTT1Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS7PR11MB5965.namprd11.prod.outlook.com (2603:10b6:8:70::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 21:22:51 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 21:22:51 +0000
Message-ID: <af68ec80-7511-4861-b4ec-0fb9c7284513@intel.com>
Date:   Mon, 6 Nov 2023 13:22:48 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/24] selftests/resctrl: Add L2 CAT test
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-24-ilpo.jarvinen@linux.intel.com>
 <8051f3ef-1126-41fb-b6cc-f48441936dd7@intel.com>
 <2514e73e-2419-7c88-3f22-469db4b2fa25@linux.intel.com>
 <48c6795b-554a-4019-bb8d-a2ca0f6fbb2b@intel.com>
 <4008929-d12b-793e-dce8-eb5ba03b4ebb@linux.intel.com>
 <755ed028-f73a-47ed-a58a-65f4f48eaee3@intel.com>
In-Reply-To: <755ed028-f73a-47ed-a58a-65f4f48eaee3@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0266.namprd04.prod.outlook.com
 (2603:10b6:303:88::31) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS7PR11MB5965:EE_
X-MS-Office365-Filtering-Correlation-Id: 7507d864-780e-4d63-eb10-08dbdf0e880d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eiPOHHopem4ySiRo+I3ZFX1PNFktiDUCZh9x23EFMW5qBnjPBeBL0D1RWDNVICo2neKSkEkt4YGRSwJFdR71NQKXi5x48qzUPn0I9C1FTKOJKRxzcKXCCSKJy50htTbH2RgSmZH1KzdR3ZfctKGiupPz38W8sg78vF9vM0kq4yD57ZU56sA7yKba6YLiOpmqvigzL0m3eocD9edyLu5K+7tDA694cvtFHpspypSVAvViqHvJP6Ay523bFz4OTON71auonChpsEcU9/cO20CFGN6SBwGyoD1KIrLF1qwXQ8bFdT34lnjoIvQqfpFxmxXPc2oMXF5mVy17QnPW6BxDYVGHtYWDznSGQTU4srhqVbhS1zBikRi0A/Z+zQu6c7KwqZt9Jb8DnNaBcKAlkDkutdQHFBkUp2vPufxv0S8ILanl10XhycdBqL1geXLi1bq6gpPLfn5BPkO6OLv+e9tZHB7euCgn5nxSLBts5sHJ5bFg/J8uIDIPSp+6UWIurNfJhjhv6alHTZ+zPGpBPH7MZMkWjmO8wzVPz2fb67JRwMQIUb0InF9AkNjbjupN9X2eo6HjSA0N/OeeUZ/BHqPi0yaRMZfQ2PGuzqZM06oRTE2S1aEeTOtdsDy47b3GIxBtqQPSQtNzrgE2S2V3Xu6GlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(44832011)(6512007)(2616005)(66574015)(31696002)(82960400001)(26005)(6486002)(478600001)(36756003)(316002)(54906003)(6916009)(66476007)(66556008)(66946007)(6666004)(6506007)(53546011)(8936002)(5660300002)(8676002)(4326008)(2906002)(83380400001)(41300700001)(38100700002)(31686004)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjRFZ29hR3dLWVNwRmt6OFdtMXQydHZUa0dxRE1maCtQYk9JQ0FiOHlKU0ty?=
 =?utf-8?B?QmM0bjc4SUFZdlFqZndWeXBXUEhGNjEyRU5Id25yZko0Sk5lUTFqWUJyWHgr?=
 =?utf-8?B?K2Vja294SHIvSlZLT0NwNDFqWHVMc3Nsb29NbjFqNERqM1I4bGZYVSsrQzU3?=
 =?utf-8?B?RVhLWnRlb3lIdk43a2E5THRsQnFZa29IWHpNV3k5aFBOMjFIaUE0aVN5dGd3?=
 =?utf-8?B?UXRNT29jYTdRYk1QRVpRdmE3K0w4Y3FIdEpHRmF0WXlQUUJPWnFWbm1JM2lD?=
 =?utf-8?B?ZXUxbms2Z0FEK0ppd2xWYWptajNEUDFLRjNMdklDL1g3QkZUZ1Q1UmplVzJq?=
 =?utf-8?B?TXQwQnlGWGlXcUNOenhRUmRIbVRXbUNqQWw1TU1qVSsrWXljMzhnVWZ4Z2cz?=
 =?utf-8?B?T1AxVmRkYjJmN2d2dVFFVlV3RGZTMHFQeWFjTExCa0toTTlzMllYOGtPbFNR?=
 =?utf-8?B?UGdaRDQ0YlBINy9MZVpWUVFRZXFlUGkvTnovYzBacU55Q0JRSzc0Rldia1JH?=
 =?utf-8?B?Rit4L3U1QWQ4WTN1Uks1cS95SGp0TkZaOHltd2dzMTNQbEFJaFdUTEpEazlO?=
 =?utf-8?B?Y0Y2ZXZ5ZUtRWE0yQ05YOW9WVzlHd3NLSVJPbHJndytKbTNwODBxNFhlTklD?=
 =?utf-8?B?ZjJFK3VmVENGdTJoR3R3QmFUQkpScXpKNlBaaUJ6UDdKQkRaZ09KUGthb0tz?=
 =?utf-8?B?azMrRlkvZnQzc3pseXpkMkxnTzQzU2ZjSzZab0Z1Vk45bVpkRXgxL2tQUC9H?=
 =?utf-8?B?cHBQclVpZFN5RUcwdzhLYlZxYU83enpwNmgwWG9INnFPc0VNaUJjN2V1NFhJ?=
 =?utf-8?B?L1NZUVJwV0xIQzVsM1FncVZEVHVIbm1TMXQzMmpJOURFRHVLcUIxNWR0Mm1T?=
 =?utf-8?B?eUJKNmV4WnJPbDRjczZHSm1oMHpOOGpPRjF0THRCQVZZYWJCVXdJMnJQVU9J?=
 =?utf-8?B?ZmNWY0sxWmtIaDZ4QmI4TFYrTVdyU0FJaXBibEUvaVpSdS9rNnhGTGFlQkhP?=
 =?utf-8?B?WFg5bE9JOE5GSnpqeWhZY3lkWlhkM1lsZnVhWCsyRm9PV2xoYkx1cXZYZG14?=
 =?utf-8?B?Zlh3RzdFMUNZSENDYWdPWlRmRFVUNWJvczdwcThMV3RiVThoaytTbHZzSk44?=
 =?utf-8?B?NEc4NmN0VVZxUmsxejQ4N0VzK0p2WjdQTmVYOTBUMzF4NXZtQXlnekduL2Yw?=
 =?utf-8?B?MFdQOFcvNkRMSDBSaTNKTkdodTl3eXNOSHFoQlE0VVpJdjhicmNINzBZNGor?=
 =?utf-8?B?a1JXMkNNYUx3b3BFbnJ1aUdRNHZkekk4ZnNtamRwOGFnTnhDajA5L3ZrcUZU?=
 =?utf-8?B?a1lPSUhZOHJEaFJOWGNEUS84dmxsZmh6aVV4T2xNOHpnS0VJQXE2eVBwb3BC?=
 =?utf-8?B?WUF4ZzVRR3dseE5BWGpEaVYranIwNWZ0QzlNMmZIaEJEOFg0U2s4WG9nZ1FH?=
 =?utf-8?B?aVhkL1hXSnI5dVljQWRMQ0J5UFN4bFBpYUpvWEhjaURYRnVDQ2J6UnFWQWJD?=
 =?utf-8?B?RGoydXNTMFI5OTgySnhCbjNGbHZ1QWNObitvaGU0R2FPSVFPd0RNSThqZDFM?=
 =?utf-8?B?Y2Q5MGtOL2RlM2dhYjlEUmFxOTBkQ1RUZEtYejhZTG9ORmJkcHlHamtQTHUr?=
 =?utf-8?B?REtVN1Q1Uk1UZ1VKRHhPU2tqb0VJZVlMWXQ1aUl3bnVzcWlFc045eGpMci9h?=
 =?utf-8?B?TTdTZzRFVk9ZU3RkRXBuQTdycTBKRlJKbVo1YlVza3hNTER2M2xDM3V2MG5N?=
 =?utf-8?B?UmowaDhNVElydytseE85Wmp2THgxVVZqMExsSEJyd1BocjkxVHJQME9ucUxD?=
 =?utf-8?B?UzhFTTJicEFRNnZZajlTMHpDc2xMdlIrQ0pLUllHb2NTNmFaWTdMaFZtK3ow?=
 =?utf-8?B?STRiSXRlSGM2WU45Q3FjZG9lbVRlYWt6bEpXK1VMWWdlcWYrSG1mWDVVa09x?=
 =?utf-8?B?N25HOW9RTWpkSW11TUlDMWxzSFpTR0hXUlZzVFFaSk1lbFNZOWw1NmJqb2s5?=
 =?utf-8?B?MVJDUlh4VEJOenUxNzdRUzVJUDA2eGw5aDBIU3NDWGtaZ0VEN05udU85L3Ez?=
 =?utf-8?B?ckpMRm5XRXNndDI2dVVHRit0YUwwSjVYdUFxRlNsb2htNlJoQmZnNm1uOCt0?=
 =?utf-8?B?aVZWRGgrVmhlZkVNSTVzaUtjdHQ1b3V5ZU1iRnphNTF3R05Zd2VmeWpPL2l0?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7507d864-780e-4d63-eb10-08dbdf0e880d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 21:22:51.0830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nMDuQGiyUCCfuNf5lixb9bqY6da9RTiN8W5lITGQwBW1ufGWgY9z9YBvOYFiNikipqdyWnkfZ7n7cmc2Pfr5Wn4HGoZD8gBw+9kiJ5lyGn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5965
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 11/6/2023 9:03 AM, Reinette Chatre wrote:
> On 11/6/2023 1:53 AM, Ilpo Järvinen wrote:
>> On Fri, 3 Nov 2023, Reinette Chatre wrote:
>>> On 11/3/2023 3:39 AM, Ilpo Järvinen wrote:
>>>> On Thu, 2 Nov 2023, Reinette Chatre wrote:
>>>>> On 10/24/2023 2:26 AM, Ilpo Järvinen wrote:
>>>>
>>>>>> Add L2 CAT selftest. As measuring L2 misses is not easily available
>>>>>> with perf, use L3 accesses as a proxy for L2 CAT working or not.
>>>>>
>>>>> I understand the exact measurement is not available but I do notice some
>>>>> L2 related symbolic counters when I run "perf list". l2_rqsts.all_demand_miss
>>>>> looks promising.
>>>>
>>>> Okay, I was under impression that L2 misses are not available. Both based 
>>>> on what you mentioned to me half an year ago and because of what flags I 
>>>> found from the header. But I'll take another look into it.
>>>
>>> You are correct that when I did L2 testing a long time ago I used
>>> the model specific L2 miss counts. I was hoping that things have improved
>>> so that model specific counters are not needed, as you have tried here.
>>> I found the l2_rqsts symbol while looking for alternatives but I am not
>>> familiar enough with perf to know how these symbolic names are mapped.
>>> I was hoping that they could be a simple drop-in replacement to
>>> experiment with.
>>
>> According to perf_event_open() manpage, mapping those symbolic names 
>> requires libpfm so this would add a library dependency?
> 
> I do not see perf list using this library to determine the event and
> umask but I am in unfamiliar territory. I'll have to spend some more
> time here to determine options.

tools/perf/pmu-events/README cleared it up for me. The architecture specific
tables are included in the perf binary. Potentially pmu-events.h could be
included or the test could just stick with the architectural events.
A quick look at the various cache.json files created the impression that
the events of interest may actually have the same event code and umask across
platforms.
I am not familiar with libpfm. This can surely be considered if it supports
this testing. Several selftests have library dependencies.

Reinette

