Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07877987CB
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 15:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243092AbjIHN2K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 09:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237098AbjIHN2K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 09:28:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533961BC1;
        Fri,  8 Sep 2023 06:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W1fQmd2i7SQqLAd276rgzi7GGa4RVcJpa4V7l02RNVI=; b=tQe7K36GRGfPLmchqqNQJVBIMV
        oLnjsUaWRZukaTJ0Ef7Rlx/s/gyhxFj+6yPgagu4pxdRgvOo024qQqQw8JVJGvAoCcy+JS0N4EmVg
        2QaQG7E7udo4USlvt5LDb8NwpCe9uy3+ebIUXC5BMaMOLzNgwZYpZNUtW5LDLeikmRsziTy7UjIUr
        j/63EUg1idyQCtuBFci0GIEaamHcv5PAB1en+DxicS8ISJM9yQM4+Ecxahj7jbqaboGvmrOndk2Lr
        Q3oeTxpxUPc3FwjzxxgjZ3DHUJm97UkasiJ45Ww+wsiGBe1iay86/gdzRtxBoTzfAIfUmVG7K/jzV
        OJvtzW/A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qebWd-000MNs-Es; Fri, 08 Sep 2023 13:27:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1E982300472; Fri,  8 Sep 2023 15:27:55 +0200 (CEST)
Date:   Fri, 8 Sep 2023 15:27:54 +0200
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
        Borislav Petkov <bp@alien8.de>, Wyes Karny <wyes.karny@amd.com>
Subject: Re: [PATCH V5 5/7] cpufreq: amd-pstate: Update amd-pstate preferred
 core ranking dynamically
Message-ID: <20230908132754.GI19320@noisy.programming.kicks-ass.net>
References: <20230905015116.2268926-1-li.meng@amd.com>
 <20230905015116.2268926-6-li.meng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905015116.2268926-6-li.meng@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 05, 2023 at 09:51:14AM +0800, Meng Li wrote:

> +static void amd_pstate_update_highest_perf(unsigned int cpu)
> +{
> +	struct cpufreq_policy *policy;
> +	struct amd_cpudata *cpudata;
> +	u32 prev_high = 0, cur_high = 0;
> +	u64 highest_perf;
> +	int ret;
> +
> +	if (!prefcore)
> +		return;
> +
> +	ret = amd_pstate_get_highest_perf(cpu, &highest_perf);
> +	if (ret)
> +		return;
> +
> +	policy = cpufreq_cpu_get(cpu);
> +	cpudata = policy->driver_data;
> +	cur_high = highest_perf;
> +	prev_high = READ_ONCE(cpudata->cppc_highest_perf);
> +
> +	if (prev_high != cur_high) {
> +		WRITE_ONCE(cpudata->cppc_highest_perf, cur_high);
> +		sched_set_itmt_core_prio(cur_high, cpu);

I just noticed, your cur_high is explicitly 'u32', but
sched_set_itmt_core_prio() and the rest of the scheduler use 'int' (aka
s32). If you somehow get that top bit set things might not work out as
expected.

Please double check.

> +	}
> +
> +	cpufreq_cpu_put(policy);
> +}
