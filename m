Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A83D7987B2
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 15:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbjIHNTo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 09:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjIHNTn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 09:19:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D421D19B5;
        Fri,  8 Sep 2023 06:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=byTGpZunXOY72bf+Yy8GIShaEnFa/OpSgKmuUVjqnmY=; b=AQvtYt+4V1wAPVojSoKVC8VN+y
        36uhQcVVz5smyjYMiZ5NigdM/nkLwL6Wl0kEizgybkW2MrZLsQlJvoHn5zH5S72pwKgAc97OmXrUC
        tMVnaHZ86dnAJ00YxIEwBMpBZ0KVSaE+3Ryv2DoNB/9Pb29it7NN5JoIsWjlPQVPetmRm5F583tZU
        CP/6IXuKdu+4QKxfdxAJTkWVTTj2WkD6rfpiIN6XejGoGjcuVe32uepWTpg717Vpl0VoZxkVx5ebs
        iXtpRuEh568t3mQZI4rWPGSxxQL1/qeg/o2iQF5H2phK/Iis3RvdUl+WU27FUEAqhIgcMAY1aDVMG
        MynsH61g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qebOK-000JqN-A1; Fri, 08 Sep 2023 13:19:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id EFF70300472; Fri,  8 Sep 2023 15:19:19 +0200 (CEST)
Date:   Fri, 8 Sep 2023 15:19:19 +0200
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
Subject: Re: [PATCH V5 4/7] cpufreq: Add a notification message that the
 highest perf has changed
Message-ID: <20230908131919.GG19320@noisy.programming.kicks-ass.net>
References: <20230905015116.2268926-1-li.meng@amd.com>
 <20230905015116.2268926-5-li.meng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905015116.2268926-5-li.meng@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 05, 2023 at 09:51:13AM +0800, Meng Li wrote:
> ACPI 6.5 section 8.4.6.1.1.1 specifies that Notify event 0x85 can be
> emmitted to cause the the OSPM to re-evaluate the highest performance
> register. Add support for this event.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> Link: https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html?highlight=cppc#cpc-continuous-performance-control

Does uefi.org guarantee this is a stable link?
