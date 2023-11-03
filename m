Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA0F7E0B6C
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Nov 2023 23:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377274AbjKCWx7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Nov 2023 18:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377760AbjKCWxy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Nov 2023 18:53:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB72D65;
        Fri,  3 Nov 2023 15:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699052031; x=1730588031;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/JhAaR9IO457t2BSocK3AeyFQFpdJcFavDx6zb3/3kY=;
  b=PLQ1NKFqDMkbG4oropp/ZG2leyjz5KJlG2Rl8MVLZsQzZybY7+sfq3U4
   cufeVrz2J72M2Swlojs1T4123IJqZzWzvPuiFhkbE/NikDa4g5FBp7sI9
   EfQVSOanzgcZ8W8fsN3nfcf2x527YwH9qzQEGqslr7dxc8rmXKn1xmxgJ
   Nfyru4o2Ik/eyNHM/kzbCOhYBhi80DD3POGPSvOLh2eRnU12lRuJRUVi9
   +oAhr/IB7AhHsK1uWlFOj9QQ1KXYPnKoMgvQrCaxkTPEqmgQf4CkaIwP+
   LBHWYyWE/MUArG5FtIvItq1PxxpCAyWmI2/BxkIWEqpBVZcyzMrrGwqgU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="453339289"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="453339289"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 15:53:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="885342224"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="885342224"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Nov 2023 15:53:50 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 15:53:50 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 15:53:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 3 Nov 2023 15:53:50 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 3 Nov 2023 15:53:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVkZjAjUQM6T9WoPLvl8T3uTzgNhqSfhyd9Uuds4/FzWI5HYp+Y4Sp+SWheQJoe0piKC3yaEDraWNcp5GOO5PFhP56M1tVSqQ9SGRzk1vxwcEFfoJgEijmCnzmbt7dDEewFisC9RPdxprl+xK3IhziuYQ1nf1WK9zvCLwtO5r3T7BkEqxFrQJ7Y9Pqf1P1vgiUz53CLXB5p1hnE4bwWScezSiLCi89StHX6OG/Hl/nFMHT4sm0GKGNcHLjQ4udGAxdGsWf0DZhFHQFKj+1hfYYhYg8Sm2Uzy3Cch0avPmREQGF9tjtKLZx+2LKABZuvOtYxXv31vIoP2aNEZRn+cSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqZqEIgmFBpJlgDaZfANMc8q7fxdiLAdnFveguW+Urs=;
 b=Zp/b8SujNDKivcLJjkKdRmUBBU/FPa094Q6yuPJoV00bnO50/oUSkdDxHzaVBDjRBdWRWnp2MacKYhgIj2V6I3ADX3rO1dYAjL44xJCB0mWxWaj0d9Bmjj61tFCeNL1WXb78wmwY4HIDjGdeTvj8tZ3mWmi7ixEf52ZOVrXS9mHRceXS2/OcXvSX2ASlJygyWPtq2yOUoonOs14/HQuFDfUtV8cpz8r/vi+bUBxY0xJZsUC8LyeEPl/i5vkLqpeG5Bv5hS+QpwBJRT3qrseBIfqBbPpJWy2cuJFLcsf3Ju3WT0CIq4QxKvtm356Z9uPn4ICDt+9mXnnJLJI4CcVStQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV8PR11MB8723.namprd11.prod.outlook.com (2603:10b6:408:1f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.24; Fri, 3 Nov
 2023 22:53:42 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.024; Fri, 3 Nov 2023
 22:53:42 +0000
Message-ID: <721c6735-dab9-49c7-bdb2-b34388144e21@intel.com>
Date:   Fri, 3 Nov 2023 15:53:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/24] selftests/resctrl: Ignore failures from L2 CAT test
 with <= 2 bits
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-25-ilpo.jarvinen@linux.intel.com>
 <a5160a37-7778-49ff-8c25-92846d42e87e@intel.com>
 <6426a6be-5e92-6c5d-7025-6308c1f3c24@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <6426a6be-5e92-6c5d-7025-6308c1f3c24@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0208.namprd03.prod.outlook.com
 (2603:10b6:303:b8::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV8PR11MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: e92b0024-d8d1-4680-ce1a-08dbdcbfb9db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GlV9c3BJg4In0mDLU24LKXO0sQPDjs2Qy9xfh83szG8Qdjvd5aJ4ggbCVK5b5P1Hxq//miGLKSeLPIWgGiVlHPUwXfH10wLxdHY2R8BEqriwiHDtK7zRIHHfGac0ln9mNdDzfFO8GO3sMcTbmoWgLxygoB4x2bHoVkbUb+Qar9dM2pi9sx6lYrlwnR9Sj7hNonmWgkyi4SD3z+2JkZmtx4Jm5AaqRVug8q3B/YaOO4MoeZ0rNjb9llOx2NqC7w/xqBtgBBnOO02P16JLtJuiwp15PN1TmIUb3Y3i6XfqSPz25wSH3ivVSe4GJnczjCBwD7RwVPN/mzGhLZ9KZPO2BmkXwn3wI4LmzvEfmKsnQETskuoa/KulJCC52aHqIh50Z0EjS7ZouJQcVyJZ0ZjQ/XsQDDctKONL/45VonQhogTJ3F41gKdxrzp8YfRzUBunkU4rB2CYrC9ekNLUtF7b6sD6VsL6Ro+HPrdzkFZuDwz3qB2kJfRJhuC6gXj1Xb6Lr0pyGgZ6geexDswJ9wIw857nYHoMsUsoUnelrA7FNPaFOKa7FTWmBiFE2RnYTGIJnZDgeGsxa3ZAj7Lcaf7P0EM1bXE94hMbfxNNb5+UnKbPxhQWKDzUbfN33m/F4TQ4kreRbdnNmCOLdM/R+jdP6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(39860400002)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(53546011)(6506007)(478600001)(54906003)(26005)(6486002)(31696002)(2906002)(66556008)(66946007)(66476007)(2616005)(31686004)(82960400001)(36756003)(6512007)(38100700002)(41300700001)(316002)(44832011)(5660300002)(6916009)(66899024)(83380400001)(86362001)(4326008)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWlWWFdicGJZSWc3bThwUzIraDlXQ1JhMXJ3VGFJbXhzTlhKQWxMVVpEamVK?=
 =?utf-8?B?TTRSd3d3aTVnV08xQ2cycmVxR2FlUVZGSFhGUWU3STduVTl3RVlMQmYwRUFT?=
 =?utf-8?B?T2k1VTUvRlcrU2ppTks3eGI0U0E0cFJFSGx0RWhhTkRVSnVtdTBHcUJHZjJT?=
 =?utf-8?B?c05ZNXFCOXB2dUtaOWxIb1hFNnE2RmhzamRDTzQxbEFsY1E2bXFocWNZaEJW?=
 =?utf-8?B?bi9BRFBTYno2QnRrZS9MNnlnc3BDZUQrZVpHMkxYbjhpcXZUbGYzRGRhUkE0?=
 =?utf-8?B?RE9oVm0zaGk2dnY1OG5CSElKYjV3MVRNWE9yUEFnVmlzTjhrQ3JBU2NTQUNB?=
 =?utf-8?B?YUp3R2hZZ28ySUFldjZOTElaWEg1RmxFV3cwZnBJVDdBVDU5dnpjU1hKbERi?=
 =?utf-8?B?Z01tVTc2U1UzZFU2VGRoWFBabTc1ZjZhTGRFeFpobmVrQldwOE13eDBFcFZG?=
 =?utf-8?B?VFV3amwrdzM0WE5vbW5JcTcyQ1dtOE92V044SzFSVG5oc0Fsa2d3cVkxRENN?=
 =?utf-8?B?czhBWUJQYWZIUFRWWTU5VDM2RHZkV0F3MGY2VDBUR2dvZmFDS3BHNGRSakpL?=
 =?utf-8?B?TEduNGpGdGZ3ZG5kWDV5UjhEdEFBbHljaE1GWkZISXpLUmh2V0d3bHBRY2VG?=
 =?utf-8?B?QThaYkEzRVo4bk9TNGFhcmxhOUF6cjd4MXlBVytxVlAySUZzS3Rvb3BJaVRu?=
 =?utf-8?B?cUdvRUYwdGJUVGMrWUJHWHdFZFhmZzlMVUViUHNNOFpHYndqVE1XbHlSeTV4?=
 =?utf-8?B?MGVBOFlrYWIwd2E5M2VudGJoY1c3T0hwamhReWp6TGV4RUpJY1Qrc0QzL0JL?=
 =?utf-8?B?bXlPQk92VHQ1WnMwTGRFN3F5a0NhRVFoQTNRdlJFcTE5Q2IvdE5Fa0hRVDJs?=
 =?utf-8?B?TnZJdnR1QlZncjRTcFlKcmoyK082anR0UkhPa3NhdENwTFFnVzE2U2pTRUR6?=
 =?utf-8?B?VFlQakRrUGw0STNYVlJmVGkxQzJqUXl6dThUWTdWdnI3QjZ4MzBBS1I2dFU0?=
 =?utf-8?B?c2lRUWhWRHdtd2lHL1NtdE80NWd6dk5ZSE5RRkJhRkhycCt3T2h1Y1NITkF0?=
 =?utf-8?B?b25rQ2xFNkZPcWlsT3NMOXY1dDBwcnljaGhtNXY0OEI4cWxHRVNRWmRsa3pM?=
 =?utf-8?B?bGUxc3VXWG1sRzMwUExWTzRXdVZwTEFZaDdlVWZiZHRuRjZoV3JkaE1lNUhU?=
 =?utf-8?B?SE1qN20vL3hSK2ZrbHUydmtNOW5rRlAvZlJ0K2Z5OFJtZURDRTIzOEFlb0h3?=
 =?utf-8?B?dUE1WCt4STdOblAzODlSZ2d2d0ptalRRdlR3UldSZVRWaWQ2VER4SzNtbHps?=
 =?utf-8?B?Rm14cU83bENnYmdreEZiWVFDMFU3UkFkdnVGSWFxNko3MDhNUHBadmlNeE05?=
 =?utf-8?B?THhMLzhBK0pyWHF4eTBMMVNLRk1HNjJ4Y3NxaW4vZFZ6Q2RlOVV3NHEzVDJT?=
 =?utf-8?B?V05wK3V0NTdpeUxjV1Q3QVcyRlBZWE9HSGtWWG5kdEhQQjZ2QmxDTDhvb21p?=
 =?utf-8?B?RUdWM0hBcDB3ZGE3SjJhTDV1MGpGZmpXUWNRTnUxWjd2WmhsQkdkQTljcXhs?=
 =?utf-8?B?RnVHVFlGN3Ava09KY1hKQ3daRXFzOWJ4L2tsZVdFZGhoZUsyNnFIcFYydG9E?=
 =?utf-8?B?dnVxMURDd0dwQXd0Z0cyYzNKanFSUTZ1OElMWVVzUC9nK2I0SGgwQVFQV0Vv?=
 =?utf-8?B?UTU3SFRYMkEyYXowZXN3UnpXNFlhcllMWU1DSXpLcUgzQVNJa1QrMXBkc3Bh?=
 =?utf-8?B?bWdEMzhRYVY0Q2tiVXlVVUorU3h4SDA0YVZTTUoyN3BDMXFUdGZnNnhOa1k0?=
 =?utf-8?B?TWVHelQ3Ukk0YzVIcFB0MitSV3FvQmlJTjB1UnU4R3RNUU8yVW5NYzJWMEVG?=
 =?utf-8?B?aHd6bnludTNndUdMZWtqN3lwVTRqNUZxbFQ1VHBwQVhRTkpyTXlEYjRlYlNO?=
 =?utf-8?B?cVNRM0NmcTJTdlpjcllDNE4zZFNmaDhwdktjMVVzTDdLcklJZnRzWE55RVRz?=
 =?utf-8?B?YW9nRTc5Tm1LNjRwMytNalBCRWtKTzB2VEp0dDF5M1pNemZxaFF0TkxlMGhI?=
 =?utf-8?B?Z080S0xZRWhaTFJSOUdxa1JjaVdYODhSM3ZvZXZldjlhbVZvcHFuMW5LU29B?=
 =?utf-8?B?L1J0b0NDSlBvWElyYlFTSitNK096dVpFZnFtU2NWUmMxdTNGczFwTzZWWjdy?=
 =?utf-8?B?Q1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e92b0024-d8d1-4680-ce1a-08dbdcbfb9db
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 22:53:41.9399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDFFbaKA+E2oIIu9ql4DwqrD7d7lOyzigiqe3n1OBR9Ae3fl52KwXtbYvbwu0+CkxX8aBmUQPDmydGVfL5a9hPi1seT8T3ZG4GPz/Qb1hTQ=
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

On 11/3/2023 3:24 AM, Ilpo Järvinen wrote:
> On Thu, 2 Nov 2023, Reinette Chatre wrote:
>> On 10/24/2023 2:26 AM, Ilpo Järvinen wrote:
>>> L2 CAT test with low number of bits tends to occasionally fail because
>>> of what seems random variation. The margin is quite small to begin with
>>> for <= 2 bits in CBM. At times, the result can even become negative.
>>> While it would be possible to allow negative values for those cases, it
>>> would be more confusing to user.
>>>
>>> Ignore failures from the tests where <= 2 were used to avoid false
>>> negative results.
>>>
>>
>> I think the core message is that 2 or fewer bits should not be used. Instead
>> of running the test and ignoring the results the test should perhaps just not
>> be run.
> 
> I considered that but it often does work so it felt shame to now present
> them when they're successful. Then I just had to decide how to deal with
> the cases where they failed.
> 
> Also, if I make it to not run down to 1 bit, those numbers will never ever 
> be seen by anyone. It doesn't say 2 and 1 bit results don't contain any 
> information to a human reader who is able to do more informed decisions 
> whether something is truly working or not. We could, hypothetically, have 
> a HW issue one day which makes 1-bit L2 mask to misbehave and if the 
> number is never seen by anyone, it's extremely unlikely to be caught 
> easily.
> 
> They are just reliable enough for simple automated threshold currently. 
> Maybe something else than average value would be, it would need to be 
> explored but I suspect also the memory address of the buffer might affect 
> the value, with L3 it definitely should because of how the things work but 
> I don't know if that holds for L2 too. I have earlier tried playing with 
> the buffer addresses with L3 but as I didn't immediately yield positive 
> outcome to guard against outliers, I postponed that investigation (e.g., 
> my alloc pattern might have been too straightforward and didn't provide 
> enough entropy into the buffer start address because I just alloc'ed n x 
> buf_size buffers back-to-back).
> 
> But I don't have very strong opinion on this so if you prefer I just stop 
> at 3 bits, I can change it?
> 

We seem to have different users in mind when thinking about this. I was
considering the users that just run the selftest to get a pass/fail. You
seem to also consider folks using this for validation. I'm ok with keeping
this change to accommodate both.

Reinette
