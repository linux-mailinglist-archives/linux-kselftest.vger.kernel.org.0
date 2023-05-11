Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3126FFBE5
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 May 2023 23:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239033AbjEKVgD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 May 2023 17:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238502AbjEKVgC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 May 2023 17:36:02 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3793A9B;
        Thu, 11 May 2023 14:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683840961; x=1715376961;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MtCVvmWwnCXr9brkLOWZHKkH7fO28nwDqU7M544s0wQ=;
  b=Mdr5i2uv2FrHkF/C+NyFEVUn5AcXHFVp6a6pxAhZRi9Dyu5uRq8zmW2V
   E5foTd8CA6G4ae5ZEpWJMs9ocVwhKqwBZwH29d1ceWbzrLT+KMJYtyBa5
   npxDB6cJ/EIfR1Xd50ESrlGyZJfpKbMZta2i62bLmt26cGjCWsMHyV9ZP
   1cbYoxyYdibZ/xfZigyBiUR9Gxhfw1TDjhTvSw1/LzECn+EvFwA2/Hvln
   XCQt/xShdNhm7rhmqL9np/sIagoneLI5cYUpASgvVcmZTExrEROICathZ
   P8PbWbgWPdQ7uhLtT0ncA5U7DKzoq4FyR+emNgnhs/3+NgxGwFOBIPGjM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="348132279"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="348132279"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 14:36:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="946352132"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="946352132"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 11 May 2023 14:35:59 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 11 May 2023 14:36:00 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 11 May 2023 14:36:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 11 May 2023 14:36:00 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 11 May 2023 14:35:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbj0PocmSbk0PSooaXfFy4gaPIIb7XR5F9pfybQ13Te3mOMm/1hbe5lr3brTYToBwh8wNgJ4ShRfb53gJkZ5kWvYjGDvzc9WhxaJEEt9ucw3/yD3NB4UlI8e2BJ0gI1aDWG10jFiOsqQ7vZUj9J8SyxXOCMUjCq26i+gl+dPu4S9kdzB2V2pIgTtjoAMI2zfNw3z1LQdNZLW7I0R/9ihxeuCmBqkkjkPilfi9A1OKTKvGsihsERaNZVzMxs520m5Qgw/C8Aj7WgRaapGnC1f6lpKcQkuwEfZ7hBLgJv7LO8ntsiMOWEYi7G+qCHKhOiPIVUeaKvIrMzAZpg2z80BLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMREnidejR3s1rv+xGifbFWMxKS90O0TcyeWcuvPClg=;
 b=U4Z43/ri+NPFlQxkhTJNg5zvXHX4TCq6s4rEl50asbY7OGo5K3KZ8B0arvnMYhlCq6qzwXctad8B+SFqDg5hdd9V5guw0BkVUxNmU45sEGl+LREwMqZX59832ztlorv6yF6oy/47CdlN8thEQYNkuJU+j+gjyDrtD46OtXW1epxyb/5MGc0jCrkgAOLLNd+IhVn8SnXXBbqYcKnUPviCDGazGUmeQHHMgS0nKNXigGy3jhUd943Z16NUiembod+vCkmXzE11zGXj+yv6rQy+FUgWqufa7jCYKhgwYuCQwqd/O/Aj28k6wyCefAr+mysGwaLgo88HWr5BZH/92FAHMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN0PR11MB5964.namprd11.prod.outlook.com (2603:10b6:208:373::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Thu, 11 May
 2023 21:35:56 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6363.032; Thu, 11 May 2023
 21:35:56 +0000
Message-ID: <242db225-8ddc-968e-a754-6aaefd1b7da9@intel.com>
Date:   Thu, 11 May 2023 14:35:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [PATCH v1 2/9] x86/resctrl: Hold a spinlock in __rmid_read() on
 AMD
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
 <20230421141723.2405942-3-peternewman@google.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230421141723.2405942-3-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:254::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN0PR11MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: 09575de0-5c99-4076-b701-08db5267b3db
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HRrVYSvnzQAR3ME/t26NO0xx4/kE+pFzjIitTw12gn18VTABr1l+k72/JuAcjP+S+yETD7FKL3I5ea6LbiDoYBOfMT3ijqE3+JeAjTt0JabV7tDblZh0LMWWPH1zM2FEdqcO7gPzYM/tTibJ9ljGO34jwFx7815vwzAYgqd4xVLUhgs4a9onnMV/dnvVEPt4hGOMHFcmESgwZfw7/4bZptwwHptBXaqYHEy7niV86w/7NRqzIBlwoVf6SKc0BObmh6JzjGlrhKrC3DJzUDOo2cDA0MwEX9m5/8GvQY6Pa5zWKArKXod7GZIHD8bh6H2wmfjmOeNi9lnwIRRtzwBxPQDBkPBQKPUMICk17jqf3e2u9iychqfuFQBoQ7vDxvGHwsNME8ltsw/fcoAyNFSo69nMEXKBC3C2cTFmFeMPCrzBWullKhCvw6hnmUaWKuJXBeW8hBESQrYO2DKAyu9YpTevziuxTnNynhd8dYajj597MxJbDwN6byH6iZ+sK+C6rRygJf81Y0TPDdqSRCWNM8Ns8tioDwyXXgyO7JP3YOIfSVdFFGFwP7Kj4+225Dhd3nCkNVfv0KoGndVP1VN5BUVdY94qV8NYV2Lj0oqMWRvottASJhoIzkK7clozdJAV1lFn7KMAftNu2ye3s3O5LA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199021)(5660300002)(44832011)(7416002)(8936002)(8676002)(83380400001)(2616005)(2906002)(186003)(36756003)(82960400001)(38100700002)(31696002)(86362001)(6636002)(4326008)(26005)(6506007)(6512007)(6666004)(41300700001)(31686004)(66476007)(66946007)(66556008)(478600001)(316002)(53546011)(6486002)(54906003)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzNDY3kxQkVQdkYrNGt0dHJraFBzazhZWXV0SEdYQkZ0SjVaM3FTRW5Tb0s5?=
 =?utf-8?B?Z2QzY1MxQ2h0UkQ3VE1HS3QvTmNKRm1JZUtmWUZHM212b3FQTXlmWlZ2TzRy?=
 =?utf-8?B?bkg1UnBGclZrTEd4blhJQmFOYUZwN05YMkVkYXdGMHNCWTd3blRqbzJoeHNz?=
 =?utf-8?B?WEFKY3pTdGEwOGRLRHZWeFovbjkyblZyN1JqQjJ4aFdzRU9ZM0l1L2lScFBo?=
 =?utf-8?B?MHVtenNrb3FETk95c3lDRXhlZU5qK0JrQjJCRWd2NFVOM09BMktDTDN1bk5Y?=
 =?utf-8?B?M2N4Tm45dGptaDJJVm9ZSytwMHdGSnh4di9vRlhrb1BTeExQb29qZEt2cHBM?=
 =?utf-8?B?dzNBbHMrYWl3UThiYUFzcXMyeWRBbUNBYWZ2RENwWmdpQk9HajVlZVFrTmtE?=
 =?utf-8?B?bkJnTnpWeUkrc2h0TU1TcmVmdnhSK09pSHFkWCt1a3M0TjNNcW5pL08yM0dy?=
 =?utf-8?B?bm9MVTNzbE82anAxOE8zbGRYaDhCYUdRbVBYMWJLU21uVll1ek04ZU9FaUFl?=
 =?utf-8?B?K1I1M1AzZ2hoRU5RSlBkUnRibDZoeFNVZmVwL1hvS0JjelY3SGthdXhSaDhK?=
 =?utf-8?B?akV6L3NmOXV0c1hiQnpKb1pjSzhqMUpqV0J1WFBya29na3hLdUllejhzb1BO?=
 =?utf-8?B?V0JodGUzMzRBUzc2T05LMGlrLy81SlBwa0oza01pU3c0VzBUczFWeHZJYzZH?=
 =?utf-8?B?R3NsM21DNm5zc1BTbFRaTFRmTkhBL3lrUnBDcUpWYWlHWTNwSlUrQUdJbWx4?=
 =?utf-8?B?cFRBY2dXbTQybTdIUGordlhRQ1RnTDRBUGJjUGsvQ0xBa0k3OHIzZXJ4aFAz?=
 =?utf-8?B?eEIzQ2x4MnFyWlRqb2kvZGNBTGlDWk95cTlkV3NhSnRhR3BjZHVUZDlqSjY2?=
 =?utf-8?B?eUNjbGNaTnpXWGkwWlhJN3psVVptMFJuejk3NTdNdWVxbFpkc0RvR2dHbTZK?=
 =?utf-8?B?LzJaK0hvMWZuTWkyVXNjMVV5QTZ2bGMwR0thZjNRQXE0WnVsaDdmdmlYNS9I?=
 =?utf-8?B?MXJyOXR1dXdpNGo2dG5WeHlveVJUK2xrRWJKUFZUMDltaDVlOGl4SWszcGFl?=
 =?utf-8?B?VGVQQStnTkJXZTdpaGF6dmVtVjg5SlJrQ25YQmhBbVJTbE1KZElvYXIyS1o2?=
 =?utf-8?B?dFhhd2MyNEFabmNwMUEzVlpVWlhHdG5BeTgzeWtObVdpbUtDS0lHM3l1b0VW?=
 =?utf-8?B?T20xL0JTdFRTZ3NKaXY2RG40eVgvbnR2b25LRC9WZXRCNU90c3dSbjh3Vy90?=
 =?utf-8?B?dmhSWnk4b3lWUmMvRFo2ZUF5SitydDhwaDNvcmRzMXBSWGNsbEhUQllVNXN0?=
 =?utf-8?B?VmdGT3dBWENGZjQ5Vng1K25zVHdOWGhsbTRVV2dPbmEyQ0dCZDQzUDF2ZUxp?=
 =?utf-8?B?MmdHUTlDSFZ6TFltSnR5NENSODFzVzhaNFZQSDVGcDBVQWI0MjFvNWM1SEln?=
 =?utf-8?B?Y3BvVGhEbWthZk1ZNTF4blVUY2w3OUZ6N2dIejNmRnZabWgxbmNNSkljNnVi?=
 =?utf-8?B?TDZzRGh5eStOV0JRQmlFVFBWRnJleGtvRnNsQjZGKytPNVRlR29XNDNsMFdT?=
 =?utf-8?B?OXhGRVlVcjNHQ21TTlF1Y0g5cmQ2WG1yZFhDTC92cWdKa3BzdmIrTU82T3Er?=
 =?utf-8?B?NzlJUFRGWjBZN210ZnhEdEJodnZrTU5kY1hwNlJyWjBraW1ydFlpamdOOUZj?=
 =?utf-8?B?ak8rV29sdTBiZkdEY0hCR3lKSW5rMURqVFJuQ2tWVWQzNFZzUDQ1bnduYWdw?=
 =?utf-8?B?by9UZm44b3V1SFl5T0ptT2Nqc0QyZzcvTVBwdTFGY214eHdsUjZlbE4wY2JO?=
 =?utf-8?B?RERtSkhvQ0tyQVRoS3BMRytqeGZtMzVRMFE4WEx2NzhubkNkcElSZWQ0NGZY?=
 =?utf-8?B?MVQwb0Y1YVI5T0ZsRzlPTlkveHVYQ3VEMCtyTjF4Z1g4dE1rZ1lLNS83MmpZ?=
 =?utf-8?B?N1dSK3Fnc2NNQzFaOFRnMXQwS3BrdEtpdFA4RXd2bm5QMlM0MG8xdlMyTXRs?=
 =?utf-8?B?bW5ydjk4aGpxVmswZHcvVVk2WXNxT1Z3Qy9nNzBRZUE1dkJHaGVnSEhHdFlM?=
 =?utf-8?B?U1laMkxNcmR0NTZVZ3FFdVJRQmt2V2VEZ3NZMzNnL1BsaVZ6SElQMDJVKy91?=
 =?utf-8?B?ZXBBaEs3QUpYNUhxRnBmZDB6dVdOZ3FSN011enR0YkR4UHJucWN1cVFkeHcy?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09575de0-5c99-4076-b701-08db5267b3db
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 21:35:55.7777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOEKb8kdOaCt3Bpte2tBaDeyBlXKQLoIiOzTGc52mTZL3r4Txkto58Ti0WJGnYm+hEYQu4Kforo+ojLIcwH2tOzrgANR4g+q5fybfOO3Wxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5964
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Peter,

