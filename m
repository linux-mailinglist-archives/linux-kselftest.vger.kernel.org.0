Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534F96FFBE9
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 May 2023 23:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238381AbjEKVhe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 May 2023 17:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjEKVhd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 May 2023 17:37:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BADF5B97;
        Thu, 11 May 2023 14:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683841050; x=1715377050;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N9qYchSd9QfI/vOfJKu3SrOJBIRMMenxmsfR2gqSJmM=;
  b=NLMDjg+UX9x5rS548jlwY1zK4nAx6J1TZcGLSF8URDr/MQkH1ZT8UjzX
   R2LAIg4aq8eoa41+6yys5T60ukwFJqa3WNxskW64nvfKrsfoLHezARu0V
   F9KCuO12tO2M4pTif6E9fTRhm2QKwxj0KA7mbTlByzIYOysnGqFocR1/j
   yw1xCsqXeyYywMadHiGR9jKnPh99jPRkOCNGM36hITNa8JRlTqC3rAuPt
   CDfU6YxC7chiCFMjeYR11YI0CcKhd2Kbqu4AafGO2Hi55MAtIV5+A/xKa
   OoLRnD/ZAilD6kM+kMMNaIynS1jB3BFuqDhnTi5Z5Zlu+ocdvbiygwtJi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="352877979"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="352877979"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 14:37:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="702910282"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="702910282"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 11 May 2023 14:37:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 11 May 2023 14:37:22 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 11 May 2023 14:37:22 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 11 May 2023 14:37:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIWM5W7LntPw8Tknu2qS+Xas8nklM3tyghQGNm0SegOCSx5GNN9BRUhbaGWGmYh3mouQiX+uVXAxiRWtTVPXHYzxm0p3phsNg76i9L12zSdzdJDUEi7080ly2t7o3KRmfV77T/onBVU3ObEANkIAIc0iENgD2EX0EVMjcsqD3wUH1ccJtCPfx+OhI2UkmarSV8zgRrvaTrxZ/UxuHpkElIWau71/KNqArwB3KH59MkV+4LYuPRohmnNXZOv26PjxuLq7RTZ1GpFEPEs9spJrnIIg5ng2/IWNlXYpF9nh/mIKr9YNqmcz0fX2xceaEIiIawT0lZKqiUm/egWKwhRmAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpF63sqf1BIJMRqWnRwMrxku7huKDeM82gJtl9xfRXo=;
 b=Xpfx7feZQnGxt6Gz7WZITYeAAUr5wNq5qrsU6fAZg1Mo/djsrylO/MaXoCH+WtPSTFK3am4tj8rLQDCMfH6LKyBloV3KiJFMjs+TyiUEbyPgV4/pIAAZf/Z6AZMzFVApvYOBDxHq7is8hJp4mF/5bCirFH1vMdlnYB80WzTMdSxp7UCIqEJIgyhAWL8GcVyDEFZCbNUbxGvQyplBdFOlHA/S7ZRO61FwHkRoLYW9lqUM7G+Bvzhe7Rlqdh/VZ+/FiSnVYhxwdG9VWU8ccpOapUDJkToKsP4xXR4VRZTTxuLjUJ59XZUypaikUqXWitZdP44norMIn501VhkPahzL5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN0PR11MB5964.namprd11.prod.outlook.com (2603:10b6:208:373::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Thu, 11 May
 2023 21:37:11 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6363.032; Thu, 11 May 2023
 21:37:10 +0000
Message-ID: <38b9e6df-cccd-a745-da4a-1d1a0ec86ff3@intel.com>
Date:   Thu, 11 May 2023 14:37:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [PATCH v1 3/9] x86/resctrl: Add resctrl_mbm_flush_cpu() to
 collect CPUs' MBM events
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>,
        Fenghua Yu <fenghua.yu@intel.com>
CC:     Babu Moger <babu.moger@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stephane Eranian <eranian@google.com>,
        James Morse <james.morse@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20230421141723.2405942-1-peternewman@google.com>
 <20230421141723.2405942-4-peternewman@google.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230421141723.2405942-4-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:a03:254::31) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN0PR11MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: c1c115f8-83bd-4de8-7b61-08db5267e0a5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tUWdcb/IscOaZIaSdnXJfqHi/jKz6HnQO8ktRTxrQ2Bz4gPegpp7mCAHiOzvBmogHFWrEdpe62CS1hs03/rFyXQC3qpE7sBYVRZJtRzWW2d6duFmFHS1QwgiBVdHs+Ml2OVE8vLf8z3OgeKzPGfD3VngI8Rv8HgA0N8TOodQc0/28clEXf23ULJ0xPU43x00E+Gjt14rhP7J31gfz3p8gDJgHDjI5irekNsmvzy4lp4nAeD21CtICZYTVLHPi4BFEPP+0vo+KDYZjwRsZ+Cxn3JZg7YUtt870HIU/S/a4mQpgEsvxG0/+iEq0rMo6HeBBYbaIzkh/iOo7RUxXvhDOXe7ip+Shx7LzZQvNLV84POd4WTMT0mBzmMY3gp4FuhV9eT4IBI6n53RDwnNacTo7TTOjeXnNO2oMHPNgefBaiT0o3xEFChAh6MZ81lkG3akQOUgyyClzzMBF0e0CSMoc1xIJSVifJ6agHgJEGKWURjSiFSDUPEcRbjSYyaSdh5qVJoYrdqQNGYZef0VJaIo9X6qL3n9Rz7CU4v9K/wrc7yqbCb4kZw5GcyVjzdyGhupt46+ok8upZkCcU4bVSwhiXHNRCZoct+KvW/LLnxJoqGETHiQy/EWhLSWkqebEAqV8PXwjZlmYz+mRkb7p53y2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199021)(5660300002)(44832011)(7416002)(8936002)(8676002)(83380400001)(2616005)(2906002)(186003)(36756003)(82960400001)(38100700002)(31696002)(86362001)(6636002)(4326008)(26005)(6506007)(6512007)(41300700001)(31686004)(66476007)(66946007)(66556008)(478600001)(316002)(53546011)(6486002)(54906003)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RStuZVVNTWV0WE5CbW5qMUJXWlp6OFFhSFpiTUdQZ1p6QlpnbGI5TDMydVgz?=
 =?utf-8?B?KzhDdC9MSUJNc0xpMThUa2gzck1zQitYbXo3azZscFowWTk0eHFoTmdiNTNQ?=
 =?utf-8?B?dXlFc2hpdWxBdG9RMGt5VjNJeC82ai9uSlRKZXpKU21FMlRFMGtYQTVaeXgx?=
 =?utf-8?B?TWZQUlI4SHViM3BqcUYvWGdPUXJsSk1IWjZmWG9pei9DdU10UlB6SVZ3Vmgv?=
 =?utf-8?B?Y2FEZjJvNDRRSEc2aTE2bnN4Umg2ZEZHMWJNdEFrT1dYelo3Mmd6S2JySHJO?=
 =?utf-8?B?b1hvT09nYUVkNUx2TjV5WUk5d0R3S04vWHcxTFJUaTJKaDQ0em0zd0ZxaFAr?=
 =?utf-8?B?QVprTThwekt2NWhWT0pMeHp1YlpLYnVCVjJ6VktGUGozNmFJSVRoYlNJVWJN?=
 =?utf-8?B?NTlCWUQwbytIdmxlVnd5cG11aytIU05VWVhoYlBPOXdubkF1ZkRNUWZCMnQr?=
 =?utf-8?B?Z2wxcXg3WnJ1M242NUFHc2xwbDROVHQxaDQ5SHpRRUxwMmtZMTg1alh5cW5m?=
 =?utf-8?B?R2tUTlNoZHhWV1dmd3FDbklGeWs2WUVlSmoxRUNMemp6SEVKV0hvZ090b2xr?=
 =?utf-8?B?Sk1uKzdLVWRZK0tGMWxtSjY2dDd2RTQxbkNQQThoY3V2VGttUGZ5M3BubGUv?=
 =?utf-8?B?dVJxOXlPUEZFWVBMR2RPM09yRVVITzkzZ2JpRGpGdDk5ZE4zT0FsdDI3VjZB?=
 =?utf-8?B?cjdHb0txQkVQeFpzdG82b2o3clNjSW1NbzFxV0tTcHkyUE45MjFDalY5Ulcz?=
 =?utf-8?B?SzdNdXdPNXhITXhDUmdwV0gxeGJrd3JzL0RKM1U5b24yeXNwQ1ZjTnc5R0o2?=
 =?utf-8?B?VTgvODU0UkVVaDhEWTg2MVYzcE1HQmV4VnZjY2hOdERZRWptVm40TzFyeHJY?=
 =?utf-8?B?YXNkQTE1VnVxWUhRMWt2V3lNZkh3Qit2YVNtUGdJamJXUTAwdCtlcGJjaXFN?=
 =?utf-8?B?TjVOdkM0TUNJNlFnVUE2ZGwreGVqSFhRWmc0alVZSlJSUW1wQUtMTWl3Q0Zl?=
 =?utf-8?B?NnlMYnEzVUF4elFFaWNHMWkwV3hrUktCY3RnMUxjR0RsaFJwRjdCNnk5L3R3?=
 =?utf-8?B?M0tUTHAramFhOCtmdnRIa1o5Z0RqWnhzZ2szVFVkS2NaTjhrN0FJaFJNQVJj?=
 =?utf-8?B?TmYySmNUMGplL202VklEQWluZnRITTAxS3pkN2dja0xtbkZNZjBnazd0S1Nt?=
 =?utf-8?B?YnphU3RsK29hUG5zek16dTNGVTZTQmpNdnJsUTRiQ0NWcUNMcTB0QjlreVky?=
 =?utf-8?B?MmEyZ0RzZzEzODZoczNYcjloSjZLckczdnIwNDJ6K3ZxUEdjZkhxcmh0dkJo?=
 =?utf-8?B?eG1zVS8wYmM0VU5QOFFhL0htMXNFUGlGR2U1ZmcvRVhHdXltZjUxQjJMWUR3?=
 =?utf-8?B?WUkrb1lrekdBeW9uQ2dBZEdoQXlnaDAzOXJ5ai9aOHVDMy84NTBVVFFoTEhX?=
 =?utf-8?B?VVRZWDBPVFdiWlVkeENrcUp1YzU4UjBWbGZ3UnFkeng1aGxKS0J5OGZsMXNr?=
 =?utf-8?B?SjJFTlhoU2lwOHl6U2hyL3ZxQzhhY1MxOHdXbEx6WmwvWFdtdEdSV0ZIV1NO?=
 =?utf-8?B?WDNwWURZY1hYVlBPeTNRaE5BbEZpMlZYeDl4YnBFQkZvYzV6djZSMXZWZWgz?=
 =?utf-8?B?elMwcFJ1aWpsTFdBdGhWeEVtTGk0cUw0QXlBZ2xISFlsMzJPZTgvWFNBRjQw?=
 =?utf-8?B?U1pDc0UrZkJVcGNpVTF6VzBhOWllRXNuRG9IM1hlV2ZRcGZmZkhaWlZVaEhz?=
 =?utf-8?B?aXd0VnhaR1dWREx2Uk52cHpvNm1IMnpXQWcxUy8rUDdVUkNEbW04TjRkNDNq?=
 =?utf-8?B?dUF0dEhidzI0QVB3VS9ZSVpmZHY0RVorSHVwMFd3N3ZWWkRiaThqR2FnNHhj?=
 =?utf-8?B?S1BZTU9oVFdVYmg3N205eVhGaU5EY3lhRktmbXlLRFJtSFpGbWRXTi9xWGor?=
 =?utf-8?B?MmtFREpjU0hORHlsZzI3b01WU0lyeXBNc2QycmRzallud2o0eTFqblBROXAy?=
 =?utf-8?B?VmcwZGdlZ2tnRWppTW9wQUFxeWpLdE52bXJhOFdIRjBzT3RlRnBPWHJOL1hR?=
 =?utf-8?B?dll0SlVoMWxaekdYVm1RWU1zRmdsMGN5ajM5eGlRZWRBUjBrVjJkZzl1dWZJ?=
 =?utf-8?B?MmJiMkp1bzVJcTBRTnQrQzlvNXozNUVCejFNQzgzMUh4clQ2OVZ5QmFlbkVB?=
 =?utf-8?B?b3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c115f8-83bd-4de8-7b61-08db5267e0a5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 21:37:10.8643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yoOQdumUnirpNnI+VdlAbkLesyBuK6AatDxXfBBNODIMckHY5Rksxja5cmTbixntqjWp7UszKYEGDGHYnnNCsbhkfpkfrbzEnLJFpfehMkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5964
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Peter,

