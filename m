Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71A771F06B
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 19:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjFAROp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 13:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbjFAROm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 13:14:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6427CF2;
        Thu,  1 Jun 2023 10:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685639681; x=1717175681;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5ctHZSm1QM/O+ji95HrgsoOnvuoybT73XxlgiiDgArI=;
  b=nioi3Ko9Ep7b8PTkz/KlSrEr4asyqFCYoEJ4mCAkerpxuLZmz3T5cimk
   c3CWFzAjHHSbSHnwVttrFROC5yo/zAmsWrlwmYuwmo9O8NICVdirT6zSf
   C4WF+HFvgCMPw9LSvvL7YpDRu9ei0z6Y27yHZnVRCRkRaGoM6WX7ZX7X8
   An98TS9O75Tx0/7bHy/FssGXuB92/aGXAH6RfZfkSzAZnwdWsUwceMVX4
   6syBzEccQd8TkzoWmBpKEpwjWivMpdcVswZfv3JJsmtkKstu9v7LEq10u
   CH/mz8EmARC3ycbu/bF05ccgptGAyQWtsKWIIzV/i+fn+2n5CyW3ZwJZE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="355642088"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="355642088"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 10:14:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="701635678"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="701635678"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 01 Jun 2023 10:14:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 10:14:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 1 Jun 2023 10:14:38 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 1 Jun 2023 10:14:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9th8pSoi0eS6TrXQkP+tVMMZVJctqclOoSIrmfdu7d36D2leFAwNesERkP78ujzpKfK3w9w6z72r09cy8/BExpM1aBU/0XJposV9QBmUXWiFroPa2yLa5HL6IRV4VBzkL5ZHfuFFAiYdqKQJeRb0/AekX0e2eYEmDiS0dRI5LK78fMX8MmbKQoj6sDu8Z4738SKlfCc1SjoCT0QjtmbQ1CgZ3cgvXELtba9zOLDyuOYIT3egJ4XghKBS2gR1nB4cj2OSFgAub1Iosr6wo380picc9gTWCBXSC/6whbcsnncmf4v8J2jzJ2HtqBZmlk96+83SrIzwAlZcUKydvmGrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adxXomk/Chrz3lQ9dilI6xs0skIfJ/qgRhTlUVjs8s4=;
 b=Wr1LxPM3Qion54CjNYBYeuCSRuEWelHt7CTPzk8q4iiBgO6CHjT33coxQLtkkQI6FfgTh1yc4E2VnA6cu+uAaBw/gGX9jGJZYhw883xVcsF+RvmmSPEJRyJTqNpD2dg6HH7okc2tB1PU9wV16LlpDBNoeREa19su74EAuIs2iZM4MqmYJMJuswfRFEyeBYT56GRIF1USUD4iy8edBSAQBBytL+7SciLUZ4xdjwlK1vHmc9mjHjKbNp6JwTZR82YcRzjbJzHBV8RKWDxUihLK1tORKaDc6Zo7OWwXf0/hinm+UOK54Fkh6GU0fX8h5Xxe94iRFeQq0hVvRWxDF/S3sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7)
 by DM8PR11MB5669.namprd11.prod.outlook.com (2603:10b6:8:36::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 17:14:36 +0000
Received: from SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::ad48:40ba:142d:c421]) by SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::ad48:40ba:142d:c421%5]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 17:14:36 +0000
Message-ID: <da7bd23e-e860-9569-bd29-4f63add710c0@intel.com>
Date:   Thu, 1 Jun 2023 10:14:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v1 3/9] x86/resctrl: Add resctrl_mbm_flush_cpu() to
 collect CPUs' MBM events
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stephane Eranian <eranian@google.com>,
        James Morse <james.morse@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20230421141723.2405942-1-peternewman@google.com>
 <20230421141723.2405942-4-peternewman@google.com>
 <38b9e6df-cccd-a745-da4a-1d1a0ec86ff3@intel.com>
 <CALPaoChcra+qJd9ETQT+nZ17ahH0RCCarjuT3jn8EyzV2HyCbw@mail.gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoChcra+qJd9ETQT+nZ17ahH0RCCarjuT3jn8EyzV2HyCbw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0109.namprd04.prod.outlook.com
 (2603:10b6:303:83::24) To SN7PR11MB7566.namprd11.prod.outlook.com
 (2603:10b6:806:34d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7566:EE_|DM8PR11MB5669:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a0d28e4-2e3f-4624-a0a3-08db62c3acad
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lwjqFyYHjDPngPGojXfEcipPsjL0Z0PI2xqu7OuxWo3QgU+nPz7A9bgV4olf8aT3fnZEdYNExB9zyjkMeUY+JYuoVSxRKwpVYN8mmlHN7+Ugq+oibDCsPrpIzjVkS5qdYF/+HFXL2Tf7qrU4hTjvG2efs9VYOuzUz0LI2u19VzOWbENuW/iQgQbqCpseiFZmw21RYEodxjjpwWVxo6aXfVj/mcqThcz/qEdiu5o50d+sHLu+RrtSQAOodh8TkbpchqOuB0/NZgbCfM/49uOMk1LxLf3Tdm8iiLvxBZVQQTsC8+uF0AF3YVP5oEpHQWmMaKY3ZkQniAISYheg7wU0pWEeqPVp/x95bRKAELAgGJqB0M+ym0CtJG9jD9oQ4L7jyEzRuHNP+YAG8PlvxWFQ0vwEZ8JmEeQHBlGul0wb5gHaa2B8famhzJOPvMz4cpB2Hdg1hHjZnnlrk1+y2n+89zg4o/OXNuj6kt8VsO9/Tgb1KvTH2Oq3vRIFSz2DZ+iJ385IbZy/tE3goIUEp287kJDv1YiNDC3v9bnvbVI/HHOMsNlOwrw7JoV7BZin0NI3c5fdmFhf5xjExNc2QhTMp3DmWKsLAvXGlbEYY/sVfiHgwFjE/9SFPLN8TUCciB40BgDpyWCWqjgDUhGNHTZN+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7566.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199021)(66556008)(66476007)(82960400001)(31696002)(6486002)(66946007)(86362001)(26005)(6506007)(53546011)(478600001)(6512007)(6666004)(54906003)(186003)(5660300002)(83380400001)(8676002)(8936002)(2906002)(7416002)(44832011)(31686004)(316002)(6916009)(38100700002)(41300700001)(36756003)(4326008)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjVWSml5ZkhmdURkVk5FaHppUjR3eHp2RlpvckpYQjhYd2ZUemx4MGh1OFda?=
 =?utf-8?B?UVE3cUlaNzBvTlZ5OXBRSUNLRTk5cTBTSzVLS3RBOE1nc2pXNnk0V1dkZzBn?=
 =?utf-8?B?OTdxdlJJUXpsYWlIS0FmNmM0Y28vL0RhNVZXSGhza3VuYmwxdFpTWjRzekkv?=
 =?utf-8?B?bzl5Ymx4QVdQMzZlMEJJdm4wUzZrZ0ZjbmlDZGUyLzNVVG1kYnk4RFVRME14?=
 =?utf-8?B?N0V3Mm9WaGVkcWF5cnVBLzV2ZHdPSnhKekpWV2EvMytjSnluK0pZUmV5SHMr?=
 =?utf-8?B?d1RTZUVnZDBIc1lPVzg2QWcrZHplVnpiVEdIVHNyeUNza2VIZ09Vc0NIQXZ1?=
 =?utf-8?B?bmlWQkJQWE9CZ1oxN0dCM0huTkk0SGM4eUJRVVNHWE9UbGRwZldoRTAyUmc4?=
 =?utf-8?B?eTdsYjJxNUd0RERzb1BGTCtLb2RueDR3TEFyM0xlYXNZV1Q0YStDVkgwWC96?=
 =?utf-8?B?Y0hoMHNCV21rR2wwaFJ3bFcxOGdpTTFzRmNsY1h6TnU2QjA0Z2Z0VlBhdElh?=
 =?utf-8?B?bWw0cGoxUlBUY3cwcW5wdkh0NXpSQlRqN0Y5bFVQSS9oSW82V1pnd3JPQ2lk?=
 =?utf-8?B?Wi9Ib2FmeFNKSU82R016OGZtZ2FSV3FWVnBwOUZMUFpVQmlzRnZ3aFRodjNN?=
 =?utf-8?B?M2FWemRZUGcyeGlYZ1lmaGVQamcvZVVUZGVkV2tNZEpnQm40RC81WWM1NW1S?=
 =?utf-8?B?YzZRQkJxM3BQMFR3WVdwOXdVZTVxNnhkOTF3WFJBbDF3MURRSEVLMDlyVkhh?=
 =?utf-8?B?Z2MvRHJsZjZ0VnI2WEg3THN6VzBKU0FDYjNKbkx5dTdXaGN2VHRIa0hGMC9S?=
 =?utf-8?B?VzVHTk1WbVhGY1FVOEtHUWV5VHhVWWZ1Wk9lc3VOTVVKdnVRaW82WDhlK0pH?=
 =?utf-8?B?bGtUd3plMnBsN0lWS0E2VWMxdVExRzFkZ1pUSWtHMU5mRUxta0FuSXhxcDNQ?=
 =?utf-8?B?dkIybnlNRGd2K3dScDR4RkJON21RYnpWVkYzcGpob2pxQlBEazFrWlNwUWpa?=
 =?utf-8?B?bDJGZmc2Zk1DRWlxQVBJeGxseUY3R3VaTTh5ZWN0TVIwSDB3SHdHMVpzVkVy?=
 =?utf-8?B?VkFiRXAvZC9aZnZDNkxqRUlzNCtMTGtDT0VFdkNrRmxmakc5QzY0TkdFNFJ6?=
 =?utf-8?B?a3p2RnJmM2t3U2RxSjdXYlQ5WGI4cGlkdGZtVlBSOGxoKy9UYWdIbnB1SFNo?=
 =?utf-8?B?R0pmZTJ0VmFXcFc4NzVReGc0cFFYWnczRFJ6ZU9oYVowTDEraURNQWh5bDNY?=
 =?utf-8?B?UWZEM1FBbXpIMFc5NTg1T09oNUo1VzJVUmMrbGt4czN4VlU5dEpUUVNTcmQw?=
 =?utf-8?B?SGQ4T0tndS9QOXVFZ1N5NUJsVFYyeVlNZ2VuVzRYWWRtazRmV3hocTF2ZzY5?=
 =?utf-8?B?V3V1cXpQQjBMQUxlMzNZN1Z4L0hrdkdjZVFTZ0paWGNQUHZnNVhJUnVieW9q?=
 =?utf-8?B?RDM0VjQzNWdLeWgzang5QVVJTFBaaGpPUGJvc25Sb1BnSERsNEhVWEZZVDdQ?=
 =?utf-8?B?T0FjYTBab1pON0RHajN4dEJBV1BsSlJacWpFaFBCLzdvUkk5Z1VablNjZW9E?=
 =?utf-8?B?eGxkbm9oUXl1aWJrVnk2cGdieXk4Uk1WZmtadGJPQkxHcWNSd0h1dERKMmov?=
 =?utf-8?B?OXRqNUdFTDQvVzNKNkVtSi9IQzNGY3Y4TjAyVUlVRWtHTW5MazBLaGt0M1Jv?=
 =?utf-8?B?SjJPOHZxZ3pwekozQVBJM3BFanozTDBMcWg4OXg4dGtYKzZISVZIZ252ZEtp?=
 =?utf-8?B?MUZMQm1GcG1PRjZwT0RNSkJpZlVYNnpFRzZsRlN6di91WklkYzNlOWhVNmdt?=
 =?utf-8?B?WGlBQzY2UnVtRHMxNWRQaERzVHNXY3VJMStiNVdtUTBvN2NPQTdQb2pQRzlo?=
 =?utf-8?B?bytlT2VReWFWdzFWdmYyMFA5WmdVdjFXSGtWTnUxeXJXYS9GZkcxbC9jcWcx?=
 =?utf-8?B?OUxIamhkK0VwL3NxdlBvMG95Z3FlUzFCZmxVSlVNWnBXTjVhcTY1Vko1SW1h?=
 =?utf-8?B?Y1hhSlV1TDRLMDJDVm9BNnQ4eStPOTNhdHNHQXNzampEYk5wa0pubmU5ME10?=
 =?utf-8?B?NmJocWpPREZvbDlkNmpUL0ZBZTYxU0Q5NHg0K2dVOXVyeVJpWVJhWGtyWjBs?=
 =?utf-8?B?N3ZpbDcwbjF6ZHMrZUVidHhmekd6THdnWWVaaXJML1paUXN0ZEtpaUdUTGs0?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0d28e4-2e3f-4624-a0a3-08db62c3acad
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7566.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 17:14:36.1719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MeltbwwD4DSd50bSUy0t5OFKd0qSGjPuOo/qhUobLVv6oONbTOcvVX52sDgQiG5bNJ6vIWfucAi0PNCObL6QvQ17EZdrcX0/qQppAEzGMEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5669
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Peter,

