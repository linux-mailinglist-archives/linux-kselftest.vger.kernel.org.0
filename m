Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624DA700B8E
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 May 2023 17:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241862AbjELP0w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 May 2023 11:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241787AbjELP0v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 May 2023 11:26:51 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921C41FFA;
        Fri, 12 May 2023 08:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683905209; x=1715441209;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZiVJRZcjrxHPdXQa/Lv+J5rzVg/1peIvhqnmJqYHnio=;
  b=R9DkaHaGcVi7N6ZLRAw840+xfRKPmjB7fLz5Ucnm+Qxo3WE085pwbceJ
   /JJLF92lHe586CgImKaCp8sLWZ9Q/+7oDbebvlK0AZD2KPmrcHm6/tT/X
   tm0t8dz4jXq+rLLnriaPQGMA7d2KIIHOMFcmYgZXlvly2KpCmVRIrHY97
   1q0pO0tpGrDj9P8ohV/NGyu9sydz5IrFDbl5+7b+DWIPS4AzuUGy46Y2g
   bR6QqLxPNhiG0N8ceJRROQuh01gMFCgYjjrW3DeWUppH/WNHPfqIsR1UP
   RIptUWpA7KhrAsCtVGvbkKYdE8IFTXogdDumPlMyOGthkFOtG0ghHk809
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="331175023"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="331175023"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 08:26:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="769842890"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="769842890"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 12 May 2023 08:26:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 12 May 2023 08:26:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 12 May 2023 08:26:48 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 12 May 2023 08:26:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXJbVf2+b6aKByZn2sGJ+LwAAoQ65AkrErzcvvl55zVy4iaXK6zp9KW323K5++kxDZuMerk+U5l/j2EsTIRlYl8EWNfBRATxu9QZDIR9wkOz4RFpUeNO5jx14QSgRzNL4dZG1UrZIZj1PjmETSduuXn2YYx3nD+k1ECVmpvse530nWxZt9VUEWmtVMQV71O5ObNOjMUxVZPPUyCMR3JN6VbkKZPBTLOtdQFz0hoRBrZrUXQzBQw3Fpon7ls+mNtYqjgdGzGq1BryWvN0SI4aAr40Rbxv834GZe5LUSR2LF71y5VrgwM+48W8hAwsFnTStmyeLlsjjOceqjoNi9cJcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ho54jcgz5tAYHTcAOMhmEE/8O4hwmU0TwG8xqIbVAT8=;
 b=C+BGLa1m/druqHbF88priG+2DFt/DiQvghQRBxIMaGmEuh4Hom1Rxac1c1+vAr2hjQALFqCk3925WttRJDIcHo69Q956JEs4aN1E/lHn4g426TUJfjAF1EMpQTRN+bAI/RiAYO8s2Q5HJ88WvC7AnH1JxpOYq6M9DyPlSke1dV3tfn2bpZXIgauGAhKa8Ww0Y2JU98kJmZBzp6m0j/I7oCOm8rmEWLLJFeZTU2CMpSQhrWOFvf2E1OV1z5Lkt4JJzNejH6UMR3QA79NN1Ng3s68onKtvCO07Ii8Wk5s5hrnxL3WeY63grwhqMfk/xstGpb8gzlsOqkXg2jmTVydvCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH8PR11MB8106.namprd11.prod.outlook.com (2603:10b6:510:255::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22; Fri, 12 May
 2023 15:26:46 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 15:26:46 +0000
Message-ID: <31993ea8-97e5-b8d5-b344-48db212bc9cf@intel.com>
Date:   Fri, 12 May 2023 08:26:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
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
 <CALPaoCg76nUsJ7eYcU61gied8WBuAAmqy0Pqpsq5=Z-S52Qg6w@mail.gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCg76nUsJ7eYcU61gied8WBuAAmqy0Pqpsq5=Z-S52Qg6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0014.namprd21.prod.outlook.com
 (2603:10b6:a03:114::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH8PR11MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: 926f8cf2-c6ec-4634-f80b-08db52fd4c3e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sNVkjaQFEc4eQWHKF3PX73XugzRWqTLE7bXCdkLiz1I0rgBxCDgBJh/MBNmnwLk035o2TgO6ln1s3Be7f/s+EDTc1o2XNOkzjI9dY5YasTb79EQTpnICqbPjPwYkRUXIV03LViyWTHNj7JivvD39A3Szn2c67EwnpS7CBM2oWJaKlFQJ4gazQsRGpijY4WgSePDAXoXxclCOcjybo4v2RQpV9DdFaiJkInzOAz0jKvyr7yl1NFbOGx6cqFMkf/AUCfU7ft7hNUd87zTSFw9DIfMirBXzY63o+POWT/9w5vwKq8SYSfjGgnPRnm89quyniGsbdUTZxKgvTqN+lYiNmKDx61Fg+zy2PrPOVt0QUye6cCPFmJ5tGX3pAMAfm/ZF0Yzc2maAy1Ca+1qraT31V/928xiPME3hYtktloipFMSHYE8QOmG1HtJWMcfOq2oQnBrL/jpvbWy3eaABYG4QIFKScciqnFVX5qaIesidCHOVLoqp9eqWtPOgJMigpL27iJRxD9TTgMJ1EIifnFgO5gAwR9RQCA33IzOntmz98Eb8yc7epnt4LoMINWgYnaTMAjqI7/CFPdHsSGCb4dvVJkyHJ4x61IuehozPzw4Z/+efSJGgpbbsx9QBbtz9fPishP+1q/uJxVgFixG9xHegHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(39860400002)(346002)(396003)(451199021)(31686004)(66556008)(6916009)(6486002)(4326008)(66946007)(66476007)(478600001)(316002)(54906003)(86362001)(31696002)(36756003)(6506007)(83380400001)(26005)(186003)(53546011)(6512007)(2616005)(8936002)(41300700001)(44832011)(5660300002)(7416002)(2906002)(8676002)(82960400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0c0WVg3S2pvbTRnRFJkWEY3U0tjeHhQaUhtemI4Q3RXVm9nRkRkWW1IL1Iw?=
 =?utf-8?B?dkZwekJvVmluclIrQnBDRkp3bW9LSitpSEhFSzZzck5oaUNuTWNCZG1qV0w1?=
 =?utf-8?B?MGxHTjI0UnBtQm1sV3R3RndlbE9Dc2Y2VkpWZXBhL3dBYVI4VHUxTGZKUEdT?=
 =?utf-8?B?RHlQbUt3UWQrQlJEZWdLTEFDTHNwQVJlUnNrY3VCQldYRzArZVpoUWJtcTNR?=
 =?utf-8?B?OFFOTmx6dlRoVTNSaDZBajgvRktuRnFiamx2N2daQ3VTUEdRSFJTdXI5VE54?=
 =?utf-8?B?NlgyNk04eU9oUkcrclJzdkJJM2RQZURBaERhemxJM1h0VHhKUlJNYm5uS3Bz?=
 =?utf-8?B?N1hicHIwZWxseW1vcUlEMG5iZndPNTkzeFRwOUhyeVpYa2hsclJINDN1OG5J?=
 =?utf-8?B?ZlFjVEdDcUFTTFNhbGtPZGlib3ZEMjVWOWVnYXlnazI5MTR5OW9MeTBwbmtv?=
 =?utf-8?B?K2UvV1l0aUhQRWt4ZCtzWUFGNzd1L21ha2VXQkpTTUEvd0NhOXE4NXNWM0Mr?=
 =?utf-8?B?UjF5U3cwbGZrWExKR2xKZXBER3grZ2MxaXlVOE5Hc2k3WGJrNGJvTlEwemwr?=
 =?utf-8?B?SXBJeTRTWE5uSzFBMmx0WUpRYjBPeXY3eGk2MTdjSmllM0Ztc2xvbTVlQUgy?=
 =?utf-8?B?ZXlnSXZ2eC9MbFB6anA5cktCdHNGdnl2VEQ1bjBOQldKRHBXUjhCazZoYjNx?=
 =?utf-8?B?TE5mbGN0bDhUV0s0VSthcHNNdlk1MElPU1dPVHduc3pSUmVrSS9KWW5yejMx?=
 =?utf-8?B?SFFmL3ZLTzBPZUFtSnpIeFVzL1ltajhVS092cGY5aUIrMEZUQ2ppK0U3RmdC?=
 =?utf-8?B?UXhWaXVZcTRTdERlekNuUEN0RFFnN240cGRQVkxHU0g5MmFsaDU2azhmS2M0?=
 =?utf-8?B?MEc1YjJuTTZFYjk1ZkFmMS9EWmJ5RVgrSW5LWDNxZnJUY0RyK2ZSOVNGVlhy?=
 =?utf-8?B?azZrY0oyb0NNczczTVJVci85K1hMQ21PSXRJMFRpTVJTT2hhM0NnT0gwU2VT?=
 =?utf-8?B?SHEweVZ6SHdzZnNSTmFCWTk2dTU5NForT1hhQUlIVnJZbVRtcWhGQ29SR2hk?=
 =?utf-8?B?ZGVxUUkyR2NHT3JMYWJLZUlYek5WTk9aZ0FuREVYQStpaXJoRmNnelRLSGVp?=
 =?utf-8?B?Snp4cVozRXRnTlpaMDErbU5xUkZLcFlLUzJLZmdLWDkxTm1GeFhqY0hkOXgr?=
 =?utf-8?B?cXhxdUpBTFg2eFkwZkZ5V0JuUVFULzFqZ01tQ0NBdGVzSTN2RTJ1M0F0L3hx?=
 =?utf-8?B?WE0rNTZSL3pYK2gwNEZuOUtOck5pTTJoMXpBYVRneXlsWVhsVWNqdkNaU2F1?=
 =?utf-8?B?UUdwRVo2MldEL0NZbGpBSFBiN2JmcGxETEtVb2ZyNW9VTUg2dWVHZTZPRXZ3?=
 =?utf-8?B?UHlZVFlYRUFJRUZyYTVWVUZ5ZEgzbGZUZW1JR2orT3czYzBqblRNRElNaVMz?=
 =?utf-8?B?UHFIQ2xWamJpNDVWQnZBdHlFeU83T0VmdTFrTTVtMHNwbWlhYTZQczMybUlG?=
 =?utf-8?B?RWtTbGo1YnErQWtDY20xd3lYVXd6bnJHSWU2U2ZRZ0V0dEhzdGxoWkxZeWFZ?=
 =?utf-8?B?aUhEaW9Pa2F2aUlXVzR5MkNEUGh1dTNMdzBCSzBPdjE4bUgvcUpoTytWak5S?=
 =?utf-8?B?NHVmTUpKemJFeitnVHpqS0FJTXhrckV3RWFXYUZ4a3h6ZnNyTHVNRjZORERO?=
 =?utf-8?B?M3BDckxTZDV4dW9GRkpkbjUvY0MxaUhZSEFXZjArTGc4azJEK0w5VEVNamtI?=
 =?utf-8?B?S2M3Qm0wQ2dlejdlSEZvRXQ4MkxHQXBvTTdmamxaMngvK3FhYmVQeHB3WWE0?=
 =?utf-8?B?NThmY2RqbTM0K1o5NUJrcHlUallybFlpdHQzWTVpQ0IxK3JZS3dRMkwwelBE?=
 =?utf-8?B?Rkg0R0hGU3p3dHRvbjFSNit5L083YmppbTZrUDNrckhSYkhDeTZNOGtlN1Z4?=
 =?utf-8?B?NlVlbGwxQTV3cXJjNCtMTW9abTdxNDFqd2hheC93MUJYZko4SXoxbHVqNXlh?=
 =?utf-8?B?TlZvUWVaRjErVUV4UHhHSldpWFh0UHpoMjJwdk9odU8xMmpIWGRTSW1USFho?=
 =?utf-8?B?c3RsZElNeDNUZmsrU014a0N3UzJhbndzelhCS1hnTXdoYVFhVzhhNUs5YWhT?=
 =?utf-8?B?NTY3aUxGY2hQMEROcTZ2RzYxRmFOY2ttRUN4aEs4Z3QrWk9MRTJIS24wMmpi?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 926f8cf2-c6ec-4634-f80b-08db52fd4c3e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 15:26:46.3754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ny4s755J5JDuxHQUVQIWA1EN/Y7muD5JEjQaRiEODNsukjRTozxKftH0cPJ6uPE8+fE3NRYnb9uS+bLs3KCcxIDTOIiXtQPmj9VIz7IqiKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8106
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Peter,

On 5/12/2023 6:25 AM, Peter Newman wrote:
> Hi Reinette,
> 
> On Thu, May 11, 2023 at 11:37 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>> On 4/21/2023 7:17 AM, Peter Newman wrote:
>>> Implement resctrl_mbm_flush_cpu(), which collects a domain's current MBM
>>> event counts into its current software RMID. The delta for each CPU is
>>> determined by tracking the previous event counts in per-CPU data.  The
>>> software byte counts reside in the arch-independent mbm_state
>>> structures.
>>
>> Could you elaborate why the arch-independent mbm_state was chosen?
> 
> It largely had to do with how many soft RMIDs to implement. For our
> own needs, we were mainly concerned with getting back to the number of
> monitoring groups the hardware claimed to support, so there wasn't
> much internal motivation to support an unbounded number of soft RMIDs.

Apologies for not being explicit, I was actually curious why the
arch-independent mbm_state, as opposed to the arch-dependent state, was
chosen.

I think the lines are getting a bit blurry here with the software RMID
feature added as a resctrl filesystem feature (and thus non architectural),
but it is specific to AMD architecture. 

> However, breaking this artificial connection between supported HW and
> SW RMIDs to support arbitrarily-many monitoring groups could make the
> implementation conceptually cleaner. If you agree,  I would be happy
> to give it a try in the next series.

I have not actually considered this. At first glance I think this would
add more tentacles into the core where currently the number of RMIDs
supported are queried from the device and supporting an arbitrary number
would impact that. At this time the RMID state is also pre-allocated
and thus not possible to support an "arbitrarily-many".

>>> +/*
>>> + * Called from context switch code __resctrl_sched_in() when the current soft
>>> + * RMID is changing or before reporting event counts to user space.
>>> + */
>>> +void resctrl_mbm_flush_cpu(void)
>>> +{
>>> +     struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>>> +     int cpu = smp_processor_id();
>>> +     struct rdt_domain *d;
>>> +
>>> +     d = get_domain_from_cpu(cpu, r);
>>> +     if (!d)
>>> +             return;
>>> +
>>> +     if (is_mbm_local_enabled())
>>> +             __mbm_flush(QOS_L3_MBM_LOCAL_EVENT_ID, r, d);
>>> +     if (is_mbm_total_enabled())
>>> +             __mbm_flush(QOS_L3_MBM_TOTAL_EVENT_ID, r, d);
>>> +}
>>
>> This (potentially) adds two MSR writes and two MSR reads to what could possibly
>> be quite slow MSRs if it was not designed to be used in context switch. Do you
>> perhaps have data on how long these MSR reads/writes take on these systems to get
>> an idea about the impact on context switch? I think this data should feature
>> prominently in the changelog.
> 
> I can probably use ftrace to determine the cost of an __rmid_read()
> call on a few implementations.

On a lower level I think it may be interesting to measure more closely
just how long a wrmsr and rdmsr take on these registers. It may be interesting
if you, for example, use rdtsc_ordered() before and after these calls, and then
compare it to how long it takes to write the PQR register that has been
designed to be used in context switch.

> To understand the overall impact to context switch, I can put together
> a scenario where I can control whether the context switches being
> measured result in change of soft RMID to prevent the data from being
> diluted by non-flushing switches.

This sounds great. Thank you very much.

Reinette

