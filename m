Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CC0799A49
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Sep 2023 19:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjIIRk7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 9 Sep 2023 13:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237402AbjIIRk5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 9 Sep 2023 13:40:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D73188;
        Sat,  9 Sep 2023 10:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7Y6bR9Kn2+pZ6DuqXBHPpEEuVHpFr7kKzyX99O1ems0=; b=JQFbjSfH+strhTcGUoh29NcXzq
        zRIRp62BFWCSrFJnC7Xp9EK4i0T3pHW68XOCaXrkuQHg9cs4O7paEsDFFfCUj2qtaX7kO6Q2NBZ6x
        GPzR8uSkTt80duohNCwTYPxlHXO291hct6udYg4nQ8pDUgYuaQVIRE+GCmHbW+8UOs3hm745rNiK7
        xxSI52L2j0zUtLuWgockDH1nWWkR7AUokBs9cay9i1hTVHNsofp6KQL9fnlPWj4XesGN03dm0R5fD
        G5JQgDK6u9L5j/LM2I3Q/dPkDqlImGlnmPj51SHzQ5E8Z+sFRtYgWXWn/vWXkbBNMuFShukR8kgB7
        SbhVla7w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qf1wR-003R46-2k;
        Sat, 09 Sep 2023 17:40:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id EE4ED300348; Sat,  9 Sep 2023 19:40:20 +0200 (CEST)
Date:   Sat, 9 Sep 2023 19:40:20 +0200
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
Subject: Re: [PATCH V6 5/7] cpufreq: amd-pstate: Update amd-pstate preferred
 core ranking dynamically
Message-ID: <20230909174020.GB33532@noisy.programming.kicks-ass.net>
References: <20230908074653.2799055-1-li.meng@amd.com>
 <20230908074653.2799055-6-li.meng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908074653.2799055-6-li.meng@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 08, 2023 at 03:46:51PM +0800, Meng Li wrote:
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
> +	prev_high = READ_ONCE(cpudata->prefcore_ranking);
> +
> +	if (prev_high != cur_high) {
> +		WRITE_ONCE(cpudata->prefcore_ranking, cur_high);
> +		sched_set_itmt_core_prio(cur_high, cpu);
> +	}
> +
> +	cpufreq_cpu_put(policy);
> +}

Idem -- I told to clarify the u32 vs int thing, nothing here.
