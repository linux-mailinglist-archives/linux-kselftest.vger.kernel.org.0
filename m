Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9AF6FFC01
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 May 2023 23:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239419AbjEKVlf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 May 2023 17:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239425AbjEKVlc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 May 2023 17:41:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7313E6A52;
        Thu, 11 May 2023 14:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683841285; x=1715377285;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=USb6atDLMfV3uIalyKRjhPqvEoCRYFObYyrgUHZ1sLM=;
  b=ejA1fzIPCZmf9EYJUHAlD6jUdH9ltYd+0SM+zvy0dDD7slb+MFVmNztF
   PlDvOpJ3K65zyxvIlPYCXUeVg1tc9MovbrI8wSAUq8c+6AQwoWMMqt5j2
   suu/8+t7kJgWsS5iQc9qGqkGJF2BtJNLtTPcPuZgu171YR5S9V9u+8xjM
   rHuURs6JCDX8N8hjvBXwTjvpksLdvUAhrskbf5mmXPK3sxgszljuQWGTg
   vsBiNs5FJuLVEqj6pE2DubeWNxjnqGqleYv4DcNXrwtCnqGZ83XL/EFOm
   KyllIcjRpec+he0EMIbjE9cu4UWYp69Tlm9PrvptvfoMOUJ8YbpDaV0kB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="330258359"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="330258359"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 14:41:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="650392878"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="650392878"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 11 May 2023 14:41:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 11 May 2023 14:41:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 11 May 2023 14:41:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 11 May 2023 14:41:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKMrqiA3d036ScglSTvrdz0LDLaZdZaAgL6Ywycoqw0Y0ZvRYXxMWSDznQg46ON4zfv5PtHH0C9OnJugOKkPJvNfbRuqmBS1EnJPU4W6AjK93mmzLWkv0SiZ3y8nE+rJ65yM++agqSF56sD1TzOrzL70t9b3aalmHpZvgdHK3yCDkqOCenOK+Cs2oQ8nkglntboOExsZXM9SBe+cNjgjGhwpny9YuqV6SOuagIFGfOxCHhE5TolT8g++8Ksv0rW5KMtNiA1NWNmT28C9bl3jHQUy/gvm2obfGrOBTlZgZre/nHfNZeMyPDdHZmMnrkqYjjklAKMSRev4OUnog7Hq/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BR1lA7LM+WK6y+Npl1zpo5qOGRfiDMVwZUFV3Kl4O78=;
 b=hcKZgsXvcap0TuPITe9ELklqB/ElWRCKisfopoUGxTumXeKTicG9DdlK5TriDnYRNK9c2sD0uJcItZwHepKCZWgIMPmoqHvHzyX1tn6owAZ2Ka7t5r9hAp59a3WRoJ5CDiynhgzVpKTMdKOXTEtu8UZf1DM/sN0DC5QfIf1P9Hbw+gh8eSVCYgEkLyX12nu7HSYZmZTxIq4hJf7pwtt743dW9voST+1XF3f3qPEjN4b9sIwjUXgS/l1E/O5dNqAdzjyU8/dyZVF4GUuB82752sHZgldQVbwKkJhJmA6kM1QkiqWIgVpxfz6jyefwyJ2j0A8sBet8Cq9gSRrdUWchXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN0PR11MB6109.namprd11.prod.outlook.com (2603:10b6:208:3cf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22; Thu, 11 May
 2023 21:41:16 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6363.032; Thu, 11 May 2023
 21:41:15 +0000
Message-ID: <78f3f6c9-c051-6004-570e-25966b1bc58a@intel.com>
Date:   Thu, 11 May 2023 14:41:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [PATCH v1 9/9] x86/resctrl: Add mount option to enable soft RMID
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
 <20230421141723.2405942-10-peternewman@google.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230421141723.2405942-10-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN0PR11MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: 555ffced-b700-42f7-e446-08db526872a8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sRoML6W7AAINo5UVYQFpCEVkxxh3UpIlbWYpwc+1wIwIM2SBOCsjCfqAwPxLbwm8bp0ouD9OaKsYCGJWaMBvw+EhxSA7tRAaNJnVqfhyz25blR/enicUjjDK6kyA1WujjQOssRfFQ+vU7gUUEM7Xik1Hiu1nMjQEXK17exGgf4p7AwyvWoNYsLnI2+i9LftYKFXUmIOu/C7QMVEBfblMh46RoD8HVcOr7xfzV7UHHBviIPIst8WxSseq1j+26Gb8oNgP7ZPpxuMvpuaa74Q8/pWAGF5tc7dl9Oi7Tj3xouRzARjukT4i1TpO5INLcelMUnj7P3+lmzBEmMW7pKDeDYHb3pN6IQq/pxTvDAsA5Mcxbks6zuNoeE90TP3t/bpK4o7+v7P8wqm7ZidR3LsDmQEwOaV64rCXzw8VYP8mjy06D02jwXOynx0E4jmIGhnjI1G7SCiFLnDn+zEbwgBitdOhIa7NPvor+oKnPaa6C9Xqc5vC0FZ+S+gVyOaG+bCxTa7PFDWr9iGevQxUhOCR5CI8+yCZCdpuR/BsjBq/LuuI+omzVtB2lKRCWJ3Jtfi1WI7+nqu0345POmRyhh3peq3Q01xvzP6ZA7RFIrgFZAkdhuURHmtLE3Odq+q+9mgtDtnjWsUEQwHpFtgPly28Eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199021)(478600001)(110136005)(54906003)(7416002)(44832011)(5660300002)(8676002)(8936002)(2906002)(86362001)(36756003)(31696002)(66476007)(6636002)(82960400001)(4326008)(66556008)(66946007)(316002)(38100700002)(41300700001)(31686004)(186003)(6486002)(53546011)(2616005)(6512007)(83380400001)(26005)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3pZcWZWSEFhRDhzZnpyNndLYVFBeWRjdUM4UE5Xb3h0cVRCOHZrQkV5eHRC?=
 =?utf-8?B?bTgwN3Q0cHZua0JvbllPQjh0MXZlUmF4NytGUkFITXlMMTkra1hZd3V2eTRi?=
 =?utf-8?B?a3NKZE1kaXJ5Ym5vaWF5UWQxVXdtZFN3T1dBK1k3bDVvYkFoeDc2RXFndGhz?=
 =?utf-8?B?VVRya3JHMFJEVWZhb1BneHFiVHY4dkw1Y05XYVpKVmZ5alBxWnRRMjhBRXpw?=
 =?utf-8?B?TEdkUS9LbVFXMjg3bEtwV3F4L0k4aTlWRitTc1AxOG8ySUxQdStHSmZBY1pE?=
 =?utf-8?B?UFd6U01zbEFLaUJIcXlsR2Nub292VFNicmlOZEo1TkxBSzd3MldWbk9tMWpC?=
 =?utf-8?B?Vmh3a3lnemF5azQvdnkzOElvbElISUkrV0hsbWtncjBjQTJOVEl3VmlCUVlW?=
 =?utf-8?B?amJzeGpNbXJqQkNzZWlmUWJvRHNQb0I0QXhhWWVRNDJNNS9ramlLS2poOTdG?=
 =?utf-8?B?elJ5a25aanNjVU5JZkZ1Z09ub2Q5UU16WkVvbHpqVFdUbXM4b0FTejkzNkt2?=
 =?utf-8?B?M1FrdkNBRzY4eHRET2RRdDdueTZlNS9LWW5HdnZTV2tlbTZvQUR3aTkyVjBD?=
 =?utf-8?B?OHZNM2RxU2hDd1l3Nmh2SXkza1hTdXgyay9zT05vazNJZTlFc1pmY0Q1Vmxm?=
 =?utf-8?B?R3JWdnlZV3dKcmdLL3JBeC91R1YxSFMwaU1vREFsUWdLWXB1SWNWTitaV0pq?=
 =?utf-8?B?aTZsdjFvVEVLL2FVdXh6Mk1ReENOUUVmSUJabnFUSVFNaDBPVmpsRUVPczEy?=
 =?utf-8?B?L2FWajE0UUdrQTAyWXV5dnFrY0Q3WHFZeFJlcU1zQ2NlZzd6dllQbDRIQ0ZZ?=
 =?utf-8?B?N0x2bzlvT0d0eWc3RmJsSjRubmJLRm9YeG1iVEdVVGtLMzlOMkhWbmFXcnZo?=
 =?utf-8?B?UURIeVhXemZPb1RlSG80L3NRU3UrNER4a0Z2V2hHRU4wYkgxcDB5UDVIdENB?=
 =?utf-8?B?dWhiWXRkdy96TWozdVZueGZVMkcyT2N2MnY4M0VlTWxpUFVGYnJLNW9QdVM0?=
 =?utf-8?B?cHJFY0xhYjZsTE5WZFZmNjVENVdSajZ3NWJWeHpNRkV1V2JQN2xkUjJCc2RZ?=
 =?utf-8?B?N1YzTVJURlluUHRKY1U1SWZHRW9sUUU5RUVYSDV1NXZoRUJINDFpNDVDbUpD?=
 =?utf-8?B?YlRHeC9xRC91d21vRGVCaGd5UVpMcVNOVUY2ampKSmlPS0pXWFR4UUREY3JJ?=
 =?utf-8?B?elJUTG9nc1YveG5WaTBmWmMrWE9qQXdhWC9wYVEvMU5YcVFlZjNicnZvbUFs?=
 =?utf-8?B?aWJoWmMyZkNaTndja0lVdE5yakNMT3N5TUhPcThNNnFOL1N1Nmx1SlVGbGFi?=
 =?utf-8?B?WFBpTnFvNU5Pb1JvS3J4Mk5YOGdUdkYvcnhrNEQ2V2JFb3RMZE9YaUpkQmhu?=
 =?utf-8?B?cTY5VGVRcjFxdGZkV2ZrYzZURUtvUFRVT2ZRME9uMzZDTGZiMXovWUhLa09T?=
 =?utf-8?B?ZURtVmRwTmZLek1vbjhSMm9KWldoaDJBUTRSbXp6UUE4Z0c2anJnbmNVTXVN?=
 =?utf-8?B?QmNWcGZlVnBucTV6YUs3ZGlwWFZaNFNpYnBhUlFRQ0dzU0JMY1pjUjBVNDRT?=
 =?utf-8?B?SzJJdTFxTWtwcThxUDlTTmR2YUNOWHJYcm5iWDlkQVkrcndiYWVUbngzK2sx?=
 =?utf-8?B?djVUem93NFpLMVkrOCtuUEd2eFBleDkzQlFaNHBCOEttRmdGY3BjMWkydnVq?=
 =?utf-8?B?TGdvMXRRaHJpWDVJS09kMERDS1FycnFLQTE5ZUtGY3dla05xVGJ2bkVVTzVL?=
 =?utf-8?B?VmJMUUpPamIyT1hhK0NDeHQ4MlVRMzYyOThrVmNOZzNEdE5jc1kvZjJ4ZC95?=
 =?utf-8?B?YzBuL1hzVlpUKytEM2tJcStNQW5oYU1RS3ZjaXpRQmkrUEZFRGlqZjJUdFhM?=
 =?utf-8?B?ZGhWY0gweVIwRFg5QlY2QThMRStqMElIRm1sYjlSMmljQk1wODVQbjNpaVp1?=
 =?utf-8?B?bkFKT3hkT2RaMytaT3Q1cWtsOVpEdmRsNFdLVHQ5NW56VUxoWEtZd1lReSt4?=
 =?utf-8?B?cnkyOXE4U1daSmozQ2dVeHAydFFNUEFSdGVZM2YySjVvU0tlQ2lqUTdLemlo?=
 =?utf-8?B?U1pwRnJWZ2lwSFFVZGl6dUNUQUsyN0VJZDJ2WVFEY0w0Z0pMWlFYclNGc3Ur?=
 =?utf-8?B?YTdlSENPZVA3SVNsRjlGM0JlUlVtYUhibS9tZDgwM2s4S2hubjdpZjVpbysw?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 555ffced-b700-42f7-e446-08db526872a8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 21:41:15.8365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: blYCgiBd37OLhGFn4lSX6/l6guHGhaD7COmDWZIRHGXq+GxQReUUijYKu4t6G0SDiN+9arjwE6c34cX8TPHx1zzXkZjAKihmVNrkMEQRo30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6109
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Peter,

On 4/21/2023 7:17 AM, Peter Newman wrote:
> Add the 'mbm_soft_rmid' mount option to enable soft RMIDs.
> 
> This requires adding a mechanism for disabling a monitoring event at
> mount time to prevent the llc_occupancy event from being presented to
> the user.
> 
> Signed-off-by: Peter Newman <peternewman@google.com>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |  3 ++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 51 ++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index e6ff31a4dbc4..604e3d550601 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -59,6 +59,7 @@ struct rdt_fs_context {
>  	bool				enable_cdpl2;
>  	bool				enable_cdpl3;
>  	bool				enable_mba_mbps;
> +	bool				enable_mbm_soft_rmid;
>  };
>  
>  static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
> @@ -76,12 +77,14 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
>   * @evtid:		event id
>   * @name:		name of the event
>   * @configurable:	true if the event is configurable
> + * @enabled:		true if event is disabled
>   * @list:		entry in &rdt_resource->evt_list
>   */
>  struct mon_evt {
>  	enum resctrl_event_id	evtid;
>  	char			*name;
>  	bool			configurable;
> +	bool			disabled;
>  	struct list_head	list;
>  };

Note the description of member named "enabled" of member
named "disabled".


Reinette
