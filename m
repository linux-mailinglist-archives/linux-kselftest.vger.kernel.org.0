Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C1C7CB5C7
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 23:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbjJPVzu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 17:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjJPVzt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 17:55:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC248A1;
        Mon, 16 Oct 2023 14:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5tkJ2bgsDt87q0DstoWjpZMRRfhwElRsndfgSDa9gto=; b=o8l1EIS9wF0DSvO7/lfeP5B37V
        2AWM2VflsyAMUBYhrSPTzyGG9HyA41o1eXWfsXoDsN7NHlrc6J71nqGFHQ8wehp1r5g9UZcMnAi1s
        sHCywxWN2ize1mTom6zOpMwC29C5HtySnp4/u4mf83V5aVEdb8Gi0C9l6gLTu5EmdIGMvqOdtahJf
        d2jSHUve/q3MpzLRILd5aXqaRhCrkQc4pUb8c8dWtWmyuHiQw8BNo4FxLCA8ofsbTqb4Wgo2Q0Fc+
        jQDRRHy5TkhhdWOMUz2Tzn1/a7yMb2rMdvoTFOOmlgmli+27CBQwfODl/b6B3WXI7OowUApHwrsFU
        hb85lJjw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qsVYW-006KoG-1c;
        Mon, 16 Oct 2023 21:55:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 815DE300513; Mon, 16 Oct 2023 23:55:21 +0200 (CEST)
Date:   Mon, 16 Oct 2023 23:55:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
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
Subject: Re: [RESEND PATCH V9 3/7] cpufreq: amd-pstate: Enable amd-pstate
 preferred core supporting.
Message-ID: <20231016215521.GD36211@noisy.programming.kicks-ass.net>
References: <20231013033118.3759311-1-li.meng@amd.com>
 <20231013033118.3759311-4-li.meng@amd.com>
 <20231013160128.GB36211@noisy.programming.kicks-ass.net>
 <DM4PR12MB6351E2E9504B57BD40DAE985F7D7A@DM4PR12MB6351.namprd12.prod.outlook.com>
 <20231016105845.GA33217@noisy.programming.kicks-ass.net>
 <e82fc689-5cc3-d799-6e5f-a9e4ac98e26f@intel.com>
 <eeb77ec34d2002e507c09949aac9110d8b8eff4a.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeb77ec34d2002e507c09949aac9110d8b8eff4a.camel@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 16, 2023 at 11:50:34AM -0700, srinivas pandruvada wrote:

I'll respond to the rest tomorrow, it's far too late.

> > > Also, same question as to the amd folks; what serializes those
> > > static
> > > variables?
> > 
> > That's a good one.
> 
> This function which is checking static variables is called from cpufreq
> ->init callback. Which in turn is called from a function which is
> passed as startup() function pointer to
> cpuhp_setup_state_nocalls_cpuslocked().
> 
> I see that startup() callbacks are called under a mutex
> cpuhp_state_mutex for each present CPUs. So if some tear down happen,
> that is also protected by the same mutex. The assumption is here is
> that cpuhp_invoke_callback() in hotplug state machine is not called in
> parallel on two CPUs by the hotplug state machine. But I see activity
> on parallel bringup, so this is questionable now.

Parallel bringup should still serialise this. It mostly only does the
hardware bringup in parallel.

Having a pointer back to the cpu hotplug lock would make it easier to
untangle this code though.