On 4/21/2023 7:17 AM, Peter Newman wrote:
> AMD implementations so far are only guaranteed to provide MBM event
> counts for RMIDs which are currently assigned in CPUs' PQR_ASSOC MSRs.
> Hardware can reallocate the counter resources for all other RMIDs' which
> are not currently assigned to those which are, zeroing the event counts
> of the unassigned RMIDs.
> 
> In practice, this makes it impossible to simultaneously calculate the
> memory bandwidth speed of all RMIDs on a busy system where all RMIDs are
> in use. Over a multiple-second measurement window, the RMID would need
> to remain assigned in all of the L3 cache domains where it has been
> assigned for the duration of the measurement, otherwise portions of the
> final count will be zero. In general, it is not possible to bound the
> number of RMIDs which will be assigned in an L3 domain over any interval
> of time.
> 
> To provide reliable MBM counts on such systems, introduce "soft" RMIDs:
> when enabled, each CPU is permanently assigned a hardware RMID whose
> event counts are flushed to the current soft RMID during context
> switches which result in a change in soft RMID as well as whenever
> userspace requests the current event count for a domain.
> 
> Implement resctrl_mbm_flush_cpu(), which collects a domain's current MBM
> event counts into its current software RMID. The delta for each CPU is
> determined by tracking the previous event counts in per-CPU data.  The
> software byte counts reside in the arch-independent mbm_state
> structures.

