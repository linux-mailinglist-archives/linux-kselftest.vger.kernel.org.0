Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09C76FFBEB
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 May 2023 23:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239346AbjEKVhv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 May 2023 17:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239164AbjEKVhs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 May 2023 17:37:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABED6587;
        Thu, 11 May 2023 14:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683841065; x=1715377065;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NrbWqGnuXZ0PES6SXlx9bOFgkeP936Lx8OpR8qhjCeQ=;
  b=nSZ5wATgMq3hlc5jH00jkBI4xW9E9A7V5h+Ct+iSA3iBgTQ8ONpgiHIu
   I+Le5t5MUziWbvqj3Px0xE4iTMOsQtln2bU2pYNDCJQAUsKMA/SVVYkHf
   YZWaGoV3Zg7UTMoOiJ7SNdjNZyAyKUVGZEENrp/oaytcEctuyh+zn8avA
   F7yZ29MPBHqrsOnmG8mQiEZt6iMPEtXCQ18qAd16vi+Mf7J5yIe3KOQuO
   yxulZI4QjbyieHz087dZ4axXe0rDCaoAdBSkIQOiDJJUADQT8EkC8UFwW
   yqCy5Bl0jjPvCDEpwosT77Rr0aMRkfxE9R1a/mwg8Yo5n7HHvvmW1w5K3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="352878080"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="352878080"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 14:37:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="1029797609"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="1029797609"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 11 May 2023 14:37:42 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 11 May 2023 14:37:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 11 May 2023 14:37:42 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 11 May 2023 14:37:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GulfTGTDv5nCGKn6WkxKt3bjQscjjpu0qxnOdA3i4KxnYu4W7w3RZarNEmjDE96s/6mLV+ujELCipzJ8tKFKwd8e7ktpFcfFxyayyH9lcLMJeOlrQjltsuXYsEbofz8aYtuEEPZKwh1S2O+VM7DqHdRUOQZm4BQMln+aw6PWJ81tNo2/oMvkiQqBxHvvK1Kip0JoLyrSXmG5wdXE6MGW/NlQ/Cop19Mhal088GolUBj34jLic+WlBy2WBFwwrINn8nAva3rfVOcYAv2PcBdefl5Nk8rLvzxxTARjnrbrGIcqHwT+7osOHnltO3cLZLqkBAPUJH1/nWj7BzXX3VVF7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDB9KHJqNSGHygcfQKt69LNj1k3Jxhz0JSeg6zDjxt8=;
 b=Ob/UdF3YkORviMvQIx53M+Ptb8bGwgftp+UNDeEjwOZWU2Y9jDlJy/1J65Ni/tryRgxKYZqop1IfMlk/a12OT5Ny5ih8n8TWvTmdGkSqMkKNLUtlcgITP4ei4e2nyZAhfZBWY6KjiCRnUyR5ExR7jAzASBJ5ptw6BdIYP22fOpRCQpx8RlF/W7raxvFNyvGQp9C89QLIsF0RuiO2xGdwgnOaFodfq6bA1coF8gtg3uFD4gYvVkWHV//Sw7lo556XjIWj/didI5YPl4pUxFXfodGCxPuugnAgr+p3mEcheaAMj/VhGia9OBTX0CQyaXqO8FNQteeK9Y+9iYHk/biL+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN0PR11MB5964.namprd11.prod.outlook.com (2603:10b6:208:373::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Thu, 11 May
 2023 21:37:39 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6363.032; Thu, 11 May 2023
 21:37:38 +0000
