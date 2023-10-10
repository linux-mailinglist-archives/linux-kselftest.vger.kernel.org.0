Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E907BF8C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 12:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjJJKgq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 06:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjJJKgp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 06:36:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEEE9E;
        Tue, 10 Oct 2023 03:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QdI+5V9yIlogu8K/04Iaa4H4soULWRigcAOJTct/Jvg=; b=a/WUK/uYdbRSB/Jd3vZe1hGzLA
        YtKU5OIsXLVDC3Ezpa6ps2+kLB8luNqYltTTOQK88USWpn2EMs+5KpJ9NagT0DPg3Dki4l5vKGzlI
        lwWMMsJqsB/sz8/z9FE318NBJH4nyxuTp5kgDmU3TB7d6seNbiX6psiuH8Zekn+TzvQnHsohMO5QU
        pE95DCWH8SPOm1j6m2Lc5/MDT5AKUoPZwQZhG6Pz9k9N/Vm7H+mMQ0Y6uOoX654bmWr8CDqNl0oCz
        B4FqC8jcWWEeajWcgE5XN4w5hRe/Yh4O4PFYMpn1dGlojlAUGf2kEBMLIaqFCn6MjgXav05DeTCqm
        G40cfMOg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qqA6G-00GmnI-0G;
        Tue, 10 Oct 2023 10:36:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 35B69300392; Tue, 10 Oct 2023 12:36:29 +0200 (CEST)
Date:   Tue, 10 Oct 2023 12:36:29 +0200
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
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH V8 3/7] cpufreq: amd-pstate: Enable amd-pstate preferred
 core supporting.
Message-ID: <20231010103629.GI377@noisy.programming.kicks-ass.net>
References: <20231009024932.2563622-1-li.meng@amd.com>
 <20231009024932.2563622-4-li.meng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009024932.2563622-4-li.meng@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 09, 2023 at 10:49:28AM +0800, Meng Li wrote:

> +static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
> +{
> +	int ret;
> +	u32 highest_perf;
> +	static u32 max_highest_perf = 0, min_highest_perf = U32_MAX;
> +
> +	ret = amd_pstate_get_highest_perf(cpudata->cpu, &highest_perf);
> +	if (ret)
> +		return;
> +
> +	cpudata->hw_prefcore = true;
> +	/* check if CPPC preferred core feature is enabled*/
> +	if (highest_perf == AMD_PSTATE_MAX_CPPC_PERF) {
> +		pr_debug("AMD CPPC preferred core is unsupported!\n");
> +		cpudata->hw_prefcore = false;
> +		return;
> +	}
> +
> +	if (!amd_pstate_prefcore)
> +		return;
> +
> +	/*
> +	 * The priorities can be set regardless of whether or not
> +	 * sched_set_itmt_support(true) has been called and it is valid to
> +	 * update them at any time after it has been called.
> +	 */
> +	sched_set_itmt_core_prio(highest_perf, cpudata->cpu);

You still got the whole u32 vs int thing confused, I've only pointed
that out *TWICE* before.

Boris, can you pull out the clue hammer please?

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
> +}
