Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62C07C897A
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 18:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjJMQB6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 12:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjJMQB5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 12:01:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0BEB7;
        Fri, 13 Oct 2023 09:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R1BXEjw/tdVpUH9FfenMcwOFEve9DMEy/SsDnd6XIV8=; b=g+CaL7TNnTOSCiZ8cFDSFAoPWe
        P4/WPfJckr/usSf+r9yzJT1lS4xprCch7vI7na4OF1+wDRkfh9hV43y2+MQiSygejZqJwwLCqj1Ko
        qdjwNr1NdfCOq++uUQvWWjkdxyDIN2/vMLnhH0SHt02IFOd2WuyAO1QQc9+x234lQ6jV3F5/JCZQS
        YRjSra9iyBZBfy8wKY8BOyV/JRR+lnVLZqM3ER4TDgEWKECQ2ma5a6nihfEv+5NGDfApEEaMQYiU4
        yMijICBewF3eqYM94tkOI9/4sIRvmpdn9FGPS8t0dkSCwDip2AtFHHz0Oq8mgXmnqTes/JxSoko9h
        O/UVkEJA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qrKbP-002rBl-2p;
        Fri, 13 Oct 2023 16:01:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 030C83002E1; Fri, 13 Oct 2023 18:01:29 +0200 (CEST)
Date:   Fri, 13 Oct 2023 18:01:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Meng Li <li.meng@amd.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-acpi@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Wyes Karny <wyes.karny@amd.com>
Subject: Re: [RESEND PATCH V9 3/7] cpufreq: amd-pstate: Enable amd-pstate
 preferred core supporting.
Message-ID: <20231013160128.GB36211@noisy.programming.kicks-ass.net>
References: <20231013033118.3759311-1-li.meng@amd.com>
 <20231013033118.3759311-4-li.meng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013033118.3759311-4-li.meng@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 13, 2023 at 11:31:14AM +0800, Meng Li wrote:

> +#define AMD_PSTATE_PREFCORE_THRESHOLD	166
> +#define AMD_PSTATE_MAX_CPPC_PERF	255

> +static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
> +{
> +	int ret, prio;
> +	u32 highest_perf;
> +	static u32 max_highest_perf = 0, min_highest_perf = U32_MAX;

What serializes these things?

Also, *why* are you using u32 here, what's wrong with something like:

	int max_hp = INT_MIN, min_hp = INT_MAX;

> +
> +	ret = amd_pstate_get_highest_perf(cpudata->cpu, &highest_perf);
> +	if (ret)
> +		return;
> +
> +	cpudata->hw_prefcore = true;
> +	/* check if CPPC preferred core feature is enabled*/
> +	if (highest_perf == AMD_PSTATE_MAX_CPPC_PERF) {

Which effectively means <255 (also, seems to suggest MAX_CPPC_PERF might
not be the best name, hmm?)

Should you not write '>= 255' then? Just in case something 'funny'
happens?

> +		pr_debug("AMD CPPC preferred core is unsupported!\n");
> +		cpudata->hw_prefcore = false;
> +		return;
> +	}
> +
> +	if (!amd_pstate_prefcore)
> +		return;
> +
> +	/* The maximum value of highest perf is 255 */
> +	prio = (int)(highest_perf & 0xff);

If for some weird reason you get 0x1ff or whatever above (dodgy BIOS
never happens, right) then this makes sense how?

Perhaps stop sending patches at break-nek speed and think for a little
while on how to write this and not be confused?


> +	/*
> +	 * The priorities can be set regardless of whether or not
> +	 * sched_set_itmt_support(true) has been called and it is valid to
> +	 * update them at any time after it has been called.
> +	 */
> +	sched_set_itmt_core_prio(prio, cpudata->cpu);
> +
> +	if (max_highest_perf <= min_highest_perf) {
> +		if (highest_perf > max_highest_perf)
> +			max_highest_perf = highest_perf;
> +
> +		if (highest_perf < min_highest_perf)
> +			min_highest_perf = highest_perf;
> +
> +		if (max_highest_perf > min_highest_perf) {
> +			/*
> +			 * This code can be run during CPU online under the
> +			 * CPU hotplug locks, so sched_set_itmt_support()
> +			 * cannot be called from here.  Queue up a work item
> +			 * to invoke it.
> +			 */
> +			schedule_work(&sched_prefcore_work);
> +		}
> +	}

Not a word about what serializes these variables.

> +}
