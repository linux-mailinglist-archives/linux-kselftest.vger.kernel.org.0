Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073E97C8EBD
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 23:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjJMVIK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 17:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJMVIJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 17:08:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FABBB;
        Fri, 13 Oct 2023 14:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697231288; x=1728767288;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1mCRscaf5cu83djN6mDk2hVfI6qB4QFKXNO6DIoOv0A=;
  b=Vqnl+nNbyDHIkUJE3mfQTS+ILyNZV+21ckF/zn1ml1yQVgg+bduSOW26
   UWsmRth0MpAb+B209LjwW0Z4z1/xBiPZul/JeQJ4ojrGg2j8q3HT9Ani2
   UkV4l6sBSW2QMiUFOd6WzOWWe/Lkrer34OFwPqYChaMSPF6grzc+U2Xii
   m9aLtkt+XgoM7K24e1QLvQxX/Xg+oKF93rW7y3+tjacsIhan1VZX2mj5f
   dwXlxmYCf0O0MSiUKH90gz4iBULu6WSXgdcFt3ohVrorZqEETLp7S3mnD
   Yy6XKWWThkF0FP+ZTYAYtvoIfwoKavInmmam4ZGSD+v+NZ2wKKZ8dbgtt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="375618707"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="375618707"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 14:08:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="789997269"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="789997269"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 14:08:07 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 14:08:07 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 14:08:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 14:08:06 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 14:08:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilqbRTufOeURGkcTfOmsCoxJZDfoTYmCQNDiugijROT1VlVVzIZ4BbQ4JpQ2GKABbDORvByPyHLUmcvc5tl/LnCo4UHLKFGEQbVFvaPk07MzIPk8pky3pEzkBo9WXFJelOsXTQ2DG35KTU3fVL3FLvXkt2JzjSNkh4xTA6E8TZkAW4DfhMgIabgXKENhoxgD3yHrCN62durmbvqX26GmxJ/JmtZvcIFJ5cffWrrruzaUhjTpQx2jhemv9H/Srp9BMViHFPyANnEkzBAu3x/9ZNCzroRhKe2aO2kaUkB82Qaw6WL5yTUEjkXei4kf0ZsqWPnMd8Bf44xdWTD4WkDq5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSG5WE+/wnaoplfs09ypVYxgSzoJptC4hKLGEksWUpQ=;
 b=gjPxv4+Ja4K5UoDbs7DYfRoZkDmFBpgYnSNqu4OOpIDMkDtXlAOn/I2pR89uSFdja5BMM/eVtgGKtYkosROr2uL7ReNXwbfMRNjURZKb5C7C1ENwHIL1slyJ3z2x7Lncs/jaUMPijFbJVy+Fj+syCjC6oym4ToSG8+xMiaBlBiIREgyDgmxfFhrPpJ9lJN73MusR+K5D3btT+Zr/7uGcU2hJja3640QytAKpIFdQxwc99RSXoLU6ge6OQZTFycfrQsuLkAH39uLu413IdBju8qOaEbvpDi7jD7WzxhclYB56+b/x8GZAp6WeRVew9+pQegnSkW4kspzGzLbV8pVJlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ1PR11MB6202.namprd11.prod.outlook.com (2603:10b6:a03:45b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Fri, 13 Oct
 2023 21:08:04 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 21:08:03 +0000
Message-ID: <2a76f17c-727e-4634-82c6-faa8a63d4864@intel.com>
Date:   Fri, 13 Oct 2023 14:08:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/8] Add printf attribute to kselftest functions
Content-Language: en-US
To:     Shuah <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        <akpm@linux-foundation.org>, <christian@kellner.me>,
        <fenghua.yu@intel.com>, <keescook@chromium.org>,
        <ndesaulniers@google.com>, <coltonlewis@google.com>,
        <dmatlack@google.com>, <vipinsh@google.com>, <seanjc@google.com>,
        <brauner@kernel.org>, <pbonzini@redhat.com>, <hannes@cmpxchg.org>,
        <nphamcs@gmail.com>
