Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D40799A45
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Sep 2023 19:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbjIIRkZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 9 Sep 2023 13:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjIIRkY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 9 Sep 2023 13:40:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F18D135;
        Sat,  9 Sep 2023 10:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1IJhOTrmx3z5yA8bOgTa5/cW12NcN6iy4SPd+R4a+r4=; b=vURBibPB3+O7RzHSUyFGqZUPld
        kQ11c4WSHJ6Nk3CVm1eeocSCChWN1AD+XnkVPzTbvuPkwpLCLGzugd1KgLUtRPpfBu1kwJf24MNnj
        oD9g7STSMPP1PMo9kcSX6igrw+kTPtKYOgivZNvP00GDj67a65m3eQjRfVIdpkwmeTizt3SjT/ilv
        bCVEKKf82uYpCPkx6PUA/l1IkI15FD1XGolFqU0uSJCdpp1HlELb+KkyhkciU7RpmfsE2AGfxnaoo
        nR41yblNuNvEbdbwG9Q+CpPJ3JC9hRAL8SVjZi2HHNqBs6bytOG/xI9qpgdyCnvXjcXQcZ0Tm5sKl
        E+/p6c/Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qf1vy-007ROQ-QX; Sat, 09 Sep 2023 17:39:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5FADF300348; Sat,  9 Sep 2023 19:39:50 +0200 (CEST)
Date:   Sat, 9 Sep 2023 19:39:50 +0200
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
Subject: Re: [PATCH V6 3/7] cpufreq: amd-pstate: Enable amd-pstate preferred
 core supporting.
Message-ID: <20230909173950.GA33532@noisy.programming.kicks-ass.net>
References: <20230908074653.2799055-1-li.meng@amd.com>
 <20230908074653.2799055-4-li.meng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908074653.2799055-4-li.meng@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 08, 2023 at 03:46:49PM +0800, Meng Li wrote:
> +static void amd_pstate_init_prefcore(void)
> +{
> +	int cpu, ret;
> +	u64 highest_perf;
> +
> +	if (!prefcore)
> +		return;
> +
> +	for_each_online_cpu(cpu) {
> +		ret = amd_pstate_get_highest_perf(cpu, &highest_perf);
> +		if (ret)
> +			break;
> +
> +		sched_set_itmt_core_prio(highest_perf, cpu);
> +
> +		/* check if CPPC preferred core feature is enabled*/
> +		if (highest_perf == AMD_PSTATE_MAX_CPPC_PERF) {
> +			pr_debug("AMD CPPC preferred core is unsupported!\n");
> +			hw_prefcore = false;
> +			prefcore = false;
> +			return;
> +		}
> +	}
> +
> +	/*
> +	 * This code can be run during CPU online under the
> +	 * CPU hotplug locks, so sched_set_amd_prefcore_support()
> +	 * cannot be called from here.  Queue up a work item
> +	 * to invoke it.
> +	 */
> +	schedule_work(&sched_prefcore_work);
> +}

Brilliant, repost without addressing prior feedback..  :-(