On 4/21/2023 7:17 AM, Peter Newman wrote:
> From: Stephane Eranian <eranian@google.com>
> 
> In AMD PQoS Versions 1.0 and 2.0, IA32_QM_EVTSEL MSR is shared by all
> processors in a QOS domain.  So there's a chance it can read a different
> event when two processors are reading the counter concurrently.  Add a
> spinlock to prevent this race.

This is unclear to me. As I understand it this changelog is written as
though there is a race that is being fixed. I believe that rdtgroup_mutex
currently protects against such races. I thus at first thought that
this is a prep patch for the introduction of the new soft RMID feature,
but instead this new spinlock is used independent of the soft RMID feature.

I think the spinlock is unnecessary when the soft RMID feature is disabled.

> Co-developed-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Stephane Eranian <eranian@google.com>
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     | 41 ++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/resctrl/internal.h |  5 ++++
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 14 +++++++--
>  3 files changed, 57 insertions(+), 3 deletions(-)
> 
...
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 85ceaf9a31ac..02a062558c67 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -325,6 +325,7 @@ struct arch_mbm_state {
>   * @ctrl_val:	array of cache or mem ctrl values (indexed by CLOSID)
>   * @arch_mbm_total:	arch private state for MBM total bandwidth
>   * @arch_mbm_local:	arch private state for MBM local bandwidth
> + * @lock:	serializes counter reads when QM_EVTSEL MSR is shared per-domain
>   *
>   * Members of this structure are accessed via helpers that provide abstraction.
>   */
> @@ -333,6 +334,7 @@ struct rdt_hw_domain {
>  	u32				*ctrl_val;
>  	struct arch_mbm_state		*arch_mbm_total;
>  	struct arch_mbm_state		*arch_mbm_local;
> +	raw_spinlock_t			evtsel_lock;
>  };

Please note the difference between the member name in the struct ("evtsel_lock")
and its description ("lock").


>  
>  static inline struct rdt_hw_domain *resctrl_to_arch_dom(struct rdt_domain *r)
> @@ -428,6 +430,9 @@ extern struct rdt_hw_resource rdt_resources_all[];
>  extern struct rdtgroup rdtgroup_default;
>  DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
>  
> +/* Serialization required in resctrl_arch_rmid_read(). */
> +DECLARE_STATIC_KEY_FALSE(rmid_read_locked);
> +
>  extern struct dentry *debugfs_resctrl;
>  
>  enum resctrl_res_level {
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 20952419be75..2de8397f91cd 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -146,10 +146,15 @@ static inline struct rmid_entry *__rmid_entry(u32 rmid)
>  	return entry;
>  }
>  
> -static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
> +static int __rmid_read(struct rdt_hw_domain *hw_dom, u32 rmid,
> +		       enum resctrl_event_id eventid, u64 *val)
>  {
> +	unsigned long flags;
>  	u64 msr_val;
>  
> +	if (static_branch_likely(&rmid_read_locked))

Why static_branch_likely() as opposed to static_branch_unlikely()?

> +		raw_spin_lock_irqsave(&hw_dom->evtsel_lock, flags);
> +
>  	/*
>  	 * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is configured
>  	 * with a valid event code for supported resource type and the bits
> @@ -161,6 +166,9 @@ static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
>  	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
>  	rdmsrl(MSR_IA32_QM_CTR, msr_val);
>  
> +	if (static_branch_likely(&rmid_read_locked))
> +		raw_spin_unlock_irqrestore(&hw_dom->evtsel_lock, flags);
> +

If the first "if (static_branch_likely(&rmid_read_locked))" was taken then the second
if branch _has_ to be taken. It should not be optional to release a lock if it was taken. I
think it would be more robust if a single test of the static key decides whether the
spinlock should be used.

>  	if (msr_val & RMID_VAL_ERROR)
>  		return -EIO;
>  	if (msr_val & RMID_VAL_UNAVAIL)
> @@ -200,7 +208,7 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
>  		memset(am, 0, sizeof(*am));
>  
>  		/* Record any initial, non-zero count value. */
> -		__rmid_read(rmid, eventid, &am->prev_msr);
> +		__rmid_read(hw_dom, rmid, eventid, &am->prev_msr);
>  	}
>  }
>  
> @@ -241,7 +249,7 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>  	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
>  		return -EINVAL;
>  
> -	ret = __rmid_read(rmid, eventid, &msr_val);
> +	ret = __rmid_read(hw_dom, rmid, eventid, &msr_val);
>  	if (ret)
>  		return ret;
>  

Reinette