On 6/1/2023 7:45 AM, Peter Newman wrote:
> Hi Reinette,
> 
> On Thu, May 11, 2023 at 11:37 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>> On 4/21/2023 7:17 AM, Peter Newman wrote:
>>> +     /* Count bandwidth after the first successful counter read. */
>>> +     if (counter->initialized) {
>>> +             /* Assume that mbm_update() will prevent double-overflows. */
>>> +             if (val != counter->prev_bytes)
>>> +                     atomic64_add(val - counter->prev_bytes,
>>> +                                  &m->soft_rmid_bytes);
>>> +     } else {
>>> +             counter->initialized = true;
>>> +     }
>>> +
>>> +     counter->prev_bytes = val;
>>
>> I notice a lot of similarities between the above and the software controller,
>> see mbm_bw_count().
> 
> I see the "a=now(); a-b; b=a;" and the not handling overflow parts
> being similar, but the use of the initialized flag seems quite
> different from delta_comp.
> 
> Also mbm_state is on the arch-independent side and the new code is
> going to the arch-dependent side, so it wouldn't be convenient to try
> to use the mbm_bw structures for this.
> 
> From this, I don't think trying to reuse this is worth it unless you
> have other suggestions.

At this time I am staring at mbm_state->prev_bw_bytes and mbm_soft_counter->prev_bytes
and concerned about how much confusion this would generate. Considering the
pending changes to data structures I hope this would be clear then.

Reinette