Could you elaborate why the arch-independent mbm_state was chosen? 

> 
> Co-developed-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Peter Newman <peternewman@google.com>
> ---
>  arch/x86/include/asm/resctrl.h         |  2 +
>  arch/x86/kernel/cpu/resctrl/internal.h | 10 ++--
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 78 ++++++++++++++++++++++++++
>  3 files changed, 86 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
> index 255a78d9d906..e7acf118d770 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -13,6 +13,7 @@
>   * @cur_closid:	The cached Class Of Service ID
>   * @default_rmid:	The user assigned Resource Monitoring ID
>   * @default_closid:	The user assigned cached Class Of Service ID
> + * @hw_rmid:	The permanently-assigned RMID when soft RMIDs are in use
>   *
>   * The upper 32 bits of MSR_IA32_PQR_ASSOC contain closid and the
>   * lower 10 bits rmid. The update to MSR_IA32_PQR_ASSOC always
> @@ -27,6 +28,7 @@ struct resctrl_pqr_state {
>  	u32			cur_closid;
>  	u32			default_rmid;
>  	u32			default_closid;
> +	u32			hw_rmid;
>  };
>  
>  DECLARE_PER_CPU(struct resctrl_pqr_state, pqr_state);
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 02a062558c67..256eee05d447 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -298,12 +298,14 @@ struct rftype {
>   * @prev_bw:	The most recent bandwidth in MBps
>   * @delta_bw:	Difference between the current and previous bandwidth
>   * @delta_comp:	Indicates whether to compute the delta_bw
> + * @soft_rmid_bytes: Recent bandwidth count in bytes when using soft RMIDs
>   */
>  struct mbm_state {
> -	u64	prev_bw_bytes;
> -	u32	prev_bw;
> -	u32	delta_bw;
> -	bool	delta_comp;
> +	u64		prev_bw_bytes;
> +	u32		prev_bw;
> +	u32		delta_bw;
> +	bool		delta_comp;
> +	atomic64_t	soft_rmid_bytes;
>  };
>  
>  /**
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 2de8397f91cd..3671100d3cc7 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -404,6 +404,84 @@ static struct mbm_state *get_mbm_state(struct rdt_domain *d, u32 rmid,
>  	}
>  }
>  
> +struct mbm_soft_counter {
> +	u64	prev_bytes;
> +	bool	initialized;
> +};
> +
> +struct mbm_flush_state {
> +	struct mbm_soft_counter local;
> +	struct mbm_soft_counter total;
> +};
> +
> +DEFINE_PER_CPU(struct mbm_flush_state, flush_state);
> +

Why not use the existing MBM state? 

> +/*
> + * flushes the value of the cpu_rmid to the current soft rmid
> + */
> +static void __mbm_flush(int evtid, struct rdt_resource *r, struct rdt_domain *d)
> +{
> +	struct mbm_flush_state *state = this_cpu_ptr(&flush_state);
> +	u32 soft_rmid = this_cpu_ptr(&pqr_state)->cur_rmid;
> +	u32 hw_rmid = this_cpu_ptr(&pqr_state)->hw_rmid;
> +	struct mbm_soft_counter *counter;
> +	struct mbm_state *m;
> +	u64 val;
> +
> +	/* cache occupancy events are disabled in this mode */
> +	WARN_ON(!is_mbm_event(evtid));

If this is hit it would trigger a lot, perhaps WARN_ON_ONCE?

> +
> +	if (evtid == QOS_L3_MBM_LOCAL_EVENT_ID) {
> +		counter = &state->local;
> +	} else {
> +		WARN_ON(evtid != QOS_L3_MBM_TOTAL_EVENT_ID);
> +		counter = &state->total;
> +	}
> +
> +	/*
> +	 * Propagate the value read from the hw_rmid assigned to the current CPU
> +	 * into the "soft" rmid associated with the current task or CPU.
> +	 */
> +	m = get_mbm_state(d, soft_rmid, evtid);
> +	if (!m)
> +		return;
> +
> +	if (resctrl_arch_rmid_read(r, d, hw_rmid, evtid, &val))
> +		return;
> +

This all seems unsafe to run without protection. The code relies on
the rdt_domain but a CPU hotplug event could result in the domain
disappearing underneath this code. The accesses to the data structures
also appear unsafe to me. Note that resctrl_arch_rmid_read() updates
the architectural MBM state and this same state can be updated concurrently
in other code paths without appropriate locking.

> +	/* Count bandwidth after the first successful counter read. */
> +	if (counter->initialized) {
> +		/* Assume that mbm_update() will prevent double-overflows. */
> +		if (val != counter->prev_bytes)
> +			atomic64_add(val - counter->prev_bytes,
> +				     &m->soft_rmid_bytes);
> +	} else {
> +		counter->initialized = true;
> +	}
> +
> +	counter->prev_bytes = val;

I notice a lot of similarities between the above and the software controller,
see mbm_bw_count(). 

> +}
> +
> +/*
> + * Called from context switch code __resctrl_sched_in() when the current soft
> + * RMID is changing or before reporting event counts to user space.
> + */
> +void resctrl_mbm_flush_cpu(void)
> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	int cpu = smp_processor_id();
> +	struct rdt_domain *d;
> +
> +	d = get_domain_from_cpu(cpu, r);
> +	if (!d)
> +		return;
> +
> +	if (is_mbm_local_enabled())
> +		__mbm_flush(QOS_L3_MBM_LOCAL_EVENT_ID, r, d);
> +	if (is_mbm_total_enabled())
> +		__mbm_flush(QOS_L3_MBM_TOTAL_EVENT_ID, r, d);
> +}

This (potentially) adds two MSR writes and two MSR reads to what could possibly
be quite slow MSRs if it was not designed to be used in context switch. Do you
perhaps have data on how long these MSR reads/writes take on these systems to get
an idea about the impact on context switch? I think this data should feature
prominently in the changelog.

> +
>  static int __mon_event_count(u32 rmid, struct rmid_read *rr)
>  {
>  	struct mbm_state *m;


Reinette
