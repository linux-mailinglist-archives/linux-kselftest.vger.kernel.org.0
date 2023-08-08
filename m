Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5654C7741E8
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 19:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbjHHRa1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 13:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbjHHR3x (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 13:29:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB67421786;
        Tue,  8 Aug 2023 09:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1E5Xb4mTlI5my7Fl2wybf8Wnwo2X+ZiGlfBansiZhhQ=; b=ZAtwYPsfE60mHVpJIFk/gIvr7O
        6vk8MaE6gPTwSXVl1PAaO4fggnI4YkMO2nNDjnLcdbbAXPRxrfM3+ib2XVBnWsAwFMgNSNtmxKA9N
        eC0WGKACsplVzoflNfcZ7dDrBun0Os47F4uZm3Yjuya8MEQ5bTbqFu192EO5wrOdw3swWmx+isshi
        N4dwURI0WMArg/qvkPlZBZyvQINv99TKUjplBNA24zvJQ6ZxEggsS1yhOEHcRN2Kg2VBgo68tCd3S
        Z1XPDBkjxhHIVYvSdpLD+0TcLFi7Np3pQwLRc1yzkzPAAaCp2SqoYhJZk04uZeHz1YCXkGjgPUqc+
        Vtp85m6A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qTIfr-00GZEv-1b; Tue, 08 Aug 2023 09:06:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DF7C730003A;
        Tue,  8 Aug 2023 11:06:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C73062028B118; Tue,  8 Aug 2023 11:06:41 +0200 (CEST)
Date:   Tue, 8 Aug 2023 11:06:41 +0200
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
Subject: Re: [PATCH V1 2/6] cpufreq: amd-pstate: Enable AMD Pstate Preferred
 Core Supporting.
Message-ID: <20230808090641.GV212435@hirez.programming.kicks-ass.net>
References: <20230808081001.2215240-1-li.meng@amd.com>
 <20230808081001.2215240-3-li.meng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808081001.2215240-3-li.meng@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 08, 2023 at 04:09:57PM +0800, Meng Li wrote:

> +static int amd_pstate_get_highest_perf(int cpu, u64 *highest_perf)
> +{
> +       int ret;
> +
> +       if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +               u64 cap1;
> +
> +               ret = rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap1);
> +               if (ret)
> +                       return ret;
> +               WRITE_ONCE(*highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));
> +       } else {
> +               ret = cppc_get_highest_perf(cpu, highest_perf);
> +       }
> +
> +       return (ret);
> +}
> +
> +static void amd_pstate_init_prefcore(void)
> +{
> +	int cpu, ret;
> +	u64 highest_perf;
> +
> +	if (no_prefcore)
> +		return;
> +
> +	for_each_possible_cpu(cpu) {
> +		ret = amd_pstate_get_highest_perf(cpu, &highest_perf);
> +		if (ret)
> +			break;

So what is the intended behaviour when online != possible ?

> +		sched_set_itmt_core_prio(highest_perf, cpu);
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