Message-ID: <c093d8b2-d6c6-237c-ffd4-0cb1565e971c@intel.com>
Date:   Thu, 11 May 2023 14:37:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [PATCH v1 4/9] x86/resctrl: Flush MBM event counts on soft RMID
 change
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
 <20230421141723.2405942-5-peternewman@google.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230421141723.2405942-5-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:a03:254::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN0PR11MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: bf8bce98-dbb4-47a2-e707-08db5267f159
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yrBRYYqJRK9EK6Fu6AJfmMCPq0elJm4ZARwqmF5Rt5emlsDvz42XoNcusfeixIP0mu+GycI3JV83EHigoEjHqZR1OAj2IuoxSK0q66TkhIF/hh0w6oOMVsBypxUcE/3VjgYMnCd7JfJnbCSiusruRBWijo4KCWU6OShu62qjBR/n1gELEwULFd7RFqK0ESzrwNpwf75Xwuuy9HJyvA6As+MzdIZXRhOVCKGtqvDPkKg1VTKD3ym9pf4JqWQOgIomTX/6ScVkE2J1hlNmBuEXxfM1x+hwuVqtvDx7ITSTUkK/Vnj4mylnDtMTw88a3o28gbHk1q/TxMlxeER8anPgq6KayZuDzopw3UxX2FounMCZc745a/o5oVI31JYPZ7X97Hsio5V3cFw+yNcmHsbt1MQmFvb7jlOAOGx3dEUrCsfTkLPpoyih8puugGG1A+izyvZVRxzFMIsisFhdX4TFw9YhnNDQgHUv0RDvkGwG85I7PJwQDYrwMDRKcqWn9xwurDkgQU2GxxgkT/M8FQqZogmp9b6t6+GofS73GC3mgjDP5eDf4zn7E2QWbThYZrVygvIZmICa7yoqQM3Xd3sDwKvXUfDGhTBlMPJzV3LBpwe+DQPCPRIL+2AeGTZf8EARQPuMMaUhYHRDP1rK5zzYtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199021)(5660300002)(44832011)(7416002)(8936002)(8676002)(83380400001)(2616005)(2906002)(186003)(36756003)(82960400001)(38100700002)(31696002)(86362001)(6636002)(4326008)(26005)(6506007)(6512007)(41300700001)(31686004)(66476007)(66946007)(66556008)(478600001)(316002)(53546011)(6486002)(54906003)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VElFVDdsaW4wZFdpc3NYYXJaNkwxdmhPZXZieEh4cDgybGVWRXFRaXZPSWRX?=
 =?utf-8?B?QVFxVXVyWHVvbXlaTW5QeXVhNU55OGhjVllGL2FhdlFOUVRhNzAxYThjaVYv?=
 =?utf-8?B?ZGVjUWFnZVdtS3F2Wk56ZnM5NE10Sm4yekhjUHd5WWZnTWphVFJiMS82WjMx?=
 =?utf-8?B?aHZGOXF3T2dKbTlTV3V3R2Z4a0kvQ3RDaStvRGpjZWpNWm9QTnkwWS80WmdM?=
 =?utf-8?B?ZVNTemNMMmpTb0w4ODY0emVlTjNwZUU3b200VGxCOE9pNnUwMFcyRlVhUjEv?=
 =?utf-8?B?aXRCeFdtd3FQRjg5RUNaUTQxV3ZOVHJuWlVqRVNYbmtYUkxvOHIyUERVZ0xa?=
 =?utf-8?B?bkV5K0E5Sld0WmxJaW01VXpCK1FseHZaRWUrb2tpZUxOOUtCSjBScVhtbjli?=
 =?utf-8?B?L3R6TjgvVmR5U3l6bDM2Rjh0OHVqZmV2T0diT2lwdzJ0WGRhM2F0dWo5Q2Jr?=
 =?utf-8?B?MmQxSzh3Q2hEaS9LZnV3MDV2NUszbnV0S3IzY3VkVUVEcnlZT0pPQ2o2Tkl2?=
 =?utf-8?B?bFJGVHlueExpUy9NdTJURlVQcEJSeTRMM2YwK0lpbng5NGswV0NzaEFRMGpw?=
 =?utf-8?B?NXk0ZGFrWUhaVURzcDcvb2FyRzI5ZXd3MFFyT2QvbUhpZDBBcEMvVzA3MmVQ?=
 =?utf-8?B?b01oNjFQbnNyOWJOYWVjcUF6bVNWOXBoZDIxaHJ4a1lNc2ZzSi80eDNYZlFu?=
 =?utf-8?B?a2IwMmtqd2JQd2hjWUtnR3JnTnROc3liMWVCT1JaZUJDWkVVZjRIa2FNU1JV?=
 =?utf-8?B?aVpRR09saFZEU1ltRHo1d0dwM1VJbERyS1hSQ2xWcEorTEwyMDc0NjBNdGJR?=
 =?utf-8?B?bzAvQXNjQXkwVVVTeTJQV1FEZ0VGNFdLaVdROVd0K3J1WVZ6aG9URjkwY1dR?=
 =?utf-8?B?L2Z3TW9NSTRUMk5lUUZIMWJkYU9GdCtpSWJmMGttZG9ZQVdBTVdEQS9HTWo1?=
 =?utf-8?B?RUZZNHAydS9ESlp4T2hINWdaTi8wN2V3Y095bUpIWUNLZFl0aTNNeUlUVzI3?=
 =?utf-8?B?eDhVWWtVUE1QcmQ3eWx2RENJV0d6M21GRHR4QVVzZWQ1M09hb0RPK05PcFZT?=
 =?utf-8?B?Z050NHBVSGhScU9GOGEvUmtoMFZLVTZHL0lYVFRLRk1KUVZNdE5iOTNJVkI5?=
 =?utf-8?B?VVN2UEh3U0hVRGZXd1cwTDFKVlRYMVdOZnlVbTEvQURNZ0tsMXBJLy9kampn?=
 =?utf-8?B?b25RM1JVdkJxbUdVeVlONXRRQlFTMGU1MDQ1Y2dKRnVqUXBYRmV3TUllNWQ3?=
 =?utf-8?B?UlNtdVJBcEtKNjRoUzVzdkZwWExrbGRHV2NvTjJmOXMwTDdWVlVDMWpBUG5H?=
 =?utf-8?B?Tm01N0ppSXhYUVdnRTd3OVFyZllKTVNPVzBRdlVtYWRtYkRoUmxlYm5vMWxF?=
 =?utf-8?B?QmlydDlKMURJT3FJbm5DZE9QZVg2TlFOOC9Wc0o4cWY4dGxPSk1YWjdNN1M5?=
 =?utf-8?B?OEFsWHFyWk5pT1lqUE1TR2RmcUJwYTFQMFEreHV5ai9EY3hodEZvZ2FJV2RP?=
 =?utf-8?B?cVV3bCtMdGRGMk9wUVYzWW03dExaRzJEekJzZGRqeXRUcHhWSG9wTm9OeSs1?=
 =?utf-8?B?azdteGo4TkVDTHA3N2JnTUM4UFBMdEFhbWFpanZLVnNFRjhUdU9GQW4vWitY?=
 =?utf-8?B?dERDZ2FuZTRIVnNHTXFvbjhtWCtpd1ZQLzVCNXNhdUN5V0E0eXdlWTVaeHlN?=
 =?utf-8?B?ekVVRjVDYUVxUks3Nkd6VzVlUjVZWWI0Z0hVVXpQYk9Pdlh0UFhRNldsbzI5?=
 =?utf-8?B?NmtBajVIRzRnVUlxYTJFWHFseEs5N0YwRFBVZzNSbEt0eVhRc3NQUVJvWXZl?=
 =?utf-8?B?LzFDdENQZ3oyOTF4dGFvNDVCd1phYlhUWXJHNmZsOS9WYUlTMVRMQnIwMHZr?=
 =?utf-8?B?QUMzRk54R0I1TkoyZVlIaFNJYnppOG9GcFVKaW9MOUx2UFBSazZYZ1NjSDNE?=
 =?utf-8?B?UVNZVGN5bmEwQlF0d2VpUUdXd1JOaHpyNHZFYitXUHZISm1GZytzNnRTK2Nw?=
 =?utf-8?B?bU9KTHI5dklDdU05MHNIRGhwaXpWbXVidjRmUkl4Q2VpV2Q2S21kdUs1NDlZ?=
 =?utf-8?B?UFJhQW1VNG5SSDMzeUJpWlp5cnNzellnL3BXdDg5cE1TUVFta0NTcHc2NVVt?=
 =?utf-8?B?ei83YTI0WXBRMXk3UXBvQU5ZT29zQm5COUxDVU5DUEd1L0tQVUJqS1Y5T05v?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8bce98-dbb4-47a2-e707-08db5267f159
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 21:37:38.8894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jw9LT3mpD3M51AgUxBx2IEx0RggFalDG6qCuqObEQaeFz8J0BTla4i+4OKgrxxdYZodKTu8xNSUtSC/68es+txA8z1UF+F7mSMgRHZSXWWY=
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
> To implement soft RMIDs, context switch must detect when the current
> soft RMID is changing and if so, flush the CPU's MBM event counts to the
> outgoing soft RMID.
> 
> To avoid impacting context switch performance in the non-soft RMID case,
> protect the new logic with a static branch.
> 
> Co-developed-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Peter Newman <peternewman@google.com>
> ---
>  arch/x86/include/asm/resctrl.h         | 27 +++++++++++++++++++++++++-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  1 +
>  2 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
> index e7acf118d770..50d05e883dbb 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -36,6 +36,9 @@ DECLARE_PER_CPU(struct resctrl_pqr_state, pqr_state);
>  DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
>  DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
>  DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
> +DECLARE_STATIC_KEY_FALSE(rdt_soft_rmid_enable_key);
> +
> +void resctrl_mbm_flush_cpu(void);
>  
>  /*
>   * __resctrl_sched_in() - Writes the task's CLOSid/RMID to IA32_PQR_MSR
> @@ -75,9 +78,31 @@ static inline void __resctrl_sched_in(struct task_struct *tsk)
>  	}
>  
>  	if (closid != state->cur_closid || rmid != state->cur_rmid) {
> +		if (static_branch_likely(&rdt_soft_rmid_enable_key)) {

Could you please elaborate on the choice of static_branch_likely() (as opposed
to static_branch_unlikely())?

Reinette
