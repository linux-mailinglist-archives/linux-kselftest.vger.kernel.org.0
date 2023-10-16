Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227677CB2FB
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 20:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjJPSuv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 14:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjJPSuu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 14:50:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E34D95;
        Mon, 16 Oct 2023 11:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697482249; x=1729018249;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Iulu54IDYUFpU+iC/guD05U9rT3+qcojMqimF0BvD7c=;
  b=jhD4+rZJQNVsfSUT8UJbDT9HLUwyecBBVj4HRHrMfkfg1XVUwMobtE7g
   BDbSxTsuduPB3ueu+4/gbXnRR7LiIlQBsM8Kk5DLQL/o+ZIiZ2UkNXJpH
   E0lmz2GC/CmNWjuizonjcZQzsofBdAzzlVIKTOmsRXUYjaskdYlywWfKM
   3a1uDfYzdcLPy3hDe4UrQahcYbCygR1spbZ9lOf6OgtTyyAubZUaJii4D
   Gs8E0g+WbUYpm4AdTxDkxyxm+rS/I98xApjEg3FgqxCiYmCtlFQjrVM3B
   42gcHaJxs4mJ9ejKau+ZO1M7qGULAUeyvN7/jI8evUwxRtu0hVsqDUH8P
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="7182384"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="7182384"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 11:50:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="826131454"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="826131454"
Received: from spandruv-desk1.amr.corp.intel.com ([10.209.124.179])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 11:50:34 -0700
Message-ID: <eeb77ec34d2002e507c09949aac9110d8b8eff4a.camel@linux.intel.com>
Subject: Re: [RESEND PATCH V9 3/7] cpufreq: amd-pstate: Enable amd-pstate
 preferred core supporting.
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>
Cc:     "Huang, Ray" <Ray.Huang@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        "Karny, Wyes" <Wyes.Karny@amd.com>
Date:   Mon, 16 Oct 2023 11:50:34 -0700
In-Reply-To: <e82fc689-5cc3-d799-6e5f-a9e4ac98e26f@intel.com>
References: <20231013033118.3759311-1-li.meng@amd.com>
         <20231013033118.3759311-4-li.meng@amd.com>
         <20231013160128.GB36211@noisy.programming.kicks-ass.net>
         <DM4PR12MB6351E2E9504B57BD40DAE985F7D7A@DM4PR12MB6351.namprd12.prod.outlook.com>
         <20231016105845.GA33217@noisy.programming.kicks-ass.net>
         <e82fc689-5cc3-d799-6e5f-a9e4ac98e26f@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 2023-10-16 at 19:27 +0200, Wysocki, Rafael J wrote:
> On 10/16/2023 12:58 PM, Peter Zijlstra wrote:
> > On Mon, Oct 16, 2023 at 06:20:53AM +0000, Meng, Li (Jassmine)
> > wrote:
> > > > > +static void amd_pstate_init_prefcore(struct amd_cpudata
> > > > > *cpudata) {
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret, prio;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 u32 highest_perf;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 static u32 max_highest_perf =3D 0, min_=
highest_perf =3D
> > > > > U32_MAX;
> > > > What serializes these things?
> > > >=20
> > > > Also, *why* are you using u32 here, what's wrong with something
> > > > like:
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int max_hp =3D INT=
_MIN, min_hp =3D INT_MAX;
> > > >=20
> > > [Meng, Li (Jassmine)]
> > > We use ITMT architecture to utilize preferred core features.
> > > Therefore, we need to try to be consistent with Intel's
> > > implementation
> > > as much as possible.=C2=A0 For details, please refer to the
> > > intel_pstate_set_itmt_prio function in file intel_pstate.c. (Line
> > > 355)
> > >=20
> > > I think using the data type of u32 is consistent with the data
> > > structures of cppc_perf_ctrls and amd_cpudata etc.
> > Rafael, should we fix intel_pstate too?
>=20
> Srinivas should be more familiar with this code than I am, so adding
> him.
>=20
If we make
	static u32 max_highest_perf =3D 0, min_highest_perf =3D U32_MAX;
to
	static int max_highest_perf =3D INT_MIN, min_highest_perf =3D
INT_MAX;

Then in intel_pstate we will compare signed vs unsigned comparison as
cppc_perf.highest_perf is u32.


In reality this will be fine to change to "int" as we will never reach
u32 max as performance on any Intel platform.

>=20
> > The point is, that sched_asym_prefer(), the final consumer of these
> > values uses int and thus an explicitly signed compare.
> >=20
> > Using u32 and U32_MAX anywhere near the setting the priority makes
> > absolutely no sense.
> >=20
> > If you were to have the high bit set, things do not behave as
> > expected.
>=20
> Right, but in practice these values are always between 0 and 255=20
> inclusive AFAICS.
>=20
> It would have been better to use u8 I suppose.
Should be fine as over clocked parts will set to max 0xff.

>=20
>=20
> > Also, same question as to the amd folks; what serializes those
> > static
> > variables?
>=20
> That's a good one.

This function which is checking static variables is called from cpufreq
->init callback. Which in turn is called from a function which is
passed as startup() function pointer to
cpuhp_setup_state_nocalls_cpuslocked().

I see that startup() callbacks are called under a mutex
cpuhp_state_mutex for each present CPUs. So if some tear down happen,
that is also protected by the same mutex. The assumption is here is
that cpuhp_invoke_callback() in hotplug state machine is not called in
parallel on two CPUs by the hotplug state machine. But I see activity
on parallel bringup, so this is questionable now.

Thanks,
Srinivas

>=20
>=20