CC:     <ilpo.jarvinen@linux.intel.com>, <linux-kselftest@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1697196663.git.maciej.wieczor-retman@intel.com>
 <0efe3ba3-b62f-4447-a195-2447e1152a22@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <0efe3ba3-b62f-4447-a195-2447e1152a22@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0220.namprd03.prod.outlook.com
 (2603:10b6:303:b9::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ1PR11MB6202:EE_
X-MS-Office365-Filtering-Correlation-Id: d35572ad-fab3-49fc-adf2-08dbcc307d67
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EpNMw00IjX/FX/0uGqAXGIJA/ypke3pDxYI/pvlu1sxQs8ocn8ee3ycebhCulltuU5SXFmvWT1rSdkSbMR/neAp/AJep61n09jPVPAVIYplYs2FWF0cgXbX0RKBtMDgBduqBFrg6jeNXta1WLXzrtjErT95uO0hum9sa96EXyCq2XjIa6MG/CbUN+9hAGJI5DBuG8onrNkzOycXZMAlCG1locoRsQvhHOuXMq8IcCKymektJrtb5vIBERCcF/9TpC6l9DR251/4mVoCgkeWrKKoIdBoFaXpdR9pUYRbIgL7FBP9fClFeq/tcUzIt4SUu/XbIdCJryWpr+Xw1RA2C1mCaW/jIXAVtrYK8ltpa7Fb6o6nJytSW41L1wR8a77UKW08DkB2E+/WQv4vwXEUUYLscSjpk8XLSeOzcLpMEvfIABIxaUmRh3X7ikTdBFfHiZ03rhohw2E2hHxG1y3WmzDYUgvTkrJ+M3WA9navA3n12hLf2qsGdnoVq1XJqpNGDjfMBmRlIYaw8entRnFrD0LOmXHLfn2JNLl+1iU07+ruhS46B+e+3MZotwzlUotpv46kfF9urgeyU1sN3tMEI83hLErCmdnokH4TgwXgu7IGGaqCJiE+VVkn7lI68ue5vrx7d4Dlp7lTaBaHixIU1W8PsyW92If6q39YPMY1yDduApejaS020KYTe2sxhq1kF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(26005)(478600001)(6486002)(966005)(2616005)(31696002)(86362001)(53546011)(6506007)(36756003)(4326008)(8936002)(66946007)(8676002)(110136005)(31686004)(316002)(66556008)(66476007)(6512007)(4744005)(7416002)(41300700001)(2906002)(38100700002)(44832011)(82960400001)(5660300002)(921005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlJaWmNGY1pPZ25YT0loNVlDRUFRalpKaC9nZTZyNmtaUy9JMllDVjk0NFkz?=
 =?utf-8?B?Q3BaQ0htZlVYdmZWSHk4aWZPUWkrNGo5M2ZlR2p4UWxuQ2psYWVWOHR3c1Qr?=
 =?utf-8?B?WDJxcUFkR25qcXExTmU0NlU4V3RNVTFtR2pldEtqbmpJenFoUC9GblZ2aThD?=
 =?utf-8?B?d0hVZytQKzVLRGdOZkhEblhydUFFT1cvYzBYQmFDVVd2UEdmd052U2F4Ujlr?=
 =?utf-8?B?b1k3Q2N4MDNlSW9qb2pSRkp3M0hPNXkzY0JQQU4zZEpSKzdNQXpxMHhKeXZn?=
 =?utf-8?B?ZVVpQXk0U25UQ2kwMU5OcVI0L3ZUZjZ2MVpOVlZoaDdDamlWeWIyb1MxTVdV?=
 =?utf-8?B?eWNsTmdnQ1pPTi9DT2Uvd3dpUUNnTU4yWmJNcWVSTnNYa0dYT2dPZzlqeTgy?=
 =?utf-8?B?QjRudExoNVBBc1o4eVM0dXc1WGxsK3Y3cDUyNkl0OVIvLzRlRUl0OExSRUJ2?=
 =?utf-8?B?RlR3c1pFR0hHVkRuMGt0dkkxbHE1NkZMeXlncDdQcEgrU0lFNURIS2NpVmc4?=
 =?utf-8?B?RS9kVlVNeFVHUjJPMUt4dVNrWTQwUDZDYmErb251d1I2enFUc0MzTmw5Nktt?=
 =?utf-8?B?YUxnYmZuKzA0aTZUalowSEMrbm1ra2FQVkhDM1k1ZVdZNXJMSXMrcjRoNkl2?=
 =?utf-8?B?SDRjak9LUlhnbkRuTjNDU2lKYUNpUmNhN09NU05wbGFkclEwVVZxbnBkQ2xO?=
 =?utf-8?B?WTZJNFdvdGE2WlJkRXpJc1paTWpYSXUyY0tacWhweU9NeVcxQ1dmNWt0SG5Q?=
 =?utf-8?B?cUNzMHMvOE5LQjBydGV5bVI4RjRiWHdxM3Q0TUtpekVsSWZMcGFxNytzZW1R?=
 =?utf-8?B?STlZUDNQOTJGN2d5SjFFRW5CaXhiM0NiVE5nRS81bjdxaUU2cDdqWVBpSklK?=
 =?utf-8?B?aVRTQXBrZ1Nhb09ReGFtVlp1dXRaSmlMS0loTmNGVzRRR2FLeEw3UmJzRDZv?=
 =?utf-8?B?bEpKQTRVQ2xER3lCOUliN3ZqV1dlRzV1RDNROGdxNVltbW5RNDh4ako5OGJE?=
 =?utf-8?B?akdKRHIrV2RQNG9PU0pmYnVnUm5RUmk4SnMyaSttaEtGdGl4YndKN3hRSm8y?=
 =?utf-8?B?R2ZNVUMwTmlvL0YzYnhWOUxvZ0IvdTNBY0RpRG1NRndldU16ZkcxZ1BKQ2di?=
 =?utf-8?B?WE9oNGptelZmL29xUUg3ck96SGNjdm5OVVdLaVVxcGw1ZzdCdnArMUovMkRT?=
 =?utf-8?B?VnNmMDA4cjFoOFdKRDIzY2FIYmtrR2pzd2UzMlBtRjZZN2haam9PbHdDNVJ1?=
 =?utf-8?B?b29NajhER2JZRWhLVWxLbElWZGxWTDJZamYxd20vclI5SUNxWStQUERNek1h?=
 =?utf-8?B?YTRKWVlCd3VJSzBKNXA1ejh0N1BuSHRlWEpnTGdTTzR1WWZFZmN1cGFteGJP?=
 =?utf-8?B?c2xFdHYzVnZwQ1czN2gxckhGMXVXclROMTFmcytrZDBEekltZGhtdTAxWHJL?=
 =?utf-8?B?anQ4UUZzVnQvMDgxU0tnY2R4U3Z6cGpVZWxRMTE2dWtWYmNZY01QTHFYUG5m?=
 =?utf-8?B?Z2U4cU8wOXIzSWxjaEtxRHlUNStRdlc0Wjl1QWkzNkkrazVpQ0pWRjZUN201?=
 =?utf-8?B?bDhBd2NHQkkycEE3eFh5NVNxRjdteEl1L2RLbHlZTXR3TkJnTU9QSEdwOWlN?=
 =?utf-8?B?dG9nUm0xK1A4MTFVdDVrMEd2NTF3UTZacTVnU2ZCRzBLNkc3VHZxU2RQblhH?=
 =?utf-8?B?eVA2amd4bHFXai83SVlxNnd5T2VvTHdFL2pwdTJSNzdNd2FIMmRrcWsvTUZ2?=
 =?utf-8?B?ak9YMm8zVVpjbHlKVmFzVkhmWTE0cUlkQ0x5Z2dKYi9Zb000L0UydTdyWDh5?=
 =?utf-8?B?NnhTRFVNYlRDSWlaVFhrTE01Y1kreUo5WjRuSWFNZ0hCdlBwYll5aXZnKzZh?=
 =?utf-8?B?TElmSkhrdEppb3JxZHpTWDl4SWI4YmNvT2JremJwR25uOVhyUituWWJWQ3RS?=
 =?utf-8?B?ekFNOXlSM1pxWDYwVVdaaDhZYVY4b1JYMzV0WE1nUGZUaWdjbFBvakova2lq?=
 =?utf-8?B?aDU3ZzB2elR6VlpUK2lsdU9CRGxocFRVa3pQZlZYUWtkL2t0TkQ5UWhVZ0FJ?=
 =?utf-8?B?UW5STzJnRU1iTXc5SVJJQkNIZ0l5VmdFenZKNi9FaWNYMjZCa09teGJzK0Vl?=
 =?utf-8?B?T3BLL0gzNGJYMUphNk5xT1pYMGhOZXpGQWlid2xnU1pkL0xVOERrVm5obkhQ?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d35572ad-fab3-49fc-adf2-08dbcc307d67
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 21:08:03.8783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4mvF4vfGxsu1ZG/lM4Ec9Ln2c8VmtLPRwzA5EWlzriycbuC3WjC0TCpyzMdmoshsOyOb92rsfyZu5JOx0nbMcA8oEUUVAf6cm/OitMTePyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6202
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 10/13/2023 2:03 PM, Shuah wrote:
> Applied this series and the following three - all 25 patches are
> in linux-kselftest next for Linux 6.7-rc1.
> 
> [1] https://lore.kernel.org/all/cover.1696932728.git.maciej.wieczor-retman@intel.com/
> [2] https://lore.kernel.org/all/20231002094813.6633-1-ilpo.jarvinen@linux.intel.com/
> [3] https://lore.kernel.org/all/20230904095339.11321-1-ilpo.jarvinen@linux.intel.com/
> 

Thank you very much Shuah.

Reinette
